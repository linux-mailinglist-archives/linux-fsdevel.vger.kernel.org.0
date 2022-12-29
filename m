Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB76E658F5E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Dec 2022 18:03:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233586AbiL2RDW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Dec 2022 12:03:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbiL2RDV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Dec 2022 12:03:21 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE2A13CD5;
        Thu, 29 Dec 2022 09:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FpO/eHt+84zbk9M68yu6DzZDNP2UCbAiX18klEN4/yA=; b=VTl9/194oI/R+TtJ/HBvlyV61k
        HXcMgF2toNI6pBRb/3FHLQ7fLcPI0De+9GfAn2n5NX6yL2Typvq+RiYIcsDx1KIKxdNXB73jKNStO
        y1hvemZd5yjmRV5iKBeY3t0A3bHEc9QUbAbvksyewg4PTT+MD3jWxtB9SyQkDPFAodEySLBeJ+kOi
        q14YcbDb7g1Pyv4wdK/VoGJsKmkJVN4vD/3GnbVg2kWT8j5qAqZu+OrmgkMwzNxi0D2vd7dII/VsH
        FSR5Y94CqlYw8/uRlVgYZY5rbq+p6wBi3UwYIXOx6hiLT80jAE+FT8noE9bjw6Q1DL/ANFIki+p1J
        GZGVUxeg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pAwJN-00A0P1-1z; Thu, 29 Dec 2022 17:03:21 +0000
Date:   Thu, 29 Dec 2022 17:03:21 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     yang.yang29@zte.com.cn
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, iamjoonsoo.kim@lge.com
Subject: Re: [PATCH linux-next] swap_state: update shadow_nodes for anonymous
 page
Message-ID: <Y63IWTOE4sNKuseL@casper.infradead.org>
References: <202212292130035747813@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202212292130035747813@zte.com.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 29, 2022 at 09:30:03PM +0800, yang.yang29@zte.com.cn wrote:
> From: Yang Yang <yang.yang29@zte.com.cn>
> 
> Shadow_nodes is for shadow nodes reclaiming of workingset handling,
> it is updated when page cache add or delete since long time ago
> workingset only supported page cache. But when workingset supports
> anonymous page detection[1], we missied updating shadow nodes for
> it.

Please include a description of the user-visible effect of this (I
think I can guess, but I'd like it spelled out)

> [1] commit aae466b0052e ("mm/swap: implement workingset detection for anonymous LRU")
> 
> Signed-off-by: Yang Yang <yang.yang29@zte.com>

No Fixes: line?  It doesn't need to be backported?

> ---
>  include/linux/xarray.h | 3 ++-
>  mm/swap_state.c        | 4 ++++
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/xarray.h b/include/linux/xarray.h
> index 44dd6d6e01bc..cd2ccb09c596 100644
> --- a/include/linux/xarray.h
> +++ b/include/linux/xarray.h
> @@ -1643,7 +1643,8 @@ static inline void xas_set_order(struct xa_state *xas, unsigned long index,
>   * @update: Function to call when updating a node.
>   *
>   * The XArray can notify a caller after it has updated an xa_node.
> - * This is advanced functionality and is only needed by the page cache.
> + * This is advanced functionality and is only needed by the page cache
> + * and anonymous page.

... "and swap cache.", not anonymous page.

