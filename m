Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7804151FCA8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 May 2022 14:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234354AbiEIM1y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 May 2022 08:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234277AbiEIM1w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 May 2022 08:27:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A4CC215528
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 May 2022 05:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+OaBhyLaIBYR0fH2MR4Ek1zIdV5dv+xykVldO/N8cK0=; b=kFlaaV00DARvTSwA1w924rrtAs
        HnshmBTeQDgsWHssd99b/ViksjOC3WFBlJMTYoUw1+nR2llYo/UhFrYu+9Uh2X0Fr5H9e6P4jXfCI
        WTzUV6a3KzZEQGV924T3xVr4wIXkQ2Oyq6yJ44Y1pqVVWuppEZ03KdLXRISrhQg+wr84HFdksUeAh
        lBha6TLo/lZrW9CHq60YkSpVmU+aXmswnkAc16BFNsG9UCc8U+XpOMv0W29x83hD6NmwbuI8kll6R
        fL/mZ7jbreTZLeW7YnJQhjN06WcS2VIvK/+dVzwsD8odBu4EkWFFlSc3urmaPaulu860+otcIIby7
        3fbSlwlg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1no2QZ-003QuQ-BD; Mon, 09 May 2022 12:23:51 +0000
Date:   Mon, 9 May 2022 13:23:51 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 01/26] fs: Add aops->release_folio
Message-ID: <YnkH1wf/ymzi+mtO@casper.infradead.org>
References: <YngbFluT9ftR5dqf@casper.infradead.org>
 <20220508203247.668791-1-willy@infradead.org>
 <20220508203247.668791-2-willy@infradead.org>
 <784287e358bc293a5381f8bdb21752e377a3bda6.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <784287e358bc293a5381f8bdb21752e377a3bda6.camel@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 09, 2022 at 06:33:55AM -0400, Jeff Layton wrote:
> On Sun, 2022-05-08 at 21:32 +0100, Matthew Wilcox (Oracle) wrote:
> > +++ b/Documentation/filesystems/locking.rst
> > @@ -249,7 +249,7 @@ prototypes::
> >  				struct page *page, void *fsdata);
> >  	sector_t (*bmap)(struct address_space *, sector_t);
> >  	void (*invalidate_folio) (struct folio *, size_t start, size_t len);
> > -	int (*releasepage) (struct page *, int);
> > +	int (*release_folio)(struct folio *, gfp_t);
> 
> Shouldn't that be a bool return?

Oh, good catch.  This whole documentation section needs a re-do in
kernel-doc, so we don't have to duplicate this.  Thanks; I'll fix that
up.
