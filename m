Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 924D538B6D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2019 15:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728577AbfFGNSG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jun 2019 09:18:06 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:56451 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727467AbfFGNSF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jun 2019 09:18:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1559913513; x=1591449513;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Yc969BoWhmiS9qHR4q79BQ4HSMy5w/pXrnIo0UWQJmY=;
  b=UkkXvQUzN7tsWlwtELDMqlg+UgWuY986h2iNKpdCv8ySchRj3fpDb//V
   RMN+Ml6hqP4/x6uGol8aTHUApEwm33xkAohSIxWLfC9LAgEnOU4nlOTor
   HYLsLr6UhCaYadQFV5U6seZ8PsLycn5h1Z3SG2edeL3T4DDhz7DDXxRYT
   GOiA33eFN0k/w+L3rC+YCA2oRgejABXCS54uLTzDjBikb0MLtFRPEel5g
   wkFJzffoohUhZDDCnMFbgQyldWBC9A3gF51KQRWxJ2rqbUQvJzSv0fOxl
   gxpOcuUSf161ZzYBj2k/VKM1IgcgrfV+kfVK7+geXvkvLjVOkSr5UcLRv
   w==;
X-IronPort-AV: E=Sophos;i="5.63,563,1557158400"; 
   d="scan'208";a="209674981"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Jun 2019 21:18:32 +0800
IronPort-SDR: rmtvv5nKXeyRyZxuWjbCVuAKeQ1mrf7MA2JIu3qYWO6NfbWid60j3nK929FRtGwwsYR6v/piXJ
 qch08UWSWH53cN5LEHX/1Kp6Mo1YEi8MiLcPsk3s3tRhPhtYPXJEIrbceZD2QjiRxYFytzezA0
 5es02aPxo0Fw+D++kZhqp6MNKd9MJuG9JqpiD+y0Q8oQtNsBG/ZjJOAgfN3p3DeGQZdUfQ7J4+
 egUCSKM5QR4ohvB5xlf3ZfEaoWRo776Bn2wcJJ5XR4jX3aCwQH17S5oaL81+TeYk8vTSeq7kdp
 3YQEwJKCBQesSTy4+KTig/LS
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 07 Jun 2019 05:55:22 -0700
IronPort-SDR: nIMyNf0cdHsV8clYR97sR6yXmzQaSw1ZOwFyLEPpECQq4biZuhMO0Yv/Q61ZpBW8ELsOnf0S8y
 OEwLWN0J73Ef1CzjUM3ajO9XtRg/y+r017FHj+JrQ1GEkkVZsdoR2MsA4Di571aBB6zej8qt9u
 F1GQNr/rBL738AotV5qHDshK0NKHNlDHU3Qa4BgCpEXuu1DZs5yOIdP4cz5BR9TdizAMaupWYC
 pVNtp9ckZYBLrAsBWtNneR9Ss37NfgtRlu5KTkz1wwEsJGaQk+yZdBFKQkWaZpS2aUWGzvXXry
 Z5I=
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 07 Jun 2019 06:18:03 -0700
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
Subject: [PATCH 02/12] btrfs-progs: utils: Introduce queue_param
Date:   Fri,  7 Jun 2019 22:17:41 +0900
Message-Id: <20190607131751.5359-2-naohiro.aota@wdc.com>
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

Introduce the queue_param function to get a device request queue
parameter and this function to test if the device is an SSD in
is_ssd().

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
[Naohiro] fixed error return value
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 mkfs/main.c | 40 ++--------------------------------------
 utils.c     | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 utils.h     |  1 +
 3 files changed, 49 insertions(+), 38 deletions(-)

diff --git a/mkfs/main.c b/mkfs/main.c
index b442e6e40c37..93c0b71c864e 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -404,49 +404,13 @@ static int zero_output_file(int out_fd, u64 size)
 
 static int is_ssd(const char *file)
 {
-	blkid_probe probe;
-	char wholedisk[PATH_MAX];
-	char sysfs_path[PATH_MAX];
-	dev_t devno;
-	int fd;
 	char rotational;
 	int ret;
 
-	probe = blkid_new_probe_from_filename(file);
-	if (!probe)
+	ret = queue_param(file, "rotational", &rotational, 1);
+	if (ret < 1)
 		return 0;
 
-	/* Device number of this disk (possibly a partition) */
-	devno = blkid_probe_get_devno(probe);
-	if (!devno) {
-		blkid_free_probe(probe);
-		return 0;
-	}
-
-	/* Get whole disk name (not full path) for this devno */
-	ret = blkid_devno_to_wholedisk(devno,
-			wholedisk, sizeof(wholedisk), NULL);
-	if (ret) {
-		blkid_free_probe(probe);
-		return 0;
-	}
-
-	snprintf(sysfs_path, PATH_MAX, "/sys/block/%s/queue/rotational",
-		 wholedisk);
-
-	blkid_free_probe(probe);
-
-	fd = open(sysfs_path, O_RDONLY);
-	if (fd < 0) {
-		return 0;
-	}
-
-	if (read(fd, &rotational, 1) < 1) {
-		close(fd);
-		return 0;
-	}
-	close(fd);
-
 	return rotational == '0';
 }
 
diff --git a/utils.c b/utils.c
index c6cdc8f01dc1..7d5a1f3b7f8d 100644
--- a/utils.c
+++ b/utils.c
@@ -65,6 +65,52 @@ static unsigned short rand_seed[3];
 
 struct btrfs_config bconf;
 
+/*
+ * Get a device request queue parameter.
+ */
+int queue_param(const char *file, const char *param, char *buf, size_t len)
+{
+	blkid_probe probe;
+	char wholedisk[PATH_MAX];
+	char sysfs_path[PATH_MAX];
+	dev_t devno;
+	int fd;
+	int ret;
+
+	probe = blkid_new_probe_from_filename(file);
+	if (!probe)
+		return 0;
+
+	/* Device number of this disk (possibly a partition) */
+	devno = blkid_probe_get_devno(probe);
+	if (!devno) {
+		blkid_free_probe(probe);
+		return 0;
+	}
+
+	/* Get whole disk name (not full path) for this devno */
+	ret = blkid_devno_to_wholedisk(devno,
+			wholedisk, sizeof(wholedisk), NULL);
+	if (ret) {
+		blkid_free_probe(probe);
+		return 0;
+	}
+
+	snprintf(sysfs_path, PATH_MAX, "/sys/block/%s/queue/%s",
+		 wholedisk, param);
+
+	blkid_free_probe(probe);
+
+	fd = open(sysfs_path, O_RDONLY);
+	if (fd < 0)
+		return 0;
+
+	len = read(fd, buf, len);
+	close(fd);
+
+	return len;
+}
+
 /*
  * Discard the given range in one go
  */
diff --git a/utils.h b/utils.h
index 7c5eb798557d..47321f62c8e0 100644
--- a/utils.h
+++ b/utils.h
@@ -121,6 +121,7 @@ int get_label(const char *btrfs_dev, char *label);
 int set_label(const char *btrfs_dev, const char *label);
 
 char *__strncpy_null(char *dest, const char *src, size_t n);
+int queue_param(const char *file, const char *param, char *buf, size_t len);
 int is_block_device(const char *file);
 int is_mount_point(const char *file);
 int is_path_exist(const char *file);
-- 
2.21.0

