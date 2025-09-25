Return-Path: <linux-fsdevel+bounces-62711-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D4BB9E8F2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 12:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1347D4E325D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 10:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A728C2EA485;
	Thu, 25 Sep 2025 10:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="co/lHs+q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DDEA2882B6
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Sep 2025 10:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758794851; cv=none; b=S0IK1qno1aEMZ6DtXJ58qcy7ClUYoRAA4Zxlm0qCRcRW9Y4Nz1JHYNw06KzTpSH6x3iZo+OrdRrhfqe70y/hve74qHryZSrlQG494YlH+bgNaFW5qiTwm3f0uUc6HXaA/F38K8PrviLH4AG91NOHy08lG62pWycBFE1tE35JQ4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758794851; c=relaxed/simple;
	bh=rFy/sAVpE33mTE9Ro6oXr14+P+7ZyrAS5jnU7fHzki4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WWGZWNIjqGJQrIHtgRoS9wXtwKH7qjjJycJfXv36GtDKOF2MEtzxtXQvRIphmrS77uov33urVspmow7dZp2huU0k9e6TUeicTcF5YgtV14vuUZjAzVnAfsDWmjBNk/vrvR/SPMdxO8uZlDJxmmnVKLTgtcQgVA4yP7Kp5xeXLkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=co/lHs+q; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b07e3a77b72so317175666b.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Sep 2025 03:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758794847; x=1759399647; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PUW/6o2CHQs8nlFUZsHr+ogKyFCjqfHWD4lpshBRaKQ=;
        b=co/lHs+q9tCk6n63T7oEqDY5tUvNB/rzjvdylC087NLiKPwT1Zxgh6gEciLY1Shz43
         AJDJ8e1D/iZGh4DUX0+YpqWrXJvBxs1iEGAksjdLwPwIDm9Q+Tzz63GMHG03c52OnQSF
         gYmNOGv8OaJdnMg4U9ADZLxGBV+usv/qIPeCSMfyJcKbMZk0A+fo4zPToTmPQLaGv4ii
         SSMvWUKHf9DZo/F0rRsByFoLyZR9FEhRbAG5+w8CAR1qmyo+1R2xtWrTMi1Haq8T+oWR
         M8t5ORjCixyofiAj3UrdtIWdz9pU3bxqpzojxcnru9wYR7TxE4DvyINcLo6ZEbljJ/Tb
         1ArA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758794847; x=1759399647;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PUW/6o2CHQs8nlFUZsHr+ogKyFCjqfHWD4lpshBRaKQ=;
        b=pFUCW33a1p3LiN4oVtkMuMQHwNtti9jAoJAiAXs++HHKCEkk2HRtUwrCG7NnyDLMsF
         lSNp2HvuJQocGLKt23xKyj4OZRcHtayfdyJIlDnWt09TN78xVWeygB1ktee9HMO6STuZ
         1J+51AKIWeYAIagGXpm/6oVBYL4Qww87/CvjW86zEef88Ka47vKVFoiUSZMPcFEajoyL
         Mx3HzlRsl1sWTC5Yq9DKBnCx0Ab5sOYCnSRQq4u5i49XVLy/uFQ6TWKJyqYyL9n+WxAy
         3UJAV7gw22DClVUVb0WsoxcaNXjSLqfCExNTlIxf3SCTO26YEbmPCy7AU3TZXJI4v9/A
         0juQ==
X-Forwarded-Encrypted: i=1; AJvYcCXAVVfUNLf/d/rhOlpUk/4gLeC2wGDQY4kY/KX7Ii8DP2XyrzxOfAlLto5v2NWmQw8EeNOnOCKdjo07V5B6@vger.kernel.org
X-Gm-Message-State: AOJu0YzWcGzjK+/rD8nARi3Yz+ge8dPQVPt91HGhd4RcEFH+HjzFhXs1
	zYSU9eeLaXNDgi4STA3YaKuFVZPZcBjb7GD7mRu0ClLGBMwjqJe5w+q6lYYmYKJHAhXyMS9EnsF
	SnWp3Bph1A5obckIgHlTthNDidBNElrM=
X-Gm-Gg: ASbGncummcb9qQNvzY1LA62IdYfgkzwjPbSYpGTSvi/7+cIdOU2W8fLhDfIcJ461zqq
	4eSC1qh34dljb3YG/rr0t91zbamXNR+GRwmqHWjP+VtzTqWK0KstchnCQNxldMNJ9veyot1YYyX
	aHUO7OdkxDNra9VZSrrP5ctmSRW5NBz+w3XG3bfJAnL6cQpLC+POFGf3sFCdRcu8AZTjFZXP0EB
	9zV+2OjynxRycUeQUEtLrFIARFDFa7W9fd9pw==
X-Google-Smtp-Source: AGHT+IHnjX1pG8TAryPQlkrDhzXnesEsM78CxhQPCj7SV7L5RRG+rd032XQ0sOmqzmFns8RoyZIP2E4vF4R8O9SgsVc=
X-Received: by 2002:a17:907:720b:b0:b2d:38eb:d12f with SMTP id
 a640c23a62f3a-b354cc2c49fmr191751466b.19.1758794846407; Thu, 25 Sep 2025
 03:07:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250923104710.2973493-1-mjguzik@gmail.com> <20250923104710.2973493-4-mjguzik@gmail.com>
In-Reply-To: <20250923104710.2973493-4-mjguzik@gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 25 Sep 2025 12:07:13 +0200
X-Gm-Features: AS18NWBbppLQvOh16nxVRueCI4eRmKFPlkIfNmlj21eycccVTLBfnR3npYDOJvk
Message-ID: <CAGudoHGuFSfSCZcoky+5wX1QfVpg-tj42c2SJijfT7ke_6tR7Q@mail.gmail.com>
Subject: Re: [PATCH v6 3/4] Manual conversion of ->i_state uses
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, kernel-team@fb.com, 
	amir73il@gmail.com, linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-xfs@vger.kernel.org, ceph-devel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

allmodconfig build was done on this patchset but somehow one failure was mi=
ssed:

diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index e9538e91f848..71ec043f7569 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -427,7 +427,7 @@ static void afs_fetch_status_success(struct
afs_operation *op)
        struct afs_vnode *vnode =3D vp->vnode;
        int ret;

-       if (vnode->netfs.inode.i_state & I_NEW) {
+       if (inode_state_read(&vnode->netfs.inode) & I_NEW) {
                ret =3D afs_inode_init_from_status(op, vp, vnode);
                afs_op_set_error(op, ret);
                if (ret =3D=3D 0)


I reran the thing with this bit and now it's all clean. I think this
can be folded into the manual fixup patch (the one i'm responding to)
instead of resending the patchset

On Tue, Sep 23, 2025 at 12:47=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com> =
wrote:
>
> Takes care of spots not converted by coccinelle.
>
> Nothing to look at with one exception: smp_store_release and
> smp_load_acquire pair replaced with a manual store/load +
> smb_wmb()/smp_rmb(), see I_WB_SWITCH.
>
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> ---
>  Documentation/filesystems/porting.rst | 2 +-
>  fs/bcachefs/fs.c                      | 8 ++++----
>  fs/btrfs/inode.c                      | 8 ++++----
>  fs/dcache.c                           | 2 +-
>  fs/fs-writeback.c                     | 6 +++---
>  fs/inode.c                            | 8 ++++----
>  fs/ocfs2/inode.c                      | 2 +-
>  fs/xfs/xfs_reflink.h                  | 2 +-
>  include/linux/backing-dev.h           | 7 ++++---
>  include/linux/fs.h                    | 2 +-
>  include/linux/writeback.h             | 4 ++--
>  include/trace/events/writeback.h      | 8 ++++----
>  12 files changed, 30 insertions(+), 29 deletions(-)
>
> diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesy=
stems/porting.rst
> index 85f590254f07..0629611600f1 100644
> --- a/Documentation/filesystems/porting.rst
> +++ b/Documentation/filesystems/porting.rst
> @@ -211,7 +211,7 @@ test and set for you.
>  e.g.::
>
>         inode =3D iget_locked(sb, ino);
> -       if (inode->i_state & I_NEW) {
> +       if (inode_state_read(inode) & I_NEW) {
>                 err =3D read_inode_from_disk(inode);
>                 if (err < 0) {
>                         iget_failed(inode);
> diff --git a/fs/bcachefs/fs.c b/fs/bcachefs/fs.c
> index 687af0eea0c2..8c7efc194ad0 100644
> --- a/fs/bcachefs/fs.c
> +++ b/fs/bcachefs/fs.c
> @@ -347,7 +347,7 @@ static struct bch_inode_info *bch2_inode_hash_find(st=
ruct bch_fs *c, struct btre
>                         spin_unlock(&inode->v.i_lock);
>                         return NULL;
>                 }
> -               if ((inode->v.i_state & (I_FREEING|I_WILL_FREE))) {
> +               if ((inode_state_read(&inode->v) & (I_FREEING|I_WILL_FREE=
))) {
>                         if (!trans) {
>                                 __wait_on_freeing_inode(c, inode, inum);
>                         } else {
> @@ -411,7 +411,7 @@ static struct bch_inode_info *bch2_inode_hash_insert(=
struct bch_fs *c,
>                  * only insert fully created inodes in the inode hash tab=
le. But
>                  * discard_new_inode() expects it to be set...
>                  */
> -               inode->v.i_state |=3D I_NEW;
> +               inode_state_set(&inode->v, I_NEW);
>                 /*
>                  * We don't want bch2_evict_inode() to delete the inode o=
n disk,
>                  * we just raced and had another inode in cache. Normally=
 new
> @@ -2224,8 +2224,8 @@ void bch2_evict_subvolume_inodes(struct bch_fs *c, =
snapshot_id_list *s)
>                 if (!snapshot_list_has_id(s, inode->ei_inum.subvol))
>                         continue;
>
> -               if (!(inode->v.i_state & I_DONTCACHE) &&
> -                   !(inode->v.i_state & I_FREEING) &&
> +               if (!(inode_state_read(&inode->v) & I_DONTCACHE) &&
> +                   !(inode_state_read(&inode->v) & I_FREEING) &&
>                     igrab(&inode->v)) {
>                         this_pass_clean =3D false;
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 8e2ab3fb9070..d2f7e7c57a36 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -3856,7 +3856,7 @@ static int btrfs_add_inode_to_root(struct btrfs_ino=
de *inode, bool prealloc)
>                 ASSERT(ret !=3D -ENOMEM);
>                 return ret;
>         } else if (existing) {
> -               WARN_ON(!(existing->vfs_inode.i_state & (I_WILL_FREE | I_=
FREEING)));
> +               WARN_ON(!(inode_state_read(&existing->vfs_inode) & (I_WIL=
L_FREE | I_FREEING)));
>         }
>
>         return 0;
> @@ -5745,7 +5745,7 @@ struct btrfs_inode *btrfs_iget_path(u64 ino, struct=
 btrfs_root *root,
>         if (!inode)
>                 return ERR_PTR(-ENOMEM);
>
> -       if (!(inode->vfs_inode.i_state & I_NEW))
> +       if (!(inode_state_read(&inode->vfs_inode) & I_NEW))
>                 return inode;
>
>         ret =3D btrfs_read_locked_inode(inode, path);
> @@ -5769,7 +5769,7 @@ struct btrfs_inode *btrfs_iget(u64 ino, struct btrf=
s_root *root)
>         if (!inode)
>                 return ERR_PTR(-ENOMEM);
>
> -       if (!(inode->vfs_inode.i_state & I_NEW))
> +       if (!(inode_state_read(&inode->vfs_inode) & I_NEW))
>                 return inode;
>
>         path =3D btrfs_alloc_path();
> @@ -7435,7 +7435,7 @@ static void btrfs_invalidate_folio(struct folio *fo=
lio, size_t offset,
>         u64 page_start =3D folio_pos(folio);
>         u64 page_end =3D page_start + folio_size(folio) - 1;
>         u64 cur;
> -       int inode_evicting =3D inode->vfs_inode.i_state & I_FREEING;
> +       int inode_evicting =3D inode_state_read(&inode->vfs_inode) & I_FR=
EEING;
>
>         /*
>          * We have folio locked so no new ordered extent can be created o=
n this
> diff --git a/fs/dcache.c b/fs/dcache.c
> index 2cb340c52191..bc275f7364db 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -1981,7 +1981,7 @@ void d_instantiate_new(struct dentry *entry, struct=
 inode *inode)
>         spin_lock(&inode->i_lock);
>         __d_instantiate(entry, inode);
>         WARN_ON(!(inode_state_read(inode) & I_NEW));
> -       inode->i_state &=3D ~I_NEW & ~I_CREATING;
> +       inode_state_clear(inode, I_NEW | I_CREATING);
>         /*
>          * Pairs with the barrier in prepare_to_wait_event() to make sure
>          * ___wait_var_event() either sees the bit cleared or
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index f521ef30d9a4..72424d3314aa 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -475,11 +475,11 @@ static bool inode_do_switch_wbs(struct inode *inode=
,
>         switched =3D true;
>  skip_switch:
>         /*
> -        * Paired with load_acquire in unlocked_inode_to_wb_begin() and
> +        * Paired with smp_rmb in unlocked_inode_to_wb_begin() and
>          * ensures that the new wb is visible if they see !I_WB_SWITCH.
>          */
> -       smp_store_release(&inode->i_state,
> -                         inode_state_read(inode) & ~I_WB_SWITCH);
> +       smp_wmb();
> +       inode_state_clear(inode, I_WB_SWITCH);
>
>         xa_unlock_irq(&mapping->i_pages);
>         spin_unlock(&inode->i_lock);
> diff --git a/fs/inode.c b/fs/inode.c
> index 4b54aba2e939..f9f3476c773b 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -829,7 +829,7 @@ static void evict(struct inode *inode)
>          * This also means we don't need any fences for the call below.
>          */
>         inode_wake_up_bit(inode, __I_NEW);
> -       BUG_ON(inode->i_state !=3D (I_FREEING | I_CLEAR));
> +       BUG_ON(inode_state_read(inode) !=3D (I_FREEING | I_CLEAR));
>
>         destroy_inode(inode);
>  }
> @@ -1895,7 +1895,7 @@ static void iput_final(struct inode *inode)
>
>         state =3D inode_state_read(inode);
>         if (!drop) {
> -               WRITE_ONCE(inode->i_state, state | I_WILL_FREE);
> +               inode_state_set(inode, I_WILL_FREE);
>                 spin_unlock(&inode->i_lock);
>
>                 write_inode_now(inode, 1);
> @@ -1906,7 +1906,7 @@ static void iput_final(struct inode *inode)
>                 state &=3D ~I_WILL_FREE;
>         }
>
> -       WRITE_ONCE(inode->i_state, state | I_FREEING);
> +       inode_state_assign(inode, state | I_FREEING);
>         if (!list_empty(&inode->i_lru))
>                 inode_lru_list_del(inode);
>         spin_unlock(&inode->i_lock);
> @@ -2964,7 +2964,7 @@ void dump_inode(struct inode *inode, const char *re=
ason)
>         pr_warn("%s encountered for inode %px\n"
>                 "fs %s mode %ho opflags 0x%hx flags 0x%x state 0x%x count=
 %d\n",
>                 reason, inode, sb->s_type->name, inode->i_mode, inode->i_=
opflags,
> -               inode->i_flags, inode->i_state, atomic_read(&inode->i_cou=
nt));
> +               inode->i_flags, inode_state_read(inode), atomic_read(&ino=
de->i_count));
>  }
>
>  EXPORT_SYMBOL(dump_inode);
> diff --git a/fs/ocfs2/inode.c b/fs/ocfs2/inode.c
> index 549f9c145dcc..50218209d04d 100644
> --- a/fs/ocfs2/inode.c
> +++ b/fs/ocfs2/inode.c
> @@ -152,7 +152,7 @@ struct inode *ocfs2_iget(struct ocfs2_super *osb, u64=
 blkno, unsigned flags,
>                 mlog_errno(PTR_ERR(inode));
>                 goto bail;
>         }
> -       trace_ocfs2_iget5_locked(inode->i_state);
> +       trace_ocfs2_iget5_locked(inode_state_read(inode));
>         if (inode_state_read(inode) & I_NEW) {
>                 rc =3D ocfs2_read_locked_inode(inode, &args);
>                 unlock_new_inode(inode);
> diff --git a/fs/xfs/xfs_reflink.h b/fs/xfs/xfs_reflink.h
> index 36cda724da89..86e87e5936b5 100644
> --- a/fs/xfs/xfs_reflink.h
> +++ b/fs/xfs/xfs_reflink.h
> @@ -17,7 +17,7 @@ xfs_can_free_cowblocks(struct xfs_inode *ip)
>  {
>         struct inode *inode =3D VFS_I(ip);
>
> -       if ((inode->i_state & I_DIRTY_PAGES) ||
> +       if ((inode_state_read(inode) & I_DIRTY_PAGES) ||
>             mapping_tagged(inode->i_mapping, PAGECACHE_TAG_DIRTY) ||
>             mapping_tagged(inode->i_mapping, PAGECACHE_TAG_WRITEBACK) ||
>             atomic_read(&inode->i_dio_count))
> diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
> index e721148c95d0..07a60bbbf668 100644
> --- a/include/linux/backing-dev.h
> +++ b/include/linux/backing-dev.h
> @@ -289,10 +289,11 @@ unlocked_inode_to_wb_begin(struct inode *inode, str=
uct wb_lock_cookie *cookie)
>         rcu_read_lock();
>
>         /*
> -        * Paired with store_release in inode_switch_wbs_work_fn() and
> -        * ensures that we see the new wb if we see cleared I_WB_SWITCH.
> +        * Paired with smp_wmb in inode_do_switch_wbs() and ensures that =
we see
> +        * the new wb if we see cleared I_WB_SWITCH.
>          */
> -       cookie->locked =3D smp_load_acquire(&inode->i_state) & I_WB_SWITC=
H;
> +       cookie->locked =3D inode_state_read(inode) & I_WB_SWITCH;
> +       smp_rmb();
>
>         if (unlikely(cookie->locked))
>                 xa_lock_irqsave(&inode->i_mapping->i_pages, cookie->flags=
);
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 06bece8d1f18..73f3ce5add6b 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2656,7 +2656,7 @@ static inline int icount_read(const struct inode *i=
node)
>   */
>  static inline bool inode_is_dirtytime_only(struct inode *inode)
>  {
> -       return (inode->i_state & (I_DIRTY_TIME | I_NEW |
> +       return (inode_state_read(inode) & (I_DIRTY_TIME | I_NEW |
>                                   I_FREEING | I_WILL_FREE)) =3D=3D I_DIRT=
Y_TIME;
>  }
>
> diff --git a/include/linux/writeback.h b/include/linux/writeback.h
> index a2848d731a46..5fcb5ab4fa47 100644
> --- a/include/linux/writeback.h
> +++ b/include/linux/writeback.h
> @@ -193,7 +193,7 @@ void inode_io_list_del(struct inode *inode);
>  static inline void wait_on_inode(struct inode *inode)
>  {
>         wait_var_event(inode_state_wait_address(inode, __I_NEW),
> -                      !(READ_ONCE(inode->i_state) & I_NEW));
> +                      !(inode_state_read(inode) & I_NEW));
>  }
>
>  #ifdef CONFIG_CGROUP_WRITEBACK
> @@ -234,7 +234,7 @@ static inline void inode_attach_wb(struct inode *inod=
e, struct folio *folio)
>  static inline void inode_detach_wb(struct inode *inode)
>  {
>         if (inode->i_wb) {
> -               WARN_ON_ONCE(!(inode->i_state & I_CLEAR));
> +               WARN_ON_ONCE(!(inode_state_read(inode) & I_CLEAR));
>                 wb_put(inode->i_wb);
>                 inode->i_wb =3D NULL;
>         }
> diff --git a/include/trace/events/writeback.h b/include/trace/events/writ=
eback.h
> index 1e23919c0da9..70c496954473 100644
> --- a/include/trace/events/writeback.h
> +++ b/include/trace/events/writeback.h
> @@ -120,7 +120,7 @@ DECLARE_EVENT_CLASS(writeback_dirty_inode_template,
>                 /* may be called for files on pseudo FSes w/ unregistered=
 bdi */
>                 strscpy_pad(__entry->name, bdi_dev_name(bdi), 32);
>                 __entry->ino            =3D inode->i_ino;
> -               __entry->state          =3D inode->i_state;
> +               __entry->state          =3D inode_state_read(inode);
>                 __entry->flags          =3D flags;
>         ),
>
> @@ -719,7 +719,7 @@ TRACE_EVENT(writeback_sb_inodes_requeue,
>                 strscpy_pad(__entry->name,
>                             bdi_dev_name(inode_to_bdi(inode)), 32);
>                 __entry->ino            =3D inode->i_ino;
> -               __entry->state          =3D inode->i_state;
> +               __entry->state          =3D inode_state_read(inode);
>                 __entry->dirtied_when   =3D inode->dirtied_when;
>                 __entry->cgroup_ino     =3D __trace_wb_assign_cgroup(inod=
e_to_wb(inode));
>         ),
> @@ -758,7 +758,7 @@ DECLARE_EVENT_CLASS(writeback_single_inode_template,
>                 strscpy_pad(__entry->name,
>                             bdi_dev_name(inode_to_bdi(inode)), 32);
>                 __entry->ino            =3D inode->i_ino;
> -               __entry->state          =3D inode->i_state;
> +               __entry->state          =3D inode_state_read(inode);
>                 __entry->dirtied_when   =3D inode->dirtied_when;
>                 __entry->writeback_index =3D inode->i_mapping->writeback_=
index;
>                 __entry->nr_to_write    =3D nr_to_write;
> @@ -810,7 +810,7 @@ DECLARE_EVENT_CLASS(writeback_inode_template,
>         TP_fast_assign(
>                 __entry->dev    =3D inode->i_sb->s_dev;
>                 __entry->ino    =3D inode->i_ino;
> -               __entry->state  =3D inode->i_state;
> +               __entry->state  =3D inode_state_read(inode);
>                 __entry->mode   =3D inode->i_mode;
>                 __entry->dirtied_when =3D inode->dirtied_when;
>         ),
> --
> 2.43.0
>

