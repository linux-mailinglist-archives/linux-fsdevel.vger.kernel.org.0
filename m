Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0B42806BD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Oct 2020 20:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732643AbgJASiC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Oct 2020 14:38:02 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:24678 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729927AbgJASiB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Oct 2020 14:38:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1601577481; x=1633113481;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0B7GyYvxBZKiLZNQGeYgaqd1Sn4PpO+kC4na0Gsi84M=;
  b=lZaAfXcrnqU4WEMOI3awKIfXQxk3UDHRjoWmTvIZ3LHW9ZrLF+cpdA62
   NFqb6M2SlayxioCb9hfWUp7oYMFb+nTSXjGN0hFIGN2AaMH6JcJeLtFZo
   k5PmrKfLn5VDcM1kksVdel5gNY/75GjMGOfE0R/hVdrDPispFB8KXALcw
   TUKET+qXABK/B14vodGTXnSVPUO6LIY4TVSGm3aVvjsi3EHWhed0NKTiw
   Pxe22vXAs8jUv27Iu6e9YWRxyB9l9wy2MuIM5qggFXTI8rCrcbauCufmQ
   yfwVM7eCzpcmgYnvvU+w7TYvl9v8XiwhEV+V7qfh9IPwLtMTd2oIgv+rc
   A==;
IronPort-SDR: yhfxsAloTbWh554jJDGTUtI543nYddA/9CdtYYsJoYjDUU0/UpDYrb0+1j9UWgdhEdk7Ik2pyI
 jmekZzF4TpzZHW6VM13FMkJFuI4KJSrnT2/a/7uD7Q4k4qZ8H72mLBbIj3Ac3DAzCczVaC8uH5
 1QvB7FfqPBXRu2WWJiQ6u8O8pG48WlPxS2CqfayLf3JjwOsWBQBH5iAIlRnNsxsEEdIn2t9w3T
 bKNrNMaCHk3aJLVazaUuJVNw0Bckw5BGUwEkovFX+FeXBjuFRMOEAQ6Aej3xbi8T/p35HqNEdV
 L3g=
X-IronPort-AV: E=Sophos;i="5.77,324,1596470400"; 
   d="scan'208";a="150036761"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Oct 2020 02:38:01 +0800
IronPort-SDR: iRHX3kRgGvNQ1RQqAT9E24T8KP4P2O30ZhDaH2hqNBxW2Ku9nkllvUPFWW5ovRvp+7n3JnEYCM
 /F/NSBqezLGQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2020 11:23:57 -0700
IronPort-SDR: 1+jpWQkcqoZkTTcxMrVytEuFdlDteWcFKJGAXztXvlGGHbgvnJ8LaZ+rjKa+96IOJsMPGrP8vp
 K3gl469s1uBg==
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 01 Oct 2020 11:38:00 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v8 01/41] block: add bio_add_zone_append_page
Date:   Fri,  2 Oct 2020 03:36:08 +0900
Message-Id: <dece91bca322ce44bed19f2b0f460fa5ded2e512.1601574234.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1601572459.git.naohiro.aota@wdc.com>
References: <cover.1601572459.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Add bio_add_zone_append_page(), a wrapper around bio_add_hw_page() which
is intended to be used by file systems that directly add pages to a bio
instead of using bio_iov_iter_get_pages().

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 block/bio.c         | 36 ++++++++++++++++++++++++++++++++++++
 include/linux/bio.h |  2 ++
 2 files changed, 38 insertions(+)

diff --git a/block/bio.c b/block/bio.c
index e865ea55b9f9..e0d41ccc4e90 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -853,6 +853,42 @@ int bio_add_pc_page(struct request_queue *q, struct bio *bio,
 }
 EXPORT_SYMBOL(bio_add_pc_page);
 
+/**
+ * bio_add_zone_append_page - attempt to add page to zone-append bio
+ * @bio: destination bio
+ * @page: page to add
+ * @len: vec entry length
+ * @offset: vec entry offset
+ *
+ * Attempt to add a page to the bio_vec maplist of a bio that will be submitted
+ * for a zone-append request. This can fail for a number of reasons, such as the
+ * bio being full or the target block device is not a zoned block device or
+ * other limitations of the target block device. The target block device must
+ * allow bio's up to PAGE_SIZE, so it is always possible to add a single page
+ * to an empty bio.
+ */
+int bio_add_zone_append_page(struct bio *bio, struct page *page,
+			     unsigned int len, unsigned int offset)
+{
+	struct request_queue *q;
+	bool same_page = false;
+
+	if (WARN_ON_ONCE(bio_op(bio) != REQ_OP_ZONE_APPEND))
+		return 0;
+
+	if (WARN_ON_ONCE(!bio->bi_disk))
+		return 0;
+
+	q = bio->bi_disk->queue;
+
+	if (WARN_ON_ONCE(!blk_queue_is_zoned(q)))
+		return 0;
+
+	return bio_add_hw_page(q, bio, page, len, offset,
+			       queue_max_zone_append_sectors(q), &same_page);
+}
+EXPORT_SYMBOL_GPL(bio_add_zone_append_page);
+
 /**
  * __bio_try_merge_page - try appending data to an existing bvec.
  * @bio: destination bio
diff --git a/include/linux/bio.h b/include/linux/bio.h
index c6d765382926..7ef300cb4e9a 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -442,6 +442,8 @@ void bio_chain(struct bio *, struct bio *);
 extern int bio_add_page(struct bio *, struct page *, unsigned int,unsigned int);
 extern int bio_add_pc_page(struct request_queue *, struct bio *, struct page *,
 			   unsigned int, unsigned int);
+int bio_add_zone_append_page(struct bio *bio, struct page *page,
+			     unsigned int len, unsigned int offset);
 bool __bio_try_merge_page(struct bio *bio, struct page *page,
 		unsigned int len, unsigned int off, bool *same_page);
 void __bio_add_page(struct bio *bio, struct page *page,
-- 
2.27.0

