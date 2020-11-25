Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B01BF2C447E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Nov 2020 16:52:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731852AbgKYPwP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Nov 2020 10:52:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731840AbgKYPwO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Nov 2020 10:52:14 -0500
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9E3AC0613D4;
        Wed, 25 Nov 2020 07:52:14 -0800 (PST)
Received: by mail-il1-x144.google.com with SMTP id b8so2519553ila.13;
        Wed, 25 Nov 2020 07:52:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZiuOyRTDnGxkNKDi3LqaWIg9/ryrtd/8rLTKFpwvXO4=;
        b=IesDUyiGY4msVm/mAJr9InhHvy9L/1ThEwro6HUd9Ie+vOE0aH4v3IdtgzAtlJWWJs
         nTz8Wo2vuTbVWEVD3rc0TR42uw8e+RaN7y9l8KZEq5wWAUw5zotJ5mc/9jMzW3FtnU0w
         keRwvS2eF13pAkXKA801K5VRidna2932JNbStPCHwhvcNLsZGpU+n1ytlbShK3wYYgKd
         adC2cDTXuKIsH+ruxwUO1Ce9KyYcHeVr2QPVr3T30cJZ3ZQZQFva934Ll7+6W4iZbWTH
         AmTlQrykwFQeXLC7auZuxSFYI4z5AFkzyhaQ3Be4pxEoXRRPqoFrS8WRfS+xkt6+shsy
         7i8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZiuOyRTDnGxkNKDi3LqaWIg9/ryrtd/8rLTKFpwvXO4=;
        b=tMnHDAhxdBBJucUjWja7G3++46vkPrLzPrYZKFCJCoEVln6ve/pyEaHiKN65ayEnk6
         hjRZe/ZIVyBoR0OmBQ22YCx4tGl7TPpqukRhDS639WlgVGuv70csuxa2nOJ++yqHiqgg
         Ewmdi4d0ryhqbU3H5MQgJgrSRbi3BQ5sMUXsiRNKNd+T/nGeeTINnidk0It1v3z0QRXr
         R75QZJ+d0bqdsN0FRN6whPRfi8MxgcQ7dJs/RS9SsSgPUW9OreOjySBppdpYQmZas5eY
         NUGNVns3SGnVwZnwQMeLai5S1jZGdrDK8vt2dXc5H5/R0v79NN2P/g6FmEAOx1bMbeO+
         6/KQ==
X-Gm-Message-State: AOAM531Hi+FMYuukwrVhlxKkZg3RPttt+eaNl4ECm1tMdg1T4zP6bgO5
        My/2kIFVE9DQykIHVmT1NlMo5gwyAN1DO14GhK4=
X-Google-Smtp-Source: ABdhPJxKs2Tv4YSW6vzK6SbD5qLPK93Gu3lEP9RW3v5hB3XqDFoGiKyzo6jQyoaEp8tZGIXM9J1K2vulYO98UQmPers=
X-Received: by 2002:a92:6403:: with SMTP id y3mr3827782ilb.72.1606319534010;
 Wed, 25 Nov 2020 07:52:14 -0800 (PST)
MIME-Version: 1.0
References: <20201125104621.18838-1-sargun@sargun.me> <20201125104621.18838-4-sargun@sargun.me>
 <CAOQ4uxhr1iLkvt+LK868pK=AaZ5O6vniPf2t8=u1=Pb+0ELPAw@mail.gmail.com> <20201125153646.GC3095@redhat.com>
In-Reply-To: <20201125153646.GC3095@redhat.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 25 Nov 2020 17:52:03 +0200
Message-ID: <CAOQ4uxhJTi3cWjrxaC1TBreFjYAuJWzCuSxwbv2ZqnSQ7=L3=w@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] overlay: Add rudimentary checking of writeback
 errseq on volatile remount
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Sargun Dhillon <sargun@sargun.me>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Daniel J Walsh <dwalsh@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 25, 2020 at 5:36 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Wed, Nov 25, 2020 at 04:03:06PM +0200, Amir Goldstein wrote:
> > On Wed, Nov 25, 2020 at 12:46 PM Sargun Dhillon <sargun@sargun.me> wrote:
> > >
> > > Volatile remounts validate the following at the moment:
> > >  * Has the module been reloaded / the system rebooted
> > >  * Has the workdir been remounted
> > >
> > > This adds a new check for errors detected via the superblock's
> > > errseq_t. At mount time, the errseq_t is snapshotted to disk,
> > > and upon remount it's re-verified. This allows for kernel-level
> > > detection of errors without forcing userspace to perform a
> > > sync and allows for the hidden detection of writeback errors.
> > >
> >
> > Looks fine as long as you verify that the reuse is also volatile.
> >
> > Care to also add the alleged issues that Vivek pointed out with existing
> > volatile mount to the documentation? (unless Vivek intends to do fix those)
>
> I thought current writeback error issue with volatile mounts needs to
> be fixed with shutting down filesystem. (And mere documentation is not
> enough).
>

Documentation is the bare minimum.
If someone implements the shutdown approach that would be best.

> Amir, are you planning to improve your ovl-shutdown patches to detect
> writeback errors for volatile mounts. Or you want somebody else to
> look at it.

I did not intend to work on this.
Whoever wants to pick this up doesn't need to actually implement the
shutdown ioctl, may implement only an "internal shutdown" on error.

>
> W.r.t this patch set, I still think that first we should have patches
> to shutdown filesystem on writeback errors (for volatile mount), and
> then detecting writeback errors on remount makes more sense.
>

I agree that would be very nice, but I can also understand the argument
that volatile mount has an issue, which does not get any better or any
worse as a result of Sargun's patches.

If anything, they improve the situation:
Currently, the user does have a way to know if any data was lost on a
volatile mount.
After a successful mount cycle, the user knows that no data was lost
during the last volatile mount period.

Thanks,
Amir.
