Return-Path: <linux-fsdevel+bounces-67370-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C12AC3D422
	for <lists+linux-fsdevel@lfdr.de>; Thu, 06 Nov 2025 20:36:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD8C83AF906
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Nov 2025 19:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709B733890E;
	Thu,  6 Nov 2025 19:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0PGUDtUy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hLvN/qk9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970C22BD031;
	Thu,  6 Nov 2025 19:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762457807; cv=none; b=t4UTaWK8lFUV//Qo8cs0rjWkCitlsb/2jJrE0YLQ/xWXObOQFIQue6QiRHXkHv4sfC3kfsx/snjefce81EkNcIFUHZkMQWOUf7hzMNYwDLHParlma8WjHU705AH1cbM/xbX/KumnSMHi85qCGO+kcS3xizrlPN2EnwqbtgcBZdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762457807; c=relaxed/simple;
	bh=vvnFxI0uitgj3UWCA38LA5zCH5SV3GX4L31qva2gAlA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DVH/gKno0HoYEcnMdsls5vPF4QnbcaiqNHqwjN10bUjG8Yq1gcV/eCdFy9JfaZO88TWLFHySsG462pvIm2WkLr5J3tZ2GSNUV2sMlQwx0/XuCyluH1t354DFjgqlHycTko1BYYyXjjnTeo7VszK5NDp3icmxPGG7KcZaNZGK8fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0PGUDtUy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hLvN/qk9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762457803;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e8m7hqDWmGMiD3VZvqj6eJnOHa/EgleS4BSvs95ztZM=;
	b=0PGUDtUy5mXmov+QN6daEJze3fpy9uOdakNj0Z80KT6Y5zXefEaDmf+1cNRdug7iYPSta5
	wfsv2zGaCLT0eVSp9UcRFnoJnL6K6xTAan+hBMg6Du7ZRNsEyNu1ig3fciszn7pI1DIVL1
	bjQwuUskTd91/RQKzETOMszyUbP5nfrviCbBFt5umCZypHPf8drCdt8vMafyuB1tOSEWpM
	+kZPKhVTeP2nD7i7hPOCYVLTG0FvpZxb2iE9Mu2l+Dd5YMR5B79nHvqqVbqxVsBb3rXT6E
	wou9vWaZSpoLNz9L9wrU/4r+PYthBXHulE8OQhakHZIl0BJdeLAVNEYP1mFqSw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762457803;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e8m7hqDWmGMiD3VZvqj6eJnOHa/EgleS4BSvs95ztZM=;
	b=hLvN/qk987oQ/YoxD4VuAngdzwe8vRIT2yABcgAbcxB/iJHWjVPc1acBGNkDhjsemQL1XA
	RmUp4DpLWphMvsDA==
To: Petr Mladek <pmladek@suse.com>
Cc: Joanne Koong <joannelkoong@gmail.com>, syzbot
 <syzbot+3686758660f980b402dc@syzkaller.appspotmail.com>,
 "amurray@thegoodpenguin.co.uk" <amurray@thegoodpenguin.co.uk>,
 brauner@kernel.org, chao@kernel.org, djwong@kernel.org,
 jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-xfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [iomap?] kernel BUG in folio_end_read (2)
In-Reply-To: <87h5v73s5g.fsf@jogness.linutronix.de>
References: <CAJnrk1bF8sLU6tG2MGkt_KR4BoTd_k01CMVZJ9js2-eyh80tbw@mail.gmail.com>
 <69096836.a70a0220.88fb8.0006.GAE@google.com>
 <CAJnrk1Yo4dRVSaPCaAGkHc+in03KaTXJ+KxckhLoSrRxbEdDBg@mail.gmail.com>
 <aQpFLJM96uRpO4S-@pathway.suse.cz> <87ldkk34yj.fsf@jogness.linutronix.de>
 <aQuABK25fdBVTGZc@pathway.suse.cz> <87bjlgqmk5.fsf@jogness.linutronix.de>
 <87tsz7iea2.fsf@jogness.linutronix.de> <aQzLX_y8PvBMiZ9f@pathway.suse.cz>
 <87h5v73s5g.fsf@jogness.linutronix.de>
Date: Thu, 06 Nov 2025 20:42:43 +0106
Message-ID: <87ecqb3qd0.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-11-06, John Ogness <john.ogness@linutronix.de> wrote:
>> I think that we should do the following:
>>
>> diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
>> index 839f504db6d3..78e02711872e 100644
>> --- a/kernel/printk/printk_ringbuffer.c
>> +++ b/kernel/printk/printk_ringbuffer.c
>> @@ -1260,9 +1260,8 @@ static const char *get_data(struct prb_data_ring *data_ring,
>>  		return NULL;
>>  	}
>>  
>> -	/* Regular data block: @begin less than @next and in same wrap. */
>> -	if (!is_blk_wrapped(data_ring, blk_lpos->begin, blk_lpos->next) &&
>> -	    blk_lpos->begin < blk_lpos->next) {
>> +	/* Regular data block: @begin and @next in same wrap. */
>> +	if (!is_blk_wrapped(data_ring, blk_lpos->begin, blk_lpos->next)) {
>>  		db = to_block(data_ring, blk_lpos->begin);
>>  		*data_size = blk_lpos->next - blk_lpos->begin;

Upon further consideration, your suggestion here is better. The wrapping
data block detection should continue to make sure there is exactly one 1
wrap. The size check will not catch the case where there are multiple
wraps.

John

