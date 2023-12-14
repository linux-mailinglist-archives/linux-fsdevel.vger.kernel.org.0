Return-Path: <linux-fsdevel+bounces-6154-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88284813BD8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 21:44:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAEEE1C21B5F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 20:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715BA6F638;
	Thu, 14 Dec 2023 20:42:39 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471D23FE27;
	Thu, 14 Dec 2023 20:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d37a6926f7so4301155ad.3;
        Thu, 14 Dec 2023 12:42:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702586556; x=1703191356;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f1/lH9Hw0WCwni4Q5tcXjRVpjlohQJZVb5B4CQ9df8U=;
        b=VAuYsrrvLII9lfTMWS+T61+d+TnYbNihd5Qf7Evj345IY5kxwlYEKr4peBqXyt0+sO
         qrRlsXJrk5PEgHjMsuAtJcgOHHwr9qQ/azu2lNNxGADNXnaUhq8i1tKML4aBde376nRr
         8KE8leH6u6qaBldswq22McR2Tv7jG/udbg+gHAL9GoeY9CvOfab4xqPks8Q5H6bUxHHH
         wWjAiu09QXjNatb5w4tI4azLtR5uosVG+ancH1PR0TqQHCb9sK2PRBGwgrT8gNmmDzlp
         qFa5mOz/THFlMc9WStCi9ZQOYsVx3iaSe/Q/k+l/QuKAsSMOoM5YbQOJDE8AgGTIvJd9
         MAmQ==
X-Gm-Message-State: AOJu0YyghAklVZYTmd4CeTYJCCgYcanpLXn3KoUjdHPDQTSIwRroXFb7
	tOdeB5AZKMrz4IX5Yg8J5mB+VN5tJJw=
X-Google-Smtp-Source: AGHT+IGUMOYYYb2Q5rUKcwMiPnyrF7TxrJMexD2DWLDHbj85s6BP762HNxJre0cZB7cLpxbOnLX8ig==
X-Received: by 2002:a17:903:2303:b0:1d0:98d8:955c with SMTP id d3-20020a170903230300b001d098d8955cmr7330000plh.124.1702586556571;
        Thu, 14 Dec 2023 12:42:36 -0800 (PST)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:0:1000:8411:bae8:452d:2e24:5984])
        by smtp.gmail.com with ESMTPSA id z21-20020a170902ee1500b001d340c71ccasm5091640plb.275.2023.12.14.12.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 12:42:36 -0800 (PST)
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
Subject: [PATCH v6 15/20] scsi: scsi_debug: Rework page code error handling
Date: Thu, 14 Dec 2023 12:40:48 -0800
Message-ID: <20231214204119.3670625-16-bvanassche@acm.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231214204119.3670625-1-bvanassche@acm.org>
References: <20231214204119.3670625-1-bvanassche@acm.org>
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
Tested-by: Douglas Gilbert <dgilbert@interlog.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/scsi_debug.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 39f8ae4dce82..b646c5320c63 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -2650,7 +2650,7 @@ static int resp_mode_sense(struct scsi_cmnd *scp,
 	unsigned char *ap;
 	unsigned char arr[SDEBUG_MAX_MSENSE_SZ];
 	unsigned char *cmd = scp->cmnd;
-	bool dbd, llbaa, msense_6, is_disk, is_zbc, bad_pcode;
+	bool dbd, llbaa, msense_6, is_disk, is_zbc;
 
 	dbd = !!(cmd[1] & 0x8);		/* disable block descriptors */
 	pcontrol = (cmd[2] & 0xc0) >> 6;
@@ -2714,7 +2714,6 @@ static int resp_mode_sense(struct scsi_cmnd *scp,
 		mk_sense_invalid_fld(scp, SDEB_IN_CDB, 3, -1);
 		return check_condition_result;
 	}
-	bad_pcode = false;
 
 	switch (pcode) {
 	case 0x1:	/* Read-Write error recovery page, direct access */
@@ -2729,15 +2728,17 @@ static int resp_mode_sense(struct scsi_cmnd *scp,
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
@@ -2790,18 +2791,17 @@ static int resp_mode_sense(struct scsi_cmnd *scp,
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

