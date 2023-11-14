Return-Path: <linux-fsdevel+bounces-2854-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B29C77EB668
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Nov 2023 19:30:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5EA61C20AE0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Nov 2023 18:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE9926AD8;
	Tue, 14 Nov 2023 18:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qXJfP5fa";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zk4WZJHJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A077726AC6;
	Tue, 14 Nov 2023 18:30:30 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A878B129;
	Tue, 14 Nov 2023 10:30:28 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E54DC22545;
	Tue, 14 Nov 2023 18:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1699986626;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q8pUm3nvakATJ1oIT3xnJbBHmvn4hznsYZTE0Am2dkc=;
	b=qXJfP5faKKR9adN0n14oxXY3VYH/AB6VgZk1uROOxjNH/hjRf4WiI93bIZQ2Kb5DsLHdRz
	mprtgSVM9HV57mec0W/B0I/d2E3VKVrf0NZosIn4viyVCAlIB5/9Byq9ue2OKnPuN/VmN1
	aEITZ+DKGbdNXBSNP0zC/e3X3z0fm7s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1699986626;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q8pUm3nvakATJ1oIT3xnJbBHmvn4hznsYZTE0Am2dkc=;
	b=zk4WZJHJOTyR4GptCdW8hCAzAXpQ30PYKfIhHCyFAAyqXQrm6QMrF56pG73htACYAUZz/j
	LqXIqkW0Du4D1+CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AC69713460;
	Tue, 14 Nov 2023 18:30:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id HpRBKcK8U2WALAAAMHmgww
	(envelope-from <dsterba@suse.cz>); Tue, 14 Nov 2023 18:30:26 +0000
Date: Tue, 14 Nov 2023 19:23:21 +0100
From: David Sterba <dsterba@suse.cz>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org, brauner@kernel.org
Subject: Re: [PATCH v2 11/18] btrfs: add reconfigure callback for fs_context
Message-ID: <20231114182321.GG11264@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1699470345.git.josef@toxicpanda.com>
 <0c2885bd48e23b46d4e60e6874c1e4f95e0e1ce8.1699470345.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c2885bd48e23b46d4e60e6874c1e4f95e0e1ce8.1699470345.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -6.80
X-Spamd-Result: default: False [-6.80 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-3.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCPT_COUNT_FIVE(0.00)[5];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-1.00)[-1.000];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]

On Wed, Nov 08, 2023 at 02:08:46PM -0500, Josef Bacik wrote:
> This is what is used to remount the file system with the new mount API.
> Because the mount options are parsed separately and one at a time I've
> added a helper to emit the mount options after the fact once the mount
> is configured, this matches the dmesg output for what happens with the
> old mount API.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/super.c | 243 +++++++++++++++++++++++++++++++++++++++++++----
>  fs/btrfs/zoned.c |  16 ++--
>  fs/btrfs/zoned.h |   6 +-
>  3 files changed, 236 insertions(+), 29 deletions(-)
> 
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index facea4632a8d..b5067cf637a2 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -734,10 +734,11 @@ static int btrfs_parse_param(struct fs_context *fc,
>  	return 0;
>  }
>  
> -static bool check_ro_option(struct btrfs_fs_info *fs_info, unsigned long opt,
> +static bool check_ro_option(struct btrfs_fs_info *fs_info,
> +			    unsigned long mount_opt, unsigned long opt,
>  			    const char *opt_name)
>  {
> -	if (fs_info->mount_opt & opt) {
> +	if (mount_opt & opt) {
>  		btrfs_err(fs_info, "%s must be used with ro mount option",
>  			  opt_name);
>  		return true;
> @@ -745,33 +746,34 @@ static bool check_ro_option(struct btrfs_fs_info *fs_info, unsigned long opt,
>  	return false;
>  }
>  
> -static bool check_options(struct btrfs_fs_info *info, unsigned long flags)
> +static bool check_options(struct btrfs_fs_info *info, unsigned long *mount_opt,
> +			  unsigned long flags)
>  {
>  	if (!(flags & SB_RDONLY) &&
> -	    (check_ro_option(info, BTRFS_MOUNT_NOLOGREPLAY, "nologreplay") ||
> -	     check_ro_option(info, BTRFS_MOUNT_IGNOREBADROOTS, "ignorebadroots") ||
> -	     check_ro_option(info, BTRFS_MOUNT_IGNOREDATACSUMS, "ignoredatacsums")))
> +	    (check_ro_option(info, *mount_opt, BTRFS_MOUNT_NOLOGREPLAY, "nologreplay") ||
> +	     check_ro_option(info, *mount_opt, BTRFS_MOUNT_IGNOREBADROOTS, "ignorebadroots") ||
> +	     check_ro_option(info, *mount_opt, BTRFS_MOUNT_IGNOREDATACSUMS, "ignoredatacsums")))
>  		return false;
>  
>  	if (btrfs_fs_compat_ro(info, FREE_SPACE_TREE) &&
> -	    !btrfs_test_opt(info, FREE_SPACE_TREE) &&
> -	    !btrfs_test_opt(info, CLEAR_CACHE)) {
> +	    !btrfs_raw_test_opt(*mount_opt, FREE_SPACE_TREE) &&
> +	    !btrfs_raw_test_opt(*mount_opt, CLEAR_CACHE)) {
>  		btrfs_err(info, "cannot disable free space tree");
>  		return false;
>  	}
>  	if (btrfs_fs_compat_ro(info, BLOCK_GROUP_TREE) &&
> -	     !btrfs_test_opt(info, FREE_SPACE_TREE)) {
> +	     !btrfs_raw_test_opt(*mount_opt, FREE_SPACE_TREE)) {
>  		btrfs_err(info, "cannot disable free space tree with block-group-tree feature");
>  		return false;
>  	}
>  
> -	if (btrfs_check_mountopts_zoned(info))
> +	if (btrfs_check_mountopts_zoned(info, mount_opt))
>  		return false;
>  
>  	if (!test_bit(BTRFS_FS_STATE_REMOUNTING, &info->fs_state)) {
> -		if (btrfs_test_opt(info, SPACE_CACHE))
> +		if (btrfs_raw_test_opt(*mount_opt, SPACE_CACHE))
>  			btrfs_info(info, "disk space caching is enabled");
> -		if (btrfs_test_opt(info, FREE_SPACE_TREE))
> +		if (btrfs_raw_test_opt(*mount_opt, FREE_SPACE_TREE))
>  			btrfs_info(info, "using free space tree");
>  	}
>  
> @@ -1337,7 +1339,7 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
>  		}
>  	}
>  out:
> -	if (!ret && !check_options(info, new_flags))
> +	if (!ret && !check_options(info, &info->mount_opt, new_flags))
>  		ret = -EINVAL;
>  	return ret;
>  }
> @@ -2377,6 +2379,203 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
>  	return ret;
>  }
>  
> +static void btrfs_ctx_to_info(struct btrfs_fs_info *fs_info,
> +			      struct btrfs_fs_context *ctx)
> +{
> +	fs_info->max_inline = ctx->max_inline;
> +	fs_info->commit_interval = ctx->commit_interval;
> +	fs_info->metadata_ratio = ctx->metadata_ratio;
> +	fs_info->thread_pool_size = ctx->thread_pool_size;
> +	fs_info->mount_opt = ctx->mount_opt;
> +	fs_info->compress_type = ctx->compress_type;
> +	fs_info->compress_level = ctx->compress_level;
> +}
> +
> +static void btrfs_info_to_ctx(struct btrfs_fs_info *fs_info,
> +			      struct btrfs_fs_context *ctx)
> +{
> +	ctx->max_inline = fs_info->max_inline;
> +	ctx->commit_interval = fs_info->commit_interval;
> +	ctx->metadata_ratio = fs_info->metadata_ratio;
> +	ctx->thread_pool_size = fs_info->thread_pool_size;
> +	ctx->mount_opt = fs_info->mount_opt;
> +	ctx->compress_type = fs_info->compress_type;
> +	ctx->compress_level = fs_info->compress_level;
> +}
> +
> +#define btrfs_info_if_set(fs_info, old_ctx, opt, fmt, args...)			\
> +do {										\
> +	if ((!old_ctx || !btrfs_raw_test_opt(old_ctx->mount_opt, opt)) &&	\
> +	    btrfs_raw_test_opt(fs_info->mount_opt, opt))			\
> +		btrfs_info(fs_info, fmt, ##args);				\
> +} while (0)
> +
> +#define btrfs_info_if_unset(fs_info, old_ctx, opt, fmt, args...)	\
> +do {									\
> +	if ((old_ctx && btrfs_raw_test_opt(old_ctx->mount_opt, opt)) &&	\
> +	    !btrfs_raw_test_opt(fs_info->mount_opt, opt))		\
> +		btrfs_info(fs_info, fmt, ##args);			\
> +} while (0)
> +
> +static void btrfs_emit_options(struct btrfs_fs_info *fs_info,
> +			       struct btrfs_fs_context *old_ctx)
> +{
> +	btrfs_info_if_set(fs_info, old_ctx, NODATASUM, "setting nodatasum");
> +	btrfs_info_if_set(fs_info, old_ctx, DEGRADED,
> +			  "allowing degraded mounts");
> +	btrfs_info_if_set(fs_info, old_ctx, NODATASUM, "setting nodatasum");
> +	btrfs_info_if_set(fs_info, old_ctx, SSD, "enabling ssd optimizations");
> +	btrfs_info_if_set(fs_info, old_ctx, SSD_SPREAD,
> +			  "using spread ssd allocation scheme");
> +	btrfs_info_if_set(fs_info, old_ctx, NOBARRIER, "turning off barriers");
> +	btrfs_info_if_set(fs_info, old_ctx, NOTREELOG, "disabling tree log");
> +	btrfs_info_if_set(fs_info, old_ctx, NOLOGREPLAY,
> +			  "disabling log replay at mount time");
> +	btrfs_info_if_set(fs_info, old_ctx, FLUSHONCOMMIT,
> +			  "turning on flush-on-commit");
> +	btrfs_info_if_set(fs_info, old_ctx, DISCARD_SYNC,
> +			  "turning on sync discard");
> +	btrfs_info_if_set(fs_info, old_ctx, DISCARD_ASYNC,
> +			  "turning on async discard");
> +	btrfs_info_if_set(fs_info, old_ctx, FREE_SPACE_TREE,
> +			  "enabling free space tree");
> +	btrfs_info_if_set(fs_info, old_ctx, SPACE_CACHE,
> +			  "enabling disk space caching");
> +	btrfs_info_if_set(fs_info, old_ctx, CLEAR_CACHE,
> +			  "force clearing of disk cache");
> +	btrfs_info_if_set(fs_info, old_ctx, AUTO_DEFRAG,
> +			  "enabling auto defrag");
> +	btrfs_info_if_set(fs_info, old_ctx, FRAGMENT_DATA,
> +			  "fragmenting data");
> +	btrfs_info_if_set(fs_info, old_ctx, FRAGMENT_METADATA,
> +			  "fragmenting metadata");
> +	btrfs_info_if_set(fs_info, old_ctx, REF_VERIFY,
> +			  "doing ref verification");
> +	btrfs_info_if_set(fs_info, old_ctx, USEBACKUPROOT,
> +			  "trying to use backup root at mount time");
> +	btrfs_info_if_set(fs_info, old_ctx, IGNOREBADROOTS,
> +			  "ignoring bad roots");
> +	btrfs_info_if_set(fs_info, old_ctx, IGNOREDATACSUMS,
> +			  "ignoring data csums");

I think we can format this on >80 char lines, it would look better IMHO.
If fs_info and old_ctx are named shorter then more of the string fits.

> +	btrfs_info_if_unset(fs_info, old_ctx, NODATACOW, "setting datacow");
> +	btrfs_info_if_unset(fs_info, old_ctx, SSD, "not using ssd optimizations");
> +	btrfs_info_if_unset(fs_info, old_ctx, SSD_SPREAD,
> +			    "not using spread ssd allocation scheme");
> +	btrfs_info_if_unset(fs_info, old_ctx, NOBARRIER,
> +			    "turning off barriers");
> +	btrfs_info_if_unset(fs_info, old_ctx, NOTREELOG, "enabling tree log");
> +	btrfs_info_if_unset(fs_info, old_ctx, SPACE_CACHE,
> +			    "disabling disk space caching");
> +	btrfs_info_if_unset(fs_info, old_ctx, FREE_SPACE_TREE,
> +			    "disabling free space tree");
> +	btrfs_info_if_unset(fs_info, old_ctx, AUTO_DEFRAG,
> +			    "disabling auto defrag");
> +	btrfs_info_if_unset(fs_info, old_ctx, COMPRESS,
> +			    "use no compression");

Same

> +
> +	/* Did the compression settings change? */
> +	if (btrfs_test_opt(fs_info, COMPRESS) &&
> +	    (!old_ctx ||
> +	     old_ctx->compress_type != fs_info->compress_type ||
> +	     old_ctx->compress_level != fs_info->compress_level ||
> +	     (!btrfs_raw_test_opt(old_ctx->mount_opt, FORCE_COMPRESS) &&
> +	      btrfs_raw_test_opt(fs_info->mount_opt, FORCE_COMPRESS)))) {
> +		char *compress_type = "none";
> +
> +		switch (fs_info->compress_type) {
> +		case BTRFS_COMPRESS_ZLIB:
> +			compress_type = "zlib";
> +			break;
> +		case BTRFS_COMPRESS_LZO:
> +			compress_type = "lzo";
> +			break;
> +		case BTRFS_COMPRESS_ZSTD:
> +			compress_type = "zstd";
> +			break;
> +		}

We have btrfs_compress_type2str()

> +
> +		btrfs_info(fs_info, "%s %s compression, level %d",
> +			   btrfs_test_opt(fs_info, FORCE_COMPRESS) ? "force" : "use",
> +			   compress_type, fs_info->compress_level);
> +	}
> +
> +	if (fs_info->max_inline != BTRFS_DEFAULT_MAX_INLINE)
> +		btrfs_info(fs_info, "max_inline at %llu",
> +			   fs_info->max_inline);
> +}

