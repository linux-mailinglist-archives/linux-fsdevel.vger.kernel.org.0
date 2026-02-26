Return-Path: <linux-fsdevel+bounces-78434-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MGR7J+m5n2n5dQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78434-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 04:11:37 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0044E1A05C3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 04:11:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 078DD306146A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 03:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D19AD3815C1;
	Thu, 26 Feb 2026 03:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="fvJ3FXnR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C62371040
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Feb 2026 03:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772075477; cv=none; b=BPPb4Px/L63R6mQVfB8463bsgPdcQj3ojxEV9Lrd4J9gCz1qKjxYRkQ/2nuOROQ+khMuIPh6XVhJ3au3By05CasbdQAbsvX3mysAix5O8XDNkdbKYnwkm5W/S0r1RKytIz3rDpN2VnFLlu1dixeBRGBnZJSK6/CQO2kjwGTjGD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772075477; c=relaxed/simple;
	bh=4YqDnd/Zva/45rCNPYD9mgaYDLej8jBWZYeGVx4Z7ok=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kcQhFKiR3U7th2q9VOMeHIOen65KPMk2QYJF9bIWmFm/f3rd3hXQxjlU6CANWFcoxVy9J10hsn1YKtcXf7rhbpiGPaQB77Wy9qOp3kO6yhAKTcrDdmgxxVxdJWvm82o5o85VeLWw6cmVD4cec65H6Ls3t3ZFMOBB23WijOJTAdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=fvJ3FXnR; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-46398742245so160814b6e.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Feb 2026 19:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1772075473; x=1772680273; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2aeYTgjykkTytqAP0zVL+KvrFyKRcfVgTb0o5/+caF4=;
        b=fvJ3FXnRAbopd4MHwYW/XdUpJ6aOES65sjvzq7eTNtxsjhR7sqYyfBZI7beZRHfcPI
         koJC5VwOWlVDZk25xFASxdtPIO1XYHMx2uhbEac2SIuZPIdWElOWnQo2vMX95OGkSJvK
         Os72KyBYn/Yp86VoFIpPc5Ol3GFqpS1IPvNGpQLy32h0JvzYKjZns6nzBPVEOgZ+sV6t
         tXovmqZGiNr9vw0w8/yMKittpiYeQ+h1Ory6JVl/lFysSGHx9nbF3Hhy8fBPAEUal8y2
         5E3mRS3o3mOX6P8Y3YnPcrRYTFcA2Kg/+qED5fQwVDQ0FsMAfpqXcH+/3RNfT86kU3BH
         7rRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772075473; x=1772680273;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2aeYTgjykkTytqAP0zVL+KvrFyKRcfVgTb0o5/+caF4=;
        b=fSx8HGNn7LLITB+32LYXikyz30YNlNedH75ZaXczUcxbtAD0Yw2PvFrKt04naI8/33
         cn/0wdLDvyhge9NihciaxEqnCqEuKYR/8UazbWt560b9eI6673dxFBvNQPgqaDGaAS3b
         cBalc0aRGpVkKFUZ4q4XCs+rJgW2logTrdBfl/YPzThEN/xOvo4FRAxG8KY5Iaqm/g2C
         RYl/bjQ6j1QKcusO5t6Ecu41TW72ElEWy682Bl9iDzAV/7ohmjBmc0zK2nigokffAFBY
         bNjV58ADmyqM26BIqqfK4pTNqCf7Wjraj+S6Vr4UMXEa1s2XdfzyxNlkWwgyfPQW5iL6
         s8+g==
X-Forwarded-Encrypted: i=1; AJvYcCVqNEwzMO/jXo3R4TeE0Nk3TyC9KfDMjxhHY6YxmjWGte2EQ/ptoV5ENVTsXGho0B3D3xY46OC7R3pd3Up4@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn2SC5PLNpVE8VYr+5ZDQIqbPuV6dbdy8kUQr6T4s1crtnwP5N
	pD2OZHydTCNZhzqyLeHMZQI/edaYziu5Fmwj9+FNADES/49xeoHODs49NFgy8szydpk=
X-Gm-Gg: ATEYQzxK+sxa5hiwf64Ucpn7AdTQv4fVFJonlus5p+kEF3OBbcaoDF3tu2J7FynCCFb
	5Rj1+pDa33Mhayd1ZvDtWMX05puN+MlIA9RG0qP/3loD39KCLm3HWd2RLDjpiL0OlqIDqV9GFEW
	50sxP4FOSG3bS00zlYHJKAbinf37qVSH3UGGUEgH31QNN8gT7rzxWaFJWXBBrHXHgn9ij2PclJz
	Toh5DVuCQDzs00UHsDmGnbnBKmJCAJihqkbdLE8JsZwukHNUFAXWq7pSuMAYjC6rNhLzo7E5GXS
	0XudZo2ygnrLf0dfp05OvZHmY35FB9jVwCydZEIC9xNq8BukCgDpNgrLzClGc5vvfx9ABAOy+N5
	9LcB91HYMkqqWCbQtErOIslXUDEaqx/guTOV9Gjudi+GOb+xOHZmWgijcgLKKGZOHAUCctIrd3h
	Qq6fRb4zn7RyHmCRs+pse20cCFp+95S4nBynAaCUQyfd9pWrJHazHhJrp9keaPJj4h8ktXJAM4p
	K+4GDFEuw==
X-Received: by 2002:a05:6808:4fd4:b0:45e:dbda:add6 with SMTP id 5614622812f47-464463e38fbmr8708984b6e.57.1772075473379;
        Wed, 25 Feb 2026 19:11:13 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4644a1f6333sm10281996b6e.19.2026.02.25.19.11.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Feb 2026 19:11:12 -0800 (PST)
Message-ID: <2e919e7b-1e75-4e57-b6f1-cdf3da4c0424@kernel.dk>
Date: Wed, 25 Feb 2026 20:11:04 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 1/2] filemap: defer dropbehind invalidation from
 IRQ context
To: Tal Zussman <tz2294@columbia.edu>
Cc: "Tigran A. Aivazian" <aivazian.tigran@gmail.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Namjae Jeon <linkinjeon@kernel.org>, Sungjong Seo <sj1557.seo@samsung.com>,
 Yuezhang Mo <yuezhang.mo@sony.com>, Dave Kleikamp <shaggy@kernel.org>,
 Ryusuke Konishi <konishi.ryusuke@gmail.com>,
 Viacheslav Dubeyko <slava@dubeyko.com>,
 Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
 Bob Copeland <me@bobcopeland.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
 linux-nilfs@vger.kernel.org, ntfs3@lists.linux.dev,
 linux-karma-devel@lists.sourceforge.net, linux-mm@kvack.org
References: <20260225-blk-dontcache-v2-0-70e7ac4f7108@columbia.edu>
 <20260225-blk-dontcache-v2-1-70e7ac4f7108@columbia.edu>
 <c8078a80-f801-4f8a-b3cd-e2ccbfca1def@kernel.dk>
 <CAKha_srSdS46FM8K-RKaiinP0y6kx_MhxnHjZ0KKP1NOAL+STA@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAKha_srSdS46FM8K-RKaiinP0y6kx_MhxnHjZ0KKP1NOAL+STA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-78434-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[kernel.dk];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,zeniv.linux.org.uk,kernel.org,suse.cz,samsung.com,sony.com,dubeyko.com,paragon-software.com,bobcopeland.com,infradead.org,linux-foundation.org,vger.kernel.org,lists.sourceforge.net,lists.linux.dev,kvack.org];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel-dk.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.992];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,columbia.edu:email,kernel-dk.20230601.gappssmtp.com:dkim,kernel.dk:mid,kernel.dk:email]
X-Rspamd-Queue-Id: 0044E1A05C3
X-Rspamd-Action: no action

On 2/25/26 6:38 PM, Tal Zussman wrote:
> On Wed, Feb 25, 2026 at 5:52?PM Jens Axboe <axboe@kernel.dk> wrote:
>> On 2/25/26 3:40 PM, Tal Zussman wrote:
>>> folio_end_dropbehind() is called from folio_end_writeback(), which can
>>> run in IRQ context through buffer_head completion.
>>>
>>> Previously, when folio_end_dropbehind() detected !in_task(), it skipped
>>> the invalidation entirely. This meant that folios marked for dropbehind
>>> via RWF_DONTCACHE would remain in the page cache after writeback when
>>> completed from IRQ context, defeating the purpose of using it.
>>>
>>> Fix this by deferring the dropbehind invalidation to a work item.  When
>>> folio_end_dropbehind() is called from IRQ context, the folio is added to
>>> a global folio_batch and the work item is scheduled. The worker drains
>>> the batch, locking each folio and calling filemap_end_dropbehind(), and
>>> re-drains if new folios arrived while processing.
>>>
>>> This unblocks enabling RWF_UNCACHED for block devices and other
>>> buffer_head-based I/O.
>>>
>>> Signed-off-by: Tal Zussman <tz2294@columbia.edu>
>>> ---
>>>  mm/filemap.c | 84 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++----
>>>  1 file changed, 79 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/mm/filemap.c b/mm/filemap.c
>>> index ebd75684cb0a..6263f35c5d13 100644
>>> --- a/mm/filemap.c
>>> +++ b/mm/filemap.c
>>> @@ -1085,6 +1085,8 @@ static const struct ctl_table filemap_sysctl_table[] = {
>>>   }
>>>  };
>>>
>>> +static void __init dropbehind_init(void);
>>> +
>>>  void __init pagecache_init(void)
>>>  {
>>>   int i;
>>> @@ -1092,6 +1094,7 @@ void __init pagecache_init(void)
>>>   for (i = 0; i < PAGE_WAIT_TABLE_SIZE; i++)
>>>   init_waitqueue_head(&folio_wait_table[i]);
>>>
>>> + dropbehind_init();
>>>   page_writeback_init();
>>>   register_sysctl_init("vm", filemap_sysctl_table);
>>>  }
>>> @@ -1613,23 +1616,94 @@ static void filemap_end_dropbehind(struct folio *folio)
>>>   * If folio was marked as dropbehind, then pages should be dropped when writeback
>>>   * completes. Do that now. If we fail, it's likely because of a big folio -
>>>   * just reset dropbehind for that case and latter completions should invalidate.
>>> + *
>>> + * When called from IRQ context (e.g. buffer_head completion), we cannot lock
>>> + * the folio and invalidate. Defer to a workqueue so that callers like
>>> + * end_buffer_async_write() that complete in IRQ context still get their folios
>>> + * pruned.
>>>   */
>>> +static DEFINE_SPINLOCK(dropbehind_lock);
>>> +static struct folio_batch dropbehind_fbatch;
>>> +static struct work_struct dropbehind_work;
>>> +
>>> +static void dropbehind_work_fn(struct work_struct *w)
>>> +{
>>> + struct folio_batch fbatch;
>>> +
>>> +again:
>>> + spin_lock_irq(&dropbehind_lock);
>>> + fbatch = dropbehind_fbatch;
>>> + folio_batch_reinit(&dropbehind_fbatch);
>>> + spin_unlock_irq(&dropbehind_lock);
>>> +
>>> + for (int i = 0; i < folio_batch_count(&fbatch); i++) {
>>> + struct folio *folio = fbatch.folios[i];
>>> +
>>> + if (folio_trylock(folio)) {
>>> + filemap_end_dropbehind(folio);
>>> + folio_unlock(folio);
>>> + }
>>> + folio_put(folio);
>>> + }
>>> +
>>> + /* Drain folios that were added while we were processing. */
>>> + spin_lock_irq(&dropbehind_lock);
>>> + if (folio_batch_count(&dropbehind_fbatch)) {
>>> + spin_unlock_irq(&dropbehind_lock);
>>> + goto again;
>>> + }
>>> + spin_unlock_irq(&dropbehind_lock);
>>> +}
>>> +
>>> +static void __init dropbehind_init(void)
>>> +{
>>> + folio_batch_init(&dropbehind_fbatch);
>>> + INIT_WORK(&dropbehind_work, dropbehind_work_fn);
>>> +}
>>> +
>>> +static void folio_end_dropbehind_irq(struct folio *folio)
>>> +{
>>> + unsigned long flags;
>>> +
>>> + spin_lock_irqsave(&dropbehind_lock, flags);
>>> +
>>> + /* If there is no space in the folio_batch, skip the invalidation. */
>>> + if (!folio_batch_space(&dropbehind_fbatch)) {
>>> + spin_unlock_irqrestore(&dropbehind_lock, flags);
>>> + return;
>>> + }
>>> +
>>> + folio_get(folio);
>>> + folio_batch_add(&dropbehind_fbatch, folio);
>>> + spin_unlock_irqrestore(&dropbehind_lock, flags);
>>> +
>>> + schedule_work(&dropbehind_work);
>>> +}
>>
>> How well does this scale? I did a patch basically the same as this, but
>> not using a folio batch though. But the main sticking point was
>> dropbehind_lock contention, to the point where I left it alone and
>> thought "ok maybe we just do this when we're done with the awful
>> buffer_head stuff". What happens if you have N threads doing IO at the
>> same time to N block devices? I suspect it'll look absolutely terrible,
>> as each thread will be banging on that dropbehind_lock.
>>
>> One solution could potentially be to use per-cpu lists for this. If you
>> have N threads working on separate block devices, they will tend to be
>> sticky to their CPU anyway.
>>
>> tldr - I don't believe the above will work well enough to scale
>> appropriately.
>>
>> Let me know if you want me to test this on my big box, it's got a bunch
>> of drives and CPUs to match.
>>
>> I did a patch exactly matching this, youc an probably find it
> 
> Yep, that makes sense. I think a per-cpu folio_batch, spinlock, and
> work_struct would solve this (assuming that's what you meant by
> per-cpu lists) and would be simple enough to implement. I can put that
> together and send it tomorrow. I'll see if I can find your patch too.

Was just looking for my patch as well... I don't think I ever posted it,
because I didn't like it very much. It's probably sitting in my git tree
somewhere.

But it looks very much the same as yours, modulo the folio batching.

One thing to keep in mind with per-cpu lists and then a per-cpu work
item is that you will potentially have all of them running. Hopefully
they can do that without burning too much CPU. However, might be more
useful to have one per node or something like that, provided it can keep
up, and just have that worker iterate the lists in that node. But we can
experiment with that, I'd say just do the naive version first which is
basically this patch but turned into a per-cpu collection of
lock/list/work_item.

> Any testing you can do on that version would be very appreciated! I'm
> unfortunately disk-limited for the moment...

No problem - I've got 32 drives in that box, and can hit about
230-240GB/sec of bandwidth off those drives. It'll certainly spot any
issues with scaling this and having many threads running uncached IO.

-- 
Jens Axboe

