Return-Path: <linux-fsdevel+bounces-20476-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF54A8D3EE9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 21:34:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DE1C1F23151
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 19:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E9DB1649C2;
	Wed, 29 May 2024 19:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="m0Ks7pmV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip168b.ess.barracuda.com (outbound-ip168b.ess.barracuda.com [209.222.82.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5773C42045
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 May 2024 19:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717011255; cv=fail; b=PuSylfZBpy55rv0+ItOffyYBX3XUH99KVljHb/GQwgesdYAdT1m0meJZ28zYEWFeKJthi4a1W62+zQcoN1shBRqm9KRBWJRdrXGCSJctjvuWKhu2pPECrin3Z3NpjZmcevbDdY0p056IRn7bmfr/FV49jom62ccxUDlEWzKgXJ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717011255; c=relaxed/simple;
	bh=/pLIyPnvASdj64wbsfVkAhSoyaqRjGH28OSgLGgAZtQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=gtN5GGNF/4bb7lLEKZCLn2HLlN6fgREVIttbrZYoNWq4I1gfmwL2F9viey5BeLApwN7+L2NslHOyyT1sHM6AelpJqCz0dCP5/11BlW/daU4Db7TW+GqmCmo0LWYyVT/wZqv1mxFIIstc7eWFPd+kLEwR62ejDzSereltkTlN6Yc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=m0Ks7pmV; arc=fail smtp.client-ip=209.222.82.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101]) by mx-outbound22-6.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 29 May 2024 19:34:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GwsGQSkEqAvBfAQgez7/sOOmWxZ+AIpCRaf0YXJaaczpWJFlffmdVLaPtwJHH3Fy2QY5477qQsv4zuGcMoLdVMCWtzPt+XRWKjEa+QloW9h1d9gqBx/E4WVMogsKd7U2jP/6pZCXwc3uaD5u5eG5Sat0ThbHZJKDLbOMAhuX0uVNp2uf0biw2uQbf0ZA789mEweKVxkZclHS7hNqwfBiVOQZgQ4y4jECAg2WpxHDS4C3qVooPjB0rK2UHCYgC+Dk9NdHwpk1MsfaFB57rVqOqLt6QPPm8JyrCPWlbjwkxthNqa5hBCEBgw4kxZWKhx3Gxsgd/RLQ0MiszkrUbiOMrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ty0yFi5Cn7xiCqb9JGfMVtY+eoKue0HUdd+30MJ2MB8=;
 b=ANmGI1AEqsn95226AiMUL3a9JN5TqfEYBcVA9RUJ3gJYrMQyzPXqttB5ALVY88wkQHvN+cP2IU+bno2Vy8x7VgLdNnQZLvrmidEEXxRtw9IEuv1YhR4inTdwbGJ2LKIzpFGxHLJCVDDQgvx/f7ZxVWWtVwK0WBi4UhSEjhpKctsVMTE0GT+Xv6943wVB5LaZUYvfgh88JB7OxSb1YI+lhsRzprghtlOTMSPkfKbKdZ2geAAJdNL65jsJvd3/J3Eb1AZtZzf556wIRYCBEKVO0/sundhAOcXqgblWVo8oPlmXy1hM+LYsNUYPh+ZEFU7iRW7YxYYWoW95nfTIX6RgsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ty0yFi5Cn7xiCqb9JGfMVtY+eoKue0HUdd+30MJ2MB8=;
 b=m0Ks7pmVCjQByFKoZ3TDNs54BK5cSoopn3fIXbb7AJ8++jizkR4fXr29rN1dlfPB1VnNR5oGN8N62DomizijnXIZeAr23arg/BizfAkMwKxxYDj5/pQBo/XqzWwKt0YnIMtLsSIH5xBDzslLiDOWKLE+V2mYlR4yeSlO6qfgS5k=
Received: from BYAPR01CA0056.prod.exchangelabs.com (2603:10b6:a03:94::33) by
 BY1PR19MB7775.namprd19.prod.outlook.com (2603:10b6:a03:523::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.17; Wed, 29 May
 2024 18:01:03 +0000
Received: from SJ1PEPF00002317.namprd03.prod.outlook.com
 (2603:10b6:a03:94:cafe::a3) by BYAPR01CA0056.outlook.office365.com
 (2603:10b6:a03:94::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30 via Frontend
 Transport; Wed, 29 May 2024 18:01:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 SJ1PEPF00002317.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7633.15
 via Frontend Transport; Wed, 29 May 2024 18:01:03 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id DB2B927;
	Wed, 29 May 2024 18:01:02 +0000 (UTC)
From: Bernd Schubert <bschubert@ddn.com>
Date: Wed, 29 May 2024 20:00:49 +0200
Subject: [PATCH RFC v2 14/19] fuse: {uring} Allow to queue to the ring
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240529-fuse-uring-for-6-9-rfc2-out-v1-14-d149476b1d65@ddn.com>
References: <20240529-fuse-uring-for-6-9-rfc2-out-v1-0-d149476b1d65@ddn.com>
In-Reply-To: <20240529-fuse-uring-for-6-9-rfc2-out-v1-0-d149476b1d65@ddn.com>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
 linux-fsdevel@vger.kernel.org, Bernd Schubert <bschubert@ddn.com>, 
 bernd.schubert@fastmail.fm
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717005648; l=12157;
 i=bschubert@ddn.com; s=20240529; h=from:subject:message-id;
 bh=/pLIyPnvASdj64wbsfVkAhSoyaqRjGH28OSgLGgAZtQ=;
 b=XtgRgTtjIPhL5rMlpoFzdZfD56yCA04HrayoANUNDG0S45+YhC4oUVPXYdpKXn5jiOjR3HyZ7
 LNFEWbbVTH7C9av34wbArqibGrK+92KMxY5xD5vcPeXA7UwwhluHl5W
X-Developer-Key: i=bschubert@ddn.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002317:EE_|BY1PR19MB7775:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bc15e17-da03-4ca2-6192-08dc80094e52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|376005|1800799015|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z011L05VeU9uWWY4MzdJTEFTcFRtdHNBa2NtZi9qcWZGQ2hjcXZhRzlWdmJp?=
 =?utf-8?B?bHBnWlB1em9NdU1CT09laGlEQ2Zta1VRVC9hcmp1R3pIN0pBTENVTlU1aGJB?=
 =?utf-8?B?QW5UaCtrdmgvNUdVTzdWOUloYUJnTVE3NVN2SGxoSytydHpJNmhTTDJDZitD?=
 =?utf-8?B?cFh5ZnVEV1N3VjVwL3FSNGU3ejBhWnhMRXRrWmw2QUprUGJWSkJBUWY3WkJ1?=
 =?utf-8?B?K2JHM2xYc1FHMEkwcU1IaU16bncwWU13YnRDVzF5ZGtUYi8yZXJUQTBRd3Ru?=
 =?utf-8?B?blg5ZkJkRWxVcmgvWDVlRWJvYmhwdCtGazc1Ulk5S21LcjhFQU85R3VkaHpM?=
 =?utf-8?B?S3lzZTRpZmI0Rkx3M1QybHdsV2c5QjFDdEl4ZktCblFnYVBXUGlGbHhia2Nm?=
 =?utf-8?B?QVRyV2xVd1JKVXg1UmIwdE1rV2JlU1RUdXV0Z0ZYTmdPZFh4RCs1K2xvSDVT?=
 =?utf-8?B?eFVHalgrN0trNXkrVjlCSlkzSThzNjhmRjFQaG4zT2x5ZEVRR0dJUTlEWFdn?=
 =?utf-8?B?b09EaG4rUUZpd2sxaC9ITkUwektHcFJUYXJTZXd3aGNZOWU0SDNsYUlNM2lX?=
 =?utf-8?B?cC9YOG0vWVZGalRzQm1BQzg4WU1aQVZkTmRxZE5PMks4VXZTVFFDc0pZLzR0?=
 =?utf-8?B?eFNrc0hCTlJhSlVPVlQxaWxCNkl0OXNLaUY2WCtkRlBFaHg1dlFvYXU1ZVhT?=
 =?utf-8?B?RzhpMWg3Nm91RGVEN0NLT3F4OWptRnpBWS9GN0d0UHlQdDMvRU4vdW9ySk9L?=
 =?utf-8?B?ZkMzUmkrTU0zLzBORXNNbWxsK2t5RWI1bHowQWZRY2M5eXlKWGtaMWs2YlVE?=
 =?utf-8?B?UmV3ZldyaXVlendmUC9jTWlPKytqQTNnY1M5Tms4NCtEMXJHTjNXMEp3cysy?=
 =?utf-8?B?NG13WVNRSzVWczdCa2p4aUVNRFZ1L3dWQ1R4M3d5a3NzSEFVbm1kZHJwZ1Nr?=
 =?utf-8?B?dlNEaE5aekE1enp5NXZ4Y0h6Z2lGeFJFZjVqNEl0Qnp4VWtlZHZCQ1lENnNR?=
 =?utf-8?B?QUhmSnRmenJxMlpzZ0NwS1FxNUMxeS9iQzNySGZ6dmhLYm53djhKT0FxdTlZ?=
 =?utf-8?B?aHV2TmtFZWs2MEF0YlFNYWNqZFNUcWVkbXRmOG1xUEdVSGJyTjN1WDBBeUla?=
 =?utf-8?B?ditwZnQxeGF1clFETEY2VUx5aXBVSFprSTFUTm5UaHF1SmRDU3pXaE1lT3kz?=
 =?utf-8?B?QUN1VGJmNlN1Q0JyeGdONmVIQXpxd3ZjbGNoT2w2SkQyeWJTWGhKSGtROGJW?=
 =?utf-8?B?TVdCVjY4VXg4WGdyOHA3T0t4VjZ5M1BoTDBoZ25RNUNDbFlBaWJ2U1RCVjdH?=
 =?utf-8?B?MFYxK0d6elU1SUJFbVZlMTkyNGFHVURTbzhNNnpubGNQVTJzWWh4UWxWWTkr?=
 =?utf-8?B?eHlIaDJzSW1aTnAzUVNBT1pGYUE5SFRhUzhmNnlqclBia3Y2dEZrZTRHVDd3?=
 =?utf-8?B?UVFUU2FnVHdjVjJML3RKK3ZaMkk1cHFpZGV1VGx6SDhJaktkc295ZXJoVTRY?=
 =?utf-8?B?Z2UvQjdTU3ZXcDV4QWZUMUxoRzNjZGpiWFNIcDBVVCtwZ0ZYakd6MkNSaGZn?=
 =?utf-8?B?Y3Q0c2Znb0RSM3ZVQ0tqZTFFbzcyL2dNNXU0L2FMc0M2emwvV1ZPRU5lOW5F?=
 =?utf-8?B?SGk4elBicktwb1k5M3kxbXh3d1dtWUczdmhYeXE2d0ZaVWpZN2VoUDdoZ2dC?=
 =?utf-8?B?VG5kZ2Q2ejR5YWlxQzEvWVU4TnRxdXNHeGoxZmZXVmtnR3k5OXNiVjlzMTBk?=
 =?utf-8?B?TGRmazBCTnhGbVNsZDNlbE5BOGY3ZEZnY3JMbGhTSCttV1BWakdOYnlMZTRo?=
 =?utf-8?B?d1lRYTBLaDJMT2JibUZzbFhPSU9qaEtoUVdQNHMyZ1ZMUGNNTlJ2c1hhc1JX?=
 =?utf-8?Q?l9XqcJhIwjWwG?=
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400017)(376005)(1800799015)(36860700004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	AyseixRltHjlva0lM3XP+FnsoFaRh57nOEIj3bZ7pyyY8o2uowO+Mww1s6734t+tZGXetjo6nBot4BSLL35aLy2S1TIhXIe49eub4U2q77/4qA7gC/1Evt6pSl8FP+04GGZsnCmYvd8Iq/HODT7ORnxjIKgA7A6B+vx57wZi7w0Am4VEcDQIreIIlXXarlZFcfPAYXNbwJDpiwLJeEe4+DJy0rak0kYaD8lnL9M7sTw7NyGkj5HgkICoKvYSksFw1q/xRSLaHN/DWOv9pdiI2x4oc4LuVUvNhkco+P3Kh9Y1oYARlAICTDUyxpVEopZp86JfSrmRdVPD2pdbf8+HrO5yYZUmH5D1xOqM4erHT7TJcBlC955jLlp/91Yc7mvCyDtJO0n3kD72JSPmN/6dToBl5odMnNnWadu47vJimgeY987E8ARGHBrSLt/S+fqhhvJMEo1/hnygOGEJJjewb+5/Tn+vWzoDmWI6MOwQuzD4NvAK6mckPeh7S7UpPCfXHvf8X0M8iRKpx9WNT0v02jgh6t5TALwVOuUDDcbrVBZJXyw7GZYi6r/VXGT0k/KK/gNF/d/3kT36yoIVMqqKCSpmLlefKuPF2assTlrrzA5WVe5O4jepvzkSKYN6bUG+8cVYqX0umIdjrg625124hg==
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 18:01:03.5756
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bc15e17-da03-4ca2-6192-08dc80094e52
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002317.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR19MB7775
X-OriginatorOrg: ddn.com
X-BESS-ID: 1717011249-105638-25772-13383-1
X-BESS-VER: 2019.1_20240429.2309
X-BESS-Apparent-Source-IP: 104.47.58.101
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoaG5hZGQGYGUNQ0xSzFIiUlyT
	zFMjUx1TgxxTAlJS3J1NzULMnQIjnVXKk2FgAMatQKQgAAAA==
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.256586 [from 
	cloudscan13-62.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
	0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, BSF_SC0_MISMATCH_TO
X-BESS-BRTS-Status:1

This enables enqueuing requests through fuse uring queues.

For initial simplicity requests are always allocated the normal way
then added to ring queues lists and only then copied to ring queue
entries. Later on the allocation and adding the requests to a list
can be avoided, by directly using a ring entry. This introduces
some code complexity and is therefore not done for now.

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
 fs/fuse/dev.c         | 80 +++++++++++++++++++++++++++++++++++++++-----
 fs/fuse/dev_uring.c   | 92 ++++++++++++++++++++++++++++++++++++++++++---------
 fs/fuse/dev_uring_i.h | 17 ++++++++++
 3 files changed, 165 insertions(+), 24 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 6ffd216b27c8..c7fd3849a105 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -218,13 +218,29 @@ const struct fuse_iqueue_ops fuse_dev_fiq_ops = {
 };
 EXPORT_SYMBOL_GPL(fuse_dev_fiq_ops);
 
-static void queue_request_and_unlock(struct fuse_iqueue *fiq,
-				     struct fuse_req *req)
+
+static void queue_request_and_unlock(struct fuse_conn *fc,
+				     struct fuse_req *req, bool allow_uring)
 __releases(fiq->lock)
 {
+	struct fuse_iqueue *fiq = &fc->iq;
+
 	req->in.h.len = sizeof(struct fuse_in_header) +
 		fuse_len_args(req->args->in_numargs,
 			      (struct fuse_arg *) req->args->in_args);
+
+	if (allow_uring && fuse_uring_ready(fc)) {
+		int res;
+
+		/* this lock is not needed at all for ring req handling */
+		spin_unlock(&fiq->lock);
+		res = fuse_uring_queue_fuse_req(fc, req);
+		if (!res)
+			return;
+
+		/* fallthrough, handled through /dev/fuse read/write */
+	}
+
 	list_add_tail(&req->list, &fiq->pending);
 	fiq->ops->wake_pending_and_unlock(fiq);
 }
@@ -261,7 +277,7 @@ static void flush_bg_queue(struct fuse_conn *fc)
 		fc->active_background++;
 		spin_lock(&fiq->lock);
 		req->in.h.unique = fuse_get_unique(fiq);
-		queue_request_and_unlock(fiq, req);
+		queue_request_and_unlock(fc, req, true);
 	}
 }
 
@@ -405,7 +421,8 @@ static void request_wait_answer(struct fuse_req *req)
 
 static void __fuse_request_send(struct fuse_req *req)
 {
-	struct fuse_iqueue *fiq = &req->fm->fc->iq;
+	struct fuse_conn *fc = req->fm->fc;
+	struct fuse_iqueue *fiq = &fc->iq;
 
 	BUG_ON(test_bit(FR_BACKGROUND, &req->flags));
 	spin_lock(&fiq->lock);
@@ -417,7 +434,7 @@ static void __fuse_request_send(struct fuse_req *req)
 		/* acquire extra reference, since request is still needed
 		   after fuse_request_end() */
 		__fuse_get_request(req);
-		queue_request_and_unlock(fiq, req);
+		queue_request_and_unlock(fc, req, true);
 
 		request_wait_answer(req);
 		/* Pairs with smp_wmb() in fuse_request_end() */
@@ -487,6 +504,10 @@ ssize_t fuse_simple_request(struct fuse_mount *fm, struct fuse_args *args)
 	if (args->force) {
 		atomic_inc(&fc->num_waiting);
 		req = fuse_request_alloc(fm, GFP_KERNEL | __GFP_NOFAIL);
+		if (unlikely(!req)) {
+			ret = -ENOTCONN;
+			goto err;
+		}
 
 		if (!args->nocreds)
 			fuse_force_creds(req);
@@ -514,16 +535,55 @@ ssize_t fuse_simple_request(struct fuse_mount *fm, struct fuse_args *args)
 	}
 	fuse_put_request(req);
 
+err:
 	return ret;
 }
 
-static bool fuse_request_queue_background(struct fuse_req *req)
+static bool fuse_request_queue_background_uring(struct fuse_conn *fc,
+					       struct fuse_req *req)
+{
+	struct fuse_iqueue *fiq = &fc->iq;
+	int err;
+
+	req->in.h.unique = fuse_get_unique(fiq);
+	req->in.h.len = sizeof(struct fuse_in_header) +
+		fuse_len_args(req->args->in_numargs,
+			      (struct fuse_arg *) req->args->in_args);
+
+	err = fuse_uring_queue_fuse_req(fc, req);
+	if (!err) {
+		/* XXX remove and lets the users of that use per queue values -
+		 * avoid the shared spin lock...
+		 * Is this needed at all?
+		 */
+		spin_lock(&fc->bg_lock);
+		fc->num_background++;
+		fc->active_background++;
+
+
+		/* XXX block when per ring queues get occupied */
+		if (fc->num_background == fc->max_background)
+			fc->blocked = 1;
+		spin_unlock(&fc->bg_lock);
+	}
+
+	return err ? false : true;
+}
+
+/*
+ * @return true if queued
+ */
+static int fuse_request_queue_background(struct fuse_req *req)
 {
 	struct fuse_mount *fm = req->fm;
 	struct fuse_conn *fc = fm->fc;
 	bool queued = false;
 
 	WARN_ON(!test_bit(FR_BACKGROUND, &req->flags));
+
+	if (fuse_uring_ready(fc))
+		return fuse_request_queue_background_uring(fc, req);
+
 	if (!test_bit(FR_WAITING, &req->flags)) {
 		__set_bit(FR_WAITING, &req->flags);
 		atomic_inc(&fc->num_waiting);
@@ -576,7 +636,8 @@ static int fuse_simple_notify_reply(struct fuse_mount *fm,
 				    struct fuse_args *args, u64 unique)
 {
 	struct fuse_req *req;
-	struct fuse_iqueue *fiq = &fm->fc->iq;
+	struct fuse_conn *fc = fm->fc;
+	struct fuse_iqueue *fiq = &fc->iq;
 	int err = 0;
 
 	req = fuse_get_req(fm, false);
@@ -590,7 +651,8 @@ static int fuse_simple_notify_reply(struct fuse_mount *fm,
 
 	spin_lock(&fiq->lock);
 	if (fiq->connected) {
-		queue_request_and_unlock(fiq, req);
+		/* uring for notify not supported yet */
+		queue_request_and_unlock(fc, req, false);
 	} else {
 		err = -ENODEV;
 		spin_unlock(&fiq->lock);
@@ -2205,6 +2267,7 @@ void fuse_abort_conn(struct fuse_conn *fc)
 		fuse_uring_set_stopped(fc);
 
 		fuse_set_initialized(fc);
+
 		list_for_each_entry(fud, &fc->devices, entry) {
 			struct fuse_pqueue *fpq = &fud->pq;
 
@@ -2478,6 +2541,7 @@ static long fuse_uring_ioctl(struct file *file, __u32 __user *argp)
 		if (res != 0)
 			return res;
 		break;
+
 		case FUSE_URING_IOCTL_CMD_QUEUE_CFG:
 			fud->uring_dev = 1;
 			res = fuse_uring_queue_cfg(fc->ring, &cfg.qconf);
diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index 6001ba4d6e82..fe80e66150c3 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -32,8 +32,7 @@
 #include <linux/io_uring/cmd.h>
 
 static void fuse_uring_req_end_and_get_next(struct fuse_ring_ent *ring_ent,
-					    bool set_err, int error,
-					    unsigned int issue_flags);
+					    bool set_err, int error);
 
 static void fuse_ring_ring_ent_unset_userspace(struct fuse_ring_ent *ent)
 {
@@ -683,8 +682,7 @@ static int fuse_uring_copy_to_ring(struct fuse_ring *ring, struct fuse_req *req,
  * userspace will read it
  * This is comparable with classical read(/dev/fuse)
  */
-static void fuse_uring_send_to_ring(struct fuse_ring_ent *ring_ent,
-				    unsigned int issue_flags, bool send_in_task)
+static void fuse_uring_send_to_ring(struct fuse_ring_ent *ring_ent)
 {
 	struct fuse_ring *ring = ring_ent->queue->ring;
 	struct fuse_ring_req *rreq = ring_ent->rreq;
@@ -721,20 +719,17 @@ static void fuse_uring_send_to_ring(struct fuse_ring_ent *ring_ent,
 	rreq->in = req->in.h;
 	set_bit(FR_SENT, &req->flags);
 
-	pr_devel("%s qid=%d tag=%d state=%lu cmd-done op=%d unique=%llu issue_flags=%u\n",
+	pr_devel("%s qid=%d tag=%d state=%lu cmd-done op=%d unique=%llu\n",
 		 __func__, ring_ent->queue->qid, ring_ent->tag, ring_ent->state,
-		 rreq->in.opcode, rreq->in.unique, issue_flags);
+		 rreq->in.opcode, rreq->in.unique);
 
-	if (send_in_task)
-		io_uring_cmd_complete_in_task(ring_ent->cmd,
-					      fuse_uring_async_send_to_ring);
-	else
-		io_uring_cmd_done(ring_ent->cmd, 0, 0, issue_flags);
+	io_uring_cmd_complete_in_task(ring_ent->cmd,
+				      fuse_uring_async_send_to_ring);
 
 	return;
 
 err:
-	fuse_uring_req_end_and_get_next(ring_ent, true, err, issue_flags);
+	fuse_uring_req_end_and_get_next(ring_ent, true, err);
 }
 
 /*
@@ -811,8 +806,7 @@ static bool fuse_uring_ent_release_and_fetch(struct fuse_ring_ent *ring_ent)
  * has lock/unlock/lock to avoid holding the lock on calling fuse_request_end
  */
 static void fuse_uring_req_end_and_get_next(struct fuse_ring_ent *ring_ent,
-					    bool set_err, int error,
-					    unsigned int issue_flags)
+					    bool set_err, int error)
 {
 	struct fuse_req *req = ring_ent->fuse_req;
 	int has_next;
@@ -828,7 +822,7 @@ static void fuse_uring_req_end_and_get_next(struct fuse_ring_ent *ring_ent,
 	has_next = fuse_uring_ent_release_and_fetch(ring_ent);
 	if (has_next) {
 		/* called within uring context - use provided flags */
-		fuse_uring_send_to_ring(ring_ent, issue_flags, false);
+		fuse_uring_send_to_ring(ring_ent);
 	}
 }
 
@@ -863,7 +857,7 @@ static void fuse_uring_commit_and_release(struct fuse_dev *fud,
 out:
 	pr_devel("%s:%d ret=%zd op=%d req-ret=%d\n", __func__, __LINE__, err,
 		 req->args->opcode, req->out.h.error);
-	fuse_uring_req_end_and_get_next(ring_ent, set_err, err, issue_flags);
+	fuse_uring_req_end_and_get_next(ring_ent, set_err, err);
 }
 
 /*
@@ -1101,3 +1095,69 @@ int fuse_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags)
 	goto out;
 }
 
+int fuse_uring_queue_fuse_req(struct fuse_conn *fc, struct fuse_req *req)
+{
+	struct fuse_ring *ring = fc->ring;
+	struct fuse_ring_queue *queue;
+	int qid = 0;
+	struct fuse_ring_ent *ring_ent = NULL;
+	int res;
+	bool async = test_bit(FR_BACKGROUND, &req->flags);
+	struct list_head *req_queue, *ent_queue;
+
+	if (ring->per_core_queue) {
+		/*
+		 * async requests are best handled on another core, the current
+		 * core can do application/page handling, while the async request
+		 * is handled on another core in userspace.
+		 * For sync request the application has to wait - no processing, so
+		 * the request should continue on the current core and avoid context
+		 * switches.
+		 * XXX This should be on the same numa node and not busy - is there
+		 * a scheduler function available  that could make this decision?
+		 * It should also not persistently switch between cores - makes
+		 * it hard for the scheduler.
+		 */
+		qid = task_cpu(current);
+
+		if (unlikely(qid >= ring->nr_queues)) {
+			WARN_ONCE(1,
+				  "Core number (%u) exceeds nr ueues (%zu)\n",
+				  qid, ring->nr_queues);
+			qid = 0;
+		}
+	}
+
+	queue = fuse_uring_get_queue(ring, qid);
+	req_queue = async ? &queue->async_fuse_req_queue :
+			    &queue->sync_fuse_req_queue;
+	ent_queue = async ? &queue->async_ent_avail_queue :
+			    &queue->sync_ent_avail_queue;
+
+	spin_lock(&queue->lock);
+
+	if (unlikely(queue->stopped)) {
+		res = -ENOTCONN;
+		goto err_unlock;
+	}
+
+	if (list_empty(ent_queue)) {
+		list_add_tail(&req->list, req_queue);
+	} else {
+		ring_ent =
+			list_first_entry(ent_queue, struct fuse_ring_ent, list);
+		list_del(&ring_ent->list);
+		fuse_uring_add_req_to_ring_ent(ring_ent, req);
+	}
+	spin_unlock(&queue->lock);
+
+	if (ring_ent != NULL)
+		fuse_uring_send_to_ring(ring_ent);
+
+	return 0;
+
+err_unlock:
+	spin_unlock(&queue->lock);
+	return res;
+}
+
diff --git a/fs/fuse/dev_uring_i.h b/fs/fuse/dev_uring_i.h
index e5fc84e2f3ea..5d7e1e6e7a82 100644
--- a/fs/fuse/dev_uring_i.h
+++ b/fs/fuse/dev_uring_i.h
@@ -208,6 +208,7 @@ int fuse_uring_queue_cfg(struct fuse_ring *ring,
 void fuse_uring_ring_destruct(struct fuse_ring *ring);
 void fuse_uring_stop_queues(struct fuse_ring *ring);
 int fuse_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags);
+int fuse_uring_queue_fuse_req(struct fuse_conn *fc, struct fuse_req *req);
 
 static inline void fuse_uring_conn_init(struct fuse_ring *ring,
 					struct fuse_conn *fc)
@@ -331,6 +332,11 @@ static inline void fuse_uring_wait_stopped_queues(struct fuse_conn *fc)
 			   atomic_read(&ring->queue_refs) == 0);
 }
 
+static inline bool fuse_uring_ready(struct fuse_conn *fc)
+{
+	return fc->ring && fc->ring->ready;
+}
+
 #else /* CONFIG_FUSE_IO_URING */
 
 struct fuse_ring;
@@ -366,6 +372,17 @@ static inline void fuse_uring_wait_stopped_queues(struct fuse_conn *fc)
 {
 }
 
+static inline bool fuse_uring_ready(struct fuse_conn *fc)
+{
+	return false;
+}
+
+static inline int
+fuse_uring_queue_fuse_req(struct fuse_conn *fc, struct fuse_req *req)
+{
+	return -EPFNOSUPPORT;
+}
+
 #endif /* CONFIG_FUSE_IO_URING */
 
 #endif /* _FS_FUSE_DEV_URING_I_H */

-- 
2.40.1


