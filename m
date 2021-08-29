Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 390B63FA827
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Aug 2021 03:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234658AbhH2Boo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 28 Aug 2021 21:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbhH2Bon (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 28 Aug 2021 21:44:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99C7BC061756;
        Sat, 28 Aug 2021 18:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1D5EGfupOlC5GqXdjCeuhAggzcMXpUvnLDnEOSPMg0A=; b=CfZFhe2GiPX4PN6UO2V2uIqyF2
        iD2aTOc8ot5LEr+95DYV24ounFidh6ICrJ73jJZaNHC7fh/pO0W4UOv+rwvHNNkEVN23atyiQ2YMj
        xE6DHWkD+sh+/g51kNKBoMHzu9HJO+PiOxZTfUDM6pNFfJPM88G5hsktwBuu7UGlxKstcT8mf7Kq+
        N/Pn2bA3BwRHppMZvfKDafduCD4/AHMKQn40Hun2qtnIwoJxup+1gJ5fR5Af/ngzGx3iQn9o2X8dQ
        2sAOBSHG5iS2sSQOR0mrPLgmGdX6atdTdIHNouIFd0vktF/CHHLyCnpKoO3WDTpYrBfHwTbundNSD
        mhwV3AGg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mK9oh-00G4HC-HA; Sun, 29 Aug 2021 01:41:13 +0000
Date:   Sun, 29 Aug 2021 02:40:59 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Tony Luck <tony.luck@intel.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ocfs2-devel@oss.oracle.com, Borislav Petkov <bp@alien8.de>,
        X86-ML <x86@kernel.org>
Subject: Re: [PATCH v7 05/19] iov_iter: Introduce fault_in_iov_iter_writeable
Message-ID: <YSrlq41Ytw7q8fCR@casper.infradead.org>
References: <YSk7xfcHVc7CxtQO@zeniv-ca.linux.org.uk>
 <CAHk-=wjMyZLH+ta5SohAViSc10iPj-hRnHc-KPDoj1XZCmxdBg@mail.gmail.com>
 <YSk+9cTMYi2+BFW7@zeniv-ca.linux.org.uk>
 <YSldx9uhMYhT/G8X@zeniv-ca.linux.org.uk>
 <YSlftta38M4FsWUq@zeniv-ca.linux.org.uk>
 <20210827232246.GA1668365@agluck-desk2.amr.corp.intel.com>
 <87r1edgs2w.ffs@tglx>
 <YSqy+U/3lnF6K0ia@zeniv-ca.linux.org.uk>
 <YSq0mPAIBfqFC/NE@zeniv-ca.linux.org.uk>
 <CA+8MBbLLze0siip=h-2hR3XiceBFQCN7uh5BPvqYRyBXgT318g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+8MBbLLze0siip=h-2hR3XiceBFQCN7uh5BPvqYRyBXgT318g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Aug 28, 2021 at 03:20:58PM -0700, Tony Luck wrote:
> On Sat, Aug 28, 2021 at 3:12 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> > BTW, is #MC triggered on stored to a poisoned cacheline?  Existence of CLZERO
> > would seem to argue against that...
> 
> No #MC on stores. Just on loads. Note that you can't clear poison
> state with a series of small writes to the cache line. But a single
> 64-byte store might do it (architects didn't want to guarantee that
> it would work when I asked about avx512 stores to clear poison
> many years ago).

Dave Jiang thinks MOVDIR64B clears poison.

http://archive.lwn.net:8080/linux-kernel/157617505636.42350.1170110675242558018.stgit@djiang5-desk3.ch.intel.com/

