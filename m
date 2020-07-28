Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D74F231179
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jul 2020 20:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728755AbgG1SRX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jul 2020 14:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732287AbgG1SRX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jul 2020 14:17:23 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD7E7C0619D2
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jul 2020 11:17:22 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id i80so11508911lfi.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jul 2020 11:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aLQ0XH/RmZSu/en4EAiBtQRKchA1E8VMT6fgzWGOKMw=;
        b=hdBHy5JovDcVsPtQmmE+kOG+0bUdmbxHWwkGKho10lmXbEo1G9ahGg7SX5mCD+aqlW
         7usecoUhK45RaSad6rpfDN2jFykepxltPY0kSQC9Ax1Dvd9VtqnLvGoZA2JD/scAiTF+
         RuZ2jZslihKTU8Zs6p6GmQJvi4+8tJXvgSOCE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aLQ0XH/RmZSu/en4EAiBtQRKchA1E8VMT6fgzWGOKMw=;
        b=MN3JV4XmkkL22V4ePEUsZ4tCAGEgd38e/9X/yA+nnOo1lWaHW6ukOzHBgSl3/CQpxX
         F7v46L7hiw9888fQa4tLBsKalNoUj3iojUspZDixtjRu1yaW9QdSkOtRHwrTvwZITCP7
         +M14Pw2OuF1NAl4QX8wiHk5Ky43COXYJsvdwg33kHlGyjrwODuf4G6VxfxxTPqZEHcRl
         Oj2RjoSiVskQGIpJ1GoO+tJsNKImOm8gAAW2cpQxosdhGRx2CY+YeKx4wkWys7LdmOnj
         uOCz9aBO/wurvdsVjTArcJqvUYBoTQ7forPg0k1XK4x8/WPg9Qv6ch4CpM+Gog/ejP1+
         5caQ==
X-Gm-Message-State: AOAM530baBQfjmGC/A20A8OSgYCq6P/KXj5dcCvUqwTLL7GfL7Ni7jG8
        tY2xJOSeI8IaQVrCR9NDZd+y4yUTUME=
X-Google-Smtp-Source: ABdhPJx5V3OmtR92P4qZ4rkYdF/bMxT/cwrwBsgTrjQfiGB40pDGIG7fPoc/J6wJPiy4GMEjeigZtg==
X-Received: by 2002:a05:6512:312b:: with SMTP id p11mr14427845lfd.202.1595960240670;
        Tue, 28 Jul 2020 11:17:20 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id r22sm3095735ljc.25.2020.07.28.11.17.19
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2020 11:17:19 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id s16so6968660ljc.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jul 2020 11:17:19 -0700 (PDT)
X-Received: by 2002:a2e:991:: with SMTP id 139mr12506329ljj.314.1595960238862;
 Tue, 28 Jul 2020 11:17:18 -0700 (PDT)
MIME-Version: 1.0
References: <87h7tsllgw.fsf@x220.int.ebiederm.org> <CAHk-=wj34Pq1oqFVg1iWYAq_YdhCyvhyCYxiy-CG-o76+UXydQ@mail.gmail.com>
 <87d04fhkyz.fsf@x220.int.ebiederm.org> <87h7trg4ie.fsf@x220.int.ebiederm.org>
In-Reply-To: <87h7trg4ie.fsf@x220.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 28 Jul 2020 11:17:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj+ynePRJC3U5Tjn+ZBRAE3y7=anc=zFhL=ycxyKP8BxA@mail.gmail.com>
Message-ID: <CAHk-=wj+ynePRJC3U5Tjn+ZBRAE3y7=anc=zFhL=ycxyKP8BxA@mail.gmail.com>
Subject: Re: [RFC][PATCH] exec: Freeze the other threads during a
 multi-threaded exec
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>, Pavel Machek <pavel@ucw.cz>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 28, 2020 at 6:23 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> For exec all I care about are user space threads.  So it appears the
> freezer infrastructure adds very little.

Yeah. 99% of the freezer stuff is for just adding the magic notations
for kernel threads, and for any user space threads it seems the wrong
interface.

> Now to see if I can find another way to divert a task into a slow path
> as it wakes up, so I don't need to manually wrap all of the sleeping
> calls.  Something that plays nice with the scheduler.

The thing is, how many places really care?

Because I think there are like five of them. And they are all marked
by taking cred_guard_mutex, or the file table lock.

So it seems really excessive to then create some whole new "let's
serialize every thread", when you actually don't care about any of it,
except for a couple of very very special cases.

If you care about "thread count stable", you care about exit() and
clone().  You don't care about threads that are happily running - or
sleeping - doing their own thing.

So trying to catch those threads and freezing them really feels like
entirely the wrong interface.

             Linus
