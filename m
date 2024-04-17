Return-Path: <linux-fsdevel+bounces-17199-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F448A8AC3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 20:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74AAE282C77
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 18:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E67B173324;
	Wed, 17 Apr 2024 18:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PTnXRkL0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="u0uvNqcx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9633818C19;
	Wed, 17 Apr 2024 18:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713377183; cv=none; b=ifNPw6CnXWpvH2EtCdWQIZSn4/x8MIFP5ZBAu51Wd2FZF4ocxBOdyQ8a0hTv98WNT/3F69CdlMytIiH8bBTKVuZH6I9SETDVHKCVqTB/vNzP8gtNkWiNk3/nYPthiuWMRSIeFn8mo2ppR/p6er5uvJnLxMBw9dYySQJJlLQwFCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713377183; c=relaxed/simple;
	bh=qDjvN97rYs9sHi5cS2z/zYzz/cV7lJgX2WvDgQPJW9s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HRJQeUsg+YSu7/sUgT6OgJe3JZjqgBH7peO+OH7y24BhwVFifyPY77Gx6v2P4DzTTwdmSUkv4Dm4UQ4JHdXWTIjkxM1eW9/YpcewXyV7CWnWoVPnbJF3DPYIbNEfNkc1UoNPoSU04fVzDidQQ8LoJx5gnNj/JnusB3WS4aBeFWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PTnXRkL0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=u0uvNqcx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 17 Apr 2024 20:06:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713377180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pwylh6Dtd2mdV0b8+p19DcG02NblOYqwKMD1VZyGC1o=;
	b=PTnXRkL0Gx3ZvvovCOtl8ojNWOUmAw0Lw3c3YU2zdLPSfYxMnMlL0SvFTTJKO51paktGUV
	RGEh5iibetSJew8rfbQDbYxMPFffMsoVjmnPSMeFkKrqUAEttHCCzIN4d08NeOU8dnEXS6
	tDoJj3Z0v4BSN1CBw6h4fiuzW/JMdPGt7RrAaPnPtGew3KXkHGx9qlYIDVa3+/LSAeysJx
	jylL0OQycAkKMO23FGGqqC0ilWzMUCyIjO6NiMh0QLRJXDeU5WrScnumsF4mZJDaVysAmb
	dYzAzJBTuZCDbDDplVOSCAv7rBJ+AKYUx1sdDUAZwpRE5Wl0W/t0FlhE9HQvZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713377180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pwylh6Dtd2mdV0b8+p19DcG02NblOYqwKMD1VZyGC1o=;
	b=u0uvNqcxsrxeHeclsTeo2hclmfvQKtnv7ZQIvprFID5UogtYQNXGwTi1vc+sqQegdsu+K4
	43uPtNQkpiHk8KCA==
From: Nam Cao <namcao@linutronix.de>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Mike Rapoport <rppt@kernel.org>, Matthew Wilcox <willy@infradead.org>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, Christian Brauner
 <brauner@kernel.org>, Andreas Dilger <adilger@dilger.ca>, Al Viro
 <viro@zeniv.linux.org.uk>, linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Jan Kara <jack@suse.cz>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, linux-riscv@lists.infradead.org, Ext4
 Developers List <linux-ext4@vger.kernel.org>, Conor Dooley
 <conor@kernel.org>, Anders Roxell <anders.roxell@linaro.org>, Alexandre
 Ghiti <alex@ghiti.fr>
Subject: Re: riscv32 EXT4 splat, 6.8 regression?
Message-ID: <20240417200617.2f54bc7b@namcao>
In-Reply-To: <20240417153122.GE2277619@mit.edu>
References: <8734rlo9j7.fsf@all.your.base.are.belong.to.us>
	<Zh6KNglOu8mpTPHE@kernel.org>
	<20240416171713.7d76fe7d@namcao>
	<20240416173030.257f0807@namcao>
	<87v84h2tee.fsf@all.your.base.are.belong.to.us>
	<20240416181944.23af44ee@namcao>
	<Zh6n-nvnQbL-0xss@kernel.org>
	<Zh6urRin2-wVxNeq@casper.infradead.org>
	<Zh7Ey507KXIak8NW@kernel.org>
	<20240417003639.13bfd801@namcao>
	<20240417153122.GE2277619@mit.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On 2024-04-17 Theodore Ts'o wrote:
> On Wed, Apr 17, 2024 at 12:36:39AM +0200, Nam Cao wrote:
> > 
> > However, I am confused about one thing: doesn't this make one page of
> > physical memory inaccessible?  
> 
> So are these riscv32 systems really having multiple terabytes of
> memory?  Why is this page in the physical memory map in the first
> place?

It's 32 bit, so it doesn't take much to fill up the entire address space.

Here's the memory layout from kernel boot log:

[    0.000000] Virtual kernel memory layout:
[    0.000000]       fixmap : 0x9c800000 - 0x9d000000   (8192 kB)
[    0.000000]       pci io : 0x9d000000 - 0x9e000000   (  16 MB)
[    0.000000]      vmemmap : 0x9e000000 - 0xa0000000   (  32 MB)
[    0.000000]      vmalloc : 0xa0000000 - 0xc0000000   ( 512 MB)
[    0.000000]       lowmem : 0xc0000000 - 0x00000000   (1024 MB)

Note that lowmem occupies the last 1GB, including ERR_PTR (the last
address wraps to zero)

Best regards,
Nam

