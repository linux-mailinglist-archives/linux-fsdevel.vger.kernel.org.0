Return-Path: <linux-fsdevel+bounces-33684-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BABD19BD2BD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Nov 2024 17:47:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2809FB21395
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Nov 2024 16:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5779F1DBB36;
	Tue,  5 Nov 2024 16:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GFb4TmS2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2053.outbound.protection.outlook.com [40.107.92.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0935BBE4E;
	Tue,  5 Nov 2024 16:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730825237; cv=fail; b=d2xy3azGoxNcxdoGE+2J3re5zyUTilY2qxoq7abmUmeVcuWo7OIHtAL+X+4IkBoPJr6xgH+8Fh4oG6DfycSkGiVqOOXv6aVryNqoSQ50Nh0gjc7UDt9UQfKoONXMt6zo3zYXmG+iR9OabdcnCcoM3kkV4ZxPHWHGTReJFAhQdX8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730825237; c=relaxed/simple;
	bh=p3dGUmFjx7g/q1yleSE7APyMrHGMH/qcoG+o0+V7e5c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fLWNCHX+JoUFxNpkJmcICWqdBplDVuF+5J+hly6nhfADxxsw680iKTbwE2psSjqf6KXgEOlLoUYuUwzUhTgjcXYFoI9qliUVZ8t1Nb5lQ+K97emizM+pyONwBUn8WD9ZMEJnRJWAdNCRa75SmT9Z/raZPGLEbxHfI4qAPAE2fV0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GFb4TmS2; arc=fail smtp.client-ip=40.107.92.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PD9rhGM5rq3lg/QCgn4MpFa0CQwed7nDrEinuD6QHoDUAi17QGd1s5AYv+tBUO0A+NzohlgRufOsNAWOdxzolGs0qw9FBnQQQm90YJEJ77ghMFXX+SGVFbuLi3yIwePvLjNOOZT6j61ffz8Ij9xyg1T013i2TYcAwxCqtFbVPHRmhl3ASg0YvvTM1pivs45+5xnW73ohT8N3cMpie9H4My0asXyETdxkJ5+bSVsql/PqVQ2/lkdz1tuYhSZpYyh6W1Athk8w7fUcrrHA2sT2I4xDEgDbM6jh/PQHV39zapcvXUN/oNXnmHVzMczhWNZFwSuzLqFxfERSPq96Rh35rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RS8Nrwsw2BXdXOZ6i/UQ4YfnkD5oo8PUth2GFkeVzb8=;
 b=cK8GEhCMJMwzyMLQrm7g8OfpiMXmxDsRruhIm36N7GAIUFHIW8gCeA+o7D+loapfNGuMcGPJXLlCMlz5qV2z8Kk3Ri9Iz/Zf0mQOEupzxUc2N3BGlcdSACqeYCMBOHsFou/PZaxJJ3a4jT18FopknQVysyuNgJlMJHxJT03ZYy88ymGKIJAcqrQ0MQDHacThE/yURve0qApgjL9fKhhatZdH7gr1GksobEO1EoalxYLe8OkePrIA6gkd0QelkFjI0JXmfQ4VqHeHAx7ztnLs9FhjDcXRQbEFGtJyUn5gab2aKx+W4Kf7DogxKmaBpAHDoI0SJ8CNsRKEf1GU58tdYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RS8Nrwsw2BXdXOZ6i/UQ4YfnkD5oo8PUth2GFkeVzb8=;
 b=GFb4TmS2dVcJ9yYRgkMa0558h8FeJnA+aOvkxZuzOBCSJFvyF3X+0/nRUat2spr1Yxw5vhdl5r/5VynolLP0C2FWXN7D39AD1sLdamw0oFm3HgLE2mpI3vfuB07xjF2uYTxQO+uUH+k8e8g1fmq32mEhuIbDfLFf5034k3fNmbw=
Received: from CH0PR03CA0288.namprd03.prod.outlook.com (2603:10b6:610:e6::23)
 by CYYPR12MB8732.namprd12.prod.outlook.com (2603:10b6:930:c8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31; Tue, 5 Nov
 2024 16:47:08 +0000
Received: from CH2PEPF00000149.namprd02.prod.outlook.com
 (2603:10b6:610:e6:cafe::53) by CH0PR03CA0288.outlook.office365.com
 (2603:10b6:610:e6::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31 via Frontend
 Transport; Tue, 5 Nov 2024 16:47:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000149.mail.protection.outlook.com (10.167.244.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Tue, 5 Nov 2024 16:47:08 +0000
Received: from kaveri.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Nov
 2024 10:47:00 -0600
From: Shivank Garg <shivankg@amd.com>
To: <x86@kernel.org>, <viro@zeniv.linux.org.uk>, <brauner@kernel.org>,
	<jack@suse.cz>, <akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-api@vger.kernel.org>, <linux-arch@vger.kernel.org>,
	<kvm@vger.kernel.org>
CC: <chao.gao@intel.com>, <pgonda@google.com>, <thomas.lendacky@amd.com>,
	<seanjc@google.com>, <luto@kernel.org>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<willy@infradead.org>, <arnd@arndb.de>, <pbonzini@redhat.com>,
	<kees@kernel.org>, <shivankg@amd.com>, <bharata@amd.com>, <nikunj@amd.com>,
	<michael.day@amd.com>, <Neeraj.Upadhyay@amd.com>
Subject: [RFC PATCH 0/4] Add fbind() and NUMA mempolicy support for KVM guest_memfd
Date: Tue, 5 Nov 2024 16:45:45 +0000
Message-ID: <20241105164549.154700-1-shivankg@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000149:EE_|CYYPR12MB8732:EE_
X-MS-Office365-Filtering-Correlation-Id: 706376f1-6bcc-4579-81b5-08dcfdb97cb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oAm5WvfHnHi1kwbK71H0X7hU6WE2tssB60WtgdXL8lClqU9F4VLJxoVUgYmC?=
 =?us-ascii?Q?m1Hj/FZeb5Ngfc7ll5VMMYEfe5gwceM1Dw5WhTKS/MUpk96D9SU8eVg18Epx?=
 =?us-ascii?Q?yI2Vzy2RMBYJ+MDO/8gDD9ucqliJ3/RgRigoqO1gyM/TRt6MnM0lLvqXb4xD?=
 =?us-ascii?Q?EtdWF64zg9tNLzoCmp+96QkuBKOAOVezgtABQWdA5nwL+kkI5raqPiKJ3jP8?=
 =?us-ascii?Q?hFoCjOPO1ezfYlk7hNR5QA0+tWyQP21FE+OpU29y9qDWb1Uaa5ucxKV1IlRh?=
 =?us-ascii?Q?WrCx6RC7wUYQsudnzycQsd5w/AcZvTt+PXrHlbxGxUCD4ZgwaRxVw6AZRB4L?=
 =?us-ascii?Q?0T1phl3npqLg1ArxGL1Q7wRIy5bo63CiX6vWAkEdN7NxTLG2OWGUBw0/oVYt?=
 =?us-ascii?Q?bUuhD5BJjyr4Rl3mvfKm341C8Z3RKJs93i0a9hPlrJ9IM0mUVPm1mdStnuVi?=
 =?us-ascii?Q?WL89YjMbGEU52cpdpKBRzSe/x8NWMyvalwZu533wK8cJaAlz1g3RbXf8Iz2F?=
 =?us-ascii?Q?yDnTX9v707IArbb/AIvDofI1NlYovvk3TJULNJAljYxcMpF5UQUPZSfUp/Xx?=
 =?us-ascii?Q?2rhVQK35yZ5s+cz+ccKqMl5MkoddL3/VNHkhW+ZtopPNyGE9j0riXiFr6glj?=
 =?us-ascii?Q?IznjRmioP5NAxFF+cqwKfbGpZk91qswX4ckal17vZ0CbNK2jfhYiuN5nmTSc?=
 =?us-ascii?Q?QJtxCOC5j5PCAhJ9ZLbBWI8fFjpRP7Zc8vRb3anZzeKb+aVzSmcHOKaz9PUl?=
 =?us-ascii?Q?dYbSRU+8FQnz2FCCw7MazsKL86BHTGiRYcsYx6MHC7BECR839D07+YrsrQ0e?=
 =?us-ascii?Q?RCCxsBUfTqTna0IGMXErEZRxmUK9TH7zKjlHslW4CPM/ONIJQwYw1KcFaRj0?=
 =?us-ascii?Q?gwS52ZZZo3sb18Ja6VNvp5VxEgh/msCIdpR8m6iJxccD7WopkQMO0jbGWanN?=
 =?us-ascii?Q?XDbanMseVh6Lsdz5rm1vpq35i16QvxQFZn6ry1Se19As0XPzB4spXToCYIiq?=
 =?us-ascii?Q?K+vtVvt2kBfLnOU/qauc/lITN62Q67gQ34hCnrYzxlyOq94gQDa6w2elZFI/?=
 =?us-ascii?Q?eJsVFXz/iZOIwgZwG4McGfWJPW2HN5y2CaKKg4CCP/iYEsYefhQiA6L4Y85e?=
 =?us-ascii?Q?Nz5enOyzIpE+H2MCEvA5CNGdU4vvrgrViPsBDBblf1WIcMS5wzluP68ndNFn?=
 =?us-ascii?Q?MeHZ4Lh5giEiVG+FOSICdR8owZ437frtYTzFWAmKwTBieM4o1JOLQ0bSEhWv?=
 =?us-ascii?Q?Xa1/B6fLXYWIZ/Dy4CagetXyLWe1xD+FbDVDrTk6bXHNgugrOahpTUCM2orn?=
 =?us-ascii?Q?4QXy9oEtBAmK4Mu1Zkm2K05MascafSYcgSnD3IiH3+3VAsh0vb2wie7OPxOe?=
 =?us-ascii?Q?MVzGy9e9pznLgEeXKbyzXYtkgHi6?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 16:47:08.1680
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 706376f1-6bcc-4579-81b5-08dcfdb97cb2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000149.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8732

This patch series introduces fbind() syscall to support NUMA memory
policies for KVM guest_memfd, allowing VMMs to configure memory placement
for guest memory. This addresses the current limitation where guest_memfd
allocations ignore NUMA policies, potentially impacting performance of
memory-locality-sensitive workloads.

Currently, while mbind() enables NUMA policy support for userspace
applications, it cannot be used with guest_memfd as the memory isn't mapped
to userspace. This results in guest memory being allocated randomly across
host NUMA nodes, even when specific policies and node preferences are
specified in QEMU commands.

The fbind() syscall is particularly useful for SEV-SNP guests.

Following suggestions from LPC and review comment [1], I switched from an
IOCTL-based approach [2] to fbind() [3]. The fbind() approach is preferred
as it provides a generic NUMA policy configuration working with any fd,
rather than being tied to guest-memfd.

Testing:
QEMU tree- https://github.com/AMDESE/qemu/tree/guest_memfd_fbind_NUMA
Based upon
Github tree- https://github.com/AMDESE/linux/tree/snp-host-latest
Branch: snp-host-latest commit: 85ef1ac

Example command to run a SEV-SNP guest bound to NUMA Node 0 of the host:
$ qemu-system-x86_64 \
   -enable-kvm \
  ...
   -machine memory-encryption=sev0,vmport=off \
   -object sev-snp-guest,id=sev0,cbitpos=51,reduced-phys-bits=1 \
   -numa node,nodeid=0,memdev=ram0,cpus=0-15 \
   -object memory-backend-memfd,id=ram0,policy=bind,host-nodes=0,size=1024M,share=true,prealloc=false

[1]: https://lore.kernel.org/linux-mm/ZvEga7srKhympQBt@intel.com/
[2]: https://lore.kernel.org/linux-mm/20240919094438.10987-1-shivankg@amd.com
[3]: https://lore.kernel.org/kvm/ZOjpIL0SFH+E3Dj4@google.com/


Shivank Garg (3):
  Introduce fbind syscall
  KVM: guest_memfd: Pass file pointer instead of inode in guest_memfd
    APIs
  KVM: guest_memfd: Enforce NUMA mempolicy if available

Shivansh Dhiman (1):
  mm: Add mempolicy support to the filemap layer

 arch/x86/entry/syscalls/syscall_32.tbl |  1 +
 arch/x86/entry/syscalls/syscall_64.tbl |  1 +
 include/linux/fs.h                     |  3 ++
 include/linux/mempolicy.h              |  3 ++
 include/linux/pagemap.h                | 40 ++++++++++++++++
 include/linux/syscalls.h               |  3 ++
 include/uapi/asm-generic/unistd.h      |  5 +-
 kernel/sys_ni.c                        |  1 +
 mm/Makefile                            |  2 +-
 mm/fbind.c                             | 49 +++++++++++++++++++
 mm/filemap.c                           | 30 ++++++++++--
 mm/mempolicy.c                         | 57 ++++++++++++++++++++++
 virt/kvm/guest_memfd.c                 | 66 +++++++++++++++++++++-----
 13 files changed, 242 insertions(+), 19 deletions(-)
 create mode 100644 mm/fbind.c

-- 
2.34.1


