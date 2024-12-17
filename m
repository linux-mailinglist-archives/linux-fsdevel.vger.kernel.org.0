Return-Path: <linux-fsdevel+bounces-37576-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B059F4203
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 06:15:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C57F7A51D7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 05:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265AD16E863;
	Tue, 17 Dec 2024 05:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LoVTDEQM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7685145335;
	Tue, 17 Dec 2024 05:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734412421; cv=fail; b=MYtWc9N3ycfzUVluW85McxLWgGsyXwEYWe8i1rFET/MnH+6ivsojBymjq09xDBUAYSKisOshfR2TNwDaSXuL/njFUa66pZKATFuVPcnZHkEnUKEiSwafpDuTN5lbw12y+WR7k2NTFZGVfPc9wWMrdxdeKvENvfddXpBNuMUgDZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734412421; c=relaxed/simple;
	bh=wZjF7+UG/Bc7bN5RQ0zHu3iH8C1QLTXOBijFyVKc1nc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fkBESDLL+ZtiAcow+NG6JXH0ahJ3tbnkauFdhEMkkebIrU2/t3kYcdOvQF8hChExBzK8bZ82eflt1JYZGBVgpMvzP0t6tsqqtpEoMzs0EtkhmPAHqe+YNK8kkg4Uje46a7p0BIHdXt8T0u4rXde6Smqcs25XinzhSgwTemSF+60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LoVTDEQM; arc=fail smtp.client-ip=40.107.220.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tcg2i+e00bYOzf5+IMcO78OWxy64HQ39Jw2NgXVVDJdsAi5b9b/BerM+l11YPAqsj02R/UolQ9RHUpun6Uf48SVAgjcZ0wwcqZmwTfFJw8LZfw/4XpilAXUiAXQWdJ38FSJ/M6+pjv+mYYAT0Mnfn5ompsiwy46fXA6JZt5nCBkz9oWHEaZ34s9tNiF/NP+L3Dioj6KQ0mzMUI/91W6veQvlq3OIOuW7WcuZo0aLEcBMJW9u+THPyNzZE1Ocnd9G5i4f8poOk9r8Bpr+Xx0sHmL5FqTTLGhEKel8IKTwCJydq9LLJtOmdVY+Cj++C6UEkdAfpF9/HtRXrIucieMh7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p54xDpSMcpfpFU3zdQGXgiKs6ViJz/NPgxrzUcuVzcQ=;
 b=RTe16Xbw/w1UCRWgUVgU6CEqfSleItxgAX5HlbMT71D1CoBKeNOU+ZAv2fXEuxVlZjMhqfysI/MCtglp3fOezrJHGJmxdsk7CojHMte5a8zpxLVmBnt4AveegSIbavxJ74NzvOz6ftaCtbZcbKhIBpoihVUGJZj8f7TajJXCj6tBFYWbwPQZicEzppJpGoKckuUIdr4arsfMBEmVgsOw8gk7jw/q2rsW40HYJQqdJqKYuErsuK+q/WhVFng6pWFDEVIhBPkl2x/XRQuBQmYplPICUj+SffCqJ6ReFvaxXcO9qerqrl/kZJn0S/eTEVwqBJZbLl2wDhL3M0/sKAFGHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p54xDpSMcpfpFU3zdQGXgiKs6ViJz/NPgxrzUcuVzcQ=;
 b=LoVTDEQM9eybDYK2AQds4kBLSUrZ/8tGKbzsrSiMXR3iIJ9mqTN+tCc7tKqTUmY8RCX6l3SGuhp28ea9na47487rqlk8HiYpTeIqBHrcotbHC5BAJPs2yBH9mo7xxPJQKpzpLzqIfud1Vsihkd6kQObSSdgf/8drpOrY+ePzHUbUGl78JUQeXxErf4IN/HRnfWEW5SCN3JRiB5O+0gQfqjVKQUnWULBh3OpUJhodk8yKp1GOVgtGJGSY60qwrSS+aU+Pp7QN96Au8JOo0Xiso4ZqBuOyXf8Lqp0SXlrh1JQ4oHN719ekfQO/Hxxf9EDtTFqlgvacJ8U6HXLhUbyY5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 CH3PR12MB8936.namprd12.prod.outlook.com (2603:10b6:610:179::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Tue, 17 Dec
 2024 05:13:38 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%4]) with mapi id 15.20.8251.015; Tue, 17 Dec 2024
 05:13:38 +0000
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
Subject: [PATCH v4 02/25] fs/dax: Return unmapped busy pages from dax_layout_busy_page_range()
Date: Tue, 17 Dec 2024 16:12:45 +1100
Message-ID: <db02794f12a4cc8c659a1123bdc90fcb4dcb1104.1734407924.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.18cbcff3638c6aacc051c44533ebc6c002bf2bd9.1734407924.git-series.apopple@nvidia.com>
References: <cover.18cbcff3638c6aacc051c44533ebc6c002bf2bd9.1734407924.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5P282CA0196.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:249::7) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|CH3PR12MB8936:EE_
X-MS-Office365-Filtering-Correlation-Id: 7862fcd4-a3e5-443c-2e8a-08dd1e599060
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aVPbxQ6cT4j+ltfPSRn84YCi7/9hdgCkH+rfP1j+Yv9+TospcrbdNaWkFCnp?=
 =?us-ascii?Q?4A3hdsGgEpE9Z7IOaSUacKpb+nv4Ps1w2tG5XuDl3ansDRajGqwobRuHWkSK?=
 =?us-ascii?Q?uDFxSyZwI8dbFTsCkIyAXyfGYQowD+9p7wogwR3f7SCTAbwMb6epz0xDXP7I?=
 =?us-ascii?Q?Hjm6d2IobhRjdOxM8QfPOD7r2Dp+g+DIKlTmFU/TFPpScLWQhgbu7oy42vQH?=
 =?us-ascii?Q?3K/CWEVB8bOVLnDYDGprRPJPT5prGvA8DCSWvGN3qlqxrSnwQNWxW4GLnvHX?=
 =?us-ascii?Q?iFm21DDcQNVwdv1/xg0aJYFkrwznXGw3C1lDNNnMIyL4S/O6Yn5Vg7EatFSI?=
 =?us-ascii?Q?9OYOQ0C53VmvDe0PyAb2F8r/r8npvOBXNnJYN47g56IXOK+cxUGyvk9PXrzq?=
 =?us-ascii?Q?bI9CNM2Mm+8oexrpW6rrQMvdEfjtxeZjRg8grZN667H83fnXtb6VNLdPeV4q?=
 =?us-ascii?Q?+acPQnb09qdTY+UABGAtFXL25L5SAcyAx6NdpYrsuNUe3sqL+rJJurh9f6U2?=
 =?us-ascii?Q?HlGzDe7ibZlRALKlHO4YwMAn2Tmv3Ak9IkyQM63zgKpNDE0dVowLGXhkV2uO?=
 =?us-ascii?Q?0Zmqo6DMIebUp37iRsIL1MjjZWsftXDurEow+6NZK5wOU4Q9r5S++iNSmgR/?=
 =?us-ascii?Q?LZjzitkYZqmCtc7FGVwoHIcrWoIy/UqOQqBL2Fm7QGkPctC7S9G7HJeNsZH7?=
 =?us-ascii?Q?jq8sfBqWjihS+UTdw5s2VW64TxJ4/WxdRUD18BrMy/OGJV381gGqHoA7Ygm+?=
 =?us-ascii?Q?WJ8hEEGItJ/C2OggH/LhmylI+WLc9yIy5UE6C00MxN6zXRm8vvW36rSm8JHC?=
 =?us-ascii?Q?xM0Ddl0BTxVng7RtCAAzGHIg+PsRxB9eaQBSWybC2/4lajfQvI/rLeP9l/QN?=
 =?us-ascii?Q?dAuzBojSZo4N67LexOzvgLR8u9vboaWsCv5/AIFbU1CrI9VfxHYXArDvGY7i?=
 =?us-ascii?Q?fvi/eNQ824ZUsC8i/mjr1W5tdHzoDumJ+OYFs0/jc7lM5T2nFSZKNzqWUsTq?=
 =?us-ascii?Q?zYToVCWoUhxQFUkxek+5npuF/lsE3R+CEcDkaWpiG2uKmrQZPvFKAC2Dh22G?=
 =?us-ascii?Q?GFNe1R/voYcMMC6M5UJ31jiWipIdcJ2O22XAojJYIqFGN+zv1EE77ooCGiez?=
 =?us-ascii?Q?iTjwpSxnkcsB0F+EP5quhc7ir2DUnC8rzSHs8Amzm62tBWskBPxJBULEYnAj?=
 =?us-ascii?Q?NsGPRBwd3dpPVQBuUkk0fTsoAp1qkRqjaziS/d2u5Fhj28wp0w3fBpFd6piY?=
 =?us-ascii?Q?w2X2io1PcJMSmAV03yUYppGMoWyCmVuSLUgysXU/KABcoPPe3cMR7c/YVRdt?=
 =?us-ascii?Q?vefG+UYYEP5C8eebbVWcs8ukWY9RDIOpeERHO8kdnBoeUhNiRapgHlO2DFS3?=
 =?us-ascii?Q?ixzpH6R3BdJJd+xWRMPmDdAbt4cG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FD5kxlqaIxXalhWVdsZq4F7a1UpfTBUfb+Ot+XCasBJrRkwPAuIplG5XWNZv?=
 =?us-ascii?Q?Fs0cpxi6CZr7TqvwJf8RLP95OSkqKvvvgXPv6GgPCTuHIGT6WO63V9rL0GFD?=
 =?us-ascii?Q?v3VIaI1uRujebdTIJJEb8xPcsrMcUIL1szVYv/otyyF1AsaH45eXez2Pg5xN?=
 =?us-ascii?Q?Qs7Ojour01nPQMKYnr8p6RLCGVHydVW6g3LxRemllqRBcCjNJKM6l090YBJS?=
 =?us-ascii?Q?ujYTDS9YEsspDvKRgVfR3qeKt9g5E2VLpRlF6xkKE0uchEHVo9ZYls815k7c?=
 =?us-ascii?Q?GRwSDvlzD1doihhOqqmUm9eM79i5iMPk2EXyNWHSNMBQmChIiK7QF6NdhNdv?=
 =?us-ascii?Q?4wtY9O+8Enu0YaTWS4SipyMWdNn2dygl4tgbCQ3vwRgy/Y994OwEK85RXZJr?=
 =?us-ascii?Q?tm4Hf+XiydvyowpyH+RB9e5iWFv3h6MyqOqbvJzasp69z/nH5pV/pVjOY2lK?=
 =?us-ascii?Q?g8ZsJ4KAOO2SNfMGk0W3jKZyprGxAiutm44/iEwkksOf5Fc97YzfU+gLKO5E?=
 =?us-ascii?Q?EIpOaDFKkpt5f07MvNBxwsyygii+p/2O6wIZPRPDssJA1BZuds+lcY1xGkEt?=
 =?us-ascii?Q?qpOWOdjZsPwcQn2z1MEskxQSzbC/JN7VPeX9RtP2+zfvUfgJSHBlPbIdUzVx?=
 =?us-ascii?Q?PtSGPU+RaO1rmbOIxPMqeVhMwe3PNa8qCHWDJH2mUJHsWJR/X+CZDSxG9qeK?=
 =?us-ascii?Q?MKoszbk0ZRQddAlk9XmpSw3E2Ll+0Cx/UvpgKusum2GIY22RpW1AlUm5SS/b?=
 =?us-ascii?Q?RxehIfRGXWJQJD0Eb0hMJ9avhsratVK/nry0PciwxqD9uK/UuVgU+PrPHBcd?=
 =?us-ascii?Q?uqMZDTGe3a/SUFviLLq55sSt+47P98/bfYccFS49KejSYpRaHhewt6wU2Chf?=
 =?us-ascii?Q?8vSLUdwxcjqngHu+9B+20LEN2Iwv9rmokQlYqzeiUzpB1/EnX+qgpQwf0aCJ?=
 =?us-ascii?Q?cloSiQ/TvokfiJYuM1ZmZgyM8u/EX0tarp9uobruh6dFyhC9rW+sHwAtzuu3?=
 =?us-ascii?Q?DpFpCBgk7VQbHMs+5tn8h5jnsbeAWgBvv9/b9IyEWSBHN+QMzszB9WZZHsaf?=
 =?us-ascii?Q?JekiEaxVjQ/D3YoQD32iO9IRO+Bibu31KBW6oMXKmccYOFqRq0THq13ENMLj?=
 =?us-ascii?Q?12LGVhAV3qMvjRSJSh9NKZduK0VPgESwSsNmu+liqEgL9l9YMnMmohEods6m?=
 =?us-ascii?Q?H+FoJgCim06OSsQmm0Y4b4vzZxHzQxOg6i1mICtU/3WwF+drA27ROyb3D1/y?=
 =?us-ascii?Q?jeL9U3KRfD8FLxFZsAcIM81Rb7w67RijsJAGUqtI+2GTdmwGPS309PnkGJkp?=
 =?us-ascii?Q?9uD/NxMx76WsDip4i1Z3ukxKJ4D04kjzu1ATHZHVLxFVZn7aoTK/vRYXRtIq?=
 =?us-ascii?Q?h7HU22aypeMm3YOVMMgL+7IZOe5LVlpcQA0El65J6WxwpVrnr20li3/+DRry?=
 =?us-ascii?Q?lZNzjZ4MqNHNsbVoWM6ixZsmotHHXBBnJVdcb28EEqYOgxVppKx1GXBsL/E5?=
 =?us-ascii?Q?MHwBHHperdI+5JCpKSfMxKdPhrb2fT5j+eA+1QtGS9wrlsO94h0qY/RRS2g6?=
 =?us-ascii?Q?ClwMDAUiqlZoJ3GsQgZofgH4P76T6R0G4a2KewJX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7862fcd4-a3e5-443c-2e8a-08dd1e599060
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 05:13:38.0920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z+kYBsnWK315EWbxlelVxXP7jNn40OYVw7XJ2MUYKc2+7t97n6G0UG0Yr7ozr7q4zp301wgtJKbGwu/6FS1vag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8936

dax_layout_busy_page_range() is used by file systems to scan the DAX
page-cache to unmap mapping pages from user-space and to determine if
any pages in the given range are busy, either due to ongoing DMA or
other get_user_pages() usage.

Currently it checks to see the file mapping is mapped into user-space
with mapping_mapped() and returns early if not, skipping the check for
DMA busy pages. This is wrong as pages may still be undergoing DMA
access even if they have subsequently been unmapped from
user-space. Fix this by dropping the check for mapping_mapped().

Signed-off-by: Alistair Popple <apopple@nvidia.com>
Suggested-by: Dan Williams <dan.j.williams@intel.com>
---
 fs/dax.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/dax.c b/fs/dax.c
index 21b4740..5133568 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -690,7 +690,7 @@ struct page *dax_layout_busy_page_range(struct address_space *mapping,
 	if (IS_ENABLED(CONFIG_FS_DAX_LIMITED))
 		return NULL;
 
-	if (!dax_mapping(mapping) || !mapping_mapped(mapping))
+	if (!dax_mapping(mapping))
 		return NULL;
 
 	/* If end == LLONG_MAX, all pages from start to till end of file */
-- 
git-series 0.9.1

