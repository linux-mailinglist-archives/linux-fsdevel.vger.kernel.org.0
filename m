Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD206E6F1E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Apr 2023 00:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233171AbjDRWM2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Apr 2023 18:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232450AbjDRWM1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Apr 2023 18:12:27 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F02B4ECB
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Apr 2023 15:12:25 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-63b73203e0aso12044545b3a.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Apr 2023 15:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1681855945; x=1684447945;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M9E1BqVFDy2BflXM1cADV/r0z5lqbfjda2/59Vcchgo=;
        b=Jo2yZxMkavhQ+MIAWBAeaGvPx0841bfH+j3qe8ft2FVaBlD2M+g06nJxwzd4Zj8OhU
         aocEc0zcAa6buJ+qL58yK2xIUsZb6kk5U+exUHEGcheHngx1crSLSJcO6CEii5k9vgXn
         OzYeWwCd2m7wkq1AhQ8Iq1FSzjMpNrDWZcKHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681855945; x=1684447945;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M9E1BqVFDy2BflXM1cADV/r0z5lqbfjda2/59Vcchgo=;
        b=QJ9tVW4AxT1iwkSlIIk/jOOAUpSc2i0+vw6A57gfMh5cBvxgCa/W0v07au39aoQZlM
         jU04Wc2mM3fjz0gvF/yHOoOuKqLI8l+boeMK6fs48L03dyr28ANFdVT3Okg6GSCWdLqY
         KHYATB6JLg3DokkTdXzn0rcoED9AlT16yFPIosXmK/1S57f+xUbs/Lx7XaqKU+fdbTrG
         1AF/pZJ1c6x02s7se1TxEH0WcEsImelTOvA590FMwnyQttHIe9t6nyI1wiu1dl5X5E0h
         xoz+E79e7dw0xBtLSMOc68rvptioL25t2WIcPjG1BjYFaRMT7q867oqb1l2tAFOVRmI6
         1hJg==
X-Gm-Message-State: AAQBX9dSf6nGnPGB9V7PWLhxcK3DcfZLuiIqHTjYjyoEzEAIPAlEjVN6
        Dph/mvvu8mAmoKwV9JgWoPbwjw==
X-Google-Smtp-Source: AKy350br4lmpBQ9IqBERy8QWvPvh8nF+TV+5IMWinZQGy/0x1eapXdYeTnP5vhm7GN1Hj1rvRlU8RQ==
X-Received: by 2002:a17:902:d2cb:b0:1a6:3def:5ff6 with SMTP id n11-20020a170902d2cb00b001a63def5ff6mr314888plc.4.1681855944989;
        Tue, 18 Apr 2023 15:12:24 -0700 (PDT)
Received: from sarthakkukreti-glaptop.corp.google.com ([2620:15c:9d:200:e38b:ca5e:3203:48d3])
        by smtp.gmail.com with ESMTPSA id x1-20020a1709029a4100b001a687c505e9sm9911892plv.237.2023.04.18.15.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 15:12:24 -0700 (PDT)
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
        Daniil Lunev <dlunev@google.com>,
        "Darrick J. Wong" <djwong@kernel.org>
Subject: [PATCH v4 0/4] Introduce provisioning primitives for thinly provisioned storage
Date:   Tue, 18 Apr 2023 15:12:03 -0700
Message-ID: <20230418221207.244685-1-sarthakkukreti@chromium.org>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
In-Reply-To: <20230414000219.92640-1-sarthakkukreti@chromium.org>
References: <20230414000219.92640-1-sarthakkukreti@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

This patch series is revision 4 of introducing a new mechanism to pass through provision requests on stacked thinly provisioned storage devices. See [1] for original cover letter.

[1] https://lore.kernel.org/lkml/ZDnMl8A1B1+Tfn5S@redhat.com/T/#md4f20113c2242755747ae069f84be720a6751012

Changelog:

V4:
- Fix UNSHARE and KEEP_SIZE handling in blkdev_fallocate.
- Split dm-thin support into a separate patch.
- Remove ranged provision request handling and adjust io hints to handle provisioning one block at a time.
- Add missing provision_supported for dm targets.

V3:
- Drop FALLOC_FL_PROVISION and use mode == 0 for provision requests.
- Drop fs-specific patches; will be sent out in a follow up series.
- Fix missing shared block handling for thin snapshots.

V2:
- Fix stacked limit handling.
- Enable provision request handling in dm-snapshot
- Don't call truncate_bdev_range if blkdev_fallocate() is called with
  FALLOC_FL_PROVISION.
- Clarify semantics of FALLOC_FL_PROVISION and why it needs to be a separate flag
  (as opposed to overloading mode == 0).


Sarthak Kukreti (4):
  block: Introduce provisioning primitives
  dm: Add block provisioning support
  dm-thin: Add REQ_OP_PROVISION support
  loop: Add support for provision requests

 block/blk-core.c              |  5 +++
 block/blk-lib.c               | 53 +++++++++++++++++++++++++
 block/blk-merge.c             | 18 +++++++++
 block/blk-settings.c          | 19 +++++++++
 block/blk-sysfs.c             |  8 ++++
 block/bounce.c                |  1 +
 block/fops.c                  | 25 +++++++++---
 drivers/block/loop.c          | 42 ++++++++++++++++++++
 drivers/md/dm-crypt.c         |  5 ++-
 drivers/md/dm-linear.c        |  2 +
 drivers/md/dm-snap.c          |  8 ++++
 drivers/md/dm-table.c         | 23 +++++++++++
 drivers/md/dm-thin.c          | 73 ++++++++++++++++++++++++++++++++---
 drivers/md/dm.c               |  6 +++
 include/linux/bio.h           |  6 ++-
 include/linux/blk_types.h     |  5 ++-
 include/linux/blkdev.h        | 16 ++++++++
 include/linux/device-mapper.h | 17 ++++++++
 18 files changed, 317 insertions(+), 15 deletions(-)

-- 
2.40.0.634.g4ca3ef3211-goog

