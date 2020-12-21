Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D80932E014C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Dec 2020 20:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbgLUTw4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Dec 2020 14:52:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45261 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726518AbgLUTwq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Dec 2020 14:52:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608580279;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g4Ccy5Y/+A40pLTl1bTQK9IV0EnfnxjPgBUXKnkaryk=;
        b=ACtsS70JbZhAo5MRc9zKj6hOeOF3iuT++BJyo8MZPLHzEW8fWeQfJyMGetoL82N/pApSqw
        h0imva2cLkxpHUg3ZIN1PDy/9c2hKlYO5RXJ6/fC94JtOVL5W8plyVc4rdwh4QwPWCryKR
        oDtBS2cnMUuXaX5be1R3Fvb8d88CD+I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-53--Anbpx-pNXyaD1agiUIXow-1; Mon, 21 Dec 2020 14:51:15 -0500
X-MC-Unique: -Anbpx-pNXyaD1agiUIXow-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 754FE425CB;
        Mon, 21 Dec 2020 19:51:13 +0000 (UTC)
Received: from horse.redhat.com (ovpn-114-244.rdu2.redhat.com [10.10.114.244])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 959C860C0F;
        Mon, 21 Dec 2020 19:51:11 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 296A0223D98; Mon, 21 Dec 2020 14:51:11 -0500 (EST)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Cc:     jlayton@kernel.org, vgoyal@redhat.com, amir73il@gmail.com,
        sargun@sargun.me, miklos@szeredi.hu, willy@infradead.org,
        jack@suse.cz, neilb@suse.com, viro@zeniv.linux.org.uk, hch@lst.de
Subject: [PATCH 1/3] vfs: Do not ignore return code from s_op->sync_fs
Date:   Mon, 21 Dec 2020 14:50:53 -0500
Message-Id: <20201221195055.35295-2-vgoyal@redhat.com>
In-Reply-To: <20201221195055.35295-1-vgoyal@redhat.com>
References: <20201221195055.35295-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Current implementation of __sync_filesystem() ignores the
return code from ->sync_fs(). I am not sure why that's the case.

Ignoring ->sync_fs() return code is problematic for overlayfs where
it can return error if sync_filesystem() on upper super block failed.
That error will simply be lost and sycnfs(overlay_fd), will get
success (despite the fact it failed).

Al Viro noticed that there are other filesystems which can sometimes
return error in ->sync_fs() and these errors will be ignored too.

fs/btrfs/super.c:2412:  .sync_fs        = btrfs_sync_fs,
fs/exfat/super.c:204:   .sync_fs        = exfat_sync_fs,
fs/ext4/super.c:1674:   .sync_fs        = ext4_sync_fs,
fs/f2fs/super.c:2480:   .sync_fs        = f2fs_sync_fs,
fs/gfs2/super.c:1600:   .sync_fs                = gfs2_sync_fs,
fs/hfsplus/super.c:368: .sync_fs        = hfsplus_sync_fs,
fs/nilfs2/super.c:689:  .sync_fs        = nilfs_sync_fs,
fs/ocfs2/super.c:139:   .sync_fs        = ocfs2_sync_fs,
fs/overlayfs/super.c:399:	.sync_fs        = ovl_sync_fs,
fs/ubifs/super.c:2052:  .sync_fs       = ubifs_sync_fs,

Hence, this patch tries to fix it and capture error returned
by ->sync_fs() and return to caller. I am specifically interested
in syncfs() path and return error to user.

I am assuming that we want to continue to call __sync_blockdev()
despite the fact that there have been errors reported from
->sync_fs(). So this patch continues to call __sync_blockdev()
even if ->sync_fs() returns an error.

Al noticed that there are few other callsites where ->sync_fs() error
code is being ignored.

sync_fs_one_sb(): For this it seems desirable to ignore the return code.

dquot_disable(): Jan Kara mentioned that ignoring return code here is fine
		 because we don't want to fail dquot_disable() just beacuse
		 caches might be incoherent.

dquot_quota_sync(): Jan thinks that it might make some sense to capture
		    return code here. But I am leaving it untouched for
		   now. When somebody needs it, they can easily fix it.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/sync.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/sync.c b/fs/sync.c
index 1373a610dc78..b5fb83a734cd 100644
--- a/fs/sync.c
+++ b/fs/sync.c
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
-- 
2.25.4

