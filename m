Return-Path: <linux-fsdevel+bounces-3268-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 876557F1FCA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 22:54:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B89C71C216BD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 21:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1573984B;
	Mon, 20 Nov 2023 21:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="yZJtJ41Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87867CA
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Nov 2023 13:54:29 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-5ca164bc0bbso17742897b3.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Nov 2023 13:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1700517268; x=1701122068; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qgfLlb+6z+gQrU8H/byznudZx7zpZZmlYzoXRoWwu40=;
        b=yZJtJ41Zzd0N0rWH+wLMtlNkimW9Jkzr7H2f1HOVKftAXzuDtOEdTjm5F7YlIVNMwf
         lPlIGcKfhTwKc/5j53Kcv4P2sfKTsC3IorRPy4c8jx2y8yXGVZFxARLS9adexlBUzvnF
         geRrczvuBb7dp3UNnlaCTPX4lnacWE5i0C6ws2sybNAgcsDylLXFt1XkBhwpw/PVprot
         DVoMQSL87pF96xjuzdzfNCV7YS3ICUNe/u3XpplcJB5K/ROrS0FmzZasVVTQcMl6AIz0
         SXiytGO8RNm5uQZVTrdY2s224Hc01K9fzDmo1g20VeqTXxqMmctwmb3MwgSZNBZt6r0u
         BWeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700517268; x=1701122068;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qgfLlb+6z+gQrU8H/byznudZx7zpZZmlYzoXRoWwu40=;
        b=aZVooZ8DarglsFxu9406PANDK3cf48sN3BwyJUwSp31p9e2nn7PV9BCCopPW19uCmT
         aFwjYB8aPn610L3t3VH0OtNxW9T5iNSGqIwc49vNbtOfsy3VxXv5gb3DNtn+p7yZlg4z
         rgMWGE41nGK9icb96pYbUgGGhDST5G/z5qbl83gGCy9f8MbcQ+sIxmHDT1hPLooS3aDP
         qu2wIL+MwAHhqM5U9/MtG8md05/RUxsiNtUc7U7p6usoRIUhmBa7JWFO+sNsX/PWrgsu
         wD30OD/QLMfkJrQQjNpdDJgLij6Q8VYLVd2mXLlXj/aYonMbh+EtbJ3Vt3PW8XEJOtSm
         WsFA==
X-Gm-Message-State: AOJu0Yxg/AuGj1g1HORlnAaYzlYx3Mu/lw6jzlu+SdUlfC2KWx6J+8zf
	/11UitKfVvZsaitQYaqKicj/ug==
X-Google-Smtp-Source: AGHT+IHu4up0d1PjwJ5sZfMcylq6WDY/XVA/Ogo++vf5V4EyntMkeGPl/n4NKNxfd3taxJ/hpw6gBg==
X-Received: by 2002:a25:1084:0:b0:d9a:d16f:dddf with SMTP id 126-20020a251084000000b00d9ad16fdddfmr6885372ybq.24.1700517268676;
        Mon, 20 Nov 2023 13:54:28 -0800 (PST)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id q6-20020a2599c6000000b00d995a8b956csm245519ybo.51.2023.11.20.13.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 13:54:27 -0800 (PST)
Date: Mon, 20 Nov 2023 16:54:26 -0500
From: Josef Bacik <josef@toxicpanda.com>
To: Anand Jain <anand.jain@oracle.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org, brauner@kernel.org
Subject: Re: [PATCH v2 04/18] btrfs: move space cache settings into open_ctree
Message-ID: <20231120215426.GA1611727@perftesting>
References: <cover.1699470345.git.josef@toxicpanda.com>
 <c1f4384e79a163e4aef516472a8d6574dc54545d.1699470345.git.josef@toxicpanda.com>
 <1f8c8d3f-8f7a-407b-8020-e961fe2f6024@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f8c8d3f-8f7a-407b-8020-e961fe2f6024@oracle.com>

On Wed, Nov 15, 2023 at 08:06:02AM +0800, Anand Jain wrote:
> 
> > @@ -3287,6 +3287,12 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
> >   	fs_info->csums_per_leaf = BTRFS_MAX_ITEM_SIZE(fs_info) / fs_info->csum_size;
> >   	fs_info->stripesize = stripesize;
> > +	/*
> > +	 * Handle the space caching options appropriately now that we have the
> > +	 * super loaded and validated.
> > +	 */
> > +	btrfs_set_free_space_cache_settings(fs_info);
> > +
> >   	ret = btrfs_parse_options(fs_info, options, sb->s_flags);
> >   	if (ret)
> >   		goto fail_alloc;
> > @@ -3298,17 +3304,6 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
> >   	if (sectorsize < PAGE_SIZE) {
> >   		struct btrfs_subpage_info *subpage_info;
> > -		/*
> > -		 * V1 space cache has some hardcoded PAGE_SIZE usage, and is
> > -		 * going to be deprecated.
> > -		 *
> > -		 * Force to use v2 cache for subpage case.
> > -		 */
> > -		btrfs_clear_opt(fs_info->mount_opt, SPACE_CACHE);
> > -		btrfs_set_and_info(fs_info, FREE_SPACE_TREE,
> > -			"forcing free space tree for sector size %u with page size %lu",
> > -			sectorsize, PAGE_SIZE);
> > -
> >   		btrfs_warn(fs_info,
> >   		"read-write for sector size %u with page size %lu is experimental",
> >   			   sectorsize, PAGE_SIZE);
> > diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> > index 639601d346d0..aef7e67538a3 100644
> > --- a/fs/btrfs/super.c
> > +++ b/fs/btrfs/super.c
> > @@ -266,6 +266,31 @@ static bool check_options(struct btrfs_fs_info *info, unsigned long flags)
> >   	return true;
> >   }
> > +void btrfs_set_free_space_cache_settings(struct btrfs_fs_info *fs_info)
> > +{
> > +	if (btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE))
> > +		btrfs_set_opt(fs_info->mount_opt, FREE_SPACE_TREE);
> > +	else if (btrfs_free_space_cache_v1_active(fs_info)) {
> > +		if (btrfs_is_zoned(fs_info)) {
> > +			btrfs_info(fs_info,
> > +			"zoned: clearing existing space cache");
> > +			btrfs_set_super_cache_generation(fs_info->super_copy, 0);
> > +		} else {
> > +			btrfs_set_opt(fs_info->mount_opt, SPACE_CACHE);
> > +		}
> > +	}
> > +
> > +	if (fs_info->sectorsize < PAGE_SIZE) {
> > +		btrfs_clear_opt(fs_info->mount_opt, SPACE_CACHE);
> > +		if (!btrfs_test_opt(fs_info, FREE_SPACE_TREE)) {
> > +			btrfs_info(fs_info,
> > +				   "forcing free space tree for sector size %u with page size %lu",
> > +				   fs_info->sectorsize, PAGE_SIZE);
> > +			btrfs_set_opt(fs_info->mount_opt, FREE_SPACE_TREE);
> > +		}
> > +	}
> > +}
> > +
> >   static int parse_rescue_options(struct btrfs_fs_info *info, const char *options)
> >   {
> >   	char *opts;
> > @@ -345,18 +370,6 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
> >   	bool saved_compress_force;
> >   	int no_compress = 0;
> > -	if (btrfs_fs_compat_ro(info, FREE_SPACE_TREE))
> > -		btrfs_set_opt(info->mount_opt, FREE_SPACE_TREE);
> > -	else if (btrfs_free_space_cache_v1_active(info)) {
> > -		if (btrfs_is_zoned(info)) {
> > -			btrfs_info(info,
> > -			"zoned: clearing existing space cache");
> > -			btrfs_set_super_cache_generation(info->super_copy, 0);
> > -		} else {
> > -			btrfs_set_opt(info->mount_opt, SPACE_CACHE);
> > -		}
> > -	}
> > -
> >   	/*
> >   	 * Even the options are empty, we still need to do extra check
> >   	 * against new flags
> 
> 
> btrfs_remount() calls btrfs_parse_options(), which previously handled
> space cache/tree flags set/reset. However, with the move of this
> functionality to a separate function, btrfs_set_free_space_cache_settings(),
> the btrfs_remount() thread no longer has the space cache/tree flags
> set/reset. The changelog provides no explanation for this change.
> Could this be a bug?
> 

All this bit does is set the mount_opt's based on the current state of the file
system, so if we're mounting with no "-o space_cache=*" option, we'll derive it
from wether FREE_SPACE_TREE is set or btrfs_free_space_cache_v1_active() returns
true.

So in your case if we mounted -o nospace_cache then we'll have cleared the
v1_active bit and this won't do anything and we'll get -o nospace_cache again.
The same goes for the free space tree, we're only allowed to change the disk
option for this in certain cases.  And in those cases it'll clear the compat
flag.

But this is definitely subtle, I'll expand the changelog.  Thanks,

Josef

