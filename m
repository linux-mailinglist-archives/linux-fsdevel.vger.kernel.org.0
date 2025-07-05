Return-Path: <linux-fsdevel+bounces-54009-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 717E1AF9FDD
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Jul 2025 13:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E69DB480681
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Jul 2025 11:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBED1251799;
	Sat,  5 Jul 2025 11:44:21 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5D914A62B;
	Sat,  5 Jul 2025 11:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.228.1.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751715861; cv=none; b=BtbrJrgvG6jznbcvypNGGBRmdXRJZUxkH2HHhWGI/4Hjbb5WdDvE3ITQ7EkhzNYChMIMUd723aCH1YQgKospBBaAP/vlKVZ52iKOHYEzuKFU5yGt9FnkI0aPOSJZNTxy5FUKr/gOl79gXnZMi2PiRztrW8feAxpWYah5ZSvWKL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751715861; c=relaxed/simple;
	bh=t0dBI9KZ0iDXjtqjyaZZJtNRaNtXo7Pxi19Gsk1Xxuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o6KLC8XTYjb4sgcI+8E2KD9xKN2FtR0B0oNCXB4FhnlBrLP4ErB6QPdN2hFDSTpivauANoLB0G3fjlQb02dila2isqF7Bo4A1xSuyICD6wMe/O6BVuJJULasTqaW8hOXbHw3kUvB3Ka44gYzq66ZdcwUIy3fX6uzQ+wBUTRjiqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org; spf=pass smtp.mailfrom=kernel.crashing.org; arc=none smtp.client-ip=63.228.1.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.crashing.org
Received: from gate.crashing.org (localhost [127.0.0.1])
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 565BgrOk149573;
	Sat, 5 Jul 2025 06:42:53 -0500
Received: (from segher@localhost)
	by gate.crashing.org (8.18.1/8.18.1/Submit) id 565BgnHF149569;
	Sat, 5 Jul 2025 06:42:49 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date: Sat, 5 Jul 2025 06:42:49 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: David Laight <david.laight.linux@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>, Naveen N Rao <naveen@kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Andre Almeida <andrealmeid@igalia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 0/5] powerpc: Implement masked user access
Message-ID: <aGkPubjld7r6v2vm@gate>
References: <cover.1750585239.git.christophe.leroy@csgroup.eu>
 <20250622172043.3fb0e54c@pumpkin>
 <ff2662ca-3b86-425b-97f8-3883f1018e83@csgroup.eu>
 <20250624131714.GG17294@gate.crashing.org>
 <20250624175001.148a768f@pumpkin>
 <20250624182505.GH17294@gate.crashing.org>
 <20250624220816.078f960d@pumpkin>
 <83fb5685-a206-477c-bff3-03e0ebf4c40c@csgroup.eu>
 <20250626220148.GR17294@gate.crashing.org>
 <3e9bff9f-1aaf-4e91-a6c0-328a343d18f1@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e9bff9f-1aaf-4e91-a6c0-328a343d18f1@csgroup.eu>

Hi!

On Sat, Jul 05, 2025 at 12:55:06PM +0200, Christophe Leroy wrote:
> > > For book3s64, GCC only use isel with -mcpu=power9 or -mcpu=power10
> > 
> > I have no idea what "book3s64" means.
> 
> Well that's the name given in Linux kernel to the 64 bits power CPU
> processors.

A fantasy name.  Great.

> > What is "powerpc/32"?  It does not help if you use different names from
> > what everyone else does.
> 
> Again, that's the way it is called in Linux kernel, refer below commits
> subjects:

And another.

> It means everything built with CONFIG_PPC32

Similar names for very dissimilar concepts, even!  Woohoo!

> > > For powerpc/64 we have less constraint than on powerpc32:
> > > - Kernel memory starts at 0xc000000000000000
> > > - User memory stops at 0x0010000000000000
> > 
> > That isn't true, not even if you mean some existing name.  Usually
> > userspace code is mapped at 256MB (0x10000000).  On powerpc64-linux
> > anyway, different default on different ABIs of course :-)
> 
> 0x10000000 is below 0x0010000000000000, isn't it ? So why isn't it true ?

I understood "starts at".  I read cross-eyed maybe, hehe.


Segher

