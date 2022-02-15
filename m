Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC294B6426
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Feb 2022 08:19:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232766AbiBOHTc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Feb 2022 02:19:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbiBOHTc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Feb 2022 02:19:32 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B79EBDE4
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Feb 2022 23:19:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vsvPeaqbWAUL4QGK7CM5RVivmBescAdGUwdMQ3Q2U6c=; b=TS0uS0b1yENg5Dbq7pS942lnrK
        bpjQjMtVZZEuPtj06ePwsMUTIp6BDXhIevsW+5wrjw/ANDGKtitW99nQYE5OHzhMB1zKjwvo9TjEJ
        RmAb6S5a5rrBZxZdQw8aRXhXvGrYQTCB1N9u4NhNDZs5otcfFQe+RHT36ANT43QOwiYBHQJ9J6XKN
        kGPQnfXFNm+RFBIcArnXxQVSLlJ/TsHM8h1unfKnwgBjVzoTxLK2WEOoD67+Sii4oaLTQz0q0KAKR
        LRVHfIpeqmSglPGqkAbrdRnpcXsdTQ9J0ReQVYVmAzkE4vQyVO7zXlJarA8R9ZlQLvv+9wOcvAjH0
        HUzWKZNA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nJs7P-0017MR-0p; Tue, 15 Feb 2022 07:19:23 +0000
Date:   Mon, 14 Feb 2022 23:19:22 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 04/10] mm/truncate: Replace page_mapped() call in
 invalidate_inode_page()
Message-ID: <YgtT+hpds6ViIeEE@infradead.org>
References: <20220214200017.3150590-1-willy@infradead.org>
 <20220214200017.3150590-5-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220214200017.3150590-5-willy@infradead.org>
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

On Mon, Feb 14, 2022 at 08:00:11PM +0000, Matthew Wilcox (Oracle) wrote:
> folio_mapped() is expensive because it has to check each page's mapcount
> field.  A cheaper check is whether there are any extra references to
> the page, other than the one we own and the ones held by the page cache.
> The call to remove_mapping() will fail in any case if it cannot freeze
> the refcount, but failing here avoids cycling the i_pages spinlock.

I wonder if something like this should also be in a comment near
the check in the code.
