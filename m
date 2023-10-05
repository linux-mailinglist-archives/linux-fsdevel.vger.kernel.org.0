Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC21D7BAA6A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Oct 2023 21:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbjJETmc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Oct 2023 15:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231671AbjJETmN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Oct 2023 15:42:13 -0400
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59803FA;
        Thu,  5 Oct 2023 12:42:11 -0700 (PDT)
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1c3d8fb23d9so10446905ad.0;
        Thu, 05 Oct 2023 12:42:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696534931; x=1697139731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T4k+JDqEcQkKs3J5VRs0ivCwgTJsm0PTpYm6Nj592ys=;
        b=b/P2h5qElGT0w43shTHF7nURo52p5zs2WZI/hB2tL3RFhTYk3DUu8o15kexXMKEeT2
         G27HFeSrIDr1uTA1fnSgJs05vLSPHUNn9wkT1Bz0Fecc+14K81MKhWsKCQvjDmzNqsxc
         qzjFYjntXc23i6dBM6qPIjNkgAj1uK9YeG33K4bzZeJg/sKcGkinyexf8sSJL5HlkRTh
         0FQp7XDB5A63s6u/FYl4c0rMt8Cma90i7gFgIdkB9PZBFH4LTsXDxlYXNiJ6Kubw5kVa
         +swRvsy7Zsd/2BZRtmYYECsX59HNWxI7hYV9tsRQSVaTVvOCKuFJDFmfD0/IvCekzN7+
         jOvg==
X-Gm-Message-State: AOJu0Yxf1Kx7xVL/QyPv3pfms4H9AxEDzSxpiaxzGpmtapapALfPyBIB
        Xam4WD4To0usKSH0zyP5L0jWbTZ2E28=
X-Google-Smtp-Source: AGHT+IE2cQrbB6ciyJn4EiRNbD5XGWxSUVH0YMUjzUSTPLVsaqiDIYt3E/3ehPrJq0t3wt97SjXCNQ==
X-Received: by 2002:a17:902:bf0c:b0:1c3:4361:ca18 with SMTP id bi12-20020a170902bf0c00b001c34361ca18mr5561601plb.5.1696534930738;
        Thu, 05 Oct 2023 12:42:10 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:ca3e:70ef:bad:2f])
        by smtp.gmail.com with ESMTPSA id u4-20020a170902e5c400b001a9b29b6759sm2129596plf.183.2023.10.05.12.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 12:42:10 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        Avri Altman <Avri.Altman@wdc.com>,
        Bean Huo <huobean@gmail.com>,
        Daejun Park <daejun7.park@samsung.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Subject: [PATCH v2 07/15] scsi_proto: Add structures and constants related to I/O groups and streams
Date:   Thu,  5 Oct 2023 12:40:53 -0700
Message-ID: <20231005194129.1882245-8-bvanassche@acm.org>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
In-Reply-To: <20231005194129.1882245-1-bvanassche@acm.org>
References: <20231005194129.1882245-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

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
