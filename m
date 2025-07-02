Return-Path: <linux-fsdevel+bounces-53701-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D740AF60FD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 20:18:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 601764A771D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 18:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE4030E843;
	Wed,  2 Jul 2025 18:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gq8TPn5Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB0219A;
	Wed,  2 Jul 2025 18:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751480328; cv=none; b=Ljhc3ovaQhOGutnZJyixd7WjOBk+gshrh4tCAHCVqpJuv5CoNEa29KZHIcACpduBZx7vD7fyytDljhECiYnNLwFqP8532J/0oN8VPVz1k8YLbiUSbig9qNztcm2uMwP/kh7U3KxjlOLip10jcp2RjvV/q3CvuL9rVBrASp3S1kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751480328; c=relaxed/simple;
	bh=IUf5SnET6UqfSq+SGrTMn7zzbo0/g6VkyLbiNpv2AbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tQnlUj3pBv3dZz9MLE30xgD+ERo6wpoENV7o+gEtD0WFCAWZStzqAtTXS8G1oe0vzdPz9nzQaBTjsUhoSSAThbNYHqE7bqkg35OiVOEniG98YL+sQaoqKm8d7h5xt6P7mblQpWX9IXzEZOaR4fMtnTG5X1VdYGm681qB7G4XpXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gq8TPn5Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0B30C4CEE7;
	Wed,  2 Jul 2025 18:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751480327;
	bh=IUf5SnET6UqfSq+SGrTMn7zzbo0/g6VkyLbiNpv2AbU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gq8TPn5YFpubZZUlsZFOxjtVxCmDcYElfghlbDUWYFZTkBKOIJvJu9FMYWrVo/bVb
	 aeOLEzi530YlTHgGgtNfCln9f95p4c4xZtsziYHM5UzBAYu/Kw1r2WBHPbNgW/pBk+
	 xY/Sgf+n8Mqs91nOIpNSdiIc5AdQ7WDMfwWkzVLOyDO3HeHJ/nmId62y97iVymtjpX
	 rLkICTigoWRXRE1Ln77BhfYTfs7Wl7FQks619FCyGRX6qY5eQJjLMRCzsFLu/x0Fur
	 xd93qbx6B/SlPsrq253ksQh492E6huVuRc8xT/D6mkFvkR/4Qb+Gk3qfvGu2xNmfPk
	 w3S/juSTcY23w==
Date: Wed, 2 Jul 2025 11:18:47 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Brian Foster <bfoster@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>,
	Joanne Koong <joannelkoong@gmail.com>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-block@vger.kernel.org, gfs2@lists.linux.dev,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH 01/12] iomap: pass more arguments using the iomap
 writeback context
Message-ID: <20250702181847.GL10009@frogsfrogsfrogs>
References: <20250627070328.975394-1-hch@lst.de>
 <20250627070328.975394-2-hch@lst.de>
 <aF601H1HVkw-g_Gk@bfoster>
 <20250630054407.GC28532@lst.de>
 <aGKF6Tfg4M94U3iA@bfoster>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGKF6Tfg4M94U3iA@bfoster>

On Mon, Jun 30, 2025 at 08:41:13AM -0400, Brian Foster wrote:
> On Mon, Jun 30, 2025 at 07:44:07AM +0200, Christoph Hellwig wrote:
> > On Fri, Jun 27, 2025 at 11:12:20AM -0400, Brian Foster wrote:
> > > I find it slightly annoying that the struct name now implies 'wbc,'
> > > which is obviously used by the writeback_control inside it. It would be
> > > nice to eventually rename wpc to something more useful, but that's for
> > > another patch:
> > 
> > True, but wbc is already taken by the writeback_control structure.
> > Maybe I should just drop the renaming for now?
> > 
> 
> Yeah, that's what makes it confusing IMO. writeback_ctx looks like it
> would be wbc, but it's actually wpc and wbc is something internal. But I
> dunno.. it's not like the original struct name is great either.
> 
> I was thinking maybe rename the wpc variable name to something like
> wbctx (or maybe wbctx and wbctl? *shrug*). Not to say that is elegant by
> any stretch, but just to better differentiate from wbc/wpc and make the
> code a little easier to read going forward. I don't really have a strong
> opinion wrt this series so I don't want to bikeshed too much. Whatever
> you want to go with is fine by me.

I'd have gone with iwc or iwbc, but I don't really care that much. :)

Now I'm confused because I've now seen the same patch from joanne and
hch and don't know which one is going forward.  Maybe I should just wait
for a combined megaseries...

--D

> Brian
> 
> 

