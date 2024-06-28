Return-Path: <linux-fsdevel+bounces-22765-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E35991BE2E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 14:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D75ABB215E7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 12:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219F41581F3;
	Fri, 28 Jun 2024 12:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CbU51ils"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853461E492
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Jun 2024 12:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719576465; cv=none; b=B3DwiUh6StSejAbbiPwu+t+1pBxjeFYY2P32iJ/MonvdhYsjIZW9BYbBzMQqZ0Fns4olg9Dz8TgpdaovYfM7iTnk30ON9CFLmEqkKSpjTrz6a1pF/y6mMNYcV21lJd7olqCV0I++ltciwfG5zMqfpGyX0lkR4F2rkniGAPhABf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719576465; c=relaxed/simple;
	bh=HSA7KNwuOgFgdBwpj2N89PZHmysGsHODOY8ea91mjJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VCJnlVL8H9GP3OY7RHohp5qIUr6AKTaysO6GEY1I6WeI08q6+JsLQr011tYE2dQ0PRHDM4QJSQVbZQA2xxCSPR/heY1Y817YgYMBZaKXrZ1edGf7TMVvkxhVMmBVi94PMXmcjh10U6h64A4BYPVkZkEsoW4ICKvZnA/7XBy3Nig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CbU51ils; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 268DAC116B1;
	Fri, 28 Jun 2024 12:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719576465;
	bh=HSA7KNwuOgFgdBwpj2N89PZHmysGsHODOY8ea91mjJU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CbU51ilsNvzEGAhXvw/GsmORIf7pbG2OiXnO1q5Y84iNWf84Rt+0z8Otk/H1OsPdA
	 zI24EnJ24qF+HCCzb9zvCYFAdAk2bcIk+lZ3VdvlwdFpPoaipYxDqih8aJBQ1upML+
	 FnsS1M4UOv+rOCyJ4AKFDogjPep6gb1iBqxj0bdL7RpqDnQ1IiZRBkFDbsjQKefpi4
	 nhwEmy8rSp2TmsdPaLVTHJSszrYTp83bU/YhYEmNbXjwCRoOB3/sV5uwiA16Cetz7+
	 PRtavgRZiXMMr3wsYnraPz/YAGhbudhIlRe1EHujf1YD55UDJ8whG/Z5lL4c/krhMC
	 VObBN/tGybxTg==
Date: Fri, 28 Jun 2024 14:07:40 +0200
From: Christian Brauner <brauner@kernel.org>
To: Eric Sandeen <sandeen@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Miklos Greczi <mgreczi@redhat.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert <bschubert@ddn.com>, 
	Amir Goldstein <amir73il@gmail.com>, Seth Forshee <sforshee@kernel.org>
Subject: Re: [PATCH 07/14] fuse: Convert to new uid/gid option parsing helpers
Message-ID: <20240628-anbrechen-warnschilder-c8607ec1c881@brauner>
References: <8dca3c11-99f4-446d-a291-35c50ed2dc14@redhat.com>
 <02670c04-2449-443f-bf44-68c927685a1c@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <02670c04-2449-443f-bf44-68c927685a1c@redhat.com>

I think you accidently Cced the wrong Miklos. :)

On Thu, Jun 27, 2024 at 07:33:43PM GMT, Eric Sandeen wrote:
> Convert to new uid/gid option parsing helpers
> 
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> ---
>  fs/fuse/inode.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index 99e44ea7d875..1ac528bcdb3c 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -740,8 +740,8 @@ static const struct fs_parameter_spec fuse_fs_parameters[] = {
>  	fsparam_string	("source",		OPT_SOURCE),
>  	fsparam_u32	("fd",			OPT_FD),
>  	fsparam_u32oct	("rootmode",		OPT_ROOTMODE),
> -	fsparam_u32	("user_id",		OPT_USER_ID),
> -	fsparam_u32	("group_id",		OPT_GROUP_ID),
> +	fsparam_uid	("user_id",		OPT_USER_ID),
> +	fsparam_gid	("group_id",		OPT_GROUP_ID),
>  	fsparam_flag	("default_permissions",	OPT_DEFAULT_PERMISSIONS),
>  	fsparam_flag	("allow_other",		OPT_ALLOW_OTHER),
>  	fsparam_u32	("max_read",		OPT_MAX_READ),
> @@ -799,16 +799,12 @@ static int fuse_parse_param(struct fs_context *fsc, struct fs_parameter *param)
>  		break;
>  
>  	case OPT_USER_ID:
> -		ctx->user_id = make_kuid(fsc->user_ns, result.uint_32);
> -		if (!uid_valid(ctx->user_id))
> -			return invalfc(fsc, "Invalid user_id");
> +		ctx->user_id = result.uid;

So fsc->user_ns will record the namespaces at fsopen() time which can be
different from the namespace used at fsconfig() time. This was done when
fuse was ported to the new mount api.

It has the same potential issues that Seth pointed out so I think your
patch is correct. But I also think we might need the same verification
that tmpfs is doing to verify that the uid/gid we're using can actually
be represented in the fsc->user_ns.

So maybe there should be a separate patch that converts fuse to rely on
make_k*id(current_user_ns()) + k*id_has_mapping() and then these patches
on top?

