Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF0CB67D8F1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jan 2023 23:59:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233191AbjAZW7s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Jan 2023 17:59:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbjAZW7r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Jan 2023 17:59:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58016552BB
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Jan 2023 14:59:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0A19BB81F42
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Jan 2023 22:59:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 963CFC433D2;
        Thu, 26 Jan 2023 22:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1674773983;
        bh=42eO7WF7X2qZyvDDgC5i2e07FCwsOErXAENkqUpi05I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OdcGjNzEs8yKW4vzBruzNVss6i+MPR28YarJ5KQjzOxGRcwgm0dEyg1mA5dam+9VV
         IbrtyKMqDXZQZXg4ScK2RFGZjC4Kvc8yG4HDR3MlkT57WIagMPp0L41sHHIxkjgvKU
         HT3p3sOvK/gWaa41TRs41l2ufvWEAUR9S3OL7JGQ=
Date:   Thu, 26 Jan 2023 14:59:42 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 2/2] mpage: Convert __mpage_writepage() to use a folio
 more fully
Message-Id: <20230126145942.de051666a47ada8f56cb34a4@linux-foundation.org>
In-Reply-To: <20230126201255.1681189-3-willy@infradead.org>
References: <20230126201255.1681189-1-willy@infradead.org>
        <20230126201255.1681189-3-willy@infradead.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 26 Jan 2023 20:12:55 +0000 "Matthew Wilcox (Oracle)" <willy@infradead.org> wrote:

> This is just a conversion to the folio API.  While there are some nods
> towards supporting multi-page folios in here, the blocks array is
> still sized for one page's worth of blocks, and there are other
> assumptions such as the blocks_per_page variable.
> 
> ...
>
> @@ -588,7 +585,7 @@ static int __mpage_writepage(struct folio *folio, struct writeback_control *wbc,
>  	if (bio == NULL) {
>  		if (first_unmapped == blocks_per_page) {
>  			if (!bdev_write_page(bdev, blocks[0] << (blkbits - 9),
> -								page, wbc))
> +						&folio->page, wbc))
>  				goto out;
>  		}
>  		bio = bio_alloc(bdev, BIO_MAX_VECS,
>

hch removed this code in
https://lkml.kernel.org/r/20230125133436.447864-2-hch@lst.de, so I'll
drop this hunk.

