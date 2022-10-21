Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2D52607092
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Oct 2022 08:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbiJUG53 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Oct 2022 02:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiJUG51 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Oct 2022 02:57:27 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA2E3244714
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Oct 2022 23:57:24 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id d26so4851021ejc.8
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Oct 2022 23:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=D0qREkhtBFfUSew1zsFqOFwIS6EywWtUfuoiS8sZqVk=;
        b=MFHrN7qGaabnyWRR9UENgIArfJYl3CIKOElAqKHJShrAoSabyqqwVnoRBzXEWRM2Qg
         jNloPn8mozbUus10zCY53V/ac93pJYSfZinxn5iZ9ruC6dVJQrIzjN56ep1TqgMVd9tI
         GvALIONGSYw4+B52usWLQCgO4Ea9sl/3e61ME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D0qREkhtBFfUSew1zsFqOFwIS6EywWtUfuoiS8sZqVk=;
        b=Eh4mPAM+L8YqQs6MdpbkBvDglNoDfLPR7zOtfyaFm6zcGHDtgvotB2+P7M2FO1/1mr
         0JqSrVFM8LYs7u35IAtlIxpVpBEzZSc7uQw3d+0XH9ZxcRGfIseKI96wy3mxbLOZFDNX
         MkbQZdVEC3frM7CKeJzi6pDdO36/8F1XBoqcc4IbJzjUz7SP5pLDdq3HGi7mrEW183zv
         JXxLGx5NrxBi5mPOk+axkMJfdsrjTIe+yPTbXbFDRsofk7PaE4+dt6XaVkulkfMI52xV
         ND5Zqs8zdfQZ5m/anWLyWdj77ShzGNzQ0XFSsFZmuGBWVUti09cz6quBbtIr32QxDVCH
         z3Ig==
X-Gm-Message-State: ACrzQf1yecis2PWlH7IKH8JptJ4eg+ZGP2rXsYNNP4U9k+TLNYOcoppt
        1pLR84iMoEaoZr1Ckc4q+8uwgWmzmWsOTmZuf6MLCnsHWWU=
X-Google-Smtp-Source: AMsMyM5Neyg680cumjv6r9jMvW6X80/vorKpk/U8Or4N1HdNRw8fr5qRp706CxrBUalv7ZXY24e4ULL/g4pVnn6Q8s0=
X-Received: by 2002:a17:906:ef8c:b0:78d:4a00:7c7b with SMTP id
 ze12-20020a170906ef8c00b0078d4a007c7bmr14709843ejb.187.1666335443006; Thu, 20
 Oct 2022 23:57:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220617071027.6569-1-dharamhans87@gmail.com> <20220617071027.6569-2-dharamhans87@gmail.com>
 <CAJfpegtRzDbcayn7MYKpgO1MBFeBihyfRB402JHtJkbXg1dvLg@mail.gmail.com>
 <08d11895-cc40-43da-0437-09d3a831b27b@fastmail.fm> <CAJfpegvSK0VmU6cLx5kiuXJ=RyL0d4=gvGLFCWQ16FrBGKmhMQ@mail.gmail.com>
 <4f0f82ff-69aa-e143-e254-f3da7ccf414d@ddn.com>
In-Reply-To: <4f0f82ff-69aa-e143-e254-f3da7ccf414d@ddn.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 21 Oct 2022 08:57:11 +0200
Message-ID: <CAJfpegt6QBZK68aXMg2OA=id3fMjBPZHTr6AqkKVqzV3eA_4Fw@mail.gmail.com>
Subject: Re: [PATCH v5 1/1] Allow non-extending parallel direct writes on the
 same file.
To:     Bernd Schubert <bschubert@ddn.com>
Cc:     Dharmendra Singh <dharamhans87@gmail.com>,
        Vivek Goyal <vgoyal@redhat.com>, linux-fsdevel@vger.kernel.org,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        linux-kernel@vger.kernel.org, Dharmendra Singh <dsingh@ddn.com>,
        Horst Birthelmer <hbirthelmer@ddn.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 13 Sept 2022 at 10:44, Bernd Schubert <bschubert@ddn.com> wrote:
>
>
>
> On 6/17/22 14:43, Miklos Szeredi wrote:
> > On Fri, 17 Jun 2022 at 11:25, Bernd Schubert <bernd.schubert@fastmail.fm> wrote:
> >>
> >> Hi Miklos,
> >>
> >> On 6/17/22 09:36, Miklos Szeredi wrote:
> >>> On Fri, 17 Jun 2022 at 09:10, Dharmendra Singh <dharamhans87@gmail.com> wrote:
> >>>
> >>>> This patch relaxes the exclusive lock for direct non-extending writes
> >>>> only. File size extending writes might not need the lock either,
> >>>> but we are not entirely sure if there is a risk to introduce any
> >>>> kind of regression. Furthermore, benchmarking with fio does not
> >>>> show a difference between patch versions that take on file size
> >>>> extension a) an exclusive lock and b) a shared lock.
> >>>
> >>> I'm okay with this, but ISTR Bernd noted a real-life scenario where
> >>> this is not sufficient.  Maybe that should be mentioned in the patch
> >>> header?
> >>
> >>
> >> the above comment is actually directly from me.
> >>
> >> We didn't check if fio extends the file before the runs, but even if it
> >> would, my current thinking is that before we serialized n-threads, now
> >> we have an alternation of
> >>          - "parallel n-1 threads running" + 1 waiting thread
> >>          - "blocked  n-1 threads" + 1 running
> >>
> >> I think if we will come back anyway, if we should continue to see slow
> >> IO with MPIIO. Right now we want to get our patches merged first and
> >> then will create an updated module for RHEL8 (+derivatives) customers.
> >> Our benchmark machines are also running plain RHEL8 kernels - without
> >> back porting the modules first we don' know yet what we will be the
> >> actual impact to things like io500.
> >>
> >> Shall we still extend the commit message or are we good to go?
> >
> > Well, it would be nice to see the real workload on the backported
> > patch.   Not just because it would tell us if this makes sense in the
> > first place, but also to have additional testing.
>
>
> Sorry for the delay, Dharmendra and me got busy with other tasks and
> Horst (in CC) took over the patches and did the MPIIO benchmarks on 5.19.
>
> Results with https://github.com/dchirikov/mpiio.git
>
>                 unpatched    patched      patched
>                 (extending) (extending)  (non-extending)
> ----------------------------------------------------------
>                  MB/s        MB/s            MB/s
> 2 threads     2275.00      2497.00       5688.00
> 4 threads     2438.00      2560.00      10240.00
> 8 threads     2925.00      3792.00      25600.00
> 16 threads    3792.00     10240.00      20480.00
>
>
> (Patched-nonextending is a manual operation on the file to extend the
> size, mpiio does not support that natively, as far as I know.)
>
>
>
> Results with IOR (HPC quasi standard benchmark)
>
> ior -w -E -k -o /tmp/test/home/hbi/test/test.1 -a mpiio -s 1280 -b 8m -t 8m
>
>
>                 unpatched       patched
>                 (extending)     (extending)
> -------------------------------------------
>                    MB/s           MB/s
> 2 threads       2086.10         2027.76
> 4 threads       1858.94         2132.73
> 8 threads       1792.68         4609.05
> 16 threads      1786.48         8627.96
>
>
> (IOR does not allow manual file extension, without changing its code.)
>
> We can see that patched non-extending gives the best results, as
> Dharmendra has already posted before, but results are still
> much better with the patches in extending mode. My assumption is here
> instead serializing N-writers, there is an alternative
> run of
>         - 1 thread extending, N-1 waiting
>         - N-1 writing, 1 thread waiting
> in the patched version.
>

Okay, thanks for the heads up.

I queued the patch up for v6.2

Thanks,
Miklos


>
>
> Thanks,
> Bernd
