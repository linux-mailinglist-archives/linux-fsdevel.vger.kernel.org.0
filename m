Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08B427BAA70
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Oct 2023 21:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbjJETme (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Oct 2023 15:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbjJETma (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Oct 2023 15:42:30 -0400
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F8DEEB;
        Thu,  5 Oct 2023 12:42:14 -0700 (PDT)
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1c60f1a2652so11416435ad.0;
        Thu, 05 Oct 2023 12:42:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696534934; x=1697139734;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y+MAWTVMOc62bHJcXIWIdTiq/rQINfWWQsJrgwniqu0=;
        b=l6vXLYy5vJ54tyLHjS3JcqGiPJbpNg0Pk6Bzx8PKEq9/rn/lIW4raYJmqRz3vjnQS+
         ZC4DrvUwxX7mxs4XAUliCa6T1Givx3gOiHcpTE9zKoMgiRjGpkdo5eAYayZyp3AgWfhS
         NnRO4e+BWPgvvm66jA8E694gsBpFmC0wKZ558pfiJRSE0IAfcrx18SBlRg0iZ4U1VD8/
         DEH9AMW6svcZUhFdxei+rEDHN/3GpN/SVagLn5PzaNnG2dmunK89hxWWCylCVCmZPF+e
         y/FIy61qLSDeoFv6M2Uh3qjwUQNEZXBTTMABatkix4ObwhdZEFry5xQGqOUWE29eSgVB
         SWyA==
X-Gm-Message-State: AOJu0YwrIjOBhkOqzsLr5YJdcvuDrXJDAW2cKTINntTDuqt7yUdtKOOt
        k2RHWAfBwUsoi/ILUm9e6II=
X-Google-Smtp-Source: AGHT+IF5GTe32v+UMke/nckypAVHnbqmEnz1LqDwI7PClnKUa4g9KTGzGM6BleUG7WBrN6upbewe4g==
X-Received: by 2002:a17:902:cecb:b0:1c0:cbaf:6954 with SMTP id d11-20020a170902cecb00b001c0cbaf6954mr6146583plg.25.1696534933756;
        Thu, 05 Oct 2023 12:42:13 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:ca3e:70ef:bad:2f])
        by smtp.gmail.com with ESMTPSA id u4-20020a170902e5c400b001a9b29b6759sm2129596plf.183.2023.10.05.12.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 12:42:13 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        Avri Altman <Avri.Altman@wdc.com>,
        Bean Huo <huobean@gmail.com>,
        Daejun Park <daejun7.park@samsung.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Avri Altman <avri.altman@wdc.com>,
        Douglas Gilbert <dgilbert@interlog.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Subject: [PATCH v2 09/15] scsi_debug: Reduce code duplication
Date:   Thu,  5 Oct 2023 12:40:55 -0700
Message-ID: <20231005194129.1882245-10-bvanassche@acm.org>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
In-Reply-To: <20231005194129.1882245-1-bvanassche@acm.org>
References: <20231005194129.1882245-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

All VPD pages have the page code in byte one. Reduce code duplication by
storing the VPD page code once.

Reviewed-by: Avri Altman <avri.altman@wdc.com>
Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Douglas Gilbert <dgilbert@interlog.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/scsi_debug.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 9c0af50501f9..46eaa2f9e63b 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -1598,7 +1598,8 @@ static int resp_inquiry(struct scsi_cmnd *scp, struct sdebug_dev_info *devip)
 		u32 len;
 		char lu_id_str[6];
 		int host_no = devip->sdbg_host->shost->host_no;
-		
+
+		arr[1] = cmd[2];
 		port_group_id = (((host_no + 1) & 0x7f) << 8) +
 		    (devip->channel & 0x7f);
 		if (sdebug_vpd_use_hostno == 0)
@@ -1609,7 +1610,6 @@ static int resp_inquiry(struct scsi_cmnd *scp, struct sdebug_dev_info *devip)
 				 (devip->target * 1000) - 3;
 		len = scnprintf(lu_id_str, 6, "%d", lu_id_num);
 		if (0 == cmd[2]) { /* supported vital product data pages */
-			arr[1] = cmd[2];	/*sanity */
 			n = 4;
 			arr[n++] = 0x0;   /* this page */
 			arr[n++] = 0x80;  /* unit serial number */
@@ -1630,23 +1630,18 @@ static int resp_inquiry(struct scsi_cmnd *scp, struct sdebug_dev_info *devip)
 			}
 			arr[3] = n - 4;	  /* number of supported VPD pages */
 		} else if (0x80 == cmd[2]) { /* unit serial number */
-			arr[1] = cmd[2];	/*sanity */
 			arr[3] = len;
 			memcpy(&arr[4], lu_id_str, len);
 		} else if (0x83 == cmd[2]) { /* device identification */
-			arr[1] = cmd[2];	/*sanity */
 			arr[3] = inquiry_vpd_83(&arr[4], port_group_id,
 						target_dev_id, lu_id_num,
 						lu_id_str, len,
 						&devip->lu_name);
 		} else if (0x84 == cmd[2]) { /* Software interface ident. */
-			arr[1] = cmd[2];	/*sanity */
 			arr[3] = inquiry_vpd_84(&arr[4]);
 		} else if (0x85 == cmd[2]) { /* Management network addresses */
-			arr[1] = cmd[2];	/*sanity */
 			arr[3] = inquiry_vpd_85(&arr[4]);
 		} else if (0x86 == cmd[2]) { /* extended inquiry */
-			arr[1] = cmd[2];	/*sanity */
 			arr[3] = 0x3c;	/* number of following entries */
 			if (sdebug_dif == T10_PI_TYPE3_PROTECTION)
 				arr[4] = 0x4;	/* SPT: GRD_CHK:1 */
@@ -1656,30 +1651,23 @@ static int resp_inquiry(struct scsi_cmnd *scp, struct sdebug_dev_info *devip)
 				arr[4] = 0x0;   /* no protection stuff */
 			arr[5] = 0x7;   /* head of q, ordered + simple q's */
 		} else if (0x87 == cmd[2]) { /* mode page policy */
-			arr[1] = cmd[2];	/*sanity */
 			arr[3] = 0x8;	/* number of following entries */
 			arr[4] = 0x2;	/* disconnect-reconnect mp */
 			arr[6] = 0x80;	/* mlus, shared */
 			arr[8] = 0x18;	 /* protocol specific lu */
 			arr[10] = 0x82;	 /* mlus, per initiator port */
 		} else if (0x88 == cmd[2]) { /* SCSI Ports */
-			arr[1] = cmd[2];	/*sanity */
 			arr[3] = inquiry_vpd_88(&arr[4], target_dev_id);
 		} else if (is_disk_zbc && 0x89 == cmd[2]) { /* ATA info */
-			arr[1] = cmd[2];        /*sanity */
 			n = inquiry_vpd_89(&arr[4]);
 			put_unaligned_be16(n, arr + 2);
 		} else if (is_disk_zbc && 0xb0 == cmd[2]) { /* Block limits */
-			arr[1] = cmd[2];        /*sanity */
 			arr[3] = inquiry_vpd_b0(&arr[4]);
 		} else if (is_disk_zbc && 0xb1 == cmd[2]) { /* Block char. */
-			arr[1] = cmd[2];        /*sanity */
 			arr[3] = inquiry_vpd_b1(devip, &arr[4]);
 		} else if (is_disk && 0xb2 == cmd[2]) { /* LB Prov. */
-			arr[1] = cmd[2];        /*sanity */
 			arr[3] = inquiry_vpd_b2(&arr[4]);
 		} else if (is_zbc && cmd[2] == 0xb6) { /* ZB dev. charact. */
-			arr[1] = cmd[2];        /*sanity */
 			arr[3] = inquiry_vpd_b6(devip, &arr[4]);
 		} else {
 			mk_sense_invalid_fld(scp, SDEB_IN_CDB, 2, -1);
