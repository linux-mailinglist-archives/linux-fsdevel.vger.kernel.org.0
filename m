Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 872275C0529
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Sep 2022 19:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbiIURQb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Sep 2022 13:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiIURQa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Sep 2022 13:16:30 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CEB79E2C0
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Sep 2022 10:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Haap+O/0CbOW0cJcob09rXVStRVDKElPgiNO41CTD6E=; b=aFbnDpXBd0CfJagXk4TRqupnIQ
        mm15mVNgKbYnBwwa6KtYYgFlUVrjgnlyFGXTfPSMl4foLgfBcibDZqV+Bn/sikkIjs4zm+CA1W5Lu
        lwffxe3ObOjxe+Zqd4+yI+vZkU8QIKDnV0DgLLqeN7Jqk1g4I1t/IoOyr8rhM1fo9Cn0rcRyrJwNz
        cQeLv1zRgl8TYfL0GkWIuS/ccT1D/PrZ7NEmVxFqHRXtv7Ta7XDZEjLGORc7puv8jYuQ0Uf3gvHkm
        J+OQfGljBr2x/o+o/tN19uoYrrertZP7DXGfcq+N2SMVA2zyqSqtU97XTRVFsnKyl/pjXwJBaQE2n
        OpZK1YGA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1ob3Kc-0028e9-1S;
        Wed, 21 Sep 2022 17:16:18 +0000
Date:   Wed, 21 Sep 2022 18:16:18 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Alexander Larsson <alexl@redhat.com>
Cc:     willy@infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] filemap: Fix error propagation in do_read_cache_page()
Message-ID: <YytG4sTn5OF44mXH@ZenIV>
References: <20220921091010.1309093-1-alexl@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220921091010.1309093-1-alexl@redhat.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 21, 2022 at 11:10:10AM +0200, Alexander Larsson wrote:
> When do_read_cache_folio() returns an error pointer the code
> was dereferencing it rather than forwarding the error via
> ERR_CAST().
> 
> Found during code review.
> 
> Fixes: 539a3322f208 ("filemap: Add read_cache_folio and read_mapping_folio")
> Signed-off-by: Alexander Larsson <alexl@redhat.com>
> ---
>  mm/filemap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 15800334147b..6bc55506f7a8 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -3560,7 +3560,7 @@ static struct page *do_read_cache_page(struct address_space *mapping,
>  
>  	folio = do_read_cache_folio(mapping, index, filler, file, gfp);
>  	if (IS_ERR(folio))
> -		return &folio->page;
> +		return ERR_CAST(folio);

Where do you see a dereference?  I agree that your variant is cleaner,
but &folio->page does *NOT* dereference anything - it's an equivalent of

	(struct page *)((unsigned long)folio + offsetof(struct folio, page))

and the reason it happens to work is that page is the first member in
struct folio, so the offsetof ends up being 0 and we are left with a cast
from struct folio * to struct page *, i.e. the same thing ERR_CAST()
variant end up with (it casts to void *, which is converted to struct
page * since return acts as assignment wrt type conversions).

It *is* brittle and misguiding, and your patch is a much more clear
way to spell that thing, no arguments about it; just that your patch
is not changing behaviour.
