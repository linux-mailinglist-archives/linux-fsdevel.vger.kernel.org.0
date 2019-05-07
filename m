Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDD8F15FBB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2019 10:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbfEGItJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 May 2019 04:49:09 -0400
Received: from mail-wr1-f53.google.com ([209.85.221.53]:43201 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbfEGItI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 May 2019 04:49:08 -0400
Received: by mail-wr1-f53.google.com with SMTP id r4so5809983wro.10
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 May 2019 01:49:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eDqWezXMALgcwT8s3H6PEODX+jJb0aIcO1v12Ssi1bc=;
        b=L6EbqEawkyvP91PQ/ogSPbAtiglWo6xcUU38rxyNZiG4uXkFLyRmAXAWuOyq0rNvvH
         /gtcEwyFfd+9TEgUulYvPQ20WIyujhzWWiFcx3C9WZ3nJ2Ly8/LF1FPBnAbbJE1f8qls
         gmi6Z1fqvkKKx4SsoG0bp+AN95n5RssRMp+Nq5/Gts/BBu2/+PEp8FeKcM91ZD+jUSuU
         8bddIX6a5dxC0Tzd5nyKJA9a4qmhZlymZfeyFHWph7A9zbgmKuKnWNLPFwtlQV8TXMVW
         CimVVPx1JeWacmp2WU7w/CDMWcy/eIgmmPjZpRAh1zjBD0EodsJzD+FK3pZnmHKxqC/y
         exmw==
X-Gm-Message-State: APjAAAVimGPe0BDXV6JulS2GBnBKo1U7oJOyfN3swZrT4NYpI6kahdYa
        bbBgfqeQ1mZEEvBbFg5wvJtA5CaJyNAK7Wgj8Cah5g==
X-Google-Smtp-Source: APXvYqyBWsiJINBU5xtijGWkwXIOzI1HRrMl+F3lMjtbgV5GJHcWzPpfd3oGScFrpc7M708L5NaRTzNDu2iBbA77twQ=
X-Received: by 2002:adf:f108:: with SMTP id r8mr11467848wro.221.1557218946960;
 Tue, 07 May 2019 01:49:06 -0700 (PDT)
MIME-Version: 1.0
References: <4a484c50-ef29-2db9-d581-557c2ea8f494@gmail.com> <20190507071021.wtm25mxx2as6babr@work>
In-Reply-To: <20190507071021.wtm25mxx2as6babr@work>
From:   Jan Tulak <jtulak@redhat.com>
Date:   Tue, 7 May 2019 10:48:55 +0200
Message-ID: <CACj3i71HdW0ys_YujGFJkobMmZAZtEPo7B2tgZjEY8oP_T9T6g@mail.gmail.com>
Subject: Re: Testing devices for discard support properly
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     Ric Wheeler <ricwheeler@gmail.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Nikolay Borisov <nborisov@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 7, 2019 at 9:10 AM Lukas Czerner <lczerner@redhat.com> wrote:
>
> On Mon, May 06, 2019 at 04:56:44PM -0400, Ric Wheeler wrote:
> >
...
> >
> > * Whole device discard at the block level both for a device that has been
> > completely written and for one that had already been trimmed
>
> Yes, usefull. Also note that a long time ago when I've done the testing
> I noticed that after a discard request, especially after whole device
> discard, the read/write IO performance went down significanly for some
> drives. I am sure things have changed, but I think it would be
> interesting to see how does it behave now.
>
> >
> > * Discard performance at the block level for 4k discards for a device that
> > has been completely written and again the same test for a device that has
> > been completely discarded.
> >
> > * Same test for large discards - say at a megabyte and/or gigabyte size?
>
> From my testing (again it was long time ago and things probably changed
> since then) most of the drives I've seen had largely the same or similar
> timing for discard request regardless of the size (hence, the conclusion
> was the bigger the request the better). A small variation I did see
> could have been explained by kernel implementation and discard_max_bytes
> limitations as well.
>
> >
> > * Same test done at the device optimal discard chunk size and alignment
> >
> > Should the discard pattern be done with a random pattern? Or just
> > sequential?
>
> I think that all of the above will be interesting. However there are two
> sides of it. One is just pure discard performance to figure out what
> could be the expectations and the other will be "real" workload
> performance. Since from my experience discard can have an impact on
> drive IO performance beyond of what's obvious, testing mixed workload
> (IO + discard) is going to be very important as well. And that's where
> fio workloads can come in (I actually do not know if fio already
> supports this or not).
>

And:

On Tue, May 7, 2019 at 10:22 AM Nikolay Borisov <nborisov@suse.com> wrote:
> I have some vague recollection this was brought up before but how sure
> are we that when a discard request is sent down to disk and a response
> is returned the actual data has indeed been discarded. What about NCQ
> effects i.e "instant completion" while doing work in the background. Or
> ignoring the discard request altogether?


As Nikolay writes in the other thread, I too have a feeling that there
have been a discard-related discussion at LSF/MM before. And if I
remember, there were hints that the drives (sometimes) do asynchronous
trim after returning a success. Which would explain the similar time
for all sizes and IO drop after trim.

So, I think that the mixed workload (IO + discard) is a pretty
important part of the whole topic and a pure discard test doesn't
really tell us anything, at least for some drives.

Jan



-- 
Jan Tulak
