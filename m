Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF855366801
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Apr 2021 11:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238103AbhDUJaB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Apr 2021 05:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238079AbhDUJaA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Apr 2021 05:30:00 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D4AC06174A;
        Wed, 21 Apr 2021 02:29:26 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id c4so7843541ilq.9;
        Wed, 21 Apr 2021 02:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kT1m64KD64a6NKz2uCmvGLQfhr0LGo1i+5bBTiha9lE=;
        b=C4enQM8zm+lrSz+/j+SYU31EqIKyyZJVZZ+n6PFAs9J0f94dW+BrC4l+VgMUv5ITVH
         pOOj6fgv9I1+wBpBqyqQ0YoRt86aaaqsXAKQ2N4/KBSh9/IY+pE4H304347JJ454ZT3r
         ymEv1G0nqzOIBZoCrh1KgrrCHWqGXsPUMGNtqIs2FmXKE5V7kwbLI8IgrmEiXLDhLHNa
         7+8X0vOuy9/E98DXtTlzDaPywLcHWJYMF160Lh0pPEo4NvgTqdCoFOPYtzBhUWl7jqK7
         K2WtxlcqPsatXDcVn4WK2qcy2w68R94ifaJq9MgcHdKSwunSXi334seRZjulFgMNy0rs
         qbSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kT1m64KD64a6NKz2uCmvGLQfhr0LGo1i+5bBTiha9lE=;
        b=hS0EKji/5bkQPxYXethtsMp6qWaEsPrIdC1uMQp9iP5NziCNKOLKTKHsSSqgIJ2lkg
         QjMlRkv7IUxYKu0xGKF9OiIqUqEQ7xLO0tSwyfibU5cU34uK4LUNVnE8dw8POnPHbVmD
         JxgBOqIP7MW9fy4rAhjdUZSJvxv8O3C2OxJssDFfqGyNavumdrfjHG470ay/6EmeZJqA
         bVYvmGyu/YJJs6JpF9lV4q2XWIG/do8GeunMa1JGtAm+zVbZnAdd9Z4fF7W9/Uz2wjss
         aXqp7kx/atmruwMrbaLaO9ijNNdYGGwZ9prxHMkSzHluyilqAk40DGKnbX11Ghn8eHAO
         jVjA==
X-Gm-Message-State: AOAM530oVIKpiVEhnrqhvIZajkgl5fUl0jPJeViumYPJKcej7loZAeUC
        Y1HluT4iRHNXJEcamHdUk65PLedVD2BxzqofiQjgUyNBqeI=
X-Google-Smtp-Source: ABdhPJx+zr3YEzzdiSD9znuYjcMsDt29lJahELUAHuXq6xILey9wmkHZbBA/obO5ZQFJnMjhM3mInVgJxIN6SM2y4wg=
X-Received: by 2002:a92:c548:: with SMTP id a8mr24713313ilj.137.1618997365530;
 Wed, 21 Apr 2021 02:29:25 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1618527437.git.repnop@google.com> <e6cd967f45381d20d67c9d5a3e49e3cb9808f65b.1618527437.git.repnop@google.com>
 <20210419132020.ydyb2ly6e3clhe2j@wittgenstein> <20210419135550.GH8706@quack2.suse.cz>
 <20210419150233.rgozm4cdbasskatk@wittgenstein> <YH4+Swki++PHIwpY@google.com> <20210421080449.GK8706@quack2.suse.cz>
In-Reply-To: <20210421080449.GK8706@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 21 Apr 2021 12:29:14 +0300
Message-ID: <CAOQ4uxhmJgbSbk_w_gsYg+zLb9GJv6_oGrmfPiNEYao_U3z9=Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] fanotify: Add pidfd support to the fanotify API
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <repnop@google.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 21, 2021 at 11:04 AM Jan Kara <jack@suse.cz> wrote:
>
> On Tue 20-04-21 12:36:59, Matthew Bobrowski wrote:
> > On Mon, Apr 19, 2021 at 05:02:33PM +0200, Christian Brauner wrote:
> > > A general question about struct fanotify_event_metadata and its
> > > extensibility model:
> > > looking through the code it seems that this struct is read via
> > > fanotify_rad(). So the user is expected to supply a buffer with at least
> > >
> > > #define FAN_EVENT_METADATA_LEN (sizeof(struct fanotify_event_metadata))
> > >
> > > bytes. In addition you can return the info to the user about how many
> > > bytes the kernel has written from fanotify_read().
> > >
> > > So afaict extending fanotify_event_metadata should be _fairly_
> > > straightforward, right? It would essentially the complement to
> > > copy_struct_from_user() which Aleksa and I added (1 or 2 years ago)
> > > which deals with user->kernel and you're dealing with kernel->user:
> > > - If the user supplied a buffer smaller than the minimum known struct
> > >   size -> reject.
> > > - If the user supplied a buffer < smaller than what the current kernel
> > >   supports -> copy only what userspace knows about, and return the size
> > >   userspace knows about.
> > > - If the user supplied a buffer that is larger than what the current
> > >   kernel knows about -> copy only what the kernel knows about, zero the
> > >   rest, and return the kernel size.
> > >
> > > Extension should then be fairly straightforward (64bit aligned
> > > increments)?
> >
> > You'd think that it's fairly straightforward, but I have a feeling
> > that the whole fanotify_event_metadata extensibility discussion and
> > the current limitation to do so revolves around whether it can be
> > achieved in a way which can guarantee that no userspace applications
> > would break. I think the answer to this is that there's no guarantee
> > because of <<reasons>>, so the decision to extend fanotify's feature
> > set was done via other means i.e. introduction of additional
> > structures.
>
> There's no real problem extending fanotify_event_metadata. We already have
> multiple extended version of that structure in use (see e.g. FAN_REPORT_FID
> flag and its effect, extended versions of the structure in
> include/uapi/linux/fanotify.h). The key for backward compatibility is to
> create extended struct only when explicitely requested by a flag when
> creating notification group - and that would be the case here -
> FAN_REPORT_PIDFD or how you called it. It is just that extending the
> structure means adding 8 bytes to each event and parsing extended structure
> is more cumbersome than just fetching s32 from a well known location.
>
> On the other hand extended structure is self-describing (i.e., you can tell
> the meaning of all the fields just from the event you receive) while
> reusing 'pid' field means that you have to know how the notification group
> was created (whether FAN_REPORT_PIDFD was used or not) to be able to
> interpret the contents of the event. Actually I think the self-describing
> feature of fanotify event stream is useful (e.g. when application manages
> multiple fanotify groups or when fanotify group descriptors are passed
> among processes) so now I'm more leaning towards using the extended
> structure instead of reusing 'pid' as Christian suggests. I'm sorry for the
> confusion.
>

But there is a middle path option.
The event metadata can be self described without extending it:

 struct fanotify_event_metadata {
        __u32 event_len;
        __u8 vers;
-       __u8 reserved;
+#define FANOTIFY_METADATA_FLAG_PIDFD   1
+       __u8 flags;
        __u16 metadata_len;
        __aligned_u64 mask;
        __s32 fd;

Thanks,
Amir.
