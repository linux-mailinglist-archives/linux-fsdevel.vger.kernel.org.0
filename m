Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DCD36F9CF0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 May 2023 02:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbjEHAXf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 7 May 2023 20:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbjEHAXd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 7 May 2023 20:23:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C59072BA
        for <linux-fsdevel@vger.kernel.org>; Sun,  7 May 2023 17:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/ndftXZhVS8NkbL8HbwnMScUwIv7+CmBxMuefylBBbM=; b=oA41I2ueadvjJ6e7RvHlhWJPKL
        XYESV/pKeTuuJj2vUzrB1Y6YQYd6HMnNK+R2brvvK9ia8zNw9mgg3DTWxjyfYZWfgeqsgdM8ql4g+
        z8Wm7hI2P92UdVWZcvFp4Uj7RANPiiSwuWmz2pDlP/cNaeoDxfuPlrNNMFYHa1CWvhcWBLW0vFEo8
        GcD82uloLtsc69p/R6bw/0CZE8+g31aPLbo9ASmwcBNB2aB8zS8dIJwKbJGPpbzWbU441SA5DhoO3
        Mds+11w7Lwpiq8Y8LnxiR2dXe1P0ks3dMN/cFj1VW1K2aHxmYGsVyCyJp2j9T07oJvLAZCKXzvSOP
        drG4JYnA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pvoey-00DfVg-6F; Mon, 08 May 2023 00:23:24 +0000
Date:   Mon, 8 May 2023 01:23:24 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [LSF/MM/BPF] Whither Highmem?
Message-ID: <ZFhA/CGgfo71jPtK@casper.infradead.org>
References: <ZFgySub+z210Rvsk@casper.infradead.org>
 <20230507234330.cnzbumof2hdl4ci6@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230507234330.cnzbumof2hdl4ci6@box.shutemov.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 08, 2023 at 02:43:30AM +0300, Kirill A. Shutemov wrote:
> On Mon, May 08, 2023 at 12:20:42AM +0100, Matthew Wilcox wrote:
> > 
> > I see there's a couple of spots on the schedule open, so here's something
> > fun we could talk about.
> > 
> > Highmem was originally introduced to support PAE36 (up to 64GB) on x86
> > in the late 90s.  It's since been used to support a similar extension
> > on ARM (maybe other 32-bit architectures?)
> > 
> > Things have changed a bit since then.  There aren't a lot of systems
> > left which have more than 4GB of memory _and_ are incapable of running a
> > 64-bit kernel.
> 
> Actual limit is lower. With 3G/1G userspace/kernel split you will have
> somewhere about 700Mb of virtual address space for direct mapping.
> 
> But, I would like to get rid of highmem too. Not sure how realistic it is.

Right, I was using 4GB because on x86, we have two config options that
enable highmem, CONFIG_HIGHMEM4G and CONFIG_HIGHMEM64G.  If we get rid
of the latter, it could be a nice win?

Also, the more highmem we have, the more kinds of things we need to put in
highmem.  Say we have a 3:1 ratio of high to lowmem.  On my 16GB laptop,
I have 5GB of Cached and 8.5GB of Anon.  That's 13.5GB, so assuming that
ratio would be similar for a 4GB laptop, it's 5.4:1 and storing _just_
anon & cached pages in highmem would be more than enough.

(fwiw, PageTables is 125MB)

Maybe there's a workload that needs, eg page tables or fs metadata to
be stored in highmem.  Other than pathological attempts to map one
page per 2MB, I don't think those exist.

Something I forgot to say is that I do not think we'll see highmem being
needed on 64-bit systems.  We already have CPUs with 128-bit registers,
and have since the Pentium 3.  128-bit ALUs are missing, but as long as
we're very firm with CPU vendors that this is the kind of nonsense up
with which we shall not put, I think we can get 128-bit normal registers
at the same time that they change the page tables to support more than
57 bits of physical memory.
