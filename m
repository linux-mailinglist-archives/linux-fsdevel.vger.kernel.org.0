Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BED5826AAC8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Sep 2020 19:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbgIORfZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Sep 2020 13:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727686AbgIORdW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Sep 2020 13:33:22 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A54C06178B
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2020 10:33:22 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id x18so1711210pll.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2020 10:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M8l6c/TjWYQRiXwPIxqfhPqbNDCVlwzZu6ART7sGA8U=;
        b=wJA7qJJabH1MtZuv73Nto4ArpYL8bpMpf3xBzAkp/k8HKbnVO+qNgBxVpGr0Fz0Ggd
         KUH/bdakO5dHORUiBJWUEiCC3O57yGwfrShO2YsEYl8X8n7zw4Tx3s+Cd5uEnn03KBrx
         iW+qRGl4cXUKUBcnQ3rqhtGNr7wgb44cq83D4pqDmM31tCIBVppOTUNzZ0uRaUuWN+Yd
         UvkfdyVoGzjnJ5jnEHZulu8IBOnYzM0iIZoCSFxiftDvpraX/xRihGAzgEbajBkm1CAo
         ZG+nTnkW1iTOo8PBTTwFv/WO0iuy9ZWcRS6qv6eUtgmLjjAJnAy5zwyE8a4nYq6ANJD/
         +4Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M8l6c/TjWYQRiXwPIxqfhPqbNDCVlwzZu6ART7sGA8U=;
        b=lH37kA2g7F66JBERBmJXnQaEi7EOq6fDWRRd80L3uQAPviFRsGVyXmRBicmBUsvmGj
         jqDQzbur4NN9HJBxCuHvXeqRPuFIn145MLsU2bKRegaWAn0Xt71zoDz38SJiNKVkCx2B
         XUJsPiqhxau4FKVyIPlUA7o2h4xhqcQcoGbN+2zx7ua1PIJmXiVvoSN3DxKkam4vNCnQ
         gVMWCM8tU+VcMZOkraTDSls4MW/R4qMFuS6Bzm0KRm4+opvOj0+HErD2sXckRsBrHR3c
         FXP+ihKaE/+Lo/2fpbLymDXxSDZo8r38f1tW5mrDDuF9ukfXfdlCMLMKuegoFoeGzOmw
         vP9w==
X-Gm-Message-State: AOAM530ICmIYd9y2B4M0K/nt6wL0QiK2OvpwSlVKrChqHc2VO0/ukmSi
        f3eeduolow50FmSOiiJeJPE5u57y9KgDioDdN56dYA==
X-Google-Smtp-Source: ABdhPJxdqveluwOFObD/Q2IeyCwgxfBsJ6CnsJl5rU2wrD26p6QqzakCfSftmjvTx3O57U4UaQflQENKIp65BvUQEN4=
X-Received: by 2002:a17:90a:fa94:: with SMTP id cu20mr388035pjb.147.1600191202144;
 Tue, 15 Sep 2020 10:33:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200915125947.26204-1-songmuchun@bytedance.com>
 <20200915143241.GH5449@casper.infradead.org> <CAMZfGtW0PqU6SLihLABA8rU+FuBqm8NksDW=EkLXy1RZfYeDGA@mail.gmail.com>
 <20200915154213.GI5449@casper.infradead.org>
In-Reply-To: <20200915154213.GI5449@casper.infradead.org>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 16 Sep 2020 01:32:46 +0800
Message-ID: <CAMZfGtVTjopGgFv4xCDcF1+iGeRva_ypH4EQWcDUFBdsfqhQbA@mail.gmail.com>
Subject: Re: [External] Re: [RFC PATCH 00/24] mm/hugetlb: Free some vmemmap
 pages of hugetlb page
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org,
        Peter Zijlstra <peterz@infradead.org>, viro@zeniv.linux.org.uk,
        Andrew Morton <akpm@linux-foundation.org>, paulmck@kernel.org,
        mchehab+huawei@kernel.org, pawan.kumar.gupta@linux.intel.com,
        Randy Dunlap <rdunlap@infradead.org>, oneukum@suse.com,
        anshuman.khandual@arm.com, jroedel@suse.de, almasrymina@google.com,
        David Rientjes <rientjes@google.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 15, 2020 at 11:42 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Tue, Sep 15, 2020 at 11:28:01PM +0800, Muchun Song wrote:
> > On Tue, Sep 15, 2020 at 10:32 PM Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > On Tue, Sep 15, 2020 at 08:59:23PM +0800, Muchun Song wrote:
> > > > This patch series will free some vmemmap pages(struct page structures)
> > > > associated with each hugetlbpage when preallocated to save memory.
> > >
> > > It would be lovely to be able to do this.  Unfortunately, it's completely
> > > impossible right now.  Consider, for example, get_user_pages() called
> > > on the fifth page of a hugetlb page.
> >
> > Can you elaborate on the problem? Thanks so much.
>
> OK, let's say you want to do a 2kB I/O to offset 0x5000 of a 2MB page
> on a 4kB base page system.  Today, that results in a bio_vec containing
> {head+5, 0, 0x800}.  Then we call page_to_phys() on that (head+5) struct
> page to get the physical address of the I/O, and we turn it into a struct
> scatterlist, which similarly has a reference to the page (head+5).

As I know, in this case, the get_user_pages() will get a reference
to the head page (head+0) before returning such that the hugetlb
page can not be freed. Although get_user_pages() returns the
page (head+5) and the scatterlist has a reference to the page
(head+5), this patch series can handle this situation. I can not
figure out where the problem is. What I missed? Thanks.

>
> If you're returning page (head+1) from get_user_pages(), all the
> calculations will be wrong and you'll do DMA to the wrong address.
>
> What needs to happen is a conversion to get_user_bvecs().  That way we
> can return a bvec which is {head, 0x5000, 0x800} and the calculations
> will work.  So that's going to involve touching a lot of device drivers.
> Christoph has a start on it here:
> http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/gup-bvec
>
> Overlapping with that is a desire to change the biovec so that it
> only stores {phys_addr, length} rather than {page, offset, length}.
> We're also going to have to rework the scatterlist so that it doesn't
> carry a struct page either.



-- 
Yours,
Muchun
