Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A192B2FF7CA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Jan 2021 23:16:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbhAUWPw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Jan 2021 17:15:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbhAUWPI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Jan 2021 17:15:08 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D163C06174A
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Jan 2021 14:14:27 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id u17so7348891iow.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Jan 2021 14:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O2R6G+JQomFrmP9HO7+cEOKXT8jw8uCDjvCWyH87E3w=;
        b=FozQaxbvtJXB+IozviQH2OUL+/gJEXx3LdIg5KlULHJ/JcijC3OTsPE0MwypuN3fqo
         O3zhoj3RuyZmmxvJKd/WbU6AIfeLwcnOqdrFcu3dMWp5qwK3yr0GSYc4gBw7l8uAu2AB
         MyKJopx+bY1jlZX2i4Qqx26ZUjVsQAYoeM8nI2EM+z7JYv4c/n9kK71N6N6utGRBzB+J
         WFsOFwvNoIZL1r5txOYFCPYvT1KczLHV5VHqIuhZ7qIdW/3bwtPgKBc8Woi+7msRmNgz
         FDMzIltl1bnCnGBOW0qUoBy8SePB68bkYe2R53WNLe2FF8KCtNRSdR21g2faMHF9Qayx
         y2dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O2R6G+JQomFrmP9HO7+cEOKXT8jw8uCDjvCWyH87E3w=;
        b=qbx1aUZrLsSa60r7hs4VVL0sX8uemUYcI9IUw4jg25sUXNVgy/IrKP0B3kj5Sr2wzz
         ARuUcDtwLb7E8q+CdtUZhahF5YkCsJuAKvsbioh5PYvFu6alzwe3DktZ4UYURVcK698/
         e6dqn9OFaSHzgIKmk/QRaPcMkcRyfTp8Qq/wufMYcAFIldwARl6BoXGp/kGWBLdFcZ8u
         iFjbp9yGB3rKNRPAku7kSuXVafVcIH9julGk44MCgHQJ07C0wzHsm2ekmEV6n05Rl5mA
         lgqCRT0eLWaMW7x0fXnD29FlUGXjDvh234zpCkgEr0nycUy21sB3GGYuG5otWvn0x4yW
         3EFg==
X-Gm-Message-State: AOAM533/IU/yx8ijYLorL5C+ZEL6rzGvwW/wTzj2QnYBSoUHBv5oeXuY
        WTgZQEFVHS0c3o7MDtWy6oov6Xrhzs6rtVacdD5SyQ==
X-Google-Smtp-Source: ABdhPJzTjt3TB+ykOZeLyHdIzwOleNs/mipT9Li327q3wBoTK1DHufVnbXilw914LnUDbHj3R79jXmVoKNYblt4kgD8=
X-Received: by 2002:a02:7610:: with SMTP id z16mr1116868jab.99.1611267266926;
 Thu, 21 Jan 2021 14:14:26 -0800 (PST)
MIME-Version: 1.0
References: <20210115190451.3135416-1-axelrasmussen@google.com> <20210121191241.GG260413@xz-x1>
In-Reply-To: <20210121191241.GG260413@xz-x1>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Thu, 21 Jan 2021 14:13:50 -0800
Message-ID: <CAJHvVch3iK_UcwpwL5p3LWQAZo_iyLMVxsMTf_GCAStqoQxmTA@mail.gmail.com>
Subject: Re: [PATCH 0/9] userfaultfd: add minor fault handling
To:     Peter Xu <peterx@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chinwen Chang <chinwen.chang@mediatek.com>,
        Huang Ying <ying.huang@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Michel Lespinasse <walken@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>, Shaohua Li <shli@fb.com>,
        Shawn Anastasio <shawn@anastas.io>,
        Steven Rostedt <rostedt@goodmis.org>,
        Steven Price <steven.price@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Linux MM <linux-mm@kvack.org>,
        Adam Ruprecht <ruprecht@google.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Oliver Upton <oupton@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 21, 2021 at 11:12 AM Peter Xu <peterx@redhat.com> wrote:
>
> On Fri, Jan 15, 2021 at 11:04:42AM -0800, Axel Rasmussen wrote:
> > UFFDIO_COPY and UFFDIO_ZEROPAGE cannot be used to resolve minor faults. Without
> > modifications, the existing codepath assumes a new page needs to be allocated.
> > This is okay, since userspace must have a second non-UFFD-registered mapping
> > anyway, thus there isn't much reason to want to use these in any case (just
> > memcpy or memset or similar).
> >
> > - If UFFDIO_COPY is used on a minor fault, -EEXIST is returned.
>
> When minor fault the dst VM will report to src with the address.  The src could
> checkup whether dst contains the latest data on that (pmd) page and either:
>
>   - it's latest, then tells dst, dst does UFFDIO_CONTINUE
>
>   - it's not latest, then tells dst (probably along with the page data?  if
>     hugetlbfs doesn't support double map, we'd need to batch all the dirty
>     small pages in one shot), dst does whatever to replace the page
>
> Then, I'm thinking what would be the way to replace an old page.. is that one
> FALLOC_FL_PUNCH_HOLE plus one UFFDIO_COPY at last?

When I wrote this, my thinking was that users of this feature would
have two mappings, one of which is not UFFD registered at all. So, to
replace the existing page contents, userspace would just write to the
non-UFFD mapping (with memcpy() or whatever else, or we could get
fancy and imagine using some RDMA technology to copy the page over the
network from the live migration source directly in place). After
performing the write, we just UFFDIO_CONTINUE.

I believe FALLOC_FL_PUNCH_HOLE / MADV_REMOVE doesn't work with
hugetlbfs? Once shmem support is implemented, I would expect
FALLOC_FL_PUNCH_HOLE + UFFDIO_COPY to work, but I wonder if such an
operation would be more expensive than just copying using the other
side of the shared mapping?

>
> Thanks,
>
> --
> Peter Xu
>
