Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6860AB99EB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Sep 2019 01:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407024AbfITXFk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Sep 2019 19:05:40 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42148 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407007AbfITXFk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Sep 2019 19:05:40 -0400
Received: by mail-lf1-f68.google.com with SMTP id c195so6107220lfg.9
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Sep 2019 16:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mtHJRljpIthtHGh3XxE5kG38evjyZkXXa2KwhkF3cfE=;
        b=Cc5gWnHvSFkt/XOMA27VwmYwG7DVJmBzs0dIyEV6yq14mog53/7iNdQvPU8DH7UYCO
         WARG7/ZwIOBICzkQ8IQmexLNL7Ke5E6YBstlJKL71nq+d4fqB4s2qSAcsuYAbWAYHSRu
         k6yu+jXAPxOkH/L5OLNGuUB3Vt3R3U+Wxs+NE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mtHJRljpIthtHGh3XxE5kG38evjyZkXXa2KwhkF3cfE=;
        b=RdwiMjvHjAVeSzfa8wL52gYycHQXykr/POQyA+O36uMUP8uYVrtOP+cDu7aJhe5CKR
         UG0RoqpgLX0Jxs/cgJejkDGxq6LEv/t5uj/5Ldulj7+mx4hbzP4zvuTbLbbcI4Ioz7Z+
         mn0vn0G1G7JlnK3r0FRBBEhBTtLx3xMVIYzZ+QS6IXi6/j5WFtlvsaRaD86nkw3xNzTX
         Cc7gxFXW4DmGCds647oSdsD7imxpjLrdpR9aDwXAhdXgVB0Hs6noP8fLUmFP0ZDqvdot
         LoULU3yZ3KMiGAlfg+2y7ClF6zBWGva4VSrau3OTSlktniSEUYRcN8gZn4MHAtobelHh
         qpkg==
X-Gm-Message-State: APjAAAUgQjDOKj21b6BXTtSrGigVRMgu15euZ4lV6IH1RXJTEEvMYg/x
        3s3uLnFKrqp0Jlq2gYfJWsq7gI/fPiI=
X-Google-Smtp-Source: APXvYqxkQhGChScLy31VFvOw/tCu3e4NBBx9hwXC5VIlEUUS92WoInbfDc7ft1AyQXjCyloVZc13YA==
X-Received: by 2002:ac2:59c2:: with SMTP id x2mr9046202lfn.125.1569020737082;
        Fri, 20 Sep 2019 16:05:37 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id s1sm760253lfd.14.2019.09.20.16.05.34
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Sep 2019 16:05:35 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id l21so8583250lje.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Sep 2019 16:05:34 -0700 (PDT)
X-Received: by 2002:a2e:96d3:: with SMTP id d19mr1246398ljj.165.1569020733395;
 Fri, 20 Sep 2019 16:05:33 -0700 (PDT)
MIME-Version: 1.0
References: <156896493723.4334.13340481207144634918.stgit@buzz>
In-Reply-To: <156896493723.4334.13340481207144634918.stgit@buzz>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 20 Sep 2019 16:05:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=whmCZvYcR10Pe9fEy912fc8xywbiP9mn054Jg_9+0TqCg@mail.gmail.com>
Message-ID: <CAHk-=whmCZvYcR10Pe9fEy912fc8xywbiP9mn054Jg_9+0TqCg@mail.gmail.com>
Subject: Re: [PATCH v2] mm: implement write-behind policy for sequential file writes
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Michal Hocko <mhocko@suse.com>,
        Dave Chinner <david@fromorbit.com>,
        Mel Gorman <mgorman@suse.de>,
        Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 20, 2019 at 12:35 AM Konstantin Khlebnikov
<khlebnikov@yandex-team.ru> wrote:
>
> This patch implements write-behind policy which tracks sequential writes
> and starts background writeback when file have enough dirty pages.

Apart from a spelling error ("contigious"), my only reaction is that
I've wanted this for the multi-file writes, not just for single big
files.

Yes, single big files may be a simpler and perhaps the "10% effort for
90% of the gain", and thus the right thing to do, but I do wonder if
you've looked at simply extending it to cover multiple files when
people copy a whole directory (or unpack a tar-file, or similar).

Now, I hear you say "those are so small these days that it doesn't
matter". And maybe you're right. But partiocularly for slow media,
triggering good streaming write behavior has been a problem in the
past.

So I'm wondering whether the "writebehind" state should perhaps be
considered be a process state, rather than "struct file" state, and
also start triggering for writing smaller files.

Maybe this was already discussed and people decided that the big-file
case was so much easier that it wasn't worth worrying about
writebehind for multiple files.

            Linus
