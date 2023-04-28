Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD666F188E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Apr 2023 14:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjD1M6W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Apr 2023 08:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjD1M6U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Apr 2023 08:58:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA9EF1BC6
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Apr 2023 05:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=doUPR4jiBjU2axrzOq1H1BL7/MBEaMu//BnwIvYAJME=; b=vf/e1aJK6INHxe6xyWbASfVrkY
        KjhAzaKwaiYzeNrbhpsO/847m0fo1dJCfReOgIkPKLU5B9n8TBS6kRcq9X3+qR0pEIXEGoHh3HRAz
        VNB5RflGruEzQkZ6UKFIqh5aZ8/V2VwS5s7i07Mee9egv3xFhuEMr1x47clsvC/0gjYrjwG9rsSQ/
        IridzaWz/vXi7Ovwbwx/uATQWpb/Lga50y0FIbb/8phOyOS7LDTCPM9HSTGrRIOitdiHAXLSlGvf7
        0qYLT14FiMLl/D8phuNtpvMSu9nk9lfq/9oAylnBEq7zOBBgflKh6g11IosPNf2GIse86PB3QPahg
        AkR74AlQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1psNfv-004bd4-9C; Fri, 28 Apr 2023 12:58:11 +0000
Date:   Fri, 28 Apr 2023 13:58:11 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH] mm: Do not reclaim private data from pinned page
Message-ID: <ZEvC4/zO48AWT8co@casper.infradead.org>
References: <20230428124140.30166-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230428124140.30166-1-jack@suse.cz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 28, 2023 at 02:41:40PM +0200, Jan Kara wrote:
> If the page is pinned, there's no point in trying to reclaim it.
> Furthermore if the page is from the page cache we don't want to reclaim
> fs-private data from the page because the pinning process may be writing
> to the page at any time and reclaiming fs private info on a dirty page
> can upset the filesystem (see link below).
> 
> Link: https://lore.kernel.org/linux-mm/20180103100430.GE4911@quack2.suse.cz
> Signed-off-by: Jan Kara <jack@suse.cz>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
