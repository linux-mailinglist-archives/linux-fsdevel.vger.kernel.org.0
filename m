Return-Path: <linux-fsdevel+bounces-40049-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C9F0A1BAE3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 17:47:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8CBC3A938A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 16:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C93915EFA0;
	Fri, 24 Jan 2025 16:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="iZh32WGu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip191b.ess.barracuda.com (outbound-ip191b.ess.barracuda.com [209.222.82.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4213415958A
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jan 2025 16:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737737272; cv=fail; b=ker4bIywN5JdGOZccwWtkLhom3/6/7Uqjc4fHP/lyHEsCjAVnYEOMIbkgOA0kiOQAY21HPIc7Bg3EImpQtG+IntFUPdAqhZFtTSuL2ogbt7bOtyu2JsY6eokxKr/83Hzbr2bOmoWMoKA8broEl/JbZPth183JXlafS5wh19rtlk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737737272; c=relaxed/simple;
	bh=lmfgK36bxxRlPP+W36lfoGQynKxojzFeF7sOGq1BtFM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=GeHjFtZCQdad2sIax6ZlebZN/TbZtGUYrR3gpWjuwJFP/scNCQizbWRig1O0cPYOLqzeaBWxdycbGH9gEiHjBRfALZfJ1r94kMPS76yvjpVhLupLXOxoZb+fvZaZMJ/ce6x0p6DHMda+FvX7r/H/gtw792OnQ5Cpj4x8KQfPaCw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=iZh32WGu; arc=fail smtp.client-ip=209.222.82.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2041.outbound.protection.outlook.com [104.47.70.41]) by mx-outbound41-29.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Fri, 24 Jan 2025 16:47:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M333JfVzNjUqEx+8LTaeCQTS/v97vrqVy8RS/NpJ0uI7aQzmZLvw5qOCwaGjUHVwVyE3R7j0htixrVCxa8ezwRQojb5UVC+lwOEmJFCjVuztNVZpx7yGYDOBm5lW0rOrDUJVLS2H1kPzV9qHWHY0tby03xlPjXPyfkD4CzywA2/eppw+uwyh/PXxYU+6gr/eOBaiEesEezqU4lwZRDKagaTiMz0geDaes8ZKjyypgrPa7rXRtPF1y3mmpi/MdzGggGg0F9J3bAxjcxsGb3tKdjZzv+GRIhnSRUcFXb/VH8UFHvdN9Vidq4qCKxwdlstOxZ61J5WWDKU9viBF5FfKPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z8TVzxJsxRPSgT3vGEudiRJ54S9q4p7lrJj4fvQDdlg=;
 b=wTuwCNbcY+8up6QPM1CARtRFqpYaCC+UJr34BwPX5dbhnOpmB/7liiFXZ/uqD1TUwIZsAv+1SLHSg7pP3l1HcUQLohFxZCA9Vr7+gaYQrNYj9GvcQ+2Y6u1boQ/NiwwcFqcviB7qhXglaGT5sHInfwXxE9iM0rdTdbVOPU0Bd1a+r2Z4fSO+RVSbg1IshDKW9FzEx0vMdlsTNzgBj0kp9KdCVCSlLkVXav15LcSLepmYHf/K/hABg6alkH7ZXZrUiW9Cyqs2bfXJ8T2HFlImm1Vhj2unBJ0/icnjdRsE++6lbYQM4KFrTLj7wuEPUg4+FkTlx5uLfVloXD5o/Hsr1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z8TVzxJsxRPSgT3vGEudiRJ54S9q4p7lrJj4fvQDdlg=;
 b=iZh32WGuMFZXqxRHFshEnUIHrWjRC1f2CsIRopylCODuDZi7oVkAXupAUPVWO7u4dYtWEuxW8q030zmy9/v+nx2Ff0ujD8gXo19Z1dNtLRgYNR9JR/bMtsI65X6nTYCxwgrPTC6m23MPwkMBNpRdRwcz+jTPzCqkbfYCyfcAo0k=
Received: from PH8PR21CA0006.namprd21.prod.outlook.com (2603:10b6:510:2ce::18)
 by LV8PR19MB8656.namprd19.prod.outlook.com (2603:10b6:408:265::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.17; Fri, 24 Jan
 2025 16:47:14 +0000
Received: from CY4PEPF0000E9D0.namprd03.prod.outlook.com
 (2603:10b6:510:2ce:cafe::5a) by PH8PR21CA0006.outlook.office365.com
 (2603:10b6:510:2ce::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.12 via Frontend Transport; Fri,
 24 Jan 2025 16:47:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 CY4PEPF0000E9D0.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.8
 via Frontend Transport; Fri, 24 Jan 2025 16:47:12 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id 0617734;
	Fri, 24 Jan 2025 16:47:11 +0000 (UTC)
From: Bernd Schubert <bschubert@ddn.com>
Subject: [PATCH 0/4] fuse: {io-uring} Ensure fuse requests are set/read
 with locks
Date: Fri, 24 Jan 2025 17:46:50 +0100
Message-Id: <20250124-optimize-fuse-uring-req-timeouts-v1-0-b834b5f32e85@ddn.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPrDk2cC/x2NwQ6CMBAFf4Xs2U3ahkLwV4wHgw/Ygy3uUmIk/
 LuNx5nDzEEGFRhdm4MUu5jkVMFfGhqXR5rB8qxMwYXofGg5r5u85AueioGLSppZ8eZqkctmHKM
 fXD/0Y9d6qplVMcnnv7jdz/MHnQo9aHIAAAA=
X-Change-ID: 20250124-optimize-fuse-uring-req-timeouts-55190797c641
To: Miklos Szeredi <miklos@szeredi.hu>, 
 Pavel Begunkov <asml.silence@gmail.com>, Luis Henriques <luis@igalia.com>
Cc: linux-fsdevel@vger.kernel.org, Joanne Koong <joannelkoong@gmail.com>, 
 Bernd Schubert <bschubert@ddn.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737737231; l=998;
 i=bschubert@ddn.com; s=20240529; h=from:subject:message-id;
 bh=lmfgK36bxxRlPP+W36lfoGQynKxojzFeF7sOGq1BtFM=;
 b=k5UmEIDCuckQmLrDv05dLCBCPFCuxJnsVwrKl8x2/eVIKB5th8UKwTjSnjSeHzvkFulIyyjSm
 pw7tnIF/uXjAoZhTrLVwpiV3WRd+ssHpNyoVCq7JlnyYgs2HAc9BG3c
X-Developer-Key: i=bschubert@ddn.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D0:EE_|LV8PR19MB8656:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ddd3a59-455f-4a0a-b5be-08dd3c96c070
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SHJqVllRQzhrL1p3MzdLN3lSQStYU29oWjJKYWs0dU0yT0c3SUlkUmI0NVhj?=
 =?utf-8?B?UTN6bm0xVUlidjFFSnhtK0Rna0FRQUdaNmFId0VEbWFEdnA3RTZHZGlPcW8z?=
 =?utf-8?B?UC9tUjRhM0lWK2NxYlZSZ3RMdnlBcW5nTG93dWRwNXRZMTJramJ3cHRRQm9h?=
 =?utf-8?B?K0UxWHdwZ0gwVElXWXNQdGF3L0ZESy9lKzhHem1aNUpnR1FVWUwvUXE3T0tz?=
 =?utf-8?B?RURsZ3hXU01DbzA2b0VaSEx2andJRFBGRDdjS0xBbjk4RzgzMGY4dnlMRHdq?=
 =?utf-8?B?NDd2UGRUV0tmMjBwZlFIRWlqVmlERnFKRnVrTXFrdW0xbjV3SGdQaXpYNzJZ?=
 =?utf-8?B?QlQ3K0lhVHpaTVRZTThhaDV1MUxGZnR1djZLZDdzRWlUV1k4WDA4VXhBOTlP?=
 =?utf-8?B?QU9YQ3IvRUdKcTFhTFptc05RaDBpejFORXBuZmNDZDhCNmZkUXViYWpFSURo?=
 =?utf-8?B?YU1zRTNpUGEzckZPc0ZTRW1uNzAyODR1SVpzL2lIem5IMWlrazBiZkhwcHdY?=
 =?utf-8?B?UjNSQzRaRWFUVU5lalVtejZkcTRsNjVhcVlWY1V6SHEyYWZydkVRcUk0SmFX?=
 =?utf-8?B?WWhPOTNWcXRQZnFtc25HSmNOd3BEdGxEQ2RoZngxQ0xtelBkcDI1TndTQkc2?=
 =?utf-8?B?ZUVzVXQ3ZHJzenhVOGR3VmNQYUVJUk85anBBclpnZlVRbnZieW1XdU80eUc2?=
 =?utf-8?B?L1VFZXRqNndEV0RoMDZWWXRub0MrV2pNZTAzWXl2YXoxWXJkd25ZQldXRmgz?=
 =?utf-8?B?T1FNT0Rid0hBa3orVklsbUxtWmxPZFVnL1NUWnVmTGRQZ0YyaWltTVZVNnpF?=
 =?utf-8?B?aDdRUG5ZdnRHaFcvVk5abU4zUmRJTkMzeVFtUWhGSG96MXRZdXJDcEVXOWRo?=
 =?utf-8?B?V05mbFFtUHdxK3VKWkVpbjZ3eEdLVzkzaUUvbjVCYVk4YmFQYnBNM2J2cU1k?=
 =?utf-8?B?NFlROFpDU25aNGoxc3A2UmY2M1l5bkdMbG9naC9Ka2xYUmNVRDlaNTJra043?=
 =?utf-8?B?bGozb1h4bWs1TU9nSUlsRWZTM1Jsa1VxaWJKbEZPbjFGcEpPdzlUT0E1T0l1?=
 =?utf-8?B?SkJ6RlZubzdTckN5OE5CQ2FrZitjTUlEOWhrL1dlZ1Zuc2pNRDhocmtrWkFX?=
 =?utf-8?B?OXNGNVRvUG1ubGVVaXJIdFRqcVBaS3Fib3RnZWRVOFJDMEQxVEtUcmZ0Y25N?=
 =?utf-8?B?ck14a2lMQ013Y0F3M1BlVGF1UXQrcFZZL1RTZkZ1d1NDRFJWQVpvMFZYWVlZ?=
 =?utf-8?B?ZWRub0QrckJzbGxQTjBHM3hocXdVNjJ2dXdETm9HRmhuN3lMWlpDd2FsTG5y?=
 =?utf-8?B?Q3JRaFdETXRMbWlkNGswYURrZ2llWGhNb1EreXNvV3p0dHgwTGV2YmcySlg1?=
 =?utf-8?B?YVI4aTlITVdsYkdzYkl6UzFoemd2ek9maXZaMDFaWjFWZDNZMytTdHVoZENY?=
 =?utf-8?B?dXNHdHdONkJlS2pZMnl3MXdaak81NzVSRzE3b3VVTys4RU40VEE4Ly9CTEFm?=
 =?utf-8?B?cEc3TnJ4OWV1enRJWDlUb1R5WFFSQzNPeDk2ZUZtOTFESUh1TWIvSnFCZXh5?=
 =?utf-8?B?SnU4d3FUOGZ1Z2J5OTJkaEJVdGdXNFNiUzlvNzgxQ1F2RC9CdUJYWFVQc3NG?=
 =?utf-8?B?ZlFYNGMydmJTUHhiYytYNXc0cVhDL3ZwS05RQ05PMDRLMG1PSVcxZmc3eG1Q?=
 =?utf-8?B?SVRLREdmMHhDcTh4dWMwUi9BMWZmc2o1TjVJbGJGcWhsYmE3WmNRZTg0Nmky?=
 =?utf-8?B?RDBOd3I2WWgvRFVYMGRqUC9hcGpvczBsMUE5cHF3TjNiZjJSa1JkdnZOUlR1?=
 =?utf-8?B?RVB5amhhK2F3QWRnV1hFT2tNS3lPZTN1VHJrVzZ3ZngyaHdlSWt2clByZmhY?=
 =?utf-8?B?RU9kaW1LVFhmeWtuZUxub2RWV09WR2Z5RUFjOUxjcitnOHRwUER4RG94bjRi?=
 =?utf-8?B?aXBzdlJZRFY1d2NxUDhkdEllNzdPb2FlOWlCQTdUOFdBMjNTMVZrdjE0Rnlw?=
 =?utf-8?Q?IlPGEzWxTrjwxs+DSPhDBWuLC4Bqws=3D?=
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	SE13RlMNh7OCXfS/FTUAa6meVuXIOzENjuquaY1rQ6+nZlCxNSih1jKGf0BnfBiey4+fC4u846MMgefwVC+NnBjSqIfG5NiQGx+h2XwPWjq0tBO1CmwuUahshWz+srvAWNbIKP43W2G5JuPFHQhVO+d1IYS61b2cCX0v1HyI4g/IvK0F1V5S4ph8GE300rJhnq7olEQ/3pnd/I0Up/WbGYnU0vL35SmLI0j+kAcVRcvNRVKw1PJA8K7qOEVBuBCKk2YUbvIw7K1BaZWod9Y4EutGmqS10hJpgAebEDPq1fxxpUKi3Hq1L4VKigKRhADKPs8JmXH/9zDXDl80kWwjKe04W8n1jdJO2iBbDCDRMJcH5FFpRlvH5AbKbXM2VnpyfHkTAAUB/SxUWNqeW69SpNhF3WxKna/LntMkYi0/wrE4rrr053XkpcNIl/v6eIwOv2D2eAQ7XmM20NpwGor5pEUvfwbA/w/G3M9d/rHsuz6Ka+6O22VBYK37EoP2eO1C0FzsmlK1nmnb08IamepxPi88hMzuy6v0kctcQEtEZIVd5JfVd4uIvUn9c5lSAbg7x9mEk+K4L2abu8oEneONU/v84HOSVY+VHS8pSOk/sqDDK68HUPVUAjz5xPMm1bvWuJV7zpx03Jm84XVjMJi6hw==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2025 16:47:12.7226
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ddd3a59-455f-4a0a-b5be-08dd3c96c070
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR19MB8656
X-BESS-ID: 1737737239-110525-13388-120-1
X-BESS-VER: 2019.1_20250123.1616
X-BESS-Apparent-Source-IP: 104.47.70.41
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVpbmRkBGBlDMyCwtJS0txSLJMj
	U5Kc082dzS1MAoMTk12dIwJdHUzFSpNhYAUel+VEAAAAA=
X-BESS-Outbound-Spam-Score: 0.20
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.262028 [from 
	cloudscan17-217.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.20 BSF_SC7_SA298e         META: Custom Rule SA298e 
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.20 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_SC7_SA298e, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

The timeout optimization patch Joanne had set ent->fuse_req to NULL
while holding a lock and that made me to realize we might have
a problem there.

And based on that, I believe we also need to set/read pdu->ent
with write,read_once.

Cc: Luis Henriques <luis@igalia.com>
Cc: Joanne Koong <joannelkoong@gmail.com>

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
Bernd Schubert (4):
      fuse: {io-uring} Use READ_ONCE in fuse_uring_send_in_task
      fuse: {io-uring} Access entries with queue lock in fuse_uring_entry_teardown
      fuse: {io-uring} set/read ent->fuse_req while holding a lock
      fuse: {io-uring} Use {WRITE,READ}_ONCE for pdu->ent

 fs/fuse/dev_uring.c | 89 +++++++++++++++++++++++++++--------------------------
 1 file changed, 46 insertions(+), 43 deletions(-)
---
base-commit: 9859b70e784b07f92196d1cef7cda4ace101fd33
change-id: 20250124-optimize-fuse-uring-req-timeouts-55190797c641

Best regards,
-- 
Bernd Schubert <bschubert@ddn.com>


