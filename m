Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2C79265F9B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Sep 2020 14:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725928AbgIKMeg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Sep 2020 08:34:36 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:38372 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgIKMds (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Sep 2020 08:33:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599827629; x=1631363629;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+3nWbUVlFor4kVfiP3oNqaSLc+/2lCklw0996h4GMGc=;
  b=RTIL2YdkYd6abNTlDVoM2sKdCTgsJz4E64h1XxYQwIjU5tFIxaGoKeAE
   bFX8OMI2Tr4hIK/Gzdxvs24bTfl9FBsPn2p7+nOGPTZpfck4O7zP6PHvm
   40yZDdqYLTzXFjYQbo1lyjJc5gMtDeOt1kQZDvIQobzWrlkD7cdgtlmSv
   SCk/N7HQJZiwGkGKE51uIBoBa3NXiDZSiq+RtdgVA7p3KorQwTX8OsfmP
   v8Y0ezkh/sKWJksY9TL7sLCydG+Z6p4Y17/3Y7HsZgjMi6sG1K3GfY8FE
   5lBP28s5KO0IIgXOmCmrNdafhtBKCW6f0EwOIgVeepgyEio0iCxiOhYcw
   g==;
IronPort-SDR: +V1XvkrfvT5YgH2MDqz6htCoST9XvpxXZgLpuzJV+U6lCnZqGSwhTusA3sabrBIbXeVzJxATLJ
 PGxY4y7fDQyC1xK6UIpCufxiygNWXLehIVFQ/2kLsLT4wCjJHY8rGc5A0LFtwLPxqQB2BKuJSS
 h/1pQPLPULDrqZ44qIK+fGMAvhE5trRGJEfWmkFV1LXQERVK68Q2r2Ww/Lp4fEl2JDpzGX4T+G
 WEIta9y6qNYmTloSH5w8xibbvTIOmGBBIZSj7gMPRnELNqEP2/OLtEzxeHI1RRBjBjlSj9igPm
 SNw=
X-IronPort-AV: E=Sophos;i="5.76,415,1592841600"; 
   d="scan'208";a="147125946"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Sep 2020 20:33:09 +0800
IronPort-SDR: 011ghEOVGHYPojpSxF4EPOfwNszaQptZsWgeUH9kTZ0hIrEqRLFU2t0OYxCKqzpZ/vuiF1o6B9
 fCnPoRMEhtXA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2020 05:19:30 -0700
IronPort-SDR: bNW0znLN4m7r2EHLLcUqFuMFuhRF0017toi2Z5FoO1Jj9BMWXCtGVxwvHtMexOCQGSvYgbK4It
 0Yb29VfSP7+Q==
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Sep 2020 05:33:07 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Hannes Reinecke <hare@suse.com>, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Anand Jain <anand.jain@oracle.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Damien Le Moal <damien.lemoal@wdc.com>
Subject: [PATCH v7 01/39] btrfs: introduce ZONED feature flag
Date:   Fri, 11 Sep 2020 21:32:21 +0900
Message-Id: <20200911123259.3782926-2-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200911123259.3782926-1-naohiro.aota@wdc.com>
References: <20200911123259.3782926-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch introduces the ZONED incompat flag. The flag indicates that the
volume management will satisfy the constraints imposed by host-managed
zoned block devices.

Reviewed-by: Anand Jain <anand.jain@oracle.com>
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/sysfs.c           | 2 ++
 include/uapi/linux/btrfs.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index c8df2edafd85..38c7a57789d8 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -262,6 +262,7 @@ BTRFS_FEAT_ATTR_INCOMPAT(no_holes, NO_HOLES);
 BTRFS_FEAT_ATTR_INCOMPAT(metadata_uuid, METADATA_UUID);
 BTRFS_FEAT_ATTR_COMPAT_RO(free_space_tree, FREE_SPACE_TREE);
 BTRFS_FEAT_ATTR_INCOMPAT(raid1c34, RAID1C34);
+BTRFS_FEAT_ATTR_INCOMPAT(zoned, ZONED);
 
 static struct attribute *btrfs_supported_feature_attrs[] = {
 	BTRFS_FEAT_ATTR_PTR(mixed_backref),
@@ -277,6 +278,7 @@ static struct attribute *btrfs_supported_feature_attrs[] = {
 	BTRFS_FEAT_ATTR_PTR(metadata_uuid),
 	BTRFS_FEAT_ATTR_PTR(free_space_tree),
 	BTRFS_FEAT_ATTR_PTR(raid1c34),
+	BTRFS_FEAT_ATTR_PTR(zoned),
 	NULL
 };
 
diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
index 2c39d15a2beb..5df73001aad4 100644
--- a/include/uapi/linux/btrfs.h
+++ b/include/uapi/linux/btrfs.h
@@ -307,6 +307,7 @@ struct btrfs_ioctl_fs_info_args {
 #define BTRFS_FEATURE_INCOMPAT_NO_HOLES		(1ULL << 9)
 #define BTRFS_FEATURE_INCOMPAT_METADATA_UUID	(1ULL << 10)
 #define BTRFS_FEATURE_INCOMPAT_RAID1C34		(1ULL << 11)
+#define BTRFS_FEATURE_INCOMPAT_ZONED		(1ULL << 12)
 
 struct btrfs_ioctl_feature_flags {
 	__u64 compat_flags;
-- 
2.27.0

