Return-Path: <linux-fsdevel+bounces-9041-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A178483D524
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 10:00:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C65A61C250E3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 09:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C3C1B7FA;
	Fri, 26 Jan 2024 07:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WsPtnk5q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC1F10A30;
	Fri, 26 Jan 2024 07:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706254441; cv=none; b=ortqlQnZURUezD6bbdacWQTYK2cC9kpSa5PZNeULrPf7eLpydhsPp+3/TpmtJd1JlW68s7HVQ80goraJ2Oyh12rqdbij1ivJtLkRkf+wuWF0seQfd2Y7IwEmHxB94yLI12plrqFbbp8nqRXbIY5qgJq6JtSQXi9bB8XTDzehnx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706254441; c=relaxed/simple;
	bh=pr8CavKcrMTZ6oQHBG9sL1u5dseQXpJbyT5ePj2mAHM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UncRacIqoAa5YEjZ/tLVMOL4HE2QSW0gxZuJz3Rs+2SxS1c68FdR+HJUrfyAN0l1q2IwfK5EMNu+yDeL4AWEw2SgFTJ7YHU1JqRmeEpbJomMt/EBmzDE1btLbHmQW5e+XRZCj68aaNZWHJA6QlvJXkwU/sGKsvB0NsZJvepVErg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WsPtnk5q; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-783b7ec94d4so10613285a.1;
        Thu, 25 Jan 2024 23:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706254438; x=1706859238; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7OxKeIsphvMqTV/5X66+kHexwoOkDjhg0ICPhwJGIqg=;
        b=WsPtnk5qHcGYc9rbzivEju6G8pU+01PcsWWmP0RIqqYIK8NhWvzKDj+3HLePe3w4nV
         HDPyXvO8b5tvIbJjSzhd5f7c5Z4y1w4Jc4f/ZfBxQaD+zJkfIw+wI5tyUV8ra37KxyNp
         3BCdXKao01RwPSe6alYchHkwm9/Eq9CojAfmx2dBq0unnQEaOKD7azR8521ldFH23HTp
         Xjmad1cXZKBkIoQ+5OeySIHHjvjusY1ldG/2YXn5DzHhFh//I5gmlv9r18lW6ChmikXw
         aATmtFspubjm89Gzr1+tfFl7n/nrAdsyW+yS2DxbSvYBEn81AennN1DpdF2FcFuRwzeE
         CdHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706254438; x=1706859238;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7OxKeIsphvMqTV/5X66+kHexwoOkDjhg0ICPhwJGIqg=;
        b=trFKNe6re9WamYvd4M3o0vZfdZdWrSbwLpUMs0PmPASwqBl4UXp21tdIHxbnrboDrP
         OUaZMeKOWiL4sLzKXDQFXbFuxPJzrHUrPPrIR+Kp2u75KZz79xQt/zqyWPVVwP/qWevl
         d4U0tKzK5nBir94s+do+2U0cW1rAj2skLZblsnKekLWCRg/3cpg/xgsmO1dmHEAQd/Lr
         FK0EyUIbTOorEZADxPgMGsEZtM1qoU9HbuK/FwttJ146Eb+VnmDysBfMN53CHIMdV/NV
         wPApGcXhKq7KoWABeFfEN16KGnosrj5+y3M2e+dRNdK1wo3GrRuHZrTrNPWS8tSNObrV
         3v1w==
X-Gm-Message-State: AOJu0YzUF9P5vDUl3bpdAT3Xb0Wzq5ReydXIVyzbedGCOjNgU7OEfpTK
	zOlVGjR03Hg7+9gYd5MMZq8Kie2vv4/zZ6wEOzRKz1npFqp9O8fR2m35twp0TEvq5gloz6Oq7Ot
	70DYlSoNSXUIx+9m2heEeF6P7dFknRr15RuY=
X-Google-Smtp-Source: AGHT+IF9/NXdXtHKzHSeskLIz03AzeCORyxWBJv8kcluJdLvqQL+mJ4Cyg2Sf6UkG3cqnSWnX725nQcicvjZtIcoUJw=
X-Received: by 2002:ad4:5e8a:0:b0:685:f9a6:1db6 with SMTP id
 jl10-20020ad45e8a000000b00685f9a61db6mr1163644qvb.9.1706254438264; Thu, 25
 Jan 2024 23:33:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126072120.71867-1-jefflexu@linux.alibaba.com>
In-Reply-To: <20240126072120.71867-1-jefflexu@linux.alibaba.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 26 Jan 2024 09:33:47 +0200
Message-ID: <CAOQ4uxh2C_mh2Zgr=s8jXh0pk=UGWJxLijTWBGEL5cZfyFUzbQ@mail.gmail.com>
Subject: Re: [PATCH v2] fuse: add support for explicit export disabling
To: Jingbo Xu <jefflexu@linux.alibaba.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2024 at 9:21=E2=80=AFAM Jingbo Xu <jefflexu@linux.alibaba.c=
om> wrote:
>
> open_by_handle_at(2) can fail with -ESTALE with a valid handle returned
> by a previous name_to_handle_at(2) for evicted fuse inodes, which is
> especially common when entry_valid_timeout is 0, e.g. when the fuse
> daemon is in "cache=3Dnone" mode.
>
> The time sequence is like:
>
>         name_to_handle_at(2)    # succeed
>         evict fuse inode
>         open_by_handle_at(2)    # fail
>
> The root cause is that, with 0 entry_valid_timeout, the dput() called in
> name_to_handle_at(2) will trigger iput -> evict(), which will send
> FUSE_FORGET to the daemon.  The following open_by_handle_at(2) will send
> a new FUSE_LOOKUP request upon inode cache miss since the previous inode
> eviction.  Then the fuse daemon may fail the FUSE_LOOKUP request with
> -ENOENT as the cached metadata of the requested inode has already been
> cleaned up during the previous FUSE_FORGET.  The returned -ENOENT is
> treated as -ESTALE when open_by_handle_at(2) returns.
>
> This confuses the application somehow, as open_by_handle_at(2) fails
> when the previous name_to_handle_at(2) succeeds.  The returned errno is
> also confusing as the requested file is not deleted and already there.
> It is reasonable to fail name_to_handle_at(2) early in this case, after
> which the application can fallback to open(2) to access files.
>
> Since this issue typically appears when entry_valid_timeout is 0 which
> is configured by the fuse daemon, the fuse daemon is the right person to
> explicitly disable the export when required.
>
> Also considering FUSE_EXPORT_SUPPORT actually indicates the support for
> lookups of "." and "..", and there are existing fuse daemons supporting
> export without FUSE_EXPORT_SUPPORT set, for compatibility, we add a new
> INIT flag for such purpose.
>
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
> v2:
> - rename to "fuse_export_fid_operations"
> - bump FUSE_KERNEL_MINOR_VERSION
>
> v1: https://lore.kernel.org/linux-fsdevel/20240124113042.44300-1-jefflexu=
@linux.alibaba.com/
> RFC: https://lore.kernel.org/all/20240123093701.94166-1-jefflexu@linux.al=
ibaba.com/
> ---
>  fs/fuse/inode.c           | 11 ++++++++++-
>  include/uapi/linux/fuse.h |  7 ++++++-
>  2 files changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index 2a6d44f91729..eee200308482 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -1110,6 +1110,11 @@ static struct dentry *fuse_get_parent(struct dentr=
y *child)
>         return parent;
>  }
>
> +/* only for fid encoding; no support for file handle */
> +static const struct export_operations fuse_export_fid_operations =3D {
> +       .encode_fh      =3D fuse_encode_fh,
> +};
> +
>  static const struct export_operations fuse_export_operations =3D {
>         .fh_to_dentry   =3D fuse_fh_to_dentry,
>         .fh_to_parent   =3D fuse_fh_to_parent,
> @@ -1284,6 +1289,8 @@ static void process_init_reply(struct fuse_mount *f=
m, struct fuse_args *args,
>                                 fc->create_supp_group =3D 1;
>                         if (flags & FUSE_DIRECT_IO_ALLOW_MMAP)
>                                 fc->direct_io_allow_mmap =3D 1;
> +                       if (flags & FUSE_NO_EXPORT_SUPPORT)
> +                               fm->sb->s_export_op =3D &fuse_export_fid_=
operations;
>                 } else {
>                         ra_pages =3D fc->max_read / PAGE_SIZE;
>                         fc->no_lock =3D 1;
> @@ -1330,7 +1337,8 @@ void fuse_send_init(struct fuse_mount *fm)
>                 FUSE_NO_OPENDIR_SUPPORT | FUSE_EXPLICIT_INVAL_DATA |
>                 FUSE_HANDLE_KILLPRIV_V2 | FUSE_SETXATTR_EXT | FUSE_INIT_E=
XT |
>                 FUSE_SECURITY_CTX | FUSE_CREATE_SUPP_GROUP |
> -               FUSE_HAS_EXPIRE_ONLY | FUSE_DIRECT_IO_ALLOW_MMAP;
> +               FUSE_HAS_EXPIRE_ONLY | FUSE_DIRECT_IO_ALLOW_MMAP |
> +               FUSE_NO_EXPORT_SUPPORT;
>  #ifdef CONFIG_FUSE_DAX
>         if (fm->fc->dax)
>                 flags |=3D FUSE_MAP_ALIGNMENT;
> @@ -1527,6 +1535,7 @@ static int fuse_fill_super_submount(struct super_bl=
ock *sb,
>         sb->s_bdi =3D bdi_get(parent_sb->s_bdi);
>
>         sb->s_xattr =3D parent_sb->s_xattr;
> +       sb->s_export_op =3D parent_sb->s_export_op;
>         sb->s_time_gran =3D parent_sb->s_time_gran;
>         sb->s_blocksize =3D parent_sb->s_blocksize;
>         sb->s_blocksize_bits =3D parent_sb->s_blocksize_bits;
> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> index e7418d15fe39..38d9f285a599 100644
> --- a/include/uapi/linux/fuse.h
> +++ b/include/uapi/linux/fuse.h
> @@ -211,6 +211,9 @@
>   *  7.39
>   *  - add FUSE_DIRECT_IO_ALLOW_MMAP
>   *  - add FUSE_STATX and related structures
> + *
> + *  7.40
> + *  - add FUSE_NO_EXPORT_SUPPORT
>   */
>
>  #ifndef _LINUX_FUSE_H
> @@ -246,7 +249,7 @@
>  #define FUSE_KERNEL_VERSION 7
>
>  /** Minor version number of this interface */
> -#define FUSE_KERNEL_MINOR_VERSION 39
> +#define FUSE_KERNEL_MINOR_VERSION 40
>
>  /** The node ID of the root inode */
>  #define FUSE_ROOT_ID 1
> @@ -410,6 +413,7 @@ struct fuse_file_lock {
>   *                     symlink and mknod (single group that matches pare=
nt)
>   * FUSE_HAS_EXPIRE_ONLY: kernel supports expiry-only entry invalidation
>   * FUSE_DIRECT_IO_ALLOW_MMAP: allow shared mmap in FOPEN_DIRECT_IO mode.
> + * FUSE_NO_EXPORT_SUPPORT: explicitly disable export support
>   */
>  #define FUSE_ASYNC_READ                (1 << 0)
>  #define FUSE_POSIX_LOCKS       (1 << 1)
> @@ -449,6 +453,7 @@ struct fuse_file_lock {
>  #define FUSE_CREATE_SUPP_GROUP (1ULL << 34)
>  #define FUSE_HAS_EXPIRE_ONLY   (1ULL << 35)
>  #define FUSE_DIRECT_IO_ALLOW_MMAP (1ULL << 36)
> +#define FUSE_NO_EXPORT_SUPPORT (1ULL << 37)
>
>  /* Obsolete alias for FUSE_DIRECT_IO_ALLOW_MMAP */
>  #define FUSE_DIRECT_IO_RELAX   FUSE_DIRECT_IO_ALLOW_MMAP
> --
> 2.19.1.6.gb485710b
>

