Return-Path: <linux-fsdevel+bounces-13052-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F6786A9EF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 09:29:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18FE7B21724
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 08:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 218E32D052;
	Wed, 28 Feb 2024 08:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NTHWxN9u";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Kz7eaScw";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NTHWxN9u";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Kz7eaScw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C843A2C85D;
	Wed, 28 Feb 2024 08:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709108948; cv=none; b=eIAeC3k4+45qi57OEq9xN8rZzBHrAfJyWMA0lLYlJBojrAL5EgTJ7FJu9AVhLMGUK1krZ2/z6eZwqtoxGRqKDteMjoxXVBW1kKWOChurFQhoasfngZcivSw9A68SSMze5Y+NmNUJMnaPeiCeJmuQjH/0ziBcBmm7tNyXshd5e9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709108948; c=relaxed/simple;
	bh=GYCBTtrme1/vyEnFSZ2rmTOFHZ+wZlEBanSJsTMPw7k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qzvTWWEKkadSSN2la7glksoFtxMDGRZKWpa0TaqXJ/K5WJXwU8sAa+QFPuD65QRjSv3qlFE92SwUkgpk6Iek+ETGWulnmYrkzGoh6fxX62iFI3Mf9AlndtVIzsHUkbH9F8lSVjWt7fFDU72oH6aOv2DEP9oIQ3ceNRw6AjofDcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NTHWxN9u; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Kz7eaScw; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NTHWxN9u; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Kz7eaScw; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A0BAA2262E;
	Wed, 28 Feb 2024 08:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709108944; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+HoIz2Qi98NBEh6aNkVpIyLsbtr/CQMlELkE74c1McU=;
	b=NTHWxN9ulO5ErLuP4gcTOYnNmaQsCFQdtc5+CSvK1qSM6duhZPY03zDynWgiAr3Ps+/FqA
	I9d3Yq0J2sd+xQ93Bbt0VKJTHIHPgz9OCriSsPTHC/y6cg9TM45uXq8YWl7oELJG+97edo
	3NypH+V4B9bZ7Ul0xa2a80i+Xl0ZdXw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709108944;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+HoIz2Qi98NBEh6aNkVpIyLsbtr/CQMlELkE74c1McU=;
	b=Kz7eaScwzxbvWjw0SaPKEc7jGN/VEKGTH5sed6LnSIGKuhRPu/OyQw33mkVFtMRAcWoR62
	lF6+/G+iqvDQN5DQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709108944; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+HoIz2Qi98NBEh6aNkVpIyLsbtr/CQMlELkE74c1McU=;
	b=NTHWxN9ulO5ErLuP4gcTOYnNmaQsCFQdtc5+CSvK1qSM6duhZPY03zDynWgiAr3Ps+/FqA
	I9d3Yq0J2sd+xQ93Bbt0VKJTHIHPgz9OCriSsPTHC/y6cg9TM45uXq8YWl7oELJG+97edo
	3NypH+V4B9bZ7Ul0xa2a80i+Xl0ZdXw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709108944;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+HoIz2Qi98NBEh6aNkVpIyLsbtr/CQMlELkE74c1McU=;
	b=Kz7eaScwzxbvWjw0SaPKEc7jGN/VEKGTH5sed6LnSIGKuhRPu/OyQw33mkVFtMRAcWoR62
	lF6+/G+iqvDQN5DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1430F13A58;
	Wed, 28 Feb 2024 08:29:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IqSSBNDu3mWDHQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 28 Feb 2024 08:29:04 +0000
Message-ID: <1287d17e-9f9e-49a4-8db7-cf3bbbb15d02@suse.cz>
Date: Wed, 28 Feb 2024 09:29:03 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 14/36] lib: add allocation tagging support for memory
 allocation profiling
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
 <20240221194052.927623-15-surenb@google.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20240221194052.927623-15-surenb@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=NTHWxN9u;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Kz7eaScw
X-Spamd-Result: default: False [-2.41 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_GT_50(0.00)[74];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_MATCH_FROM(0.00)[];
	 BAYES_HAM(-2.11)[95.70%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCVD_DKIM_ARC_DNSWL_HI(-1.00)[];
	 FROM_HAS_DN(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 TO_MATCH_ENVRCPT_SOME(0.00)[];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FREEMAIL_CC(0.00)[linux.dev,suse.com,cmpxchg.org,suse.de,stgolabs.net,infradead.org,oracle.com,i-love.sakura.ne.jp,lwn.net,manifault.com,redhat.com,arm.com,kernel.org,arndb.de,linutronix.de,linux.intel.com,kernel.dk,soleen.com,google.com,gmail.com,chromium.org,linuxfoundation.org,linaro.org,goodmis.org,linux.com,lge.com,bytedance.com,akamai.com,android.com,vger.kernel.org,lists.linux.dev,kvack.org,googlegroups.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[];
	 RCVD_IN_DNSWL_HI(-0.50)[2a07:de40:b281:106:10:150:64:167:received]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: A0BAA2262E
X-Spam-Level: 
X-Spam-Score: -2.41
X-Spam-Flag: NO

On 2/21/24 20:40, Suren Baghdasaryan wrote:
> 
> +static inline void alloc_tag_sub(union codetag_ref *ref, size_t bytes)
> +{
> + __alloc_tag_sub(ref, bytes);
> +}
> +
> +static inline void alloc_tag_sub_noalloc(union codetag_ref *ref, size_t bytes)
> +{
> + __alloc_tag_sub(ref, bytes);
> +}
> +

Nit: just notice these are now the same and maybe you could just drop both
wrappers and rename __alloc_tag_sub to alloc_tag_sub?

