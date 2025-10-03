Return-Path: <linux-fsdevel+bounces-63355-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A884DBB678D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 03 Oct 2025 12:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7134E3C3FC0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Oct 2025 10:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5312EB843;
	Fri,  3 Oct 2025 10:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="GbMNVP++"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip168b.ess.barracuda.com (outbound-ip168b.ess.barracuda.com [209.222.82.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B5A2EB5C0
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Oct 2025 10:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759488008; cv=fail; b=OJuLRgxe4TdwGJE2Z/M9LDhKiFQPvEzLLzUG3pnkBGJMYs/1ODUnkVSiyuyEviEEy7rAV2I1SH2ZJdniNbth47KYPgjxyDU2N5FiaBrkvreeLaxcr8JzlubJo1tBf6RXNbcQXBqNbfD8DAI0/NssA/kXYBjZDDWP9hglDvfW9Lo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759488008; c=relaxed/simple;
	bh=VKlBrWdMegl2evlXi4dvgH5H7IhXb2RoTOO0Hblua84=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=onSHbDVxSNdOOuSL/SAMvgXTulXPlsdBV0IVRXtiDL4lU2FydpaHcV3q14h7tcib1rLJVNSBByPEHNsyw6Ny3BNhTEfdq9ooY/dGIRXJ4dTsJBjZAodZxO4+0D9V0lFK9lnS9igp/+BOgEnYth8iH1z8tWFv3VddM1mSLAQ4lbU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=GbMNVP++; arc=fail smtp.client-ip=209.222.82.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11022140.outbound.protection.outlook.com [40.107.209.140]) by mx-outbound-ea18-75.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Fri, 03 Oct 2025 10:40:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oFMcw6aLAXFBcV06ywJvI6REU7xDX6fLlLIejDBXmiJdVDLXg2bGxz9IaktBYMGfQ0yngO3w3R3Aedz1giJ+eON75XLp/2jJa2DjknxHfFhMkxPWXHEIrDj+bm//gncF2Ke3dq+CHpI2ijHNSzPgXoIxn45t7ePxsEWiHA/slNdGx4BmLOWNUbLRf44q5oChHWqlN1zFQXnErdt3zoGN7wLSygkFtMDOLLjldCyVAL27w0U+SgiqBco+uVpuZ23GTnzjcIIezrE2N8IXlp/NsgBLcVBGpNP0l7WRR2Xzux8QoqEAWNZbKa8WF6pgBqL/bF7D1R77tKkb3zpqI2G7pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g2Fkh4M3BOBZN8c1MBfofL1WNA5dYAhQcUIN9EAKoXk=;
 b=jlJSCG8kLVfRxhx0OK0MyADnQ5PWl+/Ab+UNlSU61In1xqC0CDG4bm2VuJXLy0PPp7arl2cBBiGqaozU26Jd86Qz4PQIiu3Euw8zuZ1gTZwFe1XG0J9NXabLUwk2trzORlu/K5l2i3FWV5jT271RdaGf2sqpVVpioX+sU1U1NvI4XhiwvzKLkyQJemO7+WYLphp2pVq+8YOMqyhXk8pHJfxv2CmOCyDaQZn2idXWP/0MZi5DL0uqVHlYx1aH7aatsiQr6uLTapHzwk4AcBsCUp63cxaE6Ya2czCRReXIv3vn9tUufjjMlIQ2Ui7UjgOxxESHPdkoStiXnsxwWHNV/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=arm.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g2Fkh4M3BOBZN8c1MBfofL1WNA5dYAhQcUIN9EAKoXk=;
 b=GbMNVP++KVyCbeCyF5WnAkxp7moQ8MyyPEzobqr61GMbib73deDf8Nh286NVK4lpvrTbaFPZkYq/d2Y3ij56zUNaNVCi1knIRI+OM0pWVsrbvHvrfdHZFjPT168X1h8qN9cezbfF/34PfxULT9w8fJZM7CdyWlepTw8NqjyVNj4=
Received: from BYAPR01CA0054.prod.exchangelabs.com (2603:10b6:a03:94::31) by
 DS4PR19MB9052.namprd19.prod.outlook.com (2603:10b6:8:2aa::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.19; Fri, 3 Oct 2025 10:06:50 +0000
Received: from SJ5PEPF000001CB.namprd05.prod.outlook.com
 (2603:10b6:a03:94:cafe::a4) by BYAPR01CA0054.outlook.office365.com
 (2603:10b6:a03:94::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.16 via Frontend Transport; Fri,
 3 Oct 2025 10:06:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 SJ5PEPF000001CB.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.15
 via Frontend Transport; Fri, 3 Oct 2025 10:06:49 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id A784E63;
	Fri,  3 Oct 2025 10:06:48 +0000 (UTC)
From: Bernd Schubert <bschubert@ddn.com>
Date: Fri, 03 Oct 2025 12:06:47 +0200
Subject: [PATCH v2 6/7] fuse: {io-uring} Queue background requests on a
 different core
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251003-reduced-nr-ring-queues_3-v2-6-742ff1a8fc58@ddn.com>
References: <20251003-reduced-nr-ring-queues_3-v2-0-742ff1a8fc58@ddn.com>
In-Reply-To: <20251003-reduced-nr-ring-queues_3-v2-0-742ff1a8fc58@ddn.com>
To: Miklos Szeredi <miklos@szeredi.hu>, Ingo Molnar <mingo@redhat.com>, 
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>
Cc: Joanne Koong <joannelkoong@gmail.com>, linux-fsdevel@vger.kernel.org, 
 Bernd Schubert <bschubert@ddn.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759486002; l=7889;
 i=bschubert@ddn.com; s=20240529; h=from:subject:message-id;
 bh=VKlBrWdMegl2evlXi4dvgH5H7IhXb2RoTOO0Hblua84=;
 b=Fb8YkUsviGf8+3SFKNAAVwgteDr3DNBm4UcgwFducy7EY/DzpYC2Jg/zeywc3knOAGLmK2/fr
 Q2JQgXG6Xk0B9T1PuV3jFh+tAGVgrTWk5hzpvY7dAT1HMMTs3gvavxz
X-Developer-Key: i=bschubert@ddn.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CB:EE_|DS4PR19MB9052:EE_
X-MS-Office365-Filtering-Correlation-Id: 824d08e8-0f15-471e-11e7-08de026491a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|376014|7416014|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NVA0c0F5VTFOMFcwY3BIWG9RcjVKaTRlR0RHMG5QUkh5WXhJWml4VkduQzNL?=
 =?utf-8?B?UzNJQWpDK0FMQmhTTms5TnBHZWs0dHVuY0JLVUY5bmtZOWM3aTFuRUxDRHVW?=
 =?utf-8?B?SnBJSkxBWHllaEZMd0NZU0hKcmtxcU0xeXAyRDFuL2lDNmNLdWlwcVJGSU1t?=
 =?utf-8?B?WVVSeEx3a0JDN1NHRTBGcVVVWWlXR3NwWUJ0anF6MzFRcmlqOVdQd1FHWm9T?=
 =?utf-8?B?WGdPTUphdGpYNGp5RlpIcGYvQ3hMSnQ2QUlwR2FzMHhoRWx3QWszZlVuN0Rp?=
 =?utf-8?B?OWFTS0FTcFAweS9GVnlEUHJVRGhhNkE3OVExMSt3VWl2bXU1TEJPTlRBSVBD?=
 =?utf-8?B?dEdlbGZZK2QxZVZ2RS9Ya2owMTlYb2xqU0ltWStFWDhRNEdXQjd0alYrWkJj?=
 =?utf-8?B?WUlCYU9vTEdxUzBoUUx2OS9acFhyL3hsWjVzbnprQXhBT0NTRE9wUUFRNm5M?=
 =?utf-8?B?djJXdFRkS3hFcFF3anBacW1uaW9pV3ZPYS9aVlJKSEQvclpLUE1SeGt6TDFu?=
 =?utf-8?B?Rm11Qnc3Titld1dGV2xmZll5QzVaZU13MEZsZXNwM2ZJT3dCcWRYclNUcGF3?=
 =?utf-8?B?N2owT1pMbktVcng5aXRRdW9ZNUVpc0JDRXo5YnZpT0p0clZ0U0JFb1FlTklk?=
 =?utf-8?B?cVBuVUpWbFBHS0xDRnRrb3lxaWREZzJ1NnRFcVNYVUdta2Frdit4SkhtQVFQ?=
 =?utf-8?B?OFdzeHVQald1UkU1eVk5WURJTVkyTGVWYzFSb0xFdDlkbmlKMncxU2JUaUV2?=
 =?utf-8?B?SHQ4a0NGVXJCNnNsdWJhUjdrbit6VWJ5NjhINGZaa3FEdWVVSlAxZ2taUHNa?=
 =?utf-8?B?TGZacytEVklaUUh5WThzRmw2OWdKQ2dEdlFjQ2ZaUFI0ZHpFQ2dabUllVmd5?=
 =?utf-8?B?dE5CNkdRKzZ5R25EQWNlQ3ZYQUtMV1lhTjdSSjgzMjFUUDZJTUFFVmRSY3hl?=
 =?utf-8?B?T0tuK3AvTEd2Q2pVWTZISEhHRWNzalM2aG5COFBROEJhaUl6dXA1Smw1NE1Z?=
 =?utf-8?B?S0tSTDZLN1hFOU1SZ3Rtb2NlWnlzQmY1L1U0TUlZSGgra01QaTRRNDU5TmFQ?=
 =?utf-8?B?Smg4eE9lYVJTR3JiTkFqelVQQ2lWVHZXbmY5RkUrWW5BYStIbnhSTHVGVkJO?=
 =?utf-8?B?ZENWSG52c0hyVHVHd01CMUlyK3hlNnRDT29iSjZ6bWI0VjdjSjZJcWI2Ti9w?=
 =?utf-8?B?VGtMRnFyZTNXazcxalJTb29NRHB5QmRFRjlIL3hqbExZa2dMRnRwc2hteFJF?=
 =?utf-8?B?dktyVEF4R0lWVVlQdnlpRVNtZkcxOU1XRE9rbS9ZRHcwNzNOcUt2QkxLNGJj?=
 =?utf-8?B?R3J1MTNqaXlNdDZ1bnZIZHV3cFFONWFxRkVucXpYeUFMeDA4RXczWlRzNDlo?=
 =?utf-8?B?N1hkQ3Zrd1RET0lNaklRNDB6UTN6WnA4ZThHWTFMRDRHUFFuVkNvcnljOW1I?=
 =?utf-8?B?WERxQUl1VEwrVFg4OGtYUUp2YUx6bzdZc0dRZDMyR3l2WnlrZTFYK1lPcGg3?=
 =?utf-8?B?K0hyN1ZCckg0YWcxSTJCWlo3dWE2MkRjQkUyNDB1YzZoUWdQMUdZUXp0RFBs?=
 =?utf-8?B?ZGtIV04yQVVkdlhwNmFjUTBBVzBIZXFrTFpBN1d0T0xEczFubU4zL3pQbHNT?=
 =?utf-8?B?d2l4NVhjcWxBQkpqSFZrS3g5VUNxN01HY1I1RUZBeVpMamN4bVY1QTlVb09v?=
 =?utf-8?B?Y054a0N0S1lBTXZFeGNpeGVtZ2tidlZaNnpDSVUyb1lsUE9PR3JaSG1VUm5k?=
 =?utf-8?B?TmFlMk4zSXFWbHVhdEc2dWdYU25tWjZCWHU0SlZWUDRUUS9uWTNtR1J1Mm5h?=
 =?utf-8?B?dmRyMDQrcjdiRFlKTnE3VUNEY1F5RnVtbkxVVURYTFZIWi9VRDFxLzFoQ01j?=
 =?utf-8?B?SjhmUWYxSEthbHlhL3hXc0JiR2toQVZPQVRtd1F5QjlxV0FFTHExWVNLWEpY?=
 =?utf-8?B?aWJXREV5VzRqSnJhWThtZ255YkJIM2lqViswUGc4VHdIZHdDcXpwNFdrYVlx?=
 =?utf-8?B?Z0taL1c2eVhqUjZaY0FVcGN1SzVRczQ2a0srb3doYlZoNkRGc25UTER3bzgr?=
 =?utf-8?B?Yi9aNGdqcHhrRm0zU2lmdndhalF1eGpRVUsxNWJieXFLeGNQV0Ftc0FzZG1w?=
 =?utf-8?Q?FzzR//C/qiQwcxXNpt6/ulKte?=
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(376014)(7416014)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kdFCGNpt3mooh11oJBcgGJ5a/cDIwxpcP0f871QJdVuB0MiYDg70W1E46jpavI/w2eThNTpFakk7hisALBeNtvBtUy1Kj7PPoGrQo308hHFXohccR+QD6HzWvDE32wcCV8ba1h2GVOFn76ydrLJnjnj/BG0b9jikfbfiB50vYSTEk/WTy3x35rlCHlRZlAMP4jCCXJKnOYQetV8IKUOrI9TkRXqF2+rLhtqpPWAZQ8Nb2zDbVTIDByhEnzHbnls3HFyY/S5E/a92e0TucChXTcF4nZf7hJeweYiy5+xo1raiFovlmlA24uR1eZVqbioI2UEfEqYDwzCjDw+O/kXFnEGx9jdlwAFGb39nCKXA4Vut6MIF6r+dYvvkPqs0r0wOW11PjJGl61U8lX8dhZCY+mebdmrz6DVulYLk3F15i3SInyJNRcI3wQljFmTA1rK2707k6p1Sb4eZrfRpA+mJy1caqxKM5Y4pqoV9PuEndr8DnmSrS7iUiXfTH+0H7lHvFbL5IRn4E4CZyu3vV9p9ssbLc8HbloxkL/diDa3xwHd0LTkQR2LU0ypUqOGqIEoCwDChh2v8Ol1RjsPbm1jyKSES302H7/1L1I9OCL/UT+NSJ7diijoX2+JQv7izkz07+0+RU9ci0rrhnlyoqzKcMQ==
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2025 10:06:49.5712
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 824d08e8-0f15-471e-11e7-08de026491a5
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR19MB9052
X-OriginatorOrg: ddn.com
X-BESS-ID: 1759488001-104683-5914-3932-1
X-BESS-VER: 2019.3_20251001.1824
X-BESS-Apparent-Source-IP: 40.107.209.140
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVuZmZkZAVgZQ0NzUNMXCLM3ULM
	3c1CzZ0tjU0CDRNMXE1CzVMjXNzChRqTYWAI64DAJBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.267935 [from 
	cloudscan13-67.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

Running background IO on a different core makes quite a difference.

fio --directory=/tmp/dest --name=iops.\$jobnum --rw=randread \
--bs=4k --size=1G --numjobs=1 --iodepth=4 --time_based\
--runtime=30s --group_reporting --ioengine=io_uring\
 --direct=1

unpatched
   READ: bw=272MiB/s (285MB/s), 272MiB/s-272MiB/s ...
patched
   READ: bw=760MiB/s (797MB/s), 760MiB/s-760MiB/s ...

With --iodepth=8

unpatched
   READ: bw=466MiB/s (489MB/s), 466MiB/s-466MiB/s ...
patched
   READ: bw=966MiB/s (1013MB/s), 966MiB/s-966MiB/s ...
2nd run:
   READ: bw=1014MiB/s (1064MB/s), 1014MiB/s-1014MiB/s ...

Without io-uring (--iodepth=8)
   READ: bw=729MiB/s (764MB/s), 729MiB/s-729MiB/s ...

Without fuse (--iodepth=8)
   READ: bw=2199MiB/s (2306MB/s), 2199MiB/s-2199MiB/s ...

(Test were done with
<libfuse>/example/passthrough_hp -o allow_other --nopassthrough  \
[-o io_uring] /tmp/source /tmp/dest
)

Additional notes:

With FURING_NEXT_QUEUE_RETRIES=0 (--iodepth=8)
   READ: bw=903MiB/s (946MB/s), 903MiB/s-903MiB/s ...

With just a random qid (--iodepth=8)
   READ: bw=429MiB/s (450MB/s), 429MiB/s-429MiB/s ...

With --iodepth=1
unpatched
   READ: bw=195MiB/s (204MB/s), 195MiB/s-195MiB/s ...
patched
   READ: bw=232MiB/s (243MB/s), 232MiB/s-232MiB/s ...

With --iodepth=1 --numjobs=2
unpatched
   READ: bw=966MiB/s (1013MB/s), 966MiB/s-966MiB/s ...
patched
   READ: bw=1821MiB/s (1909MB/s), 1821MiB/s-1821MiB/s ...

With --iodepth=1 --numjobs=8
unpatched
   READ: bw=1138MiB/s (1193MB/s), 1138MiB/s-1138MiB/s ...
patched
   READ: bw=1650MiB/s (1730MB/s), 1650MiB/s-1650MiB/s ...
fuse without io-uring
   READ: bw=1314MiB/s (1378MB/s), 1314MiB/s-1314MiB/s ...
no-fuse
   READ: bw=2566MiB/s (2690MB/s), 2566MiB/s-2566MiB/s ...

In summary, for async requests the core doing application IO is busy
sending requests and processing IOs should be done on a different core.
Spreading the load on random cores is also not desirable, as the core
might be frequency scaled down and/or in C1 sleep states. Not shown here,
but differnces are much smaller when the system uses performance govenor
instead of schedutil (ubuntu default). Obviously at the cost of higher
system power consumption for performance govenor - not desirable either.

Results without io-uring (which uses fixed libfuse threads per queue)
heavily depend on the current number of active threads. Libfuse uses
default of max 10 threads, but actual nr max threads is a parameter.
Also, no-fuse-io-uring results heavily depend on, if there was already
running another workload before, as libfuse starts these threads
dynamically - i.e. the more threads are active, the worse the
performance.

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
 fs/fuse/dev_uring.c | 61 +++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 50 insertions(+), 11 deletions(-)

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index f5946bb1bbea930522921d49c04e047c70d21ee2..296592fe3651926ab4982b8d80694b3dac8bbffa 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -22,6 +22,7 @@ MODULE_PARM_DESC(enable_uring,
 #define FURING_Q_LOCAL_THRESHOLD 2
 #define FURING_Q_NUMA_THRESHOLD (FURING_Q_LOCAL_THRESHOLD + 1)
 #define FURING_Q_GLOBAL_THRESHOLD (FURING_Q_LOCAL_THRESHOLD * 2)
+#define FURING_NEXT_QUEUE_RETRIES 2
 
 bool fuse_uring_enabled(void)
 {
@@ -1262,7 +1263,8 @@ static void fuse_uring_send_in_task(struct io_uring_cmd *cmd,
  *  (Michael David Mitzenmacher, 1991)
  */
 static struct fuse_ring_queue *fuse_uring_best_queue(const struct cpumask *mask,
-						     struct fuse_ring *ring)
+						     struct fuse_ring *ring,
+						     bool background)
 {
 	unsigned int qid1, qid2;
 	struct fuse_ring_queue *queue1, *queue2;
@@ -1277,9 +1279,14 @@ static struct fuse_ring_queue *fuse_uring_best_queue(const struct cpumask *mask,
 	}
 
 	/* Get two different queues using optimized bounded random */
-	qid1 = cpumask_nth(get_random_u32_below(weight), mask);
+
+	do {
+		qid1 = cpumask_nth(get_random_u32_below(weight), mask);
+	} while (background && qid1 == task_cpu(current));
 	queue1 = READ_ONCE(ring->queues[qid1]);
 
+	return queue1;
+
 	do {
 		qid2 = cpumask_nth(get_random_u32_below(weight), mask);
 	} while (qid2 == qid1);
@@ -1298,12 +1305,14 @@ static struct fuse_ring_queue *fuse_uring_best_queue(const struct cpumask *mask,
 /*
  * Get the best queue for the current CPU
  */
-static struct fuse_ring_queue *fuse_uring_get_queue(struct fuse_ring *ring)
+static struct fuse_ring_queue *fuse_uring_get_queue(struct fuse_ring *ring,
+						    bool background)
 {
 	unsigned int qid;
 	struct fuse_ring_queue *local_queue, *best_numa, *best_global;
 	int local_node;
 	const struct cpumask *numa_mask, *global_mask;
+	int retries = 0;
 
 	qid = task_cpu(current);
 	if (WARN_ONCE(qid >= ring->max_nr_queues,
@@ -1311,16 +1320,44 @@ static struct fuse_ring_queue *fuse_uring_get_queue(struct fuse_ring *ring)
 		      ring->max_nr_queues))
 		qid = 0;
 
-	local_queue = READ_ONCE(ring->queues[qid]);
 	local_node = cpu_to_node(qid);
 
-	/* Fast path: if local queue exists and is not overloaded, use it */
-	if (local_queue && local_queue->nr_reqs <= FURING_Q_LOCAL_THRESHOLD)
+	local_queue = READ_ONCE(ring->queues[qid]);
+
+retry:
+	/*
+	 * For background requests, try next CPU in same NUMA domain.
+	 * I.e. cpu-0 creates async requests, cpu-1 io processes.
+	 * Similar for foreground requests, when the local queue does not
+	 * exist - still better to always wake the same cpu id.
+	 */
+	if (background || !local_queue) {
+		numa_mask = ring->numa_registered_q_mask[local_node];
+		int weight = cpumask_weight(numa_mask);
+
+		if (weight > 0) {
+			int idx = (qid + 1) % weight;
+
+			qid = cpumask_nth(idx, numa_mask);
+		} else {
+			qid = cpumask_first(numa_mask);
+		}
+
+		local_queue = READ_ONCE(ring->queues[qid]);
+	}
+
+	if (local_queue && local_queue->nr_reqs <= FURING_Q_NUMA_THRESHOLD)
 		return local_queue;
 
+	if (retries < FURING_NEXT_QUEUE_RETRIES) {
+		retries++;
+		local_queue = NULL;
+		goto retry;
+	}
+
 	/* Find best NUMA-local queue */
 	numa_mask = ring->numa_registered_q_mask[local_node];
-	best_numa = fuse_uring_best_queue(numa_mask, ring);
+	best_numa = fuse_uring_best_queue(numa_mask, ring, background);
 
 	/* If NUMA queue is under threshold, use it */
 	if (best_numa && best_numa->nr_reqs <= FURING_Q_NUMA_THRESHOLD)
@@ -1328,7 +1365,7 @@ static struct fuse_ring_queue *fuse_uring_get_queue(struct fuse_ring *ring)
 
 	/* NUMA queues above threshold, try global queues */
 	global_mask = ring->registered_q_mask;
-	best_global = fuse_uring_best_queue(global_mask, ring);
+	best_global = fuse_uring_best_queue(global_mask, ring, background);
 
 	/* Might happen during tear down */
 	if (!best_global)
@@ -1338,8 +1375,10 @@ static struct fuse_ring_queue *fuse_uring_get_queue(struct fuse_ring *ring)
 	if (best_global->nr_reqs <= FURING_Q_GLOBAL_THRESHOLD)
 		return best_global;
 
+	return best_global;
+
 	/* Fall back to best available queue */
-	return best_numa ? best_numa : best_global;
+	// return best_numa ? best_numa : best_global;
 }
 
 static void fuse_uring_dispatch_ent(struct fuse_ring_ent *ent)
@@ -1360,7 +1399,7 @@ void fuse_uring_queue_fuse_req(struct fuse_iqueue *fiq, struct fuse_req *req)
 	int err;
 
 	err = -EINVAL;
-	queue = fuse_uring_get_queue(ring);
+	queue = fuse_uring_get_queue(ring, false);
 	if (!queue)
 		goto err;
 
@@ -1405,7 +1444,7 @@ bool fuse_uring_queue_bq_req(struct fuse_req *req)
 	struct fuse_ring_queue *queue;
 	struct fuse_ring_ent *ent = NULL;
 
-	queue = fuse_uring_get_queue(ring);
+	queue = fuse_uring_get_queue(ring, true);
 	if (!queue)
 		return false;
 

-- 
2.43.0


