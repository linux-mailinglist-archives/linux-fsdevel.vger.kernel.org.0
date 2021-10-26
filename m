Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD1C43AC9A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Oct 2021 09:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbhJZHIY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Oct 2021 03:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbhJZHIX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Oct 2021 03:08:23 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41BC2C061745;
        Tue, 26 Oct 2021 00:06:00 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id v65so7265923ioe.5;
        Tue, 26 Oct 2021 00:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J6ya56Qt8Frw/lGfkXq3MuIPZzFJiXTaiX1cCAIXijQ=;
        b=CTFHJKoM0Wp+8eKK7/GFuMJSAcksP6Wtpn2J2AwYFbn529gKkA+YNLG3WZ/CeU9Ml8
         RSrFhpaz+QhW3Y+2SfW+jSSTxAbB2dK8DJ9qWuAx7wM4cRcY7ObZG59OfbBlRBjdh96q
         OOvld9O5ZpAAKopUxibhiAouDndggLM7vHRhtid4MRHLJ+jkoqtGkUXvzzAXwIhlauMx
         +MuW03Vkj1YtpCLBsIK4cJrtEy/mKjuknvmSPl0Gr1V2pYTAeB+PaLZ7FiUhl0PtyaN9
         Qg1b+DbumDVccVNyfkDl0gHQtMAPBiVaIb3n98roa/M7MusE+gJTWreFkKhlelu+PPQ5
         HjIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J6ya56Qt8Frw/lGfkXq3MuIPZzFJiXTaiX1cCAIXijQ=;
        b=n3bSHiK5eifcaEVf01rak5paTZwrelndNCp3Mf83OwiMujKYiJC9eYFPtwJSSldgpr
         LJM9ZvMj/0Em6Q6tFYyRdmYCiZ9rY63rBxkqzicOplCPVzGvbQnz/JWNYMOI2Gi8XZXS
         cElpbL/ZRQohENA8S2f0KnCfBLxG5PGjDyeENtmTbVfUzgZj1Gy7ybZTCszDpZxB+tqZ
         RG2hrCGL3ws9PA9ls3l7/nFpI1G4Es4RiS3l0BKfOUllJ5C5DSw7vHWfnD1jcpP25W1X
         ilXp4ZUrrqqKuFyworER0dBSlyNUa3Ras2A8j1Hvg9NNIno+i6kztnOfV+2MdIlBkiIn
         EkIw==
X-Gm-Message-State: AOAM531MgWJsO8h9sB5lw5l70Eq2wyVRQGFnLTUybU/ITUYvpwVquWkG
        OvzsfDZM2hrTDB1eJVD1AThBTutzf8K/0ZVpEao=
X-Google-Smtp-Source: ABdhPJxKy1OkXYWwh38nixaMiF+75w1YWDKY1ocQKp92xK9np/sVDL/sHSJyj98FKPazASbA4VfKjk+0zxFLtBIFxyY=
X-Received: by 2002:a5e:c018:: with SMTP id u24mr13884841iol.197.1635231959682;
 Tue, 26 Oct 2021 00:05:59 -0700 (PDT)
MIME-Version: 1.0
References: <20211025192746.66445-1-krisman@collabora.com> <20211025192746.66445-30-krisman@collabora.com>
In-Reply-To: <20211025192746.66445-30-krisman@collabora.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 26 Oct 2021 10:05:48 +0300
Message-ID: <CAOQ4uxjAFPVH9Oft52OP2EfN41x=9k8HLdE5ebc91bdCZAaY3w@mail.gmail.com>
Subject: Re: [PATCH v9 29/31] ext4: Send notifications on error
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Jan Kara <jack@suse.com>, "Darrick J. Wong" <djwong@kernel.org>,
        Theodore Tso <tytso@mit.edu>,
        Dave Chinner <david@fromorbit.com>,
        David Howells <dhowells@redhat.com>,
        Khazhismel Kumykov <khazhy@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 25, 2021 at 10:31 PM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> Send a FS_ERROR message via fsnotify to a userspace monitoring tool
> whenever a ext4 error condition is triggered.  This follows the existing
> error conditions in ext4, so it is hooked to the ext4_error* functions.
>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
> Changes since v8:
>   - Report always report non-zero errno (Jan, Amir, Ted)
> Changes since v6:
>   - Report ext4_std_errors agains superblock (jan)
> ---
>  fs/ext4/super.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 88d5d274a868..1a766c68a55e 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -46,6 +46,7 @@
>  #include <linux/part_stat.h>
>  #include <linux/kthread.h>
>  #include <linux/freezer.h>
> +#include <linux/fsnotify.h>
>
>  #include "ext4.h"
>  #include "ext4_extents.h"      /* Needed for trace points definition */
> @@ -759,6 +760,8 @@ void __ext4_error(struct super_block *sb, const char *function,
>                        sb->s_id, function, line, current->comm, &vaf);
>                 va_end(args);
>         }
> +       fsnotify_sb_error(sb, NULL, error ? error : EFSCORRUPTED);
> +
>         ext4_handle_error(sb, force_ro, error, 0, block, function, line);
>  }
>
> @@ -789,6 +792,8 @@ void __ext4_error_inode(struct inode *inode, const char *function,
>                                current->comm, &vaf);
>                 va_end(args);
>         }
> +       fsnotify_sb_error(inode->i_sb, inode, error ? error : EFSCORRUPTED);
> +
>         ext4_handle_error(inode->i_sb, false, error, inode->i_ino, block,
>                           function, line);
>  }
> @@ -827,6 +832,8 @@ void __ext4_error_file(struct file *file, const char *function,
>                                current->comm, path, &vaf);
>                 va_end(args);
>         }
> +       fsnotify_sb_error(inode->i_sb, inode, EFSCORRUPTED);
> +
>         ext4_handle_error(inode->i_sb, false, EFSCORRUPTED, inode->i_ino, block,
>                           function, line);
>  }
> @@ -894,6 +901,7 @@ void __ext4_std_error(struct super_block *sb, const char *function,
>                 printk(KERN_CRIT "EXT4-fs error (device %s) in %s:%d: %s\n",
>                        sb->s_id, function, line, errstr);
>         }
> +       fsnotify_sb_error(sb, NULL, errno ? errno : EFSCORRUPTED);
>
>         ext4_handle_error(sb, false, -errno, 0, 0, function, line);
>  }
> --
> 2.33.0
>
