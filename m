Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF324E321B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Mar 2022 21:59:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbiCUVAn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Mar 2022 17:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbiCUVAm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Mar 2022 17:00:42 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B57C403D7;
        Mon, 21 Mar 2022 13:59:16 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id bx5so14025422pjb.3;
        Mon, 21 Mar 2022 13:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IIUq70JYO9LLmND1+BslUpEoL6qaTZK16a7hVYB0QVM=;
        b=GndI/VxWim9/UZXk2q5afrDqn2qyfiunzh3+1Wi9X8fNS1w85Tf4ChDSAH8lNu5uUL
         oWYqa/jbEnaFBK81JDNc81tks7HXnDtf3AndRcwvNV9bSWWPsC4XzNwmnBsOEdkY0L1X
         BSUG7RROwOeVpU/tFDseuWll/YOx3hbAqIOScG1ZrCafa0FxC4cOZFUyKofji/UXVGZE
         FdsJxWWGaHKc+ZeWwRHhBQEb4MxhvniyoNYzNkXb1HCmR+ZLFFOcLbXYmMAGkuuYqiiQ
         4v3yAupeTJUIl3lUpmw43KqO20tcx9Zmm/IP2nvuGgT+hjVlPo1QRaBdT0e2fmiBIXjV
         tF+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IIUq70JYO9LLmND1+BslUpEoL6qaTZK16a7hVYB0QVM=;
        b=RBUXKlp5L2IowEYcQGNXmnZvQ4rtDLYcdKICVOmMEuLMxmO+vpnbeT9jJ33fV7ugsr
         TFKrdi/mgw6pJtbD9zEc4OI4sHUZeC0+kpLufsNFlg7mkAt9av+Jo14soNzjzvbRjp8M
         ngQi42rRIiaf98qO8s+wtMtscoA8xNbwz10u+qBcNikp0EnYEZpBNycjJgHiakkEkKwL
         a84lOulBs03J+RCQP4aYk9SDCZHWNU+JZ1zz82M33jZ5tRmZ1RtDPj8izdxSSe3wzOH5
         bXXFMi+d3x5xhd6VPr8IH+wlxgZBY68jd2u9oz4XJWGZBTzRYS2ROGaBfs+/05RzIOSW
         6vBA==
X-Gm-Message-State: AOAM530Qj70tzzhYA2leYaomF8fNceqVBGRLqckaqg2/d1zhWUvw1VSz
        u+7UhbiFQHfwEilv7RrVzPFDtA2ifr4Bh8OOGec8MgM3
X-Google-Smtp-Source: ABdhPJyBLvSja91CZSb9b1UipjcC7dfke8iT6LTMlxKJcStOuDIKqmTw96VUrfGKcbTdWt/JgXkudAetfH8E4lRL998=
X-Received: by 2002:a17:903:124a:b0:151:99fe:1a10 with SMTP id
 u10-20020a170903124a00b0015199fe1a10mr14532689plh.87.1647896356123; Mon, 21
 Mar 2022 13:59:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220317234827.447799-1-shy828301@gmail.com> <20220317234827.447799-4-shy828301@gmail.com>
 <YjhpxDKJFtztdTCb@ip-172-31-19-208.ap-northeast-1.compute.internal>
In-Reply-To: <YjhpxDKJFtztdTCb@ip-172-31-19-208.ap-northeast-1.compute.internal>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 21 Mar 2022 13:59:04 -0700
Message-ID: <CAHbLzkpZVJ0L1rVQdZEeLq6s9H9DSPQVKdHz626uHk2z0Mw7uw@mail.gmail.com>
Subject: Re: [v2 PATCH 3/8] mm: khugepaged: skip DAX vma
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Song Liu <songliubraving@fb.com>,
        Rik van Riel <riel@surriel.com>,
        Matthew Wilcox <willy@infradead.org>, Zi Yan <ziy@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        darrick.wong@oracle.com, Linux MM <linux-mm@kvack.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 21, 2022 at 5:04 AM Hyeonggon Yoo <42.hyeyoo@gmail.com> wrote:
>
> On Thu, Mar 17, 2022 at 04:48:22PM -0700, Yang Shi wrote:
> > The DAX vma may be seen by khugepaged when the mm has other khugepaged
> > suitable vmas.  So khugepaged may try to collapse THP for DAX vma, but
> > it will fail due to page sanity check, for example, page is not
> > on LRU.
> >
> > So it is not harmful, but it is definitely pointless to run khugepaged
> > against DAX vma, so skip it in early check.
>
> in fs/xfs/xfs_file.c:
> 1391 STATIC int
> 1392 xfs_file_mmap(
> 1393         struct file             *file,
> 1394         struct vm_area_struct   *vma)
> 1395 {
> 1396         struct inode            *inode = file_inode(file);
> 1397         struct xfs_buftarg      *target = xfs_inode_buftarg(XFS_I(inode));
> 1398
> 1399         /*
> 1400          * We don't support synchronous mappings for non-DAX files and
> 1401          * for DAX files if underneath dax_device is not synchronous.
> 1402          */
> 1403         if (!daxdev_mapping_supported(vma, target->bt_daxdev))
> 1404                 return -EOPNOTSUPP;
> 1405
> 1406         file_accessed(file);
> 1407         vma->vm_ops = &xfs_file_vm_ops;
> 1408         if (IS_DAX(inode))
> 1409                 vma->vm_flags |= VM_HUGEPAGE;
>
> Are xfs and other filesystems setting VM_HUGEPAGE flag even if it can
> never be collapsed?

DAX is available or intended to use on some special devices, for
example, persistent memory. Collapsing huge pages on such devices is
not the intended usecase of khugepaged.

>
> 1410         return 0;
> 1411 }
>
>
> > Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
> > Signed-off-by: Yang Shi <shy828301@gmail.com>
> > ---
> >  mm/khugepaged.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index 82c71c6da9ce..a0e4fa33660e 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -448,6 +448,10 @@ static bool hugepage_vma_check(struct vm_area_struct *vma,
> >       if (vm_flags & VM_NO_KHUGEPAGED)
> >               return false;
> >
> > +     /* Don't run khugepaged against DAX vma */
> > +     if (vma_is_dax(vma))
> > +             return false;
> > +
> >       if (vma->vm_file && !IS_ALIGNED((vma->vm_start >> PAGE_SHIFT) -
> >                               vma->vm_pgoff, HPAGE_PMD_NR))
> >               return false;
> > --
> > 2.26.3
> >
> >
>
> --
> Thank you, You are awesome!
> Hyeonggon :-)
