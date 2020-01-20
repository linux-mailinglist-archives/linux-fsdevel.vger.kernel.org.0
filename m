Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE5C4143471
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2020 00:29:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbgATX3D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jan 2020 18:29:03 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:56548 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726843AbgATX3C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jan 2020 18:29:02 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1itgTa-00CJ1b-La; Mon, 20 Jan 2020 23:28:58 +0000
Date:   Mon, 20 Jan 2020 23:28:58 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH][bpf] don't bother with getname/kern_path - use user_path_at
Message-ID: <20200120232858.GF8904@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

	kernel/bpf/inode.c misuses kern_path...() - it's much simpler
(and more efficient, on top of that) to use user_path...() counterparts
rather than bothering with doing getname() manually.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
index ecf42bec38c0..e11059b99f18 100644
--- a/kernel/bpf/inode.c
+++ b/kernel/bpf/inode.c
@@ -380,7 +380,7 @@ static const struct inode_operations bpf_dir_iops = {
 	.unlink		= simple_unlink,
 };
 
-static int bpf_obj_do_pin(const struct filename *pathname, void *raw,
+static int bpf_obj_do_pin(const char __user *pathname, void *raw,
 			  enum bpf_type type)
 {
 	struct dentry *dentry;
@@ -389,7 +389,7 @@ static int bpf_obj_do_pin(const struct filename *pathname, void *raw,
 	umode_t mode;
 	int ret;
 
-	dentry = kern_path_create(AT_FDCWD, pathname->name, &path, 0);
+	dentry = user_path_create(AT_FDCWD, pathname, &path, 0);
 	if (IS_ERR(dentry))
 		return PTR_ERR(dentry);
 
@@ -422,30 +422,22 @@ static int bpf_obj_do_pin(const struct filename *pathname, void *raw,
 
 int bpf_obj_pin_user(u32 ufd, const char __user *pathname)
 {
-	struct filename *pname;
 	enum bpf_type type;
 	void *raw;
 	int ret;
 
-	pname = getname(pathname);
-	if (IS_ERR(pname))
-		return PTR_ERR(pname);
-
 	raw = bpf_fd_probe_obj(ufd, &type);
-	if (IS_ERR(raw)) {
-		ret = PTR_ERR(raw);
-		goto out;
-	}
+	if (IS_ERR(raw))
+		return PTR_ERR(raw);
 
-	ret = bpf_obj_do_pin(pname, raw, type);
+	ret = bpf_obj_do_pin(pathname, raw, type);
 	if (ret != 0)
 		bpf_any_put(raw, type);
-out:
-	putname(pname);
+
 	return ret;
 }
 
-static void *bpf_obj_do_get(const struct filename *pathname,
+static void *bpf_obj_do_get(const char __user *pathname,
 			    enum bpf_type *type, int flags)
 {
 	struct inode *inode;
@@ -453,7 +445,7 @@ static void *bpf_obj_do_get(const struct filename *pathname,
 	void *raw;
 	int ret;
 
-	ret = kern_path(pathname->name, LOOKUP_FOLLOW, &path);
+	ret = user_path_at(AT_FDCWD, pathname, LOOKUP_FOLLOW, &path);
 	if (ret)
 		return ERR_PTR(ret);
 
@@ -480,36 +472,27 @@ static void *bpf_obj_do_get(const struct filename *pathname,
 int bpf_obj_get_user(const char __user *pathname, int flags)
 {
 	enum bpf_type type = BPF_TYPE_UNSPEC;
-	struct filename *pname;
-	int ret = -ENOENT;
 	int f_flags;
 	void *raw;
+	int ret;
 
 	f_flags = bpf_get_file_flag(flags);
 	if (f_flags < 0)
 		return f_flags;
 
-	pname = getname(pathname);
-	if (IS_ERR(pname))
-		return PTR_ERR(pname);
-
-	raw = bpf_obj_do_get(pname, &type, f_flags);
-	if (IS_ERR(raw)) {
-		ret = PTR_ERR(raw);
-		goto out;
-	}
+	raw = bpf_obj_do_get(pathname, &type, f_flags);
+	if (IS_ERR(raw))
+		return PTR_ERR(raw);
 
 	if (type == BPF_TYPE_PROG)
 		ret = bpf_prog_new_fd(raw);
 	else if (type == BPF_TYPE_MAP)
 		ret = bpf_map_new_fd(raw, f_flags);
 	else
-		goto out;
+		return -ENOENT;
 
 	if (ret < 0)
 		bpf_any_put(raw, type);
-out:
-	putname(pname);
 	return ret;
 }
 
