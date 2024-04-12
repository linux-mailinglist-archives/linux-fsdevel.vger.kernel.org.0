Return-Path: <linux-fsdevel+bounces-16790-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3018A2B12
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 11:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C192A1F22672
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 09:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD1B51C54;
	Fri, 12 Apr 2024 09:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UmcMEDNF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160233D3BC;
	Fri, 12 Apr 2024 09:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712913675; cv=none; b=irjrMUuhZxz7khMYNVonpoSOoTK8TC/PqPzizdKpjdSadJrw97LeKGIduQGQuiVplV5gR4jVh4BmzwOobimFjxbLrSrtkN4u9Bqh11i5gdbtU+uWUFAaAoMwcHiNHH7Ry1/Z/GAYuMff5gXsPHmel46kyK/WkFdbVCzKlh5E2NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712913675; c=relaxed/simple;
	bh=4BIQToTxzepCOKbB6nkJt1qYoU3CTvJHeXqs7Y06pK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RHOdSHvcVhekVm8ffHXvIrQWl32SopaKq6fIMVe5RCD8In+u/Mg56v79vjhmLedu3aEMFL1ZBZUdFBx/0ne0ugZ++Jq4/ZuNBco7oJ7spBCzpZlhykXHfeH55vs2Q/Xy0j+zjyDoc9UEtmVuLqpQEMPDlWgeV+ITM/WHdY5eRjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UmcMEDNF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4268C113CC;
	Fri, 12 Apr 2024 09:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712913674;
	bh=4BIQToTxzepCOKbB6nkJt1qYoU3CTvJHeXqs7Y06pK4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UmcMEDNF0U0OpgUziCh/lrsamzg+XhX7tU8HPW8QRcoMDYJYRtBdSOoyVYpLAV0dG
	 TE+Wnk10xHcKm3oB+mRbDMDBpevPESBuSVTh0VN0X2f3U8rKxOrxqcnHuoes3bxXuX
	 2M0xBu7/5lMrkyzlUNQI343hqtd5e2nSc2lp8HSr9fjMqgxdn6cVISx2f286fFHbgc
	 bMRbYnc7B19exbBG5DQRxwDOaKWHadMR9hFvptZv5zWklNTLKSVCAeKHGtS7yQQAoK
	 uHiHWGOiPkr//fEfNc1YQChSvybGEmBk6YHWUGgMKitBaxU8oJDIvewTNiRk88SNxC
	 jiGhAA1l0f/yw==
Date: Fri, 12 Apr 2024 11:21:08 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Jan Kara <jack@suse.cz>, Yu Kuai <yukuai1@huaweicloud.com>, hch@lst.de, 
	axboe@kernel.dk, linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org, 
	yi.zhang@huawei.com, yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH vfs.all 22/26] block: stash a bdev_file to read/write raw
 blcok_device
Message-ID: <20240412-egalisieren-fernreise-71b1f21f8e64@brauner>
References: <20240407015149.GG538574@ZenIV>
 <21d1bfd6-76f7-7ffb-34a4-2a85644674fe@huaweicloud.com>
 <20240407030610.GI538574@ZenIV>
 <8f414bc5-44c6-fe71-4d04-6aef3de8c5e3@huaweicloud.com>
 <20240409042643.GP538574@ZenIV>
 <49f99e7b-3983-8074-bb09-4b093c1269d1@huaweicloud.com>
 <20240410105911.hfxz4qh3n5ekrpqg@quack3>
 <20240410223443.GG2118490@ZenIV>
 <20240411-logik-besorgen-b7d590d6c1e9@brauner>
 <20240411140409.GH2118490@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240411140409.GH2118490@ZenIV>

On Thu, Apr 11, 2024 at 03:04:09PM +0100, Al Viro wrote:
> On Thu, Apr 11, 2024 at 01:56:03PM +0200, Christian Brauner wrote:
> > On Wed, Apr 10, 2024 at 11:34:43PM +0100, Al Viro wrote:
> > > On Wed, Apr 10, 2024 at 12:59:11PM +0200, Jan Kara wrote:
> > > 
> > > > I agree with Christian and Al - and I think I've expressed that already in
> > > > the previous version of the series [1] but I guess I was not explicit
> > > > enough :). I think the initial part of the series (upto patch 21, perhaps
> > > > excluding patch 20) is a nice cleanup but the latter part playing with
> > > > stashing struct file is not an improvement and seems pointless to me. So
> > > > I'd separate the initial part cleaning up the obvious places and let
> > > > Christian merge it and then we can figure out what (if anything) to do with
> > > > remaining bd_inode uses in fs/buffer.c etc. E.g. what Al suggests with
> > > > bd_mapping makes sense to me but I didn't check what's left after your
> > > > initial patches...
> > > 
> > > FWIW, experimental on top of -next:
> > 
> > Ok, let's move forward with this. I've applied the first 19 patches.
> > Patch 20 is the start of what we all disliked. 21 is clearly a bugfix
> > for current code so that'll go separately from the rest. I've replaced
> > open-code f_mapping access with file_mapping(). The symmetry between
> > file_inode() and file_mapping() is quite nice.
> > 
> > Al, your idea to switch erofs away from buf->inode can go on top of what
> > Yu did imho. There's no real reason to throw it away imho.
> > 
> > I've exported bdev_mapping() because it really makes the btrfs change a
> > lot slimmer and we don't need to care about messing with a lot of that
> > code. I didn't care about making it static inline because that might've
> > meant we need to move other stuff into the header as well. Imho, it's
> > not that important but if it's a big deal to any of you just do the
> > changes on top of it, please.
> > 
> > Pushed to
> > https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.super
> > 
> > If I hear no objections that'll show up in -next tomorrow. Al, would be
> > nice if you could do your changes on top of this, please.
> 
> Objection: start with adding bdev->bd_mapping, next convert the really
> obvious instances to it and most of this series becomes not needed at
> all.
> 
> Really.  There is no need whatsoever to push struct file down all those
> paths.

Your series just replaces bd_inode in struct block_device with
bd_mapping. In a lot of places we do have immediate access to the bdev
file without changing any calling conventions whatsoever. IMO it's
perfectly fine to just use file_mapping() there. Sure, let's use
bdev_mapping() in instances like btrfs where we'd otherwise have to
change function signatures I'm not opposed to that. But there's no good
reason to just replace everything with bdev->bd_mapping access. And
really, why keep that thing in struct block_device when we can avoid it.

> 
> And yes, erofs and buffer.c stuff belongs on top of that, no arguments here.

