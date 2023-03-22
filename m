Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D491B6C4D61
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Mar 2023 15:20:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbjCVOUI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Mar 2023 10:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231522AbjCVOTa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Mar 2023 10:19:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A7FA64B19;
        Wed, 22 Mar 2023 07:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3I8+EPoj9s30M6BN+/MyaicBmCloUwGfehVdB0NlrWY=; b=ZJGeiZApYD0ixCPvU2hO6qnVJ4
        6hWhoXL2A5VSGpA/HCIUwp17RyNbGB6HwspMKQJPNDDh20N6hrOT4ozwKMOIDvzXcfPIOJMsyrkjM
        Wt3MkZhdFVmqHdJ1lWxT4eXdCx110KJnbOyzl/iPxY+bn6XLfmHsjea6m1l7KLD8f7dY4YSKeAek+
        umzj/t7YDT4ethQO/0993oVhI/sJvKfiV78LOHHrY6cakTRl21XfDTdT4E8DXsRynHOO+boyXDbX4
        Mw0WKEvPgsFeoFkI87C2PhNCXHmae9LHyCnHR6r3HoUft2dxDNv/BZgb6iE5h3T4igDN8xhR2ML9O
        rV2aBaYQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pezIz-0034XG-FS; Wed, 22 Mar 2023 14:19:09 +0000
Date:   Wed, 22 Mar 2023 14:19:09 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Pankaj Raghav <p.raghav@samsung.com>
Cc:     senozhatsky@chromium.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
        brauner@kernel.org, akpm@linux-foundation.org, minchan@kernel.org,
        hubcap@omnibond.com, martin@omnibond.com, mcgrof@kernel.org,
        devel@lists.orangefs.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, gost.dev@samsung.com
Subject: Re: [RFC v2 4/5] mpage: use folios in bio end_io handler
Message-ID: <ZBsOXWk6sKISbbfl@casper.infradead.org>
References: <20230322135013.197076-1-p.raghav@samsung.com>
 <CGME20230322135017eucas1p2d29ffaf8dbbd79761ba56e8198d9c933@eucas1p2.samsung.com>
 <20230322135013.197076-5-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230322135013.197076-5-p.raghav@samsung.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 22, 2023 at 02:50:12PM +0100, Pankaj Raghav wrote:
>  static void mpage_write_end_io(struct bio *bio)
>  {
> -	struct bio_vec *bv;
> -	struct bvec_iter_all iter_all;
> +	struct folio_iter fi;
> +	int err = blk_status_to_errno(bio->bi_status);
>  
> -	bio_for_each_segment_all(bv, bio, iter_all) {
> -		struct page *page = bv->bv_page;
> -		page_endio(page, REQ_OP_WRITE,
> -			   blk_status_to_errno(bio->bi_status));
> +	bio_for_each_folio_all(fi, bio) {
> +		struct folio *folio = fi.folio;
> +
> +		if (err) {
> +			struct address_space *mapping;
> +
> +			folio_set_error(folio);
> +			mapping = folio_mapping(folio);
> +			if (mapping)
> +				mapping_set_error(mapping, err);

The folio is known to belong to this mapping and can't be truncated
while under writeback.  So it's safe to do:

			folio_set_error(folio);
			mapping_set_error(folio->mapping, err);

I'm not even sure I'd bother to pull folio out of the fi.

	bio_for_each_folio_all(fi, bio) {
		if (err) {
			folio_set_error(fi.folio);
			mapping_set_error(fi.folio->mapping, err);
		}
		folio_end_writeback(fi.folio);
	}

