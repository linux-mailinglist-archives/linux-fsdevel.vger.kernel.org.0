Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3E462B84B7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Nov 2020 20:19:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbgKRTTP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Nov 2020 14:19:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727257AbgKRTTP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Nov 2020 14:19:15 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA6BDC0613D4
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2020 11:19:13 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id q34so1848007pgb.11
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2020 11:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3q2Oqtj8dfFGH+5O8y2xFre8FdN2AUaLsaYdJ9TIuIY=;
        b=MpU7al+XTm9RPKdhcCpVmCKrylEVe18Z+7BxLSjdqC/3OO74UKeKp71CWp6UH6GlFM
         u28NPklC/CsFZXKQ2pjomKFWr3BL83HL29mt3vEWaCtFzTKdjpb35XqntiToyp31V6+k
         F/+vkfdsmUEnSiDJNZC9Gja9c1yfBoKeQEPN3aTTpdKYSUpz3PhXyRWmcjqWaa8HQy3Z
         fLfQpa/FNJscCFPagyt/HQl+EIM0+T1ZhJ2cRSRidDoMR0snYWriQXgvVYJHkULpKxDY
         mf9srlHqKVsTJIvi7YvzvQMvnWEb+gPoSnIbjpLUtQaE/0FxCmv1tbPtj6smTY08iIQb
         WzJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3q2Oqtj8dfFGH+5O8y2xFre8FdN2AUaLsaYdJ9TIuIY=;
        b=js5gDfpBK4bEYFamwUjPup1ev/0mQhoBsVBey7PoumVaom0LWTaT4ITOAOeTM/r1v6
         0bWvKMrFXt5QLr02vmm8I1yX190YJajDl/cdHkXARWlkz5HOprazM7VIEmSP4J2iGYLq
         DY/BgBsixpuNz+E1PfjGbtoagX6PYd7lmclZcpMihE4/krTiPc0OYc8xjTkgERwKNT8t
         GDbEn0+cM73PIYkldUUayTNLkhCe5A5koLtKIoKPO4sbADjePnBXXPp+ZnNoCAAy5PsF
         ndQxNvrjTJChakdSuieNoQSizI+YPj7APp/nAN3AA4Yf4OGOXh9Yv2XynGA6PakZVDDL
         BU+Q==
X-Gm-Message-State: AOAM533iZTOppe2+a554+NtHDpV6e7sIM+LWWS5zxI+m/B5tDuRGR0ux
        OsfP4LTo4KsvIjh11k1DrYSz7RTIPI41SA==
X-Google-Smtp-Source: ABdhPJynVRRk1YtA/iA/xowELBPkoIP9SaPs1iY+y0yzmtOren+xHiIzXS2G2qG51Zr1sfkZL7evQQ==
X-Received: by 2002:a63:8d4b:: with SMTP id z72mr9581696pgd.327.1605727153409;
        Wed, 18 Nov 2020 11:19:13 -0800 (PST)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:8b43])
        by smtp.gmail.com with ESMTPSA id l9sm3197221pjy.10.2020.11.18.11.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 11:19:12 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 02/13] btrfs-progs: receive: support v2 send stream larger tlv_len
Date:   Wed, 18 Nov 2020 11:18:45 -0800
Message-Id: <adf79444c623c2867ec7419824bdae02ac862246.1605723745.git.osandov@osandov.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1605723600.git.osandov@fb.com>
References: <cover.1605723600.git.osandov@fb.com>
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
index 69d75168..3bd21d3f 100644
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
 	int fd;
 	char read_buf[BTRFS_SEND_BUF_SIZE];
 
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
2.29.2

