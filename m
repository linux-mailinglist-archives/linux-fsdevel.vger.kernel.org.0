Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0C583F2042
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Aug 2021 20:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234126AbhHSS6P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Aug 2021 14:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbhHSS6P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Aug 2021 14:58:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91062C061575;
        Thu, 19 Aug 2021 11:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5eC8zn0nvpnMn9/nAEV/c108WS/2ZWs8TKMFCYynaRY=; b=H8XCrnz86KwsvRN6bgl+cdcl3s
        EFeLyzfjvMeDUaOZ/N/24FpuMiBg7gWZ1hsJTqN0gmDFRy8R2Tm9U+0W40nEQMqZogRWfN4HUXLaF
        P5qVH2GU4FgwcXxmiacEhz/gmoQxRr4o7X8K/nn4ZX2S9z27N/c2b2Oc5wVZHtR9NXkW/nee4FiW+
        SPMjwOlZj4ueHzqqiqbTz1skZy4RoOmenMAHEuYnLWVzivkfHuNP8OCa8pCQqY7gnqu1LVr2r++n3
        S37tMnBanxQ8eGa+1B4oeBY6ReHuSMsdY0VfDiCqVhdPn+7yWnm4Ggujr4VLXBSYrstssQVkxYbRJ
        hAXI+p0Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mGnDX-005Scq-6c; Thu, 19 Aug 2021 18:56:51 +0000
Date:   Thu, 19 Aug 2021 19:56:43 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     fstests <fstests@vger.kernel.org>, Xu Yu <xuyu@linux.alibaba.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        riteshh@linux.ibm.com, tytso@mit.edu, gavin.dg@linux.alibaba.com,
        Christoph Hellwig <hch@infradead.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] generic: test swapping process pages in and out of a
 swapfile
Message-ID: <YR6paxMLClZ8WaaT@casper.infradead.org>
References: <20210819182646.GD12612@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210819182646.GD12612@magnolia>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 19, 2021 at 11:26:46AM -0700, Darrick J. Wong wrote:
> +	printf("Dirtying memory.\n");
> +	fflush(stdout);
> +
> +	/* Dirty the memory to force this program to be swapped out. */
> +	for (p = pstart; p < pend; p += pagesize)
> +		*p = 'X';

What I liked about dhowells' program was that it checked whether the
pages brought back in from swap were the same ones that had been written
to swap.  As a block filesystem person, you only know the misery of having
swap go behind your back to the block device.  As a network filesystem
person, David is acutely aware of the misery of having to remember to
use page_file_index() instead of page->index in order to avoid reading
a page from the wrong offset in the swap partition.

Yes, our swap code is nasty in many different ways, why do you ask?
