Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A449526532
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 May 2022 16:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381327AbiEMOr7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 May 2022 10:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376714AbiEMOr5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 May 2022 10:47:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A2431239;
        Fri, 13 May 2022 07:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=ztuINqFjPlYU6A7nur+hQa2c3/cfWMKnPJP7Dz5NJGg=; b=gQT97zesi9Xx/9EiGMIH0tllcu
        fr8JzAVYeWkZxHWUWh/+Jb2L6qcaarb/zN2mkSr86StvAC/HmPUs4Wi75qNRtBedy6an1zuaRb+D6
        cZtICjC9fonBjTDX/3UyFC0yLXP6qk9jS0rSZayUaSvla1NoGbZRXRgSzxjzNmEWAlXdfFtH/NVwr
        FTSvGdA3oNowKx5zucbw2dVTAon/OdrRNV+pqA3JVLauDvGmfJ6tL0u95S/qyc1Dv25Yx1VAh24fW
        vvDuxKdKaphTe7N6gqz1kgJVSyv8mLytZ3HYcepZlC/9uNw0Ys7qjYPDKOwg1YBvy+galQqWsbPPN
        5AkS8bbg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1npWaA-007Qg1-Pn; Fri, 13 May 2022 14:47:54 +0000
Date:   Fri, 13 May 2022 15:47:54 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Xiubo Li <xiubli@redhat.com>,
        =?iso-8859-1?Q?Lu=EDs?= Henriques <lhenriques@suse.de>
Subject: Re: [PATCH] mm: BUG if filemap_alloc_folio gives us a folio with a
 non-NULL ->private
Message-ID: <Yn5vmh0WbhczfURJ@casper.infradead.org>
References: <20220513142952.27853-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220513142952.27853-1-jlayton@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 13, 2022 at 10:29:52AM -0400, Jeff Layton wrote:
> We've seen some instances where we call __filemap_get_folio and get back
> one with a ->private value that is non-NULL. Let's have the allocator
> bug if that happens.

Oh, I meant for this to be a debugging aid for your case, rather than
be something we put into upstream.  If we do find out that the page
allocator is returning pages with page->private non-NULL, we should
discuss what the guarantee is that the page allocator provides -- does
it guarantee that page->private is NULL, or is that something the page
cache should zero out itself.

If we do end up changing filemap_alloc_folio(), we need to remember to
change the one in pagemap.h too.

> URL: https://tracker.ceph.com/issues/55421
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Xiubo Li <xiubli@redhat.com>
> Cc: Luís Henriques <lhenriques@suse.de>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  mm/filemap.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> It might not hurt to merge this into mainline. If it pops then we know
> something is very wrong.
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 9a1eef6c5d35..74c3fb062ef7 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -990,10 +990,12 @@ struct folio *filemap_alloc_folio(gfp_t gfp, unsigned int order)
>  			n = cpuset_mem_spread_node();
>  			folio = __folio_alloc_node(gfp, order, n);
>  		} while (!folio && read_mems_allowed_retry(cpuset_mems_cookie));
> -
> -		return folio;
> +	} else {
> +		folio = folio_alloc(gfp, order);
>  	}
> -	return folio_alloc(gfp, order);
> +	if (folio)
> +		VM_BUG_ON_FOLIO(folio->private, folio);
> +	return folio;
>  }
>  EXPORT_SYMBOL(filemap_alloc_folio);
>  #endif
> -- 
> 2.36.1
> 
