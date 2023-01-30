Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88ECA68161C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jan 2023 17:14:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236741AbjA3QO5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Jan 2023 11:14:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237377AbjA3QOw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Jan 2023 11:14:52 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 240FF2136;
        Mon, 30 Jan 2023 08:14:51 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id t12-20020a17090aae0c00b00229f4cff534so13577212pjq.1;
        Mon, 30 Jan 2023 08:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0jNbvW+OvfL7IEkaCr2rWTx9wUJqXsD/cWs80MRYDO4=;
        b=LBy2rslIY6fMtC4X+Po1Anvvm4wPC8a4H4PnhPbqA8KN91CUiVzDMeLeZI+jKTgDpk
         RU8L+n/OF/+QIz2Iuek1oBz+unxXB5kyvvKBJMqWnmqnOeUwwELbZ4Cd42d8CGdDFsDJ
         2/ajKUpy74n/gNxWtoe0FmB2t9v1ZUSkFbka+eC2GdkE9X0w+yHUxxf09XO6EHOrivIN
         tL+dhyI1+Hx268xhX5Ka9mFW82sBW2Z0TZ6DdO1esEwnuxetZWMbZpiA8D649O24UtKK
         Xd3bP4VovpAWhcXBMwmQe4B1et3oxFGddHfSkIqShA+KCdtnhg1tAsn4vV8a1qDT9wIE
         cKrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0jNbvW+OvfL7IEkaCr2rWTx9wUJqXsD/cWs80MRYDO4=;
        b=pNlOTW7R5HKRPf9W05s6TppyDOIvkoc/Cu3OqWWqu7afjFl/3wJz//0IfVAWmUhb7N
         ZBrbuHLOghTFJ5RYY1xXTu9al7MEJu9OZ/yVcKT3+iu9e6JpUKi4/tR9JWaCClrhAt82
         nL1QuS+HISgMYqNB7EOrFpR7LA8GlBYGBqAH8/pNmphe784HqmYX3uKWPhW/3EFuyhca
         onNQjWVDw0iGuA3UpsMDYxpzh4nE2JbsC48XEfKREcwPaD0RmGOH10s7P8ylW9G8CNYV
         QZW722y3c7IrPtN8QrbHsGKI6XDTAebjkvS3xXkIgr7Wk/lpKp3XSVoxmftKCzQaBluF
         34+g==
X-Gm-Message-State: AO0yUKX/FDn3xODtz2jQk7rbndFPRv2KpIg95ywwVNbuoExtsZH4+Cql
        M5oMc6ev+99pt0FUrqIAkCQSS4FNXag=
X-Google-Smtp-Source: AK7set9CNUXZcENIN7xzsV0hyo9ohPzG3pISUcyiJ/hiAO0feTWaeuLIv24akestu83VMyD4fQjYFw==
X-Received: by 2002:a17:902:c943:b0:196:4652:7cff with SMTP id i3-20020a170902c94300b0019646527cffmr17583689pla.11.1675095290113;
        Mon, 30 Jan 2023 08:14:50 -0800 (PST)
Received: from localhost ([2406:7400:63:1fd8:5041:db86:706c:f96b])
        by smtp.gmail.com with ESMTPSA id t12-20020a170902a5cc00b0019667318941sm4598018plq.176.2023.01.30.08.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 08:14:49 -0800 (PST)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Aravinda Herle <araherle@in.ibm.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFCv2 0/3] iomap: Add support for subpage dirty state tracking to improve write performance
Date:   Mon, 30 Jan 2023 21:44:10 +0530
Message-Id: <cover.1675093524.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.1
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

Please find the RFCv2 patchset which adds support for iomap subpage dirty state
tracking which improves write performance and should reduce the write
amplification problem on platforms with smaller filesystem blocksize compared
to pagesize.
E.g. On Power with 64k default pagesize and with 4k filesystem blocksize.

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
  iomap: Move creation of iomap_page early in __iomap_write_begin
  iomap: Change uptodate variable name to state
  iomap: Support subpage size dirty tracking to improve write performance

 fs/gfs2/aops.c         |   2 +-
 fs/iomap/buffered-io.c | 129 ++++++++++++++++++++++++++++++++++-------
 fs/xfs/xfs_aops.c      |   2 +-
 fs/zonefs/super.c      |   2 +-
 include/linux/iomap.h  |   1 +
 5 files changed, 111 insertions(+), 25 deletions(-)

--
2.39.1

