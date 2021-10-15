Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8929C42EC4B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Oct 2021 10:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234271AbhJOI36 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Oct 2021 04:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233917AbhJOI35 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Oct 2021 04:29:57 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6DAAC061570;
        Fri, 15 Oct 2021 01:27:51 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id y67so6799260iof.10;
        Fri, 15 Oct 2021 01:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rxNSXTTVVx91MGU9tuy1IjjSTZBxo7fsCL7MaJIlNhs=;
        b=XRI4+FgajPz9TPX4bUspKK89VhO5b7CRd6y2Y+GajoxkAyxU4la7pXKTdAlSQWLQfa
         yT6Cts6EkVN9LQY7BLAK7EvUym2xCoRZxKztJwzCTtJNyZ9Nlo+qzLDluxiIG9T83gIE
         Kw+AgZi4e6JxIH+0w5lQw+Krwczr978US5mfpb0rsDXbBIXxEAF9lIqCHYnzAMvU1N76
         b/y6lLwwjTPa3wublKTg/4AUd1z74bFcw5Ba2gW2JzBWx4jcWIlmuI4Y3Gnixl4IgIZ4
         o0ieLJ/dJ11zK3yZHYy+xviu2ucOMF4lcfJxdvTAciqPUL2kgSshuzlqmOydrDKl7GsD
         BUXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rxNSXTTVVx91MGU9tuy1IjjSTZBxo7fsCL7MaJIlNhs=;
        b=iZLJs6FQKrrtR+vZHISdw5FM/w4rYYlh6klhc8OnaM8YZMJZhiRIlrPYITfnqIwSy0
         YkTHBmmxmIyvQg86f979TrBJ+pKrIuRr+h91Gr9w9VVv0iQNxzMRB2nnMt0Z8goJECRq
         XfrbNCQ283f1t5vSbzI1dzbE8+zzdvJsp+gXKPVMaoMz0gBDn5hWOLEvX6UaKOxigJxe
         tnKaoK+JivNDzNeJ3mXco1dYkBucmms5iekELwZRvjgBr0Jn53trhoDHJSpDC1TA00Z+
         Ikonxpie+lvuxYujZ9fLl+Nkip2Mkqm+l/fgC5wg7Cqotyb1Jcjbd7p3Lj28dgLcFvo/
         2pPA==
X-Gm-Message-State: AOAM530Ow9TkhGO8vRQEMz6vUXFq+YkUXUkGOF0Gq+SYGQtIfHi4PWze
        YtrXkB0QNdiQJWgLkhiqAJHbtNcPCiQ1P84Dfps=
X-Google-Smtp-Source: ABdhPJwhvIwe4ipVkqkAD6x6BfIauqt9dJcKkP2SqLyQox1cC4ffci5RV4ZQO4sXeumM+tZxklKQryIYWXVSG1onuwU=
X-Received: by 2002:a02:1688:: with SMTP id a130mr7456902jaa.40.1634286471145;
 Fri, 15 Oct 2021 01:27:51 -0700 (PDT)
MIME-Version: 1.0
References: <20211014213646.1139469-1-krisman@collabora.com> <20211014213646.1139469-26-krisman@collabora.com>
In-Reply-To: <20211014213646.1139469-26-krisman@collabora.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 15 Oct 2021 11:27:39 +0300
Message-ID: <CAOQ4uxjS02VccUUP6r3FyoQ_7TbT6wpo=jzhr+0HNJpSkmiWrQ@mail.gmail.com>
Subject: Re: [PATCH v7 25/28] fanotify: Allow users to request FAN_FS_ERROR events
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Jan Kara <jack@suse.com>, "Darrick J. Wong" <djwong@kernel.org>,
        Theodore Tso <tytso@mit.edu>,
        David Howells <dhowells@redhat.com>,
        Khazhismel Kumykov <khazhy@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Matthew Bobrowski <repnop@google.com>, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 15, 2021 at 12:39 AM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> Wire up the FAN_FS_ERROR event in the fanotify_mark syscall, allowing
> user space to request the monitoring of FAN_FS_ERROR events.
>
> These events are limited to filesystem marks, so check it is the
> case in the syscall handler.
>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> ---
>  fs/notify/fanotify/fanotify.c      | 2 +-
>  fs/notify/fanotify/fanotify_user.c | 5 +++++
>  include/linux/fanotify.h           | 6 +++++-
>  3 files changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> index 47e28f418711..d449a23d603f 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -827,7 +827,7 @@ static int fanotify_handle_event(struct fsnotify_group *group, u32 mask,
>         BUILD_BUG_ON(FAN_OPEN_EXEC_PERM != FS_OPEN_EXEC_PERM);
>         BUILD_BUG_ON(FAN_FS_ERROR != FS_ERROR);
>
> -       BUILD_BUG_ON(HWEIGHT32(ALL_FANOTIFY_EVENT_BITS) != 19);
> +       BUILD_BUG_ON(HWEIGHT32(ALL_FANOTIFY_EVENT_BITS) != 20);
>
>         mask = fanotify_group_event_mask(group, iter_info, mask, data,
>                                          data_type, dir);
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index 8f7c2f4ce674..5edfd7e3f356 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -1585,6 +1585,11 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
>                 fsid = &__fsid;
>         }
>
> +       if (mask & FAN_FS_ERROR && mark_type != FAN_MARK_FILESYSTEM) {
> +               ret = -EINVAL;
> +               goto path_put_and_out;
> +       }
> +

Please move this up to the section where input args validity is checked
(i.e. before or after FANOTIFY_PERM_EVENTS check).
It is the correct context for this sort of check and ret is already
set to -EINVAL for the entire section.

Thanks,
Amir.
