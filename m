Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1131F1E74
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jun 2020 19:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730041AbgFHRqJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Jun 2020 13:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbgFHRqI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Jun 2020 13:46:08 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A5C9C08C5C2;
        Mon,  8 Jun 2020 10:46:08 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id e11so12517551ilr.4;
        Mon, 08 Jun 2020 10:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=flU8txg+glWIi8fulPUwPzIPdeohInHSXaY33/9ThCw=;
        b=oWxGYT8A0b3THLWnp6+WNhUYr5lhxnC0iCsnVEWaHvL0MuzTTNd7uoI/JQzVbB1TSt
         0ivolbkn3faqqGPZHyCRpx+F3rnZwRJKcGGzdPzP3B/dLRRfcGIeiE3yLVe4WWgS0f4x
         Spv43/gjVHiZ7a2nLepfhlEJcDtFgUNOLiqDP84IjLvFhmBgO66qumLi3Rd0YLjC5Twt
         aIp95j+zb6wLr5zmts6GLFSyb2dEoWOhdikR1Lx73R3x5VkxGG3ieVHoHC0HfqGV/+PL
         /93E+q1WoTkfo4qyrUc8W3TDduY5TGBgEkDP5eZQSG785x9l3vlc7xFOlcWXUbZWS84K
         O+vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=flU8txg+glWIi8fulPUwPzIPdeohInHSXaY33/9ThCw=;
        b=byVjvYXHMSuNwz8TO7drOW7Pjkk/jn3ipWLfzO/x0Y+sPo8GTjF48H0y6UONlKmGFy
         obTyMyg8v65BnlpQcjK+RA5HfKTfhnLjfVsStZC3Wbto3iOHaVh4Zhpyy4S1Bwlf+Onb
         AJ4m4oNKM2JbrpsbwcB2Sk54DmQAvNhro12Db/WNAx9c/r7NEpyNTmWZgTIZCIgS338f
         9dTP40Gs7iAN0AjUb4Pyaab3Rpz3Y37cq4QDi4vwryeDHXbhobJlNTnbvRZwo8/zDyQu
         QYNYBu2sHgnJq6XK90oLWG2g5T1MqJgdQ2np8nMdrl3lsmEUy6qmt4DlHFRQYPPvqQvZ
         bqnw==
X-Gm-Message-State: AOAM533riWRsaMq9EftJuQMkr/bqH9qe9h7EQba+RYoyUlmPY2w7Kuxg
        pWgXmhdNsBgpbL5mAQMJZSisokU/smPEryKtbjUtA8Gh
X-Google-Smtp-Source: ABdhPJyfKtn7HoqtSpLNxQ7xQVqbp2EsASalnYA0qlI3rr8yKbjRc9BLAO+xaARmqQ/10tZ4f1u2dkSPjpVsx1Burgs=
X-Received: by 2002:a92:1b86:: with SMTP id f6mr23607749ill.9.1591638367400;
 Mon, 08 Jun 2020 10:46:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200608140557.GG3127@techsingularity.net> <20200608151943.GA861@quack2.suse.cz>
 <20200608165040.GI3127@techsingularity.net>
In-Reply-To: <20200608165040.GI3127@techsingularity.net>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 8 Jun 2020 20:45:56 +0300
Message-ID: <CAOQ4uxg2BKuRCfn7BH4FYnvrp_2rsgfgJ05pjjGOarx4C3E9Mw@mail.gmail.com>
Subject: Re: [PATCH] fsnotify: Rearrange fast path to minimise overhead when
 there is no watcher
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 8, 2020 at 7:50 PM Mel Gorman <mgorman@techsingularity.net> wrote:
>
> On Mon, Jun 08, 2020 at 05:19:43PM +0200, Jan Kara wrote:
> > > This is showing that the latencies are improved by roughly 2-9%. The
> > > variability is not shown but some of these results are within the noise
> > > as this workload heavily overloads the machine. That said, the system CPU
> > > usage is reduced by quite a bit so it makes sense to avoid the overhead
> > > even if it is a bit tricky to detect at times. A perf profile of just 1
> > > group of tasks showed that 5.14% of samples taken were in either fsnotify()
> > > or fsnotify_parent(). With the patch, 2.8% of samples were in fsnotify,
> > > mostly function entry and the initial check for watchers.  The check for
> > > watchers is complicated enough that inlining it may be controversial.
> > >
> > > Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> >
> > Thanks for the patch! I have to tell I'm surprised this small reordering
> > helps so much. For pipe inode we will bail on:
> >
> >        if (!to_tell->i_fsnotify_marks && !sb->s_fsnotify_marks &&
> >            (!mnt || !mnt->mnt_fsnotify_marks))
> >                return 0;
> >
> > So what we save with the reordering is sb->s_fsnotify_mask and
> > mnt->mnt_fsnotify_mask fetch but that should be the same cacheline as
> > sb->s_fsnotify_marks and mnt->mnt_fsnotify_marks, respectively.
>
> It is likely that the contribution of that change is marginal relative
> to the fsnotify_parent() call. I'll know by tomorrow morning at the latest.
>
> > We also
> > save a function call of fsnotify_parent() but I would think that is very
> > cheap (compared to the whole write path) as well.
> >
>
> To be fair, it is cheap but with this particular workload, we call
> vfs_write() a *lot* and the path is not that long so it builds up to 5%
> of samples overall. Given that these were anonymous pipes, it surprised
> me to see fsnotify at all which is why I took a closer look.
>

I should note that after:
7c49b8616460 fs/notify: optimize inotify/fsnotify code for unwatched files
Which speaks of a similar workload,
the code looked quite similar to your optimization.

It was:
60f7ed8c7c4d fsnotify: send path type events to group with super block marks

That started accessing ->x_fsnotify_mask before ->x_fsnotify_marks,
although I still find it hard to believe that this makes a real difference.

Thanks,
Amir.
