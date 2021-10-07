Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EBF1425987
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Oct 2021 19:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242794AbhJGRdV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Oct 2021 13:33:21 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:34806 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242949AbhJGRdJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Oct 2021 13:33:09 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id DE10E200F8;
        Thu,  7 Oct 2021 17:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1633627873; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/83RDrqHPpl87OGAurh8rfbtU/YEjkgyJAZ6Fte+y4Y=;
        b=jiftm9rUlvRqDadj+/PG/GyTAHxCwqYmZQS//pQi+8kj7fDoqfsiM11hG0RoVgR0Su5Apc
        OT329neI0OF04fxbNZlPIA5H1VbCG98tjWz9FTg6jr7BLrdU27CAUaJZS4cxJK46uq+7E6
        Afam4a2bEi+IY8YdyR+kmBQG45W91F4=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 2F184A3B85;
        Thu,  7 Oct 2021 17:31:13 +0000 (UTC)
Date:   Thu, 7 Oct 2021 19:31:12 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        David Hildenbrand <david@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Colin Cross <ccross@google.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Kees Cook <keescook@chromium.org>,
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
Message-ID: <YV8u4B8Y9AP9xZIJ@dhcp22.suse.cz>
References: <6b15c682-72eb-724d-bc43-36ae6b79b91a@redhat.com>
 <CAJuCfpEPBM6ehQXgzp=g4SqtY6iaC8wuZ-CRE81oR1VOq7m4CA@mail.gmail.com>
 <20211006175821.GA1941@duo.ucw.cz>
 <CAJuCfpGuuXOpdYbt3AsNn+WNbavwuEsDfRMYunh+gajp6hOMAg@mail.gmail.com>
 <YV6rksRHr2iSWR3S@dhcp22.suse.cz>
 <92cbfe3b-f3d1-a8e1-7eb9-bab735e782f6@rasmusvillemoes.dk>
 <20211007101527.GA26288@duo.ucw.cz>
 <CAJuCfpGp0D9p3KhOWhcxMO1wEbo-J_b2Anc-oNwdycx4NTRqoA@mail.gmail.com>
 <YV8jB+kwU95hLqTq@dhcp22.suse.cz>
 <CAJuCfpG-Nza3YnpzvHaS_i1mHds3nJ+PV22xTAfgwvj+42WQNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpG-Nza3YnpzvHaS_i1mHds3nJ+PV22xTAfgwvj+42WQNA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 07-10-21 09:58:02, Suren Baghdasaryan wrote:
> On Thu, Oct 7, 2021 at 9:40 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Thu 07-10-21 09:04:09, Suren Baghdasaryan wrote:
> > > On Thu, Oct 7, 2021 at 3:15 AM Pavel Machek <pavel@ucw.cz> wrote:
> > > >
> > > > Hi!
> > > >
> > > > > >> Hmm, so the suggestion is to have some directory which contains files
> > > > > >> representing IDs, each containing the string name of the associated
> > > > > >> vma? Then let's say we are creating a new VMA and want to name it. We
> > > > > >> would have to scan that directory, check all files and see if any of
> > > > > >> them contain the name we want to reuse the same ID.
> > > > > >
> > > > > > I believe Pavel meant something as simple as
> > > > > > $ YOUR_FILE=$YOUR_IDS_DIR/my_string_name
> > > > > > $ touch $YOUR_FILE
> > > > > > $ stat -c %i $YOUR_FILE
> > >
> > > Ah, ok, now I understand the proposal. Thanks for the clarification!
> > > So, this would use filesystem as a directory for inode->name mappings.
> > > One rough edge for me is that the consumer would still need to parse
> > > /proc/$pid/maps and convert [anon:inode] into [anon:name] instead of
> > > just dumping the content for the user. Would it be acceptable if we
> > > require the ID provided by prctl() to always be a valid inode and
> > > show_map_vma() would do the inode-to-filename conversion when
> > > generating maps/smaps files? I know that inode->dentry is not
> > > one-to-one mapping but we can simply output the first dentry name.
> > > WDYT?
> >
> > No. You do not want to dictate any particular way of the mapping. The
> > above is just one way to do that without developing any actual mapping
> > yourself. You just use a filesystem for that. Kernel doesn't and
> > shouldn't understand the meaning of those numbers. It has no business in
> > that.
> >
> > In a way this would be pushing policy into the kernel.
> 
> I can see your point. Any other ideas on how to prevent tools from
> doing this id-to-name conversion themselves?

I really fail to understand why you really want to prevent them from that.
Really, the whole thing is just a cookie that kernel maintains for memory
mappings so that two parties can understand what the meaning of that
mapping is from a higher level. They both have to agree on the naming
but the kernel shouldn't dictate any specific convention because the
kernel _doesn't_ _care_. These things are not really anything actionable
for the kernel. It is just a metadata.

-- 
Michal Hocko
SUSE Labs
