Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1D6A3FBC6C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Aug 2021 20:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238870AbhH3S3V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Aug 2021 14:29:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:48400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238720AbhH3S3N (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Aug 2021 14:29:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0A7A560E98;
        Mon, 30 Aug 2021 18:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630348099;
        bh=q7Sa9oLo1QMLGdTm8gSfsqOzZ6zO/A6Cj0Uzj1ZzG6U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WanAlxD7OG2mK5TiNVVN8rRFUR/8IocLCJmB9m6K3n5ns6ZumxwOG7A6H+1KcXwrA
         uIwsL2zIP0tEroxxX+/F3VK+CO7dH5vEmpSC06kOBrROHF7U0cXZ5TEW6Ss1/lobTI
         npe4LTbziMxbXhUNyCxaz0mrnUtjQyv3Hf1snKRZMWS2G1RZraLuzFtOFMNWCBReJw
         n0Gxd60W+DY7P/HdsIbInFN63221O+zbRwFwsOwBaWOsYKJZLm69dw1AKXdoO9o/1/
         t6TAubAA+EU4WgzyirdD7R+BTsydKulNNQ36Qi3IZJDKQ4MgRwI8qOjcsKJevS+rFI
         4wdKzJCaQxo/Q==
Date:   Mon, 30 Aug 2021 11:28:18 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: Discontiguous folios/pagesets
Message-ID: <20210830182818.GA9892@magnolia>
References: <YSqIry5dKg+kqAxJ@casper.infradead.org>
 <1FC3646C-259F-4AA4-B7E0-B13E19EDC595@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1FC3646C-259F-4AA4-B7E0-B13E19EDC595@dilger.ca>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Aug 28, 2021 at 01:27:29PM -0600, Andreas Dilger wrote:
> On Aug 28, 2021, at 1:04 PM, Matthew Wilcox <willy@infradead.org> wrote:
> > 
> > The current folio work is focused on permitting the VM to use
> > physically contiguous chunks of memory.  Both Darrick and Johannes
> > have pointed out the advantages of supporting logically-contiguous,
> > physically-discontiguous chunks of memory.  Johannes wants to be able to
> > use order-0 allocations to allocate larger folios, getting the benefit
> > of managing the memory in larger chunks without requiring the memory
> > allocator to be able to find contiguous chunks.  Darrick wants to support
> > non-power-of-two block sizes.
> 
> What is the use case for non-power-of-two block sizes?  The main question
> is whether that use case is important enough to add the complexity and
> overhead in order to support it?

For copy-on-write to a XFS realtime volume where the allocation extent
size (we support bigalloc too! :P) is not a power of two (e.g. you set
up a 4 disk raid5 with 64k stripes, now the extent size is 192k).

Granted, I don't think folios handling 192k chunks is absolutely
*required* for folios; the only hard requirement is that if any page in
a 192k extent becomes dirty, the rest have to get written out all the
same time, and the cow remap can only happen after the last page
finishes writeback.

--D

> Cheers, Andreas
> 
> 
> 
> 
> 


