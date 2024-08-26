Return-Path: <linux-fsdevel+bounces-27104-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D97E95EA3C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 09:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E59DCB20D0D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 07:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD58C12CD89;
	Mon, 26 Aug 2024 07:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="j1IJS+MS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F72980611;
	Mon, 26 Aug 2024 07:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724656776; cv=none; b=iptdJjJwvkjQ2XJcucF43bDjd5G+UZq+hs3ckCRQ6M7D0/B1KRltTh9OU5uGYnu9MZA6Nf5r3FXsBlzq4F7hg63+kCy9O1yyxKNy3Z/j/jF9ozJeODSLqy2HoIBZ30QNm88b224Upa9h6FEYLQ+Ic58i1foviJya1Rvd2vS1Dg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724656776; c=relaxed/simple;
	bh=5mnxkRlBDghVp+jV0qHPEpLxDRs2U12I4ncTzaWP+rA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ERd825Rg148OQfsn+yGI5bdQw1VUbuR6j4+31hyxAegbEcFcNrhdK4QNycCMGHtGjsDaAaPDOnKRhvPlMR2PO/kcaK/1rc3r36oNMGP2U1ncmhMd0cG9H9h1Ky1G5DVaVu2WbdSa6fK8G0+wGnLkHmGS9JZ05bIskfVDzSI9iSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=j1IJS+MS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53143C8CDCE;
	Mon, 26 Aug 2024 07:19:33 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="j1IJS+MS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1724656771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5mnxkRlBDghVp+jV0qHPEpLxDRs2U12I4ncTzaWP+rA=;
	b=j1IJS+MSiGszC/AZy4D3uJ/andjVajwkIyrQoUshcUHxGJMb2WL2259Af5/W64kkm2vxcD
	jF7007HPkvb2yHXa5A2ZPmhxrqe20+doeNB8UTbSMckIY4tAtJ5hFuP4KW3z7N4l7UroHd
	BfKpnFUeAB/F62oewuRJdbaVwBTyfGM=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 746e735a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 26 Aug 2024 07:19:31 +0000 (UTC)
Date: Mon, 26 Aug 2024 09:19:22 +0200
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
Message-ID: <Zswsennpw6fvigVh@zx2c4.com>
References: <cover.1724309198.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1724309198.git.christophe.leroy@csgroup.eu>

Hi Christophe,

Thanks for this series. There are quite a few preliminary patches in it,
before you get to the PPC part, which fix up general build system or test
harness correctness issues. Since some of those affect all architectures
that are adding vDSO getrandom() support for 6.12, I'm going to take
those into my random.git tree as a fix for 6.11 now, in hopes that the
new archs can mostly go into arch trees without too many tree
interdependencies.

So I'll reply to individual patches for that, mentioning which ones I
extract.

Jason

