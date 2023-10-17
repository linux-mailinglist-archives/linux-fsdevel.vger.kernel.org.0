Return-Path: <linux-fsdevel+bounces-568-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4667CCEA7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Oct 2023 22:48:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 588E9B21464
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Oct 2023 20:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A5902EB0C;
	Tue, 17 Oct 2023 20:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348262E405
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Oct 2023 20:48:28 +0000 (UTC)
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97AA6FA;
	Tue, 17 Oct 2023 13:48:26 -0700 (PDT)
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6b2018a11efso4280935b3a.0;
        Tue, 17 Oct 2023 13:48:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697575706; x=1698180506;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T4k+JDqEcQkKs3J5VRs0ivCwgTJsm0PTpYm6Nj592ys=;
        b=RgkIRboai4lX0Xy1ylkKgXRKV77aYnylQsHi7S/6cqY7+KFBFp/Y4/O4leOYn5tEOY
         5Sco1MCoVi8H6yw8EYNRMWahoQ7d7eHqTjtQjxI6hiTwBn405uLuMbZpm4dNKbR2DkhZ
         N6dZDvtO8Es0QLRsE5F41BC79q7dxN5cEF2C4pordmLtEKuFags5A56GlvzoVORWvRCf
         e1c8K60qUXsjprpxegBoULzGUdF9Bz0ke8pws3eU+9HwLQhOzGeCJwYr/EH2xoDNrtvD
         1JCZsmPyQCjEa1MzQiwHK/yieQJmXVD9AVjfWOGx00pH8+PmtlaIhQzD1Sd/MMmuoGPN
         FC1Q==
X-Gm-Message-State: AOJu0Yw/hmceKiDU81ZAMFE8/HQyfSh+rDz0kfUctcDaGZavEM8xhFx6
	6/PIn7QU884ZRFPSh6PsRtUTDJXOCJo=
X-Google-Smtp-Source: AGHT+IE9JmC7mnpFAERJjbxXj8433DA2LiY59WlVX6Lr+DI/sHn29bu/4VP2IM+dMqjwkD0A6kKnow==
X-Received: by 2002:aa7:88ce:0:b0:6b1:c1c4:ae98 with SMTP id k14-20020aa788ce000000b006b1c1c4ae98mr3811496pff.18.1697575705851;
        Tue, 17 Oct 2023 13:48:25 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:8f02:2919:9600:ac09])
        by smtp.gmail.com with ESMTPSA id fa36-20020a056a002d2400b006b2e07a6235sm1874704pfb.136.2023.10.17.13.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 13:48:25 -0700 (PDT)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Christoph Hellwig <hch@lst.de>,
	Niklas Cassel <Niklas.Cassel@wdc.com>,
	Avri Altman <Avri.Altman@wdc.com>,
	Bean Huo <huobean@gmail.com>,
	Daejun Park <daejun7.park@samsung.com>,
	Bart Van Assche <bvanassche@acm.org>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>
Subject: [PATCH v3 06/14] scsi_proto: Add structures and constants related to I/O groups and streams
Date: Tue, 17 Oct 2023 13:47:14 -0700
Message-ID: <20231017204739.3409052-7-bvanassche@acm.org>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
In-Reply-To: <20231017204739.3409052-1-bvanassche@acm.org>
References: <20231017204739.3409052-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

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

