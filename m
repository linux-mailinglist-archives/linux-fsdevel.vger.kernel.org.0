Return-Path: <linux-fsdevel+bounces-12172-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6343585C39D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 19:27:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18D58284EE2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 18:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 226B182888;
	Tue, 20 Feb 2024 18:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IxxD5z05";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="EGjwc1aS";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IxxD5z05";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="EGjwc1aS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8380C81AC4;
	Tue, 20 Feb 2024 18:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708453651; cv=none; b=LDRdB0B3i8xrtyVkyNVlvEs+iRzmf6v9cN37UpfoNXLBenlWccRcfCyW3apiGLaWOX8V/XO9ZkZgZzCNcXLI3wsPoyKTPQxqye/QGUERNt05IayJuno4g312xOXsEacfKM/ht5uunK12g1CL1L+9UQoKMHV8i7s3s5HIiiS8uXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708453651; c=relaxed/simple;
	bh=OJkratr22VFfCbpm7Y4TEVF5H+VxTfzYWK8qM7R7Bmw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RF3v84y5WsS4nTojCsEIxsCHX6PTybJZ28PzSx15RVjv+bQNOR9tE8RsihATFPdM+OUo14AsKyMgGnLMSHyluU9yAxkbYsZV6889YwNc0Lw4lzSa7wgjNBGsjuwDyJGSCWrZVK+a4CFVREXjL4oL+wciFp+MZcEhm6ISLNOPWcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=IxxD5z05; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=EGjwc1aS; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=IxxD5z05; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=EGjwc1aS; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 279D421FDD;
	Tue, 20 Feb 2024 18:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708453647; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZilpvBzNJyAotgmhs4yPhtveHoML0rb6UBsNzTh2fy0=;
	b=IxxD5z05As9iwNt64pXwo9uMrmiMPOx8LkjV0Fqt9JDJTqgYJsDWFpdeeOZ6naB/Yats4r
	j/dPrszvU95YLT0h9IkQS+uuBZiA3xuxqNBxE9MX7vilfRnf/estNQhT+NL6Sn4IguNupc
	ro8ag87CYBCPjZh9LLlOn3yXWmPIcRU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708453647;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZilpvBzNJyAotgmhs4yPhtveHoML0rb6UBsNzTh2fy0=;
	b=EGjwc1aSk9FAHIhSFQeC/OSVGYAmMzA+6CUGwcOr3GWEprXkm1AzuTEWFhTlt3mVD0WADw
	zit1C1mKEB3w86Dw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708453647; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZilpvBzNJyAotgmhs4yPhtveHoML0rb6UBsNzTh2fy0=;
	b=IxxD5z05As9iwNt64pXwo9uMrmiMPOx8LkjV0Fqt9JDJTqgYJsDWFpdeeOZ6naB/Yats4r
	j/dPrszvU95YLT0h9IkQS+uuBZiA3xuxqNBxE9MX7vilfRnf/estNQhT+NL6Sn4IguNupc
	ro8ag87CYBCPjZh9LLlOn3yXWmPIcRU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708453647;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZilpvBzNJyAotgmhs4yPhtveHoML0rb6UBsNzTh2fy0=;
	b=EGjwc1aSk9FAHIhSFQeC/OSVGYAmMzA+6CUGwcOr3GWEprXkm1AzuTEWFhTlt3mVD0WADw
	zit1C1mKEB3w86Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 895C6139D0;
	Tue, 20 Feb 2024 18:27:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zQTVIA7v1GUGcgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 20 Feb 2024 18:27:26 +0000
Message-ID: <e017b7bc-d747-46e6-a89d-4ce558ed79b0@suse.cz>
Date: Tue, 20 Feb 2024 19:27:26 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 31/35] lib: add memory allocations report in show_mem()
Content-Language: en-US
To: Suren Baghdasaryan <surenb@google.com>,
 Kent Overstreet <kent.overstreet@linux.dev>
Cc: Steven Rostedt <rostedt@goodmis.org>, Michal Hocko <mhocko@suse.com>,
 akpm@linux-foundation.org, hannes@cmpxchg.org, roman.gushchin@linux.dev,
 mgorman@suse.de, dave@stgolabs.net, willy@infradead.org,
 liam.howlett@oracle.com, corbet@lwn.net, void@manifault.com,
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
 dietmar.eggemann@arm.com, bsegall@google.com, bristot@redhat.com,
 vschneid@redhat.com, cl@linux.com, penberg@kernel.org,
 iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com,
 elver@google.com, dvyukov@google.com, shakeelb@google.com,
 songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com,
 minchan@google.com, kaleshsingh@google.com, kernel-team@android.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, linux-arch@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-modules@vger.kernel.org, kasan-dev@googlegroups.com,
 cgroups@vger.kernel.org, Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
References: <Zc3X8XlnrZmh2mgN@tiehlicka>
 <CAJuCfpHc2ee_V6SGAc_31O_ikjGGNivhdSG+2XNcc9vVmzO-9g@mail.gmail.com>
 <Zc4_i_ED6qjGDmhR@tiehlicka>
 <CAJuCfpHq3N0h6dGieHxD6Au+qs=iKAifFrHAMxTsHTcDrOwSQA@mail.gmail.com>
 <ruxvgrm3scv7zfjzbq22on7tj2fjouydzk33k7m2kukm2n6uuw@meusbsciwuut>
 <320cd134-b767-4f29-869b-d219793ba8a1@suse.cz>
 <efxe67vo32epvmyzplmpd344nw2wf37azicpfhvkt3zz4aujm3@n27pl5j5zahj>
 <20240215180742.34470209@gandalf.local.home>
 <20240215181648.67170ed5@gandalf.local.home>
 <20240215182729.659f3f1c@gandalf.local.home>
 <mi5zw42r6c2yfg7fr2pfhfff6hudwizybwydosmdiwsml7vqna@a5iu6ksb2ltk>
 <CAJuCfpEARb8t8pc8WVZYB=yPk6G_kYGmJTMOdgiMHaYYKW3fUA@mail.gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <CAJuCfpEARb8t8pc8WVZYB=yPk6G_kYGmJTMOdgiMHaYYKW3fUA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=IxxD5z05;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=EGjwc1aS
X-Spamd-Result: default: False [-1.80 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 MID_RHS_MATCH_FROM(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BAYES_HAM(-3.00)[100.00%];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_MATCH_ENVRCPT_SOME(0.00)[];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_GT_50(0.00)[74];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[goodmis.org,suse.com,linux-foundation.org,cmpxchg.org,linux.dev,suse.de,stgolabs.net,infradead.org,oracle.com,lwn.net,manifault.com,redhat.com,arm.com,kernel.org,arndb.de,linutronix.de,linux.intel.com,kernel.dk,soleen.com,google.com,gmail.com,chromium.org,linuxfoundation.org,linaro.org,linux.com,lge.com,bytedance.com,akamai.com,android.com,vger.kernel.org,lists.linux.dev,kvack.org,googlegroups.com,I-love.SAKURA.ne.jp];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 279D421FDD
X-Spam-Level: 
X-Spam-Score: -1.80
X-Spam-Flag: NO

On 2/19/24 18:17, Suren Baghdasaryan wrote:
> On Thu, Feb 15, 2024 at 3:56 PM Kent Overstreet
> <kent.overstreet@linux.dev> wrote:
>>
>> On Thu, Feb 15, 2024 at 06:27:29PM -0500, Steven Rostedt wrote:
>> > All this, and we are still worried about 4k for useful debugging :-/
> 
> I was planning to refactor this function to print one record at a time
> with a smaller buffer but after discussing with Kent, he has plans to
> reuse this function and having the report in one buffer is needed for
> that.

We are printing to console, AFAICS all the code involved uses plain printk()
I think it would be way easier to have a function using printk() for this
use case than the seq_buf which is more suitable for /proc and friends. Then
all concerns about buffers would be gone. It wouldn't be that much of a code
duplication?

>> Every additional 4k still needs justification. And whether we burn a
>> reserve on this will have no observable effect on user output in
>> remotely normal situations; if this allocation ever fails, we've already
>> been in an OOM situation for awhile and we've already printed out this
>> report many times, with less memory pressure where the allocation would
>> have succeeded.
> 
> I'm not sure this claim will always be true, specifically in the case
> of low-end devices with relatively low amounts of reserves and in the

That's right, GFP_ATOMIC failures can easily happen without prior OOMs.
Consider a system where userspace allocations fill the memory as they
usually do, up to high watermark. Then a burst of packets is received and
handled by GFP_ATOMIC allocations that deplete the reserves and can't cause
OOMs (OOM is when we fail to reclaim anything, but we are allocating from a
context that can't reclaim), so the very first report would be an GFP_ATOMIC
failure and now it can't allocate that buffer for printing.

I'm sure more such scenarios exist, Cc: Tetsuo who I recall was an expert on
this topic.

> presence of a possible quick memory usage spike. We should also
> consider a case when panic_on_oom is set. All we get is one OOM
> report, so we get only one chance to capture this report. In any case,
> I don't yet have data to prove or disprove this claim but it will be
> interesting to test it with data from the field once the feature is
> deployed.
> 
> For now I think with Vlastimil's __GFP_NOWARN suggestion the code
> becomes safe and the only risk is to lose this report. If we get cases
> with reports missing this data, we can easily change to reserved
> memory.


