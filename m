Return-Path: <linux-fsdevel+bounces-38828-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BD72A087E0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 07:10:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB52E3A4212
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 06:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D53E20E012;
	Fri, 10 Jan 2025 06:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IsiidAmI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20A720E011;
	Fri, 10 Jan 2025 06:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736488997; cv=fail; b=dZEs6VRPQ2XhWya04mqDS3YWi0jXthchJlQHW9mfx7d0LsxEDp1a8aWvhnochQ3Q7OGLlHmZXGKOqZQ5Gpg1tew0bY9tSRKfFbP9TMBDlKnuxpEdgd5UMJoBW0LRmG2k54WSSd90qIM2m2+2s0lVkju2gyTY9OogLV9DydmV5bI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736488997; c=relaxed/simple;
	bh=bVzgWyQa4w+3Tu64z6XFGDevakKWyWcLsWA7cirN12I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M0wshBxuGPqi8UWPrJuzRzls6qsTCqyP9nXZwiTQRTOWWQXcNzixwtKkpIFkPIU//bXgllFgtav6ygSGwKI0lWZTXE6yaS2AOCw9aWlfCnnXmMKzCYOh/xNYCdZVkL4kTitUYdqAhmAMtZBIPrZMOJ31ehlCTO3m4C8SCQcVRpw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IsiidAmI; arc=fail smtp.client-ip=40.107.93.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y18xpba6TdheYus1n6dVkhfLhglU0ONgqQfrNnYlwvcM1iWEj/cniKfFpTad7flRpDLUcq30Hsd59CTgLt4Vmse5OupzAK6cs5etd1ZhaIksgmSp56HkjitDP32ucuH5kNpCE2FLtSb/rFYSzGT8TJmqEAcOsXxL9F4UbKZj6/qIk/JPc2aqVL73Pw3t6IlmGtujxAwb9CIpTxRMyjevTT9fRGFXSg3g5NWK8MgzGdQIEkr2p6BgfHk1gY11yBQ7ACof4x/SyVIfTQ3TBU7aOnXH0wZsAM2qvSNUWYat5D2pQK8NUIZjwlN4O14kg9e9M5VmOMszUmlJrx05IEQGNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+RK8HcctKWrWGjHAxyN8k6xlAbP24zFsv0TFbZlW19A=;
 b=S8yLkD4vtMpOnXI+X3yg0lUvkaf1LGofKeKGauEzPB0QXGqP2QWt2j6/xUz0VnRzyyDFsIiNZROx20/CrZMbCao6bdHlqgAJ0d1ZjaDJT84t8t+qjCQwc6+ZIeQzxDlgpguFc80Hg4Y1ZxYvLdmOwIvpdBaIt3tX/AH78hQcXjxa3svWIwRPzaK88KO5BSfutof4Zo70z8pPQnYJFv2E9CKjJrj33lioZSWCjHsKI5WWEbikhkrSBRbyMTlNdEPJcPGdn22FxB+Xyv5IMVHnvAB3UT2v+P+UAFl3nr0oq7WyRJd0MhPWbOKnwJV9Sq5j4SgP4GIDi/xTrVLmNoWLUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+RK8HcctKWrWGjHAxyN8k6xlAbP24zFsv0TFbZlW19A=;
 b=IsiidAmIzGlV9snO1GXLGjypuf+oqJWB+BFtbvIArPqbaAqT2fLwHfVKq2Ig1dQbobsRTHmjdriH8IUp+rGczqP7e8fn7LahIN0xQ9x+TECGNCh4rw8uJrklRs0K2mkf8FrXdi/kd7tJBY/kgUSV3RPLIGJavVXxMUDhCVZP+TNaaL2+Pf75L74h8RD/cGCkgVr84YubI0PQyHWL7Zb3am+aTUvUcHbsU2DKxiLi3HAjFojkzOzCoIiTSnFOHYxDrVvJt3fCX8qUX7uG1RfOACiUBiPtBvmz33Bwg+EajglLyjda9egrJ7JCezhzgfKxJhQ0/s3jIrmZ/gpX55Olfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 SA0PR12MB7002.namprd12.prod.outlook.com (2603:10b6:806:2c0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.13; Fri, 10 Jan
 2025 06:03:13 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%7]) with mapi id 15.20.8335.011; Fri, 10 Jan 2025
 06:03:13 +0000
From: Alistair Popple <apopple@nvidia.com>
To: akpm@linux-foundation.org,
	dan.j.williams@intel.com,
	linux-mm@kvack.org
Cc: alison.schofield@intel.com,
	Alistair Popple <apopple@nvidia.com>,
	lina@asahilina.net,
	zhang.lyra@gmail.com,
	gerald.schaefer@linux.ibm.com,
	vishal.l.verma@intel.com,
	dave.jiang@intel.com,
	logang@deltatee.com,
	bhelgaas@google.com,
	jack@suse.cz,
	jgg@ziepe.ca,
	catalin.marinas@arm.com,
	will@kernel.org,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	dave.hansen@linux.intel.com,
	ira.weiny@intel.com,
	willy@infradead.org,
	djwong@kernel.org,
	tytso@mit.edu,
	linmiaohe@huawei.com,
	david@redhat.com,
	peterx@redhat.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	jhubbard@nvidia.com,
	hch@lst.de,
	david@fromorbit.com,
	chenhuacai@kernel.org,
	kernel@xen0n.name,
	loongarch@lists.linux.dev
Subject: [PATCH v6 22/26] device/dax: Properly refcount device dax pages when mapping
Date: Fri, 10 Jan 2025 17:00:50 +1100
Message-ID: <7d5416ad49341207e5f3c48d5b9c4b7af5fd9ac6.1736488799.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.11189864684e31260d1408779fac9db80122047b.1736488799.git-series.apopple@nvidia.com>
References: <cover.11189864684e31260d1408779fac9db80122047b.1736488799.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5PR01CA0122.ausprd01.prod.outlook.com
 (2603:10c6:10:246::19) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|SA0PR12MB7002:EE_
X-MS-Office365-Filtering-Correlation-Id: 22c062fe-c9b2-4741-fd88-08dd313c779f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lycuOy11TiPN5jqDOEDgW2ZLjC+j/tz4q9oO/CHDpcFPf6x9+hlr96QvPDR7?=
 =?us-ascii?Q?Hgpk/iHAtL7ndH8QlaZJIJSALkGVkJ8wkOKRtjWrHwqepusu54Q7blblvHF8?=
 =?us-ascii?Q?ZGG7itogeynSdcbvP4yM+CfM2bfDiq3/9+ZRY6GZDY+hoZHIr8QWX+liiL4a?=
 =?us-ascii?Q?I/OrtZ2rTM80JmixMjgohYEUNrOV3ueifkEAadMxEFcmuHoWMkv/H7+uhgcr?=
 =?us-ascii?Q?6dET8aiz/x2325P/PUct4tKBSXdT1AOONlrHwZuxYk6Z2j1QvIPhNjpmLnS6?=
 =?us-ascii?Q?kHGtaLoA0mQF0UpyfbsKwJpSCdTTC04OfbAbz5gNx5UAmb1k+1eJRl/uN/QJ?=
 =?us-ascii?Q?WzB0mxFpBKPcnz6lpAfltFIBUBeq7/b3ZLULO0b3BrLmUuH/kxc7ROx0w2Vc?=
 =?us-ascii?Q?2/LWVHsUYs1jHxv2LtVWyDHd27bgrN5QVdnwDIG94tPN8758xeDmMMx/dPSZ?=
 =?us-ascii?Q?AIFpXXQDxNdHxc1n/tIwKLXRiM5Npdw+Llzd4FbBIXQ1MscEeVvdBhHU/AxD?=
 =?us-ascii?Q?uC24hDNzCKLInASK06jcClGzeXlH/VWcta8GtXFPsTkArmRU13XX3TMVPRq+?=
 =?us-ascii?Q?dZ2PHw1Ss0eVUJeeDZWGm4iV4sZx808CYh1zP4AFRtN/7mVZHBJwNrihCVl0?=
 =?us-ascii?Q?TTVT5BQm5vnCXSNBGpYfEygrgD47ZxiG/fzgEZSdd1XBHAzGwiVOF9KTfrIL?=
 =?us-ascii?Q?91us0UIT4CbGFnhGvUbEMly5v9VMAxCQubabV+sFzDnNKGtTFCPXvN/7SOBW?=
 =?us-ascii?Q?oP5aHcDJ1Hkf+UHvV8lrgqfPrE1jBzLAMVWZaUM++IDe4jiqxfi2REK7n7tt?=
 =?us-ascii?Q?MiOmSYfa9PnCaO0hRqHG4PPZjYGpouwnkMbyjHji1XC8Lqi+XxaBwZSJaAX9?=
 =?us-ascii?Q?F37lkZeVfFSeXegmm6AGOsVDZpcy9Yufjnlqr8XUHuvOTTmk+XWBlR0Hg/EO?=
 =?us-ascii?Q?NaUWa++BUfqLlqaskOxJn+aizQzNDlVQUUVcLojCiWY9kpf3BToTBXZA3kBI?=
 =?us-ascii?Q?5SvJTtwl4Rc5GLc8B6vQ0K8RC+eJyAyreUl+y26VoH+v5qpmJhRCObJYDp7Q?=
 =?us-ascii?Q?LIOPURo2JK+OIE73koW6Y/DyrvFUo0S/fih/9JYVTJHTluGwr+3TSFxUZ4YW?=
 =?us-ascii?Q?ThrS1SROGB2E5ULetKa90xrugeIMhPqd3Viqu2O+L/ZYOWQtaCFSYOB0+GV5?=
 =?us-ascii?Q?4Ce2V/jx5kGdli+Pa4j3ddehKdp/BgnRfWn/5BSFYFG6axg1E7ZRa0oXBU9L?=
 =?us-ascii?Q?wucqaiZ8T4sbL1eSxh92ZCOJ+XWUzwd5OMl2UrYxti/eu9Vt7vj3tMSvDBaq?=
 =?us-ascii?Q?xnHWBpPIOd45qWVnJTxZghhs5ZbgJMLUeMdWINZ2wLUce1pG/4NbI0xhR/a/?=
 =?us-ascii?Q?mYqAe2hBuY+9LS3zxyDwDBzcQ5gD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?l1i7qh/dPZYxIZAmIf93JLe+q73C0J2YiYnGbhpWaz7tToXRlv28qdWMHvDm?=
 =?us-ascii?Q?gXCW0ZCZTNRkzV+/cosqrXZwtFTrjP1F2Lbjkm4BUmUhbVvph6isXbZiIwGf?=
 =?us-ascii?Q?/4BwNA4RoNMKMJa9Okn28kuiiIfg5L5LAj6a5wU9PaR0rRyhRx2yoI8FREsm?=
 =?us-ascii?Q?SEqxTP0k2OlnoDgc/8KSZACa+0V8X0Ck+F/zy6UTWxIAep5R8Ye/A62XH6AZ?=
 =?us-ascii?Q?8Bkb1rka3WNaVQMYgqjqDNDXixrEzTt8/mgp7UUPv8GQP0QFM73CuC9AAEf1?=
 =?us-ascii?Q?MiqWdOg0SS0IvLdBy9p/wFHh8sNYGT3qQLpnLVz0fYV7sG9md0MRVs+rsam1?=
 =?us-ascii?Q?7jcRX9JsuCceJqzFCDXoH6kzOzv+MkYPB5ub45NGvV97dfntzIcTyCrqrzuF?=
 =?us-ascii?Q?ienCGk/DKqPcXooGLPxrJ4DkGapPIBZaKBMgyC4Ua2qEiotQqsROTgODlbSH?=
 =?us-ascii?Q?9e7gnQ9kBoQQIv+1iPgPcaIpO4Eo4uIniewtf/H4zBhq1FoluYxLoxvXujux?=
 =?us-ascii?Q?KRsIe4PwAlkqCc/Dqfq68s5rHueUFHW8tJOTgBagfpGc440mCvDJfRGTvBYn?=
 =?us-ascii?Q?MDvy2t0Tz5EZLUigKuYp0C8B+cTktmiCH8y6AAvjUL0YzGJlIwhQOXz7UIQ8?=
 =?us-ascii?Q?HnQFbhIYqUtEX+VlT1iBDZ872e4EWvmX+46ObbjJAwyrHCu2EiFzq+Mt5DxK?=
 =?us-ascii?Q?NlH6+MROQQ/rZmTtlAgBY6pAnJhxcWnOL2KYwhBLks25kUOo6pYivietilWn?=
 =?us-ascii?Q?eVP1xoSS7W681GYOH9Gv/xjOs02MicJMeqlh1YiLXNbq0DJeK6w85pVFv4n/?=
 =?us-ascii?Q?OOGsqJKBg6n31zl+5AD2sBt8e5JvgN4H5jlb+0W2Wb9jHtJ+iGpiq6NfJwWN?=
 =?us-ascii?Q?SFKrEEcg6cQ7aiz7k+2nhWcwdaT0Uc2NKw7vGXNCrY3rjp5sKfm60VUsP4rE?=
 =?us-ascii?Q?jEmBHqSDPbXWGOgouId1QYkaHVWSOo/JMJ+wtkG5FBowWfzxyFGMn8sP1zYq?=
 =?us-ascii?Q?FSQ1RBOIet9b/2rmVZVx8g093Vn07D4aC4chMZdR0Sj22a3hVQmnkGk8OWiZ?=
 =?us-ascii?Q?5WPtZ1CY5neJvf8nbt6c9kRa3AjXwFp63b9bf5ollqzPmeVcHdo+8LBKWwYS?=
 =?us-ascii?Q?vkG+ADIKy78c71L7P2yaC+JUFgUhUGYb7kqYlgyRdqUCqq7qZdxYyar0gJmZ?=
 =?us-ascii?Q?taqf/Y+4qsGVs9WmF0Yp+DyKowmeACHjrJX68h5Dss9B7So/ld0tREXdb2hT?=
 =?us-ascii?Q?zxLDo8+ijsYUNNXl9XqamYPikNwA2QOrAoMAUS2itnd1n+vJcAtM3aWTrtyi?=
 =?us-ascii?Q?/j12PseGgu6KsTc/NFLgQmurrbnKvs5G5GetVOIFWhb+3LkIGGvxxlAOUmxU?=
 =?us-ascii?Q?tlM1rIcLqEEpeFVamNQe5hd9idr53y/GmPjYE53OA4GRl9JkjYDE18XBn6/d?=
 =?us-ascii?Q?0rCxM4XcmGi2up48ylEmBwuigLzFVc+h/vwWez7Gopd3qkyPtnfN9AKv2iVr?=
 =?us-ascii?Q?WJSXB3OXCIBfkEZUy+7swWp5L979a9frHNNhPG1dWjSE5aio6QA73y1fgdyf?=
 =?us-ascii?Q?sTJnBbaE3nXES7+t4EgxfOlRkguhK0A9eZT2a2I8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22c062fe-c9b2-4741-fd88-08dd313c779f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 06:03:13.2648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0RiJRIlixOpBkFWjby829rdmbUos9luBd8n9Gw3H6jW166Tlw9sazfjJVClIaR8CDWRrB8h/K/1IIilgvRqhaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7002

Device DAX pages are currently not reference counted when mapped,
instead relying on the devmap PTE bit to ensure mapping code will not
get/put references. This requires special handling in various page
table walkers, particularly GUP, to manage references on the
underlying pgmap to ensure the pages remain valid.

However there is no reason these pages can't be refcounted properly at
map time. Doning so eliminates the need for the devmap PTE bit,
freeing up a precious PTE bit. It also simplifies GUP as it no longer
needs to manage the special pgmap references and can instead just
treat the pages normally as defined by vm_normal_page().

Signed-off-by: Alistair Popple <apopple@nvidia.com>
---
 drivers/dax/device.c | 15 +++++++++------
 mm/memremap.c        | 13 ++++++-------
 2 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/dax/device.c b/drivers/dax/device.c
index 6d74e62..fd22dbf 100644
--- a/drivers/dax/device.c
+++ b/drivers/dax/device.c
@@ -126,11 +126,12 @@ static vm_fault_t __dev_dax_pte_fault(struct dev_dax *dev_dax,
 		return VM_FAULT_SIGBUS;
 	}
 
-	pfn = phys_to_pfn_t(phys, PFN_DEV|PFN_MAP);
+	pfn = phys_to_pfn_t(phys, 0);
 
 	dax_set_mapping(vmf, pfn, fault_size);
 
-	return vmf_insert_mixed(vmf->vma, vmf->address, pfn);
+	return vmf_insert_page_mkwrite(vmf, pfn_t_to_page(pfn),
+					vmf->flags & FAULT_FLAG_WRITE);
 }
 
 static vm_fault_t __dev_dax_pmd_fault(struct dev_dax *dev_dax,
@@ -169,11 +170,12 @@ static vm_fault_t __dev_dax_pmd_fault(struct dev_dax *dev_dax,
 		return VM_FAULT_SIGBUS;
 	}
 
-	pfn = phys_to_pfn_t(phys, PFN_DEV|PFN_MAP);
+	pfn = phys_to_pfn_t(phys, 0);
 
 	dax_set_mapping(vmf, pfn, fault_size);
 
-	return vmf_insert_pfn_pmd(vmf, pfn, vmf->flags & FAULT_FLAG_WRITE);
+	return vmf_insert_folio_pmd(vmf, page_folio(pfn_t_to_page(pfn)),
+				vmf->flags & FAULT_FLAG_WRITE);
 }
 
 #ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
@@ -214,11 +216,12 @@ static vm_fault_t __dev_dax_pud_fault(struct dev_dax *dev_dax,
 		return VM_FAULT_SIGBUS;
 	}
 
-	pfn = phys_to_pfn_t(phys, PFN_DEV|PFN_MAP);
+	pfn = phys_to_pfn_t(phys, 0);
 
 	dax_set_mapping(vmf, pfn, fault_size);
 
-	return vmf_insert_pfn_pud(vmf, pfn, vmf->flags & FAULT_FLAG_WRITE);
+	return vmf_insert_folio_pud(vmf, page_folio(pfn_t_to_page(pfn)),
+				vmf->flags & FAULT_FLAG_WRITE);
 }
 #else
 static vm_fault_t __dev_dax_pud_fault(struct dev_dax *dev_dax,
diff --git a/mm/memremap.c b/mm/memremap.c
index 9a8879b..532a52a 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -460,11 +460,10 @@ void free_zone_device_folio(struct folio *folio)
 {
 	struct dev_pagemap *pgmap = folio->pgmap;
 
-	if (WARN_ON_ONCE(!pgmap->ops))
-		return;
-
-	if (WARN_ON_ONCE(pgmap->type != MEMORY_DEVICE_FS_DAX &&
-			 !pgmap->ops->page_free))
+	if (WARN_ON_ONCE((!pgmap->ops &&
+			  pgmap->type != MEMORY_DEVICE_GENERIC) ||
+			 (pgmap->ops && !pgmap->ops->page_free &&
+			  pgmap->type != MEMORY_DEVICE_FS_DAX)))
 		return;
 
 	mem_cgroup_uncharge(folio);
@@ -494,7 +493,8 @@ void free_zone_device_folio(struct folio *folio)
 	 * zero which indicating the page has been removed from the file
 	 * system mapping.
 	 */
-	if (pgmap->type != MEMORY_DEVICE_FS_DAX)
+	if (pgmap->type != MEMORY_DEVICE_FS_DAX &&
+	    pgmap->type != MEMORY_DEVICE_GENERIC)
 		folio->mapping = NULL;
 
 	switch (pgmap->type) {
@@ -509,7 +509,6 @@ void free_zone_device_folio(struct folio *folio)
 		 * Reset the refcount to 1 to prepare for handing out the page
 		 * again.
 		 */
-		pgmap->ops->page_free(folio_page(folio, 0));
 		folio_set_count(folio, 1);
 		break;
 
-- 
git-series 0.9.1

