Return-Path: <linux-fsdevel+bounces-20479-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC29B8D3EEF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 21:35:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFB891C20C78
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 19:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3544167282;
	Wed, 29 May 2024 19:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="SYLWaX5h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip168b.ess.barracuda.com (outbound-ip168b.ess.barracuda.com [209.222.82.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C73642045
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 May 2024 19:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717011301; cv=fail; b=j239A928y+IV62UZL9fp3QupucOq5SVcF1mdv23rKq89WfpmDPkuv+HwNS2SDsVlx6xBJb/1vAHT24t9J1GNmYNcDV7HKhTmz3dHFYJqmOlTXfj42lA51FRDNjk+Cp2lk7RopeCs1aei1FPXIFnNDwmV2FyKFF44ent5r7zFj70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717011301; c=relaxed/simple;
	bh=yezGSbNY2m7pcLSUKK3aAEUBUzPfBv6e8zEqydNY0To=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=Vo7DvKEpfGLddsAcrpne8HwbKC8LLU2KKDsbKbxYIRhg1BOFlwwdOrNHsZ19BC9Lk8+ECj93h5GN9PGVTmebNBq/PKo/2URVrT5y9WFV6v6i8dHnzuf/TbKllAeHILMJHAH0F4Ze+HzNMmFaeEIG0NHttv9n1eaQk4X7+9Og2uA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=SYLWaX5h; arc=fail smtp.client-ip=209.222.82.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100]) by mx-outbound45-109.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 29 May 2024 19:34:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m3tEniMkbe27CjKXn0HugNAe7ub3DyC6ei6f2i69eMZl13Dk0+kR9bnoK1wDEc9ySdw6HtMWtaWUnBO5phqEh4wxfqp/7XiNJnhBqPeTxKtOkAjchYGG0l74gEhK98BLkfBGdCQBdiQUWEQ9tZpVXsS6aZNTptHq8eMZE8ydeZdjWc+nfn076ILEhwWsnowgGVQZF2roY+dwNH9RsDFb28zbmsG4hFmLX8r2Gja5e3PyJiw+vqfuPopDKt7mhiFlx8IbBT/wvETTVL7ZktflR2L0jBJx3XHMGmuddniO5CDegtN/8Np3ycqOlAeqB77eKMiy1XWvPRGtUJ5k4fjqXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JGz3EdpLhpl+Oj78BNRT5SmWtw4gwscCrGD822CkXqs=;
 b=ignQCiWLsiVXRz9LYhzYBs0SCkz/aIzsVRj6dlPvUaFTixCuH+RJEcq7/eN779wHDJaxhAeeT1sDzuiDu1Ln//Tp2Go3xIiIWbJ1gfZE1CaCCYrUWQJyekJCB8PvAR4D3XlfyaHdIa7WJcelvzVyVtlNQuOglKZ9Ck3eE8/0KuKA6paiGSKOvP9SF6hVvzNr6uYSdGzrmkMrnZMHX8ZZYC4nfNvukW5U/+bdK8FyLCpmdbbboUOq7MfivAxLsUSnQujAMUOYi1+Jnbs3cA+oYLDeY5Wj51L+lovHNfwRKqOrAivSGEZX3GKIFE6SXTgQUycXqlwtPq4iemYLxkhP3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JGz3EdpLhpl+Oj78BNRT5SmWtw4gwscCrGD822CkXqs=;
 b=SYLWaX5hEJiYC+R3J7cbDELdzaHQmQnN+HCg1myJ4P3IO3VbeO+kTNXwF2tktyq3srtrh0//+6VFzYmGLu8qlzzA3TAqyIM65XcZPVtQeXEM+Of2EXQ9yNPaqcTBdiXUZkCZ8AnNmD4UpE3+lWbkGtC2RxKlzIKTZ6/qkIZ0Hvg=
Received: from CH2PR14CA0049.namprd14.prod.outlook.com (2603:10b6:610:56::29)
 by SJ0PR19MB5367.namprd19.prod.outlook.com (2603:10b6:a03:3d2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Wed, 29 May
 2024 18:00:55 +0000
Received: from CH1PEPF0000AD7C.namprd04.prod.outlook.com
 (2603:10b6:610:56:cafe::67) by CH2PR14CA0049.outlook.office365.com
 (2603:10b6:610:56::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30 via Frontend
 Transport; Wed, 29 May 2024 18:00:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 CH1PEPF0000AD7C.mail.protection.outlook.com (10.167.244.84) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7452.22
 via Frontend Transport; Wed, 29 May 2024 18:00:54 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id 26DBC25;
	Wed, 29 May 2024 18:00:54 +0000 (UTC)
From: Bernd Schubert <bschubert@ddn.com>
Date: Wed, 29 May 2024 20:00:40 +0200
Subject: [PATCH RFC v2 05/19] fuse: Add a uring config ioctl
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240529-fuse-uring-for-6-9-rfc2-out-v1-5-d149476b1d65@ddn.com>
References: <20240529-fuse-uring-for-6-9-rfc2-out-v1-0-d149476b1d65@ddn.com>
In-Reply-To: <20240529-fuse-uring-for-6-9-rfc2-out-v1-0-d149476b1d65@ddn.com>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
 linux-fsdevel@vger.kernel.org, Bernd Schubert <bschubert@ddn.com>, 
 bernd.schubert@fastmail.fm
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717005648; l=18468;
 i=bschubert@ddn.com; s=20240529; h=from:subject:message-id;
 bh=yezGSbNY2m7pcLSUKK3aAEUBUzPfBv6e8zEqydNY0To=;
 b=s1lu3sRwXdHn40yCWrk3zpjfwkhpCiInCuCDVPLx3xbRcZCKlfBGRbvsDV2osS55WQlMMvBb8
 QmsWG5tMlhdC0UGL8AyLHftwP74snSzXBi8pEi9d5Re25R5nQugvz9K
X-Developer-Key: i=bschubert@ddn.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7C:EE_|SJ0PR19MB5367:EE_
X-MS-Office365-Filtering-Correlation-Id: 8302581b-4122-47aa-d892-08dc8009492b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|376005|1800799015|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VDdSSWtsRmxDZFhyRVAvSXpOODh5NnhSbVlGOEpEMHZBNXZ6ZFBMb3ljdDJX?=
 =?utf-8?B?cEg4NWZ0clM5ZkNCZTlIQlB2ckVkZ3lUOW56TkJGRFRyVmJyT1JKRWkxRms3?=
 =?utf-8?B?SllXK05kTStvbG1PZ0I5dm9aYkx5YXErYktEYTZpWHVBd2hHT21lRkJPZW1J?=
 =?utf-8?B?cVkwS09ld0w5b3U4eXpMV0R2S01sNVpvaUZoU1AxQ1hPZDY3Q2VWZVc4ZnUy?=
 =?utf-8?B?UGJTUWM2QUlyMmtxUkZ6N25xQ3RTTDdTbXFBTXBPbjlxMEJKQVEwYlFnaHQw?=
 =?utf-8?B?QnhLYXNhWnNzSkcxZFNmc2VMY1ZQNlVEdTZPUXh2c3pIVmxNL2UzMkNObWt1?=
 =?utf-8?B?OTFtSGZDL2JrTnRVcG8vOWdaVTY5MXU1V1ErNk5UWVFPTi9TaFZGdDdPa0hU?=
 =?utf-8?B?d1o4QUgxazg3TTM0c3k5UVpsNStId0tGSHExSjQvSkgvVkZmV1I5Um5oZzF6?=
 =?utf-8?B?VUYyeS8zMzRiVkc4d0FOSXJDZ1NGRkE2Y3JNMlRZUk1FT3R0SHVka2VzdnZ3?=
 =?utf-8?B?ZlcyY1ZqVms1WDJLaXNpa3RmQzZWdzF0TnljMG9MSDUxOXp5Y3RZTUQ4bUJz?=
 =?utf-8?B?SXR6OXlhOTl0ODVveTlsMWdBVkFManNodkhFa3NFam15bnUvOUpDcEtUOE0z?=
 =?utf-8?B?bUxQalJ5N0dQV0k0S0ZyS1V0MmZxRHBzcER6Y3ZrUjJRSHhlb0pOZWhlemFX?=
 =?utf-8?B?bW5Ub0R2UHJSZHBUK1JFbjR1TmlOL0lmYlI3RDdKdVRRMEcyditxYmV0RFNq?=
 =?utf-8?B?MURNbGtibUdvRStuTVlUOXRKRUp0VWlGU1VrQ1QwYjJXQmhkU3I5TjJSTHRE?=
 =?utf-8?B?TXJxcE1Rc1VSQmxmYjNFTTRUMTk5OXNpUmQ0OVNlMzd4VVVENG9rMGtQNEdq?=
 =?utf-8?B?cXk4NlFweHJJSzk5ZDV2Wm1vcFVqODk0TzJDSTVmOURWNm94ZGdnZ3JuSWlD?=
 =?utf-8?B?SlZ3T1RTR3A3VjNTWjhjSXBxUlFPZ2czV1pUWUNiQ2poWXkvQmhxNVJSQnJU?=
 =?utf-8?B?TXpQYU02MDFJbFQyWENscXk2Nno1TUxYa2FFdDhGOHRIUlYrQTNHUjFINVJp?=
 =?utf-8?B?UzdxN1UxakN2YVlyTVBkWFBFUTVaUXhZbzVNRkxQYVVjakxFNXdza1lxbDRx?=
 =?utf-8?B?YURmZzNWSktDRXJvMitwa3pkbFYxZDd2UENrUmJyTFR3TWxpdlU5QkxIWmdt?=
 =?utf-8?B?RDJ4dnVCa3RuL1JtZWFucy9DMWpWb1hySVZVaFc3ckNacm1YeWVKVWxDRFYy?=
 =?utf-8?B?cGNEU1ZTVzNnQzg1eXlZSkhxMmFXRkYrd1dMUXZOV0pCSGFyeVU0dXlMMjZm?=
 =?utf-8?B?OG5oby9YV3M4bUhnTFI2STBESStxaDhoOGRNV1QxK1JiMWZKMU51TUQxckwr?=
 =?utf-8?B?UUlsVFFKbzFTN3JmUCtvUmdUMFlocmxiekt3cUVQSmFnMUQ2OGxGSHkvL2ky?=
 =?utf-8?B?NzBCYVIwazRvemtGMjg0V1kzYnBEcHJKQ2JLSHpkR09DMkQ1ODRoMzlkVHNy?=
 =?utf-8?B?RExoSG9mWkZobGxNeVF3b0hNakhTejc5UVJITmpDWkhoSFE1bTl0S3RiLzl2?=
 =?utf-8?B?Y3hxL1JRZXFVY2xSc296MWNGWVova0xWWCtQQk5NL2dBMnpvbE44Y3FvVmFJ?=
 =?utf-8?B?bjNZUytNMTJaWjlvTWg4ZnZZdjQzc0pMNmxvVjlTOE1uYm5YczNETGJoeU9j?=
 =?utf-8?B?dGw3OWI4cjdUUEs1NXViMlR6QzhpTnB4TUZ5by82ZlZETU42TWZqNGwrSFV3?=
 =?utf-8?B?Qlh2SWtNYTgvNUZUUmpVNnEvR0JvUURiejBMQm9XMlBwdDZQYk9TWmphbThY?=
 =?utf-8?B?K2labjJSbHJLTVdpVEF1a2tHbTNlZnJ2T1lGQUhnbVlxMVBJS0xHakpQYVFW?=
 =?utf-8?Q?ZoVnyaR2BLik+?=
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400017)(376005)(1800799015)(36860700004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	oLkGfebqruS8bTvLGSUcZbIsPKeVinlR0TDX6oSm27+nAN/xRYTzMGq0x1WfYUj3aPC2kdVdhBbpQKvgywuyN8afb7zAhgI7ABNk2X+O6DESXPXQq144fArXQXDGHeypmYdgRIUzj+mDB7ye7os7UIR48B6bcQdiigFNh0vLoSGhJ7WGS2jWveZGETOznsrZc4s2Hfi9bBIVImE3KJzTAkJI3bj4Mxba3oMqvrbWlRHcsLE3puSOJAF56X9NXDnuAQwamhWTKNBOjY5mX/WnrQDPnqNWOz160hCdooMIcSBBqTIOpHw4IY6JO3cZKAsE57GTq22FPCuuyM69pTPVZFTlb9zVWwImIfLvg2ugiGZUV45x7eYyx4Or61nwgy1ns/0j3oOAlk9qnBLhdGyo62ao4EWxWufMt8269NtWD2BU9qabyTSzlryXpn5VcHa2H6j0BlGhKSiNwwXaF2ydldor9Sxw3J7yg2KGBenBQ590tCSTFQv2No7jzUaFUCX/sbk4o8S79S5SEshMRnCHuAWeM/UOzkQUgWJIm026oPTkf1tt3clHxmysNG5l1Nik3ZlJ3Nqpdt/0neRpTw7Zv1DZBVkmpspz9tPjdv33uGEk3GiPX0hAv/+GSYSK6Ph2wA8/KydTl+vBNxUfUjszJA==
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 18:00:54.9345
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8302581b-4122-47aa-d892-08dc8009492b
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR19MB5367
X-OriginatorOrg: ddn.com
X-BESS-ID: 1717011297-111629-12835-26231-1
X-BESS-VER: 2019.1_20240429.2309
X-BESS-Apparent-Source-IP: 104.47.70.100
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVobm5qbmQGYGUNTMOMUs2cgi0d
	Qo1TQxNdHYODk5NcUiOTnFwNA4MdUgWak2FgBSAWHIQgAAAA==
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.256586 [from 
	cloudscan10-140.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.50 BSF_RULE7568M          META: Custom Rule 7568M 
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
	0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
X-BESS-Outbound-Spam-Status: SCORE=0.50 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_RULE7568M, BSF_BESS_OUTBOUND, BSF_SC0_MISMATCH_TO
X-BESS-BRTS-Status:1

This only adds the initial ioctl for basic fuse-uring initialization.
More ioctl types will be added later to initialize queues.

This also adds data structures needed or initialized by the ioctl
command and that will be used later.

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
 fs/fuse/Kconfig           |  12 +++
 fs/fuse/Makefile          |   1 +
 fs/fuse/dev.c             |  91 ++++++++++++++++--
 fs/fuse/dev_uring.c       | 122 +++++++++++++++++++++++
 fs/fuse/dev_uring_i.h     | 239 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/fuse_dev_i.h      |   1 +
 fs/fuse/fuse_i.h          |   5 +
 fs/fuse/inode.c           |   3 +
 include/uapi/linux/fuse.h |  73 ++++++++++++++
 9 files changed, 538 insertions(+), 9 deletions(-)

diff --git a/fs/fuse/Kconfig b/fs/fuse/Kconfig
index 8674dbfbe59d..11f37cefc94b 100644
--- a/fs/fuse/Kconfig
+++ b/fs/fuse/Kconfig
@@ -63,3 +63,15 @@ config FUSE_PASSTHROUGH
 	  to be performed directly on a backing file.
 
 	  If you want to allow passthrough operations, answer Y.
+
+config FUSE_IO_URING
+	bool "FUSE communication over io-uring"
+	default y
+	depends on FUSE_FS
+	depends on IO_URING
+	help
+	  This allows sending FUSE requests over the IO uring interface and
+          also adds request core affinity.
+
+	  If you want to allow fuse server/client communication through io-uring,
+	  answer Y
diff --git a/fs/fuse/Makefile b/fs/fuse/Makefile
index 6e0228c6d0cb..7193a14374fd 100644
--- a/fs/fuse/Makefile
+++ b/fs/fuse/Makefile
@@ -11,5 +11,6 @@ fuse-y := dev.o dir.o file.o inode.o control.o xattr.o acl.o readdir.o ioctl.o
 fuse-y += iomode.o
 fuse-$(CONFIG_FUSE_DAX) += dax.o
 fuse-$(CONFIG_FUSE_PASSTHROUGH) += passthrough.o
+fuse-$(CONFIG_FUSE_IO_URING) += dev_uring.o
 
 virtiofs-y := virtio_fs.o
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index b98ecb197a28..bc77413932cf 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -8,6 +8,7 @@
 
 #include "fuse_i.h"
 #include "fuse_dev_i.h"
+#include "dev_uring_i.h"
 
 #include <linux/init.h>
 #include <linux/module.h>
@@ -26,6 +27,13 @@
 MODULE_ALIAS_MISCDEV(FUSE_MINOR);
 MODULE_ALIAS("devname:fuse");
 
+#if IS_ENABLED(CONFIG_FUSE_IO_URING)
+static bool __read_mostly enable_uring;
+module_param(enable_uring, bool, 0644);
+MODULE_PARM_DESC(enable_uring,
+		 "Enable uring userspace communication through uring.");
+#endif
+
 static struct kmem_cache *fuse_req_cachep;
 
 static void fuse_request_init(struct fuse_mount *fm, struct fuse_req *req)
@@ -2297,16 +2305,12 @@ static int fuse_device_clone(struct fuse_conn *fc, struct file *new)
 	return 0;
 }
 
-static long fuse_dev_ioctl_clone(struct file *file, __u32 __user *argp)
+static long _fuse_dev_ioctl_clone(struct file *file, int oldfd)
 {
 	int res;
-	int oldfd;
 	struct fuse_dev *fud = NULL;
 	struct fd f;
 
-	if (get_user(oldfd, argp))
-		return -EFAULT;
-
 	f = fdget(oldfd);
 	if (!f.file)
 		return -EINVAL;
@@ -2329,6 +2333,16 @@ static long fuse_dev_ioctl_clone(struct file *file, __u32 __user *argp)
 	return res;
 }
 
+static long fuse_dev_ioctl_clone(struct file *file, __u32 __user *argp)
+{
+	int oldfd;
+
+	if (get_user(oldfd, argp))
+		return -EFAULT;
+
+	return _fuse_dev_ioctl_clone(file, oldfd);
+}
+
 static long fuse_dev_ioctl_backing_open(struct file *file,
 					struct fuse_backing_map __user *argp)
 {
@@ -2364,8 +2378,65 @@ static long fuse_dev_ioctl_backing_close(struct file *file, __u32 __user *argp)
 	return fuse_backing_close(fud->fc, backing_id);
 }
 
-static long fuse_dev_ioctl(struct file *file, unsigned int cmd,
-			   unsigned long arg)
+/**
+ * Configure the queue for the given qid. First call will also initialize
+ * the ring for this connection.
+ */
+static long fuse_uring_ioctl(struct file *file, __u32 __user *argp)
+{
+#if IS_ENABLED(CONFIG_FUSE_IO_URING)
+	int res;
+	struct fuse_uring_cfg cfg;
+	struct fuse_dev *fud;
+	struct fuse_conn *fc;
+	struct fuse_ring *ring;
+
+	res = copy_from_user(&cfg, (void *)argp, sizeof(cfg));
+	if (res != 0)
+		return -EFAULT;
+
+	fud = fuse_get_dev(file);
+	if (fud == NULL)
+		return -ENODEV;
+	fc = fud->fc;
+
+	switch (cfg.cmd) {
+	case FUSE_URING_IOCTL_CMD_RING_CFG:
+		if (READ_ONCE(fc->ring) == NULL)
+			ring = kzalloc(sizeof(*fc->ring), GFP_KERNEL);
+
+		spin_lock(&fc->lock);
+		if (fc->ring == NULL) {
+			fc->ring = ring;
+			fuse_uring_conn_init(fc->ring, fc);
+		} else {
+			kfree(ring);
+		}
+
+		spin_unlock(&fc->lock);
+		if (fc->ring == NULL)
+			return -ENOMEM;
+
+		mutex_lock(&fc->ring->start_stop_lock);
+		res = fuse_uring_conn_cfg(fc->ring, &cfg.rconf);
+		mutex_unlock(&fc->ring->start_stop_lock);
+
+		if (res != 0)
+			return res;
+		break;
+	default:
+		res = -EINVAL;
+	}
+
+		return res;
+#else
+	return -ENOTTY;
+#endif
+}
+
+static long
+fuse_dev_ioctl(struct file *file, unsigned int cmd,
+	       unsigned long arg)
 {
 	void __user *argp = (void __user *)arg;
 
@@ -2379,8 +2450,10 @@ static long fuse_dev_ioctl(struct file *file, unsigned int cmd,
 	case FUSE_DEV_IOC_BACKING_CLOSE:
 		return fuse_dev_ioctl_backing_close(file, argp);
 
-	default:
-		return -ENOTTY;
+	case FUSE_DEV_IOC_URING:
+		return fuse_uring_ioctl(file, argp);
+
+	default: return -ENOTTY;
 	}
 }
 
diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
new file mode 100644
index 000000000000..702a994cf192
--- /dev/null
+++ b/fs/fuse/dev_uring.c
@@ -0,0 +1,122 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * FUSE: Filesystem in Userspace
+ * Copyright (c) 2023-2024 DataDirect Networks.
+ */
+
+#include "fuse_i.h"
+#include "fuse_dev_i.h"
+#include "dev_uring_i.h"
+
+#include "linux/compiler_types.h"
+#include "linux/spinlock.h"
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/poll.h>
+#include <linux/sched/signal.h>
+#include <linux/uio.h>
+#include <linux/miscdevice.h>
+#include <linux/pagemap.h>
+#include <linux/file.h>
+#include <linux/slab.h>
+#include <linux/pipe_fs_i.h>
+#include <linux/swap.h>
+#include <linux/splice.h>
+#include <linux/sched.h>
+#include <linux/io_uring.h>
+#include <linux/mm.h>
+#include <linux/io.h>
+#include <linux/io_uring.h>
+#include <linux/io_uring/cmd.h>
+#include <linux/topology.h>
+#include <linux/io_uring/cmd.h>
+
+/*
+ * Basic ring setup for this connection based on the provided configuration
+ */
+int fuse_uring_conn_cfg(struct fuse_ring *ring, struct fuse_ring_config *rcfg)
+{
+	size_t queue_sz;
+
+	if (ring->configured) {
+		pr_info("The ring is already configured.\n");
+		return -EALREADY;
+	}
+
+	if (rcfg->nr_queues == 0) {
+		pr_info("zero number of queues is invalid.\n");
+		return -EINVAL;
+	}
+
+	if (rcfg->nr_queues > 1 && rcfg->nr_queues != num_present_cpus()) {
+		pr_info("nr-queues (%d) does not match nr-cores (%d).\n",
+			rcfg->nr_queues, num_present_cpus());
+		return -EINVAL;
+	}
+
+	if (rcfg->req_arg_len < FUSE_RING_MIN_IN_OUT_ARG_SIZE) {
+		pr_info("Per req buffer size too small (%d), min: %d\n",
+			rcfg->req_arg_len, FUSE_RING_MIN_IN_OUT_ARG_SIZE);
+		return -EINVAL;
+	}
+
+	if (WARN_ON(ring->queues))
+		return -EINVAL;
+
+	ring->numa_aware = rcfg->numa_aware;
+	ring->nr_queues = rcfg->nr_queues;
+	ring->per_core_queue = rcfg->nr_queues > 1;
+
+	ring->max_nr_sync = rcfg->sync_queue_depth;
+	ring->max_nr_async = rcfg->async_queue_depth;
+	ring->queue_depth = ring->max_nr_sync + ring->max_nr_async;
+
+	ring->req_arg_len = rcfg->req_arg_len;
+	ring->req_buf_sz = rcfg->user_req_buf_sz;
+
+	ring->queue_buf_size = ring->req_buf_sz * ring->queue_depth;
+
+	queue_sz = sizeof(*ring->queues) +
+		   ring->queue_depth * sizeof(struct fuse_ring_ent);
+	ring->queues = kcalloc(rcfg->nr_queues, queue_sz, GFP_KERNEL);
+	if (!ring->queues)
+		return -ENOMEM;
+	ring->queue_size = queue_sz;
+	ring->configured = 1;
+
+	atomic_set(&ring->queue_refs, 0);
+
+	return 0;
+}
+
+void fuse_uring_ring_destruct(struct fuse_ring *ring)
+{
+	unsigned int qid;
+	struct rb_node *rbn;
+
+	for (qid = 0; qid < ring->nr_queues; qid++) {
+		struct fuse_ring_queue *queue = fuse_uring_get_queue(ring, qid);
+
+		vfree(queue->queue_req_buf);
+	}
+
+	kfree(ring->queues);
+	ring->queues = NULL;
+	ring->nr_queues_ioctl_init = 0;
+	ring->queue_depth = 0;
+	ring->nr_queues = 0;
+
+	rbn = rb_first(&ring->mem_buf_map);
+	while (rbn) {
+		struct rb_node *next = rb_next(rbn);
+		struct fuse_uring_mbuf *entry =
+			rb_entry(rbn, struct fuse_uring_mbuf, rb_node);
+
+		rb_erase(rbn, &ring->mem_buf_map);
+		kfree(entry);
+
+		rbn = next;
+	}
+
+	mutex_destroy(&ring->start_stop_lock);
+}
diff --git a/fs/fuse/dev_uring_i.h b/fs/fuse/dev_uring_i.h
new file mode 100644
index 000000000000..58ab4671deff
--- /dev/null
+++ b/fs/fuse/dev_uring_i.h
@@ -0,0 +1,239 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * FUSE: Filesystem in Userspace
+ * Copyright (c) 2023-2024 DataDirect Networks.
+ */
+
+#ifndef _FS_FUSE_DEV_URING_I_H
+#define _FS_FUSE_DEV_URING_I_H
+
+#include "fuse_i.h"
+#include "linux/compiler_types.h"
+#include "linux/rbtree_types.h"
+
+#if IS_ENABLED(CONFIG_FUSE_IO_URING)
+
+/* IORING_MAX_ENTRIES */
+#define FUSE_URING_MAX_QUEUE_DEPTH 32768
+
+struct fuse_uring_mbuf {
+	struct rb_node rb_node;
+	void *kbuf; /* kernel allocated ring request buffer */
+	void *ubuf; /* mmaped address */
+};
+
+/** A fuse ring entry, part of the ring queue */
+struct fuse_ring_ent {
+	/*
+	 * pointer to kernel request buffer, userspace side has direct access
+	 * to it through the mmaped buffer
+	 */
+	struct fuse_ring_req *rreq;
+
+	/* the ring queue that owns the request */
+	struct fuse_ring_queue *queue;
+
+	struct io_uring_cmd *cmd;
+
+	struct list_head list;
+
+	/*
+	 * state the request is currently in
+	 * (enum fuse_ring_req_state)
+	 */
+	unsigned long state;
+
+	/* array index in the ring-queue */
+	int tag;
+
+	/* is this an async or sync entry */
+	unsigned int async : 1;
+
+	struct fuse_req *fuse_req; /* when a list request is handled */
+};
+
+struct fuse_ring_queue {
+	/* task belonging to the current queue */
+	struct task_struct *server_task;
+
+	/*
+	 * back pointer to the main fuse uring structure that holds this
+	 * queue
+	 */
+	struct fuse_ring *ring;
+
+	/* issue flags when running in io-uring task context */
+	unsigned int uring_cmd_issue_flags;
+
+	int qid;
+
+	/*
+	 * available number of sync requests,
+	 * loosely bound to fuse foreground requests
+	 */
+	int nr_req_sync;
+
+	/*
+	 * available number of async requests
+	 * loosely bound to fuse background requests
+	 */
+	int nr_req_async;
+
+	/* queue lock, taken when any value in the queue changes _and_ also
+	 * a ring entry state changes.
+	 */
+	spinlock_t lock;
+
+	/* per queue memory buffer that is divided per request */
+	char *queue_req_buf;
+
+	/* fuse fg/bg request types */
+	struct list_head async_fuse_req_queue;
+	struct list_head sync_fuse_req_queue;
+
+	/* available ring entries (struct fuse_ring_ent) */
+	struct list_head async_ent_avail_queue;
+	struct list_head sync_ent_avail_queue;
+
+	struct list_head ent_in_userspace;
+
+	unsigned int configured : 1;
+	unsigned int stopped : 1;
+
+	/* size depends on queue depth */
+	struct fuse_ring_ent ring_ent[] ____cacheline_aligned_in_smp;
+};
+
+/**
+ * Describes if uring is for communication and holds alls the data needed
+ * for uring communication
+ */
+struct fuse_ring {
+	/* back pointer to fuse_conn */
+	struct fuse_conn *fc;
+
+	/* number of ring queues */
+	size_t nr_queues;
+
+	/* number of entries per queue */
+	size_t queue_depth;
+
+	/* max arg size for a request */
+	size_t req_arg_len;
+
+	/* req_arg_len + sizeof(struct fuse_req) */
+	size_t req_buf_sz;
+
+	/* max number of background requests per queue */
+	size_t max_nr_async;
+
+	/* max number of foreground requests */
+	size_t max_nr_sync;
+
+	/* size of struct fuse_ring_queue + queue-depth * entry-size */
+	size_t queue_size;
+
+	/* buffer size per queue, that is used per queue entry */
+	size_t queue_buf_size;
+
+	/* Used to release the ring on stop */
+	atomic_t queue_refs;
+
+	/* Hold ring requests */
+	struct fuse_ring_queue *queues;
+
+	/* number of initialized queues with the ioctl */
+	int nr_queues_ioctl_init;
+
+	/* number of SQEs initialized */
+	atomic_t nr_sqe_init;
+
+	/* one queue per core or a single queue only ? */
+	unsigned int per_core_queue : 1;
+
+	/* Is the ring completely iocl configured */
+	unsigned int configured : 1;
+
+	/* numa aware memory allocation */
+	unsigned int numa_aware : 1;
+
+	/* Is the ring read to take requests */
+	unsigned int ready : 1;
+
+	/*
+	 * Log ring entry states onces on stop when entries cannot be
+	 * released
+	 */
+	unsigned int stop_debug_log : 1;
+
+	struct mutex start_stop_lock;
+
+	wait_queue_head_t stop_waitq;
+
+	/* mmaped ring entry memory buffers, mmaped values is the key,
+	 * kernel pointer is the value
+	 */
+	struct rb_root mem_buf_map;
+
+	struct delayed_work stop_work;
+	unsigned long stop_time;
+};
+
+void fuse_uring_abort_end_requests(struct fuse_ring *ring);
+int fuse_uring_conn_cfg(struct fuse_ring *ring, struct fuse_ring_config *rcfg);
+int fuse_uring_queue_cfg(struct fuse_ring *ring,
+			 struct fuse_ring_queue_config *qcfg);
+void fuse_uring_ring_destruct(struct fuse_ring *ring);
+
+static inline void fuse_uring_conn_init(struct fuse_ring *ring,
+					struct fuse_conn *fc)
+{
+	/* no reference on fc as ring and fc have to be destructed together */
+	ring->fc = fc;
+	init_waitqueue_head(&ring->stop_waitq);
+	mutex_init(&ring->start_stop_lock);
+	ring->mem_buf_map = RB_ROOT;
+}
+
+static inline void fuse_uring_conn_destruct(struct fuse_conn *fc)
+{
+	struct fuse_ring *ring = fc->ring;
+
+	if (ring == NULL)
+		return;
+
+	fuse_uring_ring_destruct(ring);
+
+	WRITE_ONCE(fc->ring, NULL);
+	kfree(ring);
+}
+
+static inline struct fuse_ring_queue *
+fuse_uring_get_queue(struct fuse_ring *ring, int qid)
+{
+	char *ptr = (char *)ring->queues;
+
+	if (unlikely(qid > ring->nr_queues)) {
+		WARN_ON(1);
+		qid = 0;
+	}
+
+	return (struct fuse_ring_queue *)(ptr + qid * ring->queue_size);
+}
+
+#else /* CONFIG_FUSE_IO_URING */
+
+struct fuse_ring;
+
+static inline void fuse_uring_conn_init(struct fuse_ring *ring,
+					struct fuse_conn *fc)
+{
+}
+
+static inline void fuse_uring_conn_destruct(struct fuse_conn *fc)
+{
+}
+
+#endif /* CONFIG_FUSE_IO_URING */
+
+#endif /* _FS_FUSE_DEV_URING_I_H */
diff --git a/fs/fuse/fuse_dev_i.h b/fs/fuse/fuse_dev_i.h
index 6c506f040d5f..e6289bafb788 100644
--- a/fs/fuse/fuse_dev_i.h
+++ b/fs/fuse/fuse_dev_i.h
@@ -7,6 +7,7 @@
 #define _FS_FUSE_DEV_I_H
 
 #include <linux/types.h>
+#include <linux/fs.h>
 
 /* Ordinary requests have even IDs, while interrupts IDs are odd */
 #define FUSE_INT_REQ_BIT (1ULL << 0)
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index f23919610313..d2b058ccb677 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -917,6 +917,11 @@ struct fuse_conn {
 	/** IDR for backing files ids */
 	struct idr backing_files_map;
 #endif
+
+#if IS_ENABLED(CONFIG_FUSE_IO_URING)
+	/**  uring connection information*/
+	struct fuse_ring *ring;
+#endif
 };
 
 /*
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 99e44ea7d875..33a080b24d65 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -7,6 +7,7 @@
 */
 
 #include "fuse_i.h"
+#include "dev_uring_i.h"
 
 #include <linux/pagemap.h>
 #include <linux/slab.h>
@@ -947,6 +948,8 @@ static void delayed_release(struct rcu_head *p)
 {
 	struct fuse_conn *fc = container_of(p, struct fuse_conn, rcu);
 
+	fuse_uring_conn_destruct(fc);
+
 	put_user_ns(fc->user_ns);
 	fc->release(fc);
 }
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index d08b99d60f6f..0449640f2501 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -1079,12 +1079,79 @@ struct fuse_backing_map {
 	uint64_t	padding;
 };
 
+enum fuse_uring_ioctl_cmd {
+	/* not correctly initialized when set */
+	FUSE_URING_IOCTL_CMD_INVALID    = 0,
+
+	/* Ioctl to prepare communucation with io-uring */
+	FUSE_URING_IOCTL_CMD_RING_CFG   = 1,
+
+	/* Ring queue configuration ioctl */
+	FUSE_URING_IOCTL_CMD_QUEUE_CFG  = 2,
+};
+
+enum fuse_uring_cfg_flags {
+	/* server/daemon side requests numa awareness */
+	FUSE_URING_WANT_NUMA = 1ul << 0,
+};
+
+struct fuse_uring_cfg {
+	/* struct flags */
+	uint64_t flags;
+
+	/* configuration command */
+	uint8_t cmd;
+
+	uint8_t padding[7];
+
+	union {
+		struct fuse_ring_config {
+			/* number of queues */
+			uint32_t nr_queues;
+
+			/* number of foreground entries per queue */
+			uint32_t sync_queue_depth;
+
+			/* number of background entries per queue */
+			uint32_t async_queue_depth;
+
+			/* argument (max data length) of a request */
+			uint32_t req_arg_len;
+
+			/*
+			 * buffer size userspace allocated per request buffer
+			 * from the mmaped queue buffer
+			 */
+			uint32_t user_req_buf_sz;
+
+			/* ring config flags */
+			uint32_t numa_aware:1;
+		} rconf;
+
+		struct fuse_ring_queue_config {
+			/* mmaped buffser address */
+			uint64_t uaddr;
+
+			/* qid the command is for */
+			uint32_t qid;
+
+			/* /dev/fuse fd that initiated the mount. */
+			uint32_t control_fd;
+		} qconf;
+
+		/* space for future additions */
+		uint8_t union_size[128];
+	};
+};
+
 /* Device ioctls: */
 #define FUSE_DEV_IOC_MAGIC		229
 #define FUSE_DEV_IOC_CLONE		_IOR(FUSE_DEV_IOC_MAGIC, 0, uint32_t)
 #define FUSE_DEV_IOC_BACKING_OPEN	_IOW(FUSE_DEV_IOC_MAGIC, 1, \
 					     struct fuse_backing_map)
 #define FUSE_DEV_IOC_BACKING_CLOSE	_IOW(FUSE_DEV_IOC_MAGIC, 2, uint32_t)
+#define FUSE_DEV_IOC_URING		_IOR(FUSE_DEV_IOC_MAGIC, 3, \
+					     struct fuse_uring_cfg)
 
 struct fuse_lseek_in {
 	uint64_t	fh;
@@ -1186,4 +1253,10 @@ struct fuse_supp_groups {
 	uint32_t	groups[];
 };
 
+/**
+ * Size of the ring buffer header
+ */
+#define FUSE_RING_HEADER_BUF_SIZE 4096
+#define FUSE_RING_MIN_IN_OUT_ARG_SIZE 4096
+
 #endif /* _LINUX_FUSE_H */

-- 
2.40.1


