Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1E63077A7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 15:06:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbhA1OGM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 09:06:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbhA1OGF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 09:06:05 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28602C0613ED
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Jan 2021 06:05:25 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id v15so3458227ljk.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Jan 2021 06:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y3gG47U5h6Z0ms3PRQUM8QBx0aKm7Kdbts1+blceg04=;
        b=CfsrBQTGs0Esbt43WsOC7Vky4axjxTddmdc93F7OYhDFG0xRi8EFPzo+ljigoe2pot
         nl08e50onWdGXMFNApzFBAnmpeofi5yYUDo1CTz9cqW42zyNQd9HH0L/9STRoEjZ5zJc
         fTQNEKQF+kRCuFHnyz08L6kuBS11UhljPl/rF/qd+Dep7b9BbEiHXcPCIznldnx2v/az
         YhUiFaD5ezD3+239rpnSr1++mcg29oPu7pI5YQLwKfPBN7dvfoXrUj0cu4J0tiwMoTNG
         iQABFGbqct02pstWAwbScdjSu0GGO2jqtYNWDU9LQ7vjkegvI5234iUqZC4wfqsWXuRJ
         Fycg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y3gG47U5h6Z0ms3PRQUM8QBx0aKm7Kdbts1+blceg04=;
        b=LaTpNwOb1T7AoIWCLIp6y5qjK3HJFhrug1xRL3euBhNtwCMr+NKOxWFFIVsfTvQZEv
         J9xbfxUOIhWfIMMQlEnSR3r2LL6vuXVqobIlcAOEgARoehe5ZaopjpKV21glfEm3Xyew
         QEJJfSzO+W1TTkN6lZnA6oRQd9b3OCD7BulD5WxFa5ycgzJSiEbf1krPaGTPekbxDIx4
         AQtlscEx9SZnJRPM+Xxl+P6krPWCi/GvTJjz8fFmhP6sn/mX+t2nyPqmR7MDbPs+AM7Z
         3cRsDngd/RqJPQixI7UcT3KsdCCWbdye++vDUsW5nEw+AqgxFONEWn6HfTEpsm2zqCSb
         yftg==
X-Gm-Message-State: AOAM532LmAWRq4m74okOrl0Zat1FxWIUNVfzesNRCmHaHZhlUUlzFT8j
        jBbkkxujAuo+NBBQmHU3zMVBMzfiwKpdzs+BHL65sw==
X-Google-Smtp-Source: ABdhPJzmRLfShao52Wl8c2GnOI8Esxdu0gDu7Q4WjHT9JBMYe6CY6I8ohfbMaBXYGGmZSWG03007q03WUtavSFPY58o=
X-Received: by 2002:a2e:9ed1:: with SMTP id h17mr8071290ljk.160.1611842723157;
 Thu, 28 Jan 2021 06:05:23 -0800 (PST)
MIME-Version: 1.0
References: <20210121122723.3446-1-rppt@kernel.org> <20210121122723.3446-9-rppt@kernel.org>
 <20210125165451.GT827@dhcp22.suse.cz> <20210125213817.GM6332@kernel.org>
 <20210126144838.GL308988@casper.infradead.org> <20210126150555.GU827@dhcp22.suse.cz>
 <20210127184213.GA919963@carbon.dhcp.thefacebook.com> <YBJuwqItjCemDN5L@dhcp22.suse.cz>
In-Reply-To: <YBJuwqItjCemDN5L@dhcp22.suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 28 Jan 2021 06:05:11 -0800
Message-ID: <CALvZod7YjXvaYoZ7HXq2sDkwvpjpLBA-jhrzxa48jEuBt6zLNQ@mail.gmail.com>
Subject: Re: [PATCH v16 08/11] secretmem: add memcg accounting
To:     Michal Hocko <mhocko@suse.com>
Cc:     Roman Gushchin <guro@fb.com>, Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@kernel.org>,
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
        linux-riscv@lists.infradead.org, x86@kernel.org,
        Hagen Paul Pfeifer <hagen@jauu.net>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 27, 2021 at 11:59 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Wed 27-01-21 10:42:13, Roman Gushchin wrote:
> > On Tue, Jan 26, 2021 at 04:05:55PM +0100, Michal Hocko wrote:
> > > On Tue 26-01-21 14:48:38, Matthew Wilcox wrote:
> > > > On Mon, Jan 25, 2021 at 11:38:17PM +0200, Mike Rapoport wrote:
> > > > > I cannot use __GFP_ACCOUNT because cma_alloc() does not use gfp.
> > > > > Besides, kmem accounting with __GFP_ACCOUNT does not seem
> > > > > to update stats and there was an explicit request for statistics:
> > > > >
> > > > > https://lore.kernel.org/lkml/CALo0P13aq3GsONnZrksZNU9RtfhMsZXGWhK1n=xYJWQizCd4Zw@mail.gmail.com/
> > > > >
> > > > > As for (ab)using NR_SLAB_UNRECLAIMABLE_B, as it was already discussed here:
> > > > >
> > > > > https://lore.kernel.org/lkml/20201129172625.GD557259@kernel.org/
> > > > >
> > > > > I think that a dedicated stats counter would be too much at the moment and
> > > > > NR_SLAB_UNRECLAIMABLE_B is the only explicit stat for unreclaimable memory.
> > > >
> > > > That's not true -- Mlocked is also unreclaimable.  And doesn't this
> > > > feel more like mlocked memory than unreclaimable slab?  It's also
> > > > Unevictable, so could be counted there instead.
> > >
> > > yes, that is indeed true, except the unreclaimable counter is tracking
> > > the unevictable LRUs. These pages are not on any LRU and that can cause
> > > some confusion. Maybe they shouldn't be so special and they should live
> > > on unevistable LRU and get their stats automagically.
> > >
> > > I definitely do agree that this would be a better fit than NR_SLAB
> > > abuse. But considering that this is somehow even more special than mlock
> > > then a dedicated counter sounds as even better fit.
> >
> > I think it depends on how large these areas will be in practice.
> > If they will be measured in single or double digits MBs, a separate entry
> > is hardly a good choice: because of the batching the displayed value
> > will be in the noise range, plus every new vmstat item adds to the
> > struct mem_cgroup size.
> >
> > If it will be measured in GBs, of course, a separate counter is preferred.
> > So I'd suggest to go with NR_SLAB (which should have been named NR_KMEM)
> > as now and conditionally switch to a separate counter later.
>
> I really do not think the overall usage matters when it comes to abusing
> other counters. Changing this in future will be always tricky and there
> always be our favorite "Can this break userspace" question. Yes we dared
> to change meaning of some counters but this is not generally possible.
> Just have a look how accounting shmem as a page cache has turned out
> being much more tricky than many like.
>
> Really if a separate counter is a big deal, for which I do not see any
> big reason, then this should be accounted as unevictable (as suggested
> by Matthew) and ideally pages of those mappings should be sitting in the
> unevictable LRU as well unless there is a strong reason against.
>

Why not decide based on the movability of these pages? If movable then
unevictable LRU seems like the right way otherwise NR_SLAB.
