Return-Path: <linux-fsdevel+bounces-69043-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 40BDCC6CBF0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 05:32:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id EE6972C66E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 04:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBBF93043BE;
	Wed, 19 Nov 2025 04:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RzNCpV0Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2591A303A22
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Nov 2025 04:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763526747; cv=none; b=kJ0B3yCcfHKaBsw8YsG15fsL6N9+rERV0EtgXpc0zOlsmaGNfVVzmjORLezvMsNxF/GC2bN2ImOy8ymHWVbYnRNDSnq8C2sLS4kweg/wynOWPYd4aWUhpkfEU6ibbjXN3I08eYQ/c82ze0wawJVmVDQzOTbFyMy3S1OwfW3GY94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763526747; c=relaxed/simple;
	bh=J6QpUVaBN7ELwTVyLXvuU4LTNlx718jbhoIxJj0L/R0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aHAcW9/KYMyC52N4MIDuZ2OJHW2S18iVfKP/wo0qMsS/lkHkhKAvHSrn7spvxiyXf6mjTPaH46Wk3lwbN0PwzA1b8ZLErSvMMY2k2ko0jgdN8dN4MulqL7CEB4kU8P5F2ArJwnOtLdvEmHNGgADvmHvgqBNcB+t+o8k5Fn+daWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RzNCpV0Y; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4779b49d724so4564705e9.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Nov 2025 20:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763526743; x=1764131543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sjLmqO/zAiu0IkPhB8Ik8VNVezTV8p8dxDm9h/l3wGY=;
        b=RzNCpV0Y6NZTOkAJgzm3Sn6sWDwgTFldIxa6CadYeX176nanaPIKacruH4IXEyqXJB
         neJ2dwwdOmjUVijWbCexPFnMhsMmhHPH1UjFs+tohS6I48libgBbEDrXiYq4qswLs0lR
         zJlJQQgDg7qmEq32PM6/K9jYoX3qAVeRAGzYCQym+IJ4tbAkst7TMtHmRwY4V6rlT1R6
         RHqH0D9wRCmRxrh0p9fRUUIXEJF+fviF/twFmG31bMXrMMuKnPHxfW3Zz0SeFSS1b6J2
         D33WOcWqOtAUSPhLdLh1Nv3fRkhXyVTZ9clATG0wXHAakYXDrSyxPbuWZU/Y9oCSQ9eU
         i9ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763526743; x=1764131543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sjLmqO/zAiu0IkPhB8Ik8VNVezTV8p8dxDm9h/l3wGY=;
        b=kc6DeWVV/rnvW3G2hE4Tcye+qKLPw8iTCLeTRXwjZIKFprSEBaodJMgfyBqmkPD+0I
         WMf8i9ldOCJQxfzvnhWFYrXCRaoAoTcW4BgmURKs4uFknW8fduWO+7Im8GbKgKzHgRZW
         aeEpuDCYFP1UXjMrZ//pzkJT8Oy9gg7PekfHuprWRMskQ00HPV8mL1w5HatFV1WSlkQV
         cgINYCVXvQi21ab5y4pxc2VaDWeKF+nfNnuHNM0PyM9sBxMLLmm+InblFeb8swGRA9g4
         RVgPTFlQhN4xOkjsq6YDbgqSun4DwtPp3XV7dXkMXXf2Bg87ESV9X/niR8WNl4ocgrVZ
         d8wg==
X-Forwarded-Encrypted: i=1; AJvYcCUtkOZf6Teii42QMHca6pvuhuQPuz5K0uNL21GqtYWqqZPKOkMtau8tQHYXapah7K4vKhWr0nDyX2gaApGR@vger.kernel.org
X-Gm-Message-State: AOJu0Yyer+OeO7ctCJlO1mazPyd/blTfko/zQRggFrKTN8LKJnbiJdYj
	u+ACgqbGARZwT/pz37FKIv6+FqRvMGOuFiV6n1T3X90B2QaXe1szAFSu
X-Gm-Gg: ASbGncvCY3hwDyTjfgQ/iiKMJnoWPu28NzFEoS5UB6MDuwVrWQW2ySOAvVEe/1cYXOf
	TuExuwKWKy0CD9E0FzZzVBpsW3h3Kv2Dy/uScHaGBpx+SRl1xbfLKbRavstVVC9wbVpd/Dl36jX
	3rmklrNl+tvvcTPnW0rtzxw38qpRGeEKVntajTGyWq8Jm2HZLoqxNCpoFM6nA9bUHplVBEqVBBY
	c2EKJF97EpdeR6Jlo2hzoXhLNyirW/USmx4K6cwdHEA6JJwQUPSX0/r2wIwQnCBGjtSMeAZInMs
	omfbS7Ng/Y2j4RZm6ZVcDOtlCryBqzrxdj96UhxCP2x7ZncPFOBrxs+5On7hHZvIB4B+P1wLa+g
	vxEcncJBvUAcgai0AP3XOpcnZ+n+64olworYwC1zYZQJvsvWN2NAAHUSj1beYKVSpiO36Cg1G0H
	jN0c+4WN6EnAw9DDg=
X-Google-Smtp-Source: AGHT+IH9h7L8UGbkTIf/vhce/CGqiB2jS+9MochxYSfFOpcpEv5k/l1SvklqjJmKWtJeC1L76MRaUQ==
X-Received: by 2002:a05:600c:1c24:b0:477:a450:7aa2 with SMTP id 5b1f17b1804b1-477a9bdb645mr30738265e9.1.1763526742941;
        Tue, 18 Nov 2025 20:32:22 -0800 (PST)
Received: from bhk ([165.50.116.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42ca01b074csm14959251f8f.34.2025.11.18.20.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 20:32:22 -0800 (PST)
From: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
To: syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com
Cc: frank.li@vivo.com,
	glaubitz@physik.fu-berlin.de,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	slava@dubeyko.com,
	syzkaller-bugs@googlegroups.com,
	Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
Subject: 
Date: Wed, 19 Nov 2025 06:31:51 +0100
Message-ID: <20251119053201.2949-1-mehdi.benhadjkhelifa@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <69155e34.050a0220.3565dc.0019.GAE@google.com>
References: <69155e34.050a0220.3565dc.0019.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test

diff --git a/fs/hfs/super.c b/fs/hfs/super.c
index 47f50fa555a4..06e1c25e47dc 100644
--- a/fs/hfs/super.c
+++ b/fs/hfs/super.c
@@ -49,8 +49,6 @@ static void hfs_put_super(struct super_block *sb)
 {
 	cancel_delayed_work_sync(&HFS_SB(sb)->mdb_work);
 	hfs_mdb_close(sb);
-	/* release the MDB's resources */
-	hfs_mdb_put(sb);
 }
 
 static void flush_mdb(struct work_struct *work)
@@ -383,7 +381,6 @@ static int hfs_fill_super(struct super_block *sb, struct fs_context *fc)
 bail_no_root:
 	pr_err("get root inode failed\n");
 bail:
-	hfs_mdb_put(sb);
 	return res;
 }
 
@@ -431,10 +428,21 @@ static int hfs_init_fs_context(struct fs_context *fc)
 	return 0;
 }
 
+static void hfs_kill_sb(struct super_block *sb)
+{
+	generic_shutdown_super(sb);
+	hfs_mdb_put(sb);
+	if (sb->s_bdev) {
+		sync_blockdev(sb->s_bdev);
+		bdev_fput(sb->s_bdev_file);
+	}
+
+}
+
 static struct file_system_type hfs_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "hfs",
-	.kill_sb	= kill_block_super,
+	.kill_sb	= hfs_kill_sb,
 	.fs_flags	= FS_REQUIRES_DEV,
 	.init_fs_context = hfs_init_fs_context,
 };
-- 
2.52.0


