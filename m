Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8791038B64
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2019 15:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728756AbfFGNSI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jun 2019 09:18:08 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:56451 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728689AbfFGNSI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jun 2019 09:18:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1559913516; x=1591449516;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kE1dxgEdKiS9vm8kRxNFlOdjtYNADwAQaRBEWkOjG7I=;
  b=e8v+X/GAePuNSn+9kWOQk9oCn3mz16Ocx5kkdi7fauImTBsq2+IH7VyG
   BPTl+CCdBolwub3SKsOoZOKYeRcMKj0Z18MazRyHJOLvPs0wuQTns6H+T
   1j27sKYQcTcShDvfUGYgWKci7hrvVNSJxEsv53lXHM9y/HYuxEqlUIVEV
   WjwYmOLm49irb1syqEOijhI3gerDf3+Wr01q7Xh62hxTsIAr1F5vH0d4a
   ZtNacjQr9Nw7fStlgPkp158QwvK8EisKkZ63bE47XRoAOzBphAKEx3ys4
   7/DOCdEzlOTkzbPwio/Z5yjGQrd2SYcu2LTH4fytOeM5qhaX8W/HdRfkG
   g==;
X-IronPort-AV: E=Sophos;i="5.63,563,1557158400"; 
   d="scan'208";a="209674986"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Jun 2019 21:18:36 +0800
IronPort-SDR: wh1Fat/eLjraEeHlm//cqBN4HcCeQnXpbsg57H6RSXleGlXvzwW/MCo6+TAmh9OvXMYfdWrEO9
 9UjvzCX1d6WsD8IJF45GstmBqnmypbOuOEAWmUptajqGiMtEvF/kXE2pjidkKuX6BCNYMETqY+
 fAjdypuj9NFWvIpoWm2TrnfHz+kWDEGW6sN5+NSiJuoC/tCy4v1mGQchmxExluDvpLLyaGLE+g
 KKuAeF7CBbb5fydqHOQbmNYCiGh5/8OJ/J4NF1DPWDCNGpHMDiirz09LqVPPDuj3znxZYnYGBs
 QR/TeZUzJhteoJN8SyKaZIKw
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 07 Jun 2019 05:55:24 -0700
IronPort-SDR: yz4Fwogp9nNtP6CLFtFcpZ88nZKTt+wJImrrhc8x8wAKFFBYsOLVrVR7kjJY/1AcKL3io1l2/z
 u1Exda8OB9QDtbKEayGOAx25XX4m4sPhkSIp/u41UYCaSZ81DFUKbsKSS95rjPQY36fnwm6zEw
 dcyCnGkNXJzkuc0qJNdC/CijPiKn2iPkYnt+dygPN1u0dZpC5z1qQhPL1DGPh8hHAnnAoTaOS/
 E1dugsZNcoiHTxmM5f1O+hrrQPbIfPBAL9yOUpJsF2TdQqVS5sucHohTVeU01FChaRncE+NEfU
 6fU=
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 07 Jun 2019 06:18:06 -0700
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
Subject: [PATCH 03/12] btrfs-progs: add new HMZONED feature flag
Date:   Fri,  7 Jun 2019 22:17:42 +0900
Message-Id: <20190607131751.5359-3-naohiro.aota@wdc.com>
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

With this feature enabled, a zoned block device aware btrfs allocates block
groups aligned to the device zones and always write in sequential zones at
the zone write pointer position.

Enabling this feature also force disable conversion from ext4 volumes.

Note: this flag can be moved to COMPAT_RO, so that older kernel can read
but not write zoned block devices formatted with btrfs.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 cmds-inspect-dump-super.c | 3 ++-
 ctree.h                   | 4 +++-
 fsfeatures.c              | 8 ++++++++
 fsfeatures.h              | 2 +-
 libbtrfsutil/btrfs.h      | 2 ++
 5 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/cmds-inspect-dump-super.c b/cmds-inspect-dump-super.c
index d62f0932556c..ff3c0aa262c8 100644
--- a/cmds-inspect-dump-super.c
+++ b/cmds-inspect-dump-super.c
@@ -229,7 +229,8 @@ static struct readable_flag_entry incompat_flags_array[] = {
 	DEF_INCOMPAT_FLAG_ENTRY(RAID56),
 	DEF_INCOMPAT_FLAG_ENTRY(SKINNY_METADATA),
 	DEF_INCOMPAT_FLAG_ENTRY(NO_HOLES),
-	DEF_INCOMPAT_FLAG_ENTRY(METADATA_UUID)
+	DEF_INCOMPAT_FLAG_ENTRY(METADATA_UUID),
+	DEF_INCOMPAT_FLAG_ENTRY(HMZONED)
 };
 static const int incompat_flags_num = sizeof(incompat_flags_array) /
 				      sizeof(struct readable_flag_entry);
diff --git a/ctree.h b/ctree.h
index 76f52b1c9b08..9f79686690e0 100644
--- a/ctree.h
+++ b/ctree.h
@@ -492,6 +492,7 @@ struct btrfs_super_block {
 #define BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA	(1ULL << 8)
 #define BTRFS_FEATURE_INCOMPAT_NO_HOLES		(1ULL << 9)
 #define BTRFS_FEATURE_INCOMPAT_METADATA_UUID    (1ULL << 10)
+#define BTRFS_FEATURE_INCOMPAT_HMZONED		(1ULL << 11)
 
 #define BTRFS_FEATURE_COMPAT_SUPP		0ULL
 
@@ -515,7 +516,8 @@ struct btrfs_super_block {
 	 BTRFS_FEATURE_INCOMPAT_MIXED_GROUPS |		\
 	 BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA |	\
 	 BTRFS_FEATURE_INCOMPAT_NO_HOLES |		\
-	 BTRFS_FEATURE_INCOMPAT_METADATA_UUID)
+	 BTRFS_FEATURE_INCOMPAT_METADATA_UUID |		\
+	 BTRFS_FEATURE_INCOMPAT_HMZONED)
 
 /*
  * A leaf is full of items. offset and size tell us where to find
diff --git a/fsfeatures.c b/fsfeatures.c
index 7f3ef03b8452..c4904ce8baf5 100644
--- a/fsfeatures.c
+++ b/fsfeatures.c
@@ -86,6 +86,14 @@ static const struct btrfs_fs_feature {
 		VERSION_TO_STRING2(4,0),
 		NULL, 0,
 		"no explicit hole extents for files" },
+#ifdef BTRFS_ZONED
+	{ "hmzoned", BTRFS_FEATURE_INCOMPAT_HMZONED,
+		"hmzoned",
+		NULL, 0,
+		NULL, 0,
+		NULL, 0,
+		"support Host-Managed Zoned devices" },
+#endif
 	/* Keep this one last */
 	{ "list-all", BTRFS_FEATURE_LIST_ALL, NULL }
 };
diff --git a/fsfeatures.h b/fsfeatures.h
index 3cc9452a3327..0918ee1aa113 100644
--- a/fsfeatures.h
+++ b/fsfeatures.h
@@ -25,7 +25,7 @@
 		| BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA)
 
 /*
- * Avoid multi-device features (RAID56) and mixed block groups
+ * Avoid multi-device features (RAID56), mixed block groups, and hmzoned device
  */
 #define BTRFS_CONVERT_ALLOWED_FEATURES				\
 	(BTRFS_FEATURE_INCOMPAT_MIXED_BACKREF			\
diff --git a/libbtrfsutil/btrfs.h b/libbtrfsutil/btrfs.h
index 944d50132456..5c415240f74c 100644
--- a/libbtrfsutil/btrfs.h
+++ b/libbtrfsutil/btrfs.h
@@ -268,6 +268,8 @@ struct btrfs_ioctl_fs_info_args {
 #define BTRFS_FEATURE_INCOMPAT_RAID56		(1ULL << 7)
 #define BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA	(1ULL << 8)
 #define BTRFS_FEATURE_INCOMPAT_NO_HOLES		(1ULL << 9)
+/* Missing */
+#define BTRFS_FEATURE_INCOMPAT_HMZONED		(1ULL << 11)
 
 struct btrfs_ioctl_feature_flags {
 	__u64 compat_flags;
-- 
2.21.0

