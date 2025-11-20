Return-Path: <linux-fsdevel+bounces-69249-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BC780C754B4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 17:18:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 973454F23FD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 15:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E609035BDD1;
	Thu, 20 Nov 2025 15:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="cVcZJsk/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11021073.outbound.protection.outlook.com [52.101.52.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EFCD3587C6;
	Thu, 20 Nov 2025 15:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763654285; cv=fail; b=IYXUwFyg3BA4Gphs7YNDWtVgQ2XmHp/ShP4qKSymjNNliQsgZynu1NZumF0wdP/jIdhSmx6wgWQKbyn2VW4kCNuUnPk97V6B1rPFwlcHVH8K/YeRzMWoai5ZVISH7/zzZomq/uxrAV+hlbffPYqf1DJn4MZ7z7WtN1n+KUlPLdo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763654285; c=relaxed/simple;
	bh=8WKoqqbKEqL65hTaT2wxT7FS6o9dZbS1kBSShrsJfJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pxMz34xAmxKoQEn4WK8sIuIr8PgB2PsDe3AkPlHbvnDGo93/A57HpCl0Y+FYx5IQv8y11GOduWIlMFsVluYapzVHCgljdFGuUoGshnrDN0+Oul1pZEMO8bCm/irBTWyxV+OCKCuQLbRzffOJBep8mkvEuaIig1xQjmPCgW4hUvw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=cVcZJsk/; arc=fail smtp.client-ip=52.101.52.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A1s8VjYT3OG3VXsfECVn3X+leXrAijeRrovb0j3ur/nOW9PXLETSoH0TrzKc55iEdam0jo7/5NkvAtWYitlvaOoKPNPi+v+GOrKYLf2r0vjU1i512UTTJpcoO+/3SyEttnGxAP9fTT2igM55UsL9YIsoJHY+OYdlTBRwA9GcPhUCOCrHTFRnzD+wk6aGYPb9nOqdtmnbjqXvnfF+OfD4OD8IWhNrv03PVBIoCBt4qJG/8SAjE1viq25PTYii5iOoDM3D5S5K027jh2dg/wqEpIF+Q2r0VC4rwgJsVNYb+AhSEPF79sas6mhiBFXf8i3EYdBhvw7Tcj7y9hyFHi32Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lk5m7dlrdqolYeHaIZhuZHynpUFfatlrJ9qa2t2yeyA=;
 b=wj2m0e6rMQa9dOeU8i8bQTZ0si0nsuFcXPTd//+ioD4GrE4de/EMzTCF4UGnUVRKKpeLP/lMDSOTx+ExUoFMTThqdy5ZHzLSLMi0cUukPL/hNWG8FHI+E5EJ0vP8yo95Luc4OBNrqH57P6RtjsaDBSpRG1/D1Eso9M2aGjG2A+FgL6ahU+KrX8W1zci8sZK0sDttswXbgtQfh6sznCploC5VEHBxhxV1zdoADUlS0ENfyNWQeIxJbpFAD76LjtIUZp+hGcGAMiyeUoJDHH+XUBGB/ZsedojKHoDLssehzG6phcLT3FfRtdtWmUFiRvC01xGhKn8U1llYAX/Edu0c9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lk5m7dlrdqolYeHaIZhuZHynpUFfatlrJ9qa2t2yeyA=;
 b=cVcZJsk/Y4MTNOyVUIA8s0ZrJTpxv0yTECSthicj9dxFc40MeEXatfITpngmAcE7sDCepD4pTtqT86ys3q4SYAqEIiLNF4cNz9ZbaXAItHWpCuTLpEQkdCixexZV6YmgPsrStVwW9js2/PcI5MNHwaOaXPJR+7in5idXqI4cZos=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from SN6PR13MB2365.namprd13.prod.outlook.com (2603:10b6:805:5a::14)
 by SA5PR13MB7587.namprd13.prod.outlook.com (2603:10b6:806:47d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Thu, 20 Nov
 2025 15:57:57 +0000
Received: from SN6PR13MB2365.namprd13.prod.outlook.com
 ([fe80::9127:c65a:b5c5:a9d]) by SN6PR13MB2365.namprd13.prod.outlook.com
 ([fe80::9127:c65a:b5c5:a9d%7]) with mapi id 15.20.9343.009; Thu, 20 Nov 2025
 15:57:57 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Mike Snitzer <snitzer@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH v2 3/3] VFS/knfsd: Teach dentry_create() to use atomic_open()
Date: Thu, 20 Nov 2025 10:57:48 -0500
Message-ID: <d7405b554e3b12a037dbce4b9db29394d87183d1.1763653605.git.bcodding@hammerspace.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1763653605.git.bcodding@hammerspace.com>
References: <cover.1763653605.git.bcodding@hammerspace.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH1PEPF000132F7.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:518:1::3c) To SN6PR13MB2365.namprd13.prod.outlook.com
 (2603:10b6:805:5a::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR13MB2365:EE_|SA5PR13MB7587:EE_
X-MS-Office365-Filtering-Correlation-Id: 0832e297-3f48-4ef2-ce58-08de284d92e1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?foHYLlp2zrIE0fvdgKfVQt9NIXrYl6CcAQGX9c7xX7H/j0OCMLiYJRYG1PQs?=
 =?us-ascii?Q?29Zuu7KF/5HRsRKKFNXh20evLRKheEsL4i9O07HMzDUOhPEZy8LqBgy0ZqnU?=
 =?us-ascii?Q?pdzJJu3992+hAoIPjC7GefcJ6H2HTxlqt0iNOXgUEp4mY1v3kCNqmLI+T6/v?=
 =?us-ascii?Q?Gl2ZgI0lNULVdKSlDnlI7KCqPeleQ5pu1ik5WR/PDW3duzr3CxopruGFUoTy?=
 =?us-ascii?Q?yyJkXddyVmAOSApI+n7h6ek6h0X2N609RL0ttgcCIwlvKvLo5p1YHi5n+lMu?=
 =?us-ascii?Q?5UKJ7v3vmzW5TwtJln9S1bUfmmdPU4EM/WDCQSVshq6aB7Yct9V4WMCKJlNW?=
 =?us-ascii?Q?uWvjIuq8pJsglC9dC+7ulHXLlt9azENIs4jFwF7r8wJkSagExARncxU1Y5Gn?=
 =?us-ascii?Q?Lsn4tWV5odwKw0g1Io4mlHoNsyvsV976NZPl5mTGDdHiwjcFFN1VHpzDAPWi?=
 =?us-ascii?Q?W866n2p4A6VQ5DD6ckt1jd1XCfNGqztBXinA0fLlGy8Tmd2zc/IRJDfEJ6zA?=
 =?us-ascii?Q?E61dFefb3InyG+wzVyd4+OKC/dtMqO02MHE9i6h3gC2bIu4FbeC0rRfCUw0a?=
 =?us-ascii?Q?TtGHs6yb8dmir8+1/8N5/WgsSw5hM0c0rejDMVjle+LZjyrPSkDloOjIowC6?=
 =?us-ascii?Q?Kg4rwrA4rxdzVYl+cQVydZabZWPbnhJv5Sy5dai4Xkg712gBgz/UE1miXdyq?=
 =?us-ascii?Q?Y7bnfXIlTERgbiWW9HdAghASKpOW+9kImnpYkXf511pzpGBB4D5k5sBI2dQF?=
 =?us-ascii?Q?uDzel9jOF6a79KYDf51G18h15g3EM28Fuy9HETPvyQ0nt01UEUZ34maMzSLy?=
 =?us-ascii?Q?Tfes/BQTGznWZen4466CW5hZ1C5dzD6jR5YNbu9YB4AyS/FO2Dqfv9NqVgxH?=
 =?us-ascii?Q?dLda8NCrqAuuDjv72wO3haLj+k3Parkf1FuQwIpRCE4nLcO6KGnJjUO71yF8?=
 =?us-ascii?Q?bdNwz+mIv5QNZVLsmTGn7gcOzXFIf8ebG72qK+vPSL3yVV1VfrSEfOTm14dt?=
 =?us-ascii?Q?kk6e4azlbxV52Y5lXFx1r6NcQbQJlDS8Z/kKiR6oWOcDr+ABuKgLYX5ASSws?=
 =?us-ascii?Q?vUvgnxxQWXm1PbrAg07yZOFIJJ+OuIVMOO++t5MVePbHVe1dQT+1NRDIY/LJ?=
 =?us-ascii?Q?rx9hqn59Oldl3b0175KaiGAdoiU6CyXZQiHp73I6gF+HG84d/uCBgKc5AWFc?=
 =?us-ascii?Q?O7dRv3zbMpIuNzA9KZLBI2Lo21YYi2s0tidicgb8qOD3/HzlLwrWdweZT+3I?=
 =?us-ascii?Q?NI5NtncCqsO2wLR+q2jYD+B2lfZgroMNl/B1yRhcCKNN00iibbZOwRwxn84N?=
 =?us-ascii?Q?GT9v3yDykyBXTWoXD/fN0yHVTQF/dA8pXk4N0vq2exKfE83pCT8GrSm6nDxa?=
 =?us-ascii?Q?bLd7jwQnEZMfRBMXpYXPeAu4tjdB1IzUJlXR3FhAsN7lmVs6mB0DScbc1CAs?=
 =?us-ascii?Q?4gTBV9/C4gzBkSRrQoY8/UvwCn2rrKRhgjK88Nx7IzThTgUYvnle9FfUObz7?=
 =?us-ascii?Q?BXc13nCO1KpBUEA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR13MB2365.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XB7vtp4ogzfhfoHqiml9GgujOmNyPUM3WBle3ne4c/ZgDSuEtVLHCrw9Mjza?=
 =?us-ascii?Q?yGU2NCYBZhh3WHFchEovh37W7EumsLrgUNXUOssD05E1QTWLIIo7XU46dXoA?=
 =?us-ascii?Q?+L7oNarm5YIG0Zh+z5STJxo0BOc1SUOqRMbJkO4jo0yWHOKaySKzKjAQKZ1e?=
 =?us-ascii?Q?CUNf3+KDkHdlqRsFotjt+80sV9TZ7GEzY8jCqPR2QkRiZBoxlwyPW8yJ1vfQ?=
 =?us-ascii?Q?8ybIhPsPwsYve6Sjmx+Ck3dZElkEmrrZS/hpE/HRVnQMGL9YywFlutdtyxbo?=
 =?us-ascii?Q?wJ/3tlzQA6uuECvUDyA1IznJapTTPo1vpxvjS5zRxVRYktw62mWOw2IPzRQh?=
 =?us-ascii?Q?a8kdJTtTHtwv5F9rIrR/z/QPoYeyrQYQ2YHIoH9OyFRnfNQ1ohOhOi5JTZWm?=
 =?us-ascii?Q?UoVw4N13VHQpYlU40iKJtb1OOycux+ye3ZEU/akUO+Ep+tkOfH4YiJ1ZD3/s?=
 =?us-ascii?Q?mEV51m+AX6tjsnAG4LSiaZeuv5KsoWH8ja0fKK0YYYGfv8myXcztTAP64jEw?=
 =?us-ascii?Q?+IlBASH+t7kXanL5hAxAOPnYuozbR3hksN0L3zGMHb6qPd5stAYqr3HX81xR?=
 =?us-ascii?Q?iP0dDuyFqbgDdhTJ1vGS07afLas+Xy+oz74XAwzHdp4dqYxEA96WFYDO+abx?=
 =?us-ascii?Q?sJvCRp2JL78BnIUKK1U0fSh8+eBxIi2WzaraBPgc6ukU6LQRiczmjW5Fkg4c?=
 =?us-ascii?Q?aKBiOcKIaKAonDIvWql58aBByEt+yjS4JEnqqaqCLHp1o8NNoSqiV3WDTGJ1?=
 =?us-ascii?Q?wd6tO34bjw/KbrRX3iQEqmC8EY/xBbR5uwP7/VI8N7yk0svfORP0Ve7V54LX?=
 =?us-ascii?Q?5gsqnYI7B3xuUVD0eo2m10aLbQUv5zEB8QNFhtaRgyLZz9yIThlV1qGSlvuB?=
 =?us-ascii?Q?C7v5CZ+IAYNx9nMdB22k3WX1ekrG+/EN35DIlmlOe8DYmw/7RfAXsDHcf19L?=
 =?us-ascii?Q?l/iuLIWQkSg7EyCogjSnztcVDxKTXfdlbId3WVM1TDuAmydYZ5Xpqlk3Fsw+?=
 =?us-ascii?Q?tk7xYhrWE6jQo/HpFSjVkqlIzXq0siIVA6ZCDcfAj5XKkvoiYQ1c0KS0CeJ5?=
 =?us-ascii?Q?r9IUtBBGEWpt6g1UfzDCXmqXFPugGgRHJsE2ZD4Gfce6D8iGOvC5ym4l+0xv?=
 =?us-ascii?Q?rTBZS2Zr1y89G+oUq+ledwom+Z3Jv13JiK4kMk8/nUAhP7wq73SnH5cn9YWA?=
 =?us-ascii?Q?VIQd72cfmwMuz3rAUk6SYUQyhPCkjwrQABeqpg28EHRh8dcUJbjcup4vMq0d?=
 =?us-ascii?Q?msZGzVzQiBnSc/ZWz5ZZ8RBEPd+hF3jW6TZFCIJLsMqMNvo5j7SKydKgSbeZ?=
 =?us-ascii?Q?V5CRlPzSRdkM3P+0qyQcRBhtLGpsnsEamjSewjqW4kwOgyuE8KpC2rjR21GW?=
 =?us-ascii?Q?0nr+ILb0RJd8wDJLQOxLtzPSRwQg9b7o+JiboWQnP1YsXcabIq8y5BvIPoIc?=
 =?us-ascii?Q?kQ7eOBJCrxn/VxwGQEoYlydf6Vr8UWJla6uyvYUUMHIpOtiJ2DHk5mArBflE?=
 =?us-ascii?Q?cJMvNEdTt20yfCnIsHsVQ7sfgKwTec4s1oE087Qg720BXweXnK/MI0gATR/m?=
 =?us-ascii?Q?aOdgQ1NBQ1APh+d+avFOtjdD3JGsG0xjUx/IXxNQgG1lj9i0hSXHke4aurva?=
 =?us-ascii?Q?uA=3D=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0832e297-3f48-4ef2-ce58-08de284d92e1
X-MS-Exchange-CrossTenant-AuthSource: SN6PR13MB2365.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 15:57:57.6173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SEVEF4n76fiO5Ld8hokvXSdjAOm/KGTB12+sWvx5FpWKFmN1bPwV1BnH1vxSOnX6qdiFIdCffmmA2SDXaBmDQ9saKuCwMlP6VPXQh3s/QgM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PR13MB7587

While knfsd offers combined exclusive create and open results to clients,
on some filesystems those results may not be atomic.  This behavior can be
observed.  For example, an open O_CREAT with mode 0 will succeed in creating
the file but unexpectedly return -EACCES from vfs_open().

Additionally reducing the number of remote RPC calls required for O_CREAT
on network filesystem provides a performance benefit in the open path.

Teach knfsd's helper dentry_create() to use atomic_open() for filesystems
that support it.  The previously const @path is passed up to atomic_open()
and may be modified depending on whether an existing entry was found or if
the atomic_open() returned an error and consumed the passed-in dentry.

Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
---
 fs/namei.c         | 46 +++++++++++++++++++++++++++++++++++++++-------
 fs/nfsd/nfs4proc.c |  8 +++++---
 include/linux/fs.h |  2 +-
 3 files changed, 45 insertions(+), 11 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 9c0aad5bbff7..941b9fcebd1b 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4200,6 +4200,9 @@ EXPORT_SYMBOL(user_path_create);
  *
  * Caller must hold the parent directory's lock, and have prepared
  * a negative dentry, placed in @path->dentry, for the new file.
+ * If the file was looked up only or didn't need to be created,
+ * FMODE_OPENED will not be set, and @path will be updated with the
+ * new dentry.  The dentry may be negative.
  *
  * Caller sets @path->mnt to the vfsmount of the filesystem where
  * the new file is to be created. The parent directory and the
@@ -4208,21 +4211,50 @@ EXPORT_SYMBOL(user_path_create);
  * On success, returns a "struct file *". Otherwise a ERR_PTR
  * is returned.
  */
-struct file *dentry_create(const struct path *path, int flags, umode_t mode,
+struct file *dentry_create(struct path *path, int flags, umode_t mode,
 			   const struct cred *cred)
 {
+	struct dentry *dentry = path->dentry;
+	struct dentry *dir = dentry->d_parent;
+	struct inode *dir_inode = d_inode(dir);
+	struct mnt_idmap *idmap;
 	struct file *file;
-	int error;
+	int error, create_error;
 
 	file = alloc_empty_file(flags, cred);
 	if (IS_ERR(file))
 		return file;
 
-	error = vfs_create(mnt_idmap(path->mnt),
-			   d_inode(path->dentry->d_parent),
-			   path->dentry, mode, true);
-	if (!error)
-		error = vfs_open(path, file);
+	idmap = mnt_idmap(path->mnt);
+
+	if (dir_inode->i_op->atomic_open) {
+		path->dentry = dir;
+		mode = vfs_prepare_mode(idmap, dir_inode, mode, S_IALLUGO, S_IFREG);
+
+		create_error = may_o_create(idmap, path, dentry, mode);
+		if (create_error)
+			flags &= ~O_CREAT;
+
+		dentry = atomic_open(path, dentry, file, flags, mode);
+		error = PTR_ERR_OR_ZERO(dentry);
+
+		if (unlikely(create_error) && error == -ENOENT)
+			error = create_error;
+
+		if (!error) {
+			if (file->f_mode & FMODE_CREATED)
+				fsnotify_create(dir->d_inode, dentry);
+			if (file->f_mode & FMODE_OPENED)
+				fsnotify_open(file);
+		}
+
+		path->dentry = dentry;
+
+	} else {
+		error = vfs_create(idmap, dir_inode, dentry, mode, true);
+		if (!error)
+			error = vfs_open(path, file);
+	}
 
 	if (unlikely(error)) {
 		fput(file);
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 71b428efcbb5..7ff7e5855e58 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -194,7 +194,7 @@ static inline bool nfsd4_create_is_exclusive(int createmode)
 }
 
 static __be32
-nfsd4_vfs_create(struct svc_fh *fhp, struct dentry *child,
+nfsd4_vfs_create(struct svc_fh *fhp, struct dentry **child,
 		 struct nfsd4_open *open)
 {
 	struct file *filp;
@@ -214,9 +214,11 @@ nfsd4_vfs_create(struct svc_fh *fhp, struct dentry *child,
 	}
 
 	path.mnt = fhp->fh_export->ex_path.mnt;
-	path.dentry = child;
+	path.dentry = *child;
 	filp = dentry_create(&path, oflags, open->op_iattr.ia_mode,
 			     current_cred());
+	*child = path.dentry;
+
 	if (IS_ERR(filp))
 		return nfserrno(PTR_ERR(filp));
 
@@ -353,7 +355,7 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	status = fh_fill_pre_attrs(fhp);
 	if (status != nfs_ok)
 		goto out;
-	status = nfsd4_vfs_create(fhp, child, open);
+	status = nfsd4_vfs_create(fhp, &child, open);
 	if (status != nfs_ok)
 		goto out;
 	open->op_created = true;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 601d036a6c78..772b734477e5 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2878,7 +2878,7 @@ struct file *dentry_open(const struct path *path, int flags,
 			 const struct cred *creds);
 struct file *dentry_open_nonotify(const struct path *path, int flags,
 				  const struct cred *cred);
-struct file *dentry_create(const struct path *path, int flags, umode_t mode,
+struct file *dentry_create(struct path *path, int flags, umode_t mode,
 			   const struct cred *cred);
 struct path *backing_file_user_path(const struct file *f);
 
-- 
2.50.1


