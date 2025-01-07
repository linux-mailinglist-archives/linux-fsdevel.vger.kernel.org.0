Return-Path: <linux-fsdevel+bounces-38519-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D46A035F0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 04:43:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6833D1885940
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 03:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E05A198E78;
	Tue,  7 Jan 2025 03:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="p9WrWxT5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100C0145348;
	Tue,  7 Jan 2025 03:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736221390; cv=fail; b=h3rmlShfaS+pY6GH37mEiKwZMy+cGYggU1be420LLR+boBrQ9/+gR2JS7cCHWGqQtjbw35Yxs5VM7FCWQkhhfIhm8hNUrOgZ1oFZu+MKPIOl0imL0Ji4NYukS7KDnvOkuZ5kRUM0hQZHVcTQEh3i4jVI1OgFEPY5vF2r00NhrH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736221390; c=relaxed/simple;
	bh=RCD8Ee77RTWPZ32uiu8qRsmltvIkR4jhZjhzmdQfZIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X8T4H16X5nfcA79kGcUunz2n+sB88DBx36MH6kNW1dr08HPtVcQdGY8/a405u9ejWzS8KN7aFCGASRVxJakuzpqGOHNlG7BMAxg4WPDjWWVJIMboK0Qsmyxlh0/S52kBy0JoaK78Bgr8b3ogFQAMtauYyiMAtA07TI+jiZpF9NY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=p9WrWxT5; arc=fail smtp.client-ip=40.107.220.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mSXvV0rrbvyXMljKvZRzKjGZenr2s2l6bpyvuZGQIzjLOvV6ECXBb5zKY/GlbOdM62fsk/K2nznqrB095LjfSG2OR0/adgZ7ktUEZo/gLAJ9nIuZD0BIPxyf5EDMPZGJoF1BZpghACaVBZBWhJfL2LopD/s640oW7LJt22YHpeJ2noKg/h2TwNrmGN/Xy3j4hQipAjzWd/iWpTemiGhei2TTuNvujdGlxOCm3Tt6HCxO5JvnURMcgy63q7WZlNs0KjqTMbOIpEoikWJspowdBYcg9fgkA1tqMgJE83BpCMWQcnEgDSQJn7DjGlpmrK+tYADS9B95OtePUMGATdzAVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oPuDXC5YQtWSoYXGVf7XL4nw5iM/h23dC62Mmqkkwdo=;
 b=J2xB+QqTaAEvWBDj2DEOSQqnLz6/cvwEGqinTDFP4KdQOjwMmuzmNF6CiMfJDse2HALMXXiqUmbTYA5VjHdii/QalZFUwxolEsqLbSwkNCm/brRd/viVZgRYxuHN48zJoQSED5paRAPUNhNmT82b3CjiatiWKY3pKX8CNrFer/hVUe5dvbp0jFzOCZVCL7dzQztAjmgxP4gAd43/s3Px/RlhufxOHQb+5cP1VzXHabBY/bRFX0T4GmyLm1K3jku6E6QUN/lFpnqs2GdAV2oN8OXfGhrn2z3TIKA4JqdRDvwODvJqDYJryJNZr1cu3B0fcooq3SuPvKzEJ4AEln7abA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oPuDXC5YQtWSoYXGVf7XL4nw5iM/h23dC62Mmqkkwdo=;
 b=p9WrWxT5Ml5JwxHwBsaWJ5X2mnFX38sJgVwZEF0MtmCZfNcvrgTaXRMeUsQ99MpHu+YvDZtBIc2zBuRqPI9itDlMNJ4SLj1fnkdMzJhjJ1MKhJHb3A19GgfSIsrsLGbJ6ZQc8hLXXi/hX2S9jORphUZCjvijU+FFw8nRC6hqszPe4/WMrmz3+U6aCTYge1qMdbSz2BOZAOXyoUCDJ215OkrB/Q1PiRudRWQJpaO/H+KmsBW4tFCjAo2W3tyKk95HOYtpcFLgdIHOrEj3cD1kahAr+hROQpWeDntElCCY8/xZ+qNE0x79xijanzNC1X/4xSaVOLI16CkjFNy7GwayhQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 CY5PR12MB6129.namprd12.prod.outlook.com (2603:10b6:930:27::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8314.15; Tue, 7 Jan 2025 03:43:03 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%6]) with mapi id 15.20.8314.015; Tue, 7 Jan 2025
 03:43:03 +0000
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
	david@fromorbit.com,
	Vivek Goyal <vgoyal@redhat.com>
Subject: [PATCH v5 01/25] fuse: Fix dax truncate/punch_hole fault path
Date: Tue,  7 Jan 2025 14:42:17 +1100
Message-ID: <f20cc2603bd33ee05ec4bc4cc7327cec61119796.1736221254.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.425da7c4e76c2749d0ad1734f972b06114e02d52.1736221254.git-series.apopple@nvidia.com>
References: <cover.425da7c4e76c2749d0ad1734f972b06114e02d52.1736221254.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY2PR01CA0008.ausprd01.prod.outlook.com
 (2603:10c6:1:14::20) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|CY5PR12MB6129:EE_
X-MS-Office365-Filtering-Correlation-Id: 17d98f96-12e0-4a8b-7197-08dd2ecd6362
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hEM9HN8UXbimi2w70PlfIpSyqxC+HDNP4I+sgPTCyBDU+KTHzI/XE0uXcsMC?=
 =?us-ascii?Q?bpkMHjp5nB6D714XLc1u1Id6wVySrZq1WQH2v9DdBwX+1rMpGMPALCTnCz8a?=
 =?us-ascii?Q?GbSLaWNbzauKWYCS6oRs5bp0tZUhhzHYPlewta1PaShpjiyAfGDC1Ak17YBG?=
 =?us-ascii?Q?yDMDYBkcJ9aJTwKMe/RzZ+e8UteIMUKXa0jI+qfdWEA/kOQS/4BO/p3P8aiA?=
 =?us-ascii?Q?J/78gaEjWbu6fMDbj7uLsP2Tlm33sUAeUrCiv/N4FtSPZpbgTp9jek9dd8ut?=
 =?us-ascii?Q?Hro9aMwJRlMrX7P7+wD21Q5wJE5y6qkqyCcMyerHdWUj6hoMAuplYKDPZQu9?=
 =?us-ascii?Q?J8CD4i6DhpIQUCODTzHVAU0cuRo8OzSPAJNOxjzL64yaFaJ5Aan6QrDzzzFe?=
 =?us-ascii?Q?VYUywDZNg/lKBML6vXBnI41WEp1lVTCeJ3lMVCBeWlm74HKjlJ2Dq+AnSoS3?=
 =?us-ascii?Q?/LDJB6l3gAZqixLHEZxXX1m9YypAaL9xczSaKzot9FEaXTeb2IOd2/l2Ty5x?=
 =?us-ascii?Q?gJ2FMRgWG8icnWvxe6/TMGrRgydUcSLqkypPa23Q3qCpG75DiLLcjSXbd22+?=
 =?us-ascii?Q?GrUB3isYaLhjtLxtPc0b8vukxSDj3zfcpihE1SKISXwEN0i3mUZtJmzTqi6A?=
 =?us-ascii?Q?oJp88m5g9IFoMEjBjO89aaKZWMq+4fgtR5hLXL2l3FDOkJdbTKvZcmQIbTXh?=
 =?us-ascii?Q?XKvPRa2XUQEfCNycfa+qWAVRxmaqinzhYfmpyxl0a1FxW6YA2OeayAq2qh3U?=
 =?us-ascii?Q?fSFMAfnyvQz1uFU3K7gjvFk1RcecUxbumLYWVtYjQkBaJSM1E+DmsM+anM0h?=
 =?us-ascii?Q?A5J7WwGw8n5rpAlq9QRFQDoWo6k3Z3tzNI+deP3AwJ8iNfmKSx+HyHRxeBT5?=
 =?us-ascii?Q?R/SrAUG0IGGn5mAdL0vdfBbAnABP9BZpKhHFcfxeDTP0dUnluUDmuUzBE4G6?=
 =?us-ascii?Q?cdAelDYX/fzV7Pw1C/tj8ZLFcHwqvxiXlpDWe42nXIsBSk3ojT2yp6JUAkMR?=
 =?us-ascii?Q?n9UuD1UdaTE4UpUry79w669yz1XG+gLAHjjTSlZZdCC5MKfhJUw9hM9U6rnB?=
 =?us-ascii?Q?bux4tj7gHRB9VhYamkxy3WDZrTCXzvOT3wLmEUJwovqOH/MXxIlS4bU8yoTj?=
 =?us-ascii?Q?ayohWG5T/TtsWD1q6IWYVwc4Aep1R17tSztyfDI5UrHDn1S40LbvO48KGNMN?=
 =?us-ascii?Q?PzGqs4GbrnL1MoDFdAUMBs3sWUCWNLkdcjcIF8kr8ZloekxfOJrb3CbzGJDI?=
 =?us-ascii?Q?PpZb1yCW66q/MwmLl7l7iRSFVxZz0jYDgXGcNnVqXlz8A27xIxLK4dH9o+5V?=
 =?us-ascii?Q?wPnV4CP9QenVLPma5G+mGczGE5z5r/UdRi5ZhrAyhuCWgiBrECemVua7xV28?=
 =?us-ascii?Q?ESQ11v1Ynp0T6sVBMxG497rs7FU0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Qde/VVVeTDLGggMASo3zD+bwm2UeENaWCRcT7ZpHGCDRwqIAmeIxOCj67M0S?=
 =?us-ascii?Q?1kkGJsPxDEs3g+YNU3B9Tm8bYuT0kX7nYdmdGh2NWNtL1V4cFRfkaWMDJ02s?=
 =?us-ascii?Q?J78ENd6lIGhghGbPNHADUXG0U8bdKFPWDPjWvMnxfvSXw0KCsExu1HW/VnmH?=
 =?us-ascii?Q?VcfOaoLQXWe1pzkI2BQE6Uq23DoOUSNxS5Hx0F98xiSmCmDfnfe1g/4/PNIT?=
 =?us-ascii?Q?IOoSU8iAXJ1Ej03Vrabh6WTbWuScYazPdM2AWq1hfq8hmA6dIUChmv5FPF9E?=
 =?us-ascii?Q?wQKOLdvZGaK8oF+ApFO20OT0cZ7tr3Hz8L04FDWrjp9VO+7CmAhFS6ruIM6Z?=
 =?us-ascii?Q?S852ybw1/KrAjOQOGbTvAGwzkxzczfi4TWLlyWv6ur9REpDhHGgOBjSKKcYQ?=
 =?us-ascii?Q?ANeyQjVxQpvXtdBvBdnleSV3GYw+vSm8656ZmDCaIAzoTZ4M4BwUVmLCz3oT?=
 =?us-ascii?Q?xRzrpJC+cT2wGb/GETh0rhHd2A6HUsFPrBRyF+VVBX+c/5sN2Tz+cdXp+8Of?=
 =?us-ascii?Q?X8i+lp9TgdwoePIzfbhTGQkZN/6eYhygHi2+SqseFcHD5uQA2r4AO1pRUhQg?=
 =?us-ascii?Q?RN5rl1Gvje0LfvI63Z+2Q5lAZb+ZBJrsQ/v5wZo/HWxrF47TUpVBsD4FbKVZ?=
 =?us-ascii?Q?9edNtwcEAOIFmhQtZmwph99AvNMicFzIoGC6is54UyA5gX+hjudPaHbdsDwn?=
 =?us-ascii?Q?Hu4BiFJgr4uaz+LUL4eX4Z8fEGDcBaKiDXEBpbycTnnlsZJaN1CZpUnDvBht?=
 =?us-ascii?Q?ISIMpfu05y20Xdch/42ivzhtNERS0cNUPT2nyx7OTa97LDyV20p74Hfi2ynJ?=
 =?us-ascii?Q?q3LX/ex4vUc3+0dvied0CjHVqLmJ+4xaplZ11Zqg0KWtlMA/817UV8pvWzo8?=
 =?us-ascii?Q?DQXKJ+tz3rVH3/Qfkm870TnmYlRAezC14/xfrlCbVySTaPQ0AFVKlp/qPMsG?=
 =?us-ascii?Q?RN7IIQr5s1yeVUkhxaxFZ9/4/OMC1zGJXTyda7USO3L6vj3oPHI1uu9/N9TX?=
 =?us-ascii?Q?nm2NV647d9bYynPj0u2pJzJMfpK62YPGufnG5KvIxhNYdq7775bS0PFwbHgg?=
 =?us-ascii?Q?wDefN1tRjBCWZ2CDA/gkLvPjQiznVPAoqMn6y1LnXIlmgrqL0SK+H0nVAH4+?=
 =?us-ascii?Q?OS7dH0c4iREvv8mxjrEP1qnaaoWDigq95+O8N4Ppl6ukutzPtrODklKa8PO5?=
 =?us-ascii?Q?+xW3N83hbKZQ3kRvm7dJ/71mLGEGGnHrbR2Gfxbi+AlPFU74nKeVDX8bA6ks?=
 =?us-ascii?Q?m/fpk5S7VsF/dcYIr+TIpfWUr25PhXs0nFFaDPwfE96ytmM52kmUQMxXnBqQ?=
 =?us-ascii?Q?WdgXWWwnzoTdsC0j3QLLapzZ0TsJsVzr7pm3xO223W1S75DX4gQt9hzVMcg+?=
 =?us-ascii?Q?YZ9I8GWC66kSpgXApbUdjbtQALbdFsqR8ut6k94LRNl0rbQt1q3EhEYkrpCf?=
 =?us-ascii?Q?L97f7a1merYSea1Ki9JHhIjMwBRUTpzolIJBrATP7UhYldB1c56O3+as4h4X?=
 =?us-ascii?Q?kgATNQfAe+E+JGKTUz+F8dOujQv4LmOac/+ef8/x848pUQUoOcxiJd1gqrlo?=
 =?us-ascii?Q?ajY36ieBgJA+cgGYaIWIKBPEvxzHVhLKjxpr+gKq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17d98f96-12e0-4a8b-7197-08dd2ecd6362
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 03:43:02.8917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dnvF7p0oTkfKSGkUCcbGH1RFzoP1kJjufcX9BiMx1clVA59x7jkhf7ofUmtNNG+adrwodTOY/7FF00E+f35D1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6129

FS DAX requires file systems to call into the DAX layout prior to
unlinking inodes to ensure there is no ongoing DMA or other remote
access to the direct mapped page. The fuse file system implements
fuse_dax_break_layouts() to do this which includes a comment
indicating that passing dmap_end == 0 leads to unmapping of the whole
file.

However this is not true - passing dmap_end == 0 will not unmap
anything before dmap_start, and further more
dax_layout_busy_page_range() will not scan any of the range to see if
there maybe ongoing DMA access to the range. Fix this by checking for
dmap_end == 0 in fuse_dax_break_layouts() and pass the entire file
range to dax_layout_busy_page_range().

Signed-off-by: Alistair Popple <apopple@nvidia.com>
Fixes: 6ae330cad6ef ("virtiofs: serialize truncate/punch_hole and dax fault path")
Cc: Vivek Goyal <vgoyal@redhat.com>

---

I am not at all familiar with the fuse file system driver so I have no
idea if the comment is relevant or not and whether the documented
behaviour for dmap_end == 0 is ever relied upon. However this seemed
like the safest fix unless someone more familiar with fuse can confirm
that dmap_end == 0 is never used.
---
 fs/fuse/dax.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
index 9abbc2f..c5d1fea 100644
--- a/fs/fuse/dax.c
+++ b/fs/fuse/dax.c
@@ -693,6 +693,10 @@ int fuse_dax_break_layouts(struct inode *inode, u64 dmap_start,
 		ret = __fuse_dax_break_layouts(inode, &retry, dmap_start,
 					       dmap_end);
 	} while (ret == 0 && retry);
+	if (!dmap_end) {
+		dmap_start = 0;
+		dmap_end = LLONG_MAX;
+	}
 
 	return ret;
 }
-- 
git-series 0.9.1

