Return-Path: <linux-fsdevel+bounces-62361-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C793B8EF10
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 06:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62B5A1896E83
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 04:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33E61F4E4F;
	Mon, 22 Sep 2025 04:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="u2818ff5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gdLVrCG5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A8880C02
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Sep 2025 04:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758515619; cv=none; b=QBIAGfdEIRfwVuXHkEmn6MSpDtTNwd2uzjjCQ/+lO9Dlj1IJoDRN5qQJhb+3OonheC8rAh5Jdjs4sTBreYgrNnWfMyj03U/Fv1uVjeqcc3Be4scT8OIfBrKU7eDpb8w89zL1Is8tGl7N+p63AVlK9e/KXcmHkTMuCPnOGYOdUl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758515619; c=relaxed/simple;
	bh=NfU2WNFVcmJFQqFO8cEqjsg2gtpuMMiH5PMGysDIHO0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IbyH5Gm6KLK8ghnHviDFqvtHDZQ2AlKc9UNsdq0KRdPQQIiFfanXBTEa3ArUwa0dcczk+nAQBz04av4f+rvHxdeA65PYur31m7jo0Ls6QE3Zi6okw/BibMI3qiOyyJRXOj7xuuQeamnWhXhp4YQJpmN4udmaU7tCElPLstdnTU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=u2818ff5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gdLVrCG5; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id BAF42EC008E;
	Mon, 22 Sep 2025 00:33:36 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 22 Sep 2025 00:33:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1758515616;
	 x=1758602016; bh=0jUV3JLQp2xY6O/3dB/61sNL0UhLEjUQ6SBHk4L82BQ=; b=
	u2818ff5RijUtM5+v9JJZxmYoQZSYFCuWlRH+A9996lPvO+uSc7XZU5yyBxI8uvX
	h4ILWhWfhTCjOtnWYczllcYLMpw9gFG7ikwsPbHkB+DbXdVQ0QRuO+9ZnAYr8JKz
	8EB6ce50wx9vEIPhORx/PokZIdDlodz+3h2L07aIoMX24vP0NarnE/ddYYQLRJGy
	uCw2vsxmpE6GLphfCdeeLUMj8GxKlH6Hu3ynoSDzlzstCApCtOUQuJFmPjU+KY8w
	MqSv4+dNnlpNha2HPL1ToXY6aAUOsBNOjyYSgFOh/7PKzLVt6E6HvO3GoIXI2l5l
	1F5GnTk8Er6R73Zr6ZgT0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1758515616; x=1758602016; bh=0
	jUV3JLQp2xY6O/3dB/61sNL0UhLEjUQ6SBHk4L82BQ=; b=gdLVrCG5+3BZC5Q5P
	tRBKhbEmyeFoJ/tvu1agOqqZpn5+aOGBg0UYlXfDxzvuUSnCHZs27Yge4CTvSuxl
	XinbTZ9e3lY6XMiFwKM5E1yvy+baWGFtRDml8Zp2idpyPJbmdA2fzEUDLE8KtGas
	G6yGRDaXcV9upAIZPfuPQ85K9A5pK1iOahbJmmpig6ByNFdVDGtQ2amJTXfe/YKF
	lq/3Eukkh4od+7v4dAzF27dSOxm7MR+0YyQ0F4TImAYsaEhBZ9p/2AiKtj4BPbM+
	82eZ39e0TsQbgm1wXbkadWeKbAQYTwI4vwmzWkeS82of90OUnQG5OQKXoP9AyzDY
	dl+Xw==
X-ME-Sender: <xms:oNHQaDczCv2RmIQkVWTwuE0EUnoqvf30YLUzPqvVV9kgGz9o7jq-rA>
    <xme:oNHQaAmvF96K-cH4zqGqxkna7GLD6-T3No_kEh5_hITst4NosfLaabdruLgCMex7j
    RPeCLcaF_6rKg>
X-ME-Received: <xmr:oNHQaCGhcQAO_UBAAW1h7ohGFMY3cLElGVDSDmoHkSR8ZI6TAUCtHcX_cGNJl_5fLju9A1Zlp1e-tceKZmqDopmFZKYkL1IGbF8kB-csI1g2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehieeltdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfrhgggfestdekredtredttdenucfhrhhomheppfgvihhluehr
    ohifnhcuoehnvghilhgssehofihnmhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpe
    evveekffduueevhfeigefhgfdukedtleekjeeitdejudfgueekvdekffdvfedvudenucev
    lhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehnvghilhgsse
    hofihnmhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpdhrtg
    hpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehjrggtkhesshhushgvrdgtiidprhgtphhtthhopehjlhgrhihtohhnse
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopegsrhgruhhnvghrsehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopegrmhhirhejfehilhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:oNHQaA4d1Vo8a1IQrpzUgAwF9E48pG4WxchVn4YIUbp-HUxsSJcK5A>
    <xmx:oNHQaClhb6B4ezzBFykhjJ_U0thCT9CY8wHrMCX-bDRJgQJbaEInfA>
    <xmx:oNHQaNoIOMhY1vpkrPC0oIUoRRx9we_CBeUT1DIGVnarm_Lnd1Sjhw>
    <xmx:oNHQaJsAFR8yeO_5Mij7qd7HRp_zK0ix03z5i9JhQha2yuG0h6tF4Q>
    <xmx:oNHQaBUIk0Q9QWNxgORfuKxWrTDrY0MpCrQOELxt-OJP_pOhJSy05dXE>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Sep 2025 00:33:34 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: "Alexander Viro" <viro@zeniv.linux.org.uk>,
	"Christian Brauner" <brauner@kernel.org>,
	"Amir Goldstein" <amir73il@gmail.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: "Jan Kara" <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 4/6] VFS/audit: introduce kern_path_parent() for audit
Date: Mon, 22 Sep 2025 14:29:51 +1000
Message-ID: <20250922043121.193821-5-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20250922043121.193821-1-neilb@ownmail.net>
References: <20250922043121.193821-1-neilb@ownmail.net>
Reply-To: NeilBrown <neil@brown.name>
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


