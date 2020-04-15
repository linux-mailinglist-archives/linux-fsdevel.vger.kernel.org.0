Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F38801AAD24
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Apr 2020 18:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1415219AbgDOQMl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Apr 2020 12:12:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:33620 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2410240AbgDOQMf (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Apr 2020 12:12:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D4B58ADF8;
        Wed, 15 Apr 2020 16:12:32 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 44ABC1E1250; Wed, 15 Apr 2020 18:12:30 +0200 (CEST)
Date:   Wed, 15 Apr 2020 18:12:30 +0200
From:   Jan Kara <jack@suse.cz>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 2/8] xarray: Provide xas_erase() helper
Message-ID: <20200415161230.GL6126@quack2.suse.cz>
References: <20200204142514.15826-1-jack@suse.cz>
 <20200204142514.15826-3-jack@suse.cz>
 <20200317152850.GC22433@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200317152850.GC22433@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 17-03-20 08:28:50, Matthew Wilcox wrote:
> On Tue, Feb 04, 2020 at 03:25:08PM +0100, Jan Kara wrote:
> > +void *xas_erase(struct xa_state *xas)
> > +{
> > +	void *entry;
> > +
> > +	entry = xas_store(xas, NULL);
> > +	xas_init_marks(xas);
> > +
> > +	return entry;
> > +}
> > +EXPORT_SYMBOL(xas_erase);
> 
> I didn't have a test case to show this, but ...
> 
> +static noinline void check_multi_store_4(struct xarray *xa)
> +{
> +       XA_BUG_ON(xa, xa_marked(xa, XA_MARK_0));
> +       XA_BUG_ON(xa, !xa_empty(xa));
> +
> +       xa_store_index(xa, 0, GFP_KERNEL);
> +       xa_store_index(xa, 2, GFP_KERNEL);
> +       xa_set_mark(xa, 0, XA_MARK_0);
> +       xa_set_mark(xa, 2, XA_MARK_0);
> +
> +       xa_store_order(xa, 0, 2, NULL, GFP_KERNEL);
> +       XA_BUG_ON(xa, xa_marked(xa, XA_MARK_0));
> +       xa_destroy(xa);
> +}
> 
> shows a problem.  Because we delete all the entries in the tree,
> xas_delete_node() sets the xas->xa_node to XAS_BOUNDS.  This fixes it:
> 
> @@ -492,7 +492,6 @@ static void xas_delete_node(struct xa_state *xas)
>  
>                 if (!parent) {
>                         xas->xa->xa_head = NULL;
> -                       xas->xa_node = XAS_BOUNDS;
>                         return;
>                 }
>  
> (it leaves xas->xa_node set to NULL, which makes the above work correctly
> because NULL is used to mean the one element at index 0 of the array)
> 
> Now I'm wondering if it's going to break anything, though.  The test suite
> runs successfully, but it can't be exhaustive.

I finally got back to this. Sorry for the delay. I was pondering about the
change you suggested for xas_delete_node() and I don't quite like it - for
the example you've described, it would be kind of the right thing. But if
we'd have an example like:

+       xa_store_index(xa, 4, GFP_KERNEL);
+       xa_set_mark(xa, 4, XA_MARK_0);
+
+       xa_store(xa, 4, NULL, GFP_KERNEL);

then having XAS_BOUNDS set after the store is IMO what should happen
because index 4 stored in xa_index cannot be stored in the array as it
currently is. So leaving xa_node set to NULL looks confusing.

So I think what I'll do is move xas_init_marks() in xas_erase() before 
xas_store(). I'll also need to add xas_load() there because that isn't
guaranteed to have happened on the xas yet and xas_init_marks() expects
xas_load() has already ran...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
