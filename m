Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4027F425A74
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Oct 2021 20:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243540AbhJGSOz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Oct 2021 14:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243531AbhJGSOy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Oct 2021 14:14:54 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48B07C061760
        for <linux-fsdevel@vger.kernel.org>; Thu,  7 Oct 2021 11:13:00 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id w11so4407365plz.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Oct 2021 11:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=o4WwfSdG/6KRIuI/J9zyZX24q26V4qiHr2+KV/sCerI=;
        b=UFWObsTY+6ez5xDu9StX0xHOEvb0Awqkv0IojxdYI+PxQZVMQnm1+78GXylVO7eQKc
         unCWRkoNBPz+dlTqyMSHkXjEyBSrxvIoYe8zqlUquJAovzzTTAutOaWA2u7XXWw+cqmI
         8LjuIEZ3xAwyUSETK/5DPVjRVFkuDfq7sRi3w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=o4WwfSdG/6KRIuI/J9zyZX24q26V4qiHr2+KV/sCerI=;
        b=ZVNznrGePbYeGR0NlgCG3l3TDgBzOW3UU8a7f0nQUT4q/SFqR/RW7wzVQNHrCenR5Z
         jdUvmwjsNzfaMoHdLBcMILJ3QBd553Gqzkc5/5Nzr4vgsNP/6J62TnIrFaYnNZgLDSGE
         rQLCDvf0iTnq8MTXSHcNeBvMiKYt4Yu28RAu5RF0M03OSgMT4MH/JPaCHq8lsqUVyGmw
         JvYQvCSfH9WpFsx54lcim2wcytlC7E5FbgbGN6HrReNgcGdoJBD5gpOS+DTt9Awa9rHm
         aVv6uGK8W+XEgXCjOJEc2C98E3Bvl3bgHEluMg3OAdKI1rMRNeZw55mBZuUbUm+10tqi
         t53w==
X-Gm-Message-State: AOAM531DlfEU3oNuNc4EgzguRJO8apZdGU7N8iAdESDrHWKkr/3dsLAU
        hhXwkPc+TlnkvrmUwrjvhU5LBZ8Y4I0+DA==
X-Google-Smtp-Source: ABdhPJzksZUFHw8GIXRDArO1r3B4Ou0wRQUnhd+Drh3yhu6yWxEjZ26oum5HTJ0UupOTrE/3y3xPaQ==
X-Received: by 2002:a17:902:c950:b0:13e:fbf9:7939 with SMTP id i16-20020a170902c95000b0013efbf97939mr5395214pla.65.1633630379611;
        Thu, 07 Oct 2021 11:12:59 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g14sm6529008pjd.24.2021.10.07.11.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 11:12:59 -0700 (PDT)
Date:   Thu, 7 Oct 2021 11:12:58 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Michal Hocko <mhocko@suse.com>, Pavel Machek <pavel@ucw.cz>,
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
Message-ID: <202110071111.DF87B4EE3@keescook>
References: <20211006175821.GA1941@duo.ucw.cz>
 <CAJuCfpGuuXOpdYbt3AsNn+WNbavwuEsDfRMYunh+gajp6hOMAg@mail.gmail.com>
 <YV6rksRHr2iSWR3S@dhcp22.suse.cz>
 <92cbfe3b-f3d1-a8e1-7eb9-bab735e782f6@rasmusvillemoes.dk>
 <20211007101527.GA26288@duo.ucw.cz>
 <CAJuCfpGp0D9p3KhOWhcxMO1wEbo-J_b2Anc-oNwdycx4NTRqoA@mail.gmail.com>
 <YV8jB+kwU95hLqTq@dhcp22.suse.cz>
 <CAJuCfpG-Nza3YnpzvHaS_i1mHds3nJ+PV22xTAfgwvj+42WQNA@mail.gmail.com>
 <YV8u4B8Y9AP9xZIJ@dhcp22.suse.cz>
 <CAJuCfpHAG_C5vE-Xkkrm2kynTFF-Jd06tQoCWehHATL0W2mY_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpHAG_C5vE-Xkkrm2kynTFF-Jd06tQoCWehHATL0W2mY_g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 07, 2021 at 10:50:24AM -0700, Suren Baghdasaryan wrote:
> On Thu, Oct 7, 2021 at 10:31 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Thu 07-10-21 09:58:02, Suren Baghdasaryan wrote:
> > > On Thu, Oct 7, 2021 at 9:40 AM Michal Hocko <mhocko@suse.com> wrote:
> > > >
> > > > On Thu 07-10-21 09:04:09, Suren Baghdasaryan wrote:
> > > > > On Thu, Oct 7, 2021 at 3:15 AM Pavel Machek <pavel@ucw.cz> wrote:
> > > > > >
> > > > > > Hi!
> > > > > >
> > > > > > > >> Hmm, so the suggestion is to have some directory which contains files
> > > > > > > >> representing IDs, each containing the string name of the associated
> > > > > > > >> vma? Then let's say we are creating a new VMA and want to name it. We
> > > > > > > >> would have to scan that directory, check all files and see if any of
> > > > > > > >> them contain the name we want to reuse the same ID.
> > > > > > > >
> > > > > > > > I believe Pavel meant something as simple as
> > > > > > > > $ YOUR_FILE=$YOUR_IDS_DIR/my_string_name
> > > > > > > > $ touch $YOUR_FILE
> > > > > > > > $ stat -c %i $YOUR_FILE
> > > > >
> > > > > Ah, ok, now I understand the proposal. Thanks for the clarification!
> > > > > So, this would use filesystem as a directory for inode->name mappings.
> > > > > One rough edge for me is that the consumer would still need to parse
> > > > > /proc/$pid/maps and convert [anon:inode] into [anon:name] instead of
> > > > > just dumping the content for the user. Would it be acceptable if we
> > > > > require the ID provided by prctl() to always be a valid inode and
> > > > > show_map_vma() would do the inode-to-filename conversion when
> > > > > generating maps/smaps files? I know that inode->dentry is not
> > > > > one-to-one mapping but we can simply output the first dentry name.
> > > > > WDYT?
> > > >
> > > > No. You do not want to dictate any particular way of the mapping. The
> > > > above is just one way to do that without developing any actual mapping
> > > > yourself. You just use a filesystem for that. Kernel doesn't and
> > > > shouldn't understand the meaning of those numbers. It has no business in
> > > > that.
> > > >
> > > > In a way this would be pushing policy into the kernel.
> > >
> > > I can see your point. Any other ideas on how to prevent tools from
> > > doing this id-to-name conversion themselves?
> >
> > I really fail to understand why you really want to prevent them from that.
> > Really, the whole thing is just a cookie that kernel maintains for memory
> > mappings so that two parties can understand what the meaning of that
> > mapping is from a higher level. They both have to agree on the naming
> > but the kernel shouldn't dictate any specific convention because the
> > kernel _doesn't_ _care_. These things are not really anything actionable
> > for the kernel. It is just a metadata.
> 
> The desire is for one of these two parties to be a human who can get
> the data and use it as is without additional conversions.
> /proc/$pid/maps could report FD numbers instead of pathnames, which
> could be converted to pathnames in userspace. However we do not do
> that because pathnames are more convenient for humans to identify a
> specific resource. Same logic applies here IMHO.

Yes, please. It really seems like the folks that are interested in this
feature want strings. (I certainly do.) For those not interested in the
feature, it sounds like a CONFIG to keep it away would be sufficient.
Can we just move forward with that?

-- 
Kees Cook
