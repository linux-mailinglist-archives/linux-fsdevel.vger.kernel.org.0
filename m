Return-Path: <linux-fsdevel+bounces-74972-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AIvOAFGucWlmLQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74972-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 05:57:53 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D00CF61D68
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 05:57:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AC7B1507A07
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 04:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE8B46AF3D;
	Thu, 22 Jan 2026 04:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="O2LeoZFO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013017.outbound.protection.outlook.com [40.93.196.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365AA4657CA;
	Thu, 22 Jan 2026 04:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769057769; cv=fail; b=LmQgUA8XEO9OBZ1VGTHGz+m1LZ9t2zry9svuwXX35tTRv9VhMgtGK+wx4Q6F47da08Gymg6FfqNznmgRIs1I/1oqG2J2TFpFtWZCdmBllh40KNqiEY220+MyzEJoSP+05xEM5QuixxwW1cceuZieEG5W0DDw8YyilvyAbwWtl2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769057769; c=relaxed/simple;
	bh=+myE2QGrk598XYj3Im84e61E/ny6REfACYVXtexMRqA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i3KR/IGvoVgGX2rlNBXdnu3Fs27/padEDuB3DlogyizaEHY0+0LwvnQyueZMjT+aYVSduKqOJRP7T7E7d2OHOTyhg9BhLSuntI6mFObjMziyYXo+0g7E79FPnd7Trb0w+pOcM9sVtGWgtwfeDnvIrI6whwg1KBXZJ+/zET0Mb4o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=O2LeoZFO; arc=fail smtp.client-ip=40.93.196.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mNVOP45wnhU2nENrFmwGDopxmXrMhUhOz42/ExDO95z/AI4URSFgIRXravXAs2MqQUgJWJ+MH2s8lLB0pAWslZqwM+shwF6pMdTd3TXEQxXyFiPEPZ8iER8er502N9EedMP/pydByJ1k+1+fMdL63RLeXZJDYPHaPAOL/mCI9SzytBTZQxHodgPue9OLiXYeZEQ+wFPDKDUZrKtTKcUtFJbOPGSewP7Z4kMxwN+u3mAM14E7zNaiVzQ2nZWpMMhvqMcUBKBGmnrezyQsbYQy5XHtKFazUGF8+J97LCyFbly9/mLolyBPsEV3h8o1LleDOSYJQfNNnsLHwWgTnjfJ+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+5Xs2RQt9kdI7iDjQpF9m4riBKoVDj/ozCX2xCM51VI=;
 b=wnVJifUyDf0Sw3su6HVS1frOIyKXN6zUhO/nhRDmxEI4PvjX3HWQBlLnYMagYWLU6GfGed/ze1YIVABzc4U6sumunXipMwPXKf7oSssde9ot1pDRnp+a0Mb8Ede7srTTUp6guFOXH/Z1n0ZeqBoIhxKYEUgejahO/9AWDqSWg3anM9/C4rfkqnEURTFeE5zKZCuw2pnc9FhTyLHaxpA4NVm8M5EqP5xMR3Pdm9+F/efX+52P5bdo+JtBj39VunH/T/klv9SX9NhcwIeKy6CqHxFGRD/KJjoSSH/eLV+OEPeJdmv0LBh4y/P999iusj2k8f0gw2H9shGTP8pfy3Targ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+5Xs2RQt9kdI7iDjQpF9m4riBKoVDj/ozCX2xCM51VI=;
 b=O2LeoZFOkjSLpgVDalH/ZXy6WE7EdGkfyWZzChBLwPw0x+Y/7eI3W+kc/KdrEiiAPUJ/tDP1gOYCXNzHjZVw23GzlZ18iAciSLTDuWxSLXZXGPLfOWPvUhwAb5TypcK69iAAOr862lhEx+6BCfmbnYD4LUsYPjobpckrfGKuo1s=
Received: from DS7PR05CA0097.namprd05.prod.outlook.com (2603:10b6:8:56::26) by
 DM6PR12MB4354.namprd12.prod.outlook.com (2603:10b6:5:28f::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.10; Thu, 22 Jan 2026 04:55:59 +0000
Received: from DS3PEPF000099DF.namprd04.prod.outlook.com
 (2603:10b6:8:56:cafe::f2) by DS7PR05CA0097.outlook.office365.com
 (2603:10b6:8:56::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.3 via Frontend Transport; Thu,
 22 Jan 2026 04:55:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099DF.mail.protection.outlook.com (10.167.17.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Thu, 22 Jan 2026 04:55:59 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 21 Jan
 2026 22:55:57 -0600
From: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<nvdimm@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>
CC: Ard Biesheuvel <ardb@kernel.org>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>, Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso
	<dave@stgolabs.net>, Matthew Wilcox <willy@infradead.org>, Jan Kara
	<jack@suse.cz>, "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown
	<len.brown@intel.com>, Pavel Machek <pavel@kernel.org>, Li Ming
	<ming.li@zohomail.com>, Jeff Johnson <jeff.johnson@oss.qualcomm.com>, "Ying
 Huang" <huang.ying.caritas@gmail.com>, Yao Xingtao <yaoxt.fnst@fujitsu.com>,
	Peter Zijlstra <peterz@infradead.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Nathan Fontenot <nathan.fontenot@amd.com>,
	Terry Bowman <terry.bowman@amd.com>, Robert Richter <rrichter@amd.com>,
	Benjamin Cheatham <benjamin.cheatham@amd.com>, Zhijian Li
	<lizhijian@fujitsu.com>, Borislav Petkov <bp@alien8.de>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>, Tomasz Wolski
	<tomasz.wolski@fujitsu.com>
Subject: [PATCH v5 4/7] cxl/region: Add helper to check Soft Reserved containment by CXL regions
Date: Thu, 22 Jan 2026 04:55:40 +0000
Message-ID: <20260122045543.218194-5-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260122045543.218194-1-Smita.KoralahalliChannabasappa@amd.com>
References: <20260122045543.218194-1-Smita.KoralahalliChannabasappa@amd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DF:EE_|DM6PR12MB4354:EE_
X-MS-Office365-Filtering-Correlation-Id: 34af48d4-4715-489e-11d1-08de597288e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/w2wGIYbX8LKVg4zVf6P5cSgPTPJxkTUsRmmig/KQ0xYp9dc7QUpiWHbXHOg?=
 =?us-ascii?Q?qS/4eDV0hY/H91jy2OOdAbIaPIAfAr/INfY+/RDtdmTZ6D1iFdByRVMyRY+F?=
 =?us-ascii?Q?xJKAtgJK0FP8zhy6TB2+kIy4IXi7qeWx3WypCNhw2sdIqKpsibKsDc+ECIjg?=
 =?us-ascii?Q?S5f51SALKW9MZQcYkN1KXzeVeiIo38NliD+dpDWA2LZ9we5E2Lnjl2TPletk?=
 =?us-ascii?Q?TV3wpu7b1aA1QFzFYQIxQCnhcxexwDXbOsChMFHlHTPpJ5LGS3LjPEzNeDE1?=
 =?us-ascii?Q?70E8S+eHAfg57bmU0j2vxev2lwNf63yscFqsiIN91/FPrPoWaHdzxL/tRelu?=
 =?us-ascii?Q?Wlt4nMkrsxBCFrRZrqk1i2+I4MRGF3C9ZQwtWEVn9njVx2xLY0Mc6nk4rmsw?=
 =?us-ascii?Q?tdEZqeQ0rtvcUwfTXOLMxqBvrW1ZU0NiXvhtjw5+Arp4UL7WfhXovjHkFoJQ?=
 =?us-ascii?Q?GwDC5tLHm2RDZa4B28TxZm10s1z3GxshEnQ/6AQKD4nrAvhoycGWuJfipuuT?=
 =?us-ascii?Q?r4xVAYwWZF2ytRHhcSDRPGMp37vCrG3YzOqosdabbbSTDG+DvflVUkaa1yil?=
 =?us-ascii?Q?nREglkl9xBGkE6hV8osmoagE3uo4iRvZS/vb5CCWQMejXTDHIHiU3WClTA9L?=
 =?us-ascii?Q?zPjKTX5odvCJx4ScStbCTmQBNpl9oNy6QL2Q8DUGG6+w5HpSA1l2ZAV2Fb0A?=
 =?us-ascii?Q?6SEXTNaapCj85OXAWbzQWVKAzpHuQSZZL2tGtoerRKMayNtaQZe9qQtyNbbu?=
 =?us-ascii?Q?D5kFqAft+41WPgONKCngWSXg8SQZ99LGgiZmLVhNYVp00VvRDh9oFJ6SwXI7?=
 =?us-ascii?Q?DmolGXi2Q3QQDaSAAGeT9fn3cXTJ6SKj6JduaCkyJnSUEBmOgiTd41+AGqbC?=
 =?us-ascii?Q?5l/un+E1FdFVWvaxPB4nXmpZzswwSr9dxq/L2RUCFH02T8lP4tSEUijct/UC?=
 =?us-ascii?Q?xP1vN1eWNqAKdaj91XaDQuAJt4Ft/HctevxGOw37l8+NIJ0BEXgS/SFduLfp?=
 =?us-ascii?Q?VnU6Ol/922LU9XdmEA6yM/ooUPUApwxkrufY8ipcs1ZINNqkwBpFhUaBgRXw?=
 =?us-ascii?Q?PVsA5oK2Y+CUMmnK9+ljU75Ta8F/J+EOEQSQQHvWct+z1ugpWtUOcJfXBLaX?=
 =?us-ascii?Q?8QNJPoviW9GEHeakEcFVNSUm5pPUKmvPFCl/bksiT/kaZaHNNx3i5ZkBFgwQ?=
 =?us-ascii?Q?bmriAUOG3EV9S+1O40f/Q3lUjLshG6gtx3VJTPl+ZEPJLaZGFH0lsh+MtQWr?=
 =?us-ascii?Q?p/E5mGG1SpeKqkCTh2pwiHmF8n1N2cA8lYbF6d+BJRbtHZheTQI/TgQC8m6W?=
 =?us-ascii?Q?+S/bJPYmZtPaL/H1S3VNhJWjfAdsQJA8vSNX9T6s+WS7m7jR1wIOjDrGEql9?=
 =?us-ascii?Q?3DEmW4WnUbLxbfXzO9/Aiur/E97P1zYd+7uxAIZi0PnfL/x/tTM9gista9bm?=
 =?us-ascii?Q?0LqKI/8sRiREme89i++5GXszwkPCcIU9RtKvFLG/GHTIbSbVF1GnSCCOBjg2?=
 =?us-ascii?Q?ksD+qParZZrWqSUIP3EuuiLrrUR6otGwKCHvfLhdwpk1J58+TLCejwaGf3eb?=
 =?us-ascii?Q?AZkkwtL035Zls+sgDoN3w8nok2WDnNsge7sCWcF/g7BjPOo8vu53IqH0yCGe?=
 =?us-ascii?Q?lLI2OePlieAi0u6USwLiRsTKkxLaexc+yEbWIRpCY6zUBRpbY4BTYh3tFPgs?=
 =?us-ascii?Q?vYeFVg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 04:55:59.0292
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34af48d4-4715-489e-11d1-08de597288e5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4354
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-74972-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,intel.com,huawei.com,amd.com,stgolabs.net,infradead.org,suse.cz,zohomail.com,oss.qualcomm.com,gmail.com,fujitsu.com,linuxfoundation.org,alien8.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Smita.KoralahalliChannabasappa@amd.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[amd.com,quarantine];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns,amd.com:email,amd.com:dkim,amd.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D00CF61D68
X-Rspamd-Action: no action

Add a helper to determine whether a given Soft Reserved memory range is
fully contained within the committed CXL region.

This helper provides a primitive for policy decisions in subsequent
patches such as co-ordination with dax_hmem to determine whether CXL has
fully claimed ownership of Soft Reserved memory ranges.

No functional changes are introduced by this patch.

Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
---
 drivers/cxl/core/region.c | 29 +++++++++++++++++++++++++++++
 drivers/cxl/cxl.h         |  5 +++++
 2 files changed, 34 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 45ee598daf95..9827a6dd3187 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3875,6 +3875,35 @@ static int cxl_region_debugfs_poison_clear(void *data, u64 offset)
 DEFINE_DEBUGFS_ATTRIBUTE(cxl_poison_clear_fops, NULL,
 			 cxl_region_debugfs_poison_clear, "%llx\n");
 
+static int cxl_region_contains_sr_cb(struct device *dev, void *data)
+{
+	struct resource *res = data;
+	struct cxl_region *cxlr;
+	struct cxl_region_params *p;
+
+	if (!is_cxl_region(dev))
+		return 0;
+
+	cxlr = to_cxl_region(dev);
+	p = &cxlr->params;
+
+	if (p->state != CXL_CONFIG_COMMIT)
+		return 0;
+
+	if (!p->res)
+		return 0;
+
+	return resource_contains(p->res, res) ? 1 : 0;
+}
+
+bool cxl_region_contains_soft_reserve(const struct resource *res)
+{
+	guard(rwsem_read)(&cxl_rwsem.region);
+	return bus_for_each_dev(&cxl_bus_type, NULL, (void *)res,
+				cxl_region_contains_sr_cb) != 0;
+}
+EXPORT_SYMBOL_GPL(cxl_region_contains_soft_reserve);
+
 static int cxl_region_can_probe(struct cxl_region *cxlr)
 {
 	struct cxl_region_params *p = &cxlr->params;
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index c796c3db36e0..b0ff6b65ea0b 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -906,6 +906,7 @@ struct cxl_pmem_region *to_cxl_pmem_region(struct device *dev);
 int cxl_add_to_region(struct cxl_endpoint_decoder *cxled);
 struct cxl_dax_region *to_cxl_dax_region(struct device *dev);
 u64 cxl_port_get_spa_cache_alias(struct cxl_port *endpoint, u64 spa);
+bool cxl_region_contains_soft_reserve(const struct resource *res);
 #else
 static inline bool is_cxl_pmem_region(struct device *dev)
 {
@@ -928,6 +929,10 @@ static inline u64 cxl_port_get_spa_cache_alias(struct cxl_port *endpoint,
 {
 	return 0;
 }
+static inline bool cxl_region_contains_soft_reserve(const struct resource *res)
+{
+	return false;
+}
 #endif
 
 void cxl_endpoint_parse_cdat(struct cxl_port *port);
-- 
2.17.1


