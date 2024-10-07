Return-Path: <linux-fsdevel+bounces-31187-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9CA5992EE3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 16:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE40E2858B8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 14:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B05521D7E29;
	Mon,  7 Oct 2024 14:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PTr8Hvce"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BAF1D8DEC;
	Mon,  7 Oct 2024 14:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728310776; cv=none; b=luCYsVZ4AnPYagwzms9EmaK+cRPKbtbbtZTZ7WR9ohILdxRMCR0Am3HkAu7j+2WFz5iIIpTpSEXO3fqtZXo2A3tvJZT6vqkBJ+vJyoshUNziQh8AUiaFrlEUHahN1Pa+ziKxeJre6+Me35vhCiZQ+4q8O+DhHVtx0pZNKHlGIGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728310776; c=relaxed/simple;
	bh=J2P5IiHrUlxURdsqJ0nNZ62+0PHUNMZc9zVb0F22A1k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ae9mqQfYQnxHzUtaGDX2LY2F9gWFHgzI7vpExPS+yD6mIlj25Z9+B/TYwP+SS98kqg88idlMfXStVjenNi5dIcYii+KVYuN8m0TMcyENto2fG35mrRYmMEGKCwOSaks9ybzRZdd1Q5ZqA73hNeizZ/CC9C8zvH6+SYuQNrn8RuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PTr8Hvce; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42f6bec84b5so46681525e9.1;
        Mon, 07 Oct 2024 07:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728310773; x=1728915573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K5pl2ROicOhNAoVpZjAYZikcTP1+nppS1IdoYmg8e5Y=;
        b=PTr8HvcelcCWFRHa1GaqLjxSzRz9iwFzsgfUMkkM/HYijnW9zJqHIUxI5/bbnCAB5m
         ZFeC3ePXMIf1AJdA0WJEISh11FDjgd/GB3CIHSUQ6XaRDXau1AImixElyufoiXq5TY6h
         SuzMXFGOn8vwZrgmC/jtDasIgUt+DpkdyqKQxRr0LOVFad+GKyYu9GSCpcy0wDt9lMUH
         dLR9PgMssuG/5/1KwgMsOYErPuuFDEoVSLU/G8qFdXRKq4qgkyq3uGE3eja+xqWsgCwv
         b6G4F+mTgdkYi1n5Hcl3KmzBE18M5XYnddLHk7qV2wA4UJq3PlS5FK1f8TWs+JBWyytL
         bxSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728310773; x=1728915573;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K5pl2ROicOhNAoVpZjAYZikcTP1+nppS1IdoYmg8e5Y=;
        b=Bq0eqG0vo9OEcDNFOBDDRgD42qMUSiUx9JMZg6EgSLJnMIEW7R0jkMIzhQfarna2zc
         SF1VaOVO8AtrMmIECoK2rSuhKTQZ3Y1J4csE92OkMfaYE82aHqmt58nRWcuQtCRxn3XG
         O6qxxs/g6MSTO+6+OX1x+ZTOdG6KkPECvpXmreY95IPAcUeofDUGr6UoRZD18YTBdPM/
         jqn6MsMJxKM/hLS3ZhKOc9//d8crK7YwCyHhBCzA1tDivvKbLP5jRA2F6HhaVOPW9Rmu
         C9tPVsdTtEeAj3uNivlIcTe1R1nn4mPFWcaZEj5VA7ZLln70TWZFECHCV4aRUNCXQ+F5
         J1Xg==
X-Forwarded-Encrypted: i=1; AJvYcCVNYyrEZ5LkX2RPAp6sNPq5HcRLR3YiZYb+ZmlVDP/9/7J4P1maCyqutZmhNxw0+7Tg1mJ4GVSXTgYaeKfOOg==@vger.kernel.org, AJvYcCXN+S9FxPLyKRRBKqNLAVHHV8tlF7IilVf+WKvJBEpXTv9ztv0nsWX0aKF1THTtU84lEqgI7UVe5F0UkWiK@vger.kernel.org
X-Gm-Message-State: AOJu0YzLRU/iibW/+BZW9MXCLnIJ/PXLeQeEE4u2jxD/J+FWMu3M7Gou
	O/g6mNcDu9JwySoX0g7DnpwdTC1B+ot19lKy27de+EFWjbEduGZy
X-Google-Smtp-Source: AGHT+IEH16bvwIy00udG2k+69iE/yqFxITAt47WoPiPNyMmmaDYZm+128yrq5+B8sUVyqXHgRT0NlQ==
X-Received: by 2002:adf:f588:0:b0:37c:ce58:5a1a with SMTP id ffacd0b85a97d-37d0e8e0415mr5918662f8f.54.1728310772238;
        Mon, 07 Oct 2024 07:19:32 -0700 (PDT)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d16970520sm5829396f8f.96.2024.10.07.07.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 07:19:31 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org
Subject: [PATCH v3 3/5] ovl: store upper real file in ovl_file struct
Date: Mon,  7 Oct 2024 16:19:23 +0200
Message-Id: <20241007141925.327055-4-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241007141925.327055-1-amir73il@gmail.com>
References: <20241007141925.327055-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When an overlayfs file is opened as lower and then the file is copied up,
every operation on the overlayfs open file will open a temporary backing
file to the upper dentry and close it at the end of the operation.

Store the upper real file along side the original (lower) real file in
ovl_file instead of opening a temporary upper file on every operation.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/overlayfs/file.c | 49 +++++++++++++++++++++++++++++++++++++--------
 1 file changed, 41 insertions(+), 8 deletions(-)

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index 03bf6037b129..525bcddb49e5 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -91,32 +91,63 @@ static int ovl_change_flags(struct file *file, unsigned int flags)
 
 struct ovl_file {
 	struct file *realfile;
+	struct file *upperfile;
 };
 
+static bool ovl_is_real_file(const struct file *realfile,
+			     const struct path *realpath)
+{
+	return file_inode(realfile) == d_inode(realpath->dentry);
+}
+
 static int ovl_real_fdget_path(const struct file *file, struct fd *real,
 			       struct path *realpath)
 {
 	struct ovl_file *of = file->private_data;
 	struct file *realfile = of->realfile;
 
-	real->word = (unsigned long)realfile;
+	real->word = 0;
 
 	if (WARN_ON_ONCE(!realpath->dentry))
 		return -EIO;
 
-	/* Has it been copied up since we'd opened it? */
-	if (unlikely(file_inode(realfile) != d_inode(realpath->dentry))) {
-		struct file *f = ovl_open_realfile(file, realpath);
-		if (IS_ERR(f))
-			return PTR_ERR(f);
-		real->word = (unsigned long)f | FDPUT_FPUT;
-		return 0;
+	/*
+	 * If the realfile that we want is not where the data used to be at
+	 * open time, either we'd been copied up, or it's an fsync of a
+	 * metacopied file.  We need the upperfile either way, so see if it
+	 * is already opened and if it is not then open and store it.
+	 */
+	if (unlikely(!ovl_is_real_file(realfile, realpath))) {
+		struct file *upperfile = READ_ONCE(of->upperfile);
+		struct file *old;
+
+		if (!upperfile) { /* Nobody opened upperfile yet */
+			upperfile = ovl_open_realfile(file, realpath);
+			if (IS_ERR(upperfile))
+				return PTR_ERR(upperfile);
+
+			/* Store the upperfile for later */
+			old = cmpxchg_release(&of->upperfile, NULL, upperfile);
+			if (old) { /* Someone opened upperfile before us */
+				fput(upperfile);
+				upperfile = old;
+			}
+		}
+		/*
+		 * Stored file must be from the right inode, unless someone's
+		 * been corrupting the upper layer.
+		 */
+		if (WARN_ON_ONCE(!ovl_is_real_file(upperfile, realpath)))
+			return -EIO;
+
+		realfile = upperfile;
 	}
 
 	/* Did the flags change since open? */
 	if (unlikely((file->f_flags ^ realfile->f_flags) & ~OVL_OPEN_FLAGS))
 		return ovl_change_flags(realfile, file->f_flags);
 
+	real->word = (unsigned long)realfile;
 	return 0;
 }
 
@@ -208,6 +239,8 @@ static int ovl_release(struct inode *inode, struct file *file)
 	struct ovl_file *of = file->private_data;
 
 	fput(of->realfile);
+	if (of->upperfile)
+		fput(of->upperfile);
 	kfree(of);
 
 	return 0;
-- 
2.34.1


