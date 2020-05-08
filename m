Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA1781CB86E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 May 2020 21:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbgEHTjG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 May 2020 15:39:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25781 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727785AbgEHTjF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 May 2020 15:39:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588966743;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WvM/+trhO6AMazPvr+ThgaIhqSMkk3F1gyxpsCTl3qk=;
        b=cwJoDALiYltfoe278W6HxjwVmvqH1OLwtrhkRyNpoITRqofrJ1VT4yn9mZPA+kOsm49wDq
        QPcEDd1FVWOu/kcW78n6gXxf1TRnCNho7QGs5drSTDIw75IUdbZ6Hro3ZfiKQunajCE3+c
        q6VDxo2RzOh0Suiapx5t9gxIdUFm254=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-Sx3SF5doMVms-by8Lqcfpg-1; Fri, 08 May 2020 15:39:02 -0400
X-MC-Unique: Sx3SF5doMVms-by8Lqcfpg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D74AA464;
        Fri,  8 May 2020 19:39:00 +0000 (UTC)
Received: from llong.remote.csb (ovpn-117-83.rdu2.redhat.com [10.10.117.83])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EB7001C9;
        Fri,  8 May 2020 19:38:59 +0000 (UTC)
Subject: Re: [PATCH RFC 3/8] dcache: sweep cached negative dentries to the end
 of list of siblings
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>
References: <158893941613.200862.4094521350329937435.stgit@buzz>
 <158894060021.200862.15936671684100629802.stgit@buzz>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <9b5d75d0-d627-2b53-10eb-a850bace091b@redhat.com>
Date:   Fri, 8 May 2020 15:38:59 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <158894060021.200862.15936671684100629802.stgit@buzz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/8/20 8:23 AM, Konstantin Khlebnikov wrote:
> For disk filesystems result of every negative lookup is cached, content of
> directories is usually cached too. Production of negative dentries isn't
> limited with disk speed. It's really easy to generate millions of them if
> system has enough memory. Negative dentries are linked into siblings list
> along with normal positive dentries. Some operations walks dcache tree but
> looks only for positive dentries: most important is fsnotify/inotify.
>
> This patch moves negative dentries to the end of list at final dput() and
> marks with flag which tells that all following dentries are negative too.
> Reverse operation is required before instantiating negative dentry.
>
> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> ---
>   fs/dcache.c            |   63 ++++++++++++++++++++++++++++++++++++++++++++++--
>   include/linux/dcache.h |    6 +++++
>   2 files changed, 66 insertions(+), 3 deletions(-)
>
> diff --git a/fs/dcache.c b/fs/dcache.c
> index 386f97eaf2ff..743255773cc7 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -632,6 +632,48 @@ static inline struct dentry *lock_parent(struct dentry *dentry)
>   	return __lock_parent(dentry);
>   }
>   
> +/*
> + * Move cached negative dentry to the tail of parent->d_subdirs.
> + * This lets walkers skip them all together at first sight.
> + * Must be called at dput of negative dentry.
> + */
> +static void sweep_negative(struct dentry *dentry)
> +{
> +	struct dentry *parent;
> +
> +	if (!d_is_tail_negative(dentry)) {
> +		parent = lock_parent(dentry);
> +		if (!parent)
> +			return;
> +
> +		if (!d_count(dentry) && d_is_negative(dentry) &&
> +		    !d_is_tail_negative(dentry)) {
> +			dentry->d_flags |= DCACHE_TAIL_NEGATIVE;
> +			list_move_tail(&dentry->d_child, &parent->d_subdirs);
> +		}
> +
> +		spin_unlock(&parent->d_lock);
> +	}
> +}
> +
> +/*
> + * Undo sweep_negative() and move to the head of parent->d_subdirs.
> + * Must be called before converting negative dentry into positive.
> + */
> +static void recycle_negative(struct dentry *dentry)
> +{
> +	struct dentry *parent;
> +
> +	spin_lock(&dentry->d_lock);
> +	parent = lock_parent(dentry);
> +	if (parent) {
> +		list_move(&dentry->d_child, &parent->d_subdirs);
> +		spin_unlock(&parent->d_lock);
> +	}
> +	dentry->d_flags &= ~DCACHE_TAIL_NEGATIVE;
> +	spin_unlock(&dentry->d_lock);
> +}
> +

The name sweep_negative and recycle_negative are not very descriptive of 
what the function is doing (especially the later one). I am not good at 
naming, but some kind of naming scheme that can clearly show one is 
opposite of another will be better.


>   static inline bool retain_dentry(struct dentry *dentry)
>   {
>   	WARN_ON(d_in_lookup(dentry));
> @@ -703,6 +745,8 @@ static struct dentry *dentry_kill(struct dentry *dentry)
>   		spin_unlock(&inode->i_lock);
>   	if (parent)
>   		spin_unlock(&parent->d_lock);
> +	if (d_is_negative(dentry))
> +		sweep_negative(dentry);
We can potentially save an unneeded lock/unlock pair by moving it up 
before "if (parent)" and pass in a flag to indicate if the parent lock 
is being held.
>   	spin_unlock(&dentry->d_lock);
>   	return NULL;
>   }
> @@ -718,7 +762,7 @@ static struct dentry *dentry_kill(struct dentry *dentry)
>   static inline bool fast_dput(struct dentry *dentry)
>   {
>   	int ret;
> -	unsigned int d_flags;
> +	unsigned int d_flags, required;
>   
>   	/*
>   	 * If we have a d_op->d_delete() operation, we sould not
> @@ -766,6 +810,8 @@ static inline bool fast_dput(struct dentry *dentry)
>   	 * a 'delete' op, and it's referenced and already on
>   	 * the LRU list.
>   	 *
> +	 * Cached negative dentry must be swept to the tail.
> +	 *
>   	 * NOTE! Since we aren't locked, these values are
>   	 * not "stable". However, it is sufficient that at
>   	 * some point after we dropped the reference the
> @@ -777,10 +823,15 @@ static inline bool fast_dput(struct dentry *dentry)
>   	 */
>   	smp_rmb();
>   	d_flags = READ_ONCE(dentry->d_flags);
> -	d_flags &= DCACHE_REFERENCED | DCACHE_LRU_LIST | DCACHE_DISCONNECTED;
> +
> +	required = DCACHE_REFERENCED | DCACHE_LRU_LIST |
> +		   (d_flags_negative(d_flags) ? DCACHE_TAIL_NEGATIVE : 0);
> +
> +	d_flags &= DCACHE_REFERENCED | DCACHE_LRU_LIST |
> +		   DCACHE_DISCONNECTED | DCACHE_TAIL_NEGATIVE;
>   
>   	/* Nothing to do? Dropping the reference was all we needed? */
> -	if (d_flags == (DCACHE_REFERENCED | DCACHE_LRU_LIST) && !d_unhashed(dentry))
> +	if (d_flags == required && !d_unhashed(dentry))
>   		return true;
>   
>   	/*
> @@ -852,6 +903,8 @@ void dput(struct dentry *dentry)
>   		rcu_read_unlock();
>   
>   		if (likely(retain_dentry(dentry))) {
> +			if (d_is_negative(dentry))
> +				sweep_negative(dentry);
>   			spin_unlock(&dentry->d_lock);
>   			return;
>   		}
> @@ -1951,6 +2004,8 @@ void d_instantiate(struct dentry *entry, struct inode * inode)
>   {
>   	BUG_ON(!hlist_unhashed(&entry->d_u.d_alias));
>   	if (inode) {
> +		if (d_is_tail_negative(entry))
> +			recycle_negative(entry);

Will it better to recycle_negative() inside __d_instantiate() under the 
d_lock. That reduces the number of lock/unlock you need to do and 
eliminate the need to change d_instantiate_new().

Cheers,
Longman

