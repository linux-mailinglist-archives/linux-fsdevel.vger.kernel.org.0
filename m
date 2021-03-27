Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A67F634B593
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Mar 2021 10:09:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbhC0JH2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 27 Mar 2021 05:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbhC0JGx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 27 Mar 2021 05:06:53 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14B2DC0613B1;
        Sat, 27 Mar 2021 02:06:53 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id t6so7043171ilp.11;
        Sat, 27 Mar 2021 02:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8UM4qDTvG5FI1YwUQ+9DzYT4jA+A+wOqNSmHA+PMwTE=;
        b=COmbHnhuXMA7YKPpBlncY+nXDIk6HTUMSNRf2QxFvG195l2gGhobNEeMoGkAZHb7wj
         gkVHhbpzuWbAz1zLPYHdahE4U/LlxYS9Sd+8/dJ2b8/dWYqxIPnFNZ0x5LhN21SUssqs
         3XFB6pMlukw077/gSYVQfcPwH6UcIccm38s7+y9GaYJiJ2OAuOHrcn0ofmNh3Rx6cQUO
         fFuu5QO7VIweKAN4E30HD2WCvQMHywRCrPBxMgZR6PVzv/hYIYEkZS1ydpnw7jVlMGwv
         c4Qif9Am+Qq/+5KKdGVdo/SeUBYA1867MnboswAjBvNks7ZLzAlA5dlmIQRqfou+E55F
         OSkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8UM4qDTvG5FI1YwUQ+9DzYT4jA+A+wOqNSmHA+PMwTE=;
        b=o4w8cxvvAyLtJkiU+xkO5RBhYFe/FWshzI1GzjXawNZI+pqWA/BTvxFPl/2ne8T8an
         1mZR4LmmS8cRiOodE6Datz0pucqyVoYzXYOOupZPx7K7p9gSKIpWigS5I1GKw1iYbqqs
         83VLppz02xuWnxaHN4w0KOJJ0Ke2n00Hn3Eq/mUK4HXsbgjsHuP9fIQwnorTP0Y4PnnZ
         p2tgZMRQfx/LF+QSnB2B00GcrQeO1MU/Z7GzA+OpuIFJlMKKgcZ79NKZO8bkQ+MTLcRB
         k4kQpLIZxe1diRnS5TGQbNM3MJp5eYruW2nxr6kPK4+0PTfmlv87rOKDAriDjt1X398Q
         yxmA==
X-Gm-Message-State: AOAM532HDgM8LFAp0gMcxs8E2rnD5CHKrzgSbbwKWIemBMkM3lQmWgSb
        DOxVuauxC5dviWig0d5hHX08/9XMaojNWoaCTY0=
X-Google-Smtp-Source: ABdhPJxiTKRrMzN82uEne8nhFbmVOHw3BonW5Tq9jLuPr6eyGyfb4tzZRn23c0tY+eWAKcxwbwLETA67ULvF2iAhG4M=
X-Received: by 2002:a92:50b:: with SMTP id q11mr14436909ile.250.1616836012381;
 Sat, 27 Mar 2021 02:06:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210322171118.446536-1-amir73il@gmail.com> <20210322230352.GW63242@dread.disaster.area>
 <CAOQ4uxjFMPNgR-aCqZt3FD90XtBVFZncdgNc4RdOCbsxukkyYQ@mail.gmail.com> <20210326191554.GB13139@fieldses.org>
In-Reply-To: <20210326191554.GB13139@fieldses.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 27 Mar 2021 12:06:41 +0300
Message-ID: <CAOQ4uxgQNfESKGM3E_aFYtkj6SpP93h8Z3T5Q9yyDGNpGzTayg@mail.gmail.com>
Subject: Re: [PATCH] xfs: use a unique and persistent value for f_fsid
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Jan Kara <jack@suse.cz>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 26, 2021 at 10:15 PM J. Bruce Fields <bfields@fieldses.org> wrote:
>
> On Tue, Mar 23, 2021 at 06:50:44AM +0200, Amir Goldstein wrote:
> > On Tue, Mar 23, 2021 at 1:03 AM Dave Chinner <david@fromorbit.com> wrote:
> > > should be using something common across all filesystems from the
> > > linux superblock, not deep dark internal filesystem magic. The
> > > export interfaces that generate VFS (and NFS) filehandles already
> > > have a persistent fsid associated with them, which may in fact be
> > > the filesystem UUID in it's entirety.
> > >
> >
> > Yes, nfsd is using dark internal and AFAIK undocumnetd magic to
> > pick that identifier (Bruce, am I wrong?).
>
> Sorry, I kept putting off catching up with this thread and only now
> noticed the question.
>
> It's actually done mostly in userspace (rpc.mountd), so "dark internal"
> might not be fair, but it is rather complicated.  There are several
> options (UUID, device number, number provided by the user with fsid=
> option), and I don't recall the logic behind which we use when.
>

I'll take back "dark internal" then and replace it with "light external" ;-)
which is also a problem. If userspace is involved in declaring the id
of the *export* then from NFS client POV, that is not a problem, but
from fsnotify POV, that identifier cannot be determined when an event
happens on an inode NOT via the NFS client.

As a matter of fact, the fanotify requirements about fsid are even more
strict than being able to get fsid from the inode. From fanotify_mark.2:
"
       EXDEV  The filesystem object indicated by pathname resides within
              a filesystem subvolume (e.g., btrfs(5)) which uses a
different fsid
              than its root superblock...
"

> I don't *think* we have good comprehensive documentation of it anywhere.
> I wish we did.  It'd take a little time to put together.  Starting
> points would be linux/fs/nfsd/nfsfh.c and
> nfs-utils/support/export/cache.c.

At least as far as fanotify is concerned, the documentation is not going
to matter. The only thing needed is an fsid value that is queryable via
a userspace API.

f_fsid meets this criteria, which is why it was chosen for fanotify.
Having the fsid reported by fanotify also be stable is a nice to have
feature for very selective use cases, which is why I posted this xfs patch.

Thanks,
Amir.
