Return-Path: <linux-fsdevel+bounces-79876-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Ak/qExgur2l1PQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79876-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 21:31:20 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B3216240D52
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 21:31:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DBDB2300D680
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2026 20:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4FA27B343;
	Mon,  9 Mar 2026 20:31:13 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9236C2EA;
	Mon,  9 Mar 2026 20:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773088272; cv=none; b=RTgN5ZgM5dpP1NrvoZNc+wtTD87tThyEiJdSeYfB3HjM7Ny2U/RIQCV8K8/HmJQj+g2s/c3xykPkWtUPar75TnfoZUj0fJ8ybUUcU/xUI8MSAXEZ/KMqv9UCw6zAkmSXiY6nXI25lGiH5cRXVgr8OkppXk5xkV1rZ+fF+UhbyqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773088272; c=relaxed/simple;
	bh=LIBZ3t6qSs2lEqwdYFFVeDDtTa2MoTx83SBUaskuTn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dlNAA87HYB0tyqfS1RxchJPMKONbw0aBd40WlHyk2UTs++A7BqpBOZIAo7Mg1y0BaU7fW9kX8dfYz5sCMBfVLPi/Lpeg0vYnGRKVE2OKdIC1e3BI2V9zSMLoNUZFi1vxIWe3YnzRgd6jQNaaZxHbu/NQMSUSnuMUzc5GcVsxQ+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 992821516;
	Mon,  9 Mar 2026 13:31:02 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C777A3F7BD;
	Mon,  9 Mar 2026 13:31:05 -0700 (PDT)
Date: Mon, 9 Mar 2026 20:31:03 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Harry Yoo <harry.yoo@oracle.com>
Cc: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
	Qing Wang <wangqing7171@gmail.com>,
	syzbot+cae7809e9dc1459e4e63@syzkaller.appspotmail.com,
	Liam.Howlett@oracle.com, akpm@linux-foundation.org, chao@kernel.org,
	jaegeuk@kernel.org, jannh@google.com, linkinjeon@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, lorenzo.stoakes@oracle.com, pfalcato@suse.de,
	sj1557.seo@samsung.com, syzkaller-bugs@googlegroups.com,
	vbabka@suse.cz, Hao Li <hao.li@linux.dev>
Subject: Re: [syzbot] [mm?] [f2fs?] [exfat?] memory leak in __kfree_rcu_sheaf
Message-ID: <aa8uByvL9GwsGfnO@arm.com>
References: <698a26d3.050a0220.3b3015.007e.GAE@google.com>
 <20260302034102.3145719-1-wangqing7171@gmail.com>
 <20df8dd1-a32c-489d-8345-085d424a2f12@kernel.org>
 <aaeLT8mnMMj_kPJc@hyeyoo>
 <925a916a-6dfb-48c0-985c-0bdfb96ebd26@kernel.org>
 <aassZV5PjgFx8dSI@arm.com>
 <aa66XJDX4QfmEbNA@hyeyoo>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa66XJDX4QfmEbNA@hyeyoo>
X-Rspamd-Queue-Id: B3216240D52
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[arm.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,syzkaller.appspotmail.com,oracle.com,linux-foundation.org,google.com,lists.sourceforge.net,vger.kernel.org,kvack.org,suse.de,samsung.com,googlegroups.com,suse.cz,linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79876-lists,linux-fsdevel=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,arm.com:mid];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[catalin.marinas@arm.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.980];
	TAGGED_RCPT(0.00)[linux-fsdevel,cae7809e9dc1459e4e63];
	MID_RHS_MATCH_FROM(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Action: no action

On Mon, Mar 09, 2026 at 09:17:32PM +0900, Harry Yoo wrote:
> On Fri, Mar 06, 2026 at 07:35:01PM +0000, Catalin Marinas wrote:
> 
> [...snip...]
> 
> > I wonder whether some early kmem_cache_node allocations like the ones in
> > early_kmem_cache_node_alloc() are not tracked and then kmemleak cannot
> > find n->barn. I got lost in the slub code, but something like this:
> 
> This sounds plausible. Before sheaves, kmem_cache_node just maintained
> a list of slabs. Because struct page (and struct slab overlaying on it)
> is not tracked by kmemleak (as Vlastimil pointed out off-list),
> not calling kmemleak_alloc() for kmem_cache_node was not a problem.
> 
> But now it maintains barns and sheaves,
> and they are tracked by kmemleak...

We could simply add kmemleak_ignore(), especially as we don't need the
data in these structures to be scanned. We can assume the slab allocator
doesn't leak it's own data structures. But I couldn't figure out why
kmemleak couldn't track down the pointer in the first place and any
random kmemleak_alloc() I added did not solve it.

> > -----------8<-----------------------------------
> > diff --git a/mm/slub.c b/mm/slub.c
> > index 0c906fefc31b..401557ff5487 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -7513,6 +7513,7 @@ static void early_kmem_cache_node_alloc(int node)
> >  	slab->freelist = get_freepointer(kmem_cache_node, n);
> >  	slab->inuse = 1;
> >  	kmem_cache_node->node[node] = n;
> > +	kmemleak_alloc(n, sizeof(*n), 1, GFP_NOWAIT);
> >  	init_kmem_cache_node(n, NULL);
> >  	inc_slabs_node(kmem_cache_node, node, slab->objects);
> 
> But this function is called for kmem_cache_node cache
> (in kmem_cache_init()), even before kmemleak_init()?

That's fine, kmemleak starts as enabled by default and tracks early
allocations in a local mem_pool[] array. kmemleak_init() just
initialises its kmem_caches for the long run.

> kmem_cache and kmalloc caches should call kmemleak_alloc() when
> allocating kmem_cache_node structures, but as they are also created
> before kmemleak_init(), I doubt that's actually doing its job...

It does. I just added a kmemleak_alloc() in create_kmalloc_cache() and
kmemleak complained that the object from the kmem_cache_zalloc() is
already registered. Of course, no stack trace saved for these early
allocations but it does track them.

> > -------------8<----------------------------------------
> > 
> > Another thing I noticed, not sure it's related but we should probably
> > ignore an object once it has been passed to kvfree_call_rcu(), similar
> > to what we do on the main path in this function. Also see commit
> > 5f98fd034ca6 ("rcu: kmemleak: Ignore kmemleak false positives when
> > RCU-freeing objects") when we added this kmemleak_ignore().
> > 
> > ---------8<-----------------------------------
> > diff --git a/mm/slab_common.c b/mm/slab_common.c
> > index d5a70a831a2a..73f4668d870d 100644
> > --- a/mm/slab_common.c
> > +++ b/mm/slab_common.c
> > @@ -1954,8 +1954,14 @@ void kvfree_call_rcu(struct rcu_head *head, void *ptr)
> >  	if (!head)
> >  		might_sleep();
> >  
> > -	if (!IS_ENABLED(CONFIG_PREEMPT_RT) && kfree_rcu_sheaf(ptr))
> > +	if (!IS_ENABLED(CONFIG_PREEMPT_RT) && kfree_rcu_sheaf(ptr)) {
> > +		/*
> > +		 * The object is now queued for deferred freeing via an RCU
> > +		 * sheaf. Tell kmemleak to ignore it.
> > +		 */
> > +		kmemleak_ignore(ptr);
> 
> As Vlastimil pointed out off-list, we need to let kmemleak ignore
> sheaves when they are submitted to call_rcu() and ideally undo
> kmemleak_ignore() in __kfree_rcu_sheaf() when they are going to be reused.
> 
> But looking at mm/kmemleak.c, undoing kmemleak_ignore() doesn't seem to
> be a thing.

If that's needed, something like below:

----------------------8<---------------------------------
diff --git a/Documentation/dev-tools/kmemleak.rst b/Documentation/dev-tools/kmemleak.rst
index 7d784e03f3f9..da2c849d4735 100644
--- a/Documentation/dev-tools/kmemleak.rst
+++ b/Documentation/dev-tools/kmemleak.rst
@@ -163,6 +163,7 @@ See the include/linux/kmemleak.h header for the functions prototype.
 - ``kmemleak_not_leak``	 - mark an object as not a leak
 - ``kmemleak_transient_leak``	 - mark an object as a transient leak
 - ``kmemleak_ignore``		 - do not scan or report an object as leak
+- ``kmemleak_unignore``		 - undo a previous kmemleak_ignore()
 - ``kmemleak_scan_area``	 - add scan areas inside a memory block
 - ``kmemleak_no_scan``	 - do not scan a memory block
 - ``kmemleak_erase``		 - erase an old value in a pointer variable
diff --git a/include/linux/kmemleak.h b/include/linux/kmemleak.h
index fbd424b2abb1..4eec0560be09 100644
--- a/include/linux/kmemleak.h
+++ b/include/linux/kmemleak.h
@@ -28,6 +28,7 @@ extern void kmemleak_update_trace(const void *ptr) __ref;
 extern void kmemleak_not_leak(const void *ptr) __ref;
 extern void kmemleak_transient_leak(const void *ptr) __ref;
 extern void kmemleak_ignore(const void *ptr) __ref;
+extern void kmemleak_unignore(const void *ptr, int min_count) __ref;
 extern void kmemleak_ignore_percpu(const void __percpu *ptr) __ref;
 extern void kmemleak_scan_area(const void *ptr, size_t size, gfp_t gfp) __ref;
 extern void kmemleak_no_scan(const void *ptr) __ref;
@@ -104,6 +105,10 @@ static inline void kmemleak_ignore_percpu(const void __percpu *ptr)
 static inline void kmemleak_ignore(const void *ptr)
 {
 }
+
+static inline void kmemleak_unignore(const void *ptr, int min_count)
+{
+}
 static inline void kmemleak_scan_area(const void *ptr, size_t size, gfp_t gfp)
 {
 }
diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index d79acf5c5100..99b7ebd03737 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -1292,6 +1292,24 @@ void __ref kmemleak_ignore(const void *ptr)
 }
 EXPORT_SYMBOL(kmemleak_ignore);
 
+/**
+ * kmemleak_unignore - undo a previous kmemleak_ignore() on an object
+ * @ptr:	pointer to beginning of the object
+ * @min_count:	minimum number of references the object must have to be
+ *		considered a non-leak (see kmemleak_alloc() for details)
+ *
+ * Calling this function undoes a prior kmemleak_ignore() by restoring the
+ * given min_count, making the object visible to kmemleak again.
+ */
+void __ref kmemleak_unignore(const void *ptr, int min_count)
+{
+	pr_debug("%s(0x%px)\n", __func__, ptr);
+
+	if (kmemleak_enabled && ptr && !IS_ERR(ptr))
+		paint_ptr((unsigned long)ptr, min_count, 0);
+}
+EXPORT_SYMBOL(kmemleak_unignore);
+
 /**
  * kmemleak_scan_area - limit the range to be scanned in an allocated object
  * @ptr:	pointer to beginning or inside the object. This also
----------------------8<---------------------------------

-- 
Catalin

