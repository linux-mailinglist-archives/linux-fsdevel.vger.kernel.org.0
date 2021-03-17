Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F09233F773
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Mar 2021 18:48:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232772AbhCQRsN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Mar 2021 13:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232806AbhCQRrq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Mar 2021 13:47:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6486C06174A;
        Wed, 17 Mar 2021 10:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rL7SFawsS6liUNgGQ9iTAJB8GXMy0bvzGxWlxqtV9bA=; b=kwWUW/scijZUk2gBe0/qYqS9Bp
        rhiaJ++M1Et/DCmh8LuhVHjj1Kb8Thfb83lSQ+LOLYlCsraR973yvNx445uTwKH4cU7CWo9Mcj5Qo
        ZCaQGP87mYLksgp6fNCN85TBefGtsgA99HN1NfB1X8H8S5CIaBeE3s+xgZveNbihitX640i5qQAyU
        JnOAgWjrmqpdDZiPDC0/HANRwWtSPix/Bavwm09jsXR0P1PTAhBk9yoPa/pzvEnHQGxiZCYUuuQ2+
        vAfgp6tu+lhYACW+SaN5d14LfY/CLj/3rdiXLVOxDQsLwY6h4BsHghato2XPqr7/UitnBB9YHgKa1
        CEVrLLkw==;
Received: from 089144199244.atnat0008.highway.a1.net ([89.144.199.244] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lMaGc-001w1O-12; Wed, 17 Mar 2021 17:47:37 +0000
Date:   Wed, 17 Mar 2021 18:45:22 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 25/25] cachefiles: Switch to wait_page_key
Message-ID: <YFJAMvsjkWKto0B+@infradead.org>
References: <20210305041901.2396498-1-willy@infradead.org>
 <20210305041901.2396498-26-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210305041901.2396498-26-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 05, 2021 at 04:19:01AM +0000, Matthew Wilcox (Oracle) wrote:
> Cachefiles was relying on wait_page_key and wait_bit_key being the
> same layout, which is fragile.  Now that wait_page_key is exposed in
> the pagemap.h header, we can remove that fragility.  Also switch it
> to use the folio directly instead of the page.

Yikes.  That fix itself is something that should go into mainline ASAP as
it fixes a massive landmine instead of mixing it up with the folio
conversion.
