Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7BEE31BF87
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Feb 2021 17:39:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbhBOQid (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Feb 2021 11:38:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231259AbhBOQfw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Feb 2021 11:35:52 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63925C061756;
        Mon, 15 Feb 2021 08:35:09 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id w1so5918984ilm.12;
        Mon, 15 Feb 2021 08:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p99Y0IizcDgJJyFvLWYBqAWdhmLE2nZ89U026tr0eGg=;
        b=EJw3TQMaTEgxG+xxenxwXWMqxKo4ZoBtUH2h4FwcOqRV6/QtYGQwBEBxvsJv15bnRc
         dvDPXT3Focve5ZfHuEATmhmZ2qzU8sbTrBJQ5IYViyNEfynKOwg9B7zfkwXWrocyYEKe
         SREkY7xE+EDu0qcbWsJOXZVuN7YujE+MZniihDK+rPTt0Sasao93PZ7/aUm4d6Het5tp
         Fh/EbSCks8NdGW17iC3KMWuCTrbtzrh7zTUnPC7IHGnSQ23voOYv10qLj4Dp8EeHfjX2
         yJh0qkO7VsWTk9dpgx/i4a8qr6th45vFOn4lkildCUxVzOO1yRu6xCElWYoMYXSmWLGv
         cjPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p99Y0IizcDgJJyFvLWYBqAWdhmLE2nZ89U026tr0eGg=;
        b=QoL0AZSuEoen1k5PgAHVTv2sIFB4/ca/NYFVvQ/ne8kAWkQtvSZIxM4aF9a+GW4ubB
         QtLwaFMdpLslfB0XMTriEHO5FsO4bXC+gIJNAuORlEde+jrWIR+GcUavXkp8J090D/k1
         0Z5GzG1z0ah4uQPmTFNsT7XuCx+HdDjHgsspWTTi1ewPuDv7vveQTxgv5hW7A9wzWaJ3
         N4EYzD/A3F+T6IcP55oDAFe759P72VGuseMvNztTXx6zP8GdZhrcunRL+jfRUzTOpnCn
         35d8uv/Czf7hKy0LvD+MZUARhpLHFFuYL2VYSCwiVAxEQnGAnLAsFksFSKIpGCXqggui
         Ppkw==
X-Gm-Message-State: AOAM5314nj75Aa8qTD0OgA572l/MLe6o4tWLw41R+RYlc7pYsMNlAqpm
        l+B2nEzf3M0+0O6um1f3r+ydZ+hXfTXEbwu688w=
X-Google-Smtp-Source: ABdhPJyDVoBlsuUNOqBP2XuJTLEKAVsYIxRaxuGbff6zyiXoZeKYAHbxipf2o1BapB3mllRe50630ce+ABVmF0oL0Gk=
X-Received: by 2002:a92:2c08:: with SMTP id t8mr13060037ile.72.1613406908904;
 Mon, 15 Feb 2021 08:35:08 -0800 (PST)
MIME-Version: 1.0
References: <CAOQ4uxiFGjdvX2-zh5o46pn7RZhvbGHH0wpzLPuPOom91FwWeQ@mail.gmail.com>
 <20210215154317.8590-1-lhenriques@suse.de>
In-Reply-To: <20210215154317.8590-1-lhenriques@suse.de>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 15 Feb 2021 18:34:57 +0200
Message-ID: <CAOQ4uxgjcCrzDkj-0ukhvHRgQ-D+A3zU5EAe0A=s1Gw2dnTJSA@mail.gmail.com>
Subject: Re: [PATCH v2] vfs: prevent copy_file_range to copy across devices
To:     Luis Henriques <lhenriques@suse.de>
Cc:     Jeff Layton <jlayton@kernel.org>, Steve French <sfrench@samba.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dave Chinner <dchinner@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Ian Lance Taylor <iant@google.com>,
        Luis Lozano <llozano@chromium.org>,
        ceph-devel <ceph-devel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 15, 2021 at 5:42 PM Luis Henriques <lhenriques@suse.de> wrote:
>
> Nicolas Boichat reported an issue when trying to use the copy_file_range
> syscall on a tracefs file.  It failed silently because the file content is
> generated on-the-fly (reporting a size of zero) and copy_file_range needs
> to know in advance how much data is present.
>
> This commit restores the cross-fs restrictions that existed prior to
> 5dae222a5ff0 ("vfs: allow copy_file_range to copy across devices") and
> removes generic_copy_file_range() calls from ceph, cifs, fuse, and nfs.
>
> Fixes: 5dae222a5ff0 ("vfs: allow copy_file_range to copy across devices")
> Link: https://lore.kernel.org/linux-fsdevel/20210212044405.4120619-1-drinkcat@chromium.org/
> Cc: Nicolas Boichat <drinkcat@chromium.org>
> Signed-off-by: Luis Henriques <lhenriques@suse.de>

Code looks ok.
You may add:

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

I agree with Trond that the first paragraph of the commit message could
be improved.
The purpose of this change is to fix the change of behavior that
caused the regression.

Before v5.3, behavior was -EXDEV and userspace could fallback to read.
After v5.3, behavior is zero size copy.

It does not matter so much what makes sense for CFR to do in this
case (generic cross-fs copy).  What matters is that nobody asked for
this change and that it caused problems.

Thanks,
Amir.
