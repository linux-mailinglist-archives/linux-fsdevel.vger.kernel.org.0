Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3352A520F69
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 May 2022 10:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237804AbiEJIKe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 May 2022 04:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237764AbiEJIKc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 May 2022 04:10:32 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B6C4F44C
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 May 2022 01:06:30 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id m20so31285606ejj.10
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 May 2022 01:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7tI2Ml7ymhbWng6Ez1TG6evxVbSct1ixRwoWt6dfoEI=;
        b=oOtcyxbZmxrFKBqSMFucrSkIORwsCB93eB0KfRaZL/Ssg7HjwooAEun4ESX1HaypIV
         sGJtZpHRV3J2QlxJP18LmXH/tBA6RmH0h240ugbELvxEDH4OpX1uBZPuiAw6GS63Et6Q
         8ds5+bFHu9ehHJK2ihuUN4MDVDqC+5TMjxprI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7tI2Ml7ymhbWng6Ez1TG6evxVbSct1ixRwoWt6dfoEI=;
        b=uMK1Mz2tOX42Qp5jWHhSjM9Mh4SzN38scKtzgD7ABjKPQpUUrBBCymJCpAsBJFYkoA
         ZmpWSOvw0nurEkzpDnpMjUAVs7CnvPnSv0wb4hVNWC7YT3LD4aI8qIrNgeEHaPvPTwn9
         uyg1TUf+OPEw22ULyTsd+FjhujCiO+lPtswqU/lQIbtj3MusQ1aVgf06Cq6YjYARPio0
         P79MiACURtpv8fgeucHTzYuRPRF8LnFfFqTjRVKd6OjtiiDLPdwHFJNFiEId7KF8Q3XH
         L0TpGX5dwy1XD3Qq/MelLYD7OOSdj1YdIwdftI91nfyfiK9x+X/MzVQ5pYZR/4WIPUZG
         4dQQ==
X-Gm-Message-State: AOAM532CtKXx3cehdEDg0BrpezdKIEG+dWO2w2JTBXCE3/2tPABpXabk
        7vKVKJPGpNWagJoNh8UQ6iV7E3ndawd/Bhl5HBWj8A==
X-Google-Smtp-Source: ABdhPJyaRY4zF9W3N5Owubw7wkii9tMo2zI4ulE85zYHRZIlQZtO1rU1FeijvcrIuKANKfUiFH8XX2WkOoqwrAZjOn8=
X-Received: by 2002:a17:907:62aa:b0:6e0:f208:b869 with SMTP id
 nd42-20020a17090762aa00b006e0f208b869mr18501699ejc.270.1652169989025; Tue, 10
 May 2022 01:06:29 -0700 (PDT)
MIME-Version: 1.0
References: <YnEeuw6fd1A8usjj@miu.piliscsaba.redhat.com> <20220509124815.vb7d2xj5idhb2wq6@wittgenstein>
 <CAJfpegveWaS5pR3O1c_7qLnaEDWwa8oi26x2v_CwDXB_sir1tg@mail.gmail.com> <8ab7f51cf18ba62e3f5bfdf5d9933895413f4806.camel@themaw.net>
In-Reply-To: <8ab7f51cf18ba62e3f5bfdf5d9933895413f4806.camel@themaw.net>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 10 May 2022 10:06:17 +0200
Message-ID: <CAJfpegv3MCHMzur9R+K+yZC3Z_Wmbq3=pQwuQ=+kQSrihg0c9g@mail.gmail.com>
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

On Tue, 10 May 2022 at 06:27, Ian Kent <raven@themaw.net> wrote:

> > Was there ever a test patch for systemd using fsinfo(2)?  I think
> > not.
>
> Mmm ... I'm hurt you didn't pay any attention to what I did on this
> during the original fsinfo() discussions.

I can't find anything related to this in my mailbox.  Maybe you
mentioned it at some point, but I have not been involved with the
actual systemd changes.  So not meant to belittle your work at all.

> > Until systemd people start to reengineer the mount handing to allow
> > for retrieving a single mount instead of the complete mount table we
> > will never know where the performance bottleneck lies.
>
> We didn't need the systemd people to do this only review and contribute
> to the pr for the change and eventually merge it.
>
> What I did on this showed that using fsinfo() allone about halved the
> CPU overhead (from around 4 processes using about 80%) and once the
> mount notifications was added too it went down to well under 10% per
> process. The problem here was systemd is quite good at servicing events
> and reducing event processing overhead meant more events would then be
> processed. Utilizing the mount notifications queueing was the key to
> improving this and that was what I was about to work on at the end.
>
> But everything stopped before the work was complete.
>
> As I said above it's been a long time since I looked at the systemd
> work and it definitely was a WIP so "what you see is what you get"
> at https://github.com/raven-au/systemd/commits/. It looks like the
> place to look to get some idea of what was being done is branch
> notifications-devel or notifications-rfc-pr. Also note that this
> uses the libmount fsinfo() infrastrucure that was done by Karal Zak
> (and a tiny bit by me) at the time.

Looks great as a first step.

What do you mean by "Utilizing the mount notifications queueing"?

Do you mean batching of notifications?   I think that's a very
important issue: processing each individual notifcation may not make
sense when there are lots of them.  For example, doing ceate
mount+remote mount in a loop a million times will result in two
million notification messages (with high likelyhood of queue
overflow), but in the end the mount table will end up being the
same...

Thanks,
Miklos
