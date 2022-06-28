Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AFCB55ECE8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jun 2022 20:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbiF1Soc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jun 2022 14:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233290AbiF1So3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jun 2022 14:44:29 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14DD32408A
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jun 2022 11:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/f+B9klYdvTMvL6NVu9C/Hn6FtWZHnKjWMB9RfQA9lI=; b=fczxIF1Y16voT7887ez1SWYIbT
        DMhkIB5N9FBp6yJJXUUVOVSVf9kWeaGEzPhzeM2b3A7wJ4v4S4IciIVOSRfjiCfZvvCLJwF4UwscL
        YnHBky1XC/DTFKa2ANRp82cHW778Vmus+0NWWoZd/+xBbDHAzY9zzuJeb7NDhmKto/4tR78gnAXSq
        fd5wDz/UvAu0HNYMIqeUgv0IvXn1xoErpnuBUaEcrDQGJZttmVn06Vg4W9Jgi6txpLoN3uo8dDLL6
        jpCAjvuMwQ3wUtcbiP4RVNu+JrrO1PpN8FmcSZXo+l03GS1mWltUl3lZOTy6vQqJswVeoYg3rGTu/
        nk3mPvmA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1o6GCJ-005iIW-FM;
        Tue, 28 Jun 2022 18:44:27 +0000
Date:   Tue, 28 Jun 2022 19:44:27 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Dominique Martinet <asmadeus@codewreck.org>
Subject: Re: [PATCH 09/44] new iov_iter flavour - ITER_UBUF
Message-ID: <YrtMCzdLD87xgufI@ZenIV>
References: <YrKWRCOOWXPHRCKg@ZenIV>
 <20220622041552.737754-1-viro@zeniv.linux.org.uk>
 <20220622041552.737754-9-viro@zeniv.linux.org.uk>
 <20220628123855.75jdjh4b267odyz2@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220628123855.75jdjh4b267odyz2@wittgenstein>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 28, 2022 at 02:38:55PM +0200, Christian Brauner wrote:

> > -/* must be done on non-empty ITER_IOVEC one */
> > +static unsigned long found_ubuf_segment(unsigned long addr,
> > +					size_t len,
> > +					size_t *size, size_t *start,
> > +					unsigned maxpages)
> > +{
> > +	len += (*start = addr % PAGE_SIZE);
> 
> Ugh, I know you just copy-pasted this but can we rewrite this to:
> 
> 	*start = addr % PAGE_SIZE;
> 	len += *start;
> 
> I think that's easier to read.

Dealt with later in the series (around the unification and cleanups
of iov_iter_get_pages/iov_iter_get_pages_alloc).  We could do that
first, but I'd rather not mix that massage in here.
