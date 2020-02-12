Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A656159E79
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 02:03:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728200AbgBLBDZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Feb 2020 20:03:25 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39365 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728137AbgBLBDY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Feb 2020 20:03:24 -0500
Received: by mail-lj1-f196.google.com with SMTP id o15so302684ljg.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Feb 2020 17:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zy6kGEEkqAsEiZzWHqRtvxnsI6DtM6n9AdiuD2GudTU=;
        b=fBxG1HcrByKfPtNty2DhtyD54YlVBt8nIN51NK2VPpgZ7L26CoMAQYrrNez+Edd1Gn
         KLAHlVWkm3Q8uZOGQqKfncW351w+GkpekQ1AxurxF26lO2WmqXR1y7xwYNvUiRUf7dX7
         p/ZI6Bsp5G+eMc0JFhnEsMBjvUERkEUAYwFn4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zy6kGEEkqAsEiZzWHqRtvxnsI6DtM6n9AdiuD2GudTU=;
        b=Td9jUoR29yEQMKuxNU8mqDX6F7bDyiSM+D6MfqrtDU8LBEoLRd/myETtj3in43gyNe
         fDYweggvT3RUc3Sk3VUFo9NURUOBDtJPuvau97gvwSPfDxa6nNnU7EQAGqagmovukriw
         WfOArXw9z+NpV1y/upjmQTeweyqAlwJ0GTnF6aohJkuqe8Mhz5nVCm9NXp6qgbmwnO00
         ZtzKw4NzQBpOCH7fu+v+j6ecMAsb6PTQU2JafSVe7lWOGxBwlyOf/H95g4sxbUBc6W8L
         U3x4CCFIwGhuVvSNjk1N4JxDgmLYTEF4J1jrog3cpIFPdSo6sUvQ2uMoJuTaqpSF1tXc
         1k3Q==
X-Gm-Message-State: APjAAAWSvqp/0haBBJWz5+fxaLN/ic/nOsGJ1ilpt6VauNNSRj6omNYB
        Ax8BneFs1IxHErKE9BC/cVUa3+Uidg8=
X-Google-Smtp-Source: APXvYqzRMRnEN2tCQNvTDWNIB9omu1oK6yvQU/OJoi6Ab8afDUEm1MBoQKmXnAcsY6c1QcxAyYT6pw==
X-Received: by 2002:a2e:5357:: with SMTP id t23mr5774629ljd.227.1581469401713;
        Tue, 11 Feb 2020 17:03:21 -0800 (PST)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id v13sm2609178lfq.69.2020.02.11.17.03.20
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2020 17:03:20 -0800 (PST)
Received: by mail-lj1-f171.google.com with SMTP id v17so313035ljg.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Feb 2020 17:03:20 -0800 (PST)
X-Received: by 2002:a2e:580c:: with SMTP id m12mr6104508ljb.150.1581469398565;
 Tue, 11 Feb 2020 17:03:18 -0800 (PST)
MIME-Version: 1.0
References: <20200211175507.178100-1-hannes@cmpxchg.org> <29b6e848ff4ad69b55201751c9880921266ec7f4.camel@surriel.com>
 <20200211193101.GA178975@cmpxchg.org> <20200211154438.14ef129db412574c5576facf@linux-foundation.org>
 <CAHk-=wiGbz3oRvAVFtN-whW-d2F-STKsP1MZT4m_VeycAr1_VQ@mail.gmail.com> <20200211164701.4ac88d9222e23d1e8cc57c51@linux-foundation.org>
In-Reply-To: <20200211164701.4ac88d9222e23d1e8cc57c51@linux-foundation.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 11 Feb 2020 17:03:02 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg1ZDADD3Vuw_sXhmBOrQ2xsp8YWxmtWiA6vG0RT-ZQ+A@mail.gmail.com>
Message-ID: <CAHk-=wg1ZDADD3Vuw_sXhmBOrQ2xsp8YWxmtWiA6vG0RT-ZQ+A@mail.gmail.com>
Subject: Re: [PATCH] vfs: keep inodes with page cache off the inode shrinker LRU
To:     Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Rik van Riel <riel@surriel.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Al Viro <viro@zeniv.linux.org.uk>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 11, 2020 at 4:47 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> What's the situation with highmem on ARM?

Afaik it's exactly the same as highmem on x86 - only 32-bit ARM ever
needed it, and I was ranting at some people for repeating all the
mistakes Intel did.

But arm64 doesn't need it, and while 32-bit arm is obviosuly still
selling, I think that in many ways the switch-over to 64-bit has been
quicker on ARM than it was on x86. Partly because it happened later
(so all the 64-bit teething pains were dealt with), but largely
because everybody ended up actively discouraging 32-bit on the Android
side.

There were a couple of unfortunate early 32-bit arm server attempts,
but they were - predictably - complete garbage and nobody bought them.
They don't exist any more.

So at least my gut feel is that the arm people don't have any big
reason to push for maintaining HIGHMEM support either.

But I'm adding a couple of arm people and the arm list just in case
they have some input.

[ Obvious background for newly added people: we're talking about
making CONFIG_HIGHMEM a deprecated feature and saying that if you want
to run with lots of memory on a 32-bit kernel, you're doing legacy
stuff and can use a legacy kernel ]

              Linus
