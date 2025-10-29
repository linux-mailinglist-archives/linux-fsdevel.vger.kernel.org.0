Return-Path: <linux-fsdevel+bounces-66391-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 861A9C1DBDC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 00:46:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 98AF04E2C2A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 23:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05171324B0C;
	Wed, 29 Oct 2025 23:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="EzUM1mZH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WeTcrWvz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-b4-smtp.messagingengine.com (flow-b4-smtp.messagingengine.com [202.12.124.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C8D21D59C;
	Wed, 29 Oct 2025 23:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761781546; cv=none; b=gQiGx2baZqRokX8bERw+TuHFgEHJRCx79bjl157H7k4/GEVkYCmkcCsxN2zdK4Eyd9Ilh1wtT1Ty8RQKCE50QADrcbuE2wMt7BV33G21BKh+ybyj9VbqAfgHRPsTACtCUoJB2wGXIPfx5pSbAcnt5a7p5MBbx6b8ciq6x0YLBjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761781546; c=relaxed/simple;
	bh=5ccGHlErJEiL1U/aKcZAMbBsFACeVcSyvza8OzAgHSI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=svJte0+xnvxQFjvc7W65fvpmyGnmPOLO2R5p+JN4kOWCOk/FXLdJAxvFk9oqprdCx3N1kmq/x6Sf51JHCuIXqtOGs/0KEWAjE6pWcJEejWpC9MQP1Jv/YHOGCS+diztWNUpioH4c6j0QLQcXANVPbmeVnzzLclp5fYcpEpMg8vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=EzUM1mZH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WeTcrWvz; arc=none smtp.client-ip=202.12.124.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.stl.internal (Postfix) with ESMTP id 8736B130035C;
	Wed, 29 Oct 2025 19:45:42 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 29 Oct 2025 19:45:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1761781542;
	 x=1761788742; bh=ZAgrbaq/ub6v+rWXKj59uZmAaxqQeW6+Mxd+Zd+T3Ak=; b=
	EzUM1mZH1gLkN8TTgLcpsi5ExYcVRdlK01N/JLNPkcqU0P2M4MCeaxCKzfzhe5rM
	FRNip0m4yrjMcMv3WepzOR9bgB1nDkuaFAiy4a0UcKws9dROz+PnK7bagJq05E9l
	7+KIIRbsyGTQWAjPjv5v/1N2HPBkjDSvYtxj+xpC7LVBxpcmysnZXCq3TnXieRhF
	MCf4QN01jWWcR2GBEuCrrZHvwWnhdESvFNKb/uMMn0uSGZ1JZPEaSVJYTo4fgA6t
	rdggP+rILS47t7Sc0syx3kAH7eS4uGhcG96pqyi7cJknl4u4s/NK2ZJ38EKb5xer
	+24Ynei54q/xkFzANCuD9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1761781542; x=1761788742; bh=Z
	Agrbaq/ub6v+rWXKj59uZmAaxqQeW6+Mxd+Zd+T3Ak=; b=WeTcrWvzUMlTT5vfo
	25cBt8s1Mo8oq2HkBoXiQ87vNMocWlZPHS1mk0gV7X/OjT5Udokxv6shoof4WnVQ
	v/VuSudl30NLG3FL7do+6sVVLTwQLgKW6c5P741v84WogEePgBoSnb3ohvjHaAHp
	WV7zbvTZSwzAO5W1NMl2aYCLL826ECAuQTDF+WNPRgM/fAv5Q55ccntl6X9qZsQx
	L1gO1DvuY6Qr4f6tlankKCIUZUjBONKKkCRDOZKxZcSvuV58QsVkPbbT+Pg23lMN
	Mm85qB4czK18d+F/gI6oo3nBSr1F6lO6XQfQJRV1MK980eI2t4B8Pb82sbN1YeDH
	1NL5g==
X-ME-Sender: <xms:JacCafPGbkKARfL7qmXhTGsgiUe4rTE7DcmZLhcQXwaA7n1WP1PTVw>
    <xme:JacCac1peOBtTzLL12EGbfv0k4aCRAiLFzNOaRLaa4fwb9o6XbAfYRNsDkN7cMua3
    1_K1R6HGQMWvz4Bt67xq2xXm7q4n74Lz6hjbi3FfE1hSHM0TCU>
X-ME-Received: <xmr:JacCafHZwvKRkPVrE-WdgF6u8C8mIGDOLPmTloUyGNgarVHEzRNWYWPhmdwrrNehu0gowplie5Uev0spV4Xrpmxtjc_WLdXVGgRw1lTAPeRh>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieehtdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epveevkeffudeuvefhieeghffgudektdelkeejiedtjedugfeukedvkeffvdefvddunecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepgedupdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpd
    hrtghpthhtohepshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehlihhnuhigqdigfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    eplhhinhhugidquhhnihhonhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehlihhnuhigqdhsvggtuhhrihhthidqmhhoughulhgvsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqtghifhhssehvghgvrhdrkhgvrhhnvg
    hlrdhorhhg
X-ME-Proxy: <xmx:JacCaVgnroa1Hy7YyBpbsiOhBwYve3E3Iq9w1QnAXf5kPPWxJrwIQA>
    <xmx:JacCaVYDjQHFLw05KYnaRyB0axtl8C_E9VNA6aUsZrWSLoYGabmZVg>
    <xmx:JacCaS2yuRDmxNfktFIwSOppi7qAM_aaeRSuoe9LP0N-7IIKkDkH9w>
    <xmx:JacCaQyC0ArEvT4i8S9xgAX4CPMLTvKZL_ifRMqNYWV9qmMM8f6UWA>
    <xmx:JqcCaS1m08pkVZ1XJX2qxj6OKK9X39TCqzayvf1f56rz2D0-Gr2ezRYg>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Oct 2025 19:45:31 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: "Alexander Viro" <viro@zeniv.linux.org.uk>,
	"Christian Brauner" <brauner@kernel.org>,
	"Amir Goldstein" <amir73il@gmail.com>
Cc: "Jan Kara" <jack@suse.cz>,	linux-fsdevel@vger.kernel.org,
	Jeff Layton <jlayton@kernel.org>,	Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>,	David Howells <dhowells@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,	Tyler Hicks <code@tyhicks.com>,
	Miklos Szeredi <miklos@szeredi.hu>,	Chuck Lever <chuck.lever@oracle.com>,
	Olga Kornievskaia <okorniev@redhat.com>,	Dai Ngo <Dai.Ngo@oracle.com>,
	Namjae Jeon <linkinjeon@kernel.org>,	Steve French <smfrench@gmail.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Carlos Maiolino <cem@kernel.org>,
	John Johansen <john.johansen@canonical.com>,
	Paul Moore <paul@paul-moore.com>,	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,	Mateusz Guzik <mjguzik@gmail.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Stefan Berger <stefanb@linux.ibm.com>,
	"Darrick J. Wong" <djwong@kernel.org>,	linux-kernel@vger.kernel.org,
	netfs@lists.linux.dev,	ecryptfs@vger.kernel.org,
	linux-nfs@vger.kernel.org,	linux-unionfs@vger.kernel.org,
	linux-cifs@vger.kernel.org,	linux-xfs@vger.kernel.org,
	apparmor@lists.ubuntu.com,	linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org
Subject: [PATCH v4 05/14] VFS/nfsd/cachefiles/ovl: introduce start_removing() and end_removing()
Date: Thu, 30 Oct 2025 10:31:05 +1100
Message-ID: <20251029234353.1321957-6-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20251029234353.1321957-1-neilb@ownmail.net>
References: <20251029234353.1321957-1-neilb@ownmail.net>
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: NeilBrown <neil@brown.name>

start_removing() is similar to start_creating() but will only return a
positive dentry with the expectation that it will be removed.  This is
used by nfsd, cachefiles, and overlayfs.  They are changed to also use
end_removing() to terminate the action begun by start_removing().  This
is a simple alias for end_dirop().

Apart from changes to the error paths, as we no longer need to unlock on
a lookup error, an effect on callers is that they don't need to test if
the found dentry is positive or negative - they can be sure it is
positive.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/cachefiles/namei.c    | 32 ++++++++++++++------------------
 fs/namei.c               | 27 +++++++++++++++++++++++++++
 fs/nfsd/nfs4recover.c    | 18 +++++-------------
 fs/nfsd/vfs.c            | 26 ++++++++++----------------
 fs/overlayfs/dir.c       | 15 +++++++--------
 fs/overlayfs/overlayfs.h |  8 ++++++++
 include/linux/namei.h    | 18 ++++++++++++++++++
 7 files changed, 89 insertions(+), 55 deletions(-)

diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index 0a136eb434da..c7f0c6ab9b88 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -260,6 +260,7 @@ static int cachefiles_unlink(struct cachefiles_cache *cache,
  * - File backed objects are unlinked
  * - Directory backed objects are stuffed into the graveyard for userspace to
  *   delete
+ * On entry dir must be locked.  It will be unlocked on exit.
  */
 int cachefiles_bury_object(struct cachefiles_cache *cache,
 			   struct cachefiles_object *object,
@@ -274,28 +275,30 @@ int cachefiles_bury_object(struct cachefiles_cache *cache,
 
 	_enter(",'%pd','%pd'", dir, rep);
 
+	/* end_removing() will dput() @rep but we need to keep
+	 * a ref, so take one now.  This also stops the dentry
+	 * being negated when unlinked which we need.
+	 */
+	dget(rep);
+
 	if (rep->d_parent != dir) {
-		inode_unlock(d_inode(dir));
+		end_removing(rep);
 		_leave(" = -ESTALE");
 		return -ESTALE;
 	}
 
 	/* non-directories can just be unlinked */
 	if (!d_is_dir(rep)) {
-		dget(rep); /* Stop the dentry being negated if it's only pinned
-			    * by a file struct.
-			    */
 		ret = cachefiles_unlink(cache, object, dir, rep, why);
-		dput(rep);
+		end_removing(rep);
 
-		inode_unlock(d_inode(dir));
 		_leave(" = %d", ret);
 		return ret;
 	}
 
 	/* directories have to be moved to the graveyard */
 	_debug("move stale object to graveyard");
-	inode_unlock(d_inode(dir));
+	end_removing(rep);
 
 try_again:
 	/* first step is to make up a grave dentry in the graveyard */
@@ -749,26 +752,20 @@ static struct dentry *cachefiles_lookup_for_cull(struct cachefiles_cache *cache,
 	struct dentry *victim;
 	int ret = -ENOENT;
 
-	inode_lock_nested(d_inode(dir), I_MUTEX_PARENT);
+	victim = start_removing(&nop_mnt_idmap, dir, &QSTR(filename));
 
-	victim = lookup_one(&nop_mnt_idmap, &QSTR(filename), dir);
 	if (IS_ERR(victim))
 		goto lookup_error;
-	if (d_is_negative(victim))
-		goto lookup_put;
 	if (d_inode(victim)->i_flags & S_KERNEL_FILE)
 		goto lookup_busy;
 	return victim;
 
 lookup_busy:
 	ret = -EBUSY;
-lookup_put:
-	inode_unlock(d_inode(dir));
-	dput(victim);
+	end_removing(victim);
 	return ERR_PTR(ret);
 
 lookup_error:
-	inode_unlock(d_inode(dir));
 	ret = PTR_ERR(victim);
 	if (ret == -ENOENT)
 		return ERR_PTR(-ESTALE); /* Probably got retired by the netfs */
@@ -816,18 +813,17 @@ int cachefiles_cull(struct cachefiles_cache *cache, struct dentry *dir,
 
 	ret = cachefiles_bury_object(cache, NULL, dir, victim,
 				     FSCACHE_OBJECT_WAS_CULLED);
+	dput(victim);
 	if (ret < 0)
 		goto error;
 
 	fscache_count_culled();
-	dput(victim);
 	_leave(" = 0");
 	return 0;
 
 error_unlock:
-	inode_unlock(d_inode(dir));
+	end_removing(victim);
 error:
-	dput(victim);
 	if (ret == -ENOENT)
 		return -ESTALE; /* Probably got retired by the netfs */
 
diff --git a/fs/namei.c b/fs/namei.c
index 9972b0257a4c..ae833dfa277c 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3248,6 +3248,33 @@ struct dentry *start_creating(struct mnt_idmap *idmap, struct dentry *parent,
 }
 EXPORT_SYMBOL(start_creating);
 
+/**
+ * start_removing - prepare to remove a given name with permission checking
+ * @idmap:  idmap of the mount
+ * @parent: directory in which to find the name
+ * @name:   the name to be removed
+ *
+ * Locks are taken and a lookup in performed prior to removing
+ * an object from a directory.  Permission checking (MAY_EXEC) is performed
+ * against @idmap.
+ *
+ * If the name doesn't exist, an error is returned.
+ *
+ * end_removing() should be called when removal is complete, or aborted.
+ *
+ * Returns: a positive dentry, or an error.
+ */
+struct dentry *start_removing(struct mnt_idmap *idmap, struct dentry *parent,
+			      struct qstr *name)
+{
+	int err = lookup_one_common(idmap, name, parent);
+
+	if (err)
+		return ERR_PTR(err);
+	return start_dirop(parent, name, 0);
+}
+EXPORT_SYMBOL(start_removing);
+
 #ifdef CONFIG_UNIX98_PTYS
 int path_pts(struct path *path)
 {
diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
index c247a7c3291c..3eefaa2202e3 100644
--- a/fs/nfsd/nfs4recover.c
+++ b/fs/nfsd/nfs4recover.c
@@ -324,20 +324,12 @@ nfsd4_unlink_clid_dir(char *name, struct nfsd_net *nn)
 	dprintk("NFSD: nfsd4_unlink_clid_dir. name %s\n", name);
 
 	dir = nn->rec_file->f_path.dentry;
-	inode_lock_nested(d_inode(dir), I_MUTEX_PARENT);
-	dentry = lookup_one(&nop_mnt_idmap, &QSTR(name), dir);
-	if (IS_ERR(dentry)) {
-		status = PTR_ERR(dentry);
-		goto out_unlock;
-	}
-	status = -ENOENT;
-	if (d_really_is_negative(dentry))
-		goto out;
+	dentry = start_removing(&nop_mnt_idmap, dir, &QSTR(name));
+	if (IS_ERR(dentry))
+		return PTR_ERR(dentry);
+
 	status = vfs_rmdir(&nop_mnt_idmap, d_inode(dir), dentry);
-out:
-	dput(dentry);
-out_unlock:
-	inode_unlock(d_inode(dir));
+	end_removing(dentry);
 	return status;
 }
 
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 4efd3688e081..cd64ffe12e0b 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -2044,7 +2044,7 @@ nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh *fhp, int type,
 {
 	struct dentry	*dentry, *rdentry;
 	struct inode	*dirp;
-	struct inode	*rinode;
+	struct inode	*rinode = NULL;
 	__be32		err;
 	int		host_err;
 
@@ -2063,24 +2063,21 @@ nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh *fhp, int type,
 
 	dentry = fhp->fh_dentry;
 	dirp = d_inode(dentry);
-	inode_lock_nested(dirp, I_MUTEX_PARENT);
 
-	rdentry = lookup_one(&nop_mnt_idmap, &QSTR_LEN(fname, flen), dentry);
+	rdentry = start_removing(&nop_mnt_idmap, dentry, &QSTR_LEN(fname, flen));
+
 	host_err = PTR_ERR(rdentry);
 	if (IS_ERR(rdentry))
-		goto out_unlock;
+		goto out_drop_write;
 
-	if (d_really_is_negative(rdentry)) {
-		dput(rdentry);
-		host_err = -ENOENT;
-		goto out_unlock;
-	}
-	rinode = d_inode(rdentry);
 	err = fh_fill_pre_attrs(fhp);
 	if (err != nfs_ok)
 		goto out_unlock;
 
+	rinode = d_inode(rdentry);
+	/* Prevent truncation until after locks dropped */
 	ihold(rinode);
+
 	if (!type)
 		type = d_inode(rdentry)->i_mode & S_IFMT;
 
@@ -2102,10 +2099,10 @@ nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh *fhp, int type,
 	}
 	fh_fill_post_attrs(fhp);
 
-	inode_unlock(dirp);
-	if (!host_err)
+out_unlock:
+	end_removing(rdentry);
+	if (!err && !host_err)
 		host_err = commit_metadata(fhp);
-	dput(rdentry);
 	iput(rinode);    /* truncate the inode here */
 
 out_drop_write:
@@ -2123,9 +2120,6 @@ nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh *fhp, int type,
 	}
 out:
 	return err != nfs_ok ? err : nfserrno(host_err);
-out_unlock:
-	inode_unlock(dirp);
-	goto out_drop_write;
 }
 
 /*
diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index a8a24abee6b3..b5247c9e1903 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -866,17 +866,17 @@ static int ovl_remove_upper(struct dentry *dentry, bool is_dir,
 			goto out;
 	}
 
-	inode_lock_nested(dir, I_MUTEX_PARENT);
-	upper = ovl_lookup_upper(ofs, dentry->d_name.name, upperdir,
-				 dentry->d_name.len);
+	upper = ovl_start_removing_upper(ofs, upperdir,
+					 &QSTR_LEN(dentry->d_name.name,
+						   dentry->d_name.len));
 	err = PTR_ERR(upper);
 	if (IS_ERR(upper))
-		goto out_unlock;
+		goto out_dput;
 
 	err = -ESTALE;
 	if ((opaquedir && upper != opaquedir) ||
 	    (!opaquedir && !ovl_matches_upper(dentry, upper)))
-		goto out_dput_upper;
+		goto out_unlock;
 
 	if (is_dir)
 		err = ovl_do_rmdir(ofs, dir, upper);
@@ -892,10 +892,9 @@ static int ovl_remove_upper(struct dentry *dentry, bool is_dir,
 	 */
 	if (!err)
 		d_drop(dentry);
-out_dput_upper:
-	dput(upper);
 out_unlock:
-	inode_unlock(dir);
+	end_removing(upper);
+out_dput:
 	dput(opaquedir);
 out:
 	return err;
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index beeba96cfcb2..49ad65f829dc 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -423,6 +423,14 @@ static inline struct dentry *ovl_start_creating_upper(struct ovl_fs *ofs,
 			      parent, name);
 }
 
+static inline struct dentry *ovl_start_removing_upper(struct ovl_fs *ofs,
+						      struct dentry *parent,
+						      struct qstr *name)
+{
+	return start_removing(ovl_upper_mnt_idmap(ofs),
+			      parent, name);
+}
+
 static inline bool ovl_open_flags_need_copy_up(int flags)
 {
 	if (!flags)
diff --git a/include/linux/namei.h b/include/linux/namei.h
index 3f92c1a16878..9ee76e88f3dd 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -90,6 +90,8 @@ struct dentry *lookup_one_positive_killable(struct mnt_idmap *idmap,
 
 struct dentry *start_creating(struct mnt_idmap *idmap, struct dentry *parent,
 			      struct qstr *name);
+struct dentry *start_removing(struct mnt_idmap *idmap, struct dentry *parent,
+			      struct qstr *name);
 
 /**
  * end_creating - finish action started with start_creating
@@ -121,6 +123,22 @@ static inline void end_creating(struct dentry *child, struct dentry *parent)
 		end_dirop(child);
 }
 
+/**
+ * end_removing - finish action started with start_removing
+ * @child:  dentry returned by start_removing()
+ * @parent: dentry given to start_removing()
+ *
+ * Unlock and release the child.
+ *
+ * This is identical to end_dirop().  It can be passed the result of
+ * start_removing() whether that was successful or not, but it not needed
+ * if start_removing() failed.
+ */
+static inline void end_removing(struct dentry *child)
+{
+	end_dirop(child);
+}
+
 extern int follow_down_one(struct path *);
 extern int follow_down(struct path *path, unsigned int flags);
 extern int follow_up(struct path *);
-- 
2.50.0.107.gf914562f5916.dirty


