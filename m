Return-Path: <linux-fsdevel+bounces-70048-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D7DC8F6D4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 17:04:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 868F14EC201
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 16:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB065339B37;
	Thu, 27 Nov 2025 16:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="TZVdJCji"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11023119.outbound.protection.outlook.com [40.93.201.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF23338932;
	Thu, 27 Nov 2025 16:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764259343; cv=fail; b=OLVwInhsc6nMefcOm1JYYrqUvxSo/v6QiGIsKXGiplilv618wO8BgarFLTTEifNRBV8jeBNODhacB8NlS538n9j4bC/XCF1oLE3G/VIllM9R3mo07hLiIFPD5Ex1RjHWmXQg9MpoWTJcxdHoldUII3PvI+TjF0YtVM86kD8mqkw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764259343; c=relaxed/simple;
	bh=Czg0mA9Dt4KqHPIFXl/m2UMz/hjAbFSCBCrwWM2DzA8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZH/8LVKbRopXjVEISEfysoyShRjZyD2ORNcyXwZ2Gm0Y/mwVxIkHTlhHNSQWZ2zPTuMfomOg65QmhhkZVbwAsN9Z+ujOjWql6PqYu3FIpxRW0QSnvdJQaRNDOhEbR/9RtxowcgVRQ8ywSpph9tm1+pl/cxxT+Wu2Z+CAZYRaKjY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=TZVdJCji; arc=fail smtp.client-ip=40.93.201.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OtqTomeP6EA0YWwajmCa8HdhOwSkxHr3p1xt3zCqfor88vIm9rv7sYu7RIG0V6iHDT1AZgipRDodPUM7+35YJy53vfZk/FeYqLzOmEMlhQGdeEj/c06iu10QlyC6XTR7G4xibyioTzvGL9wparbhxYk4BDCUgHJ7jdj7qcZiop00Eof2VDiNh3pmfUjkNZNgAAUdPAwASL7mWEd5H/rmiWQvne4/jezA8N+KG2vwVQ77JVEFtYf1avbqZsj5rSrF3MvYwf2FjMmt+KaJxOvf+99qWhmeJ8aDa3i1Q+fp2/NTKOKC0rIIHyNaYKp9znA6uCZ5V9VrjMMcZS1PQKUMYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zXzFWuXfD1ZubQyPuzgU7FjtCJpKBZsQ7n27zM078/s=;
 b=YLfkf+kWcK2pTTBBHbt5GkvH/q7yHRkld/52Uqz4ecn8qTnAxyHB/zLNFUvASssfRXhFviosSGu+NEw0iTfPTlWjyGhz12CsgOdyj1lyvQFuuazE+pM8aIallqLZ4NRpA3O/KencQ5YTuryjCY52Fmb0SV/tR4zJIqh+sClktt3mG2e1s8kUCsG/vm89MMa5Q+k5AHW6zH6aRD1OLcbKOXnbPPaONZdqZ4W8z4PSBJiFZ+T7lKVtd1YjeVxvYtAUzDaDeT/2/K+LcYfPWtwkF7kSy5jNo8hUcbY2AmEeQ1J/yTKU7zf6BZpzYeUE0vqaG2kFbcTaDV3a7gU/Qkb6aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zXzFWuXfD1ZubQyPuzgU7FjtCJpKBZsQ7n27zM078/s=;
 b=TZVdJCjiuGvP1FSL6DyX/lvY1G3kH8BmIorE5QINs4xuEIHNDcbVfFrWC5glEw2UB67VbjIhC2IcqyVMzOQmIYtx1yhKn+7RnxmY2cPMk6gnE4vTiDrR3HO9jv54G3ZUJgRc/Z8SafJPlLBOwRfihuAZyazbd26ujFU9H6ziPag=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from SN6PR13MB2365.namprd13.prod.outlook.com (2603:10b6:805:5a::14)
 by SJ0PR13MB5500.namprd13.prod.outlook.com (2603:10b6:a03:421::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Thu, 27 Nov
 2025 16:02:13 +0000
Received: from SN6PR13MB2365.namprd13.prod.outlook.com
 ([fe80::9127:c65a:b5c5:a9d]) by SN6PR13MB2365.namprd13.prod.outlook.com
 ([fe80::9127:c65a:b5c5:a9d%7]) with mapi id 15.20.9366.009; Thu, 27 Nov 2025
 16:02:12 +0000
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
Subject: [PATCH v4 3/3] VFS/knfsd: Teach dentry_create() to use atomic_open()
Date: Thu, 27 Nov 2025 11:02:05 -0500
Message-ID: <8e449bfb64ab055abb9fd82641a171531415a88c.1764259052.git.bcodding@hammerspace.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1764259052.git.bcodding@hammerspace.com>
References: <cover.1764259052.git.bcodding@hammerspace.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR05CA0013.namprd05.prod.outlook.com
 (2603:10b6:208:91::23) To SN6PR13MB2365.namprd13.prod.outlook.com
 (2603:10b6:805:5a::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR13MB2365:EE_|SJ0PR13MB5500:EE_
X-MS-Office365-Filtering-Correlation-Id: f94aeb58-e06f-451c-317e-08de2dce53cb
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Yn7+W6kGTR5LutPfFpBTey2OCn1jVF2g98JuEjMxeNgKX7JR1a1IhgjXO/Q3?=
 =?us-ascii?Q?u7v92qzGm4XgX837po2CWcFZfSflgOAOsVxHqBrmjO+cr+HABREu3gMOQBFL?=
 =?us-ascii?Q?4TeBahp6jaSNWeaxVzlicq9XWQZtvmg8wItYUPkWzV+9qWkOxNZN9huuodhN?=
 =?us-ascii?Q?o83tORlHyf6a0odAd0fPOlD/++WO6/e0AFbOWKfwrlJYnfKIWJkYc03SNioK?=
 =?us-ascii?Q?7cLz/PHTt2nuEdwUl+dtpAalXaLpnMMjQYMLJTww8EjfjWut+faNUsFha258?=
 =?us-ascii?Q?q/10JTVv1H6th9Lg5EuS0ytZi8N5GhzcPFkam+Jv3jwYfef65noRel3pctcy?=
 =?us-ascii?Q?neTWZql8hHimJSvHIEREX0Kmjv1Gond+njRPxfehi1DGAPrtpABCD1eeT314?=
 =?us-ascii?Q?jahwxuWYm0ZG7yEwpvimPhFrr1lSI5/JZ25colulOnYDh7qnh5OBrN8iFNc1?=
 =?us-ascii?Q?g0x3fPBmX9TBxfEJ+HmOO0a04Fat0N4SQE51F1HOxWiuVcsNA+tSWTsLK6Iw?=
 =?us-ascii?Q?3dN+a0mb/OLH1tXWuqbIu+vj5RGmmkIGQDiJPoNG2Br4uIRzmjN2YwA7nvsn?=
 =?us-ascii?Q?0Hx2aYXfNATtipgZN9wE0R3mAgKWB1qIIkOV39iMR5sp2JCn5QCCZnSBIPEC?=
 =?us-ascii?Q?iO3pqJW9L+uGmX0bCzzAIRRZuy2cFWRqws+hEgqhCdfk6L0poZdwmwBq8OlY?=
 =?us-ascii?Q?uIHHQ34eTjQB4RyMGX2QBs4v8/Rl1Ni6WUFKc9RtQXywLgW6UfLfkduMKv7e?=
 =?us-ascii?Q?R5iNgHpY7PrM9uEGovFO7i7vXttmEVcYexXsC17At6ZlS/XNwYJqDOQ7wcou?=
 =?us-ascii?Q?lkGg5i19sS9kaSM7EwGd7ieLH+vkyCqso870V0zrCUIWwYb2CFTVpaHIOhBQ?=
 =?us-ascii?Q?MmYBox6V0KEJBUefHcjx4hmwTwJnRbjrlKE0wDoKuIxcS/dCFM5wFbEkjkJB?=
 =?us-ascii?Q?/kM4T6uo1lOP181FLbrQJp4b1r2jet5kqLQXORShQzVdz9ZkXLMNVNZFubMO?=
 =?us-ascii?Q?UoEmP4da/XUp7HkrwDKZvlqe+NV3dl4L8MUzMCS9G4F272UA4bUqqdNpJdFY?=
 =?us-ascii?Q?4QBR/lV0ZX59zGmIr7LBQkcc5R5rs3Eds7ZZRHzBboVwxHuVY8S4lu3jZRBB?=
 =?us-ascii?Q?ZIeWclpA2tKdFjUqFLfw0uKpkOSJJOevWce9Rntp516qPdNrduZDfja6fRV9?=
 =?us-ascii?Q?/3Em9NAosLjLMW4gPJuC6J9VQn59VHa3OaeDHW2FBdAtIXNwfSNkTtRKwd+D?=
 =?us-ascii?Q?m3A3me4NZypzybsAn87mQJ/K7pEtgLHtGsjigoACxyu3d1eV4a2c3FJWfH5u?=
 =?us-ascii?Q?EJHZvP2Bsg23S1sXuF72kN2J0fD1oHajDuO3ep8dJebIL9sKX3PbfD8JGYkp?=
 =?us-ascii?Q?adrmB/IQhww9BV+JP2nm6slkjELGL1rq0A8MVB1hwFd9RFM16OeVo+EhGCez?=
 =?us-ascii?Q?D5XbBw6R3JnetTgFUtggHc/WQyuvR73rNy44ke4t4xicDYx4h6cLjRhnZxnc?=
 =?us-ascii?Q?FH3BbkGjzOXiekU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR13MB2365.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3VSDUinoilsIPs1GINW1qWFBcnWjMMJDJRQAT12SqkTCYDgHeRVVpeODDadn?=
 =?us-ascii?Q?TdG5/fNvnrTYfbHQhFqze7eSXthX7nQMBm8NlO5xMXZNHFYFz66Gxd+PQ74F?=
 =?us-ascii?Q?zCHNHa7/b5bgTp6ESsD48z5yYVExXpsfrljX1OGjkM84+yCs/j8oAlLyHCFC?=
 =?us-ascii?Q?/hj8MZP90vq8MtSjZNdGqQd8rGOpbLc1+NBcMJUIPfLq+bASWAfeawl6jGmm?=
 =?us-ascii?Q?5Uuw0hpkNSYg/uSGI4smE5LT510X6x7KbeE8xlhEE6O9t20IbpjjiLfcj/Zi?=
 =?us-ascii?Q?wJd7CMUVfK6OArqTW2sq+qZUQ5v5CjHP07MRJ/QHxEW9xHmjMJlUvvOKzEu8?=
 =?us-ascii?Q?P3JnpftmZXG9St5ifu98XRdiSbh72FRXYbC8k4XNWSSWMyXhhDNnjX1BSUUB?=
 =?us-ascii?Q?YapSpAi+zmKjHmxM01oBTpvidy41pATPq5jqHP7I0Vja9G51l4vuLmlKtmSG?=
 =?us-ascii?Q?EMJdeh05bs+OEn+jpYjLqhx/wXfovWemEXg8R1MU5MZiGzeXxQn9M9POW/S2?=
 =?us-ascii?Q?ksd7XtEs2AzF2vT528re6h01qEXqVeSmMqK8/UUJoaEh+wtq1/7FKZ1RMcIb?=
 =?us-ascii?Q?hf7U4hr2YnX1ShN6txSAwvtBbQ7W03udkWCigMdG6qQ8URTcKYyW9s5hBgyZ?=
 =?us-ascii?Q?R+TwwEp4NZuu8ETIKOxCVhpepKlgj7Vi4lgWGBt07BFWvTnBHZdrV7i//gAi?=
 =?us-ascii?Q?97rHxLtkS/hJQ6pAWYMhS2uqKstMlNInFxhBpj/sotmfeAX7h9E7VpdbcSSO?=
 =?us-ascii?Q?yQAaf/Igy3pBOJ4wnZCy12GTBF9jtntgXI/pKfeI7j/7RATcqr6Z8NGIvzp3?=
 =?us-ascii?Q?2PZY/Zsv8o3rSR3m61N5K2RiQB3rA+PS00B2cU4z9tB8jCEBIpautVJM1F50?=
 =?us-ascii?Q?S7a0ejyQ4seOY3SDt6v0Hyq3janLZ7nLvjwEkdeYROizrE0SfsxSwQxefKNB?=
 =?us-ascii?Q?ASPxfcftWUeewBZzafEtQx+WuqZcx67HmxPLHNTkJrFKf+5/bx9vULELWBw2?=
 =?us-ascii?Q?Lc5qjid8t1T9lQ1BNu3xk7grii7YkWTSrJjVfPPA237dXwsmESSuGYSFhnhz?=
 =?us-ascii?Q?PT+ZqmbY5Wyd2CXaBfzBr/P9ngJcjTx18327ZWRE2U0TARog4YDexDAEVg0X?=
 =?us-ascii?Q?vMRITc6Ajck+8eP64xLjABTBYuo5UgKEd001gywQW2u1B/AJ5s5DO8XtR+Cc?=
 =?us-ascii?Q?W9+CU4L0sg0mxl5JZlfAFDC/fBP2/eDjfcdw8n29sM+WgDUhXObBpMoiK+Oo?=
 =?us-ascii?Q?ocQHLPguGldEYUL1z7Tf6sI9+Tbpi33P0wqjs9uSJ0w04phrMpiOuTZo82vQ?=
 =?us-ascii?Q?w2U51FpBosorr7IKCnLuZgI7Eov45S84XSnqviYIKJgWwf3/jUtFJaQlsv1A?=
 =?us-ascii?Q?sMTLsZnlU79RYibg21Gwu5IXb5M600h3l2j32dBbcNepLoVZhqTD7SwboHTC?=
 =?us-ascii?Q?GeLEWpS4BLPvTXfI9YC1nRJIsM4KdJhntrVM4qfYPymHNMokh+7kDUIlyvcI?=
 =?us-ascii?Q?qT3/JNxmVoVGDcucI7Gv+6AwunytGKeidnSJ7Bn/aj6vqcN+AUI3kelobBdS?=
 =?us-ascii?Q?4aDTcEcE4TNuWO1wnWQYLlMG99IJOyS2JUqL9YWdPuGCnzj6lvODCqXL7L+/?=
 =?us-ascii?Q?rA=3D=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f94aeb58-e06f-451c-317e-08de2dce53cb
X-MS-Exchange-CrossTenant-AuthSource: SN6PR13MB2365.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2025 16:02:12.6546
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Iezjkwt45t/jKuDKpBSm2oly2XanyeCRNihpqH2zpcbxyRakpDaBGGbcujPNY9vqPlfxI1DNzxWmRhnwFbZYAWMCBzpPd+VXW2jg8bd0a9U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR13MB5500

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
 fs/nfsd/nfs4proc.c | 11 ++++++++---
 include/linux/fs.h |  2 +-
 3 files changed, 48 insertions(+), 11 deletions(-)

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
index 7f7e6bb23a90..6990ba92bca1 100644
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
@@ -202,6 +202,9 @@ nfsd4_vfs_create(struct svc_fh *fhp, struct dentry *child,
 	int oflags;
 
 	oflags = O_CREAT | O_LARGEFILE;
+	if (nfsd4_create_is_exclusive(open->op_createmode))
+		oflags |= O_EXCL;
+
 	switch (open->op_share_access & NFS4_SHARE_ACCESS_BOTH) {
 	case NFS4_SHARE_ACCESS_WRITE:
 		oflags |= O_WRONLY;
@@ -214,9 +217,11 @@ nfsd4_vfs_create(struct svc_fh *fhp, struct dentry *child,
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
 
@@ -353,7 +358,7 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
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


