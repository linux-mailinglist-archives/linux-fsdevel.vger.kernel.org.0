Return-Path: <linux-fsdevel+bounces-52178-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A720DAE00DE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 11:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4569017936C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 09:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A74280A32;
	Thu, 19 Jun 2025 08:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iq3mN273"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2080.outbound.protection.outlook.com [40.107.102.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFC6267AEB;
	Thu, 19 Jun 2025 08:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750323542; cv=fail; b=ZMCZCkMxNjJx7gHvH6Cl94kXN0IQljaXHaLVyIgkkweDhTFmfYfSXpVOTntUXNl7VP9TetdBl66+f6RNQfZbe3pJYtR83I1pYdNqNkESfcXlqkqs2c3ZdvkxhUn8Hce7msfLwmAC9Id5uuSRHB19BNjHiRhhMUQJLLui3rIrmuQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750323542; c=relaxed/simple;
	bh=W1ITD9flB1x/1u0Br3O2aJpuVkjl0MUs8OibXSMAGTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VvHWnRfmyy57XlI6gPOEJ5YCRp4zMcSJk1acY3ZS81aScbmosN5qUOOhby39EXVzamR44cUm4+In56OXFAcsjvO4ghmhB0xu2rUsNk7LRB891MJQAsoWQjBmACjNClY0f0nf3CsVNxHOUNB/18JryySqW0rUhj1+FPxgAXFbEaw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iq3mN273; arc=fail smtp.client-ip=40.107.102.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CRhZdM8okEFrc6vJgdm6LFz+AcdmdyrYsvIhYz7fKKo2RIzLf1ZHsdq3Tld5KvicbjXBnESodahCY/EHeOmBjX/DLGNl+ooUdODK6Xuo32ErC/tau3GlxSR48ohl0SyVFqUKUY4Kuq2Wa3WpQAygpybMZvkx4g4sgKI69nLfyUBtDD/ExuMtpUOudH3OJJtcKV453ccZvz02UowDlEgP6caF8bNtv1KaUIbOw20Hvwnlfpqu3E5WTrQh3HC2NfGbWUAwmC8gkq6bFLGBgaYtcvlHESmTR8gJKpsLvnexDLnGu3P45KRSfSGzLffW9RjLgd2GKQLa+/JVMnmmUhs48g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LVIg2scLZ6XgNn1rJf0cIGQq47FktPvjhAMQwFPO80Q=;
 b=Ia57l20eAwCBeF8X7FHPn91YzWdCyalJR6rv7A8ceUbSa4yv0mBB+Pz4iNdJ5uFeeWntpi1Xd8E4fj2vWGpLQfYPDbPZRck2Xpt/DL2GBxOFqMKB5jYSQoDQ7EZTOxv4SWRBPiFKgAWMNjdUqTkscUmZ8/h0ZKUyzl7AkNIXep76hXHXVHA/fpbNatlhougTuEKq/S4bjpf6pDOpXeV3EjtC/nBreapkhKfmaV1qO4pFlnytWWh4QLbQDYD6QumSe1k8Zcqrm+7ezhk+Fgvo1FKD7eLtSnqJhMf96DSDgR1be1yA++El1G6B/xEiikV+1xsElmTC/devdf44Pp9TSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LVIg2scLZ6XgNn1rJf0cIGQq47FktPvjhAMQwFPO80Q=;
 b=iq3mN273RY0RsGnX6+3tOhmrfTFoJ3I1M75edhQjPMHzAiG1eFMHquQhGxCUO3U8HyHqd66oqhlTfSNgwACn/wvngh2iwTG9fN0rrKVVqUKV6NTMrz+7YzhIJWYo/zn35eLJSziKAGhLpe5VWhPHDwCriPpAqSdervragHxCjycbbiIqSl6ACZd1gkNOX0i3zYG5HMv/JMkHL5nPRt6GTZaIV2HB61CoBb1CbuEsq0C3b33c5dFnf66KNvjQ1LmZwVqbe4OkuocqxuBKDCvlqA47860guVkWnxSeSYSZD1Q1Sdo6+JbA/0f6Y9piPyDNb1Yv4/z96+u3UFpjIfDkRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB7705.namprd12.prod.outlook.com (2603:10b6:930:84::9)
 by SN7PR12MB7956.namprd12.prod.outlook.com (2603:10b6:806:328::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.25; Thu, 19 Jun
 2025 08:58:54 +0000
Received: from CY8PR12MB7705.namprd12.prod.outlook.com
 ([fe80::4b06:5351:3db4:95f6]) by CY8PR12MB7705.namprd12.prod.outlook.com
 ([fe80::4b06:5351:3db4:95f6%5]) with mapi id 15.20.8835.026; Thu, 19 Jun 2025
 08:58:54 +0000
From: Alistair Popple <apopple@nvidia.com>
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	Alistair Popple <apopple@nvidia.com>,
	gerald.schaefer@linux.ibm.com,
	dan.j.williams@intel.com,
	jgg@ziepe.ca,
	willy@infradead.org,
	david@redhat.com,
	linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	jhubbard@nvidia.com,
	hch@lst.de,
	zhang.lyra@gmail.com,
	debug@rivosinc.com,
	bjorn@kernel.org,
	balbirs@nvidia.com,
	lorenzo.stoakes@oracle.com,
	linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-cxl@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	John@Groves.net,
	m.szyprowski@samsung.com
Subject: [PATCH v3 07/14] mm: Remove redundant pXd_devmap calls
Date: Thu, 19 Jun 2025 18:57:59 +1000
Message-ID: <d58f089dc16b7feb7c6728164f37dea65d64a0d3.1750323463.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.176965585864cb8d2cf41464b44dcc0471e643a0.1750323463.git-series.apopple@nvidia.com>
References: <cover.176965585864cb8d2cf41464b44dcc0471e643a0.1750323463.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5P282CA0128.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:209::8) To CY8PR12MB7705.namprd12.prod.outlook.com
 (2603:10b6:930:84::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7705:EE_|SN7PR12MB7956:EE_
X-MS-Office365-Filtering-Correlation-Id: 62833842-2f2b-41d8-1afe-08ddaf0f8452
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?E1csYZ+UsQ2uebzkZ357LpGN133bHjVLZJkVITOr4Op6WbQeVCneGI/8XpEr?=
 =?us-ascii?Q?XJgT0S9LBS95hdbgWVLvzT9RV8fESvRfb+YmnYrnDzJVnmqiacRmVPwbZB3i?=
 =?us-ascii?Q?Rm6IyEjshqe8CyLRF9bzbhmWsXZNM3HG9YZU+CkDHMWW5ba67Nq/wcmiGAtR?=
 =?us-ascii?Q?U2g7dRn8rCIPIQd8Sz3ZcionHnnm7dh6+5pobec9/q6U8DjMeUSl3pIo92YY?=
 =?us-ascii?Q?UnOevnpBKCifUxOBNKILSya4hLqVrh/z9HIWNizg1gyYZ7rLhdLP6/TuCXiW?=
 =?us-ascii?Q?16SIwq5JUBgqYK6+TiMQh+eEDSk5A8geE2oC0bjitIkR14DmAu96tTVddVnv?=
 =?us-ascii?Q?2WjYdFXHyxDQEyn0RuKioR2ihdcwcUEfjwYQO3aB2xhRnE8UbZLuDj68dXng?=
 =?us-ascii?Q?dW+JBlTi1RK7mXNT0iTRFxsQbN+0feU2dbic5M+SrlA2t5koj6VGs2sWYOqw?=
 =?us-ascii?Q?DVPNrjj18kx0dcu5OCBI7o7nZUmLqT2FqHWVpGkpUK5X+gR3AxIEFSal0jms?=
 =?us-ascii?Q?lxJk6hVrmfPgnk7omdpE9If95VocyttUxy2ApZ3TVHqTOj3rW+95Ck8ZGuOl?=
 =?us-ascii?Q?TawYMzTIkR1ZwDcc+W4tG8Gh5qq0I8pk68ou/+mYqie4xAxh0B9grLwWTtQ0?=
 =?us-ascii?Q?PNENEjkoq3kziF0a5/M6oh7bP2XAmxhAccU8JNxSwc3/nvN5JN62vvGhElLo?=
 =?us-ascii?Q?ZI3Eqa5RlTQh8YHBZPJPTRC/7GaubxaOXzfX4Ajn3OWhAbIAI4ennuMq1ouN?=
 =?us-ascii?Q?OmTxIt9i9h88nT2cBVTgiU4pGbA9vB56nBORhYUWSqIESat5KURm1W5uayc4?=
 =?us-ascii?Q?8Vy5NOYH2O7pPbje1iYBR9S4/metdkIQiNRtlxfzIpzNzGmo+GX92IpA6ncW?=
 =?us-ascii?Q?XMXiRVux7OY+ZKwB3ozEYWXQs/jQOHFPIlK9y8B9bUeizJr6qWM+Dmpi0zDb?=
 =?us-ascii?Q?BogVEHuRKgeCKK0N7qRUBRtGhPeGMtsm+ys1jvQjHU86OOPbUy86DpUqvxB2?=
 =?us-ascii?Q?Ff/lQu/ILQF2gs4Ya9JOnE8AMDHCbYdM5WNsQ3S588Us1kHVhslCr80SKEmt?=
 =?us-ascii?Q?+TlTbzi/T/qYT83B0GOH8iU5mufMWJc0O+nJO/kvUngHCb0YXRiWcGj+7Qur?=
 =?us-ascii?Q?LYEybJVaeXQMEjjJ5zC42Y2u/fx28YIdpYorc2PZcc3CPBxR7ACeDnt+Ir4d?=
 =?us-ascii?Q?g3tgVCL5RmfYeSNuzgFRJmW/ryHD1gvRRsIX9g+vrkpuTHVuhydv8MgcMFBZ?=
 =?us-ascii?Q?sXkWdCRrlLARRcg3dnzCphuyLoBC4mRIhJpBiqeHBCRfh+s4ibKMsP2hWk7V?=
 =?us-ascii?Q?ULUbzYmSBnvTcFhbh4KKAfjQB0/TdsR2ZoD+lYjw3fIeY3cqB8P9XMp2BFY6?=
 =?us-ascii?Q?qdAk5+M5ks8MHHb4d82K36EoMKAK6FpWVOgVFJc0OHRwwBcyNmBgjBH8y1MX?=
 =?us-ascii?Q?VO28LXdxKPw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7705.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?U35Qbd9b+x2t99TM2v4GcLQZMzIpnOnubKtEd9In3DtWKfTZ3QsKWG5cgSjb?=
 =?us-ascii?Q?/XAzmTMFCNvjMEXUzAvkbV6WXhIylerB/wkp9GxmRnjKkoZ+diFQyRT+q9u+?=
 =?us-ascii?Q?8wAkiqyJB+vewXhMFmDFKbwV2/xO1PLDGZyaSHuUK0JkZxJGShraQmQlcTLy?=
 =?us-ascii?Q?kqzy8usMg1864OZOf7v8t/epQd40PWgEptpBVEL1KiTMiFMxa5KI+dXLi3xq?=
 =?us-ascii?Q?S8r/7sWE2+D5IK34bvptWCMSkp1gIP5AKggvWFxP/wb9+ns1ZqgOVU6OJLVf?=
 =?us-ascii?Q?76hNsBN1xvSvjuKzr7JLW+9xHe0bXLsoKClzeETTzx795ij2yA0LovoPShLZ?=
 =?us-ascii?Q?1Eh8EE16nPQ/Qh//PDATTw/UsfqRjQgbJ8c9I3VpdV4lEPvuIeCVYNpfjBad?=
 =?us-ascii?Q?gu+w2NjozPjvqY7CYFqnLsx8ayOgD5eZwdkomLOe7zeFNRq2y4NYyiOf7zMR?=
 =?us-ascii?Q?7Dw2FwsB714jRkILgMyChz1JWbmaSx3HoRrqOBuNeSQ8flF9x+6BmvFy1oLm?=
 =?us-ascii?Q?O3E2Mecn+43fXi4nxLkYk7VbtTYtS2ZgWu73UwJdCQF0eue6mZgV6rjMSjEp?=
 =?us-ascii?Q?prJu0vM3+R8nN0o/1aZMD2kxhGa/Gmungagd0AGUBCHnvvOpAfNb7Nl6W7x0?=
 =?us-ascii?Q?ZrFxyye7/3y2fuP0ZcqKIi9YfCLQer58OxBu4KfexD+aV23M4ULcaqCr+BwC?=
 =?us-ascii?Q?1juLGFRkF+2hsk1hOqhXegDzxt+MpfXCqf0jeBKNkih36NY6/GOua9gWUtfN?=
 =?us-ascii?Q?ierD9C49OMHGcZ3wVEmaLZzVRgKU/VA7EMT2eo6Ve+XFe2MHtRKeCtZ77hPO?=
 =?us-ascii?Q?Eh3fsE6J7AwZVoFC2UFuV4LZf/BwrNHKRA083JHNwnW9evvCsjXx0wMYqD+A?=
 =?us-ascii?Q?NWlhtaqOIOFuJQSJ+wIIyDUOmL46d/VIPdfrpnK9Nru00n8OXr1IEbEFJv1N?=
 =?us-ascii?Q?62TpJFt6SZB7H28DmuCFjGi+uw/J3cS2aT1sRwzhV99ClqaJDvYpNLyqUohX?=
 =?us-ascii?Q?eaY+Q0LtzN0JQLCmEcl9KonTGcxtdFVj+FrwQxar3DfIrzFnHdD9RJgTxbd0?=
 =?us-ascii?Q?aJ8bg9Njme0Lg/6yfYEG6tK90XBl5zfd1kgPTQmVAqFHW0u7accB41Gf0uLA?=
 =?us-ascii?Q?LF7jCHy3pv4OHGJmwnm3CmGwDbUXX2qT10m9/1hvBZIS2JW7A51WbtNrcBUi?=
 =?us-ascii?Q?e62cAlobh8XtMHvLjb2/TZtVnjrs1T7rRjmnXcWP99zlpV7+rpBuwVvw6eUA?=
 =?us-ascii?Q?nSh5addwd+Yq7Y8FaUT676X24LADCTZsq64TyxspynBXlG594YXOz9RgPez3?=
 =?us-ascii?Q?Lw8KBxXEVzv6tbl+6Dp5wnjT0JbOkpvDzwbVr5LMXk2QTgeKBnVZnUbJQ/VL?=
 =?us-ascii?Q?ERzCw1tGhsRp4yWjaAyf/nJf7v264ywihWckBkI4PfGImc3Mg6DMszx03Oso?=
 =?us-ascii?Q?yj3wf4stVStDSnPYzrR7QIweR6IlhSObdORnECRx2BV3hrt79agaqlPgyoxy?=
 =?us-ascii?Q?T512Bl3cl4/dPzsGdb6Z9k/qxgw6YxVxHPE2wyc4yd1Oz2kyWoE5vuCSnwnK?=
 =?us-ascii?Q?v4obAodtntnngkBBPPGJtRcMQqf7v9H9ffHDU7IN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62833842-2f2b-41d8-1afe-08ddaf0f8452
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7705.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 08:58:53.8570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pNbqB1v8E7X+BrXSBr3HYUHO7Z0R5c50/tE6qa7GN1lTVZUO7VZVPRQQ8oEArU6Wi1KP28V0XNEEWOB0bUiKng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7956

DAX was the only thing that created pmd_devmap and pud_devmap entries
however it no longer does as DAX pages are now refcounted normally and
pXd_trans_huge() returns true for those. Therefore checking both pXd_devmap
and pXd_trans_huge() is redundant and the former can be removed without
changing behaviour as it will always be false.

Signed-off-by: Alistair Popple <apopple@nvidia.com>

---

Changes since v1:

 - Removed a new pud_devmap() call added to __relocate_anon_folios().
   This could never have been hit as only DAX created pud_devmap entries
   and never for anonymous VMA's.
---
 fs/dax.c                   |  5 ++---
 include/linux/huge_mm.h    | 10 ++++------
 include/linux/pgtable.h    |  2 +-
 mm/hmm.c                   |  4 ++--
 mm/huge_memory.c           | 23 +++++++++--------------
 mm/mapping_dirty_helpers.c |  4 ++--
 mm/memory.c                | 15 ++++++---------
 mm/migrate_device.c        |  2 +-
 mm/mprotect.c              |  2 +-
 mm/mremap.c                |  9 +++------
 mm/page_vma_mapped.c       |  5 ++---
 mm/pagewalk.c              |  8 +++-----
 mm/pgtable-generic.c       |  7 +++----
 mm/userfaultfd.c           |  4 ++--
 mm/vmscan.c                |  3 ---
 15 files changed, 41 insertions(+), 62 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index ea0c357..7d4ecb9 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1937,7 +1937,7 @@ static vm_fault_t dax_iomap_pte_fault(struct vm_fault *vmf, pfn_t *pfnp,
 	 * the PTE we need to set up.  If so just return and the fault will be
 	 * retried.
 	 */
-	if (pmd_trans_huge(*vmf->pmd) || pmd_devmap(*vmf->pmd)) {
+	if (pmd_trans_huge(*vmf->pmd)) {
 		ret = VM_FAULT_NOPAGE;
 		goto unlock_entry;
 	}
@@ -2060,8 +2060,7 @@ static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, pfn_t *pfnp,
 	 * the PMD we need to set up.  If so just return and the fault will be
 	 * retried.
 	 */
-	if (!pmd_none(*vmf->pmd) && !pmd_trans_huge(*vmf->pmd) &&
-			!pmd_devmap(*vmf->pmd)) {
+	if (!pmd_none(*vmf->pmd) && !pmd_trans_huge(*vmf->pmd)) {
 		ret = 0;
 		goto unlock_entry;
 	}
diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 519c3f0..21b3f0b 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -400,8 +400,7 @@ void __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
 #define split_huge_pmd(__vma, __pmd, __address)				\
 	do {								\
 		pmd_t *____pmd = (__pmd);				\
-		if (is_swap_pmd(*____pmd) || pmd_trans_huge(*____pmd)	\
-					|| pmd_devmap(*____pmd))	\
+		if (is_swap_pmd(*____pmd) || pmd_trans_huge(*____pmd))	\
 			__split_huge_pmd(__vma, __pmd, __address,	\
 					 false);			\
 	}  while (0)
@@ -426,8 +425,7 @@ change_huge_pud(struct mmu_gather *tlb, struct vm_area_struct *vma,
 #define split_huge_pud(__vma, __pud, __address)				\
 	do {								\
 		pud_t *____pud = (__pud);				\
-		if (pud_trans_huge(*____pud)				\
-					|| pud_devmap(*____pud))	\
+		if (pud_trans_huge(*____pud))				\
 			__split_huge_pud(__vma, __pud, __address);	\
 	}  while (0)
 
@@ -450,7 +448,7 @@ static inline int is_swap_pmd(pmd_t pmd)
 static inline spinlock_t *pmd_trans_huge_lock(pmd_t *pmd,
 		struct vm_area_struct *vma)
 {
-	if (is_swap_pmd(*pmd) || pmd_trans_huge(*pmd) || pmd_devmap(*pmd))
+	if (is_swap_pmd(*pmd) || pmd_trans_huge(*pmd))
 		return __pmd_trans_huge_lock(pmd, vma);
 	else
 		return NULL;
@@ -458,7 +456,7 @@ static inline spinlock_t *pmd_trans_huge_lock(pmd_t *pmd,
 static inline spinlock_t *pud_trans_huge_lock(pud_t *pud,
 		struct vm_area_struct *vma)
 {
-	if (pud_trans_huge(*pud) || pud_devmap(*pud))
+	if (pud_trans_huge(*pud))
 		return __pud_trans_huge_lock(pud, vma);
 	else
 		return NULL;
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index e4a3895..0298e55 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1672,7 +1672,7 @@ static inline int pud_trans_unstable(pud_t *pud)
 	defined(CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD)
 	pud_t pudval = READ_ONCE(*pud);
 
-	if (pud_none(pudval) || pud_trans_huge(pudval) || pud_devmap(pudval))
+	if (pud_none(pudval) || pud_trans_huge(pudval))
 		return 1;
 	if (unlikely(pud_bad(pudval))) {
 		pud_clear_bad(pud);
diff --git a/mm/hmm.c b/mm/hmm.c
index 14914da..62d3082 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -360,7 +360,7 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
 		return hmm_pfns_fill(start, end, range, HMM_PFN_ERROR);
 	}
 
-	if (pmd_devmap(pmd) || pmd_trans_huge(pmd)) {
+	if (pmd_trans_huge(pmd)) {
 		/*
 		 * No need to take pmd_lock here, even if some other thread
 		 * is splitting the huge pmd we will get that event through
@@ -371,7 +371,7 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
 		 * values.
 		 */
 		pmd = pmdp_get_lockless(pmdp);
-		if (!pmd_devmap(pmd) && !pmd_trans_huge(pmd))
+		if (!pmd_trans_huge(pmd))
 			goto again;
 
 		return hmm_vma_handle_pmd(walk, addr, end, hmm_pfns, pmd);
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 6514e25..642fd83 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1459,8 +1459,7 @@ vm_fault_t vmf_insert_pfn_pmd(struct vm_fault *vmf, pfn_t pfn, bool write)
 	 * but we need to be consistent with PTEs and architectures that
 	 * can't support a 'special' bit.
 	 */
-	BUG_ON(!(vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP)) &&
-			!pfn_t_devmap(pfn));
+	BUG_ON(!(vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP)));
 	BUG_ON((vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP)) ==
 						(VM_PFNMAP|VM_MIXEDMAP));
 	BUG_ON((vma->vm_flags & VM_PFNMAP) && is_cow_mapping(vma->vm_flags));
@@ -1596,8 +1595,7 @@ vm_fault_t vmf_insert_pfn_pud(struct vm_fault *vmf, pfn_t pfn, bool write)
 	 * but we need to be consistent with PTEs and architectures that
 	 * can't support a 'special' bit.
 	 */
-	BUG_ON(!(vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP)) &&
-			!pfn_t_devmap(pfn));
+	BUG_ON(!(vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP)));
 	BUG_ON((vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP)) ==
 						(VM_PFNMAP|VM_MIXEDMAP));
 	BUG_ON((vma->vm_flags & VM_PFNMAP) && is_cow_mapping(vma->vm_flags));
@@ -1815,7 +1813,7 @@ int copy_huge_pud(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 
 	ret = -EAGAIN;
 	pud = *src_pud;
-	if (unlikely(!pud_trans_huge(pud) && !pud_devmap(pud)))
+	if (unlikely(!pud_trans_huge(pud)))
 		goto out_unlock;
 
 	/*
@@ -2677,8 +2675,7 @@ spinlock_t *__pmd_trans_huge_lock(pmd_t *pmd, struct vm_area_struct *vma)
 {
 	spinlock_t *ptl;
 	ptl = pmd_lock(vma->vm_mm, pmd);
-	if (likely(is_swap_pmd(*pmd) || pmd_trans_huge(*pmd) ||
-			pmd_devmap(*pmd)))
+	if (likely(is_swap_pmd(*pmd) || pmd_trans_huge(*pmd)))
 		return ptl;
 	spin_unlock(ptl);
 	return NULL;
@@ -2695,7 +2692,7 @@ spinlock_t *__pud_trans_huge_lock(pud_t *pud, struct vm_area_struct *vma)
 	spinlock_t *ptl;
 
 	ptl = pud_lock(vma->vm_mm, pud);
-	if (likely(pud_trans_huge(*pud) || pud_devmap(*pud)))
+	if (likely(pud_trans_huge(*pud)))
 		return ptl;
 	spin_unlock(ptl);
 	return NULL;
@@ -2747,7 +2744,7 @@ static void __split_huge_pud_locked(struct vm_area_struct *vma, pud_t *pud,
 	VM_BUG_ON(haddr & ~HPAGE_PUD_MASK);
 	VM_BUG_ON_VMA(vma->vm_start > haddr, vma);
 	VM_BUG_ON_VMA(vma->vm_end < haddr + HPAGE_PUD_SIZE, vma);
-	VM_BUG_ON(!pud_trans_huge(*pud) && !pud_devmap(*pud));
+	VM_BUG_ON(!pud_trans_huge(*pud));
 
 	count_vm_event(THP_SPLIT_PUD);
 
@@ -2780,7 +2777,7 @@ void __split_huge_pud(struct vm_area_struct *vma, pud_t *pud,
 				(address & HPAGE_PUD_MASK) + HPAGE_PUD_SIZE);
 	mmu_notifier_invalidate_range_start(&range);
 	ptl = pud_lock(vma->vm_mm, pud);
-	if (unlikely(!pud_trans_huge(*pud) && !pud_devmap(*pud)))
+	if (unlikely(!pud_trans_huge(*pud)))
 		goto out;
 	__split_huge_pud_locked(vma, pud, range.start);
 
@@ -2853,8 +2850,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 	VM_BUG_ON(haddr & ~HPAGE_PMD_MASK);
 	VM_BUG_ON_VMA(vma->vm_start > haddr, vma);
 	VM_BUG_ON_VMA(vma->vm_end < haddr + HPAGE_PMD_SIZE, vma);
-	VM_BUG_ON(!is_pmd_migration_entry(*pmd) && !pmd_trans_huge(*pmd)
-				&& !pmd_devmap(*pmd));
+	VM_BUG_ON(!is_pmd_migration_entry(*pmd) && !pmd_trans_huge(*pmd));
 
 	count_vm_event(THP_SPLIT_PMD);
 
@@ -3062,8 +3058,7 @@ void split_huge_pmd_locked(struct vm_area_struct *vma, unsigned long address,
 			   pmd_t *pmd, bool freeze)
 {
 	VM_WARN_ON_ONCE(!IS_ALIGNED(address, HPAGE_PMD_SIZE));
-	if (pmd_trans_huge(*pmd) || pmd_devmap(*pmd) ||
-	    is_pmd_migration_entry(*pmd))
+	if (pmd_trans_huge(*pmd) || is_pmd_migration_entry(*pmd))
 		__split_huge_pmd_locked(vma, pmd, address, freeze);
 }
 
diff --git a/mm/mapping_dirty_helpers.c b/mm/mapping_dirty_helpers.c
index 2f8829b..208b428 100644
--- a/mm/mapping_dirty_helpers.c
+++ b/mm/mapping_dirty_helpers.c
@@ -129,7 +129,7 @@ static int wp_clean_pmd_entry(pmd_t *pmd, unsigned long addr, unsigned long end,
 	pmd_t pmdval = pmdp_get_lockless(pmd);
 
 	/* Do not split a huge pmd, present or migrated */
-	if (pmd_trans_huge(pmdval) || pmd_devmap(pmdval)) {
+	if (pmd_trans_huge(pmdval)) {
 		WARN_ON(pmd_write(pmdval) || pmd_dirty(pmdval));
 		walk->action = ACTION_CONTINUE;
 	}
@@ -152,7 +152,7 @@ static int wp_clean_pud_entry(pud_t *pud, unsigned long addr, unsigned long end,
 	pud_t pudval = READ_ONCE(*pud);
 
 	/* Do not split a huge pud */
-	if (pud_trans_huge(pudval) || pud_devmap(pudval)) {
+	if (pud_trans_huge(pudval)) {
 		WARN_ON(pud_write(pudval) || pud_dirty(pudval));
 		walk->action = ACTION_CONTINUE;
 	}
diff --git a/mm/memory.c b/mm/memory.c
index 97aaad9..f69e66d 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -675,8 +675,6 @@ struct page *vm_normal_page_pmd(struct vm_area_struct *vma, unsigned long addr,
 		}
 	}
 
-	if (pmd_devmap(pmd))
-		return NULL;
 	if (is_huge_zero_pmd(pmd))
 		return NULL;
 	if (unlikely(pfn > highest_memmap_pfn))
@@ -1240,8 +1238,7 @@ copy_pmd_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 	src_pmd = pmd_offset(src_pud, addr);
 	do {
 		next = pmd_addr_end(addr, end);
-		if (is_swap_pmd(*src_pmd) || pmd_trans_huge(*src_pmd)
-			|| pmd_devmap(*src_pmd)) {
+		if (is_swap_pmd(*src_pmd) || pmd_trans_huge(*src_pmd)) {
 			int err;
 			VM_BUG_ON_VMA(next-addr != HPAGE_PMD_SIZE, src_vma);
 			err = copy_huge_pmd(dst_mm, src_mm, dst_pmd, src_pmd,
@@ -1277,7 +1274,7 @@ copy_pud_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 	src_pud = pud_offset(src_p4d, addr);
 	do {
 		next = pud_addr_end(addr, end);
-		if (pud_trans_huge(*src_pud) || pud_devmap(*src_pud)) {
+		if (pud_trans_huge(*src_pud)) {
 			int err;
 
 			VM_BUG_ON_VMA(next-addr != HPAGE_PUD_SIZE, src_vma);
@@ -1791,7 +1788,7 @@ static inline unsigned long zap_pmd_range(struct mmu_gather *tlb,
 	pmd = pmd_offset(pud, addr);
 	do {
 		next = pmd_addr_end(addr, end);
-		if (is_swap_pmd(*pmd) || pmd_trans_huge(*pmd) || pmd_devmap(*pmd)) {
+		if (is_swap_pmd(*pmd) || pmd_trans_huge(*pmd)) {
 			if (next - addr != HPAGE_PMD_SIZE)
 				__split_huge_pmd(vma, pmd, addr, false);
 			else if (zap_huge_pmd(tlb, vma, pmd, addr)) {
@@ -1833,7 +1830,7 @@ static inline unsigned long zap_pud_range(struct mmu_gather *tlb,
 	pud = pud_offset(p4d, addr);
 	do {
 		next = pud_addr_end(addr, end);
-		if (pud_trans_huge(*pud) || pud_devmap(*pud)) {
+		if (pud_trans_huge(*pud)) {
 			if (next - addr != HPAGE_PUD_SIZE) {
 				mmap_assert_locked(tlb->mm);
 				split_huge_pud(vma, pud, addr);
@@ -6136,7 +6133,7 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
 		pud_t orig_pud = *vmf.pud;
 
 		barrier();
-		if (pud_trans_huge(orig_pud) || pud_devmap(orig_pud)) {
+		if (pud_trans_huge(orig_pud)) {
 
 			/*
 			 * TODO once we support anonymous PUDs: NUMA case and
@@ -6177,7 +6174,7 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
 				pmd_migration_entry_wait(mm, vmf.pmd);
 			return 0;
 		}
-		if (pmd_trans_huge(vmf.orig_pmd) || pmd_devmap(vmf.orig_pmd)) {
+		if (pmd_trans_huge(vmf.orig_pmd)) {
 			if (pmd_protnone(vmf.orig_pmd) && vma_is_accessible(vma))
 				return do_huge_pmd_numa_page(&vmf);
 
diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index 3158afe..e05e14d 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -615,7 +615,7 @@ static void migrate_vma_insert_page(struct migrate_vma *migrate,
 	pmdp = pmd_alloc(mm, pudp, addr);
 	if (!pmdp)
 		goto abort;
-	if (pmd_trans_huge(*pmdp) || pmd_devmap(*pmdp))
+	if (pmd_trans_huge(*pmdp))
 		goto abort;
 	if (pte_alloc(mm, pmdp))
 		goto abort;
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 88608d0..00d5989 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -376,7 +376,7 @@ static inline long change_pmd_range(struct mmu_gather *tlb,
 			goto next;
 
 		_pmd = pmdp_get_lockless(pmd);
-		if (is_swap_pmd(_pmd) || pmd_trans_huge(_pmd) || pmd_devmap(_pmd)) {
+		if (is_swap_pmd(_pmd) || pmd_trans_huge(_pmd)) {
 			if ((next - addr != HPAGE_PMD_SIZE) ||
 			    pgtable_split_needed(vma, cp_flags)) {
 				__split_huge_pmd(vma, pmd, addr, false);
diff --git a/mm/mremap.c b/mm/mremap.c
index 7a0657b..6541faa 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -1237,8 +1237,6 @@ static bool __relocate_anon_folios(struct pagetable_move_control *pmc, bool undo
 
 			/* Otherwise, we split so we can do this with PMDs/PTEs. */
 			split_huge_pud(pmc->old, pudp, old_addr);
-		} else if (pud_devmap(pud)) {
-			return false;
 		}
 
 		extent = get_old_extent(NORMAL_PMD, pmc);
@@ -1267,7 +1265,7 @@ static bool __relocate_anon_folios(struct pagetable_move_control *pmc, bool undo
 
 			/* Otherwise, we split so we can do this with PTEs. */
 			split_huge_pmd(pmc->old, pmdp, old_addr);
-		} else if (is_swap_pmd(pmd) || pmd_devmap(pmd)) {
+		} else if (is_swap_pmd(pmd)) {
 			return false;
 		}
 
@@ -1333,7 +1331,7 @@ unsigned long move_page_tables(struct pagetable_move_control *pmc)
 		new_pud = alloc_new_pud(mm, pmc->new_addr);
 		if (!new_pud)
 			break;
-		if (pud_trans_huge(*old_pud) || pud_devmap(*old_pud)) {
+		if (pud_trans_huge(*old_pud)) {
 			if (extent == HPAGE_PUD_SIZE) {
 				move_pgt_entry(pmc, HPAGE_PUD, old_pud, new_pud);
 				/* We ignore and continue on error? */
@@ -1352,8 +1350,7 @@ unsigned long move_page_tables(struct pagetable_move_control *pmc)
 		if (!new_pmd)
 			break;
 again:
-		if (is_swap_pmd(*old_pmd) || pmd_trans_huge(*old_pmd) ||
-		    pmd_devmap(*old_pmd)) {
+		if (is_swap_pmd(*old_pmd) || pmd_trans_huge(*old_pmd)) {
 			if (extent == HPAGE_PMD_SIZE &&
 			    move_pgt_entry(pmc, HPAGE_PMD, old_pmd, new_pmd))
 				continue;
diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index e463c3b..e981a1a 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -246,8 +246,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 		 */
 		pmde = pmdp_get_lockless(pvmw->pmd);
 
-		if (pmd_trans_huge(pmde) || is_pmd_migration_entry(pmde) ||
-		    (pmd_present(pmde) && pmd_devmap(pmde))) {
+		if (pmd_trans_huge(pmde) || is_pmd_migration_entry(pmde)) {
 			pvmw->ptl = pmd_lock(mm, pvmw->pmd);
 			pmde = *pvmw->pmd;
 			if (!pmd_present(pmde)) {
@@ -262,7 +261,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 					return not_found(pvmw);
 				return true;
 			}
-			if (likely(pmd_trans_huge(pmde) || pmd_devmap(pmde))) {
+			if (likely(pmd_trans_huge(pmde))) {
 				if (pvmw->flags & PVMW_MIGRATION)
 					return not_found(pvmw);
 				if (!check_pmd(pmd_pfn(pmde), pvmw))
diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index a214a2b..6480382 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -143,8 +143,7 @@ static int walk_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
 			 * We are ONLY installing, so avoid unnecessarily
 			 * splitting a present huge page.
 			 */
-			if (pmd_present(*pmd) &&
-			    (pmd_trans_huge(*pmd) || pmd_devmap(*pmd)))
+			if (pmd_present(*pmd) && pmd_trans_huge(*pmd))
 				continue;
 		}
 
@@ -210,8 +209,7 @@ static int walk_pud_range(p4d_t *p4d, unsigned long addr, unsigned long end,
 			 * We are ONLY installing, so avoid unnecessarily
 			 * splitting a present huge page.
 			 */
-			if (pud_present(*pud) &&
-			    (pud_trans_huge(*pud) || pud_devmap(*pud)))
+			if (pud_present(*pud) && pud_trans_huge(*pud))
 				continue;
 		}
 
@@ -908,7 +906,7 @@ struct folio *folio_walk_start(struct folio_walk *fw,
 		 * TODO: FW_MIGRATION support for PUD migration entries
 		 * once there are relevant users.
 		 */
-		if (!pud_present(pud) || pud_devmap(pud) || pud_special(pud)) {
+		if (!pud_present(pud) || pud_special(pud)) {
 			spin_unlock(ptl);
 			goto not_found;
 		} else if (!pud_leaf(pud)) {
diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
index 5a882f2..567e2d0 100644
--- a/mm/pgtable-generic.c
+++ b/mm/pgtable-generic.c
@@ -139,8 +139,7 @@ pmd_t pmdp_huge_clear_flush(struct vm_area_struct *vma, unsigned long address,
 {
 	pmd_t pmd;
 	VM_BUG_ON(address & ~HPAGE_PMD_MASK);
-	VM_BUG_ON(pmd_present(*pmdp) && !pmd_trans_huge(*pmdp) &&
-			   !pmd_devmap(*pmdp));
+	VM_BUG_ON(pmd_present(*pmdp) && !pmd_trans_huge(*pmdp));
 	pmd = pmdp_huge_get_and_clear(vma->vm_mm, address, pmdp);
 	flush_pmd_tlb_range(vma, address, address + HPAGE_PMD_SIZE);
 	return pmd;
@@ -153,7 +152,7 @@ pud_t pudp_huge_clear_flush(struct vm_area_struct *vma, unsigned long address,
 	pud_t pud;
 
 	VM_BUG_ON(address & ~HPAGE_PUD_MASK);
-	VM_BUG_ON(!pud_trans_huge(*pudp) && !pud_devmap(*pudp));
+	VM_BUG_ON(!pud_trans_huge(*pudp));
 	pud = pudp_huge_get_and_clear(vma->vm_mm, address, pudp);
 	flush_pud_tlb_range(vma, address, address + HPAGE_PUD_SIZE);
 	return pud;
@@ -293,7 +292,7 @@ pte_t *___pte_offset_map(pmd_t *pmd, unsigned long addr, pmd_t *pmdvalp)
 		*pmdvalp = pmdval;
 	if (unlikely(pmd_none(pmdval) || is_pmd_migration_entry(pmdval)))
 		goto nomap;
-	if (unlikely(pmd_trans_huge(pmdval) || pmd_devmap(pmdval)))
+	if (unlikely(pmd_trans_huge(pmdval)))
 		goto nomap;
 	if (unlikely(pmd_bad(pmdval))) {
 		pmd_clear_bad(pmd);
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 8395db2..879505c 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -795,8 +795,8 @@ static __always_inline ssize_t mfill_atomic(struct userfaultfd_ctx *ctx,
 		 * (This includes the case where the PMD used to be THP and
 		 * changed back to none after __pte_alloc().)
 		 */
-		if (unlikely(!pmd_present(dst_pmdval) || pmd_trans_huge(dst_pmdval) ||
-			     pmd_devmap(dst_pmdval))) {
+		if (unlikely(!pmd_present(dst_pmdval) ||
+				pmd_trans_huge(dst_pmdval))) {
 			err = -EEXIST;
 			break;
 		}
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 85bf782..b8a2889 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3449,9 +3449,6 @@ static unsigned long get_pmd_pfn(pmd_t pmd, struct vm_area_struct *vma, unsigned
 	if (!pmd_present(pmd) || is_huge_zero_pmd(pmd))
 		return -1;
 
-	if (WARN_ON_ONCE(pmd_devmap(pmd)))
-		return -1;
-
 	if (!pmd_young(pmd) && !mm_has_notifiers(vma->vm_mm))
 		return -1;
 
-- 
git-series 0.9.1

