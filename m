Return-Path: <linux-fsdevel+bounces-69008-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CA529C6B303
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 19:22:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D28334E2DAA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 18:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F9C3612E6;
	Tue, 18 Nov 2025 18:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ISEStpCD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4586C330323
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Nov 2025 18:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763490159; cv=none; b=PKJEV6TGBxlko8pnS4nQk6uDuAQGrZY7Hq7PaQ555mnNSL00LBcyEW0//b3BpMIZ2r8g5HyLiO+96A+/zYXif/4HI4VZ1zxu4gGMng/5WS3aFbyD9aw/lFWlv8kHwmrm+F7Y0wVfkKLoXfwLxCSOrJtPuAxtZZHQx/3U8Rqekuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763490159; c=relaxed/simple;
	bh=J6QpUVaBN7ELwTVyLXvuU4LTNlx718jbhoIxJj0L/R0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gz/fRIRL7YTZstdrI4AC3fBB2m6ws1BvGNmI9KaS9dMAmzEVRby/s1czEVZfxDu+4ZIWxsJH9eAYB3zqycb/MfeTjJbCZ82zcD0qQBeD9rML8+riBxORLnJkJQRjdoIHnwe7PxvslrNCBcd+yZnWJ/EjD86xE+L6lh7rJD+diys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ISEStpCD; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4779b49d724so3914385e9.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Nov 2025 10:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763490155; x=1764094955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sjLmqO/zAiu0IkPhB8Ik8VNVezTV8p8dxDm9h/l3wGY=;
        b=ISEStpCDYC8sQTB0upIwfxHgg6MZ1j5dySnBxd9hy8l1dz5AmVvtYG30xwEwTymaQN
         aCf6mMpZnPRNIlXoPMx43evvGLbIZsL3hO7msshd2R51efBv+EhL7BzR9AWzYN6tb17L
         rSOGdJjtssZ6qgzmR5ljmTIRE7bJJB/jS+mguGzTFYHeMbGqDYPmtc75coFKZLc9jHTd
         RceztkLVY+J+Flw3sWlXIy6zmYqRjYFwjWDxWRnUDvx8p5u74qocCPIo+ptCMkFgzfJi
         E2skfhDAJYeDnIs+ndcpREbrunRgzA5daTyJ9Gd/ZE7gtC9DTvit7NnVqIR+bvU6h16O
         j/pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763490155; x=1764094955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sjLmqO/zAiu0IkPhB8Ik8VNVezTV8p8dxDm9h/l3wGY=;
        b=NIldHEstEHwbnJVT0o+x6gc6CFaQTTmgIVoeUoU3xCIiDLfTlncUVVog42rFZJGHFe
         I6nzpJTTZiip9CQ+eMDxhqo4n5aL+T9aUzGwRBjJv03rXfd/a2s4Co9KyTVY31JxuFtr
         CQjVpMhw7TCSeTf9LEVOtOebFluVpnqXfRMCIj2y7wHGehQ4U3GyTRb2rsfgZ2SA4URw
         JhrxK2oNJOOBek6sggljcKLXrZNckI8m98M86SO3no3aNecrdH0hiNPYHO0+HI9S2qD3
         dh5OpZxqciSLsRScDMo/4OnWuoUf6w5EeBXgJXCeWskusPolYnoZw3UxTH9lkmI2wZsO
         Lhog==
X-Forwarded-Encrypted: i=1; AJvYcCXqC8s3mz5e9ulZ91oyMFX16d53ImUdIz6tduqy7ee2RDZ9FmWlLHfxK0sqmuxetdPEgN5K8TcIHyevtggf@vger.kernel.org
X-Gm-Message-State: AOJu0YwjNzmAHg/En0Ya9hn5pQQK5GyYsWtBK09BH1HnbTVbRHvtOX3z
	JDxJS0eqsNFbkgR6Gf8n2DNZFTrWQVMhU7FIvJ0mbYC1KuI2a3KQoz84
X-Gm-Gg: ASbGnculbmzXiuT5Tvl6m1cUw2QVdmBFKO40UE8cDaUwq1LjcRaitIvx6u4kEbfaFw1
	GGQCGIsepblyVEKgsCPRddYvum91eKGgk2WBlsWS8Kc7AOEuZDOMI+Mxg2d3p2bUWzwft665osI
	4lkJjJVYTao5OYW46Zv5DFFvdv7++i6XUA9+kYqyFD0pUVzePTe9H0TBTc6BmMl26KNPVvcMVNa
	noNmNleGvVbCrAyv6KLawwnwEIIHUJr5UryS/l5NBV4kWn/nkMBdurhBkzBHmuCboyRmtaBfx9X
	lpnb9IDibesW+xwMNYSeYhxpZ+yYvxS9B5yKk8KXlGwUX55Ck3OOhe2MRCofjZI5gohP41J5zBO
	CzMagSR8pZuagomh0Q4mlF/y7ni5+e6tBoqMRdPT7Fy0rXCmVNajK4lGmazXE5Uj8WCrj3lVsGQ
	ZOXeZCpQV19kceWw==
X-Google-Smtp-Source: AGHT+IEmJCet1pBjWipxvPuVvaiy1pTZKeMhZWLkNjdzwqgxnfUgnaa0Yu0wYBrDWCqbtIkCJjNvXQ==
X-Received: by 2002:a05:600c:4447:b0:477:a16e:fec5 with SMTP id 5b1f17b1804b1-477a9a6f3c4mr19146465e9.0.1763490155225;
        Tue, 18 Nov 2025 10:22:35 -0800 (PST)
Received: from bhk ([165.50.73.153])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477b103415asm3751465e9.10.2025.11.18.10.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 10:22:34 -0800 (PST)
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
Date: Tue, 18 Nov 2025 20:21:27 +0100
Message-ID: <20251118192209.70315-1-mehdi.benhadjkhelifa@gmail.com>
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


