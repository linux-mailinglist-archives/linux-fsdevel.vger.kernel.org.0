Return-Path: <linux-fsdevel+bounces-12937-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F166E868D2E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 11:19:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B2771F27675
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 10:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D2781384A7;
	Tue, 27 Feb 2024 10:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cpyVIP79";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UuxALrSs";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cpyVIP79";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UuxALrSs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C0E138484;
	Tue, 27 Feb 2024 10:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709029134; cv=none; b=faLOVWTGVn8KJ/9dMrbr2iWhdyWhMVVTXpNr2TYyO1NlappalXJBSXuz0n6vrUahLQ3YiTRG8BvQwaw0Qi8mubAKCAeMU7s2pPdBv0l1mz4JruaWNheGIYPNc47NcPobp82hHQQBc8I7tP5Z/Cktm81M9FyD7Zu22Di2V6KaRGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709029134; c=relaxed/simple;
	bh=1kT4IadTcD9s8wVa7TvXCimMRyY5zCB8d4SK3JfJKpI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qgKJ2Fm289+Puk/7nac/sGMJuaegQ8skLupDzr47ksHrGhQIS/WQeUD973FLkW51H3dRglAf+/y6/fk3KiQiH5A+Yqo/HAfdbbcdpObIkUWcwRT/Cd7CLDqZ9tMGxl4gCJsmbenq+vFxkgc5iTwhnIawoSu03xXn0vWe8OhkR+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cpyVIP79; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UuxALrSs; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cpyVIP79; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UuxALrSs; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5FBE01F44F;
	Tue, 27 Feb 2024 10:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709029129; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q4pT87ICIgMrimfBYIsFt4403+jQ655os57F8M8rAV0=;
	b=cpyVIP79rj0/sBrJvpdZDSi/YWGaVzMxOeOUTFZkxXRW5dBBpVG2nrSet3ziaxNcNhCRul
	fsn2i6ZDMFIR8vZKMy1rHahvaELrlR9TdV1JOh9wud8P37gKHfMGsbCuw8Lz1zGjf4dOM9
	gotsrvN12NpBYdL5ELH484nyYHkPZRY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709029129;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q4pT87ICIgMrimfBYIsFt4403+jQ655os57F8M8rAV0=;
	b=UuxALrSs0P8mLarP5bjo/PfJ0N2IwYv6LH6qdRMTKIyww8fRC4dOnMwu5xagQtZCCFsHZf
	6lKfIVVRnWShjTBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709029129; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q4pT87ICIgMrimfBYIsFt4403+jQ655os57F8M8rAV0=;
	b=cpyVIP79rj0/sBrJvpdZDSi/YWGaVzMxOeOUTFZkxXRW5dBBpVG2nrSet3ziaxNcNhCRul
	fsn2i6ZDMFIR8vZKMy1rHahvaELrlR9TdV1JOh9wud8P37gKHfMGsbCuw8Lz1zGjf4dOM9
	gotsrvN12NpBYdL5ELH484nyYHkPZRY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709029129;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q4pT87ICIgMrimfBYIsFt4403+jQ655os57F8M8rAV0=;
	b=UuxALrSs0P8mLarP5bjo/PfJ0N2IwYv6LH6qdRMTKIyww8fRC4dOnMwu5xagQtZCCFsHZf
	6lKfIVVRnWShjTBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B14DF13A65;
	Tue, 27 Feb 2024 10:18:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UH3gKQi33WXqfQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 27 Feb 2024 10:18:48 +0000
Message-ID: <4e648451-31a8-4293-bc14-e7ea01c889b1@suse.cz>
Date: Tue, 27 Feb 2024 11:19:20 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 21/36] lib: add codetag reference into slabobj_ext
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
 <20240221194052.927623-22-surenb@google.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20240221194052.927623-22-surenb@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Bar: /
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=cpyVIP79;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=UuxALrSs
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.02 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_GT_50(0.00)[74];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_MATCH_FROM(0.00)[];
	 BAYES_HAM(-0.02)[51.67%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_MATCH_ENVRCPT_SOME(0.00)[];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,linux.dev:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FREEMAIL_CC(0.00)[linux.dev,suse.com,cmpxchg.org,suse.de,stgolabs.net,infradead.org,oracle.com,i-love.sakura.ne.jp,lwn.net,manifault.com,redhat.com,arm.com,kernel.org,arndb.de,linutronix.de,linux.intel.com,kernel.dk,soleen.com,google.com,gmail.com,chromium.org,linuxfoundation.org,linaro.org,goodmis.org,linux.com,lge.com,bytedance.com,akamai.com,android.com,vger.kernel.org,lists.linux.dev,kvack.org,googlegroups.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Score: -0.02
X-Rspamd-Queue-Id: 5FBE01F44F
X-Spam-Flag: NO

On 2/21/24 20:40, Suren Baghdasaryan wrote:
> To store code tag for every slab object, a codetag reference is embedded
> into slabobj_ext when CONFIG_MEM_ALLOC_PROFILING=y.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Co-developed-by: Kent Overstreet <kent.overstreet@linux.dev>
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  include/linux/memcontrol.h | 5 +++++
>  lib/Kconfig.debug          | 1 +
>  2 files changed, 6 insertions(+)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index f3584e98b640..2b010316016c 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -1653,7 +1653,12 @@ unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
>   * if MEMCG_DATA_OBJEXTS is set.
>   */
>  struct slabobj_ext {
> +#ifdef CONFIG_MEMCG_KMEM
>  	struct obj_cgroup *objcg;
> +#endif
> +#ifdef CONFIG_MEM_ALLOC_PROFILING
> +	union codetag_ref ref;
> +#endif
>  } __aligned(8);
>  
>  static inline void __inc_lruvec_kmem_state(void *p, enum node_stat_item idx)
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 7bbdb0ddb011..9ecfcdb54417 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -979,6 +979,7 @@ config MEM_ALLOC_PROFILING
>  	depends on !DEBUG_FORCE_WEAK_PER_CPU
>  	select CODE_TAGGING
>  	select PAGE_EXTENSION
> +	select SLAB_OBJ_EXT
>  	help
>  	  Track allocation source code and record total allocation size
>  	  initiated at that code location. The mechanism can be used to track

