Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F03827BAA52
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Oct 2023 21:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbjJETli (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Oct 2023 15:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjJETlh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Oct 2023 15:41:37 -0400
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E8ECE;
        Thu,  5 Oct 2023 12:41:36 -0700 (PDT)
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1c88b467ef8so4866195ad.0;
        Thu, 05 Oct 2023 12:41:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696534896; x=1697139696;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8PNVxsJWMiXLmTm8xBAOWRN8wkjHwA+8htAHskM1reQ=;
        b=VAortn4XPNJZt1SsLlZJdzHzSVQMg4GrCJ3IOhc1zJAQhBsYDoNbKfdfa2oqm38toc
         /0TL5oHCgPMKaJTFFRqp+4IB8B+XCDbI0TOIlaldwHq30UF/ehuJd1zvZRAIlz3LKiye
         sjN+juGWf9Cy8GrJQai7/nL0s7+1D41RD6OgsOInKFz1XTosstcrl9gF1yXF7Ugvo2i5
         rlbRquPc0oPGlh2Ppma7s1Sn00Hk/k8rozpslg5eEimWV81zrz8Xjfo3rErRwgy+VEJi
         +8z+E0fFNjtbl9ghfTbgKoJXnTK36pf/omdGtQwsCDb/93b8jDR0+rT1us/XMt85QqLG
         wy5Q==
X-Gm-Message-State: AOJu0YyDiTqhwAaBEDGMBicHnd/lNcRuDcW3X7uoHv4iHnLgpmEI8nzV
        RdP8zAyAHG4Y0tK9e9ZdDbU=
X-Google-Smtp-Source: AGHT+IHYz2XdRKL3PBxgEAHlFeFWptqRewEQT3gWgB/hHliMo32MW2iVB1fnzBG+5n+CZQqJ4ZUcTQ==
X-Received: by 2002:a17:902:e54a:b0:1c6:2d13:5b74 with SMTP id n10-20020a170902e54a00b001c62d135b74mr7264965plf.55.1696534895572;
        Thu, 05 Oct 2023 12:41:35 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:ca3e:70ef:bad:2f])
        by smtp.gmail.com with ESMTPSA id u4-20020a170902e5c400b001a9b29b6759sm2129596plf.183.2023.10.05.12.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 12:41:34 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        Avri Altman <Avri.Altman@wdc.com>,
        Bean Huo <huobean@gmail.com>,
        Daejun Park <daejun7.park@samsung.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v2 00/15] Pass data temperature information to UFS devices
Date:   Thu,  5 Oct 2023 12:40:46 -0700
Message-ID: <20231005194129.1882245-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Jens,

UFS vendors need the data lifetime information to achieve good performance.
Without this information there is significantly higher write amplification due
to garbage collection. Hence this patch series that add support in F2FS and
also in the block layer for data lifetime information. The SCSI disk (sd)
driver is modified such that it passes write hint information to SCSI devices
via the GROUP NUMBER field.

Please consider this patch series for the next merge window.

Thanks,

Bart.

Changes compared to v1:
- Use six bits from the ioprio field for data lifetime information. The
  bio->bi_write_hint / req->write_hint / iocb->ki_hint members that were
  introduced in v1 have been removed again.
- The F_GET_FILE_RW_HINT and F_SET_FILE_RW_HINT fcntls have been removed.
- In the SCSI disk (sd) driver, query the stream status and check the PERM bit.
- The GET STREAM STATUS command has been implemented in the scsi_debug driver.

Bart Van Assche (15):
  block: Make bio_set_ioprio() modify fewer bio->bi_ioprio bits
  blk-ioprio: Modify fewer bio->bi_ioprio bits
  block: Support data lifetime in the I/O priority bitfield
  fs: Restore write hint support
  fs/f2fs: Restore the whint_mode mount option
  scsi: core: Query the Block Limits Extension VPD page
  scsi_proto: Add structures and constants related to I/O groups and
    streams
  sd: Translate data lifetime information
  scsi_debug: Reduce code duplication
  scsi_debug: Support the block limits extension VPD page
  scsi_debug: Rework page code error handling
  scsi_debug: Rework subpage code error handling
  scsi_debug: Implement the IO Advice Hints Grouping mode page
  scsi_debug: Implement GET STREAM STATUS
  scsi_debug: Maintain write statistics per group number

 Documentation/filesystems/f2fs.rst |  70 ++++++++
 block/blk-ioprio.c                 |   9 +-
 block/blk-mq.c                     |   3 +-
 drivers/scsi/scsi.c                |   2 +
 drivers/scsi/scsi_debug.c          | 247 +++++++++++++++++++++--------
 drivers/scsi/scsi_sysfs.c          |  10 ++
 drivers/scsi/sd.c                  | 112 ++++++++++++-
 drivers/scsi/sd.h                  |   3 +
 fs/f2fs/data.c                     |   3 +
 fs/f2fs/f2fs.h                     |   9 ++
 fs/f2fs/segment.c                  |  95 +++++++++++
 fs/f2fs/super.c                    |  32 +++-
 fs/iomap/buffered-io.c             |   3 +
 fs/mpage.c                         |   2 +
 include/linux/fs-lifetime.h        |  20 +++
 include/linux/ioprio.h             |  10 ++
 include/scsi/scsi_device.h         |   1 +
 include/scsi/scsi_proto.h          |  75 +++++++++
 include/uapi/linux/ioprio.h        |   8 +-
 19 files changed, 639 insertions(+), 75 deletions(-)
 create mode 100644 include/linux/fs-lifetime.h

