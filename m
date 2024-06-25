Return-Path: <linux-fsdevel+bounces-22356-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A499F916926
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 15:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C781B23E2E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 13:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4158615FA7C;
	Tue, 25 Jun 2024 13:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dl4RF2WV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A513F15F31D
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jun 2024 13:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719322799; cv=none; b=CZelVrUmKKMzpE/A64dJoVWKyEkTISbcLdy4X1jI4XCJOddza2YNhjC2qs0AbMcscZfwnmh4M/Veqc5gHpmpeAvxX07BKJDGVa/Ddt+nGXwydfOKTwSCqN71pUrJ624CAvzGzFQVYyKzAOTOjvewKYm8OyNhKUiI/ndUvAOpafg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719322799; c=relaxed/simple;
	bh=5To5uKUyWMRZ95WUyglljS6cWXaCKHmjhhbDaSK1P78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jTl+hsqLWgLCvcf+0P+0oppOz2BMYKRqYDlWUsI2rxZJxeifUfiLC4MkEqUQlWMKCazZiLBsOs3VQY0jqehMvoHw7martnSmOOg/BqZMRgZbYof9IX7k4K1ldnhhORYy8qCVzQLRDJGFrb4KvvxfOEpeuf7FPAEPwEPUslpaxfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dl4RF2WV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF119C32781;
	Tue, 25 Jun 2024 13:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719322799;
	bh=5To5uKUyWMRZ95WUyglljS6cWXaCKHmjhhbDaSK1P78=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dl4RF2WVmJZ9bIkW5QuYLzmRyEy8nLuiVW2BwULZk2jXzG5aHtDbofy6oklrnXZhJ
	 FPKVcILIyRg3BM7IxzgYkFYz5G5jfVv9LgEcew3fp72IkXKbw9cuZnGFya2Q8NVJPN
	 JTQEzY/DIh5RM9qrEKkCsmnlHIC377ydjAI4Ul9A8/LQuLyBJUf10f8ZwUNNAgigYa
	 vq/4K5MKzCDoy/LvZ/q0kmj/zC9Zmd/KOYBPNjNI/svd5+S/qhJGiJn6ePwh/v35Iv
	 bUR0c/mzIgYqgfVh9q36q4+OZVglZAx7anuAxgQzgOisr5AwPJoSuNR4Uf0uGK6rmJ
	 zEu0Bagu9SjzA==
Date: Tue, 25 Jun 2024 15:39:55 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org, 
	kernel-team@fb.com
Subject: Re: [PATCH 3/8] fs: keep an index of current mount namespaces
Message-ID: <20240625-prall-gelenk-753f382e6608@brauner>
References: <cover.1719243756.git.josef@toxicpanda.com>
 <e5fdd78a90f5b00a75bd893962a70f52a2c015cd.1719243756.git.josef@toxicpanda.com>
 <050ce2c523cc6f2651da4ca50aae1544c5b09730.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <050ce2c523cc6f2651da4ca50aae1544c5b09730.camel@kernel.org>

On Tue, Jun 25, 2024 at 09:03:03AM GMT, Jeff Layton wrote:
> On Mon, 2024-06-24 at 11:49 -0400, Josef Bacik wrote:
> > In order to allow for listmount() to be used on different namespaces we
> > need a way to lookup a mount ns by its id.  Keep a rbtree of the current
> > !anonymous mount name spaces indexed by ID that we can use to look up
> > the namespace.
> > 
> > Co-developed-by: Christian Brauner <brauner@kernel.org>
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > ---
> >  fs/mount.h     |   2 +
> >  fs/namespace.c | 113 ++++++++++++++++++++++++++++++++++++++++++++++++-
> >  2 files changed, 113 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/mount.h b/fs/mount.h
> > index 4adce73211ae..ad4b1ddebb54 100644
> > --- a/fs/mount.h
> > +++ b/fs/mount.h
> > @@ -16,6 +16,8 @@ struct mnt_namespace {
> >  	u64 event;
> >  	unsigned int		nr_mounts; /* # of mounts in the namespace */
> >  	unsigned int		pending_mounts;
> > +	struct rb_node		mnt_ns_tree_node; /* node in the mnt_ns_tree */
> > +	refcount_t		passive; /* number references not pinning @mounts */
> >  } __randomize_layout;
> >  
> >  struct mnt_pcp {
> > diff --git a/fs/namespace.c b/fs/namespace.c
> > index 45df82f2a059..babdebdb0a9c 100644
> > --- a/fs/namespace.c
> > +++ b/fs/namespace.c
> > @@ -78,6 +78,8 @@ static struct kmem_cache *mnt_cache __ro_after_init;
> >  static DECLARE_RWSEM(namespace_sem);
> >  static HLIST_HEAD(unmounted);	/* protected by namespace_sem */
> >  static LIST_HEAD(ex_mountpoints); /* protected by namespace_sem */
> > +static DEFINE_RWLOCK(mnt_ns_tree_lock);
> > +static struct rb_root mnt_ns_tree = RB_ROOT; /* protected by namespace_sem */
> >  
> >  struct mount_kattr {
> >  	unsigned int attr_set;
> > @@ -103,6 +105,109 @@ EXPORT_SYMBOL_GPL(fs_kobj);
> >   */
> >  __cacheline_aligned_in_smp DEFINE_SEQLOCK(mount_lock);
> >  
> > +static int mnt_ns_cmp(u64 seq, const struct mnt_namespace *ns)
> > +{
> > +	u64 seq_b = ns->seq;
> > +
> > +	if (seq < seq_b)
> > +		return -1;
> > +	if (seq > seq_b)
> > +		return 1;
> > +	return 0;
> > +}
> > +
> > +static inline struct mnt_namespace *node_to_mnt_ns(const struct rb_node *node)
> > +{
> > +	if (!node)
> > +		return NULL;
> > +	return rb_entry(node, struct mnt_namespace, mnt_ns_tree_node);
> > +}
> > +
> > +static bool mnt_ns_less(struct rb_node *a, const struct rb_node *b)
> > +{
> > +	struct mnt_namespace *ns_a = node_to_mnt_ns(a);
> > +	struct mnt_namespace *ns_b = node_to_mnt_ns(b);
> > +	u64 seq_a = ns_a->seq;
> > +
> > +	return mnt_ns_cmp(seq_a, ns_b) < 0;
> > +}
> > +
> > +static void mnt_ns_tree_add(struct mnt_namespace *ns)
> > +{
> > +	guard(write_lock)(&mnt_ns_tree_lock);
> > +	rb_add(&ns->mnt_ns_tree_node, &mnt_ns_tree, mnt_ns_less);
> > +}
> > +
> > +static void mnt_ns_release(struct mnt_namespace *ns)
> > +{
> > +	lockdep_assert_not_held(&mnt_ns_tree_lock);
> > +
> 
> Why is it bad to hold this lock here? AFAICT, put_user_ns just does a
> schedule_work when the counter goes to 0. Granted, I don't see a reason
> why you would want to hold it here, but usually that sort of assertion
> means that it _must_ be forbidden.

I just annotate locking assumptions liberally. There's no reason to take
the lock there and there's no current codepath that needs to hold it so
don't waste cycles and hold it when we don't have to.

