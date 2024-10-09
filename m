Return-Path: <linux-fsdevel+bounces-31413-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC05995E6B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 06:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93E581F24C3D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 04:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F2714900E;
	Wed,  9 Oct 2024 04:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="aJHqtD6J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC16F208D0
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Oct 2024 04:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728446601; cv=none; b=Nw8/itsX9MFm8/JDg1vneLbQOWdyvC8Qgz8Kj/RArWWsw+Ggr7YlVrBYyTyMXRIv1D0w6VPsnpttnTGG+I70/oA2OmdZEcDKV+gH/0oKIUxXJsA+juTZKjqM369oxAyS/XyKMKFo9bPPLQ49lRGqTclCsvLcu8ps6sx5Pu4MQVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728446601; c=relaxed/simple;
	bh=mxo2jFjcd/uBpk3TWa/7hdGiI9h+XtUGtb2ralMbuMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Jg9SNEkNZJwkH6WUpHP6J6GkBIrNEuy++mMM5Og0mNUP5VJIX4jAISRnm6cm0HbvfVXDlWOwQvBK/5ltdS+i5WmI43SBC3FSO/H+c2DtzdREsD3Z2s2hW0Wie0CuEaBtJ1qc7y17dE8JqsFFN81ZS1/Ojw3j+f7N1xWJ+OVStCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=aJHqtD6J; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=Nkc3/t3OLS4IZEMtC1X487m5ZwynyUtmIikkFH3GW28=; b=aJHqtD6JsXPav09/FhSeyj23m4
	aI+PIfaDA9P8Nm2uvBdmMouUT+GE6S6XDET1Qr4zeOaIf4JVtqIPRxjkU32H6AwKDvXO1c/8UMFy8
	zh+Mp+Deuf9XNnygW6su3oUGEIGUK826uTKRn4FUgG/oDhKZwuEDlNm5T9QGhhXWIHuIKiQzcCc89
	TD5qNf398W2pnSlOIpDHEf8rkirVjEsHXPg8yTDtACG0e49t2nm+EMvXxrwITYZ3cUt/KLsvA9hUz
	t586m5bnstr2r9BjL0lxxgr6VM3yu+sUmnC940RK96Oct1kGMDBAS4/bdXUKdWgyesi3pGrRbkqG8
	hu7muyRQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1syNuu-0000000232v-47Bq;
	Wed, 09 Oct 2024 04:03:17 +0000
Date: Wed, 9 Oct 2024 05:03:16 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>
Subject: [RFC][PATCH] getname_maybe_null() - the third variant of pathname
 copy-in
Message-ID: <20241009040316.GY4017910@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

[
in #work.getname; if nobody objects, I'm going to make #work.xattr pull that.
IMO it's saner than hacks around vfs_empty_path() and it does very similar
logics - with simpler handling on the caller side.
]

Semantics used by statx(2) (and later *xattrat(2)): without AT_EMPTY_PATH
it's standard getname() (i.e. ERR_PTR(-ENOENT) on empty string,
ERR_PTR(-EFAULT) on NULL), with AT_EMPTY_PATH both empty string and
NULL are accepted.
    
Calling conventions: getname_maybe_null(user_pointer, flags) returns
	* pointer to struct filename when non-empty string had been
successfully read
	* ERR_PTR(...) on error
	* NULL if an empty string or NULL pointer had been given
with AT_EMPTY_FLAGS in the flags argument.

It tries to avoid allocation in the last case; it's not always
able to do so, in which case the temporary struct filename instance
is freed and NULL returned anyway.

Fast path is inlined.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
--- 
diff --git a/fs/namei.c b/fs/namei.c
index 4a4a22a08ac2..27eb0a81d9b8 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -211,22 +211,38 @@ getname_flags(const char __user *filename, int flags)
 	return result;
 }
 
-struct filename *
-getname_uflags(const char __user *filename, int uflags)
+struct filename *getname_uflags(const char __user *filename, int uflags)
 {
 	int flags = (uflags & AT_EMPTY_PATH) ? LOOKUP_EMPTY : 0;
 
 	return getname_flags(filename, flags);
 }
 
-struct filename *
-getname(const char __user * filename)
+struct filename *getname(const char __user * filename)
 {
 	return getname_flags(filename, 0);
 }
 
-struct filename *
-getname_kernel(const char * filename)
+struct filename *__getname_maybe_null(const char __user *pathname)
+{
+	struct filename *name;
+	char c;
+
+	/* try to save on allocations; loss on um, though */
+	if (get_user(c, pathname))
+		return ERR_PTR(-EFAULT);
+	if (!c)
+		return NULL;
+
+	name = getname_flags(pathname, LOOKUP_EMPTY);
+	if (!IS_ERR(name) && !(name->name[0])) {
+		putname(name);
+		name = NULL;
+	}
+	return name;
+}
+
+struct filename *getname_kernel(const char * filename)
 {
 	struct filename *result;
 	int len = strlen(filename) + 1;
diff --git a/fs/stat.c b/fs/stat.c
index 41e598376d7e..aa5bfc41a669 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -326,18 +326,11 @@ int vfs_fstatat(int dfd, const char __user *filename,
 {
 	int ret;
 	int statx_flags = flags | AT_NO_AUTOMOUNT;
-	struct filename *name;
+	struct filename *name = getname_maybe_null(filename, flags);
 
-	/*
-	 * Work around glibc turning fstat() into fstatat(AT_EMPTY_PATH)
-	 *
-	 * If AT_EMPTY_PATH is set, we expect the common case to be that
-	 * empty path, and avoid doing all the extra pathname work.
-	 */
-	if (flags == AT_EMPTY_PATH && vfs_empty_path(dfd, filename))
+	if (!name)
 		return vfs_fstat(dfd, stat);
 
-	name = getname_flags(filename, getname_statx_lookup_flags(statx_flags));
 	ret = vfs_statx(dfd, name, statx_flags, stat, STATX_BASIC_STATS);
 	putname(name);
 
@@ -775,7 +768,7 @@ SYSCALL_DEFINE5(statx,
 {
 	int ret;
 	unsigned lflags;
-	struct filename *name;
+	struct filename *name = getname_maybe_null(filename, flags);
 
 	/*
 	 * Short-circuit handling of NULL and "" paths.
@@ -788,10 +781,9 @@ SYSCALL_DEFINE5(statx,
 	 * Supporting this results in the uglification below.
 	 */
 	lflags = flags & ~(AT_NO_AUTOMOUNT | AT_STATX_SYNC_TYPE);
-	if (lflags == AT_EMPTY_PATH && vfs_empty_path(dfd, filename))
+	if (!name)
 		return do_statx_fd(dfd, flags & ~AT_NO_AUTOMOUNT, mask, buffer);
 
-	name = getname_flags(filename, getname_statx_lookup_flags(flags));
 	ret = do_statx(dfd, name, flags, mask, buffer);
 	putname(name);
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index e3c603d01337..403258ac2ea2 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2766,6 +2766,16 @@ extern struct filename *getname_flags(const char __user *, int);
 extern struct filename *getname_uflags(const char __user *, int);
 extern struct filename *getname(const char __user *);
 extern struct filename *getname_kernel(const char *);
+extern struct filename *__getname_maybe_null(const char __user *);
+static inline struct filename *getname_maybe_null(const char __user *name, int flags)
+{
+	if (!(flags & AT_EMPTY_PATH))
+		return getname(name);
+
+	if (!name)
+		return NULL;
+	return __getname_maybe_null(name);
+}
 extern void putname(struct filename *name);
 
 extern int finish_open(struct file *file, struct dentry *dentry,

