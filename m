Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2E2724CFA7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Aug 2020 09:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728358AbgHUHlO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Aug 2020 03:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728251AbgHUHkl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Aug 2020 03:40:41 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A13C1C061346
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2020 00:40:41 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id d4so463376pjx.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2020 00:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N1N4BTnl4BaaYraexKEAlh2R7kwx90CEeerw/26WSug=;
        b=BXNiuBbZOZkAJvbBGbzKIlsbNo3cFOHkqLme1JEMS8uq9yYeDlgRPMn2BQoec8ylsr
         8Psr06jSo9TnEsOX+E2saOj11H4du91qvpkCtPus7xGc4ygo6njrzLQ1O9ai228HjN+O
         4QGbnLeSUUE53vvnbmUBFtHv7oWuQN9F0445cf8JCMtqP3KdsdMZnO+ZdR2F5fSTALo1
         uZLIY4W3m2PBqsgxWpZ9uwt1PTeHKKstqFuaEO6BS6lebjSNhLK8mlPmJSfwPzUTp7kE
         EoVHUS6oGdVsfiH0iP02qXmwAavvtSBdHfwoFEYub6EDPUAoGvC4Yyhrki02DKyRVfSz
         HbGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N1N4BTnl4BaaYraexKEAlh2R7kwx90CEeerw/26WSug=;
        b=ZbUdyjYlLaga7L4guUs6isO0Jqmp+jNvhwCRQ0tmIvFcg7bY7PriPTyyjhIiu7xXo1
         L5Tw4ulZz/07c/psxIodthXrGyufIMeRunj31+fpbdpRoSM6inQExBWgMKRoCLjfrpXv
         x08P/aoZI+GwOww7eT7neiFshoMtH2+huHYVdXCia7kFqnK4l3si4CzZXolfx5JrzlFC
         TWeR7FpC1Q4k/fn1PV2sYDYeMdQNDS8xgVgx4B33tdE+QTmC/CthBQxbSq/ONev71Rya
         Xk+Z4447vd9j8WvGBz11rC22i0d0D+VWoHz7fL8VBIG8Qk6Qaw+qdWkiFYoycr6mzFvc
         8K+g==
X-Gm-Message-State: AOAM532D6lofFb6pAnXkYbT+UGcO1s4rHtMbkvx7I1ou6AXXah9HkyXE
        5kYgZkSZSpMvKkUOfITtiTJ6NQ==
X-Google-Smtp-Source: ABdhPJz+TEw8htl0uMBxwjAa8AUNwxVt2AuNzHEQXhWxlIcalWWSvFVEjLQm4Uv2WLPemXg8RBixQg==
X-Received: by 2002:a17:902:407:: with SMTP id 7mr1388728ple.167.1597995641064;
        Fri, 21 Aug 2020 00:40:41 -0700 (PDT)
Received: from exodia.tfbnw.net ([2620:10d:c090:400::5:f2a4])
        by smtp.gmail.com with ESMTPSA id jb1sm1080875pjb.9.2020.08.21.00.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 00:40:39 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 03/11] btrfs-progs: receive: support v2 send stream DATA tlv format
Date:   Fri, 21 Aug 2020 00:40:02 -0700
Message-Id: <fb40593fee0c6d6d6c0c2c75bbaea5c33f7523d0.1597994354.git.osandov@osandov.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1597994106.git.osandov@osandov.com>
References: <cover.1597994106.git.osandov@osandov.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Boris Burkov <borisb@fb.com>

The new format privileges the BTRFS_SEND_A_DATA attribute by
guaranteeing it will always be the last attribute in any command that
needs it, and by implicitly encoding the data length as the difference
between the total command length in the command header and the sizes of
the rest of the attributes (and of course the tlv_type identifying the
DATA attribute). To parse the new stream, we must read the tlv_type and
if it is not DATA, we proceed normally, but if it is DATA, we don't
parse a tlv_len but simply compute the length.

In addition, we add some bounds checking when parsing each chunk of
data, as well as for the tlv_len itself.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 common/send-stream.c | 36 ++++++++++++++++++++++++++----------
 1 file changed, 26 insertions(+), 10 deletions(-)

diff --git a/common/send-stream.c b/common/send-stream.c
index 51a6a94a..77d5cd04 100644
--- a/common/send-stream.c
+++ b/common/send-stream.c
@@ -165,28 +165,44 @@ static int read_cmd(struct btrfs_send_stream *sctx)
 
 	pos = 0;
 	while (pos < cmd_len) {
-		struct btrfs_tlv_header *tlv_hdr;
 		u16 tlv_type;
-		u16 tlv_len;
 		struct btrfs_send_attribute *send_attr;
 
-		tlv_hdr = (struct btrfs_tlv_header *)data;
-		tlv_type = le16_to_cpu(tlv_hdr->tlv_type);
-		tlv_len = le16_to_cpu(tlv_hdr->tlv_len);
+		if (cmd_len - pos < sizeof(__le16)) {
+			error("send stream is truncated");
+			ret = -EINVAL;
+			goto out;
+		}
+		tlv_type = le16_to_cpu(*(__le16 *)data);
 
 		if (tlv_type == 0 || tlv_type > BTRFS_SEND_A_MAX) {
-			error("invalid tlv in cmd tlv_type = %hu, tlv_len = %hu",
-					tlv_type, tlv_len);
+			error("invalid tlv in cmd tlv_type = %hu", tlv_type);
 			ret = -EINVAL;
 			goto out;
 		}
 
 		send_attr = &sctx->cmd_attrs[tlv_type];
 		send_attr->tlv_type = tlv_type;
-		send_attr->tlv_len = tlv_len;
-		pos += sizeof(*tlv_hdr);
-		data += sizeof(*tlv_hdr);
 
+		pos += sizeof(tlv_type);
+		data += sizeof(tlv_type);
+		if (sctx->version == 2 && tlv_type == BTRFS_SEND_A_DATA) {
+			send_attr->tlv_len = cmd_len - pos;
+		} else {
+			if (cmd_len - pos < sizeof(__le16)) {
+				error("send stream is truncated");
+				ret = -EINVAL;
+				goto out;
+			}
+			send_attr->tlv_len = le16_to_cpu(*(__le16 *)data);
+			pos += sizeof(__le16);
+			data += sizeof(__le16);
+		}
+		if (cmd_len - pos < send_attr->tlv_len) {
+			error("send stream is truncated");
+			ret = -EINVAL;
+			goto out;
+		}
 		send_attr->data = data;
 		pos += send_attr->tlv_len;
 		data += send_attr->tlv_len;
-- 
2.28.0

