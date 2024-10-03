Return-Path: <linux-fsdevel+bounces-30840-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5048698EB18
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 10:10:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB6EEB20B94
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 08:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F08136E21;
	Thu,  3 Oct 2024 08:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qMqR0r4c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B46126C04;
	Thu,  3 Oct 2024 08:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727942996; cv=none; b=LOWvg3nfFvG3uR50saAtoW+dTXI7G7IJ2ab9gVpJ+KD+OIwC947v8DvqUlL4fUKkwxSV/D8zaUYIDOaUiB0nAbMjcj0beo1A0sUNWgYz3HfiadCL1Xitbuv3xDmjaVwxl1E/a8BGtV+7A98+5/Lnfb1m5ZFbdRBbCKjSlnx/du8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727942996; c=relaxed/simple;
	bh=qQeayOm0L0sSl/y1Csw+TfpLfgb2PW3yPbPgwLvTd0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q8vtrQyToTfr1ICtsCVJQ8QXV7XKBvHyQBpD0Jqgji1IKmGiXXJ16xStwQAtX8rdsItKi2/VmTAplDcXaedxTGQVU0Yh0qzycPYMS+NrCq5/fL7nGJpAMwKCYGRMWgYQ4jtEIbQtf8K6Mf9rs1h1Ah4JY7untpja51S8qUWa1Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qMqR0r4c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC63BC4CECC;
	Thu,  3 Oct 2024 08:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727942996;
	bh=qQeayOm0L0sSl/y1Csw+TfpLfgb2PW3yPbPgwLvTd0c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qMqR0r4c535Qw1/zSFmD71mAE01tk4kDkUOo2n7zhWRb1dhvhhJpqI/NBxQKYxVG9
	 zTRbnISP5rMsldDpTrUVXQTeqjiV7JnknYqTkOi9X0Lwaizj+Epm81HVhDwYcGIdBz
	 OKhvjQ8Vkn1vHHQ+utTO2Xuy5CxgKgJgDNIpI9PSVBY08XqdUMhLGR6FelisZBEa+R
	 gskufR6f7Uf062fx2OoaI02G7SiEOMNVzTK/dcU/E276lLxRm0YG2gn8155r7dmKpU
	 4TasQvuacPMssc4iczt8UNr7FXAHDmIMPlGFUJqo0M+oW2a0XnvDu3qniNXMjkq458
	 PONHRIQSexyxA==
Date: Thu, 3 Oct 2024 10:09:50 +0200
From: Christian Brauner <brauner@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Alice Ryhl <aliceryhl@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] rust: miscdevice: add base miscdevice abstraction
Message-ID: <20241003-atempause-entrichten-2552bfddae99@brauner>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <10dca723-73e2-4757-8e94-22407f069a75@app.fastmail.com>

On Wed, Oct 02, 2024 at 03:45:08PM GMT, Arnd Bergmann wrote:
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

This presupposes that we will have Rust drivers - not C drivers - that
define structs like it's 1990. You yourself and me included try to
enforce that structs are correctly aligned and padded. So I see this as
a non-argument. We wouldn't let this slide in new system calls so I
don't see why we would in new ioctls.

