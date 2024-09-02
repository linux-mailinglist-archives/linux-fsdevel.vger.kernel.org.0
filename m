Return-Path: <linux-fsdevel+bounces-28265-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF23F968A20
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 16:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5540B281622
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 14:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CEE621C163;
	Mon,  2 Sep 2024 14:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="i1U/TFM/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8431A263A;
	Mon,  2 Sep 2024 14:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725287850; cv=none; b=uunlUWgJ0DIhGmOo92TEhfgoYCzyI2PDbiyHLymwvUi5IcPf3/aI4UQ0BlaUr3j3TsZWOHLplN83SSeD2+GsUrJVuRAttmO0A7O7KS6liEPndSMKOz59q4EWxIwGfZQ96cnEcOXcM8otAuDZcc5vIrvA9l8im0AsgkAVbSWbkM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725287850; c=relaxed/simple;
	bh=gpTjIBth8xskV4yK843F5+CB269IaZCQg800LCCrZlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=egBV7/OQu6yy6uq4YYUBr5hS8xrJNRlxYkPQOFyz1PwVUqau0LWrUh81KaJhbmlgQOTGCsu0WkMZUUESu8/4Apt5jbGuxBVtzCG1oA1A9bw0lPvNaW6tBchHmXBhCbAeI6EM7mZwBYpUoRerY0UN1L0FiJQx0I9FudvfoanQ+a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=i1U/TFM/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DB3CC4CEC2;
	Mon,  2 Sep 2024 14:37:27 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="i1U/TFM/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1725287845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fkpr2xyIOoNVSN6u9wpBQgcyAP1uccLTt9mgRczfpKU=;
	b=i1U/TFM/BVYMk5TlS2vnBMnfGpj32tpFcSRnNwTo99N5lrPyNwJjZr8pkxe6jXhDmkDbjn
	GWCnZdMN+yY/+ANdCkUyfXNpGinu8fcfRlZAsDMhrKZE6VFWFmnpGRjRv73QnO4bRbnrxQ
	dbBjZkpe5RvVnXQOmj1jYisPJP5j5YU=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id b222261e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 2 Sep 2024 14:37:25 +0000 (UTC)
Date: Mon, 2 Sep 2024 16:37:24 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Andrew Morton <akpm@linux-foundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
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
Subject: Re: [PATCH v4 5/5] powerpc/vdso: Wire up getrandom() vDSO
 implementation on PPC64
Message-ID: <ZtXNpLbk2jj4Hr4c@zx2c4.com>
References: <cover.1725278148.git.christophe.leroy@csgroup.eu>
 <27de70dcc356e56754a03a2887a97597f5e840a4.1725278148.git.christophe.leroy@csgroup.eu>
 <ZtWyeuCfzZ66fVsg@zx2c4.com>
 <bdf1a515-b3d0-471d-89ee-989ae0d63202@csgroup.eu>
 <ZtXE-AISB4w9U9Yc@zx2c4.com>
 <c411b0c6-1806-4e4d-8bcf-51f0747fcd19@csgroup.eu>
 <ZtXJfiA1lU55JLMM@zx2c4.com>
 <dac37bce-9616-450c-8c1e-aa24dcbfb882@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dac37bce-9616-450c-8c1e-aa24dcbfb882@csgroup.eu>

On Mon, Sep 02, 2024 at 04:27:12PM +0200, Christophe Leroy wrote:
> Hi Jason, hi Michael,
> 
> Le 02/09/2024 à 16:19, Jason A. Donenfeld a écrit :
> > On Mon, Sep 02, 2024 at 04:16:48PM +0200, Christophe Leroy wrote:
> >> Can do that, but there will still be a problem with chacha selftests if
> >> I don't opt-out the entire function content when it is ppc64. It will
> >> build properly but if someone runs it on a ppc64 it will likely crash
> >> because only the low 32 bits of registers will be saved.
> > 
> > What if you don't wire up the selftests _at all_ until the ppc64 commit?
> > Then there'll be no risk.
> > 
> > (And I think I would prefer to see the 32-bit code all in the 32-bit
> > commit; that'd make it more straight forward to review too.)
> 
> I'd be fine with that but I'd like feedback from Michael on it: Is there 
> a risk to only get PPC32 part merged as a first step or will both PPC32 
> and PPC64 go together anyway ?
> 
> I would prefer not to delay PPC32 because someone doesn't feel confident 
> with PPC64.

I have no objection to applying these at the same time.

