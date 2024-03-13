Return-Path: <linux-fsdevel+bounces-14294-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6157987A98A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 15:35:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84C941C208A5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 14:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD424A11;
	Wed, 13 Mar 2024 14:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ebqOZkqA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="orfYLnID";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YR/kwdkQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="oK4wgZO5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B4517C8;
	Wed, 13 Mar 2024 14:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710340514; cv=none; b=oINsbf0kwrqo0k6484JkRIZC+6Aym91t2KtRTqFNU0/oD/KmzTQGF6JZP+ZhSGQoWtjksowP5ea1g4flCkB53L4haj9B3LP/B4sdrP0pJwhSX5EKCzH2buccZd0LN7LUYFWYct09CCSqxNw9jf9S4mzWJDcm5zbXUi4ULf9z/QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710340514; c=relaxed/simple;
	bh=7Ggb48mfmQd0gjOutcISKertiP5xCb7jo8IBrz/yYb4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ELaSWbQXY/6gTGHr5gueBuWiOJXFHtM7SQ15p9n0R03j5gPkO/WpyqDvZ/IiQYzfScWbhKmx3WThXnrOJq8usqkjpHGCL10kRviAqzTPwFM5CGVULBFKRhg6vYJlRQeAsWWMBZDP9ugUGN6rioZuUILyECno8NI8GItTA8O6gA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ebqOZkqA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=orfYLnID; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YR/kwdkQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=oK4wgZO5; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DBFE521C8A;
	Wed, 13 Mar 2024 14:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710340509; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2RSlYwqGCgMw8Oen4eBYJ9RLkQu5lewBFTm9qigzA78=;
	b=ebqOZkqAlbIlDLeZr4Wx03fKNo+nawtibfpLCg6+Q4I7xn3k08nxpk38v/9P/pN6HBlVLE
	3oN18aptixVZ5j+P5h72hzEUzaXWZ656RUhLV1KaVn/ULJrY+obEL6+u6Z0V2ret8kxkwt
	VHQD3v2is9dCEKZ3js1jUs5GFFcZTkw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710340509;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2RSlYwqGCgMw8Oen4eBYJ9RLkQu5lewBFTm9qigzA78=;
	b=orfYLnIDxWPQOxAfsZDtFE7rUGJ7oQQsqo0/Mtoyh5mM9gWh6I8HNu8RMZE5fyxkhzYb7o
	+afMySU81XMXiDCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710340508; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2RSlYwqGCgMw8Oen4eBYJ9RLkQu5lewBFTm9qigzA78=;
	b=YR/kwdkQ7oo6g7nxLjQEGunx8N1zRLdauP7333MQMKOmV37zmdpkCuHXpEOFHPrfAZFfGZ
	X549edAXo2lu//nDJxpSA2Qvk5PQ3E2f5gkbvL0/6Fyudo9p+tRUWFD7Ec0mUZvV7263xF
	b/I66AohdibWQLMZ4PTajURL7FkKLT8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710340508;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2RSlYwqGCgMw8Oen4eBYJ9RLkQu5lewBFTm9qigzA78=;
	b=oK4wgZO5wOrJ1EG1VHXjpbFCBihJFze1f72GbydqVyebG0uzplJ2FIO5uCcOLhU42giqBe
	aQInfrj0PvfH4GCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8145F13977;
	Wed, 13 Mar 2024 14:35:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WfP0Hpy58WX6YwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 13 Mar 2024 14:35:08 +0000
Message-ID: <ef836dd3-0b65-485e-84a2-dd5cb9ecdff1@suse.cz>
Date: Wed, 13 Mar 2024 15:35:53 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 15/37] lib: introduce early boot parameter to avoid
 page_ext memory overhead
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
 nathan@kernel.org, dennis@kernel.org, jhubbard@nvidia.com, tj@kernel.org,
 muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org,
 pasha.tatashin@soleen.com, yosryahmed@google.com, yuzhao@google.com,
 dhowells@redhat.com, hughd@google.com, andreyknvl@gmail.com,
 keescook@chromium.org, ndesaulniers@google.com, vvvvvv@google.com,
 gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, bristot@redhat.com, vschneid@redhat.com, cl@linux.com,
 penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com,
 glider@google.com, elver@google.com, dvyukov@google.com,
 songmuchun@bytedance.com, jbaron@akamai.com, aliceryhl@google.com,
 rientjes@google.com, minchan@google.com, kaleshsingh@google.com,
 kernel-team@android.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-modules@vger.kernel.org,
 kasan-dev@googlegroups.com, cgroups@vger.kernel.org
References: <20240306182440.2003814-1-surenb@google.com>
 <20240306182440.2003814-16-surenb@google.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20240306182440.2003814-16-surenb@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-1.59 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 URIBL_BLOCKED(0.00)[suse.cz:email];
	 MID_RHS_MATCH_FROM(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BAYES_HAM(-3.00)[100.00%];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_MATCH_ENVRCPT_SOME(0.00)[];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_GT_50(0.00)[75];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[linux.dev,suse.com,cmpxchg.org,suse.de,stgolabs.net,infradead.org,oracle.com,i-love.sakura.ne.jp,lwn.net,manifault.com,redhat.com,arm.com,kernel.org,arndb.de,linutronix.de,linux.intel.com,kernel.dk,nvidia.com,soleen.com,google.com,gmail.com,chromium.org,linuxfoundation.org,linaro.org,goodmis.org,linux.com,lge.com,bytedance.com,akamai.com,android.com,vger.kernel.org,lists.linux.dev,kvack.org,googlegroups.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Score: -1.59
X-Spam-Flag: NO

On 3/6/24 19:24, Suren Baghdasaryan wrote:
> The highest memory overhead from memory allocation profiling comes from
> page_ext objects. This overhead exists even if the feature is disabled
> but compiled-in. To avoid it, introduce an early boot parameter that
> prevents page_ext object creation. The new boot parameter is a tri-state
> with possible values of 0|1|never. When it is set to "never" the
> memory allocation profiling support is disabled, and overhead is minimized
> (currently no page_ext objects are allocated, in the future more overhead
> might be eliminated). As a result we also lose ability to enable memory
> allocation profiling at runtime (because there is no space to store
> alloctag references). Runtime sysctrl becomes read-only if the early boot
> parameter was set to "never". Note that the default value of this boot
> parameter depends on the CONFIG_MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT
> configuration. When CONFIG_MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT=n
> the boot parameter is set to "never", therefore eliminating any overhead.
> CONFIG_MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT=y results in boot parameter
> being set to 1 (enabled). This allows distributions to avoid any overhead
> by setting CONFIG_MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT=n config and
> with no changes to the kernel command line.
> We reuse sysctl.vm.mem_profiling boot parameter name in order to avoid
> introducing yet another control. This change turns it into a tri-state
> early boot parameter.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

