Return-Path: <linux-fsdevel+bounces-3435-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE067F48E6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 15:27:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 324F0281607
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 14:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A10E4C3BB;
	Wed, 22 Nov 2023 14:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="ATwLcDMZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-x1143.google.com (mail-yw1-x1143.google.com [IPv6:2607:f8b0:4864:20::1143])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7132DB2
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Nov 2023 06:26:59 -0800 (PST)
Received: by mail-yw1-x1143.google.com with SMTP id 00721157ae682-5cc69df1b9aso7371947b3.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Nov 2023 06:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1700663218; x=1701268018; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wn1N2wP5kYjXhETeZRnS2g/Au9WRP1Q6+PlSYJ/AYbg=;
        b=ATwLcDMZS4+Hkiu1dM6mSAuG1AtSElGcOE30R0ds1ibHG/uD37y6P6iQ9qa0qjwKaH
         WZPGABAdin4XfZVUWUOpuMj/o/ekG3JBZC7J3XuDx2ax3FxXcwgipOgUeu/QX1WJJCS4
         /Nfim+uhkYesiXTOsDL97ifV8L3kQHkjGegf1cK+u2Ac62lwH1AWig2G9QSRz1Pmskxb
         WADCAwhFLe0RmlSVEnCYnyCJVlRoEBVpURePR0ZNBIrdz5nPy8c0jcbSpuUnXDVasg03
         ptGn791ngC12TGrJL8aVg8JBpvZAbyRIDN6CveuwnlhoAcIhLtuV52n7gfAb0omDMyji
         NUng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700663218; x=1701268018;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wn1N2wP5kYjXhETeZRnS2g/Au9WRP1Q6+PlSYJ/AYbg=;
        b=QdILgIF1swao2yVr8ZC3irw7wM+188tsPv2zXhzlNgxBM6WLz+JvZbhacsa0H1tJ2J
         Q+diCPPoVyjRhOJMuHOq4lwvHYgPqh/8iIw8trWK6IluKBapa0noudo8Y+j6uTiEkafW
         wd/HYItEJQB5J2xTQTzg/6RcoAUpBenA2wZx+azSweLMyFqn3k0lw3c0sklRcbcH8CPG
         T8+t7GCE1nv+NhWBEJF/E8HjQKGdpUlscS5cgVR13bNOFwgXX6fyIWrHeG0wcBJvHeDN
         2DiP3QgayrORoao82h8KXmYHrAj8k0TbGhHkuu2l+tqmunOQgl6CoF45XeaKPij6/RMn
         /J0Q==
X-Gm-Message-State: AOJu0Yw9wrg7Yd13v6nTNCtkTAxXfj9QrrujzJ3c6jKeEX6w5eD0/E59
	mkHuECrj7gU7M5/up04S3Y+EtA==
X-Google-Smtp-Source: AGHT+IFRqWK/J22zTckz51NPrJ3lH47wt+L27E4CFVccEC4mEPB7Jly6yk+EZxKlI09QQnRV1c5+yA==
X-Received: by 2002:a0d:ea93:0:b0:5c9:be:57c0 with SMTP id t141-20020a0dea93000000b005c900be57c0mr2329883ywe.24.1700663218539;
        Wed, 22 Nov 2023 06:26:58 -0800 (PST)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id i6-20020a816d06000000b005ccd9a64bcfsm109534ywc.1.2023.11.22.06.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 06:26:58 -0800 (PST)
Date: Wed, 22 Nov 2023 09:26:57 -0500
From: Josef Bacik <josef@toxicpanda.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>
Subject: Re: [PATCH 3/4] mnt_idmapping: decouple from namespaces
Message-ID: <20231122142657.GF1733890@perftesting>
References: <20231122-vfs-mnt_idmap-v1-0-dae4abdde5bd@kernel.org>
 <20231122-vfs-mnt_idmap-v1-3-dae4abdde5bd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122-vfs-mnt_idmap-v1-3-dae4abdde5bd@kernel.org>

On Wed, Nov 22, 2023 at 01:44:39PM +0100, Christian Brauner wrote:
> There's no reason we need to couple mnt idmapping to namespaces in the
> way we currently do. Copy the idmapping when an idmapped mount is
> created and don't take any reference on the namespace at all.
> 
> We also can't easily refcount struct uid_gid_map because it needs to
> stay the size of a cacheline otherwise we risk performance regressions
> (Ignoring for a second that right now struct uid_gid_map isn't actually
>  64 byte but 72 but that's a fix for another patch series.).
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  fs/mnt_idmapping.c      | 106 +++++++++++++++++++++++++++++++++++++++++-------
>  include/linux/uidgid.h  |  13 ++++++
>  kernel/user_namespace.c |   4 +-
>  3 files changed, 106 insertions(+), 17 deletions(-)
> 
> diff --git a/fs/mnt_idmapping.c b/fs/mnt_idmapping.c
> index 35d78cb3c38a..64c5205e2b5e 100644
> --- a/fs/mnt_idmapping.c
> +++ b/fs/mnt_idmapping.c
> @@ -9,8 +9,16 @@
>  
>  #include "internal.h"
>  
> +/*
> + * Outside of this file vfs{g,u}id_t are always created from k{g,u}id_t,
> + * never from raw values. These are just internal helpers.
> + */
> +#define VFSUIDT_INIT_RAW(val) (vfsuid_t){ val }
> +#define VFSGIDT_INIT_RAW(val) (vfsgid_t){ val }
> +
>  struct mnt_idmap {
> -	struct user_namespace *owner;
> +	struct uid_gid_map uid_map;
> +	struct uid_gid_map gid_map;
>  	refcount_t count;
>  };
>  
> @@ -20,7 +28,6 @@ struct mnt_idmap {
>   * mapped to {g,u}id 1, [...], {g,u}id 1000 to {g,u}id 1000, [...].
>   */
>  struct mnt_idmap nop_mnt_idmap = {
> -	.owner	= &init_user_ns,
>  	.count	= REFCOUNT_INIT(1),
>  };
>  EXPORT_SYMBOL_GPL(nop_mnt_idmap);
> @@ -65,7 +72,6 @@ vfsuid_t make_vfsuid(struct mnt_idmap *idmap,
>  		     kuid_t kuid)
>  {
>  	uid_t uid;
> -	struct user_namespace *mnt_userns = idmap->owner;
>  
>  	if (idmap == &nop_mnt_idmap)
>  		return VFSUIDT_INIT(kuid);
> @@ -75,7 +81,7 @@ vfsuid_t make_vfsuid(struct mnt_idmap *idmap,
>  		uid = from_kuid(fs_userns, kuid);
>  	if (uid == (uid_t)-1)
>  		return INVALID_VFSUID;
> -	return VFSUIDT_INIT(make_kuid(mnt_userns, uid));
> +	return VFSUIDT_INIT_RAW(map_id_down(&idmap->uid_map, uid));
>  }
>  EXPORT_SYMBOL_GPL(make_vfsuid);
>  
> @@ -103,7 +109,6 @@ vfsgid_t make_vfsgid(struct mnt_idmap *idmap,
>  		     struct user_namespace *fs_userns, kgid_t kgid)
>  {
>  	gid_t gid;
> -	struct user_namespace *mnt_userns = idmap->owner;
>  
>  	if (idmap == &nop_mnt_idmap)
>  		return VFSGIDT_INIT(kgid);
> @@ -113,7 +118,7 @@ vfsgid_t make_vfsgid(struct mnt_idmap *idmap,
>  		gid = from_kgid(fs_userns, kgid);
>  	if (gid == (gid_t)-1)
>  		return INVALID_VFSGID;
> -	return VFSGIDT_INIT(make_kgid(mnt_userns, gid));
> +	return VFSGIDT_INIT_RAW(map_id_down(&idmap->gid_map, gid));
>  }
>  EXPORT_SYMBOL_GPL(make_vfsgid);
>  
> @@ -132,11 +137,10 @@ kuid_t from_vfsuid(struct mnt_idmap *idmap,
>  		   struct user_namespace *fs_userns, vfsuid_t vfsuid)
>  {
>  	uid_t uid;
> -	struct user_namespace *mnt_userns = idmap->owner;
>  
>  	if (idmap == &nop_mnt_idmap)
>  		return AS_KUIDT(vfsuid);
> -	uid = from_kuid(mnt_userns, AS_KUIDT(vfsuid));
> +	uid = map_id_up(&idmap->uid_map, __vfsuid_val(vfsuid));
>  	if (uid == (uid_t)-1)
>  		return INVALID_UID;
>  	if (initial_idmapping(fs_userns))
> @@ -160,11 +164,10 @@ kgid_t from_vfsgid(struct mnt_idmap *idmap,
>  		   struct user_namespace *fs_userns, vfsgid_t vfsgid)
>  {
>  	gid_t gid;
> -	struct user_namespace *mnt_userns = idmap->owner;
>  
>  	if (idmap == &nop_mnt_idmap)
>  		return AS_KGIDT(vfsgid);
> -	gid = from_kgid(mnt_userns, AS_KGIDT(vfsgid));
> +	gid = map_id_up(&idmap->gid_map, __vfsgid_val(vfsgid));
>  	if (gid == (gid_t)-1)
>  		return INVALID_GID;
>  	if (initial_idmapping(fs_userns))
> @@ -195,16 +198,91 @@ int vfsgid_in_group_p(vfsgid_t vfsgid)
>  #endif
>  EXPORT_SYMBOL_GPL(vfsgid_in_group_p);
>  
> +static int copy_mnt_idmap(struct uid_gid_map *map_from,
> +			  struct uid_gid_map *map_to)
> +{
> +	struct uid_gid_extent *forward, *reverse;
> +	u32 nr_extents = READ_ONCE(map_from->nr_extents);
> +	/* Pairs with smp_wmb() when writing the idmapping. */
> +	smp_rmb();
> +
> +	/*
> +	 * Don't blindly copy @map_to into @map_from if nr_extents is
> +	 * smaller or equal to UID_GID_MAP_MAX_BASE_EXTENTS. Since we
> +	 * read @nr_extents someone could have written an idmapping and
> +	 * then we might end up with inconsistent data. So just don't do
> +	 * anything at all.
> +	 */
> +	if (nr_extents == 0)
> +		return 0;
> +
> +	/*
> +	 * Here we know that nr_extents is greater than zero which means
> +	 * a map has been written. Since idmappings can't be changed
> +	 * once they have been written we know that we can safely copy
> +	 * from @map_to into @map_from.
> +	 */
> +
> +	if (nr_extents <= UID_GID_MAP_MAX_BASE_EXTENTS) {
> +		*map_to = *map_from;
> +		return 0;
> +	}
> +
> +	forward = kmemdup(map_from->forward,
> +			  nr_extents * sizeof(struct uid_gid_extent),
> +			  GFP_KERNEL_ACCOUNT);
> +	if (!forward)
> +		return -ENOMEM;
> +
> +	reverse = kmemdup(map_from->reverse,
> +			  nr_extents * sizeof(struct uid_gid_extent),
> +			  GFP_KERNEL_ACCOUNT);
> +	if (!reverse) {
> +		kfree(forward);
> +		return -ENOMEM;
> +	}
> +
> +	/*
> +	 * The idmapping isn't exposed anywhere so we don't need to care
> +	 * about ordering between extent pointers and @nr_extents
> +	 * initialization.
> +	 */
> +	map_to->forward = forward;
> +	map_to->reverse = reverse;
> +	map_to->nr_extents = nr_extents;
> +	return 0;
> +}
> +
> +static void free_mnt_idmap(struct mnt_idmap *idmap)
> +{
> +	if (idmap->uid_map.nr_extents > UID_GID_MAP_MAX_BASE_EXTENTS) {
> +		kfree(idmap->uid_map.forward);
> +		kfree(idmap->uid_map.reverse);
> +	}
> +	if (idmap->gid_map.nr_extents > UID_GID_MAP_MAX_BASE_EXTENTS) {
> +		kfree(idmap->gid_map.forward);
> +		kfree(idmap->gid_map.reverse);
> +	}
> +	kfree(idmap);
> +}
> +
>  struct mnt_idmap *alloc_mnt_idmap(struct user_namespace *mnt_userns)
>  {
>  	struct mnt_idmap *idmap;
> +	int ret;
>  
>  	idmap = kzalloc(sizeof(struct mnt_idmap), GFP_KERNEL_ACCOUNT);
>  	if (!idmap)
>  		return ERR_PTR(-ENOMEM);
>  
> -	idmap->owner = get_user_ns(mnt_userns);
>  	refcount_set(&idmap->count, 1);
> +	ret = copy_mnt_idmap(&mnt_userns->uid_map, &idmap->uid_map);
> +	if (!ret)
> +		ret = copy_mnt_idmap(&mnt_userns->gid_map, &idmap->gid_map);
> +	if (ret) {
> +		free_mnt_idmap(idmap);
> +		idmap = ERR_PTR(ret);
> +	}
>  	return idmap;
>  }
>  
> @@ -234,9 +312,7 @@ EXPORT_SYMBOL_GPL(mnt_idmap_get);
>   */
>  void mnt_idmap_put(struct mnt_idmap *idmap)
>  {
> -	if (idmap != &nop_mnt_idmap && refcount_dec_and_test(&idmap->count)) {
> -		put_user_ns(idmap->owner);
> -		kfree(idmap);
> -	}
> +	if (idmap != &nop_mnt_idmap && refcount_dec_and_test(&idmap->count))
> +		free_mnt_idmap(idmap);
>  }
>  EXPORT_SYMBOL_GPL(mnt_idmap_put);
> diff --git a/include/linux/uidgid.h b/include/linux/uidgid.h
> index b0542cd11aeb..7806e93b907d 100644
> --- a/include/linux/uidgid.h
> +++ b/include/linux/uidgid.h
> @@ -17,6 +17,7 @@
>  
>  struct user_namespace;
>  extern struct user_namespace init_user_ns;
> +struct uid_gid_map;
>  
>  typedef struct {
>  	uid_t val;
> @@ -138,6 +139,9 @@ static inline bool kgid_has_mapping(struct user_namespace *ns, kgid_t gid)
>  	return from_kgid(ns, gid) != (gid_t) -1;
>  }
>  
> +u32 map_id_down(struct uid_gid_map *map, u32 id);
> +u32 map_id_up(struct uid_gid_map *map, u32 id);
> +
>  #else
>  
>  static inline kuid_t make_kuid(struct user_namespace *from, uid_t uid)
> @@ -186,6 +190,15 @@ static inline bool kgid_has_mapping(struct user_namespace *ns, kgid_t gid)
>  	return gid_valid(gid);
>  }
>  
> +static inline u32 map_id_down(struct uid_gid_map *map, u32 id)
> +{
> +	return id;
> +}
> +
> +static inline u32 map_id_up(struct uid_gid_map *map, u32 id);

You accidentally put a ; here, and then fix it up in the next patch, it needs to
be fixed here.  Thanks,

Josef

