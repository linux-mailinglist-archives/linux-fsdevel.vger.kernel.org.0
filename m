Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04AB93BF56D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jul 2021 08:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbhGHGTX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Jul 2021 02:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbhGHGTW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Jul 2021 02:19:22 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4021DC061574;
        Wed,  7 Jul 2021 23:16:40 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id v3so6823082ioq.9;
        Wed, 07 Jul 2021 23:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2kh71cbRAp+0W+wcIHglMYX7muuD/4uXgU3T8q2huOo=;
        b=qjrU7U/XkGlafZ3ggVEa+alvFUQ+yKBNrAyhkL0km2/XPXOINzULejfPRcguPJ57uu
         pNGAX5nBr9zL0JYoR+rQujG/cZvOUOqLrRRd6Re++xDc4/yDo4+0zeDih0qQNZdMhDmc
         E1P97yGDoAG+3qoYbb6xgY6PDY/Zm6u1O+O7zWX8bSOaWS2uZpj6Mvm2qGLq7T2f0Nah
         2QYqu7BkWeq7D9QjUlkMlEsdgaMP3vj3zQYhjBdu9yy5hsq26QdS39wpm/RL6J1I/78J
         knWVx/lns6JUCkkUTeu56W9mUEtlf0b9blXPubS9jb9ANQguQQ9/6paxuzLZiqAqwwC7
         kADQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2kh71cbRAp+0W+wcIHglMYX7muuD/4uXgU3T8q2huOo=;
        b=DP+GsBD4oDRp9D9vq+21jRIHelkrhHg9Ha/O1fMAgmT9qXcyf5jMq/MnobU3R1TZk7
         k2JKrHveeBnbDG5W8LNZMAGDkuYiL+ZxXiJ6Y/4c9STyaqe7KhYWLjdtGPxDUKXjUlgZ
         02p3gvZPCo9nFK8ZrGGK1PIubvj9//jP688Zvx/dcb3PgWcwbp+nCALrekRQYNPgF+j3
         Yj/q8r5frZSimWP+IxP8IIOzaPVkwsCLA4Og5+w1d1IX//itsXg3w7zLnFwuzbt/Kdag
         ikkJW4pdwgRqN4omm8/4/OrEKysS48p2sT7bySJgMu1o4MhQ6B8FZvoI7pSe5kA9I8Yo
         A4Yw==
X-Gm-Message-State: AOAM530iptbQLUf9I7hlvn0JlVjQyl6zRnpFwp247Is7lII0dmMtV/fa
        0vRzynp511nUNQHba4Q1v6FdI2oFd8xzHxL0KN4=
X-Google-Smtp-Source: ABdhPJxfpX+pT9kO46jEyI2pxmB9fVKY4SoBQHFTm46UDBJln0nYPxXnEGdw6bXjQTjpRQMnnfl4G5bWaLoGZZJsROY=
X-Received: by 2002:a02:a60a:: with SMTP id c10mr18436682jam.81.1625724998224;
 Wed, 07 Jul 2021 23:16:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210629191035.681913-1-krisman@collabora.com>
 <20210629191035.681913-5-krisman@collabora.com> <20210707201310.GG18396@quack2.suse.cz>
In-Reply-To: <20210707201310.GG18396@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 8 Jul 2021 09:16:26 +0300
Message-ID: <CAOQ4uxh0Rr9P3q3e8exzcMrdKTnx-LsdaWNmHvYTghUth5nnjg@mail.gmail.com>
Subject: Re: [PATCH v3 04/15] fanotify: Split superblock marks out to a new cache
To:     Jan Kara <jack@suse.cz>
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Theodore Tso <tytso@mit.edu>,
        Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.com>,
        David Howells <dhowells@redhat.com>,
        Khazhismel Kumykov <khazhy@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 7, 2021 at 11:13 PM Jan Kara <jack@suse.cz> wrote:
>
> On Tue 29-06-21 15:10:24, Gabriel Krisman Bertazi wrote:
> > FAN_ERROR will require an error structure to be stored per mark.  But,
> > since FAN_ERROR doesn't apply to inode/mount marks, it should suffice to
> > only expose this information for superblock marks. Therefore, wrap this
> > kind of marks into a container and plumb it for the future.
> >
> > Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
>
> ...
>
> > -static void fanotify_free_mark(struct fsnotify_mark *fsn_mark)
> > +static void fanotify_free_mark(struct fsnotify_mark *mark)
> >  {
> > -     kmem_cache_free(fanotify_mark_cache, fsn_mark);
> > +     if (mark->flags & FSNOTIFY_MARK_FLAG_SB) {
> > +             struct fanotify_sb_mark *fa_mark = FANOTIFY_SB_MARK(mark);
> > +
> > +             kmem_cache_free(fanotify_sb_mark_cache, fa_mark);
> > +     } else {
> > +             kmem_cache_free(fanotify_mark_cache, mark);
> > +     }
> >  }
>
> Frankly, I find using mark->flags for fanotify internal distinction of mark
> type somewhat ugly. Even more so because fsnotify_put_mark() could infer
> the mark type information from mark->conn->type and pass it to the freeing
> function. But the passing would be somewhat non-trivial so probably we can
> leave that for some other day. But the fact that FSNOTIFY_MARK_FLAG_SB is
> set inside fsnotify-backend specific code is a landmine waiting just for
> another backend to start supporting sb marks, not set
> FSNOTIFY_MARK_FLAG_SB, and some generic code depend on checking
> FSNOTIFY_MARK_FLAG_SB instead of mark->conn->type.
>
> So I see two sensible solutions:
>
> a) Just admit this is fanotify private flag, carve out some flags from
> mark->flags as backend private and have FANOTIFY_MARK_FLAG_SB in that space
> (e.g. look how include/linux/buffer_head.h has flags upto BH_PrivateStart,
> then e.g. include/linux/jbd2.h starts its flags from BH_PrivateStart
> further).
>
> b) Make a rule that mark connector type is also stored in mark->flags. We
> have plenty of space there so why not. Then fsnotify_add_mark_locked() has
> to store type into the flags.
>
> Pick your poison :)

I find option a) more flexible for future expansion.
This way fanotify could potentially allocate "normal" sb marks
(e.g. if not FAN_REPORT_FID) and "private" sb marks otherwise
(not that I recommend it - this was just an example)

Also, it is far less fsnotify code changes:

 #define FSNOTIFY_MARK_FLAG_ATTACHED            0x04
+/* Backend private flags */
+#define FSNOTIFY_MARK_FLAG_PRIVATE(x)   (0x100 + (x))

[...]

+#define FANOTIFY_MARK_FLAG_SB FSNOTIFY_MARK_FLAG_PRIVATE(0x01)
+
+struct fanotify_sb_mark {
+       struct fsnotify_mark fsn_mark;
+};
+

Thanks,
Amir.
