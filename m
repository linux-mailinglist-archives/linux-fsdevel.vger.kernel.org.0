Return-Path: <linux-fsdevel+bounces-27573-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D21962759
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 14:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DEC11C239E8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 12:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62032177999;
	Wed, 28 Aug 2024 12:40:13 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D4B15A86D;
	Wed, 28 Aug 2024 12:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.228.1.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724848813; cv=none; b=dQ3JHxGdHZJCmiUr1hgtK8NfFGLfXrLyI3k00njw31iOdEe+UEu+CIXLoyBAq+ThVQbW5rNenVyT4wSFk4yerkoDPSecMR/Su1XQcZpZO/gk9lHJHmP0vvbBho7x2kCgd20dD/95op/09FVXr7URw+zauQOD1GlmzmT69xLTVGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724848813; c=relaxed/simple;
	bh=/bBNY0jv3D7Deqpb/q8fLTkX1nKaz6wX3cf774wtMYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KPU+7p314uvYseFBjzsNI3jvhl7icmVi3rsbJvx1i/kOf2lxN+csPGbF/Qb4JVTIjajmUFZnP0t7KHEO6jOuJzC/eqUvVXpUVLjNae8C5F9oFLvDPNc+B3nypp8WyL88pZGiV3PM1moPYpQzssuZeq0zs80nJF737YDIgGzhivw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org; spf=pass smtp.mailfrom=kernel.crashing.org; arc=none smtp.client-ip=63.228.1.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.crashing.org
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 47SCXFAC030999;
	Wed, 28 Aug 2024 07:33:15 -0500
Received: (from segher@localhost)
	by gate.crashing.org (8.14.1/8.14.1/Submit) id 47SCXDte030998;
	Wed, 28 Aug 2024 07:33:13 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date: Wed, 28 Aug 2024 07:33:13 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Eric Biggers <ebiggers@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>, Naveen N Rao <naveen@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, "Theodore Ts'o" <tytso@mit.edu>,
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
Message-ID: <20240828123313.GD29862@gate.crashing.org>
References: <cover.1724309198.git.christophe.leroy@csgroup.eu> <5deb67090b214f0e6eae96b7c406546d1a16f89b.1724309198.git.christophe.leroy@csgroup.eu> <20240827180819.GB2049@sol.localdomain> <20240827225330.GC29862@gate.crashing.org> <Zs8HirKLk-SrwTIu@zx2c4.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zs8HirKLk-SrwTIu@zx2c4.com>
User-Agent: Mutt/1.4.2.3i

On Wed, Aug 28, 2024 at 01:18:34PM +0200, Jason A. Donenfeld wrote:
> On Tue, Aug 27, 2024 at 05:53:30PM -0500, Segher Boessenkool wrote:
> > On Tue, Aug 27, 2024 at 11:08:19AM -0700, Eric Biggers wrote:
> > > > +		for (i = 0; i < ARRAY_SIZE(params->reserved); i++)
> > > > +			params->reserved[i] = 0;

This is a loop.  With -ftree-loop-distribute-patterns, the default at
-O2, this is optimised to

    memset(params->reserved, 0, ...);

(which is perfectly fine, since memset is required to be there even
for freestanding environments, this is documented!)

> > -fno-tree-loop-distribute-patterns .  But, as always, read up on it, see
> > what it actually does (and how it avoids your problem, and mostly: learn
> > what the actual problem *was*!)
> 
> This might help with various loops, but it doesn't help with the matter
> that this patch fixes, which is struct initialization. I just tried it
> with the arm64 patch to no avail.

It very much *does* help.  Try harder?  Maybe you typoed?


Segher

