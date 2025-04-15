Return-Path: <linux-fsdevel+bounces-46433-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CBDBA895AD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 09:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3BC718979CD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 07:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94051274671;
	Tue, 15 Apr 2025 07:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m3CdO1Oe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0E824C67A;
	Tue, 15 Apr 2025 07:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744703567; cv=none; b=Z+FGqcEPPcxGWH1vlDHw9pxmAf5t7Nzp5WzXbSTgCyeL3h8khyiPAm7pS7N6/n7gTggEOUa/ASJkqCwogN5Eep7JjW4yevKkZ/uiiX5wkG3ubm94DBbTvgV7ovT1Pyzwu0kpw2mn2GnBrEcrPPR8AD3+wQwl0GLg9yH2F5P0OWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744703567; c=relaxed/simple;
	bh=F1+z5QDEOA6VH1pZErpvrrad7ZYMutqq0ODAhFb3cXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aa/i3kFugSCLZdjerlkKxMDtQx8MNH5wHdBvcyrls2+YtlYj6mZ8UuU6Yv/rfrixiiR7gVIOlYO+Nuh6n0+vyCo/0gaYuM8viw7jKID0itr9IpFYw5hdGf7PLuam3MBOK49vum8I69PCoP8BU3bw/2zIO4KWQ1FuG3T9rQ9qcmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m3CdO1Oe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A908DC4CEE9;
	Tue, 15 Apr 2025 07:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744703566;
	bh=F1+z5QDEOA6VH1pZErpvrrad7ZYMutqq0ODAhFb3cXk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m3CdO1OeyDYKhuD0nV5JR+nrAaBbxY5V0WnfqLLyG67QCBrDa6eiINNnQ5Bxi8nOS
	 rcr6IDNjM04R14U3rP356s6GiTY/kfd/DLzrulyw5ZjBkR3z4TG+EgUzMcmIdXm3gn
	 PUPxUiXGm1d7+LUcGiiN1ulOodFp5vsJ4RpkzH2/aHhimDWfEartUnQzNTVy+LXYEy
	 hK/aNCvMYJoBuKuGZvbJK5WrdAnpe/vGVB1JJUBLWObYoACC6w/EYbX0kqXSZ3MmjC
	 fIrCJq08lQImjtiJSNrBzkyv21VgEKfbRB+MaUtDwivBsrWTlG3PVQm2gusnmtv5c+
	 RkLk+vl0niWSQ==
Date: Tue, 15 Apr 2025 09:52:41 +0200
From: Christian Brauner <brauner@kernel.org>
To: David Sterba <dsterba@suse.cz>, 
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>, 
	now4yreal <now4yreal@foxmail.com>, Jan Kara <jack@suse.com>, Viro <viro@zeniv.linux.org.uk>, 
	Bacik <josef@toxicpanda.com>, Stone <leocstone@gmail.com>, Sandeen <sandeen@redhat.com>, 
	Johnson <jeff.johnson@oss.qualcomm.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Bug Report] OOB-read BUG in HFS+ filesystem
Message-ID: <20250415-wohin-anfragen-90b2df73295b@brauner>
References: <tencent_B730B2241BE4152C9D6AA80789EEE1DEE30A@qq.com>
 <20250414-behielt-erholen-e0cd10a4f7af@brauner>
 <Z_0aBN-20w20-UiD@casper.infradead.org>
 <20250414162328.GD16750@twin.jikos.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250414162328.GD16750@twin.jikos.cz>

On Mon, Apr 14, 2025 at 06:23:28PM +0200, David Sterba wrote:
> On Mon, Apr 14, 2025 at 03:21:56PM +0100, Matthew Wilcox wrote:
> > On Mon, Apr 14, 2025 at 04:18:27PM +0200, Christian Brauner wrote:
> > > On Mon, Apr 14, 2025 at 09:45:25PM +0800, now4yreal wrote:
> > > > Dear Linux Security Maintainers,
> > > > I would like to report a OOB-read vulnerability in the HFS+ file
> > > > system, which I discovered using our in-house developed kernel fuzzer,
> > > > Symsyz.
> > > 
> > > Bug reports from non-official syzbot instances are generally not
> > > accepted.
> > > 
> > > hfs and hfsplus are orphaned filesystems since at least 2014. Bug
> > > reports for such filesystems won't receive much attention from the core
> > > maintainers.
> > > 
> > > I'm very very close to putting them on the chopping block as they're
> > > slowly turning into pointless burdens.
> > 
> > I've tried asking some people who are long term Apple & Linux people,
> > but haven't been able to find anyone interested in becoming maintainer.
> > Let's drop both hfs & hfsplus.  Ten years of being unmaintained is
> > long enough.
> 
> Agreed. If needed there are FUSE implementations to access .dmg files
> with HFS/HFS+ or other standalone tools.
> 
> https://github.com/0x09/hfsfuse
> https://github.com/darlinghq/darling-dmg

Ok, I'm open to trying. I'm adding a deprecation message when initating
a new hfs{plus} context logged to dmesg and then we can try and remove
it by the end of the year.

