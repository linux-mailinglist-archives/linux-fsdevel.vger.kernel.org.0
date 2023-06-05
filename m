Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B45C3721B79
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jun 2023 03:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbjFEBcK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 4 Jun 2023 21:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbjFEBcJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 4 Jun 2023 21:32:09 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEC91A1;
        Sun,  4 Jun 2023 18:32:08 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1b026657a6fso37545555ad.0;
        Sun, 04 Jun 2023 18:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685928728; x=1688520728;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rSZA2eRliE46TAZCl7u2/d8ZP2MbH7jghdES6MZCDJk=;
        b=owYheJdm0N0ShI3KbX42PVAZWaaG3OtOloENj3Zl+SZnkp7lKNSH5ULcy8v/erBDbP
         x9tkvtHm7kDA4sCHCxZhvfBFqYlQvtNUOikCuIupYu3MMr2JqCaNd4eZm+9CCG2xusd+
         LZIR+y4npWz/60l77Xw/WXqOuzcQWmw16FAAICT4o1M/K0ighwKrCRzwEF4wqmo8BaZY
         Vf6/KVQIE2cNVhbxg8SNtz198dC8/cC2OBiml2YwGQU9AmoS/UcPhXpPrL8bn5ADKWUU
         z1vQF7SuRbT5w0HkLTdqoVP+tzfj6LVW/ogATK3nmkF1WZehuZ6NuHxYpJGZ1LLp6In5
         o70Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685928728; x=1688520728;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rSZA2eRliE46TAZCl7u2/d8ZP2MbH7jghdES6MZCDJk=;
        b=H5NYS+v699IBv5dqOYNKUissFKSCfOP3cVLDNodvxoqVMm3ngvEBszY/SBjXDYlpR4
         J2IANu5/ZFOutF90GbczgSU25hbzZP5o4VIpvqrGOSkodpdHLv4bAU++10CQtmuz4aQ+
         +2pWWl4E1HBPFScQryUTHpu7Q63uB/UfkldkwXPcInQlnNuh2ilsNzXR3rT5MaaujIyb
         vFncltqXt8ExGYe69YBrO6wDNM0nyzkhxooNal+SkjGyPZGEwvw0eJFVBm/KEluhGkbs
         nU07kIj2I1R6edZ1y10HauOW4X94ti+/m/HLchOt+8LBOGxF80K27s89ylwISCrsVCL6
         hcbA==
X-Gm-Message-State: AC+VfDyLC8k61r0ge06IOySlHuQ+ATxUg6foNf2DgEmQnN4PKl+KoLwM
        bgBhgMAs0xsSM8xXB/V2LSD4G87EwzQ=
X-Google-Smtp-Source: ACHHUZ7/CFsaKk0X1nejmQYx3fwRpPBxSxAJqU57MDMZXUEZVPEv/kQHsKutJWqPHntPvBuDnhE42g==
X-Received: by 2002:a17:902:f68b:b0:1ab:7fb:aac1 with SMTP id l11-20020a170902f68b00b001ab07fbaac1mr8063463plg.24.1685928727738;
        Sun, 04 Jun 2023 18:32:07 -0700 (PDT)
Received: from dw-tp.ihost.com ([49.207.220.159])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902c14d00b001aaec7a2a62sm5209287plj.188.2023.06.04.18.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jun 2023 18:32:07 -0700 (PDT)
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
Subject: [PATCHv6 0/5] iomap: Add support for per-block dirty state to improve write performance
Date:   Mon,  5 Jun 2023 07:01:47 +0530
Message-Id: <cover.1685900733.git.ritesh.list@gmail.com>
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

Please find PATCHv6 which adds per-block dirty tracking to iomap.
As discussed earlier this is required to improve write performance and reduce
write amplification for cases where either blocksize is less than pagesize (such
as Power platform with 64k pagesize) or when we have a large folio (such as xfs
which currently supports large folio).

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

Ritesh Harjani (IBM) (5):
  iomap: Rename iomap_page_create/release() to iomap_iop_alloc/free()
  iomap: Move folio_detach_private() in iomap_iop_free() to the end
  iomap: Refactor some iop related accessor functions
  iomap: Allocate iop in ->write_begin() early
  iomap: Add per-block dirty state tracking to improve performance

 fs/gfs2/aops.c         |   2 +-
 fs/iomap/buffered-io.c | 309 ++++++++++++++++++++++++++++++-----------
 fs/xfs/xfs_aops.c      |   2 +-
 fs/zonefs/file.c       |   2 +-
 include/linux/iomap.h  |   1 +
 5 files changed, 235 insertions(+), 81 deletions(-)

--
2.40.1

