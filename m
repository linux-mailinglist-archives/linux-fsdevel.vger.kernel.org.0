Return-Path: <linux-fsdevel+bounces-20472-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 404638D3E6B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 20:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98256B22F26
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 18:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F381C2316;
	Wed, 29 May 2024 18:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="f1RAq/Mo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip191a.ess.barracuda.com (outbound-ip191a.ess.barracuda.com [209.222.82.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96311C230A
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 May 2024 18:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717007668; cv=fail; b=dZw4GlbAMMVM6nIcFVHabMGnr5fJ8sdXH3iqG1suooqNbvYhDTSsgfZPSpPoWIFvK/gWjQmO3jJL4kP+SW2nhF/nt4HiQLwogUabAVFA25VBle73rxYb5CEYb2ZIXL/7Ii8/gRMtlsoQb433ZLSXFLXcLOaAm3iKQ8wkySSPRBI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717007668; c=relaxed/simple;
	bh=CcNl+4uTqsWv/7y+EkzMH+0ATQoShxOMuW8cNxxdZ7Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=Ll2agXQrD1lqnhr3HXQ0/Wj+imAHbMszsKr/Qkj/Q1OOpF56rdHcYIanHzTAlxXQjMLduQUIK/MyF8gdTYjZNQ5/w5TmHTUYWvPPx6oA75ZsG1CSPisRP8AvnhZwsZtOMie8O/ZvCpSqyLzhEUzN9gsPDEIquSvOPp8eSBzugoE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=f1RAq/Mo; arc=fail smtp.client-ip=209.222.82.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168]) by mx-outbound42-232.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 29 May 2024 18:34:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C4zzMH1PgZcMCFoui3rjEtsp+KlrIibhlcT5C8YnrnCRNoNBTeExbA/+NZjssYLsOXJRaNngB8ya0Kc2PtsxIbwFIPsduvA1+f4mlMGrgOb1e8uIA8zflA0qQdrCQik5EJ5rqBhbq4oJJM/TdEIGBgyNcD5Xb2cUHdmSQN8adg2p97umjpJQW/jW8UJnH33WEnbFWtNxEFvE7AFo9yR7uGbOiX90jaDkDWqM9z5HtTFz7zx+GoFZH357vFB67zn+gssTZXfTyMtPqpknPxyRhbMLKxioW8kxQNtn/PrUyE5d4m3XVroXZEoGOLP/IQhVPQa934qMxWxfD6Mi8mTLKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RNT+UV/N3hr4vIJIzccOWfOyrxWrlI6C93qZpFpW9jw=;
 b=LAOjynm10bfX0BUZl4fb70RE7PYhTQ7gipVXCvtm36DkiRvs413CYQ8aAKyIzvIiRBIzV7t/dyNYwuazEIrRPyU+CckUu3n/iNn7FXR3SU8I+WyJMuFof8p+74TN0fwmT39zzPZOU4T84yR154S9708NAzlmmmiKYAIGB/ZgdThuxIw2vmoC1wfH9c9dMJzi6LI1oFX2wFa5H/E5lqev0Cn0D+wDYY3FnHOCaHsnZq+6DgcJ5MsmY/Mfc31tkFTj+yzJlO1FbKKA82cgmsuU4O+rE/VkHmOAcLkMx/DxpOAyDgaxGD8l6RUtQj66d2K/rm292y/YF3/yKHlrj3QFCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RNT+UV/N3hr4vIJIzccOWfOyrxWrlI6C93qZpFpW9jw=;
 b=f1RAq/Mo8vD5TgNlu9ZhkxFwTcH2IKhXe6PiaZF6hc9It0iJMOoXbQEDq9HMGROk6kDdwCb4DsJNgz6YHmhIhB+0T8Zs34tK0APk1sN72t02U3GlUm2Gs4XILgWi4HtIe3Z7gStDt1IzcaqTrZvHZXC/vw/Lc1+I2QCzhk9Qxyk=
Received: from CY5PR18CA0021.namprd18.prod.outlook.com (2603:10b6:930:5::9) by
 DS7PR19MB5902.namprd19.prod.outlook.com (2603:10b6:8:7d::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.17; Wed, 29 May 2024 18:01:01 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:930:5:cafe::15) by CY5PR18CA0021.outlook.office365.com
 (2603:10b6:930:5::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30 via Frontend
 Transport; Wed, 29 May 2024 18:01:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7633.15
 via Frontend Transport; Wed, 29 May 2024 18:01:01 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id EA6914A7;
	Wed, 29 May 2024 18:01:00 +0000 (UTC)
From: Bernd Schubert <bschubert@ddn.com>
Date: Wed, 29 May 2024 20:00:47 +0200
Subject: [PATCH RFC v2 12/19] fuse: {uring} Add uring sqe commit and fetch
 support
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240529-fuse-uring-for-6-9-rfc2-out-v1-12-d149476b1d65@ddn.com>
References: <20240529-fuse-uring-for-6-9-rfc2-out-v1-0-d149476b1d65@ddn.com>
In-Reply-To: <20240529-fuse-uring-for-6-9-rfc2-out-v1-0-d149476b1d65@ddn.com>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
 linux-fsdevel@vger.kernel.org, Bernd Schubert <bschubert@ddn.com>, 
 bernd.schubert@fastmail.fm
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717005648; l=10804;
 i=bschubert@ddn.com; s=20240529; h=from:subject:message-id;
 bh=CcNl+4uTqsWv/7y+EkzMH+0ATQoShxOMuW8cNxxdZ7Y=;
 b=1t06uYdiOnqSWK6L83bgG+n3vXy8pgvag0ewKOfcjVp+SWF5HHPGjTbEBgYFsiMdBbpBKasle
 3/nDd1eFP3/AbewAB81K3N2bZB3sijq7mbO73UuXPKI/LsHhsHfVgAg
X-Developer-Key: i=bschubert@ddn.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|DS7PR19MB5902:EE_
X-MS-Office365-Filtering-Correlation-Id: 3525fe56-4137-4819-e507-08dc80094d0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|1800799015|36860700004|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bUVUMEYwaEtWeHE5Wkd6Vjl6QUxpWUg1dDNCbnIrRkRIcUVadmpML3FOaThB?=
 =?utf-8?B?YitrVjQ4ck55bXVud1pDdjFZWjE4eFFxUWpKdkg3TXRKU1BlT25KRVpTTzlI?=
 =?utf-8?B?VitWSWs1czF4Ri9rWi9NbUt6V0k3T3Vwa2lvRFh2aUh3bjBqYUNGNi9sWjlP?=
 =?utf-8?B?bnRhYk5aMDFPVEFSaExFY0FSN09CNkhra1Q2dGtMeE8wLzRIY0xhcDdHV0Mv?=
 =?utf-8?B?VnAvSjZwanZESlc1Y2ZMeXE5UmFtbXhFMlFUV1Vrc0R0OTRIcnp4ZCtKRDFP?=
 =?utf-8?B?Znl2b1RaMlBjdFJUamRXUTBnNHN0NU9pcERjV2oyV3p3d0hDNDEwMmhFcFYx?=
 =?utf-8?B?SHZOeTBFNmI5K0ExeFZaZGpZc3BzRjY4emdaUlRUZkRTanJYMDY4T09pOW9B?=
 =?utf-8?B?YzBESU94RitzN1VLNVNvMUFZdFluUXZUUE9ZTlZNN0xYdUJPeFkrNkdISFhy?=
 =?utf-8?B?bW41alBIZC9JUFNmQjFEbE1FQ1JyRTJ1a1dlN1Y1Q0VZckFhWFI1WTl1Q2RD?=
 =?utf-8?B?Z1M2dGsxd3VieFhGS2xkTUJwOUN0ZkVQTzBzcG1oQnFZeWN2U2JpY0J3c05T?=
 =?utf-8?B?aFlaU2lKNFk4OW4zaUt3Yjk2SXhOUk9DRDBnUUJCb2dEdFNZQnJxSUNVMnZB?=
 =?utf-8?B?U2YzMzRDUGVCKzRORWJmUVJJcFB5b0VFa1hLWUxkaTROUWNTMkxqWWJBUnFu?=
 =?utf-8?B?QzljZU0reDl5MFh2d1FUT3lYUmN1dFpuTGZsbTBpL1ZueWY3KzBZdHMwazIv?=
 =?utf-8?B?OFVXekFCeGtjcjBaZ0lmV2E4NlNqTlVHQm5lNkMwbEdzMkV4Y2Fza01Nc1VZ?=
 =?utf-8?B?bzBZMWxqSGZOSVowMXp6Z3dsL3MzL1B2VHVFTDVxbUVaZ3IzZ2NvcVNhdWxB?=
 =?utf-8?B?TWp2WW5sT2JuNmFnSHdhOGNaWnBZOWhZZjNVakJiLzZvNENzakZpNTdXdVVC?=
 =?utf-8?B?czdtN0d2SCtHYnNxS1o1ZEdHalJtN1BDY0g1VGlvZDRvQ0FmR1dackVRSlov?=
 =?utf-8?B?NGhDMytDbnNCaGJZdFp4S1RxZGtUUUpENW1TQVZaL1NCSzNGZUthTGNCZW5W?=
 =?utf-8?B?TUZaVzcwK0VnT010UGxrQ3JOdFp4bnVUMFJ4NDY5WDc2cFE3LzhtWFUzZGx4?=
 =?utf-8?B?REI1QVlRcGQ4MXlJUVN2cjFyQ0lwMGRjUU5pYVVXdDc2ZWdubVV4VlhHeUVt?=
 =?utf-8?B?Slc5eUdER1I4R2hVYllxWFJFMzlxQXNHRURBbFJQTUJzU0RsNkxtRFF1cER6?=
 =?utf-8?B?LzBVSTRYNHhiVVA1Uk83YTBVOFhQSldIL3VETS9YOEEyVDUvQnpGL01GTHkw?=
 =?utf-8?B?OHZuL1lvNk0yMjVNUGI1MmJvaFNDbmRiYW9CMFZIU3hKclNVR2p4ZHg3T2ZD?=
 =?utf-8?B?RWdUdktYdnBSdDlBY0tjOGdTSHBaYVZjY09WT240UjYwOUxacVc4eitMMnlG?=
 =?utf-8?B?UUIxQldOQ2E1RGhXSG9PYVV4Y3FHeG9ZWDVuaFJxTE1hVUtnTVJ4ZW5jcUNL?=
 =?utf-8?B?ZE1MMWlIMm1qTXRXRlFlRGhyUnNLaWJZT0NDTUlYNWdGdkhPbWhtayt1RkMw?=
 =?utf-8?B?SWk5SXhYK2lLTktuNUV3bzJWczZ0bU9rMkdZWE5xc2t1MXRZczFmbUFQbGZZ?=
 =?utf-8?B?NlFiZm1nVWtwVTFWV0llNUFRdDRwcUF4S2xWQVd5RWVhV2RqaDZnN2FEVVFr?=
 =?utf-8?B?WnpVcWJsVC85WExjMUdlZ0pQS3ZGZ3k2VG01TDBuV2RQQW44aEdKSXRaVmJ4?=
 =?utf-8?B?c2dUZEd2RU1JdmxoK3I1eGZiKzNuTzZMelk5ZXRWOVpvOUp5TmxySkpUYlY1?=
 =?utf-8?B?U25pbUZGT2phcFUrbG1vOUVXZlU0N09LWmdoWndZMVJDZnNrcFZvK0ZXd2Y4?=
 =?utf-8?Q?7NhV1KgRP4hP3?=
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400017)(1800799015)(36860700004)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5n4tV6tMXqMjIa4tbJQH6NMorvoow+uKrvHfIam9IerE2YIXd1aA/fifgfxJD1CDpIaYeL+3rZ/G5HxBkPE3Mwan9WTKcAzodYmEUWc8WWp4bCJ2SMPd7ZI88TEt12yhaxHWCjT8vovJakmxsdE5PJNrefBDGWJp0msweSE+P+JFld2gM+ra67VO+YyfCYeQhsfcKQF81N5yFpvJuRQohJd6ioGGJMh62xgrKdI5SAnzQJVIQDp+WUzEI7LIgNvB9I+GE6TeTPilbHNVX+Mtd+4DvNdNyypboKjvNE5qiG2dO36llWk7ke1fHkSn/+Ae47tP0wMkp/uNVe/NbQfBmFXpzTj2TWQcNnM7BMIj2jNRJssU7wkgQoASnENZhFPcMo6obPNShpI/5V0KX+oaO5mrjmqQQzoNrCRxEmX63ysfYQzo1ImpDTph5PVOWWq2KqQT6eCizXgXmAT0nVJhSpfiR1Po/UqL9rC+r/awnCeXjlVHokagT39fXvYcJAc7+UIOQWjhRoHXhKzKQe6g9z+JwXyS8DQ1L/WWuZ6dBMYkd8WamQbUKddIk+A5jomwMPQ6sFOTGHcXzFc5dN36PpYcqjPMHUBt2kA3N5LCSlzv2CFdaVxd8vATpYSZ7/uYO9wt2yMPIIz/BmXTl6gX+Q==
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 18:01:01.5025
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3525fe56-4137-4819-e507-08dc80094d0e
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR19MB5902
X-OriginatorOrg: ddn.com
X-BESS-ID: 1717007664-110984-12677-56636-1
X-BESS-VER: 2019.1_20240429.2309
X-BESS-Apparent-Source-IP: 104.47.57.168
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoYGJsaWQGYGUNQiLdEiKc0sOd
	HA3Cwx1TglxSwx0cg4yTQpycjA1NjIVKk2FgDRJXdiQgAAAA==
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.256584 [from 
	cloudscan23-125.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
	0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, BSF_SC0_MISMATCH_TO
X-BESS-BRTS-Status:1

This adds support for fuse request completion through ring SQEs
(FUSE_URING_REQ_COMMIT_AND_FETCH handling). After committing
the ring entry it becomes available for new fuse requests.
Handling of requests through the ring (SQE/CQE handling)
is complete now.

Fuse request data are copied through the mmaped ring buffer,
there is no support for any zero copy yet.

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
 fs/fuse/dev_uring.c | 311 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 311 insertions(+)

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index 48b1118b64f4..5269b3f8891e 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -31,12 +31,23 @@
 #include <linux/topology.h>
 #include <linux/io_uring/cmd.h>
 
+static void fuse_uring_req_end_and_get_next(struct fuse_ring_ent *ring_ent,
+					    bool set_err, int error,
+					    unsigned int issue_flags);
+
 static void fuse_ring_ring_ent_unset_userspace(struct fuse_ring_ent *ent)
 {
 	clear_bit(FRRS_USERSPACE, &ent->state);
 	list_del_init(&ent->list);
 }
 
+static void
+fuse_uring_async_send_to_ring(struct io_uring_cmd *cmd,
+			      unsigned int issue_flags)
+{
+	io_uring_cmd_done(cmd, 0, 0, issue_flags);
+}
+
 /* Update conn limits according to ring values */
 static void fuse_uring_conn_cfg_limits(struct fuse_ring *ring)
 {
@@ -350,6 +361,188 @@ int fuse_uring_queue_cfg(struct fuse_ring *ring,
 	return 0;
 }
 
+/*
+ * Checks for errors and stores it into the request
+ */
+static int fuse_uring_ring_ent_has_err(struct fuse_ring *ring,
+				       struct fuse_ring_ent *ring_ent)
+{
+	struct fuse_conn *fc = ring->fc;
+	struct fuse_req *req = ring_ent->fuse_req;
+	struct fuse_out_header *oh = &req->out.h;
+	int err;
+
+	if (oh->unique == 0) {
+		/* Not supportd through request based uring, this needs another
+		 * ring from user space to kernel
+		 */
+		pr_warn("Unsupported fuse-notify\n");
+		err = -EINVAL;
+		goto seterr;
+	}
+
+	if (oh->error <= -512 || oh->error > 0) {
+		err = -EINVAL;
+		goto seterr;
+	}
+
+	if (oh->error) {
+		err = oh->error;
+		pr_devel("%s:%d err=%d op=%d req-ret=%d", __func__, __LINE__,
+			 err, req->args->opcode, req->out.h.error);
+		goto err; /* error already set */
+	}
+
+	if ((oh->unique & ~FUSE_INT_REQ_BIT) != req->in.h.unique) {
+		pr_warn("Unpexted seqno mismatch, expected: %llu got %llu\n",
+			req->in.h.unique, oh->unique & ~FUSE_INT_REQ_BIT);
+		err = -ENOENT;
+		goto seterr;
+	}
+
+	/* Is it an interrupt reply ID?	 */
+	if (oh->unique & FUSE_INT_REQ_BIT) {
+		err = 0;
+		if (oh->error == -ENOSYS)
+			fc->no_interrupt = 1;
+		else if (oh->error == -EAGAIN) {
+			/* XXX Interrupts not handled yet */
+			/* err = queue_interrupt(req); */
+			pr_warn("Intrerupt EAGAIN not supported yet");
+			err = -EINVAL;
+		}
+
+		goto seterr;
+	}
+
+	return 0;
+
+seterr:
+	pr_devel("%s:%d err=%d op=%d req-ret=%d", __func__, __LINE__, err,
+		 req->args->opcode, req->out.h.error);
+	oh->error = err;
+err:
+	pr_devel("%s:%d err=%d op=%d req-ret=%d", __func__, __LINE__, err,
+		 req->args->opcode, req->out.h.error);
+	return err;
+}
+
+/*
+ * Copy data from the ring buffer to the fuse request
+ */
+static int fuse_uring_copy_from_ring(struct fuse_ring *ring,
+				     struct fuse_req *req,
+				     struct fuse_ring_req *rreq)
+{
+	struct fuse_copy_state cs;
+	struct fuse_args *args = req->args;
+
+	fuse_copy_init(&cs, 0, NULL);
+	cs.is_uring = 1;
+	cs.ring.buf = rreq->in_out_arg;
+
+	if (rreq->in_out_arg_len > ring->req_arg_len) {
+		pr_devel("Max ring buffer len exceeded (%u vs %zu\n",
+			 rreq->in_out_arg_len, ring->req_arg_len);
+		return -EINVAL;
+	}
+	cs.ring.buf_sz = rreq->in_out_arg_len;
+	cs.req = req;
+
+	pr_devel("%s:%d buf=%p len=%d args=%d\n", __func__, __LINE__,
+		 cs.ring.buf, cs.ring.buf_sz, args->out_numargs);
+
+	return fuse_copy_out_args(&cs, args, rreq->in_out_arg_len);
+}
+
+/*
+ * Copy data from the req to the ring buffer
+ */
+static int fuse_uring_copy_to_ring(struct fuse_ring *ring, struct fuse_req *req,
+				   struct fuse_ring_req *rreq)
+{
+	struct fuse_copy_state cs;
+	struct fuse_args *args = req->args;
+	int err;
+
+	fuse_copy_init(&cs, 1, NULL);
+	cs.is_uring = 1;
+	cs.ring.buf = rreq->in_out_arg;
+	cs.ring.buf_sz = ring->req_arg_len;
+	cs.req = req;
+
+	pr_devel("%s:%d buf=%p len=%d args=%d\n", __func__, __LINE__,
+		 cs.ring.buf, cs.ring.buf_sz, args->out_numargs);
+
+	err = fuse_copy_args(&cs, args->in_numargs, args->in_pages,
+			     (struct fuse_arg *)args->in_args, 0);
+	rreq->in_out_arg_len = cs.ring.offset;
+
+	pr_devel("%s:%d buf=%p len=%d args=%d err=%d\n", __func__, __LINE__,
+		 cs.ring.buf, cs.ring.buf_sz, args->out_numargs, err);
+
+	return err;
+}
+
+/*
+ * Write data to the ring buffer and send the request to userspace,
+ * userspace will read it
+ * This is comparable with classical read(/dev/fuse)
+ */
+static void fuse_uring_send_to_ring(struct fuse_ring_ent *ring_ent,
+				    unsigned int issue_flags, bool send_in_task)
+{
+	struct fuse_ring *ring = ring_ent->queue->ring;
+	struct fuse_ring_req *rreq = ring_ent->rreq;
+	struct fuse_req *req = ring_ent->fuse_req;
+	struct fuse_ring_queue *queue = ring_ent->queue;
+	int err = 0;
+
+	spin_lock(&queue->lock);
+
+	if (WARN_ON(test_bit(FRRS_USERSPACE, &ring_ent->state) ||
+		   (test_bit(FRRS_FREED, &ring_ent->state)))) {
+		pr_err("qid=%d tag=%d ring-req=%p buf_req=%p invalid state %lu on send\n",
+		       queue->qid, ring_ent->tag, ring_ent, rreq,
+		       ring_ent->state);
+		err = -EIO;
+	} else {
+		set_bit(FRRS_USERSPACE, &ring_ent->state);
+		list_add(&ring_ent->list, &queue->ent_in_userspace);
+	}
+
+	spin_unlock(&queue->lock);
+	if (err)
+		goto err;
+
+	err = fuse_uring_copy_to_ring(ring, req, rreq);
+	if (unlikely(err)) {
+		spin_lock(&queue->lock);
+		fuse_ring_ring_ent_unset_userspace(ring_ent);
+		spin_unlock(&queue->lock);
+		goto err;
+	}
+
+	/* ring req go directly into the shared memory buffer */
+	rreq->in = req->in.h;
+	set_bit(FR_SENT, &req->flags);
+
+	pr_devel("%s qid=%d tag=%d state=%lu cmd-done op=%d unique=%llu issue_flags=%u\n",
+		 __func__, ring_ent->queue->qid, ring_ent->tag, ring_ent->state,
+		 rreq->in.opcode, rreq->in.unique, issue_flags);
+
+	if (send_in_task)
+		io_uring_cmd_complete_in_task(ring_ent->cmd,
+					      fuse_uring_async_send_to_ring);
+	else
+		io_uring_cmd_done(ring_ent->cmd, 0, 0, issue_flags);
+
+	return;
+
+err:
+	fuse_uring_req_end_and_get_next(ring_ent, true, err, issue_flags);
+}
+
 /*
  * Put a ring request onto hold, it is no longer used for now.
  */
@@ -381,6 +574,104 @@ static void fuse_uring_ent_avail(struct fuse_ring_ent *ring_ent,
 	set_bit(FRRS_WAIT, &ring_ent->state);
 }
 
+/*
+ * Assign a fuse queue entry to the given entry
+ */
+static void fuse_uring_add_req_to_ring_ent(struct fuse_ring_ent *ring_ent,
+					   struct fuse_req *req)
+{
+	clear_bit(FRRS_WAIT, &ring_ent->state);
+	list_del_init(&req->list);
+	clear_bit(FR_PENDING, &req->flags);
+	ring_ent->fuse_req = req;
+	set_bit(FRRS_FUSE_REQ, &ring_ent->state);
+}
+
+/*
+ * Release a uring entry and fetch the next fuse request if available
+ *
+ * @return true if a new request has been fetched
+ */
+static bool fuse_uring_ent_release_and_fetch(struct fuse_ring_ent *ring_ent)
+{
+	struct fuse_req *req = NULL;
+	struct fuse_ring_queue *queue = ring_ent->queue;
+	struct list_head *req_queue = ring_ent->async ?
+		&queue->async_fuse_req_queue : &queue->sync_fuse_req_queue;
+
+	spin_lock(&ring_ent->queue->lock);
+	fuse_uring_ent_avail(ring_ent, queue);
+	if (!list_empty(req_queue)) {
+		req = list_first_entry(req_queue, struct fuse_req, list);
+		fuse_uring_add_req_to_ring_ent(ring_ent, req);
+		list_del_init(&ring_ent->list);
+	}
+	spin_unlock(&ring_ent->queue->lock);
+
+	return req ? true : false;
+}
+
+/*
+ * Finalize a fuse request, then fetch and send the next entry, if available
+ *
+ * has lock/unlock/lock to avoid holding the lock on calling fuse_request_end
+ */
+static void fuse_uring_req_end_and_get_next(struct fuse_ring_ent *ring_ent,
+					    bool set_err, int error,
+					    unsigned int issue_flags)
+{
+	struct fuse_req *req = ring_ent->fuse_req;
+	int has_next;
+
+	if (set_err)
+		req->out.h.error = error;
+
+	clear_bit(FR_SENT, &req->flags);
+	fuse_request_end(ring_ent->fuse_req);
+	ring_ent->fuse_req = NULL;
+	clear_bit(FRRS_FUSE_REQ, &ring_ent->state);
+
+	has_next = fuse_uring_ent_release_and_fetch(ring_ent);
+	if (has_next) {
+		/* called within uring context - use provided flags */
+		fuse_uring_send_to_ring(ring_ent, issue_flags, false);
+	}
+}
+
+/*
+ * Read data from the ring buffer, which user space has written to
+ * This is comparible with handling of classical write(/dev/fuse).
+ * Also make the ring request available again for new fuse requests.
+ */
+static void fuse_uring_commit_and_release(struct fuse_dev *fud,
+					  struct fuse_ring_ent *ring_ent,
+					  unsigned int issue_flags)
+{
+	struct fuse_ring_req *rreq = ring_ent->rreq;
+	struct fuse_req *req = ring_ent->fuse_req;
+	ssize_t err = 0;
+	bool set_err = false;
+
+	req->out.h = rreq->out;
+
+	err = fuse_uring_ring_ent_has_err(fud->fc->ring, ring_ent);
+	if (err) {
+		/* req->out.h.error already set */
+		pr_devel("%s:%d err=%zd oh->err=%d\n", __func__, __LINE__, err,
+			 req->out.h.error);
+		goto out;
+	}
+
+	err = fuse_uring_copy_from_ring(fud->fc->ring, req, rreq);
+	if (err)
+		set_err = true;
+
+out:
+	pr_devel("%s:%d ret=%zd op=%d req-ret=%d\n", __func__, __LINE__, err,
+		 req->args->opcode, req->out.h.error);
+	fuse_uring_req_end_and_get_next(ring_ent, set_err, err, issue_flags);
+}
+
 /*
  * fuse_uring_req_fetch command handling
  */
@@ -566,6 +857,26 @@ int fuse_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags)
 
 		spin_unlock(&queue->lock);
 		break;
+	case FUSE_URING_REQ_COMMIT_AND_FETCH:
+		if (unlikely(!ring->ready)) {
+			pr_info("commit and fetch, but fuse-uringis not ready.");
+			goto err_unlock;
+		}
+
+		if (!test_bit(FRRS_USERSPACE, &ring_ent->state)) {
+			pr_info("qid=%d tag=%d state %lu SQE already handled\n",
+				queue->qid, ring_ent->tag, ring_ent->state);
+			goto err_unlock;
+		}
+
+		fuse_ring_ring_ent_unset_userspace(ring_ent);
+		spin_unlock(&queue->lock);
+
+		WRITE_ONCE(ring_ent->cmd, cmd);
+		fuse_uring_commit_and_release(fud, ring_ent, issue_flags);
+
+		ret = 0;
+		break;
 	default:
 		ret = -EINVAL;
 		pr_devel("Unknown uring command %d", cmd_op);

-- 
2.40.1


