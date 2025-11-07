Return-Path: <linux-fsdevel+bounces-67438-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F55C4028D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 07 Nov 2025 14:41:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00AF7424079
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Nov 2025 13:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF5542F2918;
	Fri,  7 Nov 2025 13:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Rfr252Xc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hOgdHBfo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FEDD2F12C5;
	Fri,  7 Nov 2025 13:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762522895; cv=none; b=LHnDaqgD7p9P096YDQ2dhZfCChhAirnbmVjaWtGt/QRJmj55tluo5WLtflXBxfC2apVFMUnhm1g8YGqW9ZWnaAzn6z9dqynCqWDGHTbaQmav0VN8BqdNyfk1m7jr2dmSQaurfDzxvgnBczAi4dyFiQM6QZkq7BT7Y3Hc95nLqIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762522895; c=relaxed/simple;
	bh=bX8MCxO0wT49e0+2aFrqM0RJ8xou+QnZeO3rKTGprV4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kyGaGnJfk1A2h59wxui+57FIluVbl5TyZJp0M8Umd3/ce1l76nMoB/DE5iLzqeoHvBrYWr4lb3+XTAo+3yekS7ZRmUeMJD8BZAeylEf7HKNp6epa4pblfDbT1SuGEbx+i/dlFOenenOX1ncEXW1bxAq3HyOwddPtkElf8qLtSFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Rfr252Xc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hOgdHBfo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762522890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UQ9noBC6jYHpesi21iR41wacPz1nSToTuWL/a29XHiA=;
	b=Rfr252XcjH5h+UUrJg/pmHzom8K256tRHq3+XOxMpc5mvk/FBD7zawbZc+FBMfzDg6JWJm
	Mzl2SO/sj/xDa39sASpyyoP6S3G9uyKdvg9R+0IYkbqaYgY3tqtVZnhLlS3+QI2O9Vr/7/
	vYKOXKTmznhPyndd5YtDpSCKbXlWB6LYpOwd0Fnz7+7kVlmnyltXyB2HxtjOAKHSrnhwHn
	SbVUOnXSo9BWL+3YQYJLKuQsCT8/sfx49vHreaLzA/2b1m1KtGXTTzw4GpsAwq+cBHytGA
	6IWsxCA0V1ohfpmidKQc/QVEjs4872qeHPN6LkOdHXDohbnkk9782R/w9rzfSA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762522890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UQ9noBC6jYHpesi21iR41wacPz1nSToTuWL/a29XHiA=;
	b=hOgdHBfoRYMa2wIRjwpw1clVkYTVr9ky7h14gp6dC/iF9rk2OTn09LiBFhE8YiT7N1QP+m
	r+HFrMbi4idy7RDQ==
To: Petr Mladek <pmladek@suse.com>
Cc: Joanne Koong <joannelkoong@gmail.com>, syzbot
 <syzbot+3686758660f980b402dc@syzkaller.appspotmail.com>,
 "amurray@thegoodpenguin.co.uk" <amurray@thegoodpenguin.co.uk>,
 brauner@kernel.org, chao@kernel.org, djwong@kernel.org,
 jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-xfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [iomap?] kernel BUG in folio_end_read (2)
In-Reply-To: <aQ3ck9Bltoac7-0d@pathway.suse.cz>
References: <CAJnrk1bF8sLU6tG2MGkt_KR4BoTd_k01CMVZJ9js2-eyh80tbw@mail.gmail.com>
 <69096836.a70a0220.88fb8.0006.GAE@google.com>
 <CAJnrk1Yo4dRVSaPCaAGkHc+in03KaTXJ+KxckhLoSrRxbEdDBg@mail.gmail.com>
 <aQpFLJM96uRpO4S-@pathway.suse.cz> <87ldkk34yj.fsf@jogness.linutronix.de>
 <aQuABK25fdBVTGZc@pathway.suse.cz> <87bjlgqmk5.fsf@jogness.linutronix.de>
 <87tsz7iea2.fsf@jogness.linutronix.de> <aQzLX_y8PvBMiZ9f@pathway.suse.cz>
 <87h5v73s5g.fsf@jogness.linutronix.de> <aQ3ck9Bltoac7-0d@pathway.suse.cz>
Date: Fri, 07 Nov 2025 14:47:29 +0106
Message-ID: <871pma0xkm.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-11-07, Petr Mladek <pmladek@suse.com> wrote:
> What about?
>
> /*
>  * Return true when @lpos1 is lower than @lpos2 and both values
>  * look sane.
>  *
>  * They are considered insane when the difference is bigger than
>  * the data buffer size. It happens when the values are read
>  * without locking and another CPU already moved the ring buffer
>  * head and/or tail.
>  *
>  * The caller must behave carefully. The changes based on this
>  * check must be done using cmpxchg() to confirm that the check
>  * worked with valid values.
>  */
> static bool lpos1_before_lpos2_sane(struct prb_data_ring *data_ring,
> 				    unsined long lpos1, unsigned long lpos2)
> {
> 	return lpos2 - lpos1 - 1 < DATA_SIZE(data_ring);
> }
>
> Feel free to come up with any other function name or description.

I prefer "_bounded" to "_sane". And I really don't care if it is
"before" or "lt". I was only stating why I chose "before" instead of
something else. But I really don't care. Really.

My preferences would be:

lpos1_before_lpos2_bounded()

lpos1_lt_lpos2_bounded()

But I can live with lpos1_before_lpos2_sane() if you think "_sane" is
better.

>> You have overlooked that I inverted the check. It is no longer checking:
>> 
>>     next_pos <= head_pos
>> 
>> but is instead checking:
>> 
>>     !(head_pos < next_pos)
>> 
>> IOW, if "next has not overtaken head".
>
> I see. I missed this. Hmm, this would be correct when the comparsion was
> mathemathical (lt, le). But is this correct in our case when take
> into account the ring buffer wrapping?
>
> The original check returned "false" when the difference between head_lpos
> and next_lpos was bigger than the data ring size.
>
> The new check would return "true", aka "!false", in this case.

Sure, but that is not possible. Even if we assume there has been
corrupted data, the new get_data() will catch that.

> Hmm, it seems that the buffer wrapping is not possible because
> this code is called when desc_reopen_last() succeeded. And nobody
> is allowed to free reopened block.

Correct.

> Anyway, I consider using (!lpos1_before_lpos2()) as highly confusing
> in this case.

I think if you look at what the new check is checking instead of trying
to mentally map the old check to the new check, it is not confusing.

> I would either keep the code as is.

:-/ That defeats the whole purpose of the new helper, which is simply
comparing the relative position of two lpos values. That is exactly what
is being done here.

I would prefer adding an additional lpos1_le_lpos2_bounded() variant
before leaving the old code. A new variant is unnecessary, but at least
we would have all logical position comparison code together.

> Maybe we could add a comment explaining that
>
> 	if (head_lpos - next_lpos < DATA_SIZE(data_ring)) {
>
> might fail only when the substraction is negative. It should never be
> positive because head_lpos advanced more than the data buffer size
> over next_lpos because the data block is reopened and nobody could
> free it.
>
> Maybe, we could even add a check for this.

If data is being illegally manipulated underneath us, we are screwed
anyway. I see no point in sprinkling checks around in case someone is
modifying our data even though we have exclusive access to it.

> I think about fixing this in a separate patch and pushing this
> into linux-next ASAP to fix the regression.
>
> We could improve the other comparisons later...
>
> How does that sound?

Sure. Are you planning on letting 6.19 pull 2 patches or will you fold
them for the 6.19 pull?

> Should I prepare the patch for get_data() are you going to do so?

I would prefer you do it so that we do not need any more discussing for
the quick fix. ;-)

John

