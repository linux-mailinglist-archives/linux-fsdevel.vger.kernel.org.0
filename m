Return-Path: <linux-fsdevel+bounces-48791-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF47AAB495B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 04:15:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2764617188E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 02:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F591B87C9;
	Tue, 13 May 2025 02:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nYXKQwO3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD101B0411
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 May 2025 02:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747102522; cv=none; b=inPhiHgAwrkGrtK8EXqA61qSppta/Hx78jHh5ih09w311cYt/l/lqOTTFlSuI9vRp2ltnWGFmOF5+N/4orODp2XS2bI5kK8nwogpRzPVQjk/Efpz78q22Ga0ILm15UdJNWbwhphrnTmOmwuYhLT7ilykOVWgVRJg97eDL0usw3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747102522; c=relaxed/simple;
	bh=jRt5CbX6+Q0OUzaiN619IgC36yvuHhHgbtpwp2BBgMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ei120zL+Vbm1GxbnOYOOCQ0wbvB8XAyyItKvhjMgZGWLped3xNSq/lFhyi3BY/pw5LlDK5Dgx/1OwE+4aj/1zyiB3pmSvFyLxjshnfmRw2uzXEVWCXuNSbeOdDr04lu4zPP8KhQ9kbkou19440Z7k4cFicwfpkwZOZfozxYctsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nYXKQwO3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73472C4CEE7;
	Tue, 13 May 2025 02:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747102521;
	bh=jRt5CbX6+Q0OUzaiN619IgC36yvuHhHgbtpwp2BBgMw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nYXKQwO3nK8V5qJS/4jUBOCRF3JdzJkW9bkHp7K0XrxG1JZmDkoKRQ1ovyFTlXvZ6
	 YP2uEHNBP4cv+70y3YeZiQ/SPvGYR4hnatwnNF1jr2qERetI0CLegTEamyC2Eh7Xox
	 Oj5CEiJxlVFeEZamBK5EgYHlmQKLkqd23HCIgnOP6gxucVm1RMex355BJKLkZuNDBo
	 Qjzdfu36OE9EtFAXFCOWo+kGy8BCp0hYcqCV7f1e0EkTaomVxZHFDnnKxIRZJqFnQ/
	 mDV2b9WcIIz6rJtKJxhw1qBIJGOMS3D6OgYFu4q0htfysF4p50/8E+n9Vha4o+dJsq
	 WoTURUBgPDHXA==
Date: Tue, 13 May 2025 02:15:19 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Eric Sandeen <sandeen@redhat.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
	chao@kernel.org, lihongbo22@huawei.com
Subject: Re: [PATCH V3 5/7] f2fs: separate the options parsing and options
 checking
Message-ID: <aCKrNwPJyOOIivzC@google.com>
References: <20250423170926.76007-1-sandeen@redhat.com>
 <20250423170926.76007-6-sandeen@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250423170926.76007-6-sandeen@redhat.com>

On 04/23, Eric Sandeen wrote:
> From: Hongbo Li <lihongbo22@huawei.com>
> 
> The new mount api separates option parsing and super block setup
> into two distinct steps and so we need to separate the options
> parsing out of the parse_options().
> 
> In order to achieve this, here we handle the mount options with
> three steps:
>   - Firstly, we move sb/sbi out of handle_mount_opt.
>     As the former patch introduced f2fs_fs_context, so we record
>     the changed mount options in this context. In handle_mount_opt,
>     sb/sbi is null, so we should move all relative code out of
>     handle_mount_opt (thus, some check case which use sb/sbi should
>     move out).
>   - Secondly, we introduce the some check helpers to keep the option
>     consistent.
>     During filling superblock period, sb/sbi are ready. So we check
>     the f2fs_fs_context which holds the mount options base on sb/sbi.
>   - Thirdly, we apply the new mount options to sb/sbi.
>     After checking the f2fs_fs_context, all changed on mount options
>     are valid. So we can apply them to sb/sbi directly.
> 
> After do these, option parsing and super block setting have been
> decoupled. Also it should have retained the original execution
> flow.
> 
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> [sandeen: forward port, minor fixes and updates]
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> ---
>  fs/f2fs/super.c | 693 +++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 510 insertions(+), 183 deletions(-)
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 15befeb45c94..149134775870 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -360,6 +360,12 @@ static inline void ctx_clear_opt(struct f2fs_fs_context *ctx,
>  	ctx->opt_mask |= flag;
>  }
>  
> +static inline bool ctx_test_opt(struct f2fs_fs_context *ctx,
> +				unsigned int flag)
> +{
> +	return ctx->info.opt & flag;
> +}
> +
>  static inline void ctx_set_flags(struct f2fs_fs_context *ctx,
>  				 unsigned int flag)
>  {
> @@ -533,51 +539,6 @@ static int f2fs_unnote_qf_name(struct fs_context *fc, int qtype)
>  	ctx->qname_mask |= 1 << qtype;
>  	return 0;
>  }
> -
> -static int f2fs_check_quota_options(struct f2fs_sb_info *sbi)
> -{
> -	/*
> -	 * We do the test below only for project quotas. 'usrquota' and
> -	 * 'grpquota' mount options are allowed even without quota feature
> -	 * to support legacy quotas in quota files.
> -	 */
> -	if (test_opt(sbi, PRJQUOTA) && !f2fs_sb_has_project_quota(sbi)) {
> -		f2fs_err(sbi, "Project quota feature not enabled. Cannot enable project quota enforcement.");
> -		return -1;
> -	}
> -	if (F2FS_OPTION(sbi).s_qf_names[USRQUOTA] ||
> -			F2FS_OPTION(sbi).s_qf_names[GRPQUOTA] ||
> -			F2FS_OPTION(sbi).s_qf_names[PRJQUOTA]) {
> -		if (test_opt(sbi, USRQUOTA) &&
> -				F2FS_OPTION(sbi).s_qf_names[USRQUOTA])
> -			clear_opt(sbi, USRQUOTA);
> -
> -		if (test_opt(sbi, GRPQUOTA) &&
> -				F2FS_OPTION(sbi).s_qf_names[GRPQUOTA])
> -			clear_opt(sbi, GRPQUOTA);
> -
> -		if (test_opt(sbi, PRJQUOTA) &&
> -				F2FS_OPTION(sbi).s_qf_names[PRJQUOTA])
> -			clear_opt(sbi, PRJQUOTA);
> -
> -		if (test_opt(sbi, GRPQUOTA) || test_opt(sbi, USRQUOTA) ||
> -				test_opt(sbi, PRJQUOTA)) {
> -			f2fs_err(sbi, "old and new quota format mixing");
> -			return -1;
> -		}
> -
> -		if (!F2FS_OPTION(sbi).s_jquota_fmt) {
> -			f2fs_err(sbi, "journaled quota format not specified");
> -			return -1;
> -		}
> -	}
> -
> -	if (f2fs_sb_has_quota_ino(sbi) && F2FS_OPTION(sbi).s_jquota_fmt) {
> -		f2fs_info(sbi, "QUOTA feature is enabled, so ignore jquota_fmt");
> -		F2FS_OPTION(sbi).s_jquota_fmt = 0;
> -	}
> -	return 0;
> -}
>  #endif
>  
>  static int f2fs_parse_test_dummy_encryption(const struct fs_parameter *param,
> @@ -636,28 +597,28 @@ static bool is_compress_extension_exist(struct f2fs_mount_info *info,
>   * extension will be treated as special cases and will not be compressed.
>   * 3. Don't allow the non-compress extension specifies all files.
>   */
> -static int f2fs_test_compress_extension(struct f2fs_sb_info *sbi)
> +static int f2fs_test_compress_extension(unsigned char (*noext)[F2FS_EXTENSION_LEN],
> +					int noext_cnt,
> +					unsigned char (*ext)[F2FS_EXTENSION_LEN],
> +					int ext_cnt)
>  {
> -	unsigned char (*ext)[F2FS_EXTENSION_LEN];
> -	unsigned char (*noext)[F2FS_EXTENSION_LEN];
> -	int ext_cnt, noext_cnt, index = 0, no_index = 0;
> -
> -	ext = F2FS_OPTION(sbi).extensions;
> -	ext_cnt = F2FS_OPTION(sbi).compress_ext_cnt;
> -	noext = F2FS_OPTION(sbi).noextensions;
> -	noext_cnt = F2FS_OPTION(sbi).nocompress_ext_cnt;
> +	int index = 0, no_index = 0;
>  
>  	if (!noext_cnt)
>  		return 0;
>  
>  	for (no_index = 0; no_index < noext_cnt; no_index++) {
> +		if (strlen(noext[no_index]) == 0)
> +			continue;
>  		if (!strcasecmp("*", noext[no_index])) {
> -			f2fs_info(sbi, "Don't allow the nocompress extension specifies all files");
> +			f2fs_info(NULL, "Don't allow the nocompress extension specifies all files");
>  			return -EINVAL;
>  		}
>  		for (index = 0; index < ext_cnt; index++) {
> +			if (strlen(ext[index]) == 0)
> +				continue;
>  			if (!strcasecmp(ext[index], noext[no_index])) {
> -				f2fs_info(sbi, "Don't allow the same extension %s appear in both compress and nocompress extension",
> +				f2fs_info(NULL, "Don't allow the same extension %s appear in both compress and nocompress extension",
>  						ext[index]);
>  				return -EINVAL;
>  			}
> @@ -749,7 +710,6 @@ static int f2fs_set_zstd_level(struct f2fs_fs_context *ctx, const char *str)
>  static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
>  {
>  	struct f2fs_fs_context *ctx = fc->fs_private;
> -	struct f2fs_sb_info *sbi = fc->s_fs_info;
>  #ifdef CONFIG_F2FS_FS_COMPRESSION
>  	unsigned char (*ext)[F2FS_EXTENSION_LEN];
>  	unsigned char (*noext)[F2FS_EXTENSION_LEN];
> @@ -758,15 +718,12 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
>  #endif
>  	substring_t args[MAX_OPT_ARGS];
>  	struct fs_parse_result result;
> -	int is_remount;
>  	int token, ret, arg;
>  
>  	token = fs_parse(fc, f2fs_param_specs, param, &result);
>  	if (token < 0)
>  		return token;
>  
> -	is_remount = fc->purpose == FS_CONTEXT_FOR_RECONFIGURE;
> -
>  	switch (token) {
>  	case Opt_gc_background:
>  		F2FS_CTX_INFO(ctx).bggc_mode = result.uint_32;
> @@ -780,19 +737,10 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
>  		ctx_set_opt(ctx, F2FS_MOUNT_NORECOVERY);
>  		break;
>  	case Opt_discard:
> -		if (result.negated) {
> -			if (f2fs_hw_should_discard(sbi)) {
> -				f2fs_warn(NULL, "discard is required for zoned block devices");
> -				return -EINVAL;
> -			}
> +		if (result.negated)
>  			ctx_clear_opt(ctx, F2FS_MOUNT_DISCARD);
> -		} else {
> -			if (!f2fs_hw_support_discard(sbi)) {
> -				f2fs_warn(NULL, "device does not support discard");
> -				break;
> -			}
> +		else
>  			ctx_set_opt(ctx, F2FS_MOUNT_DISCARD);
> -		}
>  		break;
>  	case Opt_noheap:
>  	case Opt_heap:
> @@ -812,6 +760,12 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
>  			ctx_set_opt(ctx, F2FS_MOUNT_INLINE_XATTR);
>  		break;
>  	case Opt_inline_xattr_size:
> +		if (result.int_32 < MIN_INLINE_XATTR_SIZE ||
> +			result.int_32 > MAX_INLINE_XATTR_SIZE) {
> +			f2fs_err(NULL, "inline xattr size is out of range: %zu ~ %zu",

I fixed this to %lu ~ %lu to avoid build warning.

> +				MIN_INLINE_XATTR_SIZE, MAX_INLINE_XATTR_SIZE);
> +			return -EINVAL;
> +		}
>  		ctx_set_opt(ctx, F2FS_MOUNT_INLINE_XATTR_SIZE);
>  		F2FS_CTX_INFO(ctx).inline_xattr_size = result.int_32;
>  		ctx->spec_mask |= F2FS_SPEC_inline_xattr_size;
> @@ -873,27 +827,18 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
>  		ctx_set_opt(ctx, F2FS_MOUNT_FASTBOOT);
>  		break;
>  	case Opt_extent_cache:
> -		if (result.negated) {
> -			if (f2fs_sb_has_device_alias(sbi)) {
> -				f2fs_err(sbi, "device aliasing requires extent cache");
> -				return -EINVAL;
> -			}
> +		if (result.negated)
>  			ctx_clear_opt(ctx, F2FS_MOUNT_READ_EXTENT_CACHE);
> -		} else
> +		else
>  			ctx_set_opt(ctx, F2FS_MOUNT_READ_EXTENT_CACHE);
>  		break;
>  	case Opt_data_flush:
>  		ctx_set_opt(ctx, F2FS_MOUNT_DATA_FLUSH);
>  		break;
>  	case Opt_reserve_root:
> -		if (test_opt(sbi, RESERVE_ROOT)) {
> -			f2fs_info(NULL, "Preserve previous reserve_root=%u",
> -				  F2FS_OPTION(sbi).root_reserved_blocks);
> -		} else {
> -			ctx_set_opt(ctx, F2FS_MOUNT_RESERVE_ROOT);
> -			F2FS_CTX_INFO(ctx).root_reserved_blocks = result.uint_32;
> -			ctx->spec_mask |= F2FS_SPEC_reserve_root;
> -		}
> +		ctx_set_opt(ctx, F2FS_MOUNT_RESERVE_ROOT);
> +		F2FS_CTX_INFO(ctx).root_reserved_blocks = result.uint_32;
> +		ctx->spec_mask |= F2FS_SPEC_reserve_root;
>  		break;
>  	case Opt_resuid:
>  		F2FS_CTX_INFO(ctx).s_resuid = result.uid;
> @@ -909,7 +854,7 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
>  		break;
>  #ifdef CONFIG_F2FS_FAULT_INJECTION
>  	case Opt_fault_injection:
> -		if (f2fs_build_fault_attr(sbi, result.int_32, 0, FAULT_RATE))
> +		if (result.int_32 > INT_MAX)
>  			return -EINVAL;
>  		F2FS_CTX_INFO(ctx).fault_info.inject_rate = result.int_32;
>  		ctx->spec_mask |= F2FS_SPEC_fault_injection;
> @@ -917,7 +862,7 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
>  		break;
>  
>  	case Opt_fault_type:
> -		if (f2fs_build_fault_attr(sbi, 0, result.int_32, FAULT_TYPE))
> +		if (result.uint_32 > BIT(FAULT_MAX))
>  			return -EINVAL;
>  		F2FS_CTX_INFO(ctx).fault_info.inject_type = result.uint_32;
>  		ctx->spec_mask |= F2FS_SPEC_fault_type;
> @@ -1051,10 +996,6 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
>  		break;
>  #ifdef CONFIG_F2FS_FS_COMPRESSION
>  	case Opt_compress_algorithm:
> -		if (!f2fs_sb_has_compression(sbi)) {
> -			f2fs_info(NULL, "Image doesn't support compression");
> -			break;
> -		}
>  		name = param->string;
>  		if (!strcmp(name, "lzo")) {
>  #ifdef CONFIG_F2FS_FS_LZO
> @@ -1098,10 +1039,6 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
>  			return -EINVAL;
>  		break;
>  	case Opt_compress_log_size:
> -		if (!f2fs_sb_has_compression(sbi)) {
> -			f2fs_info(NULL, "Image doesn't support compression");
> -			break;
> -		}
>  		if (result.uint_32 < MIN_COMPRESS_LOG_SIZE ||
>  		    result.uint_32 > MAX_COMPRESS_LOG_SIZE) {
>  			f2fs_err(NULL,
> @@ -1112,10 +1049,6 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
>  		ctx->spec_mask |= F2FS_SPEC_compress_log_size;
>  		break;
>  	case Opt_compress_extension:
> -		if (!f2fs_sb_has_compression(sbi)) {
> -			f2fs_info(NULL, "Image doesn't support compression");
> -			break;
> -		}
>  		name = param->string;
>  		ext = F2FS_CTX_INFO(ctx).extensions;
>  		ext_cnt = F2FS_CTX_INFO(ctx).compress_ext_cnt;
> @@ -1136,10 +1069,6 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
>  		ctx->spec_mask |= F2FS_SPEC_compress_extension;
>  		break;
>  	case Opt_nocompress_extension:
> -		if (!f2fs_sb_has_compression(sbi)) {
> -			f2fs_info(NULL, "Image doesn't support compression");
> -			break;
> -		}
>  		name = param->string;
>  		noext = F2FS_CTX_INFO(ctx).noextensions;
>  		noext_cnt = F2FS_CTX_INFO(ctx).nocompress_ext_cnt;
> @@ -1160,26 +1089,14 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
>  		ctx->spec_mask |= F2FS_SPEC_nocompress_extension;
>  		break;
>  	case Opt_compress_chksum:
> -		if (!f2fs_sb_has_compression(sbi)) {
> -			f2fs_info(NULL, "Image doesn't support compression");
> -			break;
> -		}
>  		F2FS_CTX_INFO(ctx).compress_chksum = true;
>  		ctx->spec_mask |= F2FS_SPEC_compress_chksum;
>  		break;
>  	case Opt_compress_mode:
> -		if (!f2fs_sb_has_compression(sbi)) {
> -			f2fs_info(NULL, "Image doesn't support compression");
> -			break;
> -		}
>  		F2FS_CTX_INFO(ctx).compress_mode = result.uint_32;
>  		ctx->spec_mask |= F2FS_SPEC_compress_mode;
>  		break;
>  	case Opt_compress_cache:
> -		if (!f2fs_sb_has_compression(sbi)) {
> -			f2fs_info(NULL, "Image doesn't support compression");
> -			break;
> -		}
>  		ctx_set_opt(ctx, F2FS_MOUNT_COMPRESS_CACHE);
>  		break;
>  #else
> @@ -1224,24 +1141,15 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
>  	return 0;
>  }
>  
> -static int parse_options(struct f2fs_sb_info *sbi, char *options, bool is_remount)
> +static int parse_options(struct fs_context *fc, char *options)
>  {
>  	struct fs_parameter param;
> -	struct fs_context fc;
> -	struct f2fs_fs_context ctx;
>  	char *key;
>  	int ret;
>  
>  	if (!options)
>  		return 0;
>  
> -	memset(&fc, 0, sizeof(fc));
> -	fc.s_fs_info = sbi;
> -	fc.fs_private = &ctx;
> -
> -	if (is_remount)
> -		fc.purpose = FS_CONTEXT_FOR_RECONFIGURE;
> -
>  	while ((key = strsep(&options, ",")) != NULL) {
>  		if (*key) {
>  			size_t v_len = 0;
> @@ -1265,7 +1173,7 @@ static int parse_options(struct f2fs_sb_info *sbi, char *options, bool is_remoun
>  			param.key = key;
>  			param.size = v_len;
>  
> -			ret = handle_mount_opt(&fc, &param);
> +			ret = handle_mount_opt(fc, &param);
>  			kfree(param.string);
>  			if (ret < 0)
>  				return ret;
> @@ -1274,24 +1182,293 @@ static int parse_options(struct f2fs_sb_info *sbi, char *options, bool is_remoun
>  	return 0;
>  }
>  
> -static int f2fs_validate_options(struct f2fs_sb_info *sbi)
> +/*
> + * Check quota settings consistency.
> + */
> +static int f2fs_check_quota_consistency(struct fs_context *fc,
> +					struct super_block *sb)
>  {
> -#ifdef CONFIG_QUOTA
> -	if (f2fs_check_quota_options(sbi))
> +	struct f2fs_sb_info *sbi = F2FS_SB(sb);
> + #ifdef CONFIG_QUOTA
> +	struct f2fs_fs_context *ctx = fc->fs_private;
> +	bool quota_feature = f2fs_sb_has_quota_ino(sbi);
> +	bool quota_turnon = sb_any_quota_loaded(sb);
> +	char *old_qname, *new_qname;
> +	bool usr_qf_name, grp_qf_name, prj_qf_name, usrquota, grpquota, prjquota;
> +	int i;
> +
> +	/*
> +	 * We do the test below only for project quotas. 'usrquota' and
> +	 * 'grpquota' mount options are allowed even without quota feature
> +	 * to support legacy quotas in quota files.
> +	 */
> +	if (ctx_test_opt(ctx, F2FS_MOUNT_PRJQUOTA) &&
> +			!f2fs_sb_has_project_quota(sbi)) {
> +		f2fs_err(sbi, "Project quota feature not enabled. Cannot enable project quota enforcement.");
>  		return -EINVAL;
> +	}
> +
> +	if (ctx->qname_mask) {
> +		for (i = 0; i < MAXQUOTAS; i++) {
> +			if (!(ctx->qname_mask & (1 << i)))
> +				continue;
> +
> +			old_qname = F2FS_OPTION(sbi).s_qf_names[i];
> +			new_qname = F2FS_CTX_INFO(ctx).s_qf_names[i];
> +			if (quota_turnon &&
> +				!!old_qname != !!new_qname)
> +				goto err_jquota_change;
> +
> +			if (old_qname) {
> +				if (strcmp(old_qname, new_qname) == 0) {
> +					ctx->qname_mask &= ~(1 << i);
> +					continue;
> +				}
> +				goto err_jquota_specified;
> +			}
> +
> +			if (quota_feature) {
> +				f2fs_info(sbi, "QUOTA feature is enabled, so ignore qf_name");
> +				ctx->qname_mask &= ~(1 << i);
> +				kfree(F2FS_CTX_INFO(ctx).s_qf_names[i]);
> +				F2FS_CTX_INFO(ctx).s_qf_names[i] = NULL;
> +			}
> +		}
> +	}
> +
> +	/* Make sure we don't mix old and new quota format */
> +	usr_qf_name = F2FS_OPTION(sbi).s_qf_names[USRQUOTA] ||
> +			F2FS_CTX_INFO(ctx).s_qf_names[USRQUOTA];
> +	grp_qf_name = F2FS_OPTION(sbi).s_qf_names[GRPQUOTA] ||
> +			F2FS_CTX_INFO(ctx).s_qf_names[GRPQUOTA];
> +	prj_qf_name = F2FS_OPTION(sbi).s_qf_names[PRJQUOTA] ||
> +			F2FS_CTX_INFO(ctx).s_qf_names[PRJQUOTA];
> +	usrquota = test_opt(sbi, USRQUOTA) ||
> +			ctx_test_opt(ctx, F2FS_MOUNT_USRQUOTA);
> +	grpquota = test_opt(sbi, GRPQUOTA) ||
> +			ctx_test_opt(ctx, F2FS_MOUNT_GRPQUOTA);
> +	prjquota = test_opt(sbi, PRJQUOTA) ||
> +			ctx_test_opt(ctx, F2FS_MOUNT_PRJQUOTA);
> +
> +	if (usr_qf_name) {
> +		ctx_clear_opt(ctx, F2FS_MOUNT_USRQUOTA);
> +		usrquota = false;
> +	}
> +	if (grp_qf_name) {
> +		ctx_clear_opt(ctx, F2FS_MOUNT_GRPQUOTA);
> +		grpquota = false;
> +	}
> +	if (prj_qf_name) {
> +		ctx_clear_opt(ctx, F2FS_MOUNT_PRJQUOTA);
> +		prjquota = false;
> +	}
> +	if (usr_qf_name || grp_qf_name || prj_qf_name) {
> +		if (grpquota || usrquota || prjquota) {
> +			f2fs_err(sbi, "old and new quota format mixing");
> +			return -EINVAL;
> +		}
> +		if (!(ctx->spec_mask & F2FS_SPEC_jqfmt ||
> +				F2FS_OPTION(sbi).s_jquota_fmt)) {
> +			f2fs_err(sbi, "journaled quota format not specified");
> +			return -EINVAL;
> +		}
> +	}
> +	return 0;
> +
> +err_jquota_change:
> +	f2fs_err(sbi, "Cannot change journaled quota options when quota turned on");
> +	return -EINVAL;
> +err_jquota_specified:
> +	f2fs_err(sbi, "%s quota file already specified",
> +		 QTYPE2NAME(i));
> +	return -EINVAL;
> +
>  #else
> -	if (f2fs_sb_has_quota_ino(sbi) && !f2fs_readonly(sbi->sb)) {
> -		f2fs_info(NULL, "Filesystem with quota feature cannot be mounted RDWR without CONFIG_QUOTA");
> +	if (f2fs_readonly(sbi->sb))
> +		return 0;
> +	if (f2fs_sb_has_quota_ino(sbi)) {
> +		f2fs_info(sbi, "Filesystem with quota feature cannot be mounted RDWR without CONFIG_QUOTA");
>  		return -EINVAL;
>  	}
> -	if (f2fs_sb_has_project_quota(sbi) && !f2fs_readonly(sbi->sb)) {
> -		f2fs_err(NULL, "Filesystem with project quota feature cannot be mounted RDWR without CONFIG_QUOTA");
> +	if (f2fs_sb_has_project_quota(sbi)) {
> +		f2fs_err(sbi, "Filesystem with project quota feature cannot be mounted RDWR without CONFIG_QUOTA");
>  		return -EINVAL;
>  	}
> +
> +	return 0;
>  #endif
> +}
> +
> +static int f2fs_check_test_dummy_encryption(struct fs_context *fc,
> +					    struct super_block *sb)
> +{
> +	struct f2fs_fs_context *ctx = fc->fs_private;
> +	struct f2fs_sb_info *sbi = F2FS_SB(sb);
> +
> +	if (!fscrypt_is_dummy_policy_set(&F2FS_CTX_INFO(ctx).dummy_enc_policy))
> +		return 0;
> +
> +	if (!f2fs_sb_has_encrypt(sbi)) {
> +		f2fs_err(sbi, "Encrypt feature is off");
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * This mount option is just for testing, and it's not worthwhile to
> +	 * implement the extra complexity (e.g. RCU protection) that would be
> +	 * needed to allow it to be set or changed during remount.  We do allow
> +	 * it to be specified during remount, but only if there is no change.
> +	 */
> +	if (fc->purpose == FS_CONTEXT_FOR_RECONFIGURE) {
> +		if (fscrypt_dummy_policies_equal(&F2FS_OPTION(sbi).dummy_enc_policy,
> +				&F2FS_CTX_INFO(ctx).dummy_enc_policy))
> +			return 0;
> +		f2fs_warn(sbi, "Can't set or change test_dummy_encryption on remount");
> +		return -EINVAL;
> +	}
> +	return 0;
> +}
> +
> +static inline bool test_compression_spec(unsigned int mask)
> +{
> +	return mask & (F2FS_SPEC_compress_algorithm
> +			| F2FS_SPEC_compress_log_size
> +			| F2FS_SPEC_compress_extension
> +			| F2FS_SPEC_nocompress_extension
> +			| F2FS_SPEC_compress_chksum
> +			| F2FS_SPEC_compress_mode);
> +}
> +
> +static inline void clear_compression_spec(struct f2fs_fs_context *ctx)
> +{
> +	ctx->spec_mask &= ~(F2FS_SPEC_compress_algorithm
> +						| F2FS_SPEC_compress_log_size
> +						| F2FS_SPEC_compress_extension
> +						| F2FS_SPEC_nocompress_extension
> +						| F2FS_SPEC_compress_chksum
> +						| F2FS_SPEC_compress_mode);
> +}
> +
> +static int f2fs_check_compression(struct fs_context *fc,
> +				  struct super_block *sb)
> +{
> +#ifdef CONFIG_F2FS_FS_COMPRESSION
> +	struct f2fs_fs_context *ctx = fc->fs_private;
> +	struct f2fs_sb_info *sbi = F2FS_SB(sb);
> +	int i, cnt;
> +
> +	if (!f2fs_sb_has_compression(sbi)) {
> +		if (test_compression_spec(ctx->opt_mask) ||
> +			ctx_test_opt(ctx, F2FS_MOUNT_COMPRESS_CACHE))
> +			f2fs_info(sbi, "Image doesn't support compression");
> +		clear_compression_spec(ctx);
> +		ctx->opt_mask &= ~F2FS_MOUNT_COMPRESS_CACHE;
> +		return 0;
> +	}
> +	if (ctx->spec_mask & F2FS_SPEC_compress_extension) {
> +		cnt = F2FS_CTX_INFO(ctx).compress_ext_cnt;
> +		for (i = 0; i < F2FS_CTX_INFO(ctx).compress_ext_cnt; i++) {
> +			if (is_compress_extension_exist(&F2FS_OPTION(sbi),
> +					F2FS_CTX_INFO(ctx).extensions[i], true)) {
> +				F2FS_CTX_INFO(ctx).extensions[i][0] = '\0';
> +				cnt--;
> +			}
> +		}
> +		if (F2FS_OPTION(sbi).compress_ext_cnt + cnt > COMPRESS_EXT_NUM) {
> +			f2fs_err(sbi, "invalid extension length/number");
> +			return -EINVAL;
> +		}
> +	}
> +	if (ctx->spec_mask & F2FS_SPEC_nocompress_extension) {
> +		cnt = F2FS_CTX_INFO(ctx).nocompress_ext_cnt;
> +		for (i = 0; i < F2FS_CTX_INFO(ctx).nocompress_ext_cnt; i++) {
> +			if (is_compress_extension_exist(&F2FS_OPTION(sbi),
> +					F2FS_CTX_INFO(ctx).noextensions[i], false)) {
> +				F2FS_CTX_INFO(ctx).noextensions[i][0] = '\0';
> +				cnt--;
> +			}
> +		}
> +		if (F2FS_OPTION(sbi).nocompress_ext_cnt + cnt > COMPRESS_EXT_NUM) {
> +			f2fs_err(sbi, "invalid noextension length/number");
> +			return -EINVAL;
> +		}
> +	}
> +
> +	if (f2fs_test_compress_extension(F2FS_CTX_INFO(ctx).noextensions,
> +				F2FS_CTX_INFO(ctx).nocompress_ext_cnt,
> +				F2FS_CTX_INFO(ctx).extensions,
> +				F2FS_CTX_INFO(ctx).compress_ext_cnt)) {
> +		f2fs_err(sbi, "invalid compress or nocompress extension");
> +		return -EINVAL;
> +	}
> +	if (f2fs_test_compress_extension(F2FS_CTX_INFO(ctx).noextensions,
> +				F2FS_CTX_INFO(ctx).nocompress_ext_cnt,
> +				F2FS_OPTION(sbi).extensions,
> +				F2FS_OPTION(sbi).compress_ext_cnt)) {
> +		f2fs_err(sbi, "invalid compress or nocompress extension");
> +		return -EINVAL;
> +	}
> +	if (f2fs_test_compress_extension(F2FS_OPTION(sbi).noextensions,
> +				F2FS_OPTION(sbi).nocompress_ext_cnt,
> +				F2FS_CTX_INFO(ctx).extensions,
> +				F2FS_CTX_INFO(ctx).compress_ext_cnt)) {
> +		f2fs_err(sbi, "invalid compress or nocompress extension");
> +		return -EINVAL;
> +	}
> +#endif
> +	return 0;
> +}
> +
> +static int f2fs_check_opt_consistency(struct fs_context *fc,
> +				      struct super_block *sb)
> +{
> +	struct f2fs_fs_context *ctx = fc->fs_private;
> +	struct f2fs_sb_info *sbi = F2FS_SB(sb);
> +	int err;
> +
> +	if (ctx_test_opt(ctx, F2FS_MOUNT_NORECOVERY) && !f2fs_readonly(sb))
> +		return -EINVAL;
> +
> +	if (f2fs_hw_should_discard(sbi) && (ctx->opt_mask & F2FS_MOUNT_DISCARD)
> +				&& !ctx_test_opt(ctx, F2FS_MOUNT_DISCARD)) {
> +		f2fs_warn(sbi, "discard is required for zoned block devices");
> +		return -EINVAL;
> +	}
> +
> +	if (f2fs_sb_has_device_alias(sbi)) {
> +		f2fs_err(sbi, "device aliasing requires extent cache");
> +		return -EINVAL;
> +	}
> +
> +	if (!f2fs_hw_support_discard(sbi) && (ctx->opt_mask & F2FS_MOUNT_DISCARD)
> +				&& ctx_test_opt(ctx, F2FS_MOUNT_DISCARD)) {
> +		f2fs_warn(sbi, "device does not support discard");
> +		ctx_clear_opt(ctx, F2FS_MOUNT_DISCARD);
> +		ctx->opt_mask &= ~F2FS_MOUNT_DISCARD;
> +	}
> +
> +	if (test_opt(sbi, RESERVE_ROOT) && (ctx->opt_mask & F2FS_MOUNT_RESERVE_ROOT)
> +				&& ctx_test_opt(ctx, F2FS_MOUNT_RESERVE_ROOT)) {
> +		f2fs_info(sbi, "Preserve previous reserve_root=%u",
> +			F2FS_OPTION(sbi).root_reserved_blocks);
> +		ctx_clear_opt(ctx, F2FS_MOUNT_RESERVE_ROOT);
> +		ctx->opt_mask &= ~F2FS_MOUNT_RESERVE_ROOT;
> +	}
> +
> +	err = f2fs_check_test_dummy_encryption(fc, sb);
> +	if (err)
> +		return err;
> +
> +	err = f2fs_check_compression(fc, sb);
> +	if (err)
> +		return err;
> +
> +	err = f2fs_check_quota_consistency(fc, sb);
> +	if (err)
> +		return err;
>  
>  	if (!IS_ENABLED(CONFIG_UNICODE) && f2fs_sb_has_casefold(sbi)) {
> -		f2fs_err(NULL,
> +		f2fs_err(sbi,
>  			"Filesystem with casefold feature cannot be mounted without CONFIG_UNICODE");
>  		return -EINVAL;
>  	}
> @@ -1303,75 +1480,210 @@ static int f2fs_validate_options(struct f2fs_sb_info *sbi)
>  	 */
>  	if (f2fs_sb_has_blkzoned(sbi)) {
>  #ifdef CONFIG_BLK_DEV_ZONED
> -		if (F2FS_OPTION(sbi).discard_unit !=
> -						DISCARD_UNIT_SECTION) {
> -			f2fs_info(NULL, "Zoned block device doesn't need small discard, set discard_unit=section by default");
> -			F2FS_OPTION(sbi).discard_unit =
> -					DISCARD_UNIT_SECTION;
> +		if ((ctx->spec_mask & F2FS_SPEC_discard_unit) &&
> +		F2FS_CTX_INFO(ctx).discard_unit != DISCARD_UNIT_SECTION) {
> +			f2fs_info(sbi, "Zoned block device doesn't need small discard, set discard_unit=section by default");
> +			F2FS_CTX_INFO(ctx).discard_unit = DISCARD_UNIT_SECTION;
>  		}
>  
> -		if (F2FS_OPTION(sbi).fs_mode != FS_MODE_LFS) {
> -			f2fs_info(NULL, "Only lfs mode is allowed with zoned block device feature");
> +		if ((ctx->spec_mask & F2FS_SPEC_mode) &&
> +		F2FS_CTX_INFO(ctx).fs_mode != FS_MODE_LFS) {
> +			f2fs_info(sbi, "Only lfs mode is allowed with zoned block device feature");
>  			return -EINVAL;
>  		}
>  #else
> -		f2fs_err(NULL, "Zoned block device support is not enabled");
> +		f2fs_err(sbi, "Zoned block device support is not enabled");
>  		return -EINVAL;
>  #endif
>  	}
>  
> -#ifdef CONFIG_F2FS_FS_COMPRESSION
> -	if (f2fs_test_compress_extension(sbi)) {
> -		f2fs_err(NULL, "invalid compress or nocompress extension");
> -		return -EINVAL;
> -	}
> -#endif
> -
> -	if (test_opt(sbi, INLINE_XATTR_SIZE)) {
> -		int min_size, max_size;
> -
> +	if (ctx_test_opt(ctx, F2FS_MOUNT_INLINE_XATTR_SIZE)) {
>  		if (!f2fs_sb_has_extra_attr(sbi) ||
>  			!f2fs_sb_has_flexible_inline_xattr(sbi)) {
> -			f2fs_err(NULL, "extra_attr or flexible_inline_xattr feature is off");
> -			return -EINVAL;
> -		}
> -		if (!test_opt(sbi, INLINE_XATTR)) {
> -			f2fs_err(NULL, "inline_xattr_size option should be set with inline_xattr option");
> +			f2fs_err(sbi, "extra_attr or flexible_inline_xattr feature is off");
>  			return -EINVAL;
>  		}
> -
> -		min_size = MIN_INLINE_XATTR_SIZE;
> -		max_size = MAX_INLINE_XATTR_SIZE;
> -
> -		if (F2FS_OPTION(sbi).inline_xattr_size < min_size ||
> -				F2FS_OPTION(sbi).inline_xattr_size > max_size) {
> -			f2fs_err(NULL, "inline xattr size is out of range: %d ~ %d",
> -				 min_size, max_size);
> +		if (!ctx_test_opt(ctx, F2FS_MOUNT_INLINE_XATTR)) {
> +			f2fs_err(sbi, "inline_xattr_size option should be set with inline_xattr option");
>  			return -EINVAL;
>  		}
>  	}
>  
> -	if (test_opt(sbi, ATGC) && f2fs_lfs_mode(sbi)) {
> -		f2fs_err(NULL, "LFS is not compatible with ATGC");
> +	if (ctx_test_opt(ctx, F2FS_MOUNT_ATGC) &&
> +	    F2FS_CTX_INFO(ctx).fs_mode == FS_MODE_LFS) {
> +		f2fs_err(sbi, "LFS is not compatible with ATGC");
>  		return -EINVAL;
>  	}
>  
> -	if (f2fs_is_readonly(sbi) && test_opt(sbi, FLUSH_MERGE)) {
> -		f2fs_err(NULL, "FLUSH_MERGE not compatible with readonly mode");
> +	if (f2fs_is_readonly(sbi) && ctx_test_opt(ctx, F2FS_MOUNT_FLUSH_MERGE)) {
> +		f2fs_err(sbi, "FLUSH_MERGE not compatible with readonly mode");
>  		return -EINVAL;
>  	}
>  
>  	if (f2fs_sb_has_readonly(sbi) && !f2fs_readonly(sbi->sb)) {
> -		f2fs_err(NULL, "Allow to mount readonly mode only");
> +		f2fs_err(sbi, "Allow to mount readonly mode only");
>  		return -EROFS;
>  	}
> +	return 0;
> +}
>  
> -	if (test_opt(sbi, NORECOVERY) && !f2fs_readonly(sbi->sb)) {
> -		f2fs_err(sbi, "norecovery requires readonly mount");
> -		return -EINVAL;
> +static void f2fs_apply_quota_options(struct fs_context *fc,
> +				     struct super_block *sb)
> +{
> +#ifdef CONFIG_QUOTA
> +	struct f2fs_fs_context *ctx = fc->fs_private;
> +	struct f2fs_sb_info *sbi = F2FS_SB(sb);
> +	bool quota_feature = f2fs_sb_has_quota_ino(sbi);
> +	char *qname;
> +	int i;
> +
> +	if (quota_feature)
> +		return;
> +
> +	for (i = 0; i < MAXQUOTAS; i++) {
> +		if (!(ctx->qname_mask & (1 << i)))
> +			continue;
> +
> +		qname = F2FS_CTX_INFO(ctx).s_qf_names[i];
> +		if (qname)
> +			set_opt(sbi, QUOTA);
> +		F2FS_OPTION(sbi).s_qf_names[i] = qname;
> +		F2FS_CTX_INFO(ctx).s_qf_names[i] = NULL;
>  	}
>  
> -	return 0;
> +	if (ctx->spec_mask & F2FS_SPEC_jqfmt)
> +		F2FS_OPTION(sbi).s_jquota_fmt = F2FS_CTX_INFO(ctx).s_jquota_fmt;
> +
> +	if (quota_feature && F2FS_OPTION(sbi).s_jquota_fmt) {
> +		f2fs_info(sbi, "QUOTA feature is enabled, so ignore jquota_fmt");
> +		F2FS_OPTION(sbi).s_jquota_fmt = 0;
> +	}
> +#endif
> +}
> +
> +static void f2fs_apply_test_dummy_encryption(struct fs_context *fc,
> +					     struct super_block *sb)
> +{
> +	struct f2fs_fs_context *ctx = fc->fs_private;
> +	struct f2fs_sb_info *sbi = F2FS_SB(sb);
> +
> +	if (!fscrypt_is_dummy_policy_set(&F2FS_CTX_INFO(ctx).dummy_enc_policy) ||
> +		/* if already set, it was already verified to be the same */
> +		fscrypt_is_dummy_policy_set(&F2FS_OPTION(sbi).dummy_enc_policy))
> +		return;
> +	F2FS_OPTION(sbi).dummy_enc_policy = F2FS_CTX_INFO(ctx).dummy_enc_policy;
> +	memset(&F2FS_CTX_INFO(ctx).dummy_enc_policy, 0,
> +		sizeof(F2FS_CTX_INFO(ctx).dummy_enc_policy));
> +	f2fs_warn(sbi, "Test dummy encryption mode enabled");
> +}
> +
> +static void f2fs_apply_compression(struct fs_context *fc,
> +				   struct super_block *sb)
> +{
> +#ifdef CONFIG_F2FS_FS_COMPRESSION
> +	struct f2fs_fs_context *ctx = fc->fs_private;
> +	struct f2fs_sb_info *sbi = F2FS_SB(sb);
> +	unsigned char (*ctx_ext)[F2FS_EXTENSION_LEN];
> +	unsigned char (*sbi_ext)[F2FS_EXTENSION_LEN];
> +	int ctx_cnt, sbi_cnt, i;
> +
> +	if (ctx->spec_mask & F2FS_SPEC_compress_level)
> +		F2FS_OPTION(sbi).compress_level =
> +					F2FS_CTX_INFO(ctx).compress_level;
> +	if (ctx->spec_mask & F2FS_SPEC_compress_algorithm)
> +		F2FS_OPTION(sbi).compress_algorithm =
> +					F2FS_CTX_INFO(ctx).compress_algorithm;
> +	if (ctx->spec_mask & F2FS_SPEC_compress_log_size)
> +		F2FS_OPTION(sbi).compress_log_size =
> +					F2FS_CTX_INFO(ctx).compress_log_size;
> +	if (ctx->spec_mask & F2FS_SPEC_compress_chksum)
> +		F2FS_OPTION(sbi).compress_chksum =
> +					F2FS_CTX_INFO(ctx).compress_chksum;
> +	if (ctx->spec_mask & F2FS_SPEC_compress_mode)
> +		F2FS_OPTION(sbi).compress_mode =
> +					F2FS_CTX_INFO(ctx).compress_mode;
> +	if (ctx->spec_mask & F2FS_SPEC_compress_extension) {
> +		ctx_ext = F2FS_CTX_INFO(ctx).extensions;
> +		ctx_cnt = F2FS_CTX_INFO(ctx).compress_ext_cnt;
> +		sbi_ext = F2FS_OPTION(sbi).extensions;
> +		sbi_cnt = F2FS_OPTION(sbi).compress_ext_cnt;
> +		for (i = 0; i < ctx_cnt; i++) {
> +			if (strlen(ctx_ext[i]) == 0)
> +				continue;
> +			strscpy(sbi_ext[sbi_cnt], ctx_ext[i]);
> +			sbi_cnt++;
> +		}
> +		F2FS_OPTION(sbi).compress_ext_cnt = sbi_cnt;
> +	}
> +	if (ctx->spec_mask & F2FS_SPEC_nocompress_extension) {
> +		ctx_ext = F2FS_CTX_INFO(ctx).noextensions;
> +		ctx_cnt = F2FS_CTX_INFO(ctx).nocompress_ext_cnt;
> +		sbi_ext = F2FS_OPTION(sbi).noextensions;
> +		sbi_cnt = F2FS_OPTION(sbi).nocompress_ext_cnt;
> +		for (i = 0; i < ctx_cnt; i++) {
> +			if (strlen(ctx_ext[i]) == 0)
> +				continue;
> +			strscpy(sbi_ext[sbi_cnt], ctx_ext[i]);
> +			sbi_cnt++;
> +		}
> +		F2FS_OPTION(sbi).nocompress_ext_cnt = sbi_cnt;
> +	}
> +#endif
> +}
> +
> +static void f2fs_apply_options(struct fs_context *fc, struct super_block *sb)
> +{
> +	struct f2fs_fs_context *ctx = fc->fs_private;
> +	struct f2fs_sb_info *sbi = F2FS_SB(sb);
> +
> +	F2FS_OPTION(sbi).opt &= ~ctx->opt_mask;
> +	F2FS_OPTION(sbi).opt |= F2FS_CTX_INFO(ctx).opt;
> +	sb->s_flags &= ~ctx->sflags_mask;
> +	sb->s_flags |= ctx->sflags;
> +
> +	if (ctx->spec_mask & F2FS_SPEC_background_gc)
> +		F2FS_OPTION(sbi).bggc_mode = F2FS_CTX_INFO(ctx).bggc_mode;
> +	if (ctx->spec_mask & F2FS_SPEC_inline_xattr_size)
> +		F2FS_OPTION(sbi).inline_xattr_size =
> +					F2FS_CTX_INFO(ctx).inline_xattr_size;
> +	if (ctx->spec_mask & F2FS_SPEC_active_logs)
> +		F2FS_OPTION(sbi).active_logs = F2FS_CTX_INFO(ctx).active_logs;
> +	if (ctx->spec_mask & F2FS_SPEC_reserve_root)
> +		F2FS_OPTION(sbi).root_reserved_blocks =
> +					F2FS_CTX_INFO(ctx).root_reserved_blocks;
> +	if (ctx->spec_mask & F2FS_SPEC_resgid)
> +		F2FS_OPTION(sbi).s_resgid = F2FS_CTX_INFO(ctx).s_resgid;
> +	if (ctx->spec_mask & F2FS_SPEC_resuid)
> +		F2FS_OPTION(sbi).s_resuid = F2FS_CTX_INFO(ctx).s_resuid;
> +	if (ctx->spec_mask & F2FS_SPEC_mode)
> +		F2FS_OPTION(sbi).fs_mode = F2FS_CTX_INFO(ctx).fs_mode;
> +#ifdef CONFIG_F2FS_FAULT_INJECTION
> +	if (ctx->spec_mask & F2FS_SPEC_fault_injection)
> +		(void)f2fs_build_fault_attr(sbi,
> +		F2FS_CTX_INFO(ctx).fault_info.inject_rate, 0, FAULT_RATE);
> +	if (ctx->spec_mask & F2FS_SPEC_fault_type)
> +		(void)f2fs_build_fault_attr(sbi, 0,
> +			F2FS_CTX_INFO(ctx).fault_info.inject_type, FAULT_TYPE);
> +#endif
> +	if (ctx->spec_mask & F2FS_SPEC_alloc_mode)
> +		F2FS_OPTION(sbi).alloc_mode = F2FS_CTX_INFO(ctx).alloc_mode;
> +	if (ctx->spec_mask & F2FS_SPEC_fsync_mode)
> +		F2FS_OPTION(sbi).fsync_mode = F2FS_CTX_INFO(ctx).fsync_mode;
> +	if (ctx->spec_mask & F2FS_SPEC_checkpoint_disable_cap)
> +		F2FS_OPTION(sbi).unusable_cap = F2FS_CTX_INFO(ctx).unusable_cap;
> +	if (ctx->spec_mask & F2FS_SPEC_checkpoint_disable_cap_perc)
> +		F2FS_OPTION(sbi).unusable_cap_perc =
> +					F2FS_CTX_INFO(ctx).unusable_cap_perc;
> +	if (ctx->spec_mask & F2FS_SPEC_discard_unit)
> +		F2FS_OPTION(sbi).discard_unit = F2FS_CTX_INFO(ctx).discard_unit;
> +	if (ctx->spec_mask & F2FS_SPEC_memory_mode)
> +		F2FS_OPTION(sbi).memory_mode = F2FS_CTX_INFO(ctx).memory_mode;
> +	if (ctx->spec_mask & F2FS_SPEC_errors)
> +		F2FS_OPTION(sbi).errors = F2FS_CTX_INFO(ctx).errors;
> +
> +	f2fs_apply_compression(fc, sb);
> +	f2fs_apply_test_dummy_encryption(fc, sb);
> +	f2fs_apply_quota_options(fc, sb);
>  }
>  
>  static struct inode *f2fs_alloc_inode(struct super_block *sb)
> @@ -2275,6 +2587,8 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
>  {
>  	struct f2fs_sb_info *sbi = F2FS_SB(sb);
>  	struct f2fs_mount_info org_mount_opt;
> +	struct f2fs_fs_context ctx;
> +	struct fs_context fc;
>  	unsigned long old_sb_flags;
>  	int err;
>  	bool need_restart_gc = false, need_stop_gc = false;
> @@ -2331,11 +2645,22 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
>  
>  	default_options(sbi, true);
>  
> +	memset(&fc, 0, sizeof(fc));
> +	memset(&ctx, 0, sizeof(ctx));
> +	fc.fs_private = &ctx;
> +	fc.purpose = FS_CONTEXT_FOR_RECONFIGURE;
> +
>  	/* parse mount options */
> -	err = parse_options(sbi, data, true);
> +	err = parse_options(&fc, data);
>  	if (err)
>  		goto restore_opts;
>  
> +	err = f2fs_check_opt_consistency(&fc, sb);
> +	if (err < 0)
> +		goto restore_opts;
> +
> +	f2fs_apply_options(&fc, sb);
> +
>  #ifdef CONFIG_BLK_DEV_ZONED
>  	if (f2fs_sb_has_blkzoned(sbi) &&
>  		sbi->max_open_zones < F2FS_OPTION(sbi).active_logs) {
> @@ -2346,11 +2671,6 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
>  		goto restore_opts;
>  	}
>  #endif
> -
> -	err = f2fs_validate_options(sbi);
> -	if (err)
> -		goto restore_opts;
> -
>  	/* flush outstanding errors before changing fs state */
>  	flush_work(&sbi->s_error_work);
>  
> @@ -4429,6 +4749,8 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
>  {
>  	struct f2fs_sb_info *sbi;
>  	struct f2fs_super_block *raw_super;
> +	struct f2fs_fs_context ctx;
> +	struct fs_context fc;
>  	struct inode *root;
>  	int err;
>  	bool skip_recovery = false, need_fsck = false;
> @@ -4445,6 +4767,9 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
>  	raw_super = NULL;
>  	valid_super_block = -1;
>  	recovery = 0;
> +	memset(&fc, 0, sizeof(fc));
> +	memset(&ctx, 0, sizeof(ctx));
> +	fc.fs_private = &ctx;
>  
>  	/* allocate memory for f2fs-specific super block info */
>  	sbi = kzalloc(sizeof(struct f2fs_sb_info), GFP_KERNEL);
> @@ -4502,14 +4827,16 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
>  		goto free_sb_buf;
>  	}
>  
> -	err = parse_options(sbi, options, false);
> +	err = parse_options(&fc, options);
>  	if (err)
>  		goto free_options;
>  
> -	err = f2fs_validate_options(sbi);
> -	if (err)
> +	err = f2fs_check_opt_consistency(&fc, sb);
> +	if (err < 0)
>  		goto free_options;
>  
> +	f2fs_apply_options(&fc, sb);
> +
>  	sb->s_maxbytes = max_file_blocks(NULL) <<
>  				le32_to_cpu(raw_super->log_blocksize);
>  	sb->s_max_links = F2FS_LINK_MAX;
> -- 
> 2.49.0

