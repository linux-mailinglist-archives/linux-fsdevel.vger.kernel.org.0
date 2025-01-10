Return-Path: <linux-fsdevel+bounces-38818-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1491BA08799
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 07:05:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D082D7A0F6C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 06:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89DAB20B205;
	Fri, 10 Jan 2025 06:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pmQGkI0o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2067.outbound.protection.outlook.com [40.107.102.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281B320ADF0;
	Fri, 10 Jan 2025 06:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736488944; cv=fail; b=U8ELaAc1TIZ8Tbjci5AwyfnAmB19H9lg0wZgMU0KB3AmJ8s1m5eeJ5BOPO+5mT2R4Vc+XkpKDI7HFXkdipYPZYcaTN/BOFf3zl2+fTV0rzRtCaZzOyL2jQ5F+5dHiBXWsHeHY7/KWex7O+0wLzsn5xX0zu64ksSxdPFVu1O7wbo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736488944; c=relaxed/simple;
	bh=F7ds27O/WOAL8W2IRVtn8s3XEgVUVn6R+d2P4WWTdEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AUbbRJg41wx4gdjuS3xBLkJXv/b8gpJzfAXQUA0jEqEzz00quIOiG7vYucZGr4Zys7ROobVNZA9Ab/iLL4a9ch+WXrm5dEi4ajCa9e1cmoU8zDcFfDLB7J3YZVMKXF4Fl9Xtmwk2cG4EycVkujYnASrhyQ+J8XwEkGBdQHDKdis=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pmQGkI0o; arc=fail smtp.client-ip=40.107.102.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qxph5V92nGK5XRyfZWS2FMg+9tyZX/Kiz4If90e/xtG9vduZ7nNWPu1AZnDq+wdxMfNQHOkGN7o16iByjN+YZYHNdnvnesppnRYc0gLmUnGmgjEzyI+LPY/zRrntVreAynSWJ1Qgx8LJb1vkex7zD9U+O9f1jcNQr4eLu2fR7TUwW3aB1TOKURKD7AZjaDNC3WMpLW30FWQ2V7W7zXclAdY7GMcsd7gPOiWpYgQQXEQ+i9kXhayeeuspLYNcBt1veTHDgPxuzlma/7djncKCU9zjIgjwhnPL+wQOOwm1oYsE1qilznLeT/EMUm8djpWGPnses6h3fIo0nSfoDQOSDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GvbMUAJxfC2ngJPxfsGXWXX3r9undPrsapqykpYUxYA=;
 b=TyFbjjmwB5O+p0xf2p9Zj7+cm1SemPKIaFWgtF4FxcDvHg9W4ogv5Nh6X6q9GO3ikU3CsHWlGj5/qzelhWChNFjJ08ZOLWGAqX+7OeK6+idYFa2HsyMzIb/ZTsxRB4jz2TcHzi8SO1KEX0nRCNFcsBSJ/FO9I9SNE7QVQ9p0R/0DM7OKGx5DWOnr91ESMQw9pgb/7i+hKW2eJYF52uwt6iijY5VuKgcSyrxlRxkm6KPLmtKRmGDNxSFW5MD+LsxmhQw/Qm4GjElk8wEe++TVJ3pYKs2Cn9Xgfd9wif7efJianGilRYKvVFj9Ua1gmvdYDN3p2zUulFmNFN+E+F5K5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GvbMUAJxfC2ngJPxfsGXWXX3r9undPrsapqykpYUxYA=;
 b=pmQGkI0oTh34FL08STLDWYgIocTM8oab5FtbFaXx0OannfCpAZ37p+wWjN9fr9JvxQZ7JJoZhXMKqV1+z7Cj6FxM6LTeAYn/pYnsAHbRT7gpikxtYu31z+fR0dxGR48NskCfaBsPM61EPgoastkPqxj1AsRDBfoXEIiuhfJfusyscsq1wNFkfm8WQQDmcGyYvrm5xB35sw6R0wQP1Wx9FMOKvbVmgRuxFVba26jw+IW6y1MyljXpip3UElYKhgdAHA3brTY377aJooQdFkQ0c3lts3gq4+hI8dwrr1AY/l2JD/Tafa1ZS26G8YkIgmAU45+CT14S+Ow4Ugob9oaM+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 BY5PR12MB4132.namprd12.prod.outlook.com (2603:10b6:a03:209::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Fri, 10 Jan
 2025 06:02:20 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%7]) with mapi id 15.20.8335.011; Fri, 10 Jan 2025
 06:02:20 +0000
From: Alistair Popple <apopple@nvidia.com>
To: akpm@linux-foundation.org,
	dan.j.williams@intel.com,
	linux-mm@kvack.org
Cc: alison.schofield@intel.com,
	Alistair Popple <apopple@nvidia.com>,
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
	david@fromorbit.com,
	chenhuacai@kernel.org,
	kernel@xen0n.name,
	loongarch@lists.linux.dev
Subject: [PATCH v6 12/26] mm/memory: Enhance insert_page_into_pte_locked() to create writable mappings
Date: Fri, 10 Jan 2025 17:00:40 +1100
Message-ID: <68974d46091eea460f404f8ced3c6de5964c9ec4.1736488799.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.11189864684e31260d1408779fac9db80122047b.1736488799.git-series.apopple@nvidia.com>
References: <cover.11189864684e31260d1408779fac9db80122047b.1736488799.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SYBPR01CA0163.ausprd01.prod.outlook.com
 (2603:10c6:10:d::31) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|BY5PR12MB4132:EE_
X-MS-Office365-Filtering-Correlation-Id: 753297fb-2285-4134-462c-08dd313c582c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SyS84vGNBXVO4ENNtxfNS8fUYSJjfR04qWa0gcuIX+jqM5+nfpUWDBHzx8OU?=
 =?us-ascii?Q?Zenh0U29OD8EXDyNDsIZVDU1zGQ37fwuhiRzxHX0ArDQsuDW0mOU19J22DVn?=
 =?us-ascii?Q?tIXgYAsqjMuLofhCu4OjmtfCBIY1TjrfWKPds8OXOMpUhZf5iqwkI2SlgIjp?=
 =?us-ascii?Q?KhqkqVMzER7Xxan0m6MMMUdEvoeH5/0s81KK3eocfZCRxoXTJhXdd1NKxc2/?=
 =?us-ascii?Q?dja2sgmbCnH9nejlJZFfGslnaiqNlTr5M280bMuxMlnzptCB/HHIWPjCwcHy?=
 =?us-ascii?Q?ZG9q1Bgv2Tc6wPBd/xeCE9iJJAyB62UnLG4q88tDHmKcNfCSq7wLrAxTynV+?=
 =?us-ascii?Q?MeZNPo7PV+MD9zmMKaCI+iwtxMKSBBekEmJFWnG+LzJG9ln5rXOs72kdS8Ra?=
 =?us-ascii?Q?4OcOhfej1JYg2yJ/H4rlC2/D/r/LBvczVxlJthGcT7dhamq48Oc376eMiQZe?=
 =?us-ascii?Q?JyNj6mw+EoHNPy4IVo14XMthpM62LW7GgQ7CxFAZA0cF4ycuJpQVzfv+F+fR?=
 =?us-ascii?Q?4knw4YeFcGqzguE98SpGjeuByyOFWI0/KYI9S3jRzKjb0MNMqL+vF0LzCL8u?=
 =?us-ascii?Q?xjeyF2T2OQr5uSjQiW7oXnXOZyuCI611TbAds1RSkgx8ZktulJLOAtpngik4?=
 =?us-ascii?Q?HydtXVMjcFdoR7J5/NYLbx8gBiF3ZEqDkRJ/FeeZGgISWKDRj/ZemvDDuJzU?=
 =?us-ascii?Q?dTje4ihu8zl4i+o/pJWES1/+eqazK7crqjXu3rj4SSHxsiqVl2WxI4sqqWkx?=
 =?us-ascii?Q?lb/AodLSe55mz1r/UNFxsrv2kSEJ6W+ETZWai23iH/fs8Lf+YHECPoy3oZ/B?=
 =?us-ascii?Q?QMAMvBG1OfbJCCTPSqtzZGwbJTyBCdv9Lp4NmyWoepCdLRnlsK37xYtToS1B?=
 =?us-ascii?Q?m3QABEhh1Z2Ak5eqyYwBW0ErbFqYIDHNa0RxmA7TvbOjYvCye/HgWHxWPoW3?=
 =?us-ascii?Q?/+UlrtNi0bXxtVzG4ELE0gHE+3YQzs13yNsqx/AJR29sB0abfRvrvxo7hy9m?=
 =?us-ascii?Q?iRMCZ+eBCLnAEuwuG+5NXND47+NgY+4NzVjmCaGAOLDAroP/qvmDMTZrSI6L?=
 =?us-ascii?Q?Y+NPDeFFvexdTHdGaBVF6V1GgGULUnnYlbGrqu1bNAAGXzT6txMZ5yuJwNwy?=
 =?us-ascii?Q?kf4NITl+uD1TaartzUlVmyXAKsECPqAKZ2i+SieE4XkC2W0oLaWG3kscOUUk?=
 =?us-ascii?Q?0YyhB9NhJaZ6UTKI+pHbG2jKxePNUraVKnh5Bt5hdrJxvsF/TW2MiFgySgQx?=
 =?us-ascii?Q?9bmPQJgRMjvKuvYP8PuEaBSahQFstonJrJ214E0AvtVNQxzRuZp1WFp+hi5o?=
 =?us-ascii?Q?CPv0xQSCDy//WMBwbAZ5MoWjF6wItjnV6MTY8LKPNVqxhMQSPhNgjhTlj6Io?=
 =?us-ascii?Q?g6rDrJtFR05pMR7c7qKHfsvmHu4F?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fKV8S3rn/yJD6dETfxU3Htm0/5o1KOR6WGhi+TXNufpZaNbzu0db0mpmQ0Jb?=
 =?us-ascii?Q?fnJZCGGyNRddkz432QcuXD5KB78ACvCL+HIF9v0ZI7lF55GFjv3FTiN2wcgS?=
 =?us-ascii?Q?+/V9zePce1KBD7XrqaAEbYD8B/3J1kSmB1ojuMzwtYRtWQAbIpAXUvNoH4HA?=
 =?us-ascii?Q?xYu4+LBVioHTvaACfiDSF45FdIkPqYMxgbjzjINsDBSsYjKmnNbW1jgoFnqX?=
 =?us-ascii?Q?EiJfECnj2WmCh68IStJve+1K/2848PLBS7Qqod5TSZmKaI+a6uqYY4mLTdLO?=
 =?us-ascii?Q?Vc8NVe2QhcAZRTfJiMgr6ciTv31YNhwi/dTgaTOTZU+fh3FMJDNNg62Vd5Ea?=
 =?us-ascii?Q?gP94zPpGFr9PeZGwIpeZ0nUwzqRGOQWkgp1XoMFU99evWg57hpCH/M1Vbs92?=
 =?us-ascii?Q?umcW1OdKgu+m03khpfNqTpGNEO4Sdhir1+ckKfmup4P6zjL13lyN2AqOTzL8?=
 =?us-ascii?Q?WX3g4w/1KkEG3/a392hl+EvfwstATiIJob6kohXFDFmrIDQVLdSQLtuY0yvr?=
 =?us-ascii?Q?gtYCyrCuuYuIC8JizCRkcuAlmEVuSwwg7aGf2cdDSusBHv/Q/5xZAWFhie1+?=
 =?us-ascii?Q?daiUiEXl3lLBtS+hSrQoIl2tgN8lfQd2S0pdx9nI8GeGwKwtsJMmV20WmoeO?=
 =?us-ascii?Q?nCoJgY1WRtqu/VdUGksQfz7628WC6NwuTiWWjYipI+JFZk7doQg8kQRBS4Bv?=
 =?us-ascii?Q?BQe+VsSSlSxLk+s7ZaO694O3meP6RmNXwl5O0TX2+qNHk1wR63KCOwibpTK/?=
 =?us-ascii?Q?e1YQqdXlKUCVC6RWv3zvdvt/2PwLrLQqAyq1KCmXHvxwpJMuukhkNFZGb7td?=
 =?us-ascii?Q?+z9l+r+/50wRuCku5DPOBR3xDQ12qasaEm3rXmOJ5Bgd1cwSlATMd+4N4Uwf?=
 =?us-ascii?Q?FSBQBPl38kXjVBQfF1zfxtAlFK4HtH6lpi45xSaUjcXwSPt97GFS7h2mubIg?=
 =?us-ascii?Q?AjSSi3DOU6MWTuGxUmnHfHqF4UtJT6RhlX+DfxO69c+gXY8AXpL0jxHTKmkg?=
 =?us-ascii?Q?F8lHgv/6Jeej+Bi9riTZXXG1zKB85qyP03lo+tQmZ9JgkHJg+VPu0Xj9ISxu?=
 =?us-ascii?Q?7g5YI9xcaCZ90/ZL3sDLQVhEEz29RsVyluhLjTDxKBajhC3C2GLEyy36fshJ?=
 =?us-ascii?Q?ZY8UcTXiT9RSXsWHbyg+PiriGSxoUC1ZV+YAKRLh7jbHNBQP+iRRBgT2Udes?=
 =?us-ascii?Q?7dZMmKuNzCPzWWaQy6DLGvbRCSgfcElOsYvSblVGgwq2pFaL+WVwztT3t1WF?=
 =?us-ascii?Q?U5Y2UmD+WKVPumLPHW3wWHdygeM2O+/a+XzuFFbQBDwKN1BWmBTAW2Llm+4z?=
 =?us-ascii?Q?TkfMkUiWUcmupP8n6z6451ddJ6fRsGTcwijNjErUfKzZI9GRvdrcWp9mH4JE?=
 =?us-ascii?Q?N102vtGQnyQxfDOxPMZySP2dsAsEoTIJ11N6SW5dEpb+RYOgu9A3HmsEml9w?=
 =?us-ascii?Q?IbwYP9UZI4mn4YUTduisRSmr6YXWrO5YYahGAHLjkWhSugtLoRfovqjVnPwh?=
 =?us-ascii?Q?Vs1abgkIpbBoVLnwfKtW+0Yf7Adl9VUDThcKjP0s6CtmQsFyqOiQpLyTIqlE?=
 =?us-ascii?Q?EYec5kBOPuY/vjofuKTg8nsY069dQrTUsaXzLpcz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 753297fb-2285-4134-462c-08dd313c582c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 06:02:20.6797
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1STWTcYIrXMOy/zmLCZsPE/VLFA73pcOuhsPGr+iAHW1mcTHf367ZykIwAHfmomQjeXnJo32M8vf/ta2TzbJOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4132

In preparation for using insert_page() for DAX, enhance
insert_page_into_pte_locked() to handle establishing writable
mappings.  Recall that DAX returns VM_FAULT_NOPAGE after installing a
PTE which bypasses the typical set_pte_range() in finish_fault.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
Suggested-by: Dan Williams <dan.j.williams@intel.com>

---

Changes for v5:
 - Minor comment/formatting fixes suggested by David Hildenbrand

Changes since v2:

 - New patch split out from "mm/memory: Add dax_insert_pfn"
---
 mm/memory.c | 37 +++++++++++++++++++++++++++++--------
 1 file changed, 29 insertions(+), 8 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 06bb29e..8531acb 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2126,19 +2126,40 @@ static int validate_page_before_insert(struct vm_area_struct *vma,
 }
 
 static int insert_page_into_pte_locked(struct vm_area_struct *vma, pte_t *pte,
-			unsigned long addr, struct page *page, pgprot_t prot)
+				unsigned long addr, struct page *page,
+				pgprot_t prot, bool mkwrite)
 {
 	struct folio *folio = page_folio(page);
+	pte_t entry = ptep_get(pte);
 	pte_t pteval;
 
-	if (!pte_none(ptep_get(pte)))
-		return -EBUSY;
+	if (!pte_none(entry)) {
+		if (!mkwrite)
+			return -EBUSY;
+
+		/* see insert_pfn(). */
+		if (pte_pfn(entry) != page_to_pfn(page)) {
+			WARN_ON_ONCE(!is_zero_pfn(pte_pfn(entry)));
+			return -EFAULT;
+		}
+		entry = maybe_mkwrite(entry, vma);
+		entry = pte_mkyoung(entry);
+		if (ptep_set_access_flags(vma, addr, pte, entry, 1))
+			update_mmu_cache(vma, addr, pte);
+		return 0;
+	}
+
 	/* Ok, finally just insert the thing.. */
 	pteval = mk_pte(page, prot);
 	if (unlikely(is_zero_folio(folio))) {
 		pteval = pte_mkspecial(pteval);
 	} else {
 		folio_get(folio);
+		entry = mk_pte(page, prot);
+		if (mkwrite) {
+			entry = pte_mkyoung(entry);
+			entry = maybe_mkwrite(pte_mkdirty(entry), vma);
+		}
 		inc_mm_counter(vma->vm_mm, mm_counter_file(folio));
 		folio_add_file_rmap_pte(folio, page, vma);
 	}
@@ -2147,7 +2168,7 @@ static int insert_page_into_pte_locked(struct vm_area_struct *vma, pte_t *pte,
 }
 
 static int insert_page(struct vm_area_struct *vma, unsigned long addr,
-			struct page *page, pgprot_t prot)
+			struct page *page, pgprot_t prot, bool mkwrite)
 {
 	int retval;
 	pte_t *pte;
@@ -2160,7 +2181,7 @@ static int insert_page(struct vm_area_struct *vma, unsigned long addr,
 	pte = get_locked_pte(vma->vm_mm, addr, &ptl);
 	if (!pte)
 		goto out;
-	retval = insert_page_into_pte_locked(vma, pte, addr, page, prot);
+	retval = insert_page_into_pte_locked(vma, pte, addr, page, prot, mkwrite);
 	pte_unmap_unlock(pte, ptl);
 out:
 	return retval;
@@ -2174,7 +2195,7 @@ static int insert_page_in_batch_locked(struct vm_area_struct *vma, pte_t *pte,
 	err = validate_page_before_insert(vma, page);
 	if (err)
 		return err;
-	return insert_page_into_pte_locked(vma, pte, addr, page, prot);
+	return insert_page_into_pte_locked(vma, pte, addr, page, prot, false);
 }
 
 /* insert_pages() amortizes the cost of spinlock operations
@@ -2310,7 +2331,7 @@ int vm_insert_page(struct vm_area_struct *vma, unsigned long addr,
 		BUG_ON(vma->vm_flags & VM_PFNMAP);
 		vm_flags_set(vma, VM_MIXEDMAP);
 	}
-	return insert_page(vma, addr, page, vma->vm_page_prot);
+	return insert_page(vma, addr, page, vma->vm_page_prot, false);
 }
 EXPORT_SYMBOL(vm_insert_page);
 
@@ -2590,7 +2611,7 @@ static vm_fault_t __vm_insert_mixed(struct vm_area_struct *vma,
 		 * result in pfn_t_has_page() == false.
 		 */
 		page = pfn_to_page(pfn_t_to_pfn(pfn));
-		err = insert_page(vma, addr, page, pgprot);
+		err = insert_page(vma, addr, page, pgprot, mkwrite);
 	} else {
 		return insert_pfn(vma, addr, pfn, pgprot, mkwrite);
 	}
-- 
git-series 0.9.1

