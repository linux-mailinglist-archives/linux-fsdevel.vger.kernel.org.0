Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B36E66D490
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jan 2023 03:50:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235658AbjAQCub (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Jan 2023 21:50:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235721AbjAQCsc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Jan 2023 21:48:32 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6CFC31E27;
        Mon, 16 Jan 2023 18:42:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=000a9m2DoIoKjXK7sVIo2/A2GFC81Al6i8o61eGFBME=; b=Ulmd1P+pFnTGzsE0Veaz8CDJrb
        l2SeOPiAAlZVK73sfMGTnBnttA+ugjnHs9dmERQAnAsqMFnsATPmMtjWyygDbe+kPAG4fL+V15gE8
        jP3KN9CNjU/Btl32PE9hrj4fzQAHzd8VYMLhhXxRo2QySc9BtIkLKR7PkACGf+MfAJ59IBFzN/gtU
        /c4DeepTwNHezJqzu0TTjbQ2/OlAsgeKaw0F7gS2OydtWq4eGVxCpOvFxkha8V+nwo/ytwtl/o0iY
        HeIOcWhrziUWzn8ekaYrGIl+h/CEfImbS8DeNx7R/QSzzoyZ5HvYwIURZpLwcQeM71CvloLBr+GOR
        pX0BNMQw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pHbur-009Ia4-Fu; Tue, 17 Jan 2023 02:41:37 +0000
Date:   Tue, 17 Jan 2023 02:41:37 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Amy Parker <apark0006@student.cerritos.edu>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dax: use switch statement over chained ifs
Message-ID: <Y8YK4c6KQg2xjM+E@casper.infradead.org>
References: <CAPOgqxF_xEgKspetRJ=wq1_qSG3h8mkyXC58TXkUvx0agzEm_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPOgqxF_xEgKspetRJ=wq1_qSG3h8mkyXC58TXkUvx0agzEm_A@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 16, 2023 at 06:11:00PM -0800, Amy Parker wrote:
> This patch uses a switch statement for pe_order, which improves
> readability and on some platforms may minorly improve performance. It
> also, to improve readability, recognizes that `PAGE_SHIFT - PAGE_SHIFT' is
> a constant, and uses 0 in its place instead.
> 
> Signed-off-by: Amy Parker <apark0006@student.cerritos.edu>

Hi Amy,

Thanks for the patch!  Two problems.  First, your mailer seems to have
mangled the patch; in my tree these are tab indents, and the patch has
arrived with four-space indents, so it can't be applied.

The second problem is that this function should simply not exist.
I forget how we ended up with enum page_entry_size, but elsewhere
we simply pass 'order' around.  So what I'd really like to see is
a patch series that eliminates page_entry_size everywhere.

I can outline a way to do that in individual patches if that would be
helpful.

>  fs/dax.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/dax.c b/fs/dax.c
> index c48a3a93ab29..e8beed601384 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -32,13 +32,16 @@
> 
>  static inline unsigned int pe_order(enum page_entry_size pe_size)
>  {
> -    if (pe_size == PE_SIZE_PTE)
> -        return PAGE_SHIFT - PAGE_SHIFT;
> -    if (pe_size == PE_SIZE_PMD)
> +    switch (pe_size) {
> +    case PE_SIZE_PTE:
> +        return 0;
> +    case PE_SIZE_PMD:
>          return PMD_SHIFT - PAGE_SHIFT;
> -    if (pe_size == PE_SIZE_PUD)
> +    case PE_SIZE_PUD:
>          return PUD_SHIFT - PAGE_SHIFT;
> -    return ~0;
> +    default:
> +        return ~0;
> +    }
>  }
> 
>  /* We choose 4096 entries - same as per-zone page wait tables */
> -- 
> 2.39.0
