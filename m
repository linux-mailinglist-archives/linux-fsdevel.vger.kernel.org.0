Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9225551048
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jun 2022 08:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237936AbiFTGZj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jun 2022 02:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231691AbiFTGZf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jun 2022 02:25:35 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0410F63CE;
        Sun, 19 Jun 2022 23:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DJcka4nk6nI6gmKXL/SKNBMqMDesGUybf1AX+sEYsjs=; b=czWVtFhBdwHslSccdEtX+EqsHY
        BXT/X5x7kJpFdgto+fK9tEQfUu4HVTAXm8Gt12gxH1Pf2XlVLiu1EjdhDWxijK19WxYHdJ0pLx8i9
        C5O2YVzJ0zwBdc1AK/m+1SbgtLbVnJ3i5ehRCaN7yMUebRIcdtP8meJdpBUmm9ONSj3i2Gp/dFv8q
        8E35uZZlppmIKENk0zhDUvfCSNo+kHHm5QClMqcJYE+oUqEXSBpEWyAxNQcHYvavmswdMTwMlQRz1
        QVfB8hiY4pPnINNNwWdst66h92fysQCq3tBja2zJvgzEM54ieOlr6II3VoZ5jvZHm7LzMenhpoTEs
        TDspvUog==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o3Aqp-00GQxm-22; Mon, 20 Jun 2022 06:25:31 +0000
Date:   Sun, 19 Jun 2022 23:25:31 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yu Kuai <yukuai3@huawei.com>,
        Kent Overstreet <kent.overstreet@gmail.com>
Subject: Re: [PATCH 1/3] filemap: Correct the conditions for marking a folio
 as accessed
Message-ID: <YrAS2+hjH19LA73A@infradead.org>
References: <20220619151143.1054746-1-willy@infradead.org>
 <20220619151143.1054746-2-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220619151143.1054746-2-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jun 19, 2022 at 04:11:41PM +0100, Matthew Wilcox (Oracle) wrote:
> +static inline bool pos_same_folio(loff_t pos1, loff_t pos2, struct folio *folio)
>
> +{
> +	unsigned int shift = folio_shift(folio);
> +
> +	return (pos1 >> shift == pos2 >> shift);
> +}

The calling convention with the folio as the last argument seems a bit
odd to me. But then again so does passing just one folio for checking
if something is in the same folio.   But as I can't come up with
something better I'll just deposit these mumblings here insted of
actually complaining.
