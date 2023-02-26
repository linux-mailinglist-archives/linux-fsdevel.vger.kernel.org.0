Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93E466A33B8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Feb 2023 20:43:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjBZTnt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Feb 2023 14:43:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjBZTns (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Feb 2023 14:43:48 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36E93EFA0;
        Sun, 26 Feb 2023 11:43:46 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id c1so4679073plg.4;
        Sun, 26 Feb 2023 11:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EVjH0NZ96EeUmRRq/WHOpNN2cvDRagcV7ziMp/14lIg=;
        b=cx/ED6KyKh7BY6KTBowZ3dQH5QWCw3c1CSFTxWuCAQ9NYXs0urNJx36pHETq7bZijg
         mF1SWu4hZx6jHdC+m9H08zYFFTxYmUlzKdt+sDC6Y458n3gtzEaVsLufJSbDbv7rGuT0
         pW8Q1TN/FL1gRmZKLF7PeWIBEdclFyPRMiTGQhxizMyadJnsohfsKX5wtqP2eiI7P+tl
         FSSof0JDyhVz559XAppddK2rfmRYnrDk3ceZY0S6q5jji2RaMl0AT9ANsfX6QXHCsaIC
         oqCHRdQm/JuxBRZnsGNvVvZDG1pOqLmVFuDqO2r7AkQZPNjdbYVaqRIbGsN1ai2RU73R
         86Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EVjH0NZ96EeUmRRq/WHOpNN2cvDRagcV7ziMp/14lIg=;
        b=TJwuKC6ZyB3GNChlUkfBkpuwgDHsvMn0EbImO62hK2i6kHTHptrPv2PIgGSGS+fUSR
         YutsUVdDKz8fAnYXf1aiohvGSnhtZX9It/fQA6eImodBkJe+zJ28QBV1/0P5ab9hunbf
         EwuhZXU+8/26quQXYyjro8ozXCBY1WXFmBbRihQac3ZgZ4r09NNF32IoN/UCopuCAxym
         vwpk7PT6bTvrIj4jqFEIVz4XZcKqLVv/2zdDwNwZNI/8FlXh7OSeey+6xM4/ojB+aeob
         VqVeSK4twfclC+D+rhOmGhhXSTiRkiAaZTDVpmL1Rsec9yoer9Q1aJ38v8t7BP90ms6p
         oe8A==
X-Gm-Message-State: AO0yUKXxb3wCbn6rVHCtDMxCD1jfFiLulObGxxp8+LjKWiEFOQhHCF1S
        nKWsoq7D1TBVRWl4y0+zmB7ERl2HX4E=
X-Google-Smtp-Source: AK7set/nJosP2QoTsIgIXW+RemutQPtgo8QoxHmV2onuu+45KZzMY8FhESV7QMqdheHzXLn2qjIu0Q==
X-Received: by 2002:a05:6a20:3c90:b0:cb:a0e3:4598 with SMTP id b16-20020a056a203c9000b000cba0e34598mr22437130pzj.43.1677440625336;
        Sun, 26 Feb 2023 11:43:45 -0800 (PST)
Received: from rh-tp.. ([2406:7400:63:469f:eb50:3ffb:dc1b:2d55])
        by smtp.gmail.com with ESMTPSA id r15-20020a62e40f000000b00582f222f088sm2815606pfh.47.2023.02.26.11.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Feb 2023 11:43:44 -0800 (PST)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Ritesh Harjani <ritesh.list@gmail.com>
Subject: [RFCv3 0/3] iomap: Add support for subpage dirty state tracking to improve write performance
Date:   Mon, 27 Feb 2023 01:13:29 +0530
Message-Id: <cover.1677428794.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello All,

Please find the RFCv3 patchset which adds support for iomap subpage dirty state
tracking which improves write performance and should reduce the write
amplification problem on platforms with smaller filesystem blocksize compared
to pagesize.
E.g. On Power with 64k default pagesize and with 4k filesystem blocksize.

RFCv2 -> RFCv3
===============
1. Addressed review comments on adding accessor APIs for both uptodate and dirty
   iop bitmap. (todo-1 of rfcv2).
   Addressed few other review comments from Christoph & Matthew.
2. Performance testing of these patches reveal the same performance improvement
   i.e. the given fio workload shows 16x perf improvement on nvme drive.
   (completed todo-3 of rfcv2)
3. Addressed todo-4 of rfcv2

Few TODOs
===========
1. Test gfs2 and zonefs with these changes (todo-2 of rfcv2)
2. Look into todo-5 of rfcv2

xfstests testing with default options and 1k blocksize on x86 reveals no new
issues. Also didn't observe any surprises on Power with 4k blocksize.
(Please do suggest if there are any specific xfstests config options (for
xfs) which are good to get it tested for this patch series?)


Copy-Paste Cover letter of RFCv2
================================

RFC -> RFCv2
=============
1. One of the key fix in v2 is that earlier when the folio gets marked as dirty,
   we were never marking the bits dirty in iop bitmap.
   This patch adds support for iomap_dirty_folio() as new ->dirty_folio() aops
   callback, which sets the dirty bitmap in iop and later call filemap_dirty_folio().
   This was one of the review comment that was discussed in RFC.

2. One of the other key fix identified in testing was that iop structure could
   get allocated at the time of the writeback if the folio is uptodate.
   (since it can get freed during memory pressure or during
   truncate_inode_partial_folio() in case of large folio). This could then cause
   nothing to get written if we have not marked the necessary bits as dirty in
   iop->state[]. Patch-1 & Patch-3 takes care of that.

TODOs
======
1. I still need to work on macros which we could declare and use for easy
   reference to uptodate/dirty bits in iop->state[] bitmap (based on previous
   review comments).

2. Test xfstests on other filesystems which are using the iomap buffered write
   path (gfs2, zonefs).

3. Latest performance testing with this patch series (I am not expecting any
   surprises here. The perf improvements should be more or less similar to rfc).

4. To address one of the todo in Patch-3. I think I missed to address it and
   noticed it only now before sending. But it should be easily addressable.
   I can address it in the next revision along with others.

5. To address one of the other review comments like what happens with a large
   folio. Can we limit the size of bitmaps if the folio is too large e.g. > 2MB.

   [RH] - I can start looking into this area too, if we think these patches
   are looking good. My preference would be to work on todos 1-4 as part of this
   patch series and take up bitmap optimization as a follow-up work for next
   part. Please do let me know your thoughts and suggestions on this.

Note: I have done a 4k bs test with auto group on Power with 64k pagesize and
I haven't found any surprises. I am also running a full bench of all tests with
x86 and 1k blocksize, but it still hasn't completed. I can update the results
once it completes.

Also as we discussed, all the dirty and uptodate bitmap tracking code for
iomap_page's state[] bitmap, is still contained within iomap buffered-io.c file.

I would appreciate any review comments/feedback and help on this work i.e.
adding subpage size dirty tracking to reduce write amplification problem and
improve buffered write performance. Kindly note that w/o these patches,
below type of workload gets severly impacted.


Performance Results from RFC [1]:
=================================
1. Performance testing of below fio workload reveals ~16x performance
improvement on nvme with XFS (4k blocksize) on Power (64K pagesize)
FIO reported write bw scores, improved from ~28 MBps to ~452 MBps.

<test_randwrite.fio>
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

2. Also our internal performance team reported that this patch improves there
   database workload performance by around ~83% (with XFS on Power)

[1]: https://lore.kernel.org/linux-xfs/cover.1666928993.git.ritesh.list@gmail.com/


Ritesh Harjani (IBM) (3):
  iomap: Allocate iop in ->write_begin() early
  iomap: Change uptodate variable name to state
  iomap: Support subpage size dirty tracking to improve write performance

 fs/gfs2/aops.c         |   2 +-
 fs/iomap/buffered-io.c | 166 ++++++++++++++++++++++++++++++++++++-----
 fs/xfs/xfs_aops.c      |   2 +-
 fs/zonefs/super.c      |   2 +-
 include/linux/iomap.h  |   1 +
 5 files changed, 150 insertions(+), 23 deletions(-)

--
2.39.2

