Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51B174CC5D0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Mar 2022 20:14:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235860AbiCCTPI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Mar 2022 14:15:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235859AbiCCTPG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Mar 2022 14:15:06 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D77515B99F;
        Thu,  3 Mar 2022 11:14:17 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id kt27so12871492ejb.0;
        Thu, 03 Mar 2022 11:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MOPMhEIV3XBqtSikTY4+v1vOWvKvVs3Rd1CFsa26faY=;
        b=fR/x2GeKfTrG9900nwOrBgV5oSRy4W2QKTw4oL1vHBDVFBa38opaw7zkQ3fLU9TsLn
         ntWBKdfXvF11tgQtBZbED1QqD8NWDqW/TOsb7DrwQvr7xRz6vtmalgZ/qAUUM3D+CDkS
         N1fkOb8+Cymr61nGyH5KcFvnbZwcUu3vi3GeSOjkB6mo/uQ7Om7MZl+EReG1/3C5LSkM
         q3p7IDRiDte3vM4YjYfE8cNWe/XT65G0xlcAhzB4Dhre25tA5tRd0rMngqg+m0a5Vzw2
         t14HeSI0vcMIi8fZJHEMwEiN8FGnfbB/zqkhELp53IB4njYD2h3vskak5Xu9MvO70XbU
         cWRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MOPMhEIV3XBqtSikTY4+v1vOWvKvVs3Rd1CFsa26faY=;
        b=HvJ9PekAhE1fqD7dCbJ0yomfEu15BdLU6uo4wnKMlVeHyVpbf7K9HKgDv6LzDB3FIs
         x6oG9re648myuSv4nWGKSljwYvzWiiQeA0QiUPi5GVhBRkN0wUGhoSMgxjelpCvXB8X1
         vfYhmeruHzdG4Uu32sifVUrY9XkcAHSdqf4j3UrIzkmeHR39321FGXwr36ldebBOwYCt
         SxG7MDyuesw/hnah89o/R5So487zOOpmIlvkhWhfbEthjBO3E/jdEQfvulZfeMAOR4Sc
         UQ/lKMIHCPpISzM/30bhnyk8P7HcY6aqaKLvyzfNSbAzK3ueJIk8ZHcSpyKxqekTK0Cn
         rDbQ==
X-Gm-Message-State: AOAM531wycsq3szgGy8oZ0Xz/MBQrYebDkJFljNybLKCUSDGVoixuzDI
        Qr6FekGWsoVZkW6gj6jAbqsKSSv02uG7o6XmL0E=
X-Google-Smtp-Source: ABdhPJyQRfkxu/g6AA1xO+7oThr+yX8gEw6C/+hhhtZO3+lPLKAOC5cvmmD1Mk0guaV/AzzmFu6KIscF0rWwnMGoeGQ=
X-Received: by 2002:a17:906:e28a:b0:6d6:e2e9:d39d with SMTP id
 gg10-20020a170906e28a00b006d6e2e9d39dmr12350886ejb.2.1646334855632; Thu, 03
 Mar 2022 11:14:15 -0800 (PST)
MIME-Version: 1.0
References: <202203020034.2Ii9kTrs-lkp@intel.com> <6c8b9d6b-fc31-11d6-c5d4-c18b3854b4e9@huawei.com>
In-Reply-To: <6c8b9d6b-fc31-11d6-c5d4-c18b3854b4e9@huawei.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 3 Mar 2022 11:14:03 -0800
Message-ID: <CAHbLzkpUZLkgKXreGwNgpH8dwGZWe63KHSfnV-PO4Y8+VqdWyA@mail.gmail.com>
Subject: Re: [PATCH 4/8] mm: thp: only regular file could be THP eligible
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        Linux MM <linux-mm@kvack.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kbuild@lists.01.org, Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Rik van Riel <riel@surriel.com>,
        Matthew Wilcox <willy@infradead.org>, Zi Yan <ziy@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        darrick.wong@oracle.com
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

On Thu, Mar 3, 2022 at 3:48 AM Miaohe Lin <linmiaohe@huawei.com> wrote:
>
> On 2022/3/3 19:43, Dan Carpenter wrote:
> > Hi Yang,
> >
> > url:    https://github.com/0day-ci/linux/commits/Yang-Shi/Make-khugepaged-collapse-readonly-FS-THP-more-consistent/20220301-075903
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
> > config: arm64-randconfig-m031-20220227 (https://download.01.org/0day-ci/archive/20220302/202203020034.2Ii9kTrs-lkp@intel.com/config)
> > compiler: aarch64-linux-gcc (GCC) 11.2.0
> >
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> >
> > smatch warnings:
> > include/linux/huge_mm.h:179 file_thp_enabled() warn: variable dereferenced before check 'vma->vm_file' (see line 177)
> > mm/khugepaged.c:468 hugepage_vma_check() error: we previously assumed 'vma->vm_file' could be null (see line 455)
> > include/linux/huge_mm.h:179 file_thp_enabled() warn: variable dereferenced before check 'vma->vm_file' (see line 177)
> >
> > vim +179 include/linux/huge_mm.h
> >
> > 2224ed1155c07b Yang Shi     2022-02-28  175  static inline bool file_thp_enabled(struct vm_area_struct *vma)
> > 2224ed1155c07b Yang Shi     2022-02-28  176  {
> > 2224ed1155c07b Yang Shi     2022-02-28 @177   struct inode *inode = vma->vm_file->f_inode;
> >                                                                       ^^^^^^^^^^^^^^
> > Dereference.
> >
> > 2224ed1155c07b Yang Shi     2022-02-28  178
> > 2224ed1155c07b Yang Shi     2022-02-28 @179   return (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS)) && vma->vm_file &&
> >                                                                                                     ^^^^^^^^^^^^
> > Checked too late.
>
> Yep. We should check vma->vm_file first before we access vma->vm_file->f_inode.

Ah, yes, thanks for the report and the suggestion.

>
> Thanks.
>
> >
> > 2224ed1155c07b Yang Shi     2022-02-28  180          (vma->vm_flags & VM_EXEC) &&
> > 2224ed1155c07b Yang Shi     2022-02-28  181          !inode_is_open_for_write(inode) && S_ISREG(inode->i_mode);
> > 2224ed1155c07b Yang Shi     2022-02-28  182  }
> >
> > ---
> > 0-DAY CI Kernel Test Service, Intel Corporation
> > https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> >
> > .
> >
>
