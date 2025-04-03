Return-Path: <linux-fsdevel+bounces-45638-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D06A7A34E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 15:05:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 952611896269
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 13:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3E624E010;
	Thu,  3 Apr 2025 13:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="VXju6uof"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip191a.ess.barracuda.com (outbound-ip191a.ess.barracuda.com [209.222.82.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B583288DA
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Apr 2025 13:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743685526; cv=fail; b=kuGRnfZhpXxezZYHPgWQ/4aANj2eiQ3sn5GsUJFB0yatLL6HyhNAW0SEWXwXVyBaPHY8lmY4z6kt1ZqWbFBuSI6pjt2hxxikaqrSUV896kKDjAfjW93pR177+i7ES9NKerdmPQMkPakf/IocMfTAB++zf0eZeRg5icwSKRrlaZ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743685526; c=relaxed/simple;
	bh=ziYZV/W/d52W8kKfIYz5/3su24KBpyjnMK0qQasJq7c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SX15QaKadoxUdOGTLBVp38OngXMotjKvmYHSCqjm7r4aVHpKJnn6ReumXk6W/N/bI7uVaj8VcWn1hEvOeIh19EUldHp57lMe15BDKVhz/pUBH+i+XifC5DjImExUuapXHtS6LgnoRu/b7rF8qEE4PmkHtpP0wnsPXcL6KpxNMgA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=VXju6uof; arc=fail smtp.client-ip=209.222.82.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173]) by mx-outbound42-120.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 03 Apr 2025 13:05:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DQOI7MaNctg0S2kd9S9627Q1V8tqYGJ7rljw0eFohv0BMO7XRyHzE26hyboaSIcKeK4w6MnU6TpBjLL3G6PtmYRfBIqSObVgR4oNaO6pJhSnoekRs+EvqWmAwMuo0QsKiI54qYXapuXabmgtgCQwpZk81yI6C6wUuEcSdIOjO9kY3o/gRFUFKW+zFvEB71VJx3UEh/CprBIfefziwPl0pSw0lYq29HjjymrWagilz5Dy88P5P46Jb67l+l8FWZf7EalRKzO+WPia1ODglmBpB7jAM/L9tLi1fOUDnp6n+7fvJodlYDg8nETBTZW0bz7Dp10/+Oopo3HscCs+MpQXOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y/tm93HuADKuq/51kxy83RJV/L4xXQ5WraSoBE7nzxg=;
 b=wKAKBzFmuq428PI+2GF7W+0UGuwVM3KPONZsb3kheU2/tVe1Sk7oPGYobtOVtRbAjD0PEE3RPZZUcUGA+69n05nzL5lGvCq8c3qN8qR858L1K89HB8P1JD0hC5BLN5vLr3kMs813KI0l8j4lavmMnxxt4HTEAR1kFFV10XnaiBvOnd77BnQ4qsTDynJvIWSIzxlYekuzxcTSh35qUWAofLJSJSjAwN9Fxlj2PRGcj6exLcwLPLZUmOgOFZEXEvxoqkUjQZE+BrdVojru4K1bNEmLGVIaBCSVnLbHeTUwwD3OBb36vkDgerL9W1deHfZCWrIhwg1YIhgv6khfuCBj6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y/tm93HuADKuq/51kxy83RJV/L4xXQ5WraSoBE7nzxg=;
 b=VXju6uofI+2mqW0dnTcw2RGTPW8ypitQpUkNOAbZ272nfz7HjbBH9s+jXZ81F6fqNtEQCugb99Rd3vyLcOZ772s7P2cY95GlbVZl+e7UoU+8/XlPpBqJ/GDsNNAr+G2LqnhQEkeBrTcw4TynpbmzEK27Bk0nLAwZC/1L5FtJ1dE=
Received: from CH0PR03CA0015.namprd03.prod.outlook.com (2603:10b6:610:b0::20)
 by CY5PR19MB6517.namprd19.prod.outlook.com (2603:10b6:930:37::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.41; Thu, 3 Apr
 2025 13:05:14 +0000
Received: from CH2PEPF0000009C.namprd02.prod.outlook.com
 (2603:10b6:610:b0:cafe::4c) by CH0PR03CA0015.outlook.office365.com
 (2603:10b6:610:b0::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.26 via Frontend Transport; Thu,
 3 Apr 2025 13:05:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 CH2PEPF0000009C.mail.protection.outlook.com (10.167.244.24) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.22
 via Frontend Transport; Thu, 3 Apr 2025 13:05:13 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id 4CBC84A;
	Thu,  3 Apr 2025 13:05:12 +0000 (UTC)
From: Bernd Schubert <bschubert@ddn.com>
Date: Thu, 03 Apr 2025 15:05:07 +0200
Subject: [PATCH v2 2/4] fuse: Set request unique on allocation
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250403-fuse-io-uring-trace-points-v2-2-bd04f2b22f91@ddn.com>
References: <20250403-fuse-io-uring-trace-points-v2-0-bd04f2b22f91@ddn.com>
In-Reply-To: <20250403-fuse-io-uring-trace-points-v2-0-bd04f2b22f91@ddn.com>
To: Miklos Szeredi <miklos@szeredi.hu>, Vivek Goyal <vgoyal@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Joanne Koong <joannelkoong@gmail.com>, 
 Josef Bacik <josef@toxicpanda.com>, Bernd Schubert <bschubert@ddn.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1743685510; l=2914;
 i=bschubert@ddn.com; s=20240529; h=from:subject:message-id;
 bh=ziYZV/W/d52W8kKfIYz5/3su24KBpyjnMK0qQasJq7c=;
 b=mpeLP5dAXB1rvQDoUfrMWHGRVx4mMQJt2EkvRDIBGSeXKfD4Oo94vzoQHYRlRuLDmb9X4M+5M
 Z5Kr3G/Oh/7DuJ1LEkFopEsFiN16XvFsCLUOnuZgujz7FTL6lbqCHuM
X-Developer-Key: i=bschubert@ddn.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009C:EE_|CY5PR19MB6517:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f8a0aa3-4383-4301-0333-08dd72b02bf3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L2tzcDd4Z1B5VVg5QXZ3VlhuUWR2dUdDTHRCWGNqVHh5YkhUOHFSMWRZTXVS?=
 =?utf-8?B?RmV4QnF1RjVsNXl3ZDVWSmNGSFFPSU44aXk1b1VKZ2lpaEY5a0ZOOWZDTnVX?=
 =?utf-8?B?NVZyUThJTnp4amN0RVBCZVhtTnhCUUxRWDAxdjdqMko1Z0FleS9pT1gxUUwr?=
 =?utf-8?B?L1F6UE1oNjBWeEZIb2FrbTVVWW5JaGFOQjhEKzA5MXJhelJFZFE3SVdKT0Y1?=
 =?utf-8?B?VHQ0OW0zWFYreFRmMUYzV0drZ1JVWU9pUS93bkpic3N0R1hyQVdXZ2tGRXow?=
 =?utf-8?B?WVN4aVdCRE1ESkRxdXpScytsUHpvTHFRTVFpekJadWVva3VJSWhFYStWVVhl?=
 =?utf-8?B?L2VhVHgzQTNZV05Gckc0U2dJMGMzT3poZVJpWlFlVTQ4a09qNXhaTmxYemQz?=
 =?utf-8?B?aG96N28wc0s3ZWJpSHFTbGhFd0pqKzBUMVFQZy85c0RJTnFFNEhVZDZuYTI5?=
 =?utf-8?B?ZFZ1VUo3bEQ4RWlWV3hXd3FxUlIwUExTZ2xTdkVKa0hEZklmSGE4Nkl2NFBa?=
 =?utf-8?B?QzVYSHEzYWhEc005ZUppeUY1UHZZblAvREU1U3FCa3NXaXhpcVYwWXBrSDZl?=
 =?utf-8?B?UWJZU3RtdlYwQ3V5cXZJVmc0UmxMQ29GV0tndDZpelhkeHNuK05ycTlwUnpY?=
 =?utf-8?B?TnJ2WWsrQzR3ZGZRVVViTTdxQ0puMExvQ2VxRnI2Y04zTEgxL29YckxuRWpB?=
 =?utf-8?B?QUtjRFBweTlvVjRwTmk3WHBlQ05LKzh5eWppREhIb2VDdXd6WEVSdHV4ZFFF?=
 =?utf-8?B?aDluV1kxZzNLbGVScW5LZFEzNTl2eEZ5V3ZTRzN0cDhOSE84UGJkSjlXdFdr?=
 =?utf-8?B?VHJ4VEZyTXFsMWxDMlV0SDdSSlA5bnV6aXZ3QVYwYTRRRnRZeUVlck42N1Fs?=
 =?utf-8?B?VDJnK2srR2pRU3R1eU9wYlJadHBuRnVIMmgxL1FkaDhkQnZ0UTVNM1JQTVhH?=
 =?utf-8?B?eExyZlYwYTRkbnNSMzcyelI0Q0hlMUdBWTR0NHFXVUVGR29RcWplK040Y2R5?=
 =?utf-8?B?QjQ3OU92aHR0d2dvc1dpa3c4QkpUbXZ2SUFRUlhYb1lhUUd1dWtTOTFuNklJ?=
 =?utf-8?B?OVJKSU9CcFdoemdVWlBLbndxK251eXpyUFE1NmtQVldXbmsvRkhsa0FYY1JW?=
 =?utf-8?B?d3BYeVVwN1orNkdQbVF3OHZkOHF6cVZGZTZmV0lnNzFHa2E3T0lvdldEcWNP?=
 =?utf-8?B?WEdMazhFSlQzZ1lTMEw4QkM2YkpuUXJGbVFMSy8rMHluMkpoa201b3lTZVIy?=
 =?utf-8?B?bFh1ZXQyVFN2QzhMQmdWdDZZNmJ2WUsrQWRIMXJwQ2dSVDhwSG43bVZMcmdp?=
 =?utf-8?B?MkpYTWFEVXNDNk1xSHU2NkQwNEEwUVBBVjlqcllZQUhOVWR3Vkl0WmRWQUFt?=
 =?utf-8?B?bzlpNTZZS3FxOVlodEtkNHJTVHlCd3hpS3ZxcCs2ZnE0eWIrUFlMVVA1N0w4?=
 =?utf-8?B?eFd1OXJMZ0QrbWNycGZPQ09OaWUwWis2ZSsvTVU0czI4WnovcTFFTHVwTjlq?=
 =?utf-8?B?T0FibXBlTjI4V2lETEE4V2RCZGxsOFRDQmp5VHQ4b0QyWEhKcCt6TGlENFFj?=
 =?utf-8?B?UGJYMHJObzZNazRoQU1xbkNNUEVpR1Q1T2dMNGFwMEVtVG1ZWXorSHhRQUJJ?=
 =?utf-8?B?ZUJ0a1A3d0g5UURzR0FSczRvMTZvb0lQNGNpN2xGZkV6blIrbkpubnl2YzVx?=
 =?utf-8?B?bFZGTG1DRWF6dG51TWUybDdyeVkzdEZFOE85MmlqUkYrN3hDNDBEQkI5YlBE?=
 =?utf-8?B?RWx4aVl5SUxYdEFUbmlJZ3NJTVhZQTFjbmRsb0xXaEJ4ZzBNZ1k0NzZidCtZ?=
 =?utf-8?B?UHZHaVduMUk1dmJOckhYNnY5WTVPSkd1MnBKUWxIWEZYNkJ2dGxsbUUzRnZZ?=
 =?utf-8?B?WnNlL0NGbHBuNGVYcENaQVU5ME9ZbTJ0emxOMU1Zb0dFeExqWjFUVXRRTFRZ?=
 =?utf-8?B?cXJyTWwvZEdGYUszQzNhQ0FaY3RueE42T2hoL1NiY2NIMHp4aUhzdkQyVW9i?=
 =?utf-8?Q?yUhr2mPSDcXsOsBKOfhqugguL7SsbA=3D?=
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LIwqIZWh27LIfXK7XUYeovtGkw6nTdhcg/rEwbySAAbbmbUnudPSOg0/8pOqWeb39vzCRo3VbRgyLaBEQJ1WfCKEpl+P2BIbzNpuAEqh41+qnZ8IdvykFhd/881hARdPqdCWGiTwQ/NUV2gxxdHzQaHkJo7wKQb5Xmja2fPSR2JnrjuWA6nO80pKkztDIiUC72ERYJMrpm9RNWBrhIgZv4pDFoM4fklL/CgQZOwmANnM6R0E1dTCOhq5xGYqvoDW4BCSuTH5mf4hyYTsD5QScuHBSTJX/qjU9f9s/+Q5AA/OwOAs+qbDml1hFBU3gskCXQT+b7vhGir1iyvD2mN5nyFDkmsVnPbJOV5zYmhgab41j4H/oejGQ99it4BbS5t0efnaCMVKf5KOOX2T+TNZ73L7lmLs/oCC+RCsVYqiH2CrsqftB/ubyKz4S1I71WOybaQjNsaN6vWyZvLR3eCIWK4RQiAtDfkJoVCONFG2YScw2IkyBgXEj6/B4rVGki3eR7XsH58qRbFIfHeP/No2NYRn5OiGV9+r/ngy8XmxFZ2KV5ZlWO5mPo4miBhA7iZMvNKcdaiyPJwoDfsZ/Yph8Yx74fceY7j/ZDonzifBF/E23M2lahgWQ4KRAjSFkoVcU8F6V6NSzz88KQzCPo3ung==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2025 13:05:13.2697
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f8a0aa3-4383-4301-0333-08dd72b02bf3
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR19MB6517
X-BESS-ID: 1743685516-110872-7686-13661-1
X-BESS-VER: 2019.1_20250402.1544
X-BESS-Apparent-Source-IP: 104.47.59.173
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVkYWxmZAVgZQMNUiMc0g2dA0Mc
	3S2MQ8zSzZKM00Oc08KdHIwMIi0SxNqTYWAEQDCDNBAAAA
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.263622 [from 
	cloudscan12-125.us-east-2a.ess.aws.cudaops.com]
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


