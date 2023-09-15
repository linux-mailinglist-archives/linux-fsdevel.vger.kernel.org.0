Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B12EB7A2290
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Sep 2023 17:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236153AbjIOPht (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Sep 2023 11:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236149AbjIOPh0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Sep 2023 11:37:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F41E6A;
        Fri, 15 Sep 2023 08:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=weIH6q/GO+uKb6SAS3pj9bawpU6jDya1ZswVdnm0Tks=; b=FNQLLzaj1CwiOfRn1Lldn35Jzd
        DT1YcE7xPmC0F7GEMiORREJofQ5NNNTGAQI7J+AqKLze307fPYBF4pD21N1aXmQBzerFdswgRnS1P
        vQEC9UpHQ30gq48dA2CCNeO4beU8Ov7SPJerssNhILXF8Bz7B2jghZCzL/bnD2HQLRNipXg6cyqQh
        NDdoodU50PsoE+QaJ4cT4Tsj5+F7RrpFH+DKCBEUQwoOVUzRBLZfsRXYmx0tEwn+9EpC8BRJsoDSe
        8QuvQvtLKPbEMGNxJ/xCcqM7EHZ/S6uyUme27VK0mA5QF5i7f5rq9PyQBBo5mrrt00e/kjrfWefhO
        Iu6wRUNg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qhAsc-00AX14-Cv; Fri, 15 Sep 2023 15:37:14 +0000
Date:   Fri, 15 Sep 2023 16:37:14 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Daniel Gomez <da.gomez@samsung.com>
Cc:     "minchan@kernel.org" <minchan@kernel.org>,
        "senozhatsky@chromium.org" <senozhatsky@chromium.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "hughd@google.com" <hughd@google.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "gost.dev@samsung.com" <gost.dev@samsung.com>,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH 5/6] shmem: add file length in shmem_get_folio path
Message-ID: <ZQR6KihECXtwVtrF@casper.infradead.org>
References: <20230915095042.1320180-1-da.gomez@samsung.com>
 <CGME20230915095131eucas1p1010e364cd1c351e5b7379954bd237a3d@eucas1p1.samsung.com>
 <20230915095042.1320180-6-da.gomez@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230915095042.1320180-6-da.gomez@samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 15, 2023 at 09:51:29AM +0000, Daniel Gomez wrote:
> @@ -2251,7 +2252,7 @@ static vm_fault_t shmem_fault(struct vm_fault *vmf)
>  	}
>  
>  	err = shmem_get_folio_gfp(inode, vmf->pgoff, &folio, SGP_CACHE,
> -				  gfp, vma, vmf, &ret);
> +				  gfp, vma, vmf, &ret, i_size_read(inode));

Surely this should be PAGE_SIZE not i_size?

> @@ -4923,7 +4927,7 @@ struct folio *shmem_read_folio_gfp(struct address_space *mapping,
>  
>  	BUG_ON(!shmem_mapping(mapping));
>  	error = shmem_get_folio_gfp(inode, index, &folio, SGP_CACHE,
> -				  gfp, NULL, NULL, NULL);
> +				  gfp, NULL, NULL, NULL, i_size_read(inode));

Same here?
