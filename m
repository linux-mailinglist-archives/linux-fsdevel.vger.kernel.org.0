Return-Path: <linux-fsdevel+bounces-55756-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B8FB0E5DC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 23:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 890BC188E792
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 21:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56ABE287507;
	Tue, 22 Jul 2025 21:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="TM7z2mLX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip168a.ess.barracuda.com (outbound-ip168a.ess.barracuda.com [209.222.82.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF41B23A564
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Jul 2025 21:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753221500; cv=fail; b=nVkyKhgasscrT8VqtnGDfakDs9eM62mLI0FlziWuXm7K+r07ThUivPiqsLWiDj6+cRDFKitLsiX61FtgU6Ys7vSjxZJdTzoy6k0EZH3dA1yIpmCfJUAO3DE80cM4gAL9q8oIKmkUKC18MAxHbIT1YDgcIkb7AI/h97sIPDnYJjc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753221500; c=relaxed/simple;
	bh=pzGYnNWuz2rev1DindXgjZBTW+Iw8+mPUZvY0wFFnsI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qda3WITNwGWqVDFNsXCc2uaiKnoPqVFOnwWUYuswHV6/fFCZK6ri1yomfSU6cnQb9aET2wIjwS6AmEQGyZ2ZZ/dTXgDgM6A5OPUEXeveuqBWpAETRD2SRn4ORb3QOvMfEcFb5SBHpk9tCLnja63uz9F+yaAyqX8cSF9S9rNpr9o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=TM7z2mLX; arc=fail smtp.client-ip=209.222.82.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2133.outbound.protection.outlook.com [40.107.220.133]) by mx-outbound44-216.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Tue, 22 Jul 2025 21:58:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WkVIp9uiNaCttDK3F97iq1Xsd28SgQhb1Ci72mWafrntPZiH9jgpJUC+M82gfErVYSpRYIP1yarPIZJP0sRJffnCabI7Aa1XuUpZ0bLhoiwwr5KS9Hy9wRY1vmPU7Nr26JeKTyd64trGTxE+CijjS2q1O2eMS3/bC9778M+Vxuk0YPVUDsZc14wPA8EcZKFwX//v0LS+f1st8Xg5pfJqatsycZz7xJqdX2oDiDhrY5EIbXsyX0LDqqHuyg1+scrqIUX/dTVlUNWPmUFY5tKQ8a5NPcMhYVUcsR8ezHjatofTOmTeh2EnuWsmCkuj+eZN5tlHykpAVkwhSYaxLJWlzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D3KA6+3Gc+hdIiYCNYDru/JN1D6WTFYr+cPjPtZwKRs=;
 b=WhYIk+UFokaa+w+sz3bMQanLPvXjQ/O0ZNfpKq1HjcsehhWnlX5F86nB1XV+e+PtqBgEyqQ/FQ4UbE5fuJIKms7KY4S1qnHNgIKfTaPovXu8FcV+SIdI7YQqdNjTDfGP9kyKaIAeF7zkm1OtCGZ6bM2ddrrz4efAlDeuLeeHO/X3WevbY0Pb6TimA7gtPRLWK9QMcG67+Li6e0d+6IUZI9ItCL+cPWnzu8Z7zaNEV2f3AOOxqj4gqifHFgprZ8HzBQHCJ5IQ+AE1DLOOp9Lng2PMss2NoujbEU7S222Rj1S4Gw/AUqyBetFgntZFEK4f+GV7SBtaW6hvmpkz4DqRFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D3KA6+3Gc+hdIiYCNYDru/JN1D6WTFYr+cPjPtZwKRs=;
 b=TM7z2mLXeJMRh/NmrGWJHQ0NKyfnsi0FRYiIeDIsRjx8TdVrQSMTPa3Ww7z7IMwZJvLg/eMDgYxqjFq/FjSprPFh2Hohhii5MQ1fs8JKNI2LepgWnMDyQ9OqFnTcGIlGOkunKwXLgkdDgJRi46YXmzHUgBnTpiOVlc3sHVmYibI=
Received: from PH8PR02CA0054.namprd02.prod.outlook.com (2603:10b6:510:2da::14)
 by BL1PPF1F08FD0FA.namprd19.prod.outlook.com (2603:10b6:20f:fc04::e8a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Tue, 22 Jul
 2025 21:58:05 +0000
Received: from CY4PEPF0000EDD2.namprd03.prod.outlook.com
 (2603:10b6:510:2da:cafe::6) by PH8PR02CA0054.outlook.office365.com
 (2603:10b6:510:2da::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.21 via Frontend Transport; Tue,
 22 Jul 2025 21:58:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 CY4PEPF0000EDD2.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.20
 via Frontend Transport; Tue, 22 Jul 2025 21:58:04 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id CD6EAB2;
	Tue, 22 Jul 2025 21:58:03 +0000 (UTC)
From: Bernd Schubert <bschubert@ddn.com>
Date: Tue, 22 Jul 2025 23:58:02 +0200
Subject: [PATCH 5/5] fuse: {io-uring} Allow reduced number of ring queues
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250722-reduced-nr-ring-queues_3-v1-5-aa8e37ae97e6@ddn.com>
References: <20250722-reduced-nr-ring-queues_3-v1-0-aa8e37ae97e6@ddn.com>
In-Reply-To: <20250722-reduced-nr-ring-queues_3-v1-0-aa8e37ae97e6@ddn.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Joanne Koong <joannelkoong@gmail.com>, linux-fsdevel@vger.kernel.org, 
 Bernd Schubert <bschubert@ddn.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753221478; l=6945;
 i=bschubert@ddn.com; s=20240529; h=from:subject:message-id;
 bh=pzGYnNWuz2rev1DindXgjZBTW+Iw8+mPUZvY0wFFnsI=;
 b=1sFVPttqWHqjP3KS3NAbheCS4Ruaj014S/+FzDAZCpBgcrr3tDpKvxpaI02G3fl6nA7PhynIe
 /v/opHtV4hKCm/Cr5tavcu83twETcOh5VX5XhLLCLPx16Am5OCB91Wm
X-Developer-Key: i=bschubert@ddn.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD2:EE_|BL1PPF1F08FD0FA:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a5f4940-9686-455c-7d78-08ddc96ad5a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024|19092799006;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SG5PcElNeHp5Tm56Mzh5WTZuK2ZveExPZmdBR0FnUUtFdG0vTzBzaEJkUHdS?=
 =?utf-8?B?UjE4cGJaWnhreURMVW5ybklYZmw4K2JXbXlPZkRTaXViNFgxMjJPNSszeHhL?=
 =?utf-8?B?QnYza21tUmFTVGI3WUZ3S2prVVVaR1NrTjB2WVJ4YTd1WTBhbENSTUQxUWNM?=
 =?utf-8?B?K09aRktmMU1BSkwyVGRrcnNRSHM4akw1TVBrWjNqN2dJUlJLd1AwRWN0Z0Ev?=
 =?utf-8?B?YUwyZGV2a0FVNVY1SjlsMGkyaWlRaWU4RTkrUFNPZjVVaURMQldab3IremR5?=
 =?utf-8?B?cmVoOS9IR2lWbGU2RXpiWU92clU4a1dpckxOU0QwYUF3U2dYSlQvYXhDSm92?=
 =?utf-8?B?ek9qVUJGRjZ1N0xQbk1XRHltYmFiWVdmZnVJZFdFRW8wcEFIclJyU1RNMkk0?=
 =?utf-8?B?WjRUc1NObzMwZHNnNUVqMkl1ekFvd1dmU0lpckJ2V1dkQU8rYTYzWHpiaVlT?=
 =?utf-8?B?aTU4ZFhZK3RzRGdBUkdNOVJMdzhlTHhIeGl4NmRHWEdCQTkwVTVTOUJZMyt4?=
 =?utf-8?B?RGV3a2hoWE16bGxKb3crWHoxbG5WVi9jMjZEVnV2ZzJoU0NLVGFaalpQeEMz?=
 =?utf-8?B?T0J0NkI4YTRGcTlBcVVybmxFbmFRcGhxK3ZkaTc2bDErMHpzQWVVbnE0UlpM?=
 =?utf-8?B?SzdOL2RkZzBFKzljM3llU2NJQmxYY1hpMkUwTGlQODJBQ01tc0dhQ3R3WDJw?=
 =?utf-8?B?L2xXc1JpL2lla0ovNnliT3FpM1MvTkhtbExLUnppemRUVWtRdzhSVC91YzZu?=
 =?utf-8?B?dVoydytrMXN6cC91alB1T2N5OXhOam54Z2xtM2t2b0hlTS9sQnh1NEo4N3JT?=
 =?utf-8?B?MkNXRUhQSkxBOFZwYnIrbnNrZEk1SHY0aXdSenNxRmxwR0FhN0VCN0FrM0Vj?=
 =?utf-8?B?UUk0SFRRWCtUT2dLTWowN2NYZDk2YTJhTjlxN0VTRUowWWlvRUx0M2NhOGl5?=
 =?utf-8?B?anJjRzRwVUlhODZyMjY2L3RwYzN3a3ZKMzRReDFpOFZkdy84enN6eGFnQ3g5?=
 =?utf-8?B?bUdqTGFydTN0bTFyZlBLQWVTblRJcXlNK2dONm1BdGh6SEtNWWd3K1hHdHYz?=
 =?utf-8?B?MEd1VmRmV2NJRHBxK281UkNNSE90eVQ5bXBtZWRacXg4ZjRqZUdrd2RwQXp5?=
 =?utf-8?B?eFpBS3RnZXU3ZXB4eTJwYUZnZk8yL293WkZoditxSVpYcGcyaGxscThGZFFo?=
 =?utf-8?B?dmNZSDlENjJLcHhqUDE1cDA3MzlzYVVTVDFjanV1by9uUFhDSDc5b21sZnFw?=
 =?utf-8?B?Sm52ZXF2RVlLTUhwdVdkRUg5dDZKb0xVSzJjLy9LMEpHdFhlWStRQkxuY2JI?=
 =?utf-8?B?YTg5VzRncjVyZkNXYklMMDdvRUpEODFTWWFBS3NEN1VUUCtEU1h5dk1SWlJl?=
 =?utf-8?B?WllyL1dmMk5oa0kxVjRYcEQ0RjZ5Szh5anlKTUVGdkhxYWJ6VmpnQnZPME5S?=
 =?utf-8?B?N2pLV29tZmFkdjJ0MWJQUmhRbnE0NldDNnY2c1hHeFN4WUNxczF5TnI2b2Vp?=
 =?utf-8?B?eVJraGRCak5rM2RCQ0p6VTRxdTJKM29IbTFubTBvUUx6S2J1Q3JEdGNac1Ux?=
 =?utf-8?B?Rll0dEpqQmFFaDgvVkNhOGxlUktWOURNYUNtbU5NSkFkMGNzOHdUUEdpNlo2?=
 =?utf-8?B?TzNxcUNqdG5PcFhqa1pRUUVwakd3elJjZDVpM3ZVOHJKMXNoSU9xQ2s1cVdY?=
 =?utf-8?B?MDFIUVUzem4rZHRWdjFCcVNGd3k5MXFpSHRqLzZsOXM0TjAyQlZETk1vUDZM?=
 =?utf-8?B?U0NUYnMwMjYvZ3l1ZUJzdlh2NHdHWDYwU0RrYU5iemM4bWhuZ3dPWmNHelBk?=
 =?utf-8?B?a1dEeGVRWU0xMmJSOGdVYnJQTFJ5cTNoUk1PSHd1NEwzVWF0MCtoRU40eGZ6?=
 =?utf-8?B?Tmg4c0pKVUF3TzFsVFJVNjRvRDRUSllJR042MXFBTTc5RmZGWHJGYmYxbk51?=
 =?utf-8?B?ZjFVOG1kVUxsK01CblJIODBzWitQSmJFYkJpbTZLdFJ2dnFBNzNSSTdXYVZV?=
 =?utf-8?B?YU9NemxGTW01UW1nYitISGp1aXArdlBrU0dPNkJhdUxIVDZKRlp4Z3lPM3BL?=
 =?utf-8?Q?eclXDO?=
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024)(19092799006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4Dvh34xSwygHRVsqOWTjDHIzl6MboRVfFML2UyPAs3f4BGlK2LRRnxQf3VNvrnOA9RqPZCPIvtJH2D4li2g9S5aP2reQoyKHtQvBrk30QIi1Q075Fph/q/ww34E/FWsFJUXqyGW8e/rv0N4Mb0y8Lnd+1NUXgxkQI5k16GcYw3pn31qoHYCRbB/u+2WTY1Me7Wg2FYNdZDDMExC9InrxFO7GfcDpl9oFGZ+nOEx8IjYgPBQe7L/1yYGFu+NsdAnaRuORCfjrJHDAYooJHiQLnjOdwkf+niWswqcrQ6L1JatbJreiIc/vnz2irrQxx0GMEFjaNsf7glwJtJYAOVPWCBljfBE2d2K4v4a7N70Hwufanm5xaOOr7y+E7l/YFZPki1esU23k46sqZkg3LXj1AbCm6qdnC+1Rc22fIpXoswiYIfEAoX5FyHwnpgJWlwrsZug57E0bKWYi28XmE5rcMb3mTCO+RLzBK+Py1eDKz43RqYV2y0ufPoNICn6jf1tr0s91dzlpWqHxQQbWvQ2YPQYL9eqbnVMo1uXHbMB7HptcMsjEg/jszwSedc/kl6gvt6cy3wnQRUsXqTRNyCxM+egw3am9lK0EZ8dTgILuNwvjXl+/+X4gWZoHSwjjxMwEB/oq51CuP6btcEXOiGGY5w==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 21:58:04.3815
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a5f4940-9686-455c-7d78-08ddc96ad5a1
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PPF1F08FD0FA
X-BESS-ID: 1753221488-111480-7644-12961-1
X-BESS-VER: 2019.1_20250709.1638
X-BESS-Apparent-Source-IP: 40.107.220.133
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVmbmhmZAVgZQ0CLNzDLN2MLM3N
	gkMdXSwsTCxNjI3NAwKTHNJAnIs1SqjQUAjtNdDEEAAAA=
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.266236 [from 
	cloudscan14-206.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

Currently, FUSE io-uring requires all queues to be registered before
becoming ready, which can result in too much memory usage.

This patch introduces a static queue mapping system that allows FUSE
io-uring to operate with a reduced number of registered queues by:

1. Adding a queue_mapping array to track which registered queue each
   CPU should use
2. Replacing the is_ring_ready() check with immediate queue mapping
   once any queues are registered
3. Implementing fuse_uring_map_queues() to create CPU-to-queue mappings
   that prefer NUMA-local queues when available
4. Updating fuse_uring_get_queue() to use the static mapping instead
   of direct CPU-to-queue correspondence

The mapping prioritizes NUMA locality by first attempting to map CPUs
to queues on the same NUMA node, falling back to any available
registered queue if no local queue exists.

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
 fs/fuse/dev_uring.c   | 112 ++++++++++++++++++++++++++++++--------------------
 fs/fuse/dev_uring_i.h |   3 ++
 2 files changed, 71 insertions(+), 44 deletions(-)

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index 624f856388e0867f3c3caed6771e61babd076645..8d16880cb0eb9b252dd6b6cf565011c3787ad1d0 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -238,6 +238,7 @@ void fuse_uring_destruct(struct fuse_conn *fc)
 
 	fuse_ring_destruct_q_masks(ring);
 	kfree(ring->queues);
+	kfree(ring->queue_mapping);
 	kfree(ring);
 	fc->ring = NULL;
 }
@@ -303,6 +304,12 @@ static struct fuse_ring *fuse_uring_create(struct fuse_conn *fc)
 	if (err)
 		goto out_err;
 
+	err = -ENOMEM;
+	ring->queue_mapping =
+		kcalloc(nr_queues, sizeof(int), GFP_KERNEL_ACCOUNT);
+	if (!ring->queue_mapping)
+		goto out_err;
+
 	spin_lock(&fc->lock);
 	if (fc->ring) {
 		/* race, another thread created the ring in the meantime */
@@ -324,6 +331,7 @@ static struct fuse_ring *fuse_uring_create(struct fuse_conn *fc)
 out_err:
 	fuse_ring_destruct_q_masks(ring);
 	kfree(ring->queues);
+	kfree(ring->queue_mapping);
 	kfree(ring);
 	return res;
 }
@@ -1040,31 +1048,6 @@ static int fuse_uring_commit_fetch(struct io_uring_cmd *cmd, int issue_flags,
 	return 0;
 }
 
-static bool is_ring_ready(struct fuse_ring *ring, int current_qid)
-{
-	int qid;
-	struct fuse_ring_queue *queue;
-	bool ready = true;
-
-	for (qid = 0; qid < ring->max_nr_queues && ready; qid++) {
-		if (current_qid == qid)
-			continue;
-
-		queue = ring->queues[qid];
-		if (!queue) {
-			ready = false;
-			break;
-		}
-
-		spin_lock(&queue->lock);
-		if (list_empty(&queue->ent_avail_queue))
-			ready = false;
-		spin_unlock(&queue->lock);
-	}
-
-	return ready;
-}
-
 static int fuse_uring_map_qid(int qid, const struct cpumask *mask)
 {
 	int nr_queues = cpumask_weight(mask);
@@ -1082,6 +1065,41 @@ static int fuse_uring_map_qid(int qid, const struct cpumask *mask)
 	return -1;
 }
 
+static int fuse_uring_map_queues(struct fuse_ring *ring)
+{
+	int qid, mapped_qid, node;
+
+	for (qid = 0; qid < ring->max_nr_queues; qid++) {
+		node = cpu_to_node(qid);
+		if (WARN_ON_ONCE(node >= ring->nr_numa_nodes) || node < 0)
+			return -EINVAL;
+
+		/* First try to find a registered queue on the same NUMA node */
+		mapped_qid = fuse_uring_map_qid(
+			qid, ring->numa_registered_q_mask[node]);
+		if (mapped_qid < 0) {
+			/*
+			 * No registered queue on this NUMA node,
+			 * use any registered queue
+			 */
+			mapped_qid = fuse_uring_map_qid(
+				qid, ring->registered_q_mask);
+			if (WARN_ON_ONCE(mapped_qid < 0))
+				return -EINVAL;
+		}
+
+		if (WARN_ON_ONCE(!ring->queues[mapped_qid])) {
+			pr_err("qid=%d mapped_qid=%d not created\n", qid,
+			       mapped_qid);
+			return -EINVAL;
+		}
+
+		WRITE_ONCE(ring->queue_mapping[qid], mapped_qid);
+	}
+
+	return 0;
+}
+
 /*
  * fuse_uring_req_fetch command handling
  */
@@ -1094,6 +1112,7 @@ static void fuse_uring_do_register(struct fuse_ring_ent *ent,
 	struct fuse_conn *fc = ring->fc;
 	struct fuse_iqueue *fiq = &fc->iq;
 	int node = queue->numa_node;
+	int err;
 
 	fuse_uring_prepare_cancel(cmd, issue_flags, ent);
 
@@ -1105,14 +1124,14 @@ static void fuse_uring_do_register(struct fuse_ring_ent *ent,
 	cpumask_set_cpu(queue->qid, ring->registered_q_mask);
 	cpumask_set_cpu(queue->qid, ring->numa_registered_q_mask[node]);
 
-	if (!ring->ready) {
-		bool ready = is_ring_ready(ring, queue->qid);
+	err = fuse_uring_map_queues(ring);
+	if (err)
+		return;
 
-		if (ready) {
-			WRITE_ONCE(fiq->ops, &fuse_io_uring_ops);
-			WRITE_ONCE(ring->ready, true);
-			wake_up_all(&fc->blocked_waitq);
-		}
+	if (!ring->ready) {
+		WRITE_ONCE(fiq->ops, &fuse_io_uring_ops);
+		WRITE_ONCE(ring->ready, true);
+		wake_up_all(&fc->blocked_waitq);
 	}
 }
 
@@ -1365,25 +1384,27 @@ fuse_uring_get_first_queue(struct fuse_ring *ring, const struct cpumask *mask)
  */
 static struct fuse_ring_queue *fuse_uring_get_queue(struct fuse_ring *ring)
 {
-	unsigned int qid;
-	struct fuse_ring_queue *queue, *local_queue;
+	unsigned int mapped_qid;
+	struct fuse_ring_queue *queue;
 	int local_node;
 	struct cpumask *mask;
+	unsigned int core = task_cpu(current);
 
-	qid = task_cpu(current);
-	if (WARN_ONCE(qid >= ring->max_nr_queues,
-		      "Core number (%u) exceeds nr queues (%zu)\n", qid,
-		      ring->max_nr_queues))
-		qid = 0;
-	local_node = cpu_to_node(qid);
+	local_node = cpu_to_node(core);
+	if (WARN_ON_ONCE(local_node >= ring->nr_numa_nodes) || local_node < 0)
+		local_node = 0;
 
-	local_queue = queue = ring->queues[qid];
-	if (WARN_ONCE(!queue, "Missing queue for qid %d\n", qid))
-		return NULL;
+	if (WARN_ON_ONCE(core >= ring->max_nr_queues))
+		core = 0;
 
+	mapped_qid = READ_ONCE(ring->queue_mapping[core]);
+	queue = ring->queues[mapped_qid];
+
+	/* First check if current CPU's queue is available */
 	if (queue->nr_reqs <= FUSE_URING_QUEUE_THRESHOLD)
 		return queue;
 
+	/* Second check if there are any available queues on the local node */
 	mask = ring->per_numa_avail_q_mask[local_node];
 	queue = fuse_uring_get_first_queue(ring, mask);
 	if (queue)
@@ -1394,7 +1415,10 @@ static struct fuse_ring_queue *fuse_uring_get_queue(struct fuse_ring *ring)
 	if (queue)
 		return queue;
 
-	return local_queue;
+	/* no better queue available, use the mapped queue */
+	queue = ring->queues[mapped_qid];
+
+	return queue;
 }
 
 static void fuse_uring_dispatch_ent(struct fuse_ring_ent *ent)
diff --git a/fs/fuse/dev_uring_i.h b/fs/fuse/dev_uring_i.h
index 0457dbc6737c8876dd7a7d4c9c724da05e553e6a..e72b83471cbfc2e911273966f3715305ca10e9ef 100644
--- a/fs/fuse/dev_uring_i.h
+++ b/fs/fuse/dev_uring_i.h
@@ -153,6 +153,9 @@ struct fuse_ring {
 
 	atomic_t queue_refs;
 
+	/* static queue mapping */
+	int *queue_mapping;
+
 	bool ready;
 };
 

-- 
2.43.0


