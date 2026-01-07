Return-Path: <linux-fsdevel+bounces-72594-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 839AECFC9F4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 07 Jan 2026 09:33:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 546E33016ECA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jan 2026 08:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1841B29BDA1;
	Wed,  7 Jan 2026 08:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="m8ClonE8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CC32868A7;
	Wed,  7 Jan 2026 08:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767774821; cv=none; b=lWInWcDwVYGFpqVHXulWA9c2ah1PqaBnrB9tnNJAyF+QPjJ6euY6NlVZNyDLFp1Q1rN39ukWTVL6YNgCgJMX8pDim4GCjNfmoDwB+pMqXwfbY/kLzQjara4rjBCDTOvn7/jldserL9l5WcMDR4ssB+ocfwsPeTu48f6Gbijw2kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767774821; c=relaxed/simple;
	bh=mSkh1s1tOj32LJpUSDpZUt9EmrLP8rYmqmw3XiPuo78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LkWUPz0pyAzFZgkHiPrstEI1Di/IPeVS/XaoFzZVgneT+WEaVT77pW7MqL2PdTGlKOF4Ouv7iorTZpTUxLkps6lJTYYhzlksbjTIwVC8Z1/U9YzdjByq/GCQwKaqrkeO44yBsJYVjnTTKJrEm2veRWVerfsL14TrpAyGbMyFg00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=m8ClonE8; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=JOTgDoBhNMdzi3z1A9Z2+FORb7HFHRG/+HJpEV/ok1g=; b=m8ClonE8SiqkHzbifDO+8o7toM
	2EgeQurGzjarlRA5KjwgkUjrroYRQJR7ZBml5WG6UC4Pkc8KuvDXqKovGCvXCY+JHx1ASTpLuXVBj
	AElKdNr/nykpwNKDKPRC70RyBq/ZxonicWL40WWXyukyJlrEgzhh85EuYOv+jG/54OAOnyR+Grejl
	ZPB2lD83x55AEGDX/alzAM9BiMjlF1FK5iWKmg9sGyqKC9GL4uKSrEOWDaLqPqZXko8fiiT9Dp34H
	lZwA6D0bIbgeRLtD50ONkxTVXrDVSaNGKCVMlLdohuXF9L/AzvDDY8DQClFhh2XIkdcxQ9AlDJ2Kq
	i5N7FD5Q==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdOyu-0000000D7oI-319K;
	Wed, 07 Jan 2026 08:33:28 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 696B3300329; Wed, 07 Jan 2026 09:33:27 +0100 (CET)
Date: Wed, 7 Jan 2026 09:33:27 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Gary Guo <gary@garyguo.net>
Cc: Alice Ryhl <aliceryhl@google.com>, Boqun Feng <boqun.feng@gmail.com>,
	Will Deacon <will@kernel.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>,
	Magnus Lindholm <linmag7@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Lyude Paul <lyude@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/5] rust: sync: support using bool with READ_ONCE
Message-ID: <20260107083327.GB272712@noisy.programming.kicks-ass.net>
References: <20251231-rwonce-v1-0-702a10b85278@google.com>
 <20251231-rwonce-v1-3-702a10b85278@google.com>
 <20260106124326.GY3707891@noisy.programming.kicks-ass.net>
 <20260106181201.22806712.gary@garyguo.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260106181201.22806712.gary@garyguo.net>

On Tue, Jan 06, 2026 at 06:12:01PM +0000, Gary Guo wrote:
> On Tue, 6 Jan 2026 13:43:26 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:

> > Does this hardcode that sizeof(_Bool) == 1? There are ABIs where this is
> > not the case.
> 
> Hi Peter,
> 
> Do you have a concrete example on which ABI/arch this is not true?
> 
> I know that the C spec doesn't mandate _Bool and char are of the same size
> but we have tons of assumptions that is not guaranteed by standard C..

Darwin/PowerPC famously has sizeof(_Bool) == 4

Win32: Visual C++ 4.2 (and earlier) had sizeof(bool)==4 (they mapped
bool to int), while Visual C++ 5.0 introduced a native _Bool and moved
to 1 byte.

Early RISC CPUs (MIPS, PowerPC, Alpha) had severe penalties for byte
access and their compilers would've had sizeof(bool)=={4,8}.

I think AVR/Arduino also has sizeof(bool) == sizeof(int) which is 2.



