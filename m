Return-Path: <linux-fsdevel+bounces-54365-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 917C1AFED19
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 17:07:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92D341894C73
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 15:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8963156F4A;
	Wed,  9 Jul 2025 15:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HL0FVgbS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="578NOeXT";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HL0FVgbS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="578NOeXT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687501D54F7
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Jul 2025 15:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752073416; cv=none; b=tS6YJY+kz1xmswhEc1AtMpWkhInLoyeqlPwl2C3+kxCVybd2WbFpb6YQQ60FZctXvAW8476mvfZ6uEOQdY+kDecLxqfQPkt6N6cBMAYNhb6NiYbwg6z5xhnETzOssaWZa59N/Uy5xSYsNxaOlAJMBl0dnSCEsYUQpC2ohL7SZRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752073416; c=relaxed/simple;
	bh=MBBQf/0UghRo70up+nIV6zw+wi9JwWF4GdvQF4Y2E8k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WZqvjoD1LyOnkOc7DSyvWg+Qnp1p6kWRcZhIkQQdmIAZ704P7QRvzDrXZrgsxEuhzxVZCnqWS7jcs1/ubaFtp9VK2CNvgCCBdZO8tFmYvjbbz9kWWNiD7UhIdg/1oq7FGpW5FwGus+nKb08H3KxO+RAd9HvDcG0nnU8y0i+X1t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HL0FVgbS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=578NOeXT; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HL0FVgbS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=578NOeXT; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AF5BF1F443;
	Wed,  9 Jul 2025 15:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1752073412; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=urLwYX9yvt4SUAQ+O+nSg2SIj8MHrRTMuAlo1NhWJiU=;
	b=HL0FVgbSYbNO8jlYCbs/AWaCts/mvGVtwsheY1mk37h2AXo89vRwvnSv6trFk54zSTY4h0
	R2bWZZasuYnBBXWeNT2UCAX/EXPhAJCI1BeyFha00bPyKElPJHjSKjxuMQCcvpoUph0pdT
	y2sRfDSih1+3hfw5IgIoL3CxOq267M0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1752073412;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=urLwYX9yvt4SUAQ+O+nSg2SIj8MHrRTMuAlo1NhWJiU=;
	b=578NOeXTln/4XCzqn7cWjzHlAlxbqgbTdDKFnIQt8l4+rKfG8YzC2HiepRF2Hgjnj8vQd7
	K8NdlF6aW1h+GaCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1752073412; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=urLwYX9yvt4SUAQ+O+nSg2SIj8MHrRTMuAlo1NhWJiU=;
	b=HL0FVgbSYbNO8jlYCbs/AWaCts/mvGVtwsheY1mk37h2AXo89vRwvnSv6trFk54zSTY4h0
	R2bWZZasuYnBBXWeNT2UCAX/EXPhAJCI1BeyFha00bPyKElPJHjSKjxuMQCcvpoUph0pdT
	y2sRfDSih1+3hfw5IgIoL3CxOq267M0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1752073412;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=urLwYX9yvt4SUAQ+O+nSg2SIj8MHrRTMuAlo1NhWJiU=;
	b=578NOeXTln/4XCzqn7cWjzHlAlxbqgbTdDKFnIQt8l4+rKfG8YzC2HiepRF2Hgjnj8vQd7
	K8NdlF6aW1h+GaCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 81B3D13757;
	Wed,  9 Jul 2025 15:03:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eMzSHsSEbmjFegAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 09 Jul 2025 15:03:32 +0000
Message-ID: <3b3521f6-30c8-419e-9615-9228f539251e@suse.cz>
Date: Wed, 9 Jul 2025 17:03:32 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 7/8] fs/proc/task_mmu: read proc/pid/maps under per-vma
 lock
Content-Language: en-US
To: Suren Baghdasaryan <surenb@google.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, akpm@linux-foundation.org,
 Liam.Howlett@oracle.com, david@redhat.com, peterx@redhat.com,
 jannh@google.com, hannes@cmpxchg.org, mhocko@kernel.org, paulmck@kernel.org,
 shuah@kernel.org, adobriyan@gmail.com, brauner@kernel.org,
 josef@toxicpanda.com, yebin10@huawei.com, linux@weissschuh.net,
 willy@infradead.org, osalvador@suse.de, andrii@kernel.org,
 ryan.roberts@arm.com, christophe.leroy@csgroup.eu, tjmercier@google.com,
 kaleshsingh@google.com, aha310510@gmail.com, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org
References: <20250704060727.724817-1-surenb@google.com>
 <20250704060727.724817-8-surenb@google.com>
 <f532558b-b19a-40ea-b594-94d1ba92188d@lucifer.local>
 <CAJuCfpGegZkgmnGd_kAsR8Wh5SRv_gtDxKbfHdjpG491u5U5fA@mail.gmail.com>
 <f60a932f-71c0-448f-9434-547caa630b72@suse.cz>
 <CAJuCfpE2H9-kRz6xSC43Ja0dmW+drcJa29hwQwQ53HRsuqRnwg@mail.gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <CAJuCfpE2H9-kRz6xSC43Ja0dmW+drcJa29hwQwQ53HRsuqRnwg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,linux-foundation.org,redhat.com,google.com,cmpxchg.org,kernel.org,gmail.com,toxicpanda.com,huawei.com,weissschuh.net,infradead.org,suse.de,arm.com,csgroup.eu,vger.kernel.org,kvack.org];
	R_RATELIMIT(0.00)[to_ip_from(RLqwhhqik4qyk5i1fk54co8f1o)];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid,suse.cz:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -4.30

On 7/9/25 16:43, Suren Baghdasaryan wrote:
> On Wed, Jul 9, 2025 at 1:57 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>>
>> On 7/8/25 01:10, Suren Baghdasaryan wrote:
>> >>> +     rcu_read_unlock();
>> >>> +     vma = lock_vma_under_mmap_lock(mm, iter, address);
>> >>> +     rcu_read_lock();
>> >> OK I guess we hold the RCU lock the whole time as we traverse except when
>> >> we lock under mmap lock.
>> > Correct.
>>
>> I wonder if it's really necessary? Can't it be done just inside
>> lock_next_vma()? It would also avoid the unlock/lock dance quoted above.
>>
>> Even if we later manage to extend this approach to smaps and employ rcu
>> locking to traverse the page tables, I'd think it's best to separate and
>> fine-grain the rcu lock usage for vma iterator and page tables, if only to
>> avoid too long time under the lock.
> 
> I thought we would need to be in the same rcu read section while
> traversing the maple tree using vma_next() but now looking at it,
> maybe we can indeed enter only while finding and locking the next
> vma...
> Liam, would that work? I see struct ma_state containing a node field.
> Can it be freed from under us if we find a vma, exit rcu read section
> then re-enter rcu and use the same iterator to find the next vma?

If the rcu protection needs to be contigous, and patch 8 avoids the issue by
always doing vma_iter_init() after rcu_read_lock() (but does it really avoid
the issue or is it why we see the syzbot reports?) then I guess in the code
quoted above we also need a vma_iter_init() after the rcu_read_lock(),
because although the iterator was used briefly under mmap_lock protection,
that was then unlocked and there can be a race before the rcu_read_lock().

