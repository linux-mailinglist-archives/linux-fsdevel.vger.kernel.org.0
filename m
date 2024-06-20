Return-Path: <linux-fsdevel+bounces-22006-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A538910CF3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2024 18:33:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C33C1C21088
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2024 16:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E916D1B5808;
	Thu, 20 Jun 2024 16:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SgoUfhsz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E13519EEBC;
	Thu, 20 Jun 2024 16:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718900791; cv=none; b=YGHojYDEX0llV0GqYco8NSjcC4bjR5BGxhOGG6t0sSxGtVlJ84Y26qERWFKTn9gSFBw6QE4+oF5ifnTTor2olPZkStjYyPRN0d+ViAvTQVv9QP8LaE3aG6kdA8ws87Bp8rdoJgfsVRQoaL983EDFHwVH1GYM8dLC1M9fi1HGGcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718900791; c=relaxed/simple;
	bh=XxaT3nLSEdsGIJw+4O6ApGSvwQbasNX6lodtpqcsiio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BNNQ0BClGbbw+HzXT4fGCTVaQP0cUrZ+jMc/bEZ2Hp4XDVG4ZGCVTb4QfpC5IfB+IkbIA185O5aGTI0vyDvlefeEKN4K7+4udCCaKMaTRLjF5RW8PRdInCI0kreQ2p7JqYfNZjPpQsA6nfera9CXcFhzr9ucTEWL1Qf/8TBqHCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SgoUfhsz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92BC2C2BD10;
	Thu, 20 Jun 2024 16:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718900791;
	bh=XxaT3nLSEdsGIJw+4O6ApGSvwQbasNX6lodtpqcsiio=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SgoUfhszSeuAtRk6+Zn1XWS2n7FCvAAyQn9Y5L3snT134zmlwZlrSiUaiFbNM/koo
	 P2nPD4ng5TcRRfaf3jt2lFncH3nj/SHFLW9+h5bAzvlLEAtizhtBAoRcQeOg6Xlbdv
	 mhaidGp6xZ3HRj6wFALxONfZ6GtOvsb/akS4mx81jBlRcwjLzgkNavXiBniCy0AtyF
	 i6VLlcv4fyQ70aejBdTd04dr3tp91XTSpZD8obA6R7MLLZg259a+eBF/Jn+deoRrwZ
	 QTcF5dHX1l0tpaSlw5gTtLKtV/Ql62Jh3shg91d/vCR5KCvaYmYK026iEG3kF89HPZ
	 hBotBYOPLT5rw==
Date: Thu, 20 Jun 2024 10:26:28 -0600
From: Keith Busch <kbusch@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Matthew Wilcox <willy@infradead.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Hongbo Li <lihongbo22@huawei.com>, linux-bcachefs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	hch@lst.de
Subject: Re: bvec_iter.bi_sector -> loff_t?
Message-ID: <ZnRYNKV6DqKAbxDx@kbusch-mbp.dhcp.thefacebook.com>
References: <20240620132157.888559-1-lihongbo22@huawei.com>
 <bbf7lnl2d5sxdzqbv3jcn6gxmtnsnscakqmfdf6vj4fcs3nasx@zvjsxfwkavgm>
 <ZnQ0gdpcplp_-aw7@casper.infradead.org>
 <pfxno4kzdgk6imw7vt2wvpluybohbf6brka6tlx34lu2zbbuaz@khifgy2v2z5n>
 <ZnRBkr_7Ah8Hj-i-@casper.infradead.org>
 <0f74318e-2442-4d7d-b839-2277a40ca196@kernel.dk>
 <ZnRHi3Cfh_w7ZQa1@casper.infradead.org>
 <861a0926-40bf-4180-8092-c84a3749f1cf@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <861a0926-40bf-4180-8092-c84a3749f1cf@kernel.dk>

On Thu, Jun 20, 2024 at 09:18:58AM -0600, Jens Axboe wrote:
> On 6/20/24 9:15 AM, Matthew Wilcox wrote:
> > On Thu, Jun 20, 2024 at 08:56:39AM -0600, Jens Axboe wrote:
> >> On 6/20/24 8:49 AM, Matthew Wilcox wrote:
> >>> On Thu, Jun 20, 2024 at 10:16:02AM -0400, Kent Overstreet wrote:
> >>> I'm more sympathetic to "lets relax the alignment requirements", since
> >>> most IO devices actually can do IO to arbitrary boundaries (or at least
> >>> reasonable boundaries, eg cacheline alignment or 4-byte alignment).
> >>> The 512 byte alignment doesn't seem particularly rooted in any hardware
> >>> restrictions.
> >>
> >> We already did, based on real world use cases to avoid copies just
> >> because the memory wasn't aligned on a sector size boundary. It's
> >> perfectly valid now to do:
> >>
> >> struct queue_limits lim {
> >> 	.dma_alignment = 3,
> >> };
> >>
> >> disk = blk_mq_alloc_disk(&tag_set, &lim, NULL);
> >>
> >> and have O_DIRECT with a 32-bit memory alignment work just fine, where
> >> before it would EINVAL. The sector size memory alignment thing has
> >> always been odd and never rooted in anything other than "oh let's just
> >> require the whole combination of size/disk offset/alignment to be sector
> >> based".
> > 
> > Oh, cool!  https://man7.org/linux/man-pages/man2/open.2.html
> > doesn't know about this yet; is anyone working on updating it?
> 
> Probably not... At least we do have STATX_DIOALIGN which can be used to
> figure out what the alignment is, but I don't recall if any man date
> updates got done. Keith may remember, CC'ed.

The man page already recommends statx if available, which tells you
everything you need to know about your device's direct io alignment
requirements. The man only suggests block size alignment for older
kernels, so I think it's fine as-is, no?

You can also query the queue's "dma_alignment" sysfs attribute.

