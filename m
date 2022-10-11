Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33AE45FBC6B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Oct 2022 22:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbiJKUvF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Oct 2022 16:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbiJKUvA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Oct 2022 16:51:00 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E2ED83072
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Oct 2022 13:50:55 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 70so13502559pjo.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Oct 2022 13:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hXVOT4cLQG/UjKF5bxvScKtDt4JjDuPp0lInq7z6SZk=;
        b=sqIPnSdL5hOAbhrVhdZG2o8sGZ+fwLZzLOdlefjOihqvUGgLaSJColzIKLls+fnmKc
         I+TNrBcbp3DxnXu9g+CwxTQBCR/0lXT18ueWRQ7SdpO5Jm+/4LysJaFEFJhAZ+nopXLE
         1ZAsm9yxvKs6Z62XTHSFJGC/iB62BnYQcAg63vgJf9ZjDBLDmn6c7iWTQPD6bGwOhLu5
         lObbFdm5P1qYkhBVE/wg3zrMywx6vg4lmS8fqA0fgqGn0Yipmuuqp+gC0/n5gUiJqSBM
         fLmw31GK/0DFXVXnvvEZSGO/eBt5F3sAdVV4i+DtzdT0TcfTs7hW0sfARTyGKIssnxUE
         Tjzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hXVOT4cLQG/UjKF5bxvScKtDt4JjDuPp0lInq7z6SZk=;
        b=whNw67++lygSbkdmPPsmZsb+rjk57NPNRDZQO4kxfB2SP3e1dWsqyly9Bj6vtvmYGQ
         Uz9kz2ky2PMOpumyE+qU7uS2RJxzx0oCvBc+xU0qUxYjFxFksxETSGfjnjNHPm2vwuCW
         1amKKO0n5KxEJ8HqEV5cQLzT052gs5yhwaAn5VH5GXZAwMBY+0sbmSh6J+jEsVrl0ffF
         cK6Gqde1Md92zP02Pg0NQqKyWRHZjuAJY93YPdQBreQMytqpzP55rJ/mZC4JoOnOeG7x
         P6PZxnwwPHgGHDMlq3vmdLOyRaU1IOSfnAJboBvu5metsFeacCbsIVibasqfjVBQm/sM
         3V1w==
X-Gm-Message-State: ACrzQf3CwF/RONzl1T8m7VtqKotkorPUpG1ScLDPPip2Eo7aTFocivY5
        coV0hGGMcY4e2ScmHz/joyR2gqCctF+46UtBcCJ4cA==
X-Google-Smtp-Source: AMsMyM4uoOmAwILCMQCsBXafyhKXq7+SNA+WhdgnvaxFyUqFj5CAoRyNhw9YCykE9rs7Uze6SEDZvj5fOZdI4rt6f10=
X-Received: by 2002:a17:90b:33c3:b0:20a:ebc3:6514 with SMTP id
 lk3-20020a17090b33c300b0020aebc36514mr1105208pjb.147.1665521454797; Tue, 11
 Oct 2022 13:50:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190307090146.1874906-1-arnd@arndb.de> <20221006222124.aabaemy7ofop7ccz@google.com>
 <f0dbc406-11b4-90f7-52fd-ce79f842c356@linux.intel.com>
In-Reply-To: <f0dbc406-11b4-90f7-52fd-ce79f842c356@linux.intel.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 11 Oct 2022 13:50:43 -0700
Message-ID: <CAKwvOdnpMqW_esBd615Fx8VKTfny-yR2PTUejBH0uYkHaL517A@mail.gmail.com>
Subject: Re: [PATCH] fs/select: avoid clang stack usage warning
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Eric Dumazet <edumazet@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 7, 2022 at 6:46 PM Andi Kleen <ak@linux.intel.com> wrote:
>
>
> On 10/6/2022 3:21 PM, Nick Desaulniers wrote:
> > On Thu, Mar 07, 2019 at 10:01:36AM +0100, Arnd Bergmann wrote:
> >> The select() implementation is carefully tuned to put a sensible amount
> >> of data on the stack for holding a copy of the user space fd_set,
> >> but not too large to risk overflowing the kernel stack.
> >>
> >> When building a 32-bit kernel with clang, we need a little more space
> >> than with gcc, which often triggers a warning:
> >>
> >> fs/select.c:619:5: error: stack frame size of 1048 bytes in function 'core_sys_select' [-Werror,-Wframe-larger-than=]
> >> int core_sys_select(int n, fd_set __user *inp, fd_set __user *outp,
> >>
> >> I experimentally found that for 32-bit ARM, reducing the maximum
> >> stack usage by 64 bytes keeps us reliably under the warning limit
> >> again.
> >>
> >> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >> ---
> >>   include/linux/poll.h | 4 ++++
> >>   1 file changed, 4 insertions(+)
> >>
> >> diff --git a/include/linux/poll.h b/include/linux/poll.h
> >> index 7e0fdcf905d2..1cdc32b1f1b0 100644
> >> --- a/include/linux/poll.h
> >> +++ b/include/linux/poll.h
> >> @@ -16,7 +16,11 @@
> >>   extern struct ctl_table epoll_table[]; /* for sysctl */
> >>   /* ~832 bytes of stack space used max in sys_select/sys_poll before allocating
> >>      additional memory. */
> >> +#ifdef __clang__
> >> +#define MAX_STACK_ALLOC 768
> > Hi Arnd,
> > Upon a toolchain upgrade for Android, our 32b x86 image used for
> > first-party developer VMs started tripping -Wframe-larger-than= again
> > (thanks -Werror) which is blocking our ability to upgrade our toolchain.
>
>
> I wonder if there is a way to disable the warning or increase the
> threshold just for this function. I don't think attribute optimize would
> work, but perhaps some pragma?

Here's what I would have guessed, the pragma approach seems a little broken.
https://godbolt.org/z/vY7fGYv7f
Maybe I'm holding it wrong?

>
>
> -Andi
>
>
>


-- 
Thanks,
~Nick Desaulniers
