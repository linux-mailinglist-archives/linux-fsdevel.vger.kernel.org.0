Return-Path: <linux-fsdevel+bounces-20483-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B539A8D3EF7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 21:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F33D1F23396
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 19:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 246C8199E9E;
	Wed, 29 May 2024 19:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="HoeWFEc3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip191a.ess.barracuda.com (outbound-ip191a.ess.barracuda.com [209.222.82.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2062B42045
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 May 2024 19:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717011383; cv=fail; b=fw3iM+WwQ/xivGJ2mGe03hFgfVPsZYPHgWQE0eRJX3h27hFMRlaUwa+diuS4mSDz22nJ5VaxzZ4Yw1ayK8UAChtzvaeb+t5VcBEnvaya6iH1naxCED9zIrecfI/pVkuE5VgPipLeQvmoX/rpKI2SHCcojL6KqXeofR7cp9Rw8OU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717011383; c=relaxed/simple;
	bh=kEi5pklCQr9uYBS4gqJHBv3XOFdiEeSBKRiSPtW205M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=u15cZmmtg431dsZzRJTGCKXrCmL+dgM3pk5riWBYILB7QtL7Fcx8+i5icMsWFGHpJzWu2iFotBVx4llrBDn9JbJoipj1at4NzMTjr+wNVIpR65njjZ3cFboqMVK3ZsTRqAA516LwuFIpdMEcvoOkoJyoKFuzIDtxUm/3ATxWx9g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=HoeWFEc3; arc=fail smtp.client-ip=209.222.82.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41]) by mx-outbound42-38.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 29 May 2024 19:36:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H6KM0mWhS0SUKg2BCxpKkU8K8md6dOw8/O3nqI2VZwkUKfkyHq+Ty3X7sULEFagDOYBY/HnUGH2Wysdy2kHYJc/ZvEHmECZ03dHOGffj7S/UjQTeOuwQ1jCxiQ82PTcPuD/CmIHNupdYulMD8dC2TO9XM5X7BkBttH0Pm+2e1KanGcWFD1F24+Ng6QmhFDTBJnWfLNlPy8lrOrCYZ3qQXBR4XegPEKefUd8dL5uBqtt4z9NhdGTqZthNCkdXAVN5OzylgDFJO0q38IsjRR2gUniC7NiuFMU1NtjRsWYHtmjrxUiMZtmRq2FrSX/mKBATyZQcLJN4ihufp943x/huZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lM/c7rWS/iOwcfGkdVctZy+ojT3bQHmnD2IdcozDka4=;
 b=OTU1FE3bW9HOR5m9xoGcL/2UNx23cYKXg7SMvtfcHtdjivq99mFMmlz8ikmqFVC3rpKahjhWdioGhLH996ZQiogwZbFGQz4RXFBB9BvX6DDSZGSB0Qetsbp62bs93ZjlnzqscwuYb5M4RXSJkuOmZNYkA6EPDmT/Hvc4RoH1XxuneZq17AEWnB1PrOOX4EwELmCeMDfgqsrsIVDfqtzmeZgYv0vBDOqxRtG42j/7BJoyBZuNbFNthw2ANlR+AdwyXHmbVjJZBMlfBWYBIbo6cqI+jCi7MWtTY0mhhH99evJc/dQ3XJsjuXsNCgp8pxp9yxl3FQKBq7iqNPCm5p0YsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lM/c7rWS/iOwcfGkdVctZy+ojT3bQHmnD2IdcozDka4=;
 b=HoeWFEc3r4rawdX5+IIA6xKvSNBhYvN2V7I8FlpO6N5Z6uHfq6bDKRmngo7p15VXzIlRwJb86clknyUj7suipuT3V/hYZHTFn6qZauieTx/3KlNLTQgl0I6rSaS0oV39L/POQb6EykstkrCHEQgL2APip6jiUpDdKwcscOdPkbE=
Received: from BYAPR07CA0060.namprd07.prod.outlook.com (2603:10b6:a03:60::37)
 by MW4PR19MB5518.namprd19.prod.outlook.com (2603:10b6:303:185::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Wed, 29 May
 2024 18:01:06 +0000
Received: from SJ1PEPF00002310.namprd03.prod.outlook.com
 (2603:10b6:a03:60:cafe::1f) by BYAPR07CA0060.outlook.office365.com
 (2603:10b6:a03:60::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30 via Frontend
 Transport; Wed, 29 May 2024 18:01:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 SJ1PEPF00002310.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7633.15
 via Frontend Transport; Wed, 29 May 2024 18:01:05 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id CCCAA27;
	Wed, 29 May 2024 18:01:04 +0000 (UTC)
From: Bernd Schubert <bschubert@ddn.com>
Date: Wed, 29 May 2024 20:00:51 +0200
Subject: [PATCH RFC v2 16/19] fuse: {uring} Wake requests on the the
 current cpu
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240529-fuse-uring-for-6-9-rfc2-out-v1-16-d149476b1d65@ddn.com>
References: <20240529-fuse-uring-for-6-9-rfc2-out-v1-0-d149476b1d65@ddn.com>
In-Reply-To: <20240529-fuse-uring-for-6-9-rfc2-out-v1-0-d149476b1d65@ddn.com>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
 linux-fsdevel@vger.kernel.org, Bernd Schubert <bschubert@ddn.com>, 
 bernd.schubert@fastmail.fm
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717005648; l=894;
 i=bschubert@ddn.com; s=20240529; h=from:subject:message-id;
 bh=kEi5pklCQr9uYBS4gqJHBv3XOFdiEeSBKRiSPtW205M=;
 b=MWkX7ZsgkHjk4f6mUaeq3J8bhjt0LmS61Xbq+nrxT+b7gvyqRV2o27rHC+6R+Xdu6cQtehfdI
 C3BdBPBXT72DGEFOyl3JLkS/rmFJbZSYQjQtAECoHCd3/iY8QfZcE2w
X-Developer-Key: i=bschubert@ddn.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002310:EE_|MW4PR19MB5518:EE_
X-MS-Office365-Filtering-Correlation-Id: fe7a61fe-8441-4e31-c7e1-08dc80094f87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|376005|82310400017|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aEozeXBNdmNkbDNBVXIyS1lDb0RzbXVHaEoyWkQzQmEwRGs2UUpBU0MvYTlS?=
 =?utf-8?B?ZE80bzJhMitISStiNEVVYkorb0dHZHJGaHN2MVlkOXdwdThqK0xxcERMRzds?=
 =?utf-8?B?ZGxNZ0lFelh1d2RDTnVqbGd1b0xlci9wUVZHQSt3WDNDazhGcFpWemxYekJq?=
 =?utf-8?B?ZkI0TnFsU1JpYWNWWDhBQ0NnTnpoMnZPMXNsaWw2UEsrMzQwQlJRcjByL2h2?=
 =?utf-8?B?bnRSY1ZjUzFycXptZVlzVjFHNTdUTklxM2lDSHVYbTdWM0pDQ215QXYrcEh3?=
 =?utf-8?B?bDZ4bmczRzZwUjlZN05TUGF1Lzl3TCtiaHpGWmRVSnhzTUtoQlpodEMwdXhU?=
 =?utf-8?B?Y0V6VjBleTZCQlJvaFcwTUExTDJ2aVpDMzJRWExBWkE3aUNkRUhwTHdWREUy?=
 =?utf-8?B?d2pTZG9ZL0dSMHNKbXZMMkQ4Y3pRbjRaaEJXUHNQUTRDUGxRUW1tMTJ4ZDZI?=
 =?utf-8?B?L1I1TDVQOGFqUTZ0T3BQOEpFRkNPaFJyYWx1bVZUSWFuZTZJamtpSDBNd1NP?=
 =?utf-8?B?Y2xSMWlyVU5DU2I2TWZVN0lTMFhaNFdNdmlQakNpRHVzbTEvU1Qyc2NxOXJw?=
 =?utf-8?B?WWJHbHpGWnYwS0NNOVk5MEM0RGRoWFljTWZGS2wxZGpHNk5mQS91ZXJDUWZr?=
 =?utf-8?B?Y2t0ZGZ0em9pdEFrc1lDVEtSRDFMVlZZMzNJb3VqMWpnLzVUWmttM1hWaHh4?=
 =?utf-8?B?a042Y2pqQzZ4TTFSczZKS1dqUGdSRUl0Y05aSEV3VnFoZ3lEdDFLZDNDRVNU?=
 =?utf-8?B?bzlNZnZJa0NVaDhveFJsek9WMEd3ZnE4TUx6SzlVYmpMMXdXNldNbFNSZHlZ?=
 =?utf-8?B?RmlKV3JMUGRsb1pFOFcvbHRmaGFCWEFjSlpwYnZYbWpJYmlhRWJ1NnVUZVpP?=
 =?utf-8?B?QjQ1NTBxT1FiTEZnblg4Mm95dWNQbUgxeUt5MnVERlp1QjdPejI0eGNqbUhs?=
 =?utf-8?B?dTFrcmJ5UlU1RlM1V2hPNGZqTWpWSlhrUGxNaHZDMXB5YWFPQXFOWDU1S3Rr?=
 =?utf-8?B?UUE0cDBEV1hodWlCdUticlh5MGxrd1pRVkhBYTl1eDl5aW0zTkgzZkd1Zjh1?=
 =?utf-8?B?ZCtWd21jMm95MXREcVB2WFZPVGZ0WTJlZVJFTnUzejhkbHJkcFg4RGJSQ05a?=
 =?utf-8?B?cnRNdmRJelJnWkxTemFFVHE3aXlrWmhqVXNUTytFemg1d2t2TThIMDdiNmxG?=
 =?utf-8?B?SzU1MjhaT0pyUVJpZDFQc25ZMEJDVFliNE56dVlIT0xVd3FFZWxWSkVIN25G?=
 =?utf-8?B?ZEgwcnJjRnNNNGJUWW0vUWdEeFFGUCtCOXVNTXNCTmdNeTV3NW90WmRrRUdj?=
 =?utf-8?B?OHBjcE4xUWQ3bzZQV2xZQ3NYb2xwYnc5ckxkS1BTZmR0Q0wyYktDQ3h0YjFN?=
 =?utf-8?B?ZXFWNmMyeWpndk9wMmxaL3lhVEgrZWJnNi9TZFJsNjg3bDlxZUdXU0JhbnNU?=
 =?utf-8?B?YkxrNGphQitEcURjN2JSR0hERXRxSVBQdndwSTJTWmNZcTllT2xESWtqd20r?=
 =?utf-8?B?dHlZekJlVVJveXByTlRNcmI1WW1NSDNHeFpRQjlNMGN6bFBLNGlPVGpibDhK?=
 =?utf-8?B?dUJJRFNKUUtLV3UwdVRPcC9KRHhTMWdTMDkyK09GOEdpbWVDM1dIVVZDVjJp?=
 =?utf-8?B?d2Y3bEE4bE9zOXhqbys2UHVDcGlZTW9SVHp2MXovc05RMVh4RUVaTndpT2Qv?=
 =?utf-8?B?M0pTWXF4UmloNVhROHdOeGRJcTY3c1RmZlpDYmtCVVhlZDhaQi9wdGR2c2l1?=
 =?utf-8?B?QWZWZVhIcFpaMlJMdWdCZ2tZdnNqWndHTVJmMUVDT3RFbDFuWVllVU9GSGc2?=
 =?utf-8?B?UzFSd0d1dlBGOEw4VGFQWE1zL1ZXMEtuRVRpL3d6RGU2WXZBRlR1MmFERUtC?=
 =?utf-8?Q?pDLp4KkOtBh8Y?=
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(376005)(82310400017)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Jh7Q4lurF/y8CnSy6QF1EhPqt+0vnUrqmZhxEm2yAZAGTu83r+DDuOUTmKlMlZW8dV4IfgNvMGyNsd1g/MRR8NOdRsoD7SIWAYu95AlCIcM4GKwaedFpOh3gkR6uUUjWb85kRfk1EAISDQbfrs3ZHO7v0Tn3uS25cvmYbYIETw7GezHyeBaixH9sc5sIbTHZyEPEdlhewoIzZv867nAZ/Vv6VZ/IV3P5Pw4oIpVy70DQ3Y2CDgu77UCIH3YSlA0Ly7Bl3+fDE8cWCSGn+KPXnmPR1+mbWNncS/mPnd8sZu12HR9X9XFieb8x9Ex6MNgzFun1MbrdTuvNCGBVs5Izy0DRfTcnBpSLjidaC1Bu7wcx+Y8aWeI0tlXxBX9bh2mpRdb4EgOFubxvK18TKNLijbT5njl9Io4MzvmwBvBwC620VW8OKANH74Eqjg+hDnllYNE6aQT/0bajQ/cJeVEO6xn7iiF1AaaAnBU7kMJmjBtOij8Ft0RGP+sEDwyDAq15J06zOhVJY4oljH0jL9Edis0M/p42xD7LZBKvaixY+COFDBBTcg4S4CRAHgCqt89b2j0Da424tWkqy6WHl0vJgToQ4JW5mv8DM5+JYPFrxX7I8HKVcT5zl3DXUM13qj8SUtRcK5EoRToo2FPRaUZ65Q==
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 18:01:05.6189
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe7a61fe-8441-4e31-c7e1-08dc80094f87
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002310.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR19MB5518
X-OriginatorOrg: ddn.com
X-BESS-ID: 1717011380-110790-12649-56438-1
X-BESS-VER: 2019.1_20240429.2309
X-BESS-Apparent-Source-IP: 104.47.73.41
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVhZmpkBGBlDM3MQ4yTQ10cjSzC
	QxJTnZIMnMzMLQwMIixdA80dTCNE2pNhYAuUahtkAAAAA=
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.256586 [from 
	cloudscan23-122.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
	0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, BSF_SC0_MISMATCH_TO
X-BESS-BRTS-Status:1

Most of the performance improvements
with fuse-over-io-uring for synchronous requests is the possibility
to run processing on the submitting cpu core and to also wake
the submitting process on the same core - switching between
cpu cores.

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
 fs/fuse/dev.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index c7fd3849a105..851c5fa99946 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -333,7 +333,10 @@ void fuse_request_end(struct fuse_req *req)
 		spin_unlock(&fc->bg_lock);
 	} else {
 		/* Wake up waiter sleeping in request_wait_answer() */
-		wake_up(&req->waitq);
+		if (fuse_per_core_queue(fc))
+			__wake_up_on_current_cpu(&req->waitq, TASK_NORMAL, NULL);
+		else
+			wake_up(&req->waitq);
 	}
 
 	if (test_bit(FR_ASYNC, &req->flags))

-- 
2.40.1


