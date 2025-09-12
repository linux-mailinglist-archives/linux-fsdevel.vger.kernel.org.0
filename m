Return-Path: <linux-fsdevel+bounces-61101-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A91B5536C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 17:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 119321D67C9C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 15:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95BD8306490;
	Fri, 12 Sep 2025 15:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gEDig6fp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E32322154F
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Sep 2025 15:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757690871; cv=none; b=DZMaZp9SSeR63qeFZ7V/xJhlDMTPS1LktQH27oW29FZXkNvBdcx7UiTloFykDxaw/cN8ZmRWgR/gLokvxHNe5lnr2pxl4BmfspGRhGQqkv/31Cwi8CRitgwaurmbRWgcmjlBoaNW3mtgKHQxHNvaVdDPWzO1OixQEj9sWbv7zg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757690871; c=relaxed/simple;
	bh=pmMDoEW+oO6NL2w9YRn5t+RQpBgWvTuhGRDXZtqEIwk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sDnUMFXIPaQKdagFz7yR1DYksViETpt4qV5zrJQT/aEIQrqrhtPR9EAsBILHOE00LFwCksu1tbKZomzzl1VOOpssUsqT4xxJqyvhHP2G6HqPChLGXhD3bcN5SugJ5NaxON+MWA0S5RC7fhWTbj680HdVQjE2TGHARa4NUBccbZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gEDig6fp; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-772843b6057so1890073b3a.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Sep 2025 08:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757690869; x=1758295669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p/p4DhcfzaoqYKW7NX5I6Kjl5Br0oWLxcOQkA5oMQX0=;
        b=gEDig6fpjxxEdIXJ9Fk4lTh9w4ldfhj/ZgU6M7Kp/b/gvE3JZENNaj1pUTNgt7xY3t
         U5MpTD3H9E6KNWvlZaq8Ms7679rMtVZMqH06nNcil7zSKka86VqrlsmRlqmMvYfuFKAh
         KoIznQx//xaUtpY3ch9jUpo2LwvW0cXckT6KPyNDIvJUH13Rp9aSTuLDIjMnyOZ5i/19
         LlJ3tXuXr0+GQu3DckvzrLULQqO/rzd99YyPj2M3CCtTqgxb+AOIXyPj00B5dfCWculu
         86TPXlSeE0oOwmiyHyinRDt+Kxxiy/AZWook+xmM8ReDUl3ZbT4iQ1HmzIYTYbUHgDsA
         J2gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757690869; x=1758295669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p/p4DhcfzaoqYKW7NX5I6Kjl5Br0oWLxcOQkA5oMQX0=;
        b=qwG/kMBS1Qkd0kW9kFAjkPaFfBwGK8EfzvDgOeLZmExwGKb05jmAmnOvVurKXpetaj
         /T1iUbE/rxDWILZ5+FzyQNQKoXTZUlUjxqtuXX3gKsLfRDs4JSBoxmeDC4YO+4sX60tV
         izhVfYsi8FOZaCrFY8siJmxyPdR3YAXLqhQlwaICB64vjJs1MGQoJzsSmLipuqDXgMIu
         vdNgq7hmLgIIZWMFF/LpyZkPdtdts84Tw8KddIA5XgTr2wk5GH3icTu2CaOuaw+J/Y4Y
         oiy47mMguCd6QiCW5U2XO/Arv1e0k3DhsF43KnuKSw4YIsaCRCZ9MQqVcIuKNiSE1l6D
         hpSA==
X-Forwarded-Encrypted: i=1; AJvYcCXG52pKSmzjDqBVdJ9MwZCpwg8sWIKmftZzIK58kyKmnpIEFAflLNO26z76NKGy9gGhsg3F4FlHhRaG3+cO@vger.kernel.org
X-Gm-Message-State: AOJu0YycglABgnKAYF0bIFnrf9L2hMPX0Wjy8E/wB2jWe7LI9GdnWqQj
	MSaUvSXtCc7pik/kYRaLQQVykbgRXuZwJsDMXKEfo66LIfyj2fgBhg3H
X-Gm-Gg: ASbGnctV7HtJFZ7R8j8Gd8ol2vxrNnp7n1UjLLKqxpEcDfKH27JYD/utenulgDwHUpR
	twoqzbmtKktCwT+vB7DcuGTB5MdxQPR5mehGGGgJLUhku4Px0dU2kaTRgbPSDmDQA5D2Z2j876l
	Fwmag8b07/H1RVd/1aWgpuYtwIBDbPQv4YIov9v03p+Xryg4OzUYR0VbE6RH7TqQ92PPkuInYE/
	Pu0wuV4vJbmMlR9+7mT5TFERnLAmy3cH5DVLGRqW6bNmZO+w6dIlTCdVCuZiljfviJy+xbOtMkh
	woFOxdWkkZLPEDuVsK9abdwAvT6w+sricuSth8P6X6ExChUu0dF7GiN09S+NtXyQGb2DQz6yQyV
	l7yaWguZmamN5EDdjooKBUNbpeZ3fOzrPr0Oi
X-Google-Smtp-Source: AGHT+IGs3yIVWaat/rUFcK1EaLvHFVa8kOg9uz8wfMp0/qrqY/TeqHTSh3FvdzrPbbu2Kju5zfv5ug==
X-Received: by 2002:a05:6a20:7d9d:b0:249:467e:ba6d with SMTP id adf61e73a8af0-26029fa1cb8mr4339715637.6.1757690868839;
        Fri, 12 Sep 2025 08:27:48 -0700 (PDT)
Received: from jicarita ([65.144.169.45])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7760944a9a9sm5436846b3a.78.2025.09.12.08.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 08:27:48 -0700 (PDT)
From: Thomas Bertschinger <tahbertschinger@gmail.com>
To: io-uring@vger.kernel.org,
	axboe@kernel.dk,
	linux-fsdevel@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	linux-nfs@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	cem@kernel.org,
	chuck.lever@oracle.com,
	jlayton@kernel.org,
	amir73il@gmail.com
Cc: Thomas Bertschinger <tahbertschinger@gmail.com>
Subject: [PATCH v3 05/10] fhandle: make do_file_handle_open() take struct open_flags
Date: Fri, 12 Sep 2025 09:28:50 -0600
Message-ID: <20250912152855.689917-6-tahbertschinger@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250912152855.689917-1-tahbertschinger@gmail.com>
References: <20250912152855.689917-1-tahbertschinger@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This allows the caller to pass additional flags, such as lookup flags,
if desired.

This will be used by io_uring to support non-blocking
open_by_handle_at(2).

Signed-off-by: Thomas Bertschinger <tahbertschinger@gmail.com>
---
 fs/fhandle.c  | 14 ++++++++++----
 fs/internal.h |  2 +-
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/fs/fhandle.c b/fs/fhandle.c
index b018fa482b03..7cc17e03e632 100644
--- a/fs/fhandle.c
+++ b/fs/fhandle.c
@@ -401,16 +401,16 @@ int handle_to_path(int mountdirfd, struct file_handle *handle,
 	return retval;
 }
 
-struct file *do_file_handle_open(struct path *path, int open_flag)
+struct file *do_file_handle_open(struct path *path, struct open_flags *op)
 {
 	const struct export_operations *eops;
 	struct file *file;
 
 	eops = path->mnt->mnt_sb->s_export_op;
 	if (eops->open)
-		file = eops->open(path, open_flag);
+		file = eops->open(path, op->open_flag);
 	else
-		file = file_open_root(path, "", open_flag, 0);
+		file = do_file_open_root(path, "", op);
 
 	return file;
 }
@@ -422,6 +422,8 @@ static long do_handle_open(int mountdirfd, struct file_handle __user *ufh,
 	long retval = 0;
 	struct path path __free(path_put) = {};
 	struct file *file;
+	struct open_flags op;
+	struct open_how how;
 
 	handle = get_user_handle(ufh);
 	if (IS_ERR(handle))
@@ -435,7 +437,11 @@ static long do_handle_open(int mountdirfd, struct file_handle __user *ufh,
 	if (fd < 0)
 		return fd;
 
-	file = do_file_handle_open(&path, open_flag);
+	how = build_open_how(open_flag, 0);
+	retval = build_open_flags(&how, &op);
+	if (retval)
+		return retval;
+	file = do_file_handle_open(&path, &op);
 	if (IS_ERR(file))
 		return PTR_ERR(file);
 
diff --git a/fs/internal.h b/fs/internal.h
index 0a3d90d30d96..2d107383a534 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -366,5 +366,5 @@ long do_sys_name_to_handle_at(int dfd, const char __user *name,
 struct file_handle *get_user_handle(struct file_handle __user *ufh);
 int handle_to_path(int mountdirfd, struct file_handle *handle,
 		   struct path *path, unsigned int o_flags);
-struct file *do_file_handle_open(struct path *path, int open_flag);
+struct file *do_file_handle_open(struct path *path, struct open_flags *op);
 #endif /* CONFIG_FHANDLE */
-- 
2.51.0


