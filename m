Return-Path: <linux-fsdevel+bounces-45504-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D205FA78B07
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 11:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 322AC16FC00
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 09:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B7E2356CB;
	Wed,  2 Apr 2025 09:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wsoYIm1U";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6/KP1Z87";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wsoYIm1U";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6/KP1Z87"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2351E8837
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Apr 2025 09:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743585916; cv=none; b=DHLzrnsPYYkFCEP2+yJcnaBtbh2l5MeI05tHkZHC8s16P6JhydyJ0C4YQPd1UhKWvbGyU5H+iZW11iGX+ytCvusa31SnozBf+L/ma26fsIbfD6ZtJJg/lN5qA0diVmdMWKrBlivZt7Y+JVlUfSNtY0I/StFGv9ZvL1/jH2XOjXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743585916; c=relaxed/simple;
	bh=Rve0IvPLk0BRdXpxQCvtdDyaPRRzdWnFF4R/OcnMi18=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rVCoa6VoPAUp1brVjgiJb/Gyz5aGYmTG6lDZvOupBZQngZbt05+w9NFYhL+LHJk2S2Z71qT1F+EEtBhsvCLfxOT1ZXhyr+gmAvKpKXbxdAoVi5krOWSGHAtiMMfWx/3iiNAI/LK9UKaopT3SUS3Wn6ZV8HH2pclfQrZPcyJJKZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wsoYIm1U; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6/KP1Z87; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wsoYIm1U; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6/KP1Z87; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 965D02116E;
	Wed,  2 Apr 2025 09:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743585912; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FKPVfWE/EtWkBYJnIZW8Og7SyLNPhkZ6aWrFs7Q5i6Y=;
	b=wsoYIm1UbJrwwC6eaFG/G+XndD/MWydcnJHzOHdAOImtLMaYhUKBCB75CjOFrL9M/nk+LJ
	RKPF0ZUqEu3yqe38HREw4E+tuR0TEryAfW2FiBhmjLa0hesfB0MFYZPQSE7e0cz+R9Gx3A
	qbIk+1U79HREdoA+slI89DooRBmDdfQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743585912;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FKPVfWE/EtWkBYJnIZW8Og7SyLNPhkZ6aWrFs7Q5i6Y=;
	b=6/KP1Z87z+VdtNhc9UA31z/z0XkptMc87l33l5UWKkCBLa5pDN3zoD01mlF23DMmnX/AMr
	SFdZWKhcpACcPKCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743585912; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FKPVfWE/EtWkBYJnIZW8Og7SyLNPhkZ6aWrFs7Q5i6Y=;
	b=wsoYIm1UbJrwwC6eaFG/G+XndD/MWydcnJHzOHdAOImtLMaYhUKBCB75CjOFrL9M/nk+LJ
	RKPF0ZUqEu3yqe38HREw4E+tuR0TEryAfW2FiBhmjLa0hesfB0MFYZPQSE7e0cz+R9Gx3A
	qbIk+1U79HREdoA+slI89DooRBmDdfQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743585912;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FKPVfWE/EtWkBYJnIZW8Og7SyLNPhkZ6aWrFs7Q5i6Y=;
	b=6/KP1Z87z+VdtNhc9UA31z/z0XkptMc87l33l5UWKkCBLa5pDN3zoD01mlF23DMmnX/AMr
	SFdZWKhcpACcPKCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7B3DE13A4B;
	Wed,  2 Apr 2025 09:25:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DYTJHXgC7WfLQwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 02 Apr 2025 09:25:12 +0000
Message-ID: <c6823186-9267-418c-a676-390be9d4524d@suse.cz>
Date: Wed, 2 Apr 2025 11:25:12 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] proc: Avoid costly high-order page allocations when
 reading proc files
Content-Language: en-US
To: Yafang Shao <laoar.shao@gmail.com>, Harry Yoo <harry.yoo@oracle.com>
Cc: Kees Cook <kees@kernel.org>, joel.granados@kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Josef Bacik <josef@toxicpanda.com>, linux-mm@kvack.org,
 Michal Hocko <mhocko@kernel.org>
References: <20250401073046.51121-1-laoar.shao@gmail.com>
 <3315D21B-0772-4312-BCFB-402F408B0EF6@kernel.org> <Z-y50vEs_9MbjQhi@harry>
 <CALOAHbBSvMuZnKF_vy3kGGNOCg5N2CgomLhxMxjn8RNwMTrw7A@mail.gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <CALOAHbBSvMuZnKF_vy3kGGNOCg5N2CgomLhxMxjn8RNwMTrw7A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_TO(0.00)[gmail.com,oracle.com];
	ARC_NA(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid]
X-Spam-Score: -2.80
X-Spam-Flag: NO

On 4/2/25 10:42, Yafang Shao wrote:
> On Wed, Apr 2, 2025 at 12:15 PM Harry Yoo <harry.yoo@oracle.com> wrote:
>>
>> On Tue, Apr 01, 2025 at 07:01:04AM -0700, Kees Cook wrote:
>> >
>> >
>> > On April 1, 2025 12:30:46 AM PDT, Yafang Shao <laoar.shao@gmail.com> wrote:
>> > >While investigating a kcompactd 100% CPU utilization issue in production, I
>> > >observed frequent costly high-order (order-6) page allocations triggered by
>> > >proc file reads from monitoring tools. This can be reproduced with a simple
>> > >test case:
>> > >
>> > >  fd = open(PROC_FILE, O_RDONLY);
>> > >  size = read(fd, buff, 256KB);
>> > >  close(fd);
>> > >
>> > >Although we should modify the monitoring tools to use smaller buffer sizes,
>> > >we should also enhance the kernel to prevent these expensive high-order
>> > >allocations.
>> > >
>> > >Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
>> > >Cc: Josef Bacik <josef@toxicpanda.com>
>> > >---
>> > > fs/proc/proc_sysctl.c | 10 +++++++++-
>> > > 1 file changed, 9 insertions(+), 1 deletion(-)
>> > >
>> > >diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
>> > >index cc9d74a06ff0..c53ba733bda5 100644
>> > >--- a/fs/proc/proc_sysctl.c
>> > >+++ b/fs/proc/proc_sysctl.c
>> > >@@ -581,7 +581,15 @@ static ssize_t proc_sys_call_handler(struct kiocb *iocb, struct iov_iter *iter,
>> > >     error = -ENOMEM;
>> > >     if (count >= KMALLOC_MAX_SIZE)
>> > >             goto out;
>> > >-    kbuf = kvzalloc(count + 1, GFP_KERNEL);
>> > >+
>> > >+    /*
>> > >+     * Use vmalloc if the count is too large to avoid costly high-order page
>> > >+     * allocations.
>> > >+     */
>> > >+    if (count < (PAGE_SIZE << PAGE_ALLOC_COSTLY_ORDER))
>> > >+            kbuf = kvzalloc(count + 1, GFP_KERNEL);
>> >
>> > Why not move this check into kvmalloc family?
>>
>> Hmm should this check really be in kvmalloc family?
> 
> Modifying the existing kvmalloc functions risks performance regressions.
> Could we instead introduce a new variant like vkmalloc() (favoring
> vmalloc over kmalloc) or kvmalloc_costless()?

We have gfp flags and kmalloc_gfp_adjust() to moderate how aggressive
kmalloc() is before the vmalloc() fallback. It does e.g.:

                if (!(flags & __GFP_RETRY_MAYFAIL))
                        flags |= __GFP_NORETRY;

However if your problem is kcompactd utilization then the kmalloc() attempt
would have to avoid ___GFP_KSWAPD_RECLAIM to avoid waking up kswapd and then
kcompactd. Should we remove the flag for costly orders? Dunno. Ideally the
deferred compaction mechanism would limit the issue in the first place.

The ad-hoc fixing up of a particular place (/proc files reading) or creating
a new vkmalloc() and then spreading its use as you see other places
triggering the issue seems quite suboptimal to me.

>>
>> I don't think users would expect kvmalloc() to implictly decide on using
>> vmalloc() without trying kmalloc() first, just because it's a high-order
>> allocation.
>>
> 


