Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E41BE33DDF0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Mar 2021 20:46:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240651AbhCPTpg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Mar 2021 15:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240593AbhCPToc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Mar 2021 15:44:32 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B80DEC061756
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Mar 2021 12:44:30 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id v14so16387009pgq.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Mar 2021 12:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=afne12eWxC99ZM3RzCisiw1S1UD3p193Z3PzLDJZPos=;
        b=gjVKxFNzVzllJs/RT8W4Egbh/OE3HnDf+Y0CMunCLsQxm014Xg6DKCojAJJe5I4a2P
         J+4pnnGsjw4pa274nBt037XOwFcOOJk9V5VaJy98lcQ1oDXXEhyh/PtELyC4Z/gKQExY
         XzrLQ8UQszcVkcb/Q414EFgaAa3L3cgrFGecymz+noqUHKjU76ADky4mrcK0npU2glI6
         3eMgoZ0RcdFu/vkPDQXwocLDa2/cap5PltYtN4MdcDxdWiGUiqgEcnWdwriCRUBi91xa
         jvGmmOscb+iWggMmd9+fU5O+EfsjQjD3bZRV0B/vTIxNXloOKaqVBM08Sf2P5PyTgjA/
         aUSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=afne12eWxC99ZM3RzCisiw1S1UD3p193Z3PzLDJZPos=;
        b=hyIqEM7Ejsl7dftgidAkXe6ox55nvEbIEGyQ7nKMCn+t3O1z5Ks/CLOZRPfJiq2h4p
         H80LX4ggjuJqjhbZkkiiR9VyIaw8zOPCTDJZCnOt04E8LetDUAZa6EWdWgHpwP98z6ix
         HfvZGHJJmX47cc3M7JFKTZdXjXYBkAWMwWTBYaxmQ2maQ4LmYZpNAMMu06hf/eJqSSSw
         ui/5HSyWjNHWuss6I5NilE6VhlFy7qTaBsCNx0xlmD7Omj7dwVqyuW6v5nqbNvYXQ3wX
         PIbfmP+4nDovN3N/4+qOw3pp+Q8kvThOqR/GGSYD5FnXecJBmtU+Ar6qvBDOvMAcjjGF
         u2Dw==
X-Gm-Message-State: AOAM533CqshfpsHTmfv7LM5bNf9dT9g0pWoPk/IkiYfUO1FE+0r2H9xy
        WDdj9im7ukY6ptRX4t3+aDCBRA==
X-Google-Smtp-Source: ABdhPJxYjxHpYGvE1UsK7N+mxBKfr8/iFr+Lwt+g/ozLYXOMwkRO+SVrODMOPJKOj8V6Hd+K0NIIhQ==
X-Received: by 2002:a63:4708:: with SMTP id u8mr1162155pga.102.1615923870318;
        Tue, 16 Mar 2021 12:44:30 -0700 (PDT)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:532])
        by smtp.gmail.com with ESMTPSA id w22sm16919104pfi.133.2021.03.16.12.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 12:44:29 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 03/11] btrfs-progs: receive: support v2 send stream DATA tlv format
Date:   Tue, 16 Mar 2021 12:43:54 -0700
Message-Id: <4ce95af75a4596ca20fed3d5112a600616e3e985.1615922859.git.osandov@osandov.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1615922753.git.osandov@fb.com>
References: <cover.1615922753.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 3d3585c3..4d819185 100644
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
2.30.2

