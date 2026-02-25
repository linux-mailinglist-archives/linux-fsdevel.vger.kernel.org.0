Return-Path: <linux-fsdevel+bounces-78411-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oACkLkV9n2mrcQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78411-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 23:52:53 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E36E719E7AB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 23:52:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3DDEF300B518
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 22:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F1A366839;
	Wed, 25 Feb 2026 22:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="PyyFmDLL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36D9366060
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Feb 2026 22:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772059967; cv=none; b=XUByiSf7PD3rEyBUD5aQkCVH8yPKrO8CtCNROr57x+m00BblHudk1XMQDKrbDkhew4Pj45b86dSoCpQZe0QGQd8bT9ELO0MiAQYyooERDq6uj+jSpfHLa1TjuSgIlxjSEsIGz4R2egDaZ2DVmJQC/cKC7S1shEtAHxDwTk+lxu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772059967; c=relaxed/simple;
	bh=wl1g8RbugLIpEDcyc9u4uEv7Y6gAeD6SXR7a/OTVtKg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ceIX5rU/MpQigCCQvG/XRQvTNNllTcdz0ssP1QeytfU/kKZBOWVb1gDwmrj9xElGiFVm5ljk+kBJuHQ9YBzteBcAOkK6CBntQK5S9GUYJ2UahhNlvy9aT9k2DFzUzYEq+RtvRZB+rAemA8l0vRo352xnR9hfJ1cYXtZEktLC0iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=PyyFmDLL; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8c70b5594f4so7225685a.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Feb 2026 14:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1772059965; x=1772664765; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lV5yfIvdQy795zXZiEFYEcuoFYVuQqyybCf8AopsVu4=;
        b=PyyFmDLLmfYGeUoSFdMNaKcxPIYfVWRyKHkjYN1AOMLfJjBkgVhelDmRwyaNkrvaxg
         X5Tftjj54JW4LcXOOXe4ydWQtvSCDKkti7pwobNJNqGWVbwR246lnWp+1JHxeo1tjB+a
         Hfk0M4D/g4q4BNiHWI5+bTzgsK1JbXr8ybVVN2/vHfSAS3Z/gQbr05x5T2/lVGC2i1So
         EZ4zGAfHl/MWl/pRUsJlMLdane92z65ltzx7z6EjBl19O2KKF1ET1wWtHNM6CzfgZq9P
         gC0XxK9lsby6dwIlS2aE1ykYeVebLuNb70ieBpLFHaIhDNod4Adz0pvZJp9vGncw5CKJ
         49ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772059965; x=1772664765;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lV5yfIvdQy795zXZiEFYEcuoFYVuQqyybCf8AopsVu4=;
        b=TqX86Eafl/74GrbCgF4dtozOK/krFg3Z4Pp6uE+LkIYCR9yYYSYczhglf/md6MRRU8
         Qv/xQDZH1fZn790zgQSplrEIJjyE3bJ8aa1+Xp86tDaSue18p8ifl8IKABX/iTrnnn9C
         9MyMJ5MacCJP5h25u+iIO5lRxbyQTgRk7eqCwXIDUJJHuUZw6w2zlVQxzHWcqvVt4XZW
         I00Pa15etU2gEUwLXYvxga8K6W0sOVgVCCqOlM6J3Q2F7mitdKXaaFDyBaNmEdtLKh9Z
         ZJla0upMUvu3tNCj03kICdXvGJjPFlB+obLrUbGgC+3DmzoNF+XTIO3/Mxvn3bUwPw9r
         45vw==
X-Forwarded-Encrypted: i=1; AJvYcCW9unkufpwjtnKSbwAB1nT50HlOP1qr7tLFkBJK/AgFqZmNzvS9hhKwo2PYqwhQyvU7GqRPTwMPCt1Z+DwA@vger.kernel.org
X-Gm-Message-State: AOJu0YwobZCe0tAVxG3eAYKr2KqP/ztvB2NDDq1KB0TFTTDzt1UEvIAl
	bYioFHWNYx0yYnG1HI4Cn3SElLJOZwqf33qPf++rmj/DLjj0ZZ8m/4anqNBIs+r1gSU=
X-Gm-Gg: ATEYQzwdgtJsEY5cZHuC62Y0X42l6gXAl6WukUJHTpud4ex6JbzIdvS3/+eFoEThOdp
	1MfZ0RYycSicPZiesk2x4IfiTXJl6OIlCGbXHERIIxhX671laLNPGdwdbMv6rrvf059ljkG2Y8z
	bZsCXIfKTf0P+xGlASOPMse0ht/JcKtY/mOsTRoBumCLKxTpkju75eLjSWq1J7lQvvZqJH7+C3I
	A+JjT+NB15asXj1NkUyrWe81c/EVNS+78O8Joavs2/Ylt5s/nyEXErndzx8T0bCoyU8fniePFnI
	rnshsRWg4eFBH+gZhg1Q/h6o6UylibtP3X0Uxi3uUicKfsXNKsYIZMPd/SfA4kLszKYoFeq4yYs
	ChJAYhyLWWAULbP2XxJuMpP/8lOHcvLrgKIwwTnlWPuNh/0zwiWQ7Xtef2HRLYI55+H5nbhg9uF
	BS2M02ytzU9/4UbJcYhXkBLMoL1/vK/PpYDQ6ih25j7h7CKYbj+5PtVhOJ05usC+S4jIVgWZnv8
	dEqTE/9
X-Received: by 2002:a05:620a:2807:b0:8cb:2b1f:99e4 with SMTP id af79cd13be357-8cbbf3cf398mr113515285a.34.1772059964616;
        Wed, 25 Feb 2026 14:52:44 -0800 (PST)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf652bb6sm51863585a.4.2026.02.25.14.52.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Feb 2026 14:52:44 -0800 (PST)
Message-ID: <c8078a80-f801-4f8a-b3cd-e2ccbfca1def@kernel.dk>
Date: Wed, 25 Feb 2026 15:52:41 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 1/2] filemap: defer dropbehind invalidation from
 IRQ context
To: Tal Zussman <tz2294@columbia.edu>,
 "Tigran A. Aivazian" <aivazian.tigran@gmail.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Namjae Jeon <linkinjeon@kernel.org>, Sungjong Seo <sj1557.seo@samsung.com>,
 Yuezhang Mo <yuezhang.mo@sony.com>, Dave Kleikamp <shaggy@kernel.org>,
 Ryusuke Konishi <konishi.ryusuke@gmail.com>,
 Viacheslav Dubeyko <slava@dubeyko.com>,
 Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
 Bob Copeland <me@bobcopeland.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 jfs-discussion@lists.sourceforge.net, linux-nilfs@vger.kernel.org,
 ntfs3@lists.linux.dev, linux-karma-devel@lists.sourceforge.net,
 linux-mm@kvack.org
References: <20260225-blk-dontcache-v2-0-70e7ac4f7108@columbia.edu>
 <20260225-blk-dontcache-v2-1-70e7ac4f7108@columbia.edu>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260225-blk-dontcache-v2-1-70e7ac4f7108@columbia.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78411-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[columbia.edu,gmail.com,zeniv.linux.org.uk,kernel.org,suse.cz,samsung.com,sony.com,dubeyko.com,paragon-software.com,bobcopeland.com,infradead.org,linux-foundation.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[kernel.dk];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel-dk.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,kernel-dk.20230601.gappssmtp.com:dkim,columbia.edu:email,kernel.dk:mid]
X-Rspamd-Queue-Id: E36E719E7AB
X-Rspamd-Action: no action

On 2/25/26 3:40 PM, Tal Zussman wrote:
> folio_end_dropbehind() is called from folio_end_writeback(), which can
> run in IRQ context through buffer_head completion.
> 
> Previously, when folio_end_dropbehind() detected !in_task(), it skipped
> the invalidation entirely. This meant that folios marked for dropbehind
> via RWF_DONTCACHE would remain in the page cache after writeback when
> completed from IRQ context, defeating the purpose of using it.
> 
> Fix this by deferring the dropbehind invalidation to a work item.  When
> folio_end_dropbehind() is called from IRQ context, the folio is added to
> a global folio_batch and the work item is scheduled. The worker drains
> the batch, locking each folio and calling filemap_end_dropbehind(), and
> re-drains if new folios arrived while processing.
> 
> This unblocks enabling RWF_UNCACHED for block devices and other
> buffer_head-based I/O.
> 
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>
> ---
>  mm/filemap.c | 84 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 79 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index ebd75684cb0a..6263f35c5d13 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -1085,6 +1085,8 @@ static const struct ctl_table filemap_sysctl_table[] = {
>  	}
>  };
>  
> +static void __init dropbehind_init(void);
> +
>  void __init pagecache_init(void)
>  {
>  	int i;
> @@ -1092,6 +1094,7 @@ void __init pagecache_init(void)
>  	for (i = 0; i < PAGE_WAIT_TABLE_SIZE; i++)
>  		init_waitqueue_head(&folio_wait_table[i]);
>  
> +	dropbehind_init();
>  	page_writeback_init();
>  	register_sysctl_init("vm", filemap_sysctl_table);
>  }
> @@ -1613,23 +1616,94 @@ static void filemap_end_dropbehind(struct folio *folio)
>   * If folio was marked as dropbehind, then pages should be dropped when writeback
>   * completes. Do that now. If we fail, it's likely because of a big folio -
>   * just reset dropbehind for that case and latter completions should invalidate.
> + *
> + * When called from IRQ context (e.g. buffer_head completion), we cannot lock
> + * the folio and invalidate. Defer to a workqueue so that callers like
> + * end_buffer_async_write() that complete in IRQ context still get their folios
> + * pruned.
>   */
> +static DEFINE_SPINLOCK(dropbehind_lock);
> +static struct folio_batch dropbehind_fbatch;
> +static struct work_struct dropbehind_work;
> +
> +static void dropbehind_work_fn(struct work_struct *w)
> +{
> +	struct folio_batch fbatch;
> +
> +again:
> +	spin_lock_irq(&dropbehind_lock);
> +	fbatch = dropbehind_fbatch;
> +	folio_batch_reinit(&dropbehind_fbatch);
> +	spin_unlock_irq(&dropbehind_lock);
> +
> +	for (int i = 0; i < folio_batch_count(&fbatch); i++) {
> +		struct folio *folio = fbatch.folios[i];
> +
> +		if (folio_trylock(folio)) {
> +			filemap_end_dropbehind(folio);
> +			folio_unlock(folio);
> +		}
> +		folio_put(folio);
> +	}
> +
> +	/* Drain folios that were added while we were processing. */
> +	spin_lock_irq(&dropbehind_lock);
> +	if (folio_batch_count(&dropbehind_fbatch)) {
> +		spin_unlock_irq(&dropbehind_lock);
> +		goto again;
> +	}
> +	spin_unlock_irq(&dropbehind_lock);
> +}
> +
> +static void __init dropbehind_init(void)
> +{
> +	folio_batch_init(&dropbehind_fbatch);
> +	INIT_WORK(&dropbehind_work, dropbehind_work_fn);
> +}
> +
> +static void folio_end_dropbehind_irq(struct folio *folio)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&dropbehind_lock, flags);
> +
> +	/* If there is no space in the folio_batch, skip the invalidation. */
> +	if (!folio_batch_space(&dropbehind_fbatch)) {
> +		spin_unlock_irqrestore(&dropbehind_lock, flags);
> +		return;
> +	}
> +
> +	folio_get(folio);
> +	folio_batch_add(&dropbehind_fbatch, folio);
> +	spin_unlock_irqrestore(&dropbehind_lock, flags);
> +
> +	schedule_work(&dropbehind_work);
> +}

How well does this scale? I did a patch basically the same as this, but
not using a folio batch though. But the main sticking point was
dropbehind_lock contention, to the point where I left it alone and
thought "ok maybe we just do this when we're done with the awful
buffer_head stuff". What happens if you have N threads doing IO at the
same time to N block devices? I suspect it'll look absolutely terrible,
as each thread will be banging on that dropbehind_lock.

One solution could potentially be to use per-cpu lists for this. If you
have N threads working on separate block devices, they will tend to be
sticky to their CPU anyway.

tldr - I don't believe the above will work well enough to scale
appropriately.

Let me know if you want me to test this on my big box, it's got a bunch
of drives and CPUs to match.

I did a patch exactly matching this, youc an probably find it 

>  void folio_end_dropbehind(struct folio *folio)
>  {
>  	if (!folio_test_dropbehind(folio))
>  		return;
>  
>  	/*
> -	 * Hitting !in_task() should not happen off RWF_DONTCACHE writeback,
> -	 * but can happen if normal writeback just happens to find dirty folios
> -	 * that were created as part of uncached writeback, and that writeback
> -	 * would otherwise not need non-IRQ handling. Just skip the
> -	 * invalidation in that case.
> +	 * Hitting !in_task() can happen for IO completed from IRQ contexts or
> +	 * if normal writeback just happens to find dirty folios that were
> +	 * created as part of uncached writeback, and that writeback would
> +	 * otherwise not need non-IRQ handling.
>  	 */
>  	if (in_task() && folio_trylock(folio)) {
>  		filemap_end_dropbehind(folio);
>  		folio_unlock(folio);
> +		return;
>  	}
> +
> +	/*
> +	 * In IRQ context we cannot lock the folio or call into the
> +	 * invalidation path. Defer to a workqueue. This happens for
> +	 * buffer_head-based writeback which runs from bio IRQ context.
> +	 */
> +	if (!in_task())
> +		folio_end_dropbehind_irq(folio);
>  }

Ideally we'd have the caller be responsible for this, rather than put it
inside folio_end_dropbehind().

-- 
Jens Axboe

