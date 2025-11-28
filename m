Return-Path: <linux-fsdevel+bounces-70136-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BACDEC91E33
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 12:55:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 828DF3ADF72
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 11:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32286325727;
	Fri, 28 Nov 2025 11:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E7VMLKwv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15DA316180
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Nov 2025 11:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764330945; cv=none; b=KheJNK0bD/qogadGiJZ/vR1lzqey72sAjlaKxY6dQBkOPh+aSeIPxaTUHoIvcuX22GFFBDbI7U7JOt3lUwT+sgMvxYU3S5c52IfnlqQWX3qylR0iI5bJ8e+H8SPHIAEFBxqNe1lLdEQvh/IpwaaNvU9mVdy1vYtlyMgh+6BAHic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764330945; c=relaxed/simple;
	bh=7McNmPYFhJWzXPpiEq0GRibRs9LFC7jSd5+BSIm+NUM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gEd5ELgsu3xui4OKmlmm9tcVofGMjK//0DAwYQGqLuSTwqvzVVL3c5I5+VzImAVAztE1dMcm54S6CMSCUJhL7ewg5ERCJ2uL5yKkWJzpXmAB5efIsqujEqNDlW09hpWvv2Tx4z23SfdblFXwpwCeD4lAnDCJR2FtEzvP2hRJYMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E7VMLKwv; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-64175dfc338so3522308a12.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Nov 2025 03:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764330942; x=1764935742; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fEVnrz7krGjC1H5D6ILDm2vm3QVpwlzQoLinf6WiPD4=;
        b=E7VMLKwvT4E7pjh3c2f8mPSfsRaYfsQkc8/GApcrK/Nfpud9Bl+Pg3Q5V521zb3jFC
         asea1V1Q+q/eIduzlP7c/Gi/AieN30gc83aAJ8+xb26kmhukp4G0+7rYiSwYK66cE4C5
         uASh3SXTGyAd4SFaInWi7ayM4MfQCCzGCcLe7/RrOIb3YpOWHKn8SaBTtA2Ro+8mRCI2
         6ifOFqNtA2dAxI4dwbF18daDUtBe2Z39FOKb2hN8shakjBm/mctpGHRbH+6DCztl47ct
         rgXIRl9lS7ruxxW9nZNM7YmAbdYApxhr7PP5H2jwK3v4V6t0GGsMwTHVnV4/MK0kzBgj
         xGWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764330942; x=1764935742;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fEVnrz7krGjC1H5D6ILDm2vm3QVpwlzQoLinf6WiPD4=;
        b=LRnXGEuLRR152pkEBGX9gqJ2Lhio9GHPzE2s1nK+Ic4cDXLaZupGzO3wt4wYXGkptN
         +9CVWPMOZznJHPRgVQhZJoiNdvBXXNgXRY44kbhtXzmGwixHhSYjr/p25cwTPQEjuXtI
         c0+KTEHoh/Woxpb/0lTcRtsyHrzN7U/9y+PV32Ros8Ilped43Z+lzY4BQKNEXIM/6SHH
         523rQ01esc7IpwLxidSpRVJV0fNzci+f9Fh8c9CgD7gWVNIP8sHdAGoI/YeDeYY9quFG
         fWRvFk4zO6+Li4trIjzqHN90CFsbFVs0YkHwIPCSAYnjUJWfAgjLr2XE9ZvZdtDcGSvx
         5lRw==
X-Gm-Message-State: AOJu0YwMxx8ZD4pcL5Xmn1vePgJvyy2VoiKXp2UZYTq4iOmM1RSau2j8
	s7wrjkyT5FPQj56s+5cUGqIlxumgUzZ2aBD+v+WOG0KR0YMc7wXu8r/tDWI6d5yqQVqvdDsc243
	dUgbsSOqP8hEHZoE6gTY0Pu1uP7XmbaY=
X-Gm-Gg: ASbGncuTSkJxUQ/9/KSPzhCCqklj0zj2spWG21i6Gdc/8gD4hI5SlH2K+Fcw8B0tl4y
	VYFy4UaRkg0IIARigo2idCzLv06H7kFk5cS0GLWBJOS2M3awQCFrl1Q4tFs5Qy6dKaNBEgRsAgl
	HRc3V/VbBprNU11OfITKz3RB6xK1qbSTTbkhsDqBcOl6sOMnZGvarjZcCaWvujutS89y2fg1AhB
	vdWapGfXt8ArFZF7g13y0ies+pZrSFN5kMouB4QrvpDLmLnV53hkGnymtuazB0at9+kdy7WZ62d
	TXsGt6VgeRoOCJvU+FDe4NtjXaW5Ur+bwQcC/JBP
X-Google-Smtp-Source: AGHT+IF2fxsudzS3hzBgUP/dnApVQ5Gn0jK+LZvWTGz72+HWVbagZFuQ+aqLr3BEnwmssw3RCdCgRrdYweSuEBX6PV8=
X-Received: by 2002:a05:6402:26d3:b0:643:1659:7584 with SMTP id
 4fb4d7f45d1cf-6455469ce5dmr24777917a12.33.1764330941882; Fri, 28 Nov 2025
 03:55:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251127170509.30139-1-jack@suse.cz> <20251127173012.23500-16-jack@suse.cz>
In-Reply-To: <20251127173012.23500-16-jack@suse.cz>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 28 Nov 2025 12:55:30 +0100
X-Gm-Features: AWmQ_bnH1l-IDU7kZSmAHLcahJu2alhyiidxIG46rmBYY_FJyv1eg0gkQWzPM8M
Message-ID: <CAOQ4uxg+HngKBK3kc6wLLeLPLe4Yh_7dPyZyHGs9Bh5=zBR0TA@mail.gmail.com>
Subject: Re: [PATCH 03/13] fsnotify: Introduce inode connector hash
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 27, 2025 at 6:30=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> Introduce rhashtable that will contain all inode connectors for a
> superblock. As for some filesystems inode number is not enough to
> identify inode, provide enough flexibility for such filesystems to
> provide their own keys for the hash. Eventually we will use this hash
> table to track all inode connectors (and thus marks) for the superblock
> and also to track inode marks for inodes that were evicted from memory
> (so that inode marks don't have to pin inodes in memory anymore).
>
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  fs/notify/fsnotify.c             |  12 ++-
>  fs/notify/fsnotify.h             |   4 +-
>  fs/notify/mark.c                 | 176 +++++++++++++++++++++++++++----
>  include/linux/fs.h               |   3 +
>  include/linux/fsnotify.h         |   9 ++
>  include/linux/fsnotify_backend.h |   6 +-
>  6 files changed, 187 insertions(+), 23 deletions(-)
>
> diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
> index 079b868552c2..46db712c83ec 100644
> --- a/fs/notify/fsnotify.c
> +++ b/fs/notify/fsnotify.c
> @@ -110,9 +110,16 @@ void fsnotify_sb_delete(struct super_block *sb)
>                                                   FSNOTIFY_PRIO_PRE_CONTE=
NT));
>  }
>
> +void fsnotify_free_sb_info(struct fsnotify_sb_info *sbinfo)
> +{
> +       rhashtable_destroy(&sbinfo->inode_conn_hash);
> +       kfree(sbinfo);
> +}
> +
>  void fsnotify_sb_free(struct super_block *sb)
>  {
> -       kfree(sb->s_fsnotify_info);
> +       if (sb->s_fsnotify_info)
> +               fsnotify_free_sb_info(sb->s_fsnotify_info);
>  }
>
>  /*
> @@ -770,8 +777,7 @@ static __init int fsnotify_init(void)
>         if (ret)
>                 panic("initializing fsnotify_mark_srcu");
>
> -       fsnotify_mark_connector_cachep =3D KMEM_CACHE(fsnotify_mark_conne=
ctor,
> -                                                   SLAB_PANIC);
> +       fsnotify_init_connector_caches();
>
>         return 0;
>  }
> diff --git a/fs/notify/fsnotify.h b/fs/notify/fsnotify.h
> index 860a07ada7fd..e9160c0e1a70 100644
> --- a/fs/notify/fsnotify.h
> +++ b/fs/notify/fsnotify.h
> @@ -108,6 +108,8 @@ static inline void fsnotify_clear_marks_by_mntns(stru=
ct mnt_namespace *mntns)
>   */
>  extern void fsnotify_set_children_dentry_flags(struct inode *inode);
>
> -extern struct kmem_cache *fsnotify_mark_connector_cachep;
> +void fsnotify_free_sb_info(struct fsnotify_sb_info *sbinfo);
> +
> +void fsnotify_init_connector_caches(void);
>
>  #endif /* __FS_NOTIFY_FSNOTIFY_H_ */
> diff --git a/fs/notify/mark.c b/fs/notify/mark.c
> index ecd2c3944051..fd1fe8d37c36 100644
> --- a/fs/notify/mark.c
> +++ b/fs/notify/mark.c
> @@ -79,7 +79,8 @@
>  #define FSNOTIFY_REAPER_DELAY  (1)     /* 1 jiffy */
>
>  struct srcu_struct fsnotify_mark_srcu;
> -struct kmem_cache *fsnotify_mark_connector_cachep;
> +static struct kmem_cache *fsnotify_mark_connector_cachep;
> +static struct kmem_cache *fsnotify_inode_mark_connector_cachep;
>
>  static DEFINE_SPINLOCK(destroy_lock);
>  static LIST_HEAD(destroy_list);
> @@ -91,6 +92,8 @@ static DECLARE_DELAYED_WORK(reaper_work, fsnotify_mark_=
destroy_workfn);
>  static void fsnotify_connector_destroy_workfn(struct work_struct *work);
>  static DECLARE_WORK(connector_reaper_work, fsnotify_connector_destroy_wo=
rkfn);
>
> +static void fsnotify_unhash_connector(struct fsnotify_mark_connector *co=
nn);
> +
>  void fsnotify_get_mark(struct fsnotify_mark *mark)
>  {
>         WARN_ON_ONCE(!refcount_read(&mark->refcnt));
> @@ -323,7 +326,7 @@ static void fsnotify_connector_destroy_workfn(struct =
work_struct *work)
>         while (conn) {
>                 free =3D conn;
>                 conn =3D conn->destroy_next;
> -               kmem_cache_free(fsnotify_mark_connector_cachep, free);
> +               kfree(free);
>         }
>  }
>
> @@ -342,6 +345,7 @@ static void *fsnotify_detach_connector_from_object(
>         if (conn->type =3D=3D FSNOTIFY_OBJ_TYPE_INODE) {
>                 inode =3D fsnotify_conn_inode(conn);
>                 inode->i_fsnotify_mask =3D 0;
> +               fsnotify_unhash_connector(conn);
>
>                 /* Unpin inode when detaching from connector */
>                 if (!(conn->flags & FSNOTIFY_CONN_FLAG_HAS_IREF))
> @@ -384,6 +388,15 @@ static void fsnotify_drop_object(unsigned int type, =
void *objp)
>         fsnotify_put_inode_ref(objp);
>  }
>
> +static void fsnotify_free_connector(struct fsnotify_mark_connector *conn=
)
> +{
> +       spin_lock(&destroy_lock);
> +       conn->destroy_next =3D connector_destroy_list;
> +       connector_destroy_list =3D conn;
> +       spin_unlock(&destroy_lock);
> +       queue_work(system_unbound_wq, &connector_reaper_work);
> +}
> +
>  void fsnotify_put_mark(struct fsnotify_mark *mark)
>  {
>         struct fsnotify_mark_connector *conn =3D READ_ONCE(mark->connecto=
r);
> @@ -421,13 +434,8 @@ void fsnotify_put_mark(struct fsnotify_mark *mark)
>
>         fsnotify_drop_object(type, objp);
>
> -       if (free_conn) {
> -               spin_lock(&destroy_lock);
> -               conn->destroy_next =3D connector_destroy_list;
> -               connector_destroy_list =3D conn;
> -               spin_unlock(&destroy_lock);
> -               queue_work(system_unbound_wq, &connector_reaper_work);
> -       }
> +       if (free_conn)
> +               fsnotify_free_connector(conn);
>         /*
>          * Note that we didn't update flags telling whether inode cares a=
bout
>          * what's happening with children. We update these flags from
> @@ -633,22 +641,136 @@ int fsnotify_compare_groups(struct fsnotify_group =
*a, struct fsnotify_group *b)
>         return -1;
>  }
>
> +/*
> + * Inode connector for filesystems where inode->i_ino uniquely identifie=
s the
> + * inode.
> + */
> +struct fsnotify_inode_mark_connector {
> +       struct fsnotify_mark_connector common;
> +       ino_t ino;
> +       struct rhash_head hash_list;
> +};

If only adding a list_head and no fs specific stuff,
I don't think we will need a dedicated fsnotify_inode_mark_connector

I think the whole thing could be done in a single not so complicated
patch. I did not see any patch in the series other than the iteration
patch and parts of this one that would be needed if we go for
inode connectors list before going to the hash table.

Thanks,
Amir.

