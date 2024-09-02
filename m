Return-Path: <linux-fsdevel+bounces-28262-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD3EA9689C5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 16:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C5941C22B2F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 14:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D9D51E49F;
	Mon,  2 Sep 2024 14:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="KeV5OogA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A4219F139;
	Mon,  2 Sep 2024 14:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725286792; cv=none; b=f8P3PywGiQ44Kx3muRqUFjwN4c1sgbxGNa59MDJ2atpCH+WRkGxN2g+Fq3o0hRbY7jP2vel+DunotSp1IVTgp41C0HiAGs6aJzlyGG8n+iW0EIypAqpbPfaBCW7yLMAFgPCV0TNqo9T20hivtQXZDnfLGOwz59jpJ38wY3dpf30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725286792; c=relaxed/simple;
	bh=k61ZjOC1ybeCJrLZm4+RQOKp9zNpJr6PNFSFYlIpUZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jKvZYrqvwxcFbsKuVTYibR7WK3DHzxNhJVUV9PUnoUWyX5zdumaXT8ZpuDmDAy4zQwnPV+tcFXiY3SpGgECSQB1yl8SpMzY3MgvTzR6++ZUkedj6jQ/wuPDAaqmaFCpTkcwJavK1pKrSl+hcwb5XLEsnH1nysqXrIlg3c3d8m60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=KeV5OogA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9739EC4CEC2;
	Mon,  2 Sep 2024 14:19:49 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="KeV5OogA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1725286788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IdelkNQNEJ/x7d6HdhvWfHMFNgEcvt0QuA/u9U3RtjY=;
	b=KeV5OogAbTBAMOtuoki3DgeJqyVvllDRgndH2dkze3yJLmaacKcbExWRMITKy5or0SV258
	x4gQsu2kUb+oZQiOAJEgQaamdG25Rb8FTyy7E8qPs0Lh1OU6kkbcfMQTYpVqXGsBV9qP8K
	jOeTQOwZFwE9yTVHoh1o8Hd59SW8oSE=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 5527ce07 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 2 Sep 2024 14:19:47 +0000 (UTC)
Date: Mon, 2 Sep 2024 16:19:42 +0200
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
Subject: Re: [PATCH v4 5/5] powerpc/vdso: Wire up getrandom() vDSO
 implementation on PPC64
Message-ID: <ZtXJfiA1lU55JLMM@zx2c4.com>
References: <cover.1725278148.git.christophe.leroy@csgroup.eu>
 <27de70dcc356e56754a03a2887a97597f5e840a4.1725278148.git.christophe.leroy@csgroup.eu>
 <ZtWyeuCfzZ66fVsg@zx2c4.com>
 <bdf1a515-b3d0-471d-89ee-989ae0d63202@csgroup.eu>
 <ZtXE-AISB4w9U9Yc@zx2c4.com>
 <c411b0c6-1806-4e4d-8bcf-51f0747fcd19@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c411b0c6-1806-4e4d-8bcf-51f0747fcd19@csgroup.eu>

On Mon, Sep 02, 2024 at 04:16:48PM +0200, Christophe Leroy wrote:
> Can do that, but there will still be a problem with chacha selftests if 
> I don't opt-out the entire function content when it is ppc64. It will 
> build properly but if someone runs it on a ppc64 it will likely crash 
> because only the low 32 bits of registers will be saved.

What if you don't wire up the selftests _at all_ until the ppc64 commit?
Then there'll be no risk.

(And I think I would prefer to see the 32-bit code all in the 32-bit
commit; that'd make it more straight forward to review too.)

