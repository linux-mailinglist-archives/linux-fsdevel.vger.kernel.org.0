Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC1677A2972
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Sep 2023 23:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237769AbjIOVd2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Sep 2023 17:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237722AbjIOVdM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Sep 2023 17:33:12 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1479B8;
        Fri, 15 Sep 2023 14:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=R2D5ERHgA50rjnGDJd3UTlmr28nE94IPRsx6Q30NTNM=; b=IioY1+MgNEocbawTB+OnCHuQPq
        m334jTZ/rCCDiPzly1hKTAnORYCPXPfXiFu35XxAtsJh70qoLVkXLWWdO79+mD7WR432rlQebZrTL
        cYwrdeEgZUkSN3sqaVas6b/eMzrthfiXWQnmOA1+sT7ytv5z33SyWfO59607OFtHrFeJ2lZSGVkxH
        +MEHOarKFO7fXw36ZP5Fi2MZv/HiawQB8OuB1KcPEsdCTHz3XDjrAVwB0n8rNubNFaQx8l88wsHcF
        lQqTYpYp1EkQybTcS+lydA1PawBqxqbzMb72Itu7Xlcc6pLwY6e97lZ4gggq007lKBQE0yY/f5xQo
        gyCQ8WmQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qhGQq-00BQnY-1P;
        Fri, 15 Sep 2023 21:32:56 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     hch@infradead.org, djwong@kernel.org, dchinner@redhat.com,
        kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com
Cc:     willy@infradead.org, brauner@kernel.org, hare@suse.de,
        ritesh.list@gmail.com, rgoldwyn@suse.com, jack@suse.cz,
        ziy@nvidia.com, ryan.roberts@arm.com, patches@lists.linux.dev,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, p.raghav@samsung.com,
        da.gomez@samsung.com, dan.helmick@samsung.com, mcgrof@kernel.org
Subject: [RFC v2 08/10] nvme: add awun / nawun sanity check
Date:   Fri, 15 Sep 2023 14:32:52 -0700
Message-Id: <20230915213254.2724586-9-mcgrof@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230915213254.2724586-1-mcgrof@kernel.org>
References: <20230915213254.2724586-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

AWUN/NAWUN control the atomicity of command execution in relation to
other commands. They impose inter-command serialization of writing of
blocks of data to the NVM and prevent blocks of data ending up on the
NVM containing partial data from one new command and partial data from
one or more other new commands.

Parse awun / nawun to verify at least the physical block size
exposed is not greater than this value.

The special case of awun / nawun == 0xffff tells us we can ramp
up to mdts.

Suggested-by: Dan Helmick <dan.helmick@samsung.com>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/nvme/host/core.c | 21 +++++++++++++++++++++
 drivers/nvme/host/nvme.h |  1 +
 2 files changed, 22 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 0365f260c514..7a3c51ac13bd 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1911,6 +1911,7 @@ static void nvme_update_disk_info(struct gendisk *disk,
 	sector_t capacity = nvme_lba_to_sect(ns, le64_to_cpu(id->nsze));
 	u32 bs = 1U << ns->lba_shift;
 	u32 atomic_bs, phys_bs, io_opt = 0;
+	u32 awun = 0, awun_bs = 0;
 
 	if (!nvme_lba_shift_supported(ns)) {
 		capacity = 0;
@@ -1931,6 +1932,15 @@ static void nvme_update_disk_info(struct gendisk *disk,
 			atomic_bs = (1 + le16_to_cpu(id->nawupf)) * bs;
 		else
 			atomic_bs = (1 + ns->ctrl->subsys->awupf) * bs;
+		if (id->nsfeat & NVME_NS_FEAT_ATOMICS && id->nawun)
+			awun = (1 + le16_to_cpu(id->nawun));
+		else
+			awun = (1 + ns->ctrl->subsys->awun);
+		/* Indicates MDTS can be used */
+		if (awun == 0xffff)
+			awun_bs = ns->ctrl->max_hw_sectors << SECTOR_SHIFT;
+		else
+			awun_bs = awun * bs;
 	}
 
 	if (id->nsfeat & NVME_NS_FEAT_IO_OPT) {
@@ -1940,6 +1950,16 @@ static void nvme_update_disk_info(struct gendisk *disk,
 		io_opt = bs * (1 + le16_to_cpu(id->nows));
 	}
 
+	if (awun) {
+		phys_bs = min(awun_bs, phys_bs);
+
+		/*
+		 * npwg and nows could be > awun, in such cases users should
+		 * be aware of out of order reads/writes as npwg and nows
+		 * are purely performance optimizations.
+		 */
+	}
+
 	blk_queue_logical_block_size(disk->queue, bs);
 	/*
 	 * Linux filesystems assume writing a single physical block is
@@ -2785,6 +2805,7 @@ static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 		kfree(subsys);
 		return -EINVAL;
 	}
+	subsys->awun = le16_to_cpu(id->awun);
 	subsys->awupf = le16_to_cpu(id->awupf);
 	nvme_mpath_default_iopolicy(subsys);
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index f35647c470af..071ec52d83ea 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -410,6 +410,7 @@ struct nvme_subsystem {
 	u8			cmic;
 	enum nvme_subsys_type	subtype;
 	u16			vendor_id;
+	u16			awun;
 	u16			awupf;	/* 0's based awupf value. */
 	struct ida		ns_ida;
 #ifdef CONFIG_NVME_MULTIPATH
-- 
2.39.2

