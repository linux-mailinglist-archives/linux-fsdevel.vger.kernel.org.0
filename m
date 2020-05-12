Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F054B1CEF2E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 May 2020 10:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728949AbgELIcX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 May 2020 04:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726187AbgELIcW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 May 2020 04:32:22 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C324C061A0E
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2020 01:32:22 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id h17so5354529wrc.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2020 01:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jEUMt72AsTKxfme4wNG0oUTNwGvf5pH41IsNwcOgwms=;
        b=RifJNjUt64Icz1NiKHKwkCKh2RKa2VgjpicSyBfYKSBlmRrove9w8ntdLgSr8qV4zx
         r5IFUvgOS/kGlCkiaDnz2RWKlMWnLzgfM+mY8wJwgvweDjKnaQ9iV+1KsN3k+ySL5vIp
         5lBdfjopVc7IZ2tRfn4NKJQ7PkaYKcTtZX508=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jEUMt72AsTKxfme4wNG0oUTNwGvf5pH41IsNwcOgwms=;
        b=hKlaRw0EgiPeEcT5OkFMXqA5xA+CQVjWyq7KAUXOKpN5egGXfzhAk4QVJ45ztAY5ll
         AQWcB3ZMj4IA5qMQ2xkElLkszlg0zzZB93boy89mryLWnBwHBo6+n1q6xXkr6MAJp/hu
         +6Zdsh1agTOq4StOyMaqr4rx1xGWZFs2sHalQAzO3HFMhJK2LF2+7bDx4iuj6ON64KWS
         zuZ/O1qMOmDCAm65ytGWoCz+OAfH19W8wf675UlMk1Zxe1XQ8MZlTX6E1pUxLLLLoswO
         2feiL0cRdlXZwERVvVyNpe8az9IdH/9G7ddFN/rXFltIn0Pjv8qFsg1rx6dVF64RacqV
         9Ung==
X-Gm-Message-State: AGi0Pubh3X+LEbiNNRGp+czse7bgOpQKRkTB+KZNeyVn7ozLvQH1Vrp1
        0J+5KUflGd2+hiYh4cAwRc+6AA==
X-Google-Smtp-Source: APiQypK88FqMBq9cfTkp7YQHtHg0zGTKwhN+qa3uxM7LH8SVKFYOEzbVqy+p2Vs15jP8mEpgbWjRgA==
X-Received: by 2002:adf:e5cd:: with SMTP id a13mr3654656wrn.266.1589272340694;
        Tue, 12 May 2020 01:32:20 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id s8sm21000989wrt.69.2020.05.12.01.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 01:32:19 -0700 (PDT)
Date:   Tue, 12 May 2020 10:32:17 +0200
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Chengguang Xu <cgxu519@mykernel.net>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH v2] ovl: suppress negative dentry in lookup
Message-ID: <20200512083217.GC13131@miu.piliscsaba.redhat.com>
References: <20200512071313.4525-1-cgxu519@mykernel.net>
 <CAOQ4uxiA_Er_VA=m8ORovGyvHDFuGBS4Ss_ef5un5VJbrev3jw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxiA_Er_VA=m8ORovGyvHDFuGBS4Ss_ef5un5VJbrev3jw@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 12, 2020 at 10:50:31AM +0300, Amir Goldstein wrote:

> This helper should be in vfs code, not duplicating vfs code
> and please don't duplicate code in vfs either.
> 
> I think you can use a lookup flag (LOOKUP_POSITIVE_CACHE???)
> to describe the desired behavior and implement it inside
> lookup_slow(). Document the semantics as well as explain
> in the context of the helper the cases where modules might
> find this useful (because they have higher level caches).
> 
> Besides the fact that this helper really needs review by Al
> and that duplicating subtle code is wrong in so many levels,
> I suppose the functionality could prove useful to other subsystems
> as well.

Something like this (untested).  Needs splitup and changelogs.

Thanks,
Miklos

---
diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
index c31f362fa098..e52a3b35ebac 100644
--- a/fs/cifs/cifsfs.c
+++ b/fs/cifs/cifsfs.c
@@ -752,7 +752,7 @@ cifs_get_root(struct smb_vol *vol, struct super_block *sb)
 		while (*s && *s != sep)
 			s++;
 
-		child = lookup_positive_unlocked(p, dentry, s - p);
+		child = lookup_positive_unlocked(p, dentry, s - p, 0);
 		dput(dentry);
 		dentry = child;
 	} while (!IS_ERR(dentry));
diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index b7f2e971ecbc..df4f37a6a9ab 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -299,7 +299,7 @@ struct dentry *debugfs_lookup(const char *name, struct dentry *parent)
 	if (!parent)
 		parent = debugfs_mount->mnt_root;
 
-	dentry = lookup_positive_unlocked(name, parent, strlen(name));
+	dentry = lookup_positive_unlocked(name, parent, strlen(name), 0);
 	if (IS_ERR(dentry))
 		return NULL;
 	return dentry;
diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index e23752d9a79f..e39af6313ad9 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -407,7 +407,7 @@ static struct dentry *ecryptfs_lookup(struct inode *ecryptfs_dir_inode,
 		name = encrypted_and_encoded_name;
 	}
 
-	lower_dentry = lookup_one_len_unlocked(name, lower_dir_dentry, len);
+	lower_dentry = lookup_one_len_unlocked(name, lower_dir_dentry, len, 0);
 	if (IS_ERR(lower_dentry)) {
 		ecryptfs_printk(KERN_DEBUG, "%s: lookup_one_len() returned "
 				"[%ld] on lower_dentry = [%s]\n", __func__,
diff --git a/fs/exportfs/expfs.c b/fs/exportfs/expfs.c
index 2dd55b172d57..a4276d14aebb 100644
--- a/fs/exportfs/expfs.c
+++ b/fs/exportfs/expfs.c
@@ -145,7 +145,7 @@ static struct dentry *reconnect_one(struct vfsmount *mnt,
 	if (err)
 		goto out_err;
 	dprintk("%s: found name: %s\n", __func__, nbuf);
-	tmp = lookup_one_len_unlocked(nbuf, parent, strlen(nbuf));
+	tmp = lookup_one_len_unlocked(nbuf, parent, strlen(nbuf), 0);
 	if (IS_ERR(tmp)) {
 		dprintk("%s: lookup failed: %d\n", __func__, PTR_ERR(tmp));
 		err = PTR_ERR(tmp);
diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
index 9dc7e7a64e10..92e7f264baa1 100644
--- a/fs/kernfs/mount.c
+++ b/fs/kernfs/mount.c
@@ -224,7 +224,7 @@ struct dentry *kernfs_node_dentry(struct kernfs_node *kn,
 			return ERR_PTR(-EINVAL);
 		}
 		dtmp = lookup_positive_unlocked(kntmp->name, dentry,
-					       strlen(kntmp->name));
+						strlen(kntmp->name), 0);
 		dput(dentry);
 		if (IS_ERR(dtmp))
 			return dtmp;
diff --git a/fs/namei.c b/fs/namei.c
index a320371899cf..e70b7a14bdcc 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1532,6 +1532,9 @@ static struct dentry *__lookup_slow(const struct qstr *name,
 		if (unlikely(old)) {
 			dput(dentry);
 			dentry = old;
+		} else if ((flags & LOOKUP_NO_NEGATIVE) &&
+			   d_is_negative(dentry)) {
+			d_drop(dentry);
 		}
 	}
 	return dentry;
@@ -2562,7 +2565,8 @@ EXPORT_SYMBOL(lookup_one_len);
  * i_mutex held, and will take the i_mutex itself if necessary.
  */
 struct dentry *lookup_one_len_unlocked(const char *name,
-				       struct dentry *base, int len)
+				       struct dentry *base, int len,
+				       unsigned int flags)
 {
 	struct qstr this;
 	int err;
@@ -2572,9 +2576,9 @@ struct dentry *lookup_one_len_unlocked(const char *name,
 	if (err)
 		return ERR_PTR(err);
 
-	ret = lookup_dcache(&this, base, 0);
+	ret = lookup_dcache(&this, base, flags);
 	if (!ret)
-		ret = lookup_slow(&this, base, 0);
+		ret = lookup_slow(&this, base, flags);
 	return ret;
 }
 EXPORT_SYMBOL(lookup_one_len_unlocked);
@@ -2588,9 +2592,10 @@ EXPORT_SYMBOL(lookup_one_len_unlocked);
  * this one avoids such problems.
  */
 struct dentry *lookup_positive_unlocked(const char *name,
-				       struct dentry *base, int len)
+					struct dentry *base, int len,
+					unsigned int flags)
 {
-	struct dentry *ret = lookup_one_len_unlocked(name, base, len);
+	struct dentry *ret = lookup_one_len_unlocked(name, base, len, flags);
 	if (!IS_ERR(ret) && d_flags_negative(smp_load_acquire(&ret->d_flags))) {
 		dput(ret);
 		ret = ERR_PTR(-ENOENT);
diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index aae514d40b64..19628922969c 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -855,7 +855,7 @@ compose_entry_fh(struct nfsd3_readdirres *cd, struct svc_fh *fhp,
 		} else
 			dchild = dget(dparent);
 	} else
-		dchild = lookup_positive_unlocked(name, dparent, namlen);
+		dchild = lookup_positive_unlocked(name, dparent, namlen, 0);
 	if (IS_ERR(dchild))
 		return rv;
 	if (d_mountpoint(dchild))
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 996ac01ee977..0c3c7928a319 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3066,7 +3066,7 @@ nfsd4_encode_dirent_fattr(struct xdr_stream *xdr, struct nfsd4_readdir *cd,
 	__be32 nfserr;
 	int ignore_crossmnt = 0;
 
-	dentry = lookup_positive_unlocked(name, cd->rd_fhp->fh_dentry, namlen);
+	dentry = lookup_positive_unlocked(name, cd->rd_fhp->fh_dentry, namlen, 0);
 	if (IS_ERR(dentry))
 		return nfserrno(PTR_ERR(dentry));
 
diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
index 0db23baf98e7..193857487060 100644
--- a/fs/overlayfs/namei.c
+++ b/fs/overlayfs/namei.c
@@ -200,7 +200,8 @@ static int ovl_lookup_single(struct dentry *base, struct ovl_lookup_data *d,
 	int err;
 	bool last_element = !post[0];
 
-	this = lookup_positive_unlocked(name, base, namelen);
+	this = lookup_positive_unlocked(name, base, namelen,
+					LOOKUP_NO_NEGATIVE);
 	if (IS_ERR(this)) {
 		err = PTR_ERR(this);
 		this = NULL;
@@ -657,7 +658,7 @@ struct dentry *ovl_get_index_fh(struct ovl_fs *ofs, struct ovl_fh *fh)
 	if (err)
 		return ERR_PTR(err);
 
-	index = lookup_positive_unlocked(name.name, ofs->indexdir, name.len);
+	index = lookup_positive_unlocked(name.name, ofs->indexdir, name.len, 0);
 	kfree(name.name);
 	if (IS_ERR(index)) {
 		if (PTR_ERR(index) == -ENOENT)
@@ -689,7 +690,7 @@ struct dentry *ovl_lookup_index(struct ovl_fs *ofs, struct dentry *upper,
 	if (err)
 		return ERR_PTR(err);
 
-	index = lookup_positive_unlocked(name.name, ofs->indexdir, name.len);
+	index = lookup_positive_unlocked(name.name, ofs->indexdir, name.len, 0);
 	if (IS_ERR(index)) {
 		err = PTR_ERR(index);
 		if (err == -ENOENT) {
@@ -1137,7 +1138,7 @@ bool ovl_lower_positive(struct dentry *dentry)
 		struct dentry *lowerdir = poe->lowerstack[i].dentry;
 
 		this = lookup_positive_unlocked(name->name, lowerdir,
-					       name->len);
+						name->len, 0);
 		if (IS_ERR(this)) {
 			switch (PTR_ERR(this)) {
 			case -ENOENT:
diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index b6a4f692d345..f588839ebe2e 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -2488,7 +2488,7 @@ int dquot_quota_on_mount(struct super_block *sb, char *qf_name,
 	struct dentry *dentry;
 	int error;
 
-	dentry = lookup_positive_unlocked(qf_name, sb->s_root, strlen(qf_name));
+	dentry = lookup_positive_unlocked(qf_name, sb->s_root, strlen(qf_name), 0);
 	if (IS_ERR(dentry))
 		return PTR_ERR(dentry);
 
diff --git a/include/linux/namei.h b/include/linux/namei.h
index a4bb992623c4..4896eeeeea46 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -49,6 +49,8 @@ enum {LAST_NORM, LAST_ROOT, LAST_DOT, LAST_DOTDOT};
 /* LOOKUP_* flags which do scope-related checks based on the dirfd. */
 #define LOOKUP_IS_SCOPED (LOOKUP_BENEATH | LOOKUP_IN_ROOT)
 
+#define LOOKUP_NO_NEGATIVE	0x200000 /* Hint: don't cache negative */
+
 extern int path_pts(struct path *path);
 
 extern int user_path_at_empty(int, const char __user *, unsigned, struct path *, int *empty);
@@ -68,8 +70,8 @@ extern struct dentry *kern_path_locked(const char *, struct path *);
 
 extern struct dentry *try_lookup_one_len(const char *, struct dentry *, int);
 extern struct dentry *lookup_one_len(const char *, struct dentry *, int);
-extern struct dentry *lookup_one_len_unlocked(const char *, struct dentry *, int);
-extern struct dentry *lookup_positive_unlocked(const char *, struct dentry *, int);
+extern struct dentry *lookup_one_len_unlocked(const char *, struct dentry *, int, unsigned int);
+extern struct dentry *lookup_positive_unlocked(const char *, struct dentry *, int, unsigned int);
 
 extern int follow_down_one(struct path *);
 extern int follow_down(struct path *);
