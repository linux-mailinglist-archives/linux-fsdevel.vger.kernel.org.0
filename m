Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 551D812231E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2019 05:24:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbfLQEYE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Dec 2019 23:24:04 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:45286 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726772AbfLQEYE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Dec 2019 23:24:04 -0500
Received: by mail-il1-f196.google.com with SMTP id p8so7273217iln.12
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Dec 2019 20:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oxAjGmT4g9RkM0QbJwp4D9wtSuLJ27EznD62EobY7Dk=;
        b=jNBrglX6nlXXyYUb6mn/HDjh88ATqtynKhLpV+BkCES0jhDci+Tnxtrke62BE0gwNd
         zJiJ1U/Rek12MtIJAc9bKpz8xIgpaldb9U4UTF/LxqRd07xUEem45cM7Yj2MCiUHGFdc
         gxz3erwgaaob5U8m9vAaYmRnhEJEAsoUV4UWU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oxAjGmT4g9RkM0QbJwp4D9wtSuLJ27EznD62EobY7Dk=;
        b=tH4fnusigmJ2bmI6e4Yfph4wnD36BGfXhwj9rVe2eKQpG7OTPYIBP8cY5I1CUx+8MA
         gQQFQGEf4QapFG4wg0oPgRDFtmJsv4AxFXrGSuHaKLKOLf2tiLDU1kqx2fbrJas7Th0U
         U5inW6BvCAIp+yLm1LjV2ZFpTJzvfoAZH0HG2QCC7xIypF4UWiZcf03O47hwmoTlq1bZ
         tKFtGkLGBXvL3e8YizPntKVv+Cy+FmOgG5tBMir0jrLc2TO8dCqkrlxPOW6JLqNnct2I
         h9093wkDSoUvCZBO+cpclPDUrPJf+t0Xk6Jo7rbm6zkd8/eTf0EeSP2NK23x5M8xEoVw
         QH7A==
X-Gm-Message-State: APjAAAUo8HAyL1UcyyhaaJtfbsX3Ofn57luXrl4PukmHtbhPlatywfRU
        vA75Z8SsZqd7tKfFdCtMV6XnFQekqvSy3v56H5s8Ow==
X-Google-Smtp-Source: APXvYqy5Q5+B5BMufukdEEoIyYPrLQrNbsfe/dPwb1SA0uhjqSnlRqf+vJhXaAlvAxrnPhRzTAkD9lGZP4q5E8YmncY=
X-Received: by 2002:a92:cc:: with SMTP id 195mr15231648ila.212.1576556643477;
 Mon, 16 Dec 2019 20:24:03 -0800 (PST)
MIME-Version: 1.0
References: <20191128155940.17530-1-mszeredi@redhat.com> <20191128155940.17530-13-mszeredi@redhat.com>
 <20191217033721.GS4203@ZenIV.linux.org.uk> <CAJfpegtnyjm_qbfMo0neAvqdMymTPHxT2NZX70XnK_rD5xtKYw@mail.gmail.com>
 <CAJfpegt=QugsQWW7NXGiOpYVSjMVfZRLhJLyq8KTsE47H_tRZg@mail.gmail.com> <20191217041945.GW4203@ZenIV.linux.org.uk>
In-Reply-To: <20191217041945.GW4203@ZenIV.linux.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 17 Dec 2019 05:23:52 +0100
Message-ID: <CAJfpegtnYdR39N-iZ5DCnwOEjkpJZ058NDT8iNQNUvDFSO6WOA@mail.gmail.com>
Subject: Re: [PATCH 12/12] vfs: don't parse "silent" option
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 17, 2019 at 5:19 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Tue, Dec 17, 2019 at 05:16:58AM +0100, Miklos Szeredi wrote:
> > On Tue, Dec 17, 2019 at 5:12 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
> > >
> > > On Tue, Dec 17, 2019 at 4:37 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
> > > >
> > > > On Thu, Nov 28, 2019 at 04:59:40PM +0100, Miklos Szeredi wrote:
> > > > > While this is a standard option as documented in mount(8), it is ignored by
> > > > > most filesystems.  So reject, unless filesystem explicitly wants to handle
> > > > > it.
> > > > >
> > > > > The exception is unconverted filesystems, where it is unknown if the
> > > > > filesystem handles this or not.
> > > > >
> > > > > Any implementation, such as mount(8), that needs to parse this option
> > > > > without failing can simply ignore the return value from fsconfig().
> > > >
> > > > Unless I'm missing something, that will mean that having it in /etc/fstab
> > > > for a converted filesystem (xfs, for example) will fail when booting
> > > > new kernel with existing /sbin/mount.  Doesn't sound like a good idea...
> > >
> > > Nope, the mount(2) case is not changed (see second hunk).
> >
> > Wrong, this has nothing to do with mount(2).  The second hunk is about
> > unconverted filesystems...
> >
> > When a filesystem that really needs to handle "silent" is converted,
> > it can handle that option itself.
>
> You know, I had a specific reason to mention XFS...

Will fix.  My bad, I did check filesystems at the time of writing the
patch, but not when resending...

Thanks,
Miklos
