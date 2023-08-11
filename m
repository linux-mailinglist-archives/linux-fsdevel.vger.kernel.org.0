Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BFE9779429
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Aug 2023 18:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233772AbjHKQRp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Aug 2023 12:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjHKQRp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Aug 2023 12:17:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C696A26A2;
        Fri, 11 Aug 2023 09:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=k5Qh2OYLkpSlQk66Lde25fAnzUb2YDmr8WqLmkA15S4=; b=NNc59xR7jloaxMIqFQREnNwxsa
        eWsoUI+sHYJo0/elWtab56XDom5Y1JwCgYDBpiuxP+xy9rEkEZsFZ9I9IMIoxDlME4C4b6zgz3bKU
        LKvVUksCTobRW4i52okiQHfOj4NI/UHmbFZ+2jkNeuTlJfxyROt5YwRtWdZ7UflJ1JP7ilo5m7JMB
        5A9IjfeEGNA4JuTzAt9nGQ3h5oLe3UAoYsRWu8m3HPDAUVyPAbtTtEmGFGxvQ0Q2Qdb7SXJuEXMGr
        hTzQLfCxh5Y2CnuPMkCMdR2ANFORAQWPzpK8D6H8fdjrxWCP4IWLefN1/PaKdpXNFgF+e5fjJ4GHL
        rqJiVDsQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qUUpa-0027sJ-AH; Fri, 11 Aug 2023 16:17:42 +0000
Date:   Fri, 11 Aug 2023 17:17:42 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     akpm@linux-foundation.org
Cc:     Hui Zhu <teawater@antgroup.com>, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH 3/3] ext4: Use bdev_getblk() to avoid memory reclaim in
 readahead path
Message-ID: <ZNZfJsSauzmSB8ya@casper.infradead.org>
References: <20230811161528.506437-1-willy@infradead.org>
 <20230811161528.506437-4-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811161528.506437-4-willy@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 11, 2023 at 05:15:28PM +0100, Matthew Wilcox (Oracle) wrote:
> +	struct buffer_head *bh = bdev_getblk(sb->s_bdev, block,
> +			sb->s_blocksize, GFP_NOWAIT);

Doh, I missed the __GFP_ACCOUNT from that.  Will wait a day or two
for other feedback.
