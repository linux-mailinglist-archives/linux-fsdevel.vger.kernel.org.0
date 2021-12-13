Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B519B4722C5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Dec 2021 09:39:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232186AbhLMIi6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Dec 2021 03:38:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbhLMIi5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Dec 2021 03:38:57 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9781CC06173F;
        Mon, 13 Dec 2021 00:38:57 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id g14so48663955edb.8;
        Mon, 13 Dec 2021 00:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mhgDMsvRarSfV0WUVOS+UIrf7Z2BgPxSrPMePub8zEI=;
        b=ev+wZKb9RhuR6DO8+Mc5e9v1nvGYgn5/Jl2RppiCCSFZt39G84O4PobYVmalE3z3Mm
         KGa/DKT7HYUh3VThDWcNN1Jr/3E3WmfL2kMtcsFHjTZQTaBw4NAczCyVQpxxxQCfhANV
         eObecQpVIlenUEfnZOKw3AjkLGhsAZ0qbCj1I6srxzZ5wDfmZVh0Q9+bd2GwT3o5P5Ha
         CNZiSvo2I0BZVH0O3Rt6C+7Y8cSgSSdd/fj1j0CHlOp4a4kWKxnW6t0AwI00GYeLuWcO
         VjKuBVHNohLRpxxD/lXEhRgreirGTm3zlfeySW4zE8e8qChCZRDHjrq/9xmYIeKxQkQ4
         v+2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mhgDMsvRarSfV0WUVOS+UIrf7Z2BgPxSrPMePub8zEI=;
        b=qtHlPLVBVqRh6Vux4RKLR8Y9EHRiXr+yJaYL7HuxVbhGBcLbdxdHxfO38h0w4gZq6U
         9vMtZu4uCSn7W0d0Dfzdfg3j+coYLG8ZaRhvHOioi6jf4QXKqWE3GB64RkoHCeBa7vwo
         9WoleCdH3IQjh5natw0rILWAjSauEEjL+wHce/SZPvYaaPg+iJVQL4BGry/Y+UFgN11a
         TGiQI/OEd/4JTLYrpeIeiD9CjwKWu8QOniojlGW2EWcswt0ddDDDlKCz/ufeK6qdXxHF
         fC/lqQysuHgi2zmcZvqBydtn5Bjhku1PrCLifH4omRaBclguTWGxUVxMAC4uHc7MiuvN
         VXcQ==
X-Gm-Message-State: AOAM530NT9naBulBZr+R5BFfG8upl2xKUIgxV9nsYZzQF3RPT/PAaSBe
        UVNNUe+VDvJocR20tPg2t3+EEnZ3v6cFK2j9e4k=
X-Google-Smtp-Source: ABdhPJyzicQrltpvFvHdvxxR4MA4FPSz4sVTF6W6YypDa+e0iCqDsSkMQnDmhxBDb+aSI37ZovL6TsK1YTM+BZalpW4=
X-Received: by 2002:a17:906:7109:: with SMTP id x9mr41899126ejj.559.1639384736111;
 Mon, 13 Dec 2021 00:38:56 -0800 (PST)
MIME-Version: 1.0
References: <20211130201652.2218636d@mail.inbox.lv> <2dc51fc8-f14e-17ed-a8c6-0ec70423bf54@valdikss.org.ru>
In-Reply-To: <2dc51fc8-f14e-17ed-a8c6-0ec70423bf54@valdikss.org.ru>
From:   Barry Song <21cnbao@gmail.com>
Date:   Mon, 13 Dec 2021 21:38:45 +1300
Message-ID: <CAGsJ_4zMoV6UJGC_X-VRM7p8w68a0Q8sLVfS3sRFxuQUtHoASw@mail.gmail.com>
Subject: Re: [PATCH] mm/vmscan: add sysctl knobs for protecting the working set
To:     ValdikSS <iam@valdikss.org.ru>
Cc:     Alexey Avramov <hakavlad@inbox.lv>, Linux-MM <linux-mm@kvack.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>, mcgrof@kernel.org,
        Kees Cook <keescook@chromium.org>, yzaikin@google.com,
        oleksandr@natalenko.name, kernel@xanmod.org, aros@gmx.com,
        hakavlad@gmail.com, Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 7, 2021 at 5:47 AM ValdikSS <iam@valdikss.org.ru> wrote:
>
> This patchset is surprisingly effective and very useful for low-end PC
> with slow HDD, single-board ARM boards with slow storage, cheap Android
> smartphones with limited amount of memory. It almost completely prevents
> thrashing condition and aids in fast OOM killer invocation.
>

Can you please post your hardware information like what is the cpu, how much
memory you have and also post your sysctl knobs, like how do you set
vm.anon_min_kbytes,  vm.clean_low_kbytes and vm.clean_min_kbytes?

> The similar file-locking patch is used in ChromeOS for nearly 10 years
> but not on stock Linux or Android. It would be very beneficial for
> lower-performance Android phones, SBCs, old PCs and other devices.
>

Can you post the link of the similar file-locking patch?

> With this patch, combined with zram, I'm able to run the following
> software on an old office PC from 2007 with __only 2GB of RAM__
> simultaneously:
>
>   * Firefox with 37 active tabs (all data in RAM, no tab unloading)
>   * Discord
>   * Skype
>   * LibreOffice with the document opened
>   * Two PDF files (14 and 47 megabytes in size)
>
> And the PC doesn't crawl like a snail, even with 2+ GB in zram!
> Without the patch, this PC is barely usable.
> Please watch the video:
> https://notes.valdikss.org.ru/linux-for-old-pc-from-2007/en/
>

The video was captured before using this patch? what video says
"the result of the test computer after the configuration", what does
"the configuration" mean?

Thanks
Barry
