Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B27634E9A6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Mar 2021 15:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232053AbhC3Nyb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Mar 2021 09:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbhC3NyO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Mar 2021 09:54:14 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B812C061574;
        Tue, 30 Mar 2021 06:54:14 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id v26so16493942iox.11;
        Tue, 30 Mar 2021 06:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eRKAgRXuGQrtNoTXHmvfGZA8o3MRnH58cBnWJ68/uhw=;
        b=ZoSVsUxJLy2nzh7TGegCTN2v3pTIsMDFpzS2MKbbyHWn2Y9+XdGppU9t6vRb1rtkmU
         RwV0BBA+skkAmhtG7l3KV0Xr11fjXDs0DzAvd56wPTt9wfUR42rAsigy7dHl3zGZL+JL
         n/sc1BshGUyOHGmD9i/ydhr7kSxYGbbYDwLHT1aoFwhEShSrU7HQXDZ3U9dF4jpX7ud8
         i4VmbSPlsIX3Z9wwxgjbHh+I7wYB4fzbwDesA8G77AIrkbwuU94CBDy8Wiq+IkKo2E2M
         /zxEuNqCLrg4fYBIe0eC//V5VHfQm6yIAB/aaNd0v4s+LDo4HFX4nKe7TzeurX2xT+U6
         Lp+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eRKAgRXuGQrtNoTXHmvfGZA8o3MRnH58cBnWJ68/uhw=;
        b=iRRUeMVVlPyutkBoSzjyZA3cDzP9z/Fpi7lfGkNKTn33qYvDcCNiJ+sqsW6BGNdaoY
         OKVxzQzgyGA2ehpIHxuldQywRlnkKHbgjRGtBkvkVAUAOO51GBDdDRm5vNGHtizpcSpT
         LyH6G7q/3+PnWiPI2Ner3XJQIi7oI+xRi34fP2HiziNqXPLWSLgZd2utdMjiH3Lgqusz
         QwCDQWPb9ot+DXU+PfC4sZCH2L0YYqXQqpnjQj2cdBWfV3jigM85BTe+mhcPIlsNP8UD
         yDw+AjWPSqoM8vISBQVC2e66fDaStGF7LAaP586P6Wqf+ePOhufxlUFV6jysBurzmaM1
         0sJA==
X-Gm-Message-State: AOAM530fPniGBqDP5rUIqSxZ7Z2aRDKpz+xbblrlR9y/+ojsVsu/MEdx
        lN28EQd/VLHoYhzhMP0CiNRg57FAhd1UkW9vUTFVlJfHSzs=
X-Google-Smtp-Source: ABdhPJxjWdKm8QHnq0tIyX+PCkYPsQXnm4mnTjLZGT+yTbtePbhWIsz2t7OxdKGUg3G9mDO7y/7iBs7qCs40dB60kjQ=
X-Received: by 2002:a05:6638:1388:: with SMTP id w8mr23178139jad.30.1617112453495;
 Tue, 30 Mar 2021 06:54:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210328155624.930558-1-amir73il@gmail.com> <20210330121204.b7uto3tesqf6m7hb@wittgenstein>
 <CAOQ4uxjVdjLPbkkZd+_1csecDFuHxms3CcSLuAtRbKuozHUqWA@mail.gmail.com> <20210330125336.vj2hkgwhyrh5okee@wittgenstein>
In-Reply-To: <20210330125336.vj2hkgwhyrh5okee@wittgenstein>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 30 Mar 2021 16:54:02 +0300
Message-ID: <CAOQ4uxjPhrY55kJLUr-=2+S4HOqF0qKAAX27h2T1H1uOnxM9pQ@mail.gmail.com>
Subject: Re: [RFC][PATCH] fanotify: allow setting FAN_CREATE in mount mark mask
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 30, 2021 at 3:53 PM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
>
> On Tue, Mar 30, 2021 at 03:33:23PM +0300, Amir Goldstein wrote:
> > On Tue, Mar 30, 2021 at 3:12 PM Christian Brauner
> > <christian.brauner@ubuntu.com> wrote:
> > >
> > > On Sun, Mar 28, 2021 at 06:56:24PM +0300, Amir Goldstein wrote:
> > > > Add a high level hook fsnotify_path_create() which is called from
> > > > syscall context where mount context is available, so that FAN_CREATE
> > > > event can be added to a mount mark mask.
> > > >
> > > > This high level hook is called in addition to fsnotify_create(),
> > > > fsnotify_mkdir() and fsnotify_link() hooks in vfs helpers where the mount
> > > > context is not available.
> > > >
> > > > In the context where fsnotify_path_create() will be called, a dentry flag
> > > > flag is set on the new dentry the suppress the FS_CREATE event in the vfs
> > > > level hooks.
> > >
> > > Ok, just to make sure this scheme would also work for overlay-style
> > > filesystems like ecryptfs where you possible generate two notify events:
> > > - in the ecryptfs layer
> > > - in the lower fs layer
> > > at least when you set a regular inode watch.
> > >
> > > If you set a mount watch you ideally would generate two events in both
> > > layers too, right? But afaict that wouldn't work.
> > >
> > > Say, someone creates a new link in ecryptfs the DENTRY_PATH_CREATE
> > > flag will be set on the new ecryptfs dentry and so no notify event will
> > > be generated for the ecryptfs layer again. Then ecryptfs calls
> > > vfs_link() to create a new dentry in the lower layer. The new dentry in
> > > the lower layer won't have DCACHE_PATH_CREATE set. Ok, that makes sense.
> > >
> > > But since vfs_link() doesn't have access to the mnt context itself you
> > > can't generate a notify event for the mount associated with the lower
> > > fs. This would cause people who a FAN_MARK_MOUNT watch on that lower fs
> > > mount to not get notified about creation events going through the
> > > ecryptfs layer. Is that right?  Seems like this could be a problem.
> > >
> >
> > Not sure I follow what the problem might be.
> >
> > FAN_MARK_MOUNT subscribes to get only events that were
> > generated via that vfsmount - that has been that way forever.
> >
> > A listener may subscribe to (say) FAN_CREATE on a certain
> > mount AND also also on a specific parent directory.
> >
> > If the listener is watching the entire ecryptfs mount and the
> > specific lower directory where said vfs_link() happens, both
> > events will be reported. One from fsnotify_create_path() and
> > the lower from fsnotify_create().
> >
> > If one listener is watching the ecryptfs mount and another
> > listener is watching the specific ecryptfs directory, both
> > listeners will get a single event each. They will both get
> > the event that is emitted from fsnotify_path_create().
> >
> > Besides I am not sure about ecryptfs, but overlayfs uses
> > private mount clone for accessing lower layer, so by definition
>
> I know. That's why I was using ecryptfs as an example which doesn't do
> that (And I think it should be switched tbh.). It simply uses
> kern_path() and then stashes that path.
>
> My example probably would be something like:
>
> mount -t ext4 /dev/sdb /A
>
> 1. FAN_MARK_MOUNT(/A)
>
> mount --bind /A /B
>
> 2. FAN_MARK_MOUNT(/B)
>
> mount -t ecryptfs /B /C
>
> 3. FAN_MARK_MOUNT(/C)
>
> let's say I now do
>
> touch /C/bla
>
> I may be way off here but intuitively it seems both 1. and 2. should get
> a creation event but not 3., right?
>

Why not 3?
You explicitly set a mark on /C requesting to be notified when
objects are created via /C.

> But with your proposal would both 1. and 2. still get a creation event?
>

They would not get an event, because fsnotify() looks for CREATE event
subscribers on inode->i_fsnotify_marks and inode->i_sb_s_fsnotify_marks
and does not find any.

The vfs_create() -> fsnotify_create() hook passes data_type inode to
fsnotify() so there is no fsnotify_data_path() to extract mnt event
subscribers from.

The same fate would be to files created by overlayfs, nfsd and cachefiles.

Only the create event on /C/bla from the syscall context would
call fsnoity_path_create() and result with path data in fsnotify(), so
the mnt event subscriber would be found.

> > users cannot watch the underlying overlayfs operations using
> > a mount mark. Also, overlayfs suppresses fsnotify events on
> > underlying files intentionally with FMODE_NONOTIFY.
>
> Probably ecryptfs should too?
>

<shrug> :)

FMODE_NONOTIFY is there not because there was a requirement
not to send events, but because the path of the internal file is
"fake", so it has a weird looking path. After all there are many
other events that would be sent (not on open files).

At least I think that's the reason...

Thanks,
Amir.
