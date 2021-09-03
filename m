Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED133FFF6B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Sep 2021 13:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349325AbhICLuK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Sep 2021 07:50:10 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:50590 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349322AbhICLuJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Sep 2021 07:50:09 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 870801FD7C;
        Fri,  3 Sep 2021 11:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1630669748; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VfAx4578eKO6ywPf0rOdh/3/SGLIJXIZHm6hFxGY/Wo=;
        b=jIxthijMtzQRiBd9X04NvrXa4xjN0DmTCz8VK6V20CtXdSkT5hWK2bjFKThlBBIxIYpYBs
        XVuq0BMkNXLHVaexin+1yL3VQ7y/QJ6t8VyFxBSZkKS0tTrgKZAJSxyUhfWO32ry+EXJgQ
        Vv1bPyvpdPTSlRsCCtivoNs5juTxt58=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 8CEBDA3BB6;
        Fri,  3 Sep 2021 11:49:06 +0000 (UTC)
Date:   Fri, 3 Sep 2021 13:49:01 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
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
        John Hubbard <jhubbard@nvidia.com>,
        Yu Zhao <yuzhao@google.com>, Will Deacon <will@kernel.org>,
        fenghua.yu@intel.com, thunder.leizhen@huawei.com,
        Hugh Dickins <hughd@google.com>, feng.tang@intel.com,
        Jason Gunthorpe <jgg@ziepe.ca>, Roman Gushchin <guro@fb.com>,
        Thomas Gleixner <tglx@linutronix.de>, krisman@collabora.com,
        chris.hyser@oracle.com, Peter Collingbourne <pcc@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Jens Axboe <axboe@kernel.dk>, legion@kernel.org,
        Rolf Eike Beer <eb@emlix.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Thomas Cedeno <thomascedeno@google.com>, sashal@kernel.org,
        cxfcosmos@gmail.com, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm <linux-mm@kvack.org>,
        kernel-team <kernel-team@android.com>
Subject: Re: [PATCH v8 2/3] mm: add a field to store names for private
 anonymous memory
Message-ID: <YTILrVHLMBky9YjP@dhcp22.suse.cz>
References: <20210827191858.2037087-1-surenb@google.com>
 <20210827191858.2037087-3-surenb@google.com>
 <YS81abHD8KZMrX8D@dhcp22.suse.cz>
 <CAJuCfpHWCtqCcuZdyfc4-virtynOMv2f_iU=OJUB_6b2Xz+k9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpHWCtqCcuZdyfc4-virtynOMv2f_iU=OJUB_6b2Xz+k9g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 01-09-21 08:42:29, Suren Baghdasaryan wrote:
> On Wed, Sep 1, 2021 at 1:10 AM 'Michal Hocko' via kernel-team
> <kernel-team@android.com> wrote:
> >
> > On Fri 27-08-21 12:18:57, Suren Baghdasaryan wrote:
> > [...]
> > > +static void replace_vma_anon_name(struct vm_area_struct *vma, const char *name)
> > > +{
> > > +     if (!name) {
> > > +             free_vma_anon_name(vma);
> > > +             return;
> > > +     }
> > > +
> > > +     if (vma->anon_name) {
> > > +             /* Should never happen, to dup use dup_vma_anon_name() */
> > > +             WARN_ON(vma->anon_name == name);
> >
> > What is the point of this warning?
> 
> I wanted to make sure replace_vma_anon_name() is not used from inside
> vm_area_dup() or some similar place (does not exist today but maybe in
> the future) where "new" vma is a copy of "orig" vma and
> new->anon_name==orig->anon_name. If someone by mistake calls
> replace_vma_anon_name(new, orig->anon_name) and
> new->anon_name==orig->anon_name then they will keep pointing to the
> same name pointer, which breaks an assumption that ->anon_name
> pointers are not shared among vmas even if the string is the same.
> That would eventually lead to use-after-free error. After the next
> patch implementing refcounting, the similar situation would lead to
> both new and orig vma pointing to the same anon_vma_name structure
> without raising the refcount, which would also lead to use-after-free
> error. That's why the above comment asks to use dup_vma_anon_name() if
> this warning ever happens.
> I can remove the warning but I thought the problem is subtle enough to
> put some safeguards.

This to me sounds very much like a debugging code that shouldn't make it
to the final patch to be merged. I do see your point of an early
diagnostic but we are talking about an internal MM code and that is not
really designed to be robust against its own failures so I do not see
why this should be any special.
-- 
Michal Hocko
SUSE Labs
