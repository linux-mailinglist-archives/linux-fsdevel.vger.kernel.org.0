Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F80B42542B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Oct 2021 15:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241577AbhJGNgZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Oct 2021 09:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241075AbhJGNgY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Oct 2021 09:36:24 -0400
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 446AAC061570
        for <linux-fsdevel@vger.kernel.org>; Thu,  7 Oct 2021 06:34:31 -0700 (PDT)
Received: by mail-ua1-x934.google.com with SMTP id c33so4280624uae.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Oct 2021 06:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jag9C+ogrZcxnbvlzXCV96tv+CXNE9JJxs7UZNJcVuY=;
        b=YPEEqVqncgDZE3eOkA9QLiJA/i4iA0W9YwPaz99zO6kRow3kMf036K9y4L5ulmXREu
         ZJ+XMgqDtE8jQNFq4SiulrFzWphUX+a4zhH3stha9Lt4cLuaXNJfpnwDN0TSCrbHNC4l
         5eukq3L/u0pJrD9i1pnR4NBIR94tVFkZ3ItWA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jag9C+ogrZcxnbvlzXCV96tv+CXNE9JJxs7UZNJcVuY=;
        b=HQYQcc2AVFOFxP9SL8kNAGO1ggqVwy0dh6Dn9w5IReoSBaGQ4eaRdjrDhC7IY6R7vO
         2KwCUN8IiOfXqq9CQ3BpG1BTINUggFUm25k3LJL8O0Rwu7GM0psm1FpJcrEU3ZDE6P5o
         mP6taHFCYOfaOmU1mDvWUuOs2i6lrKpLGi1S88LGjrNQSg5g4N6fd3yUjAJXmaYQnB6v
         lDSpaUGNAACh7iXrurVi2+EMc3rTje8KrF6UENyWNLaVsHis1VF6zn7tLUAR7U3P9sb4
         i9fjrIydU+2RT8/IoWEwFy2Yl29Ou44S9+voZ78jWovrknt57thPSN1a2rAE5xF2ohdY
         spUQ==
X-Gm-Message-State: AOAM530KctqjEER1y6gfAkLvy1qzxQrW/WcJKIDzVLx11MyuzSyzUfkv
        gkDUhqcFVy3d+vv9DJPFL6SM/RYMrodhkEyT6EyHjw==
X-Google-Smtp-Source: ABdhPJxmjP2DfCokChnQhrBqbnGAJg1mMD8fkSMMPRTM5OVXNmkABjNp26NlAezgaEUPb0poHEyD+5BZK060ZLWuQPQ=
X-Received: by 2002:a9f:234a:: with SMTP id 68mr4384005uae.13.1633613670429;
 Thu, 07 Oct 2021 06:34:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210923130814.140814-1-cgxu519@mykernel.net> <20210923130814.140814-7-cgxu519@mykernel.net>
 <CAJfpeguqj2vst4Zj5EovSktJkXiDSCSWY=X12X0Yrz4M8gPRmQ@mail.gmail.com>
 <17c5aba1fef.c5c03d5825886.6577730832510234905@mykernel.net>
 <CAJfpegtr1NkOiY9YWd1meU1yiD-LFX-aB55UVJs94FrX0VNEJQ@mail.gmail.com> <17c5adfe5ea.12f1be94625921.4478415437452327206@mykernel.net>
In-Reply-To: <17c5adfe5ea.12f1be94625921.4478415437452327206@mykernel.net>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 7 Oct 2021 15:34:19 +0200
Message-ID: <CAJfpegt4jZpSCXGFk2ieqUXVm3m=ng7QtSzZp2bXVs07bfrbXg@mail.gmail.com>
Subject: Re: [RFC PATCH v5 06/10] ovl: implement overlayfs' ->write_inode operation
To:     Chengguang Xu <cgxu519@mykernel.net>
Cc:     Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 7 Oct 2021 at 15:10, Chengguang Xu <cgxu519@mykernel.net> wrote:
>  > However that wasn't what I was asking about.  AFAICS ->write_inode()
>  > won't start write back for dirty pages.   Maybe I'm missing something,
>  > but there it looks as if nothing will actually trigger writeback for
>  > dirty pages in upper inode.
>  >
>
> Actually, page writeback on upper inode will be triggered by overlayfs ->writepages and
> overlayfs' ->writepages will be called by vfs writeback function (i.e writeback_sb_inodes).

Right.

But wouldn't it be simpler to do this from ->write_inode()?

I.e. call write_inode_now() as suggested by Jan.

Also could just call mark_inode_dirty() on the overlay inode
regardless of the dirty flags on the upper inode since it shouldn't
matter and results in simpler logic.

Thanks,
Miklos


>
> Thanks,
> Chengguang
>
>
>
