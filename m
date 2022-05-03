Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 704B85186CF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 May 2022 16:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237119AbiECOjj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 May 2022 10:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237210AbiECOjO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 May 2022 10:39:14 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 544521FCE1
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 May 2022 07:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=N8Nulet2cuwDxTro4ujyyIhyKtNfAj5bP/cgh9cSaIE=; b=tkugZvROCAQO6RzohwFuyNo/sd
        0pcP3E4XQik9v08v/n2VmUjti/M7gRAsnjqwmQZ0PyxiT6qBFwj348BfbtC0jhE2rPOOlSKVpmB8E
        Q0T/77VX4vTjak0seUNBCiBlS0gPUFlVpG5LcxUsZT1CaR8IMofZmej9PYnficRcyufTic4ULkfEn
        Zz4uC0tBKe7ded25GhrNV8OoZRb9MbesehxQbWa1cqDLbqfc8MJNG3BneMHdcrwJeevxgwoNrPR3N
        9B/1qGduufBKVbE518wgKMf960EM2WwFg7VvnxcA+tV4+c9YX/g5iKLLYTRL88iYa40TwYzx1/5vQ
        4uxzFUQQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nltcr-006IOt-Um; Tue, 03 May 2022 14:35:41 +0000
Date:   Tue, 3 May 2022 07:35:41 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 01/69] scsicam: Fix use of page cache
Message-ID: <YnE9vaA14JqqbD1W@infradead.org>
References: <20220429172556.3011843-1-willy@infradead.org>
 <20220429172556.3011843-2-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220429172556.3011843-2-willy@infradead.org>
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

On Fri, Apr 29, 2022 at 06:24:48PM +0100, Matthew Wilcox (Oracle) wrote:
> Filesystems do not necessarily set PageError; instead they will leave
> PageUptodate clear on errors.  We should also kmap() the page before
> accessing it in case the page is allocated from HIGHMEM.

The PageError to PageUptodate change looks sane.  But block device
page cache absolutely must not be in highmem, so I don't see a point
in the kmap conversion here.
