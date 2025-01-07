Return-Path: <linux-fsdevel+bounces-38530-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69333A0364C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 04:47:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CE421608FD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 03:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 862421E5729;
	Tue,  7 Jan 2025 03:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ofGWUPxo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E102B1E8836;
	Tue,  7 Jan 2025 03:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736221443; cv=fail; b=I/AnSzIZnqpbJyJyOMLSendtikBtFj04sbS89l7czParYw+fr7fyv/Fqf55mKDMufW5KWNstQnYs5bnP86va4Qjl1ezysRv4vsJBvu0iS4D8EKRjDueQoa7ZSfJTXmqU9u2IztL/1Q9UAOfg9Crq9Efucam+SsQmeCgvWx9yF6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736221443; c=relaxed/simple;
	bh=F7ds27O/WOAL8W2IRVtn8s3XEgVUVn6R+d2P4WWTdEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MRVk7bGQWZp8p3kLrraNQ5Pv6O+g1GLD7h9RTVwwBppo2LUDRjn4Da14Bm+TjS5rjxjb5t1SKeSQ6P0Tb+VxqR84ZXyUzRFBC8iWqXyt/a+65u7ebCQTBdL0Tlf+u6VrlAZekuUIOjAUHdJJXdcf0XW8rzXbMMsg+G1MpgZyWvc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ofGWUPxo; arc=fail smtp.client-ip=40.107.220.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F6hDZ5R2koBnf7vYTnj8T2NJdA2CTaORRKTznw6MPHFY1oDFwn/U+uwdba6lTe+MjGJ76BdJ/sqCsJJbGJEzk6z0xMIWrcrWH0rpKxMoauqJLOXvt81lY8FH6kB9K3rE+EodacF57rGMVXrOwFo8ELUd7tD1EPUKjYeOUrzMHnXQbug9OVw2TLk2H6mOnCkXp0bBiICr2BsNgBAsTv3EQ7q4HEy5J83jJ6GobXylr2fq9FZr7QkdHPDPjE9bk5P7GHeJlSxHJi/hs4hOsT/E3UKn7+6Vsh7JClldIXhNTbc7JekdEVASikfDgo20DdER4MTNv00fDrCR7FeXlcNnVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GvbMUAJxfC2ngJPxfsGXWXX3r9undPrsapqykpYUxYA=;
 b=FAWe3pViAGo9DpB/qFxhhQhOJhSAkg81+24nKSlRbbMRNpsTb9srxQybB1DnPO3902cgJyPTUgFaddeo3WzccicWCHT/Alh6VA2YrvZYNc2axWFS1X4jLXLxmkdzP/swtjeowmfFbUx+scZczMcITfv9YjZ62kc1a9syGwRswq510qNdevtPNsHntwxRqtBBLKFR8M37d4TJK1CgDQee8HLU0zhGfSyEMjP1reqfaXLlcfw6Htf4UUBzo9dT8VM5+c2OLdDaGbN3VCndN0R/7f+qPyOp9/qt6mI0KNJRvXFjrrfz8vkDCDlkVfV7wJtC8Z02Al7s0TlDOmNkAHOefw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GvbMUAJxfC2ngJPxfsGXWXX3r9undPrsapqykpYUxYA=;
 b=ofGWUPxolyNOdDjzIP60f/v2E6nrYM38y7arRMLFRhQ1ep8sivPVWaIjZCzw91MXPKSM0eHENovs2iUF5z1FaZeJT8DrqQXSie93SkSQuunqhOaqt4e1mIcG0BcdN+2S0LoLGuUhzuCMYRDV52LB55TYCY7hnepJLCQ1OtZVz5Vyv8tUzc0JR4Tujm/GK5iQYUQBfS2JAcHUNvTu99/pWC9rDxl1GxT9DKcDksbWfw9uY0kD2DL9mw823kLnwOKwcLdp8UMtacleoln2dQcw3mhdxeNwm9WjeUw6+zzdoEL0aEiDYJGQn897wXpNEInvMMqn0xpxk9Jpmm4Gu3aCww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 CY5PR12MB6129.namprd12.prod.outlook.com (2603:10b6:930:27::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8314.15; Tue, 7 Jan 2025 03:43:53 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%6]) with mapi id 15.20.8314.015; Tue, 7 Jan 2025
 03:43:53 +0000
From: Alistair Popple <apopple@nvidia.com>
To: akpm@linux-foundation.org,
	dan.j.williams@intel.com,
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
Subject: [PATCH v5 12/25] mm/memory: Enhance insert_page_into_pte_locked() to create writable mappings
Date: Tue,  7 Jan 2025 14:42:28 +1100
Message-ID: <1f41d6cb93fc3db54eb0dafb66fd6f7203249239.1736221254.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.425da7c4e76c2749d0ad1734f972b06114e02d52.1736221254.git-series.apopple@nvidia.com>
References: <cover.425da7c4e76c2749d0ad1734f972b06114e02d52.1736221254.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5P282CA0198.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:249::22) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|CY5PR12MB6129:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a6f16b9-4c4f-4009-b062-08dd2ecd813e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UdS5HtxM3+LzKh52q1mB/OyIbBsCfolhMPE7Dlq1knwsR48h+chz4vC9Rf0C?=
 =?us-ascii?Q?fPTTNfZuAuWhUiv6OF8rrKR8k2wluKPQZiMoQs5utXOjEI8o1tq10jvLD1b3?=
 =?us-ascii?Q?qEaBR2Ss9Z5tk0BxYgAEkZvO9Pj75Ee7sXjiUcywq9XJeVFHJ0wltQoPF6+X?=
 =?us-ascii?Q?G0PzSFnIxSCEmRStZJab4hsPrhrRaC08zBHt8Z8r3j//eAyDBcM7QYtRS4Ez?=
 =?us-ascii?Q?pJDkpFB29VuhesdTzCbKvKxK6TUS/JGJ2G6vnV5VNwuDdOZQ3HVFxaoK0tOy?=
 =?us-ascii?Q?F9w3t2DhP92uNOvky7il5lmoSkELnnzJ+baUkv94UbatQOi1psLJ1Fu+iV/n?=
 =?us-ascii?Q?vrDoTSfp/m43cdrwyrU28RVF7657jrUr/Eq6udKc3S+BNMYP/FSUdZ+CphSH?=
 =?us-ascii?Q?VsHdDPLnn2VaC+6KTz7bNBfQFh9WTQ32zANAdb3XZjOxIs+4U9U6GZwomkbb?=
 =?us-ascii?Q?tsVbyULglcTk5LNxjCjNSjc/pS3k/69W1iSiQAzT2iVs6hs1q2wVYK3rrT4P?=
 =?us-ascii?Q?NiJWtTFIf7F2geXyFMPVJWROtufuGIYEIPLf+Uv+3gxDJVWlVStsEbCGf4yf?=
 =?us-ascii?Q?E88l5nXsPy1C+x7SAyKubHqqFvqGlUl5oVS4CGnF5uCEto7B0PHlq4T3pAfB?=
 =?us-ascii?Q?+MkPc6qUlfDsAhUxENPk0vwLflD0fza1JPkgwap0is/lyJOt/a9sXUWYdgRx?=
 =?us-ascii?Q?2SDgURZ8qGZBPt5ALQhQyN7S8hkxwg18wnIL8Uhe8l+ywimp5hz4KpNL8Dlw?=
 =?us-ascii?Q?8a85khpPzp+fMXvVn1oBzZeSmhBBCp0rkQEznOv8nJaWygYEsO3BEYtkzFC1?=
 =?us-ascii?Q?1fLoitczX+xs/YOpNzg9rNdY97tDG9KPmDrM6NQ7yMZkO6XNhN8jqDOx+M6X?=
 =?us-ascii?Q?+bPS8AR/vy8MDUoWMDdFz+bn4DRRlDSFfe0H0CDaz8RzaZJHFV9ngvN7j1f3?=
 =?us-ascii?Q?7gnKH0lcXqVzQXd91T0LCjxeedGvFT/uB0ULfbYNRxkIkocQVOxS7ZG0orun?=
 =?us-ascii?Q?s5AC+p+zXPemO5qD6vGu9ALhu00gNw4ps9Hr1V3KZA+JhJWtv0JVshrbYBSf?=
 =?us-ascii?Q?+kCTodfb4zEqldq8/iwzfabUMZVOmGBVT+raKDIbt6F0JDIUpNZ1YvbdXdwH?=
 =?us-ascii?Q?+nTRcxIXg6tKjyaqs0xERiNdo2AZBYL5cQtS/WEhISv0wpvqROpDJrE76OEi?=
 =?us-ascii?Q?pglFE/nrsKyIjgf0NQBlq+lzqgGcyd+anuO5w6xKwLGUTR8LoCzqxUezwRps?=
 =?us-ascii?Q?ykEgCr49NT9vokqJb1OlMQWS863Q5xsfqswlnkcWLLaCD9gImC8Vnlimp38V?=
 =?us-ascii?Q?b5xmY+BYqBbCrH4/d62RTCETGL1siBmUNTM1WVPml5FTrFADaUDb/nKKAZxG?=
 =?us-ascii?Q?QQtwAMVWl49z5KZKmoof6BCqLlRS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JOax42wvT2jWhletQQEP9ASUilnG98s33+IvyaH4O8cUw3kpeL0P3Angk3sn?=
 =?us-ascii?Q?zSlMnIF48Y9NQ9BxpU/dGo0AfEP7Ar7jrJHqebZmeFr8ukMi8xdsmF9CrpmD?=
 =?us-ascii?Q?nEp6bYcFq9ZJxsMFI/H3bnwvOmHz0bY8J7N9M0GHp+gEZZkY+LuAMX+AuV99?=
 =?us-ascii?Q?ow9wJ+vVd/3JWQ7uElDMTuqFP0fulhJ4U2iy6dTKixCC7BXinBjXJ47DCtPc?=
 =?us-ascii?Q?9hXbEdWWaStGFevCsEA2JctgOuYPCyrCJ8SXXXkW3zHQ9pGyXO1Mfau29fJA?=
 =?us-ascii?Q?tLIcPaKUzG/HGwDeQyq2xhDsOvwJJNyC9Xc+UM6Ol1hP2neFHqzL++Ibuy9v?=
 =?us-ascii?Q?stAvSRy4W6rHYBcdMYITJKoZSrgr9O4yWNutazj/cf0DFRcayszMXqa5h3Bn?=
 =?us-ascii?Q?WOnIgbFxFzBXT1oqxvhdx47SazQhgpqjH/z351CwWpTaj+ZR+5nlW3ROYryq?=
 =?us-ascii?Q?YL+XWTJPUZR8h3eI5vopNrdZxsubAn9WIrLU+y/0DnpnStmgwAAEqPDQG1Jb?=
 =?us-ascii?Q?Vni5wnptui4ixAe7yK0nlk5XtYMsgMGiCPe0lt0MoQtskG4yVF2FSffpnr/6?=
 =?us-ascii?Q?2iNfAGlhS+PmCZnYx0gJ0087qfJMGS4kdyQbfMB4BboyAsfr/jcTP67M6ECo?=
 =?us-ascii?Q?24IEQQ1nACpDYwVFMmIy/8lnD4JliHZSzZxQI/nT33fh81lKohQLvnUgVj6F?=
 =?us-ascii?Q?4LtZBVZjgxh0mmPPWVIX9AtBZ5nVffuEwUwpU2+6ULW08tXI84OCIQfoT2FD?=
 =?us-ascii?Q?X1ZxlRRyzfvU0wQXN1cVT6A9+v3IFL74+afx+WfOWQzJ7W4oiD3DZ017dwBN?=
 =?us-ascii?Q?4Dgxf24KTojuDs558shj+kw8Z8UtWxFE2ZStgO+G7DGoqXjZT6Qz2t9YwkAZ?=
 =?us-ascii?Q?Ru65E43YVNE5BkBun31JNg/PE2/kQz79joWfSd/WIHsO/cv6qtHMhaVNjAHS?=
 =?us-ascii?Q?C7zqjc4br4AJiJfycAJQWQwhGh4L/yWmXN68WNeR8Z2Wzsn7mqqT7+CsIVfK?=
 =?us-ascii?Q?kAnSUUcwi3bHl1ciaR72EpVERoWG+jArfAm5b+tPbX2Wg0Q6Qcz3XU8kheCn?=
 =?us-ascii?Q?5+ofRdeJiqYayie9k9CmUqrtzWRwFjylw9Cx9yO3NeXjGF+/vxEMNZG7ndeT?=
 =?us-ascii?Q?PRb2SZsnBX7UvmaMkJq8nTpvOrPu41LmAmYkL8yajAlCBygUo9qqxnTLjSud?=
 =?us-ascii?Q?hsDYO5SQkS9pFXwwcp2++zWrcRLmFlue0fR2JMIKbPhgX2kt/xd1SGn7xIVI?=
 =?us-ascii?Q?df5VdqK2pfBul27THPoiTshCYjMDFnezUXBmYE3uo55PXVzQTyKsQcq6zy3l?=
 =?us-ascii?Q?dEb2MSnvLb2ob9pupdDVWa7kMvuS8PXiTKRs+kgTv7O0eaWqs3mDO79H4vfe?=
 =?us-ascii?Q?CCAP9LnUEuVgkpb7LhZLLXAKcXfhR11lnaXh0b4sb1cTUIuZk+MS4qP6yjsg?=
 =?us-ascii?Q?elg9CFB6i9e4QgD+VqNFaAhnhnOKXc9IiVo1Zqv915E9p6XCBgTNHT4pdUVE?=
 =?us-ascii?Q?asisFYdyJdDF8xWMlbMHpjPfb8RCaOv1GAKfCPhjKjAQ/yk/LtSvcNG2cJM/?=
 =?us-ascii?Q?4fFOI4s8vUZ94Jrj+TqIF++63pLicTtE5E/ff1wz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a6f16b9-4c4f-4009-b062-08dd2ecd813e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 03:43:53.1365
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rSUu6GNu+qYHH0vLG0vDp4VmmD/TYvNPccBxvE0JGA5qEXsE3uLxIKQQbUq9JFkcS66r8iSEPcFvXsEauV41zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6129

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

