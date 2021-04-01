Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4862D350D2C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Apr 2021 05:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233565AbhDADcW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Mar 2021 23:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233015AbhDADcP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Mar 2021 23:32:15 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B1F8C0613E6;
        Wed, 31 Mar 2021 20:32:15 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id n198so841326iod.0;
        Wed, 31 Mar 2021 20:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p6SGEiBrOYUBlIz6omEKVX2rtKN0BjeDSFjoke/LKSk=;
        b=mWpJsxSBKTvETLyixX+prhZ1ogZ4ZdKRnxErem470keY5Bc9ls4m5VFAbFH6CbzbYb
         vT86xigJgNxEk4FQi+O41DWBkWGE+6u5sKIxaf148ICimxw311I0EEvu1+73NI21QZbk
         KzCnm+oYZML89lDA/5NKfUKZxV9ssTl2mpTeD7vfIIo0dgHgpeas6nOvZEgTzHz9F43v
         X6/Pmw4J4a6mvGOK9CE3dgS27MCbkDI5WgDxloZ9KSGF5QRCS+oLB9GNRMqoWe+PnnBJ
         hYcFe8qAyhmLqaI1k9FsKEPAClVKGPpYlYjPwWe5LTd4SKKYPJJCWCYZDcNQNgD31eVI
         HjHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p6SGEiBrOYUBlIz6omEKVX2rtKN0BjeDSFjoke/LKSk=;
        b=Uv+P3aOfq5p73X7BeNyGY897FnkwOhzfhS/lH0gqPwHmKm1fYmmMmpXNxQ3rhmEdwd
         zvx7oVodxZidCZxc+dU0zz+zHF3f+HvpEaPzj/kdSttnmZPWgizXfYmTq+dowXcN8ZIb
         kXNKIoPyPc75OlkpC8pHbTxxONMEPW2QzZbIz/qjeLjAIYubdqxikl1sLLGjMtnQD5Ps
         VWCKlx3yczdsGUZ8FQB/B0kEo90QuX9EcOFPVUA68Rk1/MWEaUin18Q0hkAHqflHdW2c
         nRlZcDsgwYxfdMRwNz6TVXw7qkVmgsxkgr1weipMHfrOjYGHtk7Q0oZkupE8HZ8Myrf2
         UB8w==
X-Gm-Message-State: AOAM532fhkXi3BsoJdAE9zMhhBYJjwHQMvuuZPOjDx89BzZY+uYa3Ygr
        1C1EZBYI5jLgt943/2udBWTjBJCUXz+zwIutL+E=
X-Google-Smtp-Source: ABdhPJwMpCW3LPDAoXrTCpoBVutBRbhsxusNji2D2oQpuitB+e0xB7lTIVhQjd8cGtnsSd+TVxI5ILBwBu5N/Ucsqek=
X-Received: by 2002:a5e:8d01:: with SMTP id m1mr4744700ioj.72.1617247934579;
 Wed, 31 Mar 2021 20:32:14 -0700 (PDT)
MIME-Version: 1.0
References: <161723932606.3149451.12366114306150243052.stgit@magnolia> <161723933214.3149451.12102627412985512284.stgit@magnolia>
In-Reply-To: <161723933214.3149451.12102627412985512284.stgit@magnolia>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 1 Apr 2021 06:32:02 +0300
Message-ID: <CAOQ4uxgJVUXxJmzSfHRFTFfqrV+oGt8QV-E+_wq46DmS0QGZ_w@mail.gmail.com>
Subject: Re: [PATCH 01/18] vfs: introduce new file range exchange ioctl
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 1, 2021 at 4:13 AM Darrick J. Wong <djwong@kernel.org> wrote:
>
> From: Darrick J. Wong <djwong@kernel.org>
>
> Introduce a new ioctl to handle swapping ranges of bytes between files.
>
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---
>  Documentation/filesystems/vfs.rst |   16 ++
>  fs/ioctl.c                        |   42 +++++
>  fs/remap_range.c                  |  283 +++++++++++++++++++++++++++++++++++++
>  fs/xfs/libxfs/xfs_fs.h            |    1
>  include/linux/fs.h                |   14 ++
>  include/uapi/linux/fiexchange.h   |  101 +++++++++++++
>  6 files changed, 456 insertions(+), 1 deletion(-)
>  create mode 100644 include/uapi/linux/fiexchange.h
>
>
> diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
> index 2049bbf5e388..9f16b260bc7e 100644
> --- a/Documentation/filesystems/vfs.rst
> +++ b/Documentation/filesystems/vfs.rst
> @@ -1006,6 +1006,8 @@ This describes how the VFS can manipulate an open file.  As of kernel
>                 loff_t (*remap_file_range)(struct file *file_in, loff_t pos_in,
>                                            struct file *file_out, loff_t pos_out,
>                                            loff_t len, unsigned int remap_flags);
> +                int (*xchg_file_range)(struct file *file1, struct file *file2,
> +                                       struct file_xchg_range *fxr);

An obvious question: why is the xchgn_file_range op not using the
unified remap_file_range() method with REMAP_XCHG_ flags?
Surely replacing the remap_flags arg with struct file_remap_range.

I went to look for reasons and I didn't find them.
Can you share your reasons for that?

Thanks,
Amir.
