Return-Path: <linux-fsdevel+bounces-17686-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F798B180E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 02:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3DA528ACB8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 00:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DABC017FE;
	Thu, 25 Apr 2024 00:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WGTfPJmQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404B97EF;
	Thu, 25 Apr 2024 00:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714005013; cv=none; b=VTcGxC8LJCLIxK3T0vEYW1mittv2K6RSJvBMK3peNE12jPTPxItEIUpkgsGiqMeGR511wnonLQlWcT7GpEhPvLFf4mlCj41m3rFNiFre1Qb36POTAuvrJAqtovFEF/n4TcfmyhK/Jud0uBsEzMYoTBXsWgfV4nr90A/AiDsv4cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714005013; c=relaxed/simple;
	bh=KOLaJB66X3054hufeGyheJESQV+R37/EE+6cbTDfyHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qCs4Ga5jpjlLWHCb9NrDXayw7gHcJ5jOOTe9HbFOQRWXl45J+OO/NCApgGK4VZhjHqyrim8RJtI/dXlhmFrhEyBrw3Eh+QmMsSut3tithJSFrUI+k5bk0OFCI1HoudpbKI9wH7rEZe/xVl6ESYVBoiCmEu/3qB1H2Tv5Xt62Vuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WGTfPJmQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC828C113CE;
	Thu, 25 Apr 2024 00:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714005012;
	bh=KOLaJB66X3054hufeGyheJESQV+R37/EE+6cbTDfyHk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WGTfPJmQRxT+1mvhuL9STyvcxrTD3k3MDrw3SIUUoqxCSgkdBKdvlYNjXx9ivDNiC
	 dzfGciaQz3iNh4Ev+Oq6pT1C3sgIEVlDnYTm7FoMnazSFE8MNGVCr1UWSWdaZ9qw3v
	 zNsgTmfRLL7inwvlblV5A36ISwT4MCk5/Z0EwGObBqIi1CQlAweHuZKa7dnc1RKnse
	 Bp++4ryM5BlITgDBtlPX1RIgbBMxxEGQkuqzWAmPU5Osf9bn3CIwlCeWRYFvcC1aK/
	 7n8ggc54Jy5VML4V+yXmTnezIhDb6s+oUgh5c7mk1lbiewMJlVxbFiL8KkWrNDmGJt
	 aNG0BkqpvRa5A==
Date: Wed, 24 Apr 2024 17:30:12 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: aalbersh@redhat.com, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, fsverity@lists.linux.dev
Subject: Re: [PATCH 06/13] fsverity: send the level of the merkle tree block
 to ->read_merkle_tree_block
Message-ID: <20240425003012.GT360919@frogsfrogsfrogs>
References: <171175867829.1987804.15934006844321506283.stgit@frogsfrogsfrogs>
 <171175867965.1987804.16949621858616176182.stgit@frogsfrogsfrogs>
 <20240405024212.GD1958@quark.localdomain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405024212.GD1958@quark.localdomain>

On Thu, Apr 04, 2024 at 10:42:12PM -0400, Eric Biggers wrote:
> On Fri, Mar 29, 2024 at 05:34:14PM -0700, Darrick J. Wong wrote:
> > +/**
> > + * struct fsverity_readmerkle - Request to read a Merkle Tree block buffer
> > + * @inode: the inode to read
> > + * @level: expected level of the block; level 0 are the leaves, -1 means a
> > + * streaming read
> > + * @num_levels: number of levels in the tree total
> > + * @log_blocksize: log2 of the size of the expected block
> > + * @ra_bytes: The number of bytes that should be prefetched starting at pos
> > + *		if the page at @block->offset isn't already cached.
> > + *		Implementations may ignore this argument; it's only a
> > + *		performance optimization.
> > + */
> > +struct fsverity_readmerkle {
> > +	struct inode *inode;
> > +	unsigned long ra_bytes;
> > +	int level;
> > +	int num_levels;
> > +	u8 log_blocksize;
> > +};
> 
> This struct should be introduced in the patch that adds ->read_merkle_tree_block
> originally.

Done.

--D

> - Eric
> 

