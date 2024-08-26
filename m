Return-Path: <linux-fsdevel+bounces-27121-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0936595EBE5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 10:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BC661C22DA3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 08:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D13146D6E;
	Mon, 26 Aug 2024 08:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="otTIgrC+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6443F145344;
	Mon, 26 Aug 2024 08:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724660614; cv=none; b=OKpNuMkFCqi029569VBCqJ4c7GrnFsaRUqnQtFHZal7ziO/Xo1eMDDhDe7klJYHKVE4HtpnDp6Uj0Xi2R6laRXSNgC9SMIrAf4UInIR5naHiIt8p6ff9X9jv4otRokYRYg39jFZcye3JBW6LHlm3cR6QFI/JNqyvXtqnMyi4NNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724660614; c=relaxed/simple;
	bh=3uKATtOL83Z5QEGsjy8Wsg0sCsAdTB22VF159CgEMo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J/h7y5LbbWkuJ+0kmSfznI05oPXGGaO6j6VEVHdSR7D7yVGKkLE0b4ujq7Qw1SCC4Ab0LC8KJBYbhNtwMY9f321T2ML7DglTVsMuvNWA6vGybG+xx05x0wGG1QTVbbJhTWUNGXFzlNpfIimSis0qqdR3ZO15AZRXVFJI05Ce4Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=otTIgrC+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4163C8CDC1;
	Mon, 26 Aug 2024 08:23:31 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="otTIgrC+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1724660610;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qkFrjwbdGTStl7OVlIXz1n12hbxUuy9LwHmcEdC3iMI=;
	b=otTIgrC+soX/VqUWzpk/m1mnp5EFDbirwfJwWcvktux0MKC8gvCukjU40UHEqN77mMAbLr
	7OSc7RG8dxenJKS4pZoRfAhfRbt3mFK0RlApFAN8AAbeWZlsVTEjG7PeL6jPUY08oeTk5F
	/KFMChRXYVZaKTmepPvIcM3dCYTkmvc=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 7287b5b0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 26 Aug 2024 08:23:30 +0000 (UTC)
Date: Mon, 26 Aug 2024 10:23:20 +0200
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
Subject: Re: [PATCH v2 00/17] Wire up getrandom() vDSO implementation on
 powerpc
Message-ID: <Zsw7eP_X_Vw4FOm3@zx2c4.com>
References: <cover.1724309198.git.christophe.leroy@csgroup.eu>
 <Zswsennpw6fvigVh@zx2c4.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zswsennpw6fvigVh@zx2c4.com>

On Mon, Aug 26, 2024 at 09:19:22AM +0200, Jason A. Donenfeld wrote:
> Hi Christophe,
> 
> Thanks for this series. There are quite a few preliminary patches in it,
> before you get to the PPC part, which fix up general build system or test
> harness correctness issues. Since some of those affect all architectures
> that are adding vDSO getrandom() support for 6.12, I'm going to take
> those into my random.git tree as a fix for 6.11 now, in hopes that the
> new archs can mostly go into arch trees without too many tree
> interdependencies.
> 
> So I'll reply to individual patches for that, mentioning which ones I
> extract.

I've committed a bunch of these to:

    https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git/log/

For a v3, if you rebase on there, that'd make things easier for me to
keep picking patches that I intend to send out for 6.11-rc6 later this
week. And then hopefully your 6.12 ppc implementation can just go in via
the ppc tree with my eventual ack on the crypto part, without needing
these interdependencies.

Jason

