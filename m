Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 325FF270B29
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Sep 2020 08:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbgISGjK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 19 Sep 2020 02:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbgISGjK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 19 Sep 2020 02:39:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FEE0C0613CE;
        Fri, 18 Sep 2020 23:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=N06vUgFDFMKJDgeybDJWkd+8W/Yn9aSVJk22hKSqvXw=; b=tUF20LCBBRMnhduZpJr46MxoeX
        jqrqsA6DTLHR7HszuS+HfgC6SR3MJ7yxisuw/ur+PdBGZ45jLVUD91dXZjumb6FC+GuS/x5UWEmbQ
        AJpC8LROLmDqd5mR7oOO45vGlzdWwaUVfYqiDH1QI7yHP9aKyQhKJ+mulV/mmzR+L7fcCQjBtxoo4
        rhCQGVqIRyVYa1NC3mIREmCLxaWAp86XNZIG54x0oxKsukzZl1bkwrpeGaJOJqdDygF/q5rJ/gHEz
        989hYOZ1XApbh7U6vu785/uEmEARHqw1+QuhbNaVI9AH1Zawc6w8UFBZ2LuBRIFUbIpCCnEPIaSEP
        1XlbiAQA==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kJWWa-0004DT-Ja; Sat, 19 Sep 2020 06:39:08 +0000
Date:   Sat, 19 Sep 2020 07:39:08 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 16/13] iomap: Make readpage synchronous
Message-ID: <20200919063908.GH13501@infradead.org>
References: <20200917151050.5363-1-willy@infradead.org>
 <20200917225647.26481-1-willy@infradead.org>
 <20200917225647.26481-3-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917225647.26481-3-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I think just adding the completion and status to struct
iomap_readpage_ctx would be a lot easier to follow, at the cost
of bloating the structure a bit for the readahead case.  If we
are realy concerned about that, the completion could be directly
on the iomap_readpage stack and we'd pass a pointer.
