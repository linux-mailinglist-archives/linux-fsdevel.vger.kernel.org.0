Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77F4C47E04E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Dec 2021 09:22:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347092AbhLWIWK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Dec 2021 03:22:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347105AbhLWIWG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Dec 2021 03:22:06 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A7EC061401
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Dec 2021 00:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TGCr7CxAcvYkAiR7jd2kBNIauxuLIoaCZf28MRPBQRU=; b=25eemg7EF5z3hPGEK0RDEEnDov
        SwWrc0jmqxak7xpUpFgDVlc55O9OkFjA8b0K4fizaujCGaOTPlUWhO3t/WaWfdotl0bCVimB1iRcl
        SpaI3FsQdq49MkQcuzSg3A6lKhrfklOz8YRLnVI95caRmXJop/Bs1DSzf4JtfcOaHRG2G+Uykrbit
        TU/I2VGGchri0XxP/ts/pXeeLKqQmes9BGk5bth41dgNYWGgaD4yZ48doN74Z4CajgeOih5rfed9S
        Z3NR+bdoJA0YMeF0LVKR2xaqPPFHTC3ffI6IxBgeuBhYAdF4EbKTraphPmmRhmkqjYZiJmUsCcpGq
        B8lGHrug==;
Received: from [46.183.103.8] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n0JMT-00CCks-6q; Thu, 23 Dec 2021 08:22:05 +0000
Date:   Thu, 23 Dec 2021 09:22:02 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 39/48] filemap: Convert filemap_read() to use a folio
Message-ID: <YcQxqnwGyDj1rf1c@infradead.org>
References: <20211208042256.1923824-1-willy@infradead.org>
 <20211208042256.1923824-40-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208042256.1923824-40-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 08, 2021 at 04:22:47AM +0000, Matthew Wilcox (Oracle) wrote:
>  		for (i = 0; i < pagevec_count(&pvec); i++) {
> -			struct page *page = pvec.pages[i];
> -			size_t page_size = thp_size(page);
> -			size_t offset = iocb->ki_pos & (page_size - 1);
> +			struct folio *folio = page_folio(pvec.pages[i]);
> +			size_t fsize = folio_size(folio);

Any reason for fsize vs folio_size?

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
