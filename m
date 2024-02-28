Return-Path: <linux-fsdevel+bounces-13054-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A81A86AA5E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 09:47:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5300283188
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 08:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DAE82D61B;
	Wed, 28 Feb 2024 08:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="s6ogdVMW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="A7eYUasH";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="s6ogdVMW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="A7eYUasH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07E21DDD1;
	Wed, 28 Feb 2024 08:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709110041; cv=none; b=FnUZpD5nTKiG9gucLqLpYaE1pbc8eoT+UOar7ntveeV8EcHGwoelPREAg+d878/NqKMFJ2lTSuk6evrAIOw4SL1rWMuIkEKAQ+0LagK4J6ViMfaGQMvrcHwB4f2qgWM57AeLYT/kqSo6gWpTOMnJMgep3Uk6mGoOs6P3wuGoveU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709110041; c=relaxed/simple;
	bh=da7fKvfglkLdtpNErLBCbJjKSB2vf0y1Y/4zsoOTLBk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C6wk/hLLLFXv9+S5ZZiY112tzk6ztmeF75KAyQHzipytoFmz2qVmPPpBMhn/NkL2fmRYyzFOt9JM8HDgOaiOsB4hXBTYoJfE9jygWUfvX9iF1Q/XRYYLsn0gvJIT2jzwGVLKH6HzCTo/jhaL1avPqaf3uFc3x2aQHq5AWTmL52Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=s6ogdVMW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=A7eYUasH; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=s6ogdVMW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=A7eYUasH; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0A4421F7A4;
	Wed, 28 Feb 2024 08:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709110038; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vj8SBiVnmCzYeLcoo696dWgrqk2e7VmSkmzYdiIhZIA=;
	b=s6ogdVMWJ9Yj9M6VNL5ljL6Ihfa+xkxsw6TeA+cvHUv191l4MKLQpNULNHkeB8GJ+Auu9v
	PlYnqE2eAGQFWv8MbBbeDgIXLU4P3Vp4vlAlYxXdU17cH7RDGQc5/8z8it3Ueoh+CGKfRr
	MPuPGNG5Utti2cOzW55ELkB4rw0zp6Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709110038;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vj8SBiVnmCzYeLcoo696dWgrqk2e7VmSkmzYdiIhZIA=;
	b=A7eYUasHGOqwTH88ZwnQWwVHo65JIkxjb91z9NcIz/jEEyMjS4CeV6OF9o9IbMR0a8tvDr
	fG/C/fs7C5VAitBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709110038; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vj8SBiVnmCzYeLcoo696dWgrqk2e7VmSkmzYdiIhZIA=;
	b=s6ogdVMWJ9Yj9M6VNL5ljL6Ihfa+xkxsw6TeA+cvHUv191l4MKLQpNULNHkeB8GJ+Auu9v
	PlYnqE2eAGQFWv8MbBbeDgIXLU4P3Vp4vlAlYxXdU17cH7RDGQc5/8z8it3Ueoh+CGKfRr
	MPuPGNG5Utti2cOzW55ELkB4rw0zp6Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709110038;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vj8SBiVnmCzYeLcoo696dWgrqk2e7VmSkmzYdiIhZIA=;
	b=A7eYUasHGOqwTH88ZwnQWwVHo65JIkxjb91z9NcIz/jEEyMjS4CeV6OF9o9IbMR0a8tvDr
	fG/C/fs7C5VAitBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6D9ED13AB0;
	Wed, 28 Feb 2024 08:47:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id d+w3GhXz3mXBIQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 28 Feb 2024 08:47:17 +0000
Message-ID: <6db0f0c8-81cb-4d04-9560-ba73d63db4b8@suse.cz>
Date: Wed, 28 Feb 2024 09:47:17 +0100
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
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <CAJuCfpGt+zfFzfLSXEjeTo79gw2Be-UWBcJq=eL1qAnPf9PaiA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -2.79
X-Spamd-Result: default: False [-2.79 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 BAYES_HAM(-3.00)[100.00%];
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

On 2/27/24 17:38, Suren Baghdasaryan wrote:
> On Tue, Feb 27, 2024 at 2:10 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>>
>> On 2/21/24 20:40, Suren Baghdasaryan wrote:
>> > When a high-order page is split into smaller ones, each newly split
>> > page should get its codetag. The original codetag is reused for these
>> > pages but it's recorded as 0-byte allocation because original codetag
>> > already accounts for the original high-order allocated page.
>>
>> This was v3 but then you refactored (for the better) so the commit log
>> could reflect it?
> 
> Yes, technically mechnism didn't change but I should word it better.
> Smth like this:
> 
> When a high-order page is split into smaller ones, each newly split
> page should get its codetag. After the split each split page will be
> referencing the original codetag. The codetag's "bytes" counter
> remains the same because the amount of allocated memory has not
> changed, however the "calls" counter gets increased to keep the
> counter correct when these individual pages get freed.

Great, thanks.
The concern with __free_pages() is not really related to splitting, so for
this patch:

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

> 
>>
>> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>>
>> I was going to R-b, but now I recalled the trickiness of
>> __free_pages() for non-compound pages if it loses the race to a
>> speculative reference. Will the codetag handling work fine there?
> 
> I think so. Each non-compoud page has its individual reference to its
> codetag and will decrement it whenever the page is freed. IIUC the
> logic in  __free_pages(), when it loses race to a speculative
> reference it will free all pages except for the first one and the

The "tail" pages of this non-compound high-order page will AFAICS not have
code tags assigned, so alloc_tag_sub() will be a no-op (or a warning with
_DEBUG).

> first one will be freed when the last put_page() happens. If prior to
> this all these pages were split from one page then all of them will
> have their own reference which points to the same codetag.

Yeah I'm assuming there's no split before the freeing. This patch about
splitting just reminded me of that tricky freeing scenario.

So IIUC the "else if (!head)" path of __free_pages() will do nothing about
the "tail" pages wrt code tags as there are no code tags.
Then whoever took the speculative "head" page reference will put_page() and
free it, which will end up in alloc_tag_sub(). This will decrement calls
properly, but bytes will become imbalanced, because that put_page() will
pass order-0 worth of bytes - the original order is lost.

Now this might be rare enough that it's not worth fixing if that would be
too complicated, just FYI.


> Every time
> one of these pages are freed that codetag's "bytes" and "calls"
> counters will be decremented. I think accounting will work correctly
> irrespective of where these pages are freed, in __free_pages() or by
> put_page().
> 


