Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7D934F5905
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Apr 2022 11:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233276AbiDFJQW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Apr 2022 05:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349398AbiDFJCq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Apr 2022 05:02:46 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EDFB48EC7E;
        Tue,  5 Apr 2022 23:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=sINtR+pRAAWqBCMZRslKVJyakyubEJXVW4tI3wGLsb0=; b=gBrZsvegbTHoIEG5qdijcHzNWW
        PfzclL3zzl2tB5xhm8Sj7w6skVV8SvvJytC4EH0RoMlbB62c3vMVvjooDHTIWQ3smYKaAuMQ4cOli
        spZhkrdfcyNNrOGeIUuTpGtX63bYCgqfiIr52xJMA9AGK42nQUGH/2eHVQ3foGEH/zFa8lWfGs7Pp
        Ay5KyAHLP9DhsOCOpCtbHRVbRjzyQdYUTq4TkVLaYR9+Sga+ljLLLtQo5Hukpu2Q5UAw6RMQTfLQg
        vt8zwwfekDfQOHpKLK7/INfKF40CQ8temfgKOOdrhB506dWycfStoRSbi1wi6owABwmVkNNzYqcsL
        kVwVOMFA==;
Received: from 213-225-3-188.nat.highway.a1.net ([213.225.3.188] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nbynD-003ul3-Rn; Wed, 06 Apr 2022 06:05:24 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     dm-devel@redhat.com, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-um@lists.infradead.org,
        linux-block@vger.kernel.org, drbd-dev@lists.linbit.com,
        nbd@other.debian.org, ceph-devel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        xen-devel@lists.xenproject.org, linux-bcache@vger.kernel.org,
        linux-raid@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com, jfs-discussion@lists.sourceforge.net,
        linux-nilfs@vger.kernel.org, ntfs3@lists.linux.dev,
        ocfs2-devel@oss.oracle.com, linux-mm@kvack.org
Subject: [PATCH 01/27] target: remove an incorrect unmap zeroes data deduction
Date:   Wed,  6 Apr 2022 08:04:50 +0200
Message-Id: <20220406060516.409838-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220406060516.409838-1-hch@lst.de>
References: <20220406060516.409838-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

For block devices the target code implements UNMAP as calls to
blkdev_issue_discard, which does not guarantee zeroing just because
Write Zeroes is supported.

Note that this does not affect the file backed path which uses
fallocate to punch holes.

Fixes: 2237498f0b5c ("target/iblock: Convert WRITE_SAME to blkdev_issue_zeroout")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/target/target_core_device.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/target/target_core_device.c b/drivers/target/target_core_device.c
index 44bb380e7390c..fa866acef5bb2 100644
--- a/drivers/target/target_core_device.c
+++ b/drivers/target/target_core_device.c
@@ -850,7 +850,6 @@ bool target_configure_unmap_from_queue(struct se_dev_attrib *attrib,
 	attrib->unmap_granularity = q->limits.discard_granularity / block_size;
 	attrib->unmap_granularity_alignment = q->limits.discard_alignment /
 								block_size;
-	attrib->unmap_zeroes_data = !!(q->limits.max_write_zeroes_sectors);
 	return true;
 }
 EXPORT_SYMBOL(target_configure_unmap_from_queue);
-- 
2.30.2

