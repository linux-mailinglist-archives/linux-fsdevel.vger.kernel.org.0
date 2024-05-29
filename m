Return-Path: <linux-fsdevel+bounces-20462-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD768D3DD8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 20:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9361E28213B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 18:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA04C1A38D8;
	Wed, 29 May 2024 18:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="jncKEe5e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip168a.ess.barracuda.com (outbound-ip168a.ess.barracuda.com [209.222.82.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B08AFC18
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 May 2024 18:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717005685; cv=fail; b=Hy1N7pmUOb/b+qEuSM0/93VyMXIfmDudBwp1knEVFHFkePxlBB5WiCXNFn1A+B3VhmvUnhfNsFgUxllgw0ycybEApK/pxiYJJ7boqSvPM53p4PoOqj/CIeNdZ18I01n7pCAqqoKf7so2o5lFWEwlNficClFgXuwz1ZGkYP6TLJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717005685; c=relaxed/simple;
	bh=MEK1vbj5ymTp2LNfUE+mfKARrGzFvVGkw7vWcp91zlQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=utUtLqm7AlAGeXeUMyrx6DJMv4G2Eh+RNNoA5xEK/6KUQVPk0WQV2laRTamoIhu5MdrTcOJDnCq1Dzn01fPYfQuEl2Bq5KAz7uKXajdiE5oRR9Yk3lD1+NlwgiBXDqy7zmz8miMmKhAJAFQg+Qfji2AgtDO4IBOVeRvtY0XVx2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=jncKEe5e; arc=fail smtp.client-ip=209.222.82.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168]) by mx-outbound15-162.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 29 May 2024 18:01:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l91R9yQOgcqDwAUY3a6CpDNcbTl1fI/N9ie8EnMl9ziTKvhGBTh3XdfrETJ35b7jup/bREwsk2PIOp51hPFBU77e7ag6vy7cbhH/My6s6LcYHzhy6bpuYpfcdV0uXS18fAS0mA+LfzOfnqHgu7B7HJfUHpMNe2VwaHs09hYZ0B7rhGc0+49YRsQnF45NNm2TyJzcQmTbN7bDDOi924r7SYZosxnu6Dp/2HQ0P9Q/zWhKgDVWsG7syCjTS7VcgKfKwMSKeL2n7AKhoKksgGtNMTsHC20NAOW24GqD3AJGiJFz77AbHrJ1COwA/gcAxBLxDv6MjV+sIu8gMZe6ZZkFJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aSDWP2yoy4IFjpUm+Q8LhV3ckwRUXFIc/vCejQP3TmA=;
 b=N61dVFT2GElBIjsDgtefBKVsyF11tVmhLX8zFMBSdcxfG/s7rF3yh8kCTIZwuzaxcn9ktZFTYRRFsj/OUC40qyGMkc3JxZTcqCuZyeY8E0DWxI5ku8Ee+PtPuV9lHL+bQhYPHXoFWHNppfAkWVxq/dPgnMwKDaEopPW+boCU3yYX0VvJZ0Q4XWFLqsqT0Wywv+tZwv+tkrak8Ln0DlA2TCZ+jP3kTWjBU71nMYQt1+PsqvQjDl5VEodM7E9uT6dCQ7gOsT1WnsaUHEDNwW8O9RYgB3kZFWgs/bIp+CgQJ4bhDJUQV8bePWZmnGVVX/ERIV52GwXEm5/8riXfbMNHww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aSDWP2yoy4IFjpUm+Q8LhV3ckwRUXFIc/vCejQP3TmA=;
 b=jncKEe5exS+Lj7juLD8tRH8/iE8mF6LtnDbljszqXWR3iHxz4d75wpGOAeLspxnJf+Z7XMI+jIOJSWDLitQOh10jJcQu7aBXFLI6lr5LII6Gs/lyBrn9mLzYEBAnoiHqziDNzEZAoXIxuK7qbvXLk170Oz/0tkgr1gU1fylu0zk=
Received: from PH8PR20CA0009.namprd20.prod.outlook.com (2603:10b6:510:23c::23)
 by CH3PR19MB8408.namprd19.prod.outlook.com (2603:10b6:610:1ce::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Wed, 29 May
 2024 18:00:56 +0000
Received: from SN1PEPF000252A2.namprd05.prod.outlook.com
 (2603:10b6:510:23c:cafe::f1) by PH8PR20CA0009.outlook.office365.com
 (2603:10b6:510:23c::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.19 via Frontend
 Transport; Wed, 29 May 2024 18:00:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 SN1PEPF000252A2.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7633.15
 via Frontend Transport; Wed, 29 May 2024 18:00:55 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id 2085A27;
	Wed, 29 May 2024 18:00:55 +0000 (UTC)
From: Bernd Schubert <bschubert@ddn.com>
Date: Wed, 29 May 2024 20:00:41 +0200
Subject: [PATCH RFC v2 06/19] Add a vmalloc_node_user function
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240529-fuse-uring-for-6-9-rfc2-out-v1-6-d149476b1d65@ddn.com>
References: <20240529-fuse-uring-for-6-9-rfc2-out-v1-0-d149476b1d65@ddn.com>
In-Reply-To: <20240529-fuse-uring-for-6-9-rfc2-out-v1-0-d149476b1d65@ddn.com>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
 linux-fsdevel@vger.kernel.org, Bernd Schubert <bschubert@ddn.com>, 
 bernd.schubert@fastmail.fm
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717005648; l=3644;
 i=bschubert@ddn.com; s=20240529; h=from:subject:message-id;
 bh=MEK1vbj5ymTp2LNfUE+mfKARrGzFvVGkw7vWcp91zlQ=;
 b=wvvWf+kh5GtFI/JGVzigS1TQbbczThjg3WJf1TqAJdEr6uffBA+v6LPQ0OKHxRlWpdp1EaBs1
 k8Y4k4nEqlBBCHQgv87hXfFlemn57LisBD045TRX2i99U3l3zIH2iyo
X-Developer-Key: i=bschubert@ddn.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A2:EE_|CH3PR19MB8408:EE_
X-MS-Office365-Filtering-Correlation-Id: 992e47e7-78f3-4c09-0c89-08dc800949d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|376005|1800799015|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M1A5Y3VWYmhkTVlZVW83dEQxTWJSSk9td0FJT0EyTkMyTTdqQllwdHFWam9E?=
 =?utf-8?B?by84TjZrKzk1VGpWU1paL2tLNk9XSlhyT0RpUFdiWjVuM1Q0K0JMNmFDTzF6?=
 =?utf-8?B?TnMyTnJTS2g2ZFlDTUkrcFBSbXpxT3NLczl4cHNMRmRjRlZwMHVQb0YwR2Vt?=
 =?utf-8?B?N1RrUFk2M1NFTnRpWW4rOG44aVVjRW9QQUtXZVNQMFhkcTJLMHpLTDR0ZDdz?=
 =?utf-8?B?eVJMeExQTXcxcEgxazJrZmRMNUZGeUJrRjNhMG9vaHFKL2RpSzBrZTBQOHVl?=
 =?utf-8?B?d1lLd0kyVk42a1pHVmZuQ0luQnl4eGZVQTUrL2pPMzd3ZUNZem1reUorZVpR?=
 =?utf-8?B?NzVKS0xQQUgzNVNZVEIzNW1xbkFkcS90K21FR3FhOWgwVm9aOUVaQXVpc2xU?=
 =?utf-8?B?QWN0M1ZRZnR0dVRPSEJQZGxRR1h3SkpsRy91SnZiUnlYelF0U2JQd1I0Slk0?=
 =?utf-8?B?dC9EdStkcWhGMDFxRzhVTUNrZXNmU3pza3BqU2N5bmsyR1BubDl1Z2lNZ3lj?=
 =?utf-8?B?dUVJZ0xJY0w0SDJyRjVEK1ZINW1YMWJOTVRCYndDLzY0OVpqUUV4d1pzVStJ?=
 =?utf-8?B?UDJHelEwK2ZUYjhBbFUwMSs4aGhsME1ZK3p1bGxRaXVRVE1TM2dWOWRXd2RX?=
 =?utf-8?B?cWJYTGc0OW5YemlhNGxqemhYSXFjOWJMSno4ME84eVQ4MTRLR2QzcXlmK0lE?=
 =?utf-8?B?czY4TDhJNnpTeGRIaFlSSGNIb3ZLdHlNRzErNWwwOHZkTlhtcVZWVHBLYk5E?=
 =?utf-8?B?N2h0aWU1dVIxZEVtcDR1NXBmMEpqWGRxcjZyL01kNnVCNmJmRitHWkM3QXBP?=
 =?utf-8?B?eWdub0gyQTJwQkZLZGRyelhaTnZGZjZSWkxlRVN0UXZRSmhVbnBhbTM2QWNG?=
 =?utf-8?B?UnJPMlNScjVQZDNIVUMzMlNXVWkya1VWYnI2VG1FOVlXMWsrRGxxZHFKVFlU?=
 =?utf-8?B?T3JRbDRzYlJLUGU4eE9VeklyMEVSd2ZJZXRVaWZ2aU9VaE05NExCa09RMDg0?=
 =?utf-8?B?cUYxYWZWL3lhZ3Y0WmE2ZEQyNHljMjlvZEtxaFZSQ3FzVUpnM3RyK01xVysv?=
 =?utf-8?B?RW5TUUJ6dEJUZ25VRC90WjdtYlR0Q1MzdGo0YWErS0ZUT05BQU9aWWFmamx1?=
 =?utf-8?B?blN6bDhFbzlLbjU1ekVtWUd4WTZpWlFsbjhFMnprMVUvdEpPcWhtN0hja1pL?=
 =?utf-8?B?dlVjVHNIL0tHK0dlZksvUWE3NDFpc0NBQm9aZHY2cTcrMGorNkZXOHlKdkky?=
 =?utf-8?B?cFQ1L3JBTXZZelUrcTdsaGdoeXVwM2ZNbXgzQzRjd1ZIZ05Ea3JMcmhDRXVL?=
 =?utf-8?B?VVB2WnBmSlEyTTladnlUU3lrT0tHK0Zic2pCdUg5MjNyQ0pVcHFKTXplK21F?=
 =?utf-8?B?ZzFHQkFNZFd0dC9LNStPYkkrVU9yclJVNmY3OHhyclVVRUIxVTNZYkdzeW8w?=
 =?utf-8?B?dTVTclR6RnpZRmNRNUtuZUwzYXpjK2JjYmlMbjZGM1Z1c3R0ZWNzQ0NSWGNN?=
 =?utf-8?B?Zm12ZGx5cGtiZGh5NFg5NnhncVdsMWpBd0RueGF0S3V1UHpkaHV4aGk4SitY?=
 =?utf-8?B?OVRPQm0rdmxER2owZjljNUhOY0JxeHp0Y2QwMGF5WlIrN1lBMTFZUldMbmxZ?=
 =?utf-8?B?WlFXdDU0S0RIMTNuZmRORnZ4aHl0VFRqeXZqU3FBKzBsa01BbVFTcnh3VzE4?=
 =?utf-8?B?Qm0yWHhzektRckdpT0x2dmhQN20xUWdwYmRNSytKR1A3TFJFZFIrY2JCeXVz?=
 =?utf-8?B?eitPUjNxZWI4OTBHWnZNaXN1TzV2MkV0K0I2Q0drNHlUL2VwdCtzQlBsUS9r?=
 =?utf-8?B?eHhacVNTZzVoeXo2Vnpmc2VidFdSVUhwLzlDUTBLY205MjJKMGx6T09qeEUr?=
 =?utf-8?Q?sW2BgWCvSpGiQ?=
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400017)(376005)(1800799015)(36860700004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LbQwQzfuSAD7NMDJn4H5TnjJWrGEx+QMwvSaAzShxa13Rp+0YXLpgdwxYTxytDUgzxuAx4WGuZyzRt6Ki6WrfTCjNb99cUJwUX6MpAD3vK7ED+P/BY8WHzMhIRYk89hMnhQSgaUKMD3c5X1dnedsr0oz/GO9cXOQLmnCQobO97ofMiPB2UkyoE7+4v6fODzth3DL+7jPYZy5/sZ5MQGlxrB7/0JYr323I1retzZy+VGkcTCutVtROJshM/xRGGOFRGUtcGCyhS8x2MhzbefMRlREb1vGIJckOjTYogW1a2KrYNv+TLh9SyRqUaiVQ70JQa0TERWBSro8YEDRSvborx4/pKaFs16jYJWAqqFXU5GxQpdXYFtYW6+upznC42jjB4qqpjv/qJQX8lZyTluqCVvShp/XHI1LWhmBIgGoOrsmBTTMxp0ejoKOkzOnh9TUQ8yWlI8zNHxujZLfOEnrevue0KFw7KJ43j8IV+Tv/VYticK5MCx33mZXQSDEEED5aJiCjVZ+cjG2tPXYbwSHSwUlUZasL2uuQ6vfjwaFQqXaUw07BQHdmAxa8N8L6XOeCxBKgT2bAwOXJwh+UV+wJjk4T/MuXF1B5cQTq64DhYYnMXYyM2tdjIk2yzPbtqOiXLPfFUqVP8z6GgEybbe18Q==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 18:00:55.8130
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 992e47e7-78f3-4c09-0c89-08dc800949d8
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR19MB8408
X-BESS-ID: 1717005661-104002-12629-48742-1
X-BESS-VER: 2019.1_20240429.2309
X-BESS-Apparent-Source-IP: 104.47.55.168
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVsamxuZAVgZQMDXVODExzcTE2N
	DUNDE11SLNJMnYNM3MIMnQ0MzMwixJqTYWANJkkRJBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.256584 [from 
	cloudscan10-209.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

This is to have a numa aware vmalloc function for memory exposed to
userspace. Fuse uring will allocate queue memory using this
new function.

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
cc: Andrew Morton <akpm@linux-foundation.org>
cc: linux-mm@kvack.org
Acked-by: Andrew Morton <akpm@linux-foundation.org>
---
 include/linux/vmalloc.h |  1 +
 mm/nommu.c              |  6 ++++++
 mm/vmalloc.c            | 41 +++++++++++++++++++++++++++++++++++++----
 3 files changed, 44 insertions(+), 4 deletions(-)

diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index 98ea90e90439..e7645702074e 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -141,6 +141,7 @@ static inline unsigned long vmalloc_nr_pages(void) { return 0; }
 extern void *vmalloc(unsigned long size) __alloc_size(1);
 extern void *vzalloc(unsigned long size) __alloc_size(1);
 extern void *vmalloc_user(unsigned long size) __alloc_size(1);
+extern void *vmalloc_node_user(unsigned long size, int node) __alloc_size(1);
 extern void *vmalloc_node(unsigned long size, int node) __alloc_size(1);
 extern void *vzalloc_node(unsigned long size, int node) __alloc_size(1);
 extern void *vmalloc_32(unsigned long size) __alloc_size(1);
diff --git a/mm/nommu.c b/mm/nommu.c
index 5ec8f44e7ce9..207ddf639aa9 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -185,6 +185,12 @@ void *vmalloc_user(unsigned long size)
 }
 EXPORT_SYMBOL(vmalloc_user);
 
+void *vmalloc_node_user(unsigned long size, int node)
+{
+	return __vmalloc_user_flags(size, GFP_KERNEL | __GFP_ZERO);
+}
+EXPORT_SYMBOL(vmalloc_node_user);
+
 struct page *vmalloc_to_page(const void *addr)
 {
 	return virt_to_page(addr);
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 68fa001648cc..0ac2f44b2b1f 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3958,6 +3958,25 @@ void *vzalloc(unsigned long size)
 }
 EXPORT_SYMBOL(vzalloc);
 
+/**
+ * _vmalloc_node_user - allocate zeroed virtually contiguous memory for userspace
+ * on the given numa node
+ * @size: allocation size
+ * @node: numa node
+ *
+ * The resulting memory area is zeroed so it can be mapped to userspace
+ * without leaking data.
+ *
+ * Return: pointer to the allocated memory or %NULL on error
+ */
+static void *_vmalloc_node_user(unsigned long size, int node)
+{
+	return __vmalloc_node_range(size, SHMLBA,  VMALLOC_START, VMALLOC_END,
+				    GFP_KERNEL | __GFP_ZERO, PAGE_KERNEL,
+				    VM_USERMAP, node,
+				    __builtin_return_address(0));
+}
+
 /**
  * vmalloc_user - allocate zeroed virtually contiguous memory for userspace
  * @size: allocation size
@@ -3969,13 +3988,27 @@ EXPORT_SYMBOL(vzalloc);
  */
 void *vmalloc_user(unsigned long size)
 {
-	return __vmalloc_node_range(size, SHMLBA,  VMALLOC_START, VMALLOC_END,
-				    GFP_KERNEL | __GFP_ZERO, PAGE_KERNEL,
-				    VM_USERMAP, NUMA_NO_NODE,
-				    __builtin_return_address(0));
+	return _vmalloc_node_user(size, NUMA_NO_NODE);
 }
 EXPORT_SYMBOL(vmalloc_user);
 
+/**
+ * vmalloc_user - allocate zeroed virtually contiguous memory for userspace on
+ *                a numa node
+ * @size: allocation size
+ * @node: numa node
+ *
+ * The resulting memory area is zeroed so it can be mapped to userspace
+ * without leaking data.
+ *
+ * Return: pointer to the allocated memory or %NULL on error
+ */
+void *vmalloc_node_user(unsigned long size, int node)
+{
+	return _vmalloc_node_user(size, node);
+}
+EXPORT_SYMBOL(vmalloc_node_user);
+
 /**
  * vmalloc_node - allocate memory on a specific node
  * @size:	  allocation size

-- 
2.40.1


