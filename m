Return-Path: <linux-fsdevel+bounces-4311-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1AC67FE711
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 03:39:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD09528223E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 02:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A871134B6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 02:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6AB31A3;
	Wed, 29 Nov 2023 17:33:52 -0800 (PST)
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6cddb35ef8bso445523b3a.2;
        Wed, 29 Nov 2023 17:33:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701308032; x=1701912832;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R8EcgaR4eXq8dVppzgdHKdsG1/gf1g8yGQ3Do1V1VIc=;
        b=bwp0fMDujf/pEZjIznUuEk5o0zcFv45xsiRrawG389b/B83CRNPEEZwCF/fCdI79Jh
         ErnaXMROisCzQ1VH8BuqEML3qjrxDs4m45cwExnnIBmAmSieTJREITwB+nAdIHV72scl
         9YEMqUmsQYDGcRfHdChfFXWiYx96IwZJyLTR2Me6iWmNMhz2S47W2Xlmj8+T5u5MXwOD
         tYEpr42t9aU6/UQtWMa3sqjMaGxEOU5LYhDZIk2a5OAUYYNDIioQafoC0HA9ioARwNNo
         rxgqXz5S4PeV1M8kc51BwJnPUo7Z9bm+VBG55QEYzmLNRDXAFJBrMmtsYdQOcr6MmVwd
         p1gg==
X-Gm-Message-State: AOJu0YxoDHQiJWPeUJ3da7nKJuWfsj70AEK/jEreJxJ0YCJCbWbjLbVB
	gFkPA0wpBAjV+XqRiyGtvjY=
X-Google-Smtp-Source: AGHT+IHW6Job7YtDCsc/GDHTR5yt0uCeo3ct+FG7vwPjfHHiXyirmsndeQvKHOEbxg5FJ30vhNc3Rw==
X-Received: by 2002:a05:6a20:1581:b0:18c:c37:35fb with SMTP id h1-20020a056a20158100b0018c0c3735fbmr20528803pzj.40.1701308032295;
        Wed, 29 Nov 2023 17:33:52 -0800 (PST)
Received: from bvanassche-glaptop2.roam.corp.google.com (c-73-231-117-72.hsd1.ca.comcast.net. [73.231.117.72])
        by smtp.gmail.com with ESMTPSA id g4-20020a17090ace8400b00277560ecd5dsm2021936pju.46.2023.11.29.17.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 17:33:52 -0800 (PST)
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
	Douglas Gilbert <dgilbert@interlog.com>
Subject: [PATCH v5 16/17] scsi_debug: Implement GET STREAM STATUS
Date: Wed, 29 Nov 2023 17:33:21 -0800
Message-ID: <20231130013322.175290-17-bvanassche@acm.org>
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

Implement the GET STREAM STATUS SCSI command. Report that the first
three stream indexes correspond to permanent streams.

Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Douglas Gilbert <dgilbert@interlog.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/scsi_debug.c | 48 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 46 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index a1f4a499b82c..16091e2913d5 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -532,6 +532,8 @@ static int resp_write_scat(struct scsi_cmnd *, struct sdebug_dev_info *);
 static int resp_start_stop(struct scsi_cmnd *, struct sdebug_dev_info *);
 static int resp_readcap16(struct scsi_cmnd *, struct sdebug_dev_info *);
 static int resp_get_lba_status(struct scsi_cmnd *, struct sdebug_dev_info *);
+static int resp_get_stream_status(struct scsi_cmnd *scp,
+				  struct sdebug_dev_info *devip);
 static int resp_report_tgtpgs(struct scsi_cmnd *, struct sdebug_dev_info *);
 static int resp_unmap(struct scsi_cmnd *, struct sdebug_dev_info *);
 static int resp_rsup_opcodes(struct scsi_cmnd *, struct sdebug_dev_info *);
@@ -606,6 +608,9 @@ static const struct opcode_info_t sa_in_16_iarr[] = {
 	{0, 0x9e, 0x12, F_SA_LOW | F_D_IN, resp_get_lba_status, NULL,
 	    {16,  0x12, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
 	     0xff, 0xff, 0xff, 0, 0xc7} },	/* GET LBA STATUS(16) */
+	{0, 0x9e, 0x16, F_SA_LOW | F_D_IN, resp_get_stream_status, NULL,
+	    {16, 0x16, 0, 0, 0xff, 0xff, 0, 0, 0, 0, 0xff, 0xff, 0xff, 0xff,
+	     0, 0} },	/* GET STREAM STATUS */
 };
 
 static const struct opcode_info_t vl_iarr[] = {	/* VARIABLE LENGTH */
@@ -2545,7 +2550,7 @@ static int resp_ctrl_m_pg(unsigned char *p, int pcontrol, int target)
 	return sizeof(ctrl_m_pg);
 }
 
-enum { MAXIMUM_NUMBER_OF_STREAMS = 4 };
+enum { MAXIMUM_NUMBER_OF_STREAMS = 6, PERMANENT_STREAM_COUNT = 5 };
 
 /* IO Advice Hints Grouping mode page */
 static int resp_grouping_m_pg(unsigned char *p, int pcontrol, int target)
@@ -2564,6 +2569,8 @@ static int resp_grouping_m_pg(unsigned char *p, int pcontrol, int target)
 		.subpage_code = 5,
 		.page_length = cpu_to_be16(sizeof(gr_m_pg) - 4),
 		.descr = {
+			{ .st_enble = 1 },
+			{ .st_enble = 1 },
 			{ .st_enble = 1 },
 			{ .st_enble = 1 },
 			{ .st_enble = 1 },
@@ -2571,7 +2578,7 @@ static int resp_grouping_m_pg(unsigned char *p, int pcontrol, int target)
 		}
 	};
 
-	BUILD_BUG_ON(sizeof(struct grouping_m_pg) != 16 + 4 * 16);
+	BUILD_BUG_ON(sizeof(struct grouping_m_pg) != 16 + MAXIMUM_NUMBER_OF_STREAMS * 16);
 	memcpy(p, &gr_m_pg, sizeof(gr_m_pg));
 	return sizeof(gr_m_pg);
 }
@@ -4540,6 +4547,43 @@ static int resp_get_lba_status(struct scsi_cmnd *scp,
 	return fill_from_dev_buffer(scp, arr, SDEBUG_GET_LBA_STATUS_LEN);
 }
 
+static int resp_get_stream_status(struct scsi_cmnd *scp,
+				  struct sdebug_dev_info *devip)
+{
+	u16 starting_stream_id, stream_id;
+	const u8 *cmd = scp->cmnd;
+	u32 alloc_len, offset;
+	u8 arr[256];
+
+	starting_stream_id = get_unaligned_be16(cmd + 4);
+	alloc_len = get_unaligned_be32(cmd + 10);
+
+	if (alloc_len < 8) {
+		mk_sense_invalid_fld(scp, SDEB_IN_CDB, 10, -1);
+		return check_condition_result;
+	}
+
+	if (starting_stream_id >= MAXIMUM_NUMBER_OF_STREAMS) {
+		mk_sense_invalid_fld(scp, SDEB_IN_CDB, 4, -1);
+		return check_condition_result;
+	}
+
+	for (offset = 8, stream_id = starting_stream_id;
+	     offset + 8 <= min_t(u32, alloc_len, sizeof(arr)) &&
+		     stream_id < MAXIMUM_NUMBER_OF_STREAMS;
+	     offset += 8, stream_id++) {
+		struct scsi_stream_status *stream_status = (void *)arr + offset;
+
+		stream_status->perm = stream_id < PERMANENT_STREAM_COUNT;
+		put_unaligned_be16(stream_id,
+				   &stream_status->stream_identifier);
+		stream_status->rel_lifetime = stream_id + 1;
+	}
+	put_unaligned_be32(offset - 8, arr + 0); /* PARAMETER DATA LENGTH */
+
+	return fill_from_dev_buffer(scp, arr, min(offset, alloc_len));
+}
+
 static int resp_sync_cache(struct scsi_cmnd *scp,
 			   struct sdebug_dev_info *devip)
 {

