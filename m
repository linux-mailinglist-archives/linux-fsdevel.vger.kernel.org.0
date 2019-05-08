Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFAE817DD7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2019 18:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728324AbfEHQKJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 May 2019 12:10:09 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:33132 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728321AbfEHQKI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 May 2019 12:10:08 -0400
Received: by mail-yw1-f66.google.com with SMTP id q11so16699788ywb.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 May 2019 09:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wGbYpw0kX1qNcSqb1bi8S4yefxodmUiD51PVXe6a90Q=;
        b=i7eR5+nrfawxTCcKmQVZUVnJNt3iZBg1uQtU4wsB0YfywmCJePPeIxSpXZk/mD1SLN
         N1UgX8E0ir+CzuKnE8ADzBUyMdjRsDCoaIEL5cnCOoGTidOpENIJKz5LMm0NLiHXat+H
         qZKt13AqPm+j0aAHOPOsPqsVYpuoJYIQJZ9uMjpnGBMGe3nrshfnDRlGpiCMQJb4Vj9D
         9pEEwa+dpZRKGaQWu8LSYWoQ36AHw5zDENF8Q8dieTd/NOfbHAFiFBs81Asx2Y30lNwe
         H8r8UcU9i3FvxoTPcgocsoL4FdqZHo7iEiWMLJMGvZU4ZQsClIECLorqgAqP7DGt39sY
         38Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wGbYpw0kX1qNcSqb1bi8S4yefxodmUiD51PVXe6a90Q=;
        b=L4jGO/MPjpU9JCO8CoXILTZDT/J9XW/CmOQTkdgaDJSCzzf+d/+2VahzK5PrX92TFb
         4R6uqq5fnhHb6XVw4s+wHZgXbMtQUGVFNBSL4PL1mQ4x/mjPUGfblDz/xFG7Jsq5tkeN
         kc2QMRp+XpEiO3tNQxorNOr0qP4ECe6c5gDDt+C0Z8quY4NsRbkKWWaS4ugYkOW/5ime
         RVaf+gxT9IWbIXsnRJcXJsZLz2Q+KoWfe/IhIPNT+fyH5VwTxuBaBlaSWBEhojiRyaMD
         IfeTzvyzetFSDfXOxIYSB4bKdF9FqCzNYx1hloS6HIfofq1kdnliRH6EMmSfpWqk2NXt
         Q1Pw==
X-Gm-Message-State: APjAAAWK5rbORnNDkS5k/dcfkSzeJRq8uxFXQbg9jRiMawx5xmBYEXFX
        JlwrOVU1blYkKkYVIGMWbQIYBqdVmIcvGkvPRXA=
X-Google-Smtp-Source: APXvYqxg3MubHzbfzUqSqfzy5BeXOVex5wyKv8KC73Fa7y6dKMEFYs1fFsY0e5+aYRrUZHrerPyLZnEWLCbP1+VaEeA=
X-Received: by 2002:a5b:64a:: with SMTP id o10mr5687297ybq.32.1557331807924;
 Wed, 08 May 2019 09:10:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAOQ4uxgde7UeFRkD13CHYX2g3SyKY92zX8Tt_wSShkNd9QPYOA@mail.gmail.com>
 <20190505200728.5892-1-amir73il@gmail.com> <20190507161928.GE4635@quack2.suse.cz>
 <CAOQ4uxgHgSiNGqozbR-pqF0BU7J-R51wXUwT_fDUnYbix3kGXw@mail.gmail.com>
In-Reply-To: <CAOQ4uxgHgSiNGqozbR-pqF0BU7J-R51wXUwT_fDUnYbix3kGXw@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 8 May 2019 19:09:56 +0300
Message-ID: <CAOQ4uxhAyfhf2rzYxcQG_kLtiLPzihvnZymSOuzfJcY9L=QsNA@mail.gmail.com>
Subject: Re: [PATCH v2] fsnotify: fix unlink performance regression
To:     Jan Kara <jack@suse.cz>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>, LKP <lkp@01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 7, 2019 at 10:12 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Tue, May 7, 2019 at 7:19 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Sun 05-05-19 23:07:28, Amir Goldstein wrote:
> > > __fsnotify_parent() has an optimization in place to avoid unneeded
> > > take_dentry_name_snapshot().  When fsnotify_nameremove() was changed
> > > not to call __fsnotify_parent(), we left out the optimization.
> > > Kernel test robot reported a 5% performance regression in concurrent
> > > unlink() workload.
> > >
> > > Modify __fsnotify_parent() so that it can be called also to report
> > > directory modififcation events and use it from fsnotify_nameremove().
> > >
> > > Reported-by: kernel test robot <rong.a.chen@intel.com>
> > > Link: https://lore.kernel.org/lkml/20190505062153.GG29809@shao2-debian/
> > > Link: https://lore.kernel.org/linux-fsdevel/20190104090357.GD22409@quack2.suse.cz/
> > > Fixes: 5f02a8776384 ("fsnotify: annotate directory entry modification events")
> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > ---
> > >
> > > Jan,
> > >
> > > A nicer approach reusing __fsnotify_parent() instead of copying code
> > > from it.
> > >
> > > This version does not apply cleanly to Al's for-next branch (there are
> > > some fsnotify changes in work.dcache). The conflict is trivial and
> > > resolved on my fsnotify branch [1].
> >
> > Hum, let me check if I understand the situation right. We've changed
> > fsnotify_nameremove() to not use fsnotify_parent() as we don't want to
> > report FS_EVENT_ON_CHILD with it anymore. We should use fsnotify_dirent()
> > as for all other directory event notification handlers but that's
> > problematic due to different locking context and possible instability of
> > parent.
> >
>
> Yes. Not only do we not want to report FS_EVENT_ON_CHILD with
> FS_DELETE, but we also need to report it to dir inode and to fs sb
> regardless of DCACHE_FSNOTIFY_PARENT_WATCHED.
>
> > Honestly I don't like the patch below much. How we are notifying parent
> > without sending FS_EVENT_ON_CHILD and modify behavior based on that flag
> > just looks subtle.
>
> I see, although please note that reporting FS_EVENT_ON_CHILD
> is strongly related to the "modified behavior", because unless this an
> a report of event on_child, DCACHE_FSNOTIFY_PARENT_WATCHED
> is not relevant.
>
> > So I'd rather move the fsnotify call to vfs_unlink(),
> > vfs_rmdir(), simple_unlink(), simple_rmdir(), and then those few callers of
> > d_delete() that remain as you suggest elsewhere in this thread. And then we
> > get more consistent context for fsnotify_nameremove() and could just use
> > fsnotify_dirent().
> >
>
> Yes, I much prefer this solution myself and I will follow up with it,
> but it would not be honest to suggest said solution as a stable fix
> to the performance regression that was introduced in v5.1.
> I think is it better if you choose between lesser evil:
> v1 with ifdef CONFIG_FSNOTIFY to fix build issue
> v2 as subtle as it is
> OR another obviously safe stable fix that you can think of
>
> The change of cleansing d_delete() from fsnotify_nameremove()
> requires more research and is anyway not stable tree material -
> if not for the level of complexity, then because all the users of
> FS_DELETE from pseudo and clustered filesystems need more time
> to find regressions (we do not have test coverage for those in LTP).
>

Something like this:
https://github.com/amir73il/linux/commits/fsnotify_nameremove

Only partially tested. Obviously haven't tested all callers.

Thanks,
Amir.
