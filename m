Return-Path: <linux-fsdevel+bounces-20966-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DCB918FB80D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 17:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 925991F21CEC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 15:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917E2147C98;
	Tue,  4 Jun 2024 15:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k3XY6rne"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617931474AB;
	Tue,  4 Jun 2024 15:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717516398; cv=none; b=RCVmBXs/ZWlFJpruSL33mxSZqVzLyaEclFerLE2TKkP/KzZujwDIj1uEnUCGh/+/qb/rRKmv2Bc3+ZWXrEl/6oEvL5s/4TEyc/l22iZkevh4b5VEinRPkyNsVQdLfatK3qIA13m/a4jS7gkRkQp0rzvSg48WUjFTa+acd3rUKiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717516398; c=relaxed/simple;
	bh=tMBXAI4+JUxnDlQdGAtRefkZXdzUZEdU1Qfk31P+ms0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LbPLUfBhrtSa6DqDku6ZFnjireAFoOY3KpQu8vBndJfNvbkkXrz0cCw3Gqrwwhqyd5v9XFVMzgqxLqvclMa63mG0uRni40TQJdSKVmxmTRPZGvF0eDnh93qOlt5IPbMdd1z9qg27j4Mm94RBtOt6WlZTxl8o3c8QUrSVXeAe+70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k3XY6rne; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52b98fb5c32so3594006e87.1;
        Tue, 04 Jun 2024 08:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717516394; x=1718121194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R6PdKVABS3e7RwAi2tNTcCnkObTlYGjLjXFR+XzE8rQ=;
        b=k3XY6rneW9phJswCeoym4yRut8Z6vJox1iI9/Qtyv5bxTl2MyqWPrT5XZ13MyOn2jO
         ZeyutxEKx8W2HpFC8PnVq49MsWYNtuyXxqwfvJSMHC2P5egUHSSmciZ9tmobjRa/6Kim
         hs/TLdcHQGCL91PuomhgSyaHjdLv0Uva++BVZGwgQgvaY9VtON5CVSS6R5gRl4ggOwtS
         36YqsfO3xVTDtjsIpSba62sEgX0lokFj323gqWcYLUyKceWVoQkMtXDW/UC1GBB+ZG7g
         o7AJjfkbW0GMm6jgseAsS+abxoRzUSOdrGY8RIiaApf2p8kOXhu5BUyYt/tQjh9ufLd2
         uovg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717516394; x=1718121194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R6PdKVABS3e7RwAi2tNTcCnkObTlYGjLjXFR+XzE8rQ=;
        b=tIQVgfQtbjjDygrODimoPyqGTpMkevkRCTDjMBQONHuYqL8sxEo1g6uurZIklj+e/0
         0IsVpCJbQNimPFGw+AGqc4xpHbQRCQ6EgAbHMdZnQxeu6DykvtJ1gn7uUTzAtNeFIL0m
         FEGDF9msl5tOq6uRz+NjNj9Mb1UnLbQtTdZJH5PquV6jTwVDiHSagj5sj7KngvE2dIAN
         PmrcHHATcStP3t8VrDkJ0LlzEcxJRZW8WEyP3rdlxuXrKTkJUCWtfIdwYszG9JfM5IMc
         MDt2zh+2uUNpj1PMx09T802XWqiaORGgCjKQQ93dMA0NKKsf70vYr+tnzrvJ5zY3GgwT
         lkMg==
X-Forwarded-Encrypted: i=1; AJvYcCWseEDb4Yt0WeDbTfk4Oj0aghkndylZhWwC8DE6yjjcwgumSKVMwT1N92wKBeCMD+GC9YEh0TMyYv1gn1ED40oJkU6p9BSYOAPtZDnhSqFxp6tfzmYTa0Bsf6l+QvZq2nViiojU4T+tgkajfA==
X-Gm-Message-State: AOJu0YzEU2Ic3Cp5M2Fww1QIrMXHkY1wqYAkz9ImgGJSEz9QqY+HBnMG
	fAO8nC8Wgik0WtzPsuMfy4rXPHeOS6SNcg1M1FbfcYkByzAufu7k
X-Google-Smtp-Source: AGHT+IFixkhL6B2yIFzDCIiEU0g30JheVCrHFR8NduhYQFccsu8JGd7qRECjDW3EvwWRTQfxaN6/cg==
X-Received: by 2002:a05:6512:3b96:b0:52b:944c:3bb3 with SMTP id 2adb3069b0e04-52b944c3c5fmr9032283e87.55.1717516394277;
        Tue, 04 Jun 2024 08:53:14 -0700 (PDT)
Received: from f.. (cst-prg-5-143.cust.vodafone.cz. [46.135.5.143])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a68e624db7esm423380066b.66.2024.06.04.08.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 08:53:12 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH 1/3] vfs: stop using user_path_at_empty in do_readlinkat
Date: Tue,  4 Jun 2024 17:52:55 +0200
Message-ID: <20240604155257.109500-2-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240604155257.109500-1-mjguzik@gmail.com>
References: <20240604155257.109500-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is the only consumer and it saddles getname_flags with an argument set
to NULL by everyone else.

Instead the routine can do the empty check on its own.

Then user_path_at_empty can get retired and getname_flags can lose the
argument.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/stat.c | 43 ++++++++++++++++++++++++-------------------
 1 file changed, 24 insertions(+), 19 deletions(-)

diff --git a/fs/stat.c b/fs/stat.c
index 70bd3e888cfa..7f7861544500 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -488,34 +488,39 @@ static int do_readlinkat(int dfd, const char __user *pathname,
 			 char __user *buf, int bufsiz)
 {
 	struct path path;
+	struct filename *name;
 	int error;
-	int empty = 0;
 	unsigned int lookup_flags = LOOKUP_EMPTY;
 
 	if (bufsiz <= 0)
 		return -EINVAL;
 
 retry:
-	error = user_path_at_empty(dfd, pathname, lookup_flags, &path, &empty);
-	if (!error) {
-		struct inode *inode = d_backing_inode(path.dentry);
+	name = getname_flags(pathname, lookup_flags, NULL);
+	error = filename_lookup(dfd, name, lookup_flags, &path, NULL);
+	if (unlikely(error)) {
+		putname(name);
+		return error;
+	}
 
-		error = empty ? -ENOENT : -EINVAL;
-		/*
-		 * AFS mountpoints allow readlink(2) but are not symlinks
-		 */
-		if (d_is_symlink(path.dentry) || inode->i_op->readlink) {
-			error = security_inode_readlink(path.dentry);
-			if (!error) {
-				touch_atime(&path);
-				error = vfs_readlink(path.dentry, buf, bufsiz);
-			}
-		}
-		path_put(&path);
-		if (retry_estale(error, lookup_flags)) {
-			lookup_flags |= LOOKUP_REVAL;
-			goto retry;
+	/*
+	 * AFS mountpoints allow readlink(2) but are not symlinks
+	 */
+	if (d_is_symlink(path.dentry) ||
+	    d_backing_inode(path.dentry)->i_op->readlink) {
+		error = security_inode_readlink(path.dentry);
+		if (!error) {
+			touch_atime(&path);
+			error = vfs_readlink(path.dentry, buf, bufsiz);
 		}
+	} else {
+		error = (name->name[0] == '\0') ? -ENOENT : -EINVAL;
+	}
+	path_put(&path);
+	putname(name);
+	if (retry_estale(error, lookup_flags)) {
+		lookup_flags |= LOOKUP_REVAL;
+		goto retry;
 	}
 	return error;
 }
-- 
2.39.2


