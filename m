Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6F1759177A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Aug 2022 00:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236968AbiHLW7P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Aug 2022 18:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbiHLW7N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Aug 2022 18:59:13 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08DA295AFE
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Aug 2022 15:59:13 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id b144so3544512yba.13
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Aug 2022 15:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=bLNd6GEUJhNmcytLkGVXgbEWnyu0+3ckJ7H09CnT0Lc=;
        b=kocRy8ImT+ADgsOB/WfyEb7y4ar/hDnYQq+822+RqDD1x7SMcwREzpKlZ1W8nkWhr+
         SRMTiullbhAtzLdobOdu6EJifgoDIY/gTPIi2xltLhT3jJxfrCPY11TJryPuQqd+ZvAr
         K/byKTHbdXqd9vVq4D382plHztSucoiJxxDsl48gLW+/DhdLgvx/5paaKordKAopgyWR
         HhrR0UE349dwWaTg6oX7s5urmOROj8HKy81KZTCLkpu/7LajpEl8srN+287rV5uXmaRc
         U3yViHgeg0Exiu0Woacm+R2TKvJVvrs0yrRkbN7hl/weKjzsWgaV9olSaXO/VHI0gA7+
         bLIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=bLNd6GEUJhNmcytLkGVXgbEWnyu0+3ckJ7H09CnT0Lc=;
        b=f10UvoHcICfGlqS7HMgXYXJ93v1vDRTA9Pl86IEssiTFUo8NgL6oHTxju7h0HP2zz8
         ohlgmARbrWmAmRXexg7Ya4JAffN5sh+PeyPS+7ex93744z/C9D4u9P+wBP+U9njoShGw
         M4nO1ZUQVhkZAIiB0emyKcjhsTT5y7u2aUt7lnRhv9H0o4ORgDNHg+QjbdvhWAJIGJ1z
         lfurcwFnbAIbuMUrRPZ56joNkCzD9zgl7v4pjq7MqsH4r60KokY+RKPUcagW/nGkCqK7
         XwQkUUrvOYEiKA/AfYqS0N40ETEggWIyYJGEa3ChVhkQG2AvdcJE9AH6C/in85NgMx/M
         Mutw==
X-Gm-Message-State: ACgBeo2/O002PRo3832Zjxgc0qFdThOWFxSJkIaX6XlzGKx8uNWkGvhj
        VpIwI3jpv3HB69myjrtG3rChWBI6Db2GG8vLI5FcuTv6CpY=
X-Google-Smtp-Source: AA6agR59CZy12NhzZ3KM+JcIgXWU6wNvdu5sBDQmFop2rfEieZS1QNFXbozW/3ziN726S9KZOzOdNpeaVMAzgBhr6iI=
X-Received: by 2002:a25:71c2:0:b0:681:63ae:4c48 with SMTP id
 m185-20020a2571c2000000b0068163ae4c48mr5031739ybc.578.1660345152080; Fri, 12
 Aug 2022 15:59:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAAmZXruoj6vYi3AA2X3mnzOACniG_5ZrTmEFKYp7=fbr6aRHGQ@mail.gmail.com>
 <CAJfpegtf7QR1=-sV59jUsJKX4f1T3Mcov=HjoTZUdLf+XyA-3A@mail.gmail.com>
In-Reply-To: <CAJfpegtf7QR1=-sV59jUsJKX4f1T3Mcov=HjoTZUdLf+XyA-3A@mail.gmail.com>
From:   Frank Dinoff <fdinoff@google.com>
Date:   Fri, 12 Aug 2022 18:58:55 -0400
Message-ID: <CAAmZXrtrb16hrfskZuWRhGFMy+WyS4Fg0PNL_yjiFauiLEOXbA@mail.gmail.com>
Subject: Re: fuse: incorrect attribute caching with writeback cache disabled
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 12, 2022 at 5:33 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Thu, 11 Aug 2022 at 23:05, Frank Dinoff <fdinoff@google.com> wrote:
> >
> > I have a binary running on a fuse filesystem which is generating a zip file. I
> > don't know what syscalls are involved since the binary segfaults when run with
> > strace.
>
> You could strace the fuse filesystem.

I'll try doing this later, I was unsuccessful in finding anything
useful printing large amounts
of debug logs.

>
> > After doing a binary search,
> > https://github.com/torvalds/linux/commit/fa5eee57e33e79b71b40e6950c29cc46f5cc5cb7
> > is the commit that seems to have introduced the error. It still seems to
> > failing with a much newer kernel.
>
> How is it failing?

Oops sorry I thought I included that.  You can't unzip the file.
unzip -t has "error:  invalid compressed data to inflate"

> > Reverting the fuse_invalidate_attr_mask in fuse_perform_write to
> > fuse_invalidate_attr makes every other run of the binary produce the correct
> > output.
>
> What do you mean?  Is it succeeding half the time?

Running the binary multiple times in a row about 50% produce the
correct file and 50%
produce a corrupt file.

Running the test multiple times before fa5eee57 I'm seeing about 10%
of runs producing
a corrupt file. (I did not realize this had a chance of failure on the
old kernel.)
After fa5eee57 I have 100% of runs producing the corrupt file.

>
> >
> > I found that enabling the writeback cache makes the binary always produce the
> > right output. Running the fuse daemon in single threaded mode also works.
> >
> > Is there anything that sticks out to you that is wrong with the above commit?
>
> Could you try adding STATX_MODE to the invalidated mask?   Can't
> imagine any other attribute being relevant.

Adding STATX_MODE to FUSE_STATX_MODIFY does make the binary produce the
correct file about 75% of the time. The last bit of flakiness may be
some concurrency
issue in the binary?

>
> Thanks,
> Miklos
