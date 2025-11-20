Return-Path: <linux-fsdevel+bounces-69246-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EDEC9C7538D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 17:05:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 662673473F4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 15:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE54634889E;
	Thu, 20 Nov 2025 15:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="AFn3peSf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11021106.outbound.protection.outlook.com [52.101.62.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B865334D91A;
	Thu, 20 Nov 2025 15:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763654279; cv=fail; b=FbFuY2aFDQ0bgtDNas5/jL6s+t/bq9Zw28ryKSC2kuXXhehxRgIVUoUFOTtLdBLzWS24TzGNuzMFmAv27uwUKyoSHN9HtUotC0yPawKLwJEQRZmVK69um1TwHTJltJVp7GvOg9bGNJkzRzp+MYTQw3OVWqMUd9bF8HDwbPC0TUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763654279; c=relaxed/simple;
	bh=yw61ekUl/oQ9hFJ+kuge7IjIOlwABsq8WECPP09vRqk=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=JM/XzydsOSqcdX1obaT9G1rkfCnckTUe2hi90S+AZ9K2CBA2n2e+pjbOcVep0a3vfSDpsyKmpyOL4FKz2WcS8W4DNahqTldoszonaVeHtxAMeBBblAQxHTpydYrtQzhkXtpBnwtOV6gRHhkZgghS3ZY2pl1ZGXNbA5yEbmPwTT8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=AFn3peSf; arc=fail smtp.client-ip=52.101.62.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lqwK1O0HgZlhXT5nqjKDeva9Q5SI8IFbhxm+vc2riA0w2tpPliPSqKq37FT/E6hkUCXunIxUz2KKKnqQbV0FVOkP611QNQpWuBrgPTSpsjHRPWLo+zNj97je+4Uu7JbAtgCDEei4bMwT7v6fTIsOVJzVw2kvBH45AqUtZjeUFc4vhIAE71JXAJLagmNH+1ZM9qQXAQm7Q9b+4ES7tVIXkpGtag/3TrHKm9UWVJ5tbOQbKOPabO5RZ6igcwsIucSnATeLqjr5i3Cez064LvzNLyWC3Ur1qvJ8WCdQC9O1xtkBj1IG+Evi3z0LwsLqpnC2S9NPog50Uiys7Su1HSBLpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8X7LULIch67TQqrIOxfgioqorCug0yue/45mCaBJ/J0=;
 b=QyTOe6rHFwyh8CINfx2E2Oqv3Uf/LSPtVBbgLI4oO2k4hbKVRRKi8YeXTGH/IDNkSIhyaK3mEWTCk9fLqfBdF7Tzua5PU5nfsehB2DduOmp5nyxjM8BtGspUmfRgzQncbqMMUdwisaZyitD50v/IFPSMOco8ihjC3H83cqwyP1Tp0rcekRKpVt0XyUIDCSSmpTvp/THo0R7CLFsaUMTSbaHu3aP+oEEs9RhMAuO7eFmUJOkQ2kY1ybaBnpZdHRfmlChJx5CDKwwdb6I/fNESKn+6jRqts+iTJXpQO6G9TudI4oum78W0cAs0/PgFppMQwT4W9/aFRIG0UNeR3tSFhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8X7LULIch67TQqrIOxfgioqorCug0yue/45mCaBJ/J0=;
 b=AFn3peSfAcSz/1VgZ4yVUE4dQNqHuckEfhXPOwQMHF3y88FLPbVZoK+vhIUWUzhXSaktF7vjpGITuyUG1q1YQe8j2CmXLodYgr/ez7gPJPWPRql5iGnyvdiYJF2uVrA7tGTfdclhBjXcExfgFhWaYuCghBy1p9nEn7Ye3rkNYvs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from SN6PR13MB2365.namprd13.prod.outlook.com (2603:10b6:805:5a::14)
 by SA3PR13MB7319.namprd13.prod.outlook.com (2603:10b6:806:480::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Thu, 20 Nov
 2025 15:57:52 +0000
Received: from SN6PR13MB2365.namprd13.prod.outlook.com
 ([fe80::9127:c65a:b5c5:a9d]) by SN6PR13MB2365.namprd13.prod.outlook.com
 ([fe80::9127:c65a:b5c5:a9d%7]) with mapi id 15.20.9343.009; Thu, 20 Nov 2025
 15:57:52 +0000
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
Subject: [PATCH v2 0/3] Allow knfsd to use atomic_open()
Date: Thu, 20 Nov 2025 10:57:45 -0500
Message-ID: <cover.1763653605.git.bcodding@hammerspace.com>
X-Mailer: git-send-email 2.50.1
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
X-MS-TrafficTypeDiagnostic: SN6PR13MB2365:EE_|SA3PR13MB7319:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e10114f-85fc-4af8-dbd0-08de284d8f8a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?G4gxDSqfuNKDNEtyCiF33SyhEWjS+1wjcJlIxm1g6H3TPV8PD4f1FfJdjfWQ?=
 =?us-ascii?Q?Ehj6mFD9JTK6ifzAl3WYef+B3J5GZbet97ha7nGME45mdgQ2MqiwAFdJnGNK?=
 =?us-ascii?Q?XQz4O6DvaEjNZWIjabmNJTY+7gHIfAf+e0LEYPFP/Jc48/B7HXjW4u19mayG?=
 =?us-ascii?Q?Yy9Jdyss3dDIktEeLELJKe20XRghnsiOAaSSbXzkDPF3gjh1QbCPwu1JeeF7?=
 =?us-ascii?Q?PZTh+ALBNEhvd1TO3JiBMCMt+LADp1/8nakKgbkswjzBD6S4AhWb2EQglESH?=
 =?us-ascii?Q?dBjiCQqIer+LWeSFeXOCVt8N+zpQpMMCfhjMKP+Du+ZefYPAH8fdCRR6u6TX?=
 =?us-ascii?Q?G7vBes/md0NWJnXhsnm7tlvaI/+xT+vhiyu0lta3ckW9BJwEuu8XoMDJDV71?=
 =?us-ascii?Q?kGLIhVamfrCC0mtCxDjcFx/dRQ9uEW3H0ImtvlXtyabqlxxHTxzzf5I8eo3p?=
 =?us-ascii?Q?MnpbJbig6JVc4eBgKTOUVk0td1P+tPQjxAiY6ptmgVFQYuMeTsIVjGyVCGPM?=
 =?us-ascii?Q?cla4gWUWn207kPvaSQsrR56eRSZX2Bug4aP++6v78ZVFXaHYdc+O/+lU5If6?=
 =?us-ascii?Q?4NX+Xh+RumTfk+dGgJV+2fqEFiGYNGIKSdnDdbUku72KZFVk0HfPSh0W2Hcy?=
 =?us-ascii?Q?u6pfxPMItUMBjJJBISmDCm8MhoAbJHlzkyu9ZD24uOxpRfKHuTMbVcoJLGbu?=
 =?us-ascii?Q?UH6Ux0I4T1RV2naT5BF+SbtkIAzdOxRCZG+m7a3DLtNYcH6kA9IuekFiuDXI?=
 =?us-ascii?Q?gxcXfKWYt1NX1ZK4ZNFNz9ZjhkMqxavid2fWtOz1pYzHaGVpsmXZdNw0E8ds?=
 =?us-ascii?Q?D9lezauJNczvh/q/BkPZfLEWkoMUwxnuS8CW5CCYx+UTLxeW9J2JwRf+hE0+?=
 =?us-ascii?Q?XYOwzonVFuMx3UZpxX5kt9LW+MLLa5EwsBBDzLgRIf6miudparsximiiRcHb?=
 =?us-ascii?Q?ySFhVarKVYDh5BQ8iZAB9VEuMOP0C63LcFfaUgZCQzHXduKebDQWtRY/jWwO?=
 =?us-ascii?Q?asNijlAemknnM6IGJEIdrNjmg5olMifPOzu3KYemSvAEdvKGniZP65Fp5lhn?=
 =?us-ascii?Q?ppTdBFo1AKVugxSNWy0P7vJsFfl5yEMYfePE5911rzzVF178RZczboqgcR5a?=
 =?us-ascii?Q?EJWCn+hPeecgwuagUq2t3PFCXK8urF+/6evh2W5j5MKkNSVqkQ8gzu5dC9wl?=
 =?us-ascii?Q?hvNIvF2AqUIi88mBEd/ourDlH5r64tA5LCNZzb+9ixtglVMuvyXRWU10P8lJ?=
 =?us-ascii?Q?WfOQfyz/J36ndfefxsPR/Rj0kdvxg7GcJBdMwQI0e3hly4OpGTZiMihxd13w?=
 =?us-ascii?Q?drxZbj2J942sctwba0Nj4R/px8rpUW3z75idW0alKCv+NfJh2oTP6qwmLAfs?=
 =?us-ascii?Q?UiVQiwUvazXaCL6XXFFGtPkIdaZJR+VZrzyqJQuMIuZHusBEXdtMzpDmzeoc?=
 =?us-ascii?Q?dgFGzqixjXAQctHSFni+JXRiRJ441PS8hw1OqJI+TvRXxq+VGSSEomUEVOap?=
 =?us-ascii?Q?xKXAIkjFACGMaxc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR13MB2365.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/eDhFskb/GO21rydUo/IThuJ6lTDzJEorXzXKaFvv+WAss8lYWd8XDjuW17L?=
 =?us-ascii?Q?uWx0oi15fI/diolbLEkR+UxNZtZVtwBoyjvnztfs6DV5hZY55IXPmsvnTM9W?=
 =?us-ascii?Q?NL/zkKPaqg+pdJGOsPEla8huFo+3Vw55di489ENwU5CQQ66qNnJsi/LkTsrZ?=
 =?us-ascii?Q?8OAzUi1XYw8bgNT0gjvUqbi9ovppmBxiOiyCwW9E+5abAsaNF0vnkM4TuUCi?=
 =?us-ascii?Q?n6rV3Qv4NkNsgPqakLvGe2LrV76Cv2x4lZggmxOy4MYEuQS1tLRzjh7TDCL1?=
 =?us-ascii?Q?RDqn6YL5A5W5wR0FREewfBOosm35BM5jifGtjb+3zaQlLMTP1Ho8wQCO7k0l?=
 =?us-ascii?Q?GaNHXM0AbcclCRgb8V5KxTd/RyEU8dQBkpnHnPlTenVM7XCWwXw9kzWZ/o6q?=
 =?us-ascii?Q?+fFNFfFMBRcw2IE5+hGoS02AQ+h7IAzwwOxns6PCgHswtTDKxpLMHNR2tioi?=
 =?us-ascii?Q?HubJ83tksYAs41UhlAnR1c6v518XgVSBlwD/xXMrVvIed+vifKlKruFlJmfR?=
 =?us-ascii?Q?FhEGgjhIrbmH7gs9PQei4SHzQfJ7YzofoTw5eodC8pqeNAEXn5s/3o8J445R?=
 =?us-ascii?Q?ZXoP1dStT/aHVw9PxLRmKnWQTKKgmLwdH5dM4V/ZQGXQZ0hHd9I9rDuJO7oz?=
 =?us-ascii?Q?oXthczJuJA0R9s3rt7ty0AUdLlCHZ56AWqkrCHGr0/h5ytx9G7pYrLf/NJCZ?=
 =?us-ascii?Q?ZBPrbewHT7e+TTyI5E0VEni2QvB8VE+Yj3U33ec4O0jOet0yl1nqUq8Ujgz9?=
 =?us-ascii?Q?/5+A72eE3EyBbvQaosnCOP23cmGKU/amGyGKKMTJOJZIlZNykbvPFwRHm+d+?=
 =?us-ascii?Q?1p+Rl7fYVgvt+MFKeVa+JF/bknmosHBYhywtfYIqnn1c9uWIFB4sAMBQYgjP?=
 =?us-ascii?Q?buGjp7tUUGdVE5CDRsSdVijmN4Bo6VT/E/aMIjXWg9GgESBruJIfKfE3bEes?=
 =?us-ascii?Q?QNbZkOaGf+05awM1e1YXnKioiF48jC2tblRT3zXDudK+h2kW0pNHOaMPxeKU?=
 =?us-ascii?Q?2k+PgQ/ZjrlEUKUXeki69G3xSoaZtMTBofmoWlveXDfETYhtZhuZjAN6QouL?=
 =?us-ascii?Q?i8Qkv1YV1G9ibItpRnuqOVACrz0o4ac+iKnHrCoxy0lopzhPmISBIo7Gq5WQ?=
 =?us-ascii?Q?pEOkrTHrhmkRCLgePMiJLCnzJBbNQyua/8F/GzyQx0vVelyxAiHeydCSmtCS?=
 =?us-ascii?Q?hlcEgRMjSKN5cXM3CboUbhdUxR5SA8yP99YswpsiISm1Wi87NiVNInclEZPl?=
 =?us-ascii?Q?z4NxVgDAPY2pqytk9qmPRs9R3gXKuQU+zPZMTxkCp8ZVjqayALB7MqT+qaQq?=
 =?us-ascii?Q?NAqir89+Yhe9Ix4hLme3Ze38qPowx/nSaBo87ilZhPdIScydy/8FvjmtDr6E?=
 =?us-ascii?Q?Mv0Wojnu1WogRR6xgAz02cua4CxU48GUWY0yyYjA2Hjo4zwU4gEdpHXTw4Ul?=
 =?us-ascii?Q?ZVOZyUa+e/GhnLAFxBMcHLyWbWafGX/KJvDDLXE33FuWmDJfWwMRGZfMg+cA?=
 =?us-ascii?Q?F0SDSXSABvzHpX6MZ6McksRSbSufg32nrnljOtCFCQVLzj0ihd+X9ED9bBWH?=
 =?us-ascii?Q?SctukGZ6l4pJXGEPS//g2MBVK49BVqrXM5JQaNOkliUgFgspEly4ja9iuuPq?=
 =?us-ascii?Q?3w=3D=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e10114f-85fc-4af8-dbd0-08de284d8f8a
X-MS-Exchange-CrossTenant-AuthSource: SN6PR13MB2365.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 15:57:52.0947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hfPyARjXaSI+WNGzpjzjZ/uFwbESsQzMzrzGSLX+EQj9/8HupEiq2dP4KLVju9eNPOdmehw3xsqLsY9KE5o1XJs7RAnerdDDXhhD462aKvg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR13MB7319

We have workloads that will benefit from allowing knfsd to use atomic_open()
in the open/create path.  There are two benefits; the first is the original
matter of correctness: when knfsd must perform both vfs_create() and
vfs_open() in series there can be races or error results that cause the
caller to receive unexpected results.  The second benefit is that for some
network filesystems, we can reduce the number of remote round-trip
operations by using a single atomic_open() path which provides a performance
benefit.

I've implemented this with the simplest possible change - by modifying
dentry_create() which has a single user: knfsd.  The changes cause us to
insert ourselves part-way into the previously closed/static atomic_open()
path, so I expect VFS folks to have some good ideas about potentially
superior approaches.

Previous work on commit fb70bf124b05 ("NFSD: Instantiate a struct file when
creating a regular NFSv4 file") addressed most of the atomicity issues, but
there are still a few gaps on network filesystems.

The problem was noticed on a test that did open O_CREAT with mode 0 which
will succeed in creating the file but will return -EACCES from vfs_open() -
this specific test is mentioned in 3/3 description.

Also, Trond notes that independently of the permissions issues, atomic_open
also solves races in open(O_CREAT|O_TRUNC). The NFS client now uses it for
both NFSv4 and NFSv3 for that reason.  See commit 7c6c5249f061 "NFS: add
atomic_open for NFSv3 to handle O_TRUNC correctly."

Changes on this v2:
	- R-b thanks to Jeff Layton
	- improvements to patch descriptions thanks to Chuck Lever, Neil
  Brown, and Trond Myklebust
	- improvements to dentry_create()'s doc comment to clarify dentry
  handling thanks to Mike Snitzer

Thanks for any additional comment and critique.

Benjamin Coddington (3):
  VFS: move dentry_create() from fs/open.c to fs/namei.c
  VFS: Prepare atomic_open() for dentry_create()
  VFS/knfsd: Teach dentry_create() to use atomic_open()

 fs/namei.c         | 87 ++++++++++++++++++++++++++++++++++++++++++----
 fs/nfsd/nfs4proc.c |  8 +++--
 fs/open.c          | 41 ----------------------
 include/linux/fs.h |  2 +-
 4 files changed, 86 insertions(+), 52 deletions(-)

-- 
2.50.1


