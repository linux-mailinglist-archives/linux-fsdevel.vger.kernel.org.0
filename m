Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C98F2331F3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jul 2020 14:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbgG3MXs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jul 2020 08:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbgG3MXr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jul 2020 08:23:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A600FC061794;
        Thu, 30 Jul 2020 05:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IT3v0Hh8vnx5zaKRHtOH95ARGWeTEDbEFgcfcKeku4Y=; b=o1Z+YuKKUhGP2mMcZG3HwQ1XDy
        +g0pF/YGFnpA5Ik90W5jj8n0UfvoB2rQCfKsHtmFCuhVTTILtbQZA4P57BVJJbTB16Wto5krB2G+m
        AOXUgzisnmWPRIQV3t88b9j3QCKkherCng35P6EslkIqnUJryw+SfoUs3pOTNw3koaw4giJonUQ/6
        fgcDNMGdWZeLJ+9OG1l3isRH9QrXD9+iCDbiAxuIsvCrl8CS5Up02idOVJ+YWdNAzfu7RNrH7JhmN
        n/oBpDtvfnFHISXfG6SpoaSPoUXJS/8wfxiMOsv/buoV7hY3RwsMjiLj5Ykgsyy2LQL8khawvWd7T
        A9trhPYA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k17ah-0003nb-UL; Thu, 30 Jul 2020 12:23:20 +0000
Date:   Thu, 30 Jul 2020 13:23:19 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     viro@zeniv.linux.org.uk, adobriyan@gmail.com, davem@davemloft.net,
        ebiederm@xmission.com, akpm@linux-foundation.org,
        christian.brauner@ubuntu.com, areber@redhat.com, serge@hallyn.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 09/23] ns: Introduce ns_idr to be able to iterate all
 allocated namespaces in the system
Message-ID: <20200730122319.GC23808@casper.infradead.org>
References: <159611007271.535980.15362304262237658692.stgit@localhost.localdomain>
 <159611040870.535980.13460189038999722608.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159611040870.535980.13460189038999722608.stgit@localhost.localdomain>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 30, 2020 at 03:00:08PM +0300, Kirill Tkhai wrote:
> This patch introduces a new IDR and functions to add/remove and iterate
> registered namespaces in the system. It will be used to list namespaces
> in /proc/namespaces/... in next patches.

Looks like you could use an XArray for this and it would be fewer lines of
code.

>  
>  static struct vfsmount *nsfs_mnt;
> +static DEFINE_SPINLOCK(ns_lock);
> +static DEFINE_IDR(ns_idr);

XArray includes its own spinlock.

> +/*
> + * Add a newly created ns to ns_idr. The ns must be fully
> + * initialized since it becomes available for ns_get_next()
> + * right after we exit this function.
> + */
> +int ns_idr_register(struct ns_common *ns)
> +{
> +	int ret, id = ns->inum - PROC_NS_MIN_INO;
> +
> +	if (WARN_ON(id < 0))
> +		return -EINVAL;
> +
> +	idr_preload(GFP_KERNEL);
> +	spin_lock_irq(&ns_lock);
> +	ret = idr_alloc(&ns_idr, ns, id, id + 1, GFP_ATOMIC);
> +	spin_unlock_irq(&ns_lock);
> +	idr_preload_end();
> +	return ret < 0 ? ret : 0;

This would simply be return xa_insert_irq(...);

> +}
> +
> +/*
> + * Remove a dead ns from ns_idr. Note, that ns memory must
> + * be freed not earlier then one RCU grace period after
> + * this function, since ns_get_next() uses RCU to iterate the IDR.
> + */
> +void ns_idr_unregister(struct ns_common *ns)
> +{
> +	int id = ns->inum - PROC_NS_MIN_INO;
> +	unsigned long flags;
> +
> +	if (WARN_ON(id < 0))
> +		return;
> +
> +	spin_lock_irqsave(&ns_lock, flags);
> +	idr_remove(&ns_idr, id);
> +	spin_unlock_irqrestore(&ns_lock, flags);
> +}

xa_erase_irqsave();

> +
> +/*
> + * This returns ns with inum greater than @id or NULL.
> + * @id is updated to refer the ns inum.
> + */
> +struct ns_common *ns_get_next(unsigned int *id)
> +{
> +	struct ns_common *ns;
> +
> +	if (*id < PROC_NS_MIN_INO - 1)
> +		*id = PROC_NS_MIN_INO - 1;
> +
> +	*id += 1;
> +	*id -= PROC_NS_MIN_INO;
> +
> +	rcu_read_lock();
> +	do {
> +		ns = idr_get_next(&ns_idr, id);
> +		if (!ns)
> +			break;

xa_find_after();

You'll want a temporary unsigned long to work with ...

> +		if (!refcount_inc_not_zero(&ns->count)) {
> +			ns = NULL;
> +			*id += 1;

you won't need this increment.

