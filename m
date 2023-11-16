Return-Path: <linux-fsdevel+bounces-2939-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 892487EDB0A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Nov 2023 06:08:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15EEC280FE7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Nov 2023 05:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB36BC8CA;
	Thu, 16 Nov 2023 05:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="pb3S3QYa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E88FA18D
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Nov 2023 21:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=J8lKgVlZ5n3FsA+3Ej0KqD1BNz8AscLDLHOWD8f4JQs=; b=pb3S3QYaZPw5GIT29aMPHXNxiY
	WNuF8KEjG8xM1T1R1X35ambbpFIHVBGeYnPnDxybM2ND6BqNpY1TSMAYBfie5BczihfCDysnleP4i
	3rHazwbXGeCdK8mUlSypWrbMRrHtNHExA+yLJrhwEcb1hCHXdrcBJNTNf8eF9IXcj2+zajJ0hSNHY
	k0AEPW1V7xBO/z1FTZ5XmqCqTt2yedhnFjYlCkcLejAWtlzLlPbiGjCoaQSpsX3thYDCL7W8bIVZZ
	iSuj2fswbTA/lueuJUZs6azF2lITAgIBCmXVpW76ZMRLdODqLG2OoiHpV1mDasdnGubArBWzDYLqH
	o6p9yavA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r3UcD-00GObK-03;
	Thu, 16 Nov 2023 05:08:33 +0000
Date: Thu, 16 Nov 2023 05:08:32 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@gmail.com>
Subject: [PATCH 1/2] new helper: user_path_locked_at()
Message-ID: <20231116050832.GX1957730@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

(in #work.namei; used for bcachefs locking fix)
From 74d016ecc1a7974664e98d1afbf649cd4e0e0423 Mon Sep 17 00:00:00 2001
From: Al Viro <viro@zeniv.linux.org.uk>
Date: Wed, 15 Nov 2023 22:41:27 -0500
Subject: [PATCH 1/2] new helper: user_path_locked_at()

Equivalent of kern_path_locked() taking dfd/userland name.
User introduced in the next commit.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namei.c            | 16 +++++++++++++---
 include/linux/namei.h |  1 +
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 71c13b2990b4..3ffbe268d52c 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2573,13 +2573,13 @@ static int filename_parentat(int dfd, struct filename *name,
 }
 
 /* does lookup, returns the object with parent locked */
-static struct dentry *__kern_path_locked(struct filename *name, struct path *path)
+static struct dentry *__kern_path_locked(int dfd, struct filename *name, struct path *path)
 {
 	struct dentry *d;
 	struct qstr last;
 	int type, error;
 
-	error = filename_parentat(AT_FDCWD, name, 0, path, &last, &type);
+	error = filename_parentat(dfd, name, 0, path, &last, &type);
 	if (error)
 		return ERR_PTR(error);
 	if (unlikely(type != LAST_NORM)) {
@@ -2598,12 +2598,22 @@ static struct dentry *__kern_path_locked(struct filename *name, struct path *pat
 struct dentry *kern_path_locked(const char *name, struct path *path)
 {
 	struct filename *filename = getname_kernel(name);
-	struct dentry *res = __kern_path_locked(filename, path);
+	struct dentry *res = __kern_path_locked(AT_FDCWD, filename, path);
 
 	putname(filename);
 	return res;
 }
 
+struct dentry *user_path_locked_at(int dfd, const char __user *name, struct path *path)
+{
+	struct filename *filename = getname(name);
+	struct dentry *res = __kern_path_locked(dfd, filename, path);
+
+	putname(filename);
+	return res;
+}
+EXPORT_SYMBOL(user_path_locked_at);
+
 int kern_path(const char *name, unsigned int flags, struct path *path)
 {
 	struct filename *filename = getname_kernel(name);
diff --git a/include/linux/namei.h b/include/linux/namei.h
index 3100371b5e32..74e0cc14ebf8 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -66,6 +66,7 @@ extern struct dentry *kern_path_create(int, const char *, struct path *, unsigne
 extern struct dentry *user_path_create(int, const char __user *, struct path *, unsigned int);
 extern void done_path_create(struct path *, struct dentry *);
 extern struct dentry *kern_path_locked(const char *, struct path *);
+extern struct dentry *user_path_locked_at(int , const char __user *, struct path *);
 int vfs_path_parent_lookup(struct filename *filename, unsigned int flags,
 			   struct path *parent, struct qstr *last, int *type,
 			   const struct path *root);
-- 
2.39.2


