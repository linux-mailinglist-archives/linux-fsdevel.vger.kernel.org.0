Return-Path: <linux-fsdevel+bounces-42032-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D5A3A3B087
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 06:05:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80E783A7613
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 05:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594151B0F20;
	Wed, 19 Feb 2025 05:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VU7h5314"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2078.outbound.protection.outlook.com [40.107.236.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DB1199FBA;
	Wed, 19 Feb 2025 05:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739941518; cv=fail; b=Qhvyw5iCJh9wAO2y3GhF31LOcnH63AZvuPWLzQHpk6ODBqidlgmJldOdhSXo8ntO+8myddcyOTwuND6YZSEqtwQD2t66Wkapr/AwFNL5kjuS+Al/S0p7nd3c5jMX3RxHVt+yuNmLFFiWJytLOHNe6p5b1SdnxAU091yGYO1VtR8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739941518; c=relaxed/simple;
	bh=adrix3AyvOnmjPbfa1dSa0JRgtHYHWkJw9p1AHyYLcw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=cvUp/BR0tR434fmUBjdHkHWy0aQn8TE917+CvX9OG2EKoRlz57rCBbJjUkaVEOY5vets+PvIPyBE8OLqVHi5PD9nPF7yrHYeISeeWvE19W7Ri1XTXhLUYTAeO1tjgft1sKC/epSpfaWiumJvXdrnF0iAr979WTlOwqHgZKr+rT4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VU7h5314; arc=fail smtp.client-ip=40.107.236.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y4jS9Ij9oMF+p9HX7Qh3MGXgXuq9GVEPJDm40+l0V/JFTpI+XBneYfhfz2iIh1shxqz4Bq0rcIZSpc0s4JdsQgxxd6gCJHSMWLZQ4LOVlZTf6eSdYy/yyApgUqENy9hgLPFE8sG5mJh6/Ovd0Mh8zoZyKOl6eHcIXDpnyBqRXcKyDmclZi/XCICdRzhIdvpS62k6duaOsQi6GEXGWRIbjmIK3NM8vBbHXSKlpzJnpDnJfaNaV1spW3RCxWArn2o2MGVCyLPMstr1UpnlYHiPKYm6AkDVgpZ3Bh5pwiIgFWAUAyCyyppQoSwyrzPCOC85aJdNLGzv+XPs3roCLmTcMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=esVAOH93aULWVaOAGxVXmZxF26Og/DobGoFTYuc0UHY=;
 b=Opozo6meNIYW9LdkM2yM84wD52DnlocGP0/Qgs2qDjf+vL0B+EIvpwwj/Pibc9Y2HpMGYAuM5vrH5NXwxa/84emFUhYX50u4nhbQiXJD3SJromu3VRhtt0j+VrZ+/e9U6hki9D86LLP0gXbjJrn/DCiqN48bvv7AabbpxQKy4mM13Gjk8QVfgPZXp3OugbfedwYXIsTg6Ito9Kpzo7Dc17eE+90JP9JedvjO8oF7OBFmOSVcDvmfOHUe+VZjR3uO4hdstT0cLusupmTxHbSY+JRth2H/c70IJKUxjuTgJfn2RxdX2koy6EWBK2zqtWbwMtFpK0CXwZkFMgKRl7Sq9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=esVAOH93aULWVaOAGxVXmZxF26Og/DobGoFTYuc0UHY=;
 b=VU7h5314MQnpfqVIkksjPD+gEJImQC8Hz0f49WnGcy7iS0/feoHIKmrA/HhrCHivYZ4x90OsBIbtP3q5rPJq4LQxF4E13TWYQ8WCS0vBl/zYgMH7oWXvAm17EAl3f9fqY3xLO69YizNbpPaNejP1btAe8WzawKL/7EmRX6PQCkxmVT/poOsWHcqeaJzduxJoBq5u/bi4PckGTi+P+4o4yKvvBUHCb+S6tnIW2MmIR04w7OyzIyo6wtvNHqWDyJrhbotBjNIASqf7eKPw2afNUy03cV1nwf6Sagg8aJrpeFaKtSDcff4N/iTTltutej2ssScejek5DriJ01tu+zHk9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 SJ2PR12MB8875.namprd12.prod.outlook.com (2603:10b6:a03:543::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.14; Wed, 19 Feb
 2025 05:05:13 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%7]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 05:05:12 +0000
From: Alistair Popple <apopple@nvidia.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: Alistair Popple <apopple@nvidia.com>,
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
	balbirs@nvidia.com
Subject: [PATCH RFC v2 00/12] mm: Remove pXX_devmap page table bit and pfn_t type
Date: Wed, 19 Feb 2025 16:04:44 +1100
Message-ID: <cover.95ff0627bc727f2bae44bea4c00ad7a83fbbcfac.1739941374.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5PR01CA0091.ausprd01.prod.outlook.com
 (2603:10c6:10:207::8) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|SJ2PR12MB8875:EE_
X-MS-Office365-Filtering-Correlation-Id: 99426b2b-9f33-4a0d-8f23-08dd50a2fd6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ymhs0ClJXHBQMr6FSuztBRaXrPADf/ENQUEgjVTxYzfNPNW7EZwfqLKj0/D3?=
 =?us-ascii?Q?nu2M9vDf09B0CaTaB6WqpZZd//ocYNPTYXsbc2+hYSsU0rWjBIc9LlHDPGhI?=
 =?us-ascii?Q?YY9Wrz5C5oPORdKbRn6dyW4OTkotiEpWA9PYpyKq9Msm+H5R4uSTslytXHQd?=
 =?us-ascii?Q?seIk5AmegG3v/2ZgTNZDqa1p6rMLkb9ISvblLMa5z29wHCV75pD0+j/amIB5?=
 =?us-ascii?Q?AOnrfXDsSMThOTVWEyARflj2zTkGwCUQD+MlkKleQ1h3uNY9tG1xG/V+bDlT?=
 =?us-ascii?Q?+gtZlSTlMmmkCyrPQz1yxK+jveQBw7Y9j/ZcZAQIW6kb9pG6HopQ/ql0vowr?=
 =?us-ascii?Q?RPsh/lfbOrO0+HbFr6QR7TpGZqHjxr6MNQutx6AGLUlFfe+4YrBeWaTi2gX9?=
 =?us-ascii?Q?ClYIQvcOsRJem/3OdZcHVwPE6p/BImgC+66cNagp3IQkAmT+HKG4wYx+vVLL?=
 =?us-ascii?Q?q8Zl4GLJVOpQCtLEA1n/u8FCNOeqwpVluuxzBB/UZ44Qz9HTCPjoFGIlefPC?=
 =?us-ascii?Q?nloq1WoCu1XQz3IdQpippyg3JwShBP3p833zc4BEIXszi7OcmSTr1MwtL/9S?=
 =?us-ascii?Q?5jyHSr2hBt3SW6KGp4mVjkBEC+laU4nWlyhSauujoqgDjG2oujnFjcpbMQX1?=
 =?us-ascii?Q?i0AjjQsch1DfKO7nqMcRbUKnYoZCZp20ajSVhhUAfD9SflTGi7duA+3poMzN?=
 =?us-ascii?Q?I/ps38AmgZlXPxes3cdCxdk3dkMWt0C8ap3eGyoXbs1qhJNNnvDVb/qpfmkS?=
 =?us-ascii?Q?FhBoFZpCJCQ3slbtt6axvEQmAHa0SDyqoXgTAFD3ZQLadJGtAcfaS8WL4RcC?=
 =?us-ascii?Q?+nlh+6da8CAi81rkcc174ReIkAogDNPuQEao+903dfFd774WKDynKEFFnoxZ?=
 =?us-ascii?Q?XMD6+PWqtyujeW44uxMvrfhDl1kxFH24yg9w41KX+33E7G34GwyDsKEsfeyk?=
 =?us-ascii?Q?bLfd/4C8JKKmUgXFEVtSo+CN2+doLBKxQZYfMaUxC79yOhaytd+08obaMPCU?=
 =?us-ascii?Q?UN6cpoJ4O12PU7G/IZ+dpAVuIL7hGw09ZeAa/JMfIQZXPOk5hRKB/9uVo/hB?=
 =?us-ascii?Q?vVp+uNEQLLVO1VVmgLYnyel+ccDqhlG6P0KsLuzdgdRrRFpq0kMD0p+Xk6CE?=
 =?us-ascii?Q?hiIzwN+dEn1WLbgPQIRYUUc1U+RCs0WBJeeY1Vfq123Mq2mk3L06zF0I3HGo?=
 =?us-ascii?Q?qHzfgO7I2wj08k4vTn749PDTdf7KAJQMR+uwmWNgqZCIr4Rbd/ezvxAYjnbd?=
 =?us-ascii?Q?fbsd0ZZqAOGxhUZTCvzx3fulczdayFFAV6fku2NHw0YX8r+l7felqo1NXmZd?=
 =?us-ascii?Q?xoKK1R+tyDIpmI1DyPW32uXx2rnpXyBVLTwQBrVqMqJ0K04T1MQCudbyOX9/?=
 =?us-ascii?Q?NWrBYT6xgzOq452smEv4YKdmUSYg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JORL87su0lSQlGFWRbYczsWtGPv1992WWP+kKcxS+pBpYl/xOp3bG57Py+VA?=
 =?us-ascii?Q?xtAdrYfaYNxL5esHAPSUFeG45BT39XLwoOB1j3BWAYRf7+T79x8HDQp9P9y3?=
 =?us-ascii?Q?QLTnxAYAnjRcKxUgSOV/kRG19vrww7hSlIwfmf8NaFMjuTEQALF/kBFpnGQZ?=
 =?us-ascii?Q?LjzIS020E3x8zvuNRwCH1/dEmX41RXXcm3Dm3cH9yb2/YaNj/PwbkVutvtDI?=
 =?us-ascii?Q?o+QBMUP+a1x0is6xWaN933mRLdvxa3TKtffxpvdnj+iEOTEa2vBGhQ3wVog6?=
 =?us-ascii?Q?p8UY8pe7pUOsKBOztrcOSPqQBUMk+IpLztMLfSWIp2Wxa6sPQrirM4p0tjNG?=
 =?us-ascii?Q?TeDfdxDu+JISvnsGO/aZ9fSNc/85cH67HuGQDtWGeP3g8KV+26lXfvldD5Iv?=
 =?us-ascii?Q?bpqS6UEw1yAfOZunsLQ4zsdTP6ZNNcaVmy4ddlZtVYa7o2ygDm0vTOF1q+VX?=
 =?us-ascii?Q?WNYODxXFLo9B8sQb6Z3fIqUpdTf6xbRCFM/JKPkWTbPIHTH99W4xCfMG7EpP?=
 =?us-ascii?Q?H8AcKk+1PgendEH1vKUR7tpX6hh0MxWp0cRUtxctNQQbSdtee+5PxC5H3uat?=
 =?us-ascii?Q?YgHAvZ9/vpSsHk8Zo4B1xrhHLlnCaSL4cKt9JOnsNiSGW0gawf8OpvOiOlWW?=
 =?us-ascii?Q?1o5Rslkz53GmsvGla+lNgimjDhHSdzsRdKr3sZEkZie6CdNndZZux0FxpwY7?=
 =?us-ascii?Q?PGU3gbs5Xcs0H9J4CRIKuosEY/G1rAMpPjWFmwrwCseRXorZJI3ktWiyqvlt?=
 =?us-ascii?Q?DfrGv+FWtg5dVifiOdb9iiLV4m2ZgWpC7Rf7I9A0R5TROBaqXYntqSeBiptW?=
 =?us-ascii?Q?xP2XipGjl7PKO0fVJj03JNV3aNZw7W5k09FLazE89BSnDiUaVseTQiSjsQll?=
 =?us-ascii?Q?uevHb+/amSGEB9mWGW4uVxdxir9BrcFaRA51IaGEQUPRXmri2TVCqr06RDqA?=
 =?us-ascii?Q?p60o9gFXvMPsEsE9paek8K4WItNPvmf7MAUEui9+irzwuqwhSWOeisUAo1IX?=
 =?us-ascii?Q?jwJYxZrnUpZ01M33fHSme2547as9VuruVYRU/tDxHHHyxM+fOHCaClGRYxvv?=
 =?us-ascii?Q?SXilT3E6WcufkG8Esf+6XFcggiX9DLfoVKDkLv46MuR8VweTU4lQjcB2s1h0?=
 =?us-ascii?Q?EJcwdCPoZFeLRUnBFkNCZOuaiEvnI5PkBLm9AkTi9gA6LLxJTmcKiRgY6YHk?=
 =?us-ascii?Q?9WpM0l+iUy+UksmhAPmtkJxJ7uDknOOM5SK+b30aiM/JCrLxovm7dh/Zf+vS?=
 =?us-ascii?Q?6N+hwkBDtTbiLyfj0UtaF6zZJHzMK1sLilJmnaj0PegihZAjubugcrBb039r?=
 =?us-ascii?Q?fQCD5nvCDwkmf+8/QQp/RaKLSwvAjiKvd/Pq6i/t5iy+ZhyuepgWWlZBt+E0?=
 =?us-ascii?Q?v94mL0u3g2sMKf9vOVsGyYk8Ahtvyz4Dl7lSWQLvugfbfU7Y3SX8AwJMiwPI?=
 =?us-ascii?Q?Vxpu0g/FHuVmfOW/WeC4dXT7c0iyXy/LUzuMRsM5dB/+X608KLZUUq/Lro32?=
 =?us-ascii?Q?zot598ch34cg1x/CN0SEQo1helep781Uns0T7MQN4Hs7/ED75pEooQZgT/Kt?=
 =?us-ascii?Q?wOVT740r2Lc+K2la9ReKopxv9hQm7gMHOXbzFW6Q?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99426b2b-9f33-4a0d-8f23-08dd50a2fd6b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 05:05:12.6133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ymQ5eHZ20VrfWCqLbLChk/yFjn5HZjcIBMMtFMSUqn8v7SyiEbV9wyU27CiU3WJ0d1K6qViglX0PQUFYoILSCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8875

Changes for v2:

 - This is an update to my previous RFC[1] removing just pfn_t rebased
   on today's mm-unstable which includes my ZONE_DEVICE refcounting
   clean-up.

 - The removal of the devmap PTE bit and associated infrastructure was
   dropped from that series so I have rolled it into this series.

 - Logically this series makes sense to me, but the dropping of devmap
   is wide ranging and touches some areas I'm less familiar with so
   would definitely appreciate any review comments there.

[1] - https://lore.kernel.org/linux-mm/cover.a7cdeffaaa366a10c65e2e7544285059cc5d55a4.1736299058.git-series.apopple@nvidia.com/
[2] - https://lore.kernel.org/linux-mm/cover.a782e309b1328f961da88abddbbc48e5b4579021.1739850794.git-series.apopple@nvidia.com/

All users of dax now require a ZONE_DEVICE page which is properly
refcounted. This means there is no longer any need for the PFN_DEV, PFN_MAP
and PFN_SPECIAL flags. Furthermore the PFN_SG_CHAIN and PFN_SG_LAST flags
never appear to have been used. It is therefore possible to remove the
pfn_t type and replace any usage with raw pfns.

The remaining users of PFN_DEV have simply passed this to
vmf_insert_mixed() to create pte_devmap() mappings. It is unclear why this
was the case but presumably to ensure vm_normal_page() does not return
these pages. These users can be trivially converted to raw pfns and
creating a pXX_special() mapping to ensure vm_normal_page() still doesn't
return these pages.

Now that there are no users of PFN_DEV we can remove the devmap page table
bit and all associated functions and macros, freeing up a software page
table bit.

---

Cc: gerald.schaefer@linux.ibm.com
Cc: dan.j.williams@intel.com
Cc: jgg@ziepe.ca
Cc: willy@infradead.org
Cc: david@redhat.com
Cc: linux-kernel@vger.kernel.org
Cc: nvdimm@lists.linux.dev
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: linux-ext4@vger.kernel.org
Cc: linux-xfs@vger.kernel.org
Cc: jhubbard@nvidia.com
Cc: hch@lst.de
Cc: zhang.lyra@gmail.com
Cc: debug@rivosinc.com
Cc: bjorn@kernel.org
Cc: balbirs@nvidia.com

Alistair Popple (12):
  mm: Remove PFN_MAP, PFN_SG_CHAIN and PFN_SG_LAST
  mm: Convert pXd_devmap checks to vma_is_dax
  mm/pagewalk: Skip dax pages in pagewalk
  mm: Convert vmf_insert_mixed() from using pte_devmap to pte_special
  mm: Remove remaining uses of PFN_DEV
  mm/gup: Remove pXX_devmap usage from get_user_pages()
  mm: Remove redundant pXd_devmap calls
  mm/khugepaged: Remove redundant pmd_devmap() check
  powerpc: Remove checks for devmap pages and PMDs/PUDs
  mm: Remove devmap related functions and page table bits
  mm: Remove callers of pfn_t functionality
  mm/memremap: Remove unused devmap_managed_key

 Documentation/mm/arch_pgtable_helpers.rst     |   6 +-
 arch/arm64/Kconfig                            |   1 +-
 arch/arm64/include/asm/pgtable-prot.h         |   1 +-
 arch/arm64/include/asm/pgtable.h              |  24 +---
 arch/loongarch/Kconfig                        |   1 +-
 arch/loongarch/include/asm/pgtable-bits.h     |   6 +-
 arch/loongarch/include/asm/pgtable.h          |  19 +--
 arch/powerpc/Kconfig                          |   1 +-
 arch/powerpc/include/asm/book3s/64/hash-4k.h  |   6 +-
 arch/powerpc/include/asm/book3s/64/hash-64k.h |   7 +-
 arch/powerpc/include/asm/book3s/64/pgtable.h  |  53 +------
 arch/powerpc/include/asm/book3s/64/radix.h    |  14 +--
 arch/powerpc/mm/book3s64/hash_hugepage.c      |   2 +-
 arch/powerpc/mm/book3s64/hash_pgtable.c       |   3 +-
 arch/powerpc/mm/book3s64/hugetlbpage.c        |   2 +-
 arch/powerpc/mm/book3s64/pgtable.c            |  10 +-
 arch/powerpc/mm/book3s64/radix_pgtable.c      |   5 +-
 arch/powerpc/mm/pgtable.c                     |   2 +-
 arch/riscv/Kconfig                            |   1 +-
 arch/riscv/include/asm/pgtable-64.h           |  20 +--
 arch/riscv/include/asm/pgtable-bits.h         |   1 +-
 arch/riscv/include/asm/pgtable.h              |  17 +--
 arch/x86/Kconfig                              |   1 +-
 arch/x86/include/asm/pgtable.h                |  51 +------
 arch/x86/include/asm/pgtable_types.h          |   5 +-
 arch/x86/mm/pat/memtype.c                     |   6 +-
 drivers/dax/device.c                          |  23 +--
 drivers/dax/hmem/hmem.c                       |   1 +-
 drivers/dax/kmem.c                            |   1 +-
 drivers/dax/pmem.c                            |   1 +-
 drivers/dax/super.c                           |   3 +-
 drivers/gpu/drm/exynos/exynos_drm_gem.c       |   1 +-
 drivers/gpu/drm/gma500/fbdev.c                |   3 +-
 drivers/gpu/drm/i915/gem/i915_gem_mman.c      |   1 +-
 drivers/gpu/drm/msm/msm_gem.c                 |   1 +-
 drivers/gpu/drm/omapdrm/omap_gem.c            |   7 +-
 drivers/gpu/drm/v3d/v3d_bo.c                  |   1 +-
 drivers/md/dm-linear.c                        |   2 +-
 drivers/md/dm-log-writes.c                    |   2 +-
 drivers/md/dm-stripe.c                        |   2 +-
 drivers/md/dm-target.c                        |   2 +-
 drivers/md/dm-writecache.c                    |   9 +-
 drivers/md/dm.c                               |   2 +-
 drivers/nvdimm/pmem.c                         |   8 +-
 drivers/nvdimm/pmem.h                         |   4 +-
 drivers/s390/block/dcssblk.c                  |  10 +-
 drivers/vfio/pci/vfio_pci_core.c              |   7 +-
 fs/cramfs/inode.c                             |   5 +-
 fs/dax.c                                      |  55 ++----
 fs/ext4/file.c                                |   2 +-
 fs/fuse/dax.c                                 |   3 +-
 fs/fuse/virtio_fs.c                           |   5 +-
 fs/userfaultfd.c                              |   2 +-
 fs/xfs/xfs_file.c                             |   2 +-
 include/linux/dax.h                           |   9 +-
 include/linux/device-mapper.h                 |   2 +-
 include/linux/huge_mm.h                       |  19 +--
 include/linux/memremap.h                      |  11 +-
 include/linux/mm.h                            |  11 +-
 include/linux/pfn.h                           |   9 +-
 include/linux/pfn_t.h                         | 131 +---------------
 include/linux/pgtable.h                       |  25 +---
 include/trace/events/fs_dax.h                 |  12 +-
 mm/Kconfig                                    |   4 +-
 mm/debug_vm_pgtable.c                         |  60 +-------
 mm/gup.c                                      | 162 +-------------------
 mm/hmm.c                                      |  12 +-
 mm/huge_memory.c                              |  98 ++---------
 mm/khugepaged.c                               |   2 +-
 mm/madvise.c                                  |   8 +-
 mm/mapping_dirty_helpers.c                    |   4 +-
 mm/memory.c                                   |  64 ++------
 mm/memremap.c                                 |  28 +---
 mm/migrate.c                                  |   1 +-
 mm/migrate_device.c                           |   2 +-
 mm/mprotect.c                                 |   2 +-
 mm/mremap.c                                   |   5 +-
 mm/page_vma_mapped.c                          |   5 +-
 mm/pagewalk.c                                 |  20 +-
 mm/pgtable-generic.c                          |   7 +-
 mm/userfaultfd.c                              |   6 +-
 mm/vmscan.c                                   |   5 +-
 tools/testing/nvdimm/pmem-dax.c               |   6 +-
 tools/testing/nvdimm/test/iomap.c             |  11 +-
 84 files changed, 216 insertions(+), 955 deletions(-)
 delete mode 100644 include/linux/pfn_t.h

base-commit: cf42737e247a159abe9b0dc065a3ea44808a83a0
-- 
git-series 0.9.1

