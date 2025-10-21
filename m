Return-Path: <linux-fsdevel+bounces-65003-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C589BF8F15
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 23:33:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA7F018A41C5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 21:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E622228B7DB;
	Tue, 21 Oct 2025 21:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="tDJpr3mg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip168a.ess.barracuda.com (outbound-ip168a.ess.barracuda.com [209.222.82.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D2727E040;
	Tue, 21 Oct 2025 21:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761082427; cv=fail; b=WJVLE+yminDfX4MxEUITfVKhVEcIX7nuXVoRlovJYGXLRuwcc77L5Y92YMwfa/uOp+u50hN9gabwkmq/3lrWP1+O8PM13Ph2rST3IDsshqpH8GbVlmAS6wzSM1BSupQdbDl2o9QufG/F/1fSmbrupjbrvCKc/0nY1a0WtawZhos=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761082427; c=relaxed/simple;
	bh=UNQCmPK+IyaLbJ2nOF+j1cDEH+vq3U6EjWD76HMDb1o=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=uPBcb5EQVHmEX7lD/EqeN+HTTs/ukf4yR3sKj4I0w3w3VteX30MY31pQFjxMWkegNozfjoP2dbZWYbr8MsUFMVgIDWdfCR/m63QBopraCaTzcwiRtrNCYlT6hclkDMULEJUFzq1MiGyCdW2cAb9vI/jdmnsKgrMbVMQTyRQ+9tE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=tDJpr3mg; arc=fail smtp.client-ip=209.222.82.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11021090.outbound.protection.outlook.com [40.93.194.90]) by mx-outbound46-224.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Tue, 21 Oct 2025 21:33:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MhTWge4LRF9e0/HBX23l3VBURZ24eTTLWPCBp6tZmouVz1ZMoIHr7fTmSbTH7bnTfYbjKkM3ySTus6nWPtFQLGDV2fM6qCfTyaMR6Kbl8OutA79RNWENeayYta30lXAW+esItRl+Nt8eDG/CVymsShg22FmcwPTc78HNXg/HhUCdcMzOSUuCrs7u4pUUkNPlx6p6RWOiDfsXA4PT5FW3dkn4DNj+spadFD+ge7zcw99jYFPJ9xBP/TvqKoKbWeWzIyL25JglMfoVBe+SxCeSgK/fXCqmbEpg8iQ5bhx1BiDnsOdyEPH0K+GIRFvJRQTOhs04F1lk6T8v8FmhauNPGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bb8Bj4tcrVdPjfCnz9cPZI72QipMHCrtRx6Ngqq6N9M=;
 b=BpxEW8EyfW1W3UJWb6Ak7+KaonW8k6G8LKNgjojF/s3/NzOo3owEX+Q66p0Yy86iBIs/H9cNinLWfJu9zToKLJOjJLyxk6JQMqzuRPa2tk395N25So5TlC6NzEUnrQsEioqC/kgjj/nH06jsks2q60pQxD8BlqDOQWlKEh8ZDCTUaux9ziJOxrwSDaix1ZlkJwKawlb9ec5xeV+NuqNmmWsu3JTs3aPGaKOxdtNJlfkjghVi9UeRj16QGQxrVTq6zSClE5JaVO6q9X91kJwrqheqT9HvHoPiru1EHONdsnZuU2uQrzq/w/XwBfyVjKNQ2Y1h9sDITKTp06aXoZVIoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bb8Bj4tcrVdPjfCnz9cPZI72QipMHCrtRx6Ngqq6N9M=;
 b=tDJpr3mgy6XnNh48KpencBGTyBBw+qNgkLf6AoqLsxrquViE0V4H/SLk8F3VC1bOQITkGa4DsJq2vl+nY5tr/Ewp3RMhLcD9EHj3r9k1ycbk3w4+oOMZNzHGxsrp06n4dGR+GOtEzQzCtompclGP5LjtPchch3uCUGYJNIZkk2s=
Received: from SA1P222CA0107.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c5::28)
 by DS2PR19MB9292.namprd19.prod.outlook.com (2603:10b6:8:2d0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Tue, 21 Oct
 2025 21:33:35 +0000
Received: from SA2PEPF00003AE7.namprd02.prod.outlook.com
 (2603:10b6:806:3c5:cafe::c8) by SA1P222CA0107.outlook.office365.com
 (2603:10b6:806:3c5::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.12 via Frontend Transport; Tue,
 21 Oct 2025 21:33:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 SA2PEPF00003AE7.mail.protection.outlook.com (10.167.248.7) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.7
 via Frontend Transport; Tue, 21 Oct 2025 21:33:33 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id BFB474C;
	Tue, 21 Oct 2025 21:33:32 +0000 (UTC)
From: Bernd Schubert <bschubert@ddn.com>
Subject: [PATCH 0/2] fuse: Fix possible memleak at startup with immediate
 teardown
Date: Tue, 21 Oct 2025 23:33:29 +0200
Message-Id: <20251021-io-uring-fixes-cancel-mem-leak-v1-0-26b78b2c973c@ddn.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACr892gC/x3MWwqDMBBG4a3IPHcgGS8pbqX0IcS/OlSjJFQEc
 e+GPn5wOCdlJEWmvjopYdesayywj4rC5OMI1qGYxEhrjVjWlX9J48gfPZA5+Bgw84KFZ/gvP8V
 0jXTOhdpRmWwJ/7A8Xu/rugFjrL0ncAAAAA==
X-Change-ID: 20251021-io-uring-fixes-cancel-mem-leak-820642677c37
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Joanne Koong <joannelkoong@gmail.com>, linux-fsdevel@vger.kernel.org, 
 Jian Huang Li <ali@ddn.com>, Bernd Schubert <bschubert@ddn.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761082412; l=817;
 i=bschubert@ddn.com; s=20240529; h=from:subject:message-id;
 bh=UNQCmPK+IyaLbJ2nOF+j1cDEH+vq3U6EjWD76HMDb1o=;
 b=rmy1oAAcEELMYGzGeshDpdrZ8wwOyK7tpHa/O15A5Bu8ptdHmDcjjMYv1YlktBsKt+enOQ106
 PvZuLNXA73TBMavZZMsOMn2ncLTz2LX6P1+Es+KJQJwunNBz+AE6W4r
X-Developer-Key: i=bschubert@ddn.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE7:EE_|DS2PR19MB9292:EE_
X-MS-Office365-Filtering-Correlation-Id: f9d99641-1f29-4b04-c726-08de10e97c7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L1FjTUlwUlgvNlMyaXRSL2dURHZtVkZ6MUpZaHVia2hTN2lNVCtKWnlzcnVq?=
 =?utf-8?B?Q3FyZ3RHQWh0ZHBNcFJVY3BGUUZJMy9kU0VUNmhQS1A2OTJKNjZZRjhWWEN2?=
 =?utf-8?B?NHRRS0RQVVJsUDV1LzhHRHpZMmI0TkVwYlAycHpnKzlpeDBkVmt6SVFMWExL?=
 =?utf-8?B?bjZNanJHNXF3UzBjRytaZFYrS0R1L2RYaWVtRHU2OFE1b0oxdEl5VEd5QVRa?=
 =?utf-8?B?cmRseU9Ia2RreW1acUJjb3JoUFRrVS9nMDMxUTNYeElhRHdOc0lGWXFLVC82?=
 =?utf-8?B?RExkQUpXUlovQzVlRFVGUENCVE10anBmOCs0alhyWFZ3NGM1S0FZbHlLM2pK?=
 =?utf-8?B?azBtR0MvRFI2cDlBMWdKWmkwNkt5VG0xS0NCeG5EbndFVm1NbHpoS0cwQlNZ?=
 =?utf-8?B?VjQrMEJYdWw5dmZyMDlHMlQzRHhSN3ZIL243WXpzMXNvdE01bUxhUFNqOHNW?=
 =?utf-8?B?SXlmYXdHcTk2Wmg5eXg1Q1k0WFlyZTJWbzMxRlU4aUR5SjRFTnhRWEs0TFYy?=
 =?utf-8?B?ZXBqMUFKemloS3kzeXc2V1ZndmRCWC9ZeXYvSWRlMjl0eEQ2K3BxNmtSdXQr?=
 =?utf-8?B?d3VQY2lnWUJNSUlvVU51WG9rZ0I5enRsdTlRSFZWYWxRd0ZJekdYRG82RnFW?=
 =?utf-8?B?N09GQUcvWCtQK2Y0cHRWNXdEOHFhRVh2RVFLbnJqbUZIbmx0NVBsbjMrWFhW?=
 =?utf-8?B?dDhWRXE4T3R0ZXQ4cXZMWlMybWJHb0IwK0dkblQ2cDg4TXRCOTJZdG01VEVH?=
 =?utf-8?B?RTJhVkdCNXRZRnVlVjg2MTQ4OEJueWlVcVJ4TDcyQVdEVmRmY0dETStRdHla?=
 =?utf-8?B?aCtnZ0Z1YWlKZldkVFdlcEszY2NHOW5XcFVBMHJQWWduYVhuOWtjVExkbVZ2?=
 =?utf-8?B?N2xORkQ3WUx5ODdma0FJUkhzRTMyWGhPczdUVnhvdXFtT3d6MFVZdVV6a3pk?=
 =?utf-8?B?bHlkNzZLcmFlcHhmWWMwUVlQb0FBRUdmUjlGRnZLRWJRUk15aWxoRFdwY09x?=
 =?utf-8?B?S1g0WTgwTThuVER5dGVMeUFITXdQUWplL1V6OEdzdjZmb3N0NTFsM1Z6Mmd3?=
 =?utf-8?B?SENuRDloSEpwRlZ3Q2VnTWlkK1R2VGphZzN1c3E5VXBJUmR0TEc0ZnJJTERD?=
 =?utf-8?B?ZyttVmN6dVpLek5QdC8xdVpRK0ZqVy9RZzl6TEJ1enlFZFNDdVhBekIwRnJi?=
 =?utf-8?B?c1ZnSHYwcUFUR1RJbms4R2FwOCtlazdmNVo2eDhuVlFvMWlNMzBDSUtVT1RE?=
 =?utf-8?B?Q21DNzJwY2luUHdoTjkrWXRUOVhJQzJ6eDBDYjVLSnJPTmtaaVJhRWV1RjFG?=
 =?utf-8?B?eU56M0M2bnE2bkZJaEZRK2hrZ3liMXR6U0RFSm5na3ZEM0tLRis4aU92Yzcv?=
 =?utf-8?B?MWZrUndTUFN0NStsbzlSQUF0THNrRGpwZG9JR05pSkdYMzNPK1BkZGR1RDE2?=
 =?utf-8?B?UXAyTmtXMFd4L1doVnJJNjBtSDlqRnRKdFRXRkM1aXZhSk1ZQ0NPT2JOdUVK?=
 =?utf-8?B?SXhsMElmOThIQjRZU1lkbkgyeDlIaVozNFBpQWhHQlF0SjhQTlpTNkJMckxG?=
 =?utf-8?B?c0FzdEZKUjFkNmFHMnVVQUV2bUh6TWN3c1MxU1JNd2xKMFpWbXIvTTYyTnpN?=
 =?utf-8?B?Q3JQcXZqanFVVzNBN2MxTjkyS1VmcGpPN1Z0bGxtd0VQWjYydVN1MlU1VytI?=
 =?utf-8?B?bUhhVktCQjdpb2tNWjR4QVljWGJQaXJQZlhFNkZOMm5JOWVINyt1ckN1aU5r?=
 =?utf-8?B?TEIvbTZ6cGEvRHNkQmlBMkZ0c0EwdzdMQzUvQndmbWx6R014NFFNRFZzM1M3?=
 =?utf-8?B?SWUxdWdBb09FTGoralVTd012QU5aK2h4NEwzRStBUXhTanZqRzV2L3Vvd3kx?=
 =?utf-8?B?ZVAwd2JxT0s4bzVCOW1obW5WOVRtdlhmU2NnNS9mM25mRlJaNzdBWGd0eE0v?=
 =?utf-8?B?Mmd2UCtlVlBJbkRyTFVtdmZvOWZ1dnVsOUFUbUNsblVGbUNXaWtnUFNyRjQz?=
 =?utf-8?B?WWRrMU5VTzVZRUpFU3BqekZWZC9oSzZFdTlsajJkUTRrWVhBOXZScHM2M1g3?=
 =?utf-8?B?MjRXSEJyQWJZVktIYW5ESFZwNy9VVVBTWHpaUHUrdXJIcTFWcWxDSTBpMXlB?=
 =?utf-8?Q?AtS4=3D?=
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(19092799006)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	XYzsHgcU/wY8otI9OMRJkKbwV8WSBJ7aogsGOyym9ifYrKgrMohdXYis5ldm59y4S9iIIkac1cQOmuBs1ox/4WpSBmy1yWKk2BouoZOxPldHnn+nrKEnsbtR8cusplvyn/o48Du2kwh5D/FqpVDCsEGfnFp7L0fC3MxBWrSyP1EirHhdKnBKJBhSr/AQL12bT1X1cmgEk1QYcCrxpVbpj5jCYVztEpDg79OuBbwJQweKoysi5eaecxVg2JZzxAc/b8FLIsNAvQ9iP0ZKlB3njoQpJrgRoS8ZLcWKw8giHDmqxdqjTisr/74tlqdTaiNriw3CptE5hpGm+tVRyPKkdq6tvfeM3iC9Kh11pJI/9Jrszu+Dbxz54le5s7aVWZiFHgA/n+o+tf5a6nncd18csK8q9NQ8Drjngf3FJfmDFENGAEwuOBdTJsaCSkB/rkLXUZqe65YDCpvUnMlyLU6mj6OzkZI8PkAEv3I7746izOnvE76VZX9vhkMoXEfTZlfHQO5oAjtIi7GnLEqJ3Y47KckPNMs3T8RSx+cggIpF1jZhKD1+LGMYctthr8uvWuGclQt2GmKF8tIlkXGcxqFX/Ffofcklfe4G62H4ImXhHvHDzrl3TnWt5INj+vs3KXimmAJEVSiJPHHz/tcSp4oneA==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 21:33:33.4525
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9d99641-1f29-4b04-c726-08de10e97c7f
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR19MB9292
X-BESS-ID: 1761082417-112000-7613-12978-1
X-BESS-VER: 2019.1_20251001.1803
X-BESS-Apparent-Source-IP: 40.93.194.90
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVuaWpkBGBlDM1NLMyMQ4OcnCIi
	XV3DDVwiLVyNzCPMnSJDXNNMkkJUWpNhYA/fyofkAAAAA=
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.268377 [from 
	cloudscan11-165.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

Do not merge yet, the current series has not been tested yet.
The race is only easily reproducible with additional patches that
pin pages during FUSE_IO_URING_CMD_REGISTER - slows it down and then
xfstest's generic/001 triggers it reliably. However, I need to update
these pin patches for linux master.

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
Bernd Schubert (1):
      fuse: Move ring queues_refs decrement

Jian Huang Li (1):
      fs/fuse: fix potential memory leak from fuse_uring_cancel

 fs/fuse/dev_uring.c | 33 ++++++++++++++-------------------
 1 file changed, 14 insertions(+), 19 deletions(-)
---
base-commit: 6548d364a3e850326831799d7e3ea2d7bb97ba08
change-id: 20251021-io-uring-fixes-cancel-mem-leak-820642677c37

Best regards,
-- 
Bernd Schubert <bschubert@ddn.com>


