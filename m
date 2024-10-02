Return-Path: <linux-fsdevel+bounces-30737-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4110E98E021
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 18:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E07971F20F9D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 16:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5892C1D0E3D;
	Wed,  2 Oct 2024 16:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="o1wPmnyS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A947A1D0DFE;
	Wed,  2 Oct 2024 16:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727885081; cv=none; b=ZgcbCjvNvB+Ia2rWgxmtCjAbcEpH8bbSR37x8BTUXBSCJXvXYRe8tFYqC7TFCULsXTiPvPFutWupfExqXqzaO8/2MHruUH9oY5suhhvjA9DsW82GlOdE8KaNinyAM+meqwnJMkQLp1EcuDG+BfBfAvlokaEGvHWFt3dZC7DgKvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727885081; c=relaxed/simple;
	bh=ZZxEQCxUcgKjKWnIjigTux19tiimsXOqcGVMh/pOsLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Coo/nPuJIxNwDPdWDW0+lF70Ys1eT2mrIk4upYU5M6cAmPa6M22SXoEh94G3UK7TC13GajugS7kapcwlA4lscl0pVk+CNo3BOzrH403nkVTJnGhY5qHHNFVDSrxfYUGMLRCvj/EKiix0KIPbUDDEvkStYE9D5IpZDc3dR8qlhc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=o1wPmnyS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4FB4C4CECD;
	Wed,  2 Oct 2024 16:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727885081;
	bh=ZZxEQCxUcgKjKWnIjigTux19tiimsXOqcGVMh/pOsLg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o1wPmnyS3MDD0g+O1BV/73nyXxVNmsj9VASntY9Gq9O8p9K6kUjMSBTHUtiOqCvRu
	 V6dyR+4t1xWh9TH/3f3VduYPjOxMV+JoIkigpkb0mu6yglViAnKmCHXqGj3QzKfhgU
	 /apB5AX+FVlJpMWVkNIMHsCM6QDqGuQ6DUFy1yI8=
Date: Wed, 2 Oct 2024 18:04:38 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Christian Brauner <brauner@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] rust: miscdevice: add base miscdevice abstraction
Message-ID: <2024100223-unwitting-girdle-92a5@gregkh>
References: <20241001-b4-miscdevice-v2-0-330d760041fa@google.com>
 <20241001-b4-miscdevice-v2-2-330d760041fa@google.com>
 <af1bf81f-ae37-48b9-87c0-acf39cf7eca7@app.fastmail.com>
 <20241002-rabiat-ehren-8c3d1f5a133d@brauner>
 <CAH5fLgjdpF7F03ORSKkb+r3+nGfrnA+q1GKw=KHCHASrkz1NPw@mail.gmail.com>
 <20241002-inbegriff-getadelt-9275ce925594@brauner>
 <10dca723-73e2-4757-8e94-22407f069a75@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10dca723-73e2-4757-8e94-22407f069a75@app.fastmail.com>

On Wed, Oct 02, 2024 at 03:45:08PM +0000, Arnd Bergmann wrote:
> On Wed, Oct 2, 2024, at 14:23, Christian Brauner wrote:
> 
> > and then copy the stuff via copy_struct_from_user() or copy back out to
> > user via other means.
> >
> > This way you can safely extend ioctl()s in a backward and forward
> > compatible manner and if we can enforce this for new drivers then I
> > think that's what we should do.
> 
> I don't see much value in building generic code for ioctl around
> this specific variant of extensibility. Extending ioctl commands
> by having a larger structure that results in a new cmd code
> constant is fine, but there is little difference between doing
> this with the same or a different 'nr' value. Most drivers just
> always use a new nr here, and I see no reason to discourage that.
> 
> There is actually a small risk in your example where it can
> break if you have the same size between native and compat
> variants of the same command, like
> 
> struct old {
>     long a;
> };
> 
> struct new {
>     long a;
>     int b;
> };
> 
> Here, the 64-bit 'old' has the same size as the 32-bit 'new',
> so if we try to handle them in a shared native/compat ioctl
> function, this needs an extra in_conmpat_syscall() check that
> adds complexity and is easy to forget.

Agreed, "extending" ioctls is considered a bad thing and it's just
easier to create a new one.  Or use some flags and reserved fields, if
you remember to add them in the beginning...

Anyway, this is all great, but for now, I'll take this series in my tree
and we can add onto it from there.  I'll dig up some sample code that
uses this too, so that we make sure it works properly.  Give me a few
days to catch up before it lands in my trees...

thanks,

greg k-h

