Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8537BAA60
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Oct 2023 21:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbjJETmJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Oct 2023 15:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231551AbjJETmI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Oct 2023 15:42:08 -0400
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 584D4D9;
        Thu,  5 Oct 2023 12:42:06 -0700 (PDT)
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1c364fb8a4cso11318415ad.1;
        Thu, 05 Oct 2023 12:42:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696534926; x=1697139726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EblNO0PoDnbAMQTjZaSS3e9uP7MnNo4tSNLZx6IdOg8=;
        b=PTSdwoIdH3WIRsL05aRKFWQHH57RX+/Wo2RQdUlb4IM8+fsMEdePw6DEwyjAOxZ5bh
         d8tMe9wjSi3IdEftJPR1w8OYtem0Nj3AlkhgYEKyx/2Y5lS2KBjF2ReIGEPjyCf6XJzl
         Y+yUM8+m075rFltqchrCexP4gfvU6MEuwsPwY69yPZ0yqubU1fTk30nEL5IdGQmUXTtv
         38yws+mmhFdF/PbTZ4OjaovmRGiBOodA7rEg1VOkchM5p6ne6161PHLA0xkWSabfI0+e
         kvDpmj6CMV4H5kpyBSOmMylgjylDQKVyPNmt/erkIzoVPaoL9+cZh/2usEOImaF3T47X
         rpeA==
X-Gm-Message-State: AOJu0Yxn5RWgmyFeEojrEzcqss/vIgVWb9TwANdW3KlNHvIBa++Hb092
        BU2GaJj4/LJEiF9cwesN6z4=
X-Google-Smtp-Source: AGHT+IFAo+RYoWIVDa7oF3w3mNOS555tFGGhKcP55p5BuHvByTTj+EwJRGL+OBas+2wIkEywjQK2FA==
X-Received: by 2002:a17:902:d382:b0:1c5:e9a8:dbc0 with SMTP id e2-20020a170902d38200b001c5e9a8dbc0mr5990132pld.51.1696534925685;
        Thu, 05 Oct 2023 12:42:05 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:ca3e:70ef:bad:2f])
        by smtp.gmail.com with ESMTPSA id u4-20020a170902e5c400b001a9b29b6759sm2129596plf.183.2023.10.05.12.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 12:42:05 -0700 (PDT)
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
        Bart Van Assche <bvanassche@acm.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Subject: [PATCH v2 04/15] fs: Restore write hint support
Date:   Thu,  5 Oct 2023 12:40:50 -0700
Message-ID: <20231005194129.1882245-5-bvanassche@acm.org>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
In-Reply-To: <20231005194129.1882245-1-bvanassche@acm.org>
References: <20231005194129.1882245-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch reverts a small subset of commit c75e707fe1aa ("block: remove
the per-bio/request write hint"). The following functionality has been
restored:
- In F2FS, store data lifetime information in struct bio.
- In fs/iomap and fs/mpage.c, restore the code that sets the data
  lifetime.

A new header file is introduced for the new bio_[sg]et_data_lifetime()
functions because there is no other header file yet that includes both
<linux/fs.h> and <linux/ioprio.h>.

The value WRITE_LIFE_NONE is mapped onto the data lifetime 0. This is
consistent with NVMe TPAR4093a. From that TPAR: "A value of 1h specifies
the shortest Data Lifetime. A value of 3Fh specifies the longest Data
Lifetime." This is also consistent with the SCSI specifications. From
T10 document 23-024r3: "0h: no relative lifetime is applicable; 1h:
shortest relative lifetime; ...; 3fh: longest relative lifetime".

Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 fs/f2fs/data.c              |  3 +++
 fs/iomap/buffered-io.c      |  3 +++
 fs/mpage.c                  |  2 ++
 include/linux/fs-lifetime.h | 20 ++++++++++++++++++++
 4 files changed, 28 insertions(+)
 create mode 100644 include/linux/fs-lifetime.h

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 916e317ac925..2962cb335897 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -6,6 +6,7 @@
  *             http://www.samsung.com/
  */
 #include <linux/fs.h>
+#include <linux/fs-lifetime.h>
 #include <linux/f2fs_fs.h>
 #include <linux/buffer_head.h>
 #include <linux/sched/mm.h>
@@ -478,6 +479,8 @@ static struct bio *__bio_alloc(struct f2fs_io_info *fio, int npages)
 	} else {
 		bio->bi_end_io = f2fs_write_end_io;
 		bio->bi_private = sbi;
+		bio_set_data_lifetime(bio,
+			f2fs_io_type_to_rw_hint(sbi, fio->type, fio->temp));
 	}
 	iostat_alloc_and_bind_ctx(sbi, bio, NULL);
 
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 644479ccefbd..9bf05342ca65 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -6,6 +6,7 @@
 #include <linux/module.h>
 #include <linux/compiler.h>
 #include <linux/fs.h>
+#include <linux/fs-lifetime.h>
 #include <linux/iomap.h>
 #include <linux/pagemap.h>
 #include <linux/uio.h>
@@ -1660,6 +1661,7 @@ iomap_alloc_ioend(struct inode *inode, struct iomap_writepage_ctx *wpc,
 			       REQ_OP_WRITE | wbc_to_write_flags(wbc),
 			       GFP_NOFS, &iomap_ioend_bioset);
 	bio->bi_iter.bi_sector = sector;
+	bio_set_data_lifetime(bio, inode->i_write_hint);
 	wbc_init_bio(wbc, bio);
 
 	ioend = container_of(bio, struct iomap_ioend, io_inline_bio);
@@ -1690,6 +1692,7 @@ iomap_chain_bio(struct bio *prev)
 	new = bio_alloc(prev->bi_bdev, BIO_MAX_VECS, prev->bi_opf, GFP_NOFS);
 	bio_clone_blkg_association(new, prev);
 	new->bi_iter.bi_sector = bio_end_sector(prev);
+	bio_set_data_lifetime(new, bio_get_data_lifetime(prev));
 
 	bio_chain(prev, new);
 	bio_get(prev);		/* for iomap_finish_ioend */
diff --git a/fs/mpage.c b/fs/mpage.c
index 242e213ee064..888ca71c9ea7 100644
--- a/fs/mpage.c
+++ b/fs/mpage.c
@@ -20,6 +20,7 @@
 #include <linux/gfp.h>
 #include <linux/bio.h>
 #include <linux/fs.h>
+#include <linux/fs-lifetime.h>
 #include <linux/buffer_head.h>
 #include <linux/blkdev.h>
 #include <linux/highmem.h>
@@ -612,6 +613,7 @@ static int __mpage_writepage(struct folio *folio, struct writeback_control *wbc,
 				GFP_NOFS);
 		bio->bi_iter.bi_sector = blocks[0] << (blkbits - 9);
 		wbc_init_bio(wbc, bio);
+		bio_set_data_lifetime(bio, inode->i_write_hint);
 	}
 
 	/*
diff --git a/include/linux/fs-lifetime.h b/include/linux/fs-lifetime.h
new file mode 100644
index 000000000000..0e652e00cfab
--- /dev/null
+++ b/include/linux/fs-lifetime.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <linux/bio.h>
+#include <linux/fs.h>
+#include <linux/ioprio.h>
+
+static inline enum rw_hint bio_get_data_lifetime(struct bio *bio)
+{
+	/* +1 to map 0 onto WRITE_LIFE_NONE. */
+	return IOPRIO_PRIO_LIFETIME(bio->bi_ioprio) + 1;
+}
+
+static inline void bio_set_data_lifetime(struct bio *bio, enum rw_hint lifetime)
+{
+	/* -1 to map WRITE_LIFE_NONE onto 0. */
+	if (lifetime != 0)
+		lifetime--;
+	WARN_ON_ONCE(lifetime & ~IOPRIO_LIFETIME_MASK);
+	bio->bi_ioprio &= ~(IOPRIO_LIFETIME_MASK << IOPRIO_LIFETIME_SHIFT);
+	bio->bi_ioprio |= lifetime << IOPRIO_LIFETIME_SHIFT;
+}
