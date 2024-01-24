Return-Path: <linux-fsdevel+bounces-8765-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A294C83ABB0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 15:28:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D4F7B2B5CA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 14:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9DBB7E575;
	Wed, 24 Jan 2024 14:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="uSmbXpx2";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="Mj7rfV5A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516437E561;
	Wed, 24 Jan 2024 14:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706106401; cv=none; b=Q8+tPWzARa6BIAtvuAlzrlSxCaTUSVX21X7A8/jmY9067YhF3NEA3rlJgzVPBT1+58NJZ3XNpvmS6x3M+nnJMNMwUidWZbC/CCHMh5O8Mg5eat1jLZe5J/WX3cmOOPWc36DmQU4vbrE/5myogIXaCn7VYAy1ljOGzU0OKP8/fkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706106401; c=relaxed/simple;
	bh=z6HvlejC/nz1/FSz3DCYfhkWullgJqi0Xj8TI/+bano=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EBanYqsD8nAMfCqLSRSdY3uv/8man+fTUbgOsFV+Y+8s0/wBfdzN3JeBZ8ZIVb13CZACyJS12yVj4ys+A003pgPUiqtTPg3AU6VQraSwPxjo4UKMdaaK+QpB3ukBlBugp5Kl0Aeb/7SvTmimwDeOG3S0WaoKLhEC+a98qagNm/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=uSmbXpx2; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=Mj7rfV5A; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1706106398;
	bh=z6HvlejC/nz1/FSz3DCYfhkWullgJqi0Xj8TI/+bano=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=uSmbXpx2o1CaErAMmOrT2372J9gawlIp9n8wxMVjobuJ+k2AgliPng72P/UndH/Hb
	 9Sxumfn/P5P3Sk9AoImcf6/e0c/vyc/KJC7hzBgaQvKgx/lbB+rlBSupuVf+T5aV2B
	 wxnVibqwz4cDQTkRKHWTATfHH8F+lWV5VJKQC3JY=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 2DB801286815;
	Wed, 24 Jan 2024 09:26:38 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id C7Hl9fLd2f7O; Wed, 24 Jan 2024 09:26:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1706106397;
	bh=z6HvlejC/nz1/FSz3DCYfhkWullgJqi0Xj8TI/+bano=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=Mj7rfV5Aw4pzn04rhqswoKDr0yviNTimO9hF/gUSa//L4HSF6PCU7dHhQDzlpv7rW
	 K6JGZ+gn5RB2zZWfA4OzJ21T3HQbE9b0ujviRLeqDsi1uOQNZn57kFbOy3bspcMkjs
	 SdtnSSpgi/p99/6MYWJszo0cy3nxQZiuwCA5zUMM=
Received: from [IPv6:2601:5c4:4302:c21::a774] (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 9840E12867F0;
	Wed, 24 Jan 2024 09:26:36 -0500 (EST)
Message-ID: <cf6a065636b5006235dbfcaf83ff9dbcc51b2d11.camel@HansenPartnership.com>
Subject: Re: [LSF/MM TOPIC] Rust
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Matthew Wilcox <willy@infradead.org>, Kent Overstreet
	 <kent.overstreet@linux.dev>
Cc: lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, Miguel Ojeda
 <miguel.ojeda.sandonis@gmail.com>,  Alice Ryhl <aliceryhl@google.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Kees
 Cook <keescook@chromium.org>, Gary Guo <gary@garyguo.net>, Dave Chinner
 <dchinner@redhat.com>, David Howells <dhowells@redhat.com>, Ariel Miculas
 <amiculas@cisco.com>, Paul McKenney <paulmck@kernel.org>
Date: Wed, 24 Jan 2024 09:26:34 -0500
In-Reply-To: <ZbAO8REoMbxWjozR@casper.infradead.org>
References: 
	<wjtuw2m3ojn7m6gx2ozyqtvlsetzwxv5hdhg2hocal3gyou3ue@34e37oox4d5m>
	 <ZbAO8REoMbxWjozR@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 2024-01-23 at 19:09 +0000, Matthew Wilcox wrote:
> >   - The use of outside library code: Historically, C code was
> > either written for userspace or the kernel, and not both. But
> > that's not particularly true in Rust land (and getting to be less
> > true even in C land); should we consider some sort of structure or
> > (cough) package management? Is it time to move beyond ye olde cut-
> > and-paste?
> 
> Rust has a package manager.  I don't think we need kCargo.  I'm not
> deep enough in the weeds on this to make sensible suggestions, but if
> a package (eg a crypto suite or compression library) doesn't depend
> on anything ridiculous then what's the harm in just pulling it in?

The problem with this is that it leads to combinatoric explosions and
multiple copies of everything[1].  For crypto in particular the last
thing you want to do is pull some random encryption routine off the
internet, particularly if the kernel already supplies it because it's
usually not properly optimized for your CPU and it makes it a nightmare
to deduce the security properties of the system.

However, there's nothing wrong with a vetted approach to this: keep a
list of stuff rust needs, make sure it's properly plumbed in to the
kernel routines (which likely necessitates package changes) and keep it
somewhere everyone can use.

James

[1] just to support this point, I maintain a build of element-desktop
that relies on node (which uses the same versioned package management
style rust does).  It pulls in 2115 packages of which 417 are version
duplicates (same package but different version numbers).


