Return-Path: <linux-fsdevel+bounces-12930-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F03868C4A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 10:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6EBAB28735
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 09:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95819136997;
	Tue, 27 Feb 2024 09:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0+Xj01Kk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="a5suGYZ0";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0+Xj01Kk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="a5suGYZ0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC49A13666C;
	Tue, 27 Feb 2024 09:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709026226; cv=none; b=drXh6wcpussbbufYADZA/iRclTTL582kwyj54XwIrb+HGF1X7co2qACs1Ol/PLYU4O33F6KhRHrMV/EjAKSx93JUiNlBjGINV2uEl21JUvlWWDORW9+PZs6GpBTXOepLvSik6Dprz7mJ9tWKBEQn6aGkvmjlSSvNUWC6q5/bUeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709026226; c=relaxed/simple;
	bh=V8bBaiplfc/wVHe6wlfGo3JD6VOdJZwSExMn/u7zeBA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lJ+U0v/ydk0CPSIrlTHKn0xrLx7LZnNN83Tut8NEJ8QN5Bl4anATE3EzLdjGiN7Pu23TDDstUJZG+lhtCqEi6liVtRMSFHX40Tn+JMn8IuzzN/B+mZ4KCUck6NPvvhBJo/owIS7vvMEssNEgCSmARSOsJ8fuVgWKXoBhU0JClb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0+Xj01Kk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=a5suGYZ0; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0+Xj01Kk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=a5suGYZ0; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0888121F39;
	Tue, 27 Feb 2024 09:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709026222; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2tfyNx8Ewzx9RhyM+EFV+xT647ehMQIa9lFPRNlyECQ=;
	b=0+Xj01KkKvhGJdcjtMAWzvJi7m2CYOxjq5YrvrR72FrAbBnNksgWTG3mO/sjQJxliG0g07
	y5XsdIYk5XIw4V9w/uFGbV+ho5g2Z79tZZHX9Z5MisAFZaNbg0ho00u47ApDjRWrG0I7x9
	LSiAQEtP8rShQ5r3WMB7RTCprO6zAnM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709026222;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2tfyNx8Ewzx9RhyM+EFV+xT647ehMQIa9lFPRNlyECQ=;
	b=a5suGYZ0cgpf5Gj/Tn3aV8oNvMw4mA2P70HXJT8NNRif7MsKFvRRBqOmJe+FSffjbyvyAG
	BTUMPoP/9cEiW9CQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709026222; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2tfyNx8Ewzx9RhyM+EFV+xT647ehMQIa9lFPRNlyECQ=;
	b=0+Xj01KkKvhGJdcjtMAWzvJi7m2CYOxjq5YrvrR72FrAbBnNksgWTG3mO/sjQJxliG0g07
	y5XsdIYk5XIw4V9w/uFGbV+ho5g2Z79tZZHX9Z5MisAFZaNbg0ho00u47ApDjRWrG0I7x9
	LSiAQEtP8rShQ5r3WMB7RTCprO6zAnM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709026222;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2tfyNx8Ewzx9RhyM+EFV+xT647ehMQIa9lFPRNlyECQ=;
	b=a5suGYZ0cgpf5Gj/Tn3aV8oNvMw4mA2P70HXJT8NNRif7MsKFvRRBqOmJe+FSffjbyvyAG
	BTUMPoP/9cEiW9CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B04E513A58;
	Tue, 27 Feb 2024 09:30:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QuGyKq2r3WW8cgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 27 Feb 2024 09:30:21 +0000
Message-ID: <72cc5f0b-90cc-48a8-a026-412fa1186acd@suse.cz>
Date: Tue, 27 Feb 2024 10:30:53 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 15/36] lib: introduce support for page allocation
 tagging
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
 <20240221194052.927623-16-surenb@google.com>
 <d6141a99-3409-447b-88ac-16c24b0a892e@suse.cz>
 <CAJuCfpGZ6W-vjby=hWd5F3BOCLjdeda2iQx_Tz-HcyjCAsmKVg@mail.gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <CAJuCfpGZ6W-vjby=hWd5F3BOCLjdeda2iQx_Tz-HcyjCAsmKVg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [1.39 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BAYES_HAM(-0.02)[52.97%];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_MATCH_ENVRCPT_SOME(0.00)[];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_GT_50(0.00)[74];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[linux-foundation.org,linux.dev,suse.com,cmpxchg.org,suse.de,stgolabs.net,infradead.org,oracle.com,i-love.sakura.ne.jp,lwn.net,manifault.com,redhat.com,arm.com,kernel.org,arndb.de,linutronix.de,linux.intel.com,kernel.dk,soleen.com,google.com,gmail.com,chromium.org,linuxfoundation.org,linaro.org,goodmis.org,linux.com,lge.com,bytedance.com,akamai.com,android.com,vger.kernel.org,lists.linux.dev,kvack.org,googlegroups.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Level: *
X-Spam-Score: 1.39
X-Spam-Flag: NO



On 2/26/24 18:11, Suren Baghdasaryan wrote:
> On Mon, Feb 26, 2024 at 9:07 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>>
>> On 2/21/24 20:40, Suren Baghdasaryan wrote:
>>> Introduce helper functions to easily instrument page allocators by
>>> storing a pointer to the allocation tag associated with the code that
>>> allocated the page in a page_ext field.
>>>
>>> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>>> Co-developed-by: Kent Overstreet <kent.overstreet@linux.dev>
>>> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
>>
>> The static key usage seems fine now. Even if the page_ext overhead is still
>> always paid when compiled in, you mention in the cover letter there's a plan
>> for boot-time toggle later, so
> 
> Yes, I already have a simple patch for that to be included in the next
> revision: https://github.com/torvalds/linux/commit/7ca367e80232345f471b77b3ea71cf82faf50954

This opt-out logic would require a distro kernel with allocation
profiling compiled-in to ship together with something that modifies
kernel command line to disable it by default, so it's not very
practical. Could the CONFIG_MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT be
turned into having 3 possible choices, where one of them would
initialize mem_profiling_enabled to false?

Or, taking a step back, is it going to be a common usecase to pay the
memory overhead unconditionally, but only enable the profiling later
during runtime? Also what happens if someone would enable and disable it
multiple times during one boot? Would the statistics get all skewed
because some frees would be not accounted while it's disabled?

>>
>> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> 
> Thanks!
> 
>>
>>

