Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54D09FCEFC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2019 20:55:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbfKNTzw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Nov 2019 14:55:52 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46488 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726474AbfKNTzw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Nov 2019 14:55:52 -0500
Received: by mail-wr1-f68.google.com with SMTP id b3so8021140wrs.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Nov 2019 11:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wcxBRQ29xnxU5Y9UL6AGFLVVPVxLVFbf1Hf8+WtVO5g=;
        b=BFYdVXTbKRu/m+SMcQPoHqwbwI3pNa9TjwMMYmZicmPXGCHifINOCFQZzQQjDIKOd0
         /QTZBU/aMn3c5ICHlnrSIQ0mkrULDIqpLjh+mBuA3eaNEaDh+7ztxDvk3RR51FjTZgcc
         MSPCO2RQbEg5GK39QqqpWulMZm8aUQykJR//8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wcxBRQ29xnxU5Y9UL6AGFLVVPVxLVFbf1Hf8+WtVO5g=;
        b=Wzyt76VoNiuBlJ7x/JVScON5VN9ZQzjqnFikvJHlCKdWrAT+Pi1GfEL2v9ziy1Epz/
         po2iHivlnkI7WKyzCQAgVhpc/ubySmAV9bV6FvYlmj4gK8PefLaU5M6w3E+Xt/Az5Qd3
         5Q77ASk9sFo1EiZIUXk8tBhAZf43Yqyk4XIpMiIwrSwLAGjRFpx5VDKiU5sU2LEpdgk0
         3w23wT4ERKGa8rYpfFHUzAegNrvsBgJRNDCo1Yb4TDuiAunW8tjpPzlcZuc/vrKqdJ8R
         3AcLbyF2QkXhOVR18Tmu/4rL10oEGyHhfvsgn7jidJFn+I37CnE732kNFfnmaFK6vHm8
         cfaw==
X-Gm-Message-State: APjAAAWYFDb6IyS9/k4hUeujqTThrm3zOkvDClTHFgOqSFT+dtuj9GSy
        C6PE8i9tZe9tal5jLnbk+kkYfw==
X-Google-Smtp-Source: APXvYqyab/oIRJv3swgEHrQbrEGDk75slT7tgN4sXu3Q2k/eZY8ehb5fHbGHbaM034xwf+rX9tuGTQ==
X-Received: by 2002:a5d:4e89:: with SMTP id e9mr11030822wru.342.1573761347793;
        Thu, 14 Nov 2019 11:55:47 -0800 (PST)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id g5sm7916089wmf.37.2019.11.14.11.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2019 11:55:46 -0800 (PST)
Date:   Thu, 14 Nov 2019 20:55:44 +0100
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org,
        linux-nfs@vger.kernel.org, "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [RFC] is ovl_fh->fid really intended to be misaligned?
Message-ID: <20191114195544.GB5569@miu.piliscsaba.redhat.com>
References: <20191114154723.GJ26530@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191114154723.GJ26530@ZenIV.linux.org.uk>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 14, 2019 at 03:47:23PM +0000, Al Viro wrote:
> AFAICS, this
>         bytes = (fh->len - offsetof(struct ovl_fh, fid));
>         real = exportfs_decode_fh(mnt, (struct fid *)fh->fid,
>                                   bytes >> 2, (int)fh->type,
>                                   connected ? ovl_acceptable : NULL, mnt);
> in ovl_decode_real_fh() combined with
>                 origin = ovl_decode_real_fh(fh, ofs->lower_layers[i].mnt,
>                                             connected);
> in ovl_check_origin_fh(),
>         /* First lookup overlay inode in inode cache by origin fh */
>         err = ovl_check_origin_fh(ofs, fh, false, NULL, &stack);
> in ovl_lower_fh_to_d() and
>         struct ovl_fh *fh = (struct ovl_fh *) fid;
> ...
>                  ovl_lower_fh_to_d(sb, fh);
> in ovl_fh_to_dentry() leads to the pointer to struct fid passed to
> exportfs_decode_fh() being 21 bytes ahead of that passed to
> ovl_fh_to_dentry().  
> 
> However, alignment of struct fid pointers is 32 bits and quite a few
> places dealing with those (including ->fh_to_dentry() instances)
> do access them directly.  Argument of ->fh_to_dentry() is supposed
> to be 32bit-aligned, and callers generally guarantee that.  Your
> code, OTOH, violates the alignment systematically there - what
> it passes to layers' ->fh_to_dentry() (by way of exportfs_decode_fh())
> always has two lower bits different from what it got itself.
> 
> What do we do with that?  One solution would be to insert sane padding
> in ovl_fh, but the damn thing appears to be stored as-is in xattrs on
> disk, so that would require rather unpleasant operations reinserting
> the padding on the fly ;-/

Something like this?  Totally untested...

Thanks,
Miklos

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index b801c6353100..60a4ca72cb4e 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -253,7 +253,7 @@ struct ovl_fh *ovl_encode_real_fh(struct dentry *real, bool is_upper)
 
 	BUILD_BUG_ON(MAX_HANDLE_SZ + offsetof(struct ovl_fh, fid) > 255);
 	fh_len = offsetof(struct ovl_fh, fid) + buflen;
-	fh = kmalloc(fh_len, GFP_KERNEL);
+	fh = kzalloc(fh_len, GFP_KERNEL);
 	if (!fh) {
 		fh = ERR_PTR(-ENOMEM);
 		goto out;
@@ -271,7 +271,7 @@ struct ovl_fh *ovl_encode_real_fh(struct dentry *real, bool is_upper)
 	 */
 	if (is_upper)
 		fh->flags |= OVL_FH_FLAG_PATH_UPPER;
-	fh->len = fh_len;
+	fh->len = fh_len - OVL_FH_WIRE_OFFSET;
 	fh->uuid = *uuid;
 	memcpy(fh->fid, buf, buflen);
 
@@ -300,7 +300,8 @@ int ovl_set_origin(struct dentry *dentry, struct dentry *lower,
 	/*
 	 * Do not fail when upper doesn't support xattrs.
 	 */
-	err = ovl_check_setxattr(dentry, upper, OVL_XATTR_ORIGIN, fh,
+	err = ovl_check_setxattr(dentry, upper, OVL_XATTR_ORIGIN,
+				 fh ? OVL_FH_START(fh) : NULL,
 				 fh ? fh->len : 0, 0);
 	kfree(fh);
 
@@ -317,7 +318,8 @@ static int ovl_set_upper_fh(struct dentry *upper, struct dentry *index)
 	if (IS_ERR(fh))
 		return PTR_ERR(fh);
 
-	err = ovl_do_setxattr(index, OVL_XATTR_UPPER, fh, fh->len, 0);
+	err = ovl_do_setxattr(index, OVL_XATTR_UPPER,
+			      OVL_FH_START(fh), fh->len, 0);
 
 	kfree(fh);
 	return err;
diff --git a/fs/overlayfs/export.c b/fs/overlayfs/export.c
index 73c9775215b3..dedda95c7746 100644
--- a/fs/overlayfs/export.c
+++ b/fs/overlayfs/export.c
@@ -234,7 +234,7 @@ static int ovl_d_to_fh(struct dentry *dentry, char *buf, int buflen)
 	if (fh->len > buflen)
 		goto fail;
 
-	memcpy(buf, (char *)fh, fh->len);
+	memcpy(buf, OVL_FH_START(fh), fh->len);
 	err = fh->len;
 
 out:
@@ -260,6 +260,7 @@ static int ovl_dentry_to_fh(struct dentry *dentry, u32 *fid, int *max_len)
 
 	/* Round up to dwords */
 	*max_len = (len + 3) >> 2;
+	memset(fid + len, 0, (*max_len << 2) - len);
 	return OVL_FILEID;
 }
 
@@ -781,7 +782,7 @@ static struct dentry *ovl_fh_to_dentry(struct super_block *sb, struct fid *fid,
 				       int fh_len, int fh_type)
 {
 	struct dentry *dentry = NULL;
-	struct ovl_fh *fh = (struct ovl_fh *) fid;
+	struct ovl_fh *fh = (void *) fid - OVL_FH_WIRE_OFFSET;
 	int len = fh_len << 2;
 	unsigned int flags = 0;
 	int err;
diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
index e9717c2f7d45..f22a65359df1 100644
--- a/fs/overlayfs/namei.c
+++ b/fs/overlayfs/namei.c
@@ -86,7 +86,8 @@ static int ovl_acceptable(void *ctx, struct dentry *dentry)
  */
 int ovl_check_fh_len(struct ovl_fh *fh, int fh_len)
 {
-	if (fh_len < sizeof(struct ovl_fh) || fh_len < fh->len)
+	if (fh_len < sizeof(struct ovl_fh) - OVL_FH_WIRE_OFFSET ||
+	    fh_len < fh->len)
 		return -EINVAL;
 
 	if (fh->magic != OVL_FH_MAGIC)
@@ -119,11 +120,11 @@ static struct ovl_fh *ovl_get_fh(struct dentry *dentry, const char *name)
 	if (res == 0)
 		return NULL;
 
-	fh = kzalloc(res, GFP_KERNEL);
+	fh = kzalloc(res + OVL_FH_WIRE_OFFSET, GFP_KERNEL);
 	if (!fh)
 		return ERR_PTR(-ENOMEM);
 
-	res = vfs_getxattr(dentry, name, fh, res);
+	res = vfs_getxattr(dentry, name, fh + OVL_FH_WIRE_OFFSET, res);
 	if (res < 0)
 		goto fail;
 
@@ -161,7 +162,7 @@ struct dentry *ovl_decode_real_fh(struct ovl_fh *fh, struct vfsmount *mnt,
 	if (!uuid_equal(&fh->uuid, &mnt->mnt_sb->s_uuid))
 		return NULL;
 
-	bytes = (fh->len - offsetof(struct ovl_fh, fid));
+	bytes = (fh->len + OVL_FH_WIRE_OFFSET - offsetof(struct ovl_fh, fid));
 	real = exportfs_decode_fh(mnt, (struct fid *)fh->fid,
 				  bytes >> 2, (int)fh->type,
 				  connected ? ovl_acceptable : NULL, mnt);
@@ -433,7 +434,8 @@ int ovl_verify_set_fh(struct dentry *dentry, const char *name,
 
 	err = ovl_verify_fh(dentry, name, fh);
 	if (set && err == -ENODATA)
-		err = ovl_do_setxattr(dentry, name, fh, fh->len, 0);
+		err = ovl_do_setxattr(dentry, name,
+				      OVL_FH_START(fh), fh->len, 0);
 	if (err)
 		goto fail;
 
@@ -512,12 +514,12 @@ int ovl_verify_index(struct ovl_fs *ofs, struct dentry *index)
 
 	err = -ENOMEM;
 	len = index->d_name.len / 2;
-	fh = kzalloc(len, GFP_KERNEL);
+	fh = kzalloc(len + OVL_FH_WIRE_OFFSET, GFP_KERNEL);
 	if (!fh)
 		goto fail;
 
 	err = -EINVAL;
-	if (hex2bin((u8 *)fh, index->d_name.name, len))
+	if (hex2bin(OVL_FH_START(fh), index->d_name.name, len))
 		goto fail;
 
 	err = ovl_check_fh_len(fh, len);
@@ -603,7 +605,7 @@ static int ovl_get_index_name_fh(struct ovl_fh *fh, struct qstr *name)
 	if (!n)
 		return -ENOMEM;
 
-	s  = bin2hex(n, fh, fh->len);
+	s  = bin2hex(n, OVL_FH_START(fh), fh->len);
 	*name = (struct qstr) QSTR_INIT(n, s - n);
 
 	return 0;
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 6934bcf030f0..c62083671a12 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -74,8 +74,13 @@ enum ovl_entry_flag {
 /* The type returned by overlay exportfs ops when encoding an ovl_fh handle */
 #define OVL_FILEID	0xfb
 
-/* On-disk and in-memeory format for redirect by file handle */
+#define OVL_FH_WIRE_OFFSET 3
+#define OVL_FH_START(fh) ((void *)(fh) + OVL_FH_WIRE_OFFSET)
 struct ovl_fh {
+	/* make sure fid is 32bit aligned */
+	u8 padding[OVL_FH_WIRE_OFFSET];
+
+	/* Wire/xattr encoding begins here*/
 	u8 version;	/* 0 */
 	u8 magic;	/* 0xfb */
 	u8 len;		/* size of this header + size of fid */
