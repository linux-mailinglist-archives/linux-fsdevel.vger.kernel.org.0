Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E624A720CC2
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Jun 2023 02:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236983AbjFCAz5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Jun 2023 20:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237011AbjFCAzz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Jun 2023 20:55:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0852E62;
        Fri,  2 Jun 2023 17:55:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2030C60FC6;
        Sat,  3 Jun 2023 00:55:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 246A0C433D2;
        Sat,  3 Jun 2023 00:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1685753748;
        bh=Xubkvl6o/dMjh0W2gs6rjN5eA+h0WSm7E9vZ1z6roSE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ckdb5p4PjYQ2h0tguVeop9ZOh+CNCjMk4ZQS8TtIbeq1ACOe7Hp9tfmWK3rgzPfgd
         u/08F1YFM4P9P9YNGu9hXZBBpraG979oH2iY8h9V0WowMpD5+x8ChFXswpJBhMdHhw
         eWk+w9/CsGr7KZWGWop98gLyPrQgbPKWXY0FTPxI=
Date:   Fri, 2 Jun 2023 17:55:47 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Ackerley Tng <ackerleytng@google.com>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>, vannapurve@google.com,
        erdemaktas@google.com, stable <stable@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 0/1] RESEND fix page_cache_next/prev_miss off by one
 error
Message-Id: <20230602175547.dba09bb3ef7eb0bc508b3a5a@linux-foundation.org>
In-Reply-To: <20230602225747.103865-1-mike.kravetz@oracle.com>
References: <20230602225747.103865-1-mike.kravetz@oracle.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri,  2 Jun 2023 15:57:46 -0700 Mike Kravetz <mike.kravetz@oracle.com> wrote:

> In commits d0ce0e47b323 and 91a2fb956ad99, hugetlb code was changed to
> use page_cache_next_miss to determine if a page was present in the page
> cache.  However, the current implementation of page_cache_next_miss will
> always return the passed index if max_scan is 1 as in the hugetlb code.
> As a result, hugetlb code will always thing a page is present in the
> cache, even if that is not the case.
> 
> The patch which follows addresses the issue by changing the implementation
> of page_cache_next_miss and for consistency page_cache_prev_miss.  Since
> such a patch also impacts the readahead code, I would suggest using the
> patch by Sidhartha Kumar [1] to fix the issue in 6.3 and this patch moving
> forward.

Well this is tricky.

This patch applies cleanly to 6.3, so if we add cc:stable to this
patch, it will get backported, against your suggestion.

Sidhartha's patch [1] (which you recommend for -stable) is quite
different from this patch.  And Sidhartha's patch has no route to being
tested in linux-next nor to being merged by Linus.

So problems.  The preferable approach is to just backport this patch
into -stable in the usual fashion.  What are the risks in doing this?

> If we would rather not modify page_cache_next/prev_miss, then a new
> interface as suggested by Ackerley Tng [2] could also be used.
> 
> Comments on the best way to fix moving forward would be appreciated.
> 
> [1] https://lore.kernel.org/linux-mm/20230505185301.534259-1-sidhartha.kumar@oracle.com/
> [2] https://lore.kernel.org/linux-mm/98624c2f481966492b4eb8272aef747790229b73.1683069252.git.ackerleytng@google.com/
> 
> Mike Kravetz (1):
>   page cache: fix page_cache_next/prev_miss off by one
> 
>  mm/filemap.c | 26 ++++++++++++++++----------
>  1 file changed, 16 insertions(+), 10 deletions(-)
> 

