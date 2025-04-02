Return-Path: <linux-fsdevel+bounces-45541-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 227C2A794DD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 20:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE3E916CFB7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 18:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B13B21C5F07;
	Wed,  2 Apr 2025 18:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="viZlnAd1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip191b.ess.barracuda.com (outbound-ip191b.ess.barracuda.com [209.222.82.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF631C84DE
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Apr 2025 18:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743617589; cv=fail; b=L301lIpPPFdf1pIGNECHvYBRbetV5hqQkIr+aka2kSlSN5+dvaba0PekTvECJJLZrpuzcBGMhOAUsoAegxvIGuhu3tLytOx/4F5LBkOFR10RlGkMB1qnweIO/N1fvGIMQM7N4ZJJxR3MZXrDjM5/rs/aQgpFzqmndJxUGfq13rM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743617589; c=relaxed/simple;
	bh=t/qWU7S8DFwFw1ltRPZymLwhxW9CiMD3+kpjL0lZZRE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XKCATEIigzrL3H7TMCQZ4lKI0aNefO2ukcOd5io+TxV7p/33xdbrPCtCD5qHokodyS4QwIHW4SLP1or3BYfKUs6OlREDTWQaDg/oY3QvWK4kAk1XOUytOPWYYo6+EBHJft5Y52M0W0JWeyJ6k0Vt5IWtdzuSs/KsmQhUOBvqe5c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=viZlnAd1; arc=fail smtp.client-ip=209.222.82.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176]) by mx-outbound43-133.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 02 Apr 2025 18:13:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wK7FRoICOy7PZ9FZ5q0DaSHUbwb9XRuu3h5/aeNt91deVi/Komxr1gKg0EJN4ysNlZtO/SjwxUPADQmDMBglhyL/uh9Gs0l7Rl/9HkjQoAq/jVzJ0BFXs/aG7JvJvtAUd7dtGZKFWmZITWBQWWCeuKYNgmrGNmDJt3LD2Xh87NBIdfVwzOEIPgAAz3AE/VrwvrpsB4k++vBmi1zA6hAevoPp5sLIrSZpo6kfjBh50w2qOJwHn6C/5mL6NDWfv1/ln75drG+FN2baSchO6gLShLGo4QqgjNCsY6UOFMA8xfBsEuXb51gUfJc3c9ocw6q9WPbev8g1XVCXi0jnYHlp4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w9c4thro/65LNTQvw9TViG04eyuC/g4rHehyEfqiU64=;
 b=hW5apI3wAOCVZtIriHgqlNefqcMR5Z7JFgJo9PMuKg95d1+1H75esrMBmjfP+DtB4TsTaWZMvcD0RgQYajv8IJecx2iC2SGPnp0s33DBhRo1k+b/hsRttIIlriO+KX1UJ3whINx4N8ziQ1vgMHgFxfQqe6TANGMdrp0+rYJTSU1cAiVfEzUCPxmfwg0sT7YW2sOvcAYD/6e225fS8WdDYA6Ii+hGfmU1mc3xLCPpVGRh6gAQQz/DOykK4pVOQ9UBUs9OanwW8ToD3nj6HE3amG3mGbBYLAuHAEgO3L2Evo8shHrGHX80bN48h83b5ZbzhN8ozYQDJKg7zWGR07iDUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w9c4thro/65LNTQvw9TViG04eyuC/g4rHehyEfqiU64=;
 b=viZlnAd15x49viFZQApGrGJayzVaXXIBG32FPV7nNb2vpPWqeEDnNOpeQPwfO6GhYl7SSB8p44HUZEblk8Ys0foexU2P5Pi1VBnDvXVIW+OmIM9muMaE/FI02j4nBwjq8Fp9+10zGHePPCoQkjHvx6eceXDkgQuibH7cAtL1BLc=
Received: from SN7P222CA0030.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:124::25)
 by MN0PR19MB5756.namprd19.prod.outlook.com (2603:10b6:208:377::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.54; Wed, 2 Apr
 2025 17:41:03 +0000
Received: from SN1PEPF0002636B.namprd02.prod.outlook.com
 (2603:10b6:806:124:cafe::fb) by SN7P222CA0030.outlook.office365.com
 (2603:10b6:806:124::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.24 via Frontend Transport; Wed,
 2 Apr 2025 17:41:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 SN1PEPF0002636B.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.22
 via Frontend Transport; Wed, 2 Apr 2025 17:41:02 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id D1BCB4D;
	Wed,  2 Apr 2025 17:41:01 +0000 (UTC)
From: Bernd Schubert <bschubert@ddn.com>
Date: Wed, 02 Apr 2025 19:40:53 +0200
Subject: [PATCH 3/4] fuse: {io-uring} Avoid _send code dup
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250402-fuse-io-uring-trace-points-v1-3-11b0211fa658@ddn.com>
References: <20250402-fuse-io-uring-trace-points-v1-0-11b0211fa658@ddn.com>
In-Reply-To: <20250402-fuse-io-uring-trace-points-v1-0-11b0211fa658@ddn.com>
To: Miklos Szeredi <miklos@szeredi.hu>, Vivek Goyal <vgoyal@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Joanne Koong <joannelkoong@gmail.com>, 
 Josef Bacik <josef@toxicpanda.com>, Bernd Schubert <bschubert@ddn.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1743615658; l=2416;
 i=bschubert@ddn.com; s=20240529; h=from:subject:message-id;
 bh=t/qWU7S8DFwFw1ltRPZymLwhxW9CiMD3+kpjL0lZZRE=;
 b=mJoMr5Qs/hKit2AXIaU/I0ABXVAaSBA6h/F0WIkBAZIZuumrsPS2q8XVDuFthcnkMEI3uJwuo
 zSbm8KP+LGXB7cICg/nD+21FOO0w50kzoh0OpOhEEbmudb7U5561kFG
X-Developer-Key: i=bschubert@ddn.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636B:EE_|MN0PR19MB5756:EE_
X-MS-Office365-Filtering-Correlation-Id: 35577b6e-c763-4aa1-a15b-08dd720d89be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?ZVJXWUM3UzhQRGNOMzdOam4rV3dZYVNXQVpRVGExeklJcXNPK2M3S0ZKQS9w?=
 =?utf-8?B?L0w4cWowR21RM0hxUDNpeUNqVW9wckFXaVNxYXlueXd4L2g3Nmx1b0c2YTBT?=
 =?utf-8?B?M3ptVGd3SmZxU1N1RElkQkJYcG1VaktNSzNCV3NqMWJ1QlZ4KzVoUEY5aXBJ?=
 =?utf-8?B?T0NxQXhGUDkvNWNybFY0RXZQcUFwT25QcllQN1Bzc3dBeDdrWlkrQmU3VzVD?=
 =?utf-8?B?VlB6YXNvWDYrczdBNy8zd2dlZWpZRWF1a1p6SDFMZGFobFhpUHZmWnkzN09I?=
 =?utf-8?B?TElyZVJHYmE3SHVzWElISmtsUEhwakg5RHJnYkh1MFJ4ek8zRDR0Zm1DeExZ?=
 =?utf-8?B?dkRIWEZQVE42eU9OL0VUT0VNOTI5UmNSU0dDN2I2ME80bGZWYXVOdzUxOHRI?=
 =?utf-8?B?T2dMVC8vUE84ZmluY2ZhZTRuczZoZ2R2OWxMRHdiN1o5NmRva1RIdWN3WGZ2?=
 =?utf-8?B?RW9CRzFQNzhDT2NvTzJLRWJnNkZaNWRrOEd6V0RNWlY2N3NqajQvbERuME42?=
 =?utf-8?B?a0ppZ2ZZVlNYczBabXY1YTV0Wms5Zm9ES0pFU2dpQmlvY3dUa1FQbSthd3dJ?=
 =?utf-8?B?bmNGMjJlRHpxRTBteENMOEtmNGtJeUVqUldJQUZ5YXJBTVZPa0VGZVJEUlMr?=
 =?utf-8?B?czRpaTJmdGx0QWNoVURMRFBhV3hDVWQzRm56TWNDMExWNU9vaCtjYnhqR0ph?=
 =?utf-8?B?clhrQ1NlbnplYnlBWDliT2pqZnhhd2ZpT2RuRWJWK21jZFFXZUxxNWNWZ0VR?=
 =?utf-8?B?L0pOQjRyUmVQTlFSMExpd0tKMGpZZzVDSmVFVDI4MjVBcURYaW8zKzJheDN1?=
 =?utf-8?B?bWUxZllsTEdmOGl2VkxMeWRxM01hclRIK0pmRjBnNmt6MHlPTTduei9SbWkw?=
 =?utf-8?B?bGJRUnUvYjdJc1lPV01ybjY4L0xvemo4dTV3VHhxVHdlWWtneC9ZZ2o2UzI1?=
 =?utf-8?B?S1lyRXhFbGpFTDNQTDJaZmh1OE1EcjNZK25pa0tqVmNWV1ZNM3ZmeFRvS1Vw?=
 =?utf-8?B?U3RkakQ1Z1ZBTWt4SzdFc29ZM0RVaU9BeEVsVGpZRUk5NHN4b2t0eXZMS2VY?=
 =?utf-8?B?b0hkbkUwR1ladWVlTFBySkZrNkRPUko4eDZ6VGJqS3d4MkRNSVRnSU54eTht?=
 =?utf-8?B?NGNMNWVYb1psSEwxSU1jVW5ITndKWm5rb1Vubk4xK2dlWVFobG5PM0RLK1NX?=
 =?utf-8?B?UjdxU0k4aWw3Tk5mSlkwdEhsakZwLzYyZmhyNXFnem1QeHduemhwOTd3M2xY?=
 =?utf-8?B?dmJKUUhueVZ1T29Icis5cnRTNUY4K0FVeGdOQVF5NkM5cXVQZE9hVjJLcUFm?=
 =?utf-8?B?YndLeGhtUFRDanczcEQ3ZlJxYlJUNmRjdDREZGJwSlJ6RDZQQTB2WjVXK1Jv?=
 =?utf-8?B?MFhpOUJ0N1o4SVRmM3lhQ3N1WUdsMDlBTHhEdHcxSHNQSkR5Y0hzWUgvdXdE?=
 =?utf-8?B?NUI2Mk9EVUlTaDBld2JvS010WG4yNUZaSEc2UUUzTjVncUYvcEdPQzVUd0lP?=
 =?utf-8?B?eGt5WkdoT0ZUVkVvR3hnN3A4SGxSWUJmbnBxcVN5aHk2TWpTc3NUOE5GSXp0?=
 =?utf-8?B?b0tvYzB5NDBCMXlKVW9VMVpFVlA3cjNvQzRBcTVlcDBYNlMxcHZUaUYyMGtu?=
 =?utf-8?B?dEFkdWY0QU4wTWorOFdLM0RCdStlbUFJQXlaUkV6MlBkTXdQOVFaenBXUHZt?=
 =?utf-8?B?QVpUbHJTbDNoWG5VZVRaRzlPL054MGUzNHRvVDRVUCs1THhnT1M4RHBPU0ZT?=
 =?utf-8?B?V01Vam16aUN4b0c4MEtmbWlQZjJPYXlsRFcrZUF1K0ZOaTZFeG1VRzZrYnEv?=
 =?utf-8?B?RHJGSmV1NGV3WjgvMW5OaHYyM1ErOEU0TTRneThOT1ZwU3FsYWJNNDJUTVAw?=
 =?utf-8?B?c2ZMTEhJelNhOW1pS09kenA0OW5PYW5LQ043ZCtXSFZpaTdGV25QajNERkww?=
 =?utf-8?B?V05YcGhJVWpnbVJ0bGQxTzJIRzM2K1ZKZFVmY3Brc092TVV3VE5wWHV5NzVk?=
 =?utf-8?Q?UsvZzxM5GqTqrZuS02jMt5B1t8wDG8=3D?=
X-Forefront-Antispam-Report:
 CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
 Y8xeged7GH1xPky9uMv8jVGA37kzHSggR9wBe0Oj2APByKuoYfo4t/PxqLWc0rUykH4F/DedPVsc5AFi+6XGtbzZob16u8C5BUtWC0IKrqyihzUzGVtHmdy/oiiKAHuDmQUqMOtwtYR8ICnsrN7bRtztHsZR3IfaXUiytbopoERkLUQoKvNJ7B7mc6TKCNVKsMZmSotwNpPNLYHdOKpG/Ly0YTiKm1PO6OO3tMHm7YEqgwq00vOFGFPUslzD8TTQqIqBUmZkcSVRfbRcOw1H0DVbusM3qluW73Ul99ALNr+25io28Hi13jPCnpTOrCSurRq9V0JIu057TLjtDkeiN2hJdy3thIvxV9h8Nww39aYw46/eVNh7ylN3axR05UgfM+yZu416t453xxgVAJe77XDsaPOdsYTn28ZGmt46JhAYcROU+wwoenXOCqOD8oO4O38X/FVDrjQv/RSIFRv78ar/dhzLq/FJstmsFsNe3kGGHhSCXH9kQmRBlfjaJ+QSAZkhSNvLFFpmXgBV+3lS2ppuAVlEVmIgckWMRme9yxW3oQhdkGZtWh0Tzw+Q0J1ET6/vS8AMc9QrpznA6l9k5RC3LSoW05j9OCsvIAMeCffyus3HUCZYupzogzTsMZd2WFoJij5ri6QRSU7nsJQbKQ==
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 17:41:02.6653
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35577b6e-c763-4aa1-a15b-08dd720d89be
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
 SN1PEPF0002636B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR19MB5756
X-OriginatorOrg: ddn.com
X-BESS-ID: 1743617584-111141-8647-9262-1
X-BESS-VER: 2019.1_20250401.1649
X-BESS-Apparent-Source-IP: 104.47.58.176
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVkbGxmZAVgZQ0CDZyMLE2MDUwC
	TR1DIxNc0gLTHVJNkyzcQ8ydQiycxSqTYWAKVqchFBAAAA
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.263603 [from 
	cloudscan14-58.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.50 BSF_RULE7568M          META: Custom Rule 7568M 
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.50 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_RULE7568M, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

fuse_uring_send_next_to_ring() can just call into fuse_uring_send
and avoid code dup.

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
 fs/fuse/dev_uring.c | 39 +++++++++++++++------------------------
 1 file changed, 15 insertions(+), 24 deletions(-)

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index 5a05b76249d6fe6214e948955f23eed1e40bb751..c5cb2aea75af523e22f539c8e18cfd0d6e771ffc 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -667,6 +667,20 @@ static int fuse_uring_prepare_send(struct fuse_ring_ent *ent,
 	return err;
 }
 
+static void fuse_uring_send(struct fuse_ring_ent *ent, struct io_uring_cmd *cmd,
+			    ssize_t ret, unsigned int issue_flags)
+{
+	struct fuse_ring_queue *queue = ent->queue;
+
+	spin_lock(&queue->lock);
+	ent->state = FRRS_USERSPACE;
+	list_move(&ent->list, &queue->ent_in_userspace);
+	ent->cmd = NULL;
+	spin_unlock(&queue->lock);
+
+	io_uring_cmd_done(cmd, ret, 0, issue_flags);
+}
+
 /*
  * Write data to the ring buffer and send the request to userspace,
  * userspace will read it
@@ -676,22 +690,13 @@ static int fuse_uring_send_next_to_ring(struct fuse_ring_ent *ent,
 					struct fuse_req *req,
 					unsigned int issue_flags)
 {
-	struct fuse_ring_queue *queue = ent->queue;
 	int err;
-	struct io_uring_cmd *cmd;
 
 	err = fuse_uring_prepare_send(ent, req);
 	if (err)
 		return err;
 
-	spin_lock(&queue->lock);
-	cmd = ent->cmd;
-	ent->cmd = NULL;
-	ent->state = FRRS_USERSPACE;
-	list_move(&ent->list, &queue->ent_in_userspace);
-	spin_unlock(&queue->lock);
-
-	io_uring_cmd_done(cmd, 0, 0, issue_flags);
+	fuse_uring_send(ent, ent->cmd, 0, issue_flags);
 	return 0;
 }
 
@@ -1151,20 +1156,6 @@ int fuse_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags)
 	return -EIOCBQUEUED;
 }
 
-static void fuse_uring_send(struct fuse_ring_ent *ent, struct io_uring_cmd *cmd,
-			    ssize_t ret, unsigned int issue_flags)
-{
-	struct fuse_ring_queue *queue = ent->queue;
-
-	spin_lock(&queue->lock);
-	ent->state = FRRS_USERSPACE;
-	list_move(&ent->list, &queue->ent_in_userspace);
-	ent->cmd = NULL;
-	spin_unlock(&queue->lock);
-
-	io_uring_cmd_done(cmd, ret, 0, issue_flags);
-}
-
 /*
  * This prepares and sends the ring request in fuse-uring task context.
  * User buffers are not mapped yet - the application does not have permission

-- 
2.43.0


