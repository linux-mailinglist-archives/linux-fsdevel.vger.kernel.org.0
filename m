Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21B45547496
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Jun 2022 14:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232802AbiFKMh5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 11 Jun 2022 08:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231649AbiFKMh4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 11 Jun 2022 08:37:56 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB3AD13D2A;
        Sat, 11 Jun 2022 05:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SBb05lsgd+OOO2FAPABsHHQaP96X8u5Au9bw5c2kfU4=; b=sSxz2SDHX74tI+Mh9uDjx3JBjg
        w3M60laG/7hD1NiTZNVfdfPuo8p/SykNo8lqbTv5uGDaFkO3ewl0sgcDlNAKK/p0o3SOsRxZD+IrE
        cMycJ9Xhpv/ja36hHX2jBp3TCQZarjEWFVG/BpJxm7T0W79NVhBFLRLzBcyn5nVH9KgbsB7TG+FIn
        INxBFAgn08urU27wENZJuOmqUTmdXIC99VaA6g0D3qEU6lOjwksGiTP9dwcKjQCgIGXpAHdag0GhL
        wiV/BRwo2T/sZ6hMVJWEHrU+8TAL9zodMFX4uklEQI/nDGBoO4DrbD4aodbPrAPoKbqaai2dCUNvb
        E7js933w==;
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o00N6-0065ri-LL; Sat, 11 Jun 2022 12:37:44 +0000
Date:   Sat, 11 Jun 2022 12:37:44 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     David Howells <dhowells@redhat.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Mike Marshall <hubcap@omnibond.com>,
        Gao Xiang <xiang@kernel.org>, linux-afs@lists.infradead.org,
        v9fs-developer@lists.sourceforge.net, devel@lists.orangefs.org,
        linux-erofs@lists.ozlabs.org, linux-cachefs@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: mainline build failure due to 6c77676645ad ("iov_iter: Fix
 iter_xarray_get_pages{,_alloc}()")
Message-ID: <YqSMmC/UuQpXdxtR@zeniv-ca.linux.org.uk>
References: <YqRyL2sIqQNDfky2@debian>
 <YqSGv6uaZzLxKfmG@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqSGv6uaZzLxKfmG@zeniv-ca.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jun 11, 2022 at 12:12:47PM +0000, Al Viro wrote:


> At a guess, should be
> 	return min((size_t)nr * PAGE_SIZE - offset, maxsize);
> 
> in both places.  I'm more than half-asleep right now; could you verify that it
> (as the last lines of both iter_xarray_get_pages() and iter_xarray_get_pages_alloc())
> builds correctly?

No, I'm misreading it - it's unsigned * unsigned long - unsigned vs. size_t.
On arm it ends up with unsigned long vs. unsigned int; functionally it *is*
OK (both have the same range there), but it triggers the tests.  Try 

	return min_t(size_t, nr * PAGE_SIZE - offset, maxsize);

there (both places).

Al, going back to sleep - 4 hours is not enough...
