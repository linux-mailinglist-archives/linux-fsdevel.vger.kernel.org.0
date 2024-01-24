Return-Path: <linux-fsdevel+bounces-8807-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE7A083B274
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 20:43:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FEE61F2555D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 19:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC3413340A;
	Wed, 24 Jan 2024 19:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="KUPBfkJ1";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="KUPBfkJ1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F1C132C13;
	Wed, 24 Jan 2024 19:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706125409; cv=none; b=cmjOhWajhk4Vh8LK2ArORL+SnkFli348OLvoTK5V2sss9Erc7BBd8eAW1f/a0qz9WKLyEJKS+BTqafZGDcMtD58GuOOXKKm7D2GaX/gjF/1LUeGWu6PYpNPyiXNCWOfuoMZbHUmFWZkvmR2eoD7pjr027mDwQhYeM9lqIBtaDuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706125409; c=relaxed/simple;
	bh=tJ6Mi2se4+V7AkOiisaserHeM5LMuQmq4B2z8I8MZkg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Pz1AiXGGN91HDefC7LoCRUzIk4qXzv9Usmdf3cfMGxiMgk2QRG9X4gKTszP5ZNAVJ3V1h/0w0/no7oeMlLe04b+JJ2d63uSFICGHwVQYJslicM8cjRC3NUk/y4zYoCyA1HuN0RgLqwbQhq5HdgUG8MegeFYGZB21MxEtNek4sQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=KUPBfkJ1; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=KUPBfkJ1; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1706125405;
	bh=tJ6Mi2se4+V7AkOiisaserHeM5LMuQmq4B2z8I8MZkg=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=KUPBfkJ1/scjss2kVoz0V4k/o8zraFf2OHNEmnqKnTRCWUfm8IQqpmsIWx5RvSOZ+
	 a2CKvyIyLi0ENqe9nKZHjJ4deH3CfWPriUBVx9ccKe/D9tZxLp1W6iZI9LjvMRRVc/
	 fxpUSslsDIFD3/aMZnvEkRiV5v6eIcy48dtbVzqQ=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id C8910128664D;
	Wed, 24 Jan 2024 14:43:25 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id clMNtITqfoZI; Wed, 24 Jan 2024 14:43:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1706125405;
	bh=tJ6Mi2se4+V7AkOiisaserHeM5LMuQmq4B2z8I8MZkg=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=KUPBfkJ1/scjss2kVoz0V4k/o8zraFf2OHNEmnqKnTRCWUfm8IQqpmsIWx5RvSOZ+
	 a2CKvyIyLi0ENqe9nKZHjJ4deH3CfWPriUBVx9ccKe/D9tZxLp1W6iZI9LjvMRRVc/
	 fxpUSslsDIFD3/aMZnvEkRiV5v6eIcy48dtbVzqQ=
Received: from [192.168.7.112] (unknown [23.31.101.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id B77C41286601;
	Wed, 24 Jan 2024 14:43:23 -0500 (EST)
Message-ID: <37f44c1409334f5dc15d7421e8b7cd3a4ff9ae33.camel@HansenPartnership.com>
Subject: Re: [LSF/MM TOPIC] Rust
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Matthew Wilcox <willy@infradead.org>, lsf-pc@lists.linux-foundation.org,
  linux-fsdevel@vger.kernel.org, rust-for-linux@vger.kernel.org, Miguel
 Ojeda <miguel.ojeda.sandonis@gmail.com>, Alice Ryhl <aliceryhl@google.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Kees
 Cook <keescook@chromium.org>, Gary Guo <gary@garyguo.net>, Dave Chinner
 <dchinner@redhat.com>, David Howells <dhowells@redhat.com>, Ariel Miculas
 <amiculas@cisco.com>, Paul McKenney <paulmck@kernel.org>
Date: Wed, 24 Jan 2024 14:43:21 -0500
In-Reply-To: <bmgzm3wjtcyzsuawscxrdyhq56ckc7vqnfbcjbm42gj6eb4qph@wgkhxkk43wxm>
References: 
	<wjtuw2m3ojn7m6gx2ozyqtvlsetzwxv5hdhg2hocal3gyou3ue@34e37oox4d5m>
	 <ZbAO8REoMbxWjozR@casper.infradead.org>
	 <cf6a065636b5006235dbfcaf83ff9dbcc51b2d11.camel@HansenPartnership.com>
	 <ZbEwKjWxdD4HhcA_@casper.infradead.org>
	 <2e62289ad0fffd2fb8bc7fa179b9a43ab7fe2222.camel@HansenPartnership.com>
	 <bmgzm3wjtcyzsuawscxrdyhq56ckc7vqnfbcjbm42gj6eb4qph@wgkhxkk43wxm>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 2024-01-24 at 13:50 -0500, Kent Overstreet wrote:
> > To illustrate the problem with cryptography in rust: just because
> > it's rust safe doesn't mean its correct or bug free.  Crypto
> > functions are the most difficult to get right (algorithmically,
> > regardless of memory safety).  Look at this Medium report on the
> > top ten bugs in blockchain:
> > 
> > https://medium.com/rektoff/top-10-vulnerabilities-in-substrate-based-blockchains-using-rust-d454279521ff
> > 
> > Number 1 is a rust crypto vulnerability due to insecure randomness
> > in a random number generating function (note it was rust safe code
> > just not properly checked for algorithmic issues by a
> > cryptographer).
> > 
> > The reason for using the kernel functions is that they are vetted
> > by cryptographers and crafted for our environment.
> 
> Are you arguing that typical kernel code is more secure than typical
> Rust code?

For crypto code?  Absolutely, that's what the example above showed. 
It's pretty much impossible to use an insecure rng in the kernel if you
plug into one of our existing APIs.  That's obviously not necessarily
true if you pull a random one from crates.io.

James


