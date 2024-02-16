Return-Path: <linux-fsdevel+bounces-11885-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0200C8585AF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 19:49:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D1E4B2107A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 18:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85D1213540A;
	Fri, 16 Feb 2024 18:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IczKkH7t";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="eWjfjtUQ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nJrH6lwW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rCplWnn+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9622C688;
	Fri, 16 Feb 2024 18:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708109348; cv=none; b=qkkHKM5Nw4GuedALyV26TEykdTKTsyHdRafMClDo+6A/gS5vdffFcfx8j9XkfxH0V7wZ59Hj8qh5MA1JfqKO56YD9ZVYFV4fVlO88FIVySdyPPQ8dQhaRcoPDG9ZHmi+jwBiO2o/2ipKC020GV9nCDacdOUUuJbFYhKqKqDUn1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708109348; c=relaxed/simple;
	bh=A0E9sndd7l0lu6Xyh5dd3tP87FBrCGKIlTdotIdICcY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=APKFTYuKbahBYM2HJZrBlFKkWtfrxa5vZcOqKBY2BV7lE3IgDkubRsImDOYqMym7JKuKAEc2xgZRoJF6UmwHZnHHNMUnox2w9vQ+daXtPPTShqx1B15ixc/dGfVDNPgTbFUMJDn80AERXC4G8KJwLVKAX+YCbUc58yZDeQq1Nq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=IczKkH7t; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=eWjfjtUQ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nJrH6lwW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rCplWnn+; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E942A22116;
	Fri, 16 Feb 2024 18:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708109344; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LIy+v1QxzmWGHbmMqIx5w7+6IieTl4Y2Xxq5xuO/0u4=;
	b=IczKkH7ttqFZkIRIpgaqdovXlBv+wdZc/WVt3WfwuuayALZt1K/ktc8gkJLvb9DV02Aw6O
	mqoxlagg9OnV1b3uKdi4cPs834trLa4dhnFFXfGsjiAFaJlLtwlt5k0zq1/mQUJcjUKD98
	Yl2/H30Tkm2T430gGAIL5rZo7SIco+4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708109344;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LIy+v1QxzmWGHbmMqIx5w7+6IieTl4Y2Xxq5xuO/0u4=;
	b=eWjfjtUQK+vs3+zTwA2o6NuZ4YsKpb1iorpHwofZAOTDMADyKmTQZgmjt5VFnhMbl3fvFK
	sOX+EXx60O+jLyCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708109341; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LIy+v1QxzmWGHbmMqIx5w7+6IieTl4Y2Xxq5xuO/0u4=;
	b=nJrH6lwWDcLp8vXKR4AD0HQDEbJXWoHr5M6JWvxdQL9Kq6Pe5MBk9Loldg+eWVs0EKznrW
	bSmITWiT6i/Cg9Xr+ymmLfxfxZCjgz/13+YnHVhtrh/UFjbFZapdv6pIPhVwTWLNVzoTnF
	773TjX4j+Iu2mcmaak8h/AOdL0cbrR4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708109341;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LIy+v1QxzmWGHbmMqIx5w7+6IieTl4Y2Xxq5xuO/0u4=;
	b=rCplWnn+zjLptQfYWR2TYcjXBWf1sp+AS9ffhspWlwv9w0hq+Dl+5EFFBo0Z/cp/14/7Vt
	EghNrullQkOlmIBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5AF8F1398D;
	Fri, 16 Feb 2024 18:49:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id upbPFR2uz2WgbQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 16 Feb 2024 18:49:01 +0000
Message-ID: <198f835b-35d6-4ae2-b993-675c871c621e@suse.cz>
Date: Fri, 16 Feb 2024 19:49:01 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/35] mm/slab: introduce SLAB_NO_OBJ_EXT to avoid
 obj_ext creation
Content-Language: en-US
To: Suren Baghdasaryan <surenb@google.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>, akpm@linux-foundation.org,
 mhocko@suse.com, hannes@cmpxchg.org, roman.gushchin@linux.dev,
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
References: <20240212213922.783301-1-surenb@google.com>
 <20240212213922.783301-8-surenb@google.com>
 <fbfab72f-413d-4fc1-b10b-3373cfc6c8e9@suse.cz>
 <tbqg7sowftykfj3rptpcbewoiy632fbgbkzemgwnntme4wxhut@5dlfmdniaksr>
 <ab4b1789-910a-4cd6-802c-5012bf9d8984@suse.cz>
 <CAJuCfpH=tr1faWnn0CZ=V_Gg-0ysEsGPOje5U-DDy5x2V83pxA@mail.gmail.com>
 <CAJuCfpGBCNsvK35Bq8666cJeZ3Hwfwj6mDJ6M5Wjg7oZi8xd0g@mail.gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <CAJuCfpGBCNsvK35Bq8666cJeZ3Hwfwj6mDJ6M5Wjg7oZi8xd0g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-1.59 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BAYES_HAM(-3.00)[100.00%];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_MATCH_ENVRCPT_SOME(0.00)[];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_GT_50(0.00)[73];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[linux.dev,linux-foundation.org,suse.com,cmpxchg.org,suse.de,stgolabs.net,infradead.org,oracle.com,lwn.net,manifault.com,redhat.com,arm.com,kernel.org,arndb.de,linutronix.de,linux.intel.com,kernel.dk,soleen.com,google.com,gmail.com,chromium.org,linuxfoundation.org,linaro.org,goodmis.org,linux.com,lge.com,bytedance.com,akamai.com,android.com,vger.kernel.org,lists.linux.dev,kvack.org,googlegroups.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -1.59

On 2/16/24 19:41, Suren Baghdasaryan wrote:
> On Thu, Feb 15, 2024 at 10:10 PM Suren Baghdasaryan <surenb@google.com> wrote:
>>
>> On Thu, Feb 15, 2024 at 1:50 PM Vlastimil Babka <vbabka@suse.cz> wrote:
>> >
>> > On 2/15/24 22:37, Kent Overstreet wrote:
>> > > On Thu, Feb 15, 2024 at 10:31:06PM +0100, Vlastimil Babka wrote:
>> > >> On 2/12/24 22:38, Suren Baghdasaryan wrote:
>> > >> > Slab extension objects can't be allocated before slab infrastructure is
>> > >> > initialized. Some caches, like kmem_cache and kmem_cache_node, are created
>> > >> > before slab infrastructure is initialized. Objects from these caches can't
>> > >> > have extension objects. Introduce SLAB_NO_OBJ_EXT slab flag to mark these
>> > >> > caches and avoid creating extensions for objects allocated from these
>> > >> > slabs.
>> > >> >
>> > >> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>> > >> > ---
>> > >> >  include/linux/slab.h | 7 +++++++
>> > >> >  mm/slub.c            | 5 +++--
>> > >> >  2 files changed, 10 insertions(+), 2 deletions(-)
>> > >> >
>> > >> > diff --git a/include/linux/slab.h b/include/linux/slab.h
>> > >> > index b5f5ee8308d0..3ac2fc830f0f 100644
>> > >> > --- a/include/linux/slab.h
>> > >> > +++ b/include/linux/slab.h
>> > >> > @@ -164,6 +164,13 @@
>> > >> >  #endif
>> > >> >  #define SLAB_TEMPORARY            SLAB_RECLAIM_ACCOUNT    /* Objects are short-lived */
>> > >> >
>> > >> > +#ifdef CONFIG_SLAB_OBJ_EXT
>> > >> > +/* Slab created using create_boot_cache */
>> > >> > +#define SLAB_NO_OBJ_EXT         ((slab_flags_t __force)0x20000000U)
>> > >>
>> > >> There's
>> > >>    #define SLAB_SKIP_KFENCE        ((slab_flags_t __force)0x20000000U)
>> > >> already, so need some other one?
>>
>> Indeed. I somehow missed it. Thanks for noticing, will fix this in the
>> next version.
> 
> Apparently the only unused slab flag is 0x00000200U, all others seem
> to be taken. I'll use it if there are no objections.

OK. Will look into the cleanup and consolidation - we already know
SLAB_MEM_SPREAD became dead with SLAB removed. If it comes to worst, we can
switch to 64 bits again.

>>
>> > >
>> > > What's up with the order of flags in that file? They don't seem to
>> > > follow any particular ordering.
>> >
>> > Seems mostly in increasing order, except commit 4fd0b46e89879 broke it for
>> > SLAB_RECLAIM_ACCOUNT?
>> >
>> > > Seems like some cleanup is in order, but any history/context we should
>> > > know first?
>> >
>> > Yeah noted, but no need to sidetrack you.


