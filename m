Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0AC424BEB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Oct 2021 04:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232654AbhJGCv6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Oct 2021 22:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232254AbhJGCv5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Oct 2021 22:51:57 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9914C061746;
        Wed,  6 Oct 2021 19:50:04 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id z20so17152146edc.13;
        Wed, 06 Oct 2021 19:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C3IDDYZFaUFLO/w9rYUwlHxNDVqOHTPNwMNOfkBaNKU=;
        b=prKH8LCl8QEsGEgecOpvC/Q38loRFsRmCFbzq7zkpKsydHQxRZKatmqH6Acjuk20K5
         p3TEM19UvZdW4HzzgJkJykXQB0374MrlZA/NnOp43kE8iy0tn+uDx5d3OqfBWY9yw9LR
         y1LeQihcSgnzSBP0u+Mr/mRHHIR9gpUzgTjKTVFGkQe7t5KG2Coxbz9MMK6SXaHLZzbH
         Ar90CVLBZ/jWF3kb0Wll5fiT6aFEAw8W4rd0TeWtXmJ4MMcBlXDDw0+A+bZe4k6JGu6h
         fqwzq4Lq4jSzijNdX4eGftHD8cSLUBHTicvCX5NXKyfs89/DJE4CVzrwsAXscb/zwKgE
         BOcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C3IDDYZFaUFLO/w9rYUwlHxNDVqOHTPNwMNOfkBaNKU=;
        b=tC1ZQn5aLd5Vawjldl+8jWFc74Ib4uPIr4QL6mMhLNfww0LVbx7z9Pc4OZGCUKcTIk
         YlOfbApL/E93+01DtF9f9PPp1eJ1aaBbrK+6NVj169IZDzxrtg+fSoR/FwN42UhdaZ6A
         zj0bmjEcnyLr8HIoYanEE0lcSODjrKoSL2HRCkrpkrrnrATSwnRwXBSZZXv+SD5kHXMX
         z6hr35KtoF9DKv7Ycgbpx8A8Rx+TgW5eua/cL1jMV1i265zumZdEoIFYzwYSSbRQS5yQ
         rs0D4H2QLCPU5Y630T9yo14yLEQsb1Bt3q27v6EVbI6BdZfmNK9aPXx0sopRBEDMwUa/
         Wwcg==
X-Gm-Message-State: AOAM5326g2Iz6PfzJezm82saZKprN2QtinTVfZz7ng4QguGRvZcbtCsV
        gET+3+9B4fP/Fx5b9G1uJ/oe5+g2npPwUvsoeZ4=
X-Google-Smtp-Source: ABdhPJzYUn+UTefsCrkM5ibhhX/EsK1QfZ6WToWZbVncVman2b38jSdBgYdkgUMBnBIPrTwIQvL2lqYQqSwyvZwidzU=
X-Received: by 2002:a05:6402:16d2:: with SMTP id r18mr2568038edx.363.1633575003380;
 Wed, 06 Oct 2021 19:50:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210930215311.240774-1-shy828301@gmail.com> <20210930215311.240774-3-shy828301@gmail.com>
 <YV4EqOpI580SKjnR@t490s>
In-Reply-To: <YV4EqOpI580SKjnR@t490s>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 6 Oct 2021 19:49:51 -0700
Message-ID: <CAHbLzko=jJYs3Tx_up9zPPtw37tDZys07A2UVtHjEokR6-Gteg@mail.gmail.com>
Subject: Re: [v3 PATCH 2/5] mm: filemap: check if THP has hwpoisoned subpage
 for PMD page fault
To:     Peter Xu <peterx@redhat.com>
Cc:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>, Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 6, 2021 at 1:18 PM Peter Xu <peterx@redhat.com> wrote:
>
> On Thu, Sep 30, 2021 at 02:53:08PM -0700, Yang Shi wrote:
> > +#ifdef CONFIG_MEMORY_FAILURE
> > +     /* Compound pages. Stored in first tail page's flags */
> > +     PG_has_hwpoisoned = PG_mappedtodisk,
> > +#endif
>
> Sorry one more comment I missed: would PG_hwpoisoned_subpage better?  It's just
> that "has_hwpoison" can be directly read as "this page has been hwpoisoned",
> which sounds too close to PG_hwpoisoned.  No strong opinion either.  Thanks,

TBH, I don't see too much difference IMHO. Someone may interpret it to
"this" subpage is hwpoisoned rather than at least one subpage of THP
is hwpoisoned.

>
> --
> Peter Xu
>
