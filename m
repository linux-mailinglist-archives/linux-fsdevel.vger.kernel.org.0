Return-Path: <linux-fsdevel+bounces-46448-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45358A89807
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 11:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 563B916BDE3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 09:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB6A28466C;
	Tue, 15 Apr 2025 09:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h8lhZkGj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71411AD41F;
	Tue, 15 Apr 2025 09:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744709495; cv=none; b=XoldVrkrjRB7lBxQPocu68C1oV7G4uRZWbHngGXlbYIv0qahDVwsGGQoI3RYJCiCduGhTFDINojWGCGhccq6apinlLaVrpHtLiIhNUwx8enYqsFsa7NAUdgAgOotrSsdgh73wiSm0ZzJ0h1rBlTidI6ZY+N1ZhQPVYFwxGkXc/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744709495; c=relaxed/simple;
	bh=ZZjxea9kGTZqK61EKBJRyCtQhNZWLg61gtTvU9KDKwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D1IUIH29NZGXIUAJL/bJbjUj+tWuyy2rhUzC6Me1J3FLogMGbnswFEWXvc8NB2EpXHFBAKA/gw1k90sXPxbppBF+vQcUM2PBPFGzIXHPy3diQNCFc9ixKvgB7SxmGD4yZltUZlLRizBfj2vnlatCEIPO8AFKZNcCLhz90+p3/oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h8lhZkGj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29317C4CEDD;
	Tue, 15 Apr 2025 09:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744709494;
	bh=ZZjxea9kGTZqK61EKBJRyCtQhNZWLg61gtTvU9KDKwk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h8lhZkGj9fCQBr7rddZ4KmxM/RYWn/0ac1xWgLWF975Cvt/MWwC6lEvlebj6hqqck
	 oUzFa6wp6diN+ADYAzC7Yx684CA3qJTno2GbOb0ccnXDNAVKrOZa1cuWseLqWHEOZK
	 Lii+SOcehYt5Ti/6Z6zQS5RQVaBjjqInZ9TmFwMIhbPjyj5bjSmkIj0xHCRfTtwE3P
	 YvtR8kp5Go8Jkc7sWereeqM7UMqsJ4kg+4xneDVRYEcDlu8Sib1zUOFeyK7ebqIVWw
	 4yNO3yPpRDp5A8tcdGSh6U64F5fal8/+JmqR0yIxkkZiKyjhiKjwpXM9eE2SPKdipd
	 EaYjEdnx1PwpQ==
Date: Tue, 15 Apr 2025 11:31:28 +0200
From: Christian Brauner <brauner@kernel.org>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: David Sterba <dsterba@suse.cz>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, 
	now4yreal <now4yreal@foxmail.com>, Jan Kara <jack@suse.com>, Viro <viro@zeniv.linux.org.uk>, 
	Bacik <josef@toxicpanda.com>, Stone <leocstone@gmail.com>, Sandeen <sandeen@redhat.com>, 
	Johnson <jeff.johnson@oss.qualcomm.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Bug Report] OOB-read BUG in HFS+ filesystem
Message-ID: <20250415-razzia-umverteilen-4e8864b62583@brauner>
References: <tencent_B730B2241BE4152C9D6AA80789EEE1DEE30A@qq.com>
 <20250414-behielt-erholen-e0cd10a4f7af@brauner>
 <Z_0aBN-20w20-UiD@casper.infradead.org>
 <20250414162328.GD16750@twin.jikos.cz>
 <20250415-wohin-anfragen-90b2df73295b@brauner>
 <786f0a0e-8cea-4007-bbae-2225fcca95b4@wdc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <786f0a0e-8cea-4007-bbae-2225fcca95b4@wdc.com>

On Tue, Apr 15, 2025 at 09:16:58AM +0000, Johannes Thumshirn wrote:
> On 15.04.25 09:52, Christian Brauner wrote:
> > On Mon, Apr 14, 2025 at 06:23:28PM +0200, David Sterba wrote:
> >> On Mon, Apr 14, 2025 at 03:21:56PM +0100, Matthew Wilcox wrote:
> >>> On Mon, Apr 14, 2025 at 04:18:27PM +0200, Christian Brauner wrote:
> >>>> On Mon, Apr 14, 2025 at 09:45:25PM +0800, now4yreal wrote:
> >>>>> Dear Linux Security Maintainers,
> >>>>> I would like to report a OOB-read vulnerability in the HFS+ file
> >>>>> system, which I discovered using our in-house developed kernel fuzzer,
> >>>>> Symsyz.
> >>>>
> >>>> Bug reports from non-official syzbot instances are generally not
> >>>> accepted.
> >>>>
> >>>> hfs and hfsplus are orphaned filesystems since at least 2014. Bug
> >>>> reports for such filesystems won't receive much attention from the core
> >>>> maintainers.
> >>>>
> >>>> I'm very very close to putting them on the chopping block as they're
> >>>> slowly turning into pointless burdens.
> >>>
> >>> I've tried asking some people who are long term Apple & Linux people,
> >>> but haven't been able to find anyone interested in becoming maintainer.
> >>> Let's drop both hfs & hfsplus.  Ten years of being unmaintained is
> >>> long enough.
> >>
> >> Agreed. If needed there are FUSE implementations to access .dmg files
> >> with HFS/HFS+ or other standalone tools.
> >>
> >> https://github.com/0x09/hfsfuse
> >> https://github.com/darlinghq/darling-dmg
> > 
> > Ok, I'm open to trying. I'm adding a deprecation message when initating
> > a new hfs{plus} context logged to dmesg and then we can try and remove
> > it by the end of the year.
> > 
> > 
> 
> Just a word of caution though, (at least Intel) Macs have their EFI ESP 
> partition on HFS+ instead of FAT. I don't own an Apple Silicon Mac so I 
> can't check if it's there as well.

Yeah, someone mentioned that. Well, then we hopefully have someone
stepping up to for maintainership.

