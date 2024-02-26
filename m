Return-Path: <linux-fsdevel+bounces-12820-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45ADB867896
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 15:33:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B15031F24B3C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 14:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C0A12BF17;
	Mon, 26 Feb 2024 14:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="s3LB6WwA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PYurhS4h";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="SFvcoWun";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CjlFK5sf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422B04437;
	Mon, 26 Feb 2024 14:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708957897; cv=none; b=UWFzU20mDPpM0bxZTRqNy0xovdtODBhRLW50mbitaM0qWzTayYNSiuSS5/EvcHklhrEroTuAjr2ZlvbAu2+CNfIokvWdf84/1hAN5PMHLnMN03Npn5h2Q65Cn11hJYD+AUsypT5lp/mtpTaFW/BnzdV0gM3IvKU1K8+9HimNfDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708957897; c=relaxed/simple;
	bh=fnHu4UQXyrGGMCbw1L/KhlGYrzsR9YX7kcSF9CXHRV4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Eb/DoEjyuXx41vwjHBp0qYpypXJtbxhC5AF11tDZWJviOmoJo2x+mWdgf9YRbJL0GfB4jxpIZQpl1w5s+g2EB1ZlRYeBOfZZblsV9OunL03K4AxorviJ3cqPiszmDU4DHvO0CleL3cYndYgipilnQ2Cxuw/RXXGUzjoF4LbzGlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=s3LB6WwA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PYurhS4h; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=SFvcoWun; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=CjlFK5sf; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4999B224F8;
	Mon, 26 Feb 2024 14:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708957892; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W4akfkc1Kw2e9YyWEpsf9c0Y76JydMXyZR2TAfFVmJg=;
	b=s3LB6WwAVt/EKwD7kJfsNbn71XtbwBFK1/9n4wFveoyb9Waj6EPPt5rWu1p8+FYQXg7uSq
	Etyh6ho5v40CfyfTuY0CR6QPgFH2hUlOqyMyOG3ZpA30la2xu6/JlVXrQeDKLwbL5iNRXZ
	IPicVeKidvxxyWldx3pjACo2ana9u0o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708957892;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W4akfkc1Kw2e9YyWEpsf9c0Y76JydMXyZR2TAfFVmJg=;
	b=PYurhS4hkcO2U2pXeQaLQVQilCZXbjA3RQZf6enw7WwsHRhov2BwDu3y+iZFdZnQ34lLql
	SwhF5sPmIIt2wLDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708957890; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W4akfkc1Kw2e9YyWEpsf9c0Y76JydMXyZR2TAfFVmJg=;
	b=SFvcoWunXAD5czuNTyZ6mcV5PqVCkfIz77swvk47XOQRUrm2nfI+UT1W4d6KRhZ8Q0kKSV
	uk3fVyLBzjEqamS9OFsgc0BxLC5UJGnVfrw1LY4/Q6x6KKC8MinPWQ8+DeqMucf9DIGsyU
	2AybUrKzXXpgdqGeIOYm9sOcG8hAjcE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708957890;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W4akfkc1Kw2e9YyWEpsf9c0Y76JydMXyZR2TAfFVmJg=;
	b=CjlFK5sfFrdmbcv4e0AyRWrrHwI4xEzQUQL9DJjvYfttGtrtvvNGoZSx3INuMj6wYtTx/C
	MMbGei+nQENXDpDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9FCE813A58;
	Mon, 26 Feb 2024 14:31:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id T+5WJsGg3GV9bwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 26 Feb 2024 14:31:29 +0000
Message-ID: <d8a7ed49-f7d1-44bf-b0e5-64969e816057@suse.cz>
Date: Mon, 26 Feb 2024 15:31:29 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/36] mm/slub: Mark slab_free_freelist_hook()
 __always_inline
To: Suren Baghdasaryan <surenb@google.com>,
 Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, mhocko@suse.com,
 hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de,
 dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
 penguin-kernel@i-love.sakura.ne.jp, corbet@lwn.net, void@manifault.com,
 peterz@infradead.org, juri.lelli@redhat.com, catalin.marinas@arm.com,
 will@kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com,
 dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com,
 david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org,
 nathan@kernel.org, dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev,
 rppt@kernel.org, paulmck@kernel.org, yosryahmed@google.com,
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
References: <20240221194052.927623-1-surenb@google.com>
 <20240221194052.927623-4-surenb@google.com>
 <CA+CK2bD8Cr1V2=PWAsf6CwDnakZ54Qaf_q5t4aVYV-jXQPtPbg@mail.gmail.com>
 <CAJuCfpHBgZeJN_O1ZQg_oLbAXc-Y+jmUpB02jznkEySpd4rzvw@mail.gmail.com>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <CAJuCfpHBgZeJN_O1ZQg_oLbAXc-Y+jmUpB02jznkEySpd4rzvw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=SFvcoWun;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=CjlFK5sf
X-Spamd-Result: default: False [1.18 / 50.00];
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
	 BAYES_HAM(-0.02)[53.57%];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_MATCH_ENVRCPT_SOME(0.00)[];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_GT_50(0.00)[74];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[soleen.com:email,linux.dev:email,chromium.org:email,suse.cz:dkim,suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[linux-foundation.org,linux.dev,suse.com,cmpxchg.org,suse.de,stgolabs.net,infradead.org,oracle.com,i-love.sakura.ne.jp,lwn.net,manifault.com,redhat.com,arm.com,kernel.org,arndb.de,linutronix.de,linux.intel.com,kernel.dk,google.com,gmail.com,chromium.org,linuxfoundation.org,linaro.org,goodmis.org,linux.com,lge.com,bytedance.com,akamai.com,android.com,vger.kernel.org,lists.linux.dev,kvack.org,googlegroups.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 1.18
X-Rspamd-Queue-Id: 4999B224F8
X-Spam-Level: *
X-Spam-Flag: NO
X-Spamd-Bar: +

On 2/24/24 03:02, Suren Baghdasaryan wrote:
> On Wed, Feb 21, 2024 at 1:16 PM Pasha Tatashin
> <pasha.tatashin@soleen.com> wrote:
>>
>> On Wed, Feb 21, 2024 at 2:41 PM Suren Baghdasaryan <surenb@google.com> wrote:
>> >
>> > From: Kent Overstreet <kent.overstreet@linux.dev>
>> >
>> > It seems we need to be more forceful with the compiler on this one.
>> > This is done for performance reasons only.
>> >
>> > Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
>> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>> > Reviewed-by: Kees Cook <keescook@chromium.org>
>> > ---
>> >  mm/slub.c | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/mm/slub.c b/mm/slub.c
>> > index 2ef88bbf56a3..d31b03a8d9d5 100644
>> > --- a/mm/slub.c
>> > +++ b/mm/slub.c
>> > @@ -2121,7 +2121,7 @@ bool slab_free_hook(struct kmem_cache *s, void *x, bool init)
>> >         return !kasan_slab_free(s, x, init);
>> >  }
>> >
>> > -static inline bool slab_free_freelist_hook(struct kmem_cache *s,
>> > +static __always_inline bool slab_free_freelist_hook(struct kmem_cache *s,
>>
>> __fastpath_inline seems to me more appropriate here. It prioritizes
>> memory vs performance.
> 
> Hmm. AFAIKT this function is used only in one place and we do not add
> any additional users, so I don't think changing to __fastpath_inline
> here would gain us anything.

It would have been more future-proof and self-documenting. But I don't insist.

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

>>
>> >                                            void **head, void **tail,
>> >                                            int *cnt)
>> >  {
>> > --
>> > 2.44.0.rc0.258.g7320e95886-goog
>> >


