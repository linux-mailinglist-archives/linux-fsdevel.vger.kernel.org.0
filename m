Return-Path: <linux-fsdevel+bounces-43403-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76269A56000
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 06:30:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1FAA17292A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 05:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98476194A53;
	Fri,  7 Mar 2025 05:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Qn54MTsy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E3B1922DC;
	Fri,  7 Mar 2025 05:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741325403; cv=fail; b=kJJVFVB+vnoX4Q4OmFyfrCiY0pBWs7WyyWJouvmLaU0Fqx9v6ONcfAmuV2btGe9J07NLj1X5Ghi39zwPcCqwRjZv1uW36FZg3aniElOCY90p1FtPUybWVPKj+/O9W4Tbt5INBoWxFwfBe33LzUNF3eshUGcYQGT6oha1Jx68r6M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741325403; c=relaxed/simple;
	bh=RHQszQJBCkYI8rF22lGfiCrZC6wKb4h9A1ftK6cIElA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aHHBa6ZOGm07V7eZISIqLggW9zux0Axxavspc1i0NXUj/QqHUYhfcqGXeXKitPWjzM4zNorBNGVEbv3xGge8AWG16rHiHX75nfzBj1W1yPVDeoe6i8uQ/OuWhtd/1O7kOcQLkJK4SuQmGr3yGTl6f8vF3vIkvmt+jQy9ArtUCKM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Qn54MTsy; arc=fail smtp.client-ip=40.107.220.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iGaabzeDk4IadjDXN7HFhMdwwC6yTWezGnW4H04iEPDjng8b2Ji9UMwygdPHGrCDFr04Qwsrug3FSHuOGve1PbjNv8NvQI6MldKOLC2t2FtH2vTRyJ9Vm27Jns99NECleFB1XdIZi5nfa91r2Fzrry7ceTM0Bsz65bJGVohWYvO8t39dru48sQwAi5EizILCOc6VcOb4ftR8ZROBUHCO81u47mZSU7ikdg+lLndowcivVk5PfOq8q0aN3b58mOZCvuNUmnG8z+j+QrkphjU/zDsU49Yeo9bMykXLxONfuO/q/OzU9LNmtIwrKmaD3j024lIUsSBMZlPDI/zLqF+axQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v4dq2kVhCacGMXsY+LnxsOmAOHoZ6wqtkfgmdeQqVAQ=;
 b=CiTWsihHwOvrqLgCg3MK1ZCYgGDJTNdWZQ1kxYpJHbvzHhzgOKIpRJ9p6jmEGSQmeIaU++hbsWmVOpjrCkmGJmuTC5jjybHCNvPSRTbq3ZeqUXVjyV1C0zvUHcNABCgkbduwCMduyxgSPo8wQ/dXBGxLoGbSdSAYDqHsT10tfVTrQM+P1VQ/kOyTZXP1tFZZrYcjMp+PMebq26wyzoVcXUHgcS4pY82fFm818GPVoEHCftM7lWWAcU38PFssvTkfpUHrJNbrYldO2RaV1Fyiit9m7vf0Er6mXgy4J4tMcC/M5/OSJTqrRYolPz69eWjSKFyGjlITeEqETpH69fIhUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v4dq2kVhCacGMXsY+LnxsOmAOHoZ6wqtkfgmdeQqVAQ=;
 b=Qn54MTsykmvSccaXjwkJ7nV9VJEqgMJVknW6KrybmT5j6lNzzfKx0s83KcHByMORJhEcUcEU9/mf/cPl5xIBi39uSl01b6g/wSVLamtpvgjJlilYE7gpE/SdESIqXdQt2QwejFhV8d5gEMOKEf9atGXhx8ecjhSSOVGKDvlliPo=
Received: from PH8PR21CA0006.namprd21.prod.outlook.com (2603:10b6:510:2ce::18)
 by PH7PR12MB7236.namprd12.prod.outlook.com (2603:10b6:510:207::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Fri, 7 Mar
 2025 05:29:57 +0000
Received: from MWH0EPF000A6730.namprd04.prod.outlook.com
 (2603:10b6:510:2ce:cafe::fe) by PH8PR21CA0006.outlook.office365.com
 (2603:10b6:510:2ce::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.14 via Frontend Transport; Fri,
 7 Mar 2025 05:29:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A6730.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Fri, 7 Mar 2025 05:29:57 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 6 Mar
 2025 23:29:51 -0600
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Linus Torvalds <torvalds@linux-foundation.org>, Oleg Nesterov
	<oleg@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>, "Christian
 Brauner" <brauner@kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Jan Kara <jack@suse.cz>, "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Mateusz Guzik <mjguzik@gmail.com>, Rasmus Villemoes <ravi@prevas.dk>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>, <Neeraj.Upadhyay@amd.com>,
	<Ananth.narayan@amd.com>, Swapnil Sapkal <swapnil.sapkal@amd.com>, "K Prateek
 Nayak" <kprateek.nayak@amd.com>
Subject: [PATCH v2 1/4] fs/pipe: Limit the slots in pipe_resize_ring()
Date: Fri, 7 Mar 2025 05:29:16 +0000
Message-ID: <20250307052919.34542-2-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250307052919.34542-1-kprateek.nayak@amd.com>
References: <20250307052919.34542-1-kprateek.nayak@amd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6730:EE_|PH7PR12MB7236:EE_
X-MS-Office365-Filtering-Correlation-Id: dab82b50-eb0c-4a69-5922-08dd5d391946
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JnzYpyzBmyQxmY4EgcJZrdP5C6RPD6MetDbzuwAw0po1AN4ffcqwtVn/qNhy?=
 =?us-ascii?Q?e50xgkxDnxw8puWNb1oOESiJ/JQTtKORBDjeLKgz6tf24G4ahBYD1jGsEKDB?=
 =?us-ascii?Q?tQLacjfAoeAPi9dculM2gwl1lzv0SjTZZarzDcNr+ng8A+6MgJWe6ppeD4Yf?=
 =?us-ascii?Q?V978ZeDHe4k24IcZ2vrSt43F886jdgvnt2QwwFrqPKp9SpPPz3lx0tNdE0Yz?=
 =?us-ascii?Q?+ZmK2mjXEgg0m3objOB+if/r4F5sBIXOoF9XGfjPVA9bF5fBtLWCISuyqHU0?=
 =?us-ascii?Q?BI+L7Qfyqo6t9c92trlg+MnWYvBuXXnupR90L+pQdrEI4nfL429hz1BtbPhv?=
 =?us-ascii?Q?pXPoxihGjonL2UKW/FZh7pNL5uKnMqvCllswhrc6zk4dXHu+oGdZXmYiVDtM?=
 =?us-ascii?Q?6sQLQ1NFWD98ztmKTP4bHrloD/e6VS7zkTV6zNH7mvAh1+cJHsyPNeXhRLYR?=
 =?us-ascii?Q?x1VTEEc58t2Lrf0P/Ho3svCC0YzcysJC9IaIuoh0eiH6t9fV9to/2idnOuvO?=
 =?us-ascii?Q?v85S+X7ZaQ2LNdTXEnzgJQ2qXig7hxygW9qB6wCkjikzz4Lu7M3eVfu5Df2l?=
 =?us-ascii?Q?XdndxqTaJron4RuiTuKcB5Hy4egTACa4xBqWYFXqviXZk+4bcsrulpQpLQaA?=
 =?us-ascii?Q?5+vbdY8IcTmzQcbsind4gzReq2CE4PMxFfqFle4CV005vE9I/btY55nzSHFh?=
 =?us-ascii?Q?1eL5Fb9YSzUmqcgCTa3tBhdoyf2O58z7S958FeUsD4kKPJ7AQvEKkKxkZTPY?=
 =?us-ascii?Q?jZ0G5dM//1QJG54UjuF9Ms3Y19phN9sU0Xqy6tYJMV4WUR2V9tC/gvUeOeY7?=
 =?us-ascii?Q?Q4VMeeZzb8deA93Wg9IdWqiZQJG8HSdMs7y53zQEMLvmUIonWqscT8MjIL3u?=
 =?us-ascii?Q?WaeJ7fr8JKm67kgt3WJsC8aRAOhRDFIkkXZOff/VtG9dqFon/ZlRqxYM3Hcz?=
 =?us-ascii?Q?YpdUgxI1RpRMiXcl+QwTzJ5l8kj+44uDcKSjXVrq4NvN3ZdHUKub2RcOtbec?=
 =?us-ascii?Q?T1LTecjAsB1QZJT/9ZXhRb0ZSl52I7LGix9wqqc1KXh3q6BeGehrcSqch5/p?=
 =?us-ascii?Q?7eiXJ5YJMTY8tRUNLjPIj8+vlUNADn/rTqHD41A6zJv2+0KhAJHdCWUmD2Bb?=
 =?us-ascii?Q?HFYxmDJI1lsZ8Kd9Tx0ITqFObcek3c41Clkjm16rvQMMwD8ax/L6jS+7OQTe?=
 =?us-ascii?Q?T9uxcoq3flPunmVcVG9ek4tSWe+fD9/HOA3+gnOG7yCqMRHPJYg+csYhso6p?=
 =?us-ascii?Q?tmCqlMKY0UabGZaYTL8dfCqlyadVFpcUBdtFmDMBW8CsjQ1aj59x85jPwRaq?=
 =?us-ascii?Q?j9zDtLx/kuA+z5pc/7jGfd9BOnqegYpm+d/Fhm192BOLGeDfWtzK2rSU/hR8?=
 =?us-ascii?Q?H+yVve/V9qu2Mvz8PliRFc2ErcuIwaR/D8X7Ua6/OcPFlOzy4a9q6zDZx1Z9?=
 =?us-ascii?Q?2MJYET5BzKTb/Y7Q9ZjoTFgDLsKCHc+r2TWH6XH9HWUGHrDhod6LF/2YC7LU?=
 =?us-ascii?Q?hsri1lUTZpGDLug=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 05:29:57.3319
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dab82b50-eb0c-4a69-5922-08dd5d391946
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6730.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7236

Limit the number of slots in pipe_resize_ring() to the maximum value
representable by pipe->{head,tail}. Values beyond the max limit can
lead to incorrect pipe occupancy related calculations where the pipe
will never appear full.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
Changelog:

RFC v1..v2:

o Use (pipe_index_t)-1u as the limit instead of BITS_PER_TYPE()
  hackery. (Oleg)

o Added the "Suggested-by:" tag.
---
 fs/pipe.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/pipe.c b/fs/pipe.c
index 4d0799e4e719..88e81f84e3ea 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -1271,6 +1271,10 @@ int pipe_resize_ring(struct pipe_inode_info *pipe, unsigned int nr_slots)
 	struct pipe_buffer *bufs;
 	unsigned int head, tail, mask, n;
 
+	/* nr_slots larger than limits of pipe->{head,tail} */
+	if (unlikely(nr_slots > (pipe_index_t)-1u))
+		return -EINVAL;
+
 	bufs = kcalloc(nr_slots, sizeof(*bufs),
 		       GFP_KERNEL_ACCOUNT | __GFP_NOWARN);
 	if (unlikely(!bufs))
-- 
2.43.0


