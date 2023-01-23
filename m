Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 516C2677C48
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jan 2023 14:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231847AbjAWNTw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Jan 2023 08:19:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231544AbjAWNTv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Jan 2023 08:19:51 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C23AB11EBB
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jan 2023 05:19:44 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id tz11so30484898ejc.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jan 2023 05:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R9T8a4GtLemfg8bs022nGvvNRVHDW8m48Zzykf+XQm4=;
        b=KH5HfoQEraABgUPGAkezcFxSvDD5ZNepe//QbJnjWZFHuWUlsQyQRWOdImqwF0HEfl
         OFyjREzeZfWAvNT9ru+zC7MuyEb9Eyzx+0bnXoYFx9EJqQ6ZBsvC49Lhl6l7i8J12cdu
         1CDlakly7qc3VpGwwXfHb93NNuqjlFcHC5iFo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R9T8a4GtLemfg8bs022nGvvNRVHDW8m48Zzykf+XQm4=;
        b=GQVziSEDm6Jl5uhQ0i0amrqhtM4D/EJoW2KYNJQbvjoZCiYTqYOrI1U0QluX0ZYD/j
         hlwgaLXJKAjEOhBh2zrasASHe1gnjdJmxBZfchJEZ8RG8tsStmx1YHahP9qCNQpazDF4
         I6CFPps2QIdla7XKuk+KHnxKyoBnwSCHlHK3lyrsov9IEq9o1grFgqLvaVi9ImRo7790
         8/wcu/kLYXM3XtcJ9bdpdWs4yBVPMIEBAxtPfjU7PcrxzHqFdwyOx6t8sdP1rILNT+wm
         x5ziFhjm2m3pcdTizbBzX9KwrDx4+yGXYacnWYF0SzFzqASgylfpuyG3gZ2NOGbKKF6w
         0cQw==
X-Gm-Message-State: AFqh2kpw5hXySQDVhKDAHqyRli6sfnGoOEoc7uhERtcHl2VcdtTSe19x
        J24njrCOhZuQoug8a0GY4z140FQPECzDw5z/KEdEOQ==
X-Google-Smtp-Source: AMrXdXssoPlw4AYdUsS4dAkefzSGmG0Xzrr1T6uyTx0QzpU0K4zZU0bDNIk+9Md5OHT02/+B4/9kp2fX8Z7WTfNPnQo=
X-Received: by 2002:a17:906:f253:b0:870:ac07:ad56 with SMTP id
 gy19-20020a170906f25300b00870ac07ad56mr3388997ejb.146.1674479983306; Mon, 23
 Jan 2023 05:19:43 -0800 (PST)
MIME-Version: 1.0
References: <CAJ16EqgEd-BP3XStsR_Cm88Qw2=CTppZo7Ewqv9se+YyzrbzCQ@mail.gmail.com>
 <CAJfpegugtmfjkW9ysDobNJGZM=G0Y_wrK1uHwANjSnKX1K++SA@mail.gmail.com> <20230119070528.GA1337007@ubuntu>
In-Reply-To: <20230119070528.GA1337007@ubuntu>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 23 Jan 2023 14:19:32 +0100
Message-ID: <CAJfpegseu=4rpu2NSD248jQYL-_Lfgc1Z2bC12MQDGJZ7pod=Q@mail.gmail.com>
Subject: Re: Re: question about fuse livelock situation
To:     "YoungJun.Park" <her0gyugyu@gmail.com>
Cc:     Alex Murray <alex.murray@canonical.com>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,T_SPF_TEMPERROR
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 19 Jan 2023 at 08:05, YoungJun.Park <her0gyugyu@gmail.com> wrote:
>
> On Wed, Aug 31, 2022 at 11:58:50AM +0200, Miklos Szeredi wrote:
> > On Tue, 30 Aug 2022 at 03:58, =EB=B0=95=EC=98=81=EC=A4=80 <her0gyugyu@g=
mail.com> wrote:
> > >
> > > I found fuse livelock situation and report it for possibility of prob=
lem.
> > >
> > > [Environment]
> > > 22.04 5.15.0-43-generic ubuntu kernel.
> > > ntfs-3g version ntfs-3g 2021.8.22 integrated FUSE 28 - Third
> > > Generation NTFS Driver
> > >
> > > [Problem]
> > > I bumped on livelock and analyze it. and concluded that it is needed
> > > to be fixed.
> > > it happends when 3 operation concurrently progressing.
> > >
> > > 1) usb detach by user. and kernel detect it.
> > > 2) mount.ntfs umount request & device release operation
> > > 3) pool-udisksd umount operation.
> > >
> > > [Conclusion]
> > > 1. mounted target device file must be released after /dev/fuse
> > > release. it makes deadlocky scenario.
> >
> > Shouldn't this be reported to ntfs-3g developers then?
> >
> > Thanks,
> > Miklos
>
> I reported it ntfs-3g and ubuntu bug report channel.
> ntfs-3g does not respond and ubuntu bug report channel response it like b=
elow.
> (If you want a detail scenario flow picture, calltack etc check the link
> https://github.com/tuxera/ntfs-3g/issues/56)
>
> > Hi
>
> > Thanks for reporting this issue - in general it is better to report bug=
s
> > via launchpad than email (e.g. by running the following command (withou=
t
> > the quotation marks) in a terminal: "ubuntu-bug ntfs-3g" or by
> > https://bugs.launchpad.net/ubuntu/+source/ntfs-3g/+filebug)
>
> > I notice you also appear to have reported this to the upstream nfts-3g
> > project at https://github.com/tuxera/ntfs-3g/issues/56 but have had no
> > response.
>
> > However, my initial thoughts when looking at this is that it appears yo=
u
> > can trigger a livelock within the kernel from an unprivileged user in
> > userspace - as such I wonder if this is a bug in the FUSE subsystem
> > within the Linux kernel and hence whether it should be reported to the
> > upstream kernel developers as well? As per
> > https://www.kernel.org/doc/html/v4.15/admin-guide/reporting-bugs.html i=
t
> > would appear that this should be reported to the following email
> > addresses (assuming this is a real kernel bug rather than a bug within
> > the ntfs-3g userspace project):
>
> > $ ./scripts/get_maintainer.pl fs/fuse/fuse_i.h
> > Miklos Szeredi <miklos@szeredi.hu> (maintainer:FUSE: FILESYSTEM IN USER=
SPACE)
> > linux-fsdevel@vger.kernel.org (open list:FUSE: FILESYSTEM IN USERSPACE)
> > linux-kernel@vger.kernel.org (open list)
>
> > Thanks,
> > Alex
>
> Could you explan why it shoulde be fixed in userspace?
> then I try to fix this issue and to report it one more based on your comm=
ent.

If the block device close is blocked, then ntfs-3g should reply to the
DESTROY request before it tries to close the block device.

Thanks,
Miklos
