Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C65F5186FC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 May 2022 16:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237237AbiECOpr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 May 2022 10:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234311AbiECOpq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 May 2022 10:45:46 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EFD935DD1
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 May 2022 07:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l77+SEjujcvovwYHWsVkztaEMYTZsJsekrCnH7+6eyI=; b=JXiL5rZXFLnw9EO07KmI8qVwtS
        OqoUDVXfkR+NV8Ri7sA9UdVGEG5F5iQuq8GeKNhJZ5KhppAaUDs6cvcIOSF0/oWGG8yHBn6TpCcxR
        FWE3hPTzBAuFfViEkUdUiRzKpycQ3hPz341TOIi1/ZRrN/KJ4x2agCX7ygCrwSrFAXSWWNhiLI0Hp
        yZEFBEWTZl4xayzmMvENXO/siTbu8+isUBd7W/ePBbkzokP2pyKm7jMnpiWy6PvjQCo0yrwnkcNz5
        3IFyojDARFpRaJKH5EAfffiIbUKlHK44llTZlnxtIjUGWYRFlOEIWJhfnN6pwdXtj03KrxW5VFu21
        iuD6dYBQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nltjA-006JH9-Q0; Tue, 03 May 2022 14:42:12 +0000
Date:   Tue, 3 May 2022 07:42:12 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 33/69] fs: Introduce aops->read_folio
Message-ID: <YnE/RGYe+DMBGscY@infradead.org>
References: <20220429172556.3011843-1-willy@infradead.org>
 <20220429172556.3011843-34-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220429172556.3011843-34-willy@infradead.org>
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

On Fri, Apr 29, 2022 at 06:25:20PM +0100, Matthew Wilcox (Oracle) wrote:
> The ->readpage and ->read_folio operations are always called with the
> same set of bits; it's only the type which differs.  Use a union to
> help with the transition and convert all the callers to use ->read_folio.

I don't think this is going to make CFI very happy.
