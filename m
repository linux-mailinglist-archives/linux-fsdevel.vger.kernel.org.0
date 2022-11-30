Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6521163D910
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Nov 2022 16:18:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbiK3PSt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Nov 2022 10:18:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiK3PSs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Nov 2022 10:18:48 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA92837235;
        Wed, 30 Nov 2022 07:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=N9HXBBW7P/KvVNawmxP/5nCywoMe+jH+9tdbHKm2yx4=; b=lQ1WyiKRrQeHAg4aAhQC4Jx+kF
        RcVZQAoZ2Reaiz5xHiiSxbFcwo041E6tsoUwVaGybmugem8+4hWo4WFjyOX3jFA2HYI7lvXcHKn+6
        h7mmjbxsORZKqCW5OipGo8f/FbZrXYnf/RWm9p8tkML3rwfEiVigFzsrNmSJJQ1twbm2qSDMcttHa
        mDNQgjabRUZkO5EOzzr04YbceD+HjlJSuBFmtrVhLUJba1383ukKb7CKz07LEPOl33OB5gbk05iRz
        EEgraQ++6paX17JPyMs1AiM5aJncrYPcaaPXhlH2OX25db/LYTfnvbHkFmJmGfqPlqbwVDHxbxBnH
        o/9lgL9w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p0OrC-00F5XG-0W; Wed, 30 Nov 2022 15:18:42 +0000
Date:   Wed, 30 Nov 2022 15:18:41 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     jaegeuk@kernel.org, chao@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, fengnanchang@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        vishal.moola@gmail.com
Subject: Re: [PATCH] f2fs: Support enhanced hot/cold data separation for f2fs
Message-ID: <Y4d0UReDb+EmUJOz@casper.infradead.org>
References: <Y4ZaBd1r45waieQs@casper.infradead.org>
 <20221130124804.79845-1-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221130124804.79845-1-frank.li@vivo.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 30, 2022 at 08:48:04PM +0800, Yangtao Li wrote:
> Hi,
> 
> > Thanks for reviewing this.  I think the real solution to this is
> > that f2fs should be using large folios.  That way, the page cache
> > will keep track of dirtiness on a per-folio basis, and if your folios
> > are at least as large as your cluster size, you won't need to do the
> > f2fs_prepare_compress_overwrite() dance.  And you'll get at least fifteen
> > dirty folios per call instead of fifteen dirty pages, so your costs will
> > be much lower.
> >
> > Is anyone interested in doing the work to convert f2fs to support
> > large folios?  I can help, or you can look at the work done for XFS,
> > AFS and a few other filesystems.
> 
> Seems like an interesting job. Not sure if I can be of any help.
> What needs to be done currently to support large folio?
> 
> Are there any roadmaps and reference documents.

From a filesystem point of view, you need to ensure that you handle folios
larger than PAGE_SIZE correctly.  The easiest way is to spread the use
of folios throughout the filesystem.  For example, today the first thing
we do in f2fs_read_data_folio() is convert the folio back into a page.
That works because f2fs hasn't told the kernel that it supports large
folios, so the VFS won't create large folios for it.

It's a lot of subtle things.  Here's an obvious one:
                        zero_user_segment(page, 0, PAGE_SIZE);
There's a folio equivalent that will zero an entire folio.

But then there is code which assumes the number of blocks per page (maybe
not in f2fs?) and so on.  Every filesystem will have its own challenges.

One way to approach this is to just enable large folios (see commit
6795801366da or 8549a26308f9) and see what breaks when you run xfstests
over it.  Probably quite a lot!

