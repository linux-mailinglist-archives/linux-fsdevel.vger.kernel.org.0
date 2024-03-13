Return-Path: <linux-fsdevel+bounces-14295-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0CD87A9B2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 15:43:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE297B2348A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 14:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0987941744;
	Wed, 13 Mar 2024 14:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Nmf6Xm61";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="K5ptLFKk";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Nmf6Xm61";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="K5ptLFKk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98914A07;
	Wed, 13 Mar 2024 14:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710341012; cv=none; b=QBxoTDcuGJaUcekVQNqB0n0HzV2f/B9beE0lHAZX835I+avFjesQg1GSyIVdsXnill3pZt/jTdOmzp8sOWBu9kegYJ+a93eS1HowE8qjf7Zq5YBV01i+koKGv+IGPDIE3g6o4X0ahnlPYsrgL9AWxT4OnTRy4OWFs7h33P6PVFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710341012; c=relaxed/simple;
	bh=kXgYc6OgRfqOOlSMEkHcIMjENoa2xrghhi5222Y1ADk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HjjymBDsRXTrqRlaQPDget7KuR5FgQ5O7S8FsoAyoboLMzAN+aW/ONREdH3qFGoD15oE2PcnVMTs4tWUv5tYhLpMmon+5XhTXAcmpIvO2QpfcCUKR25ERlLNRRHmk9v73L0YP+WBmbj6HjPKVKy1NMXPOOf9USXiu8jXzSVLigE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Nmf6Xm61; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=K5ptLFKk; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Nmf6Xm61; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=K5ptLFKk; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B80CA21C91;
	Wed, 13 Mar 2024 14:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710341008; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O3ouuLw+tQrb8/EbRY+xlkqcLCuq786lUp+bYp4r2zU=;
	b=Nmf6Xm61+zxcWS+I5r9U+P3gPHU2vCbG7ufrhgetyuVBRCFoAAp+EoXhy5xUB5Tmutzepl
	7YmX4PfY5TaUAkjwOQpz9y+4LHQEPr3MY6QlMMsIFpMnXXofcmRb61UVwIlpEK3LPlPdr8
	EojUYmzwXu4oWcfNFWwBYddlMSbm8uY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710341008;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O3ouuLw+tQrb8/EbRY+xlkqcLCuq786lUp+bYp4r2zU=;
	b=K5ptLFKkA01m4S7ajiM2r/a218s+QmeM+PIHTAAq79pyoH1Wrn2NfXTQLwjdD9JNIp1I+B
	vI5NUhUMygRO1rDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710341008; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O3ouuLw+tQrb8/EbRY+xlkqcLCuq786lUp+bYp4r2zU=;
	b=Nmf6Xm61+zxcWS+I5r9U+P3gPHU2vCbG7ufrhgetyuVBRCFoAAp+EoXhy5xUB5Tmutzepl
	7YmX4PfY5TaUAkjwOQpz9y+4LHQEPr3MY6QlMMsIFpMnXXofcmRb61UVwIlpEK3LPlPdr8
	EojUYmzwXu4oWcfNFWwBYddlMSbm8uY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710341008;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O3ouuLw+tQrb8/EbRY+xlkqcLCuq786lUp+bYp4r2zU=;
	b=K5ptLFKkA01m4S7ajiM2r/a218s+QmeM+PIHTAAq79pyoH1Wrn2NfXTQLwjdD9JNIp1I+B
	vI5NUhUMygRO1rDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 73FB413977;
	Wed, 13 Mar 2024 14:43:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IMkYHJC78WXjZgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 13 Mar 2024 14:43:28 +0000
Message-ID: <76c84f17-8b99-4f68-a6ac-a0db22f5ace3@suse.cz>
Date: Wed, 13 Mar 2024 15:44:13 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 20/37] mm: fix non-compound multi-order memory
 accounting in __free_pages
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
 <20240306182440.2003814-21-surenb@google.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20240306182440.2003814-21-surenb@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Bar: /
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Nmf6Xm61;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=K5ptLFKk
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.03 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_GT_50(0.00)[75];
	 NEURAL_HAM_SHORT(-0.20)[-0.999];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_MATCH_FROM(0.00)[];
	 BAYES_HAM(-0.03)[56.09%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_MATCH_ENVRCPT_SOME(0.00)[];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FREEMAIL_CC(0.00)[linux.dev,suse.com,cmpxchg.org,suse.de,stgolabs.net,infradead.org,oracle.com,i-love.sakura.ne.jp,lwn.net,manifault.com,redhat.com,arm.com,kernel.org,arndb.de,linutronix.de,linux.intel.com,kernel.dk,nvidia.com,soleen.com,google.com,gmail.com,chromium.org,linuxfoundation.org,linaro.org,goodmis.org,linux.com,lge.com,bytedance.com,akamai.com,android.com,vger.kernel.org,lists.linux.dev,kvack.org,googlegroups.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Score: -0.03
X-Rspamd-Queue-Id: B80CA21C91
X-Spam-Flag: NO



On 3/6/24 19:24, Suren Baghdasaryan wrote:
> When a non-compound multi-order page is freed, it is possible that a
> speculative reference keeps the page pinned. In this case we free all
> pages except for the first page, which will be freed later by the last
> put_page(). However put_page() ignores the order of the page being freed,
> treating it as a 0-order page. This creates a memory accounting imbalance
> because the pages freed in __free_pages() do not have their own alloc_tag
> and their memory was accounted to the first page. To fix this the first
> page should adjust its allocation size counter when "tail" pages are freed.
> 
> Reported-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

