Return-Path: <linux-fsdevel+bounces-20481-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB2798D3EF2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 21:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 215B61F23487
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 19:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E240A167282;
	Wed, 29 May 2024 19:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="Kyyw6/of"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip168a.ess.barracuda.com (outbound-ip168a.ess.barracuda.com [209.222.82.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D2942045
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 May 2024 19:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717011325; cv=fail; b=jN0egr/ND6hIcjTs++PXukbdb6k6E+tfYNACFfbSA25fSZ114BFlUdnEyVh6MAJ1CV2bkxP/aN90wguhicWTR99CM9rzMFUc8PRtFGbvnmgyLhRtskCHo8RHiQXC2Hod5KPGvv0gEs9ddizFqgYHK/TgHrgEdfDDpO6Qkq29krM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717011325; c=relaxed/simple;
	bh=hGZY0/CVL5YnixNcNqwYzhhkGec435ldTQG/hUg5tmU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R61Fxv3jp4S83/ydi/8qW4h3DDQGVh1lgMjqElTMPOnJVNYbqH3FAO2ceKYIDcYtSsKV/qHOBwY8VLu5xSwW6rmfLO1A2xBjEjlMHsiZgP+YYml26wihaM3UCJZRhD5g68HPO/wgHxvgmcIBg5s1lOtwkuQKusbndwlsykloeiE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=Kyyw6/of; arc=fail smtp.client-ip=209.222.82.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100]) by mx-outbound10-110.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 29 May 2024 19:35:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=REFUz4tBTgf3ZMyHCA8dmH8Bc3i6lf+PvZumcMr6JazAQHOLIggRBPf88jydTZ+JrrZnhz+VNpeCB9G1/uBSfxwiEA6tywV/A0MxOSmbRbAIR03Qgc5UOsUd11zhdpeEpEjmiWNE4CGuS3mvagD2Hz1oCIl6MOPyH0fRhHKDXYA1ZDLQCRV/Iw+14EfkNNsPr0DpBg2v5kFY32XcnFj/K4DY0Ze0QQsS9+W1FTOXzDrvsKtIdsT0jAdMtLFDO+peQKqtuCDCoKU1fW872dJWfSYoAgioLwLMbfwwvr9EIlP9p97X0kG00o9UAkeqn95GZZGj2s6xyg4QF79wi5YN6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wg1bCdmL0ksCHj/ERN1DKLMkr+cbKMVzZ+pUtVnyp0Y=;
 b=LVG8Ye8NWpUBAzbr6USm+vmZKW2GwISg98zLeQJVhyiEFwEmC3Q2xM2cdSm62F87NTJBnLthH7GrSEe9jXP7DE46E/k1ihsTLbl4UVH3gAgzkRewcx0fuf7N/wPy2PYgdUSq6v61yjuzurFxleapyTnm1vBB6SFg7GhiI5PckTwwo//lFMaJCLPpqC1csBX0pZfvv4EqgAXYF7ciEWUNsfMbres39CBustZ9NZGWPjn7E5eu5cwwN8pabQhJJq1Hb6spopnRi1BFPd40vWr7g0QVQ9Mi2AaRySGrdLt6dboPVkfpzMJuAEfqTEBeAxgd5w4gWIG/g2vkmWDVTErKAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wg1bCdmL0ksCHj/ERN1DKLMkr+cbKMVzZ+pUtVnyp0Y=;
 b=Kyyw6/ofXtHhI+6HWGEIJZwUWF/NEJrXuydgXLyVaQjUSNhiFndhC2ptgmNhxkYsiVNVeEEtVXm4LqWfRz40hcD0TXCPACyzB/2BOrJb2YIKVffEQyJmED7oFNP6bxFuBkUDPKPecWfNdlsIF2KuhFleL5PsqjMrEV7BmIZmq2M=
Received: from PH7PR13CA0012.namprd13.prod.outlook.com (2603:10b6:510:174::18)
 by SA0PR19MB4635.namprd19.prod.outlook.com (2603:10b6:806:bf::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.20; Wed, 29 May
 2024 18:01:04 +0000
Received: from SN1PEPF0002529D.namprd05.prod.outlook.com
 (2603:10b6:510:174:cafe::c5) by PH7PR13CA0012.outlook.office365.com
 (2603:10b6:510:174::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.20 via Frontend
 Transport; Wed, 29 May 2024 18:01:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 SN1PEPF0002529D.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7633.15
 via Frontend Transport; Wed, 29 May 2024 18:01:04 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id D3AFD25;
	Wed, 29 May 2024 18:01:03 +0000 (UTC)
From: Bernd Schubert <bschubert@ddn.com>
Date: Wed, 29 May 2024 20:00:50 +0200
Subject: [PATCH RFC v2 15/19] export __wake_on_current_cpu
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240529-fuse-uring-for-6-9-rfc2-out-v1-15-d149476b1d65@ddn.com>
References: <20240529-fuse-uring-for-6-9-rfc2-out-v1-0-d149476b1d65@ddn.com>
In-Reply-To: <20240529-fuse-uring-for-6-9-rfc2-out-v1-0-d149476b1d65@ddn.com>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
 linux-fsdevel@vger.kernel.org, Bernd Schubert <bschubert@ddn.com>, 
 bernd.schubert@fastmail.fm
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Andrei Vagin <avagin@google.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717005648; l=935;
 i=bschubert@ddn.com; s=20240529; h=from:subject:message-id;
 bh=hGZY0/CVL5YnixNcNqwYzhhkGec435ldTQG/hUg5tmU=;
 b=pUctWm5Q8BHDdNUsGmPBDpqG7t5bfcizOYdOOIGmgb2r9MNQHtHGnZjvgN6QyPrPnxZ8PbIQ3
 CJhOvtDXXx0C8QHvz/7LaW0VDttIiGDJlnhK2mKmfjfG640MkEedvd1
X-Developer-Key: i=bschubert@ddn.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529D:EE_|SA0PR19MB4635:EE_
X-MS-Office365-Filtering-Correlation-Id: c7720fc4-52b1-4beb-a642-08dc80094eeb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230031|376005|36860700004|1800799015|82310400017;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?cWtkeExuOWs4QTFabnU5NlpwbHYreXZ2L3NVVjd6TERHUzVVNDVUMmFkNmJi?=
 =?utf-8?B?dFF4TWRGZVZCNmVSc2NRdUpFbDJxR1pra1lxRVRlNzRibEFKUUNFcjI1Ritj?=
 =?utf-8?B?YjFlYmJiejdiWTFLbGd4L0w1WHk5RTJhMnJWNXhLLzEvc0l4dXlJcWdURzNt?=
 =?utf-8?B?REcwakdTdEpCOU5UR1ZDMGJPTGcrTmJnOUhDR0pQbEhsTVlpV1ZIRzRJRGFq?=
 =?utf-8?B?Sk5WUGxnWnhka0pBeXpTS2NRdDY4NEpER3ExQW1GOVN3TVF0RTdmcW1zMkJs?=
 =?utf-8?B?L3YrZ0FKazhUQnd0amlCTkhTM3pmTmhsV21yd2poaXNJVm96VmE4VE9ROThQ?=
 =?utf-8?B?czZKWmdWT3J2SjdYVE9FTnRiSk9jcUdjZGhBL096d0ZHODBKeWRPM2EyT1dR?=
 =?utf-8?B?WkpJTFIwYlIvZTZwenY5Zkk0TlFQZ2FKVWpNVTZydTVQRVJVTk9hdmwxMlhs?=
 =?utf-8?B?WDYvSk5aRzVUTE14OW5COVlvRlFpTUI1RDk1Wk80TjBlVWRaRVhidk4wS3I5?=
 =?utf-8?B?d29URkJQZmRtbzNEcko4azRqeXRwS3lBT0k4TGsrVE1OMHJpWHdwN0NPc1Nu?=
 =?utf-8?B?SWszY2RMSzdsdGVxSFFBN2xBOUQvamhpQ29NckdjcUwxMFg1cWFWVzh5TXBN?=
 =?utf-8?B?czlvQ0pwTDBLWFhMWTRncXZTZDM3MVZQYTYvUFZYQStTbjlxT3pKS3IzcEQz?=
 =?utf-8?B?ZWsxc3RLdXM5bDBsdFRCUXpWVFJKd3V2NTBCN2JHcHM1SGdLa3lUdTFrWHlV?=
 =?utf-8?B?aERaSTBEanR5eTlwM0pJck9VYlhKOHdNYW9PamZQVEhCTTlCa3pUY254clhz?=
 =?utf-8?B?MDN3Ry85MDllK2w5Ky9vSEFxYndKN3BuOHZIeG5HWG9pYzVETG9MSy9JVDhW?=
 =?utf-8?B?UFZZMHRXOHBkYzlUU2NPeWlXVU1XM21oMWkybUlweGhBZ1VYeEdvMHc3TU1n?=
 =?utf-8?B?WXVnVG5ObnVHcEhETFBWOGFqYnZuRU1aN1o0NTdORTNhSmxGOXlQVlZPWWM1?=
 =?utf-8?B?V3E2V3dOQWZtTDNPY1pVRGgwMVJIRTZNcis0MHZQaE5nU1p2ZS9NZVFhK2lO?=
 =?utf-8?B?UERKdVkwVG0vQysrR0NwbEovWkxiOEY0TzRsaUszNE9iMTVNU3FITXUvQS9o?=
 =?utf-8?B?UHZXNTkwN0ZJeDVNQ1FxSXNGY1ZocllHMHJuemR6VDNHNzZxSnc4Z2dBTEw3?=
 =?utf-8?B?MUJuUzZSR2FUOFZtSXQwUkV6QzFTNGVOSXhqemRxRmxMaG9sQUJrc0FQQkl0?=
 =?utf-8?B?R09HbjEyendwd29NS0I0Um56anRKS3dXZEhwNmxVVW84TnFhMEIzTm0xQXM4?=
 =?utf-8?B?NFJnSTJkdWFyWU9idklWWWdrNTRMcGRWYlErZlFvd1JzRG0raEF4dzg4MWFJ?=
 =?utf-8?B?azBQOGgyZkMxekpyczlRS01CcXRCQUpCc3Q2N2xrSnhYbStMdktiNEJQVVR6?=
 =?utf-8?B?KzYzUUY0TGlzMkc3V3dWbVZxRUFBckhqeGFJREZvbTRBYzFzZjdpK0FDNjZx?=
 =?utf-8?B?R2lIQ0hzN0dIVU00YVEvVENUbXhiQTFJUDB3cm56Q203RFNlNG1PcTVPeWht?=
 =?utf-8?B?SFZlZ2J0cXllOXVNT3BhUmNYTmMwT1RhU0xWa2pIc1JNTS9BU3dKYW5OM05r?=
 =?utf-8?B?eGx5VHpyVWlBSSt0QmpnUldXYjV1M0xMSEtpR1llcnRrSzMzZm9EdFRhTjlE?=
 =?utf-8?B?VCtYeU9keHBLNzRCL3J1dzNmTFpDaUl2aVUxMFVNWWhscGgvQmJ3YlZtUDQv?=
 =?utf-8?B?ZUpJTEpVcVpYemZ5emw5bTkwZ1d0VkIwZzZYQmluTUxzeGM5dXZXZVN2QzRx?=
 =?utf-8?B?bjdBQTNrUi9wY2d4MW1lb2hWeTlXT2JicTBYeE9SYzNhT3pSL0l5d2txSXh5?=
 =?utf-8?Q?xsOeuPn9c6GGd?=
X-Forefront-Antispam-Report:
 CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(36860700004)(1800799015)(82310400017);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
 DucuI3X/3Amf4l/znaspGNIwabsmwGPpQ9CWNpEQQ7loXrCnNjFAD59+mUjKD7Q+9x2Vnm2ZAtuumLkQs9WnMXWe7lwab4IVyM66AQNm06Ejy/bhhhA3o+fAq4lepZe5pw/YYu/lrN7R8414XTuB3YE1EMnQpMyhBXrYAmB/kQgpv+oy4DAh3pNREUF0ftKB+KjJEwZ31WAqgXuyua3U1L2dS6OFnWi/meEhyiJOZ7pVCwAtpjx4uFk/J3hyNh6yUlg1Blw2jrhPr1W5rVFtK242fSJlso9cr2mDeHlKh22NpzZfTvGsyVGypEHi3ZEK37ueKMRXj8WDfkFgXdA7lPZ1MzCUTGyJgMbW8g8O7OUNeyakBvh/Yx+huYCCiTIqzziUXQXV0GjuwQY0YNr1hNYO0soiLqa0fE81Fh/uBg6U4Kn6NifvmSZafS7XRRiB0fKzOsil2ktnii7sI8/fzZGkwWEBp1Mpq03+DnfQCb2LuHH1LN7QMgN3I3hHti64vzvFh79eTuz3N0lVN2/VG0mAO00i1raH9xYD97Fl0vX9WtZq+FEwRCdQhZKbzYtpZCNa7Uey1wGFSzxauueEm4OlMQvr/0SIGAJDa80jM6J23i7Bs9MEsjCj60JTvPIUJAGsD+PrSomG+P4WpEeiBg==
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 18:01:04.5957
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7720fc4-52b1-4beb-a642-08dc80094eeb
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
 SN1PEPF0002529D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR19MB4635
X-OriginatorOrg: ddn.com
X-BESS-ID: 1717011322-102670-12914-11745-1
X-BESS-VER: 2019.1_20240429.2309
X-BESS-Apparent-Source-IP: 104.47.58.100
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVpYGFkBGBlAsMTHF0MDCItEw2d
	IiLc3c2MA42SQ11cjA2NLIzNTAKEWpNhYAnFFnxEAAAAA=
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.256586 [from 
	cloudscan11-249.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
	0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, BSF_SC0_MISMATCH_TO
X-BESS-BRTS-Status:1

This is needed by fuse-over-io-uring to wake up the waiting
application thread on the core it was submitted from.
Avoiding core switching is actually a major factor for
fuse performance improvements of fuse-over-io-uring.

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andrei Vagin <avagin@google.com>
---
 kernel/sched/wait.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sched/wait.c b/kernel/sched/wait.c
index 51e38f5f4701..6576a1ef5d43 100644
--- a/kernel/sched/wait.c
+++ b/kernel/sched/wait.c
@@ -132,6 +132,7 @@ void __wake_up_on_current_cpu(struct wait_queue_head *wq_head, unsigned int mode
 {
 	__wake_up_common_lock(wq_head, mode, 1, WF_CURRENT_CPU, key);
 }
+EXPORT_SYMBOL(__wake_up_on_current_cpu);
 
 /*
  * Same as __wake_up but called with the spinlock in wait_queue_head_t held.

-- 
2.40.1


