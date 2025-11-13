Return-Path: <linux-fsdevel+bounces-68138-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E528AC55105
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 01:52:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 277023B2749
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 00:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B247C1B87C0;
	Thu, 13 Nov 2025 00:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="X9bQCE6j";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LxsR5wNm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-b5-smtp.messagingengine.com (flow-b5-smtp.messagingengine.com [202.12.124.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC57E1A9FBC;
	Thu, 13 Nov 2025 00:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762994577; cv=none; b=QHdaPT9y2VHrz2ttD/F54Q1y3Bn5bQ1owyB6Q8n41mw8WNEbFYldTmGyJxgfGmmQ7uXhSLPJfJns2yI4YSUWFUnlH8AtdCMzWFUIBqK6xJBU3OpQT2b453HSTATVn8MypWzPQ2iv3a9MkTptYo5PPbMmRTFVsgtY3GCwnM8XHRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762994577; c=relaxed/simple;
	bh=EAEQiQ0RRXiBTHnh6+T7tsdNOoRoBtPrB+5U2X/DaC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cmWRJum7F/2fsbsKQ+wueigU7Ospbidx96MDiSsDudmtWMrRj2nPf0K/kd9u9OBDrQ2jtbu6WlImctsGkm9taidHy1MBtD5X7KNkpsgOcc6XHRmdIjA2Tj3V2xvBvrslRl7Q5O7itoaE60a3t+xDma5Wli8Zn3fpmrI8sKuWku0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=X9bQCE6j; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LxsR5wNm; arc=none smtp.client-ip=202.12.124.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailflow.stl.internal (Postfix) with ESMTP id 588C61300C8F;
	Wed, 12 Nov 2025 19:42:54 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Wed, 12 Nov 2025 19:42:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1762994574;
	 x=1763001774; bh=yqqJA4rj418/PYsYG14TTyYYF0JXqvTALHGdmZWfrgY=; b=
	X9bQCE6jBaoccWqQnVWPKZyauJZE1sMtvTZ+XhVVAwKrWuJDu94M8gZwImqvSUnm
	e1dF3/LIQqbmKLC5ySxA9YVZoxXGRbmtxweJ03rzeiS1idiNqCMyB5ms7ftFUAA5
	fBs3scgkjBkibMg+E8luh2mIs4Zkf9ubIx4gzyHXEsSkkcg9DjynQsFxf3AzOzYI
	BrHbmcqxUgofa5sS7vsDE2zVB0gQVrh86bjHkhdUf7P2A/TthtBidDvWb5S/zjba
	BscqjPQcqjIQTJlO3uy1yQ30S6zJK5b6gGxZ73r66gqeF3LKvkg2DYvzjezjZ4Yk
	BKgm8BzeVJu2z88sD2+chQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1762994574; x=1763001774; bh=y
	qqJA4rj418/PYsYG14TTyYYF0JXqvTALHGdmZWfrgY=; b=LxsR5wNmz5WXWqjGH
	EciA3mn7TEN5hcyXTE+bKLhUOBPDIh0UWr9XMAy7VfctaiZ/7tZvR6M80sumEmS4
	dS4+tvPsaRicDZtrET5W/Y2lrEwH1fBfeT+S+q6VHBkbFota76B/xoxqpR5IF6Dj
	FqCpd2O1tQBeWyerlWtVZZJvuLWoirDNEO0eU3/fwZIoNV7dOtyCo/7QuuNAZ2c/
	ttvVIyYahdgc0OFdLQKUJUgeap0NS4etdc2oVmrjs/Yx/9X0SfrlSPOvfIuMps1w
	5mz099laGgRuoivEhIjDYkxzERvTaO6Y3Pw8kaVeCDS1pLvRaNQQDX59BKosSbjL
	I85bw==
X-ME-Sender: <xms:jSkVaVsGU1AkGOjtQm6kIUiMYxMaV2p2cGn2xgPfUYMi4ozJ0wpcMQ>
    <xme:jSkVaThF9X1rMnV-NR-leQSqPF-i9_c518g9ipAl2b2icdaMju6L1032d1vc9XN4I
    5NB2z2jxu0N2tMmPdVrXUHarPzrLijiUcjgT7PbKDK5siMG>
X-ME-Received: <xmr:jSkVaVwOZUgmoS7liz9y-G1wgQ6EKy-UUsK22WzaGDKwpcSfiPdclTtCbj7q2Q6tvj9st443vsfIq76U7CNLtM3Yj5ZM6EshjrsL0B5UqwQy>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdehheegucetufdoteggodetrf
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
X-ME-Proxy: <xmx:jSkVaZ5m7BdttmDTfqbqav5VG4cWJ_Uj-n3Hcmww4ZNHk2C7PfNOIA>
    <xmx:jSkVaXc8Eu26ZfZ3dTvv6XA5AoZfcHvXS8ZGg3TZpJBB2_UPNToNBA>
    <xmx:jSkVaRq3p5ZXJ0Sjfmk_ExJmovEXTYuYJE8aTSyeLRVy4TDsq59BLw>
    <xmx:jSkVab1mGwgszlLul3-rP99AvwctzpUM1FZMjyV2BNKJUnI3v2DqLQ>
    <xmx:jikVaWsKdVc1DxVWdyDzZlMPUwi67c9smnqaaeobW-eWepC8Z-NfB_hY>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Nov 2025 19:42:43 -0500 (EST)
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
Subject: [PATCH v6 14/15] VFS: change vfs_mkdir() to unlock on failure.
Date: Thu, 13 Nov 2025 11:18:37 +1100
Message-ID: <20251113002050.676694-15-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20251113002050.676694-1-neilb@ownmail.net>
References: <20251113002050.676694-1-neilb@ownmail.net>
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

ovl_create_real() will now unlock on error.  So the conditional
end_creating() after the call is removed, and end_creating() is called
internally on error.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Tested-by: syzbot@syzkaller.appspotmail.com
Signed-off-by: NeilBrown <neil@brown.name>

---
changes since v5
 - ovl_create_real() now calls end_creating() on error.
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
 fs/overlayfs/dir.c                    | 18 ++++++++---------
 fs/overlayfs/super.c                  |  6 +++---
 fs/xfs/scrub/orphanage.c              |  2 +-
 include/linux/namei.h                 | 28 +++++++++------------------
 ipc/mqueue.c                          |  2 +-
 16 files changed, 61 insertions(+), 58 deletions(-)

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
index 61e9484e4ab8..739f974dc258 100644
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
 
@@ -187,7 +187,7 @@ struct dentry *ovl_create_real(struct ovl_fs *ofs, struct dentry *parent,
 			if (!err && ofs->casefold != ovl_dentry_casefolded(newdentry)) {
 				pr_warn_ratelimited("wrong inherited casefold (%pd2)\n",
 						    newdentry);
-				dput(newdentry);
+				end_creating(newdentry);
 				err = -EINVAL;
 			}
 			break;
@@ -237,8 +237,7 @@ struct dentry *ovl_create_real(struct ovl_fs *ofs, struct dentry *parent,
 	}
 out:
 	if (err) {
-		if (!IS_ERR(newdentry))
-			dput(newdentry);
+		end_creating(newdentry);
 		return ERR_PTR(err);
 	}
 	return newdentry;
@@ -254,7 +253,7 @@ struct dentry *ovl_create_temp(struct ovl_fs *ofs, struct dentry *workdir,
 	ret = ovl_create_real(ofs, workdir, ret, attr);
 	if (!IS_ERR(ret))
 		dget(ret);
-	end_creating(ret, workdir);
+	end_creating(ret);
 	return ret;
 }
 
@@ -362,12 +361,11 @@ static int ovl_create_upper(struct dentry *dentry, struct inode *inode,
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


