Return-Path: <linux-fsdevel+bounces-27131-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA0F795EDA4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 11:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD2E81C21587
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 09:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B767314659C;
	Mon, 26 Aug 2024 09:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Ra8Bb8ep"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A28429A2;
	Mon, 26 Aug 2024 09:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724665697; cv=none; b=PjLNjbgxBrGz+8awFwtLUOfEOBX/uUl2VjXzMPcHRwOKsegCeFZ2N9AL40NxwUPhZtmZcYtNYZtopBaITQavbcsRiXqWFKMQIh+7UlnpYE3jvHWcHsPTSkz0wVArSSKHRK7KMTN8e3lcCk0uEokoivesRj07nsKxVLRJR+AFsUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724665697; c=relaxed/simple;
	bh=40duo67vILFW2Mtz3qng4d4MnMFvqiJDQTSXPleTFaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EV8Q7mDeNIHM1TiPwipKkt93Mz9NuUi78QHfSnOdmSW4kDds/ssI/C8yu0BO9hkReFqfTZaMgmZXwSMJAVSaCFXG9nDLMl3VjtDg4784ygGtrC0ssXggEu4qzjeYTUeYU4Wcn9paiAdHHldEXcHnHXg0qXQWJHOq9V4b2xvdWTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=Ra8Bb8ep; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E668C4DDFF;
	Mon, 26 Aug 2024 09:48:13 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Ra8Bb8ep"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1724665691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=awbUvn+zcUaAMzrxEX5rtv3K5X2zJKdTxDK7qFVNC2A=;
	b=Ra8Bb8epvfQUmYF44p8hCwYUkMlgxSsvYepqJe39nrmzRZFcnxDHLnhWhQSSslCM/8qTGm
	rJoy82h0Gs73r3V0WNG+Y+HRCD3DemC+gvIEye0QFf8acyKnRI2qG/QH8beDx5lMQRczDQ
	B53l/X4IZqTFNqiIK/LddaNIyEDciAE=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 97e8236b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 26 Aug 2024 09:48:11 +0000 (UTC)
Date: Mon, 26 Aug 2024 11:48:01 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Naveen N Rao <naveen@kernel.org>, Andy Lutomirski <luto@kernel.org>,
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
Subject: Re: [PATCH v2 06/17] vdso: Change getrandom's generation to unsigned
 long
Message-ID: <ZsxPUXq0qo4MPDbW@zx2c4.com>
References: <cover.1724309198.git.christophe.leroy@csgroup.eu>
 <525b48eb79978ddba2d1b8ee23b27bd6c5b0b4ee.1724309198.git.christophe.leroy@csgroup.eu>
 <Zswzu1l3xO99KN3I@zx2c4.com>
 <7d58be73-a8e5-4ec7-bbdc-238b0c25c77b@csgroup.eu>
 <87v7znd3g4.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87v7znd3g4.ffs@tglx>

On Mon, Aug 26, 2024 at 11:43:39AM +0200, Thomas Gleixner wrote:
> As explained before, there is no problem with store or load tearing on
> 32bit systems because the generation counter is only 32bit wide. So the
> obvious solution is to only update 32 bits on a 32bit kernel:
> 
> --- a/drivers/char/random.c
> +++ b/drivers/char/random.c
> @@ -282,7 +282,7 @@ static void crng_reseed(struct work_stru
>  	 * is ordered with the write above to base_crng.generation. Pairs with
>  	 * the smp_rmb() before the syscall in the vDSO code.
>  	 */
> -	smp_store_release(&_vdso_rng_data.generation, next_gen + 1);
> +	smp_store_release((unsigned long *)&_vdso_rng_data.generation, next_gen + 1);
>  #endif
>  	if (!static_branch_likely(&crng_is_ready))
>  		crng_init = CRNG_READY;

That seems like a pretty clean fix.

> But that's a trivial fix compared to making VM_DROPPABLE work on 32-bit
> correclty. :)

My initial response too, and then I noticed he posted this:
https://lore.kernel.org/all/315e3a268b165b6edad7dcb723b0d8a506a56c4e.1724309198.git.christophe.leroy@csgroup.eu/
If that's correct, maybe it's not so bad, at least here. I haven't yet
looked into the details of it.

Jason

