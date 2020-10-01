Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB9F280529
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Oct 2020 19:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732702AbgJAR2W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Oct 2020 13:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732096AbgJAR2V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Oct 2020 13:28:21 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC517C0613D0
        for <linux-fsdevel@vger.kernel.org>; Thu,  1 Oct 2020 10:28:20 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id 77so7582790lfj.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Oct 2020 10:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nq30T9ipylnBWjO2xJskq+OLvWlQYB6lkENNQ5ZOw1w=;
        b=M7TKpUswrG2jxtRl2zoF3NNLx7uT3xRR84G8viOemh2ubF41na0bVTyv2blp4hVdFk
         D9dx53TS5ugcU7ADMVNgY1XE+YIP9FTtJ9cb8AYAoZvFPxvO3rpqfUbpfGL3nJQJZIhv
         oIKJoEWMy0xn+kUtH3dO+7HtsmG3WBb098vP4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nq30T9ipylnBWjO2xJskq+OLvWlQYB6lkENNQ5ZOw1w=;
        b=WjlrOO9sMC1Goju+qDyOnSgH1Nx0LX4OkOZDKbrD0ulmuHZB+gAjyjbC02rdbVLAil
         G9nHU2YohdF0pxf8G42r9iF2jMgAkppL7DOVb0NdeInCdZVW1HW/G1OG1PSBdKJjg6f6
         cB2kLH3EX71w+s0iDiB63602PRkvrSIwa29D6Ds7y6D43cwsSla8uZKWtgs63NPGSG5p
         nO+qa9PtYmWh/KeYO2l+XOh7eyBlmsUTdu4I3i/NlbOmehKDi6xf/gKyCoeV10Y6HJll
         CiVYane11d/kS17CeHyiTucxAm2u3/7u4Mvx0cQy8Mw4mN+Vtp2zXW1mlvli0pzxY2Fg
         dzYQ==
X-Gm-Message-State: AOAM532zfLizXx9x37+9ZyNjcPaGNZYZZV2ztVnwPSjFnXoz1JAsc4ZN
        FWJttkC/CfCn7hvte+DXLphbLlXpcqmwgg==
X-Google-Smtp-Source: ABdhPJwON5jzS5dbJBkVbertQLLvvzkk/Ha8TG8Pzl/B4b15KnkgsB2XWPQSjqv8PjTEwKUrjcSMpg==
X-Received: by 2002:a19:cb12:: with SMTP id b18mr3383950lfg.417.1601573298943;
        Thu, 01 Oct 2020 10:28:18 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id w17sm627390lfn.55.2020.10.01.10.28.17
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Oct 2020 10:28:17 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id y2so7542899lfy.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Oct 2020 10:28:17 -0700 (PDT)
X-Received: by 2002:ac2:4ec7:: with SMTP id p7mr2698279lfr.352.1601573297305;
 Thu, 01 Oct 2020 10:28:17 -0700 (PDT)
MIME-Version: 1.0
References: <bfa88b5ad6f069b2b679316b9e495a970130416c.1601567868.git.josef@toxicpanda.com>
In-Reply-To: <bfa88b5ad6f069b2b679316b9e495a970130416c.1601567868.git.josef@toxicpanda.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 1 Oct 2020 10:28:01 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj9-Cc-qZUrTZ=V=LrHj-wK++kuOrxbiFQCkbu9THycEQ@mail.gmail.com>
Message-ID: <CAHk-=wj9-Cc-qZUrTZ=V=LrHj-wK++kuOrxbiFQCkbu9THycEQ@mail.gmail.com>
Subject: Re: [PATCH] pipe: fix hang when racing with a wakeup
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 1, 2020 at 8:58 AM Josef Bacik <josef@toxicpanda.com> wrote:
>
> The problem is we're doing the prepare_to_wait, which sets our state
> each time, however we can be woken up either with reads or writes.  In
> the case above we race with the WRITER waking us up, and re-set our
> state to INTERRUPTIBLE, and thus never break out of schedule.

Good catch of an interesting problem.

That said, the real problem here is that "pipe_wait()" is some nasty
garbage. I really wanted to convert all users to do a proper
wait-queue usage, but left the old structure alone.

Any normal "prepare_to_wait()" user should always check for the
condition that it's waiting for _after_ the prepare-to-wait call, but
the pipe code was traditionally all run under the pipe mutex, so it
should have no races at all, because it's completely invalid to use
"pipe_wait()" with anything that doesn't hold the mutex (both on the
sleeping and waking side).

So pipe_wait() is kind of legacy and meant for all the silly and
complex UNIX domain connection things that nobody wants to touch.

The IO code was supposed to have been converted away from that pipe
mutex model, but it looks like I punted on splice, without thinking
about this issue.

So I think the *real* fix would be to convert the splice waiting code
to work even without holding the pipe mutex. Because honestly, I think
your patch fixes the problem, but not completely.

In particular, the pipe wakeup can happen from somebody that doesn't
hold the pipe mutex at all (see pipe_read(), and notice how it's doing
the __pipe_unlock() before it does the "if it was full, wake things
up), so this whole sequence is racy:

   check if pipe is full
   pipe_wait() if it is

because the wakeup can happen in between those things, and
"pipe_wait()" has no way to know what it's waiting for, and the wakeup
event has already happened by the time it's called.

Let me think about this, but I think the right solution is to just get
rid of the splice use of pipe_wait.

Do you have some half-way reliable way to trigger the issue for testing?

                 Linus
