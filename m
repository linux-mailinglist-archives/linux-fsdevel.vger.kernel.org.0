Return-Path: <linux-fsdevel+bounces-67251-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7CDC38973
	for <lists+linux-fsdevel@lfdr.de>; Thu, 06 Nov 2025 01:59:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A85C834ED9A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Nov 2025 00:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA60241663;
	Thu,  6 Nov 2025 00:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="GdzJ1nln";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="0ulPfTa6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-b4-smtp.messagingengine.com (flow-b4-smtp.messagingengine.com [202.12.124.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A301E9B35;
	Thu,  6 Nov 2025 00:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762390622; cv=none; b=gax16vwUj5OfV6XIP27JjnyRX5QPRAZb8MS6ePhKbw0IIT3xS8gjLjkl6aJRlGNE6EdNqgVSy1dgWGRsANq+v8iGR4VWuP6+eOBXUGYmRKEN1l+Dn7CtNcJq1tZ7jwFj4PqRsYXTDkJJTGkfopOrGsQ3oBCx5ErP/XzgcN9g2Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762390622; c=relaxed/simple;
	bh=A1tgej96Mp14illHvlK3m02G5P06YWQbqmBOac0pDyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=llNetAMShj7Gmn2lRDSPKTyiOaTwdMBIPXVwEZB9hskZHVTIIpw3TK7nF+xvu2vbKIYOI9HzdgoS2LqI0pa9VwJ4HFEkNHtvXl9k2NZdYaWmBxMOoOuSr8JUIedpHREFjWM9hMq14ZWi9g1s+hb5SKN03rm0A2HXKPd8niwCBdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=GdzJ1nln; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=0ulPfTa6; arc=none smtp.client-ip=202.12.124.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailflow.stl.internal (Postfix) with ESMTP id 3765F13006BE;
	Wed,  5 Nov 2025 19:56:59 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 05 Nov 2025 19:57:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1762390619;
	 x=1762397819; bh=gQNIkXGJ/3duZgz9+qpY2pD9VeeCFkuSeIVTt2ww9Pw=; b=
	GdzJ1nlnGmO5zYVoiHBiKU9TGsDtyZFNjHjfFa4i/spDfKl3jsoB311rHdu2IhBY
	1roCTPI14vYqBW/bwlOwQCNG2dKwj1rxPU4NPyWoLhU/g9B9gQdJwHcAjy2ULcZj
	N0z8qkxAdyxfj72rcPRkmAMCcmATXY08HcvNGg/z3J7fNJKCv9RHxlfj6ta+vDzB
	UhhYBfgjjTnS5EOGvuN+WCNX627OZ7W+IsOmSPM8VcztXjy39Vab++lZMH5hJXpK
	aKT41cVVY2xlV5txE0Z3dM2gA+AqbJMpXzsT8F0Cpu7Bf40JK12FIioZEX69tqJd
	BgrO437eszTmUOZHTBf5Og==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1762390619; x=1762397819; bh=g
	QNIkXGJ/3duZgz9+qpY2pD9VeeCFkuSeIVTt2ww9Pw=; b=0ulPfTa6ogj0f83e0
	8hG3h2QP3hVWYN3M0q/lLTl0K/JjBBUzEViC4NbXNCFDQ2x+UcjoGIaR5TxIrkww
	ioDT6HSvTNC4aJPg3fXNJ+lv2vdzJ3mS20YRqZdrpZCLJpWuHcd/htL4ircuUr9r
	dyXqLDMWBdtqDJV9nkGMWi1kB8a1nAM6wqQmZ8zvnO0YfTyjY0kpUji5b0QmYJQs
	YI71d/cMANyyDWhbw0IcX0HiN2uvN8hzwr4MX/j/nuyFuv8bdIp1G2oGuSyg1jpK
	H56rspaaYOCFFxMbiBnalR4TuCTMco8f9Ucr1wIAULFbLtvFPbUpmIf4lE3GI6bj
	FQj1Q==
X-ME-Sender: <xms:WvILaStiO4l6k0vGdaMn4-CbNhcN8hnnB8nUqzmO5lfwF1M1GEZgHw>
    <xme:WvILacg8IX90w1CeczXry5STiINR5cfJxLmv8KIYJ1pEgT6IMY26PiirFlpEXd2Gq
    FOWLUGPNHQ3fpOFwZAhzGN3WPzvFRuJaf76ac_VNJs4SlW8JA>
X-ME-Received: <xmr:WvILaazWSGHBmGL3dSWKtw7uSJmxM6U9vBFi6C35kh1Qq_8sCrfc7rXvYMai3CB3pvgqXYb5HAVEhhLcgj1aUHD3yO4qqiUU6TfqtWMAmDBP>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeehgedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epveevkeffudeuvefhieeghffgudektdelkeejiedtjedugfeukedvkeffvdefvddunecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepgedtpdhmohguvgepshhmthhp
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
X-ME-Proxy: <xmx:WvILaa6QoGAJAlNZGMb7nRHxwK4Qe1-H2i2Ru5Ve9_TONy-jJ6o4Jg>
    <xmx:WvILaUeFUmYTubT3q-l6IAblz-XnAtFQKP1Qv0pNCMqLRen2v89rsA>
    <xmx:WvILaaqXMXjktNsnAAe2WITmjjYmnlGy8jR69sOZIavIhL5WqAb54g>
    <xmx:WvILaQ1kUdT1QgWEe5-fHrP-3miO-wHaOHWMesLBaQ3grwzF7UD7Ow>
    <xmx:W_ILabv9usBXLDt1prtSNLftvtyNN0R0B9Ay-Qf3bfKYnpiJ8leOw6YK>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Nov 2025 19:56:48 -0500 (EST)
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
	linux-security-module@vger.kernel.org,	selinux@vger.kernel.org
Subject: [PATCH v5 13/14] VFS: change vfs_mkdir() to unlock on failure.
Date: Thu,  6 Nov 2025 11:50:57 +1100
Message-ID: <20251106005333.956321-14-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20251106005333.956321-1-neilb@ownmail.net>
References: <20251106005333.956321-1-neilb@ownmail.net>
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: NeilBrown <neil@brown.name>

vfs_mkdir() already drops the reference to the dentry on failure but it
leaves the parent locked.
This complicates end_creating() which needs to unlock the parent even
though the dentry is no longer available.

If we change vfs_mkdir() to unlock on failure as well as releasing the
dentry, we can remove the "parent" arg from end_creating() and simplify
the rules for calling it.

Note that cachefiles_get_directory() can choose to substitute an error
instead of actually calling vfs_mkdir(), for fault injection.  In that
case it needs to call end_creating(), just as vfs_mkdir() now does on
error.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: NeilBrown <neil@brown.name>

--
changes since v2:
 - extra {} in if() branch in cachefiles_get_directory() to
   match the new extra {} in the else branch.
 - filesystems/porting.rst updated.
---
 Documentation/filesystems/porting.rst | 13 +++++++++++++
 fs/btrfs/ioctl.c                      |  2 +-
 fs/cachefiles/namei.c                 | 16 ++++++++-------
 fs/ecryptfs/inode.c                   |  8 ++++----
 fs/namei.c                            |  4 ++--
 fs/nfsd/nfs3proc.c                    |  2 +-
 fs/nfsd/nfs4proc.c                    |  2 +-
 fs/nfsd/nfs4recover.c                 |  2 +-
 fs/nfsd/nfsproc.c                     |  2 +-
 fs/nfsd/vfs.c                         |  8 ++++----
 fs/overlayfs/copy_up.c                |  4 ++--
 fs/overlayfs/dir.c                    | 13 ++++++-------
 fs/overlayfs/super.c                  |  6 +++---
 fs/xfs/scrub/orphanage.c              |  2 +-
 include/linux/namei.h                 | 28 +++++++++------------------
 ipc/mqueue.c                          |  2 +-
 16 files changed, 59 insertions(+), 55 deletions(-)

diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystems/porting.rst
index 35f027981b21..d33429294252 100644
--- a/Documentation/filesystems/porting.rst
+++ b/Documentation/filesystems/porting.rst
@@ -1309,3 +1309,16 @@ a different length, use
 	vfs_parse_fs_qstr(fc, key, &QSTR_LEN(value, len))
 
 instead.
+
+---
+
+**mandatory**
+
+vfs_mkdir() now returns a dentry - the one returned by ->mkdir().  If
+that dentry is different from the dentry passed in, including if it is
+an IS_ERR() dentry pointer, the original dentry is dput().
+
+When vfs_mkdir() returns an error, and so both dputs() the original
+dentry and doesn't provide a replacement, it also unlocks the parent.
+Consequently the return value from vfs_mkdir() can be passed to
+end_creating() and the parent will be unlocked precisely when necessary.
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index d0c3bb0423bb..b138120feba3 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -935,7 +935,7 @@ static noinline int btrfs_mksubvol(struct dentry *parent,
 out_up_read:
 	up_read(&fs_info->subvol_sem);
 out_dput:
-	end_creating(dentry, parent);
+	end_creating(dentry);
 	return ret;
 }
 
diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index 0104ac00485d..59327618ac42 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -128,10 +128,12 @@ struct dentry *cachefiles_get_directory(struct cachefiles_cache *cache,
 		if (ret < 0)
 			goto mkdir_error;
 		ret = cachefiles_inject_write_error();
-		if (ret == 0)
+		if (ret == 0) {
 			subdir = vfs_mkdir(&nop_mnt_idmap, d_inode(dir), subdir, 0700);
-		else
+		} else {
+			end_creating(subdir);
 			subdir = ERR_PTR(ret);
+		}
 		if (IS_ERR(subdir)) {
 			trace_cachefiles_vfs_error(NULL, d_inode(dir), ret,
 						   cachefiles_trace_mkdir_error);
@@ -140,7 +142,7 @@ struct dentry *cachefiles_get_directory(struct cachefiles_cache *cache,
 		trace_cachefiles_mkdir(dir, subdir);
 
 		if (unlikely(d_unhashed(subdir) || d_is_negative(subdir))) {
-			end_creating(subdir, dir);
+			end_creating(subdir);
 			goto retry;
 		}
 		ASSERT(d_backing_inode(subdir));
@@ -154,7 +156,7 @@ struct dentry *cachefiles_get_directory(struct cachefiles_cache *cache,
 	/* Tell rmdir() it's not allowed to delete the subdir */
 	inode_lock(d_inode(subdir));
 	dget(subdir);
-	end_creating(subdir, dir);
+	end_creating(subdir);
 
 	if (!__cachefiles_mark_inode_in_use(NULL, d_inode(subdir))) {
 		pr_notice("cachefiles: Inode already in use: %pd (B=%lx)\n",
@@ -196,7 +198,7 @@ struct dentry *cachefiles_get_directory(struct cachefiles_cache *cache,
 	return ERR_PTR(-EBUSY);
 
 mkdir_error:
-	end_creating(subdir, dir);
+	end_creating(subdir);
 	pr_err("mkdir %s failed with error %d\n", dirname, ret);
 	return ERR_PTR(ret);
 
@@ -699,7 +701,7 @@ bool cachefiles_commit_tmpfile(struct cachefiles_cache *cache,
 		if (ret < 0)
 			goto out_end;
 
-		end_creating(dentry, fan);
+		end_creating(dentry);
 
 		ret = cachefiles_inject_read_error();
 		if (ret == 0)
@@ -733,7 +735,7 @@ bool cachefiles_commit_tmpfile(struct cachefiles_cache *cache,
 	}
 
 out_end:
-	end_creating(dentry, fan);
+	end_creating(dentry);
 out:
 	_leave(" = %u", success);
 	return success;
diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index 37d6293600c7..c951e723f24d 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -211,7 +211,7 @@ ecryptfs_do_create(struct inode *directory_inode,
 	fsstack_copy_attr_times(directory_inode, lower_dir);
 	fsstack_copy_inode_size(directory_inode, lower_dir);
 out_lock:
-	end_creating(lower_dentry, NULL);
+	end_creating(lower_dentry);
 	return inode;
 }
 
@@ -456,7 +456,7 @@ static int ecryptfs_link(struct dentry *old_dentry, struct inode *dir,
 		  ecryptfs_inode_to_lower(d_inode(old_dentry))->i_nlink);
 	i_size_write(d_inode(new_dentry), file_size_save);
 out_lock:
-	end_creating(lower_new_dentry, NULL);
+	end_creating(lower_new_dentry);
 	return rc;
 }
 
@@ -500,7 +500,7 @@ static int ecryptfs_symlink(struct mnt_idmap *idmap,
 	fsstack_copy_attr_times(dir, lower_dir);
 	fsstack_copy_inode_size(dir, lower_dir);
 out_lock:
-	end_creating(lower_dentry, NULL);
+	end_creating(lower_dentry);
 	if (d_really_is_negative(dentry))
 		d_drop(dentry);
 	return rc;
@@ -534,7 +534,7 @@ static struct dentry *ecryptfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	fsstack_copy_inode_size(dir, lower_dir);
 	set_nlink(dir, lower_dir->i_nlink);
 out:
-	end_creating(lower_dentry, lower_dir_dentry);
+	end_creating(lower_dentry);
 	if (d_really_is_negative(dentry))
 		d_drop(dentry);
 	return ERR_PTR(rc);
diff --git a/fs/namei.c b/fs/namei.c
index 2444c7ddb926..e834486acff1 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4832,7 +4832,7 @@ EXPORT_SYMBOL(start_creating_path);
  */
 void end_creating_path(const struct path *path, struct dentry *dentry)
 {
-	end_creating(dentry, path->dentry);
+	end_creating(dentry);
 	mnt_drop_write(path->mnt);
 	path_put(path);
 }
@@ -5034,7 +5034,7 @@ struct dentry *vfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	return dentry;
 
 err:
-	dput(dentry);
+	end_creating(dentry);
 	return ERR_PTR(error);
 }
 EXPORT_SYMBOL(vfs_mkdir);
diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index e2aac0def2cb..6b39e4aff959 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -364,7 +364,7 @@ nfsd3_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	status = nfsd_create_setattr(rqstp, fhp, resfhp, &attrs);
 
 out:
-	end_creating(child, parent);
+	end_creating(child);
 out_write:
 	fh_drop_write(fhp);
 	return status;
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index b2c95e8e7c68..524cb07a477c 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -376,7 +376,7 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	if (attrs.na_aclerr)
 		open->op_bmval[0] &= ~FATTR4_WORD0_ACL;
 out:
-	end_creating(child, parent);
+	end_creating(child);
 	nfsd_attrs_free(&attrs);
 out_write:
 	fh_drop_write(fhp);
diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
index 3eefaa2202e3..18c08395b273 100644
--- a/fs/nfsd/nfs4recover.c
+++ b/fs/nfsd/nfs4recover.c
@@ -215,7 +215,7 @@ nfsd4_create_clid_dir(struct nfs4_client *clp)
 	if (IS_ERR(dentry))
 		status = PTR_ERR(dentry);
 out_end:
-	end_creating(dentry, dir);
+	end_creating(dentry);
 out:
 	if (status == 0) {
 		if (nn->in_grace)
diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index ee1b16e921fd..28f03a6a3cc3 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -421,7 +421,7 @@ nfsd_proc_create(struct svc_rqst *rqstp)
 	}
 
 out_unlock:
-	end_creating(dchild, dirfhp->fh_dentry);
+	end_creating(dchild);
 out_write:
 	fh_drop_write(dirfhp);
 done:
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index a993f1e54182..145f1c8d124d 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1589,7 +1589,7 @@ nfsd_create_locked(struct svc_rqst *rqstp, struct svc_fh *fhp,
 out:
 	if (!err)
 		fh_fill_post_attrs(fhp);
-	end_creating(dchild, dentry);
+	end_creating(dchild);
 	return err;
 
 out_nfserr:
@@ -1646,7 +1646,7 @@ nfsd_create(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	return err;
 
 out_unlock:
-	end_creating(dchild, dentry);
+	end_creating(dchild);
 	return err;
 }
 
@@ -1747,7 +1747,7 @@ nfsd_symlink(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		nfsd_create_setattr(rqstp, fhp, resfhp, attrs);
 	fh_fill_post_attrs(fhp);
 out_unlock:
-	end_creating(dnew, dentry);
+	end_creating(dnew);
 	if (!err)
 		err = nfserrno(commit_metadata(fhp));
 	if (!err)
@@ -1824,7 +1824,7 @@ nfsd_link(struct svc_rqst *rqstp, struct svc_fh *ffhp,
 	host_err = vfs_link(dold, &nop_mnt_idmap, dirp, dnew, NULL);
 	fh_fill_post_attrs(ffhp);
 out_unlock:
-	end_creating(dnew, ddir);
+	end_creating(dnew);
 	if (!host_err) {
 		host_err = commit_metadata(ffhp);
 		if (!host_err)
diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index 9911a346b477..23216ed01325 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -624,7 +624,7 @@ static int ovl_link_up(struct ovl_copy_up_ctx *c)
 			ovl_dentry_set_upper_alias(c->dentry);
 			ovl_dentry_update_reval(c->dentry, upper);
 		}
-		end_creating(upper, upperdir);
+		end_creating(upper);
 	}
 	if (err)
 		goto out;
@@ -891,7 +891,7 @@ static int ovl_copy_up_tmpfile(struct ovl_copy_up_ctx *c)
 	err = PTR_ERR(upper);
 	if (!IS_ERR(upper)) {
 		err = ovl_do_link(ofs, temp, udir, upper);
-		end_creating(upper, c->destdir);
+		end_creating(upper);
 	}
 
 	if (err)
diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 61e9484e4ab8..a4a0dc261310 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -91,7 +91,7 @@ static struct dentry *ovl_whiteout(struct ovl_fs *ofs)
 		err = ovl_do_whiteout(ofs, wdir, whiteout);
 		if (!err)
 			ofs->whiteout = dget(whiteout);
-		end_creating(whiteout, workdir);
+		end_creating(whiteout);
 		if (err)
 			return ERR_PTR(err);
 	}
@@ -103,7 +103,7 @@ static struct dentry *ovl_whiteout(struct ovl_fs *ofs)
 		err = ovl_do_link(ofs, ofs->whiteout, wdir, link);
 		if (!err)
 			whiteout = dget(link);
-		end_creating(link, workdir);
+		end_creating(link);
 		if (!err)
 			return whiteout;;
 
@@ -254,7 +254,7 @@ struct dentry *ovl_create_temp(struct ovl_fs *ofs, struct dentry *workdir,
 	ret = ovl_create_real(ofs, workdir, ret, attr);
 	if (!IS_ERR(ret))
 		dget(ret);
-	end_creating(ret, workdir);
+	end_creating(ret);
 	return ret;
 }
 
@@ -362,12 +362,11 @@ static int ovl_create_upper(struct dentry *dentry, struct inode *inode,
 	if (IS_ERR(newdentry))
 		return PTR_ERR(newdentry);
 	newdentry = ovl_create_real(ofs, upperdir, newdentry, attr);
-	if (IS_ERR(newdentry)) {
-		end_creating(newdentry, upperdir);
+	if (IS_ERR(newdentry))
 		return PTR_ERR(newdentry);
-	}
+
 	dget(newdentry);
-	end_creating(newdentry, upperdir);
+	end_creating(newdentry);
 
 	if (ovl_type_merge(dentry->d_parent) && d_is_dir(newdentry) &&
 	    !ovl_allow_offline_changes(ofs)) {
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index a721ef2b90e8..3acda985c8a3 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -320,7 +320,7 @@ static struct dentry *ovl_workdir_create(struct ovl_fs *ofs,
 
 		if (work->d_inode) {
 			dget(work);
-			end_creating(work, ofs->workbasedir);
+			end_creating(work);
 			if (persist)
 				return work;
 			err = -EEXIST;
@@ -338,7 +338,7 @@ static struct dentry *ovl_workdir_create(struct ovl_fs *ofs,
 		work = ovl_do_mkdir(ofs, dir, work, attr.ia_mode);
 		if (!IS_ERR(work))
 			dget(work);
-		end_creating(work, ofs->workbasedir);
+		end_creating(work);
 		err = PTR_ERR(work);
 		if (IS_ERR(work))
 			goto out_err;
@@ -632,7 +632,7 @@ static struct dentry *ovl_lookup_or_create(struct ovl_fs *ofs,
 						OVL_CATTR(mode));
 		if (!IS_ERR(child))
 			dget(child);
-		end_creating(child, parent);
+		end_creating(child);
 	}
 	dput(parent);
 
diff --git a/fs/xfs/scrub/orphanage.c b/fs/xfs/scrub/orphanage.c
index e732605924a1..b77c2b6b6d44 100644
--- a/fs/xfs/scrub/orphanage.c
+++ b/fs/xfs/scrub/orphanage.c
@@ -199,7 +199,7 @@ xrep_orphanage_create(
 	sc->orphanage_ilock_flags = 0;
 
 out_dput_orphanage:
-	end_creating(orphanage_dentry, root_dentry);
+	end_creating(orphanage_dentry);
 out_dput_root:
 	dput(root_dentry);
 out:
diff --git a/include/linux/namei.h b/include/linux/namei.h
index 0e6b1b9afc26..b4d95b79b5a8 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -106,34 +106,24 @@ struct dentry *start_creating_dentry(struct dentry *parent,
 struct dentry *start_removing_dentry(struct dentry *parent,
 				     struct dentry *child);
 
-/**
- * end_creating - finish action started with start_creating
- * @child:  dentry returned by start_creating() or vfs_mkdir()
- * @parent: dentry given to start_creating(),
- *
- * Unlock and release the child.
+/* end_creating - finish action started with start_creating
+ * @child: dentry returned by start_creating() or vfs_mkdir()
  *
- * Unlike end_dirop() this can only be called if start_creating() succeeded.
- * It handles @child being and error as vfs_mkdir() might have converted the
- * dentry to an error - in that case the parent still needs to be unlocked.
+ * Unlock and release the child. This can be called after
+ * start_creating() whether that function succeeded or not,
+ * but it is not needed on failure.
  *
  * If vfs_mkdir() was called then the value returned from that function
  * should be given for @child rather than the original dentry, as vfs_mkdir()
- * may have provided a new dentry.  Even if vfs_mkdir() returns an error
- * it must be given to end_creating().
+ * may have provided a new dentry.
+ *
  *
  * If vfs_mkdir() was not called, then @child will be a valid dentry and
  * @parent will be ignored.
  */
-static inline void end_creating(struct dentry *child, struct dentry *parent)
+static inline void end_creating(struct dentry *child)
 {
-	if (IS_ERR(child))
-		/* The parent is still locked despite the error from
-		 * vfs_mkdir() - must unlock it.
-		 */
-		inode_unlock(parent->d_inode);
-	else
-		end_dirop(child);
+	end_dirop(child);
 }
 
 /**
diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index 6d7610310003..83d9466710d6 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -932,7 +932,7 @@ static int do_mq_open(const char __user *u_name, int oflag, umode_t mode,
 		put_unused_fd(fd);
 		fd = error;
 	}
-	end_creating(path.dentry, root);
+	end_creating(path.dentry);
 	if (!ro)
 		mnt_drop_write(mnt);
 out_putname:
-- 
2.50.0.107.gf914562f5916.dirty


