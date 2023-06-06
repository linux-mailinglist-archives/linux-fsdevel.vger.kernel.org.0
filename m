Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2AD47241DE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jun 2023 14:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233262AbjFFMRd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Jun 2023 08:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232007AbjFFMRb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Jun 2023 08:17:31 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA9B110C3;
        Tue,  6 Jun 2023 05:17:29 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4f63006b4e3so1622070e87.1;
        Tue, 06 Jun 2023 05:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686053848; x=1688645848;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fYdG+l24N7nOPPkYzvC1dMPw8hRed5xRsohavReXDVA=;
        b=ifo4a8IwMqTUyoJn9aC/S0EWxW8hyiaPUl/x4fVjRobnkH9VQWXlqGCKd0B7rFdPh/
         v8GTkSr7uCgYV0C0FK0LiJM95+2ieVUfv8NL5CWYVur+XMHguEjKJnjVOX/N4BsPoisu
         EQrCT7jxo9FDnbh9f5YCy9HWDCx4/h48YdrALffbDrZyAsbmrpsM27+raeHl4BfuPlxr
         UO7XVO/Rn6G5Ckj20eQ3iNDwYaRlSmU2ePkeOI2s/efSq10v65gLIx5+10hovJiTgL9b
         2M6ZHenUAvmSYz79fqo5IVDi3yG3GOIYNEBKJ65hZ5Cg24nOGQeJyM3o0NcCxCDfIoRK
         Dx3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686053848; x=1688645848;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fYdG+l24N7nOPPkYzvC1dMPw8hRed5xRsohavReXDVA=;
        b=OM363g5wmxGCA6L5zhr6jLjj5CEikJQ1UUOqIATOkeHUmDIDnwIh1cPW+mLomu+1w+
         /NeEND4SnMsx0APsbHN9YlhDuNXoW5yFTNtGMcARH1WWsAd6EalcjK9M3yYAyHC/hI7u
         /4nVI4Rlttt4fLpl340UHp/LBRIr99erPxA4xkUVh/KTiUlMOo+cg2MBoPxsxI5HJnIV
         nKrHrscuYFITPxuz2Eh/JB+TyxEDPOOsH7BIdZ4x/Qw+ITxilFQ3QlAezvxM79K6fyg4
         yXnBuw6+jOV2IFijFFlIFUxByCEBO3i1EiXzxMAItdHDdQWAbg91NJT+xmXMfSkjTjmY
         mTJQ==
X-Gm-Message-State: AC+VfDweIZiFHmeznfb+08knAa2tHJFotd4BTfAkxYeoyCKs3/ZoWOHW
        5aN9q9xZF/7VTslsuqUxc45YL2iFf+F39s1yQEQ=
X-Google-Smtp-Source: ACHHUZ4AAeFf0lhDH/3FNs4BrtjrfNhgGfmAvgwNdLdhY8vNRg6fELk9qIjAiYCEVH1w9WWN+zFveWKbTZjJVN+x6yg=
X-Received: by 2002:a2e:8514:0:b0:2b1:c501:5124 with SMTP id
 j20-20020a2e8514000000b002b1c5015124mr1383698lji.51.1686053847591; Tue, 06
 Jun 2023 05:17:27 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1685900733.git.ritesh.list@gmail.com>
In-Reply-To: <cover.1685900733.git.ritesh.list@gmail.com>
From:   =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Date:   Tue, 6 Jun 2023 14:17:13 +0200
Message-ID: <CAHpGcM+xTevu0LaJvaPrF-M3bEDvicUqqY5MPD6z2VuMO9vRWw@mail.gmail.com>
Subject: Re: [PATCHv6 0/5] iomap: Add support for per-block dirty state to
 improve write performance
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Ritesh,

Am Mo., 5. Juni 2023 um 03:33 Uhr schrieb Ritesh Harjani (IBM)
<ritesh.list@gmail.com>:
> Hello All,
>
> Please find PATCHv6 which adds per-block dirty tracking to iomap.
> As discussed earlier this is required to improve write performance and reduce
> write amplification for cases where either blocksize is less than pagesize (such
> as Power platform with 64k pagesize) or when we have a large folio (such as xfs
> which currently supports large folio).
>
> RFCv5 -> PATCHv6:
> =================
> 1. Addresses review comments from Brian, Christoph and Matthew.
>    @Christoph:
>      - I have renamed the higher level functions such as iop_alloc/iop_free() to
>        iomap_iop_alloc/free() in v6.
>      - As for the low level bitmap accessor functions I couldn't find any better
>        naming then iop_test_/set/clear_**. I could have gone for
>        iomap_iop__test/set/clear/_** or iomap__iop_test/set/clear_**, but
>        I wasn't convinced with either of above as it also increases function
>        name.
>        Besides iop_test/set_clear_ accessors functions for uptodate and dirty
>        status tracking make sense as we are sure we have a valid iop in such
>        cases. Please do let me know if this looks ok to you.
> 2. I tried testing gfs2 (initially with no patches) with xfstests. But I always ended up
>    in some or the other deadlock (I couldn't spend any time debugging that).
>    I also ran it with -x log, but still it was always failing for me.
>    @Andreas:
>    - could you please suggest how can I test gfs2 with these patches. I see gfs2
>      can have a smaller blocksize and it uses iomap buffered io path. It will be
>      good if we can get these patches tested on it too.

here's a minimal list of tests we're running automatically on a daily basis:

https://gitlab.com/redhat/centos-stream/tests/kernel/kernel-tests/-/blob/main/filesystems/xfs/xfstests/RUNTESTS.gfs2

Please note that function inode_to_wb() in <linux/backing-dev.h>
includes some asserts that are active when CONFIG_LOCKDEP is enabled.
Those asserts will cause every single fstest to fail. So either
disable CONFIG_LOCKDEP or remove the asserts in inode_to_wb() for now.

Thanks,
Andreas

> 3. I can now say I have run some good amount of fstests on these patches on
>    these platforms and I haven't found any new failure in my testing so far.
>    arm64 (64k pagesize): with 4k -g quick
>    Power: with 4k -g auto
>    x86: 1k, 4k with -g auto and adv_auto
>
> From my testing so far these patches looks stable to me and if this looks good
> to reviewers as well, do you think this can be queued to linux-next for wider
> testing?
>
> Performance numbers copied from last patch commit message
> ==================================================
> Performance testing of below fio workload reveals ~16x performance
> improvement using nvme with XFS (4k blocksize) on Power (64K pagesize)
> FIO reported write bw scores improved from around ~28 MBps to ~452 MBps.
>
> 1. <test_randwrite.fio>
> [global]
>         ioengine=psync
>         rw=randwrite
>         overwrite=1
>         pre_read=1
>         direct=0
>         bs=4k
>         size=1G
>         dir=./
>         numjobs=8
>         fdatasync=1
>         runtime=60
>         iodepth=64
>         group_reporting=1
>
> [fio-run]
>
> 2. Also our internal performance team reported that this patch improves
>    their database workload performance by around ~83% (with XFS on Power)
>
> Ritesh Harjani (IBM) (5):
>   iomap: Rename iomap_page_create/release() to iomap_iop_alloc/free()
>   iomap: Move folio_detach_private() in iomap_iop_free() to the end
>   iomap: Refactor some iop related accessor functions
>   iomap: Allocate iop in ->write_begin() early
>   iomap: Add per-block dirty state tracking to improve performance
>
>  fs/gfs2/aops.c         |   2 +-
>  fs/iomap/buffered-io.c | 309 ++++++++++++++++++++++++++++++-----------
>  fs/xfs/xfs_aops.c      |   2 +-
>  fs/zonefs/file.c       |   2 +-
>  include/linux/iomap.h  |   1 +
>  5 files changed, 235 insertions(+), 81 deletions(-)
>
> --
> 2.40.1
>
