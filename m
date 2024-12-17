Return-Path: <linux-fsdevel+bounces-37575-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D009F41F5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 06:14:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE2F67A5111
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 05:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59782158875;
	Tue, 17 Dec 2024 05:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YXGFkIJE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DE114D70B;
	Tue, 17 Dec 2024 05:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734412413; cv=fail; b=ugtzhOKDq97x1vcdAT6/fB/cj9KrRLhGrrJJVEpmAzt6xR5RHJQSFgKsaDJSD7y9Ta8pdWponGugzmASCzHoVmMwF9nJhC7EW3ttuxZCa2ByFrcrOG//dUWKDnuoZYd7/4aZgys6qZE/Sdzqs22MbEdmIZ6iRvhjVOz5pWmMA2w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734412413; c=relaxed/simple;
	bh=RCD8Ee77RTWPZ32uiu8qRsmltvIkR4jhZjhzmdQfZIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h0K3nBmplXOtT5ZxHcdEHtU5iop7+7hkrurQswnvMWBJqcgQIv4WxgVubaIhJyQ/vPltxF6O7wAWOKrmeXYyh1v90Esle7sqDPkfgh8zMqfu+N4EBBI4J+cjjSIQWw5FZKmILU+8L2qC/08w/GXnnGz52ue3R55z3uOVAkeKa+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YXGFkIJE; arc=fail smtp.client-ip=40.107.220.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SYZqns5NcLI6aid/1gPIi1xHgBQrCx43yJxfgAsi2MtVzA5+uwjQ5xRtgtiRZCSO8ZopzY4hSQH1nxoQ07l//zV+Zt+hiaKjnuDrvPmeV9obrT3YNHussUbowxAtC9K4nzmZB//01OEj2GZfkXJdMbMWpHHSs5ypP5LSlHoNxyOYkSVImMoi9l/LWG1ssPoGw1ms3SFbUVtrmLb1/tt/53Qtz7mhB+HCSLldFgBZGGwk1Oox8iMxmNGVkfu27snFT4nmTN4SFES65tj7M0XQmp2L2yE0Njlk2C1NZVN78vvUfdgiG7SWP1gvRdd2i9AHVW8szJ1yAUzUwQusAeb+uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oPuDXC5YQtWSoYXGVf7XL4nw5iM/h23dC62Mmqkkwdo=;
 b=DxT5rXIg5o6M8lMfgpyneUdD4UBzx5SB8UOs7UtrL6fcfq7qCDSejq5P1mPIaSTEe/Qp+4w+Y8c8uPUGTNltHxgqsZdn5DAjB0HbVAJUndm4S/ULjiwzEzwZhhdCYsUiLa6Iy/uzRZUsECcx7eJI3cG6gNDeTKsjRBQ5DkztwzP9WZ3hguJzDUY0ozGZ7Bt3QYxHc07RYt2FRMFmdcOsVy06y/IlujOForD5vsyTUZlalClxZ5ICEyy+ZnX1CuThu9+cOPaQktcvs0JXd2wBAEhYsouixAXxg6hYOPmoCniQFaM3kizPJA6/cLzB2OLS+7VM1kqekm/gp4yuZFoNbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oPuDXC5YQtWSoYXGVf7XL4nw5iM/h23dC62Mmqkkwdo=;
 b=YXGFkIJESXxZwN+1AyoIhsVGZiRsJNE199S410Fgp0qXQ1v8xgXkV3VTtJTNE9fdAbglkO5HDULovWVAGuX5sSLkOKDZ7p5xA9nm7AQoVNPW3Fi8CF0X9qGp4slWyysXxoJsz7W5ER0OHk7E+ipaTT6vGtxO1rFvPLrazrexNpyLUhFxEDhay0Hs9zJHM+0oWXjR640XjdRaNhd3xbYp+yxR9GgiRuR7yj8rDYjlv/4OrtCByZCpd59LUnq8FVxc8KQ0sb92Gw2qz3Kjyn7CIteK56wwTLv7PsdWxr4NlDWjbClRp8V0Uo4/GRzBFou7utlA6c6Azq0391sCuD+Iww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 CH3PR12MB8936.namprd12.prod.outlook.com (2603:10b6:610:179::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Tue, 17 Dec
 2024 05:13:30 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%4]) with mapi id 15.20.8251.015; Tue, 17 Dec 2024
 05:13:30 +0000
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
Subject: [PATCH v4 01/25] fuse: Fix dax truncate/punch_hole fault path
Date: Tue, 17 Dec 2024 16:12:44 +1100
Message-ID: <f20cc2603bd33ee05ec4bc4cc7327cec61119796.1734407924.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.18cbcff3638c6aacc051c44533ebc6c002bf2bd9.1734407924.git-series.apopple@nvidia.com>
References: <cover.18cbcff3638c6aacc051c44533ebc6c002bf2bd9.1734407924.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5P300CA0057.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:1fe::7) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|CH3PR12MB8936:EE_
X-MS-Office365-Filtering-Correlation-Id: 92efd73d-9cd5-4aa4-7343-08dd1e598bd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vGTit7PiNrb0Kc02yU2MWw4C3jILeoV+mXw2ry3NVJuk/BbjuXvFIuBsMC4Y?=
 =?us-ascii?Q?ub4reJ729kU/54YZ+XowR2tHnxZ48P/WotDy/N8c4bDgfXM/JLl07Dh3dTW5?=
 =?us-ascii?Q?3xOg24rw6gQ6u0eckBYQZX5/zG457CwZey6LtYwhNg8NqNvRBSFbSYhKDK8c?=
 =?us-ascii?Q?1BWLRVTGUmFua4JBYlcdPtWmFelw5+Z+B2eexqWpNsFnnMLCix7zTBs30fwd?=
 =?us-ascii?Q?wKp438203o8EtxWJAqRywXIhT8J6VdovLWaoXlKyyzrimJm532JOU4+LxL4M?=
 =?us-ascii?Q?rxCz5rRdqiddOwZInwdowcT8H7eC50HORPBMPSneElYqrO4sULdGCCO1bm7r?=
 =?us-ascii?Q?gfn01P19xg+Kv910EK2DqIckO908kZphCev91sFW1yq7RiRruhJTnAqyjkfr?=
 =?us-ascii?Q?l0WduEmMFufVcxhTfgMJaXG3yn/7RgbBE2DHiVf907BqieoUfk+FXPtuWUz8?=
 =?us-ascii?Q?oXL3lx66kmikq2UCWcH70TMt4cDJSmQOSLJ62/K6Kz5+IjxOUObBsoE7Elic?=
 =?us-ascii?Q?+REgt9AWTBGEAKawTPI5b9DSi+p5AA1RteD3UtdbH4WSkbfQjhVIv7jcjN8b?=
 =?us-ascii?Q?KYgNo63mYiQhQeql8ohuyBg8JoXEvZtxNS3BG3CSNhsa3KRJ0g/j4q+vB4JG?=
 =?us-ascii?Q?ySzKkMXY7c8E7tFRuRfP5CQOBsThjs5Vgbaww1+TmGNxf55EBTqxUFy/3eyj?=
 =?us-ascii?Q?g+147o1fnLHbrnrE6l6JHGI5oSq+1K0yXcNsg6GpuXKaRSHbtKgiFoTpN3Ki?=
 =?us-ascii?Q?v9lzVjPv2SenVQONhHVwtE//xJiB2EASI+l87mhDBjkU+X++U/W8Yt7Oh6Lt?=
 =?us-ascii?Q?7GoEU6gzXPFigjaZ9DPmbLyOG0qO+jFMdTT3fJWMMq181j8wMuhHi/XV/SET?=
 =?us-ascii?Q?gUQrDFNqIgbKbs7UHFkzJxU9LrL2oZ7DNTp2XrwAmRu8iNdrOCM5FE0JI1fz?=
 =?us-ascii?Q?wI9hRoZeXdgZj3l7l/R7masqG8H61X/2bkKhjwkpWm36/N7AW+H5Wau0yzVB?=
 =?us-ascii?Q?EyXBOcUhOv3qOSoUIGMUlygpDiagqwodm5vR/KKlE9a1ptgi2jdc+zO08w8M?=
 =?us-ascii?Q?MD6qjjpfydm91Di9osjsCoEaLln4aY+5gJriTfDvgfSOufi90vuWUjayFVzl?=
 =?us-ascii?Q?h/zNq52albfjkzehqeavMTGO0xJNZ2IDew5dovTLJkNFxLshu/bFih3YgoJq?=
 =?us-ascii?Q?+ZCdo0CQJderzPDwUoYpOVpusJ5YXDKq1PA3S5W1Aho5ZY6ytn5ygVE2uyAK?=
 =?us-ascii?Q?kKTyvA03UE2msXai5KkAiV6Bac24JkaTpZK9q86tRRR+Bm1SRQFqMdKGERln?=
 =?us-ascii?Q?oqcQvvMd72MlQr3BHcfbIi7HCIIfFIWgTGVF2INMnRH6hMwYYUt4ioMosm36?=
 =?us-ascii?Q?Hb3zrEEN5g6x56ItrUyKylpWkm92?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PndvQFX0pYbvOfGKuy6VeEyX9wLw9Kjk7HmcCj6GNBkTSlRXN8Ny3oZ6D+kK?=
 =?us-ascii?Q?uvPKFVjUaIa12QUgNPo+YClJMMSzBCCsy3Sg67hJVQ5bX9Y0VN9ov24/EK+I?=
 =?us-ascii?Q?UebXSlAeLSUJGXgCB0g04yy/1naFvjd38jJ8vjkGM+JFXTQWR3WW92ys+qVI?=
 =?us-ascii?Q?TkgE6LBkAZtDrCYrD5G/TBMEj1gbbgbZduHoEfQ0YLGbYCIH1x6t7DSJpQpl?=
 =?us-ascii?Q?pgTZWbIG4XUZgCs35hz/aZ1UNZ6lrncPx/wV7jFB4Xt7TRiFSTj6LOiof4iP?=
 =?us-ascii?Q?ZYaxPDfL/SEek/BEPPVd6CL6ExSNI0MgZSOvvW7INdI8wLcu0CcBQbczSS9D?=
 =?us-ascii?Q?cs+z5nlozJFo464PcYXgIOQxIxFRq8y8n8Oa3J9WRCjyzZ/ZWmS1QoY0nZli?=
 =?us-ascii?Q?k2DS+TL9JCPL5Z8bUtl5dwCVGJQM0C23fZ1vp7We8oMVkzHIBru4C8Uq5m2K?=
 =?us-ascii?Q?jOr84NVOFNs/1WUlvEuOWrAGgJ4UoN/XHfijEeLtl9/roIi8ziJKjKu7WQPR?=
 =?us-ascii?Q?D7l5hYpCqi6op0ha0ddc56QgDLgLkX916btMRUjsJwyIiS9ybiR3Q7ijI1Q7?=
 =?us-ascii?Q?jz9GRLh0P2fY126d7ygTx8+e26+TemEZ4XBUVW6pSPlXg+1/qmNmFwLDMu7o?=
 =?us-ascii?Q?sM9SbeoZMss5nO2gTAfgdIP5DQdCzxHCFX1RYPHCPtnTR/I+WrtWi0RghTLt?=
 =?us-ascii?Q?H15J9n1DsvWV3vEA01JN9tI97/hwEnUhs5gAZ2rv6e6f+vqzrfNS2sdsiKUc?=
 =?us-ascii?Q?8I6dtfbOuWj9lzavqOhwo97BePJM4rFCk7+L6ZRxlnXWK5jJDR7RyQg1gYhA?=
 =?us-ascii?Q?zsJiLzPWzStK/S5PMV6pzswzsfXCQNBWNnopHHLLy+5Y30NVNksrDweyTbEH?=
 =?us-ascii?Q?djepWKw5yTo+Bgs7WBf9CJXgGSpMWCFS1Z8tfWq2rE69DKvi8qTot6WzJp5B?=
 =?us-ascii?Q?kFxlADmOK5GRMfFnzSBnHefa9kloX63bwbFtgDhGo/pUJ8Mu8vyxqrVsT44Y?=
 =?us-ascii?Q?3MrGHfJrJyil7JnfMtEjO8aSravGYXJfywkt2KcIVtE2P53rnDpeqbwpsbbU?=
 =?us-ascii?Q?R3CDiEqtdkRFlCd9w+XQuMuq6tiw4v2NtxhTPZpU2kfgyBD9sjP7cPnMnGaC?=
 =?us-ascii?Q?15FPIceCg27V3A+XdMo7cxwJSkfha6weqOaBefA+VowwSWw4F0Z+XcBTNG5X?=
 =?us-ascii?Q?m55JboEW09zD8HBouV4t8ootygs+VmDt8abLjsy43ojKA0CZf4aLOljSkTSG?=
 =?us-ascii?Q?KPPYPIbl6xgvc4TZEFaqRk3qENeZeMz8mfOj53pwRYPg6dGDB7i+F1S6vlj3?=
 =?us-ascii?Q?tHO/gDYxoG4KNrnMNc9EvIAZ4gjuqOOqq7vOO9ozMaEFhr4wP+yRS9hbzjLx?=
 =?us-ascii?Q?ZjM43BzNJ2NggArqSbi4ZRYsSRWhMRLcoaeCycJ6uWbtBjEWrGuaONeRhCb7?=
 =?us-ascii?Q?PtKdD54dDP8OWUASyF6GGlCd3h7CaGtaITIjQAdcjhvCIqh8XyrUC8PV97j5?=
 =?us-ascii?Q?GlW2krZpNbNfBh6v6lJr+RwUTIfuER6ZNhR+YC7gaFCJYRPTkT8Mi7ZMCAE4?=
 =?us-ascii?Q?bN1Mz9iTgKxyaXORjK8kbfG+6hp7FORNOcwoZovu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92efd73d-9cd5-4aa4-7343-08dd1e598bd0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 05:13:30.4259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gfxgxB4Owg7WFQjB2fzDNZFbOOy7Uwopd4MAYD06xcMVeiDrQGLE1QWVP/rvXLezZhGjJhjr8qn3Zk3KBCQmSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8936

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

