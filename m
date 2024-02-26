Return-Path: <linux-fsdevel+bounces-12839-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D83A7867D00
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 17:58:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D91328D55C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 16:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36AD012EBFA;
	Mon, 26 Feb 2024 16:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="SC1Y7gg5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="DP8JmlMt";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="SC1Y7gg5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="DP8JmlMt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A37130E54;
	Mon, 26 Feb 2024 16:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708966431; cv=none; b=P6OlsTF4rModqLYMUJKYbB/t3D7G+a5R2SRzobxUoBsJAHWguvMM1tU2/rxINVr8Wt5ZxmaPjzsnulO4+mu7TQpvxkXuMigJUUVcBZUqG9/h3KdtSM4gjYpsJCGhJPFaU4QxXk2fiVBbMNQ7+q3gDw8W/ZLfs7F6/H7/ZCmk9XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708966431; c=relaxed/simple;
	bh=MardUWIsmATEFKuh2wT2c1olpb4/Ho/XLdLxS4S1UFw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eUK85t8z1/g/oaf+ENZM212t/n9YgeKwa7G9mGFp32mFfQgwf0xo1a1HSMBUmWYW31I6WllZVZhjnKnOwOGtG3Dv93FQy92fZpo8ibB9cju4CQonLBcIV/RbmrOuQOiZHsk8L14mgr4t150ZV/FDZZ04zsmSLC7oGQ79yShDUpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=SC1Y7gg5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=DP8JmlMt; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=SC1Y7gg5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=DP8JmlMt; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 83DC61FB5E;
	Mon, 26 Feb 2024 16:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708966427; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MgS/hvgxhSITdk7Ky5kATehTNmll0NfOjHtx26rdj8w=;
	b=SC1Y7gg5QXG1RWGqgXzNKCkOz8jPKpuj/x6TjPWa8IGN9RLI+3dktUTdFANCKO0rZbBLxq
	BW0KbR0x/ICg3txrKimd5S5/9kGkfBHYFKR3TQ4A0A3NuBE/63gIAiMRDQJZ4yU3gmKLcK
	vqPk9PorpQ5yg7PGad8rMnmzf5GJJpI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708966427;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MgS/hvgxhSITdk7Ky5kATehTNmll0NfOjHtx26rdj8w=;
	b=DP8JmlMtfZcmpcKO0tD6mnWB1fho5gzEMOcSqXzjdfyn/BRtS8fTGzZYy+GrUCIxD17X+w
	yCHYsByOXT8FocBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708966427; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MgS/hvgxhSITdk7Ky5kATehTNmll0NfOjHtx26rdj8w=;
	b=SC1Y7gg5QXG1RWGqgXzNKCkOz8jPKpuj/x6TjPWa8IGN9RLI+3dktUTdFANCKO0rZbBLxq
	BW0KbR0x/ICg3txrKimd5S5/9kGkfBHYFKR3TQ4A0A3NuBE/63gIAiMRDQJZ4yU3gmKLcK
	vqPk9PorpQ5yg7PGad8rMnmzf5GJJpI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708966427;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MgS/hvgxhSITdk7Ky5kATehTNmll0NfOjHtx26rdj8w=;
	b=DP8JmlMtfZcmpcKO0tD6mnWB1fho5gzEMOcSqXzjdfyn/BRtS8fTGzZYy+GrUCIxD17X+w
	yCHYsByOXT8FocBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F076813A58;
	Mon, 26 Feb 2024 16:53:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id g9dZOhrC3GXKFgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 26 Feb 2024 16:53:46 +0000
Message-ID: <fd480d2f-01bd-4658-b1b2-bf78383496f6@suse.cz>
Date: Mon, 26 Feb 2024 17:53:46 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/36] slab: objext: introduce objext_flags as
 extension to page_memcg_data_flags
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
 <20240221194052.927623-11-surenb@google.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20240221194052.927623-11-surenb@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=SC1Y7gg5;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=DP8JmlMt
X-Spamd-Result: default: False [-0.28 / 50.00];
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
	 BAYES_HAM(-1.48)[91.52%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_MATCH_ENVRCPT_SOME(0.00)[];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,chromium.org:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FREEMAIL_CC(0.00)[linux.dev,suse.com,cmpxchg.org,suse.de,stgolabs.net,infradead.org,oracle.com,i-love.sakura.ne.jp,lwn.net,manifault.com,redhat.com,arm.com,kernel.org,arndb.de,linutronix.de,linux.intel.com,kernel.dk,soleen.com,google.com,gmail.com,chromium.org,linuxfoundation.org,linaro.org,goodmis.org,linux.com,lge.com,bytedance.com,akamai.com,android.com,vger.kernel.org,lists.linux.dev,kvack.org,googlegroups.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -0.28
X-Rspamd-Queue-Id: 83DC61FB5E
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Bar: /

On 2/21/24 20:40, Suren Baghdasaryan wrote:
> Introduce objext_flags to store additional objext flags unrelated to memcg.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>


