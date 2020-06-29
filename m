Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDBC120D2E2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jun 2020 21:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729815AbgF2SxW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Jun 2020 14:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729814AbgF2Sww (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:52:52 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDCC5C02E2DD;
        Mon, 29 Jun 2020 07:05:49 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id k6so14538057ili.6;
        Mon, 29 Jun 2020 07:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SIY049maXgLeyh5B7pSQJoj4G7EcvGdwTWmpWjXLOLg=;
        b=Wyp0PLFugiK1RUPQcKtPHeek3fr/J/2Gy2AilxBoARXp1yFmWsTt3ik4X3TQZD8vf9
         zuwDJQuCI33YONsdXRxww3JbOSHF0Cy3xNSQdlmAFGWrcGPLnIjfbIVR2GDMZVuA41Xk
         +cE9N8UPLHOXuAdVJOBHqWLL48OrvZ1xTkQ91vxg1lzdIAppxXvb3JCvQDb7CmuV7YsR
         AhbRF4xoPIyCIN9kSKkKwvk8F0oXX5++Ixcf7nXW6lJhku6iVYVfmOm/7t9kZMLn5Qw1
         G4gr/pHHm8wlpxfqLfQbLV88FFwdtzVpIw9hgkBCp6MmRR7iA/xk0kYlCNg6mVtkYHdg
         CjZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SIY049maXgLeyh5B7pSQJoj4G7EcvGdwTWmpWjXLOLg=;
        b=D9Pu9R0L7tPXRGZ9qi1aNX1Fs0BIzq7M2OgZIN0+6vvk6hWj+0sOJ7EjZVWJZWQNYT
         ZZwGhXS/p2C60eqazoxfPdJb14FvC1wt820XKib/574pIkqG9CRtAsWKtyRW1b58/ZeW
         OwlZx2mg7BIsR7mFWTOeXWkizBjTw1oUKP7mXaz4PG8i0wFeYFZqFtDVSK37t8fTP9th
         RQXxqrxf0+uVBj1tYbmDnMeTP2Hb1ynlMKeWxiasSVa8sVeCo/3UlHMVdaAaqDcVv42N
         8ofrM2xtJGW5t5Ov4DIzS5J+5O5i5UuMcBQ4X4DL2NhZOqfJwXhfLEghCLxqSQ4/jl7r
         /oqg==
X-Gm-Message-State: AOAM531Y0pimMkzRK/r3W+JWI6e206oPn/BBxFp5Tfic9cuUKBym3jI8
        JNEjshUucxnoR2WqgNT+J+cQv9Vri/ObHKAIq2c=
X-Google-Smtp-Source: ABdhPJxQkwee4h4i38IDgjWPIBbehnogM+Uwa4QjkjNIXA6MDuKP1JoQ0D6pSJNpUdpuu1DfoaOtoHeSo/c3/MUVr/0=
X-Received: by 2002:a92:2a0c:: with SMTP id r12mr15665053ile.275.1593439549027;
 Mon, 29 Jun 2020 07:05:49 -0700 (PDT)
MIME-Version: 1.0
References: <7b4aa1e985007c6d582fffe5e8435f8153e28e0f.camel@redhat.com>
 <CAOQ4uxg8E-im=B6L0PQNaTTKdtxVAO=MSJki7kxq875ME4hOLw@mail.gmail.com> <20200629130915.GF26507@quack2.suse.cz>
In-Reply-To: <20200629130915.GF26507@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 29 Jun 2020 17:05:38 +0300
Message-ID: <CAOQ4uxhdOMbn9vL_PAGKLtriVzkjwBkuEgbdB5+uH2ZM6uA97w@mail.gmail.com>
Subject: Re: Commit 'fs: Do not check if there is a fsnotify watcher on pseudo
 inodes' breaks chromium here
To:     Jan Kara <jack@suse.cz>
Cc:     Maxim Levitsky <mlevitsk@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 29, 2020 at 4:09 PM Jan Kara <jack@suse.cz> wrote:
>
> On Sun 28-06-20 15:53:51, Amir Goldstein wrote:
> > On Sun, Jun 28, 2020 at 2:14 PM Maxim Levitsky <mlevitsk@redhat.com> wrote:
> > >
> > > Hi,
> > >
> > > I just did usual kernel update and now chromium crashes on startup.
> > > It happens both in a KVM's VM (with virtio-gpu if that matters) and natively with amdgpu driver.
> > > Most likely not GPU related although I initially suspected that it is.
> > >
> > > Chromium starts as a white rectangle, shows few white rectangles
> > > that resemble its notifications and then crashes.
> > >
> > > The stdout output from chromium:
> >
> > I guess this answers our question whether we could disable fsnoitfy
> > watches on pseudo inodes....
>
> Right :-|
>
> > From comments like these in chromium code:
> > https://chromium.googlesource.com/chromium/src/+/master/mojo/core/watcher_dispatcher.cc#77
> > https://chromium.googlesource.com/chromium/src/+/master/base/files/file_descriptor_watcher_posix.cc#176
> > https://chromium.googlesource.com/chromium/src/+/master/ipc/ipc_channel_mojo.cc#240
> >
> > I am taking a wild guess that the missing FS_CLOSE event on anonymous pipes is
> > the cause for regression.
>
> I was checking the Chromium code for some time. It uses inotify in
> base/files/file_path_watcher_linux.cc and watches IN_CLOSE_WRITE event
> (among other ones) but I was unable to track down how the class gets
> connected to the mojo class that crashes. I'd be somewhat curious how they
> place inotify watches on pipe inodes - probably they have to utilize proc
> magic links but I'd like to be sure. Anyway your guess appears to be
> correct :)

Well, I lost track of the code as well...

>
> > The motivation for the patch "fs: Do not check if there is a fsnotify
> > watcher on pseudo inodes"
> > was performance, but actually, FS_CLOSE and FS_OPEN events probably do
> > not impact performance as FS_MODIFY and FS_ACCESS.
>
> Correct.
>
> > Do you agree that dropping FS_MODIFY/FS_ACCESS events for FMODE_STREAM
> > files as a general rule should be safe?
>
> Hum, so your patch drops FS_MODIFY/FS_ACCESS events also for named pipes
> compared to the original patch AFAIU and for those fsnotify works fine
> so far. So I'm not sure we won't regress someone else with this.
>
> I've also tested inotify on a sample pipe like: cat /dev/stdin | tee
> and watched /proc/<tee pid>/fd/0 and it actually generated IN_MODIFY |
> IN_ACCESS when data arrived to a pipe and tee(1) read it and then
> IN_CLOSE_WRITE | IN_CLOSE_NOWRITE when the pipe got closed (I thought you
> mentioned modify and access events didn't get properly generated?).

I don't think that I did (did I?)

>
> So as much as I agree that some fsnotify events on FMODE_STREAM files are
> dubious, they could get used (possibly accidentally) and so after this
> Chromium experience I think we just have to revert the change and live with
> generating notification events for pipes to avoid userspace regressions.
>
> Thoughts?

I am fine with that.

Before I thought of trying out FMODE_STREAM I was considering to propose
to set the new flag FMODE_NOIONOTIFY in alloc_file_pseudo() to narrow Mel's
patch to dropping FS_MODIFY|FS_ACCESS.

But I guess the burden of proof is back on Mel.
And besides, quoting Mel's patch:
"A patch is pending that reduces, but does not eliminate, the overhead of
    fsnotify but for files that cannot be looked up via a path, even that
    small overhead is unnecessary"

So really, we are not even sacrificing much by reverting this patch.
We down to "nano optimizations".

Thanks,
Amir.
