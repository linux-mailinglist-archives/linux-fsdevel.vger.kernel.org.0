Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99F8B50DB5A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Apr 2022 10:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236095AbiDYIlS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Apr 2022 04:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbiDYIlO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Apr 2022 04:41:14 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2859F6C970
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Apr 2022 01:38:11 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id g6so5346100ejw.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Apr 2022 01:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VYj7gb2p+tfnsZdvnMq4DRXvqIJLzOEZPdR6J7EgYds=;
        b=jykvH8iYFyvyl0kpb3iWILAI/i44LQ5Xzw/dWEOXZwrptNnmkltE0jH88XVk/5aRoC
         sGT0DDavqPJNeLrcqn0exgkkNM2SWlGCOwFeX1SjESUEbasnm2oEoeoXN7AKlj/I4BOf
         yBdCVUj5q/U3yNmNZagHaBC5HRWisFOW1kw0o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VYj7gb2p+tfnsZdvnMq4DRXvqIJLzOEZPdR6J7EgYds=;
        b=F3Qs0ZjgZ6TTm9TWIxJUuGstUwt/VHCKLQnsNugPKUH/BY0cfGFwgndv/2ll2bPMvq
         gPqpxInkPENy04v6Z738J24l78A1MmLMYsyVB4JCET7U1mpEMiSjn8tOVSgy8/trwq+K
         lLgfjp0fvXx1SkiOYur1RJ90SS6hxsY0V5iYmUEcLCHycmZ4eFWrSWVNftyeZ2kM/vW3
         3Al4e8L36YpEliCd/IqX1aq3bZlARMdObtp09tH/0bcfLkKadiGeyc4I4XPcaphO68W+
         uAeSQUeHQn3tgaSSTY2Pyn3Te9ipokWcfrjyimfH7sexUzNtS9+0p90CdRGytxZxhv1T
         Uv1g==
X-Gm-Message-State: AOAM531SfFyq1P02V6Hzu+HTjacEGtKRlvq5n9Mi5wj2pHw/QpPVufyG
        4XeDX95Xm0A9k0t+DLyFtURxXECyzBYr2aUu6EdY3g==
X-Google-Smtp-Source: ABdhPJw5rzOA+Kvs5RQzl860wnNgugg/lvSgKBm2FCDCh1P4AnmqJxo3aTfj8Ri9bagdo1YtzjbrJcR6O/p6tPijugQ=
X-Received: by 2002:a17:907:1c11:b0:6f0:d63:69b3 with SMTP id
 nc17-20020a1709071c1100b006f00d6369b3mr15338656ejc.691.1650875889690; Mon, 25
 Apr 2022 01:38:09 -0700 (PDT)
MIME-Version: 1.0
References: <6ba14287-336d-cdcd-0d39-680f288ca776@ddn.com> <CAJfpegt=KZJKExpxPgGXoBEzWpzepL9cyaqS=dwW5AN6y2up_Q@mail.gmail.com>
 <d1955ffb-77ce-97a6-fcf2-b25960d389aa@fastmail.fm>
In-Reply-To: <d1955ffb-77ce-97a6-fcf2-b25960d389aa@fastmail.fm>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 25 Apr 2022 10:37:58 +0200
Message-ID: <CAJfpegsr3fqcFuNekLwf69v3mpNJyze741=L5KUJjvH758eE6g@mail.gmail.com>
Subject: Re: RFC fuse waitq latency
To:     Bernd Schubert <bernd.schubert@fastmail.fm>
Cc:     Bernd Schubert <bschubert@ddn.com>,
        Linux-FSDevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Dharmendra Singh <dsingh@ddn.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 22 Apr 2022 at 17:46, Bernd Schubert <bernd.schubert@fastmail.fm> wrote:
>
> [I removed the failing netapp/zufs CCs]
>
> On 4/22/22 14:25, Miklos Szeredi wrote:
> > On Mon, 28 Mar 2022 at 15:21, Bernd Schubert <bschubert@ddn.com> wrote:
> >>
> >> I would like to discuss the user thread wake up latency in
> >> fuse_dev_do_read(). Profiling fuse shows there is room for improvement
> >> regarding memory copies and splice. The basic profiling with flame graphs
> >> didn't reveal, though, why fuse is so much
> >> slower (with an overlay file system) than just accessing the underlying
> >> file system directly and also didn't reveal why a single threaded fuse
> >> uses less than 100% cpu, with the application on top of use also using
> >> less than 100% cpu (simple bonnie++ runs with 1B files).
> >> So I started to suspect the wait queues and indeed, keeping the thread
> >> that reads the fuse device for work running for some time gives quite
> >> some improvements.
> >
> > Might be related: I experimented with wake_up_sync() that didn't meet
> > my expectations.  See this thread:
> >
> > https://lore.kernel.org/all/1638780405-38026-1-git-send-email-quic_pragalla@quicinc.com/#r
> >
> > Possibly fuse needs some wake up tweaks due to its special scheduling
> > requirements.
>
> Thanks I will look at that as well. I have a patch with spinning and
> avoid of thread wake  that is almost complete and in my (still limited)
> testing almost does not take more CPU and improves meta data / bonnie
> performance in between factor ~1.9 and 3, depending on in which
> performance mode the cpu is.
>
> https://github.com/aakefbs/linux/commits/v5.17-fuse-scheduling3
>
> Missing is just another option for wake-queue-size trigger and handling
> of signals. Should be ready once I'm done with my other work.

Trying to understand what is being optimized here...  does the
following correctly describe your use case?

- an I/O thread is submitting synchronous requests (direct I/O?)

- the fuse thread always goes to sleep, because the request queue is
empty (there's always a single request on the queue)

- with this change the fuse thread spins for a jiffy before going to
sleep, and by that time the I/O thread will submit a new sync request.

- the I/O thread does not spin while the the fuse thread is processing
the request, so it still goes to sleep.

Thanks,
Miklos
