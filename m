Return-Path: <linux-fsdevel+bounces-8505-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF79838656
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 05:24:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 087D71C26C8D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 04:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 344441C33;
	Tue, 23 Jan 2024 04:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RXzMqfzb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED171854
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Jan 2024 04:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705983839; cv=none; b=Gez9pzaIaH8p5Dw+cyYQJq8uQvE9QxWax7d/QZQy4oqKA3XbbQDsMkr0zMuoKvOIdhSqwbD706hX+ylDNJDTXjqInzbh5XC3XFX2/ekcygogpv/BobmJo6XBa0uI2xE/tbNoYzfzeYUE4nIZsw64Ue7yZOKvI6f4fOFYnkgm3Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705983839; c=relaxed/simple;
	bh=/VPfVazbwFpSBC+0ifZqsnv9bctAnhbQS8oMbmkcvYU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hory+LkEAu0UsLqvmCSBfnur3TLZRXhwCrzwACorf6zV1TsVE4EF8Cf1oPkwue/LAEjV6oPGSiK/mnJbxpNEFXR+QDPOwgZjT6qTM1r8oI8aqY3PjpVuua33fzklLuYG3Uag/VGekF/GDULoC4YMzoSN3B9cCtg8/m8bBq0ChRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RXzMqfzb; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 22 Jan 2024 23:23:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705983835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=oj/czkBO9mo00jE3jNADQx+5itN+Q7VPjGprKWae67A=;
	b=RXzMqfzbWo6xMoecnDNoQ+fENXV/YTMFfXjViMQOvbVqCGMbND7UpedA1KvMOaBHM33xch
	WNmcZaEPPuf0MUotWIpw6oHjHi8CAEvSKl7lDNGf7MIT4q/52Zi/eJN/ZWtH4UM01aIjzS
	/SJUdGtp1Y1zOEF6IepGIrVruosit34=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, 
	Alice Ryhl <aliceryhl@google.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Kees Cook <keescook@chromium.org>, Matthew Wilcox <willy@infradead.org>, 
	Gary Guo <gary@garyguo.net>, Dave Chinner <dchinner@redhat.com>, 
	David Howells <dhowells@redhat.com>, Ariel Miculas <amiculas@cisco.com>, 
	Paul McKenney <paulmck@kernel.org>
Subject: [LSF/MM TOPIC] Rust
Message-ID: <wjtuw2m3ojn7m6gx2ozyqtvlsetzwxv5hdhg2hocal3gyou3ue@34e37oox4d5m>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT

There's been ongoing work on safe Rust interfaces to the VFS, as well as
whole new filesystems in Rust (tarfs, puzzlefs), and talk of adding Rust
code for existing filesystems (bcachefs, any day now, I swear).

Maybe it's time to get together and see what sort of
trolling^H^H^H^Hserious design discussions we can come up with?

Possible subtopics:
 - Braces, brackets and arrow signs: does Rust have enough of them, too
   many, or both?

 - Obeying the borrow checker: C programmers are widely renouned for
   creative idiosyncrasies in pointer based data structures; structure
   design; will we be able to fully express our creativity within Rust?
   Or are there VFS abstractions and lifetime rules that will be
   difficult to translate?

 - Perhaps there are annoying VFS rules that in the past required hand
   tattoos to remember, but we'll now be able to teach the compiler to
   remember for us?

   (idmapping comes to mind as one area where we've recently been able
   to increase safety through effective use of the type system - this is
   about way more than just use-after-free bugs)

 - Moving objects around in memory: Rust rather dislikes being told
   objects can't be moved around (a consequence of algebraic data
   types), and this has been a source of no small amount of frustration
   on the Rust side of things. Could we on the C side perhaps find ways
   to relax their constraints? (object pinning, versus e.g. perhaps
   making it possible to move a list head around)

 - The use of outside library code: Historically, C code was either
   written for userspace or the kernel, and not both. But that's not
   particularly true in Rust land (and getting to be less true even in C
   land); should we consider some sort of structure or (cough) package
   management? Is it time to move beyond ye olde cut-and-paste?

 - What's the development and debugging experience been like so far?
   Who's got stories to share?

The Rust-for-Linux people have been great - let's see if we can get them
to join us in Utah this year, I think they'll have things to teach us.

Cheers,
Kent

