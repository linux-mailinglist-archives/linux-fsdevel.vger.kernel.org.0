Return-Path: <linux-fsdevel+bounces-36436-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 146789E3A7E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 13:56:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EECAB24A25
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 12:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F5141B415A;
	Wed,  4 Dec 2024 12:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=omnibond-com.20230601.gappssmtp.com header.i=@omnibond-com.20230601.gappssmtp.com header.b="gtCQA2h/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CDC18452C
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Dec 2024 12:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733316286; cv=none; b=niWTAKgXHkYV6dw3ST7Oo+5lVx9Ot4vi99yAu4k5vJBVFFkcG7j6gW+AOfGz+6rmHIVtBqU/gnYLyi37KP9qF87uMjdAhRUWFxvZizqQE4dVQyVfLAW1uafyZpySrx2mgB5NxmNHEot2LN2C6RAS1UEuo3quQ+N301qxZrgPNpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733316286; c=relaxed/simple;
	bh=p8U5N7eOgaHbGroo6CGwLdSunVzDQRv4NF+rxSTo7D4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=RlZzuGbOKlxjlQNq25jEuykut/eLDtlz97UtOEgLGhienia4Q8F374pikdLXuX4ajfTVO8pkvcJrEaS6aKkVepTifpE3d0Z5IfVZFdG0Y0eJPj7XhqpcPYiGV7Sj7/luA310o4o5+FftcUJGVhC4vQeyAaiZ5sGKg6qe63db3Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omnibond.com; spf=pass smtp.mailfrom=omnibond.com; dkim=pass (2048-bit key) header.d=omnibond-com.20230601.gappssmtp.com header.i=@omnibond-com.20230601.gappssmtp.com header.b=gtCQA2h/; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omnibond.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omnibond.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-215b4681c94so21149075ad.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Dec 2024 04:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20230601.gappssmtp.com; s=20230601; t=1733316284; x=1733921084; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OLHoqfZuXr0T3EBegaMu9E+vGqRUgACnHd+ErPoaQEE=;
        b=gtCQA2h/ru2lRqBUQC6lnh+SBaLy12PzWZn8MatlseEzmxDVa3+9kPT7+iE6iYGHml
         Q8uHHq25mjKP/o8q2Q+V4Zgw6rswxALz0AiLcT/p7jYt3sCFXpnoNYD2aOoLX8R1UxK7
         PJlz4IV9bfwNQYRya7L9dWI8PilxCK1fc4wmormBgkzq1IdaMgHDZN92p0zEu7RAq5OM
         bcEsGZmb9CsuSTJ5g6b90R6srNQk/plzksZ1XJrO6kQ3OHmbIHTJ4j7gYjEb+QsiMZkF
         nPBcpTIMiUjwe7YDSoxH9uImkqTBIbC3qYKWRcXr/aaAwdnPA5CfPB1E5JCrBdveKt/J
         xLWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733316284; x=1733921084;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OLHoqfZuXr0T3EBegaMu9E+vGqRUgACnHd+ErPoaQEE=;
        b=giwbVgASpyK3WOgozVA71528Mb1MHBA76Wr9LxJspyZ5ntSdBfrD3p2RxMGl3e9zJk
         qXtjJ2LojqwdRgOSTCvVUChfVVmqiSiY7HsDbeo08//kk1MhgWxBx8hpUv+kIFVYIsKB
         IahoBDIaqbjGMEkgYmKzEArY5cUhGS1BXd09Fcuemf/Yf6Jv4mgd1Hg2L84HJajr55dF
         DXW0ntLAVYo28O9RrmXo8xal8LeAbeKmVEehBosANKBsxmNFHwRPBSBXZpFKFDNTHTM7
         s0ccKXUYIi5wD5jbLnBQNUeux2fnTC1l6WMyKxRFTbMnrXRk6OoNqu7kvx9GE+4APLtt
         2moQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMns6NqUu0mfX6Ag2YFUVMQPKV7jE33BYizbM27HikDb1wVd93ZnRsb9fO77aJrtQoXzH4ZH7V8WamKpzw@vger.kernel.org
X-Gm-Message-State: AOJu0YzI39xCQRBMhQECu3vBbSOeNCM/gA5XG4JFwt9jjQgh10ISUgkb
	EYX8pWWsejWIknbMg5n2x9EUdEvtZzRCSKQLTWAzBzoUhzjpWUiEBnU8Sjdh0ZkA+XvutE1xRaV
	yDqS/S/JTgImvwIzExe0Y71XrvbyhB52ac7k5
X-Gm-Gg: ASbGnctT2qAynIB3EHtWTyJrN7rPEY9+/1NdDu81Z9JWqM9Rnat5i+G4QZc2NJ7K4gl
	SiUjo4g/1fRSS+RzFO31rch+WVktcorJhVavNb5KetQ==
X-Google-Smtp-Source: AGHT+IGLYXAil4YBT9KEzgc/riB6FuydkXKjmod24lT19ipTGIX+eMkC1ZgdGzBUwRuelHHAVAS3FoDv2XG8jH90cac=
X-Received: by 2002:a17:902:ec8b:b0:215:19ae:77bf with SMTP id
 d9443c01a7336-215bd0d8999mr82552125ad.19.1733316283696; Wed, 04 Dec 2024
 04:44:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241122-guestmem-library-v5-0-450e92951a15@quicinc.com> <20241122-guestmem-library-v5-1-450e92951a15@quicinc.com>
In-Reply-To: <20241122-guestmem-library-v5-1-450e92951a15@quicinc.com>
From: Mike Marshall <hubcap@omnibond.com>
Date: Wed, 4 Dec 2024 07:44:31 -0500
Message-ID: <CAOg9mSRqCnSManMT38-EdbSTHotAg9KFbEpg9feCDQPFWrgHzw@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] filemap: Pass address_space mapping to ->free_folio()
To: Elliot Berman <quic_eberman@quicinc.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	Mike Marshall <hubcap@omnibond.com>, devel@lists.orangefs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Elliot...

I added your "v5 1/2" patch to "Linux 6.13-rc1" and ran it through
xfstests with no regressions.

you can add my Tested-by: Mike Marshall <hubcap@omnibond.com>

-Mike

On Fri, Nov 22, 2024 at 12:30=E2=80=AFPM Elliot Berman <quic_eberman@quicin=
c.com> wrote:
>
> When guest_memfd becomes a library, a callback will need to be made to
> the owner (KVM SEV) to update the RMP entry for the page back to shared
> state. This is currently being done as part of .free_folio() operation,
> but this callback shouldn't assume that folio->mapping is set/valid.
>
> The mapping is well-known to callers of .free_folio(), so pass that
> mapping so the callback can access the mapping's private data.
>
> Link: https://lore.kernel.org/all/15f665b4-2d33-41ca-ac50-fafe24ade32f@re=
dhat.com/
> Suggested-by: David Hildenbrand <david@redhat.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> ---
>  Documentation/filesystems/locking.rst |  2 +-
>  fs/nfs/dir.c                          | 11 ++++++-----
>  fs/orangefs/inode.c                   |  3 ++-
>  include/linux/fs.h                    |  2 +-
>  mm/filemap.c                          |  9 +++++----
>  mm/secretmem.c                        |  3 ++-
>  mm/vmscan.c                           |  4 ++--
>  virt/kvm/guest_memfd.c                |  3 ++-
>  8 files changed, 21 insertions(+), 16 deletions(-)
>
> diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesy=
stems/locking.rst
> index f5e3676db954b5bce4c23a0bf723a79d66181fcd..f1a20ad5edbee70c1a3c8d8a9=
bfc0f008a68985b 100644
> --- a/Documentation/filesystems/locking.rst
> +++ b/Documentation/filesystems/locking.rst
> @@ -258,7 +258,7 @@ prototypes::
>         sector_t (*bmap)(struct address_space *, sector_t);
>         void (*invalidate_folio) (struct folio *, size_t start, size_t le=
n);
>         bool (*release_folio)(struct folio *, gfp_t);
> -       void (*free_folio)(struct folio *);
> +       void (*free_folio)(struct address_space *, struct folio *);
>         int (*direct_IO)(struct kiocb *, struct iov_iter *iter);
>         int (*migrate_folio)(struct address_space *, struct folio *dst,
>                         struct folio *src, enum migrate_mode);
> diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
> index 492cffd9d3d845723b5f3d0eea3874b1f1773fe1..54e7069013ef2a63db24491fa=
65059e5ad68057a 100644
> --- a/fs/nfs/dir.c
> +++ b/fs/nfs/dir.c
> @@ -55,7 +55,7 @@ static int nfs_closedir(struct inode *, struct file *);
>  static int nfs_readdir(struct file *, struct dir_context *);
>  static int nfs_fsync_dir(struct file *, loff_t, loff_t, int);
>  static loff_t nfs_llseek_dir(struct file *, loff_t, int);
> -static void nfs_readdir_clear_array(struct folio *);
> +static void nfs_readdir_clear_array(struct address_space *, struct folio=
 *);
>  static int nfs_do_create(struct inode *dir, struct dentry *dentry,
>                          umode_t mode, int open_flags);
>
> @@ -218,7 +218,8 @@ static void nfs_readdir_folio_init_array(struct folio=
 *folio, u64 last_cookie,
>  /*
>   * we are freeing strings created by nfs_add_to_readdir_array()
>   */
> -static void nfs_readdir_clear_array(struct folio *folio)
> +static void nfs_readdir_clear_array(struct address_space *mapping,
> +                                   struct folio *folio)
>  {
>         struct nfs_cache_array *array;
>         unsigned int i;
> @@ -233,7 +234,7 @@ static void nfs_readdir_clear_array(struct folio *fol=
io)
>  static void nfs_readdir_folio_reinit_array(struct folio *folio, u64 last=
_cookie,
>                                            u64 change_attr)
>  {
> -       nfs_readdir_clear_array(folio);
> +       nfs_readdir_clear_array(folio->mapping, folio);
>         nfs_readdir_folio_init_array(folio, last_cookie, change_attr);
>  }
>
> @@ -249,7 +250,7 @@ nfs_readdir_folio_array_alloc(u64 last_cookie, gfp_t =
gfp_flags)
>  static void nfs_readdir_folio_array_free(struct folio *folio)
>  {
>         if (folio) {
> -               nfs_readdir_clear_array(folio);
> +               nfs_readdir_clear_array(folio->mapping, folio);
>                 folio_put(folio);
>         }
>  }
> @@ -391,7 +392,7 @@ static void nfs_readdir_folio_init_and_validate(struc=
t folio *folio, u64 cookie,
>         if (folio_test_uptodate(folio)) {
>                 if (nfs_readdir_folio_validate(folio, cookie, change_attr=
))
>                         return;
> -               nfs_readdir_clear_array(folio);
> +               nfs_readdir_clear_array(folio->mapping, folio);
>         }
>         nfs_readdir_folio_init_array(folio, cookie, change_attr);
>         folio_mark_uptodate(folio);
> diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
> index aae6d2b8767df04714647db5fe1e5ce54c092fce..2d554102ba9ac83acd2b637d4=
568090717e87f94 100644
> --- a/fs/orangefs/inode.c
> +++ b/fs/orangefs/inode.c
> @@ -470,7 +470,8 @@ static bool orangefs_release_folio(struct folio *foli=
o, gfp_t foo)
>         return !folio_test_private(folio);
>  }
>
> -static void orangefs_free_folio(struct folio *folio)
> +static void orangefs_free_folio(struct address_space *mapping,
> +                               struct folio *folio)
>  {
>         kfree(folio_detach_private(folio));
>  }
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index e3c603d01337650d562405500013f5c4cfed8eb6..6e5b5cc99750a685b217cb827=
3c38e7f6bf5ae86 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -417,7 +417,7 @@ struct address_space_operations {
>         sector_t (*bmap)(struct address_space *, sector_t);
>         void (*invalidate_folio) (struct folio *, size_t offset, size_t l=
en);
>         bool (*release_folio)(struct folio *, gfp_t);
> -       void (*free_folio)(struct folio *folio);
> +       void (*free_folio)(struct address_space *, struct folio *folio);
>         ssize_t (*direct_IO)(struct kiocb *, struct iov_iter *iter);
>         /*
>          * migrate the contents of a folio to the specified target. If
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 36d22968be9a1e10da42927dd627d3f22c3a747b..2c8d92dd9d5dd433acbf1b871=
56eb2e68337332d 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -235,12 +235,12 @@ void __filemap_remove_folio(struct folio *folio, vo=
id *shadow)
>
>  void filemap_free_folio(struct address_space *mapping, struct folio *fol=
io)
>  {
> -       void (*free_folio)(struct folio *);
> +       void (*free_folio)(struct address_space *, struct folio *);
>         int refs =3D 1;
>
>         free_folio =3D mapping->a_ops->free_folio;
>         if (free_folio)
> -               free_folio(folio);
> +               free_folio(mapping, folio);
>
>         if (folio_test_large(folio))
>                 refs =3D folio_nr_pages(folio);
> @@ -814,7 +814,8 @@ EXPORT_SYMBOL(file_write_and_wait_range);
>  void replace_page_cache_folio(struct folio *old, struct folio *new)
>  {
>         struct address_space *mapping =3D old->mapping;
> -       void (*free_folio)(struct folio *) =3D mapping->a_ops->free_folio=
;
> +       void (*free_folio)(struct address_space *, struct folio *) =3D
> +               mapping->a_ops->free_folio;
>         pgoff_t offset =3D old->index;
>         XA_STATE(xas, &mapping->i_pages, offset);
>
> @@ -843,7 +844,7 @@ void replace_page_cache_folio(struct folio *old, stru=
ct folio *new)
>                 __lruvec_stat_add_folio(new, NR_SHMEM);
>         xas_unlock_irq(&xas);
>         if (free_folio)
> -               free_folio(old);
> +               free_folio(mapping, old);
>         folio_put(old);
>  }
>  EXPORT_SYMBOL_GPL(replace_page_cache_folio);
> diff --git a/mm/secretmem.c b/mm/secretmem.c
> index 3afb5ad701e14ad87b6e5173b2974f1309399b8e..8643d073b8f3554a18d419353=
fa604864de224c1 100644
> --- a/mm/secretmem.c
> +++ b/mm/secretmem.c
> @@ -152,7 +152,8 @@ static int secretmem_migrate_folio(struct address_spa=
ce *mapping,
>         return -EBUSY;
>  }
>
> -static void secretmem_free_folio(struct folio *folio)
> +static void secretmem_free_folio(struct address_space *mapping,
> +                                struct folio *folio)
>  {
>         set_direct_map_default_noflush(&folio->page);
>         folio_zero_segment(folio, 0, folio_size(folio));
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 749cdc110c745944cd455ae9c5a4c373f631341d..419dc63de05095be298fee724=
891f0665a397a7b 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -765,7 +765,7 @@ static int __remove_mapping(struct address_space *map=
ping, struct folio *folio,
>                 xa_unlock_irq(&mapping->i_pages);
>                 put_swap_folio(folio, swap);
>         } else {
> -               void (*free_folio)(struct folio *);
> +               void (*free_folio)(struct address_space *, struct folio *=
);
>
>                 free_folio =3D mapping->a_ops->free_folio;
>                 /*
> @@ -794,7 +794,7 @@ static int __remove_mapping(struct address_space *map=
ping, struct folio *folio,
>                 spin_unlock(&mapping->host->i_lock);
>
>                 if (free_folio)
> -                       free_folio(folio);
> +                       free_folio(mapping, folio);
>         }
>
>         return 1;
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index 47a9f68f7b247f4cba0c958b4c7cd9458e7c46b4..24dcbad0cb76e353509cf4718=
837a1999f093414 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -358,7 +358,8 @@ static int kvm_gmem_error_folio(struct address_space =
*mapping, struct folio *fol
>  }
>
>  #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
> -static void kvm_gmem_free_folio(struct folio *folio)
> +static void kvm_gmem_free_folio(struct address_space *mapping,
> +                               struct folio *folio)
>  {
>         struct page *page =3D folio_page(folio, 0);
>         kvm_pfn_t pfn =3D page_to_pfn(page);
>
> --
> 2.34.1
>

