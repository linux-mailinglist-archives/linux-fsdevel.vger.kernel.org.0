Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF6674E276
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jul 2023 02:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbjGKAHo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jul 2023 20:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbjGKAHn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jul 2023 20:07:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 858521A7;
        Mon, 10 Jul 2023 17:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qIoe5JGgFeAY5726K1xkwOnbXeFuwkk4STNzO4mGXdQ=; b=CaCNv049Bq0gse0X/MKP0apWMJ
        SUH9DXsdlvyyV6Q5Y58fuLgsjCigfuLVe3CO2eCybs3vJsWN6qSaZ3yzUec8WbUXYF1hnb8eZtvl+
        E4twqENQRo/FTGtqCSvE+gc9J+Q3ZFMrgu+GGM7tgkwtdPY5tKyfBqj3cs0ODMN//3USzQoPjWcXQ
        bKjE4fws7ZEqzlxqHbQfYHyhpoZPRg850f0GXiVRitxPFWiFIrVRsg7MfG5K9CoT1Sl5pAPOBhXB4
        xUVNQRBwWfQhDqWEPT5T56pAXidoYhclWeIfX2RxhPddIb2fQtLP2nXgGLiP50GoUWpqg3OvB2DjK
        qgaFdtow==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qJ0un-00F49f-TW; Tue, 11 Jul 2023 00:07:37 +0000
Date:   Tue, 11 Jul 2023 01:07:37 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Wang Yugui <wangyugui@e16-tech.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v4 7/9] filemap: Allow __filemap_get_folio to allocate
 large folios
Message-ID: <ZKydSZM70Fd2LW/q@casper.infradead.org>
References: <20230710130253.3484695-1-willy@infradead.org>
 <20230710130253.3484695-8-willy@infradead.org>
 <ZKybP22DRs1w4G3a@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZKybP22DRs1w4G3a@bombadil.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 10, 2023 at 04:58:55PM -0700, Luis Chamberlain wrote:
> > @@ -1914,26 +1916,44 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
> >  			gfp &= ~GFP_KERNEL;
> >  			gfp |= GFP_NOWAIT | __GFP_NOWARN;
> >  		}
> > -
> > -		folio = filemap_alloc_folio(gfp, 0);
> > -		if (!folio)
> > -			return ERR_PTR(-ENOMEM);
> > -
> >  		if (WARN_ON_ONCE(!(fgp_flags & (FGP_LOCK | FGP_FOR_MMAP))))
> >  			fgp_flags |= FGP_LOCK;
> >  
> > -		/* Init accessed so avoid atomic mark_page_accessed later */
> > -		if (fgp_flags & FGP_ACCESSED)
> > -			__folio_set_referenced(folio);
> > +		if (!mapping_large_folio_support(mapping))
> > +			order = 0;
> > +		if (order > MAX_PAGECACHE_ORDER)
> > +			order = MAX_PAGECACHE_ORDER;
> 
> Curious how this ended up being the heuristic used to shoot for the
> MAX_PAGECACHE_ORDER sky first, and then go down 1/2 each time. I don't
> see it explained on the commit log but I'm sure there's has to be
> some reasonable rationale. From the cover letter, I could guess that
> it means the gains of always using the largest folio possible means
> an implied latency savings through other means, so the small latencies
> spent looking seem to no where compare to the saving in using. But
> I rather understand a bit more for the rationale.

You've completely misunderstood this patch.  The caller hints at the
folio size it wants, and this code you're highlighting limits it to be
less than MAX_PAGECACHE_ORDER.

