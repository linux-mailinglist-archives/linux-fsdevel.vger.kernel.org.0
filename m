Return-Path: <linux-fsdevel+bounces-29514-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E6A97A64E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 18:58:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6660B209FE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 16:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6238415B133;
	Mon, 16 Sep 2024 16:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AMGHk/96"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2068.outbound.protection.outlook.com [40.107.100.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4943410A18;
	Mon, 16 Sep 2024 16:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726505902; cv=fail; b=QD2w1Nv1UjhmJRSlEbBFFhxxZMAzXTmcKfCnxhwLyH1u/Pueoderog2EfVcMGXjDc/RN6wONfdBhjkB6o//D9rmIwAkmXpNnUzrcD4YaEYDloiT1EN8HMDPFtq5+zrePU2+U6uf3x5Bkb0O7wHkv9QyFXQiJwfCtl0wEWT+Vme4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726505902; c=relaxed/simple;
	bh=Qs0AakKzu6m4cPlnNL7HjgeM6YQuRkbBGanII5b+jds=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=vAq+tUGKeFuGz+Rba3PWCrTGGlGk+D9Dh3CxLGganwxjAvfsFWKqDBLO+LXOZIej2cJONQdPuIW4YPvO1agVHoaSbZ0xYlWfUe7R/OAK3ONJi8DleiEl7akTJUmBaEAn9BfUKX2Kj2+9urJERGn8gEkr214apdKdhVg/mYamwOY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AMGHk/96; arc=fail smtp.client-ip=40.107.100.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j/i/VQTps2qgEHlS6j/nRB+IQI53QLK3X/c1Y6AImMbaAgbcDljKDw6DYHBWFWTxkhrMZagTz8JUr+1MUnPIANTeL2htlhso6J/FCYQogbcp9NqD8I+wui4Fe2LSWY/tPfmR/t4x8NXuB/qBRHT4W+Um0Ryk1hJi8wmo9YG02M0Yye8Nxu5nKqhcryRUiYcRL9heKWYueLYTZNTQRUgS0z3dv2DG8uAHZH1qtJy6Rfgz9ZhoEs2rjHy8EwbvpygfuSkoO6Rp47KAVj/G1k1Khvu493ENhqMQ401kiG+HxKLTz5eS5ySXmkZ5aWpNn1bwTx+c06aCssQ9BkrgUOS7Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ubS2tFOUtJAvpXXDPXQi0C6ol4vzx/+49QbQRu3P0nM=;
 b=WQtDE7y4C2Z4VohUhThqpRFAOpIVdXbq765mnjs77J1+lr4wBW0L7j4/rzNG0U9/2Lxztbnu+wuEa0uw8xpi41CLQcTWBQ4P6OmWXIyrBHar1hwFbZ4eVYmtY+auF+Qrj3MdE3aiaJmXHybpxKsThNVWacwrwxsajhGpI+4OqjKv27azusgYujUJ6pBzZVfmT79wwybpMozscyV2r0hiJy+MXFcla26txlwDQzg9U5O+H2UpPot5+M5AVP/TZK2BtZBHAwzNn1rWviPMtwJpDGnYB6OJDlOjjB0IN+G7qJYf96YLChxEeo/fBlUqy04OnPZESZogPSycHvyVLKubig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ubS2tFOUtJAvpXXDPXQi0C6ol4vzx/+49QbQRu3P0nM=;
 b=AMGHk/96OeFDhygdQcxsuIefcXH6EkjKV4KU5Y+zokBKX6aTFn588cbMiBl/p64rtuXzdhH55Vz5KkHCO3orL2NbPmLUjj2r1LpcrML9OkmgQzhShpK9b22GHTi4sLHn9ksiagGdxh0Q/GFk8uojFiUo+CkllDbgz4V5W1QKCg8=
Received: from SA0PR11CA0112.namprd11.prod.outlook.com (2603:10b6:806:d1::27)
 by PH0PR12MB5606.namprd12.prod.outlook.com (2603:10b6:510:141::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Mon, 16 Sep
 2024 16:58:10 +0000
Received: from SN1PEPF000252A1.namprd05.prod.outlook.com
 (2603:10b6:806:d1:cafe::e4) by SA0PR11CA0112.outlook.office365.com
 (2603:10b6:806:d1::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.30 via Frontend
 Transport; Mon, 16 Sep 2024 16:58:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A1.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Mon, 16 Sep 2024 16:58:10 +0000
Received: from kaveri.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Sep
 2024 11:58:05 -0500
From: Shivank Garg <shivankg@amd.com>
To: <pbonzini@redhat.com>, <corbet@lwn.net>, <akpm@linux-foundation.org>,
	<willy@infradead.org>
CC: <acme@redhat.com>, <namhyung@kernel.org>, <mpe@ellerman.id.au>,
	<isaku.yamahata@intel.com>, <joel@jms.id.au>, <kvm@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-fsdevel@vger.kernel.org>, <shivankg@amd.com>,
	<shivansh.dhiman@amd.com>, <bharata@amd.com>, <nikunj@amd.com>
Subject: [PATCH RFC 0/3] Add NUMA mempolicy support for KVM guest_memfd
Date: Mon, 16 Sep 2024 16:57:40 +0000
Message-ID: <20240916165743.201087-1-shivankg@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A1:EE_|PH0PR12MB5606:EE_
X-MS-Office365-Filtering-Correlation-Id: 42eb57f6-d429-49c8-4d87-08dcd670beca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Fs+cMxKVa5xC5zIRSTxVzpaoRksJhjsCMONPKnI7/mUYy0axpQcswIKuJ1BD?=
 =?us-ascii?Q?2IWbVC9YL/zwYiJxjTRwm5hbSEnfUoY/R5yIy2MRLJpCvdkZBTeHk0XZ0KBG?=
 =?us-ascii?Q?cTHnCSGWYr8aiwMpnP7tMKkOgXMi61iooCNd4X8IxM3Hizpudg6FpcVhXUvr?=
 =?us-ascii?Q?8EydIbaEXdMoyPzdLmmpJ7nHUVJE1j0qyYSBVUx1+QIwSZcVNVvaIXSOXo6O?=
 =?us-ascii?Q?ngdUlOHQy+WSisupKQAQD8WQ4RCP547Ow7ZeCmJBWSxzxwOEU922+Ic/v5aY?=
 =?us-ascii?Q?zV33zGJY2yuq1SWllo5gys2xAXEURYT2z7oNI9igU/jZDbJVgcTZNtDnEtET?=
 =?us-ascii?Q?JHwh3g5x22gLy0abadLcnclgab2hLMK0l3kkOpYpat6IL/Gdsfp6SkXIr3y7?=
 =?us-ascii?Q?EyGnBQPdT0qPvwNfZwc+FzTrTy6NZyTBi2s1snI6FHMyIOYQjo5F0g43OgNf?=
 =?us-ascii?Q?fBnR8bkFMxMyUK/12H88C7ZjgojarsbuwgjRLaghFHiSQ91K9KIXSghRwn7H?=
 =?us-ascii?Q?11ofFT1RK5vojOmctHvEDHIqknygo4vmeYeF3/ZKRE3znU7NfNUqwjpTH7lE?=
 =?us-ascii?Q?duci6WTz2ijyRXF9F+ahNwBGArWm85fWXQ3NQuwens/DYUEZdpAaMROkhfTK?=
 =?us-ascii?Q?ZD9O7ZwP7L3iudctPQOdTyqWU7CQlqyz+L/NQPkWWGMfHwjAI/IPLGjxcgW4?=
 =?us-ascii?Q?VX65AQVe3C0Zf9y3qpu9GpKdJmhKwtXTotwyKPDrbU3Y4ctvx8iSUYZvoKqr?=
 =?us-ascii?Q?+kboLNqERvTC/cfzMZNO/ZssPkvliOyZZ95pFwg8rScfaxc44BG/53VLkh5d?=
 =?us-ascii?Q?I0LLqEUxYqSDtOAzFXbLc+P0vyX7zUOacjnDl3oEEXgtpECYDhp8nGSd+AqY?=
 =?us-ascii?Q?ws+y6E0RzicCdH0POGLxGsTZiv67SVCJtEn4/aYlMCX8KxoCE0tiP/flN6yX?=
 =?us-ascii?Q?iA31XofOYmfBewV6doTOXBLWldOXBoRu9nbO0jp7VbzoUONrg1wbEDRIkYIv?=
 =?us-ascii?Q?W28jmrnkG/HtzRYgCJAn1apRjC9gTywXPxgiuJtpqIT/2bwXl2eouYYNectH?=
 =?us-ascii?Q?B1Nczxk116D46xiOkbTPBNvdo5BANgaY6It17Mea4nlBUAAnko2hiUcQTSP3?=
 =?us-ascii?Q?I0pb9lepypcDYCxZg/tG4LVbEW2UKGu2bFHfOiAaJjOxMjLeFPtVWTDM5cvn?=
 =?us-ascii?Q?CWTmHUygPiDe6+k6YOhTIY14DCVbzpoBkRNw6qRehPl45k+8oo/n8i1KTDYY?=
 =?us-ascii?Q?Mf0erjoaEKkFCrzpqDY36zhsC3XqNGfhZTZouPoX8Vb39lJdapx0+GtRzdcN?=
 =?us-ascii?Q?/F9VEbcOwjgQdPqp3q7I310qph7SOspaKWf4Bs+8RoOc1yFA0Pi7x27cIrmQ?=
 =?us-ascii?Q?i114+AlVktHJAi3qfRZckO59OW0Rte+ZeouJYdz8XdQAPa/G+cnRb6HywW07?=
 =?us-ascii?Q?swF4bAvC3rvB1tXtHtbtQbIk0aqrCy09?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 16:58:10.4440
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42eb57f6-d429-49c8-4d87-08dcd670beca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5606

The current implementation of KVM guest-memfd does not honor the settings
provided by VMM. While mbind() can be used for NUMA policy support in
userspace applications, it is not functional for guest-memfd as the memory
is not mapped to userspace.

This patch-series adds support to specify NUMA memory policy for guests
with private guest-memfd memory backend. KVM guest-memfd support for
memory backend is already available in QEMU RAMBlock. However, the NUMA
support was missing. This cause memory allocation from guest to randomly
allocate on host NUMA nodes even when passing policy and host-nodes in the
QEMU command. It ensures that VMM provided NUMA policy is adhered.

This feature is particularly useful for SEV-SNP guests as they require
guest_memfd memory backend for allocations. Workloads with high memory-
locality are likely to benefit with this change.

Users can provide a policy mode such as default, bind, interleave, or
preferred along with a list of node IDs from the host machine.

To try this patch-series, build the custom QEMU with NUMA supported KVM
guest-memfd:
QEMU tree- https://github.com/AMDESE/qemu/tree/NUMA_guest_memfd
For instance, to run a SEV-SNP guest bound to NUMA Node 0 of the host,
the corresponding QEMU command would be:

$ qemu-system-x86_64 \
   -enable-kvm \
  ...
   -machine memory-encryption=sev0,vmport=off \
   -object sev-snp-guest,id=sev0,cbitpos=51,reduced-phys-bits=1 \
   -numa node,nodeid=0,memdev=ram0,cpus=0-15 \
   -object memory-backend-memfd,id=ram0,policy=bind,host-nodes=0,size=1024M,share=true,prealloc=false


Shivansh Dhiman (3):
  KVM: guest_memfd: Extend creation API to support NUMA mempolicy
  mm: add mempolicy support to the filemap layer
  KVM: guest_memfd: Enforce NUMA mempolicy if available

 Documentation/virt/kvm/api.rst | 13 ++++++++-
 include/linux/mempolicy.h      |  4 +++
 include/linux/pagemap.h        | 30 +++++++++++++++++++
 include/uapi/linux/kvm.h       |  5 +++-
 mm/filemap.c                   | 30 +++++++++++++++----
 mm/mempolicy.c                 | 53 ++++++++++++++++++++++++++++++++++
 tools/include/uapi/linux/kvm.h |  5 +++-
 virt/kvm/guest_memfd.c         | 28 ++++++++++++++----
 virt/kvm/kvm_mm.h              |  3 ++
 9 files changed, 158 insertions(+), 13 deletions(-)

-- 
2.34.1


