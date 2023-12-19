Return-Path: <linux-fsdevel+bounces-6453-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C27C0817E99
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 01:10:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 730D0285CE7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 00:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DDCFBE74;
	Tue, 19 Dec 2023 00:09:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B657AD4F;
	Tue, 19 Dec 2023 00:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d3ae590903so12426795ad.1;
        Mon, 18 Dec 2023 16:09:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702944542; x=1703549342;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HDbYkMJjEquxAUzkIs58T1VgEWf/IZY0doxHFjDYrzk=;
        b=wL0olhIGka8kwxDlbTosSM6vFSJekyXPPjBYLVAB7W5dB3YSzQwLe/K0a+ibL1JDQv
         WtuYyYe3Bso4L1EnNZ530EEla4ZfSjgiN2C5FEGcohJptZKDcKaKT62uDi7+cPR6KmRw
         guUmwmARFVa96BTaRqAuBHX9Dcoxe2gA1IziPlulDZ99v9COzjmc61lG9Whm0ImUijmu
         SsrqSXQR7KCnv5mHRIB1LSNOuu75NXj1EGZQwuPCQ7Udhbl6EwdEmQvJWtINNdvu4eCc
         4d01xKfJ/wEtO5AqmBtGjptfz5gH0B0FMg24613nOQiEJ2xK1VFtrBSri3MC2MXOuwIh
         MdZQ==
X-Gm-Message-State: AOJu0YyO97UPj5I25eirYBUDo+vuViLs02fHakNd0MVwIE+7qm+I00Wf
	WaLmvtcYI9hbZTZgUiFgK0o=
X-Google-Smtp-Source: AGHT+IHLhgY/1VJ8iwlqElDIJhbh7gFr1aAd/6Rl0GFRotn0ITlkpyc5UFzF7PCjj8ZCjmsQHAlB2Q==
X-Received: by 2002:a17:90a:c283:b0:28b:b20f:9d9a with SMTP id f3-20020a17090ac28300b0028bb20f9d9amr238279pjt.46.1702944541826;
        Mon, 18 Dec 2023 16:09:01 -0800 (PST)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:0:1000:8411:e67:7ba6:36a9:8cd5])
        by smtp.gmail.com with ESMTPSA id x17-20020a17090a531100b0028b050e8297sm118630pjh.18.2023.12.18.16.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 16:09:01 -0800 (PST)
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
Subject: [PATCH v8 16/19] scsi: scsi_debug: Allocate the MODE SENSE response from the heap
Date: Mon, 18 Dec 2023 16:07:49 -0800
Message-ID: <20231219000815.2739120-17-bvanassche@acm.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231219000815.2739120-1-bvanassche@acm.org>
References: <20231219000815.2739120-1-bvanassche@acm.org>
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

