Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA5F16FEBC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2020 13:15:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727240AbgBZMPD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Feb 2020 07:15:03 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:45925 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726806AbgBZMPD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Feb 2020 07:15:03 -0500
Received: by mail-io1-f66.google.com with SMTP id w9so3044126iob.12
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Feb 2020 04:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i8aL1SjtO0IY16pBcTsdKGb0iFjBF11eY/BNppnxlf4=;
        b=cu/tNtt03/8jTnvEbbNzbjpAy6wo4t8Xf2nDvw+MfWuhgnS7SA1iJfk9DfqY53WW/h
         RvGt3kT5CTJJ9zfFu7icBl8mPiS/hUROkBTh5Lf6GIPG4b0uDtqCpnFUX7HxDxXRevVA
         Vo7JdEVe8kwyh98LvfhyN7UkgISpiV+7VxO76qJGxEei3FM2LLpVh6NxNbLZLaByyxIx
         USQwUl9OX8bP6g0aWQ6ssPoS0sXMtpr/nm56R9bULzNmy5+4IYS8IasJxRCqsisahCu0
         tLt3jTRkXlc9IgEJeOxXz3g6SWNfvTe79++hpyvElZHO3a2Mb1iPty338OJ8RmmwzRZo
         hNcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i8aL1SjtO0IY16pBcTsdKGb0iFjBF11eY/BNppnxlf4=;
        b=MeIlr7xrKgEFxhbp2Vtfk7MUNktIYF3gdVGSztyp47Vwy2mATftQ3HcuFOQ+/KHWOi
         shNYE7u+k8RdkiCKpJIF8zPwvQX/yPL/PBeCO1tdrBUzjyYx3qoNGvurAYtexJAEu8mf
         y7TersKf5TBwZkvT8M2z3mv5tPwgXrj+9tnbeq/Cuvc9/Skn3aFZauADd3IdD79a0daI
         YeVgsku9Xp4EsB+PkouxRvKyzH1IFxF4mfXV5S+WY6a9MZSsGHCMJ4Ug9BGplroZ8973
         K+lTpTQ1U2bENWrc+zHeUJubDIL3UpUDArxky/kYOwAc3LTKvsrwpy5nL0SFgn7n+FPZ
         K5PQ==
X-Gm-Message-State: APjAAAV4vOQZkHVzjUIgEJMHqApCISKG3/q6vkJ9k69Ig5GMekQaKIIN
        3cvpS2h3UmV1Lkh0nVrlPARnWrJLkYTMM3re1pQ=
X-Google-Smtp-Source: APXvYqxzIhq/v6P9Ca9isvaF2NkvtSKaUl4gELry76yBnKz76tLOZo4HqW8B5ALCxJOkG8KrMUHoNtWlOQom8edW5Cs=
X-Received: by 2002:a02:350a:: with SMTP id k10mr3904466jaa.120.1582719302591;
 Wed, 26 Feb 2020 04:15:02 -0800 (PST)
MIME-Version: 1.0
References: <20200217131455.31107-1-amir73il@gmail.com> <20200217131455.31107-9-amir73il@gmail.com>
 <20200226091804.GD10728@quack2.suse.cz>
In-Reply-To: <20200226091804.GD10728@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 26 Feb 2020 14:14:50 +0200
Message-ID: <CAOQ4uxiXbGF+RRUmnP4Sbub+3TxEavmCvi0AYpwHuLepqexdCA@mail.gmail.com>
Subject: Re: [PATCH v2 08/16] fanotify: merge duplicate events on parent and child
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 26, 2020 at 11:18 AM Jan Kara <jack@suse.cz> wrote:
>
> On Mon 17-02-20 15:14:47, Amir Goldstein wrote:
> > With inotify, when a watch is set on a directory and on its child, an
> > event on the child is reported twice, once with wd of the parent watch
> > and once with wd of the child watch without the filename.
> >
> > With fanotify, when a watch is set on a directory and on its child, an
> > event on the child is reported twice, but it has the exact same
> > information - either an open file descriptor of the child or an encoded
> > fid of the child.
> >
> > The reason that the two identical events are not merged is because the
> > tag used for merging events in the queue is the child inode in one event
> > and parent inode in the other.
> >
> > For events with path or dentry data, use the dentry instead of inode as
> > the tag for event merging, so that the event reported on parent will be
> > merged with the event reported on the child.
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
>
> I agree that reporting identical event twice seems wasteful but ...
>
> > @@ -312,7 +313,12 @@ struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
> >       if (!event)
> >               goto out;
> >  init: __maybe_unused
> > -     fsnotify_init_event(&event->fse, inode);
> > +     /*
> > +      * Use the dentry instead of inode as tag for event queue, so event
> > +      * reported on parent is merged with event reported on child when both
> > +      * directory and child watches exist.
> > +      */
> > +     fsnotify_init_event(&event->fse, (void *)dentry ?: inode);
>
> ... this seems quite ugly and also previously we could merge 'inode' events
> with others and now we cannot because some will carry "dentry where event
> happened" and other ones "inode with watch" as object identifier. So if you
> want to do this, I'd use "inode where event happened" as object identifier
> for fanotify.

<scratch head> Why didn't I think of that?...

I suppose you mean to just use:

     fsnotify_init_event(&event->fse, id);


>
> Hum, now thinking about this, maybe we could clean this up even a bit more.
> event->inode is currently used only by inotify and fanotify for merging
> purposes. Now inotify could use its 'wd' instead of inode with exactly the
> same results, fanotify path or fid check is at least as strong as the inode
> check. So only for the case of pure "inode" events, we need to store inode
> identifier in struct fanotify_event - and we can do that in the union with
> struct path and completely remove the 'inode' member from fsnotify_event.
> Am I missing something?

That generally sounds good and I did notice it is strange that wd is not
being compared.
However, I think I was worried that comparing fid+name (in following patches)
would be more expensive than comparing dentry (or object inode) as a
"rule out first" in merge, so I preferred to keep the tag/dentry/id comparison
for fanotify_fid case.

Given this analysis (and assuming it is correct), would you like me to
just go a head
with the change suggested above? or anything beyond that?

Thanks,
Amir.
