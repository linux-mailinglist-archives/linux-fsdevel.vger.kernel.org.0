Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C15536D7740
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Apr 2023 10:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237459AbjDEIre (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Apr 2023 04:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236931AbjDEIrb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Apr 2023 04:47:31 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2134.outbound.protection.outlook.com [40.107.117.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB82D5275;
        Wed,  5 Apr 2023 01:47:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JOji/6uKSA1BmQuJ8wjUk2UTkIj8mlhLCoRcs9PVlSJap6SnHeMPXk4K/C2TiEALZKYhN5TyThyfulz2YlDPnqqknEWoLd7Zo384Gjo/elvF2K4XCVtPqeeu6yqATOgKvf77HozmceET+ampo+Hxh9UiHqnLQmF5/a7LG4tvRAe8aNLi/Tg1GwNinHtFRUtYzSqfE0kInTRFHR1KRbieuvVHmOaTunDowfWMnbBWRNIxK9oIWgncwrRAbxHvJPHObDW6n7wr2uUEsoHwG9dDRY6TUjLvk/60aPs1fAQ6KOZtYCGFcgSDHcIVfbzJi2ojLFQ4fHyb7i2zADVs2mQiGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=siBRLtO41J5tuA963VQpffU7mMDS7Va6mSU4SzVT/08=;
 b=CKFcy1EHSNW2zFCzhQAtWNeLur6XhmoRuK+QEpHN2tzNVGAkKRD3HCHeNU0a8bb8/Gp8zSSHyWpLh/RY+8oSuYGVszwV6lCXW5ChB5oDwD1x56gVRwuSKLuRSLZMwpLSB69y2aCwAFbsNxVrseMtbzd+207w4q72h0u+SCOsD+Pk4SDs3k2MdtDVPWissAkGQFBQEfGdsVpal1Y4OEt5ePvAKEBCB8ikOjALFxGmmRA5pBu5hxLvxz+vAdfQJ686XcuzQt8LUjIb3A8l0VE1QXkQEtPlk3gZv4pcjYiTqKIFfZZ4yBIVswrTfxv5lUyj1QFYA9iKtaKKP/wbYZ1M0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=siBRLtO41J5tuA963VQpffU7mMDS7Va6mSU4SzVT/08=;
 b=Dm8afFHs+JlFuB8X6uq2QmHPVe827kCdYF1p0ogKZKMh2byxo6lQ1JG98Xs29dvEaAyD+a4h4UH9aUbtIFWL3wy/3cZsVUs1XjMuZ0yTWFdUQd9QSOgto0tiMlPP2GFAPJ0Hu/QwJAimiDveVbEQbPJ3JNKLApnDKBm7pRdzcqtcdnuIwto6zSHB7kigwCJytOOi3g8wg7pn1bqBuOQdGvJkLwRrklGZ8z99TH7NwzwYcDkU6MEGHqv8LPcyewlk9xlvbGYlQse2xfVE3V3T619j5EYW4l6b9vhy4QRou9WoVG+Oh8cE532nP9VSzDHSckk1DjPAq2hnpjlbYszKUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYUPR06MB6121.apcprd06.prod.outlook.com (2603:1096:400:351::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Wed, 5 Apr
 2023 08:46:47 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::a3a1:af8e:be1e:437c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::a3a1:af8e:be1e:437c%6]) with mapi id 15.20.6254.028; Wed, 5 Apr 2023
 08:46:46 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH] exfat: add sysfs interface
Date:   Wed,  5 Apr 2023 16:46:34 +0800
Message-Id: <20230405084635.74680-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0069.apcprd02.prod.outlook.com
 (2603:1096:4:54::33) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYUPR06MB6121:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b637a52-ca8b-49b8-6725-08db35b24a07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RUex9lzN2zMLu8Vvkg4lVqidSujtrygSAAhxQ73jfEJPkygdtFzV5dKOQLgAfgaBsaxAK6iGu0ud+oZgkggXb7DzstKV958dEUAo7OXp6QjFtUg0NhW1W3j5wg0Mxjy3x4X1jP2Uz0dcA6O9qz7A5bXM9Mim/BCGkYOaFBv0Ivjh39/fCtaCb1ceadMB3dPzK23Hz4zEfPsP98kak1OGuhPQFjaigkTYTyziQORBJwlYprQQcap/n3UHQBK+3Ga8Q8zier+cSGPTbzixrcOUfE8b930AMU1IMY9bht953T0s840fzkk8/sF71LuaGL7lpfM6CevOHLjAjYgro+fOEWp94lejabTzlOAf9Jv9sIsBuvL36ZAWbtgMqGdfkWkBd/frrOWx4ZsuBAV3c9wjgIyId0qChCJYc7DqQn49bWdOo7e+seD89L6zyb/gUO0rIjjMWQfSy56/iVXMArc/6psB785afPk6Ilh1LX3GBi2IzbgawR/Qk3+brhVBezr3BzC03lpvtmJB5wqKefJvKjB5q9ho3k9tzj4sk89ky8A7z5DaYs4wymX3kdgHJViaFrCxV2ZCRtnDu/AO8yYS0z6mT1zVSr3skallWGwwYNHGZwUfbLotk+TgnQddMwci
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(376002)(136003)(366004)(346002)(451199021)(4326008)(6666004)(110136005)(52116002)(6486002)(316002)(66556008)(41300700001)(66946007)(66476007)(86362001)(36756003)(38100700002)(83380400001)(26005)(2616005)(6506007)(2906002)(5660300002)(1076003)(8936002)(6512007)(478600001)(38350700002)(186003)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oqJ4wCE1EuVYUnc2j2X7i+dyUTpzTo7um4LUiwEIwDpBUnXxKrgl4xt8OMvP?=
 =?us-ascii?Q?zxA2SLRFZcY8wj6evn7bXPyLKli1e4Nbrc199G4qErrC62N16FvBmKMzGsjR?=
 =?us-ascii?Q?pH1gY9uOW2sVuRTVgWFH8JeBW4odj+LD5G1dVQb1wqW0/onbJvPcJ6ScAK2P?=
 =?us-ascii?Q?IBsdhTuWMLa8DSZxWIh95d5mT8+YB2B2C9iBxiU5W8R8Sq/ogNDigBSonEct?=
 =?us-ascii?Q?uQHE7Cfj6yINHOjzwxR+OeKj8tXmFPikQ0KZ0T64IEI9YiQIeBFppmqckLnW?=
 =?us-ascii?Q?8ruTemvxaKc4BsY7PYz4B9hgcJKVoiWW3Di1aH1RRQ+LZx/1jbAPefBm3AFy?=
 =?us-ascii?Q?o9mcVe0m9mmAHkaPgenbg4BI/toNee50+rigWODdtP5+MNGd2tl8amwrIO24?=
 =?us-ascii?Q?KWXFcsRXPVlrJKOsIfGF642UV7tHXcBXZPI2w6Qd45H5f2/2QYpMG8K2lALp?=
 =?us-ascii?Q?cXgI838E0dxpzcIdJNWPzWo8miNCxx/EF/0SwAdeMaPpyEah53SvCBVLCR44?=
 =?us-ascii?Q?kbsTz5nE/VCPscMpXPgapDW+k3c78aMhqOnYa0Cs/oDJ8CcWrzl6hT72QNAn?=
 =?us-ascii?Q?07Or6o5DgQPIjfEgJwD+UUcwTwF6D12qME9pYlO3PEDZ1ZP2lVX0Qjh1iQJG?=
 =?us-ascii?Q?wn7upqWvrEp9NPxFOfSj6XQ0LzUaNAkxy1VOypH7pAuMv6Cts0ZPerBac7i7?=
 =?us-ascii?Q?khrwE3T/7piiXDjbtFlY9w6H1T/RGEdXZoETQ+TKjvjqMNkiX4IPAnRA/act?=
 =?us-ascii?Q?YY+UmNhvDIFyPPcoPGGoGcjWP4FXU0lBJwSa9hoidbdkaJ5Mc4s/RxJZ1zKI?=
 =?us-ascii?Q?llL2kC3FfqZZk5qkXv4HD12SvqiuG1o0OplXwZRI3RZKT/JQYGR7U4LktTnX?=
 =?us-ascii?Q?98wThk2SgTT7gTS1mj9WGrGnnJk6xpw+pVIboxpAQf+oFJ58glvR9rIhlDyl?=
 =?us-ascii?Q?8dD9Uk0pOnf8PF+1MSoxkBWmtyPTODgWXChH0C0i9srjrEokGL6w5hbkUAzz?=
 =?us-ascii?Q?DG61PQwUDMUzwfMcC1/CKaF17ieUHQ7oK/xqNRfc6x+V+y8WSzaZdb9HW6F5?=
 =?us-ascii?Q?08U3K3DiioKkK36QoIBD+6bBvzJ/oTaaUgYaf2GFEdmJMgt8boT/A5Siigj5?=
 =?us-ascii?Q?On/3Yvip1UbzKvK6D3kOGZYEXpqQg3HcFp/VMoF0ZWCUHpIh2tVAM8Al5s0/?=
 =?us-ascii?Q?+n9XF61HzUawbBhIrHyw9X0gPJEUM6Jr1eJqE2nrBVUmBB7/d1dPG4dzjsPI?=
 =?us-ascii?Q?X9hPurAvWGUCKWzJ46XiC9Ka0qhdnFjXufnNb5iTDnaAIf3vg/OcTjjd2/MX?=
 =?us-ascii?Q?biRxsqg4i+EF6oScwnzS1i8jK/MimjdjL85wUTlVw0jMKntEupTgkDOvaSkX?=
 =?us-ascii?Q?oUYmvSjDZ/e5/T7EMu4oTG69mTCJisxZPdKIKrYpOP1qOVfrMnP/YP6YolqB?=
 =?us-ascii?Q?7jVX2hi8cfZM24iedcuW0HHlAvwIjF7j3Bmn+Hfu2MJSvCQ6cZCgmppaz2uv?=
 =?us-ascii?Q?KsN6QwC+seoGQJkdbudA0DEmKB3Lh7VEua74aqNDsRr8JzVt2wgLKAWBax0E?=
 =?us-ascii?Q?I8eh6/bTnuF6dony3aPGruxUrbwxLjkTII8dvxua?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b637a52-ca8b-49b8-6725-08db35b24a07
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2023 08:46:46.8078
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XZdg9Wkr5fiBanyk1YzcHBw3iY5arm0BkthpfV6xbOgSu/9SR4BIdN0b2wixXt9ODMWOW6tPQqmcbWbWHhAjVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB6121
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add sysfs interface to configure exfat related parameters.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/exfat/Makefile   |   2 +-
 fs/exfat/dir.c      |   4 +-
 fs/exfat/exfat_fs.h |  13 +++++
 fs/exfat/super.c    |  23 +++++++-
 fs/exfat/sysfs.c    | 138 ++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 174 insertions(+), 6 deletions(-)
 create mode 100644 fs/exfat/sysfs.c

diff --git a/fs/exfat/Makefile b/fs/exfat/Makefile
index ed51926a4971..96bda5e5cca2 100644
--- a/fs/exfat/Makefile
+++ b/fs/exfat/Makefile
@@ -5,4 +5,4 @@
 obj-$(CONFIG_EXFAT_FS) += exfat.o
 
 exfat-y	:= inode.o namei.o dir.o super.o fatent.o cache.o nls.o misc.o \
-	   file.o balloc.o
+	   file.o balloc.o sysfs.o
diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
index 957574180a5e..efd2bd6e0567 100644
--- a/fs/exfat/dir.c
+++ b/fs/exfat/dir.c
@@ -711,15 +711,13 @@ static int exfat_find_location(struct super_block *sb, struct exfat_chain *p_dir
 	return 0;
 }
 
-#define EXFAT_MAX_RA_SIZE     (128*1024)
 static int exfat_dir_readahead(struct super_block *sb, sector_t sec)
 {
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
 	struct buffer_head *bh;
-	unsigned int max_ra_count = EXFAT_MAX_RA_SIZE >> sb->s_blocksize_bits;
 	unsigned int page_ra_count = PAGE_SIZE >> sb->s_blocksize_bits;
 	unsigned int adj_ra_count = max(sbi->sect_per_clus, page_ra_count);
-	unsigned int ra_count = min(adj_ra_count, max_ra_count);
+	unsigned int ra_count = min(adj_ra_count, sbi->max_dir_ra_count);
 
 	/* Read-ahead is not required */
 	if (sbi->sect_per_clus == 1)
diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index 729ada9e26e8..20638334e1ec 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -236,10 +236,13 @@ struct exfat_mount_options {
 	int time_offset; /* Offset of timestamps from UTC (in minutes) */
 };
 
+#define EXFAT_MAX_RA_SIZE     (128*1024)
+
 /*
  * EXFAT file system superblock in-memory data
  */
 struct exfat_sb_info {
+	struct super_block *sb; /* pointer to VFS super block */
 	unsigned long long num_sectors; /* num of sectors in volume */
 	unsigned int num_clusters; /* num of clusters in volume */
 	unsigned int cluster_size; /* cluster size in bytes */
@@ -275,6 +278,10 @@ struct exfat_sb_info {
 	struct hlist_head inode_hashtable[EXFAT_HASH_SIZE];
 
 	struct rcu_head rcu;
+
+	unsigned int max_dir_ra_count;
+	struct kobject s_kobj;
+	struct completion s_kobj_unregister;
 };
 
 #define EXFAT_CACHE_VALID	0
@@ -516,6 +523,12 @@ int exfat_write_inode(struct inode *inode, struct writeback_control *wbc);
 void exfat_evict_inode(struct inode *inode);
 int exfat_block_truncate_page(struct inode *inode, loff_t from);
 
+/* In sysfs.c */
+int exfat_sysfs_register(struct super_block *sb);
+void exfat_sysfs_unregister(struct super_block *sb);
+int __init exfat_sysfs_init(void);
+void exfat_sysfs_exit(void);
+
 /* exfat/nls.c */
 unsigned short exfat_toupper(struct super_block *sb, unsigned short a);
 int exfat_uniname_ncmp(struct super_block *sb, unsigned short *a,
diff --git a/fs/exfat/super.c b/fs/exfat/super.c
index 8c32460e031e..a29ce9561cc1 100644
--- a/fs/exfat/super.c
+++ b/fs/exfat/super.c
@@ -501,6 +501,7 @@ static int exfat_read_boot_sector(struct super_block *sb)
 	sbi->vol_flags_persistent = sbi->vol_flags & (VOLUME_DIRTY | MEDIA_FAILURE);
 	sbi->clu_srch_ptr = EXFAT_FIRST_CLUSTER;
 	sbi->used_clusters = EXFAT_CLUSTERS_UNTRACKED;
+	sbi->max_dir_ra_count = EXFAT_MAX_RA_SIZE >> sb->s_blocksize_bits;
 
 	/* check consistencies */
 	if ((u64)sbi->num_FAT_sectors << p_boot->sect_size_bits <
@@ -638,6 +639,7 @@ static int exfat_fill_super(struct super_block *sb, struct fs_context *fc)
 		opts->discard = 0;
 	}
 
+	sbi->sb = sb;
 	sb->s_flags |= SB_NODIRATIME;
 	sb->s_magic = EXFAT_SUPER_MAGIC;
 	sb->s_op = &exfat_sops;
@@ -697,6 +699,10 @@ static int exfat_fill_super(struct super_block *sb, struct fs_context *fc)
 		goto free_table;
 	}
 
+	err = exfat_sysfs_register(sb);
+	if (err)
+		goto put_inode;
+
 	return 0;
 
 put_inode:
@@ -773,12 +779,18 @@ static int exfat_init_fs_context(struct fs_context *fc)
 	return 0;
 }
 
+static void exfat_kill_super(struct super_block *sb)
+{
+	kill_block_super(sb);
+	exfat_sysfs_unregister(sb);
+}
+
 static struct file_system_type exfat_fs_type = {
 	.owner			= THIS_MODULE,
 	.name			= "exfat",
 	.init_fs_context	= exfat_init_fs_context,
 	.parameters		= exfat_parameters,
-	.kill_sb		= kill_block_super,
+	.kill_sb		= exfat_kill_super,
 	.fs_flags		= FS_REQUIRES_DEV,
 };
 
@@ -811,12 +823,18 @@ static int __init init_exfat_fs(void)
 		goto shutdown_cache;
 	}
 
-	err = register_filesystem(&exfat_fs_type);
+	err = exfat_sysfs_init();
 	if (err)
 		goto destroy_cache;
 
+	err = register_filesystem(&exfat_fs_type);
+	if (err)
+		goto sysfs_exit;
+
 	return 0;
 
+sysfs_exit:
+	exfat_sysfs_exit();
 destroy_cache:
 	kmem_cache_destroy(exfat_inode_cachep);
 shutdown_cache:
@@ -833,6 +851,7 @@ static void __exit exit_exfat_fs(void)
 	rcu_barrier();
 	kmem_cache_destroy(exfat_inode_cachep);
 	unregister_filesystem(&exfat_fs_type);
+	exfat_sysfs_exit();
 	exfat_cache_shutdown();
 }
 
diff --git a/fs/exfat/sysfs.c b/fs/exfat/sysfs.c
new file mode 100644
index 000000000000..d0a4dac3bc71
--- /dev/null
+++ b/fs/exfat/sysfs.c
@@ -0,0 +1,138 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2023 Vivo Communication Technology Co.,Ltd.
+ * Author: Yangtao Li <frank.li@vivo.com>
+ */
+
+#include <linux/fs.h>
+#include <linux/seq_file.h>
+#include <linux/blkdev.h>
+
+#include "exfat_raw.h"
+#include "exfat_fs.h"
+
+struct exfat_sysfs_attr {
+	struct attribute attr;
+	ssize_t (*show)(struct exfat_sb_info *sbi, char *buf);
+	ssize_t (*store)(struct exfat_sb_info *sbi, const char *buf,
+				size_t count);
+};
+
+#define EXFAT_SYSFS_ATTR_RW(name) \
+static struct exfat_sysfs_attr exfat_sysfs_attr_##name = __ATTR_RW(name)
+
+#define ATTR_LIST(name) (&exfat_sysfs_attr_##name.attr)
+
+static ssize_t exfat_sysfs_attr_show(struct kobject *kobj,
+			struct attribute *attr, char *buf)
+{
+	struct exfat_sb_info *sbi =
+		container_of(kobj, struct exfat_sb_info, s_kobj);
+	struct exfat_sysfs_attr *exfat_attr =
+		container_of(attr, struct exfat_sysfs_attr, attr);
+
+	return exfat_attr->show(sbi, buf);
+}
+
+static ssize_t exfat_sysfs_attr_store(struct kobject *kobj,
+			struct attribute *attr, const char *buf, size_t count)
+{
+	struct exfat_sb_info *sbi =
+		container_of(kobj, struct exfat_sb_info, s_kobj);
+	struct exfat_sysfs_attr *exfat_attr =
+		container_of(attr, struct exfat_sysfs_attr, attr);
+
+	return exfat_attr->store(sbi, buf, count);
+}
+
+static ssize_t max_dir_ra_count_show(struct exfat_sb_info *sbi, char *buf)
+{
+	return sysfs_emit(buf, "%u\n", sbi->max_dir_ra_count);
+}
+
+static ssize_t max_dir_ra_count_store(struct exfat_sb_info *sbi, const char *buf,
+					size_t count)
+{
+	struct super_block *sb = sbi->sb;
+	unsigned long t;
+	int ret;
+
+	ret = kstrtoul(skip_spaces(buf), 0, &t);
+	if (ret < 0)
+		return ret;
+
+	if (t > EXFAT_MAX_RA_SIZE >> sb->s_blocksize_bits)
+		return -EINVAL;
+
+	sbi->max_dir_ra_count = t;
+
+	return count;
+}
+EXFAT_SYSFS_ATTR_RW(max_dir_ra_count);
+
+static struct attribute *exfat_sysfs_attrs[] = {
+	ATTR_LIST(max_dir_ra_count),
+	NULL,
+};
+ATTRIBUTE_GROUPS(exfat_sysfs);
+
+static void exfat_sysfs_sb_release(struct kobject *kobj)
+{
+	struct exfat_sb_info *sbi =
+		container_of(kobj, struct exfat_sb_info, s_kobj);
+
+	complete(&sbi->s_kobj_unregister);
+}
+
+static const struct sysfs_ops exfat_sysfs_attr_ops = {
+	.show	= exfat_sysfs_attr_show,
+	.store	= exfat_sysfs_attr_store,
+};
+
+static const struct kobj_type exfat_sb_ktype = {
+	.default_groups = exfat_sysfs_groups,
+	.sysfs_ops	= &exfat_sysfs_attr_ops,
+	.release	= exfat_sysfs_sb_release,
+};
+
+static struct kobject *exfat_sysfs_root;
+
+int exfat_sysfs_register(struct super_block *sb)
+{
+	struct exfat_sb_info *sbi = EXFAT_SB(sb);
+	int ret;
+
+	init_completion(&sbi->s_kobj_unregister);
+	ret = kobject_init_and_add(&sbi->s_kobj, &exfat_sb_ktype,
+				   exfat_sysfs_root, "%s", sb->s_id);
+	if (ret) {
+		kobject_put(&sbi->s_kobj);
+		wait_for_completion(&sbi->s_kobj_unregister);
+		return ret;
+	}
+
+	return 0;
+}
+
+void exfat_sysfs_unregister(struct super_block *sb)
+{
+	struct exfat_sb_info *sbi = EXFAT_SB(sb);
+
+	kobject_put(&sbi->s_kobj);
+	wait_for_completion(&sbi->s_kobj_unregister);
+}
+
+int __init exfat_sysfs_init(void)
+{
+	exfat_sysfs_root = kobject_create_and_add("exfat", fs_kobj);
+	if (!exfat_sysfs_root)
+		return -ENOMEM;
+
+	return 0;
+}
+
+void exfat_sysfs_exit(void)
+{
+	kobject_put(exfat_sysfs_root);
+	exfat_sysfs_root = NULL;
+}
-- 
2.35.1

