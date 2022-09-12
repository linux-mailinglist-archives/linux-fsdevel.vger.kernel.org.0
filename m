Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC4565B5E60
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Sep 2022 18:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbiILQiW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Sep 2022 12:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiILQiU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Sep 2022 12:38:20 -0400
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF80240B7
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Sep 2022 09:38:19 -0700 (PDT)
Received: by mail-vk1-xa36.google.com with SMTP id i67so4522918vkb.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Sep 2022 09:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=dqb/Y6BgDyo3Z5mh9jo4hy+A7ntHI5cQar49On57rb0=;
        b=cfTmrSOLp2rhAoJC1s3ZO5IYpcUQG9uazAtiIjC7m8uCoYmvLJyr8WPChNylgttz34
         fb7U30VVIBfjOb3/zfVD4q7ZdxGKNud+PxmCg+vYvljL6MlBNsnDVrqiKycHdHNIy3EQ
         2OithsaokhFvTI7V908mY39p14h6WYdOl2p4BmL0gvdJw5HUQp9hldxB78r0nFsXDmeg
         T8TtySluxGQaplC5ECi+3ZW0/f5GNNRjOnjoDvG34esjTrK1en3Qa/N6SKChQu82HKwg
         sgl5TjWZmBuLexpCWHRIR+wzPc3LfmVLi2KwzDscIgBvhwHFDJlTw0RdDWoVWDanDAAu
         g4+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=dqb/Y6BgDyo3Z5mh9jo4hy+A7ntHI5cQar49On57rb0=;
        b=rrZQvsz5r4fV/5MXZloYCQjUTXqm0PeA0XYl7OKpMjCoQaG21+ZrEWNhdlaI45re78
         7u1f7MRRahW2/YKLPK0QM7o+VqY7BusVtnnIz4zx0A7J45yWWG+xdXvIy1BMvy8Fxxy7
         TNjIF3kCMZp2rlfOMhXiaOoSjhzuVvD1MCrGCbQ95+fClGmJ8ZxRY0KFapRbA4V2+H3S
         89rAPhJelRBLoWGGfwQQF6IYSw8vTM/98Susfl+dZKOtk28reRRWYcfDLi/Y4PP3us70
         /H2VGxN9M/JzN3u2ZOjXD/ae14jQ0Zk5yrG3lzzfHPn1ZzofUcDa2RlsW+cq0E1sSaDk
         EVLQ==
X-Gm-Message-State: ACgBeo1HcTG9saUgT7j5Bzo3HaHIAqEAsCwM73/FVz2iawOXcmMGmAvg
        Ohj86sOQB7aeYBewy6DOx5nhQgRY5LrpysFdkcfHSszOXUo=
X-Google-Smtp-Source: AA6agR6xfS8/6QPcYNxXRfYrX981+ETABsxymjwcXqqko1JYxiRKXpvXe7x+PcDh8JNXfXtkFbZjERCSZFjrC37xQyY=
X-Received: by 2002:a1f:a004:0:b0:398:3e25:d2a7 with SMTP id
 j4-20020a1fa004000000b003983e25d2a7mr8770618vke.36.1663000698690; Mon, 12 Sep
 2022 09:38:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAOQ4uxhrQ7hySTyHM0Atq=uzbNdHyGV5wfadJarhAu1jDFOUTg@mail.gmail.com>
 <20220912125734.wpcw3udsqri4juuh@quack3>
In-Reply-To: <20220912125734.wpcw3udsqri4juuh@quack3>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 12 Sep 2022 19:38:07 +0300
Message-ID: <CAOQ4uxgE5Wicsq_O+Vc6aOaLeYMhCEWrRVvAW9C1kEMMqBwJ9Q@mail.gmail.com>
Subject: Re: thoughts about fanotify and HSM
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 12, 2022 at 3:57 PM Jan Kara <jack@suse.cz> wrote:
>
> Hi Amir!
>
> On Sun 11-09-22 21:12:06, Amir Goldstein wrote:
> > I wanted to consult with you about preliminary design thoughts
> > for implementing a hierarchical storage manager (HSM)
> > with fanotify.
> >
> > I have been in contact with some developers in the past
> > who were interested in using fanotify to implement HSM
> > (to replace old DMAPI implementation).
>
> Ah, DMAPI. Shiver. Bad memories of carrying that hacky code in SUSE kernels
> ;)
>
> So how serious are these guys about HSM and investing into it? Because

Let's put it this way.
They had to find a replacement for DMAPI so that they could stop
carrying DMAPI patches, so pretty serious.
They had to do it one way or the other.

They approached me around the time that FAN_MARK_FILESYSTEM
was merged, so I explained them how to implement HSM using
FAN_MARK_FILESYSTEM+FAN_OPEN_PERM
Whether they ended up using it or not - I don't know.

But I do know for a fact that there are several companies out there
implementing HSM to tier local storage to cloud and CTERA is one of
those companies.

We use FUSE to implement HSM and I have reason to believe that
other companies do that as well.

> kernel is going to be only a small part of what's needed for it to be
> useful and we've dropped DMAPI from SUSE kernels because the code was
> painful to carry (and forwardport + it was not of great quality) and the
> demand for it was not really big... So I'd prefer to avoid the major API
> extension unless there are serious users out there - perhaps we will even
> need to develop the kernel API in cooperation with the userspace part to
> verify the result is actually usable and useful. But for now we can take it
> as an interesting mental excercise ;)
>

Certainly. Let's make this a "Call for Users".

> > Basically, FAN_OPEN_PERM + FAN_MARK_FILESYSTEM
> > should be enough to implement a basic HSM, but it is not
> > sufficient for implementing more advanced HSM features.
> >
> > Some of the HSM feature that I would like are:
> > - blocking hook before access to file range and fill that range
> > - blocking hook before lookup of child and optionally create child
> >
> > My thoughts on the UAPI were:
> > - Allow new combination of FAN_CLASS_PRE_CONTENT
> >   and FAN_REPORT_FID/DFID_NAME
> > - This combination does not allow any of the existing events
> >   in mask
> > - It Allows only new events such as FAN_PRE_ACCESS
> >   FAN_PRE_MODIFY and FAN_PRE_LOOKUP
> > - FAN_PRE_ACCESS and FAN_PRE_MODIFY can have
> >   optional file range info
> > - All the FAN_PRE_ events are called outside vfs locks and
> >   specifically before sb_writers lock as in my fsnotify_pre_modify [1]
> >   POC
> >
> > That last part is important because the HSM daemon will
> > need to make modifications to the accessed file/directory
> > before allowing the operation to proceed.
>
> My main worry here would be that with FAN_FILESYSTEM marks, there will be
> far to many events (especially for the lookup & access cases) to reasonably
> process. And since the events will be blocking, the impact on performance
> will be large.
>

Right. That problem needs to be addressed.

> I think that a reasonably efficient HSM will have to stay in the kernel
> (without generating work for userspace) for the "nothing to do" case. And
> only in case something needs to be migrated, event is generated and
> userspace gets involved. But it isn't obvious to me how to do this with
> fanotify (I could imagine it with say overlayfs which is kind of HSM
> solution already ;)).
>

Yeh, overlayfs was on my radar for this as well ;)
as well as eBPF-FUSE:
https://lore.kernel.org/linux-fsdevel/CAOQ4uxh2OZ_AMp6XRcMy0ZtjkQnBfBZFhH0t-+Pd298uPuSEVw@mail.gmail.com/

There is an existing HSM solution out there that this proposal is modeled after:
https://docs.microsoft.com/en-us/windows/win32/projfs/projected-file-system

The Windows ProjFS hooks into userspace for specific files that were
marked some way.

There was an attempt to implement this interface for Linux but this
project is discontinued:
https://github.com/github/libprojfs/

To do the same thing with fanotify we would either need to define
a new inode flag (i.e. chattr) for this purpose or (much better)
implement an eBPF filter for FAN_MARK_FILESYSTEM, so that
every HSM can choose whichever inode flag it wants.

> > Naturally that opens the possibility for new userspace
> > deadlocks. Nothing that is not already possible with permission
> > event, but maybe deadlocks that are more inviting to trip over.
> >
> > I am not sure if we need to do anything about this, but we
> > could make it easier to ignore events from the HSM daemon
> > itself if we want to, to make the userspace implementation easier.
>
> So if the events happen only in the "migration needed" case, I don't think
> deadlocks would be too problematic - it just requires a bit of care from
> userspace so that the event processing & migration processes do not access
> HSM managed stuff.
>

Right.

> > Another thing that might be good to do is provide an administrative
> > interface to iterate and abort pending fanotify permission/pre-content
> > events.
>
> You can always kill the listener. Or are you worried about cases where it
> sleeps in UN state?
>

FUSE, which is technically also a userspace hook for filesystem operations
can end up in a state where the daemon cannot be killed to release a
deadlock which is why the administrative abort interface is needed:
https://www.kernel.org/doc/html/latest/filesystems/fuse.html#aborting-a-filesystem-connection

I am not sure if we need to worry about this if the fanotify hooks are
called outside of vfs locks (?).

> > You must have noticed the overlap between my old persistent
> > change tracking journal and this design. The referenced branch
> > is from that old POC.
> >
> > I do believe that the use cases somewhat overlap and that the
> > same building blocks could be used to implement a persistent
> > change journal in userspace as you suggested back then.
> >
> > Thoughts?
>
> Yes, there is some overlap. But OTOH HSM seems to require more detailed and
> generally more frequent events which seems like a challenge.
>

I should have mentioned this in my proposal, but you are right -
kernel filtering is an essential part of implementing HSM using fanotify.

The "swap in" should actually be an uncommon case and
after it happens on a certain file that file becomes "warm"
and then "swap out" of that file would be discouraged.

Thanks,
Amir.
