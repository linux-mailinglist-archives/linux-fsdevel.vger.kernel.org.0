Return-Path: <linux-fsdevel+bounces-16632-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C71D8A04FC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 02:58:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5F0B284F8B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 00:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A37B8D51E;
	Thu, 11 Apr 2024 00:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Hh97ttS8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2096.outbound.protection.outlook.com [40.107.237.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8591DC153;
	Thu, 11 Apr 2024 00:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712797071; cv=fail; b=szLyXjkHDo3OaUdm3UsRVTPxKDWV1AQnxVi2eHZdnbbPBBYuoZ+9shOC3hxxIW9U31bdXVsVqscuk6dUYBO6GDiAvsV8JiD2/SLBsWHsSWyR6ZJhNr5lyhnJ0ZKoYijL32+OYhOShcUCG6/ks+Z+/kGKB3nFGEiwAZrQqsbYeFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712797071; c=relaxed/simple;
	bh=wi4a4SEgpHOV8mfnA9Ddek9bgY8F54DVEilfRiG7jvE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZDiz1FLChaSdSdKz7Gm7M3Ye4KtujpbbDactjKl+hIiYQhRPIRwWxllnV3nk1S5rqwBpgWBUqHAEt7APqwtVPhlabpleO/8BFTwmKoNhCMMulrm01oTrlN25FoMpMjxkrmgcf3LpVUuKrYMYgDTsHtmuPv0ZsxD+ZUKDT04V5sY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Hh97ttS8; arc=fail smtp.client-ip=40.107.237.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HY5sTlIR5CpSNsBjedXbQPPwVjBMKnMgBXa1hsJjAziLhZhHiJ80+/E9PztM1PwBhhgBC9q5MrC0og9BDrQaO7ZUorwzUKuxKrLFthhR8LCRdphYMfQqPySEpLIW/DMQRrpr0+M+2GTTuMhoJmBurgrOs3g2ygTwTmN1m8onnsOZvVO8P0mEk/RDJuuYYRSXcrRZrnphWzUnyNaWu5ijj2Lgr2n5WsM9cpaxEu6zTq1IXsYocq0sCjQb/oakmtskOuvZptTOHf6oRDDGIri4fc6sV+jb9RAS0dnHPyyrCNrV8ktdiS7NWZY8if1gZ627oq4f7t8vjkNJa/xVtUrDEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tKiN3shwTxUYVqfDKXnFvse1zmk7VaIAWgqrFv/wtSQ=;
 b=L/cM3GXLbBIFaCNs0IxElReAYjRg5d0Yn6+Udx7Y84ZLb+RqSrZB6ACMgxL3nP3KhNf+oMR8NXR+BjPyB6vMfa0BQYO9bPQxnSaMvhUtP7PpantVP4O12+4XCpI3q3XThvJHB2dWCO/HUI7wvB4pGbAODKG4ndU5Kqv+1ochx+oYYVeHzayx6UKocTqe8W6GX7J6qqBLKX5BH5k7+VBbmDnBvS74spMGl0RrV9WVIy6I+6J3PtSsWuH3RowJMihsV7exMWzvNS+fnOPpizbGpTfJxBh3JmBYNbTIxUqebYixuNPKFQA1Uzsm3gGcJYnROH86JnA/Ru8PXCqY/auBcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tKiN3shwTxUYVqfDKXnFvse1zmk7VaIAWgqrFv/wtSQ=;
 b=Hh97ttS80gmSlfXtTA0UIwxmkMM9iC8h0lfM3JI7NLlcGNkQ9Y+LSbaHZnNn6rcKJa7q6hU4wZ5QZ2jLFcLp/fo5xtZWg4IWLMJ5p3ZMZuD3JdzBGJB7XDDex4sikbMSKGp8TPtRGXVb7S28POZi9AJpHfeBPJQYBXE/uob7db0uCl9nl/+cssetzhF7tR1e8l5NvGNuq7YpkXIaxPVwHvw67sp6aFG1gWfWT2fyOHezJ5U2ktb4nE5iQOdKLXdY2efU8IOReAsISWHFFh8PwLBxYv2FkzvQH6mSHaf7UHVOA0hDJk2k9kB7NwkRF0wwS6y5SB9Clq2ERXO8vXa3/A==
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 SN7PR12MB7854.namprd12.prod.outlook.com (2603:10b6:806:32b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 11 Apr
 2024 00:57:45 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::c5de:1187:4532:de80]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::c5de:1187:4532:de80%7]) with mapi id 15.20.7409.042; Thu, 11 Apr 2024
 00:57:45 +0000
From: Alistair Popple <apopple@nvidia.com>
To: linux-mm@kvack.org
Cc: david@fromorbit.com,
	dan.j.williams@intel.com,
	jhubbard@nvidia.com,
	rcampbell@nvidia.com,
	willy@infradead.org,
	jgg@nvidia.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	djwong@kernel.org,
	hch@lst.de,
	david@redhat.com,
	ruansy.fnst@fujitsu.com,
	nvdimm@lists.linux.dev,
	linux-xfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	jglisse@redhat.com,
	Alistair Popple <apopple@nvidia.com>
Subject: [RFC 01/10] mm/gup.c: Remove redundant check for PCI P2PDMA page
Date: Thu, 11 Apr 2024 10:57:22 +1000
Message-ID: <ffd72e934eeae28639b636e1e61a9c5109808420.1712796818.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.fe275e9819458a4bbb9451b888cafb88af8867d4.1712796818.git-series.apopple@nvidia.com>
References: <cover.fe275e9819458a4bbb9451b888cafb88af8867d4.1712796818.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SYCPR01CA0013.ausprd01.prod.outlook.com
 (2603:10c6:10:31::25) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|SN7PR12MB7854:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yRXac+g063Y2zXlo/eBjC+LLXWm8LH67J5JZq/vIksk2PDvAs8uiPYq+zvIOk2iQhdQs+OF4ilPKXafE7EzkhR7Vf5bB13h3kmLyt9xqYYpPuUshJBgxFSqcWim6s8d7W6TMUxyK4TjppkxoLNiyWrBgQ30abh3iOoYhePI9a/WT6JdaWDIPLBTJ3/iIYDUNATbCfLgnAvUCistO2oXf5jkMIfQN7TGJYzp7qxm0HfwcnSNo8YOApRJT2p+heBL5wviQsGeI5FIOtHxIpltBNHYVaaZNqL6YH9kobqbbRO0aN2JDEroNfzAi9KwzydtkmA4l144NZSz+4VKVsl63RH/flT6UZFtf+fm3EpcrFW0oRnwF0FRnu3ViG1/YKmSweqrotU6pJkvy+5JFLOXU26lDAs/gd6iouvvWVUydsgp7PpXIkAAa3GGL3EmZTtYni8/n/JqP0CYqD4ey9Xe+bmsfVeHCkSWxbdEwFPA0tbk2CfiAThZKypGTvUdF0zMTqDm4iBZXgH8CzNbpPYpGX1L1NfWUqVPkNfNT6c35a6elTMInWTsvhBzPSW9me2IgLdwplXnqp0W2au0DM6z5p/xAFhqGd/bN5tk3MIifv27hkY+PFRsP94eCZ5EsALaclHH/Km3VnxoO5GN7ENfbI/x2CMhyBRdNRwlwnnBu8OE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(7416005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1qlMQ2Dt5t8CkWQqMeXuqN3pGNu1Rx6VN8pKvEDMXdN2gO2UpNqT+rAMfcmz?=
 =?us-ascii?Q?1n5WHpwy4MT1PgcdVhEirUwJ4y9wY63c/SIafADkeEO9LiCe84zv0P1OPvWN?=
 =?us-ascii?Q?+LTQqKJXSDpzLCYQvyhpGKKtU5nHHXksz+zxlB+0L2UYjqAKxQS3x5q9B7EP?=
 =?us-ascii?Q?8Ke/13gGjploSTrTpy7zOPXRGZGP7qE6EdBGlHDB++RMUR0vzIuS5a2N8eb2?=
 =?us-ascii?Q?1Y36z5+kd+lMeHNww7miGtzVKZ7B44ryx+2akP0m4UAi+1vJCqLN156kobSI?=
 =?us-ascii?Q?nFyxS2Ieth3+pTAqkDUqQCIjMsYoqmEcQRkKiLIV+phY/IClRl0AL/RbUbAQ?=
 =?us-ascii?Q?mNSUkRYowoY/Re/gUfUslm/jLYJi9FdT4gvxdxj6gov8e8snmWTATUOV25hC?=
 =?us-ascii?Q?Zv1KmrwMpukPvzeq9wGn07Yugi6M8rL/kLEogxhXr8//w3Eg+OW6m5Fw3qnk?=
 =?us-ascii?Q?xtltHAg+kkuRgl8ZLVBib32IY4Z2OAMFBBSTo0kS8IT6fbfd34/vWRQpPGiu?=
 =?us-ascii?Q?YZTzdIUTo2HUWH070LUiun9HZrawcsduwacu9OmYn3/XvsKEa9qdhCWqw16m?=
 =?us-ascii?Q?pLlNmUqfVMufd6zROqGJJvCchuj2gb2sMJxF4hx99kHvjwMGF9eXxEo3l5h9?=
 =?us-ascii?Q?7bE1faResABolnP5sAWsLf2sN6rPKsO6QHks/0VVFwMfIYpbsRpwOVcBlEX0?=
 =?us-ascii?Q?QYJf0CJt6PYVTGbxtijPFSFCA3QZo+ej/jx9ejOUOs2+Xxihi0zWSiUWn5hz?=
 =?us-ascii?Q?19AiSSwbK3iOD7v41+UywEEcX56cKvgS3Akva0TP0I5N6MDWbegL2cBxt05z?=
 =?us-ascii?Q?3csvokCoMeV+qSJHArdy5IdXScmUTZuCGxvYKaKH7k28UcE5TbE3TJYbwUCz?=
 =?us-ascii?Q?RuenQ9jOZndZIpbdCTKF4NgQORr1mK50Kt8x5otuu5+SE7ZNn3W7wvDmCpfJ?=
 =?us-ascii?Q?1vzopFVDx0t5pP8lyTRAQndBgfYPZPYp+rrH1qjZt6n4lBGghF9egBRCiB3r?=
 =?us-ascii?Q?ePLO3mX8UlrhRR5FBsml44K2xrlValLF31rSO9pJ2cGfDpZ/7BZvCgKCfsoe?=
 =?us-ascii?Q?DpcqoCtNwcPchoDbY6rP2pdelxVXgErzitGvQZE6gZwfhCdq8XXUvRL4ALfY?=
 =?us-ascii?Q?uVz1Js7CdrkII6CuFsFHtcYxVPnPr6F3/iXGnvAfNWZv1rA/eUq33tuQx45i?=
 =?us-ascii?Q?F9ZMmhrp8i5w887v47/a2zEaQ9JflTWg19jARuu2dwzM9RQGmRZkzI3684Gl?=
 =?us-ascii?Q?dKSjD+umVsyQTPjKrUTZkyPjPFvmeJAWHAPYKhYJQGygeyLBMBrvG5gTKGWY?=
 =?us-ascii?Q?SqBShfw/pXdCxbDgOMHF4+EN2o6cGih6+KfK5YComUBIMEBg/VMvSQ7ddhyO?=
 =?us-ascii?Q?3p4r5wPkLSOCpMx5xuEjfDigFepedlorJ41UCxpI8/XkRVTZPyDhbIUcq4+l?=
 =?us-ascii?Q?o8u5JUKxjNMaLkmmiczlPfQBWuhdDAMUvmiRdrnLeUZ/YN0JCWiy6XR+U0+3?=
 =?us-ascii?Q?JVnREGqJ1LdDeJUF8BVQmmLoRg8ubi7fw6UKhVOYSO1hcAEDnYvJsIBCHBP7?=
 =?us-ascii?Q?vUOiipqcIreLkSzKIRRJbY0O5cRNsaq1ZmUXS40m?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bd81b5d-44cb-4688-6bb6-08dc59c2667c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 00:57:45.8689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GMuLPEdFt6WPrxqnLuiqpHtIh5XcMbkDnKAVtd1oHgXXU4PYGPZonbbK06wYNIaBIgQpd//3xW250+75g+OPcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7854

PCI P2PDMA pages are not mapped with pXX_devmap PTEs therefore the
check in __gup_device_huge() is redundant. Remove it

Signed-off-by: Alistair Popple <apopple@nvidia.com>
---
 mm/gup.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 2f8a2d8..a9c8a09 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2683,11 +2683,6 @@ static int __gup_device_huge(unsigned long pfn, unsigned long addr,
 			break;
 		}
 
-		if (!(flags & FOLL_PCI_P2PDMA) && is_pci_p2pdma_page(page)) {
-			undo_dev_pagemap(nr, nr_start, flags, pages);
-			break;
-		}
-
 		SetPageReferenced(page);
 		pages[*nr] = page;
 		if (unlikely(try_grab_page(page, flags))) {
-- 
git-series 0.9.1

