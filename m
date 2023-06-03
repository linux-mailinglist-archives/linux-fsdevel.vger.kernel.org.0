Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7C0720CC9
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Jun 2023 02:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237037AbjFCA72 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Jun 2023 20:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236854AbjFCA71 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Jun 2023 20:59:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 949341A8;
        Fri,  2 Jun 2023 17:59:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E7B461FD9;
        Sat,  3 Jun 2023 00:59:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 458BAC433EF;
        Sat,  3 Jun 2023 00:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1685753961;
        bh=eh5DVYfbuqzMcZ0I3u+igVhAEofzAdLoif80bx8rdXA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dvaor2btUSVJCn43NTJn7k/xOz6V6rhBlT8B9vOL+YqUga2PPqqPOs90Kq7lKaqTx
         pGNf1bFuUGvMpEtESxs41nFqqBkXMblNA0nFjani75NWb7YYi0Z5yBDjnpoIr4D8pM
         2tzmebkYbhmrqYhTl7C/ISZJrV7AT1RReLYE+BCw=
Date:   Fri, 2 Jun 2023 17:59:20 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Ackerley Tng <ackerleytng@google.com>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>, vannapurve@google.com,
        erdemaktas@google.com
Subject: Re: [PATCH 1/1] page cache: fix page_cache_next/prev_miss off by
 one
Message-Id: <20230602175920.4891c718afd2b20b7cd620cb@linux-foundation.org>
In-Reply-To: <20230602225747.103865-2-mike.kravetz@oracle.com>
References: <20230602225747.103865-1-mike.kravetz@oracle.com>
        <20230602225747.103865-2-mike.kravetz@oracle.com>
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

On Fri,  2 Jun 2023 15:57:47 -0700 Mike Kravetz <mike.kravetz@oracle.com> wrote:

> Ackerley Tng reported an issue with hugetlbfs fallocate here[1].  The
> issue showed up after the conversion of hugetlb page cache lookup code
> to use page_cache_next_miss.

So I'm assuming

Fixes: d0ce0e47b323 ("mm/hugetlb: convert hugetlb fault paths to use alloc_hugetlb_folio()")

?

> Code in hugetlb fallocate, userfaultfd
> and GUP is now using page_cache_next_miss to determine if a page is
> present the page cache.  The following statement is used.
> 
> 	present = page_cache_next_miss(mapping, index, 1) != index;
> 
> There are two issues with page_cache_next_miss when used in this way.
> 1) If the passed value for index is equal to the 'wrap-around' value,
>    the same index will always be returned.  This wrap-around value is 0,
>    so 0 will be returned even if page is present at index 0.
> 2) If there is no gap in the range passed, the last index in the range
>    will be returned.  When passed a range of 1 as above, the passed
>    index value will be returned even if the page is present.
> The end result is the statement above will NEVER indicate a page is
> present in the cache, even if it is.
> 
> As noted by Ackerley in [1], users can see this by hugetlb fallocate
> incorrectly returning EEXIST if pages are already present in the file.
> In addition, hugetlb pages will not be included in core dumps if they
> need to be brought in via GUP.  userfaultfd UFFDIO_COPY also uses this
> code and will not notice pages already present in the cache.  It may try
> to allocate a new page and potentially return ENOMEM as opposed to
> EEXIST.
> 
> Both page_cache_next_miss and page_cache_prev_miss have similar issues.
> Fix by:
> - Check for index equal to 'wrap-around' value and do not exit early.
> - If no gap is found in range, return index outside range.
> - Update function description to say 'wrap-around' value could be
>   returned if passed as index.
> 
> [1] https://lore.kernel.org/linux-mm/cover.1683069252.git.ackerleytng@google.com/
> 

