Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 094513AFE19
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jun 2021 09:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbhFVHmm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Jun 2021 03:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbhFVHmm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Jun 2021 03:42:42 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BECCC061574;
        Tue, 22 Jun 2021 00:40:26 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id he7so32935414ejc.13;
        Tue, 22 Jun 2021 00:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xQyABpWzE19xRadtudcaP3+NTE2M7E6yiV97ca/yhww=;
        b=QZvDdaoOkVYQLG8otklFFBe/0ZsEeILKWvXBF3qUOpC2R5PuSHowtJOHv9FApI3o/G
         OJNMWjLZb16lmrKAz3uL+iX2dPnIzSq+upTI8t7tb0SXLHPKDY4DHQvJPZ7FZRUJa3cg
         RU+X43a5PZO1baFqI3NF003p6IuuADeFuWosIslZil8GoyIa9akhb+OkxhTD8WxIYNsY
         k4202UDJX4KGzCosjI1MxXTlbx13XuOFh8Ou2+OPrrkbpuxm9BzBDEhAKRnO1ZCMPGS0
         7M0B5maG0tUredvMuoEyC7tuGWbdpl+fWHvMLlmmduEFGy4UQUAfOMXmc/+dOD/MnOjp
         o1nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xQyABpWzE19xRadtudcaP3+NTE2M7E6yiV97ca/yhww=;
        b=DDLiXHMtKiihhZUtNCceDPfWe7sSj1sAWgdP8MDB+k0X8hEwTvXgUuybyckqDvai6L
         jiya/QY/cVUbykO2fum71BB8keUNh6dtGBy9NSgyR8/BmS5V+nC+FGGVydu60Sq0qT9X
         i5CJMQiJtcpLgXlmmxUWCelZA8vb+5k6vN4fOMxXzXXDQwgpCjxMuu3HY8UPTdZb0NGT
         lEDtz2Qbz8xZf62+VVten1SeHFceAw+98aIBAFRfmTpO8Ul8v/ze9XDo8m6QrfbKmMsx
         zCu/YKL6Zso7h3AmnidCE0zRLVYXv+wjx6OiK328QocrCNCkMByDxGxbd/Ld3/OeNRKU
         m2Cg==
X-Gm-Message-State: AOAM5302cFH8zntZCady19R2cIQVPv1o/POndUFb2dSQBZz0C0oZJC5W
        7wbnzT1dNdXrfYqsw/vft3ukmx9nbVT+7UYzOYs=
X-Google-Smtp-Source: ABdhPJz0yuY8/gdW7uMGBdd4+eGP7+3+wPgKIgWYdTdtY008V/0jI8bwYFqoIsHgInuxvN9TxpVDyDkAt5ZusPb3x/M=
X-Received: by 2002:a17:906:1486:: with SMTP id x6mr2559515ejc.69.1624347624690;
 Tue, 22 Jun 2021 00:40:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210618075925.803052-1-cccheng@synology.com> <20210622060419.GA29360@lst.de>
In-Reply-To: <20210622060419.GA29360@lst.de>
From:   Chung-Chiang Cheng <shepjeng@gmail.com>
Date:   Tue, 22 Jun 2021 15:40:13 +0800
Message-ID: <CAHuHWt=2ZoQJz1tVpJ7SzqUDwPXthNHksq2-uTFCzHmv+E7qWA@mail.gmail.com>
Subject: Re: [PATCH] configfs: fix memleak in configfs_release_bin_file
To:     Christoph Hellwig <hch@lst.de>
Cc:     jlbec@evilplan.org,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Chung-Chiang Cheng <cccheng@synology.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

It works for me. I've verified it with ACPI configfs that is the only
one using configfs binary attributes so far, and the memleak issue
is solved.

On Tue, Jun 22, 2021 at 2:04 PM Christoph Hellwig <hch@lst.de> wrote:
>
> Hmm.  The issue looks real, but I think we should just call the vfree
> unconditionally given that the buffer structure is zeroed on allocation
> and freed just after, and also remove the pointless clearing of all the
> flags.  Does something like this work for you?
>
> diff --git a/fs/configfs/file.c b/fs/configfs/file.c
> index 53913b84383a..1ab6afb84f04 100644
> --- a/fs/configfs/file.c
> +++ b/fs/configfs/file.c
> @@ -393,11 +393,8 @@ static int configfs_release_bin_file(struct inode *inode, struct file *file)
>  {
>         struct configfs_buffer *buffer = file->private_data;
>
> -       buffer->read_in_progress = false;
> -
>         if (buffer->write_in_progress) {
>                 struct configfs_fragment *frag = to_frag(file);
> -               buffer->write_in_progress = false;
>
>                 down_read(&frag->frag_sem);
>                 if (!frag->frag_dead) {
> @@ -407,13 +404,9 @@ static int configfs_release_bin_file(struct inode *inode, struct file *file)
>                                         buffer->bin_buffer_size);
>                 }
>                 up_read(&frag->frag_sem);
> -               /* vfree on NULL is safe */
> -               vfree(buffer->bin_buffer);
> -               buffer->bin_buffer = NULL;
> -               buffer->bin_buffer_size = 0;
> -               buffer->needs_read_fill = 1;
>         }
>
> +       vfree(buffer->bin_buffer);
>         configfs_release(inode, file);
>         return 0;
>  }
