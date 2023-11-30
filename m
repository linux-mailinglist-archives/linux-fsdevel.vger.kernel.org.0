Return-Path: <linux-fsdevel+bounces-4303-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 807D57FE709
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 03:38:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39940281F99
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 02:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F34134B6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 02:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E502F10CE;
	Wed, 29 Nov 2023 17:33:43 -0800 (PST)
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1cf856663a4so4288645ad.3;
        Wed, 29 Nov 2023 17:33:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701308023; x=1701912823;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T4k+JDqEcQkKs3J5VRs0ivCwgTJsm0PTpYm6Nj592ys=;
        b=DorxnFWLz895arSQJhewr0C8Y6sFPCmuJbn1DaUSfVNP5PKWnNmkeX3UiyqEP1E69X
         qwNXZhEOx5A48e3Fyt6Pw7T8VWAE22svj/VajoRa6JiAkkiyxGUNpcZiWL0Zul7vw6fN
         haDAoG6GZVFf6faRWSX8df76OoUoFqBiRBN0LPAZ53WSdTYvfEQUN1F4jocdemDqrN+O
         I+9OdkMOJLlKKwNZ1K7gmpujt6eAY5p1/YsYWc6zt5nQjszK+t+HfJngOwqTF7VHLYmj
         z27NGjIY7zyleeEiDOKn4Q3izxOMB6IxKgphHpPh06N4jTaAR/D5uUQtPSX2RZ4WBFBL
         koiw==
X-Gm-Message-State: AOJu0Yyls5I323iauom17POOW50kZA8M5pwsPdBAvnZaT/aTgaPLkQlG
	fl7AsW97URltyuXdadZobmQ=
X-Google-Smtp-Source: AGHT+IFA3giPx27JFIy/7/BwyL4QyHN2lWe5oOrxFmzyYz6uNlepuhsKoe00eT78/v24HM+C7CHEcw==
X-Received: by 2002:a17:90b:80b:b0:285:866f:ca0d with SMTP id bk11-20020a17090b080b00b00285866fca0dmr19099099pjb.46.1701308023257;
        Wed, 29 Nov 2023 17:33:43 -0800 (PST)
Received: from bvanassche-glaptop2.roam.corp.google.com (c-73-231-117-72.hsd1.ca.comcast.net. [73.231.117.72])
        by smtp.gmail.com with ESMTPSA id g4-20020a17090ace8400b00277560ecd5dsm2021936pju.46.2023.11.29.17.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 17:33:42 -0800 (PST)
From: Bart Van Assche <bvanassche@acm.org>
To: "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Daejun Park <daejun7.park@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v5 09/17] scsi_proto: Add structures and constants related to I/O groups and streams
Date: Wed, 29 Nov 2023 17:33:14 -0800
Message-ID: <20231130013322.175290-10-bvanassche@acm.org>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
In-Reply-To: <20231130013322.175290-1-bvanassche@acm.org>
References: <20231130013322.175290-1-bvanassche@acm.org>
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
 include/scsi/scsi_proto.h | 75 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/include/scsi/scsi_proto.h b/include/scsi/scsi_proto.h
index 07d65c1f59db..9ee4983c23b4 100644
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
@@ -275,6 +277,79 @@ struct scsi_lun {
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
+struct scsi_stream_status {
+#if defined(__BIG_ENDIAN)
+	u16 perm: 1;
+	u16 reserved1: 15;
+#elif defined(__LITTLE_ENDIAN)
+	u16 reserved1: 15;
+	u16 perm: 1;
+#else
+#error
+#endif
+	__be16 stream_identifier;
+#if defined(__BIG_ENDIAN)
+	u8 reserved2: 2;
+	u8 rel_lifetime: 6;
+#elif defined(__LITTLE_ENDIAN)
+	u8 rel_lifetime: 6;
+	u8 reserved2: 2;
+#else
+#error
+#endif
+	u8 reserved3[3];
+};
+
+static_assert(sizeof(struct scsi_stream_status) == 8);
+
+struct scsi_stream_status_header {
+	__be32 len;	/* length in bytes of stream_status[] array. */
+	u16 reserved;
+	u16 number_of_open_streams;
+	DECLARE_FLEX_ARRAY(struct scsi_stream_status, stream_status);
+};
+
+static_assert(sizeof(struct scsi_stream_status_header) == 8);
+
 /* SPC asymmetric access states */
 #define SCSI_ACCESS_STATE_OPTIMAL     0x00
 #define SCSI_ACCESS_STATE_ACTIVE      0x01

