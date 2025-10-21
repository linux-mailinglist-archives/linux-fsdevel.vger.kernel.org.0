Return-Path: <linux-fsdevel+bounces-65004-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 90DB7BF8F18
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 23:33:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E3D16351EF9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 21:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 150D9296BB7;
	Tue, 21 Oct 2025 21:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="rHq5aciZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip191a.ess.barracuda.com (outbound-ip191a.ess.barracuda.com [209.222.82.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49F915C158;
	Tue, 21 Oct 2025 21:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761082427; cv=fail; b=TgxvLndPjgBzOK4OmV78I8EutRnjus40TaUq34+ruesThdEj/7vGZXpRZA32d+ehyBHRs8Dxoh3aSpA99u8aveigv9lTqEHaXbNK58ngC1B0DKTVAZLe3Wpa1cHiwg8IolY5k71I3O23kVf0WHMsLM7gX1AU3vlynYuyBTxipuk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761082427; c=relaxed/simple;
	bh=0DQ5B4dYwtSQR19JaagUIHuWalXk/6+wzSiO3SlbC08=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hnixi2h/QgkG5bPwFxrEeU29iO+Tm3DWjdwXGsB2kfCk6EmqVQRmiKT582qWq1OkAs9HZdjM4Bq+kl9cjyMUXkmdMxZQp72sP+SSwdD2tiOFOb8rYZOLOUoKtwi818hzkjC4PNE0oa5ae70Hwljst6uwSnc/mEJ9gu64hjO460E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=rHq5aciZ; arc=fail smtp.client-ip=209.222.82.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11020078.outbound.protection.outlook.com [52.101.56.78]) by mx-outbound11-23.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Tue, 21 Oct 2025 21:33:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XeNN5xdg89AxVGdYg/rGTM2gnqNlQ9Q9gjwthlFDbWNeRbfqOf2iXKwLHom96Xt/saOadII2mAht7+0Q9nSI5sHkqppSPol0uOCpV+Uzpo5U+DmK3eAl4SukyGnmVD7XnQTINwNMbjKTyNy3dUi3FvD7YiQrWyaxZJCqdpblFuqvOogcJTSsdWMhabcYwxKPn5D1ky8NfJWzX3qyAPJSkYGYlMwH4GLAPMB36cBU8Ecj9cktPvU7VplnRWQ1iT9YyCd5H7ECjR6pjKOmrvVgDZJQfqNBuCRQQTiITHffyAe5IgJjX+jTXdphwV6TSnwdJPz9D1uOW1LLH5XSN0dQxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sK9WnOidYGWyeiE+NLpLJmcgQKAkmA1OeTCPfsEWPTM=;
 b=R8VNPTFCjxKO1uvyzybAr4jR4EMgVzs8vakdsEZwjGrsk8/s2wgsadIv042ASwi+9QSwvRqwf88nfrl6BgQpvApjQcfvswLaM49mGogeUbNQhavo7Eek4ICEw1JWROaHgaYr/QI/gzzQgWyWfuFCo7AwKksd1vY22Qc3HD6KingZX7+8R92Uu1cNcIc4Z1iDvCGGvueqLb1PwPomICBRNxlqOVh+Rw8BiM590f452GVLNL/qE/07JL9s5qSpdSadkdY8TibXmHKFc0Z9j6DfZiFDYqZcN+Dv1Q9I83NH2q4brg6CR8qcP+3/t9lWgpPRww62DLuJaLoxlMpVnwaoAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sK9WnOidYGWyeiE+NLpLJmcgQKAkmA1OeTCPfsEWPTM=;
 b=rHq5aciZFzorliQddKEHuuaQv5vqg+hIqETJn5aQL3TLiZUMQs1ZXd/o+dqtK6BzlFkS2OG1CGUkBEbc+zTL61tNclwhhH/uWcmjiLOnrt4HsdpT5mvGS4DswHcm4jH0BEJi2xSr1PF1Tu1hbKnUnTSu1PhhmPq3C7uHtxZadsI=
Received: from SA1PR04CA0010.namprd04.prod.outlook.com (2603:10b6:806:2ce::16)
 by IA4PR19MB9042.namprd19.prod.outlook.com (2603:10b6:208:54d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Tue, 21 Oct
 2025 21:33:35 +0000
Received: from SN1PEPF0002529D.namprd05.prod.outlook.com
 (2603:10b6:806:2ce:cafe::5a) by SA1PR04CA0010.outlook.office365.com
 (2603:10b6:806:2ce::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.12 via Frontend Transport; Tue,
 21 Oct 2025 21:33:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 SN1PEPF0002529D.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.7
 via Frontend Transport; Tue, 21 Oct 2025 21:33:35 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id A863381;
	Tue, 21 Oct 2025 21:33:34 +0000 (UTC)
From: Bernd Schubert <bschubert@ddn.com>
Date: Tue, 21 Oct 2025 23:33:31 +0200
Subject: [PATCH 2/2] fs/fuse: fix potential memory leak from
 fuse_uring_cancel
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-io-uring-fixes-cancel-mem-leak-v1-2-26b78b2c973c@ddn.com>
References: <20251021-io-uring-fixes-cancel-mem-leak-v1-0-26b78b2c973c@ddn.com>
In-Reply-To: <20251021-io-uring-fixes-cancel-mem-leak-v1-0-26b78b2c973c@ddn.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Joanne Koong <joannelkoong@gmail.com>, linux-fsdevel@vger.kernel.org, 
 Jian Huang Li <ali@ddn.com>, Bernd Schubert <bschubert@ddn.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761082412; l=3702;
 i=bschubert@ddn.com; s=20240529; h=from:subject:message-id;
 bh=MRyOYBJNTdSLAem8bBZA1eph0FrautKc4/8SzNoZcbs=;
 b=A82OA0hZHROsT+beJ8T2YA+Rni+6gccsJKDYM+tn0EXN6s+iYKGlW/IJ6GzipIaSsUAITdAMy
 SbohS5bwQK0Axaj3eG2p5QzcIOKjUxKy/OwqRIGQTsnXN3x180lI4eD
X-Developer-Key: i=bschubert@ddn.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529D:EE_|IA4PR19MB9042:EE_
X-MS-Office365-Filtering-Correlation-Id: 54dc9288-1ca8-41e6-6653-08de10e97dae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|19092799006|1800799024|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eWV0NVUyRTRMcWVVNE5NNzhNUHZSUWsvLzlUUHMyV1VuckhjZEZpUnd3dk9s?=
 =?utf-8?B?dGpzeWh4dWJ4V2lTUW9EN0h0Qnp1RDVjZWJaZUlnZTM1aXR3dTlyaysrOWFz?=
 =?utf-8?B?d2lBU0lEdEpUVmV3bWNCejFvc01xR1NtTk5KdURuaUN5QStVc3RXa25qY2Mx?=
 =?utf-8?B?b3dSYzJDeG5HUEdaZzN2UyttNG0vWGhJY3FkcGVnUjJaQjVsSm9zVmU4T3Vt?=
 =?utf-8?B?LzhIV095YWozMHc3d1NlV0tESG80RHp2L3U5WjhhUm45STNrcCtRY0FmTVdy?=
 =?utf-8?B?Q2N5SnlYY0Jpb0tmSUY2WVhWYmZQWkZ6dElhT0NxU2RxY2drOWRzRy94TFU0?=
 =?utf-8?B?Zll1c0YxeWxNbEpWUkt6KzVEUFgvN29Ma1VqVC9HWHlvbHlrdVVEOU9MaGpa?=
 =?utf-8?B?MXJFbG50TnZhY2o3RWpFNlJlZXlrNExiTU9NMFhGeXZnRTJtdlRGRE8rNGxw?=
 =?utf-8?B?eW02b29SdzJzWmJHNHJUcDh2Zytmbk5abUVpWWFDdnZBdm9NbW92eVh5Nksz?=
 =?utf-8?B?QW5YcjVMeXhlUXZQSDZvbUt4Slo2bG5Ha0Z1cEIvazNaTlZnY1h2cGlQa0VF?=
 =?utf-8?B?WVFEWjNPeTJGOEJMcGNwQXlFUXFqLzVQSFBGeGdBT3BtQm1CdFgvY0VFUWxD?=
 =?utf-8?B?alJVZ1ppdFEybEdZcjRDMXNjSmlqcVJGa2tGVjZiQ0ZaNUI3VHhPcmlmM1FY?=
 =?utf-8?B?YlZBSVA2bUZ5M21RRGdMeGNYTUdwK0k4U01Jc0Z6TDNtdE9JNVVEZWZWVlU5?=
 =?utf-8?B?elhMdEwzSm9wdHl3SGVrM2FHbXZweFpTa1llQnd1ZVlwY1FwNUx3Sk1sT0s0?=
 =?utf-8?B?a1NsQXhoRGZrN01tclkvVUt2SzRjVkkxSFduMkhCdGRpMVRYd29oUUh0YkNX?=
 =?utf-8?B?TUI5Um5IVmM2TkozZUJzWDcyVkhQRVJuRzFoQXBFRlB0YVczbFkvYVZrUVNt?=
 =?utf-8?B?QlM4UjNUTEl4MHU2b1ZQOWI0TUF5K0hIL1IycWhhVC9HTlR4eEY4cWR6YnJI?=
 =?utf-8?B?OUV0aFhVNVpSaUZSNGpKQTQ2TS9MZnliOFd4SWxhend5b0UwUVZJSjlBQ1F1?=
 =?utf-8?B?N291YnFxY2gyMkdrdHhIMU5HcmhnaVEyZjVaQTBDbXNQWVdiRjRIUm5PVndr?=
 =?utf-8?B?UkNENzkrTEs3Z2ZoWVZ3NzBmRVhGUGl4d2tya2lLaXovOThGREdXcktJTVJ1?=
 =?utf-8?B?M1o1MDF4M3lZdWVybVpQc01WRnd1NmdSSkJJR2dkQk50UWFiWW41SjRvNWJD?=
 =?utf-8?B?N3hPdlIyb1RUdzA1eGRwRGg3OHI0V3V4bU11SUw1SlJWeVVNb3RGWGZxWEk5?=
 =?utf-8?B?OEhyTmx6ZmRFZVI3c2dtMi9GOHd6MlhNL2dOWHhraFVwSmJjQjMySURna0Vz?=
 =?utf-8?B?Y0FjYXpyVzgwWmdlbVYvZnI4WWNiTkRKc1F1ZzF4QUhmUTJ4L1ErT05iYzdP?=
 =?utf-8?B?bm44cW9LQmtSVGRPbUhWdlEyQ1R0SVlqdzhUYTd3VFE3ZGdzVWQyNG9nZkJH?=
 =?utf-8?B?TlN1NG5pWStoamVFWVo1UTgwcXZFdXlVZFVLV1lpak16NU00cytnaHFjS1RF?=
 =?utf-8?B?Q1BzSkNmUnNKV3pwWG5saUdERllxbW0yRlQ5S0M5bTFEbTZVangzT1llK052?=
 =?utf-8?B?bXF3NUtnNjdoUlJ5dU5CMlNCSlduQmtzQngzTFRocXpQMmZMY1pMR1VDZGJC?=
 =?utf-8?B?MmE4Rkp2K1RXd3VhWjc0cGRVS0pvMDZKTWxUcmE0QlgxREI4Q3Fra1JkekpW?=
 =?utf-8?B?MVFXZTlmMjc1WkM4VmhCa25wcWMyNGdEZWRsNThPR0NGWC83QVI4TmVXUDFs?=
 =?utf-8?B?bE1Vck5vKzJDMkpLZXFIWDJ1V1oxS2xtOHpTTjMwempFVFViL09ObWw1Ulcw?=
 =?utf-8?B?SGZVbTE0Sjd1ZENiYWJrSVI3Qk1WQ0ZYK000ZFhoNWNrTVl6dHIydzhta0la?=
 =?utf-8?B?Zkc4eDk3Vmh2RkpoZlpmTUtwSHM3bCtYQlh6OEt4Mmxxa29UeVRuVzlXY2lj?=
 =?utf-8?B?dTRxTUFKUStMVVYxdFZzNlBwVG5PTXVCU2c5RFNxQVRYTVRBM0piY2RtTGJE?=
 =?utf-8?B?N0JqRFZ5NXp0SittRmZZQk5oM3RjaktyM09ob3MvV3pBdUR2QVpLYnN1dEZZ?=
 =?utf-8?Q?3MV4=3D?=
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(19092799006)(1800799024)(36860700013)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	eR2hfxFrY/NHoHUFKBOW3hEP/txvpxaCF5FDzauhhN/11UNuu5B8xI03x7xvWm+fRnkvVCF4RmUoVDQtblcPrVkvQr/p/wMiG0b4qwQkBEWqTlUYAiDdyBRTu9d60hbgeZm8FSjLMdlhTiru5PVQn+REtL6OUgSrXwJn2NPDYfw5rk9RsR90sNokS3KKp+Ot4qkpeR9wM4oP0TMkJdJzVhKLj1lDA76LfV6FVbFVEHgKKKUI/4ViRvtOGuxwBpmAJKZIoAmMGCD23osuM+v+p+nJkMLaE5myiMXpE+xEq98OLkZdMxIVvnZYUKKgYsuZWuD1UPRvnoVWnv7jQIkgGG+3kF4szEyqpN/YOH+CFcwwRmiUXgdbGORCZUqqbz1MJs36u+UgvBIrzMS2qCsJlwHVT2JwCsAFBIjSdrHDNlebLwcElWD4SImlzn5Ru/Z7FhsacZTwfgcb+aJJbPoZ1bP9fx74a8Vx7fvrqZXIetxb7mMjQjOPXcul08tBLwq981kd7R/wvvmfiPcbqhQIatSKavHEq1rMePkiN/n7vdKCrZY+AECF+6iQ76aR4JYSVk1fHAYyFzAjAMwVnQE/up9PVzHybPoRfKAUnlKJjJmboHMuEHZosgfgds7cL6VnkP9JEk6S1MzvEQhHWaS6dA==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 21:33:35.4018
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54dc9288-1ca8-41e6-6653-08de10e97dae
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002529D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR19MB9042
X-BESS-ID: 1761082417-102839-19528-6015-1
X-BESS-VER: 2019.1_20251001.1803
X-BESS-Apparent-Source-IP: 52.101.56.78
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVsZmJiZAVgZQ0CQ1MdEsLTHN2M
	TUwNAiydzYwtzYIC3V2NTEzDwp0ThJqTYWAILsfPdBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.268377 [from 
	cloudscan16-140.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

From: Jian Huang Li <ali@ddn.com>

This issue could be observed sometimes during libfuse xfstests, from
dmseg prints some like "kernel: WARNING: CPU: 4 PID: 0 at
fs/fuse/dev_uring.c:204 fuse_uring_destruct+0x1f5/0x200 [fuse]".

The cause is, if when fuse daemon just submitted
FUSE_IO_URING_CMD_REGISTER SQEs, then umount or fuse daemon quits at
this very early stage. After all uring queues stopped, might have one or
more unprocessed FUSE_IO_URING_CMD_REGISTER SQEs get processed then some
new ring entities are created and added to ent_avail_queue, and
immediately fuse_uring_cancel moved them to ent_in_userspace after SQEs
get canceled. These ring entities were not moved to ent_released, and
stayed in ent_in_userspace when fuse_uring_destruct was called.

One way to solve it would be to also free 'ent_in_userspace' in
fuse_uring_destruct(), but from code point of view it is hard to see why
it is needed. As suggested by Joanne, another solution is to avoid moving
entries in fuse_uring_cancel() to the 'ent_in_userspace' list and just
releasing them directly.

Fixes: b6236c8407cb ("fuse: {io-uring} Prevent mount point hang on fuse-server termination")
Cc: Joanne Koong <joannelkoong@gmail.com>
Cc: <stable@vger.kernel.org> # v6.14
Signed-off-by: Jian Huang Li <ali@ddn.com>
Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
 fs/fuse/dev_uring.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index e7c1095b83b11fe46080c24f539df17e70969e21..d88a0c05434a04668241f09f123d5e3a9cc1621d 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -324,7 +324,7 @@ static void fuse_uring_stop_fuse_req_end(struct fuse_req *req)
 /*
  * Release a request/entry on connection tear down
  */
-static void fuse_uring_entry_teardown(struct fuse_ring_ent *ent)
+static void fuse_uring_entry_teardown(struct fuse_ring_ent *ent, int issue_flags)
 {
 	struct fuse_req *req;
 	struct io_uring_cmd *cmd;
@@ -352,7 +352,7 @@ static void fuse_uring_entry_teardown(struct fuse_ring_ent *ent)
 	spin_unlock(&queue->lock);
 
 	if (cmd)
-		io_uring_cmd_done(cmd, -ENOTCONN, IO_URING_F_UNLOCKED);
+		io_uring_cmd_done(cmd, -ENOTCONN, issue_flags);
 
 	if (req)
 		fuse_uring_stop_fuse_req_end(req);
@@ -383,7 +383,7 @@ static void fuse_uring_stop_list_entries(struct list_head *head,
 
 	/* no queue lock to avoid lock order issues */
 	list_for_each_entry_safe(ent, next, &to_teardown, list)
-		fuse_uring_entry_teardown(ent);
+		fuse_uring_entry_teardown(ent, IO_URING_F_UNLOCKED);
 }
 
 static void fuse_uring_teardown_entries(struct fuse_ring_queue *queue)
@@ -499,7 +499,7 @@ static void fuse_uring_cancel(struct io_uring_cmd *cmd,
 {
 	struct fuse_ring_ent *ent = uring_cmd_to_ring_ent(cmd);
 	struct fuse_ring_queue *queue;
-	bool need_cmd_done = false;
+	bool teardown = false;
 
 	/*
 	 * direct access on ent - it must not be destructed as long as
@@ -508,17 +508,14 @@ static void fuse_uring_cancel(struct io_uring_cmd *cmd,
 	queue = ent->queue;
 	spin_lock(&queue->lock);
 	if (ent->state == FRRS_AVAILABLE) {
-		ent->state = FRRS_USERSPACE;
-		list_move_tail(&ent->list, &queue->ent_in_userspace);
-		need_cmd_done = true;
-		ent->cmd = NULL;
+		ent->state = FRRS_TEARDOWN;
+		list_del_init(&ent->list);
+		teardown = true;
 	}
 	spin_unlock(&queue->lock);
 
-	if (need_cmd_done) {
-		/* no queue lock to avoid lock order issues */
-		io_uring_cmd_done(cmd, -ENOTCONN, issue_flags);
-	}
+	if (teardown)
+		fuse_uring_entry_teardown(ent, issue_flags);
 }
 
 static void fuse_uring_prepare_cancel(struct io_uring_cmd *cmd, int issue_flags,

-- 
2.43.0


