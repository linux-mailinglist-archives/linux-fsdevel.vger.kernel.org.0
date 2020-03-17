Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A17818892C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Mar 2020 16:28:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbgCQP2u (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Mar 2020 11:28:50 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52336 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbgCQP2u (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Mar 2020 11:28:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xJA9FFPfJkuq8fVzTKccTbceOpg3uJs1/00mKyQZnEc=; b=nNS0iOdmgHP2ZIGEAO0g8u8fHS
        TDvQDiQcFH1hBkh3Q5nsFQz5yj7wNCL9cCORyBIyR7V7GMpP/q/ZoUKULALuLr2IdVltjzsEIP4xU
        ZxpJAxHApbow3TTrO+kd7z8z5XjPJvXMEpQnHDINerFDHBgzwxx833CnsYL6lxI3noSayyLLf8qoR
        e4jvJjgerruwRQffudZlNvBPEa8TKXAtVTahVkqvpnOgladbVay0AMUHK92QgVxKvK4RBmQ5/1d1R
        +yWUabB4oYjjbTWqpMJSPZIicNbXxCNRb7EXNJSzuMNn4VGo1WST+AhzHDaLRUUWT0AbzpC+lzkCj
        r6J22hMQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jEE9C-0008Sr-5E; Tue, 17 Mar 2020 15:28:50 +0000
Date:   Tue, 17 Mar 2020 08:28:50 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 2/8] xarray: Provide xas_erase() helper
Message-ID: <20200317152850.GC22433@bombadil.infradead.org>
References: <20200204142514.15826-1-jack@suse.cz>
 <20200204142514.15826-3-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200204142514.15826-3-jack@suse.cz>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 04, 2020 at 03:25:08PM +0100, Jan Kara wrote:
> +void *xas_erase(struct xa_state *xas)
> +{
> +	void *entry;
> +
> +	entry = xas_store(xas, NULL);
> +	xas_init_marks(xas);
> +
> +	return entry;
> +}
> +EXPORT_SYMBOL(xas_erase);

I didn't have a test case to show this, but ...

+static noinline void check_multi_store_4(struct xarray *xa)
+{
+       XA_BUG_ON(xa, xa_marked(xa, XA_MARK_0));
+       XA_BUG_ON(xa, !xa_empty(xa));
+
+       xa_store_index(xa, 0, GFP_KERNEL);
+       xa_store_index(xa, 2, GFP_KERNEL);
+       xa_set_mark(xa, 0, XA_MARK_0);
+       xa_set_mark(xa, 2, XA_MARK_0);
+
+       xa_store_order(xa, 0, 2, NULL, GFP_KERNEL);
+       XA_BUG_ON(xa, xa_marked(xa, XA_MARK_0));
+       xa_destroy(xa);
+}

shows a problem.  Because we delete all the entries in the tree,
xas_delete_node() sets the xas->xa_node to XAS_BOUNDS.  This fixes it:

@@ -492,7 +492,6 @@ static void xas_delete_node(struct xa_state *xas)
 
                if (!parent) {
                        xas->xa->xa_head = NULL;
-                       xas->xa_node = XAS_BOUNDS;
                        return;
                }
 
(it leaves xas->xa_node set to NULL, which makes the above work correctly
because NULL is used to mean the one element at index 0 of the array)

Now I'm wondering if it's going to break anything, though.  The test suite
runs successfully, but it can't be exhaustive.
