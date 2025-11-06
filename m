Return-Path: <linux-fsdevel+bounces-67367-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DCCEEC3D1F2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 06 Nov 2025 19:58:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3A20D4E2CCE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Nov 2025 18:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF75351FAA;
	Thu,  6 Nov 2025 18:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ne6IZX8v";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vLytAN2x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF792580E1;
	Thu,  6 Nov 2025 18:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762455489; cv=none; b=JjJceShDAk+M/uhWumEMXZ5q8pq/i1JBJJcIHAxWPtBis8812Ppespy8e9duFBl3cSAQHhX1lV1uViE9wSr3RllksT3fp6bBvvtjWQ+gKBGQ5bOp06o6FXOSoECrd8NRCNTiP/UkM0Oa03EgZyWpPgadHwuC9S9xQDBDZbnTVJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762455489; c=relaxed/simple;
	bh=5KqT4KCJFpxvHex8i6POgBnHb1cAaMrCyZdv0GaCTKs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BNUt30JSnOF62MliD0QPGSunuuhnjMXbv90TgHtpuNfGwBnLFHySzgcYseOmdUO8T646g1Ciz8ck//XcENUcX1n3mqvc1XYAWsQ4nV/GeEJwPAduE67AKfwiGZa8Cu3BCTbfpwfLP2+bya95TXVT54/ieN/Ihz5QTA2Be4CJkhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ne6IZX8v; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vLytAN2x; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762455484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mWMyuixnst/vfm8/10KssX5w/ZtcrBMY+5+JVb+DTU4=;
	b=ne6IZX8vOnSnujWL7niEpvzOXSwkbcEah8Y0U53yPNBJzsCnhaJP4y0oyqSXCAex0F6mK/
	pUZQR458x4LZqHJtrWdh0Tjwoincl7rwIbcp+xsG2fTOIKyvFFvlpOUgqDqBhWHTFYftT3
	40hsQu1De4xpx9phH7rrq1/HymLh7To7CU+VhObqwN7SQFL8lul6BnRJmSSVj5ei/IOK0z
	uk2TG+ZsmC80NmzoGpwNpjr7NWGdhXQlIoZmdmT3nfpDVaFK22bdLXU2ugCvs6CrQuD4sh
	R8NKSh1vHrqDeVbiTOEvWQtXu5i7zd6tNdYEpnB+0A7SD1M8VFq/fkNf1EQEMA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762455484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mWMyuixnst/vfm8/10KssX5w/ZtcrBMY+5+JVb+DTU4=;
	b=vLytAN2x2CKboH6PJj7U+1rQKrlMp/RZLscVdXuAU2IDgMWIofWXa4cxClMN5b51u3N0+p
	MYm/GF5NvbB1g3Dw==
To: Petr Mladek <pmladek@suse.com>
Cc: Joanne Koong <joannelkoong@gmail.com>, syzbot
 <syzbot+3686758660f980b402dc@syzkaller.appspotmail.com>,
 "amurray@thegoodpenguin.co.uk" <amurray@thegoodpenguin.co.uk>,
 brauner@kernel.org, chao@kernel.org, djwong@kernel.org,
 jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-xfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [iomap?] kernel BUG in folio_end_read (2)
In-Reply-To: <aQzLX_y8PvBMiZ9f@pathway.suse.cz>
References: <CAJnrk1bF8sLU6tG2MGkt_KR4BoTd_k01CMVZJ9js2-eyh80tbw@mail.gmail.com>
 <69096836.a70a0220.88fb8.0006.GAE@google.com>
 <CAJnrk1Yo4dRVSaPCaAGkHc+in03KaTXJ+KxckhLoSrRxbEdDBg@mail.gmail.com>
 <aQpFLJM96uRpO4S-@pathway.suse.cz> <87ldkk34yj.fsf@jogness.linutronix.de>
 <aQuABK25fdBVTGZc@pathway.suse.cz> <87bjlgqmk5.fsf@jogness.linutronix.de>
 <87tsz7iea2.fsf@jogness.linutronix.de> <aQzLX_y8PvBMiZ9f@pathway.suse.cz>
Date: Thu, 06 Nov 2025 20:04:03 +0106
Message-ID: <87h5v73s5g.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-11-06, Petr Mladek <pmladek@suse.com> wrote:
>> diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
>> index 839f504db6d30..8499ee642c31d 100644
>> --- a/kernel/printk/printk_ringbuffer.c
>> +++ b/kernel/printk/printk_ringbuffer.c
>> @@ -390,6 +390,17 @@ static unsigned int to_blk_size(unsigned int size)
>>  	return size;
>>  }
>>  
>> +/*
>> + * Check if @lpos1 is before @lpos2. This takes ringbuffer wrapping
>> + * into account. If @lpos1 is more than a full wrap before @lpos2,
>> + * it is considered to be after @lpos2.
>
> The 2nd sentence is a brain teaser ;-)
>
>> + */
>> +static bool lpos1_before_lpos2(struct prb_data_ring *data_ring,
>> +			       unsigned long lpos1, unsigned long lpos2)
>> +{
>> +	return lpos2 - lpos1 - 1 < DATA_SIZE(data_ring);
>> +}
>
> It would be nice to describe the semantic a more clean way. Sigh,
> it is not easy. I tried several variants and ended up with:
>
>    + using "lt" instead of "before" because "lower than" is
>      a well known mathematical therm.

I explicitly chose a word other than "less" or "lower" because I was
concerned people might visualize values. The lpos does not necessarily
have a lesser or lower value. "Preceeds" would also be a choice of mine.

When I see "lt" I immediately think "less than" and "<". But I will not
fight it. I can handle "lt".

>    + adding "_safe" suffix to make it clear that it is not
>      a simple mathematical comparsion. It takes the wrap
>      into account.

I find "_safe" confusing. Especially when you look at the implementation
you wonder, "what is safe about this?". Especially when comparing it to
all the complexity of the rest of the code. But I can handle "_safe" if
it is important for you.

> Something like:
>
> /*
>  * Returns true when @lpos1 is lower than @lpos2 and both values
>  * are comparable.
>  *
>  * It is safe when the compared values are read a lock less way.
>  * One of them must be already overwritten when the difference
>  * is bigger then the data ring buffer size.

This makes quite a bit of assumptions about the context and intention of
the call. I preferred my brain teaser version. But to me it is not worth
bike-shedding. If this explanation helps you, I am fine with it.

>  */
> static bool lpos1_lt_lpos2_safe(struct prb_data_ring *data_ring,
> 				unsined long lpos1, unsigned long lpos2)
> {
> 	return lpos2 - lpos1 - 1 < DATA_SIZE(data_ring);
> }
>
>>  /*
>>   * Sanity checker for reserve size. The ringbuffer code assumes that a data
>>   * block does not exceed the maximum possible size that could fit within the
>> @@ -577,7 +588,7 @@ static bool data_make_reusable(struct printk_ringbuffer *rb,
>>  	unsigned long id;
>>  
>>  	/* Loop until @lpos_begin has advanced to or beyond @lpos_end. */
>> -	while ((lpos_end - lpos_begin) - 1 < DATA_SIZE(data_ring)) {
>> +	while (lpos1_before_lpos2(data_ring, lpos_begin, lpos_end)) {
>
> lpos1_lt_lpos2_safe() fits here.
>
>>  		blk = to_block(data_ring, lpos_begin);
>>  		/*
>> @@ -668,7 +679,7 @@ static bool data_push_tail(struct printk_ringbuffer *rb, unsigned long lpos)
>>  	 * sees the new tail lpos, any descriptor states that transitioned to
>>  	 * the reusable state must already be visible.
>>  	 */
>> -	while ((lpos - tail_lpos) - 1 < DATA_SIZE(data_ring)) {
>> +	while (lpos1_before_lpos2(data_ring, tail_lpos, lpos)) {
>>  		/*
>>  		 * Make all descriptors reusable that are associated with
>>  		 * data blocks before @lpos.
>
> Same here.
>
>> @@ -1149,7 +1160,7 @@ static char *data_realloc(struct printk_ringbuffer *rb, unsigned int size,
>>  	next_lpos = get_next_lpos(data_ring, blk_lpos->begin, size);
>>  
>>  	/* If the data block does not increase, there is nothing to do. */
>> -	if (head_lpos - next_lpos < DATA_SIZE(data_ring)) {
>> +	if (!lpos1_before_lpos2(data_ring, head_lpos, next_lpos)) {
>
> I think that the original code was correct. And using the "-1" is
> wrong here.

You have overlooked that I inverted the check. It is no longer checking:

    next_pos <= head_pos

but is instead checking:

    !(head_pos < next_pos)

IOW, if "next has not overtaken head".

> Both data_make_reusable() and data_push_tail() had to use "-1"
> because it was the "lower than" semantic. But in this case,
> we do not need to do anything even when "head_lpos == next_lpos"
>
> By other words, both data_make_reusable() and data_push_tail()
> needed to make a free space when the position was "lower than".
> There was enough space when the values were "equal".
>
> It means that "equal" should be OK in data_realloc(). By other
> words, data_realloc() should use "le" aka "less or equal"
> semantic.
>
> The helper function might be:
>
> /*
>  * Returns true when @lpos1 is lower or equal than @lpos2 and both
>  * values are comparable.
>  *
>  * It is safe when the compared values are read a lock less way.
>  * One of them must be already overwritten when the difference
>  * is bigger then the data ring buffer size.
>  */
> static bool lpos1_le_lpos2_safe(struct prb_data_ring *data_ring,
> 				unsined long lpos1, unsigned long lpos2)
> {
> 	return lpos2 - lpos1 < DATA_SIZE(data_ring);
> }

If you negate lpos1_lt_lpos2_safe() and swap the parameters, there is no
need for a second helper. That is what I did.

>> @@ -1262,7 +1273,7 @@ static const char *get_data(struct prb_data_ring *data_ring,
>>  
>>  	/* Regular data block: @begin less than @next and in same wrap. */
>>  	if (!is_blk_wrapped(data_ring, blk_lpos->begin, blk_lpos->next) &&
>> -	    blk_lpos->begin < blk_lpos->next) {
>> +	    lpos1_before_lpos2(data_ring, blk_lpos->begin, blk_lpos->next)) {
>
> Hmm, I think that it is more complicated here.
>
> The "lower than" semantic is weird here. One would expect that "equal"
> values, aka "zero size" is perfectly fine.

No, we would _not_ expect that zero size is OK, because we are detecting
"Regular data blocks", in which case they must _not_ be equal.

> It does not hurt because the "zero size" case is already handled
> earlier. But still, the "lower than" semantic does not fit here.

Currently we have 3 explicit checks:

1. data-less

2. regular

3. wrapping

But I agree the checks are "relaxed" because we are doing only minimal
sanity checks on the positions, rather than size validation.

> IMHO, the main motivation for this fix is to make sure that
> blk_lpos->begin and blk_lpos->next will produce a valid
> *data_size.
>
> From this POV, even lpos1_le_lpos2_safe() does not fit here
> because the data_size must be lower than half of the size
> of the ring buffer.

Currently we do not do size validation for reading, only for writing. If
you are arguing that we _should_ perform better size validation on read,
then I agree this is the place for it.

>> 		db = to_block(data_ring, blk_lpos->begin);
>>  		*data_size = blk_lpos->next - blk_lpos->begin;
>
> I think that we should do the following:
>
> diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
> index 839f504db6d3..78e02711872e 100644
> --- a/kernel/printk/printk_ringbuffer.c
> +++ b/kernel/printk/printk_ringbuffer.c
> @@ -1260,9 +1260,8 @@ static const char *get_data(struct prb_data_ring *data_ring,
>  		return NULL;
>  	}
>  
> -	/* Regular data block: @begin less than @next and in same wrap. */
> -	if (!is_blk_wrapped(data_ring, blk_lpos->begin, blk_lpos->next) &&
> -	    blk_lpos->begin < blk_lpos->next) {
> +	/* Regular data block: @begin and @next in same wrap. */
> +	if (!is_blk_wrapped(data_ring, blk_lpos->begin, blk_lpos->next)) {
>  		db = to_block(data_ring, blk_lpos->begin);
>  		*data_size = blk_lpos->next - blk_lpos->begin;
>  
> @@ -1279,6 +1278,10 @@ static const char *get_data(struct prb_data_ring *data_ring,
>  		return NULL;
>  	}
>  
> +	/* Double check that the data_size is reasonable. */
> +	if (WARN_ON_ONCE(!data_check_size(data_ring, *data_size)))
> +		return NULL;
> +
>  	/* A valid data block will always be aligned to the ID size. */
>  	if (WARN_ON_ONCE(blk_lpos->begin != ALIGN(blk_lpos->begin, sizeof(db->id))) ||
>  	    WARN_ON_ONCE(blk_lpos->next != ALIGN(blk_lpos->next, sizeof(db->id)))) {
>
> 1. Just distinguish regular vs. wrapped. vs. invalid block.
>
> 2. Add sanity check for the "data_size". It might catch some wrong values
>    in both code paths for "regular" and "wrapped" blocks. So, win win.
>
> How does that sound?

I think it can be made even more simple since we are adding size
validation:

diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
index b7ab4e75917f0..04bc863eae411 100644
--- a/kernel/printk/printk_ringbuffer.c
+++ b/kernel/printk/printk_ringbuffer.c
@@ -1271,23 +1271,15 @@ static const char *get_data(struct prb_data_ring *data_ring,
 		return NULL;
 	}
 
-	/* Regular data block: @begin less than @next and in same wrap. */
-	if (!is_blk_wrapped(data_ring, blk_lpos->begin, blk_lpos->next) &&
-	    blk_lpos->begin < blk_lpos->next) {
-		db = to_block(data_ring, blk_lpos->begin);
-		*data_size = blk_lpos->next - blk_lpos->begin;
-
-	/* Wrapping data block: @begin is one wrap behind @next. */
-	} else if (!is_blk_wrapped(data_ring,
-				   blk_lpos->begin + DATA_SIZE(data_ring),
-				   blk_lpos->next)) {
+	/* Wrapping data block description. */
+	if (is_blk_wrapped(data_ring, blk_lpos->begin, blk_lpos->next)) {
 		db = to_block(data_ring, 0);
 		*data_size = DATA_INDEX(data_ring, blk_lpos->next);
 
-	/* Illegal block description. */
+	/* Regular data block description. */
 	} else {
-		WARN_ON_ONCE(1);
-		return NULL;
+		db = to_block(data_ring, blk_lpos->begin);
+		*data_size = blk_lpos->next - blk_lpos->begin;
 	}
 
 	/* A valid data block will always be aligned to the ID size. */
@@ -1300,6 +1292,10 @@ static const char *get_data(struct prb_data_ring *data_ring,
 	if (WARN_ON_ONCE(*data_size < sizeof(db->id)))
 		return NULL;
 
+	/* Check if the data size is at least legal. */
+	if (WARN_ON_ONCE(!data_check_size(data_ring, *data_size)))
+		return NULL;
+
 	/* Subtract block ID space from size to reflect data size. */
 	*data_size -= sizeof(db->id);
 
So it ends up looking like this:

	/* Wrapping data block description. */
	if (is_blk_wrapped(data_ring, blk_lpos->begin, blk_lpos->next)) {
		db = to_block(data_ring, 0);
		*data_size = DATA_INDEX(data_ring, blk_lpos->next);

	/* Regular data block description. */
	} else {
		db = to_block(data_ring, blk_lpos->begin);
		*data_size = blk_lpos->next - blk_lpos->begin;
	}
...
	/* Ensure the data size is at least legal. */
	if (WARN_ON_ONCE(!data_check_size(data_ring, *data_size)))
		return NULL;

(Note that there is already WARN_ON_ONCE() checks for misaligned lpos
values and sizes less than sizeof(id).)

How does this sound?

John

