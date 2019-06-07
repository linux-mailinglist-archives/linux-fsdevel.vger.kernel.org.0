Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C29938B7D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2019 15:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729282AbfFGNS2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jun 2019 09:18:28 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:56479 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729274AbfFGNS1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jun 2019 09:18:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1559913547; x=1591449547;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7OJCfl7mJcrjPMSDFaEobu5+R6OlEI3WvKTSWthUVKA=;
  b=cat6pKsmsGvICKvIRFSiNmsIDjb+2tYCRhFMsW/psD4i/JBUD6ASRYWc
   MrSq6ihFSsV1A/Sx15fDJ7A2UeCW+l4xPXh1CEjYHvOZCJdUfngtIk3+a
   yHV8K+EC/kcjbPfrQSXksOVkfNWO0TJLjVEoj2ZnWJzm8RpcUFccVq+m8
   /bCFXK6E7J8/oedlREQTvr07WJQiGRYJ37eRQLOHvMVnxHSo5CLR1mV92
   PALQtANBD+sb0cFHBFHgFjcSFSbZWhlNefj46fteFZZuJg2KUPXL6/MB4
   9vIZJphdEMF4ImHluYERcOESMrQrEITidGId6Ubu0GBvo0EfFISPqLR9B
   g==;
X-IronPort-AV: E=Sophos;i="5.63,563,1557158400"; 
   d="scan'208";a="209675034"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Jun 2019 21:19:06 +0800
IronPort-SDR: xgi4EgEqZ/nvDaA/Y4QrDRNhQ2jkmUpl8UrzS1+ryZ+f+egYcyXt5uTbFk5mOfYb0VFvecmc/Q
 1TlSlKMNZARr1/4JLsIGsAEULTWcjY+0++VKgRDa+b/94VEZzaV2hzbhGO3LGiGxKjogrX+YyJ
 XDUDT8/aU7ov8/HeWxsgJD73Yg0ZHPmqAQ/EnU2w6C+dszcmRDMtmTvOrZkhali59ZfwRTxNYj
 DOqy2leTzYKjOMlwmwbbwYcv26xlc2sVOSjdTAKQlZjPIDfuTLlj/7JY/nRakdQwSgNIMxZP1y
 +o/rGJKTp4Bin2wUa+mgLrEN
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 07 Jun 2019 05:55:45 -0700
IronPort-SDR: EGR3OeGqPSc8rQAD7I2QT16I633TuWGjdQODiLRNAhQQB0qJp685MdKHrdeEnUgxVpoX3sjoGN
 XubpuDY4bDd/9XP1+/gJRVFWr8gzq0PSYCMxUhy+YEK/tGNV2sB7RDEPxT5kgl5/mrZ4UhfpAZ
 OWUqG6ADmh7hYLzNP6pqy67y/g8eermho3CKWM3F5PGlCHl4ivONBiAtcQEwGwaLWszTy3E0Cq
 wyUj+avjKxf6f0sSmVT8RU2fheYM+ZaWzwDMzBCupHQvIdJ7PbxV7Nt81ZJDgHPYUPKkT3sSsa
 zms=
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 07 Jun 2019 06:18:26 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Qu Wenruo <wqu@suse.com>, Nikolay Borisov <nborisov@suse.com>,
        linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        linux-fsdevel@vger.kernel.org,
        Damien Le Moal <damien.lemoal@wdc.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 12/12] btrfs-progs: introduce support for dev-place HMZONED device
Date:   Fri,  7 Jun 2019 22:17:51 +0900
Message-Id: <20190607131751.5359-12-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190607131751.5359-1-naohiro.aota@wdc.com>
References: <20190607131025.31996-1-naohiro.aota@wdc.com>
 <20190607131751.5359-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch check if the target file system is flagged as HMZONED. If it is,
the device to be added is flagged PREP_DEVICE_HMZONED.  Also add checks to
prevent mixing non-zoned devices and zoned devices.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 cmds-replace.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/cmds-replace.c b/cmds-replace.c
index 713d200938d4..c752ceaadb77 100644
--- a/cmds-replace.c
+++ b/cmds-replace.c
@@ -116,6 +116,7 @@ static const char *const cmd_replace_start_usage[] = {
 
 static int cmd_replace_start(int argc, char **argv)
 {
+	struct btrfs_ioctl_feature_flags feature_flags;
 	struct btrfs_ioctl_dev_replace_args start_args = {0};
 	struct btrfs_ioctl_dev_replace_args status_args = {0};
 	int ret;
@@ -123,6 +124,7 @@ static int cmd_replace_start(int argc, char **argv)
 	int c;
 	int fdmnt = -1;
 	int fddstdev = -1;
+	int hmzoned;
 	char *path;
 	char *srcdev;
 	char *dstdev = NULL;
@@ -163,6 +165,13 @@ static int cmd_replace_start(int argc, char **argv)
 	if (fdmnt < 0)
 		goto leave_with_error;
 
+	ret = ioctl(fdmnt, BTRFS_IOC_GET_FEATURES, &feature_flags);
+	if (ret) {
+		error("ioctl(GET_FEATURES) on '%s' returns error: %m", path);
+		goto leave_with_error;
+	}
+	hmzoned = feature_flags.incompat_flags & BTRFS_FEATURE_INCOMPAT_HMZONED;
+
 	/* check for possible errors before backgrounding */
 	status_args.cmd = BTRFS_IOCTL_DEV_REPLACE_CMD_STATUS;
 	status_args.result = BTRFS_IOCTL_DEV_REPLACE_RESULT_NO_RESULT;
@@ -257,7 +266,8 @@ static int cmd_replace_start(int argc, char **argv)
 	strncpy((char *)start_args.start.tgtdev_name, dstdev,
 		BTRFS_DEVICE_PATH_NAME_MAX);
 	ret = btrfs_prepare_device(fddstdev, dstdev, &dstdev_block_count, 0,
-			PREP_DEVICE_ZERO_END | PREP_DEVICE_VERBOSE);
+			PREP_DEVICE_ZERO_END | PREP_DEVICE_VERBOSE |
+			(hmzoned ? PREP_DEVICE_HMZONED | PREP_DEVICE_DISCARD : 0));
 	if (ret)
 		goto leave_with_error;
 
-- 
2.21.0

