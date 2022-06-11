Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1911547470
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Jun 2022 14:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231603AbiFKMNP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 11 Jun 2022 08:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbiFKMNO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 11 Jun 2022 08:13:14 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C4C68DDFB;
        Sat, 11 Jun 2022 05:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=atgndddR6SXbIyqaExtJZJhw3ic+UgK9VwWvZJVDRqM=; b=DTBELQ0XOtAet4aUT4efB1q+ia
        sP7gw1tag71Ut9T9J0Y25hndtEHuQORviFREhu65NZ0JgunSjujQajXnFDN3Uhx2zyhojxkmZdwl0
        qFbkPtFs+jzPUrd06AFHJ66iAw0ZejUG7QGBkdYtMMAUYvF9gwQ6+Ge5hl2MN67J7+9sdYld9SbYL
        7zB8a17jvdMvDNcoBdbiC4mM+jU2vVpWX0/p6VbQ5opblAuQF9I0QDAwkqUReQnlGVQzFY2iASRbs
        tjceebpiSFE/FT8okP3RGX3Tw9QnTYrgEfjEhqkRpch/IGE+mV1sULTrAUnDj20FxAqpoFnIyfoHN
        le1+vSDQ==;
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nzzyx-0065U6-SO; Sat, 11 Jun 2022 12:12:48 +0000
Date:   Sat, 11 Jun 2022 12:12:47 +0000
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
Message-ID: <YqSGv6uaZzLxKfmG@zeniv-ca.linux.org.uk>
References: <YqRyL2sIqQNDfky2@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqRyL2sIqQNDfky2@debian>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jun 11, 2022 at 11:45:03AM +0100, Sudip Mukherjee wrote:
> Hi All,
> 
> The latest mainline kernel branch fails to build for "arm allmodconfig",
> "xtensa allmodconfig" and "csky allmodconfig" with the error:
> 
> In file included from ./include/linux/kernel.h:26,
>                  from ./include/linux/crypto.h:16,
>                  from ./include/crypto/hash.h:11,
>                  from lib/iov_iter.c:2:
> lib/iov_iter.c: In function 'iter_xarray_get_pages':
> ./include/linux/minmax.h:20:35: error: comparison of distinct pointer types lacks a cast [-Werror]
>    20 |         (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
>       |                                   ^~
> ./include/linux/minmax.h:26:18: note: in expansion of macro '__typecheck'
>    26 |                 (__typecheck(x, y) && __no_side_effects(x, y))
>       |                  ^~~~~~~~~~~
> ./include/linux/minmax.h:36:31: note: in expansion of macro '__safe_cmp'
>    36 |         __builtin_choose_expr(__safe_cmp(x, y), \
>       |                               ^~~~~~~~~~
> ./include/linux/minmax.h:45:25: note: in expansion of macro '__careful_cmp'
>    45 | #define min(x, y)       __careful_cmp(x, y, <)
>       |                         ^~~~~~~~~~~~~
> lib/iov_iter.c:1464:16: note: in expansion of macro 'min'
>  1464 |         return min(nr * PAGE_SIZE - offset, maxsize);
>       |                ^~~
> lib/iov_iter.c: In function 'iter_xarray_get_pages_alloc':
> ./include/linux/minmax.h:20:35: error: comparison of distinct pointer types lacks a cast [-Werror]
>    20 |         (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
>       |                                   ^~
> ./include/linux/minmax.h:26:18: note: in expansion of macro '__typecheck'
>    26 |                 (__typecheck(x, y) && __no_side_effects(x, y))
>       |                  ^~~~~~~~~~~
> ./include/linux/minmax.h:36:31: note: in expansion of macro '__safe_cmp'
>    36 |         __builtin_choose_expr(__safe_cmp(x, y), \
>       |                               ^~~~~~~~~~
> ./include/linux/minmax.h:45:25: note: in expansion of macro '__careful_cmp'
>    45 | #define min(x, y)       __careful_cmp(x, y, <)
>       |                         ^~~~~~~~~~~~~
> lib/iov_iter.c:1628:16: note: in expansion of macro 'min'
>  1628 |         return min(nr * PAGE_SIZE - offset, maxsize);
> 
> 
> git bisect pointed to 6c77676645ad ("iov_iter: Fix iter_xarray_get_pages{,_alloc}()")

At a guess, should be
	return min((size_t)nr * PAGE_SIZE - offset, maxsize);

in both places.  I'm more than half-asleep right now; could you verify that it
(as the last lines of both iter_xarray_get_pages() and iter_xarray_get_pages_alloc())
builds correctly?
