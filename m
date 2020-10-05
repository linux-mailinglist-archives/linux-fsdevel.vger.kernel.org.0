Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79F32284182
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Oct 2020 22:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729700AbgJEUhe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Oct 2020 16:37:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39101 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727247AbgJEUhb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Oct 2020 16:37:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601930250;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7nUZF53moaE0jZmZ5l3IQLMteMr+7qZSYgEgvocHM68=;
        b=ZQbPraSQ0cEUyl2O9Idf4hXdoURC42mw44ToB1wUs0FJWN28GVqp+l2N2+hPlhZ78YjVE2
        M3K0GCK4P5jFdwAl/4iLvxMcuFOrDhXvQGYXLXPe9hR094VVH62VVWQKPvjgHzf3M5jAlA
        ANGFGTMT+CXavoozdeNSFZbvtJLaELE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-497-i1Bmh4B7MzGC0GSNKOjgoA-1; Mon, 05 Oct 2020 16:37:23 -0400
X-MC-Unique: i1Bmh4B7MzGC0GSNKOjgoA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7547B107AFA9;
        Mon,  5 Oct 2020 20:37:19 +0000 (UTC)
Received: from ovpn-114-87.rdu2.redhat.com (ovpn-114-87.rdu2.redhat.com [10.10.114.87])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C7A9A10013C0;
        Mon,  5 Oct 2020 20:37:18 +0000 (UTC)
Message-ID: <b56d7eff12d3e85f4fcca11d70b8dbb29da25a3f.camel@redhat.com>
Subject: Re: [RFC PATCH 27/27] epoll: take epitem list out of struct file
From:   Qian Cai <cai@redhat.com>
To:     Al Viro <viro@ZenIV.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>
Date:   Mon, 05 Oct 2020 16:37:18 -0400
In-Reply-To: <20201004023929.2740074-27-viro@ZenIV.linux.org.uk>
References: <20201004023608.GM3421308@ZenIV.linux.org.uk>
         <20201004023929.2740074-1-viro@ZenIV.linux.org.uk>
         <20201004023929.2740074-27-viro@ZenIV.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, 2020-10-04 at 03:39 +0100, Al Viro wrote:
>  /*
>   * Must be called with "mtx" held.
>   */
> @@ -1367,19 +1454,21 @@ static int ep_insert(struct eventpoll *ep, const
> struct epoll_event *event,
>  	epi->event = *event;
>  	epi->next = EP_UNACTIVE_PTR;
>  
> -	atomic_long_inc(&ep->user->epoll_watches);
> -
>  	if (tep)
>  		mutex_lock(&tep->mtx);
>  	/* Add the current item to the list of active epoll hook for this file
> */
> -	spin_lock(&tfile->f_lock);
> -	hlist_add_head_rcu(&epi->fllink, &tfile->f_ep_links);
> -	spin_unlock(&tfile->f_lock);
> -	if (full_check && !tep) {
> -		get_file(tfile);
> -		list_add(&tfile->f_tfile_llink, &tfile_check_list);
> +	if (unlikely(attach_epitem(tfile, epi) < 0)) {
> +		kmem_cache_free(epi_cache, epi);
> +		if (tep)
> +			mutex_lock(&tep->mtx);

Shouldn't this be mutex_unlock() instead?

> +		return -ENOMEM;
>  	}
>  

