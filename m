Return-Path: <linux-fsdevel+bounces-27126-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E7ED95EC8F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 10:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A14261C21688
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 08:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8C0145A19;
	Mon, 26 Aug 2024 08:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="QcZNv2yU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B8E13D8B8;
	Mon, 26 Aug 2024 08:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724662719; cv=none; b=lJstM1D57wypSuB1aiPmCYeF6Ot93eg+XY0Loa0L7rrC9UOHIcjyEBdMmrqTtWJXp0ZEq0u0FXLszSwfiJ9bvpqlfPl78XPlFhPb6/uZ/BRKORK9zXzdeVeTXvUrJOuUVDi+GJvHx3tB0hRprDpE9uf2JsNAKQuDDmW7HYJhs+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724662719; c=relaxed/simple;
	bh=RHTdlRJLvh7TUVw6KkABioi08Cm9CNB4/CBIFd9tV9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U3gCmIkD9vwuzxhnqy1WGflteh2qh2CGN7ufqXn7fSuOZdZcPRwRkqd2JpxvdU73jaSIbxHCehuI2lWhig0Gkm9Ai2IcCbdYlPoRjPXNTExe7C8erc+hcCunHbW8rXkEIdJhHu4c3AHJ56RsJ1wQgKmdUzDeEKuhUuelwp8n9CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=QcZNv2yU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EB46C567C1;
	Mon, 26 Aug 2024 08:58:36 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="QcZNv2yU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1724662715;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ocYxyao+YeYVwZkJVZlNCDBZUEKM/vUAfandsZETTJ0=;
	b=QcZNv2yUAl78MTanT1uEILVIG0Rwr7Gq5dxZIeMULB8F3+zNHLp+iJBBgbdma6WoOLSZZm
	dyEAM4d4sn63r+0vrzUEc2Y/7Gvw6Sd+SX+9xw+3TQl5UNUPtgirmdTEW4ELU96hQQ2Ups
	B1IIgm4VbXKEFP704+R3/GvFPvQLfh0=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id b99b8b23 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 26 Aug 2024 08:58:35 +0000 (UTC)
Date: Mon, 26 Aug 2024 10:58:26 +0200
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
Subject: Re: [PATCH v2 02/17] vdso: Clean header inclusion in getrandom
Message-ID: <ZsxDssNPbLkcPetJ@zx2c4.com>
References: <cover.1724309198.git.christophe.leroy@csgroup.eu>
 <2a081f1fff5e40f496153f8e0162fc7ec5adab2e.1724309198.git.christophe.leroy@csgroup.eu>
 <Zsw3xMoX2EI5UUs1@zx2c4.com>
 <7e519ba2-0293-4320-84bf-44f930fc286d@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7e519ba2-0293-4320-84bf-44f930fc286d@csgroup.eu>

On Mon, Aug 26, 2024 at 10:37:49AM +0200, Christophe Leroy wrote:
> 
> 
> Le 26/08/2024 à 10:07, Jason A. Donenfeld a écrit :
> > On Thu, Aug 22, 2024 at 09:13:10AM +0200, Christophe Leroy wrote:
> >>   
> >> +#define _PAGE_SIZE (1UL << CONFIG_PAGE_SHIFT)
> >> +#define _PAGE_MASK (~(_PAGE_SIZE - 1))
> > 
> > If PAGE_SIZE isn't defined at this point, why not just call it PAGE_SIZE
> > instead of _PAGE_SIZE? But if that's the case, why not put the vdso
> > definition of PAGE_SIZE into some vdso header included by this file?
> 
> It was working ok on powerpc but on x86 I got:

Seems like there might be some more fiddling to do, then? Or did you
conclude it's impossible?

