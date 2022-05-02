Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2799851764F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 May 2022 20:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244453AbiEBSKN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 May 2022 14:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238752AbiEBSKM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 May 2022 14:10:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 662B324F
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 May 2022 11:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OulwLswCitXJ6GxfTcA2z6xZVHJbNV/+iN54hSQ/zdk=; b=fw39PtZiDUYcvUefU9Aqe+roy3
        +JH65mMk3ODra67EpxXDJvuUOT7ly1H37gW/LB7XaWgFWvcgRiAgZABBOy9sxaZXBB2Xu3fS122T8
        GTUpcPcFYJY/ASH7Y1w0VfHed4rn+1PA6JIzH2HfLM008xM6LM8tSPu5yVVeRZtiqj9YFC+x2B18k
        70oyxs0Aymzr4J9w5uMUV9fYNBd8b+6cFpez70R/3oT6MkFkhVWPvrv43VYfeAmofq6G0frOnptFg
        0YHPJQgAZ4A56HtwWP/K7+qnk11WOwmkZuf7KPgKPwykCHSTDuqOZWlC/6jDMeckv/xEEGApBjfk/
        LwJlaSDA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nlaRU-00F0w9-FA; Mon, 02 May 2022 18:06:40 +0000
Date:   Mon, 2 May 2022 19:06:40 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 01/26] fs: Add aops->release_folio
Message-ID: <YnAdsPWKLCZd2YLw@casper.infradead.org>
References: <20220502055614.3473032-1-willy@infradead.org>
 <20220502055614.3473032-2-willy@infradead.org>
 <081dd8bc2b0462b86bc03638c5e55eeaaf4de13a.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <081dd8bc2b0462b86bc03638c5e55eeaaf4de13a.camel@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 02, 2022 at 11:19:19AM -0400, Jeff Layton wrote:
> On Mon, 2022-05-02 at 06:55 +0100, Matthew Wilcox (Oracle) wrote:
> > diff --git a/mm/filemap.c b/mm/filemap.c
> > index 81a0ed08a82c..40df5704ec39 100644
> > --- a/mm/filemap.c
> > +++ b/mm/filemap.c
> > @@ -3956,6 +3956,8 @@ bool filemap_release_folio(struct folio *folio, gfp_t gfp)
> >  	if (folio_test_writeback(folio))
> >  		return false;
> >  
> > +	if (mapping && mapping->a_ops->release_folio)
> > +		return mapping->a_ops->release_folio(folio, gfp);
> 
> Might it be worthwhile to add something like this to the above condition
> for now?
> 
>       BUG_ON(mapping->a_ops->releasepage);
> 
> It might help catch bad conversions...

Patch 26 gets rid of ->releasepage ... I don't intend for it to stick
around for a kernel cycle and let people introduce new users ;-)

> >  	if (mapping && mapping->a_ops->releasepage)
> >  		return mapping->a_ops->releasepage(&folio->page, gfp);
> >  	return try_to_free_buffers(&folio->page);
> 
> 
> Looks pretty like a straighforward change overall.
> 
> Reviewed-by: Jeff Layton <jlayton@kernel.org>

Thanks!
