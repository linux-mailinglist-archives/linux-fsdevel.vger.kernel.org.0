Return-Path: <linux-fsdevel+bounces-42815-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5162AA48F82
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 04:36:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F51A3B869D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 03:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A50E1CAA65;
	Fri, 28 Feb 2025 03:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="L9u/dcB6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2046.outbound.protection.outlook.com [40.107.92.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9EC1C5F1F;
	Fri, 28 Feb 2025 03:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740713545; cv=fail; b=ccxUeA19yoJ44GBg1IqzkVfcVOSrewmeGkPp6v9xpOWGxsbQZCQ2GIDK7ttzG3qj354dFoi0xtohuNDDQ05EtnFjDpJIGkR4LhSXazuX/Cme4k23uY8jqJ6gc00ATXgDlALleCNVacKmLqzEPlr4u61pOFaUAwWXPE2cNfocodc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740713545; c=relaxed/simple;
	bh=P/QQbn4mRCiYCkUUlrSYmHK3j3m73UFXSWrT3MHQtEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SajlxBZs450FZiqpQXrmIL5lFGrFZZrl5baSGT59GSHej/eBwNY4wAz7Y1Jpd0rWin13IGyWlxvq0lVSu+GPYvtUIHiFfHMNZfhhGXKjDd79Au8GMIy0DSQMeS7J/FtZc6DPpifddg7Xy43eHEC1RwLpdacyAtQBqTvxCpQPqE4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=L9u/dcB6; arc=fail smtp.client-ip=40.107.92.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mBB+97phwKzRvIZZyzhTDI8NhAo/aQhokC9bsOgShYQe/vSqiPrx6hOJ9W/SzrBu8ZkfHZyUoI3ivj6WUEus6j9UvY9K1tDaZDB8vNWmHgBSJg+/K+JrAaefkidv9APUQnyMSUbbtwjIq5rayje+uE5pRHisAnpfeRFn8KVL7EEiT5/RqtIInSh1HorKzmev8ykLtZXotGn5T0TGYjTx6rN40MHx2VzVqpZTgUOHKTRFm27HGPDb5OB5EBmrrIuQFsAhUJvvqGmSMv/dUe7xlMrVQVpXLQBY0/I40Y0jLk4vfRcPIhzuW9pBzfRgpU8Yo+LuNud8Jr1Th8ZIIVuEBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yNPEvAsPe8G2yTsS4zF2Ou6m25axDDKUOssAOYWV7/4=;
 b=hoD309mzoTJNaNwIVVjus9IQez8Mx7T3cy/otkBlaqOSgPsKRiQB+4yyT3Ia8ch/oeGvpsgVwqeHMFu5EtqFLr++8XwdGuZNXkyHjL02LOwLFHR9iMaLG/i1Cu5VPkzsZ89Y+u+nZiXG7B92I9ueYzhw3krlOcZ67kvtJ3xLvPA+rmluNOLopiHhuiIroXbZN8tOB36hjnq9PSzJLeXVqqzXycRlfgTU9+IWSWN57BqtSx2JaIoPMiJJqwpyY664YI0/TFq41HoWtlDFNZTHRXCmJmXmsvhuGYeaLFIQbEwBbjXxhugrJGZ6loPrl4lCnSsWiiBnRjF0efJckNTi7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yNPEvAsPe8G2yTsS4zF2Ou6m25axDDKUOssAOYWV7/4=;
 b=L9u/dcB6w8plRd9kbTR8spcNO5FMuRTFP9+YahZeMdtlXwmQF8IEGbHlqKb9LTLU2pc5L/Djd7CeHmT/MQIAhm6T9+NG4V3+o1rPfPqzkvxCLPcwwFExEItNDlVCVRLuKigVCDWX5E8F1PT/hvoRJ7E5GDnlXQagZALXAVgDDbiaqEjnFDaJH9kvGNlXExaWlB1ofGNc1GoabrJBq5ec9fuWvc+gpNOAj8X8j9VfpYQPwOBOTSJP485F9Xg2bAhsRa53bz13+fQ50P7XNFApLdHd1bq2WXiiTIxZ/IOOiV5a7L8ZeMNXgvnepXlyMDYAq44oHdek5uulBv9eie/FaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 SJ2PR12MB7991.namprd12.prod.outlook.com (2603:10b6:a03:4d1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 03:32:21 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%7]) with mapi id 15.20.8489.018; Fri, 28 Feb 2025
 03:32:21 +0000
From: Alistair Popple <apopple@nvidia.com>
To: akpm@linux-foundation.org,
	dan.j.williams@intel.com,
	linux-mm@kvack.org
Cc: Alistair Popple <apopple@nvidia.com>,
	Alison Schofield <alison.schofield@intel.com>,
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
Subject: [PATCH v9 12/20] mm/memory: Enhance insert_page_into_pte_locked() to create writable mappings
Date: Fri, 28 Feb 2025 14:31:07 +1100
Message-ID: <f7354fd9c2f5d0c2fa321733039f9f87e791023e.1740713401.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.8068ad144a7eea4a813670301f4d2a86a8e68ec4.1740713401.git-series.apopple@nvidia.com>
References: <cover.8068ad144a7eea4a813670301f4d2a86a8e68ec4.1740713401.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SYBPR01CA0146.ausprd01.prod.outlook.com
 (2603:10c6:10:d::14) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|SJ2PR12MB7991:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bd29e86-fef4-46ca-0908-08dd57a8822d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CxtFFC9aCUAnMKS9Hz4xjpv8X/FLsEMac8vKJL8HQTEJAXBWlp3FyW5HWjSH?=
 =?us-ascii?Q?gk0r6NOlho3C3nCLWFQSYIKfmbc4ByMzKlh7dkIu/1N9Zi7OPxmQGZ8I5sRA?=
 =?us-ascii?Q?enX4+ZgzZo+soIPPp4Li+8L/JrgfIoN8yM1KYQocnKFm4gMb72XWizxUoyqR?=
 =?us-ascii?Q?SiueyA0F5zVvA5UW/czYVJc+rO0W8zbUPRla9iv8f21D8hiB8Ygi9uXiq7Em?=
 =?us-ascii?Q?cs0nAF0SEaJrK8agBvxGzz+7m9dWKfNj9homcF/b50hdD/FUkbpfBQYp4KhJ?=
 =?us-ascii?Q?uNMRaQV54XE86cGVufJ3VjxIhja7Buxj+wymPbOCDwxR2yoQ+skUvB6jdf42?=
 =?us-ascii?Q?JQH3i1EoafI7zenJ0R037gKGjq2CrqFYNR6wgCKdODyO63Gfap+wG5x7puU/?=
 =?us-ascii?Q?FpeIgx23KZ1qJQE5xdR0luJvVEo8IM/WD0tGbp7r+yUndg4QrNBLTOXwkbh9?=
 =?us-ascii?Q?FBeAZNAZP0tVbVLMU6bmU89q6qqiCEGjL9YWSp7jol9VyFZLHBtHiL3boqRX?=
 =?us-ascii?Q?geekouRnqFCukdFTQmsU/kVOgOwN2P1pTriuhlSMJbF0veIXFYG/ngO93HzP?=
 =?us-ascii?Q?f0cRA6gi9X84w0NrZpx9UN1MopxeO/UTcGTzBn4/XWHWV2BywLFJ+HaIyVcu?=
 =?us-ascii?Q?qt0Q8g9LOdoPKkIp9zEwtzJRW5QjynG5GwVDMtgLk98OskcMSfLr/wBSkIiL?=
 =?us-ascii?Q?ljlYE3pTIC7VxpiY3v164PiWOdRg/XJVwM2gGLGXtyEXL9kKZGRX6gfII9hi?=
 =?us-ascii?Q?9RBXXQe6Ag8F43lVbbSk/3uKJLR93hp/HyW0X/NK0N6J+BZHI0c7IMiRTc2w?=
 =?us-ascii?Q?5FQkgVDiByG1RsvsjlfjVD/rvnXl5KgTt33M7R1zRkfhP+BIaqduCkuduFra?=
 =?us-ascii?Q?xHlsRrdtQADSOMChARQuqE7iX27l/VDzTYP5P8cgJg0/Dozz07tMPPWmBDlu?=
 =?us-ascii?Q?PXZ1eEkier/KXX+OsZvd+zgvHXHQxsN5/Z4NyaRzuSfXIO4DnBBXvm+Yz/NE?=
 =?us-ascii?Q?hEFTSzH6SazrJm9HWYSKOOTjVMtbVFSt2fusL2EcqvFZRXT1lyL3LVQw6y+Z?=
 =?us-ascii?Q?RJAbbdo1nyJjcQJLal2HEWpkiELCPAYBR8VatqPEmavWCdVzi5lh8tcIlhTJ?=
 =?us-ascii?Q?b+f3eMg3BIlJ4lSxuxulsdJeeNzHiuMYW9/Cz7dxaWwz2S4yXjApYLn5TwCT?=
 =?us-ascii?Q?Df//NTTVqZPimZxR+mzu3HBkEPm08i2FBm8pJZxRyF/s1IsRaiyFhUeJmzE1?=
 =?us-ascii?Q?94DGulnvx/51fCK5fApHw1+Uhrl2IohKB8yfgZCDk1oVb2AjLVJN48OpPzXh?=
 =?us-ascii?Q?hZbtD9rJFMJD4sTOyuIMygIFzIWX1g1aN4ax8R9hoazd/iy775ktEmqqHa6v?=
 =?us-ascii?Q?WjNPLvOU5gedgU0WaPuKDNImcbdE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xLFgM3yWNTSzfS1255VgCfHHTHATH8X1NRvueVWfhfmvc0Fs/xlWOFUYIiqX?=
 =?us-ascii?Q?MeJOO87zXX54eUaqpJHiJCxVNnas2NyZxfYOa//B+T/+xxggngecONO9OiFv?=
 =?us-ascii?Q?xQ5rN6TQG7aZ2R8HdSdeQRpb7m81Ja3+hLGfBXD/59oxiBFekfkEl+Nk4+gn?=
 =?us-ascii?Q?l+PMx4VvHdoeUjyHLrK25l1iM1cppoVm1aLBXw+eM8+WrTCa4AvxRIDghRBH?=
 =?us-ascii?Q?Z8xDaQ+DD83ZcHJ6WdGbQXsCQp47lz4F8trfhWTxACQ4OY2ohjUclGU4rKSX?=
 =?us-ascii?Q?Jx3Ny0eGMfggN4pelDYGW9JOka5fH4FL/C3in4ysRgjmkbeiqlypuzRv81ZY?=
 =?us-ascii?Q?2iHVL/hB+TF2B78NlAq0mqNAHoSJ5E853rEcRup0cPDuql2Gb7w5zwWb8UFg?=
 =?us-ascii?Q?VIKetWXLOo1ZL3jdrmoXOY19yugiw1wGKl/zPlrP/UJJoYB/WqQDJ2zgOC/M?=
 =?us-ascii?Q?RXbgpvK7whBScvlywfHllOpEmA0Mu+OBpcK42WpBFoT1e7pebQWBZ0xpi9Gu?=
 =?us-ascii?Q?V6irO7g+ggo9ffQt7+tOanc+CCPhycQ+erPRcbu/YWFUdiKyqp5HChL6SqDA?=
 =?us-ascii?Q?Z5U3hqOJsjjRmnAG+4dGc9O9anmT58yxay1AL/RGaSW6HciNSfa+umVeG4V7?=
 =?us-ascii?Q?e/NWpszwqV07uvponzPl2iDD7vXBNMpKe3bDY4fE4KbFPZZ9tYHz9a2dx0oG?=
 =?us-ascii?Q?WtilJWU09XKVT/Q4ALUO1ku5A2hpDquoZz7XayxBIcusDk8vJExhfxN2VQG7?=
 =?us-ascii?Q?bmCoULIF35A76VCd1/Sn+aat7gDn23bk6tKGYGnzrrYv8lw31nwIUwD4jcxN?=
 =?us-ascii?Q?Ty33O2HM3/0HeLEBadcXX4TCYVHJTYtNO/rMlthHhYXcXz/xtjgm/5wmWWE0?=
 =?us-ascii?Q?l7V+qTr6CeIgT3TmmidUeyBwK8LDxFaO3a9RLwzDOxD3DeV29S0QIq5JakiA?=
 =?us-ascii?Q?Ou3Ny/a30y94RH/hHsU0DylVhEm2MSSEGFqJXT9SBfQOW2y37BJIc9n5ZIOe?=
 =?us-ascii?Q?yk2HuiIh/3tsp/anuFS1x+YV++lXegGSvkEewjd7r7KXicpwmz/IfNrj1c3T?=
 =?us-ascii?Q?9Alo7PK49xSJSV8fnmoM6ecGQ5sLYXwl7TScDI0VhbYcnnEeCb2v12c2B2Op?=
 =?us-ascii?Q?vdZeDH3IoHbCElTn9Nrqzwc0WheY95MHCXEne43E2i7VVLEPQKhlKKhXI/C1?=
 =?us-ascii?Q?GN9ITlk4Sa8oIcuBLC5bzz7diOqYcdpViRJT5IoZMBw0R8jUwaFKgiKx2qVl?=
 =?us-ascii?Q?X7Zv7A2esDRsUiAq/TKcvczMlRB1iYfItdCx6KnZu1vfbYOLM6UMtkjYdVFh?=
 =?us-ascii?Q?t+I16MVrDCp+59ar0rXy7cK1PMP7unVWIAKQrPbhahUIGvedIdY/nw9Vjo78?=
 =?us-ascii?Q?ge4rfDgmsRA7UHXDowg+u8/agWV3nyF3e1P0yBI0CqpnJcHgwWd3TCtFi1/A?=
 =?us-ascii?Q?Eih0EOQ3kGnCOYveTm1WJcU+g5II7Phbzxli9Z1SVIbKnt3jkzEcm6F7TsBV?=
 =?us-ascii?Q?ILm4IpR9vniWak6k1dnX8lS235aeATOWcH04ExCGwj4g2azJ+v8DqWSbwpxn?=
 =?us-ascii?Q?KLI0aF90uluuNCawA0/g01aHDhq63QbTm5rVxxtZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bd29e86-fef4-46ca-0908-08dd57a8822d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 03:32:20.8961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lr6H7zMdW/ylEQS4aKCpEL6HkQxzqxLuP8a4ebLDsSxQ086EphR/kCyg4jvAE1icg4I79nrnJzWodrHhdiM0LA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7991

In preparation for using insert_page() for DAX, enhance
insert_page_into_pte_locked() to handle establishing writable
mappings.  Recall that DAX returns VM_FAULT_NOPAGE after installing a
PTE which bypasses the typical set_pte_range() in finish_fault.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
Suggested-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Acked-by: David Hildenbrand <david@redhat.com>

---

Changes for v7:
 - Drop entry and reuse pteval as suggested by David.

Changes for v5:
 - Minor comment/formatting fixes suggested by David Hildenbrand

Changes since v2:
 - New patch split out from "mm/memory: Add dax_insert_pfn"
---
 mm/memory.c | 39 ++++++++++++++++++++++++++++++---------
 1 file changed, 30 insertions(+), 9 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 905ed2f..becfaf4 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2126,19 +2126,39 @@ static int validate_page_before_insert(struct vm_area_struct *vma,
 }
 
 static int insert_page_into_pte_locked(struct vm_area_struct *vma, pte_t *pte,
-			unsigned long addr, struct page *page, pgprot_t prot)
+				unsigned long addr, struct page *page,
+				pgprot_t prot, bool mkwrite)
 {
 	struct folio *folio = page_folio(page);
-	pte_t pteval;
+	pte_t pteval = ptep_get(pte);
+
+	if (!pte_none(pteval)) {
+		if (!mkwrite)
+			return -EBUSY;
+
+		/* see insert_pfn(). */
+		if (pte_pfn(pteval) != page_to_pfn(page)) {
+			WARN_ON_ONCE(!is_zero_pfn(pte_pfn(pteval)));
+			return -EFAULT;
+		}
+		pteval = maybe_mkwrite(pteval, vma);
+		pteval = pte_mkyoung(pteval);
+		if (ptep_set_access_flags(vma, addr, pte, pteval, 1))
+			update_mmu_cache(vma, addr, pte);
+		return 0;
+	}
 
-	if (!pte_none(ptep_get(pte)))
-		return -EBUSY;
 	/* Ok, finally just insert the thing.. */
 	pteval = mk_pte(page, prot);
 	if (unlikely(is_zero_folio(folio))) {
 		pteval = pte_mkspecial(pteval);
 	} else {
 		folio_get(folio);
+		pteval = mk_pte(page, prot);
+		if (mkwrite) {
+			pteval = pte_mkyoung(pteval);
+			pteval = maybe_mkwrite(pte_mkdirty(pteval), vma);
+		}
 		inc_mm_counter(vma->vm_mm, mm_counter_file(folio));
 		folio_add_file_rmap_pte(folio, page, vma);
 	}
@@ -2147,7 +2167,7 @@ static int insert_page_into_pte_locked(struct vm_area_struct *vma, pte_t *pte,
 }
 
 static int insert_page(struct vm_area_struct *vma, unsigned long addr,
-			struct page *page, pgprot_t prot)
+			struct page *page, pgprot_t prot, bool mkwrite)
 {
 	int retval;
 	pte_t *pte;
@@ -2160,7 +2180,8 @@ static int insert_page(struct vm_area_struct *vma, unsigned long addr,
 	pte = get_locked_pte(vma->vm_mm, addr, &ptl);
 	if (!pte)
 		goto out;
-	retval = insert_page_into_pte_locked(vma, pte, addr, page, prot);
+	retval = insert_page_into_pte_locked(vma, pte, addr, page, prot,
+					mkwrite);
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

