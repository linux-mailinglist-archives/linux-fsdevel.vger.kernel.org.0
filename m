Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 730921543D6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2020 13:14:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727756AbgBFMO4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Feb 2020 07:14:56 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:33004 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727111AbgBFMO4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Feb 2020 07:14:56 -0500
Received: by mail-il1-f195.google.com with SMTP id s18so4889718iln.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Feb 2020 04:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OdIwU+LBgb1mL3eWiBfdffn/xin9JFWGFwQp7up5cSI=;
        b=XIWZnYR6J1zwp5bcot+rk0yXn1tsv6AnWRfIHHEBMSovpvawwbIfRBQtq3SL7nn90h
         f03PxjQYN+ebzlrP3uzVKeP1q/1VO5/3YRkb+C2dgTpFPvkUxP8omOLulMEo6z4eAWl5
         Ow9lgphO0cai9MA0f0DWistDqp8wvJCUnPRCk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OdIwU+LBgb1mL3eWiBfdffn/xin9JFWGFwQp7up5cSI=;
        b=oMZgns7t0F4CjUMzdjMU0VVrn9rZYipLf+NulzzC6T331MRNHB/uhk7D+T68BqJ+v8
         DD9S3PtMwKyLOIw77q00wPOfLAEFZYQr9Jq5PjBldlgOdxCfAyDVbiHoAHGp06LjmkJH
         Y1oursf6qFyOgX6gTmFG0sZpsnYg36t+H+KSz2xAPCkgRH23R4q+qIyyDcUZ9PV3aZEW
         wJnxlbbIhvxrTSU+VME1lz6dc7LnXEFIWNxzY1uFyDkFTXdGzvVK6g3gxQuN/mObUQBo
         l0CQVut+RCLCyRQBSZJpz+Qea1Y093HV2NwqK30M69NpSr+eDrolyrMiLJt0JgdQzH5D
         CFqQ==
X-Gm-Message-State: APjAAAW+sYZsb6fGQ64ElRhdY+QILxAcry4z6MgORlWaQcsu6NObpNJX
        O/BFzMVilrEwyJeTjzJyJ2D2cxyx0oEn6uTOm0m4Ng==
X-Google-Smtp-Source: APXvYqxE+BA6Zk65CebUGTDzrMwVNsdAiSl7quXMuQBkl3kHmT6tUoxfD8ik2WVjAAhXaS6b6oKhzg2pzJQig6S43eg=
X-Received: by 2002:a92:c0c9:: with SMTP id t9mr3576959ilf.174.1580991295906;
 Thu, 06 Feb 2020 04:14:55 -0800 (PST)
MIME-Version: 1.0
References: <20200203073652.12067-1-ice_yangxiao@163.com> <CAJfpegsVjca2xGV=9xwE75a5NRSYqLpDu9x_q9CeDZ1vt-GyyQ@mail.gmail.com>
In-Reply-To: <CAJfpegsVjca2xGV=9xwE75a5NRSYqLpDu9x_q9CeDZ1vt-GyyQ@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 6 Feb 2020 13:14:44 +0100
Message-ID: <CAJfpegsPfurF2fB+XgSjr-CnBNcjWiqYCB6bFwP8VKNp3sUChA@mail.gmail.com>
Subject: Re: [PATCH] fuse: Don't make buffered read forward overflow value to
 a userspace process
To:     Xiao Yang <ice_yangxiao@163.com>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        linux-fsdevel@vger.kernel.org, yangx.jy@cn.fujitsu.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 5, 2020 at 3:37 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Mon, Feb 3, 2020 at 8:37 AM Xiao Yang <ice_yangxiao@163.com> wrote:
> >
> > Buffered read in fuse normally goes via:
> > -> generic_file_buffered_read()
> >   ------------------------------
> >   -> fuse_readpages()
> >     -> fuse_send_readpages()
> >   or
> >   -> fuse_readpage() [if fuse_readpages() fails to get page]
> >     -> fuse_do_readpage()
> >   ------------------------------
> >       -> fuse_simple_request()
> >
> > Buffered read changes original offset to page-aligned length by left-shift
> > and extends original count to be multiples of PAGE_SIZE and then fuse
> > forwards these new parameters to a userspace process, so it is possible
> > for the resulting offset(e.g page-aligned offset + extended count) to
> > exceed the whole file size(even the max value of off_t) when the userspace
> > process does read with new parameters.
> >
> > xfstests generic/525 gets "pread: Invalid argument" error on virtiofs
> > because it triggers this issue.  See the following explanation:
> > PAGE_SIZE: 4096, file size: 2^63 - 1
> > Original: offset: 2^63 - 2, count: 1
> > Changed by buffered read: offset: 2^63 - 4096, count: 4096
> > New offset + new count exceeds the file size as well as LLONG_MAX
>
> Thanks for the report and analysis.
>
> However this patch may corrupt the cache if i_size changes between
> calls to fuse_page_length().  (e.g. first page length set to 33;
> second page length to 45; then 33-4095 will be zeroed and 4096-4140
> will be filled from offset 33-77).  This will be mitigated by the
> pages being invalidated when i_size changes
> (fuse_change_attributes()).  Filling the pages with wrong data is not
> a good idea regardless.
>
> I think the best approach is first to just fix the xfstest reported
> bug by clamping the end offset to LLONG_MAX.  That's a simple patch,
> independent of i_size, and hence trivial to verify and hard to mess
> up.

Applied a fix and pushed to:

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git#for-next

Thanks,
Miklos
