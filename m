Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA2ED78DB1D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Aug 2023 20:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237633AbjH3Sid (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Aug 2023 14:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344179AbjH3SPp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Aug 2023 14:15:45 -0400
Received: from outbound-ip7a.ess.barracuda.com (outbound-ip7a.ess.barracuda.com [209.222.82.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10AC0132
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Aug 2023 11:15:35 -0700 (PDT)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176]) by mx-outbound12-16.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 30 Aug 2023 18:15:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AkaXen7/n8vAWbOMDuhtCSxXfhPRChUSC2vMgapd8d4o5QXQB4GRyEVbCzLCGg2uwfN2iKu2vkiPdqsuO98VcI2KJfgs/CcIADWDVGsO7/beTs/NbfpskH3CFTOWk1LeNTpHNtHc6fuwmJDeye0cArMti8vBoiOoOor3naLAYTG+//jSrGq1NGx+wedAUlqS5qHoKVvxYStwZPzqnB4tErT5pyi6/gpm803vihT8IplEZNNYEa0QcGxB+Exhy94i5mzE2PeftZOXte7BaoT78EklirwRh8pkw/aZJMTF0jRWf4ta2C8wXFz5BAzXcMiPnquCVhkCyYDd0zH9bX8oDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JH1IRVqwi5yaAlGJWt4Jx4JOmTtWYWQE7IEL5yxEOSw=;
 b=jxf2OlfMKQiXhiNKalq9Qc0292G1h1OLpCRTdPwjjGWS4L6yV2gJ4ExcOBt25q7qQoqaXuI1UZI3/wgkeo1tdHnzxke/ELc5gbqjemxxYQ3rROp6C93JcQLVvuRVnR55USJnvZLhI58e6fB7jbO0f8PRyIft6FwAP0xyfZ6FcASaFVeTF/pZqeKmj4u5IHvQCYhRqhGkdCoL9LpGh+OZ5QrO+wLwf0WLOevIHBg5uIeBgi0lrrAVeqsDnRwFkq7+P25rVjnVnL2mXap9CKfljUgwZouGIZdyZ0Z+pwd2JX9wBIPBKgS4uplh5R9kygOD75mscGqMlyBAyLSjTtq7Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JH1IRVqwi5yaAlGJWt4Jx4JOmTtWYWQE7IEL5yxEOSw=;
 b=VMvvXNbrPlP1xgZPeznqXxF2z58MT6sqaLqOLmaH11mO9RLC3qs4ttWcFFRb++LsZNambfeR8XYTBsbNgHI7IPGYScvrarKvP8mhZrawe5KRTqjI/nhsxlBvaS6oP2MG81ClnQ7ciJs6o2PdrDeUciYdau5ODui4VJJJCTx8gVs=
Received: from SJ0PR05CA0017.namprd05.prod.outlook.com (2603:10b6:a03:33b::22)
 by SN7PR19MB7733.namprd19.prod.outlook.com (2603:10b6:806:2eb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Wed, 30 Aug
 2023 18:15:26 +0000
Received: from MW2NAM04FT067.eop-NAM04.prod.protection.outlook.com
 (2603:10b6:a03:33b:cafe::9c) by SJ0PR05CA0017.outlook.office365.com
 (2603:10b6:a03:33b::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.18 via Frontend
 Transport; Wed, 30 Aug 2023 18:15:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mx01.datadirectnet.com; pr=C
Received: from uww-mx01.datadirectnet.com (50.222.100.11) by
 MW2NAM04FT067.mail.protection.outlook.com (10.13.31.174) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.21 via Frontend Transport; Wed, 30 Aug 2023 18:15:25 +0000
Received: from localhost (unknown [10.68.0.8])
        by uww-mx01.datadirectnet.com (Postfix) with ESMTP id 691F020C684D;
        Wed, 30 Aug 2023 12:16:31 -0600 (MDT)
From:   Bernd Schubert <bschubert@ddn.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     bernd.schubert@fastmail.fm, miklos@szeredi.hu, dsingh@ddn.com,
        Bernd Schubert <bschubert@ddn.com>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: file_remove_privs needs an exclusive lock
Date:   Wed, 30 Aug 2023 20:15:19 +0200
Message-Id: <20230830181519.2964941-3-bschubert@ddn.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230830181519.2964941-1-bschubert@ddn.com>
References: <20230830181519.2964941-1-bschubert@ddn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2NAM04FT067:EE_|SN7PR19MB7733:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: c490965c-38c2-402d-9eb4-08dba9851571
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9XojB2xQSsmwN2dWbmsdfCwcp7f3IRFK5dTrcUIeZyh6Z7rAN8K5Re3kmKOk2Sf6q2Ht3YEiCYvLIXReaAvAv6rkMfJr2qNwsSh20Z6k0VU3QNFMeEi4QFsJik4oV7Rzwf29yC5n3IFE11O0wZJE+d6FbalhLjacMn5uFv+ni2E/rtQTy+g1Up8LSkoXkI2Q+JpLAclbgw6VDSa56CSQjHkVkL/7V6zR8FvP2NM5DckSFU8omOcsEgayaLq+aBeJ8ZJJU9alM7yJFoSktPkpsm0kRWNHjYxV2Yy9P82WFDsnWqkKpGRgTstHrobMdL0TdAz25jzPHg0RJfZySJmOCf+8Tz7/yNi1STzMgWGF/s7+nHsXQITZeNSh7M2LXMZXAMiQEynhVOhxtfrNAz7GQjSUZHwcm7PHMYxUqQUGXaWmNNxOMyxOENgX33jElRwJzA945ZFN92aFNTmk3sJ6k2I7rnJuuTpssWgvZHMI36aHTQKzCWbtPXImgwiYMOet++QJS1wTxpCnx86uVipmGqAbCXsuPQKUjxv623RzyCS4gwVWqI4bER4kjVlTLb05alNt4dD8P+IzeiFD9Eyo+SitbYIhNNmWsab2jWKuhX/fXDdRVZGzDXHFobkgB3WmgxX7fmSwtVmVjPrmTomprDE8VcFbX7T/cMT1uEPIDd3WFe5E6+rUR8eSm7mWJQ8MyuKEM0lqiS/yKelgiXkEUrIrZ83k8mwi9r86fZlOFmNd90ig5B4u3GIrachRSi+e
X-Forefront-Antispam-Report: CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mx01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(346002)(396003)(39850400004)(186009)(1800799009)(451199024)(82310400011)(46966006)(36840700001)(36860700001)(41300700001)(26005)(356005)(81166007)(82740400003)(6666004)(86362001)(83380400001)(478600001)(47076005)(336012)(1076003)(6266002)(2616005)(40480700001)(70206006)(70586007)(6916009)(2906002)(54906003)(36756003)(316002)(5660300002)(4326008)(8936002)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?4eKDDvpAC7dG0DgGBo6jE5/RluR9IXqniC9Fr96kJQj1sAtugIlhOuaR8V7e?=
 =?us-ascii?Q?KCJb1GGnDVGmgTz/noPkQdYleh76GkB93YaNvZkLoJ3yF4j5Yi11Nr/ElOU5?=
 =?us-ascii?Q?Tz3r+Xcdh/4mPndF8OhFDplBoADf+XK5Xxt+gMUP6duRz++kIu5scajZxKGK?=
 =?us-ascii?Q?i7y3EnjiAocEFOn0JNZWNP0B83oAc9U4brdscin/Yyy3AmfQpZK59NxzcB1H?=
 =?us-ascii?Q?6IYaqp0jvyKTrYa+nCwRMRru5kTyQ/F8k8MbTbS0XbWJrcXLv6TPsxlARTig?=
 =?us-ascii?Q?fcGWzWvWWkgGHxFEH7jgLYoxybEnm6m14tVJjIrhdNLHffN4GI4htjIWg6e8?=
 =?us-ascii?Q?IGgqTlAEX8mLj1RfQ5PT31v9wEKSi5mT7JeaWoFt0zRY8J9OlQ8UT/EXZ4GO?=
 =?us-ascii?Q?opAAthk0E5kCzfXqW18csKMbLIP6o98sAbVAfeb0wckisNyy9RLLX8k0A6e9?=
 =?us-ascii?Q?k4lfiRrrXrhK+QiC4QCst0e4HPwUJndCRGnfUYdCurgRskUvISey36KOpB9n?=
 =?us-ascii?Q?tUzg17d/EaRUKL2zChoKS/QddOR2wTejPxr1Vr+uO2cLkdSZVylaZueK0DCh?=
 =?us-ascii?Q?l4rNN+B8Y6FJAR0anYbfUD+yfeDpSj4cSW0of+5heW37sLuODLpVkv4NdDAc?=
 =?us-ascii?Q?QV0iZLJi4mzadj4uWCavsKokfGnJkWYiSqitttO41LWBrkNB2RzPS8N5ub2Q?=
 =?us-ascii?Q?9BJ54fL27Ju9CPfB2CP3Kil3Se2WSA4JcE+Y4TYyG+738+jObX1LSbd+8/Pt?=
 =?us-ascii?Q?KrZ1rdb8FFRlt7rTMbe3Oe55kZPghPF9Ancd1jP72zjULeZLYtzdOfLJwbnF?=
 =?us-ascii?Q?Cs+ARS19UB9ZwYiDzZeznwZhvERztRE+jCcCL6/+tHVT5QGzqBpoJOiHfYaN?=
 =?us-ascii?Q?aka1AoA0muZQ+KZyAn4HSdqURcOyYXP7MfsxdskdEiEYRO/mrrvMmv5yi9cB?=
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 18:15:25.7631
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c490965c-38c2-402d-9eb4-08dba9851571
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mx01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM04FT067.eop-NAM04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR19MB7733
X-BESS-ID: 1693419330-103088-22887-1172-1
X-BESS-VER: 2019.1_20230830.1749
X-BESS-Apparent-Source-IP: 104.47.59.176
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKViYG5kZAVgZQ0DIt2TLNzMgo2T
        A5KS3NIC3RzDTVwsQwLTU5NdHMOM1AqTYWAOYOC11BAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.250495 [from 
        cloudscan23-177.us-east-2b.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
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
 fs/btrfs/file.c | 37 +++++++++++++++++++++++++++++--------
 1 file changed, 29 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index fd03e689a6be..89c869ab131d 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1125,7 +1125,7 @@ static void update_time_for_write(struct inode *inode)
 }
 
 static int btrfs_write_check(struct kiocb *iocb, struct iov_iter *from,
-			     size_t count)
+			     size_t count, unsigned int *ilock_flags)
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
+		if (ilock_flags && *ilock_flags & BTRFS_ILOCK_SHARED) {
+			*ilock_flags &= ~BTRFS_ILOCK_SHARED;
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
 
@@ -1462,13 +1470,16 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 	ssize_t err;
 	unsigned int ilock_flags = 0;
 	struct iomap_dio *dio;
+	bool has_shared_lock;
 
 	if (iocb->ki_flags & IOCB_NOWAIT)
 		ilock_flags |= BTRFS_ILOCK_TRY;
 
 	/* If the write DIO is within EOF, use a shared lock */
-	if (iocb->ki_pos + iov_iter_count(from) <= i_size_read(inode))
+	if (iocb->ki_pos + iov_iter_count(from) <= i_size_read(inode)) {
 		ilock_flags |= BTRFS_ILOCK_SHARED;
+		has_shared_lock = true;
+	}
 
 relock:
 	err = btrfs_inode_lock(BTRFS_I(inode), ilock_flags);
@@ -1481,8 +1492,17 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 		return err;
 	}
 
-	err = btrfs_write_check(iocb, from, err);
+	/* might uset BTRFS_ILOCK_SHARED */
+	err = btrfs_write_check(iocb, from, err, &ilock_flags);
 	if (err < 0) {
+		if (err == -EAGAIN && has_shared_lock &&
+		    !(ilock_flags & BTRFS_ILOCK_SHARED)) {
+			btrfs_inode_unlock(BTRFS_I(inode),
+					   ilock_flags | BTRFS_ILOCK_SHARED);
+			has_shared_lock = false;
+			goto relock;
+		}
+
 		btrfs_inode_unlock(BTRFS_I(inode), ilock_flags);
 		goto out;
 	}
@@ -1496,6 +1516,7 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 	    pos + iov_iter_count(from) > i_size_read(inode)) {
 		btrfs_inode_unlock(BTRFS_I(inode), ilock_flags);
 		ilock_flags &= ~BTRFS_ILOCK_SHARED;
+		has_shared_lock = false;
 		goto relock;
 	}
 
@@ -1632,7 +1653,7 @@ static ssize_t btrfs_encoded_write(struct kiocb *iocb, struct iov_iter *from,
 	if (ret || encoded->len == 0)
 		goto out;
 
-	ret = btrfs_write_check(iocb, from, encoded->len);
+	ret = btrfs_write_check(iocb, from, encoded->len, NULL);
 	if (ret < 0)
 		goto out;
 
-- 
2.39.2

