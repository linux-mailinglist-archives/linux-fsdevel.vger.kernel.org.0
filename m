Return-Path: <linux-fsdevel+bounces-2871-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99DB57EB8E4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Nov 2023 22:43:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3947E1F25DB8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Nov 2023 21:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5FB2E825;
	Tue, 14 Nov 2023 21:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D8E33070;
	Tue, 14 Nov 2023 21:42:27 +0000 (UTC)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5267BFB;
	Tue, 14 Nov 2023 13:42:26 -0800 (PST)
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1cc53d0030fso2024735ad.0;
        Tue, 14 Nov 2023 13:42:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699998146; x=1700602946;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kTU9M4tDmQIbWEc4YNDxclk8bmN1pALqT2vJyD7Eag8=;
        b=i5bd0+cpfFIt/V6593cb63I8yYzp2r3V5G8syC4LxLgHgmA7Lx0Uyq1jWKlcK9+nOW
         9bRz9Hn6GyJ0/MS+MuAlO8XQHRSgScU8oZVKktcYP5iqgyRzvcJC/r2IaERTv7rS9Y0z
         sC306ovOvXBOMcGvIX+0oyxddxHj24C2xOCO2+LuWpvc+RxcigpsiwQis6vcxPmI6U1h
         tO1jvQu+lMzj8RoaiJVC0Muf0E6mxssh2f+7dUW/p7IgdJdyAMJNP6E1cWDYwPmNIr5J
         mNL9QzKdnewEcxXcU6OsFeerIPSQFnNm2U+ceMqcZctBPXQMqsyOCdjBgWKAksFPlE+O
         h4OA==
X-Gm-Message-State: AOJu0YxBTmYHZ0VdRIF02GXFMM+sgiqD6ngTlL7LUwzIiEaisAFC+jmk
	EfSLTMjW5ms7BqCPvIItCgE=
X-Google-Smtp-Source: AGHT+IHOMUHzn5ZM0eQoPjNaTe5xVTqA79xWEjRmhy0EzKGKLUuYtkdbvS4vLJRmJBcOnoQ89fH24g==
X-Received: by 2002:a17:902:e891:b0:1c9:e77d:62d3 with SMTP id w17-20020a170902e89100b001c9e77d62d3mr4998248plg.10.1699998145727;
        Tue, 14 Nov 2023 13:42:25 -0800 (PST)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:0:1000:8411:2278:ad72:cefb:4d49])
        by smtp.gmail.com with ESMTPSA id o16-20020a170902d4d000b001c3267ae317sm6133926plg.165.2023.11.14.13.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 13:42:25 -0800 (PST)
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
	Douglas Gilbert <dgilbert@interlog.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>
Subject: [PATCH v4 14/15] scsi_debug: Implement GET STREAM STATUS
Date: Tue, 14 Nov 2023 13:41:09 -0800
Message-ID: <20231114214132.1486867-15-bvanassche@acm.org>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
In-Reply-To: <20231114214132.1486867-1-bvanassche@acm.org>
References: <20231114214132.1486867-1-bvanassche@acm.org>
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
 drivers/scsi/scsi_debug.c | 44 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 98fa675cbf37..daf64844d6cb 100644
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
@@ -2552,7 +2557,7 @@ static int resp_ctrl_m_pg(unsigned char *p, int pcontrol, int target)
 	return sizeof(ctrl_m_pg);
 }
 
-enum { MAXIMUM_NUMBER_OF_STREAMS = 4 };
+enum { MAXIMUM_NUMBER_OF_STREAMS = 4, PERMANENT_STREAM_COUNT = 3 };
 
 /* IO Advice Hints Grouping mode page */
 static int resp_grouping_m_pg(unsigned char *p, int pcontrol, int target)
@@ -4547,6 +4552,43 @@ static int resp_get_lba_status(struct scsi_cmnd *scp,
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

