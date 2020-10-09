Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15D512882F0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Oct 2020 08:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731165AbgJIGrA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Oct 2020 02:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbgJIGrA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Oct 2020 02:47:00 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A662C0613D2;
        Thu,  8 Oct 2020 23:47:00 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id y16so4121443ila.7;
        Thu, 08 Oct 2020 23:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=Ss/mXOR08e71a1QafBlk4YUgoJYs7qUy06tUnjygl1E=;
        b=nYEo05DKAAHxH9EsxvMqyCWl/OTquIEt5FJKgIakA2YKAkwqOxNWpA217tTOVtTv8B
         A0Kfu9d6J7o/YpY0OBoxFARGY3ow0EySgVAt7QCaQjF3tUAAl2rcAYn4GYrSQobK9D+Q
         4UMtJ4QxLQ7QNf0CwGD58QfQTYD0sSL0N9UkUR5xk3am8ZWpTkdDvPcnH9T8zPoyqUoE
         jhqwgs5dKXMpa/8/nPx4fgpaXfQnmPxf2FEqC2RG2J0d28u3UDiHd8b2yMOd+tgbkLnt
         Oxw8yDMhx3RD6bFzcVH7t8p38XO2IH8Tq3drfRULUwpNL0dmpkbEnWhsRCK1jD6ZAWEt
         C+Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=Ss/mXOR08e71a1QafBlk4YUgoJYs7qUy06tUnjygl1E=;
        b=d4AZtvdL3yzb2N2oHWcUg+XBWdfGCwcKwR3ZjndjnN4pclIPwigp7XeKHTql/zKu+R
         yaxtj0TfrHxX76b340hVCzXc/BVj5x2YFmRSGMGtXZBl5Qpx07f+0gNaAukKm7w2IZWD
         RCCeq+dbnegSFPqJyD38165SCqo/8HGS81vfSseEqhSw0VuSfbNpTEdxlmwkHdqUshcq
         +G4ZAvQ6mIhbjKP3dSozCNrLy3wVZqtGvymxShPIW/pmDxmKug1H/sZs74XmmvwkGvI1
         s6mH9obo7nLPvVc6LSr0axrwsmcYlCt4nYvEzaJNhzddPgfRiRS9qs+HabnySynoLsgX
         mxVQ==
X-Gm-Message-State: AOAM532SyR67+8yRvcotm1qfgw6fWQyJ8Kxfoqwg60tN338W4hrhauXy
        ble2HrpfT8uSLe3iiKaBd3mzHYTojuW3gAJ2XAU=
X-Google-Smtp-Source: ABdhPJzcFoTjvdGfC7xWgG3pZ3MTtN4c6VxXwxpU8mWxi5u0h8PWeTmC6KhON2GWgocS3gO85WAL5YhgUTs5G/sWRjU=
X-Received: by 2002:a92:9fc8:: with SMTP id z69mr8246401ilk.215.1602226019448;
 Thu, 08 Oct 2020 23:46:59 -0700 (PDT)
MIME-Version: 1.0
References: <af902b5db99e8b73980c795d84ad7bb417487e76.1602168865.git.riteshh@linux.ibm.com>
In-Reply-To: <af902b5db99e8b73980c795d84ad7bb417487e76.1602168865.git.riteshh@linux.ibm.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 9 Oct 2020 08:46:47 +0200
Message-ID: <CA+icZUVPXFkc7ow5-vF4bxggE63LqQkmaXA6m9cAZVCOnbS1fQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] ext4: Fix bs < ps issue reported with dioread_nolock
 mount opt
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tytso@mit.edu, jack@suse.cz, anju@linux.vnet.ibm.com,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 8, 2020 at 5:56 PM Ritesh Harjani <riteshh@linux.ibm.com> wrote:
>
> left shifting m_lblk by blkbits was causing value overflow and hence
> it was not able to convert unwritten to written extent.
> So, make sure we typecast it to loff_t before do left shift operation.
> Also in func ext4_convert_unwritten_io_end_vec(), make sure to initialize
> ret variable to avoid accidentally returning an uninitialized ret.
>
> This patch fixes the issue reported in ext4 for bs < ps with
> dioread_nolock mount option.
>
> Fixes: c8cc88163f40df39e50c ("ext4: Add support for blocksize < pagesize in dioread_nolock")

Fixes: tag should be 12 digits (see [1]).
( Seen while walking through ext-dev Git commits. )

- Sedat -

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst#n183

> Reported-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
> ---
>  fs/ext4/extents.c | 2 +-
>  fs/ext4/inode.c   | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index a0481582187a..32d610cc896d 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -4769,7 +4769,7 @@ int ext4_convert_unwritten_extents(handle_t *handle, struct inode *inode,
>
>  int ext4_convert_unwritten_io_end_vec(handle_t *handle, ext4_io_end_t *io_end)
>  {
> -       int ret, err = 0;
> +       int ret = 0, err = 0;
>         struct ext4_io_end_vec *io_end_vec;
>
>         /*
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index bf596467c234..3021235deaa1 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -2254,7 +2254,7 @@ static int mpage_process_page(struct mpage_da_data *mpd, struct page *page,
>                                         err = PTR_ERR(io_end_vec);
>                                         goto out;
>                                 }
> -                               io_end_vec->offset = mpd->map.m_lblk << blkbits;
> +                               io_end_vec->offset = (loff_t)mpd->map.m_lblk << blkbits;
>                         }
>                         *map_bh = true;
>                         goto out;
> --
> 2.26.2
>
