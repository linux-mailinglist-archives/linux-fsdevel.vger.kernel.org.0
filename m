Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5AF345AF9C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Nov 2021 00:00:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbhKWXDN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Nov 2021 18:03:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbhKWXDN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Nov 2021 18:03:13 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC37C061574;
        Tue, 23 Nov 2021 15:00:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5vRcWxXxzd4WGPKdHz9LVWODQ5YzAkwMwaTDRt2JBCg=; b=qwI0SbySX8Oas1lAMTbPkY6Wr9
        qu3DVtQjPQ9uTgc5mZKdJoC3BqXo4eSwDZsNKk+WS6s7ywjV4YJAo4gkdkqQz3Jr2cT+TyJv1pMoR
        3YXg+nvS7s0J9agapBeb+HJVWEa5NYqCgxepwjlK9SZJazlLXa+ZvBuulUmE6rHZcvL4XrFR9c3Qq
        fvI0h2K3s+2077dCM9Y0kH3nn2w5kzjd1fuVwsP2M1Gd4IiggTr4Pt6NA84EXOick9n7FdO0B82Db
        pijG/FftTQimqE3dV7Jzpojv4S007nPLpt8W3gK49AGT+L0rjmqbpBEvTBYSKRvLjVN7BE5ZYZxvA
        8a2DKAXw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mpelW-00GlV8-4G; Tue, 23 Nov 2021 22:59:54 +0000
Date:   Tue, 23 Nov 2021 22:59:54 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Mina Almasry <almasrymina@google.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        David Hildenbrand <david@redhat.com>,
        "Paul E . McKenney" <paulmckrcu@fb.com>,
        Yu Zhao <yuzhao@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>,
        Ivan Teterevkov <ivan.teterevkov@nutanix.com>,
        Florian Schmidt <florian.schmidt@nutanix.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v7] mm: Add PM_THP_MAPPED to /proc/pid/pagemap
Message-ID: <YZ1yapOMZOXdFHG9@casper.infradead.org>
References: <20211123000102.4052105-1-almasrymina@google.com>
 <YZ1USY+zB1PP24Z1@casper.infradead.org>
 <CAHS8izOhi45RqCACGGXYyB8UAmMo-85TyuNX8Myzdh81xOkBTA@mail.gmail.com>
 <YZ1ddl3FA43NijmX@casper.infradead.org>
 <CAHS8izMmcbXQ0xCDVYx8JW54sbbLXwNnK6pHgf9Ztn=XPFEsWA@mail.gmail.com>
 <YZ1lOgjv6r+ZOSRX@casper.infradead.org>
 <CAHS8izO0EMRgH8_qt58_O9-MBSwFXLgr1g79gJGrY1N0dTKutg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHS8izO0EMRgH8_qt58_O9-MBSwFXLgr1g79gJGrY1N0dTKutg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 23, 2021 at 02:23:23PM -0800, Mina Almasry wrote:
> On Tue, Nov 23, 2021 at 2:03 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Tue, Nov 23, 2021 at 01:47:33PM -0800, Mina Almasry wrote:
> > > On Tue, Nov 23, 2021 at 1:30 PM Matthew Wilcox <willy@infradead.org> wrote:
> > > > What I've been trying to communicate over the N reviews of this
> > > > patch series is that *the same thing is about to happen to THPs*.
> > > > Only more so.  THPs are going to be of arbitrary power-of-two size, not
> > > > necessarily sizes supported by the hardware.  That means that we need to
> > > > be extremely precise about what we mean by "is this a THP?"  Do we just
> > > > mean "This is a compound page?"  Do we mean "this is mapped by a PMD?"
> > > > Or do we mean something else?  And I feel like I haven't been able to
> > > > get that information out of you.
> > >
> > > Yes, I'm very sorry for the trouble, but I'm also confused what the
> > > disconnect is. To allocate hugepages I can do like so:
> > >
> > > mount -t tmpfs -o huge=always tmpfs /mnt/mytmpfs
> > >
> > > or
> > >
> > > madvise(..., MADV_HUGEPAGE)
> > >
> > > Note I don't ask the kernel for a specific size, or a specific mapping
> > > mechanism (PMD/contig PTE/contig PMD/PUD), I just ask the kernel for
> > > 'huge' pages. I would like to know whether the kernel was successful
> > > in allocating a hugepage or not. Today a THP hugepage AFAICT is PMD
> > > mapped + is_transparent_hugepage(), which is the check I have here. In
> > > the future, THP may become an arbitrary power of two size, and I think
> > > I'll need to update this querying interface once/if that gets merged
> > > to the kernel. I.e, if in the future I allocate pages by using:
> > >
> > > mount -t tmpfs -o huge=2MB tmpfs /mnt/mytmpfs
> > >
> > > I need the kernel to tell me whether the mapping is 2MB size or not.
> > >
> > > If I allocate pages by using:
> > >
> > > mount -t tmpfs -o huge=pmd tmpfs /mnt/mytmps,
> > >
> > > Then I need the kernel to tell me whether the pages are PMD mapped or
> > > not, as I'm doing here.
> > >
> > > The current implementation is based on what the current THP
> > > implementation is in the kernel, and depending on future changes to
> > > THP I may need to update it in the future. Does that make sense?
> >
> > Well, no.  You're adding (or changing, if you like) a userspace API.
> > We need to be precise about what that userspace API *means*, so that we
> > don't break it in the future when the implementation changes.  You're
> > still being fuzzy above.
> >
> > I have no intention of adding an API like the ones you suggest above to
> > allow the user to specify what size pages to use.  That seems very strange
> > to me; how should the user (or sysadmin, or application) know what size is
> > best for the kernel to use to cache files?  Instead, the kernel observes
> > the usage pattern of the file (through the readahead mechanism) and grows
> > the allocation size to fit what the kernel thinks will be most effective.
> >
> > I do honour some of the existing hints that userspace can provide; eg
> > VM_HUGEPAGE makes the pagefault path allocate PMD sized pages (if it can).
> 
> Right, so since VM_HUGEPAGE makes the kernel allocate PMD mapped THP
> if it can, then I want to know if the page is actually a PMD mapped
> THP or not. The implementation and documentation that I'm adding seem
> consistent with that AFAICT, but sorry if I missed something.

So what userspace cares about is that the kernel is mapping the
memory with a PMD entry; it doesn't care whether the file is
being cached in 2MB (or larger) chunks.  So we can drop the 'THP'
from all of this, and just call the bit the PMD mapping bit?
