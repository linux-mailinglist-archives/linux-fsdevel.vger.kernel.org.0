Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 871845A963
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Jun 2019 09:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbfF2HFD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 29 Jun 2019 03:05:03 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:39144 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbfF2HFD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 29 Jun 2019 03:05:03 -0400
Received: by mail-yb1-f193.google.com with SMTP id k4so6253324ybo.6;
        Sat, 29 Jun 2019 00:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xM/xcvkzohmQdtVDVPIgTFxuHjb4HOBVLFjrfhylohA=;
        b=Gfu5Pz78tLVKvI8Q9WtRwxoZiso9oqghADUZOQqtlF6a4PF4ZC24i4bhdxEFOWT9mb
         ogpxVnV34CUKT9Hp3X/zqMkMMajHb+ZB117iqrYsimXsLjh5l46Ev8rT8yc8cIX3yIvp
         pPvNValE4fvXkmuBjtLVOlUXgnPgouNfZrFrcwZJP2fDEoyBu6UDZfe0+vDH3DvWwhm2
         zDFMbFYJkqZlfRqwPcIjOiXLiRHvuGtOYey5wWMnlJCELzFsocHIwB5e56zebm7P/vZi
         S6f79kvT8PuUPJTo2r7gwPTQl2Z6a4vDBem6y6JYpyyoLzjF+dqkakkpoHJf+XnufEOL
         I8qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xM/xcvkzohmQdtVDVPIgTFxuHjb4HOBVLFjrfhylohA=;
        b=fGTYzuL+oud727aBlwsLu8xlR47mCfqDSocu+JWOhrYD2fHsRWOtTibjFpG8h+mVmc
         LtLngKxWk47XmZ/oa/3K+HkWSveSf/fb2Ma9xhmx+aVgZHISopq/ncJ/T6X9WzbpkcG3
         dH9EKfZuD+w+FsHAfxetAUTkotnokSJGFD9VpbPqMjWz/peR6pe32b9aXzVdIq+RRJ77
         /YUo0m+e1Fm396bGZKB6HUm7IUde/BxIrtlTkAWwftTDEFXzD2CUHwacQnoagOvALwfX
         NMz19469BVNfR+LGzqXfF6dNKepBthCmGhaLuPvbz4x78llROCFXnmc5D1YfkQQT1lZ+
         MMNg==
X-Gm-Message-State: APjAAAXwKeIIADgcELt2dsFQUJIT/iHki71NzdiXHp7+ZbW3+Bb2Buaz
        7+5dq0/1ux2psCOMQQ12p1t5yjmNHaA+WJvfpEc=
X-Google-Smtp-Source: APXvYqxU4FPLSq/gM1nVlP+fbK0BmSrMY2hESytnxCDMdjqY3j5BqEk3eirFdcbLmu5rTiIZzzGPOTH2wPbd9PuZuhY=
X-Received: by 2002:a25:8489:: with SMTP id v9mr8918225ybk.144.1561791901221;
 Sat, 29 Jun 2019 00:05:01 -0700 (PDT)
MIME-Version: 1.0
References: <156174687561.1557469.7505651950825460767.stgit@magnolia> <156174690758.1557469.9258105121276292687.stgit@magnolia>
In-Reply-To: <156174690758.1557469.9258105121276292687.stgit@magnolia>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 29 Jun 2019 10:04:50 +0300
Message-ID: <CAOQ4uxgG5Kijx=nzFRB0uFPMghJXDfCqxKEWQoePwKZTGO+NMg@mail.gmail.com>
Subject: Re: [PATCH 4/4] vfs: don't allow most setxattr to immutable files
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     matthew.garrett@nebula.com, Chao Yu <yuchao0@huawei.com>,
        Theodore Tso <tytso@mit.edu>, ard.biesheuvel@linaro.org,
        Josef Bacik <josef@toxicpanda.com>,
        Christoph Hellwig <hch@infradead.org>,
        Chris Mason <clm@fb.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.com>,
        David Sterba <dsterba@suse.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, jk@ozlabs.org,
        reiserfs-devel@vger.kernel.org, linux-efi@vger.kernel.org,
        devel@lists.orangefs.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, linux-nilfs@vger.kernel.org,
        linux-mtd@lists.infradead.org, ocfs2-devel@oss.oracle.com,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>,
        Linux Btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 28, 2019 at 9:37 PM Darrick J. Wong <darrick.wong@oracle.com> wrote:
>
> From: Darrick J. Wong <darrick.wong@oracle.com>
>
> The chattr manpage has this to say about immutable files:
>
> "A file with the 'i' attribute cannot be modified: it cannot be deleted
> or renamed, no link can be created to this file, most of the file's
> metadata can not be modified, and the file can not be opened in write
> mode."
>
> However, we don't actually check the immutable flag in the setattr code,
> which means that we can update inode flags and project ids and extent
> size hints on supposedly immutable files.  Therefore, reject setflags
> and fssetxattr calls on an immutable file if the file is immutable and
> will remain that way.
>
> Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
> ---
>  fs/inode.c |   27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>
>
> diff --git a/fs/inode.c b/fs/inode.c
> index cf07378e5731..4261c709e50e 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -2214,6 +2214,14 @@ int vfs_ioc_setflags_prepare(struct inode *inode, unsigned int oldflags,
>             !capable(CAP_LINUX_IMMUTABLE))
>                 return -EPERM;
>
> +       /*
> +        * We aren't allowed to change any other flags if the immutable flag is
> +        * already set and is not being unset.
> +        */
> +       if ((oldflags & FS_IMMUTABLE_FL) && (flags & FS_IMMUTABLE_FL) &&
> +           oldflags != flags)
> +               return -EPERM;
> +
>         /*
>          * Now that we're done checking the new flags, flush all pending IO and
>          * dirty mappings before setting S_IMMUTABLE on an inode via
> @@ -2284,6 +2292,25 @@ int vfs_ioc_fssetxattr_check(struct inode *inode, const struct fsxattr *old_fa,
>             !(S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode)))
>                 return -EINVAL;
>
> +       /*
> +        * We aren't allowed to change any fields if the immutable flag is
> +        * already set and is not being unset.
> +        */
> +       if ((old_fa->fsx_xflags & FS_XFLAG_IMMUTABLE) &&
> +           (fa->fsx_xflags & FS_XFLAG_IMMUTABLE)) {
> +               if (old_fa->fsx_xflags != fa->fsx_xflags)
> +                       return -EPERM;
> +               if (old_fa->fsx_projid != fa->fsx_projid)
> +                       return -EPERM;
> +               if ((fa->fsx_xflags & (FS_XFLAG_EXTSIZE |
> +                                      FS_XFLAG_EXTSZINHERIT)) &&
> +                   old_fa->fsx_extsize != fa->fsx_extsize)
> +                       return -EPERM;
> +               if ((old_fa->fsx_xflags & FS_XFLAG_COWEXTSIZE) &&
> +                   old_fa->fsx_cowextsize != fa->fsx_cowextsize)
> +                       return -EPERM;
> +       }
> +

I would like to reject this for the sheer effort on my eyes, but
I'll try harder to rationalize.

How about memcmp(fa, old_fa, offsetof(struct fsxattr, fsx_pad))?

Would be more robust to future struct fsxattr changes and generally
more easy on the eyes.

Sure, there is the possibility of userspace passing uninitialized
fsx_extsize/fsx_cowextsize without setting the flag, but is that
a real concern for the very few tools that are used to chattr?
Those tools, when asked to set an attribute, will first get
struct fsxattr from fs, then change the requested attr and set the
fsxattr struct. So IMO the chances of this causing any regression
or unexpected behavior are ridiculously low.

Thanks,
Amir.
