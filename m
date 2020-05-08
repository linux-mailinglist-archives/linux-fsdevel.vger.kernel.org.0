Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF43A1CBA81
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 May 2020 00:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbgEHWQv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 May 2020 18:16:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38358 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727828AbgEHWQu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 May 2020 18:16:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588976209;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=WtlaW23JDJ9HL5V5AbxLYLZIsw33KhJwstUsDfJ8CX0=;
        b=QaSnnwVnMHWb/bIk1xRev0M5Ta/12vMPrkp6XPDmXixfkrS82K/bPMG8Paqonawl5C4p4t
        QfB82JtCg3aWDudImRNbSuqSRjK24LFF+YgkFBkExKYPfmjEFVrK+BxWCNQN1xdfciTnMY
        myU+qSgpgeVUeX5JTGkEGYn7ypMkgvM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174--VLbbYq4OZqQqAlSytfzBw-1; Fri, 08 May 2020 18:16:45 -0400
X-MC-Unique: -VLbbYq4OZqQqAlSytfzBw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 71E9C107ACCD;
        Fri,  8 May 2020 22:16:44 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-118-225.rdu2.redhat.com [10.10.118.225])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 928776AD09;
        Fri,  8 May 2020 22:16:37 +0000 (UTC)
Subject: [PATCH 0/5] cachefiles, nfs: Fixes
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Cc:     Lei Xue <carmark.dlut@gmail.com>,
        Dave Wysochanski <dwysocha@redhat.com>,
        David Wysochanski <dwysocha@redhat.com>,
        Carlos Maiolino <cmaiolino@redhat.com>, dhowells@redhat.com,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs@vger.kernel.org, linux-cachefs@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 08 May 2020 23:16:36 +0100
Message-ID: <158897619675.1119820.2203023452686054109.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.21
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Hi Linus, Trond, Anna,

Can you pull these fixes for cachefiles and NFS's use of fscache?  Should
they go through the NFS tree or directly upstream?  The things fixed are:

 (1) The reorganisation of bmap() use accidentally caused the return value
     of cachefiles_read_or_alloc_pages() to get corrupted.

 (2) The NFS superblock index key accidentally got changed to include a
     number of kernel pointers - meaning that the key isn't matchable after
     a reboot.

 (3) A redundant check in nfs_fscache_get_super_cookie().

 (4) The NFS change_attr sometimes set in the auxiliary data for the
     caching of an file and sometimes not, which causes the cache to get
     discarded when it shouldn't.

 (5) There's a race between cachefiles_read_waiter() and
     cachefiles_read_copier() that causes an occasional assertion failure.

The patches are tagged here:

	git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git
	tag fscache-fixes-20200508-2

Thanks,
David
---
Dave Wysochanski (3):
      NFS: Fix fscache super_cookie index_key from changing after umount
      NFS: Fix fscache super_cookie allocation
      NFSv4: Fix fscache cookie aux_data to ensure change_attr is included

David Howells (1):
      cachefiles: Fix corruption of the return value in cachefiles_read_or_alloc_pages()

Lei Xue (1):
      cachefiles: Fix race between read_waiter and read_copier involving op->to_do


 fs/cachefiles/rdwr.c |   12 ++++++------
 fs/nfs/fscache.c     |   39 ++++++++++++++++++---------------------
 fs/nfs/super.c       |    1 -
 3 files changed, 24 insertions(+), 28 deletions(-)


