Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F98573FAC6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 13:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbjF0LIi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 07:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjF0LIh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 07:08:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D6B1BE8;
        Tue, 27 Jun 2023 04:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=aiHsdcFdbTne0FqDQT/At35HF+CebE5/fvRBdL3jClE=; b=e1JCm0AVlzhQRuuH7L20hP1en/
        mmmXaECSpteaMbbsjANEEOmcPHi7jaWDKqXSoBko4ELgk5SjkY0k/Dm/tpvZ7xFqJlv0DVN3HOxSm
        EdK7jGPSMQV0ikV5BZZUQ7aU7glxBrMqX/itX1usITYtxc78qpuGlqRw8jVrJFb8/pBJfinfIyA8d
        fQgmib4k2bgEMIDOmp7Cxb4noKr76/9CzA/oDJekzBQWF62f7y2uePqVi5CBVBsGufdRLW5XieA5p
        +UDJnjCpzHbRWILEhJPwP6Xju8HkfNqymNy4sklauET7ON/xQ+1iVQyj/862p8g5jaeh1KEj/33/P
        5DaKqISQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qE6Yg-002eID-H1; Tue, 27 Jun 2023 11:08:30 +0000
Date:   Tue, 27 Jun 2023 12:08:30 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.com>,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 07/12] writeback: Factor writeback_iter_init() out of
 write_cache_pages()
Message-ID: <ZJrDLgrSYV56zaZf@casper.infradead.org>
References: <20230626173521.459345-1-willy@infradead.org>
 <20230626173521.459345-8-willy@infradead.org>
 <ZJplzwnPBHo4ZK60@infradead.org>
 <ZJpmPOEH7rYkETsQ@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJpmPOEH7rYkETsQ@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 26, 2023 at 09:31:56PM -0700, Christoph Hellwig wrote:
> On Mon, Jun 26, 2023 at 09:30:07PM -0700, Christoph Hellwig wrote:
> > On Mon, Jun 26, 2023 at 06:35:16PM +0100, Matthew Wilcox (Oracle) wrote:
> > > +	for (folio = writeback_iter_init(mapping, wbc);
> > > +	     folio;
> > > +	     folio = writeback_get_next(mapping, wbc)) {
> > 
> > Ok that's another way to structure it.  Guess I should look over the
> > whole series first..

Perhaps ... it's a little hard to decide which of your comments
are worth replying to, and which are obviated by later realisations.

> That beeing said.  Given that writeback_iter_init calls 
> writeback_get_next anyway,
> 
> 	writeback_iter_init(mapping, wbc);
> 	while ((folio = writeback_get_next(mapping, wbc)))
> 
> still feels a little easier to follow to be.  No hard feelings either
> way, just an observation.

I had it structured that way originally, but we need to pass in 'error'
to the get_next, and it's better if we also pass in 'folio', which means
that the user then needs to initialise error to 0 and folio to NULL
before using the macro, and that all felt a bit "You're holding it wrong".
