Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E26C64DACCD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Mar 2022 09:48:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354620AbiCPItZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Mar 2022 04:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237574AbiCPItX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Mar 2022 04:49:23 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86EF411179;
        Wed, 16 Mar 2022 01:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6DMI/g95lN3KbmsY69kplIZpPoE0mud1rZfU2MPf/tc=; b=UH0KEpb8QSE9A35VRN42fuERUy
        8kbb7/Z3cBbpaoZ4IColp2oHcWY2kt5pgv5XWcB8rDGLwIC4k88L/WRDDSBb4z76//vc6KzYojF6D
        OHOQxqnPGWt05sgU6ltNppDFjW84RW0+VCf2u7f399zYZgOuiN6Eh5r9AJ6f9tHprDcCP82DXZekj
        3iNA4sNTzOjVGJCHAszJ0KpN2a3voVsztFA+COqFNRi0EuMJjJIQRtxiJRqFBYfqjiQ1tHG46uk8t
        qN8STWcVSt7QD+VJbjWjOa/G3kx3+EedN+pq/rGSqlUNll5TxaubESknOV2qiN4+jvAYxkPbkGvzL
        jGJZVEAA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nUPK9-00CD6y-O4; Wed, 16 Mar 2022 08:48:05 +0000
Date:   Wed, 16 Mar 2022 01:48:05 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     cgel.zte@gmail.com
Cc:     axboe@kernel.dk, viro@zeniv.linux.org.uk, hannes@cmpxchg.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org,
        Yang Yang <yang.yang29@zte.com.cn>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>
Subject: Re: [PATCH] block/psi: make PSI annotations of submit_bio only work
 for file pages
Message-ID: <YjGkRT+ccoZ0ZNDq@infradead.org>
References: <20220316063927.2128383-1-yang.yang29@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220316063927.2128383-1-yang.yang29@zte.com.cn>
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

> @@ -1035,8 +1035,9 @@ void __bio_add_page(struct bio *bio, struct page *page,
>  	bio->bi_iter.bi_size += len;
>  	bio->bi_vcnt++;
>  
> -	if (!bio_flagged(bio, BIO_WORKINGSET) && unlikely(PageWorkingset(page)))
> -		bio_set_flag(bio, BIO_WORKINGSET);
> +	if (!bio_flagged(bio, BIO_WORKINGSET_FILE) &&
> +	    unlikely(PageWorkingset(page)) && !PageSwapBacked(page))
> +		bio_set_flag(bio, BIO_WORKINGSET_FILE);

This needs to go out of the block I/O fast path, not grow even more
checks.
