Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E76D45475DF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Jun 2022 17:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237099AbiFKPBi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 11 Jun 2022 11:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233836AbiFKPBh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 11 Jun 2022 11:01:37 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA689654A;
        Sat, 11 Jun 2022 08:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9vgJd/fIuQ4ZpHZzquMnxQ7TKWacR7xtAP6nZ+FYUdo=; b=P012lR2l7PYF8ZfC8IWYrypqWB
        ExTyxhwihX2l96+mR6voO0mRqONRKn9SuYG2JuVxSkokpbeP32K3mxL+qy+eLoCJJuhVGaCmyGUvG
        2fqf1sXk1Akn4upqTPKogZFsnSlcGUS3Hwq3f59OknwXzmt003+iNrJyi0VHThjSDwSCnvepD6qw3
        2asfwp7bVY1y/l9Y0aHukinZ2wlpPJk0E449eHrdoSCquNe2jyzCnuBPLPEMgfJrWaa0QF+KhZcvr
        OKFnACEdCx+uUzLzschL+y8LCtemRFI2TWE1iXCPzmAkELsfoHy0OoJzUagwr2pSbBkvjZ8fn4uDD
        uzFwvXAA==;
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o02c0-0068m3-Ma; Sat, 11 Jun 2022 15:01:16 +0000
Date:   Sat, 11 Jun 2022 15:01:16 +0000
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
Message-ID: <YqSuPPM0rNQaRwlm@zeniv-ca.linux.org.uk>
References: <YqRyL2sIqQNDfky2@debian>
 <YqSGv6uaZzLxKfmG@zeniv-ca.linux.org.uk>
 <YqSMmC/UuQpXdxtR@zeniv-ca.linux.org.uk>
 <YqSQ++8UnEW0AJ2y@zeniv-ca.linux.org.uk>
 <20220611140052.GA288528@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220611140052.GA288528@roeck-us.net>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jun 11, 2022 at 07:00:52AM -0700, Guenter Roeck wrote:
> On Sat, Jun 11, 2022 at 12:56:27PM +0000, Al Viro wrote:
> > On Sat, Jun 11, 2022 at 12:37:44PM +0000, Al Viro wrote:
> > > On Sat, Jun 11, 2022 at 12:12:47PM +0000, Al Viro wrote:
> > > 
> > > 
> > > > At a guess, should be
> > > > 	return min((size_t)nr * PAGE_SIZE - offset, maxsize);
> > > > 
> > > > in both places.  I'm more than half-asleep right now; could you verify that it
> > > > (as the last lines of both iter_xarray_get_pages() and iter_xarray_get_pages_alloc())
> > > > builds correctly?
> > > 
> > > No, I'm misreading it - it's unsigned * unsigned long - unsigned vs. size_t.
> > > On arm it ends up with unsigned long vs. unsigned int; functionally it *is*
> > > OK (both have the same range there), but it triggers the tests.  Try 
> > > 
> > > 	return min_t(size_t, nr * PAGE_SIZE - offset, maxsize);
> > > 
> > > there (both places).
> > 
> > The reason we can't overflow on multiplication there, BTW, is that we have
> > nr <= count, and count has come from weirdly open-coded
> > 	DIV_ROUND_UP(size + offset, PAGE_SIZE)
> 
> That is often done to avoid possible overflows. Is size + offset
> guaranteed to be smaller than ULONG_MAX ?

You'd need iter->count and maxsize argument to be within PAGE_SIZE of
ULONG_MAX.  How would you populate that xarray, anyway?
