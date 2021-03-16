Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFB8833DDE4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Mar 2021 20:45:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240621AbhCPTpD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Mar 2021 15:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240584AbhCPToY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Mar 2021 15:44:24 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D638DC061756
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Mar 2021 12:44:23 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id w34so22251903pga.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Mar 2021 12:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jZrSTcmazmtFthQfVzPJZ2x5Gg/YBmitG9JH3bMhW2M=;
        b=k1emE4N9PeUn+HjoBCWU3u042syqDlmnav39G4fD/cmD1EuvIT4hTnRuffrvXoNpcs
         j20WIHTbi03ahcJZT6j7oCeAqMsSf5Ie7JcXItgJkPQa9npbKZv8lC2V3iKETfyRF42M
         tUrTpuQ/lGd2LwU8mLx48D+2H8am/t/stSVUJ9AuC56F0HC4eOYp7VL4FTioVK4gRlx0
         82wRRkT6aa/qE1nB9c1zt4U0uy8xX65xvOzm2FyZdQKgTo3BkiOJOaYfwD3T0fHqlQ72
         huIbgiEtZ07F+58Q2M2RW5X+Hh2Q8Imc40l8ZKlUDjS6A6bF78t5lpzpWmvuvcdH0Zdz
         mGAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jZrSTcmazmtFthQfVzPJZ2x5Gg/YBmitG9JH3bMhW2M=;
        b=UE89ZrH2uPJux4Awt7LzzatTjPzZgRu9KU/Q7SgPIT+JySj6uoZCYIiNpwY0rHNkdl
         BrIAKpX6CpuzpWFq1QlSAGCplrM6DU436Y5udqbxguy7Of4/jbaiIqAC93rTI+zCWbfe
         pZ0jWdgurbvpECI4/FSx4zi6JbuR6vnQJTN/ECib1HY7kCp2XVdNDxRV446KkxNvI5Tx
         jGRm3hW+X2T7J9sZIP5uj075h+VTZX72zanoLG6xyb0vm0VchoVxAmWaz4QC+H5Vcyfd
         BXqdWEzYRBxJZiZ382605fgMh+RhdMkxQBajCi4eRYYcS/3s7AyToFHb23U9eBm4b4zD
         yHOg==
X-Gm-Message-State: AOAM532z9tL02l+dQwD2SSO4BkRSx7I7QL7HAblqjZItiWaKmYJzcQFs
        A4ROPYwsmEErKQ/bunb+21CkoQ==
X-Google-Smtp-Source: ABdhPJz5l3OpzRSIAlAbcB2PScfh0mtc6vJvWgoS5gx2k3I3zCWnnzd1VEfVKcN88nIHuhGG0Juo1g==
X-Received: by 2002:a63:1350:: with SMTP id 16mr1120350pgt.85.1615923863404;
        Tue, 16 Mar 2021 12:44:23 -0700 (PDT)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:532])
        by smtp.gmail.com with ESMTPSA id w22sm16919104pfi.133.2021.03.16.12.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 12:44:22 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 01/11] btrfs-progs: receive: support v2 send stream larger tlv_len
Date:   Tue, 16 Mar 2021 12:43:51 -0700
Message-Id: <69201100820c1c8df863eb353d02a8f5e35f44d5.1615922859.git.osandov@osandov.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1615922753.git.osandov@fb.com>
References: <cover.1615922753.git.osandov@fb.com>
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
2.30.2

