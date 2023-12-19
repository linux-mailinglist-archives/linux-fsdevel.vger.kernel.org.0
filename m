Return-Path: <linux-fsdevel+bounces-6447-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5D4817E87
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 01:09:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2D54286442
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 00:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F14D233E1;
	Tue, 19 Dec 2023 00:08:55 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F0B747E;
	Tue, 19 Dec 2023 00:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d3ddccfaffso310045ad.1;
        Mon, 18 Dec 2023 16:08:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702944533; x=1703549333;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=42p6S51yVjjRx4XaJ49dXrO2bR8JV9Iikw1taYqMYk4=;
        b=Zc70E/x7HlkevqQOTElAfgdbrQDlCwhyv/weXmgueX1Q3krXTJFGmzELfdnzjJTxff
         BbMyOBxqa/zVhCu9w7RJ8CzEo1BAxg7lv6eYLe1cJk/eoegMep3pJ4a+gmVllGN2W86x
         6IDQ/X7ybbA9ng/9SsmqQtPPulwVhvMQGQC5kuA+pKAEN25LnW9aN655JCOdvSCHXbKV
         4Sr39u8PJYB/1Eh4DxENbmqmbDkeaafS8FFfSTGtmM0oK4UddBzdzZuInfLggNBvHZFZ
         pErlYV4oVD6EGG7I3zRujxknAXWuiWOTQ04an6++VY5wtWXedrXPJgYCAXJqbgmm1Xlu
         BMOA==
X-Gm-Message-State: AOJu0YzQj2YTsdF3o2T2Jz9axmtFUbB/k9QoWJcJomj0F1mIdyCRbhF6
	yqTIKhvyZDbQW3owWe+z9MA=
X-Google-Smtp-Source: AGHT+IHSpSTcrQuUEvU/2d9ZRZvurskSv/BGP2UWyF636F6mMEtvj837VVzXglwVaF6IwfrxTC+8Ig==
X-Received: by 2002:a17:903:1245:b0:1d0:cbef:2efe with SMTP id u5-20020a170903124500b001d0cbef2efemr18855096plh.102.1702944533459;
        Mon, 18 Dec 2023 16:08:53 -0800 (PST)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:0:1000:8411:e67:7ba6:36a9:8cd5])
        by smtp.gmail.com with ESMTPSA id x17-20020a17090a531100b0028b050e8297sm118630pjh.18.2023.12.18.16.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 16:08:53 -0800 (PST)
From: Bart Van Assche <bvanassche@acm.org>
To: "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Daejun Park <daejun7.park@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Bart Van Assche <bvanassche@acm.org>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>
Subject: [PATCH v8 10/19] scsi: scsi_proto: Add structures and constants related to I/O groups and streams
Date: Mon, 18 Dec 2023 16:07:43 -0800
Message-ID: <20231219000815.2739120-11-bvanassche@acm.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231219000815.2739120-1-bvanassche@acm.org>
References: <20231219000815.2739120-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prepare for adding code that will query the I/O advice hints group
descriptors and for adding code that will retrieve the stream status.

Cc: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/Kconfig           |  5 +++
 drivers/scsi/Makefile          |  2 +
 drivers/scsi/scsi_proto_test.c | 56 ++++++++++++++++++++++++
 include/scsi/scsi_proto.h      | 78 ++++++++++++++++++++++++++++++++++
 4 files changed, 141 insertions(+)
 create mode 100644 drivers/scsi/scsi_proto_test.c

diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
index addac7fbe37b..83b542abfc29 100644
--- a/drivers/scsi/Kconfig
+++ b/drivers/scsi/Kconfig
@@ -232,6 +232,11 @@ config SCSI_SCAN_ASYNC
 	  Note that this setting also affects whether resuming from
 	  system suspend will be performed asynchronously.
 
+config SCSI_PROTO_TEST
+	tristate "scsi_proto.h unit tests" if !KUNIT_ALL_TESTS
+	depends on SCSI && KUNIT
+	default KUNIT_ALL_TESTS
+
 menu "SCSI Transports"
 	depends on SCSI
 
diff --git a/drivers/scsi/Makefile b/drivers/scsi/Makefile
index f055bfd54a68..1313ddf2fd1a 100644
--- a/drivers/scsi/Makefile
+++ b/drivers/scsi/Makefile
@@ -24,6 +24,8 @@ obj-$(CONFIG_SCSI_COMMON)	+= scsi_common.o
 
 obj-$(CONFIG_RAID_ATTRS)	+= raid_class.o
 
+obj-$(CONFIG_SCSI_PROTO_TEST)	+= scsi_proto_test.o
+
 # --- NOTE ORDERING HERE ---
 # For kernel non-modular link, transport attributes need to
 # be initialised before drivers
diff --git a/drivers/scsi/scsi_proto_test.c b/drivers/scsi/scsi_proto_test.c
new file mode 100644
index 000000000000..7fa0a78a2ad1
--- /dev/null
+++ b/drivers/scsi/scsi_proto_test.c
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright 2023 Google LLC
+ */
+#include <kunit/test.h>
+#include <asm-generic/unaligned.h>
+#include <scsi/scsi_proto.h>
+
+static void test_scsi_proto(struct kunit *test)
+{
+	static const union {
+		struct scsi_io_group_descriptor desc;
+		u8 arr[sizeof(struct scsi_io_group_descriptor)];
+	} d = { .arr = { 0x45, 0, 0, 0, 0xb0, 0xe4, 0xe3 } };
+	KUNIT_EXPECT_EQ(test, d.desc.io_advice_hints_mode + 0, 1);
+	KUNIT_EXPECT_EQ(test, d.desc.st_enble + 0, 1);
+	KUNIT_EXPECT_EQ(test, d.desc.cs_enble + 0, 0);
+	KUNIT_EXPECT_EQ(test, d.desc.ic_enable + 0, 1);
+	KUNIT_EXPECT_EQ(test, d.desc.acdlu + 0, 1);
+	KUNIT_EXPECT_EQ(test, d.desc.rlbsr + 0, 3);
+	KUNIT_EXPECT_EQ(test, d.desc.lbm_descriptor_type + 0, 0);
+	KUNIT_EXPECT_EQ(test, d.desc.params[0] + 0, 0xe4);
+	KUNIT_EXPECT_EQ(test, d.desc.params[1] + 0, 0xe3);
+
+	static const union {
+		struct scsi_stream_status s;
+		u8 arr[sizeof(struct scsi_stream_status)];
+	} ss = { .arr = { 0x80, 0, 0x12, 0x34, 0x3f } };
+	KUNIT_EXPECT_EQ(test, ss.s.perm + 0, 1);
+	KUNIT_EXPECT_EQ(test, get_unaligned_be16(&ss.s.stream_identifier),
+			0x1234);
+	KUNIT_EXPECT_EQ(test, ss.s.rel_lifetime + 0, 0x3f);
+
+	static const union {
+		struct scsi_stream_status_header h;
+		u8 arr[sizeof(struct scsi_stream_status_header)];
+	} sh = { .arr = { 1, 2, 3, 4, 0, 0, 5, 6 } };
+	KUNIT_EXPECT_EQ(test, get_unaligned_be32(&sh.h.len), 0x1020304);
+	KUNIT_EXPECT_EQ(test, get_unaligned_be16(&sh.h.number_of_open_streams),
+			0x506);
+}
+
+static struct kunit_case scsi_proto_test_cases[] = {
+	KUNIT_CASE(test_scsi_proto),
+	{}
+};
+
+static struct kunit_suite scsi_proto_test_suite = {
+	.name = "scsi_proto",
+	.test_cases = scsi_proto_test_cases,
+};
+kunit_test_suite(scsi_proto_test_suite);
+
+MODULE_DESCRIPTION("<scsi/scsi_proto.h> unit tests");
+MODULE_AUTHOR("Bart Van Assche");
+MODULE_LICENSE("GPL");
diff --git a/include/scsi/scsi_proto.h b/include/scsi/scsi_proto.h
index 07d65c1f59db..843106e1109f 100644
--- a/include/scsi/scsi_proto.h
+++ b/include/scsi/scsi_proto.h
@@ -10,6 +10,7 @@
 #ifndef _SCSI_PROTO_H_
 #define _SCSI_PROTO_H_
 
+#include <linux/build_bug.h>
 #include <linux/types.h>
 
 /*
@@ -126,6 +127,7 @@
 #define	SAI_READ_CAPACITY_16  0x10
 #define SAI_GET_LBA_STATUS    0x12
 #define SAI_REPORT_REFERRALS  0x13
+#define SAI_GET_STREAM_STATUS 0x16
 /* values for maintenance in */
 #define MI_REPORT_IDENTIFYING_INFORMATION 0x05
 #define MI_REPORT_TARGET_PGS  0x0a
@@ -275,6 +277,82 @@ struct scsi_lun {
 	__u8 scsi_lun[8];
 };
 
+/* SBC-5 IO advice hints group descriptor */
+struct scsi_io_group_descriptor {
+#if defined(__BIG_ENDIAN)
+	u8 io_advice_hints_mode: 2;
+	u8 reserved1: 3;
+	u8 st_enble: 1;
+	u8 cs_enble: 1;
+	u8 ic_enable: 1;
+#elif defined(__LITTLE_ENDIAN)
+	u8 ic_enable: 1;
+	u8 cs_enble: 1;
+	u8 st_enble: 1;
+	u8 reserved1: 3;
+	u8 io_advice_hints_mode: 2;
+#else
+#error
+#endif
+	u8 reserved2[3];
+	/* Logical block markup descriptor */
+#if defined(__BIG_ENDIAN)
+	u8 acdlu: 1;
+	u8 reserved3: 1;
+	u8 rlbsr: 2;
+	u8 lbm_descriptor_type: 4;
+#elif defined(__LITTLE_ENDIAN)
+	u8 lbm_descriptor_type: 4;
+	u8 rlbsr: 2;
+	u8 reserved3: 1;
+	u8 acdlu: 1;
+#else
+#error
+#endif
+	u8 params[2];
+	u8 reserved4;
+	u8 reserved5[8];
+};
+
+static_assert(sizeof(struct scsi_io_group_descriptor) == 16);
+
+/* SCSI stream status descriptor */
+struct scsi_stream_status {
+#if defined(__BIG_ENDIAN)
+	u8 perm: 1;
+	u8 reserved1: 7;
+#elif defined(__LITTLE_ENDIAN)
+	u8 reserved1: 7;
+	u8 perm: 1;
+#else
+#error
+#endif
+	u8 reserved2;
+	__be16 stream_identifier;
+#if defined(__BIG_ENDIAN)
+	u8 reserved3: 2;
+	u8 rel_lifetime: 6;
+#elif defined(__LITTLE_ENDIAN)
+	u8 rel_lifetime: 6;
+	u8 reserved3: 2;
+#else
+#error
+#endif
+	u8 reserved4[3];
+};
+
+static_assert(sizeof(struct scsi_stream_status) == 8);
+
+/* GET STREAM STATUS parameter data */
+struct scsi_stream_status_header {
+	__be32 len;	/* length in bytes of stream_status[] array. */
+	u16 reserved;
+	__be16 number_of_open_streams;
+	DECLARE_FLEX_ARRAY(struct scsi_stream_status, stream_status);
+};
+
+static_assert(sizeof(struct scsi_stream_status_header) == 8);
+
 /* SPC asymmetric access states */
 #define SCSI_ACCESS_STATE_OPTIMAL     0x00
 #define SCSI_ACCESS_STATE_ACTIVE      0x01

