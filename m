Return-Path: <linux-fsdevel+bounces-53819-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 607E9AF7E2F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 18:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3D744A7A58
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 16:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404B8259CA8;
	Thu,  3 Jul 2025 16:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QCyLAN9U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9E233DF;
	Thu,  3 Jul 2025 16:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751561479; cv=none; b=n0B68CATdkms+cWeKiq1NIwUg7a8lmsjxfRTWN8qwEGvaClhaZDmMyDYoqf4t6oP0NONnHuiP6ilu3ry8SUtR4kU0nyZLaKTDHCvg3cBZkCxzslfArpabUTZfEijT3wJiPzm3UTluffBw06aJazbZEmgpkEDsHpeIwXAqhjLmsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751561479; c=relaxed/simple;
	bh=KgNWAEPsvGLZYpBhpkLVwDOSCjtLzdipdUOgdEkAzQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gl8Jcl9ugglozNN0k53kEkGf7GivQfVVdeI54ibBaSyt5Q0ZT8JjHYg7sPOudPKdNS64OoST4IW/DdsYuXUa0XWuuYB+A9WCwQQWQm3htsSGq/EljDO+OR6PTu1qXKblG3ppzjowVVnfE+C1DA+dt9mwbLiBWqU15/I4AkelXUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QCyLAN9U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12CFCC4CEE3;
	Thu,  3 Jul 2025 16:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751561478;
	bh=KgNWAEPsvGLZYpBhpkLVwDOSCjtLzdipdUOgdEkAzQc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QCyLAN9UKompBN/Txlb0N5sKTjycQuUVbNWq4uLmWMH+EOFlkomwkRhux+XdKcStW
	 C74wJfVSHPKYVez5me2dCemHJjc2S9KvtOszihXM/VZ/cw+mW3PrFJP3gmDL69LCvZ
	 PjqOKJRdOFzlptOQn54UQPBwAB8Uvx9SF2aSgnH8/+meQiHY0sXkJ+tdWEZ2QHNKrl
	 3VH6OjTGPBVP6ZVeCL9ImVd3UWXM2igfFdg6OmWh35wXgCuE2LEzYVguBxZ+0vmxn/
	 WnpiGFITbqBAASKYir2sRwlPWv9ZxmxqZKMXEHM+PxBAj8PUUNpXQ14xAGY5ggACOb
	 cJbuiF4zwJ3nA==
Date: Thu, 3 Jul 2025 09:51:17 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Joanne Koong <joannelkoong@gmail.com>, linux-fsdevel@vger.kernel.org,
	miklos@szeredi.hu, brauner@kernel.org, anuj20.g@samsung.com,
	linux-xfs@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-block@vger.kernel.org, gfs2@lists.linux.dev,
	kernel-team@meta.com
Subject: Re: [PATCH v3 03/16] iomap: refactor the writeback interface
Message-ID: <20250703165117.GA2672049@frogsfrogsfrogs>
References: <20250624022135.832899-1-joannelkoong@gmail.com>
 <20250624022135.832899-4-joannelkoong@gmail.com>
 <20250702171353.GW10009@frogsfrogsfrogs>
 <20250703121654.GA19114@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703121654.GA19114@lst.de>

On Thu, Jul 03, 2025 at 02:16:54PM +0200, Christoph Hellwig wrote:
> On Wed, Jul 02, 2025 at 10:13:53AM -0700, Darrick J. Wong wrote:
> > > +    int (*writeback_range)(struct iomap_writepage_ctx *wpc,
> > > +    		struct folio *folio, u64 pos, unsigned int len, u64 end_pos);
> > 
> > Why does @pos change from loff_t to u64 here?  Are we expecting
> > filesystems that set FOP_UNSIGNED_OFFSET?
> 
> It doesn't really change, it matches what iomap_writepage_map_blocks
> was doing.  I guess it simply doesn't fix the existing inconsistency.
> 
> > > +    int (*submit_ioend)(struct iomap_writepage_ctx *wpc, int status);
> > 
> > Nit:   ^^ indenting change here.
> 
> Yeah, RST formatting is a mess unfortunately.   I think the problem is
> that the exiting code uses 4 space indents.  I wonder if that's required
> by %##% RST?

It's a code block, so it's not going to make the rst parser choke.
However it will result in an weirdly indented output:

 struct iomap_writeback_ops {
     int (*map_blocks)(struct iomap_writepage_ctx *wpc, struct inode *inode,
                       loff_t offset, unsigned len);
     int (*submit_ioend)(struct iomap_writepage_ctx *wpc, int status);
    void (*discard_folio)(struct folio *folio, loff_t pos);
 };

is what I got when I removed an indentation space from discard_folio.
Hilariously it actually makes the "(" line up which appeals to my column
aligning brain and actually looks better. :P

So having now seriously undercut my own point, I'll relax to "meh do
whatever".

> > > +		if (wpc->iomap.type != IOMAP_HOLE)
> > > +			*wb_pending = true;
> > 
> > /me wonders if this should be an outparam of ->writeback_range to signal
> > that it actually added the folio to the writeback ioend chain?  Or maybe
> > just a boolean in iomap_writepage_ctx that we clear before calling
> > ->writeback_range and iomap_add_to_ioend can set it as appropriate?
> 
> What's the benefit of that?  A hole pretty clearly signal there is
> no writeback here.

Fair enough.  In my head it was "the code that actually sets up the
ioend should set this flag" but I guess we can detect it from the
mapping after the fact instead of passing things around.

> > Should this jump label should be named add_to_ioend or something?  We
> > already mapped the blocks.  The same applies to the zoned version of
> > this function.
> 
> The newer version already uses a map_blocks helper for both again.

Ah, so it does.

--D

