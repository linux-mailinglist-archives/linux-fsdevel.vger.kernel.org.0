Return-Path: <linux-fsdevel+bounces-16201-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E8B89A03B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 16:52:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 783071C224E8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 14:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119FF16F29E;
	Fri,  5 Apr 2024 14:52:48 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3744716DEAB;
	Fri,  5 Apr 2024 14:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712328767; cv=none; b=QulPvWPx2+GlWsptP0WorpQQmZxR0fbi9rWbl3AQPhtcLik97wQGVUxekxpFQ9JCYIrmc086FB1PurYoCzcJJM1gW2M6h+pfk/GUzcPx++m4N+N2UVrbtbLxMyyc5AhC94kIxU0NnXIcV3AbunvhheCKwEYqlw2WJZ58829LtDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712328767; c=relaxed/simple;
	bh=bL2giRgf/f1M6TVUVmUCOeofYNHANZ5VQjcrrlLM6V0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GBNxoIoekZUBuOOKU3r8uYqcIuh8Z79bpLjBhp5Id0aaqP1rflW3Z/2yQpV06noLPSW3ImXz4uEbV3B9PssQArnLYYre7bDjeYsLlcTsq1ilRNsI0j5UdSNFRN/QRV18aNYG0a25vuh3o+gOSwtlU/tjkhhVEQM5q7h93+e64NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 354FD68D08; Fri,  5 Apr 2024 16:52:41 +0200 (CEST)
Date: Fri, 5 Apr 2024 16:52:40 +0200
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Amir Goldstein <amir73il@gmail.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	syzbot <syzbot+9a5b0ced8b1bfb238b56@syzkaller.appspotmail.com>,
	gregkh@linuxfoundation.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
	tj@kernel.org, valesini@yandex-team.ru, Jan Kara <jack@suse.cz>,
	Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [syzbot] [kernfs?] possible deadlock in kernfs_fop_llseek
Message-ID: <20240405145240.GA6931@lst.de>
References: <00000000000098f75506153551a1@google.com> <0000000000002f2066061539e54b@google.com> <CAOQ4uxiS5X19OT2MTo_LnLAx2VL9oA1zBSpbuiWMNy_AyGLDrg@mail.gmail.com> <20240404081122.GQ538574@ZenIV> <20240404082110.GR538574@ZenIV> <CAOQ4uximHfK78KFabJA3Hf4R0En6-GfJ3eF96Lzmc94PGuGayA@mail.gmail.com> <20240405065135.GA3959@lst.de> <20240405-ozonwerte-hungrig-326d97c62e65@brauner> <20240405-liebschaft-effekt-ca71fb6e7699@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405-liebschaft-effekt-ca71fb6e7699@brauner>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Apr 05, 2024 at 03:48:20PM +0200, Christian Brauner wrote:
> * There's early_lookup_bdev() which deals with PARTUUID,
>   PARTLABEL, raw device number, and lookup based on /dev. No actual path
>   lookup involved in that.
> 
> * So the only interesting case is lookup_bdev() for /sys/power/suspend.
>   That one takes arbitrary paths. But being realistic for a moment...
>   How many people will specify a device path that's _not_ some variant
>   of /dev/...? IOW, how many people will specify a device path that's
>   not on devtmpfs or a symlink on devtmpfs? Probably almost no one.

That's not the point.  The poins is that trying to do the dumb name
to bdev translation in early_lookup_bdev is wrong.  Distro had and have
their own numbering schemes, and not using them bypasses access
control.  We should never use that at runtime.

> <brauner> So /sys/power/resume does systemd ever write anything other than a /dev/* path in to there?
> <maintainer> Hmm? You never do that? It only accepts devno.
> 
> So that takes away one of the main users of this api. So I really
> suspect that arbitrary device path is unused in practice. Maybe I'm all
> wrong though.

I'm all fine with just accepting a devno and no name.  But I fear it
will break something as someone added it for whatever use case they had
(and we should not have allowed that back then, but that ship has sailed
unfortunately)

