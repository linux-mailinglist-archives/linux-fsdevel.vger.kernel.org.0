Return-Path: <linux-fsdevel+bounces-2868-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59CD07EB8DE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Nov 2023 22:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A5EF1C20AC9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Nov 2023 21:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1478541AAC;
	Tue, 14 Nov 2023 21:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58C43D3B4;
	Tue, 14 Nov 2023 21:42:22 +0000 (UTC)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E115D6;
	Tue, 14 Nov 2023 13:42:21 -0800 (PST)
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1cc5b705769so55051615ad.0;
        Tue, 14 Nov 2023 13:42:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699998141; x=1700602941;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GVFPJUULVVwuYnf49ztY/tTT0ax+5xK1Qvs6cG/QHSg=;
        b=pmqUjBlEE+5qnwTOl8c4szKH5DyYYHti1HyncvqRrsrGOgEhe1CtsUCXFd9C+6mk/a
         L7dodBc4KCQzONQdlcbefS3FGeZiYpYprNJ4hPYY83j/ilLzoLx4RBWMzcj7Z2tz20dB
         pMNM8a+CKTq1leLNFZ1MXzRTeadLh8HRi6/UAi7tY3HvlBHhc6aOco92ZSUfRZBQh6QO
         nJvU9SxhFkSrx9qEPWC1OJLp2wSDYV/s1mrCqzfuXqtucbpfNFxh2L67Bfum7PVre3FU
         w1HkWqRqCaHSckTMSHU54aLYLU3w/D+vS2Tmi1N4TZEVHQD+wS/gQ1xTCifmQ3+gRUkS
         tUqA==
X-Gm-Message-State: AOJu0YxPCtQWu08gdRpOQRXD3pVYyaeSqOVaCTdUf5MpilRvTihCpQWa
	+tVVPhNUyMNxLmcHKeNeez8=
X-Google-Smtp-Source: AGHT+IESh0wPeYT0Qx2qTHJavnpLDcmDwUv6LCtxO0CxU4u4l8W3v1IaltQ6w4odTkelljdV+YpWYg==
X-Received: by 2002:a17:903:1cb:b0:1cc:49e7:ee16 with SMTP id e11-20020a17090301cb00b001cc49e7ee16mr4694286plh.12.1699998140772;
        Tue, 14 Nov 2023 13:42:20 -0800 (PST)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:0:1000:8411:2278:ad72:cefb:4d49])
        by smtp.gmail.com with ESMTPSA id o16-20020a170902d4d000b001c3267ae317sm6133926plg.165.2023.11.14.13.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 13:42:20 -0800 (PST)
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
Subject: [PATCH v4 11/15] scsi_debug: Rework page code error handling
Date: Tue, 14 Nov 2023 13:41:06 -0800
Message-ID: <20231114214132.1486867-12-bvanassche@acm.org>
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

Instead of tracking whether or not the page code is valid in a boolean
variable, jump to error handling code if an unsupported page code is
encountered.

Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Douglas Gilbert <dgilbert@interlog.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/scsi_debug.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 11c57aed73ce..12c3e3b68552 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -2638,7 +2638,7 @@ static int resp_mode_sense(struct scsi_cmnd *scp,
 	unsigned char *ap;
 	unsigned char arr[SDEBUG_MAX_MSENSE_SZ];
 	unsigned char *cmd = scp->cmnd;
-	bool dbd, llbaa, msense_6, is_disk, is_zbc, bad_pcode;
+	bool dbd, llbaa, msense_6, is_disk, is_zbc;
 
 	dbd = !!(cmd[1] & 0x8);		/* disable block descriptors */
 	pcontrol = (cmd[2] & 0xc0) >> 6;
@@ -2702,7 +2702,6 @@ static int resp_mode_sense(struct scsi_cmnd *scp,
 		mk_sense_invalid_fld(scp, SDEB_IN_CDB, 3, -1);
 		return check_condition_result;
 	}
-	bad_pcode = false;
 
 	switch (pcode) {
 	case 0x1:	/* Read-Write error recovery page, direct access */
@@ -2717,15 +2716,17 @@ static int resp_mode_sense(struct scsi_cmnd *scp,
 		if (is_disk) {
 			len = resp_format_pg(ap, pcontrol, target);
 			offset += len;
-		} else
-			bad_pcode = true;
+		} else {
+			goto bad_pcode;
+		}
 		break;
 	case 0x8:	/* Caching page, direct access */
 		if (is_disk || is_zbc) {
 			len = resp_caching_pg(ap, pcontrol, target);
 			offset += len;
-		} else
-			bad_pcode = true;
+		} else {
+			goto bad_pcode;
+		}
 		break;
 	case 0xa:	/* Control Mode page, all devices */
 		len = resp_ctrl_m_pg(ap, pcontrol, target);
@@ -2778,18 +2779,17 @@ static int resp_mode_sense(struct scsi_cmnd *scp,
 		}
 		break;
 	default:
-		bad_pcode = true;
-		break;
-	}
-	if (bad_pcode) {
-		mk_sense_invalid_fld(scp, SDEB_IN_CDB, 2, 5);
-		return check_condition_result;
+		goto bad_pcode;
 	}
 	if (msense_6)
 		arr[0] = offset - 1;
 	else
 		put_unaligned_be16((offset - 2), arr + 0);
 	return fill_from_dev_buffer(scp, arr, min_t(u32, alloc_len, offset));
+
+bad_pcode:
+	mk_sense_invalid_fld(scp, SDEB_IN_CDB, 2, 5);
+	return check_condition_result;
 }
 
 #define SDEBUG_MAX_MSELECT_SZ 512

