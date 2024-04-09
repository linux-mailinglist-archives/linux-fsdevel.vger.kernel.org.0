Return-Path: <linux-fsdevel+bounces-16502-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F2ED89E617
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Apr 2024 01:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BD3C1F2250E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 23:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56659158DC3;
	Tue,  9 Apr 2024 23:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UUYYXGIp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049D2158DBD
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Apr 2024 23:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712705510; cv=none; b=sE+xtwTskFaYTkfWfCbyleejjBLnBt12VzWQmgXpVLD2x1POGig0eO689kKNdUxyZj4uP3TnViyWgnhvEmp4fWKpCiyf2UzpYZGmrLNybKI2D8pgX/y98Us++v9Lkdh3W+hEWIKNFmmiMGdaHQ67JbJ/bw61RNUZB8Ljsf2cqQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712705510; c=relaxed/simple;
	bh=J8WPSkloWpZ1xnPhvjig0oF32O3TWol42AIRTiT7h/U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I2ndYv/uvZn8ENcAeBMdKnoSQ+w4Q08aqpJSYxqe7YgbiSutV0u56Gp84ivvFbu4zKkLxcIVOrhrUau4nU7koCZ7WpeU/BkmpG98PQB4XrOY4jzQYB4jUZCIfftfVwpPK05BUjXSviardBiQcbaXuN3OXCyZT9LDSdSFKl0vIFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UUYYXGIp; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6e6888358dfso3706941a34.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Apr 2024 16:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712705508; x=1713310308; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pThfWeZnZjnSsk4esynnYrwJWWrvYDk078WWQy4/lmg=;
        b=UUYYXGIpP5pBR7T5ZWv9LFrWFXHneg32UI6E0ENudxdK4vQROeB/dXABOsK0rKksSu
         iqwoMrCFsPwgpiJ0TseKfRqvaORxQxJSLCjHo5t1diTeo9hBLP/u8L+h3US20/SWA8Bg
         JGS5h8/73kYHlUbZ0GwRjLfnWl1qT1Hm9nwZ1SM4JBQ8UPADGxq6S/HbFBreGpqynEdX
         IM/D7/lACnWeyU7qhwFDxtoysmTNyKHDPXtlGSvxYvKUBs6Or7yGRAdZZBGYujsgPaQu
         42lzoLbHalDSrBZcA3Rb02y1SJWuYADhN7W5jDft4d5Cj+1VeDdvQWfWoV7260SxQVEW
         0L/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712705508; x=1713310308;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pThfWeZnZjnSsk4esynnYrwJWWrvYDk078WWQy4/lmg=;
        b=nNbohAXDU3JrbByHbbBBq+LDupgbQTDXD9Aka6pSj+YBUEslxUM6nE2yVioVObdFYD
         d0tnR+xHjLNxsWta5sDgrKd2Uy9cPWX7IyHSK0FTli5VNi8uHSrH3hz7Ma65DBjMJbh7
         qtp+yiq/yQLTKopvJ6jlcdXoKvHzsOoNw7Y+J0SREM7wGGsFG6waegLoz/4S7uaEgA0U
         Lsu7K38pgpY374LbSY9UtZcqtMBUertSiXmBGe+pMQbb0d9esBPzw05JVKDRaESYwgn6
         KrTolC0scXARLP1uDmXCz57Xbvt01LXrC911Bk2dtllzATGQ71DN9wZbcvk/6YJGIsIz
         yYaA==
X-Forwarded-Encrypted: i=1; AJvYcCWQGE2KTPtVPgVrHcdqXk9/VPmhtIGlcwBtno5Cff+cLQnH88E7EBSUDbPZCEMitjRld9jmRIcn2lN7F6OkoBpjbrRM8hgUXjlh3Z/CvQ==
X-Gm-Message-State: AOJu0Yw8Io96kRSp/S+0o1aW03zxVPfefR7wvPWnPBinsBlkouu/fJIk
	sIN4IvvqP74ezP+9Zt6uzhYm8XeC+V6rn0xCJZy3U9PLvIiEKTJ1
X-Google-Smtp-Source: AGHT+IH9EF6VZZGIBwKSr1xguSgM1qYP38IIy4u5xxcLr1R6NZDs3LXIX38DOlxqS2P5lNXpgRHzAQ==
X-Received: by 2002:a05:6830:6d18:b0:6ea:30b9:c778 with SMTP id dz24-20020a0568306d1800b006ea30b9c778mr704760otb.24.1712705507995;
        Tue, 09 Apr 2024 16:31:47 -0700 (PDT)
Received: from localhost.localdomain (070-114-203-196.res.spectrum.com. [70.114.203.196])
        by smtp.gmail.com with ESMTPSA id a14-20020a056830100e00b006ea1a31bbccsm852909otp.77.2024.04.09.16.31.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 09 Apr 2024 16:31:47 -0700 (PDT)
Sender: John Groves <grovesaustin@gmail.com>
From: John Groves <John@Groves.net>
X-Google-Original-From: John Groves <john@groves.net>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Cc: John Groves <John@Groves.net>,
	John Groves <jgroves@micron.com>,
	john@jagalactic.com,
	John Groves <john@groves.net>
Subject: [PATCH 1/1] sget_dev() bug fix: dev_t passed by value but stored via stack address
Date: Tue,  9 Apr 2024 18:31:44 -0500
Message-Id: <7a37d4832e0c2e7cfe8000b0bf47dcc2c50d78d0.1712704849.git.john@groves.net>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <cover.1712704849.git.john@groves.net>
References: <cover.1712704849.git.john@groves.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ref vs. value logic used by sget_dev() was ungood, storing the
stack address of the key (dev_t) rather than the value of the key.
This straightens that out.

In the sget_dev() path, the (void *)data passed to the test and set
helpers should be the value of the dev_t, not its address.

Signed-off-by: John Groves <john@groves.net>
---
 fs/super.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index 69ce6c600968..b4ef775e95da 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1308,7 +1308,9 @@ EXPORT_SYMBOL(get_tree_keyed);
 
 static int set_bdev_super(struct super_block *s, void *data)
 {
-	s->s_dev = *(dev_t *)data;
+	u64 devno = (u64)data;
+
+	s->s_dev = (dev_t)devno;
 	return 0;
 }
 
@@ -1319,8 +1321,10 @@ static int super_s_dev_set(struct super_block *s, struct fs_context *fc)
 
 static int super_s_dev_test(struct super_block *s, struct fs_context *fc)
 {
+	u64 devno = (u64)fc->sget_key;
+
 	return !(s->s_iflags & SB_I_RETIRED) &&
-		s->s_dev == *(dev_t *)fc->sget_key;
+		s->s_dev == (dev_t)devno;
 }
 
 /**
@@ -1345,7 +1349,9 @@ static int super_s_dev_test(struct super_block *s, struct fs_context *fc)
  */
 struct super_block *sget_dev(struct fs_context *fc, dev_t dev)
 {
-	fc->sget_key = &dev;
+	u64 devno = (u64)dev;
+
+	fc->sget_key = (void *)devno;
 	return sget_fc(fc, super_s_dev_test, super_s_dev_set);
 }
 EXPORT_SYMBOL(sget_dev);
@@ -1637,13 +1643,15 @@ struct dentry *mount_bdev(struct file_system_type *fs_type,
 	struct super_block *s;
 	int error;
 	dev_t dev;
+	u64 devno;
 
 	error = lookup_bdev(dev_name, &dev);
 	if (error)
 		return ERR_PTR(error);
 
+	devno = (u64)dev;
 	flags |= SB_NOSEC;
-	s = sget(fs_type, test_bdev_super, set_bdev_super, flags, &dev);
+	s = sget(fs_type, test_bdev_super, set_bdev_super, flags, (void *)devno);
 	if (IS_ERR(s))
 		return ERR_CAST(s);
 
-- 
2.43.0


