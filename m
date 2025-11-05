Return-Path: <linux-fsdevel+bounces-67196-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CEF4C3798D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 20:58:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5C8A1889746
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 19:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891453446AF;
	Wed,  5 Nov 2025 19:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YadV75Eq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cgoR/Xr3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29BA21A9F82;
	Wed,  5 Nov 2025 19:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762372689; cv=none; b=c89E0Pt4Hv+MTikynonlRrnSnerijiYQZZg6XGyYzGo63w4x2QIaqPcEI1b59u1dxlaLpqwE7VMCiEHlsIIGfkl3kr0Y5l3EYioFmEqLCbV6VX4WMa7mqvINhpZiyaV9NQQBlx4lR+BR0s5QNzeQpFmIvOyFoSTQRVhsB5yxzI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762372689; c=relaxed/simple;
	bh=I9hL+v1k2zWn/5GfkHIPkAt3XWEoA4ZAZUt0y90ZrZo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Qg9CapaVxf5+aO0EW/4aEL4FThsNeAlhDYrH/nXLVO56ep4iqOh1JoAgNuYN0q6jGm2bQVAflYmpYQRPHMT4xBtc2FFuUjVuouACGg12MSnerzizOUbkCr/LCzyvGPjeOh9vIL6h4Qq3TH44m15/f3Zq6lE83tMnDQEJuMaxDHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YadV75Eq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cgoR/Xr3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762372682;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/0Okumwv2i/9MTHqqUn+mKL3pMAEP/LLr4SPEwH8vDA=;
	b=YadV75EqqrChNko7W61kSE7LTp9KNUVgJOpsBNRK0sYVRatElmdQHw3YK/33Ev0WkW8bI2
	0i3CE/80EDgrpib0ydGQDBh/ZJGRrJL7EIp/POOGsD4V/6wkL8/XZcA7CPiyO6PK9m+8tM
	dqA2hFq8KAGpjVpq/LZsbdX5dBQvUA3ZkeVbSJ2oSu5Zd6Q7366vKvV+HzJ4d3ikhQFtMm
	7v2rVCoFb31ks69IVdK/QCPgqoJrxmeNHIzQFuakaDrdvWWd8N9N3V1NzRGl4gmP4NJ/PW
	q9LTxmKlp2Pp3kjClmmgjKPD+Cepu8/hrZj8XlRdZVH/j/USXMssTzRRcSC0eA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762372682;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/0Okumwv2i/9MTHqqUn+mKL3pMAEP/LLr4SPEwH8vDA=;
	b=cgoR/Xr3pmYydMuv3YWSAL5rRLtSuwHLagt0qe4h/yfBvnLYkaAZ7dqg6Wi4dbs5PGPOa0
	UTuqS04wCz72B2Ag==
To: Petr Mladek <pmladek@suse.com>
Cc: Joanne Koong <joannelkoong@gmail.com>, syzbot
 <syzbot+3686758660f980b402dc@syzkaller.appspotmail.com>,
 "amurray@thegoodpenguin.co.uk" <amurray@thegoodpenguin.co.uk>,
 brauner@kernel.org, chao@kernel.org, djwong@kernel.org,
 jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-xfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [iomap?] kernel BUG in folio_end_read (2)
In-Reply-To: <aQuABK25fdBVTGZc@pathway.suse.cz>
References: <CAJnrk1bF8sLU6tG2MGkt_KR4BoTd_k01CMVZJ9js2-eyh80tbw@mail.gmail.com>
 <69096836.a70a0220.88fb8.0006.GAE@google.com>
 <CAJnrk1Yo4dRVSaPCaAGkHc+in03KaTXJ+KxckhLoSrRxbEdDBg@mail.gmail.com>
 <aQpFLJM96uRpO4S-@pathway.suse.cz> <87ldkk34yj.fsf@jogness.linutronix.de>
 <aQuABK25fdBVTGZc@pathway.suse.cz>
Date: Wed, 05 Nov 2025 21:04:02 +0106
Message-ID: <87bjlgqmk5.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-11-05, Petr Mladek <pmladek@suse.com> wrote:
> I guess that we should do:
>
> From f9cae42b4a910127fb7694aebe2e46247dbb0fcb Mon Sep 17 00:00:00 2001
> From: Petr Mladek <pmladek@suse.com>
> Date: Wed, 5 Nov 2025 17:14:57 +0100
> Subject: [PATCH] printk_ringbuffer: Fix check of valid data size when blk_lpos
>  overflows
>
> The commit 67e1b0052f6bb8 ("printk_ringbuffer: don't needlessly wrap
> data blocks around") allows to use the last 4 bytes of the ring buffer.
>
> But the check for the data_size was not properly updated. It fails
> when blk_lpos->next overflows to "0". In this case:
>
>   + is_blk_wrapped(data_ring, blk_lpos->begin, blk_lpos->next)
>     returns false because it checks "blk_lpos->next - 1"
>
>   + but "blk_lpos->begin < blk_lpos->next" fails because
>     blk_lpos->next is already 0.
>
>   + is_blk_wrapped(data_ring, blk_lpos->begin + DATA_SIZE(data_ring),
>     blk_lpos->next) returns false because "begin_lpos" is from
>     next wrap but "next_lpos - 1" is from the previous one
>
> As a result, get_data() triggers the WARN_ON_ONCE() for "Illegal
> block description", for example:

Beautiful catch!

> Another question is whether this is the only problem caused the patch.

This comparison is quite special. It caught my attention while combing
through the code. Sadly, I missed this fix despite staring at the
problem. I was more concerned about making sure it could handle wraps
correctly without realizing it was an incorrect range check.

Tomorrow I will recomb through again, this time verifying all the range
checks.

> It might help to fill messages with a fixed size which might trigger
> blk_lpos->next == 0 in the 1st wrap.

I did this and indeed it reproduces the WARN_ON_ONCE() when next==0. And
with your patch applied, the warning is gone.

John

