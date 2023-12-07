Return-Path: <linux-fsdevel+bounces-5085-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F3267807E83
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 03:32:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E8A1B2105A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 02:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B5D186B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 02:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Ar1MDqmX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03294D4B;
	Wed,  6 Dec 2023 18:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=VnNxPtULTHkI7+FJBFkxvuhGf4itUHcJaix/h4kMFWk=; b=Ar1MDqmXci7Shf383eNOiYpJEG
	Xcy3OFqNU4GSO5sHlexxo6Frj3D0bdK7t+mK8aor2Jpel1HIT2ag9M92CZVM0cOjQo9Wnom0g3UGp
	qx76DkqvBHRVUEP1ZUJKw+GvsKnrHxL5YjJ6SUVJMaeIIsGd5JuJlFvnpM0RIYLRjuRROrME0JNen
	Amge3ULWWLEFE2Mh5jcjAbSVWVNTsgHByvrf/xDNoMfbt62eVJXxNcbY7h2IUvONyfrwyI6Nl0SLP
	enz2SulFtL40+bB9YOQ9gbkdJzFPm8Zup2rbNIfhNAkSwgxkLHPAQuHR2xO0Sv6mD34zqUsZTX975
	vhdOn4gg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rB43R-00831U-1R;
	Thu, 07 Dec 2023 02:23:57 +0000
Date: Thu, 7 Dec 2023 02:23:57 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Dave Chinner <david@fromorbit.com>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-cachefs@redhat.com, dhowells@redhat.com, gfs2@lists.linux.dev,
	dm-devel@lists.linux.dev, linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/11] lib/dlock-list: Distributed and lock-protected
 lists
Message-ID: <20231207022357.GS1674809@ZenIV>
References: <20231206060629.2827226-1-david@fromorbit.com>
 <20231206060629.2827226-2-david@fromorbit.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206060629.2827226-2-david@fromorbit.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Dec 06, 2023 at 05:05:30PM +1100, Dave Chinner wrote:

> +static inline struct dlock_list_node *
> +__dlock_list_next_entry(struct dlock_list_node *curr,
> +			struct dlock_list_iter *iter)
> +{
> +	/*
> +	 * Find next entry
> +	 */
> +	if (curr)
> +		curr = list_next_entry(curr, list);
> +
> +	if (!curr || (&curr->list == &iter->entry->list)) {

Hmm...  hlist, perhaps?  I mean, that way the thing becomes
	if (curr)
		curr = hlist_entry_safe(curr->node.next,
					struct dlock_list_node, node);
	if (!curr)
		curr = __dlock_list_next_list(iter);
	return curr;

BTW, does anybody have objections against

#define hlist_first_entry(head, type, member)
	hlist_entry_safe((head)->first, type, member)

#define hlist_next_entry(pos, member)
	hlist_entry_safe((pos)->member.next, typeof(*pos), member)

added in list.h?

> +static int __init cpu2idx_init(void)
> +{
> +	int idx, cpu;
> +
> +	idx = 0;
> +	for_each_possible_cpu(cpu)
> +		per_cpu(cpu2idx, cpu) = idx++;
> +	return 0;
> +}
> +postcore_initcall(cpu2idx_init);

Is it early enough?  Feels like that ought to be done from smp_init() or
right after it...

> +/**
> + * dlock_lists_empty - Check if all the dlock lists are empty
> + * @dlist: Pointer to the dlock_list_heads structure
> + * Return: true if list is empty, false otherwise.
> + *
> + * This can be a pretty expensive function call. If this function is required
> + * in a performance critical path, we may have to maintain a global count
> + * of the list entries in the global dlock_list_heads structure instead.
> + */
> +bool dlock_lists_empty(struct dlock_list_heads *dlist)
> +{
> +	int idx;
> +
> +	for (idx = 0; idx < nr_cpu_ids; idx++)
> +		if (!list_empty(&dlist->heads[idx].list))
> +			return false;
> +	return true;
> +}

Umm...  How would one use it, anyway?  You'd need to stop all insertions
first, wouldn't you?

> + */
> +struct dlock_list_node *__dlock_list_next_list(struct dlock_list_iter *iter)
> +{
> +	struct dlock_list_node *next;
> +	struct dlock_list_head *head;
> +
> +restart:
> +	if (iter->entry) {
> +		spin_unlock(&iter->entry->lock);
> +		iter->entry = NULL;
> +	}
> +
> +next_list:
> +	/*
> +	 * Try next list
> +	 */
> +	if (++iter->index >= nr_cpu_ids)
> +		return NULL;	/* All the entries iterated */
> +
> +	if (list_empty(&iter->head[iter->index].list))
> +		goto next_list;
> +
> +	head = iter->entry = &iter->head[iter->index];
> +	spin_lock(&head->lock);
> +	/*
> +	 * There is a slight chance that the list may become empty just
> +	 * before the lock is acquired. So an additional check is
> +	 * needed to make sure that a valid node will be returned.
> +	 */
> +	if (list_empty(&head->list))
> +		goto restart;
> +
> +	next = list_entry(head->list.next, struct dlock_list_node,
> +			  list);
> +	WARN_ON_ONCE(next->head != head);
> +
> +	return next;
> +}

Perhaps something like

	if (iter->entry) {
		spin_unlock(&iter->entry->lock);
		iter->entry = NULL;
	}
	while (++iter->index < nr_cpu_ids) {
		struct dlock_list_head *head = &iter->head[iter->index];

		if (list_empty(head->list))
			continue;

		spin_lock(&head->lock);
		// recheck under lock
		if (unlikely(list_empty(&head->list))) {
			spin_unlock(&head->lock);
			continue;
		}

		iter->entry = head;
		next = list_first_entry(&head->list,
					struct dlock_list_node, list);
		WARN_ON_ONCE(next->head != head);
		return next;
	}
	return NULL;

