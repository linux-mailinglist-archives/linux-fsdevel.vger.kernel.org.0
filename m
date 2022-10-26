Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5951D60E3ED
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Oct 2022 16:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234426AbiJZO7U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Oct 2022 10:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234442AbiJZO7Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Oct 2022 10:59:16 -0400
X-Greylist: delayed 502 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 26 Oct 2022 07:59:12 PDT
Received: from lobo.ruivo.org (lobo.ruivo.org [173.14.175.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCB5B122762
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Oct 2022 07:59:12 -0700 (PDT)
Received: by lobo.ruivo.org (Postfix, from userid 1011)
        id DD49D534CC; Wed, 26 Oct 2022 10:50:48 -0400 (EDT)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
Received: from jake.ruivo.org (bob.qemu.ruivo [192.168.72.19])
        by lobo.ruivo.org (Postfix) with ESMTPA id 81027529B6;
        Wed, 26 Oct 2022 10:50:29 -0400 (EDT)
Received: by jake.ruivo.org (Postfix, from userid 1000)
        id 7E93D220062; Wed, 26 Oct 2022 10:50:29 -0400 (EDT)
Date:   Wed, 26 Oct 2022 10:50:29 -0400
From:   Aristeu Rozanski <aris@ruivo.org>
To:     Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
        npiggin@gmail.com, christophe.leroy@csgroup.eu, linux-mm@kvack.org,
        akpm@linux-foundation.org, David Howells <dhowells@redhat.com>,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [RFC PATCH] fs/hugetlb: Fix UBSAN warning reported on hugetlb
Message-ID: <Y1lJNepa22oMZ3tR@cathedrallabs.org>
References: <20220908072659.259324-1-aneesh.kumar@linux.ibm.com>
 <YxoeFUW5HFP/3/s1@casper.infradead.org>
 <6e8246ae-c420-df00-c1d1-03c49c0ab1f1@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e8246ae-c420-df00-c1d1-03c49c0ab1f1@linux.ibm.com>
User-Agent: Mutt/2.2.3 (2022-04-12)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 08, 2022 at 10:29:59PM +0530, Aneesh Kumar K V wrote:
> On 9/8/22 10:23 PM, Matthew Wilcox wrote:
> > On Thu, Sep 08, 2022 at 12:56:59PM +0530, Aneesh Kumar K.V wrote:
> >> +++ b/fs/dax.c
> >> @@ -1304,7 +1304,7 @@ EXPORT_SYMBOL_GPL(dax_zero_range);
> >>  int dax_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
> >>  		const struct iomap_ops *ops)
> >>  {
> >> -	unsigned int blocksize = i_blocksize(inode);
> >> +	size_t blocksize = i_blocksize(inode);
> >>  	unsigned int off = pos & (blocksize - 1);
> > 
> > If blocksize is larger than 4GB, then off also needs to be size_t.
> > 
> >> +++ b/fs/iomap/buffered-io.c
> >> @@ -955,7 +955,7 @@ int
> >>  iomap_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
> >>  		const struct iomap_ops *ops)
> >>  {
> >> -	unsigned int blocksize = i_blocksize(inode);
> >> +	size_t blocksize = i_blocksize(inode);
> >>  	unsigned int off = pos & (blocksize - 1);
> > 
> > Ditto.
> > 
> > (maybe there are others; I didn't check closely)
> 
> Thanks. will check those. 
> 
> Any feedback on statx? Should we really fix that?
> 
> I am still not clear why we chose to set blocksize = pagesize for hugetlbfs.
> Was that done to enable application find the hugetlb pagesize via stat()? 

I'd like to know that as well. It'd be easier to just limit the hugetlbfs max
blocksize to 4GB. It's very unlikely anything else will use such large
blocksizes and having to introduce new user interfaces for it doesn't sound
right.

-- 
Aristeu

