Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE35F6E1891
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Apr 2023 02:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbjDNACo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Apr 2023 20:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbjDNACn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Apr 2023 20:02:43 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D5E03C1E
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Apr 2023 17:02:40 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id hg14-20020a17090b300e00b002471efa7a8fso3354508pjb.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Apr 2023 17:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1681430559; x=1684022559;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o7P9g3Nl+EfrrL2NO6MRAt6Dye4XvqSU4otNxeRaGZY=;
        b=IRUYl+scWxtKHfQzW1OJHJIuR3Z3RkNtZXSk2D4iGYiWRM+zh5hAWdHpMYLUNWFNrn
         mLzFrKWjDYCRBZ5ukbWyr/5DVDpw5GvHFJGO31u9DPxe2rdJMyTCo4TGQJruwa45+WfG
         0zMUArth2/a1WFpBOeA4+r+QFJJ+At0aSepqs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681430559; x=1684022559;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o7P9g3Nl+EfrrL2NO6MRAt6Dye4XvqSU4otNxeRaGZY=;
        b=KLUtY9uo0Ytke/Td821qwXR481wyL97egzJYMMtvyV8OAKT9q2+XyeNG72NaVFUI6C
         CVrcdVeIwZShfIfbBH8nUUQbtWFp8dSGzSjZGwofHt8zVP8AvGrha7X/ekqRC+eCd6Nw
         CXw4kcTwhl0UtlM+ZayJFquH6mLoDS1P9Y9iFKW2FgySF7ANWO2j47MMJ71nevZHj/LW
         O7nMULQBwDFVpNIjczxtVz1n0gbSjsqlISH+Fx3kVRwz7XFlgxxvAMNlt+2kyYM3Hip5
         B9yAcyFQjO7cm2+nq06Abvfqbf5hOvJCc+81HlmR9lhYpuuNS13KWXrhwL6iTOV6r/AD
         oDww==
X-Gm-Message-State: AAQBX9c5orn7kbiNwbDYMPPAO6Hq2V5WVwUKQItmZnBjHxCR9AOmT7Sn
        ulDcMkulnJKM8wE0Ybq9CDKGZQ==
X-Google-Smtp-Source: AKy350a2nB2erFq7GiOYjZ2KhzsJGWrzG9WdIfbNnMAWthKviGqkJTS5lu3A5CkCn3PsSc1wuojVvw==
X-Received: by 2002:a17:90b:2692:b0:246:f5a3:e942 with SMTP id pl18-20020a17090b269200b00246f5a3e942mr9234592pjb.18.1681430559599;
        Thu, 13 Apr 2023 17:02:39 -0700 (PDT)
Received: from sarthakkukreti-glaptop.corp.google.com ([2620:15c:9d:200:72cc:7fa5:adcb:7c02])
        by smtp.gmail.com with ESMTPSA id u18-20020a17090a891200b002470f179b92sm2212939pjn.43.2023.04.13.17.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 17:02:39 -0700 (PDT)
From:   Sarthak Kukreti <sarthakkukreti@chromium.org>
To:     sarthakkukreti@google.com, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
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
Subject: [PATCH v3 0/3] Introduce provisioning primitives for thinly provisioned storage
Date:   Thu, 13 Apr 2023 17:02:16 -0700
Message-ID: <20230414000219.92640-1-sarthakkukreti@chromium.org>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
In-Reply-To: <20221229071647.437095-1-sarthakkukreti@chromium.org>
References: <20221229071647.437095-1-sarthakkukreti@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

This patch series adds a mechanism to pass through provision requests on
stacked thinly provisioned block devices.

The linux kernel provides several mechanisms to set up thinly provisioned
block storage abstractions (eg. dm-thin, loop devices over sparse files),
either directly as block devices or backing storage for filesystems. Currently,
short of writing data to either the device or filesystme, there is no way for
users to pre-allocate space for use in such storage setups. Consider the
following use-cases:

1) Suspend-to-disk and resume from a dm-thin device: In order to ensure that
   the underlying thinpool metadata is not modified during the suspend
   mechanism, the dm-thin device needs to be fully provisioned.
2) If a filesystem uses a loop device over a sparse file, fallocate() on the
   filesystem will allocate blocks for files but the underlying sparse file
   will remain intact.
3) Another example is virtual machine using a sparse file/dm-thin as a storage
   device; by default, allocations within the VM boundaries will not affect
   the host.
4) Several storage standards support mechanisms for thin provisioning on
   real hardware devices. For example:
   a. The NVMe spec 1.0b section 2.1.1 loosely talks about thin provisioning:
      "When the THINP bit in the NSFEAT field of the Identify Namespace data
       structure is set to ‘1’, the controller ... shall track the number of
       allocated blocks in the Namespace Utilization field"
   b. The SCSi Block Commands reference - 4 section references "Thin
      provisioned logical units",
   c. UFS 3.0 spec section 13.3.3 references "Thin provisioning".

In all the above situations, currently, the only way for pre-allocating space
is to issue writes (or use WRITE_ZEROES/WRITE_SAME). However, that does not
scale well with larger pre-allocation sizes.

This patchset introduces primitives to support block-level provisioning (note:
the term 'provisioning' is used to prevent overloading the term
'allocations/pre-allocations') requests across filesystems and block devices.
This allows fallocate() and file creation requests to reserve space across
stacked layers of block devices and filesystems. Currently, the patchset covers
a prototype on the device-mapper targets, loop device and ext4, but the same
mechanism can be extended to other filesystems/block devices as well as extended
for use with devices in 4 a-c.

Patch 1 introduces REQ_OP_PROVISION as a new request type.
The provision request acts like the inverse of a discard request; instead
of notifying lower layers that the block range will no longer be used, provision
acts as a request to lower layers to provision disk space for the given block
range. Real hardware storage devices will currently disable the provisioing
capability but for the standards listed in 4a.-c., REQ_OP_PROVISION can be
overloaded for use as the provisioing primitive for future devices.

Patch 2 implements REQ_OP_PROVISION handling for some of the device-mapper
targets. Device-mapper targets will usually mirror the support of underlying
devices. This patch also enables the use of fallocate in mode == 0 for block
devices.

Patch 3 wires up the loop device handling of REQ_OP_PROVISION and calls
fallocate() with mode 0 on the underlying file/block device.

Testing:
--------
- Tested on a VM running a 6.2 kernel.

- Preallocation of dm-thin devices:
As expected, avoiding the need to zero out thinly-provisioned block devices to
preallocate space speeds up the provisioning operation significantly:

The following was tested on a dm-thin device set up on top of a dm-thinp with
skip_block_zeroing=true.
A) Zeroout was measured using `fallocate -z ...`
B) Provision was measured using `fallocate -p ...`.

Size	Time	A	B
512M	real	1.093	0.034
	user	0	0
	sys	0.022	0.01
1G	real	2.182	0.048
	user	0	0.01
	sys	0.022	0
2G	real	4.344	0.082
	user	0	0.01
	sys	0.036	0
4G	real	8.679	0.153
	user	0	0.01
	sys	0.073	0
8G	real	17.777	0.318
	user	0	0.01
	sys	0.144	0

Changelog:

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

Sarthak Kukreti (3):
  block: Introduce provisioning primitives
  dm: Add support for block provisioning
  loop: Add support for provision requests

 block/blk-core.c              |   5 ++
 block/blk-lib.c               |  53 ++++++++++++++++
 block/blk-merge.c             |  18 ++++++
 block/blk-settings.c          |  19 ++++++
 block/blk-sysfs.c             |   8 +++
 block/bounce.c                |   1 +
 block/fops.c                  |  14 +++--
 drivers/block/loop.c          |  42 +++++++++++++
 drivers/md/dm-crypt.c         |   4 +-
 drivers/md/dm-linear.c        |   1 +
 drivers/md/dm-snap.c          |   7 +++
 drivers/md/dm-table.c         |  25 ++++++++
 drivers/md/dm-thin.c          | 110 +++++++++++++++++++++++++++++++---
 drivers/md/dm.c               |   4 ++
 include/linux/bio.h           |   6 +-
 include/linux/blk_types.h     |   5 +-
 include/linux/blkdev.h        |  16 +++++
 include/linux/device-mapper.h |  11 ++++
 18 files changed, 333 insertions(+), 16 deletions(-)

-- 
2.40.0.634.g4ca3ef3211-goog

