Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B256D488CF2
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Jan 2022 23:59:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237345AbiAIW7z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 9 Jan 2022 17:59:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235684AbiAIW7y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 9 Jan 2022 17:59:54 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE8A8C06173F;
        Sun,  9 Jan 2022 14:59:53 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id b13so46470225edd.8;
        Sun, 09 Jan 2022 14:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JichIxBzlu+gabrOqQBbMPOsNHYmhCY/t5tbp7G0B7M=;
        b=kgHkAD5+T6PvIvnKRVStbR9axj45u0zQZQ5Ajh++vJu5m6K31ArZpk2IN3u29P6Ts8
         0Kcj9/w6x1pMK0BkEOzWRIt1AhFmg/UoG6PQg5hESnlGa3qh9bDzv7ekWmnYQqmHVAcA
         v1v9x7La9ewcyLBOiBqC5yl/V/Zj5lHi7+3j1d6iQbfHVT9uJp/7a1otpbFshIBTKDSh
         wsRr0V0vkjIP56fu6yCPFayVkLH2+jhcJ0ru+G/qECb57GxGOHDhaqM1ef3pBVGbMhDm
         6DsxE9Sjrl4/6Pu+PiVrpzUYePkyzWxI268lzABt4FJvjUTak3G4GAlv2gpd3a0kv7lr
         oabg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JichIxBzlu+gabrOqQBbMPOsNHYmhCY/t5tbp7G0B7M=;
        b=kmZEIcIV993OzOAFdQDYZGmplrm68HhKtVTzna0YVVCU0mNd1hjJ/5hQhBEF4FylZA
         8N5WK4WRvsOyjMCsq9MfUG1CdFU9RL836TPzsx5+SB9D++6Cpr5zbkFOJuqNveIkqgJp
         +YjH12nAnNMLtQHoPW5QuTcU0jZtffGLYuBevRz9pPH/NUiIylFRrz+D86q3jkomFWfj
         OyZYwETUtI2CSxTKC6w2wVLMxfPYjQkz1r8tgDVeGir1mrLt4t9niVsTL+Ut1KrlS28n
         m5acia0Tbu+JETrN7EaaVy768jP+imxW0xvJb/0uia5ac6diujth6n7f0a1Uqu0esL2x
         T8mA==
X-Gm-Message-State: AOAM530Df8pCWPDHqzvlHOFLXB7nv8QstYh6LFUHX5EWq3hceX9Et0Ag
        mbBTWRM/g5B12VuofmE7WwCTqFNL7vrQ5zlzAuM=
X-Google-Smtp-Source: ABdhPJxNWqr5kmxsLYsT/zArMcv16U9D8HQ6t/tgYp/axFuIl3brCOR+Lnj9TzrscWzwvbef3kkV5mYvAuiVz+llCQk=
X-Received: by 2002:aa7:d554:: with SMTP id u20mr73148751edr.322.1641769192522;
 Sun, 09 Jan 2022 14:59:52 -0800 (PST)
MIME-Version: 1.0
References: <20211130201652.2218636d@mail.inbox.lv> <2dc51fc8-f14e-17ed-a8c6-0ec70423bf54@valdikss.org.ru>
 <20211202135824.33d2421bf5116801cfa2040d@linux-foundation.org>
 <cca17e9f-0d4f-f23a-2bc4-b36e834f7ef8@suse.cz> <20211203222710.3f0ba239@mail.inbox.lv>
 <Ya3fG2rp+860Yb+t@dhcp22.suse.cz>
In-Reply-To: <Ya3fG2rp+860Yb+t@dhcp22.suse.cz>
From:   Barry Song <21cnbao@gmail.com>
Date:   Mon, 10 Jan 2022 11:59:40 +1300
Message-ID: <CAGsJ_4zaumNC7QT=J1NmmcWD4GE1XZtRZ3xVdsTfv8gLJPU7kA@mail.gmail.com>
Subject: Re: [PATCH] mm/vmscan: add sysctl knobs for protecting the working set
To:     Michal Hocko <mhocko@suse.com>
Cc:     Alexey Avramov <hakavlad@inbox.lv>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        ValdikSS <iam@valdikss.org.ru>, Linux-MM <linux-mm@kvack.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, mcgrof@kernel.org,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>, oleksandr@natalenko.name,
        kernel@xanmod.org, aros@gmx.com, hakavlad@gmail.com,
        Yu Zhao <yuzhao@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 7, 2021 at 4:51 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Fri 03-12-21 22:27:10, Alexey Avramov wrote:
> > >I'd also like to know where that malfunction happens in this case.
> >
> > User-space processes need to always access shared libraries to work.
> > It can be tens or hundreds of megabytes, depending on the type of workload.
> > This is a hot cache, which is pushed out and then read leads to thrashing.
> > There is no way in the kernel to forbid evicting the minimum file cache.
> > This is the problem that the patch solves. And the malfunction is exactly
> > that - the inability of the kernel to hold the minimum amount of the
> > hottest cache in memory.
>
> Executable pages are a protected resource already page_check_references.
> Shared libraries have more page tables pointing to them so they are more
> likely to be referenced and thus kept around. What is the other memory
> demand to push those away and cause a trashing?

I've heard a lot of complaints that shared libraries can be swapped
out and thrashing.
it seems page_check_references won't be able to relieve the thrashing for them.
on the other hand, exec pages could have a very big mapcount, that means reverse
mapping of them will take a lot of time while they are reclaimed, so
this makes the user
experience even much worse while memory is under high pressure.

Are we actually able to make mapcount a factor for memory reclaim in
some way? The
difficulty might be that a big mapcount doesn't necessarily mean the
page is active. for
For example,  all processes mapping the page might be inactive. but
reclaiming pages
with a big mapcount has been a big pain as far as i know.

Thanks
Barry
