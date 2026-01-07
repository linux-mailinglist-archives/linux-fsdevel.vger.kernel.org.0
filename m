Return-Path: <linux-fsdevel+bounces-72612-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE9C6CFD9D4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 07 Jan 2026 13:21:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3EEE7303C285
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jan 2026 12:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59CF13128B4;
	Wed,  7 Jan 2026 12:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="WbN1bj2N";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="WbN1bj2N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AB331196C
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Jan 2026 12:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767788347; cv=none; b=IMFuuw0VX/RrjQ3xS552iNn3bBQcxTc7DqKIZR84AK2u9BRK0+OzYKboyc00RDrXAqg6pwuViy7bK39Uh+PmTwUUAd4a5nLbXAnD1LFPeYPwxstXyTlKrbHAhzPrC6HlesRPViy73PrC4vsrPbPVkoJHt7uCwgnsR2L5YFNzY1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767788347; c=relaxed/simple;
	bh=sTLeg0ybqfF1wLs66ayDecTEEDhJwRX25f1F6Ysfh+o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gg8Il/ZacOzvQyT3jRHcYfz5LZyW3Lvxk4D+02fLjMl3Ol86fzWkQ4RXNtxrZ5ph2hGxZL5IQbfn1JMXO5fZSWT0ybnKKk4UKA8sypxSBYhSAfSlm8jYlxhC0hIiROw3wa+dogm9jR6MRcBtwmFxO83EeBT4L1ZX9GrMsiyj4nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=WbN1bj2N; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=WbN1bj2N; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 68B9E33D86;
	Wed,  7 Jan 2026 12:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1767788342; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1InH04BUhqu6lMlLWmyVtPrVr0o1jtu64a/MC1vmWxY=;
	b=WbN1bj2NvmY+V7Jbi20SxuPQ/UHWer8r4OTn44HlYNZmRxL49sd5CkaVo8uYo4gmuSSJ0J
	BbG+fRPzp1IReqgI6ZW/1fIGwbhzwQBSSzSEChftWtxrh9efKEwtUAeT4Yl3KXbLVAQYtU
	i+p23blbGZYpxaaQSFnTz0TZ5Vu09JQ=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=WbN1bj2N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1767788342; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1InH04BUhqu6lMlLWmyVtPrVr0o1jtu64a/MC1vmWxY=;
	b=WbN1bj2NvmY+V7Jbi20SxuPQ/UHWer8r4OTn44HlYNZmRxL49sd5CkaVo8uYo4gmuSSJ0J
	BbG+fRPzp1IReqgI6ZW/1fIGwbhzwQBSSzSEChftWtxrh9efKEwtUAeT4Yl3KXbLVAQYtU
	i+p23blbGZYpxaaQSFnTz0TZ5Vu09JQ=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F2AF53EA63;
	Wed,  7 Jan 2026 12:19:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id auvPOjRPXmnfRAAAD6G6ig
	(envelope-from <petr.pavlu@suse.com>); Wed, 07 Jan 2026 12:19:00 +0000
Message-ID: <7afb6666-43b6-4d17-b875-e585c7a5ac99@suse.com>
Date: Wed, 7 Jan 2026 13:19:00 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 34/42] dept: add module support for struct
 dept_event_site and dept_event_site_dep
To: Byungchul Park <byungchul@sk.com>
Cc: kernel_team@skhynix.com, torvalds@linux-foundation.org,
 damien.lemoal@opensource.wdc.com, linux-ide@vger.kernel.org,
 adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, mingo@redhat.com,
 peterz@infradead.org, will@kernel.org, tglx@linutronix.de,
 rostedt@goodmis.org, joel@joelfernandes.org, sashal@kernel.org,
 daniel.vetter@ffwll.ch, duyuyang@gmail.com, johannes.berg@intel.com,
 tj@kernel.org, tytso@mit.edu, willy@infradead.org, david@fromorbit.com,
 amir73il@gmail.com, gregkh@linuxfoundation.org, kernel-team@lge.com,
 linux-mm@kvack.org, akpm@linux-foundation.org, mhocko@kernel.org,
 minchan@kernel.org, hannes@cmpxchg.org, vdavydov.dev@gmail.com,
 sj@kernel.org, jglisse@redhat.com, dennis@kernel.org, cl@linux.com,
 penberg@kernel.org, rientjes@google.com, vbabka@suse.cz, ngupta@vflare.org,
 linux-block@vger.kernel.org, josef@toxicpanda.com,
 linux-fsdevel@vger.kernel.org, jack@suse.cz, jlayton@kernel.org,
 dan.j.williams@intel.com, hch@infradead.org, djwong@kernel.org,
 dri-devel@lists.freedesktop.org, rodrigosiqueiramelo@gmail.com,
 melissa.srw@gmail.com, hamohammed.sa@gmail.com, harry.yoo@oracle.com,
 chris.p.wilson@intel.com, gwan-gyeong.mun@intel.com,
 max.byungchul.park@gmail.com, boqun.feng@gmail.com, longman@redhat.com,
 yunseong.kim@ericsson.com, ysk@kzalloc.com, yeoreum.yun@arm.com,
 netdev@vger.kernel.org, matthew.brost@intel.com, her0gyugyu@gmail.com,
 corbet@lwn.net, catalin.marinas@arm.com, bp@alien8.de, x86@kernel.org,
 hpa@zytor.com, luto@kernel.org, sumit.semwal@linaro.org,
 gustavo@padovan.org, christian.koenig@amd.com, andi.shyti@kernel.org,
 arnd@arndb.de, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 rppt@kernel.org, surenb@google.com, mcgrof@kernel.org, da.gomez@kernel.org,
 samitolvanen@google.com, paulmck@kernel.org, frederic@kernel.org,
 neeraj.upadhyay@kernel.org, joelagnelf@nvidia.com, josh@joshtriplett.org,
 urezki@gmail.com, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
 qiang.zhang@linux.dev, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
 vschneid@redhat.com, chuck.lever@oracle.com, neil@brown.name,
 okorniev@redhat.com, Dai.Ngo@oracle.com, tom@talpey.com, trondmy@kernel.org,
 anna@kernel.org, kees@kernel.org, bigeasy@linutronix.de,
 clrkwllms@kernel.org, mark.rutland@arm.com, ada.coupriediaz@arm.com,
 kristina.martsenko@arm.com, wangkefeng.wang@huawei.com, broonie@kernel.org,
 kevin.brodsky@arm.com, dwmw@amazon.co.uk, shakeel.butt@linux.dev,
 ast@kernel.org, ziy@nvidia.com, yuzhao@google.com,
 baolin.wang@linux.alibaba.com, usamaarif642@gmail.com,
 joel.granados@kernel.org, richard.weiyang@gmail.com,
 geert+renesas@glider.be, tim.c.chen@linux.intel.com, linux@treblig.org,
 alexander.shishkin@linux.intel.com, lillian@star-ark.net,
 chenhuacai@kernel.org, francesco@valla.it, guoweikang.kernel@gmail.com,
 link@vivo.com, jpoimboe@kernel.org, masahiroy@kernel.org,
 brauner@kernel.org, thomas.weissschuh@linutronix.de, oleg@redhat.com,
 mjguzik@gmail.com, andrii@kernel.org, wangfushuai@baidu.com,
 linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 linux-i2c@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-modules@vger.kernel.org, rcu@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 2407018371@qq.com, dakr@kernel.org, miguel.ojeda.sandonis@gmail.com,
 neilb@ownmail.net, bagasdotme@gmail.com, wsa+renesas@sang-engineering.com,
 dave.hansen@intel.com, geert@linux-m68k.org, ojeda@kernel.org,
 alex.gaynor@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
 lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com,
 tmgross@umich.edu, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251205071855.72743-1-byungchul@sk.com>
 <20251205071855.72743-35-byungchul@sk.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20251205071855.72743-35-byungchul@sk.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	FORGED_RECIPIENTS(2.00)[m:byungchul@sk.com,m:kernel_team@skhynix.com,m:torvalds@linux-foundation.org,m:damien.lemoal@opensource.wdc.com,m:adilger.kernel@dilger.ca,m:mingo@redhat.com,m:peterz@infradead.org,m:will@kernel.org,m:tglx@linutronix.de,m:rostedt@goodmis.org,m:joel@joelfernandes.org,m:sashal@kernel.org,m:daniel.vetter@ffwll.ch,m:duyuyang@gmail.com,m:johannes.berg@intel.com,m:tj@kernel.org,m:tytso@mit.edu,m:willy@infradead.org,m:david@fromorbit.com,m:amir73il@gmail.com,m:gregkh@linuxfoundation.org,m:kernel-team@lge.com,m:linux-mm@kvack.org,m:akpm@linux-foundation.org,m:mhocko@kernel.org,m:minchan@kernel.org,m:hannes@cmpxchg.org,m:vdavydov.dev@gmail.com,m:sj@kernel.org,m:jglisse@redhat.com,m:dennis@kernel.org,m:cl@linux.com,m:penberg@kernel.org,m:rientjes@google.com,m:vbabka@suse.cz,m:ngupta@vflare.org,m:josef@toxicpanda.com,m:jack@suse.cz,m:jlayton@kernel.org,m:dan.j.williams@intel.com,m:hch@infradead.org,m:djwong@kernel.org,m:dri-devel@lists.freedesktop.org,m:rodrigosiqueiram
 elo@gmail.com,m:melissa.srw@gmail.com,m:hamohammed.sa@gmail.com,m:harry.yoo@oracle.com,m:chris.p.wilson@intel.com,m:gwan-gyeong.mun@intel.com,m:max.byungchul.park@gmail.com,m:boqun.feng@gmail.com,m:longman@redhat.com,m:yunseong.kim@ericsson.com,m:ysk@kzalloc.com,m:yeoreum.yun@arm.com,m:matthew.brost@intel.com,m:her0gyugyu@gmail.com,m:corbet@lwn.net,m:catalin.marinas@arm.com,m:bp@alien8.de,m:x86@kernel.org,m:luto@kernel.org,m:sumit.semwal@linaro.org,m:gustavo@padovan.org,m:christian.koenig@amd.com,m:andi.shyti@kernel.org,m:arnd@arndb.de,m:lorenzo.stoakes@oracle.com,m:Liam.Howlett@oracle.com,m:rppt@kernel.org,m:surenb@google.com,m:mcgrof@kernel.org,m:da.gomez@kernel.org,m:samitolvanen@google.com,m:paulmck@kernel.org,m:frederic@kernel.org,m:neeraj.upadhyay@kernel.org,m:joelagnelf@nvidia.com,m:josh@joshtriplett.org,m:urezki@gmail.com,m:mathieu.desnoyers@efficios.com,m:jiangshanlai@gmail.com,m:qiang.zhang@linux.dev,m:juri.lelli@redhat.com,m:vincent.guittot@linaro.org,m:dietmar.eggemann@a
 rm.com,m:bsegall@google.com,m:mgorman@suse.de,m:vschneid@redhat.com,m:chuck.lever@oracle.com,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,s:linux-doc@vger.kernel.org,s:linux-i2c@vger.kernel.org,s:linux-kernel@vger.kernel.org,s:linux-media@vger.kernel.org,s:linux-modules@vger.kernel.org,s:linux-nfs@vger.kernel.org,s:rcu@vger.kernel.org,s:rust-for-linux@vger.kernel.org,s:link@vivo.com];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCPT_COUNT_GT_50(0.00)[165];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FREEMAIL_CC(0.00)[skhynix.com,linux-foundation.org,opensource.wdc.com,vger.kernel.org,dilger.ca,redhat.com,infradead.org,kernel.org,linutronix.de,goodmis.org,joelfernandes.org,ffwll.ch,gmail.com,intel.com,mit.edu,fromorbit.com,linuxfoundation.org,lge.com,kvack.org,cmpxchg.org,linux.com,google.com,suse.cz,vflare.org,toxicpanda.com,lists.freedesktop.org,oracle.com,ericsson.com,kzalloc.com,arm.com,lwn.net,alien8.de,zytor.com,linaro.org,padovan.org,amd.com,arndb.de,nvidia.com,joshtriplett.org,efficios.com,linux.dev,suse.de,brown.name,talpey.com,huawei.com,amazon.co.uk,linux.alibaba.com,glider.be,linux.intel.com,treblig.org,star-ark.net,valla.it,vivo.com,baidu.com,lists.infradead.org,lists.linaro.org,lists.linux.dev,qq.com,ownmail.net,sang-engineering.com,linux-m68k.org,garyguo.net,protonmail.com,umich.edu];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[renesas];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,sk.com:email,suse.com:dkim,suse.com:mid]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Queue-Id: 68B9E33D86
X-Spam-Flag: NO
X-Spam-Score: -1.01

On 12/5/25 8:18 AM, Byungchul Park wrote:
> struct dept_event_site and struct dept_event_site_dep have been
> introduced to track dependencies between multi event sites for a single
> wait, that will be loaded to data segment.  Plus, a custom section,
> '.dept.event_sites', also has been introduced to keep pointers to the
> objects to make sure all the event sites defined exist in code.
> 
> dept should work with the section and segment of module.  Add the
> support to handle the section and segment properly whenever modules are
> loaded and unloaded.
> 
> Signed-off-by: Byungchul Park <byungchul@sk.com>

Below are a few comments from the module loader perspective.

> ---
>  include/linux/dept.h     | 14 +++++++
>  include/linux/module.h   |  5 +++
>  kernel/dependency/dept.c | 79 +++++++++++++++++++++++++++++++++++-----
>  kernel/module/main.c     | 15 ++++++++
>  4 files changed, 103 insertions(+), 10 deletions(-)
> 
> diff --git a/include/linux/dept.h b/include/linux/dept.h
> index 44083e6651ab..c796cdceb04e 100644
> --- a/include/linux/dept.h
> +++ b/include/linux/dept.h
> @@ -166,6 +166,11 @@ struct dept_event_site {
>  	struct dept_event_site		*bfs_parent;
>  	struct list_head		bfs_node;
>  
> +	/*
> +	 * for linking all dept_event_site's
> +	 */
> +	struct list_head		all_node;
> +
>  	/*
>  	 * flag indicating the event is not only declared but also
>  	 * actually used in code
> @@ -182,6 +187,11 @@ struct dept_event_site_dep {
>  	 */
>  	struct list_head		dep_node;
>  	struct list_head		dep_rev_node;
> +
> +	/*
> +	 * for linking all dept_event_site_dep's
> +	 */
> +	struct list_head		all_node;
>  };
>  
>  #define DEPT_EVENT_SITE_INITIALIZER(es)					\
> @@ -193,6 +203,7 @@ struct dept_event_site_dep {
>  	.bfs_gen = 0,							\
>  	.bfs_parent = NULL,						\
>  	.bfs_node = LIST_HEAD_INIT((es).bfs_node),			\
> +	.all_node = LIST_HEAD_INIT((es).all_node),			\
>  	.used = false,							\
>  }
>  
> @@ -202,6 +213,7 @@ struct dept_event_site_dep {
>  	.recover_site = NULL,						\
>  	.dep_node = LIST_HEAD_INIT((esd).dep_node),			\
>  	.dep_rev_node = LIST_HEAD_INIT((esd).dep_rev_node),		\
> +	.all_node = LIST_HEAD_INIT((esd).all_node),			\
>  }
>  
>  struct dept_event_site_init {
> @@ -225,6 +237,7 @@ extern void dept_init(void);
>  extern void dept_task_init(struct task_struct *t);
>  extern void dept_task_exit(struct task_struct *t);
>  extern void dept_free_range(void *start, unsigned int sz);
> +extern void dept_mark_event_site_used(void *start, void *end);

Nit: The coding style recommends not using the extern keyword with
function declarations.

https://www.kernel.org/doc/html/v6.19-rc4/process/coding-style.html#function-prototypes

>  
>  extern void dept_map_init(struct dept_map *m, struct dept_key *k, int sub_u, const char *n);
>  extern void dept_map_reinit(struct dept_map *m, struct dept_key *k, int sub_u, const char *n);
> @@ -288,6 +301,7 @@ struct dept_event_site { };
>  #define dept_task_init(t)				do { } while (0)
>  #define dept_task_exit(t)				do { } while (0)
>  #define dept_free_range(s, sz)				do { } while (0)
> +#define dept_mark_event_site_used(s, e)			do { } while (0)
>  
>  #define dept_map_init(m, k, su, n)			do { (void)(n); (void)(k); } while (0)
>  #define dept_map_reinit(m, k, su, n)			do { (void)(n); (void)(k); } while (0)
> diff --git a/include/linux/module.h b/include/linux/module.h
> index d80c3ea57472..29885ba91951 100644
> --- a/include/linux/module.h
> +++ b/include/linux/module.h
> @@ -29,6 +29,7 @@
>  #include <linux/srcu.h>
>  #include <linux/static_call_types.h>
>  #include <linux/dynamic_debug.h>
> +#include <linux/dept.h>
>  
>  #include <linux/percpu.h>
>  #include <asm/module.h>
> @@ -588,6 +589,10 @@ struct module {
>  #ifdef CONFIG_DYNAMIC_DEBUG_CORE
>  	struct _ddebug_info dyndbg_info;
>  #endif
> +#ifdef CONFIG_DEPT
> +	struct dept_event_site **dept_event_sites;
> +	unsigned int num_dept_event_sites;
> +#endif
>  } ____cacheline_aligned __randomize_layout;
>  #ifndef MODULE_ARCH_INIT
>  #define MODULE_ARCH_INIT {}

My understanding is that entries in the .dept.event_sites section are
added by the dept_event_site_used() macro and they are pointers to the
dept_event_site_init struct, not dept_event_site.

> diff --git a/kernel/dependency/dept.c b/kernel/dependency/dept.c
> index b14400c4f83b..07d883579269 100644
> --- a/kernel/dependency/dept.c
> +++ b/kernel/dependency/dept.c
> @@ -984,6 +984,9 @@ static void bfs(void *root, struct bfs_ops *ops, void *in, void **out)
>   * event sites.
>   */
>  
> +static LIST_HEAD(dept_event_sites);
> +static LIST_HEAD(dept_event_site_deps);
> +
>  /*
>   * Print all events in the circle.
>   */
> @@ -2043,6 +2046,33 @@ static void del_dep_rcu(struct rcu_head *rh)
>  	preempt_enable();
>  }
>  
> +/*
> + * NOTE: Must be called with dept_lock held.
> + */
> +static void disconnect_event_site_dep(struct dept_event_site_dep *esd)
> +{
> +	list_del_rcu(&esd->dep_node);
> +	list_del_rcu(&esd->dep_rev_node);
> +}
> +
> +/*
> + * NOTE: Must be called with dept_lock held.
> + */
> +static void disconnect_event_site(struct dept_event_site *es)
> +{
> +	struct dept_event_site_dep *esd, *next_esd;
> +
> +	list_for_each_entry_safe(esd, next_esd, &es->dep_head, dep_node) {
> +		list_del_rcu(&esd->dep_node);
> +		list_del_rcu(&esd->dep_rev_node);
> +	}
> +
> +	list_for_each_entry_safe(esd, next_esd, &es->dep_rev_head, dep_rev_node) {
> +		list_del_rcu(&esd->dep_node);
> +		list_del_rcu(&esd->dep_rev_node);
> +	}
> +}
> +
>  /*
>   * NOTE: Must be called with dept_lock held.
>   */
> @@ -2384,6 +2414,8 @@ void dept_free_range(void *start, unsigned int sz)
>  {
>  	struct dept_task *dt = dept_task();
>  	struct dept_class *c, *n;
> +	struct dept_event_site_dep *esd, *next_esd;
> +	struct dept_event_site *es, *next_es;
>  	unsigned long flags;
>  
>  	if (unlikely(!dept_working()))
> @@ -2405,6 +2437,24 @@ void dept_free_range(void *start, unsigned int sz)
>  	while (unlikely(!dept_lock()))
>  		cpu_relax();
>  
> +	list_for_each_entry_safe(esd, next_esd, &dept_event_site_deps, all_node) {
> +		if (!within((void *)esd, start, sz))
> +			continue;
> +
> +		disconnect_event_site_dep(esd);
> +		list_del(&esd->all_node);
> +	}
> +
> +	list_for_each_entry_safe(es, next_es, &dept_event_sites, all_node) {
> +		if (!within((void *)es, start, sz) &&
> +		    !within(es->name, start, sz) &&
> +		    !within(es->func_name, start, sz))
> +			continue;
> +
> +		disconnect_event_site(es);
> +		list_del(&es->all_node);
> +	}
> +
>  	list_for_each_entry_safe(c, n, &dept_classes, all_node) {
>  		if (!within((void *)c->key, start, sz) &&
>  		    !within(c->name, start, sz))
> @@ -3337,6 +3387,7 @@ void __dept_recover_event(struct dept_event_site_dep *esd,
>  
>  	list_add(&esd->dep_node, &es->dep_head);
>  	list_add(&esd->dep_rev_node, &rs->dep_rev_head);
> +	list_add(&esd->all_node, &dept_event_site_deps);
>  	check_recover_dl_bfs(esd);
>  unlock:
>  	dept_unlock();
> @@ -3347,6 +3398,23 @@ EXPORT_SYMBOL_GPL(__dept_recover_event);
>  
>  #define B2KB(B) ((B) / 1024)
>  
> +void dept_mark_event_site_used(void *start, void *end)

Nit: I suggest that dept_mark_event_site_used() take pointers to
dept_event_site_init, which would catch the type mismatch with
module::dept_event_sites.

> +{
> +	struct dept_event_site_init **evtinitpp;
> +
> +	for (evtinitpp = (struct dept_event_site_init **)start;
> +	     evtinitpp < (struct dept_event_site_init **)end;
> +	     evtinitpp++) {
> +		(*evtinitpp)->evt_site->used = true;
> +		(*evtinitpp)->evt_site->func_name = (*evtinitpp)->func_name;
> +		list_add(&(*evtinitpp)->evt_site->all_node, &dept_event_sites);
> +
> +		pr_info("dept_event_site %s@%s is initialized.\n",
> +				(*evtinitpp)->evt_site->name,
> +				(*evtinitpp)->evt_site->func_name);
> +	}
> +}
> +
>  extern char __dept_event_sites_start[], __dept_event_sites_end[];

Related to the above, __dept_event_sites_start and
__dept_event_sites_end can already be properly typed here.

>  
>  /*
> @@ -3356,20 +3424,11 @@ extern char __dept_event_sites_start[], __dept_event_sites_end[];
>  void __init dept_init(void)
>  {
>  	size_t mem_total = 0;
> -	struct dept_event_site_init **evtinitpp;
>  
>  	/*
>  	 * dept recover dependency tracking works from now on.
>  	 */
> -	for (evtinitpp = (struct dept_event_site_init **)__dept_event_sites_start;
> -	     evtinitpp < (struct dept_event_site_init **)__dept_event_sites_end;
> -	     evtinitpp++) {
> -		(*evtinitpp)->evt_site->used = true;
> -		(*evtinitpp)->evt_site->func_name = (*evtinitpp)->func_name;
> -		pr_info("dept_event %s@%s is initialized.\n",
> -				(*evtinitpp)->evt_site->name,
> -				(*evtinitpp)->evt_site->func_name);
> -	}
> +	dept_mark_event_site_used(__dept_event_sites_start, __dept_event_sites_end);
>  	dept_recover_ready = true;
>  
>  	local_irq_disable();
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index 03ed63f2adf0..82448cdb8ed7 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -2720,6 +2720,11 @@ static int find_module_sections(struct module *mod, struct load_info *info)
>  						&mod->dyndbg_info.num_classes);
>  #endif
>  
> +#ifdef CONFIG_DEPT
> +	mod->dept_event_sites = section_objs(info, ".dept.event_sites",
> +					sizeof(*mod->dept_event_sites),
> +					&mod->num_dept_event_sites);
> +#endif
>  	return 0;
>  }
>  
> @@ -3346,6 +3351,14 @@ static int early_mod_check(struct load_info *info, int flags)
>  	return err;
>  }
>  
> +static void dept_mark_event_site_used_module(struct module *mod)
> +{
> +#ifdef CONFIG_DEPT
> +	dept_mark_event_site_used(mod->dept_event_sites,
> +			     mod->dept_event_sites + mod->num_dept_event_sites);
> +#endif
> +}
> +

It seems to me that the .dept.event_sites section can be discarded after
the module is initialized. In this case, the section should be prefixed
by ".init" and its address can be obtained at the point of use in
dept_mark_event_site_used_module(), without needing to store it inside
the module struct.

Additionally, what is the reason that the dept_event_site_init data is
not stored in the .dept.event_sites section directly and it requires
a level of indirection?

In general, for my own understanding, I also wonder whether the check to
determine that a dept_event_site is used needs to be done at runtime, or
if it could be done at build time by objtool/modpost.

>  /*
>   * Allocate and load the module: note that size of section 0 is always
>   * zero, and we rely on this for optional sections.
> @@ -3508,6 +3521,8 @@ static int load_module(struct load_info *info, const char __user *uargs,
>  	/* Done! */
>  	trace_module_load(mod);
>  
> +	dept_mark_event_site_used_module(mod);
> +
>  	return do_init_module(mod);
>  
>   sysfs_cleanup:

-- 
Thanks,
Petr

