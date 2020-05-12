Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C84851CEFA0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 May 2020 10:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729281AbgELIzt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 May 2020 04:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729194AbgELIzs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 May 2020 04:55:48 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B385DC061A0C;
        Tue, 12 May 2020 01:55:48 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id i19so13022968ioh.12;
        Tue, 12 May 2020 01:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C3tdP0puGCXu1ysiHg+HqCRPLVN5JHOLtaHdKHfS+Ew=;
        b=egmqH6xUD1aGTHxm/xrwmO9hxxiOWyVLFpcOn9l8veIP3nde9PTdO4IQULBoGLN4Zl
         TwcYQB1HhHuM3ZQJvLkA9HKmq4H0e28VILrPLU5+Oe0YWTVEdP7ljV0wc/QN4mGwhPXO
         bky7ZG04PUeVwdJyUh6nMvdPZHBudA9l8E7TlE08SXHnB/Q61INkTzqLWc8YZpJdSduH
         5+n6BCKNooEkVXCs4/k78NxKWpB9ET0R1srYiDticSTbfUWlusa04AzwKWA2HqdV9I6F
         c2N1ClkzeWmns8s7hjqveCB2N4YHsOpI0H60yt/rOmpW5UdoXkn65yyuk116xa4+w/d7
         igLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C3tdP0puGCXu1ysiHg+HqCRPLVN5JHOLtaHdKHfS+Ew=;
        b=Shgfgn3BDokzp6AtIKxzPzntQhebjrGJVXoL7QDhF6o4Cl0iP299Bf5DEk985eFdTW
         3Kuv1ei6ERwlEvHqlhw/ZH2BBOAkQrKQHPGXlrbSD15O9jHa1CCAxXsDi0y0iWQXjUbp
         2jC+0qNii3F/EhW47EFpjHwYoE1ar0yN7tAmz+gnlQIGWUWvZNw+dtoJgnpXa1uo8YdU
         ZTsA4IFEbSs+yUEGZjuF4ziTUrn7yoIlsYlaN7tV8Qrqa5Rwr3JjPK145zCkS0FaXFyo
         xdvaz5/NACzorYF9wsFhXLw8yjM1wtH8gd5j7wUrcwT8ync4PlSPstesqSIwBbMN8bz4
         hIXA==
X-Gm-Message-State: AGi0PuYRylcb0O0AeUzh2bLQ9PHu7SvOzA6LMBY6Cm7s14rBjKlvwbYo
        mj8LPs0vmt40aRL5Pi5GgPLnPD0AxxckYGKT6NM=
X-Google-Smtp-Source: APiQypLdpKuVy4Pc+prdFsMkT1x8wbyVDXJijZPVmt/O6Qx3L6q0ySsneae0gob/5ZFwTschobPfZ9sKt7I9Unt5HWA=
X-Received: by 2002:a5e:840d:: with SMTP id h13mr9417577ioj.64.1589273747978;
 Tue, 12 May 2020 01:55:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200512071313.4525-1-cgxu519@mykernel.net> <CAOQ4uxiA_Er_VA=m8ORovGyvHDFuGBS4Ss_ef5un5VJbrev3jw@mail.gmail.com>
 <20200512083217.GC13131@miu.piliscsaba.redhat.com>
In-Reply-To: <20200512083217.GC13131@miu.piliscsaba.redhat.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 12 May 2020 11:55:36 +0300
Message-ID: <CAOQ4uxgfPVvFh3cQNoKzL6Y3k1HWF9hWXXutuDCON0dCzmapwA@mail.gmail.com>
Subject: Re: [RFC PATCH v2] ovl: suppress negative dentry in lookup
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Chengguang Xu <cgxu519@mykernel.net>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 12, 2020 at 11:32 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Tue, May 12, 2020 at 10:50:31AM +0300, Amir Goldstein wrote:
>
> > This helper should be in vfs code, not duplicating vfs code
> > and please don't duplicate code in vfs either.
> >
> > I think you can use a lookup flag (LOOKUP_POSITIVE_CACHE???)
> > to describe the desired behavior and implement it inside
> > lookup_slow(). Document the semantics as well as explain
> > in the context of the helper the cases where modules might
> > find this useful (because they have higher level caches).
> >
> > Besides the fact that this helper really needs review by Al
> > and that duplicating subtle code is wrong in so many levels,
> > I suppose the functionality could prove useful to other subsystems
> > as well.
>
> Something like this (untested).  Needs splitup and changelogs.
>
> Thanks,
> Miklos
>
> ---
> diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
> index c31f362fa098..e52a3b35ebac 100644
> --- a/fs/cifs/cifsfs.c
> +++ b/fs/cifs/cifsfs.c
> @@ -752,7 +752,7 @@ cifs_get_root(struct smb_vol *vol, struct super_block *sb)
>                 while (*s && *s != sep)
>                         s++;
>
> -               child = lookup_positive_unlocked(p, dentry, s - p);
> +               child = lookup_positive_unlocked(p, dentry, s - p, 0);
>                 dput(dentry);
>                 dentry = child;
>         } while (!IS_ERR(dentry));
> diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
> index b7f2e971ecbc..df4f37a6a9ab 100644
> --- a/fs/debugfs/inode.c
> +++ b/fs/debugfs/inode.c
> @@ -299,7 +299,7 @@ struct dentry *debugfs_lookup(const char *name, struct dentry *parent)
>         if (!parent)
>                 parent = debugfs_mount->mnt_root;
>
> -       dentry = lookup_positive_unlocked(name, parent, strlen(name));
> +       dentry = lookup_positive_unlocked(name, parent, strlen(name), 0);
>         if (IS_ERR(dentry))
>                 return NULL;
>         return dentry;
> diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
> index e23752d9a79f..e39af6313ad9 100644
> --- a/fs/ecryptfs/inode.c
> +++ b/fs/ecryptfs/inode.c
> @@ -407,7 +407,7 @@ static struct dentry *ecryptfs_lookup(struct inode *ecryptfs_dir_inode,
>                 name = encrypted_and_encoded_name;
>         }
>
> -       lower_dentry = lookup_one_len_unlocked(name, lower_dir_dentry, len);
> +       lower_dentry = lookup_one_len_unlocked(name, lower_dir_dentry, len, 0);
>         if (IS_ERR(lower_dentry)) {
>                 ecryptfs_printk(KERN_DEBUG, "%s: lookup_one_len() returned "
>                                 "[%ld] on lower_dentry = [%s]\n", __func__,
> diff --git a/fs/exportfs/expfs.c b/fs/exportfs/expfs.c
> index 2dd55b172d57..a4276d14aebb 100644
> --- a/fs/exportfs/expfs.c
> +++ b/fs/exportfs/expfs.c
> @@ -145,7 +145,7 @@ static struct dentry *reconnect_one(struct vfsmount *mnt,
>         if (err)
>                 goto out_err;
>         dprintk("%s: found name: %s\n", __func__, nbuf);
> -       tmp = lookup_one_len_unlocked(nbuf, parent, strlen(nbuf));
> +       tmp = lookup_one_len_unlocked(nbuf, parent, strlen(nbuf), 0);
>         if (IS_ERR(tmp)) {
>                 dprintk("%s: lookup failed: %d\n", __func__, PTR_ERR(tmp));
>                 err = PTR_ERR(tmp);
> diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
> index 9dc7e7a64e10..92e7f264baa1 100644
> --- a/fs/kernfs/mount.c
> +++ b/fs/kernfs/mount.c
> @@ -224,7 +224,7 @@ struct dentry *kernfs_node_dentry(struct kernfs_node *kn,
>                         return ERR_PTR(-EINVAL);
>                 }
>                 dtmp = lookup_positive_unlocked(kntmp->name, dentry,
> -                                              strlen(kntmp->name));
> +                                               strlen(kntmp->name), 0);
>                 dput(dentry);
>                 if (IS_ERR(dtmp))
>                         return dtmp;
> diff --git a/fs/namei.c b/fs/namei.c
> index a320371899cf..e70b7a14bdcc 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -1532,6 +1532,9 @@ static struct dentry *__lookup_slow(const struct qstr *name,
>                 if (unlikely(old)) {
>                         dput(dentry);
>                         dentry = old;
> +               } else if ((flags & LOOKUP_NO_NEGATIVE) &&
> +                          d_is_negative(dentry)) {
> +                       d_drop(dentry);
>                 }
>         }
>         return dentry;
> @@ -2562,7 +2565,8 @@ EXPORT_SYMBOL(lookup_one_len);
>   * i_mutex held, and will take the i_mutex itself if necessary.
>   */
>  struct dentry *lookup_one_len_unlocked(const char *name,
> -                                      struct dentry *base, int len)
> +                                      struct dentry *base, int len,
> +                                      unsigned int flags)
>  {
>         struct qstr this;
>         int err;
> @@ -2572,9 +2576,9 @@ struct dentry *lookup_one_len_unlocked(const char *name,
>         if (err)
>                 return ERR_PTR(err);
>
> -       ret = lookup_dcache(&this, base, 0);
> +       ret = lookup_dcache(&this, base, flags);
>         if (!ret)
> -               ret = lookup_slow(&this, base, 0);
> +               ret = lookup_slow(&this, base, flags);
>         return ret;
>  }
>  EXPORT_SYMBOL(lookup_one_len_unlocked);
> @@ -2588,9 +2592,10 @@ EXPORT_SYMBOL(lookup_one_len_unlocked);
>   * this one avoids such problems.
>   */
>  struct dentry *lookup_positive_unlocked(const char *name,
> -                                      struct dentry *base, int len)
> +                                       struct dentry *base, int len,
> +                                       unsigned int flags)
>  {
> -       struct dentry *ret = lookup_one_len_unlocked(name, base, len);
> +       struct dentry *ret = lookup_one_len_unlocked(name, base, len, flags);
>         if (!IS_ERR(ret) && d_flags_negative(smp_load_acquire(&ret->d_flags))) {
>                 dput(ret);
>                 ret = ERR_PTR(-ENOENT);
> diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
> index aae514d40b64..19628922969c 100644
> --- a/fs/nfsd/nfs3xdr.c
> +++ b/fs/nfsd/nfs3xdr.c
> @@ -855,7 +855,7 @@ compose_entry_fh(struct nfsd3_readdirres *cd, struct svc_fh *fhp,
>                 } else
>                         dchild = dget(dparent);
>         } else
> -               dchild = lookup_positive_unlocked(name, dparent, namlen);
> +               dchild = lookup_positive_unlocked(name, dparent, namlen, 0);
>         if (IS_ERR(dchild))
>                 return rv;
>         if (d_mountpoint(dchild))
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index 996ac01ee977..0c3c7928a319 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -3066,7 +3066,7 @@ nfsd4_encode_dirent_fattr(struct xdr_stream *xdr, struct nfsd4_readdir *cd,
>         __be32 nfserr;
>         int ignore_crossmnt = 0;
>
> -       dentry = lookup_positive_unlocked(name, cd->rd_fhp->fh_dentry, namlen);
> +       dentry = lookup_positive_unlocked(name, cd->rd_fhp->fh_dentry, namlen, 0);
>         if (IS_ERR(dentry))
>                 return nfserrno(PTR_ERR(dentry));
>
> diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
> index 0db23baf98e7..193857487060 100644
> --- a/fs/overlayfs/namei.c
> +++ b/fs/overlayfs/namei.c
> @@ -200,7 +200,8 @@ static int ovl_lookup_single(struct dentry *base, struct ovl_lookup_data *d,
>         int err;
>         bool last_element = !post[0];
>
> -       this = lookup_positive_unlocked(name, base, namelen);
> +       this = lookup_positive_unlocked(name, base, namelen,
> +                                       LOOKUP_NO_NEGATIVE);
>         if (IS_ERR(this)) {
>                 err = PTR_ERR(this);
>                 this = NULL;
> @@ -657,7 +658,7 @@ struct dentry *ovl_get_index_fh(struct ovl_fs *ofs, struct ovl_fh *fh)
>         if (err)
>                 return ERR_PTR(err);
>
> -       index = lookup_positive_unlocked(name.name, ofs->indexdir, name.len);
> +       index = lookup_positive_unlocked(name.name, ofs->indexdir, name.len, 0);
>         kfree(name.name);
>         if (IS_ERR(index)) {
>                 if (PTR_ERR(index) == -ENOENT)
> @@ -689,7 +690,7 @@ struct dentry *ovl_lookup_index(struct ovl_fs *ofs, struct dentry *upper,
>         if (err)
>                 return ERR_PTR(err);
>
> -       index = lookup_positive_unlocked(name.name, ofs->indexdir, name.len);
> +       index = lookup_positive_unlocked(name.name, ofs->indexdir, name.len, 0);
>         if (IS_ERR(index)) {
>                 err = PTR_ERR(index);
>                 if (err == -ENOENT) {
> @@ -1137,7 +1138,7 @@ bool ovl_lower_positive(struct dentry *dentry)
>                 struct dentry *lowerdir = poe->lowerstack[i].dentry;
>
>                 this = lookup_positive_unlocked(name->name, lowerdir,
> -                                              name->len);
> +                                               name->len, 0);
>                 if (IS_ERR(this)) {
>                         switch (PTR_ERR(this)) {
>                         case -ENOENT:
> diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
> index b6a4f692d345..f588839ebe2e 100644
> --- a/fs/quota/dquot.c
> +++ b/fs/quota/dquot.c
> @@ -2488,7 +2488,7 @@ int dquot_quota_on_mount(struct super_block *sb, char *qf_name,
>         struct dentry *dentry;
>         int error;
>
> -       dentry = lookup_positive_unlocked(qf_name, sb->s_root, strlen(qf_name));
> +       dentry = lookup_positive_unlocked(qf_name, sb->s_root, strlen(qf_name), 0);
>         if (IS_ERR(dentry))
>                 return PTR_ERR(dentry);
>
> diff --git a/include/linux/namei.h b/include/linux/namei.h
> index a4bb992623c4..4896eeeeea46 100644
> --- a/include/linux/namei.h
> +++ b/include/linux/namei.h
> @@ -49,6 +49,8 @@ enum {LAST_NORM, LAST_ROOT, LAST_DOT, LAST_DOTDOT};
>  /* LOOKUP_* flags which do scope-related checks based on the dirfd. */
>  #define LOOKUP_IS_SCOPED (LOOKUP_BENEATH | LOOKUP_IN_ROOT)
>
> +#define LOOKUP_NO_NEGATIVE     0x200000 /* Hint: don't cache negative */
> +

The language lawyers will call this double negative, but I do
prefer this over LOOKUP_POSITIVE :-)

Thanks,
Amir.
