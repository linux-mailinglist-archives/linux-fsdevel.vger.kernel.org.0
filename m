Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0FA236C00B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Apr 2021 09:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbhD0H0J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Apr 2021 03:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbhD0H0I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Apr 2021 03:26:08 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D9EC061574;
        Tue, 27 Apr 2021 00:25:25 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id i22so6025993ila.11;
        Tue, 27 Apr 2021 00:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KypSn7jaMxDXK61CADYpVAu4LrUoQUvUtgwxvJUGc8E=;
        b=mIcjCJP4y7s1LeBXLcEG7c5ic6PwxjZqF3vgsUtXRBK0hBERDM7m/jzysVmfYuENXB
         qiilfQKdrDiL/gGxX3wVOsCTj6gZB+o2cezpK6Oe4pjShs+86mK/5+8Q2pYOEEmAAVrs
         8FCuj6WQvGRTUWqdnVYNNo5F3PjypCUTTeyxvnWZnzA09wm+SLjoSM7TxYtR/GWwiCUv
         OWTZmh5Tg6UJaWMyUODBfwMZdC9RD2Kcn/ycaaqe02G4/g92Ki8/zandnvRJd7Mprrkv
         2K0B90uXW/s8c9QRlRd/Skz0RiLvu6AbQxPBjETT91r+EQU54O+9NPOQx195k3ZoKYdj
         /a6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KypSn7jaMxDXK61CADYpVAu4LrUoQUvUtgwxvJUGc8E=;
        b=BtiUPImJlyo+kciWZXoHEMQMDHAiIHDhXH7QKfjFlWRUk3CyIAhYxll6x5mX8ccmUm
         chY3iOtkImYImml++MFmlmytvKYXROKlnyofc0mBZtsz7PyY4WR6OrfaSCATtnGZAoUn
         7wJ7z+kiNFPkoh6iP7P53vDL3C+F7yuiUmlp8JHCfYoQQ1o7ktdJu3YcpCEVW88Hp3Mi
         MhvdFe/hXDaAd6DHDlZmOWJqrcDWEFYjatNRBNj3pYA6ME9yLE8+FpmNOoNxxu8hFSrX
         csclJC7/jaU/HHNZmQ11uDnMZVTEKoZyQqJigYXgnGXs42NEnElAF7v67QYH4/2bvxuT
         H8IQ==
X-Gm-Message-State: AOAM532Ih/PleF66hAlstId9N3M1REahF3BdRMl+yCGx/8RSTzUjoxLj
        4k4I9yckS62IUgIVilu8FJNwmbYuSYYkkAVxXm8=
X-Google-Smtp-Source: ABdhPJwELAdZyyNdQuQuB5kn7Eb80yLU3viH2nIiz0gKrHzo9IqRdvzSHlmGw1pmWH14fVKC7/0/0jRcxcZb+isWRrE=
X-Received: by 2002:a92:d352:: with SMTP id a18mr5103971ilh.9.1619508325161;
 Tue, 27 Apr 2021 00:25:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210426184201.4177978-1-krisman@collabora.com> <20210426184201.4177978-13-krisman@collabora.com>
In-Reply-To: <20210426184201.4177978-13-krisman@collabora.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 27 Apr 2021 10:25:14 +0300
Message-ID: <CAOQ4uxhhyZhEwg6aiNVYc4Nbxg4PBhTtcgYE0Vqm8iONXDqg=Q@mail.gmail.com>
Subject: Re: [PATCH RFC 12/15] fanotify: Introduce the FAN_ERROR mark
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Theodore Tso <tytso@mit.edu>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.com>,
        David Howells <dhowells@redhat.com>,
        Khazhismel Kumykov <khazhy@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 26, 2021 at 9:43 PM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> The FAN_ERROR mark is used by filesystem wide monitoring tools to
> receive notifications of type FS_ERROR_EVENT, emited by filesystems when
> a problem is detected.  The error notification includes a generic error
> descriptor, an optional location record and a filesystem specific blob.
>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> ---
>  fs/notify/fanotify/fanotify.c      | 48 +++++++++++++++++++----
>  fs/notify/fanotify/fanotify.h      |  8 ++++
>  fs/notify/fanotify/fanotify_user.c | 63 ++++++++++++++++++++++++++++++
>  include/linux/fanotify.h           |  9 ++++-
>  include/uapi/linux/fanotify.h      |  2 +
>  5 files changed, 120 insertions(+), 10 deletions(-)
>
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> index 98591a8155a7..6bae23d42e5e 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -240,12 +240,14 @@ static u32 fanotify_group_event_mask(struct fsnotify_group *group,
>                  __func__, iter_info->report_mask, event_mask, data, data_type);
>
>         if (!fid_mode) {
> -               /* Do we have path to open a file descriptor? */
> -               if (!path)
> -                       return 0;
> -               /* Path type events are only relevant for files and dirs */
> -               if (!d_is_reg(path->dentry) && !d_can_lookup(path->dentry))
> -                       return 0;
> +               if (!fanotify_is_error_event(event_mask)) {

This open coded nested condition is not nice.
If we get as far as this, I will explain what needs to be done.
Need helpers fanotify_is_reporting_fd(), fanotify_is_reporting_fid() and
fanotify_is_reporting_dir_fid().

Thanks,
Amir.
