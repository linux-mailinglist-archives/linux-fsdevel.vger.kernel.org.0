Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF407A8C9E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Sep 2023 21:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbjITTQD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Sep 2023 15:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbjITTPb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Sep 2023 15:15:31 -0400
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96A93182;
        Wed, 20 Sep 2023 12:15:06 -0700 (PDT)
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-565334377d0so72304a12.2;
        Wed, 20 Sep 2023 12:15:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695237306; x=1695842106;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/amIXBh2OmwTU85hCgujumlTfo/mnD8IJjMcbcGdMyM=;
        b=fZ6s2sO9bYuocOKQirwbh2tKL59vnKti4JW2OtGWDEkaMHcXg6evHciGkdvoxq9UqG
         1JAwqCc8i/tVUocBn0QMZbfxwvR7Zv1ZXWr0WrfljKgjMI4HRhYkFmazNZUc66w3TRn4
         TnE9ee5Nx+sS4H4wGfia5g5NNKfVxdtrYBgO2rAOPAyi18Zp08DOJjLU+0Emw/ovveFU
         KwjF4J5WY7qk5NBCmXpB01COmdnkISD6z6eCwmCdnnPhUayducH3Fs75FUwJu/GX+ezx
         J6Ae7PP+AfTq6v61boTXs/PkUbKxVaS/wJNAQOhO0raVRrIOJpvNaZiQ3rJzETa0siuh
         DKlg==
X-Gm-Message-State: AOJu0YzP1CnwyH22fL5b6iKZ4cO3g/TjFgKwVvgv2pgXTxVdHh5xJvAr
        6eHhDXUySkL2tX11O7VLfnY=
X-Google-Smtp-Source: AGHT+IH9qu6xjDlu4LJfi3eSTdGsEfguEJ625ijQxPTBuTkepsyO46nhzRHUkaBF/q2w742rvWN5rQ==
X-Received: by 2002:a17:90a:4f4b:b0:26d:43f0:7ce4 with SMTP id w11-20020a17090a4f4b00b0026d43f07ce4mr3769576pjl.8.1695237305624;
        Wed, 20 Sep 2023 12:15:05 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:b0c6:e5b6:49ef:e0bd])
        by smtp.gmail.com with ESMTPSA id a13-20020a17090a8c0d00b002633fa95ac2sm1656318pjo.13.2023.09.20.12.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 12:15:05 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Douglas Gilbert <dgilbert@interlog.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Subject: [PATCH 10/13] scsi_debug: Rework page code error handling
Date:   Wed, 20 Sep 2023 12:14:35 -0700
Message-ID: <20230920191442.3701673-11-bvanassche@acm.org>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
In-Reply-To: <20230920191442.3701673-1-bvanassche@acm.org>
References: <20230920191442.3701673-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

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
index 88cba9374166..6b87d267c9c5 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -2327,7 +2327,7 @@ static int resp_mode_sense(struct scsi_cmnd *scp,
 	unsigned char *ap;
 	unsigned char arr[SDEBUG_MAX_MSENSE_SZ];
 	unsigned char *cmd = scp->cmnd;
-	bool dbd, llbaa, msense_6, is_disk, is_zbc, bad_pcode;
+	bool dbd, llbaa, msense_6, is_disk, is_zbc;
 
 	dbd = !!(cmd[1] & 0x8);		/* disable block descriptors */
 	pcontrol = (cmd[2] & 0xc0) >> 6;
@@ -2391,7 +2391,6 @@ static int resp_mode_sense(struct scsi_cmnd *scp,
 		mk_sense_invalid_fld(scp, SDEB_IN_CDB, 3, -1);
 		return check_condition_result;
 	}
-	bad_pcode = false;
 
 	switch (pcode) {
 	case 0x1:	/* Read-Write error recovery page, direct access */
@@ -2406,15 +2405,17 @@ static int resp_mode_sense(struct scsi_cmnd *scp,
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
@@ -2467,18 +2468,17 @@ static int resp_mode_sense(struct scsi_cmnd *scp,
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
