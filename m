Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26EC85F21AA
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Oct 2022 09:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbiJBHJF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 2 Oct 2022 03:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiJBHJE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 2 Oct 2022 03:09:04 -0400
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B173F337;
        Sun,  2 Oct 2022 00:09:03 -0700 (PDT)
Received: by mail-ua1-x92c.google.com with SMTP id d3so2016558uav.7;
        Sun, 02 Oct 2022 00:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=LXHdxUnEPRav2MpSDEM7tzyEf7YMDJf0LVPzraEFzIk=;
        b=Qy5cxZways54nm/9MLDMp7+yWjordQLhW4//q/MyefIXCYOy1h5MQByuVKHMix/oyX
         h7FHj+ttjYM/fAIPn6+T5SEQqWWRSAwc3zlwOOqY2SOcjrgHQOgwsSBB5UwcCy+weIC6
         Xa+gdIeodO4XtvTSIhF8TkLHdGRQ8F16yUUZcWnEQZBRm4A0ebUaZkW4lwEGpO4j91B2
         rA0TYnsxr8rXrpTlO5ow2PiQ7a6brhQGV+SIkVbTPHAP++s5g8pfa6EJIjmsOUT1Wjxg
         mO6BR6Am82qVA+aCQkWVTPoDkfFnokQBR+ZwfwzLo1fIR5O8W0GsZeqllCQHo4vqLVcr
         QEpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=LXHdxUnEPRav2MpSDEM7tzyEf7YMDJf0LVPzraEFzIk=;
        b=d1JHtUrTqtYb7qJ3q7MvlBgLjNu47nU+89+P0+VYk+N5KtT5Dqpe+CiqLVzbMzMNLX
         Kq+ryVQxBZ3zFom7RJcHBh883E7Q9BBMADK7u/X18m5CupjhMePWFhr+D1DriFPu3tyJ
         07frTdR+TisO8AlU0HZ3t/6LN6GXWq8sI59CY1gQqOkehYk7N/h/4oKJAPp1SWApzk4H
         JQB8Xeicp5t7uy/Q0sumsBrIyyq7n2J/THdGzFLjgYr9N3fhoKeSNAKFdkCxrySziNEr
         9xytp8DybuPp6gO6M2SVgFMxlBb2lyOwTEM6xz61qcRkO8gGZrT+5OGL8JpXs2Lkx9kq
         wJtQ==
X-Gm-Message-State: ACrzQf1THfFcyAhO//5QSgvz30judBjegzIVkIC/XRUvPZImdRptP54z
        WUTMUIvhIo3tseuXnXYFbpFEEWzUQxbtRXQY520=
X-Google-Smtp-Source: AMsMyM4lxq8AMEBGfxhYSFJxHI6bK6WI16yGisB2NddH2eWCjim+p2nhUlJ9NU/wgxtpH+PtkMxn0OySNuUsyVaDhoI=
X-Received: by 2002:a9f:3562:0:b0:3d0:ad99:b875 with SMTP id
 o89-20020a9f3562000000b003d0ad99b875mr8123774uao.102.1664694542759; Sun, 02
 Oct 2022 00:09:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220930111840.10695-1-jlayton@kernel.org> <20220930111840.10695-9-jlayton@kernel.org>
In-Reply-To: <20220930111840.10695-9-jlayton@kernel.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sun, 2 Oct 2022 10:08:51 +0300
Message-ID: <CAOQ4uxgofERYwN7AfYFWqQMpQH5y3LV+6UuGfjU29gZXNf7-vQ@mail.gmail.com>
Subject: Re: [PATCH v6 8/9] vfs: update times after copying data in __generic_file_write_iter
To:     Jeff Layton <jlayton@kernel.org>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, djwong@kernel.org,
        david@fromorbit.com, trondmy@hammerspace.com, neilb@suse.de,
        viro@zeniv.linux.org.uk, zohar@linux.ibm.com, xiubli@redhat.com,
        chuck.lever@oracle.com, lczerner@redhat.com, jack@suse.cz,
        bfields@fieldses.org, brauner@kernel.org, fweimer@redhat.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-xfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 30, 2022 at 2:30 PM Jeff Layton <jlayton@kernel.org> wrote:
>
> The c/mtime and i_version currently get updated before the data is
> copied (or a DIO write is issued), which is problematic for NFS.
>
> READ+GETATTR can race with a write (even a local one) in such a way as
> to make the client associate the state of the file with the wrong change
> attribute. That association can persist indefinitely if the file sees no
> further changes.
>
> Move the setting of times to the bottom of the function in
> __generic_file_write_iter and only update it if something was
> successfully written.
>

This solution is wrong for several reasons:

1. There is still file_update_time() in ->page_mkwrite() so you haven't
    solved the problem completely
2. The other side of the coin is that post crash state is more likely to end
    up data changes without mtime/ctime change

If I read the problem description correctly, then a solution that invalidates
the NFS cache before AND after the write would be acceptable. Right?
Would an extra i_version bump after the write solve the race?

> If the time update fails, log a warning once, but don't fail the write.
> All of the existing callers use update_time functions that don't fail,
> so we should never trip this.
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  mm/filemap.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
>
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 15800334147b..72c0ceb75176 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -3812,10 +3812,6 @@ ssize_t __generic_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
>         if (err)
>                 goto out;
>
> -       err = file_update_time(file);
> -       if (err)
> -               goto out;
> -
>         if (iocb->ki_flags & IOCB_DIRECT) {
>                 loff_t pos, endbyte;
>
> @@ -3868,6 +3864,19 @@ ssize_t __generic_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
>                         iocb->ki_pos += written;
>         }
>  out:
> +       if (written > 0) {
> +               err = file_update_time(file);
> +               /*
> +                * There isn't much we can do at this point if updating the
> +                * times fails after a successful write. The times and i_version
> +                * should still be updated in the inode, and it should still be
> +                * marked dirty, so hopefully the next inode update will catch it.
> +                * Log a warning once so we have a record that something untoward
> +                * has occurred.
> +                */
> +               WARN_ONCE(err, "Failed to update m/ctime after write: %ld\n", err);

pr_warn_once() please - this is not a programming assertion.

Thanks,
Amir.
