Return-Path: <linux-fsdevel+bounces-16865-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 625188A3D6A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Apr 2024 17:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECC2CB216FD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Apr 2024 15:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1EE248CD4;
	Sat, 13 Apr 2024 15:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PG/ETt95"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36BE947A52;
	Sat, 13 Apr 2024 15:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713021908; cv=none; b=JMN5h/Tb+3nATMegqJHz4+9u+XZ9HiNYrc77t9IlZANLaKl2nIOJWK+49/xjiB/pU3oyJkse9U+V4o4Ln1Ku19EQfeK4V62lWEbQjqEzMLf9Pbryepud/yj2dFMl47WuEpvbZkTbR/Qu+WDvfqNCuRc2/YchjoI03qacG7EmDj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713021908; c=relaxed/simple;
	bh=VoaAhMD+KhsHLDJ/g0q7xTIV6soPlt6qxpZCLZTQ61s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QHvfw2GD/GL8FXe1IP3O3b1waELUT8sIgTVGYMygg2I+vJMyfvPlgS9M1MjtSIbA0OX5gutJJrjk/yEA/9cRj7iq7h2DZkimAnSpbjG+bwpaoHn2vyPndxTmUWL0j+vQJpte/nw38kR8Ag49kk5RV4ErravPKh0jeM7KGy2jAJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PG/ETt95; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF490C2BBFC;
	Sat, 13 Apr 2024 15:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713021907;
	bh=VoaAhMD+KhsHLDJ/g0q7xTIV6soPlt6qxpZCLZTQ61s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PG/ETt954ndwXloFe6YoQGeaE9A44q1ZaLxGo9xhrEeCu1gR4vuVIeqVDbNJQNouV
	 RDPpcunKwbCPjZETe3XOvJ3o99wt9VD/f5fD8chLW88cKaNR00D21YfnF4FR3vWCyi
	 xjkKPADpXtI9xUR3OFIQZ5lmNQ1M0Rhgk3orUcpwzh/Rec1OXot3GHHe9Gs9z7IMoL
	 3PyLenEYqgd0nzUquSxCmfWLRXvey2GeY9LmUigaFTw7RAPIwCx+eqoqBkvrxWcHEe
	 RP2x7gykwk49eNA28Ea3/PuCbmDOXPZqcdvoXdoXjDFhxEGBAWTREkxsKVYwxuzZrq
	 XEZakMEeCu/NA==
Date: Sat, 13 Apr 2024 17:25:01 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Jan Kara <jack@suse.cz>, Yu Kuai <yukuai1@huaweicloud.com>, hch@lst.de, 
	axboe@kernel.dk, linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org, 
	yi.zhang@huawei.com, yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH vfs.all 22/26] block: stash a bdev_file to read/write raw
 blcok_device
Message-ID: <20240413-hievt-zweig-2e40ac6443aa@brauner>
References: <20240407030610.GI538574@ZenIV>
 <8f414bc5-44c6-fe71-4d04-6aef3de8c5e3@huaweicloud.com>
 <20240409042643.GP538574@ZenIV>
 <49f99e7b-3983-8074-bb09-4b093c1269d1@huaweicloud.com>
 <20240410105911.hfxz4qh3n5ekrpqg@quack3>
 <20240410223443.GG2118490@ZenIV>
 <20240411-logik-besorgen-b7d590d6c1e9@brauner>
 <20240411140409.GH2118490@ZenIV>
 <20240412-egalisieren-fernreise-71b1f21f8e64@brauner>
 <20240412112919.GN2118490@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240412112919.GN2118490@ZenIV>

On Fri, Apr 12, 2024 at 12:29:19PM +0100, Al Viro wrote:
> On Fri, Apr 12, 2024 at 11:21:08AM +0200, Christian Brauner wrote:
> 
> > Your series just replaces bd_inode in struct block_device with
> > bd_mapping. In a lot of places we do have immediate access to the bdev
> > file without changing any calling conventions whatsoever. IMO it's
> > perfectly fine to just use file_mapping() there. Sure, let's use
> > bdev_mapping() in instances like btrfs where we'd otherwise have to
> > change function signatures I'm not opposed to that. But there's no good
> > reason to just replace everything with bdev->bd_mapping access. And
> > really, why keep that thing in struct block_device when we can avoid it.
> 
> Because having to have struct file around in the places where we want to
> get to page cache of block device fast is often inconvenient (see fs/buffer.c,
> if nothing else).

Yes, agreed. But my point is why can't we expose bdev_mapping() for
exactly that purpose without having to have that bd_mapping member in
struct block_device? We don't want to trade bd_inode for bd_mapping in
that struct imho. IOW, if we can avoid bloating struct block device with
additional members then we should do that. Is there some performance
concern that I'm missing and if so are there numbers to back this?

> It also simplifies the hell out of the patch series - it's one obviously
> safe automatic change in a single commit.

It's trivial to fold the simple file_mapping() conversion into a single
patch as well. It's a pure artifact of splitting the patches per
subsystem/driver. That's just because people have wildly different
opinions on how to do such conversion. But really, that can be trivially
dealt with.

> And AFAICS the flags-related rationale can be dealt with in a much simpler
> way - see #bf_flags in my tree.

That's certainly worth doing independent of this discussion.

