Return-Path: <linux-fsdevel+bounces-37556-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5FC9F3C77
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 22:16:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CAC47A758A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 21:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F7F1D5AA8;
	Mon, 16 Dec 2024 21:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="Y+57wHh8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip168b.ess.barracuda.com (outbound-ip168b.ess.barracuda.com [209.222.82.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80C04437
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Dec 2024 21:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734383671; cv=fail; b=FTntfilJ2sVIo6CBeAVxp8WMIoy3pr9NTz5VofFuJGZTlN8F+gW7WNYcIIGs/RjrZGX1YnpOu3f1Mnyc6vwlXQI95IG+oqvxAjqjCm9GyNcl+mE6UgeoCIrmDg1wgHc4ReCg5Wr5rhnrnwUDb/xMR/mYDLLsEi9EHWopAZuFZDY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734383671; c=relaxed/simple;
	bh=TEqkVJpwiN6TKszgsfKn1PmnS2FKZ+qsBW2fDGv5LwA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rPDP90viTwM2PGdUfIK2ktC7aIkwiGWw+UuRCSZNLfOb7x9Hmsv0WmhxXgTlZMyfTsZiu0G0+HJInYfIlkS5Fe4dpnBtjYFSANdBHgtXjQIcjfQqoJOaGcLFiH1ld3liuVkomCEkT5hE+SditMlM2rSinFLUYVdJW0soPQCq9Ao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=Y+57wHh8; arc=fail smtp.client-ip=209.222.82.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2047.outbound.protection.outlook.com [104.47.58.47]) by mx-outbound20-17.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 16 Dec 2024 21:14:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sOPiToey0ksR1RLjxX5auND96uP1ZRyFPyA01KKumD7Vx4IDCjyvxaz7izlN38X71US9T8rj174EzqnGbXaavC8eTvBRJ4W4zfPGARgcC5DCTsmC5feTKWC+WV/TuPzRG8OKhZJMbOs9O9NUeG1LQK0/l2wNVIM9yTCnZ2c9Y1CRuq1xuH/eiUSJfLSBANBIPJzM1Wfb3fW9h7cxqXGbr2C2eeAZp0gDtqh9tFItX1YeL7RXg4f0jqhPBUZoaeG2c6YxBtRjAhw/3V44pfb7ZAc9cnvPnQZSHWPXvSMsqjh0TALnGzBSRHFSPY62ZReLQkpEBTvNpACkSVF1aoT1PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EPVEcSUBUCyRQeY7PUKfUs/mVzhUvuRGq+cGtv9I7Ds=;
 b=QdSCudgPnWv0nBKcA5jo7qwHbwkVwk7T+y1ATZSdZbQ2b+pExCQholB7EYdJz6wGVa57WIYdD4speoAC2p67av/HVyTBle5BMsm45oqSVZjK3IlK50dVdc3+Ei9jmVtMX2xyj0AllgqS2+aBiUJKODXq1+KkmDgeVWRs42f3S0+cokMXh/qobuMDi0wkhlvFa0KOAMLUeyWHX93h/DEL+9YbdIv/xg+7stuAqhfP7AHv8I0Zw5NxwYN9RfSSoStrIf2iyFIIsZac4xw6i8nW9bOaGk3RevmyUpzS+HGVS/JU3C/vCNC+xV6Iu6FBpr8+lLFochYMuGMvbbJdujumFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EPVEcSUBUCyRQeY7PUKfUs/mVzhUvuRGq+cGtv9I7Ds=;
 b=Y+57wHh8g8EkqHnlGTSwtnronwFIhNWdhdqztaUal416XYHOfQWTJUIlrVFFYnVsDUmShvKjYUsCOerNDAw3UOodc/cmStOTnQ8J91dpFT68i2W/cqy0NokOar67O+07YVYLmaSPFHoQgTJ20sVM9qRGfVkUlT1pommTDEnu3vk=
Received: from BN9PR03CA0570.namprd03.prod.outlook.com (2603:10b6:408:138::35)
 by PH8PR19MB6973.namprd19.prod.outlook.com (2603:10b6:510:22b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Mon, 16 Dec
 2024 21:14:12 +0000
Received: from BN1PEPF0000468A.namprd05.prod.outlook.com
 (2603:10b6:408:138:cafe::33) by BN9PR03CA0570.outlook.office365.com
 (2603:10b6:408:138::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.20 via Frontend Transport; Mon,
 16 Dec 2024 21:14:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 BN1PEPF0000468A.mail.protection.outlook.com (10.167.243.135) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15
 via Frontend Transport; Mon, 16 Dec 2024 21:14:11 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id 95DEA101;
	Mon, 16 Dec 2024 21:14:10 +0000 (UTC)
From: Bernd Schubert <bschubert@ddn.com>
Subject: [PATCH v3 0/2] fuse: Increase FUSE_NAME_MAX limit
Date: Mon, 16 Dec 2024 22:14:05 +0100
Message-Id: <20241216-fuse_name_max-limit-6-13-v3-0-b4b04966ecea@ddn.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAB2YYGcC/43N0Q6CIBTG8VdxXEeTgzjtqvdozSEcki2wgTGb8
 91Db+qqdfn/tvM7C4kYLEZyKhYSMNloR5+DHwqiBulvSK3OTaCEigEDap4ROy8ddk7O9G6dnWh
 NGaesEQ30mrdaVySfPwIaO+/05Zp7sHEaw2v/lNi2/oEmRkvaQo8CTMlQybPW/qhGRzYywTfDf
 zCQGd4aVAIErzl8mHVd31rupNkFAQAA
X-Change-ID: 20241212-fuse_name_max-limit-6-13-18582bd39dd4
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, Shachar Sharon <synarete@gmail.com>, 
 Jingbo Xu <jefflexu@linux.alibaba.com>, Bernd Schubert <bschubert@ddn.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734383650; l=1279;
 i=bschubert@ddn.com; s=20240529; h=from:subject:message-id;
 bh=TEqkVJpwiN6TKszgsfKn1PmnS2FKZ+qsBW2fDGv5LwA=;
 b=cjwhM8vGDY0Mx7l/ewu2dFohGEInYcfI7WVFMHV3+RP5BNm+lljkpQPAfra93yM7XxPpV32zS
 xo/K9FYOKQRCb/zNwYRET7x1sGtXs3izCSMtuu/iSTjzhgU12UfLdi4
X-Developer-Key: i=bschubert@ddn.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468A:EE_|PH8PR19MB6973:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b4fad36-4b43-4a39-86bc-08dd1e16966f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Yi96Wng1MlRrTUs0dzJ4OWhiKzVVcVpDbndaNmZhREgvdTBnbDRzYVlETmRD?=
 =?utf-8?B?dVZWeG1BaFRkSzhzdWdLYnpycFZLQjhHNEpZZzhEcG1EandUMXlXeERNRDNu?=
 =?utf-8?B?MzBXWW13Z3Q5Zkx4QzdtZjRNdFhzWitRSnAxMTNwV1IrbjA4ZnZOM3RFMTNT?=
 =?utf-8?B?ekdDTTZOUjZpVm1tWGlqNzg5V05IckRQZHVGQUlpS3VLVzBmUW5TeWhMOCt4?=
 =?utf-8?B?L284YjBLci9XbEpML3RkVXEwR0p6bjU5RTA1N09pOTlQY3dXUE01bDJWd21C?=
 =?utf-8?B?VGRhTEpUZkt0U1ZtWksvWHA4MGN3a0V5VWF3MmhRb0pjK3Rrei9mSzBUYjNH?=
 =?utf-8?B?RjZlMGVQZXhWTjJLRm84aVMyOXNlYUdOQWRDY0JITGY2UDkzNVIwMVp6VEQw?=
 =?utf-8?B?alhZdzVFN2JMTmhLSzh4RVhyemNJWFpETUhZRHozZ21FZDVjdzhTVG9TUVIr?=
 =?utf-8?B?OCtFL2EzaHNsZlVWbUUrTmowbzM2eU9kUUw4TW1oMWZnN2licG9zT090d0lK?=
 =?utf-8?B?aHpRaXNQMng5WEd0OUpMd216TWJ0TzJETmlVL1ZUZzdPSHBqMVZ5K3Rxa0th?=
 =?utf-8?B?MzE3cXlnekdlMGlQSlFNQU1LK1BkVmVOS0VZd25DMG1TUG5aRWJsYTA1N3A5?=
 =?utf-8?B?R3Q4eFNpYk5ObWRSOFkxeXVOZFdFdWZObWZIcXptZm92WEVoTjZicFB2akgz?=
 =?utf-8?B?ejQ1U2h5ZHdQcXcxa0dzeGpQVFlDMHpmUDNnN3l4T0VxTGVsOEcrSEs0VVJY?=
 =?utf-8?B?cmxDWVdpWW1HRnI2a3RBZ2Y3ZFpKNHJENkk4ekdvN1h6S1dmcFAwK2twM1VK?=
 =?utf-8?B?NUNMdnljMVZxVHVoR3N6MTlGMkZEWm41OStwaHpuUTkrWjN5OTlPeml0OWU2?=
 =?utf-8?B?cTIzN3RLZU9WOFZCbzZsOWE3TGppYUJzdmM5bmRCb2Z1eFU5TzBjbVR4bmRD?=
 =?utf-8?B?QllSRkFOdXk4R0IwcTlpWnhreEdsRktJZUw5SW1yaUNGQVRtK216eGxxcm5Y?=
 =?utf-8?B?OGllU1lWVUpWVm1heHQzOTlja3EvUUR0YXdxTmFqWDhxaUtlNC9KYlpSOHp6?=
 =?utf-8?B?R1E1SjNyUnBTOUZtaEhpZFpSdVBUWlRvSEtQSEdJUExsSmNab1BLdU56WWkz?=
 =?utf-8?B?VTBIVFdFbGlVUnVFTDhmRDB1YXphNUFXYyswSXBLVEtuQWFwNkRQdVI2Qm51?=
 =?utf-8?B?WW4wdkdwTFRNbmRqQnIzYjJMd3ZZUnQ5U2IrUm9FcEJXVXhZenlKT3p4Nys3?=
 =?utf-8?B?Q1ptSGtkSXRPZzRsaS9YOW16aWlEQmpIM2tJRjdkd3Q2dTFIYk1yalFlNFlB?=
 =?utf-8?B?ZkN3T2FHMFpnTmpaek1vQlErVFB3M0J0SXJHcjk1NGdQZFZpbGVNZEtDNlpX?=
 =?utf-8?B?OGREWkFDRXpaN1p6cklseGYrSFBrOW9YczBjS2VSaEVNVS84eXFWNXVRbmlz?=
 =?utf-8?B?YXBjbXYwTVdmL005NlZDM2R3RVVHYjdxUU4vNUJ1eldSK0g1dnJpL01VRmhq?=
 =?utf-8?B?cVY1WHpzTmZqWlV1R09NQXZCQk1HSFNKbVNaWG1GVWViSHFIYzdEUkFJUUFM?=
 =?utf-8?B?N1lCRngzelZoR2RHUktFdlYrU2dMMnhLbFZqeFRwdXQwM093M21LL1JoYWRJ?=
 =?utf-8?B?QXJXV3FTc0o4Vi9BZ2pmdHVkeU5GaHR1Mi9MYnJEejMyN1d3MjNldjlmd2F1?=
 =?utf-8?B?bzJXMDVGTFNYMjNQR21zSWQ4aEthSjVjbngxbEJ2Wng2SHl0VE1QN1UxQjZW?=
 =?utf-8?B?VUtsK0FOSTN2T1U2VTRvdytHSWh2TWx6eUJIdFB3NUFXYlpvUkllV2s3MUJS?=
 =?utf-8?B?bEdWZjFZZWNYMUdMaW9MNFFjVjZEWnl5Zy8xRlpuTkd1VENRVyszWkpObmtN?=
 =?utf-8?B?NkFpYTdTMVdPZHErRHFJUUFiMWQ4T1hDcldQMG9hdDhtKzVKaHpQeDQ2dDJt?=
 =?utf-8?B?WFN4UzBHc3R1d1RDMTF1SGk0L0tORU95SUJISE56b3FjMVA1SkQ4UXJKR2VU?=
 =?utf-8?Q?GvKUndKskNmdT+aoGSWkicrt2EfOy4=3D?=
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Ly4u9SrehBqsjymZyrZZuq+FgO3LAwj3AlBy8jdH+K+hdtxARWIUczDKvAHGfOFfk/hli8lI8ULKBRBWduHGkeggFU6rvDnIyU7urr0Ou792GqRugdTH5eyX1TLzn3MRg/nWSCS00/Vwz9Q4WAPgsVLt5CycI7DT4s2FR/6jlqjBf+3qMMJtABZBpJCTFc+fePGQqzyZCCE7tWaZVZWJUSU1LH71rSMsyRTbeTsL+UmNuUEZjvHdAAWEXxMaaEM0SlHm0hw2j5bV8WD38uhkhhvOBrg0xAC7l26pvV0+Sn8IckaV3Bs8TIARHedXa+/EJDFxHPKpHK55bbsz6TGYPq3wn1QHcjhqrLrPoIvdvmUBtGfKHj1iihvmLdD+VewbWfOFbJCn6Aa3uzzEMJfCQ7bGCZEnk2+h6nlIjcUyooG3/fkiV+J6SmNrBWhlY786rtwfpUnB5CgktSHImsCDLx2Eu2BO/7u0/lKgxOmC+Jn2RcOiGejdLjw3Bsm3CuNjJlEQnjBTPvpml8cSyAdIHTkjUH6bzg3kn41i0eWSCT22xvfXJo0g2qOmIEbhnNdSMXtsAnzKr8NzORnmQ/RI8q8YzB5dWHjmJw2gNZNTBtAdp7mEMok3fuIbMzMVJgBV4jWysyExKAv/p31Jh+9MNw==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 21:14:11.7077
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b4fad36-4b43-4a39-86bc-08dd1e16966f
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR19MB6973
X-BESS-ID: 1734383655-105137-22272-3733-1
X-BESS-VER: 2019.1_20241212.2019
X-BESS-Apparent-Source-IP: 104.47.58.47
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoZGJqZAVgZQ0MzALMXcONHAKN
	U00dwkycgiMcnQ0iglzdLc2CQ1OclUqTYWABSSIBFBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.261160 [from 
	cloudscan18-176.us-east-2b.ess.aws.cudaops.com]
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
Changes in v3:
- New variable fc->name_max that is initialized to FUSE_NAME_LOW_MAX
  (1024B). The FUSE_NAME_MAX (PATH_MAX - 1) is only used when
  fuse server set max_pages > 1 in FUSE_INIT reply.
- Link to v2: https://lore.kernel.org/r/20241213-fuse_name_max-limit-6-13-v2-0-39fec5253632@ddn.com

Changes in v2:
- Switch to PATH_MAX (Jingbo)
- Add -1 to handle the terminating null
- Link to v1: https://lore.kernel.org/r/20241212-fuse_name_max-limit-6-13-v1-0-92be52f01eca@ddn.com

---
Bernd Schubert (2):
      fuse: Allocate only namelen buf memory in fuse_notify_
      fuse: Increase FUSE_NAME_MAX to PATH_MAX

 fs/fuse/dev.c    | 30 ++++++++++++++++--------------
 fs/fuse/dir.c    |  2 +-
 fs/fuse/fuse_i.h | 11 +++++++++--
 fs/fuse/inode.c  |  8 ++++++++
 4 files changed, 34 insertions(+), 17 deletions(-)
---
base-commit: f92f4749861b06fed908d336b4dee1326003291b
change-id: 20241212-fuse_name_max-limit-6-13-18582bd39dd4

Best regards,
-- 
Bernd Schubert <bschubert@ddn.com>


