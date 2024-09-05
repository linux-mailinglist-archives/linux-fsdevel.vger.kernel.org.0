Return-Path: <linux-fsdevel+bounces-28767-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0450C96E0C1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 19:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 361681C25256
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 17:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA7B1A304D;
	Thu,  5 Sep 2024 17:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="S8oxi/AJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C9C19FA8E;
	Thu,  5 Sep 2024 17:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725555822; cv=none; b=cejyqbeVm++LFquUnjASNVhkf2FVyLmtrimG7QLBRGQudIUbMLIFVFsEex+N5AY+09g5BRQea7sRzmVgZXZHjw+9+jsSs7gSdlHIg3HGntDcuygMJjvsuyXRpgk/9wJxeALc4byXogbcfFJtkLvv8UDzzgA0307PtLsMAdNIwws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725555822; c=relaxed/simple;
	bh=nJr8UA9brtZt8MAxTeFaBGCFlqvqywHjYo6H6YDX4GQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YUcaSXG1gngBBDadnmckMhgR90LhPNoagSM3HGMLETlN6JKkjUilO5mUwTS3bTO6K2DLS2w00b7B9fpUFJ/zHQPRc26Sgkzgcl9XGXfr8cr1QGQMGBDk7I6T9v16mwtYgzRcybh/KWmkDCzs9zdAiC3Q8dX7NWJ+PCwxS9MF+qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=S8oxi/AJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2114C4CEC3;
	Thu,  5 Sep 2024 17:03:39 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="S8oxi/AJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1725555817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2WPPczzM5fWySeHC6qCU5mJN44nYuMHACOhNso4EGCc=;
	b=S8oxi/AJO3vG5kC0wYzvPcvwfn+o0kCttzDIhQelVpgwHEjGgAUGSmBmhwbhPa1WeQUBkb
	zu10fm2SriimEK0oAC9nBbD2fdcQS3U5JLuIJ3Yt6a4wdt2cJhjM7HSPHPV5+s0R7BSnJa
	90zYJO/+yld5Pdz8ajTRqlFukUnSKxg=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 27c37213 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 5 Sep 2024 17:03:37 +0000 (UTC)
Date: Thu, 5 Sep 2024 19:03:34 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Naveen N Rao <naveen@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org,
	llvm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
	Adhemerval Zanella <adhemerval.zanella@linaro.org>,
	Xi Ruoyao <xry111@xry111.site>
Subject: Re: [PATCH v5 4/5] powerpc/vdso: Wire up getrandom() vDSO
 implementation on VDSO32
Message-ID: <ZtnkZsHJESAqU-FH@zx2c4.com>
References: <cover.1725304404.git.christophe.leroy@csgroup.eu>
 <1f49c2ce009f8b007ab0676fb41187b2d54f28b2.1725304404.git.christophe.leroy@csgroup.eu>
 <ZtnYqZI-nrsNslwy@zx2c4.com>
 <85c02620-e8b2-4c97-9905-685a9a4e556d@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <85c02620-e8b2-4c97-9905-685a9a4e556d@csgroup.eu>

On Thu, Sep 05, 2024 at 06:55:27PM +0200, Christophe Leroy wrote:
> 
> 
> Le 05/09/2024 à 18:13, Jason A. Donenfeld a écrit :
> >> +/*
> >> + * The macro sets two stack frames, one for the caller and one for the callee
> >> + * because there are no requirement for the caller to set a stack frame when
> >> + * calling VDSO so it may have omitted to set one, especially on PPC64
> >> + */
> >> +
> >> +.macro cvdso_call funct
> >> +  .cfi_startproc
> >> +	PPC_STLU	r1, -PPC_MIN_STKFRM(r1)
> >> +  .cfi_adjust_cfa_offset PPC_MIN_STKFRM
> >> +	mflr		r0
> >> +	PPC_STLU	r1, -PPC_MIN_STKFRM(r1)
> >> +  .cfi_adjust_cfa_offset PPC_MIN_STKFRM
> >> +	PPC_STL		r0, PPC_MIN_STKFRM + PPC_LR_STKOFF(r1)
> >> +  .cfi_rel_offset lr, PPC_MIN_STKFRM + PPC_LR_STKOFF
> >> +	get_datapage	r8
> >> +	addi		r8, r8, VDSO_RNG_DATA_OFFSET
> >> +	bl		CFUNC(DOTSYM(\funct))
> >> +	PPC_LL		r0, PPC_MIN_STKFRM + PPC_LR_STKOFF(r1)
> >> +	cmpwi		r3, 0
> >> +	mtlr		r0
> >> +	addi		r1, r1, 2 * PPC_MIN_STKFRM
> >> +  .cfi_restore lr
> >> +  .cfi_def_cfa_offset 0
> >> +	crclr		so
> >> +	bgelr+
> >> +	crset		so
> >> +	neg		r3, r3
> >> +	blr
> >> +  .cfi_endproc
> >> +.endm
> > 
> > You wrote in an earlier email that this worked with time namespaces, but
> > in my testing that doesn't seem to be the case.
> 
> Did I write that ? I can't remember and neither can I remember testing 
> it with time namespaces.

It's possible I confused you with someone else? Hum. Anyway...

> >  From my test harness [1]:
> > 
> > Normal single thread
> >     vdso: 25000000 times in 12.494133131 seconds
> >     libc: 25000000 times in 69.594625188 seconds
> > syscall: 25000000 times in 67.349243972 seconds
> > Time namespace single thread
> >     vdso: 25000000 times in 71.673057436 seconds
> >     libc: 25000000 times in 71.712774121 seconds
> > syscall: 25000000 times in 66.902318080 seconds
> > 
> > I'm seeing this on ppc, ppc64, and ppc64le.
> 
> What is the command to use to test with time namespace ?

Look at the C in the commit I linked.

