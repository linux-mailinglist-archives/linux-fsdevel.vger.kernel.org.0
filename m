Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9B72E576
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2019 21:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbfE2Tg3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 May 2019 15:36:29 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:37792 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbfE2Tg3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 May 2019 15:36:29 -0400
Received: by mail-yb1-f193.google.com with SMTP id l66so1235631ybf.4;
        Wed, 29 May 2019 12:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7mEjgHYQ04qmca/Pwc7iF7uxZsyWUtmaIoM2mZ31LQc=;
        b=ZqWrslUQMdbel0zaoDjEn6UvUaq0aUP7KhexsRNdGhbCvxekatAwIPxf356JrUDnOx
         C09DY60ki0ngftPh+10L/hTshAMMNzEeRbZR+HR9lh7DDk3HTHAkIZdOKBkMQDFchkqC
         BSrqcVT3r8KKQ9pwKM0YVXOOU0nv55jbtupzPoHq7qHWUZ6IoTj2y0ca3+6XYBeElMT7
         03LMn0p0gKX1NG7mSOOfFb0wK616PofkM/rP++cD2mKAQ69vRbC8C1ovkzRcM3uWJlua
         dHj2GlH4/IxhE8ZSch32KCQIrgmeh0cRM3GjCL1souIZ1RnwBafeARtfAIi0MtidEXfX
         xSjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7mEjgHYQ04qmca/Pwc7iF7uxZsyWUtmaIoM2mZ31LQc=;
        b=bLqjKAPDQ+m+OeIe8aXUO6BdnIfRtqeP/Tl1eE1wg0oX6Kl1zsxUX1p0eiXjFDdOcR
         zvQBwnjT45hR10c1hKPxeX6KG8uc0K+XhT1hDCIg1ZBE2RLSY93p8ljAxh6/yeQYi12Z
         hs4V7xsbov84hG2XUthASsynA6Ghb6rjd8gOvAgp5WrxoToJsZ2aOkI9oC6dXC/lnyab
         L/K16enQvbeVgU2Ytgn30NxXSrWkEJLZEFI13+cwL5ZxUehBzC/ugF5ydjtKhXCZiY7z
         E/6GeFiKM/WSBBM6UFo9Lqy2UhmqP/0em1FyMW/Ch7hyXIcBtINx3NTnbFdBkcZie27F
         1HZQ==
X-Gm-Message-State: APjAAAWoJ5eqkodIfdP84n/IserMwvplEBdjUpdKZ6XSD3V2ewbp3qYU
        oCGI1nD2zQHkGE2p35Va1w4n1OqAnIHuiFvSCzISof9p7zQ=
X-Google-Smtp-Source: APXvYqxUzf10qrPKNmM4si1Ho/xA9MTy04IyA/D+jDEIvhwOY8vzXt+TC/oPfRRIYXfaYVxTBXtn7CAgMBqV6zkX3Qc=
X-Received: by 2002:a25:b202:: with SMTP id i2mr26730349ybj.439.1559158588100;
 Wed, 29 May 2019 12:36:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190529174318.22424-1-amir73il@gmail.com> <20190529174318.22424-11-amir73il@gmail.com>
In-Reply-To: <20190529174318.22424-11-amir73il@gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 29 May 2019 22:36:16 +0300
Message-ID: <CAOQ4uxiTtZTycTMdvcdJ5nR6YNOjRgQ51pKnXC6M-dO+eNMHRA@mail.gmail.com>
Subject: Re: [PATCH v3 10/13] cifs: copy_file_range needs to strip setuid bits
 and update timestamps
To:     Steve French <smfrench@gmail.com>
Cc:     Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        Luis Henriques <lhenriques@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-api@vger.kernel.org, ceph-devel@vger.kernel.org,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Steve,

Could we get an ACK on this patch.
It is a prerequisite for merging the cross-device copy_file_range work.

It depends on a new helper introduced here:
https://lore.kernel.org/linux-fsdevel/CAOQ4uxjbcSWX1hUcuXbn8hFH3QYB+5bAC9Z1yCwJdR=T-GGtCg@mail.gmail.com/T/#m1569878c41f39fac3aadb3832a30659c323b582a

Thanks,
Amir,

On Wed, May 29, 2019 at 8:43 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> cifs has both source and destination inodes locked throughout the copy.
> Like ->write_iter(), we update mtime and strip setuid bits of destination
> file before copy and like ->read_iter(), we update atime of source file
> after copy.
>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  fs/cifs/cifsfs.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
> index c65823270313..ab6c5c24146d 100644
> --- a/fs/cifs/cifsfs.c
> +++ b/fs/cifs/cifsfs.c
> @@ -1096,6 +1096,10 @@ ssize_t cifs_file_copychunk_range(unsigned int xid,
>                 goto out;
>         }
>
> +       rc = -EOPNOTSUPP;
> +       if (!target_tcon->ses->server->ops->copychunk_range)
> +               goto out;
> +
>         /*
>          * Note: cifs case is easier than btrfs since server responsible for
>          * checks for proper open modes and file type and if it wants
> @@ -1107,11 +1111,12 @@ ssize_t cifs_file_copychunk_range(unsigned int xid,
>         /* should we flush first and last page first */
>         truncate_inode_pages(&target_inode->i_data, 0);
>
> -       if (target_tcon->ses->server->ops->copychunk_range)
> +       rc = file_modified(dst_file);
> +       if (!rc)
>                 rc = target_tcon->ses->server->ops->copychunk_range(xid,
>                         smb_file_src, smb_file_target, off, len, destoff);
> -       else
> -               rc = -EOPNOTSUPP;
> +
> +       file_accessed(src_file);
>
>         /* force revalidate of size and timestamps of target file now
>          * that target is updated on the server
> --
> 2.17.1
>
