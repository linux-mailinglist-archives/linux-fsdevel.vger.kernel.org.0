Return-Path: <linux-fsdevel+bounces-27118-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B9D795EB51
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 10:05:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F9C0B241FF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 08:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23A0A13D297;
	Mon, 26 Aug 2024 08:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="euRNN4TD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC5743ABD;
	Mon, 26 Aug 2024 08:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724659291; cv=none; b=pNenXzBGJt9fI6YZiXq35x136tkL/ZbptP90Vn9vw5m9o+x0B69XY0+bF3dl85K5q9WRXvBV1bc/UnYovMxNqD7ptF8mOgD9kpvVW1SdGF5/mgz3lDANf1oDaSMT61gPwGnW64q6Rmc1yvke6F/9HHdU++Wc4vHp7ZmcHblY4vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724659291; c=relaxed/simple;
	bh=PkJbB7g9Jp1ftXVX2Q71jOzQKUk93Y996X0S9kfNOWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tta9LLUdxIdCAKjvP0CXvseRNiIMbkl1yNuCCKABKMz4ArWYQfTOm4vRL6h7BdRSMsgtn1jzfbDT9gNYJZD03oiaCOdO8ZwK1n5BAhuDuMxfBqre6BglRZ9tJuLcewFvAymq22vwuae05J92xiTu3hazjekCeOtSKZMS4G7smTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=euRNN4TD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F8EBC4E692;
	Mon, 26 Aug 2024 08:01:28 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="euRNN4TD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1724659287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jmxPDcYvoBbgyB/umzSWgUasur5EN8gznSbU8g01ECM=;
	b=euRNN4TDD56oHAa0RrIkhmKbl5jtPbgpQ1JiwbhkhFRp8dZmh+ShCB6W/NDpmnIvUxEDTO
	C5cAUMejHJxRuOzUYKKlbojI9lDu8RcjGMFf9vyihfG6AwtbWurhazqeeZpGN7+e3Aq3q6
	CncCu/SuHaoW1H+sZwkK37zSiBxPhZQ=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 955bdc20 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 26 Aug 2024 08:01:26 +0000 (UTC)
Date: Mon, 26 Aug 2024 10:01:17 +0200
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
Subject: Re: [PATCH v2 05/17] vdso: Avoid call to memset() by getrandom
Message-ID: <Zsw2TbCqqlVePJod@zx2c4.com>
References: <cover.1724309198.git.christophe.leroy@csgroup.eu>
 <5deb67090b214f0e6eae96b7c406546d1a16f89b.1724309198.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5deb67090b214f0e6eae96b7c406546d1a16f89b.1724309198.git.christophe.leroy@csgroup.eu>

On Thu, Aug 22, 2024 at 09:13:13AM +0200, Christophe Leroy wrote:
> With the current implementation, __cvdso_getrandom_data() calls
> memset(), which is unexpected in the VDSO.
> 
> Rewrite opaque data initialisation to avoid memset().

I think of the various ways I've seen of fixing this -- e.g. adding a
memset() arch-by-arch -- this is the cleanest and simplest. I'll add
this as a fix to random.git now.

Jason

