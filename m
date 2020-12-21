Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D96C92DFF22
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Dec 2020 19:01:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726026AbgLUSBH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Dec 2020 13:01:07 -0500
Received: from mx2.suse.de ([195.135.220.15]:49680 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbgLUSBG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Dec 2020 13:01:06 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 99C07AD09;
        Mon, 21 Dec 2020 18:00:24 +0000 (UTC)
Date:   Mon, 21 Dec 2020 19:00:19 +0100
From:   Oscar Salvador <osalvador@suse.de>
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
        Michal Hocko <mhocko@suse.com>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        David Hildenbrand <david@redhat.com>, naoya.horiguchi@nec.com,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [External] Re: [PATCH v10 03/11] mm/hugetlb: Free the vmemmap
 pages associated with each HugeTLB page
Message-ID: <20201221180019.GA2884@localhost.localdomain>
References: <20201217121303.13386-1-songmuchun@bytedance.com>
 <20201217121303.13386-4-songmuchun@bytedance.com>
 <20201221091123.GB14343@linux>
 <CAMZfGtVnS=_m4fpGBfDpOpdgzP02QCteUQn-gGiLADWfGiVJ=A@mail.gmail.com>
 <20201221134345.GA19324@linux>
 <CAMZfGtVTqYXOvTHSay-6WS+gtDSCtcN5ksnkj8hJgrUs_XWoWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZfGtVTqYXOvTHSay-6WS+gtDSCtcN5ksnkj8hJgrUs_XWoWQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 21, 2020 at 11:52:30PM +0800, Muchun Song wrote:
> On Mon, Dec 21, 2020 at 9:44 PM Oscar Salvador <osalvador@suse.de> wrote:
> >
> > On Mon, Dec 21, 2020 at 07:25:15PM +0800, Muchun Song wrote:
> >
> > > Should we add a BUG_ON in vmemmap_remap_free() for now?
> > >
> > >         BUG_ON(reuse != start + PAGE_SIZE);
> >
> > I do not think we have to, plus we would be BUG_ing for some specific use
> > case in "generic" function.
> 
> The vmemmap_remap_range() walks page table range [start, end),
> if reuse is equal to (start + PAGE_SIZE), the range can adjust to
> [start - PAGE_SIZE, end). But if not, we need some work to
> implement the "generic" function.
> 
>   - adjust range to [min(start, reuse), end) and call
>     vmemmap_remap_rangeand which skip the hole
>     which is [reuse + PAGE_SIZE, start) or [end, reuse).
>   - call vmemmap_remap_range(reuse, reuse + PAGE_SIZE)
>     to get the reuse page.Then, call vmemmap_remap_range(start, end)
>     again to remap.
> 
> Which one do you prefer?

I would not overcomplicate things at this stage.
Just follow my sugestion and add a BUG_ON as you said, that might be the
easier way now.
We can overthink this in the future when some other usecases come
around, right?

Thanks


-- 
Oscar Salvador
SUSE L3
