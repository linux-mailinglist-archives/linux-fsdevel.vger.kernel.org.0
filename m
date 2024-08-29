Return-Path: <linux-fsdevel+bounces-27940-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94BC9964D78
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 20:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7D9A1C2232B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 18:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1379A1B86C5;
	Thu, 29 Aug 2024 18:10:11 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B52291B5EC8;
	Thu, 29 Aug 2024 18:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.228.1.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724955010; cv=none; b=IBoxF+215HEz9QRMfrrP+G0FFhgc0y8RON9IXXZ4lt/O1vtro0R2rX3Ed123KpDrwlMqhEQpu66htw+oXSc/d6COUaiPR0HjOsGTlwS5zzqtZn0pv2+VX8bM1T3opx4xDjSaq1dR4HP2prL+KJLFAXEZb2WbTphZHMJerCPCS0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724955010; c=relaxed/simple;
	bh=Dk7L9zYDsUOil9EZzG0eOuo3b9mPRIUPgURR2DLTmLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nMa2BilSPvQ9G8Wg4kHh3MnP0SgXwmyjyRI8KcJ6UdhdLTiEXUNIrBZzClb/Ww3/uwZrV8c3LF/3vF5oMZkdo/PdCaUG3aSDGuV4fk1hXp2Rp0gFrzvL4T/mPkzVFLv0ITRtoc73Tfj5JZltRsLX6VGN08pPgpMRFDbFThiZGJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org; spf=pass smtp.mailfrom=kernel.crashing.org; arc=none smtp.client-ip=63.228.1.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.crashing.org
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 47TI2hac000933;
	Thu, 29 Aug 2024 13:02:44 -0500
Received: (from segher@localhost)
	by gate.crashing.org (8.14.1/8.14.1/Submit) id 47TI2fBi000932;
	Thu, 29 Aug 2024 13:02:41 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date: Thu, 29 Aug 2024 13:02:41 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>, Naveen N Rao <naveen@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, "Theodore Ts'o" <tytso@mit.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        shuah <shuah@kernel.org>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>, linux-mm@kvack.org,
        linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 05/17] vdso: Avoid call to memset() by getrandom
Message-ID: <20240829180241.GJ29862@gate.crashing.org>
References: <20240827180819.GB2049@sol.localdomain> <20240827225330.GC29862@gate.crashing.org> <Zs8HirKLk-SrwTIu@zx2c4.com> <fc19bf63-d519-46e2-be70-80202c85ff92@app.fastmail.com> <20240828124519.GE29862@gate.crashing.org> <CAMj1kXGmDmxy75eP=rf_fzKmg0g_FeKV43jk2G_gibnKZBtVww@mail.gmail.com> <20240828162025.GG29862@gate.crashing.org> <CAMj1kXHZPfr2Sz78UrgsdX-2uBp0D1sCnznQnz5ZyMdiJq6rAA@mail.gmail.com> <20240828172538.GI29862@gate.crashing.org> <e5a36d98-c880-4d33-954a-2a05240ef02f@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e5a36d98-c880-4d33-954a-2a05240ef02f@csgroup.eu>
User-Agent: Mutt/1.4.2.3i

On Thu, Aug 29, 2024 at 07:36:38PM +0200, Christophe Leroy wrote:
> 
> 
> Le 28/08/2024 à 19:25, Segher Boessenkool a écrit :
> >
> >>Not sure about static binaries, though: do those even use the VDSO?
> >
> >With "static binary" people usually mean "a binary not using any DSOs",
> >I think the VDSO is a DSO, also in this respect?  As always, -static
> >builds are *way* less problematic (and faster and smaller :-) )
> >
> 
> AFAIK on powerpc even static binaries use the vDSO, otherwise signals 
> don't work.

How can that work?  Non-dynamic binaries do not use ld.so (that is the
definition of a dynamic binary, even).  So they cannot link (at runtime)
to any DSO (unless that is done manually?!)

Maybe there is something at a fixed offset in the vDSO, or something
like that?  Is this documented somewhere?


Segher

