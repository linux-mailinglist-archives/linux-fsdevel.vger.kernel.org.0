Return-Path: <linux-fsdevel+bounces-11533-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D6C854703
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 11:21:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E118F285EB3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 10:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB52618039;
	Wed, 14 Feb 2024 10:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DNRgpeGh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nX6r6YD0";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DNRgpeGh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nX6r6YD0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688781757A;
	Wed, 14 Feb 2024 10:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707906036; cv=none; b=L14ozIf+XSinNjn4U9I6d70eZNHJ+MUIoLYY9ROA6owPrtLtvntRbh0lwGBeA25nbzpDvu988v7ups9jNIWl83tSAWhrQguzicE/TSYHCsndF9Mqt25aKqPp/y0YzAbWiI+YCgWsXqgUhVctHha/WDXoYxHucLbtDlOOPQR9DXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707906036; c=relaxed/simple;
	bh=20sRNx8iOq0dxtbjIRX48x/rKE5QlAzFN67tIlBtgIA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QYaClOI7qoHA195u3hu1jEGH31E/gm6Zw6kepovDgvyeeLr6oF8kys7cr7QtvkRI/D3WpSf6zxN0jnco3qIQpC3pbVygO1g6f/0XDMOsMmjnzVuWhqdTafDHaNJ9JaiS3LcbAf87d74Ec4sCTrXW71PIekRKRmCJkGuihgqj4LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DNRgpeGh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nX6r6YD0; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DNRgpeGh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nX6r6YD0; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 110351FD18;
	Wed, 14 Feb 2024 10:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707906027; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FGladMXENrd0YjrbTrjIK8mVP0LFAbru1yEEbY+cSOQ=;
	b=DNRgpeGhsDI+oSKTmcp+slsJEYfRS5HYFj3TT/mD1w+ZV1MzliTWcl4XEU6bVt3xTX9gBa
	6c93XMG6n7uYcTsRNReflnsHj10orptTi2Vyl2Ll8/BiPXGvllIFrZYcU8UY4ckjh5/mYE
	ecPjl2bd/Jyci9DykfeSrzt1k/0aaCY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707906027;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FGladMXENrd0YjrbTrjIK8mVP0LFAbru1yEEbY+cSOQ=;
	b=nX6r6YD0jPrpVOJ83kIFxVBq3vl0couSpQ2UrxdMnSPIbg4NKpFIEC32DvhFQkJALEvR40
	eek/vbRuZR1rV0DQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707906027; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FGladMXENrd0YjrbTrjIK8mVP0LFAbru1yEEbY+cSOQ=;
	b=DNRgpeGhsDI+oSKTmcp+slsJEYfRS5HYFj3TT/mD1w+ZV1MzliTWcl4XEU6bVt3xTX9gBa
	6c93XMG6n7uYcTsRNReflnsHj10orptTi2Vyl2Ll8/BiPXGvllIFrZYcU8UY4ckjh5/mYE
	ecPjl2bd/Jyci9DykfeSrzt1k/0aaCY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707906027;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FGladMXENrd0YjrbTrjIK8mVP0LFAbru1yEEbY+cSOQ=;
	b=nX6r6YD0jPrpVOJ83kIFxVBq3vl0couSpQ2UrxdMnSPIbg4NKpFIEC32DvhFQkJALEvR40
	eek/vbRuZR1rV0DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7241913A72;
	Wed, 14 Feb 2024 10:20:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wRKNG+qTzGW7RwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 14 Feb 2024 10:20:26 +0000
Message-ID: <4bb7b1e4-d107-4708-bb65-ac44d4af9959@suse.cz>
Date: Wed, 14 Feb 2024 11:20:26 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/35] Memory allocation profiling
Content-Language: en-US
To: Kent Overstreet <kent.overstreet@linux.dev>,
 Suren Baghdasaryan <surenb@google.com>
Cc: David Hildenbrand <david@redhat.com>, Michal Hocko <mhocko@suse.com>,
 akpm@linux-foundation.org, hannes@cmpxchg.org, roman.gushchin@linux.dev,
 mgorman@suse.de, dave@stgolabs.net, willy@infradead.org,
 liam.howlett@oracle.com, corbet@lwn.net, void@manifault.com,
 peterz@infradead.org, juri.lelli@redhat.com, catalin.marinas@arm.com,
 will@kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com,
 dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com,
 axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, nathan@kernel.org,
 dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev, rppt@kernel.org,
 paulmck@kernel.org, pasha.tatashin@soleen.com, yosryahmed@google.com,
 yuzhao@google.com, dhowells@redhat.com, hughd@google.com,
 andreyknvl@gmail.com, keescook@chromium.org, ndesaulniers@google.com,
 vvvvvv@google.com, gregkh@linuxfoundation.org, ebiggers@google.com,
 ytcoode@gmail.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
 rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
 vschneid@redhat.com, cl@linux.com, penberg@kernel.org,
 iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com,
 elver@google.com, dvyukov@google.com, shakeelb@google.com,
 songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com,
 minchan@google.com, kaleshsingh@google.com, kernel-team@android.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, linux-arch@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-modules@vger.kernel.org, kasan-dev@googlegroups.com,
 cgroups@vger.kernel.org
References: <20240212213922.783301-1-surenb@google.com>
 <Zctfa2DvmlTYSfe8@tiehlicka>
 <CAJuCfpEsWfZnpL1vUB2C=cxRi_WxhxyvgGhUg7WdAxLEqy6oSw@mail.gmail.com>
 <9e14adec-2842-458d-8a58-af6a2d18d823@redhat.com>
 <2hphuyx2dnqsj3hnzyifp5yqn2hpgfjuhfu635dzgofr5mst27@4a5dixtcuxyi>
 <6a0f5d8b-9c67-43f6-b25e-2240171265be@redhat.com>
 <CAJuCfpEtOhzL65eMDk2W5SchcquN9hMCcbfD50a-FgtPgxh4Fw@mail.gmail.com>
 <adbb77ee-1662-4d24-bcbf-d74c29bc5083@redhat.com>
 <r6cmbcmalryodbnlkmuj2fjnausbcysmolikjguqvdwkngeztq@45lbvxjavwb3>
 <CAJuCfpF4g1jeEwHVHjQWwi5kqS-3UqjMt7GnG0Kdz5VJGyhK3Q@mail.gmail.com>
 <ea5vqiv5rt5cdbrlrdep5flej2pysqbfvxau4cjjbho64652um@7rz23kesqdup>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <ea5vqiv5rt5cdbrlrdep5flej2pysqbfvxau4cjjbho64652um@7rz23kesqdup>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=DNRgpeGh;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=nX6r6YD0
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.00 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
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
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_GT_50(0.00)[73];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,suse.cz:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FREEMAIL_CC(0.00)[redhat.com,suse.com,linux-foundation.org,cmpxchg.org,linux.dev,suse.de,stgolabs.net,infradead.org,oracle.com,lwn.net,manifault.com,arm.com,kernel.org,arndb.de,linutronix.de,linux.intel.com,kernel.dk,soleen.com,google.com,gmail.com,chromium.org,linuxfoundation.org,linaro.org,goodmis.org,linux.com,lge.com,bytedance.com,akamai.com,android.com,vger.kernel.org,lists.linux.dev,kvack.org,googlegroups.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Score: -3.00
X-Rspamd-Queue-Id: 110351FD18
X-Spam-Flag: NO

On 2/14/24 00:08, Kent Overstreet wrote:
> On Tue, Feb 13, 2024 at 02:59:11PM -0800, Suren Baghdasaryan wrote:
>> On Tue, Feb 13, 2024 at 2:50 PM Kent Overstreet
>> <kent.overstreet@linux.dev> wrote:
>> >
>> > On Tue, Feb 13, 2024 at 11:48:41PM +0100, David Hildenbrand wrote:
>> > > On 13.02.24 23:30, Suren Baghdasaryan wrote:
>> > > > On Tue, Feb 13, 2024 at 2:17 PM David Hildenbrand <david@redhat.com> wrote:
>> > > If you think you can easily achieve what Michal requested without all that,
>> > > good.
>> >
>> > He requested something?
>> 
>> Yes, a cleaner instrumentation. Unfortunately the cleanest one is not
>> possible until the compiler feature is developed and deployed. And it
>> still would require changes to the headers, so don't think it's worth
>> delaying the feature for years.
> 
> Hang on, let's look at the actual code.
> 
> This is what instrumenting an allocation function looks like:
> 
> #define krealloc_array(...)                     alloc_hooks(krealloc_array_noprof(__VA_ARGS__))
> 
> IOW, we have to:
>  - rename krealloc_array to krealloc_array_noprof
>  - replace krealloc_array with a one wrapper macro call
> 
> Is this really all we're getting worked up over?
> 
> The renaming we need regardless, because the thing that makes this
> approach efficient enough to run in production is that we account at
> _one_ point in the callstack, we don't save entire backtraces.
> 
> And thus we need to explicitly annotate which one that is; which means
> we need _noprof() versions of functions for when the accounting is done
> by an outer wraper (e.g. mempool).
> 
> And, as I keep saying: that alloc_hooks() macro will also get us _per
> callsite fault injection points_, and we really need that because - if
> you guys have been paying attention to other threads - whenever moving
> more stuff to PF_MEMALLOC_* flags comes up (including adding
> PF_MEMALLOC_NORECLAIM), the issue of small allocations not failing and
> not being testable keeps coming up.

How exactly do you envision the fault injection to help here? The proposals
are about scoping via a process flag, and the process may then call just
about anything under that scope. So if our tool is per callsite fault
injection points, how do we know which callsites to enable to focus the
fault injection on the particular scope?

