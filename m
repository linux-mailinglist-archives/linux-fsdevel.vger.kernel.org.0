Return-Path: <linux-fsdevel+bounces-45642-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5343FA7A353
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 15:05:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CF8A3ACBFD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 13:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA6B24EA83;
	Thu,  3 Apr 2025 13:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="UDpsl0ut"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip168a.ess.barracuda.com (outbound-ip168a.ess.barracuda.com [209.222.82.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107C724CEFD
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Apr 2025 13:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743685530; cv=fail; b=FMZMonYU/zIbRC/iZX+w0acvE8W/IYVXCL54cqaK/VJVqYQvI3uiQxRVVBCam5T0Vz9LGq3z1qip6qeQ8GCKR102I7rRC1KyOzK5hD4zayfQRbRen+Qst0tgmS++mCz4QHU5gB3GzL1PmM6YU1eNv8o0lOtlTaa4BAMYImjVZxs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743685530; c=relaxed/simple;
	bh=EeR4SAHhK/bZrl9eB1DzSa1KvaWoEbbw7frzCsxDreo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=LoKHOZJ0v6AIAgW36FTTr6yfmf0MJRoFVo1YA8HprAOWDCV7mfid0yYGtL3BU19NAW4W1B/mV/EeG/3n7gEiIT3Hfy1fbfDnkwONQdsE+uQGy6l2R+6hviu0bn1UGwGNTLBkdjJdNhqmKRm28jrsZBwiRz2VQszPczS5q7GXVkE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=UDpsl0ut; arc=fail smtp.client-ip=209.222.82.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46]) by mx-outbound-ea8-37.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 03 Apr 2025 13:05:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v7NjxXgE3OBJw3IyxamWTd35PekwpPK9gQEzeYWVOZsyOA2FOTtkF/gpwXf1f4TJXgTpOHglCJlZGPOpSOwUxYy3VJFzJfKLnGCBr6uyN0GgZ7bGwX6Il72L/YqYUcUIp46xyZHRbnC7M7bAXQPfvsQOaT9MK/yxBk8vaO9SXYuMXpqn11iyrhbPbXev0a0VdhMlB4qAURMbY8RE5R/wyCpM+U2x+FBxP9WOvCYnsJB+5CoMaB1gX/9VQ/+ZjMLBX4uI2tS3QcoUXUHrRcouzRrBPDZu5xphvnh8PFzAh0Qf3f+MMyaywLhTGSHiwki5L5MrRv2Y70ipZCX2FrKz0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6daAYI64Qu4j37R76WUocb6uDG9rHc48z03ot2/VI8k=;
 b=yCf8oxPsZ6hd+z6O3G5wFFn+Pm4gt5ZleacatDIDdlzUPbLdye9MhmHOROhLypsCtBjPxSPmktChfbi6/OO5g/JztqyFv8PbZJeFM2OCsXdt3I5x6p/3c+5jz7vmS7gpxBsUDdvcB4ZhuvhcWzPacsCc0w5+oTPiwBitBTjFa2qQdGzXaF7Q4qXqe4Uq4ZiZWf4k9qMB5U8xk6NQJUcuoLqcby1+wxwwUKubh1P7IaBSXzTLRjs8D5RCaAfcPxyGeN/l5qmiIdwby39Y5HENdRZRrVKz7eHXDdTPS9tSlv1rpbF+ZoePL6RjfDN405VjZW+LgV57rdybWP6MYpaQ1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6daAYI64Qu4j37R76WUocb6uDG9rHc48z03ot2/VI8k=;
 b=UDpsl0utdgJ9EegmuATBLROAOKaUAQqaSkz7Aod4HszNT374ndt2OPv8V4oWAx517K7nj1Sv1TWnq+uKcxmn+WkNVGblPtzqJBooo8XEQOW76URFXqC1Zw1AvdVYsv92JpKr6+bDaFlhJkEWoBULQ/LuxVVXCmzUunhbYY902QM=
Received: from CH3P220CA0030.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1e8::21)
 by SA3PR19MB8196.namprd19.prod.outlook.com (2603:10b6:806:37d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.54; Thu, 3 Apr
 2025 13:05:11 +0000
Received: from CH2PEPF0000009A.namprd02.prod.outlook.com
 (2603:10b6:610:1e8:cafe::4d) by CH3P220CA0030.outlook.office365.com
 (2603:10b6:610:1e8::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.26 via Frontend Transport; Thu,
 3 Apr 2025 13:05:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 CH2PEPF0000009A.mail.protection.outlook.com (10.167.244.22) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.22
 via Frontend Transport; Thu, 3 Apr 2025 13:05:11 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id 5FA1F4A;
	Thu,  3 Apr 2025 13:05:10 +0000 (UTC)
From: Bernd Schubert <bschubert@ddn.com>
Subject: [PATCH v2 0/4] fuse: Improve ftraces, per-cpu req unique and code
 dup removal
Date: Thu, 03 Apr 2025 15:05:05 +0200
Message-Id: <20250403-fuse-io-uring-trace-points-v2-0-bd04f2b22f91@ddn.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIGH7mcC/42NSw6CMBQAr0Le2mf6GgrqinsYFvQDvIUtaYFoS
 O9u5QQuZxYzByQX2SV4VAdEt3Pi4AvISwVmHvzkkG1hkEIqUQuJ45aKC7hF9hOucTAOl8B+Tdj
 cBala61aaFkpgiW7k9xl/9oVnTmuIn/O108/+ld0JBRJpIYnGoVG3zlp/NeEFfc75CwZh3/zCA
 AAA
X-Change-ID: 20250402-fuse-io-uring-trace-points-690154bb72c7
To: Miklos Szeredi <miklos@szeredi.hu>, Vivek Goyal <vgoyal@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Joanne Koong <joannelkoong@gmail.com>, 
 Josef Bacik <josef@toxicpanda.com>, Bernd Schubert <bschubert@ddn.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1743685510; l=1452;
 i=bschubert@ddn.com; s=20240529; h=from:subject:message-id;
 bh=EeR4SAHhK/bZrl9eB1DzSa1KvaWoEbbw7frzCsxDreo=;
 b=E+LFgJjUINohfBHyuIfCDgc3jOl6z9l8CZY/Tv+L7vlRlKPWD/KsRdO8PI8DVTJ2/c/KpUtqI
 CeqTWrxWCP7Cft2xnTColwPBkWPr9djO1L2dMigKVI3XYMKUQ3Km3ue
X-Developer-Key: i=bschubert@ddn.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009A:EE_|SA3PR19MB8196:EE_
X-MS-Office365-Filtering-Correlation-Id: d1f2efb6-f96f-4abd-566d-08dd72b02af1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cFBpei9vMkorMlZCZHlCREVMVmtQS0c4a243MmdUVkpJbUhlWTVCaG50dlUx?=
 =?utf-8?B?Qk4rOFlVdHowaldRWFJpR251bVhkdFpFWks2NSt4UmRMU2g1VnBnS2hIR3Jt?=
 =?utf-8?B?ZWtKaksxeDJLZHNmLzFWc0xXT2JLdVBvcXl0VHkrdUEwRUkxRGdhTzhyZFZn?=
 =?utf-8?B?VHNUWDNlNVNnS1ZCOXV2MnRPVHhFbzBQUUNWdEFTOVdWZzNGSTFpODJiUGZj?=
 =?utf-8?B?VFpGb29SQ0JuY2pUSndIYlkwbWduamlnc25LV1FqeTJ2U2s3QmpuZVZlbk9t?=
 =?utf-8?B?S2Z4ZS82dmhBcXJtYysrNDg5bmFrZmJEdmJpQjlIMGp0YjY4dWJURCtoeWZ5?=
 =?utf-8?B?YVNiL2tQUldRUmIzZ0ZFc3JxeEhjUlBJcVh4c0dLK3luSUVNSkVSQm5PVml3?=
 =?utf-8?B?U1o0Y05wUEJ4YzNTeXpzNjF2cEpmOGtHMzYvUmJqUUFOMEU2M0gzbngxc2p4?=
 =?utf-8?B?S1lIalQwbFJpK2VpeXdHd0pDR0tLOWJ3ZG5PUWZjOVh1eHo4cHRUSkFoNGda?=
 =?utf-8?B?UFFrTGUxSVhNY2tudFRBakZHUUh6TDN2Vzd4VUZlU0c1UWx3UWVSV2xLeE9p?=
 =?utf-8?B?RXZtanppdmdMQlRjK1Z6bnV3RVBFSmpMb1RTeVg2SW1FZDJuTTlnK0ZyS0M1?=
 =?utf-8?B?Mmg4RE13aktRdDhXM3VMTWNiTno1S1p6WCt2WXhYOVh3MElsSkZ1RWRoaC8w?=
 =?utf-8?B?YVFpYXp6d003bGdjbjJEdkRzeUNTajd6YlVYTG9xNDhwNTJOKzZvVVFWRkJv?=
 =?utf-8?B?UU40Rm5xZllNd1RDandIOFkxNXgyMzg3L2liR3o1OUhyNEtlZzArOHZzOE9M?=
 =?utf-8?B?YU9QRVFPNFJKT2p6eXNaaWRCTng5TjRMWHNWZXBZUEdnSUlYcmYwQ1VlOUpO?=
 =?utf-8?B?UnF1K1FaNkF2akNlditSMVJzOU1pb3VMOXhzZWFnSjB4VXBLcjBzaXZKVlVO?=
 =?utf-8?B?Z3U4Nll3T2VjeHdBS0FyOG8rdHEraEVpa3FiVm0vMERqVUxCWkFtSDQ0TURP?=
 =?utf-8?B?VkRGalEzVllWNzd3WTFXdytTOWxhRjZoMXp2T0kxZUpzTlBFSldUeFhCV2tq?=
 =?utf-8?B?REh1Y2pDcjV3OXpqUk9ONjY2M0ZMTHdyU1BOTXROdWtNZ0lVRE9VZXBRTGVF?=
 =?utf-8?B?QnBtbm9KUFl4NmdVcVlTUDVoZ25rYUxKamRmSVM5WTlEL0JqUEIrQnowSUgx?=
 =?utf-8?B?ZENUVVZ2MW9jZXR2NHhTTDZNeGN5WEpFRzB3NnhUZSt4WTFzYWk0UFRhaURx?=
 =?utf-8?B?R3FBRTh1KzAyMnhSalRkWjFKNjVDdmlVckRxVDB0Y0U1eG4yeUc4SHE5VkZC?=
 =?utf-8?B?bWdneUtRS1JOTmxWdWx4QjZqYU9CWkdzRGhGS2pMNG0wWjgxS29sZGR6N3kz?=
 =?utf-8?B?a3dMdlpZbDJHSk9mRWZVWEp2NWVZMDB0NUgzYWllOXkybEpOb2pVU3BWOTZH?=
 =?utf-8?B?UDVyTk51c1Y2WlFrM0xhYkxFNDRxa1RNcEtPMUNUVXhVMEVLOENrNkZvanJP?=
 =?utf-8?B?S1dXczhNenlnU3dZd2tPTFU1YlJheFhYb0prSkRQVEtDZmpWYmUzWVlhMHpW?=
 =?utf-8?B?UWwybEE5Z0V1V2djVmtFS3BjMWhiUUNjODFVdTBEbmlyVDdQL08walFQK05T?=
 =?utf-8?B?Qlp4VHV6RXluaXFpS05aajJ5bzlCeG5PUVlDaGk2cktHa2pRYyszWm1PWktp?=
 =?utf-8?B?bHdHRE9PYitLTWdFRU0vUXdEOEU0TnZWSjd4djVGd1FSZ1VmRHNCU0RlYk00?=
 =?utf-8?B?N1prNGJhM1B3bE9leW01bnU0Nmw1WnVOZWcxZ0xBTGNjSy9xYVZucDdOc2Iv?=
 =?utf-8?B?bStUUVlSNzJkTk5FeEFBN0c2L3dueGRyaDJxNGxLUU1GNzJ1TEVycVVHeHdw?=
 =?utf-8?B?Z2dESmR6ZmVlNU1QMWM4NlJ2ZlR6UzRoKzBPajFTdWducEt1U2xCenR6cjhH?=
 =?utf-8?B?ZlFFcTlsSW1qZHd2Ni82N1pOdXdkL1FSSFRmTjV4cVZrSUYvVFpOWGxIYkgz?=
 =?utf-8?Q?HSu9bwhAi8snSxYHEh47eIFL/YGfOc=3D?=
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	XnisgycE3vGfzGG6aEJ5VGeX6z2zk8xr/69rVdBUWjUoAbzxxTjtqfsxCrGzlExp+UE3zLYZpmWEzt7AEob3go42MJUIZn0xRHVS9BOnUO6AopWJ9v++KHxg1dCY6JNPJ56iJGTSWj/s9RzHtL9IMuyuoE1I1tG4gCL36N2CYP8zQWYwRyq/QIuBVRmm73tXAl4HXWwipEiwzOSyLFHw38Ojt90rTcxSOaJW1m+dXfvGTySlj81huG+nZj3tOTa/FoHXcFAv4QN0b38JVZ4ZcUjn12nE7cLQhdiavRMrKpi01ZIlEhIJJ0rwIbOV3eSm3dGJJdpix4/iExQZQ/Kco/mV2Lxs6ZbUBFr3LGNQmlmF974YjsBWd/zKdR2yDtk0/LSWGTYHGkY1iPskPdN6eqxAP5OqpJwI2U95xu2iyXOPSssE+TT1omNZKKKdBO3xr6Vmn99vs4MFlM24MFI6NmYYX0qeECImg0b8taAa1eQKL9LGq/6W/e6btGt4jz0zDnsZXY9k7UpW+Z1TG6Zlhdia32c1K4w8IkhsbOCDYCAgWqrClQASQjN+8ZIdE87wwJdR1CyG0HMT01n27sIYExCXZG1oHzx73ItJHkHFy6f8tE14H0mOqI3jazljEyZ+34z716isKZkCw5hR/IMgkQ==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2025 13:05:11.5029
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1f2efb6-f96f-4abd-566d-08dd72b02af1
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR19MB8196
X-BESS-ID: 1743685515-102085-31777-29783-1
X-BESS-VER: 2019.3_20250402.1543
X-BESS-Apparent-Source-IP: 104.47.66.46
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoYmhqZAVgZQ0MLILMUszdzIxM
	A0OS3ZMNXIPDUlMSU5ycDI1NQi1TJZqTYWAPXqCEdBAAAA
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.263622 [from 
	cloudscan13-233.us-east-2a.ess.aws.cudaops.com]
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
 fs/fuse/fuse_i.h     | 23 ++++++++++++++++-----
 fs/fuse/fuse_trace.h | 57 +++++++++++++++++++++++++++++++++++++---------------
 fs/fuse/inode.c      |  1 +
 fs/fuse/virtio_fs.c  |  3 ---
 7 files changed, 88 insertions(+), 81 deletions(-)
---
base-commit: 08733088b566b58283f0f12fb73f5db6a9a9de30
change-id: 20250402-fuse-io-uring-trace-points-690154bb72c7

Best regards,
-- 
Bernd Schubert <bschubert@ddn.com>


