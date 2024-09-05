Return-Path: <linux-fsdevel+bounces-28737-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9847796D97A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 14:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5544A28641E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 12:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B6919CD19;
	Thu,  5 Sep 2024 12:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="A9I5x1EB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C0319CC17;
	Thu,  5 Sep 2024 12:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725540992; cv=none; b=csClEaXrFn7gJeHV5QyyiSud4a71TSa9ZtuCBWbjONE9DuB8FuJKaYZ+Tvi2oHM/mPnzbsAtGIaxufeI9TwownG/NdJSUC7BWtKQ+wa0jk+uIW0olj2co/8MKg7pquv0HVnDNnRyPntfZRxVy8S5dUAEssWP7vxqYZGRYfiWNlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725540992; c=relaxed/simple;
	bh=m+5iopGLNzFqbjrMALwt0zwA8EVzJc9BNnAEJ6KONhk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KvCA3xucDNkrvfMgoV/1PX/ekqNY2gRy9kgbVxCAjm8/sUzv6svVgyCWgbsMpzuLeC/K6iFvamvhG0qNaReFd8dqWWsHDzmpUckZqbPKvIWNSwP/qbP2mN4pb9k2SXtvI+AdizmckvCFN9a7VacpSpb1V6Py+OQJY7e0LtAgNg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=A9I5x1EB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B06BC4CEC7;
	Thu,  5 Sep 2024 12:56:29 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="A9I5x1EB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1725540987;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6MTRMH1950H7pYJdyL+qM9S+/x9T4aarJ3EpbvZXG0c=;
	b=A9I5x1EBzjWpsyVHdJmPYjDYEuQpDwByqVQ89KOcyYwjwC/5UglJ7bOVFCORH/KKdLDSsj
	hE0+FEYI1HzmSRsLBGvjoYX+tvf6Yr6IvTYdDzNBFgQnOfkYAjE0L/FEuSL0rfcnnK/EpH
	wvrGrZzEfhJC/aKxpXKjrA1SYDA0ufM=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 83f56dc6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 5 Sep 2024 12:56:27 +0000 (UTC)
Date: Thu, 5 Sep 2024 14:56:22 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
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
Subject: Re: [PATCH v5 0/5] Wire up getrandom() vDSO implementation on powerpc
Message-ID: <Ztmqdr01_idiz64-@zx2c4.com>
References: <cover.1725304404.git.christophe.leroy@csgroup.eu>
 <Zthr1nB_RJ56YD3O@zx2c4.com>
 <87frqe5m5b.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87frqe5m5b.fsf@mail.lhotse>

On Thu, Sep 05, 2024 at 10:18:40PM +1000, Michael Ellerman wrote:
> There is an existing comment in the a/p/vdso/Makefile about the
> fixed-r30 thing, tldr is it's a workaround to avoid breaking old
> versions of Go.

Thanks. Indeed, following Christophe's links yesterday, I tumbled down
that rabbit hole for a bit. Interesting how ABIs ossify unintentionally.


> For the series:
> 
> Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

Excellent, queued up now.

> If you can include Maddy's test results from Power9 in the change log
> for patch 5 that'd be nice.

Was my plan exactly. I replaced the QEMU result with the PowerNV one.

Jason

