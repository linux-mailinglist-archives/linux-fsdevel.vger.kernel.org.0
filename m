Return-Path: <linux-fsdevel+bounces-20143-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C138CEC8C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 May 2024 00:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D97151F21EFA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 May 2024 22:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68DA12DDAD;
	Fri, 24 May 2024 22:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="bfVqHYkv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA60D7E792;
	Fri, 24 May 2024 22:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716591430; cv=none; b=dJa9TpOK/QXT2o/QgTxqTLfARjlN8anDrAwoOkZSfbrQIVVO0hT3JqWjpGmMdDHcztMEwq6SgI3J0s1YBaLUZC319621oo2MVJKJ2Nh7N2/vty0X92bA+C19GX/UmlEXchkTLmO0Yp6xV/tRMK9Z1MZUvlZgZ1vBgNymEpCnrNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716591430; c=relaxed/simple;
	bh=DNccZvpZOFVPzw5iv19JSrpXebrRznjN6qDOBxwfpcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MZP+5A8oe56uhTAiGMSfkxvOkfb1cHpT5omE4BhHr7bX96KG1NoIRRr9x5wnfvncOETS5ZGPacMs/d/nR8hJ6iA7GD5g3cTAR4urSfnogONZQRSb3BrqgZEERblASzQRXX3ZESsptUd+uwva6DVWLK6tHcaNuPWJDisol66Tf5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=bfVqHYkv; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hYs4ZKXmk7I4+l7YLdpq+LGHLH6EgJ2slOFrsMAyMtQ=; b=bfVqHYkvIy4chaOmDU6p5KXBo9
	GL65kr85GH6v92B82mGjxB/vH8Jwa0z6xdFdaNcg6RwDtP/nC+AlGdoEhTn2b8GlLrf8l/oBCug0b
	Es7Zn9jOxyXdDGY5rjqtnVbTXx0vg7tNlepGd95a9NHUipsU8fk/4lcfJs5mTGNswjY6z+jZOxa1+
	/IbCbAa/1uwJjTmPFX0r52Jtz4U4ONljXN5l377WCMKfm4C3365Mejrt3sQqz7Deeql5CYk2XVQOJ
	pxlqtWRPb76zPO2YrEqlUB1m5oEW0jKAaH1R2ozRQl3D6XWcYY3h681APuDlpRQXo8tr5EMJUppye
	A8M4T1Wg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1sAdq4-005yAP-1R;
	Fri, 24 May 2024 22:56:40 +0000
Date: Fri, 24 May 2024 23:56:40 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Alice Ryhl <aliceryhl@google.com>
Cc: brauner@kernel.org, a.hindborg@samsung.com, alex.gaynor@gmail.com,
	arve@android.com, benno.lossin@proton.me, bjorn3_gh@protonmail.com,
	boqun.feng@gmail.com, cmllamas@google.com, dan.j.williams@intel.com,
	dxu@dxuuu.xyz, gary@garyguo.net, gregkh@linuxfoundation.org,
	joel@joelfernandes.org, keescook@chromium.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	maco@android.com, ojeda@kernel.org, peterz@infradead.org,
	rust-for-linux@vger.kernel.org, surenb@google.com,
	tglx@linutronix.de, tkjos@android.com, tmgross@umich.edu,
	wedsonaf@gmail.com, willy@infradead.org, yakoyoku@gmail.com
Subject: Re: [PATCH v6 3/8] rust: file: add Rust abstraction for `struct file`
Message-ID: <20240524225640.GU2118490@ZenIV>
References: <20240524-anhieb-bundesweit-e1b0227fd3ed@brauner>
 <20240524191714.2950286-1-aliceryhl@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240524191714.2950286-1-aliceryhl@google.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, May 24, 2024 at 07:17:13PM +0000, Alice Ryhl wrote:
> > And then those both implement a get_file() method so the caller can take
> > an explicit long-term reference to the file.
> 
> Even if you call `get_file` to get a long-term reference from something
> you have an fdget_pos reference to, that doesn't necessarily mean that
> you can share that long-term reference with other threads. You would
> need to release the fdget_pos reference first. For that reason, the
> long-term reference returned by `get_file` would still need to have the
> `File<MaybeFdgetPos>` type.

Why would you want such a bizarre requirement?

> Note that since it forgets which fd and fd table it came from, calls to
> `fdget` are actually not a problem for sending our long-term references
> across threads. The `fdget` requirements only care about things that
> touch the entry in the file descriptor table, such as closing the fd.
> The `ARef<File>` type does not provide any methods that could lead to
> that happening, so sharing it across threads is okay *even if* there is
> an light reference. That's why I have an `MaybeFdgetPos` but no
> `MaybeFdget`.

Huh?

What is "the entry in the file descriptor table"?  Which one and in which one?

> 	let file = File::fget(my_fd)?;
> 	// SAFETY: We know that there are no active `fdget_pos` calls on
> 	// the current thread, since this is an ioctl and we have not
> 	// called `fdget_pos` inside the Binder driver.
> 	let thread_safe_file = unsafe { file.assume_no_fdget_pos() };
> 
> (search for File::from_fd in the RFC to find where this would go)
> 
> The `assume_no_fdget_pos` call has no effect at runtime - it is purely a
> compile-time thing to force the user to use unsafe to "promise" that
> there aren't any `fdget_pos` calls on the same fd.

Why does fdget_pos() even matter?  The above makes no sense...

Again, cloning a reference and sending it to another thread is perfectly
fine.  And what's so special about fdget_pos()/fdput_pos() compared to
fdget()/fdput()?

_What_ memory safety issues are you talking about?

