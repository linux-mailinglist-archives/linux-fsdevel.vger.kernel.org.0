Return-Path: <linux-fsdevel+bounces-39976-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EABEA1A836
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 17:56:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F659188C027
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 16:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D0D19066D;
	Thu, 23 Jan 2025 16:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="kojTb9Dd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip191b.ess.barracuda.com (outbound-ip191b.ess.barracuda.com [209.222.82.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB81145B00
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jan 2025 16:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737651349; cv=fail; b=fB/PpJHPiCG/pMGZ04e3zla3mn7C8+rifZOJPbW7WUhSYBh6cOTmBwYoxJ1Vb/YhOZyE1gvG0jkyUCdcTD2HOSJ3HjxqMkABSbcn8geM5y9w0ry7SoHkGSGRFBE9K79va35oGamoKUWiS/tF+AhrjAT0rv50CeNUo3Vk+YIR7qY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737651349; c=relaxed/simple;
	bh=g1xK0U2GeyWaNV19wfhUECA5XXU1GKPpozZo+5/ZdkI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y3lOVUD9NWriTrZ/ESD5t4gX6UgmPJ4XCu+meAGwJUxzTws+TnRT67dXbg0TvRgdmWvmQhTgfoBcvZYmXNiCvOSp4EP5JEOZAvh2KleIFCoOZE/DXnnTSmb5a67dD1lwx1sJ8V71PWhOM0lB0Zf1J0KMZWDfQwmaOUxxLE7FU+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=kojTb9Dd; arc=fail smtp.client-ip=209.222.82.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2044.outbound.protection.outlook.com [104.47.73.44]) by mx-outbound20-119.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 23 Jan 2025 16:55:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g9P/Miweim5Us0mfe6NP74DlMP8jQ+pm7k+r7Y4BW+RdiL5327HMS7UeeQ+QXwxUOvqyBwqzbaTPxvNaD0wFECqgygkqUUE11HpcG+x3blNY1e0cE+utJBDz2fLmr3FOqFgEKTSdrKnIlg8vg85m/dECuuIC2ryJ1ZTgScoYw2ltO2i+C+PXGLHHZcWjBHXlgzSOnZdjVB8MwbLoOZHDk4WI4/aCT/Nwrqb56EaBFeYpn/ybmGGWwOI+jMc7mfd5I6eUApjDoWC7r1j/F0Roglugru//NmrayaBtVF88in2ZHYvGxAT7rDPNqk/HNMk1uk9g/BdbJoxugMRo75wM4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gc3MMGdaFLtOKOHRWjNgFPBcDJ1NV5a7cI/e1yGElEg=;
 b=p0t1R1Q+Zw+Op6PLGh2b7t10Ha2h19DU2oDQXXPRvD5hJUqxW+5flUcwmXdMkafB/hvklmF+OBYqk6rX3JfW0858m7f4Mn7dxmUQjZX3CCdJeHq7EUoYBIoH8JlLNy0jR1vbK7pJTGOYu60IReYJWtx2+P6xYg6c8SKGns3bjpZ1FeG5R3pzj4uQycWMHgqSdAkIChNYPO83Gco2SdhMwQzssmBS7JCKD0l4m1bDW8Z9ZY2oerDJHWD0XrT+ATqneT4Z3cMpRI2F5ZonYrOAp0hA6c3V0a5lwlmQiKrcD6nDEgB8la+wEJY30t5fqPqnkRe4XHwYLn4Hu51pee38GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gc3MMGdaFLtOKOHRWjNgFPBcDJ1NV5a7cI/e1yGElEg=;
 b=kojTb9DdmtlNeE/9tpA7Uuh5BkmOjVPPgX7xmdVJu3pR/uVmg9MJbt4hBjx1HfMyzPw0lW9QJGB/5Voz/t5pD5TNyPMHu4WsjyE4dBWWCp9kaf1pZZcnKVD+boDtqjSMV4AIJYUS5ZH+kT7HLihvh/MPypd/ikenlxMdRCaj2xM=
Received: from DM5PR07CA0108.namprd07.prod.outlook.com (2603:10b6:4:ae::37) by
 CO1PR19MB5190.namprd19.prod.outlook.com (2603:10b6:303:f1::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8377.18; Thu, 23 Jan 2025 16:55:34 +0000
Received: from CY4PEPF0000EE36.namprd05.prod.outlook.com
 (2603:10b6:4:ae:cafe::d0) by DM5PR07CA0108.outlook.office365.com
 (2603:10b6:4:ae::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.21 via Frontend Transport; Thu,
 23 Jan 2025 16:55:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 CY4PEPF0000EE36.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.8
 via Frontend Transport; Thu, 23 Jan 2025 16:55:33 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id 6A9ED58;
	Thu, 23 Jan 2025 16:55:33 +0000 (UTC)
From: Bernd Schubert <bschubert@ddn.com>
Date: Thu, 23 Jan 2025 17:55:31 +0100
Subject: [PATCH 2/5] fuse: Remove an err= assignment and move a comment
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250123-fuse-uring-for-6-14-incremental-to-v10-v1-2-8aee9f27c066@ddn.com>
References: <20250123-fuse-uring-for-6-14-incremental-to-v10-v1-0-8aee9f27c066@ddn.com>
In-Reply-To: <20250123-fuse-uring-for-6-14-incremental-to-v10-v1-0-8aee9f27c066@ddn.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, 
 Luis Henriques <luis@igalia.com>, Joanne Koong <joannelkoong@gmail.com>, 
 linux-fsdevel@vger.kernel.org, Bernd Schubert <bschubert@ddn.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737651330; l=1564;
 i=bschubert@ddn.com; s=20240529; h=from:subject:message-id;
 bh=g1xK0U2GeyWaNV19wfhUECA5XXU1GKPpozZo+5/ZdkI=;
 b=DHx45tjlpaO5uO0MT4kNGs4F63rK1kTA4TsxwNgEC8OauSbsErrjtU0+3aXVV2atmh/+eVoOT
 C+/woznsemSBwDMOrOLcGxZvdj4DlQMp9ENMV6St1bN3yQGVsHuF/fv
X-Developer-Key: i=bschubert@ddn.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE36:EE_|CO1PR19MB5190:EE_
X-MS-Office365-Filtering-Correlation-Id: ccb2be6c-506b-4b92-f6b6-08dd3bcec0b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RUxjdHJ3a2wwc0c4YVFFYXMzbFBXbU5BeEREeTQzeGJZY2F6Z0d0ditNQ1Qy?=
 =?utf-8?B?MVRpMzkwdUYrYjAyQndmSWZkRUNQNWpDK2wrdUg0OFFRZ0M0VFEwdld3WGc5?=
 =?utf-8?B?OExNTm5nVFNVWUJFRlErY0FLcitGK3c0ckZhQmxHdTIzcDNJTDZMSU9RZWZh?=
 =?utf-8?B?bmVZMHpVakN4S2dETDdCMHhMRG91Y2lYRCtmL1l5dWNpdzM2d2oyVGFtcFZj?=
 =?utf-8?B?Wjl5ODhjMGNKVjYrcE1mVnJEVGpFK2xIRFYyZXVKWGlQWTlWRXErWVRkaG9X?=
 =?utf-8?B?Yng4cmtCRjFTRmlZTmFmclBDMlp5c0NDck95NDhTcTdwQ1JCalg3WTF4OTkw?=
 =?utf-8?B?dVg0bmdKWXVxRWhQdVNueFhEalJZcGYxOEwrL0ZEczV3UVd5RSt1L3ZXT0Zj?=
 =?utf-8?B?WElVQkQvbURndE0vTE5iYzkrSTBWaDJ3OEdLNFExL2tRUXBTcUs1T1JWcCtn?=
 =?utf-8?B?aC9obWlrNDNtRzIvQ2p0bmdsMkVwaGVkTVFqZ3ZVbjY5ekJ4bm5Wc3hWSUV1?=
 =?utf-8?B?d2Q0UTJqS0dURDJhdGZKbDNrd1Q3a2xBSnhTaUVCWmhicUpkMmRZVUZSRFRn?=
 =?utf-8?B?TVE2d0N2WXZjV0pQNkUwRlluUkFHVHRUbEMyMlVaYVRMbFFGMlcrYlgrYWJF?=
 =?utf-8?B?aDdsaFlQNEpOSzdIMFRCVEM5dkN1TE10NlJzaFl2NzBYcWxTM1VOL2NjUi9J?=
 =?utf-8?B?WXlFcjBrNjJIK3pSZ1NoTGFiaWFadFNFVTZRZlgxZFFMZTI5N2YvK0lnY0w0?=
 =?utf-8?B?NS9lVG9WNzgvR1ZiU3NjV1hoZlN2MjJYV2diTmpBWms0dllJNVRHRVhXeFFx?=
 =?utf-8?B?TzBpbDNRTzc3MFl0WlVWM2p5UmJsOXJyM2VxUUQrQ2lybi9mZnJOSGdrMEpE?=
 =?utf-8?B?UWE2bUxPcUR1ZWpiRDB6b0JxRnZ1U2JPWEo5aHkveWxaeHl6ZGhjSGNXb3Zw?=
 =?utf-8?B?UTMvbmxMdDRmK1VPM2VzMk9iTmR4QzZzV0s1dHR2LzRvVHQ3QXd3Nndob3Vo?=
 =?utf-8?B?aFNONUliSm5vekRpMlFYczdQejZ3ck1BTnZzaTdGaGYxTDROdUthcUpzM210?=
 =?utf-8?B?cGs1RTEvTlViSHNhTVNrcUpoQkc0VHI4YXgxbXQ3SHpmaERCNmV1aElRQmpw?=
 =?utf-8?B?aUtzQVlJcEpSanZadjR6L1VEOHFTVjNsUGdOdGE1SjFKS0dndHhFMFl5WmVL?=
 =?utf-8?B?L2pvUjdKcTdmcVYwdDB3RlQ1UWNVSlJTYzh1TWhVUncwb0tMWTZOcEdTbTdn?=
 =?utf-8?B?THZXTHZKNHUzTG9yMTJvRkFEM0l4ZGdMS2JYWmJzMWtjQ0dMRGFheUJtNjdM?=
 =?utf-8?B?WHVGWnJUVExVYW5NRkM3N3U5UXp5Mm5NR3o5cmtwMWM3bDBOVmhGS3JhalZp?=
 =?utf-8?B?WlFqYWNCV0R0Z1JwR0JEb2RrUG94ZkR2QStZZGt3bExLNjUrRUk5T0M0a0Y4?=
 =?utf-8?B?L1p3UTc1cDFteWZIZWZZNzM2M09sMGlySk51N2NaMXp0ZXpCL2RqaHQzK2JR?=
 =?utf-8?B?RDZDUGFkZEplU3FzV3NMbmJGZUNqWDhhbmsyRmhOZnM5dkhjZmZaWU5uSXRm?=
 =?utf-8?B?dE5zbnFyQ0liY2xkNEdZaWhaMkxFRFArNUk5MGpYaWFtTWZqR244NkNZZU5a?=
 =?utf-8?B?dk52U1cwZ2JuTXVHampaNlozQWhSd1dSeXQ2WnV0N3BuQVlXcXBkMnNMVXlF?=
 =?utf-8?B?L3Y4NzgxVUZ3bFBpc0o5a2FVVXQxakhsTXhkdlI1YjhubzRJajZkVjZXNjhQ?=
 =?utf-8?B?SHJxVFhFMVROY1VHaFFKNWxpRTNqTDNwdml1UUVxTjhWd3lWckFha2N4VmF5?=
 =?utf-8?B?emdITEEzcTA3Tk1yeEg5MFZFWG8vTnNRL0hyajkzODVTOHNCelNUYTIzb2xV?=
 =?utf-8?B?R2IxZUlpVG5jVWx3TnZ0K3p2MmJRYkJCWW5pV2tCdElDaWRBa1NRVG1zYmda?=
 =?utf-8?B?MnhoKzZqRHNvaWxRb042dUhDMyt4WW1xOUsvWnhuR3ZhY3lNemZCUmZZb2pK?=
 =?utf-8?Q?nruUjCVfBNlSfHNmiEvSLo+WmqT2Q0=3D?=
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	tDjCFhZgTyhp6pXfoK04jZ6HYmAKikaqsEbEyd8ytHAdinkCrhSMFxr3ztEaKdewf0XzmwcgXmltLT4jn/4VxwGdwTkzj1OwiIwlQU6Et730GWf/8VS1rGnyF/sz+7LDrhVhh9QgmZcbe4GQBtqxhf0glehGFIM2ezGF74l8nX2CgpJuYd38nJM+tmM9IoN28SUhTzFPvq70N7hEkE/JvXynU7yiiWN1tcr8FkMn4OTrMeGADuNMR9HdveO8Y7hHjQb2GmXO82E35iO2D/8wK1HRoQKltdQiJ0NeY4GpXuupJyhxPx9IPF+Gc/p8u0A5ahdK+PdQiXqp1rL86tqsadye2/OCSisd0hOVEj2HbQ6k184LghlazrbGNXk6lvxHZiImy+XFywuDJGevikDZD00IUG1wUNpzSnb6kV8jHPuXkg4+lWi+739Ftr/cCvq31MPCqaIhwWWlZV/y6V6ETA0GiJiGp8ifebEzlvifm3EgYY1FbCEYbiD/jc4ugwY/MYQ7YebAw8rpQxZ2ZAw4ML/xl/gEiw7VgMgNRrU5fldOjk8ERlis1pQDsT+jWEAeAJFVjNSpURYsK0ZCul1RssnGrQiy9wOwH6O2kzBTy/QetBJADIb/PnH2pYyvlsQR/Ag8/bsr+CM3Joo6f7x9Mw==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 16:55:33.8199
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ccb2be6c-506b-4b92-f6b6-08dd3bcec0b1
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE36.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR19MB5190
X-BESS-ID: 1737651335-105239-13392-10389-1
X-BESS-VER: 2019.1_20250122.1822
X-BESS-Apparent-Source-IP: 104.47.73.44
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoamhmZAVgZQMNkk0SI5LTUlKd
	U40STRwMLIOC3ZxCDR0MzAyNzS1MREqTYWAF6xBVZBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.262005 [from 
	cloudscan8-103.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

The err assignment is not needed as it was already set to that value before
and comment is better in the calling function, as it is about the
queue object that.

Fixes: fuse: {io-uring} Handle SQEs - register commands
Spotted in review by: Luis Henriques <luis@igalia.com>
Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
 fs/fuse/dev_uring.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index 8e15acb3d350d223c64423233f3613b6eee075da..8e46cddde34539af398290f26db120713520ee51 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -1018,10 +1018,6 @@ fuse_uring_create_ring_ent(struct io_uring_cmd *cmd,
 		return ERR_PTR(err);
 	}
 
-	/*
-	 * The created queue above does not need to be destructed in
-	 * case of entry errors below, will be done at ring destruction time.
-	 */
 	err = -ENOMEM;
 	ent = kzalloc(sizeof(*ent), GFP_KERNEL_ACCOUNT);
 	if (!ent)
@@ -1063,7 +1059,6 @@ static int fuse_uring_register(struct io_uring_cmd *cmd,
 		return -EINVAL;
 	}
 
-	err = -ENOMEM;
 	queue = ring->queues[qid];
 	if (!queue) {
 		queue = fuse_uring_create_queue(ring, qid);
@@ -1071,6 +1066,11 @@ static int fuse_uring_register(struct io_uring_cmd *cmd,
 			return err;
 	}
 
+	/*
+	 * The created queue above does not need to be destructed in
+	 * case of entry errors below, will be done at ring destruction time.
+	 */
+
 	ent = fuse_uring_create_ring_ent(cmd, queue);
 	if (IS_ERR(ent))
 		return PTR_ERR(ent);

-- 
2.43.0


