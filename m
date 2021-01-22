Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 822A8300E41
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 21:55:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729786AbhAVUyu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jan 2021 15:54:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728924AbhAVUwZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jan 2021 15:52:25 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F80DC0613D6
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Jan 2021 12:48:27 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id c132so4623975pga.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Jan 2021 12:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Bt0vf2xnnq+L7u6gm6lH9LhabqXbnPeiGL7bkGtie2s=;
        b=gAT0Ly07k45VtTc+4CiL8nznhXVDFcaWwBJQFMc9cAO1mkwnFVOrZhYBQNcsu0/etw
         L5KjT8wznAna7OKfQgn04+MPFD9KAZuAppiCWcGJyAhmJGV6HqalreC1ZHkI9X5tpC5N
         Q2uiKuCrVJGkgZqwXwwFqMceCeMp+f9onIt6LIe7VK8blQ/EjiEpduaI8tUq/0ebi2il
         nVgKPhFxIZlCWN0A1L87ISOtD03GkR4GiOyVdfgKUgr2NAVPNt4w3hFF8G5wYHgY7zOT
         dPM8OPEWUg6DgZawSX72JNpATaQ2mB9WOvEtU5hyJs6qZvFnqeDoCiOPklrnQgIt3+TJ
         BNlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Bt0vf2xnnq+L7u6gm6lH9LhabqXbnPeiGL7bkGtie2s=;
        b=ilF/1Bxl6Nw3ON0jNjIGFXzNqqrSBRoCvMddh11NNmekj66ayKsaQhUxNsH02F/1GC
         SK9AB1S8bnG2h0LG5g9gNSAcMZxmkCoEyCyz072MkhPc7zo4xcoaTYPsueHzh06uRKSR
         8HczqIiUuRY4MxIcajUlwtSMoolfJi8YpSJQ6ZQqo7IJDVcwTq3s/y5ixcE/u4Q38C/a
         DWx2Lya+VxBrxqbXHOcSfVhUxY6QmfNgsUJ1rsLspuSPwVc7KzvieGLWkASzSAblXpiv
         efgJvL7kjkLzi494KPzWhVwdoczRbiN5ht0yL8thbf1rDP5OaNPW0/ii7DITl0LR/gjX
         vFIw==
X-Gm-Message-State: AOAM5335Rvh2wzkBJaHHi5CR2rhJ8HumF+zm87c6CZDGZEWInZwKLFwO
        sSEgNeYHdAX03pCQo5UmrDtzVzf3S42f8A==
X-Google-Smtp-Source: ABdhPJwXj/ytmwn93g/hryffgdZFG49b4q2h8dVPQMfyg+S3ztuJy8v2hsgafy2t1dMXoON4TvFlEw==
X-Received: by 2002:a62:5383:0:b029:1b6:20bf:e5a1 with SMTP id h125-20020a6253830000b02901b620bfe5a1mr6860974pfb.58.1611348507188;
        Fri, 22 Jan 2021 12:48:27 -0800 (PST)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:ea88])
        by smtp.gmail.com with ESMTPSA id y16sm9865617pfb.83.2021.01.22.12.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 12:48:25 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 03/11] btrfs-progs: receive: support v2 send stream DATA tlv format
Date:   Fri, 22 Jan 2021 12:47:47 -0800
Message-Id: <58df81982267169d549b982091a4ccb0b3ac4c5d.1611347859.git.osandov@osandov.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1611347187.git.osandov@fb.com>
References: <cover.1611347187.git.osandov@fb.com>
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
2.30.0

