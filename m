Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C92A5186FB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 May 2022 16:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237226AbiECOo6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 May 2022 10:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237177AbiECOo5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 May 2022 10:44:57 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD69F30564
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 May 2022 07:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jUcHIBF95QyHHUNgHr5HcMs8YZVe3mLhLpQyAkM7Fmw=; b=ktfNw6Nnz9TXxAtkkEjAV63zOL
        /j7Ata1LvvHsxODMPBWfUj19mKGU62rLI0wMKbZVc/UwqWGjoFZZ1uGjZn0wbuyQlkahlviwuC623
        odl5BSIsP8SOE1jOHzWvQnS5c6eEdTjWjobFS3Lb+D8GMtC07xWsTf5/k/eyY7Frlrb60M166ehc0
        PkaRCed4OJ/nGgDzGMLrYJRU7WH0fjLrbO540peG2aA7Rvb1JEOep3nvbRntX+O/pg58Ej2gIMt1I
        e/3gbrNmLfz2L7hYFAtWw2g6EFOGvOZHlplrRcCUmzP3js4QGQ/a7EcUdq7MCtK5gIjhaIe0Zcn+a
        Rn6ACfGA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nltiO-006JCG-FA; Tue, 03 May 2022 14:41:24 +0000
Date:   Tue, 3 May 2022 07:41:24 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 32/69] buffer: Rewrite nobh_truncate_page() to use folios
Message-ID: <YnE/FOz5fHKAg2zS@infradead.org>
References: <20220429172556.3011843-1-willy@infradead.org>
 <20220429172556.3011843-33-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220429172556.3011843-33-willy@infradead.org>
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

The changes looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

But I wonder if we shouldn't really just drop these nobh helpers
entirely.  They were added to save lowmem on highmem systems with a lot
of highmem, but I really don't think we should continue optimizaing for
that.

