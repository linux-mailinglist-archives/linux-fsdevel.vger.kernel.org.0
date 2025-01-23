Return-Path: <linux-fsdevel+bounces-39975-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8761A1A837
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 17:56:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC4BD3A4E3B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 16:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBFD418453E;
	Thu, 23 Jan 2025 16:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="SxHGsAPK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip168b.ess.barracuda.com (outbound-ip168b.ess.barracuda.com [209.222.82.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150AE145A0F
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jan 2025 16:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737651349; cv=fail; b=lNCR2r6ztlf21xk/h7V6ohaB0hBOEpEl8pP0IfPZUjC46xhSwtT+NCHzWksiXCkk3BXbzKtTjtVvcb9Ek5sE4VeFjlGMgVf8Y+XkzQH8MviaaIYPc28R4M2tSf59dEHcGBqf6qXTfYbzfsE5I8/Q1RSF0iTo+eACBO1HJKFjKVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737651349; c=relaxed/simple;
	bh=KtNNwAgaPSdPWS/mQhbikCiDNR3s1e8xxT5cseFMw9I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=buF9SjFo7boA0z6j9e3UfnH99q2nt9WMKmsqAwNp5rvyjoQpgcMW3Gy1LHH0DBGDiiBy/WksuvQuBdig5MskMFD0uBk8+ArAVcsqJ69V73mNX+GFizMktvQ94ObhHsoCAbeyVS5b3Yp4/Epx5HkFH6T9deepqVHhwfe/OpMPBRI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=SxHGsAPK; arc=fail smtp.client-ip=209.222.82.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2045.outbound.protection.outlook.com [104.47.70.45]) by mx-outbound44-13.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 23 Jan 2025 16:55:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yYyB8814/Viby6+rifdq3yf0/8DDHEXMy9LSh1UsUsfJMo4B9yPLdDWm76PI9jWr0Og1yQ95ZcnhfHWyx3+8V/e5vEJLb4GhA4QavKBIA2Rpx5YRantXRBV5vMiTTH2yGvqL/OYfSlPR5HEB0TjQKJaE0WpabpQk8fFyQnTeVVCdueVzlNz9I9jBIeDofiIlaSXH79jSXW6WyTAOgPGzmYr6ACwFcu1NSjPZAzMHLGUDIBIexTNrsO3gytCkWSXi1jO+UOr9Ab0hQByogdblDIK5Bipr4WS0tYdmnS5ms6G26kCE2Lqi5c9us1bBpKfknLd2uhLBP2Qvtqwb9EU+iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GIlwN+DKkguUaqcv2R2l41Su4fRN3kGaWCQ8bQo0IAk=;
 b=Q776dHzYdqOhCHpU5rv890XrAY0mCECluQ6Khumb1G8N1YSUpGVYATAN+9gTYo2FdPwK1UM9qpetsuZ83QqjzI5qgYKP1c4bkXdAMNm/6qASZvKuw5Q2iJi18Mt/AF5YRPobrL/xlnMUJ7016vMBIzEePeE/W34klcoAgUy87tCJAvek2nUs56wfg8rngYM/2Tfsm+s19YyWU42dc3UEKaz0SxS7hG8alGycDhYWzyH8Y57BzfmOjXfgkUeZ5fn1hzABUyvkpaxVoJdkB34rpRpU/w1VJ5qUeCGHg41aZzYWyzpm9X2sSSL0tPo5DI09gEczmkeEn7CFgksvIZbd9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GIlwN+DKkguUaqcv2R2l41Su4fRN3kGaWCQ8bQo0IAk=;
 b=SxHGsAPK7Dcm36K8Hub5xZ1Vq7/jZIFg5n6GYmGt/jNbyLeuiHEJpPZ2G2cOVMBMIYnb/Ioe6ThF37XttAIoyXK1QhkVhlwPaWm8VZFn8HZDjbk2dO9vwG1a3O1AiE8ILSRkDS5cGMyMXlofwO2D+fSRqwICg8c2LmxLnIRYaDw=
Received: from SJ0PR03CA0074.namprd03.prod.outlook.com (2603:10b6:a03:331::19)
 by LV2PR19MB5720.namprd19.prod.outlook.com (2603:10b6:408:17b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Thu, 23 Jan
 2025 16:55:35 +0000
Received: from SJ1PEPF000026CA.namprd04.prod.outlook.com
 (2603:10b6:a03:331:cafe::74) by SJ0PR03CA0074.outlook.office365.com
 (2603:10b6:a03:331::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.18 via Frontend Transport; Thu,
 23 Jan 2025 16:55:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 SJ1PEPF000026CA.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.8
 via Frontend Transport; Thu, 23 Jan 2025 16:55:34 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id 6337880;
	Thu, 23 Jan 2025 16:55:34 +0000 (UTC)
From: Bernd Schubert <bschubert@ddn.com>
Date: Thu, 23 Jan 2025 17:55:32 +0100
Subject: [PATCH 3/5] fuse: prevent disabling io-uring on active connections
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250123-fuse-uring-for-6-14-incremental-to-v10-v1-3-8aee9f27c066@ddn.com>
References: <20250123-fuse-uring-for-6-14-incremental-to-v10-v1-0-8aee9f27c066@ddn.com>
In-Reply-To: <20250123-fuse-uring-for-6-14-incremental-to-v10-v1-0-8aee9f27c066@ddn.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, 
 Luis Henriques <luis@igalia.com>, Joanne Koong <joannelkoong@gmail.com>, 
 linux-fsdevel@vger.kernel.org, Bernd Schubert <bschubert@ddn.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737651330; l=1542;
 i=bschubert@ddn.com; s=20240529; h=from:subject:message-id;
 bh=KtNNwAgaPSdPWS/mQhbikCiDNR3s1e8xxT5cseFMw9I=;
 b=1GnbpRNsVyvRpAo6SOFKAXTU7jn8+HH+UVKJ7PTOC9MgaO0h5GLdNY1Qq/s3Ki0iNVIaM+wxr
 4fhAJJjAaFPBc6wK/ue7c7vuaXQeMOmatJx3rI0x8VVvzacHgS0gfaE
X-Developer-Key: i=bschubert@ddn.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026CA:EE_|LV2PR19MB5720:EE_
X-MS-Office365-Filtering-Correlation-Id: 46233bd6-4a67-4f7b-3c2f-08dd3bcec16a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z1ZIWlBNYzlRY05ua1Y0YWZ1ZkdjK3h3L2NuWFI2MDU1elg2TlE5WVY5YUp5?=
 =?utf-8?B?SVdpejNubldmRFdPSVVuTFhHMUQ2dmdMY211OW1LVG5RNllQUmJ4SkcxSjNH?=
 =?utf-8?B?bWFiOGhkMkVBOWRJemFyVEc5TzUxNlFBakpvMVpESzJ0eDRJdXRYaHN0ZkhG?=
 =?utf-8?B?c0FFZkRTVmJ5WnBFR3hIb05wckhrSDBwQm1XVDNkQlB3dnk4UzlsR3Z3a1pY?=
 =?utf-8?B?WHBNcVgzOVhseTJCMWRkQXpSNUw5ZmNKY3ZydFpZeUs1cGYrZ1JFTXFJblJq?=
 =?utf-8?B?K2hUU3IzZmhVOW1vTGhqUE9ZQTYweTZ1SXZrZVh5VXBhTFBYZWx0TVB0Y1NO?=
 =?utf-8?B?ZWs2cEF4UEdVdUtDQXduSEszTXlLMUJ6UFZDNWZwZHlTekJFcmlmNW0yTCtG?=
 =?utf-8?B?YSsxcCsycXBKYXRtNmhIN1ByZW5OK2tmUzh1dHpabDBpQXVVRU9lUXRaR0hh?=
 =?utf-8?B?dy9wSUpWc0tYelp1T1FVMlBsQTlsOFZHYjJYN0dhQ1orK2dpK2x6c2kzLzJi?=
 =?utf-8?B?TzdmeUgrTlppOUNsUjhLWW9YTkNGUUhLcmZLVklveUk0b3hoU1RZZmRYSlZN?=
 =?utf-8?B?MFIybTZ0QkFDd2FjdGpoL1VZb2RDdmtmaEthMXNPdEJOZHQ0YUtoL08xc2RU?=
 =?utf-8?B?bEg3NE1ONEFPUndleHg3U2hCeitpc25Ua0hodllCTHYzN2FjcDh1S0ptUXJw?=
 =?utf-8?B?cjI1L1hvT05pcks3RGpoUmdRMFAzNFh1Z1IvZjVyT3N3aGIyTkIyNjZPclZ4?=
 =?utf-8?B?UEVxUEM1dENhMEtIMHYxVTNaYW1mbm1vRFZ2dHJiSjBRaTkyWGx1NHd4NENs?=
 =?utf-8?B?cmZPQnN0QjhGZGFsVzhOL1AzUWRqVnBEVG5iRElLa2t2NVAwQ1FuZERHdFBY?=
 =?utf-8?B?YzFMckUzNGdhY0pXd1A3UVdmSlF1QkZ4QWVCSDBYY0FzY1lnbWUxM2JHN05U?=
 =?utf-8?B?VXJWb3QwSUFnT1NzR3lFY2VvM3hGZnlOZHBlSjdJL0pZNnMxZlNaRThkUHpZ?=
 =?utf-8?B?bkl6Z1dndENzWjRyTUpWVGZsREFteGtGb3BadHRvbVNrakdXOVBVampremFU?=
 =?utf-8?B?YTVEWGVNc1dCVnJ4VEltK0VjaDA0NlI0NEd2cWxZYkp3bmlKdUQybStmMmV6?=
 =?utf-8?B?Mmt5a2JWU01HVmNqZEZXalhoNk1MVmc5VmE5WlRucTZJUzJ6czZpWnYvYTRl?=
 =?utf-8?B?dUJzNks0K2FNeHpUalBwT2NCOFlPSW5aU04rMXFKU280V0NWN3ZmQUcxSjYz?=
 =?utf-8?B?Q0lTcTFCNVZWaUlVeThveXNYNDhMQjRCaWZxb2wzZHVPOGRCRUJYbi9yRU5y?=
 =?utf-8?B?YUpoaTVhcWk3VDBIODh6a1JhTWQ2QnRrZEdzNUY5UDBIUGd3NWY0YUt6dkEw?=
 =?utf-8?B?eGNuL0REaHEzQXRxVW5NNTUvU0g5NzR2ZVNoZlJwVWlrcTFzYW1WSDNmTU1X?=
 =?utf-8?B?U0dLd0tISkNQd1VyeFU3ZU4zZ0NuMWpuWDgyeVF0anorbW5JbXNuRHhQOGRY?=
 =?utf-8?B?eGMxYStJYzZOQ29GSG5pSkJHakVleGVmUnhEUUM1QUVLdldaV3B6b0tIZ2pk?=
 =?utf-8?B?akhja0JpYVRXTzlXNlZoVFRMYTM0VVcyMG0wVTlQY2xMSitIdUg1TkswT2RM?=
 =?utf-8?B?VDRwWXkxZlZFeXBaN3hsVmZmMW9rcFhzd0lsc1c5bnBXQ3BMMWpXeE42KzZv?=
 =?utf-8?B?YVlENkdDRFZzWFo2cXNZR2cwQUw1dTMwZkxpTHY3WXVVUlQyaWsra2pvUUJP?=
 =?utf-8?B?SGtSU1V6R29tdmlRVFRlQ1hoR0s1ajJoUXpLRUVYelFkSThDNDVveGNNQmd2?=
 =?utf-8?B?U3dIYkQvd1hJWEF0a3kxNm1lWkRCTlA5STJCTTBBVXpLenRXR29mUVI2SzFx?=
 =?utf-8?B?MG15Y09NamYxd2JlTTYvSEJIbndOQUJyU1FOTC9EblNTQituOEhWY1J2cGFQ?=
 =?utf-8?B?SVVmeHpaWmQrUG1oODNlVTV2R0p0RWdjbW5lZjVrRUpZaDg4ZDVvODZXTDB0?=
 =?utf-8?Q?5I4jqxQ9InvBnpfpLYuhQ6mDqNrT2o=3D?=
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	sWlvM0akoEQJgbQyLWdbK+AAprSH7ftixa1OxdxEW32kFZuRo6VBCtf0uMJ+xGAud7Blvv2IJlmP2gUNpimpzw1jK1k+Idok3mMQ7I/PMTWXofYXxnxkxFM+5FIiDigvsA869wnMDtX/euq7zlvtZrLU1CArfgIJ7QjSzTWs1duIS+53UuphpBiC3911CYsjhfcIbgxnpOEEKYDLIscqoUyI//Pqn6e8XhocvSP5/77AiUdRFhA9xBwpcofuCLIwULj102V6YrnT4HNY6TdOyv662PPik72zP5GaCvbnL027CKFXtTPJkHoDvOE2oe50CGsTEHz/UZOIXDfiw3TeKDgxWbVc6n4vTSnDdoP7ow+2KlzbWVhfV9T6xHBGf307CqPUYkRR6pnNSTlyNEkA3AbcytqsNxOcgCXP0FxqbgxKiLI6M8XnCAdLkPS/Jm+VjOCmlVUOE8EbPqseZ1NZMdUeZMOswFl8q0edeL6Efi3MM18rysOdcFYy7SocfSP6PNQHlOAYdUYcjg5zZ+ZShkLUQ50HtP8VNMepyk8X7G2MqRCH66YG3spwuP4fy04famV5azK1x+Et/NuWn7zX/hIfBz1YP+VSTOdDI2njWy+PBgSjRoB2c2pCHTfqG7JunpbuyJUiPos1S5yFxph/GA==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 16:55:34.9650
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46233bd6-4a67-4f7b-3c2f-08dd3bcec16a
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026CA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR19MB5720
X-BESS-ID: 1737651337-111277-13411-1426-1
X-BESS-VER: 2019.1_20250122.1822
X-BESS-Apparent-Source-IP: 104.47.70.45
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoYmlhZAVgZQ0MQw2dLYICnRIs
	3S1MzE0iDFzCIl2TQxNdXAxNLE2DRZqTYWAFiwr09BAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.262004 [from 
	cloudscan15-131.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

The enable_uring module parameter allows administrators to enable/disable
io-uring support for FUSE at runtime. However, disabling io-uring while
connections already have it enabled can lead to an inconsistent state.

Fix this by keeping io-uring enabled on connections that were already using
it, even if the module parameter is later disabled. This ensures active
FUSE mounts continue to function correctly.

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
 fs/fuse/dev_uring.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index 8e46cddde34539af398290f26db120713520ee51..a2abcde3f074459de3dba55727c5159f0a257521 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -1091,11 +1091,6 @@ int fuse_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags)
 	u32 cmd_op = cmd->cmd_op;
 	int err;
 
-	if (!enable_uring) {
-		pr_info_ratelimited("fuse-io-uring is disabled\n");
-		return -EOPNOTSUPP;
-	}
-
 	if ((unlikely(issue_flags & IO_URING_F_CANCEL))) {
 		fuse_uring_cancel(cmd, issue_flags);
 		return 0;
@@ -1112,6 +1107,12 @@ int fuse_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags)
 	}
 	fc = fud->fc;
 
+	/* Once a connection has io-uring enabled on it, it can't be disabled */
+	if (!enable_uring && !fc->io_uring) {
+		pr_info_ratelimited("fuse-io-uring is disabled\n");
+		return -EOPNOTSUPP;
+	}
+
 	if (fc->aborted)
 		return -ECONNABORTED;
 	if (!fc->connected)

-- 
2.43.0


