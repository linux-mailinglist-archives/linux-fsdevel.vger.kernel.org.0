Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A440328F221
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Oct 2020 14:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728521AbgJOMch (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Oct 2020 08:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728048AbgJOMch (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Oct 2020 08:32:37 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4360C061755;
        Thu, 15 Oct 2020 05:32:36 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id k6so4099988ior.2;
        Thu, 15 Oct 2020 05:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=It21HUEP/CV7FitEvMD4n5JsB6P+ylamqrbiit/hLGo=;
        b=az3jJ0S/x9iSqq+JB3mKSeFIMxLxg69WeVdNxSrp/fQEXGBqifG6J0264mBYsv4V/D
         YpkwyKaG6FvZdmBQNMX69ZfjvCYI8fGsdoEE0TZmt3IK5qmGQHQBe6LPdB8cE/fZWBmk
         wheZShG5OCAz3QkwkXykqpSfX34Yv0VM3pqWtHWJlEfFKxyFx6eHDKLEcklV9lI2LOfn
         eoVc8Qq9iAVsg6+2QXEI2zqp7v/LZn8scoi1YmMyGqimKWasV/iGuQXJJ96h1vtLWD7M
         8T5FndrtKCvqX/S04c6YiVgOzssFO9TR7sDqXpsHjeywJx5LZPANr5rkcoOHsEqSBQJJ
         1Dow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=It21HUEP/CV7FitEvMD4n5JsB6P+ylamqrbiit/hLGo=;
        b=h/7fh0KukdSMAKTT0R0OyILD6rV0bAr0VyZllFuusmtRdNdHA80HxoYV45ohgZT1EN
         6vn6d1Lr9LsO3tZ7SBdsmkG/mMONpHo0Pw4DmSqG6qqHowNvE1qFbfv+iqzEweWbhbhs
         CYaraaVHMaSWfp+FMoHmIcasVEjK+oIEz/lSb3xe5yqGs8IIXgpmtOxRAUiGnYnIs1du
         Gfag0xoIiOweOGv7ZTr54POMoCp3Bkti7bFYREdyn7QWMUQk1iohYnDHem6x5HDdmmGI
         4UOH6Ni3O2OvtsLAM/vaUVX6fQ30jPwZfbLrVzXxUQdF9ix88PU0alWq+oE5cqLCBOYw
         NWGQ==
X-Gm-Message-State: AOAM533+raCeMoFtNGIygP087nzDAMF6U4+9A2Fy1wv51IY/iQ9xLdWl
        ojFWebRqFGvebnPJ6DhfpeQ7T7MVmjEU4eUinVO5kLi0hVM=
X-Google-Smtp-Source: ABdhPJw6+7vvOW5OA70+YfAt0GtsxEr+JFY/UpyZekrHQN4MwYJ7M2T4+maWcahNzMcCkFsMVYT+QZKqtzx1pR3B/nI=
X-Received: by 2002:a6b:651a:: with SMTP id z26mr2996527iob.186.1602765156224;
 Thu, 15 Oct 2020 05:32:36 -0700 (PDT)
MIME-Version: 1.0
References: <20201010142355.741645-1-cgxu519@mykernel.net> <20201010142355.741645-2-cgxu519@mykernel.net>
 <20201014161538.GA27613@quack2.suse.cz> <1752a360692.e4f6555543384.3080516622688985279@mykernel.net>
 <CAOQ4uxhOrPfJxhJ1g7eSSdO4=giFJabCCOvJL7dSo1R9VsZozA@mail.gmail.com> <1752c05cbe5.fd554a7a44272.2744418978249296745@mykernel.net>
In-Reply-To: <1752c05cbe5.fd554a7a44272.2744418978249296745@mykernel.net>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 15 Oct 2020 15:32:24 +0300
Message-ID: <CAOQ4uxhEA=ggONsJrUzGfHOGHob+81-UHk1Wo9ejj=CziAjtTQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/5] fs: introduce notifier list for vfs inode
To:     Chengguang Xu <cgxu519@mykernel.net>
Cc:     Jan Kara <jack@suse.cz>, miklos <miklos@szeredi.hu>,
        linux-unionfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>  > Perhaps you can combine that with the shadow overlay sbi approach.
>  > Instead of dirtying overlay inode when underlying is dirtied, you can
>  > "pre-dirty" overlayfs inode in higher level file ops and add them to the
>  > "maybe-dirty" list (e.g. after write).
>  >
>
> Main problem is we can't be notified by set_page_dirty from writable mmap.
> Meanwhile, if we dirty overlay inode then writeback will pick up dirty overlay
> inode and clear it after syncing, then overlay inode could be release at any time,
> so in the end, maybe overlay inode is released but upper inode is still dirty and
> there is no any pointer to find upper dirty inode out.
>

But we can control whether overlay inode is release with ovl_drop_inode()
right? Can we prevent dropping overlay inode if upper inode is
inode_is_open_for_write()?

About re-dirty, see below...

>
>  > ovl_sync_fs() can iterate the maybe-dirty list and re-dirty overlay inodes
>  > if the underlying inode is still dirty on the (!wait) pass.
>  >
>  > As for memory mapped inodes via overlayfs (which can be dirtied without
>  > notifying overlayfs) I am not sure that is a big problem in practice.
>  >
>
> Yes, it's key problem here.
>
>  > When an inode is writably mapped via ovarlayfs, you can flag the
>  > overlay inode with "maybe-writably-mapped" and then remove
>  > it from the maybe dirty list when the underlying inode is not dirty
>  > AND its i_writecount is 0 (checked on write_inode() and release()).
>  >
>  > Actually, there is no reason to treat writably mapped inodes and
>  > other dirty inodes differently - insert to suspect list on open for
>  > write, remove from suspect list on last release() or write_inode()
>  > when inode is no longer dirty and writable.
>  >
>  > Did I miss anything?
>  >
>
> If we dirty overlay inode that means we have launched writeback mechanism,
> so in this case, re-dirty overlay inode in time becomes important.
>

My idea was to use the first call to ovl_sync_fs() with 'wait' false
to iterate the
maybe-dirty list and re-dirty overlay inodes whose upper is dirty.

Then in the second call to __sync_filesystem, sync_inodes_sb() will take
care of calling ovl_write_inode() for all the re-dirty inodes.

In current code we sync ALL dirty upper fs inodes and we do not overlay
inodes with no reference in cache.

The best code would sync only upper fs inodes dirtied by this overlay
and will be able to evict overlay inodes whose upper inodes are clean.

The compromise code would sync only upper fs inodes dirtied by this overlay,
and would not evict overlay inodes as long as upper inodes are "open for write".
I think its a fine compromise considering the alternatives.

Is this workable?

Thanks,
Amir.
