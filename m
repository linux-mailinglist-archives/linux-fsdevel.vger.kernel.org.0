Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE1278EBEF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Aug 2023 13:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346115AbjHaLZD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Aug 2023 07:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346146AbjHaLZB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Aug 2023 07:25:01 -0400
Received: from outbound-ip7a.ess.barracuda.com (outbound-ip7a.ess.barracuda.com [209.222.82.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1269CF9;
        Thu, 31 Aug 2023 04:24:52 -0700 (PDT)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169]) by mx-outbound14-193.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 31 Aug 2023 11:24:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AAzqXy7ZU64JiVs4TbJ8PYgawtQm/TSeDVNEtFDVmSeiINShv1Sa0+mZi0GAzr8Kycv/WznCfqxMlvN6n6jcnSI7sX0IzlavfT60cMPovuoPQUI0ymUXbU0h8gSaMpH+wiUWz0eHqp2lQ0MDvbF6BHfRiyFJzHd4isC3IeO6aBWfgVXmXo0A/sff4Ie0ycJ3ie9WR4IJsPPn+kDwP3Yx7bvi28f0ip9K06nd7fhOgacI8/sUUuMu66NwcjcnCeIvx9CIo6ULIJBeWSifl2FvTtF+tQKg6fxji3Xek3+2bFpLW2AErDGjuXEkT9Lnl/oTfxKXEmQuy27GNowYJRBsWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=grXBLzh9zXZ3cQxGsX42W2Ce76KaovRSKCsg11QrvnU=;
 b=G01G4ZS/hHeV/s+bg2Q3NuRe7aeE/otKKysmsSP/EmZVajEWKDeqBY0SEEVHD703eKS7+c08qH+TqMjtH76ZiiurIAJbi4S6kHfeXmjy8HCuz+i9LUogOlQnyC8LFwyI75BiSUgfS+uPTW9L6pkjIKs+LdkVlVI007SiO7UuWwb0OtlX7nW0UBFZiwqy6YgUKRQbkD9ulnD9QddntJORaehc3SXvMszlm1gC6Gt/OgE0JZRV0DhwMD5MjV0qKcPMP58BGVv9EN1OcNXqq+jihnJKRLo3wfoEeCpNXb/c//x4zyFF0Y6b+tN/OCP2Le2AWhjr6ZjG/lSBH2a2ncnhzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=grXBLzh9zXZ3cQxGsX42W2Ce76KaovRSKCsg11QrvnU=;
 b=NqAciESZh60FgSk2+o4dsMFNIlglmHJ4Pdi9+gTIF/pd97BAuc1K0q5tta+kQuLhlI3GUg+cxFyb110KqM6H3HfkyLuRiEh/MP5SgK4mjbJZlNznQ5V3YotfHRK4XPQS2M3A09X33Nf+3iDU0pIWArIxUyfcFwjDd6rs+XmM4rA=
Received: from SJ0PR05CA0093.namprd05.prod.outlook.com (2603:10b6:a03:334::8)
 by DM4PR19MB5953.namprd19.prod.outlook.com (2603:10b6:8:69::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.21; Thu, 31 Aug
 2023 11:24:41 +0000
Received: from MW2NAM04FT014.eop-NAM04.prod.protection.outlook.com
 (2603:10b6:a03:334:cafe::71) by SJ0PR05CA0093.outlook.office365.com
 (2603:10b6:a03:334::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.18 via Frontend
 Transport; Thu, 31 Aug 2023 11:24:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mx01.datadirectnet.com; pr=C
Received: from uww-mx01.datadirectnet.com (50.222.100.11) by
 MW2NAM04FT014.mail.protection.outlook.com (10.13.31.34) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.21 via Frontend Transport; Thu, 31 Aug 2023 11:24:40 +0000
Received: from localhost (unknown [10.68.0.8])
        by uww-mx01.datadirectnet.com (Postfix) with ESMTP id DA70420C684B;
        Thu, 31 Aug 2023 05:25:45 -0600 (MDT)
From:   Bernd Schubert <bschubert@ddn.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     bernd.schubert@fastmail.fm, miklos@szeredi.hu, dsingh@ddn.com,
        Bernd Schubert <bschubert@ddn.com>,
        Christoph Hellwig <hch@infradead.org>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: file_remove_privs needs an exclusive lock
Date:   Thu, 31 Aug 2023 13:24:31 +0200
Message-Id: <20230831112431.2998368-3-bschubert@ddn.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230831112431.2998368-1-bschubert@ddn.com>
References: <20230831112431.2998368-1-bschubert@ddn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2NAM04FT014:EE_|DM4PR19MB5953:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: afa8bdd4-b64e-4ab9-27d8-08dbaa14ddfc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m/aW3EWlkYA1mpH72Pqy8+qCh/REV4YuNRqOXGMyTdEWgJwPcHUy2mI73k1vJLlv7SFztggV2fuC9d6oWX6DaMKD7vPeUlXyVnt3b9wszWyDtlEReFRKlWdlOf+JWCfeNmxojTHJNKux2jLthqLpk7S8JzXEeSntWD3Po6Ar2/l5/1mafe0IwBOb94piwUt5O3HfWY//URsTC/CXn+lekM5Z5lW1p9vtSsLa1c57Ifish9WqAmk/QVXJ95d5gaUza4l91Iyg66Oh5M9pesEf+FtBQsRZdRhiIDM7T9kZSnRGNmyPNDZNjdxWMC9pFXYOUciFQKD/s6fNi11ofZA1i6vNPYoUoQC6BPQjeW4Ky4017VgIXyeLJn3LSH6hPhkTkXBHNqUoiMX2etX31Xd0RMC3d1dWotVM1nXslfhPUlnpGFpZU9eMk1QaBopZAIimzAZRUNom+S7EsmvZBu65cHSrFef0NTQetkDs/EgzRCN0m79Ae/J7fGuP6yYaadMbBIgvOHRXSFWr1ZFezdxnuwhCKHR94HTJ9YMXn1HM4L92LuYCOL9DVro0DOMP42zQ3uUhFfmNHbIVlY5BcX8ZnygMoHWpc+i4VB74KyAKl6Gl3f7gwkbzmxbq5wUeV5sl5dYusPgXEYzcZL4GschF+zS6k+9cUALSyEhu67HE0nw4ys23OXiVei1xnwAv9CeWOfAKUcwan86vI5b7M6wTRuIeE0Fx4Sx+y+cu31wIRsA+8jPaNgk4gjox38TFD1o7
X-Forefront-Antispam-Report: CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mx01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(396003)(346002)(39850400004)(82310400011)(451199024)(1800799009)(186009)(46966006)(36840700001)(6666004)(478600001)(83380400001)(2616005)(1076003)(2906002)(336012)(6266002)(26005)(316002)(6916009)(54906003)(41300700001)(70206006)(70586007)(5660300002)(4326008)(8676002)(8936002)(36756003)(40480700001)(47076005)(36860700001)(86362001)(81166007)(82740400003)(356005)(36900700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?vuBmr56GwV8lCT9c8XAMzzXd/+a9Bf8nfu1YpntsVdy1EftFyu2heJbtks05?=
 =?us-ascii?Q?cXe11xXK/ngCnZP0CcTyQ6j2d4Wq3tpfaa5vUOzxWnqM4KIk1FjS4+1naqEq?=
 =?us-ascii?Q?aXpgSv9qurLqkhOAp+T6UmEFfAuwNLk8F8YCMkfzjgt7EGQSbev9HhHdEH7y?=
 =?us-ascii?Q?a/ml2nsqxgVwhf4zfe03IwghAYCIJssuwHxftBwnWu92tpBQtzfnStpXJj3x?=
 =?us-ascii?Q?BB1uCq7MfHBLgDeMUFhSdA7ZGA/2of290qz5h8YqR2Pcti2ZR8G3ymgF5slj?=
 =?us-ascii?Q?SURBqQsUMGe9NuxrBnnRLbjlWbd8TrShMUt1lRwh4Klk+fhLXl9w2EkRsSAW?=
 =?us-ascii?Q?edhoPag426hDrjuE7FqelQBjwov2IcNWh4yrnF+a5m9M5dane/IWz5LJVpt8?=
 =?us-ascii?Q?h80lzgCnErvxBrSY55OpY781V51MAELLxjnDAapLMt/F+9d2vtF5IoPTstHQ?=
 =?us-ascii?Q?m6AY1d59Sc0gAW8lAcdxsP+byv1XfX66Wcx4XxZIVI4kUOxj0bMhlJ7el29p?=
 =?us-ascii?Q?fBxVAUUWNuzkxRVJsOmUXbduVLn6H4drSaeu+xtYf7zVE9fWSs+t0ggVB4ln?=
 =?us-ascii?Q?LxwyY/zEfir9+3vL/BaHdI/OqZlcdyoSYcJescupajnXlyFp1lrl93+d7aaJ?=
 =?us-ascii?Q?q+Tcg7CZABaw/fCqKfeuJlhaaTZI6hoDUkLQe8I8yRrQQL8YOwUUJzN6mxpR?=
 =?us-ascii?Q?hM4ZKyE67v6UvRhRxUNGbrwn7b7NNtnxz/31SAaiiez6StvuFU8yskdvJjX7?=
 =?us-ascii?Q?KuOEV3gFNp3qVNr5euHmGD1GfTfd4wGtpQBAYn0mSu+99Vucxp5j2so5mRae?=
 =?us-ascii?Q?03z5lvoO5LwSS0op30Mxlr/D+WejQPt2lvCp5Pll6dwmxmKOph2uXXPJSF4n?=
 =?us-ascii?Q?Xwjd1OXuijr/UICnQd8yeZYNts3AmEH02Wts0Z44zsNURK255bb7MSB7hhMK?=
 =?us-ascii?Q?S0O37INutgoWMrfpjCFuQ4dvFvbGELZj48R2FVuBzY4=3D?=
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 11:24:40.2477
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: afa8bdd4-b64e-4ab9-27d8-08dbaa14ddfc
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mx01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM04FT014.eop-NAM04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR19MB5953
X-BESS-ID: 1693481085-103777-12336-5089-1
X-BESS-VER: 2019.1_20230830.2058
X-BESS-Apparent-Source-IP: 104.47.58.169
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKViZGhmZAVgZQ0MzcwMQizcLCyC
        TF3DLNIMXIxNLIMsXIPNUw0dwg1SxNqTYWACps33JBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.250513 [from 
        cloudscan15-105.us-east-2a.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

file_remove_privs might call into notify_change(), which
requires to hold an exclusive lock.
In order to keep the shared lock for most IOs it now first
checks if privilege changes are needed, then switches to
the exclusive lock, rechecks and only then calls file_remove_privs.
This makes usage of the new exported function
file_needs_remove_privs().

The file_remove_privs code path is not optimized, under the
assumption that it would be a rare call (file_remove_privs
calls file_needs_remove_privs a 2nd time).

Fixes: e9adabb9712e ("btrfs: use shared lock for direct writes within EOF")
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Goldwyn Rodrigues <rgoldwyn@suse.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Dharmendra Singh <dsingh@ddn.com>
Cc: Chris Mason <clm@fb.com>
Cc: Josef Bacik <josef@toxicpanda.com>
Cc: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
 fs/btrfs/file.c | 41 ++++++++++++++++++++++++++++++++---------
 1 file changed, 32 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index fd03e689a6be..3162ec245d57 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1125,7 +1125,7 @@ static void update_time_for_write(struct inode *inode)
 }
 
 static int btrfs_write_check(struct kiocb *iocb, struct iov_iter *from,
-			     size_t count)
+			     size_t count, bool *shared_lock)
 {
 	struct file *file = iocb->ki_filp;
 	struct inode *inode = file_inode(file);
@@ -1145,9 +1145,17 @@ static int btrfs_write_check(struct kiocb *iocb, struct iov_iter *from,
 	    !(BTRFS_I(inode)->flags & (BTRFS_INODE_NODATACOW | BTRFS_INODE_PREALLOC)))
 		return -EAGAIN;
 
-	ret = file_remove_privs(file);
-	if (ret)
-		return ret;
+	ret = file_needs_remove_privs(file);
+	if (ret) {
+		if (shared_lock && *shared_lock) {
+			*shared_lock = false;
+			return -EAGAIN;
+		}
+
+		ret = file_remove_privs(file);
+		if (ret)
+			return ret;
+	}
 
 	/*
 	 * We reserve space for updating the inode when we reserve space for the
@@ -1204,7 +1212,7 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 	if (ret <= 0)
 		goto out;
 
-	ret = btrfs_write_check(iocb, i, ret);
+	ret = btrfs_write_check(iocb, i, ret, NULL);
 	if (ret < 0)
 		goto out;
 
@@ -1462,13 +1470,20 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 	ssize_t err;
 	unsigned int ilock_flags = 0;
 	struct iomap_dio *dio;
+	bool shared_lock;
 
 	if (iocb->ki_flags & IOCB_NOWAIT)
 		ilock_flags |= BTRFS_ILOCK_TRY;
 
-	/* If the write DIO is within EOF, use a shared lock */
-	if (iocb->ki_pos + iov_iter_count(from) <= i_size_read(inode))
+	/* If the write DIO is within EOF, use a shared lock and also only
+	 * if security bits will likely not be dropped. Either will need
+	 * to be rechecked after the lock was acquired.
+	 */
+	if (iocb->ki_pos + iov_iter_count(from) <= i_size_read(inode) &&
+	    IS_NOSEC(inode)) {
 		ilock_flags |= BTRFS_ILOCK_SHARED;
+		shared_lock = true;
+	}
 
 relock:
 	err = btrfs_inode_lock(BTRFS_I(inode), ilock_flags);
@@ -1481,8 +1496,15 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 		return err;
 	}
 
-	err = btrfs_write_check(iocb, from, err);
+	err = btrfs_write_check(iocb, from, err, &shared_lock);
 	if (err < 0) {
+		if (err == -EAGAIN && ilock_flags & BTRFS_ILOCK_SHARED &&
+		    !shared_lock) {
+			btrfs_inode_unlock(BTRFS_I(inode), ilock_flags);
+			ilock_flags &= ~BTRFS_ILOCK_SHARED;
+			goto relock;
+		}
+
 		btrfs_inode_unlock(BTRFS_I(inode), ilock_flags);
 		goto out;
 	}
@@ -1496,6 +1518,7 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 	    pos + iov_iter_count(from) > i_size_read(inode)) {
 		btrfs_inode_unlock(BTRFS_I(inode), ilock_flags);
 		ilock_flags &= ~BTRFS_ILOCK_SHARED;
+		shared_lock = false;
 		goto relock;
 	}
 
@@ -1632,7 +1655,7 @@ static ssize_t btrfs_encoded_write(struct kiocb *iocb, struct iov_iter *from,
 	if (ret || encoded->len == 0)
 		goto out;
 
-	ret = btrfs_write_check(iocb, from, encoded->len);
+	ret = btrfs_write_check(iocb, from, encoded->len, NULL);
 	if (ret < 0)
 		goto out;
 
-- 
2.39.2

