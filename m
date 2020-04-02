Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B47C319C5A8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Apr 2020 17:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389135AbgDBPTR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Apr 2020 11:19:17 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44435 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389084AbgDBPTR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Apr 2020 11:19:17 -0400
Received: by mail-ed1-f65.google.com with SMTP id i16so4609245edy.11
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Apr 2020 08:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MUZimPCBmfg/lNq5C9li8ToeMH5GybOob9boTMJ8Ry4=;
        b=pJotPFYLX2utpXM+urj5d012OnozHKhG/DAfbSolW1WTTjvFpXzSE2T94VdAu5KGjE
         y6UduEs0avw6aH/jnPIj35O1z9paB7T50YDn82a4NRSD6s3ei7KyuqtU4Kg/o/8lD4KB
         y6eArWXTDzt7ZY64tQxj+HCgONZ3sGjRTBDZI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MUZimPCBmfg/lNq5C9li8ToeMH5GybOob9boTMJ8Ry4=;
        b=G9+MMA4eoyTcCgxHazFY9SttAHJYu0cm+SXezTz7wSoC0PJ0D5/YRy6xdCSXuRsNNA
         2Qwx3JCM9nsVo97uip4GblniRU/6tfx099wKZJGYth3R0Vth5kZOeA2Gufpp+UtiVC+K
         uIKO6yU4HtQE5WE6szPjUkFM/+1/4lZ6KN9eV9k0DfZTXy51RPbi3kzOQ+bklpIb8byL
         cZ+lFZv6TpIop772u9ocDf4jR88DcKMre8N0um6HR3/Eybz7YPgcpucq3esCnQmvoedV
         4eMhqPzdVkFYW36z4iIne3eOstLZ09OfZOZSTwXIicUXSg67RNnONj5TnXABCvJqLagX
         e6IA==
X-Gm-Message-State: AGi0PubvGntJuqv6hYMxr0AadueCEpTxw9rqIsAhITkirQMYqF9i45cN
        zEXyEErGfGimW/h7N7VDFTyHP/HQtwdJz496c2gD4w==
X-Google-Smtp-Source: APiQypKo3qRag48ZV+QcN5Q48u7U1vmvCSGaVa84FwlErWIvq9TTAI/U67RpOOZHpA8X6cv/s5bg8cpOTZDAbDROO0E=
X-Received: by 2002:a17:906:405b:: with SMTP id y27mr3832799ejj.213.1585840754915;
 Thu, 02 Apr 2020 08:19:14 -0700 (PDT)
MIME-Version: 1.0
References: <158454378820.2863966.10496767254293183123.stgit@warthog.procyon.org.uk>
 <158454391302.2863966.1884682840541676280.stgit@warthog.procyon.org.uk>
In-Reply-To: <158454391302.2863966.1884682840541676280.stgit@warthog.procyon.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 2 Apr 2020 17:19:03 +0200
Message-ID: <CAJfpegspWA6oUtdcYvYF=3fij=Bnq03b8VMbU9RNMKc+zzjbag@mail.gmail.com>
Subject: Re: [PATCH 13/17] watch_queue: Implement mount topology and attribute
 change notifications [ver #5]
To:     David Howells <dhowells@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, nicolas.dichtel@6wind.com,
        Ian Kent <raven@themaw.net>,
        Christian Brauner <christian@brauner.io>, andres@anarazel.de,
        Jeff Layton <jlayton@redhat.com>, dray@redhat.com,
        Karel Zak <kzak@redhat.com>, keyrings@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        LSM <linux-security-module@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 18, 2020 at 4:05 PM David Howells <dhowells@redhat.com> wrote:
>
> Add a mount notification facility whereby notifications about changes in
> mount topology and configuration can be received.  Note that this only
> covers vfsmount topology changes and not superblock events.  A separate
> facility will be added for that.
>
> Every mount is given a change counter than counts the number of topological
> rearrangements in which it is involved and the number of attribute changes
> it undergoes.  This allows notification loss to be dealt with.

Isn't queue overrun signalled anyway?

If an event is lost, there's no way to know which object was affected,
so how does the counter help here?

>  Later
> patches will provide a way to quickly retrieve this value, along with
> information about topology and parameters for the superblock.

So?  If we receive a notification for MNT1 with change counter CTR1
and then receive the info for MNT1 with CTR2, then we know that we
either missed a notification or we raced and will receive the
notification later.  This helps with not having to redo the query when
we receive the notification with CTR2, but this is just an
optimization, not really useful.

> Firstly, a watch queue needs to be created:
>
>         pipe2(fds, O_NOTIFICATION_PIPE);
>         ioctl(fds[1], IOC_WATCH_QUEUE_SET_SIZE, 256);
>
> then a notification can be set up to report notifications via that queue:
>
>         struct watch_notification_filter filter = {
>                 .nr_filters = 1,
>                 .filters = {
>                         [0] = {
>                                 .type = WATCH_TYPE_MOUNT_NOTIFY,
>                                 .subtype_filter[0] = UINT_MAX,
>                         },
>                 },
>         };
>         ioctl(fds[1], IOC_WATCH_QUEUE_SET_FILTER, &filter);
>         watch_mount(AT_FDCWD, "/", 0, fds[1], 0x02);
>
> In this case, it would let me monitor the mount topology subtree rooted at
> "/" for events.  Mount notifications propagate up the tree towards the
> root, so a watch will catch all of the events happening in the subtree
> rooted at the watch.

Does it make sense to watch a single mount?  A set of mounts?   A
subtree with an exclusion list (subtrees, types, ???)?

Not asking for these to be implemented initially, just questioning
whether the API is flexible enough to allow these cases to be
implemented later if needed.

>
> After setting the watch, records will be placed into the queue when, for
> example, as superblock switches between read-write and read-only.  Records
> are of the following format:
>
>         struct mount_notification {
>                 struct watch_notification watch;
>                 __u32   triggered_on;
>                 __u32   auxiliary_mount;

What guarantees that mount_id is going to remain a 32bit entity?

>                 __u32   topology_changes;
>                 __u32   attr_changes;
>                 __u32   aux_topology_changes;

Being 32bit this introduces wraparound effects.  Is that really worth it?

>         } *n;
>
> Where:
>
>         n->watch.type will be WATCH_TYPE_MOUNT_NOTIFY.
>
>         n->watch.subtype will indicate the type of event, such as
>         NOTIFY_MOUNT_NEW_MOUNT.
>
>         n->watch.info & WATCH_INFO_LENGTH will indicate the length of the
>         record.

Hmm, size of record limited to 112bytes?  Is this verified somewhere?
Don't see a BUILD_BUG_ON() in watch_sizeof().

>
>         n->watch.info & WATCH_INFO_ID will be the fifth argument to
>         watch_mount(), shifted.
>
>         n->watch.info & NOTIFY_MOUNT_IN_SUBTREE if true indicates that the
>         notifcation was generated in the mount subtree rooted at the watch,

notification

>         and not actually in the watch itself.
>
>         n->watch.info & NOTIFY_MOUNT_IS_RECURSIVE if true indicates that
>         the notifcation was generated by an event (eg. SETATTR) that was
>         applied recursively.  The notification is only generated for the
>         object that initially triggered it.

Unused in this patchset.  Please don't add things to the API which are not used.

>
>         n->watch.info & NOTIFY_MOUNT_IS_NOW_RO will be used for
>         NOTIFY_MOUNT_READONLY, being set if the superblock becomes R/O, and
>         being cleared otherwise,

Does this refer to mount r/o flag or superblock r/o flag?  Confused.

> and for NOTIFY_MOUNT_NEW_MOUNT, being set
>         if the new mount is a submount (e.g. an automount).

Huh?  What has r/o flag do with being a submount?

>
>         n->watch.info & NOTIFY_MOUNT_IS_SUBMOUNT if true indicates that the
>         NOTIFY_MOUNT_NEW_MOUNT notification is in response to a mount
>         performed by the kernel (e.g. an automount).
>
>         n->triggered_on indicates the ID of the mount to which the change
>         was accounted (e.g. the new parent of a new mount).

For move there are two parents that are affected.  This doesn't look
sufficient to reflect that.

>
>         n->axiliary_mount indicates the ID of an additional mount that was
>         affected (e.g. a new mount itself) or 0.
>
>         n->topology_changes provides the value of the topology change
>         counter of the triggered-on mount at the conclusion of the
>         operarion.

operation

>
>         n->attr_changes provides the value of the attribute change counter
>         of the triggered-on mount at the conclusion of the operarion.

operation

>
>         n->aux_topology_changes provides the value of the topology change
>         counter of the auxiliary mount at the conclusion of the operation.
>
> Note that it is permissible for event records to be of variable length -
> or, at least, the length may be dependent on the subtype.  Note also that
> the queue can be shared between multiple notifications of various types.

Will review code later...

Thanks,
Miklos
