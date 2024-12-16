Return-Path: <linux-fsdevel+bounces-37557-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02F029F3C78
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 22:16:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE07D162C12
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 21:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529E91D63E8;
	Mon, 16 Dec 2024 21:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="DiQw0Gtm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip191a.ess.barracuda.com (outbound-ip191a.ess.barracuda.com [209.222.82.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42DE1CEADD
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Dec 2024 21:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734383671; cv=fail; b=jrx0yvJ9OhjbEp4hzvQabZV2N/HdZsEFSqPZyU7x/vl4ceiCgOj9aLUSt63RzZu+LMjDnd3IRLv62I836I0QlZduSofjYItnyR1jvZkBF4QL8m/m0XIqW6rnjgK29LLOgllM1wQmZMsG8hKpKbeV+Q7Ll3BcRfEx5bviO6jqkpY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734383671; c=relaxed/simple;
	bh=+g/1Dx0SW50nuo8vH+HhLcRdENQtTJ1dYpIuOife0rg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M6ZXYKtD5dInEKbasHX5tvZxPQZmsitQqqBNG63NkL68bZ8CrULW/R1XdQxowAU8qkYjd/kJSv9CTZIy1jKCDxrM1bVeuGxTMkU8aJQEpXGPEeB70+QyQXdMWtkWkNuAG5ZvKf0DZvi85dLJdOSLVszjzfQdD7am3w9tIMdRuQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=DiQw0Gtm; arc=fail smtp.client-ip=209.222.82.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47]) by mx-outbound11-114.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 16 Dec 2024 21:14:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u3NSOupT+Tm4O7DvYGT+LGCXW1l6iCHqgoJhmhtVdQ5diIR9T3g4utiUJvN841u2RdnDiLO4V0a1NL2Jdr6xzn1+H3uhY3//Ei+GtDziBTWowmfzNKN4oGJ6rtCaqS8uywkoL3ZCu6KySfgCM1tbibOUOkl2t9AXqG7YHvW+KNO9tIBEq0ZOEMGuNDfmwAx5jKGmMwc35WugQsCkQDN7/S7/s1qaSG3DzcHIjobhTnnYgM/QuQrJjnFLNBQ6WpkCo540Fpumtim1l8Fqgp+Dcg9KH0QqRyAdYpYrA5tFQFmdnEyN1slIt4TRNLU3S5N379p7dAUhhfoKK/8i9zmfYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cmOBH6iKqQO4OdA78C0LdGCaUZLawz9LwMEYVmyY0UE=;
 b=aNw3w/Fl6G7Zu8+j4cO520bj+Q/cAfR2T5UkqlWdHUclE8T3PSvY5XOG1rlVZdS+i3Rrd06WSaUnYKW2hyR9oiGCjnOfY3UXdkZfDVgvKcnmH3fPtOGxoAnue/yJ4pKDSxwnlGg3jxB82MVWYUxMyCvf3quXpmJ/emVOps2Mu4TecM30mhn6AACAvpCZx5HGSv0ay373mUBmMP+UQ1z2bp4FbsMI4Ou5wkEWgITLP9UFx9sONY0C8lGYM+t7rQMNcBPSsJU7/+SZHeg4MDV2d+CesMgGyL/koi/7a05WanLDK5ymOZsuvh2jEOhQ8FGa20+jqi2KTQej75t2SxQkJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cmOBH6iKqQO4OdA78C0LdGCaUZLawz9LwMEYVmyY0UE=;
 b=DiQw0GtmFc740uj+EDAiyfOR2auwS8J4UpyXDKjnAQ29h/33DO/02rYJGGGF/dBiNsf0vajZpAEqhAt7CC0QAItSSmTxX3bsFauJC75dCfSy6xPZC3DkV4lBj6V/uCQ1wpFlFwgDr44IgI76bWgOp3Ghej+FygLHmGmbkSh1yxM=
Received: from BN9PR03CA0183.namprd03.prod.outlook.com (2603:10b6:408:f9::8)
 by DS0PR19MB7224.namprd19.prod.outlook.com (2603:10b6:8:133::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.20; Mon, 16 Dec
 2024 21:14:14 +0000
Received: from BN2PEPF00004FC1.namprd04.prod.outlook.com
 (2603:10b6:408:f9:cafe::e8) by BN9PR03CA0183.outlook.office365.com
 (2603:10b6:408:f9::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.20 via Frontend Transport; Mon,
 16 Dec 2024 21:14:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 BN2PEPF00004FC1.mail.protection.outlook.com (10.167.243.187) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15
 via Frontend Transport; Mon, 16 Dec 2024 21:14:13 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id 88A4B55;
	Mon, 16 Dec 2024 21:14:12 +0000 (UTC)
From: Bernd Schubert <bschubert@ddn.com>
Date: Mon, 16 Dec 2024 22:14:07 +0100
Subject: [PATCH v3 2/2] fuse: Increase FUSE_NAME_MAX to PATH_MAX
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241216-fuse_name_max-limit-6-13-v3-2-b4b04966ecea@ddn.com>
References: <20241216-fuse_name_max-limit-6-13-v3-0-b4b04966ecea@ddn.com>
In-Reply-To: <20241216-fuse_name_max-limit-6-13-v3-0-b4b04966ecea@ddn.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, Shachar Sharon <synarete@gmail.com>, 
 Jingbo Xu <jefflexu@linux.alibaba.com>, Bernd Schubert <bschubert@ddn.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734383650; l=4423;
 i=bschubert@ddn.com; s=20240529; h=from:subject:message-id;
 bh=+g/1Dx0SW50nuo8vH+HhLcRdENQtTJ1dYpIuOife0rg=;
 b=eydZoKGARj0DSPQeHwgcPoLVfJtXYXhup2e2RnqRneSdAo4CaNrs9/Pw701vUrUcN132AJRMW
 wnBAs2zKKrNClilK6Nb9IabndDBVdQOZ67DuQXVAZnb6YyYAztu0TGq
X-Developer-Key: i=bschubert@ddn.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC1:EE_|DS0PR19MB7224:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fe93142-3af1-40bf-3e3f-08dd1e169796
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bXdLUTduQXhZb0lpcHExQUpnZlJuOSs3amJJUG9wMFJYMkZhZGhJRW96bGdU?=
 =?utf-8?B?UUUzaE1tMWdlcHlqdVRUL1E1NHNTdDB5Sk1KZG55SFRZSnhlU1pBMFMvWk9E?=
 =?utf-8?B?MnZ1a05Pb0FjeFVBWVM1MjhtWlNPb1ZpV0lGTnpPTUw3V080RUxBN1oyTzdu?=
 =?utf-8?B?UUJhQWlpM2Vqamx5Q21XVE92Q2JaczI3OXcyR0k1UWtsRVdzVTcxL1NnVmdl?=
 =?utf-8?B?ZjJGWG1UY1ZRd3IzZTJFYWx2clU5L25EenJ0K0E2Q25uT1dSZEVPa2QwT0hw?=
 =?utf-8?B?YklkUk52STkveENQdW9ZamxGdXhnSkZHaHFwM2UvSmFzT2xwcWN0WVo0bnc2?=
 =?utf-8?B?TkcvQmxneDZWaVFmRlNkK2YzL1JDb3JNUzZJLytWZ3RWdjJOaG03OStnSDhv?=
 =?utf-8?B?NWZvYVdsWTFTaGVBMitpQjU2VEJjTEl1cTBKYnVlOE5pQlloMkhLeE1acy9T?=
 =?utf-8?B?Z21WZmlVaWZ6Q1R2YVBOYTJiOTZuVENWNkpUNVlha0lsZWUzWkxidExkbjZD?=
 =?utf-8?B?eXd4YmkvZ2FsSXRmcFVRWFRCQ3RBdFpIZ0ZyZWVKclB2UlF2YnZ3WnZtYXRU?=
 =?utf-8?B?SjhTMEZQd1hFTUNWR3B5NC9KY0MrMldmVm1FSlYyQmhqVHNBd3BwSHV1NjZI?=
 =?utf-8?B?WWRhb09EbDBCelZFN2tvbFNNYTlRNkFzZHgwNXEwQnE1WFBDaGtuWGlMa2Zh?=
 =?utf-8?B?d25ESG5zeTdGWitMY1JvSEx5VnFmRjhnZnZod3NqQ0NLN1FMY0ZQdGF6VEJK?=
 =?utf-8?B?VVlUS0pRZnZEemVaWGFKb1E2dlNLSVU5eVVqT2JzZituVkNOQW1BTzJqbG5F?=
 =?utf-8?B?a3IzcWwxY1RSdW9zWjdrcDlBeXNEMWR2RTRCWjVWSHRzR1grcGNEcnkwTnNL?=
 =?utf-8?B?dDFJb2FHekNvaHdzTzBhOXVxOE1EWXRpNUR3ZjJJSGFpMVBDNWQyUS9zbkFq?=
 =?utf-8?B?NzJZS0wyRHZBVU5NeCtTUUxCLzNKNXltMGduTVJjWnVteEw4eVFnN1pSME8x?=
 =?utf-8?B?cm90ZjFjK3Y5U0N4elVoRlZPVHJwWkpWeTJCOXJKbTJNS0RBWS9URG41L2dD?=
 =?utf-8?B?aFlmQmNMVFhKNHF6ZWNxeHZHQlU3L1pDSjRTajEybm5zSUVQRkJPKzU3SEI2?=
 =?utf-8?B?ZUxWaWJydXdaZHIyZDcwanRMamVFRm4wTlhyU0x1Vi9XSGEwc3dNQXBrUWZR?=
 =?utf-8?B?SVRRR0VjV2dnZk5RTHZqUktROU9uOE1hMEttZm9Qd2FaSFhHL01nY2NvWkRl?=
 =?utf-8?B?MTlQRjBvV3dJajNla1ZMNmxaZ2F1VDRadVk1dDlxTE4yVXdZVHNtUk1KbkpL?=
 =?utf-8?B?TlpMSFB3OTJyS1dtVTZLa3h5SzJ1Qmx0MlpIRnNPVlZlWXZwK2VVUlVLZ1U3?=
 =?utf-8?B?T0lwVFpBMUpQOGlaQ2l5WmNmaFlPajdmQzVnc0IydHB2aGdBV1ZESG1RSEZa?=
 =?utf-8?B?TkVNTFNDaEJLZUtKTkw4TDhmY3hNVVFGVFlKc0ZFU0FuVWhOM2ZvN3FtZ1Iy?=
 =?utf-8?B?Y1NTTitoR0ppZEVyR3F6VGJlN0dEK3BSbGJvYXV0RWVKV3dpQmg3MC9xVWd3?=
 =?utf-8?B?NVdOcHVrUFN4U3FSNmpJR1ZBeEZqdkY4bHVkK1N4bFNyRlhMSi9LNEtIeGdI?=
 =?utf-8?B?Z29xbHZranFYL3dFajUweDdnV005NVJYVEtISDV1b3pZRDVXdmJnYmRnM2lL?=
 =?utf-8?B?ZEx6ZkVXODNyMk02UlhacHVwazdzeGJMeC93eUNTMCtudDhtZHdhL2dTQXk4?=
 =?utf-8?B?dzZmK0dFRHZWZkg5dVNWV3F1bENuK0xId0VFbE52em1SRFgvY1lYL3VwaVdC?=
 =?utf-8?B?OVgxdk43SGdyNlIyWi94MXQ5NldQcktDcjFxNHhVakl2d0Fac0JiZU1uUHFZ?=
 =?utf-8?B?dkJQTHdFVzRKbkcvQnJ3eGFMTGxhTnZoS052WS9CK1h0NkJ1SXdpM0NnV0ZL?=
 =?utf-8?B?eWpSK1o1NS92Q0hHcWl3bUJOUHR6UllUenlzV2lhZnBXYnRjL1VYSlQ5Sm5Y?=
 =?utf-8?Q?SRH3M5UmVUGF/Yy1rMR9SIGbN33dfw=3D?=
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mrSfaqXPnsbnO8PMeUjiQjHGgIoBtayrzxK+SWe+aiac4KjQmsYioedFhkxDn5Cb/RgqD0cmAsXtnKy0/yVEGWQprqW66fiopqorZT08U+5R+sJgMkw2RPP1wDSN9BWlhm7+bFkhlIKZVnfeafexSm57BxAb1nt023qFFg+VRD4+7DYjmpFwLL+oxnQuu95Sbof2wlaRFyua6J4ELHRnOo13S8PH8oHp2dqeYPzNhzEoYj25ucv2fsge8+85pHEqgY5iPGu2Rgukp1cUnE9A0vElAG7M3NUnHs9Ghc+ygvaezuRZCYRt5A6Lt+6a6mdVbI48cXj1OrRH4D+nyb0EZRWS3urSMXwObj5scb+nnhHDJgFeT52Xj4hwmESzpj5g311Jv7LgqqYDqGIgKH3uHxcOY/a5InEzjfE40I1H+zCO74yV61GiNxmf10OaEkzjoJjbNi1OiaTdAwR6lP5DjECJJDClpjWky+QTb904A8dFcESDRrVi7ZWKisRd3l+e1PC4Lxx3cyOdxpcm2sExZODDtJZFacDJ0MMl7IzKB1z5cILvmcIeR/WtaDSfaxd83gCPG/rSm2VUsd7R+F9TU23e130gen4WfXiqlH/Ievs/Fs2Di2IaBEwDO6w5grP8pcVLPxuXzln6O4eQGC4K8w==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 21:14:13.6079
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fe93142-3af1-40bf-3e3f-08dd1e169796
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FC1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR19MB7224
X-BESS-ID: 1734383656-102930-17820-8818-1
X-BESS-VER: 2019.1_20241212.2019
X-BESS-Apparent-Source-IP: 104.47.66.47
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVibGBoZAVgZQMCU10cI00SAxzc
	TI1NgszTLVJC010dzcNNXMzDTVPNVYqTYWADfEZ0RBAAAA
X-BESS-Outbound-Spam-Score: 1.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.261160 [from 
	cloudscan19-230.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.50 BSF_RULE7568M          META: Custom Rule 7568M 
	0.50 BSF_RULE_7582B         META: Custom Rule 7582B 
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=1.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_RULE7568M, BSF_RULE_7582B, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

Our file system has a translation capability for S3-to-posix.
The current value of 1kiB is enough to cover S3 keys, but
does not allow encoding of %xx escape characters.
The limit is increased to (PATH_MAX - 1), as we need
3 x 1024 and that is close to PATH_MAX (4kB) already.
-1 is used as the terminating null is not included in the
length calculation.

Testing large file names was hard with libfuse/example file systems,
so I created a new memfs that does not have a 255 file name length
limitation.
https://github.com/libfuse/libfuse/pull/1077

The connection is initialized with FUSE_NAME_LOW_MAX, which
is set to the previous value of FUSE_NAME_MAX of 1024. With
FUSE_MIN_READ_BUFFER of 8192 that is enough for two file names
+ fuse headers.
When FUSE_INIT reply sets max_pages to a value > 1 we know
that fuse daemon supports request buffers of at least 2 pages
(+ header) and can therefore hold 2 x PATH_MAX file names - operations
like rename or link that need two file names are no issue then.

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
 fs/fuse/dev.c    |  4 ++--
 fs/fuse/dir.c    |  2 +-
 fs/fuse/fuse_i.h | 11 +++++++++--
 fs/fuse/inode.c  |  8 ++++++++
 4 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index c979ce93685f8338301a094ac513c607f44ba572..3b4bdff84e534be8b1ce4a970e841b6a362ef176 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1538,7 +1538,7 @@ static int fuse_notify_inval_entry(struct fuse_conn *fc, unsigned int size,
 		goto err;
 
 	err = -ENAMETOOLONG;
-	if (outarg.namelen > FUSE_NAME_MAX)
+	if (outarg.namelen > fc->name_max)
 		goto err;
 
 	err = -EINVAL;
@@ -1587,7 +1587,7 @@ static int fuse_notify_delete(struct fuse_conn *fc, unsigned int size,
 		goto err;
 
 	err = -ENAMETOOLONG;
-	if (outarg.namelen > FUSE_NAME_MAX)
+	if (outarg.namelen > fc->name_max)
 		goto err;
 
 	err = -EINVAL;
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 494ac372ace07ab4ea06c13a404ecc1d2ccb4f23..42db112e052f0c26d1ba9973b033b1c7cd822359 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -371,7 +371,7 @@ int fuse_lookup_name(struct super_block *sb, u64 nodeid, const struct qstr *name
 
 	*inode = NULL;
 	err = -ENAMETOOLONG;
-	if (name->len > FUSE_NAME_MAX)
+	if (name->len > fm->fc->name_max)
 		goto out;
 
 
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 74744c6f286003251564d1235f4d2ca8654d661b..5ce19bc6871291eeaa4c4af4ea935d4de80e8a00 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -38,8 +38,12 @@
 /** Bias for fi->writectr, meaning new writepages must not be sent */
 #define FUSE_NOWRITE INT_MIN
 
-/** It could be as large as PATH_MAX, but would that have any uses? */
-#define FUSE_NAME_MAX 1024
+/** Maximum length of a filename, not including terminating null */
+
+/* maximum, small enough for FUSE_MIN_READ_BUFFER*/
+#define FUSE_NAME_LOW_MAX 1024
+/* maximum, but needs a request buffer > FUSE_MIN_READ_BUFFER */
+#define FUSE_NAME_MAX (PATH_MAX - 1)
 
 /** Number of dentries for each connection in the control filesystem */
 #define FUSE_CTL_NUM_DENTRIES 5
@@ -893,6 +897,9 @@ struct fuse_conn {
 	/** Version counter for evict inode */
 	atomic64_t evict_ctr;
 
+	/* maximum file name length */
+	u32 name_max;
+
 	/** Called on final put */
 	void (*release)(struct fuse_conn *);
 
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 3ce4f4e81d09e867c3a7db7b1dbb819f88ed34ef..4d61dacedf6a1684eb5dc39a6f56ded0ca4c1fe4 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -978,6 +978,7 @@ void fuse_conn_init(struct fuse_conn *fc, struct fuse_mount *fm,
 	fc->user_ns = get_user_ns(user_ns);
 	fc->max_pages = FUSE_DEFAULT_MAX_PAGES_PER_REQ;
 	fc->max_pages_limit = fuse_max_pages_limit;
+	fc->name_max = FUSE_NAME_LOW_MAX;
 
 	if (IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
 		fuse_backing_files_init(fc);
@@ -1335,6 +1336,13 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
 				fc->max_pages =
 					min_t(unsigned int, fc->max_pages_limit,
 					max_t(unsigned int, arg->max_pages, 1));
+
+				/*
+				 * PATH_MAX file names might need two pages for
+				 * ops like rename
+				 */
+				if (fc->max_pages > 1)
+					fc->name_max = FUSE_NAME_MAX;
 			}
 			if (IS_ENABLED(CONFIG_FUSE_DAX)) {
 				if (flags & FUSE_MAP_ALIGNMENT &&

-- 
2.43.0


