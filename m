Return-Path: <linux-fsdevel+bounces-13678-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34075872E29
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 06:01:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBF49B25591
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 05:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8EEB17BB9;
	Wed,  6 Mar 2024 05:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UpxJ7Pfe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6E75381;
	Wed,  6 Mar 2024 05:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709701281; cv=none; b=WZxMpRYNDAp5epKaDD045nBw6v/aQpMJelwdYI2zRfTETs1d6TN5P+nSbNMTKrFKqJNpBMEiYudYCtyp2Js8b0b7S4BU4IGyNDBsY803tUyrFByLLLizQVVfs7Ae02BDep4FFJjnhpvyFAzJpNR3nwjn3UtUYRs3SkDNCVTZqLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709701281; c=relaxed/simple;
	bh=v4I57+kN832FV9McH2if26mI6NZU7n2LdcVNv2OU8bM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Im8dMpWjIPGP/szFVrVJXxoUoXKFPMiGPJoyNt5TZLqCtuU80/XWLrA9+a5gzccjAKxQyVc1i7010kBc+8wBub4Q2oNCzsgq5IxAGeBlZBQUmNyuit7+ZuX+FAloysX4VEPbC1BRM0vHEyZsbFnGl9GBQQnQtjr0fIeqcCleFb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UpxJ7Pfe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53B6DC433C7;
	Wed,  6 Mar 2024 05:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709701280;
	bh=v4I57+kN832FV9McH2if26mI6NZU7n2LdcVNv2OU8bM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UpxJ7Pfe6wWLXViu+voobSLZc73ODFab/ZdkaBhRUspXcjA7gHhZI71vanHOUiauQ
	 Vdi+XvnIMGQ+Ll+U5Q9eYZsF5NTEfTZ1RTG4WO/nz8UfMRhrvw844FAze9PpRghLPv
	 wGM7d5uukFGkSquHJ81j1wVopX+stMuDnWWTXICo2vIPFdonrkqEP5uIJxLMjg3Lvt
	 4WwfbyviJBui0943aqLJcD/lYhDbL1Le1FXMuzm5uCHx62S4lHbpmQPJkAQtlgQZKv
	 bmHoP90kmo/metpRHAjgTl6lQSVZqUmFqf3xOvzDpinLNkrUdjD0vvt43aLsED9GFS
	 r/IZuXronz/yw==
Date: Tue, 5 Mar 2024 21:01:18 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, chandan.babu@oracle.com,
	djwong@kernel.org
Subject: Re: [PATCH v5 21/24] xfs: add fs-verity support
Message-ID: <20240306050118.GD68962@sol.localdomain>
References: <20240304191046.157464-2-aalbersh@redhat.com>
 <20240304191046.157464-23-aalbersh@redhat.com>
 <20240306045543.GC68962@sol.localdomain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306045543.GC68962@sol.localdomain>

On Tue, Mar 05, 2024 at 08:55:43PM -0800, Eric Biggers wrote:
> On Mon, Mar 04, 2024 at 08:10:44PM +0100, Andrey Albershteyn wrote:
> > +static void
> > +xfs_verity_put_listent(
> > +	struct xfs_attr_list_context	*context,
> > +	int				flags,
> > +	unsigned char			*name,
> > +	int				namelen,
> > +	int				valuelen)
> > +{
> > +	struct fsverity_blockbuf	block = {
> > +		.offset = xfs_fsverity_name_to_block_offset(name),
> > +		.size = valuelen,
> > +	};
> > +	/*
> > +	 * Verity descriptor is smaller than 1024; verity block min size is
> > +	 * 1024. Exclude verity descriptor
> > +	 */
> > +	if (valuelen < 1024)
> > +		return;
> > +
> 
> Is there no way to directly check whether it's the verity descriptor?  The
> 'valuelen < 1024' check is fragile because it will break if support for smaller
> Merkle tree block sizes is ever added.  (Silently, because this is doing
> invalidation which is hard to test and we need to be super careful with.)
> 
> If you really must introduce the assumption that the Merkle tree block size is
> at least 1024, this needs to be documented in the comment in
> fsverity_init_merkle_tree_params() that explains the reasoning behind the
> current restrictions on the Merkle tree block size.

Also, the verity descriptor can be >= 1024 bytes if there is a large builtin
signature attached to it.

- Eric

