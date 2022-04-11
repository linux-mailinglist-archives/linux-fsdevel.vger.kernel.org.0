Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8D424FB45E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Apr 2022 09:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244040AbiDKHIh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Apr 2022 03:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244992AbiDKHIe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Apr 2022 03:08:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D322D33A1A;
        Mon, 11 Apr 2022 00:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=21mNC1xMcb143QvqEDow7m5pUs/f8C5BnuVHx811IUY=; b=OyrX/F9/CkEzV2AJPytb9wOZe/
        xVlVjM4Mv9OnTKyiF6cpVh+Lwn0P7HwhNa3rYDlLij84mntPBmNs9LvVI7aROjv7wQu6m79nP2LRi
        I9jTbJMDqly7aZfSfm7/ONz0mxcoBk3vPSbBZ0sdEQEmXpJTeodLum0KIib5NP53Lp+b6ljFbJPzX
        E18EpZvaJnzlFZwIvexozxCxHxwIIQ4ncxaopxsiiYs38YUzYCuMVa9SUmCWxzjK0yhdecVOv7zFM
        N7FcPgI4h26a1A3ZDKlLYdg6O0Cp67bEI/Jyc80MlsDU+Wi8R0fvARRVPQjbhDI4e/niO8gq0/08Z
        9jWhlbFw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ndo7t-0075f9-59; Mon, 11 Apr 2022 07:06:17 +0000
Date:   Mon, 11 Apr 2022 00:06:17 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, djwong@kernel.org,
        dan.j.williams@intel.com, david@fromorbit.com, hch@infradead.org,
        jane.chu@oracle.com
Subject: Re: [RFC PATCH] mm, pmem, xfs: Introduce MF_MEM_REMOVE for unbind
Message-ID: <YlPTaexutZrus1kQ@infradead.org>
References: <20220410171623.3788004-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220410171623.3788004-1-ruansy.fnst@fujitsu.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 11, 2022 at 01:16:23AM +0800, Shiyang Ruan wrote:
> diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
> index bd502957cfdf..72d9e69aea98 100644
> --- a/drivers/nvdimm/pmem.c
> +++ b/drivers/nvdimm/pmem.c
> @@ -359,7 +359,6 @@ static void pmem_release_disk(void *__pmem)
>  	struct pmem_device *pmem = __pmem;
>  
>  	dax_remove_host(pmem->disk);
> -	kill_dax(pmem->dax_dev);
>  	put_dax(pmem->dax_dev);
>  	del_gendisk(pmem->disk);
>  
> @@ -597,6 +596,8 @@ static void nd_pmem_remove(struct device *dev)
>  		pmem->bb_state = NULL;
>  	}
>  	nvdimm_flush(to_nd_region(dev->parent), NULL);
> +
> +	kill_dax(pmem->dax_dev);

I think the put_dax will have to move as well.

This part should probably also be a separate, well-documented
cleanup patch.
