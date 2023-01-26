Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 093E967CF8F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jan 2023 16:15:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231989AbjAZPP2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Jan 2023 10:15:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232012AbjAZPPZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Jan 2023 10:15:25 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0284161856
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Jan 2023 07:15:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SVSoOmOkAv0qYrFF5AaQQ5wZnGROZeVJYi9nhjejcH4=; b=bvHTLd2/MBh8CJm4f1Qad67IVU
        OltafoB+leWzqyRzks/wdnTbu7bAlostQoGgb7q/L8qik4zWHdv67wemCAp0+vIhTsE7Rz6t+Rfs0
        hfxKvPqdGmAeb0C6LWkysLAU2wIdIrXhZcEQx/g1wD0xWQbQbPWWrj8EZRsbpyh7TtK75HCx9B5jt
        DLmI8mIZ2xZK/UH39Pmmw1h9ndjFvQAeI4YhVlmBoAOdyZPxuMZTnszD8nny8/GivhF5gVkCerdA3
        xJgMXqMcwqDt6RUfLIzOLA5MHPL4nmVp3nkI/DatRKLQ3IoEhpaiMnPF7j7w7UnVXkOtpOYIEHTzB
        2MHjBnzg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pL3yC-00BRUY-NH; Thu, 26 Jan 2023 15:15:20 +0000
Date:   Thu, 26 Jan 2023 07:15:20 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] fs: gracefully handle ->get_block not mapping bh in
 __mpage_writepage
Message-ID: <Y9KZCML4zoguJJ5v@infradead.org>
References: <20230126085155.26395-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126085155.26395-1-jack@suse.cz>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 26, 2023 at 09:51:55AM +0100, Jan Kara wrote:
> When filesystem's ->get_block function does not map the buffer head when
> called from __mpage_writepage(), the function will happily go and pass
> bogus bdev and block number to bio allocation routines which leads to
> crashes sooner or later. E.g. UDF can do this because it doesn't want to
> allocate blocks from ->writepages callbacks. It allocates blocks on
> write or page fault but writeback can still spot dirty buffers without
> underlying blocks allocated e.g. if blocksize < pagesize, the tail page
> is dirtied (which means all its buffers are dirtied), and truncate
> extends the file so that some buffer starts to be within i_size.

Yes, this matches what the buffer.c helpers do, so:

Reviewed-by: Christoph Hellwig <hch@lst.de>
