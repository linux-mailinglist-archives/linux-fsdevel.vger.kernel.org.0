Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47CE6B7166
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2019 04:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387853AbfISCIR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Sep 2019 22:08:17 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43875 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387465AbfISCIR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Sep 2019 22:08:17 -0400
Received: by mail-lj1-f194.google.com with SMTP id d5so1858521lja.10
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Sep 2019 19:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5Xuld3BlUHhLVm41JSQ0g37C/9G156A47j1pRWimdvw=;
        b=K4bnmhnBOLjP8CCgm9SQOLs8Azqf3H69cXUe+ZDqGsJNsVyqgu4XmqoP9IeTJLNk2l
         //0jhii85ZMd5vOF7E688yX86AzktkkMYhlQ07aMMj+h5+afd2UQCp7atEt6iXXdF2LU
         RRh/vpBYAp69fsqpH8cadS17r2gGFQbSW0FSg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5Xuld3BlUHhLVm41JSQ0g37C/9G156A47j1pRWimdvw=;
        b=YNWq2Vv2vTG8oupG9FHAdTAC6kcUlABosrQVyIPN2tM8hOMHpZzZTc0Ul8TXnC5BRg
         QosoAKSm8ZSVuYn8on2sKOfJZGK/N8QXIF9DE6So5AwuTGOZLPmV+P0E4ecgK1IAJpW5
         A94iHZP/DG7XUsJqSR9mDAL98pjRfZGpOPx1UESn9jnqwzJnRUrCEBB84qJQwExnITEL
         BAb+sK2JLvlUz8xkcI1XQGDnhF+sQA1BjpqOKY5FOy/Jczalc2SkKE6aMueaUi0Qdo2Z
         J/zTGgiYyGyrVAAdIqYH9ERL7yRHCd214OaiE10C6cWklb7xhZ9tcqKSk80l4bo8tnsb
         FRjA==
X-Gm-Message-State: APjAAAVvirBq28JZA/8KW3tnW1PhiKsy1T0250UxNH0soOFTQXCk0JlF
        XHlZvIQgjiPhATUyD5pWnE2NdS8TYuY=
X-Google-Smtp-Source: APXvYqyix6rgEF/5oMDJgzjRDLT9Cdr01xLzQIYBAeAMJlszaxozVRzACvKJCE0/fonMnTl/llz62g==
X-Received: by 2002:a2e:89cd:: with SMTP id c13mr3947907ljk.174.1568858894779;
        Wed, 18 Sep 2019 19:08:14 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id v1sm1275679lfa.87.2019.09.18.19.08.13
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Sep 2019 19:08:13 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id w67so1116845lff.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Sep 2019 19:08:13 -0700 (PDT)
X-Received: by 2002:ac2:5a4c:: with SMTP id r12mr3524864lfn.52.1568858892842;
 Wed, 18 Sep 2019 19:08:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190917152140.GU2229799@magnolia> <CAHk-=wj9Zjb=NENJ6SViNiYiYi4LFX9WYqskZh4E_OzjijK1VA@mail.gmail.com>
In-Reply-To: <CAHk-=wj9Zjb=NENJ6SViNiYiYi4LFX9WYqskZh4E_OzjijK1VA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 18 Sep 2019 19:07:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgXBV57mz46ZB5XivjiSBGkM0cjuvnU2OWyfRF=+41NPQ@mail.gmail.com>
Message-ID: <CAHk-=wgXBV57mz46ZB5XivjiSBGkM0cjuvnU2OWyfRF=+41NPQ@mail.gmail.com>
Subject: Re: [GIT PULL] iomap: new code for 5.4
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eric Sandeen <sandeen@sandeen.net>,
        Christoph Hellwig <hch@lst.de>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Bob Peterson <rpeterso@redhat.com>,
        cluster-devel <cluster-devel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 18, 2019 at 6:31 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Why would anybody use that odd "list_pop()" thing in a loop, when what
> it really seems to just want is that bog-standard
> "list_for_each_entry_safe()"

Side note: I do agree that the list_for_each_entry_safe() thing isn't
exactly beautiful, particularly since you need that extra variable for
the temporary "next" pointer.

It's one of the C++ features I'd really like to use in the kernel -
the whole "declare new variable in a for (;;) statement" thing.

In fact, it made it into C - it's there in C99 -  but we still use
"-std=gnu89" because of other problems with the c99 updates.

Anyway, I *would* be interested in cleaning up
list_for_each_entry_safe() if somebody has the energy and figures out
what we could do to get the c99 behavior without the breakage from
other sources.

For some background: the reason we use "gnu89" is because we use the
GNU extension with type cast initializers quite a bit, ie things like

    #define __RAW_SPIN_LOCK_UNLOCKED(lockname)      \
        (raw_spinlock_t) __RAW_SPIN_LOCK_INITIALIZER(lockname)

and that broke in c99 and gnu99, which considers those compound
literals and you can no longer use them as initializers.

See

    https://lore.kernel.org/lkml/20141019231031.GB9319@node.dhcp.inet.fi/

for some of the historical discussion about this. It really _is_ sad,
because variable declarations inside for-loops are very useful, and
would have the potential to make some of our "for_each_xyz()" macros a
lot prettier (and easier to use too).

So our list_for_each_entry_safe() thing isn't perfect, but that's no
reason to try to then make up completely new things.

             Linus
