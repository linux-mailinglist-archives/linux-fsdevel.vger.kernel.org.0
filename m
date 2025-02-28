Return-Path: <linux-fsdevel+bounces-42819-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9722A48F9B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 04:38:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1408A3B9438
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 03:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E16861DE2C9;
	Fri, 28 Feb 2025 03:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bMoMcWzz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E1B1DDA0E;
	Fri, 28 Feb 2025 03:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740713563; cv=fail; b=YP9IRzOSxV5nWMJ7dtnaKtyo3I1aEuiuJ+V1GB/FQWdHuS3JRcrb2E95x24m+YaoOckiiyv4S6zx2O+er71rXJ1Fs6wGmhxPFniUsEMdNe9bihebIndqxT3Trefnx5SyQmK6aWob+SlRpU2ZORfH3S8yCUxwaLD/KjEFXp/Lwbc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740713563; c=relaxed/simple;
	bh=lxvcxiAERX4u3lMeFhjTSvCJqjT8+v62jqsrMQchVr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=blM0LtDcE2JMwLpK40EUarxV3aqk8FLuDVxTb56F02Ac4d6o1dGwpWp8cpRMafeCjVB+Lv5Buzi36j0Sto1Uf9MWT+wnqR5jpWPFyBZLBHeUS3hGOhubqIA10UKUy9zdEgg5gqEKA1TJswKAJ91DAXv0PUMsGCMnxe3X7qP7VaI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bMoMcWzz; arc=fail smtp.client-ip=40.107.94.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=srC6fd1+4kPTJxcPm2tIMmc2P8e0/3Z44XVNc6q7T0EM5oFHllUdX+9WVlLTRprCAPRRQOdSfZZEMFY1kc3eyPElAZHSN53QnS7Apmm5F/KXbdB2aJdqHvRjucwO+G/gaDs9hh9YSGeIkLmTOpxnLJG54Vc5igoHCTr84YX3GPapn5efeLUCqqIYz8GexAxzzO7/HB9kxdQS8kr8KyaEm9Q4FcEe0FtBQbhG1O6jp7YlzTaJar2JH8QWjucxcDqFEp8D8npL1GtwFClxeIBtlAKaGwkcjNzsxrbDTFO+ripvCTwk+lwD6zgGLrYz3ptA3EOjb6TOezva14k3p5sIOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BPkfSG+iXeKAyAjVqa1PJ1E1IonWgQrZ7MBYoYvRJTg=;
 b=k+Li6wv4p0BCgq16DSeYWzxX26i+/2+IDsOC+WhuIikiGQK27YXFD9PkM+joHvNRMJS9JsCo65EsRfeA5lxO82i5sX+YI90jU4tpmrcax1nJJ2QonMpQG+GcHsCcrYSXTU7b+aJoN6cvC1wDbvD+9wzsx1DTbKkyS7EQ5dEATyBFfcYIBtiZbI+jojb6HIELe2BIhSjRFTSSH/y0eSN7zqsD+iP+2pJVUxm7JC7hiHyOvihR5PIbmoZXADT+DWFg6HEQqn27o4lI6qeFyY9aB2r06nBX/Wdf97zxFWs6MbXQUDe78X0HPgjM0rsePm9PziqcJ8X+KYiQg0Zj19ajiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BPkfSG+iXeKAyAjVqa1PJ1E1IonWgQrZ7MBYoYvRJTg=;
 b=bMoMcWzzngxN1jSMkj2ASvWN7Wq0JNbJRq22ehOn+BuBMD9SBPyM05dJ5o2m+Gux1+e9exVBW+1xkrkZu0Zpam9BzSr2bxTvMu7c+e1qBxdtORBbvgFEA+beNtFJIs9MNivEpt4GZjT8FvwwDLScQZ5WcJ8l6L8SD9rA5x5KRq/3n/7VST+hfa8JHBxF7DwrcPkz37h0qUpXHJeMEP0WoPrfq/e5/1nLGlcMluzg5CDNwu7gHtI0wlKGcQhR09HJczYOudj8jzKGmDaICdhcRcbpemzzBsZ2LhPl6B08xfPoZOR+z+Rc8wzHkjjG0Ur47rF3dJwA0AdUZTxcxc5fkQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 SJ2PR12MB7991.namprd12.prod.outlook.com (2603:10b6:a03:4d1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 03:32:39 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%7]) with mapi id 15.20.8489.018; Fri, 28 Feb 2025
 03:32:39 +0000
From: Alistair Popple <apopple@nvidia.com>
To: akpm@linux-foundation.org,
	dan.j.williams@intel.com,
	linux-mm@kvack.org
Cc: Alistair Popple <apopple@nvidia.com>,
	Alison Schofield <alison.schofield@intel.com>,
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
Subject: [PATCH v9 16/20] mm/huge_memory: Add vmf_insert_folio_pmd()
Date: Fri, 28 Feb 2025 14:31:11 +1100
Message-ID: <7bf92a2e68225d13ea368d53bbfee327314d1c40.1740713401.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.8068ad144a7eea4a813670301f4d2a86a8e68ec4.1740713401.git-series.apopple@nvidia.com>
References: <cover.8068ad144a7eea4a813670301f4d2a86a8e68ec4.1740713401.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5PR01CA0023.ausprd01.prod.outlook.com
 (2603:10c6:10:1f9::7) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|SJ2PR12MB7991:EE_
X-MS-Office365-Filtering-Correlation-Id: 5941775a-8968-47d8-81b0-08dd57a88d04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MvC7HML4Aah2rfTieShn566whk6Rlg5KX+keQR1V8QmVm+neQdtMU/C6TPYX?=
 =?us-ascii?Q?o/m0QWWlNT4l/CZeNUjr0DdQmVkEseDtT7x/nOrHbXSr13S71OnDEZE1b5rO?=
 =?us-ascii?Q?KFywpHcoChfNStOxe9P/veUtzI9gR2RKNsVW2a3ta+oth3zsgcUv/zbqjG0I?=
 =?us-ascii?Q?PoUtaOImCW0S5PVLvpDWiI82Eif+q0FCaItHs6P2+JRYEfJTkicfIYVrwH6y?=
 =?us-ascii?Q?/ELCFtR9iuEU8JSFoiawjPQQU0xN8U+38y3ZYHWtcBQ7uhx+OfIZDFWo2Jli?=
 =?us-ascii?Q?OwT7lH0TKrHiQEFXYhemlmEMSBNHrZPG0Sfd8VagXX3J7TcRDr70pD8m0MmR?=
 =?us-ascii?Q?/oNHOa9hFS5Z970YFFEkAaeBAesCR/XWsScMGIrUtNezbc2WqNYn6dXx7TcK?=
 =?us-ascii?Q?GQ72fU2HXI4wr2kWTWTFtPgu86IR7ZR/9hjMCnisOPdtjh9IgYwI0+BYGN0t?=
 =?us-ascii?Q?wqoKxtYad4Ht3YWQgCpuaEcyFK9fU90oMJmyXskIrKPIqO6oiKkSxcEb0cWg?=
 =?us-ascii?Q?rvtfIK9ryNSKEiKckWhtDC/brSvgSeMhlMXQN12478KrLFxLfrw5MIYiBegj?=
 =?us-ascii?Q?TIeofdyzeWHrwd0DUPBPUvJQrifuS1tCLo98CI5mq6PJpgC/yqFiaHJXd3WU?=
 =?us-ascii?Q?sI+gDc3pnCHLfUDUDLhh2T599Z4NAULaQr/1ouEP9BJGBYR7DItc0i0jwo4V?=
 =?us-ascii?Q?fwKmOSTruRKg9kjyqTi/2RaRe90cDZ7zm1P0w0rk3I8tOV4vcUnikrrYLWjW?=
 =?us-ascii?Q?F1kudMxcVaDR3KyNbIde4N0YaMLsHlxzLATcEKNVQ1KKxWd5hFXXet6Fc0qo?=
 =?us-ascii?Q?fZ8ruebWZ+7KKGk9ikkdxteMNvW5pjVA3XJ+z8/7Wt1iwrRVATvDjsE+q6c2?=
 =?us-ascii?Q?D6a9mhepAFIi/nQAXAsMX96ZPrCDGyaDZXnJVpiYDcaNHQKLoec1vZrS7CX9?=
 =?us-ascii?Q?DIwFW1yC0XiAIoJqdT01XMqBeziYYEZ/SNk2iiMhx5yOqDyi6UAEPlJtj/2F?=
 =?us-ascii?Q?l4jhXOque8qg4GTActqmQU/bpg4s7W3ySBKvsaxAtWgy5c9BP2G4jN92oVaW?=
 =?us-ascii?Q?/FQWi6vJFNcH0ldX9riwdtqcSqnb5DB2Vy+dk98lnD9wHc3egKrTXd2W6Ljo?=
 =?us-ascii?Q?ix/cDL7OWqDNjljBOl3HdUL2VJbvOvpW4iN43+v2DURr9Q38yK2RjGKvYnzD?=
 =?us-ascii?Q?bmKiXkW2jZEsh9f4RsnLIlRBTqekgzFi/AmWWiE9wkQXdSGLWYFeo04ObehP?=
 =?us-ascii?Q?K6jFHVQKhC5o1BN+mJUtaXUAl9+DND5EMPMhWCzAv4IYso51td3bDqubYMuS?=
 =?us-ascii?Q?1x1CyN6oOUISLAK6xyNmpSQtZiCrS8OFMFAMCPQ9KqjwCaSlMfKKAPJdmmgf?=
 =?us-ascii?Q?qNOHFbcxGzb4PZUDJnOIr+LCpBJv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HFBFmEU43RPxA6pvEJ+EhXNguuPyKNkV+aUbO1NIkLk5dgoCEPBhsCBsAUqy?=
 =?us-ascii?Q?Ns5wD1AHDjExb8ifz/5zxlM2+mXr7ilx0F+rvYycxkWbP2oOmjiylxcKlxkv?=
 =?us-ascii?Q?ixnsoG+kbkt7YFaN+vQTRVnPyXL9Dop/1wlPz2H3Q+9ocQ60QGzn0Y7+lrIG?=
 =?us-ascii?Q?7ltyk7rY2UoZrb+9yHEBjxfak+/bE8ODUWPfK7/8Ue1OHWkGKDmRsFe5e2Gq?=
 =?us-ascii?Q?kT2zKiTWYujbKpEGEajMXaMV445YgDqE/nNbKUkkAeHziJ3TQX1Jhr2Og8Cq?=
 =?us-ascii?Q?C4HdtC8I3uDnJ6O3MXPAsrp69dYX7sdOSR+ExOei6jhP/HXs1Prq6Fjo7Alv?=
 =?us-ascii?Q?a3+rq5I9OayRsjFr8iWVLa5k3TsoGnHU0I8KS1ZaRupBnsnqCqf7dinEuX4v?=
 =?us-ascii?Q?LrkacHMf7s12GGgLaIxQ/fWV4FqdBf1Fj+LaZwOWWUuQ2lxVq9okPzROLYcf?=
 =?us-ascii?Q?RXKg1/aSxHZ42n+a+0Cf6H8T4ak+O6frwBTJ4y8DMAVRKzCSYJTGJ6AO8IFB?=
 =?us-ascii?Q?v0XQk3/ivRZEvx1I5AY7jSvvFASNrJtfHoA0FR5blsHKeVnBsJhUexLGqsRE?=
 =?us-ascii?Q?nPty4JLv5lqCXtZSXiCSYf1r6avU6lZHEtSlEDFjHypPtxLmcsN4btPn0Z7x?=
 =?us-ascii?Q?3cnCfnMkZYzQ+gdjzYOZK9kMFdwyqG7aMto020sqAi7OndqQNNTEcAGTRSZJ?=
 =?us-ascii?Q?lhyeIoM5vFOtnf/PXQjiShcJ8fj7xGYT6kIMgCz0HpfcQN6r9Vgd1/rtC/jI?=
 =?us-ascii?Q?Oglcnmv7CJt2ls8+CgCFSxAJ6Qq8BVzwK8SJAHWa6IM+MQZhoszG0oh/GU+Q?=
 =?us-ascii?Q?kT6kc4DJ3hSsZk0e5eUrYDsNg/ZjUY14hO9ynv7HUU7k1VpgV1WUVKFHsZPC?=
 =?us-ascii?Q?tTY+AwWeLENsScNxB+SyvDD2MRVEune5WWQJsqQUVaYhGrpVedpoS1TZ5RrJ?=
 =?us-ascii?Q?sy6AoQZM15ZoKuIpQZ4Wx4thYmzPqT2KYm9BdLYTsISl8CUbBhvX65OFOYec?=
 =?us-ascii?Q?1DLEh+8fltcCd5I4I0tKOmh12vAv6FtumDdHsltPZsfikPYUtqcu7m7856Zt?=
 =?us-ascii?Q?OJFkSeAAqP8rIzaJ/pJxaGLjjLVP1PN9iM2q7s//As6Ro5VzLJ0Jt9tG0W6Y?=
 =?us-ascii?Q?Cmzp5eIN8XZ+nSIgtCMf5rmYKQCmAAl4S9/LrOGODSzQunJCdpGCFWVhFhY1?=
 =?us-ascii?Q?ESw2iTB2SQ/k8bhxb058PK4CdQq4BaMSRJXvurN4D5fSU8hotNkhUdJAy/zE?=
 =?us-ascii?Q?ow05giDqFOJg+Whb5u4RXMYfqQQ/3ad07SzR4snAiVg2KzBBEPcxd0dUsbQj?=
 =?us-ascii?Q?5bbcYlANISDQJ8uXrEEP+VAO0jBCehmFz8nQbXYiyJ7YfNDJIRKbppWz5JCh?=
 =?us-ascii?Q?LlI9v/swLyOiNVx6+TGhRKdQWVrCk71mAYjPTAQUZH5nqR4auHgldZJIfcgB?=
 =?us-ascii?Q?5QEBhiSXCMuAN++dxN+mtc2VZ/3jZRGH61LhRg6ghTEzxma4T7oK5E3SqZZq?=
 =?us-ascii?Q?9sADlwMCWw3OJ5NC7+8OtyOfX/ZJcS8KDKTfKUnd9FHJmQz1E/kF+wAu6+Er?=
 =?us-ascii?Q?3qcnYE18dJm8Azn1JFju3a+tOy1QWS8/fHz1iNu7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5941775a-8968-47d8-81b0-08dd57a88d04
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 03:32:39.1551
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OA9hEPlJMjbw0LCs277PihIa2LjXfBarf5XLG0yyLM3HKIWC0qMUMvHVFd8srdB19hx46hQAvKkBeg6IoeQ5fA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7991

Currently DAX folio/page reference counts are managed differently to normal
pages. To allow these to be managed the same as normal pages introduce
vmf_insert_folio_pmd. This will map the entire PMD-sized folio and take
references as it would for a normally mapped page.

This is distinct from the current mechanism, vmf_insert_pfn_pmd, which
simply inserts a special devmap PMD entry into the page table without
holding a reference to the page for the mapping.

It is not currently useful to implement a more generic vmf_insert_folio()
which selects the correct behaviour based on folio_order(). This is because
PTE faults require only a subpage of the folio to be PTE mapped rather than
the entire folio. It would be possible to add this context somewhere but
callers already need to handle PTE faults and PMD faults separately so a
more generic function is not useful.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
Acked-by: David Hildenbrand <david@redhat.com>

---

Changes for v8:

 - Cleanup useless and confusing pgtable assignment.
 - Fix line lengths

Changes for v7:

 - Fix bad pgtable handling for PPC64 (Thanks Dan and Dave)
 - Add lockdep_assert() to document locking requirements for insert_pfn_pmd()

Changes for v5:

 - Minor code cleanup suggested by David
---
 include/linux/huge_mm.h |  2 +-
 mm/huge_memory.c        | 65 ++++++++++++++++++++++++++++++++++--------
 2 files changed, 55 insertions(+), 12 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index b60e2d4..e893d54 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -39,6 +39,8 @@ int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 
 vm_fault_t vmf_insert_pfn_pmd(struct vm_fault *vmf, pfn_t pfn, bool write);
 vm_fault_t vmf_insert_pfn_pud(struct vm_fault *vmf, pfn_t pfn, bool write);
+vm_fault_t vmf_insert_folio_pmd(struct vm_fault *vmf, struct folio *folio,
+				bool write);
 vm_fault_t vmf_insert_folio_pud(struct vm_fault *vmf, struct folio *folio,
 				bool write);
 
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 1da6047..d189826 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1375,20 +1375,20 @@ vm_fault_t do_huge_pmd_anonymous_page(struct vm_fault *vmf)
 	return __do_huge_pmd_anonymous_page(vmf);
 }
 
-static void insert_pfn_pmd(struct vm_area_struct *vma, unsigned long addr,
+static int insert_pfn_pmd(struct vm_area_struct *vma, unsigned long addr,
 		pmd_t *pmd, pfn_t pfn, pgprot_t prot, bool write,
 		pgtable_t pgtable)
 {
 	struct mm_struct *mm = vma->vm_mm;
 	pmd_t entry;
-	spinlock_t *ptl;
 
-	ptl = pmd_lock(mm, pmd);
+	lockdep_assert_held(pmd_lockptr(mm, pmd));
+
 	if (!pmd_none(*pmd)) {
 		if (write) {
 			if (pmd_pfn(*pmd) != pfn_t_to_pfn(pfn)) {
 				WARN_ON_ONCE(!is_huge_zero_pmd(*pmd));
-				goto out_unlock;
+				return -EEXIST;
 			}
 			entry = pmd_mkyoung(*pmd);
 			entry = maybe_pmd_mkwrite(pmd_mkdirty(entry), vma);
@@ -1396,7 +1396,7 @@ static void insert_pfn_pmd(struct vm_area_struct *vma, unsigned long addr,
 				update_mmu_cache_pmd(vma, addr, pmd);
 		}
 
-		goto out_unlock;
+		return -EEXIST;
 	}
 
 	entry = pmd_mkhuge(pfn_t_pmd(pfn, prot));
@@ -1412,16 +1412,11 @@ static void insert_pfn_pmd(struct vm_area_struct *vma, unsigned long addr,
 	if (pgtable) {
 		pgtable_trans_huge_deposit(mm, pmd, pgtable);
 		mm_inc_nr_ptes(mm);
-		pgtable = NULL;
 	}
 
 	set_pmd_at(mm, addr, pmd, entry);
 	update_mmu_cache_pmd(vma, addr, pmd);
-
-out_unlock:
-	spin_unlock(ptl);
-	if (pgtable)
-		pte_free(mm, pgtable);
+	return 0;
 }
 
 /**
@@ -1440,6 +1435,8 @@ vm_fault_t vmf_insert_pfn_pmd(struct vm_fault *vmf, pfn_t pfn, bool write)
 	struct vm_area_struct *vma = vmf->vma;
 	pgprot_t pgprot = vma->vm_page_prot;
 	pgtable_t pgtable = NULL;
+	spinlock_t *ptl;
+	int error;
 
 	/*
 	 * If we had pmd_special, we could avoid all these restrictions,
@@ -1462,12 +1459,56 @@ vm_fault_t vmf_insert_pfn_pmd(struct vm_fault *vmf, pfn_t pfn, bool write)
 	}
 
 	track_pfn_insert(vma, &pgprot, pfn);
+	ptl = pmd_lock(vma->vm_mm, vmf->pmd);
+	error = insert_pfn_pmd(vma, addr, vmf->pmd, pfn, pgprot, write,
+			pgtable);
+	spin_unlock(ptl);
+	if (error && pgtable)
+		pte_free(vma->vm_mm, pgtable);
 
-	insert_pfn_pmd(vma, addr, vmf->pmd, pfn, pgprot, write, pgtable);
 	return VM_FAULT_NOPAGE;
 }
 EXPORT_SYMBOL_GPL(vmf_insert_pfn_pmd);
 
+vm_fault_t vmf_insert_folio_pmd(struct vm_fault *vmf, struct folio *folio,
+				bool write)
+{
+	struct vm_area_struct *vma = vmf->vma;
+	unsigned long addr = vmf->address & PMD_MASK;
+	struct mm_struct *mm = vma->vm_mm;
+	spinlock_t *ptl;
+	pgtable_t pgtable = NULL;
+	int error;
+
+	if (addr < vma->vm_start || addr >= vma->vm_end)
+		return VM_FAULT_SIGBUS;
+
+	if (WARN_ON_ONCE(folio_order(folio) != PMD_ORDER))
+		return VM_FAULT_SIGBUS;
+
+	if (arch_needs_pgtable_deposit()) {
+		pgtable = pte_alloc_one(vma->vm_mm);
+		if (!pgtable)
+			return VM_FAULT_OOM;
+	}
+
+	ptl = pmd_lock(mm, vmf->pmd);
+	if (pmd_none(*vmf->pmd)) {
+		folio_get(folio);
+		folio_add_file_rmap_pmd(folio, &folio->page, vma);
+		add_mm_counter(mm, mm_counter_file(folio), HPAGE_PMD_NR);
+	}
+	error = insert_pfn_pmd(vma, addr, vmf->pmd,
+			pfn_to_pfn_t(folio_pfn(folio)), vma->vm_page_prot,
+			write, pgtable);
+	spin_unlock(ptl);
+	if (error && pgtable)
+		pte_free(mm, pgtable);
+
+	return VM_FAULT_NOPAGE;
+}
+EXPORT_SYMBOL_GPL(vmf_insert_folio_pmd);
+
 #ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
 static pud_t maybe_pud_mkwrite(pud_t pud, struct vm_area_struct *vma)
 {
-- 
git-series 0.9.1

