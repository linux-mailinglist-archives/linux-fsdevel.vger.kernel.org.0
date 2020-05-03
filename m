Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE35F1C2D15
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 May 2020 16:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728706AbgECOrC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 3 May 2020 10:47:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:39836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728698AbgECOrC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 3 May 2020 10:47:02 -0400
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 648E9206F0
        for <linux-fsdevel@vger.kernel.org>; Sun,  3 May 2020 14:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588517221;
        bh=8s1DSRTBmb10kFPL8ejk7tvwu04ZaQtvIflYHBjTpME=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=a+L3vrQUnuHjz0ugN4ShEA8g9pqud8ebFBb9p2QA0JTaNB4vrdpN3FVlY41zfcqoR
         xLnmdR7HOhA3WhDvNskv/+cBBLyZU08WkuJUHjAtMpMfFd1DZNnqmanCknn8gvRPoP
         cMVw5VWfVZsUu6fXiiePQ8MM64MgWTCvuzU7/+ZU=
Received: by mail-ot1-f45.google.com with SMTP id g14so6634594otg.10
        for <linux-fsdevel@vger.kernel.org>; Sun, 03 May 2020 07:47:01 -0700 (PDT)
X-Gm-Message-State: AGi0PuYVOIX36UzC7ZLQ02LFzfQI4rtPFNphnOd+Pk4y6YAHE+w28bAh
        McEIPBf5YVCW2PHxmtyyEa2jLvn5s4hVRBN7nX4=
X-Google-Smtp-Source: APiQypKk1NwITqv7D2wkg8G90a1ROWkFrFrJADc5jjaQCxlptkLshwNGtaUdo5JpSio/k4sqbny9El/Uuv5QFTa3kUo=
X-Received: by 2002:a05:6830:154c:: with SMTP id l12mr11201167otp.120.1588517220720;
 Sun, 03 May 2020 07:47:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:6e4:0:0:0:0:0 with HTTP; Sun, 3 May 2020 07:47:00 -0700 (PDT)
In-Reply-To: <f7b13155-5f56-1d14-4c26-e1fea8d04a62@sandeen.net>
References: <f7b13155-5f56-1d14-4c26-e1fea8d04a62@sandeen.net>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Sun, 3 May 2020 23:47:00 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9NiayEX91dyMwrY8QZRp+C4ekNVP8q6uhNyrKTbZmu+w@mail.gmail.com>
Message-ID: <CAKYAXd9NiayEX91dyMwrY8QZRp+C4ekNVP8q6uhNyrKTbZmu+w@mail.gmail.com>
Subject: Re: [PATCH] exfat: use iter_file_splice_write
To:     Eric Sandeen <sandeen@sandeen.net>
Cc:     fsdevel <linux-fsdevel@vger.kernel.org>,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

2020-05-02 10:34 GMT+09:00, Eric Sandeen <sandeen@sandeen.net>:
> Doing copy_file_range() on exfat with a file opened for direct IO leads
> to an -EFAULT:
>
> # xfs_io -f -d -c "truncate 32768" \
>        -c "copy_range -d 16384 -l 16384 -f 0" /mnt/test/junk
> copy_range: Bad address
>
> and the reason seems to be that we go through:
>
> default_file_splice_write
>  splice_from_pipe
>   __splice_from_pipe
>    write_pipe_buf
>     __kernel_write
>      new_sync_write
>       generic_file_write_iter
>        generic_file_direct_write
>         exfat_direct_IO
>          do_blockdev_direct_IO
>           iov_iter_get_pages
>
> and land in iterate_all_kinds(), which does "return -EFAULT" for our kvec
> iter.
>
> Setting exfat's splice_write to iter_file_splice_write fixes this and lets
> fsx (which originally detected the problem) run to success from the
> xfstests
> harness.
>
> Signed-off-by: Eric Sandeen <sandeen@sandeen.net>
Applied:)
Thanks!
> ---
>
> I know that's not a good changelog; I conferred with viro about whether
> this
> is correct, but I still don't have a great explanation, so feel free to fix
> up
> the changelog to be more informative if the change is otherwise correct...
>
> diff --git a/fs/exfat/file.c b/fs/exfat/file.c
> index 4f76764165cf..c9db8eb0cfc3 100644
> --- a/fs/exfat/file.c
> +++ b/fs/exfat/file.c
> @@ -348,12 +348,13 @@ int exfat_setattr(struct dentry *dentry, struct iattr
> *attr)
>  }
>
>  const struct file_operations exfat_file_operations = {
> -	.llseek      = generic_file_llseek,
> -	.read_iter   = generic_file_read_iter,
> -	.write_iter  = generic_file_write_iter,
> -	.mmap        = generic_file_mmap,
> -	.fsync       = generic_file_fsync,
> -	.splice_read = generic_file_splice_read,
> +	.llseek		= generic_file_llseek,
> +	.read_iter	= generic_file_read_iter,
> +	.write_iter	= generic_file_write_iter,
> +	.mmap		= generic_file_mmap,
> +	.fsync		= generic_file_fsync,
> +	.splice_read	= generic_file_splice_read,
> +	.splice_write	= iter_file_splice_write,
>  };
>
>  const struct inode_operations exfat_file_inode_operations = {
>
>
>
