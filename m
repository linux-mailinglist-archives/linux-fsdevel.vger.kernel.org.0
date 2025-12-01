Return-Path: <linux-fsdevel+bounces-70380-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 705A2C992D8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 01 Dec 2025 22:29:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CA4D74E2594
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Dec 2025 21:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BACEB285CBA;
	Mon,  1 Dec 2025 21:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eOM/prtQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699D123F40D
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Dec 2025 21:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764624570; cv=none; b=lrLnC0JWMJ/m9wiNnFfasIZ2NRRLtO9F0+F8KYsOIdVQMKghrQwqB4kbscmAgFz9BfwbvNzDVbNbPiSKGVsQvFP5egr5LawSNl0VHvXF6S+Ib5VG3qgSAPHNuAYqm7kJPLs8aOzZD5gAanw3qlmtyEPhBcjpATmEPARFQ1eQrSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764624570; c=relaxed/simple;
	bh=lSvg/K7yPsKUCFTcfSOcZg9VsOKeNcGmYT1edmcLv+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZUKr1vV0OZfXEgfg8wZzDYlNYpq/1u/hLeMsl3MnI6A5+lI0bSnPBV5H9LnFwE4BfQUk3NYckJye8138mw9L0R9eS2K5Dy9OdeyZ0NV58HRShtDK8TGMERjH9F5jE3EahKgY/BgaZ7Bh1DNSct+qkLqcxElPujBGGobmoXZafTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eOM/prtQ; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6411f1c4b4fso716346a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Dec 2025 13:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764624567; x=1765229367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S0Yn63rsGsd4Hj7X1d2hk85Oe6NspbG2sX3h25PNq3o=;
        b=eOM/prtQzCQkC3h2dB0feks+lWNJnMfgWJmuVHWXl6qTGv7Vmsizgz10yBKuH7+4Ek
         U08BtSGDiDI3VFnNy68nUFLLkZvg6m27DIlitsimj8YV5a2R2Fcq3cJC9H5OlMiw1XBA
         4gDEdsg5udlNMRl2n8bWiRrUs9hXvCygKAxIijfPm6ZhP/U2SZUIhbP9QJGl/Reg5twr
         IKl3/yMI1ga1/EtaOWRV0D4jTi7ttgqvSnOq74eFwzXGS9bHNKkkYBKps8Vp0EPabH5m
         AxIlYKN7WqFBjeEQo/katzZ+qjOdI4Kz+6jzGqB7QDFdLQN+w36Z2H6nAJiIMtoW57iE
         3ehg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764624567; x=1765229367;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=S0Yn63rsGsd4Hj7X1d2hk85Oe6NspbG2sX3h25PNq3o=;
        b=hiEwstdTiMx66sYhYtM41Yeey5c4JNqVLypgBCd/qaSBv3r+3KkO7GjC55IyVpZc1h
         R5btEBUxw4lpHXspmdm0ENVceBVNEiz8gSZvLjTmNiMkDwRBgJPGIPGK1xmd+8kkqJY2
         8AevR7ppwDMxd3sMG7a0cEivAKAMG2YwZqDsec2RR2l3XNUO8FYZDnwA1kcR2XRApPOY
         hEvwAkPHCuVIihjYWJBcFuz7+UemV2nxYI13/F8AbtSy5k3Az7OQ8X9+LIkjd9hqO6s3
         iIayF8ce0C3b1tf6ITPut7olSnV6A0o5OAvN4f8bEZ0JXM9rhmejezYGu2ORE4+iyirH
         5xzw==
X-Gm-Message-State: AOJu0Yy7yn9fV6vH97bQFOHiCJAFjLEGtSyzUGiYw4u4yh12a9TsYbPM
	qva6ykZbtQ10zQUzv8u1TjsaKMPRdYOMzevQK+Yd7jYifaM1hyjtINst
X-Gm-Gg: ASbGncusClDC4xXi1y+AsxNt4LjpGEhcJ/aOgoHXiNCqzRggRsvXVaTLSDgInKZlf4x
	qrJCF3iBXtHdl0mpD7U+TKvWtOKfwVzCAbi/ri6YcBNsP1GGgGNk11Ea1y+wp2iko5dEDU5NNnE
	Y2koY4Y6fcaalFNmc/1hkbwDXRty7TahrQyc2477Sj3o/i+81CuK/5xNzMYwKoZ/Ycu2+nUeejt
	NMrv0Be/Yhbr+lBFhmo7Z/0vwDH1OcgnqKgLCd+ul3dU5HqLzGPdc66z7iSich7EA/NvoF797mT
	bo5DnGqZGmrcHNlyrUjzeq6ETpWlpa0nosftxgCrjWbp9WDp8+Abf8f0wIKCqWnunSahQBH/nj/
	BIMrM5J0q+qojtE/F8zQx8N4yNZ7Ik2DsF5cdxz1V10XNglU0zShVKZzoFU7nu02pMCgGaYgQE9
	loZIZIq1lkicwYVQ==
X-Google-Smtp-Source: AGHT+IGu1SlFFpvIYvIrQ+apMAxrKVb7zxXr0S8Sxm9iSmu6U7ZmdNyqWZGcEobHLqob2qXQsUOdtQ==
X-Received: by 2002:a05:6402:5190:b0:645:e986:682f with SMTP id 4fb4d7f45d1cf-645e98668camr14681838a12.8.1764624566404;
        Mon, 01 Dec 2025 13:29:26 -0800 (PST)
Received: from bhk ([165.50.39.229])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6475104fd7asm13519497a12.23.2025.12.01.13.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 13:29:26 -0800 (PST)
From: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
To: slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com,
	jack@suse.cz,
	sandeen@redhat.com,
	brauner@kernel.org,
	Slava.Dubeyko@ibm.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	khalid@kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 2/2] hfsplus: ensure sb->s_fs_info is always cleaned up
Date: Mon,  1 Dec 2025 23:23:07 +0100
Message-ID: <20251201222843.82310-3-mehdi.benhadjkhelifa@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251201222843.82310-1-mehdi.benhadjkhelifa@gmail.com>
References: <20251201222843.82310-1-mehdi.benhadjkhelifa@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When hfsplus was converted to the new mount api a bug was introduced by
changing the allocation pattern of sb->s_fs_info. If setup_bdev_super()
fails after a new superblock has been allocated by sget_fc(), but before
hfsplus_fill_super() takes ownership of the filesystem-specific s_fs_info
data it was leaked.

Fix this by freeing sb->s_fs_info in hfsplus_kill_super().

Cc: stable@vger.kernel.org
Fixes: 432f7c78cb00 ("hfsplus: convert hfsplus to use the new mount api")
Reported-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com> 
Tested-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
---
 fs/hfsplus/super.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
index 16bc4abc67e0..8734520f6419 100644
--- a/fs/hfsplus/super.c
+++ b/fs/hfsplus/super.c
@@ -328,8 +328,6 @@ static void hfsplus_put_super(struct super_block *sb)
 	hfs_btree_close(sbi->ext_tree);
 	kfree(sbi->s_vhdr_buf);
 	kfree(sbi->s_backup_vhdr_buf);
-	call_rcu(&sbi->rcu, delayed_free);
-
 	hfs_dbg("finished\n");
 }
 
@@ -629,7 +627,6 @@ static int hfsplus_fill_super(struct super_block *sb, struct fs_context *fc)
 out_unload_nls:
 	unload_nls(sbi->nls);
 	unload_nls(nls);
-	kfree(sbi);
 	return err;
 }
 
@@ -688,10 +685,18 @@ static int hfsplus_init_fs_context(struct fs_context *fc)
 	return 0;
 }
 
+static void hfsplus_kill_super(struct super_block *sb)
+{
+	struct hfsplus_sb_info *sbi = HFSPLUS_SB(sb);
+
+	kill_block_super(sb);
+	call_rcu(&sbi->rcu, delayed_free);
+}
+
 static struct file_system_type hfsplus_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "hfsplus",
-	.kill_sb	= kill_block_super,
+	.kill_sb	= hfsplus_kill_super,
 	.fs_flags	= FS_REQUIRES_DEV,
 	.init_fs_context = hfsplus_init_fs_context,
 };
-- 
2.52.0


