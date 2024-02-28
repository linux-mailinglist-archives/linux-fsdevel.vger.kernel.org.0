Return-Path: <linux-fsdevel+bounces-13121-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD09986B729
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 19:28:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22FFDB24056
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 18:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41AA71EAB;
	Wed, 28 Feb 2024 18:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZPxRODIg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kXqEJKXA";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lzwTXBmR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="K7/pGILz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5954240860;
	Wed, 28 Feb 2024 18:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709144890; cv=none; b=uoXaLAX1+RLeE2bCpKbr4NGmWHGURiYoUqXN4GHSjBc6GXKF0fX66ZBELelXMgnRfHrWVfqZx/4ZwAXX1rwj5tYvtNDNSV31GuyvvKlujig5lzuIGMJUwrKQrWKCWxlwMsiY57YCv2QooLoDXUhkiVQY5VpznNlmsTNr8o07RDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709144890; c=relaxed/simple;
	bh=R9QZp/YdeKna3hadnR/VgwsmE0VqRkxvcGnU+2XOCfU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NviGkGXCcAVvHuu7GZa5NnDZcpN/fwnM3moxrP48JyDrcF/BC/BN2YeZ6kopfiokVxZEbc00AcAz33BiVqXcdODr8v9bvfXNmVUCZ0YsP4adLEtlMFTvEOzRnkef5qfJtiImjaEXFUq7JUNAAtadU8644h2egWgNVCg9q/HAPNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZPxRODIg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kXqEJKXA; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lzwTXBmR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=K7/pGILz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 964A71F83E;
	Wed, 28 Feb 2024 18:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709144886; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u5+mCXb2oxOlDfsxFtS236UJWrVmUWVW4KbIf8DfAn4=;
	b=ZPxRODIgJuBC/kk3bKWl/fqC1Sfyudk0vGJJkm74L2ILUYXVZDYFKC7QLCbG8BoZfFfnuO
	2F5Y9sWwEkEx5uGUYjaoCqwl/ENpnPeD10I3Om2S5Cun7+hfdohyNZ6fIr5VMivmAvOzWw
	iiVeA6/W1sayC/DjSc1YVcFCA2hPS64=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709144886;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u5+mCXb2oxOlDfsxFtS236UJWrVmUWVW4KbIf8DfAn4=;
	b=kXqEJKXAtS54C2U4OLK3xcLGEe0opZ/tDK7QnBXntatpViLNLLzG938b4EGqOLURbeGaND
	/oRSC6c82o94pPDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709144884; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u5+mCXb2oxOlDfsxFtS236UJWrVmUWVW4KbIf8DfAn4=;
	b=lzwTXBmRXkxN7gO7SJLCYCtmmofqbF1HrCjq5bznG+IgfvcAWdRTeZ3EhUd3U5GqxBzYJf
	Kg7uOFCn3GbKV1pFoGR7rDwj027aADKyrD34Ivv+yi++YDMuQBnVPxJGtUl08OAVrvwVKd
	DdjyLH60n1iN1umSCH9NlibdRc2WAns=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709144884;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u5+mCXb2oxOlDfsxFtS236UJWrVmUWVW4KbIf8DfAn4=;
	b=K7/pGILzfHFsjg6IJPzTgMwsz1KP2WTfZMzbOuLg7OGmntvIBW9iQPiorJV3J4dAp4BNrI
	2rbvzZOpwfnNiRCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EFC7513A58;
	Wed, 28 Feb 2024 18:28:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id i+05OjN732V+LAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 28 Feb 2024 18:28:03 +0000
Message-ID: <f494b8e5-f1ca-4b95-a8aa-01b9c4395523@suse.cz>
Date: Wed, 28 Feb 2024 19:28:03 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 19/36] mm: create new codetag references during page
 splitting
Content-Language: en-US
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, mhocko@suse.com,
 hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de,
 dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
 penguin-kernel@i-love.sakura.ne.jp, corbet@lwn.net, void@manifault.com,
 peterz@infradead.org, juri.lelli@redhat.com, catalin.marinas@arm.com,
 will@kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com,
 dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com,
 david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org,
 nathan@kernel.org, dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev,
 rppt@kernel.org, paulmck@kernel.org, pasha.tatashin@soleen.com,
 yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com,
 hughd@google.com, andreyknvl@gmail.com, keescook@chromium.org,
 ndesaulniers@google.com, vvvvvv@google.com, gregkh@linuxfoundation.org,
 ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 bristot@redhat.com, vschneid@redhat.com, cl@linux.com, penberg@kernel.org,
 iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com,
 elver@google.com, dvyukov@google.com, shakeelb@google.com,
 songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com,
 minchan@google.com, kaleshsingh@google.com, kernel-team@android.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, linux-arch@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-modules@vger.kernel.org, kasan-dev@googlegroups.com,
 cgroups@vger.kernel.org
References: <20240221194052.927623-1-surenb@google.com>
 <20240221194052.927623-20-surenb@google.com>
 <2daf5f5a-401a-4ef7-8193-6dca4c064ea0@suse.cz>
 <CAJuCfpGt+zfFzfLSXEjeTo79gw2Be-UWBcJq=eL1qAnPf9PaiA@mail.gmail.com>
 <6db0f0c8-81cb-4d04-9560-ba73d63db4b8@suse.cz>
 <CAJuCfpEgh1OiYNE_uKG-BqW2x97sOL9+AaTX4Jct3=WHzAv+kg@mail.gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <CAJuCfpEgh1OiYNE_uKG-BqW2x97sOL9+AaTX4Jct3=WHzAv+kg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: 0.07
X-Spamd-Result: default: False [0.07 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 BAYES_HAM(-0.14)[68.46%];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_MATCH_ENVRCPT_SOME(0.00)[];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_GT_50(0.00)[74];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[linux-foundation.org,linux.dev,suse.com,cmpxchg.org,suse.de,stgolabs.net,infradead.org,oracle.com,i-love.sakura.ne.jp,lwn.net,manifault.com,redhat.com,arm.com,kernel.org,arndb.de,linutronix.de,linux.intel.com,kernel.dk,soleen.com,google.com,gmail.com,chromium.org,linuxfoundation.org,linaro.org,goodmis.org,linux.com,lge.com,bytedance.com,akamai.com,android.com,vger.kernel.org,lists.linux.dev,kvack.org,googlegroups.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Flag: NO

On 2/28/24 18:50, Suren Baghdasaryan wrote:
> On Wed, Feb 28, 2024 at 12:47 AM Vlastimil Babka <vbabka@suse.cz> wrote:
> 
>>
>> Now this might be rare enough that it's not worth fixing if that would be
>> too complicated, just FYI.
> 
> Yeah. We can fix this by subtracting the "bytes" counter of the "head"
> page for all free_the_page(page + (1 << order), order) calls we do
> inside __free_pages(). But we can't simply use pgalloc_tag_sub()
> because the "calls" counter will get over-decremented (we allocated
> all of these pages with one call). I'll need to introduce a new
> pgalloc_tag_sub_bytes() API and use it here. I feel it's too targeted
> of a solution but OTOH this is a special situation, so maybe it's
> acceptable. WDYT?

Hmm I think there's a problem that once you fail put_page_testzero() and
detect you need to do this, the page might be already gone or reallocated so
you can't get to the tag for decrementing bytes. You'd have to get it
upfront (I guess for "head && order > 0" cases) just in case it happens.
Maybe it's not worth the trouble for such a rare case.

>>
>>
>> > Every time
>> > one of these pages are freed that codetag's "bytes" and "calls"
>> > counters will be decremented. I think accounting will work correctly
>> > irrespective of where these pages are freed, in __free_pages() or by
>> > put_page().
>> >
>>


