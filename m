Return-Path: <linux-fsdevel+bounces-17675-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E208B1539
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 23:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C01FF286982
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 21:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A6A156F53;
	Wed, 24 Apr 2024 21:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OT+P+jg9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A51156999;
	Wed, 24 Apr 2024 21:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713994621; cv=none; b=mTEhFE10tuTarqAE60N6QQinFbOG3ZQuwUsdzhV3j09UyClqAsyzFqJY+D1RwpVVsFSVuiuvbJ+WJ5RVPLbjuDpAW0/ZIouT7cVqnXF6qjUVywh99M+fyTMdT7GL+k3qWoj3wznH6z0XTGhN5R8bvxZRpxoHaGSsNM2LigK29ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713994621; c=relaxed/simple;
	bh=7qb4LXozbyMPgn/1IfNvPYSuXPSN45HfNNC51nvCwMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XhzUld1Vkib+ED16Ykjr/JHqw87LuLGCz5XxMv4Oe+7iXp3G+Ro2mW18P5gO7jvpLll8PLdj/Unt1IFs8FdMd9DWaMjLyD1apr3fPqDwbspLBcewL7h5Ly5QIZVpPgheRXCHMv+dIAIFylz5F8p74UxRKLKCsYUIP+k8n+LKy5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OT+P+jg9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F1B2C113CD;
	Wed, 24 Apr 2024 21:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713994620;
	bh=7qb4LXozbyMPgn/1IfNvPYSuXPSN45HfNNC51nvCwMs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OT+P+jg9d4QnFqAVGx4ycqm+qIBnPALRXFWJoXSVXvLxEDIeMBiZ5uPf2BtGo/MRF
	 l6KoKR5ZixVQzaWCX3kz5dJItO8QarnqDDCf7jBIbvpc8t+OB2ATKfnSYRvIP6Hq3U
	 T1r//uwvwr8xY7W9vpPj5r7imNePGB2cZPM7ZiVi32I12R2u2C9aLHBQ+mntvFciLC
	 vY2Ul/HHvb6Wy3qizInp49LBqdcA6cGCKWSjAGhQwKgtXZNF4LIAK0N0cF8KNkO6/T
	 yvInrrIOq7zFOTYr90KdbCo22cBSKmUYLdESdvPaHx9RnzWyKyAxYMB73fUwheFW0w
	 2nr9fYlEW0voA==
Date: Wed, 24 Apr 2024 14:36:59 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: aalbersh@redhat.com, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, fsverity@lists.linux.dev
Subject: Re: [PATCH 07/13] fsverity: pass the new tree size and block size to
 ->begin_enable_verity
Message-ID: <20240424213659.GQ360919@frogsfrogsfrogs>
References: <171175867829.1987804.15934006844321506283.stgit@frogsfrogsfrogs>
 <171175867981.1987804.2143506550606185399.stgit@frogsfrogsfrogs>
 <20240405024609.GE1958@quark.localdomain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405024609.GE1958@quark.localdomain>

On Thu, Apr 04, 2024 at 10:46:09PM -0400, Eric Biggers wrote:
> On Fri, Mar 29, 2024 at 05:34:30PM -0700, Darrick J. Wong wrote:
> > diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
> > index 52de58d6f021f..030d7094d80fc 100644
> > --- a/include/linux/fsverity.h
> > +++ b/include/linux/fsverity.h
> > @@ -82,6 +82,8 @@ struct fsverity_operations {
> >  	 * Begin enabling verity on the given file.
> >  	 *
> >  	 * @filp: a readonly file descriptor for the file
> > +	 * @merkle_tree_size: total bytes the new Merkle tree will take up
> > +	 * @tree_blocksize: the new Merkle tree block size
> 
> "new Merkle tree block size" is confusing because there's no old Merkle tree
> block size here.  Maybe delete "new" from the above two lines.

Done.

--D

> - Eric
> 

