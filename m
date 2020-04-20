Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 884C11B128B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Apr 2020 19:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbgDTRGF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Apr 2020 13:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725784AbgDTRGE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Apr 2020 13:06:04 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E91D2C061A0C;
        Mon, 20 Apr 2020 10:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=rWfkeNl+tPQgsDgysGAPqfogci/QDhLeDrzw1N/HSZo=; b=QUQYVCugWbDdKvcHEcXNg1l/KP
        ZRAYCB/7IyL34lxTlxTlaikOlyXjYOUULc8yAHxj6nf9Zprs8WpyNTKwy+rsJLuLHD9oH8pEUbrDr
        T/EiYZ0uGs5k7DWs32dYc4RbTNDWb53SWwDcIncs0+WamwsRHgyQOLEGzRRPRDrnaxw0trnMQuZmY
        UK4i42q47h3IxnBuIoM0Oh639W7T095DekGWNn+P9xIs3mW2sGfs+wbiJFDTEDmmNJnhrtcnbQX4F
        AgamhDQssECFsKBdu70I7XHOCBH1pIIsk+S+qVzPayhUBTb3bOGqgNrK4DYuO36J0EmoNIdnL7qm8
        v9Xk9PHg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jQZrv-0002kf-ML; Mon, 20 Apr 2020 17:06:03 +0000
Date:   Mon, 20 Apr 2020 10:06:03 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Manfred Spraul <manfred@colorfullife.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] ipc: Convert ipcs_idr to XArray
Message-ID: <20200420170603.GC5820@bombadil.infradead.org>
References: <20200326151418.27545-1-willy@infradead.org>
 <80ab3182-5a17-7434-9007-33eb1da46d85@colorfullife.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <80ab3182-5a17-7434-9007-33eb1da46d85@colorfullife.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 20, 2020 at 05:35:20PM +0200, Manfred Spraul wrote:
> > -		max_idx = max(ids->in_use*3/2, ipc_min_cycle);
> > -		max_idx = min(max_idx, ipc_mni);
> > -
> > -		/* allocate the idx, with a NULL struct kern_ipc_perm */
> > -		idx = idr_alloc_cyclic(&ids->ipcs_idr, NULL, 0, max_idx,
> > -					GFP_NOWAIT);
> > -
> > -		if (idx >= 0) {
> > -			/*
> > -			 * idx got allocated successfully.
> > -			 * Now calculate the sequence number and set the
> > -			 * pointer for real.
> > -			 */
> > -			if (idx <= ids->last_idx) {
> > +		min_idx = ids->next_idx;
> > +		new->seq = ids->seq;
> > +
> > +		/* Modified version of __xa_alloc */
> > +		do {
> > +			xas.xa_index = min_idx;
> > +			xas_find_marked(&xas, max_idx, XA_FREE_MARK);
> > +			if (xas.xa_node == XAS_RESTART && min_idx > 0) {
> >   				ids->seq++;
> >   				if (ids->seq >= ipcid_seq_max())
> >   					ids->seq = 0;
> > +				new->seq = ids->seq;
> > +				xas.xa_index = 0;
> > +				min_idx = 0;
> > +				xas_find_marked(&xas, max_idx, XA_FREE_MARK);
> >   			}
> 
> Is is nessary to have that many details of xarray in ipc/util?
> 
> This function is not performance critical.
> 
> The core requirement is that ipc_obtain_object_check() must scale.
> 
> Would it be possible to use something like
> 
>     xa_alloc(,entry=NULL,)
> 
>     new->seq = ...
> 
>     xa_store(,entry=new,);

Yes, that would absolutely be possible, and some users do exactly that.
I thought that creating a new message queue / semaphore set / shared
memory segment would be performance sensitive.

> > -			ids->last_idx = idx;
> > -
> > -			new->seq = ids->seq;
> > -			/* no need for smp_wmb(), this is done
> > -			 * inside idr_replace, as part of
> > -			 * rcu_assign_pointer
> > -			 */
> 
> Could you leave the memory barrier comments in the code?
> 
> The rcu_assign_pointer() is the first hands-off from semget() or msgget().
> 
> Before the rcu_assign_pointer, e.g. semop() calls would return -EINVAL;
> 
> After the rcu_assign_pointer, semwhatever() must work - and e.g. the
> permission checks are lockless.

How about simply:
			/* xa_store contains a memory barrier */

> > -			idr_replace(&ids->ipcs_idr, new, idx);
> > -		}
> > +			if (xas.xa_node == XAS_RESTART)
> > +				xas_set_err(&xas, -ENOSPC);
> > +			else
> > +				new->id = (new->seq << ipcmni_seq_shift()) +
> > +					xas.xa_index;
> 
> Setting new->id should remain at the end, outside any locking:
> 
> The variable has no special protection, access is only allowed after proper
> locking, thus no need to have the initialization in the middle.
> 
> What is crucial is that the final value of new->seq is visible to all cpus
> before a storing the pointer.

The IPC locking is weird.  Most users spin_lock the xarray/idr/radix
tree for modifications, and on the read-side use RCU to protect the
lookup and a refcount on the object looked up in it (after which,
RCU is unlocked).  IPC seems to hold the RCU lock much longer, and it
has a per-object spinlock rather than refcount.  And it has an rwsem.
It feels like it could be much simpler, but I haven't had time to dig
into it and figure out why it's so different from all the other users.
Maybe it's just older code.

> > +			xas_store(&xas, new);
> > +			xas_clear_mark(&xas, XA_FREE_MARK);
> > +		} while (__xas_nomem(&xas, GFP_KERNEL));
> > +
> 
> Just for my curiosity:
> 
> If the xas is in an invalid state, then xas_store() will not store anything.
> Thus the loop will not store "new" multiple times, it will be stored only
> once.

Correct, although we're going to delete this loop entirely.

> @@ -472,7 +487,7 @@ void ipc_rmid(struct ipc_ids *ids, struct kern_ipc_perm
> *ipcp)
> >   			idx--;
> >   			if (idx == -1)
> >   				break;
> > -		} while (!idr_find(&ids->ipcs_idr, idx));
> > +		} while (!xa_load(&ids->ipcs, idx));
> >   		ids->max_idx = idx;
> >   	}
> >   }
> 
> Is there an xa_find_last() function?
> 
> It is outside of any hot path, I have a patch that does a binary search with
> idr_get_next().
> 
> If there is no xa_find_last(), then I would rebase that patch.

There is not currently an xa_find_last().  It shouldn't be too hard
to add; start at the top of the tree and walk backwards in each node
until finding a non-NULL entry.  Of course, it'll need documentation
and test cases.
