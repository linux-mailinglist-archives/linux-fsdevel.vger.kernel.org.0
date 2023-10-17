Return-Path: <linux-fsdevel+bounces-575-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 493E57CCEB9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Oct 2023 22:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05E15281A8C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Oct 2023 20:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FBE62F52A;
	Tue, 17 Oct 2023 20:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37D72F515
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Oct 2023 20:48:37 +0000 (UTC)
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF9D911D;
	Tue, 17 Oct 2023 13:48:36 -0700 (PDT)
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6c0b8f42409so4182047a34.0;
        Tue, 17 Oct 2023 13:48:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697575716; x=1698180516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7d0SXC6UVHzAU0xOIJZHMg0dP00OvMSzg+wOowpDTtA=;
        b=sR0khXhgs+XqHyPqS3dCWVMOjjNss4LuzpqEhDGJavoywJCk7BqzhwKZ3+ubCTa5hU
         VtQMTLZCskLz9QA25dFydtppXStrJjRWhhlB2jh7tvccP4ucK75CEVRJ3pPCGNtTGtwj
         09DfIcoi+M6MMDpA23rxwFWBMLiJ6dU+YC1cP+Mtswmfrv3lQfEMXc49Jjk/+SuPOdrF
         5P+SRQOPUNxj/rqhmLdPA/pQCOCyUchs8HnPqBGilMKcekNup59LoP/TN6RQMCyBlUtV
         whKRtKc5qr6WxYFQMFeeNAC6wNv03xcfP34AWjmwet2WDUhsXm2VzzYKKpZ4WYpPMCc1
         GwPg==
X-Gm-Message-State: AOJu0YwFT7k7nOb2XUINEB7T3ZR1eBwGwWkd1264fru0CvqoUhZ1ADXJ
	45led5VRyzQ4oVIos6G3sX/M4U0KyW4=
X-Google-Smtp-Source: AGHT+IGSXWyx/eFcMYRpo1ZiNRhWiL5aUn/JUd141oVaiXdvlK8l3n7dB/+STLHaUa3pL8qBl4z9Mw==
X-Received: by 2002:a05:6830:310a:b0:6aa:ecb5:f186 with SMTP id b10-20020a056830310a00b006aaecb5f186mr4768411ots.7.1697575715918;
        Tue, 17 Oct 2023 13:48:35 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:8f02:2919:9600:ac09])
        by smtp.gmail.com with ESMTPSA id fa36-20020a056a002d2400b006b2e07a6235sm1874704pfb.136.2023.10.17.13.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 13:48:35 -0700 (PDT)
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
	Douglas Gilbert <dgilbert@interlog.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>
Subject: [PATCH v3 13/14] scsi_debug: Implement GET STREAM STATUS
Date: Tue, 17 Oct 2023 13:47:21 -0700
Message-ID: <20231017204739.3409052-14-bvanassche@acm.org>
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
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Implement the GET STREAM STATUS SCSI command. Report that the first
three stream indexes correspond to permanent streams.

Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Douglas Gilbert <dgilbert@interlog.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/scsi_debug.c | 44 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index d56989e94c4a..801448570960 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -481,6 +481,8 @@ static int resp_write_scat(struct scsi_cmnd *, struct sdebug_dev_info *);
 static int resp_start_stop(struct scsi_cmnd *, struct sdebug_dev_info *);
 static int resp_readcap16(struct scsi_cmnd *, struct sdebug_dev_info *);
 static int resp_get_lba_status(struct scsi_cmnd *, struct sdebug_dev_info *);
+static int resp_get_stream_status(struct scsi_cmnd *scp,
+				  struct sdebug_dev_info *devip);
 static int resp_report_tgtpgs(struct scsi_cmnd *, struct sdebug_dev_info *);
 static int resp_unmap(struct scsi_cmnd *, struct sdebug_dev_info *);
 static int resp_rsup_opcodes(struct scsi_cmnd *, struct sdebug_dev_info *);
@@ -555,6 +557,9 @@ static const struct opcode_info_t sa_in_16_iarr[] = {
 	{0, 0x9e, 0x12, F_SA_LOW | F_D_IN, resp_get_lba_status, NULL,
 	    {16,  0x12, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
 	     0xff, 0xff, 0xff, 0, 0xc7} },	/* GET LBA STATUS(16) */
+	{0, 0x9e, 0x16, F_SA_LOW | F_D_IN, resp_get_stream_status, NULL,
+	    {16, 0x16, 0, 0, 0xff, 0xff, 0, 0, 0, 0, 0xff, 0xff, 0xff, 0xff,
+	     0, 0} },	/* GET STREAM STATUS */
 };
 
 static const struct opcode_info_t vl_iarr[] = {	/* VARIABLE LENGTH */
@@ -2241,7 +2246,7 @@ static int resp_ctrl_m_pg(unsigned char *p, int pcontrol, int target)
 	return sizeof(ctrl_m_pg);
 }
 
-enum { MAXIMUM_NUMBER_OF_STREAMS = 4 };
+enum { MAXIMUM_NUMBER_OF_STREAMS = 4, PERMANENT_STREAM_COUNT = 3 };
 
 /* IO Advice Hints Grouping mode page */
 static int resp_grouping_m_pg(unsigned char *p, int pcontrol, int target)
@@ -4236,6 +4241,43 @@ static int resp_get_lba_status(struct scsi_cmnd *scp,
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

