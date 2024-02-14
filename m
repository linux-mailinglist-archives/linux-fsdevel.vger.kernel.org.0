Return-Path: <linux-fsdevel+bounces-11565-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C278854C5F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 16:15:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8AEE1C27D09
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 15:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4EFA5D91D;
	Wed, 14 Feb 2024 15:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gU3rk2X2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="IhXF164r";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gU3rk2X2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="IhXF164r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBAA5D47E;
	Wed, 14 Feb 2024 15:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707923641; cv=none; b=GtseO/qmO2P4QhzBRM22oov5sfsjHS+8diV7W1V0Ppt6MAVkdZ3g2HAeRrqtPoTzASTpqwe082aB25XH9GF9GY4ozcsKEWZgo62d0pyH2UVkqTpzu3nhEb3SXZA45E4UcEbDtR6tH56RK9ooskojuoNk3GqgFu5jQvxPlRxAR1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707923641; c=relaxed/simple;
	bh=7rqAA2OMkjlzZfzF2L7LpXxjv4CH2lahcs7k59r/a/U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BLDk53poI7fyyqHnhiOuajUVxqa3QwRLdhU8pZwy5cVMSz6VpmzdPqUR0P5IVfWS1MSY0ErWQNEsovp6TbOQPBCZK7bNVrcYq9FiystKCG8mL39PKFDpLtsYZfPdl5XClEGB09WZzq5uHHd7gK+mAXaLYtbw/5l8c4uLWF3mzho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gU3rk2X2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=IhXF164r; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gU3rk2X2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=IhXF164r; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5D70A220DD;
	Wed, 14 Feb 2024 15:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707923637; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tikF5ShYKbO2WOghBk9vtGAaaUgiPj3VsQTjyNrj1PE=;
	b=gU3rk2X2NEJX4Fh9fwdAFML7uiHJwPY6ADIvA28KKNY/2Z7m2rh+DZBQYUGyaSSqjBp0Nk
	j9kuonCsfIAslBIukjceFCBUO5tqnhYhJHks6m+XMV8pC11+/ehOtDt2i/K1HEEXk/7AwU
	Cka2ujVNvF+539lMChG2VJsssRfRCPQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707923637;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tikF5ShYKbO2WOghBk9vtGAaaUgiPj3VsQTjyNrj1PE=;
	b=IhXF164rhLv5W/+NathAC18BJymcHAqy5xAL15E8/dUk8X8AocBsujmKILSINsYmD8QYgi
	+u8unfWWkL1AV6BA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707923637; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tikF5ShYKbO2WOghBk9vtGAaaUgiPj3VsQTjyNrj1PE=;
	b=gU3rk2X2NEJX4Fh9fwdAFML7uiHJwPY6ADIvA28KKNY/2Z7m2rh+DZBQYUGyaSSqjBp0Nk
	j9kuonCsfIAslBIukjceFCBUO5tqnhYhJHks6m+XMV8pC11+/ehOtDt2i/K1HEEXk/7AwU
	Cka2ujVNvF+539lMChG2VJsssRfRCPQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707923637;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tikF5ShYKbO2WOghBk9vtGAaaUgiPj3VsQTjyNrj1PE=;
	b=IhXF164rhLv5W/+NathAC18BJymcHAqy5xAL15E8/dUk8X8AocBsujmKILSINsYmD8QYgi
	+u8unfWWkL1AV6BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 352AA13A6D;
	Wed, 14 Feb 2024 15:13:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BizkC7TYzGVnIQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 14 Feb 2024 15:13:56 +0000
Message-ID: <6370b20f-96fb-4918-bef0-7555563c9ce2@suse.cz>
Date: Wed, 14 Feb 2024 16:13:55 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 23/35] mm/slub: Mark slab_free_freelist_hook()
 __always_inline
Content-Language: en-US
To: Kent Overstreet <kent.overstreet@linux.dev>,
 Kees Cook <keescook@chromium.org>
Cc: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
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
 hughd@google.com, andreyknvl@gmail.com, ndesaulniers@google.com,
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
References: <20240212213922.783301-1-surenb@google.com>
 <20240212213922.783301-24-surenb@google.com> <202402121631.5954CFB@keescook>
 <3xhfgmrlktq55aggiy2beupy6hby33voxl65hqqxz55tivdbbi@j66oaehpauhz>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <3xhfgmrlktq55aggiy2beupy6hby33voxl65hqqxz55tivdbbi@j66oaehpauhz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=gU3rk2X2;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=IhXF164r
X-Spamd-Result: default: False [-0.48 / 50.00];
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
	 BAYES_HAM(-0.18)[70.21%];
	 RCVD_DKIM_ARC_DNSWL_HI(-1.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_MATCH_ENVRCPT_SOME(0.00)[];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_GT_50(0.00)[73];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[google.com,linux-foundation.org,suse.com,cmpxchg.org,linux.dev,suse.de,stgolabs.net,infradead.org,oracle.com,lwn.net,manifault.com,redhat.com,arm.com,kernel.org,arndb.de,linutronix.de,linux.intel.com,kernel.dk,soleen.com,gmail.com,linuxfoundation.org,linaro.org,goodmis.org,linux.com,lge.com,bytedance.com,akamai.com,android.com,vger.kernel.org,lists.linux.dev,kvack.org,googlegroups.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[];
	 RCVD_IN_DNSWL_HI(-0.50)[2a07:de40:b281:106:10:150:64:167:received]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -0.48
X-Rspamd-Queue-Id: 5D70A220DD
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Bar: /

On 2/13/24 03:08, Kent Overstreet wrote:
> On Mon, Feb 12, 2024 at 04:31:14PM -0800, Kees Cook wrote:
>> On Mon, Feb 12, 2024 at 01:39:09PM -0800, Suren Baghdasaryan wrote:
>> > From: Kent Overstreet <kent.overstreet@linux.dev>
>> > 
>> > It seems we need to be more forceful with the compiler on this one.
>> 
>> Sure, but why?
> 
> Wasn't getting inlined without it, and that's one we do want inlined -
> it's only called in one place.

It would be better to mention this in the changelog so it's clear this is
for performance and not e.g. needed for the code tagging to work as expected.

