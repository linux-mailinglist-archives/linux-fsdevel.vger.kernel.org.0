Return-Path: <linux-fsdevel+bounces-65929-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 930A9C15675
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 16:22:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED0A53B0CEA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 15:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2359C340D93;
	Tue, 28 Oct 2025 15:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qq+aDogl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CA733F8DC;
	Tue, 28 Oct 2025 15:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761664812; cv=none; b=U4QxA6zwuaIZVu8bbOnGlL+ZHIEMfqAZzipnKW6ZolmLo8vcPnTGruwCoVMHvJHTa3/x9aLly2LKn31IAsaAqjCQZYbA3RVQP3KEwzxdxJ1DQC4JDnXxuwTza3OZPbQCq1FSQQa3m06PTGIno1U7q2KsWaGKJwquUDL7o4NnL/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761664812; c=relaxed/simple;
	bh=v9Rv1HV3ikERpxpW7AFoVZzI5l2h0fNjA8LM+9vK5U4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HnXQHB4OBCQzqBTJebwgXNdIs3hUPL8QPzGH81+DX2aTHOW/uKpxNT9lH/WO6h1oVHh1DIh8IWT4zciDz0tvQKPr18uBGWD4tIdoYWY/Yl7pSJakorMtg9WK1G1p79RdBcxwuHdmD9dJLpe46QQc7++nl1MojpZOQZtTONR1tA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qq+aDogl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11D2CC4CEE7;
	Tue, 28 Oct 2025 15:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761664812;
	bh=v9Rv1HV3ikERpxpW7AFoVZzI5l2h0fNjA8LM+9vK5U4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qq+aDoglEAEQeZj43j1Ad6bErXdWun4BUqRgwXwoPFKAf/z011GLNFY7bIPgOKkBw
	 0xwuuW7/3ijghyDkNnHVsZVgy+w2I86WF+S0DFH6R6pou2EiYfmwr1OR+91OsYR2cC
	 YzsGU/+kV1g+48Y9C2KzvIeVZ8bpGhcgJbx+hdSZIgRcSTo3ye1jcxTBgPLG+538s7
	 tvNOfs8wSga3jNoEnPPnBTYKW7kSRn40U5+aWQEF0jb8/kccNi01lfrQRf/VbEOg1O
	 ZmAFI+7NoT6i575j/FD4+FLa4JZ1mOfawv9/MV9efOtLb7W99c5tz5Mbv03wOPlsVW
	 Fh4aS/RkNfevg==
Date: Tue, 28 Oct 2025 16:20:04 +0100
From: Christian Brauner <brauner@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
	Jeff Layton <jlayton@kernel.org>, Jann Horn <jannh@google.com>, Mike Yuan <me@yhndnzj.com>, 
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, Lennart Poettering <mzxreary@0pointer.de>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, 
	Amir Goldstein <amir73il@gmail.com>, Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	bpf@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Netdev <netdev@vger.kernel.org>
Subject: Re: [PATCH v3 17/70] nstree: add listns()
Message-ID: <20251028-landhaus-akademie-875cd140fbbb@brauner>
References: <20251024-work-namespace-nstree-listns-v3-0-b6241981b72b@kernel.org>
 <20251024-work-namespace-nstree-listns-v3-17-b6241981b72b@kernel.org>
 <481c973c-3ae5-4184-976e-96ab633dd09a@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <481c973c-3ae5-4184-976e-96ab633dd09a@app.fastmail.com>

On Fri, Oct 24, 2025 at 04:06:57PM +0200, Arnd Bergmann wrote:
> On Fri, Oct 24, 2025, at 12:52, Christian Brauner wrote:
> > Add a new listns() system call that allows userspace to iterate through
> > namespaces in the system. This provides a programmatic interface to
> > discover and inspect namespaces, enhancing existing namespace apis.
> 
> I double-checked that the ABI is well-formed and works the same
> way on all supported architectures, though I did not check the functional
> aspects.
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
> One small thing I noticed:
> 
> > +SYSCALL_DEFINE4(listns, const struct ns_id_req __user *, req,
> > +		u64 __user *, ns_ids, size_t, nr_ns_ids, unsigned int, flags)
> > +{
> > +	struct klistns klns __free(klistns_free) = {};
> > +	const size_t maxcount = 1000000;
> > +	struct ns_id_req kreq;
> > +	ssize_t ret;
> > +
> > +	if (flags)
> > +		return -EINVAL;
> > +
> > +	if (unlikely(nr_ns_ids > maxcount))
> > +		return -EOVERFLOW;
> > +
> > +	if (!access_ok(ns_ids, nr_ns_ids * sizeof(*ns_ids)))
> > +		return -EFAULT;
> 
> I'm a bit worried about hardcoding the maxcount value here, which
> seems to limit both the size of the allocation and prevent overflowing
> the multiplication of the access_ok() argument, though that isn't
> completely clear from the implementation.
> 
> Allowing 8MB of vmalloc space to be filled can be bad on 32-bit
> systems that may only have 100MB in total. The access_ok() check
> looks like it tries to provide an early-fail error return but
> should not actually be needed since there is a single copy_to_user()
> in the end, and that is more likely to fail for unmapped memory than
> an access_ok() failure.
> 
> Would it make sense to just drop the kvmalloc() completely and
> instead put_user() the output values individually? That way you
> can avoid both a hardwired limit and a potential DoS from vmalloc
> exhaustion.

Initially this wasn't possible because we walked all of this completely
with only rcu protection. But now that we always have to take a passive
reference its possible to do what you suggest. This would mean
ping-ponging the rcu_read_lock()/rcu_read_unlock() but that's probably
fine. How do you feel about the following?: 

diff --git a/kernel/nstree.c b/kernel/nstree.c
index 1455573e774e..e4c8508e97c7 100644
--- a/kernel/nstree.c
+++ b/kernel/nstree.c
@@ -382,7 +382,7 @@ u64 __ns_tree_gen_id(struct ns_common *ns, u64 id)
 }
 
 struct klistns {
-	u64 *kns_ids;
+	u64 __user *uns_ids;
 	u32 nr_ns_ids;
 	u64 last_ns_id;
 	u64 user_ns_id;
@@ -395,9 +395,8 @@ static void __free_klistns_free(const struct klistns *kls)
 {
 	if (kls->user_ns_id != LISTNS_CURRENT_USER)
 		put_user_ns(kls->user_ns);
-	if (kls->first_ns)
+	if (kls->first_ns && kls->first_ns->ops)
 		kls->first_ns->ops->put(kls->first_ns);
-	kvfree(kls->kns_ids);
 }
 
 #define NS_ALL (PID_NS | USER_NS | MNT_NS | UTS_NS | IPC_NS | NET_NS | CGROUP_NS | TIME_NS)
@@ -429,18 +428,13 @@ static int copy_ns_id_req(const struct ns_id_req __user *req,
 }
 
 static inline int prepare_klistns(struct klistns *kls, struct ns_id_req *kreq,
-				  size_t nr_ns_ids)
+				  u64 __user *ns_ids, size_t nr_ns_ids)
 {
 	kls->last_ns_id = kreq->ns_id;
 	kls->user_ns_id = kreq->user_ns_id;
-	kls->nr_ns_ids = nr_ns_ids;
-	kls->ns_type = kreq->ns_type;
-
-	kls->kns_ids = kvmalloc_array(nr_ns_ids, sizeof(*kls->kns_ids),
-				      GFP_KERNEL_ACCOUNT);
-	if (!kls->kns_ids)
-		return -ENOMEM;
-
+	kls->nr_ns_ids	= nr_ns_ids;
+	kls->ns_type	= kreq->ns_type;
+	kls->uns_ids	= ns_ids;
 	return 0;
 }
 
@@ -459,8 +453,9 @@ static struct ns_common *lookup_ns_owner_at(u64 ns_id, struct ns_common *owner)
 	node = owner->ns_owner_tree.rb_node;
 
 	while (node) {
-		struct ns_common *ns = node_to_ns_owner(node);
+		struct ns_common *ns;
 
+		ns = node_to_ns_owner(node);
 		if (ns_id <= ns->ns_id) {
 			ret = ns;
 			if (ns_id == ns->ns_id)
@@ -494,7 +489,7 @@ static struct ns_common *lookup_ns_id(u64 mnt_ns_id, int ns_type)
 
 static ssize_t do_listns_userns(struct klistns *kls)
 {
-	u64 *ns_ids = kls->kns_ids;
+	u64 __user *ns_ids = kls->uns_ids;
 	size_t nr_ns_ids = kls->nr_ns_ids;
 	struct ns_common *ns = NULL, *first_ns = NULL;
 	const struct list_head *head;
@@ -525,7 +520,9 @@ static ssize_t do_listns_userns(struct klistns *kls)
 	ret = 0;
 	head = &to_ns_common(kls->user_ns)->ns_owner;
 	userns_capable = ns_capable_noaudit(kls->user_ns, CAP_SYS_ADMIN);
-	guard(rcu)();
+
+	rcu_read_lock();
+
 	if (!first_ns)
 		first_ns = list_entry_rcu(head->next, typeof(*ns), ns_owner_entry);
 	for (ns = first_ns; &ns->ns_owner_entry != head && nr_ns_ids;
@@ -534,19 +531,28 @@ static ssize_t do_listns_userns(struct klistns *kls)
 			continue;
 		if (!ns_get_unless_inactive(ns))
 			continue;
+
+		rcu_read_unlock();
+
 		if (userns_capable || is_current_namespace(ns) ||
 		    ((ns->ns_type == CLONE_NEWUSER) && ns_capable_noaudit(to_user_ns(ns), CAP_SYS_ADMIN))) {
-			*ns_ids = ns->ns_id;
-			ns_ids++;
+			if (put_user(ns->ns_id, ns_ids + ret))
+				return -EINVAL;
 			nr_ns_ids--;
 			ret++;
 		}
+
 		if (need_resched())
-			cond_resched_rcu();
+			cond_resched();
+
+		rcu_read_lock();
+
 		/* doesn't sleep */
-		ns->ops->put(ns);
+		if (ns->ops)
+			ns->ops->put(ns);
 	}
 
+	rcu_read_unlock();
 	return ret;
 }
 
@@ -626,7 +632,7 @@ static inline bool ns_common_is_head(struct ns_common *ns,
 
 static ssize_t do_listns(struct klistns *kls)
 {
-	u64 *ns_ids = kls->kns_ids;
+	u64 __user *ns_ids = kls->uns_ids;
 	size_t nr_ns_ids = kls->nr_ns_ids;
 	struct ns_common *ns, *first_ns = NULL;
 	struct ns_tree *ns_tree = NULL;
@@ -659,7 +665,8 @@ static ssize_t do_listns(struct klistns *kls)
 	else
 		head = &ns_unified_list;
 
-	guard(rcu)();
+	rcu_read_lock();
+
 	if (!first_ns)
 		first_ns = first_ns_common(head, ns_tree);
 
@@ -669,6 +676,9 @@ static ssize_t do_listns(struct klistns *kls)
 			continue;
 		if (!ns_get_unless_inactive(ns))
 			continue;
+
+		rcu_read_unlock();
+
 		/* Check permissions */
 		if (!ns->ops)
 			user_ns = NULL;
@@ -679,16 +689,22 @@ static ssize_t do_listns(struct klistns *kls)
 		if (ns_capable_noaudit(user_ns, CAP_SYS_ADMIN) ||
 		    is_current_namespace(ns) ||
 		    ((ns->ns_type == CLONE_NEWUSER) && ns_capable_noaudit(to_user_ns(ns), CAP_SYS_ADMIN))) {
-			*ns_ids++ = ns->ns_id;
+			if (put_user(ns->ns_id, ns_ids + ret))
+				return -EINVAL;
 			nr_ns_ids--;
 			ret++;
 		}
 		if (need_resched())
-			cond_resched_rcu();
+			cond_resched();
+
+		rcu_read_lock();
+
 		/* doesn't sleep */
-		ns->ops->put(ns);
+		if (ns->ops)
+			ns->ops->put(ns);
 	}
 
+	rcu_read_unlock();
 	return ret;
 }
 
@@ -713,19 +729,12 @@ SYSCALL_DEFINE4(listns, const struct ns_id_req __user *, req,
 	if (ret)
 		return ret;
 
-	ret = prepare_klistns(&klns, &kreq, nr_ns_ids);
+	ret = prepare_klistns(&klns, &kreq, ns_ids, nr_ns_ids);
 	if (ret)
 		return ret;
 
 	if (kreq.user_ns_id)
-		ret = do_listns_userns(&klns);
-	else
-		ret = do_listns(&klns);
-	if (ret <= 0)
-		return ret;
+		return do_listns_userns(&klns);
 
-	if (copy_to_user(ns_ids, klns.kns_ids, ret * sizeof(*ns_ids)))
-		return -EFAULT;
-
-	return ret;
+	return do_listns(&klns);
 }

