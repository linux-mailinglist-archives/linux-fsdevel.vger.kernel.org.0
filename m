Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71D4C34669A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Mar 2021 18:45:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbhCWRon (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Mar 2021 13:44:43 -0400
Received: from linux.microsoft.com ([13.77.154.182]:33980 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbhCWRoL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Mar 2021 13:44:11 -0400
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
        by linux.microsoft.com (Postfix) with ESMTPSA id 25EA020B5687;
        Tue, 23 Mar 2021 10:44:11 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 25EA020B5687
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1616521451;
        bh=G7iciegtRvKppYPYJPauE2IorhaqFayxqE/yzKwzn88=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kDTg5d9RTPxy1Mfp4rWpK1Q4IdRB+dl+unYwdT0itz0xewY5lRAay+WgiuRWVF0CQ
         Z4zrbZIkWTITwZ93Rus+zk7Zc0hrhdjyhQU1X06d2fJl64Q08ZWg7vX2YEk+dNy/vq
         Rny9xfKOcPG8kJfdWD+MBhjWLvMSQQ/GgIjmtYHY=
Received: by mail-pg1-f170.google.com with SMTP id i22so925013pgl.4;
        Tue, 23 Mar 2021 10:44:11 -0700 (PDT)
X-Gm-Message-State: AOAM532dDF9bkHRqb7lULm0hCTVi8i024ru6s4M92k+aTdw6SIHBgzNx
        tAkMJrM329UCwQk/dusHJAIu2M+ibxzTIdFBG6Q=
X-Google-Smtp-Source: ABdhPJyoxMVW+rRjABv+KDN/Kbo5Gw98D4A5VsOkK8yQv98ZRKj6D9fQY4srWZEiM4ohAm6aeEwxZ6ewoj61y0h7m5E=
X-Received: by 2002:a17:902:e80a:b029:e6:c4c4:1f05 with SMTP id
 u10-20020a170902e80ab02900e6c4c41f05mr7002419plg.33.1616521450618; Tue, 23
 Mar 2021 10:44:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210315200242.67355-1-mcroce@linux.microsoft.com>
 <20210315200242.67355-2-mcroce@linux.microsoft.com> <7358d5ae-afd6-f0d9-5535-b1d7ecfbd785@linux.alibaba.com>
In-Reply-To: <7358d5ae-afd6-f0d9-5535-b1d7ecfbd785@linux.alibaba.com>
From:   Matteo Croce <mcroce@linux.microsoft.com>
Date:   Tue, 23 Mar 2021 18:43:34 +0100
X-Gmail-Original-Message-ID: <CAFnufp2E8ky_q10R5=zXsU+2ca53yQ=W+XOtKAq-c654xHCoEA@mail.gmail.com>
Message-ID: <CAFnufp2E8ky_q10R5=zXsU+2ca53yQ=W+XOtKAq-c654xHCoEA@mail.gmail.com>
Subject: Re: [PATCH -next 1/5] block: add disk sequence number
To:     JeffleXu <jefflexu@linux.alibaba.com>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lennart Poettering <lennart@poettering.net>,
        Luca Boccassi <bluca@debian.org>, Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Tejun Heo <tj@kernel.org>,
        =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 16, 2021 at 2:44 AM JeffleXu <jefflexu@linux.alibaba.com> wrote:
>
> On 3/16/21 4:02 AM, Matteo Croce wrote:
> > From: Matteo Croce <mcroce@microsoft.com>
> >
> > Add a sequence number to the disk devices. This number is put in the
> > uevent so userspace can correlate events when a driver reuses a device,
> > like the loop one.
>
> Hi, I'm quite interested in this 'seqnum'. Actually I'm also planing to
> add support for some sort of 'seqnum' when supporting IO polling for dm
> devices, so that every time dm device changes its dm table, the seqnum
> will be increased.
>

Interesting, thanks!

> As for your patch, @diskseq is declared as one static variable in
> inc_diskseq(). Then I doubt if all callers of inc_diskseq() will share
> *one* counting when inc_diskseq() is compiled as the separate call entry
> rather than inlined.
>

That would be true if the static declaration was in the .h, but being
in genhd.c it goes in vmlinux once.
Maybe you get confused by the inc_diskseq prototype in the header
file, but the function body is in the .c

Regards,



--
per aspera ad upstream
