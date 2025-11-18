Return-Path: <linux-fsdevel+bounces-68986-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D68C6AB55
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 17:46:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 22166348800
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 16:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E9B359F99;
	Tue, 18 Nov 2025 16:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="RG8Xj9i5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11020133.outbound.protection.outlook.com [52.101.193.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468AD28312D;
	Tue, 18 Nov 2025 16:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763483652; cv=fail; b=ic5sICkb8PSbw/8bbhnGxvm89BMb1qgB7vNZioiRubvHgXtwL1LPaQGGerb/gsZgCMb+3BDEmUpEHfymB439sIMtatlraA2TLzD47ctH7B1ZcatTWQdjFWfYnJsluJlljOC8agh7e3sFZ2iZ4XnGPLEz+hTrIbqKN056rTp8o5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763483652; c=relaxed/simple;
	bh=DiLiGzq5gsU6XqpzKsSIHrnIlAYQTvzQfDKIyJP/UGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V6qIpYVRZNlcX5kRUgv4kshOzrgFloGJPNLOZ+oGuXxsHjZxKhy5QoQ2rviEPmv8hq7EQdBv1r1vMOdiNfNW0eAkp/XdOFBZEBr58u8By76bEDJkYrqVT1S36cR0FgMbahcc5ZppM0YqbalIy5EHbq+mcoPAegsbLxhusvVm6qQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=RG8Xj9i5; arc=fail smtp.client-ip=52.101.193.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=adDtdBmaH27zpku0bGMu8F0OAGNjyJp+Jn7i5zJS9p9Mlnn+mlBhCw1tYP+yrb8KJx02COjX7VWu4Dw9ZnXyZ5ILgDYunZSnNKXQ6PxqIFpmn1MiPVTTl/ny6OAq6wmbtQ/oGCTkZ7GpLhnEsQOdHNYIu8/vOOTjZI4axSeIDu/RHw0XlMPMQ0rtj8NuUlR5TjFCcz6VjQAG+sJZNVKez2G+jOxzkbCuNldtR+Hi0ImJvG7JG2utwyUsQTsM60qldLHBXC+vNpOMXz1M9pftSgpm2pLx2/uvCylX4wwpmujgkX5TLRjqEFMOTgcX2jPwyIUS2fLbMjxS1i9dolVsyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vIRU8SrvUoj6aeaLDg15MtHgnIRy/vue8F4kvuUn8SM=;
 b=oskb/FP7QdBue2o5wsj/wX7KL1XP8Go5uWuMbIPFkPQddEc2Yy+8U9UyFJ3UccALU836D+41Bn78/ICsrxrXdR/Utl5x+0USWZlw5FttqGJSbgRlTI1LoFAwNxkm6BJyM29/H5X+A+Jcbewf1/ot4eZVVunTXjoScQZXpZeDFRzEAESMpGcpYaNPxyuqMrZ698z+BkKvpQDm+j6HMB/rUDfFVs06g5Tk5+iH7saPQqRvIFEDXdLjEyZlGPunm11q1pIv22FWFhKIEO7PZvQfYUWPFICVEzx4INbGDDq7bVToPj9BmgjK7j5pfPXMnU/+DI7jY1IVlcpO0+JMaHiReg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vIRU8SrvUoj6aeaLDg15MtHgnIRy/vue8F4kvuUn8SM=;
 b=RG8Xj9i5FW+rtb9gfFlIoxkOtXgb6dmp0YSnJOONY09C6K/6uQxJ+ClNcz811HTxb7Q93Hz3tfWfdmJJ26W4jPJcXWFmqpfLonmYJThJnSxEpwOEgXkLi+Y42S+O8zcIRr8r3Lg4fpapPje3SFVtX7Qd6dcZys1lVtF0eEyH0P4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from SN6PR13MB2365.namprd13.prod.outlook.com (2603:10b6:805:5a::14)
 by MN2PR13MB4072.namprd13.prod.outlook.com (2603:10b6:208:26e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Tue, 18 Nov
 2025 16:34:06 +0000
Received: from SN6PR13MB2365.namprd13.prod.outlook.com
 ([fe80::9127:c65a:b5c5:a9d]) by SN6PR13MB2365.namprd13.prod.outlook.com
 ([fe80::9127:c65a:b5c5:a9d%7]) with mapi id 15.20.9343.009; Tue, 18 Nov 2025
 16:34:06 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	Trond Myklebust <trondmy@kernel.org>,
	Mike Snitzer <snitzer@kernel.org>
Subject: [PATCH v1 2/3] VFS: Prepare atomic_open() for dentry_create()
Date: Tue, 18 Nov 2025 11:33:58 -0500
Message-ID: <333c7f8940bd9b14a2311d5e65b6c007e8079966.1763483341.git.bcodding@hammerspace.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1763483341.git.bcodding@hammerspace.com>
References: <cover.1763483341.git.bcodding@hammerspace.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7P223CA0021.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:510:338::16) To SN6PR13MB2365.namprd13.prod.outlook.com
 (2603:10b6:805:5a::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR13MB2365:EE_|MN2PR13MB4072:EE_
X-MS-Office365-Filtering-Correlation-Id: ab4660cf-f50e-4889-700d-08de26c04af7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lji4CXdaoT02DDMYi9f7lgc0ElxumpnWPOjwo8wc8mLCWes/6dCm6ZHUA7Aw?=
 =?us-ascii?Q?DhTnnsCoPMoacTs9/S8uTIjnvEGNN/im2g5U5sOhVW1NX7dxdRo1nuwWlLnb?=
 =?us-ascii?Q?B5qfWN23QGp+KT2IZa+1qFApTZA8fTPkOzrShw7dGqAqqlKcWw3dusa5SdDZ?=
 =?us-ascii?Q?vmencKcHBNIT7qWr23ZFVQ1K1vTJajT8ayxFVsmBOrepuwZEAzrKCh2RAZd3?=
 =?us-ascii?Q?Ev2US49U0/A9ID+8Hqlr3l4EFEr7q3fdaWyDGjAP4ZTza+c8Pu1IB6OYSr/P?=
 =?us-ascii?Q?dnYyL1zmavOnLA87fIgz8YydRKCG2YgCG8f4Jiq3A+8xa/Nkb4zoFxDwes4t?=
 =?us-ascii?Q?FqHXa4TxzNPPan5x9VNu0TP0plQoeSF5JzXcclAKovOzFPZVSoAksfL+ymHE?=
 =?us-ascii?Q?3/Mcxj1yLrB6nXGypysoUzp6koKhYHT/nTRGVMCnoD3VVcTbPPxDQGitw5mX?=
 =?us-ascii?Q?xNXbrXUW156hXUYj15DmxxjLsziHXzE9/pvSReABDb3kkN1qrFnxN4BOHhhy?=
 =?us-ascii?Q?tw8jfEjo5lfcPKE7ophdIU+GjlLv9o/GamxOsawyXL+BGiI9BNkXfxj+kqM0?=
 =?us-ascii?Q?9xcGlqn6a6aCNhbGSFhBr4sygrCxGajSM9Zz+0VdFQOvQd97XhbBXqnsluAa?=
 =?us-ascii?Q?VxuN8xHk21UPTddhFZuXjfY7oiUtIuZ5tAP+aLOeMqYxh+9u1g+XHnG+QicA?=
 =?us-ascii?Q?pLb5CXc5zyAUQFxjTkGLpy7p/sNxp7MVGkFmNAm9CSlkATEqvNdXxK4JmIQn?=
 =?us-ascii?Q?2PPZhktHIEvt1IMmITh8/VhiCS8/6Krbi/uhCHZszL/pDbfe3zcvI3YZOdzu?=
 =?us-ascii?Q?Rkn9XLuAflQX7BQ57SAGxwRPexnePRkwZ9HXa5nTiohOsRpqpjTZumMkGQDW?=
 =?us-ascii?Q?0UlSG3+ZRw3FBqmURVnl6u8XGreZRMah7SS4xabCiEGcqCHdfIN3NVWS9lAK?=
 =?us-ascii?Q?oOu96sBeW/MAnEW1AeroZoFvK/s4pJdUaQkOhtx1yDep5TdxBjqd836NYFxT?=
 =?us-ascii?Q?fEf/F1rIT9faA2NOZdewSmsz1rrhk/qFTa436qCgQDkQn4p+WVr1UizdOqny?=
 =?us-ascii?Q?9Ege023rtAfumNmhGVq9A8N6NcKQ9mqR/VYs8SI2fw0PBmi+dMf7f5l72PX4?=
 =?us-ascii?Q?z3LuWwWsmCqWL3u6PWfUvDSEcEI9l+2oRjUVNqsBhH2jtXAL40n/DJhEH2Ei?=
 =?us-ascii?Q?Wn2ke36vE2wSkMn8Jv+V62KtifE6G91BGY9EZ29ILM54ihTB9KmsJS5owuFg?=
 =?us-ascii?Q?U0M+1hAyEThBk31fbnCue+ueP2ntaHgnFlV9ZUH7sRiyySou2/OgL5a0oI4v?=
 =?us-ascii?Q?oxYACroDm0mAj+CKfQUzzeJmK0G8aJc608hKpSMoIG1a1h6x+OfHv80JIy43?=
 =?us-ascii?Q?jNgKSHbFr6HYX/hjWqTpVZd7I/rqKQx668IZgjaiDsNjVxMhitCS4jadQYXx?=
 =?us-ascii?Q?PxFn7LazRt87JCEzJCfRh6LMNSyK+p+A?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR13MB2365.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wD+Ah0UkbHZohrSLEGHI87W+To7VYHKGvND7bkrDPTJ+SEh0YnRI7GE+sJ3o?=
 =?us-ascii?Q?skRosPMPWgGQu+NrhJdyXdLDyTDxkg/l7kYHxTWz7E13KSOk5HgDWzcBM9wG?=
 =?us-ascii?Q?zb65LrMjXqfXuun1e8zUL2kQz1vd2linFuhwrkfPX/6/0mmmEgoIPfMgcbX8?=
 =?us-ascii?Q?/jzEskwL+wV8FS47GdE2CJ5KMCPr0hPXkGCPyswBhkMxc4UQKeYsBcbSHZJq?=
 =?us-ascii?Q?ln6imz4g9tJAvZsg02lzXCsegQBY6+9UIByHARanLtC3+ZvitNK3bowosphr?=
 =?us-ascii?Q?m9k7v9LcgG+6OoeDv91P/I+ESVYjkJNxyJkkhEBtPzlSNOBeUXKwXTBmJUwS?=
 =?us-ascii?Q?LtLGj7Mri/cbiaikwZKlaYK0mLD+DHGSsiTpeVG6ZV/AjzfHBRz+qGupbbWi?=
 =?us-ascii?Q?TcQwhkBD3X2NfNPs89L32vAKZkTn+eHTUgmDsdVKoEnU6P2dHbpHsnrVV1Te?=
 =?us-ascii?Q?pkoonNYO4pyj23Ec/DZQGuqPzZ0XvPIAcdZpOte7ppDKyYB48uAWAHdII+ng?=
 =?us-ascii?Q?a9N0IR/EW2OgtfrrmEWMWGYNzKv+x/rv3UqzaEbVrBHor19wzdOPfP8cIMMn?=
 =?us-ascii?Q?HB9zQOKxCLkztwNnezBeVw49yrFVREYysk+kJ6Sc6jPXJDDYKdcOBIymkSuX?=
 =?us-ascii?Q?Vwhr9HJwBPQtBXVq8cXxhTWliQ97eA/tIf9Da/KvidnRp005fva4DSmR3k+f?=
 =?us-ascii?Q?sSDBrTRbL+9GJxwPoL3vu/lMQjFpmTFk7ZlUHBxrp8XkV0drDY52LrQnQWXJ?=
 =?us-ascii?Q?uoBSjLsqRqs238UV0mwL/MkaL9eFrUkixFuGDPaCDAlR49S1Gknkta8VG40D?=
 =?us-ascii?Q?fWhrzbiNFtHvmM2z83ZJDtMZ9gyS4pOzhIwWIB/QV91s+JMJ3l/TFbWWkW6k?=
 =?us-ascii?Q?3uzrL+srHMYiMOkdlHmeTCYIUzYA1CCf+ygFtHCA25ll3L+3QhwZXiOn+6SD?=
 =?us-ascii?Q?xQ+IjSLGYN1+57zBYuBVL6PFIAEedJDAB7s28sKt5XCxlBdccwHhqs/pYsJN?=
 =?us-ascii?Q?ChjDYAjJ62WqFR5rskpRMn7nsoWDlsvCTzR6R0a9Tw94u7ZUh50ygTlRQcc8?=
 =?us-ascii?Q?8DjH0ZyvK1xNqiDZS73Z/y38xHUSegS34xH5d5CgzUsred0PZbCc7NTZab6v?=
 =?us-ascii?Q?WjPJmG5Oqmr/EQ9dvLMouITXjHKTznmUQ6SbQlKMdSW7pnKE4mSMNkSXPLAj?=
 =?us-ascii?Q?NTnNekXhLzA5xZ7yO2j+8/8E7QiiZCU5WHyv3Dp5MvBYUANKrOBSflNOZBt+?=
 =?us-ascii?Q?hjRabS/WY2ilw10wQEttBGya1ZJARjZS7RK3YFOdiaSZiPdPAwuIUNIjhl9C?=
 =?us-ascii?Q?DFwH5CXH5dRTop/sIB/HWZTJQbXG/xde7mdeGt9usQ6Y3SunRLWKR6ah2WTA?=
 =?us-ascii?Q?Xu2gozKyvjH89cu5JAoKPOzqt9xOhvyLrifqDazqZb4KguHHmtvGhBNOJVSL?=
 =?us-ascii?Q?olhyKYj6GDa/bS8m8eyPgpB8q9d65gjS376/0ts0jUBedNmfxUNVXXMcb3H/?=
 =?us-ascii?Q?MU2n3anuxAKdJwOJLEGJEyFXBFPFP5H2Ah6x5wqbmVP2/wNp0d2FVMbIGVFx?=
 =?us-ascii?Q?5VbO7nvsJHXiB2LFRhLqdvgBpL0SeIYSQbm46n1KqCJHyK3WfKNUkOp7pNjX?=
 =?us-ascii?Q?lA=3D=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab4660cf-f50e-4889-700d-08de26c04af7
X-MS-Exchange-CrossTenant-AuthSource: SN6PR13MB2365.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 16:34:06.7942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ItqH55IKW0Jo/sq936bd/BiWDrNBSDX1fQuHxH+gs4k2x9hBBODgk/bM+MDtlNtJzeEL5IOkASfb2mXjnmw8bF5KYsMQmJLfjjwpR1iofxw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB4072

The next patch allows dentry_create() to call atomic_open(), but it does
not have fabricated nameidata.  Let atomic_open() take a path instead.

Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
---
 fs/namei.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index e2bfd2a73cba..9c0aad5bbff7 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3552,19 +3552,16 @@ static int may_o_create(struct mnt_idmap *idmap,
  *
  * Returns an error code otherwise.
  */
-static struct dentry *atomic_open(struct nameidata *nd, struct dentry *dentry,
+static struct dentry *atomic_open(const struct path *path, struct dentry *dentry,
 				  struct file *file,
 				  int open_flag, umode_t mode)
 {
 	struct dentry *const DENTRY_NOT_SET = (void *) -1UL;
-	struct inode *dir =  nd->path.dentry->d_inode;
+	struct inode *dir =  path->dentry->d_inode;
 	int error;
 
-	if (nd->flags & LOOKUP_DIRECTORY)
-		open_flag |= O_DIRECTORY;
-
 	file->f_path.dentry = DENTRY_NOT_SET;
-	file->f_path.mnt = nd->path.mnt;
+	file->f_path.mnt = path->mnt;
 	error = dir->i_op->atomic_open(dir, dentry, file,
 				       open_to_namei_flags(open_flag), mode);
 	d_lookup_done(dentry);
@@ -3676,7 +3673,10 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 	if (create_error)
 		open_flag &= ~O_CREAT;
 	if (dir_inode->i_op->atomic_open) {
-		dentry = atomic_open(nd, dentry, file, open_flag, mode);
+		if (nd->flags & LOOKUP_DIRECTORY)
+			open_flag |= O_DIRECTORY;
+
+		dentry = atomic_open(&nd->path, dentry, file, open_flag, mode);
 		if (unlikely(create_error) && dentry == ERR_PTR(-ENOENT))
 			dentry = ERR_PTR(create_error);
 		return dentry;
-- 
2.50.1


