Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54961E62D4
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Oct 2019 15:04:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbfJ0OD6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 27 Oct 2019 10:03:58 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46902 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbfJ0OD5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 27 Oct 2019 10:03:57 -0400
Received: by mail-lj1-f193.google.com with SMTP id w8so4043211lji.13
        for <linux-fsdevel@vger.kernel.org>; Sun, 27 Oct 2019 07:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aUtxqBrTqUG2JQM67qlbeu/gWrmsCKLHs/nf3HjwR6o=;
        b=UBVoDLidxhGRZnO3t3s9odW+975NWscpsgyn72pMoIFtMXrLI8gYCDX8RoEk4dUGpu
         XShVkulYmvYa4f4vPiGJkAOAAjj/NBHXSLZISLlhGaOzl5SAbZ6BhT9CpKJEgEzb8LhN
         G2c7dQQvyPPapIvGT5FeHB9zbcHI3CN4A0Ff0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aUtxqBrTqUG2JQM67qlbeu/gWrmsCKLHs/nf3HjwR6o=;
        b=nxKKaE9I9rb2jCWiWBuSC74Xq6tv8DG/qZ1P60pw1JKic15kNM73qnaJU/Yo1yEDru
         c8pA/8CP9yOK/XTroRne32JZwQss1/4KYc3P95COtIEUfXcmnwicIJ6tm9aIw4cnQ/2v
         9Dsp3K9gv0UtuFGIp5nH9ugiJBmTag4QA4UPBaUfRYwF57bBeqm5ObWjpup8huGefMrI
         ovrjZjKFyekwq4BSpFTEvYn8HnDWP7zEUGP7Qo9ZQQyjDzmXUmf7+r4f/IzNRiO0itkz
         6zMZUZKzknSPlHP++VaCNYfg+gI5j1e7dIzcSKMBY1XuXT3LTu1lymRtGaYdD1mQAIWK
         f5PA==
X-Gm-Message-State: APjAAAVL0iV2bBUkq/Mf1UgXKifMLxNYQHG60JKBrqpfTmerVT07A5DP
        rAdb6NiXKOs//0AjdX08lO5o/eX74xvaEg==
X-Google-Smtp-Source: APXvYqxJFoxjCBvf/1v6Uu1Aa9OPhWzHC4OfQjx7++AhbasJWckfWERrRWcU5Y5CeeJx0olLFJ+T3A==
X-Received: by 2002:a2e:42d6:: with SMTP id h83mr8640782ljf.21.1572185034641;
        Sun, 27 Oct 2019 07:03:54 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id l24sm3707688lfc.53.2019.10.27.07.03.52
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Oct 2019 07:03:52 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id u22so8548983lji.7
        for <linux-fsdevel@vger.kernel.org>; Sun, 27 Oct 2019 07:03:52 -0700 (PDT)
X-Received: by 2002:a05:651c:331:: with SMTP id b17mr8760744ljp.133.1572185032112;
 Sun, 27 Oct 2019 07:03:52 -0700 (PDT)
MIME-Version: 1.0
References: <157186182463.3995.13922458878706311997.stgit@warthog.procyon.org.uk>
 <157186186167.3995.7568100174393739543.stgit@warthog.procyon.org.uk>
In-Reply-To: <157186186167.3995.7568100174393739543.stgit@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 27 Oct 2019 10:03:35 -0400
X-Gmail-Original-Message-ID: <CAHk-=wh7cf3ANq-G9MmwSQiUK2d-=083C0HV_8hTGe2Mb4X7JA@mail.gmail.com>
Message-ID: <CAHk-=wh7cf3ANq-G9MmwSQiUK2d-=083C0HV_8hTGe2Mb4X7JA@mail.gmail.com>
Subject: Re: [RFC PATCH 04/10] pipe: Use head and tail pointers for the ring,
 not cursor and length [ver #2]
To:     David Howells <dhowells@redhat.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>, raven@themaw.net,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This still has signs of that earlier series:

On Wed, Oct 23, 2019 at 4:17 PM David Howells <dhowells@redhat.com> wrote:
>
>                 if (rem >= ibuf->len) {
>                         *obuf = *ibuf;
>                         ibuf->ops = NULL;
> -                       pipe->curbuf = (pipe->curbuf + 1) & (pipe->buffers - 1);
> -                       pipe->nrbufs--;
> +                       tail++;
> +                       pipe_commit_read(pipe, tail);
>                 } else {
>                         if (!pipe_buf_get(pipe, ibuf))
>                                 goto out_free;

with those odd "pipe_commit_read/write()" helpers.

They make no sense, and they don't make things more legible.

It's shorter and more obvious to just write

   pipe->head = head;

than it is to write

   pipe_commit_write(pipe, head);

Even when the addition of the notifications,  it's all under the
pipe->wait.lock, so it's all just regular assignments.

Now, if at some point it starts doing fancy lockless things, at _that_
point the updates might become more complex, but that's a potential
future thing that wouldn't be relevant for a while, and isn't a reason
to make the code more obscure now.

Hmm?

             Linus
