Return-Path: <linux-fsdevel+bounces-57093-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB49B1EA1A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 16:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7112F4E2763
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 14:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE3D27EC80;
	Fri,  8 Aug 2025 14:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ul4RDosv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4A727E05F;
	Fri,  8 Aug 2025 14:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754662501; cv=none; b=TIhz3YWb0rj7EuHqWDDP3tX+exbWrpBE5BX8v3xgudU2eR4v1pOot7iXll2qHUuq5sjp0TaH3KNLy5hRYHXmo2jk/C5sezQhT7k8QlRMQUeSpZ27gCju1xDIjptV4Ya31/08PTWleZt8QNPJdsck+v0fLFIYRGAXr+0UMbrS/2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754662501; c=relaxed/simple;
	bh=HKIkgDzMLDwzvzKcSbUoDlFcm9sGFZMnObzsmCeGRbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZlT4fTAwL6H7AgzjxXNbzsEXVguQX5lnl6GEy4rUVB1QTedi8kV+TpArLczJzc5cNDv49lU6NaOfvGP7nLmWa3TKO+gg604KDBXoO6fyrynWQt0AcVWbcnkCtZ9kMcg+xA/o35UfkdEbt0nJ4u5yjXYbc6W34BNBPukhH93HBhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ul4RDosv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22B1DC4CEED;
	Fri,  8 Aug 2025 14:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754662500;
	bh=HKIkgDzMLDwzvzKcSbUoDlFcm9sGFZMnObzsmCeGRbk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ul4RDosvdyO3wvUFC9dpG5zZP+OhqJpvY6w4eDfUSuYA2AQLSHCJlkKZCkOY2LLjP
	 Qtkd4Vee/lax31JRFeEYVYLYAylGeMvoEM45Bvn1W6/hoyuXNUB2/UR4QvXrDaIDLW
	 s6+0+Kp9hpeneR2Ru2Xa7EmtJH4PHg33ncPjZNQy9oz4BM/qLDzYXYnp4i6QBASt6z
	 nsGc/7PSDMwEbjKZqKUqlhHJ1GgNYEiX+fP05VZAubvlVEe0BrW3LoGJKPPO6DOOtq
	 kLdTiZtv3XGb8h8qDBmd6m2xFNPU8KcOyrz6kF/6PTiyiNTm7Y5zOmKdVfj+0gOslK
	 FaXmVQPl4LrDQ==
Date: Fri, 8 Aug 2025 16:14:55 +0200
From: Christian Brauner <brauner@kernel.org>
To: Qu Wenruo <wqu@suse.com>
Cc: Anand Jain <anand.jain@oracle.com>, Josef Bacik <josef@toxicpanda.com>, 
	Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.de>, 
	linux-btrfs <linux-btrfs@vger.kernel.org>, David Sterba <dsterba@suse.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: Should seed device be allowed to be mounted multiple times?
Message-ID: <20250808-liest-allumfassend-2fb553ad1fb3@brauner>
References: <aef03da8-853a-4c9f-b77b-30cf050ec1a5@suse.de>
 <4cdf6f5c-41e8-4943-9c8b-794e04aa47c5@suse.de>
 <8daff5f7-c8e8-4e74-a56c-3d161d3bda1f@oracle.com>
 <bddc796f-a0e0-4ab5-ab90-8cd10e20db23@suse.de>
 <184c750a-ce86-4e08-9722-7aa35163c940@oracle.com>
 <bc8ecf02-b1a1-4bc0-80e3-162e334db94a@gmx.com>
 <a3db2131-37a8-469f-a20d-dc83b2b14475@oracle.com>
 <510675a5-7cb2-4838-87e0-9fb0e9f114f0@suse.com>
 <20250805-tragweite-keule-31547b419bc3@brauner>
 <6a85c9c0-36ac-4a69-a0d5-4bc5846cd5c7@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6a85c9c0-36ac-4a69-a0d5-4bc5846cd5c7@suse.com>

On Wed, Aug 06, 2025 at 07:50:06AM +0930, Qu Wenruo wrote:
> 
> 
> 在 2025/8/5 22:13, Christian Brauner 写道:
> > On Tue, Aug 05, 2025 at 10:22:49AM +0930, Qu Wenruo wrote:
> > > 
> > > 
> > > 在 2025/8/5 10:06, Anand Jain 写道:
> > > > 
> > > > 
> > > > > > Thanks for the comments.
> > > > > > Our seed block device use-case doesn’t fall under the kind of risk that
> > > > > > BLK_OPEN_RESTRICT_WRITES is meant to guard against—it’s not a typical
> > > > > > multi-FS RW setup. Seed devices are readonly, so it might be reasonable
> > > > > > to handle this at the block layer—or maybe it’s not feasible.
> > > > 
> > > > 
> > > > > Read-only doesn't prevent the device from being removed suddenly.
> > > > 
> > > > I don't see how this is related to the BLK_OPEN_RESTRICT_WRITES flag.
> > > > Can you clarify?
> > > 
> > > It's not related to that flag, I'm talking about the fs_bdev_mark_dead(),
> > > and the remaining 3 callbacks.
> > > 
> > > Those call backs are all depending on the bdev holder to grab a super block.
> > > 
> > > Thus a block device should and can not have multiple super blocks.
> > 
> > I'm pretty sure you can't just break the seed device sharing use-case
> > without causing a lot of regressions...
> 
> It's not that widely affecting, we can still share the same seed device for
> all different sprout fses, just only one of them can be mounted at the same
> time.
> 
> And even with that limitation, it won't affect most (or any) real world use
> cases.
> 
> Even the most complex case like using seed devices as rootfs, and we want to
> sprout the rootfs again, just remove the seed device from the current
> rootfs, then one can mount the seed device again.
> 
> > 
> > If you know what the seed devices are than you can change the code to
> > simply use the btrfs filesystem type as the holder without any holder
> > operations but just for seed devices. Then seed devices can be opened
> > by/shared with any btrfs filesystem.
> 
> But we will lose all the bdev related events.
> 
> We still want to sync/freeze/thaw the real sprouted fs in the end.
> 
> > 
> > The only restriction is that you cannot use a device as a seed device
> > that another btrfs filesystem uses as a non-seed device because then it
> > will be fully owned by the other btrfs filesystem. But Josef tells me
> > you can only use it as a seed device anyway.
> > 
> > IOW, if you have a concept of shareable devices between different btrfs
> > filesystems then it's fine to reflect that in the code. If really needed
> > you can later add custom block holder ops for seed devices so you can
> > e.g., iterate through all filesystems that share the device.
> 
> Sure it's possible, with a lot of extra code looking up where the seed
> device belongs, and all the extra bdev event proxy.
> 
> 
> But I'd say, the seed device specification is not well specified in the very
> beginning, thus it results a lot of "creative" but not practical use cases.
> 
> Yes, this will result some regression, but I'd prefer a more sounding and
> simpler logic for the whole seed device, with minimal impact to the most
> common existing use cases.

Ok, I'm not in a position to argue this effectively. If you think you an
reasonably get away with this regression so be it. But if this ends up
in a total revert of the conversion even though we'd have alternative
solution I'm not going to be happy...

