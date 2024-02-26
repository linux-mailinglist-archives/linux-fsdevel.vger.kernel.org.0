Return-Path: <linux-fsdevel+bounces-12842-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8CED867DDE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 18:16:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58DAA1F2941C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 17:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF98B136997;
	Mon, 26 Feb 2024 17:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lqm7Mvls";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="eRSBuzih";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ociJqUVZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="u94fmCMp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D6E12FB14;
	Mon, 26 Feb 2024 17:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708967279; cv=none; b=i/VU6hUKLGyiCpeNMkhrBBj34oHk9en+nNbLFxyPOBJkbiw/AurZSH/aMh3KB3JOMiAsXZO4zknC+0NIpy2/VA8ph1TqSQBITuQX072x63nN0sA9rJPtV9FZHfDk7Jqa/YTIddudaWNfswSgrvSm1KAx2HDgYKCWzzr8OLYckcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708967279; c=relaxed/simple;
	bh=Ghx+uTZbpHULPvh6J03M80Ievm3SPeqKg1tWQqLgkC0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VCG7T1KBwcBNBqyggVtI4P84natCsXV21woqOwUfhRxg0z5tZkeVynLJDFodFNbTQsj9RRYd6vjnm5l2wJtGgjoyrDSkpqlnyCNxmgSyxOR9drhm3SxyLHLNTnyTn2E4eg5pSLr6ifQU5angjI63Ymg3NGBer4j0FmUYanGDeFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lqm7Mvls; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=eRSBuzih; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ociJqUVZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=u94fmCMp; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EF93D22118;
	Mon, 26 Feb 2024 17:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708967275; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I/hQUuxQxkgRF4bShVLMfZoPBj+Cztno3mv4Ida72ys=;
	b=lqm7MvlsGMdOnV7A0DCBCbAnV9wVNi5sPkxcsjnwm2TAhHzd8yzvwP15LeL6zBp8IXkj5O
	prSheJklKGpTJ+aJQCX4tR4QzX2mn6cVUXIXWux9eBpu9v4ldmLgGy9ACqLYj6ubdQlNQI
	nEvhzpAuRiEYzN4D2nVMa8/AcLOqr4A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708967275;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I/hQUuxQxkgRF4bShVLMfZoPBj+Cztno3mv4Ida72ys=;
	b=eRSBuzihPxqq1qI7IGAwNDlGPDFZsp+5LrwDwZP3mNyRuPHOIwE5kJ1xirGZsg/vWFNFVY
	biRDN3OHE/W5sYAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708967274; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I/hQUuxQxkgRF4bShVLMfZoPBj+Cztno3mv4Ida72ys=;
	b=ociJqUVZaiwOnBmsJApQrVY4NKPWiDHcA5fWKOpgbgF8u/X37yRgEV03Je0LR/cpuUh4gg
	4xxXqFcnLMohgek80IiWqkkj7rgbHOiecdSK3MxD7nSEmhpghcM02lBglw3nANYNZPXew4
	93jPhYxYQ5w7D/TlaBV/VKqkou/DNe8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708967274;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I/hQUuxQxkgRF4bShVLMfZoPBj+Cztno3mv4Ida72ys=;
	b=u94fmCMpbUXFk4iD2JqDbDSQ8FuX0yXq4xZ/oLuHtIUtWTgurgpOaxcHwOU1mpLCtzWfcV
	BJbGD51qmCdM5gCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4DA5C13A58;
	Mon, 26 Feb 2024 17:07:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qbR1EmrF3GW7GgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 26 Feb 2024 17:07:54 +0000
Message-ID: <d6141a99-3409-447b-88ac-16c24b0a892e@suse.cz>
Date: Mon, 26 Feb 2024 18:07:53 +0100
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
 <20240221194052.927623-16-surenb@google.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20240221194052.927623-16-surenb@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ociJqUVZ;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=u94fmCMp
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
	 BAYES_HAM(-0.00)[43.76%];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_MATCH_ENVRCPT_SOME(0.00)[];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_GT_50(0.00)[74];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[linux.dev,suse.com,cmpxchg.org,suse.de,stgolabs.net,infradead.org,oracle.com,i-love.sakura.ne.jp,lwn.net,manifault.com,redhat.com,arm.com,kernel.org,arndb.de,linutronix.de,linux.intel.com,kernel.dk,soleen.com,google.com,gmail.com,chromium.org,linuxfoundation.org,linaro.org,goodmis.org,linux.com,lge.com,bytedance.com,akamai.com,android.com,vger.kernel.org,lists.linux.dev,kvack.org,googlegroups.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 1.20
X-Rspamd-Queue-Id: EF93D22118
X-Spam-Level: *
X-Spam-Flag: NO
X-Spamd-Bar: +

On 2/21/24 20:40, Suren Baghdasaryan wrote:
> Introduce helper functions to easily instrument page allocators by
> storing a pointer to the allocation tag associated with the code that
> allocated the page in a page_ext field.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Co-developed-by: Kent Overstreet <kent.overstreet@linux.dev>
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>

The static key usage seems fine now. Even if the page_ext overhead is still
always paid when compiled in, you mention in the cover letter there's a plan
for boot-time toggle later, so

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>



