Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 868B3520F74
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 May 2022 10:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237854AbiEJIMN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 May 2022 04:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237823AbiEJIMG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 May 2022 04:12:06 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 715D0259FA8
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 May 2022 01:08:08 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id i19so31292132eja.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 May 2022 01:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2QFdBMdYEEbUASs02np96D58mKsmERHZc9+DIqJWP78=;
        b=qQi+i9ZAoniWPdwG3ylmPUcac2wf8Zd0T/w/nS4IkCX0SkHWtsVxLcPNyUCNNYVzbs
         SKLrVJtsuHZOxJf9utf3nZ1kAxJ0Y5h6Rt6gPKKyU3j5RzI862zM7fBWXwNd3l4lr+p6
         dD3XO8aDg4AuxFjyL4NW7QgH+gJ4zt0+d9rh8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2QFdBMdYEEbUASs02np96D58mKsmERHZc9+DIqJWP78=;
        b=FAhYGzq+BPz3JoVODrfuHb8K4xYRgeR1UPsHChUD57OwqpLCmnfsY6G1zws0xGuqJY
         vZs+i88K/QAyZvI5UHi+qqTt8CHvnVv+J+LPxwQo2rz6bOjP9QBiRcmu4rdpECBFjJvk
         v2fLTeAwx+E+UUuQAIXaQiIURWYoVWCYY+BqqJT7zRMNZ8gqP2WGozJTL9NTGQ09JfWb
         zwvTA3nRpF/rXwX+aPFVy9QkZ7zFMljCgJqFXicHCbevusE6vOYVDappJU8A+6GRbhJZ
         pKw72dIwj2/+n2V8h+k+CN+kXrFe/CQSrC8oKrFeDaKl4MJKwG1syDQrHqFbE1ZHsKxq
         eKbg==
X-Gm-Message-State: AOAM531E/1Qn4W0sgFdRiu8YYuLJwH13rh0KTIieN2E3ZUx1Z/Ri0hXb
        vOzzFT7DIxhElZ8ZPWgsepKWd0Udh4XsRaQuBLVgpQ==
X-Google-Smtp-Source: ABdhPJwEHlw4XhbiZIuNB+ukHQw6ZcScwA3a5E2Bw5WzA5tKVBIbFK+IK2Sb7JbU5SORV2GvNdQ+pEESwl6nGdb3zws=
X-Received: by 2002:a17:906:b48:b0:6f5:132c:1a17 with SMTP id
 v8-20020a1709060b4800b006f5132c1a17mr18555378ejg.748.1652170086987; Tue, 10
 May 2022 01:08:06 -0700 (PDT)
MIME-Version: 1.0
References: <YnEeuw6fd1A8usjj@miu.piliscsaba.redhat.com> <20220509124815.vb7d2xj5idhb2wq6@wittgenstein>
 <CAJfpegveWaS5pR3O1c_7qLnaEDWwa8oi26x2v_CwDXB_sir1tg@mail.gmail.com>
 <8ab7f51cf18ba62e3f5bfdf5d9933895413f4806.camel@themaw.net> <CAJfpegv3MCHMzur9R+K+yZC3Z_Wmbq3=pQwuQ=+kQSrihg0c9g@mail.gmail.com>
In-Reply-To: <CAJfpegv3MCHMzur9R+K+yZC3Z_Wmbq3=pQwuQ=+kQSrihg0c9g@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 10 May 2022 10:07:55 +0200
Message-ID: <CAJfpegutUQOTa71NTy_iaz5Kus2ma16ALqrHtvV2+cQ0tFiaxA@mail.gmail.com>
Subject: Re: [RFC PATCH] getting misc stats/attributes via xattr API
To:     Ian Kent <raven@themaw.net>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, Dave Chinner <david@fromorbit.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Karel Zak <kzak@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        LSM <linux-security-module@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 10 May 2022 at 10:06, Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Tue, 10 May 2022 at 06:27, Ian Kent <raven@themaw.net> wrote:
>
> > > Was there ever a test patch for systemd using fsinfo(2)?  I think
> > > not.
> >
> > Mmm ... I'm hurt you didn't pay any attention to what I did on this
> > during the original fsinfo() discussions.
>
> I can't find anything related to this in my mailbox.  Maybe you
> mentioned it at some point, but I have not been involved with the
> actual systemd changes.  So not meant to belittle your work at all.
>
> > > Until systemd people start to reengineer the mount handing to allow
> > > for retrieving a single mount instead of the complete mount table we
> > > will never know where the performance bottleneck lies.
> >
> > We didn't need the systemd people to do this only review and contribute
> > to the pr for the change and eventually merge it.
> >
> > What I did on this showed that using fsinfo() allone about halved the
> > CPU overhead (from around 4 processes using about 80%) and once the
> > mount notifications was added too it went down to well under 10% per
> > process. The problem here was systemd is quite good at servicing events
> > and reducing event processing overhead meant more events would then be
> > processed. Utilizing the mount notifications queueing was the key to
> > improving this and that was what I was about to work on at the end.
> >
> > But everything stopped before the work was complete.
> >
> > As I said above it's been a long time since I looked at the systemd
> > work and it definitely was a WIP so "what you see is what you get"
> > at https://github.com/raven-au/systemd/commits/. It looks like the
> > place to look to get some idea of what was being done is branch
> > notifications-devel or notifications-rfc-pr. Also note that this
> > uses the libmount fsinfo() infrastrucure that was done by Karal Zak
> > (and a tiny bit by me) at the time.
>
> Looks great as a first step.
>
> What do you mean by "Utilizing the mount notifications queueing"?
>
> Do you mean batching of notifications?   I think that's a very
> important issue: processing each individual notifcation may not make
> sense when there are lots of them.  For example, doing ceate
> mount+remote mount in a loop a million times will result in two

s/remote/remove/

> million notification messages (with high likelyhood of queue
> overflow), but in the end the mount table will end up being the
> same...
>
> Thanks,
> Miklos
