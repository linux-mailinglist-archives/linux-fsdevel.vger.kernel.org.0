Return-Path: <linux-fsdevel+bounces-12936-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E1A868D22
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 11:17:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1198285128
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 10:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9722A13849E;
	Tue, 27 Feb 2024 10:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YYsNtmEp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2SXuPYm8";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YYsNtmEp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2SXuPYm8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CFC0137C4D;
	Tue, 27 Feb 2024 10:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709029054; cv=none; b=MH2rAUbnnLFDJeGWicsWypl47ExQJFrR9qHNdpwHYt9v6j/0KLsA3mb18tZjpsXQRHDrstFsHJZCtnGo9PwlD0ywwxUg+AJ+IoCwmC9wWq3JeBIWTwprA4P/V6ABiahd6MFX5jeu9L+/1s9gHGO58HdMCYxT50ec5FR3gHZ1O/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709029054; c=relaxed/simple;
	bh=uAT8fOjHimP1s8p52C/iiBFIjHSNXhLdNgmVkCGq/SM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fab0nSI6baoxsnA61c8VS4+Ha5fAz8vazIgc+7wtxItlJv6fewEGlQJVF0LYEr5m3DHIPHj9Mr86txP2ncy/ASAmJ1KRg2mCrAHmrZdstr5YnMwxkqt6VkvDm8GDtUd1Tbw5jbmPNZ3t4yN3ULu0/np7kV2jracaXCLI4ECF1nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YYsNtmEp; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2SXuPYm8; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YYsNtmEp; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2SXuPYm8; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7A41F22722;
	Tue, 27 Feb 2024 10:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709029050; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CWojS/ZBMHmeYzh+o2egixF9yHAOBC8s1LHQ5pVRk5E=;
	b=YYsNtmEpB6yRtMeGZZynoZ9Gj6zOZN0ULuXprkdjnd3ebaDESlEU2nLaRURpU8A+daBzAj
	q5qsf17lVyVqjSa9FjAf9H7PJ0EsGhR3WKCEVnnJptbgqi/r1Loqr9T7gw3THvUs+fzbz/
	VcQDuFxYk7woWEtGLS3UcznYheAjCKY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709029050;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CWojS/ZBMHmeYzh+o2egixF9yHAOBC8s1LHQ5pVRk5E=;
	b=2SXuPYm80fYChAQrn/4DmTfrCVV9IvIAJ/vSXwLtFn07gSD61WET7VJEU8BHJ+hWwQda1g
	PUlKDb6Vwsq+CuAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709029050; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CWojS/ZBMHmeYzh+o2egixF9yHAOBC8s1LHQ5pVRk5E=;
	b=YYsNtmEpB6yRtMeGZZynoZ9Gj6zOZN0ULuXprkdjnd3ebaDESlEU2nLaRURpU8A+daBzAj
	q5qsf17lVyVqjSa9FjAf9H7PJ0EsGhR3WKCEVnnJptbgqi/r1Loqr9T7gw3THvUs+fzbz/
	VcQDuFxYk7woWEtGLS3UcznYheAjCKY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709029050;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CWojS/ZBMHmeYzh+o2egixF9yHAOBC8s1LHQ5pVRk5E=;
	b=2SXuPYm80fYChAQrn/4DmTfrCVV9IvIAJ/vSXwLtFn07gSD61WET7VJEU8BHJ+hWwQda1g
	PUlKDb6Vwsq+CuAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2F5E913A65;
	Tue, 27 Feb 2024 10:17:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oUVMCrq23WXqfQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 27 Feb 2024 10:17:30 +0000
Message-ID: <49c33680-2a08-4d59-86ba-72f8850099a5@suse.cz>
Date: Tue, 27 Feb 2024 11:18:02 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 20/36] mm/page_ext: enable early_page_ext when
 CONFIG_MEM_ALLOC_PROFILING_DEBUG=y
Content-Language: en-US
To: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, mhocko@suse.com, hannes@cmpxchg.org,
 roman.gushchin@linux.dev, mgorman@suse.de, dave@stgolabs.net,
 willy@infradead.org, liam.howlett@oracle.com,
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
 <20240221194052.927623-21-surenb@google.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20240221194052.927623-21-surenb@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -0.09
X-Spamd-Result: default: False [-0.09 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 BAYES_HAM(-0.30)[75.07%];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_MATCH_ENVRCPT_SOME(0.00)[];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_GT_50(0.00)[74];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[linux.dev,suse.com,cmpxchg.org,suse.de,stgolabs.net,infradead.org,oracle.com,i-love.sakura.ne.jp,lwn.net,manifault.com,redhat.com,arm.com,kernel.org,arndb.de,linutronix.de,linux.intel.com,kernel.dk,soleen.com,google.com,gmail.com,chromium.org,linuxfoundation.org,linaro.org,goodmis.org,linux.com,lge.com,bytedance.com,akamai.com,android.com,vger.kernel.org,lists.linux.dev,kvack.org,googlegroups.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Flag: NO

On 2/21/24 20:40, Suren Baghdasaryan wrote:
> For all page allocations to be tagged, page_ext has to be initialized
> before the first page allocation. Early tasks allocate their stacks
> using page allocator before alloc_node_page_ext() initializes page_ext
> area, unless early_page_ext is enabled. Therefore these allocations will
> generate a warning when CONFIG_MEM_ALLOC_PROFILING_DEBUG is enabled.
> Enable early_page_ext whenever CONFIG_MEM_ALLOC_PROFILING_DEBUG=y to
> ensure page_ext initialization prior to any page allocation. This will
> have all the negative effects associated with early_page_ext, such as
> possible longer boot time, therefore we enable it only when debugging
> with CONFIG_MEM_ALLOC_PROFILING_DEBUG enabled and not universally for
> CONFIG_MEM_ALLOC_PROFILING.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/page_ext.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/mm/page_ext.c b/mm/page_ext.c
> index 3c58fe8a24df..e7d8f1a5589e 100644
> --- a/mm/page_ext.c
> +++ b/mm/page_ext.c
> @@ -95,7 +95,16 @@ unsigned long page_ext_size;
>  
>  static unsigned long total_usage;
>  
> +#ifdef CONFIG_MEM_ALLOC_PROFILING_DEBUG
> +/*
> + * To ensure correct allocation tagging for pages, page_ext should be available
> + * before the first page allocation. Otherwise early task stacks will be
> + * allocated before page_ext initialization and missing tags will be flagged.
> + */
> +bool early_page_ext __meminitdata = true;
> +#else
>  bool early_page_ext __meminitdata;
> +#endif
>  static int __init setup_early_page_ext(char *str)
>  {
>  	early_page_ext = true;

