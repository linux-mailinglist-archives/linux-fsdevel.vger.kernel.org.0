Return-Path: <linux-fsdevel+bounces-56750-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73463B1B3A0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 14:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD450188A3D3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 12:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D94127145D;
	Tue,  5 Aug 2025 12:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JfSh+ZG5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07C6212B1E;
	Tue,  5 Aug 2025 12:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754397787; cv=none; b=OaNZOrXbxypMf5FfMqBd6KSnQS20AIBnbfPDuSY7Z9amXYmmxKF24PtoL7Ouch6A660UmfZoxdcXT3sR8y9rue2nv9t0fW1EOLBAmTP2GB6YpGiFU0OanRglCK+KPotbiUowtvHtlgJpNG/jdxRer8t6Qa/HUaYt1WB+lJ53GuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754397787; c=relaxed/simple;
	bh=eQhXOdRcHwsQfwiKwAi1pUkTgdi1uEToiJeldO19dt4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ICQ3pdIZiNS+DS5mR4zDfEpn0Q6CXfDRzgd5CRiiwc5flceoKDmTjrHSZ1xs4dcuhSKY7wdSEJcfPMNs7Nbb4CDD/J5IL+IP93QtBpq/4Bg9XvHxsMAF051qkfbuG3gFbDAfYG8TDe1MIT1BcPRD1fBWSaZ2hiIt6CW3gvtP9rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JfSh+ZG5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF2FBC4CEF0;
	Tue,  5 Aug 2025 12:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754397786;
	bh=eQhXOdRcHwsQfwiKwAi1pUkTgdi1uEToiJeldO19dt4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JfSh+ZG5LZUktZIhaTtmd5poK9R2Rk3QSjy9rQLepyA43XG2mUky9662IkEOYMUKY
	 QNaz915c9v/ndGsMRBibvh1kCvaPc1fZhIEehISxAXKNRfUG5oiKAWIVLJ/qPo7NG0
	 cF6XZtIVL9MMSfBr/so/t6AorUE5uvCugnUfeGm/AXvVU3qwh9m5oAGaYo6Pt6BR0c
	 ntYtbFer8BRSjWqxXEA/hrgMj/i+QgDG0+5rRbppLkwQURRH/Yc0beDHr3bi/ovMXZ
	 IbdrNhtMX6AVnJOm2qcX3MnhNNARb3vhJLAKwNi/H5qCL5+YHbNRFMrd7Va2/DKYtO
	 qxtLh84bY/Ryw==
Date: Tue, 5 Aug 2025 14:43:02 +0200
From: Christian Brauner <brauner@kernel.org>
To: Qu Wenruo <wqu@suse.com>, Anand Jain <anand.jain@oracle.com>
Cc: Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <quwenruo.btrfs@gmx.com>, 
	Qu Wenruo <wqu@suse.de>, linux-btrfs <linux-btrfs@vger.kernel.org>, 
	David Sterba <dsterba@suse.com>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: Should seed device be allowed to be mounted multiple times?
Message-ID: <20250805-tragweite-keule-31547b419bc3@brauner>
References: <aef03da8-853a-4c9f-b77b-30cf050ec1a5@suse.de>
 <4cdf6f5c-41e8-4943-9c8b-794e04aa47c5@suse.de>
 <8daff5f7-c8e8-4e74-a56c-3d161d3bda1f@oracle.com>
 <bddc796f-a0e0-4ab5-ab90-8cd10e20db23@suse.de>
 <184c750a-ce86-4e08-9722-7aa35163c940@oracle.com>
 <bc8ecf02-b1a1-4bc0-80e3-162e334db94a@gmx.com>
 <a3db2131-37a8-469f-a20d-dc83b2b14475@oracle.com>
 <510675a5-7cb2-4838-87e0-9fb0e9f114f0@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <510675a5-7cb2-4838-87e0-9fb0e9f114f0@suse.com>

On Tue, Aug 05, 2025 at 10:22:49AM +0930, Qu Wenruo wrote:
> 
> 
> 在 2025/8/5 10:06, Anand Jain 写道:
> > 
> > 
> > > > Thanks for the comments.
> > > > Our seed block device use-case doesn’t fall under the kind of risk that
> > > > BLK_OPEN_RESTRICT_WRITES is meant to guard against—it’s not a typical
> > > > multi-FS RW setup. Seed devices are readonly, so it might be reasonable
> > > > to handle this at the block layer—or maybe it’s not feasible.
> > 
> > 
> > > Read-only doesn't prevent the device from being removed suddenly.
> > 
> > I don't see how this is related to the BLK_OPEN_RESTRICT_WRITES flag.
> > Can you clarify?
> 
> It's not related to that flag, I'm talking about the fs_bdev_mark_dead(),
> and the remaining 3 callbacks.
> 
> Those call backs are all depending on the bdev holder to grab a super block.
> 
> Thus a block device should and can not have multiple super blocks.

I'm pretty sure you can't just break the seed device sharing use-case
without causing a lot of regressions...

If you know what the seed devices are than you can change the code to
simply use the btrfs filesystem type as the holder without any holder
operations but just for seed devices. Then seed devices can be opened
by/shared with any btrfs filesystem.

The only restriction is that you cannot use a device as a seed device
that another btrfs filesystem uses as a non-seed device because then it
will be fully owned by the other btrfs filesystem. But Josef tells me
you can only use it as a seed device anyway.

IOW, if you have a concept of shareable devices between different btrfs
filesystems then it's fine to reflect that in the code. If really needed
you can later add custom block holder ops for seed devices so you can
e.g., iterate through all filesystems that share the device.

