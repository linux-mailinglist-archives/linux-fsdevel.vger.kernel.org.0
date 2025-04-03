Return-Path: <linux-fsdevel+bounces-45698-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A619A7B04B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 23:14:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A79C13A47FA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 21:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0CCC1F0E2A;
	Thu,  3 Apr 2025 20:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="PH6DmLl2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip191a.ess.barracuda.com (outbound-ip191a.ess.barracuda.com [209.222.82.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0FF1EF0AE
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Apr 2025 20:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743711787; cv=fail; b=HCSCC48eQ1qdIbNlyerOGsFcN3KSTY731IEkTRPM9EVdEczFHqrcXaAOcTjfxEhg0k1eubg8ALlYIZzdrFMzsfWoFTQXEtvzkalq/Ji41KRbrbt6DxNsgDgLk5p5WPJYtHHWqyp8zaMyZ1+ZS58FaLxfYQrwatQn0tgHpfYcbsY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743711787; c=relaxed/simple;
	bh=R914zhK7i+JCVCvZ1X2GiNmteleK82D9TXudSjDGj7I=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=H+ZSRA28O+z0RnnwOHphkpNZSY4Hc0D4Qo5/GTu3etGe+j8Gdqqs6RAZwANDpxYWb2RR9Z6vbsfoEtn+pDHcgqwWw3yxi0PWt4XU2qugAOcQlM5aGnPi4o1v8pTjGQWyF61IHkLu6EUoqY2isBnwYe9CS0Kvg1A3eVVL5woTDAU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=PH6DmLl2; arc=fail smtp.client-ip=209.222.82.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175]) by mx-outbound13-255.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 03 Apr 2025 20:22:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t67+RO9+1xkGcIdWgkgFWnSeZFNClc+WgNGWUOYLd1X9WCxZGP38YYvRjr3ifrQUnuzCTROU3KPELrjAw1ecWMJxMojqW+uoKxtN3WzfQo/QZfUjQKo1jytpWA1k/0mB4iluvJLjqI8FU1fiRpWCnDsoWEhXole5GZSMEPPwwCzL7t8u60W+Q3eziNOjkUwczFufAreHgVIRO2I7FAYyCcIVOJJSGurDKtYysjrd4O47Xh6P9uVmFOyMtpsF+l9+rerzyQhpjwi64u+VBrYhPpqY4vLcypePlEGs+mZkjlE7DMYgDyBhy9X38jHOdrn1jifR11ij3+pkkUGfhUtijg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RRZcv1fH4Uhf2tYlJpxJzAdeGUq/4zqm3rRkoSJO7BM=;
 b=tvnRjHTslxQUCg73UR4yi4INc6MuA+NhpbOb3OoBAjIoDo8etrNKoHgH17FomBhG23EM813JRNgyRK1j3GOnl46RSrXgdcN0eKfDngY7f8uB4lrWDlNCMxSjNGIQWQYyevKogVIzxUsHt43oSklt9DAwoxl9oM3yL7vFYO/YCoAb9hphLJT+XUVhUGXT/GUoVSpr41AjhCj4GgBtwvrec6saDkjMyg/weAuaPUPO7sRGaPBhAsBy078F7Z6cXfyWwI76b4jF5g0luy3TQi9S8Ca+Yxjvx3p3jQvqKOTetQvqAYqIF/2pYnfzaplVD+Vk0XL6YG4OGe+zuAK97QJWVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RRZcv1fH4Uhf2tYlJpxJzAdeGUq/4zqm3rRkoSJO7BM=;
 b=PH6DmLl2vgQ2iu5SpVtQQ/1bArMEOFxJgc/iext/YlC8sMHFwEbn9wd9X/4RtSjcQVip1VJ8mV+wRwv0oTKZgiU76wzslQIZHY8PxzDIZqIHFnI7TwCPmrPvbyQZhv6u8kkmoVSuSBwSzbq6SHHPcx6P+eqmQM8W7aOIqiSWY6c=
Received: from BN9PR03CA0518.namprd03.prod.outlook.com (2603:10b6:408:131::13)
 by SN7PR19MB6829.namprd19.prod.outlook.com (2603:10b6:806:263::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 3 Apr
 2025 20:22:50 +0000
Received: from BL6PEPF0001AB4D.namprd04.prod.outlook.com
 (2603:10b6:408:131::4) by BN9PR03CA0518.outlook.office365.com
 (2603:10b6:408:131::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.54 via Frontend Transport; Thu,
 3 Apr 2025 20:22:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 BL6PEPF0001AB4D.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.22
 via Frontend Transport; Thu, 3 Apr 2025 20:22:49 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id 79B954A;
	Thu,  3 Apr 2025 20:22:48 +0000 (UTC)
From: Bernd Schubert <bschubert@ddn.com>
Subject: [PATCH v3 0/4] fuse: Improve ftraces, per-cpu req unique and code
 dup removal
Date: Thu, 03 Apr 2025 22:22:44 +0200
Message-Id: <20250403-fuse-io-uring-trace-points-v3-0-35340aa31d9c@ddn.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABTu7mcC/43NOw7CMBBF0a1ErhnkmfyAin0giviXuMCO7MQCR
 dk7ThqoEOV9xXkLizpYHdmlWFjQyUbrXY7yUDA5dK7XYFVuRpxqXnECM8e8eZiDdT1MoZMaRm/
 dFKE5c6wrIVqSLcvAGLSxzx2/3XMPNk4+vPavhNv6F5sQOCAKToima+rTVSl3lP7BNjTRN1T+h
 ChDQvHKkCAyZ/xA67q+Ack1oisLAQAA
X-Change-ID: 20250402-fuse-io-uring-trace-points-690154bb72c7
To: Miklos Szeredi <miklos@szeredi.hu>, Vivek Goyal <vgoyal@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Joanne Koong <joannelkoong@gmail.com>, 
 Josef Bacik <josef@toxicpanda.com>, Bernd Schubert <bschubert@ddn.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1743711767; l=1726;
 i=bschubert@ddn.com; s=20240529; h=from:subject:message-id;
 bh=R914zhK7i+JCVCvZ1X2GiNmteleK82D9TXudSjDGj7I=;
 b=hbW6mfcPG68At5GgG8K2/i6LMIG3O7ThCx2PGj9w3hWtowezwuCKZxYS8QCWft580H11Nwdto
 K1QWwNCeu9FAPqgYlMudy/0a/YJjYheaSJrK9iSPcD5LzEf29lF7abZ
X-Developer-Key: i=bschubert@ddn.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4D:EE_|SN7PR19MB6829:EE_
X-MS-Office365-Filtering-Correlation-Id: cc4b8ba9-b054-4260-f75b-08dd72ed4de7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZDFyQWVnZ2Fqb0loZWhNdVpaT0orVm1pZlpmWlFIaXVVbFZSYnRpWmd4aHl2?=
 =?utf-8?B?K1c4RTZBWi9rTStSMWtZbE91ODY4cVJPeUU3d0U4cnhBNUJqVHF1V1BIWE5S?=
 =?utf-8?B?QmtXbHpyRmhGeXJLTk5pNTN1TlpEYjhkVjNGampsVkdSVXZKU0pLMkdHUUxF?=
 =?utf-8?B?eTk4Vmo3bHM0ak1CbmJXVDkxSGI0Vk0vTnAybnp6bDRYSlQwbTBiSURMSCtt?=
 =?utf-8?B?TGlnQUhpbzQrdlg4SkJKUUpGSHFLN1ovdXVpU2pBSEwxOFZFUmlZUTBENUdx?=
 =?utf-8?B?N2gwSExoOGtmMHVlc2ZMcm9mN2trVHBKMUs0OFZ2QnBqN0NoUFdibm9QaG1x?=
 =?utf-8?B?UjNCbkordUJ4ai9ZbnMzOXkxcmJ5d0lJRWZFZHdLeFkwZ0RUNmZ6MFppUFlm?=
 =?utf-8?B?Vm1USU92ZU9MY3pLRGl0b3doM3kzOXZ4a2VKbzhCV1VwMmJPM0NSVkZHZW16?=
 =?utf-8?B?Zk5hRm5aUXg0dDR5aDJaY2JOZUtWNFFBYVBxYW9OY09FWWtWVzhoSVZPU1JF?=
 =?utf-8?B?V1V5eGxGRGxmRnVPYUlyeVd4S3NjZHpTa3hvRWR6UUFWWGRLTEFLcHVOMlc5?=
 =?utf-8?B?cUt5QXcxUkczMCs3d0VDY1NON2IrWXFWMCtTaHEvRjZ2aHlrMUptYkZQY3BS?=
 =?utf-8?B?czJOay8rWXROd2VCditCZkpaMFRqdHhRZTZiTEFMKzc1ZzNlQjJGNnB2Yklw?=
 =?utf-8?B?aXo5K3VXY05nYTBYYUpXR3VDcndoOEo4Z2E4a2xuSVZVRExZYm5VZmUrSUtW?=
 =?utf-8?B?aERGZzNWSUk5TmE0V2w0QzJPaGltanZFd1IySkM5c2tuLzB0YnhIOWUxQnll?=
 =?utf-8?B?QUo3bmo5NitXY3U4bnpPL0x2TjM4c1ZjODFkTVVtbnB3aGk5UmtpVVVpdW5C?=
 =?utf-8?B?TFl0V21HdU01OUxEWGpTdUVJMGFzcitkN21RUDQxbjY3aU90QThQV3NsOUhy?=
 =?utf-8?B?c1dBVlpzdXdSK3YvVUk1Q0RDTkRWTjRNWjVTZm9rcGRGK3BtM1FxNzJOci9C?=
 =?utf-8?B?OFQ2NGdSSnA2eHNTQllNRFBMWjIwWE1GenFmcWlZeWlGNzdiNDdYa0Voc1pI?=
 =?utf-8?B?MmFXbHVmWGp0SThJZGM4Sk40b2NqL2IwdG9RbWVRT0k0UzYyMVhVbksxNDNK?=
 =?utf-8?B?azZhMkZNL0Q3UVBwTGZOd0gvbDRuZGV6bEJkQVZINkNxYXFUU2s4dUFKL1kr?=
 =?utf-8?B?UzdWVzlIazlsWGRmTzVxL2JGbnUzUmMwY1psRktXb2RseksySW1hczZ5ZEpq?=
 =?utf-8?B?WVpId256b252ZXRYYUQ4QmdNTDFTZy9yZXhPenpVOG55WGMzTStYZ2hWNlQ2?=
 =?utf-8?B?MkxrWlV0aWxsWjBoRFIxbytvd2wyMk8xUklvQU9aemUzQ3RTWkFkS1RuN1VE?=
 =?utf-8?B?ekRnVUFUdHloaml2YUdlNFpaMXZ6KzBrZ2Ixc2xQSHF2STZrWmVsYmdSR2hq?=
 =?utf-8?B?dk9pd0UvcG9qdWhQS3gzVmRuR1BEbDg4L1dQVkVISkVubTdwR3ZSVUZyQis2?=
 =?utf-8?B?VHZzNXZzMU0yekdZU1diaVBUaDRUWmJybG9uc0ljTWplYnZZWEowRnVnUndj?=
 =?utf-8?B?R3BjWWFKQXNzTHNoNC9IWkFTclJyN2dzRkJSeUQxVmo3OUp6dWZZL2hxTzF5?=
 =?utf-8?B?RHdPaDc2b3R5MWJRbUI0SWdVSUJLbDV6bVhnUTJSNjN4anl5YWwyNFJ1Zjdu?=
 =?utf-8?B?enVRQTBZZmhKUUp3T2swM2Y1MFd0dGdWZHBENUpoVW1hRWJXOExHYSs2cE82?=
 =?utf-8?B?Vm0reVhZTGdqdXdadUo3VVYvc3Z5d2lITmw3cnBOZ2ZOU3lsWjNqaGh3c0Z6?=
 =?utf-8?B?R0ZOdHVKZk5nYVFjamZMdzdoUG1UV3N3QTlWckdqLy9uK1dndmF0RXRSZWtO?=
 =?utf-8?B?YXoyVUEzQ3IzM2JaT3NRMGRxQkdsbnZNV0s1WlRCRWpVeHczQU9vS29DUDVy?=
 =?utf-8?B?TnM3eFd4V2hYWXA4T3NsUHR2SFkrSnZuTFBUT0lEUHNYZys0ZDdoeU5PWHJJ?=
 =?utf-8?Q?98AkJckCYT09LAc9jb3jF5++VOvgps=3D?=
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7DgfH2i/DBXzrjUe1KHPj2NLrKoUAokyj//TTUfMtA4BWXbPSMiquKeO164TkUSbPRTua8gq2ljzEo3PAj4k6XDSQHBAIqBLw0Ale09IZUrxgBC4jBlkU4xntY0ctyQAAotFs1fTLXmw6SVW1ALURGE7upt4g+04e8azvxYNWc35E4hHIgBfl556qqddDmmKNe1nZSIcG+0W288A9O0dKaL1mnedL93EFgqATh9CpH2LR/u/2GaSumf4S2puVJfR109M3bLN3BtrmZzaNe7Yp76JNy7T5mGZFCyXK60dpqaVU8KMIm7gmdC8zQqzHr9EuBgWBhE2U5l0CnctFCSZj8L08XtEqlYHqgxafwGTYRRBWLGSkyf7dd7QAf34LIn7iZtSXvSwUBc2KvaxDUSdaMHvvbttTKG6l/8KxNTY8U6gxafY/jKITxePiZJdnp2iej206Ngp3b9R+9tNHc0JBFLi0lROmY4pO94GvnDr9j4Vebyi+9DQFv583WjtQgslOko7zdlRk+8dzHNnlQeTnlPqFzCCYt6qMHeLF9IISjDZQL2jliGu0JEazT9gCiU3A4D/+NG4iRJJAE13ASLUW4Ppw/pLB4CKYoScO1jNct+FbmOvhU68HPSeeOHl8VF2wDj0Lln0p5MEg7ZUb+zT6A==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2025 20:22:49.4935
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc4b8ba9-b054-4260-f75b-08dd72ed4de7
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR19MB6829
X-BESS-ID: 1743711772-103583-8767-39661-1
X-BESS-VER: 2019.1_20250402.1544
X-BESS-Apparent-Source-IP: 104.47.58.175
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoZmFsZAVgZQ0DzJ0jgxxTIxJd
	nQzNzExNLYMi3FwiDJzCQxxTgl2cBCqTYWAAAzK21BAAAA
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.263629 [from 
	cloudscan20-229.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.50 BSF_RULE7568M          META: Custom Rule 7568M 
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.50 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_RULE7568M, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

This series is mainly about improved ftraces to determine
latencies between queues and also to be able to create
latency histograms - the request unique was missing in
trace_fuse_request_send so far.
Some preparation patches are added before.

Scripts to enabled tracing and to get histograms are here
https://github.com/libfuse/libfuse/pull/1186

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
Changes in v3:
- Added missing free_percpu(), and new fuse_iqueue_destroy() (Joanne)
- Removed uneeded headers (Joanne)
- Removed '+ 1' for current cpu (Joanne)
- Link to v2: https://lore.kernel.org/r/20250403-fuse-io-uring-trace-points-v2-0-bd04f2b22f91@ddn.com

Changes in v2:
- EDITME: describe what is new in this series revision.
- EDITME: use bulletpoints and terse descriptions.
- Link to v1: https://lore.kernel.org/r/20250402-fuse-io-uring-trace-points-v1-0-11b0211fa658@ddn.com

---
Bernd Schubert (4):
      fuse: Make the fuse unique value a per-cpu counter
      fuse: Set request unique on allocation
      fuse: {io-uring} Avoid _send code dup
      fuse: fine-grained request ftraces

 fs/fuse/dev.c        | 37 ++++++++++------------------------
 fs/fuse/dev_uring.c  | 44 ++++++++++++++++------------------------
 fs/fuse/fuse_dev_i.h |  4 ----
 fs/fuse/fuse_i.h     | 21 ++++++++++++++-----
 fs/fuse/fuse_trace.h | 57 +++++++++++++++++++++++++++++++++++++---------------
 fs/fuse/inode.c      |  7 +++++++
 fs/fuse/virtio_fs.c  |  3 ---
 7 files changed, 92 insertions(+), 81 deletions(-)
---
base-commit: 08733088b566b58283f0f12fb73f5db6a9a9de30
change-id: 20250402-fuse-io-uring-trace-points-690154bb72c7

Best regards,
-- 
Bernd Schubert <bschubert@ddn.com>


