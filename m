Return-Path: <linux-fsdevel+bounces-41930-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ABDB0A39203
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 05:04:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FCF6174B5D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 04:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EFA31DED6C;
	Tue, 18 Feb 2025 03:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mcJG9hsw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFB41DED55;
	Tue, 18 Feb 2025 03:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739851067; cv=fail; b=CmbH9ELjVgCpf28LuH3aybB82I0bCZ+e26VeHl0W4WDBjiLRZaK3qOcrivc5mziFmN3IB9pzx0gnVyEFxSW46p6WLr16KAAIk+JFIDCPLMxd4GSYSmnTGbXvCtM/6angNI8nb5sLziOvCzpk2ihvn9L38FxbydiyDktsxCFZNvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739851067; c=relaxed/simple;
	bh=l3tjsqoelRafPtCkxkAZUTNZI+xNMbLw/2WdiWh9a5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V2Wv5QJNqjvXr6PPzA9JKq5xN9vMshlO/oQGaf4j8cka8LDt2kqknnzMQEYvXypkGeWqR4EFh+6m5eJVKfdSjBWNoU+En5G0llwxfk+PdveYKkYZeXrbizbazAu17Ercq6FqQI86s4EJo73liDuWw14g8ZPzLKEwKdipKjrtUcg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mcJG9hsw; arc=fail smtp.client-ip=40.107.220.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JUESnSUyTSgaHVu6gHSNeAbswAqOg+B0LOEopV9gKby+mMoqqLP8PD2y9YPcJmVCJiIP1VDmm5/g2bvs0yDloeiJLVLOk1n3x5DEee3Yva09ear/BPNoJ35eOwqyiAS+ApaUEEpmqYa30S+OLgH2OQnvhgQrnFsfVfCuUbd66YSHOua5ETqdjD/3ocMePuIThv40haS+Be0s3xYD9tzmXjyjiKG6YaIc3ddZYcX5sDbaMKg5FAX5vb41eHgf+LeQrg2V1BjUBnImWOa0CMXUv77gmNmZW/KKd2xo5SvoOo8ITkN9po9LP3JEjlsKrD8oMj5jtz8ZbP0q7ylQouuEYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aUoGRvPjc6XudJSdcb96sWcrO4g7fmBhrvmPNErCJKU=;
 b=k6KpeeDt4zXyJEJ8qwAmyiqbwYBxfrmI94cpWiAoulRqHfNeXIT+5iCngTmO3goMsm3JW4IYCjGCg8ivruA4h0SeQ8bkvww+4/jiuKraV5E1V5SjNaMwOFSO6NImChMyw8GnvgUe6Rhr0WTPcQ7CO/XdcRZ+WEBh1kJy7wJFJkD6u79su0YJFcMjueejKGQ9/cVO0iAXzPVvf4dXgYv55oTHxze2bNoFjVQDblWEdnU10NCmc2Ed1qUz8pt1ooVkEyd38DXvZGbWM1ohG0RFFKSAUpkd/vwusg/oKrew25ZKpyYSqD1PbZvngdPn/Gwuc2538ww2/MEwlqzUZBwtXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aUoGRvPjc6XudJSdcb96sWcrO4g7fmBhrvmPNErCJKU=;
 b=mcJG9hswHYujC28m5/cncy4ijldioH/egvnEjBDJJWyDr5A6cpuShlKtRMr+VJQaqhMd7kHObW0j3X6yo0ZjALqE+l05amHhia543SWNkDaz0mno/4/se+xBScWtxHwM0zqeT/xIgJt00B6EOE1+aAnmvxIgdSLuxTDoOfG9fCGrT4zGpQQZ2dRqEa+OIF3OFVUoMXop7132SixsRZ2paihz9XzsCrsZIgnzLPn9r5YmoDCevSRv51vFz5+xKxgNbTSdfVsmaQ4C5FHzfhBckGvq9ZKgWnYc95QgJxk80cF9dNM6oZhmUAPKQ1/hM8tNuKUy4hAV/GPdnx99mrAnww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 CH3PR12MB7593.namprd12.prod.outlook.com (2603:10b6:610:141::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 03:57:37 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%7]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 03:57:37 +0000
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
Subject: [PATCH v8 20/20] device/dax: Properly refcount device dax pages when mapping
Date: Tue, 18 Feb 2025 14:55:36 +1100
Message-ID: <9d9d33b418dd1aab9323203488305085389f62c1.1739850794.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.a782e309b1328f961da88abddbbc48e5b4579021.1739850794.git-series.apopple@nvidia.com>
References: <cover.a782e309b1328f961da88abddbbc48e5b4579021.1739850794.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY6PR01CA0060.ausprd01.prod.outlook.com
 (2603:10c6:10:ea::11) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|CH3PR12MB7593:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dc756a1-66ef-4d3e-49fc-08dd4fd061ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pHTg7TKoBdV8azmCvt8nPs0EzwuJoYIg7FlhjmWX4WOGJ61LUz9UHY2TG6+0?=
 =?us-ascii?Q?tOJPnp7X8UpPlErN56RuWbExYBsUwac9ihjJKGbEUR0MQoUE1N9ITVufIF/K?=
 =?us-ascii?Q?zC4CkmfESNyOJwhf6RsJKdbeODCgpme0ts9BdXAp8bZtwgNIwLSUjkq089qY?=
 =?us-ascii?Q?6uQ50KsKQnHLoHbjNDl5erX5RhgF/mSK5wgMWjFfNhkOcflW2QnRrVdwfYtr?=
 =?us-ascii?Q?+Iy8E2LsjWe2zjwBYDbJ1i5Gdk8Cn5+keVdILjXDcT1pNlAHdyUbzH1BFFVO?=
 =?us-ascii?Q?r4rNleYjkoOsoIob5bkMU9kYOO1f5zlKH/lcEzY4ze9lZm9eDHQpABXHCHMS?=
 =?us-ascii?Q?nWBwDPZus0FemsDL7g2LEz0Zqpn1CZve6LST1k4yUjT6Gh7pbjQUykgw3z+f?=
 =?us-ascii?Q?LbrZPjNFceMEjGZZauUlGvBmhlp7rQbF6Gbt8ei9EG/UnzExQWIPGr/oc226?=
 =?us-ascii?Q?Srfd33t2E8zU3Mt6ecn9+GTNa8Op+pZlI/X9in+YYc2haMtSY7zTv/CAUvgN?=
 =?us-ascii?Q?b4IvvZFNMWaY9EG7KAbwKvfrwEJKQn/aTs+pgMZKaakg7PKzvxI127QtVt4J?=
 =?us-ascii?Q?1JKwUcA56czR71jUmgvz8fRnm8WE7z/PiPVqJlXie9E1Hb4Av2W9b5yQGr1S?=
 =?us-ascii?Q?9YkB5Afj3mm/j+AO4vSR7ZJJ6+VmJVuDNoug1nzPP7+uIVSKjfx2y5JqKzS1?=
 =?us-ascii?Q?GAvYckBurfhjbDUv7c2wYdP0sRaTPwgHe+uMbMK/4pmF0e41SKGR8K7+9Idk?=
 =?us-ascii?Q?u94uSY8SazKb1wJzg/b5FrBBsxuOpXXUePIkRKGEGK8dMhUPjPiaugFEX7Ss?=
 =?us-ascii?Q?dD9lU87UMFfxOr+nvkEFmp+ImfPMypeHMkDN5iz1jRhAm5UHt+84L8K1M/sH?=
 =?us-ascii?Q?os113SjlCfCYqtZq7B6/SqqvSxmjRLPIxa3cHhfSsOK4BFSM0o/CE5A83HKd?=
 =?us-ascii?Q?XpB/1djZkNCY5d3z1bj5/Gvo3yI3oJk/awGtjD+cVqjTl51uqpnCGPAygVS6?=
 =?us-ascii?Q?tMaxQA1kNpk5t/BrPmXuISC/BRX3Cp1GVbhHO3uBgm6eVIJwqhAgukXP/Ozs?=
 =?us-ascii?Q?qvvcYsoWUuMgZmU8ANit79xCCCDMbWiOXA/YH1QavtQNy4wIKn3hmv3K0HND?=
 =?us-ascii?Q?F3ZyKbKOZTgj0CrIYCOl1Syl2UTDcRVvqIluOdnYXQUi14HxpO1gb0B3/poI?=
 =?us-ascii?Q?Ee90G+RlKNu0zz2cslG0YavHmYsnnJPtyjBFMU7R0Vr2bfwVj5qfJAmtqrI5?=
 =?us-ascii?Q?R0oou6q3TyOm2qJqx8PNiFZbcylZIIF0IDsbxKl/0ZAZ2BjWChXdxyW/DWFk?=
 =?us-ascii?Q?tFo0AX0w6tTbnZc5Sjdktxt2D/iuoAmRedKq//HXM/Yc7aTqIA52iwFoddzX?=
 =?us-ascii?Q?yQAlVg3a+k8lnKSGQEftjCN1Web3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/BKux46PJhPBhJTlwlEkI5q1geFB76u5ZcBGEn4h+FRb1yjvsDJC0xgE8tqb?=
 =?us-ascii?Q?2DpplVRnllnATGVL2YUKWm3jd9rwnA8c5lZGZTO9Om4jRma16ijpJpSwhd+d?=
 =?us-ascii?Q?/WFN3zT0Ub8EEmpwbnm11wdpt4lrfb0dBHS14+0/n08LtMmAX7Adt0Yb91gO?=
 =?us-ascii?Q?UjkV+NGEFO3n/bNc6Wx258ulww/WfRHPgkc9nRcZmsPaiXSAaP0rSNk7eEck?=
 =?us-ascii?Q?lLs8bbKjmf7972pM6JZyxW1spJ5MQJWwBbm4AYBWju4JZOqG6DZFKBukrtj+?=
 =?us-ascii?Q?fgP1cGyS9jUpan5PnSDwk9DUovruCApJGHDZevSF1kIYpMOFrJqPlDYCGIQ+?=
 =?us-ascii?Q?FWQAxjKkdsZQpJy+5c72AYPEuAYHbzP66MoVWOwAjehgUIZ5SWBmlxu9+GXR?=
 =?us-ascii?Q?hy4KKtUiwgBLufj3XeNeMUA/yJ6S7Wb/kI3OV0zY6XZUZsVgx1N/WL0FphPE?=
 =?us-ascii?Q?BbbxOCZFve8TYf/1RRWPCq0K7ddNRu5aS2ujUjQPYocKsFJBbO8/WV3QKd/t?=
 =?us-ascii?Q?Dalxn5ATyNUxqjmZ4A47vOHvqoxjv7bzqymxWJXMGQ2upiK3ZDtMlOI80DtQ?=
 =?us-ascii?Q?EhNhOU9yaChSr3IfkXyunbK9+neF55h3HmMlB4s97e4lyR0LUw0v7WZxvGGi?=
 =?us-ascii?Q?/MXfZutIfsZ9osf/7s+Ye/WFEdMaBZkpmVj1PXFioy0lyYYtFVTG8Uuj4k+A?=
 =?us-ascii?Q?avCZYjnTN9bui4pKLQfMuZg+FVFbb3YZhbCg6SmAAmXKygTgAxidESfevsaj?=
 =?us-ascii?Q?Ryu9fAs6ti1Yhge/wHwjcCQ60B0s2pgTNptoeKY4bPBdIn/mPdOugaJQ9dcX?=
 =?us-ascii?Q?rxvqx+XIieWLBwSzw2MIDagVkyVlHZurbQaPbTnGQbswq8kyUQ8TfDLHfUI3?=
 =?us-ascii?Q?nWeECyGj4HXhYvMopsQ6XbnU0CXn3jg5ivJua5zAMugx4mNNdq5TX47FwqQS?=
 =?us-ascii?Q?shARq90c8UWbuenSh+De7n4+dXZa0piVG+iMTqrg1TftAjSvvPZAruRmbzRt?=
 =?us-ascii?Q?eKXrrVcINYmLUukGqicEefHDMj68i1y51w2AqU4O8Yrcud+7O68F47tiBxJm?=
 =?us-ascii?Q?CwCUF7mUo+1iLUmrWIXXm44x45KxAXfJp+OaagJuj/oRRe8x8L5cXwR/52tz?=
 =?us-ascii?Q?Fx/V4Zjlr8Tlxg8SiomAtAH3XwSTUvxKMxEPZyrq9l+WgVE2oV0NB3+pU4qD?=
 =?us-ascii?Q?d7fdIf9B9sfw1gU0GStRLH8hB9wQPw598GBdAc7ZrMp6NUpIe6x976to8rz3?=
 =?us-ascii?Q?8wpFwtL32W09GiTlKxpii2BZz4K6m2yXYm7TOyE89he1XbtraDpwl2jwSyT3?=
 =?us-ascii?Q?QfrBVwfe1SKuVaSYCThKqhxWHYXv3wJzJslwfkhdNWYwSAtnOCWizejsFOlT?=
 =?us-ascii?Q?VGaQTgruCf0U3Gs59Nwkg8LRlYBZ0XXjDk9rO1sFiW7J2fWwmdsRNwZ1vHQT?=
 =?us-ascii?Q?mXVBGPJ/LBw3C1H4imbxhQLxVVwEg0QSXgNBUxPZ901INdSZywSc3mdLteUd?=
 =?us-ascii?Q?XwhtzShGpLdUV6wWOFwysgM+svWQlWt/W04GCEvbAu+8vMcMOsjGmzOsj7Vu?=
 =?us-ascii?Q?RhdBttDG2vz5M13ZLUW/bRqUstcPxRlV37SYq2Ns?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dc756a1-66ef-4d3e-49fc-08dd4fd061ef
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 03:57:37.4658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hVJXfdCw5WD7zqXWN6XfD3X1ZD0G0QKZ9mRC6JlA+lTDqq6sAoM50hUvhPQ6S0yy89FDYx5RaVec9EA439WBHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7593

Device DAX pages are currently not reference counted when mapped,
instead relying on the devmap PTE bit to ensure mapping code will not
get/put references. This requires special handling in various page
table walkers, particularly GUP, to manage references on the
underlying pgmap to ensure the pages remain valid.

However there is no reason these pages can't be refcounted properly at
map time. Doning so eliminates the need for the devmap PTE bit,
freeing up a precious PTE bit. It also simplifies GUP as it no longer
needs to manage the special pgmap references and can instead just
treat the pages normally as defined by vm_normal_page().

Signed-off-by: Alistair Popple <apopple@nvidia.com>
---
 drivers/dax/device.c | 15 +++++++++------
 mm/memremap.c        | 13 ++++++-------
 2 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/dax/device.c b/drivers/dax/device.c
index bc871a3..328231c 100644
--- a/drivers/dax/device.c
+++ b/drivers/dax/device.c
@@ -125,11 +125,12 @@ static vm_fault_t __dev_dax_pte_fault(struct dev_dax *dev_dax,
 		return VM_FAULT_SIGBUS;
 	}
 
-	pfn = phys_to_pfn_t(phys, PFN_DEV|PFN_MAP);
+	pfn = phys_to_pfn_t(phys, 0);
 
 	dax_set_mapping(vmf, pfn, fault_size);
 
-	return vmf_insert_mixed(vmf->vma, vmf->address, pfn);
+	return vmf_insert_page_mkwrite(vmf, pfn_t_to_page(pfn),
+					vmf->flags & FAULT_FLAG_WRITE);
 }
 
 static vm_fault_t __dev_dax_pmd_fault(struct dev_dax *dev_dax,
@@ -168,11 +169,12 @@ static vm_fault_t __dev_dax_pmd_fault(struct dev_dax *dev_dax,
 		return VM_FAULT_SIGBUS;
 	}
 
-	pfn = phys_to_pfn_t(phys, PFN_DEV|PFN_MAP);
+	pfn = phys_to_pfn_t(phys, 0);
 
 	dax_set_mapping(vmf, pfn, fault_size);
 
-	return vmf_insert_pfn_pmd(vmf, pfn, vmf->flags & FAULT_FLAG_WRITE);
+	return vmf_insert_folio_pmd(vmf, page_folio(pfn_t_to_page(pfn)),
+				vmf->flags & FAULT_FLAG_WRITE);
 }
 
 #ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
@@ -213,11 +215,12 @@ static vm_fault_t __dev_dax_pud_fault(struct dev_dax *dev_dax,
 		return VM_FAULT_SIGBUS;
 	}
 
-	pfn = phys_to_pfn_t(phys, PFN_DEV|PFN_MAP);
+	pfn = phys_to_pfn_t(phys, 0);
 
 	dax_set_mapping(vmf, pfn, fault_size);
 
-	return vmf_insert_pfn_pud(vmf, pfn, vmf->flags & FAULT_FLAG_WRITE);
+	return vmf_insert_folio_pud(vmf, page_folio(pfn_t_to_page(pfn)),
+				vmf->flags & FAULT_FLAG_WRITE);
 }
 #else
 static vm_fault_t __dev_dax_pud_fault(struct dev_dax *dev_dax,
diff --git a/mm/memremap.c b/mm/memremap.c
index 9a8879b..532a52a 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -460,11 +460,10 @@ void free_zone_device_folio(struct folio *folio)
 {
 	struct dev_pagemap *pgmap = folio->pgmap;
 
-	if (WARN_ON_ONCE(!pgmap->ops))
-		return;
-
-	if (WARN_ON_ONCE(pgmap->type != MEMORY_DEVICE_FS_DAX &&
-			 !pgmap->ops->page_free))
+	if (WARN_ON_ONCE((!pgmap->ops &&
+			  pgmap->type != MEMORY_DEVICE_GENERIC) ||
+			 (pgmap->ops && !pgmap->ops->page_free &&
+			  pgmap->type != MEMORY_DEVICE_FS_DAX)))
 		return;
 
 	mem_cgroup_uncharge(folio);
@@ -494,7 +493,8 @@ void free_zone_device_folio(struct folio *folio)
 	 * zero which indicating the page has been removed from the file
 	 * system mapping.
 	 */
-	if (pgmap->type != MEMORY_DEVICE_FS_DAX)
+	if (pgmap->type != MEMORY_DEVICE_FS_DAX &&
+	    pgmap->type != MEMORY_DEVICE_GENERIC)
 		folio->mapping = NULL;
 
 	switch (pgmap->type) {
@@ -509,7 +509,6 @@ void free_zone_device_folio(struct folio *folio)
 		 * Reset the refcount to 1 to prepare for handing out the page
 		 * again.
 		 */
-		pgmap->ops->page_free(folio_page(folio, 0));
 		folio_set_count(folio, 1);
 		break;
 
-- 
git-series 0.9.1

