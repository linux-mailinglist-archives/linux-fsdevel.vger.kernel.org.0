Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 498E5560A16
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jun 2022 21:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbiF2TNn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jun 2022 15:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiF2TNn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jun 2022 15:13:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5B2DC37A8A
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jun 2022 12:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656530020;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mJMn7sxcJ5FrbPdaD15z+vHLQTJWaPg41D8B+sADTcA=;
        b=ZmVsBL54tTTPTuJZXRMQZdWytK+bmVgT9X66REAmJrnGFYavwWjCnkLBtQYinvSIvzbRsm
        xvyHnD72RboM2CB2RiWwP3eI82F0o73ideFj2r1kzPPYaBNWJ+G2E1XpthmcKba8UO6GCF
        aVE9tK4op2PR8Q5PbTS7v6eOUST/eCk=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-195-hrKruZqSNX-BLZNDiyNXjA-1; Wed, 29 Jun 2022 15:13:39 -0400
X-MC-Unique: hrKruZqSNX-BLZNDiyNXjA-1
Received: by mail-qk1-f197.google.com with SMTP id w16-20020a376210000000b006af059b17b7so16318238qkb.12
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jun 2022 12:13:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mJMn7sxcJ5FrbPdaD15z+vHLQTJWaPg41D8B+sADTcA=;
        b=Mxkj0y5IMQuA5C7dtv6+kHtKSwt4vUFg/0m15O5dWAGUGCrPI+MwfjowFzLR2GzP+1
         960RxWc4tmMkjF1HLmgJTETh2kmtr92OrnW4F6ao9y+1Dkdptudr/ze4CaQNDoD0aa9g
         3rjYHyCjqEJxM+tMSYApO+Xk1IqH2ex9ZxSEQRpPlODloR5vvJzZmHHtnA8ZXsDhvM1J
         EJkhHL5XX/A0MWokNrQcDhPqjzzc/jT9/vqzVyCQyc+VDOTO6Ywg3WSIRtY2tXw+yCG8
         MMGW3nh20X1BMvKWEhHnqDSHAYlp7/iPzvW5xFNeVl9NMCqWhEfcOXVBzwyfL+xMJXh7
         5eyw==
X-Gm-Message-State: AJIora+g2vUCW8Trvzj33UIaJs6OMt0JkniYW6l+SavGzLCjvukXGPsM
        AQsvqbTTAXG67Yr/ZKpWNEd94YYS+uBn9Dz/yrdxQGDTQ79BhUpBR56w5J2zG7kAi+du2l5t8Y+
        dd1fshWo3EKN3XNHwHr5BR6tN7g==
X-Received: by 2002:a05:6214:500b:b0:470:5f58:68f with SMTP id jo11-20020a056214500b00b004705f58068fmr9227013qvb.9.1656530018016;
        Wed, 29 Jun 2022 12:13:38 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sfdPBlzaLkzl42s//Rzy6mBAKIvM5z7koEgLg2Rq1boNJvVNzy+RXEcK/5v9IBYKbQ1w31kw==
X-Received: by 2002:a05:6214:500b:b0:470:5f58:68f with SMTP id jo11-20020a056214500b00b004705f58068fmr9226981qvb.9.1656530017569;
        Wed, 29 Jun 2022 12:13:37 -0700 (PDT)
Received: from bfoster (c-24-61-119-116.hsd1.ma.comcast.net. [24.61.119.116])
        by smtp.gmail.com with ESMTPSA id h9-20020ac85149000000b003050bd1f7c9sm11595967qtn.76.2022.06.29.12.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 12:13:37 -0700 (PDT)
Date:   Wed, 29 Jun 2022 15:13:34 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ikent@redhat.com, onestero@redhat.com
Subject: Re: [PATCH 1/3] radix-tree: propagate all tags in idr tree
Message-ID: <YrykXim1t71TgdYg@bfoster>
References: <20220614180949.102914-1-bfoster@redhat.com>
 <20220614180949.102914-2-bfoster@redhat.com>
 <Yqm+jmkDA+um2+hd@infradead.org>
 <YqnXVMtBkS2nbx70@bfoster>
 <YqnhW2CI1kbJ3NqR@casper.infradead.org>
 <YqnwFZxmiekL5ZOC@bfoster>
 <YqoJ+p83dLOcGfwX@casper.infradead.org>
 <20220628125511.s2frv6lw7zgyzou5@wittgenstein>
 <YrsV/uT2MDgNPMvR@bfoster>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrsV/uT2MDgNPMvR@bfoster>
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 28, 2022 at 10:53:50AM -0400, Brian Foster wrote:
> On Tue, Jun 28, 2022 at 02:55:11PM +0200, Christian Brauner wrote:
> > On Wed, Jun 15, 2022 at 05:34:02PM +0100, Matthew Wilcox wrote:
> > > On Wed, Jun 15, 2022 at 10:43:33AM -0400, Brian Foster wrote:
> > > > Interesting, thanks. I'll have to dig more into this to grok the current
> > > > state of the radix-tree interface vs. the underlying data structure. If
> > > > I follow correctly, you're saying the radix-tree api is essentially
> > > > already a translation layer to the xarray these days, and we just need
> > > > to move legacy users off the radix-tree api so we can eventually kill it
> > > > off...
> > > 
> > > If only it were that easy ... the XArray has a whole bunch of debugging
> > > asserts to make sure the users are actually using it correctly, and a
> > > lot of radix tree users don't (they're probably not buggy, but they
> > > don't use the XArray's embedded lock).
> > > 
> > > Anyway, here's a first cut at converting the PID allocator from the IDR
> > > to the XArray API.  It boots, but I haven't tried to do anything tricky
> > > with PID namespaces or CRIU.
> > 
> > It'd be great to see that conversion done.
> > Fwiw, there's test cases for e.g. nested pid namespace creation with
> > specifically requested PIDs in
> > 
> 
> Ok, but I'm a little confused. Why open code the xarray usage as opposed
> to work the idr bits closer to being able to use the xarray api (and/or
> work the xarray to better support the idr use case)? I see 150+ callers
> of idr_init(). Is the goal to eventually open code them all? That seems
> a lot of potential api churn for something that is presumably a generic
> interface (and perhaps inconsistent with ida, which looks like it uses
> xarray directly?), but I'm probably missing details.
> 
> If the issue is open-coded locking across all the idr users conflicting
> with internal xarray debug bits, I guess what I'm wondering is why not
> implement your patch more generically within idr (i.e. expose some
> locking apis, etc.)? Even if it meant creating something like a
> temporary init_idr_xa() variant that users can switch over to as they're
> audited for expected behavior, I don't quite grok why that couldn't be
> made to work if changing this code over directly does and the various
> core radix tree data structures idr uses are already #defined to xarray
> variants. Hm?
> 

Using Willy's patch as a reference, here's a hacked up example of what I
was thinking (squashed to a single diff and based on top of my pending
idr tag patches). Obviously this needs more work and thought. I skipped
the locking change to start, so this will nest the internal xarray lock
inside the pidmap lock. I'm assuming doing otherwise might cause xarray
problems based on earlier comments..?  It does boot and doesn't
immediately explode however; the tag -> mark bits seem to work as
expected, etc.

I am a little curious how pervasive the aforementioned locking issue is
here. Are we talking about the lockdep_is_held() assertions in xarray.h?
If so, could we get away with either disabling those for idr users (via
some new flag) or perhaps allow idr users to pass along a lockdep_map
associated with an external lock that the xarray can feed into
lock_is_held()..?

Brian

--- 8< ---

diff --git a/include/linux/idr.h b/include/linux/idr.h
index 5b62dfa4a031..f7dd0e8d8ac2 100644
--- a/include/linux/idr.h
+++ b/include/linux/idr.h
@@ -17,28 +17,31 @@
 #include <linux/percpu.h>
 
 struct idr {
-	struct radix_tree_root	idr_rt;
+	struct xarray		idr_rt;
 	unsigned int		idr_base;
 	unsigned int		idr_next;
+	bool			idr_xa;
 };
 
 /*
- * The IDR API does not expose the tagging functionality of the radix tree
- * to users.  Use tag 0 to track whether a node has free space below it.
+ * The IDR API does not expose the tagging functionality of the tree to users.
+ * Use tag 0 to track whether a node has free space below it.
  */
 #define IDR_FREE	0
 #define IDR_TAG		1
 
 /* Set the IDR flag and the IDR_FREE tag */
-#define IDR_RT_MARKER	(ROOT_IS_IDR | (__force gfp_t)			\
-					(1 << (ROOT_TAG_SHIFT + IDR_FREE)))
+#define IDR_RT_MARKER	(ROOT_IS_IDR | XA_FLAGS_MARK(IDR_FREE))
 
-#define IDR_INIT_BASE(name, base) {					\
-	.idr_rt = RADIX_TREE_INIT(name, IDR_RT_MARKER),			\
+#define __IDR_INIT(name, base, flags, is_xa) {				\
+	.idr_rt = XARRAY_INIT(name, flags),				\
 	.idr_base = (base),						\
 	.idr_next = 0,							\
+	.idr_xa = is_xa,						\
 }
 
+#define IDR_INIT_BASE(name, base) __IDR_INIT(name, base, IDR_RT_MARKER, false)
+
 /**
  * IDR_INIT() - Initialise an IDR.
  * @name: Name of IDR.
@@ -111,6 +114,7 @@ static inline void idr_set_cursor(struct idr *idr, unsigned int val)
 				xa_unlock_irqrestore(&(idr)->idr_rt, flags)
 
 void idr_preload(gfp_t gfp_mask);
+void idr_preload_end(void);
 
 int idr_alloc(struct idr *, void *ptr, int start, int end, gfp_t);
 int __must_check idr_alloc_u32(struct idr *, void *ptr, u32 *id,
@@ -123,6 +127,9 @@ int idr_for_each(const struct idr *,
 void *idr_get_next(struct idr *, int *nextid);
 void *idr_get_next_ul(struct idr *, unsigned long *nextid);
 void *idr_replace(struct idr *, void *, unsigned long id);
+void idr_set_tag(struct idr *idr, unsigned long id);
+bool idr_get_tag(struct idr *idr, unsigned long id);
+void *idr_get_next_tag(struct idr *idr, unsigned long id);
 void idr_destroy(struct idr *);
 
 /**
@@ -133,11 +140,17 @@ void idr_destroy(struct idr *);
  * This variation of idr_init() creates an IDR which will allocate IDs
  * starting at %base.
  */
-static inline void idr_init_base(struct idr *idr, int base)
+static inline void __idr_init(struct idr *idr, int base, gfp_t flags, bool is_xa)
 {
-	INIT_RADIX_TREE(&idr->idr_rt, IDR_RT_MARKER);
+	xa_init_flags(&idr->idr_rt, flags);
 	idr->idr_base = base;
 	idr->idr_next = 0;
+	idr->idr_xa = is_xa;
+}
+
+static inline void idr_init_base(struct idr *idr, int base)
+{
+	__idr_init(idr, base, IDR_RT_MARKER, false);
 }
 
 /**
@@ -160,43 +173,8 @@ static inline void idr_init(struct idr *idr)
  */
 static inline bool idr_is_empty(const struct idr *idr)
 {
-	return radix_tree_empty(&idr->idr_rt) &&
-		radix_tree_tagged(&idr->idr_rt, IDR_FREE);
-}
-
-/**
- * idr_preload_end - end preload section started with idr_preload()
- *
- * Each idr_preload() should be matched with an invocation of this
- * function.  See idr_preload() for details.
- */
-static inline void idr_preload_end(void)
-{
-	local_unlock(&radix_tree_preloads.lock);
-}
-
-static inline void idr_set_tag(struct idr *idr, unsigned long id)
-{
-	radix_tree_tag_set(&idr->idr_rt, id, IDR_TAG);
-}
-
-static inline bool idr_get_tag(struct idr *idr, unsigned long id)
-{
-	return radix_tree_tag_get(&idr->idr_rt, id, IDR_TAG);
-}
-
-/*
- * Find the next id with the internal tag set.
- */
-static inline void *idr_get_next_tag(struct idr *idr, unsigned long id)
-{
-	unsigned int ret;
-	void *entry;
-
-	ret = radix_tree_gang_lookup_tag(&idr->idr_rt, &entry, id, 1, IDR_TAG);
-	if (ret != 1)
-		return NULL;
-	return entry;
+	return xa_empty(&idr->idr_rt) &&
+		xa_marked(&idr->idr_rt, IDR_FREE);
 }
 
 /**
diff --git a/kernel/pid.c b/kernel/pid.c
index bd72d1dbff95..d2297578466f 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -66,6 +66,8 @@ int pid_max = PID_MAX_DEFAULT;
 int pid_max_min = RESERVED_PIDS + 1;
 int pid_max_max = PID_MAX_LIMIT;
 
+#define PID_XA_FLAGS	(XA_FLAGS_TRACK_FREE | XA_FLAGS_LOCK_IRQ)
+
 /*
  * PID-map pages start out as NULL, they get allocated upon
  * first use and are never deallocated. This way a low pid_max
@@ -74,7 +76,7 @@ int pid_max_max = PID_MAX_LIMIT;
  */
 struct pid_namespace init_pid_ns = {
 	.ns.count = REFCOUNT_INIT(2),
-	.idr = IDR_INIT(init_pid_ns.idr),
+	.idr = __IDR_INIT(init_pid_ns.idr, 0, PID_XA_FLAGS, true),
 	.pid_allocated = PIDNS_ADDING,
 	.level = 0,
 	.child_reaper = &init_task,
@@ -205,7 +207,6 @@ struct pid *alloc_pid(struct pid_namespace *ns, pid_t *set_tid,
 			set_tid_size--;
 		}
 
-		idr_preload(GFP_KERNEL);
 		spin_lock_irq(&pidmap_lock);
 
 		if (tid) {
@@ -234,7 +235,6 @@ struct pid *alloc_pid(struct pid_namespace *ns, pid_t *set_tid,
 					      pid_max, GFP_ATOMIC);
 		}
 		spin_unlock_irq(&pidmap_lock);
-		idr_preload_end();
 
 		if (nr < 0) {
 			retval = (nr == -ENOSPC) ? -EAGAIN : nr;
@@ -696,7 +696,7 @@ void __init pid_idr_init(void)
 				PIDS_PER_CPU_MIN * num_possible_cpus());
 	pr_info("pid_max: default: %u minimum: %u\n", pid_max, pid_max_min);
 
-	idr_init(&init_pid_ns.idr);
+	__idr_init(&init_pid_ns.idr, 0, PID_XA_FLAGS, true);
 
 	init_pid_ns.pid_cachep = KMEM_CACHE(pid,
 			SLAB_HWCACHE_ALIGN | SLAB_PANIC | SLAB_ACCOUNT);
diff --git a/lib/idr.c b/lib/idr.c
index f4ab4f4aa3c7..ae6dac08683c 100644
--- a/lib/idr.c
+++ b/lib/idr.c
@@ -37,11 +37,27 @@ int idr_alloc_u32(struct idr *idr, void *ptr, u32 *nextid,
 	void __rcu **slot;
 	unsigned int base = idr->idr_base;
 	unsigned int id = *nextid;
+	int error;
+	struct xa_limit limit;
+
+	id = (id < base) ? 0 : id - base;
+
+	if (idr->idr_xa) {
+		limit.min = id;
+		limit.max = max - base;
+		error = xa_alloc(&idr->idr_rt, nextid, ptr, limit, gfp);
+		/* error compatibility w/ radix-tree */
+		if (error == -EBUSY)
+			return -ENOSPC;
+		else if (error)
+			return error;
+		*nextid += base;
+		return 0;
+	}
 
 	if (WARN_ON_ONCE(!(idr->idr_rt.xa_flags & ROOT_IS_IDR)))
 		idr->idr_rt.xa_flags |= IDR_RT_MARKER;
 
-	id = (id < base) ? 0 : id - base;
 	radix_tree_iter_init(&iter, id);
 	slot = idr_get_free(&idr->idr_rt, &iter, gfp, max - base);
 	if (IS_ERR(slot))
@@ -151,6 +167,8 @@ EXPORT_SYMBOL(idr_alloc_cyclic);
  */
 void *idr_remove(struct idr *idr, unsigned long id)
 {
+	if (idr->idr_xa)
+		return xa_erase(&idr->idr_rt, id - idr->idr_base);
 	return radix_tree_delete_item(&idr->idr_rt, id - idr->idr_base, NULL);
 }
 EXPORT_SYMBOL_GPL(idr_remove);
@@ -171,6 +189,8 @@ EXPORT_SYMBOL_GPL(idr_remove);
  */
 void *idr_find(const struct idr *idr, unsigned long id)
 {
+	if (idr->idr_xa)
+		return xa_load(&idr->idr_rt, id - idr->idr_base);
 	return radix_tree_lookup(&idr->idr_rt, id - idr->idr_base);
 }
 EXPORT_SYMBOL_GPL(idr_find);
@@ -233,6 +253,14 @@ void *idr_get_next_ul(struct idr *idr, unsigned long *nextid)
 	unsigned long id = *nextid;
 
 	id = (id < base) ? 0 : id - base;
+
+	if (idr->idr_xa) {
+		entry = xa_find(&idr->idr_rt, &id, ULONG_MAX, XA_PRESENT);
+		if (entry)
+			*nextid = id + base;
+		return entry;
+	}
+
 	radix_tree_for_each_slot(slot, &idr->idr_rt, &iter, id) {
 		entry = rcu_dereference_raw(*slot);
 		if (!entry)
@@ -295,6 +323,12 @@ void *idr_replace(struct idr *idr, void *ptr, unsigned long id)
 
 	id -= idr->idr_base;
 
+	if (idr->idr_xa) {
+		entry = xa_store(&idr->idr_rt, id, ptr, 0);
+		/* XXX: error translation? */
+		return entry;
+	}
+
 	entry = __radix_tree_lookup(&idr->idr_rt, id, &node, &slot);
 	if (!slot || radix_tree_tag_get(&idr->idr_rt, id, IDR_FREE))
 		return ERR_PTR(-ENOENT);
@@ -305,6 +339,41 @@ void *idr_replace(struct idr *idr, void *ptr, unsigned long id)
 }
 EXPORT_SYMBOL(idr_replace);
 
+void idr_set_tag(struct idr *idr, unsigned long id)
+{
+	if (idr->idr_xa)
+		xa_set_mark(&idr->idr_rt, id, IDR_TAG);
+	else
+		radix_tree_tag_set(&idr->idr_rt, id, IDR_TAG);
+}
+
+bool idr_get_tag(struct idr *idr, unsigned long id)
+{
+	if (idr->idr_xa)
+		return xa_get_mark(&idr->idr_rt, id, IDR_TAG);
+	return radix_tree_tag_get(&idr->idr_rt, id, IDR_TAG);
+}
+
+/*
+ * Find the next id with the internal tag set.
+ */
+void *idr_get_next_tag(struct idr *idr, unsigned long id)
+{
+	unsigned int ret;
+	void *entry;
+
+	if (idr->idr_xa) {
+		entry = xa_find(&idr->idr_rt, &id, ULONG_MAX, IDR_TAG);
+		return entry;
+	}
+
+	ret = radix_tree_gang_lookup_tag(&idr->idr_rt, &entry, id, 1, IDR_TAG);
+	if (ret != 1)
+		return NULL;
+	return entry;
+}
+
+
 /**
  * DOC: IDA description
  *
diff --git a/lib/radix-tree.c b/lib/radix-tree.c
index 08eef33e7820..8c6eb25aadbb 100644
--- a/lib/radix-tree.c
+++ b/lib/radix-tree.c
@@ -1476,6 +1476,18 @@ void idr_preload(gfp_t gfp_mask)
 }
 EXPORT_SYMBOL(idr_preload);
 
+/**
+ * idr_preload_end - end preload section started with idr_preload()
+ *
+ * Each idr_preload() should be matched with an invocation of this
+ * function.  See idr_preload() for details.
+ */
+void idr_preload_end(void)
+{
+	local_unlock(&radix_tree_preloads.lock);
+}
+EXPORT_SYMBOL(idr_preload_end);
+
 void __rcu **idr_get_free(struct radix_tree_root *root,
 			      struct radix_tree_iter *iter, gfp_t gfp,
 			      unsigned long max)

