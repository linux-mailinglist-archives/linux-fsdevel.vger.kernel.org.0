Return-Path: <linux-fsdevel+bounces-49486-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3EF2ABD1BF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 10:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FD204A27A7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 08:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3AC52641C6;
	Tue, 20 May 2025 08:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="jUr8jGEJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4604025F994;
	Tue, 20 May 2025 08:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747729384; cv=none; b=Tmid1apHxWZ7/23KSvvN8sTDkspRzT//R/hm0Uc3tcGvSHEef0iedGIwsd02zIcPuTRkOe6+rS9NiVPyfZ7+0Va1ZNJWc8xFSLCx3YPxkRdjtJE0Q/uq48hnJXT/SyLtponEK4DhZjxFRVoC04yjEeoiUlb7ggIPBE7Fq/QufGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747729384; c=relaxed/simple;
	bh=CbpYojFOx9hi6fdWZji6aYnRHJDIhGVyI2NkMIQwV6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j/7oiNib0+bRyBipmNu2kvZ5I9Nus3VB+4RR157uR1w9vvDWas16RkcREQCllbUpG+VfvCDWizjRBRISxoWfxaEnG0ALQBn7OwbKLWlCiGuzP9vlycZNi4Q/C5gC4x487lPon74Wfd/dT1a6PHe2Nh9xr5eBHBjON6GJEvKHeKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=jUr8jGEJ; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=BwzWdX9UlxauyFitnj8K7HxgnGbZaQA6IrXxNXDLqjA=; b=jUr8jGEJ/jjaGU4sdJ49zJc1my
	9YDku1GJGK1m+i+kdpEoy2TKpaM6cry7J8cWiCJq6/hRYq9V+VaJ3Ak7d0SR0Y8dKCPvx3pHvhYsb
	yIAkI30B0XVGhcLEY830vHZ2K+rntaGKoFHM2IcyOCMMeQFyaUC2ymlDnKp7qKx1Ch7MoL0hp4quU
	MIo0esmeu37Hl6Vk8/JQMBvR+1feNt2Whnbs25l8W5yRJyXOka8JxNrTaLEBeCYCVikaDNZICXLQq
	uQvRh+svheAUforKZiL/OmwZZDr5LhRsrZrEZGsFAFFgOI8e5JpGm8jK3iCl3ojpl3m/WntnBUjZR
	Y4VyYKpw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHIFW-0000000GDin-0OIq;
	Tue, 20 May 2025 08:22:58 +0000
Date: Tue, 20 May 2025 09:22:58 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org,
	loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dcache: Define DNAME_INLINE_LEN as a number directly
Message-ID: <20250520082258.GC2023217@ZenIV>
References: <20250520064707.31135-1-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250520064707.31135-1-yangtiezhu@loongson.cn>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, May 20, 2025 at 02:47:07PM +0800, Tiezhu Yang wrote:
> When executing the bcc script, there exists the following error
> on LoongArch and x86_64:

NOTABUG.  You can't require array sizes to contain no arithmetics,
including sizeof().  Well, you can, but don't expect your requests
to be satisfied.

> How to reproduce:
> 
> git clone https://github.com/iovisor/bcc.git
> mkdir bcc/build; cd bcc/build
> cmake ..
> make
> sudo make install
> sudo /usr/share/bcc/tools/filetop

So fix the script.  Or report it to whoever wrote it, if it's
not yours.

I'm sorry, but we are NOT going to accomodate random parsers
poking inside the kernel-internal headers and failing to
actually parse the language they are written in.

If you want to exfiltrate a constant, do what e.g. asm-offsets is
doing.  Take a look at e.g.  arch/loongarch/kernel/asm-offsets.c
and check what ends up in include/generated/asm-offsets.h - the
latter is entirely produced out of the former.

The trick is to have inline asm that would spew a recognizable
line when compiled into assembler, with the value(s) you want
substituted into it.  See include/linux/kbuild.h for the macros.

Then you pick these lines out of generated your_file.s - no need
to use python, sed(1) will do just fine.  See filechk_offsets in
scripts/Makefile.lib for that part.

