Return-Path: <linux-fsdevel+bounces-63797-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD55BCE1B6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 19:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52155543558
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 17:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64140222560;
	Fri, 10 Oct 2025 17:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="J/FNMawV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013026.outbound.protection.outlook.com [40.93.196.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B43422157F;
	Fri, 10 Oct 2025 17:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760117971; cv=fail; b=LXjz/CduF8uYzNI2TDIjyd3V/BPEy3ssDtHXIwSx+Vq3eyPvYIWkBOhl4zKLh1gw1eLN4aTH2q6hN6zdm8LGX8LqU8tabP/IrT4OmjeXQCnbf+7q7k25xarWkHp/ztHyevGnTFZz669W7JOK3oX99Jn+L1flNFykn2vMFrI8Wag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760117971; c=relaxed/simple;
	bh=UT83nfD3ItgtHZCH2O9wewcRoeIqwKXlNN9orTlhigU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=rh5nEmvkBa7EPfqindOSrcD/RkeKWh8vk7c+cKS09oUtggB6rA3hQ3Qi3Ek/WTSPfa8bSwucuJQ2TdNzq6SiotAdCQQSPZ0ZpHIjzgyhoXweEa6M5jFTv4TuWc5sqoooG3Z38YWe79pUtdvcN8L2dBQVN7YqgWu3B0B0Sn1Kmhk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=J/FNMawV; arc=fail smtp.client-ip=40.93.196.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zl4/SZlRfTC7jG5vjAD+5IF4QEh/v2ie4p0ajL49JYubb0JPWohbUcOkk54ytLuIqGOZOxaErczzztbfnm2u30IyDAJzSgan/owINBp11tI4flaEQogrRz7u4s8SL+DUrl0Y6VQnp+Nu+pxD/cNe1Ln4OfapTabQX8eKnllxhJedByWTzrVMX6VSY+kgQ66RFo0pBQcwrshbu5o9r7Gx2KZdzFAexFFJa8uSR3vjygjh4sYjoDWzF8j8hLoZoypZtBBE1b88ppT6yFg5FRqgz7IDN2PYqEGsFpVYi9Kcpg6JkTUL+WNEEW34CqwQL3mp34Ua3Nm10HoD5kF7q2OhuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vVFDKB9aiFMowTd+XpJZ8KEBaJ86Nrgm34/ldnAfXck=;
 b=fEw4grBTgukPJwNjqxikSu9W/n075V3eGHc0etD83EqwzzTS01aLMljljj2RE2Q/4aNp4QRmq3ehRyKglFI3DcMGE01SBrnZUKuS8AS9G7xVV1cr/VzltwZORRUw4adXAVkHAc0Qv6UJqYiJn/71eyaKdn1UPuU/tcq0bLRR3A6++h6ZP6B9MFmk2vIbj5u9VXUR32u6DZox7z+tUmEciPbjZM+uoAi0dItj909Pjj1LQxvcp64vJMCq6crgLx+8GVUyDr2u6iHLXxxCXLY8+G1qPxu5VGyS9u0gthaQW0id6DLy8P6iwWQK61gohPOidOawyVSFL6xAjdVszweIYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vVFDKB9aiFMowTd+XpJZ8KEBaJ86Nrgm34/ldnAfXck=;
 b=J/FNMawV8hzx0Yf1Umt6+sMfAIMgZkDDnxmOzkad9XGJgtZ6b/YFj6ZrPv9XDFY03dk23pjmLMHoZBbFU14gDI12H3SkccdY/fiDROavIusCLGko1tN8bn5+F/t7Re3qcFInpXHfIUawjoabhDhe39EJU8yU5eOFQvQUrmTmc5YVo4rBm7t5vKen1YpXmtTXNdWp/ViP8XFS4LnawTHUZJU1f2d23ch0OYEY8U0teGum/Jp1Vzrvu1XbOtCvjQ0D8BQQBU/OfQkHgaRpx5dLm0CTwmlbiy1NfmHATsZaxNk70Vl0LdxNi1P6PC24fbvn9qXDwRNJMOnH2MtQBDHoTA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 IA1PR12MB8222.namprd12.prod.outlook.com (2603:10b6:208:3f2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 17:39:26 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 17:39:26 +0000
From: Zi Yan <ziy@nvidia.com>
To: linmiaohe@huawei.com,
	david@redhat.com,
	jane.chu@oracle.com,
	kernel@pankajraghav.com,
	syzbot+e6367ea2fdab6ed46056@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Cc: ziy@nvidia.com,
	akpm@linux-foundation.org,
	mcgrof@kernel.org,
	nao.horiguchi@gmail.com,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 0/2] Do not change split folio target order
Date: Fri, 10 Oct 2025 13:39:04 -0400
Message-ID: <20251010173906.3128789-1-ziy@nvidia.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR10CA0003.namprd10.prod.outlook.com
 (2603:10b6:408:143::35) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|IA1PR12MB8222:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cdf6e03-222d-4b02-a878-08de0823f55f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uFhtchUBSq/QSCsMSgxUqz1dRw3u6h2pSK6ePFrU3OMNqmYuzPdzJc49BLU4?=
 =?us-ascii?Q?3KsrO6vzL/bFq8tZsmRmaeTqowUgUHNsq01J+3ghDKHiqJlEVHeCOpfCINQJ?=
 =?us-ascii?Q?HxkwcfFpMdIw7jgat+qOqQnm4seTOchzLQhRC24SOlY8xBsEy5ICbc1jqdac?=
 =?us-ascii?Q?2cwcfVNqbatROCS1Ne+YO+vc95BjG+6M+vzAHk8BeVu0g+7JobHVxw0YC66T?=
 =?us-ascii?Q?N7SyxWYgUpQJFjNWNgtbLtT4yFKEHPvR6Ap2Q7jB7diN8nS3feBVQt+zqhE5?=
 =?us-ascii?Q?Qz63/h+OhquzIIUcGb1cHMcml0xZei9luuoAuaAHttSaEOyC/tqIzDNXd+Wj?=
 =?us-ascii?Q?5FVOkuXUD2Uhkkc56bEA1pOa8ORNH/A25v+t7ZjpQqPDwAwu9tJDlaHDjlj5?=
 =?us-ascii?Q?CowSF3dLgPMsKGhMruGWZufIQ/9KtX87LmhF/EdhbwAsuh2j70RBhlHnFzD6?=
 =?us-ascii?Q?bxkdICHU7WierzilKzQcWwAX9UCH3uqGHYWeQYc/hHMytB7CmvyAn0Xntljl?=
 =?us-ascii?Q?jZktrvlCP+qipReE0+qKo44egY1QNGH4YDayaTw5cjczRPS1QTwubEpwMd+D?=
 =?us-ascii?Q?Ct+SYHvDOuZ10kUwgjTtBCNTSkijhywqgKbaeq5/4AwxdszsBTbjYHIpBw4H?=
 =?us-ascii?Q?RnRhfMRL/YdRZ/qjYRDmhDSb0ZEKJDeAkC0IBqic9uX2ei4u6PFGHiKqVVoI?=
 =?us-ascii?Q?bXfG1/uJjAEYHAogPrKNrLoI2y1riIbeERp0Db7/fIZJsfAJp0Uea5uM6XnG?=
 =?us-ascii?Q?fn0rfC6u4uewedfEff+/NBGvePtAvq2xYyWKmmrATKr5U1vKrhsGjDVxh3Sp?=
 =?us-ascii?Q?wgUBEkpSaytTJBvz66bR4YykQ8xjXEMxMLf9b5xPI4ZaUGNjYcAsyDZivSWJ?=
 =?us-ascii?Q?Br+9go09GatOSRnkw6EoQfSAIsw9gWX0zg+uxAiXPtVJpOZOBDqcXMPNAJYw?=
 =?us-ascii?Q?721QZszbTGQOU+f4OfumCJ9SP2wIAjyWELH8EVLnY/wcvxcWOgZogIxTZWcv?=
 =?us-ascii?Q?83qZUgnKgHCuE2O4qgsDnrS1Rs49kVccCigx+VZJS6atg9pArmV84Fs6Nje4?=
 =?us-ascii?Q?wOiq/RWF0zsYzv7IdUGpJIIISxG2lyv57oGlCSlW9zUsWQIehPhA75PkfDtq?=
 =?us-ascii?Q?R9RZzwGe4elblOP+K0zu6H/PfhvSMmoOK1ZxVa5kXoRz/dR/DCT5Zxfm+Lhx?=
 =?us-ascii?Q?JP6P4bQ4LOYppk7ho1hazFJA7sGYjdJ2zmEs1sJD3tDZEZrJBsPfK1UmDX8l?=
 =?us-ascii?Q?Gy4g9cuA8bYEW7kPx4VdM0jnSKgFG5iG435HBmXE4z3GbT+vB6FGBaO9xOwu?=
 =?us-ascii?Q?6phLjyvTx4+Iey6WN33AYPvNko9EeiY65DSqRgu4mUfrPXa1NX6hKSnXHhzS?=
 =?us-ascii?Q?gx01zXc/pPjMY7LTn97g9mCSrAUV0Lq7OKXuwWnEXHbzWGf1uFKJz3fXWXgb?=
 =?us-ascii?Q?q6n2CV7NVJWjisGDFf0+5bzGIRBteTorb6RngI+qfTy+DH8G9trkOw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?X+bVHmGVDj2n8cEeEO48nqmjTPNlL9L6GuiD70bqB08D56WhB04jBoUbCC26?=
 =?us-ascii?Q?JreA6BT+sgyQrQcXMJJ8rpdbdhEnLbAhs8BcNW60ZorVCHq/FUaVDTb8JqWR?=
 =?us-ascii?Q?e3DLsixTaKUOm3yIpb4O6NtqUUQdkwi5FujhcrGMOQ1ujt0RDxlLeeQhOsDa?=
 =?us-ascii?Q?dl/Dc2pz3EMH/vtk3kiv8ZU5BZsQEL6YOIotNkjaQjbclRkPNf7wylOFk4XH?=
 =?us-ascii?Q?hSyhBDZ2WnzglUPI/RoNo/0rxjMhQ6+3dCOnpXOORlxG2BLTNhGJ1IVwWedf?=
 =?us-ascii?Q?Nvwzq+ylexjGez5Nt5wTNkFVsf92jPz/Ni0QQovACTeFFARXHSCjtJLP6k/q?=
 =?us-ascii?Q?fW+N4BdhfrAM21VdM/O7falfFPSGCYtlxxkmJ9aI1JaUFPy4rMv//6OPe2b9?=
 =?us-ascii?Q?Grato9UG7hyR2MFLlpDhNkCOfDThXK4xTAGoFmutsWAbfezpeTG7G4j3Z0D1?=
 =?us-ascii?Q?tZ9tVawXsCtRdUl1dYeEFhWol0uSSi7OqlyMalV87hIMk0FYOVvnMHa7HXEm?=
 =?us-ascii?Q?953l1H6q7/V/cgMxRMyFnIKju9uLS+kjDUkuPst8hc56eGBu2WZPsusWVDSz?=
 =?us-ascii?Q?TSu/cADVUk1UBQmIeKE7pGU5OusvNb5aiAfw2ic2N1DI7UUDdjIpAODvBAaz?=
 =?us-ascii?Q?IZcg9Thu21apgWPg076KlsQGTvTVUSycIMDIHmnappc3NUo8t7c+00kcX5t0?=
 =?us-ascii?Q?mTUvspm41ylWSuV5i2Z7wTOiS+/+yR729Au7IUGoyCfmtzAw+o5hfqyfF7j4?=
 =?us-ascii?Q?ukjWTJmOFxjSp6WyEtEPTNji17Tj6b6AOzrxJRmMCQJwEKOGNKMgAXf/F38Z?=
 =?us-ascii?Q?7kJ5iOZ6fHK/FjoeUlrxuuko0ZWX1wozq78Q74OlmZsH+tDEMlsfxDr8G0IM?=
 =?us-ascii?Q?LNZcIOblOtWdp5IVajYi+0tahuC5C+9X13LI++b2CUrcRynA65Rm2vz3FjIm?=
 =?us-ascii?Q?imY2zvmsref/aO5OfIM/y0uD/jINwoq5WZg34xJ/d6W6WCYGVLnoPrhOzh5a?=
 =?us-ascii?Q?x4KKnmfJmcDdhzSFtra8cgo415Wp4vhp4BSwLywrdeHyW4oxUPocjjzZd34H?=
 =?us-ascii?Q?HWf0jrvjX8QK9qWztIMpKPj9leE1eLe6mu1Qm+eldGgth2LlVQmDu/4AG3xf?=
 =?us-ascii?Q?iIOu4rW7pYylfZjqYUMLsH3agh+hA0zMeFNvLky+yaJDcosIleYJuFS511rN?=
 =?us-ascii?Q?BsgUu3ETeWNgOgZDnt8mjEEBLEckXg+2klPJ5s5K46/dbAK8MaLW8P6F3tIs?=
 =?us-ascii?Q?IJsOH05n5rZid0S3M5t4qc1dxUGXLG8sUjXvLK3qQMdgM225dTfuRvhkBSRI?=
 =?us-ascii?Q?fBq9ixJrgO1Kh3RjGvxp701CFhxbaLi6ogLuRHXsohLTjpqM+iVcXldE9rEc?=
 =?us-ascii?Q?sKqP/tow0sZAtmGtUPB7aSpHQpollWatu2i51RVAkzvMOiW04r9SKKChtDKR?=
 =?us-ascii?Q?kxozak3HeOmljVE5QM4S87ZWYJJT9BQI1/dkoN0w/ulIZkjirHtBHqqjfCV4?=
 =?us-ascii?Q?3sYZGGDxZoJu7E4B10bxayqvaRtuCYugujBlfccEA62iLpq1KCQMUHhl+P/W?=
 =?us-ascii?Q?Vz3CUYBrJru9+f0lToAwIhk/rtfODafgD1R5LBIP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cdf6e03-222d-4b02-a878-08de0823f55f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 17:39:26.8329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ih1vLIiQES9RvJM8olTl30rgecATdkbMYa99R78z591n3+q+FPxKDGjhW0RbQU6d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8222

Hi all,

Currently, huge page and large folio split APIs would bump new order
when the target folio has min_order_for_split() > 0 and return
success if split succeeds. When callers expect after-split folios to be
order-0, the actual ones are not. The callers might not be able to
handle them, since they call huge page and large folio split APIs to get
order-0 folios. This issue appears in a recent report on
memory_failure()[1], where memory_failure() used split_huge_page() to split
a large forlio to order-0, but after a successful split got non order-0
folios. Because memory_failure() can only handle order-0 folios, this
caused a WARNING.

Fix the issue by not changing split target order and failing the
split if min_order_for_split() is greater than the target order.
In addition, to avoid wasting memory in memory failure handling, a second
patch is added to always split a large folio to min_order_for_split()
even if it is not 0, so that folios not containing the poisoned page can
be freed for reuse. For soft offline, since the folio is still accessible,
do not split if min_order_for_split() is not zero to avoid potential
performance loss.


[1] https://lore.kernel.org/all/68d2c943.a70a0220.1b52b.02b3.GAE@google.com/

Zi Yan (2):
  mm/huge_memory: do not change split_huge_page*() target order
    silently.
  mm/memory-failure: improve large block size folio handling.

 include/linux/huge_mm.h | 28 +++++-----------------------
 mm/huge_memory.c        |  9 +--------
 mm/memory-failure.c     | 25 +++++++++++++++++++++----
 mm/truncate.c           |  6 ++++--
 4 files changed, 31 insertions(+), 37 deletions(-)

-- 
2.51.0


