Return-Path: <linux-fsdevel+bounces-23052-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D05B69266A7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 19:02:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E15A1F2361C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 17:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB316183097;
	Wed,  3 Jul 2024 17:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ej4jpF7G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2D6170836
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jul 2024 17:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720026151; cv=none; b=iAcs79Hocy979jYVOxv0YxUmhIUhvFwYArV8vYmLBrz5VQ10dLQOT+y3MJxqFsJDap59B29eVbInOYAHCGNXh2/Vwrb0fycUGbb4ckCMdMZ5CHTXSS2iP6NEQZqqk+SvAoHsf4ocHnbb82O73AnvptP4g0YGX3RjT/YFrHcWduk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720026151; c=relaxed/simple;
	bh=g5WNjWZ76RN0wus4iHbui2J3px0NX9Md1xr/qFgmkxM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KH1rnuyjyxGxFD3dvPS79rmCweeZ6aFilp842qzYNydvpUn6KRl44+e3Z5VLbyH5a7HH0UP5BDoB/yR5Uj+AJae6oYx+RG14C6g877tViFY8F9rOlCmM7F24xwu3clisHuxqbSPHWhOBgIwvdYkEruSjzBBPR2H7B1nFv6lv+uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ej4jpF7G; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720026148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kpg3siekmk/AagbLtthyAfHOPTR1/TLkS4FSt5H0BRE=;
	b=Ej4jpF7GdtABFQmcB8L5HW79B8zE8i0GuZU+8bzyfshMdMwIqkFbyf4tsaQjGdAFjGMwCl
	wtBQfEjFQIPZhlJk/VXX0+QVBs21/pBDq9tVLH6ErU5psfd0vT0UfozmJxhBQXPlBQHWRH
	n3+5P1m1ppM9H5V+R5S89nZdHt4VOJ0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-369-xlmb1lGqO96TB03CToluPA-1; Wed,
 03 Jul 2024 13:02:25 -0400
X-MC-Unique: xlmb1lGqO96TB03CToluPA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8BED4195609F;
	Wed,  3 Jul 2024 17:02:24 +0000 (UTC)
Received: from [10.22.33.252] (unknown [10.22.33.252])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7D8491954B0F;
	Wed,  3 Jul 2024 17:02:23 +0000 (UTC)
Message-ID: <fe367317-2026-4228-9f0f-563c7fe395f6@redhat.com>
Date: Wed, 3 Jul 2024 13:02:22 -0400
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] vfs: don't mod negative dentry count when on shrinker
 list
To: Brian Foster <bfoster@redhat.com>, linux-fsdevel@vger.kernel.org
Cc: Ian Kent <ikent@redhat.com>, Josef Bacik <josef@toxicpanda.com>,
 Christian Brauner <brauner@kernel.org>
References: <20240703121301.247680-1-bfoster@redhat.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20240703121301.247680-1-bfoster@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 7/3/24 08:13, Brian Foster wrote:
> The nr_dentry_negative counter is intended to only account negative
> dentries that are present on the superblock LRU. Therefore, the LRU
> add, remove and isolate helpers modify the counter based on whether
> the dentry is negative, but the shrinker list related helpers do not
> modify the counter, and the paths that change a dentry between
> positive and negative only do so if DCACHE_LRU_LIST is set.
>
> The problem with this is that a dentry on a shrinker list still has
> DCACHE_LRU_LIST set to indicate ->d_lru is in use. The additional
> DCACHE_SHRINK_LIST flag denotes whether the dentry is on LRU or a
> shrink related list. Therefore if a relevant operation (i.e. unlink)
> occurs while a dentry is present on a shrinker list, and the
> associated codepath only checks for DCACHE_LRU_LIST, then it is
> technically possible to modify the negative dentry count for a
> dentry that is off the LRU. Since the shrinker list related helpers
> do not modify the negative dentry count (because non-LRU dentries
> should not be included in the count) when the dentry is ultimately
> removed from the shrinker list, this can cause the negative dentry
> count to become permanently inaccurate.
>
> This problem can be reproduced via a heavy file create/unlink vs.
> drop_caches workload. On an 80xcpu system, I start 80 tasks each
> running a 1k file create/delete loop, and one task spinning on
> drop_caches. After 10 minutes or so of runtime, the idle/clean cache
> negative dentry count increases from somewhere in the range of 5-10
> entries to several hundred (and increasingly grows beyond
> nr_dentry_unused).
>
> Tweak the logic in the paths that turn a dentry negative or positive
> to filter out the case where the dentry is present on a shrink
> related list. This allows the above workload to maintain an accurate
> negative dentry count.
>
> Fixes: af0c9af1b3f6 ("fs/dcache: Track & report number of negative dentries")
> Signed-off-by: Brian Foster <bfoster@redhat.com>
> Acked-by: Ian Kent <ikent@redhat.com>
> ---
>
> Hi Christian,
>
> I see you already picked up v1. Josef had asked for some comment updates
> so I'm posting v2 with that, but TBH I'm not sure how useful this all is
> once one groks the flags. I have no strong opinion on it. I also added a
> Fixes: tag for the patch that added the counter.
>
> In short, feel free to grab this one, ignore this and stick with v1, or
> maybe just pull in the Fixes: tag if you agree with it. Thanks.
>
> Brian
>
> v2:
> - Update comments (Josef).
> - Add Fixes: tag, cc Waiman.
> v1: https://lore.kernel.org/linux-fsdevel/20240702170757.232130-1-bfoster@redhat.com/
>
>   fs/dcache.c | 12 +++++++++---
>   1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/fs/dcache.c b/fs/dcache.c
> index 407095188f83..66515fbc9dd7 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -355,7 +355,11 @@ static inline void __d_clear_type_and_inode(struct dentry *dentry)
>   	flags &= ~DCACHE_ENTRY_TYPE;
>   	WRITE_ONCE(dentry->d_flags, flags);
>   	dentry->d_inode = NULL;
> -	if (flags & DCACHE_LRU_LIST)
> +	/*
> +	 * The negative counter only tracks dentries on the LRU. Don't inc if
> +	 * d_lru is on another list.
> +	 */
> +	if ((flags & (DCACHE_LRU_LIST|DCACHE_SHRINK_LIST)) == DCACHE_LRU_LIST)
>   		this_cpu_inc(nr_dentry_negative);
>   }
>   
> @@ -1844,9 +1848,11 @@ static void __d_instantiate(struct dentry *dentry, struct inode *inode)
>   
>   	spin_lock(&dentry->d_lock);
>   	/*
> -	 * Decrement negative dentry count if it was in the LRU list.
> +	 * The negative counter only tracks dentries on the LRU. Don't dec if
> +	 * d_lru is on another list.
>   	 */
> -	if (dentry->d_flags & DCACHE_LRU_LIST)
> +	if ((dentry->d_flags &
> +	     (DCACHE_LRU_LIST|DCACHE_SHRINK_LIST)) == DCACHE_LRU_LIST)
>   		this_cpu_dec(nr_dentry_negative);
>   	hlist_add_head(&dentry->d_u.d_alias, &inode->i_dentry);
>   	raw_write_seqcount_begin(&dentry->d_seq);

Thanks for fixing it.

Reviewed-by: Waiman Long <longman@redhat.com>


