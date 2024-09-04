Return-Path: <linux-fsdevel+bounces-28460-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD60096AEBF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 04:45:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1D711C23A14
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 02:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27CE43D0AD;
	Wed,  4 Sep 2024 02:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="CJ8x5ElV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9AB32B2CC
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Sep 2024 02:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725417927; cv=none; b=lmp4wYTOEYJvcfjXTIFUvCDhTm9PMRjsdgNOiIQDfxC2TlqczOvgK/lx3vlj2etqnxonQ95CT12oi/efXZfVgaaEWS3lD1Pjca5HT2f9Of8a861pCCFGofgyU3ZxWhO2eBL6FptqkF4Twf734Aab8SB2tf6SjXYtmulQlRKWkYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725417927; c=relaxed/simple;
	bh=NK6YhPeotmJtK+GMXSnIWRIf+LgudAJR4z/35FRgOVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CSRzPO2uNT8idLv7mAwdXH7Aes5COpTycSZVXZEJ9h7xPkaAe+EIaJYXiJvcp9jp6kwngAjNaRlqZw0vFrFNjPdpV0gzzMk/+sCNqy6VD0CbzvpcKf4m6dCkm6aGY5YJn288IpSROFe0OqrtWq5zhFnefR1kmnby+HysVEG5NeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=CJ8x5ElV; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-102-194.bstnma.fios.verizon.net [173.48.102.194])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 4842ijoS018341
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 3 Sep 2024 22:44:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1725417888; bh=N0tURsEO/daEuLgW14fTk/vKz4zHa6gbI1lU17foqrM=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=CJ8x5ElVv9k0Bgq7LZmmaouC2u2CdmhbKpq+FkWcbz7Oc2tv83e3s12LmQ7F5hWVZ
	 PwneG4V0QQ+N58Kn/1DyedALKHaAujxihuitGvBcX2ewJGWUBfxJKaMRcQYGaIgbeJ
	 TupGzPCXH4Up2wJ7ePeoWQ66rgpoZBQQyGD3Uts0U62KNpFq8RBpMe1JMSG5IcSfwv
	 qEx7RCmUIvH8QcCwhcXIaw4reV/a07Est3xQoQNXm7ZnnBSBNuFDmKLGOcR+EJU+ed
	 s0vpYAanuWDM/Zm0qHudMIdOHo3Wk78AhzhF/DYp6qgUGukJGGzYz9lgoZx20LRX+g
	 hlQxDl1K1Z3NQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 69BA515C02C4; Tue, 03 Sep 2024 22:44:45 -0400 (EDT)
Date: Tue, 3 Sep 2024 22:44:45 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        steve.kang@unisoc.com
Subject: Re: [RFC PATCHv2 1/1] fs: ext4: Don't use CMA for buffer_head
Message-ID: <20240904024445.GR9627@mit.edu>
References: <20240823082237.713543-1-zhaoyang.huang@unisoc.com>
 <20240903022902.GP9627@mit.edu>
 <CAGWkznEv+F1A878Nw0=di02DHyKxWCvK0B=93o1xjXK6nUyQ3Q@mail.gmail.com>
 <20240903120840.GD424729@mit.edu>
 <CAGWkznFu1GTB41Vx1_Ews=rNw-Pm-=ACxg=GjVdw46nrpVdO3g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGWkznFu1GTB41Vx1_Ews=rNw-Pm-=ACxg=GjVdw46nrpVdO3g@mail.gmail.com>

On Wed, Sep 04, 2024 at 08:49:10AM +0800, Zhaoyang Huang wrote:
> >
> > After all, using GFP_MOVEABLE memory seems to mean that the buffer
> > cache might get thrashed a lot by having a lot of cached disk buffers
> > getting ejected from memory to try to make room for some contiguous
> > frame buffer memory, which means extra I/O overhead.  So what's the
> > upside of using GFP_MOVEABLE for the buffer cache?
>
> To my understanding, NO. using GFP_MOVEABLE memory doesn't introduce
> extra IO as they just be migrated to free pages instead of ejected
> directly when they are the target memory area. In terms of reclaiming,
> all migrate types of page blocks possess the same position.

Where is that being done?  I don't see any evidence of this kind of
migration in fs/buffer.c.

It's *possile* I suppose, but you'd have to remove the buffer_head so
it can't be found by getblk(), and then wait for bh->b_count to go to
zero, and then allocate a new page, and then copy buffer_head's page,
update the buffer_head, and then rechain the bh into the buffer cache.
And as I said, I can't see any kind of code like that.  It would be
much simpler to just try to eject the bh from the buffer cache.  And
that's consistent which what you've observed, which is that if the
buffer_head is prevented from being ejected because it's held by the
jbd2 layer until the buffer has been checkpointed.

> > Just curious, because in general I'm blessed by not having to use CMA
> > in the first place (not having I/O devices too primitive so they can't
> > do scatter-gather :-).  So I don't tend to use CMA, and obviously I'm
> > missing some of the design considerations behind CMA.  I thought in
> > general CMA tends to used in early boot to allocate things like frame
> > buffers, and after that CMA doesn't tend to get used at all?  That's
> > clearly not the case for you, apparently?
>
> Yes. CMA is designed for contiguous physical memory and has been used
> via cma_alloc during the whole lifetime especially on the system
> without SMMU, such as DRM driver. In terms of MIGRATE_MOVABLE page
> blocks, they also could have compaction path retry for many times
> which is common during high-order alloc_pages.

But then what's the point of using CMA-eligible memory for the buffer
cache, as opposed to just always using !__GFP_MOVEABLE for all buffer
cache allocations?  After all, that's what is being proposed for
ext4's ext4_getblk().  What's the downside of avoiding the use of
CMA-eligible memory for ext4's buffer cache?  Why not do this for
*all* buffers in the buffer cache?

					- Ted

