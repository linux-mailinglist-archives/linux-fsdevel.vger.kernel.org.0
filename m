Return-Path: <linux-fsdevel+bounces-2870-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D07527EB8E3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Nov 2023 22:43:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6933B20B09
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Nov 2023 21:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9431333CEE;
	Tue, 14 Nov 2023 21:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1DA33073;
	Tue, 14 Nov 2023 21:42:26 +0000 (UTC)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F3EDDD;
	Tue, 14 Nov 2023 13:42:25 -0800 (PST)
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1cc5b7057d5so55238425ad.2;
        Tue, 14 Nov 2023 13:42:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699998144; x=1700602944;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P8DaSa1vZ2Lwg+6sy/PSqvH44cWhy9tSfQc+XBCbuX8=;
        b=Co/NgYtn3lW+RJv6tlj98Zvk2M5azbR31z2fAN2kbx/QrIy+NlytJ1/q280yizY5w1
         CcfPyU0DFQKa95TuGbOuE3TKh60C+UfveHAzIduXx5FX2GPyZ2maverr3vAPbOkLIhLU
         KiCsvePFISVDdg5icywZvsX1Pf7vwr3bs0eyzosunbNdTfBV+1M6hB7UlG8smssNxUJA
         HPmT9XkxSwmS43QyVbJs6k9DpzqJZrQIipx6GdF6Kosl3nl+TlOtQIa0vZs3y4eNuNim
         sY8c/7BmeuDnruBdvm6Jy4EgMYZf8LhzGJJua0F94iSwjjvv6VtVPbdUhbhOZpFtwOYu
         qy7Q==
X-Gm-Message-State: AOJu0Yywj5q1fAwLGNedsALTxXbhZ/T/HujoFgirjTbCiDkTvxYKFgG3
	yq/EIoQ5HwdApCWQD8GMNGc=
X-Google-Smtp-Source: AGHT+IFbBjmxf+wmbzKrxY+nAWApEQbh2dMhzI2fy+/7c3ggL3xl0kN6FdFccdjcfKmeDbPVi+PrOQ==
X-Received: by 2002:a17:902:d505:b0:1cc:4828:9b07 with SMTP id b5-20020a170902d50500b001cc48289b07mr4633610plg.0.1699998144000;
        Tue, 14 Nov 2023 13:42:24 -0800 (PST)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:0:1000:8411:2278:ad72:cefb:4d49])
        by smtp.gmail.com with ESMTPSA id o16-20020a170902d4d000b001c3267ae317sm6133926plg.165.2023.11.14.13.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 13:42:23 -0800 (PST)
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
Subject: [PATCH v4 13/15] scsi_debug: Implement the IO Advice Hints Grouping mode page
Date: Tue, 14 Nov 2023 13:41:08 -0800
Message-ID: <20231114214132.1486867-14-bvanassche@acm.org>
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

Implement an IO Advice Hints Grouping mode page with three permanent
streams. A permanent stream is a stream for which the device server does
not allow closing or otherwise modifying the configuration of that
stream. The stream identifier enable (ST_ENBLE) bit specifies whether
the stream identifier may be used in the GROUP NUMBER field of SCSI
WRITE commands.

Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Douglas Gilbert <dgilbert@interlog.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/scsi_debug.c | 42 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index a16885fcec24..98fa675cbf37 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -2552,6 +2552,36 @@ static int resp_ctrl_m_pg(unsigned char *p, int pcontrol, int target)
 	return sizeof(ctrl_m_pg);
 }
 
+enum { MAXIMUM_NUMBER_OF_STREAMS = 4 };
+
+/* IO Advice Hints Grouping mode page */
+static int resp_grouping_m_pg(unsigned char *p, int pcontrol, int target)
+{
+	/* IO Advice Hints Grouping mode page */
+	struct grouping_m_pg {
+		u8 page_code;
+		u8 subpage_code;
+		__be16 page_length;
+		u8 reserved[12];
+		struct scsi_io_group_descriptor
+			descr[MAXIMUM_NUMBER_OF_STREAMS];
+	};
+	static const struct grouping_m_pg gr_m_pg = {
+		.page_code = 0xa,
+		.subpage_code = 5,
+		.page_length = cpu_to_be16(sizeof(gr_m_pg) - 4),
+		.descr = {
+			{ .st_enble = 1 },
+			{ .st_enble = 1 },
+			{ .st_enble = 1 },
+			{ .st_enble = 0 },
+		}
+	};
+
+	BUILD_BUG_ON(sizeof(struct grouping_m_pg) != 16 + 4 * 16);
+	memcpy(p, &gr_m_pg, sizeof(gr_m_pg));
+	return sizeof(gr_m_pg);
+}
 
 static int resp_iec_m_pg(unsigned char *p, int pcontrol, int target)
 {	/* Informational Exceptions control mode page for mode_sense */
@@ -2731,9 +2761,17 @@ static int resp_mode_sense(struct scsi_cmnd *scp,
 		}
 		break;
 	case 0xa:	/* Control Mode page, all devices */
-		if (subpcode > 0x0 && subpcode < 0xff)
+		switch (subpcode) {
+		case 0:
+		case 0xff:
+			len = resp_ctrl_m_pg(ap, pcontrol, target);
+			break;
+		case 0x05:
+			len = resp_grouping_m_pg(ap, pcontrol, target);
+			break;
+		default:
 			goto bad_subpcode;
-		len = resp_ctrl_m_pg(ap, pcontrol, target);
+		}
 		offset += len;
 		break;
 	case 0x19:	/* if spc==1 then sas phy, control+discover */

