Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D94438B81
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2019 15:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729322AbfFGNSf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jun 2019 09:18:35 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:56479 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729237AbfFGNSZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jun 2019 09:18:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1559913543; x=1591449543;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7YLox0tNG9lHpTIY6mw5AUho1M9ivC0mOCOT+Ptqtag=;
  b=N9ghDEItGra4M3hn4J1YEmpfaYc9wUP+5be/71BtOpMut9cZp2kdLYR8
   QqoYsaGt8Mym7ZQtDnwBTA7gggHMUxuUbb23vKufW3LGIcwIcg4DpLtxu
   NXR/PB8gGX75sGB+1sOWcpTRm5XtwdxkpM3IXjxcEGQ7rLBaZ0ls2J3nv
   VfYZTw4pInOwWS8g3R5WcpMW/+JSFUOw4R3iQ0bazCXFxRFyj7KdtwG5w
   zomhklQHEoE31PqXn7vCPFfXDViyYyrxKQCIeVw9o91fz6jSgTPuH+5aX
   eTFfd7knC17TwshWbd9xozsIEYEBnjupYDGp+SoQYr//UMsUXoj/k3qAs
   A==;
X-IronPort-AV: E=Sophos;i="5.63,563,1557158400"; 
   d="scan'208";a="209675031"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Jun 2019 21:19:03 +0800
IronPort-SDR: fhh+Eb7eEBM7K27cHL19ZtzYge3s7ME3DC4xsAzr9bGw1moJGYwXL4Qt77pXNniZMZKS00OXNF
 /aZwVyFzJTX80pwg3bnHoLTAkyJUa4W+diwCANjnRTYWXNfmfvCsqqP66N+qeXpe8zeZsK0H2m
 1rmmdAf8+gEXukIQfG0B5IkYhyQ7wPS+/PAEvpxLIe3RcUt9NRYQkpKQvo2Ny1fKruWsdYXodi
 6Pglo1qLc3ZjNw8a45yOnOtch3scUq4k+Y5gXhOB5q8tf6Hw14cUop5B96IpCBI3dmOX7tHHQh
 800aOelsOYlUlvZhjYqPVtgK
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 07 Jun 2019 05:55:42 -0700
IronPort-SDR: vbwS6gnqfZa3FR8uJ/1d5LALS/dMBFOW13K5BAVI3QDC6EPc2VxU7W6/CnqRw6a4WWOb/Y7a6S
 PVIYYUylJJJMchov5wzsmU7EzajGiChKTaApdkirYb0Vk5YGJbni87vTI0RY3GbyOkzwaVo6Gv
 D3hO8Yr65KVJTPGoMdxCofVZ7G7g+dEmzlOkcWJWncZIOW649RCU4c6FwF0n0jBULMSakAnz8c
 s/UzpElvM+dcJenD57r9GSaXZ7/2qsUnusp3KTMqfjF71QZ55ytwp9wFuEX/i6tbQfY/efjuF4
 3PU=
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 07 Jun 2019 06:18:24 -0700
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
Subject: [PATCH 11/12] btrfs-progs: device-add: support HMZONED device
Date:   Fri,  7 Jun 2019 22:17:50 +0900
Message-Id: <20190607131751.5359-11-naohiro.aota@wdc.com>
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
 cmds-device.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/cmds-device.c b/cmds-device.c
index e3e30b6d5ded..86ffb1a2a5c2 100644
--- a/cmds-device.c
+++ b/cmds-device.c
@@ -57,6 +57,9 @@ static int cmd_device_add(int argc, char **argv)
 	int discard = 1;
 	int force = 0;
 	int last_dev;
+	int res;
+	int hmzoned;
+	struct btrfs_ioctl_feature_flags feature_flags;
 
 	optind = 0;
 	while (1) {
@@ -92,12 +95,33 @@ static int cmd_device_add(int argc, char **argv)
 	if (fdmnt < 0)
 		return 1;
 
+	res = ioctl(fdmnt, BTRFS_IOC_GET_FEATURES, &feature_flags);
+	if (res) {
+		error("error getting feature flags '%s': %m", mntpnt);
+		return 1;
+	}
+	hmzoned = feature_flags.incompat_flags & BTRFS_FEATURE_INCOMPAT_HMZONED;
+
 	for (i = optind; i < last_dev; i++){
 		struct btrfs_ioctl_vol_args ioctl_args;
-		int	devfd, res;
+		int	devfd;
 		u64 dev_block_count = 0;
 		char *path;
 
+		if (hmzoned && zoned_model(argv[i]) == ZONED_NONE) {
+			error("cannot add non-zoned device to HMZONED file system '%s'",
+			      argv[i]);
+			ret++;
+			continue;
+		}
+
+		if (!hmzoned && zoned_model(argv[i]) == ZONED_HOST_MANAGED) {
+			error("cannot add host managed zoned device to non-HMZONED file system '%s'",
+			      argv[i]);
+			ret++;
+			continue;
+		}
+
 		res = test_dev_for_mkfs(argv[i], force);
 		if (res) {
 			ret++;
@@ -113,7 +137,8 @@ static int cmd_device_add(int argc, char **argv)
 
 		res = btrfs_prepare_device(devfd, argv[i], &dev_block_count, 0,
 				PREP_DEVICE_ZERO_END | PREP_DEVICE_VERBOSE |
-				(discard ? PREP_DEVICE_DISCARD : 0));
+				(discard ? PREP_DEVICE_DISCARD : 0) |
+				(hmzoned ? PREP_DEVICE_HMZONED : 0));
 		close(devfd);
 		if (res) {
 			ret++;
-- 
2.21.0

