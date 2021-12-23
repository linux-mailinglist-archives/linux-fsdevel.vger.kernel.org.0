Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05A7347DF32
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Dec 2021 07:54:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238781AbhLWGy2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Dec 2021 01:54:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232658AbhLWGy1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Dec 2021 01:54:27 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84747C061401
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Dec 2021 22:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UqYj4/ZoXrbTAGwPYQVwmUR0ull7fD69GaAxZ4CoMYc=; b=fc1kVFHQ7a8AbbqfnqzrCl2dgD
        Lq3axW8CfTKyAWJQv9/aUCDq6NnZVCRExK0Da5xojPcFibm1NZSzFb1jZvCJbBOLuKc6Npt9uMuGA
        jmsFfvwpNc0ZjqOBsMsOc9QWegcJ+6Eng8LwEAFIW6USQT8CPL+B1dNEI7PaRk17VR0zdminf+kSJ
        DOOkF8YNJC8dWiZYN4gIXxtqVb8RIM9uxR55/A3RN6tAghzKQW5ubaYs53eOmwc3u0xCWrVsrO4Da
        O4s1TH9TSVy9oDi3RzYFn47Mnb4GWXUiwt/dt9PZS/A92YfazKOMfZZFRh5qPI5ZANbKfRt+UEAJb
        Km4MEwlg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n0Hzf-00BwsO-1d; Thu, 23 Dec 2021 06:54:27 +0000
Date:   Wed, 22 Dec 2021 22:54:27 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 05/48] pagevec: Add folio_batch
Message-ID: <YcQdI9lvCfBY8odQ@infradead.org>
References: <20211208042256.1923824-1-willy@infradead.org>
 <20211208042256.1923824-6-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208042256.1923824-6-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 08, 2021 at 04:22:13AM +0000, Matthew Wilcox (Oracle) wrote:
> +static inline void folio_batch_release(struct folio_batch *fbatch)
> +{
> +	pagevec_release((struct pagevec *)fbatch);
> +}
> +
> +static inline void folio_batch_remove_exceptionals(struct folio_batch *fbatch)
> +{
> +	pagevec_remove_exceptionals((struct pagevec *)fbatch);
> +}

I think these casts need documentation, both here and at the
struct folio_batch and struct pagevec definitions.

Alternatively I wonder if a union in stuct pagevec so that it can store
folios or pages might be the better option.
