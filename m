Return-Path: <linux-fsdevel+bounces-60861-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E169B523C1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 23:47:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B30013B47F1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 21:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 942AA3112B0;
	Wed, 10 Sep 2025 21:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N8kFZ+rM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8700D30F927
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Sep 2025 21:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757540823; cv=none; b=OoY9ZM+EYFWPk1IGBIYEZc2TLEQfcfy1nhGKmZt4rLV5S6AA/1Ruyow1f7gangVx3/xS1rN8QRWrlpe65mclOYGq8niC1zqVEdcT1PS9O837JOEbzKuxnkXdxq9Ap2L9cZ72o6IyGG+jcduU1EUH8v77PEljl/7/H6Sqw8UOKuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757540823; c=relaxed/simple;
	bh=N1vu5A1ZRCFHnhrDrtQSS+sG1PdI8dtEJ7gEJSlJ2a8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FsUWPGgXc9c4hwXNw2UcZcIiEJgBhZgVlHhZzLPccJ5ynrbo0oU38B9Os6/aT7/2V/msAntyqwEt5buagIIbW9VR0nAWrtK0Uy2C6ckBusFN+fBg44CBvPRumJNsPXaznD+oe7gKRJU2cQy+oFGNDCXmLgT7SiRpT2ARCILFD9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N8kFZ+rM; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-77256e75eacso82407b3a.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Sep 2025 14:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757540821; x=1758145621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jh1PVWcfGklaWv+aRqcKqBvGWRMB1ZgPcYyyYXlyxeU=;
        b=N8kFZ+rM1tVBGEpDjPDRLuoXoLTBb3Ert5R9b/JUD88kJvwhY+wyo9t6dT4Vd+DFlG
         UNrGEeFtDYYAd6fN+ZuWPkNZ6vr7XPVSK/6GZnxminO4JDB8KwW7qebXZQmsJLA/n1dq
         DoBx3T+hiXkvF1wBUSlqm6iKyAcda4JHpaXvI8FFstrsZuVrq50kxKuiD108e8QXqiFD
         IvzuPrNbtUoYxmjrqaMXL3aTPsXuaJsH/BNMyrT1L+R+p1LZxFLrbk72C2IiMXmxQfG3
         2hfwrsCinFl7DYrdyT5UDdqoQrU59fGUVCtGvOq8V33hEoEzk6M76yis5nd26kbiZMTz
         29Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757540821; x=1758145621;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jh1PVWcfGklaWv+aRqcKqBvGWRMB1ZgPcYyyYXlyxeU=;
        b=fHgsdTmd7QjFi24KL/m0VrZGPvE24fwv37puQRI5KBurYYE71Yd8agr6s0FDBoY/JF
         GKXkgHgBd8vARGGuZFaEOkgOAkH4XY9y8TZQoZlI374/t6/+//GD6JRcZCnZMOY3xYt4
         nDo1mpCn2Cqr7jJUDL6jBnhMgP+m4pn6LkCnAgjWBBF/8GO6S66aRCXxuZLx5oM/Yczz
         r3P2xeKC+tHYA5AQyFU/USvxDax/NUog8hIMTbXq4lsiMj0ZdEhkgH720uNXGhuJY27e
         T8rEonQY4RsuNP5U9PMYbZ8AaC7UlKe86Fg3C709sPx7i2vGddqr1tB/jvqM1NdRpFw9
         vecw==
X-Forwarded-Encrypted: i=1; AJvYcCUZP10B2LrqRdy9XLWHR838dagb5KyYImwbg2wysFDl2NVwpr3nhWR/BH6mehznlWVv14TXjlhpDPm9vYor@vger.kernel.org
X-Gm-Message-State: AOJu0YzJaT6pfPZsolPnK+pPJIdGYvuAlkQF2okT+0SV1i8rt9udbkWy
	9PH3Xune18i4uoJGd+6d89GcktGUg53Q/A+UKS+re7VchgCQFRjlj+Eu
X-Gm-Gg: ASbGncs6YIWhqd677PvzW8921t59Bv4chLsO18qAlg5ebQhGOrnm427pFf0rTq2Vqw5
	JWz7u6WZ5MiiI1sEZWFpaxaT3ARERAheXfKgkAJGdHNuZVgGKH2OyNUfHH8e4MuciPEfqvUbxdk
	LFHpc3yIe+KQ1ILZWLtmHARZEsU/4YWHajM8cSnm6AYB1R3qKqYaYwhUGlnhIkhS1HGZh+Au2GQ
	DgwTY6bvrQb0/m1W2cEE7XM61+32LHnBjfLYX+V+jBQA/Kz443znik08dV+rYsCsdtDUSdtOtnt
	ORWsgCgbywnayaWRKn1KWLYJB9Z7PZOXqkU+nSxADK/dDDJNdGnziqN36+3mjFReKlk5oeyS1NL
	Hv7rXVHtpHQsb6D2t7ynK91UwOw==
X-Google-Smtp-Source: AGHT+IHg4ns4GkmdZ6pzmsU1/aewjLF9oDtwhywGlNT90Gumf5P4l0ty5klyFIatdkwk619z24neag==
X-Received: by 2002:a05:6a00:3c90:b0:772:f23:f9f with SMTP id d2e1a72fcca58-7742ded55a4mr20159233b3a.29.1757540820798;
        Wed, 10 Sep 2025 14:47:00 -0700 (PDT)
Received: from jicarita ([65.144.169.45])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-775fbbc3251sm2422516b3a.103.2025.09.10.14.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 14:47:00 -0700 (PDT)
From: Thomas Bertschinger <tahbertschinger@gmail.com>
To: io-uring@vger.kernel.org,
	axboe@kernel.dk,
	linux-fsdevel@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	linux-nfs@vger.kernel.org
Cc: Thomas Bertschinger <tahbertschinger@gmail.com>
Subject: [PATCH 04/10] fhandle: create do_filp_path_open() helper
Date: Wed, 10 Sep 2025 15:49:21 -0600
Message-ID: <20250910214927.480316-5-tahbertschinger@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250910214927.480316-1-tahbertschinger@gmail.com>
References: <20250910214927.480316-1-tahbertschinger@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This pulls the code for opening a file, after its handle has been
converted to a struct path, into a new helper function.

This function will be used by io_uring once io_uring supports
open_by_handle_at(2).

Signed-off-by: Thomas Bertschinger <tahbertschinger@gmail.com>
---
 fs/fhandle.c  | 21 +++++++++++++++------
 fs/internal.h |  1 +
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/fs/fhandle.c b/fs/fhandle.c
index 36e194dd4cb6..91b0d340a4d1 100644
--- a/fs/fhandle.c
+++ b/fs/fhandle.c
@@ -402,6 +402,20 @@ int handle_to_path(int mountdirfd, struct file_handle *handle,
 	return retval;
 }
 
+struct file *do_filp_path_open(struct path *path, int open_flag)
+{
+	const struct export_operations *eops;
+	struct file *file;
+
+	eops = path->mnt->mnt_sb->s_export_op;
+	if (eops->open)
+		file = eops->open(path, open_flag);
+	else
+		file = file_open_root(path, "", open_flag, 0);
+
+	return file;
+}
+
 static long do_handle_open(int mountdirfd, struct file_handle __user *ufh,
 			   int open_flag)
 {
@@ -409,7 +423,6 @@ static long do_handle_open(int mountdirfd, struct file_handle __user *ufh,
 	long retval = 0;
 	struct path path __free(path_put) = {};
 	struct file *file;
-	const struct export_operations *eops;
 
 	handle = get_user_handle(ufh);
 	if (IS_ERR(handle))
@@ -423,11 +436,7 @@ static long do_handle_open(int mountdirfd, struct file_handle __user *ufh,
 	if (fd < 0)
 		return fd;
 
-	eops = path.mnt->mnt_sb->s_export_op;
-	if (eops->open)
-		file = eops->open(&path, open_flag);
-	else
-		file = file_open_root(&path, "", open_flag, 0);
+	file = do_filp_path_open(&path, open_flag);
 	if (IS_ERR(file))
 		return PTR_ERR(file);
 
diff --git a/fs/internal.h b/fs/internal.h
index ab80f83ded47..599e0d7b450e 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -366,4 +366,5 @@ long do_sys_name_to_handle_at(int dfd, const char __user *name,
 struct file_handle *get_user_handle(struct file_handle __user *ufh);
 int handle_to_path(int mountdirfd, struct file_handle *handle,
 		   struct path *path, unsigned int o_flags);
+struct file *do_filp_path_open(struct path *path, int open_flag);
 #endif /* CONFIG_FHANDLE */
-- 
2.51.0


