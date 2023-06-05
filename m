Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB6F7223EF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jun 2023 12:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbjFEKz2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Jun 2023 06:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231624AbjFEKzX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Jun 2023 06:55:23 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1445B102;
        Mon,  5 Jun 2023 03:55:16 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-39a3f26688bso3917665b6e.2;
        Mon, 05 Jun 2023 03:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685962515; x=1688554515;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8C8WF6ddBDwpJAR+KH7PzhmaMBctfUo/cmAqG5y8fZA=;
        b=n7WjGkLCLX9C6e9uY19szD4l8m5clnC2s4d4cXQwA5hWtM4SIGICeJ+2il9rKFZkWh
         7Tg+uMnQj0UcnRJBN5MyPQeCcMnyKi9dZFeYzk43dKl4qyGPgBVi2K40JN+SDhRbf1YS
         YuwUmafRojFojYLEYnfPi+hgCDvY6J6NErSuwsUlj/jSIs59hPs1OZmqJy2CNjNNrfyM
         lM5jp2Hsx62ek+IILgmtU+TJ47RqLDriA1m6EfdtH4NqFm1AxXrq9Xw+v/bWvqqzvKd0
         TMXe4CD2W1erEorPT1n6NkZxaCTKqMs6FN+SXykow+ddmbFelFZsp1KTPIYvCYZRj6zO
         nSIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685962515; x=1688554515;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8C8WF6ddBDwpJAR+KH7PzhmaMBctfUo/cmAqG5y8fZA=;
        b=XJu0Mqk9R91ssD3PNN9uUxeU0OmEYP3pMMp9bxLLcLxZtq+FQnrjtDYuBIsDeRaafc
         Be30ecXgfpm8IEHwXpMaprx+zjTbgORNwPixhGwKxFExqgEqLSin57fduTqvrkf2iAOM
         OVRoNfFJLv/UxlEtQE9uqM+hAg3LiU0J24nF+cLVFfITZOxkNq0CCJkH+H57GyqRJvG3
         5/HWpGWVAlVwuMJaSpH4m9SnOuI6CXeA9I8w/qhnT509KJH2EwZLs5ndITQ780tM6TY9
         zV47fJnizpONcq0XUOF4hdJEilFZCjaDvGMZG2tY7I4ntDlcNWs7LHfTUy4gQYwiBrGe
         +f+A==
X-Gm-Message-State: AC+VfDxSTEMJgShp1pa3WuGljOp57n+tPs4uDlF+W4Lr91Bm2PVIIPie
        Hc2+iwztKcytNriRZntx9/g/EcYPQdc=
X-Google-Smtp-Source: ACHHUZ7hdrgDRNVvc1BEnWju7m2mXasd2Pf/kBA7+8qPENtc5s5IIXAgsejcvCYXag54QekEunB4Vw==
X-Received: by 2002:aca:d11:0:b0:39a:bf0:4fe0 with SMTP id 17-20020aca0d11000000b0039a0bf04fe0mr7062358oin.15.1685962514919;
        Mon, 05 Jun 2023 03:55:14 -0700 (PDT)
Received: from dw-tp.c4p-in.ibmmobiledemo.com ([129.41.58.19])
        by smtp.gmail.com with ESMTPSA id q3-20020a17090311c300b001b0f727bc44sm6266883plh.16.2023.06.05.03.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 03:55:14 -0700 (PDT)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     linux-xfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCHv7 0/6] iomap: Add support for per-block dirty state to improve write performance
Date:   Mon,  5 Jun 2023 16:25:00 +0530
Message-Id: <cover.1685962158.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello All,

Please find PATCHv7 which adds per-block dirty tracking to iomap.
As discussed earlier this is required to improve write performance and reduce
write amplification for cases where either blocksize is less than pagesize (such
as Power platform with 64k pagesize) or when we have a large folio (such as xfs
which currently supports large folio).

Patchv6 -> Patchv7
==================
1. Fixed __maybe_unused annotation.
2. Added this patch-4
   iomap: Refactor iomap_write_delalloc_punch() function out

RFCv5 -> PATCHv6:
=================
1. Addresses review comments from Brian, Christoph and Matthew.
   @Christoph:
     - I have renamed the higher level functions such as iop_alloc/iop_free() to
       iomap_iop_alloc/free() in v6.
     - As for the low level bitmap accessor functions I couldn't find any better
       naming then iop_test_/set/clear_**. I could have gone for
       iomap_iop__test/set/clear/_** or iomap__iop_test/set/clear_**, but
       I wasn't convinced with either of above as it also increases function
       name.
       Besides iop_test/set_clear_ accessors functions for uptodate and dirty
       status tracking make sense as we are sure we have a valid iop in such
       cases. Please do let me know if this looks ok to you.
2. I tried testing gfs2 (initially with no patches) with xfstests. But I always ended up
   in some or the other deadlock (I couldn't spend any time debugging that).
   I also ran it with -x log, but still it was always failing for me.
   @Andreas:
   - could you please suggest how can I test gfs2 with these patches. I see gfs2
     can have a smaller blocksize and it uses iomap buffered io path. It will be
     good if we can get these patches tested on it too.

3. I can now say I have run some good amount of fstests on these patches on
   these platforms and I haven't found any new failure in my testing so far.
   arm64 (64k pagesize): with 4k -g quick
   Power: with 4k -g auto
   x86: 1k, 4k with -g auto and adv_auto

From my testing so far these patches looks stable to me and if this looks good
to reviewers as well, do you think this can be queued to linux-next for wider
testing?

Performance numbers copied from last patch commit message
==================================================
Performance testing of below fio workload reveals ~16x performance
improvement using nvme with XFS (4k blocksize) on Power (64K pagesize)
FIO reported write bw scores improved from around ~28 MBps to ~452 MBps.

1. <test_randwrite.fio>
[global]
	ioengine=psync
	rw=randwrite
	overwrite=1
	pre_read=1
	direct=0
	bs=4k
	size=1G
	dir=./
	numjobs=8
	fdatasync=1
	runtime=60
	iodepth=64
	group_reporting=1

[fio-run]

2. Also our internal performance team reported that this patch improves
   their database workload performance by around ~83% (with XFS on Power)


Ritesh Harjani (IBM) (6):
  iomap: Rename iomap_page_create/release() to iomap_iop_alloc/free()
  iomap: Move folio_detach_private() in iomap_iop_free() to the end
  iomap: Refactor some iop related accessor functions
  iomap: Refactor iomap_write_delalloc_punch() function out
  iomap: Allocate iop in ->write_begin() early
  iomap: Add per-block dirty state tracking to improve performance

 fs/gfs2/aops.c         |   2 +-
 fs/iomap/buffered-io.c | 312 ++++++++++++++++++++++++++++++-----------
 fs/xfs/xfs_aops.c      |   2 +-
 fs/zonefs/file.c       |   2 +-
 include/linux/iomap.h  |   1 +
 5 files changed, 236 insertions(+), 83 deletions(-)

--
2.40.1

