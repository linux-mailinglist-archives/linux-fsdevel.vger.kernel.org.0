Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC3B3EF479
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Aug 2021 23:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234825AbhHQVIH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Aug 2021 17:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234693AbhHQVIF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Aug 2021 17:08:05 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA5FC0617AF
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Aug 2021 14:07:30 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id j1so1199547pjv.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Aug 2021 14:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tw8xR2a6I/yCN/dxhxbTeM3MwYqBNV7e97Y2x/4SyLg=;
        b=HRWt9l81TyzGLcksTQN3zlvLHVlZjCt8MFXGdw7TTACh0NAQr1mEXuS/vV5LT2gJby
         4/M7NhZbEVV5ATUDwDebIBVoKBD7UQ/X5fPO0slQHHUXfzbOKuagylNHcWmgR/JS07DE
         PuWzj1rsu1m0NwvgfUG+8ftm2+1rEr6D6X0/tEFAu2d0ZbZlC+QxxzQoppll/8ym6PTD
         +HsOiwqMccqT8kDNfg5d0ch4qQXREIO2LsYVhtgLRkJtMzb6XjuJ1c1oZ7vkUyJRYK8K
         Rbzo5oDP+ih4rhLWjkhjaqJldOsSuRAsBWsqpxAwajBurvZrfETeXgspNZSEH5Rb4etk
         odBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tw8xR2a6I/yCN/dxhxbTeM3MwYqBNV7e97Y2x/4SyLg=;
        b=RoGpyK7KOq7xerw+BnmF/nvzVvkAatFA9m9USVSFAwafOrVEjUdk1j/z5IjTXKuvA5
         6YJFtiRQoP5PQfqZydHcUhMbPM/afKyc+5YiKLAKWyheA+TerEjb3AJlq0dK72WB69k0
         5ckeX33VXELFMUJ6ecdo8t/V26bo8rmLz6OcDN6RWStYvxE14deVRDXVKYph8Gq6RsF4
         dVDxA3LlLhlVB7w3XEIeIV/yr+40+vgdY5nbI+mghkbamj4Ql8Co1JqVCs9h2mkExJkh
         494SrAJIVCgE/v4MhXQJsw9aYdUcuj+J/YuSprleIGpexPWi1JTpnq9MS9uODlmCSReb
         6cqw==
X-Gm-Message-State: AOAM532U5NVfQXeIpXihztroCrn9CM4R8OgvQI9y0Y1ga0Y27clzt064
        no884lxUjnj7DaJjU3LEfiVFJw==
X-Google-Smtp-Source: ABdhPJzTmKc+T0N2I/81nNABreZEZnYxWpFYCcwa6KOlMhCnMFAPi5njvOxmWqbW/ZhIVa149b4lpQ==
X-Received: by 2002:a62:ea06:0:b0:3e1:62a6:95b8 with SMTP id t6-20020a62ea06000000b003e162a695b8mr5602149pfh.70.1629234449775;
        Tue, 17 Aug 2021 14:07:29 -0700 (PDT)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:df70])
        by smtp.gmail.com with ESMTPSA id c9sm4205194pgq.58.2021.08.17.14.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 14:07:29 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, linux-fsdevel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-api@vger.kernel.org
Subject: [PATCH v10 11/14] btrfs: send: write larger chunks when using stream v2
Date:   Tue, 17 Aug 2021 14:06:43 -0700
Message-Id: <7d186d9f0bbc03f2c72e3fd0546d01d529230ffc.1629234193.git.osandov@fb.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1629234193.git.osandov@fb.com>
References: <cover.1629234193.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

The length field of the send stream TLV header is 16 bits. This means
that the maximum amount of data that can be sent for one write is 64k
minus one. However, encoded writes must be able to send the maximum
compressed extent (128k) in one command. To support this, send stream
version 2 encodes the DATA attribute differently: it has no length
field, and the length is implicitly up to the end of containing command
(which has a 32-bit length field). Although this is necessary for
encoded writes, normal writes can benefit from it, too.

For v2, let's bump up the send buffer to the maximum compressed extent
size plus 16k for the other metadata (144k total). Since this will most
likely be vmalloc'd (and always will be after the next commit), we round
it up to the next page since we might as well use the rest of the page
on systems with >16k pages.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/send.c | 34 ++++++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 02ac158837ce..dfe598d12b8c 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -4915,14 +4915,27 @@ static inline u64 max_send_read_size(const struct send_ctx *sctx)
 
 static int put_data_header(struct send_ctx *sctx, u32 len)
 {
-	struct btrfs_tlv_header *hdr;
+	if (sctx->flags & BTRFS_SEND_FLAG_STREAM_V2) {
+		/*
+		 * In v2, the data attribute header doesn't include a length; it
+		 * is implicitly to the end of the command.
+		 */
+		if (sctx->send_max_size - sctx->send_size < 2 + len)
+			return -EOVERFLOW;
+		put_unaligned_le16(BTRFS_SEND_A_DATA,
+				   sctx->send_buf + sctx->send_size);
+		sctx->send_size += 2;
+	} else {
+		struct btrfs_tlv_header *hdr;
 
-	if (sctx->send_max_size - sctx->send_size < sizeof(*hdr) + len)
-		return -EOVERFLOW;
-	hdr = (struct btrfs_tlv_header *)(sctx->send_buf + sctx->send_size);
-	put_unaligned_le16(BTRFS_SEND_A_DATA, &hdr->tlv_type);
-	put_unaligned_le16(len, &hdr->tlv_len);
-	sctx->send_size += sizeof(*hdr);
+		if (sctx->send_max_size - sctx->send_size < sizeof(*hdr) + len)
+			return -EOVERFLOW;
+		hdr = (struct btrfs_tlv_header *)(sctx->send_buf +
+						  sctx->send_size);
+		put_unaligned_le16(BTRFS_SEND_A_DATA, &hdr->tlv_type);
+		put_unaligned_le16(len, &hdr->tlv_len);
+		sctx->send_size += sizeof(*hdr);
+	}
 	return 0;
 }
 
@@ -7294,7 +7307,12 @@ long btrfs_ioctl_send(struct file *mnt_file, struct btrfs_ioctl_send_args *arg)
 
 	sctx->clone_roots_cnt = arg->clone_sources_count;
 
-	sctx->send_max_size = BTRFS_SEND_BUF_SIZE_V1;
+	if (sctx->flags & BTRFS_SEND_FLAG_STREAM_V2) {
+		sctx->send_max_size = ALIGN(SZ_16K + BTRFS_MAX_COMPRESSED,
+					    PAGE_SIZE);
+	} else {
+		sctx->send_max_size = BTRFS_SEND_BUF_SIZE_V1;
+	}
 	sctx->send_buf = kvmalloc(sctx->send_max_size, GFP_KERNEL);
 	if (!sctx->send_buf) {
 		ret = -ENOMEM;
-- 
2.32.0

