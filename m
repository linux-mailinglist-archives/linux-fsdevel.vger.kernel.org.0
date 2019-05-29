Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7122E58B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2019 21:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbfE2Tnh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 May 2019 15:43:37 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:46277 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbfE2Tnh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 May 2019 15:43:37 -0400
Received: by mail-yw1-f67.google.com with SMTP id x144so1563977ywd.13;
        Wed, 29 May 2019 12:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JuSRvJuyVghuriGBXIxziVD7uudys6jv6caxpa93ooE=;
        b=BXZiDr+cnYBSTe7iIikJu3C2vPoPW4Ehh5vGi8S9SIiUZqOlmbojyfHD4bwrR6EJfd
         LuNsmmBTwHrcohIMr/AwiAyuek9W2Rf9Wqkteffn1CqUnfV+sSsDZqN2g4hDLxPtyVhs
         BKavPM82hwIKuWtcDrgZzXefxGkEoQbfL9+dASDR5ZQW0wOUZri79QRZk4H3VA1eE+3L
         TIYmrJM0jOFWcFennfWyEpeEAb/+EN6OoqnNWZAWWW9pW6pj/gcVY91OhmG99gmBLTK4
         JCn0ZxL41pPSXkMxYkNUUJcjIgICGvLZ9pKNdB3cW4bzngwHuKQQRASe3coQamU1ia8X
         55rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JuSRvJuyVghuriGBXIxziVD7uudys6jv6caxpa93ooE=;
        b=ac7xDzUbYEjzz6klFpTnGfeBfN0p9G9AhaWiCn1sQ42GKLRmvYdxsYAc4do1YyQBXB
         4ae6FvqwPwnoCwYGAEH/EAp/+U50IelANyjziUhgLL46k5lsua/X180cijEGuJxZbpKN
         TQfQke8O8+PuQEi4Rcoprct5u1RpS3KTbQO3LIoPzEphlqeZxorpNs4cERvKxE2KNBVh
         h3ynMrFjzZ8hA5RocZMocCwlC9aufRL+gzrBqwOw0ws4o6jLYZgfc89Dwi25PVD93LgT
         CDClTKi2lMIyACfzPdL/Kpj46AkpoHlltbCqbM2yco8lXK0wMpLam91IFQARQiOlnZwV
         wycw==
X-Gm-Message-State: APjAAAW9YC2b8Hzp/n4VuUiiiN1G6FOjClONmUPDkFbFLJVZCS9m3kY7
        o21C1E3CJiyXHnoSNXqy968DGGpLXx83/IbItac=
X-Google-Smtp-Source: APXvYqyGRiTm0j2kIiRQus8R71623OkZyqP2Am/hpFKYOQZFfOR0PeAro2DvfhxR7ZUwNv40m+SWMleXeBhVQ5MC25E=
X-Received: by 2002:a81:3797:: with SMTP id e145mr53714691ywa.25.1559159016346;
 Wed, 29 May 2019 12:43:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190529174318.22424-1-amir73il@gmail.com> <20190529174318.22424-10-amir73il@gmail.com>
In-Reply-To: <20190529174318.22424-10-amir73il@gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 29 May 2019 22:43:25 +0300
Message-ID: <CAOQ4uxiGqiFuz+H8YQgU_2JnVWve+NVcY4Gxi_+ym-Gq6G9xAQ@mail.gmail.com>
Subject: Re: [PATCH v3 09/13] ceph: copy_file_range needs to strip setuid bits
 and update timestamps
To:     "Yan, Zheng" <zyan@redhat.com>, Ilya Dryomov <idryomov@gmail.com>
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

Hi Zheng and Ilya,

Could we help us get an ACK on this patch.
It is a prerequisite for merging the cross-device copy_file_range work.

It depends on a new helper introduced here:
https://lore.kernel.org/linux-fsdevel/CAOQ4uxjbcSWX1hUcuXbn8hFH3QYB+5bAC9Z1yCwJdR=T-GGtCg@mail.gmail.com/T/#m1569878c41f39fac3aadb3832a30659c323b582a

Luis Henriques has tested (the previous revision of) this work on ceph.

Thanks,
Amir,

On Wed, May 29, 2019 at 8:43 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> Because ceph doesn't hold destination inode lock throughout the copy,
> strip setuid bits before and after copy.
>
> The destination inode mtime is updated before and after the copy and the
> source inode atime is updated after the copy, similar to the filesystem
> ->read_iter() implementation.
>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  fs/ceph/file.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> index e87f7b2023af..8a70708e1aca 100644
> --- a/fs/ceph/file.c
> +++ b/fs/ceph/file.c
> @@ -1947,6 +1947,15 @@ static ssize_t __ceph_copy_file_range(struct file *src_file, loff_t src_off,
>                 goto out;
>         }
>
> +       /* Should dst_inode lock be held throughout the copy operation? */
> +       inode_lock(dst_inode);
> +       ret = file_modified(dst_file);
> +       inode_unlock(dst_inode);
> +       if (ret < 0) {
> +               dout("failed to modify dst file before copy (%zd)\n", ret);
> +               goto out;
> +       }
> +
>         /*
>          * We need FILE_WR caps for dst_ci and FILE_RD for src_ci as other
>          * clients may have dirty data in their caches.  And OSDs know nothing
> @@ -2097,6 +2106,14 @@ static ssize_t __ceph_copy_file_range(struct file *src_file, loff_t src_off,
>  out:
>         ceph_free_cap_flush(prealloc_cf);
>
> +       file_accessed(src_file);
> +       /* To be on the safe side, remove privs also after copy */
> +       inode_lock(dst_inode);
> +       err = file_modified(dst_file);
> +       inode_unlock(dst_inode);
> +       if (err < 0)
> +               dout("failed to modify dst file after copy (%zd)\n", err);
> +
>         return ret;
>  }
>
> --
> 2.17.1
>
