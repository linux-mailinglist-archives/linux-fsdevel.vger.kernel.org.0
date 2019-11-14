Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA9EEFCFEE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2019 21:55:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbfKNUza (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Nov 2019 15:55:30 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:46642 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726597AbfKNUza (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Nov 2019 15:55:30 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iVM9G-0002GF-05; Thu, 14 Nov 2019 20:55:26 +0000
Date:   Thu, 14 Nov 2019 20:55:25 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org,
        linux-nfs@vger.kernel.org, "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [RFC] is ovl_fh->fid really intended to be misaligned?
Message-ID: <20191114205525.GK26530@ZenIV.linux.org.uk>
References: <20191114154723.GJ26530@ZenIV.linux.org.uk>
 <20191114195544.GB5569@miu.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191114195544.GB5569@miu.piliscsaba.redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 14, 2019 at 08:55:44PM +0100, Miklos Szeredi wrote:

>  	BUILD_BUG_ON(MAX_HANDLE_SZ + offsetof(struct ovl_fh, fid) > 255);
>  	fh_len = offsetof(struct ovl_fh, fid) + buflen;

IOW, 3 bytes longer now.  OK...

> -	fh = kmalloc(fh_len, GFP_KERNEL);
> +	fh = kzalloc(fh_len, GFP_KERNEL);
>  	if (!fh) {
>  		fh = ERR_PTR(-ENOMEM);
>  		goto out;
> @@ -271,7 +271,7 @@ struct ovl_fh *ovl_encode_real_fh(struct dentry *real, bool is_upper)
>  	 */
>  	if (is_upper)
>  		fh->flags |= OVL_FH_FLAG_PATH_UPPER;
> -	fh->len = fh_len;
> +	fh->len = fh_len - OVL_FH_WIRE_OFFSET;

... same value as before

>  	fh->uuid = *uuid;
>  	memcpy(fh->fid, buf, buflen);

Is there any point to two allocations + memcpy here?  It's not as if you kept those
ovl_fh instances allocated for a long time - the caller frees them shortly.  So
why bother with buf at all?  Just allocate your fh max-sized and bloody pass &fh->fid
to exportfs_encode_fh() there.  I would suggest this for declaration, if you want
to pad it in front:
struct ovl_fh {
	u8 __pad[OVL_FH_WIRE_OFFSET];
        u8 version;     /* 0 */
        u8 magic;       /* 0xfb */
        u8 len;         /* size of this header + size of fid */
        u8 flags;       /* OVL_FH_FLAG_* */
        u8 type;        /* fid_type of fid */
        uuid_t uuid;    /* uuid of filesystem */
	union {
		struct fid fid;      /* file identifier */
		u8 storage[];
	};
} __packed;
with BUILD_BUG_ON(offsetof(struct ovl_fh, fid) % 4); somewhere in there.
Size calculation would be
        fh_len = offsetof(struct ovl_fh, storage[MAX_HANDLE_SIZE]);


And check that resulting fhandle size does *not* exceed 32 words, just to make sure.

> @@ -234,7 +234,7 @@ static int ovl_d_to_fh(struct dentry *dentry, char *buf, int buflen)
>  	if (fh->len > buflen)
>  		goto fail;
>  
> -	memcpy(buf, (char *)fh, fh->len);
> +	memcpy(buf, OVL_FH_START(fh), fh->len);
>  	err = fh->len;

Incidentally, memcpy() doesn't need any casts - it takes any data pointer types
just fine...

>  out:
> @@ -260,6 +260,7 @@ static int ovl_dentry_to_fh(struct dentry *dentry, u32 *fid, int *max_len)
>  
>  	/* Round up to dwords */
>  	*max_len = (len + 3) >> 2;
> +	memset(fid + len, 0, (*max_len << 2) - len);

No.  This is broken - fid is u32 pointer.  What you want here is

memcpy(fid, OVL_FH_START(fh), fh->len);
memset((char *)fid + fh->len, 0, OVL_FH_START(fh), OVL_FH_WIRE_OFFSET);
len = fh->len + OVL_FH_WIRE_OFFSET;

in the d_to_fh part, then just have *max_len = len / 4;

Or just do the max-sized allocation for fh and have ovl_encode_real_fh()
zero everything past fh->len; then this would just be a plain memcpy() and
to hell with separate memset()...

Incidentally, I really don't understand why these three functions separated
from each other.  Why not do all of that in ovl_encode_fh()?  AFAICS, the
logics gets simpler than way.


>  	return OVL_FILEID;
>  }


> @@ -781,7 +782,7 @@ static struct dentry *ovl_fh_to_dentry(struct super_block *sb, struct fid *fid,
>  				       int fh_len, int fh_type)
>  {
>  	struct dentry *dentry = NULL;
> -	struct ovl_fh *fh = (struct ovl_fh *) fid;
> +	struct ovl_fh *fh = (void *) fid - OVL_FH_WIRE_OFFSET;

Not enough, I'm afraid...  Look what happens when you get to passing the
payload to ovl_decode_real_fh().  You pass a misaligned pointer (1 mod 4)
in there, then an equally misaligned pointer is passed to exportfs_decode_fh().
You really need to move that sucker here - the underlying fhandle is really
misaligned in what gets passed to you.


> @@ -119,11 +120,11 @@ static struct ovl_fh *ovl_get_fh(struct dentry *dentry, const char *name)
>  	if (res == 0)
>  		return NULL;
>  
> -	fh = kzalloc(res, GFP_KERNEL);
> +	fh = kzalloc(res + OVL_FH_WIRE_OFFSET, GFP_KERNEL);
>  	if (!fh)
>  		return ERR_PTR(-ENOMEM);
>  
> -	res = vfs_getxattr(dentry, name, fh, res);
> +	res = vfs_getxattr(dentry, name, fh + OVL_FH_WIRE_OFFSET, res);
>  	if (res < 0)
>  		goto fail;

BTW, is there any point in precisely-sized allocations here?  Again,
the result won't live long, and we know the upper limit on the size,
so why bother with two vfs_getxattr() calls, etc?
