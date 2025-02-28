Return-Path: <linux-fsdevel+bounces-42809-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48BABA48F66
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 04:34:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DC4A3B177C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 03:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744981BD01E;
	Fri, 28 Feb 2025 03:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lOFlUXkx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F111A2622;
	Fri, 28 Feb 2025 03:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740713517; cv=fail; b=Oanme5jA2G6jITqqJlKHVXa5672KKVCtmJ2C+1hKmOaW8oZqRWNHEk2wpsCQ95NIE0YXLrazs/ocfjiZYiP3Gljg/s0iVnSWrikTHL+9xSVouYCuSPOeHTthl4oqrohWt7lp95jWr1j4lopIDllwBSJkYP9EI1Vw8AAf/THGvb8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740713517; c=relaxed/simple;
	bh=NB2qWAEf3M0nhaVcGry6fSIHPnB+RJDfQFtzNOsjReE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iD7KF+1LHnlONQP8F3M4E3gbX85EpfIFfzKJycr5RtK6rZuJIWbOKtCrdOeiJzcMDYojjR8fCQQyRu5SaP8EYfcGYsNE0hR83ICy2QOPogQUvTCHEjBBjV2//kCD109bd3eGZBtp731vCAS9FOOFPe2Dsmeg9iUi3LCzIGzLJ4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lOFlUXkx; arc=fail smtp.client-ip=40.107.92.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CUJ7haef2wyK+CmE2PUbv5z+FHQJv5ZHtBddMq9KNRE952cBGLP9EtggixEdSRwMJlMbnFgzlkuVymvISgfE7wWP0Tdr5RpEhbHQx0pe9bRDAV+YySyBF6lWi5jnpiCcGBEpXsT1gjNFOALBjG3C9+xhRKSlRy26fPewqmU3Bh0DWjnbvd4Q6RSW0iY3DHWR2S0v87h0NkNJM7+tLAennNT9VcFmmytG4Q6NkmAnAu1ETkZDr8hCRk/qebbe3GQ1uH6dp2TDck0I/mfCHagPrntjFPlAX5GKDNMWbUTGwRAUx7AVNY9L095YEQjCVriKbB1vcw9wVFRDxshRzqWb0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w7VcP7ZEvUthj5PzZYbtWmdjUZ5HeQZyLdoZRveFFxw=;
 b=g9JtfrLkJE+SUqP3gBB+AYwCC1lwxs+vdLXutvrbHWJWWskHX8wSO6jm40t+HIqlyLfc0ulmGK77I9Eje/ouqHz45d/qMJH1kY+6EnsdgcQxnhWLpjZdvBwJVEYV3UTYenFE5cOqsSy0/r1ckMDHz56DfXDCN2wRJEO/kYXH+pAbZL6khvexqi61AB71QkzgYQC8lxGqnvWm6ZW9103ao644xBC15XTCnuQzXUr7+pUcvxoO3PUEDfeOBOTbm9wXkbl+d0a3TnPayiYJtbCpTmf5Nk2qDa5oaKZ5QgeOArngZg4qPdKPxKHXvUMyuqaasra1RUy0uzl5AXPt2+LCeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w7VcP7ZEvUthj5PzZYbtWmdjUZ5HeQZyLdoZRveFFxw=;
 b=lOFlUXkxx47GXPFIzLFIn/TJnK7aZCiEbhxaeNgkxAnRrk28tiqXDNj6Z2VPAFo3P2CAJwVXEBE1GElwNG3fvQdn0n52cqZ/o4WFLHGX2XNqqh85/QchUZUClXRPrJAgdmFUluOTyZPNtvM8x796goxlehbQB/suCU0Bdh3f9HnOf7gymS29Ry0Ns7RGkLoPUetFduOW88KfOwOukEgtrr+EUKUwpC0qAwLv9broBQbYK1TgrfwM+G7CRIlV+LjXq7Po3ksX6w6Tz4+6vJZxN52EB7PQ9rdxrO+S+o0NL14Rgvnh0bijAL+N6dRu4dov7Ko0w+QGwxueOEoRexj0qw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 SJ2PR12MB7991.namprd12.prod.outlook.com (2603:10b6:a03:4d1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 03:31:51 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%7]) with mapi id 15.20.8489.018; Fri, 28 Feb 2025
 03:31:51 +0000
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
Subject: [PATCH v9 06/20] fs/dax: Always remove DAX page-cache entries when breaking layouts
Date: Fri, 28 Feb 2025 14:31:01 +1100
Message-ID: <3be6115eaaa8d28fee37fcba3287be4f226a7d24.1740713401.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.8068ad144a7eea4a813670301f4d2a86a8e68ec4.1740713401.git-series.apopple@nvidia.com>
References: <cover.8068ad144a7eea4a813670301f4d2a86a8e68ec4.1740713401.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5P300CA0054.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:1fe::16) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|SJ2PR12MB7991:EE_
X-MS-Office365-Filtering-Correlation-Id: be7cbd1f-7a62-40a8-6ab4-08dd57a87039
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RTKB4wjE0Fhw3O89jzimQv7WwhLw6HsEo9ahZlXaimWTDmT5PSQx9Lgceu3j?=
 =?us-ascii?Q?RnTV7zAObEMaR9C22wvJx59J6WDYO0n8ihDDlUY938u8QeOceqy30rbgjPcl?=
 =?us-ascii?Q?2ScJwdj1JLX/7PtK6Ml7iuB/jFpO+qBp5JUfwFw75ij0SC1so8EkPntJynbM?=
 =?us-ascii?Q?RPjCgXJMz/nnCXehUMYwoZD+OBZve5oITfM8GpDGgk13zzfNDdFfnJLxp/Y/?=
 =?us-ascii?Q?HCjYwh8/TEyBbMHDRCBI2JbHJsaE6CFxZJOuU1BXlMrGljOZQMjOezyS6ytY?=
 =?us-ascii?Q?CARlGMen+K+7GABCJeviZKzYuxYGd6kveW+fSKZyXuXg1Sv5/Au41BlzyX9s?=
 =?us-ascii?Q?/b5o3f0Tac4x+d8/AUDgLIk6UVfxNLg65K5WTQsozHHnqwRE5xGqUinXjLSI?=
 =?us-ascii?Q?Tp9QpJSPriSBNwAMJRdSbsh1ubv5rr8oOb71rU38UxDAzoWSz8Ry3CVIsBP5?=
 =?us-ascii?Q?dKVxwHENxIpa4dtM1yUqU+xUDcqVQzC+chzhZiCvCocdOHQxyk+bILbGH2RT?=
 =?us-ascii?Q?Nr2Ogvp8pTw9s49KGz9tFU+dykva9fb1Z8zypPTt+0DHCnzZ+PAcTlZ8/8xW?=
 =?us-ascii?Q?QE0xzE7CsFrVN13ld76rwPxs+0OPqcdL/LhV3Yng0YRlT55ZWgq0j700SSMh?=
 =?us-ascii?Q?+V62ftYjQLx3Tgbgmjzc37SvqpMWWLuA/HrlweU/ZJjR5jWJOFUXg+/ebH0l?=
 =?us-ascii?Q?QW0JafKE0fBeqblFUczhj5lH6IwPtTImJgvMIy1t6PsuSRKqDuedQQHWFqr9?=
 =?us-ascii?Q?UdizumY4oLyAH36lOx4d1IfaOyjc6vz9UnYu+m3z5Rduy58y9aFD5pxKyJ0u?=
 =?us-ascii?Q?5Jh6YRAgQiIIHsL++r5q8ckjN0mvvPTdSBELdYOn8KMiOpzkh94wJy1Gykv9?=
 =?us-ascii?Q?P1GOmAUxTnh5EApzLuPKSOu7YslanvYCYF6t6YBw1ardeOXgtg3aPVPWHx4s?=
 =?us-ascii?Q?CJ3ZjkTGJooPSwd8TLLRHf14u4oiRrPIWe6k3BHCtk/oGagF44a1/ocMUbz9?=
 =?us-ascii?Q?4qEdpA0IH4VRkPpVg74r9kKGd5QpxbUp5zW5mYNGVmzZaMuHtsS6l2hsKTjl?=
 =?us-ascii?Q?YQY6MzeN+8DMQbaNYVD553L4wvvQskPxXzAoJgIF1K86EzOSP7LPx+Wdw5iD?=
 =?us-ascii?Q?mOgx+vsYZrsXsJjpDhiW+Zc6oFQtm0iAwD8Rybdr7yGR55RNdYEIMrL4iXa7?=
 =?us-ascii?Q?gibJgdRIcwrXc9rjOYmfDpGPo14ZQkPOjJEvIw8FaKxSu4DFt78h5uT4Iu0a?=
 =?us-ascii?Q?LXQAb7sLu7n+UyPnFyGF5JRNgyQRnco5+SVw4lkOl7epS5+wjlWDLgk/ZOBG?=
 =?us-ascii?Q?dWiMKn10EnRy6q4PaHyTXMX69sHX+zVAps15lBrQltx9sURW4L3sEIzilbLG?=
 =?us-ascii?Q?jM8IG4XYD0BfFaGlHl4yr14vBmSC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UxyMp3sRNR7f+rL6JCiP9HtnSo8DA8ZLbQYDFlVGlmq8E0cc7xSGqq2PnvRs?=
 =?us-ascii?Q?Sc9Fgr7hPNNIJKjTuLBruxNGuVuam4lAwfyOM+fGjLk1EQUfKAZJ0Eu8/3f2?=
 =?us-ascii?Q?Sux4pieI7FGJswPwb9Ow4OMBQhuDg0OSwPwiZuHQ/ba6Ujoe+n58CxToYsWY?=
 =?us-ascii?Q?n9QMxO0WUeUQiWdynCQSN02FBTySx04Y5okMu9eTmjmuDIzB2agDTqGpc6pn?=
 =?us-ascii?Q?HylM6iqTZRnZloggcRm4PNtEO1eQefK6TXjsbKteSee2oqjKOArYIA5pi8jc?=
 =?us-ascii?Q?/DmQnCcvTDwvKhHL/NDa6HPsaCFeBrcLdq1wezKbwtBfEjkYy3KrqZdVLD9d?=
 =?us-ascii?Q?14pxam3TP7JF3nk/7byMVQLU8tPhwk0aoC9IPlVqwWBSM/7o6EcdShUJnnzX?=
 =?us-ascii?Q?HOyz4kssHx9Zp0TdgFE3ndD9gMZ+9/NFJ7vWneqWiG+cWVr1WwBhPOhinD3Q?=
 =?us-ascii?Q?T0Nwilqn5be1LKUsX1bbme512YEX2wteM9FuEJvxoDT5oYaUHBUTOXLm+OML?=
 =?us-ascii?Q?XkmjDUFxeIe2m0fSRpn1/632VNrfLXEN9C4fs3AA/k08iNgR7HjmbW8zZSOQ?=
 =?us-ascii?Q?HFYh2SEi05x5G+kwI+g5XHeC3FKa6exuA2IoGofqwxxeYvuwdLayKbd+djlI?=
 =?us-ascii?Q?xNWmU93vgX9srNJQt9Me/3wIFKkkjfvqVqwIcLIX+LeHlu1sFkwqmGfFb42s?=
 =?us-ascii?Q?2r1BzB6D6gXxwCC5L0rIro1z328xMTvOwrV9iX6tB+f2FRN9Zg5aAbUl6lkh?=
 =?us-ascii?Q?NkE5AquDAku/+6qrm1y0QELeVZctyMlKaxsUsBjstwl+s/lfAMD4PtVTqrLM?=
 =?us-ascii?Q?So/dePeyW/PCpQXhoqHtxsNP7r9byZeDlg8zMcY6sQMgDjxhpag9rsF41Ct7?=
 =?us-ascii?Q?VhUTm6CzU0QqfdHE27l3R2s1HnnOmr1HKhb6r/G7zl7lffZGDb8nuoyKLBHj?=
 =?us-ascii?Q?YcKGRtYYAvVkyJ0cG+wOT9DHV/RaUOsjHM9tkkdCRbtAurAg3rWadfNbTtki?=
 =?us-ascii?Q?Tp4yajhmIL8bibUImN7dSw/zCXFyOJGcX4d4MF+L4Nk3NoOhIJDUXcsxH2nr?=
 =?us-ascii?Q?hvWkMMJAaJsHUUN6AO9wQLVdf+5Q3WALSxl0ypOE1Rmjd9XiNWM8ohmTz/W6?=
 =?us-ascii?Q?UzFooUJumzx1BbQU1qjNamzgcgXQ/5uHMd+erC7zveW8g5iUA0dvJ1qO4RDD?=
 =?us-ascii?Q?VJl9Z53b9U2JN9uLoZ/EGGB5SFd34iZezWLJJLwSQ9AWny1AfWH+EaSQmjYK?=
 =?us-ascii?Q?ZN9CKtx8OCWT6PGPsHQXN2rqVDFmK9XKUVRi4CadIhPaiXUTzXRwNdL8JAPC?=
 =?us-ascii?Q?RzVgOCTeqgTM3FPAE87mhY5CWpM5CYSYyZLZlHOkqIFnYhSrO2V9vAhCVkgq?=
 =?us-ascii?Q?yZe1jE50XSNk/8mQ8ku/ALyTStgByREB2gtCm/92A8JyWlspTyUGG/0bt5w7?=
 =?us-ascii?Q?RUvGeIit4isvPYLGw8ExeU6HGIVp83rTnq8m4h5D9iznUqR+lmnXeOWr/SC2?=
 =?us-ascii?Q?GU8dsqKD6vVLhWALi9+XHa8lvA18GrUfHQrfXz6S69C5sbNgXWP6lFI/oYOz?=
 =?us-ascii?Q?4Zc53FM0OXejWfQwYHW/meHOGUZAGWc+045YEGTb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be7cbd1f-7a62-40a8-6ab4-08dd57a87039
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 03:31:50.9806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xBULIaOTPNu7KKZRyiSSIA5wzP5shjVoqfT/Zd1BFijlOfYxaSTKUXK2Kc+r54YP+EdJNxCAmSJgluCRSbnfXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7991

Prior to any truncation operations file systems call
dax_break_mapping() to ensure pages in the range are not under going
DMA. Later DAX page-cache entries will be removed by
truncate_folio_batch_exceptionals() in the generic page-cache code.

However this makes it possible for folios to be removed from the
page-cache even though they are still DMA busy if the file-system
hasn't called dax_break_mapping(). It also means they can never be
waited on in future because FS DAX will lose track of them once the
page-cache entry has been deleted.

Instead it is better to delete the FS DAX entry when the file-system
calls dax_break_mapping() as part of it's truncate operation. This
ensures only idle pages can be removed from the FS DAX page-cache and
makes it easy to detect if a file-system hasn't called
dax_break_mapping() prior to a truncate operation.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>

---

Changes for v7:

 - s/dax_break_mapping/dax_break_layout/ suggested by Dan.
 - Rework dax_break_mapping() to take a NULL callback for NOWAIT
   behaviour as suggested by Dan.
---
 fs/dax.c            | 40 ++++++++++++++++++++++++++++++++++++++++
 fs/xfs/xfs_inode.c  |  5 ++---
 include/linux/dax.h |  2 ++
 mm/truncate.c       | 16 +++++++++++++++-
 4 files changed, 59 insertions(+), 4 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index f1945aa..14fbe51 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -846,6 +846,36 @@ int dax_delete_mapping_entry(struct address_space *mapping, pgoff_t index)
 	return ret;
 }
 
+void dax_delete_mapping_range(struct address_space *mapping,
+				loff_t start, loff_t end)
+{
+	void *entry;
+	pgoff_t start_idx = start >> PAGE_SHIFT;
+	pgoff_t end_idx;
+	XA_STATE(xas, &mapping->i_pages, start_idx);
+
+	/* If end == LLONG_MAX, all pages from start to till end of file */
+	if (end == LLONG_MAX)
+		end_idx = ULONG_MAX;
+	else
+		end_idx = end >> PAGE_SHIFT;
+
+	xas_lock_irq(&xas);
+	xas_for_each(&xas, entry, end_idx) {
+		if (!xa_is_value(entry))
+			continue;
+		entry = wait_entry_unlocked_exclusive(&xas, entry);
+		if (!entry)
+			continue;
+		dax_disassociate_entry(entry, mapping, true);
+		xas_store(&xas, NULL);
+		mapping->nrpages -= 1UL << dax_entry_order(entry);
+		put_unlocked_entry(&xas, entry, WAKE_ALL);
+	}
+	xas_unlock_irq(&xas);
+}
+EXPORT_SYMBOL_GPL(dax_delete_mapping_range);
+
 static int wait_page_idle(struct page *page,
 			void (cb)(struct inode *),
 			struct inode *inode)
@@ -857,6 +887,9 @@ static int wait_page_idle(struct page *page,
 /*
  * Unmaps the inode and waits for any DMA to complete prior to deleting the
  * DAX mapping entries for the range.
+ *
+ * For NOWAIT behavior, pass @cb as NULL to early-exit on first found
+ * busy page
  */
 int dax_break_layout(struct inode *inode, loff_t start, loff_t end,
 		void (cb)(struct inode *))
@@ -871,10 +904,17 @@ int dax_break_layout(struct inode *inode, loff_t start, loff_t end,
 		page = dax_layout_busy_page_range(inode->i_mapping, start, end);
 		if (!page)
 			break;
+		if (!cb) {
+			error = -ERESTARTSYS;
+			break;
+		}
 
 		error = wait_page_idle(page, cb, inode);
 	} while (error == 0);
 
+	if (!page)
+		dax_delete_mapping_range(inode->i_mapping, start, end);
+
 	return error;
 }
 EXPORT_SYMBOL_GPL(dax_break_layout);
diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index d4f07e0..8008337 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -2735,7 +2735,6 @@ xfs_mmaplock_two_inodes_and_break_dax_layout(
 	struct xfs_inode	*ip2)
 {
 	int			error;
-	struct page		*page;
 
 	if (ip1->i_ino > ip2->i_ino)
 		swap(ip1, ip2);
@@ -2759,8 +2758,8 @@ xfs_mmaplock_two_inodes_and_break_dax_layout(
 	 * need to unlock & lock the XFS_MMAPLOCK_EXCL which is not suitable
 	 * for this nested lock case.
 	 */
-	page = dax_layout_busy_page(VFS_I(ip2)->i_mapping);
-	if (!dax_page_is_idle(page)) {
+	error = dax_break_layout(VFS_I(ip2), 0, -1, NULL);
+	if (error) {
 		xfs_iunlock(ip2, XFS_MMAPLOCK_EXCL);
 		xfs_iunlock(ip1, XFS_MMAPLOCK_EXCL);
 		goto again;
diff --git a/include/linux/dax.h b/include/linux/dax.h
index a6b277f..2fbb262 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -255,6 +255,8 @@ vm_fault_t dax_iomap_fault(struct vm_fault *vmf, unsigned int order,
 vm_fault_t dax_finish_sync_fault(struct vm_fault *vmf,
 		unsigned int order, pfn_t pfn);
 int dax_delete_mapping_entry(struct address_space *mapping, pgoff_t index);
+void dax_delete_mapping_range(struct address_space *mapping,
+				loff_t start, loff_t end);
 int dax_invalidate_mapping_entry_sync(struct address_space *mapping,
 				      pgoff_t index);
 int __must_check dax_break_layout(struct inode *inode, loff_t start,
diff --git a/mm/truncate.c b/mm/truncate.c
index 0994817..031d0be 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -78,8 +78,22 @@ static void truncate_folio_batch_exceptionals(struct address_space *mapping,
 
 	if (dax_mapping(mapping)) {
 		for (i = j; i < nr; i++) {
-			if (xa_is_value(fbatch->folios[i]))
+			if (xa_is_value(fbatch->folios[i])) {
+				/*
+				 * File systems should already have called
+				 * dax_break_layout_entry() to remove all DAX
+				 * entries while holding a lock to prevent
+				 * establishing new entries. Therefore we
+				 * shouldn't find any here.
+				 */
+				WARN_ON_ONCE(1);
+
+				/*
+				 * Delete the mapping so truncate_pagecache()
+				 * doesn't loop forever.
+				 */
 				dax_delete_mapping_entry(mapping, indices[i]);
+			}
 		}
 		goto out;
 	}
-- 
git-series 0.9.1

