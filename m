Return-Path: <linux-fsdevel+bounces-12953-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BF71E86933F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 14:43:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2C2CB2DDB9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 13:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8296113B7BE;
	Tue, 27 Feb 2024 13:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Si4g5Sei";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nTgrsNPt";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Si4g5Sei";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nTgrsNPt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BEB1332A7;
	Tue, 27 Feb 2024 13:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709040954; cv=none; b=DvxX1szfwG4ztvYFOgXJfyZoFIFLymLWyMcQepGpkaPglLI22E6p3rTkIwmsmu2WapPH/ATDSDlWBqosF+yh5UQtwtmYNV1GgwFVG6WwcsZM9HtYL3qZ0k/7/6MfHSFrxSno15cI5Zj6cuVPBU02eQHmF/wREnAYfX08eol0QFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709040954; c=relaxed/simple;
	bh=IeeH8FW7appcHAym5VvThxokOlHOzDrVEXH8nPsBLP8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TrikIlBZvEatgXUMcSqAMsbhUP/Pimp8D1lY+GJ6nYeDVMEygFQL7enTDBHWglqWf/wnoSeEBSOORB9lHpUY0zPEX+i74PTCX7dxDoP+tyQxKypJ7cvypvcV/cxe2YtnWDb2cj28emrZRRkXYIyP6ePg43CSck3pgDDD7wmr2Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Si4g5Sei; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nTgrsNPt; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Si4g5Sei; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nTgrsNPt; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5CB6622445;
	Tue, 27 Feb 2024 13:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709040951; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k1BLeq7Vl9qJ6EYRJ54haTpHogCVSh3EPlNJp9vn1oU=;
	b=Si4g5SeiWxr+Fxmg1mh1nKy7S726J5ngIFb3w5n1326Q+tVr5DbAT5m8N+TG2LIB03edoG
	pcPuoEhcH+pjcb1S0qhxhtrOr9QQprUkGb+KMJgzqH9/+7TTJ4JA1h8XNMYT/lWVAPhSWF
	ZXzwdohp08cA5HsNxeTq8KMrTzwp3Ls=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709040951;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k1BLeq7Vl9qJ6EYRJ54haTpHogCVSh3EPlNJp9vn1oU=;
	b=nTgrsNPt3BuR2Za3gx0Z1aZPJwCD4atXB95fQMBDER1s+A+MPzLOFn2uXXsSiMpEUe42Xp
	nTNV5F9Y6gXm2tDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709040951; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k1BLeq7Vl9qJ6EYRJ54haTpHogCVSh3EPlNJp9vn1oU=;
	b=Si4g5SeiWxr+Fxmg1mh1nKy7S726J5ngIFb3w5n1326Q+tVr5DbAT5m8N+TG2LIB03edoG
	pcPuoEhcH+pjcb1S0qhxhtrOr9QQprUkGb+KMJgzqH9/+7TTJ4JA1h8XNMYT/lWVAPhSWF
	ZXzwdohp08cA5HsNxeTq8KMrTzwp3Ls=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709040951;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k1BLeq7Vl9qJ6EYRJ54haTpHogCVSh3EPlNJp9vn1oU=;
	b=nTgrsNPt3BuR2Za3gx0Z1aZPJwCD4atXB95fQMBDER1s+A+MPzLOFn2uXXsSiMpEUe42Xp
	nTNV5F9Y6gXm2tDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0512013A58;
	Tue, 27 Feb 2024 13:35:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id B094ADbl3WX2MAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 27 Feb 2024 13:35:50 +0000
Message-ID: <67453a56-d4c2-4dc8-a5db-0a4665e40856@suse.cz>
Date: Tue, 27 Feb 2024 14:36:14 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/36] Memory allocation profiling
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
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20240221194052.927623-1-surenb@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Si4g5Sei;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=nTgrsNPt
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.00 / 50.00];
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
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_MATCH_ENVRCPT_SOME(0.00)[];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FREEMAIL_CC(0.00)[linux.dev,suse.com,cmpxchg.org,suse.de,stgolabs.net,infradead.org,oracle.com,i-love.sakura.ne.jp,lwn.net,manifault.com,redhat.com,arm.com,kernel.org,arndb.de,linutronix.de,linux.intel.com,kernel.dk,soleen.com,google.com,gmail.com,chromium.org,linuxfoundation.org,linaro.org,goodmis.org,linux.com,lge.com,bytedance.com,akamai.com,android.com,vger.kernel.org,lists.linux.dev,kvack.org,googlegroups.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Spam-Score: -3.00
X-Rspamd-Queue-Id: 5CB6622445
X-Spam-Flag: NO

On 2/21/24 20:40, Suren Baghdasaryan wrote:
> Overview:
> Low overhead [1] per-callsite memory allocation profiling. Not just for
> debug kernels, overhead low enough to be deployed in production.
> 
> Example output:
>   root@moria-kvm:~# sort -rn /proc/allocinfo
>    127664128    31168 mm/page_ext.c:270 func:alloc_page_ext
>     56373248     4737 mm/slub.c:2259 func:alloc_slab_page
>     14880768     3633 mm/readahead.c:247 func:page_cache_ra_unbounded
>     14417920     3520 mm/mm_init.c:2530 func:alloc_large_system_hash
>     13377536      234 block/blk-mq.c:3421 func:blk_mq_alloc_rqs
>     11718656     2861 mm/filemap.c:1919 func:__filemap_get_folio
>      9192960     2800 kernel/fork.c:307 func:alloc_thread_stack_node
>      4206592        4 net/netfilter/nf_conntrack_core.c:2567 func:nf_ct_alloc_hashtable
>      4136960     1010 drivers/staging/ctagmod/ctagmod.c:20 [ctagmod] func:ctagmod_start
>      3940352      962 mm/memory.c:4214 func:alloc_anon_folio
>      2894464    22613 fs/kernfs/dir.c:615 func:__kernfs_new_node
>      ...
> 
> Since v3:
>  - Dropped patch changing string_get_size() [2] as not needed
>  - Dropped patch modifying xfs allocators [3] as non needed,
>    per Dave Chinner
>  - Added Reviewed-by, per Kees Cook
>  - Moved prepare_slab_obj_exts_hook() and alloc_slab_obj_exts() where they
>    are used, per Vlastimil Babka
>  - Fixed SLAB_NO_OBJ_EXT definition to use unused bit, per Vlastimil Babka
>  - Refactored patch [4] into other patches, per Vlastimil Babka
>  - Replaced snprintf() with seq_buf_printf(), per Kees Cook
>  - Changed output to report bytes, per Andrew Morton and Pasha Tatashin
>  - Changed output to report [module] only for loadable modules,
>    per Vlastimil Babka
>  - Moved mem_alloc_profiling_enabled() check earlier, per Vlastimil Babka
>  - Changed the code to handle page splitting to be more understandable,
>    per Vlastimil Babka
>  - Moved alloc_tagging_slab_free_hook(), mark_objexts_empty(),
>    mark_failed_objexts_alloc() and handle_failed_objexts_alloc(),
>    per Vlastimil Babka
>  - Fixed loss of __alloc_size(1, 2) in kvmalloc functions,
>    per Vlastimil Babka
>  - Refactored the code in show_mem() to avoid memory allocations,
>    per Michal Hocko
>  - Changed to trylock in show_mem() to avoid blocking in atomic context,
>    per Tetsuo Handa
>  - Added mm mailing list into MAINTAINERS, per Kees Cook
>  - Added base commit SHA, per Andy Shevchenko
>  - Added a patch with documentation, per Jani Nikula
>  - Fixed 0day bugs
>  - Added benchmark results [5], per Steven Rostedt
>  - Rebased over Linux 6.8-rc5
> 
> Items not yet addressed:
>  - An early_boot option to prevent pageext overhead. We are looking into
>    ways for using the same sysctr instead of adding additional early boot
>    parameter.

I have reviewed the parts that integrate the tracking with page and slab
allocators, and besides some details to improve it seems ok to me. The
early boot option seems coming so that might eventually be suitable for
build-time enablement in a distro kernel.

The macros (and their potential spread to upper layers to keep the
information useful enough) are of course ugly, but guess it can't be
currently helped and I'm unable to decide whether it's worth it or not.
That's up to those providing their success stories I guess. If there's
at least a path ahead to replace that part with compiler support in the
future, great. So I'm not against merging this. BTW, do we know Linus's
opinion on the macros approach?

