Return-Path: <linux-fsdevel+bounces-77583-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6IY0DBfWlWlLVQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77583-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 16:09:11 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 506F61574AC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 16:09:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CB83E3005320
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 15:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D9133FE0D;
	Wed, 18 Feb 2026 15:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="gldyKQL6";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="gldyKQL6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6845D319610
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Feb 2026 15:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771427317; cv=none; b=INJB0SadCiTIb31xpoliLXI6hr19FAfK0OeouWh7d76A8Ziz4kDV+0780Evhx1HVGdBS5oPo8EfIx3oG5m1sk9fBc71m4WkYbFEAD6ar+yVuK7k+AxzZvITSz6n8C5SlEZ0C1mlwWMMOgzK4oz1mgrTCy2/hEwdCBbvvAE6fIls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771427317; c=relaxed/simple;
	bh=2fr/OCZ8cFVBHcDNDyV5zLQo4aqIHZtJeIp6unn02Vg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cN3mhZ24eBqohqDrI/YOiOIn7wpfYFnV48RyY3+pQfqlA2YaN5rVyo1zsTVhrSfufkvGFgTV5cxFqFF/iSznB4ixKAnK4L0iIsAczmhJ1gzbtLCZltWVjaZcBqxJupsnZAoYpdVJyPhSZXh3cKAO2OGGLkW8CpNBxG554I5N6hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=gldyKQL6; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=gldyKQL6; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3EAF23E6DD;
	Wed, 18 Feb 2026 15:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1771427308; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5lyt323+HbZYpoX64Rl3vcxfunKzUx7dWbFHruMcR5o=;
	b=gldyKQL6ACDQdncmwMAad+Z99WShbTJgDNbsPhcbC0DQiA3KedeIyVic93hD8vv78dtV5k
	mpXWOEOKQDyHkeA1GRi52v9RwnG2zVxhkBv7o7JMU+8dwRIwmS7XltK2XFgm+L7TqcdAoi
	1nUoIbVbEo1ghf+4y8+Ad7p6+tMf3RI=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1771427308; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5lyt323+HbZYpoX64Rl3vcxfunKzUx7dWbFHruMcR5o=;
	b=gldyKQL6ACDQdncmwMAad+Z99WShbTJgDNbsPhcbC0DQiA3KedeIyVic93hD8vv78dtV5k
	mpXWOEOKQDyHkeA1GRi52v9RwnG2zVxhkBv7o7JMU+8dwRIwmS7XltK2XFgm+L7TqcdAoi
	1nUoIbVbEo1ghf+4y8+Ad7p6+tMf3RI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8B3DA3EA65;
	Wed, 18 Feb 2026 15:08:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4AnNIevVlWkRRwAAD6G6ig
	(envelope-from <petr.pavlu@suse.com>); Wed, 18 Feb 2026 15:08:27 +0000
Message-ID: <7765df86-b08a-4f70-900d-4b4d85c07d49@suse.com>
Date: Wed, 18 Feb 2026 16:08:19 +0100
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
 <7afb6666-43b6-4d17-b875-e585c7a5ac99@suse.com>
 <20260213055006.GA55430@system.software.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260213055006.GA55430@system.software.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Score: -0.80
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[skhynix.com,linux-foundation.org,opensource.wdc.com,vger.kernel.org,dilger.ca,redhat.com,infradead.org,kernel.org,linutronix.de,goodmis.org,joelfernandes.org,ffwll.ch,gmail.com,intel.com,mit.edu,fromorbit.com,linuxfoundation.org,lge.com,kvack.org,cmpxchg.org,linux.com,google.com,suse.cz,vflare.org,toxicpanda.com,lists.freedesktop.org,oracle.com,ericsson.com,kzalloc.com,arm.com,lwn.net,alien8.de,zytor.com,linaro.org,padovan.org,amd.com,arndb.de,nvidia.com,joshtriplett.org,efficios.com,linux.dev,suse.de,brown.name,talpey.com,huawei.com,amazon.co.uk,linux.alibaba.com,glider.be,linux.intel.com,treblig.org,star-ark.net,valla.it,vivo.com,baidu.com,lists.infradead.org,lists.linaro.org,lists.linux.dev,qq.com,ownmail.net,sang-engineering.com,linux-m68k.org,garyguo.net,protonmail.com,umich.edu];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	TAGGED_FROM(0.00)[bounces-77583-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[petr.pavlu@suse.com,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_GT_50(0.00)[165];
	TAGGED_RCPT(0.00)[linux-fsdevel,renesas];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,sk.com:email]
X-Rspamd-Queue-Id: 506F61574AC
X-Rspamd-Action: no action

On 2/13/26 6:50 AM, Byungchul Park wrote:
> On Wed, Jan 07, 2026 at 01:19:00PM +0100, Petr Pavlu wrote:
>> On 12/5/25 8:18 AM, Byungchul Park wrote:
>>> struct dept_event_site and struct dept_event_site_dep have been
>>> introduced to track dependencies between multi event sites for a single
>>> wait, that will be loaded to data segment.  Plus, a custom section,
>>> '.dept.event_sites', also has been introduced to keep pointers to the
>>> objects to make sure all the event sites defined exist in code.
>>>
>>> dept should work with the section and segment of module.  Add the
>>> support to handle the section and segment properly whenever modules are
>>> loaded and unloaded.
>>>
>>> Signed-off-by: Byungchul Park <byungchul@sk.com>
>>
>> Below are a few comments from the module loader perspective.
> 
> Sorry about the late reply.  I've been going through some major life
> changes lately. :(
> 
> Thank you sooooo~ much for your helpful feedback.  I will leave my
> opinion below.
> 
[...]
>>> diff --git a/kernel/dependency/dept.c b/kernel/dependency/dept.c
>>> index b14400c4f83b..07d883579269 100644
>>> --- a/kernel/dependency/dept.c
>>> +++ b/kernel/dependency/dept.c
>>> @@ -984,6 +984,9 @@ static void bfs(void *root, struct bfs_ops *ops, void *in, void **out)
>>>   * event sites.
>>>   */
>>>
>>> +static LIST_HEAD(dept_event_sites);
>>> +static LIST_HEAD(dept_event_site_deps);
>>> +
>>>  /*
>>>   * Print all events in the circle.
>>>   */
>>> @@ -2043,6 +2046,33 @@ static void del_dep_rcu(struct rcu_head *rh)
>>>       preempt_enable();
>>>  }
>>>
>>> +/*
>>> + * NOTE: Must be called with dept_lock held.
>>> + */
>>> +static void disconnect_event_site_dep(struct dept_event_site_dep *esd)
>>> +{
>>> +     list_del_rcu(&esd->dep_node);
>>> +     list_del_rcu(&esd->dep_rev_node);
>>> +}
>>> +
>>> +/*
>>> + * NOTE: Must be called with dept_lock held.
>>> + */
>>> +static void disconnect_event_site(struct dept_event_site *es)
>>> +{
>>> +     struct dept_event_site_dep *esd, *next_esd;
>>> +
>>> +     list_for_each_entry_safe(esd, next_esd, &es->dep_head, dep_node) {
>>> +             list_del_rcu(&esd->dep_node);
>>> +             list_del_rcu(&esd->dep_rev_node);
>>> +     }
>>> +
>>> +     list_for_each_entry_safe(esd, next_esd, &es->dep_rev_head, dep_rev_node) {
>>> +             list_del_rcu(&esd->dep_node);
>>> +             list_del_rcu(&esd->dep_rev_node);
>>> +     }
>>> +}
>>> +
>>>  /*
>>>   * NOTE: Must be called with dept_lock held.
>>>   */
>>> @@ -2384,6 +2414,8 @@ void dept_free_range(void *start, unsigned int sz)
>>>  {
>>>       struct dept_task *dt = dept_task();
>>>       struct dept_class *c, *n;
>>> +     struct dept_event_site_dep *esd, *next_esd;
>>> +     struct dept_event_site *es, *next_es;
>>>       unsigned long flags;
>>>
>>>       if (unlikely(!dept_working()))
>>> @@ -2405,6 +2437,24 @@ void dept_free_range(void *start, unsigned int sz)
>>>       while (unlikely(!dept_lock()))
>>>               cpu_relax();
>>>
>>> +     list_for_each_entry_safe(esd, next_esd, &dept_event_site_deps, all_node) {
>>> +             if (!within((void *)esd, start, sz))
>>> +                     continue;
>>> +
>>> +             disconnect_event_site_dep(esd);
>>> +             list_del(&esd->all_node);
>>> +     }
>>> +
>>> +     list_for_each_entry_safe(es, next_es, &dept_event_sites, all_node) {
>>> +             if (!within((void *)es, start, sz) &&
>>> +                 !within(es->name, start, sz) &&
>>> +                 !within(es->func_name, start, sz))
>>> +                     continue;
>>> +
>>> +             disconnect_event_site(es);
>>> +             list_del(&es->all_node);
>>> +     }
>>> +
>>>       list_for_each_entry_safe(c, n, &dept_classes, all_node) {
>>>               if (!within((void *)c->key, start, sz) &&
>>>                   !within(c->name, start, sz))
>>> @@ -3337,6 +3387,7 @@ void __dept_recover_event(struct dept_event_site_dep *esd,
>>>
>>>       list_add(&esd->dep_node, &es->dep_head);
>>>       list_add(&esd->dep_rev_node, &rs->dep_rev_head);
>>> +     list_add(&esd->all_node, &dept_event_site_deps);
>>>       check_recover_dl_bfs(esd);
>>>  unlock:
>>>       dept_unlock();
>>> @@ -3347,6 +3398,23 @@ EXPORT_SYMBOL_GPL(__dept_recover_event);
>>>
>>>  #define B2KB(B) ((B) / 1024)
>>>
>>> +void dept_mark_event_site_used(void *start, void *end)
>>
>> Nit: I suggest that dept_mark_event_site_used() take pointers to
>> dept_event_site_init, which would catch the type mismatch with
> 
> IMO, this is the easiest way to get all the pointers from start to the
> end, or I can't get the number of the pointers.  It's similar to the
> initcalls section for device drivers.

This was a minor suggestion.. The idea is to simply change the function
signature to:

void dept_mark_event_site_used(struct dept_event_site_init **start,
			       struct dept_event_site_init **end))

This way, the compiler can provide proper type checking to ensure that
correct pointers are passed to dept_mark_event_site_used(). It would
catch the type mismatch with module::dept_event_sites.

> 
>> module::dept_event_sites.
>>
>>> +{
>>> +     struct dept_event_site_init **evtinitpp;
>>> +
>>> +     for (evtinitpp = (struct dept_event_site_init **)start;
>>> +          evtinitpp < (struct dept_event_site_init **)end;
>>> +          evtinitpp++) {
>>> +             (*evtinitpp)->evt_site->used = true;
>>> +             (*evtinitpp)->evt_site->func_name = (*evtinitpp)->func_name;
>>> +             list_add(&(*evtinitpp)->evt_site->all_node, &dept_event_sites);
>>> +
>>> +             pr_info("dept_event_site %s@%s is initialized.\n",
>>> +                             (*evtinitpp)->evt_site->name,
>>> +                             (*evtinitpp)->evt_site->func_name);
>>> +     }
>>> +}
>>> +
>>>  extern char __dept_event_sites_start[], __dept_event_sites_end[];
>>
>> Related to the above, __dept_event_sites_start and
>> __dept_event_sites_end can already be properly typed here.
> 
> How can I get the number of the pointers?

Similarly here, changing the code to:

extern struct dept_event_site_init *__dept_event_sites_start[], *__dept_event_sites_end[];

It is the same for the initcalls you mentioned. The declarations of
their start/end symbols are also already properly typed as
initcall_entry_t[] in include/linux/init.h.

-- 
Thanks,
Petr

