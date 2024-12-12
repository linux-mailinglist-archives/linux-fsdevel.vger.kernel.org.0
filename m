Return-Path: <linux-fsdevel+bounces-37235-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FCB39EFECD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 22:51:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01C20188C240
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 21:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F04C2F2F;
	Thu, 12 Dec 2024 21:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="yECfGxm2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip168b.ess.barracuda.com (outbound-ip168b.ess.barracuda.com [209.222.82.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2875B1B21AA
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Dec 2024 21:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734040248; cv=fail; b=Pi2fIbxLftZBZ38g2aHfZrL/HQTnObdhwjbPKPiKJhe5abzgMg2sRWAB8snJQQ/HcYKzf/D5s2a7HO/5FVO7MQLsT/Ng/DVJbbIq+h92fM6EUm1gmc0jVtxibFZ3PtT0b/FprlBhIfLqbpiz+9Fwf+X4JZijeoCvIdFLm8q5UrI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734040248; c=relaxed/simple;
	bh=LR9VAGLFIwTIs+/PGMnieIGhcAaIr26pi+xCkivRTUo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CIwZQpSBAkO+dc/FYqeAl0JuAnVuM136RJ30UuO7sq7J9RWIop3aZT3kNvw9P8Js6Xhcn7tZ8Rg+pJwNv5EaMwEvxiYigW21pprMQOI8/8OSAulGjqYozXAjdeSFLxaR78cH/Tujqpbwrv/gcyiZAf4UUVOY4iFHf1J8PJHT+w8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=yECfGxm2; arc=fail smtp.client-ip=209.222.82.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169]) by mx-outbound21-170.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 12 Dec 2024 21:50:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kdk3KPGHAGXrZ04ImBUH6TEsB+tO8mnwzBowMP8EUTKaxxZb8srZnBRldFmHN5ZYs0mbSuXcirjYsFz0Y5h+hEX3DCQLfiURNh3eubif+bG1PzfKpufGd5oscv3yKl6S+xECtkXYORvlv4y2xBd6wrV3AAnS/qoQL2oL3PdDYNbPevczKJ9syfjrg6VkVjNeVa8dT6JW2DzXkULFpxb5FdYzCH1li+NXU6/AFbxUWS7n49npUCQZUY4VlcAeraEsl3U2UZjY2PuVvSkYlV38x3L/Mh+hI2TzkNtxdZDLhmADU3lBW1aLBu/QBTj82NhGmpFmYh3g/2sERHI7ZKLS9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3CKefZ+90LbzlKD4UUD9Df1iu8ZRSBebRFeIQ5kLx+c=;
 b=qtT9ONKwR3QB7WZZAtArx4WgJzt55QHDPV65HTYc+MIn9xUqcANVzFi/SKF8D/sBzV8WpSuPt0lffyZy1lmVxZ6E5jSzOHk/nfeJsnSSE0bN8575jrfsERPZ1mYrWm3YOBRk5mr7CinLojkqgPHQ5YkJhwa7AJDFhaqIl5uw8m7cGB4sWE53JdcjS2b1Xj46AcaskJs0Wvil5X+MFDM9Qoj9AiTtw023YhOyO6cGq+znB9VdiNPYDX2m7Prq4Iz9P7pBgV6t2GT7jn9TrVLeopdslSiSygzzuaj/QEuiQZyMK6eaqV2f8BVtBmlteL/Y4H7681TLjh6NsrSX1OHrWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3CKefZ+90LbzlKD4UUD9Df1iu8ZRSBebRFeIQ5kLx+c=;
 b=yECfGxm2lTdhE0oMGpyeZG0zRpjr88ln+566l+Nsnt/EIl1/cYES/8ybLWYS/KSg/PI4Aql1kMMl68Vz5KGE6p/2p2DAL6DdgxpOnkUgEgQzSqCdJSJhHwJLA3S+j0o050eKxebBJpqg3Htjk20u+07FGRRDynoXl9QcjsQuSSE=
Received: from BL1PR13CA0129.namprd13.prod.outlook.com (2603:10b6:208:2bb::14)
 by SJ2PR19MB7594.namprd19.prod.outlook.com (2603:10b6:a03:4c7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Thu, 12 Dec
 2024 21:50:35 +0000
Received: from BN3PEPF0000B06C.namprd21.prod.outlook.com
 (2603:10b6:208:2bb:cafe::30) by BL1PR13CA0129.outlook.office365.com
 (2603:10b6:208:2bb::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.13 via Frontend Transport; Thu,
 12 Dec 2024 21:50:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 BN3PEPF0000B06C.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8272.0
 via Frontend Transport; Thu, 12 Dec 2024 21:50:34 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id C7AE54A;
	Thu, 12 Dec 2024 21:50:33 +0000 (UTC)
From: Bernd Schubert <bschubert@ddn.com>
Subject: [PATCH 0/2] fuse: Increase FUSE_NAME_MAX limit
Date: Thu, 12 Dec 2024 22:50:32 +0100
Message-Id: <20241212-fuse_name_max-limit-6-13-v1-0-92be52f01eca@ddn.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKhaW2cC/x3MQQqDMBBA0avIrB3ojLaoVxEJ0YztgImS2CKId
 zd0+Rb/n5AkqiToihOi/DTpGjKoLGD62PAWVJcN/OCamBjnbxITrBfj7YGLet3xhVQhNc+GR1e
 1ztWQ8y3KrMd/3Q/XdQOhQo94agAAAA==
X-Change-ID: 20241212-fuse_name_max-limit-6-13-18582bd39dd4
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, Bernd Schubert <bschubert@ddn.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734040233; l=705;
 i=bschubert@ddn.com; s=20240529; h=from:subject:message-id;
 bh=LR9VAGLFIwTIs+/PGMnieIGhcAaIr26pi+xCkivRTUo=;
 b=F11MQ67nae4yShZbh61Wo4vD0rIVvJaKj5IYJGGjs/u0j/M8Dh4BtZk03WkATZAiGfILvmyUO
 +Zshdqsrhi8ACrkfxmCmVJkIMvV2YK56amVMbQPeUHvjgbt1De4pDxd
X-Developer-Key: i=bschubert@ddn.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06C:EE_|SJ2PR19MB7594:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e7249e8-861a-45e6-6d9f-08dd1af701ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WXgvbUN0R2EvNzh5emplenp1ZjJvVE5OVG5RWnNHaktEVnQzVW4va2NTb2tB?=
 =?utf-8?B?Y0l2WmxvNE9MUEYyY2ozcW9HcThSSGJYdFMxVFQra2wzUnEweXY5bHBOSU1K?=
 =?utf-8?B?QTQ1Yy91TGFJWUs3djJqbTJEbXhhQTdZcXkzVVpwWXBsV00vNHVWaXZOaUVm?=
 =?utf-8?B?bk83TS9ES0U1MnFyMmRoc3NZR1JlVmEvUGhrRnhTNlFhZmU1ejJaWE10MmVo?=
 =?utf-8?B?TlpBWDQ1RVJaUmdPOUtPdjZDR0l3WkJTZ3c3N0RwdjY4M0ZNL0dXeTJZUTh4?=
 =?utf-8?B?T2NNZEFkL1Z3SjJJRDUrZFRxdms2NEhmWkxSbGlCUnJjdFBqb0VDYWJKVk8z?=
 =?utf-8?B?UlFibzRYUThjOHRNd2lDWlJoWnNJUWJvcFk1NnpLeG50NUZnWHlrQUphYXRN?=
 =?utf-8?B?ZWRjU21KRnV3S1JEY1JiWlFiL3pGTER0VlBqRVc5THJoUDUzYmFNRVBmZ1ox?=
 =?utf-8?B?Ym5vdSs0b2pwdExUQXAxTDhMNzBLQk5EeURRSlQxdjBkUWVSdGZvNlVzVU5G?=
 =?utf-8?B?Vld4VW1MSk1QQmhDZG80UHAvcHRsSWZQM1lOalo5Q3RaK2hBOGl0dnNPR0JU?=
 =?utf-8?B?emZjd0FHRW1UUmVTNlRwYXJGOUJHZEh5ZmRaRmM5Ti82WEUwc0dzUjdJYmlp?=
 =?utf-8?B?OXc0M0pOSjdWSE1ieVlMM1dRQnVBUUpmQUErUUVTWkVQYjFzaEJ0SkVKdWM5?=
 =?utf-8?B?Z1FQaG1iMGw0cXR5Umh1OXBlcmg5SjUyWTF1ZlR3VkZxWlI5ZnIxU1pHYUdU?=
 =?utf-8?B?MGNFWWFxT1Y2ckZYYUVWcW1KKzhiUG5xcUJIcE9YL0Z4VUZnNnIxbGZPUk5L?=
 =?utf-8?B?cWlRdXZGUjU0WVhlRUo1cG9GZ2pEVkZKd0xkU0lhSUxIYXlDUXlQbnpKbWtK?=
 =?utf-8?B?Z3orSW1ua2hiNDMyVGxjdkdpanR1N2JqanRPVjREdUtkNTlBUFdwd3MrMWdq?=
 =?utf-8?B?cE12VnI5T281Vi81MmpGQStJcWxOU1R3MU1iUEhxZ09uYnRTeWV6QkVOeVJD?=
 =?utf-8?B?L3p4Y05rUEltdXluSk5KT0kyV3VTRWNqK29pL25zTUVXd2o5SS9sQVRNa1Fs?=
 =?utf-8?B?RzhseWZpdmtHQVl1a0tDM3UvM1FiV3hucnM3dUtBSURmbnVVejVPRXM2NElE?=
 =?utf-8?B?N21WMzhFaE5FalIwWDJQT3lNVyt6bWE5MTJpUmVsOGxUK1oyOU5IS09SWjFo?=
 =?utf-8?B?bGE4U3E0bmdEdE9EVXVlRGxnNWJMa1hFU0t1YThOVUZlKzJQZ3NqR21Cek1y?=
 =?utf-8?B?bjlnMWFrRzQ3dzV6SzdyR1EvUHptODJ5UnZGeXhVSGk5M2FFaWFkRjZMNTNW?=
 =?utf-8?B?TWFUTzB5SlEzUyt5NUh1SldpSmJrVnBmZUp3UmdIT2tuWTB3U1U1Q0p3T3Fl?=
 =?utf-8?B?THpyUUwwYXZFcW9zTHNTZnlnbGR0QTEyTXRYSkE4YVJYei9BdUVuN0Q1bVM3?=
 =?utf-8?B?amNmTHRsU0l4N3drSi9DMVlTcEQwUnJJVlJWYmNLNGpkd21RbkhiNVdRL0cz?=
 =?utf-8?B?NWNYTjg4S05rZGJMb1gzYjBIZE1qU21HeHg0clFkNDl2YTlPNktNY1BHWXJG?=
 =?utf-8?B?bjhJM253cnRtekg0WGtkMmptWkVPMHhqWjMzVENDOWxSUWlmRWtIVW9sT0ti?=
 =?utf-8?B?RXBJOWNxVktta2h4RVdYQ2pLdHBzbXQyNWdiY2dvUEhNTjZpNGhBWmFVQlNz?=
 =?utf-8?B?dTdCK0x4cjlzQ0FIVVlWVWsxU0ROeURiUmM0czRhODU1V2RkUy9aRmp5Q0Mz?=
 =?utf-8?B?VGo2eGRKcGEyek9JS01XVmpSMHdNUVdHcDY0ekhaOEhObDd1Mk5qc3JCUVdZ?=
 =?utf-8?B?YUhhTGRmOWJRczIxMm9IMStyNFVYenVOMzJvYXhNWkFPS3N6R3VQajZjTTgz?=
 =?utf-8?B?LzEwSTVqano4RWhBR2pMbWM0czJnclVyNHBFS1F3dXA1clhXTjBZTkFqQ2ZT?=
 =?utf-8?Q?rUmgmvxblYs9UvDXExPMOXqYtn+zHOG1?=
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Lzt9XxzY8EA4C/0PrnMYDb5ItOo1LVg0owzJ2jFabpf/aBmgwZl+K9SNKp9T/44WWtU3UrBh1dzNc9W/+zQ2y06ecodLve5+BD9Y9GUJhFc/oyC8hMgqn6Q2OBZYp1mCP6c4n9GpMDY8nLxlK8XMsHt+/B1614igBYZUgVITqlMM0Tiarjm0KHpKlUb6yY8a/cD46Mi0COWUx1xnH8/2A2s3U5BAfPUKV+737UDaHDTx+6vwnhZg/j//IcvvWMTUYaQKj2gJV5KujeoFD9RIfB6nhflU0hWEXHh2rT/w8n1NzStkTzFfGM7fqmTCWqmSfk6rmGAmYqBmJtEd26jQIFyjG1jxoXDWKIFnx0NolDf5iE89V0x5S5VGH2dVN/QAbNUfbis4EMWnBDC6Zxb3PO4GjPqZ3VzxxC3NkGG9WmqZOH+lwurPrzQoQXu09IQCYia/innxMKbJZotHrr84oORFL4mEp7IQC+pekoGykVboust3u0Ts7jYOlMPyyjg6EW0S7UQHND7qrOe3sTulw8RQzxExfCgajFYDMP6CGyHAhk0BZpCpRwQ++94p5iOgLiZtbT7YjvG2QR6yzBvqvy7lXqVD1o+tj1ETUSYGFJGCdT7aTtB8ZIBiZqU8jtGjUo0dTUhICa2pomFEJmvaKQ==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 21:50:34.6875
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e7249e8-861a-45e6-6d9f-08dd1af701ee
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06C.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR19MB7594
X-BESS-ID: 1734040238-105546-13393-62371-1
X-BESS-VER: 2019.1_20241205.2350
X-BESS-Apparent-Source-IP: 104.47.58.169
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVmYWpkBGBlDM0DDJ0CjFOCkx0c
	DCxDwxxcLU1DzN0NTIPNnMJDnZJFmpNhYAiaZEZEAAAAA=
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.261069 [from 
	cloudscan21-33.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

First patch switches fuse_notify_inval_entry and fuse_notify_delete
to allocate name buffers to the actual file name size and not
FUSE_NAME_MAX anymore. 
Second patch increases the FUSE_NAME_MAX limit.

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
Bernd Schubert (2):
      fuse: Allocate only namelen buf memory in fuse_notify_
      fuse: Increase FUSE_NAME_MAX to PATH_MAX

 fs/fuse/dev.c    | 26 ++++++++++++++------------
 fs/fuse/fuse_i.h |  2 +-
 2 files changed, 15 insertions(+), 13 deletions(-)
---
base-commit: f92f4749861b06fed908d336b4dee1326003291b
change-id: 20241212-fuse_name_max-limit-6-13-18582bd39dd4

Best regards,
-- 
Bernd Schubert <bschubert@ddn.com>


