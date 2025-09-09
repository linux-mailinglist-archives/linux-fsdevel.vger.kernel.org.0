Return-Path: <linux-fsdevel+bounces-60613-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE84B4A0E3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 06:48:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 733274E1F3C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 04:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8390C2EC566;
	Tue,  9 Sep 2025 04:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="t5GAo21t";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HLKK+ELD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDCB2566F2
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Sep 2025 04:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757393325; cv=none; b=TB7RlBpcwywTw2B1F92UmUphoIFmjmEx10RB/VR0+42/XRBbBVzEXUolcmkXJpMUxQIqf+a0YCgHpWXdWIjPrSrmQQp9RDGdk8eXfTJpGqU3L3TpPIFgyQ/OKkKHRiALPD+je5167f+0uW8U1g8MluOZVA+qsW+nc6xfntjMess=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757393325; c=relaxed/simple;
	bh=NfU2WNFVcmJFQqFO8cEqjsg2gtpuMMiH5PMGysDIHO0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rrHgguit/w0PcMyroVznc1epXMgii94+j9A8P3KDwP556EjGCQoiVnK8imjMlTi4ETQKwMivvHHPpGRe8Ly3xU8W5bJo/I8j2uMCcZ8ra3gAQs96ZB7aujzI2wcPws/XepNgPRhMfRdVbmF4zuyQw0tc7j3kiIE2my6bNV69nnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=t5GAo21t; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HLKK+ELD; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EDD2D7A00BC;
	Tue,  9 Sep 2025 00:48:42 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Tue, 09 Sep 2025 00:48:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1757393322;
	 x=1757479722; bh=0jUV3JLQp2xY6O/3dB/61sNL0UhLEjUQ6SBHk4L82BQ=; b=
	t5GAo21tDClAekuHyE6N0XKnc6bfWQnfSVedyXI3XmseCuHpM9p5SR66nKqiqxd3
	VGi65xkeWqL+iI07/l+BzXGvQmgJGrA3yDLSZhMZ5EfCtMas1cDjAy8VJyk3XORj
	sVpIWHVSa0VYQ5vUwv+hlkjkpGlOwH0A2trmeQEp/BtPvknVXCz3pDARSXaKOdFp
	xHlPLBT7wFHlzVf6XzcW2sAB9dnXoG1Bc1VDwGdr98+LU5Ff/lRvgzzvklSmiIB8
	0158gYfVEV0WKZGPs+T0yEozZ2nvsKqgYC2rHcfEJGkgIFqFXy4RTJUfMJtBuOuR
	72XFH7KNm719xNFp/jD8mg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1757393322; x=1757479722; bh=0
	jUV3JLQp2xY6O/3dB/61sNL0UhLEjUQ6SBHk4L82BQ=; b=HLKK+ELDAd/YIfriL
	R0cDNmlTsnsaNb/qJKW5ZUer4w06foka/fVIWJYS2pu+abuDAqJP2yqwiSRZkXNz
	05RTYhsdAVj619FObo/rNwQCHYCNJKy4pHB0d00AOOxWMMG6Pc+NP3DalukJceZT
	HJxu9ZKOn1BGCmD3/EmCwADAcoEcik59qNZA92H3X7AFOR+OFV68s/AZgiUu+xXb
	/MxwQ1ucXaARRAuIQd9gA37OHuiXXk60ZAGmBORQTCipp5KTiOkths/VDKpWyJve
	OKX4ummsw9uqpzQKOdaXpUasizoraR9DwEmKVVNyLgrA+tcf0XciPrUEVoNX4Mji
	g/9/Q==
X-ME-Sender: <xms:qrG_aNOmUSM5caUSfp3ZM1grfLX-NdpRvySGET_jEfx7b9tfbOuExw>
    <xme:qrG_aHUQMjizYEr5hvsNusI4ZVv7joWbfCQoNGTrt0l0jnLiIdII0YTUPm9DRdkc5
    8-4_--Kye1-9w>
X-ME-Received: <xmr:qrG_aB0kxIiullqFdsvXSH9WcernbuIpT9FBZ_Fhx3SAjQwXf0aOp6pEgchqP8wANfuSwcMn_Ugk7pnV_gaUnhnRk2jKPhURuoHEftshSmnA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduleegkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfrhgggfestdekredtredttdenucfhrhhomheppfgvihhluehr
    ohifnhcuoehnvghilhgssehofihnmhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpe
    evveekffduueevhfeigefhgfdukedtleekjeeitdejudfgueekvdekffdvfedvudenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnvghilhgsse
    hofihnmhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpdhrtg
    hpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehjrggtkhesshhushgvrdgtiidprhgtphhtthhopehjlhgrhihtohhnse
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopegsrhgruhhnvghrsehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopegrmhhirhejfehilhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:qrG_aFpK9c-PVmx5USceGVDuFaUPygMceoBe8D_ccfJKyYn64BE0AQ>
    <xmx:qrG_aIXy5BFgf3AIbQg5hOk8-VKxS1VjXuiEH55qD4aAbJEiLI_t7Q>
    <xmx:qrG_aAaVr4CWfuhswhUDIOtjFa9VVs7g8zTrEm6P3YCXjhnf6txW0A>
    <xmx:qrG_aFc3e3LCByllryeYszz6uSU5uOtJh2eD_ODzDwjdJ7YNkcf3Nw>
    <xmx:qrG_aGMccHKRAMC8ytqorBjTlWEDHXnSHHu8V5jr7RGzRz14bFP8iYOm>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Sep 2025 00:48:40 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: "Alexander Viro" <viro@zeniv.linux.org.uk>,
	"Christian Brauner" <brauner@kernel.org>,
	"Amir Goldstein" <amir73il@gmail.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: "Jan Kara" <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 4/7] VFS/audit: introduce kern_path_parent() for audit
Date: Tue,  9 Sep 2025 14:43:18 +1000
Message-ID: <20250909044637.705116-5-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20250909044637.705116-1-neilb@ownmail.net>
References: <20250909044637.705116-1-neilb@ownmail.net>
Reply-To: neil@brown.name
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: NeilBrown <neil@brown.name>

audit_alloc_mark() and audit_get_nd() both need to perform a path
lookup getting the parent dentry (which must exist) and the final
target (following a LAST_NORM name) which sometimes doesn't need to
exist.

They don't need the parent to be locked, but use kern_path_locked() or
kern_path_locked_negative() anyway.  This is somewhat misleading to the
casual reader.

This patch introduces a more targeted function, kern_path_parent(),
which returns not holding locks.  On success the "path" will
be set to the parent, which must be found, and the return value is the
dentry of the target, which might be negative.

This will clear the way to rename kern_path_locked() which is
otherwise only used to prepare for removing something.

It also allows us to remove kern_path_locked_negative(), which is
transformed into the new kern_path_parent().

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/namei.c              | 23 +++++++++++++++++------
 include/linux/namei.h   |  2 +-
 kernel/audit_fsnotify.c | 11 ++++++-----
 kernel/audit_watch.c    |  3 +--
 4 files changed, 25 insertions(+), 14 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 180037b96956..4017bc8641d3 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2781,7 +2781,20 @@ static struct dentry *__kern_path_locked(int dfd, struct filename *name, struct
 	return d;
 }
 
-struct dentry *kern_path_locked_negative(const char *name, struct path *path)
+/**
+ * kern_path_parent: lookup path returning parent and target
+ * @name: path name
+ * @path: path to store parent in
+ *
+ * The path @name should end with a normal component, not "." or ".." or "/".
+ * A lookup is performed and if successful the parent information
+ * is store in @parent and the dentry is returned.
+ *
+ * The dentry maybe negative, the parent will be positive.
+ *
+ * Returns:  dentry or error.
+ */
+struct dentry *kern_path_parent(const char *name, struct path *path)
 {
 	struct path parent_path __free(path_put) = {};
 	struct filename *filename __free(putname) = getname_kernel(name);
@@ -2794,12 +2807,10 @@ struct dentry *kern_path_locked_negative(const char *name, struct path *path)
 		return ERR_PTR(error);
 	if (unlikely(type != LAST_NORM))
 		return ERR_PTR(-EINVAL);
-	inode_lock_nested(parent_path.dentry->d_inode, I_MUTEX_PARENT);
-	d = lookup_one_qstr_excl(&last, parent_path.dentry, LOOKUP_CREATE);
-	if (IS_ERR(d)) {
-		inode_unlock(parent_path.dentry->d_inode);
+
+	d = lookup_noperm_unlocked(&last, parent_path.dentry);
+	if (IS_ERR(d))
 		return d;
-	}
 	path->dentry = no_free_ptr(parent_path.dentry);
 	path->mnt = no_free_ptr(parent_path.mnt);
 	return d;
diff --git a/include/linux/namei.h b/include/linux/namei.h
index 551a1a01e5e7..1d5038c21c20 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -57,12 +57,12 @@ struct dentry *lookup_one_qstr_excl(const struct qstr *name,
 				    struct dentry *base,
 				    unsigned int flags);
 extern int kern_path(const char *, unsigned, struct path *);
+struct dentry *kern_path_parent(const char *name, struct path *parent);
 
 extern struct dentry *kern_path_create(int, const char *, struct path *, unsigned int);
 extern struct dentry *user_path_create(int, const char __user *, struct path *, unsigned int);
 extern void done_path_create(struct path *, struct dentry *);
 extern struct dentry *kern_path_locked(const char *, struct path *);
-extern struct dentry *kern_path_locked_negative(const char *, struct path *);
 extern struct dentry *user_path_locked_at(int , const char __user *, struct path *);
 int vfs_path_parent_lookup(struct filename *filename, unsigned int flags,
 			   struct path *parent, struct qstr *last, int *type,
diff --git a/kernel/audit_fsnotify.c b/kernel/audit_fsnotify.c
index c565fbf66ac8..b92805b317a2 100644
--- a/kernel/audit_fsnotify.c
+++ b/kernel/audit_fsnotify.c
@@ -76,17 +76,18 @@ struct audit_fsnotify_mark *audit_alloc_mark(struct audit_krule *krule, char *pa
 	struct audit_fsnotify_mark *audit_mark;
 	struct path path;
 	struct dentry *dentry;
-	struct inode *inode;
 	int ret;
 
 	if (pathname[0] != '/' || pathname[len-1] == '/')
 		return ERR_PTR(-EINVAL);
 
-	dentry = kern_path_locked(pathname, &path);
+	dentry = kern_path_parent(pathname, &path);
 	if (IS_ERR(dentry))
 		return ERR_CAST(dentry); /* returning an error */
-	inode = path.dentry->d_inode;
-	inode_unlock(inode);
+	if (d_really_is_negative(dentry)) {
+		audit_mark = ERR_PTR(-ENOENT);
+		goto out;
+	}
 
 	audit_mark = kzalloc(sizeof(*audit_mark), GFP_KERNEL);
 	if (unlikely(!audit_mark)) {
@@ -100,7 +101,7 @@ struct audit_fsnotify_mark *audit_alloc_mark(struct audit_krule *krule, char *pa
 	audit_update_mark(audit_mark, dentry->d_inode);
 	audit_mark->rule = krule;
 
-	ret = fsnotify_add_inode_mark(&audit_mark->mark, inode, 0);
+	ret = fsnotify_add_inode_mark(&audit_mark->mark, path.dentry->d_inode, 0);
 	if (ret < 0) {
 		audit_mark->path = NULL;
 		fsnotify_put_mark(&audit_mark->mark);
diff --git a/kernel/audit_watch.c b/kernel/audit_watch.c
index 0ebbbe37a60f..a700e3c8925f 100644
--- a/kernel/audit_watch.c
+++ b/kernel/audit_watch.c
@@ -349,7 +349,7 @@ static int audit_get_nd(struct audit_watch *watch, struct path *parent)
 {
 	struct dentry *d;
 
-	d = kern_path_locked_negative(watch->path, parent);
+	d = kern_path_parent(watch->path, parent);
 	if (IS_ERR(d))
 		return PTR_ERR(d);
 
@@ -359,7 +359,6 @@ static int audit_get_nd(struct audit_watch *watch, struct path *parent)
 		watch->ino = d_backing_inode(d)->i_ino;
 	}
 
-	inode_unlock(d_backing_inode(parent->dentry));
 	dput(d);
 	return 0;
 }
-- 
2.50.0.107.gf914562f5916.dirty


