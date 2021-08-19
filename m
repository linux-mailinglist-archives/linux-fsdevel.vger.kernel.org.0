Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3BC3F2078
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Aug 2021 21:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234675AbhHSTTv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Aug 2021 15:19:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:56256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234404AbhHSTTn (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Aug 2021 15:19:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 29A2960C3E;
        Thu, 19 Aug 2021 19:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629400740;
        bh=G4Xi5HqBpDKXc3j8L3BAi3I6X+w5fRA9RfqQJZDwZ6U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DKYaiP2jBBnH1RR4rjXN3jRVSy+5vnbbXYywiyLOVOSuO/3MALXCdglgMHTTW9C9M
         Zowih9jRJ3Rdazk+4MwPK5ZalhjHgGEq3ZPEBcA/HqNp7F24aiXaB3RkHLHhLSqHkB
         pUZKYDzUliRwhFDFuquYq/G6nKqqlyN84l1aYSzZhHwJgCQ5fkhUGrt4S9gGIUy9Js
         LGzTCT1Qgogk+r46ksP0B5WBNDw09Up0gw04WoH8Z7+1tUAEKhhWvjO47gTELGwkc/
         ZiosKehlu/dlXBeFVd/kZZC0n2VjE8e/4IxH10S5dr5eU56GAyCLXT77tLZkYcJ1GJ
         1oWNQF3cDsdCw==
Date:   Thu, 19 Aug 2021 12:18:59 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     fstests <fstests@vger.kernel.org>, Xu Yu <xuyu@linux.alibaba.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        riteshh@linux.ibm.com, tytso@mit.edu, gavin.dg@linux.alibaba.com,
        Christoph Hellwig <hch@infradead.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] generic: test swapping process pages in and out of a
 swapfile
Message-ID: <20210819191859.GH12664@magnolia>
References: <20210819182646.GD12612@magnolia>
 <YR6paxMLClZ8WaaT@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YR6paxMLClZ8WaaT@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 19, 2021 at 07:56:43PM +0100, Matthew Wilcox wrote:
> On Thu, Aug 19, 2021 at 11:26:46AM -0700, Darrick J. Wong wrote:
> > +	printf("Dirtying memory.\n");
> > +	fflush(stdout);
> > +
> > +	/* Dirty the memory to force this program to be swapped out. */
> > +	for (p = pstart; p < pend; p += pagesize)
> > +		*p = 'X';
> 
> What I liked about dhowells' program was that it checked whether the
> pages brought back in from swap were the same ones that had been written
> to swap.  As a block filesystem person, you only know the misery of having
> swap go behind your back to the block device.  As a network filesystem
> person, David is acutely aware of the misery of having to remember to
> use page_file_index() instead of page->index in order to avoid reading
> a page from the wrong offset in the swap partition.
> 
> Yes, our swap code is nasty in many different ways, why do you ask?

Wheeee, I'll go change it to store per-page data in each page and check
it on the way back.

--D
