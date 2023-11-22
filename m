Return-Path: <linux-fsdevel+bounces-3450-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB3C77F4C06
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 17:12:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21E12B20F78
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 16:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 475884D10D;
	Wed, 22 Nov 2023 16:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="Vm9/0mow"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD81A2
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Nov 2023 08:12:13 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-5cb5248a21fso8882427b3.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Nov 2023 08:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1700669533; x=1701274333; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=36p1umQEgwFzXjxpCg2qYkrYWJtzRfqSTZF2V0uZ9Qs=;
        b=Vm9/0mow5EfEczgNR1mwENb4Gl6MotWJtGnBhtFqtEzW+/W+GMleQgWuY2fxa/a/WU
         iGbJFCIfxJ0mlee0D9wZ0+C6rr7+xdwJvCljTPK8I7dMasV+SqCuOxxzrALPV66KddXP
         0JljZ6gGKjYNxlZDgEJ3wY9teaf8Smqmn/9ZzeLwBDfM9zqzQIu0dYlPU7HskNQa4t9K
         YdgnqiW5xxQum1h+QU7F+bSwpOGkEKydC/udcHXgfNZ+P1iGFXNJtH7WIn743vsKTvrr
         Woi8gSCmcz8KjjZ6DcCuvs/II1qcEwwtrzqHLKiXqVWPHQkfeiqt+oeDDu3IYBhjYRDl
         cmDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700669533; x=1701274333;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=36p1umQEgwFzXjxpCg2qYkrYWJtzRfqSTZF2V0uZ9Qs=;
        b=F2blEVs+JTOQVcIOz+1LYj04JTDnt5HcfjzXkhaVsQvnTeXq7olrsnIYaKmGefxQnL
         YqOxv1g16m45FHxlhb5QZRrbiS2RJCpFFgCjemZw+tOR+gsWBHLEIrSxIx0pGqa/JZRw
         +dkLyso9Tg9lHYpnbO4381Ox6LAwcKY26lfRxKWCUSbyuAxr+kyAxXx7A32Zmpa9hk5Y
         J9oaFhzP8o9FHD8nPTE4PX+FwAXRodFcVObUvyHau9sVkE8raHVqbILdZue7/yb0d9PZ
         ChMRAgEcAFChDnS0InJLONYYTaCJTHZ9VPtOMYEiaL+53YQ0/nZYUcWihStZQj72Su45
         A7zA==
X-Gm-Message-State: AOJu0YzNQV1TlOmVL5tnZI2G/wyxq5TtXYjd7yKBumDihlS/uwG7/01h
	/T3k4h7Qdn+rWR+FZIHmR8yJhQ==
X-Google-Smtp-Source: AGHT+IER5xR0hHjv+GvEmsiUE/FBwCwkvgNOaZpOqQBbOsucIGjtUYEMFvW1I1pPad8aIiDl/ZOi5w==
X-Received: by 2002:a81:9a03:0:b0:5cc:5d7d:60e5 with SMTP id r3-20020a819a03000000b005cc5d7d60e5mr1772631ywg.23.1700669532896;
        Wed, 22 Nov 2023 08:12:12 -0800 (PST)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id o81-20020a817354000000b005b37c6e01f9sm3777654ywc.90.2023.11.22.08.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 08:12:12 -0800 (PST)
Date: Wed, 22 Nov 2023 11:12:11 -0500
From: Josef Bacik <josef@toxicpanda.com>
To: David Sterba <dsterba@suse.cz>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org, brauner@kernel.org
Subject: Re: [PATCH v2 09/18] btrfs: add parse_param callback for the new
 mount api
Message-ID: <20231122161211.GA1740325@perftesting>
References: <cover.1699470345.git.josef@toxicpanda.com>
 <0a00937137f9b737e97284af572eab72fa02e594.1699470345.git.josef@toxicpanda.com>
 <20231114181338.GF11264@twin.jikos.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231114181338.GF11264@twin.jikos.cz>

On Tue, Nov 14, 2023 at 07:13:38PM +0100, David Sterba wrote:
> On Wed, Nov 08, 2023 at 02:08:44PM -0500, Josef Bacik wrote:
> > The parse_param callback handles one parameter at a time, take our
> > existing mount option parsing loop and adjust it to handle one parameter
> > at a time, and tie it into the fs_context_operations.
> > 
> > Create a btrfs_fs_context object that will store the various mount
> > properties, we'll house this in fc->fs_private.  This is necessary to
> > separate because remounting will use ->reconfigure, and we'll get a new
> > copy of the parsed parameters, so we can no longer directly mess with
> > the fs_info in this stage.
> > 
> > In the future we'll add this to the btrfs_fs_info and update the users
> > to use the new context object instead.
> > 
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > ---
> >  fs/btrfs/super.c | 390 +++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 390 insertions(+)
> > 
> > diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> > index 0e9cb9ed6508..2f7ee78edd11 100644
> > --- a/fs/btrfs/super.c
> > +++ b/fs/btrfs/super.c
> > @@ -84,6 +84,19 @@ static void btrfs_put_super(struct super_block *sb)
> >  	close_ctree(btrfs_sb(sb));
> >  }
> >  
> > +/* Store the mount options related information. */
> > +struct btrfs_fs_context {
> > +	char *subvol_name;
> > +	u64 subvol_objectid;
> > +	u64 max_inline;
> > +	u32 commit_interval;
> > +	u32 metadata_ratio;
> > +	u32 thread_pool_size;
> > +	unsigned long mount_opt;
> > +	unsigned long compress_type:4;
> > +	unsigned int compress_level;
> > +};
> > +
> >  enum {
> >  	Opt_acl, Opt_noacl,
> >  	Opt_clear_cache,
> > @@ -348,6 +361,379 @@ static const struct fs_parameter_spec btrfs_fs_parameters[] __maybe_unused = {
> >  	{}
> >  };
> >  
> > +static int btrfs_parse_param(struct fs_context *fc,
> > +			     struct fs_parameter *param)
> > +{
> > +	struct btrfs_fs_context *ctx = fc->fs_private;
> > +	struct fs_parse_result result;
> > +	int opt;
> > +
> > +	opt = fs_parse(fc, btrfs_fs_parameters, param, &result);
> > +	if (opt < 0)
> > +		return opt;
> > +
> > +	switch (opt) {
> > +	case Opt_degraded:
> > +		btrfs_set_opt(ctx->mount_opt, DEGRADED);
> > +		break;
> > +	case Opt_subvol_empty:
> > +		/*
> > +		 * This exists because we used to allow it on accident, so we're
> > +		 * keeping it to maintain ABI.  See
> > +		 * 37becec95ac31b209eb1c8e096f1093a7db00f32.
> 
> Please use the full patch reference 37becec95ac3 ("Btrfs: allow empty
> subvol= again"), the subject itself explains why it's here.
> 
> > +		 */
> > +		break;
> > +	case Opt_subvol:
> > +		kfree(ctx->subvol_name);
> > +		ctx->subvol_name = kstrdup(param->string, GFP_KERNEL);
> > +		if (!ctx->subvol_name)
> > +			return -ENOMEM;
> > +		break;
> > +	case Opt_subvolid:
> > +		ctx->subvol_objectid = result.uint_64;
> > +
> > +		/* subvoldi=0 means give me the original fs_tree. */
> 
>                    subvolid=0
> 
> > +		if (!ctx->subvol_objectid)
> > +			ctx->subvol_objectid = BTRFS_FS_TREE_OBJECTID;
> > +		break;
> > +	case Opt_device: {
> > +		struct btrfs_device *device;
> > +		blk_mode_t mode = sb_open_mode(fc->sb_flags);
> > +
> > +		mutex_lock(&uuid_mutex);
> > +		device = btrfs_scan_one_device(param->string, mode, false);
> > +		mutex_unlock(&uuid_mutex);
> 
> So this changes how the device option and scan works. At this point the
> option is in the simple lock/unlock sequence, while currently it's
> scanning all devices under in one lock and then also opens all the
> devices. This prevents any other scan to interrupt that so it's either
> scanned right before (and filling the list) or after (which is a no-op).
> 
> Now it's open to the races, I haven't evaluated if this could be a
> problem or not.
> 

Udev has been scanning our devices ahead of time for years, this is exactly how
it exists currently.  I don't think anybody is actually using -o
device=<whatever>, but if they are this gives them the same behavior that most
people get with the udev rule and mount /dev/oneofthedisks /foo.

If we're really worried about it however I could allocate the strings and attach
them to the context here, and then at mount time scan them all to give us the
same behavior as we had before.

> > +		if (IS_ERR(device))
> > +			return PTR_ERR(device);
> > +		break;
> > +	}
> > +	case Opt_datasum:
> > +		if (result.negated) {
> > +			btrfs_set_opt(ctx->mount_opt, NODATASUM);
> > +		} else {
> > +			btrfs_clear_opt(ctx->mount_opt, NODATACOW);
> > +			btrfs_clear_opt(ctx->mount_opt, NODATASUM);
> > +		}
> > +		break;
> > +	case Opt_datacow:
> > +		if (result.negated) {
> > +			btrfs_clear_opt(ctx->mount_opt, COMPRESS);
> > +			btrfs_clear_opt(ctx->mount_opt, FORCE_COMPRESS);
> > +			btrfs_set_opt(ctx->mount_opt, NODATACOW);
> > +			btrfs_set_opt(ctx->mount_opt, NODATASUM);
> > +		} else {
> > +			btrfs_clear_opt(ctx->mount_opt, NODATACOW);
> > +		}
> > +		break;
> > +	case Opt_compress_force:
> > +	case Opt_compress_force_type:
> > +		btrfs_set_opt(ctx->mount_opt, FORCE_COMPRESS);
> > +		fallthrough;
> > +	case Opt_compress:
> > +	case Opt_compress_type:
> > +		if (opt == Opt_compress ||
> > +		    opt == Opt_compress_force ||
> > +		    strncmp(param->string, "zlib", 4) == 0) {
> > +			ctx->compress_type = BTRFS_COMPRESS_ZLIB;
> > +			ctx->compress_level = BTRFS_ZLIB_DEFAULT_LEVEL;
> > +			/*
> > +			 * args[0] contains uninitialized data since
> > +			 * for these tokens we don't expect any
> > +			 * parameter.
> > +			 */
> 
> Please reformat/realign comments that you copy or move
> 
> > +			if (opt != Opt_compress &&
> > +			    opt != Opt_compress_force)
> > +				ctx->compress_level =
> > +					btrfs_compress_str2level(
> > +								 BTRFS_COMPRESS_ZLIB,
> > +								 param->string + 4);
> 
> This does not need to do newline after "("
> 
> > +			btrfs_set_opt(ctx->mount_opt, COMPRESS);
> > +			btrfs_clear_opt(ctx->mount_opt, NODATACOW);
> > +			btrfs_clear_opt(ctx->mount_opt, NODATASUM);
> > +		} else if (strncmp(param->string, "lzo", 3) == 0) {
> > +			ctx->compress_type = BTRFS_COMPRESS_LZO;
> > +			ctx->compress_level = 0;
> > +			btrfs_set_opt(ctx->mount_opt, COMPRESS);
> > +			btrfs_clear_opt(ctx->mount_opt, NODATACOW);
> > +			btrfs_clear_opt(ctx->mount_opt, NODATASUM);
> > +		} else if (strncmp(param->string, "zstd", 4) == 0) {
> > +			ctx->compress_type = BTRFS_COMPRESS_ZSTD;
> > +			ctx->compress_level =
> > +				btrfs_compress_str2level(
> > +							 BTRFS_COMPRESS_ZSTD,
> > +							 param->string + 4);
> 
> Same
> 
> > +			btrfs_set_opt(ctx->mount_opt, COMPRESS);
> > +			btrfs_clear_opt(ctx->mount_opt, NODATACOW);
> > +			btrfs_clear_opt(ctx->mount_opt, NODATASUM);
> > +		} else if (strncmp(param->string, "no", 2) == 0) {
> > +			ctx->compress_level = 0;
> > +			ctx->compress_type = 0;
> > +			btrfs_clear_opt(ctx->mount_opt, COMPRESS);
> > +			btrfs_clear_opt(ctx->mount_opt, FORCE_COMPRESS);
> > +		} else {
> > +			btrfs_err(NULL, "unrecognized compression value %s",
> > +				  param->string);
> > +			return -EINVAL;
> > +		}
> > +		break;
> > +	case Opt_ssd:
> > +		if (result.negated) {
> > +			btrfs_set_opt(ctx->mount_opt, NOSSD);
> > +			btrfs_clear_opt(ctx->mount_opt, SSD);
> > +			btrfs_clear_opt(ctx->mount_opt, SSD_SPREAD);
> > +		} else {
> > +			btrfs_set_opt(ctx->mount_opt, SSD);
> > +			btrfs_clear_opt(ctx->mount_opt, NOSSD);
> > +		}
> > +		break;
> > +	case Opt_ssd_spread:
> > +		if (result.negated) {
> > +			btrfs_clear_opt(ctx->mount_opt, SSD_SPREAD);
> > +		} else {
> > +			btrfs_set_opt(ctx->mount_opt, SSD);
> > +			btrfs_set_opt(ctx->mount_opt, SSD_SPREAD);
> > +			btrfs_clear_opt(ctx->mount_opt, NOSSD);
> > +		}
> > +		break;
> > +	case Opt_barrier:
> > +		if (result.negated)
> > +			btrfs_set_opt(ctx->mount_opt, NOBARRIER);
> > +		else
> > +			btrfs_clear_opt(ctx->mount_opt, NOBARRIER);
> > +		break;
> > +	case Opt_thread_pool:
> > +		if (result.uint_32 == 0) {
> > +			btrfs_err(NULL, "invalid value 0 for thread_pool");
> > +			return -EINVAL;
> > +		}
> > +		ctx->thread_pool_size = result.uint_32;
> 
> It's not in current code but we should eventually clamp the value,
> num_online_cpus or similar.
> 
> > +		break;
> > +	case Opt_max_inline:
> > +		ctx->max_inline = memparse(param->string, NULL);
> 
> This does not match, the max_inline value is adjusted as
> 
>        if (info->max_inline) {
>                info->max_inline = min_t(u64,
>                        info->max_inline,
>                        info->sectorsize);
>        }
> 
> and it should be validated at the time we parse it, like other options.
> 

We can't do that with the current scheme, tho I did miss clam'ing it.  I've
added the clamping part to the patch where we flip over to using the new mount
API.

> > +		break;
> > +	case Opt_acl:
> > +		if (result.negated) {
> > +			fc->sb_flags &= ~SB_POSIXACL;
> > +		} else {
> > +#ifdef CONFIG_BTRFS_FS_POSIX_ACL
> > +			fc->sb_flags |= SB_POSIXACL;
> > +#else
> > +			btrfs_err(NULL, "support for ACL not compiled in!");
> > +			ret = -EINVAL;
> > +			goto out;
> > +#endif
> > +		}
> > +		/*
> > +		 * VFS limits the ability to toggle ACL on and off via remount,
> > +		 * despite every file system allowing this.  This seems to be an
> > +		 * oversight since we all do, but it'll fail if we're
> > +		 * remounting.  So don't set the mask here, we'll check it in
> > +		 * btrfs_reconfigure and do the toggling ourselves.
> > +		 */
> > +		if (fc->purpose != FS_CONTEXT_FOR_RECONFIGURE)
> > +			fc->sb_flags_mask |= SB_POSIXACL;
> > +		break;
> > +	case Opt_treelog:
> > +		if (result.negated)
> > +			btrfs_set_opt(ctx->mount_opt, NOTREELOG);
> > +		else
> > +			btrfs_clear_opt(ctx->mount_opt, NOTREELOG);
> > +		break;
> > +	case Opt_recovery:
> > +		/*
> > +		 * -o recovery used to be an alias for usebackuproot, and then
> > +		 * norecovery was an alias for nologreplay, hence the different
> > +		 * behaviors for negated and not.
> > +		 */
> > +		if (result.negated) {
> > +			btrfs_warn(NULL,
> > +				   "'norecovery' is deprecated, use 'rescue=nologreplay' instead");
> > +			btrfs_set_opt(ctx->mount_opt, NOLOGREPLAY);
> > +		} else {
> > +			btrfs_warn(NULL,
> > +				   "'recovery' is deprecated, use 'rescue=usebackuproot' instead");
> > +			btrfs_set_opt(ctx->mount_opt, USEBACKUPROOT);
> > +		}
> > +		break;
> > +	case Opt_nologreplay:
> > +		btrfs_warn(NULL,
> > +			   "'nologreplay' is deprecated, use 'rescue=nologreplay' instead");
> > +		btrfs_set_opt(ctx->mount_opt, NOLOGREPLAY);
> > +		break;
> > +	case Opt_flushoncommit:
> > +		if (result.negated)
> > +			btrfs_clear_opt(ctx->mount_opt, FLUSHONCOMMIT);
> > +		else
> > +			btrfs_set_opt(ctx->mount_opt, FLUSHONCOMMIT);
> > +		break;
> > +	case Opt_ratio:
> > +		ctx->metadata_ratio = result.uint_32;
> > +		break;
> > +	case Opt_discard:
> > +		if (result.negated) {
> > +			btrfs_clear_opt(ctx->mount_opt, DISCARD_SYNC);
> > +			btrfs_clear_opt(ctx->mount_opt, DISCARD_ASYNC);
> > +			btrfs_set_opt(ctx->mount_opt, NODISCARD);
> > +		} else {
> > +			btrfs_set_opt(ctx->mount_opt, DISCARD_SYNC);
> > +			btrfs_clear_opt(ctx->mount_opt, DISCARD_ASYNC);
> > +		}
> > +		break;
> > +	case Opt_discard_mode:
> > +		switch (result.uint_32) {
> > +		case Opt_discard_sync:
> > +			btrfs_clear_opt(ctx->mount_opt, DISCARD_ASYNC);
> > +			btrfs_set_opt(ctx->mount_opt, DISCARD_SYNC);
> > +			break;
> > +		case Opt_discard_async:
> > +			btrfs_clear_opt(ctx->mount_opt, DISCARD_SYNC);
> > +			btrfs_set_opt(ctx->mount_opt, DISCARD_ASYNC);
> > +			break;
> > +		default:
> > +			btrfs_err(NULL, "unrecognized discard mode value %s",
> > +				  param->key);
> > +			return -EINVAL;
> > +		}
> > +		btrfs_clear_opt(ctx->mount_opt, NODISCARD);
> > +		break;
> > +	case Opt_space_cache:
> > +		if (result.negated) {
> > +			btrfs_set_opt(ctx->mount_opt, NOSPACECACHE);
> > +			btrfs_clear_opt(ctx->mount_opt, SPACE_CACHE);
> > +			btrfs_clear_opt(ctx->mount_opt, FREE_SPACE_TREE);
> > +		} else {
> > +			btrfs_clear_opt(ctx->mount_opt, FREE_SPACE_TREE);
> > +			btrfs_set_opt(ctx->mount_opt, SPACE_CACHE);
> > +		}
> > +		break;
> > +	case Opt_space_cache_version:
> > +		switch (result.uint_32) {
> > +		case Opt_space_cache_v1:
> > +			btrfs_set_opt(ctx->mount_opt, SPACE_CACHE);
> > +			btrfs_clear_opt(ctx->mount_opt, FREE_SPACE_TREE);
> > +			break;
> > +		case Opt_space_cache_v2:
> > +			btrfs_clear_opt(ctx->mount_opt, SPACE_CACHE);
> > +			btrfs_set_opt(ctx->mount_opt, FREE_SPACE_TREE);
> > +			break;
> > +		default:
> > +			btrfs_err(NULL, "unrecognized space_cache value %s",
> > +				  param->key);
> > +			return -EINVAL;
> > +		}
> > +		break;
> > +	case Opt_rescan_uuid_tree:
> > +		btrfs_set_opt(ctx->mount_opt, RESCAN_UUID_TREE);
> > +		break;
> > +	case Opt_inode_cache:
> > +		btrfs_warn(NULL,
> > +			   "the 'inode_cache' option is deprecated and has no effect since 5.11");
> > +		break;
> > +	case Opt_clear_cache:
> > +		btrfs_set_opt(ctx->mount_opt, CLEAR_CACHE);
> > +		break;
> > +	case Opt_user_subvol_rm_allowed:
> > +		btrfs_set_opt(ctx->mount_opt, USER_SUBVOL_RM_ALLOWED);
> > +		break;
> > +	case Opt_enospc_debug:
> > +		if (result.negated)
> > +			btrfs_clear_opt(ctx->mount_opt, ENOSPC_DEBUG);
> > +		else
> > +			btrfs_set_opt(ctx->mount_opt, ENOSPC_DEBUG);
> > +		break;
> > +	case Opt_defrag:
> > +		if (result.negated)
> > +			btrfs_clear_opt(ctx->mount_opt, AUTO_DEFRAG);
> > +		else
> > +			btrfs_set_opt(ctx->mount_opt, AUTO_DEFRAG);
> > +		break;
> > +	case Opt_usebackuproot:
> > +		btrfs_warn(NULL,
> > +			   "'usebackuproot' is deprecated, use 'rescue=usebackuproot' instead");
> > +		btrfs_set_opt(ctx->mount_opt, USEBACKUPROOT);
> > +		break;
> > +	case Opt_skip_balance:
> > +		btrfs_set_opt(ctx->mount_opt, SKIP_BALANCE);
> > +		break;
> > +	case Opt_fatal_errors:
> > +		switch (result.uint_32) {
> > +		case Opt_fatal_errors_panic:
> > +			btrfs_set_opt(ctx->mount_opt,
> > +				      PANIC_ON_FATAL_ERROR);
> 
> Lines can be joined
> 
> > +			break;
> > +		case Opt_fatal_errors_bug:
> > +			btrfs_clear_opt(ctx->mount_opt,
> > +					PANIC_ON_FATAL_ERROR);
> 
> Same
> 
> > +			break;
> > +		default:
> > +			btrfs_err(NULL, "unrecognized fatal_errors value %s",
> > +				  param->key);
> > +			return -EINVAL;
> > +		}
> > +		break;
> > +	case Opt_commit_interval:
> > +		ctx->commit_interval = result.uint_32;
> > +		if (!ctx->commit_interval)
> > +			ctx->commit_interval = BTRFS_DEFAULT_COMMIT_INTERVAL;
> 
> And the value of commit_interval is also adjusted in current code, this
> should be done here as well.
>

It isn't adjusted, we just yell if it's above 300.  If you do -o
commit_interval=0 it wants the default interval, which is what I've handled
here.  Thanks,

Josef

