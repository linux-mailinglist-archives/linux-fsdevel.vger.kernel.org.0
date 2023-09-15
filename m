Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4E977A1420
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Sep 2023 05:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231779AbjIODGs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Sep 2023 23:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbjIODGr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Sep 2023 23:06:47 -0400
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C46FA270A;
        Thu, 14 Sep 2023 20:06:43 -0700 (PDT)
Received: by mail-vk1-xa2d.google.com with SMTP id 71dfb90a1353d-495f20c5832so672325e0c.0;
        Thu, 14 Sep 2023 20:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694747203; x=1695352003; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oYtmGG6qL/zG4tahuBG2Sq+on0Fe6qbc1wsa4F9iPKk=;
        b=AkNLur5sXWUQ6BmzfG7L1n/bqy1lTlERiK8kBrPerF37bNT1lMTSj6kp13ASESDfh9
         0xno+AXU3lJgy+qWE/hQXZMZXFEtjzPBvPw163xuXVAe7hE5o3QY3Y6VrYRZOChbZ7fw
         XKn02btuZDsTKbwqLs6m1M5/vCrZ6kccdQLvfb77YWjdIltfZlyGxsD5Crqgv6mj2Sr/
         dL7Utepivn0ffV7I1PNzSEp3W7bovzmxeaWyL4aLMZ3ojYmpnX9f/pO1W7YhsUUEKUJr
         2CPI+ddpb3rR0zHEY+ART/goTuJZz8mIZmeufc2oWLIgTrx93v8r7aiemsiMaM70GTN3
         OV/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694747203; x=1695352003;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oYtmGG6qL/zG4tahuBG2Sq+on0Fe6qbc1wsa4F9iPKk=;
        b=HgF2pXuszv4qkmda7iI7KpCf9bWl2Z2u0LPxlbIUukJ2Lhk4eltocp6XwAGiIYeXmI
         9tKg7TUYmH9sTOMaMTQ5IZcyJvLJyjtQ5VYuei/N6gQ+e2UuHd2+6oJz9CvTK+2uwxR/
         PmdaaSRHIQWNk8tPzZkS8Sj5sYI6D7n6E+sh66C0CqJktX/Z5Xo+kY4giwTSIxeOTVRN
         P1P7kkr45J58fnOK2RWgeG1cvn5VOG86hpFaHRh1JIlEJnhVAm3TO7dpi1t3qgdA51FV
         N1J/aUlCvhEUsyVEyn5Zf8nOsH/3WCNEaFeD53D1uj1SSJt/OaxGxEq1UkcOutGh8c2p
         b1MQ==
X-Gm-Message-State: AOJu0YyFSN/mWBr0foXyCivwkT8udv3WOXNXbKo0D3W9F9UVwvAz/Ae5
        p4MU22iWkj94p93hkmZpBy7KUFS22EYZt+ZucYQ=
X-Google-Smtp-Source: AGHT+IEhMX07JZksQwf7xl95wqZoUqPRGk4v7y/txStcf9i0R4DdtWN/EbCHAyaH4Ri4XhPBhlkDhTEzYcuPbgWxfNk=
X-Received: by 2002:a1f:eb82:0:b0:493:5363:d1dc with SMTP id
 j124-20020a1feb82000000b004935363d1dcmr576225vkh.12.1694747202792; Thu, 14
 Sep 2023 20:06:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230913152238.905247-1-mszeredi@redhat.com> <CAOQ4uxiuc0VNVaF98SE0axE3Mw6wMJJ1t36cmbcM5vwYLqtWSw@mail.gmail.com>
 <904a8d17-b6df-e294-fcf6-6f95459e1ffa@themaw.net>
In-Reply-To: <904a8d17-b6df-e294-fcf6-6f95459e1ffa@themaw.net>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 15 Sep 2023 06:06:31 +0300
Message-ID: <CAOQ4uxgHxVqtvb51Z27Sgft-U=oYtXeiv+3HJbara4zdRC-FZg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] quering mount attributes
To:     Ian Kent <raven@themaw.net>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-man@vger.kernel.org,
        linux-security-module@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 15, 2023 at 4:20=E2=80=AFAM Ian Kent <raven@themaw.net> wrote:
>
> On 14/9/23 14:47, Amir Goldstein wrote:
> > On Wed, Sep 13, 2023 at 6:22=E2=80=AFPM Miklos Szeredi <mszeredi@redhat=
.com> wrote:
> >> Implement the mount querying syscalls agreed on at LSF/MM 2023.  This =
is an
> >> RFC with just x86_64 syscalls.
> >>
> >> Excepting notification this should allow full replacement for
> >> parsing /proc/self/mountinfo.
> > Since you mentioned notifications, I will add that the plan discussed
> > in LFSMM was, once we have an API to query mount stats and children,
> > implement fanotify events for:
> > mount [mntuid] was un/mounted at [parent mntuid],[dirfid+name]
> >
> > As with other fanotify events, the self mntuid and dirfid+name
> > information can be omitted and without it, multiple un/mount events
> > from the same parent mntuid will be merged, allowing userspace
> > to listmnt() periodically only mntuid whose child mounts have changed,
> > with little risk of event queue overflow.
> >
> > The possible monitoring scopes would be the entire mount namespace
> > of the monitoring program or watching a single mount for change in
> > its children mounts. The latter is similar to inotify directory childre=
n watch,
> > where the watches needs to be set recursively, with all the weight on
> > userspace to avoid races.
>
> It's been my belief that the existing notification mechanisms don't
> quite fully satisfy the needs of users of these calls (aka. the need
> I found when implementing David's original calls into systemd).
>
> Specifically the ability to process a batch of notifications at once.
>
> Admittedly the notifications mechanism that David originally implemented
> didn't fully implement what I found I needed but it did provide for a
> settable queue length and getting a batch of notifications at a time.
>
> Am I mistaken in my belief?
>

I am not sure I understand the question.

fanotify has an event queue (16K events by default), but it can
also use unlimited size.
With a limited size queue, event queue overflow generates an
overflow event.

event listeners can read a batch of events, depending on
the size of the buffer that they provide.

when multiple events with same information are queued,
for example "something was un/mounted over parent mntuid 100"
fanotify will merged those all those events in the queue and the
event listeners will get only one such event in the batch.

> Don't misunderstand me, it would be great for the existing notification
> mechanisms to support these system calls, I just have a specific use case
> in mind that I think is important, at least to me.
>

Please explain the use case and your belief about existing fanotify
limitations. I did not understand it.

Thanks,
Amir.
