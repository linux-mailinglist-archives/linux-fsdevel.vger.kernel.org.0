Return-Path: <linux-fsdevel+bounces-37577-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65EAB9F420F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 06:15:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE7AC1888FFC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 05:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B799618754F;
	Tue, 17 Dec 2024 05:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JqIbO7y5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569FC1714BE;
	Tue, 17 Dec 2024 05:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734412427; cv=fail; b=ikGI98GhUm8PG9pVbltB70OchFZ62EJ37h8tnUA3eOoB8Rosd1SS2k9D5b+PwxwETJ5aVVV3puenJwNVDhzkyZioPp16bIPR+6DdDuCceLYKuxM6TGX/SQ7W08XOo91l9JmYbydvXkjyCXE+OfVVlWUeEuCO5Icn3xZvuBIWp5I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734412427; c=relaxed/simple;
	bh=tIOOW+Nrc3D0iOSBxejuf1cwiGMgPxMrkh9/3p7R5TA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qBC5wiogsz1zkpWuC4SQrBnJ/9EXkqWspYAYwHfOSc7egdkOPMKp51NWlXpGlj+F1KRhNmXUldqqageTb1aIYqXG5c9cFmR+dcWTqCsYOhTL9IQ8istnPnqxN1n/kVZqnndT4dxTQJqUjVNHB0cvaF434VVBYuM7La57J3x87p8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JqIbO7y5; arc=fail smtp.client-ip=40.107.223.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o3lC+bDQEDIMDsvfEHJfBXed7Bf/+r5nt4d3T9LmSyWsy4GdpYzrRWDqRdXQSQvPYc9Vz/X2RsA8KUV8jSsmKBM+uDcdNjUxoxy8YLs9/DADYxPP/q8899ZNdvfUfDq3z+RfUYGVOQgvUOY+yuEz3dKL60LJkeEFNJjN1bINtL5b6Rjn3Q87ANySfpJpqiTnTEyBs+YCdJx3zcsGMgWwRhyFhOCUpcY9HRyceniZ1rGYcP4qIAhEYjnDBs9Ih7SqyeKRdyzdQIX9XuUozDISFr6MMkRdiHCquKC8JUjM9WueyqrKQTQZgM4tIqxovp8IOmGTYZ4n3rMPIfqbqXnWcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bE5P8XNU3ah4J/7ozO76nVLgHi9O2KTRIMaPoDiVlsY=;
 b=mHllwzXpaiVSjH9G++2qzi62Hl0wE0vaPabHuySw8XPECOuD5UeUMvL33ssULMP4weoYFMdyCKPcuI4us91+laZ+uXMltyHXx5IFUjkakE+UdR+KvU8I03bOwCM7n0qJQ+TfHORZOc19Dr8UlD2KLtq12Ex3zAQ14hD/k4ojTtW35OfoKcFFmVBtME+yLtzv99aBmutwsdIB88alSmwzPDU21rtMvy0iblw61+udm8d7GJ/fYcgoF7o/uCwi7w+6fmXJWjOPEX754aWYTcsViRTCEV6i9PfKJ20uGC58zvx1rK5++Zd7V2YpDtcv44rfthtMVLYDBsEKXEJLl43hLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bE5P8XNU3ah4J/7ozO76nVLgHi9O2KTRIMaPoDiVlsY=;
 b=JqIbO7y5DSTnrL/N1jQmZgCPU7MwBy5Hzx9BDGVDptfqgABoo1vedOzM94vlDQ5WcqHp4J6c0qfN8ERYHNAVthPrjLEhVLhT6w3I2D6Qbc8GNOD8tc++uTLx0IB4KYaKtPSw3JFV+lbyXh2J6ZLAuFeUyRB6Z/b7BUglI8NKGKPLrT8yauLluggg7I/+M1WwhbANVy0dC3GSuFnv/CKYSlOiUaztcrZH3iQDqNiGndgbKCqjaT4BcwGlaMJe6RFha1LXD1H14VKDjd/1ov3ke6MBD5gHMwcyVYtBqJOJhof03gLK+K3llzlsP/jvCWTyk7Z6c9tUOM6w8szwD3CQlg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 CH3PR12MB8936.namprd12.prod.outlook.com (2603:10b6:610:179::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Tue, 17 Dec
 2024 05:13:43 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%4]) with mapi id 15.20.8251.015; Tue, 17 Dec 2024
 05:13:43 +0000
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
Subject: [PATCH v4 03/25] fs/dax: Don't skip locked entries when scanning entries
Date: Tue, 17 Dec 2024 16:12:46 +1100
Message-ID: <6d25aaaadc853ffb759d538392ff48ed108e3d50.1734407924.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.18cbcff3638c6aacc051c44533ebc6c002bf2bd9.1734407924.git-series.apopple@nvidia.com>
References: <cover.18cbcff3638c6aacc051c44533ebc6c002bf2bd9.1734407924.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY6PR01CA0050.ausprd01.prod.outlook.com
 (2603:10c6:10:e9::19) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|CH3PR12MB8936:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b8c33dd-6288-40ed-be70-08dd1e599363
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pJy3PNfawEDoVnzoQ1qBXC36RK6DFGxrc1yylk646p2W4KhdG3oz3eObd7cn?=
 =?us-ascii?Q?IAXFk4fsh4O1bAui14Ml+BbjyB2IOEXxlQmx/bxifXhWgWrjMEpyVd3mI/wz?=
 =?us-ascii?Q?6lmKGLcseRh7g0NSXxkL/R/lQTzGQ9PXSlOIdNtpRc8YnhHX4XMQu9y45cbf?=
 =?us-ascii?Q?G+KOOvmJl6NS2GN/ohlcUCCf9S0VgJhQLA0tweoXWUTzaCB99An05IGzyi8d?=
 =?us-ascii?Q?3WIayYVRTKltZE5idk3GJd2I9FnRGeC0iHNgjlAT2I7NzKwkwSfeJ+v88tNx?=
 =?us-ascii?Q?1ePb+oq5UBzmN8CxAc6EseC38HN/tYLn6a1J7lnORluuIxIdBkUMEcNIvYPo?=
 =?us-ascii?Q?jkwkbxur7ufb3HSPxIRZmvyhf8mfUozyBN+rBvfappHxOioqW3wZ3MRWBOcG?=
 =?us-ascii?Q?dvGuA4vJDzWLo7QKrWARuUDCmGXXii5BJ3fwQJ43rHQzZHGM9Viv2ZSo1IsD?=
 =?us-ascii?Q?VEdzje0UcxkaQTWfM2ibzcDuKTWj5YrGbld8BjW2eQlqIiiyMET2PSWbSj8U?=
 =?us-ascii?Q?p2dyIalgNou9Tm307zjmhgW5hMzfVDLQL0r1rV9c7Bd3sD7en9sBFONAhKpy?=
 =?us-ascii?Q?DeNt+kxf/yRxV+NoC1ubyKwivTCRPtexDNuLtqS0GLMvk6S2skwcCpyB2lDI?=
 =?us-ascii?Q?c9St4dR9pwgQqVwjOM1Q+Uync7N7t8DVsPjbnyjnWVqFihJtNqniXj1dVif5?=
 =?us-ascii?Q?LSU3jjY3alKZvF/TFk7hBJI901JOYRyL1fqJo/328MKeoY88yEakOUFx6uWH?=
 =?us-ascii?Q?4SabJDFzux/UCOnRR0p/iadY2ExtBErWp5stVgIwdiekSOlE66cypHKZ7bES?=
 =?us-ascii?Q?zFY5rwFrR3Ja8aYzb8KTM4w6L1mN9vEiVtmPo2rwoYOLop6DqtJ+8k/u/AtA?=
 =?us-ascii?Q?Tmoior1R2TUl6zflY4d69qmv9foDabPMdl2OLnnAkrmW64JIi8Lm9gLGnP3B?=
 =?us-ascii?Q?rY7opUAfCQ5qYR9RkmgcyFJ8cOXTeYkXSnsN0LNgTY7KlV0IGY1zXLrRWmN0?=
 =?us-ascii?Q?0XlRDvrVXgsszRSq4rnjGhkZ6NE/Ctc/jqLBdu7dsak0NLfO8wwHRfoiAyi7?=
 =?us-ascii?Q?3Ak4kEhwVmows8G6hL2zYld2bWIyVTw3bXHnr8rX7h3KdPjUOGh+j+8r+ck5?=
 =?us-ascii?Q?MKFDpq0id8NdLncha319rNiDsrESmoSVkf91ytaxMKi9diW9fTaEYeeni+oV?=
 =?us-ascii?Q?SXAQUbNqyuMG3ddB9lkkpHNlwvLnUi+jjxoFHnCofVv/rsweZKAt+2URPtar?=
 =?us-ascii?Q?/x9jC5ydE5KzSoN331WhyAacm3CXpM99CMOCNg4X0Ilmzqq58PKJtFnImijw?=
 =?us-ascii?Q?S9TDCz9Tgpl/gkKsUe2ROR9omHz5sRLSE3opJW+eCJnF1+BTDhsTosOX0dep?=
 =?us-ascii?Q?7ITb8iAOHDyUjBLfufNT9FnNAShP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?S769GrJi9wxojydBoDPavVj/uu0/tM+pS8NE0rUzxoJHyaEjonYPJqC7mCu8?=
 =?us-ascii?Q?42gDnkE3F6WWZshkvewzn8cUqwxtRZHGEOj2W7o7nYgbJWwZY/J6gnT2inNb?=
 =?us-ascii?Q?Srr7Xy5JR0kU8OfbvdUlZHmkyyeGWRrVvNZJ0o/Eg0gWI2tsF34dHY5aEgT5?=
 =?us-ascii?Q?Leozrg3cZkqaQDiSgDdtkReE55U16Jg0np/eBJFFZSNNSS7deiKsnEX8vUVv?=
 =?us-ascii?Q?U46dNdIusmPhUS9rwMSFtFvgh0pzEBRf/nIEKYZJaAafh6sWE4c0eLlS93Bw?=
 =?us-ascii?Q?oE4Bk5Ew5s+LJjGlU6ae+WKrM5Wjq3l2kCquQpWxTJJolq1L9SVKBx9tQLVj?=
 =?us-ascii?Q?H9WaeHnOBTkJQC7LMTrWNkRhkjUfMnWyIZKnSJAPSA613ld9PhFonE+eziIe?=
 =?us-ascii?Q?uUJze9w5cQ+/AtK1iks6Nchb9Lw3iwfaHgFAJLM1WXkCcp4/J3XUAFiGmpqT?=
 =?us-ascii?Q?SATMnpMbzkifc0v6UARVZyDYDcLaXxqS101/Bgw1Xmf62fh06fd0WG3rzT0b?=
 =?us-ascii?Q?/WDUMcRH8FbZK0Vy25HttQgcFwwAiuSNuIxrWscTzVb1doU+TAK8SRpWufAk?=
 =?us-ascii?Q?J4XORw5dj/NHqoqt3qEmwcooSYlW1Z4IL4Z3EtMnM3FbggEW6r9NV3mRNQpo?=
 =?us-ascii?Q?zJnovOmynxOWpnPWMImwU2GSToZNJHKKTCryZ2IeVzD9UW6LDhOZLn9JwcvU?=
 =?us-ascii?Q?aXP7gyEn2HVB37aHpiItpEfWi3y3A/5pXK5hgc6lhEMt9hxEbIq/Q/Cp3OeG?=
 =?us-ascii?Q?QbWIVK3AhDvShGnI8unCVFnf1ubanB7VuDoVOrXU6d7W0j/7vn51aI4Ydaoo?=
 =?us-ascii?Q?ORQtcDME7P25i3s7y9JrynO1jc/c4ql+jx96EodFfeFmwbt5emwVry3xW+N7?=
 =?us-ascii?Q?tikc5U5n3u9O/7v1YT/YGTT54ivb8AO+5f0KiW5UfR0iKQrNV7NEOyM4MgW+?=
 =?us-ascii?Q?gDtmodJMk2n54MBJpCVC1RyolUAUW3Sv69kz7fFgXboLND6TRS/NiNjGitW8?=
 =?us-ascii?Q?UJ+R0dWmEoQpHhShiWnxQbTx1iSSOHQ2nCpaUpS830/UnZlmwZ7i51sKN8yE?=
 =?us-ascii?Q?hhZjKPOXPLJcJvG+2HJbSf6iJ7X40g3OcX8cGmAd5LpetRKjoCyYpHqi6J3n?=
 =?us-ascii?Q?asnuCmulJa810EcMr9Bis4wDnSJ1mfUXQX+6Jw54pA0BlPpwbehce6u/HczM?=
 =?us-ascii?Q?/BCqk1ER+rmn8wAgIO/0LHfgt9/F9rRv8R3/AmTasHUV8iA6y4vK25LLJHvZ?=
 =?us-ascii?Q?Y7gNX4uJwJWlJfVo6JRh5fc9yspdx8a9aHtnLns1UFanSqL2tfOQ4IFdY0pO?=
 =?us-ascii?Q?zmgeEiLvckxWW6y1rH8RYvYQT9SkKeOeFnh6xdSbD2HVKrO9/bOy0a66HZme?=
 =?us-ascii?Q?zMPv59RXX7kKsMUILKjt+L+qQ7HMc2qFwXlZNxYrZEgAwNIXkkFBwQ3QNsdX?=
 =?us-ascii?Q?Q1hQo5bwdliyBmeh2qTbLS70CBsbVkd6QJ3cgJBgIbDhcOO7iQCCDQuuOekF?=
 =?us-ascii?Q?gDiJ8A7kOQNfTq9IqNbCoXvTAHloVbcRSnNyhVB0q91ZYXhRX7pm6oBvnsc3?=
 =?us-ascii?Q?Oo/8JBHVqWkkq9c567LxRpclxHx4RU/7UjpDoztu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b8c33dd-6288-40ed-be70-08dd1e599363
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 05:13:43.3161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2LhS58ibFqlFYIXlx1eVg1AJ8qmteWrU2nlcqI4Cn1mPehqzPogI6I+HAz0U35B3zZfoB83tDeEUYiedK7s5QA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8936

Several functions internal to FS DAX use the following pattern when
trying to obtain an unlocked entry:

    xas_for_each(&xas, entry, end_idx) {
	if (dax_is_locked(entry))
	    entry = get_unlocked_entry(&xas, 0);

This is problematic because get_unlocked_entry() will get the next
present entry in the range, and the next entry may not be
locked. Therefore any processing of the original locked entry will be
skipped. This can cause dax_layout_busy_page_range() to miss DMA-busy
pages in the range, leading file systems to free blocks whilst DMA
operations are ongoing which can lead to file system corruption.

Instead callers from within a xas_for_each() loop should be waiting
for the current entry to be unlocked without advancing the XArray
state so a new function is introduced to wait.

Also while we are here rename get_unlocked_entry() to
get_next_unlocked_entry() to make it clear that it may advance the
iterator state.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
---
 fs/dax.c | 50 +++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 41 insertions(+), 9 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 5133568..d010c10 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -206,7 +206,7 @@ static void dax_wake_entry(struct xa_state *xas, void *entry,
  *
  * Must be called with the i_pages lock held.
  */
-static void *get_unlocked_entry(struct xa_state *xas, unsigned int order)
+static void *get_next_unlocked_entry(struct xa_state *xas, unsigned int order)
 {
 	void *entry;
 	struct wait_exceptional_entry_queue ewait;
@@ -236,6 +236,37 @@ static void *get_unlocked_entry(struct xa_state *xas, unsigned int order)
 }
 
 /*
+ * Wait for the given entry to become unlocked. Caller must hold the i_pages
+ * lock and call either put_unlocked_entry() if it did not lock the entry or
+ * dax_unlock_entry() if it did. Returns an unlocked entry if still present.
+ */
+static void *wait_entry_unlocked_exclusive(struct xa_state *xas, void *entry)
+{
+	struct wait_exceptional_entry_queue ewait;
+	wait_queue_head_t *wq;
+
+	init_wait(&ewait.wait);
+	ewait.wait.func = wake_exceptional_entry_func;
+
+	while (unlikely(dax_is_locked(entry))) {
+		wq = dax_entry_waitqueue(xas, entry, &ewait.key);
+		prepare_to_wait_exclusive(wq, &ewait.wait,
+					TASK_UNINTERRUPTIBLE);
+		xas_pause(xas);
+		xas_unlock_irq(xas);
+		schedule();
+		finish_wait(wq, &ewait.wait);
+		xas_lock_irq(xas);
+		entry = xas_load(xas);
+	}
+
+	if (xa_is_internal(entry))
+		return NULL;
+
+	return entry;
+}
+
+/*
  * The only thing keeping the address space around is the i_pages lock
  * (it's cycled in clear_inode() after removing the entries from i_pages)
  * After we call xas_unlock_irq(), we cannot touch xas->xa.
@@ -250,7 +281,7 @@ static void wait_entry_unlocked(struct xa_state *xas, void *entry)
 
 	wq = dax_entry_waitqueue(xas, entry, &ewait.key);
 	/*
-	 * Unlike get_unlocked_entry() there is no guarantee that this
+	 * Unlike get_next_unlocked_entry() there is no guarantee that this
 	 * path ever successfully retrieves an unlocked entry before an
 	 * inode dies. Perform a non-exclusive wait in case this path
 	 * never successfully performs its own wake up.
@@ -580,7 +611,7 @@ static void *grab_mapping_entry(struct xa_state *xas,
 retry:
 	pmd_downgrade = false;
 	xas_lock_irq(xas);
-	entry = get_unlocked_entry(xas, order);
+	entry = get_next_unlocked_entry(xas, order);
 
 	if (entry) {
 		if (dax_is_conflict(entry))
@@ -716,8 +747,7 @@ struct page *dax_layout_busy_page_range(struct address_space *mapping,
 	xas_for_each(&xas, entry, end_idx) {
 		if (WARN_ON_ONCE(!xa_is_value(entry)))
 			continue;
-		if (unlikely(dax_is_locked(entry)))
-			entry = get_unlocked_entry(&xas, 0);
+		entry = wait_entry_unlocked_exclusive(&xas, entry);
 		if (entry)
 			page = dax_busy_page(entry);
 		put_unlocked_entry(&xas, entry, WAKE_NEXT);
@@ -750,7 +780,7 @@ static int __dax_invalidate_entry(struct address_space *mapping,
 	void *entry;
 
 	xas_lock_irq(&xas);
-	entry = get_unlocked_entry(&xas, 0);
+	entry = get_next_unlocked_entry(&xas, 0);
 	if (!entry || WARN_ON_ONCE(!xa_is_value(entry)))
 		goto out;
 	if (!trunc &&
@@ -776,7 +806,9 @@ static int __dax_clear_dirty_range(struct address_space *mapping,
 
 	xas_lock_irq(&xas);
 	xas_for_each(&xas, entry, end) {
-		entry = get_unlocked_entry(&xas, 0);
+		entry = wait_entry_unlocked_exclusive(&xas, entry);
+		if (!entry)
+			continue;
 		xas_clear_mark(&xas, PAGECACHE_TAG_DIRTY);
 		xas_clear_mark(&xas, PAGECACHE_TAG_TOWRITE);
 		put_unlocked_entry(&xas, entry, WAKE_NEXT);
@@ -940,7 +972,7 @@ static int dax_writeback_one(struct xa_state *xas, struct dax_device *dax_dev,
 	if (unlikely(dax_is_locked(entry))) {
 		void *old_entry = entry;
 
-		entry = get_unlocked_entry(xas, 0);
+		entry = get_next_unlocked_entry(xas, 0);
 
 		/* Entry got punched out / reallocated? */
 		if (!entry || WARN_ON_ONCE(!xa_is_value(entry)))
@@ -1949,7 +1981,7 @@ dax_insert_pfn_mkwrite(struct vm_fault *vmf, pfn_t pfn, unsigned int order)
 	vm_fault_t ret;
 
 	xas_lock_irq(&xas);
-	entry = get_unlocked_entry(&xas, order);
+	entry = get_next_unlocked_entry(&xas, order);
 	/* Did we race with someone splitting entry or so? */
 	if (!entry || dax_is_conflict(entry) ||
 	    (order == 0 && !dax_is_pte_entry(entry))) {
-- 
git-series 0.9.1

