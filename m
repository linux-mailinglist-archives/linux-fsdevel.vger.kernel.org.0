Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41BE53628F7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Apr 2021 21:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243916AbhDPT4t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Apr 2021 15:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243842AbhDPT4m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Apr 2021 15:56:42 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC0DC061756
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Apr 2021 12:56:17 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id l4so43756814ejc.10
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Apr 2021 12:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l12BmPzjPGQPhOVAK1+pGnVg6YOohJn2PXow4I2KCwo=;
        b=nQnk4fUrtR73OTn0Bked0GsH77E4CU2Aryt7NrztyQzLtex0tRik3lEi7dybmcBzRH
         imUnySkDeWbLpm1SmLfQ939xsEAUlHIlrHZFouijtfVnEwwG/v4ZQfXaj+HSc8sr43j+
         v+8FG6MhnCm6G5B8vHIVVyp4FpcXRY7PYCkB9DDvlM+eVLprbZBp++dJAbMAVMCt5SYF
         q/qG9Xpz56IlrdEJbFFzzSPDCCvk4OjPw1eqpC1um+tl/xs3BG0Rvpm0vl3JBc7b9mtP
         P0H2tUoAEcqxONVhFCzFwaQG92PxbLWuDF0PKMf+1CmUgDTeVky9AKb8XU42U9NOfxiW
         nrZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l12BmPzjPGQPhOVAK1+pGnVg6YOohJn2PXow4I2KCwo=;
        b=HJ6u+fw7lfVgWRm0OqL2SLyozmE+ikizu2Iia9W/IVLSr33R12DlOiRgyLDi0eaSWy
         tL4wf8tmYW4UauAQKIl4AYNvOKqkBBplCqqCx2WqqtCS7Yi13RJLlH/qvEyE0apZxB5o
         jLxX7y4FOoEVtE2P/0wEYfo8cgtRVmh86MAL+aCfymQyII6r3oWDeqy+lnsiMFXylWzg
         +J2BqVGu8EbgaN+Efj6d57XsSkujHj9blBhBkaOoZC0o/HkI9/iVDOP/Jo7+Hvcou/eu
         f/GsGhPFckBekROAIv7YbyJll7inXWhW19fCZMDPK/V5Tcsyby7w1BmPRugp1EIH/9Ac
         n+XQ==
X-Gm-Message-State: AOAM532gu0XW8Xk2NhcxTFfw1oDPcmez2Z6hJ1XCsDmFoIPImGjSNcTH
        BLvWTy1BAuIRWTZnF36lSZOuIm1akIXC4IjFRI4dhg==
X-Google-Smtp-Source: ABdhPJyQvyIq/sIJGlqAF2MfMI37oI2jAKdM4rT3dS8JIUJ3W5auOyWaYVKZc/Khipbuc/aofSL7uwOHc1OwxgnwwFo=
X-Received: by 2002:a17:907:7631:: with SMTP id jy17mr9952113ejc.418.1618602976235;
 Fri, 16 Apr 2021 12:56:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210416173524.GA1379987@redhat.com>
In-Reply-To: <20210416173524.GA1379987@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 16 Apr 2021 12:56:05 -0700
Message-ID: <CAPcyv4h77oTMBQ50wg6eHLpkFMQ16oAHg2+D=d5zshT6iWgAfw@mail.gmail.com>
Subject: Re: [PATCH] dax: Fix missed wakeup in put_unlocked_entry()
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Linux fsdevel mailing list <linux-fsdevel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        virtio-fs-list <virtio-fs@redhat.com>,
        Sergio Lopez <slp@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 16, 2021 at 10:35 AM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> I am seeing missed wakeups which ultimately lead to a deadlock when I am
> using virtiofs with DAX enabled and running "make -j". I had to mount
> virtiofs as rootfs and also reduce to dax window size to 32M to reproduce
> the problem consistently.
>
> This is not a complete patch. I am just proposing this partial fix to
> highlight the issue and trying to figure out how it should be fixed.
> Should it be fixed in generic dax code or should filesystem (fuse/virtiofs)
> take care of this.
>
> So here is the problem. put_unlocked_entry() wakes up waiters only
> if entry is not null as well as !dax_is_conflict(entry). But if I
> call multiple instances of invalidate_inode_pages2() in parallel,
> then I can run into a situation where there are waiters on
> this index but nobody will wait these.
>
> invalidate_inode_pages2()
>   invalidate_inode_pages2_range()
>     invalidate_exceptional_entry2()
>       dax_invalidate_mapping_entry_sync()
>         __dax_invalidate_entry() {
>                 xas_lock_irq(&xas);
>                 entry = get_unlocked_entry(&xas, 0);
>                 ...
>                 ...
>                 dax_disassociate_entry(entry, mapping, trunc);
>                 xas_store(&xas, NULL);
>                 ...
>                 ...
>                 put_unlocked_entry(&xas, entry);
>                 xas_unlock_irq(&xas);
>         }
>
> Say a fault in in progress and it has locked entry at offset say "0x1c".
> Now say three instances of invalidate_inode_pages2() are in progress
> (A, B, C) and they all try to invalidate entry at offset "0x1c". Given
> dax entry is locked, all tree instances A, B, C will wait in wait queue.
>
> When dax fault finishes, say A is woken up. It will store NULL entry
> at index "0x1c" and wake up B. When B comes along it will find "entry=0"
> at page offset 0x1c and it will call put_unlocked_entry(&xas, 0). And
> this means put_unlocked_entry() will not wake up next waiter, given
> the current code. And that means C continues to wait and is not woken
> up.
>
> In my case I am seeing that dax page fault path itself is waiting
> on grab_mapping_entry() and also invalidate_inode_page2() is
> waiting in get_unlocked_entry() but entry has already been cleaned
> up and nobody woke up these processes. Atleast I think that's what
> is happening.
>
> This patch wakes up a process even if entry=0. And deadlock does not
> happen. I am running into some OOM issues, that will debug.
>
> So my question is that is it a dax issue and should it be fixed in
> dax layer. Or should it be handled in fuse to make sure that
> multiple instances of invalidate_inode_pages2() on same inode
> don't make progress in parallel and introduce enough locking
> around it.
>
> Right now fuse_finish_open() calls invalidate_inode_pages2() without
> any locking. That allows it to make progress in parallel to dax
> fault path as well as allows multiple instances of invalidate_inode_pages2()
> to run in parallel.
>
> Not-yet-signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> ---
>  fs/dax.c |    7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> Index: redhat-linux/fs/dax.c
> ===================================================================
> --- redhat-linux.orig/fs/dax.c  2021-04-16 12:50:40.141363317 -0400
> +++ redhat-linux/fs/dax.c       2021-04-16 12:51:42.385926390 -0400
> @@ -266,9 +266,10 @@ static void wait_entry_unlocked(struct x
>
>  static void put_unlocked_entry(struct xa_state *xas, void *entry)
>  {
> -       /* If we were the only waiter woken, wake the next one */
> -       if (entry && !dax_is_conflict(entry))
> -               dax_wake_entry(xas, entry, false);
> +       if (dax_is_conflict(entry))
> +               return;
> +
> +       dax_wake_entry(xas, entry, false);

How does this work if entry is NULL? dax_entry_waitqueue() will not
know if it needs to adjust the index. I think the fix might be to
specify that put_unlocked_entry() in the invalidate path needs to do a
wake_up_all().
