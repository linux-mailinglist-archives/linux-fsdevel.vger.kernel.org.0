Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A66507A2777
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Sep 2023 21:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235850AbjIOTyR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Sep 2023 15:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231969AbjIOTyP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Sep 2023 15:54:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63567C7;
        Fri, 15 Sep 2023 12:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Yb0aXGGdlsQgU/B8FX1uy5m2GcMPKzwXuAhrykJSyg0=; b=T5Bw5jLf+rV8lN51oBY/eYf7vW
        4tVlsQ1NaKbz7asS3ljwbDo3W5nrMMKRr8bNPLdR1/fWWAi0BWpXgJeEowhVaJmqlX4BMJB3w9nkm
        6hP+2/dTfCEc5h87HFBqbPje020S4imv4jMOAs8vNP+UjzGGXlPeC1fbe1hh8p3pvxhAYVMf29HeC
        ehtemRFVopME8CgLhmZFeWsRnfESAWaW9SZe3WlzTsQgdmaDOTU4GM7PeNFpKBlBMk2POlni1Z28I
        8//nYNO8rWCG3R5JHP68kXv0kOnIQB42fxbSS1S3dDFkJkDJP1Fi+J5dipw95Xa4po122Jmk+Ybo9
        sjlUu0iQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qhEtD-00Bip8-8T; Fri, 15 Sep 2023 19:54:07 +0000
Date:   Fri, 15 Sep 2023 20:54:07 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Pankaj Raghav <kernel@pankajraghav.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        p.raghav@samsung.com, david@fromorbit.com, da.gomez@samsung.com,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        djwong@kernel.org, linux-mm@kvack.org, chandan.babu@oracle.com,
        mcgrof@kernel.org, gost.dev@samsung.com
Subject: Re: [RFC 09/23] filemap: use mapping_min_order while allocating
 folios
Message-ID: <ZQS2X3Kn3wFSLCvu@casper.infradead.org>
References: <20230915183848.1018717-1-kernel@pankajraghav.com>
 <20230915183848.1018717-10-kernel@pankajraghav.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230915183848.1018717-10-kernel@pankajraghav.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 15, 2023 at 08:38:34PM +0200, Pankaj Raghav wrote:
> From: Pankaj Raghav <p.raghav@samsung.com>
> 
> Allocate al teast mapping_min_order when creating new folio for the
> filemap in filemap_create_folio() and do_read_cache_folio().

This patch is where you should be doing:

	index &= ~(folio_nr_pages(folio) - 1UL);

(or similar)

> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>  mm/filemap.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 21e1341526ab..e4d46f79e95d 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -2502,7 +2502,8 @@ static int filemap_create_folio(struct file *file,
>  	struct folio *folio;
>  	int error;
>  
> -	folio = filemap_alloc_folio(mapping_gfp_mask(mapping), 0);
> +	folio = filemap_alloc_folio(mapping_gfp_mask(mapping),
> +				    mapping_min_folio_order(mapping));
>  	if (!folio)
>  		return -ENOMEM;
>  
> @@ -3696,7 +3697,8 @@ static struct folio *do_read_cache_folio(struct address_space *mapping,
>  repeat:
>  	folio = filemap_get_folio(mapping, index);
>  	if (IS_ERR(folio)) {
> -		folio = filemap_alloc_folio(gfp, 0);
> +		folio = filemap_alloc_folio(gfp,
> +					    mapping_min_folio_order(mapping));
>  		if (!folio)
>  			return ERR_PTR(-ENOMEM);
>  		err = filemap_add_folio(mapping, folio, index, gfp);
> -- 
> 2.40.1
> 
