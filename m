Return-Path: <linux-fsdevel+bounces-76817-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cEFeBEnUimnrOAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76817-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 07:46:33 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE9411774E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 07:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 452A53046DBE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 06:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE4A332EAC;
	Tue, 10 Feb 2026 06:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FOsUh5K4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012000.outbound.protection.outlook.com [40.107.209.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB6B330666;
	Tue, 10 Feb 2026 06:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770705931; cv=fail; b=awrjxHqo36tDwVHVG2qIORTRMnmPoNY066OUCzaujSivsTQx1/hICCiesuG0/Pc3dRz+/opPYU0OrbmbByq429t78JY0BZioAuEbpu9I3L40Y3mgoNmbkhbsRu4Bit1MANkufJABMeac+5LApYJeltZ/Nd1pOahXBQoJhkZKdK4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770705931; c=relaxed/simple;
	bh=QnwMkmmEXHNX8DR67HM7LkjGbfajuRdVCarEQ/IahAA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WSrlh+b/SWZyB/LA8f1/hpUcYg7PD6rjeVKSKdMQfVTmZkkEKmXQQUCBydVGPnwWw/ag4ncOuhCsA6SuAunOxAf+PddFoHSxnNDKy0JE7EN4Ckinjr/9m6MdMyK0zByv6QiQdksTdARJGThNJSM5PFlxo4qpcZ45M00al18GiD8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FOsUh5K4; arc=fail smtp.client-ip=40.107.209.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lDg7FDNmXTqksMYYwHnn52Uyiho23xr3TIeJgpVIJoLG9jDT7WclXFcd5w7wn6hVNeW/mpfZI/XqtnR5SAU0ahpx67l77KD/XZKwsaJp8Gymt0uNM412oWZysFQw/25LAfPAl+/BEI+SKQYmjlPZXLxEIG/GD617ITpOIVhfkd6EMObLrjaBhjWzXgnUOHZmHQEVxYZ6rTMplPEkqyrVX+f+Hllddr+g6qmFthSyETYTKzwZfgfG+M1QkitpEb7TM6ThOoR2eMjwxRo4wJVv4P4ww/rtdKEDYyN95M0WRI0Jdex12+3e3Q6iaFi/jsvscs0ZnMz6NkTKOjI0e9daTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uTQhBryCe4qIgl/Dqcvh3j+QwprY3KNo/DMYG/kWB28=;
 b=QvAf8J8OY7uhjleG557ppE8PKWN0ZB9/jNJu7epctO6TrrIQn/ry2FHadK57cfkGsXMpIb3WG1JzfySfytLg2eEC9n92R7a9TNvmuxofGLXmzSGnXK486FSyacgooBy8ezjXD3vO/h7cSNsHEhQ7n5/t4N1YG93d1YmxtlbkzeITzd9BG/7S+6y3CHJU8hVWk+Jgemy/IBAB2NGD+amfxX7IKgyObFMqsdoJRLwzjRFbJ+Zhp7wialDl8gx5WXiwwnEXiVhq+pgodWHLOxHjsgZNRuO8jvY5vzfVDaXJuWW/t7wcQPwJXtuJhx5w+4GqDsJ/PXOBR2LtwYD36l9W0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uTQhBryCe4qIgl/Dqcvh3j+QwprY3KNo/DMYG/kWB28=;
 b=FOsUh5K47ZDGmaA1MdIxdqomyU5NX7d3Qs/tVDKnV4yoWGtVHO47SYujX6tHZHe2/XxP6qSdmoLh5eFxzgpRRlku2aHarxLS0DfnpUAizTQHhTjjCZ3qlgixNbyRH1qv1eCFwnfRB8QNawshGj6r+N/WVEgbKWPdI/NnmTLAbBM=
Received: from SJ0PR03CA0030.namprd03.prod.outlook.com (2603:10b6:a03:33a::35)
 by LV2PR12MB5800.namprd12.prod.outlook.com (2603:10b6:408:178::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 06:45:21 +0000
Received: from SJ1PEPF000026C5.namprd04.prod.outlook.com
 (2603:10b6:a03:33a:cafe::d6) by SJ0PR03CA0030.outlook.office365.com
 (2603:10b6:a03:33a::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.18 via Frontend Transport; Tue,
 10 Feb 2026 06:45:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C5.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Tue, 10 Feb 2026 06:45:20 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 10 Feb
 2026 00:45:18 -0600
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
Subject: [PATCH v6 5/9] dax: Track all dax_region allocations under a global resource tree
Date: Tue, 10 Feb 2026 06:44:57 +0000
Message-ID: <20260210064501.157591-6-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260210064501.157591-1-Smita.KoralahalliChannabasappa@amd.com>
References: <20260210064501.157591-1-Smita.KoralahalliChannabasappa@amd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C5:EE_|LV2PR12MB5800:EE_
X-MS-Office365-Filtering-Correlation-Id: c608dbf9-0d45-4b16-b38d-08de686ff596
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?q8nBumf7gvm3Cla0mgKePLZHkCxi2YI3TAkqbyiOEEQr4BhgZPJfrQfxbOTC?=
 =?us-ascii?Q?KE36IrxWWyRaZkteSywW9aNEZqmfhCYeEC3AG+fH50t1B++BiXQzb+pqv6FA?=
 =?us-ascii?Q?edwfSApVcsTzEw0ILhAYgmx0mIAMm6ORuDvhChsZb8Zt1Yrr7fAzNY0elZJQ?=
 =?us-ascii?Q?D/f3qyCitqAziPS1w4VvFtc0wdW+lUO4SZlv144/qMrMaLQOxkN7rEfbKuAo?=
 =?us-ascii?Q?4wveTpUc5C3Obq5IBKl14rY7VDBGGi346FFPdw99Eb2TLUY/zWgnD7XiUuhW?=
 =?us-ascii?Q?Vpi91SVXQmBsqhdpi+a6eHlTFTT7iiyLLBQoIM56siFGxd6A+qNiM/mj1kxM?=
 =?us-ascii?Q?AJBVrMs2uGZdd8GvjJHNSaPU47e+ETA9qdnZHzcdQ2DQFRbzUkvlj5MacqKP?=
 =?us-ascii?Q?yNeyji67kQT3Ql1OCQ9d+IUtM8Dsyl4X925RPfFhKcy++0fj9RgqfOl9arau?=
 =?us-ascii?Q?ASzotBQT4vOHESwtNHqILPHm2E99pfbrNOdjnUeu5WRDngscCn/44u6y/tdC?=
 =?us-ascii?Q?d6MkdMAVvPWmlyOKw+on1mbXjz+40X7eSv1eAkDp3jmgdU1KtG+xeX+7+3IT?=
 =?us-ascii?Q?Ra2pObf3Z10DmG1qpTUl7xDBjZR4Soe1epxYrhWWSQvJc7UYZtySrTsggq1I?=
 =?us-ascii?Q?0DUOE4fj5KEUTtpfOcWVNsWCJhoyoM8ROpJx/lnQbaGXs++Ca/CsCsxjJZxg?=
 =?us-ascii?Q?4K7ZBfIU05F22ocXwsckYiQe/hqAWz2fRfgyrZixTjyT/459lVIraHoeHlag?=
 =?us-ascii?Q?RqHYgEbZeEWZX88N6behPRlM73PuBR5uJB9QWf8IYjx/JXb+yPZ76BxtU0T2?=
 =?us-ascii?Q?9UuDJMV+AJwHc29Jhmpkb2ZrszrSHWwI7As40+L10VxiXINallbVazVyViPA?=
 =?us-ascii?Q?1RbCQMi2ENjuopl9WW7Q/VMzJH8g7Ee+FQZhYFvwXFsBt1gZ8wfLJOLURGkC?=
 =?us-ascii?Q?vO8Od6ifhQ7ZfAenid6fXJrpl+eUAEvSurvLVcZFIfOoIK4FJ5cPoRwjnIf3?=
 =?us-ascii?Q?nbCV0P4kfbAnR9XQjkpHnXzvJXsh+8bw6AOGCdG1iJJB1YkpOIEm7Q4Sd11F?=
 =?us-ascii?Q?dZpguFPRIwUWZw6IkS8MV5QWfPxtWvTa1GE9n3Y6ep8H1zRJee+8sVIrGJRY?=
 =?us-ascii?Q?zcEW3ZhGFoy76cAvsqGfNAEXZqPxGxsqECJye07KpwWauFiIu0NeUx9P3m5G?=
 =?us-ascii?Q?zcTzyh/WSrMcZqhYQljXhpthS4OMtjmIrETWr+QQjmDGlPcro7dJMmEaVsM/?=
 =?us-ascii?Q?mM8o5L7VSflUj5/wcHU+5moF7nxoee2Yn/ov1ZR35iMhIyqNcpjVSEyzc5xt?=
 =?us-ascii?Q?UIY8WrTYbkv4CAoLwj/ar1sCdtgKb8YnNEt/x1G4wgT2Cgx2yCiUp3kRfta8?=
 =?us-ascii?Q?9wDdQ+fZLWNmOITgvfkGiV414ypuyUdZf7OIQ0MdvnWVNpktVVDo53gVhwAU?=
 =?us-ascii?Q?dCY4GC60t0JHDDdGC93jS/uMI1Au/N+67rQkDNqSQeAL4T4s89Uc/dbjVz6R?=
 =?us-ascii?Q?lfvze+iv/C6CixvEyFIqek2ZDF5Zg1aGI368ha7HHi8YI3DTZpeI0CE03hsN?=
 =?us-ascii?Q?pS+o+cA/Bxx7FZVQ79jPzE2Onrn7fKQYq8gnHQXTpYdC+9W5peROqejb+24p?=
 =?us-ascii?Q?vz/WYQMk2M8UDaokIbR6QNEnGrpJL2swWLNcrOCOerS8X7oI4CpZVA6j8+bd?=
 =?us-ascii?Q?BdVLjA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4QzJUuYWjMB2oHo6u2IUCTvsPA+WusDg8BRWZxE7IaRiEbw4fSbxxYLPJI0mwFFayItfxMXDvDcc4YgK8+ZrIibOimVvhDEK5Y7uYAGe8p855Xg2S1yKq3dRH8r5ypZH+9GyQenzAGlnWxXWYMd0G9SfEK9X2cUVm2AIoS1LXoAs+CfE/9AqMTpYE8ARndrb3A+ILWU+oNJwI2MKyS9pOeIqggG+V8BIOm3CKCv3DRU2MQc92aPfNP+NvPGKRzMOlswLHZ/OLpSz4adKOtYdNMKaWjGrONL9iFV3B3csogddp+vIFY4289skAvVIrShnuAsvd59jy538rAWvDtTjo+EMarYMOE7DZjwnD1oBq8JV/iJZt2Kr7ExDXA9A40kQ8aZweSt6AzCzm3hAXuJBAEv3sDPMrac8vAOToTjAu8t/syZ0xkIb1oK26geH5HB0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 06:45:20.2884
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c608dbf9-0d45-4b16-b38d-08de686ff596
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5800
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76817-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,intel.com,huawei.com,amd.com,stgolabs.net,infradead.org,suse.cz,zohomail.com,oss.qualcomm.com,gmail.com,fujitsu.com,linuxfoundation.org,alien8.de];
	DKIM_TRACE(0.00)[amd.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Smita.KoralahalliChannabasappa@amd.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:mid,amd.com:dkim,amd.com:email,intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 7BE9411774E
X-Rspamd-Action: no action

Introduce a global "DAX Regions" resource root and register each
dax_region->res under it via request_resource(). Release the resource on
dax_region teardown.

By enforcing a single global namespace for dax_region allocations, this
ensures only one of dax_hmem or dax_cxl can successfully register a
dax_region for a given range.

Co-developed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
---
 drivers/dax/bus.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index fde29e0ad68b..5f387feb95f0 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -10,6 +10,7 @@
 #include "dax-private.h"
 #include "bus.h"
 
+static struct resource dax_regions = DEFINE_RES_MEM_NAMED(0, -1, "DAX Regions");
 static DEFINE_MUTEX(dax_bus_lock);
 
 /*
@@ -625,6 +626,8 @@ static void dax_region_unregister(void *region)
 {
 	struct dax_region *dax_region = region;
 
+	scoped_guard(rwsem_write, &dax_region_rwsem)
+		release_resource(&dax_region->res);
 	sysfs_remove_groups(&dax_region->dev->kobj,
 			dax_region_attribute_groups);
 	dax_region_put(dax_region);
@@ -635,6 +638,7 @@ struct dax_region *alloc_dax_region(struct device *parent, int region_id,
 		unsigned long flags)
 {
 	struct dax_region *dax_region;
+	int rc;
 
 	/*
 	 * The DAX core assumes that it can store its private data in
@@ -667,14 +671,27 @@ struct dax_region *alloc_dax_region(struct device *parent, int region_id,
 		.flags = IORESOURCE_MEM | flags,
 	};
 
-	if (sysfs_create_groups(&parent->kobj, dax_region_attribute_groups)) {
-		kfree(dax_region);
-		return NULL;
+	scoped_guard(rwsem_write, &dax_region_rwsem)
+		rc = request_resource(&dax_regions, &dax_region->res);
+	if (rc) {
+		dev_dbg(parent, "dax_region resource conflict for %pR\n",
+			&dax_region->res);
+		goto err_res;
 	}
 
+	if (sysfs_create_groups(&parent->kobj, dax_region_attribute_groups))
+		goto err_sysfs;
+
 	if (devm_add_action_or_reset(parent, dax_region_unregister, dax_region))
 		return NULL;
 	return dax_region;
+
+err_sysfs:
+	scoped_guard(rwsem_write, &dax_region_rwsem)
+		release_resource(&dax_region->res);
+err_res:
+	kfree(dax_region);
+	return NULL;
 }
 EXPORT_SYMBOL_GPL(alloc_dax_region);
 
-- 
2.17.1


