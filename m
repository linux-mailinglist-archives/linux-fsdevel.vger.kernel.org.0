Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC4B8BDBD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2019 17:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbfHMPxW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Aug 2019 11:53:22 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:46775 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbfHMPxW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Aug 2019 11:53:22 -0400
Received: by mail-ua1-f67.google.com with SMTP id b41so3741332uad.13;
        Tue, 13 Aug 2019 08:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=9QfVCdEceGaKcUHTjyCVyYLM6lUUMnaY36J5ldvpecg=;
        b=r0VkBPDoFjs/vrMk9XdxacXo7nUFQfzd25zP2gBWjIYklm7qD0gYak5GjseWOGvH+9
         FZfjxou4QlmBhr39o/YCg0xDh5IWDB4JgrojDTt6F7AURliEHfdAD/usDaURxvGcdn4N
         DeX7lfR+TTmiOBgSTt7VJbb86jcd0MoSJAlZr7EWMXfOPnHXoqrhljoBOeLsINcR7+PY
         DvMmJItAnWPlFFIMumlF3Rp1OUq5HxOT03HOc4rkaO0HEnkQ1P+5Yr21xUJ34pIQ8vDs
         TJDSHNOnWm87Vl7UIlNU8p+tvQAdmL7hwWxeNhpquIoqW39Jft2iC+ypDi+C1V5C15Uo
         l7YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=9QfVCdEceGaKcUHTjyCVyYLM6lUUMnaY36J5ldvpecg=;
        b=OAyJi0Y9NpZ5Ja1yJDFK4x6DQRRF7u81xGKs/ca9I4tYnEKdg/Nt7FsRMnAxe7iusk
         CtJDktGExBPWyO2W+qhMnihMlbCXzRdA05RLYAXkE13IbY+59EJgmaac0fZMNme6X0FO
         BnIbHS2OUAi6TJK+3bYHUQ/Jvi4o85S0DoPDm9bAJTC2wwJWkOyHmugfTT6KV40mTyW/
         0mGHRqy1DhdsfNt24Yv6/VFBehBU4yanDmbNhkdl7PEARXEJfMRG+f1yDGD49ri/U1ow
         5sIcTMm5rCiBt96sFdN64DYq5aXODiMAd0M0Pp2iwXw/lRqKCgtGJSW9HGiQ2yRLYHIO
         V5lA==
X-Gm-Message-State: APjAAAW4rTQLbm9v5dFnAW3zCIUOI1aGZ5mNP6CwV6mWAdj5K9ZlI3g1
        gk5UHygsz6CPmyV/kh/1hylkL8BxqlirL8Gheww=
X-Google-Smtp-Source: APXvYqxi1hJGnkHgAhZT2ZUALCV/jE8njcE4NzNGhaAtJdCdYFycEUmBBoqSwHOxcPS+ZTiFXBzQH6eiELdr6o9KPgc=
X-Received: by 2002:ab0:1843:: with SMTP id j3mr16070032uag.83.1565711600450;
 Tue, 13 Aug 2019 08:53:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190813151434.GQ7138@magnolia>
In-Reply-To: <20190813151434.GQ7138@magnolia>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Tue, 13 Aug 2019 16:53:09 +0100
Message-ID: <CAL3q7H6bL1DO-3mAk5yPncVF62=ehStz7kZMTYK_4nXQ1H3k-A@mail.gmail.com>
Subject: Re: [PATCH v3] vfs: fix page locking deadlocks when deduping files
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Dave Chinner <david@fromorbit.com>,
        xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 13, 2019 at 4:15 PM Darrick J. Wong <darrick.wong@oracle.com> w=
rote:
>
> From: Darrick J. Wong <darrick.wong@oracle.com>
>
> When dedupe wants to use the page cache to compare parts of two files
> for dedupe, we must be very careful to handle locking correctly.  The
> current code doesn't do this.  It must lock and unlock the page only
> once if the two pages are the same, since the overlapping range check
> doesn't catch this when blocksize < pagesize.  If the pages are distinct
> but from the same file, we must observe page locking order and lock them
> in order of increasing offset to avoid clashing with writeback locking.
>
> Fixes: 876bec6f9bbfcb3 ("vfs: refactor clone/dedupe_file_range common fun=
ctions")
> Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
> Reviewed-by: Bill O'Donnell <billodo@redhat.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

We actually had the same bug in btrfs, before we had cloning/dedupe in
vfs/xfs/etc, and fixed it back in 2017 [1].
I totally missed this behaviour in the vfs helpers when I updated
btrfs to use them some months ago.
Thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3Db1517622f2524f531113b12c27b9a0ea69c38983


> ---
> v3: revalidate page after locking it
> v2: provide an unlock helper
> ---
>  fs/read_write.c |   50 ++++++++++++++++++++++++++++++++++++++++++-------=
-
>  1 file changed, 42 insertions(+), 8 deletions(-)
>
> diff --git a/fs/read_write.c b/fs/read_write.c
> index 1f5088dec566..da341eb3033c 100644
> --- a/fs/read_write.c
> +++ b/fs/read_write.c
> @@ -1811,10 +1811,7 @@ static int generic_remap_check_len(struct inode *i=
node_in,
>         return (remap_flags & REMAP_FILE_DEDUP) ? -EBADE : -EINVAL;
>  }
>
> -/*
> - * Read a page's worth of file data into the page cache.  Return the pag=
e
> - * locked.
> - */
> +/* Read a page's worth of file data into the page cache. */
>  static struct page *vfs_dedupe_get_page(struct inode *inode, loff_t offs=
et)
>  {
>         struct page *page;
> @@ -1826,10 +1823,32 @@ static struct page *vfs_dedupe_get_page(struct in=
ode *inode, loff_t offset)
>                 put_page(page);
>                 return ERR_PTR(-EIO);
>         }
> -       lock_page(page);
>         return page;
>  }
>
> +/*
> + * Lock two pages, ensuring that we lock in offset order if the pages ar=
e from
> + * the same file.
> + */
> +static void vfs_lock_two_pages(struct page *page1, struct page *page2)
> +{
> +       /* Always lock in order of increasing index. */
> +       if (page1->index > page2->index)
> +               swap(page1, page2);
> +
> +       lock_page(page1);
> +       if (page1 !=3D page2)
> +               lock_page(page2);
> +}
> +
> +/* Unlock two pages, being careful not to unlock the same page twice. */
> +static void vfs_unlock_two_pages(struct page *page1, struct page *page2)
> +{
> +       unlock_page(page1);
> +       if (page1 !=3D page2)
> +               unlock_page(page2);
> +}
> +
>  /*
>   * Compare extents of two files to see if they are the same.
>   * Caller must have locked both inodes to prevent write races.
> @@ -1867,10 +1886,25 @@ static int vfs_dedupe_file_range_compare(struct i=
node *src, loff_t srcoff,
>                 dest_page =3D vfs_dedupe_get_page(dest, destoff);
>                 if (IS_ERR(dest_page)) {
>                         error =3D PTR_ERR(dest_page);
> -                       unlock_page(src_page);
>                         put_page(src_page);
>                         goto out_error;
>                 }
> +
> +               vfs_lock_two_pages(src_page, dest_page);
> +
> +               /*
> +                * Now that we've locked both pages, make sure they still
> +                * represent the data we're interested in.  If not, someo=
ne
> +                * is invalidating pages on us and we lose.
> +                */
> +               if (src_page->mapping !=3D src->i_mapping ||
> +                   src_page->index !=3D srcoff >> PAGE_SHIFT ||
> +                   dest_page->mapping !=3D dest->i_mapping ||
> +                   dest_page->index !=3D destoff >> PAGE_SHIFT) {
> +                       same =3D false;
> +                       goto unlock;
> +               }
> +
>                 src_addr =3D kmap_atomic(src_page);
>                 dest_addr =3D kmap_atomic(dest_page);
>
> @@ -1882,8 +1916,8 @@ static int vfs_dedupe_file_range_compare(struct ino=
de *src, loff_t srcoff,
>
>                 kunmap_atomic(dest_addr);
>                 kunmap_atomic(src_addr);
> -               unlock_page(dest_page);
> -               unlock_page(src_page);
> +unlock:
> +               vfs_unlock_two_pages(src_page, dest_page);
>                 put_page(dest_page);
>                 put_page(src_page);
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
