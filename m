Return-Path: <linux-fsdevel+bounces-37814-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E3A9F7EBA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 17:01:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F46B1893449
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 15:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE3E227596;
	Thu, 19 Dec 2024 15:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tpze9uOM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA88313790B;
	Thu, 19 Dec 2024 15:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734623835; cv=none; b=EJt41PTlIeYXf37ZXjzDKYOgk/ujCW3xfRJ9enUfMn/yUoFmAyAmxmfW1qjU5NQt2LFv7cH2iQZoC3vTcXiJdlNxRuaKeH1Co8MFMroIMbxSF6qkRtcVjYk7PvDlDKDOo44czaODQh8yV4JVfIytKS16i/bcCqO3opcoe9JZLkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734623835; c=relaxed/simple;
	bh=x75Sk0MmnY8xdkcTY4bDbEHtKGN/QZvOM5AK+ZIPqC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h+L3SAPxAgmVQc4E4x86ddqTvDDx6oiU1YYnMKuQAuzFtbAZO9Lh31ChSB/zqGD1ygWqomqYp3FrfAhqQR7KDCQSu0r801hoDapJ2y/Tmv8JWzlUbysIvNebsgDblGcstyFHYj0dTjTxNG3CbVk76QxS5SoYn4NE9afhFb+SmTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tpze9uOM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BA0EC4CED0;
	Thu, 19 Dec 2024 15:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734623835;
	bh=x75Sk0MmnY8xdkcTY4bDbEHtKGN/QZvOM5AK+ZIPqC8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tpze9uOMfiaXl3ad7AwJdtoNUV7BwXMaaF9xrqPmd8rtxulPcaNwaznauVopsw95W
	 Xf2HGGidnv8jxGFCyo9/7Rb5roR27ABfsV+xXNrjjYEl4Ee4yz1WyYibxWtyRnOES9
	 dVNgIhppVbHgRJxBr9XZteZ09p9SC+rbBW5PPYnpANLpQ16FI+g489SBqe6JiSc43N
	 IIO1VyzJbtHWe6/dAch0ugVXNHJMIu+rLRou/IJ+kvuBXtlw0ouRCtEjgjKcy3pOa4
	 eOCtMTW4oMwH1uiaB6DV3xQX5TXQlFwKBIh6SehrOuOwi8ABQL3g8e27935XUxFxZp
	 aNQoX9Ui4s1Ew==
Date: Thu, 19 Dec 2024 07:57:14 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
	Ritesh Harjani <ritesh.list@gmail.com>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Andrey Albershteyn <aalbersh@kernel.org>
Subject: Re: [PATCH v2 3/3] xfs_io: add extsize command support
Message-ID: <20241219155714.GH6174@frogsfrogsfrogs>
References: <cover.1734611784.git.ojaswin@linux.ibm.com>
 <931b3f0da15da34cfd9d6460e930ce301e721cf5.1734611784.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <931b3f0da15da34cfd9d6460e930ce301e721cf5.1734611784.git.ojaswin@linux.ibm.com>

On Thu, Dec 19, 2024 at 06:09:15PM +0530, Ojaswin Mujoo wrote:
> extsize command is currently only supported with XFS filesystem.
> Lift this restriction now that ext4 is also supporting extsize hints.
> 
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  io/open.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/io/open.c b/io/open.c
> index a30dd89a1fd5..2582ff9b862e 100644
> --- a/io/open.c
> +++ b/io/open.c
> @@ -997,7 +997,7 @@ open_init(void)
>  	extsize_cmd.args = _("[-D | -R] [extsize]");
>  	extsize_cmd.argmin = 0;
>  	extsize_cmd.argmax = -1;
> -	extsize_cmd.flags = CMD_NOMAP_OK;
> +	extsize_cmd.flags = CMD_NOMAP_OK | CMD_FOREIGN_OK;
>  	extsize_cmd.oneline =
>  		_("get/set preferred extent size (in bytes) for the open file");
>  	extsize_cmd.help = extsize_help;
> -- 
> 2.43.5
> 
> 

