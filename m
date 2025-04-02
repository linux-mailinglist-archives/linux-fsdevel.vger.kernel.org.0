Return-Path: <linux-fsdevel+bounces-45543-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE4C5A794DF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 20:13:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3D233A5287
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 18:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39AB51C8FBA;
	Wed,  2 Apr 2025 18:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="qx0x3Eqm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip191b.ess.barracuda.com (outbound-ip191b.ess.barracuda.com [209.222.82.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B251C5F13
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Apr 2025 18:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743617612; cv=fail; b=cGhzZPQXU9uqhJBJqjIEr5nO3MiEluCxdwSUWlaCaIVsk5m6EH7UldtN73iLknQohOBpoAPBZC4qiqVxLTnYEshQOyAkrqOAKW+NcoKfrtm9W7QbLx5GEZ8iehTajTsmzF3O8DC59YgDkRcoeRAvIzAPbPUrhLy4YRDDu97540E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743617612; c=relaxed/simple;
	bh=ziYZV/W/d52W8kKfIYz5/3su24KBpyjnMK0qQasJq7c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aSwrd1EFCE2Sgm276an+jOorSlJsFyFzrsPYXTIS49YE1Lzkareh4hyscVIluoRdEGCnM4aVwQ8WGwV8dmtWMjdBdEegsvbYwR+MPeHCoJ6LzgczUw4SWQmF66Pg7IL4t2B01QlXHrKLyBbdp5GbOn2YDrjyxp3FcBwJU29PdHI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=qx0x3Eqm; arc=fail smtp.client-ip=209.222.82.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175]) by mx-outbound22-72.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 02 Apr 2025 18:13:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nooMoxcU2cGrGMlzs/7qTgFF+0nRmoJ+GbiMLRq9l5GvzBqOMuYmua9Pzho95Ja+MJpvTcuu+TC91f7lFIlYz0z/TYuPuPUEBoRWaFJxaC8UJIVavOdPt8rRJAZPeuq8zIeODfXkyqaGn4AxpN9wxDQB5v39FkdxfefB2E2jN1Qi1I/VBisFM9SIyaK22eJ0ViWqfNDiGYmkxUBQYHTX6rtXRH9v7xWl16xiKc9pZTDS4MAJQWG/VRFKi52GLn2pk5g+a6v8MV87WsIzYKe6IxjaOXt7FS+/PDzGG/yEczAh+wl2E7SP/WUWizjaFoar8zLgLU6s3/XBHf+Ku4faHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y/tm93HuADKuq/51kxy83RJV/L4xXQ5WraSoBE7nzxg=;
 b=KSA8d/rP0aWzV+KTb2yb1y5OB/crZql0GT5alghhwZNS71fV9Sg/bt7IHHcBV5hC/vqIyoZWLv8ufoFITiu+YSyMeLMsi2pJknE4TY85Yn18JKZXC8hMC7iOjbKrnktmtPLGscD/4Rs7z1HvHRbvRmhM2ENUXSNm1t36yTNS3oV77oNA5VzALFiqzr0dY7k/cfSf8KdnJjUrbg0bjibC2mchzrEpGzqrnGVX4PGmldGOgkKDqWbgxOKBvCHbjwmhVmH84qWMV+69LNGxeXs1lSLZ78EvQfGT1l+1PNlZX6PieMpcptTd04xaaP/Dy01Y+8xzJAOa1duBWan5fXgRLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y/tm93HuADKuq/51kxy83RJV/L4xXQ5WraSoBE7nzxg=;
 b=qx0x3EqmfVlepkvQHondwpPuw//XibFh2QBZgqDLrcqXWD5in4yFb3CUPaenRINB8Ti+G6rm37NSVuJTGIOG3UwllSOuvp/UwYyzK5/pA9cx9wBnThABtnrZ8mOli/MnZ4GF8/08UBroaVtfvdmVw3xkwgdngQcs6b4R5jIo2OM=
Received: from SA1P222CA0110.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c5::22)
 by LV2PR19MB5792.namprd19.prod.outlook.com (2603:10b6:408:176::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 2 Apr
 2025 17:41:02 +0000
Received: from SN1PEPF0002636E.namprd02.prod.outlook.com
 (2603:10b6:806:3c5:cafe::ef) by SA1P222CA0110.outlook.office365.com
 (2603:10b6:806:3c5::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8583.42 via Frontend Transport; Wed,
 2 Apr 2025 17:41:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 SN1PEPF0002636E.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.22
 via Frontend Transport; Wed, 2 Apr 2025 17:41:01 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id DAEC165;
	Wed,  2 Apr 2025 17:41:00 +0000 (UTC)
From: Bernd Schubert <bschubert@ddn.com>
Date: Wed, 02 Apr 2025 19:40:52 +0200
Subject: [PATCH RFC 2/4] fuse: Set request unique on allocation
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250402-fuse-io-uring-trace-points-v1-2-11b0211fa658@ddn.com>
References: <20250402-fuse-io-uring-trace-points-v1-0-11b0211fa658@ddn.com>
In-Reply-To: <20250402-fuse-io-uring-trace-points-v1-0-11b0211fa658@ddn.com>
To: Miklos Szeredi <miklos@szeredi.hu>, Vivek Goyal <vgoyal@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Joanne Koong <joannelkoong@gmail.com>, 
 Josef Bacik <josef@toxicpanda.com>, Bernd Schubert <bschubert@ddn.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1743615658; l=2914;
 i=bschubert@ddn.com; s=20240529; h=from:subject:message-id;
 bh=ziYZV/W/d52W8kKfIYz5/3su24KBpyjnMK0qQasJq7c=;
 b=EjvUYIPqrjJLjTCoGGesC3+7HHJz+Ww7VfOgAaN1LvKrmdHwiT4Tu5zaub632DnbDHi2yw5sj
 CQ+Q7fHZbE4DTFOjMr7c9ab0EHY5JgVfqMyfzq708L3Ezk1svquQ5Us
X-Developer-Key: i=bschubert@ddn.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636E:EE_|LV2PR19MB5792:EE_
X-MS-Office365-Filtering-Correlation-Id: 04206b5e-2ac1-4baa-a622-08dd720d8934
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?cStFWi9DY2dYWDc3TVBRRFc3OE1OVG1nZUs4NWd1K2lqUnUyLzEvQUhsbm5V?=
 =?utf-8?B?TXNxTytEMkxMYlo5NVJpdnJCanBwb0d0OUNxL1owcjJUQkVxQmNzaVRMaGEx?=
 =?utf-8?B?UnlqaHdFcHliYmJVcGhsMVVmblVDd2hhcGk0ZkJsbmpZVXZnUzdaSHhSMUZ5?=
 =?utf-8?B?bWRuK0tkV0xMTUNOUklIQ1l0U0hnV0djck1SN0l0cHNiUDZ5ay8xMzJQWjZs?=
 =?utf-8?B?U2hvRnczRm5RUTUrUGszaVZaV3hiNzFXZHl0ditUZkl6dTdMcTk5MEUzVy9q?=
 =?utf-8?B?THBrM01aQTB3Z01HV1o2TjhQVXRVbktBK1RvYlVYL0NERDBiM0h1eWtxQk5G?=
 =?utf-8?B?RVNZR3Z4NmdLRlFrRlRIOFIwVC9Hc1pxY3hwc0xhbmtCdnBXUnAzTEh3bjlM?=
 =?utf-8?B?emdQbldJaXIweE1OT0Y3Q3VzR0tGdW02UC9EK0hKU24rTFN4NnE0L2VxUGds?=
 =?utf-8?B?Mk1uTDI5Tm5pQUk5K3ZqRFlTc2RRVmZUd0M3NXJCc1QvN3dUOFlhV2JHSzhI?=
 =?utf-8?B?d0FtR09DZ3YrQ3VyTUZTOE5uZUVaSFBKbGkrTGJ6cGt5YUJ4RXpmUHZCMEsv?=
 =?utf-8?B?ZEUyQWxvZDFndUpIQ083SmI5MUppSUhyNnFQUWZDTitvSW5KUmxTSVVmTnpp?=
 =?utf-8?B?alBrVU1RSTYrZjNBbzBWcHBMN3ordlR0RFJhaU4ydzJET29CdytGcFFWRGpj?=
 =?utf-8?B?OE9PNzRqbUE1cDBLaE9OV2pvQU12TWNkYU1FUlU4bitka0E3Wko3YjVqRTIz?=
 =?utf-8?B?eGNVRzVnUkFzTFl6TVBEVFRUWEVnVTFjTEFDNXF2ajVOa2w3ckhxNmNJVy8y?=
 =?utf-8?B?Z3pIQjFVMzlBU1lOV3E3RkgzSlAzcGhtWkxiQXR5TlE3bFI1OFBtZXlyb3py?=
 =?utf-8?B?cDZYc1ZpdDVPRlpxNHB1ZUdZMU9OR3BIM0FkdEN1VFp2VzZ0UitPR2U4eDB0?=
 =?utf-8?B?dldvTzk4QkxFWXlnUC9SbzdsMDdYcXNWd1FxL3QzK0pPdTJLTlJpdGg1WWcz?=
 =?utf-8?B?OHBOU2Z1OTN6d3FDRDdqaFA2UVJwb1d5T2ozOTdzSHRJV3hqVG8wUitZN1RG?=
 =?utf-8?B?bVE2ZmVtSlNHTmhtc1c3UTBtVzQvcDNMSmcvcnJhZTN0UkoxbGdYR2JhWFcv?=
 =?utf-8?B?bzh0VFNHSnBMWW5TMEQ1LzFWUjZZNnpyaE4zand2UTkzQXZlOS9iNDJYalJS?=
 =?utf-8?B?dVR2NzRHenpiZDh0WEtmRDRoNjZpYW1CL0VMSTFxekxCSk02MnFJbEdwN2RH?=
 =?utf-8?B?cUpHaEZONlB1SERGZWUvM0g1QkMxSXduYmtFNXQySjlCZXUrNUU0TUFZSFkr?=
 =?utf-8?B?LzNRZ0NxcXFJd29hZ01ReUh2Y0hSNUthb3VPckdJWFhUNDkzSmM0cVNVOXZX?=
 =?utf-8?B?Zm5XYlNsRVNZbUJmN0R1UDZvL3JpcCtOOE9pNEY4UXN2V2N4bjhmV25nRk52?=
 =?utf-8?B?aWdHamM5c21IbjExZzZuTTlCVmV2R29Pd0VWT00rOC82dDZIYTBnQlJJc2VQ?=
 =?utf-8?B?dGtTRWJtMUV5Qk52OWI5djl2TzlGVEJWa0FYaVFFREhJYU1LVnNXT2VUcjBm?=
 =?utf-8?B?dC92S2RmbDFLN3ZzS3dhVzV1bkZ6MUJ2WGRZSDFkRE01bnEwMVp2SVpRYmFz?=
 =?utf-8?B?bFBUalRiaVBSNGQ5a2xIaUFwWjJncHZNYWRQb1QyM1J5Y3ZoQlBFNUN3QnJW?=
 =?utf-8?B?TUxCWXB6M2F4bmZxN2hOejNaZU8rcmEza3F2aVRCaDl4ZEx0RzJoWHZ5c212?=
 =?utf-8?B?ajl4bzZ5TkdyNHBiUDA4Mm5Ic3Q5bVpHdnoyTFhhYjhtdHhEajdZOCs1M2JX?=
 =?utf-8?B?c0Rudlo3VUY5VDRUZjZRMm52MlVEWXRZTklxcVVGdnk0ZCtkYVcyQ1pkRW96?=
 =?utf-8?B?dTZSTmJVKys1anJiNzU3MHFvVDRLeG9DcGpBUlRENVlER1ZXY3BlcE41cVhy?=
 =?utf-8?B?UGFBdjV1eGd3L3RGeW1WRkJuNmJmMVduSlRRd3RON0ZyMHFKZXVWSERBVmxw?=
 =?utf-8?B?czZFcmZkRDRtcjlQUWNFQmNwaTBsbFpvUkREdGNjZGEvYnVkbTVZL1BxV1hu?=
 =?utf-8?Q?Bj10Bb?=
X-Forefront-Antispam-Report:
 CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
 iewMSV44R777UYbL1Y3Vv7PEtD6/Ilsz5b1k4LTOqjHl5U+5pJmFvT/yBb5i0FMD0Trd2KjGPCCVStzKUQYNnjKkAwhxQu9xiinPn2OJlYYVG2Q2O6S7ve8obn0yJgve0XIJk3EKfZiNRtcXFRwTp0wHNbwSIi5inC9uzioUGvIXj/1WlM5rFxURS/v1sucWCVy2YbrzfVrQsoWZSgkzl40zlvHD2oxLOuxiV1JsuUF/xYcrEFU+neIsMcfDKDVhBBxBM6rFihVOhfaV4OV/xWrY4CoIdDfrgV7+xQLPpX17G5HgF2TG6c1VTqmrdIqCOCi+CeeihlfNbq29wdKlD7Ogwhm7z5auTrZOhLxZWnRPrXr96iqgbgkRcdS+OiSl56wqP1BfINfdlqQv7oA4RQyfU9NtV0zGkT+xMU4uP72qTWP5UrB8kZuZPwbXLCc18GXNIHn0OM62xMSm/YGOnVTONV7/qjj7x4McXZC6u5CuqZiJTgJeYP0qP+wsPQLxCZb1Tdj4SANlSqaRlPtuU51QdH11fE3VVZSgkfecdg4CkyWLeSRWKVScKmsWudxLIx1SEgWnCxkavli+nXjQOmA3mtHfZ8FJrulszl+Q9p2pNtev7hQsfPP2cWqoQH9fQ+DgQuOokJ58gZ8IE+TZEw==
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 17:41:01.7142
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04206b5e-2ac1-4baa-a622-08dd720d8934
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
 SN1PEPF0002636E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR19MB5792
X-OriginatorOrg: ddn.com
X-BESS-ID: 1743617608-105704-7814-4390-1
X-BESS-VER: 2019.1_20250401.1649
X-BESS-Apparent-Source-IP: 104.47.57.175
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVkYWxmZAVgZQMNUiMc0g2dA0Mc
	3S2MQ8zSzZKM00Oc08KdHIwMIi0SxNqTYWAEQDCDNBAAAA
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.263603 [from 
	cloudscan9-45.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.50 BSF_RULE7568M          META: Custom Rule 7568M 
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.50 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_RULE7568M, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

This is especially needed for better ftrace analysis,
for example to build histograms. So far the request unique
was missing, because it was added after the first trace message.

IDs/req-unique now might not come up perfectly sequentially
anymore, but especially  with cloned device or io-uring this
did not work perfectly anyway.

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
 fs/fuse/dev.c       | 8 +++-----
 fs/fuse/dev_uring.c | 3 ---
 fs/fuse/virtio_fs.c | 3 ---
 3 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index e9592ab092b948bacb5034018bd1f32c917d5c9f..1ccf5a9c61ae2b11bc1d0b799c08e6da908a9782 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -259,8 +259,6 @@ static void fuse_dev_queue_req(struct fuse_iqueue *fiq, struct fuse_req *req)
 {
 	spin_lock(&fiq->lock);
 	if (fiq->connected) {
-		if (req->in.h.opcode != FUSE_NOTIFY_REPLY)
-			req->in.h.unique = fuse_get_unique(fiq);
 		list_add_tail(&req->list, &fiq->pending);
 		fuse_dev_wake_and_unlock(fiq);
 	} else {
@@ -508,6 +506,9 @@ static void fuse_args_to_req(struct fuse_req *req, struct fuse_args *args)
 		req->in.h.total_extlen = args->in_args[args->ext_idx].size / 8;
 	if (args->end)
 		__set_bit(FR_ASYNC, &req->flags);
+
+	if (req->in.h.opcode != FUSE_NOTIFY_REPLY)
+		req->in.h.unique = fuse_get_unique(&req->fm->fc->iq);
 }
 
 ssize_t __fuse_simple_request(struct mnt_idmap *idmap,
@@ -555,9 +556,6 @@ ssize_t __fuse_simple_request(struct mnt_idmap *idmap,
 static bool fuse_request_queue_background_uring(struct fuse_conn *fc,
 					       struct fuse_req *req)
 {
-	struct fuse_iqueue *fiq = &fc->iq;
-
-	req->in.h.unique = fuse_get_unique(fiq);
 	req->in.h.len = sizeof(struct fuse_in_header) +
 		fuse_len_args(req->args->in_numargs,
 			      (struct fuse_arg *) req->args->in_args);
diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index 82bf458fa9db5b2357ae2d1cf5621ed4db978892..5a05b76249d6fe6214e948955f23eed1e40bb751 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -1230,9 +1230,6 @@ void fuse_uring_queue_fuse_req(struct fuse_iqueue *fiq, struct fuse_req *req)
 	if (!queue)
 		goto err;
 
-	if (req->in.h.opcode != FUSE_NOTIFY_REPLY)
-		req->in.h.unique = fuse_get_unique(fiq);
-
 	spin_lock(&queue->lock);
 	err = -ENOTCONN;
 	if (unlikely(queue->stopped))
diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 82afe78ec542358e2db6f4d955d521652ae363ec..ea13d57133c335554acae33b22e1604424886ac9 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -1482,9 +1482,6 @@ static void virtio_fs_send_req(struct fuse_iqueue *fiq, struct fuse_req *req)
 	struct virtio_fs_vq *fsvq;
 	int ret;
 
-	if (req->in.h.opcode != FUSE_NOTIFY_REPLY)
-		req->in.h.unique = fuse_get_unique(fiq);
-
 	clear_bit(FR_PENDING, &req->flags);
 
 	fs = fiq->priv;

-- 
2.43.0


