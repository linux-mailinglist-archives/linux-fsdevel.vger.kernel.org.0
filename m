Return-Path: <linux-fsdevel+bounces-13278-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 305F686E256
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 14:37:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B9861C22AC0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 13:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2946E2B8;
	Fri,  1 Mar 2024 13:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j+kxOS53"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C1F40BE2;
	Fri,  1 Mar 2024 13:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709300251; cv=none; b=San5p1Slr3WD7Va+MtH/tM3yR0K4w0zTbmvGfKRdkwNK021fQ38P6uXeDOT4SACWQwzBxvmELhS8nKTWBnBhFWQqSFW32mUYsUfuron/uNFLd6pkpv+DmlZBII1CFcrOPHtVoMTQdCl6NtSPOgmmEJ306nm+KqxvkBkJWJpmNxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709300251; c=relaxed/simple;
	bh=QG08rg0nOQvqkILqz7tYSRnoJ1btB5O9gNJcwb46kLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EmEU86Q8vU8iPk2Z/WOwGTDaJ3NX3Ar1PCtoa1zoju9gb7utujBNTm2VHrJW0IT7r1vset1ZmJICmaJCrNNJEARZ1H35v+orAISFiLLGGott73CyvwSS39aQ/zZzXL1F6a2R0atrqbipREJia5qZYv9/7mZ463whIGY+lF3emjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j+kxOS53; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C287C43390;
	Fri,  1 Mar 2024 13:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709300251;
	bh=QG08rg0nOQvqkILqz7tYSRnoJ1btB5O9gNJcwb46kLE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j+kxOS53MeWl4dNYvaQGX4EEkC0dApluEgkRG9uW94Celznuv0Dgkx8r7m7q2RjCg
	 5GQYFxPWeZZ3dzTuRaNa//Kf8rCFf2GuAG5WFPEanVuDl/6/9BmI9fa2ug9j0Gqb49
	 YC9n/mpNTGTUZ0z3JdGj99XlCdZnmEhdX+FkLPSJzoGQwLnpwm4AmrQBrAx+NMHsz2
	 j6C62XCQEqt8/pRU2HUHwKW2D+FXqKTK53tdfPTx40zPpETxcd+TZssj5IyjSLKFgA
	 YqacQkjIXIeP7WVppaX2MgTBcfRijMdqOMhXDalRG5HHdLS0MEtsI3xkwO7lqB2Lro
	 GYDQJ6uK8No2g==
Date: Fri, 1 Mar 2024 14:37:25 +0100
From: Christian Brauner <brauner@kernel.org>
To: Luis Henriques <lhenriques@suse.de>
Cc: Theodore Ts'o <tytso@mit.edu>, 
	Andreas Dilger <adilger.kernel@dilger.ca>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Miklos Szeredi <miklos@szeredi.hu>, 
	Amir Goldstein <amir73il@gmail.com>, linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] overlay: fix mount parameters check for empty values
Message-ID: <20240301-stehplatz-globus-0707fafe22fb@brauner>
References: <20240229163011.16248-1-lhenriques@suse.de>
 <20240229163011.16248-4-lhenriques@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240229163011.16248-4-lhenriques@suse.de>

On Thu, Feb 29, 2024 at 04:30:10PM +0000, Luis Henriques wrote:
> Now that parameters that have the flag 'fs_param_can_be_empty' set and
> their value is NULL are handled as 'flag' type, we need to properly check
> for empty (NULL) values.
> 
> Signed-off-by: Luis Henriques <lhenriques@suse.de>
> ---
>  fs/overlayfs/params.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/overlayfs/params.c b/fs/overlayfs/params.c
> index 112b4b12f825..09428af6abc5 100644
> --- a/fs/overlayfs/params.c
> +++ b/fs/overlayfs/params.c
> @@ -441,7 +441,7 @@ static int ovl_parse_param_lowerdir(const char *name, struct fs_context *fc)
>  	/* drop all existing lower layers */
>  	ovl_reset_lowerdirs(ctx);
>  
> -	if (!*name)
> +	if (!name)

Same comment/qestion as on ext4 patch.

