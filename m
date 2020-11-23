Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC1202C00B3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Nov 2020 08:41:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbgKWHku (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Nov 2020 02:40:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:44606 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726302AbgKWHku (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Nov 2020 02:40:50 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1606117249; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qDKd/j/QMUNk+/p2NwiTiy96ayOEs3BuwGOqaQL5s+c=;
        b=ezVAS4q+yY3KB7/f2FALGK82bgAjW+b5kVyFv4xuqGO6lb82TcYoJxP6KhSaKImDGnkbAt
        Tt8TWcoLgHPwD61QMXVwnQ/J1Q79H3FMW7WYKYnCzjqUNbRqHvhTAUbO6Bc01xLi42FhIi
        DkFUPz+KuuqcjYnSGwamDnkv23XrGpU=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D9D65ABCE;
        Mon, 23 Nov 2020 07:40:48 +0000 (UTC)
Date:   Mon, 23 Nov 2020 08:40:46 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org,
        Peter Zijlstra <peterz@infradead.org>, viro@zeniv.linux.org.uk,
        Andrew Morton <akpm@linux-foundation.org>, paulmck@kernel.org,
        mchehab+huawei@kernel.org, pawan.kumar.gupta@linux.intel.com,
        Randy Dunlap <rdunlap@infradead.org>, oneukum@suse.com,
        anshuman.khandual@arm.com, jroedel@suse.de,
        Mina Almasry <almasrymina@google.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oscar Salvador <osalvador@suse.de>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [External] Re: [PATCH v5 00/21] Free some vmemmap pages of
 hugetlb page
Message-ID: <20201123074046.GB27488@dhcp22.suse.cz>
References: <20201120064325.34492-1-songmuchun@bytedance.com>
 <20201120084202.GJ3200@dhcp22.suse.cz>
 <CAMZfGtWJXni21J=Yn55gksKy9KZnDScCjKmMasNz5XUwx3OcKw@mail.gmail.com>
 <20201120131129.GO3200@dhcp22.suse.cz>
 <CAMZfGtWNDJWWTtpUDtngtgNiOoSd6sJpdAB6MnJW8KH0gePfYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZfGtWNDJWWTtpUDtngtgNiOoSd6sJpdAB6MnJW8KH0gePfYA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 20-11-20 23:44:26, Muchun Song wrote:
> On Fri, Nov 20, 2020 at 9:11 PM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Fri 20-11-20 20:40:46, Muchun Song wrote:
> > > On Fri, Nov 20, 2020 at 4:42 PM Michal Hocko <mhocko@suse.com> wrote:
> > > >
> > > > On Fri 20-11-20 14:43:04, Muchun Song wrote:
> > > > [...]
> > > >
> > > > Thanks for improving the cover letter and providing some numbers. I have
> > > > only glanced through the patchset because I didn't really have more time
> > > > to dive depply into them.
> > > >
> > > > Overall it looks promissing. To summarize. I would prefer to not have
> > > > the feature enablement controlled by compile time option and the kernel
> > > > command line option should be opt-in. I also do not like that freeing
> > > > the pool can trigger the oom killer or even shut the system down if no
> > > > oom victim is eligible.
> > >
> > > Hi Michal,
> > >
> > > I have replied to you about those questions on the other mail thread.
> > >
> > > Thanks.
> > >
> > > >
> > > > One thing that I didn't really get to think hard about is what is the
> > > > effect of vmemmap manipulation wrt pfn walkers. pfn_to_page can be
> > > > invalid when racing with the split. How do we enforce that this won't
> > > > blow up?
> > >
> > > This feature depends on the CONFIG_SPARSEMEM_VMEMMAP,
> > > in this case, the pfn_to_page can work. The return value of the
> > > pfn_to_page is actually the address of it's struct page struct.
> > > I can not figure out where the problem is. Can you describe the
> > > problem in detail please? Thanks.
> >
> > struct page returned by pfn_to_page might get invalid right when it is
> > returned because vmemmap could get freed up and the respective memory
> > released to the page allocator and reused for something else. See?
> 
> If the HugeTLB page is already allocated from the buddy allocator,
> the struct page of the HugeTLB can be freed? Does this exist?

Nope, struct pages only ever get deallocated when the respective memory
(they describe) is hotremoved via hotplug.

> If yes, how to free the HugeTLB page to the buddy allocator
> (cannot access the struct page)?

But I do not follow how that relates to my concern above.

-- 
Michal Hocko
SUSE Labs
