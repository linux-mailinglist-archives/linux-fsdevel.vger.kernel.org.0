Return-Path: <linux-fsdevel+bounces-20477-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66EEA8D3EEA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 21:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E54CC1F23301
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 19:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920841C2321;
	Wed, 29 May 2024 19:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="sbwUPMR8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip168a.ess.barracuda.com (outbound-ip168a.ess.barracuda.com [209.222.82.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE2615B13E
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 May 2024 19:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717011256; cv=fail; b=hbERsmdOloQL0uaaoSYpaDq0ayF6Cp3nEnfQf9l9Z0ncPc00YKuRqRsoYw/zYxFPQD95RQHLPeQ+0YWuPR7ewX/qD0XeQ9bQjno/1zhvCK13D0CF7qzQcsarOmJbZ+tio57t1eE/Pj8PiPNY6M0AbZyts7MNWO0MndNe++lH/UI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717011256; c=relaxed/simple;
	bh=HorOtb32wYZnnjwl6WMg5S13aoIm4pN+nPF9ebPVagw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=blRwtb8Qad3W/2vAOZVRzWNx4bez8CyjO9V87+jKtMd6wd/P3XzjkwWzo86GlVZ03CAmqQb6mMeSgQbDp96+TmAMIWYOtIQTIRyq/WsCZY0leZujcdhwFedI8N818aBfu+zl7L+LixYGWNOcU9dR5eejk/XNi5nyEqur+UIP5JM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=sbwUPMR8; arc=fail smtp.client-ip=209.222.82.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49]) by mx-outbound8-137.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 29 May 2024 19:34:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BbLYRNhaOUKAbcbiXndCikMO2pHKQUz9sdapGbgVF6ZyMpfo8XfWhhYs1kRi/dZoQTGy9sjeaQ6gyv8V7osuA8lB91PJDIBD4Ax60XnQWKcarwGjpsEYse3rn9VVLIipO74rmqs6x+/fhIeLhJZB6I4epO3Bvj54My9c/ayJ19XqZ30RqLTuIFOuJX6a0RVmGasG1sxQ1PUhaKNlHgsnS/WPxyvy3okSHx2X64KEMv6WfSdSvHWtHmZuX6ElZSyzObbDSMdUYQdAwS9xyTZvW2UWonf+XygbxXV0bPpRFF7/1ZJaSzBaJDcdV8EBXeCmoDTG7watXIP78WGCaI6mDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CnOm1jqq/94uMhfygXgUHjQKz2mFXhxEHG+ZipgV/w4=;
 b=oFaVOBzHBlqF9R3tMeqqJw8xiDzyt30y9D4wRZjyHSVxk0mUhmv3rXJW3DlHEVqIiiKOl/ZIqpkLgz3Aa2iy15uV8EFNGbxIHOiFY3gdK0ibCCf7+/G4mnKZwvUSQtZzooaMxTd7/0fAFtD6LqkrEeryC125zueX3NsR+61nubq8aSrVhIumEHQHXjsSyILbK84SV4iSjx82WbQyBEXRDXfFadHNkm6ls6YT3UfaccpUzo4qHafl5zj71bsEDs7yHZXPNOLtuq4tUmOhqaLJytMDNJpO6oOsOqvweF2Qo91V+83PpLj7olJ8/gyismL6qUmnlOTZPiEQ4+L0gReccQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CnOm1jqq/94uMhfygXgUHjQKz2mFXhxEHG+ZipgV/w4=;
 b=sbwUPMR8NXooTFqwiVpd4pz/NOW578yuOR/ld1NLRipyuDnYmlUf9ch4AcPDEoiO5Y/Q6GsWWDmg/OKmi45azUrq9M/bjO0TY0onCaJ0B5LnhvyM9Xaq1qx+6croqb4gyrcLhziPF0YglHCuJt8SIUys6D68HI2eC5xzhZM8bqI=
Received: from PH7PR17CA0021.namprd17.prod.outlook.com (2603:10b6:510:324::27)
 by DM4PR19MB7192.namprd19.prod.outlook.com (2603:10b6:8:110::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.37; Wed, 29 May
 2024 18:01:02 +0000
Received: from CY4PEPF0000EE30.namprd05.prod.outlook.com
 (2603:10b6:510:324:cafe::67) by PH7PR17CA0021.outlook.office365.com
 (2603:10b6:510:324::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.20 via Frontend
 Transport; Wed, 29 May 2024 18:01:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 CY4PEPF0000EE30.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7633.15
 via Frontend Transport; Wed, 29 May 2024 18:01:02 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id E33B725;
	Wed, 29 May 2024 18:01:01 +0000 (UTC)
From: Bernd Schubert <bschubert@ddn.com>
Date: Wed, 29 May 2024 20:00:48 +0200
Subject: [PATCH RFC v2 13/19] fuse: {uring} Handle uring shutdown
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240529-fuse-uring-for-6-9-rfc2-out-v1-13-d149476b1d65@ddn.com>
References: <20240529-fuse-uring-for-6-9-rfc2-out-v1-0-d149476b1d65@ddn.com>
In-Reply-To: <20240529-fuse-uring-for-6-9-rfc2-out-v1-0-d149476b1d65@ddn.com>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
 linux-fsdevel@vger.kernel.org, Bernd Schubert <bschubert@ddn.com>, 
 bernd.schubert@fastmail.fm
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717005648; l=9764;
 i=bschubert@ddn.com; s=20240529; h=from:subject:message-id;
 bh=HorOtb32wYZnnjwl6WMg5S13aoIm4pN+nPF9ebPVagw=;
 b=sC+hBXO5NdrYI9epeJGOikrsEKMPdTyVMzSJ4EtJwWJeBSmGXN0LsYrAaM94JN74scU1p8WJG
 eLTzyeMqJZ/DOUy4AzQTDDc6lPd2sHRyBzU6jcQ3sM0KaYuJPHsc7jK
X-Developer-Key: i=bschubert@ddn.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE30:EE_|DM4PR19MB7192:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ece4a91-5ce5-4d02-9e4b-08dc80094d8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|1800799015|36860700004|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dkZvZ1VseWZZVm5VK3ZkL2MvZWF4dUsrMTJLTTVFTlVvOExmNHNQSWFhSDVs?=
 =?utf-8?B?ZTdVZjFnRWU2Q0tqMUZXNVBOSW83WFJaVVcyRVNhWXZoM0ZsNnBrVUw2blpF?=
 =?utf-8?B?QTI4NlVuTmh0cVhJVjZTdVB1QzZYM215c2EwQm1sbXRXYXhmaDIvRy9DMG5L?=
 =?utf-8?B?a3NXdDVzOFQvNUliTFFDVWdQV3FhanRpOE42amVHcVFJdXZoQkN1WWNGSGdJ?=
 =?utf-8?B?MDFPd09mdko3Wm9EcEgvVmFoZHU4K3FXUk90aThyOWhUak1SQnZDRFk2bFBJ?=
 =?utf-8?B?T0NEalpmMGJFNnYwWDVvZEtEQ0VyZ3RsYW1ScXRoRElSTy9xRWN6OGZTbWZu?=
 =?utf-8?B?d3dlcExUdHJEaHBqSFZQRDJ3Y2xJRHI3MjhEclpHSUUwSmlBMy9aenBZbFdT?=
 =?utf-8?B?SEw2ZTBjbTBiT1ozS0w3aFNvWHVIT3RKSGpOaitHZmxtODU5Qmk2WXdRYjc3?=
 =?utf-8?B?NDdPenA5YW1STzJOUFhXZHgwSklxLzNzdndvQi9UeHhPVWIzTk1RVDgxVUJQ?=
 =?utf-8?B?STU2MGtCSWZnWnN5aDlncTVNMk9nUktaWE1Ic0k0OElLaDkxR0U2WXJGQmFO?=
 =?utf-8?B?cThuOE1ybFJBNUJ0MW5KR2lVd3JBTGk0NXRob04xWEcwZWZUTTR3L2x2UVR5?=
 =?utf-8?B?QWFtdVg4UmlTZEVvRFB3SDk3bnJrMDRob0IvTGVaeHZHUWEwNGo4R2dhYWxW?=
 =?utf-8?B?S0R3OFU2RDJMZGVIYks4cGFrbkV5Q2VWSlFoTmhUVjJhNzk1MW5uN2NQbHJZ?=
 =?utf-8?B?NVJsbE43Z1JFTC9jTDRpZEtnbTVOVDN5d2JMQ05YWHY2MHY4UTE1VWo4VW11?=
 =?utf-8?B?TmI4dVFIMHVZWXF6eU9ydXlvNG1RY0laVFM5ckJod0NWMk5XTTE2SWRWZ3Va?=
 =?utf-8?B?QnNoejBsWU5TV2FlN3JXZFREUWx0d1FnQnJrR0duWUNnQTd5ZElJZG54TTBI?=
 =?utf-8?B?emhBd1p3T3FUeVVYS2VoVnhyakpJbHZFTkhlQ3U3SitEVVEvN1Z1U2k3ZHZS?=
 =?utf-8?B?Um04M25HWXBRbkRWK0VNd3lENHNEKzhDWG1LM0pRWnpHbHlia3hmalBzRVFJ?=
 =?utf-8?B?UU5kQVYzOWRhRDRqQjdYckViMUx6WnlrZS9VbDl6RHRnL2c3SFh4a3dXRDJ5?=
 =?utf-8?B?SmdiSS9JekFKRmpGaTExL3hzUGo2SndiaDNlc083bEFaMDVLdDJtenhQRWFE?=
 =?utf-8?B?YzBpWlN6ajQrVE1NVHUxaW92eTBqZzlVKy83bnF0ODU0THhPZVRaTStpbkhm?=
 =?utf-8?B?eHlVNFBvNGsvZ0hDbUpocDZhd092QXE4RHFubTh1RnBjUVZwTHRXN1BqQWRs?=
 =?utf-8?B?bm9NekJ4aXBzRHhMY1h4WisyYWFhZGxTMXRKSEtOVm1TNFBWUkVudWU4Z0Fk?=
 =?utf-8?B?dG5OdWtLT2JnaGtjUkZvN0ZINVNLY1BKQ1h2ZkNRKzdKYzl4bFI5SEdyQlpj?=
 =?utf-8?B?NkpiemU4dEREelhUTnVwb24wb1V5anpyM3JDOExMOEpkaEcxTTVyZC9meWYv?=
 =?utf-8?B?elZaWDZGVVJkblp0dS90Zk9NSEhIT0xsMU5PNXRST3JKT0t6TlVYYk82dWJE?=
 =?utf-8?B?YUNMQzViT25Dcm5XSHNkTW5QTEUwbDMxTVZwYzc0STBET0I2WlZsaDhzNkFh?=
 =?utf-8?B?aUdhNXRvNlFYL2ludmpWVnFtVDduTVRRdVl6YU00TFNvcGNpMWRZekp0eER2?=
 =?utf-8?B?RGtwTVZ6V0NvZ09CR2tKNHZNWnpwbVNzWWc3WkdaRE5zNm8yUWdMbGNpZWR1?=
 =?utf-8?B?ZURkSE0vYk4zQTB6ais4SHlQQ1g3TGhMaEVDd3ROL0hRL3NSaDNIczJVKzVm?=
 =?utf-8?B?OTlGNkhHRXpVR3RHQ2pYUDVnemZTSHlQUi9MN0J5V1lRc1hmZWVYbzhlc2xs?=
 =?utf-8?Q?WGH4v2onA20zF?=
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400017)(1800799015)(36860700004)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2e2kQgfFuQg9X7x3uJhgw31wXlKsCYT13TytN1drawQWX/cscGq5y2rpV5veP1L21Wts1BEeYjw4yW43HZrbv6Tlvq1AzAeQBoLfPpgwpKZcjYhDfH0mdgVxe5hmrR3AEr9iLo6NHkwUj72b9fnaANovIofcJC2g7bJqBepsq/+0aRzlkOUeVqgnf9na9EnmC5L/GOwKiZNMfPA+OrSoARV38LGxiV2WDbeKAZ/5N2IjngevJu39E/IXDPnrHzltAxaUQd1xSFiY7wgLBMBFfVb39IVQDhFNBn741TZCjl2epo8HwhbWhB7vAcfzXrvX3bqt5ot/KO0pTBnYsbqQEQLoEZ0Jzk7aHCuSqa1sVVFc/U/vn+TFCuGpOdaOjmMi/pZvHGM6xG46u63N5y7XqkDX+odB/Y0Or+ejoqeTo27WGgxV83jOieNbC3RERrBE+//G3Ts7F3UCqMOxObWmGS0vvR5auXn9D3pyKcNIU8ObiMs1246UctVwHvgFjwhixxes6iPoJHPHszUhz80WJGnp/oG47qzfXL3p+Ol9hk/KVbv8rDRaXb2ntHdXs0spLCQjywEmGywPFpEnoL7jbc+5LAj+YZLLws5BJmwhcKGu012iW72dGDWC4C2oNU0yroQsYtNvpsMHiSWCoLjRjQ==
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 18:01:02.3552
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ece4a91-5ce5-4d02-9e4b-08dc80094d8e
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE30.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR19MB7192
X-OriginatorOrg: ddn.com
X-BESS-ID: 1717011252-102185-14207-17562-1
X-BESS-VER: 2019.1_20240429.2309
X-BESS-Apparent-Source-IP: 104.47.66.49
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVpYmBpZAVgZQMMnCzNTM1NDEyD
	TV1CA1xcIoOS0xOcXC1NDYMjkVyFCqjQUA4rMqH0EAAAA=
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.256586 [from 
	cloudscan19-121.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
	0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, BSF_SC0_MISMATCH_TO
X-BESS-BRTS-Status:1

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
 fs/fuse/dev.c         |  10 +++
 fs/fuse/dev_uring.c   | 194 ++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/dev_uring_i.h |  67 +++++++++++++++++
 3 files changed, 271 insertions(+)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index a7d26440de39..6ffd216b27c8 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -2202,6 +2202,8 @@ void fuse_abort_conn(struct fuse_conn *fc)
 		fc->connected = 0;
 		spin_unlock(&fc->bg_lock);
 
+		fuse_uring_set_stopped(fc);
+
 		fuse_set_initialized(fc);
 		list_for_each_entry(fud, &fc->devices, entry) {
 			struct fuse_pqueue *fpq = &fud->pq;
@@ -2245,6 +2247,12 @@ void fuse_abort_conn(struct fuse_conn *fc)
 		spin_unlock(&fc->lock);
 
 		fuse_dev_end_requests(&to_end);
+
+		/*
+		 * fc->lock must not be taken to avoid conflicts with io-uring
+		 * locks
+		 */
+		fuse_uring_abort(fc);
 	} else {
 		spin_unlock(&fc->lock);
 	}
@@ -2256,6 +2264,8 @@ void fuse_wait_aborted(struct fuse_conn *fc)
 	/* matches implicit memory barrier in fuse_drop_waiting() */
 	smp_mb();
 	wait_event(fc->blocked_waitq, atomic_read(&fc->num_waiting) == 0);
+
+	fuse_uring_wait_stopped_queues(fc);
 }
 
 int fuse_dev_release(struct inode *inode, struct file *file)
diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index 5269b3f8891e..6001ba4d6e82 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -48,6 +48,44 @@ fuse_uring_async_send_to_ring(struct io_uring_cmd *cmd,
 	io_uring_cmd_done(cmd, 0, 0, issue_flags);
 }
 
+/* Abort all list queued request on the given ring queue */
+static void fuse_uring_abort_end_queue_requests(struct fuse_ring_queue *queue)
+{
+	struct fuse_req *req;
+	LIST_HEAD(sync_list);
+	LIST_HEAD(async_list);
+
+	spin_lock(&queue->lock);
+
+	list_for_each_entry(req, &queue->sync_fuse_req_queue, list)
+		clear_bit(FR_PENDING, &req->flags);
+	list_for_each_entry(req, &queue->async_fuse_req_queue, list)
+		clear_bit(FR_PENDING, &req->flags);
+
+	list_splice_init(&queue->async_fuse_req_queue, &sync_list);
+	list_splice_init(&queue->sync_fuse_req_queue, &async_list);
+
+	spin_unlock(&queue->lock);
+
+	/* must not hold queue lock to avoid order issues with fi->lock */
+	fuse_dev_end_requests(&sync_list);
+	fuse_dev_end_requests(&async_list);
+}
+
+void fuse_uring_abort_end_requests(struct fuse_ring *ring)
+{
+	int qid;
+
+	for (qid = 0; qid < ring->nr_queues; qid++) {
+		struct fuse_ring_queue *queue = fuse_uring_get_queue(ring, qid);
+
+		if (!queue->configured)
+			continue;
+
+		fuse_uring_abort_end_queue_requests(queue);
+	}
+}
+
 /* Update conn limits according to ring values */
 static void fuse_uring_conn_cfg_limits(struct fuse_ring *ring)
 {
@@ -361,6 +399,162 @@ int fuse_uring_queue_cfg(struct fuse_ring *ring,
 	return 0;
 }
 
+static void fuse_uring_stop_fuse_req_end(struct fuse_ring_ent *ent)
+{
+	struct fuse_req *req = ent->fuse_req;
+
+	ent->fuse_req = NULL;
+	clear_bit(FRRS_FUSE_REQ, &ent->state);
+	clear_bit(FR_SENT, &req->flags);
+	req->out.h.error = -ECONNABORTED;
+	fuse_request_end(req);
+}
+
+/*
+ * Release a request/entry on connection shutdown
+ */
+static bool fuse_uring_try_entry_stop(struct fuse_ring_ent *ent,
+				      bool need_cmd_done)
+	__must_hold(ent->queue->lock)
+{
+	struct fuse_ring_queue *queue = ent->queue;
+	bool released = false;
+
+	if (test_bit(FRRS_FREED, &ent->state))
+		goto out; /* no work left, freed before */
+
+	if (ent->state == BIT(FRRS_INIT) || test_bit(FRRS_WAIT, &ent->state) ||
+	    test_bit(FRRS_USERSPACE, &ent->state)) {
+		set_bit(FRRS_FREED, &ent->state);
+
+		if (need_cmd_done) {
+			pr_devel("qid=%d tag=%d sending cmd_done\n", queue->qid,
+				 ent->tag);
+
+			spin_unlock(&queue->lock);
+			io_uring_cmd_done(ent->cmd, -ENOTCONN, 0,
+					  IO_URING_F_UNLOCKED);
+			spin_lock(&queue->lock);
+		}
+
+		if (ent->fuse_req)
+			fuse_uring_stop_fuse_req_end(ent);
+		released = true;
+	}
+out:
+	return released;
+}
+
+static void fuse_uring_stop_list_entries(struct list_head *head,
+					 struct fuse_ring_queue *queue,
+					 bool need_cmd_done)
+{
+	struct fuse_ring *ring = queue->ring;
+	struct fuse_ring_ent *ent, *next;
+	ssize_t queue_refs = SSIZE_MAX;
+
+	list_for_each_entry_safe(ent, next, head, list) {
+		if (fuse_uring_try_entry_stop(ent, need_cmd_done)) {
+			queue_refs = atomic_dec_return(&ring->queue_refs);
+			list_del_init(&ent->list);
+		}
+
+		if (WARN_ON_ONCE(queue_refs < 0))
+			pr_warn("qid=%d queue_refs=%zd", queue->qid,
+				queue_refs);
+	}
+}
+
+static void fuse_uring_stop_queue(struct fuse_ring_queue *queue)
+	__must_hold(&queue->lock)
+{
+	fuse_uring_stop_list_entries(&queue->ent_in_userspace, queue, false);
+	fuse_uring_stop_list_entries(&queue->async_ent_avail_queue, queue, true);
+	fuse_uring_stop_list_entries(&queue->sync_ent_avail_queue, queue, true);
+}
+
+/*
+ * Log state debug info
+ */
+static void fuse_uring_stop_ent_state(struct fuse_ring *ring)
+{
+	int qid, tag;
+
+	for (qid = 0; qid < ring->nr_queues; qid++) {
+		struct fuse_ring_queue *queue = fuse_uring_get_queue(ring, qid);
+
+		for (tag = 0; tag < ring->queue_depth; tag++) {
+			struct fuse_ring_ent *ent = &queue->ring_ent[tag];
+
+			if (!test_bit(FRRS_FREED, &ent->state))
+				pr_info("ring=%p qid=%d tag=%d state=%lu\n",
+					ring, qid, tag, ent->state);
+		}
+	}
+	ring->stop_debug_log = 1;
+}
+
+static void fuse_uring_async_stop_queues(struct work_struct *work)
+{
+	int qid;
+	struct fuse_ring *ring =
+		container_of(work, struct fuse_ring, stop_work.work);
+
+	for (qid = 0; qid < ring->nr_queues; qid++) {
+		struct fuse_ring_queue *queue = fuse_uring_get_queue(ring, qid);
+
+		if (!queue->configured)
+			continue;
+
+		spin_lock(&queue->lock);
+		fuse_uring_stop_queue(queue);
+		spin_unlock(&queue->lock);
+	}
+
+	if (atomic_read(&ring->queue_refs) > 0) {
+		if (time_after(jiffies,
+			       ring->stop_time + FUSE_URING_STOP_WARN_TIMEOUT))
+			fuse_uring_stop_ent_state(ring);
+
+		pr_info("ring=%p scheduling intervalled queue stop\n", ring);
+
+		schedule_delayed_work(&ring->stop_work,
+				      FUSE_URING_STOP_INTERVAL);
+	} else {
+		wake_up_all(&ring->stop_waitq);
+	}
+}
+
+/*
+ * Stop the ring queues
+ */
+void fuse_uring_stop_queues(struct fuse_ring *ring)
+{
+	int qid;
+
+	for (qid = 0; qid < ring->nr_queues; qid++) {
+		struct fuse_ring_queue *queue = fuse_uring_get_queue(ring, qid);
+
+		if (!queue->configured)
+			continue;
+
+		spin_lock(&queue->lock);
+		fuse_uring_stop_queue(queue);
+		spin_unlock(&queue->lock);
+	}
+
+	if (atomic_read(&ring->queue_refs) > 0) {
+		pr_info("ring=%p scheduling intervalled queue stop\n", ring);
+		ring->stop_time = jiffies;
+		INIT_DELAYED_WORK(&ring->stop_work,
+				  fuse_uring_async_stop_queues);
+		schedule_delayed_work(&ring->stop_work,
+				      FUSE_URING_STOP_INTERVAL);
+	} else {
+		wake_up_all(&ring->stop_waitq);
+	}
+}
+
 /*
  * Checks for errors and stores it into the request
  */
diff --git a/fs/fuse/dev_uring_i.h b/fs/fuse/dev_uring_i.h
index b2be67bb2fa7..e5fc84e2f3ea 100644
--- a/fs/fuse/dev_uring_i.h
+++ b/fs/fuse/dev_uring_i.h
@@ -16,6 +16,9 @@
 /* IORING_MAX_ENTRIES */
 #define FUSE_URING_MAX_QUEUE_DEPTH 32768
 
+#define FUSE_URING_STOP_WARN_TIMEOUT (5 * HZ)
+#define FUSE_URING_STOP_INTERVAL (HZ/20)
+
 enum fuse_ring_req_state {
 
 	/* request is basially initialized */
@@ -203,6 +206,7 @@ int fuse_uring_mmap(struct file *filp, struct vm_area_struct *vma);
 int fuse_uring_queue_cfg(struct fuse_ring *ring,
 			 struct fuse_ring_queue_config *qcfg);
 void fuse_uring_ring_destruct(struct fuse_ring *ring);
+void fuse_uring_stop_queues(struct fuse_ring *ring);
 int fuse_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags);
 
 static inline void fuse_uring_conn_init(struct fuse_ring *ring,
@@ -275,6 +279,58 @@ static inline bool fuse_per_core_queue(struct fuse_conn *fc)
 	return fc->ring && fc->ring->per_core_queue;
 }
 
+static inline void fuse_uring_set_stopped_queues(struct fuse_ring *ring)
+{
+	int qid;
+
+	for (qid = 0; qid < ring->nr_queues; qid++) {
+		struct fuse_ring_queue *queue = fuse_uring_get_queue(ring, qid);
+
+		if (!queue->configured)
+			continue;
+
+		spin_lock(&queue->lock);
+		queue->stopped = 1;
+		spin_unlock(&queue->lock);
+	}
+}
+
+/*
+ *  Set per queue aborted flag
+ */
+static inline void fuse_uring_set_stopped(struct fuse_conn *fc)
+	__must_hold(fc->lock)
+{
+	if (fc->ring == NULL)
+		return;
+
+	fc->ring->ready = false;
+
+	fuse_uring_set_stopped_queues(fc->ring);
+}
+
+static inline void fuse_uring_abort(struct fuse_conn *fc)
+{
+	struct fuse_ring *ring = fc->ring;
+
+	if (ring == NULL)
+		return;
+
+	if (ring->configured && atomic_read(&ring->queue_refs) > 0) {
+		fuse_uring_abort_end_requests(ring);
+		fuse_uring_stop_queues(ring);
+	}
+}
+
+static inline void fuse_uring_wait_stopped_queues(struct fuse_conn *fc)
+{
+	struct fuse_ring *ring = fc->ring;
+
+	if (ring && ring->configured)
+		wait_event(ring->stop_waitq,
+			   atomic_read(&ring->queue_refs) == 0);
+}
+
 #else /* CONFIG_FUSE_IO_URING */
 
 struct fuse_ring;
@@ -298,6 +354,17 @@ static inline bool fuse_per_core_queue(struct fuse_conn *fc)
 	return false;
 }
 
+static inline void fuse_uring_set_stopped(struct fuse_conn *fc)
+{
+}
+
+static inline void fuse_uring_abort(struct fuse_conn *fc)
+{
+}
+
+static inline void fuse_uring_wait_stopped_queues(struct fuse_conn *fc)
+{
+}
 
 #endif /* CONFIG_FUSE_IO_URING */
 

-- 
2.40.1


