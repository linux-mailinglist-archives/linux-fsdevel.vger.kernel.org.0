Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCF5F72FF28
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jun 2023 14:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234541AbjFNMzk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jun 2023 08:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236378AbjFNMzj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jun 2023 08:55:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E16291BD4;
        Wed, 14 Jun 2023 05:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BMaPAYhQ0oHtmG4Cgc94dDi2EYz+dcUDeD41ey8/MQE=; b=RD29uM16q/P7/G4/9L8l/WJgYC
        ENyt7RbYLiIcrkzDeGcCI0PBVudqcumFbCe4Tzoi+qzIWI6VrIC7h5vAD0GRQ1ENTvq2SV2iXNw6s
        IwmuK8wu7nLsMFDutkWWqVMHteE7JfpiJMwwxlH0tER+ierTk33zYbSVXyFs9GTEi71r0uxiC18IG
        mG5WsCWkhk4wqUQMpxEl49oKgwpI6omghQTyvaS8dh2EomJZBa4Rtj8cMdzWSTsaIvge/0VFfcDGS
        HxWYDo8vOJU29Be/5LIKilWQ1XIxRcea63/z+uyinNPwNZ1qUMtEMzgk6YA8rLxUm/JZQxTu4xJZd
        m36pCE0w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q9Q27-006Jlg-Pq; Wed, 14 Jun 2023 12:55:31 +0000
Date:   Wed, 14 Jun 2023 13:55:31 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Hannes Reinecke <hare@suse.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH 4/7] brd: make sector size configurable
Message-ID: <ZIm4wyHZK/YMV2gj@casper.infradead.org>
References: <20230614114637.89759-1-hare@suse.de>
 <20230614114637.89759-5-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230614114637.89759-5-hare@suse.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 14, 2023 at 01:46:34PM +0200, Hannes Reinecke wrote:
> @@ -43,9 +43,11 @@ struct brd_device {
>  	 */
>  	struct xarray	        brd_folios;
>  	u64			brd_nr_folios;
> +	unsigned int		brd_sector_shift;
> +	unsigned int		brd_sector_size;
>  };
>  
> -#define BRD_SECTOR_SHIFT(b) (PAGE_SHIFT - SECTOR_SHIFT)
> +#define BRD_SECTOR_SHIFT(b) ((b)->brd_sector_shift - SECTOR_SHIFT)
>  
>  static pgoff_t brd_sector_index(struct brd_device *brd, sector_t sector)
>  {
> @@ -85,7 +87,7 @@ static int brd_insert_folio(struct brd_device *brd, sector_t sector, gfp_t gfp)
>  {
>  	pgoff_t idx;
>  	struct folio *folio, *cur;
> -	unsigned int rd_sector_order = get_order(PAGE_SIZE);
> +	unsigned int rd_sector_order = get_order(brd->brd_sector_size);

Surely max(0, brd->brd_sector_shift - PAGE_SHIFT) ?

> @@ -346,6 +353,25 @@ static int brd_alloc(int i)
>  		return -ENOMEM;
>  	brd->brd_number		= i;
>  	list_add_tail(&brd->brd_list, &brd_devices);
> +	brd->brd_sector_shift = ilog2(rd_blksize);
> +	if ((1ULL << brd->brd_sector_shift) != rd_blksize) {
> +		pr_err("rd_blksize %d is not supported\n", rd_blksize);

Are you trying to require power-of-two here?  We have is_power_of_2()
for that purpose.

