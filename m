Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 692BC58545C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Jul 2022 19:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238350AbiG2RVd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Jul 2022 13:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238345AbiG2RVa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Jul 2022 13:21:30 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12DF97FE54
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Jul 2022 10:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9MjnRk/7Rye5Pnt5j/mWtjmtFCsBsmAjvxv0luba/TQ=; b=laQi6phQMRe8mISuNMhEv/I8zC
        IaSFEMWyNjn+RyedtI1sH7XnAbhSRGu8orPXOm3VPzEfDPzrSlckDv1wjWfIKlhyobT+CjTCx6Gc8
        KYverMbk/ciKLMuoyirdHRIHOGjB911RQIQn89aR/94jMW0UIdFTULNdzuxM6b4YG9un0R+AgwaM7
        yyKWi77Xcppbf12auxg+bpLKha+ag+K643MrGVr6fSKib0K4WxISYnr4UacnCUEZcOro7wfbZuWAQ
        nYZDpQlDkWsKJjuG8QvOXikU+66Zw0sNsUjlOHPGvHwN/pk1UhxYCDaCJfbShS7L6Jsf0KHoy7ipp
        NrBvJmDg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oHTfv-00H8XR-AL;
        Fri, 29 Jul 2022 17:21:23 +0000
Date:   Fri, 29 Jul 2022 18:21:23 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH 9/44] new iov_iter flavour - ITER_UBUF
Message-ID: <YuQXE+MBAHVhdWW3@ZenIV>
References: <YrKWRCOOWXPHRCKg@ZenIV>
 <20220622041552.737754-1-viro@zeniv.linux.org.uk>
 <20220622041552.737754-9-viro@zeniv.linux.org.uk>
 <YuJc/gfGDj4loOqt@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YuJc/gfGDj4loOqt@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,URIBL_ABUSE_SURBL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 28, 2022 at 11:55:10AM +0200, Alexander Gordeev wrote:
> On Wed, Jun 22, 2022 at 05:15:17AM +0100, Al Viro wrote:
> > Equivalent of single-segment iovec.  Initialized by iov_iter_ubuf(),
> > checked for by iter_is_ubuf(), otherwise behaves like ITER_IOVEC
> > ones.
> > 
> > We are going to expose the things like ->write_iter() et.al. to those
> > in subsequent commits.
> > 
> > New predicate (user_backed_iter()) that is true for ITER_IOVEC and
> > ITER_UBUF; places like direct-IO handling should use that for
> > checking that pages we modify after getting them from iov_iter_get_pages()
> > would need to be dirtied.
> > 
> > DO NOT assume that replacing iter_is_iovec() with user_backed_iter()
> > will solve all problems - there's code that uses iter_is_iovec() to
> > decide how to poke around in iov_iter guts and for that the predicate
> > replacement obviously won't suffice.
> > 
> > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> > Link: https://lore.kernel.org/r/20220622041552.737754-9-viro@zeniv.linux.org.uk
> 
> Hi Al,
> 
> This changes causes sendfile09 LTP testcase fail in linux-next
> (up to next-20220727) on s390. In fact, not this change exactly,
> but rather 92d4d18eecb9 ("new iov_iter flavour - ITER_UBUF") -
> which differs from what is posted here.
> 
> AFAICT page_cache_pipe_buf_confirm() encounters !PageUptodate()
> and !page->mapping page and returns -ENODATA.
> 
> I am going to narrow the testcase and get more details, but please
> let me know if I am missing something.

Grrr....

-               } else if (iter_is_iovec(to)) {
+               } else if (!user_backed_iter(to)) {

in mm/shmem.c.  Spot the typo...

Could you check if replacing that line with
		} else if (user_backed_iter(to)) {

fixes the breakage?
