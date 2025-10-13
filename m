Return-Path: <linux-fsdevel+bounces-63996-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B4ABD5795
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 19:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 430084C4AA0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 17:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBDF12C0F96;
	Mon, 13 Oct 2025 17:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XBQPkpl0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010012.outbound.protection.outlook.com [52.101.46.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CCA2C029D;
	Mon, 13 Oct 2025 17:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760375222; cv=fail; b=lzbpGidp532KkoQosw2C06dhT37XxY0uYKzPbLBdphvbxipp9zKTeaRL9cqTYhl/l+FPJKAH4330PAXHTXn9cOHQkJZWjYgdYbAfPWPAwkxzNiTStzKCg9BOe/XZa2nWr7Z4TEs6H/UEhhno+YZ1hgXPS1mSypRyGcobqb01S74=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760375222; c=relaxed/simple;
	bh=mhOstO5O5LAvhMuhQwBjG3twDMnsdgxSL48TfY9qx10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i/q7F+4fsze+oJihXEEihSZuf+52IdeJyrzc9lPSZcs14QRcBATKe8rfgOJxJalaWu28yrZYJtXrfQUrROCLv1MXY4SfbRK1D9yznW0SnARkgIOvpTdcPGYVMQdDBEU1e5+VCp5CVUSJVarmc5IArnRlm0VrHWD/+jE2C5OnLo0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XBQPkpl0; arc=fail smtp.client-ip=52.101.46.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JEEK/m20YsXYu89i7+6f7HVA+Q35wjCg8qT4+HbJy3zRtkE35af3B3ese2Uf2N3R8l3qGP4PJah65ZHzpwgWHfSQJwHb5KzXoIdCX5BoIL6YeBHUqBxhfO0ySua8zbfhOClys1NC2neSiUmwTa9YtiVIEzaL4uFRCnzNNSyHl5IcVHUxgT+SSxYOV7CqDcl8wUpTtSa1ZWeRnJI8yBG/CWAiFp5kFyuU7w/n1PMn5W9p5sodBDiwf3mT/bBgSm3if4zdoVGOWPrVruQi3dom1hg/SbPlYMdq7XhaDIbWSpgWAAJ8+h47J5YaL1MmjjEjQgXkMiNgHWfoMzlTdWBxQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6fvsj3abLNpg75lRAOUnWThyXESHF6cuVTaQWT6aPvI=;
 b=npCSG6y8JqLkk+Kr7PEMjgtO5k3FMEbQJVkOqKKw6LRE9DV/VkmQZdE8P36NA4tRLhsU97CI1fvnAcAGGbLSlXTl6S4qSUxRxs1k8RJLz5jLzhIXXxOLBbTOkbXBuRRRX+nQ3XPLVkG39CxPdMyKwdZZ1nyLAH4VZR+GwK6OFtdErL0c2gL3VVR7MA1MzuJTVrsnmn6KNzhs3PBAgPa5NiQUmKUXPVsXEgO5GFDBoon1oC8ZGLOUAP5uOFk8Nuvm9F65WpKFnInk7awBfo7dybSoo3iOeQMVGoqKYPMTRoETHeadx6qYi5x8Ic2xaftbgHm4b2VnzAKlgfTd49FIsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6fvsj3abLNpg75lRAOUnWThyXESHF6cuVTaQWT6aPvI=;
 b=XBQPkpl086FPXKM/bkN5NvVPQa5Qhah6Q0Upfm/4rrvLzsWPqBc6W6IhsZg2eBfHWVVmDfj1GrxHVGaAfb1GqpEQBYG9lWSjfHlGqz+1LL7bXs1/DkvKiUYr5/5SXWM/k/fIgLlKvfhEhZWDpZq4OzS5C29BZLkbXXSOyNW/0gDh2QDGpSLrJHI4bh7TBbTQDvELZuCxewXnUP8pZothnPO/xMJMQK+y8n+SY+7FL8Ya0emppgG8D0v6kXiPlmNRQO+Bf88lVVBrO7GxprOebbmBYyfL1n/+cynE+ti1pgfUsas1pTsKNbsBmXevpmTziegraSSEzOlt0D9Umhsrww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 DS0PR12MB9728.namprd12.prod.outlook.com (2603:10b6:8:226::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.12; Mon, 13 Oct 2025 17:06:56 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 17:06:56 +0000
From: Zi Yan <ziy@nvidia.com>
To: Lance Yang <lance.yang@linux.dev>
Cc: akpm@linux-foundation.org, syzkaller-bugs@googlegroups.com,
 mcgrof@kernel.org, nao.horiguchi@gmail.com,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, kernel@pankajraghav.com,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, jane.chu@oracle.com,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 linux-fsdevel@vger.kernel.org, david@redhat.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, linmiaohe@huawei.com,
 syzbot+e6367ea2fdab6ed46056@syzkaller.appspotmail.com
Subject: Re: [PATCH 1/2] mm/huge_memory: do not change split_huge_page*()
 target order silently.
Date: Mon, 13 Oct 2025 13:06:54 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <DF7765C3-B485-440C-8035-6BBA5A7FDA4B@nvidia.com>
In-Reply-To: <11b98453-560d-4c55-8ac9-43d1cf7b3543@linux.dev>
References: <20251010173906.3128789-1-ziy@nvidia.com>
 <20251010173906.3128789-2-ziy@nvidia.com>
 <11b98453-560d-4c55-8ac9-43d1cf7b3543@linux.dev>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BN9PR03CA0282.namprd03.prod.outlook.com
 (2603:10b6:408:f5::17) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|DS0PR12MB9728:EE_
X-MS-Office365-Filtering-Correlation-Id: d1d1134c-bb14-4f8c-117d-08de0a7aea0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AjKDnlYnYpQ1GL3G3dvB0EVkMIVh+Au32YMRHpNbdfFhu6Y8zKmjwct1pjOH?=
 =?us-ascii?Q?3ueBkN+r0TRkXVUNrx2zLxAanN7CM3HZTllF8C5g6YubJQKwtgPLzOL52WRu?=
 =?us-ascii?Q?By05ewOcAD7MPAWDG/ZrZx4B0bDofOOAToLdibN07dLKlvVKTZ0MzQp4JH42?=
 =?us-ascii?Q?0GvIsexEj3aJ+DJLLW1O86/njSTz+Xjq3AQVvJDNXuvNA41F5ks5gRO8A6QF?=
 =?us-ascii?Q?VQRtHD8YRGfX1GzGdgPMCusHwliC7eWVF5g80CqKP3ERC3FStr+lCel4fWe4?=
 =?us-ascii?Q?iATryecFttQAjR88i/356v1Kh2vMj4KSt5u6QMiVxko/7Uv9iSgXV5rjW+5y?=
 =?us-ascii?Q?hmUlgs9lG2Pvt34CzoPpCQz/nZff5kml5HlZ35inW5Dv6aYUy7Dfe1TsCfO1?=
 =?us-ascii?Q?CStZLpIb/fqjbcrARxYbDt/I8zOMKrOXyQDzrQh/iQdHlSKozYFvyW27MoKg?=
 =?us-ascii?Q?SHdBHpzsJ0Z0kHE1V3MQObPrCv37sGCCRCnxtVIBF4ACDOdjchRXBU17BbS6?=
 =?us-ascii?Q?Ln7t2WPJ0a7C0+H7HtTLjHK3Vxx4y+0yu5wDwk95uzBEvmbxIDnzK2xwYv6l?=
 =?us-ascii?Q?Vf4xF+vmkJGqJasSFwbnSlI8CM9fmGzCKtMsZfBLFwFcwAJ1LCqArzdAkhc2?=
 =?us-ascii?Q?Novt4s0F3WfOwptN01Xr/+pCE8UyvrvLu9Eyn7erg6r/eVIBumvaV22B8T1Q?=
 =?us-ascii?Q?WUgH6zEPuvXypYE3szjF06LJeSBKPe4ImrnfJQpaV3i2Dpydhut6OYkRVzw4?=
 =?us-ascii?Q?OOqEmjljQQnMJ0W8r/hPT66VJnho0jC6rgkbr1NKqd8w3AoK3+n9HyG1B0NW?=
 =?us-ascii?Q?L343qCM+qMJ2Aqg4pOSMdw/e1cEF4MpJ74OEhrOLzavrqwtZ8SxkEjPyR8ce?=
 =?us-ascii?Q?8MolpLL0/INgk+FwCW3GXWnd/axzAPwQMW4bcZJBoDFdf+Y+WPoUpdLH0Oje?=
 =?us-ascii?Q?fT0j+gX5bZt+Ee//aBqer/QJBjMGoA1lsYdU9J3om4qbG7JhzogoHzyVM2sn?=
 =?us-ascii?Q?rs5SYcvINogPZzWjZMi1SCECMEEc/AfUYf40UevFBLUJ5QaSqj2Iywrejmla?=
 =?us-ascii?Q?VfJveeNVhg9BpitlPMZNk510QjMv/whDEYp2AgQ+MU0cpyq0eJxweqFPPpkm?=
 =?us-ascii?Q?txhXcA3BP6WIiAP55OfkyoslLRCp9BvsLfGOFuGgZkNmVW9qURgyvsDDUwYu?=
 =?us-ascii?Q?66vnHPXmP3ETKFu0E1EOs0OvaTo0vMwhkKJ0LPiuIZyrJmR54dob+fgb76Oc?=
 =?us-ascii?Q?aPHjRcheI5OVEVfGgU1Cb5hz468sbgTgXwU9hcdQ2CH3vUbPqiz+P0CpZraI?=
 =?us-ascii?Q?EEVKGsDlvWshMYNGV3T52ZqY7qU9IDENIcASeUDaHhxAK36LRXBEQM7XSms6?=
 =?us-ascii?Q?005xoD+dw7qSCaqiKuvsFQZHZcGFKNNzeubKklDeAnbMKCLRXSBv7HNA68mz?=
 =?us-ascii?Q?2FdOSIzKXAUKgOJwsOWli+oRRn/azPYrdNHfUsUlNxPZRPF6Po6QMA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RnHZ/eEx0ZbZwdHT5AuKZF/U0OkdgZ+MbF8rFHpdUyyOLahYu3B/mUkpCTZl?=
 =?us-ascii?Q?Dyd5cpC7RpOKBGhdQfD53FC2gphH6UT1xAtvobE/yA5zA2CxxB/zmpJyB21o?=
 =?us-ascii?Q?u0W9eAs2qPgiY24n1Yo/z9KCE9bzcWoKSYreJShHX0FsHTBB70ebp6xoEh5r?=
 =?us-ascii?Q?HqB1LwCJQfi9JMgX35tujAA7UgBCcrM0EG+WNdFxfa/ANKdUhmMS4MKWfySF?=
 =?us-ascii?Q?+JMsRetwJzwOP9uQkoFw0yo1EOqJ1bk5q3Q1aiCzAvvP8dBina3WrRNUgHbJ?=
 =?us-ascii?Q?1aGg3Wu0ZwMl1wsVxhh7wgjB24+aT9PEdI18DihKFTvsE9neDMsM/v++pKEt?=
 =?us-ascii?Q?JtVYjEqV2W5MTJeShU+Z5KbXEmnccZguQkCt5ORU5EulwFpEpNshX+92cKTu?=
 =?us-ascii?Q?jaXwAtHWTOGMvBoW6PIqsPOtz5cSc/6W1/grl0ANcUENkIKV+hIv9a2kmeq4?=
 =?us-ascii?Q?X/sTX31SgI2vqYzMfnSd+Ir5Fa2ASPeTg88OJ1O19vHJCLnvOA8noTxM2+5i?=
 =?us-ascii?Q?sHM39QKeHYVxp0ThgVq8DUo9r2/Y2DBDoBfqy1Zd/XngDJMuWZEz8R3AcI6R?=
 =?us-ascii?Q?QgGo38usIosZtFfCJXI/LHdHl+vlzDrVlQb4AB/lCQ4qpBdUMjQyHVhh2MwT?=
 =?us-ascii?Q?xL2rD/cQYUW9d9xsq+4tGT6/41EUC146JLNDou0DqupVOH+fVuyslq3UMKsW?=
 =?us-ascii?Q?1W3bR+hKJMlJ1GVx9/kNqz1lccW9eCuRLFFEvua6zljPiEw42IrYjiyWrRE4?=
 =?us-ascii?Q?LTYhRz3hey1/yeAWpoZ2P8uSCnRN9lFXL94SQBRgAQkENvybhs/CxHq1BBbT?=
 =?us-ascii?Q?NWd9uS85TE+uZ9+lNTfpRohCQik2kyAkecJH91TJUYxYviycZnVzglUx3HmZ?=
 =?us-ascii?Q?C8nHprMomq6qOIJ+UTaYksiNS/pbJdoT/KAa/7/8e+RredaqUvFd6HxzNWdm?=
 =?us-ascii?Q?yQuBlsrLwLEOY6+E4q4hwb3JT1lEuQhXOahOe651pjL7UUUjLlthj22mmu+t?=
 =?us-ascii?Q?9RGyz0jDk8oz8ae1n4+pjY7obrIGfK985vAnrpSUa3yJ3vtsSLPpNkUXllgQ?=
 =?us-ascii?Q?WuJr1fcd5gSQtYacPOcbkhyQ4wdONgUhd2dtRFobnPOt2FS10XFCMo8J9B4y?=
 =?us-ascii?Q?zBjg+h/o6Encje/UVl0nWjO3KsNwW6EApK/gPKKLHX4gRtCYKPTjo/trlF56?=
 =?us-ascii?Q?zML9D+4Uaucp7iCJVEkul4OPYppRYzOTZ0nxQBhCqrXKv5OCYc3Uv2UoAJu4?=
 =?us-ascii?Q?tZ96tf1t1oRdaL2v9BXiC0TA0231D0JV53XTGzR1U6vBjDF5Us4UcWNdbnkv?=
 =?us-ascii?Q?bLcbHI8zawOEwK5yDwds2qTUTs3ZOCLpDptKHQOJ5izRo7b52H7UOLbTSEY3?=
 =?us-ascii?Q?/ZFrrSPffN41wTZPBqqLo49hSlFlp3m4kaaJf/NALCncm5hPdTFPYvP7OHj6?=
 =?us-ascii?Q?8AvV1kyeqM+HzfXt/2HR+Yf+iuRd5pXybecMv4YqNba+aEDO0mdZ1uQrZqX3?=
 =?us-ascii?Q?3P8jqRwitUpQkOrTlOoUtcxIMGbEKmwtZo8fJQRBwCGlh+G1QawsnCkVcZXG?=
 =?us-ascii?Q?L+86bpTDBFpKDhs//q5HpeSVpIJ7jqeNk7ivRYpc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1d1134c-bb14-4f8c-117d-08de0a7aea0a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 17:06:56.3288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gd48aZQe8DR1vdh/4lo3W/V5Sm02Z3+wEmdHJx34G+7kzpQSWM5FM19Gb32pflJB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9728

On 10 Oct 2025, at 22:25, Lance Yang wrote:

> On 2025/10/11 01:39, Zi Yan wrote:
>> Page cache folios from a file system that support large block size (LB=
S)
>> can have minimal folio order greater than 0, thus a high order folio m=
ight
>> not be able to be split down to order-0. Commit e220917fa507 ("mm: spl=
it a
>> folio in minimum folio order chunks") bumps the target order of
>> split_huge_page*() to the minimum allowed order when splitting a LBS f=
olio.
>> This causes confusion for some split_huge_page*() callers like memory
>> failure handling code, since they expect after-split folios all have
>> order-0 when split succeeds but in really get min_order_for_split() or=
der
>> folios.
>>
>> Fix it by failing a split if the folio cannot be split to the target o=
rder.
>>
>> Fixes: e220917fa507 ("mm: split a folio in minimum folio order chunks"=
)
>> [The test poisons LBS folios, which cannot be split to order-0 folios,=
 and
>> also tries to poison all memory. The non split LBS folios take more me=
mory
>> than the test anticipated, leading to OOM. The patch fixed the kernel
>> warning and the test needs some change to avoid OOM.]
>> Reported-by: syzbot+e6367ea2fdab6ed46056@syzkaller.appspotmail.com
>> Closes: https://lore.kernel.org/all/68d2c943.a70a0220.1b52b.02b3.GAE@g=
oogle.com/
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>> ---
>>   include/linux/huge_mm.h | 28 +++++-----------------------
>>   mm/huge_memory.c        |  9 +--------
>>   mm/truncate.c           |  6 ++++--
>>   3 files changed, 10 insertions(+), 33 deletions(-)
>>
>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>> index 8eec7a2a977b..9950cda1526a 100644
>> --- a/include/linux/huge_mm.h
>> +++ b/include/linux/huge_mm.h
>> @@ -394,34 +394,16 @@ static inline int split_huge_page_to_list_to_ord=
er(struct page *page, struct lis
>>    * Return: 0: split is successful, otherwise split failed.
>>    */
>>   static inline int try_folio_split(struct folio *folio, struct page *=
page,
>> -		struct list_head *list)
>> +		struct list_head *list, unsigned int order)
>
> Seems like we need to add the order parameter to the stub for try_folio=
_split() as well?
>
> #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>
> ...
>
> #else /* CONFIG_TRANSPARENT_HUGEPAGE */
>
> static inline int try_folio_split(struct folio *folio, struct page *pag=
e,
> 		struct list_head *list)
> {
> 	VM_WARN_ON_ONCE_FOLIO(1, folio);
> 	return -EINVAL;
> }
>
> #endif /* CONFIG_TRANSPARENT_HUGEPAGE */

Thanks. It is also reported by lkp robot. Will fix it.

--
Best Regards,
Yan, Zi

