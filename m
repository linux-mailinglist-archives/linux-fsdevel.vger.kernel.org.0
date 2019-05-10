Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D14971A00E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2019 17:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727516AbfEJPYy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 May 2019 11:24:54 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:42251 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727471AbfEJPYy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 May 2019 11:24:54 -0400
Received: by mail-yw1-f68.google.com with SMTP id s5so5022311ywd.9
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 May 2019 08:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RttBHidLvODMpRlI+TVJyiUw0BRsfOYPRetEk9fbxp8=;
        b=hkhJk1ZCm7Hxagk+p9nQb7xYlXe5ZyWhxYeFEBVm3u1hyU+yotnRJJ6QyW8JjxOaa9
         0rr+1yeLlJq8jfbemT4OlnYoVwOzqpUPHFoo11A8zwKyG/N778CEzDbLCHcKnzTp3/q2
         fnUvn5sG57L3NiNcnOXC/zEJwY73cEfTxXfKM8bIjiLmDTL+uVgTxoXePZJZdHXIZVZ5
         QfJKwB7lreGomWDVzKePk+RMqsyBQFd546LNy62U8TO0S4eesm3HWCcP11jkNIHXQDER
         6hvX0Wi5oStn9IjFmuDGzFeuiwLgjmlvrz1hh4OfV8Jpa0m4r6xT7Timga61nYvMsoEu
         1s/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RttBHidLvODMpRlI+TVJyiUw0BRsfOYPRetEk9fbxp8=;
        b=s610cmtpLS3IGtXF6ECdF2pETSQQel69aUcRbD1w5g6xt2CmpfwfH3yGVCm9KJvg+j
         kcNvvnk+7JBnrCCUIJtYNuVur6oeaTmLReD30XI53PztBVU4bcChyhKjDlS3pI0Cltq+
         wkHH7L7msFxHPZlYf9FdzZC7tjRil4TVoswi3HQ3WuuoO00WFcNlU8q6Ng+uGfbU+cAz
         +WrputBgpROoiBUp7S9pmMh0YIPDa6CwjF6dmiqyeT+1KrX44seGwN/DyvE2QDW04aJ0
         lGMWqYiW8/fWSXvaODrKjvclfe1wwec26yaY4LvNfUt/R30PgPn4o8BEhUEEhNyr3bgJ
         mf3A==
X-Gm-Message-State: APjAAAVsskp628rf9vsgF9srj2BHvO67xAYY4hWP/+OtrzJWW6nQhxMb
        2bySBJ93RMQIAb9S/O3wLEyPlHLLJ3ALyE+mmBc=
X-Google-Smtp-Source: APXvYqxgJ7geUj9kHxxNVm5i+OBGNCSEbZVindWE1bTz++3PZDC2gCle+DWeCvH6n3y7m+MD7cJdVDfIgv1KmRikXmc=
X-Received: by 2002:a25:8249:: with SMTP id d9mr5916636ybn.320.1557501893702;
 Fri, 10 May 2019 08:24:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAOQ4uxgde7UeFRkD13CHYX2g3SyKY92zX8Tt_wSShkNd9QPYOA@mail.gmail.com>
 <20190505200728.5892-1-amir73il@gmail.com> <20190507161928.GE4635@quack2.suse.cz>
 <CAOQ4uxgHgSiNGqozbR-pqF0BU7J-R51wXUwT_fDUnYbix3kGXw@mail.gmail.com>
 <CAOQ4uxhAyfhf2rzYxcQG_kLtiLPzihvnZymSOuzfJcY9L=QsNA@mail.gmail.com> <20190509103147.GC23589@quack2.suse.cz>
In-Reply-To: <20190509103147.GC23589@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 10 May 2019 18:24:42 +0300
Message-ID: <CAOQ4uxhkfnZ1pXJE9jxpuMpZmyJ0VOQwWDOM4e-=HJaHSathPA@mail.gmail.com>
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

On Thu, May 9, 2019 at 1:31 PM Jan Kara <jack@suse.cz> wrote:
>
> On Wed 08-05-19 19:09:56, Amir Goldstein wrote:
> > On Tue, May 7, 2019 at 10:12 PM Amir Goldstein <amir73il@gmail.com> wrote:
> > > Yes, I much prefer this solution myself and I will follow up with it,
> > > but it would not be honest to suggest said solution as a stable fix
> > > to the performance regression that was introduced in v5.1.
> > > I think is it better if you choose between lesser evil:
> > > v1 with ifdef CONFIG_FSNOTIFY to fix build issue
> > > v2 as subtle as it is
> > > OR another obviously safe stable fix that you can think of
> > >
> > > The change of cleansing d_delete() from fsnotify_nameremove()
> > > requires more research and is anyway not stable tree material -
> > > if not for the level of complexity, then because all the users of
> > > FS_DELETE from pseudo and clustered filesystems need more time
> > > to find regressions (we do not have test coverage for those in LTP).
> > >
> >
> > Something like this:
> > https://github.com/amir73il/linux/commits/fsnotify_nameremove
> >
> > Only partially tested. Obviously haven't tested all callers.
>
> Not quite. I'd add the fsnotify_nameremove() call also to simple_rmdir()
> and simple_unlink(). That takes care of:
> arch/s390/hypfs/inode.c, drivers/infiniband/hw/qib/qib_fs.c,
> fs/configfs/dir.c, fs/debugfs/inode.c, fs/tracefs/inode.c,
> net/sunrpc/rpc_pipe.c
>

simple_unlink() is used as i_op->unlink() implementation of simple
filesystems, such as: fs/pstore/inode.c fs/ramfs/inode.c
fs/ocfs2/dlmfs/dlmfs.c fs/hugetlbfs/inode.c kernel/bpf/inode.c

If we place fsnotify hook in the filesystem implementation and not
in vfs_unlink(), what will cover normal fs? If we do place fsnotify hook
in vfs_unlink(), then we have a double call to hook.

The places we add explicit fsnofity hooks should only be call sites that
do not originate from vfs_unlink/vfs_rmdir.

> So you're left only with:
> drivers/usb/gadget/function/f_fs.c, fs/btrfs/ioctl.c, fs/devpts/inode.c,
> fs/reiserfs/xattr.c
>
> Out of these drivers/usb/gadget/function/f_fs.c and fs/reiserfs/xattr.c
> actually also don't want the notifications to be generated. They don't
> generate events on file creation AFAICS and at least in case of reiserfs I
> know that xattrs are handled in "hidden" system files so notification does
> not make any sense. So we are left with exactly *two* places that need

OK. good to know.

> explicit fsnotify_nameremove() call. Since both these callers already take
> care of calling fsnotify_create() I think that having explicit
> fsnotify_nameremove() calls there is clearer than the current state.
>

I though so too, but then I did not feel comfortable with "regressing"
delete notifications on many filesystems that did seem plausible for
having notification users like configfs, even though they do not have
create notification, so I decided to do the safer option of converting all
plausible callers of d_delete() that abide to the parent/name stable
constrains to use the d_delete_and_notify() wrapper.

For readers that did not follow my link, those are the call site that were
converted to opt-in for d_delete_and_notify() in the linked branch:
arch/s390/hypfs/inode.c
drivers/infiniband/hw/qib/qib_fs.c
drivers/usb/gadget/function/f_fs.c
fs/btrfs/ioctl.c
fs/configfs/dir.c
fs/debugfs/inode.c
fs/devpts/inode.c
fs/reiserfs/xattr.c
fs/tracefs/inode.c
net/sunrpc/rpc_pipe.c

In addition, nfs and afs no longer need to call fsnotify hook explcitly on
completion of silly rename (delayed unlink).

Thanks,
Amir.
