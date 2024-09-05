Return-Path: <linux-fsdevel+bounces-28768-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D60A96E0F6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 19:16:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C4F9B2521F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 17:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2318C1A2875;
	Thu,  5 Sep 2024 17:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="hCjAgG29"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BE3522F;
	Thu,  5 Sep 2024 17:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725556588; cv=none; b=O530iULN5Mmd2dTv3J16ORNW/o6H251zA6i0twfTe/x5aOesZByWHikZqSdqbwbJWFbB848w4m/zV+Vx3ff6kOtVS9BnmEDvI9EySEAcIvTYpkDCsLD+3TKkk3/nENu8CZIAChOOD6CtlL7VUf5QdgT2sB3XVlQZOlhIljazxT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725556588; c=relaxed/simple;
	bh=H2OP04J4RUYnSKeA1cXeJ7eXawYISo2nhtstKNwQ4Bg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nk2ozxC/4u/plKm6aHnx4CfQXJWHvtqIzNt24YmOGw+prxxA094O3sH+vteV54C6BQXAnp/6ZNKajQ6r/qqA7FLp0kBvXPCCMMWDFtjbCwybqWf6eJvloYJ5AkfJhWW2uj0EtZ08RF9MJjLqvJeQvYthIc/ETZ//pFPJF1/8G+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=hCjAgG29; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0216CC4CEC3;
	Thu,  5 Sep 2024 17:16:25 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="hCjAgG29"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1725556584;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U/i7kxMFedYKvorYnbQF73cn+5NdhIM30ISsp20UbHg=;
	b=hCjAgG292GvjSYLd7cIJbV9+sE37uAJnudlmH79DWrvxKhI1aT+MkTsEmZIqTXhYJC3AjG
	GKu0T3GOiKFo6Gd/ZQwz0mjJ7G8jNN7vZoXVVqlMX+NTR4p/v66KLBzSg7LZ0ZRymTcpi5
	z8NptxebJrjClHLK2svu5ZYfVCDOfJ0=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id c27291d3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 5 Sep 2024 17:16:24 +0000 (UTC)
Date: Thu, 5 Sep 2024 19:16:20 +0200
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
Message-ID: <ZtnnZMa_Yi-UwhHT@zx2c4.com>
References: <cover.1725304404.git.christophe.leroy@csgroup.eu>
 <1f49c2ce009f8b007ab0676fb41187b2d54f28b2.1725304404.git.christophe.leroy@csgroup.eu>
 <ZtnYqZI-nrsNslwy@zx2c4.com>
 <85c02620-e8b2-4c97-9905-685a9a4e556d@csgroup.eu>
 <ZtnkZsHJESAqU-FH@zx2c4.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZtnkZsHJESAqU-FH@zx2c4.com>

On Thu, Sep 05, 2024 at 07:03:34PM +0200, Jason A. Donenfeld wrote:
> On Thu, Sep 05, 2024 at 06:55:27PM +0200, Christophe Leroy wrote:
> > 
> > 
> > Le 05/09/2024 à 18:13, Jason A. Donenfeld a écrit :
> > >> +/*
> > >> + * The macro sets two stack frames, one for the caller and one for the callee
> > >> + * because there are no requirement for the caller to set a stack frame when
> > >> + * calling VDSO so it may have omitted to set one, especially on PPC64
> > >> + */
> > >> +
> > >> +.macro cvdso_call funct
> > >> +  .cfi_startproc
> > >> +	PPC_STLU	r1, -PPC_MIN_STKFRM(r1)
> > >> +  .cfi_adjust_cfa_offset PPC_MIN_STKFRM
> > >> +	mflr		r0
> > >> +	PPC_STLU	r1, -PPC_MIN_STKFRM(r1)
> > >> +  .cfi_adjust_cfa_offset PPC_MIN_STKFRM
> > >> +	PPC_STL		r0, PPC_MIN_STKFRM + PPC_LR_STKOFF(r1)
> > >> +  .cfi_rel_offset lr, PPC_MIN_STKFRM + PPC_LR_STKOFF
> > >> +	get_datapage	r8
> > >> +	addi		r8, r8, VDSO_RNG_DATA_OFFSET
> > >> +	bl		CFUNC(DOTSYM(\funct))
> > >> +	PPC_LL		r0, PPC_MIN_STKFRM + PPC_LR_STKOFF(r1)
> > >> +	cmpwi		r3, 0
> > >> +	mtlr		r0
> > >> +	addi		r1, r1, 2 * PPC_MIN_STKFRM
> > >> +  .cfi_restore lr
> > >> +  .cfi_def_cfa_offset 0
> > >> +	crclr		so
> > >> +	bgelr+
> > >> +	crset		so
> > >> +	neg		r3, r3
> > >> +	blr
> > >> +  .cfi_endproc
> > >> +.endm
> > > 
> > > You wrote in an earlier email that this worked with time namespaces, but
> > > in my testing that doesn't seem to be the case.
> > 
> > Did I write that ? I can't remember and neither can I remember testing 
> > it with time namespaces.
> 
> It's possible I confused you with someone else? Hum. Anyway...
> 
> > >  From my test harness [1]:
> > > 
> > > Normal single thread
> > >     vdso: 25000000 times in 12.494133131 seconds
> > >     libc: 25000000 times in 69.594625188 seconds
> > > syscall: 25000000 times in 67.349243972 seconds
> > > Time namespace single thread
> > >     vdso: 25000000 times in 71.673057436 seconds
> > >     libc: 25000000 times in 71.712774121 seconds
> > > syscall: 25000000 times in 66.902318080 seconds
> > > 
> > > I'm seeing this on ppc, ppc64, and ppc64le.
> > 
> > What is the command to use to test with time namespace ?
> 
> Look at the C in the commit I linked.

The below also seems to work well for testing on x86. I'll clean that up
and send a patch to the list.

diff --git a/tools/testing/selftests/vDSO/vdso_test_getrandom.c b/tools/testing/selftests/vDSO/vdso_test_getrandom.c
index 8866b65a4605..4df80f769aa7 100644
--- a/tools/testing/selftests/vDSO/vdso_test_getrandom.c
+++ b/tools/testing/selftests/vDSO/vdso_test_getrandom.c
@@ -16,8 +16,11 @@
 #include <sys/mman.h>
 #include <sys/random.h>
 #include <sys/syscall.h>
+#include <sys/ptrace.h>
+#include <sys/wait.h>
 #include <sys/types.h>
 #include <linux/random.h>
+#include <linux/ptrace.h>

 #include "../kselftest.h"
 #include "parse_vdso.h"
@@ -239,9 +242,10 @@ static void fill(void)
 static void kselftest(void)
 {
 	uint8_t weird_size[1263];
+	pid_t child;

 	ksft_print_header();
-	ksft_set_plan(1);
+	ksft_set_plan(2);

 	for (size_t i = 0; i < 1000; ++i) {
 		ssize_t ret = vgetrandom(weird_size, sizeof(weird_size), 0);
@@ -250,6 +254,39 @@ static void kselftest(void)
 	}

 	ksft_test_result_pass("getrandom: PASS\n");
+
+	assert(unshare(CLONE_NEWTIME) == 0);
+	child = fork();
+	assert(child >= 0);
+
+	if (!child) {
+		vgetrandom_init();
+		child = getpid();
+		assert(ptrace(PTRACE_TRACEME, 0, NULL, NULL) == 0);
+		assert(kill(child, SIGSTOP) == 0);
+		assert(vgetrandom(weird_size, sizeof(weird_size), 0) == sizeof(weird_size));
+		_exit(0);
+	}
+	for (;;) {
+		struct ptrace_syscall_info info = { 0 };
+		int status, ret;
+		assert(waitpid(child, &status, 0) >= 0);
+		if (WIFEXITED(status))
+			break;
+		assert(WIFSTOPPED(status));
+		if (WSTOPSIG(status) == SIGSTOP)
+			assert(ptrace(PTRACE_SETOPTIONS, child, 0, PTRACE_O_TRACESYSGOOD) == 0);
+		else if (WSTOPSIG(status) == SIGTRAP | 0x80) {
+			assert(ptrace(PTRACE_GET_SYSCALL_INFO, child, sizeof(info), &info) > 0);
+			if (info.entry.nr == __NR_getrandom &&
+			    ((void *)info.entry.args[0] == &weird_size && info.entry.args[1] == sizeof(weird_size)))
+				exit(KSFT_FAIL);
+		}
+		assert(ptrace(PTRACE_SYSCALL, child, 0, 0) == 0);
+	}
+
+	ksft_test_result_pass("getrandom timens: PASS\n");
+
 	exit(KSFT_PASS);
 }


