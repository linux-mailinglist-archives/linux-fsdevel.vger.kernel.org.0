Return-Path: <linux-fsdevel+bounces-13561-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11082871026
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 23:35:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A67631F21BDA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 22:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FDC07BAF3;
	Mon,  4 Mar 2024 22:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DpicgEza"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D4E1E4A2;
	Mon,  4 Mar 2024 22:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709591750; cv=none; b=i9kQu+OPgqMPlwF4rWZby/sUGEI46j7+PAWKrV7MNk8GgXqz5xq2IDEb69nHpu/q4Ecwa65S457ypRlT7R98g8C77V952McpXr88kDz12zNadtnXH4t/NBR1+Xgtijkd8giFDAMXuo4XyiJmZ5u6qwUMstg++XHLJimfGW0BoJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709591750; c=relaxed/simple;
	bh=bJ7MCr9foOX1eS/Ku0VOOBEyDi7t7HkcEOn41y2Nxew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E8p85TEyqOBWZVlhTHN6cvuwVM1e6aN8f1enfdNBdiWgqXpGdzqC9hTHf+qqJHbdEcoaLLV3fKTemU8gMmjFIh69VAOvXPfUULJyxuVZOMvYByOuPzCLDqkwdMySFwXMob3zYFiHz6Y4/3RCdMBd1daOZrG9iUflwjdiceB5kgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DpicgEza; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22B23C433F1;
	Mon,  4 Mar 2024 22:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709591750;
	bh=bJ7MCr9foOX1eS/Ku0VOOBEyDi7t7HkcEOn41y2Nxew=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DpicgEzage9AzzyTIn16VX41jDSUeN6e4urq512vCgO00qoUaBhTPgHf0N5mQmwm6
	 b48CR03EiaK9bcMHguLYmuZi6N8Z7KoIxkvOqb72nkLQ20kMbqmYdWKwb79l2vUqsW
	 S/fQPWRIxiFcG1xYcPbZt73PsyOmbw56QHbp4QyYx4/QNa3jmuJ1kvLBsSPNsMFSLn
	 kpYy64/18g5+JISyd/b5a1gPch4zscSIuNcwtnpGgaydov9BTbn2qQXlPP96aIbYPo
	 N3vokCIEZeOSZQ3jdpqyJ5obxRyzVYiUBf1zdbEr+0jRYAf29kmaPDGpVm7qnng1ru
	 sSggWRnRhu1aQ==
Date: Mon, 4 Mar 2024 14:35:48 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, chandan.babu@oracle.com,
	djwong@kernel.org
Subject: Re: [PATCH v5 05/24] fs: add FS_XFLAG_VERITY for verity files
Message-ID: <20240304223548.GB17145@sol.localdomain>
References: <20240304191046.157464-2-aalbersh@redhat.com>
 <20240304191046.157464-7-aalbersh@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304191046.157464-7-aalbersh@redhat.com>

On Mon, Mar 04, 2024 at 08:10:28PM +0100, Andrey Albershteyn wrote:
> @@ -641,6 +645,13 @@ static int fileattr_set_prepare(struct inode *inode,
>  	    !(S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode)))
>  		return -EINVAL;
>  
> +	/*
> +	 * Verity cannot be set through FS_IOC_FSSETXATTR/FS_IOC_SETFLAGS.
> +	 * See FS_IOC_ENABLE_VERITY
> +	 */
> +	if (fa->fsx_xflags & FS_XFLAG_VERITY)
> +		return -EINVAL;

This makes FS_IOC_SETFLAGS and FS_IOC_FSSETXATTR start failing on files that
already have verity enabled.

An error should only be returned when the new flags contain verity and the old
flags don't.

- Eric

