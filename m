Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D2C72B6F85
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Nov 2020 21:03:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730499AbgKQUCR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Nov 2020 15:02:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730251AbgKQUCQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Nov 2020 15:02:16 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D4D7C0613CF
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2020 12:02:14 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id b17so25687233ljf.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2020 12:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GSCHMMM0D0q85Saw3BGZ1mrSdRqytsRtsFlwlLFUG1Q=;
        b=U5ZlwbFbW6wzZ9SjWFK+Je9NtJURJfuA+CBtm8mpTtA3OAFV31Gt7/PVFooFI3hJSJ
         FPe5GnyQ9vo+K8E4DGvg2CmIfBjU80aj+PwOMi9JxkBrfyCFhmQwE8yG25tVzzpwHM/G
         +SLjkMHpsWn0eetojTcyUPdUG+YBEUlN6bkAREdia0RwgRe5Az5vSyoEcUpsdqwdqQS2
         wQsiqbs+NFvyybKCLcEoNJlXX+Q79meG+WhN0TKvoL+R5ZHI5kwQtcSrRMvmI503HpW4
         iQFfKDV7kGEefpCno1fqlRK8X77oqYAJVuKjI7LR9wx0wgLXu6vuCzgHwKA6G32zuy1F
         Z/Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GSCHMMM0D0q85Saw3BGZ1mrSdRqytsRtsFlwlLFUG1Q=;
        b=C2NidLxG5jDW3tJKzlz5VUCObKJwXwKpF21pmwcbD5gSbZT7cvZ05s0XqTYuREPx/i
         kqHdGQyJvuUkZfAIzIsFgoZZNTqH26Xf1/ZltqPSL4Ofhl3oIyQf4jnrgkniq855XpqQ
         z/Qy6eRxFYp0GwO0RgZPDUrpbRVMvZrWbbUW6efgdOEuFAZ5rQPYiVPjCrXK3bp9IoSZ
         J3HparOp8zbPCLNPjVDqMm3DiLhdz+eAQw+nYlfwVcvRcBSDFFKVC5S2oLPU+Z1gCiBc
         jIdeU080TZCQjN++0+CniFSci9Dr5vqETJKwnktfb7ZSq51UUAHB88goyKl35bC+m00g
         cUbg==
X-Gm-Message-State: AOAM532BGbVg9VGxN9OY4IWvcd7fF4wk8wBbEomvOHEwNNvrwerR8vw/
        lpVsVWSTTZw82KNE+qWMe0Tpz+M0Sv5EO3R5XFsJ5w==
X-Google-Smtp-Source: ABdhPJzrteo1SoLGHTARp2PUs3U3i4VQkUG29Mj40M+A73s5OoqlPLDhJ7M0v+3kzosqo9RIkW4zU8tz5/C7FbMtdpI=
X-Received: by 2002:a05:651c:204c:: with SMTP id t12mr2581977ljo.347.1605643332643;
 Tue, 17 Nov 2020 12:02:12 -0800 (PST)
MIME-Version: 1.0
References: <20201117162932.13649-1-rppt@kernel.org> <20201117162932.13649-7-rppt@kernel.org>
 <20201117193358.GB109785@carbon.dhcp.thefacebook.com>
In-Reply-To: <20201117193358.GB109785@carbon.dhcp.thefacebook.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 17 Nov 2020 12:02:01 -0800
Message-ID: <CALvZod5mJnR2DXoYTbp9RX4uR7zVyqAPfD+XKpqXKgxaNyJ1VA@mail.gmail.com>
Subject: Re: [PATCH v9 6/9] secretmem: add memcg accounting
To:     Roman Gushchin <guro@fb.com>
Cc:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-riscv@lists.infradead.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 17, 2020 at 11:49 AM Roman Gushchin <guro@fb.com> wrote:
>
> On Tue, Nov 17, 2020 at 06:29:29PM +0200, Mike Rapoport wrote:
> > From: Mike Rapoport <rppt@linux.ibm.com>
> >
> > Account memory consumed by secretmem to memcg. The accounting is updated
> > when the memory is actually allocated and freed.
> >
> > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
[snip]
> >
> > +static int secretmem_account_pages(struct page *page, gfp_t gfp, int order)
> > +{
> > +     int err;
> > +
> > +     err = memcg_kmem_charge_page(page, gfp, order);

I haven't looked at the whole series but it seems like these pages
will be mapped into the userspace, so this patch has dependency on
Roman's "mm: allow mapping
accounted kernel pages to userspace" patch series.
