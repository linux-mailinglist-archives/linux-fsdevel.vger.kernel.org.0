Return-Path: <linux-fsdevel+bounces-28944-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7807A971A2C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2024 14:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3FF01C21B53
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2024 12:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 951D11B86DD;
	Mon,  9 Sep 2024 12:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h9itpF9e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC511B790E;
	Mon,  9 Sep 2024 12:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725886672; cv=none; b=Zzjsl8+ER+9yiUMzHBslYatO2BKjenEGz8VIaLQJPCRfITO5OcvGlh7avbV2Ae/NZ3IryLYVG2+TT/CIqmzW566QYPTybtmnkl+yKYkCfJmU8UsV3ZEOjwihTYNMjNmxoRc/0na6gxEeHuJH2Uq7/mFY4tNCnxr7+cHJXkFkr3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725886672; c=relaxed/simple;
	bh=PpiHwLihXlv9slsWWgeRNxz0ygIyTVN9UC/5LY/o5to=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SDjlaHgpIyzO1p4v/1oneQJOeLYGAuAuJo9XPTG7xNATYsJPDGr4RwMi/LEn6QLTESxq7rF3uUluZmBWu79ZAqEfK+lmuJOQY6fcqTY/lUGeTUtcUvMM88TMppSIGvw8z1lxLmt2qxe5Elu6++vWnUogH44ZbQjP6WOp8j/Wgyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h9itpF9e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F2F5C4CEC5;
	Mon,  9 Sep 2024 12:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725886671;
	bh=PpiHwLihXlv9slsWWgeRNxz0ygIyTVN9UC/5LY/o5to=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h9itpF9eKDSVTEj3CvndqUuJ8B6HMYvbXR5TLMJNSSglt08VMn+4Cv1NdOQ5DxHYt
	 PLThoiEOtq6BllsEhvSWLaPV2+r4dM6KNBreqAlbJPOhbT7q1HYj0paEYIeeOUN9Ma
	 pP8f3e3jpptQ4TWVzvFy/UpzmmZjHQdhXXH287CmNL3AqO52SrnW6qhDN40u8b64mL
	 xmQrkiHDFpok7QlylQm1SwyYyeNgTRUYrkFqviLMcjbg4ZIALKuBrNGTX7lkGz0498
	 UzjS27PD2DSz5CwGAPQDZQC7+qjGXZM9o7Tn+hszOcupeD08QBNtgeIoB6oFRadjUI
	 Yirb9yONGo7vw==
Date: Mon, 9 Sep 2024 14:57:46 +0200
From: Christian Brauner <brauner@kernel.org>
To: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc: mszeredi@redhat.com, linux-fsdevel@vger.kernel.org, 
	Miklos Szeredi <miklos@szeredi.hu>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Seth Forshee <sforshee@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/3] fs/mnt_idmapping: introduce an invalid_mnt_idmap
Message-ID: <20240909-moosbedeckt-landnahme-61cecf06e530@brauner>
References: <20240906143453.179506-1-aleksandr.mikhalitsyn@canonical.com>
 <20240906143453.179506-2-aleksandr.mikhalitsyn@canonical.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240906143453.179506-2-aleksandr.mikhalitsyn@canonical.com>

On Fri, Sep 06, 2024 at 04:34:52PM GMT, Alexander Mikhalitsyn wrote:
> Link: https://lore.kernel.org/linux-fsdevel/20240904-baugrube-erhoben-b3c1c49a2645@brauner/
> Suggested-by: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
> ---
>  fs/mnt_idmapping.c            | 22 ++++++++++++++++++++--
>  include/linux/mnt_idmapping.h |  1 +
>  2 files changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/mnt_idmapping.c b/fs/mnt_idmapping.c
> index 3c60f1eaca61..cbca6500848e 100644
> --- a/fs/mnt_idmapping.c
> +++ b/fs/mnt_idmapping.c
> @@ -32,6 +32,15 @@ struct mnt_idmap nop_mnt_idmap = {
>  };
>  EXPORT_SYMBOL_GPL(nop_mnt_idmap);
>  
> +/*
> + * Carries the invalid idmapping of a full 0-4294967295 {g,u}id range.
> + * This means that all {g,u}ids are mapped to INVALID_VFS{G,U}ID.
> + */
> +struct mnt_idmap invalid_mnt_idmap = {
> +	.count	= REFCOUNT_INIT(1),
> +};
> +EXPORT_SYMBOL_GPL(invalid_mnt_idmap);
> +
>  /**
>   * initial_idmapping - check whether this is the initial mapping
>   * @ns: idmapping to check
> @@ -75,6 +84,8 @@ vfsuid_t make_vfsuid(struct mnt_idmap *idmap,
>  
>  	if (idmap == &nop_mnt_idmap)
>  		return VFSUIDT_INIT(kuid);
> +	if (idmap == &invalid_mnt_idmap)
> +		return INVALID_VFSUID;

Could possibly deserve an:

if (unlikely(idmap == &invalid_mnt_idmap))
	return INVALID_VFSUID;

and technically I guess we could also do:

if (likely(idmap == &nop_mnt_idmap))
	return VFSUIDT_INIT(kuid);

but not that relevant for this patch.

