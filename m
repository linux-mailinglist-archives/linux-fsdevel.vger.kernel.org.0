Return-Path: <linux-fsdevel+bounces-571-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B9AE47CCEAF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Oct 2023 22:48:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A32AB21525
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Oct 2023 20:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B5BA2EB1A;
	Tue, 17 Oct 2023 20:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84962E40A
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Oct 2023 20:48:32 +0000 (UTC)
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 459A592;
	Tue, 17 Oct 2023 13:48:31 -0700 (PDT)
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-57b68556d6dso3417587eaf.1;
        Tue, 17 Oct 2023 13:48:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697575710; x=1698180510;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=105xJtXU3kMI2hh6/g7PSS5FLkiZJWAuMxIKylxsIMA=;
        b=e1EOyN+kQM8p1yAG3aLBBb6Y5abK6836jHXVGh+QEoc90djBXR6cXqLNMjaxbqlVjq
         RPOU59K7vyow+dNk7rSbZ5TAzl9HOE/kCZ6Rw6yXbi2I77F5EBkQbyVka37e8Flq84Pf
         sQZu7zwsOVUkrEKUTM1PJSn6sJVE6y/LiB2PNONB7kKB09hsAXbQ9HW+mn49AADOLMi+
         8EjFvKkHKVwaYps8MbB4YbX6Q6Vac/sNfxVGOsMIrv85i+w25gtP4KQ3hV3phm+oKcva
         m6pacgglbcB8/CvWDMvk3J9BUezLGl8EA59wlLJGx2EmN7VAmctYhpBN2DUBm4KQNqtF
         47hw==
X-Gm-Message-State: AOJu0YxEPE3WGCRTbtQMXl6YV061MjOZnKnM5g9X3+OKrtoOOjY4ZRQ6
	wRjnQk+U1rSeiOE/lpbwxD0=
X-Google-Smtp-Source: AGHT+IGKpwnJVusLdCOnbH4TMWpBVokmUp5EtTJw1dIbjz3QvVxicCOEifeVNO4gmLHRTIznDv/kXw==
X-Received: by 2002:a05:6359:29c2:b0:13e:d853:cc22 with SMTP id qf2-20020a05635929c200b0013ed853cc22mr3093749rwb.4.1697575710260;
        Tue, 17 Oct 2023 13:48:30 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:8f02:2919:9600:ac09])
        by smtp.gmail.com with ESMTPSA id fa36-20020a056a002d2400b006b2e07a6235sm1874704pfb.136.2023.10.17.13.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 13:48:29 -0700 (PDT)
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
Subject: [PATCH v3 09/14] scsi_debug: Support the block limits extension VPD page
Date: Tue, 17 Oct 2023 13:47:17 -0700
Message-ID: <20231017204739.3409052-10-bvanassche@acm.org>
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
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From SBC-5 r05:

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

