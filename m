Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 893CD51EFE2
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 May 2022 21:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbiEHTRr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 May 2022 15:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348280AbiEHTKw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 May 2022 15:10:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F792DCD;
        Sun,  8 May 2022 12:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HPtZn1pXVcAa2BUPhG85sgXmXcmLsDiRYjOT7IzzrhM=; b=juEwUtY+Pswar3mi9JCqMG0GB0
        eDZZ9UH2uN8HFDyFlUDrZTXE2YJnQJ3j8xjADLm/8ozl2oFFxoJ/3UBpi+cv0JS8p9k50jwwdYWMG
        bmk1L+0tuu0X6IG8b5oiZmaRi4DThDX0pwC35eYJ46I5qO+kJTs50VM+tsRtqqkny2m36qFziDIiS
        Y9x+nmjbz0OjJnsZSJXJScraAShlBtty6se+Fj21xQly9hqNdBCBkMW0jiHleQgCXnAUO4HuuEy6X
        71WDfR3YtiizfRmphYM5ZobpS7DEUGLZWl5ml+RPoyjFo63IwmpUryJxGIvk95gnj1FLLYHUf/HtE
        rb2k7tLg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nnmEn-002k8z-4S; Sun, 08 May 2022 19:06:37 +0000
Date:   Sun, 8 May 2022 20:06:37 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, cluster-devel@redhat.com,
        linux-mtd@lists.infradead.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 3/3] fs: Change the type of filler_t
Message-ID: <YngUvbIyPA2gsslF@casper.infradead.org>
References: <20220502054159.3471078-1-willy@infradead.org>
 <20220502054159.3471078-4-willy@infradead.org>
 <YnE60WTzSzxt9OxY@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnE60WTzSzxt9OxY@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 03, 2022 at 07:23:13AM -0700, Christoph Hellwig wrote:
> > @@ -3504,9 +3504,9 @@ static struct folio *do_read_cache_folio(struct address_space *mapping,
> >  
> >  filler:
> >  		if (filler)
> > -			err = filler(data, &folio->page);
> > +			err = filler(file, folio);
> >  		else
> > -			err = mapping->a_ops->read_folio(data, folio);
> > +			err = mapping->a_ops->read_folio(file, folio);
> 
> Wouldn't it just make sense to just pass mapping->a_ops->read_folio as
> the filler here from the callers that currently pass NULL?

Thanks for the review.  We're heading in the same direction; my
plan was to (in some subsequent merge window) convert all callers of
read_cache_page() to use read_mapping_folio() (by setting ->read_folio)
and then get rid of filler_t altogether.

Maybe there are some filesystems that can't do that, eg they need a
different ->read_folio() when called from read_cache_folio() to the
one they need when called for filemap_read(), but I bet they can all be
worked around.
