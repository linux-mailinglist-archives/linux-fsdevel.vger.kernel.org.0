Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA5311BA72
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2019 18:37:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730010AbfLKRhm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Dec 2019 12:37:42 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37361 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728128AbfLKRhm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Dec 2019 12:37:42 -0500
Received: by mail-lj1-f196.google.com with SMTP id u17so25022315lja.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Dec 2019 09:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/qPDI4CWJjC5/5bz94R850+eMWjiIMaPpEB5QatbHqs=;
        b=LtAWLNJIGgleEYyJY7SqUMGfF7zizqXB9fYINThzWBGo8tnYIl1k6mXoeKI7sQzQdq
         EPnru+FlO2NXMV0jrkNCbK7iiC4wwbei2gwxVjVLVdeaIlu64BeNLRHNskMdjZ4IKCGH
         RZm3Yapso6JOJSyQl9vuO5BT87Tpq60EJwBYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/qPDI4CWJjC5/5bz94R850+eMWjiIMaPpEB5QatbHqs=;
        b=nWrtefRj6IYWPTBtuhNUMiXA01CKUmGJHtsj+xg4KeLlpC/BsXjHOXFWHxIkMvIdMx
         z8TbkjrdBGZDwZf7adpyQRpbcFl9s/pTnAMcFrTW0yrtCgy6uidfL7upnmle7syb7koX
         35PyyN2e/z5V2TiQq6DQVyIxt8nFdDWO9y5vlolaPhDk8U1XyBG61U7YXZrP65HqBHzy
         RziwScgYCMwgXEUOgx8pXvq2DiIT92LJqoI9zZGsH0Y1qkGJgo3LRuOXKU6Vwk3sTPZ+
         LY3/gjxzM1oehbWt4I/DBKoV31lUw9plrX7VjaYIfTy+HopoOs+YGnLXV0f6IPhF9D49
         5pdQ==
X-Gm-Message-State: APjAAAX+paU8e8Zn2M49dXpg3ITE1ZTTvkcleSP/MFOwrGoIevQyCAXs
        PSyabGRXx2aKgHcCFFDANDMZZWkx5qM=
X-Google-Smtp-Source: APXvYqxvpGV2GJob0mb1P9U1FtnG6NyXgQIuvukxthZBcFH2q1dxGNa+O/I7w9LHRzgsqt3zhxwqwQ==
X-Received: by 2002:a2e:9b52:: with SMTP id o18mr2893582ljj.205.1576085860056;
        Wed, 11 Dec 2019 09:37:40 -0800 (PST)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id w6sm1509736lfq.95.2019.12.11.09.37.38
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2019 09:37:39 -0800 (PST)
Received: by mail-lj1-f176.google.com with SMTP id e28so24978305ljo.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Dec 2019 09:37:38 -0800 (PST)
X-Received: by 2002:a2e:9041:: with SMTP id n1mr3004616ljg.133.1576085858434;
 Wed, 11 Dec 2019 09:37:38 -0800 (PST)
MIME-Version: 1.0
References: <20191211152943.2933-1-axboe@kernel.dk>
In-Reply-To: <20191211152943.2933-1-axboe@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 11 Dec 2019 09:37:22 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjz3LE1kznro1dozhk9i9Dr4pCnkj7Fuccn2xdWeGHawQ@mail.gmail.com>
Message-ID: <CAHk-=wjz3LE1kznro1dozhk9i9Dr4pCnkj7Fuccn2xdWeGHawQ@mail.gmail.com>
Subject: Re: [PATCHSET v3 0/5] Support for RWF_UNCACHED
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>, Chris Mason <clm@fb.com>,
        Dave Chinner <david@fromorbit.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 11, 2019 at 7:29 AM Jens Axboe <axboe@kernel.dk> wrote:
>
> Comments appreciated! This should work on any standard file system,
> using either the generic helpers or iomap. I have tested ext4 and xfs
> for the right read/write behavior, but no further validation has been
> done yet. Patches are against current git, and can also be found here:

I don't think this is conceptually wrong, but the implementation smells a bit.

I commented on the trivial part (the horrendous argument list to
iomap_actor), but I wonder how much of the explicit invalidation is
actually needed?

Because active invalidation really is a horrible horrible thing to do.
It immediately means that you can't use this interface for normal
everyday things that may actually cache perfectly fine.

What happens if you simply never _activate_ the page? Then they should
get invalidated on their own, without impacting any other load - but
only when there is _some_ memory pressure. They'll just stay on the
inactive lru list, and get re-used quickly.

Note that there are two ways to activate a page: the "accessed while
on the inactive list" will activate it, but these days we also have a
"pre-activate" path in the workingset code (see workingset_refault()).

Even if you might also want an explicit invalidate path, I would like
to hear what it looks like if you instead of - or in addition to -
invalidating, have a "don't activate" flag.

We don't have all _that_ many places where we activate pages, and they
should be easy to find (just grep for "SetPageActive()"), although the
call chain may make it a bit painful to add a "don't do it for this
access" kind of things.

But I think most of the regular IO call chains come through
"mark_page_accessed()". So _that_ is the part you want to avoid (and
maybe the workingset code). And that should be fairly straightforward,
I think.

In fact, that you say that just a pure random read case causes lots of
kswapd activity makes me think that maybe we've screwed up page
activation in general, and never noticed (because if you have enough
memory, you don't really see it that often)? So this might not be an
io_ring issue, but an issue in general.

                     Linus
