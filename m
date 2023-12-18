Return-Path: <linux-fsdevel+bounces-6410-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC3D817A5F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Dec 2023 19:59:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE02B1F24E04
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Dec 2023 18:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5656274E17;
	Mon, 18 Dec 2023 18:58:02 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E2D74E0D;
	Mon, 18 Dec 2023 18:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso2785846a12.3;
        Mon, 18 Dec 2023 10:58:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702925880; x=1703530680;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HDbYkMJjEquxAUzkIs58T1VgEWf/IZY0doxHFjDYrzk=;
        b=vcbZlKHMaXnMXvngI4TxibGecujTULXJOKod86BYMDtUrk4x7W9waDnMSXQI5O2Uhv
         QZY2tK0+cLBIyKSRejbiXQpf0XRipiKkvJj0WJt+uazE5T3Ff2brYJOefdcD/744ND/a
         AyrVi18LB3CPZYf0FFU3WmxazDx01qb0d9MPzZmlK0SkZXOsY9urh8/p/JtL2qf8bCtK
         jh8Mu233/IgqLYkZ3Se5ZbzufgMJ/Udj2GnNBInBIW5wgQKNyZWp0b783jn3jjnEW5nT
         orsxiBKGeoKwn18O1XvsWCHJIVV3IPmocVe37+TbxXYOAtD+EaFpIhBnMyyvW6o1f821
         RGiQ==
X-Gm-Message-State: AOJu0YwwuAnk2wEWE24SFO2akiJva7HNHO4x74p9RDEr/8O06ecuO6zP
	NDcXnzgMqw7E/iSVJH/23KNL+rANj6Q=
X-Google-Smtp-Source: AGHT+IH6r9O7nPloy93RnpgL8YVuVQrozw3cp2Ua4KuDtKvvMj89qK90JB1CbAGir6u/Yecix7rmQA==
X-Received: by 2002:a05:6a20:96db:b0:18f:b870:e563 with SMTP id hq27-20020a056a2096db00b0018fb870e563mr17974102pzc.38.1702925880011;
        Mon, 18 Dec 2023 10:58:00 -0800 (PST)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:0:1000:8411:e67:7ba6:36a9:8cd5])
        by smtp.gmail.com with ESMTPSA id n20-20020a056a0007d400b006d45707d8edsm3918397pfu.7.2023.12.18.10.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 10:57:59 -0800 (PST)
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
Subject: [PATCH v7 16/19] scsi: scsi_debug: Allocate the MODE SENSE response from the heap
Date: Mon, 18 Dec 2023 10:56:39 -0800
Message-ID: <20231218185705.2002516-17-bvanassche@acm.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231218185705.2002516-1-bvanassche@acm.org>
References: <20231218185705.2002516-1-bvanassche@acm.org>
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

