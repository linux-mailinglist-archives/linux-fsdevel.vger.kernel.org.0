Return-Path: <linux-fsdevel+bounces-12951-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF09869199
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 14:18:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10DD11F233B4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 13:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D6613DB9B;
	Tue, 27 Feb 2024 13:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="t+9keHML";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GRvXGAM1";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="F9IZKXKZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qeLIL82+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C747D13B29C;
	Tue, 27 Feb 2024 13:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709039918; cv=none; b=J6HhOwqO8aLyhKHRzbqDAUW0XdAKFLlFrwtTYh0fAJumKPeRJFN8WJ3tnyHY+Ff2CEiBgBfSaveztJ8OQ+eP/kI3tsGId1FbiEiEzhQQq3AQroo2pqd535BgzHQz0HXNkBPNIgU+mVBT9T5G+Y/i5l9ySB7pyh4OzxVvyuawYaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709039918; c=relaxed/simple;
	bh=3gcuV61t2Hf8iIU8GS9e4WnOjtwy66ob4TygKymP7vI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IrPhu2RKmpZTUucBCEEV2XJTBmLYYLnuOxs79OpuXnpQzbDUS75pI3Vo139VHtkzbe++WQ2ORJ/KcW67j6Z6Qt6/Brz+dTpZrI9Wh4zcsq5mXLNwCQwwKIOt6hWOsbKE9pnLjp+SCXFjBotoykA18TmkQYyeI7VvlS4qSX+quXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=t+9keHML; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GRvXGAM1; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=F9IZKXKZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qeLIL82+; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CD386222B1;
	Tue, 27 Feb 2024 13:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709039914; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b5fxnH3MZSXNsSIAXZNKwmzfwaEYfCce0iXFeFygkQg=;
	b=t+9keHMLh4mZ9U9FQ87VKQu8qlErdV098YFQ27/heTmhZppg6tdPU6yJ9Eo76VKzqONnnB
	1DBPJEyQqJV/UxcctxZ22Xq3EhU0hSfd5ki6CR8KBtRG2fx3ZgjUmb8S2H5X+dAnVF5Svw
	CMbh1JgO3q0lxv2gMts6lsIDlkbCUZg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709039914;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b5fxnH3MZSXNsSIAXZNKwmzfwaEYfCce0iXFeFygkQg=;
	b=GRvXGAM18yVMX0BW2K+RwWRfUhc/w+IroW6mjGbZVcLNZgZY0hFKcOseHovdH82tnqfTto
	OlaadaQpT0hAOkDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709039913; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b5fxnH3MZSXNsSIAXZNKwmzfwaEYfCce0iXFeFygkQg=;
	b=F9IZKXKZt1gaRwhJRkHRlaQl1OHHL8G72P9VbBh9roM6E3f52yS+BVAhXmn3S2584WUvxJ
	ENH/CybjETOcGt4IQKTDzjQUBrSJRyTn/xgopePYT59Kc+3X6u6ghbXOY8evc12MXdxiqu
	DD9NtaFXXx+SvDohX/QhkhPtG+o3fsw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709039913;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b5fxnH3MZSXNsSIAXZNKwmzfwaEYfCce0iXFeFygkQg=;
	b=qeLIL82+HCy8ZAeUFMjZFYLviW9bzTdgWX6Cj9qpRxpNfNN2rVWl2yY3EOP1Z6qmCjOMY8
	DkkhqX5V+tGh6EAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 31E4C13A58;
	Tue, 27 Feb 2024 13:18:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Pt1+Cyjh3WWwLAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 27 Feb 2024 13:18:32 +0000
Message-ID: <ae4f9958-813a-42c8-8e54-4ef19fd36d6c@suse.cz>
Date: Tue, 27 Feb 2024 14:19:04 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 31/36] lib: add memory allocations report in show_mem()
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
 <20240221194052.927623-32-surenb@google.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20240221194052.927623-32-surenb@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=F9IZKXKZ;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=qeLIL82+
X-Spamd-Result: default: False [1.20 / 50.00];
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
	 BAYES_HAM(-0.00)[11.51%];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_MATCH_ENVRCPT_SOME(0.00)[];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_GT_50(0.00)[74];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,linux.dev:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[linux.dev,suse.com,cmpxchg.org,suse.de,stgolabs.net,infradead.org,oracle.com,i-love.sakura.ne.jp,lwn.net,manifault.com,redhat.com,arm.com,kernel.org,arndb.de,linutronix.de,linux.intel.com,kernel.dk,soleen.com,google.com,gmail.com,chromium.org,linuxfoundation.org,linaro.org,goodmis.org,linux.com,lge.com,bytedance.com,akamai.com,android.com,vger.kernel.org,lists.linux.dev,kvack.org,googlegroups.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 1.20
X-Rspamd-Queue-Id: CD386222B1
X-Spam-Level: *
X-Spam-Flag: NO
X-Spamd-Bar: +

On 2/21/24 20:40, Suren Baghdasaryan wrote:
> Include allocations in show_mem reports.
> 
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

Nit: there's pr_notice() that's shorter than printk(KERN_NOTICE

> ---
>  include/linux/alloc_tag.h |  7 +++++++
>  include/linux/codetag.h   |  1 +
>  lib/alloc_tag.c           | 38 ++++++++++++++++++++++++++++++++++++++
>  lib/codetag.c             |  5 +++++
>  mm/show_mem.c             | 26 ++++++++++++++++++++++++++
>  5 files changed, 77 insertions(+)
> 
> diff --git a/include/linux/alloc_tag.h b/include/linux/alloc_tag.h
> index 29636719b276..85a24a027403 100644
> --- a/include/linux/alloc_tag.h
> +++ b/include/linux/alloc_tag.h
> @@ -30,6 +30,13 @@ struct alloc_tag {
>  
>  #ifdef CONFIG_MEM_ALLOC_PROFILING
>  
> +struct codetag_bytes {
> +	struct codetag *ct;
> +	s64 bytes;
> +};
> +
> +size_t alloc_tag_top_users(struct codetag_bytes *tags, size_t count, bool can_sleep);
> +
>  static inline struct alloc_tag *ct_to_alloc_tag(struct codetag *ct)
>  {
>  	return container_of(ct, struct alloc_tag, ct);
> diff --git a/include/linux/codetag.h b/include/linux/codetag.h
> index bfd0ba5c4185..c2a579ccd455 100644
> --- a/include/linux/codetag.h
> +++ b/include/linux/codetag.h
> @@ -61,6 +61,7 @@ struct codetag_iterator {
>  }
>  
>  void codetag_lock_module_list(struct codetag_type *cttype, bool lock);
> +bool codetag_trylock_module_list(struct codetag_type *cttype);
>  struct codetag_iterator codetag_get_ct_iter(struct codetag_type *cttype);
>  struct codetag *codetag_next_ct(struct codetag_iterator *iter);
>  
> diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
> index cb5adec4b2e2..ec54f29482dc 100644
> --- a/lib/alloc_tag.c
> +++ b/lib/alloc_tag.c
> @@ -86,6 +86,44 @@ static const struct seq_operations allocinfo_seq_op = {
>  	.show	= allocinfo_show,
>  };
>  
> +size_t alloc_tag_top_users(struct codetag_bytes *tags, size_t count, bool can_sleep)
> +{
> +	struct codetag_iterator iter;
> +	struct codetag *ct;
> +	struct codetag_bytes n;
> +	unsigned int i, nr = 0;
> +
> +	if (can_sleep)
> +		codetag_lock_module_list(alloc_tag_cttype, true);
> +	else if (!codetag_trylock_module_list(alloc_tag_cttype))
> +		return 0;
> +
> +	iter = codetag_get_ct_iter(alloc_tag_cttype);
> +	while ((ct = codetag_next_ct(&iter))) {
> +		struct alloc_tag_counters counter = alloc_tag_read(ct_to_alloc_tag(ct));
> +
> +		n.ct	= ct;
> +		n.bytes = counter.bytes;
> +
> +		for (i = 0; i < nr; i++)
> +			if (n.bytes > tags[i].bytes)
> +				break;
> +
> +		if (i < count) {
> +			nr -= nr == count;
> +			memmove(&tags[i + 1],
> +				&tags[i],
> +				sizeof(tags[0]) * (nr - i));
> +			nr++;
> +			tags[i] = n;
> +		}
> +	}
> +
> +	codetag_lock_module_list(alloc_tag_cttype, false);
> +
> +	return nr;
> +}
> +
>  static void __init procfs_init(void)
>  {
>  	proc_create_seq("allocinfo", 0444, NULL, &allocinfo_seq_op);
> diff --git a/lib/codetag.c b/lib/codetag.c
> index b13412ca57cc..7b39cec9648a 100644
> --- a/lib/codetag.c
> +++ b/lib/codetag.c
> @@ -36,6 +36,11 @@ void codetag_lock_module_list(struct codetag_type *cttype, bool lock)
>  		up_read(&cttype->mod_lock);
>  }
>  
> +bool codetag_trylock_module_list(struct codetag_type *cttype)
> +{
> +	return down_read_trylock(&cttype->mod_lock) != 0;
> +}
> +
>  struct codetag_iterator codetag_get_ct_iter(struct codetag_type *cttype)
>  {
>  	struct codetag_iterator iter = {
> diff --git a/mm/show_mem.c b/mm/show_mem.c
> index 8dcfafbd283c..1e41f8d6e297 100644
> --- a/mm/show_mem.c
> +++ b/mm/show_mem.c
> @@ -423,4 +423,30 @@ void __show_mem(unsigned int filter, nodemask_t *nodemask, int max_zone_idx)
>  #ifdef CONFIG_MEMORY_FAILURE
>  	printk("%lu pages hwpoisoned\n", atomic_long_read(&num_poisoned_pages));
>  #endif
> +#ifdef CONFIG_MEM_ALLOC_PROFILING
> +	{
> +		struct codetag_bytes tags[10];
> +		size_t i, nr;
> +
> +		nr = alloc_tag_top_users(tags, ARRAY_SIZE(tags), false);
> +		if (nr) {
> +			printk(KERN_NOTICE "Memory allocations:\n");
> +			for (i = 0; i < nr; i++) {
> +				struct codetag *ct = tags[i].ct;
> +				struct alloc_tag *tag = ct_to_alloc_tag(ct);
> +				struct alloc_tag_counters counter = alloc_tag_read(tag);
> +
> +				/* Same as alloc_tag_to_text() but w/o intermediate buffer */
> +				if (ct->modname)
> +					printk(KERN_NOTICE "%12lli %8llu %s:%u [%s] func:%s\n",
> +					       counter.bytes, counter.calls, ct->filename,
> +					       ct->lineno, ct->modname, ct->function);
> +				else
> +					printk(KERN_NOTICE "%12lli %8llu %s:%u func:%s\n",
> +					       counter.bytes, counter.calls, ct->filename,
> +					       ct->lineno, ct->function);
> +			}
> +		}
> +	}
> +#endif
>  }

