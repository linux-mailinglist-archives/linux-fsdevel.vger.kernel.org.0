Return-Path: <linux-fsdevel+bounces-8817-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC9283B3C8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 22:20:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 719181C2389B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 21:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9A51353E3;
	Wed, 24 Jan 2024 21:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="p6EBUHlj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCAA1350FA
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jan 2024 21:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706131244; cv=none; b=M7T1pHzhAoVy7ypLCRWuwLHfGmPVXacsVXo368c8YYB9Hv1dy9fAlQu/4Ts8/0+dkJ3GzdTC9IpPMjS42QwDN36NuGjXWyrE4psCyU3+gIme5ALpqi82V5XLEUmMvlTUMQnaItUFIhSO+ntJtf3IQnC8BqQdy9v0DgODVQpx114=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706131244; c=relaxed/simple;
	bh=bQffYBrC51rkcv1085upNJjrNHF7me/8H3wDfFrLFys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a3x09HTAQqDoqR8kyB2ZvOJkEkzVvE/Pw5xAUylw3MY9Eo2w1Pycs6wmdIrzFu/skrvbNVaCxfalYDi0pK6sxTrseWZkXvYZun4QpiFwHSjVQd52sOVPhMX6ImYNYL2QHrH9p8NfLGgn3TvTNl31cQtxo+heAk3t7+9fct1o9hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=p6EBUHlj; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 24 Jan 2024 16:20:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706131241;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BiGrjr/hG3xB2xz0QT2ZW2M4beJpPuD9moDfSoptlG4=;
	b=p6EBUHljBBBhgRJPFaTNlTW+n49jfGUviNsmQCdvgqPbNIiWdhbdMgWO8qo1m/Cx8UXEy3
	/KSTnz/sbBY1W+DTrBL/E8/Zw8HimVfw3jhT9J06w7mGFJ4JibK795gOex+3pHJUVULm6b
	Rls1DvoD6kQ5mGuGFtILzZpAWLbLpM8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: David Howells <dhowells@redhat.com>
Cc: Matthew Wilcox <willy@infradead.org>, 
	lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Alice Ryhl <aliceryhl@google.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Kees Cook <keescook@chromium.org>, Gary Guo <gary@garyguo.net>, 
	Dave Chinner <dchinner@redhat.com>, Ariel Miculas <amiculas@cisco.com>, 
	Paul McKenney <paulmck@kernel.org>
Subject: Re: [LSF/MM TOPIC] Rust
Message-ID: <m3so6o7wa2slahaey3mzt6jvs2us34j2dup7rc2pb4vj4owe5e@amtjjkv4okqk>
References: <ZbAO8REoMbxWjozR@casper.infradead.org>
 <wjtuw2m3ojn7m6gx2ozyqtvlsetzwxv5hdhg2hocal3gyou3ue@34e37oox4d5m>
 <201190.1706050689@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201190.1706050689@warthog.procyon.org.uk>
X-Migadu-Flow: FLOW_OUT

On Tue, Jan 23, 2024 at 10:58:09PM +0000, David Howells wrote:
> Matthew Wilcox <willy@infradead.org> wrote:
> 
> > I really want this to happen.  It's taken 50 years, but we finally have
> > a programming language that can replace C for writing kernels.
> 
> I really don't want this to happen.  Whilst I have sympathy with the idea that
> C can be replaced with something better - Rust isn't it.  The syntax is awful.
> It's like they looked at perl and thought they could beat it at inventing
> weird and obfuscated bits of operator syntax.  Can't they replace the syntax
> with something a lot more C-like[*]?

I've heard you say this before, and I'm still curious what it is you
dislike about Rust syntax... because to my eyes, Rust syntax /is/
already quite C-like and the differences are all obvious fixes and
cleanups for things that have annoyed me for years.

Fixing the statement/expression distinction is really nice, so we no
longer have to use the ridiculous ({}) construct, and that also means
the ternary operator is no longer needed because if and match are now
normal expressions that can have values.

Changing how functions and variables are defined is also a nice fix -
the type of the variable or return value no longer being the first token
means Rust can be parsed in one pass; that's always been a painful part
of the C grammar.

Gegarding macros, C macros are pretty terrible in that they can
completely violate the syntax and know nothing about the syntax tree;
Rust macros operate on token trees and are much more regular (they're
also hygenic!).

Syntax wise, the only annoying thing for me has been getting used to
borrow checker syntax, but I'm more than willing to put up with that for
what it gets us...

