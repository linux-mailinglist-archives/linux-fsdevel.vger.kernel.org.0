Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 213A13EB216
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Aug 2021 09:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239652AbhHMH7e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Aug 2021 03:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235010AbhHMH7d (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Aug 2021 03:59:33 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC19C061756;
        Fri, 13 Aug 2021 00:59:07 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id e186so12058307iof.12;
        Fri, 13 Aug 2021 00:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tJrR0ZX02YDONCaPjcXUreICi6RLxVYaDTPdoTGcCio=;
        b=ZMhalzYAClKwsMhDbIBOJwcopX7h5mBfWT1XaAwcVEAYn1CgoHQsB/oRfMHc7UGRRs
         MIGoK2j1Si0OqJ6Y8xcfrXcirhPXMIBa7OHD6MqokfOr1EhHUNPc+OpjSFDu3FfMNR7c
         JSyL+HUzV+QpL6XNaD0Fx3XzTEl8uIN5YJo6/HwCjlqWz63PIm6pGYtSTrxUQQcdmqhI
         JWXQSgB3hOiYg9uL1nsc++i3dXcX8U0xR6p1b+ZHuFqnCNDK1D0UwH5pNGzTIX7+W9PA
         CQh+cujfWJqxgYyOLDDgZD0SY9LP6fkOl8b0koUAonZRVg9QtQdvEYMpJ568s5ujEPoc
         DzRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tJrR0ZX02YDONCaPjcXUreICi6RLxVYaDTPdoTGcCio=;
        b=A5JPkh1rXKIYchXKpYsyE6HAk2PkJAn/1B5LOhBzwAa5LvZLA9iGrAS3A0ztsZjQvO
         HnDzINFOe8uhB1pkd3gx/lGqa30pJtZmMFUrCI6wLgVu8pgUt8Oc77zcjzHkvaoKNce2
         9X3O6tWiOpuMB+K/DC9qMxnJPDRGltg0n6Zk3S0yA+PpXcNmfyDByvOXdof23rHpU0ir
         HHp37Twx50CYTdISOjKvA6cakzTNu//mztabGocLlUag6QH9gvtWc26d/YgbrkKHplOT
         2maOQawa5ocZykBn6eXF7elp6Whoj8rWMWmN5fWihh8ltNgyTKHLftVwtW/x0X1uKEol
         bNOQ==
X-Gm-Message-State: AOAM531ZgitSnR3i6jVDqix785RXd6szMp+1B8AZkvnQGLsY7LpzMwk5
        KkUci1f0+1Kv96UUImPM0N7q3MwQN74R8pdON3c=
X-Google-Smtp-Source: ABdhPJxJfUcIIYWqqYQ2E/x79fSfARdbOedADmz/JDeFZB8iyjqpjlQXGzP1l+a5XoRrgxbMqiRtIk1ihfn43GWu4yc=
X-Received: by 2002:a6b:7f48:: with SMTP id m8mr1082862ioq.5.1628841547138;
 Fri, 13 Aug 2021 00:59:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210812214010.3197279-1-krisman@collabora.com> <20210812214010.3197279-10-krisman@collabora.com>
In-Reply-To: <20210812214010.3197279-10-krisman@collabora.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 13 Aug 2021 10:58:56 +0300
Message-ID: <CAOQ4uxi7otGo6aNNMk9-fVQCx4Q0tDFe7sJaCr6jj1tNtfExTg@mail.gmail.com>
Subject: Re: [PATCH v6 09/21] fsnotify: Allow events reported with an empty inode
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Jan Kara <jack@suse.com>, Linux API <linux-api@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Khazhismel Kumykov <khazhy@google.com>,
        David Howells <dhowells@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        Theodore Tso <tytso@mit.edu>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Matthew Bobrowski <repnop@google.com>, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 13, 2021 at 12:41 AM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> Some file system events (i.e. FS_ERROR) might not be associated with an
> inode.  For these, it makes sense to associate them directly with the
> super block of the file system they apply to.  This patch allows the
> event to be reported with a NULL inode, by recovering the superblock
> directly from the data field, if needed.
>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
>
> --
> Changes since v5:
>   - add fsnotify_data_sb handle to retrieve sb from the data field. (jan)
> ---
>  fs/notify/fsnotify.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
> index 30d422b8c0fc..536db02cb26e 100644
> --- a/fs/notify/fsnotify.c
> +++ b/fs/notify/fsnotify.c
> @@ -98,6 +98,14 @@ void fsnotify_sb_delete(struct super_block *sb)
>         fsnotify_clear_marks_by_sb(sb);
>  }
>
> +static struct super_block *fsnotify_data_sb(const void *data, int data_type)
> +{
> +       struct inode *inode = fsnotify_data_inode(data, data_type);
> +       struct super_block *sb = inode ? inode->i_sb : NULL;
> +
> +       return sb;
> +}
> +
>  /*
>   * Given an inode, first check if we care what happens to our children.  Inotify
>   * and dnotify both tell their parents about events.  If we care about any event
> @@ -455,8 +463,10 @@ static void fsnotify_iter_next(struct fsnotify_iter_info *iter_info)
>   *             @file_name is relative to
>   * @file_name: optional file name associated with event
>   * @inode:     optional inode associated with event -
> - *             either @dir or @inode must be non-NULL.
> - *             if both are non-NULL event may be reported to both.
> + *             If @dir and @inode are NULL, @data must have a type that
> + *             allows retrieving the file system associated with this

Irrelevant comment. sb must always be available from @data.

> + *             event.  if both are non-NULL event may be reported to
> + *             both.
>   * @cookie:    inotify rename cookie
>   */
>  int fsnotify(__u32 mask, const void *data, int data_type, struct inode *dir,
> @@ -483,7 +493,7 @@ int fsnotify(__u32 mask, const void *data, int data_type, struct inode *dir,
>                  */
>                 parent = dir;
>         }
> -       sb = inode->i_sb;
> +       sb = inode ? inode->i_sb : fsnotify_data_sb(data, data_type);

        const struct path *path = fsnotify_data_path(data, data_type);
+       const struct super_block *sb = fsnotify_data_sb(data, data_type);

All the games with @data @inode and @dir args are irrelevant to this.
sb should always be available from @data and it does not matter
if fsnotify_data_inode() is the same as @inode, @dir or neither.
All those inodes are anyway on the same sb.

Thanks,
Amir.
