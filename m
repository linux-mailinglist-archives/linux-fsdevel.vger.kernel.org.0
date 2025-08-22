Return-Path: <linux-fsdevel+bounces-58786-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 761A9B3172D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 14:11:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26F657A2CDA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 12:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43AE2FD7D3;
	Fri, 22 Aug 2025 12:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i5s1bEe7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5072FAC0D;
	Fri, 22 Aug 2025 12:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755864621; cv=none; b=Vcloo58Ylfg1Bi7k3gF47D8OlIEhW+fupNFzRAW+Lk3gCMNaWuc2zmUpZpD94mz0J6UQ84kzLHZyiy6g5hodVNHjf4v60HGE++tQi0p9hMBxzMyzuP8+uS39+Z/VYH+1i59wktKeizc1VTmfRDEUrM1PKUb/gUyHJMXDW+xJJcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755864621; c=relaxed/simple;
	bh=73827JPw+IKiF4ZxGfpRR4ZjpodYAx5pLDZUWImMo1c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S1+uOYLaOTmxjLf1bSU20ah67Q1nZ0FWbfU+OOH/JpYEPy0ynlvOf2Omr0gtpIopt0H1v8/3lOVcjIiZ6Zr0aqtTuss/D5cRzVTByudxK1RYmrfq/t/nAbi7PWE2GhZfYWz1t8RgbFfQvw7wk0PEre8/7fUdwkkb41McUuBj9vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i5s1bEe7; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-618b62dbb21so4035212a12.2;
        Fri, 22 Aug 2025 05:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755864617; x=1756469417; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e2NFY7AgriBVWrdUT6xci5zp3c2h/qG27DfIhsCL9EQ=;
        b=i5s1bEe7h+wxIlQFCzWqiSciqGaHosCLv9LeGsbO41t+0kSvywaoUGjQcIl8KY8AEw
         xKfygUa7r1zhNob+IbfTDXBWtZ9doYW/1II6gU+vmJct9Ayyeacx5AAkwLwMFKxGbP6S
         bWZ6+xj7ohDs479EDntoMDvgDqTzRESJ6L1EP9QdSUEGjsAqEQKdY7TEMC14E7LHlyLB
         x12twBDmgAZPlVYouv/MMO/WNYTJkYr1XhFsCw2kgWLjWetutXyt+SG6FoBAbIBAuLRD
         9+1bxV5vU8JiM+w+QFT4ju4n/kx2B+5SyRDUSyHObyukS7WvSZv/VhMki5iC7EBkGPJM
         GjMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755864617; x=1756469417;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e2NFY7AgriBVWrdUT6xci5zp3c2h/qG27DfIhsCL9EQ=;
        b=iMoL+PV3DhqzCLSKIVinHgzE2x8c8IVXzsnww2DfNCeqHiPaxWnn5dKNB/ByVPQ9Oz
         679F/4ve6/dK8b2hgsxMHdFD/gToAB5VBSABxCpF+C+5MgtLmQNcTiieHfk8DXHVmJee
         RzgdyyAS2NKbIwFGxMgkIo14VX9Eiur1rLJ3MT7hV1OdJ9p7cxHlJLvsPG06F4AQ+CF1
         Ma+UQnJw/1qPzhlzJZiIyYG/lNMaadWA8JjbmGsQumGCgU7xr4SosSdq/DGkTx6N/45J
         74kBEayYYGg1MofSZ63msLYrLUBr28+Ye25fib8d3qGSidfWt0+ZpxQ4bznjpYtx0DDQ
         6egQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLXkPvQuQzemiX/f8zonIw3CVeHcRhdgJce721aQbZSVUrlIJ/X/Q4v5go274iYRTclW7Ei+TpOzGg0w==@vger.kernel.org, AJvYcCWb2WE6lGaiWW42ae8fgyBksXqJLaXwpd6IKpWuc3X6JmkWSo32kPmUr9OKRImDnmzKQFGccXXmTkpufA==@vger.kernel.org, AJvYcCWdfPNjX7gKSlF3+7WbmBIb6bSJ/YeMuGwniUoJ3hyKb+X47Dt74xfgulj7J5CIEq+yvmRrQq5POMWa@vger.kernel.org
X-Gm-Message-State: AOJu0YyL2iS1eX6yOBo7lRjw1yeRUuOCKtaPw+aprUXe4eBIOqaVDLDb
	lTbkxtl1nGkf5Y7I3i7zl7qZeEiudCLrAbUcB5RVCaJ8FOCKEenLCuqgTHExpyGd9jQv5DsuIEJ
	T36E42hZQvZuRfRNeXngqiAHy8k2NbHI=
X-Gm-Gg: ASbGncuq7KJiARWNa5otuGTrb9ojC8BA1DZxnS4RiWInj8W8TNblkrpVMsinp2A6qtQ
	0LJK+zZZliUP4NnLNfbNNcXNZ6dZg85TUI1kw+JsJ+fT4J5Mk8YUvhtucYR5JXjKLbpMgVoPJLz
	t8jF9IT0t5u7WxONnUPCsIx4lmMQh8WKpYHBAfWq6307mPEVbE1nTqCzES1dGuw7LtydRLfMC1l
	yyGTDM=
X-Google-Smtp-Source: AGHT+IHlGT92s+giPKMCst87cGJ2m2GtvtkYgaEBaziPtZzpPtmb9Dn2nmK/Vc7hpgSjZ8pOpkGUGNBLLratNDBPsPc=
X-Received: by 2002:a05:6402:274b:b0:618:6e15:d095 with SMTP id
 4fb4d7f45d1cf-61c1b45328cmr2010856a12.4.1755864616511; Fri, 22 Aug 2025
 05:10:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1755806649.git.josef@toxicpanda.com> <6a12e35a078d765b50bc7ced7030d6cd98065528.1755806649.git.josef@toxicpanda.com>
In-Reply-To: <6a12e35a078d765b50bc7ced7030d6cd98065528.1755806649.git.josef@toxicpanda.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 22 Aug 2025 14:10:05 +0200
X-Gm-Features: Ac12FXw3Aoy5tNkv_mtS6oeTi6gMWNwW57QQRRFJq-XhP3j8lFw9abj8Oz0Hq3g
Message-ID: <CAOQ4uxjoyv1x9Wk0a9-3GyErDVFL_1ZyzcEn7B14VzD4ke0mAw@mail.gmail.com>
Subject: Re: [PATCH 20/50] fs: convert i_count to refcount_t
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	kernel-team@fb.com, linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, 
	brauner@kernel.org, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2025 at 12:54=E2=80=AFAM Josef Bacik <josef@toxicpanda.com>=
 wrote:
>
> Now that we do not allow i_count to drop to 0 and be used we can convert
> it to a refcount_t and benefit from the protections those helpers add.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  arch/powerpc/platforms/cell/spufs/file.c |  2 +-
>  fs/btrfs/inode.c                         |  4 ++--
>  fs/ceph/mds_client.c                     |  2 +-
>  fs/ext4/ialloc.c                         |  4 ++--
>  fs/fs-writeback.c                        |  2 +-
>  fs/hpfs/inode.c                          |  2 +-
>  fs/inode.c                               | 11 ++++++-----
>  fs/nfs/inode.c                           |  4 ++--
>  fs/notify/fsnotify.c                     |  2 +-
>  fs/ubifs/super.c                         |  2 +-
>  fs/xfs/xfs_inode.c                       |  2 +-
>  fs/xfs/xfs_trace.h                       |  2 +-
>  include/linux/fs.h                       |  4 ++--
>  include/trace/events/filelock.h          |  2 +-
>  security/landlock/fs.c                   |  2 +-
>  15 files changed, 24 insertions(+), 23 deletions(-)
>

You missed a spot in fs/smb/client/inode.c
that is using  inode->i_count.counter directly.

Thanks,
Amir.

> diff --git a/arch/powerpc/platforms/cell/spufs/file.c b/arch/powerpc/plat=
forms/cell/spufs/file.c
> index d5a2c77bc908..3f768b003838 100644
> --- a/arch/powerpc/platforms/cell/spufs/file.c
> +++ b/arch/powerpc/platforms/cell/spufs/file.c
> @@ -1430,7 +1430,7 @@ static int spufs_mfc_open(struct inode *inode, stru=
ct file *file)
>         if (ctx->owner !=3D current->mm)
>                 return -EINVAL;
>
> -       if (atomic_read(&inode->i_count) !=3D 1)
> +       if (refcount_read(&inode->i_count) !=3D 1)
>                 return -EBUSY;
>
>         mutex_lock(&ctx->mapping_lock);
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index bbbcd96e8f5c..e85e38df3ea0 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -3418,7 +3418,7 @@ void btrfs_add_delayed_iput(struct btrfs_inode *ino=
de)
>         struct btrfs_fs_info *fs_info =3D inode->root->fs_info;
>         unsigned long flags;
>
> -       if (atomic_add_unless(&inode->vfs_inode.i_count, -1, 1)) {
> +       if (refcount_dec_not_one(&inode->vfs_inode.i_count)) {
>                 iobj_put(&inode->vfs_inode);
>                 return;
>         }
> @@ -4559,7 +4559,7 @@ static void btrfs_prune_dentries(struct btrfs_root =
*root)
>
>         inode =3D btrfs_find_first_inode(root, min_ino);
>         while (inode) {
> -               if (atomic_read(&inode->vfs_inode.i_count) > 1)
> +               if (refcount_read(&inode->vfs_inode.i_count) > 1)
>                         d_prune_aliases(&inode->vfs_inode);
>
>                 min_ino =3D btrfs_ino(inode) + 1;
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index 0f497c39ff82..ff666d18f6ad 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -2221,7 +2221,7 @@ static int trim_caps_cb(struct inode *inode, int md=
s, void *arg)
>                         int count;
>                         dput(dentry);
>                         d_prune_aliases(inode);
> -                       count =3D atomic_read(&inode->i_count);
> +                       count =3D refcount_read(&inode->i_count);
>                         if (count =3D=3D 1)
>                                 (*remaining)--;
>                         doutc(cl, "%p %llx.%llx cap %p pruned, count now =
%d\n",
> diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
> index df4051613b29..9a3c7f22a57e 100644
> --- a/fs/ext4/ialloc.c
> +++ b/fs/ext4/ialloc.c
> @@ -252,10 +252,10 @@ void ext4_free_inode(handle_t *handle, struct inode=
 *inode)
>                        "nonexistent device\n", __func__, __LINE__);
>                 return;
>         }
> -       if (atomic_read(&inode->i_count) > 1) {
> +       if (refcount_read(&inode->i_count) > 1) {
>                 ext4_msg(sb, KERN_ERR, "%s:%d: inode #%lu: count=3D%d",
>                          __func__, __LINE__, inode->i_ino,
> -                        atomic_read(&inode->i_count));
> +                        refcount_read(&inode->i_count));
>                 return;
>         }
>         if (inode->i_nlink) {
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index 111a9d8215bf..789c4228412c 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -1796,7 +1796,7 @@ static int writeback_single_inode(struct inode *ino=
de,
>         int ret =3D 0;
>
>         spin_lock(&inode->i_lock);
> -       if (!atomic_read(&inode->i_count))
> +       if (!refcount_read(&inode->i_count))
>                 WARN_ON(!(inode->i_state & (I_WILL_FREE|I_FREEING)));
>         else
>                 WARN_ON(inode->i_state & I_WILL_FREE);
> diff --git a/fs/hpfs/inode.c b/fs/hpfs/inode.c
> index a59e8fa630db..ee23a941d8f5 100644
> --- a/fs/hpfs/inode.c
> +++ b/fs/hpfs/inode.c
> @@ -184,7 +184,7 @@ void hpfs_write_inode(struct inode *i)
>         struct hpfs_inode_info *hpfs_inode =3D hpfs_i(i);
>         struct inode *parent;
>         if (i->i_ino =3D=3D hpfs_sb(i->i_sb)->sb_root) return;
> -       if (hpfs_inode->i_rddir_off && !atomic_read(&i->i_count)) {
> +       if (hpfs_inode->i_rddir_off && !refcount_read(&i->i_count)) {
>                 if (*hpfs_inode->i_rddir_off)
>                         pr_err("write_inode: some position still there\n"=
);
>                 kfree(hpfs_inode->i_rddir_off);
> diff --git a/fs/inode.c b/fs/inode.c
> index 07c8edb4b58a..28d197731914 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -236,7 +236,7 @@ int inode_init_always_gfp(struct super_block *sb, str=
uct inode *inode, gfp_t gfp
>         inode->i_state =3D 0;
>         atomic64_set(&inode->i_sequence, 0);
>         refcount_set(&inode->i_obj_count, 1);
> -       atomic_set(&inode->i_count, 1);
> +       refcount_set(&inode->i_count, 1);
>         inode->i_op =3D &empty_iops;
>         inode->i_fop =3D &no_open_fops;
>         inode->i_ino =3D 0;
> @@ -561,7 +561,8 @@ static void init_once(void *foo)
>  void ihold(struct inode *inode)
>  {
>         iobj_get(inode);
> -       WARN_ON(atomic_inc_return(&inode->i_count) < 2);
> +       refcount_inc(&inode->i_count);
> +       WARN_ON(refcount_read(&inode->i_count) < 2);
>  }
>  EXPORT_SYMBOL(ihold);
>
> @@ -614,7 +615,7 @@ static void __inode_add_lru(struct inode *inode, bool=
 rotate)
>
>         if (inode->i_state & (I_FREEING | I_WILL_FREE))
>                 return;
> -       if (atomic_read(&inode->i_count) !=3D 1)
> +       if (refcount_read(&inode->i_count) !=3D 1)
>                 return;
>         if (inode->__i_nlink =3D=3D 0)
>                 return;
> @@ -2019,7 +2020,7 @@ static void __iput(struct inode *inode, bool skip_l=
ru)
>                 return;
>         BUG_ON(inode->i_state & I_CLEAR);
>
> -       if (atomic_add_unless(&inode->i_count, -1, 1)) {
> +       if (refcount_dec_not_one(&inode->i_count)) {
>                 iobj_put(inode);
>                 return;
>         }
> @@ -2039,7 +2040,7 @@ static void __iput(struct inode *inode, bool skip_l=
ru)
>          */
>         drop =3D maybe_add_lru(inode, skip_lru);
>
> -       if (atomic_dec_and_test(&inode->i_count))
> +       if (refcount_dec_and_test(&inode->i_count))
>                 iput_final(inode, drop);
>         else
>                 spin_unlock(&inode->i_lock);
> diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
> index 338ef77ae423..9cc84f0afa9a 100644
> --- a/fs/nfs/inode.c
> +++ b/fs/nfs/inode.c
> @@ -608,7 +608,7 @@ nfs_fhget(struct super_block *sb, struct nfs_fh *fh, =
struct nfs_fattr *fattr)
>                 inode->i_sb->s_id,
>                 (unsigned long long)NFS_FILEID(inode),
>                 nfs_display_fhandle_hash(fh),
> -               atomic_read(&inode->i_count));
> +               refcount_read(&inode->i_count));
>
>  out:
>         return inode;
> @@ -2229,7 +2229,7 @@ static int nfs_update_inode(struct inode *inode, st=
ruct nfs_fattr *fattr)
>         dfprintk(VFS, "NFS: %s(%s/%lu fh_crc=3D0x%08x ct=3D%d info=3D0x%l=
lx)\n",
>                         __func__, inode->i_sb->s_id, inode->i_ino,
>                         nfs_display_fhandle_hash(NFS_FH(inode)),
> -                       atomic_read(&inode->i_count), fattr->valid);
> +                       refcount_read(&inode->i_count), fattr->valid);
>
>         if (!(fattr->valid & NFS_ATTR_FATTR_FILEID)) {
>                 /* Only a mounted-on-fileid? Just exit */
> diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
> index 079b868552c2..0883696f873d 100644
> --- a/fs/notify/fsnotify.c
> +++ b/fs/notify/fsnotify.c
> @@ -66,7 +66,7 @@ static void fsnotify_unmount_inodes(struct super_block =
*sb)
>                  * removed all zero refcount inodes, in any case.  Test t=
o
>                  * be sure.
>                  */
> -               if (!atomic_read(&inode->i_count)) {
> +               if (!refcount_read(&inode->i_count)) {
>                         spin_unlock(&inode->i_lock);
>                         continue;
>                 }
> diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
> index f3e3b2068608..79526f71fa8a 100644
> --- a/fs/ubifs/super.c
> +++ b/fs/ubifs/super.c
> @@ -358,7 +358,7 @@ static void ubifs_evict_inode(struct inode *inode)
>                 goto out;
>
>         dbg_gen("inode %lu, mode %#x", inode->i_ino, (int)inode->i_mode);
> -       ubifs_assert(c, !atomic_read(&inode->i_count));
> +       ubifs_assert(c, !refcount_read(&inode->i_count));
>
>         truncate_inode_pages_final(&inode->i_data);
>
> diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
> index 9c39251961a3..06af749fe5f3 100644
> --- a/fs/xfs/xfs_inode.c
> +++ b/fs/xfs/xfs_inode.c
> @@ -1035,7 +1035,7 @@ xfs_itruncate_extents_flags(
>         int                     error =3D 0;
>
>         xfs_assert_ilocked(ip, XFS_ILOCK_EXCL);
> -       if (atomic_read(&VFS_I(ip)->i_count))
> +       if (refcount_read(&VFS_I(ip)->i_count))
>                 xfs_assert_ilocked(ip, XFS_IOLOCK_EXCL);
>         ASSERT(new_size <=3D XFS_ISIZE(ip));
>         ASSERT(tp->t_flags & XFS_TRANS_PERM_LOG_RES);
> diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
> index ac344e42846c..167d33b8095c 100644
> --- a/fs/xfs/xfs_trace.h
> +++ b/fs/xfs/xfs_trace.h
> @@ -1152,7 +1152,7 @@ DECLARE_EVENT_CLASS(xfs_iref_class,
>         TP_fast_assign(
>                 __entry->dev =3D VFS_I(ip)->i_sb->s_dev;
>                 __entry->ino =3D ip->i_ino;
> -               __entry->count =3D atomic_read(&VFS_I(ip)->i_count);
> +               __entry->count =3D refcount_read(&VFS_I(ip)->i_count);
>                 __entry->pincount =3D atomic_read(&ip->i_pincount);
>                 __entry->iflags =3D ip->i_flags;
>                 __entry->caller_ip =3D caller_ip;
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 8384ed81a5ad..34fb40ba8a94 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -880,7 +880,7 @@ struct inode {
>         };
>         atomic64_t              i_version;
>         atomic64_t              i_sequence; /* see futex */
> -       atomic_t                i_count;
> +       refcount_t              i_count;
>         atomic_t                i_dio_count;
>         atomic_t                i_writecount;
>  #if defined(CONFIG_IMA) || defined(CONFIG_FILE_LOCKING)
> @@ -3399,7 +3399,7 @@ static inline void iobj_get(struct inode *inode)
>  static inline void __iget(struct inode *inode)
>  {
>         iobj_get(inode);
> -       atomic_inc(&inode->i_count);
> +       refcount_inc(&inode->i_count);
>  }
>
>  extern void iget_failed(struct inode *);
> diff --git a/include/trace/events/filelock.h b/include/trace/events/filel=
ock.h
> index b8d1e00a7982..e745436cfcd2 100644
> --- a/include/trace/events/filelock.h
> +++ b/include/trace/events/filelock.h
> @@ -189,7 +189,7 @@ TRACE_EVENT(generic_add_lease,
>                 __entry->i_ino =3D inode->i_ino;
>                 __entry->wcount =3D atomic_read(&inode->i_writecount);
>                 __entry->rcount =3D atomic_read(&inode->i_readcount);
> -               __entry->icount =3D atomic_read(&inode->i_count);
> +               __entry->icount =3D refcount_read(&inode->i_count);
>                 __entry->owner =3D fl->c.flc_owner;
>                 __entry->flags =3D fl->c.flc_flags;
>                 __entry->type =3D fl->c.flc_type;
> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> index c04f8879ad03..570f851dc469 100644
> --- a/security/landlock/fs.c
> +++ b/security/landlock/fs.c
> @@ -1281,7 +1281,7 @@ static void hook_sb_delete(struct super_block *cons=
t sb)
>                 struct landlock_object *object;
>
>                 /* Only handles referenced inodes. */
> -               if (!atomic_read(&inode->i_count))
> +               if (!refcount_read(&inode->i_count))
>                         continue;
>
>                 /*
> --
> 2.49.0
>
>

