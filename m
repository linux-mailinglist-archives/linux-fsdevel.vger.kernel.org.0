Return-Path: <linux-fsdevel+bounces-6156-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC899813BDE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 21:44:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EC951F225D9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 20:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F936FCE0;
	Thu, 14 Dec 2023 20:42:42 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B16B3FE27;
	Thu, 14 Dec 2023 20:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d34a6b3566so15859515ad.2;
        Thu, 14 Dec 2023 12:42:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702586560; x=1703191360;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HDbYkMJjEquxAUzkIs58T1VgEWf/IZY0doxHFjDYrzk=;
        b=JXk1UB7PX2yBekSLAlWRsnhS/omTJGTSLpa47Ai/uZx7eji0Pnn6MIN0S8LUpjnsd9
         Dbvo3KbejmJY9cMziyXFinJWhEyo7tU5Qsopzf+ObJeM5zrB3wrI7RkUQIn6yabEKvsn
         bdgqUTATQaZJZ+ig7uz2C9kD9xNAIvDRv5hOVEAgYMC7RW+1pe4Ie+2beuJr2YPPiqKo
         m5GD+M0vE4UhDjR8G6w6bRjzePEx/AgFQPz266dWuOLZKcYAHeKWZgNshEl6hbQU4aZj
         Grn8oCyOFO4oId3zgfnEeZN5ASRdnpIoNgMFqrzGoukWcHyUW2aeQGZzd6UQbHdrt6mj
         3eIQ==
X-Gm-Message-State: AOJu0YxCSRUrSwIb+KKlvgZdVQvWyVEToqCDRFut8jnRluZsD+Ql677J
	i/sYAT/iTSehDz/r4yei5x0=
X-Google-Smtp-Source: AGHT+IGNzjvOXPUdwv/x8mvbty+fLAW9YU2L8Q7oMDv0NxMYrLy+lVkRSl00uyDFP7+uDy98MkWZEg==
X-Received: by 2002:a17:903:2446:b0:1d0:cec3:4569 with SMTP id l6-20020a170903244600b001d0cec34569mr6306273pls.100.1702586559664;
        Thu, 14 Dec 2023 12:42:39 -0800 (PST)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:0:1000:8411:bae8:452d:2e24:5984])
        by smtp.gmail.com with ESMTPSA id z21-20020a170902ee1500b001d340c71ccasm5091640plb.275.2023.12.14.12.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 12:42:39 -0800 (PST)
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
Subject: [PATCH v6 17/20] scsi: scsi_debug: Allocate the MODE SENSE response from the heap
Date: Thu, 14 Dec 2023 12:40:50 -0800
Message-ID: <20231214204119.3670625-18-bvanassche@acm.org>
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

Make the MODE SENSE response buffer larger and allocate it from the heap.
This patch prepares for adding support for the IO Advice Hints Grouping
mode page.

Suggested-by: Douglas Gilbert <dgilbert@interlog.com>
Cc: Douglas Gilbert <dgilbert@interlog.com>
Tested-by: Douglas Gilbert <dgilbert@interlog.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/scsi_debug.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index cadd130d6b53..4181d0d81224 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -43,6 +43,7 @@
 #include <linux/prefetch.h>
 #include <linux/debugfs.h>
 #include <linux/async.h>
+#include <linux/cleanup.h>
 
 #include <net/checksum.h>
 
@@ -2637,7 +2638,8 @@ static int resp_sas_sha_m_spg(unsigned char *p, int pcontrol)
 	return sizeof(sas_sha_m_pg);
 }
 
-#define SDEBUG_MAX_MSENSE_SZ 256
+/* PAGE_SIZE is more than necessary but provides room for future expansion. */
+#define SDEBUG_MAX_MSENSE_SZ PAGE_SIZE
 
 static int resp_mode_sense(struct scsi_cmnd *scp,
 			   struct sdebug_dev_info *devip)
@@ -2648,10 +2650,13 @@ static int resp_mode_sense(struct scsi_cmnd *scp,
 	int target_dev_id;
 	int target = scp->device->id;
 	unsigned char *ap;
-	unsigned char arr[SDEBUG_MAX_MSENSE_SZ];
+	unsigned char *arr __free(kfree);
 	unsigned char *cmd = scp->cmnd;
 	bool dbd, llbaa, msense_6, is_disk, is_zbc;
 
+	arr = kzalloc(SDEBUG_MAX_MSENSE_SZ, GFP_ATOMIC);
+	if (!arr)
+		return -ENOMEM;
 	dbd = !!(cmd[1] & 0x8);		/* disable block descriptors */
 	pcontrol = (cmd[2] & 0xc0) >> 6;
 	pcode = cmd[2] & 0x3f;

