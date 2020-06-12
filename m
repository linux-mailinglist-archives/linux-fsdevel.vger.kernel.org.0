Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90F691F7EAA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Jun 2020 00:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbgFLWBe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Jun 2020 18:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbgFLWBb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Jun 2020 18:01:31 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB8DC08C5C1
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jun 2020 15:01:30 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id c17so12732550lji.11
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jun 2020 15:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JWYJp5nNaxwsgKcZ1Z6bBPv+CeaisGshv5pM/NlGa8g=;
        b=iGB7pNOJkr6LRcHMfXc8Hc5bgDWNnC9dhToyz0MVwqn+5ZDrq4FXB5hkdU+1LIx/wY
         29BCG06xc7ngZQKzimY3IdOfI1AOPkYaI0qAzWHwrDzGuh5uZPT59r9N9W8aG0jjBok4
         wPUVKZCV++VNxKinJaOsg6Y3DzKn42vwmy34o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JWYJp5nNaxwsgKcZ1Z6bBPv+CeaisGshv5pM/NlGa8g=;
        b=Id6VMrUwCa6WdekZ8xGvE3HwnxmsUmqfIfDfMJqjZiN/OFq46/hWHMf92KnLUXKqEi
         k45Om6JpGaeR56sF4Dy4d0pfugvl/+EHiTf4KcPzJiyZm+nFugZe2jY3rPpk6J+ANjxr
         z31OTlH7/Y+J9mTQdhMzJG+dYJo73Y4rUZE7cuw2Z1O30vaAayWVlXmgbm2eNK+Oer0s
         9O9D4hUn1nbsuExfRFi88kqVH1pEXomBh8U17H99ryCE80PXS7ViXcefoRWauT34Sv6E
         Y2Cwi1Nsk8w9H8fXsfwDxTVz6ldogn0956SaL6MUMyiOZUgvYSFxsLMszU8wksYqymNa
         CTOQ==
X-Gm-Message-State: AOAM530pTn5STL4DUbUTPiMbAQlyEywXeTSETy4NYOZ4pHBmjiTs9UvK
        yIvfhZQV3LVfvvPcnhcXsAv1XI7ri8E=
X-Google-Smtp-Source: ABdhPJzC+lam05sy2cGPPpaS50xkwdzfnY6tBhnWppi55zXwhXJy8SKSAWqwgskdYpRBJ8u8pICU7Q==
X-Received: by 2002:a2e:9709:: with SMTP id r9mr7591609lji.389.1591999288358;
        Fri, 12 Jun 2020 15:01:28 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id p2sm2049213ljg.95.2020.06.12.15.01.27
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jun 2020 15:01:27 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id d27so1716578lfq.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jun 2020 15:01:27 -0700 (PDT)
X-Received: by 2002:a19:6a0e:: with SMTP id u14mr7689820lfu.192.1591999286926;
 Fri, 12 Jun 2020 15:01:26 -0700 (PDT)
MIME-Version: 1.0
References: <1503686.1591113304@warthog.procyon.org.uk> <20200610111256.s47agmgy5gvj3zwz@ws.net.home>
In-Reply-To: <20200610111256.s47agmgy5gvj3zwz@ws.net.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 12 Jun 2020 15:01:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjUP6WmngGq70GFKrtDp5Z9mkqORtBD2uStp2p_H-nzqA@mail.gmail.com>
Message-ID: <CAHk-=wjUP6WmngGq70GFKrtDp5Z9mkqORtBD2uStp2p_H-nzqA@mail.gmail.com>
Subject: Re: [GIT PULL] General notification queue and key notifications
To:     Karel Zak <kzak@redhat.com>
Cc:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>, dray@redhat.com,
        Miklos Szeredi <mszeredi@redhat.com>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Jeff Layton <jlayton@redhat.com>, Ian Kent <raven@themaw.net>,
        andres@anarazel.de,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        keyrings@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[ Actually going through the code now ]

On Wed, Jun 10, 2020 at 4:13 AM Karel Zak <kzak@redhat.com> wrote:
>
> All the next operations are done with "fd". It's nowhere used as a
> pipe, and nothing uses pipefd[1].

As an aside, that isn't necessarily true.

In some of the examples, pipefd[1] is used for configuration (sizing
and adding filters), although I think right now that's not really
enforced, and other examples seem to have pipefd[0] do that too.

DavidH: should that perhaps be a hard rule, so that you can pass a
pipefd[0] to readers, while knowing that they can't then change the
kinds of notifications they see.

In the "pipe: Add general notification queue support" commit message,
the code example uses pipefd[0] for IOC_WATCH_QUEUE_SET_SIZE, but then
in the commit message for "watch_queue: Add a key/keyring notification
facility" it uses pipefd[1].

And that latter example does make sense: using the write-side
pipefd[1] for configuration, while the read-side pipefd[0] is the side
that sees the results. That is also how it would work if you have a
user-mode pipe with the notification source controlling the writing
side - the reading side can obviously not add filters or change the
semantics of the watches.

So that allows a trusted side to add and create filters, while some
untrusted entity can then see the results.

This isn't going to hold up me merging the code, but it would be good
to clarify and make that something that gets enforced if we decide
it's worth it.

It does seem conceptually like a good idea, and potentially actually
useful to clearly separate the domain of "you can add watches and
filters" from "you can see the notifications".

               Linus
