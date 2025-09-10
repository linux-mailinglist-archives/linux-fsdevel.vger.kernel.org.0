Return-Path: <linux-fsdevel+bounces-60739-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EFA9B50FA0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 09:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFCD417A655
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 07:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A078D30BF6C;
	Wed, 10 Sep 2025 07:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Tfuwk8q9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6B234CDD
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Sep 2025 07:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757489946; cv=none; b=Zd+irlVXL+o7MytjYCbjizzTQwVDQKRuw5buXeE2CtdR63v5W6H9+pfwBT1LnPq8c9lgYifLV8ixbQ6k7Xk/6jPttANAas/e+BG3ktZpSQgJlinQst/fRNN0oii4pGQ9XtZEq2mO4Z7OGuvbHmD0NhEjbZtMnwbcYWTZHlPew9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757489946; c=relaxed/simple;
	bh=w0Jv7GNyL9/zUxDACagQ8HWDv7Fg94c5/+VONATQV2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ag+goHcVS0H9XLGmdj1HHHcDGjms/c73VlyrwSMoSU7mQWMf1VnnP4YmbZNLMGCX+PzN11nW8EyQnFRA+LwgZ5aDCw+dh/su3ymLGGxbP2Vi0mRxi1iUV8bhCBrlNjUg76dbNuESuHIVQLtp8/TLf9/hPqSQWhUZNwE7b74tsx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Tfuwk8q9; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7724cacc32bso5107016b3a.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Sep 2025 00:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1757489943; x=1758094743; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=amhdj6MOEhyly+/5boSIJUaEeiy//aQ5RS0+3yOj7Ek=;
        b=Tfuwk8q90E8Krcvgs3NaoiXyNjYRdIzPtzC/54X++ZNN4JsKF63GBzJLgTpQt3Coav
         MDcCQ/8dFdemH5rvZjyqYWocVGdTUC10F42yHRoi+tyerkMVN1mNJ5skxvt9lSR4xmBx
         9QJvS5Do1uzmwbztzafRMrF2rqAcLwS0xAI4QLTFusi9OYslvauaLJDRHDOlANvO7mbb
         w6ZVpeN0sYCStMcGA/ouDGYWFuBNrLSOBSohbd9joeIZsfkeUUv/tlkwA75zh4J64qY5
         GZzWuwnIEwoFf6tld21630I9JWiG4riEJ8fO8qD9n4/4QoLsB23wnBbiYEpKx5+30u3k
         wY3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757489943; x=1758094743;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=amhdj6MOEhyly+/5boSIJUaEeiy//aQ5RS0+3yOj7Ek=;
        b=NqJsw3RTjdaq+yo1326tfBn05wePJDT+3i+aFHx+sf4W0f6P5DRRTdEyCbFyU0qv13
         AqTY2vWK+27pAxRoO6gjtq9Uyg07Yd3GG4EP8vk+AMlwdlFIm6y4ySy5REMmoI/OnT9z
         0Ks3f3b2nyH6nE5xvVtVSvbu8kHub6ZVoVBoABZZENyA5pfWGIWTt42khqUfDpqimIrm
         SanmwiEiWZrwoH7O1OeOPC8RWdhGdVRB0EbUbg4k+356xI+whB6qZXUvt+4XYKznY3VF
         sySY9LRjZAIjPc1vrUEGw3n2h6uPJvQXgTkvuFsQR0xZF6rEsFV7uVfbuUnABzuoVn0q
         p94w==
X-Forwarded-Encrypted: i=1; AJvYcCW5jajEiUG1/9lcJJzA3Ajvb7DEfzuJHEjdrZ1cukqamAsAgy9d/tLIQpHBW4SYf57Z6bT0IoTZa6sDzReV@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk5/DXGzQS35j0nfUnFPD4aQZPIGeI0lan8xAoq149vDEYfawb
	5XquUsFOWQvQ7TfhBynWaWAbvPtMs/n23nd1WuMrZh1wZCv0DzS922KcUL7UDxL7s5U=
X-Gm-Gg: ASbGncvICuHha58FogJYxcOhnQ87nJV1w40ygJkeAI/NNmry7PXCUzUlEm/LV/TxLcN
	z7PrXqXKgovpa/fIQX1f/3w8NC24SKnLdUdzhR2WFnU/jJMJ0gzQForSPPqE8l/0A6rpZS5X3Rz
	Cwd2vDcKQ+dX6Trj8hTiyFwQsEzp8WkFyuDpGqW0m4IwH6D5Vn7fYIB8KAXtQkdnuSKUUv5wxuc
	/7DNeg/+H4GVSH8VVgF4SWTbC4s78tBQQmWvaIUdeK0h+8+lVF+eKVH+hJQNywoiXI+42fjnGP3
	4zhqXE0LEPxFmxu4ECvwurNqrP4B149dVuOftpCNiLXxX6boADe7vy5Y/Cyahg9LfTQ1rhbP6bH
	22tb14LlUFi1baLQy1wj8fJaSx0ANSFub7YIjR9xXi+2TcoJ72KDHs5aM
X-Google-Smtp-Source: AGHT+IH9Ygo2eY4mJlDFHfCvTHSy2SH/RWavdZLm5XlF9+y7C7O+224Jc3mIRhdpemTVZaLXTkfzwQ==
X-Received: by 2002:a05:6a00:3d53:b0:772:6235:7038 with SMTP id d2e1a72fcca58-7742dce0f81mr15382700b3a.10.1757489942865;
        Wed, 10 Sep 2025 00:39:02 -0700 (PDT)
Received: from H7GWF0W104 ([139.177.225.237])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-774662f9e95sm4259619b3a.98.2025.09.10.00.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 00:39:02 -0700 (PDT)
Date: Wed, 10 Sep 2025 15:38:55 +0800
From: Diangang Li <lidiangang@bytedance.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Stephen Brennan <stephen.s.brennan@oracle.com>,
	linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	Amir Goldstein <amir73il@gmail.com>,
	Fengnan Chang <changfengnan@bytedance.com>
Subject: Re: [PATCH v2 1/4] dcache: sweep cached negative dentries to the end
 of list of siblings
Message-ID: <20250910073855.GA59407@bytedance.com>
References: <20220209231406.187668-1-stephen.s.brennan@oracle.com>
 <20220209231406.187668-2-stephen.s.brennan@oracle.com>
 <YgSjo5wascR9mfnA@zeniv-ca.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgSjo5wascR9mfnA@zeniv-ca.linux.org.uk>

On Thu, Feb 10, 2022 at 05:33:23AM +0000, Al Viro wrote:
> On Wed, Feb 09, 2022 at 03:14:03PM -0800, Stephen Brennan wrote:
> 
> > +static void sweep_negative(struct dentry *dentry)
> > +{
> > +	struct dentry *parent;
> > +
> > +	rcu_read_lock();
> > +	parent = lock_parent(dentry);
> > +	if (!parent) {
> > +		rcu_read_unlock();
> > +		return;
> > +	}
> > +
> > +	/*
> > +	 * If we did not hold a reference to dentry (as in the case of dput),
> > +	 * and dentry->d_lock was dropped in lock_parent(), then we could now be
> > +	 * holding onto a dead dentry. Be careful to check d_count and unlock
> > +	 * before dropping RCU lock, otherwise we could corrupt freed memory.
> > +	 */
> > +	if (!d_count(dentry) && d_is_negative(dentry) &&
> > +		!d_is_tail_negative(dentry)) {
> > +		dentry->d_flags |= DCACHE_TAIL_NEGATIVE;
> > +		list_move_tail(&dentry->d_child, &parent->d_subdirs);
> > +	}
> > +
> > +	spin_unlock(&parent->d_lock);
> > +	spin_unlock(&dentry->d_lock);
> > +	rcu_read_unlock();
> > +}
> 
> 	I'm not sure if it came up the last time you'd posted this series
> (and I apologize if it had and I forgot the explanation), but... consider
> the comment in dentry_unlist().  What's to prevent the race described there
> making d_walk() skip a part of tree, by replacing the "lseek moving cursor
> in just the wrong moment" with "dput moving the negative dentry right next
> to the one being killed to the tail of the list"?
> 
> 	The race in question:
> d_walk() is leaving a subdirectory.  We are here:
>         rcu_read_lock();
> ascend:
>         if (this_parent != parent) {
> 
> It isn't - we are not back to the root of tree being walked.
> At this point this_parent is the directory we'd just finished looking into.
> 
>                 struct dentry *child = this_parent;
>                 this_parent = child->d_parent;
> 
> ... and now child points to it, and this_parent points to its parent.
> 
>                 spin_unlock(&child->d_lock);
> 
> No locks held.  Another CPU gets through successful rmdir().  child gets
> unhashed and dropped.  It's off the ->d_subdirs of this_parent; its
> ->d_child.next is still pointing where it used to, and whatever it points
> to won't be physically freed until rcu_read_unlock().
> 
> Moreover, in the meanwhile this next sibling (negative, pinned) got dput().
> And had been moved to the tail of the this_parent->d_subdirs.  Since
> its ->d_child.prev does *NOT* point to child (which is off-list, about to
> be freed shortly, etc.), child->d_dchild.next is not modified - it still
> points to that (now moved) sibling.
> 
>                 spin_lock(&this_parent->d_lock);
> Got it.
> 
>                 /* might go back up the wrong parent if we have had a rename. */
>                 if (need_seqretry(&rename_lock, seq))
>                         goto rename_retry;
> 
> Nope, hadn't happened.
> 
>                 /* go into the first sibling still alive */
>                 do {
>                         next = child->d_child.next;
> ... and this is the moved sibling, now in the end of the ->d_subdirs.
> 
>                         if (next == &this_parent->d_subdirs)
>                                 goto ascend;
> 
> No, it is not - it's the last element of the list, not its anchor.
> 
>                         child = list_entry(next, struct dentry, d_child);
> 
> Our moved negative dentry.
> 
>                 } while (unlikely(child->d_flags & DCACHE_DENTRY_KILLED));
> 
> Not killed, that one.
>                 rcu_read_unlock();
>                 goto resume;
> 
> ... and since that sucker has no children, we proceed to look at it,
> ascend and now we are at the end of this_parent->d_subdirs.  And we
> ascend out of it, having entirely skipped all branches that used to
> be between the rmdir victim and the end of the parent's ->d_subdirs.
> 
> What am I missing here?  Unlike the trick we used with cursors (see
> dentry_unlist()) we can't predict who won't get moved in this case...
> 
> Note that treating "child is has DCACHE_DENTRY_KILLED" same as we do
> for rename_lock mismatches would not work unless you grab the spinlock
> component of rename_lock every time dentry becomes positive.  Which
> is obviously not feasible (it's a system-wide lock and cacheline
> pingpong alone would hurt us very badly, not to mention the contention
> issues due to the frequency of grabbing it going up by several orders
> of magnitude).

Hi Al, Stephen,

How about adding a pointer in union d_u to record the original next of negative dentry
when executing `sweep_negative`, as follows:

@@ -125,6 +126,7 @@ struct dentry {
 		struct hlist_node d_alias;	/* inode alias list */
 		struct hlist_bl_node d_in_lookup_hash;	/* only for in-lookup ones */
 	 	struct rcu_head d_rcu;
+
+		/* valid between sweep_negative and recyle_negative */
+		struct hlist_node *d_sib_backup;
 	} d_u;
 };

Then, during `d_walk`, once we find a dentry with `DCACHE_DENTRY_KILLED`, and its next
with `DCACHE_TAIL_NEGATIVE`, iterate to get the genuine next dentry in d_children.

@@ -1357,8 +1405,22 @@ static void d_walk(struct dentry *parent, void *data,
    /* might go back up the wrong parent if we have had a rename. */
    if (need_seqretry(&rename_lock, seq))
        goto rename_retry;
+
+		next = hlist_entry_safe(dentry->d_sib.next, struct dentry, d_sib);
+		do {
+			if (!(next && next->d_u.d_sib_backup) ||
+			    !(dentry->d_flags & DCACHE_DENTRY_KILLED) ||
+			    !(next->d_flags & DCACHE_TAIL_NEGATIVE)) {
+				dentry = next;
+				break;
+			}
+			dentry = hlist_entry_safe(next->d_u.d_sib_backup, struct dentry, d_sib);
+			next = hlist_entry_safe(dentry->d_sib.next, struct dentry, d_sib);
+		} while (true);
+
		/* go into the first sibling still alive */
-		hlist_for_each_entry_continue(dentry, d_sib) {
+		hlist_for_each_entry_from(dentry, d_sib) {

And since `d_children` changed from `list_head` to `hlist_head`, we cannot move a negative dentry
to the tail of d_children directly. Instead, add another `d_negative` list to cache negative
dentries. For the majority of d_children traversal, we only care about positive dentries.

@@ -118,6 +118,7 @@ struct dentry {
 	};
 	struct hlist_node d_sib;	/* child of parent list */
 	struct hlist_head d_children;	/* our children */
+	struct hlist_head d_negative;	/* cached negative dentries */

The commit `41f49be2e51a71` ("fsnotify: clear PARENT_WATCHED flags lazily") has resolved the
softlockup in `__fsnotify_parent`, but we are still seeing softlockup in `fsnotify_recalc_mask`
when adding watches with millions of negative dentries. As noted in [1], we have encountered the
same issue. In our case, the negative dentries are accumulated primarily by opening non-existent
files. The `dentry-negative` sysctl introduced in commit `e6957c99dca5f`
("vfs: Add a sysctl for automated deletion of dentry") does not seem to have any effect in our
scenario. Given this, we believe that splitting the `d_children` list into positive and negative
dentries, and skipping the negatives in `fsnotify_set_children_dentry_flags`, is still a
valuable approach.

[1] https://lore.kernel.org/linux-fsdevel/CAJfpegs+czRD1=s+o5yNoOp13xH+utQ8jQkJ9ec5283MNT_xmg@mail.gmail.com/


Regards,
Diangang

