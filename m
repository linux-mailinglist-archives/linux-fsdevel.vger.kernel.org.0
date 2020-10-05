Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E50B2841AA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Oct 2020 22:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725862AbgJEUtr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Oct 2020 16:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbgJEUtq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Oct 2020 16:49:46 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92518C0613CE;
        Mon,  5 Oct 2020 13:49:46 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kPXQT-00CaNG-Lb; Mon, 05 Oct 2020 20:49:41 +0000
Date:   Mon, 5 Oct 2020 21:49:41 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Qian Cai <cai@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>
Subject: Re: [RFC PATCH 27/27] epoll: take epitem list out of struct file
Message-ID: <20201005204941.GT3421308@ZenIV.linux.org.uk>
References: <20201004023608.GM3421308@ZenIV.linux.org.uk>
 <20201004023929.2740074-1-viro@ZenIV.linux.org.uk>
 <20201004023929.2740074-27-viro@ZenIV.linux.org.uk>
 <b56d7eff12d3e85f4fcca11d70b8dbb29da25a3f.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b56d7eff12d3e85f4fcca11d70b8dbb29da25a3f.camel@redhat.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 05, 2020 at 04:37:18PM -0400, Qian Cai wrote:
> On Sun, 2020-10-04 at 03:39 +0100, Al Viro wrote:
> >  /*
> >   * Must be called with "mtx" held.
> >   */
> > @@ -1367,19 +1454,21 @@ static int ep_insert(struct eventpoll *ep, const
> > struct epoll_event *event,
> >  	epi->event = *event;
> >  	epi->next = EP_UNACTIVE_PTR;
> >  
> > -	atomic_long_inc(&ep->user->epoll_watches);
> > -
> >  	if (tep)
> >  		mutex_lock(&tep->mtx);
> >  	/* Add the current item to the list of active epoll hook for this file
> > */
> > -	spin_lock(&tfile->f_lock);
> > -	hlist_add_head_rcu(&epi->fllink, &tfile->f_ep_links);
> > -	spin_unlock(&tfile->f_lock);
> > -	if (full_check && !tep) {
> > -		get_file(tfile);
> > -		list_add(&tfile->f_tfile_llink, &tfile_check_list);
> > +	if (unlikely(attach_epitem(tfile, epi) < 0)) {
> > +		kmem_cache_free(epi_cache, epi);
> > +		if (tep)
> > +			mutex_lock(&tep->mtx);
> 
> Shouldn't this be mutex_unlock() instead?

It should.  Fixed and force-pushed...

> > +		return -ENOMEM;
> >  	}
> >  
> 
