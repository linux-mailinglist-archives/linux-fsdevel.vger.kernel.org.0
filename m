Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28E641C524F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 May 2020 11:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728713AbgEEJ7d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 May 2020 05:59:33 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:52577 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728700AbgEEJ73 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 May 2020 05:59:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588672767;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9rEQgq0n2zQNPcIwMRs6h5ARye1Rkk4BmUOM1dwLbDA=;
        b=cUIGKLVShKMg8eDE1wisxDY2aMbM1Beg4NDXtTHiyrZvfseIMEsV/h+5ZtdnTCi6M5eP6g
        BIVBZ8FcvzuvarSzCCN6yGjj5+B3WJudeiRyRydnBvjHjp1LaUWgq3tZEa/BL7FxP/jKI1
        s6CrFHbRduRFtXDHZKf2jq8+cmiR39I=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-496-YXYwpnjSPn-9ZMMJp-qHhw-1; Tue, 05 May 2020 05:59:26 -0400
X-MC-Unique: YXYwpnjSPn-9ZMMJp-qHhw-1
Received: by mail-wr1-f71.google.com with SMTP id q13so964642wrn.14
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 May 2020 02:59:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9rEQgq0n2zQNPcIwMRs6h5ARye1Rkk4BmUOM1dwLbDA=;
        b=BQPY35RxSKUu1uquNqfoR7QA5XhWZE8ztMlYpOPY3t4ptfmsaw9sugVmSHq/BUYc0V
         aRls2hUv15DvJAVmnbaOQaEQ1qMmpWifzOXzWgnr3Lr5fYT24uNOlFo+UGbmOuGhIooc
         6/Fqs693l2+rdT+lKd2a5xl5yGV9i6gHU17QNxlp1Zogw8oP/qw5IkJZ0qnsKWL53nRv
         zpPvgRV6ecfDW34WlLfcSDWk8OfpPtsc2S99EIxpsrIwRhbXn9H6JO3le6chp5VVAyJ/
         /zvEnAE0Uik4w2cHOcY5kIkdPrna0XKyE4ZYwhuqJAr7R2S+X9xVEK7CuHKofZjL6UxC
         s4Gg==
X-Gm-Message-State: AGi0Pua2W99lAn0QyV35ihlxiOGDc11cJqLQnWFCOJFQBMTJT/456KAA
        7iE/Rm2OHcCc26zWZSVA4icr83YrzQEuTekhbNnPwngcgfiRpJHAh9qZ20FrC5Og30DRzQFJCI/
        yU6+SbaOXAdV9ZINEAAKrhjnPmw==
X-Received: by 2002:a1c:6405:: with SMTP id y5mr2400168wmb.63.1588672764605;
        Tue, 05 May 2020 02:59:24 -0700 (PDT)
X-Google-Smtp-Source: APiQypIhMi3j2nqO2MWoy8CJJ/UAxBVFaxgdYOm9aJaKfjOxrKh9K6Ko84tRV230umXoxFOuIT8unA==
X-Received: by 2002:a1c:6405:: with SMTP id y5mr2400148wmb.63.1588672764365;
        Tue, 05 May 2020 02:59:24 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id t16sm2862734wmi.27.2020.05.05.02.59.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 02:59:23 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Subject: [PATCH 06/12] uapi: deprecate STATX_ALL
Date:   Tue,  5 May 2020 11:59:09 +0200
Message-Id: <20200505095915.11275-7-mszeredi@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200505095915.11275-1-mszeredi@redhat.com>
References: <20200505095915.11275-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Constants of the *_ALL type can be actively harmful due to the fact that
developers will usually fail to consider the possible effects of future
changes to the definition.

Deprecate STATX_ALL in the uapi, while no damage has been done yet.

We could keep something like this around in the kernel, but there's
actually no point, since all filesystems should be explicitly checking
flags that they support and not rely on the VFS masking unknown ones out: a
flag could be known to the VFS, yet not known to the filesystem.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Michael Kerrisk <mtk.manpages@gmail.com>
---
 fs/stat.c                       |  1 -
 include/uapi/linux/stat.h       | 11 ++++++++++-
 samples/vfs/test-statx.c        |  2 +-
 tools/include/uapi/linux/stat.h | 11 ++++++++++-
 4 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/fs/stat.c b/fs/stat.c
index 030008796479..a6709e7ba71d 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -70,7 +70,6 @@ int vfs_getattr_nosec(const struct path *path, struct kstat *stat,
 
 	memset(stat, 0, sizeof(*stat));
 	stat->result_mask |= STATX_BASIC_STATS;
-	request_mask &= STATX_ALL;
 	query_flags &= KSTAT_QUERY_FLAGS;
 
 	/* allow the fs to override these if it really wants to */
diff --git a/include/uapi/linux/stat.h b/include/uapi/linux/stat.h
index ad80a5c885d5..d1192783139a 100644
--- a/include/uapi/linux/stat.h
+++ b/include/uapi/linux/stat.h
@@ -148,9 +148,18 @@ struct statx {
 #define STATX_BLOCKS		0x00000400U	/* Want/got stx_blocks */
 #define STATX_BASIC_STATS	0x000007ffU	/* The stuff in the normal stat struct */
 #define STATX_BTIME		0x00000800U	/* Want/got stx_btime */
-#define STATX_ALL		0x00000fffU	/* All currently supported flags */
+
 #define STATX__RESERVED		0x80000000U	/* Reserved for future struct statx expansion */
 
+#ifndef __KERNEL__
+/*
+ * This is deprecated, and shall remain the same value in the future.  To avoid
+ * confusion please use the equivalent (STATX_BASIC_STATS | STATX_BTIME)
+ * instead.
+ */
+#define STATX_ALL		0x00000fffU
+#endif
+
 /*
  * Attributes to be found in stx_attributes and masked in stx_attributes_mask.
  *
diff --git a/samples/vfs/test-statx.c b/samples/vfs/test-statx.c
index a3d68159fb51..76c577ea4fd8 100644
--- a/samples/vfs/test-statx.c
+++ b/samples/vfs/test-statx.c
@@ -216,7 +216,7 @@ int main(int argc, char **argv)
 	struct statx stx;
 	int ret, raw = 0, atflag = AT_SYMLINK_NOFOLLOW;
 
-	unsigned int mask = STATX_ALL;
+	unsigned int mask = STATX_BASIC_STATS | STATX_BTIME;
 
 	for (argv++; *argv; argv++) {
 		if (strcmp(*argv, "-F") == 0) {
diff --git a/tools/include/uapi/linux/stat.h b/tools/include/uapi/linux/stat.h
index ad80a5c885d5..d1192783139a 100644
--- a/tools/include/uapi/linux/stat.h
+++ b/tools/include/uapi/linux/stat.h
@@ -148,9 +148,18 @@ struct statx {
 #define STATX_BLOCKS		0x00000400U	/* Want/got stx_blocks */
 #define STATX_BASIC_STATS	0x000007ffU	/* The stuff in the normal stat struct */
 #define STATX_BTIME		0x00000800U	/* Want/got stx_btime */
-#define STATX_ALL		0x00000fffU	/* All currently supported flags */
+
 #define STATX__RESERVED		0x80000000U	/* Reserved for future struct statx expansion */
 
+#ifndef __KERNEL__
+/*
+ * This is deprecated, and shall remain the same value in the future.  To avoid
+ * confusion please use the equivalent (STATX_BASIC_STATS | STATX_BTIME)
+ * instead.
+ */
+#define STATX_ALL		0x00000fffU
+#endif
+
 /*
  * Attributes to be found in stx_attributes and masked in stx_attributes_mask.
  *
-- 
2.21.1

