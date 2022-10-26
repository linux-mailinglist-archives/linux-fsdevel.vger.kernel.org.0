Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6757660E07E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Oct 2022 14:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233741AbiJZMSD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Oct 2022 08:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233282AbiJZMSC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Oct 2022 08:18:02 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD690DDA20
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Oct 2022 05:18:01 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id t15so6429264edd.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Oct 2022 05:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6yzw6+maSr+v8Y7t/htw292HhtPNBaI9v4IImMyQywI=;
        b=jR2GZ6shPIK7x8ePXQ3LoAIKM/UwPKkbmI129rs/i/djUiZ76zCleMWwbO3cyrzY0T
         v1hjZ07cj7G/4wIwNYAYLdxyefwSpJ3q/J7pHD2HuEWHAPXx8nmdBYl6uOVvz1bU5TAi
         FFOrMkotVRn8/h/D41xyykq9gOewqppnS05PY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6yzw6+maSr+v8Y7t/htw292HhtPNBaI9v4IImMyQywI=;
        b=YHcCeEAlLdpU7bRZVKtkPdH1akB8QrCif5jl7ZLA2wvoowi3q92lNmCfGuzxf+a6Re
         szUfQpJJIiyr9gAXgFzCcjaPkO0pUkofMHn18OAE1JdPwPuqGnu2Kk3V37zw3TstYotO
         O3LtwWolmhDNpzprNo/fVePYtlPbsjfzLjxhRQ6Djev9O6CoEAlFzt9L7t4Nh+kTO9V7
         OAlBtf+aVvVSEM/NwqAFIgfk537phVlHnzGZVepGDq7U20Nu14sx/wAh6cm+NVG56NBv
         0CRwk01nJFR804hWtU2Ojm+lzSyMNnlZaBwA4PNFwd+ga4e8YF6bGGFaOxPr9grKuJkF
         OB0A==
X-Gm-Message-State: ACrzQf3QDZtyOfG7UioIWkkdlz82+DaXgRDvkdXU7mPm2tolu9RWJoh0
        C7jz3y7DaXPlhwvRmnFHvDpwyTSBROzD49lrvxPjXQ==
X-Google-Smtp-Source: AMsMyM40/fRsTKgy9H/VEFjMzTlBbRGPtzS+IOLwY9GGewZC2D7iC8OBcjVvGjiIKIsZyvh0hhQIxEYB7R6d1ZCaHls=
X-Received: by 2002:a05:6402:370c:b0:453:9fab:1b53 with SMTP id
 ek12-20020a056402370c00b004539fab1b53mr41777487edb.28.1666786680472; Wed, 26
 Oct 2022 05:18:00 -0700 (PDT)
MIME-Version: 1.0
References: <87mtaxt05z.fsf@vostro.rath.org> <CAJfpegv=1UjycheWyANxsoOM5oCf7DGs9OKNzhNw_dSETBDCVQ@mail.gmail.com>
 <7d293f21-c0b4-46eb-6822-4015560f787e@spawn.link> <CAJfpegt0bt6UDPy1Z2b=MZ1yAWg5xphDhTm6s-TjEnqy30xQCA@mail.gmail.com>
In-Reply-To: <CAJfpegt0bt6UDPy1Z2b=MZ1yAWg5xphDhTm6s-TjEnqy30xQCA@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 26 Oct 2022 14:17:49 +0200
Message-ID: <CAJfpegtUtmkVcJrUyAFwA53rhBvMaX1Pe3Jk4FrVgfVEKo2kQA@mail.gmail.com>
Subject: Re: Should FUSE set IO_FLUSHER for the userspace process?
To:     Antonio SJ Musumeci <trapexit@spawn.link>
Cc:     Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        miklos <mszeredi@redhat.com>
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

On Wed, 26 Oct 2022 at 13:58, Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Tue, 25 Oct 2022 at 17:39, Antonio SJ Musumeci <trapexit@spawn.link> wrote:
> >
> > On 9/19/22 05:20, Miklos Szeredi wrote:
> > > On Sun, 18 Sept 2022 at 13:03, Nikolaus Rath <Nikolaus@rath.org> wrote:
> > >> Hi,
> > >>
> > >> Should the FUSE kernel driver perhaps set PR_SET_IO_FLUSHER for the FUSE
> > >> userspace process daemon when a connection is opened?
> > >>
> > >> If I understand correctly, this is necessary to avoid a deadlocks if the
> > >> kernel needs to reclaim memory that has to be written back through FUSE.
> > > The fuse kernel driver is careful to avoid such deadlocks.  When
> > > memory reclaim happens, it copies data to temporary buffers and
> > > immediately finishes the reclaim from the memory management
> > > subsystem's point of view.   The temp buffers are then sent to
> > > userspace and written back without having to worry about deadlocks.
> > > There are lots of details missing from the above description, but this
> > > is the essence of the writeback deadlock avoidance.
> > >
> > > Thanks,
> > > Miklos
> >
> > Miklos, does this mean that FUSE servers shouldn't bother setting
> > PR_SET_IO_FLUSHER? Are there any benefits to setting it explicitly or
> > detriments to not setting it?
>
> PR_SET_IO_FLUHSER internally sets the process flags PF_MEMALLOC_NOIO
> and PF_LOCAL_THROTTLE.
>
> The former is clear: don't try to initiate I/O when memory needs to be
> reclaimed.  This could be detrimental in low memory situations, since
> the kernel has less choice for freeing up memory.
>
> PF_LOCAL_THROTTLE  seems to mean "don't throttle dirtying pages
> (writes) by this process, since that would throttle the cleaning of
> dirty pages."   This logic seems valid for fuse as well, but it also
> upsets the normal dirty throttling mechanisms, so I'm not sure that
> there aren't any side effects.

Also consider:  when a fuse page is under writeback, it's already
accounted as "clean" for the purposes reclaim and for throttling other
dirtiers.  Throttling of fuse fuse writeback pages (NR_WRITEBACK_TEMP)
is done completely separately.

So I'd say, it's better not to set PR_SET_IO_FLUSHER on the fuse
daemon, although there probably wouldn't be any catastrophic
consequences of setting it.

Thanks,
Miklos
