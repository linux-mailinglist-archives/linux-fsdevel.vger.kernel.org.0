Return-Path: <linux-fsdevel+bounces-60411-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96677B46929
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Sep 2025 07:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05AA6A02766
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Sep 2025 05:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7909A26CE0A;
	Sat,  6 Sep 2025 05:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="eXQ06sfL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nCfBKlhE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AFCA255F39
	for <linux-fsdevel@vger.kernel.org>; Sat,  6 Sep 2025 05:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757134878; cv=none; b=WyJ5xo4MSms2j+9B3oa6DyJrkY5+vjUElh40y28md9Kq97UKsuETZ0jf7PGmX7pJYQoYZg7EeKa8k6hgDanCFRG8H/Q0SOn0sYtFVkEvhJ690getOPqJ0/7r7l4LP3aRXrmBHd4y7r0Pk4jjUqNyngB/jCl4NOGCYtdfJtPNCLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757134878; c=relaxed/simple;
	bh=wTox/RWhvn2QH8FvhwMj47IxmJJEIOP3kzvQRULXY4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kWHWt+GT4M6wMlNwa7mw9ZF4OfiOeao1rJr4MSiCAYCm8iaB02SO7dsCYBquDAjgYw2N6qaZ6pXfKxISLrhRPs/sjsEbGvjgs0zS04cB3cXEDO05Z+LazO/C4tQtq5+rNyG+8rhmu9zkfQHmPagseOb2+b/AOBogpp+MFHq9/kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=eXQ06sfL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nCfBKlhE; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 4120B1D003CB;
	Sat,  6 Sep 2025 01:01:16 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Sat, 06 Sep 2025 01:01:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1757134876; x=
	1757221276; bh=SlPHI6TxCRGEokMtR/YkC4vkT6t60QmKFOLa6XXFGUs=; b=e
	XQ06sfL09Yr0VosQid6r0jSljWByImFLSW7JfJeOp4ryAF0jxNAUF71XBVf3YF9N
	QEfeyAWxhIMAmI2cEfeFeiDYF569Ch0yz216O0xDsnZap9wNkT/B0u2FUH4sZ26o
	X4QThmR5JdHO840CUrXfebkfTLdUYt9yBVWWv6hBi1skaP6D7MIQSqyhmgwX1SP5
	TEtEIfxAnRQFnkz/7A12Ua1+BzR0FDI5c1moZtWpROlBqzGPUaGYj6a4gIphoAit
	Nh17kE8dEurGKa2mPS6F1VQ4FTesQS7/4kE2fqPZn6B5LWMDr4Ts/gA75QDknKGF
	ZBgsHH1ewoFoKfn9v+Cww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1757134876; x=1757221276; bh=S
	lPHI6TxCRGEokMtR/YkC4vkT6t60QmKFOLa6XXFGUs=; b=nCfBKlhEAOemPiwSm
	ZvWhMCBftr9k/2mX+tdcELC5G4aFQ9cEqpkdtVTy9Ssy0tnFNz3g6ILQFXJGdU62
	qetL/ONCnLMQYVjSlqm4g7F6dGpMYVCKsuaqesl7w8YY4Ft7FoNuh9F+JQztipfO
	e6+M0FmKd4LYvglOJBBJxtoCGhiPuVJVWj937NcZGpRCOzXR1VRkHmfQ7k6nEPe3
	DLYMIOIDunbTqY7zcVOahjxdx57MNXUZ/kbCD2lkF9hekbmUCcq5+hk8MQSNOEPm
	YJEwinqeKXnne0g/U2SW02ibPyFGhXwoSDd1SfuR5BL4kCITz9mGXOk4dRk5mbRa
	wparw==
X-ME-Sender: <xms:G8C7aLrRfGed5PozPuraFqg0eoYt3QkKmqY89k5N7NBn9p4XpWYjCQ>
    <xme:G8C7aDmwQy58bEx95uNlQXD8ggoAFa9s4NS6TMe0GbLiLoKeGb734s2CpHaDi4-1U
    epbo9HMnaEwFA>
X-ME-Received: <xmr:G8C7aKh_Il1bx4T52aG6W14V8d7sTN4okkvswyZ7U9H5M45h5biQ7IMsxTRPqHy6ckMIy8q8IulK_ipEOjAJpQWT5bvFTHEu7e3xKA0ykM0v>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdekjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefpvghilheurhho
    fihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnhepue
    ekvdehhfegtddufffhjeehfeeiueffgeeltdeuhefhtdffteejtdejtedvjeetnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsgesoh
    ifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepvhhirhhoseiivghnihhvrdhlihhnuhigrdhorhhgrdhukhdprhgtph
    htthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepjhgrtghksehsuhhsvgdrtgiipdhrtghpthhtohepsghrrghunhgvrheskh
    gvrhhnvghlrdhorhhgpdhrtghpthhtoheprghmihhrjeefihhlsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:G8C7aDelBE4gky8K8kMfkx-qryqvxBNW1zadd6sOgY5-ChxAIvsuRw>
    <xmx:G8C7aCgyC0lc9SR0IhaQrFHSYsKvR01z1MdvXKIYmbar-dSYwQX5ZQ>
    <xmx:G8C7aDwaKnwY1R5qQSICYVr7GFifoBDhFGDc3FQVrfShrrECY_htdg>
    <xmx:G8C7aGMy_3eLYvgbbR9mUI4UKjU6qxkqbB8SIlWLayv8bTSZTiYoaQ>
    <xmx:HMC7aOs9-5OYnry1nlab0qQnzTMBI-q9yo38cuXaY2dYNyw2MUEhThsE>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 6 Sep 2025 01:01:14 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: "Alexander Viro" <viro@zeniv.linux.org.uk>,
	"Christian Brauner" <brauner@kernel.org>,
	"Amir Goldstein" <amir73il@gmail.com>
Cc: "Jan Kara" <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 6/6] VFS: rename kern_path_locked() to kern_path_removing()
Date: Sat,  6 Sep 2025 14:57:10 +1000
Message-ID: <20250906050015.3158851-7-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20250906050015.3158851-1-neilb@ownmail.net>
References: <20250906050015.3158851-1-neilb@ownmail.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: NeilBrown <neil@brown.name>

Also rename user_path_locked_at() to user_path_removing_at()

Add done_path_removing() to clean up after these calls.

The only credible need for a locked positive dentry is to remove it, so
make that explicit in the name.

Signed-off-by: NeilBrown <neil@brown.name>
---
 Documentation/filesystems/porting.rst | 10 ++++++++++
 drivers/base/devtmpfs.c               | 12 ++++--------
 fs/bcachefs/fs-ioctl.c                |  6 ++----
 fs/namei.c                            | 23 +++++++++++++++++------
 include/linux/namei.h                 |  5 +++--
 5 files changed, 36 insertions(+), 20 deletions(-)

diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystems/porting.rst
index 85f590254f07..defbae457310 100644
--- a/Documentation/filesystems/porting.rst
+++ b/Documentation/filesystems/porting.rst
@@ -1285,3 +1285,13 @@ rather than a VMA, as the VMA at this stage is not yet valid.
 The vm_area_desc provides the minimum required information for a filesystem
 to initialise state upon memory mapping of a file-backed region, and output
 parameters for the file system to set this state.
+
+---
+
+**mandatory**
+
+kern_path_locked and user_path_locked_at() are renamed to
+kern_path_removing() and user_path_removing_at() and should only
+be used when removing a name.  done_path_removing() should be called
+after removal.
+
diff --git a/drivers/base/devtmpfs.c b/drivers/base/devtmpfs.c
index 31bfb3194b4c..26d0beead1f0 100644
--- a/drivers/base/devtmpfs.c
+++ b/drivers/base/devtmpfs.c
@@ -256,7 +256,7 @@ static int dev_rmdir(const char *name)
 	struct dentry *dentry;
 	int err;
 
-	dentry = kern_path_locked(name, &parent);
+	dentry = kern_path_removing(name, &parent);
 	if (IS_ERR(dentry))
 		return PTR_ERR(dentry);
 	if (d_inode(dentry)->i_private == &thread)
@@ -265,9 +265,7 @@ static int dev_rmdir(const char *name)
 	else
 		err = -EPERM;
 
-	dput(dentry);
-	inode_unlock(d_inode(parent.dentry));
-	path_put(&parent);
+	done_path_removing(dentry, &parent);
 	return err;
 }
 
@@ -325,7 +323,7 @@ static int handle_remove(const char *nodename, struct device *dev)
 	int deleted = 0;
 	int err = 0;
 
-	dentry = kern_path_locked(nodename, &parent);
+	dentry = kern_path_removing(nodename, &parent);
 	if (IS_ERR(dentry))
 		return PTR_ERR(dentry);
 
@@ -349,10 +347,8 @@ static int handle_remove(const char *nodename, struct device *dev)
 		if (!err || err == -ENOENT)
 			deleted = 1;
 	}
-	dput(dentry);
-	inode_unlock(d_inode(parent.dentry));
+	done_path_removing(dentry, &parent);
 
-	path_put(&parent);
 	if (deleted && strchr(nodename, '/'))
 		delete_path(nodename);
 	return err;
diff --git a/fs/bcachefs/fs-ioctl.c b/fs/bcachefs/fs-ioctl.c
index 4e72e654da96..9446cefbe249 100644
--- a/fs/bcachefs/fs-ioctl.c
+++ b/fs/bcachefs/fs-ioctl.c
@@ -334,7 +334,7 @@ static long bch2_ioctl_subvolume_destroy(struct bch_fs *c, struct file *filp,
 	if (arg.flags)
 		return -EINVAL;
 
-	victim = user_path_locked_at(arg.dirfd, name, &path);
+	victim = user_path_removing_at(arg.dirfd, name, &path);
 	if (IS_ERR(victim))
 		return PTR_ERR(victim);
 
@@ -351,9 +351,7 @@ static long bch2_ioctl_subvolume_destroy(struct bch_fs *c, struct file *filp,
 		d_invalidate(victim);
 	}
 err:
-	inode_unlock(dir);
-	dput(victim);
-	path_put(&path);
+	done_path_removing(victim, &path);
 	return ret;
 }
 
diff --git a/fs/namei.c b/fs/namei.c
index 104015f302a7..c750820b27b9 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2757,7 +2757,8 @@ static int filename_parentat(int dfd, struct filename *name,
 }
 
 /* does lookup, returns the object with parent locked */
-static struct dentry *__kern_path_locked(int dfd, struct filename *name, struct path *path)
+static struct dentry *__kern_path_removing(int dfd, struct filename *name,
+					   struct path *path)
 {
 	struct path parent_path __free(path_put) = {};
 	struct dentry *d;
@@ -2815,24 +2816,34 @@ struct dentry *kern_path_parent(const char *name, struct path *path)
 	return d;
 }
 
-struct dentry *kern_path_locked(const char *name, struct path *path)
+struct dentry *kern_path_removing(const char *name, struct path *path)
 {
 	struct filename *filename = getname_kernel(name);
-	struct dentry *res = __kern_path_locked(AT_FDCWD, filename, path);
+	struct dentry *res = __kern_path_removing(AT_FDCWD, filename, path);
 
 	putname(filename);
 	return res;
 }
 
-struct dentry *user_path_locked_at(int dfd, const char __user *name, struct path *path)
+void done_path_removing(struct dentry *dentry, struct path *path)
+{
+	if (!IS_ERR(dentry)) {
+		inode_unlock(path->dentry->d_inode);
+		dput(dentry);
+		path_put(path);
+	}
+}
+EXPORT_SYMBOL(done_path_removing);
+
+struct dentry *user_path_removing_at(int dfd, const char __user *name, struct path *path)
 {
 	struct filename *filename = getname(name);
-	struct dentry *res = __kern_path_locked(dfd, filename, path);
+	struct dentry *res = __kern_path_removing(dfd, filename, path);
 
 	putname(filename);
 	return res;
 }
-EXPORT_SYMBOL(user_path_locked_at);
+EXPORT_SYMBOL(user_path_removing_at);
 
 int kern_path(const char *name, unsigned int flags, struct path *path)
 {
diff --git a/include/linux/namei.h b/include/linux/namei.h
index 1d5038c21c20..37568f8055f9 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -62,8 +62,9 @@ struct dentry *kern_path_parent(const char *name, struct path *parent);
 extern struct dentry *kern_path_create(int, const char *, struct path *, unsigned int);
 extern struct dentry *user_path_create(int, const char __user *, struct path *, unsigned int);
 extern void done_path_create(struct path *, struct dentry *);
-extern struct dentry *kern_path_locked(const char *, struct path *);
-extern struct dentry *user_path_locked_at(int , const char __user *, struct path *);
+extern struct dentry *kern_path_removing(const char *, struct path *);
+extern struct dentry *user_path_removing_at(int , const char __user *, struct path *);
+void done_path_removing(struct dentry *dentry, struct path *path);
 int vfs_path_parent_lookup(struct filename *filename, unsigned int flags,
 			   struct path *parent, struct qstr *last, int *type,
 			   const struct path *root);
-- 
2.50.0.107.gf914562f5916.dirty


