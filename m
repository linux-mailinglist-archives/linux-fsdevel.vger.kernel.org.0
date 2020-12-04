Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE0452CE6B0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Dec 2020 04:49:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726868AbgLDDt1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Dec 2020 22:49:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbgLDDt0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Dec 2020 22:49:26 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B1E3C061A4F;
        Thu,  3 Dec 2020 19:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OT2ToLvxm9ndZrO1bmPA6HE3oC3Xt6abE/tQXRQLEts=; b=jAo5OOywuNxNDCnoGaqkj6LsZQ
        Ozk6UNEBW9M3HIr4RqpVuqcuC8+RXowF3z/ChJamXyKDZPGryrkIHA/gZx8WRtDLFAo/4XmafgJSV
        1YIRVjEKJ0epCG1rb7SLiCIm55jPAebywdX7xoXEN0mt09oLfq5dO6107wG83qsunmWqq1Oo3DgC9
        Gh3UjDNQJq0TSIky5HUoOctUzrZHq5UVS5J11yzkRkjWhqggeHbWT1gAwDyfRVf4QnwPuOkR1mLyh
        ejQk4d0cz/5Zcd06RxNnsOadzubHqwgAAPxMqESrUOQOkzou+ztraS+Si+g8lgHz4iHUUBWucLllk
        K7HCev+g==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kl25L-0002pU-3H; Fri, 04 Dec 2020 03:48:43 +0000
Date:   Fri, 4 Dec 2020 03:48:43 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        linux-nvdimm@lists.01.org
Subject: Re: PATCH] fs/dax: fix compile problem on parisc and mips
Message-ID: <20201204034843.GM11935@casper.infradead.org>
References: <fb91b40d258414b0fdce2c380752e48daa6a70d6.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb91b40d258414b0fdce2c380752e48daa6a70d6.camel@HansenPartnership.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 03, 2020 at 04:33:10PM -0800, James Bottomley wrote:
> These platforms define PMD_ORDER in asm/pgtable.h

I think that's the real problem, though.

#define PGD_ORDER       1 /* Number of pages per pgd */
#define PMD_ORDER       1 /* Number of pages per pmd */
#define PGD_ALLOC_ORDER (2 + 1) /* first pgd contains pmd */
#else
#define PGD_ORDER       1 /* Number of pages per pgd */
#define PGD_ALLOC_ORDER (PGD_ORDER + 1)

That should clearly be PMD_ALLOC_ORDER, not PMD_ORDER.  Or even
PAGES_PER_PMD like the comment calls it, because I really think
that doing an order-3 (8 pages) allocation for the PGD is wrong.

