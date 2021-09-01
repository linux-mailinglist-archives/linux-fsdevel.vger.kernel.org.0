Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5D13FE0BD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Sep 2021 19:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345539AbhIARCv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Sep 2021 13:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345665AbhIARCs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Sep 2021 13:02:48 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7921C0613C1
        for <linux-fsdevel@vger.kernel.org>; Wed,  1 Sep 2021 10:01:51 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id 18so300020pfh.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Sep 2021 10:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uln2HVGAQYqVfchTpLKMoAipwuM7tlLjazsvAWo2m9E=;
        b=Kuf6yfFRpXAnuJEQTU1+YH+WjEDHNNKPKABTHYeCW+sm8D9rCJfd4NSoFSfXOjfK0C
         vTBcAH0ty6U7uh/8t8sPH9P7xc2NJn7JZXItAiBpNzhouWU07QQHjvVvzofCnmi+JASR
         ckSYEoHXOwSM6apmW5WNzFbTC4YMVNuYITdirI/+NSgoQGUHC5NLHoHVbpdP71ijUYU8
         VMYEbx4LRx4tGiY/FSXWm5i3TIZlz7HRDhjYniSRfqCJJcJqAXw8DOigWg1hjmAfU7iP
         I2nhba7QjKIYKdNPADvYYFG7wfMppMpFStDjoA1xho/nNXl6RqYzdUpxmzzL4xfigIqt
         xoDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uln2HVGAQYqVfchTpLKMoAipwuM7tlLjazsvAWo2m9E=;
        b=BLh/FnoQu+paWc90YrsNNZTHPNQRqSlkvQLqAUOqavI9/nsMiCud/7ywimGRYbYBkn
         4+i0FUggCpfou1RDhShnKfp1BYn6PYIAWv0S18zHopy27Ezz6YXXYViAs9uGNx0Bfpvd
         Paf7SvUQ3RSG696yI6HaJSbhcxAdXtn2dSm1jiC9Hp840G8bGOH9Qti2PxGTdX9Pya0T
         h+rC8Yp9Bo3SP/gF+K3v66hPt7u6jE00toJbFmB1v5D8Db3as8hEWUXKbX16AVZjbJZb
         ++pwL9mVF5dvTVibTnkCd4r3P5PbTrvW0lpkhqrr1vOm7WIvHIZImJ25IiuPGP+mWR6B
         WMWg==
X-Gm-Message-State: AOAM533nHAOzM51eiMELJI5Ki8cjh6hta9ewALDcZvewFM+ghd//5fBr
        SjfodmCYRFTHICRsz14f8szi7eLlqp0JUw==
X-Google-Smtp-Source: ABdhPJzFtAnewtQI57YgBYsbiYSAQLLZbLy/4YfYZ7s+jeUlku3e7gkfS9k+6pk+4+qocnbOdhusOQ==
X-Received: by 2002:a65:62c1:: with SMTP id m1mr63421pgv.339.1630515711182;
        Wed, 01 Sep 2021 10:01:51 -0700 (PDT)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:a2b2])
        by smtp.gmail.com with ESMTPSA id y7sm58642pff.206.2021.09.01.10.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 10:01:50 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: [PATCH v11 01/10] btrfs-progs: receive: support v2 send stream larger tlv_len
Date:   Wed,  1 Sep 2021 10:01:10 -0700
Message-Id: <8729477d23b83c368a76c4f39b5f73a483a3ad14.1630515568.git.osandov@fb.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1630514529.git.osandov@fb.com>
References: <cover.1630514529.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Boris Burkov <borisb@fb.com>

An encoded extent can be up to 128K in length, which exceeds the largest
value expressible by the current send stream format's 16 bit tlv_len
field. Since encoded writes cannot be split into multiple writes by
btrfs send, the send stream format must change to accommodate encoded
writes.

Supporting this changed format requires retooling how we store the
commands we have processed. Since we can no longer use btrfs_tlv_header
to describe every attribute, we define a new struct btrfs_send_attribute
which has a 32 bit length field, and use that to store the attribute
information needed for receive processing. This is transparent to users
of the various TLV_GET macros.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 common/send-stream.c | 34 +++++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/common/send-stream.c b/common/send-stream.c
index a0c52f79..cd5aa311 100644
--- a/common/send-stream.c
+++ b/common/send-stream.c
@@ -24,13 +24,23 @@
 #include "crypto/crc32c.h"
 #include "common/utils.h"
 
+struct btrfs_send_attribute {
+	u16 tlv_type;
+	/*
+	 * Note: in btrfs_tlv_header, this is __le16, but we need 32 bits for
+	 * attributes with file data as of version 2 of the send stream format
+	 */
+	u32 tlv_len;
+	char *data;
+};
+
 struct btrfs_send_stream {
 	char read_buf[BTRFS_SEND_BUF_SIZE];
 	int fd;
 
 	int cmd;
 	struct btrfs_cmd_header *cmd_hdr;
-	struct btrfs_tlv_header *cmd_attrs[BTRFS_SEND_A_MAX + 1];
+	struct btrfs_send_attribute cmd_attrs[BTRFS_SEND_A_MAX + 1];
 	u32 version;
 
 	/*
@@ -152,6 +162,7 @@ static int read_cmd(struct btrfs_send_stream *sctx)
 		struct btrfs_tlv_header *tlv_hdr;
 		u16 tlv_type;
 		u16 tlv_len;
+		struct btrfs_send_attribute *send_attr;
 
 		tlv_hdr = (struct btrfs_tlv_header *)data;
 		tlv_type = le16_to_cpu(tlv_hdr->tlv_type);
@@ -164,10 +175,15 @@ static int read_cmd(struct btrfs_send_stream *sctx)
 			goto out;
 		}
 
-		sctx->cmd_attrs[tlv_type] = tlv_hdr;
+		send_attr = &sctx->cmd_attrs[tlv_type];
+		send_attr->tlv_type = tlv_type;
+		send_attr->tlv_len = tlv_len;
+		pos += sizeof(*tlv_hdr);
+		data += sizeof(*tlv_hdr);
 
-		data += sizeof(*tlv_hdr) + tlv_len;
-		pos += sizeof(*tlv_hdr) + tlv_len;
+		send_attr->data = data;
+		pos += send_attr->tlv_len;
+		data += send_attr->tlv_len;
 	}
 
 	sctx->cmd = cmd;
@@ -180,7 +196,7 @@ out:
 static int tlv_get(struct btrfs_send_stream *sctx, int attr, void **data, int *len)
 {
 	int ret;
-	struct btrfs_tlv_header *hdr;
+	struct btrfs_send_attribute *send_attr;
 
 	if (attr <= 0 || attr > BTRFS_SEND_A_MAX) {
 		error("invalid attribute requested, attr = %d", attr);
@@ -188,15 +204,15 @@ static int tlv_get(struct btrfs_send_stream *sctx, int attr, void **data, int *l
 		goto out;
 	}
 
-	hdr = sctx->cmd_attrs[attr];
-	if (!hdr) {
+	send_attr = &sctx->cmd_attrs[attr];
+	if (!send_attr->data) {
 		error("attribute %d requested but not present", attr);
 		ret = -ENOENT;
 		goto out;
 	}
 
-	*len = le16_to_cpu(hdr->tlv_len);
-	*data = hdr + 1;
+	*len = send_attr->tlv_len;
+	*data = send_attr->data;
 
 	ret = 0;
 
-- 
2.33.0

