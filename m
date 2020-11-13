Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 903132B1960
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Nov 2020 11:52:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbgKMKwf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Nov 2020 05:52:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbgKMKwe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Nov 2020 05:52:34 -0500
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 724D8C0613D1
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2020 02:52:21 -0800 (PST)
Received: by mail-vs1-xe44.google.com with SMTP id t8so4988787vsr.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2020 02:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XcZFuOywFlwUrSIuKL+RneXTqsIWzJFQ00rtiHdVuIE=;
        b=UV+OcPX+NeQsjnK+78MWP8buKX85Bp6VU8jkSm5CWWPwpM9ZntrdAYcROidUIL+sv5
         m7Ns8WBfICyfdYm5JOIL3yIXPAGeXD1uBhcywYbmlzHV1TH9oR3qDJW7qJkR20jzfPZb
         WCLiCZUquwGUvkbhQGpML1jHzaQxZlb1ow1hw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XcZFuOywFlwUrSIuKL+RneXTqsIWzJFQ00rtiHdVuIE=;
        b=Fr6+WIXDHJZXeJ4neVcJV2wl6GY4lhPMTAFLroldSWG1OQzTbzsTKG3CCi6otaWbD3
         iQfMqVPomfwQCz8zMJIKD/ZRRvlZEQg05A5Ghad4uuhpMem9ELnOqKf+Fw3f21U1cWRY
         9OHhztRVRiS1JJ/mShUn5rwufG6P46iNPCXnSFL41AXj0cnFoNpULaoPD/oZmscAGmcq
         4kgA1l+2Um1o990j2QRgQWdHp7J/UI9SEi7Tt4dy8qDfxZdME3UKi96O6ih4borJY3ON
         YSWratEqYNt2Jc1uj0l7XWG0CZh3ZQrNZ1lgoTC/JpZKih87c/PPqYBFuvk3SYi0wp+o
         /tvQ==
X-Gm-Message-State: AOAM532+N6Al6ea7wcr7Z3plQqUU4qYU6zv5Q+HyQBowGE1OKMQ5ZD2d
        3CYeMHeSuUS5wN5Zh6KdKdUAoEX94guiel5l8rHcLg==
X-Google-Smtp-Source: ABdhPJyiPcwMryvps42wpA+gK47Ff52c4pmp8l254UsYyJzozNPofsy0S8KbZyBPW4OmvvphaZyi+5DzPZjddELsD90=
X-Received: by 2002:a05:6102:3203:: with SMTP id r3mr595572vsf.21.1605264740526;
 Fri, 13 Nov 2020 02:52:20 -0800 (PST)
MIME-Version: 1.0
References: <20201109100343.3958378-1-chirantan@chromium.org>
 <20201109100343.3958378-3-chirantan@chromium.org> <CAJfpegv5DdgCqdtSzUS43P9JQeUg9fSyuRXETLNy47=cZyLtuQ@mail.gmail.com>
 <CAJFHJrqZMg6A_QnoOL3e5gNZtYquUPSr4B0ZLZMSKQH6o7sxag@mail.gmail.com>
 <CAJfpegsjeRSeabJK5xLr4g7mDkwT88u+iOnhwCj_78-HT+HVqA@mail.gmail.com> <CAJFHJroPwxB3EW+wFg=NgYsKiQAswd7MNm6Ha3jUAPdp6PMMsg@mail.gmail.com>
In-Reply-To: <CAJFHJroPwxB3EW+wFg=NgYsKiQAswd7MNm6Ha3jUAPdp6PMMsg@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 13 Nov 2020 11:52:09 +0100
Message-ID: <CAJfpegv4X2m=-N69iB+Q_6fneeX_0uMNyzkVqfU+qQXdqXSUNw@mail.gmail.com>
Subject: Re: [PATCH 2/2] fuse: Implement O_TMPFILE support
To:     Chirantan Ekbote <chirantan@chromium.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Dylan Reid <dgreid@chromium.org>,
        Suleiman Souhlal <suleiman@chromium.org>,
        fuse-devel <fuse-devel@lists.sourceforge.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 13, 2020 at 6:19 AM Chirantan Ekbote <chirantan@chromium.org> wrote:
>
> On Tue, Nov 10, 2020 at 4:52 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
> >
> > On Tue, Nov 10, 2020 at 4:33 AM Chirantan Ekbote <chirantan@chromium.org> wrote:
> >
> > > That's not the behavior I observed.  Without this, the O_TMPFILE flag
> > > gets passed through to the server.  The call stack is:
> > >
> > > - do_filp_open
> > >     - path_openat
> > >         - do_tmpfile
> > >             - vfs_tmpfile
> > >                 - dir->i_op->tmpfile
> > >             - finish_open
> > >                 - do_dentry_open
> > >                     - f->f_op->open
> > >
> > > and I didn't see O_TMPFILE being removed anywhere in there.
> >
> > Ah, indeed.
> >
> > The reason I missed this is because IMO the way it *should* work is
> > that FUSE_TMPFILE creates and opens the file in one go.  We shouldn't
> > need two separate request.
> >
> > Not sure how we should go about this... The ->atomic_open() API is
> > sufficient, but maybe we want a new ->atomic_tmpfile().
> >
>
> I think I agree with you that it should probably be a single request
> but at this point is it worth adding an ->atomic_tmpfile() that's only
> used by fuse?  Unlike regular file creation, it's not like the tmpfile
> entry is accessible via any other mechanism so other than latency I
> don't think there's any real harm with having it be 2 separate
> requests.

It's the wrong interface, and we'll have to live with it forever if we
go this route.

Better get the interface right and *then* think about the
implementation.  I don't think adding ->atomic_tmpfile() would be that
of a big deal, and likely other distributed fs would start using it in
the future.

Thanks,
Miklos
