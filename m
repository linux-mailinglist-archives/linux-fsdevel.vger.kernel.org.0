Return-Path: <linux-fsdevel+bounces-71273-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F37CBC24D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 01:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D833E300943D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 00:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 418EF2F25E2;
	Mon, 15 Dec 2025 00:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="US71yglr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7AD2ED846
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Dec 2025 00:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765758610; cv=none; b=GgOJehNrqZK599vDC663Ojj3GNhEgK9K2HZ9VaoaXKkxLp14iexMvE5dB1N6+hXabrvxPnZ91cxo2s6EwiUzBgp3q5WFlQchdaN9IOHBzcpGx2YVvRXCe+nCbeRoFoHG9z9KeyvTsM4HsrHi3HYnX4s06NAqt+HuBhtspKvg5w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765758610; c=relaxed/simple;
	bh=UuAi23Bz7BXygEvFRE5l4i0EJmfD6Kmonsp0nu5n/wA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M8KMPuRRcOJTDo6uNUUx/dAPiwL1Vadb9cz3HLgNzy7rRs9pkgrgXVSX8EfusVbfdmk6nRoCq8dZ7yNt4Wd6qeblNlqe4TMjJpNPDiFhy/UfcSy26+TsfCvIouMulWgq8qRN//R9TpPpFkn7MSwXVoTyfM2BekHqkn6KPcGtTE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=US71yglr; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4779cc419b2so30425235e9.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 14 Dec 2025 16:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765758607; x=1766363407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M2TsxigQJnXUF8zh9YUO1wBhx8HEJp8RRzu7Ncb060E=;
        b=US71yglrfkrKdVW2kfMrRXeGGM3rxLQqdjZc/3TmHY8FB0BzWBVQ+OwQBr+qzAHIZq
         MVlfo3cl8xUcVgegEMBVZ+jr6xXNU0WQoko4EItd0Icrufgbr7EM2xIr5DSL4jcbv8cB
         uwRKyJ2goEPV8ElBZ77vqrG53E1ylDUbWVSn8M8gDeVLALWnp0j7Nu7ZUPVkWxxFnvi0
         LyBbX/QbdenkTJa6pDHku+UQWSGE+5sCNBYZpukmaWvpscjzRWH07wrHdfd8pOUxjXX8
         vJcFlY7Ro9VKGg2zFr5Ph3ep0Z7dfVPpNecNIelywuzlm139TiMB8H9KMqSMlRLsud29
         imJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765758607; x=1766363407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M2TsxigQJnXUF8zh9YUO1wBhx8HEJp8RRzu7Ncb060E=;
        b=vCgihzXff5GFUWljw2oWc+zmXDw+NUaYM0dzSy3om7e1+ZQUC4ZWopZLhMrsnT+JQw
         CLESsynfpEIrlqPq7d/8BVV0cGPdpUDwHwv/assS0cXCa0nlgIgRl784YsYYmBWrvJaz
         8BTrrstnMIMyhUxm4vYjVtO2QYN4OToWVyoE2fr0QdOYfafM8/PXxYo7PH6jKqkZK8A2
         6Uf/w+578ZvIcAK/Zo8KQ3IbrfNkOOaaTkVF6HRxvpaJxY/e9SoXqpUlLcAIq3faeyjh
         RUVtb+dKWV9zRHS4px1aioYK40HJ6E50YiPHTRqjiGdGGrBHkjoJpXt2w2Yypspo5HyB
         CzUw==
X-Forwarded-Encrypted: i=1; AJvYcCVb1dLMhKtWkj5UjL3Ev5X34QMFOnlliw+XnzZ+VvFSlr2L9gQSYl+ger+p4MuicTH7ZFnujbFzlG/1ru+C@vger.kernel.org
X-Gm-Message-State: AOJu0YxNGts4+/VGUP+EPCekPdcGPQT0HEI3cF+sKIPb0ixJOb3k6Sdy
	NqJ9sxizaDQQO32IUwRsVSIeZoUyAHcQjYD6I+9VkusR/sN0Vk546R5I
X-Gm-Gg: AY/fxX4hlv73yu92uGre3cX+eRSITjFtPNsXP0dvW15M3XpaEbIeRwhkXpvj+jveuRW
	0+Z7FE1qpsOxrodR3BirA5tXlzaURxHF8nj8bHGX48bW4gLKF1szKbD/YyPXc0FI93HjkEZuHBq
	pUG4ivIIj20JQD2/ckp4l87xNe2OzRd+m6d4AzEOkr6N3Trjj5rZ9LzDKVOFnZNFlFSxutDIxpR
	YWnbCG8uDXrVz7JXsovHhOOLT+3P+NaLbMA3NRLsJui4gBIjsZryWmv1CF8nfR1g74bDy+pjUHf
	BC4pkgm8pbqenmwGxhK5UAEUfVAWDjPhKbBeXWwtlHTHSX8hwbNsAyY9f117R2wUpVD+rntZneX
	Z5WcQsfxfRcIde5eLCsGPse3u3pS7sdb4h6INsjbHHGAEBSmG/LSQzyJ8/jGcAqVgXw5a9oydFc
	mU0xc7pgx+LR5UxygtJ8emloUZXKfgujNp8FthNhchNl0=
X-Google-Smtp-Source: AGHT+IFbp2Jw9RT9K70hnf2MaicUF2ApfvzKt6GrG3uHWNivxnvjvUAas6pQ+q2+9c0oFM7RJYlV9Q==
X-Received: by 2002:a05:600c:1994:b0:477:a978:3a7b with SMTP id 5b1f17b1804b1-47a8f905675mr78020235e9.22.1765758607023;
        Sun, 14 Dec 2025 16:30:07 -0800 (PST)
Received: from eray-kasa.. ([2a02:4e0:2d18:46e:3c46:576e:9e04:ff85])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a8f703efesm56435575e9.16.2025.12.14.16.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Dec 2025 16:30:06 -0800 (PST)
From: Ahmet Eray Karadag <eraykrdg1@gmail.com>
To: akpm@linux-foundation.org
Cc: viro@zeniv.linux.org.uk,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	Ahmet Eray Karadag <eraykrdg1@gmail.com>,
	syzbot+1c70732df5fd4f0e4fbb@syzkaller.appspotmail.com
Subject: [PATCH v2] adfs: fix memory leak in sb->s_fs_info
Date: Mon, 15 Dec 2025 03:22:52 +0300
Message-ID: <20251215002252.158637-2-eraykrdg1@gmail.com>
In-Reply-To: <20251213233621.151496-2-eraykrdg1@gmail.com>
References: <20251213233621.151496-2-eraykrdg1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Syzbot reported a memory leak in adfs during the mount process. The issue
arises because the ownership of the allocated (struct adfs_sb_info) is
transferred from the filesystem context to the superblock via sget_fc().
This function sets fc->s_fs_info to NULL after the transfer.

The ADFS filesystem previously used the default kill_block_super for
superblock destruction. This helper performs generic cleanup but does not
free the private sb->s_fs_info data. Since fc->s_fs_info is set to
NULL during the transfer, the standard context cleanup (adfs_free_fc)
also skips freeing this memory. As a result, if the superblock is
destroyed, the allocated struct adfs_sb_info is leaked.

Fix this by implementing a custom .kill_sb callback (adfs_kill_sb)
that explicitly frees sb->s_fs_info before invoking the generic
kill_block_super.

Reported-by: syzbot+1c70732df5fd4f0e4fbb@syzkaller.appspotmail.com
Fixes: https://syzkaller.appspot.com/bug?extid=1c70732df5fd4f0e4fbb
Signed-off-by: Ahmet Eray Karadag <eraykrdg1@gmail.com>
---
v2:
 - Remove adfs_put_super
 - Remove error label in adfs_fill_super
 - Use kfree_rcu instead kfree
 - Free map in adfs_kill_sb
 - Tested with ADFS test images
---
 fs/adfs/super.c | 32 ++++++++++++++------------------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/fs/adfs/super.c b/fs/adfs/super.c
index fdccdbbfc213..96855f1086cd 100644
--- a/fs/adfs/super.c
+++ b/fs/adfs/super.c
@@ -90,14 +90,6 @@ static int adfs_checkdiscrecord(struct adfs_discrecord *dr)
 	return 0;
 }
 
-static void adfs_put_super(struct super_block *sb)
-{
-	struct adfs_sb_info *asb = ADFS_SB(sb);
-
-	adfs_free_map(sb);
-	kfree_rcu(asb, rcu);
-}
-
 static int adfs_show_options(struct seq_file *seq, struct dentry *root)
 {
 	struct adfs_sb_info *asb = ADFS_SB(root->d_sb);
@@ -246,7 +238,6 @@ static const struct super_operations adfs_sops = {
 	.free_inode	= adfs_free_inode,
 	.drop_inode	= adfs_drop_inode,
 	.write_inode	= adfs_write_inode,
-	.put_super	= adfs_put_super,
 	.statfs		= adfs_statfs,
 	.show_options	= adfs_show_options,
 };
@@ -362,7 +353,7 @@ static int adfs_fill_super(struct super_block *sb, struct fs_context *fc)
 		ret = -EINVAL;
 	}
 	if (ret)
-		goto error;
+		return ret;
 
 	/* set up enough so that we can read an inode */
 	sb->s_op = &adfs_sops;
@@ -403,15 +394,9 @@ static int adfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	if (!sb->s_root) {
 		adfs_free_map(sb);
 		adfs_error(sb, "get root inode failed\n");
-		ret = -EIO;
-		goto error;
+		return -EIO;
 	}
 	return 0;
-
-error:
-	sb->s_fs_info = NULL;
-	kfree(asb);
-	return ret;
 }
 
 static int adfs_get_tree(struct fs_context *fc)
@@ -462,10 +447,21 @@ static int adfs_init_fs_context(struct fs_context *fc)
 	return 0;
 }
 
+static void adfs_kill_sb(struct super_block *sb)
+{
+	struct adfs_sb_info *asb = ADFS_SB(sb);
+
+	kill_block_super(sb);
+
+	adfs_free_map(sb);
+
+	kfree_rcu(asb, rcu);
+}
+
 static struct file_system_type adfs_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "adfs",
-	.kill_sb	= kill_block_super,
+	.kill_sb	= adfs_kill_sb,
 	.fs_flags	= FS_REQUIRES_DEV,
 	.init_fs_context = adfs_init_fs_context,
 	.parameters	= adfs_param_spec,
-- 
2.43.0


