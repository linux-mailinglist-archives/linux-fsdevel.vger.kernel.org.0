Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBC6C21994
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2019 16:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729037AbfEQOIu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 May 2019 10:08:50 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:35975 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728720AbfEQOIt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 May 2019 10:08:49 -0400
Received: by mail-it1-f194.google.com with SMTP id e184so12223872ite.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 May 2019 07:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wnE5ugQSV+EX8NJq3bXAxc5+808EKDRQWDkjcFDm76g=;
        b=bCbydxhIRSNOt3TwDd4BdgsvwmO+IYfUOtPAEAjE2b/cMzWleRTqkn3UbY13DGYF1K
         x4yKjJrT6J8shR6+H2q3zQgZGYdC9a0WvJmPeCQ4S0ffoyFISZ2B0V76p9gorMUSQ6ER
         bRKXGBesi4Znrw/l7X+0AcOZOXjCjR7CaV4xUbio+/j3wXC0fnhOlLLnTQyxz5/dsx5U
         oSqt/pSv99S0Oftm7Z+LRef9zrwxu9hleDGUMXzjoDfyHveXTeVIn3F3wfTR3OL6TJGu
         082bIphpUtJ9LlQ5xRROlabqAeWGtZVRZrntcO9m/4dBEXkJ5cyyPS6SNomLQs8wNpZ8
         Xw9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wnE5ugQSV+EX8NJq3bXAxc5+808EKDRQWDkjcFDm76g=;
        b=RHEM4hKK/yq3g0k2yxmB3H2Hm96H7ehbnFDnGhJQpufFygEq7c56LnLsX2sXmU8KvB
         g+La7fxjmsvBzbSVeJhiKwvFDLCEJrRK7pOP/Zy443K2o9iPvxwYp75KLXRLPizqVouJ
         E7djGwyz4nQSgXMEowCfhHo4XSKCAcfkr532hDUVBblf1gdYrQuMR8XHV4k1NE0TIwjz
         yBYj5IKtxho1Fo30OG9R8wXv6QHCC0XBGPGSunIWtouwNXyM7twNDqQh21yNjvNZqsrS
         jZYt0AjY0TqcA3/dgoRMbd/j41+qnRFLhtd0GQ5xTVtVssHKHQ7s1bSB2sjUUmvJ3BYq
         qIUQ==
X-Gm-Message-State: APjAAAXXrzGm/h8EHAuhDz6+3A6+kL7J9nT/Nupt/Lz2o06zyHkIntez
        0x1BCUeQVectjd+vaqMnRmQFzplR6MUg9G1VPVHNRkKfpCk=
X-Google-Smtp-Source: APXvYqzuUfMi8lV0T0lwvRZljXNCxDfrTqM5N220cNATHJKTOwPJxnkJlmO1e5pjoYWFu4RheZnomcXVJ0T1qE6Tsfg=
X-Received: by 2002:a02:412:: with SMTP id 18mr1390107jab.82.1558102128480;
 Fri, 17 May 2019 07:08:48 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000014285d05765bf72a@google.com> <0000000000000eaf23058912af14@google.com>
 <20190517134850.GG17978@ZenIV.linux.org.uk>
In-Reply-To: <20190517134850.GG17978@ZenIV.linux.org.uk>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 17 May 2019 16:08:35 +0200
Message-ID: <CACT4Y+Z8760uYQP0jKgJmVC5sstqTv9pE6K6YjK_feeK6-Obfg@mail.gmail.com>
Subject: Re: BUG: unable to handle kernel paging request in do_mount
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     syzbot <syzbot+73c7fe4f77776505299b@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, sabin.rapan@gmail.com,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 17, 2019 at 3:48 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Fri, May 17, 2019 at 03:17:02AM -0700, syzbot wrote:
> > This bug is marked as fixed by commit:
> > vfs: namespace: error pointer dereference in do_remount()
> > But I can't find it in any tested tree for more than 90 days.
> > Is it a correct commit? Please update it by replying:
> > #syz fix: exact-commit-title
> > Until then the bug is still considered open and
> > new crashes with the same signature are ignored.
>
> Could somebody explain how the following situation is supposed to
> be handled:
>
> 1) branch B1 with commits  C1, C2, C3, C4 is pushed out
> 2) C2 turns out to have a bug, which gets caught and fixed
> 3) fix is folded in and branch B2 with C1, C2', C3', C4' is
> pushed out.  The bug is not in it anymore.
> 4) B1 is left mouldering (or is entirely removed); B2 is
> eventually merged into other trees.
>
> This is normal and it appears to be problematic for syzbot.
> How to deal with that?  One thing I will *NOT* do in such
> situations is giving up on folding the fixes in.  Bisection
> hazards alone make that a bad idea.

linux-next creates a bit of a havoc.

The ideal way of handling this is including Tested-by: tag into C2'.
Reported-by: would work too, but people suggested that Reported-by: is
confusing in this situation because it suggests that the commit fixes
a bug in some previous commit. Technically, syzbot now accepts any
tag, so With-inputs-from:
syzbot+73c7fe4f77776505299b@syzkaller.appspotmail.com would work too.

At this point we obvious can't fix up C2'. For such cases syzbot
accepts #syz fix command to associate bugs with fixes. So replying
with "#syz fix: C2'-commit-title" should do.
