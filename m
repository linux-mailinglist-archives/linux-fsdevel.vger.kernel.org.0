Return-Path: <linux-fsdevel+bounces-76818-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJ/zElXUimnrOAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76818-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 07:46:45 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B4802117763
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 07:46:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 27EE0304AC12
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 06:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 122C032ED29;
	Tue, 10 Feb 2026 06:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Zr2k4KaZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010014.outbound.protection.outlook.com [52.101.56.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7EC330659;
	Tue, 10 Feb 2026 06:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770705939; cv=fail; b=HE8dSvuBjKmI/p/EmFU+4FEVaEpdqKmMQ1GWJY4nLtXTzbFlUdEKtsinCshzGrnih3e/Hd7+EnJF3k59C0XHRQky0nKLoYtKMLMGp2KTEF9WXq4AOu0VaN3GU9Xo8LyW4y+giQ1RMgixskAYoFW+3o6EI1hmWzKROh6r6pzfg0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770705939; c=relaxed/simple;
	bh=SJ1jSJCnlgfeuPYnwV5eZsxa6Y2f78GlQvpg8+hspSw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a+voQujsTU8bAK70FFFbGnJIp3fMpRzL6ZjZwP5L8KYqXMddrrAaqdgP14WLgurKBbkll8vj8+8PEUkoK/+8iWh3D8RI4Q0trpi4RYMwPEJUWXCgFoF5zU0t6BUkxJFz2337ExMxztmrvX339CWVEHQusWAjf65Pnhd0hcLEYkU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Zr2k4KaZ; arc=fail smtp.client-ip=52.101.56.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rzCwRU4iyqFBi8QZTw7Nmt3alKM9vGRjpenrHRVIp5xLpJWbZXmQhqU+yzShjrvyNRr6nLE7TcXbr0/uhFDX+jshVEC58V2lilAxphvfA/utzMpbzmsubu+6/BlD1iKT3bDUEyukOLv98kzqn2eev9i/vJEjf7ox7FPHw+PAX23tnrPmVqU3We0p7i3dFf9TfCsgdwaqZbvEJyD/IXGFhk4B3u9wqJHfRGkrNEUHpKriZVp7747bLRYKOefIFKYK+REzClUcLPEEQd/HN3usVyNtx8g1qnlDFSIoQgx3cU+lENjPYY36/BJFFHeemu/ih+ekpKASvUpOQYfW9BeXxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VVzxHXcbR89bTpoQN49HpyrhE+9QKCmWqOlXqrpDosU=;
 b=U+Qv3ixOorqNSh7BSHOK6gqzT/MdpBXD+2j86qWH0k4+VcXUrMuImK3OCx/+G++f67oP8h4XLbi8F0ryblVEDOU1mdQB0mrPqu2nJ2F/ee+Mvmt+KcUMcITZb6Or45EpzWIrhOwy7i6S5ie98Y70psRS6HVlvoVtVhwZWkUxWVEn66meUhLOZYLiTu2AFpLOaZFUxNSB0O0DRhpByVfrhY5uO6hc2adgWQ7cMi3eu7AktcfV+duLBrOZbBiS4ZYlagS6pgCkdGZit13cgcWmKDz7fgu8MIE3ohw61kkDHkzayv5A2D3oEXsuRXBKIAAoKbi8ahvUfy2jTZQg1TBQeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VVzxHXcbR89bTpoQN49HpyrhE+9QKCmWqOlXqrpDosU=;
 b=Zr2k4KaZ8lIU2L6dEAdEGtgDrTy84IXkwaWDf/O9wcFOTUsQA3umwyyyBm7Eb7IUn1bRcqd5CFRn6QddvIJDOTn6imK+FZ23zre20Jo4QAWlQcL9bfAdSb4sop/22bEQtrRbDEJvlYfix20yhJxokSpuvpsl9ZMKUbpOYbdEr2g=
Received: from BYAPR06CA0003.namprd06.prod.outlook.com (2603:10b6:a03:d4::16)
 by DM6PR12MB4217.namprd12.prod.outlook.com (2603:10b6:5:219::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 06:45:26 +0000
Received: from SJ1PEPF000026C3.namprd04.prod.outlook.com
 (2603:10b6:a03:d4:cafe::2b) by BYAPR06CA0003.outlook.office365.com
 (2603:10b6:a03:d4::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.19 via Frontend Transport; Tue,
 10 Feb 2026 06:45:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C3.mail.protection.outlook.com (10.167.244.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Tue, 10 Feb 2026 06:45:26 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 10 Feb
 2026 00:45:22 -0600
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
Subject: [PATCH v6 9/9] dax/hmem: Reintroduce Soft Reserved ranges back into the iomem tree
Date: Tue, 10 Feb 2026 06:45:01 +0000
Message-ID: <20260210064501.157591-10-Smita.KoralahalliChannabasappa@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C3:EE_|DM6PR12MB4217:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bbb49bc-3781-4676-2bac-08de686ff953
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NmcD/ItVf04GiP5LNfDpfy9S8NQ4QBLhbsQEbdUPw5Xmu6db7PmTZrUn6oWq?=
 =?us-ascii?Q?GgvvaqRx3aL1CImPIdYvsSlGLxNzEibELv55EpkGxtLqfMqzxoclfYU3YWsE?=
 =?us-ascii?Q?1g8KecZ2dIplGwLV6OCZntFDqtqft5xH8Utd4YQufoz1OdLM6/r004cuSM02?=
 =?us-ascii?Q?FHRpA5kVhC+CY0HibdqN9Hymj/wy5y+IzcxJovbJ0s0gCGWu3Trl1JYsi2j5?=
 =?us-ascii?Q?+tZeGYohmw4F1O18ZeXSGHbNZhY/kceSbmm+nQKrXpE0v5biYCO9Ps285dX4?=
 =?us-ascii?Q?rAMJSc82knpsNpUU/KUYRLnSzfaHYMrRMjkDqORNJmHjgM+w/g5SnkbfV9Jp?=
 =?us-ascii?Q?qeyMWU8fOas0viAlasHYpdBnwHcn2NcnOZ/lXx486gqZEWhOP3NlZKOmSB/I?=
 =?us-ascii?Q?BnDdYihDQCdGvPAnBS0nCJqw/+++4UDkFhq+g8a0g4gw1kX0u+1uFEWGj9Y7?=
 =?us-ascii?Q?WNMQQ3CRfKQbIBjTxF87Sgk+FJFe0FxWFJ6ZFCU2ZAhqA0JAp/PcHbg//f7K?=
 =?us-ascii?Q?rIMJvi058xkWLqjTRgUgmdWO6YmCxWYj3axeV9Y5q5CJ035abyIgRDVPwwh7?=
 =?us-ascii?Q?BsmhSw+Iht1yfSXd89kyi4PE+YkviYHWK3y/0iqDv0d4rZmkbfIrhvcYGv29?=
 =?us-ascii?Q?LAMnjvJzehxAJQRfMiE7teVpSU1xMpGjuoxp9LVmWaFlJHOd/yS7rVxu6XLj?=
 =?us-ascii?Q?UyxNuCA1cSuDFDDbUgzKZgCFz3/63cz3hDEBNkpeFHNTo8aeD7EW2xqO7XxC?=
 =?us-ascii?Q?Ytkugh+KIu0nDsjdh42NYLoypJCDxVHUL+uCZZm9KUlrYEJk74CxT1kOnley?=
 =?us-ascii?Q?K9borgjpFlp13YxB7RxW1prYY4OsMu6MuJeAqWUXdEl1B0G36VLCInA12Zqx?=
 =?us-ascii?Q?gzUpvEO0It1bK+4g/yvJdPUvN67+9dDdEPoCr89vwnFBTx9pefkN3AXVeQN2?=
 =?us-ascii?Q?+/4apsnk2IXOZDF5JX7IbfX4yCgn7sK5SoH8qODcgE1OL0jg/ByBzgTebA/P?=
 =?us-ascii?Q?fDXReuJfRMCszXkexpTh6XvELXIbfBiDm0mgEzR/21fYikzuOyPwj+/BfvB5?=
 =?us-ascii?Q?SfOQi4UBpn6uhq1HfGnwD7ebHgPLUMJxHuepZvov1Ee3OfhgGQCTtJU7Bcwc?=
 =?us-ascii?Q?1/Wy4qNgyztXxsRs8nZQph7zEOMDKQys/Zxomw6pyByknJ3QZJuPLDkaQdtD?=
 =?us-ascii?Q?tC811Ltr6m+scEgxonjZB3z5Aj/yWgt5sMMsuv/eQJ4V93RpEyXhnO5yd+D0?=
 =?us-ascii?Q?y0pPAaNplRupgxbTgW0U5CaH/meQ5GM2RdwP7dhAWKeDC/STqYXaZLIVpU4+?=
 =?us-ascii?Q?p2JQ2ZEAcUz3E6iKdwxvzKjauaPf3wK7QbTyo5FKEOmcgQ/GvUXlRbcWhajg?=
 =?us-ascii?Q?+qdHnANCzfd1Qc6Nb5SJv5gJIgGNVylvGMyBrV3uQWiQx85jK0DwjPSRqUG3?=
 =?us-ascii?Q?YD+dd+c/fAdcG9JqHjMZNEs2FSQMgLczcmhv0gL6xVrBlEfhH0i0YA/eYqc1?=
 =?us-ascii?Q?p0EeMOd76wc0uZpEWbAapw1LfCSgruUTeQGZlPlLI2s+gk78hPEMHjVtXrsi?=
 =?us-ascii?Q?TNKOxPPAcOShjX+nlTi1N7OdczGeKaQLgAOia0Z4G3o6bktlJBBIjNFvdCiV?=
 =?us-ascii?Q?KoIODzH8suw0cwPMwj0jRKmTBbB7Eas1l7YdBJYd6yYaPyxIfwvTAnmXYriy?=
 =?us-ascii?Q?JfW6hw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	SMOtxojWwKycEeVOEOhdbFwMTvb7Yvr4F4NiFxOYn0yJRxt+dsYDdpcV+jtJ2RGs/LnFNp2C2j2BsE5MqGksCC/a+2jcKAnd6dNuuDRKITdz0Cuw16lQzME0tBpWK0kn7Jz6RJ1QJP85ij8q+xsDtxshHuxXB9JewC/tV7uWNmE/4+wq8QGdwsHXBxZdvVagY0VyECfeeGCoWdbzkk9l4e/mCs6dxvNeV0s80CWg/5mRMOyBV90fzgs+J2xdNK9hUZ7NV0OhB/63L9vVKZGGpJMtvQ7npQRGE/jUeiej6t/MOB4zL7dL40EftacAaonDQPgu8ANmUqf5VmyAdYAvUfkLwoBcONlCVRUwYwFp3yuKoDxhlsPdOlc4wn/vmnEiuy5G2DpapEIMOEvrclfe+vSdwZMSfeUzyfOb7nJLcM0gL0OsBrlUYOTcTzyRtNy0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 06:45:26.5483
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bbb49bc-3781-4676-2bac-08de686ff953
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4217
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76818-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,intel.com,huawei.com,amd.com,stgolabs.net,infradead.org,suse.cz,zohomail.com,oss.qualcomm.com,gmail.com,fujitsu.com,linuxfoundation.org,alien8.de];
	DKIM_TRACE(0.00)[amd.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Smita.KoralahalliChannabasappa@amd.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,huawei.com:email,amd.com:mid,amd.com:dkim,amd.com:email,fujitsu.com:email];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: B4802117763
X-Rspamd-Action: no action

Reworked from a patch by Alison Schofield <alison.schofield@intel.com>

Reintroduce Soft Reserved range into the iomem_resource tree for HMEM
to consume.

This restores visibility in /proc/iomem for ranges actively in use, while
avoiding the early-boot conflicts that occurred when Soft Reserved was
published into iomem before CXL window and region discovery.

Link: https://lore.kernel.org/linux-cxl/29312c0765224ae76862d59a17748c8188fb95f1.1692638817.git.alison.schofield@intel.com/
Co-developed-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Co-developed-by: Zhijian Li <lizhijian@fujitsu.com>
Signed-off-by: Zhijian Li <lizhijian@fujitsu.com>
Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/dax/hmem/hmem.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/dax/hmem/hmem.c b/drivers/dax/hmem/hmem.c
index 85854e25254b..c07bf5fe833d 100644
--- a/drivers/dax/hmem/hmem.c
+++ b/drivers/dax/hmem/hmem.c
@@ -59,6 +59,34 @@ static void release_hmem(void *pdev)
 	platform_device_unregister(pdev);
 }
 
+static void remove_soft_reserved(void *r)
+{
+	remove_resource(r);
+	kfree(r);
+}
+
+static int add_soft_reserve_into_iomem(struct device *host,
+				       const struct resource *res)
+{
+	int rc;
+
+	struct resource *soft __free(kfree) =
+		kmalloc(sizeof(*res), GFP_KERNEL);
+	if (!soft)
+		return -ENOMEM;
+
+	*soft = DEFINE_RES_NAMED_DESC(res->start, (res->end - res->start + 1),
+				      "Soft Reserved", IORESOURCE_MEM,
+				      IORES_DESC_SOFT_RESERVED);
+
+	rc = insert_resource(&iomem_resource, soft);
+	if (rc)
+		return rc;
+
+	return devm_add_action_or_reset(host, remove_soft_reserved,
+					no_free_ptr(soft));
+}
+
 static int hmem_register_device(struct device *host, int target_nid,
 				const struct resource *res)
 {
@@ -88,7 +116,9 @@ static int hmem_register_device(struct device *host, int target_nid,
 	if (rc != REGION_INTERSECTS)
 		return 0;
 
-	/* TODO: Add Soft-Reserved memory back to iomem */
+	rc = add_soft_reserve_into_iomem(host, res);
+	if (rc)
+		return rc;
 
 	id = memregion_alloc(GFP_KERNEL);
 	if (id < 0) {
-- 
2.17.1


