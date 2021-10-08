Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE854264B1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Oct 2021 08:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbhJHGgr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Oct 2021 02:36:47 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:46878 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbhJHGgp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Oct 2021 02:36:45 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 253B7223F3;
        Fri,  8 Oct 2021 06:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1633674889; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CcFIsT1c20GjUuqiYz9PJ+eUk+2oJK91pSz23fk2I9w=;
        b=X3yuN8h8Wp2n/qIrLAm1bgF3pbs0djN0Upa2GuSzWd7ZMvhNjTMfNGafyZfFa85St77ULb
        XlR1cukpoUA5j0NlftLczY56Cgls+aCdeZKzQw2YiMOjkGCPiBTNrmZhFC5EIWmx58V6OD
        Vzq+qZOju9bMpBwfXY2F+X0JZ8+Tp94=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 0E692A3B84;
        Fri,  8 Oct 2021 06:34:48 +0000 (UTC)
Date:   Fri, 8 Oct 2021 08:34:47 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Pavel Machek <pavel@ucw.cz>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        David Hildenbrand <david@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Colin Cross <ccross@google.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Randy Dunlap <rdunlap@infradead.org>,
        Kalesh Singh <kaleshsingh@google.com>,
        Peter Xu <peterx@redhat.com>, rppt@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        vincenzo.frascino@arm.com,
        Chinwen Chang =?utf-8?B?KOW8temMpuaWhyk=?= 
        <chinwen.chang@mediatek.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jann Horn <jannh@google.com>, apopple@nvidia.com,
        Yu Zhao <yuzhao@google.com>, Will Deacon <will@kernel.org>,
        fenghua.yu@intel.com, thunder.leizhen@huawei.com,
        Hugh Dickins <hughd@google.com>, feng.tang@intel.com,
        Jason Gunthorpe <jgg@ziepe.ca>, Roman Gushchin <guro@fb.com>,
        Thomas Gleixner <tglx@linutronix.de>, krisman@collabora.com,
        Chris Hyser <chris.hyser@oracle.com>,
        Peter Collingbourne <pcc@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Jens Axboe <axboe@kernel.dk>, legion@kernel.org,
        Rolf Eike Beer <eb@emlix.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Thomas Cedeno <thomascedeno@google.com>, sashal@kernel.org,
        cxfcosmos@gmail.com, LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm <linux-mm@kvack.org>,
        kernel-team <kernel-team@android.com>
Subject: Re: [PATCH v10 3/3] mm: add anonymous vma name refcounting
Message-ID: <YV/mhyWH1ZwWazdE@dhcp22.suse.cz>
References: <CAJuCfpGuuXOpdYbt3AsNn+WNbavwuEsDfRMYunh+gajp6hOMAg@mail.gmail.com>
 <YV6rksRHr2iSWR3S@dhcp22.suse.cz>
 <92cbfe3b-f3d1-a8e1-7eb9-bab735e782f6@rasmusvillemoes.dk>
 <20211007101527.GA26288@duo.ucw.cz>
 <CAJuCfpGp0D9p3KhOWhcxMO1wEbo-J_b2Anc-oNwdycx4NTRqoA@mail.gmail.com>
 <YV8jB+kwU95hLqTq@dhcp22.suse.cz>
 <CAJuCfpG-Nza3YnpzvHaS_i1mHds3nJ+PV22xTAfgwvj+42WQNA@mail.gmail.com>
 <YV8u4B8Y9AP9xZIJ@dhcp22.suse.cz>
 <CAJuCfpHAG_C5vE-Xkkrm2kynTFF-Jd06tQoCWehHATL0W2mY_g@mail.gmail.com>
 <202110071111.DF87B4EE3@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202110071111.DF87B4EE3@keescook>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 07-10-21 11:12:58, Kees Cook wrote:
> On Thu, Oct 07, 2021 at 10:50:24AM -0700, Suren Baghdasaryan wrote:
> > On Thu, Oct 7, 2021 at 10:31 AM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Thu 07-10-21 09:58:02, Suren Baghdasaryan wrote:
> > > > On Thu, Oct 7, 2021 at 9:40 AM Michal Hocko <mhocko@suse.com> wrote:
> > > > >
> > > > > On Thu 07-10-21 09:04:09, Suren Baghdasaryan wrote:
> > > > > > On Thu, Oct 7, 2021 at 3:15 AM Pavel Machek <pavel@ucw.cz> wrote:
> > > > > > >
> > > > > > > Hi!
> > > > > > >
> > > > > > > > >> Hmm, so the suggestion is to have some directory which contains files
> > > > > > > > >> representing IDs, each containing the string name of the associated
> > > > > > > > >> vma? Then let's say we are creating a new VMA and want to name it. We
> > > > > > > > >> would have to scan that directory, check all files and see if any of
> > > > > > > > >> them contain the name we want to reuse the same ID.
> > > > > > > > >
> > > > > > > > > I believe Pavel meant something as simple as
> > > > > > > > > $ YOUR_FILE=$YOUR_IDS_DIR/my_string_name
> > > > > > > > > $ touch $YOUR_FILE
> > > > > > > > > $ stat -c %i $YOUR_FILE
> > > > > >
> > > > > > Ah, ok, now I understand the proposal. Thanks for the clarification!
> > > > > > So, this would use filesystem as a directory for inode->name mappings.
> > > > > > One rough edge for me is that the consumer would still need to parse
> > > > > > /proc/$pid/maps and convert [anon:inode] into [anon:name] instead of
> > > > > > just dumping the content for the user. Would it be acceptable if we
> > > > > > require the ID provided by prctl() to always be a valid inode and
> > > > > > show_map_vma() would do the inode-to-filename conversion when
> > > > > > generating maps/smaps files? I know that inode->dentry is not
> > > > > > one-to-one mapping but we can simply output the first dentry name.
> > > > > > WDYT?
> > > > >
> > > > > No. You do not want to dictate any particular way of the mapping. The
> > > > > above is just one way to do that without developing any actual mapping
> > > > > yourself. You just use a filesystem for that. Kernel doesn't and
> > > > > shouldn't understand the meaning of those numbers. It has no business in
> > > > > that.
> > > > >
> > > > > In a way this would be pushing policy into the kernel.
> > > >
> > > > I can see your point. Any other ideas on how to prevent tools from
> > > > doing this id-to-name conversion themselves?
> > >
> > > I really fail to understand why you really want to prevent them from that.
> > > Really, the whole thing is just a cookie that kernel maintains for memory
> > > mappings so that two parties can understand what the meaning of that
> > > mapping is from a higher level. They both have to agree on the naming
> > > but the kernel shouldn't dictate any specific convention because the
> > > kernel _doesn't_ _care_. These things are not really anything actionable
> > > for the kernel. It is just a metadata.
> > 
> > The desire is for one of these two parties to be a human who can get
> > the data and use it as is without additional conversions.
> > /proc/$pid/maps could report FD numbers instead of pathnames, which
> > could be converted to pathnames in userspace. However we do not do
> > that because pathnames are more convenient for humans to identify a
> > specific resource. Same logic applies here IMHO.
> 
> Yes, please. It really seems like the folks that are interested in this
> feature want strings. (I certainly do.)

I am sorry but there were no strong arguments mentioned for strings so
far. Effectively string require a more complex and more resource hungry
solution. The only advantage is that strings are nicer to read for
humans.

There hasn't been any plan presented for actual naming convention or how
those names would be used in practice. Except for a more advanced
resource management and that sounds like something that can work with
ids just fine.

> For those not interested in the
> feature, it sounds like a CONFIG to keep it away would be sufficient.

CONFIG is not an answer here as already pointed out. Distro kernels will
be forced to enable this because there might be somebody to use this
feature.

Initially I was not really feeling strongly one way or other but more we
are discussing the topic the more I see that strings have a very weak
justification behind.

-- 
Michal Hocko
SUSE Labs
