Return-Path: <linux-fsdevel+bounces-22996-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D809252E9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 07:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B74A31F25CE0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 05:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856C43A1B5;
	Wed,  3 Jul 2024 05:20:19 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D002AF17
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jul 2024 05:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.171.160.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719984019; cv=none; b=XRLEnBMeGb2puuEGPFHK0NKH8K4gcx2ND9iIVWPioeffCJwvRPb1Ki7T33Y/atiQ9Grg2WLgvQboTOgLhF9Q/jsveZtYhPzuBz2nvlm13Qem4DmUE3MCfO3zTY6Nowqwl8AQmmlFh/OUvBGUC8sHk/l77b+TCERw95W39aKvKm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719984019; c=relaxed/simple;
	bh=tZ1ZfxXHHylDXONNQkekAbq1SYIiwNlCvmPGnj0bCJg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Bbp3zuSOm5kZt2qcRFH7Y9m20xq0Em9YTZlJrCSna05rlCQ2HWfDZsIEOC2rspFxfbluzVCzIAPx8LSHtxHBbqbBoIjFAn4Ee5sQtu5xlBXnlh2Ua6PJ90TacI1hqWJR6yHksXvPGWQgeVDBSYXOFrQgbxz0GegQ/PJ1kLwsWTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mail.parknet.co.jp; spf=pass smtp.mailfrom=parknet.co.jp; arc=none smtp.client-ip=210.171.160.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id 03FD72055FA2;
	Wed,  3 Jul 2024 14:20:16 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (8.18.1/8.18.1/Debian-4) with ESMTPS id 4635KElX114164
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 3 Jul 2024 14:20:15 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
	by devron.myhome.or.jp (8.18.1/8.18.1/Debian-4) with ESMTPS id 4635KE8P681176
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 3 Jul 2024 14:20:14 +0900
Received: (from hirofumi@localhost)
	by devron.myhome.or.jp (8.18.1/8.18.1/Submit) id 4635KEag681175;
	Wed, 3 Jul 2024 14:20:14 +0900
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: Eric Sandeen <sandeen@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-fsdevel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH V2 3/3] fat: Convert to new uid/gid option parsing helpers
In-Reply-To: <1a67d2a8-0aae-42a2-9c0f-21cd4cd87d13@redhat.com> (Eric Sandeen's
	message of "Tue, 2 Jul 2024 17:45:57 -0500")
References: <ec599fc8-b32e-48cf-ac6c-09ded36468d5@redhat.com>
	<1a67d2a8-0aae-42a2-9c0f-21cd4cd87d13@redhat.com>
Date: Wed, 03 Jul 2024 14:20:14 +0900
Message-ID: <87a5izrr01.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Eric Sandeen <sandeen@redhat.com> writes:

> Convert to new uid/gid option parsing helpers
>
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>

Looks good.

Acked-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

Thanks.

> ---
>  fs/fat/inode.c | 16 ++++------------
>  1 file changed, 4 insertions(+), 12 deletions(-)
>
> diff --git a/fs/fat/inode.c b/fs/fat/inode.c
> index b83b39f2f69b..8fbf5edb7aa2 100644
> --- a/fs/fat/inode.c
> +++ b/fs/fat/inode.c
> @@ -1091,8 +1091,8 @@ static const struct constant_table fat_param_conv[] = {
>  /* Core options. See below for vfat and msdos extras */
>  const struct fs_parameter_spec fat_param_spec[] = {
>  	fsparam_enum	("check",	Opt_check, fat_param_check),
> -	fsparam_u32	("uid",		Opt_uid),
> -	fsparam_u32	("gid",		Opt_gid),
> +	fsparam_uid	("uid",		Opt_uid),
> +	fsparam_gid	("gid",		Opt_gid),
>  	fsparam_u32oct	("umask",	Opt_umask),
>  	fsparam_u32oct	("dmask",	Opt_dmask),
>  	fsparam_u32oct	("fmask",	Opt_fmask),
> @@ -1161,8 +1161,6 @@ int fat_parse_param(struct fs_context *fc, struct fs_parameter *param,
>  	struct fat_mount_options *opts = fc->fs_private;
>  	struct fs_parse_result result;
>  	int opt;
> -	kuid_t uid;
> -	kgid_t gid;
>  
>  	/* remount options have traditionally been ignored */
>  	if (fc->purpose == FS_CONTEXT_FOR_RECONFIGURE)
> @@ -1209,16 +1207,10 @@ int fat_parse_param(struct fs_context *fc, struct fs_parameter *param,
>  		opts->sys_immutable = 1;
>  		break;
>  	case Opt_uid:
> -		uid = make_kuid(current_user_ns(), result.uint_32);
> -		if (!uid_valid(uid))
> -			return -EINVAL;
> -		opts->fs_uid = uid;
> +		opts->fs_uid = result.uid;
>  		break;
>  	case Opt_gid:
> -		gid = make_kgid(current_user_ns(), result.uint_32);
> -		if (!gid_valid(gid))
> -			return -EINVAL;
> -		opts->fs_gid = gid;
> +		opts->fs_gid = result.gid;
>  		break;
>  	case Opt_umask:
>  		opts->fs_fmask = opts->fs_dmask = result.uint_32;

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

