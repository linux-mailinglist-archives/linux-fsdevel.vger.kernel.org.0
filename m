Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88D3A3BD9E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jun 2019 22:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389728AbfFJUjy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jun 2019 16:39:54 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35594 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389331AbfFJUjy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jun 2019 16:39:54 -0400
Received: by mail-pg1-f194.google.com with SMTP id s27so5644488pgl.2;
        Mon, 10 Jun 2019 13:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p22jka5+YJm6qPKEtZtbCvfH4UahOct5JWkXMZAH0cw=;
        b=NhlNZfOGNT+ejmzCAz0X2gLGOPNXE1tFxrO+5Oj/L+OS5tuMH21fIGZKoaTbYtZX8H
         daUxxWC/BTvz/kX0XQ4pBxdJ0EFhImt0cW3c26wyyXOCkvzoBgAq/xPuWo52m/Q4tyUn
         TYSIhrTGu3PlLE6l2cUoMV3sfWg2E4NhGDP691EZBvDzrCGJLk/Bh9ocZzv+DbI/w3Ty
         47gWJIxQd8QMWFw4U4IkAzb0qEmz4nEXCQTUDfTCQPGak79+b7ZwhALqViyU4C7JBTog
         mRMoj433l7CaPSZ6g97SdcdNBfyPlZM1rOEkhHnHFSKLfqJhvYUtqz/0Rwz6v7mY1etM
         +gGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p22jka5+YJm6qPKEtZtbCvfH4UahOct5JWkXMZAH0cw=;
        b=Rs5I2Tq7NcvFJX5dOZ72XDyW/zRuyj3iRmWMKuDuxoBocuNNIN2a9K8erhN8yN4MaF
         lbYK88s9An1OjqBE0xRoqEPjxTfzFO/eN9GMoGZoQ3khUA42nYTvN/t48/XKG7Dzn7z+
         MEnFKc3ouNrUtlbu18c3ClQ5pnDtkw/inmKhkAn8mqI6912aaeXKQbBEzJozql2+6TEE
         d5J0fzIL9K5Vg76d32ktIIGXpAVprsfFUexmOgUqXq/yQRlW53DXMsHNxjicE49ee/Fk
         LOxEl+gGsaDhZpVZsjFBYyu8nK+jL12NZgylMHfKOw3PxpbxB4a1hTpJTCg917faIBKc
         ermw==
X-Gm-Message-State: APjAAAX8cYv0OwaAWuKUZyKYHlK45YhxoVD+UQSTUNYNHlDwzZkHqB8+
        WYEQqT3a7JS6+xHxx5hK4O0xNq3Z6V2pP3iX4X3Dxg==
X-Google-Smtp-Source: APXvYqyZhAA7zOt0YTe9pldYkl5YKoHrILFJnrdT5QuwZKl3z0twfCRhTTw/lergT/D0q15rr+nXHbuIOJhZze1DeOA=
X-Received: by 2002:a62:f20b:: with SMTP id m11mr23937722pfh.125.1560199193677;
 Mon, 10 Jun 2019 13:39:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190610173657.4655-1-amir73il@gmail.com>
In-Reply-To: <20190610173657.4655-1-amir73il@gmail.com>
From:   Steve French <smfrench@gmail.com>
Date:   Mon, 10 Jun 2019 15:39:42 -0500
Message-ID: <CAH2r5mtQObwvdtaNr31fd-wDpjrZi5YLZ+ZcaW0ECVvTR-ByXQ@mail.gmail.com>
Subject: Re: [PATCH] cifs: copy_file_range needs to strip setuid bits and
 update timestamps
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     "Darrick J . Wong" <darrick.wong@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good in my testing so far - but also want to do a little more
testing with the copy_file_range xfstest cases because your patches
fixed one additional test (not cross mount copy) so we can understand
why it fixed that test case.

On Mon, Jun 10, 2019 at 12:37 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> cifs has both source and destination inodes locked throughout the copy.
> Like ->write_iter(), we update mtime and strip setuid bits of destination
> file before copy and like ->read_iter(), we update atime of source file
> after copy.
>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>
> Hi Steve,
>
> Please apply this patch to you cifs branch after merging Darrick's
> copy-file-range-fixes branch from:
>         git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git
>
> Thanks,
> Amir.
>
>  fs/cifs/cifsfs.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
> index f11eea6125c1..83956452c108 100644
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


-- 
Thanks,

Steve
