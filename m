Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 523602E57F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2019 21:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbfE2TiE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 May 2019 15:38:04 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:46056 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbfE2TiE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 May 2019 15:38:04 -0400
Received: by mail-yw1-f67.google.com with SMTP id w18so1556655ywa.12;
        Wed, 29 May 2019 12:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=awlNxR/Rxv+hJa8Bxg/Rn90OEdMGA9Wwg8E/mvGNXU8=;
        b=qwkghOQr+yXQSjWTa2072FVqiGioaKVDacsPXvGumD95BzNbGdv89s4W267tRi1TnU
         rBFR1RO1VzLDZqzTEM8F0ZMI/ABLksFiKBzf08uNtXNrVhCdb6qJ9jyLsNtDriBVHfXy
         D7A+SKRe9ixxWjif2vpDiD18p1djMPD/CMRAE4WCEFVd8A6FIcWYSaGPy8yWi91ggVPS
         IeW4lbwacpbnqnP0daaMfXPo+lrL884r9FCgAdiUaGzQkvy8+DZg7OrVthq7iMRKulMI
         p5710OC+1DUJCN7x43c4eIgxdvYc2LnFlv67YinKplAX5Z8hAdnlch7v0PGQt962PYJF
         Z5gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=awlNxR/Rxv+hJa8Bxg/Rn90OEdMGA9Wwg8E/mvGNXU8=;
        b=btB9pGhgXEqvProvx1w5jYzFeJIh/y7BotV4e0GRhLvelX+af6zm8axZjGkuvYj8c5
         e+Iwd6MzgDNykhDwS3sfGPm/E9YiIxJIFRJKMpn/Siv0J2GsMsuGeTnIz0qhtNVVTGxV
         Ub1raMESDIF8wrs1EC5fRYJCX6RkP5Ux8DGXHY+rc15LVBD0RIw1T2BV5cCxpKyUp4GE
         j2pV9NfIb3mePfWHcjpAQKb/8GqGJ/WjGrjEuldvYj8zuO+HVEw1iLjSAff3xmSoVUBf
         xLtpvU2kXY6UxWKCQInz5GMknyykXwiyQEnjBKpmNQ+1pac5QSRlhFljTkswQ4SKAqUW
         jV6w==
X-Gm-Message-State: APjAAAUFux8GP6GB03152ODdI8+vR2V2mCu57uUluvv9Y17SwH6lHQ8q
        GPeJcQtTdHYpMqUql3888pOF8QYuw55SP6ZnG9Q=
X-Google-Smtp-Source: APXvYqyOyBWU9oVJUYgwWDGKcrIuMP/6YEvLDerVu8kRoRQBCUkMMVdYnH1oGApBHjrwyfhf5K/i47NLtTmdQQZgvnw=
X-Received: by 2002:a81:4f06:: with SMTP id d6mr48782860ywb.379.1559158683230;
 Wed, 29 May 2019 12:38:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190529174318.22424-1-amir73il@gmail.com> <20190529174318.22424-12-amir73il@gmail.com>
In-Reply-To: <20190529174318.22424-12-amir73il@gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 29 May 2019 22:37:52 +0300
Message-ID: <CAOQ4uxiAa5jCCqkRbq7cn8Mmnb0rX7piMOfy9W4qk7g=7ziJnA@mail.gmail.com>
Subject: Re: [PATCH v3 11/13] fuse: copy_file_range needs to strip setuid bits
 and update timestamps
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        Luis Henriques <lhenriques@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-api@vger.kernel.org, ceph-devel@vger.kernel.org,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        "Darrick J . Wong" <darrick.wong@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Miklos,

Could we get an ACK on this patch.
It is a prerequisite for merging the cross-device copy_file_range work.

It depends on a new helper introduced here:
https://lore.kernel.org/linux-fsdevel/CAOQ4uxjbcSWX1hUcuXbn8hFH3QYB+5bAC9Z1yCwJdR=T-GGtCg@mail.gmail.com/T/#m1569878c41f39fac3aadb3832a30659c323b582a

Thanks,
Amir,

On Wed, May 29, 2019 at 8:43 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> Like ->write_iter(), we update mtime and strip setuid of dst file before
> copy and like ->read_iter(), we update atime of src file after copy.
>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  fs/fuse/file.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index e03901ae729b..7f33d68f66d9 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -3128,6 +3128,10 @@ static ssize_t __fuse_copy_file_range(struct file *file_in, loff_t pos_in,
>
>         inode_lock(inode_out);
>
> +       err = file_modified(file_out);
> +       if (err)
> +               goto out;
> +
>         if (fc->writeback_cache) {
>                 err = filemap_write_and_wait_range(inode_out->i_mapping,
>                                                    pos_out, pos_out + len);
> @@ -3169,6 +3173,7 @@ static ssize_t __fuse_copy_file_range(struct file *file_in, loff_t pos_in,
>                 clear_bit(FUSE_I_SIZE_UNSTABLE, &fi_out->state);
>
>         inode_unlock(inode_out);
> +       file_accessed(file_in);
>
>         return err;
>  }
> --
> 2.17.1
>
