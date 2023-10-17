Return-Path: <linux-fsdevel+bounces-574-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D0DD7CCEB6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Oct 2023 22:48:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9ED521C20841
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Oct 2023 20:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A522F524;
	Tue, 17 Oct 2023 20:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967D52F50D
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Oct 2023 20:48:36 +0000 (UTC)
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 598E9113;
	Tue, 17 Oct 2023 13:48:35 -0700 (PDT)
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-57f0f81b2aeso3404478eaf.3;
        Tue, 17 Oct 2023 13:48:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697575714; x=1698180514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UM8sqysXvoRJ5DMnsmYXvV6LHJ7K767rwmBQQL3CWG0=;
        b=e2ra+MormH+7kdP6iE6cUxAU/6WB5wz1fKlke1TZEXcDwdff9Xew6YR7U4xN/PNksz
         Va3T9XioDxvR9eBK0DhXP1OHwwXINyloLfv+Pcmkw1DFnWFhLMyIj7w0dYG60BRLmLcc
         T4eP38EpWNwwH1jbF84LSUazOufQz+ISr1SntRNezmtESEdxc6IigZbuqIQdFF8rmX+s
         n/JdTfxaq27MjO9fMDeu7ZFUjvczR+2QI6rGTmu21o0OxUrSuILtPq3FGgVid0JRNarv
         3rNZrP0x3YtBFGxXQloj2ep9N7jvl15E9l/3MSuPbVbdcY5hwFR+RnYbK+vfB5NtFd+h
         9dLQ==
X-Gm-Message-State: AOJu0YzQm29VEHJcDe/bM5FtIItfXRxIRHNnjeo+xuOx0i0c/rovnLOv
	VZi3quBhx4ge74OE67LSsm0=
X-Google-Smtp-Source: AGHT+IF/5L3x/Ab+PAUfdX+hgUIOKfSGbqsErIOon16NHRSS3O63qPnEQlqyvTg+yp+05VhyWXhxhQ==
X-Received: by 2002:a05:6358:ce11:b0:166:dcf6:cd82 with SMTP id gt17-20020a056358ce1100b00166dcf6cd82mr3050454rwb.14.1697575714527;
        Tue, 17 Oct 2023 13:48:34 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:8f02:2919:9600:ac09])
        by smtp.gmail.com with ESMTPSA id fa36-20020a056a002d2400b006b2e07a6235sm1874704pfb.136.2023.10.17.13.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 13:48:34 -0700 (PDT)
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
Subject: [PATCH v3 12/14] scsi_debug: Implement the IO Advice Hints Grouping mode page
Date: Tue, 17 Oct 2023 13:47:20 -0700
Message-ID: <20231017204739.3409052-13-bvanassche@acm.org>
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
index a96eb0d10346..d56989e94c4a 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -2241,6 +2241,36 @@ static int resp_ctrl_m_pg(unsigned char *p, int pcontrol, int target)
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
@@ -2420,9 +2450,17 @@ static int resp_mode_sense(struct scsi_cmnd *scp,
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

