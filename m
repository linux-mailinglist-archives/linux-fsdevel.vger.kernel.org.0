Return-Path: <linux-fsdevel+bounces-35514-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D42B59D5747
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 02:43:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 959EF2825E2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 01:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0AB4170A3E;
	Fri, 22 Nov 2024 01:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fXfJZsOt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B49154454;
	Fri, 22 Nov 2024 01:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732239697; cv=fail; b=PnBy1abzyLkWWvHrXRqghsyLDVVHev2TtYeGu/7H5Q1bQuNdECF9hRSZpk2ER+/BrmtDofsVvRU4AF/pv9K01tcilEswQaw8Y62kA571gLT9rpCIUeG3LzWCClOV1OlTs790iDKvy6p75zD9ezokdvSYDjSjor+zr4kv+0eL4fw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732239697; c=relaxed/simple;
	bh=Hf5/6AmFN0iOHNDqOKhGh9Em4PNSCVXfqUDfDg3fCSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bOQtTeRCjK2DF4jhX2LnC+xPVPtyoHXvoIJZUBt61+aTDfqbyRIIDuiuO+MvoTsCgngD2pE3/Xazjzj7WqKMrQvjdj8KGVh69eejKGLkOyxIBLT93yldnjJIQ5qkjjsggKKxi8SRFWtgHeCFE+41fBYCptW7soZiWAk3ng0gNYQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fXfJZsOt; arc=fail smtp.client-ip=40.107.243.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iSrP2T/B6wO4pIczzVM+G8nBu1enZOu5AxFNup28+y9HwzW8Ak1zcLBFHJ6J5so0KRVKfW+m61X5HlSYV6oJQH3zjSheJ2gp360LnrbqefnzBjrUtDe48yd9PlsYWa2ptS/Uie7K1tAdqxZ3bvxfD0Xk6thqQiHsyGG1Z8l/95OGkrB4V/rTBWjC78OiTEMlgYkSCBLks0PMrUe/N3qTWXjqwpJn3KzxMF7sWazX6cyesspc5+/6dp32WNt4+0hTTieVzmVQxWdyHyufaXz9bcYwvMYfmD7CIo+nZnysF/uUEQnhfk7P3c37szVsvTYAT4qZTI2QFEtcBbCkGPQVNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aaxjcauunadh3WMcr+ZT+bNHtY/w01B57wxPB0uQu2U=;
 b=C7/aHwiAH2I0tg6CbwYFW2Rda8T469R512PgTTZ5b437eUPdsdaBALB+78O2Sog6KoMSJHSsBzkaBsaDLGL2AdTxMG1+EHYCxWMVJSypA+vuHhOsqGSQEHIzJqPskyMTmtRW2MPO3sO/1jyRH89ZDMLqOBKlHwXb5r16lQ0B3ps2OIbJ4P4gi3DqHIXs4Sb3c2haDlAY5rpGi6r4eKBNxJD6fLDxsJtzIhUquxpnT2msSP678pXDwrDmg2sFJpTAgYsmhro9maZ2fxSevR3RafYEWltzL87SGcbeoXfFyCmENziJWg5lMT1ASJLpaEl5aPrHbTesDGa2WqZvARxB9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aaxjcauunadh3WMcr+ZT+bNHtY/w01B57wxPB0uQu2U=;
 b=fXfJZsOtnkUhmJx4rzDUjpuCg+e90sSXpcYYl+e4SFtrCbTHeC3Zph0H3zqiS9XZdx6b1i3w6hduwsOZ2a2AvC0n3838OSsLs3XhGhW/mILbPXpeSYlepOcHh3HsGvLzJkwDf/099BFvjFVPkWXdnhhw/SlpaizeQQ1DG0ak3YtzW2zSYnyRAcLl1RWQCpWuJ7r3MCtfn3H8h6Z4G5NAm/nZhOcawOxGNH6SJU2qn0jzf58jXrEUR6zFlAC9Yo1Dn5Jkl3sya8D9D1H3STgbYgsrLc+qdEKM7Q/1xFJnJMjR/c8eaHdsw3f2fDX8Ee/1IyUD3bNEAiHJYiuYV58lkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 IA1PR12MB6305.namprd12.prod.outlook.com (2603:10b6:208:3e7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.17; Fri, 22 Nov
 2024 01:41:32 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%4]) with mapi id 15.20.8182.016; Fri, 22 Nov 2024
 01:41:32 +0000
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
Subject: [PATCH v3 05/25] fs/dax: Create a common implementation to break DAX layouts
Date: Fri, 22 Nov 2024 12:40:26 +1100
Message-ID: <31b18e4f813bf9e661d5d98d928c79556c8c2c57.1732239628.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.e1ebdd6cab9bde0d232c1810deacf0bae25e6707.1732239628.git-series.apopple@nvidia.com>
References: <cover.e1ebdd6cab9bde0d232c1810deacf0bae25e6707.1732239628.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SYAPR01CA0016.ausprd01.prod.outlook.com (2603:10c6:1::28)
 To DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|IA1PR12MB6305:EE_
X-MS-Office365-Filtering-Correlation-Id: d59761eb-5554-413a-9dc6-08dd0a96cac4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U9oStiO4tFbQPF4xT7/v9D0qjrruE8SFXv5DzWPTMfSu8Ta7+QNz0m3CnMLr?=
 =?us-ascii?Q?0SE62m/m7AWSC6V/Dwv6umqy1VB7mnlpF5UMFgXnOdZFMFw5g5yotKhJzGrr?=
 =?us-ascii?Q?QcIfxkSrp1nmDA2aqdYaLa0mlROh2e2taHWKH4ksH/zFhJpTrk6Eugslwe1r?=
 =?us-ascii?Q?2Ge83xRNSHCOXeHlJOhX1Xd/JZYq9e8PSFQXzfEYIe+0GrH8lUXCuO1oSFHU?=
 =?us-ascii?Q?iVPshCGSyvLkdB8ur503YvMJgfX7yWESQauzqeOT9tgE52E39KmMZL7wbGRg?=
 =?us-ascii?Q?WTJyo7zBp+xZiC0aokAAnQdrga9H3OQmptXMTE+lviiDCK/XI0j3OjTjs8oK?=
 =?us-ascii?Q?2jsY89GNqhKyUbVOgPFYBEGEXgMWK8Zl822Gnv96qJD8YQ+MHNCIyW66eMYD?=
 =?us-ascii?Q?spve1LOFklzF4bClVqbeO1bpTfUCpTwxjJKDAB1D+SZlBOyTY6EmA+JOYb2q?=
 =?us-ascii?Q?CcKj05w2VJMrIqe1MG5ZYAc5vX9G+TEeBh0ENhiYZKJ6z3vBb/Cn4lmDtP8Q?=
 =?us-ascii?Q?Aew6ekqRnzcTkRU6ofnpCg3fJlgonSb8IzjuT6xF7h/CHazL3AUZWsyDzP8q?=
 =?us-ascii?Q?0Ql7U83ryKdxYoXvBN5gkn8NimnW0Q6BiSkoNs4JWIiLPQsyaHYUH4QvVHyT?=
 =?us-ascii?Q?vGCjiQiFqGzF7ZPuXVhVKn65rturzaPoXxtq0LezILpWxJbihbn9pS9V3aPH?=
 =?us-ascii?Q?gMnPB0qvvXZCP3ZpKRNy/R2jhIZQQfyOqjXtAyDhhUwd+ewigF19+pBTTFoQ?=
 =?us-ascii?Q?r/PxV667zGIpb3WqPqukhtKKJhweFT47mVfaFg/xuheBgaEo7sSAozt1wCOq?=
 =?us-ascii?Q?MXC/ZOIkY+yW7/l5v7N2NL9l2bX17yK8KorCqjuzXnaK4exG2h8EoFOLKqyn?=
 =?us-ascii?Q?4/DkhaTrO6Ds8FWuHpKVfXO/rHkjKPAZ3Q77EV8lwkybkOG2f5NU8W1tV0HX?=
 =?us-ascii?Q?/o/Sjo60cb5ccwqDGwXjUxvbDzQMbHW7X6PkWIE6uvVwd2PWztpI6O+rE0UJ?=
 =?us-ascii?Q?RKySPLZ524ARtVlptGB2Svt9kHKixEtXk0HLY2NFd0YtToCipE1GWh7AAJnp?=
 =?us-ascii?Q?xIvNAxViwurN6hEn5d+VsaGjjemFwo6wkaF2a7YEenRiS8v3E5u3bv0tQAfk?=
 =?us-ascii?Q?7m0Um6q5K5MVahKEmY/Ll8YkpsdFpLcc6p9lNJr+BP6r5pZJFXK7Yn5AfBul?=
 =?us-ascii?Q?Vh1MKygZyiOM4PoHE4R4VTu/A1gE2ExMlUBFLH+lwG5+6tQyimDLaWllOduG?=
 =?us-ascii?Q?uRIP//0ii7g4126CTOZftkfsdCeMp8jFjtiGVi7Y/o2Xj2Pc6l/1LgMzGBHB?=
 =?us-ascii?Q?gUSm6AGBg4pmVNv9BMWjAziW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ncQnbCYswH438j+Gl33h1L3OT93krl8ZMps+F3vYjjTdl8obBGQloC8rBAEL?=
 =?us-ascii?Q?Hz7A1JCXVG+m9wFzeZE7xy+hRpXDpOEPU1MJUL+UAppCHehrlJVyQA6TBsbA?=
 =?us-ascii?Q?AC6FToArV2vsA+yCAvVKWkc/KQEUiTX5MgPW8Z4LkQUUcD7emCjL7dm0mNEV?=
 =?us-ascii?Q?8SYLlK9HpzbZp+LmCmiTjAiJFMceR6Sb2Hl823chWOCqownAvb7YDyLQbZ1b?=
 =?us-ascii?Q?ZVWtIcHJIpTGU3tPEloLTN89EVDjmtFcGS1WX8hd6cBLHGoqMUlfpzytfvjT?=
 =?us-ascii?Q?Rq7QKCHs1ufjdLdWzmdlTd6PryX+p9xN4xXjKMsC9spraLsgnOlG+Dl8bm+Q?=
 =?us-ascii?Q?0LNZClFvByTWOZdAkarjWy1Adjm8L7gOJVEF7EC+2UG6XLA7o4j4ePu311AH?=
 =?us-ascii?Q?/LImshCGSUk+1jRzW21uxoTZAvZF9GQYQQKlcvyrSVxXkJVuAT+0EeGW723c?=
 =?us-ascii?Q?4RS9S+G6Tos09JpgwqyqGg7HPMlPF1ZVewEfNCRcLv2X/IeOynMII3Q87YD7?=
 =?us-ascii?Q?EXwUYxEsWR5ueQqXW6kwGCNAkp57nRduBjQN6RcL/5m8PqFwjByr1mGPjIDO?=
 =?us-ascii?Q?uUs9n/1LC9Sbs2QO/Q+bypflhGrJh0gRbouFf/DDidJAb5upAwSIzTz9tobD?=
 =?us-ascii?Q?tx6ERbUXd4mT0ZA1GLHe7rAXKEZsChmfmGLSjOVNBZAU+/8W+OM6lhT3KqoA?=
 =?us-ascii?Q?GSJ10IUJ/1bNIfJkQntnM7BqE4u37YmrIDyFlHWMzRNia0R2uLNDCijusDix?=
 =?us-ascii?Q?go/XxVvp/J61IWQF15FX8xl2LrI6zcNCk3Bi966MCMpJ9YErCJ0ehfP4+Sh6?=
 =?us-ascii?Q?Rv597q8AZkhrVEgby5QC9SrDVFHSBqzKC0e0l1V7Ls3Po7SGS+OHr3/E+gLJ?=
 =?us-ascii?Q?AM7Fo5FLvc6afaJBE/Sg7S+G1Wuvs2+evn7ICjHrj4s7+mBMww4N9MzKnfNt?=
 =?us-ascii?Q?hqSnpN/FOP07i1iICusy+f+KYZS2yKDNr0sqrmrwd7jNxCEN/lmdnC3G5nkA?=
 =?us-ascii?Q?xDu0wvawV8SAiE8s90UZhQ+pU95BFTxEC5EipKEcTvejcrqoSSCiw6Y9z3aa?=
 =?us-ascii?Q?GBqh6OvJWx2A9LUFlk9c5/g6hWQrbgWER/DN14w4eP1WW3O/YRZX3WStkpti?=
 =?us-ascii?Q?Rl4fFAMRsgbx7Y+/JvKjG4rmGQj8QlWmzFMYSdNLteWT7x0R12ViwqaH4K8J?=
 =?us-ascii?Q?E2ypInX39TLKCF9hyDRC6BIPYGVd9XFHqbhZFNIqpwsi+aWtFVSrBYf0cYbj?=
 =?us-ascii?Q?+9Sx8kjEYO7J9TBAfhyAQnh3Z7Pyj54HTPxnMrt4iftliOR/igEZsSCR+25k?=
 =?us-ascii?Q?kWd2OgZTvcHbEXDt4RHq3Prpsgubd5L4b53fp37Gq5/O25wFqoaBmib+rt3m?=
 =?us-ascii?Q?bN6TwFpDe6yO1ZFFXg00XvZ3pv8OcTjuLyLJfnCJDoSG3aXXyz0AuWIZVHLu?=
 =?us-ascii?Q?3w1hY2VUxb2X3fFDPJCoVjsJPgzsBy95g0PsVxLZoDgFjiDRHFHcvGgTbajx?=
 =?us-ascii?Q?7jitBFyOUjz81rK9wkwfekUrBxBwOO8AHHPc1alt3iaGwc0mHJzfej7kvUg0?=
 =?us-ascii?Q?MfkN3Mg55cDjdnpqnXNrwcyW+OldyXRscRfa7NBA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d59761eb-5554-413a-9dc6-08dd0a96cac4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 01:41:32.2541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mM7BBtDtbubqz7V/PPzMsfZRWxBIFWD2NdLn1JOEaXhKh83UKsIQJQqdBK5n8QajQgUWpXBPEPSYEdv8UKC1vQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6305

Prior to freeing a block file systems supporting FS DAX must check
that the associated pages are both unmapped from user-space and not
undergoing DMA or other access from eg. get_user_pages(). This is
achieved by unmapping the file range and scanning the FS DAX
page-cache to see if any pages within the mapping have an elevated
refcount.

This is done using two functions - dax_layout_busy_page_range() which
returns a page to wait for the refcount to become idle on. Rather than
open-code this introduce a common implementation to both unmap and
wait for the page to become idle.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
---
 fs/dax.c            | 29 +++++++++++++++++++++++++++++
 fs/ext4/inode.c     | 10 +---------
 fs/fuse/dax.c       | 29 +++++------------------------
 fs/xfs/xfs_inode.c  | 23 +++++------------------
 fs/xfs/xfs_inode.h  |  2 +-
 include/linux/dax.h |  7 +++++++
 6 files changed, 48 insertions(+), 52 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index efc1d56..b1ad813 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -845,6 +845,35 @@ int dax_delete_mapping_entry(struct address_space *mapping, pgoff_t index)
 	return ret;
 }
 
+static int wait_page_idle(struct page *page,
+			void (cb)(struct inode *),
+			struct inode *inode)
+{
+	return ___wait_var_event(page, page_ref_count(page) == 1,
+				TASK_INTERRUPTIBLE, 0, 0, cb(inode));
+}
+
+/*
+ * Unmaps the inode and waits for any DMA to complete prior to deleting the
+ * DAX mapping entries for the range.
+ */
+int dax_break_mapping(struct inode *inode, loff_t start, loff_t end,
+		void (cb)(struct inode *))
+{
+	struct page *page;
+	int error;
+
+	do {
+		page = dax_layout_busy_page_range(inode->i_mapping, start, end);
+		if (!page)
+			break;
+
+		error = wait_page_idle(page, cb, inode);
+	} while (error == 0);
+
+	return error;
+}
+
 /*
  * Invalidate DAX entry if it is clean.
  */
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index cf87c5b..d42c011 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3885,15 +3885,7 @@ int ext4_break_layouts(struct inode *inode)
 	if (WARN_ON_ONCE(!rwsem_is_locked(&inode->i_mapping->invalidate_lock)))
 		return -EINVAL;
 
-	do {
-		page = dax_layout_busy_page(inode->i_mapping);
-		if (!page)
-			return 0;
-
-		error = dax_wait_page_idle(page, ext4_wait_dax_page, inode);
-	} while (error == 0);
-
-	return error;
+	return dax_break_mapping_inode(inode, ext4_wait_dax_page);
 }
 
 /*
diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
index af436b5..2493f9c 100644
--- a/fs/fuse/dax.c
+++ b/fs/fuse/dax.c
@@ -665,38 +665,19 @@ static void fuse_wait_dax_page(struct inode *inode)
 	filemap_invalidate_lock(inode->i_mapping);
 }
 
-/* Should be called with mapping->invalidate_lock held exclusively */
-static int __fuse_dax_break_layouts(struct inode *inode, bool *retry,
-				    loff_t start, loff_t end)
-{
-	struct page *page;
-
-	page = dax_layout_busy_page_range(inode->i_mapping, start, end);
-	if (!page)
-		return 0;
-
-	*retry = true;
-	return dax_wait_page_idle(page, fuse_wait_dax_page, inode);
-}
-
-/* dmap_end == 0 leads to unmapping of whole file */
+/* Should be called with mapping->invalidate_lock held exclusively.
+ * dmap_end == 0 leads to unmapping of whole file.
+ */
 int fuse_dax_break_layouts(struct inode *inode, u64 dmap_start,
 				  u64 dmap_end)
 {
-	bool	retry;
-	int	ret;
-
-	do {
-		retry = false;
-		ret = __fuse_dax_break_layouts(inode, &retry, dmap_start,
-					       dmap_end);
-	} while (ret == 0 && retry);
 	if (!dmap_end) {
 		dmap_start = 0;
 		dmap_end = LLONG_MAX;
 	}
 
-	return ret;
+	return dax_break_mapping(inode, dmap_start, dmap_end,
+				fuse_wait_dax_page);
 }
 
 ssize_t fuse_dax_read_iter(struct kiocb *iocb, struct iov_iter *to)
diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index eb12123..120597a 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -2704,21 +2704,17 @@ xfs_mmaplock_two_inodes_and_break_dax_layout(
 	struct xfs_inode	*ip2)
 {
 	int			error;
-	bool			retry;
 	struct page		*page;
 
 	if (ip1->i_ino > ip2->i_ino)
 		swap(ip1, ip2);
 
 again:
-	retry = false;
 	/* Lock the first inode */
 	xfs_ilock(ip1, XFS_MMAPLOCK_EXCL);
-	error = xfs_break_dax_layouts(VFS_I(ip1), &retry);
-	if (error || retry) {
+	error = xfs_break_dax_layouts(VFS_I(ip1));
+	if (error) {
 		xfs_iunlock(ip1, XFS_MMAPLOCK_EXCL);
-		if (error == 0 && retry)
-			goto again;
 		return error;
 	}
 
@@ -2977,19 +2973,11 @@ xfs_wait_dax_page(
 
 int
 xfs_break_dax_layouts(
-	struct inode		*inode,
-	bool			*retry)
+	struct inode		*inode)
 {
-	struct page		*page;
-
 	xfs_assert_ilocked(XFS_I(inode), XFS_MMAPLOCK_EXCL);
 
-	page = dax_layout_busy_page(inode->i_mapping);
-	if (!page)
-		return 0;
-
-	*retry = true;
-	return dax_wait_page_idle(page, xfs_wait_dax_page, inode);
+	return dax_break_mapping_inode(inode, xfs_wait_dax_page);
 }
 
 int
@@ -3007,8 +2995,7 @@ xfs_break_layouts(
 		retry = false;
 		switch (reason) {
 		case BREAK_UNMAP:
-			error = xfs_break_dax_layouts(inode, &retry);
-			if (error || retry)
+			if (xfs_break_dax_layouts(inode))
 				break;
 			fallthrough;
 		case BREAK_WRITE:
diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
index 97ed912..0db27ba 100644
--- a/fs/xfs/xfs_inode.h
+++ b/fs/xfs/xfs_inode.h
@@ -564,7 +564,7 @@ xfs_itruncate_extents(
 	return xfs_itruncate_extents_flags(tpp, ip, whichfork, new_size, 0);
 }
 
-int	xfs_break_dax_layouts(struct inode *inode, bool *retry);
+int	xfs_break_dax_layouts(struct inode *inode);
 int	xfs_break_layouts(struct inode *inode, uint *iolock,
 		enum layout_break_reason reason);
 
diff --git a/include/linux/dax.h b/include/linux/dax.h
index 773dfc4..7419c88 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -257,6 +257,13 @@ vm_fault_t dax_finish_sync_fault(struct vm_fault *vmf,
 int dax_delete_mapping_entry(struct address_space *mapping, pgoff_t index);
 int dax_invalidate_mapping_entry_sync(struct address_space *mapping,
 				      pgoff_t index);
+int __must_check dax_break_mapping(struct inode *inode, loff_t start,
+				loff_t end, void (cb)(struct inode *));
+static inline int __must_check dax_break_mapping_inode(struct inode *inode,
+						void (cb)(struct inode *))
+{
+	return dax_break_mapping(inode, 0, LLONG_MAX, cb);
+}
 int dax_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
 				  struct inode *dest, loff_t destoff,
 				  loff_t len, bool *is_same,
-- 
git-series 0.9.1

