Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC4C7A8C9C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Sep 2023 21:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbjITTQD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Sep 2023 15:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbjITTPb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Sep 2023 15:15:31 -0400
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 309DD12B;
        Wed, 20 Sep 2023 12:15:05 -0700 (PDT)
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-578af21ff50so74735a12.1;
        Wed, 20 Sep 2023 12:15:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695237304; x=1695842104;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ii59m5xCTgqg6QGOg5WM7rjN4QDexfLB+c1iYtMG1tY=;
        b=f+s85tO6nyvrkX4uY5WlCN1gfZARAl60KJoHBrVcoBSpAEw1+Zxg8oMYmVxZ8tQiMd
         LHPE1D0AgggK+qtQ5H3jAhAwecVLXZQciXLNNeWdogL4oSaWq8ViCA0j4+0yexEggs5u
         1bLrBAJBIDPods5kZ0qfuGrLf0wkTLfWRalvAVloxeEo8L4UjFyWhBhUlwn/67njgE9U
         JA4QiJ2/509yJIGJ1M6NVtnkesx3prHBNM4AEkZvRdJYtcp+IF05KGOXBeg20t4B+Buf
         U4aguVJdeyqpsJITq51BsYl84Yo2+fO51QwFdbfWrFHllhP1THlqJWAbQ9Fi/+ryFvAi
         sTfg==
X-Gm-Message-State: AOJu0YzwRyfahXzOsrBBYK7dO3sSREeJVPIWoREEdjyHMuzbOJHZ30ks
        Nrg6vDdFceeoNJDo7xpZ8u+cKIilR+U=
X-Google-Smtp-Source: AGHT+IGnl8fl04A/u2Kl+h68BofUj59vmffs7DzUnShI5+0eIC/esjoh/k27+KIHe80wGc1KEqXRRg==
X-Received: by 2002:a17:90b:1b03:b0:26b:4ce1:9705 with SMTP id nu3-20020a17090b1b0300b0026b4ce19705mr3667816pjb.38.1695237304194;
        Wed, 20 Sep 2023 12:15:04 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:b0c6:e5b6:49ef:e0bd])
        by smtp.gmail.com with ESMTPSA id a13-20020a17090a8c0d00b002633fa95ac2sm1656318pjo.13.2023.09.20.12.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 12:15:03 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Douglas Gilbert <dgilbert@interlog.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Subject: [PATCH 09/13] scsi_debug: Support the block limits extension VPD page
Date:   Wed, 20 Sep 2023 12:14:34 -0700
Message-ID: <20230920191442.3701673-10-bvanassche@acm.org>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
In-Reply-To: <20230920191442.3701673-1-bvanassche@acm.org>
References: <20230920191442.3701673-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From T10 document 23-024r3.pdf:

"Reduced stream control:
a) reduces the maximum number of streams that the device server supports;
   and
b) increases the number of write commands that are able to specify a stream
   to be written in any write command that contains the GROUP NUMBER field
   in its CDB.

If the RSCS bit (see 6.6.5) is set to one, then the device server shall:
a) support per group stream identifier usage as described in 4.32.2;
b) support the IO Advice Hints Grouping mode page (see 6.5.7); and
c) set the MAXIMUM NUMBER OF STREAMS field (see 6.6.5) to a value that is
   less than 64.

Device servers that set the RSCS bit to one may support other features
(e.g., permanent streams (see 4.32.4)).

4.32.4 Permanent streams

A permanent stream is a stream for which the device server does not allow
closing or otherwise modifying the configuration of that stream. The PERM
bit (see 5.9.2.3) indicates whether a stream is a permanent stream. If a
STREAM CONTROL command (see 5.32) specifies the closing of a permanent
stream, the device server terminates that command with CHECK CONDITION
status instead of closing the specified stream. A permanent stream is always
an open stream. Device severs should assign the lowest numbered stream
identifiers to permanent streams."

Report that reduced stream control is supported.

Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Douglas Gilbert <dgilbert@interlog.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/scsi_debug.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 46eaa2f9e63b..88cba9374166 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -1627,6 +1627,7 @@ static int resp_inquiry(struct scsi_cmnd *scp, struct sdebug_dev_info *devip)
 					arr[n++] = 0xb2;  /* LB Provisioning */
 				if (is_zbc)
 					arr[n++] = 0xb6;  /* ZB dev. char. */
+				arr[n++] = 0xb7;  /* Block limits extension */
 			}
 			arr[3] = n - 4;	  /* number of supported VPD pages */
 		} else if (0x80 == cmd[2]) { /* unit serial number */
@@ -1669,6 +1670,9 @@ static int resp_inquiry(struct scsi_cmnd *scp, struct sdebug_dev_info *devip)
 			arr[3] = inquiry_vpd_b2(&arr[4]);
 		} else if (is_zbc && cmd[2] == 0xb6) { /* ZB dev. charact. */
 			arr[3] = inquiry_vpd_b6(devip, &arr[4]);
+		} else if (cmd[2] == 0xb7) { /* block limits extension page */
+			arr[3] = 2; /* page length */
+			arr[5] = 1; /* Reduced stream control support (RSCS) */
 		} else {
 			mk_sense_invalid_fld(scp, SDEB_IN_CDB, 2, -1);
 			kfree(arr);
