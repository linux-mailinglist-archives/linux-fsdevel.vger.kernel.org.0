Return-Path: <linux-fsdevel+bounces-65223-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8063BFE66D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 00:21:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36E931A04E1E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 22:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2528E306B20;
	Wed, 22 Oct 2025 22:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="AGO0WiH2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip191b.ess.barracuda.com (outbound-ip191b.ess.barracuda.com [209.222.82.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11EF304964
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Oct 2025 22:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761171704; cv=fail; b=S2x5j9ZgoI8wLbyHjDydvOkl7l7DFBoKUyndjRm+5NR/rXZK7cdXLszvjTPsemmTtzZmUc1oIa8MfJ3kXsF+kWrSA+LlhU9DwvrKEo/g+2iGr0jfrKTcWcMnTHvB+xPOUdNRDWvRYfsFmFNOKE7/ostgBp5QMYF4x81mNorWxnQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761171704; c=relaxed/simple;
	bh=Zc3bLdcUGHvYcz/DOiuQ+1uSfy8hvCs3GYpzmiRfjwk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vrpe00lTO034RFVuz4ENGVAiX4dNjHL97fIRrwq/XR8xxvi/6NFyl3KwI6tg4Trt+vUAIWO2eWWeDfXKSTsOQoDV9QhSZZw4roQEMVmo3LVmlCcZ3hLs9NbR91S156kaTTZzcoNH56pt9P/nfJX4JQ/WhbzlFN/8mqTkIJIgnl8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=AGO0WiH2; arc=fail smtp.client-ip=209.222.82.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11021110.outbound.protection.outlook.com [40.93.194.110]) by mx-outbound20-158.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 22 Oct 2025 22:21:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HoJ9W2k9UJxabORm49FS+TF4RmcY7lc0Nrum3noss5AD0wXuLMeopkU2Ur03G1j06oQ8XQrYPHaKOkKwrY1+ePlwfVt3ygk/zbk9PgCV5amUBdmtWBAakc261sN4X7OafQBQT/EQK0cOjgULdX2yhFo+NosEnlmhCqV7kH3d5XkdzAANwL+Z4UjXo5/6HDvcfzXnlGHUgkE3yNb62l1ZwMtiqNcpXzw6QuX1d7wN1xMgUk6U43n49+VM/AsvpYDaJRCnoDtHIklndKSwiD3jIU1IpaB7ITMxLHpDJ9lP6UD+E6ltmbbU3a50so3eooAUU8pOKjw4Z/K2IaqQzEdt0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UwMAScXV16BgMLaVF3g93UjFjNoYkw/b+8lGI8SgcXY=;
 b=Z0Su2mR21I3TCOYSaBcrOMs2swxiND8jVH8izRxP21cqfVz5vQx0YO87+JWOwdZ4fXfk1pUls56C0HTR3WXOC4ZVuR5uWiEzm0Py7bEKYjXCpUxmAmfUr3nGup3qniabTF9qVEFRt4/6/4W7HjWMhKMxrkeWYn1YBSM8uwqu6MrgYB/5q/HC7zG1Jo8DAIA4d4Zw9Xw6JHWtiaoBsYwQRPpPWIGxVXMn21hUOd6swohikhHR1xqeYvY7CoREd9l2kYrW+BkogjkJ7B2flx7UciPqUVK8paY4zOx2DiT0MolPptGJrFEqVKtF7IPTsScz8LQIo+OkMS5rlBUuZW5Gew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=bytedance.com smtp.mailfrom=ddn.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ddn.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UwMAScXV16BgMLaVF3g93UjFjNoYkw/b+8lGI8SgcXY=;
 b=AGO0WiH2csV4wTjGmNjpjdq/a9UrRwm/NYvWZvLTEPKJxXNOPfFyle5fcEdPDs4vs++n6YfRvEetyEUwkRXW01ufRM2fxaWr2RdOYoWVwqEYLK/5MaAx+IDkIbSy1GgtvVq8RySzrLxRlP/n6Jqq1BkfM+cuadWgkNA1FLOXmEk=
Received: from SJ0PR13CA0036.namprd13.prod.outlook.com (2603:10b6:a03:2c2::11)
 by CY8PR19MB6940.namprd19.prod.outlook.com (2603:10b6:930:5f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Wed, 22 Oct
 2025 22:21:23 +0000
Received: from MWH0EPF000971E9.namprd02.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::a5) by SJ0PR13CA0036.outlook.office365.com
 (2603:10b6:a03:2c2::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.11 via Frontend Transport; Wed,
 22 Oct 2025 22:21:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 MWH0EPF000971E9.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.7
 via Frontend Transport; Wed, 22 Oct 2025 22:21:22 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id BB51F4C;
	Wed, 22 Oct 2025 22:21:21 +0000 (UTC)
From: Bernd Schubert <bschubert@ddn.com>
Date: Thu, 23 Oct 2025 00:21:18 +0200
Subject: [PATCH 2/2] fuse: Always flush the page cache before
 FOPEN_DIRECT_IO write
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251023-fix-fopen-direct-io-post-invalidation-v1-2-3f93a411cd00@ddn.com>
References: <20251023-fix-fopen-direct-io-post-invalidation-v1-0-3f93a411cd00@ddn.com>
In-Reply-To: <20251023-fix-fopen-direct-io-post-invalidation-v1-0-3f93a411cd00@ddn.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, Hao Xu <howeyxu@tencent.com>, 
 Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>, 
 Bernd Schubert <bschubert@ddn.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761171679; l=840;
 i=bschubert@ddn.com; s=20240529; h=from:subject:message-id;
 bh=Zc3bLdcUGHvYcz/DOiuQ+1uSfy8hvCs3GYpzmiRfjwk=;
 b=hZqsYRzXZGZff7HsDb/FCF6NIqFRlLXuh7rJODtSuu1faIwl54KP+9GNG9fG8Ek/Wpu7YRVdw
 pwtXHhdRC4hBUFoe6VEuPNe715vyEmvGKbTO3ZMO51EvkR6Qh6K2V45
X-Developer-Key: i=bschubert@ddn.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E9:EE_|CY8PR19MB6940:EE_
X-MS-Office365-Filtering-Correlation-Id: db755da6-96b1-4c6f-027b-08de11b95500
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|19092799006|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YWdoRWJTNVhPSGhCa1RkRFBTeEdrVDFTQWpza3RIOTYvcmRzRmNPS005VnFt?=
 =?utf-8?B?TlVsQStQOHpsOHdRZSt4U0tEVlZUVDZ0V2ZxZzBERFlhMjdMamxEK1JBQUhC?=
 =?utf-8?B?OTJldlpYUEdiNHpnSDIzRzB4MDJHVjZoN0NqZjcyVHplaHhENm9DdWtDWDMw?=
 =?utf-8?B?SkhWUktDYzhRWU1zN2tkUzd3K0hCdWI2em90QUUyNVdvdWs5QXovQlJVYzZs?=
 =?utf-8?B?VkhSU3ZHSDJ0aVdadE9wWkVHbzBVS3VBQUh1a1ZBbjZHOHIwQUJieUxlMmli?=
 =?utf-8?B?TXZyWmU4a0prdHBvZ2laYlN2bUJUZ1ZidXBRazFQVW9ETGVwSUxTb1g2WGwr?=
 =?utf-8?B?YnBqdHJ2N09OcnNiVThRckRmNTFCc3dGUGpaUmpPVG9uemVJY0dBVjQ0bEw3?=
 =?utf-8?B?eVBiTElOemt5TGRFRm5pUnBuL1hxck54Z3hZQkNzRk5RL2tBcnZzTW5kZE9k?=
 =?utf-8?B?eXdQQW5VOGlqbUU5b1FhSk1VT2U3UjFINkVVV1hSVVhRWXE1cmpqTkR0ZnAw?=
 =?utf-8?B?WkpsSEtoL1JNU0RJQk04ZnNiNVY0dXlRYldCd05ZS3dUbnRHcktCajFZeGdW?=
 =?utf-8?B?REhQREZuMFBoVWpUMXdkMTF2aVdOcjliVW5KTEpNaWJ0ZWVDWWRHWVZtaUpH?=
 =?utf-8?B?ZjZ4UHBCemd6VkJrbk16ZXE0THYvdFQySmZLMUVHbCtsZzVxVzdnd0h5U2pU?=
 =?utf-8?B?eGJYekRxbUxNaGJKVnFDdmFCd3h2ZGp3RmlaOGdTOHBoRVdzanh0V1FkUC9K?=
 =?utf-8?B?T29uYlV5UnhaVC9uYm0zOVRMWHBuT21mTThleTJjaFQ3L1Y2cFFMMnA2YUgw?=
 =?utf-8?B?VWgvdkZtUHBRWExleDR5V2ZZUFdnOTltWlp6cjVnQXJJTmdEQXk0SU5KZlB0?=
 =?utf-8?B?WXRJMHl2bGxOU2FLOE9Bdkw2UWZzY281Tzc5bnB6d1dZdzlhSG1hckg5bkpt?=
 =?utf-8?B?ZTJQcE1BSmQ1MlZ5MllJQkU4bW1wcy9HWFVkckxOKy9waER3LzhXdDZQN0hq?=
 =?utf-8?B?VDQ2THlCcE1xdDlwNVU0cWoxa0ZwSVorZFQwcm9CSkdwZ3pDeFdJTldKdUpn?=
 =?utf-8?B?allOT3VDMWJjRUVlc3ZRcHpTVWF2UmZORWx6a29oYTdDOWJNRzZUZW1OR2Y2?=
 =?utf-8?B?a3FFQVZDaTZJQlVxV3g2TEdBbHVhUTIxRmRnTm9QblErLzZoeHp6czBVc2hC?=
 =?utf-8?B?cHdqMUtSQmtKOGNtVW9rWHEwYjZRTUljdVN1TEs4L3UwR0lOYmRPTEkveEdZ?=
 =?utf-8?B?Tkl1MjZpa2FVbXI3aU9DVWk4NFlOOFExYnMwSUhBc1Bxazl6NTdWaHE5RGRp?=
 =?utf-8?B?Q3JGcXdyTnpnZUd5WDJzWm1SVXJyaFdERGdMdEIvc3FkZ01TVW5xOExBTTg0?=
 =?utf-8?B?bmR3ZWtUek81TXo1SzZrQmp2Tm80VVhzaE5hUVNhN1BPYjFSMDQyT285MVlX?=
 =?utf-8?B?NWlCRlBXM29iMjhNOFpLa2o0TU40eGxVNm5aeTFJMjBHNExPcTBnaFJrbGd4?=
 =?utf-8?B?cUFtTXdXS3ZsV0Ixa3NYT2Uvajl5dW41UmdBVXhITHFTZ0FhVUdDM1dWaldL?=
 =?utf-8?B?a1R1UEc2L1UrZ3p2cEtzN2NVclp1ZkdPZnkrT25VMTB4T3JCQjd2eXdxcEo5?=
 =?utf-8?B?SXZEcHFXdkJwM1BzVjVTVjV0blprb0ZzL1BCd0RyeXAyMzV0alhGR2NCMlJv?=
 =?utf-8?B?ZlZHZGRDUjlRbkswMy9OcHAxdlV4bSs2RXhOaVR0MmZNMzU5RS9pUnNCNG5o?=
 =?utf-8?B?K0t1VjhBQnNRSTVzcU9DMExtSVQ2T09YS3BtaEZIWWpOUHVKMW9HVTFFOXVU?=
 =?utf-8?B?clhhZWpSNXBEOWY2L2dvWEtSNTFkemdYUndJT1E5eG9ON2hCMVVWYnpXK0lB?=
 =?utf-8?B?dEZ3cnNsbG1wRDRYaXhhd1AzaU1ET09WaVhGVU1WbFV1c1hrVTc5TUZiaEVM?=
 =?utf-8?B?MnRNK1FJclp2WVQ4SnBsUnI3ZWxzOEZ4NjZwV1ZiQkR4bEtLMzdZaUMrMjNG?=
 =?utf-8?B?L2JDazhXNnFmcW1kdHRydzBncVh5empER2ZlUHpXMDNqZWU1aWk1QmV1Tk9h?=
 =?utf-8?B?ZWZYVWhiSTNzN0wwMHdFVTNCVGN0empUdFluZmJTcmZNSkUyd050YWtDZnNU?=
 =?utf-8?Q?uZ1s=3D?=
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(19092799006)(36860700013);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	TSGg/dPFg2JZ4n/XqYvdkn1iSQTr1kRlSFjLZM/Ou+rb50s4ZUlnb7ItjmsC/DSWMhB0sBoWu063O+RYWcXQNVNKSnTHFCfC6siIRwWbi27ylqBUzwQEa3YdVAnd81N2+KhBCBBQHhO/pXLzlmUvRt5bdPkCKQ1iGzuJoPjcfLvoaRBwJ5rRsBXFW6xusGegJAWeBZE6dZdVhzfvcI3wh4SBnZ5dkihOAnLAJx5M5DsnbHCBmcg9WbfeUBXhxoW3yMmMPsuHDFZGj6Yb656mtPSGgXRyYhypJr3DPd7r/VpR0lEPKs7HLqN/w3QABRkmVyAG6JOsvjSUZhjMhsqKiI+WVUOYsej4mbANqPkIbNwTg55pCNLP2CYdzvG99tSS8Pz/KIpg5Pj7Kg9M2l8xIJFur97dWPnPTngTTbCzKgAlDDc0Jvc1gahM7EUau7nmxAg2/Wh9vshX02wcoa1CIZBphs37ZaMcAimClBEvwKRvWZ8ma8WO/1kp1bnbpmU1MoyvTp5W6WgI6YXKgvUdkun4KQWuVqHrt53pCFBR8HLlhmZaebxO3SStwefsd1SR2uJsnESxOg13/MRxUVwViGR28ClgM8LK9JQIr2VBF5xs/NspNjq5ndl+xkc7h7K297cVxqwNrjHR5mJjOLXhQg==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 22:21:22.4694
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db755da6-96b1-4c6f-027b-08de11b95500
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR19MB6940
X-BESS-ID: 1761171686-105278-8608-23777-1
X-BESS-VER: 2019.1_20251001.1803
X-BESS-Apparent-Source-IP: 40.93.194.110
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVhaGZkBGBlDMJCnZIMUyOSkp1T
	TZPNkyOSXN1NQwxczMwCI5NTXZwlipNhYA3H4rV0AAAAA=
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.268402 [from 
	cloudscan23-81.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

This was done as condition on direct_io_allow_mmap, but I believe
this is not right, as a file might be open two times - once with
write-back enabled another time with FOPEN_DIRECT_IO.

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
 fs/fuse/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 746c9113107e8f8b7e848c338a925025ddfd961c..bb4ecfd469a5e835ac9674625384f210c8a42c19 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1607,7 +1607,7 @@ ssize_t fuse_direct_io(struct fuse_io_priv *io, struct iov_iter *iter,
 	if (!ia)
 		return -ENOMEM;
 
-	if (fopen_direct_io && fc->direct_io_allow_mmap) {
+	if (fopen_direct_io) {
 		res = filemap_write_and_wait_range(mapping, pos, pos + count - 1);
 		if (res) {
 			fuse_io_free(ia);

-- 
2.43.0


