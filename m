Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A85C1F9F64
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jun 2020 20:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731343AbgFOSc3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Jun 2020 14:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729354AbgFOSc3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Jun 2020 14:32:29 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13BEFC061A0E;
        Mon, 15 Jun 2020 11:32:29 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id g3so1013137ilq.10;
        Mon, 15 Jun 2020 11:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3Ju2CK/5JT+Aa3sS8yMCiNxVZSpDlKEY0dOrTNPmcdo=;
        b=d52YDIB0gnUumzeigaFjn3geebR0cj1uocUHfj2gyCSlvSV0+eCFCP2SyVHXJT44Q0
         I69YuQ0LjIWuSzlvaBJADaeV9BbNHkEnc1iFf3FQozt6J5QmYVnm8wl+CnLTRdez2ueR
         gzmcdHb7RXtewqd1OuNYrgGvA39EUCyLd8uliOF/+scxv3eqSZazLmeWzx0IqfzxJVDD
         p6RvQipYBAMDlyfrIL39TQTFfrrqxBtyJl4NHdlxSC80fhloDayq1wdGWYLkQzicOh8U
         jy+mqNVpG/qYyjXc2qDHV5JGNoQ9SgyTPPAs7g+UopJxHlw1fzkKcl1HrWfy1VH0AtO2
         5fqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3Ju2CK/5JT+Aa3sS8yMCiNxVZSpDlKEY0dOrTNPmcdo=;
        b=DM14MTfqiCZ/CxhfGiF6r8eQ0a3eoF3LxwPqqcG/Wty+lEr/nmyq+nNoXYsehO9Ujr
         NCj2hYX0gagQO7ZScJLcrcpBz9evHRynQNpVjhIoaFmY5n9T9qKS0XR6VwJDU7Hjk8od
         ZorVeAOvlIAqYQ0uIs/lGZ375/Jyry864Y3fNX2oPJ43GafU520YeN8GO0ctiZyi/kyy
         NZ3atuNmswO/gSP9BWClRamQL+pNHtf8D6xNAFDv/dJCJuG+hnMvM/sawFhySGvSo0Y0
         ovoz0/sWOxg+f78+I0aa9a3h3cFsxZnz1NItzO6AKeM6pRyNDbtpCtvJNt1PwZeBeInK
         BWFw==
X-Gm-Message-State: AOAM5328jgmgLkj38mQGs6etrFwcwIhz8p7hSzeMVDc9F8cnBzOOirSJ
        6Rg7wsI29Ex0DM5RdXU/FJsIxIoWAERSM39qtTQ=
X-Google-Smtp-Source: ABdhPJwCimuYm3Md2+QbZCpOZo5BVsQVZQ5O52qkXatdGcrNd13nnmHXATWjRg9wQjqfg7W9+9FTdnlojDp+9ReomjM=
X-Received: by 2002:a92:c60b:: with SMTP id p11mr28860644ilm.137.1592245948442;
 Mon, 15 Jun 2020 11:32:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200615121358.GF3183@techsingularity.net> <CAOQ4uxi0fqKFZ9=U-+DQ78233hR9TXEU44xRih4q=M556ynphA@mail.gmail.com>
 <20200615172545.GG3183@techsingularity.net>
In-Reply-To: <20200615172545.GG3183@techsingularity.net>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 15 Jun 2020 21:32:16 +0300
Message-ID: <CAOQ4uxikAD0FFZdnkd_aHfst0G3j0Gt1_oGDb75z8gHpaE3ERg@mail.gmail.com>
Subject: Re: [PATCH v2] fs: Do not check if there is a fsnotify watcher on
 pseudo inodes
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 15, 2020 at 8:25 PM Mel Gorman <mgorman@techsingularity.net> wrote:
>
> On Mon, Jun 15, 2020 at 07:26:38PM +0300, Amir Goldstein wrote:
> > On Mon, Jun 15, 2020 at 3:14 PM Mel Gorman <mgorman@techsingularity.net> wrote:
> > >
> > > Changelog since v1
> > > o Updated changelog
> >
> > Slipped to commit message
> >
>
> It's habit, it's the layout I generally use for mm even though others
> prefer having it below ---. I wasn't sure of fsnotify's preferred format
> for tracking major differences between versions.
>
> > >
> > > The kernel uses internal mounts created by kern_mount() and populated
> > > with files with no lookup path by alloc_file_pseudo for a variety of
> > > reasons. An example of such a mount is for anonymous pipes. For pipes,
> > > every vfs_write regardless of filesystem, fsnotify_modify() is called to
> > > notify of any changes which incurs a small amount of overhead in fsnotify
> > > even when there are no watchers. It can also trigger for reads and readv
> > > and writev, it was simply vfs_write() that was noticed first.
> > >
> > > A patch is pending that reduces, but does not eliminte, the overhead of
> >
> > typo: eliminte
> >
>
> Yes.
>
> > > fsnotify but for files that cannot be looked up via a path, even that
> > > small overhead is unnecessary. The user API for fanotify is based on
> > > the pathname and a dirfd and proc entries appear to be the only visible
> > > representation of the files. Proc does not have the same pathname as the
> > > internal entry and the proc inode is not the same as the internal inode
> > > so even if fanotify is used on a file under /proc/XX/fd, no useful events
> > > are notified.
> > >
> >
> > Note that fanotify is not the only uapi to add marks, but this is fine by me
> > I suppose if Jan wants to he can make small corrections on commit.
> >
>
> True but I didn't think inotify was materially different as it also takes
> a path. Is that wrong or are there others that matter and can attach to
> a file that cannot be looked up via a path?

There are kernel/audit* and nfsd/filecache.c users, but as far as I could
tell, there is no danger from there. I was just pointing out that the fanotify
uapi argument alone is not a full proof.

Thanks,
Amir.
