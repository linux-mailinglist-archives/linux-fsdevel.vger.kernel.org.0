Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84952536B09
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 May 2022 08:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbiE1GFX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 28 May 2022 02:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233232AbiE1GFV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 28 May 2022 02:05:21 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31561E89
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 May 2022 23:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mBmi5eB1To9ahf6hTQu5xbkhEk5AHfBerDC3nc8GKvk=; b=biOBFMsQpRg/3JY+TpmOD/uvYJ
        AuLYgUtY4dVllYfmRcw1vzVVdrYKYG+y9IaxH7PWsstt+6p41YQcPQNrNKSqOTno3WnQFwzA1FDN8
        ituobb/uQPRNjYTxYnsn+KqokcQE4+TR4uqAN24AGxpOQX+Vywy/sVZhmNApa50R11UBCMVtD0Ee0
        5zvXhNnVAyVvrbOZPo6KoIZE7kfSOlzWQ8EE9LAuRxzlIpbtfD2oxWJVJdm1au43wOT3qJqxSG8vr
        +k59ju8keLPifXYkSZouLIKAaEzTsyMMUFEUQsEV/7vuQuE2EyiCLxgUL9xr3e0lgiXqvTMIiC1fh
        1vTcSmWA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nupZf-001XAz-R6; Sat, 28 May 2022 06:05:19 +0000
Date:   Fri, 27 May 2022 23:05:19 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 21/24] buffer: Don't test folio error in
 block_read_full_folio()
Message-ID: <YpG7n8QFWThgV5TN@infradead.org>
References: <20220527155036.524743-1-willy@infradead.org>
 <20220527155036.524743-22-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220527155036.524743-22-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 27, 2022 at 04:50:33PM +0100, Matthew Wilcox (Oracle) wrote:
> We can cache this information in a local variable instead of communicating
> from one part of the function to another via folio flags.

Looks sensibel, but I'd invert the polarity and name this
buffers_uptodate to match the API call based on it.
