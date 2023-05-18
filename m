Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD0F8708BA4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 May 2023 00:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbjERWdv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 May 2023 18:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbjERWdt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 May 2023 18:33:49 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD85DE6E
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 May 2023 15:33:46 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-52caed90d17so1786684a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 May 2023 15:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684449226; x=1687041226;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WPcvilHxRv5tEGKC3PHnSqwH0oZyyl+v+Zg8TUGpbJw=;
        b=eLivEVS3iKurVg9hrVHfytK1IGa2bJfL0gEwTz9neJ/E/Tbjm2ePYOr1r8ikGFkSZk
         YMULVD+goAY9Bam6P9se2p9H7xW/8TTt55lrGMtIFtvsxBL3q0fKXHHnLsj2bNeXzOGm
         9fEFpzBwz5R7mn7DZBMeI0YdaH0QyvfQI1m8k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684449226; x=1687041226;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WPcvilHxRv5tEGKC3PHnSqwH0oZyyl+v+Zg8TUGpbJw=;
        b=cBr2qk2z/Lv0YPpxT0QMPSN8xRm/leRFrhLZE8Bcb3p+NBwVLbzgy1PkX0eYUoz3XL
         thOAO5WCACCgjQQXT3nuEY5m9GcOwbLohWcATyq+2rgYhI9zYFx5ZeOhThQYKMNWSByw
         b35N0v+Xjdx22IzzBq5pgd3JHf/rUgYb6p3hZfVKwaWeHdkdKrgALN1MX6m4S6bJgBzC
         jw8VR9bxM94KEcQ3aqlMxmkMHI9C+C5J37MgbVcWhPCE+pU3G0SjbuhsRhj0kzPZRSNk
         fYEhk4M35DXi6z13YpfDQGbaJU9t3WVj7F+AFu/tYRhzz5EzI72GWYrMNS27G05BOt2a
         vWwg==
X-Gm-Message-State: AC+VfDxx5VQs7+FIegcIDIM6pMWXXlPb433FwnIYdTx+dBWyz1bcfraf
        JA3N8G5IxQcZXEM59GrSde8kww==
X-Google-Smtp-Source: ACHHUZ7srcWgRWNjK1oBR93TOXpdFS6fhRHeem/s6f029tvJAmcsLM8dRi+XaWwzfkjepb180UvfcA==
X-Received: by 2002:a17:902:9b94:b0:1ae:153f:4cb with SMTP id y20-20020a1709029b9400b001ae153f04cbmr560712plp.49.1684449226192;
        Thu, 18 May 2023 15:33:46 -0700 (PDT)
Received: from sarthakkukreti-glaptop.corp.google.com ([100.107.238.113])
        by smtp.gmail.com with ESMTPSA id q4-20020a170902b10400b001aafb802efbsm1996502plr.12.2023.05.18.15.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 15:33:45 -0700 (PDT)
From:   Sarthak Kukreti <sarthakkukreti@chromium.org>
To:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Brian Foster <bfoster@redhat.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Bart Van Assche <bvanassche@google.com>,
        "Darrick J. Wong" <djwong@kernel.org>
Subject: [PATCH v7 0/5] Introduce provisioning primitives
Date:   Thu, 18 May 2023 15:33:21 -0700
Message-ID: <20230518223326.18744-1-sarthakkukreti@chromium.org>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

This is version 7 of the patch series to introduce block-level provisioning primitives [1]. The current series is rebased on: (2d1bcbc6cd70 Merge tag 'probes-fixes-v6.4-rc1'...).

Changelog:

v7:
- Fold up lo_req_provision() into lo_req_fallocate().
- Propagate error on failure to provision from the blkdev_issue_provision().
- Set 'max_provision_granularity' in thin_ctr.
- Fix positioning of 'max_provision_sectors' in pool_ctr.
- Add provision bios into process_prepared_mapping() to prevent the bio from being reissued to the underlying thinpool.

[1] https://lore.kernel.org/lkml/20220915164826.1396245-1-sarthakkukreti@google.com/

Sarthak Kukreti (5):
  block: Don't invalidate pagecache for invalid falloc modes
  block: Introduce provisioning primitives
  dm: Add block provisioning support
  dm-thin: Add REQ_OP_PROVISION support
  loop: Add support for provision requests

 block/blk-core.c              |  5 +++
 block/blk-lib.c               | 51 ++++++++++++++++++++++++
 block/blk-merge.c             | 18 +++++++++
 block/blk-settings.c          | 19 +++++++++
 block/blk-sysfs.c             |  9 +++++
 block/bounce.c                |  1 +
 block/fops.c                  | 31 ++++++++++++---
 drivers/block/loop.c          | 34 ++++++++++++++--
 drivers/md/dm-crypt.c         |  4 +-
 drivers/md/dm-linear.c        |  1 +
 drivers/md/dm-snap.c          |  7 ++++
 drivers/md/dm-table.c         | 23 +++++++++++
 drivers/md/dm-thin.c          | 74 +++++++++++++++++++++++++++++++++--
 drivers/md/dm.c               |  6 +++
 include/linux/bio.h           |  6 ++-
 include/linux/blk_types.h     |  5 ++-
 include/linux/blkdev.h        | 16 ++++++++
 include/linux/device-mapper.h | 17 ++++++++
 18 files changed, 310 insertions(+), 17 deletions(-)

-- 
2.40.1.698.g37aff9b760-goog

