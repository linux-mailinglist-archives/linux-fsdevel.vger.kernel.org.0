Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C07B6C673C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Mar 2023 12:56:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbjCWL4H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Mar 2023 07:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbjCWLzo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Mar 2023 07:55:44 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C330D34C0D
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Mar 2023 04:55:30 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id cz11so12245747vsb.6
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Mar 2023 04:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679572530;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+g244NDjyuCCq96rI3Y/rJkxFolT/Tu9AzAiuIUfdu4=;
        b=JfwDhP1tx7yJxFzNVmVcqhNgZk9aVwqRNSMLTlyqYX8LK5WECQSlr+tbcYRmjJLQ+p
         CoAjpj5Zd7+m1iR/4PiziyLAFOwVkzNsGE3f7nFzjZ4nleczr1pCjv+WIZTLTOb4Hytd
         uyoJb1sXO67pMbZ7NGUru+LP2Y/VgUzwLbdUptZVQ9i0mf87bWjEQodAg2Wr3AgGvStx
         +d75i2gEI6FnGIdDxzBwjcsbjLesfzFUPGtFDnQf80AB/ro6RURO9XGW4gh8zNpYQ/1/
         o879Oxh+STbamrQ6+/fXs40E39bNBF1CPwscOqvoTBVJIOlnm1IZG5e4BHuJje8PUmSW
         HpVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679572530;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+g244NDjyuCCq96rI3Y/rJkxFolT/Tu9AzAiuIUfdu4=;
        b=NG2QpzWzypaKs8qtkDAkDBWtUhVvwdIsxjrTYZEKQeYqLFETV17HtdcMv+25BKvP/p
         tuCe3KwkzQZj8SiDppPZsFVpxQlZONzU6bE5M2JGQ3jrcNYhbYFd82/qtjKqoCRt+0Ol
         b+TRhDSgc3fOQ7oMp4hMdGZGCv1VqOUI3HihZ1hEqOmsu74SHBXyNIhb5ElCTR6H2xhQ
         vboWCQAJdWKMBWuH3kC0IdD0HiYfQeqKJQVDfCxtHZ9bZeePoX2iet5vVxcFl/a0c9kF
         q2pelfln2CZ/yPHHwTeVID/xfL98sR5ruyu1aNmPqwmDWQKKRv11latOVncIvg2vqnsg
         t1AA==
X-Gm-Message-State: AO0yUKXJi0+KmWoaPGmHBJMZNWhQOTCTow2tb+rnzwSY8dy5jFJ/Ta5r
        Mi4sTamIKColRI+zk0pIf5c7KJclOBF+vzQmhraK53oH9sQ=
X-Google-Smtp-Source: AK7set+8CiA8FyRW2yZKmCxGJnXQ5Ysl+y50NH0M6x8pZstrv/FkUweDIO1/ThD+btY9YfmO7bccS6fQV721HFF9dMI=
X-Received: by 2002:a05:6102:4751:b0:411:ffe1:9c6 with SMTP id
 ej17-20020a056102475100b00411ffe109c6mr1597686vsb.0.1679572529572; Thu, 23
 Mar 2023 04:55:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230321011047.3425786-1-bschubert@ddn.com> <CAOQ4uxjXZHr3DZUQVvcTisRy+HYNWSRWvzKDXuHP0w==QR8Yog@mail.gmail.com>
 <02f19f49-47f8-b1c5-224d-d7233b62bf32@fastmail.fm>
In-Reply-To: <02f19f49-47f8-b1c5-224d-d7233b62bf32@fastmail.fm>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 23 Mar 2023 13:55:18 +0200
Message-ID: <CAOQ4uxiDLV2y_HeUy1M-WWrNGdjn-drUxcoNczJBYRKOLXkkUQ@mail.gmail.com>
Subject: Re: [RFC PATCH 00/13] fuse uring communication
To:     Bernd Schubert <bernd.schubert@fastmail.fm>
Cc:     Bernd Schubert <bschubert@ddn.com>, linux-fsdevel@vger.kernel.org,
        Dharmendra Singh <dsingh@ddn.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        fuse-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 23, 2023 at 1:18=E2=80=AFPM Bernd Schubert
<bernd.schubert@fastmail.fm> wrote:
>
>
>
> On 3/21/23 10:35, Amir Goldstein wrote:
> > On Tue, Mar 21, 2023 at 3:11=E2=80=AFAM Bernd Schubert <bschubert@ddn.c=
om> wrote:
> >>
> >> This adds support for uring communication between kernel and
> >> userspace daemon using opcode the IORING_OP_URING_CMD. The basic
> >> appraoch was taken from ublk.  The patches are in RFC state -
> >> I'm not sure about all decisions and some questions are marked
> >> with XXX.
> >>
> >> Userspace side has to send IOCTL(s) to configure ring queue(s)
> >> and it has the choice to configure exactly one ring or one
> >> ring per core. If there are use case we can also consider
> >> to allow a different number of rings - the ioctl configuration
> >> option is rather generic (number of queues).
> >>
> >> Right now a queue lock is taken for any ring entry state change,
> >> mostly to correctly handle unmount/daemon-stop. In fact,
> >> correctly stopping the ring took most of the development
> >> time - always new corner cases came up.
> >> I had run dozens of xfstest cycles,
> >> versions I had once seen a warning about the ring start_stop
> >> mutex being the wrong state - probably another stop issue,
> >> but I have not been able to track it down yet.
> >> Regarding the queue lock - I still need to do profiling, but
> >> my assumption is that it should not matter for the
> >> one-ring-per-core configuration. For the single ring config
> >> option lock contention might come up, but I see this
> >> configuration mostly for development only.
> >> Adding more complexity and protecting ring entries with
> >> their own locks can be done later.
> >>
> >> Current code also keep the fuse request allocation, initially
> >> I only had that for background requests when the ring queue
> >> didn't have free entries anymore. The allocation is done
> >> to reduce initial complexity, especially also for ring stop.
> >> The allocation free mode can be added back later.
> >>
> >> Right now always the ring queue of the submitting core
> >> is used, especially for page cached background requests
> >> we might consider later to also enqueue on other core queues
> >> (when these are not busy, of course).
> >>
> >> Splice/zero-copy is not supported yet, all requests go
> >> through the shared memory queue entry buffer. I also
> >> following splice and ublk/zc copy discussions, I will
> >> look into these options in the next days/weeks.
> >> To have that buffer allocated on the right numa node,
> >> a vmalloc is done per ring queue and on the numa node
> >> userspace daemon side asks for.
> >> My assumption is that the mmap offset parameter will be
> >> part of a debate and I'm curious what other think about
> >> that appraoch.
> >>
> >> Benchmarking and tuning is on my agenda for the next
> >> days. For now I only have xfstest results - most longer
> >> running tests were running at about 2x, but somehow when
> >> I cleaned up the patches for submission I lost that.
> >> My development VM/kernel has all sanitizers enabled -
> >> hard to profile what happened. Performance
> >> results with profiling will be submitted in a few days.
> >
> > When posting those benchmarks and with future RFC posting,
> > it's would be useful for people reading this introduction for the
> > first time, to explicitly state the motivation of your work, which
> > can only be inferred from the mention of "benchmarks".
> >
> > I think it would also be useful to link to prior work (ZUFS, fuse2)
> > and mention the current FUSE performance issues related to
> > context switches and cache line bouncing that was discussed in
> > those threads.
>
> Oh yes sure, entirely forgot to mention the motivation. Will do in the
> next patch round. You don't have these links by any chance? I know that

I have this thread which you are on:
https://lore.kernel.org/linux-fsdevel/CAJfpegtjEoE7H8tayLaQHG9fRSBiVuaspnmP=
r2oQiOZXVB1+7g@mail.gmail.com/

> there were several zufs threads, but I don't remember discussions about
> cache line - maybe I had missed it. I can try to read through the old
> threads, in case you don't have it.

Miklos talked about it somewhere...

> Our own motivation for ring basically comes from atomic-open benchmarks,
> which gave totally confusing benchmark results in multi threaded libfuse
> mode - less requests caused lower IOPs - switching to single threaded
> then gave expect IOP increase. Part of it was due to a libfuse issue -
> persistent thread destruction/creation due to min_idle_threads, but
> another part can be explained with thread switching only. When I added
> (slight) spinning in fuse_dev_do_read(), the hard part/impossible part
> was to avoid letting multiple threads spin - even with a single threaded
> application creating/deleting files (like bonnie++), multiple libfuse
> threads started to spin for no good reason. So spinning resulted in a
> much improved latency, but high cpu usage, because multiple threads were
> spinning. I will add those explanations to the next patch set.
>

That would be great.

Thanks,
Amir.
