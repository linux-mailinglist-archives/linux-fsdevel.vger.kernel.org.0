Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B342A2D3732
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Dec 2020 00:54:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730522AbgLHXxl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Dec 2020 18:53:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27030 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730236AbgLHXxh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Dec 2020 18:53:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607471530;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=MTh9e9UxyEy8kihSlCzR3WJynOSHVGELayKPMtiESZU=;
        b=bqo4rSEYmSs2IbP7Xi8SfqE8/UbmFCtJxqVTRpJ3x6g2PJ0iaw5YntcgthxSdiErbo3Oit
        cxV9U3u8QS0H3ydqRhu710O6dAD4BRo7Wn28rrk4YzQZHsZD+qSZqi9gKgzmL5b+nxbw59
        e+ryQOFbv3WvcFMYWi3XuH9T/knlBVk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-497-c3VAAdd1PuWrwzcGOCnjmg-1; Tue, 08 Dec 2020 18:52:07 -0500
X-MC-Unique: c3VAAdd1PuWrwzcGOCnjmg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B4351803620;
        Tue,  8 Dec 2020 23:52:05 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-116-67.rdu2.redhat.com [10.10.116.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 848FA5D9DD;
        Tue,  8 Dec 2020 23:52:04 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH] afs: Fix memory leak when mounting with multiple source
 parameters
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     syzbot+86dc6632faaca40133ab@syzkaller.appspotmail.com,
        Randy Dunlap <rdunlap@infradead.org>, dhowells@redhat.com,
        linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 08 Dec 2020 23:52:03 +0000
Message-ID: <160747152376.1115012.15487588820547991576.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There's a memory leak in afs_parse_source() whereby multiple source=
parameters overwrite fc->source in the fs_context struct without freeing
the previously recorded source.

Fix this by only permitting a single source parameter and rejecting with an
error all subsequent ones.

This was caught by syzbot with the kernel memory leak detector, showing
something like the following trace:

unreferenced object 0xffff888114375440 (size 32):
  comm "repro", pid 5168, jiffies 4294923723 (age 569.948s)
  hex dump (first 32 bytes):
    25 5e 5d 24 5b 2b 25 5d 28 24 7b 3a 0f 6b 5b 29  %^]$[+%](${:.k[)
    2d 3a 00 00 00 00 00 00 00 00 00 00 00 00 00 00  -:..............
  backtrace:
    [<0000000072e41e46>] slab_post_alloc_hook+0x42/0x79
    [<00000000d8b306e6>] __kmalloc_track_caller+0x125/0x16a
    [<0000000028ae1813>] kmemdup_nul+0x24/0x3c
    [<0000000072927516>] vfs_parse_fs_string+0x5a/0xa1
    [<0000000045b4b196>] generic_parse_monolithic+0x9d/0xc5
    [<0000000084462c80>] do_new_mount+0x10d/0x15a
    [<000000008aef98c5>] do_mount+0x5f/0x8e
    [<000000002998d632>] __do_sys_mount+0xff/0x127
    [<00000000faf86d94>] do_syscall_64+0x2d/0x3a
    [<000000004495c173>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

Fixes: 13fcc6837049 ("afs: Add fs_context support")
Reported-by: syzbot+86dc6632faaca40133ab@syzkaller.appspotmail.com
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Randy Dunlap <rdunlap@infradead.org>
---

 fs/afs/super.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/afs/super.c b/fs/afs/super.c
index 6c5900df6aa5..e38bb1e7a4d2 100644
--- a/fs/afs/super.c
+++ b/fs/afs/super.c
@@ -230,6 +230,9 @@ static int afs_parse_source(struct fs_context *fc, struct fs_parameter *param)
 
 	_enter(",%s", name);
 
+	if (fc->source)
+		return invalf(fc, "kAFS: Multiple sources not supported");
+
 	if (!name) {
 		printk(KERN_ERR "kAFS: no volume name specified\n");
 		return -EINVAL;


