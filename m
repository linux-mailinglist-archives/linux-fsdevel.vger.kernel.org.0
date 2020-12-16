Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79C702DC25F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Dec 2020 15:39:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbgLPOji (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Dec 2020 09:39:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36478 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726543AbgLPOji (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Dec 2020 09:39:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608129491;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=gVUKEmORyjU5eVV5WXTEYQ4KDgnLkmlQvzKGyHA5964=;
        b=aAssUVVV49hOszKmPduJ8/9FfG9Qsqw4oDgjZmCBOG4aJLAJLO+1xM1HRZO2nI1lHT2ijo
        BQbkWy/yysyoSIlz7IQIONNlDgLw1aEKYr7awQJ40CBGVk3aeEMRV1oiazt7yeeqbDjEsF
        268xlxioFcX6T3mngzGUw3MtLeYiaz8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-270-vuIpWoLrPT-_aA9rhG-Y3g-1; Wed, 16 Dec 2020 09:38:06 -0500
X-MC-Unique: vuIpWoLrPT-_aA9rhG-Y3g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1BBC1801817;
        Wed, 16 Dec 2020 14:38:04 +0000 (UTC)
Received: from horse.redhat.com (ovpn-112-114.rdu2.redhat.com [10.10.112.114])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DC6911800D;
        Wed, 16 Dec 2020 14:38:02 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 5E825220BCF; Wed, 16 Dec 2020 09:38:02 -0500 (EST)
Date:   Wed, 16 Dec 2020 09:38:02 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Linux fsdevel mailing list <linux-fsdevel@vger.kernel.org>,
        linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     viro@zeniv.linux.org.uk, miklos@szeredi.hu, jlayton@kernel.org,
        amir73il@gmail.com, willy@infradead.org, jack@suse.cz,
        sargun@sargun.me
Subject: [PATCH] vfs, syncfs: Do not ignore return code from ->sync_fs()
Message-ID: <20201216143802.GA10550@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I see that current implementation of __sync_filesystem() ignores the
return code from ->sync_fs(). I am not sure why that's the case.

Ignoring ->sync_fs() return code is problematic for overlayfs where
it can return error if sync_filesystem() on upper super block failed.
That error will simply be lost and sycnfs(overlay_fd), will get
success (despite the fact it failed).

I am assuming that we want to continue to call __sync_blockdev()
despite the fact that there have been errors reported from
->sync_fs(). So I wrote this simple patch which captures the
error from ->sync_fs() but continues to call __sync_blockdev()
and returns error from sync_fs() if there is one.

There might be some very good reasons to not capture ->sync_fs()
return code, I don't know. Hence thought of proposing this patch.
Atleast I will get to know the reason. I still need to figure
a way out how to propagate overlay sync_fs() errors to user
space.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/sync.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

Index: redhat-linux/fs/sync.c
===================================================================
--- redhat-linux.orig/fs/sync.c	2020-12-16 09:15:49.831565653 -0500
+++ redhat-linux/fs/sync.c	2020-12-16 09:23:42.499853207 -0500
@@ -30,14 +30,18 @@
  */
 static int __sync_filesystem(struct super_block *sb, int wait)
 {
+	int ret, ret2;
+
 	if (wait)
 		sync_inodes_sb(sb);
 	else
 		writeback_inodes_sb(sb, WB_REASON_SYNC);
 
 	if (sb->s_op->sync_fs)
-		sb->s_op->sync_fs(sb, wait);
-	return __sync_blockdev(sb->s_bdev, wait);
+		ret = sb->s_op->sync_fs(sb, wait);
+	ret2 = __sync_blockdev(sb->s_bdev, wait);
+
+	return ret ? ret : ret2;
 }
 
 /*

