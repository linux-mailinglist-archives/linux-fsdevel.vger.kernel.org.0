Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F27F51B5AA0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Apr 2020 13:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbgDWLkK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Apr 2020 07:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727903AbgDWLkK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Apr 2020 07:40:10 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 039BDC035494;
        Thu, 23 Apr 2020 04:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tB+BVWMxib2gd9XqAz2QdvAOKuEQpc9FChbzR+SgxV4=; b=tbKgu6elYwtDE343Cpmt0XiJGp
        YBfbojKbLj9MhwhMUUK2urKoXUnNhgrOMDarNDfO6YA2yB65SSwjsKHPqDdVr9vm4XlcmSGQ8tGIp
        6+vB+UqrpbQKsJSN1FU8awdV+mwaLz7mwcmVFAtyWoAIA0W6LA6Nc7l1bn8DxA7OPHB6w4sU2+OEs
        E2PnoNS1hbJx+RI2F7iAXFs9kxmluk94xuIjCWED41/z2Dwkjct59Gi90qX1ivsHBs1leveYOkJrD
        SzcZ7kRgpYF+2CQHNLPcn/4kjW7hItE3avfMSCU9tF7UCTQVc0gtr4RT6lAxr1KL6lcvh81ZStkYy
        ahRXi2vg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jRaDA-0002U1-Dr; Thu, 23 Apr 2020 11:40:08 +0000
Date:   Thu, 23 Apr 2020 04:40:08 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
        Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] fs: Use slab constructor to initialize conn objects in
 fsnotify
Message-ID: <20200423114008.GB13910@bombadil.infradead.org>
References: <20200423044050.162093-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200423044050.162093-1-joel@joelfernandes.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 23, 2020 at 12:40:50AM -0400, Joel Fernandes (Google) wrote:
> While reading the famous slab paper [1], I noticed that the conn->lock
> spinlock and conn->list hlist in fsnotify code is being initialized
> during every object allocation. This seems a good fit for the
> constructor within the slab to take advantage of the slab design. Move
> the initializtion to that.

The slab paper was written a number of years ago when CPU caches were
not as they are today.  With this patch, every time you allocate a
new page, we dirty the entire page, and then the dirty cachelines will
gradually fall out of cache as the other objects on the page are not used
immediately.  Then, when we actually use one of the objects on the page,
we bring those cachelines back in and dirty them again by initialising
'type' and 'obj'.  The two stores to initialise lock and list are almost
free when done in fsnotify_attach_connector_to_object(), but are costly
when done in a slab constructor.

There are very few places where a slab constructor is justified with a
modern CPU.  We've considered removing the functionality before.

> @@ -479,8 +479,6 @@ static int fsnotify_attach_connector_to_object(fsnotify_connp_t *connp,
>  	conn = kmem_cache_alloc(fsnotify_mark_connector_cachep, GFP_KERNEL);
>  	if (!conn)
>  		return -ENOMEM;
> -	spin_lock_init(&conn->lock);
> -	INIT_HLIST_HEAD(&conn->list);
>  	conn->type = type;
>  	conn->obj = connp;
>  	/* Cache fsid of filesystem containing the object */
> -- 
> 2.26.1.301.g55bc3eb7cb9-goog
