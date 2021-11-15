Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C64C2451B6C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Nov 2021 00:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344320AbhKPABy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Nov 2021 19:01:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245325AbhKOX7w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Nov 2021 18:59:52 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B6DC03AA28
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Nov 2021 14:50:38 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id l8so18363223ilv.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Nov 2021 14:50:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MbJjt/ncW6eOrgGWMNW+Eh6/4jlzS3HIFhQ82o7o1ZE=;
        b=NS9lOPe9i5akbD6ebXCrGb+sx/9H3cRucOxDp7O8Ex7janJgSxxGfTF1PuUC87V/Ai
         4ATPuckrf4HOO4HhPolfuUO0xfapDfmydxr5ROYfJGTXvz70aZqo1qv8TBP4TAy+hwY+
         01AbCzh3jA/wwIyvVmdOve1kR34KIPnV02+3zmA8s3pUIcUAx8pjY5ks2NjOlIw2f8Fo
         DmFHhwJmC02NwO+qta37QCnY5eyIJbXsd29hsdciEdg9pWduG7t3NSXhnOPhGu8Neflx
         +rhpCbOE6MuJVe9aUjK5QRTsdGvIF0pj9Zg0Kzsc3WSwA5RgNlkr20JJ8Lqcfa1XpPS0
         8ulg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MbJjt/ncW6eOrgGWMNW+Eh6/4jlzS3HIFhQ82o7o1ZE=;
        b=gp3GZIltCeNUJ1IHpJhsj4Tf7juXtnRZNo0rgiJSH1ySoKUYMvGyyHQmjAIUZWqdQu
         HepyKkKyQdsUtNx0CnCAFKKMPzRuHdJ4Rc/5njNTxsonl/bOK79m+fU117ZPX69VfGpn
         oWGXsTJ0AqfCteUXvXh/TUPVknsfpDO6iOzHl0vKPDa/akprLxY0iz3c4Np2xSKaaq84
         C252GlF1no5IsK/XjoWUB9CBfL+j/YaTdBI+PjyClXn2tVTIp9sHEF5gFYCH1k/bgUvW
         cOsSoJCyBQ/of1hBgflQfqClJuaK0bv5S0OclDQR7OC1AFIzcYPy0Pqz3shHMmp2lf8r
         R+hw==
X-Gm-Message-State: AOAM530ooBrljsGuCP0idr+8wisqQ0OsGi4fHvoRRJIVQ8jz2lzzuwuC
        e76yXXjw2raKxs3ueg2BbJ953alyE959I8tqIXsBdA==
X-Google-Smtp-Source: ABdhPJwFUJw+E4PVvoQj8Sluj9XmoKPe/cZLTm+RfdBC45c2ftLWfz10J0gBd0rqheQ6j55AB2/Z8l0cLhcRf5AFg1Y=
X-Received: by 2002:a92:6b0b:: with SMTP id g11mr1622656ilc.146.1637016638060;
 Mon, 15 Nov 2021 14:50:38 -0800 (PST)
MIME-Version: 1.0
References: <20211107235754.1395488-1-almasrymina@google.com>
 <YYtuqsnOSxA44AUX@t490s> <CAHS8izP9zJYfqmDouA1otnD-CsQtWJSta0KhOQq81qLSTOHB4Q@mail.gmail.com>
 <YY4bFPkfUhlpUqvo@xz-m1.local>
In-Reply-To: <YY4bFPkfUhlpUqvo@xz-m1.local>
From:   Mina Almasry <almasrymina@google.com>
Date:   Mon, 15 Nov 2021 14:50:26 -0800
Message-ID: <CAHS8izP7_BBH9NGz3XoL2=xVniH6REor=biqDSZ4wR=NaFS-8A@mail.gmail.com>
Subject: Re: [PATCH v4] mm: Add PM_HUGE_THP_MAPPING to /proc/pid/pagemap
To:     Peter Xu <peterx@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Paul E . McKenney" <paulmckrcu@fb.com>,
        Yu Zhao <yuzhao@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ivan Teterevkov <ivan.teterevkov@nutanix.com>,
        Florian Schmidt <florian.schmidt@nutanix.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 11, 2021 at 11:41 PM Peter Xu <peterx@redhat.com> wrote:
>
> On Wed, Nov 10, 2021 at 09:42:25AM -0800, Mina Almasry wrote:
> > Sorry, yes I should update the commit message with this info. The
> > issues with smaps are:
> > 1. Performance: I've pinged our network service folks to obtain a
> > rough perf comparison but I haven't been able to get one. I can try to
> > get a performance measurement myself but Peter seems to be also seeing
> > this.
>
> No I was not seeing any real issues in my environment, but I remembered people
> complaining about it because smaps needs to walk the whole memory of the
> process, then if one program is only interested in some small portion of the
> whole memory, it'll be slow because smaps will still need to walk all the
> memory anyway.
>
> > 2. smaps output is human readable and a bit convoluted for userspace to parse.
>
> IMHO this is not a major issue.  AFAIK lots of programs will still try to parse
> human readable output like smaps to get some solid numbers.  It's just that
> it'll be indeed an perf issue if it's only a part of the memory that is of
> interest.
>
> Could we consider exporting a new smaps interface that:
>
>   1. allows to specify a range of memory, and,
>   2. expose information as "struct mem_size_stats" in binary format
>      (we may want to replace "unsigned long" with "u64", then also have some
>       versioning or having a "size" field for the struct, though; seems doable)
>
> I'm wondering whether this could be helpful in even more scenarios.
>

Sorry could you elaborate more? How do we allow users to specify the
range? Are you envisioning a new added syscall? Or is there some way
for users to pass the range to the existing /proc/pid/smaps that I'm
missing?

On Thu, Nov 11, 2021 at 11:43 PM Peter Xu <peterx@redhat.com> wrote:
>
> On Wed, Nov 10, 2021 at 09:50:13AM -0800, Mina Almasry wrote:
> > On Tue, Nov 9, 2021 at 11:03 PM Peter Xu <peterx@redhat.com> wrote:
> > >
> > > The ending "_MAPPING" seems redundant to me, how about just call it "PM_THP" or
> > > "PM_HUGE" (as THP also means HUGE already)?
> > >
> >
> > So I want to make it clear that the flag is set only when the page is
> > PMD mappend and is a THP (not hugetlbfs or some other PMD device
> > mapping). PM_THP would imply the flag is set only if the underlying
> > page is THP without regard to whether it's actually PMD mapped or not.
>
> I see, that's fine.
>
> However as I mentioned I still think HUGE and THP dup with each other.
> Meanwhile, "MAPPING" does not sound like a boolean status on whether it's thp
> mapped..
>
> If you still prefer this approach, how about PM_THP_MAPPED?

PM_THP_MAPPED sounds good to me.

TBH I think I still prefer this approach because it's a very simple 2
line patch which addresses the concrete use case I have well. I'm not
too familiar with the smaps code to be honest but I think adding a
range-based smaps API will be a sizeable patch to add a syscall,
handle a stable interface, and handle cases where the memory range
doesn't match a VMA boundary. I'm not sure the performance benefit
would justify this patch and I'm not sure the extra info from smaps
would be widely useful. However if you insist and folks believe this
is the better approach I can prototype a range-based smaps and test
its performance to see if it works for us as well, just let me know
what kind of API you're envisioning.

>
> --
> Peter Xu
>
