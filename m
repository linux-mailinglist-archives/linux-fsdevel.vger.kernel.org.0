Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 475C536717D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Apr 2021 19:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242908AbhDURkU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Apr 2021 13:40:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27431 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235434AbhDURkT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Apr 2021 13:40:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619026785;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NozKqtAQsLfIuTJYfL4jEF5T8uHtk7yVgiyg7jRNbZo=;
        b=g6BfZ85MukkGC9o21UNmIT0BsnXigHt97H+bJm4FiyBhq5fIZaKUIGRwq9zEL7V3jR2+s+
        PPVRJmWhCy79qXIHtlXcGbPu1BJygxcfrU4gsu1HNXRYNZXO6+/dSItqoeda7cm7X+yQ7H
        72l/ZFyD9xX6NrL0jx3zcOpN5ul+hsM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-438-R1oJopAjPNS_ZDvua3z3Zg-1; Wed, 21 Apr 2021 13:39:36 -0400
X-MC-Unique: R1oJopAjPNS_ZDvua3z3Zg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8EAE28030C9;
        Wed, 21 Apr 2021 17:39:35 +0000 (UTC)
Received: from horse.redhat.com (ovpn-114-206.rdu2.redhat.com [10.10.114.206])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 26E885D769;
        Wed, 21 Apr 2021 17:39:32 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id B4E70220BCF; Wed, 21 Apr 2021 13:39:31 -0400 (EDT)
Date:   Wed, 21 Apr 2021 13:39:31 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Greg Kurz <groug@kaod.org>
Cc:     linux-fsdevel@vger.kernel.org, dan.j.williams@intel.com,
        jack@suse.cz, willy@infradead.org, linux-nvdimm@lists.01.org,
        miklos@szeredi.hu, linux-kernel@vger.kernel.org,
        virtio-fs@redhat.com
Subject: Re: [Virtio-fs] [PATCH v3 2/3] dax: Add a wakeup mode parameter to
 put_unlocked_entry()
Message-ID: <20210421173931.GF1579961@redhat.com>
References: <20210419213636.1514816-1-vgoyal@redhat.com>
 <20210419213636.1514816-3-vgoyal@redhat.com>
 <20210420093420.2eed3939@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210420093420.2eed3939@bahia.lan>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 20, 2021 at 09:34:20AM +0200, Greg Kurz wrote:
> On Mon, 19 Apr 2021 17:36:35 -0400
> Vivek Goyal <vgoyal@redhat.com> wrote:
> 
> > As of now put_unlocked_entry() always wakes up next waiter. In next
> > patches we want to wake up all waiters at one callsite. Hence, add a
> > parameter to the function.
> > 
> > This patch does not introduce any change of behavior.
> > 
> > Suggested-by: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> > ---
> >  fs/dax.c | 13 +++++++------
> >  1 file changed, 7 insertions(+), 6 deletions(-)
> > 
> > diff --git a/fs/dax.c b/fs/dax.c
> > index 00978d0838b1..f19d76a6a493 100644
> > --- a/fs/dax.c
> > +++ b/fs/dax.c
> > @@ -275,11 +275,12 @@ static void wait_entry_unlocked(struct xa_state *xas, void *entry)
> >  	finish_wait(wq, &ewait.wait);
> >  }
> >  
> > -static void put_unlocked_entry(struct xa_state *xas, void *entry)
> > +static void put_unlocked_entry(struct xa_state *xas, void *entry,
> > +			       enum dax_entry_wake_mode mode)
> >  {
> >  	/* If we were the only waiter woken, wake the next one */
> 
> With this change, the comment is no longer accurate since the
> function can now wake all waiters if passed mode == WAKE_ALL.
> Also, it paraphrases the code which is simple enough, so I'd
> simply drop it.

Ok, I will get rid of this comment. Agreed that code is simple
enough. And frankly speaking I don't even understand "If we were the
only waiter woken" part. How do we know that only this caller
was woken.

Vivek

> 
> This is minor though and it shouldn't prevent this fix to go
> forward.
> 
> Reviewed-by: Greg Kurz <groug@kaod.org>
> 
> >  	if (entry && !dax_is_conflict(entry))
> > -		dax_wake_entry(xas, entry, WAKE_NEXT);
> > +		dax_wake_entry(xas, entry, mode);
> >  }
> >  
> >  /*
> > @@ -633,7 +634,7 @@ struct page *dax_layout_busy_page_range(struct address_space *mapping,
> >  			entry = get_unlocked_entry(&xas, 0);
> >  		if (entry)
> >  			page = dax_busy_page(entry);
> > -		put_unlocked_entry(&xas, entry);
> > +		put_unlocked_entry(&xas, entry, WAKE_NEXT);
> >  		if (page)
> >  			break;
> >  		if (++scanned % XA_CHECK_SCHED)
> > @@ -675,7 +676,7 @@ static int __dax_invalidate_entry(struct address_space *mapping,
> >  	mapping->nrexceptional--;
> >  	ret = 1;
> >  out:
> > -	put_unlocked_entry(&xas, entry);
> > +	put_unlocked_entry(&xas, entry, WAKE_NEXT);
> >  	xas_unlock_irq(&xas);
> >  	return ret;
> >  }
> > @@ -954,7 +955,7 @@ static int dax_writeback_one(struct xa_state *xas, struct dax_device *dax_dev,
> >  	return ret;
> >  
> >   put_unlocked:
> > -	put_unlocked_entry(xas, entry);
> > +	put_unlocked_entry(xas, entry, WAKE_NEXT);
> >  	return ret;
> >  }
> >  
> > @@ -1695,7 +1696,7 @@ dax_insert_pfn_mkwrite(struct vm_fault *vmf, pfn_t pfn, unsigned int order)
> >  	/* Did we race with someone splitting entry or so? */
> >  	if (!entry || dax_is_conflict(entry) ||
> >  	    (order == 0 && !dax_is_pte_entry(entry))) {
> > -		put_unlocked_entry(&xas, entry);
> > +		put_unlocked_entry(&xas, entry, WAKE_NEXT);
> >  		xas_unlock_irq(&xas);
> >  		trace_dax_insert_pfn_mkwrite_no_entry(mapping->host, vmf,
> >  						      VM_FAULT_NOPAGE);
> 

