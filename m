Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 775142A6DDD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Nov 2020 20:30:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731065AbgKDTan (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Nov 2020 14:30:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbgKDTan (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Nov 2020 14:30:43 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35680C0613D3;
        Wed,  4 Nov 2020 11:30:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3CAUqs5j3DsZpEzWXVNgPMK/4eRfDvaX4jGpcM9i5e0=; b=UmUl3uppN1ZChdV0qJD3ilF63L
        DNOBVSBbQCa1pQCsI3eZKUKKMguVW/tuY24VmmftqDsM80YmtIbVs+ni4pKiWlvdwHrEaPTvz8x4Y
        /Q/a2YVNyos53BQe3j1hIgUVIyfx6qJlMy7ey3tJdEz7uvSKSSnXl5OrG0hrTrhxF+ueTmY1NZa91
        a5tBmSX2yylxr7M7sx4E0vbW2KZ8dY0o9R59rAfr/No14qymSEpfTDAfbpsonvqauZ7oUgQOjUJut
        UMoUX6WKXdL1kYGdfOopsWOfj1jSlJiH7aGKcQqOzw0vBqVGF4KVX4Ymy3JWatZ4Yy2DAmOqX+tNL
        6WMDrJYQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kaOUO-000090-EU; Wed, 04 Nov 2020 19:30:36 +0000
Date:   Wed, 4 Nov 2020 19:30:36 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     "xiaofeng.yan" <xiaofeng.yan2012@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        dledford@redhat.com, oulijun@huawei.com, yanxiaofeng7@jd.com
Subject: Re: [PATCH 2/2] infiniband: Modify the reference to xa_store_irq()
 because the parameter of this function  has changed
Message-ID: <20201104193036.GD17076@casper.infradead.org>
References: <20201104023213.760-1-xiaofeng.yan2012@gmail.com>
 <20201104023213.760-2-xiaofeng.yan2012@gmail.com>
 <20201104185843.GV36674@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104185843.GV36674@ziepe.ca>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 04, 2020 at 02:58:43PM -0400, Jason Gunthorpe wrote:
> >  static void cm_finalize_id(struct cm_id_private *cm_id_priv)
> >  {
> >  	xa_store_irq(&cm.local_id_table, cm_local_id(cm_id_priv->id.local_id),
> > -		     cm_id_priv, GFP_KERNEL);
> > +		     cm_id_priv);
> >  }
> 
> This one is almost a bug, the entry is preallocated with NULL though:
> 
> 	ret = xa_alloc_cyclic_irq(&cm.local_id_table, &id, NULL, xa_limit_32b,
> 				  &cm.local_id_next, GFP_KERNEL);
> 
> so it should never allocate here:
> 
> static int cm_req_handler(struct cm_work *work)
> {
> 	spin_lock_irq(&cm_id_priv->lock);
> 	cm_finalize_id(cm_id_priv);

Uhm.  I think you want a different debugging check from this.  The actual
bug here is that you'll get back from calling cm_finalize_id() with
interrupts enabled.  Can you switch to xa_store(), or do we need an
xa_store_irqsave()?

> Still, woops.
> 
> Matt, maybe a might_sleep is deserved in here someplace?
> 
> @@ -1534,6 +1534,8 @@ void *__xa_store(struct xarray *xa, unsigned long index, void *entry, gfp_t gfp)
>         XA_STATE(xas, xa, index);
>         void *curr;
>  
> +       might_sleep_if(gfpflags_allow_blocking(gfp));
> +
>         if (WARN_ON_ONCE(xa_is_advanced(entry)))
>                 return XA_ERROR(-EINVAL);
>         if (xa_track_free(xa) && !entry)
> 
> And similar in the other places that conditionally call __xas_nomem()
> ?
> 
> I also still wish there was a proper 'xa store in already allocated
> but null' idiom - I remember you thought about using gfp flags == 0 at
> one point.

An xa_replace(), perhaps?
