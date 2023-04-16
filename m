Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34E466E34D9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Apr 2023 06:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbjDPEBC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 16 Apr 2023 00:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjDPEBB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 16 Apr 2023 00:01:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 337962115;
        Sat, 15 Apr 2023 21:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cuwzBT/PH/2bD1KMYhwjwolg7uBkqqaygg8jxUvIEW8=; b=E6g9+pTcKZmVQ4Gzvsex6qFn3l
        USkynvSgj/YkrT20LuIhB7WgIbmBQ+2Pk7KFEa6Bp0MwAz3MqpxzACxEbcFJLHE8zFs6V8X4R3Nf7
        PFSupthNLfuVbDVMaYpInelAXUOBt7q9TwpWSr176vhMYH0FZFbyitG1MEcJX8aVsf4cqE+NWokwG
        m6cuCyH27ivTxu0uxANfuaUBG4flqVVENs3QkqI8tCI4WddGVHu0kNm2oIgqVadr8qnnvrPOGqHnB
        Hsayg4kLgEHoaOkb9BVVbS35yY/edw22seHGvlX79WFVn9Rqr7k/X2qzahpC3QKZWg2voX1n16pjL
        8D+SXfaA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pntZQ-00A6OJ-GD; Sun, 16 Apr 2023 04:00:56 +0000
Date:   Sun, 16 Apr 2023 05:00:56 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Pankaj Raghav <p.raghav@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mcgrof@kernel.org
Subject: Re: [PATCH] mm/filemap: allocate folios according to the blocksize
Message-ID: <ZDty+PQfHkrGBojn@casper.infradead.org>
References: <20230414134908.103932-1-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230414134908.103932-1-hare@suse.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 14, 2023 at 03:49:08PM +0200, Hannes Reinecke wrote:
> @@ -3607,14 +3611,16 @@ static struct folio *do_read_cache_folio(struct address_space *mapping,
>  		pgoff_t index, filler_t filler, struct file *file, gfp_t gfp)
>  {
>  	struct folio *folio;
> -	int err;
> +	int err, order = 0;
>  
> +	if (mapping->host->i_blkbits > PAGE_SHIFT)
> +		order = mapping->host->i_blkbits - PAGE_SHIFT;

This pattern comes up a few times.  What I did in a patch I wrote back
in December 2020 and never submitted (!) was this:


@@ -198,9 +198,15 @@ enum mapping_flags {
        AS_EXITING      = 4,    /* final truncate in progress */
        /* writeback related tags are not used */
        AS_NO_WRITEBACK_TAGS = 5,
-       AS_LARGE_FOLIO_SUPPORT = 6,
+       AS_FOLIO_ORDER_MIN = 8,
+       AS_FOLIO_ORDER_MAX = 13,
+       /* 8-17 are used for FOLIO_ORDER */
 };

+#define AS_FOLIO_ORDER_MIN_MASK        0x00001f00
+#define AS_FOLIO_ORDER_MAX_MASK 0x0002e000
+#define AS_FOLIO_ORDER_MASK (AS_FOLIO_ORDER_MIN_MASK | AS_FOLIO_ORDER_MAX_MASK)

...

+static inline unsigned mapping_min_folio_order(struct address_space *mapping)
+{
+	return (mapping->flags & AS_FOLIO_ORDER_MIN_MASK) >> AS_FOLIO_ORDER_MIN;
+}

(do we really need 5 bits for each, or can we get by with eg 3 or 4 bits?)

Anyway, the point is that we could set this quite early in the creation
of the mapping, and eliminate the conditional setting of order.
