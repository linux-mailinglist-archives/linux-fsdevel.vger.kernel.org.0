Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27504223BE1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jul 2020 15:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbgGQNEH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jul 2020 09:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgGQNEG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jul 2020 09:04:06 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7DC0C061755
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jul 2020 06:04:06 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id d16so7566184edz.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jul 2020 06:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qwRjfX/9Iiv2+eNA6c+MQANP26Q3DaOF+RivvR998Rw=;
        b=IztGUBXSvUdhZ/8+EM+IPoGLOg4z3R3RRR1uT3+I41o4/p6J+gJFxq+X1NJ0rp3cJY
         k6CBEh3NAbAUuh6SmtkXcBlksRSxA44ZnMnjF6w0eTKE22FEwii/oPo43CLQt+7hFGiz
         HBwnHxVHedLK83wMgYflWrePwr5IC5c8FuaO8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qwRjfX/9Iiv2+eNA6c+MQANP26Q3DaOF+RivvR998Rw=;
        b=ba6SaEkkUehjbjPNzgXer9V/Rot1l+xQjLWpCYku7D1Jxzghvj3+THlNoXgD7D1WT2
         m0rUV58u/94EL1wL4+TtFdNWdBgYDYBRQgiuSYk45WHdHaVIDIDM9xqNpp4EzDuye58j
         IdOeRo5S93la05Xw3ESzLqKFjMNv2m2ri0d4a+yRY9cLP60d/dEqgehI1PiVTngoekaH
         zWIw2TS3oDSaqOt8t6aR6aIPde5EiSGEcoL9A3Cm2YhFVgffa27RPEiqmVdanKNMGylI
         LTr/FAXIChxBYwSPFiqZX8VQNSmtgMTHuU01PN+v6blEipGU5JHKGrkom/F88WpkIDUJ
         0arA==
X-Gm-Message-State: AOAM5306lnI2H22q2ZZ32VvI3/aIsdsryBt4REQYVc9jTEsfQ3N+yzVD
        fwWW/1OCus24Plgp+0c+97LuOXC3ftdHGo2pWokLiA==
X-Google-Smtp-Source: ABdhPJy2ExwjyJ1BPa+QeVTaNlLxndAFQbT5UiEAPP02gG6VNIbF8I0pyMTCzQ/ZghagSY+GZWHE7FJ6FfNZDZQNJ7c=
X-Received: by 2002:a05:6402:1bdd:: with SMTP id ch29mr9160829edb.134.1594991045356;
 Fri, 17 Jul 2020 06:04:05 -0700 (PDT)
MIME-Version: 1.0
References: <874de72a-e196-66a7-39f7-e7fe8aa678ee@molgen.mpg.de>
 <CAJfpegs7qxiA+bKvS3_e_QNJEn+5YQxR=kEQ95W0wRFCeunWKw@mail.gmail.com> <20200717125208.GP12769@casper.infradead.org>
In-Reply-To: <20200717125208.GP12769@casper.infradead.org>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 17 Jul 2020 15:03:54 +0200
Message-ID: <CAJfpeguYBT=3VG=75K5tXp3Yfm0JCkfQvCHPkKq8uNOrMc5+bw@mail.gmail.com>
Subject: Re: `ls` blocked with SSHFS mount
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>, linux-fsdevel@vger.kernel.org,
        it+linux-fsdevel@molgen.mpg.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 17, 2020 at 2:52 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Fri, Jul 17, 2020 at 02:39:03PM +0200, Miklos Szeredi wrote:
> > On Fri, Jul 17, 2020 at 10:07 AM Paul Menzel <pmenzel@molgen.mpg.de> wrote:
> > > [105591.121285] INFO: task ls:21242 blocked for more than 120 seconds.
> > > [105591.121293]       Not tainted 5.7.0-1-amd64 #1 Debian 5.7.6-1
> > > [105591.121295] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> > > disables this message.
> > > [105591.121298] ls              D    0 21242    778 0x00004004
> > > [105591.121304] Call Trace:
> > > [105591.121319]  __schedule+0x2da/0x770
> > > [105591.121326]  schedule+0x4a/0xb0
> > > [105591.121339]  request_wait_answer+0x122/0x210 [fuse]
> > > [105591.121349]  ? finish_wait+0x80/0x80
> > > [105591.121357]  fuse_simple_request+0x198/0x290 [fuse]
> > > [105591.121366]  fuse_do_getattr+0xcf/0x2c0 [fuse]
> > > [105591.121376]  vfs_statx+0x96/0xe0
> > >
> > > The `ls` process cannot be killed. The SSHFS issue *Fuse sshfs blocks
> > > standby (Visual Studio Code?)* from 2018 already reported this for Linux
> > > 4.17, and the SSHFS developers asked to report this to the Linux kernel.
> >
> > This is a very old and fundamental issue.   Theoretical solution for
> > killing the stuck process exists, but it's not trivial and since the
> > above mentioned workarounds work well in all cases it's not high
> > priority right now.
>
> What?  All you need to do is return -EINTR from fuse_do_getattr() if
> there's a fatal signal.  What "fundamental issue"?

TL;DR: the fundamental issue is not with getattr, but with ops that
hold locks.  We could make an exception for ops that do not hold
locks, but it would not be a solution to the problem, and as I said
this is not something we can't live with.

The fundamental issue is that  a task killed while the userspace
filesystem is still performing that operation will release the vfs
lock and allow another op requiring that lock tobe sent to the
userspace filesystem.  This may confuse the userspace filesystem
otherwise relying on the locking and quite possibly result in fs
corruption.

To fix this, we need to add shadow locking somewhere that duplicates
the vfs locks but are only released if userspace finished processing
the request.  Best place to put the shadow locks is probably in the
kernel.

Thanks,
Miklos
