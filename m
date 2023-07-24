Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3277475FDDB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jul 2023 19:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbjGXRfv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jul 2023 13:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbjGXRft (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jul 2023 13:35:49 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F0C8D3;
        Mon, 24 Jul 2023 10:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wIB4vt+V8SoWEpCnfmMPCk+fw2G2kkNB8igJzqls7oU=; b=Pzbx30YS2Rg7H7yLPpADxdF85r
        vsuXhVDHp+K9vmtVADs2Rwp6vLh8qZ1pt6rwTPReURqH9zDC8IJf6ZzjI5hqLuyD95bmsLrk7bUhS
        T9TRuajPRSeD3nca7V56HUsal8BVu7XyOfKkoT862hdolm73u5wBEmhPD1YVXSlCLfipixJIZa4IP
        CG/xiLkWs7br2Jd51zong0u9tGNTM58j45TswhILhrJ0Hpkmh0fELtLT0JjU8CkDRDewAws7d8zVh
        LLH5Uyl0zB7MX/X1sASxmhSx3catmsmBgaKnpzbWfUr100fw7h5pIlVwwnrGlJ+fI8BZ+3SfC/dMe
        WyH5TThw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qNzTF-0054TX-0c;
        Mon, 24 Jul 2023 17:35:45 +0000
Date:   Mon, 24 Jul 2023 10:35:45 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 06/20] block: Bring back zero_fill_bio_iter
Message-ID: <ZL62cVmeI6t7o+G9@infradead.org>
References: <20230712211115.2174650-1-kent.overstreet@linux.dev>
 <20230712211115.2174650-7-kent.overstreet@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712211115.2174650-7-kent.overstreet@linux.dev>
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

On Wed, Jul 12, 2023 at 05:11:01PM -0400, Kent Overstreet wrote:
> From: Kent Overstreet <kent.overstreet@gmail.com>
> 
> This reverts 6f822e1b5d9dda3d20e87365de138046e3baa03a - this helper is
> used by bcachefs.
> 
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: linux-block@vger.kernel.org
> ---
>  block/bio.c         | 6 +++---
>  include/linux/bio.h | 7 ++++++-
>  2 files changed, 9 insertions(+), 4 deletions(-)

I really don't see any point in offering this in the block layer.  By
the lack of any other caller it obviously isn't such a generic and
always used helper, but more importantly it literally is three lines
of code to implement it.
