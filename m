Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D68F33F6DF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Mar 2021 18:32:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbhCQRcA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Mar 2021 13:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbhCQRbh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Mar 2021 13:31:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56074C06174A;
        Wed, 17 Mar 2021 10:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=juTMg8li9WPs7BV+rnBMWaP6lQk9lYsWgQiaexNFbfM=; b=a/25aH81aDfiJnlPF2p+fW3ZIy
        gKa6Kr9lvB2hlH58bQNh9mv4TKbz5IPukOxqDpUZZesKeSYVMWn1byX3oxBWUNnzxVsref83RJqSG
        2kFBuBlfwaZ90rofUL1IsqFWRCo5uIgh08Yqsop+y8VPU0+MM1WAhe4GqiGAmQ31gTIUN2ji/5NSx
        4ydSY5gX6mxWhV0mz/lUyuv4UUrhRfNnoEqQl9ZY266GZRxOXTHbvG0K3Gkb+9bGv8WnD414OUW1W
        Ebs0+El7AhG+w2Ugw3pfbXv5oAT9ych66CJAkvXPFKfISahgJpODS8ljaiiYAxByZF8bwDb3oygD9
        wFhGk6rg==;
Received: from 089144199244.atnat0008.highway.a1.net ([89.144.199.244] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lMa0r-001uvG-8S; Wed, 17 Mar 2021 17:31:23 +0000
Date:   Wed, 17 Mar 2021 18:29:05 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 15/25] mm/filemap: Convert lock_page_async to
 lock_folio_async
Message-ID: <YFI8YU9Hmitq/HwT@infradead.org>
References: <20210305041901.2396498-1-willy@infradead.org>
 <20210305041901.2396498-16-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210305041901.2396498-16-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 05, 2021 at 04:18:51AM +0000, Matthew Wilcox (Oracle) wrote:
> There aren't any actual callers of lock_page_async(), but convert
> filemap_update_page() to call __lock_folio_async().

So please just kill lock_page_async first and mark __lock_page_async
static.  Then only update __lock_page_async to work on a folio.
