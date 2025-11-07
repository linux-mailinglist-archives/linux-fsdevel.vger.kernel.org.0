Return-Path: <linux-fsdevel+bounces-67425-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 581DDC3FD01
	for <lists+linux-fsdevel@lfdr.de>; Fri, 07 Nov 2025 12:50:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 120F23BD335
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Nov 2025 11:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D79320A31;
	Fri,  7 Nov 2025 11:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="P7aHNV3j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A552B2DF709
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Nov 2025 11:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762516123; cv=none; b=N5upvfMhZ1x69oSj9EaRrx5Nc95zNScZJv1k1LIiFFK1ouVi/HziAhqqOKn0xXNl93J2NhPY8rrJQ4SEXSsvDb2YgeB/B9fzWN30kYP/myLegYRPyIntua9BlMzrMVFi500/LvEi52L5kQFdQHc3lpsfCd+raoRHlV+xCEplfsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762516123; c=relaxed/simple;
	bh=2RT+fnmoZ4nfvY5zlKMIbHcZWAoZa52HOltas4MhZt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i/NfDOBK1x5LKKoEHDtM5z9p5dsbSG5v6FiXGllCzoKXUQre2+9pAia5sAg8PXI2+2S0d4ZLFXAqmPD0HoxRMe3PHOIIMBnmIU+5Nsp6mfB/Tu3NYNmhFeHLnplkFOrOropL1VzGO7emZrSlJsvvpzv2IsgyO9vSPB//giIwC3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=P7aHNV3j; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b729f239b39so141869866b.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Nov 2025 03:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762516118; x=1763120918; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0btHuhgoXf1JIAcsuz3z0Yh6Fl6KHmjrhbtAp1FpJMM=;
        b=P7aHNV3jloCek62WlFnRJC//16l643rNzJTBMrkq1gPlA0uuTXC7AbsP45doGVFfhu
         Z/N8J+9MPHUJRsbju0gzwa0ysNiaTsWeCtMey6l0kTYs0n3a9TlDrrGRWwSnDEYzy6xt
         00Yumg9eWeosEb3cErFvH1MWXqBBEFt9s6/GH97dkfTNYsNU1rqcv2w8zdDL+9dWRuYz
         7SO8UrDtP9r1/XyEUB0CEzDxHp/ps7Hlavt9TKmLVHt1ffO5Voja9tpg75wbnxqX/E1J
         8ylaWqv1+HrKj8+/nhBq+EmD9qganj8UktR6clILHy2r/qAGlNI0ryvgMkVlTfw2v6ci
         yjEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762516118; x=1763120918;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0btHuhgoXf1JIAcsuz3z0Yh6Fl6KHmjrhbtAp1FpJMM=;
        b=fAXEER3mIsEryzKBwDZpfEm8dh25l2bkXnhiw6m6vBR0JHyOK9ziIovbnhEc6oYJIx
         9dW14pBjQXYPnSYF4z3zQofW8qnnSJlhMCxEkRF3WKX1W9z9+l5WV8jAbgw6e64WdBuP
         CtHncrkIQNvM6gZbw+GEveTye9s2+5E/yvQKfhJm/alGpkCt+T4/qd/EH1fgNheoAltD
         /yLCUBh31kctg6hnfvUXORwL7ivX/gXb7d91/h/Km2tRxQf9erknQq5hHLiPbp7kR1rn
         94j+zprwjg9eqAHj3N1oYYRtbPz7GbSHdBXu+rXc0xTrFqLZ59UDh59jlQdRUsmvpQ5L
         Wfow==
X-Forwarded-Encrypted: i=1; AJvYcCXYTJEYk9Kxf3leKyUyzJ9/io2cJJu9fzVxLUEolY370F56GD+2EiNQy/ppm2oy2/d3LiD+IQ9eRUlz7ebz@vger.kernel.org
X-Gm-Message-State: AOJu0YxLMDRzdiqOq+WMPP15+rIdu7eEb4LJK35Me2AcQDbNEpmpO7ae
	o6qn3wr2rjyz40jbW0m5/BdMABZo1iD9dhqCQplOWQT30B2q7XkhcZUBLGLK2i5R1fc=
X-Gm-Gg: ASbGncvEhYrzUhsaSQZkkfdxNHUXtyU4VH3tyTKDnBaGzJJUczJcWJRdIJ/cioTjuVW
	l0kxiIUdshH+7FpuO1XvPUoApQeYkSvYGJMUbNz/fbrkWvDKYvveznhuF78CTWxhxON9ZGHu47U
	AHccD5A/i+XMGEhDDiicFY3Xfcv+2o7ZG5gh6TdD8Zi9Z+M0XdACPRE2DezX+WfPsofWnq8GZvr
	Txx9t5w41k9NkmmihrIgduZ5gVemADCzTznxBgZmZ/zj+i6pyn6G7u9Qsv046pqmorDy/m3X4nI
	bmDysBeAtFzGY3S+wPrXZbb6+7ExnmqK4Nx71/4srULzb3Tzr/TylG9sEMLYBhq175aT/QrbFor
	kFcECuFxHP30dQvcmL9j/lNafOMH0iZkcwc3dnxFxFO19SsoY1EKWUUxxjb4SgHC/VHwlou/Jnr
	IPfgaaOTA3CpUrHOarOFquDxIL
X-Google-Smtp-Source: AGHT+IEokWk1ZSxMf9gnaVqeMhezk2Opyg5SPlA30ekZY/SCq/nzbaLIFzm2m4+Eq/H2tXmxOh/49A==
X-Received: by 2002:a17:907:9489:b0:b72:c103:88da with SMTP id a640c23a62f3a-b72d0adb87bmr177003966b.26.1762516117816;
        Fri, 07 Nov 2025 03:48:37 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72d3baf872sm85014366b.27.2025.11.07.03.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 03:48:37 -0800 (PST)
Date: Fri, 7 Nov 2025 12:48:35 +0100
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Joanne Koong <joannelkoong@gmail.com>,
	syzbot <syzbot+3686758660f980b402dc@syzkaller.appspotmail.com>,
	"amurray@thegoodpenguin.co.uk" <amurray@thegoodpenguin.co.uk>,
	brauner@kernel.org, chao@kernel.org, djwong@kernel.org,
	jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [iomap?] kernel BUG in folio_end_read (2)
Message-ID: <aQ3ck9Bltoac7-0d@pathway.suse.cz>
References: <CAJnrk1bF8sLU6tG2MGkt_KR4BoTd_k01CMVZJ9js2-eyh80tbw@mail.gmail.com>
 <69096836.a70a0220.88fb8.0006.GAE@google.com>
 <CAJnrk1Yo4dRVSaPCaAGkHc+in03KaTXJ+KxckhLoSrRxbEdDBg@mail.gmail.com>
 <aQpFLJM96uRpO4S-@pathway.suse.cz>
 <87ldkk34yj.fsf@jogness.linutronix.de>
 <aQuABK25fdBVTGZc@pathway.suse.cz>
 <87bjlgqmk5.fsf@jogness.linutronix.de>
 <87tsz7iea2.fsf@jogness.linutronix.de>
 <aQzLX_y8PvBMiZ9f@pathway.suse.cz>
 <87h5v73s5g.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h5v73s5g.fsf@jogness.linutronix.de>

On Thu 2025-11-06 20:04:03, John Ogness wrote:
> On 2025-11-06, Petr Mladek <pmladek@suse.com> wrote:
> >> diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
> >> index 839f504db6d30..8499ee642c31d 100644
> >> --- a/kernel/printk/printk_ringbuffer.c
> >> +++ b/kernel/printk/printk_ringbuffer.c
> >> @@ -390,6 +390,17 @@ static unsigned int to_blk_size(unsigned int size)
> >>  	return size;
> >>  }
> >>  
> >> +/*
> >> + * Check if @lpos1 is before @lpos2. This takes ringbuffer wrapping
> >> + * into account. If @lpos1 is more than a full wrap before @lpos2,
> >> + * it is considered to be after @lpos2.
> >
> > The 2nd sentence is a brain teaser ;-)
> >
> >> + */
> >> +static bool lpos1_before_lpos2(struct prb_data_ring *data_ring,
> >> +			       unsigned long lpos1, unsigned long lpos2)
> >> +{
> >> +	return lpos2 - lpos1 - 1 < DATA_SIZE(data_ring);
> >> +}
> >
> > It would be nice to describe the semantic a more clean way. Sigh,
> > it is not easy. I tried several variants and ended up with:
> >
> >    + using "lt" instead of "before" because "lower than" is
> >      a well known mathematical therm.
> 
> I explicitly chose a word other than "less" or "lower" because I was
> concerned people might visualize values. The lpos does not necessarily
> have a lesser or lower value. "Preceeds" would also be a choice of mine.

The word "before" was fine. I proposed "lt" because it was shorter and
I wanted to add "le" variant. I wanted to keep it short also because I
wanted to add another suffix to make it obvious that there was
the twist with wrapping.


> When I see "lt" I immediately think "less than" and "<". But I will not
> fight it. I can handle "lt".
> 
> >    + adding "_safe" suffix to make it clear that it is not
> >      a simple mathematical comparsion. It takes the wrap
> >      into account.
> 
> I find "_safe" confusing. Especially when you look at the implementation
> you wonder, "what is safe about this?". Especially when comparing it to
> all the complexity of the rest of the code. But I can handle "_safe" if
> it is important for you.

OK, forget "_safe". The helper function should make the code more
clear. And it won't work when even you or me are confused.

I though about "_wrap" but it was confusing as well. The code uses
the word "wrap" many times and it is always about wrapping over
the end of the data ring, for example, DATA_WRAPS() computes how
many times the data array was filled [*].

But in this case, data_make_reusable(), and data_push_tail(),
the edge for wrapping is a moving target. It is defined by
data_ring->head_lpos and data_ring->tail_lpos.

[*] It is not the exact number because it is computed from lpos
    which is not initialized to zero and might overflow.

> > Something like:
> >
> > /*
> >  * Returns true when @lpos1 is lower than @lpos2 and both values
> >  * are comparable.
> >  *
> >  * It is safe when the compared values are read a lock less way.
> >  * One of them must be already overwritten when the difference
> >  * is bigger then the data ring buffer size.
> 
> This makes quite a bit of assumptions about the context and intention of
> the call. I preferred my brain teaser version. But to me it is not worth
> bike-shedding. If this explanation helps you, I am fine with it.

My problem with the "brain teaser" version is the sentence"

  "If @lpos1 is more than a full wrap before @lpos2,
   it is considered to be after @lpos2."

It says what it does but it does not explain why. And the "why"
is very important here.

I actually think that the sentence is misleading. If @lpos1 is more
than a full wrap before @lpos2 it is still _before_ @lpos2!

Why we want to return "false" in this case? My understanding is
that it is because we want to break the "while" cycle where
the function is used because we are clearly working with
outdated lpos values.

What about?

/*
 * Return true when @lpos1 is lower than @lpos2 and both values
 * look sane.
 *
 * They are considered insane when the difference is bigger than
 * the data buffer size. It happens when the values are read
 * without locking and another CPU already moved the ring buffer
 * head and/or tail.
 *
 * The caller must behave carefully. The changes based on this
 * check must be done using cmpxchg() to confirm that the check
 * worked with valid values.
 */
static bool lpos1_before_lpos2_sane(struct prb_data_ring *data_ring,
				    unsined long lpos1, unsigned long lpos2)
{
	return lpos2 - lpos1 - 1 < DATA_SIZE(data_ring);
}

Feel free to come up with any other function name or description.
Whatever you think that is more clear. but I have a favor to ask you to:

  + explain why the function returns false when the difference is
    bigger that the data buffer size.

  + ideally avoid the word "wrap" because it has another meaning
    in the printk ring buffer code as explained earlier.


> >>  /*
> >>   * Sanity checker for reserve size. The ringbuffer code assumes that a data
> >>   * block does not exceed the maximum possible size that could fit within the
> >> @@ -577,7 +588,7 @@ static bool data_make_reusable(struct printk_ringbuffer *rb,
> >>  	unsigned long id;
> >>  
> >>  	/* Loop until @lpos_begin has advanced to or beyond @lpos_end. */
> >> -	while ((lpos_end - lpos_begin) - 1 < DATA_SIZE(data_ring)) {
> >> +	while (lpos1_before_lpos2(data_ring, lpos_begin, lpos_end)) {
> >
> > lpos1_lt_lpos2_safe() fits here.
> >
> >>  		blk = to_block(data_ring, lpos_begin);
> >>  		/*
> >> @@ -668,7 +679,7 @@ static bool data_push_tail(struct printk_ringbuffer *rb, unsigned long lpos)
> >>  	 * sees the new tail lpos, any descriptor states that transitioned to
> >>  	 * the reusable state must already be visible.
> >>  	 */
> >> -	while ((lpos - tail_lpos) - 1 < DATA_SIZE(data_ring)) {
> >> +	while (lpos1_before_lpos2(data_ring, tail_lpos, lpos)) {
> >>  		/*
> >>  		 * Make all descriptors reusable that are associated with
> >>  		 * data blocks before @lpos.
> >
> > Same here.
> >
> >> @@ -1149,7 +1160,7 @@ static char *data_realloc(struct printk_ringbuffer *rb, unsigned int size,
> >>  	next_lpos = get_next_lpos(data_ring, blk_lpos->begin, size);
> >>  
> >>  	/* If the data block does not increase, there is nothing to do. */
> >> -	if (head_lpos - next_lpos < DATA_SIZE(data_ring)) {
> >> +	if (!lpos1_before_lpos2(data_ring, head_lpos, next_lpos)) {
> >
> > I think that the original code was correct. And using the "-1" is
> > wrong here.
> 
> You have overlooked that I inverted the check. It is no longer checking:
> 
>     next_pos <= head_pos
> 
> but is instead checking:
> 
>     !(head_pos < next_pos)
> 
> IOW, if "next has not overtaken head".

I see. I missed this. Hmm, this would be correct when the comparsion was
mathemathical (lt, le). But is this correct in our case when take
into account the ring buffer wrapping?

The original check returned "false" when the difference between head_lpos
and next_lpos was bigger than the data ring size.

The new check would return "true", aka "!false", in this case.

Hmm, it seems that the buffer wrapping is not possible because
this code is called when desc_reopen_last() succeeded. And nobody
is allowed to free reopened block.

Anyway, I consider using (!lpos1_before_lpos2()) as highly confusing
in this case.

I would either keep the code as is. Maybe we could add a comment
explaining that

	if (head_lpos - next_lpos < DATA_SIZE(data_ring)) {

might fail only when the substraction is negative. It should never be
positive because head_lpos advanced more than the data buffer size
over next_lpos because the data block is reopened and nobody could
free it.

Maybe, we could even add a check for this.


> > Both data_make_reusable() and data_push_tail() had to use "-1"
> > because it was the "lower than" semantic. But in this case,
> > we do not need to do anything even when "head_lpos == next_lpos"
> >
> > By other words, both data_make_reusable() and data_push_tail()
> > needed to make a free space when the position was "lower than".
> > There was enough space when the values were "equal".
> >
> > It means that "equal" should be OK in data_realloc(). By other
> > words, data_realloc() should use "le" aka "less or equal"
> > semantic.
> >
> > The helper function might be:
> >
> > /*
> >  * Returns true when @lpos1 is lower or equal than @lpos2 and both
> >  * values are comparable.
> >  *
> >  * It is safe when the compared values are read a lock less way.
> >  * One of them must be already overwritten when the difference
> >  * is bigger then the data ring buffer size.
> >  */
> > static bool lpos1_le_lpos2_safe(struct prb_data_ring *data_ring,
> > 				unsined long lpos1, unsigned long lpos2)
> > {
> > 	return lpos2 - lpos1 < DATA_SIZE(data_ring);
> > }
> 
> If you negate lpos1_lt_lpos2_safe() and swap the parameters, there is no
> need for a second helper. That is what I did.

Sigh, lpos1_le_lpos2_safe() does not say the truth after all.
And (!lpos1_lt_lpos2_safe()) looks wrong to me.

I am going to wait what you say about my comments above.

> >> @@ -1262,7 +1273,7 @@ static const char *get_data(struct prb_data_ring *data_ring,
> >>  
> >>  	/* Regular data block: @begin less than @next and in same wrap. */
> >>  	if (!is_blk_wrapped(data_ring, blk_lpos->begin, blk_lpos->next) &&
> >> -	    blk_lpos->begin < blk_lpos->next) {
> >> +	    lpos1_before_lpos2(data_ring, blk_lpos->begin, blk_lpos->next)) {
> >
> > Hmm, I think that it is more complicated here.
> >
> > The "lower than" semantic is weird here. One would expect that "equal"
> > values, aka "zero size" is perfectly fine.
> 
> No, we would _not_ expect that zero size is OK, because we are detecting
> "Regular data blocks", in which case they must _not_ be equal.

It seems that you have more or less agreed with my proposal to
use  check_data_size() in the other replay, see
https://lore.kernel.org/all/87ecqb3qd0.fsf@jogness.linutronix.de/

I think about fixing this in a separate patch and pushing this
into linux-next ASAP to fix the regression.

We could improve the other comparisons later...

How does that sound?
Should I prepare the patch for get_data() are you going to do so?

Best Regards,
Petr

