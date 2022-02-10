Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18A674B1379
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Feb 2022 17:51:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244818AbiBJQvq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Feb 2022 11:51:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244375AbiBJQvp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Feb 2022 11:51:45 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98309EE;
        Thu, 10 Feb 2022 08:51:46 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4E1F121121;
        Thu, 10 Feb 2022 16:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1644511905; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=IYGYQc5+DmfMVKXLKY+jywQH8/yCGWAk5raliA2Ua8A=;
        b=KdU4IMRUtt07PIUbUWCPUNaVK1Op56Cm2m+sVGPj4s2RqN9fN59yX88oW/JI+NVDvwIDM+
        9x8C1YP2H6Cox1VVFF8GEbWcZI2mE7sMtFukj0VyVAA4KKEZpvPsUtBUMGUt9WZm7sWldL
        JVYFdgFeZ5FYdUfPj2f7I0odwbzCIqw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1644511905;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=IYGYQc5+DmfMVKXLKY+jywQH8/yCGWAk5raliA2Ua8A=;
        b=BE5lRfziXErod1Fbvr6Yj+HYsNUjAqWSrDW+HXBKOvqyyLwh0j50rZ1KRPXY4NoAcG9AtJ
        mKNng34KDh1bhnBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D940513C14;
        Thu, 10 Feb 2022 16:51:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id BmoJKaBCBWL7PgAAMHmgww
        (envelope-from <rgoldwyn@suse.de>); Thu, 10 Feb 2022 16:51:44 +0000
Date:   Thu, 10 Feb 2022 10:51:42 -0600
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     dhowells@redhat.com, fvogt@suse.com
Subject: [PATCH] Fix read-only superblock in case of subvol RO remount
Message-ID: <20220210165142.7zfgotun5qdtx4rq@fiona>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If a read-write root mount is remounted as read-only, the subvolume
is also set to read-only.

Use a rw_mounts counter to check the number of read-write mounts, and change
superblock to read-only only in case there are no read-write subvol mounts.

Since sb->s_flags can change while calling legacy_reconfigure(), use
sb->s_flags instead of fc->sb_flags to re-evaluate sb->s_flags in
reconfigure_super().

Test case:
dd if=/dev/zero of=btrfsfs seek=240 count=0 bs=1M
mkfs.btrfs btrfsfs
mount btrfsfs /mnt
btrfs subvol create /mnt/sv
mount -o remount,ro /mnt
mount -osubvol=/sv btrfsfs /mnt/sv
findmnt # /mnt is RO, /mnt/sv RW
mount -o remount,ro /mnt
findmnt # /mnt is RO, /mnt/sv RO as well
umount /mnt{/sv,}
rm btrfsfs

Reported-by: Fabian Vogt <fvogt@suse.com>
Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index a2991971c6b5..2bb6869f15af 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1060,6 +1060,9 @@ struct btrfs_fs_info {
 	spinlock_t zone_active_bgs_lock;
 	struct list_head zone_active_bgs;
 
+	/* Count of subvol mounts read-write */
+	int rw_mounts;
+
 #ifdef CONFIG_BTRFS_FS_REF_VERIFY
 	spinlock_t ref_verify_lock;
 	struct rb_root block_tree;
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 33cfc9e27451..32941e11e551 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1835,6 +1835,11 @@ static struct dentry *btrfs_mount(struct file_system_type *fs_type, int flags,
 	/* mount_subvol() will free subvol_name and mnt_root */
 	root = mount_subvol(subvol_name, subvol_objectid, mnt_root);
 
+	if (!IS_ERR(root) && !(flags & SB_RDONLY)) {
+		struct btrfs_fs_info *fs_info = btrfs_sb(mnt_root->mnt_sb);
+		fs_info->rw_mounts++;
+	}
+
 out:
 	return root;
 }
@@ -1958,6 +1963,9 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
 		goto out;
 
 	if (*flags & SB_RDONLY) {
+
+		if (--fs_info->rw_mounts > 0)
+			goto out;
 		/*
 		 * this also happens on 'umount -rf' or on shutdown, when
 		 * the filesystem is busy.
@@ -2057,6 +2065,8 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
 		if (ret)
 			goto restore;
 
+		fs_info->rw_mounts++;
+
 		btrfs_clear_sb_rdonly(sb);
 
 		set_bit(BTRFS_FS_OPEN, &fs_info->flags);
diff --git a/fs/super.c b/fs/super.c
index f1d4a193602d..fd528f76f14b 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -913,7 +913,8 @@ int reconfigure_super(struct fs_context *fc)
 	}
 
 	WRITE_ONCE(sb->s_flags, ((sb->s_flags & ~fc->sb_flags_mask) |
-				 (fc->sb_flags & fc->sb_flags_mask)));
+				 (sb->s_flags & fc->sb_flags_mask)));
+
 	/* Needs to be ordered wrt mnt_is_readonly() */
 	smp_wmb();
 	sb->s_readonly_remount = 0;

-- 
Goldwyn
