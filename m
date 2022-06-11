Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7D76547630
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Jun 2022 17:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238681AbiFKPjq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 11 Jun 2022 11:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233692AbiFKPjp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 11 Jun 2022 11:39:45 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C3B626571;
        Sat, 11 Jun 2022 08:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Ti+2AANXX2O8MAB4FF8D2MuTxZeEKRqkYWjOlelpBa8=; b=eHg0+OU8W/nrYlQJlJYgZ9OA5O
        JqazKQBmjlFvunvi9gzljs37rl2Oa5VtTvtmDVbS87YWv6HXm7B+Jvx9k+QuOMrOR+Ul/iTf93iyr
        xjKbyuWKIGwwWFyw5KZVNlW1gMrGEhXyht4WhHci+l4Nin/S1FRCdv3kMmFFgjLRJtkbP4gPVsQRZ
        Zj/CRNvjQ2HyJjevRDmaB0CIEzb3wn4VsNmJwhfkqGiMiM1ldx1Bq+v0U/TEjXYPt8jdPOpMk4n1c
        vQEERdRFkMfu8I1VH64q2IwRqYEq+vZnRz1AwE6zjsVJgHmnjFgXctZpbaETDntZ18RWNYE+Tn3ii
        VbxTN1BQ==;
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o03Cw-0069LO-Mm; Sat, 11 Jun 2022 15:39:26 +0000
Date:   Sat, 11 Jun 2022 15:39:26 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Mike Marshall <hubcap@omnibond.com>,
        Gao Xiang <xiang@kernel.org>, linux-afs@lists.infradead.org,
        v9fs-developer@lists.sourceforge.net, devel@lists.orangefs.org,
        linux-erofs@lists.ozlabs.org, linux-cachefs@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: mainline build failure due to 6c77676645ad ("iov_iter: Fix
 iter_xarray_get_pages{,_alloc}()")
Message-ID: <YqS3LqioLdSYIWgS@zeniv-ca.linux.org.uk>
References: <YqRyL2sIqQNDfky2@debian>
 <YqSGv6uaZzLxKfmG@zeniv-ca.linux.org.uk>
 <YqSMmC/UuQpXdxtR@zeniv-ca.linux.org.uk>
 <YqSQ++8UnEW0AJ2y@zeniv-ca.linux.org.uk>
 <20220611140052.GA288528@roeck-us.net>
 <YqSuPPM0rNQaRwlm@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqSuPPM0rNQaRwlm@zeniv-ca.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jun 11, 2022 at 03:01:16PM +0000, Al Viro wrote:
> On Sat, Jun 11, 2022 at 07:00:52AM -0700, Guenter Roeck wrote:
> > On Sat, Jun 11, 2022 at 12:56:27PM +0000, Al Viro wrote:
> > > On Sat, Jun 11, 2022 at 12:37:44PM +0000, Al Viro wrote:
> > > > On Sat, Jun 11, 2022 at 12:12:47PM +0000, Al Viro wrote:
> > > > 
> > > > 
> > > > > At a guess, should be
> > > > > 	return min((size_t)nr * PAGE_SIZE - offset, maxsize);
> > > > > 
> > > > > in both places.  I'm more than half-asleep right now; could you verify that it
> > > > > (as the last lines of both iter_xarray_get_pages() and iter_xarray_get_pages_alloc())
> > > > > builds correctly?
> > > > 
> > > > No, I'm misreading it - it's unsigned * unsigned long - unsigned vs. size_t.
> > > > On arm it ends up with unsigned long vs. unsigned int; functionally it *is*
> > > > OK (both have the same range there), but it triggers the tests.  Try 
> > > > 
> > > > 	return min_t(size_t, nr * PAGE_SIZE - offset, maxsize);
> > > > 
> > > > there (both places).
> > > 
> > > The reason we can't overflow on multiplication there, BTW, is that we have
> > > nr <= count, and count has come from weirdly open-coded
> > > 	DIV_ROUND_UP(size + offset, PAGE_SIZE)
> > 
> > That is often done to avoid possible overflows. Is size + offset
> > guaranteed to be smaller than ULONG_MAX ?
> 
> You'd need iter->count and maxsize argument to be within PAGE_SIZE of
> ULONG_MAX.  How would you populate that xarray, anyway?

	FWIW, it probably would be a good idea to truncate maxsize to LONG_MAX
in iov_iter_get_pages()/iov_iter_get_pages_alloc(), just to avoid that kind
of crap in the future.  Check that maxpages is not zero on the top level,
while we are at it...

	Any caller of iov_iter_get_pages{,_alloc}() must be ready to handle
getting less than what they'd asked for - if nothing else, get_user_pages_fast()
might refuse to give you more than this many pages, etc.  All in-tree callers
do, AFAICS.  And if anyone comes with "pin me more than LONG_MAX bytes of RAM
in one call, I can't accept anything less than that", well...  ISO9000-compliant
response per Dilbert would be called for.
