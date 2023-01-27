Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E65867F242
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Jan 2023 00:34:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231862AbjA0XeD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Jan 2023 18:34:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjA0XeC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Jan 2023 18:34:02 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D786A84975;
        Fri, 27 Jan 2023 15:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ko3fCTrnJ7desFFruqwKyt1k71qg/3QydB5d/88N3Oc=; b=glbJD4FR5aw9colVN5LAxh+JwM
        7Tzz8T+L/UmgRrF0BPS+7bDh3pt+3ADbYBNuRXOdsVvmzVl7HRsDbp4Qup/XhwMCaaLlmiUzm2VF6
        H6D7GFaohuuYK+hGyn2akv1EU+BSkhEyYNsKTWT7VH/Ch9VSfOL/56Xn9nt37cU7I4UZACqYHkgyy
        KbL4OknX19A/vR0kUh4+bx9oy28yKvGQw3aVG9YsDBCO2o/pHFeyXGrnbdSgywIqayvN5mqqgayVR
        JRunu7VAMsolDYy1vI0d/1XpqCkCZUBHFa1TN+DhBHk/Jpp0mf5nKf9yRCWNIyu1xAIlAJJJL1OgN
        Z32uts7A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pLYEH-0088ox-5q; Fri, 27 Jan 2023 23:33:57 +0000
Date:   Fri, 27 Jan 2023 23:33:57 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH] fscrypt: support decrypting data from large folios
Message-ID: <Y9RfZaGoQ07UkD6w@casper.infradead.org>
References: <20230127224202.355629-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230127224202.355629-1-ebiggers@kernel.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 27, 2023 at 02:42:02PM -0800, Eric Biggers wrote:
> +++ b/fs/buffer.c
> @@ -307,8 +307,8 @@ static void decrypt_bh(struct work_struct *work)
>  	struct buffer_head *bh = ctx->bh;
>  	int err;
>  
> -	err = fscrypt_decrypt_pagecache_blocks(bh->b_page, bh->b_size,
> -					       bh_offset(bh));
> +	err = fscrypt_decrypt_pagecache_blocks(page_folio(bh->b_page),
> +					       bh->b_size, bh_offset(bh));

FYI, Andrew's been carrying "buffer: add b_folio as an alias of b_page"
in his tree since mid-December.  buffer_heads always point to the
head page, aka folio.

This all looks good to me.

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
