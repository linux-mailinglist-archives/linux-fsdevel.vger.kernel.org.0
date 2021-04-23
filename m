Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A097D368E04
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Apr 2021 09:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240603AbhDWHke (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Apr 2021 03:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbhDWHkd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Apr 2021 03:40:33 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF68FC061574;
        Fri, 23 Apr 2021 00:39:57 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id s16so42835061iog.9;
        Fri, 23 Apr 2021 00:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0eFyP4CBoxR2zXMawnsNjKh1kmbyyJeUuqoBmNoBQrk=;
        b=jXOvDIseSI6lYeNT1dQ+Eaxpj7kkknv1mqtIzkyca0mPEwtkdpt4frIuvCj+cFLkGr
         06qjvVSxiJJSw3D82uCmUXJnrCxtekwO8Erjh1e+HMxVtOS1BMddtln1ORexxX5W6p9B
         ChH2sdjIr3c6QzePfK395g2F4iZmmouqx7CDG4bPMe9DzbQaXU6YO6rNBvu/hX3EyouP
         +ELllLDL26y0Vpkv9pkPzfNWnivzVRzIJLRSIkLTKHqFjMxkKQHFJL+FXU0WKaKMXfVZ
         CQDDlz8GvkjNBDPhzGzNyyKH9g6it6cgr8LeIs9ZC0JNcMbKCE2YHfl2Qpmmy2bvklwj
         crwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0eFyP4CBoxR2zXMawnsNjKh1kmbyyJeUuqoBmNoBQrk=;
        b=l1l2iFanEb3ybl1pcQCYHVULW/prOc1b5L15Fi0KJZksvJe/8WB4eLW900+4L3fImg
         Fz2q+Mnu1eaSs8vdkH4tLIKHUtISYJKkClyrSzkAzvsaxYDekFpWdNhulS5stybVotlC
         QkDi94BAQpBFcsiWZTYwX7vHN6iUdi6gJz54i28ADTTOErkdEYqbGnuIOV5pGx2uVZr0
         ZQLqtZFqDs7IJl9armkVIEXptq8m5Z2KuCdQqAnWiAgA5n0ZA+SLsFk/rOzW0OrKn9bG
         wCtwesuQ1PvgPHnS5cjOc1wUmVKEpyRP+KS1wa7ddLBfVOVF8U5AH0W2iFxXbWPSBqe8
         y55g==
X-Gm-Message-State: AOAM533nzZIXswr6v6/7nYCNqVc/WgFIdq99S44vnZGVto8LRTrl7+ZX
        xSvx3QxM2A/+hxvAZao34ZoLYifYNnIWnCrrAUc=
X-Google-Smtp-Source: ABdhPJyzm6DHxbShrKljxWmaSfmTEQlzg5urevalIrK5Yt6eAjbI6CJrDAwayZFCiIULDo+9OjNYasu9vhHjdBXjk+8=
X-Received: by 2002:a05:6602:58d:: with SMTP id v13mr2281525iox.64.1619163597209;
 Fri, 23 Apr 2021 00:39:57 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1618527437.git.repnop@google.com> <e6cd967f45381d20d67c9d5a3e49e3cb9808f65b.1618527437.git.repnop@google.com>
 <20210419132020.ydyb2ly6e3clhe2j@wittgenstein> <20210419135550.GH8706@quack2.suse.cz>
 <20210419150233.rgozm4cdbasskatk@wittgenstein> <YH4+Swki++PHIwpY@google.com>
 <20210421080449.GK8706@quack2.suse.cz> <YIIBheuHHCJeY6wJ@google.com>
In-Reply-To: <YIIBheuHHCJeY6wJ@google.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 23 Apr 2021 10:39:46 +0300
Message-ID: <CAOQ4uxhUcefbu+5pLKfx7b-kOPP2OB+_RRPMPDX1vLk36xkZnQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] fanotify: Add pidfd support to the fanotify API
To:     Matthew Bobrowski <repnop@google.com>
Cc:     Jan Kara <jack@suse.cz>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 23, 2021 at 2:06 AM Matthew Bobrowski <repnop@google.com> wrote:
>
> On Wed, Apr 21, 2021 at 10:04:49AM +0200, Jan Kara wrote:
> > On Tue 20-04-21 12:36:59, Matthew Bobrowski wrote:
> > > On Mon, Apr 19, 2021 at 05:02:33PM +0200, Christian Brauner wrote:
> > > > A general question about struct fanotify_event_metadata and its
> > > > extensibility model:
> > > > looking through the code it seems that this struct is read via
> > > > fanotify_rad(). So the user is expected to supply a buffer with at least
> > > >
> > > > #define FAN_EVENT_METADATA_LEN (sizeof(struct fanotify_event_metadata))
> > > >
> > > > bytes. In addition you can return the info to the user about how many
> > > > bytes the kernel has written from fanotify_read().
> > > >
> > > > So afaict extending fanotify_event_metadata should be _fairly_
> > > > straightforward, right? It would essentially the complement to
> > > > copy_struct_from_user() which Aleksa and I added (1 or 2 years ago)
> > > > which deals with user->kernel and you're dealing with kernel->user:
> > > > - If the user supplied a buffer smaller than the minimum known struct
> > > >   size -> reject.
> > > > - If the user supplied a buffer < smaller than what the current kernel
> > > >   supports -> copy only what userspace knows about, and return the size
> > > >   userspace knows about.
> > > > - If the user supplied a buffer that is larger than what the current
> > > >   kernel knows about -> copy only what the kernel knows about, zero the
> > > >   rest, and return the kernel size.
> > > >
> > > > Extension should then be fairly straightforward (64bit aligned
> > > > increments)?
> > >
> > > You'd think that it's fairly straightforward, but I have a feeling
> > > that the whole fanotify_event_metadata extensibility discussion and
> > > the current limitation to do so revolves around whether it can be
> > > achieved in a way which can guarantee that no userspace applications
> > > would break. I think the answer to this is that there's no guarantee
> > > because of <<reasons>>, so the decision to extend fanotify's feature
> > > set was done via other means i.e. introduction of additional
> > > structures.
> >
> > There's no real problem extending fanotify_event_metadata. We already have
> > multiple extended version of that structure in use (see e.g. FAN_REPORT_FID
> > flag and its effect, extended versions of the structure in
> > include/uapi/linux/fanotify.h). The key for backward compatibility is to
> > create extended struct only when explicitely requested by a flag when
> > creating notification group - and that would be the case here -
> > FAN_REPORT_PIDFD or how you called it. It is just that extending the
> > structure means adding 8 bytes to each event and parsing extended structure
> > is more cumbersome than just fetching s32 from a well known location.
> >
> > On the other hand extended structure is self-describing (i.e., you can tell
> > the meaning of all the fields just from the event you receive) while
> > reusing 'pid' field means that you have to know how the notification group
> > was created (whether FAN_REPORT_PIDFD was used or not) to be able to
> > interpret the contents of the event. Actually I think the self-describing
> > feature of fanotify event stream is useful (e.g. when application manages
> > multiple fanotify groups or when fanotify group descriptors are passed
> > among processes) so now I'm more leaning towards using the extended
> > structure instead of reusing 'pid' as Christian suggests. I'm sorry for the
> > confusion.
>
> This approach makes sense to me.
>
> Jan/Amir, just to be clear, we've agreed to go ahead with the extended
> struct approach whereby specifying the FAN_REPORT_PIDFD flag will
> result in an event which includes an additional struct
> (i.e. fanotify_event_info_pid) alongside the generic existing

struct fanotify_event_info_pidfd?

> fanotify_event_metadata (also ensuring that pid has been
> provided). Events will be provided to userspace applications just like
> when specifying FAN_REPORT_FID, correct?
>

Yes.

Thanks,
Amir.
