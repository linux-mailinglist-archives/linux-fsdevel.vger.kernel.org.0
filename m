Return-Path: <linux-fsdevel+bounces-27108-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AB2695EA6D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 09:29:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1D59B21D8A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 07:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC705136E01;
	Mon, 26 Aug 2024 07:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="fGS4lsQP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BFAC12CDAE;
	Mon, 26 Aug 2024 07:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724657336; cv=none; b=OfsvaGzutC38nAVxAgAHexPayynCy/NlIjfmYqYhcytpovN1hRjUv+hrnEacsMypOZMI33sdQw0YAU05IS3ElAs1gugk9Os7MMGjETPKq8eIIhRhnN4Ko5X94xXqFgecQyxg0rWgtvNNBxHDGnk/eyG5EwPGW1kdrw/FIsPEnjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724657336; c=relaxed/simple;
	bh=E00tzGpDJcjYlSMLb3KbCmafy2KSXv+2OjPe3U447Io=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UVDLcbc5xV/sSaXRNGceczMnXkFmLdMEpxeD9FG66y8jYvWGjn7Gq9ooVyCLj1zJRVE4my3bezXapLPjrxrjAasIH8vhj2rDD9zMbivp9Aw+ASaIwKURZ4JLDMEQTw/uveyevXvbTEgyiDXS64zjD9xozu1rB3NHSFFq8qpu8JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=fGS4lsQP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 880B9C8CDC1;
	Mon, 26 Aug 2024 07:28:53 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="fGS4lsQP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1724657332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cIIjB88DbOJOvuZ2jjU6lJJKiyoqxEyU/0md06aOA9Y=;
	b=fGS4lsQPmJ47S4KPzgxk3QvyNtKhSk0/NSOVe7mmBsaTQCOpf8LdeOZ8NRFSZVGvJlo+6S
	zya3q8/MC3vnj7W6QkSb/tQ7ibwWIO7gaTmCFFEUbZBJZ4gTKo0ADc09YExEQZvcI0SprG
	MnhV/Nlqebjptb73hPDfjdwYVd0Acps=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 087983a8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 26 Aug 2024 07:28:51 +0000 (UTC)
Date: Mon, 26 Aug 2024 09:28:42 +0200
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
Subject: Re: [PATCH v2 14/17] selftests: vdso: Make test_vdso_getrandom look
 for the right vDSO function
Message-ID: <ZswuqjC8T8TwF8LJ@zx2c4.com>
References: <cover.1724309198.git.christophe.leroy@csgroup.eu>
 <04d1de23a2ff14e2709edd8b75e27b81d703bc57.1724309198.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <04d1de23a2ff14e2709edd8b75e27b81d703bc57.1724309198.git.christophe.leroy@csgroup.eu>

On Thu, Aug 22, 2024 at 09:13:22AM +0200, Christophe Leroy wrote:
> Don't hard-code x86 specific names, use vdso_config definitions
> to find the correct function matching the architecture.
> 
> Add random VDSO function names in names[][]. Remove the #ifdef
> CONFIG_VDSO32, having the name there all the time is harmless
> and guaranties a steady index for following strings.

This is indeed the right way of doing it. Thanks. I'll take this now,
though with one small fixup:

> +	const char *version = versions[VDSO_VERSION];
> +	const char **name = (const char **)&names[VDSO_NAMES];

I'll just do:

        const char *name = names[VDSO_NAMES][6];

Instead of referring to name[6] everywhere after. Seems more straight
forward.

Jason

