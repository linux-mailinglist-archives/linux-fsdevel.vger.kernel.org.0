Return-Path: <linux-fsdevel+bounces-52739-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D05AE61EE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 12:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 130FF1899D35
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 10:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3D7280035;
	Tue, 24 Jun 2025 10:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hv79WMvd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74FB8634F;
	Tue, 24 Jun 2025 10:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750760119; cv=none; b=c7rkVUFUux0c053V25YbbJuO90KHWhlF0bmqS5faa+uCYeyYHHrrThRC7z/APhzuQWHle/oCc9TVLg0OEAqrEmcl87ZsD03di2gJDV1s5pflcO5HpZTdpFm5xO4SnysVraWcVt8TexmvvShlG1oIDfxzDCKR9V6ItG26uUEDmoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750760119; c=relaxed/simple;
	bh=rdUwDLVG/TKz8NYY/g0YuSZlKne+cP5og5UuSBrt19M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rDTLBp09XoIu/8zcP86orMxSqOtv7ppfoluqGkwihYNuZkBX2Y73FfeWUr4h3ripqn2eEoCSZyPkS78stu2j9T2j9hvpoxf8POah0gnJiWePXzRBHT50XKmJlfk2V6fOOJtmtEN+lqyywnbsPGUqHzznPK5TrpeWW4N/XnNtsXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hv79WMvd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C495EC4CEE3;
	Tue, 24 Jun 2025 10:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750760117;
	bh=rdUwDLVG/TKz8NYY/g0YuSZlKne+cP5og5UuSBrt19M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hv79WMvdidIh6Kk5+hAAYLuVm/TohQ2e8NrROwnIl97jLSY6SHfWuH778BexeRW92
	 AYKrdOrePIugW4AtunSMsLoY23AW/PH+A/B3vwDwE38AT9YiStU/GjlbQMdIBBk2TA
	 vYqjpgYKQwjZbp0fLrLIJQerPGplBqmXLp6LGeWXO3ZR2/2Xun7KeqDf+PO3HGUnLo
	 IvI7Ou0752ayrwMMTS0fXStVAgxIc3PqXVFyBka7BGc5QhCXIhqUfzMjha8QQZgRXn
	 BI4r9pYqM8y7FN78sNNXVRzJxDw/CajGsgdrB/1T7cV9361KBG5FQN7H1NmgEnj7gn
	 oW07LCTrJZgow==
Date: Tue, 24 Jun 2025 12:15:13 +0200
From: Christian Brauner <brauner@kernel.org>
To: Qu Wenruo <wqu@suse.com>
Cc: Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>, 
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk
Subject: Re: [PATCH RFC 5/6] fs: introduce a shutdown_bdev super block
 operation
Message-ID: <20250624-goldschatz-wohnviertel-aeb3209ad47b@brauner>
References: <ef624790b57b76be25720e4a8021d7f5f03166cb.1750397889.git.wqu@suse.com>
 <wmvb4bnsz5bafoyu5mp33csjk4bcs63jemzi2cuqjzfy3rwogw@4t6fizv5ypna>
 <aFji5yfAvEeuwvXF@infradead.org>
 <20250623-worte-idolisieren-75354608512a@brauner>
 <aFldWPte-CK2PKSM@infradead.org>
 <84d61295-9c4a-41e8-80f0-dcf56814d0ae@suse.com>
 <20250624-geerntet-haare-2ce4cc42b026@brauner>
 <8db82a80-242f-41ff-84b8-601d6dcd9b9d@suse.com>
 <20250624-briefe-hassen-f693b4fe3501@brauner>
 <abe98c94-b4e0-446b-90e7-c9cdb1c9d197@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <abe98c94-b4e0-446b-90e7-c9cdb1c9d197@suse.com>

On Tue, Jun 24, 2025 at 07:21:50PM +0930, Qu Wenruo wrote:
> 
> 
> 在 2025/6/24 18:43, Christian Brauner 写道:
> [...]
> > > It's not hard for btrfs to provide it, we already have a check function
> > > btrfs_check_rw_degradable() to do that.
> > > 
> > > Although I'd say, that will be something way down the road.
> > 
> > Yes, for sure. I think long-term we should hoist at least the bare
> > infrastructure for multi-device filesystem management into the VFS.
> 
> Just want to mention that, "multi-device filesystem" already includes fses
> with external journal.

Yes, that's what I meant below by "We've already done a bit of that".
It's now possible to actually reach all devices associted with a
filesystem from the block layer. It works for xfs and ext4 with
journal fileystems. So for example, you can freeze the log device and
the main device as the block layer is now able to find both and the fs
stays frozen until both have been unfrozen. This wasn't possible before
the rework we did.

Now follows a tiny rant not targeted at you specifically but something
that still bugs me in general:

We had worked on extending this to btrfs so that it's all integrated
properly with the block layer. And we heard long promises of how you
would make that switch happen but refused us to let us make that switch.
So now it's 2 years later and zero happend in that area.

That also means block device freezing on btrfs is broken. If you freeze
a block device used by btrfs via the dm (even though unlikely) layer you
freeze the block device without btrfs being informed about that.

It also means that block device removal is likely a bit yanky because
btrfs won't be notified when any device other than the main device is
suddenly yanked. You probably have logic there but the block layer can
easily inform the filesystem about such an event nowadays and let it
take appropriate action.

And fwiw, you also don't restrict writing to mounted block devices.
That's another thing you blocked us from implementing even though we
sent the changes for that already and so we disabled that in
ead622674df5 ("btrfs: Do not restrict writes to btrfs devices"). So
you're also still vulnerable to that stuff.

> 
> Thus the new callback may be a good chance for those mature fses to explore
> some corner case availability improvement, e.g. the loss of the external
> journal device while there is no live journal on it.

Already handled for xfs and ext4 cleanly since our rework iiuc.

> (I have to admin it's super niche, and live-migration to internal journal
> may be way more complex than my uneducated guess)
> 
> Thanks,
> Qu
> 
> > Or we should at least explore whether that's feasible and if it's
> > overall advantageous to maintenance and standardization. We've already
> > done a bit of that and imho it's now a lot easier to reason about the
> > basics already.
> > 
> > > 
> > > We even don't have a proper way to let end user configure the device loss
> > > behavior.
> > > E.g. some end users may prefer a full shutdown to be extra cautious, other
> > > than continue degraded.
> > 
> > Right.
> 

