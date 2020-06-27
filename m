Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3CC20C0C3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jun 2020 12:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbgF0Kbp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 27 Jun 2020 06:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbgF0Kbp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 27 Jun 2020 06:31:45 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8ACCC03E979;
        Sat, 27 Jun 2020 03:31:44 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id w9so10549476ilk.13;
        Sat, 27 Jun 2020 03:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=hBYoEvRRpXyGXqyyyK+UUmgCSVK6/vU+GBKDP/WjSog=;
        b=WPbYFm8LkOEQ491lr6WUlHUx16k0jFw8yAAedERvFPkMZRQYu10ksjg9pFFKLIByzC
         hgyOgBwVWOkvUt89+lmwMJmfw5eHkEXd0bIrQWenwWXrk+sO0QbnNKQmijnRPWYsvwPC
         wo3X8XTVZ8GdwgqdAL6m2wgJWYZlEq9OMqnES/DXosyoE/5NAneEtupy4AVlwQC7Rn9Z
         iL/2oik8A3XFKaA5x2Yq7qXbdYMn1wuj0W0enSXkrRVXVbBvAidxxZTOMpkgyI6/hdxl
         eov8Dpv6qqHrK+b3+vjt5iZ6YPTt2p3jdQn7W4GvbTaqDKuCUevci8iCXqxiejv+ADSB
         OaSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=hBYoEvRRpXyGXqyyyK+UUmgCSVK6/vU+GBKDP/WjSog=;
        b=ZeT8LqeiVQqhxltXRcrLxfxJNho/2cGJWDUOP+F4tCH8H76bdeTFO8/HfPu75b6xkI
         QEjgNH++hvbnYvkUpSJCQNIUJ4oax9zVgZnD/TnJWiXoa6ZIscWt7OHYTnlEGhAFb5Ud
         S7mcWpMH0sQ8ckDVrtgp3XurFno3E5Q+jr+FWWEaXYEo31I9hqDotzwriStHVLK4IUfz
         B90v2LP5PcviCD2qjGTOq/7RBucAV9sBzxooEbGUANB3EnNFfHb/ketbwpCZbxSKcjXC
         N+LGshYgx+XZ1lfpSWGCa8aR966p/bgRmDIwxfGR++DAYupWC/vAEv3LjKALyQAbH7IN
         EgCA==
X-Gm-Message-State: AOAM531fff3Au3EbQc1xyPwzZhz8i241zZVMlWhT27pwAGhVZ7jzIMVj
        qvUfETjaHd8oL5zkzoZopSI2TxVvs6s/b5B9yGHuaRtrI4w=
X-Google-Smtp-Source: ABdhPJz5AyJtabGAW8xkxuzMwsBOaBn/dnqc6WDQFkSkcopWOOO+69r5vU0f2n59M+r8ti12ivIoPmjiBO+Qs1hiMcg=
X-Received: by 2002:a05:6e02:92:: with SMTP id l18mr7060839ilm.212.1593253904114;
 Sat, 27 Jun 2020 03:31:44 -0700 (PDT)
MIME-Version: 1.0
References: <2733b41a-b4c6-be94-0118-a1a8d6f26eec@virtuozzo.com> <d6e8ef46-c311-b993-909c-4ae2823e2237@virtuozzo.com>
In-Reply-To: <d6e8ef46-c311-b993-909c-4ae2823e2237@virtuozzo.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sat, 27 Jun 2020 12:31:51 +0200
Message-ID: <CA+icZUUad6Nk_ezhY5vcuVox41Eg120fELf5Kh_E1FCKhpv4Nw@mail.gmail.com>
Subject: Re: [PATCH] fuse_writepages_fill() optimization to avoid WARN_ON in tree_insert
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
        Maxim Patlasov <maximvp@gmail.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 25, 2020 at 11:52 AM Vasily Averin <vvs@virtuozzo.com> wrote:
>
> In current implementation fuse_writepages_fill() tries to share the code:
> for new wpa it calls tree_insert() with num_pages = 0
> then switches to common code used non-modified num_pages
> and increments it at the very end.
>
> Though it triggers WARN_ON(!wpa->ia.ap.num_pages) in tree_insert()
>  WARNING: CPU: 1 PID: 17211 at fs/fuse/file.c:1728 tree_insert+0xab/0xc0 [fuse]
>  RIP: 0010:tree_insert+0xab/0xc0 [fuse]
>  Call Trace:
>   fuse_writepages_fill+0x5da/0x6a0 [fuse]
>   write_cache_pages+0x171/0x470
>   fuse_writepages+0x8a/0x100 [fuse]
>   do_writepages+0x43/0xe0
>
> This patch re-works fuse_writepages_fill() to call tree_insert()
> with num_pages = 1 and avoids its subsequent increment and
> an extra spin_lock(&fi->lock) for newly added wpa.
>
> Fixes: 6b2fb79963fb ("fuse: optimize writepages search")

Hi Vasily,

I have cherry-picked commit 6b2fb79963fb ("fuse: optimize writepages
search") on top of Linux v5.7.

Tested against Linux v5.7.6 with your triple patchset together (I
guess the triple belongs together?):

$ git log --oneline v5.7..
0b26115de7aa (HEAD -> for-5.7/fuse-writepages-optimization-vvs)
fuse_writepages ignores errors from fuse_writepages_fill
687be6184c30 fuse_writepages_fill: simplified "if-else if" constuction
8d8e2e5d90c0 fuse_writepages_fill() optimization to avoid WARN_ON in tree_insert
cd4e568ca924 (for-5.7/fuse-writepages-optimization) fuse: optimize
writepages search

Unsure if your single patches should be labeled with:

"fuse:" or "fuse: writepages:" or "fuse: writepages_fill:"

It is common to use present tense not past tense in the subject line.
I found one typo in one subject line.

Example (understand this as suggestions):
1/3: fuse: writepages: Avoid WARN_ON in tree_insert in fuse_writepages_fill
2/3: fuse: writepages: Simplif*y* "if-else if" const*r*uction
3/3: fuse: writepages: Ignore errors from fuse_writepages_fill

Unsure how to test your patchset.
My usecase with fuse is to mount and read from the root.disk (loop,
ext4) of a WUBI-installation of Ubuntu/precise 12.04-LTS.

root@iniza# mount -r -t auto /dev/sda2 /mnt/win7
root@iniza# cd /path/to/root.disk
root@iniza# mount -r -t ext4 -o loop ./root.disk /mnt/ubuntu

BTW, your patchset is bullet-proof with Clang version 11.0.0-git IAS
(Integrated Assembler).

If you send a v2 please add my:

Tested-by: Sedat Dilek <sedat.dilek@gmail.com> # build+boot; Linux
v5.7.6 with clang-11 (IAS)

Can you send a (git) cover-letter if this is a patchset - next time?

Thanks.

Regards,
- Sedat -




> Reported-by: kernel test robot <rong.a.chen@intel.com>
> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
> ---
>  fs/fuse/file.c | 56 +++++++++++++++++++++++++++++---------------------------
>  1 file changed, 29 insertions(+), 27 deletions(-)
>
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index e573b0c..cf267bd 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -1966,10 +1966,9 @@ static bool fuse_writepage_in_flight(struct fuse_writepage_args *new_wpa,
>         struct fuse_writepage_args *old_wpa;
>         struct fuse_args_pages *new_ap = &new_wpa->ia.ap;
>
> -       WARN_ON(new_ap->num_pages != 0);
> +       WARN_ON(new_ap->num_pages != 1);
>
>         spin_lock(&fi->lock);
> -       rb_erase(&new_wpa->writepages_entry, &fi->writepages);
>         old_wpa = fuse_find_writeback(fi, page->index, page->index);
>         if (!old_wpa) {
>                 tree_insert(&fi->writepages, new_wpa);
> @@ -1977,7 +1976,6 @@ static bool fuse_writepage_in_flight(struct fuse_writepage_args *new_wpa,
>                 return false;
>         }
>
> -       new_ap->num_pages = 1;
>         for (tmp = old_wpa->next; tmp; tmp = tmp->next) {
>                 pgoff_t curr_index;
>
> @@ -2020,7 +2018,7 @@ static int fuse_writepages_fill(struct page *page,
>         struct fuse_conn *fc = get_fuse_conn(inode);
>         struct page *tmp_page;
>         bool is_writeback;
> -       int err;
> +       int index, err;
>
>         if (!data->ff) {
>                 err = -EIO;
> @@ -2083,44 +2081,48 @@ static int fuse_writepages_fill(struct page *page,
>                 wpa->next = NULL;
>                 ap->args.in_pages = true;
>                 ap->args.end = fuse_writepage_end;
> -               ap->num_pages = 0;
> +               ap->num_pages = 1;
>                 wpa->inode = inode;
> -
> -               spin_lock(&fi->lock);
> -               tree_insert(&fi->writepages, wpa);
> -               spin_unlock(&fi->lock);
> -
> +               index = 0;
>                 data->wpa = wpa;
> +       } else {
> +               index = ap->num_pages;
>         }
>         set_page_writeback(page);
>
>         copy_highpage(tmp_page, page);
> -       ap->pages[ap->num_pages] = tmp_page;
> -       ap->descs[ap->num_pages].offset = 0;
> -       ap->descs[ap->num_pages].length = PAGE_SIZE;
> +       ap->pages[index] = tmp_page;
> +       ap->descs[index].offset = 0;
> +       ap->descs[index].length = PAGE_SIZE;
>
>         inc_wb_stat(&inode_to_bdi(inode)->wb, WB_WRITEBACK);
>         inc_node_page_state(tmp_page, NR_WRITEBACK_TEMP);
>
>         err = 0;
> -       if (is_writeback && fuse_writepage_in_flight(wpa, page)) {
> -               end_page_writeback(page);
> -               data->wpa = NULL;
> -               goto out_unlock;
> +       if (is_writeback) {
> +               if (fuse_writepage_in_flight(wpa, page)) {
> +                       end_page_writeback(page);
> +                       data->wpa = NULL;
> +                       goto out_unlock;
> +               }
> +       } else if (!index) {
> +               spin_lock(&fi->lock);
> +               tree_insert(&fi->writepages, wpa);
> +               spin_unlock(&fi->lock);
>         }
> -       data->orig_pages[ap->num_pages] = page;
> -
> -       /*
> -        * Protected by fi->lock against concurrent access by
> -        * fuse_page_is_writeback().
> -        */
> -       spin_lock(&fi->lock);
> -       ap->num_pages++;
> -       spin_unlock(&fi->lock);
> +       data->orig_pages[index] = page;
>
> +       if (index) {
> +               /*
> +                * Protected by fi->lock against concurrent access by
> +                * fuse_page_is_writeback().
> +                */
> +               spin_lock(&fi->lock);
> +               ap->num_pages++;
> +               spin_unlock(&fi->lock);
> +       }
>  out_unlock:
>         unlock_page(page);
> -
>         return err;
>  }
>
> --
> 1.8.3.1
>
