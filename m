Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5543A9669
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jun 2021 11:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbhFPJk4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Jun 2021 05:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231491AbhFPJk4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Jun 2021 05:40:56 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6132EC061574;
        Wed, 16 Jun 2021 02:38:49 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id s26so2308458ioe.9;
        Wed, 16 Jun 2021 02:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2/MvKY4Cc8ZvNy+Agqhh0BnZkqflTNCcNSEyPszszWE=;
        b=BCxLH9VjmgtjKc9Vp38RV3uJWTkhfVk9L2cN0xGy3I6OnvNbdC18ZPDp7mIb9LDnqG
         rqG3L30hKMGkLFsgz1ohSkD1GdOnTD39CfqYIEFITXc+7fydUFXw+cRR3eCFsQTMN6lr
         65qAHMy6EWY5LmaZ9W2Rfbwh5MOwEFW3Y9ZCO8WqqD04RwdC3TtfJJz9EyetqzGHRS6t
         raL0hZGHTVeE4XUelrG2Trp6XONROtpUQeRMngULXJtpA5FBVNGbZc0hXufWPItapiDk
         2b0/iFxQljwKmJBVws+7R5rBNecAnR4n9wNrYz5bSggL/tpCNyKE7VLLqkahDENqtG++
         U8Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2/MvKY4Cc8ZvNy+Agqhh0BnZkqflTNCcNSEyPszszWE=;
        b=lgBz+ShUUrSLOONxuVSJtCOs17GM+ZQOmUVJ8587Yvbn2GqJVMXA+yEqcsSfPQwugw
         5YRYqcl55aoYlyg1osbJ8ulv3ZDFLeBJfl4nqEBWtoTe4D2xFrxWUE+05B2BIeFic0Rp
         OXQZBcWvfB6Y5lzadgOpXScmSoSOLfo1tbikvsBUCJ8opNw1h7eNwaQ+2rkRs2mFf0vU
         mjjyQlS+8jXLxCPwa8eIs0y1ogBXIIw2U/oL1tGSoY69sBbKZKN+axOMv4o3beqwhygh
         nyiWT8hI6T9gq4IKr5xj5UpXYKMx/PrrG3Dwjw17Nw6uuIFWa6FvvbC7mBKWwk5Ji4L9
         mZbg==
X-Gm-Message-State: AOAM531MZw5k48R91pCrFSrLXLSMrNZwUClClc2TgsoawoOxpUsiyEtM
        w3yAxkiX0Ia6FIHD2PuOgvy0oMzXCXfljv4q7pc=
X-Google-Smtp-Source: ABdhPJycEXv3DexAYGjm/B4EuogiJJk7dUEA52DCI6ai2NnexGrddRUZgRoaZlaDzKRBeb5JR9kFZPZqrDdyFG1WjfA=
X-Received: by 2002:a05:6602:2d83:: with SMTP id k3mr3009500iow.5.1623836328913;
 Wed, 16 Jun 2021 02:38:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210615235556.970928-1-krisman@collabora.com> <20210615235556.970928-11-krisman@collabora.com>
In-Reply-To: <20210615235556.970928-11-krisman@collabora.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 16 Jun 2021 12:38:38 +0300
Message-ID: <CAOQ4uxj0K_q5Oaaou73Saan4cuF8jqBu1XmRYGYc+mCKs_Ewkg@mail.gmail.com>
Subject: Re: [PATCH v2 10/14] fsnotify: Introduce helpers to send error_events
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     kernel@collabora.com, "Darrick J. Wong" <djwong@kernel.org>,
        Theodore Tso <tytso@mit.edu>,
        Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.com>,
        David Howells <dhowells@redhat.com>,
        Khazhismel Kumykov <khazhy@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 16, 2021 at 2:56 AM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> Introduce helpers for filesystems interested in reporting FS_ERROR
> events.
>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
>
> ---
> Changes since v1:
>   - Use the inode argument (Amir)
>   - Protect s_fsnotify_marks with ifdef guard
> ---
>  fs/notify/fsnotify.c             |  2 +-
>  include/linux/fsnotify.h         | 20 ++++++++++++++++++++
>  include/linux/fsnotify_backend.h |  1 +
>  3 files changed, 22 insertions(+), 1 deletion(-)
>
> diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
> index 36205a769dde..ac05eb3fb368 100644
> --- a/fs/notify/fsnotify.c
> +++ b/fs/notify/fsnotify.c
> @@ -491,7 +491,7 @@ int __fsnotify(__u32 mask, const struct fsnotify_event_info *event_info)
>                  */
>                 parent = event_info->dir;
>         }
> -       sb = inode->i_sb;
> +       sb = event_info->sb ?: inode->i_sb;
>
>         /*
>          * Optimization: srcu_read_lock() has a memory barrier which can
> diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
> index 8c2c681b4495..c0dbc5a65381 100644
> --- a/include/linux/fsnotify.h
> +++ b/include/linux/fsnotify.h
> @@ -326,4 +326,24 @@ static inline void fsnotify_change(struct dentry *dentry, unsigned int ia_valid)
>                 fsnotify_dentry(dentry, mask);
>  }
>
> +static inline int fsnotify_sb_error(struct super_block *sb, struct inode *inode,
> +                                       int error)
> +{
> +#ifdef CONFIG_FSNOTIFY
> +       if (sb->s_fsnotify_marks) {

__fsnotify() has this optimization very early
so you do not need it here and you do not need the ifdef.
performance of fsnotify_sb_error() is utterly not important.

> +               struct fs_error_report report = {
> +                       .error = error,
> +                       .inode = inode,
> +               };
> +
> +               return __fsnotify(FS_ERROR, &(struct fsnotify_event_info) {
> +                               .data = &report,
> +                               .data_type = FSNOTIFY_EVENT_ERROR,
> +                               .inode = NULL, .cookie = 0, .sb = sb

No need to set members to 0/NULL with this type of initializer.

Thanks,
Amir.
