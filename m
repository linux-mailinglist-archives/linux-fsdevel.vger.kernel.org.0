Return-Path: <linux-fsdevel+bounces-60424-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7B1B46A8C
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Sep 2025 11:12:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC748A629ED
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Sep 2025 09:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 976872C11E9;
	Sat,  6 Sep 2025 09:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="tM/Q06Ap"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BA327F00A
	for <linux-fsdevel@vger.kernel.org>; Sat,  6 Sep 2025 09:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757149902; cv=none; b=T8Wo9AEJD2IIy97arEkuwXprSmhYOmdm2Xz4u1nGP9KD9n/L2YJ/ZnoxP7dlFm0fv/KsVs6N7p5FTEX4I/XUo5POblguhKsejLthQ2o5MzOsW42ez/C+bGyDjjYJZrJEaOphodjL8CJaTpex5Mu5rz17z1SuVB0UW+CTWKotRqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757149902; c=relaxed/simple;
	bh=7yuTzkOrA6ZC25ueBDtOzfs2O8nWdq6WjIqoa/e+H1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=meBHMkeWNgHV6ifo2xoMaDMBdG3YWl1QkYkC52rfqOyTEFIPSgItfXPiILedqAxqsOoAW7USepOKDqP2BH6zgtVi2QTV66CVYGV6v3r9AxgAcRkayNg58eq0Gq3OgMHxupKchZYr7i1z1mvEQuWw9CluSZ18WnhDjVCMMq0SRxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=tM/Q06Ap; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=xfATYKKIcFml/BtiW7cyICW+4dGprzaSKEiNiOnLWQQ=; b=tM/Q06Ap/BD9ibMGrGGxlWOyLG
	WhTdWvoZrpUSH1MwneWxwnOUXHCKJ4WfkVBzgn4EqeQxzmOVuo7yC8RWawgOGaF6yLxfXymPKQEK2
	HLsrgJpdVZacLx6VThxNyTzhV7A05lWZv4GwlGDFHj+OUh0hq5gU3CQShqme58u+zRqrq8v7X3DTU
	8fwkRI3jkuMYeqjcdBUlxoGDXfa8nmkWYpOREPcLvwA9L059iGEV5ExPkM9uWbLhWNZekjVvpLavN
	RzwLa6RGEWTSQS4xqx5qzlIaeY+n/d/BAkgLs7iObCGkS9V2N71fqkamDcNyvUQBvG6LaQhpNw9JZ
	oWkXTHcw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uuoxN-00000000OrO-3a92;
	Sat, 06 Sep 2025 09:11:37 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org,
	amir73il@gmail.com,
	chuck.lever@oracle.com,
	linkinjeon@kernel.org,
	john@apparmor.net
Subject: [PATCH 01/21] backing_file_user_path(): constify struct path *
Date: Sat,  6 Sep 2025 10:11:17 +0100
Message-ID: <20250906091137.95554-1-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250906090738.GA31600@ZenIV>
References: <20250906090738.GA31600@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Callers never use the resulting pointer to modify the struct path it
points to (nor should they).

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/file_table.c    | 2 +-
 include/linux/fs.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/file_table.c b/fs/file_table.c
index 81c72576e548..85b53e39138d 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -54,7 +54,7 @@ struct backing_file {
 
 #define backing_file(f) container_of(f, struct backing_file, file)
 
-struct path *backing_file_user_path(const struct file *f)
+const struct path *backing_file_user_path(const struct file *f)
 {
 	return &backing_file(f)->user_path;
 }
diff --git a/include/linux/fs.h b/include/linux/fs.h
index d7ab4f96d705..3bcc878817be 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2879,7 +2879,7 @@ struct file *dentry_open_nonotify(const struct path *path, int flags,
 				  const struct cred *cred);
 struct file *dentry_create(const struct path *path, int flags, umode_t mode,
 			   const struct cred *cred);
-struct path *backing_file_user_path(const struct file *f);
+const struct path *backing_file_user_path(const struct file *f);
 
 /*
  * When mmapping a file on a stackable filesystem (e.g., overlayfs), the file
-- 
2.47.2


