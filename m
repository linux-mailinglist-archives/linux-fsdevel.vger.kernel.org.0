Return-Path: <linux-fsdevel+bounces-20473-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4395E8D3E6C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 20:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA3EBB22CF3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 18:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EC171C0DE6;
	Wed, 29 May 2024 18:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="mWbKT+HW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip191b.ess.barracuda.com (outbound-ip191b.ess.barracuda.com [209.222.82.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389341C0DD0
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 May 2024 18:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717007674; cv=fail; b=W0sUntyL/Wdm/DkCJlYTr4uZQd/juBmp5eM2XiiiCPap+9MBqz0GEyM276CBIlORixGR1zCngdLYVKLwNPjrmuY2htweIrKu8r2Ta74sN2U+1MnPxS0kKXsd1/zhqTs/koUQxwCixpyjk+A3/SoisypVD+q6lBV/CmFjGI37Ls4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717007674; c=relaxed/simple;
	bh=peuavuWDg6/F1rstWppmqi4fhIXHPXqJjVSujb8rG0Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=urJALOCxT2qDZA1bHYAgldljned5W5Kk9+FbA3JeWYIvOr5Uyvqic2WJ1rz9TFaiMD2pfj/ffNzGg4kk567fBohiQe5uO4AAO9xgZRtLHvJvRjed33P7/Fs32O2XMI8wslVCoSBhsHLueuR3E7XF11aMRB4dH3zpNTYPiqrsvqw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=mWbKT+HW; arc=fail smtp.client-ip=209.222.82.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100]) by mx-outbound17-84.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 29 May 2024 18:34:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lrjz+/OL6RZFm02vOdzOcgE27Z2oqxUqAxfxnnfxLQ44auAfLIVzsstWBocMA3Mmcaf0Bg1nizAU9t8ipOnheqcKWTJx0MTLh1ch5iTfnvHA2eo457zAhip9X5yMFxJUxDe964/vZaxr0smT8FDTI2DKB57UXp3ucIxlPsgBWvLAwN2+nFMDV8diZf9H6UJVz5Zoz7BznTzENXJ+suxTYHpDLkYS5rL67NiO6rKH7v0F/w8iBxewliX9CKgPRdq5l2Z7zm5Sj52qLnXjRTAuB21SiUtmncYG3sLckSIpf5utRsd9ToIwLnRMpFJ+0pbUbuKN4AivqAZYnG6XMJcuGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MwaQa/OaVGNrDMOeRXemJgYoo0zuNyAJRQoBYiIlNew=;
 b=HogLoWLyALaCirTe53okbi8iAQ3p7dpjOyrHUH7tEdkL5mPdOgD3Txyv7pjwyXrIZvXNlLnW7Smsj6e0jtnRRnXVCxTA+Hw+z8rax+TDqdddCHJcQO9zX4I9OH0sMDjRERh0uFs+f490hcjkNxG8pun6w2SRooB1lfzW6N64wnrtD5zFwYlmZY2PcEsm7YeDljdZEMczTIGLWzqREj0soAgw2XvIXTepNN/m3InqzUIkGS3iZ9VECjbY1vgNoCc3Q/fXkuzMecBe0urOjIqZd0v3z5K7bDLccKVmICojuGslYjitTRTvQzhe58xUL5z2WIR/IsA7FXRJfIoYsPS8Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MwaQa/OaVGNrDMOeRXemJgYoo0zuNyAJRQoBYiIlNew=;
 b=mWbKT+HWvFY1BjLwk8rwhxlsrpj/m4Wc4/TPUCLVfwox6YIYBjZDIOq4qdMFHp2s9MZpV0+dMIkvMhhvMMiAyvsUYPYgZyEnZ1hzILeCaT3i0Fi/ImYjdWNcshigLQhmVqkVeyXzjcv18JzTOtxVC6Kbr3Z3en2bs4qr9lsIjaw=
Received: from PH0P220CA0014.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::28)
 by SJ0PR19MB6897.namprd19.prod.outlook.com (2603:10b6:a03:4ae::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.17; Wed, 29 May
 2024 18:01:06 +0000
Received: from CY4PEPF0000EE34.namprd05.prod.outlook.com
 (2603:10b6:510:d3:cafe::10) by PH0P220CA0014.outlook.office365.com
 (2603:10b6:510:d3::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.18 via Frontend
 Transport; Wed, 29 May 2024 18:01:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 CY4PEPF0000EE34.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7633.15
 via Frontend Transport; Wed, 29 May 2024 18:01:06 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id C567D25;
	Wed, 29 May 2024 18:01:05 +0000 (UTC)
From: Bernd Schubert <bschubert@ddn.com>
Date: Wed, 29 May 2024 20:00:52 +0200
Subject: [PATCH RFC v2 17/19] fuse: {uring} Send async requests to qid of
 core + 1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240529-fuse-uring-for-6-9-rfc2-out-v1-17-d149476b1d65@ddn.com>
References: <20240529-fuse-uring-for-6-9-rfc2-out-v1-0-d149476b1d65@ddn.com>
In-Reply-To: <20240529-fuse-uring-for-6-9-rfc2-out-v1-0-d149476b1d65@ddn.com>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
 linux-fsdevel@vger.kernel.org, Bernd Schubert <bschubert@ddn.com>, 
 bernd.schubert@fastmail.fm
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717005648; l=2986;
 i=bschubert@ddn.com; s=20240529; h=from:subject:message-id;
 bh=peuavuWDg6/F1rstWppmqi4fhIXHPXqJjVSujb8rG0Y=;
 b=XMo/A9mQJ6prhSRwSBesFLe3o7FtCAyEIdt2xK39m4n0AwdD9YikFmD3U93swj8z/GeE4imxp
 n8UeWOb8025CjWxosHS5eCauK8n4rXtq4NN9BNvxZPCAZF7JejzIUVB
X-Developer-Key: i=bschubert@ddn.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE34:EE_|SJ0PR19MB6897:EE_
X-MS-Office365-Filtering-Correlation-Id: c7ca7a9f-24b7-4df4-98b0-08dc80094fe2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|376005|82310400017|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?blJQdW5kcExmWUx6aFJMWHZqMWRaaFhYS0RmTXhxS3hpRHpTai9VOWZjYUJn?=
 =?utf-8?B?NWJYalhtSFBlZTVmMzBjb2RQTWFHckV6UFpZOC9ybDhnVDhxMXVhWXY4Uzgr?=
 =?utf-8?B?M1UxVFA4ZVdieHFXYW9mRjlwbjduTjlsQnpyaWtiZmdKUnVYVmN0Qmlrd05m?=
 =?utf-8?B?UGVxZHIyc1o4bis0OVNHNkxpQkh6aEVsMHdJWm5UbWtPdXI0djV5YVJNQ1Fr?=
 =?utf-8?B?RnNuOXJySFJvQURldUg3UitvWERmWmpFUHJzYWREY2tmUnVHLzc5Yy9udjd1?=
 =?utf-8?B?cHV3Zm1ucXJkOVZ5TGhpRUY5Ym93b2JWUXJab0JZRkNDU0FPbTNHaURXMFNx?=
 =?utf-8?B?UmNaaXhwY0dEQzNsTXp2QTFBY0JJeVBlQTQ1a0w1NGxSZUwrQ3FScEcvREtI?=
 =?utf-8?B?UEhreDdVSWJIUXBLc3JpMHdlVGE4MmQ4MWkrOHVPS29aTW54eFRXelhZRzFr?=
 =?utf-8?B?cW02MnJNUWRyUlRuQ1d6QmV6ZWpDWUI0WVdOb0pPUU9TMG5DRjJwdWV5ckhi?=
 =?utf-8?B?MlZiNzhLaWlPRm45Z2l6d2N2SnVSZUM2RmRUVWNtMk05UHhYZm04VWhvejN0?=
 =?utf-8?B?VE5Ld0hkd2YzMUtUUkdYcmEwSURDazlnc1VSVkNZMEk4Kzd1eXc5ZWd4ZE5I?=
 =?utf-8?B?YWhWdm9KUFU3THZjenRRMlE4VHFVOEI2OTdrNHY0cTNQYk40QmZibkRwWnVK?=
 =?utf-8?B?ZmhTTXNXM2xzS3A5WVlJRVlDd01VNmRHclJIaFRFa2ZhMkhESERDRnFTQytw?=
 =?utf-8?B?UnJnTEYyTC8rYnhPdVBYSWhLUE9xNlFyWE9zRTdHUzYrd2ZsUmdEMENpbE9h?=
 =?utf-8?B?T1ZEM0RLZ1IzS1p2RGFsV3FEUUNZck1YYnQ5c21NNGszVG1lYW9SNmlYMmkx?=
 =?utf-8?B?ekhhVnJ4NzZjV3NGV1lvTnY3RWlpM3BYRU1wUlVLUnJCRC9ia0NBME1Db0xu?=
 =?utf-8?B?NWRFU3ZBTGRFRWJDUFllZWpoM3djeGJWQi8wdG5aZ1FjanZZUkVuNW0xZENq?=
 =?utf-8?B?aUJMSTJCeVhFbE1OaVlWd0hFaWlWRnRDZUhoSWZZM0hHUzlLUEE1LzNtZnQz?=
 =?utf-8?B?cDliVWdxRGVKcUFTMVJST3hUM0Iwa1JZZ0loR3paU3VvK3VlejZsYXlFbC9O?=
 =?utf-8?B?eHg3K045R0MrcXlhNTZaeUcvOFEyaUx6c2VpQTREWGtZNllqRThTMU5SSUpr?=
 =?utf-8?B?a05VczMwUEFaOEN1YnI3a0ZnNGZCSXNyLzJxOHZNTE1MVy9BamgxOStINmpN?=
 =?utf-8?B?VEk5RHMzUDN6UUo0MjA5d2lvQ3I0L1VGZmVDUmxROTB5dEd0WDcxcVlrdDNT?=
 =?utf-8?B?czJQOTVTaU80N1hGUlI1VUk0QlExZ29ZdXlEVExGWUtCVEZ2Q25JUVJBaGg3?=
 =?utf-8?B?NnB0RXlJMzljRXkvcmIxb0J3TS8vWXJ5N2dkWVZWeUc0b2hHa2gwci9qUTJD?=
 =?utf-8?B?RWhPTmE5YThWYzZWbFdwV0MxdEd1ZzA4R1RyenR0NDR0Q1lkalJiR25Fdzh4?=
 =?utf-8?B?YU05dDlIUzRwMnkxdUFjc2x5WCtaZGloYW14YmdFczYwRkpraFVveDczRjgx?=
 =?utf-8?B?WEs4YnlaUTlIMFRaODI2bnc2WEc1Y0ZwZE5zSFQwNlkwVzdlaWxZY3U0ckVL?=
 =?utf-8?B?M1Zad0JzU2lBWEt4SkRwNVU3dXpBemRlRERDbFV5ZVZ4cmMzYjA5amF5M2cr?=
 =?utf-8?B?bTFkSnlTZHZZTmZGcVJ1OTNBeXV2OFRIWDhPalZ2WDQySEpMNUxob3NUQXNX?=
 =?utf-8?B?MDU2eC9IakZVWXRscmVER0ZMSDRhcGorWi90eWJ5T3J3WHcxejYrdVBVempK?=
 =?utf-8?B?dE9yTmVaZ29wQ1gwOW5YSko1MlF4OXRvbC9Pc09iSXZkZFc4RnJ3UDA0TmVL?=
 =?utf-8?Q?MbyPizx9bajAH?=
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(376005)(82310400017)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	UCwf7lZhZDBBmU4cuhW9KXB95dgc+34/l4bE6YA4Zu0QXI2CW8IS/4d+lT+Q90S5aCmMGDOh1f1dToDHcQQiHyGqI2+r1evArMF81EsyH9wosudVKcs4rLqblIQR5o1Dxk4iAwEqQ9pr0lVBZQPV8+6JS1hKsA9hyv4FEsU5K7YUJXqLRRGtDq/vmcArAYZpHHhLkvMnB5ewzfwx8VzNalMAma8uGHqeUuInLPicJFhMvCOgUsvttCnf8MrG3n4PqvPz8KJYSOta+K9ks88gzBL3/foIvx5VREZXSJzA+Hy97T7uhEAMTUIK8KcVjSYwUl/g4cXe5UpK1p4bmDUZsV7L3zHstToChqwetRtL8EDVLbqg/vAZfClE/GC7o+iyup1bdg4U4brTM+qYJz+KOyQUW5Lrcp99i/CtoNO0jnM9GxJPzIACUcHJkIZyBqQRbD5BFSq2JEiSxQqvqUDLSvoqq3bkCazgvPh6GQ5qjLFldZu+Z64QShYcxTIcx3VLPlgeUu1O2NE5wU8YMkMlezq+WATgAbqFou47fJW1LIjRHCz/1/1w2g3KluxaAa+jl9LzzTZgmtrATbr+2MXd9BQEkSGISUDnsmpujJGFOh6Mal4x74+xGKbfsKvhC3LbzLH+Mj4EhA8JtKyh2viU2w==
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 18:01:06.2610
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7ca7a9f-24b7-4df4-98b0-08dc80094fe2
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE34.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR19MB6897
X-OriginatorOrg: ddn.com
X-BESS-ID: 1717007671-104436-4473-1004-1
X-BESS-VER: 2019.1_20240429.2309
X-BESS-Apparent-Source-IP: 104.47.70.100
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVkaWBuZAVgZQ0NTUJM0oLcXEzC
	Il1cIw0czAKNnA0DzFxMTUyDAtOclcqTYWAH6DsiBBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.256584 [from 
	cloudscan18-74.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
	0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, BSF_SC0_MISMATCH_TO
X-BESS-BRTS-Status:1

This is another performance optimization - async requests are
better served on another core.
Async blocking requests are marked as such and treated as sync requests.

Example with mmap read
fio --size=1G --numjobs=32 --ioengine=mmap --output-format=normal,terse\
--directory=/scratch/dest/ --rw=read --bs=4K --group_reporting \
job-file.fio

jobs  /dev/fuse	uring   gain    uring   gain      gain
                               (core+1)
                      (to dev)         (to dev)  (uring same-core)
1	   124.61   306.59  2.46    255.51   2.05     0.83
2	   248.83   580.00  2.33    563.00   2.26     0.97
4	   611.47  1049.65  1.72    998.57   1.63     0.95
8	  1499.95  1848.42  1.23   1990.64   1.33     1.08
16	  2206.30  2890.24  1.31   3439.13   1.56     1.19
24	  2545.68  2704.87  1.06   4527.63   1.78     1.67
32	  2233.52  2574.37  1.15   5263.09   2.36     2.04

Interesting here is that the max gain comes with more core usage,
I had actually expected the other way around.

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
 fs/fuse/dev_uring.c | 5 ++++-
 fs/fuse/file.c      | 1 +
 fs/fuse/fuse_i.h    | 1 +
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index fe80e66150c3..dff210658172 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -1106,6 +1106,8 @@ int fuse_uring_queue_fuse_req(struct fuse_conn *fc, struct fuse_req *req)
 	struct list_head *req_queue, *ent_queue;
 
 	if (ring->per_core_queue) {
+		int cpu_off;
+
 		/*
 		 * async requests are best handled on another core, the current
 		 * core can do application/page handling, while the async request
@@ -1118,7 +1120,8 @@ int fuse_uring_queue_fuse_req(struct fuse_conn *fc, struct fuse_req *req)
 		 * It should also not persistently switch between cores - makes
 		 * it hard for the scheduler.
 		 */
-		qid = task_cpu(current);
+		cpu_off = async ? 1 : 0;
+		qid = (task_cpu(current) + cpu_off) % ring->nr_queues;
 
 		if (unlikely(qid >= ring->nr_queues)) {
 			WARN_ONCE(1,
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index b57ce4157640..6fda1e7bd7f4 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -791,6 +791,7 @@ static ssize_t fuse_async_req_send(struct fuse_mount *fm,
 
 	ia->ap.args.end = fuse_aio_complete_req;
 	ia->ap.args.may_block = io->should_dirty;
+	ia->ap.args.async_blocking = io->blocking;
 	err = fuse_simple_background(fm, &ia->ap.args, GFP_KERNEL);
 	if (err)
 		fuse_aio_complete_req(fm, &ia->ap.args, err);
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index fadc51a22bb9..7dcf0472df67 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -309,6 +309,7 @@ struct fuse_args {
 	bool may_block:1;
 	bool is_ext:1;
 	bool is_pinned:1;
+	bool async_blocking : 1;
 	struct fuse_in_arg in_args[3];
 	struct fuse_arg out_args[2];
 	void (*end)(struct fuse_mount *fm, struct fuse_args *args, int error);

-- 
2.40.1


