Return-Path: <linux-fsdevel+bounces-37595-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE43C9F428E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 06:25:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42628188A31E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 05:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4361F2C43;
	Tue, 17 Dec 2024 05:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="G8YwmN2Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A5517ADF7;
	Tue, 17 Dec 2024 05:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734412534; cv=fail; b=ArVO7VjG1MOebVXJjVp8gdcgnNqmrqQFK3OmnPCUV9HHWGLIzAdHPQnVTgVEyZS7xl1M7Thacz9+5nkkYJpMsOj9Y3rHjSnL05LvbFUdIRm/x3Sajb8F1QPGlOdf0I2UUc/ctcs1sEVnul7cQmlIp+cyfcGSTDs7P4hV2K2ayuE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734412534; c=relaxed/simple;
	bh=StwzfISJFB5qZend+V8Fd3c3YatPcNY7DarH49Bx1bw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DQrmDQGpxvxHf/uFXeHDLls8SEsO0Yl2V5sNeeE1pWrwYjXDbdQdetl1F/a9NIAj4qPpu67MbJJEFi2HjV8asNq4XFkOBbbUAnpilHKHZr30md++RlDXBznuQGG9UoxKdFgMjhGWDMkgxSjTB+fzDuaF4xG/wRMQs6VeQO6/5TY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=G8YwmN2Q; arc=fail smtp.client-ip=40.107.93.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OXigU7STV2HhLK1KlwW85P8I3bdxgfl1l7dTLngHsfQtVi4Cd8lKN6apZReGhiyCojY/J9ai756lMKMq16z5v+TGoOAhnb5zlTswVkvmjxXpZkDQMA1seWfaV9NxUMXiRGqbMr2ex/o9gLWNpW2DVm31sx3b8KwK3s9L/KXqGpsK89dAL2vqGahoEcq+07ZWWg9HS+eX+mtK2W240h09fSokk+7oU44lfe6B7nLc986gtZoG1zI/I0qJy+gcT7pHIKgEzhjn5p/rx0fmP3/LXj+qqLlpFwlf7mqVFyMvTw6xvQ7uBrn2txccFMt0sA1Djbu0Gc4lkl862Pz13bBbMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J0XEfmRDPrkhjRLYogWmO4CnmKQB6Q2UKlPdfjQj148=;
 b=eTqV0cGwHXzDNa7le7Z2cy1nyChiLas9M26I4FcIGynoUfFUx6bKIEEAArLUciGw+uPwxHJvGNlz5TAAEgOvmE1rVs9PtI3MkWeQMMX7usGAyMjFpbdYB8wfOhHAYOtRkUgcXKqbisFsEPXkFMHbrkRobfjTil+oqkAQ30bIBcwalF5WyzuoMkw6R5W87IUgvx4xLCQDqOk2Vz1PJzxm5JAtgxOJMPjp8WE8Sk/XxOjrWcaA5ztpkKifY3JLKHcAI9LZoIQ0VlNC2LvoGYc/Bcs/D6u6z4ztrhBrkf+HODRq/sNyDsFcObkr+ZtseN1qShMlZLXCJMYpiIlkU/K7XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J0XEfmRDPrkhjRLYogWmO4CnmKQB6Q2UKlPdfjQj148=;
 b=G8YwmN2QhDRpjXg1GZdouT//DFfCtPn9WhXkixxbXfhZU11+S86S+aBG6CygeyX+cCcreRKaL6ma88urxglC/Slq23OvvDpipuAFCjcD+YaU5SEEHnFwbV++VGCvstWG5mogo3eOlk7EN81GipfoyGresUjobf9RsMDt9XiA/tuODCgKnwUpyrBPeWAOKRHxOuI8sPcvVhaQsmz75+hChgyhC6FEIX+n3mf+PhpW6K3zxq1d+z2fVLDtFDBQVOisVfvFqZqmcMuU86rHhcs4pfwGOrqx/jtju3q+CsWUy0GRJybHj8Jr1J6R2LWGWrhuL8lF9DnPcgxtr0ohUJy0aQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 DM6PR12MB4388.namprd12.prod.outlook.com (2603:10b6:5:2a9::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.22; Tue, 17 Dec 2024 05:15:26 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%4]) with mapi id 15.20.8251.015; Tue, 17 Dec 2024
 05:15:26 +0000
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
Subject: [PATCH v4 21/25] fs/dax: Properly refcount fs dax pages
Date: Tue, 17 Dec 2024 16:13:04 +1100
Message-ID: <cf03be2d827737240c10de615023ff913870bec6.1734407924.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.18cbcff3638c6aacc051c44533ebc6c002bf2bd9.1734407924.git-series.apopple@nvidia.com>
References: <cover.18cbcff3638c6aacc051c44533ebc6c002bf2bd9.1734407924.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5P300CA0030.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:1ff::20) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|DM6PR12MB4388:EE_
X-MS-Office365-Filtering-Correlation-Id: 06f590c0-42bc-4940-115a-08dd1e59d109
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GVaOZon70bOggLpfAdMLdy2hfw7W0pFyloUbDs4LuSyjSroubhSEubxkdr4A?=
 =?us-ascii?Q?xqEgAZwaFA4bN2xobgIu1s0ZQOuG8x6J6tsgi4dO4hldmxWxiBF1E7KZohyb?=
 =?us-ascii?Q?5LUYLX9zaRFtp0/ceBORTxuPCY05kN9wk4XNEXB1+sLUUnVUZXsXT2Y4gPMk?=
 =?us-ascii?Q?Djc8vXZw+uVH34TSJ3Bl/Qp0a4twNmHHPov7cmcKbvj7MebR0MIqBFnFy2K4?=
 =?us-ascii?Q?cqY4hAxiENXg7YDnNFZMfb7yxUNVCZRRs56Tj9reMbs2U3FL/TrEq0HgQkAV?=
 =?us-ascii?Q?0JYcvle5zq8aibiR2IoR7UCflUyCtqIRU1NiHSwZtFZvFx0HD9aa0yi0AzSM?=
 =?us-ascii?Q?L+6J4hIuwoipMoUwI9FyctBVkdDx+GbGaNTWEDGcOM+i8odVhMXwxZn4bpog?=
 =?us-ascii?Q?NBTIFEj9oGTqV7kX6VTEt/aDMWRwbOOrkHRMJTjjVpYMBqltVA22GvNVnh9u?=
 =?us-ascii?Q?CZn1kwaGgSgKGcX6gauQMMGWb+ZZXBjQolcflQo4O20pjiUsEGBNE91tunow?=
 =?us-ascii?Q?2622cBqRCrWQFq/ncMiccArUthot35HFnOxbFNmcqzYDi9cuqE+hq08qCXq6?=
 =?us-ascii?Q?dUKKkAo+xoPaerywaT55hvVxIGzAMEdmBYsnVVvxy+8La3+HOJJVmoV/OuaC?=
 =?us-ascii?Q?I8mb57rGSJGfQD8y9lyaIUdP4jYRwmKzLeKsXydDd4wUAGKvo/uAlx1sPqey?=
 =?us-ascii?Q?u5RdbJoIebRSRHTiqRBzQ8dgpqtas773DFyPHbtZx6BYo2ZqxqNZ4dN4oIvg?=
 =?us-ascii?Q?TJAHIj6SGyzcvutsf95ppfJG6RHN38YDNy3tRlpNUgjmgP5KRQ7sDtC6VSOW?=
 =?us-ascii?Q?vwh0SEci2DQLzx+qXUcVxqQyRRDLIo6fBY796QTQBay50nInyVwRdhW3wVC4?=
 =?us-ascii?Q?FZTVQ5leUEA7L7+WVr24dnJqRC6Mo48D8kZGWvXt1DYpJGdZ8HnUJML0T+0b?=
 =?us-ascii?Q?kO08GIfc0sBj13MDxYcCceOPA0BDhD5K34Me1Ewyz8mwiY8wP3UfNE1iDO85?=
 =?us-ascii?Q?GNFYS2oe7Zdka3KmDfVDduDmVAPAu+BkNEqxYFePOwS4rkZVFxx6+H2llL9h?=
 =?us-ascii?Q?DVoslFyNVUpdb7LOmpc/qe8A7MAQzetlOb4TPnNPPurRkqXAgLYWlViCsjAd?=
 =?us-ascii?Q?FMAmgI3Tg2JfHX73vDwv6x4bPshsfkbtP1XorR8FvM+0nuogr5wZPEJU4wG0?=
 =?us-ascii?Q?gmNlef5n7d9br8hk32dpuaUJbj0o8Lntuyb6t6MeNglYavCa11+8kvLvf06S?=
 =?us-ascii?Q?+6OCE46rsVeUSG/3ZB8ApXxFFdMu2+blq/vT/5eJuZSlOuzilHH2kRv1n115?=
 =?us-ascii?Q?8QGp30JF0/r1cgf2bDml2dahPFu6bDFPTubIX4MbekeJzdo6Hw5B1ixp32nk?=
 =?us-ascii?Q?SvYJqGi3zpqaCKpH4LR/Dy52WZC4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZFOE09+yDbFgMPBlq/L8FD/HZR2rbvWumEdEvXIVbqXLcOBoqlc221RE5yyN?=
 =?us-ascii?Q?gJhctx6wAnvJVsXAv+JqS0wJRu8JanLk7OkXgkaMecCMlGcrXoNxgkPV70dx?=
 =?us-ascii?Q?NcTl135GwE5x4CA7Msv5y+mAveLWF5b2ZZYlxhUNEEbcFlrv/PN0h4lJKwO2?=
 =?us-ascii?Q?mtTTyl89c58qtqRyjS/D7Io1zP5jv3lKUlV1WwmkaF/xLLFCmNMkP6nJfFrc?=
 =?us-ascii?Q?/iwwN5ain3eTkKBBvX6J7UdTrbnjUkBaPVbOl8mH94ZaQPDTInSAVFO0xiqU?=
 =?us-ascii?Q?vQj8QqgxOTq1b531GSOQQMavnlygcLL5HrDGxHwUYVb0XA1cWUGd4pfwaWhM?=
 =?us-ascii?Q?zqYQ9LwHbPlo6fF2fZFlyhmmphW2WLOiMl2C6BiT9ZWOSVixVlgS08U33cw1?=
 =?us-ascii?Q?tCEIFgHj/zUAjIv/RmP0mgAHv6PjeZUTm9l/EK8Ex46buCLKiGW/QJz5NyWZ?=
 =?us-ascii?Q?sXGtAQCh35fmX1W6fAnFX7dCb47DPnE0PYa/qOPjUK93t3S/9gpl/zFW4IoL?=
 =?us-ascii?Q?/wpm65IONrUk7aNthWUWZtClXmdy87EjTDZzyWwmGUEMHSiM6nbOG5OBluCt?=
 =?us-ascii?Q?JrqDM1kDhO3Y4tUGym675HlVDOYC+li0pjkuEgK1mGn/ZoSHPKbgcFrKBQhu?=
 =?us-ascii?Q?xUuxyCmWWXutYXn4Lm58Y5ziCJXZlkzCLztb/7UulBzNAJ5bfHlNtr0gRsbj?=
 =?us-ascii?Q?E8jzWkh33DFuOUrDEyKAelitB/jZHCbEEsy0fg7D+xXoNh6apr+0ANj0fZkG?=
 =?us-ascii?Q?BG/ESkUAyhKyvpOy77MitCkqtkRK/fzE/Wt+i7pSyQ4TGKGoXNfXtlGTzPyG?=
 =?us-ascii?Q?s3te0nOwgk90Wz2G5fooORavN7sxy1uTYH6PIImjRLBY/GCztOyEppAT3ZLZ?=
 =?us-ascii?Q?DBEDAL6IjdwlXw7vyrbwQqMKi9yHVuvTVM+Koc9P7H9App7IExsvUp6YHUQo?=
 =?us-ascii?Q?6B+SBZDxH9XykLAPdXnOuHy493a/UKhcJ5EhmCeU55u2sp1om2yhCzC1mnbQ?=
 =?us-ascii?Q?VIix0d7fnjPiD/tNqG7lfyzaQtgLM6k9MCrjNwdcMjtn9txDd2FWOWhKFr+3?=
 =?us-ascii?Q?7VrcfScj64aIZBVCSxm3VuL9DZcubtmorbn/uTqxxA3ZiSnSgldlt6zdZC7w?=
 =?us-ascii?Q?A4FPf/p96YOUo0DU/8FZ4CjJeux6wJmstK6hPxhthmRJri5FJ9u/ny1CrQpw?=
 =?us-ascii?Q?S5nbT2LMbYWytnfAhE3OFEE311SQOc6JdD9Sgulbnf96EE5tTw4yOlwXWLWG?=
 =?us-ascii?Q?lj7oXdQW7qrdFUwzq0sJmAtzgfCI2ijiTxzDusS3LA2iwFbvChZ24q9TsVDs?=
 =?us-ascii?Q?RHFJQEdZlSgy/JbvofBtnIDmMfMWUD/QPfxhD7wvP2h2LHWGW2V2lCo1M1wV?=
 =?us-ascii?Q?yg4y3xWONR1Udi57l7vuGJXe51fyswMXK8NiDdP0S+FvQvJz+3kld+9hIsBp?=
 =?us-ascii?Q?DDBCeaZQ/l4Q+Xus0rHeEHyV3IDyOh9ItIPXnFDcUuhQFQo/C+Qh+3g2TlxJ?=
 =?us-ascii?Q?IP/1RAClGr3iaBGW5WbUryeyrE0erzSeJclxSsXKL+mj/XzlQb1uPvhs1OgP?=
 =?us-ascii?Q?HNwivzEkuXMts+jLfPtaaOjMm9xs0PKhDgCGdYeg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06f590c0-42bc-4940-115a-08dd1e59d109
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 05:15:26.7303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a5/+KaUO5UmSN1+ECHDUSl17wW+0SBPBIAQJzqprPBxRyfwisUIIu2++pUaz5QMJ1QZM/LADOpKQhoCWw+RdQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4388

Currently fs dax pages are considered free when the refcount drops to
one and their refcounts are not increased when mapped via PTEs or
decreased when unmapped. This requires special logic in mm paths to
detect that these pages should not be properly refcounted, and to
detect when the refcount drops to one instead of zero.

On the other hand get_user_pages(), etc. will properly refcount fs dax
pages by taking a reference and dropping it when the page is
unpinned.

Tracking this special behaviour requires extra PTE bits
(eg. pte_devmap) and introduces rules that are potentially confusing
and specific to FS DAX pages. To fix this, and to possibly allow
removal of the special PTE bits in future, convert the fs dax page
refcounts to be zero based and instead take a reference on the page
each time it is mapped as is currently the case for normal pages.

This may also allow a future clean-up to remove the pgmap refcounting
that is currently done in mm/gup.c.

Signed-off-by: Alistair Popple <apopple@nvidia.com>

---

Changes since v2:

Based on some questions from Dan I attempted to have the FS DAX page
cache (ie. address space) hold a reference to the folio whilst it was
mapped. However I came to the strong conclusion that this was not the
right thing to do.

If the page refcount == 0 it means the page is:

1. not mapped into user-space
2. not subject to other access via DMA/GUP/etc.

Ie. From the core MM perspective the page is not in use.

The fact a page may or may not be present in one or more address space
mappings is irrelevant for core MM. It just means the page is still in
use or valid from the file system perspective, and it's a
responsiblity of the file system to remove these mappings if the pfn
mapping becomes invalid (along with first making sure the MM state,
ie. page->refcount, is idle). So we shouldn't be trying to track that
lifetime with MM refcounts.

Doing so just makes DMA-idle tracking more complex because there is
now another thing (one or more address spaces) which can hold
references on a page. And FS DAX can't even keep track of all the
address spaces which might contain a reference to the page in the
XFS/reflink case anyway.

We could do this if we made file systems invalidate all address space
mappings prior to calling dax_break_layouts(), but that isn't
currently neccessary and would lead to increased faults just so we
could do some superfluous refcounting which the file system already
does.

I have however put the page sharing checks and WARN_ON's back which
also turned out to be useful for figuring out when to re-initialising
a folio.
---
 drivers/nvdimm/pmem.c    |   4 +-
 fs/dax.c                 | 212 +++++++++++++++++++++++-----------------
 fs/fuse/virtio_fs.c      |   3 +-
 fs/xfs/xfs_inode.c       |   2 +-
 include/linux/dax.h      |   6 +-
 include/linux/mm.h       |  27 +-----
 include/linux/mm_types.h |   5 +-
 mm/gup.c                 |   9 +--
 mm/huge_memory.c         |   6 +-
 mm/internal.h            |   2 +-
 mm/memory-failure.c      |   6 +-
 mm/memory.c              |   6 +-
 mm/memremap.c            |  47 ++++-----
 mm/mm_init.c             |   9 +--
 mm/swap.c                |   2 +-
 15 files changed, 181 insertions(+), 165 deletions(-)

diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index d81faa9..785b2d2 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -513,7 +513,7 @@ static int pmem_attach_disk(struct device *dev,
 
 	pmem->disk = disk;
 	pmem->pgmap.owner = pmem;
-	pmem->pfn_flags = PFN_DEV;
+	pmem->pfn_flags = 0;
 	if (is_nd_pfn(dev)) {
 		pmem->pgmap.type = MEMORY_DEVICE_FS_DAX;
 		pmem->pgmap.ops = &fsdax_pagemap_ops;
@@ -522,7 +522,6 @@ static int pmem_attach_disk(struct device *dev,
 		pmem->data_offset = le64_to_cpu(pfn_sb->dataoff);
 		pmem->pfn_pad = resource_size(res) -
 			range_len(&pmem->pgmap.range);
-		pmem->pfn_flags |= PFN_MAP;
 		bb_range = pmem->pgmap.range;
 		bb_range.start += pmem->data_offset;
 	} else if (pmem_should_map_pages(dev)) {
@@ -532,7 +531,6 @@ static int pmem_attach_disk(struct device *dev,
 		pmem->pgmap.type = MEMORY_DEVICE_FS_DAX;
 		pmem->pgmap.ops = &fsdax_pagemap_ops;
 		addr = devm_memremap_pages(dev, &pmem->pgmap);
-		pmem->pfn_flags |= PFN_MAP;
 		bb_range = pmem->pgmap.range;
 	} else {
 		addr = devm_memremap(dev, pmem->phys_addr,
diff --git a/fs/dax.c b/fs/dax.c
index 6f2d1de..139891f 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -71,6 +71,11 @@ static unsigned long dax_to_pfn(void *entry)
 	return xa_to_value(entry) >> DAX_SHIFT;
 }
 
+static struct folio *dax_to_folio(void *entry)
+{
+	return page_folio(pfn_to_page(dax_to_pfn(entry)));
+}
+
 static void *dax_make_entry(pfn_t pfn, unsigned long flags)
 {
 	return xa_mk_value(flags | (pfn_t_to_pfn(pfn) << DAX_SHIFT));
@@ -338,44 +343,88 @@ static unsigned long dax_entry_size(void *entry)
 		return PAGE_SIZE;
 }
 
-static unsigned long dax_end_pfn(void *entry)
-{
-	return dax_to_pfn(entry) + dax_entry_size(entry) / PAGE_SIZE;
-}
-
-/*
- * Iterate through all mapped pfns represented by an entry, i.e. skip
- * 'empty' and 'zero' entries.
- */
-#define for_each_mapped_pfn(entry, pfn) \
-	for (pfn = dax_to_pfn(entry); \
-			pfn < dax_end_pfn(entry); pfn++)
-
 /*
  * A DAX page is considered shared if it has no mapping set and ->share (which
  * shares the ->index field) is non-zero. Note this may return false even if the
  * page if shared between multiple files but has not yet actually been mapped
  * into multiple address spaces.
  */
-static inline bool dax_page_is_shared(struct page *page)
+static inline bool dax_folio_is_shared(struct folio *folio)
 {
-	return !page->mapping && page->share;
+	return !folio->mapping && folio->share;
 }
 
 /*
- * Increase the page share refcount, warning if the page is not marked as shared.
+ * Increase the folio share refcount, warning if the folio is not marked as shared.
  */
-static inline void dax_page_share_get(struct page *page)
+static inline void dax_folio_share_get(void *entry)
 {
-	WARN_ON_ONCE(!page->share);
-	WARN_ON_ONCE(page->mapping);
-	page->share++;
+	struct folio *folio = dax_to_folio(entry);
+
+	WARN_ON_ONCE(!folio->share);
+	WARN_ON_ONCE(folio->mapping);
+	WARN_ON_ONCE(dax_entry_order(entry) != folio_order(folio));
+	folio->share++;
+}
+
+static inline unsigned long dax_folio_share_put(struct folio *folio)
+{
+	unsigned long ref;
+
+	if (!dax_folio_is_shared(folio))
+		ref = 0;
+	else
+		ref = --folio->share;
+
+	WARN_ON_ONCE(ref < 0);
+	if (!ref) {
+		folio->mapping = NULL;
+		if (folio_order(folio)) {
+			struct dev_pagemap *pgmap = page_pgmap(&folio->page);
+			unsigned int order = folio_order(folio);
+			unsigned int i;
+
+			for (i = 0; i < (1UL << order); i++) {
+				struct page *page = folio_page(folio, i);
+
+				ClearPageHead(page);
+				clear_compound_head(page);
+
+				/*
+				 * Reset pgmap which was over-written by
+				 * prep_compound_page().
+				 */
+				page_folio(page)->pgmap = pgmap;
+
+				/* Make sure this isn't set to TAIL_MAPPING */
+				page->mapping = NULL;
+				page->share = 0;
+				WARN_ON_ONCE(page_ref_count(page));
+			}
+		}
+	}
+
+	return ref;
 }
 
-static inline unsigned long dax_page_share_put(struct page *page)
+static void dax_device_folio_init(void *entry)
 {
-	WARN_ON_ONCE(!page->share);
-	return --page->share;
+	struct folio *folio = dax_to_folio(entry);
+	int order = dax_entry_order(entry);
+
+	/*
+	 * Folio should have been split back to order-0 pages in
+	 * dax_folio_share_put() when they were removed from their
+	 * final mapping.
+	 */
+	WARN_ON_ONCE(folio_order(folio));
+
+	if (order > 0) {
+		prep_compound_page(&folio->page, order);
+		if (order > 1)
+			INIT_LIST_HEAD(&folio->_deferred_list);
+		WARN_ON_ONCE(folio_ref_count(folio));
+	}
 }
 
 /*
@@ -388,72 +437,58 @@ static inline unsigned long dax_page_share_put(struct page *page)
  * dax_holder_operations.
  */
 static void dax_associate_entry(void *entry, struct address_space *mapping,
-		struct vm_area_struct *vma, unsigned long address, bool shared)
+				struct vm_area_struct *vma, unsigned long address, bool shared)
 {
-	unsigned long size = dax_entry_size(entry), pfn, index;
-	int i = 0;
+	unsigned long size = dax_entry_size(entry), index;
+	struct folio *folio = dax_to_folio(entry);
 
 	if (IS_ENABLED(CONFIG_FS_DAX_LIMITED))
 		return;
 
 	index = linear_page_index(vma, address & ~(size - 1));
-	for_each_mapped_pfn(entry, pfn) {
-		struct page *page = pfn_to_page(pfn);
-
-		if (shared && page->mapping && page->share) {
-			if (page->mapping) {
-				page->mapping = NULL;
+	if (shared && (folio->mapping || dax_folio_is_shared(folio))) {
+		if (folio->mapping) {
+			folio->mapping = NULL;
 
-				/*
-				 * Page has already been mapped into one address
-				 * space so set the share count.
-				 */
-				page->share = 1;
-			}
-
-			dax_page_share_get(page);
-		} else {
-			WARN_ON_ONCE(page->mapping);
-			page->mapping = mapping;
-			page->index = index + i++;
+			/*
+			 * folio has already been mapped into one address
+			 * space so set the share count.
+			 */
+			folio->share = 1;
 		}
+
+		dax_folio_share_get(entry);
+	} else {
+		WARN_ON_ONCE(folio->mapping);
+		dax_device_folio_init(entry);
+		folio = dax_to_folio(entry);
+		folio->mapping = mapping;
+		folio->index = index;
 	}
 }
 
 static void dax_disassociate_entry(void *entry, struct address_space *mapping,
-		bool trunc)
+				bool trunc)
 {
-	unsigned long pfn;
+	struct folio *folio = dax_to_folio(entry);
 
 	if (IS_ENABLED(CONFIG_FS_DAX_LIMITED))
 		return;
 
-	for_each_mapped_pfn(entry, pfn) {
-		struct page *page = pfn_to_page(pfn);
-
-		WARN_ON_ONCE(trunc && page_ref_count(page) > 1);
-		if (dax_page_is_shared(page)) {
-			/* keep the shared flag if this page is still shared */
-			if (dax_page_share_put(page) > 0)
-				continue;
-		} else
-			WARN_ON_ONCE(page->mapping && page->mapping != mapping);
-		page->mapping = NULL;
-		page->index = 0;
-	}
+	dax_folio_share_put(folio);
 }
 
 static struct page *dax_busy_page(void *entry)
 {
-	unsigned long pfn;
+	struct folio *folio = dax_to_folio(entry);
 
-	for_each_mapped_pfn(entry, pfn) {
-		struct page *page = pfn_to_page(pfn);
+	if (dax_is_zero_entry(entry) || dax_is_empty_entry(entry))
+		return NULL;
 
-		if (page_ref_count(page) > 1)
-			return page;
-	}
-	return NULL;
+	if (folio_ref_count(folio) - folio_mapcount(folio))
+		return &folio->page;
+	else
+		return NULL;
 }
 
 /**
@@ -786,7 +821,7 @@ struct page *dax_layout_busy_page(struct address_space *mapping)
 EXPORT_SYMBOL_GPL(dax_layout_busy_page);
 
 static int __dax_invalidate_entry(struct address_space *mapping,
-					  pgoff_t index, bool trunc)
+				  pgoff_t index, bool trunc)
 {
 	XA_STATE(xas, &mapping->i_pages, index);
 	int ret = 0;
@@ -892,7 +927,7 @@ static int wait_page_idle(struct page *page,
 			void (cb)(struct inode *),
 			struct inode *inode)
 {
-	return ___wait_var_event(page, page_ref_count(page) == 1,
+	return ___wait_var_event(page, page_ref_count(page) == 0,
 				TASK_INTERRUPTIBLE, 0, 0, cb(inode));
 }
 
@@ -900,7 +935,7 @@ static void wait_page_idle_uninterruptible(struct page *page,
 					void (cb)(struct inode *),
 					struct inode *inode)
 {
-	___wait_var_event(page, page_ref_count(page) == 1,
+	___wait_var_event(page, page_ref_count(page) == 0,
 			TASK_UNINTERRUPTIBLE, 0, 0, cb(inode));
 }
 
@@ -943,7 +978,8 @@ void dax_break_mapping_uninterruptible(struct inode *inode,
 		wait_page_idle_uninterruptible(page, cb, inode);
 	} while (true);
 
-	dax_delete_mapping_range(inode->i_mapping, 0, LLONG_MAX);
+	if (!page)
+		dax_delete_mapping_range(inode->i_mapping, 0, LLONG_MAX);
 }
 EXPORT_SYMBOL_GPL(dax_break_mapping_uninterruptible);
 
@@ -1029,8 +1065,10 @@ static void *dax_insert_entry(struct xa_state *xas, struct vm_fault *vmf,
 		void *old;
 
 		dax_disassociate_entry(entry, mapping, false);
-		dax_associate_entry(new_entry, mapping, vmf->vma, vmf->address,
-				shared);
+		if (!(flags & DAX_ZERO_PAGE))
+			dax_associate_entry(new_entry, mapping, vmf->vma, vmf->address,
+						shared);
+
 		/*
 		 * Only swap our new entry into the page cache if the current
 		 * entry is a zero page or an empty entry.  If a normal PTE or
@@ -1218,9 +1256,7 @@ static int dax_iomap_direct_access(const struct iomap *iomap, loff_t pos,
 		goto out;
 	if (pfn_t_to_pfn(*pfnp) & (PHYS_PFN(size)-1))
 		goto out;
-	/* For larger pages we need devmap */
-	if (length > 1 && !pfn_t_devmap(*pfnp))
-		goto out;
+
 	rc = 0;
 
 out_check_addr:
@@ -1327,7 +1363,7 @@ static vm_fault_t dax_load_hole(struct xa_state *xas, struct vm_fault *vmf,
 
 	*entry = dax_insert_entry(xas, vmf, iter, *entry, pfn, DAX_ZERO_PAGE);
 
-	ret = vmf_insert_mixed(vmf->vma, vaddr, pfn);
+	ret = vmf_insert_page_mkwrite(vmf, pfn_t_to_page(pfn), false);
 	trace_dax_load_hole(inode, vmf, ret);
 	return ret;
 }
@@ -1798,7 +1834,8 @@ static vm_fault_t dax_fault_iter(struct vm_fault *vmf,
 	loff_t pos = (loff_t)xas->xa_index << PAGE_SHIFT;
 	bool write = iter->flags & IOMAP_WRITE;
 	unsigned long entry_flags = pmd ? DAX_PMD : 0;
-	int err = 0;
+	struct folio *folio;
+	int ret, err = 0;
 	pfn_t pfn;
 	void *kaddr;
 
@@ -1830,17 +1867,18 @@ static vm_fault_t dax_fault_iter(struct vm_fault *vmf,
 			return dax_fault_return(err);
 	}
 
+	folio = dax_to_folio(*entry);
 	if (dax_fault_is_synchronous(iter, vmf->vma))
 		return dax_fault_synchronous_pfnp(pfnp, pfn);
 
-	/* insert PMD pfn */
+	folio_ref_inc(folio);
 	if (pmd)
-		return vmf_insert_pfn_pmd(vmf, pfn, write);
+		ret = vmf_insert_folio_pmd(vmf, pfn_folio(pfn_t_to_pfn(pfn)), write);
+	else
+		ret = vmf_insert_page_mkwrite(vmf, pfn_t_to_page(pfn), write);
+	folio_put(folio);
 
-	/* insert PTE pfn */
-	if (write)
-		return vmf_insert_mixed_mkwrite(vmf->vma, vmf->address, pfn);
-	return vmf_insert_mixed(vmf->vma, vmf->address, pfn);
+	return ret;
 }
 
 static vm_fault_t dax_iomap_pte_fault(struct vm_fault *vmf, pfn_t *pfnp,
@@ -2079,6 +2117,7 @@ dax_insert_pfn_mkwrite(struct vm_fault *vmf, pfn_t pfn, unsigned int order)
 {
 	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
 	XA_STATE_ORDER(xas, &mapping->i_pages, vmf->pgoff, order);
+	struct folio *folio;
 	void *entry;
 	vm_fault_t ret;
 
@@ -2096,14 +2135,17 @@ dax_insert_pfn_mkwrite(struct vm_fault *vmf, pfn_t pfn, unsigned int order)
 	xas_set_mark(&xas, PAGECACHE_TAG_DIRTY);
 	dax_lock_entry(&xas, entry);
 	xas_unlock_irq(&xas);
+	folio = pfn_folio(pfn_t_to_pfn(pfn));
+	folio_ref_inc(folio);
 	if (order == 0)
-		ret = vmf_insert_mixed_mkwrite(vmf->vma, vmf->address, pfn);
+		ret = vmf_insert_page_mkwrite(vmf, &folio->page, true);
 #ifdef CONFIG_FS_DAX_PMD
 	else if (order == PMD_ORDER)
-		ret = vmf_insert_pfn_pmd(vmf, pfn, FAULT_FLAG_WRITE);
+		ret = vmf_insert_folio_pmd(vmf, folio, FAULT_FLAG_WRITE);
 #endif
 	else
 		ret = VM_FAULT_FALLBACK;
+	folio_put(folio);
 	dax_unlock_entry(&xas, entry);
 	trace_dax_insert_pfn_mkwrite(mapping->host, vmf, ret);
 	return ret;
diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 82afe78..2c7b24c 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -1017,8 +1017,7 @@ static long virtio_fs_direct_access(struct dax_device *dax_dev, pgoff_t pgoff,
 	if (kaddr)
 		*kaddr = fs->window_kaddr + offset;
 	if (pfn)
-		*pfn = phys_to_pfn_t(fs->window_phys_addr + offset,
-					PFN_DEV | PFN_MAP);
+		*pfn = phys_to_pfn_t(fs->window_phys_addr + offset, 0);
 	return nr_pages > max_nr_pages ? max_nr_pages : nr_pages;
 }
 
diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index c7ec5ab..7bfb4eb 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -2740,7 +2740,7 @@ xfs_mmaplock_two_inodes_and_break_dax_layout(
 	 * for this nested lock case.
 	 */
 	page = dax_layout_busy_page(VFS_I(ip2)->i_mapping);
-	if (page && page_ref_count(page) != 1) {
+	if (page && page_ref_count(page) != 0) {
 		xfs_iunlock(ip2, XFS_MMAPLOCK_EXCL);
 		xfs_iunlock(ip1, XFS_MMAPLOCK_EXCL);
 		goto again;
diff --git a/include/linux/dax.h b/include/linux/dax.h
index 7c3773f..dbefea1 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -211,8 +211,12 @@ static inline int dax_wait_page_idle(struct page *page,
 				void (cb)(struct inode *),
 				struct inode *inode)
 {
-	return ___wait_var_event(page, page_ref_count(page) == 1,
+	int ret;
+
+	ret = ___wait_var_event(page, !page_ref_count(page),
 				TASK_INTERRUPTIBLE, 0, 0, cb(inode));
+
+	return ret;
 }
 
 #if IS_ENABLED(CONFIG_DAX)
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 01edca9..a734278 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1161,6 +1161,8 @@ int vma_is_stack_for_current(struct vm_area_struct *vma);
 struct mmu_gather;
 struct inode;
 
+extern void prep_compound_page(struct page *page, unsigned int order);
+
 /*
  * compound_order() can be called without holding a reference, which means
  * that niceties like page_folio() don't work.  These callers should be
@@ -1482,25 +1484,6 @@ vm_fault_t finish_fault(struct vm_fault *vmf);
  *   back into memory.
  */
 
-#if defined(CONFIG_ZONE_DEVICE) && defined(CONFIG_FS_DAX)
-DECLARE_STATIC_KEY_FALSE(devmap_managed_key);
-
-bool __put_devmap_managed_folio_refs(struct folio *folio, int refs);
-static inline bool put_devmap_managed_folio_refs(struct folio *folio, int refs)
-{
-	if (!static_branch_unlikely(&devmap_managed_key))
-		return false;
-	if (!folio_is_zone_device(folio))
-		return false;
-	return __put_devmap_managed_folio_refs(folio, refs);
-}
-#else /* CONFIG_ZONE_DEVICE && CONFIG_FS_DAX */
-static inline bool put_devmap_managed_folio_refs(struct folio *folio, int refs)
-{
-	return false;
-}
-#endif /* CONFIG_ZONE_DEVICE && CONFIG_FS_DAX */
-
 /* 127: arbitrary random number, small enough to assemble well */
 #define folio_ref_zero_or_close_to_overflow(folio) \
 	((unsigned int) folio_ref_count(folio) + 127u <= 127u)
@@ -1615,12 +1598,6 @@ static inline void put_page(struct page *page)
 {
 	struct folio *folio = page_folio(page);
 
-	/*
-	 * For some devmap managed pages we need to catch refcount transition
-	 * from 2 to 1:
-	 */
-	if (put_devmap_managed_folio_refs(folio, 1))
-		return;
 	folio_put(folio);
 }
 
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 54b59b8..5ad6d3d 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -344,7 +344,10 @@ struct folio {
 				struct dev_pagemap *pgmap;
 			};
 			struct address_space *mapping;
-			pgoff_t index;
+			union {
+				pgoff_t index;
+				unsigned long share;
+			};
 			union {
 				void *private;
 				swp_entry_t swap;
diff --git a/mm/gup.c b/mm/gup.c
index 9b587b5..d6575ed 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -96,8 +96,7 @@ static inline struct folio *try_get_folio(struct page *page, int refs)
 	 * belongs to this folio.
 	 */
 	if (unlikely(page_folio(page) != folio)) {
-		if (!put_devmap_managed_folio_refs(folio, refs))
-			folio_put_refs(folio, refs);
+		folio_put_refs(folio, refs);
 		goto retry;
 	}
 
@@ -116,8 +115,7 @@ static void gup_put_folio(struct folio *folio, int refs, unsigned int flags)
 			refs *= GUP_PIN_COUNTING_BIAS;
 	}
 
-	if (!put_devmap_managed_folio_refs(folio, refs))
-		folio_put_refs(folio, refs);
+	folio_put_refs(folio, refs);
 }
 
 /**
@@ -565,8 +563,7 @@ static struct folio *try_grab_folio_fast(struct page *page, int refs,
 	 */
 	if (unlikely((flags & FOLL_LONGTERM) &&
 		     !folio_is_longterm_pinnable(folio))) {
-		if (!put_devmap_managed_folio_refs(folio, refs))
-			folio_put_refs(folio, refs);
+		folio_put_refs(folio, refs);
 		return NULL;
 	}
 
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 55293b0..44672d3 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2222,7 +2222,7 @@ int zap_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 						tlb->fullmm);
 	arch_check_zapped_pmd(vma, orig_pmd);
 	tlb_remove_pmd_tlb_entry(tlb, pmd, addr);
-	if (vma_is_special_huge(vma)) {
+	if (!vma_is_dax(vma) && vma_is_special_huge(vma)) {
 		if (arch_needs_pgtable_deposit())
 			zap_deposited_table(tlb->mm, pmd);
 		spin_unlock(ptl);
@@ -2866,13 +2866,15 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 		 */
 		if (arch_needs_pgtable_deposit())
 			zap_deposited_table(mm, pmd);
-		if (vma_is_special_huge(vma))
+		if (!vma_is_dax(vma) && vma_is_special_huge(vma))
 			return;
 		if (unlikely(is_pmd_migration_entry(old_pmd))) {
 			swp_entry_t entry;
 
 			entry = pmd_to_swp_entry(old_pmd);
 			folio = pfn_swap_entry_folio(entry);
+		} else if (is_huge_zero_pmd(old_pmd)) {
+			return;
 		} else {
 			page = pmd_page(old_pmd);
 			folio = page_folio(page);
diff --git a/mm/internal.h b/mm/internal.h
index 3922788..c4df0ad 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -733,8 +733,6 @@ static inline void prep_compound_tail(struct page *head, int tail_idx)
 	set_page_private(p, 0);
 }
 
-extern void prep_compound_page(struct page *page, unsigned int order);
-
 void post_alloc_hook(struct page *page, unsigned int order, gfp_t gfp_flags);
 extern bool free_pages_prepare(struct page *page, unsigned int order);
 
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index a7b8ccd..7838bf1 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -419,18 +419,18 @@ static unsigned long dev_pagemap_mapping_shift(struct vm_area_struct *vma,
 	pud = pud_offset(p4d, address);
 	if (!pud_present(*pud))
 		return 0;
-	if (pud_devmap(*pud))
+	if (pud_trans_huge(*pud))
 		return PUD_SHIFT;
 	pmd = pmd_offset(pud, address);
 	if (!pmd_present(*pmd))
 		return 0;
-	if (pmd_devmap(*pmd))
+	if (pmd_trans_huge(*pmd))
 		return PMD_SHIFT;
 	pte = pte_offset_map(pmd, address);
 	if (!pte)
 		return 0;
 	ptent = ptep_get(pte);
-	if (pte_present(ptent) && pte_devmap(ptent))
+	if (pte_present(ptent))
 		ret = PAGE_SHIFT;
 	pte_unmap(pte);
 	return ret;
diff --git a/mm/memory.c b/mm/memory.c
index 4f73454..fa0d7b8 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3851,13 +3851,15 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
 	if (vma->vm_flags & (VM_SHARED | VM_MAYSHARE)) {
 		/*
 		 * VM_MIXEDMAP !pfn_valid() case, or VM_SOFTDIRTY clear on a
-		 * VM_PFNMAP VMA.
+		 * VM_PFNMAP VMA. FS DAX also wants ops->pfn_mkwrite called.
 		 *
 		 * We should not cow pages in a shared writeable mapping.
 		 * Just mark the pages writable and/or call ops->pfn_mkwrite.
 		 */
-		if (!vmf->page)
+		if (!vmf->page || is_fsdax_page(vmf->page)) {
+			vmf->page = NULL;
 			return wp_pfn_shared(vmf);
+		}
 		return wp_page_shared(vmf, folio);
 	}
 
diff --git a/mm/memremap.c b/mm/memremap.c
index 68099af..9a8879b 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -458,8 +458,13 @@ EXPORT_SYMBOL_GPL(get_dev_pagemap);
 
 void free_zone_device_folio(struct folio *folio)
 {
-	if (WARN_ON_ONCE(!folio->pgmap->ops ||
-			!folio->pgmap->ops->page_free))
+	struct dev_pagemap *pgmap = folio->pgmap;
+
+	if (WARN_ON_ONCE(!pgmap->ops))
+		return;
+
+	if (WARN_ON_ONCE(pgmap->type != MEMORY_DEVICE_FS_DAX &&
+			 !pgmap->ops->page_free))
 		return;
 
 	mem_cgroup_uncharge(folio);
@@ -484,26 +489,36 @@ void free_zone_device_folio(struct folio *folio)
 	 * For other types of ZONE_DEVICE pages, migration is either
 	 * handled differently or not done at all, so there is no need
 	 * to clear folio->mapping.
+	 *
+	 * FS DAX pages clear the mapping when the folio->share count hits
+	 * zero which indicating the page has been removed from the file
+	 * system mapping.
 	 */
-	folio->mapping = NULL;
-	folio->pgmap->ops->page_free(folio_page(folio, 0));
+	if (pgmap->type != MEMORY_DEVICE_FS_DAX)
+		folio->mapping = NULL;
 
-	switch (folio->pgmap->type) {
+	switch (pgmap->type) {
 	case MEMORY_DEVICE_PRIVATE:
 	case MEMORY_DEVICE_COHERENT:
-		put_dev_pagemap(folio->pgmap);
+		pgmap->ops->page_free(folio_page(folio, 0));
+		put_dev_pagemap(pgmap);
 		break;
 
-	case MEMORY_DEVICE_FS_DAX:
 	case MEMORY_DEVICE_GENERIC:
 		/*
 		 * Reset the refcount to 1 to prepare for handing out the page
 		 * again.
 		 */
+		pgmap->ops->page_free(folio_page(folio, 0));
 		folio_set_count(folio, 1);
 		break;
 
+	case MEMORY_DEVICE_FS_DAX:
+		wake_up_var(&folio->page);
+		break;
+
 	case MEMORY_DEVICE_PCI_P2PDMA:
+		pgmap->ops->page_free(folio_page(folio, 0));
 		break;
 	}
 }
@@ -519,21 +534,3 @@ void zone_device_page_init(struct page *page)
 	lock_page(page);
 }
 EXPORT_SYMBOL_GPL(zone_device_page_init);
-
-#ifdef CONFIG_FS_DAX
-bool __put_devmap_managed_folio_refs(struct folio *folio, int refs)
-{
-	if (folio->pgmap->type != MEMORY_DEVICE_FS_DAX)
-		return false;
-
-	/*
-	 * fsdax page refcounts are 1-based, rather than 0-based: if
-	 * refcount is 1, then the page is free and the refcount is
-	 * stable because nobody holds a reference on the page.
-	 */
-	if (folio_ref_sub_return(folio, refs) == 1)
-		wake_up_var(&folio->_refcount);
-	return true;
-}
-EXPORT_SYMBOL(__put_devmap_managed_folio_refs);
-#endif /* CONFIG_FS_DAX */
diff --git a/mm/mm_init.c b/mm/mm_init.c
index cb73402..0c12b29 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1017,23 +1017,22 @@ static void __ref __init_zone_device_page(struct page *page, unsigned long pfn,
 	}
 
 	/*
-	 * ZONE_DEVICE pages other than MEMORY_TYPE_GENERIC and
-	 * MEMORY_TYPE_FS_DAX pages are released directly to the driver page
-	 * allocator which will set the page count to 1 when allocating the
-	 * page.
+	 * ZONE_DEVICE pages other than MEMORY_TYPE_GENERIC are released
+	 * directly to the driver page allocator which will set the page count
+	 * to 1 when allocating the page.
 	 *
 	 * MEMORY_TYPE_GENERIC and MEMORY_TYPE_FS_DAX pages automatically have
 	 * their refcount reset to one whenever they are freed (ie. after
 	 * their refcount drops to 0).
 	 */
 	switch (pgmap->type) {
+	case MEMORY_DEVICE_FS_DAX:
 	case MEMORY_DEVICE_PRIVATE:
 	case MEMORY_DEVICE_COHERENT:
 	case MEMORY_DEVICE_PCI_P2PDMA:
 		set_page_count(page, 0);
 		break;
 
-	case MEMORY_DEVICE_FS_DAX:
 	case MEMORY_DEVICE_GENERIC:
 		break;
 	}
diff --git a/mm/swap.c b/mm/swap.c
index 062c856..a587842 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -952,8 +952,6 @@ void folios_put_refs(struct folio_batch *folios, unsigned int *refs)
 				unlock_page_lruvec_irqrestore(lruvec, flags);
 				lruvec = NULL;
 			}
-			if (put_devmap_managed_folio_refs(folio, nr_refs))
-				continue;
 			if (folio_ref_sub_and_test(folio, nr_refs))
 				free_zone_device_folio(folio);
 			continue;
-- 
git-series 0.9.1

