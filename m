Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 449FE3EABA3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Aug 2021 22:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237160AbhHLUWf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Aug 2021 16:22:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36948 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237252AbhHLUWc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Aug 2021 16:22:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628799726;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=NsaVDaCwK+MSCURVuNpjRNXWnZh7JWlR1iYxtP6UtJw=;
        b=b6ZSzNUON2pOwlaoAXRqisuuPPMWbOVmlatpjb8Py0e07Z+aWWLIOBM0vP8LAHDQnZy5nH
        UkqrQczwQKiEVarooo2T8Ol8F+Te67rOYhCjZTotVyblpJqyivCGEqpiB3MpqVUnhzGtkA
        uDfFL3Ex4t927qmnGnKokSpo3Yseo/4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-Txz6G_TxO_6MozlMIkrbcg-1; Thu, 12 Aug 2021 16:22:04 -0400
X-MC-Unique: Txz6G_TxO_6MozlMIkrbcg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 868C3760C0;
        Thu, 12 Aug 2021 20:22:01 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.22.32.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0ECA1620DE;
        Thu, 12 Aug 2021 20:21:57 +0000 (UTC)
Subject: [RFC PATCH v2 0/5] mm: Fix NFS swapfiles and use DIO for swapfiles
From:   David Howells <dhowells@redhat.com>
To:     willy@infradead.org
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Seth Jennings <sjenning@linux.vnet.ibm.com>,
        Bob Liu <bob.liu@oracle.com>, linux-nfs@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Dan Magenheimer <dan.magenheimer@oracle.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Trond Myklebust <trond.myklebust@primarydata.com>,
        Minchan Kim <minchan@kernel.org>, dhowells@redhat.com,
        dhowells@redhat.com, trond.myklebust@primarydata.com,
        darrick.wong@oracle.com, hch@lst.de, viro@zeniv.linux.org.uk,
        jlayton@kernel.org, sfrench@samba.org,
        torvalds@linux-foundation.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 12 Aug 2021 21:21:57 +0100
Message-ID: <162879971699.3306668.8977537647318498651.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Hi Willy, Trond,

Here's v2 of a change to make reads and writes from the swapfile use async
DIO, via the ->direct_IO() method, rather than readpage(), as requested by
Willy.

The consensus seems to be that this is probably the wrong approach and
->direct_IO() needs replacing with a swap-specific method - but that will
require a bunch of filesystems to be modified also.

Note that I'm refcounting the kiocb struct around the call to
->direct_IO().  This is required in cachefiles where I'm going in through
the ->read_iter/->write_iter methods as both core routines and filesystems
touch kiocb *after* calling the completion routine.  Should this practice
be disallowed?

I've also added an additional patch to try and remove the bio-submission
path entirely from swap_readpage/writepage code and only go down the
->direct_IO route, but this fails spectacularly (from I/O errors to ATA
failure messages on the test disk using a normal swapspace).  This was
suggested by Willy as the bio-submission code is a potential data corruptor
if it's asked to write out a compound page that crosses extent boundaries.

Whilst trying to make this work, I found that NFS's support for swapfiles
seems to have been non-functional since Aug 2019 (I think), so the first
patch fixes that.  Question is: do we actually *want* to keep this
functionality, given that it seems that no one's tested it with an upstream
kernel in the last couple of years?

My patches can be found here also:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=swap-dio

I tested this using the procedure and program outlined in the first patch.

I also encountered occasional instances of the following warning, so I'm
wondering if there's a scheduling problem somewhere:

BUG: workqueue lockup - pool cpus=0-3 flags=0x5 nice=0 stuck for 34s!
Showing busy workqueues and worker pools:
workqueue events: flags=0x0
  pwq 6: cpus=3 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
    in-flight: 1565:fill_page_cache_func
workqueue events_highpri: flags=0x10
  pwq 3: cpus=1 node=0 flags=0x1 nice=-20 active=1/256 refcnt=2
    in-flight: 1547:fill_page_cache_func
  pwq 1: cpus=0 node=0 flags=0x0 nice=-20 active=1/256 refcnt=2
    in-flight: 1811:fill_page_cache_func
workqueue events_unbound: flags=0x2
  pwq 8: cpus=0-3 flags=0x5 nice=0 active=3/512 refcnt=5
    pending: fsnotify_connector_destroy_workfn, fsnotify_mark_destroy_workfn, cleanup_offline_cgwbs_workfn
workqueue events_power_efficient: flags=0x82
  pwq 8: cpus=0-3 flags=0x5 nice=0 active=4/256 refcnt=6
    pending: neigh_periodic_work, neigh_periodic_work, check_lifetime, do_cache_clean
workqueue writeback: flags=0x4a
  pwq 8: cpus=0-3 flags=0x5 nice=0 active=1/256 refcnt=4
    in-flight: 433(RESCUER):wb_workfn
workqueue rpciod: flags=0xa
  pwq 8: cpus=0-3 flags=0x5 nice=0 active=38/256 refcnt=40
    in-flight: 7:rpc_async_schedule, 1609:rpc_async_schedule, 1610:rpc_async_schedule, 912:rpc_async_schedule, 1613:rpc_async_schedule, 1631:rpc_async_schedule, 34:rpc_async_schedule, 44:rpc_async_schedule
    pending: rpc_async_schedule, rpc_async_schedule, rpc_async_schedule, rpc_async_schedule, rpc_async_schedule, rpc_async_schedule, rpc_async_schedule, rpc_async_schedule, rpc_async_schedule, rpc_async_schedule, rpc_async_schedule, rpc_async_schedule, rpc_async_schedule, rpc_async_schedule, rpc_async_schedule, rpc_async_schedule, rpc_async_schedule, rpc_async_schedule, rpc_async_schedule, rpc_async_schedule, rpc_async_schedule, rpc_async_schedule, rpc_async_schedule, rpc_async_schedule, rpc_async_schedule, rpc_async_schedule, rpc_async_schedule, rpc_async_schedule, rpc_async_schedule, rpc_async_schedule
workqueue ext4-rsv-conversion: flags=0x2000a
pool 1: cpus=0 node=0 flags=0x0 nice=-20 hung=59s workers=2 idle: 6
pool 3: cpus=1 node=0 flags=0x1 nice=-20 hung=43s workers=2 manager: 20
pool 6: cpus=3 node=0 flags=0x0 nice=0 hung=0s workers=3 idle: 498 29
pool 8: cpus=0-3 flags=0x5 nice=0 hung=34s workers=9 manager: 1623
pool 9: cpus=0-3 flags=0x5 nice=-20 hung=0s workers=2 manager: 5224 idle: 859

Note that this is due to DIO writes to NFS only, as far as I can tell, and
that no reads had happened yet.

Changes:
========
ver #2:
   - Remove the callback param to __swap_writepage() as it's invariant.
   - Allocate the kiocb on the stack in sync mode.
   - Do an async DIO write if WB_SYNC_ALL isn't set.
   - Try to remove the BIO submission paths.

David

Link: https://lore.kernel.org/r/162876946134.3068428.15475611190876694695.stgit@warthog.procyon.org.uk/ # v1
---
David Howells (5):
      nfs: Fix write to swapfile failure due to generic_write_checks()
      mm: Remove the callback func argument from __swap_writepage()
      mm: Make swap_readpage() for SWP_FS_OPS use ->direct_IO() not ->readpage()
      mm: Make __swap_writepage() do async DIO if asked for it
      mm: Remove swap BIO paths and only use DIO paths [BROKEN]


 fs/direct-io.c       |   2 +
 include/linux/bio.h  |   2 +
 include/linux/fs.h   |   1 +
 include/linux/swap.h |   4 +-
 mm/page_io.c         | 379 ++++++++++++++++++++++---------------------
 mm/zswap.c           |   2 +-
 6 files changed, 204 insertions(+), 186 deletions(-)


