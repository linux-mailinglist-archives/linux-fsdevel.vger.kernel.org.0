Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DCE914EF94
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2020 16:30:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729136AbgAaPaA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Jan 2020 10:30:00 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:46642 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728958AbgAaP37 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Jan 2020 10:29:59 -0500
Received: by mail-io1-f67.google.com with SMTP id t26so8521547ioi.13;
        Fri, 31 Jan 2020 07:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=475ET+oVeejOUJkarGEX+7i746VW14N/qJbSVy2K/YA=;
        b=t97Ir3EiaPGGk4EA/CC/7jP5bReoKgv+/tNWZygeEeBzuwItC1C+/MAaMAyWQxG5Zy
         ktD1RsBIzuqBDvXbUQ47Cq/xfSJKILFLHyvp+0W8oJcOMOH1gxewiv/Rq1nVV93WyP3u
         n6BSvrnbBZbU0YM/xvuklNQwa/qWwgH6EZufemIBLGnJzraTJgwfJe8yqAw0qUKx3OS5
         D/AZ9oYVbWur1i3YFDONZ3avDGq114d034vtGXOILLWSrF3bo4qgBbl14Wnkm/tB91dL
         WgjqIG27ik731gv7pDBw74x5HrRB4DoP2wK3Pn4CxzH/r3kbLQhGj5BnW1LevQmosY1Q
         XUXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=475ET+oVeejOUJkarGEX+7i746VW14N/qJbSVy2K/YA=;
        b=aIEDC6NI4ICEYSD+n8o9GwLBSZj/x0Q/YdFuMSb6IalQZKr9qnjqJ/LwoVD2hmtXj1
         Ree+OSKoEZLkF9qPMqp/3ie2i7/6k0xxooN5OEH3piUTRoyNtY/P3tWvHZ62A9lJuQnB
         IsWxFPeAf8mxVo0UvXemMfjZp1qs2gSH4NEaTV7OaD2rUYMLjg+sKmIVQO/A12RvF/22
         DY+MXqDZMVswCn/OTIj9QeLk3BEGntLakSnQFxWT1gVLAsTB681MxPrmaW8fe91fCBoC
         zZcuiKnsB+8y9K+W5oOh7t0KhPKANS2UGqMkzjP309FPzq0pY/2W0z/XOicbtQzqxCL7
         Z1LA==
X-Gm-Message-State: APjAAAW7evZPpuNZIpwFWDga7/bcE7Zl7+qHbXEbiE1UxRrQlwW7Tlt/
        o/PT9fZLB2l6FJwJrPVmhKIDAdIp/2Q4O/8pKuc=
X-Google-Smtp-Source: APXvYqzQJWHuWIV/jttr0Lb3AHpDymctrpz5X6Jxh/gSzg09/5PgaDgeuBkDBtOpwyNIqtOQcmT/fyXNIP4zU/J8PO8=
X-Received: by 2002:a02:a48e:: with SMTP id d14mr8784782jam.30.1580484597910;
 Fri, 31 Jan 2020 07:29:57 -0800 (PST)
MIME-Version: 1.0
References: <20200131115004.17410-1-mszeredi@redhat.com> <20200131115004.17410-5-mszeredi@redhat.com>
In-Reply-To: <20200131115004.17410-5-mszeredi@redhat.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 31 Jan 2020 17:29:47 +0200
Message-ID: <CAOQ4uxgV9KbE9ROCi5=RmXe1moqnmwWqaZ98jDjLcpDuM70RGQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] ovl: alllow remote upper
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Vivek Goyal <vgoyal@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 31, 2020 at 1:51 PM Miklos Szeredi <mszeredi@redhat.com> wrote:
>
> No reason to prevent upper layer being a remote filesystem.  Do the
> revalidation in that case, just as we already do for lower layers.
>

No reason to prevent upper layer from being a remote filesystem, but
the !remote criteria for upper fs kept away a lot of filesystems from
upper. Those filesystems have never been tested as upper and many
of them are probably not fit for upper.

The goal is to lift the !remote limitation, not to allow for lots of new
types of upper fs's.

What can we do to minimize damages?

We can assert that is upper is remote, it must qualify for a more strict
criteria as upper fs, that is:
- support d_type
- support xattr
- support RENAME_EXCHANGE|RENAME_WHITEOUT

I have a patch on branch ovl-strict which implements those restrictions.

Now I know fuse doesn't support RENAME_WHITEOUT, but it does
support RENAME_EXCHANGE, which already proves to be a very narrow
filter for remote fs: afs, fuse, gfs2.
Did not check if afs, gfs2 qualify for the rest of the criteria.

Is it simple to implement RENAME_WHITEOUT for fuse/virtiofs?
Is it not a problem to rely on an upper fs for modern systems
that does not support RENAME_WHITEOUT?

Thanks,
Amir.
