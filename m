Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA25B722DA2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jun 2023 19:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234915AbjFER1D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Jun 2023 13:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234801AbjFER0y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Jun 2023 13:26:54 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 994B5127
        for <linux-fsdevel@vger.kernel.org>; Mon,  5 Jun 2023 10:26:53 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-256a43693e7so1670250a91.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Jun 2023 10:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685986013; x=1688578013;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ueWZS/kOW4BuWhGYKzzIBH6tWenyxQH8hwfC8Aoaus0=;
        b=hDFZ0MSP0Jx9/6SIuv8n9M3NinI6ZNIbBZlcKOB0iBuwHHVhKhGmC5BPbvGCwj8RYh
         cZUFVduYF1QdnBqWv3zZFKxS2Mdj93m0/VWd+nQb49gdc0MWKl+TvoDVt6pZjICFKfeZ
         RB9vUfL9lITC4VYwVIy9kIThY1YFtd0Fku8bdiGP1nHYtY+S57g1egGBa1/BHy8Zm3Fk
         7iGm6sqXyx1BeBS/5pMX4b//nG3c2ECtq4osABZCGSseAY/WC9eSyK7tAPFTJ3aaE5G2
         jbVUDMVz1Tx/ulJ0o96ojpqWg/tvCfef3KAWLv+nQjnaaIiLwXRPeg8xN5oebS5nlKBC
         SN5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685986013; x=1688578013;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ueWZS/kOW4BuWhGYKzzIBH6tWenyxQH8hwfC8Aoaus0=;
        b=KpFzcKEC2AQFAvJzPPgNJoxExw7XabeCpl0DkCA99UHQMzWAtUEHGX8KreC4YBN1mA
         qHuUt2q9p0t4zNphOevnP9W2wj6wW9BgWcyPQLNGy/sgRXRBMC3/7a04Zpr4aCsyHGi+
         qr5aS20DYuPMGI7hMH3YpQJ1e2KmlU7URnvFsoy7kn1KX5Da1SPrm/3r7tbhtLcNGoVX
         VPafxDFGURGq2str5fVZ1b4Qo7Ril0mqdBhpPhIlExM+4EP7aTTdcJnfrGE1CsDWRxTF
         niRb7osLUdIYNotxrWKFRivhCQMTV9O6vd7pRKXzdeX81uPwtoRHuHzsEQHNUtY2p38Y
         +0rA==
X-Gm-Message-State: AC+VfDyxL6Vg00wtAqBFlJRe+nVGv61YEQT9qmfkGhYlsD5ThJnTUqwS
        GTwgKltf4ePDdIrkAjZlpGDpifmfcGi1PN2x5A==
X-Google-Smtp-Source: ACHHUZ6zcZqHZyBmfLUjfwJE+pMRoCoiRHufLHJlw69HS8jnaE2sQ+clt3zwG4Y1oholewzQ6Ug2L4xwulkdwmPsQA==
X-Received: from ackerleytng-ctop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:13f8])
 (user=ackerleytng job=sendgmr) by 2002:a17:90b:f89:b0:253:6d69:605b with SMTP
 id ft9-20020a17090b0f8900b002536d69605bmr1855277pjb.1.1685986012933; Mon, 05
 Jun 2023 10:26:52 -0700 (PDT)
Date:   Mon, 05 Jun 2023 17:26:51 +0000
In-Reply-To: <20230602225747.103865-2-mike.kravetz@oracle.com> (message from
 Mike Kravetz on Fri,  2 Jun 2023 15:57:47 -0700)
Mime-Version: 1.0
Message-ID: <diqzttvlom5g.fsf@ackerleytng-ctop.c.googlers.com>
Subject: Re: [PATCH 1/1] page cache: fix page_cache_next/prev_miss off by one
From:   Ackerley Tng <ackerleytng@google.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, willy@infradead.org,
        sidhartha.kumar@oracle.com, songmuchun@bytedance.com,
        vannapurve@google.com, erdemaktas@google.com,
        akpm@linux-foundation.org, mike.kravetz@oracle.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Mike Kravetz <mike.kravetz@oracle.com> writes:

> diff --git a/mm/filemap.c b/mm/filemap.c
> index 71dc90f64e43..123540c7ba45 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -1733,7 +1733,9 @@ bool __folio_lock_or_retry(struct folio *folio,  
> struct mm_struct *mm,
>    *
>    * Return: The index of the gap if found, otherwise an index outside the
>    * range specified (in which case 'return - index >= max_scan' will be  
> true).
> - * In the rare case of index wrap-around, 0 will be returned.
> + * In the rare case of index wrap-around, 0 will be returned.  0 will  
> also
> + * be returned if index == 0 and there is a gap at the index.  We can not
> + * wrap-around if passed index == 0.
>    */
>   pgoff_t page_cache_next_miss(struct address_space *mapping,
>   			     pgoff_t index, unsigned long max_scan)
> @@ -1743,12 +1745,13 @@ pgoff_t page_cache_next_miss(struct address_space  
> *mapping,
>   	while (max_scan--) {
>   		void *entry = xas_next(&xas);
>   		if (!entry || xa_is_value(entry))
> -			break;
> -		if (xas.xa_index == 0)
> -			break;
> +			return xas.xa_index;
> +		if (xas.xa_index == 0 && index != 0)
> +			return xas.xa_index;
>   	}

> -	return xas.xa_index;
> +	/* No gaps in range and no wrap-around, return index beyond range */
> +	return xas.xa_index + 1;
>   }
>   EXPORT_SYMBOL(page_cache_next_miss);


This doesn't seem to work as expected:

Here's a test I did

/* Modified so I can pass in an xarray for this test */
static unsigned long page_cache_next_miss(struct xarray *xa, unsigned long  
index,
					  unsigned long max_scan)
{
	XA_STATE(xas, xa, index);

	while (max_scan--) {
		void *entry = xas_next(&xas);
		if (!entry || xa_is_value(entry))
			return xas.xa_index;
		if (xas.xa_index == 0 && index != 0)
			return xas.xa_index;
	}

	return xas.xa_index + 1;
}

static noinline void check_find_5(void)
{
	struct xarray xa;
	unsigned long max_scan;
	void *ptr = malloc(10);

	xa_init(&xa);
	xa_store_range(&xa, 3, 5, ptr, GFP_KERNEL);

	max_scan = 3;
	printk("page_cache_next_miss(xa, %d, %ld): %ld\n", 4, max_scan,
	       page_cache_next_miss(&xa, 4, max_scan));

}

The above gave me: page_cache_next_miss(xa, 4, 3): 7

But I was expecting a return value of 6.

I investigated a little, and it seems like entry at index 6 if we start
iterating before 6 is 0xe, and xa_is_internal(entry) returns true.

Not yet familiar with the internals of xarrays, not sure what the fix
should be.
