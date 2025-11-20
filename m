Return-Path: <linux-fsdevel+bounces-69248-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B29C752F4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 16:58:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 9DF523115C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 15:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A430B34EF1D;
	Thu, 20 Nov 2025 15:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="gAbZeI27"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11021073.outbound.protection.outlook.com [52.101.52.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0AD2FBE17;
	Thu, 20 Nov 2025 15:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763654282; cv=fail; b=n9RwDwftfChs6xsiF37MRdyfpA991E4e34f6X+3gQ3SNj+WKZic+zSfe6vzDS+00+8nw1oGvSQr+YHFUKInx6avctxLOMMKJEVRDi/31rl5apA+u9ZCOjs9Tsioyz9xKJuZkWKUlJvXSaLqUPaT7XN5mSolDPawbfpQr0v1Anac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763654282; c=relaxed/simple;
	bh=H21omN6K9njdM5Ic9L6SfDteYW5bYiW8oELpFfd1Vuc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P3NqWU1RLayq7M+r1roIWiWyv6pGJcDjyKqWKZXPySUqwIbzrVs0Z+AIMm93GFXA0y9bsiWrVGR+XKILGbAp6Mpbfhlyt7+qO3tWBW5f67lPTXHFDRfST0ohW3HHyXJbBlEkpOM6qGQiu/vp6UpAC/zn8O6wh5yJZZRqweXSF+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=gAbZeI27; arc=fail smtp.client-ip=52.101.52.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jVEZTedUBzVWBiYu7GrAW1oaT1QKo/lNGQ9kt5jREdA9oIOY7dwwCOLUrIv25Vog3ogmJYmut1k7xiZEhs5DmkgLqN04b0Gu1xI1wgx9m1wTbjUfEE/amMGAXy4nEtW0f4aTzy96ayBgWyxIv02zMQcs1sVs166tDzgmgab0IPt7aGOxcfgIqfWGqiQaIVsHj3N1bCh/3Qu+qMXazr+jbgzCVq53HK5y2cCQSqPc8oWMy3ILEYFA4PH1ljYjivAiu1TLtibaMqg6w/eiL+QAEcz1C+YkzSV9gRZCxW2PZm56BhUT5MZonvkewMKvLomF4bh6tjPSUqACJGyQx81BEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T+aym8iI0I5uE1aOh9OsZb9dM1e81uAhJSYWlC2qn7c=;
 b=JgpupnPUtqYIahrZ59PnHmbDTCQb19kLpEZrFzfe6QzC1Rxs8zghNGbwZVuV2H9OwEp3SxLIzxdcuNLIJEgjwSG0W4eM1r4+yXbKztiCrpP0x27M7n/03z5oa8V5io6vJ5EkB2llwd3s55cUwSb3p7g1Fi1LIyUmYcc7zk4zCTpPMyTgwUlL5tNxMIrNPwQDbiIrumjxQBoyqaNVQJkimd0OFnQE+4xQQdTpepkwEsj1evl8eFq3VWNNlR1+Z/KutoF2Ybo7z37GJXDVKOZoYNCVPilpJdATPUgiXn+1/mjbzARcGJRVOo5GMXGlD2LIKiVe13RKCkZWG+bDR35Txw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T+aym8iI0I5uE1aOh9OsZb9dM1e81uAhJSYWlC2qn7c=;
 b=gAbZeI27VuCvtGKUpzelXLN1d3kFFw1Cr+/Y4ZWMk3BeAajF0tmW2T4CUtSinz9PzUC4w/3k/hgxr9rRHp6m5TLqgrdB/my9OyVyXWc2p8fSTsumjXd/HqqWr4JT7wwwtareZ4V/yEO9xrYRMGV5856tc4cv383Sm8VjTaR2rYc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from SN6PR13MB2365.namprd13.prod.outlook.com (2603:10b6:805:5a::14)
 by SA5PR13MB7587.namprd13.prod.outlook.com (2603:10b6:806:47d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Thu, 20 Nov
 2025 15:57:55 +0000
Received: from SN6PR13MB2365.namprd13.prod.outlook.com
 ([fe80::9127:c65a:b5c5:a9d]) by SN6PR13MB2365.namprd13.prod.outlook.com
 ([fe80::9127:c65a:b5c5:a9d%7]) with mapi id 15.20.9343.009; Thu, 20 Nov 2025
 15:57:55 +0000
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
Subject: [PATCH v2 2/3] VFS: Prepare atomic_open() for dentry_create()
Date: Thu, 20 Nov 2025 10:57:47 -0500
Message-ID: <ec24d02be163047b250e8487cb74248b44ee9979.1763653605.git.bcodding@hammerspace.com>
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
X-MS-Office365-Filtering-Correlation-Id: db42d8f1-4b7b-491f-85d4-08de284d91c6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zHDw6ff43kMSrJz2KWIHJp4oHUgRg+ZKNZeQWUtIMOhBd+xpckblplPwwwEP?=
 =?us-ascii?Q?hNGPndus7Tib4NgqMB3qs0F2fs/LU1WImL6QqvR7fNKjWf83BCyVOjk9kC7R?=
 =?us-ascii?Q?eaPJ6yzCF0VN1AGa+cepma2Hcbqmu/f1h2YnXFU4kMcLF1tYApe2b81a/IBO?=
 =?us-ascii?Q?PQAigL5GuqQzdGtw9pKXGNiontLOGDtwAK6Jf0+Vpf5pCXJ6tBhUcN9F4/F1?=
 =?us-ascii?Q?FsPfh/+OreBRAgTl94waF+29Nd0uM+yZIgHerHQZj8KqvgX7zNKD0Mn+8CQH?=
 =?us-ascii?Q?uVajRh7PEBHTGM7DI1I/mefRkF1cV3jWn4JZY7rk297mdzKdFcTfSU5/oQIb?=
 =?us-ascii?Q?jQZ7Afy6yPZXWkKe8lzB8/BCI2cE5P01c6E4RgKl0AN3TlIbIlq1g8m+ua95?=
 =?us-ascii?Q?ZPu/XDi8UMQoo4VpUsqCaCxS4xs1pimMrGoT9tqgvxiBjOP+BoTAoltx2EeJ?=
 =?us-ascii?Q?996ybOE8jzqaYzsada8EfkL524xc85d03f1xqyhjlHEOrIU6u+tbKfgWgw+p?=
 =?us-ascii?Q?1GcWGK96GNa/Humfqex2PW7G+cE1b7eY/ySA02GJQVp+B3BajyB6crh+nwhi?=
 =?us-ascii?Q?afNhiCfmioyIl9hIKN9RAv6C/MtnxBtA0RI5vczYmxAHcVIZahxRDfnJjcD5?=
 =?us-ascii?Q?p1VRNeTsjRVKGni/jzwAHG4Uav/H1Bdid2Z0T6wkuVyM/cmB+aEyl5umYbvg?=
 =?us-ascii?Q?hylcQXR0tjvlGmUFmaH2IERRs70TnGkJl7TPiiaS3TkX71SGH8Y3NT/lEkL3?=
 =?us-ascii?Q?ee5dbcx8QxVKKX/TUhlOEl5wS4dcIFQh/lNTqlfjY+BeUoq9ysok2HW7db3N?=
 =?us-ascii?Q?jAUzjgHz6emjOf113f0gAeCN2r7xFlihTte59pXlNnnajIvg1OnFjoJIfl4E?=
 =?us-ascii?Q?BGkT+5Z0fof6uB6hQpvPgvsiKkD+YhJn77q4qK0lddzXQ4b33R2WJpBaLIH1?=
 =?us-ascii?Q?UexPV2TPzhmYKEziPC27SYjJBLHcjDngoiiI+5KiATEXIVHX6YuY2J/VeJYH?=
 =?us-ascii?Q?ZGcXcWCOs+LyY4ha733wQAMeBueso+7BNqnyblEF+kDcgrtvpQmPdyRR1vJ4?=
 =?us-ascii?Q?R9JPf6ZkeGkmAlyerJWaQEB4oHTgZVvzbJKbkfqs6TZtXKOFh83mSQQXlN6V?=
 =?us-ascii?Q?ut3Hn0y8ZmABdIxD1j50iVv9C+ixxJKQOPWGVoCz4UIqpM5uMd+Vhnnmq5mx?=
 =?us-ascii?Q?aRe2TUWh0TTNyWZkl5hinckwWHs84XrNrpFpiuRmSxczNbJKHf6DdLogPPJZ?=
 =?us-ascii?Q?2rUiP23xxvx5bk6XlHGGGX3reLakWDSCOW/THAoZ9Do19tlUHfM8q5AiIV2J?=
 =?us-ascii?Q?3aPYO5TYBRGSJh0J9Uh76tCJfV/cn/Z+8yGN49yvmL8kGz3MBk4UQaKvGPGs?=
 =?us-ascii?Q?li5OUEjk7GQzcsjZA3bu3JrrhZai3hc7IvNsr97W+jJDo0lWCF3dwO9xZr+z?=
 =?us-ascii?Q?P0yLqyjCIm9XJ0hc28b4LSQecAjo+JKeSzbbutYaTrXd0UgzpzBMgsfkGGcp?=
 =?us-ascii?Q?lnbglMAOK01O9TA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR13MB2365.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Y5gJ1HQeQzEA9+gGZpcwJjyeXwtZweGsM/YnobI6lv12ekXwZhthE9fyh0ci?=
 =?us-ascii?Q?OqkPtdRFsHS/aDfLWG358/gAFQenNVfBlICWRtxoQ29XpzO1A9RTIZYyyzzB?=
 =?us-ascii?Q?wduMdIsnlw6ODOHAIH1fmvWS+tEdxTdfCU1cfrilg2R/TWPPaMVx3KqOovtM?=
 =?us-ascii?Q?/HxWaERdfrCxq1dEnGNOEXyt6aW/C6vQB6a9l2UqN0wA2HyOoHAjpcP8TR4D?=
 =?us-ascii?Q?U/mySCRagclJ6oxwUrk4YG9U0nNEidEgN6WMwarZyu57jm6PXR8tzHI65N1y?=
 =?us-ascii?Q?MHUMsTCa1vNLdneWZfESZBAJ07Oh66/bUqxTMnAX6pkNZpzOc2EpSeWfcr3T?=
 =?us-ascii?Q?3mXBMZfjxcayhUY6QxEIRW6biS+IrQ69mzUREoZ6KfVtbrwjGzafTj2wgOBP?=
 =?us-ascii?Q?gN7MkRFF7iCBpRXhW0CmHHu3tmQPF/4/QDhqQcNh5tCejWdt6oZwQJUljGfQ?=
 =?us-ascii?Q?att9emNS0C6CMNwbjoI9+go3B2fktjFCC2gsunRjN+O2e6JhOmgxCBkHbK7R?=
 =?us-ascii?Q?xG0AHiVnlTa4QIJBW/eEZ8XNNioAqPdu8r76Gl1wOc+AgJMf2ktsteRZ6quD?=
 =?us-ascii?Q?rsayLDhv4QZBNqSnSdqGlrP48z5MwwYWZuHVPtMt1xy7ot+X07vYbBwfw5Yv?=
 =?us-ascii?Q?zL+JQ6ig6H9C6KAJUdHO2jDsMQLHMNKewIT1SEsEkpvoji9AreMFQn3i5mrq?=
 =?us-ascii?Q?Uez6MEzQWQVTz2+TZherLZeklXIug5WKkYi27RzNfs7jJ+90pTfkTMFe1tbt?=
 =?us-ascii?Q?hVjEXma/FSC2XZxjy3Tst13aWPOARGGTEkq93PGb5bXgYWahMsm8D0tZGsLh?=
 =?us-ascii?Q?bydm55dZ5lbRJF4YqwV4aoHf4O/jzBWY1JyeUaCu6uouYeeYT+u1WsQbjtrz?=
 =?us-ascii?Q?Md1wXX2CQtT8mgbruzSD7YoDaXWYJGk24/9FN1L2sQwPnxDomUGCkpSiikqZ?=
 =?us-ascii?Q?eciCMDwzb5uMIAAgR/+oYJKj+nyfEvFQMoMUC2ssz9jHcjkzxwhBuS0qnic8?=
 =?us-ascii?Q?nx1V47tXc3nBNWJuitqPbw4bOJjEo6jNpnr0Q1y3tbCpIxy5g+6+kAr/89qF?=
 =?us-ascii?Q?n8XwYxy67bePwpVCGmmQEJb/W8ONsMxuAwRBjThjc/CTHtzkjjc2OCvbJd/H?=
 =?us-ascii?Q?c9PZs8qmUQTL9OH/D3GQ//hhFMr3827Vomm3HEj5b6cONj6SSgGpS9LB0HPt?=
 =?us-ascii?Q?STcp4licKwDuH6afyBDOu33bhf9J3hCYaJf03puUoVMavq+DRe6xQgak5M/A?=
 =?us-ascii?Q?so/73TOffWL4HPwIgKhDlbzLo7oLt/SDJMDfWxSBCZGIBwBZfKUQamgBKG1j?=
 =?us-ascii?Q?I9rxYamMar6jrqIN5uJppQ7q35CASdXcABD3PfGe35RvOz8rKDLzMhUX8qoY?=
 =?us-ascii?Q?aGa9GCXylDuKUImL52GmZNO4VnZH2M4ubbjpsX7ZDI/vQyKAl3WUPtycJMmO?=
 =?us-ascii?Q?BoEg2HZVngSGhf9pvysJ/zhOUe//LM+KeBRF38g1EjGDkyo3ny0/4MlL7cj1?=
 =?us-ascii?Q?uYCg9fBejJ1Nh5X07rxtpC2X8dWsX3RZrxPOLFbg/ZlpsA63XLIuJaMFaHWZ?=
 =?us-ascii?Q?K25OLooQg0K0QM2DKW47UMv7OLjGusPrtUQdPY8c2VsfGBlpPjg/VcatqnVY?=
 =?us-ascii?Q?Lg=3D=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db42d8f1-4b7b-491f-85d4-08de284d91c6
X-MS-Exchange-CrossTenant-AuthSource: SN6PR13MB2365.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 15:57:55.7730
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dZfiysZLShS0hgsq8cC+E0yGZiF8br0h7Qz6P6l/GXt6d0P+dAkJMQprqFPAdGqZdIQJlJJMc7TZC0+fa4+qzzglFt6lvBuN8wH2AgjkBE0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PR13MB7587

The next patch allows dentry_create() to call atomic_open(), but it does
not have fabricated nameidata.  Let atomic_open() take a path instead.

Since atomic_open() currently takes a nameidata of which it only uses the
path and the flags, and flags are only used to update open_flags, then the
flag update can happen before calling atomic_open(). Then, only the path
needs be passed to atomic_open() rather than the whole nameidata.  This
makes it easier for dentry_create() To call atomic_open().

Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
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


