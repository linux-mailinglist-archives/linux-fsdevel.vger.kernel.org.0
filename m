Return-Path: <linux-fsdevel+bounces-13340-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74F1F86EC9A
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Mar 2024 00:04:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDF1E1F222B1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 23:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 327345EE69;
	Fri,  1 Mar 2024 23:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NYoQDw9b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BE61F16B
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Mar 2024 23:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709334279; cv=none; b=P4OmnH8reEn1GZhK9l/bwl5tV6+UJBeG1AeHeQ3kxsa6kvMS/wAWXchr8yrEXpiv1qR67t4k9VD3AsCa+nUEiEE+U8WARehfcJ3mlUpW35VCL9WZBlK30lDDlicM4cYaAxxn6xbyf0xpOJ6URCpxsfj9o2HTnC15bmNXkYUd28A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709334279; c=relaxed/simple;
	bh=4lei7NE/sxx/Eb7C3DISEloqUNH1/A0D2O+AwiqnN3Q=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=ImltR1fnnLld+QXMbYJJBjyd1zPZ8fHmbdYJgPAcpf6o+AUnT9PI9PpJxK/xOjbaAPErjMQgdyq82BJq0XmgW3Eq72J+keOmMUeln/90vsJWNahZ3vSr1+A4YQWQMkmj0LXeHl7bUk9BMQI9bQEFxcYPmhZfyxdkGArf8q4DA9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NYoQDw9b; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709334276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=h9UdT98fW1T8MyRXzBEIgMQsRTSxXcPJT9GTAi5tvq0=;
	b=NYoQDw9btzMKlH8VQzRe8lrP9so4zKBoTBBlHA5X/nLFC837pKivcqULsJbtqzLmvrtEBe
	pXlog4CHXcxYX26ltB4eFbYAAllyl6MYow7cfbCde7ojjAO+5EAehx5QiyeFZdnFlPoShS
	jOCjkLaFVp9ds6hkKslX06c23tRvHjQ=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-504-HzQZGEkHOrSoARhXzW4-jA-1; Fri, 01 Mar 2024 18:04:35 -0500
X-MC-Unique: HzQZGEkHOrSoARhXzW4-jA-1
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7c495649efdso346041039f.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 Mar 2024 15:04:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709334273; x=1709939073;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=h9UdT98fW1T8MyRXzBEIgMQsRTSxXcPJT9GTAi5tvq0=;
        b=j/bm+eSbMXWnit4K+gssXViTPBJjBL5m6eVQYbdwpP/ZKlkUN6ugVFl7ijyhlAcsJ7
         fkD02oDEh4Vv4F8H9TfXLJIWo1PklaXAF+aUuLUx/1l6v9CrrEkzVbnh5PBHK1VzdtY7
         fkgwzoyErIMLKIkTNBmFl7AE9p39gH+RCltGunZVGu8nA3Vgl/7ePeNuyf0WyJbbUrF4
         R0Z6IsRL8o5ojAf6/SfNb4+wQf0JajffBEhCCY4zxEOGNnQ03aJeeaPRcCFwCuKrv7xM
         IT6A1fpaNt2dRv505CwHnBX65H5FIQ7lWt6Omqo8Bqf0HiHzNJj0o1RcZlMCiKUxdPVQ
         qbRw==
X-Gm-Message-State: AOJu0YzhxKhQlD5FpHs8dp+ii2peSKxGr1K3w9lL3NKU4lErMthZyKKE
	LVKjtQHQYYweDoo1zgV/YWq6fBghirBunWFd3raeXqc7T/0lHs3i0AqoUVyEioV55fv0xMEDwdN
	ncUVbu0rqolD1R78VN+LuwhnEe15M8UXDMBe5fubmZ4WtZ/cGPz2+T0M0VWQdTJgU4oQi+iZlmL
	LDfNenToiVdJUAd3O+YVpYi510MPYMS9eTcUbezt0yJFOV2nWg
X-Received: by 2002:a6b:7805:0:b0:7c8:da0:ba91 with SMTP id j5-20020a6b7805000000b007c80da0ba91mr2804512iom.21.1709334273333;
        Fri, 01 Mar 2024 15:04:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGicY6zKoi4QN8uXw6u8Yfmd/+IrzpsjP5uJV1bY5AWUHwgkYqr1YY9NqBoZl/xqJdTyI1C+A==
X-Received: by 2002:a6b:7805:0:b0:7c8:da0:ba91 with SMTP id j5-20020a6b7805000000b007c80da0ba91mr2804503iom.21.1709334273076;
        Fri, 01 Mar 2024 15:04:33 -0800 (PST)
Received: from [10.0.0.71] (sandeen.net. [63.231.237.45])
        by smtp.gmail.com with ESMTPSA id r17-20020a6b5d11000000b007c7a27451ddsm1167141iob.42.2024.03.01.15.04.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Mar 2024 15:04:32 -0800 (PST)
Message-ID: <b0d1a423-4b8e-4bc1-a021-a1078aee915f@redhat.com>
Date: Fri, 1 Mar 2024 17:04:31 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
 Christoph Hellwig <hch@infradead.org>, Bill O'Donnell <billodo@redhat.com>,
 =?UTF-8?Q?Krzysztof_B=C5=82aszkowski?= <kb@sysmikro.com.pl>
From: Eric Sandeen <sandeen@redhat.com>
Subject: [PATCH] freevxfs: Convert freevxfs to the new mount API.
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Convert the freevxfs filesystem to the new mount API.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
Tested-by: Krzysztof Błaszkowski <kb@sysmikro.com.pl>
---

Krzysztof tested this for me with an image he had; I guess I don't have
his explicit blessing for tested-by so Krzysztof if you have concerns
about that please speak up. :)

Note, this does convert some printk's to warnf() and friends. For
frequently-used filesystems I think I'd hold off on these conversions
so messages don't get lost until that question is sorted out, but for
almost-orphan filesystems ... I figure we can go for it.

 fs/freevxfs/vxfs_super.c | 66 ++++++++++++++++++++++++----------------
 1 file changed, 39 insertions(+), 27 deletions(-)

diff --git a/fs/freevxfs/vxfs_super.c b/fs/freevxfs/vxfs_super.c
index e6e2a2185e7c..2b3debe20d3f 100644
--- a/fs/freevxfs/vxfs_super.c
+++ b/fs/freevxfs/vxfs_super.c
@@ -17,7 +17,7 @@
 #include <linux/slab.h>
 #include <linux/stat.h>
 #include <linux/vfs.h>
-#include <linux/mount.h>
+#include <linux/fs_context.h>
 
 #include "vxfs.h"
 #include "vxfs_extern.h"
@@ -91,10 +91,10 @@ vxfs_statfs(struct dentry *dentry, struct kstatfs *bufp)
 	return 0;
 }
 
-static int vxfs_remount(struct super_block *sb, int *flags, char *data)
+static int vxfs_reconfigure(struct fs_context *fc)
 {
-	sync_filesystem(sb);
-	*flags |= SB_RDONLY;
+	sync_filesystem(fc->root->d_sb);
+	fc->sb_flags |= SB_RDONLY;
 	return 0;
 }
 
@@ -120,24 +120,24 @@ static const struct super_operations vxfs_super_ops = {
 	.evict_inode		= vxfs_evict_inode,
 	.put_super		= vxfs_put_super,
 	.statfs			= vxfs_statfs,
-	.remount_fs		= vxfs_remount,
 };
 
-static int vxfs_try_sb_magic(struct super_block *sbp, int silent,
+static int vxfs_try_sb_magic(struct super_block *sbp, struct fs_context *fc,
 		unsigned blk, __fs32 magic)
 {
 	struct buffer_head *bp;
 	struct vxfs_sb *rsbp;
 	struct vxfs_sb_info *infp = VXFS_SBI(sbp);
+	int silent = fc->sb_flags & SB_SILENT;
 	int rc = -ENOMEM;
 
 	bp = sb_bread(sbp, blk);
 	do {
 		if (!bp || !buffer_mapped(bp)) {
 			if (!silent) {
-				printk(KERN_WARNING
-					"vxfs: unable to read disk superblock at %u\n",
-					blk);
+				warnf(fc,
+				      "vxfs: unable to read disk superblock at %u",
+				      blk);
 			}
 			break;
 		}
@@ -146,9 +146,9 @@ static int vxfs_try_sb_magic(struct super_block *sbp, int silent,
 		rsbp = (struct vxfs_sb *)bp->b_data;
 		if (rsbp->vs_magic != magic) {
 			if (!silent)
-				printk(KERN_NOTICE
-					"vxfs: WRONG superblock magic %08x at %u\n",
-					rsbp->vs_magic, blk);
+				infof(fc,
+				      "vxfs: WRONG superblock magic %08x at %u",
+				      rsbp->vs_magic, blk);
 			break;
 		}
 
@@ -182,26 +182,27 @@ static int vxfs_try_sb_magic(struct super_block *sbp, int silent,
  * Locking:
  *   We are under @sbp->s_lock.
  */
-static int vxfs_fill_super(struct super_block *sbp, void *dp, int silent)
+static int vxfs_fill_super(struct super_block *sbp, struct fs_context *fc)
 {
 	struct vxfs_sb_info	*infp;
 	struct vxfs_sb		*rsbp;
 	u_long			bsize;
 	struct inode *root;
 	int ret = -EINVAL;
+	int silent = fc->sb_flags & SB_SILENT;
 	u32 j;
 
 	sbp->s_flags |= SB_RDONLY;
 
 	infp = kzalloc(sizeof(*infp), GFP_KERNEL);
 	if (!infp) {
-		printk(KERN_WARNING "vxfs: unable to allocate incore superblock\n");
+		warnf(fc, "vxfs: unable to allocate incore superblock");
 		return -ENOMEM;
 	}
 
 	bsize = sb_min_blocksize(sbp, BLOCK_SIZE);
 	if (!bsize) {
-		printk(KERN_WARNING "vxfs: unable to set blocksize\n");
+		warnf(fc, "vxfs: unable to set blocksize");
 		goto out;
 	}
 
@@ -210,24 +211,24 @@ static int vxfs_fill_super(struct super_block *sbp, void *dp, int silent)
 	sbp->s_time_min = 0;
 	sbp->s_time_max = U32_MAX;
 
-	if (!vxfs_try_sb_magic(sbp, silent, 1,
+	if (!vxfs_try_sb_magic(sbp, fc, 1,
 			(__force __fs32)cpu_to_le32(VXFS_SUPER_MAGIC))) {
 		/* Unixware, x86 */
 		infp->byte_order = VXFS_BO_LE;
-	} else if (!vxfs_try_sb_magic(sbp, silent, 8,
+	} else if (!vxfs_try_sb_magic(sbp, fc, 8,
 			(__force __fs32)cpu_to_be32(VXFS_SUPER_MAGIC))) {
 		/* HP-UX, parisc */
 		infp->byte_order = VXFS_BO_BE;
 	} else {
 		if (!silent)
-			printk(KERN_NOTICE "vxfs: can't find superblock.\n");
+			infof(fc, "vxfs: can't find superblock.");
 		goto out;
 	}
 
 	rsbp = infp->vsi_raw;
 	j = fs32_to_cpu(infp, rsbp->vs_version);
 	if ((j < 2 || j > 4) && !silent) {
-		printk(KERN_NOTICE "vxfs: unsupported VxFS version (%d)\n", j);
+		infof(fc, "vxfs: unsupported VxFS version (%d)", j);
 		goto out;
 	}
 
@@ -244,17 +245,17 @@ static int vxfs_fill_super(struct super_block *sbp, void *dp, int silent)
 
 	j = fs32_to_cpu(infp, rsbp->vs_bsize);
 	if (!sb_set_blocksize(sbp, j)) {
-		printk(KERN_WARNING "vxfs: unable to set final block size\n");
+		warnf(fc, "vxfs: unable to set final block size");
 		goto out;
 	}
 
 	if (vxfs_read_olt(sbp, bsize)) {
-		printk(KERN_WARNING "vxfs: unable to read olt\n");
+		warnf(fc, "vxfs: unable to read olt");
 		goto out;
 	}
 
 	if (vxfs_read_fshead(sbp)) {
-		printk(KERN_WARNING "vxfs: unable to read fshead\n");
+		warnf(fc, "vxfs: unable to read fshead");
 		goto out;
 	}
 
@@ -265,7 +266,7 @@ static int vxfs_fill_super(struct super_block *sbp, void *dp, int silent)
 	}
 	sbp->s_root = d_make_root(root);
 	if (!sbp->s_root) {
-		printk(KERN_WARNING "vxfs: unable to get root dentry.\n");
+		warnf(fc, "vxfs: unable to get root dentry.");
 		goto out_free_ilist;
 	}
 
@@ -284,18 +285,29 @@ static int vxfs_fill_super(struct super_block *sbp, void *dp, int silent)
 /*
  * The usual module blurb.
  */
-static struct dentry *vxfs_mount(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+static int vxfs_get_tree(struct fs_context *fc)
 {
-	return mount_bdev(fs_type, flags, dev_name, data, vxfs_fill_super);
+	return get_tree_bdev(fc, vxfs_fill_super);
+}
+
+static const struct fs_context_operations vxfs_context_ops = {
+	.get_tree	= vxfs_get_tree,
+	.reconfigure	= vxfs_reconfigure,
+};
+
+static int vxfs_init_fs_context(struct fs_context *fc)
+{
+	fc->ops = &vxfs_context_ops;
+
+	return 0;
 }
 
 static struct file_system_type vxfs_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "vxfs",
-	.mount		= vxfs_mount,
 	.kill_sb	= kill_block_super,
 	.fs_flags	= FS_REQUIRES_DEV,
+	.init_fs_context = vxfs_init_fs_context,
 };
 MODULE_ALIAS_FS("vxfs"); /* makes mount -t vxfs autoload the module */
 MODULE_ALIAS("vxfs");
-- 
2.43.0

 


