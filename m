Return-Path: <linux-fsdevel+bounces-16669-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A6E8A13B3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 13:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 329521C2121F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 11:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E1A14D281;
	Thu, 11 Apr 2024 11:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HLs/6PI8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E79D14C5A4;
	Thu, 11 Apr 2024 11:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712836570; cv=none; b=dh1Dm4Ft+lqGk8/VWaIoCK8Fv6osU3Ij8x1u8pjDAs1zQRNONOQVoOrG4zcWtHcX68DnA3+1HyANntNRobACvHa0wP6kQk1ouT2luYkb79WiORJ5mR9RfitFJy6wCGhlUsa8GsDJbwbJ9qWQhzh6CKdm7W8sZVI443E2rDtBDh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712836570; c=relaxed/simple;
	bh=NHWm6/QuyChhlZB8R4yFfy0w7knNXtALJG38VFYUIoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=osU1G496f0yJ/JafUG3cDNVLYasm+LdWm2TIE0hZqaJM+7Hcn7oVb+VpozxOUJWkSGAEtcNwgMHiCmbELaNxj67FYnLwzkPVCZYhG1KYs50vJ1z+kYxzGyVN73S9pv5eHoMSDUgTvayhyfoOFPYlFoVHgo2qqXsklknx3u836RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HLs/6PI8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4A2BC433C7;
	Thu, 11 Apr 2024 11:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712836570;
	bh=NHWm6/QuyChhlZB8R4yFfy0w7knNXtALJG38VFYUIoM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HLs/6PI8OburW1pE6HFFn+DvKJRXAdO1bAU6kYyJIsbdlo08puYJUlH8xlA6ok6Pb
	 H1vHx8jfnRQ02CSXN5VXvKZVqbpVMzt5uu6S9YI5OCDUw7t7NzaPz9uMh0B8Zar6tb
	 SeLXLBiUTh0P85ncHxZOFov/u5Df9M29JsGt4d/hSle+jeNJP0OowzMY1gTwgg+6Kk
	 92SjotEqT05Kws/v9B6u41Cmi27yuhGttteixMcthqdt3a0jL2N/wOnTiJQSah9wru
	 63M+bg3nHv6Ea1omFnJI6KkVScJvPgZJgajCqSL3LrDB/VXcsQ4T+pBjATUOK+DzSG
	 SBaBpfuQJKTdA==
Date: Thu, 11 Apr 2024 13:56:03 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
Cc: Yu Kuai <yukuai1@huaweicloud.com>, hch@lst.de, axboe@kernel.dk, 
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org, yi.zhang@huawei.com, 
	yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH vfs.all 22/26] block: stash a bdev_file to read/write raw
 blcok_device
Message-ID: <20240411-logik-besorgen-b7d590d6c1e9@brauner>
References: <20240406202947.GD538574@ZenIV>
 <3567de30-a7ce-b639-fa1f-805a8e043e18@huaweicloud.com>
 <20240407015149.GG538574@ZenIV>
 <21d1bfd6-76f7-7ffb-34a4-2a85644674fe@huaweicloud.com>
 <20240407030610.GI538574@ZenIV>
 <8f414bc5-44c6-fe71-4d04-6aef3de8c5e3@huaweicloud.com>
 <20240409042643.GP538574@ZenIV>
 <49f99e7b-3983-8074-bb09-4b093c1269d1@huaweicloud.com>
 <20240410105911.hfxz4qh3n5ekrpqg@quack3>
 <20240410223443.GG2118490@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240410223443.GG2118490@ZenIV>

On Wed, Apr 10, 2024 at 11:34:43PM +0100, Al Viro wrote:
> On Wed, Apr 10, 2024 at 12:59:11PM +0200, Jan Kara wrote:
> 
> > I agree with Christian and Al - and I think I've expressed that already in
> > the previous version of the series [1] but I guess I was not explicit
> > enough :). I think the initial part of the series (upto patch 21, perhaps
> > excluding patch 20) is a nice cleanup but the latter part playing with
> > stashing struct file is not an improvement and seems pointless to me. So
> > I'd separate the initial part cleaning up the obvious places and let
> > Christian merge it and then we can figure out what (if anything) to do with
> > remaining bd_inode uses in fs/buffer.c etc. E.g. what Al suggests with
> > bd_mapping makes sense to me but I didn't check what's left after your
> > initial patches...
> 
> FWIW, experimental on top of -next:

Ok, let's move forward with this. I've applied the first 19 patches.
Patch 20 is the start of what we all disliked. 21 is clearly a bugfix
for current code so that'll go separately from the rest. I've replaced
open-code f_mapping access with file_mapping(). The symmetry between
file_inode() and file_mapping() is quite nice.

Al, your idea to switch erofs away from buf->inode can go on top of what
Yu did imho. There's no real reason to throw it away imho.

I've exported bdev_mapping() because it really makes the btrfs change a
lot slimmer and we don't need to care about messing with a lot of that
code. I didn't care about making it static inline because that might've
meant we need to move other stuff into the header as well. Imho, it's
not that important but if it's a big deal to any of you just do the
changes on top of it, please.

Pushed to
https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.super

If I hear no objections that'll show up in -next tomorrow. Al, would be
nice if you could do your changes on top of this, please.

