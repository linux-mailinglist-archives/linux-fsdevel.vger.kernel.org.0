Return-Path: <linux-fsdevel+bounces-35531-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A899D57BA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 02:51:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62BE228157F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 01:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F3813F435;
	Fri, 22 Nov 2024 01:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gzKEsHdp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2048.outbound.protection.outlook.com [40.107.236.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429091DEFE2;
	Fri, 22 Nov 2024 01:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732239781; cv=fail; b=LLTYBPAUXzc7GFGAiXwBd3xnbY6Yd7egAkNNclbhBDr1z3BcaGVMhMdABhgC6yEkJjB8uQYT/UKQcznp46lUJsnV8dXNusqOI9BDAwP1WYA52ZPBjoJWQG2Fadg+v6KYgIEA15TlsyyoanVDLciw4PH1aVHzmBqSHqtXyT/no08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732239781; c=relaxed/simple;
	bh=bVzgWyQa4w+3Tu64z6XFGDevakKWyWcLsWA7cirN12I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LVRON9XvS9GhlefKge8catzraZwmR6XSTr92yJkuVuIdc0aKwMd+TfOR3uNk8qunYK/p8mwL+YzVYV4QvePcOD0P19dyGRqsEL/h0xGHMp79tEOciLvZBzoOLMF/u51dsGFloxVEoaGYHYV7jdm0+Xyh9h3K/Tt8zkgRCtV311w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gzKEsHdp; arc=fail smtp.client-ip=40.107.236.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=weBVc+GFy9Z2a6njO1QBsRcTg5NrzYqRqkifilR4dxf5l3F8/hCRAy/O5XxTnbkK4I63f68TDz/FN7ACapsar88Uhsr21WDOh89fTd8CL0/pO6trGykNzPFc5oNNxOoZV6npDqIS4RXXV2JPM0mLnhrIwHwxcjJniS3XFuW2JWXe260tAlqGyVgEc9OcfkgDOf1zrQTMLuWlRmXSPwznVfR7G8N8ju7gMsNqmv5nwZdwi8T6ecJlqF347A0+Nc2SkMe5QDO55kwtCcWfxswXKcU1OS4OnNi00TpED7IpzaicedS3hukeqvpcTvNWO1GmcoXQ6sqwsTVcoPqEUYpG7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+RK8HcctKWrWGjHAxyN8k6xlAbP24zFsv0TFbZlW19A=;
 b=av4+KqFMohbx3u6nPn9rm4qbV4xY1PNoLcWOZX2uodQ3pM95AV81Rg+AKZj6GPTIiIUxTxUQh08O6seR6CZye2TS2Q8Ppk8UtX5Eh/eSqA8wCjP5+2UReQZjw73QqUN4RBrJShkl0RknbwYsxg2ntwCLykGLgjvhhfiqvhw4XVKmiz5SwRMzRObJDWvoJnlGX3mE/2eIJv/bEgZFHu+hh94pRo7mlO7Zf+8m1C683HGkZELUVqPYJE1PGgmqA21av4sDA8AWPCjv0ES8IP4jU8EcykoHozuBJKbCGNQjynRnMSbSRtUzGX79g/CVnkHbu0YJ58k/NNJ9oAAZrlU9HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+RK8HcctKWrWGjHAxyN8k6xlAbP24zFsv0TFbZlW19A=;
 b=gzKEsHdplPpPAw7PXbI3+wJoS0Ng80yS85rNLBmNO6KtDDdoz86XNyKZ2rzE01NjOkKeQ+GzVzzg0j60OqUecxSTLSUbf8oFvq63nvtYyv52RR95fnSht0c3Oz+rSAmtjVjny/SznVM+rOoWJbB165I2CSnYfXbFfMrixf36uBHuZ/HZ5fgzw5mo4PUuQqAi1o35fbk8HSSB1IXYu+9HtBxkPu/Iof0uKpjr+0xqFrw3ueQ6n7qBK2E8H8/VSjISdYLnxvVcgH4Hw080gd17687jDmKzSat2lCKgrk4W2HcV/OYE6FSs/7qT9Z7qvM7rLd9OzU9foOKLI2ng9Xknzg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 BY5PR12MB4131.namprd12.prod.outlook.com (2603:10b6:a03:212::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Fri, 22 Nov
 2024 01:42:55 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%4]) with mapi id 15.20.8182.016; Fri, 22 Nov 2024
 01:42:55 +0000
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
Subject: [PATCH v3 22/25] device/dax: Properly refcount device dax pages when mapping
Date: Fri, 22 Nov 2024 12:40:43 +1100
Message-ID: <5a3f120dd11d92123835c8565aa9c59e44f10f9c.1732239628.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.e1ebdd6cab9bde0d232c1810deacf0bae25e6707.1732239628.git-series.apopple@nvidia.com>
References: <cover.e1ebdd6cab9bde0d232c1810deacf0bae25e6707.1732239628.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SYBPR01CA0181.ausprd01.prod.outlook.com
 (2603:10c6:10:52::25) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|BY5PR12MB4131:EE_
X-MS-Office365-Filtering-Correlation-Id: 507e2c92-7f8b-4735-a445-08dd0a96fc85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xbhDw791yL54vbSjLKKuqGEPKGjjmSqvxQHP9hFdjBau71cxGBu1MlEMzVtH?=
 =?us-ascii?Q?To+fPc71yJi8BMnLpDNPyMdZZdPDenJ2gtBGwsRWLTuHoVgLs3oqIAf4BOx8?=
 =?us-ascii?Q?d+Z9qBE7ocz2YW/aDvt/Wz2dmfwSmpE996K2IBUJWxIHFLc90BcPTRXyS+xv?=
 =?us-ascii?Q?xgcrzPpp9Sa+fNmd846v7cCi+5XsSW30Y8VfRvPapcxZ4anuS/Khc2d59u9V?=
 =?us-ascii?Q?qDi9FQZATJV+P95V3c5f1YxQTogSHpUuQDGpsq/B9k+5KcH3GToxEqaVNAZY?=
 =?us-ascii?Q?+3Kxrgg3ibwoAJQaUFZzkyAGpkAlM+/7mIP0pleu31EKOppHViM9Hc/EZSOK?=
 =?us-ascii?Q?ChTcM8gXg6AQrsluzzrIaQ6TKvvRjvuWmX3sybnSy4pbu7SpZVlpJ/twgCdT?=
 =?us-ascii?Q?n7bwFzKU8Z2i78L3QpiYQ25X9ZSHMwTrXVt7/WKYsv4IiFCVuh4vYiOmB3tS?=
 =?us-ascii?Q?Ld8/2+K1c2YELZBxvy/hFnrXzGXeBflx8sF5qeQtYX94q4fVmSJCuJO+/5H/?=
 =?us-ascii?Q?yEaFHhLgigVBaE7xH6av4l/DCF7ldDUTtc4B49Ti5kXKR+/Ae0Gz8xRi03RQ?=
 =?us-ascii?Q?YD/lqdWEpmay0V88c5dblpOpExZFnBJACMuDhgQ7bJoQJhIhomUa7YBQVjYR?=
 =?us-ascii?Q?I9vFrpfVC5AHcnHqAYOB06e3H/A0M3PjOzZSMqmb5qoOBPd2LPmiTq0tTSya?=
 =?us-ascii?Q?ymZ0/4kQvIPOA8yOmwTGjaYJr7AZK5TPXylRH6gfYdpRFpBxXga4ZE2FSz6F?=
 =?us-ascii?Q?kjDzJRr+ryjYDOz1D+MESnM2/65XuM3CszyV6vHcZ5Rh55edF/zw0kwXryDY?=
 =?us-ascii?Q?LlYukm8o4damlQU792W2tgHP2nrSnejacDOIIzu2ZplPEfMzx3RmEXow30/H?=
 =?us-ascii?Q?ET80jyeEBxfKIoufAmAX/r7dAJZzaVbxEIY+4FJLc4Nxz5Azi9IcMTWbHafc?=
 =?us-ascii?Q?AOlOI3DbnYqv4vEa+cRI354LyzXyfOPT0vCMYssmToet71zoFaRzpzM8GMnJ?=
 =?us-ascii?Q?AWb5mikL14RPIfPpaG/jkqHAJ0y+lxa6hWBCvDEzJgP0u3nOyId9aBJdsdkO?=
 =?us-ascii?Q?V22bbwUnoQP2tF5ILKvVCF2MBp/ehp1yPK9oUYQj6L32HC7G/X/2j+3rxRt+?=
 =?us-ascii?Q?Fvay9FX7DV+9Z5OEgwv5hdYH51oJcGi9+wwuIR0bQg1SnkD/zz/1xAzxX0Dc?=
 =?us-ascii?Q?gi/9l6dFXMWxhwLJdhqlYPpOtRsR7XBmGCIZxjFfd+PeZpDTon9vf5O8ZlCM?=
 =?us-ascii?Q?5bAVYMO8Bch+rHhyH22G7b8TRFIObZ+42h8eSWa2DIs3MhyZNkGPmVzRqIw7?=
 =?us-ascii?Q?IXcOwtSdF4RDXJ2jLTsqhuKp?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pysUss7gV89SjQKS9PZYYfjgBqcTzLrLZLDM7JO+wMDxVDU20+ORo7RVaAqH?=
 =?us-ascii?Q?5GqpXVZoPnr54KXmhPC9a9Iw4NUzffo+wAiusFj1qyvfF1FBYMrM5KZdmmNH?=
 =?us-ascii?Q?z5c7PxQk5I0sgV9wKXfPBpdxZ0j5j2EgLcdmDEBJl8CpzraVOScjut07BW+1?=
 =?us-ascii?Q?hbPGbI5y8XbcTSXc2JsJfWJNHb61DRcEuPQk+/y2e22yE/uVop/GLhc3GP5u?=
 =?us-ascii?Q?lRlAjVSsNZBBeg34eQ+uOlKCTtDCXtSx0ageOUMfQ7ddwzCX3GJ09YpeqmqH?=
 =?us-ascii?Q?RMWJoyigQpVegRDVze7DCH+cNeER3/0mrB2eBKfrj4LETCOAbi7WLzJ6I2Rh?=
 =?us-ascii?Q?PtBwcmDBkNjeGddvPqjFZq5ZX2E5tw1N9kth+4/oP8GaFtR3LU2XEP+ULkfa?=
 =?us-ascii?Q?UYuJQuTD0ARrNTnplxxHpfwGaSgJ2q5q6neQG0WnibKxw+GE7goOG11FrN8g?=
 =?us-ascii?Q?AgZMMacbiUG6RH4dJ5vmG7EgfKAuc/7lVzd4v6u8tYNMBp02eBLqLT2EZThl?=
 =?us-ascii?Q?j7czDzMIai3zH8DjVOrvoHNvKr2CrvdIZ0fN08qnWK0UYFw3I1M7Rx3HYAwX?=
 =?us-ascii?Q?QhEo8ESn5WETxoCu0n7wCwqpAEawTA6MI+z8xV07+BA7xXW28uc3hytfz8B5?=
 =?us-ascii?Q?gqim/xePDXfH/6LE7DvU8oPpB/pF7ln0WpTawAKTvt1PFRW2/GAqiBfnof5c?=
 =?us-ascii?Q?JCH0OEjfpzLRGR8J4AO/N4oLltwufoip6MtMxremYMhOkIhYbIPN59nKzKy0?=
 =?us-ascii?Q?wFMvZWtRTj9a6g0vpdOC/HDyPX7eDkAoNj5xk6kahFBEgdOMXdhslfHCtQfY?=
 =?us-ascii?Q?ndKtLdONvvQFWoogWZuacVo61YwQ7nml9mDLBdoUPyp6ciXJfJ+tCENDctdL?=
 =?us-ascii?Q?tavNVkms6d+8EKQwRYoZJxq+c5w1BY9iS1Mh7m7O6mxPsHSVbxAFcFxLGfSA?=
 =?us-ascii?Q?SZOiju6+rnk0I6mVC0iUDYDev/rCQBO21cqql1y+FCUMl5eOIGzOF/WGSBP1?=
 =?us-ascii?Q?luTrM83SEH3jCpGjFYVIFneBFeG/mymYgp/PgLK3AI/ljw0Vlb3aGu1MI3MP?=
 =?us-ascii?Q?iOjgHND5FpyovOc9Ik4sznNympQ6sChP/LjN8IYUEtaQqeSMeRAI+0Za7aa6?=
 =?us-ascii?Q?KmdQVZkV1fxnuv2c7vTiusG/e/TRNZJrVTYGIM+/sFSYqc8ayxsxHNYhE0Lh?=
 =?us-ascii?Q?3Rwmsv17tpB+IP/ELIVgdHikck5HWYjQ7evuIqtbewuCjAzZ/Xt9WJ0+D6wV?=
 =?us-ascii?Q?BIL/Lfo/qtqJJn3NxTPHOcu861RGXwUtbhoqg/WF6KEZqhUyb7LN/sE82haZ?=
 =?us-ascii?Q?SdIHhPSC37KLQDSL0936ww88sLu2pACDL2Rd54IC2zy1+2Xvo31zSeBJmw3r?=
 =?us-ascii?Q?6jjVqEAU+uf4p2pGFeVipYeNl1YSGPuhLQ4yx8iyJKzb0INlTSZA+qgpKahv?=
 =?us-ascii?Q?4tWvAC/obfyhtxxlCYZqQHvq/Rfl7AI7QfVYHu2RSnYJI49wHfm9/Li1gMUY?=
 =?us-ascii?Q?btgfQaYHUj4G814ZSS9Cb98IjCZtDdwedbJhHoatmh8WNbnMaJXQsOcUTNlu?=
 =?us-ascii?Q?Edwexoh2E4b1a1/L2GNy9emWRRmWSofLaVdj0q0O?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 507e2c92-7f8b-4735-a445-08dd0a96fc85
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 01:42:55.7591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aEhpBGb1QIrbfogxmU6SPSwcqXdpK8dXgtDhvWROm/tO70pIGQd6k5cyG8a0oFGIRuaFWWxR3UKYKblQ2Wmu3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4131

Device DAX pages are currently not reference counted when mapped,
instead relying on the devmap PTE bit to ensure mapping code will not
get/put references. This requires special handling in various page
table walkers, particularly GUP, to manage references on the
underlying pgmap to ensure the pages remain valid.

However there is no reason these pages can't be refcounted properly at
map time. Doning so eliminates the need for the devmap PTE bit,
freeing up a precious PTE bit. It also simplifies GUP as it no longer
needs to manage the special pgmap references and can instead just
treat the pages normally as defined by vm_normal_page().

Signed-off-by: Alistair Popple <apopple@nvidia.com>
---
 drivers/dax/device.c | 15 +++++++++------
 mm/memremap.c        | 13 ++++++-------
 2 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/dax/device.c b/drivers/dax/device.c
index 6d74e62..fd22dbf 100644
--- a/drivers/dax/device.c
+++ b/drivers/dax/device.c
@@ -126,11 +126,12 @@ static vm_fault_t __dev_dax_pte_fault(struct dev_dax *dev_dax,
 		return VM_FAULT_SIGBUS;
 	}
 
-	pfn = phys_to_pfn_t(phys, PFN_DEV|PFN_MAP);
+	pfn = phys_to_pfn_t(phys, 0);
 
 	dax_set_mapping(vmf, pfn, fault_size);
 
-	return vmf_insert_mixed(vmf->vma, vmf->address, pfn);
+	return vmf_insert_page_mkwrite(vmf, pfn_t_to_page(pfn),
+					vmf->flags & FAULT_FLAG_WRITE);
 }
 
 static vm_fault_t __dev_dax_pmd_fault(struct dev_dax *dev_dax,
@@ -169,11 +170,12 @@ static vm_fault_t __dev_dax_pmd_fault(struct dev_dax *dev_dax,
 		return VM_FAULT_SIGBUS;
 	}
 
-	pfn = phys_to_pfn_t(phys, PFN_DEV|PFN_MAP);
+	pfn = phys_to_pfn_t(phys, 0);
 
 	dax_set_mapping(vmf, pfn, fault_size);
 
-	return vmf_insert_pfn_pmd(vmf, pfn, vmf->flags & FAULT_FLAG_WRITE);
+	return vmf_insert_folio_pmd(vmf, page_folio(pfn_t_to_page(pfn)),
+				vmf->flags & FAULT_FLAG_WRITE);
 }
 
 #ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
@@ -214,11 +216,12 @@ static vm_fault_t __dev_dax_pud_fault(struct dev_dax *dev_dax,
 		return VM_FAULT_SIGBUS;
 	}
 
-	pfn = phys_to_pfn_t(phys, PFN_DEV|PFN_MAP);
+	pfn = phys_to_pfn_t(phys, 0);
 
 	dax_set_mapping(vmf, pfn, fault_size);
 
-	return vmf_insert_pfn_pud(vmf, pfn, vmf->flags & FAULT_FLAG_WRITE);
+	return vmf_insert_folio_pud(vmf, page_folio(pfn_t_to_page(pfn)),
+				vmf->flags & FAULT_FLAG_WRITE);
 }
 #else
 static vm_fault_t __dev_dax_pud_fault(struct dev_dax *dev_dax,
diff --git a/mm/memremap.c b/mm/memremap.c
index 9a8879b..532a52a 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -460,11 +460,10 @@ void free_zone_device_folio(struct folio *folio)
 {
 	struct dev_pagemap *pgmap = folio->pgmap;
 
-	if (WARN_ON_ONCE(!pgmap->ops))
-		return;
-
-	if (WARN_ON_ONCE(pgmap->type != MEMORY_DEVICE_FS_DAX &&
-			 !pgmap->ops->page_free))
+	if (WARN_ON_ONCE((!pgmap->ops &&
+			  pgmap->type != MEMORY_DEVICE_GENERIC) ||
+			 (pgmap->ops && !pgmap->ops->page_free &&
+			  pgmap->type != MEMORY_DEVICE_FS_DAX)))
 		return;
 
 	mem_cgroup_uncharge(folio);
@@ -494,7 +493,8 @@ void free_zone_device_folio(struct folio *folio)
 	 * zero which indicating the page has been removed from the file
 	 * system mapping.
 	 */
-	if (pgmap->type != MEMORY_DEVICE_FS_DAX)
+	if (pgmap->type != MEMORY_DEVICE_FS_DAX &&
+	    pgmap->type != MEMORY_DEVICE_GENERIC)
 		folio->mapping = NULL;
 
 	switch (pgmap->type) {
@@ -509,7 +509,6 @@ void free_zone_device_folio(struct folio *folio)
 		 * Reset the refcount to 1 to prepare for handing out the page
 		 * again.
 		 */
-		pgmap->ops->page_free(folio_page(folio, 0));
 		folio_set_count(folio, 1);
 		break;
 
-- 
git-series 0.9.1

