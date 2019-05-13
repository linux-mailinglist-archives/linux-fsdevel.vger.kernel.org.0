Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EBCD1BB41
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 May 2019 18:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730549AbfEMQre (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 May 2019 12:47:34 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:34607 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729125AbfEMQrd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 May 2019 12:47:33 -0400
Received: by mail-yw1-f68.google.com with SMTP id n76so11549839ywd.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 May 2019 09:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0+NbXF7LAfrefhECAtvnUvFY631UMIjb+zEJAz34k1U=;
        b=osq4SsIjcU5dpYHqTQkzty8jWPLVOg+vTF73tHYby7ey1XQjCF6DyBsz8hgbJ2ba2o
         3JEGhdDT4p6TB5VT3qQ/QYBRb0iiA3WlL6bBQtBJUCj7UNdLZlZw5YoRpcKzWDxNzyXY
         XORMvBs0HeY6AxuVsTQv6QCVddvodCIAnKXZSqdJ+Pu3FvmkhiN1LG1jgowTJooA4Qt4
         CdccWulprwwuHkbnvx0fWCZmaysg63OxvCvZSRVADEjqULZQoZGkarDYxtqSYMO6CeaA
         b+A9AgZ5Ryq4kQA4Q8pgsOR76KaWYbJr0GP1hc4ZEAD0XJk20uxsFFP+yTwXhsuimYzI
         wuwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0+NbXF7LAfrefhECAtvnUvFY631UMIjb+zEJAz34k1U=;
        b=Kn+ueX3V1rQqrmskHDbQvxKxUK2aobKW3YGI+tKRzD5/8kWxznAsasgjan+MtP1iRU
         kDMSyKar3sge6MdVrhy20uM7d1n+rH7In7w4Z7P0qWExMhv4ZcqPXXK7rDp6gBdacWmS
         LyE6GmR6t7s2Xpz9hSM67LKvIWb4vDUB4hvyzSCBqVsMKIZF2Tagw8ZMIaX0Q8pnzfP1
         aRV0De2HBm5uHpTCm0qtw4kurITQ9C4D6zhadArX8OaOh3Ud1DCePgKhkJgyaOtPMNqV
         iYJhyvQi5ng2V9IIzpKIt7vPakxnAX3myt7IqBoKRG9N5g7eHR+l79VM4O6WfR4rFECR
         yd1g==
X-Gm-Message-State: APjAAAWuQ9IRdFTXZREjMBqwhZgqy6OtkQ2v4Y9+QpxTpkvbuPVitW2W
        JTs60wKXnx/uMJ10LAX4dXLVZ6y0xvLlL26nRac=
X-Google-Smtp-Source: APXvYqw2i7PAEN8Xbasnvm6lXa98nEpGEM86Vl3gWDylsx+qOcuLJWguu/+K4BTMb0LD0377k5zCyZsHCn9IJM20668=
X-Received: by 2002:a81:7554:: with SMTP id q81mr14578010ywc.404.1557766052803;
 Mon, 13 May 2019 09:47:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAOQ4uxgde7UeFRkD13CHYX2g3SyKY92zX8Tt_wSShkNd9QPYOA@mail.gmail.com>
 <20190505200728.5892-1-amir73il@gmail.com> <20190507161928.GE4635@quack2.suse.cz>
 <CAOQ4uxgHgSiNGqozbR-pqF0BU7J-R51wXUwT_fDUnYbix3kGXw@mail.gmail.com>
 <CAOQ4uxhAyfhf2rzYxcQG_kLtiLPzihvnZymSOuzfJcY9L=QsNA@mail.gmail.com>
 <20190509103147.GC23589@quack2.suse.cz> <CAOQ4uxhkfnZ1pXJE9jxpuMpZmyJ0VOQwWDOM4e-=HJaHSathPA@mail.gmail.com>
 <20190513163309.GE13297@quack2.suse.cz>
In-Reply-To: <20190513163309.GE13297@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 13 May 2019 19:47:21 +0300
Message-ID: <CAOQ4uxi5jj24p2iAiOyk1ko=-fVOS11+JvLkRao93yFe5W5niA@mail.gmail.com>
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

On Mon, May 13, 2019 at 7:33 PM Jan Kara <jack@suse.cz> wrote:
>
> On Fri 10-05-19 18:24:42, Amir Goldstein wrote:
> > On Thu, May 9, 2019 at 1:31 PM Jan Kara <jack@suse.cz> wrote:
> > > On Wed 08-05-19 19:09:56, Amir Goldstein wrote:
> > > > On Tue, May 7, 2019 at 10:12 PM Amir Goldstein <amir73il@gmail.com> wrote:
> > > > > Yes, I much prefer this solution myself and I will follow up with it,
> > > > > but it would not be honest to suggest said solution as a stable fix
> > > > > to the performance regression that was introduced in v5.1.
> > > > > I think is it better if you choose between lesser evil:
> > > > > v1 with ifdef CONFIG_FSNOTIFY to fix build issue
> > > > > v2 as subtle as it is
> > > > > OR another obviously safe stable fix that you can think of
> > > > >
> > > > > The change of cleansing d_delete() from fsnotify_nameremove()
> > > > > requires more research and is anyway not stable tree material -
> > > > > if not for the level of complexity, then because all the users of
> > > > > FS_DELETE from pseudo and clustered filesystems need more time
> > > > > to find regressions (we do not have test coverage for those in LTP).
> > > > >
> > > >
> > > > Something like this:
> > > > https://github.com/amir73il/linux/commits/fsnotify_nameremove
> > > >
> > > > Only partially tested. Obviously haven't tested all callers.
> > >
> > > Not quite. I'd add the fsnotify_nameremove() call also to simple_rmdir()
> > > and simple_unlink(). That takes care of:
> > > arch/s390/hypfs/inode.c, drivers/infiniband/hw/qib/qib_fs.c,
> > > fs/configfs/dir.c, fs/debugfs/inode.c, fs/tracefs/inode.c,
> > > net/sunrpc/rpc_pipe.c
> > >
> >
> > simple_unlink() is used as i_op->unlink() implementation of simple
> > filesystems, such as: fs/pstore/inode.c fs/ramfs/inode.c
> > fs/ocfs2/dlmfs/dlmfs.c fs/hugetlbfs/inode.c kernel/bpf/inode.c
> >
> > If we place fsnotify hook in the filesystem implementation and not
> > in vfs_unlink(), what will cover normal fs? If we do place fsnotify hook
> > in vfs_unlink(), then we have a double call to hook.
> >
> > The places we add explicit fsnofity hooks should only be call sites that
> > do not originate from vfs_unlink/vfs_rmdir.
>
> Hum, right. I didn't realize simple_unlink() gets also called through
> vfs_unlink() for some filesystems. But then I'd rather create variants
> simple_unlink_notify() and simple_rmdir_notify() than messing with
> d_delete(). As I just think that fsnotify call in d_delete() happens at a
> wrong layer. d_delete() is about dcache management, not really about
> filesystem name removal which is what we want to notify about.
>

Agreed.
I'll follow up with this solution, hopefully after the stable regression
fix is already merged.

Thanks,
Amir.
