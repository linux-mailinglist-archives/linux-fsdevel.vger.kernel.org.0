Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76EA542E87A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Oct 2021 07:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234292AbhJOFvT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Oct 2021 01:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbhJOFvS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Oct 2021 01:51:18 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D80C061570;
        Thu, 14 Oct 2021 22:49:12 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id i11so5953901ila.12;
        Thu, 14 Oct 2021 22:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KtSR2tvDzCNz1RXAdUkMqN1214rU3gzhBqVCW7f8teA=;
        b=OcW6z5+rot60yxdedv/Au44PSchJgC4IJNCHB+zwlk6MWhlmEE3hfoVkO2SKjpNKLD
         IKICKC/owR1kIEFJra4chM9hEc+dVYQwMB+H1G3plv/xjPEX2OPDOIz5LFlBXD2jXEl0
         dNthO0esLVxWTPS25caEbVpxlWyoFIGi5cC4QrGmYetz0rK3nDRAjcdzLMm89q3Qq0nS
         bOYEVSq/+bFSvi4vPKdA+IMU1ls/Q3OMgGzggGEKMPfWpJBTBu2fWgbxdVzJxGPZF7DQ
         h7y3XR4H6akyd6YiV/eMZwHLJAo6MjEhYGbbuEtNICHfFMQdNlYPEojXqM8uTnoOQNa8
         UBCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KtSR2tvDzCNz1RXAdUkMqN1214rU3gzhBqVCW7f8teA=;
        b=SDCTbVtyaiNRbnhbo8tIMrFNX3gAJAf8+LfE2N5TzxCszYMMf2iEPelz0GAKtsXQGQ
         I5OUonknTNuHow68GaZcxwgGHwBPIHRpgIu4na8N1bj23sqbEHfNTUsaNYS4DmOHVb9x
         yhZ+TgmCcBgV33na+85h8Okdl7tOcpy2pefkdPH0Af1XZcz0fCa+TmANsbaBcm9l4hjK
         lUYx02ymnzi5JKjll66cF5Pg+diC4TsYAmsOcfnc7FrspZw7NyUrrauF0CSDsRdJd01b
         GGNveNaqonS7MlmsW7S3X+vK+YN5L/ln7tgSgxNevZ9Tba6ALdzR7xS59pvv9Nsvpoec
         r6YA==
X-Gm-Message-State: AOAM5326LvzS/n/e4rl2NBP//G4W95AS+NZnKJg6ipb150iyOGMVLtjF
        0ESECr2ymGGw/oaROykQMHhQCgkzPPbBM14Sv7Q=
X-Google-Smtp-Source: ABdhPJzwSFjfUq090BgtjtkcbeaYVZ/WbY+YEfRnSaBQbgsNWSG8qAion3LOliT3eaNgt9JnuP2ORn/NpJbx8dAZx0U=
X-Received: by 2002:a05:6e02:160e:: with SMTP id t14mr2539077ilu.107.1634276952113;
 Thu, 14 Oct 2021 22:49:12 -0700 (PDT)
MIME-Version: 1.0
References: <20211014213646.1139469-1-krisman@collabora.com> <20211014213646.1139469-13-krisman@collabora.com>
In-Reply-To: <20211014213646.1139469-13-krisman@collabora.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 15 Oct 2021 08:49:01 +0300
Message-ID: <CAOQ4uxjtS1e-SvX+LJhREjAgDqoNAjoBQENpCgK=KV9QSiYvBQ@mail.gmail.com>
Subject: Re: [PATCH v7 12/28] fanotify: Support null inode event in fanotify_dfid_inode
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

On Fri, Oct 15, 2021 at 12:38 AM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> FAN_FS_ERROR doesn't support DFID, but this function is still called for
> every event.  The problem is that it is not capable of handling null
> inodes, which now can happen in case of superblock error events.  For
> this case, just returning dir will be enough.
>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>


Please also fortify fsnotify_handle_inode_event() against calling
->handle_inode_event() with NULL inode.

> ---
>  fs/notify/fanotify/fanotify.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> index c620b4f6fe12..397ee623ff1e 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -452,7 +452,7 @@ static struct inode *fanotify_dfid_inode(u32 event_mask, const void *data,
>         if (event_mask & ALL_FSNOTIFY_DIRENT_EVENTS)
>                 return dir;
>
> -       if (S_ISDIR(inode->i_mode))
> +       if (inode && S_ISDIR(inode->i_mode))
>                 return inode;
>
>         return dir;
> --
> 2.33.0
>
