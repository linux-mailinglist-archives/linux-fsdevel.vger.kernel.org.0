Return-Path: <linux-fsdevel+bounces-71280-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DEAA1CBC52B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 04:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5767A3008BC0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 03:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7BBB31A04D;
	Mon, 15 Dec 2025 03:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pl2xHjiW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87EB731984E
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Dec 2025 03:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765768820; cv=none; b=fV2f4d9q40CI3dcflUom8cyT3ZzSWe3GltbwE4lVkWJr5N0JyU0GcHPVeZqtp4Z/xKX1c2a2Q87r+w79GWImU4R2D6OfyX/EQ+DZ8ST9abss1VUwacIGOWdg1YGRkn+gYkyH1cuJb3W4vQ/jspvDzAYdzMYk6jDvx3asoDNx8DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765768820; c=relaxed/simple;
	bh=ivODMrg/FnXo1Qa6TCazBxG2cCvZSG5kJiO8UZDEftY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OfJmMo5R2QQZdc7gprwFo8RzMxjL9VCrIQOHYUHXMTTGP19NNdkn3Sdy0xJOTzozaCTzrIfKMQXWCm87Q5mBvxianrX4RlsI1UiSvAmeR9nqeJjcGGRBlYJnI1Hd1ijcJJgjbUf3m5ACBn4klQHgdB2r1kP/FUvEmIT4HPIU5ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pl2xHjiW; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4779aa4f928so38001475e9.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 14 Dec 2025 19:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765768813; x=1766373613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PvH2175WHU7W1KCtzrt9AMe5qH2hVu70g0VD1sppAW4=;
        b=Pl2xHjiWt/hxA7CdDAufXFiGCCt+8Dw+Xt9hzmSyh7NatClTuWylHjI7vukv3EK5Mo
         5UoRh8YAOYKzW1+L2CP2mXyZSXQXfjjHYki/jp/ZC5O/PwUxSNNTAUQachT95iNuIJDp
         COSSzhhbMTLuplSmSSRL3g5zmzVlwUXgvrrTD0OvWM/1DbRaadgnheQ4PeTeMfmsrDAh
         3/fxMT3U/s1AAfBjuzae2tdEUbF4PR191Y1khZK4ltsHdDzjxqlAp/9zMqv4ARmEtwUG
         AR1vommbhWAPirrr6VAFP9c1uYDTcHVrBETzHFGByWlYmfstphJAR87I3gk2DWqJKRzj
         owDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765768813; x=1766373613;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PvH2175WHU7W1KCtzrt9AMe5qH2hVu70g0VD1sppAW4=;
        b=fkKBmnfMbh1mhOLEWZ4oa8gDleZCSMX9W27b4hFaQCOT7sgKDxwCbKLYsUXtVGiXlf
         XL6Wrjt+fJDY7lGsrbmFd0OJI9NuhSniU6919mHWKge3Rv3FyqtbUwGs4nLstOgUsgP8
         TNTaa698Am5zcjJCRlDooCK4kVsbz8F4qUkTCwBanH6HZlvyolK98yP4XHNuHh2gWFpb
         SfP85F+q4Ma8w5PD6UpcB42Qjw18s3PTpyxY4eoVKj0SZ7FIrgt72EdpH41j/i6GDcRH
         H9bWvKXUcMakCl+qiSsLAxthPib7vDrNoc7fMdhsxV2K3IBZ2jmQh9DvKaSQpQgGHp2s
         ToOA==
X-Forwarded-Encrypted: i=1; AJvYcCWXTbyXlQSKFIcouzfjZi1ORM0STSQWIV/FDGZdTAv1jkyzTsClNHA94BDimUMXQXaOoOUCWD3Lze2vYPyq@vger.kernel.org
X-Gm-Message-State: AOJu0YxnUiUsd0GLvS91kKim2yBYVQcnJ7C9pu7QQ4gPyKNpQIhAEqcc
	HIyUE1VTjcIPrqbvzFlge1yBHZUU8Z4XgpofeEnFr16wJKnW/AtmpBN5
X-Gm-Gg: AY/fxX5kFFXk4Bh/lgMMbaPAAYFLGIdJ3jgUAEeBIlt+fVbDdvjlJxhU6dv93R08V5+
	Tj4QuOz3pG/uiVipalDlCkr+clTX8JdDTMJVGKYrMddirZv0tt0jBJgjDHcyZqZfdsdVPBRhdes
	xrFQfFpyVCg+rs8k5Ma9RJvDiL9bC2wj2dtp2vViuiQ3PXGl2ApzH4fT63HFVZvmrmkPMtC5JFi
	8/vCx/LFM4gd5sKWQmHfKdrMkXtsz8tYzOcScMaM6h52SeeqjQNWXB8/+uQRj2sJn6O4VR/uIUT
	WNQzt7fq3xqfF/O3mF/YbSfc6mch5dpAzDC+4e1xqYSS7zTmaCmA3R5Uv+PkDUH4skgeoE851Kj
	bWw2lwxx5rG9zUw+WlXP5FS2hPMV8kjUWRdy7v2fdxIt0SoC9C/fwWSdLPLJ3GjXgMBm+xI+/WT
	ZaVO3OHogx6XnWXc4b+5HPezYqApPPljS44V95irwiFvI=
X-Google-Smtp-Source: AGHT+IF43eVjTLDjh/CzyeHPa4AgcllROvUF+Tk9Iw3AXUkA1JTqtW6UI+UpBKYGynW8HvQJtRH7RA==
X-Received: by 2002:a05:600d:8401:b0:47a:935f:61a0 with SMTP id 5b1f17b1804b1-47a935f64f6mr65201255e9.0.1765768812985;
        Sun, 14 Dec 2025 19:20:12 -0800 (PST)
Received: from eray-kasa.. ([2a02:4e0:2d18:46e:3c46:576e:9e04:ff85])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a8f6f3e78sm62482475e9.3.2025.12.14.19.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Dec 2025 19:20:12 -0800 (PST)
From: Ahmet Eray Karadag <eraykrdg1@gmail.com>
To: akpm@linux-foundation.org
Cc: viro@zeniv.linux.org.uk,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	Ahmet Eray Karadag <eraykrdg1@gmail.com>,
	syzbot+1c70732df5fd4f0e4fbb@syzkaller.appspotmail.com
Subject: [PATCH v3] adfs: fix memory leak in sb->s_fs_info
Date: Mon, 15 Dec 2025 06:14:34 +0300
Message-ID: <20251215031433.182205-2-eraykrdg1@gmail.com>
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
v3:
 - Restore adfs_put_super() to handle map cleanup
 - Moving map cleanup to kill_sb() caused a double-free
---
 fs/adfs/super.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/fs/adfs/super.c b/fs/adfs/super.c
index fdccdbbfc213..51bf4652422d 100644
--- a/fs/adfs/super.c
+++ b/fs/adfs/super.c
@@ -92,10 +92,7 @@ static int adfs_checkdiscrecord(struct adfs_discrecord *dr)
 
 static void adfs_put_super(struct super_block *sb)
 {
-	struct adfs_sb_info *asb = ADFS_SB(sb);
-
 	adfs_free_map(sb);
-	kfree_rcu(asb, rcu);
 }
 
 static int adfs_show_options(struct seq_file *seq, struct dentry *root)
@@ -362,7 +359,7 @@ static int adfs_fill_super(struct super_block *sb, struct fs_context *fc)
 		ret = -EINVAL;
 	}
 	if (ret)
-		goto error;
+		return ret;
 
 	/* set up enough so that we can read an inode */
 	sb->s_op = &adfs_sops;
@@ -403,15 +400,9 @@ static int adfs_fill_super(struct super_block *sb, struct fs_context *fc)
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
@@ -462,10 +453,19 @@ static int adfs_init_fs_context(struct fs_context *fc)
 	return 0;
 }
 
+static void adfs_kill_sb(struct super_block *sb)
+{
+	struct adfs_sb_info *asb = ADFS_SB(sb);
+
+	kill_block_super(sb);
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


