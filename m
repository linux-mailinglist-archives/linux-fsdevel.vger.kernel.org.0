Return-Path: <linux-fsdevel+bounces-27107-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4939C95EA58
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 09:27:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05FBB286ABE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 07:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30EAC13212B;
	Mon, 26 Aug 2024 07:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="eYAnrPy3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CACD12BEBE;
	Mon, 26 Aug 2024 07:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724657214; cv=none; b=mMQ1Sq6W9sNAKgp6twW9C/f5AfzlZHM6tZ+jYxDWhAWitShKfik3NB/F6mOemoDUl4VQuVCRhd00WcwXi+zK40ENJSkmEpxVSzltbTu7J7mjoGWENIteS0wYDyQu/LVBremcac5K7cx4jPt7tykeW4CPYOkII8NM3Bg+vfN+8sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724657214; c=relaxed/simple;
	bh=OyH99wmO5mv066v8pAidbzidLzJx3ynfsY7lGCuhtNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iEZz/okHFVg9dtt0wEtAuD/kr0NVIs6s1dHTFkrUgEqHesRiODLUHMToHywwNGBnNXETCF3zLTKQKUpwN2dw6IkfzxowVu8T+k+/mdQ3KQum+aGo+sPwk7KoWSrIno+h7bgADqBfH/kY+FtFY/zlWx+imjNdIZViyM8J4/4YJuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=eYAnrPy3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF2BEC4FDF3;
	Mon, 26 Aug 2024 07:26:51 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="eYAnrPy3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1724657210;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w24dLA36c/d+xQ7ZOImOMWGl1II9pRfdgFurGBE0teA=;
	b=eYAnrPy37tSdpNsOmLxnE9vtVohlmjxR65Olke78XoDNkBDbyRAPVZ8yVj5TfBfvzC93iz
	U17fXHlJI9Qzp1HLsBACdsK6/LpPt0sDt6PMsbbcE1euKmR/4Icub25zv3gIElrlQ9wXEB
	9UYlaBoAY1m9Yx1tf5dw5a/jQPgDNBY=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id d127c021 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 26 Aug 2024 07:26:50 +0000 (UTC)
Date: Mon, 26 Aug 2024 09:26:40 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
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
Subject: Re: [PATCH v2 13/17] selftests: vdso: Don't hard-code location of
 vDSO sources
Message-ID: <ZswuMITw0PLJJBuU@zx2c4.com>
References: <cover.1724309198.git.christophe.leroy@csgroup.eu>
 <a40d859dba5654239650eec44d75ab45c98221f4.1724309198.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a40d859dba5654239650eec44d75ab45c98221f4.1724309198.git.christophe.leroy@csgroup.eu>

On Thu, Aug 22, 2024 at 09:13:21AM +0200, Christophe Leroy wrote:
> Architectures use different location for vDSO sources:
> 	arch/mips/vdso
> 	arch/sparc/vdso
> 	arch/arm64/kernel/vdso
> 	arch/riscv/kernel/vdso
> 	arch/csky/kernel/vdso
> 	arch/x86/um/vdso
> 	arch/x86/entry/vdso
> 	arch/powerpc/kernel/vdso
> 	arch/arm/vdso
> 	arch/loongarch/vdso
> 
> Don't hard-code vdso sources location in selftest Makefile,
> instead create a vdso/ symbolic link in tools/arch/$arch/ and
> update Makefile accordingly.

That seems like a good way of handling it. As archs add their
implementations, they can just add the symlink and do no more work. It
will also make review slightly easier: if I don't see the symlink added,
I'll know the submitter didn't actually test their chacha :-P.

I'll take this into my random.git tree now as a fix.

Jason

