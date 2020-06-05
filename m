Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C38E1EF164
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jun 2020 08:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbgFEGgX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Jun 2020 02:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbgFEGgW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Jun 2020 02:36:22 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9682FC08C5C2;
        Thu,  4 Jun 2020 23:36:22 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id u13so7350418wml.1;
        Thu, 04 Jun 2020 23:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6A+Yc/NcIwBkdU7I3CB2KCsuXoL3rpyUZTqoR0EzSg8=;
        b=N3dlX4HRWIqNWFCX93secDfZiwMU1Ju9hkUtdPWp8v5KS524hXTrfhbdvCewJRi7Wg
         hHhj5NeDmzbRinC07HMvOzkv9r5uFM/bCMB2cN36voTuE0z3aWbGA7md0doqRd+sKzWu
         QhvybNNLUyPClnlia9IJpWa9OdglaDsB1RWx8KSoIsBPBy1KqtDBez+aERH024UzAHlv
         KtkKZb7WpgDz9TKy10oNAcqtLsYjf1zPHmo6gQ/hb5KNGKqsSr7xIvfJZE+RdKeJNDBp
         HBBSIXYYYOAGh7qtExGVlET2EFuohIi75h5/HbiBJfa2KkwjAillg2/6rvBRxrUoYX4w
         SmQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6A+Yc/NcIwBkdU7I3CB2KCsuXoL3rpyUZTqoR0EzSg8=;
        b=ZW++Js6HbeRGftSOYywkXyT0k0matJNPSjnzKS+qrTpxxvu2aLyTGXcrUdaoWu2/gM
         Kd10F9+q3wSVGWH7XE7jc7PJQqQFfzAnqRf5iD+QLPTLvRFDtJRPQNVEgHZo7zmNZTR0
         UF3RGkEHB5T6QAj8lD8S8ZezebcZl2Bd+pWX4vGe3gbvaULd1rFwV6B7qPNtFO/RNfbn
         rs2AsdGScmMpptnQaCa06l57BWQxFpu+7u5FTCJQUKZ+5xIjcJ2hAmDM8YFctWKO8s1R
         H8Ss5jdy2Z9KaIetYpKWJVEdIimQnGp2MpN6LFHSU5OPr2//V80bGw7eFNelKXg8XE+/
         yXoA==
X-Gm-Message-State: AOAM533HMZOsQCNVNLjQ1Ef0MqKCJg8Gb5BDB14KyP9E/1dZGquEj2bg
        EHYeWUT/bkcFFieV9+Exn8LPSIdA
X-Google-Smtp-Source: ABdhPJw8f8JI3DbnRJc4v0j6Y8s5RDEkjiIgirZ9MRvFQtf4pVBBGZGGOamsht6XhfANeF6ah9rYxw==
X-Received: by 2002:a1c:5987:: with SMTP id n129mr1093340wmb.60.1591338981121;
        Thu, 04 Jun 2020 23:36:21 -0700 (PDT)
Received: from [192.168.1.43] (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
        by smtp.gmail.com with ESMTPSA id n7sm10832794wrx.82.2020.06.04.23.36.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2020 23:36:20 -0700 (PDT)
Subject: Re: clean up kernel_{read,write} & friends v2
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Laight <David.Laight@aculab.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        David Howells <dhowells@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        NetFilter <netfilter-devel@vger.kernel.org>,
        Nicolas Pitre <nico@fluxnic.net>, Joe Perches <joe@perches.com>
References: <CAHk-=wj3iGQqjpvc+gf6+C29Jo4COj6OQQFzdY0h5qvYKTdCow@mail.gmail.com>
 <20200528054043.621510-1-hch@lst.de>
 <22778.1590697055@warthog.procyon.org.uk>
 <f89f0f7f-83b4-72c6-7d08-cb6eaeccd443@schaufler-ca.com>
 <3aea7a1c10e94ea2964fa837ae7d8fe2@AcuMS.aculab.com>
 <CAHk-=wjR0H3+2ba0UUWwoYzYBH0GX9yTf5dj2MZyo0xvyzvJnA@mail.gmail.com>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <d67deb88-73a8-4c57-6b37-c62190422d65@amsat.org>
Date:   Fri, 5 Jun 2020 08:36:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wjR0H3+2ba0UUWwoYzYBH0GX9yTf5dj2MZyo0xvyzvJnA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

On 5/29/20 9:19 PM, Linus Torvalds wrote:
> On Fri, May 29, 2020 at 6:08 AM David Laight <David.Laight@aculab.com> wrote:
>>
>> A wide monitor is for looking at lots of files.
> 
> Not necessarily.
> 
> Excessive line breaks are BAD. They cause real and every-day problems.
> 
> They cause problems for things like "grep" both in the patterns and in
> the output, since grep (and a lot of other very basic unix utilities)
> is fundamentally line-based.
> 
> So the fact is, many of us have long long since skipped the whole
> "80-column terminal" model, for the same reason that we have many more
> lines than 25 lines visible at a time.
> 
> And honestly, I don't want to see patches that make the kernel reading
> experience worse for me and likely for the vast majority of people,
> based on the argument that some odd people have small terminal
> windows.
> 
> If you or Christoph have 80 character lines, you'll get possibly ugly
> wrapped output. Tough. That's _your_ choice. Your hardware limitations
> shouldn't be a pain for the rest of us.

Unfortunately refreshable braille displays have that "hardware
limitations". 80 cells displays are very expensive.
Visual impairments is rarely a "choice".
Relaxing the 80-char limit make it harder for blind developers
to contribute.

> Longer lines are fundamentally useful. My monitor is not only a lot
> wider than it is tall, my fonts are universally narrower than they are
> tall. Long lines are natural.
> 
> When I tile my terminal windows on my display, I can have 6 terminals
> visible at one time, and that's because I have them three wide. And I
> could still fit 80% of a fourth one side-by-side.
> 
> And guess what? That's with my default "100x50" terminal window (go to
> your gnome terminal settings, you'll find that the 80x25 thing is just
> an initial default that you can change), not with some 80x25 one. And
> that's with a font that has anti-aliasing and isn't some pixelated
> mess.
> 
> And most of my terminals actually end up being dragged wider and
> taller than that. I checked, and my main one is 142x76 characters
> right now, because it turns out that wider (and taller) terminals are
> useful not just for source code.
> 
> Have you looked at "ps ax" output lately? Or used "top"? Or done "git
> diff --stat" or any number of things where it turns out that 80x25 is
> really really limiting, and is simply NO LONGER RELEVANT to most of
> us.
> 
> So no. I do not care about somebody with a 80x25 terminal window
> getting line wrapping.
> 
> For exactly the same reason I find it completely irrelevant if
> somebody says that their kernel compile takes 10 hours because they
> are doing kernel development on a Raspberry PI with 4GB of RAM.
> 
> People with restrictive hardware shouldn't make it more inconvenient
> for people who have better resources. Yes, we'll accommodate things to
> within reasonable limits. But no, 80-column terminals in 2020 isn't
> "reasonable" any more as far as I'm concerned. People commonly used
> 132-column terminals even back in the 80's, for chrissake, don't try
> to make 80 columns some immovable standard.
> 
> If you choose to use a 80-column terminal, you can live with the line
> wrapping. It's just that simple.
> 
> And longer lines are simply useful. Part of that is that we aren't
> programming in the 80's any more, and our source code is fundamentally
> wider as a result.
> 
> Yes, local iteration variables are still called 'i', because more
> context just isn't helpful for some anonymous counter. Being concise
> is still a good thing, and overly verbose names are not inherently
> better.
> 
> But still - it's entirely reasonable to have variable names that are
> 10-15 characters and it makes the code more legible. Writing things
> out instead of using abbreviations etc.
> 
> And yes, we do use wide tabs, because that makes indentation something
> you can visually see in the structure at a glance and on a
> whole-function basis, rather than something you have to try to
> visually "line up" things for or count spaces.
> 
> So we have lots of fairly fundamental issues that fairly easily make
> for longer lines in many circumstances.
> 
> And yes, we do line breaks at some point. But there really isn't any
> reason to make that point be 80 columns any more.
> 
>                   Linus

Regards,

Phil.
