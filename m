Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD3210851B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2019 22:34:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbfKXVeV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 24 Nov 2019 16:34:21 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:52718 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbfKXVeV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 24 Nov 2019 16:34:21 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iYzWJ-0007zX-VF; Sun, 24 Nov 2019 21:34:16 +0000
Date:   Sun, 24 Nov 2019 21:34:15 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Deepa Dinamani <deepa.kernel@gmail.com>
Cc:     Amir Goldstein <amir73il@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>
Subject: Re: [PATCH] utimes: Clamp the timestamps in notify_change()
Message-ID: <20191124213415.GD4203@ZenIV.linux.org.uk>
References: <20191124193145.22945-1-amir73il@gmail.com>
 <20191124194934.GB4203@ZenIV.linux.org.uk>
 <CABeXuvqZUK4UMLA=hU5i9r0k6G7E+RCi58Om-KVeZuA3OjL4fA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABeXuvqZUK4UMLA=hU5i9r0k6G7E+RCi58Om-KVeZuA3OjL4fA@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Nov 24, 2019 at 01:13:50PM -0800, Deepa Dinamani wrote:

> We also want to replace all uses of timespec64_trunc() with
> timestamp_truncate() for all fs cases.
> 
> In that case we have a few more:
> 
> fs/ceph/mds_client.c:   req->r_stamp = timespec64_trunc(ts,
> mdsc->fsc->sb->s_time_gran);

Umm... That comes from ktime_get_coarse_real_ts64(&ts);

> fs/cifs/inode.c:        fattr->cf_mtime =
> timespec64_trunc(fattr->cf_mtime, sb->s_time_gran);
ktime_get_real_ts64(&fattr->cf_mtime) here

> fs/cifs/inode.c:                fattr->cf_atime =
> timespec64_trunc(fattr->cf_atime, sb->s_time_gran);
ditto

> fs/fat/misc.c:                  inode->i_ctime =
> timespec64_trunc(*now, 10000000);

I wonder... some are from setattr, some (with NULL passed to fat_truncate_time())
from current_time()...  Wouldn't it make more sense to move the truncation into
the few callers that really need it (if any)?  Quite a few of those are *also*
getting the value from current_time(), after all.  fat_fill_inode() looks like
the only case that doesn't fall into these classes; does it need truncation?

BTW, could we *please* do something about fs/inode.c:update_time()?  I mean,
sure, local variable shadows file-scope function, so it's legitimate C, but
this is not IOCCC and having a function called 'update_time' end with
        return update_time(inode, time, flags);
is actively hostile towards casual readers...

> fs/fat/misc.c:                  inode->i_ctime =
> fat_timespec64_trunc_2secs(*now);
> fs/fat/misc.c:          inode->i_mtime = fat_timespec64_trunc_2secs(*now);
> fs/ubifs/sb.c:  ts = timespec64_trunc(ts, DEFAULT_TIME_GRAN);
> 
> These do not follow from notify_change(), so these might still need
> timestamp_truncate() exported.
> I will post a cleanup series for timespec64_trunc() also, then we can decide.

What I've got right now is

commit 6d13412e2b27970810037f7b1b418febcd7013aa
Author: Amir Goldstein <amir73il@gmail.com>
Date:   Sun Nov 24 21:31:45 2019 +0200

    utimes: Clamp the timestamps in notify_change()
    
    Push clamping timestamps into notify_change(), so in-kernel
    callers like nfsd and overlayfs will get similar timestamp
    set behavior as utimes.
    
    AV: get rid of clamping in ->setattr() instances; we don't need
    to bother with that there, with notify_change() doing normalization
    in all cases now (it already did for implicit case, since current_time()
    clamps).
    
    Suggested-by: Miklos Szeredi <mszeredi@redhat.com>
    Fixes: 42e729b9ddbb ("utimes: Clamp the timestamps before update")
    Cc: stable@vger.kernel.org # v5.4
    Cc: Deepa Dinamani <deepa.kernel@gmail.com>
    Cc: Jeff Layton <jlayton@kernel.org>
    Signed-off-by: Amir Goldstein <amir73il@gmail.com>
    Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

diff --git a/fs/attr.c b/fs/attr.c
index df28035aa23e..b4bbdbd4c8ca 100644
--- a/fs/attr.c
+++ b/fs/attr.c
@@ -183,18 +183,12 @@ void setattr_copy(struct inode *inode, const struct iattr *attr)
 		inode->i_uid = attr->ia_uid;
 	if (ia_valid & ATTR_GID)
 		inode->i_gid = attr->ia_gid;
-	if (ia_valid & ATTR_ATIME) {
-		inode->i_atime = timestamp_truncate(attr->ia_atime,
-						  inode);
-	}
-	if (ia_valid & ATTR_MTIME) {
-		inode->i_mtime = timestamp_truncate(attr->ia_mtime,
-						  inode);
-	}
-	if (ia_valid & ATTR_CTIME) {
-		inode->i_ctime = timestamp_truncate(attr->ia_ctime,
-						  inode);
-	}
+	if (ia_valid & ATTR_ATIME)
+		inode->i_atime = attr->ia_atime;
+	if (ia_valid & ATTR_MTIME)
+		inode->i_mtime = attr->ia_mtime;
+	if (ia_valid & ATTR_CTIME)
+		inode->i_ctime = attr->ia_ctime;
 	if (ia_valid & ATTR_MODE) {
 		umode_t mode = attr->ia_mode;
 
@@ -268,8 +262,13 @@ int notify_change(struct dentry * dentry, struct iattr * attr, struct inode **de
 	attr->ia_ctime = now;
 	if (!(ia_valid & ATTR_ATIME_SET))
 		attr->ia_atime = now;
+	else
+		attr->ia_atime = timestamp_truncate(attr->ia_atime, inode);
 	if (!(ia_valid & ATTR_MTIME_SET))
 		attr->ia_mtime = now;
+	else
+		attr->ia_mtime = timestamp_truncate(attr->ia_mtime, inode);
+
 	if (ia_valid & ATTR_KILL_PRIV) {
 		error = security_inode_need_killpriv(dentry);
 		if (error < 0)
diff --git a/fs/configfs/inode.c b/fs/configfs/inode.c
index 680aba9c00d5..fd0b5dd68f9e 100644
--- a/fs/configfs/inode.c
+++ b/fs/configfs/inode.c
@@ -76,14 +76,11 @@ int configfs_setattr(struct dentry * dentry, struct iattr * iattr)
 	if (ia_valid & ATTR_GID)
 		sd_iattr->ia_gid = iattr->ia_gid;
 	if (ia_valid & ATTR_ATIME)
-		sd_iattr->ia_atime = timestamp_truncate(iattr->ia_atime,
-						      inode);
+		sd_iattr->ia_atime = iattr->ia_atime;
 	if (ia_valid & ATTR_MTIME)
-		sd_iattr->ia_mtime = timestamp_truncate(iattr->ia_mtime,
-						      inode);
+		sd_iattr->ia_mtime = iattr->ia_mtime;
 	if (ia_valid & ATTR_CTIME)
-		sd_iattr->ia_ctime = timestamp_truncate(iattr->ia_ctime,
-						      inode);
+		sd_iattr->ia_ctime = iattr->ia_ctime;
 	if (ia_valid & ATTR_MODE) {
 		umode_t mode = iattr->ia_mode;
 
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 29bc0a542759..a286564ba2e1 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -751,18 +751,12 @@ static void __setattr_copy(struct inode *inode, const struct iattr *attr)
 		inode->i_uid = attr->ia_uid;
 	if (ia_valid & ATTR_GID)
 		inode->i_gid = attr->ia_gid;
-	if (ia_valid & ATTR_ATIME) {
-		inode->i_atime = timestamp_truncate(attr->ia_atime,
-						  inode);
-	}
-	if (ia_valid & ATTR_MTIME) {
-		inode->i_mtime = timestamp_truncate(attr->ia_mtime,
-						  inode);
-	}
-	if (ia_valid & ATTR_CTIME) {
-		inode->i_ctime = timestamp_truncate(attr->ia_ctime,
-						  inode);
-	}
+	if (ia_valid & ATTR_ATIME)
+		inode->i_atime = attr->ia_atime;
+	if (ia_valid & ATTR_MTIME)
+		inode->i_mtime = attr->ia_mtime;
+	if (ia_valid & ATTR_CTIME)
+		inode->i_ctime = attr->ia_ctime;
 	if (ia_valid & ATTR_MODE) {
 		umode_t mode = attr->ia_mode;
 
diff --git a/fs/ntfs/inode.c b/fs/ntfs/inode.c
index 6c7388430ad3..d4359a1df3d5 100644
--- a/fs/ntfs/inode.c
+++ b/fs/ntfs/inode.c
@@ -2899,18 +2899,12 @@ int ntfs_setattr(struct dentry *dentry, struct iattr *attr)
 			ia_valid |= ATTR_MTIME | ATTR_CTIME;
 		}
 	}
-	if (ia_valid & ATTR_ATIME) {
-		vi->i_atime = timestamp_truncate(attr->ia_atime,
-					       vi);
-	}
-	if (ia_valid & ATTR_MTIME) {
-		vi->i_mtime = timestamp_truncate(attr->ia_mtime,
-					       vi);
-	}
-	if (ia_valid & ATTR_CTIME) {
-		vi->i_ctime = timestamp_truncate(attr->ia_ctime,
-					       vi);
-	}
+	if (ia_valid & ATTR_ATIME)
+		vi->i_atime = attr->ia_atime;
+	if (ia_valid & ATTR_MTIME)
+		vi->i_mtime = attr->ia_mtime;
+	if (ia_valid & ATTR_CTIME)
+		vi->i_ctime = attr->ia_ctime;
 	mark_inode_dirty(vi);
 out:
 	return err;
diff --git a/fs/ubifs/file.c b/fs/ubifs/file.c
index cd52585c8f4f..91362079f82a 100644
--- a/fs/ubifs/file.c
+++ b/fs/ubifs/file.c
@@ -1078,18 +1078,12 @@ static void do_attr_changes(struct inode *inode, const struct iattr *attr)
 		inode->i_uid = attr->ia_uid;
 	if (attr->ia_valid & ATTR_GID)
 		inode->i_gid = attr->ia_gid;
-	if (attr->ia_valid & ATTR_ATIME) {
-		inode->i_atime = timestamp_truncate(attr->ia_atime,
-						  inode);
-	}
-	if (attr->ia_valid & ATTR_MTIME) {
-		inode->i_mtime = timestamp_truncate(attr->ia_mtime,
-						  inode);
-	}
-	if (attr->ia_valid & ATTR_CTIME) {
-		inode->i_ctime = timestamp_truncate(attr->ia_ctime,
-						  inode);
-	}
+	if (attr->ia_valid & ATTR_ATIME)
+		inode->i_atime = attr->ia_atime;
+	if (attr->ia_valid & ATTR_MTIME)
+		inode->i_mtime = attr->ia_mtime;
+	if (attr->ia_valid & ATTR_CTIME)
+		inode->i_ctime = attr->ia_ctime;
 	if (attr->ia_valid & ATTR_MODE) {
 		umode_t mode = attr->ia_mode;
 
diff --git a/fs/utimes.c b/fs/utimes.c
index 1ba3f7883870..090739322463 100644
--- a/fs/utimes.c
+++ b/fs/utimes.c
@@ -36,14 +36,14 @@ static int utimes_common(const struct path *path, struct timespec64 *times)
 		if (times[0].tv_nsec == UTIME_OMIT)
 			newattrs.ia_valid &= ~ATTR_ATIME;
 		else if (times[0].tv_nsec != UTIME_NOW) {
-			newattrs.ia_atime = timestamp_truncate(times[0], inode);
+			newattrs.ia_atime = times[0];
 			newattrs.ia_valid |= ATTR_ATIME_SET;
 		}
 
 		if (times[1].tv_nsec == UTIME_OMIT)
 			newattrs.ia_valid &= ~ATTR_MTIME;
 		else if (times[1].tv_nsec != UTIME_NOW) {
-			newattrs.ia_mtime = timestamp_truncate(times[1], inode);
+			newattrs.ia_mtime = times[1];
 			newattrs.ia_valid |= ATTR_MTIME_SET;
 		}
 		/*
