Return-Path: <linux-fsdevel+bounces-29702-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7332097C788
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2024 11:49:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F9E7286DD2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2024 09:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54AC71A0AF3;
	Thu, 19 Sep 2024 09:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AhlQYqts"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CEB81A08CC;
	Thu, 19 Sep 2024 09:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726739126; cv=fail; b=fbW0Gu49yStn46FKiT8sJJ/f6iHQtSLK+fDHOjhc1vOUZ4V05YfXsXGSDRbh3+X1FAJfJBvAXJV5wI/lm/RXDoufZtFaTlHn82WRpFquf+eQG+IRo4RrGdIFIs6uaa+Ql/dVK3nVV0KwgfvHX4dTDrxc935Mzf64/9yipSN7K7s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726739126; c=relaxed/simple;
	bh=Ch/3BXRIDwXuwvGggJHTLNf/PCWdMgQZ54sRU6QlWZk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RSRBiaVIlht5Yrtmhb3T/ubz+nI0Ke+rB/OE74m4fbJUjzb19YP6aZFLzeKlB3mVzWmyUiwAhi6uXM76dt620DsKmiX/4vhT9paIZc+iqgdAj/WQ6qbSRzGSJ1XsYP1Ro0NkaL3NNSW3cZW8GXLT3ikjjxhTqq9GpwKT1rlOTE0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AhlQYqts; arc=fail smtp.client-ip=40.107.223.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T+/r3YmQNREDWg3zA3VcBAHmLBjLCq6NPvLuqy7k/3WY7TY3jYq3LLXCxwQh1QucbXr6/ZUbgTOrPZN+gJWHptiIqyz2hkqNAOvfRsh9QLpxer9LHX4vV0ErUQpcOUwn8FEM7Ag/ugqeZ7uORi/TxY6ZuugGfkX8SO37Vt5AEKDrBBxkbKIjzh+4xao8O5CMMIjij1z6/WrXQn33FC8wG7au9EISBlHE6qg48MU51jaNz2oVn+DOL0A9gbCJJ/85mzBdekwRFo3zCAx7iX75uxfiYkmv/rpBhzZH2mfKyFtiRo8TaAG2RbpZg95j2+HY0zZ08KAbi1OwvR85p+SKWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t3TqfD3ymF6eqT4nlqJNmccBGoGKxBelhDPWPHnJ0q8=;
 b=SOCsn7rRaYO6k4af9vn/53JJEZi7H1/WUP4n4otLqOQOaEYm/Yatm38fJQvkKFiiYfO1r6kUQsJmxWskLX7seXdcoo95YmqqdvKk3SuKAdNnllcc0/kRXcb8Y3uBCcWwZxi3biyvG1S0NcH8uFQ2Me01LcEW+diJMYMaOlS4aIWqKuJ+3NGG/tV703IaGIzuLxFuq5AXQduvC2kLyxqB0SotxQi9raIkTHV9iw4XYHsaurkpvqhTyUaCWQBuhtqmtJDx6jp5Kc0VEc80T1NqBr7oHpxQ2SEJ0+OQfK+/JlajGWW0Hzen5lnUlKE196QW7MSatj2dEyAD2MwgsHoeYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t3TqfD3ymF6eqT4nlqJNmccBGoGKxBelhDPWPHnJ0q8=;
 b=AhlQYqtsfKDtZkZO2ypK528CjR61zshfcssxtXD2+6GT06xahb9TIt76EEXVEG1pDrdMQj+/+OD/a1OJe7WQeBXV1qYeCi0bBcFulbABHZWdoM92CxQ7/HrQewPKqNDFLDh2ve1q5ETPYWm/GZvPxaCKLkErzPMgs5W2zRNQ5bQ=
Received: from BL1PR13CA0402.namprd13.prod.outlook.com (2603:10b6:208:2c2::17)
 by BY5PR12MB4307.namprd12.prod.outlook.com (2603:10b6:a03:20c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.21; Thu, 19 Sep
 2024 09:45:20 +0000
Received: from BN1PEPF00004682.namprd03.prod.outlook.com
 (2603:10b6:208:2c2:cafe::20) by BL1PR13CA0402.outlook.office365.com
 (2603:10b6:208:2c2::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25 via Frontend
 Transport; Thu, 19 Sep 2024 09:45:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004682.mail.protection.outlook.com (10.167.243.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 19 Sep 2024 09:45:19 +0000
Received: from kaveri.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 19 Sep
 2024 04:45:13 -0500
From: Shivank Garg <shivankg@amd.com>
To: <pbonzini@redhat.com>, <corbet@lwn.net>, <akpm@linux-foundation.org>,
	<willy@infradead.org>
CC: <acme@redhat.com>, <namhyung@kernel.org>, <mpe@ellerman.id.au>,
	<isaku.yamahata@intel.com>, <joel@jms.id.au>, <kvm@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-fsdevel@vger.kernel.org>, <shivankg@amd.com>,
	<bharata@amd.com>, <nikunj@amd.com>, Shivansh Dhiman
	<shivansh.dhiman@amd.com>
Subject: [RFC PATCH V2 3/3] KVM: guest_memfd: Enforce NUMA mempolicy if available
Date: Thu, 19 Sep 2024 09:44:38 +0000
Message-ID: <20240919094438.10987-4-shivankg@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240919094438.10987-1-shivankg@amd.com>
References: <20240919094438.10987-1-shivankg@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004682:EE_|BY5PR12MB4307:EE_
X-MS-Office365-Filtering-Correlation-Id: f510be3e-3ae5-4432-9f83-08dcd88fc63b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CoH8PVwrVkFFuaqmWMh6HEMGGRoj7DTRG/ngW4R1N99ShmV/HedSKzqdxRwy?=
 =?us-ascii?Q?YZbIX1jXfipv9L5/gEtxGGMxV+M205EkJTM0VOtzKZGKZbgmoUNV3wJr8A63?=
 =?us-ascii?Q?IwCuw/VDU0xHwL4OdUM6XkuI3V5RxxAjxmM5UpBt5eUdAzGyYyqfGHaXQAEv?=
 =?us-ascii?Q?aT5kUpqfO47hK52JCTtRsRHo/GBGlF76Bz3GNWxkS2s9hVvIB/e8uddp2Im7?=
 =?us-ascii?Q?UOnBG12XEn7r2Ghq0qq6eS9l5o6hG6LXROfperp3ZlnR+pFFx+kcscYcXwc/?=
 =?us-ascii?Q?PkMK2qeUhxtJfUM9uuJxvFlksuA95M/XbFGx3+yv2XJQaT2jg+LbQk/Nep80?=
 =?us-ascii?Q?g7xX0jzZp+kymH05ig3runSHC7u7gtJiA+jND6tNDEndp6k7NW2ZU5a3sxky?=
 =?us-ascii?Q?jQl3h19h7pAumKVvt8QnAUgbj3E5nDTroDJSZ7xjK1kY0GrPplDEpIfIWZ7v?=
 =?us-ascii?Q?zbYzfCAwpd+rT2oghREkCX3/vm3LVPbJQqPvFVt8zdLjlJ+QqCXth3XSzBOJ?=
 =?us-ascii?Q?NjtlUKNBC/eH4sSRCqrPUgru3N4p8oIqSCX4ZzlCRXwzdloswjLFfIyJSeHU?=
 =?us-ascii?Q?Vy9AY7pNQK90lrURWk5egt6ssbxtobPyUq3ngVr6ygyWCMrYwuz1Qn9hAm5m?=
 =?us-ascii?Q?Ki6W97/zJLkWghaF6zPyV8Ou9uA/d+yy4azqEh+mn6FUTwpdt+sYVmvooi9x?=
 =?us-ascii?Q?70M+DsMAsU0a6dll3utSeVl8j1IKGz43r2x+dW6tlc/r6nCvGsw9i2iWXgkI?=
 =?us-ascii?Q?HJr1J7VOuTMKQpe9EMzZKTF5ht9nCsaLz8QVisl5ziJnSNVVfoN5rJVrN2EN?=
 =?us-ascii?Q?emo0PJxomt5KogA5rBGqAChjoqzsgHg2Rxyfmq9W1dA8BGOcp85iTSWAdjTx?=
 =?us-ascii?Q?G5HT7Id2D30L9Of9Xtne17aKwqVW5YUcL/Vlil6bNGfg6qt1SpIH6eUoHh+h?=
 =?us-ascii?Q?uo5kxQ2zo3mpr3OoeXA6npOGMgMPuzRlgtT6YP7NsftMoU/z4woGm/CmPqf8?=
 =?us-ascii?Q?mfcrVyh5+SFHtto4dwwCkfV8RtwvsTuh1dTQ/xGG2vWRbiC11NqqWHmQ/+mN?=
 =?us-ascii?Q?3S3piAO6m+47hYpKkeyJfOOpK8LHkj2n8j8B03RFoP1EM61eZju1Z3PyC5Ii?=
 =?us-ascii?Q?U9sPe/2wyL+e42KZZ2EGbcVwcp56AngHkCUSocDlZ6PNfYKs+utak3UNBAqB?=
 =?us-ascii?Q?qxp6/+4O3iT86uXdlFL4//iM3tZmbZ+VztKZ0VX6Pq1K6ZbfVZy5xBWqlTaY?=
 =?us-ascii?Q?mXXYIJfjCHgSLmtnc6YDz2N7VC62bW1WKFUF72dzLD0DSrr94CS1kYZkV6El?=
 =?us-ascii?Q?YuBG3wORTnl+c+tJWj10rX9ypzRdg7vGagZ/iwDM0yb1n60iteGMmESC2bxG?=
 =?us-ascii?Q?h9YvjqcNq5LV5VKvt8TtaoVWUSiuVZTAKlOg2XLoyNGPzlXiWhWCBvLaYD31?=
 =?us-ascii?Q?SIGGkQP105iPgiR1Ob21VlwNAvD9+33V?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 09:45:19.6861
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f510be3e-3ae5-4432-9f83-08dcd88fc63b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004682.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4307

From: Shivansh Dhiman <shivansh.dhiman@amd.com>

Enforce memory policy on guest-memfd to provide proper NUMA support.
Previously, guest-memfd allocations were following local NUMA node id in
absence of process mempolicy, resulting in random memory allocation.
Moreover, it cannot use mbind() since memory isn't mapped to userspace.

To support NUMA policies, retrieve the mempolicy struct from
i_private_data part of memfd's inode. Use filemap_grab_folio_mpol() to
ensure that allocations follow the specified memory policy.

Signed-off-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
Signed-off-by: Shivank Garg <shivankg@amd.com>
---
 virt/kvm/guest_memfd.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 8f1877be4976..8553d7069ba8 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -130,12 +130,15 @@ static struct folio *__kvm_gmem_get_folio(struct inode *inode, pgoff_t index,
 					  bool allow_huge)
 {
 	struct folio *folio = NULL;
+	struct mempolicy *mpol;
 
 	if (gmem_2m_enabled && allow_huge)
 		folio = kvm_gmem_get_huge_folio(inode, index, PMD_ORDER);
 
-	if (!folio)
-		folio = filemap_grab_folio(inode->i_mapping, index);
+	if (!folio) {
+		mpol = (struct mempolicy *)(inode->i_mapping->i_private_data);
+		folio = filemap_grab_folio_mpol(inode->i_mapping, index, mpol);
+	}
 
 	pr_debug("%s: allocate folio with PFN %lx order %d\n",
 		 __func__, folio_pfn(folio), folio_order(folio));
-- 
2.34.1


