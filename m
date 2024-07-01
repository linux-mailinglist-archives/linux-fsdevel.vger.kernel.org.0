Return-Path: <linux-fsdevel+bounces-22884-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F93D91E213
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2024 16:15:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD050B2130B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2024 14:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72E9914387C;
	Mon,  1 Jul 2024 14:15:20 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40EA68C1D
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Jul 2024 14:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.171.160.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719843320; cv=none; b=Zs7mIVAg1mX5W2RvbLwFI0tfC7OaPWsY2gbECEE1CigatCjRxI/AxQkDyVt15GcJa+34RTpNmbvvWjXiXJzNH9sIf47SISXHiq8VLRZJkIge99/8bMLewnUcApxUDQTZEIpb5LReyQxwLk8ySLHE9boyr7DJiJV6ewra5fL0QTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719843320; c=relaxed/simple;
	bh=m66dDn7BsICYftZ3beou+Az/7jb+v+63vXv6k/GKHQw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DVxubc2yhH4TdaKdbgD9KsDikxcC4oHHcjw0M7Lv5A/z06DdE0frAds1ZjG0iN8MoO+gVH6hVmKbCpZ+qq7IGmRqleXY6LaMsCp1uT1vGwOoYtHfafpFpxl6tlKZOfXo+nG7iR9NlatOQM/b64U7KLvA2OsDTsNa0CzTzI4JDdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mail.parknet.co.jp; spf=pass smtp.mailfrom=parknet.co.jp; arc=none smtp.client-ip=210.171.160.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id E9B902055FA5;
	Mon,  1 Jul 2024 23:15:09 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (8.18.1/8.18.1/Debian-4) with ESMTPS id 461EF8Pm037657
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 1 Jul 2024 23:15:09 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
	by devron.myhome.or.jp (8.18.1/8.18.1/Debian-4) with ESMTPS id 461EF8PB224360
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 1 Jul 2024 23:15:08 +0900
Received: (from hirofumi@localhost)
	by devron.myhome.or.jp (8.18.1/8.18.1/Submit) id 461EF8Tn224359;
	Mon, 1 Jul 2024 23:15:08 +0900
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: Eric Sandeen <sandeen@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH 2/2 V2] fat: Convert to new mount api
In-Reply-To: <72d3f126-ac1c-46d3-b346-6e941f377e1e@redhat.com> (Eric Sandeen's
	message of "Sat, 29 Jun 2024 13:02:48 -0500")
References: <fe6baab2-a7a0-4fb0-9b94-17c58f73ed62@redhat.com>
	<2509d003-7153-4ce3-8a04-bc0e1f00a1d5@redhat.com>
	<72d3f126-ac1c-46d3-b346-6e941f377e1e@redhat.com>
Date: Mon, 01 Jul 2024 23:15:08 +0900
Message-ID: <87v81p8ahf.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Eric Sandeen <sandeen@redhat.com> writes:

[...]

> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> ---
>
> V2: Ignore all options during remount via
>
> 	if (fc->purpose == FS_CONTEXT_FOR_RECONFIGURE)
> 		return 0;

Thanks, basically looks good. However I tested a bit and found a bug,
and small comments.

> +extern const struct fs_parameter_spec fat_param_spec[];
> +extern int fat_init_fs_context(struct fs_context *fc, bool is_vfat);
> +extern void fat_free_fc(struct fs_context *fc);
> +
> +int fat_parse_param(struct fs_context *fc, struct fs_parameter *param,
> +		    int is_vfat);
> +extern int fat_reconfigure(struct fs_context *fc);

Let's remove extern from new one.

> +int fat_parse_param(struct fs_context *fc, struct fs_parameter *param,
> +			   int is_vfat)

Maybe better to use bool (and true/false) instead of int for is_vfat?

> +{
> +	struct fat_mount_options *opts = fc->fs_private;
> +	struct fs_parse_result result;
> +	int opt;
> +	char buf[50];

[...]	

> +	case Opt_codepage:
> +		sprintf(buf, "cp%d", result.uint_32);

"buf" is unused.

> +	/* obsolete mount options */
> +	case Opt_obsolete:
> +		infof(fc, "\"%s\" option is obsolete, not supported now",
> +		      param->key);
> +		break;

I'm not sure though, "Opt_obsolete" should use fs_param_deprecated?

> +	default:
> +		return -EINVAL;

I'm not sure though, "default:" should not happen anymore?

>  	}
>  
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(fat_parse_param);

[...]

> +	/* If user doesn't specify allow_utime, it's initialized from dmask. */
> +	if (opts->allow_utime == (unsigned short)-1)
> +		opts->allow_utime = ~opts->fs_dmask & (S_IWGRP | S_IWOTH);
> +	if (opts->unicode_xlate)
> +		opts->utf8 = 0;

Probably, this should move to fat_parse_param()?

> +	/* Apply pparsed options to sbi */
> +	sbi->options = *opts;

	/* Transfer ownership of iocharset to sbi->options */
	opts->iocharset = NULL;
	opts = &sbi->options;

opts->iocharset is freed by both of opts and sbi->options, we should fix
it like above or such.

> -	sprintf(buf, "cp%d", sbi->options.codepage);
> +	sprintf(buf, "cp%d", opts->codepage);

[...]

>  	/* FIXME: utf8 is using iocharset for upper/lower conversion */
>  	if (sbi->options.isvfat) {
> -		sbi->nls_io = load_nls(sbi->options.iocharset);
> +		sbi->nls_io = load_nls(opts->iocharset);
>  		if (!sbi->nls_io) {
>  			fat_msg(sb, KERN_ERR, "IO charset %s not found",
> -			       sbi->options.iocharset);
> +			       opts->iocharset);
>  			goto out_fail;

Revert above to remove opts usage to not touch after ownership transfer
if we fix the bug like that way.

> +static int msdos_parse_param(struct fs_context *fc, struct fs_parameter *param)
> +{
> +	return fat_parse_param(fc, param, 0);

If we changed int to bool, 0 to false.

> +static int msdos_init_fs_context(struct fs_context *fc)
> +{
> +	int err;
> +
> +	/* Initialize with isvfat == 0 */
> +	err = fat_init_fs_context(fc, 0);

If we changed int to bool, 0 to false.

> +static int vfat_parse_param(struct fs_context *fc, struct fs_parameter *param)
> +{
> +	return fat_parse_param(fc, param, 1);

If we changed int to bool, 0 to true.

> +static int vfat_init_fs_context(struct fs_context *fc)
> +{
> +	int err;
> +
> +	/* Initialize with isvfat == 1 */
> +	err = fat_init_fs_context(fc, 1);

If we changed int to bool, 0 to true.

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

