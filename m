Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79AFDFCF25
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2019 21:07:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfKNUHV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Nov 2019 15:07:21 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:34632 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726474AbfKNUHV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Nov 2019 15:07:21 -0500
Received: by mail-yb1-f193.google.com with SMTP id k17so3097481ybp.1;
        Thu, 14 Nov 2019 12:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eTLK8UO96mmVMYxYGbP7Ho7asUvdokWxxBM9/ZbnysA=;
        b=ne4RQfm7GyuW8MbsThnJ8aeu06ZnMurOva9NzBIbGveeyD4NKplFRw8nNoiw/iRii/
         fi7tRVPczzw4ZkGJ0KHAw2MbaxSoKtceUh9YkovIqO5FRw2AK+scu7sx2yCNNXT1fZUl
         U7eexymj51O/QRbdrRrfG4ohVmrl4ZooiZ3Jw8Inl3AMysDVI9EpeXSB2saOeuBEzhWP
         4OBBSIlkNxpPpQmXfslyRkySgvu38BrAvNAnYNW9w8xuCJw3HezNewLI+4flzFow3Nwq
         D5+rB5wPCNtnhcZK9O9Q4ffcCwF68qTwV54x+TpsHbAGPEeG6bdpzbBhKTxfYXnN7y6n
         dGGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eTLK8UO96mmVMYxYGbP7Ho7asUvdokWxxBM9/ZbnysA=;
        b=aWMYvAHeoueVLdN+7EU/4mN8idN6rnThOCIQUyLqb0KpVHRCH/boB/B2QBkT4N+4Xi
         wfiauN+XbLnElkpTHPhnRAJx0RZs/6QqS18SO9xdByKyYLifarTM1W5kxxLhRIxDYku7
         EFVXrPLk+Pvc39kaiZX5+KbdsIkSvWwNnrgobTD8gkMom1Das99pGIihLSLLnb5BaPi1
         vXpJHTN7opzV8wMMRAlbTTkV0kkpXUYFWI6vVx6o3PULzYMtXoXOUa0Y3Y0taN6OtZiW
         JstNXBIkZ0ti+dhz3nT6Tt7+upss4r5L9lK8xtz3qEYaKSrwIkClulj1QTbfveeGyeT4
         +jxA==
X-Gm-Message-State: APjAAAXdfR4a1hILaAQdkg7DRT5Qr6gpnNZKlYlOjBoHb8eTimLvZlra
        FboQxVCAd6avN1foMiLyF1Jf5w1UAN/WPJA7upA=
X-Google-Smtp-Source: APXvYqzgPeT5JYqAvD1x77d3/qrATRhNj8ku/mOSLoBtO8y9ueeSoxsJLSoQFBr2TmcbH3GI9EEyfS1pqE9RJKWXRWQ=
X-Received: by 2002:a25:212:: with SMTP id 18mr8364283ybc.439.1573762039404;
 Thu, 14 Nov 2019 12:07:19 -0800 (PST)
MIME-Version: 1.0
References: <20191114154723.GJ26530@ZenIV.linux.org.uk> <20191114195544.GB5569@miu.piliscsaba.redhat.com>
In-Reply-To: <20191114195544.GB5569@miu.piliscsaba.redhat.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 14 Nov 2019 22:07:07 +0200
Message-ID: <CAOQ4uxhjAwU_V0cUF+VkQbAwXKTJKsZuyysNXMecuM9Y1iuUsw@mail.gmail.com>
Subject: Re: [RFC] is ovl_fh->fid really intended to be misaligned?
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 14, 2019 at 9:55 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Thu, Nov 14, 2019 at 03:47:23PM +0000, Al Viro wrote:
> > AFAICS, this
> >         bytes = (fh->len - offsetof(struct ovl_fh, fid));
> >         real = exportfs_decode_fh(mnt, (struct fid *)fh->fid,
> >                                   bytes >> 2, (int)fh->type,
> >                                   connected ? ovl_acceptable : NULL, mnt);
> > in ovl_decode_real_fh() combined with
> >                 origin = ovl_decode_real_fh(fh, ofs->lower_layers[i].mnt,
> >                                             connected);
> > in ovl_check_origin_fh(),
> >         /* First lookup overlay inode in inode cache by origin fh */
> >         err = ovl_check_origin_fh(ofs, fh, false, NULL, &stack);
> > in ovl_lower_fh_to_d() and
> >         struct ovl_fh *fh = (struct ovl_fh *) fid;
> > ...
> >                  ovl_lower_fh_to_d(sb, fh);
> > in ovl_fh_to_dentry() leads to the pointer to struct fid passed to
> > exportfs_decode_fh() being 21 bytes ahead of that passed to
> > ovl_fh_to_dentry().
> >
> > However, alignment of struct fid pointers is 32 bits and quite a few
> > places dealing with those (including ->fh_to_dentry() instances)
> > do access them directly.  Argument of ->fh_to_dentry() is supposed
> > to be 32bit-aligned, and callers generally guarantee that.  Your
> > code, OTOH, violates the alignment systematically there - what
> > it passes to layers' ->fh_to_dentry() (by way of exportfs_decode_fh())
> > always has two lower bits different from what it got itself.
> >
> > What do we do with that?  One solution would be to insert sane padding
> > in ovl_fh, but the damn thing appears to be stored as-is in xattrs on
> > disk, so that would require rather unpleasant operations reinserting
> > the padding on the fly ;-/
>
> Something like this?  Totally untested...
>

I was going to suggest something similar using

struct ovl_fhv1 {
        u8 pad[3];
        struct ovl_fh fhv0;
} __packed;

New overlayfs exported file handles on-wire could be ovl_fhv1,
but we can easily convert old ovl_fhv to ovl_fhv1
on-the-fly on decode (if we care about those few users at all)

xattrs would still be stored and read as ovl_fh v0.

Thanks,
Amir.

>
> diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
> index b801c6353100..60a4ca72cb4e 100644
> --- a/fs/overlayfs/copy_up.c
> +++ b/fs/overlayfs/copy_up.c
> @@ -253,7 +253,7 @@ struct ovl_fh *ovl_encode_real_fh(struct dentry *real, bool is_upper)
>
>         BUILD_BUG_ON(MAX_HANDLE_SZ + offsetof(struct ovl_fh, fid) > 255);
>         fh_len = offsetof(struct ovl_fh, fid) + buflen;
> -       fh = kmalloc(fh_len, GFP_KERNEL);
> +       fh = kzalloc(fh_len, GFP_KERNEL);
>         if (!fh) {
>                 fh = ERR_PTR(-ENOMEM);
>                 goto out;
> @@ -271,7 +271,7 @@ struct ovl_fh *ovl_encode_real_fh(struct dentry *real, bool is_upper)
>          */
>         if (is_upper)
>                 fh->flags |= OVL_FH_FLAG_PATH_UPPER;
> -       fh->len = fh_len;
> +       fh->len = fh_len - OVL_FH_WIRE_OFFSET;
>         fh->uuid = *uuid;
>         memcpy(fh->fid, buf, buflen);
>
> @@ -300,7 +300,8 @@ int ovl_set_origin(struct dentry *dentry, struct dentry *lower,
>         /*
>          * Do not fail when upper doesn't support xattrs.
>          */
> -       err = ovl_check_setxattr(dentry, upper, OVL_XATTR_ORIGIN, fh,
> +       err = ovl_check_setxattr(dentry, upper, OVL_XATTR_ORIGIN,
> +                                fh ? OVL_FH_START(fh) : NULL,
>                                  fh ? fh->len : 0, 0);
>         kfree(fh);
>
> @@ -317,7 +318,8 @@ static int ovl_set_upper_fh(struct dentry *upper, struct dentry *index)
>         if (IS_ERR(fh))
>                 return PTR_ERR(fh);
>
> -       err = ovl_do_setxattr(index, OVL_XATTR_UPPER, fh, fh->len, 0);
> +       err = ovl_do_setxattr(index, OVL_XATTR_UPPER,
> +                             OVL_FH_START(fh), fh->len, 0);
>
>         kfree(fh);
>         return err;
> diff --git a/fs/overlayfs/export.c b/fs/overlayfs/export.c
> index 73c9775215b3..dedda95c7746 100644
> --- a/fs/overlayfs/export.c
> +++ b/fs/overlayfs/export.c
> @@ -234,7 +234,7 @@ static int ovl_d_to_fh(struct dentry *dentry, char *buf, int buflen)
>         if (fh->len > buflen)
>                 goto fail;
>
> -       memcpy(buf, (char *)fh, fh->len);
> +       memcpy(buf, OVL_FH_START(fh), fh->len);
>         err = fh->len;
>
>  out:
> @@ -260,6 +260,7 @@ static int ovl_dentry_to_fh(struct dentry *dentry, u32 *fid, int *max_len)
>
>         /* Round up to dwords */
>         *max_len = (len + 3) >> 2;
> +       memset(fid + len, 0, (*max_len << 2) - len);
>         return OVL_FILEID;
>  }
>
> @@ -781,7 +782,7 @@ static struct dentry *ovl_fh_to_dentry(struct super_block *sb, struct fid *fid,
>                                        int fh_len, int fh_type)
>  {
>         struct dentry *dentry = NULL;
> -       struct ovl_fh *fh = (struct ovl_fh *) fid;
> +       struct ovl_fh *fh = (void *) fid - OVL_FH_WIRE_OFFSET;
>         int len = fh_len << 2;
>         unsigned int flags = 0;
>         int err;
> diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
> index e9717c2f7d45..f22a65359df1 100644
> --- a/fs/overlayfs/namei.c
> +++ b/fs/overlayfs/namei.c
> @@ -86,7 +86,8 @@ static int ovl_acceptable(void *ctx, struct dentry *dentry)
>   */
>  int ovl_check_fh_len(struct ovl_fh *fh, int fh_len)
>  {
> -       if (fh_len < sizeof(struct ovl_fh) || fh_len < fh->len)
> +       if (fh_len < sizeof(struct ovl_fh) - OVL_FH_WIRE_OFFSET ||
> +           fh_len < fh->len)
>                 return -EINVAL;
>
>         if (fh->magic != OVL_FH_MAGIC)
> @@ -119,11 +120,11 @@ static struct ovl_fh *ovl_get_fh(struct dentry *dentry, const char *name)
>         if (res == 0)
>                 return NULL;
>
> -       fh = kzalloc(res, GFP_KERNEL);
> +       fh = kzalloc(res + OVL_FH_WIRE_OFFSET, GFP_KERNEL);
>         if (!fh)
>                 return ERR_PTR(-ENOMEM);
>
> -       res = vfs_getxattr(dentry, name, fh, res);
> +       res = vfs_getxattr(dentry, name, fh + OVL_FH_WIRE_OFFSET, res);
>         if (res < 0)
>                 goto fail;
>
> @@ -161,7 +162,7 @@ struct dentry *ovl_decode_real_fh(struct ovl_fh *fh, struct vfsmount *mnt,
>         if (!uuid_equal(&fh->uuid, &mnt->mnt_sb->s_uuid))
>                 return NULL;
>
> -       bytes = (fh->len - offsetof(struct ovl_fh, fid));
> +       bytes = (fh->len + OVL_FH_WIRE_OFFSET - offsetof(struct ovl_fh, fid));
>         real = exportfs_decode_fh(mnt, (struct fid *)fh->fid,
>                                   bytes >> 2, (int)fh->type,
>                                   connected ? ovl_acceptable : NULL, mnt);
> @@ -433,7 +434,8 @@ int ovl_verify_set_fh(struct dentry *dentry, const char *name,
>
>         err = ovl_verify_fh(dentry, name, fh);
>         if (set && err == -ENODATA)
> -               err = ovl_do_setxattr(dentry, name, fh, fh->len, 0);
> +               err = ovl_do_setxattr(dentry, name,
> +                                     OVL_FH_START(fh), fh->len, 0);
>         if (err)
>                 goto fail;
>
> @@ -512,12 +514,12 @@ int ovl_verify_index(struct ovl_fs *ofs, struct dentry *index)
>
>         err = -ENOMEM;
>         len = index->d_name.len / 2;
> -       fh = kzalloc(len, GFP_KERNEL);
> +       fh = kzalloc(len + OVL_FH_WIRE_OFFSET, GFP_KERNEL);
>         if (!fh)
>                 goto fail;
>
>         err = -EINVAL;
> -       if (hex2bin((u8 *)fh, index->d_name.name, len))
> +       if (hex2bin(OVL_FH_START(fh), index->d_name.name, len))
>                 goto fail;
>
>         err = ovl_check_fh_len(fh, len);
> @@ -603,7 +605,7 @@ static int ovl_get_index_name_fh(struct ovl_fh *fh, struct qstr *name)
>         if (!n)
>                 return -ENOMEM;
>
> -       s  = bin2hex(n, fh, fh->len);
> +       s  = bin2hex(n, OVL_FH_START(fh), fh->len);
>         *name = (struct qstr) QSTR_INIT(n, s - n);
>
>         return 0;
> diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
> index 6934bcf030f0..c62083671a12 100644
> --- a/fs/overlayfs/overlayfs.h
> +++ b/fs/overlayfs/overlayfs.h
> @@ -74,8 +74,13 @@ enum ovl_entry_flag {
>  /* The type returned by overlay exportfs ops when encoding an ovl_fh handle */
>  #define OVL_FILEID     0xfb
>
> -/* On-disk and in-memeory format for redirect by file handle */
> +#define OVL_FH_WIRE_OFFSET 3
> +#define OVL_FH_START(fh) ((void *)(fh) + OVL_FH_WIRE_OFFSET)
>  struct ovl_fh {
> +       /* make sure fid is 32bit aligned */
> +       u8 padding[OVL_FH_WIRE_OFFSET];
> +
> +       /* Wire/xattr encoding begins here*/
>         u8 version;     /* 0 */
>         u8 magic;       /* 0xfb */
>         u8 len;         /* size of this header + size of fid */
