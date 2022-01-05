Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DDDB484D23
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jan 2022 05:40:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237375AbiAEEkA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jan 2022 23:40:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237365AbiAEEj7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jan 2022 23:39:59 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 801F9C061761;
        Tue,  4 Jan 2022 20:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=i6uYjQM6a+w//FCMGzjfe0KtBTgocro5T9Tkc6vxins=; b=NeTlfINWf+IFbE4Az2T9/P0eVE
        aA5vY9D1w5ArKSl3EJx0PSAVrzmxBcLW47YG54b8dGACGKjZGvCu79NSwszQomhyOR2LVisqgGrm4
        LBIrQfjljvI+LUysEmND531G7CTV9G49mDkbD3TXufevdcKM1co5Dl6HV2WHbjHhoTGvDA2gGFPFm
        3r5wbQSrjFEXTjDsQHaiaJnDipB7NhxTf9Q6UHZLZb+leRtyPON4/yGzNkbI7oF1tyqF3V98EfxDi
        ZUgr8zYAW8M4DenCKbzNG2PdE+NFgQzp4e+kmYCaHV9iJOnv6i8BfTUXYHh1GiTD4pg0D8yBGr7Nt
        Piw6dRoA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n4y5P-00EGSs-US; Wed, 05 Jan 2022 04:39:43 +0000
Date:   Wed, 5 Jan 2022 04:39:43 +0000
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
Message-ID: <YdUhD8ju+y0TGQzq@casper.infradead.org>
References: <20211123000102.4052105-1-almasrymina@google.com>
 <YaMBGQGNLqPd6D6f@casper.infradead.org>
 <CAHS8izM5as_AmN4bSmZd1P7aSXZ86VAfXgyooZivyf7-E5gZcQ@mail.gmail.com>
 <CAHS8izNw87-L=rEwJF7_9WCaAcXLn2dUe68h_SbLErJoSUDzzg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHS8izNw87-L=rEwJF7_9WCaAcXLn2dUe68h_SbLErJoSUDzzg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 04, 2022 at 03:04:31PM -0800, Mina Almasry wrote:
> On Mon, Dec 13, 2021 at 4:22 PM Mina Almasry <almasrymina@google.com> wrote:
> >
> > On Sat, Nov 27, 2021 at 8:10 PM Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > On Mon, Nov 22, 2021 at 04:01:02PM -0800, Mina Almasry wrote:
> > > > Add PM_THP_MAPPED MAPPING to allow userspace to detect whether a given virt
> > > > address is currently mapped by a transparent huge page or not.  Example
> > > > use case is a process requesting THPs from the kernel (via a huge tmpfs
> > > > mount for example), for a performance critical region of memory.  The
> > > > userspace may want to query whether the kernel is actually backing this
> > > > memory by hugepages or not.
> > >
> > > But what is userspace going to _do_ differently if the kernel hasn't
> > > backed the memory with huge pages?
> >
> > Sorry for the late reply here.
> >
> > My plan is to expose this information as metrics right now and:
> > 1. Understand the kind of hugepage backing we're actually getting if any.
> > 2. If there are drops in hugepage backing we can investigate the
> > cause, whether it's due to normal memory fragmentation or some
> > bug/issue.
> > 3. Schedule machines for reboots to defragment the memory if the
> > hugepage backing is too low.
> > 4. Possibly motivate future work to improve hugepage backing if our
> > numbers are too low.
> 
> Friendly ping on this. It has been reviewed by a few folks and after
> Matthew had questions about the use case which I've answered in the
> email above. Matthew, are you opposed to this patch?

I'm not convinced you need more than the existing stats
(THP_FAULT_FALLBACK) for the information you claim to want.
