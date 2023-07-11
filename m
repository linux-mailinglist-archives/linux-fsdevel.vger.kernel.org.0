Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8796374E27E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jul 2023 02:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbjGKAVH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jul 2023 20:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjGKAVG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jul 2023 20:21:06 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A93FB;
        Mon, 10 Jul 2023 17:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oKMPRltSL5oJpUkPhsbe0HpEgmOXSJnh20eXBSK1NtM=; b=nbOwz4hsHGCYaZlXREiRr3naZ3
        ws80+poluFsMrrCOFw53Ad9v9f9lnkpPyB//bLAIsGzOQg3Pqqee0Yc+BRwIMQC8XoZ5aRlVah5DL
        3/IL2CyqAeW6rm5H9OqYs0cWdsMIeT1ZZfI0hbVzOk6p8oXT6BbT2lsInL6VGoEBWuWEqVMm0dCj3
        hF15UelGGR9KDoyj+CwwUBZQ0JZtxA0EweNejiTsqTDw5iK7Bs/5p3XsRM9rwkAMMDxqQ1P+yCAim
        WCQhzn5ficA1Z2nSobjFJdSIgRG+5ksTdq8Za5ZNiHgqjk/61fQbzDoVh0QuQZPRN9gPd3jcS1XwZ
        pCn8KTNg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qJ17o-00D39j-12;
        Tue, 11 Jul 2023 00:21:04 +0000
Date:   Mon, 10 Jul 2023 17:21:04 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Wang Yugui <wangyugui@e16-tech.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v4 7/9] filemap: Allow __filemap_get_folio to allocate
 large folios
Message-ID: <ZKygcP5efM2AE/nr@bombadil.infradead.org>
References: <20230710130253.3484695-1-willy@infradead.org>
 <20230710130253.3484695-8-willy@infradead.org>
 <ZKybP22DRs1w4G3a@bombadil.infradead.org>
 <ZKydSZM70Fd2LW/q@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZKydSZM70Fd2LW/q@casper.infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 11, 2023 at 01:07:37AM +0100, Matthew Wilcox wrote:
> The caller hints at the
> folio size it wants, and this code you're highlighting limits it to be
> less than MAX_PAGECACHE_ORDER.

Yes sorry, if the write size is large we still max out at MAX_PAGECACHE_ORDER
naturally. I don't doubt the rationale that that is a good idea.

What I'm curious about is why are we OK to jump straight to MAX_PAGECACHE_ORDER
from the start and if there are situations where perhaps a a
not-so-aggressive high order may be desriable. How do we know?

  Luis
