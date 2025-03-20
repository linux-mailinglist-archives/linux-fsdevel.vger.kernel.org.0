Return-Path: <linux-fsdevel+bounces-44651-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 982E3A6B006
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 22:41:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FBF0188C6B7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 21:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A04E2222B6;
	Thu, 20 Mar 2025 21:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="coADCjkK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A018F22170A;
	Thu, 20 Mar 2025 21:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742506854; cv=none; b=WL3ZTUb5bItK6JIGBU/8fu4xItAsEGRwJFfSLspIrHBZlzTy8bqGLgavitdMHTEitZ9gkQ6JL+3uoUkA+MJvTYo3Jp6rWelwb2nMGcSWB7ytmtfXnEYRsJNS5b/q1H+oEwSisBKBtzP+Xm4ZpxP4BNvMFGmIu2SFWC/ebpBs+OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742506854; c=relaxed/simple;
	bh=iuxYTWMikuL7/79jMbq6dB02LLSik5Yg9oqM20hqKS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T+eO5Uz2CB58AOxDo9/f04IR8cXi0/lE/yunfresia8lDIgvDBkijROEaydACVn5O3zhya19MI1/pgWwshdY57Oqhtfoe/b2IEL1h2qTNW0C1ZALGZVbd5x4UetAwEmAmUWZuuLXq+BPkI1vksV3G3xJe2HvByVT/zNv7qUFRpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=coADCjkK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98362C4CEDD;
	Thu, 20 Mar 2025 21:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742506854;
	bh=iuxYTWMikuL7/79jMbq6dB02LLSik5Yg9oqM20hqKS8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=coADCjkKky5l1VpWZZMoqTmplW8HxyaN3yHoTHbGRo+idKiZY7UyLEm/qzPgl5qIU
	 WVc1o2FKrtvtCnYF5oOC/aYCPQwLVci0rzMMHitYakkzd44fh2D2v/C0M28uGeFVRe
	 U4K61w14dc7O61vy6HLw69YomgTeCel1FL5Rf4yZNv5UiWV4ThhsBdNLnKNhWLtoSC
	 nlvgGsH0jCF2odg8LfW0IDkyQRZCu6sCO/SsJHDwy29ARSzBJ/Nmt9K/izXA0Lf278
	 jQx0yR1DpkEvEW/QHtg8wflDM3ox4Hid1RJHJpThFAY+S6JdVxeXRQXFqCVx4U1dV6
	 yrZaDShVrDS8w==
Date: Thu, 20 Mar 2025 14:40:52 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-block@vger.kernel.org, lsf-pc@lists.linux-foundation.org,
	david@fromorbit.com, leon@kernel.org, kbusch@kernel.org,
	sagi@grimberg.me, axboe@kernel.dk, joro@8bytes.org,
	brauner@kernel.org, hare@suse.de, willy@infradead.org,
	djwong@kernel.org, john.g.garry@oracle.com, ritesh.list@gmail.com,
	p.raghav@samsung.com, gost.dev@samsung.com, da.gomez@samsung.com
Subject: Re: [LSF/MM/BPF TOPIC] breaking the 512 KiB IO boundary on x86_64
Message-ID: <Z9yLZAjrHFsCD1Ww@bombadil.infradead.org>
References: <Z9v-1xjl7dD7Tr-H@bombadil.infradead.org>
 <20250320141846.GA11512@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320141846.GA11512@lst.de>

On Thu, Mar 20, 2025 at 03:18:46PM +0100, Christoph Hellwig wrote:
> On Thu, Mar 20, 2025 at 04:41:11AM -0700, Luis Chamberlain wrote:
> > We've been constrained to a max single 512 KiB IO for a while now on x86_64.
> 
> No, we absolutely haven't.  I'm regularly seeing multi-MB I/O on both
> SCSI and NVMe setup.

Sorry you're right, I should have been clearer. This is only an issue without
large folios for buffered IO, or without scatter list chaining support.

Or put another way, block driver which don't support scatter list
chaining will end up with a different max IO possible for direct IO and
io-uring cmd.

> > This is due to the number of DMA segments and the segment size.
> 
> In nvme the max_segment_size is UINT_MAX, and for most SCSI HBAs it is
> fairly large as well.

For Direct IO or io-uring cmd when large folios may not be used the
segments will be constrained to the page size.

  Luis

