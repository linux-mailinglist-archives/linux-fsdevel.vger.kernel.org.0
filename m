Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1865373F364
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 06:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjF0EaY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 00:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbjF0EaL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 00:30:11 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 651EC97;
        Mon, 26 Jun 2023 21:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+r8p/v5s7wbLIPfSeJmQ/Jnc8OoL0+y1yUUWCSbGtuo=; b=mC8i7Dn84t1nQu2SXZOo0VXBPi
        6GNIEqUOKZCP4LQWlB/pldb33gsvunRvnV6Ukm9rE4T4N7kH00nBcG53PLhHmcWdplIzyAUkSunGW
        Ovhky/bUBuI0LV5kB4QKOOFCWm2IYpOwskAcyfGSoCRwi/InTaYQQoi78xUahRsiX/QTLbhBkDWRD
        +iFriABvNMURanj7kUTHF7+7OCKBK45EgNAwvYnUW8S7X/O7huGFuwDjQHHw1X/QuSkqyX7FGRn3G
        CjI8LYX/W/t+F0d3qEELi/fOl9CMfnIb/32IbsqyZbxNI/KNTLFhaT/kqA+1S6EUmutxvxhHNZbLj
        5FgZJSrQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qE0L9-00Bh4b-08;
        Tue, 27 Jun 2023 04:30:07 +0000
Date:   Mon, 26 Jun 2023 21:30:07 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.com>,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 07/12] writeback: Factor writeback_iter_init() out of
 write_cache_pages()
Message-ID: <ZJplzwnPBHo4ZK60@infradead.org>
References: <20230626173521.459345-1-willy@infradead.org>
 <20230626173521.459345-8-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230626173521.459345-8-willy@infradead.org>
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

On Mon, Jun 26, 2023 at 06:35:16PM +0100, Matthew Wilcox (Oracle) wrote:
> +	for (folio = writeback_iter_init(mapping, wbc);
> +	     folio;
> +	     folio = writeback_get_next(mapping, wbc)) {

Ok that's another way to structure it.  Guess I should look over the
whole series first..

