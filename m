Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD0281CB978
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 May 2020 23:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbgEHVIF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 May 2020 17:08:05 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:29477 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727828AbgEHVIE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 May 2020 17:08:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588972082;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=51tOjAmGuPsQ8dYkV+2UxiGwYwlSXctoheg2IBU0/Os=;
        b=YbV1OwYEWQL1BM1/2X02Da8OWq+PRiAmpOlvFXZ4UyL7juXz4eQQ5KxVknnBOmDSwIxiLJ
        Oa3nOLMKcyM+/sQDVcCrbu/H7RYykBh+R9mkjrv/ZFq7877ypKAztFAJCQPlL1uN+oG8XZ
        N7mAVw8PpSLU/mk54d5L5ijzzpuAT0M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-460-QKkOAGwFOJmYIONrrCIoCQ-1; Fri, 08 May 2020 17:07:58 -0400
X-MC-Unique: QKkOAGwFOJmYIONrrCIoCQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 50978872FE4;
        Fri,  8 May 2020 21:07:57 +0000 (UTC)
Received: from llong.remote.csb (ovpn-117-83.rdu2.redhat.com [10.10.117.83])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 46D88707D3;
        Fri,  8 May 2020 21:07:56 +0000 (UTC)
Subject: Re: [PATCH RFC 8/8] dcache: prevent flooding with negative dentries
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>
References: <158893941613.200862.4094521350329937435.stgit@buzz>
 <158894061332.200862.9812452563558764287.stgit@buzz>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <b3e29b86-7231-fcd1-3dbf-224bb82b079f@redhat.com>
Date:   Fri, 8 May 2020 17:07:55 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <158894061332.200862.9812452563558764287.stgit@buzz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/8/20 8:23 AM, Konstantin Khlebnikov wrote:
> Without memory pressure count of negative dentries isn't bounded.
> They could consume all memory and drain all other inactive caches.
>
> Typical scenario is an idle system where some process periodically creates
> temporary files and removes them. After some time, memory will be filled
> with negative dentries for these random file names. Reclaiming them took
> some time because slab frees pages only when all related objects are gone.
> Time of dentry lookup is usually unaffected because hash table grows along
> with size of memory. Unless somebody especially crafts hash collisions.
> Simple lookup of random names also generates negative dentries very fast.
>
> This patch implements heuristic which detects such scenarios and prevents
> unbounded growth of completely unneeded negative dentries. It keeps up to
> three latest negative dentry in each bucket unless they were referenced.
>
> At first dput of negative dentry when it swept to the tail of siblings
> we'll also clear it's reference flag and look at next dentries in chain.
> Then kill third in series of negative, unused and unreferenced denries.
>
> This way each hash bucket will preserve three negative dentry to let them
> get reference and survive. Adding positive or used dentry into hash chain
> also protects few recent negative dentries. In result total size of dcache
> asymptotically limited by count of buckets and positive or used dentries.
>
> Before patch: tool 'dcache_stress' could fill entire memory with dentries.
>
> nr_dentry = 104913261   104.9M
> nr_buckets = 8388608    12.5 avg
> nr_unused = 104898729   100.0%
> nr_negative = 104883218 100.0%
>
> After this patch count of dentries saturates at around 3 per bucket:
>
> nr_dentry = 24619259    24.6M
> nr_buckets = 8388608    2.9 avg
> nr_unused = 24605226    99.9%
> nr_negative = 24600351  99.9%
>
> This heuristic isn't bulletproof and solves only most practical case.
> It's easy to deceive: just touch same random name twice.
>
> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> ---
>   fs/dcache.c |   54 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 54 insertions(+)
>
> diff --git a/fs/dcache.c b/fs/dcache.c
> index 60158065891e..9f3d331b4978 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -632,6 +632,58 @@ static inline struct dentry *lock_parent(struct dentry *dentry)
>   	return __lock_parent(dentry);
>   }
>   
> +/*
> + * Called at first dput of each negative dentry.
> + * Prevents filling cache with never reused negative dentries.
> + *
> + * This clears reference and then looks at following dentries in hash chain.
> + * If they are negative, unused and unreferenced then keep two and kill third.
> + */
> +static void trim_negative(struct dentry *dentry)
> +	__releases(dentry->d_lock)
> +{
> +	struct dentry *victim, *parent;
> +	struct hlist_bl_node *next;
> +	int keep = 2;
> +
> +	rcu_read_lock();
> +
> +	dentry->d_flags &= ~DCACHE_REFERENCED;
> +	spin_unlock(&dentry->d_lock);
> +
> +	next = rcu_dereference_raw(dentry->d_hash.next);
> +	while (1) {
> +		victim = hlist_bl_entry(next, struct dentry, d_hash);
> +
> +		if (!next || d_count(victim) || !d_is_negative(victim) ||
> +		    (victim->d_flags & DCACHE_REFERENCED)) {
> +			rcu_read_unlock();
> +			return;
> +		}
> +
> +		if (!keep--)
> +			break;
> +
> +		next = rcu_dereference_raw(next->next);
> +	}
> +
> +	spin_lock(&victim->d_lock);
> +	parent = lock_parent(victim);
> +
> +	rcu_read_unlock();
> +
> +	if (d_count(victim) || !d_is_negative(victim) ||
> +	    (victim->d_flags & DCACHE_REFERENCED)) {
> +		if (parent)
> +			spin_unlock(&parent->d_lock);
> +		spin_unlock(&victim->d_lock);
> +		return;
> +	}
> +
> +	__dentry_kill(victim);
> +	dput(parent);
> +}

Since you are picking a victim from the hash list, I think it is better 
to kill it only if it has already been in the LRU. Otherwise, it could 
be in the process of being instantiated or in the middle of some operations.

Besides, I feel a bit uneasy about picking a random negative dentry to 
kill like that.

Cheers,
Longman

