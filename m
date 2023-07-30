Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59F2A7684E5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Jul 2023 13:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbjG3LH3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 30 Jul 2023 07:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbjG3LH1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 30 Jul 2023 07:07:27 -0400
X-Greylist: delayed 346 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 30 Jul 2023 04:07:23 PDT
Received: from out-86.mta0.migadu.com (out-86.mta0.migadu.com [91.218.175.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D37D810F9
        for <linux-fsdevel@vger.kernel.org>; Sun, 30 Jul 2023 04:07:23 -0700 (PDT)
Message-ID: <a2a2180c-62ac-452f-0737-26f01f228c79@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1690714895;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YDqItS6TsBITc0ogQeiO9zs2cfijso9HiN6zsa9jo50=;
        b=XpXFu6WxU3V13MvRIEnz/7Ji7DORifqqz168/epr0ILzyigpBFV+A4z4oGIVSkBtUeOFgh
        diNqH0zw0JE5/uCXG3B6N+tvcHXMpKZsZ6s0eKFzsZ+X7f+mOxmtYIXl0uv700u7SMTX1R
        uLBVb66nh3KObdbTdSfDQ/9rS/J3C2k=
Date:   Sun, 30 Jul 2023 19:01:26 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 03/13] scatterlist: Add sg_set_folio()
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        netdev@vger.kernel.org
References: <20230621164557.3510324-1-willy@infradead.org>
 <20230621164557.3510324-4-willy@infradead.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20230621164557.3510324-4-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

在 2023/6/22 0:45, Matthew Wilcox (Oracle) 写道:
> This wrapper for sg_set_page() lets drivers add folios to a scatterlist
> more easily.  We could, perhaps, do better by using a different page
> in the folio if offset is larger than UINT_MAX, but let's hope we get
> a better data structure than this before we need to care about such
> large folios.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>   include/linux/scatterlist.h | 24 ++++++++++++++++++++++++
>   1 file changed, 24 insertions(+)
> 
> diff --git a/include/linux/scatterlist.h b/include/linux/scatterlist.h
> index ec46d8e8e49d..77df3d7b18a6 100644
> --- a/include/linux/scatterlist.h
> +++ b/include/linux/scatterlist.h
> @@ -141,6 +141,30 @@ static inline void sg_set_page(struct scatterlist *sg, struct page *page,
>   	sg->length = len;
>   }
>   
> +/**
> + * sg_set_folio - Set sg entry to point at given folio
> + * @sg:		 SG entry
> + * @folio:	 The folio
> + * @len:	 Length of data
> + * @offset:	 Offset into folio
> + *
> + * Description:
> + *   Use this function to set an sg entry pointing at a folio, never assign
> + *   the folio directly. We encode sg table information in the lower bits
> + *   of the folio pointer. See sg_page() for looking up the page belonging
> + *   to an sg entry.
> + *
> + **/
> +static inline void sg_set_folio(struct scatterlist *sg, struct folio *folio,
> +			       size_t len, size_t offset)
> +{
> +	WARN_ON_ONCE(len > UINT_MAX);
> +	WARN_ON_ONCE(offset > UINT_MAX);
> +	sg_assign_page(sg, &folio->page);
> +	sg->offset = offset;
> +	sg->length = len;
> +}
> +

https://elixir.bootlin.com/linux/latest/source/lib/scatterlist.c#L451

Does the following function have folio version?

"
int sg_alloc_append_table_from_pages(struct sg_append_table *sgt_append,
		struct page **pages, unsigned int n_pages, unsigned int offset,
		unsigned long size, unsigned int max_segment,
		unsigned int left_pages, gfp_t gfp_mask)
"

Thanks a lot.
Zhu Yanjun

>   static inline struct page *sg_page(struct scatterlist *sg)
>   {
>   #ifdef CONFIG_DEBUG_SG

