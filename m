Return-Path: <linux-fsdevel+bounces-52773-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E3AAE66A0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 15:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52F07192769B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 13:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FED82C158B;
	Tue, 24 Jun 2025 13:34:56 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6532A1A4;
	Tue, 24 Jun 2025 13:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.228.1.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750772096; cv=none; b=p2zAUHgQCuzBVVejIex1mo47f1DtNR0/h3KppzEsmECf5+nCaBkDyBK4sEU1q+e5291FXYRHDaRfMMTKhdYDVfsTVYtDYKK18Ht9iuAc8SQJAmIl/3nAe1BKUixG1YMyios1ZWIo8UElQmlezQZLO6bLTsnrZ8dIy1V2WvUb7dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750772096; c=relaxed/simple;
	bh=l8hlToF1Oci/MZLkd/37EWZi6SIO9bMm5mseHYujdR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iBA5Fq6YIjLRjcG8/HcZJhvV+2khNq6mGL7IIL0NVV5EDu6guq/JX3Q3L3waq8W6RqLekqIT2pmhbzH9P/MgpUCWYjmM4tUx2UISV6G+VbcqFryQFCMLJWUPy2sVE2ig2DNwj2JEfphUtemQ4gxDy0SfI1c9/VbsHJra1mJOMc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org; spf=pass smtp.mailfrom=kernel.crashing.org; arc=none smtp.client-ip=63.228.1.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.crashing.org
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 55ODHH69017475;
	Tue, 24 Jun 2025 08:17:17 -0500
Received: (from segher@localhost)
	by gate.crashing.org (8.14.1/8.14.1/Submit) id 55ODHFe6017474;
	Tue, 24 Jun 2025 08:17:15 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date: Tue, 24 Jun 2025 08:17:14 -0500
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
Message-ID: <20250624131714.GG17294@gate.crashing.org>
References: <cover.1750585239.git.christophe.leroy@csgroup.eu> <20250622172043.3fb0e54c@pumpkin> <ff2662ca-3b86-425b-97f8-3883f1018e83@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff2662ca-3b86-425b-97f8-3883f1018e83@csgroup.eu>
User-Agent: Mutt/1.4.2.3i

On Tue, Jun 24, 2025 at 07:27:47AM +0200, Christophe Leroy wrote:
> Ah ok, I overlooked that, I didn't know the cmove instruction, seem 
> similar to the isel instruction on powerpc e500.

cmove does a move (register or memory) when some condition is true.
isel (which is base PowerPC, not something "e500" only) is a
computational instruction, it copies one of two registers to a third,
which of the two is decided by any bit in the condition register.

But sure, seen from very far off both isel and cmove can be used to
implemente the ternary operator ("?:"), are similar in that way :-)


Segher

