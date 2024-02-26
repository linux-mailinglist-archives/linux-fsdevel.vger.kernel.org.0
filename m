Return-Path: <linux-fsdevel+bounces-12841-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DAA1867DA7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 18:11:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5344F28F1C9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 17:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E3413B780;
	Mon, 26 Feb 2024 16:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jcYeMA68";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Q/Xv00rl";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jcYeMA68";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Q/Xv00rl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A05412CD80;
	Mon, 26 Feb 2024 16:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708966724; cv=none; b=Bg1Al7HZv0geMoLMXmB5RwkGZUD/fGrp6EieEXLXR25gHV5Py7HNPjgsie7Cau42LdhGbWK+ikVkxIpQJq9CB8IqOVxWxXdRk3xF//UHOx8eYCnofiDkYMa/IQLgqujHFhs4WymtLXzCigP67GRV8hs+PSN4Z/unu+iwEGq0XFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708966724; c=relaxed/simple;
	bh=zYKjf9atYKOAZsSmpBw821yA+yGfcDbKYiZ1glrCtOI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p1EEw4B0UAuIfbsSrMdXwKXWtfNFNszn4PBc9ul1lqvz/u6YVpAF0Y2Z0JD7t6EBPRaOf3Qd2enCo+C7zF/VtqQBM6CTOHuREqbRZq2zCSF/56pboPuW45zMY4P03ostmsMc0u8hxoPj1DsXqLhk/4w+s5xMGL8RIxTH4/vtLGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jcYeMA68; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Q/Xv00rl; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jcYeMA68; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Q/Xv00rl; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 14138225F4;
	Mon, 26 Feb 2024 16:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708966721; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l0KFPjXNqVsEqy2ySF8st8aX9aaAa1NXHzLxm/9qX7E=;
	b=jcYeMA68fIDBke9G63XYDHgm8r7rC8tM+xa/Jd9ZUVyLmCWWjabOr3q1eQCqkPp8AXYygU
	B6gQn18Om2KAhCXe4PdV8gb9C03jZeMWnTF7c8/KmoT48mw5r5Fs8oh4z7Va22fcqWQo2R
	5nb3sre7bhuJCoZed92SVCBqLCLRheE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708966721;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l0KFPjXNqVsEqy2ySF8st8aX9aaAa1NXHzLxm/9qX7E=;
	b=Q/Xv00rlXZFJgefrppCuzXJpBCyRFGwXI/qhd56LD39Ty5Lx3SkyuS3agI9PXyjpcd844V
	kHbrGV8fBOAd1zCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708966721; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l0KFPjXNqVsEqy2ySF8st8aX9aaAa1NXHzLxm/9qX7E=;
	b=jcYeMA68fIDBke9G63XYDHgm8r7rC8tM+xa/Jd9ZUVyLmCWWjabOr3q1eQCqkPp8AXYygU
	B6gQn18Om2KAhCXe4PdV8gb9C03jZeMWnTF7c8/KmoT48mw5r5Fs8oh4z7Va22fcqWQo2R
	5nb3sre7bhuJCoZed92SVCBqLCLRheE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708966721;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l0KFPjXNqVsEqy2ySF8st8aX9aaAa1NXHzLxm/9qX7E=;
	b=Q/Xv00rlXZFJgefrppCuzXJpBCyRFGwXI/qhd56LD39Ty5Lx3SkyuS3agI9PXyjpcd844V
	kHbrGV8fBOAd1zCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6763713A58;
	Mon, 26 Feb 2024 16:58:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5Hq7GEDD3GUxGAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 26 Feb 2024 16:58:40 +0000
Message-ID: <a9ebb623-298d-4acf-bdd5-0025ccb70148@suse.cz>
Date: Mon, 26 Feb 2024 17:58:40 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 13/36] lib: prevent module unloading if memory is not
 freed
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
 <20240221194052.927623-14-surenb@google.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20240221194052.927623-14-surenb@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Bar: /
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=jcYeMA68;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="Q/Xv00rl"
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.73 / 50.00];
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
	 BAYES_HAM(-0.73)[83.74%];
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
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Score: -0.73
X-Rspamd-Queue-Id: 14138225F4
X-Spam-Flag: NO

On 2/21/24 20:40, Suren Baghdasaryan wrote:
> Skip freeing module's data section if there are non-zero allocation tags
> because otherwise, once these allocations are freed, the access to their
> code tag would cause UAF.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

I know that module unloading was never considered really supported etc.
But should we printk something so the admin knows why it didn't unload, and
can go check those outstanding allocations?


