Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12A487735C2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Aug 2023 03:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbjHHBME (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Aug 2023 21:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjHHBME (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Aug 2023 21:12:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE7919A2
        for <linux-fsdevel@vger.kernel.org>; Mon,  7 Aug 2023 18:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4hQm2gdZ65LTLHU7bja/ZjRmOL3/czAMitrNkR36dXs=; b=bdRUssl/s1IKjgXr91BgOuDN8r
        lKsJZUefso15U/IZD+LqcVJNG2H7WJ5bJBssROPxKJP7zrriBk+IKqO/Mx2a3ZgEk/VKdetJIxZiW
        02hW09VOqzq07pu3jsMH36r6tOgBoL5d91ZTEh2BqxLWCCqFYXzFUh8vzrDngd5kWPCOGPDHtiJSH
        IINJRmwMhLkpLZBohIXVE2NExPU9mQniTnYITxdAgeHFhrDOZDFjK+xdXPqeDWsp+QoUJ/9GCzpqA
        0HmvnR8mvEaA/xa8zFk5rBRmPjJ0sdtOju92VqGA3UHY/h2t1vjBRG12d4Ech7jxzRNDsZmIiGGAW
        5mEbeEaQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qTBGC-00EV9R-7X; Tue, 08 Aug 2023 01:11:44 +0000
Date:   Tue, 8 Aug 2023 02:11:44 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tomas Mudrunka <tomas.mudrunka@gmail.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] mm: memtest: convert to memtest_report_meminfo()
Message-ID: <ZNGWUHj2gA62ksA8@casper.infradead.org>
References: <20230808012156.88924-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230808012156.88924-1-wangkefeng.wang@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 08, 2023 at 09:21:56AM +0800, Kefeng Wang wrote:
> @@ -117,3 +118,17 @@ void __init early_memtest(phys_addr_t start, phys_addr_t end)
>  		do_one_pass(patterns[idx], start, end);
>  	}
>  }
> +
> +void memtest_report_meminfo(struct seq_file *m)
> +{
> +	unsigned long early_memtest_bad_size_kb;
> +
> +	if (!early_memtest_done)
> +		return;
> +
> +	early_memtest_bad_size_kb = early_memtest_bad_size >> 10;
> +	if (early_memtest_bad_size && !early_memtest_bad_size_kb)
> +		early_memtest_bad_size_kb = 1;
> +	/* When 0 is reported, it means there actually was a successful test */
> +	seq_printf(m, "EarlyMemtestBad:   %5lu kB\n", early_memtest_bad_size_kb);
> +}

Doesn't this function need to be under CONFIG_PROC_FS ?
