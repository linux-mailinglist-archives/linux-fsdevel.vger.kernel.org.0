Return-Path: <linux-fsdevel+bounces-40050-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93DDFA1BAE4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 17:48:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32C113AE213
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 16:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2471215958A;
	Fri, 24 Jan 2025 16:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="MAMBMTU1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip168b.ess.barracuda.com (outbound-ip168b.ess.barracuda.com [209.222.82.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C134194A64
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jan 2025 16:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737737272; cv=fail; b=E1TedRJ6KSL7PDzcqNEOqMS1pdbUAI7GxC4Heyfr2m0iRMIUkWjxrVqG1ZODcgSNHwaHh/URBvMfOSCeeSMirjCO5D1DLQqZEd/FGFp23k+nCYZ0GdylPLo/BbcMprKQjhUlx/6Xt4jg6vJlrz9WK/IraAqQv2tZGs7L1z9+GGY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737737272; c=relaxed/simple;
	bh=A4PFhntJG8uOQDXbGbGG2z6CiMSrQ04K3JN7lMyteYI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Pzz6EWSSGU7waL0OMD/d0/U2VA+ps+uRqUhwkRz7C1zDUpWV8OB3iwf7VWcuBk6csWknahB+ESJmiz70IhPwG66U3uRKaZNtB0+z6g0qBJyk2I+bMrpPP7S8KdZATqQ3AoZBTi582sZXgpFqhqxL5n5/4UyquHchZaa+aNoIQY4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=MAMBMTU1; arc=fail smtp.client-ip=209.222.82.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2047.outbound.protection.outlook.com [104.47.73.47]) by mx-outbound41-29.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Fri, 24 Jan 2025 16:47:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UcHJSFEid+6v3OoZsgLHu13Uo1+L9TuK8C+VmG13sx55rhe5nz6Y85W2txtK83DYmQVPFYs1vdHPgapzMBy2xwFqxs+ChiXWGcuwuAW7Y9YHP95707FY9939RmiTbR2Z7IotWVOdBBX6BXSxHyIwifwZCfMruedq8w/sR/uSbxlBwICaA1++gLhcjWegyq7Pz/11D1VGSCrNM4hOHvqg3S/R+pcwm23nohpVlgRpEo3oYLWhgNrWtHTFtQGNCi9lgERoUmWmW+Gnf/4jf4kssaV8ve7JWPPBKzY3sjTt/jodwU8lHOFfC9EoEItRfzLbuYj/qFh3dSA6OfEf7Udorg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K774j8oyKpgyBrhTSxUGdweMSUZ7fRhDIIYcc+L8rzc=;
 b=srExYae2vJCcnwy7g59bZ/vQ10rmwihTSC8i42lcw4iqSQ48p0I8P2xX5k/1CETWSYbXU22uaryS92NXkCJT8rKgBbkNjS3MffY0vDj9HTOJ4Dso1TGeHAe7O0G4cJu4rgPJpGWb4vQEUi4taCgGmPZjer/y+eWa77JNgb4JHJlWuMYJIMUXFQb4RyUNan6stYrOM404aS5KMJ5JJtngXgzbT6WcsXTeeXXM41yqCBcsDUbKhw3kUjEAgP6VP2zIE1gF9xbIUtj8zEH09Z53l1IVBxkhhlruf7BMjdfUG5+S+wrzN7fcxtQdG2sOUBwqEoWGK3dCqVpFVcovT5qk9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K774j8oyKpgyBrhTSxUGdweMSUZ7fRhDIIYcc+L8rzc=;
 b=MAMBMTU1U09fIPqJuGGrdhZXoJUNWnJZK5S4jc7jt6gYtqDutsSRPupn+7x3fIqokbw7SJejeMnTclUVkr5GrdvPoeDMeT2LTxPzgDHn9ZTeAu0AbDRNx2WagVFYMRBcJWkifKAZpJ7UJQR9YhXOr/LA+UBQvDEjPUjRTDcSlPg=
Received: from BN0PR04CA0090.namprd04.prod.outlook.com (2603:10b6:408:ea::35)
 by SA1PR19MB8072.namprd19.prod.outlook.com (2603:10b6:806:38c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.18; Fri, 24 Jan
 2025 16:47:15 +0000
Received: from BL02EPF0001A0FC.namprd03.prod.outlook.com
 (2603:10b6:408:ea:cafe::8) by BN0PR04CA0090.outlook.office365.com
 (2603:10b6:408:ea::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.20 via Frontend Transport; Fri,
 24 Jan 2025 16:47:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 BL02EPF0001A0FC.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.8
 via Frontend Transport; Fri, 24 Jan 2025 16:47:15 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id 016F4E1;
	Fri, 24 Jan 2025 16:47:13 +0000 (UTC)
From: Bernd Schubert <bschubert@ddn.com>
Date: Fri, 24 Jan 2025 17:46:52 +0100
Subject: [PATCH 2/4] fuse: {io-uring} Access entries with queue lock in
 fuse_uring_entry_teardown
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250124-optimize-fuse-uring-req-timeouts-v1-2-b834b5f32e85@ddn.com>
References: <20250124-optimize-fuse-uring-req-timeouts-v1-0-b834b5f32e85@ddn.com>
In-Reply-To: <20250124-optimize-fuse-uring-req-timeouts-v1-0-b834b5f32e85@ddn.com>
To: Miklos Szeredi <miklos@szeredi.hu>, 
 Pavel Begunkov <asml.silence@gmail.com>, Luis Henriques <luis@igalia.com>
Cc: linux-fsdevel@vger.kernel.org, Joanne Koong <joannelkoong@gmail.com>, 
 Bernd Schubert <bschubert@ddn.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737737231; l=1883;
 i=bschubert@ddn.com; s=20240529; h=from:subject:message-id;
 bh=A4PFhntJG8uOQDXbGbGG2z6CiMSrQ04K3JN7lMyteYI=;
 b=+uSHKtz9SKX/naCOJ6SuQwLwj5TNQ5GLMkfUSDl3FTClAS1hCFAoEji/IDe7z5QNSNdPdcIE0
 XZCSWLeo52jA0BCRFnaRf/PsxBKEtHSUh9t9l34O1u9FUtCspIr3wUt
X-Developer-Key: i=bschubert@ddn.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FC:EE_|SA1PR19MB8072:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b1023ec-42cc-4b78-6b26-08dd3c96c1e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZEVpaEZkMU9JdkZzUG5xSlNKdy90TTR3UU55cjBUSkE3SDBTTldMckU3bnlJ?=
 =?utf-8?B?QWNHbktiMmZtQktGdGxRR3VYek9MelB3N2wvRTU1bldjZ1hKQjF2MGQ4UHU0?=
 =?utf-8?B?UU02TWpzRy9wUnVwMjBubUo3czBRMXpnZHJSRENyQ2NrRVlVTUg3UmpzV3Vt?=
 =?utf-8?B?Q1VDN3YxT29LVk5ad3VjdmpybDhSVXA0bmhaY0RlckxWbC9iWVNoWUs4NWFU?=
 =?utf-8?B?MGhzbWt6cWdoV1dTZ2R3ZlVBdDRUODJ6aWRIbW1EajRkeDgvMmgwNjlzOE1L?=
 =?utf-8?B?d2FxMmtkZjVOVStYbU1pNzRKa25XT1B1eXZHUXhtWXZpeC9jSzBYeTNXdWY1?=
 =?utf-8?B?RWdZMy9CcWJtMVpLVXF6cEhjSnZ0Ty9GZm1weW10OVpQWStkdmNMNW5qWDVX?=
 =?utf-8?B?R1hFekhpYWl2S3ZwNmk4WW83dTgyNWY1Ykd2Q1hSSFRTT3kyTmJPQStsdkIr?=
 =?utf-8?B?ajRDWmhxY3VHSjhWaStwMHZZakJOWWh3WXhGTVJEeU9QMG5hSi9RVkN1R2JW?=
 =?utf-8?B?QTFrQ3BQY0JOMk1LOFFuVzRLTVBxaXlZZXJ5SW1Xd0huMGU3Ry9RdlYrV3hD?=
 =?utf-8?B?NzVlU05Hc3ZXVGhPclVwWTJiZ0Evb3U2M2MzdTFxZkRNWHlWUnFDNENQczlp?=
 =?utf-8?B?aHZ4NC9idlE2Zk5JUUw5Y0tpZ2V5UmhJaExzVFlSRUJ6NVh2MlFCcW56NFR5?=
 =?utf-8?B?YlRQa25UY1dTVFYrZTlSZStBR2gyT0hCTkJ2UWNvWXovOWJDa1ZhenlkbS9t?=
 =?utf-8?B?U0xYWTAwdEJ2a3BUSW9qNnkrakxwa2RWRTNzT0Jpb3d2SGI5TThSTDZ0RVBq?=
 =?utf-8?B?VmNyZ1ZtN1FtYzNtcGxRVFZIMytTb3pUbUlXRUJzcVJPb0hhaXVReTBlL2po?=
 =?utf-8?B?TVZOSlZsSkFWOXlvYTNLS2FwSTQ2Z3g5NDA4d0JyaHN1ZHp5WTdyeHZYQkNt?=
 =?utf-8?B?SmFHdzEvWGhULzJwMzV4SGtzSitVR1A2TmlTQVdpRFhORFdLSVQ5bmRqUEdJ?=
 =?utf-8?B?VnJMeXh6eit0UERvSFBOUXIzSVNiOUFEaGRTSllhWUFXRExYSmdxMWNiN2ow?=
 =?utf-8?B?Q05FcFR2eENIeVgyK2RTNUhTemhFbFNlVm9WNG5vbjFvNEJLUDhibHcvYXBK?=
 =?utf-8?B?cWwzNHJ5dTdNMkJlemZaRS9uTjZKUUJreDJQWTZXT2dOeTRWRVFTc2JEOXQr?=
 =?utf-8?B?Z0FObEN1eTZyVTBMbGdOdFFPUnFFbXc1b2JQeVNnaWRXbGJBalVQTjZaSlBY?=
 =?utf-8?B?S0hZYklSbFhsWUJ3bno5eStlL3dSelQrZjk5VFpiK3EzYnZiVWRDK2tkaTZT?=
 =?utf-8?B?YjRJVVFSdVNGVlVpTmFKYUc1bGUwU3FDZzdtZkkzMjJONGVobWF5a3lNZEJP?=
 =?utf-8?B?QW5oUTRxcmwzckoxYUJxWDJwMFBOKzI4U0YweUNiV0ZFRUJJSys0QW42a2RT?=
 =?utf-8?B?OFhpNGtDSktJMW5zcWZacEQ4NkxDOHN2aHA1L0Q4bFMxaHdXelg2RVBjY2tw?=
 =?utf-8?B?N2xiSmkxRjFFUENLcFdIVkpmNG8rS3BybHBhZjBXMm5DcU9YemxmUnJlNHA2?=
 =?utf-8?B?bHdZV0w0eUdWQzB1NGlnRFZaL3BWckJyZFpGWnovSWQrVmNHaWxhdkt6SEZY?=
 =?utf-8?B?NncrZHVScG1BN3lvQmJLRWhUN0RsWXFKR1MxeE84ZXJmenF6aEV3TnQvV01h?=
 =?utf-8?B?REdhTWtBd3RwVjhuR3dhTVJSMmwrMWFySnNpOVBZQ0M1WC95ZVRseTc3NUl5?=
 =?utf-8?B?alhMTlFKQUgzSkZqZWNqcytwQUdoSzJ2L2dVeGJHbzVSMzFHVmZ6ekU0a0Jh?=
 =?utf-8?B?Wkp2Rlg0VzlZRGJrTG04bXRlSjEyZVFRRkIzQTFITUQzRzErYXg4eHkwREFl?=
 =?utf-8?B?VEpEUWxjMVEwZ3V1NzV1N1FNcjdPZFhEU0xMNGdPZ0FLUm5PQXY4MmFrYlJp?=
 =?utf-8?B?c2pyZ0NnU29SUEE2WXltdkRhamttRUNPd0U4ODUrcGFERWtWaWNxcFdDeFNz?=
 =?utf-8?Q?k3AmRXkhUZEFTzKoTLl+XiHV2gMi9E=3D?=
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	em0Dw2hPcnA8cC+iq7kIc7DHszhVBbmWE4lL6d+5zVdZJpWce8Qtl4CKmtkm6Q4NVHyZ0SgGhoWiWGJjCvtIKQhQFumkbYwiI4LAsd8D5bZ1t+N8Rfyr0yHTmWM8spe/1FPfh8reLYXxPRCXPmCenDpHGNC5eqGI4UoPbZ2J+JR90C30Eby2LFNq8Zpy9X1336S684nbGpwfa+jDjhR+wrksmxFTB7RvdvfAF0+bLmPx7xKJ/FosrB/VYoTig9CIHyC6f001j3u/QnUJe4M2XH5a1KhXIns7TzQJ6z/GjtXTqW86EAT+maRWQjGW8td7y89DB/WqPxRnIqo27yEuKF1C3E6H9xC69Lc2UggvKZknUh7XsRuCwN+C9Nla00pund2rRO7xONchAfHp/IHS6ruoS0ne6zzKP5sjGfJkQzh6E8Oh1XnuI6FZsIQbKooWB897oFvIMTfIX9tG/0Uc7mjdP7NPd8Ut3ttmXSCxn93fKyqIYx8AI5F6hJVC9DddwUHiIGOr8OA3UckuRhudKxzu82zS39Niq3tJKZsdq+goBb6YDHDQ5y9tNdNT9GeRFi1cHkLAqRObWOUwqs7+y+OHZNSSXiw03OGaU7yjY6RmkDbjcdbXJBjAH3fEOUdxWCv7/GNu1vObRMcnaMBIlQ==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2025 16:47:15.0674
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b1023ec-42cc-4b78-6b26-08dd3c96c1e2
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR19MB8072
X-BESS-ID: 1737737238-110525-13388-117-1
X-BESS-VER: 2019.1_20250123.1616
X-BESS-Apparent-Source-IP: 104.47.73.47
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoYWRsZAVgZQ0DLR0jLZPNnCyC
	DRwszAJMnQ2DTFxDDVxNjAMjXN1CBRqTYWAENfEmxBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.262028 [from 
	cloudscan20-157.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

This ensures that ent->cmd and ent->fuse_req are accessed in
fuse_uring_entry_teardown while holding the queue lock.

Fixes: a4bdb3d786c0 ("fuse: enable fuse-over-io-uring")
Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
 fs/fuse/dev_uring.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index 1834c1933d2bbab0342257fde4b030f06506c55d..87bb89994c311f435c370f78984be060fcb8036f 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -315,14 +315,20 @@ static void fuse_uring_stop_fuse_req_end(struct fuse_ring_ent *ent)
  */
 static void fuse_uring_entry_teardown(struct fuse_ring_ent *ent)
 {
-	struct fuse_ring_queue *queue = ent->queue;
-	if (ent->cmd) {
-		io_uring_cmd_done(ent->cmd, -ENOTCONN, 0, IO_URING_F_UNLOCKED);
-		ent->cmd = NULL;
-	}
+	struct fuse_req *req;
+	struct io_uring_cmd *cmd;
 
-	if (ent->fuse_req)
-		fuse_uring_stop_fuse_req_end(ent);
+	struct fuse_ring_queue *queue = ent->queue;
+
+	spin_lock(&queue->lock);
+	ent->fuse_req = NULL;
+
+	req = ent->fuse_req;
+	if (req)
+		list_del_init(&req->list);
+
+	cmd = ent->cmd;
+	ent->cmd = NULL;
 
 	/*
 	 * The entry must not be freed immediately, due to access of direct
@@ -330,10 +336,15 @@ static void fuse_uring_entry_teardown(struct fuse_ring_ent *ent)
 	 * of race between daemon termination (which triggers IO_URING_F_CANCEL
 	 * and accesses entries without checking the list state first
 	 */
-	spin_lock(&queue->lock);
 	list_move(&ent->list, &queue->ent_released);
 	ent->state = FRRS_RELEASED;
 	spin_unlock(&queue->lock);
+
+	if (cmd)
+		io_uring_cmd_done(cmd, -ENOTCONN, 0, IO_URING_F_UNLOCKED);
+
+	if (req)
+		fuse_uring_stop_fuse_req_end(req);
 }
 
 static void fuse_uring_stop_list_entries(struct list_head *head,

-- 
2.43.0


