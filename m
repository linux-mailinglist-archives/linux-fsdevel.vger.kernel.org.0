Return-Path: <linux-fsdevel+bounces-51740-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D6BADAFB4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 14:04:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E6BC3AA747
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 12:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D096B2DF3E8;
	Mon, 16 Jun 2025 11:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="X+kN5gdI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2076.outbound.protection.outlook.com [40.107.236.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9AE2ED862;
	Mon, 16 Jun 2025 11:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750075171; cv=fail; b=k/LDMV3CfoIqGK4nWLKuKb07ze8q14lQbnLdzs3FXshBkdkcjx6eujMLm2BC38I2Y0sTjB60nfNYMib2R2ATtaewpCjeztGkXp/axtx7StriK6J3z/clvfmb8Gb2xxWWrznObfQ6oqMvlyan3JKHuIi1Bsc3mXD7UZ+wpDGCgWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750075171; c=relaxed/simple;
	bh=BE6jsO6MSowvS46JLkycJq6EX/VNHCz3f3Mcjt54sAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uVa5YHZ+qfBbBDIReid1wOLQDhXobQUUQtA+nS7JjobgJjkbRVADl+57lrIg+Ad6n7xpzagfXJTIvf5NxZdbZjn8laZ4MuDJmirZnUp5fvEvUuKTNbviswyvKoo/ijeM2NcoQZiPxs3t/ZeB8tvksoLJ+XcZX0pKLf7t2t2LPr8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=X+kN5gdI; arc=fail smtp.client-ip=40.107.236.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fT9BlpXZloZbeEoFJMAZA8fulX0LCda2F3Fh2Bzp42Gr7atiNXrmSK8IbT8fAbHziAAw7+16PCYFSP8yfbeiL+iSop87A6Bo7kBsJPDuBR+Qzhubuu+DCJ7OV1TBpCxtQ3VtcOfhmKaIKZl55e7Ds0U7NlV2SnCjS2wLYxkSV2EmCmSqet/AOh20js6m4TLdqO2imxmftnllL1hT84Gj8brq/2QYvO5Ci/ywu3TPR/mxCefDx++7N8az9y68A06uYNKmUWQqd6J9NB41BlryDVrXjwQ32iWNSZSiI2xK+T3zzcQlcWHQKFA6PVr6MVfs3f6z+q5q73FBWUMNek2osg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=edsvNyPONjNcsEF/H93JUHN4et34ZSFlpbM7WDc7qjU=;
 b=oORxGf7BKRmJMDLn3fcnZQ6kK6VtoHlpq+r25OWsI60w9uYmiRitZCAhcmEh3C+DjfdoBe6av1yerw3OAybyFSsswfaoDuvBfDyTQfRj5QdyGyedgp/3ISjf21JfYf1jHP3eKM9kjUiqrLtFNv6wCAQJAVY19XEuRYi/BSMVkdEuJ9GqwvPplh2wJPMXZ+yRpOb1Y1pjqb8AeDIB9+Gwam5jnhdbaNlnXKJnMmzD5OGG+fvnTpBiPNzYrqRf6Bgw70OT5D47p29DGOgR85lm8ZSk7GjkF5aQwRA6L1CoZEj9EmLPT6DoVZxk1lM2xfnyGBspiMcjsnBTOLEdvoPP/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=edsvNyPONjNcsEF/H93JUHN4et34ZSFlpbM7WDc7qjU=;
 b=X+kN5gdILaFgl+IqWN8+V5KPtsilNTUASZr+UjIxLbSbOI4HbfNNDaz+RH9zpYDTovGBv2CcO1iKh4o8BgEnxggTV4+E0GAdPVXFoGGBBCtb0yXXOd36S58CDKkya5rIlYZog//NwbONWWj43O1n47x9buylalP9G2Xb5ctFkXDNB5WJIUdmcw+24vdX+RdvCJTdYeXIig2JVOnEyr9YEOaDZAq651lRgTm2J6gW7dYIYjDA1TRcTPPNuhT5NnS5TQMo5no4k4p3gGiAROy1LHTSK13CR59lzUFQ9s7sqFZ+KF1O1JuhmnF4W7PlklqcRovoTSCPFD8NLx4KMQbrog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB7705.namprd12.prod.outlook.com (2603:10b6:930:84::9)
 by SA3PR12MB7878.namprd12.prod.outlook.com (2603:10b6:806:31e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 16 Jun
 2025 11:59:26 +0000
Received: from CY8PR12MB7705.namprd12.prod.outlook.com
 ([fe80::4b06:5351:3db4:95f6]) by CY8PR12MB7705.namprd12.prod.outlook.com
 ([fe80::4b06:5351:3db4:95f6%5]) with mapi id 15.20.8835.026; Mon, 16 Jun 2025
 11:59:26 +0000
From: Alistair Popple <apopple@nvidia.com>
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	Alistair Popple <apopple@nvidia.com>,
	gerald.schaefer@linux.ibm.com,
	dan.j.williams@intel.com,
	jgg@ziepe.ca,
	willy@infradead.org,
	david@redhat.com,
	linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	jhubbard@nvidia.com,
	hch@lst.de,
	zhang.lyra@gmail.com,
	debug@rivosinc.com,
	bjorn@kernel.org,
	balbirs@nvidia.com,
	lorenzo.stoakes@oracle.com,
	linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-cxl@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	John@Groves.net,
	m.szyprowski@samsung.com
Subject: [PATCH v2 10/14] fs/dax: Remove FS_DAX_LIMITED config option
Date: Mon, 16 Jun 2025 21:58:12 +1000
Message-ID: <bbade6a3154d14d958f5f9cf65fd6424897ec9c2.1750075065.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.8d04615eb17b9e46fc0ae7402ca54b69e04b1043.1750075065.git-series.apopple@nvidia.com>
References: <cover.8d04615eb17b9e46fc0ae7402ca54b69e04b1043.1750075065.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY6PR01CA0140.ausprd01.prod.outlook.com
 (2603:10c6:10:1b9::15) To CY8PR12MB7705.namprd12.prod.outlook.com
 (2603:10b6:930:84::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7705:EE_|SA3PR12MB7878:EE_
X-MS-Office365-Filtering-Correlation-Id: 90e69060-0b9d-4a6e-3622-08ddaccd3dcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2/PJNohpKexGKZ87MfTulsAu5Gj96TK7Ean/7Zg2j5gfssEzNpovvVEJQ0Aq?=
 =?us-ascii?Q?nWMHBbF1Z88POzX/W0rcu8mnCWzIhkXJdo1EjgevVajXepy0fRNcrqpF/e/J?=
 =?us-ascii?Q?YjY/fT2n5dNn/lvWbC0zTtu34c0vTL/qLjRgCDvr5xEHryDgrA6DO8+6E2EF?=
 =?us-ascii?Q?WVNXIZnAiz818JobCLlyRWzFsft/wB0gCLDtnIUAREN+By0Gto/IIsHMPjmK?=
 =?us-ascii?Q?pc3N3nq+IOnksoIl5vEuc6XHuTN4CvgnJ4H3sv/jRNeV3m1/2VDcIZf6amBb?=
 =?us-ascii?Q?KTDKFhAqY8x6GszYGP3Y6WHb+0BrOhqfTvEOmhX/Jc3Mnj9uCsUvyJzkgWiJ?=
 =?us-ascii?Q?VkcKbhgPAcFixdVtdLVSp0adOlV11lw0nRP4Fq4aqPEUfhwSFnI0gdpJF9fk?=
 =?us-ascii?Q?ylbZV+XGIEcVdAh6NFGag+sClhXTYZ2PuFgmZUM5O5nZEM5jXhqZANbtMXwZ?=
 =?us-ascii?Q?jb+TFsetGBy+v79FYGMvp2sdgzfWIuqR7ZbwLeAngYlcwxjIH72YXCrr5Uei?=
 =?us-ascii?Q?FmkQX7dSxIGS4rbcvP2Bdfp1k9ccbGPUILa48Cdqrhy/wI44GuAevGv/pR+f?=
 =?us-ascii?Q?/HfCNRdIQmF7Stfheuzg16Gpt18GsHfUhlF5XjALZVq9uJsM9kO1WrtsmBTZ?=
 =?us-ascii?Q?Hlo3YYqhU2oE4S5ThjVt02A1xzC+0XpN2iLmwJYWOsRC9UfAIIBdRCHAtk5h?=
 =?us-ascii?Q?ougwxhGBMfRDVWsl77/N9SOz7+ia3R6gT78vUYOckdkUorYA+OajIDUccRBX?=
 =?us-ascii?Q?x9eH5/Xg4TtFp+OXWE0r8NOMY/E4C5U5Kf4A54tB6OG0mfOMMEW6Jkx1xyVB?=
 =?us-ascii?Q?1eHzdy/95GcnCgPzMUetLZWhnYRTITnvzzvTgG8uu9aQEWOH2cxh7Q3wPfXW?=
 =?us-ascii?Q?OAp9f6UqvKbLKhskN2DYt5SQFGpRS0i3WygS2R2biEgwZc9vrUK8lu1Ug8L9?=
 =?us-ascii?Q?MnrC1GrPW93yy0ijGQrWdotYyP313/7hq8LLqOZ8vdy+ovqCsYezrDaxTIqK?=
 =?us-ascii?Q?2VIJPvzkrO6exk4tqv0YX8ezdi287RW7jZc76tdtX0n3ysxOkIkgftxkIS97?=
 =?us-ascii?Q?ooO4z4TtEgMAgLuHR6LHio6tpP/NQ+by8M+7YHqz+taFOcy2yQkR44YByfyN?=
 =?us-ascii?Q?lcR0iE+w/kJdZ6Qyp7ASXzCsuS2TewWDGR4QxBdzo4WF7kIUlU4B/Lr1OZgm?=
 =?us-ascii?Q?tGKtIW6J3fREQKUjVDc7Ge3l96w2eX1iAxxNQVH4YeSLsSSwOmbTDVM6arK5?=
 =?us-ascii?Q?vxW1Lyp6/ABbB0iYasaCfY6ha1pYBwdvQp/XabsechhhRzV1JyxXds9D+Mlf?=
 =?us-ascii?Q?CQmuRs1T/OhbWQfXLwaZHbChD9Fa/2vCTVSwF7jH6bTOErTPSZvEE+5Zt3JK?=
 =?us-ascii?Q?LBmf6zIB4Qr2hVTi6dytEDLjqUWqMKYdPZXBKLgTigS/ZfnPFA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7705.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/codIgEq2ftPz8I33nwtaRKY2DxTt0HXyK35It4cOjCiK8dQWGepwznM8sbX?=
 =?us-ascii?Q?/LOJQvP0+Y8Qy762h79AYG+mdZA2KG+mbAAxLt2yh0m1KbUkez2X2LhXtmiu?=
 =?us-ascii?Q?Gjszsx3wzARKXn+Gc1+KhDiotvEd8kcGXvji4wJjbj/+BYGMyCGUzA9+eq+M?=
 =?us-ascii?Q?EQ/Fv3X8vVe/4MhZnBQyyYzi3oozy7KHjAUB8Q+sYX2/jUV5KV5SDdsB8+TE?=
 =?us-ascii?Q?a5A7IrAVcmdiEIWWGyzgNKZO+2naXPZYrlCNA25g96CBT0li+BbtUyVnjWy+?=
 =?us-ascii?Q?bo3WBSnpL3oeTD/qLLtUQWwK7LrsAB5Udh3rTtrV2ZRH6gzf2YtzB11Rsf7o?=
 =?us-ascii?Q?iVpF6owshqOiDAjOSSAXTe+d41/qClC/FAgd056pGYTxg1oOLFsFnh7XO43p?=
 =?us-ascii?Q?8vjcNsvovRN+S4aXRgqTZ37Wx220H1MKY4NNoHdVeCKZBCfw8SBbDUf71fJ1?=
 =?us-ascii?Q?0zvuP5dEXVtn4GnyAeeLz7KyswSeHyerbqTCLqzjbMr8xFmSG++NrikdIHcI?=
 =?us-ascii?Q?zwwo2Asl7ElD6wIMIw7Zc4qSpErm3GY6PFva6UjJGJDfBppvS/+Ntilg4J1P?=
 =?us-ascii?Q?1Lpd2yJm42ebuaCxLjDvSY9brhrDyr0YG5s4hBTVI2U1eOIHyDPy5MS+UVsh?=
 =?us-ascii?Q?Kd+PlF/MOmGFISaws/igaqzbrSYXTfqcKw8gBXsfrGzoD2BLPKQL6K9MhTSi?=
 =?us-ascii?Q?u405ttPneqXO+mmct//5mkvPQsdBf/9kgHsFovBvlaG/cwRXzyPD0Zsy2VQV?=
 =?us-ascii?Q?PAVBKCMxcBX39k2w/9+e5tf9CTIPs76umrmKzNXHLx6DKUt5Oty+zFrXBTfC?=
 =?us-ascii?Q?YNokK5pas2tcj/+TMgxhBts4TLfimc75xpBJkJHTjcOfuPADJ8Pf91cjrgjh?=
 =?us-ascii?Q?IOMPxofQ4LGJqhpEHErCq8caNRre2dAEPpAVr13fYjL3xOiEmjTPa1SqgdvJ?=
 =?us-ascii?Q?KIgE2Zj2XOYvCA2A1gAbcAfSdmxExhxx63Lu1oIYgAnJg2DNS1LpFvV2pk7N?=
 =?us-ascii?Q?hicUdrSTuiCCkUx2QdgM+zsIEWYFy87eDhylBnFY07cEOUpjmTiRO5/fbczT?=
 =?us-ascii?Q?jdf2ln+l1p0KHIlBPrLcOuVCx2m5hzfTXj2KZGH/nh0J8YSFkVCvuRKLydWz?=
 =?us-ascii?Q?i1HXj4gzI6bHojFN3kCHnkTh3qz4FlRL5fbmWY5sQPswp0PCWBqaablyiZyZ?=
 =?us-ascii?Q?jYgRH+a6iqOhyNBGjYqF9UdN+KNj5dZpGMLzlIwy2HTN4ulpYp53zCl/1ldp?=
 =?us-ascii?Q?lqV5POSjNvoohgE+TkFUTBF9xQvzz5zfqYDYIk7vZ4buQMzqCp44fOvlhWkj?=
 =?us-ascii?Q?9QeG7c48WMUYkgKXTyqYf/kaXCxl9N7WT0DyNckDw+DIDbK6DH/3aiTZeXJD?=
 =?us-ascii?Q?ei7LmmT18Kvp46Zi+smb3qWsVFq5fFYD+GeTOuMu1S6daNxZosrAIpAb0C73?=
 =?us-ascii?Q?yH35ci3MaJQeFHzGix1BSFcddncQTmusa4nNFb3ERrWR5KsRYz3NDPcFmDst?=
 =?us-ascii?Q?FGEMKarTojdNnqIy+GABt3Aa7jItYFyXOBGRNhE0t4lUY0SGvB+pb58z9TMt?=
 =?us-ascii?Q?HB85NkJiW3E47rQOBxjFfH+olOsZJZpVAFsbW78i?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90e69060-0b9d-4a6e-3622-08ddaccd3dcd
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7705.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 11:59:26.5308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +GCVo1TMssNi9Bvf/Ryd/0NWjJeQiIQzZTIXk90YSULt6C7ucTRQk8BaAEG59CzepWjkRLyaXJo8v5DYZEgKvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7878

The dcssblk driver was the last user of FS_DAX_LIMITED. That was marked
broken by 653d7825c149 ("dcssblk: mark DAX broken, remove FS_DAX_LIMITED
support") to allow removal of PFN_SPECIAL. However the FS_DAX_LIMITED
config option itself was not removed, so do that now.

Signed-off-by: Alistair Popple <apopple@nvidia.com>

---

Changes since v1:

 - New for v2.
---
 fs/Kconfig    |  9 +--------
 fs/dax.c      | 12 ------------
 mm/memremap.c |  4 ----
 3 files changed, 1 insertion(+), 24 deletions(-)

diff --git a/fs/Kconfig b/fs/Kconfig
index 44b6cdd..ccdf371 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -59,7 +59,7 @@ endif # BLOCK
 config FS_DAX
 	bool "File system based Direct Access (DAX) support"
 	depends on MMU
-	depends on ZONE_DEVICE || FS_DAX_LIMITED
+	depends on ZONE_DEVICE
 	select FS_IOMAP
 	select DAX
 	help
@@ -95,13 +95,6 @@ config FS_DAX_PMD
 	depends on ZONE_DEVICE
 	depends on TRANSPARENT_HUGEPAGE
 
-# Selected by DAX drivers that do not expect filesystem DAX to support
-# get_user_pages() of DAX mappings. I.e. "limited" indicates no support
-# for fork() of processes with MAP_SHARED mappings or support for
-# direct-I/O to a DAX mapping.
-config FS_DAX_LIMITED
-	bool
-
 # Posix ACL utility routines
 #
 # Note: Posix ACLs can be implemented without these helpers.  Never use
diff --git a/fs/dax.c b/fs/dax.c
index 7d4ecb9..f4ffb69 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -449,9 +449,6 @@ static void dax_associate_entry(void *entry, struct address_space *mapping,
 	if (dax_is_zero_entry(entry) || dax_is_empty_entry(entry))
 		return;
 
-	if (IS_ENABLED(CONFIG_FS_DAX_LIMITED))
-		return;
-
 	index = linear_page_index(vma, address & ~(size - 1));
 	if (shared && (folio->mapping || dax_folio_is_shared(folio))) {
 		if (folio->mapping)
@@ -474,9 +471,6 @@ static void dax_disassociate_entry(void *entry, struct address_space *mapping,
 {
 	struct folio *folio = dax_to_folio(entry);
 
-	if (IS_ENABLED(CONFIG_FS_DAX_LIMITED))
-		return;
-
 	if (dax_is_zero_entry(entry) || dax_is_empty_entry(entry))
 		return;
 
@@ -768,12 +762,6 @@ struct page *dax_layout_busy_page_range(struct address_space *mapping,
 	pgoff_t end_idx;
 	XA_STATE(xas, &mapping->i_pages, start_idx);
 
-	/*
-	 * In the 'limited' case get_user_pages() for dax is disabled.
-	 */
-	if (IS_ENABLED(CONFIG_FS_DAX_LIMITED))
-		return NULL;
-
 	if (!dax_mapping(mapping))
 		return NULL;
 
diff --git a/mm/memremap.c b/mm/memremap.c
index c417c84..c17e0a6 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -332,10 +332,6 @@ void *memremap_pages(struct dev_pagemap *pgmap, int nid)
 		}
 		break;
 	case MEMORY_DEVICE_FS_DAX:
-		if (IS_ENABLED(CONFIG_FS_DAX_LIMITED)) {
-			WARN(1, "File system DAX not supported\n");
-			return ERR_PTR(-EINVAL);
-		}
 		params.pgprot = pgprot_decrypted(params.pgprot);
 		break;
 	case MEMORY_DEVICE_GENERIC:
-- 
git-series 0.9.1

