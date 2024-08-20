Return-Path: <linux-fsdevel+bounces-26404-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D8E958FEA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 23:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67EC61C21DD2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 21:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B74C1C463A;
	Tue, 20 Aug 2024 21:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="k4V3Y1/P";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="OEtEC/rD";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="k4V3Y1/P";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="OEtEC/rD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF4718E377;
	Tue, 20 Aug 2024 21:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724190467; cv=none; b=f2gc7c7kNMT5pkY/2YnVVh1UHb976XaKaTBfBE0N5crWf/PRMvj/x80R1F9iv8FwrrsHn8OvFB9sloxWG8h9+4ODBpfUaKWd/TNX3yBZ8fbJyDfLOAv3eguzY+0kQuAS8iX6DNwuBkDXIFQTOh72I9y9cJ7dw0cTe6KW/TnedxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724190467; c=relaxed/simple;
	bh=ztAaK7g+xwD9hAZ0s7okIVhu2nfulKWN4DcmZ1X0J4k=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=k8s3vzqdAczb6GnXyo29vl9HiRTdu9zSFSY4Do/LGs8hfQ2byRTrT49HR8qeDyP+rHcPHQUME9zsBVwJG0XAHyhjx14icQfTJ42ku3IQh/1Jofp+agcrUdLfg5PJOmAXQy9qWqde+0mX0PS2UVi4RpL01FtENpjv+IwWplMmx54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=k4V3Y1/P; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=OEtEC/rD; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=k4V3Y1/P; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=OEtEC/rD; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7E81D1F88C;
	Tue, 20 Aug 2024 21:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724190462; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8bSDoYFxts8Sxc334i27mY8a4zI2q1iqZP8WoE+QxBo=;
	b=k4V3Y1/PxV8MtrBdc7NFi0W8jTP6vRiE/0IEG2KWGA1EdDb2XJ1XuTXacdMSWJptepKfZs
	tDaGRQhmZY5Lm7tq2+UkaQZKYBCqcc6tRJjWvrRRRCjBg+tMOAstsY6fho2syNc1KfoUqE
	MRh6IftIczAoCuSrgsuRxvx7RFtAu+s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724190462;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8bSDoYFxts8Sxc334i27mY8a4zI2q1iqZP8WoE+QxBo=;
	b=OEtEC/rDrfeFi0gKQAe9tcqJswkEG5HCcqenxdPLOjPNlKtABHKl5KKCtW72uPqR5YHuct
	m7Rbk8HvBJCiY2BQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724190462; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8bSDoYFxts8Sxc334i27mY8a4zI2q1iqZP8WoE+QxBo=;
	b=k4V3Y1/PxV8MtrBdc7NFi0W8jTP6vRiE/0IEG2KWGA1EdDb2XJ1XuTXacdMSWJptepKfZs
	tDaGRQhmZY5Lm7tq2+UkaQZKYBCqcc6tRJjWvrRRRCjBg+tMOAstsY6fho2syNc1KfoUqE
	MRh6IftIczAoCuSrgsuRxvx7RFtAu+s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724190462;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8bSDoYFxts8Sxc334i27mY8a4zI2q1iqZP8WoE+QxBo=;
	b=OEtEC/rDrfeFi0gKQAe9tcqJswkEG5HCcqenxdPLOjPNlKtABHKl5KKCtW72uPqR5YHuct
	m7Rbk8HvBJCiY2BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A8EC013A17;
	Tue, 20 Aug 2024 21:47:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Q5VIF/wOxWYrHQAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 20 Aug 2024 21:47:40 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: "Ingo Molnar" <mingo@redhat.com>, "Peter Zijlstra" <peterz@infradead.org>,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/9 RFC] Make wake_up_{bit,var} less fragile
In-reply-to:
 <CAHk-=widip3Dj5UWs8MVGgxt=DJjMy1OEzZq9U8TMJAT3y48Uw@mail.gmail.com>
References: <20240819053605.11706-1-neilb@suse.de>,
 <CAHk-=widip3Dj5UWs8MVGgxt=DJjMy1OEzZq9U8TMJAT3y48Uw@mail.gmail.com>
Date: Wed, 21 Aug 2024 07:47:36 +1000
Message-id: <172419045605.6062.3170152948140066950@noble.neil.brown.name>
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.993];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Mon, 19 Aug 2024, Linus Torvalds wrote:
> On Sun, 18 Aug 2024 at 22:36, NeilBrown <neilb@suse.de> wrote:
> >
> > The main patches here are 7 and 8 which revise wake_up_bit and
> > wake_up_var respectively.  They result in 3 interfaces:
> >   wake_up_{bit,var}           includes smp_mb__after_atomic()
> 
> I actually think this is even worse than the current model, in that
> now it subtle only works after atomic ops, and it's not obvious from
> the name.
> 
> At least the current model, correct code looks like
> 
>       do_some_atomic_op
>       smp_mb__after_atomic()
>       wake_up_{bit,var}
> 
> and the smp_mb__after_atomic() makes sense and pairs with the atomic.
> So the current one may be complex, but at the same time it's also
> explicit. Your changed interface is still complex, but now it's even
> less obvious what is actually going on.
> 
> With your suggested interface, a plain "wake_up_{bit,var}" only works
> after atomic ops, and other ops have to magically know that they
> should use the _mb() version or whatever. And somebody who doesn't
> understand that subtlety, and copies the code (but changes the op from
> an atomic one to something else) now introduces code that looks fine,
> but is really subtly wrong.
> 
> The reason for the barrier is for the serialization with the
> waitqueue_active() check. Honestly, if you worry about correctness
> here, I think you should leave the existing wake_up_{bit,var}() alone,
> and concentrate on having helpers that do the whole "set and wake up".
> 
> IOW, I do not think you should change existing semantics, but *this*
> kind of pattern:
> 
> >  [PATCH 2/9] Introduce atomic_dec_and_wake_up_var().
> >  [PATCH 9/9] Use clear_and_wake_up_bit() where appropriate.
> 
> sounds like a good idea.
> 
> IOW, once you have a whole "atomic_dec_and_wake_up()" (skip the "_var"
> - it's implied by the fact that it's an atomic_dec), *then* that
> function makes for a simple-to-use model, and now the "atomic_dec(),
> the smp_mb__after_atomic(), and the wake_up_var()" are all together.
> 
> For all the same reasons, it makes total sense to have
> "clear_bit_and_wake()" etc.

I can definitely get behind the idea has having a few more helpers and
using them more widely.  But unless we get rid of wake_up_bit(), people
will still use and some will use it wrongly.

What would you think of changing wake_up_bit/var to always have a full
memory barrier, and adding wake_up_bit/var_relaxed() for use when a
different barrier, or not barrier, is wanted?

Thanks,
NeilBrown


> 
> But exposing those "three different memory barrier scenarios" as three
> different helpers is the *opposite* of helpful. It keeps the current
> complexity, and makes it worse by making the barrier rules even more
> opaque, imho.
> 
>                Linus
> 


