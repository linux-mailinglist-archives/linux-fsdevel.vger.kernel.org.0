Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26BEF38C3B2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 May 2021 11:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbhEUJqF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 May 2021 05:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbhEUJqE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 May 2021 05:46:04 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD65BC061574;
        Fri, 21 May 2021 02:44:40 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id z24so19526453ioi.3;
        Fri, 21 May 2021 02:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=buVeB8WnFW23aOCded2ctcfxRFpFitusLk1LSIom5Wc=;
        b=H4t/wza1JohzT+GyvbVlQW/F8/7ZgpenD/ltDTmZOq/iWk6DWhqlEzDtj/kba/QHES
         6DMsBv6ajB8dQbMLf1w2qH+RQas6yEFin9tGJivo13lNQPuWy5N5Dq5BZGCBeold+5zY
         1hYois3SWQGg3uBNrjIWLCiopvyaTjzLtwRPFxt1CBs+ZgFyoNAFzvWrFlhfmeC9fnXH
         H7fJNnP37orU4o3wkkQGDhEeY0yIzb2Bf7C65NXubCgp69ChiEgRktkt0wTabaMUMwZU
         UArovEWH5o63Tib6csCsZrtT52DWw1/R3RQs8ChJJLQ0QrdGOVAdwdBdAp5/gwERNXOw
         D4Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=buVeB8WnFW23aOCded2ctcfxRFpFitusLk1LSIom5Wc=;
        b=fAd8U4AUo5ZcF1z5ZiEdo9EPxuofis7L+H8EgI7EZJd0P9YTxnjSQ9aK4f0S4ctuv2
         isaKHrE8wI09WTCq+yWkZdqOhB9+6UE4XJfAaz0aEo5hwYLabDdwJKXRpzOxr7PWapJo
         A6Dtv82S4HNsSDDj5fQPcDmV473T6WFod2TJJMvtiya4X8noBnElLO47nbg8EuYPxMHv
         EZv/Oa6u4RvkoPTKpgKVxjRsmENUynwsshJwYGbSykA/65rlWrhetlk9QhkkMostAfej
         kO+NiVS/60Rl70BPNRFfE9DFCdPxsGKPa2cmMWo3yOrriRXDX1dFYTH0hJ9vvLu37eSN
         f0/Q==
X-Gm-Message-State: AOAM53268Q0KunDUvkZ7TaL++adAydpKJHhFMQ+xlG+Z6HoU/8QkzUJ7
        lgjQ8Hf2/bdXtRI/qeeG0gEns3FgVea6ujCt+i0=
X-Google-Smtp-Source: ABdhPJwE0nH9O/hZURX0Yy9y6OuQGShSniuB3VZdam0CslV7if6EpOW4NoBW7ivUmNDJ2Fa239bOWV5/ogeGvEVXVvQ=
X-Received: by 2002:a5d:814d:: with SMTP id f13mr10157873ioo.203.1621590280276;
 Fri, 21 May 2021 02:44:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210521024134.1032503-1-krisman@collabora.com> <20210521024134.1032503-10-krisman@collabora.com>
In-Reply-To: <20210521024134.1032503-10-krisman@collabora.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 21 May 2021 12:44:29 +0300
Message-ID: <CAOQ4uxj+J7bA-7MKvv30jPAOGqjX7fpcKxC3RudXmTG2y+vxXw@mail.gmail.com>
Subject: Re: [PATCH 09/11] ext4: Send notifications on error
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     kernel@collabora.com, "Darrick J . Wong" <djwong@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.com>,
        David Howells <dhowells@redhat.com>,
        Khazhismel Kumykov <khazhy@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 21, 2021 at 5:42 AM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> Send a FS_ERROR message via fsnotify to a userspace monitoring tool
> whenever a ext4 error condition is triggered.  This follows the existing
> error conditions in ext4, so it is hooked to the ext4_error* functions.
>
> It also follows the current dmesg reporting in the format.  The
> filesystem message is composed mostly by the string that would be
> otherwise printed in dmesg.
>
> A new ext4 specific record format is exposed in the uapi, such that a
> monitoring tool knows what to expect when listening errors of an ext4
> filesystem.
>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

Looks fine.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  fs/ext4/super.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 7dc94f3e18e6..a8c0ac2c3e4c 100644
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
> @@ -752,6 +753,8 @@ void __ext4_error(struct super_block *sb, const char *function,
>                        sb->s_id, function, line, current->comm, &vaf);
>                 va_end(args);
>         }
> +       fsnotify_error_event(sb, NULL, error);
> +
>         ext4_handle_error(sb, force_ro, error, 0, block, function, line);
>  }
>
> @@ -782,6 +785,8 @@ void __ext4_error_inode(struct inode *inode, const char *function,
>                                current->comm, &vaf);
>                 va_end(args);
>         }
> +       fsnotify_error_event(inode->i_sb, inode, error);
> +
>         ext4_handle_error(inode->i_sb, false, error, inode->i_ino, block,
>                           function, line);
>  }
> @@ -820,6 +825,8 @@ void __ext4_error_file(struct file *file, const char *function,
>                                current->comm, path, &vaf);
>                 va_end(args);
>         }
> +       fsnotify_error_event(inode->i_sb, inode, EFSCORRUPTED);
> +
>         ext4_handle_error(inode->i_sb, false, EFSCORRUPTED, inode->i_ino, block,
>                           function, line);
>  }
> @@ -887,6 +894,7 @@ void __ext4_std_error(struct super_block *sb, const char *function,
>                 printk(KERN_CRIT "EXT4-fs error (device %s) in %s:%d: %s\n",
>                        sb->s_id, function, line, errstr);
>         }
> +       fsnotify_error_event(sb, sb->s_root->d_inode, errno);
>
>         ext4_handle_error(sb, false, -errno, 0, 0, function, line);
>  }
> --
> 2.31.0
>
