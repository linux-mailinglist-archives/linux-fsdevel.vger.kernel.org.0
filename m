Return-Path: <linux-fsdevel+bounces-41866-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E2AA38948
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 17:36:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E688D3AB4CF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 16:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E75B22576A;
	Mon, 17 Feb 2025 16:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VfoCrMSp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B723223703;
	Mon, 17 Feb 2025 16:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739810136; cv=none; b=B+blAUXACoYYM36zC3KME6ofLa3y1Ct4X88jns+NMktTm5LDovsXnZtTYReggCSIFYaCwQIVY1BeVZXpSyu9enJGlsFmaTzZFXpWv/YPBdZZ/kum4CZXgQJiK/sv6Txz9gl3YKLdKQXWe4o2xI1fS2NEhgI6EQWxU8DD/wvq9RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739810136; c=relaxed/simple;
	bh=lE8v3cHaPMoIUyZtlB1vlHQgjxDf/rnGpnjVRsPeq58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VY1XwFT/X1eltfIXYfUbLScLvMB37U/7usyhinU7fuxSYJBsI+Z+CC08ZtfbxlwC2oziFsG6I8U20qRTAXD8L4wE5srSz8SLkYShFWKhMRwCovGRH/6rM2FkM1Wfo3E+hvjF/egl7bL8upliEoY3/2A5moY3WL42gVv5mDxcHXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VfoCrMSp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37154C4CED1;
	Mon, 17 Feb 2025 16:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739810135;
	bh=lE8v3cHaPMoIUyZtlB1vlHQgjxDf/rnGpnjVRsPeq58=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VfoCrMSpk6EACaA4rYBe7g8zDZsKhPPRomWHO1Sdgmdh4maL9oMtcO3f13ClINlqz
	 dCdqfFG56QRFjT+IBcng9APi36QBfO3mrKY0A8eM2HdDNgUc8AkULq1NJqxt2bYaf2
	 Zj3i99uV8q2gul/xNEdivP5dVLstiQpGt5a3UCnwJzOa46MAPUpuCmPtXUUmYv6tU1
	 phZUsDVXv/6NCEpJbeKXTJMY6MtOjpxboydCJZBPzr8hi15vZPdOoa0tSuZhbu/PwK
	 nO2JFZ8IiKbSQrU/iWhxNLXtbIyk+YYFH+9boC5hqpkpd6nojLrl9mE7r8teyoa1Jc
	 34lRcnhArXX9Q==
Date: Mon, 17 Feb 2025 17:35:28 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Tamir Duberstein <tamird@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Matthew Wilcox <willy@infradead.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	"Rob Herring (Arm)" <robh@kernel.org>,
	=?iso-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>,
	Asahi Lina <lina@asahilina.net>, rust-for-linux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, Fiona Behrens <me@kloenk.dev>
Subject: Re: [PATCH v16 2/4] rust: types: add `ForeignOwnable::PointedTo`
Message-ID: <Z7NlUN7pSrDnSaMD@cassiopeiae>
References: <20250207-rust-xarray-bindings-v16-0-256b0cf936bd@gmail.com>
 <20250207-rust-xarray-bindings-v16-2-256b0cf936bd@gmail.com>
 <Z7MnxKSSNY7IyExt@cassiopeiae>
 <CAJ-ks9=OG2zPPPPfZd5KhGKgNsv3Qm9iHr2eWXFeL7Zv16QVdw@mail.gmail.com>
 <Z7NEZfuXSr3Ofh1G@cassiopeiae>
 <CAJ-ks9=TrFHiLFkRfyawNquDY2x6t3dwGi6FxnfgFLvQLYwc+A@mail.gmail.com>
 <Z7NJugCD3FThZpbI@cassiopeiae>
 <CAJ-ks9mcRffgyMWxYf=anoP7XWCA1yzc74-NazLZCXdjNqZSfg@mail.gmail.com>
 <Z7NNDucW1-kEdFem@cassiopeiae>
 <CAJ-ks9kZJt=eB0NU-PcXiygjORhhbEhGYEr9g3Mgjcf2-os06w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ-ks9kZJt=eB0NU-PcXiygjORhhbEhGYEr9g3Mgjcf2-os06w@mail.gmail.com>

On Mon, Feb 17, 2025 at 10:50:10AM -0500, Tamir Duberstein wrote:
> On Mon, Feb 17, 2025 at 9:52 AM Danilo Krummrich <dakr@kernel.org> wrote:
> >
> > On Mon, Feb 17, 2025 at 09:47:14AM -0500, Tamir Duberstein wrote:
> > > On Mon, Feb 17, 2025 at 9:37 AM Danilo Krummrich <dakr@kernel.org> wrote:
> > > > You're free to do the change (I encourage that), but that's of course up to you.
> > >
> > > I'll create a "good first issue" for it in the RfL repository.
> >
> > That's a good idea -- thanks.
> 
> What do you think about enabling clippy::ptr_as_ptr?
> https://rust-lang.github.io/rust-clippy/master/index.html#ptr_as_ptr

Seems reasonable to me, but I'm a bit out of competence here.

I know some lints are not stable and hence need to be treated with care, though
this doesn't seem to be one of them.

Additionally, I think the lint would need to be supported by all compiler
versions the kernel supports currently, which also seems to be the case (added
in: 1.51.0).

> 
> Do we currently enable any non-default clippy lints?

Yes, you can check the root Makefile [1].

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Makefile?h=v6.14-rc3#n471

