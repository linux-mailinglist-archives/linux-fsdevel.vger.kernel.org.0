Return-Path: <linux-fsdevel+bounces-23836-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B069A933F8A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 17:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49667284FCF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 15:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3559181BB1;
	Wed, 17 Jul 2024 15:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CqePwazl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563B0181319;
	Wed, 17 Jul 2024 15:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721229923; cv=none; b=ZdME9bCkActNbPPSc76woY4eXS3RQLg0Zxlk6BQBhjBeHU5u1xnjSrFyOUyowbHo67OXZRDLPdtGiKuATCo6QUdSGBxHCn0CbbiOKUDR6MGRuDJ2CI6gTNmcagbiZBNQGcOODNNtfQ1FnKGBtjN2HngmAYKoNjuE5YGHxP18U94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721229923; c=relaxed/simple;
	bh=DaTpRgJzWuI3JbYf7wsfuKAVwq9nrnAcFhQzfaoZpbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=truuvp8uZ+HbdCAJOWRy1Lg09WoovALCcVwZN1WJnqY5IjemQINns+neSxi10AzXdAlqjr3FPBLZUqJ+YJgn5rstMivAFYEffkFYjLmi2AywanaIj0I12pnh4N5BnL0PrtMyLS3S49nfbf+vV2gRK03Svbvn9V5Q/DH7GK8xkAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CqePwazl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7245C4AF50;
	Wed, 17 Jul 2024 15:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721229923;
	bh=DaTpRgJzWuI3JbYf7wsfuKAVwq9nrnAcFhQzfaoZpbw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CqePwazlBQsMh8JyH+2onHzIgig7EbJ2ZLDuHB5MXQshcYWBmsWwwIU8mRyH8C/wM
	 q5k4fAC7avhpe0bJM7syVZwT4UWy/YNOlI8tN4GB2nBA4xdrh5xfPipJktNz7ROVJx
	 1HlKpSIVCL3uJKqvworU//xiTjWGvRFPrNUoh8dKpmUz7M5GTFokT5bNqWF8wzuhO3
	 sV2RuUFy5sRxh7Ejq2rKnTYnNY+KwN2o9spTIHGyMvGJE/QIhaWHJ3trUlO6hbUgvS
	 SbtlLcaU/32O5vXmHVTlj0WdzErE7Ojsp6zPZytOQDtTruHE16/TSQnk1mp6vI4SuL
	 0bOJP+t8GlG3g==
Date: Wed, 17 Jul 2024 08:25:22 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	Matthew Wilcox <willy@infradead.org>, david@fromorbit.com,
	chandan.babu@oracle.com, brauner@kernel.org,
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	yang@os.amperecomputing.com, linux-mm@kvack.org,
	john.g.garry@oracle.com, linux-fsdevel@vger.kernel.org,
	hare@suse.de, p.raghav@samsung.com, mcgrof@kernel.org,
	gost.dev@samsung.com, cl@os.amperecomputing.com,
	linux-xfs@vger.kernel.org, hch@lst.de, Zi Yan <ziy@nvidia.com>
Subject: Re: [PATCH v10 01/10] fs: Allow fine-grained control of folio sizes
Message-ID: <20240717152522.GF612460@frogsfrogsfrogs>
References: <20240715094457.452836-1-kernel@pankajraghav.com>
 <20240715094457.452836-2-kernel@pankajraghav.com>
 <ZpaRElX0HyikQ1ER@casper.infradead.org>
 <20240717094621.fdobfk7coyirg5e5@quentin>
 <61806152-3450-4a4f-b81f-acc6c6aeed29@arm.com>
 <20240717151251.x7vkwajb57pefs6m@quentin>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240717151251.x7vkwajb57pefs6m@quentin>

On Wed, Jul 17, 2024 at 03:12:51PM +0000, Pankaj Raghav (Samsung) wrote:
> > >>
> > >> This is really too much.  It's something that will never happen.  Just
> > >> delete the message.
> > >>
> > >>> +	if (max > MAX_PAGECACHE_ORDER) {
> > >>> +		VM_WARN_ONCE(1,
> > >>> +	"max order > MAX_PAGECACHE_ORDER. Setting max_order to MAX_PAGECACHE_ORDER");
> > >>> +		max = MAX_PAGECACHE_ORDER;
> > >>
> > >> Absolutely not.  If the filesystem declares it can support a block size
> > >> of 4TB, then good for it.  We just silently clamp it.
> > > 
> > > Hmm, but you raised the point about clamping in the previous patches[1]
> > > after Ryan pointed out that we should not silently clamp the order.
> > > 
> > > ```
> > >> It seems strange to silently clamp these? Presumably for the bs>ps usecase,
> > >> whatever values are passed in are a hard requirement? So wouldn't want them to
> > >> be silently reduced. (Especially given the recent change to reduce the size of
> > >> MAX_PAGECACHE_ORDER to less then PMD size in some cases).
> > > 
> > > Hm, yes.  We should probably make this return an errno.  Including
> > > returning an errno for !IS_ENABLED() and min > 0.
> > > ```
> > > 
> > > It was not clear from the conversation in the previous patches that we
> > > decided to just clamp the order (like it was done before).
> > > 
> > > So let's just stick with how it was done before where we clamp the
> > > values if min and max > MAX_PAGECACHE_ORDER?
> > > 
> > > [1] https://lore.kernel.org/linux-fsdevel/Zoa9rQbEUam467-q@casper.infradead.org/
> > 
> > The way I see it, there are 2 approaches we could take:
> > 
> > 1. Implement mapping_max_folio_size_supported(), write a headerdoc for
> > mapping_set_folio_order_range() that says min must be lte max, max must be lte
> > mapping_max_folio_size_supported(). Then emit VM_WARN() in
> > mapping_set_folio_order_range() if the constraints are violated, and clamp to
> > make it safe (from page cache's perspective). The VM_WARN()s can just be inline
> 
> Inlining with the `if` is not possible since:
> 91241681c62a ("include/linux/mmdebug.h: make VM_WARN* non-rvals")
> 
> > in the if statements to keep them clean. The FS is responsible for checking
> > mapping_max_folio_size_supported() and ensuring min and max meet requirements.
> 
> This is sort of what is done here but IIUC willy's reply to the patch,
> he prefers silent clamping over having WARNINGS. I think because we check
> the constraints during the mount time, so it should be safe to call
> this I guess?

That's my read of the situation, but I'll ask about it at the next thp
meeting if that helps.

> > 
> > 2. Return an error from mapping_set_folio_order_range() (and the other functions
> > that set min/max). No need for warning. No state changed if error is returned.
> > FS can emit warning on error if it wants.
> 
> I think Chinner was not happy with this approach because this is done
> per inode and basically we would just shutdown the filesystem in the
> first inode allocation instead of refusing the mount as we know about
> the MAX_PAGECACHE_ORDER even during the mount phase anyway.

I agree.  Filesystem-wide properties (e.g. fs blocksize) should cause
the mount to fail if the pagecache cannot possibly handle any file
blocks.  Inode-specific properties (e.g. the forcealign+notears write
work John Garry is working on) could error out of open() with -EIO, but
that's a specialty file property.

--D

> --
> Pankaj
> 

