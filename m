Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA804B7677
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Feb 2022 21:49:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238436AbiBOUeE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Feb 2022 15:34:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236437AbiBOUeE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Feb 2022 15:34:04 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 183B489CD4
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Feb 2022 12:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XmAUCxdK9LP0XThgfZLTCMmPMdPVyUIqZsFQoqqvxRE=; b=vPsQ6kNlZdAwkzJfvvGZ5nbXbO
        2AuHORN7nSKwlHsctx0qj5b3w6owNRBDf2Zqg4P0J/eZQkKSx2aVFW2NQj0vzACacGA2wdB2cfxBm
        VJlQb+Hy2yuFSgcDTTmNtHg0ln0tTfWSpIzdH/bR1u9xUYjPH75WZbd/jPE/+Y8g8vNp1NMHhl7wB
        Eft00HLESsOKVsBiy6HPkdAx8TdZX1TdW2yImEN/YVDrW8eTdTClvLnhEL9ZK7C3OZs7bCdTEED9o
        zWA91uC30L+GVW2s7Q5FrneXMZo3wMfC9we+fNCRRbjrP1eLGjH7D64oH89OCqyEh+UkuGICIbS21
        HU/f+a3w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nK4WF-00E9mq-Sk; Tue, 15 Feb 2022 20:33:51 +0000
Date:   Tue, 15 Feb 2022 20:33:51 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 08/10] mm: Turn deactivate_file_page() into
 deactivate_file_folio()
Message-ID: <YgwOLye/QnBXCuL0@casper.infradead.org>
References: <20220214200017.3150590-1-willy@infradead.org>
 <20220214200017.3150590-9-willy@infradead.org>
 <56e09280-c1dd-6bdb-81f0-524af99c5f4f@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56e09280-c1dd-6bdb-81f0-524af99c5f4f@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 15, 2022 at 04:26:22PM +0800, Miaohe Lin wrote:
> > +	folio_get(folio);
> 
> Should we comment the assumption that caller already hold the refcnt?

Added to the kernel-doc:
+ * Context: Caller holds a reference on the page.

> Anyway, this patch looks good to me. Thanks.
> 
> Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
> 
> > +	local_lock(&lru_pvecs.lock);
> > +	pvec = this_cpu_ptr(&lru_pvecs.lru_deactivate_file);
> >  
> > -		if (pagevec_add_and_need_flush(pvec, page))
> > -			pagevec_lru_move_fn(pvec, lru_deactivate_file_fn);
> > -		local_unlock(&lru_pvecs.lock);
> > -	}
> > +	if (pagevec_add_and_need_flush(pvec, &folio->page))
> > +		pagevec_lru_move_fn(pvec, lru_deactivate_file_fn);
> > +	local_unlock(&lru_pvecs.lock);
> >  }
> >  
> >  /*
> > diff --git a/mm/truncate.c b/mm/truncate.c
> > index 567557c36d45..14486e75ec28 100644
> > --- a/mm/truncate.c
> > +++ b/mm/truncate.c
> > @@ -525,7 +525,7 @@ static unsigned long __invalidate_mapping_pages(struct address_space *mapping,
> >  			 * of interest and try to speed up its reclaim.
> >  			 */
> >  			if (!ret) {
> > -				deactivate_file_page(&folio->page);
> > +				deactivate_file_folio(folio);
> >  				/* It is likely on the pagevec of a remote CPU */
> >  				if (nr_pagevec)
> >  					(*nr_pagevec)++;
> > 
> 
> 
