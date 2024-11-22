Return-Path: <linux-fsdevel+bounces-35529-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59FFD9D57AD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 02:50:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D62B01F22B85
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 01:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A38391DED5E;
	Fri, 22 Nov 2024 01:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FLBGCStn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6141D1DE4FE;
	Fri, 22 Nov 2024 01:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732239769; cv=fail; b=Q9AqoOaShcebBDmHpMJ2nUOCNA+mifUl0GHYhf8G6/RXbGuSNNyEiWCKVNuk65w9PoBpo7D1WDYoyxoRfBl6WMrMIxqgeDm0mJjmL/NwJTPC2UFzd6iiJ7AoQvUG/SAF2SOBOMTBQ0iZkJH9wLkmn1pVbLWsv3M5YnO36zq7i6k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732239769; c=relaxed/simple;
	bh=TL3YpTkyvb0TrsNdadVavaPZVXqghI3XosqqFtixP2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fgUxg3Zdjm3UofdT6Yv0EyqK9JMohQaCYeJSjnAMVwS1uV5OIPlwsOb/JZ2daVyp0jxpk+F6qEeUs0aMeVTDeq+yOap0giGHwvkKHVodpltY2jZKPWra54ff6lTPQTdmDnnVTuiagGsBS+eJ3vryM6eCl/VMYUouxHntJ9Am3bM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FLBGCStn; arc=fail smtp.client-ip=40.107.243.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PgUmX/DVdqcIn30PYD6vuZuFZI2UsPq4xfQgGT7nNQS84DK/7pH2E/+8KjMsUhKP6cygPBSmNeIfpF2cp+CKSg3xmBO7jP/0Lq9Qx7AQQqPKptuKaInyJ8ApZtQETOpAvElCjxIA45gEZXXRl9TWo0JdsHFxAaLB58mAC3iXEDinRJcYCfabv17aVx5AAjBnww/bfohXDmQBIVxY1BnEc8U6RM0lwFtG+rf3x84QB3Um5H1lvH0Hokrk3+Iv24sh/QuPc+6VZI0tmfUhkzy6QLYou06wfv4ksmGfQWqbLh5G+UcR9osVCre0lzelFvWXch/LpZ+RLakld0zxU9cIPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Ie2UfWwGOlQGgWf9J0Trgw3+Mxxvp09CYeo6TMsj7w=;
 b=fZeLGvFdGgxG/D5ygjADVYrUKtTFbQXhRTf3RuOUer450Pa6Sj4UuWz5V9gaDaSOKEcKGFxwyz1fEn5X+nBsd5XGSpDvRF0SDTGUAAW7WV3H24jrwrSKaXT1FHcz5tPEy8h8FLefuaR6f+a796LOIn9YYB4yiNhPnS4b3rAfc+ZoGiIk0fbda92FxTE4MuhLlwQdy88U34z4IHqBduLoFXKFu7GA/Y/1F4DM9SZjL6uMZ1evW56pneXlnVwWOpL3vZECTZLT8UBJ6re0I9UioD+vzrAhwlpHgT3DLZWulQ5fBexQr0O/OpyeEL4PljdlujXQ6zBX535zL3oqFyYJkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Ie2UfWwGOlQGgWf9J0Trgw3+Mxxvp09CYeo6TMsj7w=;
 b=FLBGCStnKRvqHLUczft/RorWlDtwirw2wYyg/3V9o22N+dhgfDPEhg/sRlVrcozqX0WCjc4+rV7QqAJfC5vVGOQUBWYs6Vdu6hfhDrW2A6xcVfkp2YYywaKCyZuADvVGS0/X2WXmSrrvdFl+b07Dt62FsiVGPcicz8ZCB14rT8JSByYq9CoTWdxaxbhbbcYDrDfLRPNu7IjchelKScf/9YL1RC1XcEL0n4dU6o6JjXqAXHEuCQdIjuhuJvSJTjq+pHnYTV3Awfpcr0Oxm8Yp9Y1csii5FqKYCXQxkI9PnmgLg1N0gBKMXcFO8JX/wk9uXCyiKWykL/aEYk6crxK9nQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 BY5PR12MB4131.namprd12.prod.outlook.com (2603:10b6:a03:212::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Fri, 22 Nov
 2024 01:42:45 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%4]) with mapi id 15.20.8182.016; Fri, 22 Nov 2024
 01:42:45 +0000
From: Alistair Popple <apopple@nvidia.com>
To: dan.j.williams@intel.com,
	linux-mm@kvack.org
Cc: Alistair Popple <apopple@nvidia.com>,
	lina@asahilina.net,
	zhang.lyra@gmail.com,
	gerald.schaefer@linux.ibm.com,
	vishal.l.verma@intel.com,
	dave.jiang@intel.com,
	logang@deltatee.com,
	bhelgaas@google.com,
	jack@suse.cz,
	jgg@ziepe.ca,
	catalin.marinas@arm.com,
	will@kernel.org,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	dave.hansen@linux.intel.com,
	ira.weiny@intel.com,
	willy@infradead.org,
	djwong@kernel.org,
	tytso@mit.edu,
	linmiaohe@huawei.com,
	david@redhat.com,
	peterx@redhat.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	jhubbard@nvidia.com,
	hch@lst.de,
	david@fromorbit.com
Subject: [PATCH v3 20/25] mm/mlock: Skip ZONE_DEVICE PMDs during mlock
Date: Fri, 22 Nov 2024 12:40:41 +1100
Message-ID: <0fc7bd0c1f7aefcc5959fcb2a1bfd5a64e022d57.1732239628.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.e1ebdd6cab9bde0d232c1810deacf0bae25e6707.1732239628.git-series.apopple@nvidia.com>
References: <cover.e1ebdd6cab9bde0d232c1810deacf0bae25e6707.1732239628.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY6PR01CA0131.ausprd01.prod.outlook.com
 (2603:10c6:10:1b9::7) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|BY5PR12MB4131:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f782ee2-3bed-4b2b-6020-08dd0a96f681
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VZvWrXcGhNKiNbJGQJpvjpoi0c6zD4a8i8ZULLHWFVG6xBQoySPjOKeyzbFP?=
 =?us-ascii?Q?Xfupxtgo3rEPGxAewS1WriJJ/SNfSrxILkihjmN+HijxPIccnUuOYIGS9eiF?=
 =?us-ascii?Q?bwAqCC9aMpgmEp+nddFpBBbiT5YV7fTOOuOCOPmQ0bDqDX3STB1BkkZKHMJM?=
 =?us-ascii?Q?YApamUNZvswCSdjaHR+ReQJ5YtCs9e1GBb/WvuRg0gQMNb0hKF+3VOiGeJPa?=
 =?us-ascii?Q?hkJqzlNNMZRKoDO5BWBy7tFJh/7mp2AqVEsGusxTEsSbais14dgPsLTe9WZG?=
 =?us-ascii?Q?CW5hsnn9xu1uJK8kObci5b1iK5rdY7UL0TiXcLReZ2sLzv+44QuE4GgmePth?=
 =?us-ascii?Q?Oc4fY+W3CnQypaog571BAjbrNIMogqBVp5MmJmHUMEISOKs6Z96XL1JWhHh+?=
 =?us-ascii?Q?MxD8NOePqZodGGWEYMpBkCeYEi8oVum/LVzc3JGyO4RVtn31HIZ0ETPPzj6m?=
 =?us-ascii?Q?NG1j8vjT8Td2h89D8R+iwNI3494s9x9UEZUIE5Srxdkiap+KUBdRarNcQ51J?=
 =?us-ascii?Q?1tWdENCNFt81FV/EecuwF9KQlctiWQ02w4IQ9eDbqJoFfbtKz6Qw0vep6Bts?=
 =?us-ascii?Q?BffVphCoEvZSUHDe750LLX/r6922KvRKZm4d7eJpCzOe5aekHysgV1ATDhcU?=
 =?us-ascii?Q?Z4Sb2Ok/PDnoZDEgqlXTW+yXod5yO7XFfjaaf2gFWzAwrOXUu7A8dnuRgrY9?=
 =?us-ascii?Q?11dexOMcMWaE0dCq5Vto/mK+Ri5ZAwY/xc57XtmUJ17pftIy75E1/4HodWGU?=
 =?us-ascii?Q?6CZJepcQ9pmI9eD1FEkPZcVNaIKwAB4YGHAGSk4zpU8o8o017WQBwxDmT2bz?=
 =?us-ascii?Q?IHkwAmyIjWy0dduvzGPfwWT5CUJrEHeyB1ENzz0/1fVgUyu7beosAA6V4qPb?=
 =?us-ascii?Q?VlReKJHVYsvpYXA1YBEq/sbsVqZwQ3fi37+pomUY/1o3fIRW60jEDJyofTYh?=
 =?us-ascii?Q?k9c9TVowOlqWZHuJpXFKmWi/M6DeRFVYJu01MdKe8AaDxyPK7M/vlYeeejxa?=
 =?us-ascii?Q?2P0RPDOFWB2toPgh+NVCh7dZuc+Vk5aDbIjiX4BX6fYddeq7gyzGqf2b9VkC?=
 =?us-ascii?Q?mcG2AYU8hDKZmkz0aQe9XNHkTcesIgvyz1dI0lpotzXxrq5x9gVJL8Aeda+B?=
 =?us-ascii?Q?a1fvXdTTvksWTfJ4Trqdr14xV2fHy30r5DHbBaa10aWrybJplP8QPN/vRQyi?=
 =?us-ascii?Q?/tOYzu5F7w3fBR/VpjcPITcQCYVO8sPx/r3CNPkQsxmHzaFCtM6OD1bPY6n+?=
 =?us-ascii?Q?J6pJeYqLUvGwRTsfZTwujG3jbp+x/OhX3M7wtDtw097qjaD+xM7b8gKbkYIm?=
 =?us-ascii?Q?uIXuUodQU6ryAVPmUkB1h1vY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?k6LNpSfqA3Vxz/i4L9MDNT8Yxcuxgoxf0Y90r8+SSfj2uJYNF7arRgldAlcX?=
 =?us-ascii?Q?ML2F+GVm9/viTMd/v1e21HOkE2BVjIahI/Tye2aLxHX7gDNIjDPLIDMZ7P1R?=
 =?us-ascii?Q?tncC68yTj0YHmKMT9eNZdHXeVRwboMtNDTyujkm0E0gUuYxnr4BnQGYI7csG?=
 =?us-ascii?Q?SdmlDBasn6ggLwmhFfKMSrgCg0N7VYN3ALLkerghjRHs4hyj7LCFzQeRbsjA?=
 =?us-ascii?Q?3SpeW8V5HZNRYC0y9w7qTFN4almRvpd2+q5pccR8ZD4UbMS5PJH8z2zUJkFN?=
 =?us-ascii?Q?+cl31x9/ZCleP2w7c3UkaIQ3mGyJBL2Hi8j2yLbswm864EuiOKH9bTyyfY+L?=
 =?us-ascii?Q?1faw1ifzlK1ZgZoaVnrxsH6kL+tyrof5EsX514n6TmL1wHQDoKxHQ1JRAZZn?=
 =?us-ascii?Q?bR4rmwkOc+cZHSnRwzS9NtdEuj28dOGfNVUPP/m++zLyS/m4xHkmhu7+UrY+?=
 =?us-ascii?Q?2IpAUPGiveSbl2emSCDMbPniQxmeB1JqaFFCWlEya7bcrptweZ/kG5ll7DlS?=
 =?us-ascii?Q?mqu+17TGuby/4e5rLTq9bjH/uQIzF0eSvqpwLKBsnv/THGkPORpeOQYMWu7x?=
 =?us-ascii?Q?KtXRMULztHBYVgU9mVGMHetgiw7j8/tO3AV0ZBoeCKT49yctmC/AGW6oPR2X?=
 =?us-ascii?Q?BmUD7PFVZSfwPOQF04AZYp4306TAJWCRLKnswhetmX16oWUejRwk5CJgv8Qh?=
 =?us-ascii?Q?qafDUTXEbuSjOPaZMNQuAAPP6D8dSCxYL2MWOQj86DgGGO24s8x+h94Nyl/J?=
 =?us-ascii?Q?JsMHjpO3cShhgO7MyHRDbhsU7mdl8fKqR0i6TNP550cdVLPUIqL8c1L4jZN7?=
 =?us-ascii?Q?fdLO+HaQwZRANibtmRkldSAspvrXqquiThhMqsetvKTZzAYUhoQqgRHhVCh1?=
 =?us-ascii?Q?NzYtGNgUz6JNMIQabd64GFc+p3LbD7lN5DbH+sAvcIqUZBynEhFRbZMkpUh+?=
 =?us-ascii?Q?H0O7EY0kBTgClZch4CtW053iim+N3JUHCbbe6lT406b2FsWoog0rBv5bXdnN?=
 =?us-ascii?Q?OW56374vctOfUHTevxQQzRwUjsEc75Y5fyXl41L3qX6FBaHKkrwZwcMpSjqe?=
 =?us-ascii?Q?d4P48RVyCvTKWuf6Qjho9YEJzp5S2b1tjr99SUgo1UoKMySr3re/4mMVTOEn?=
 =?us-ascii?Q?LFq7oX7QBv7fQ42pyre89ScmZyJhQ0Bk7moxOSeFrmocmVpBiL+A3zojOOhb?=
 =?us-ascii?Q?hqNQmNBNtyrBsDE+KZc/GIaEIPV3h/GEgpwGo7eig3IGsvYFKT7xK4lqzP65?=
 =?us-ascii?Q?u/NZwJbDXMDIEXrXs0iR7PujhLQdZeDeecpmDIqgCf9FITFOXtxluV/OtbC4?=
 =?us-ascii?Q?HlAyZcFoU/0gVleGyuwKdz8S0ezH9SP1owT2QZzGxYF1zWqdGmo/keax0q2i?=
 =?us-ascii?Q?lcCmaSV0f4VWZI/NFVW1/bVMCa4Gr1LaLBUzzyrcj62Sk3au0CIlBUBQnlYP?=
 =?us-ascii?Q?RDTZEXKPEORcCugVihEdXxtxIjgmxXtx1z/wTE/uqTlcH/YSuJRaXnGnhCwy?=
 =?us-ascii?Q?7KqQWd3bCn0r6ZXTCZ6vvYQtzTOpxZRMQpndrjlN/y3jnuuFEqpEfVCfjx4P?=
 =?us-ascii?Q?YZVNQEfJDjuql1fs3kLLpfoWUcJk2rqIK1K3FLeb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f782ee2-3bed-4b2b-6020-08dd0a96f681
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 01:42:45.5109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z4UXWC02nP81RMjXliDt/cKEj1mEb3zFNTztGu01lZo2GZTcLdt/3auaumYKgoqnfzI0njuybDqO30gpgqp84g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4131

At present mlock skips ptes mapping ZONE_DEVICE pages. A future change
to remove pmd_devmap will allow pmd_trans_huge_lock() to return
ZONE_DEVICE folios so make sure we continue to skip those.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
---
 mm/mlock.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/mlock.c b/mm/mlock.c
index e3e3dc2..567cf64 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -368,6 +368,8 @@ static int mlock_pte_range(pmd_t *pmd, unsigned long addr,
 		if (is_huge_zero_pmd(*pmd))
 			goto out;
 		folio = pmd_folio(*pmd);
+		if (folio_is_zone_device(folio))
+			goto out;
 		if (vma->vm_flags & VM_LOCKED)
 			mlock_folio(folio);
 		else
-- 
git-series 0.9.1

