Return-Path: <linux-fsdevel+bounces-45588-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE75A799E0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 04:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FA8B16F040
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 02:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4B015C140;
	Thu,  3 Apr 2025 02:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GZ/jDKFa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF456F31E;
	Thu,  3 Apr 2025 02:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743645866; cv=none; b=FKlmscMDYDLfDN8NmBGF1SzulqCngYbPEd7d93zfx5QevX83G7QWKKJmHBkWRuLX3Gabhz3+4EAofqKba1iRdA+HDkluRnC+x1C5ttTf8uzahy1BI8vOrl/kk4nSKfVQxLhfrDJba/73TzSKuGz3MikqX+4ypKzo6eVDe2ue4pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743645866; c=relaxed/simple;
	bh=a96SlvwEBzJj+2DnKMwsTwDZGhq08Zv/n7EyUk+W7Rs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gd0HKfqSoUqEigUXdshvSd2h5CR6MKEzyiBniEhIu/jok1AX1J4slZnBsXLhuvtTSh3SPBL2o/nr+O48fEFg2B9AsB96bCNVbWTpA75g21wcWhM0DaLAbTjZwtu9WWARsNTcX8jwRxcTPuiRRElO79MWPOMmPIgr6YJTMkutPLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GZ/jDKFa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A600C4CEDD;
	Thu,  3 Apr 2025 02:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743645865;
	bh=a96SlvwEBzJj+2DnKMwsTwDZGhq08Zv/n7EyUk+W7Rs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GZ/jDKFaDLc097kSITEFAQ6NhhyOGIJG3yaklFbH+MEfC/ySGAZ/45xfBAgNi3XVB
	 n4V6J65QqB1NCOGquu1iiluGCY7h47njXbzBhYbo/hKA5GyJeDTXj27rkq5OThV2+q
	 L8zB1DX5jdqsXcB8wRLMKZ51RdJcB0UhyjyeoJfqGihVuNjw6aOKNXHxytumXTcwPV
	 XuFpklC0UtxfwxG9BzQlAxNaL+3vK1/syQk4KhQ8wIIJhJOMsjbjno5q91werBEMle
	 /eoP1p1iWA2SQ42DYlBDj4/QPH5fvY63ddBeg8MLGfn6e8vELEAjnp3TmeuFsoSAdp
	 Zz/K3YI8eqJDA==
Date: Wed, 2 Apr 2025 19:04:23 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Jan Kara <jack@suse.cz>, brauner@kernel.org, tytso@mit.edu,
	adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	riel@surriel.com, hannes@cmpxchg.org, oliver.sang@intel.com,
	david@redhat.com, axboe@kernel.dk, hare@suse.de,
	david@fromorbit.com, djwong@kernel.org, ritesh.list@gmail.com,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-mm@kvack.org, gost.dev@samsung.com, p.raghav@samsung.com,
	da.gomez@samsung.com
Subject: Re: [PATCH 2/3] fs/buffer: avoid races with folio migrations on
 __find_get_block_slow()
Message-ID: <Z-3spxNHYe_CbLgP@bombadil.infradead.org>
References: <20250330064732.3781046-1-mcgrof@kernel.org>
 <20250330064732.3781046-3-mcgrof@kernel.org>
 <lj6o73q6nev776uvy7potqrn5gmgtm4o2cev7dloedwasxcsmn@uanvqp3sm35p>
 <20250401214951.kikcrmu5k3q6qmcr@offworld>
 <Z-yZxMVJgqOOpjHn@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-yZxMVJgqOOpjHn@casper.infradead.org>

On Wed, Apr 02, 2025 at 02:58:28AM +0100, Matthew Wilcox wrote:
> On Tue, Apr 01, 2025 at 02:49:51PM -0700, Davidlohr Bueso wrote:
> > So the below could be tucked in for norefs only (because this is about the addr
> > space i_private_lock), but this also shortens the hold time; if that matters
> > at all, of course, vs changing the migration semantics.
> 
> I like this approach a lot better.  One wrinkle is that it doesn't seem
> that we need to set the BH_Migrate bit on every buffer; we could define
> that it's only set on the head BH, right?

Yes, we are also only doing this for block devices, and for migration
purposes. Even though a bit from one buffer may be desirable it makes
no sense to allow for that in case migration is taking place.  So indeed
we have no need to add the flag for all buffers.

I think the remaining question is what users of __find_get_block_slow()
can really block, and well I've started trying to determine that with
coccinelle [0], its gonna take some more time.

Perhaps its easier to ask, why would a block device mapping want to
allow __find_get_block_slow() to not block?

[0] https://lkml.kernel.org/r/20250403020123.1806887-1-mcgrof@kernel.org

  Luis

