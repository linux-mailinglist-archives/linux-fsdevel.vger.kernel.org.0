Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84CBB73F326
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 06:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbjF0EFX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 00:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjF0EFV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 00:05:21 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C851DE59;
        Mon, 26 Jun 2023 21:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RsyF4h6uoThSvw3Iku4RrSPBs0D/JAtSb0sn0qxxh20=; b=Zb4bAeY+ZUGIlTx6WZmKQEwcds
        pkXLg56Ft7TV3uU3ZBjuckl/fvKej5gLQkonpvu37uVL3mtmYulH9uNbOBPHu8YPDi5U+g2S+osAN
        7Lb8NdhZwhFZc1gA9uEBqWbraiK9LVwW+C0lDbkigoi9ZMcH1ow/wmaXGBhm3JgC3LRszv00fK+82
        b4pwUH5W74zAX9Snl/D/7HWNtjPJW9sN9kkWwsumzjyd5iVYRi4GmH1IEJ/iXreNjgB06usomOOiS
        VSc9rDRIdBmEW6DN0ouQWqIJ2Y+dR22mdHVixj5DqY5/cmZwtVTtWy/pgrIkNihtrF7XMC8K2MBPo
        kk/ojpKg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qDzx8-00BeBk-2A;
        Tue, 27 Jun 2023 04:05:18 +0000
Date:   Mon, 26 Jun 2023 21:05:18 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.com>,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 01/12] writeback: Factor out writeback_finish()
Message-ID: <ZJpf/gh8rUN82ARF@infradead.org>
References: <20230626173521.459345-1-willy@infradead.org>
 <20230626173521.459345-2-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230626173521.459345-2-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 26, 2023 at 06:35:10PM +0100, Matthew Wilcox (Oracle) wrote:
> +	struct folio_batch fbatch;
> +	pgoff_t done_index;
> +	int err;
> +

I think this really needs a comment that it should only be used for
the writeback iterator.  In fact this whole structure could use a lot
more comments on what should / can be set by the caller, and what is
internal.

> +	unsigned range_whole:1;		/* entire file */

Same here.

