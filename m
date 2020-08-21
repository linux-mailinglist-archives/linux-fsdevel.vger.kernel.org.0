Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BCAE24CF9D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Aug 2020 09:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbgHUHkp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Aug 2020 03:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728267AbgHUHk2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Aug 2020 03:40:28 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F20C061385
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2020 00:40:28 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id m71so678164pfd.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2020 00:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MpMHOROWH1K8dL9ToH1ce+0j8obccQVesOcDCSINSNg=;
        b=iau3GpV8ekB9m+DmlUkMpAcGc34fTiQC1Xkrmkdflfo80BK9SRQVIbkJcXexjwHMhf
         yLwurQrHHV9kx2jJUr9eCK2J26VhrOmBW2gMzW3eLN/3lVQ3en5/3/zx5QFRLq2X0qUa
         XSjhYR/xJkNn+x5tLTM4sRNfIugFG8JEDe7zqC7EGKLmrBJPm7AWBKjdIkZHD0ZDk/Hx
         vsCyLAeCDewv3odZ7axGSkfGsm+ponE2mDza8rBgO61tKP7QUSeqg3JDO31OmC8kOrWc
         wE6x4QH8fMoR+qUSc2Vvkrbk9rMoBM881+8o94PDHOKImxZZ9xEYL66k1TrVKYEMa5Qw
         Esfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MpMHOROWH1K8dL9ToH1ce+0j8obccQVesOcDCSINSNg=;
        b=QI48NU3R0ptHF2siZos3OnNTyJiBFQJzxhF/l8z5d3O5GqW7SSIQ4mCcO+7jsanZ16
         TW2fRXYihWyVCsc+RmRkFlsAq9H1CejlHbVsyNPVD1EOBWfnxuzCgkq+6DT58zQqv1Cv
         Rh0TiU6V00uC1DG6zOEWFz5A8TzUpZeFHsWYK4xzb9Z2V/P7QqDW0JQE9szvigTwHB0E
         0tkRK7RbwaECE7X9pdiZflU1haX+EP9oJjgmnhQ2B6vI1wFsI2pIMkAxbhaDeXnBw92D
         qRkKZrbfAdAaF0mN9atotlDzHuzregidksETc9YERZfaKBmgtfWrAN/3P8UPeEwgvVtc
         Rx4g==
X-Gm-Message-State: AOAM531riVVMCjFHRwMHZdhVt/4n5Khlp26jPAgjfCPHinLGGkb89W0n
        104DQ6GA6FhD0IAW/6vaZI+wF9TXeuIKBQ==
X-Google-Smtp-Source: ABdhPJydIf99Q5Hfrly97cyxhvALDoesvJp9B1+WUNcmfgiAj0fKuLIqZ6rzXogAAWcrSVCLW+xVig==
X-Received: by 2002:a62:8141:: with SMTP id t62mr1426534pfd.282.1597995627765;
        Fri, 21 Aug 2020 00:40:27 -0700 (PDT)
Received: from exodia.tfbnw.net ([2620:10d:c090:400::5:f2a4])
        by smtp.gmail.com with ESMTPSA id jb1sm1080875pjb.9.2020.08.21.00.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 00:40:26 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 6/9] btrfs: send: write larger chunks when using stream v2
Date:   Fri, 21 Aug 2020 00:39:56 -0700
Message-Id: <eebf24d3b42ef50a19ba9bc38ed5210d0cc87157.1597994106.git.osandov@osandov.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1597994106.git.osandov@osandov.com>
References: <cover.1597994106.git.osandov@osandov.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
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
index e25c3391fc02..c0f81d302f49 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -4799,14 +4799,27 @@ static u64 max_send_read_size(struct send_ctx *sctx)
 
 static int put_data_header(struct send_ctx *sctx, u32 len)
 {
-	struct btrfs_tlv_header *hdr;
+	if (sctx->flags & BTRFS_SEND_FLAG_STREAM_V2) {
+		__le16 tlv_type;
+
+		if (sctx->send_max_size - sctx->send_size <
+		    sizeof(tlv_type) + len)
+			return -EOVERFLOW;
+		tlv_type = cpu_to_le16(BTRFS_SEND_A_DATA);
+		memcpy(sctx->send_buf + sctx->send_size, &tlv_type,
+		       sizeof(tlv_type));
+		sctx->send_size += sizeof(tlv_type);
+	} else {
+		struct btrfs_tlv_header *hdr;
 
-	if (sctx->send_max_size - sctx->send_size < sizeof(*hdr) + len)
-		return -EOVERFLOW;
-	hdr = (struct btrfs_tlv_header *)(sctx->send_buf + sctx->send_size);
-	hdr->tlv_type = cpu_to_le16(BTRFS_SEND_A_DATA);
-	hdr->tlv_len = cpu_to_le16(len);
-	sctx->send_size += sizeof(*hdr);
+		if (sctx->send_max_size - sctx->send_size < sizeof(*hdr) + len)
+			return -EOVERFLOW;
+		hdr = (struct btrfs_tlv_header *)(sctx->send_buf +
+						  sctx->send_size);
+		hdr->tlv_type = cpu_to_le16(BTRFS_SEND_A_DATA);
+		hdr->tlv_len = cpu_to_le16(len);
+		sctx->send_size += sizeof(*hdr);
+	}
 	return 0;
 }
 
@@ -7136,7 +7149,12 @@ long btrfs_ioctl_send(struct file *mnt_file, struct btrfs_ioctl_send_args *arg)
 
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
2.28.0

