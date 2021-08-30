Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5B7C3FBA90
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Aug 2021 19:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237988AbhH3REY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Aug 2021 13:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237892AbhH3RET (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Aug 2021 13:04:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB81C06175F;
        Mon, 30 Aug 2021 10:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xoB9y/6gb5tvI+qqY/ALh9vMOrQQ9QlAyNC2IX3tc1Y=; b=pqZfVDzw4vekFytMGTd+nWCCR8
        2YO5nnghGG2115wp916H67WC44RJL9F0/DeML/IkIabm+LR2wvHyAok6I3oHh6Axa9yufbd4+LYjx
        doZkgz/i7MqsMhY8LYZePDVgGDNyXh947bd+P/ghJT/ePsYjVsJURruhNp4aEO5QqrLKmIIfyWudl
        8eAY6GmK6ZhUo2HYv4dsXb5gIYpULHzMCdyK8iaEZb1wdlf1UGuYdTlO2yw0au6tLyxDKVBOcJtEm
        vUeyPfSGhfyZEy+jr+e9eMOHZFqPagB/WsG4e4noe+wRFWjha8yZ3lCS5TlSiPaW4GZ3p5kChwJr7
        sILUD6WQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mKkci-000LX7-Qk; Mon, 30 Aug 2021 16:59:09 +0000
Date:   Mon, 30 Aug 2021 17:59:04 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Colin Cross <ccross@google.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Michal Hocko <mhocko@suse.com>,
        Dave Hansen <dave.hansen@intel.com>,
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
        cxfcosmos@gmail.com, LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm <linux-mm@kvack.org>,
        kernel-team <kernel-team@android.com>
Subject: Re: [PATCH v8 2/3] mm: add a field to store names for private
 anonymous memory
Message-ID: <YS0OWFnzLHJViamF@casper.infradead.org>
References: <20210827191858.2037087-1-surenb@google.com>
 <20210827191858.2037087-3-surenb@google.com>
 <YSmVl+DEPrU6oUR4@casper.infradead.org>
 <202108272228.7D36F0373@keescook>
 <CAJuCfpEWc+eTLYp_Xf9exMJCO_cFtvBUzi39+WbcSKZBXHe3SQ@mail.gmail.com>
 <f7117620-28ba-cfa5-b2c6-21812f15e4d6@rasmusvillemoes.dk>
 <CAJuCfpHXF34THa=zVcRozYiLA9QPeNyU09WvyJFKk=ZjCq0ZZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpHXF34THa=zVcRozYiLA9QPeNyU09WvyJFKk=ZjCq0ZZw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 30, 2021 at 09:16:14AM -0700, Suren Baghdasaryan wrote:
> On Mon, Aug 30, 2021 at 1:12 AM Rasmus Villemoes
> <linux@rasmusvillemoes.dk> wrote:
> >
> > On 28/08/2021 23.47, Suren Baghdasaryan wrote:
> > > On Fri, Aug 27, 2021 at 10:52 PM Kees Cook <keescook@chromium.org> wrote:
> > >>
> > >>>> +   case PR_SET_VMA_ANON_NAME:
> > >>>> +           name = strndup_user((const char __user *)arg,
> > >>>> +                               ANON_VMA_NAME_MAX_LEN);
> > >>>> +
> > >>>> +           if (IS_ERR(name))
> > >>>> +                   return PTR_ERR(name);
> > >>>> +
> > >>>> +           for (pch = name; *pch != '\0'; pch++) {
> > >>>> +                   if (!isprint(*pch)) {
> > >>>> +                           kfree(name);
> > >>>> +                           return -EINVAL;
> > >>>
> > >>> I think isprint() is too weak a check.  For example, I would suggest
> > >>> forbidding the following characters: ':', ']', '[', ' '.  Perhaps
> >
> > Indeed. There's also the issue that the kernel's ctype actually
> > implements some almost-but-not-quite latin1, so (some) chars above 0x7f
> > would also pass isprint() - while everybody today expects utf-8, so the
> > ability to put almost arbitrary sequences of chars with the high bit set
> > could certainly confuse some parsers. IOW, don't use isprint() at all,
> > just explicitly check for the byte values that we and up agreeing to
> > allow/forbid.
> >
> > >>> isalnum() would be better?  (permit a-zA-Z0-9)  I wouldn't necessarily
> > >>> be opposed to some punctuation characters, but let's avoid creating
> > >>> confusion.  Do you happen to know which characters are actually in use
> > >>> today?
> > >>
> > >> There's some sense in refusing [, ], and :, but removing " " seems
> > >> unhelpful for reasonable descriptors. As long as weird stuff is escaped,
> > >> I think it's fine. Any parser can just extract with m|\[anon:(.*)\]$|
> > >
> > > I see no issue in forbidding '[' and ']' but whitespace and ':' are
> > > currently used by Android. Would forbidding or escaping '[' and ']' be
> > > enough?
> >
> > how about allowing [0x20, 0x7e] except [0x5b, 0x5d], i.e. all printable
> > (including space) ascii characters, except [ \ ] - the brackets as
> > already discussed, and backslash because then there's nobody who can get
> > confused about whether there's some (and then which?) escaping mechanism
> > in play - "\n" is simply never going to appear. Simple rules, easy to
> > implement, easy to explain in a man page.
> 
> Thanks for the suggestion, Rasmus. I'm all for keeping it simple.
> Kees, Matthew, would that be acceptable?

Yes, I think so.  It permits all kinds of characters that might
be confusing if passed on to something else, but we can't prohibit
everything, and forbidding just these three should remove any confusion
for any parser of /proc.  Little Bobby Tables thanks you.
