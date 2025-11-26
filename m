Return-Path: <linux-fsdevel+bounces-69898-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D043C8A5A7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 15:33:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB6753A6BD2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 14:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E4A3043BD;
	Wed, 26 Nov 2025 14:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="YfFYCn9m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11022090.outbound.protection.outlook.com [40.107.209.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C269D303A21;
	Wed, 26 Nov 2025 14:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764167509; cv=fail; b=Hjw2Arl5MX40kFOzZO1qvHLQhNxEB5ppiXxjTFiWydEQEuN/95GQc6zmVeCtyBzw4l39RfGGB4yyNRSqqAqP+SPm2M28QS3Pk3HFuHlgd+NEFZD/AosOvH3sIs0r8Q/frXsFP3nSA181XvRYzxzrDLq1MxHAmTKac8CI57SCVwY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764167509; c=relaxed/simple;
	bh=bLLS8qIWn2WQyvID5CW5TiVylOGOlyAnVuDIoVyQcm4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hh50PcHrH2SZEEvm11KwegWW+o2Uvxn5ZjaD8UknVN/P0PWdUEvkU+aVYVqkgF4zYM3bphZYEwhm1d4/b6DB436sv0sEp8IU/+zBHGfgYZwNR5+V6wW2ZUsGypkz2ymZ7wJ6dumxl1h1ZANmCDccEdpyWufS6c/EOqErQU8wFyM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=YfFYCn9m; arc=fail smtp.client-ip=40.107.209.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UoT55dd2EzZjCfpzymYMijUgBbVQoZkIb22ONkvUvoQmDAvfjaD9TJiWw773jJ34a02t/6sa0uJiBFYIFLgaHWIerv19SW4WlLHY2pCAtqtXyFS734VyEuwqNqksym+ov8EURWYPvwwU5DXM3/GjunXGzI7GT9xOzEP/YAREaYgfz90+gVWDeHzvBr4pznbCLSzi6SBl61id58LHrIJ4QNFum8aLIyYp87XRV2XH5RyD0IV8ZxtR+JTfwIJxknZbYdWU5Oj6KGk0/BKungjOd6CVX8u7GzDijua+TVURMMyanE0N0OFLQaYQWxVlR6tYHuq7yrz2QADEzudK8JMZCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RCISu79RwJ997Da2B9M8yDgLqdjtVue2k52gsy0OZXA=;
 b=Av+U5l2OB+6LqaQY/BxbDkYxdBxCABB0JPbhTp82J1LmzZu2MxfewkstoNpjXjJpao9z0oTv1i27aetBEpn+c0tLSui+rAog1l6Hlt2Z2wvxJukYcklfdEgb/gHmHm3Aen7g+AyBgrOvfMbH5leRhpNbsWYnb7gNRgsvCruMcg7XMEk3A/cJTESw4HEl/w29STz32OGQKqnLo61ovgwuDC4IkDEAldkSdG58w2Om9b4BS2ueDGJyuuiH9SCbtGGGDUAIARQq4f0pcz5PVjBMRX+1T45oM+aLRxGs+yjcZDHZmodkSlnNrtWkhtheXYJdyjPgLmF/jwKVTWhvO2gg6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RCISu79RwJ997Da2B9M8yDgLqdjtVue2k52gsy0OZXA=;
 b=YfFYCn9mhfUfMbeDNhqh5C/v4TgQnXIrZ66SouZEvArejx8T7k7d1+Eq3iU3i74sPF6aK8w/lUlk9+0/9r8DUhMYEysqceKLLFsHHEbIyJQbs68fGQ1P6iesT4CRkNpi/vdUNCrqM9zlgmz6KRQzcKOfv4E2pAFbMiui58NWmKk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from SN6PR13MB2365.namprd13.prod.outlook.com (2603:10b6:805:5a::14)
 by IA1PR13MB7519.namprd13.prod.outlook.com (2603:10b6:208:59e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.13; Wed, 26 Nov
 2025 14:31:45 +0000
Received: from SN6PR13MB2365.namprd13.prod.outlook.com
 ([fe80::9127:c65a:b5c5:a9d]) by SN6PR13MB2365.namprd13.prod.outlook.com
 ([fe80::9127:c65a:b5c5:a9d%7]) with mapi id 15.20.9366.009; Wed, 26 Nov 2025
 14:31:45 +0000
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
Subject: [PATCH v3 3/3] VFS/knfsd: Teach dentry_create() to use atomic_open()
Date: Wed, 26 Nov 2025 09:31:36 -0500
Message-ID: <e8e927f72d9f28bcb91185077e0905285c307552.1764167204.git.bcodding@hammerspace.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1764167204.git.bcodding@hammerspace.com>
References: <cover.1764167204.git.bcodding@hammerspace.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7PR17CA0041.namprd17.prod.outlook.com
 (2603:10b6:510:323::24) To SN6PR13MB2365.namprd13.prod.outlook.com
 (2603:10b6:805:5a::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR13MB2365:EE_|IA1PR13MB7519:EE_
X-MS-Office365-Filtering-Correlation-Id: cb5e4f37-8fe4-42ba-b232-08de2cf886b5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PP/GheG54MZnXg/oJyIVdsxWzDnay569lK12b6mY8C5T6myvN6nzv+/uQP/f?=
 =?us-ascii?Q?Z2lUhCc+Jp3ZSAFU5JZh21d7jHuBXGQ8QK7mjGjhR0BmUzorIiyQ5n4LPIP3?=
 =?us-ascii?Q?5lsKwl3ZvoFl9HGCM1cIdmYuNi0IXZO+DRs2NQiP1U3hEFxLD9ezigCPSnjN?=
 =?us-ascii?Q?vS62iNrdr2H0vwPjpC2/1mIsk4dkBnQGAvW9/JMx6z8+SEwnZyXKokyT9KNy?=
 =?us-ascii?Q?EJN44JxWCcyHTDtx3WQ6gomkvrmDs+iFuGqYdrh5jmlfAbMlK8NxxZ6xC/6Q?=
 =?us-ascii?Q?xV0mel+7A8zLR5KJxD+KSiK9OzIXTCbLVo0KJePBvQRBVYUpqGJLWA4nNWOC?=
 =?us-ascii?Q?h4T/k9Dj3vcP5mfxAaPxXPKivb4HHyMC9ylTE9JX8I2bXe3MNgBjmnYBB01J?=
 =?us-ascii?Q?w1EfrckCBedUCPi100/qZjnRCN79XiX7tQvRaFJ1SELHuH11tNBSFynjFSoz?=
 =?us-ascii?Q?xNJAedhS0FxgzFYKkiAhbBEQYs4KPMyYd9NJEhKVc57X5LkViK4i4r79wuUq?=
 =?us-ascii?Q?WUIgE9uy0+4xIvW2Fu2OzLyIaxfiS3vZphSQ9l+LZ82KSiDJ/PrQPyndQF0Z?=
 =?us-ascii?Q?78On2N3QN2ItT10IDPEiF0qWY79SBx+43bYsqOwpx5/uW2iVzROV4ZnWqmch?=
 =?us-ascii?Q?dFQqt7cBhZGvErh9yPNVUmuWvrfPnEPCkOPTbTSUeDz/PVM3CBMfu6QWB+vt?=
 =?us-ascii?Q?JtFF2mIt0fRVxWc3yQEbJONnCaOon9bmNzViI1BoOFOC2LjyRkLL9FPruV6Y?=
 =?us-ascii?Q?catpNbq9vWR0j6OVTA4ITY41bZZrp9a+uXdza8sB39Cl5t2Bp2dFripFpRsC?=
 =?us-ascii?Q?I+3ZQmEwix7Xs2FkcLRCwZIj3M/sv+kvsaXA+BRNTVysoExtRggxciX4aY/k?=
 =?us-ascii?Q?jfdargpZ6Z33RyNiRxdV+7L4ZIiSwumohDgRf5wwXYhg9TNtwxTKenScXdWa?=
 =?us-ascii?Q?SngRQJLCP6EHBezZU+QHGALvCBajx7MgQZjmiDggn4NDNY9Zb/a7hJOOtNtH?=
 =?us-ascii?Q?w6zZFF6j16HlpZmhOeRNpH7FqKGfRe1mG0T6AqSt8z3BDwsW1zvzjKq7ksrr?=
 =?us-ascii?Q?/7ohh1HlKuG51/OpS4CUdobG1u7TXRFOQ3mP9Zi3uplyriSGmwP0/72zQiRU?=
 =?us-ascii?Q?asgHus2V21C5Z+pARpSketaZbkT9iUMzk6wCEG48eFwTEXRLQKU0haoer/Rj?=
 =?us-ascii?Q?QwMggkwe2zcjao98yT5S5+iuDQjenf3iA7TJCFaRVUFHn4BpMRx3pYCq82kS?=
 =?us-ascii?Q?8LLmq/5D5N6Hc4e7WNkfrxWqKIuwmCr+tbHCLhPNSu4imXV4tdGNgnXI6MCD?=
 =?us-ascii?Q?avWfc1I5OUn/Yw4771Q9g7nylwwTpJMLjDNGZc5GfjUbpIkOQGYkU9ek6ekQ?=
 =?us-ascii?Q?TW9EcC4UdiWc/KZCXmIDL+d6NofocryqQMoTavvfD4ccscHUO/0xrzCH/m9A?=
 =?us-ascii?Q?4b+BW5eMzBWce73MnM+3uqE/o2BwNELe4i1QBjVSrJ+baj6p/0gSG2KQlDzH?=
 =?us-ascii?Q?b9q6OU3sOrGG83c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR13MB2365.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Gt+kqvSpCjZ4KSwEyyUL2976doJQ+wOELBch8Hyazqb6xX88mVO8ST2gljXa?=
 =?us-ascii?Q?+6QzR7yGINg80Z9UAvrQ9bJ/mt27KHArQMiyAWu+q3NjlSkMJbmT2VEVnrhp?=
 =?us-ascii?Q?JCPBOqOMMxAl+H9wtxtHmBZPJx45xRC51loG10EWDTEsx0olUz6pLtvb+fyI?=
 =?us-ascii?Q?GTdoAF40CCDtnSagwI0Wljgk9cTfLeoH031FaKvEGR7jWQDC1ebpZvALw0h5?=
 =?us-ascii?Q?JMK4JbaBteFvAXY9HrKtoIlauUvHUfE06E34/3Xrn/0h4RJc4weW5gsE7mcT?=
 =?us-ascii?Q?AAg8NiOwjkrr2iJ11jfKc8vu3/Eebo5KV0hXn6KAV8jVneW9Ze+FvobnqILf?=
 =?us-ascii?Q?owzZ3BNCx953Hb0b8ccLx9U+IaTBR4FTzzb+o1O/WYFZNDwPAsq2WKwAHblT?=
 =?us-ascii?Q?zcw+SyvxC47pWMC84sWFsdRY3WxBzvL5qlDO2WLMHhKqvqstnyBIBBplzV2E?=
 =?us-ascii?Q?N1izou2xI/yDKkDj/B8bnM+GLaFsvEYFAq590c6V8STLrOE0RpikGMuhr8LZ?=
 =?us-ascii?Q?UtoQwWXCCjlZBd4+BPlnSjWzeIwQhvd/qgdscwbpGaJZhAwJ8cTCbhiLgMXF?=
 =?us-ascii?Q?u0noiH4Zo1FapPvrzWK5Z6/ihQK0gtMAkUw8RZHStZTvsKappya7qGf4doeC?=
 =?us-ascii?Q?cpjp79tBYF6gj0Ki+9aB7pb/eHNsZxZYTAWsdveJnBcyA/bBLtLVr7fSVL1y?=
 =?us-ascii?Q?qn7iZ1e4/PxTApe8SUCzQEYYKXtPYJ5QOpv6nctMaG28yJ64uFndFcWq7ZSf?=
 =?us-ascii?Q?Npg9mqbBZUxtL+NSCgoen8hU7g6EiKnAmEyV3eYN5QIMJYh99J/euSBEzPI6?=
 =?us-ascii?Q?KePT99lSGzfJeaZttI9LSNee5YLTmNlCvrECFO+dTOrLBQ9/YfPVFVASIrEW?=
 =?us-ascii?Q?Kp0sprz5PSOBDdVmeq6OyFIddctDiieX4McubUQikPPLpsihVyERcrKve00G?=
 =?us-ascii?Q?HCxG1ZBqJ2AG8NxXAaYslWW1JerZcDIidr6ecLpjzY1/xC41oR9Ka5ayPvmW?=
 =?us-ascii?Q?6ihS4obl/mvOHqpNJ+ueoMOrNdHzlsNo3wGQ3UHQgium/NeU1B++tnhUAxa8?=
 =?us-ascii?Q?3HL0ug8NQ7z9gwhyBVamVZ+WPu1nlao0rq1yYzb9F39UitOreRberFvsGlIU?=
 =?us-ascii?Q?f30QqoSNta5EXlJh211LBm+8LtJwqcYHQTwt6rcr9O8bkkaBPFYVQm0XnHbk?=
 =?us-ascii?Q?Ebe7n1QbPcG+5gcqb/BjDaQn1LTBGni/GMTkZQ+LfHkrTCxpk3sNKdCtoFtK?=
 =?us-ascii?Q?uQNEwxPp0FhGIvD5FXTYRs3Md289b9axJyrnXV1UVYdSs7kjJKuj3p9SaArW?=
 =?us-ascii?Q?vaFvlRkHJ8sDLcrrNyU/Bsn85tLFKHhcVGezAqsRWvJtSnhatrzSO2D9kqMv?=
 =?us-ascii?Q?LgOjKvzcjgfir6aSJV2ySshMAmVHDK+Va4PglxS3uI/F/WI2+Y9cJUtJLLrd?=
 =?us-ascii?Q?r+IQFM2TwuFcSEyGuPPy2bq52HZS8FcnKZedomALzhzPBf/rEBVZV0hZZrJN?=
 =?us-ascii?Q?ExPO7ieVgi0WfeyMJPcKopq6hRBVy+w1tUqKowOtP+Jod8QQOGebWzhyNhxo?=
 =?us-ascii?Q?/riZjDIVCYBp0fHGDY6FgJNYYpHw6NABjvHJcqGgI77KTme/OJmkT0rjVOGH?=
 =?us-ascii?Q?IA=3D=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb5e4f37-8fe4-42ba-b232-08de2cf886b5
X-MS-Exchange-CrossTenant-AuthSource: SN6PR13MB2365.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 14:31:45.8197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fwyUULkN1Ia9xmU5N1vTSKr5OHCFTC+vucmZYaOyh4m5pFBm/WA4+J8yvvg5vJq1/BL4vmdtAHpI2AE7vjzTOO8xqo+GUu6XcPY6W9p2X8U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR13MB7519

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
Reviewed-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/namei.c         | 46 +++++++++++++++++++++++++++++++++++++++-------
 fs/nfsd/nfs4proc.c |  8 +++++---
 include/linux/fs.h |  2 +-
 3 files changed, 45 insertions(+), 11 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 389f91a4d121..d70fd7362107 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4286,6 +4286,9 @@ EXPORT_SYMBOL(start_creating_user_path);
  *
  * Caller must hold the parent directory's lock, and have prepared
  * a negative dentry, placed in @path->dentry, for the new file.
+ * If the file was looked up only or didn't need to be created,
+ * FMODE_OPENED will not be set, and @path will be updated with the
+ * new dentry.  The dentry may be negative.
  *
  * Caller sets @path->mnt to the vfsmount of the filesystem where
  * the new file is to be created. The parent directory and the
@@ -4294,21 +4297,50 @@ EXPORT_SYMBOL(start_creating_user_path);
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
index 7f7e6bb23a90..7e39234e0649 100644
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
index dd3b57cfadee..2d3fcb343993 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2883,7 +2883,7 @@ struct file *dentry_open(const struct path *path, int flags,
 			 const struct cred *creds);
 struct file *dentry_open_nonotify(const struct path *path, int flags,
 				  const struct cred *cred);
-struct file *dentry_create(const struct path *path, int flags, umode_t mode,
+struct file *dentry_create(struct path *path, int flags, umode_t mode,
 			   const struct cred *cred);
 const struct path *backing_file_user_path(const struct file *f);
 
-- 
2.50.1


