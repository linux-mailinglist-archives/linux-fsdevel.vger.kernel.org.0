Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD60C4535A6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Nov 2021 16:22:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238198AbhKPPY7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Nov 2021 10:24:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238204AbhKPPYm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Nov 2021 10:24:42 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB812C0613B9
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Nov 2021 07:21:45 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id x9so20734826ilu.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Nov 2021 07:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5gthWZg0+yQYl80LcjWgCNZkTU37IOYj2vTgyBv44ag=;
        b=YHcXq+8T2NIdfwrHkLRhh4q2NbdTCKXkFQg695DZ9w8VNHYOdQ2xFC7JTQcA05Z0g9
         EpkhcklmUUDQb4AewGKy8SatJYy+4v9mvXU/VI20srSJxVDLRw/YgPu6ht8mDdj27tC7
         I/dboArXoKO6PmoWjzipz7mzWlF2QgGQGZh1U7Fopr8XGFNjPxpLTdb4H+xH9pjC4FZd
         WOxZFCPrRP+tVo/GG3XfniVdoYtZWLIx2gYKbyipOqEeW7WHJyPZLOY4kmLEMoyPRArw
         7ohLrBwh6yq6xNM982Tki0I+ntDT/YH+s8Nlc/uR+JvsQwzQVDwjapcIiL/oRmV+ZsYe
         LFHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5gthWZg0+yQYl80LcjWgCNZkTU37IOYj2vTgyBv44ag=;
        b=xFO/eQiXpagcaWvBTGCR7cK+vx7Hhh6gg+NTK3yWHxFvwEdYbxqBesoHHEof2PDymI
         B70kWXZG6sSKSTjS8N1LFMlz0WPJ3O/zAhXJb31LfZXjSwMxDcCAg5jKLnAUpTLv8Hvs
         /IZaqX0pjQZpoHR/wYmwanMv1pP84DCmdxyO5oyBI80lRBW7LVvg6xoPX2rKGz6Aic4B
         x/L+XQKF8Hit67Ohs4jIRfH9Ii4TuHF9kwooL+/YVUZJerbqhdtys6P8C4PUopegMwcc
         r2kYQ3oGQW2ss45idUXZMXmv6l5CJAYMF4pj4pGtvW41yiX88VDK8sVwi81E3FGH2lsZ
         z4aQ==
X-Gm-Message-State: AOAM530HP3NoGAXOMdOSEMLm2Wj0ocfNTRWHkRPsiQRY++/V9UGre3yQ
        CX6wlo5egH+r7puBmELTyr48mJI8KZ7li+D69x9f4italNc=
X-Google-Smtp-Source: ABdhPJwLWUbrjYVNaU6bQSxo6BRXiXZ6wtz8ET8RaFt/ODL3NPEwSAWuRKgNHyr+zSKFLA4A3xAoftNlM+UEYd24Jgs=
X-Received: by 2002:a92:d643:: with SMTP id x3mr5235444ilp.107.1637076105403;
 Tue, 16 Nov 2021 07:21:45 -0800 (PST)
MIME-Version: 1.0
References: <20211116114516.GA11780@kili>
In-Reply-To: <20211116114516.GA11780@kili>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 16 Nov 2021 17:21:34 +0200
Message-ID: <CAOQ4uxhHzoK=MU4Toc3uQSk5HZLZia0=DBBkC2L1ZeVVLTLGXw@mail.gmail.com>
Subject: Re: [bug report] fanotify: record name info for FAN_DIR_MODIFY event
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 16, 2021 at 1:45 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> Hello Amir Goldstein,
>
> The patch cacfb956d46e: "fanotify: record name info for
> FAN_DIR_MODIFY event" from Mar 19, 2020, leads to the following
> Smatch static checker warning:
>
>         fs/notify/fanotify/fanotify_user.c:401 copy_fid_info_to_user()
>         error: we previously assumed 'fh' could be null (see line 362)
>
> fs/notify/fanotify/fanotify_user.c
>     354 static int copy_fid_info_to_user(__kernel_fsid_t *fsid, struct fanotify_fh *fh,
>     355                                  int info_type, const char *name,
>     356                                  size_t name_len,
>     357                                  char __user *buf, size_t count)
>     358 {
>     359         struct fanotify_event_info_fid info = { };
>     360         struct file_handle handle = { };
>     361         unsigned char bounce[FANOTIFY_INLINE_FH_LEN], *fh_buf;
>     362         size_t fh_len = fh ? fh->len : 0;
>                                 ^^^^^^^^^^^^^
> The patch adds a check for in "fh" is NULL
>
>     363         size_t info_len = fanotify_fid_info_len(fh_len, name_len);
>     364         size_t len = info_len;
>     365
>     366         pr_debug("%s: fh_len=%zu name_len=%zu, info_len=%zu, count=%zu\n",
>     367                  __func__, fh_len, name_len, info_len, count);
>     368

Upstream has these two lines:
       if (!fh_len)
                return 0;

Which diffuses the reported bug.
Where did those lines go?

Thanks,
Amir.
