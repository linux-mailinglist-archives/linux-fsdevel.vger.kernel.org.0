Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DED263EA427
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Aug 2021 13:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236439AbhHLL6P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Aug 2021 07:58:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36561 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235448AbhHLL6P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Aug 2021 07:58:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628769159;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=+MUILZud/IAozexZw2Rp3LH70sCYOJsL7dafaXwyS/4=;
        b=aTDiUp2rQcSZpWD+jRGWGBhRlgC1udpHl0sLLUCfORLT9dOjgGlVAhVJcwQbzfOqX0mPBR
        gzS6jpyQkRc1TwSOJAr5wrrVCHdvSE/mrSDydq9B1cSP6R60rnQ7foChtFBpQ+XVw0YQdR
        5O07cSF61GI6qy2V1YLgIFI8TxBbXMM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-424-05cOM7r1PKGLzk-WXnMcXA-1; Thu, 12 Aug 2021 07:57:46 -0400
X-MC-Unique: 05cOM7r1PKGLzk-WXnMcXA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ADACF1008064;
        Thu, 12 Aug 2021 11:57:44 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.22.32.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4897C60657;
        Thu, 12 Aug 2021 11:57:42 +0000 (UTC)
Subject: [PATCH 0/2] mm: Fix NFS swapfiles and use DIO read for swapfiles
From:   David Howells <dhowells@redhat.com>
To:     willy@infradead.org
Cc:     dhowells@redhat.com, trond.myklebust@primarydata.com,
        darrick.wong@oracle.com, hch@lst.de, jlayton@kernel.org,
        sfrench@samba.org, torvalds@linux-foundation.org,
        linux-nfs@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 12 Aug 2021 12:57:41 +0100
Message-ID: <162876946134.3068428.15475611190876694695.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Hi Willy, Trond,

Here's a change to make reads from the swapfile use async DIO rather than
readpage(), as requested by Willy.

Whilst trying to make this work, I found that NFS's support for swapfiles
seems to have been non-functional since Aug 2019 (I think), so the first
patch fixes that.  Question is: do we actually *want* to keep this
functionality, given that it seems that no one's tested it with an upstream
kernel in the last couple of years?

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

David
---
David Howells (2):
      nfs: Fix write to swapfile failure due to generic_write_checks()
      mm: Make swap_readpage() for SWP_FS_OPS use ->direct_IO() not ->readpage()


 mm/page_io.c | 73 +++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 67 insertions(+), 6 deletions(-)


