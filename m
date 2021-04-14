Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99A9635F380
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Apr 2021 14:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350841AbhDNMXO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Apr 2021 08:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233262AbhDNMXN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Apr 2021 08:23:13 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C9BC061574;
        Wed, 14 Apr 2021 05:22:52 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id s14so5341827pjl.5;
        Wed, 14 Apr 2021 05:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fyIUblUREgMH1vb1P+kh4YcjWxhnRZRiMGz8M+UIb9g=;
        b=Fq58+T3DCGR4/jwmuM8Jny5dImQvCvlG7t5OUfv60hf0QlHKNw1UP/4CP4obY67TPI
         FqzBp0FdUN+vHntCMNQlQNiTB05hQtPi05RqoGkzMVWHXcl4C8t3Hh4oJjBWlq7tq4Js
         xx4zqAnLN/42y4hLZm/yQvwehD8jZeXjJuInnJCoZ2SeTizhV1nL+LKeSW1EskMHZZdB
         XxnUQ8J2ExbXXOgIp9ZlAZ4zQb3ptqdf7PhH5yu9fuiVwSUFhmNOStBItqE+BtPgbpGe
         Nb+3cDX40Bfs6Ca5L3Z8Y4X9c2V2OpCUzJ6ADtSG8dStSgTg7G70p9zZUhbhPTuTFDB8
         EsQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fyIUblUREgMH1vb1P+kh4YcjWxhnRZRiMGz8M+UIb9g=;
        b=mBHPE6Inn3UqM4hhsKQUBbh6NMGbxIvqbgWwsxF8NQ9xnwx/BJDaC+7eTuADThN5xU
         z46H0IyNhX73X3OOiD/7ZlZQjWyieKeRFPQ4O+YAGd5I79ucqOQAeByIKoDcqV+mUJxx
         482+dq65Ho33Q5/cwf0Xe7/f+B3njOZr1DIVG3YwTQCe1KA5la7+Sn491B8uM/yXjgkj
         7lAgw+VUL1XVKLguuNDB9FDXKt9PQG41MxdOVHi2QJOq8PmunNUAO4kPwbsDRryv/MuL
         vy7z+7ISxmI8OwndWa8UvbnXICCTuKosx+XUR6XW7/AooKJ8APZv/pGguVogAAkcEqVg
         DlVg==
X-Gm-Message-State: AOAM5339Vk4TxBx092Tt4GuvwecgcjSjuHvkknMRBDp5rL6MdoPNS66e
        9mubOMnSWxii+l0BJQOtgCS74/opVllKByyt1a5z1rfmhvI=
X-Google-Smtp-Source: ABdhPJxsxeOA9hb+Sdt/BuvZqyQPXTIpMaWfp64w9rw1O6w3J0aDEDSpgcE8wvDVjW5MKTM7hYKf3uLxs/Gv5jxR9vY=
X-Received: by 2002:a17:90b:b03:: with SMTP id bf3mr3363221pjb.223.1618402971848;
 Wed, 14 Apr 2021 05:22:51 -0700 (PDT)
MIME-Version: 1.0
References: <807bb470f90bae5dcd80a29020d38f6b5dd6ef8e.1616826872.git.baolin.wang@linux.alibaba.com>
 <f72f28cd-06b5-fb84-c7ce-ad1a3d14c016@linux.alibaba.com> <CAJfpegtJ6100CS34+MSi8Rn_NMRGHw5vxbs+fOHBBj8GZLEexw@mail.gmail.com>
In-Reply-To: <CAJfpegtJ6100CS34+MSi8Rn_NMRGHw5vxbs+fOHBBj8GZLEexw@mail.gmail.com>
From:   Peng Tao <bergwolf@gmail.com>
Date:   Wed, 14 Apr 2021 20:22:40 +0800
Message-ID: <CA+a=Yy4Ea6Vn7md2KxGc_Tkxx04Ck-JCBL7qz-JWecJ9W2nT_g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] fuse: Fix possible deadlock when writing back
 dirty pages
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        Peng Tao <tao.peng@linux.alibaba.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 13, 2021 at 5:42 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Mon, Apr 12, 2021 at 3:23 PM Baolin Wang
> <baolin.wang@linux.alibaba.com> wrote:
> >
> > Hi Miklos,
> >
> > =E5=9C=A8 2021/3/27 14:36, Baolin Wang =E5=86=99=E9=81=93:
> > > We can meet below deadlock scenario when writing back dirty pages, an=
d
> > > writing files at the same time. The deadlock scenario can be reproduc=
ed
> > > by:
> > >
> > > - A writeback worker thread A is trying to write a bunch of dirty pag=
es by
> > > fuse_writepages(), and the fuse_writepages() will lock one page (name=
d page 1),
> > > add it into rb_tree with setting writeback flag, and unlock this page=
 1,
> > > then try to lock next page (named page 2).
> > >
> > > - But at the same time a file writing can be triggered by another pro=
cess B,
> > > to write several pages by fuse_perform_write(), the fuse_perform_writ=
e()
> > > will lock all required pages firstly, then wait for all writeback pag=
es
> > > are completed by fuse_wait_on_page_writeback().
> > >
> > > - Now the process B can already lock page 1 and page 2, and wait for =
page 1
> > > waritehack is completed (page 1 is under writeback set by process A).=
 But
> > > process A can not complete the writeback of page 1, since it is still
> > > waiting for locking page 2, which was locked by process B already.
> > >
> > > A deadlock is occurred.
> > >
> > > To fix this issue, we should make sure each page writeback is complet=
ed
> > > after lock the page in fuse_fill_write_pages() separately, and then w=
rite
> > > them together when all pages are stable.
> > >
> > > [1450578.772896] INFO: task kworker/u259:6:119885 blocked for more th=
an 120 seconds.
> > > [1450578.796179] kworker/u259:6  D    0 119885      2 0x00000028
> > > [1450578.796185] Workqueue: writeback wb_workfn (flush-0:78)
> > > [1450578.796188] Call trace:
> > > [1450578.798804]  __switch_to+0xd8/0x148
> > > [1450578.802458]  __schedule+0x280/0x6a0
> > > [1450578.806112]  schedule+0x34/0xe8
> > > [1450578.809413]  io_schedule+0x20/0x40
> > > [1450578.812977]  __lock_page+0x164/0x278
> > > [1450578.816718]  write_cache_pages+0x2b0/0x4a8
> > > [1450578.820986]  fuse_writepages+0x84/0x100 [fuse]
> > > [1450578.825592]  do_writepages+0x58/0x108
> > > [1450578.829412]  __writeback_single_inode+0x48/0x448
> > > [1450578.834217]  writeback_sb_inodes+0x220/0x520
> > > [1450578.838647]  __writeback_inodes_wb+0x50/0xe8
> > > [1450578.843080]  wb_writeback+0x294/0x3b8
> > > [1450578.846906]  wb_do_writeback+0x2ec/0x388
> > > [1450578.850992]  wb_workfn+0x80/0x1e0
> > > [1450578.854472]  process_one_work+0x1bc/0x3f0
> > > [1450578.858645]  worker_thread+0x164/0x468
> > > [1450578.862559]  kthread+0x108/0x138
> > > [1450578.865960] INFO: task doio:207752 blocked for more than 120 sec=
onds.
> > > [1450578.888321] doio            D    0 207752 207740 0x00000000
> > > [1450578.888329] Call trace:
> > > [1450578.890945]  __switch_to+0xd8/0x148
> > > [1450578.894599]  __schedule+0x280/0x6a0
> > > [1450578.898255]  schedule+0x34/0xe8
> > > [1450578.901568]  fuse_wait_on_page_writeback+0x8c/0xc8 [fuse]
> > > [1450578.907128]  fuse_perform_write+0x240/0x4e0 [fuse]
> > > [1450578.912082]  fuse_file_write_iter+0x1dc/0x290 [fuse]
> > > [1450578.917207]  do_iter_readv_writev+0x110/0x188
> > > [1450578.921724]  do_iter_write+0x90/0x1c8
> > > [1450578.925598]  vfs_writev+0x84/0xf8
> > > [1450578.929071]  do_writev+0x70/0x110
> > > [1450578.932552]  __arm64_sys_writev+0x24/0x30
> > > [1450578.936727]  el0_svc_common.constprop.0+0x80/0x1f8
> > > [1450578.941694]  el0_svc_handler+0x30/0x80
> > > [1450578.945606]  el0_svc+0x10/0x14
> > >
> > > Suggested-by: Peng Tao <tao.peng@linux.alibaba.com>
> > > Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> >
> > Do you have any comments for this patch set? Thanks.
>
> Hi,
>
> I guess this is related:
>
> https://lore.kernel.org/linux-fsdevel/20210209100115.GB1208880@miu.pilisc=
saba.redhat.com/
>
> Can you verify that the patch at the above link fixes your issue?
>
Hi Miklos,

Copying the referred patch here for better discussion.

> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -1117,17 +1117,12 @@ static ssize_t fuse_send_write_pages(str
>       count =3D ia->write.out.size;
>       for (i =3D 0; i < ap->num_pages; i++) {
>               struct page *page =3D ap->pages[i];
> +             bool page_locked =3D ap->page_locked && (i =3D=3D ap->num_p=
ages - 1);
Any reason for just handling the last locked page in the page array?
To be specific, it look like the first page in the array can also be
partial dirty and locked?

>
> -             if (!err && !offset && count >=3D PAGE_SIZE)
> -                     SetPageUptodate(page);
> -
> -             if (count > PAGE_SIZE - offset)
> -                     count -=3D PAGE_SIZE - offset;
> -             else
> -                     count =3D 0;
> -             offset =3D 0;
> -
> -             unlock_page(page);
> +             if (err)
> +                     ClearPageUptodate(page);
> +             if (page_locked)
> +                     unlock_page(page);
>               put_page(page);
>       }
>
> @@ -1191,6 +1186,16 @@ static ssize_t fuse_fill_write_pages(str
>               if (offset =3D=3D PAGE_SIZE)
>                       offset =3D 0;
>
> +             /* If we copied full page, mark it uptodate */
> +             if (tmp =3D=3D PAGE_SIZE)
> +                     SetPageUptodate(page);
> +
> +             if (PageUptodate(page)) {
> +                     unlock_page(page);
> +             } else {
> +                     ap->page_locked =3D true;
> +                     break;
> +             }
Is it possible to still have two pages locked before we start to issue
WRITEs? The deadlock found by Baolin is a stable page handling issue
between fuse_fill_write_pages() and write_cache_pages(). It seems that
as long as we ever lock two or more pages at the same time during
fuse_fill_write_pages(), the race window is there since
write_cache_pages() can set the PG_DIRTY on one page and block locking
the others, whereas fuse_fill_write_pages() can lock all related pages
and block waiting for writeback.

To illustrate the deadlock:

write_cache_pages()                             fuse_perform_write()
lock page A
set PG_DIRTY on page A
                                                              lock
page A and page B in fuse_fill_write_pages()
                                                              wait for
page A and page B writeback in fuse_send_write_pages()
lock page B

Then write_cache_pages() is blocked waiting to lock page B, which page
B is locked by fuse_perform_write() waiting for page A to be written
back.

Cheers,
Tao


>               if (!fc->big_writes)
>                       break;



--=20
Into Sth. Rich & Strange
