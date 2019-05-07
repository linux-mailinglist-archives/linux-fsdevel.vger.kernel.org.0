Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC86F16AEB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2019 21:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbfEGTNJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 May 2019 15:13:09 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:46065 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbfEGTNJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 May 2019 15:13:09 -0400
Received: by mail-yw1-f67.google.com with SMTP id w18so14108648ywa.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 May 2019 12:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t9Z8VteRDcRMZyYoJ5Q59wYmtn8wPxsUbTltBvWAwl0=;
        b=gtAE3CZDrBZ5AnqfoCD1sV66j2j/wKTXxv3ZvtKkYyNzgR3PNSIZxATL4UjrubFyru
         fvHhaA1ir8F5vVgRlRlorq5V9nI4kbGEZ6BtD8egK4spvP7FqJkTH/mvkoQ/9nUmLCb0
         NINbmgbiDi/nR07dDv9A352y5tAOdO9Q+u6cflR9KEJqFmHm+jAOpSmGdkIcnlDB2Dgc
         iIF14IDmxuOHeuH6v5NRwVEjEFkvlz7OVY4Ao8Vj3SbZkdRvG0u9jAS/WWconLDgwox3
         Ue1qSkrdv2XUA9ixkWkFt+5dUFwMkVDZY5hFZ1TjBIIekgXdV8Gh4VovVkufDMCn00is
         YykA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t9Z8VteRDcRMZyYoJ5Q59wYmtn8wPxsUbTltBvWAwl0=;
        b=E5EBVQiPloywZfCnziiqDVBzNoKQRgEcKThNYQ1gRhgyKnRq9huKGisz6bAP+L/5dK
         Mfd8ogxANwJNRL8/hhD38Rt9pJTGcwPWXUPXjvtJp+l7PVLJI3y4t+1s0pucKmjakMjG
         jubzv54IHI2EJSJC3YY0EHcp67KMSWmhBJPqwne1npnFWBhTIO9HOx6Pj1bYn2kAUdGC
         EimMmH9+4gQu6Q8E4LbR0gr08o9r8Vq2oeCOZihjYnrTCFDPmbxhvGPXM/JogTAgOv/n
         /FIZfObbKKnWQRc5JNjzPuaec91YIWqQ80TC3E2Lj6gKnfmZmg43muALseZMKzHWxJ21
         3kxA==
X-Gm-Message-State: APjAAAWYAAB4g3sd0yDZ3Qd81rhU5F9u/+au0NRSGDNxjrhZv0JSanSz
        Mi7ys5MMF/gdEC9h0sIvmTxxLl37hxaM5znRsdO36X9B
X-Google-Smtp-Source: APXvYqxG0B7MFPMDc+Y4FvXWorwKPhcr1PcIBAnuXzhwgWK9cmHqLpjfCLKKtxuG1DA+F7ceQ+FXlsR+IHKj5x2ph1s=
X-Received: by 2002:a81:9903:: with SMTP id q3mr13023162ywg.211.1557256388675;
 Tue, 07 May 2019 12:13:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAOQ4uxgde7UeFRkD13CHYX2g3SyKY92zX8Tt_wSShkNd9QPYOA@mail.gmail.com>
 <20190505200728.5892-1-amir73il@gmail.com> <20190507161928.GE4635@quack2.suse.cz>
In-Reply-To: <20190507161928.GE4635@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 7 May 2019 22:12:57 +0300
Message-ID: <CAOQ4uxgHgSiNGqozbR-pqF0BU7J-R51wXUwT_fDUnYbix3kGXw@mail.gmail.com>
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

On Tue, May 7, 2019 at 7:19 PM Jan Kara <jack@suse.cz> wrote:
>
> On Sun 05-05-19 23:07:28, Amir Goldstein wrote:
> > __fsnotify_parent() has an optimization in place to avoid unneeded
> > take_dentry_name_snapshot().  When fsnotify_nameremove() was changed
> > not to call __fsnotify_parent(), we left out the optimization.
> > Kernel test robot reported a 5% performance regression in concurrent
> > unlink() workload.
> >
> > Modify __fsnotify_parent() so that it can be called also to report
> > directory modififcation events and use it from fsnotify_nameremove().
> >
> > Reported-by: kernel test robot <rong.a.chen@intel.com>
> > Link: https://lore.kernel.org/lkml/20190505062153.GG29809@shao2-debian/
> > Link: https://lore.kernel.org/linux-fsdevel/20190104090357.GD22409@quack2.suse.cz/
> > Fixes: 5f02a8776384 ("fsnotify: annotate directory entry modification events")
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >
> > Jan,
> >
> > A nicer approach reusing __fsnotify_parent() instead of copying code
> > from it.
> >
> > This version does not apply cleanly to Al's for-next branch (there are
> > some fsnotify changes in work.dcache). The conflict is trivial and
> > resolved on my fsnotify branch [1].
>
> Hum, let me check if I understand the situation right. We've changed
> fsnotify_nameremove() to not use fsnotify_parent() as we don't want to
> report FS_EVENT_ON_CHILD with it anymore. We should use fsnotify_dirent()
> as for all other directory event notification handlers but that's
> problematic due to different locking context and possible instability of
> parent.
>

Yes. Not only do we not want to report FS_EVENT_ON_CHILD with
FS_DELETE, but we also need to report it to dir inode and to fs sb
regardless of DCACHE_FSNOTIFY_PARENT_WATCHED.

> Honestly I don't like the patch below much. How we are notifying parent
> without sending FS_EVENT_ON_CHILD and modify behavior based on that flag
> just looks subtle.

I see, although please note that reporting FS_EVENT_ON_CHILD
is strongly related to the "modified behavior", because unless this an
a report of event on_child, DCACHE_FSNOTIFY_PARENT_WATCHED
is not relevant.

> So I'd rather move the fsnotify call to vfs_unlink(),
> vfs_rmdir(), simple_unlink(), simple_rmdir(), and then those few callers of
> d_delete() that remain as you suggest elsewhere in this thread. And then we
> get more consistent context for fsnotify_nameremove() and could just use
> fsnotify_dirent().
>

Yes, I much prefer this solution myself and I will follow up with it,
but it would not be honest to suggest said solution as a stable fix
to the performance regression that was introduced in v5.1.
I think is it better if you choose between lesser evil:
v1 with ifdef CONFIG_FSNOTIFY to fix build issue
v2 as subtle as it is
OR another obviously safe stable fix that you can think of

The change of cleansing d_delete() from fsnotify_nameremove()
requires more research and is anyway not stable tree material -
if not for the level of complexity, then because all the users of
FS_DELETE from pseudo and clustered filesystems need more time
to find regressions (we do not have test coverage for those in LTP).

Thanks,
Amir.
