Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4EB38C2A6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 May 2021 11:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235524AbhEUJJE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 May 2021 05:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235439AbhEUJJD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 May 2021 05:09:03 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2681CC061574;
        Fri, 21 May 2021 02:07:41 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id b25so1106980iot.5;
        Fri, 21 May 2021 02:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F68djwrrrlB+TcldXidy5MN/3R9n2lZHelR2pEFMlHU=;
        b=S6xbS/yQBhxwHdRnjhwMLqSX1iGJDDuoKPl9IOnk5+aYo3PrzVbSoFiTyJziNTCDD3
         Hxl3ZkX/PvlYAv6kPyNqlBYLdgvoEmtI9qv4y469KhJ3ATQxnrLRpsjOoTRAhW64fpVU
         opMM8IquJZHsamIjbO56bBibM5K/jcvrF55l1A6EykFFGoWzrtxBgKp7r+YDU6DmQRTf
         lYsBCUVT5lqMCF2Y61k6EBITfF3JjrTh1dLGChE+xefeMRoTFDP3IxP4wCcmQ8uwhYIS
         MEgXSjs6xsJdtmiM1bcxyOKj8t0wHGd1ruUg7hPby/laEXwhC4lFF+wKeavnW1XpK/BC
         02lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F68djwrrrlB+TcldXidy5MN/3R9n2lZHelR2pEFMlHU=;
        b=EWjswr1MJJ45vWOXuwUMl9pjILOdMKAeV7PVBzo8HglWRcTQM5laxvyzNf/tM/3/e8
         C75K9d+N/cOX6F2i/xJ9w3MVLkfQHaPXBBtisqezERvqu2pQx5eCp3PN5FtXwPwu9+3G
         cY6z5dAdhIl4qS1QPvSGx6btz3u5FXcUdOcL5LsXfhDrIwAWQvp2GNdIMwBlc9H+sLTi
         vTvYAR+sJapmkn0nT9pw0jyTGSvEF/yv4WQfqxzSeH3Osk5w5ACJ95CP69whwmwmoOYo
         v/mrGQueuimZxUIRXKc6zWJyd7aH1dO8kID38ZJ+2E2Iw51WqrxYTmV8VbVU5KoHpvFW
         mUUw==
X-Gm-Message-State: AOAM532qna3blmPjzKrFhlKEYJesODEo9nT0EseermnhCBpyeNGVoQB3
        +KfQC2az1uwe9Ryf9Eb4l4urmS+NAF5U1FLI4pUXjP0M6Z0=
X-Google-Smtp-Source: ABdhPJwN46O66COep21kHFjg/O7u1o0s8ggjlT1za2ZnAGm3M6lvrJDPH6PziiQQSDz167s5uxV3YxFE9kjAJAS2v00=
X-Received: by 2002:a6b:3119:: with SMTP id j25mr9404514ioa.64.1621588060516;
 Fri, 21 May 2021 02:07:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210521024134.1032503-1-krisman@collabora.com> <20210521024134.1032503-6-krisman@collabora.com>
In-Reply-To: <20210521024134.1032503-6-krisman@collabora.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 21 May 2021 12:07:29 +0300
Message-ID: <CAOQ4uxi2G-RT1aLU337zDjWZxpi7aP-x-OTTL=5vGuf1H9DXjA@mail.gmail.com>
Subject: Re: [PATCH 05/11] inotify: Don't force FS_IN_IGNORED
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
> According to Amir:
>
> "FS_IN_IGNORED is completely internal to inotify and there is no need
> to set it in i_fsnotify_mask at all, so if we remove the bit from the
> output of inotify_arg_to_mask() no functionality will change and we will
> be able to overload the event bit for FS_ERROR."
>
> This is done in preparation to overload FS_ERROR with the notification
> mechanism in fanotify.
>
> Suggested-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  fs/notify/inotify/inotify_user.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
> index 98f61b31745a..4d17be6dd58d 100644
> --- a/fs/notify/inotify/inotify_user.c
> +++ b/fs/notify/inotify/inotify_user.c
> @@ -89,10 +89,10 @@ static inline __u32 inotify_arg_to_mask(struct inode *inode, u32 arg)
>         __u32 mask;
>
>         /*
> -        * Everything should accept their own ignored and should receive events
> -        * when the inode is unmounted.  All directories care about children.
> +        * Everything should receive events when the inode is unmounted.
> +        * All directories care about children.
>          */
> -       mask = (FS_IN_IGNORED | FS_UNMOUNT);
> +       mask = (FS_UNMOUNT);

Nit: can remove ()

Thanks,
Amir.
