Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB29C2B1633
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Nov 2020 08:08:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbgKMHIn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Nov 2020 02:08:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbgKMHIn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Nov 2020 02:08:43 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04EACC0613D1
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2020 23:08:43 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id l1so8531787wrb.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2020 23:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IlXhzogRSxSvoHkWYteutxbOuUvU6nH3WapY0MSxAaw=;
        b=XPVMvRHGELsBmWE8Al91Q9dAH4K4xxhUxuP0YbN1DisG9ho6/GbC1Bmnvn6+nweh5k
         sUIqk2yfRTeks/Tk0IkH7FFt2nE/AoZoEwNx2dNJ1ZSHdtf5GN0N21ZCUYHxd6KZsfWW
         oDzf4yHEtP31iKsorbUKlr2VJbyHzKfkVvkLflEKX3Wbd1oug0/VoT4BQQK3Sx/3CTNZ
         PE9ULJQtMS/1PuN4vuni3svPYenFDo4U2YGxAkRfqlQAsjeT4yHwwKuTvbe61E7PKeWo
         wRVsZ/4P9tbmM0DYUbMwnAsZtL9K8ywmksINY2/YksWwvOS41Av8XNqCUMZmNtdMHg97
         d5GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IlXhzogRSxSvoHkWYteutxbOuUvU6nH3WapY0MSxAaw=;
        b=bmtul5FMJKV7iCDGl3/oAxtPweAegl1PtGCSlqU0iiVG6PXGwBZh+n5C6NXB5Vd7Vg
         ymmQfDGWhrxW3SeBLcbctdf1GaejMGlvRW8IgiEPrkgoRDi3J3EauVpo+fKFy4Lu5B3C
         gx6E3sMQk0dVHIccmGgY4cp0VtyyhBRG69Btk8yxT0IeOC9Qe4irDWJYiHzTb2ypBS7R
         cyfpSm4ZZJJ8WAtHJh4TNvXKPvr4kXMWlhlws3RxvsxMMGBhjlH2uxaHNfoP/HxIKG1P
         UN/Sp5/xoTF7a1Gn9fV9XZdy3YTzCoyAeImIf5gPF6Pc7RDyP84t8/wbCnMLtbY1b+NU
         v4BQ==
X-Gm-Message-State: AOAM533AJeCx/Qiy/nEJa9Q9lCeGHIE7uN/JL/PQWcxxGUPYGTK9nU1P
        Pel6HSjb/ZtPo7uu0mipkawBdV6FE314g1vZdHNoGmOyTEU=
X-Google-Smtp-Source: ABdhPJwjzsmFnnk8S7s8wDdbSnnNmcl6obLTrQpcB+KdKfl7AU/IhKbH4qXIhRemzTEbJ3HBJPZ12iCpK9sg8PZ3PHI=
X-Received: by 2002:a5d:4001:: with SMTP id n1mr1532830wrp.426.1605251321518;
 Thu, 12 Nov 2020 23:08:41 -0800 (PST)
MIME-Version: 1.0
References: <20201113044652.GD17076@casper.infradead.org>
In-Reply-To: <20201113044652.GD17076@casper.infradead.org>
From:   Hugh Dickins <hughd@google.com>
Date:   Thu, 12 Nov 2020 23:08:13 -0800
Message-ID: <CANsGZ6bw9XAgOsWGj3zNyRWteV4pcVceKUzQzdfDGXWvnDU07Q@mail.gmail.com>
Subject: Re: Are THPs the right model for the pagecache?
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm <linux-mm@kvack.org>,
        Linux-FSDevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 12, 2020 at 8:47 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> When I started working on using larger pages in the page cache, I was
> thinking about calling them large pages or lpages.  As I worked my way
> through the code, I switched to simply adopting the transparent huge
> page terminology that is used by anonymous and shmem.  I just changed
> the definition so that a thp is a page of arbitrary order.
>
> But now I'm wondering if that expediency has brought me to the right
> place.  To enable THP, you have to select CONFIG_TRANSPARENT_HUGEPAGE,
> which is only available on architectures which support using larger TLB
> entries to map PMD-sized pages.  Fair enough, since that was the original
> definition, but the point of suppoting larger page sizes in the page
> cache is to reduce software overhead.  Why shouldn't Alpha or m68k use
> large pages in the page cache, even if they can't use them in their TLBs?

Yes, I strongly agree with this new position. While I understood your
desire to avoid all the confusions of yet another config option, it
always seemed a wrong direction to require THugeP support for your
not-necessarily-huge TLargePs. Most of the subtlety and significance
of traditional THPs lies with the page table mappings thereof; whereas
your TLPs or whatever are aiming for I/O and page cache efficiencies:
very useful, but a mistake to muddle it with the page table issues.

Hugh
