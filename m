Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 288CF338E69
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Mar 2021 14:12:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbhCLNMK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Mar 2021 08:12:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231694AbhCLNLx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Mar 2021 08:11:53 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3703C061761;
        Fri, 12 Mar 2021 05:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tvpjCoady7IGByyxkS97aMgJJirlM2J40DzsaJU72mI=; b=q/da4l3LIDjHrcbEUEmKLQwVSh
        KlSt4MSWxdLroPNerkJi+pOKPjh71eRW0Z3Lkr9JLhV89hTfarZRqDT+GPjnp+dQH94Lk1xUaN5B9
        AdVWvbix78dRGQoMEJBhJiddIMDiGII81pmR782yZ7upSp4/BfevFNv1fTOoubqfek5e269323OKR
        x7z6lyP88+nK5pEDw1nM6WPlpCMsIGMJPgYrVBtejRD9dW/KBbLAlb0b7XXY6NqJB5zZOEHjtnecY
        ytmZdXoKy4ZSBBHgoqsAvWLB1qJbAO7IEWWUjXnelGzAIbdsgCl0ZQUXi9ppDu9Z7c0fUd/IgBaPz
        Ag7HnDpQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lKhZb-00AiRn-V7; Fri, 12 Mar 2021 13:11:28 +0000
Date:   Fri, 12 Mar 2021 13:11:23 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Luis Henriques <lhenriques@suse.de>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: fuse: kernel BUG at mm/truncate.c:763!
Message-ID: <20210312131123.GZ3479805@casper.infradead.org>
References: <YEsryBEFq4HuLKBs@suse.de>
 <CAJfpegu+T-4m=OLMorJrZyWaDNff1eviKUaE2gVuMmLG+g9JVQ@mail.gmail.com>
 <YEtc54pWLLjb6SgL@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YEtc54pWLLjb6SgL@suse.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 12, 2021 at 12:21:59PM +0000, Luis Henriques wrote:
> > > I've seen a bug report (5.10.16 kernel splat below) that seems to be
> > > reproducible in kernels as early as 5.4.

If this is reproducible, can you turn this BUG_ON into a VM_BUG_ON_PAGE()
so we know what kind of problem we're dealing with?  Assuming the SUSE
tumbleweed kernels enable CONFIG_DEBUG_VM, which I'm sure they do.

> > Page fault locks the page before installing a new pte, at least
> > AFAICS, so the BUG looks impossible.  The referenced commits only
> > touch very high level control of writeback, so they may well increase
> > the chance of a bug triggering, but very unlikely to be the actual
> > cause of the bug.   I'm guessing this to be an MM issue.
> 
> Ok, thank you for having a look at it.
> 
> Interestingly, there's a single commit to mm/truncate.c in 5.4:
> ef18a1ca847b ("mm/thp: allow dropping THP from page cache").  I'm Cc'ing
> Andrew and Kirill, maybe they have some ideas.

That's probably not it; unless FUSE has developed the ability to insert
compound pages into the page cache without me noticing.

(if it had, that would absolutely explain it -- i have a fix in my thp
tree for this case, but it doesn't affect any existing filesystem
because only shmem uses compound pages and it doesn't call
invalidate_inode_pages2_range)
