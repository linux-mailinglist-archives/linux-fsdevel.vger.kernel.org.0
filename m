Return-Path: <linux-fsdevel+bounces-43402-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 253B0A55FFE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 06:29:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F639170655
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 05:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7634E192B7F;
	Fri,  7 Mar 2025 05:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="C7u18XjE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2062.outbound.protection.outlook.com [40.107.212.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271361474A9;
	Fri,  7 Mar 2025 05:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741325384; cv=fail; b=EaLpenDfemgcPwkSkaF+aud057+O882kQSpap1y651hlRA6GJk13htVFSNzHR6Y53C4Pc7P0xtcjGEsqaQmbIB8zb0f1Xk5C+OjQI/jywdCbNP726lOzO/oGCQ5wjRBbW76hzJgpAxqvBjKPhFVovnz38dgCLWAlxpFvzUj30bQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741325384; c=relaxed/simple;
	bh=dL2ejAWDBIEwXz6DlMtRLQfqXDXY7kVuOyKScXglqsE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ewi2av+6t+BVmYPWGpKcuKvGCN21rVh7j6JXbO8RrbiJRqz26Cqdzg87Zs0+HfT8cnGh00y41DhMKbQPrM8v4Slh3qMBmMXLn8j23UcHEZOYr0w76cR5/XAtyXwpCgieEsXMAx6tRillRfKkvurVAiyQdfR8o806u0S4FcA7GcI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=C7u18XjE; arc=fail smtp.client-ip=40.107.212.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YpfovWqa0aEiu6vX6cxX3cf+wlIorx83cE8KU5XogqARb0wvrVEnG8SO27Tzt8AYF0RjA/eBlpUs6S+BEB72xUenEXWMUPdKflJbcmg7EPMUyKh8tV8kMyBV1eBiy6rkWdzbdKBTVeGBFIHXtmdD2BoUUgAIYTVUtyP7N4u/CpgwMVszO3AH8r/6DULSwx4H7Kdu7O6YZQruQT3lE3ZwCp/8mNw3yjMldIHnElQVbQ0T9Bp7kvhxZFaPNDhBklN6jCD6thQMvmlpzRXivPedmGi5LZikR+EFfj3qFKhx8O3fQxTD6STeVaMOZvf6ee/kj9q6GnBrAqLqQ1Zg7j+0vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FcWyh1lEuw5f1ttbALr+a4S5JUPX5nJnpIXRJQkx0m8=;
 b=Rxf7rAdkLI6/2R1cACu9WZsUlNmLdLMfaUpY0BWyZiio9AdSZCk7FHlddNbz/Cp7zYpPefgYsGrtOnHPekCu7+BGdByFRGkf3lktGOgYVf1rVVyYcMLn8Z7VfCVvp1J5E1ygl+s43GIlnHafoaESrdGniayM/xCa4XPgN+j57PwgaumFQjkNl4Qsc3n3XITxbItdxPuUdUdeI1Cy8atcJVoe4IpKuXBtOI9SlpZLayySs3R/yfUmSNqXBpBjhbjVtMp1PYFzhvDcbtF98/6rk3uW0KZniWkOrJMu+7KAy8qBGDdD3QLZwD/Qm33DTEUvalQ5Keo2X2BJJZ97XxBHJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FcWyh1lEuw5f1ttbALr+a4S5JUPX5nJnpIXRJQkx0m8=;
 b=C7u18XjEZBYByAiSpQVh6ztI13gD2IhUD4liRe7Wse5gv2yPjAmvq2EseEuy8RwHAOM79XPTRXBSt9JbKjXMrfT5Dmd7Xk6GwXqj2T98O1hut8SONLNRfApSEGvlPy502pUIaECMqTTSBlPG/wGVV+deP47zM+JG9Y2KWiEh8Y8=
Received: from CH2PR14CA0049.namprd14.prod.outlook.com (2603:10b6:610:56::29)
 by PH7PR12MB6539.namprd12.prod.outlook.com (2603:10b6:510:1f0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.18; Fri, 7 Mar
 2025 05:29:39 +0000
Received: from CH2PEPF00000143.namprd02.prod.outlook.com
 (2603:10b6:610:56:cafe::72) by CH2PR14CA0049.outlook.office365.com
 (2603:10b6:610:56::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.17 via Frontend Transport; Fri,
 7 Mar 2025 05:29:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000143.mail.protection.outlook.com (10.167.244.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Fri, 7 Mar 2025 05:29:38 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 6 Mar
 2025 23:29:33 -0600
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
Subject: [PATCH v2 0/4] pipe: Trivial cleanups
Date: Fri, 7 Mar 2025 05:29:15 +0000
Message-ID: <20250307052919.34542-1-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000143:EE_|PH7PR12MB6539:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cd90eb9-f6ff-40bf-c984-08dd5d390e1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BBPO1X0BYiR9+KoF3JjJuREoSlRDCd/ml8o2DjEBlnYErRSVKvBE+TMkO3Rh?=
 =?us-ascii?Q?eKpPCyQX1cNEUMKVT8Zij5G7kPcpfSHAjuxxv7Ig6L5jaTV7zdRPk/OUuwvw?=
 =?us-ascii?Q?0fGvnBa3qcbaEwPdYN7Oj/JJf+J+9RYxumSb7OhTTL9LIXJTh61gVayQUpl3?=
 =?us-ascii?Q?IT9SY4bUPE0HFwDFybUI+0GK0eRiXsNmbWag4p+TJt4H5DkvlzNYkC+9IFdR?=
 =?us-ascii?Q?QdmNKnKEqz7tUiy8mOySLolihkRIRjTdDpRbcYgaX9Cn0gv2ZUi4E28iLQsZ?=
 =?us-ascii?Q?o/z2FMRt6sGQgt9V9tmrK1ZOiA7A3LRpiT5MWAf8VRYNbfIZxh5rPSH2pIxH?=
 =?us-ascii?Q?hj6A/g9Ls7FrX3LELbtZsxeANDndqmL7bTb46I2ZzmEWSP73O1i5rWBW9m3D?=
 =?us-ascii?Q?v3IU77UiSrm+MnpORDL0rY8FsTrZi0Pp3hfd1XZ/3EZvg5ekQ6trO6Vpac3m?=
 =?us-ascii?Q?0g0Qq/3C/p8KNXQO9ZoJZNoy/otJ0LUKd/dhZpE9iUg7WXEwXh4SrQ515/0B?=
 =?us-ascii?Q?caNBGQ213DIbF4cuTgRSCu6vPhykzQTG4rwiNhQhpjQwNn+nkSo0vCIz75So?=
 =?us-ascii?Q?X8l6CdfG2l26nmVcDXfQnDzrS3fHlrmKC02dS3Q9bamGcsbwBwtXONNM8AFX?=
 =?us-ascii?Q?gUBUzBZvCiPphN2CwjMy74VGb7mPEVaBcO7iPb2BcJyAPQmWR1mB9cf3W2Qk?=
 =?us-ascii?Q?YLf5zj8fQQIh+jNcxvymWdCJavVp2DLBolXG9uHJnKwQexVy9yOiK9ZmN+pV?=
 =?us-ascii?Q?WUYqE99NJ75qQKIcUuMcL+rGCcgujb3yILn2GG6YhcpU3evKrQtxVz9CEFWT?=
 =?us-ascii?Q?m+Njai1loAVYmfXL48zZaKIOUIJc6PaXOVFsED6RK2/zrNC0QCGXd3vN56B8?=
 =?us-ascii?Q?wzth4vdB1H8gdx2arbaOdQTm6kwSFj+tudwxWw+PyuVNfk557SpzqV/4N9SZ?=
 =?us-ascii?Q?uytxCrI2zpXsO4kYcmD/zJP2UnPSoa2decgLyRrf8oV9pIghrPO5VeQtXObr?=
 =?us-ascii?Q?Zw6LD25sJ97eVoNkplGEPv9e6Nr/9cgS0zozRHb0dccxhe5pX7hfxShFXzjJ?=
 =?us-ascii?Q?jT4rUAfl3fiD6BD72BxmOi9nOUGq7RpV+vod8IlyWr5IfQHUoD+M1tU3P+pv?=
 =?us-ascii?Q?0LThkkM/g0NQ3gybRFTZubsm42nQ9gNfdAruQ6s67DJgyq77aV/p/nrMZUf2?=
 =?us-ascii?Q?LjW54qtYdK/qyGlL3oABxfKmPB7aXg4er9k/0cEAYQhfgnVM3XYTGgCqtYcz?=
 =?us-ascii?Q?EzldxJm9Y4/CxOEIS1ZtxDNkqkVmaUTlHOmLjWOXIKXgbmUD7XzL/KETn2+N?=
 =?us-ascii?Q?hFtB48EVFGelsETdgI0xpDtJWRg3h1XatO6i/dhyS/yaam7Zp6+j8c+dRhkM?=
 =?us-ascii?Q?jbV5WoIsWpTzyTwO8jCruaCccETemP4c2R+/S957HUnZO95IA0t3L3cYQyvO?=
 =?us-ascii?Q?n1D24Hoyf3Gm/cE2tx3Vcgp3gYd+XaSRCQbH4IlHMEKWT9wC0+SrL2QjROK3?=
 =?us-ascii?Q?kp7ZSfbhERsI2ng=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 05:29:38.7115
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cd90eb9-f6ff-40bf-c984-08dd5d390e1e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000143.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6539

Hello folks,

Based on the suggestion on the RFC, the treewide conversion of
references to pipe->{head,tail} from unsigned int to pipe_index_t has
been dropped for now. The series contains trivial cleanup suggested to
limit the nr_slots in pipe_resize_ring() to be covered between
pipe_index_t limits of pipe->{head,tail} and using pipe_buf() to remove
the open-coded usage of masks to access pipe buffer building on Linus'
cleanup of fs/fuse/dev.c in commit ebb0f38bb47f ("fs/pipe: fix pipe
buffer index use in FUSE")

If folks are interested in converting a selective subset of references
to pipe->{head,tail} from unsigned int to pipe_index_t, please comment
on
https://lore.kernel.org/all/20250306113924.20004-4-kprateek.nayak@amd.com/
and I can send out a patch or you can go ahead and send one out yourself
too :)

Changes are based on Linus' tree at commit 00a7d39898c8 ("fs/pipe: add
simpler helpers for common cases")

---
Changelog:

RFC v1..v2:

o Dropped the RFC tag.

o Use (piep_index_t)-1u as the upper limit for nr_slots replacing the
  BITS_PER_TYPE() hackery to get the limits (Oleg; Patch 1)

o Patch 2 from the RFC v1 was dropped as it became redundand after the
  introduction of pipe_is_full() helper.

o Patch 2-4 are additional cleanups introduced in this version to use
  pipe_buf() replacing all the open-coded logic in various subsystems.
  (Oleg; Patch 2-4)

RFC: https://lore.kernel.org/all/20250306113924.20004-1-kprateek.nayak@amd.com/
---
K Prateek Nayak (4):
  fs/pipe: Limit the slots in pipe_resize_ring()
  kernel/watch_queue: Use pipe_buf() to retrieve the pipe buffer
  fs/pipe: Use pipe_buf() helper to retrieve pipe buffer
  fs/splice: Use pipe_buf() helper to retrieve pipe buffer

 fs/pipe.c            | 13 +++++++------
 fs/splice.c          | 40 ++++++++++++++--------------------------
 kernel/watch_queue.c |  7 +++----
 3 files changed, 24 insertions(+), 36 deletions(-)


base-commit: 00a7d39898c8010bfd5ff62af31ca5db34421b38
-- 
2.43.0


