Return-Path: <linux-fsdevel+bounces-27574-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9D89627BE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 14:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 384CC1C23A7B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 12:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6801017BB1A;
	Wed, 28 Aug 2024 12:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ODK/7ERo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4366149C7A;
	Wed, 28 Aug 2024 12:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724849471; cv=none; b=aTDbnBswO2cW0d/+dR+Kj2jvcHINY9YWh4TWDYaBVPq1cnxtkF0wJWRvy9V54GtwCXHeSiXHKX6r9L8XNAa1bdTsxz2Mb1pEK5XtTHec1JhaS/dl/4pQ1wXyHfkwkUqa9i4KGhYC21oP8UyHxgDI8H245BKnlGvUd9a0Xx5gH4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724849471; c=relaxed/simple;
	bh=X/ZPnsZ+Te6Cbfi8XNIH7Qv8KvV1JtNjk7KdNe5xbHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OP45orNBrZlOns/UHxs1UdKmyN80beY+8vXiuSTUqxpraENozHjjW5DT7jUHYopTrCKzdfruokSfdTucfvpCXSbwPDXpys8KhMfcOy74V1vL7SnX4nWuPnYnKq1psimNA/zTxr8f/mAETsOqugaeibZP3bzwRs0poZLwpQB1dds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=ODK/7ERo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EADC3C4FEAA;
	Wed, 28 Aug 2024 12:51:08 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ODK/7ERo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1724849467;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oeaYEeMYW7hEo3u8qxst85yaDnh5A2IqHmNMDFLAgFo=;
	b=ODK/7ERoI7S8QMrOJubKV+KYvxjfHTDZ1zzNE6AiRyLjnfeCtBY3W36gNo8wympvGHxdgN
	NSlxiq62JUyQC+aiXpMPbstKEvistBZZgAUjEOeILQQdAc9aNvROXJCsA6m9EfcUlXBIZM
	Xx5CPriIkEngv9c0pT/XBKJFCpvNkmI=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id a0cc7065 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 28 Aug 2024 12:51:06 +0000 (UTC)
Date: Wed, 28 Aug 2024 14:51:05 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Eric Biggers <ebiggers@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Naveen N Rao <naveen@kernel.org>, Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Theodore Ts'o <tytso@mit.edu>,
	Arnd Bergmann <arnd@arndb.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Shuah Khan <shuah@kernel.org>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 05/17] vdso: Avoid call to memset() by getrandom
Message-ID: <Zs8dOXrSp0OdY9s8@zx2c4.com>
References: <cover.1724309198.git.christophe.leroy@csgroup.eu>
 <5deb67090b214f0e6eae96b7c406546d1a16f89b.1724309198.git.christophe.leroy@csgroup.eu>
 <20240827180819.GB2049@sol.localdomain>
 <20240827225330.GC29862@gate.crashing.org>
 <Zs8HirKLk-SrwTIu@zx2c4.com>
 <20240828123313.GD29862@gate.crashing.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240828123313.GD29862@gate.crashing.org>

On Wed, Aug 28, 2024 at 07:33:13AM -0500, Segher Boessenkool wrote:
> On Wed, Aug 28, 2024 at 01:18:34PM +0200, Jason A. Donenfeld wrote:
> > On Tue, Aug 27, 2024 at 05:53:30PM -0500, Segher Boessenkool wrote:
> > > On Tue, Aug 27, 2024 at 11:08:19AM -0700, Eric Biggers wrote:
> > > > > +		for (i = 0; i < ARRAY_SIZE(params->reserved); i++)
> > > > > +			params->reserved[i] = 0;
> 
> This is a loop.  With -ftree-loop-distribute-patterns, the default at
> -O2, this is optimised to
> 
>     memset(params->reserved, 0, ...);
> 
> (which is perfectly fine, since memset is required to be there even
> for freestanding environments, this is documented!)
> 
> > > -fno-tree-loop-distribute-patterns .  But, as always, read up on it, see
> > > what it actually does (and how it avoids your problem, and mostly: learn
> > > what the actual problem *was*!)
> > 
> > This might help with various loops, but it doesn't help with the matter
> > that this patch fixes, which is struct initialization. I just tried it
> > with the arm64 patch to no avail.
> 
> It very much *does* help.  Try harder?  Maybe you typoed?

Scroll up and reread the original patch. You are confused. The loop is
what fixes the matter. It's struct initialization that generates the
memset.

