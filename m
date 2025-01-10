Return-Path: <linux-fsdevel+bounces-38807-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC8BA08734
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 07:02:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CD233A3B6E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 06:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A942066D7;
	Fri, 10 Jan 2025 06:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mf3LZHqK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2062.outbound.protection.outlook.com [40.107.100.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29742066FF;
	Fri, 10 Jan 2025 06:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736488887; cv=fail; b=dBpHCol8jKen4I9/ZA33ALVZIZ5A+HxSWsYhNuJKjYWMF+3pAh0wmEB+cXP1w+fQE/rgTMhQcAM0FigBhuzHK6zeVjo9eqbHFM7kKWK4ckqkT976XZXtw4qePnfuqBDCdWxRFg4ZbUMeOFmWW976hXdjKnLg/rr6z/uAM8yQmnI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736488887; c=relaxed/simple;
	bh=qN4EvV1nBT456CCQnDYQJT+nMqUPfSlVkPdOylOsJYA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FgLdi5izAROrXB1aTz/HZNiP1HxzANbTGakKc5/LQeirhKOSYHDQ9yC8vWIa0FaQ/YJbwPndCVTg+mO56MZEiRMONNtToLgPn3Mhapv5S2TusVKbORCO/+eTfCef2fkSYyJlerbWjaNWBClqbuMet5yzQ9CLy6mjenJ6WFRsqFU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mf3LZHqK; arc=fail smtp.client-ip=40.107.100.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U5GZBIzNet1G4cQFRU+Q54xBT5t5qrRgDTv5jA5pTLG3nya+VeqCpzi32GtMqwHaqzMjNu/y0QWwSvcJtcKgwmyj3a4fnUbijiANwCqqhWzGUHzvC8BpNpiKKysUC0hZo0ZT4Ym9P1hRuH3twz/WYnUbg+XBXOzBJ6JYJoVQJxKo3ODpwHlUxqVZE9vGdwMNJB2BdoOxsV50TC6wrdixQ269yH4IYSbpkzTm/tjvCsxiFRVt8+klO/J1aQvGo6OUkNyjqYkp1jtJlTURkBAXy9k2orscRnCGAsyKTT/IL6mFkO1/gXOKxNERvphpQNi163/BVmStsl6ICgNDvLHJjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LbBcp8B+/Sn0jziT5hc2amOpZmSK5V3jlPqrQF2ZsC4=;
 b=Ix+ieebpZGBChCvt0i49n+lUM4YRIcOZJCF5TSNbeYyEt0/7B0Oq+EPr4tdFbpjkTgaXxuA+7J+8jgsffcHIv19SC0xiBRDfdAd9olJGxBQDn4Av2dNZh+IBNcaIQVTuNkvHQWkkPEONsHdOJEttj5T7kmZ5lbEeH3mRJkM/TfVFdVflFwt0XIj9OjGEeQ6lkDdW7g3QLYrGMfdmVbgla9o/eFPCHzuMgJQbOujyxPmDwycJUYezZiIoFPbTPRqiYWiv0A+6A/P2Wqv5JAdA/JYq6k83UReoWCNTowAQ1VijtGwcgIgYsscv8ngNn2ZWbFKXfTrl+he8pRXPD9DXrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LbBcp8B+/Sn0jziT5hc2amOpZmSK5V3jlPqrQF2ZsC4=;
 b=mf3LZHqKIAUnFplAYMAuYYYfszMf2Uc3vP0gadUYGUhugrNWO4u0844JDCgyvNdu3x8pgkgO7K4PogfXqOYOk15R5ljKoVW0oaSitmgLdtS/MHkxVHMMsG/oGr5FeZ+eOWVyLh84N5b8N+cI9gR4K2gEnDRy1H2yimYTr7h22HVMTSplgCnh5gtcJda7HmAMW0dm/t0Uy4hPhQrbU0Jg4RXpBKiEo5WG054ryCQ8RMY8Yb1xHqwnXHlOTC7/hK5dp4Z6sFU6zRptkfyDTcutG2XnmPFrHHe7yjByiWDxBcQTmry6FFmhgcuGDvknp6HA4XRgmMDpOMpBZZw1OPzxUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 BY5PR12MB4132.namprd12.prod.outlook.com (2603:10b6:a03:209::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Fri, 10 Jan
 2025 06:01:23 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%7]) with mapi id 15.20.8335.011; Fri, 10 Jan 2025
 06:01:23 +0000
From: Alistair Popple <apopple@nvidia.com>
To: akpm@linux-foundation.org,
	dan.j.williams@intel.com,
	linux-mm@kvack.org
Cc: alison.schofield@intel.com,
	Alistair Popple <apopple@nvidia.com>,
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
	loongarch@lists.linux.dev,
	Vivek Goyal <vgoyal@redhat.com>
Subject: [PATCH v6 01/26] fuse: Fix dax truncate/punch_hole fault path
Date: Fri, 10 Jan 2025 17:00:29 +1100
Message-ID: <bfae590045c7fc37b7ccef10b9cec318012979fd.1736488799.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.11189864684e31260d1408779fac9db80122047b.1736488799.git-series.apopple@nvidia.com>
References: <cover.11189864684e31260d1408779fac9db80122047b.1736488799.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY6PR01CA0102.ausprd01.prod.outlook.com
 (2603:10c6:10:111::17) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|BY5PR12MB4132:EE_
X-MS-Office365-Filtering-Correlation-Id: 7415fded-2293-4465-edb8-08dd313c35ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iUiea6TcIoFaGltYHqp4MCOBxiDcafpaNHe3Va/E4WoJj2inejH6vzjtX+Od?=
 =?us-ascii?Q?shioydj0ySbzw2THNGM6Buf6C4HaudO9wLKjFGqVU19NXoQkr5hs7/8AYFvd?=
 =?us-ascii?Q?wULm9GNCK+KaqKZWhPT2zgpwm5xIyyEVxgL9sdPrqOwGUQ8xkcHGXj2qd5iE?=
 =?us-ascii?Q?9Oreal2H4alhTMzWo0ZvrWDESqMwUxEYVStyXK2hbM+6LxwOBZcuH5xKPrVF?=
 =?us-ascii?Q?fL6n8DWf/G5VJ2pOnzpOOsYsylGMnRLgeCol2ALKN8lB2LD/MI0KzELLvId9?=
 =?us-ascii?Q?YD8G9mypE/2DrA/dfKMT5ORSo9Ie9ojxRRPuZpfud7Qd9LyuEthq+AI2u/oo?=
 =?us-ascii?Q?NDYnSUexgyCtPpDnM8xe8GfY8jKX/nFl79dvWepJ5KOt8qc8IfX2vpHLfWlV?=
 =?us-ascii?Q?N81DvodEZ8blgSYILgv+z6UtxxEUs1+veBlyT6CUrJE1dyD6ZNuVqcJNLbIr?=
 =?us-ascii?Q?2Otei3fAwuYfN6jP8CmHOj9pcok48FSxJWfVcF3Ln9yVF4KjBq6xCBaQPmR5?=
 =?us-ascii?Q?xWvJEPu+ehbalBJBLpxWV3doq9ZdsRnArfbQel42/+0ZoIDYqommf9fkHDpR?=
 =?us-ascii?Q?8FQPU4/zCA8b7zRo3N98tuVcwLedOrBoEzZVw5K4r2KXOOLf9IzOaFnjnp4K?=
 =?us-ascii?Q?lDaHdwmufiZesdEtWJJ6fLe7cZ1KWJCtoghVo9QTKVZx4yBWiue4FN8oO9yF?=
 =?us-ascii?Q?JR01Nsz0GEVw7PtDaeLAEaXLTYpS0Lg2hZuKfUuKvJ6ZEAuTqYWdykZcuiEs?=
 =?us-ascii?Q?ccT5Wj8HDKuKq5ogqKA3U79V5S4uulqgpeWGI/SYzA3N3oqWbmB8+0klectq?=
 =?us-ascii?Q?e4YIypwkXtkWcTEinyGA8IBwPeG6J1uo01V8NjxB6aQQ91szyuJjdhViC1SD?=
 =?us-ascii?Q?mpM2ZdCKbwumfQEjoumejpTotawicXeiwnLY1ioHKqRwhnLC8NS4BFOHOViu?=
 =?us-ascii?Q?U9p4E37PhFRQsbB5W3Rvm8amvBIufqYK29GnNfCqQR2P5miCDfWIajiLfFIu?=
 =?us-ascii?Q?nWmQekqLvnPXDRUjiEv7FhNdFPSp/2lUrHBkjljiWRt1DLTlDLWg+TXuYVrP?=
 =?us-ascii?Q?89MGhRk/N47kjFsTIKxfF9Uj+zLpgqLQkSxwcsBtJE53Udw1FYpw95WF8xLL?=
 =?us-ascii?Q?xfBFSrdLIN+al2IGgPDR0A9GRSe/5IBZibfKpNYO8skpvVdlsP6+eMLBKwBe?=
 =?us-ascii?Q?V0EO1l55GwX8iXBbOHUiataVQ094e5JWhIi9t07Ni9figZ+FsWipZ8uaZaCL?=
 =?us-ascii?Q?LvWziuQEL8/aeLB5b1Tu59nk3JZ2Jdu6nTwcUX+qoO6hnxIAJYk5aceJ7ILZ?=
 =?us-ascii?Q?97cw6fZ/1N2NyX+MW+CngLIDoLF7R3+u0k0uZ0a+B1+IzYahQg9altLFJrAW?=
 =?us-ascii?Q?BQEqc3QITago+C4aGBZG/RZgqh7M?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?q3WholDKedmVRDQSIdDEqbsTSX+QtxlNOzU8klTKMUAoO8pcfltOLqWeBycu?=
 =?us-ascii?Q?K86n69nSLq0Y+oaIy4tSYoO4opXy0nNhtwpycVXqJCzHL1XO6WuYfp9ODXme?=
 =?us-ascii?Q?oVuurBlx2A90d98TxlGWCkRNWTnW+ycSr0UYBdhRwnl7g1XQdQB2CQL3bvwv?=
 =?us-ascii?Q?ly4HNzRCSFasFMaWMMBPilYPTJFqNcyhum/MAvkehnhAAftxTk6QJCuE7CG3?=
 =?us-ascii?Q?BRqc6/vsaVGeZtIZ/nyhdm4UOC61xjbkP52/XOopAsBfQSPI1WPXmWaDNSRB?=
 =?us-ascii?Q?51jWrHzS6wljLHGtLGUgxgT6Gqm0c7SHG5YdCorgWdxcz6o4cND9X1clAIeY?=
 =?us-ascii?Q?lAeXYWrgxBDITrWKvv/eLlwuaVSDfFLTum4j5pXJJnYrr1w2hPKvPiI76XAo?=
 =?us-ascii?Q?Cy7JjCbIqYAhNsp3y8Ov8rcpNDx0QnffAlI6jkii04PcJblgmDO/hyEZnf8X?=
 =?us-ascii?Q?9fURHtsYR3XexbCynYVGfcYYA/jBw6IxvO+lNaMzwmkcPlPL//nTBMnDM8fj?=
 =?us-ascii?Q?vDJOQUPhBScVurKsa0xZmXjOueeiaxWPVnBbb4UII6H161mhX5zXPzYBRi3s?=
 =?us-ascii?Q?hCJw/IssRLg9SP1tOmBs1Ub+hSA7IJksaXZj2Je8S35WkTQvgXP17OeTPbch?=
 =?us-ascii?Q?AffrUBEB6SRz65aO7vdRJh+uQA0aHTzHVG4REVDxzNBO9fPZTsZUIi7TQAlH?=
 =?us-ascii?Q?0LV8+6BDlfmI04adpTBHVFH9NJu7voSz/TWgg9GzmN9e+SjzEq5s1wi4uzfC?=
 =?us-ascii?Q?BJvEAlRn2BrgQ45EFTPhVv4bIkr2S2gGBiYerkW0UNBxVM0zfbXPuuaSjV8z?=
 =?us-ascii?Q?SaAhNUf7W+9lzam1bK+MODQQzFTT+UiMSjYzARzFiaX1mFRwj+6NMsIRB7+D?=
 =?us-ascii?Q?1wGLlWoyr7Gewr1oHm2dA9c/duqPTe4Xm1IToMfd+2BfpQH2QTTPiK0VatU3?=
 =?us-ascii?Q?Dwip/reM2T83BpfKQDrJD8gscDtTOGEX0msymHD1N2CeMXCLjV/8iPskUMl/?=
 =?us-ascii?Q?JUAptQRJxJquwUUb773SNnGRW4+kEGXqwMiPiRXJVeleWMODA2W7umMN6EJQ?=
 =?us-ascii?Q?vVpglYfQTvW5uGNk9JApiS3RbIA/l7ZZmXlCs8REcspHQ0y6PellaXFH1tki?=
 =?us-ascii?Q?mPm6EYmN9UoNH8ogH3vVfpQUuNl39J1gY+ZBDKRl8Q+6zuLr7tbZZFnqmsT4?=
 =?us-ascii?Q?8QhZh+ZcNCGZMqp+FYrPQcWMKeMFncdiIvFjOj4nlZwDhVg3IDvFitbluFav?=
 =?us-ascii?Q?QMgcYoDfOAm8LhsO+c+6/AjqAtoW/TPx8rld0wiV88WFiaprEDUMBjz6YoGw?=
 =?us-ascii?Q?Hxrxza0+c4pmttmw7kqObyFzWaiZ9jKcmUs0D8xXPeo4lb/cWYw1LZeIqu7Z?=
 =?us-ascii?Q?ditXXGLcjhtZvYhyRzsuMIWjXcp5EPWf5a3WSZPE1aN+CtqqHy+q00MU7h7q?=
 =?us-ascii?Q?mDWuDu3ZuHCtC3VF1hjVbke1OitAv9m/xG7XKUFTuldkaRInZEI7YvqOKhDi?=
 =?us-ascii?Q?ziRnd1rtz100clKwX+crn8vl1FMzM7nlCQJ0BRanuAqvf/DVWQCzU0aqvlzO?=
 =?us-ascii?Q?1D/dG2hNVUkf2k0aG2uvA8BA2qjXlJe4AgiN7Fxl?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7415fded-2293-4465-edb8-08dd313c35ab
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 06:01:22.7610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: htroSdF/dxS3nzKIpqIjntV3q4KRTiTTAbDZsGM2Eik3FUjh4pHnShiH+zMQv3HN3QbULE+UgyXuEwMBIg5CQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4132

FS DAX requires file systems to call into the DAX layout prior to unlinking
inodes to ensure there is no ongoing DMA or other remote access to the
direct mapped page. The fuse file system implements
fuse_dax_break_layouts() to do this which includes a comment indicating
that passing dmap_end == 0 leads to unmapping of the whole file.

However this is not true - passing dmap_end == 0 will not unmap anything
before dmap_start, and further more dax_layout_busy_page_range() will not
scan any of the range to see if there maybe ongoing DMA access to the
range. Fix this by passing -1 for dmap_end to fuse_dax_break_layouts()
which will invalidate the entire file range to
dax_layout_busy_page_range().

Signed-off-by: Alistair Popple <apopple@nvidia.com>
Co-developed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Fixes: 6ae330cad6ef ("virtiofs: serialize truncate/punch_hole and dax fault path")
Cc: Vivek Goyal <vgoyal@redhat.com>

---

Changes for v6:

 - Original patch had a misplaced hunk due to a bad rebase.
 - Reworked fix based on Dan's comments.
---
 fs/fuse/dax.c  | 1 -
 fs/fuse/dir.c  | 2 +-
 fs/fuse/file.c | 4 ++--
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
index 9abbc2f..455c4a1 100644
--- a/fs/fuse/dax.c
+++ b/fs/fuse/dax.c
@@ -681,7 +681,6 @@ static int __fuse_dax_break_layouts(struct inode *inode, bool *retry,
 			0, 0, fuse_wait_dax_page(inode));
 }
 
-/* dmap_end == 0 leads to unmapping of whole file */
 int fuse_dax_break_layouts(struct inode *inode, u64 dmap_start,
 				  u64 dmap_end)
 {
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 0b2f856..bc6c893 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1936,7 +1936,7 @@ int fuse_do_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	if (FUSE_IS_DAX(inode) && is_truncate) {
 		filemap_invalidate_lock(mapping);
 		fault_blocked = true;
-		err = fuse_dax_break_layouts(inode, 0, 0);
+		err = fuse_dax_break_layouts(inode, 0, -1);
 		if (err) {
 			filemap_invalidate_unlock(mapping);
 			return err;
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 082ee37..cef7a8f 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -253,7 +253,7 @@ static int fuse_open(struct inode *inode, struct file *file)
 
 	if (dax_truncate) {
 		filemap_invalidate_lock(inode->i_mapping);
-		err = fuse_dax_break_layouts(inode, 0, 0);
+		err = fuse_dax_break_layouts(inode, 0, -1);
 		if (err)
 			goto out_inode_unlock;
 	}
@@ -2890,7 +2890,7 @@ static long fuse_file_fallocate(struct file *file, int mode, loff_t offset,
 	inode_lock(inode);
 	if (block_faults) {
 		filemap_invalidate_lock(inode->i_mapping);
-		err = fuse_dax_break_layouts(inode, 0, 0);
+		err = fuse_dax_break_layouts(inode, 0, -1);
 		if (err)
 			goto out;
 	}
-- 
git-series 0.9.1

