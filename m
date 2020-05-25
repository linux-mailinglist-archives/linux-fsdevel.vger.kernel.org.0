Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE471E0FD8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 May 2020 15:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403918AbgEYNvD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 May 2020 09:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403912AbgEYNvC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 May 2020 09:51:02 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B963C05BD43
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 May 2020 06:51:01 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id n24so20553784ejd.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 May 2020 06:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QihzPsvUnSGaU3hwhHMNaFA+LimqGZBbwZeaObsM9NE=;
        b=PSyrtHVje7ZYLkqfzSdnpXcPump23C7iFuJtsKEgIW9MGzqxyJzqCXWJQpNHWdZBIT
         wpdor15GX7rrYx4rzsyLcUoOUn413z8uP1se9QEbd6xgfTWggGZD/6q6u43gsAC110PR
         i+g0IOy4InlLFjwmTbWMJUvHIP0a8rgXqfCuQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QihzPsvUnSGaU3hwhHMNaFA+LimqGZBbwZeaObsM9NE=;
        b=VhY+rq56Zalw9vPBNjT3bH4r6DezGnEwMcX5hiAuu3iNzZWlCzWMAoNcE72al//yb4
         pDtcl0C4khXDmyf+mWS2dX9Pw0ax3quBQYAqHNGrUqdLr8xLz+zbijZgZHzAIbszUFRh
         k7yCYjLZW+tVEEJVQat2Y+F8nzpQ0CUqfnpjrB1mYm62p6HzOSZhGoaSNaSB4h3PX9Z7
         y5LQSoO8dlbj0Zlj31u4XUAOU3JBZVab+IcoRiRriRxyUCoOhdrf5K99DpSGYQGj0Ur+
         Gfj3SdINd9VrpRGk5bIFSaJBSW2xcrLtnnFpfuhcQu38VUU+PWK0NdrhdNjW3xyKrH8J
         xChQ==
X-Gm-Message-State: AOAM533YUmtDm49fp/gJrAD+74CDrminzV8HtVcRG6B3Vtqivv6VxSkx
        vGg2S5h5yDR0W8aKLyCI8gnY41RjgVHNSg6TdlI2qg==
X-Google-Smtp-Source: ABdhPJxGuqOa6lmUmdDtVB1Wsc818xo4RJaCunGXVDJuxR/mpgxMOYUDA7he5IeWyM1qHP2JtZeVs4XXJ0CBv/u/5x4=
X-Received: by 2002:a17:907:420e:: with SMTP id oh22mr18186325ejb.320.1590414660201;
 Mon, 25 May 2020 06:51:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200515072047.31454-1-cgxu519@mykernel.net> <e994d56ff1357013a85bde7be2e901476f743b83.camel@themaw.net>
 <CAOQ4uxjT8DouPmf1mk1x24X8FcN5peYAqwdr362P4gcW+x15dw@mail.gmail.com>
 <CAJfpegtpi1SVJRbQb8zM0t66WnrjKsPEGEN3qZKRzrZePP06dA@mail.gmail.com>
 <05e92557-055c-0dea-4fe4-0194606b6c77@mykernel.net> <CAJfpegtyZw=6zqWQWm-fN0KpGEp9stcfvnbA7eh6E-7XHxaG=Q@mail.gmail.com>
 <7fcb778f-ba80-8095-4d48-20682f5242a9@mykernel.net> <CAJfpegu1XVB5ABGMzNpyomgWqu+gtd2RCoDpuqGcEYJ7tmWdew@mail.gmail.com>
 <778de44a-17d5-a5ba-fc54-6839b67fe7b1@mykernel.net>
In-Reply-To: <778de44a-17d5-a5ba-fc54-6839b67fe7b1@mykernel.net>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 25 May 2020 15:50:48 +0200
Message-ID: <CAJfpegtGZYfvNK34-DszC0=kKcaW1krdnV+jtO5j=tNXhZ-qSQ@mail.gmail.com>
Subject: Re: [RFC PATCH v3 0/9] Suppress negative dentry
To:     Chengguang Xu <cgxu519@mykernel.net>
Cc:     Amir Goldstein <amir73il@gmail.com>, Ian Kent <raven@themaw.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 25, 2020 at 3:37 PM Chengguang Xu <cgxu519@mykernel.net> wrote:
>
> =E5=9C=A8 5/20/2020 10:44 PM, Miklos Szeredi =E5=86=99=E9=81=93:
> > On Tue, May 19, 2020 at 11:24 AM cgxu <cgxu519@mykernel.net> wrote:
> >> On 5/19/20 4:21 PM, Miklos Szeredi wrote:
> >>> On Tue, May 19, 2020 at 7:02 AM cgxu <cgxu519@mykernel.net> wrote:
> >>>
> >>>> If we don't consider that only drop negative dentry of our lookup,
> >>>> it is possible to do like below, isn't it?
> >>> Yes, the code looks good, though I'd consider using d_lock on dentry
> >>> instead if i_lock on parent, something like this:
> >>>
> >>> if (d_is_negative(dentry) && dentry->d_lockref.count =3D=3D 1) {
> >>>       spin_lock(&dentry->d_lock);
> >>>       /* Recheck condition under lock */
> >>>       if (d_is_negative(dentry) && dentry->d_lockref.count =3D=3D 1)
> >>>           __d_drop(dentry)
> >>>       spin_unlock(&dentry->d_lock);
> >> And after this we will still treat 'dentry' as negative dentry and dpu=
t it
> >> regardless of the second check result of d_is_negative(dentry), right?
> > I'd restructure it in the same way as lookup_positive_unlocked()...
> >
> >>> }
> >>>
> >>> But as Amir noted, we do need to take into account the case where
> >>> lower layers are shared by multiple overlays, in which case dropping
> >>> the negative dentries could result in a performance regression.
> >>> Have you looked at that case, and the effect of this patch on negativ=
e
> >>> dentry lookup performance?
> >> The container which is affected by this feature is just take advantage
> >> of previous another container but we could not guarantee that always
> >> happening. I think there no way for best of both worlds, consider that
> >> some malicious containers continuously make negative dentries by
> >> searching non-exist files, so that page cache of clean data, clean
> >> inodes/dentries will be freed by memory reclaim. All of those
> >> behaviors will impact the performance of other container instances.
> >>
> >> On the other hand, if this feature significantly affects particular
> >> container,
> >> doesn't that mean the container is noisy neighbor and should be restri=
cted
> >> in some way?
> > Not necessarily.   Negative dentries can be useful and in case of
> > layers shared between two containers having negative dentries cached
> > in the lower layer can in theory positively affect performance.   I
> > don't have data to back this up, nor the opposite.  You should run
> > some numbers for container startup times with and without this patch.
>
> I did some simple tests  for it but the result seems not very steady, so
> I need to take time to do more detail tests later. Is it possible to
> apply the patch for upper layer first?

Sure, that's a good start.

Thanks,
Miklos
