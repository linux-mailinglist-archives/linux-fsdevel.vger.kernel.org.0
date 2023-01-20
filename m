Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 171B1674F9F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jan 2023 09:44:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbjATIoX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Jan 2023 03:44:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjATIoW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Jan 2023 03:44:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E260E8534B
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Jan 2023 00:43:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674204216;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2ieVgb0wdTbUDgdUwiBcUCrz7AjasaHhJqwRtTkIp84=;
        b=Gny2aV4vPGkBG0iWh3VVLPAj0Rl8tWqqTGy9e/sPErPE4xsELv5T+JLiKVWVBQrYd8IK6o
        DE3sxP1qqQ7zp6Zbi/akNDRMkiK5Qsy0B+G+WGQBd6WAavk7B0UiPiuH3Eyu+yYB49Bevr
        W+RHgo9xKk+xxxkJKyIbr/7dXVtt44I=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-356-y8breDbpOc-ptKsq4bveBw-1; Fri, 20 Jan 2023 03:43:33 -0500
X-MC-Unique: y8breDbpOc-ptKsq4bveBw-1
Received: by mail-il1-f198.google.com with SMTP id i14-20020a056e020d8e00b003034b93bd07so3324940ilj.14
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Jan 2023 00:43:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2ieVgb0wdTbUDgdUwiBcUCrz7AjasaHhJqwRtTkIp84=;
        b=dkMq8QJCZdBgKzAHM7m2TXax4cyBgnt+5jIo1ZExA21J3njk9rDiQhYmLivsAQSmG+
         RCy9lkFmvLdUy3L+N5aBMDhWrqGBdS8qXuNJTO065Ao+VpkTxcP9XubqSpW6f0bvZgPz
         uVhlfijsxHhwfZy3QOFB5VTkI6bcwmcBQ+7/cZv5itN7j7mjfmmMASXNPo4ZSBZkJ03X
         aYvSBIPJ0AQHBygvEDDmr2yw2Uu5U+mN2VKGek6VVb01K3HwQDd1LjsTMLPgGWo2ro58
         7GYQqh8vxGo8fyR3txNSVmSku16upPqz3EYUFw+2ayUSNwgIWneulu93tZPl2EH1+lis
         MHoQ==
X-Gm-Message-State: AFqh2kr7TChXdWwNHLvV41DwgniyOzjwVmuCs+Xsmz5K6o8tCaVYxdpn
        gV7/+WFavMMtmds/IKp4ib0/P8HIRJt+rpddWyDpIvUvSyzFjl7CV+b4X8HVjyHGOtJG7nWBqRR
        mUlj/ntjgAh1nG83Sm6G2nYFNIBICqq60YQFisPhr1w==
X-Received: by 2002:a5d:884b:0:b0:704:d851:64ba with SMTP id t11-20020a5d884b000000b00704d85164bamr818294ios.135.1674204212930;
        Fri, 20 Jan 2023 00:43:32 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuqWj7kT7WAI3DeIVj9rztUM3R8UUxuRsEPXeV6XWDqUb5Yxgs99M9gWUoAq8V02mWEWfIaFyr9o0FeQ5PeRM0=
X-Received: by 2002:a5d:884b:0:b0:704:d851:64ba with SMTP id
 t11-20020a5d884b000000b00704d85164bamr818292ios.135.1674204212712; Fri, 20
 Jan 2023 00:43:32 -0800 (PST)
MIME-Version: 1.0
References: <20230119211455.498968-1-echanude@redhat.com> <20230119211455.498968-2-echanude@redhat.com>
 <Y8m/ljQUJOefsD6O@ZenIV>
In-Reply-To: <Y8m/ljQUJOefsD6O@ZenIV>
From:   Alexander Larsson <alexl@redhat.com>
Date:   Fri, 20 Jan 2023 09:43:21 +0100
Message-ID: <CAL7ro1EESqanEQnGnLqd_WvoxL0ybn0XJwtMAFxap=w-a=-Vig@mail.gmail.com>
Subject: Re: [RFC PATCH RESEND 1/1] fs/namespace: defer free_mount from namespace_unlock
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Eric Chanudet <echanude@redhat.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Andrew Halaney <ahalaney@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 19, 2023 at 11:09 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Thu, Jan 19, 2023 at 04:14:55PM -0500, Eric Chanudet wrote:
> > From: Alexander Larsson <alexl@redhat.com>
> >
> > Use call_rcu to defer releasing the umount'ed or detached filesystem
> > when calling namepsace_unlock().
> >
> > Calling synchronize_rcu_expedited() has a significant cost on RT kernel
> > that default to rcupdate.rcu_normal_after_boot=1.
> >
> > For example, on a 6.2-rt1 kernel:
> > perf stat -r 10 --null --pre 'mount -t tmpfs tmpfs mnt' -- umount mnt
> >            0.07464 +- 0.00396 seconds time elapsed  ( +-  5.31% )
> >
> > With this change applied:
> > perf stat -r 10 --null --pre 'mount -t tmpfs tmpfs mnt' -- umount mnt
> >         0.00162604 +- 0.00000637 seconds time elapsed  ( +-  0.39% )
> >
> > Waiting for the grace period before completing the syscall does not seem
> > mandatory. The struct mount umount'ed are queued up for release in a
> > separate list and no longer accessible to following syscalls.
>
> Again, NAK.  If a filesystem is expected to be shut down by umount(2),
> userland expects it to have been already shut down by the time the
> syscall returns.
>
> It's not just visibility in namespace; it's "can I pull the disk out?".
> Or "can the shutdown get to taking the network down?", for that matter.

In the usecase we're worrying about, all the unmounts are lazy (i.e.
MNT_DETACH). What about delaying the destroy in that case? That seems
in line with the expected behaviour of lazy shutdown. I.e. you can't
rely on it to be settled anyway.


-- 
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
 Alexander Larsson                                Red Hat, Inc
       alexl@redhat.com         alexander.larsson@gmail.com

