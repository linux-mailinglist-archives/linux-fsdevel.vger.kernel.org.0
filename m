Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D65335DA89
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Apr 2021 10:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243811AbhDMI6K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Apr 2021 04:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbhDMI6J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Apr 2021 04:58:09 -0400
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32329C061574
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Apr 2021 01:57:50 -0700 (PDT)
Received: by mail-vk1-xa2a.google.com with SMTP id k12so140403vkn.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Apr 2021 01:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=D5uDSu+GYJjaWPoe8h3mJwhd/DcJYP150YgFVzspmgY=;
        b=b5yrKS8aPr7bTDMX8mH6+Fq/epKx0YSIK5VkWKmOEGzqNx1gi8KL4KpK7134yf//KU
         b+PIbkJKISKmcsa8P63lCkdZvcRD7Tm7bkWsOOwW7h/QogtNhJgfMBk+qv0qkdJ3uKjx
         1F6YXdE1YQLUxBOIE0719ILXx67GO1Y9s6OMs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=D5uDSu+GYJjaWPoe8h3mJwhd/DcJYP150YgFVzspmgY=;
        b=T3WskEGmcDjBxLMVGP8WhbRW+aC2RsZmKAtPzJPCTYzfIDxACWxUfi4U5sBBXT4La3
         j0HcNJbkG1qF8uYeY96xNxWaOEx75+C2MeNhMRZHyAMW2/n4EDfkyXTFwuTWh20PozUb
         GSKrcWtlrcI2bf1+UUp/ZShypm3m4r4Jns11TsSAl/oAmJyZmoLuoN4s2kEmkCL8t1IQ
         vV7wYhEi3dN4M1P+zr895MFPEWO3ObyQCl6F6RYE64T83f8oYLGwBHbrhp87V7z4m6f0
         HbdZVPA+Ler90SbZI5+U+VCGVPvJeYhRKb9qACXoaPZiTx3w96H+Ubrt3Q267yeI0lUF
         4ODw==
X-Gm-Message-State: AOAM5328wyNSXzP0O3yOkwRzXJrHi+aBILsDExMN/vospyll1Sl3l1AB
        NGmXlhHOeyCtdN1I4gk5qE3RUyseNv/dKTIfpp7hKA==
X-Google-Smtp-Source: ABdhPJyXnwG9a5aRq35LnL98GQ/xhaxSugwAWCGB7jsjYQHAgQtsfd2JmppOJRFQWhoLc3//9s0nwlZvs4qJvkH/CHA=
X-Received: by 2002:a1f:4ec3:: with SMTP id c186mr22566430vkb.11.1618304269218;
 Tue, 13 Apr 2021 01:57:49 -0700 (PDT)
MIME-Version: 1.0
References: <807bb470f90bae5dcd80a29020d38f6b5dd6ef8e.1616826872.git.baolin.wang@linux.alibaba.com>
 <f72f28cd-06b5-fb84-c7ce-ad1a3d14c016@linux.alibaba.com>
In-Reply-To: <f72f28cd-06b5-fb84-c7ce-ad1a3d14c016@linux.alibaba.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 13 Apr 2021 10:57:38 +0200
Message-ID: <CAJfpegtJ6100CS34+MSi8Rn_NMRGHw5vxbs+fOHBBj8GZLEexw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] fuse: Fix possible deadlock when writing back
 dirty pages
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     Peng Tao <tao.peng@linux.alibaba.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 12, 2021 at 3:23 PM Baolin Wang
<baolin.wang@linux.alibaba.com> wrote:
>
> Hi Miklos,
>
> =E5=9C=A8 2021/3/27 14:36, Baolin Wang =E5=86=99=E9=81=93:
> > We can meet below deadlock scenario when writing back dirty pages, and
> > writing files at the same time. The deadlock scenario can be reproduced
> > by:
> >
> > - A writeback worker thread A is trying to write a bunch of dirty pages=
 by
> > fuse_writepages(), and the fuse_writepages() will lock one page (named =
page 1),
> > add it into rb_tree with setting writeback flag, and unlock this page 1=
,
> > then try to lock next page (named page 2).
> >
> > - But at the same time a file writing can be triggered by another proce=
ss B,
> > to write several pages by fuse_perform_write(), the fuse_perform_write(=
)
> > will lock all required pages firstly, then wait for all writeback pages
> > are completed by fuse_wait_on_page_writeback().
> >
> > - Now the process B can already lock page 1 and page 2, and wait for pa=
ge 1
> > waritehack is completed (page 1 is under writeback set by process A). B=
ut
> > process A can not complete the writeback of page 1, since it is still
> > waiting for locking page 2, which was locked by process B already.
> >
> > A deadlock is occurred.
> >
> > To fix this issue, we should make sure each page writeback is completed
> > after lock the page in fuse_fill_write_pages() separately, and then wri=
te
> > them together when all pages are stable.
> >
> > [1450578.772896] INFO: task kworker/u259:6:119885 blocked for more than=
 120 seconds.
> > [1450578.796179] kworker/u259:6  D    0 119885      2 0x00000028
> > [1450578.796185] Workqueue: writeback wb_workfn (flush-0:78)
> > [1450578.796188] Call trace:
> > [1450578.798804]  __switch_to+0xd8/0x148
> > [1450578.802458]  __schedule+0x280/0x6a0
> > [1450578.806112]  schedule+0x34/0xe8
> > [1450578.809413]  io_schedule+0x20/0x40
> > [1450578.812977]  __lock_page+0x164/0x278
> > [1450578.816718]  write_cache_pages+0x2b0/0x4a8
> > [1450578.820986]  fuse_writepages+0x84/0x100 [fuse]
> > [1450578.825592]  do_writepages+0x58/0x108
> > [1450578.829412]  __writeback_single_inode+0x48/0x448
> > [1450578.834217]  writeback_sb_inodes+0x220/0x520
> > [1450578.838647]  __writeback_inodes_wb+0x50/0xe8
> > [1450578.843080]  wb_writeback+0x294/0x3b8
> > [1450578.846906]  wb_do_writeback+0x2ec/0x388
> > [1450578.850992]  wb_workfn+0x80/0x1e0
> > [1450578.854472]  process_one_work+0x1bc/0x3f0
> > [1450578.858645]  worker_thread+0x164/0x468
> > [1450578.862559]  kthread+0x108/0x138
> > [1450578.865960] INFO: task doio:207752 blocked for more than 120 secon=
ds.
> > [1450578.888321] doio            D    0 207752 207740 0x00000000
> > [1450578.888329] Call trace:
> > [1450578.890945]  __switch_to+0xd8/0x148
> > [1450578.894599]  __schedule+0x280/0x6a0
> > [1450578.898255]  schedule+0x34/0xe8
> > [1450578.901568]  fuse_wait_on_page_writeback+0x8c/0xc8 [fuse]
> > [1450578.907128]  fuse_perform_write+0x240/0x4e0 [fuse]
> > [1450578.912082]  fuse_file_write_iter+0x1dc/0x290 [fuse]
> > [1450578.917207]  do_iter_readv_writev+0x110/0x188
> > [1450578.921724]  do_iter_write+0x90/0x1c8
> > [1450578.925598]  vfs_writev+0x84/0xf8
> > [1450578.929071]  do_writev+0x70/0x110
> > [1450578.932552]  __arm64_sys_writev+0x24/0x30
> > [1450578.936727]  el0_svc_common.constprop.0+0x80/0x1f8
> > [1450578.941694]  el0_svc_handler+0x30/0x80
> > [1450578.945606]  el0_svc+0x10/0x14
> >
> > Suggested-by: Peng Tao <tao.peng@linux.alibaba.com>
> > Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>
> Do you have any comments for this patch set? Thanks.

Hi,

I guess this is related:

https://lore.kernel.org/linux-fsdevel/20210209100115.GB1208880@miu.piliscsa=
ba.redhat.com/

Can you verify that the patch at the above link fixes your issue?

Thanks,
Miklos
