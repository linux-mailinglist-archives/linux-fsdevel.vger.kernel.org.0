Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB51A425829
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Oct 2021 18:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242753AbhJGQmg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Oct 2021 12:42:36 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:58410 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242742AbhJGQmf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Oct 2021 12:42:35 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 7ABCE1FE9D;
        Thu,  7 Oct 2021 16:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1633624840; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iFXDHIdmFx9kOd99BpBZhPs9QL1kZsGk7ICGKgi5oo4=;
        b=P8Xk1Z595yZrs6BKXhkLSy617Pk/28mCV4RpLMtibIaiNBrHMQjdjq0pPiqN1cZqnfxQ+A
        s/Nq4zSXnAnqCKum77vSyiENDBnG1Yl5fVHJkcIxh7EDiUOYbNmUQt6iVeDnmcCv8tbDeN
        MHIzTFOhfoWhKJfWRACGPgInluA2SH0=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 168ADA3B84;
        Thu,  7 Oct 2021 16:40:40 +0000 (UTC)
Date:   Thu, 7 Oct 2021 18:40:39 +0200
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
Message-ID: <YV8jB+kwU95hLqTq@dhcp22.suse.cz>
References: <efdffa68-d790-72e4-e6a3-80f2e194d811@nvidia.com>
 <YV1eCu0eZ+gQADNx@dhcp22.suse.cz>
 <6b15c682-72eb-724d-bc43-36ae6b79b91a@redhat.com>
 <CAJuCfpEPBM6ehQXgzp=g4SqtY6iaC8wuZ-CRE81oR1VOq7m4CA@mail.gmail.com>
 <20211006175821.GA1941@duo.ucw.cz>
 <CAJuCfpGuuXOpdYbt3AsNn+WNbavwuEsDfRMYunh+gajp6hOMAg@mail.gmail.com>
 <YV6rksRHr2iSWR3S@dhcp22.suse.cz>
 <92cbfe3b-f3d1-a8e1-7eb9-bab735e782f6@rasmusvillemoes.dk>
 <20211007101527.GA26288@duo.ucw.cz>
 <CAJuCfpGp0D9p3KhOWhcxMO1wEbo-J_b2Anc-oNwdycx4NTRqoA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpGp0D9p3KhOWhcxMO1wEbo-J_b2Anc-oNwdycx4NTRqoA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 07-10-21 09:04:09, Suren Baghdasaryan wrote:
> On Thu, Oct 7, 2021 at 3:15 AM Pavel Machek <pavel@ucw.cz> wrote:
> >
> > Hi!
> >
> > > >> Hmm, so the suggestion is to have some directory which contains files
> > > >> representing IDs, each containing the string name of the associated
> > > >> vma? Then let's say we are creating a new VMA and want to name it. We
> > > >> would have to scan that directory, check all files and see if any of
> > > >> them contain the name we want to reuse the same ID.
> > > >
> > > > I believe Pavel meant something as simple as
> > > > $ YOUR_FILE=$YOUR_IDS_DIR/my_string_name
> > > > $ touch $YOUR_FILE
> > > > $ stat -c %i $YOUR_FILE
> 
> Ah, ok, now I understand the proposal. Thanks for the clarification!
> So, this would use filesystem as a directory for inode->name mappings.
> One rough edge for me is that the consumer would still need to parse
> /proc/$pid/maps and convert [anon:inode] into [anon:name] instead of
> just dumping the content for the user. Would it be acceptable if we
> require the ID provided by prctl() to always be a valid inode and
> show_map_vma() would do the inode-to-filename conversion when
> generating maps/smaps files? I know that inode->dentry is not
> one-to-one mapping but we can simply output the first dentry name.
> WDYT?

No. You do not want to dictate any particular way of the mapping. The
above is just one way to do that without developing any actual mapping
yourself. You just use a filesystem for that. Kernel doesn't and
shouldn't understand the meaning of those numbers. It has no business in
that.

In a way this would be pushing policy into the kernel.

-- 
Michal Hocko
SUSE Labs
