Return-Path: <linux-fsdevel+bounces-41926-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED153A391DD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 05:01:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B9367A3684
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 04:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2ADD1DE2D6;
	Tue, 18 Feb 2025 03:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="s+J0Si8h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDC21B3939;
	Tue, 18 Feb 2025 03:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739851039; cv=fail; b=UQbW5ouSbFwDRZWsOHuZuozQZTsToLijHmVvuD7cU5WgAAzZVDhpeoXYs0l8e4/GVItZq4nT90TmnMXfHljy9PTpHbxX5W31gnvoegVOw0x3bgl9OPiuiqBr2gDZHwBq0KsD9XYGhbw5dxDUxQO1yYV+Ctf9ag/VZqDcokmW9ko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739851039; c=relaxed/simple;
	bh=lxvcxiAERX4u3lMeFhjTSvCJqjT8+v62jqsrMQchVr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WOKkjLF8V3irdz36SN9lXH4sv5Ha5cSMzjQlQRszfOcySX/AMuaCvFWGRKbohvINZeIgLaJ22Ile6MrkT4JgiXrTDl1oEoGKd0YBAzxJl8ZuzNWmt6acDr4sA68Hkio2yyj4lspI9SPzRuId3NRZwpO8czFX9a9AHbdBKphUnYk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=s+J0Si8h; arc=fail smtp.client-ip=40.107.220.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NfjMgE2tIi3xt1+1A5/gW9d37z8ipmfyCKh0V633/F4wQwzAvdVMmX37Yj3JmGJWXpUdo/kHhtIzDL7JO17V3LPtatYAhKqYfVJzXojPzRg/qNCeva1tqXvaDtPFDIXqi53RXJAMuTG0SZhaGHNuXGpLlU+T76WOeSaNIkfBkgxroqFyy7kIgn0qI2Ybssv+gyFUM6YiE4y1Pk3YJRna7+Wz+p0vwN25XgQ1tekYzPpeELHFWqsd/jbmU5Hes4mQ/EbqAlDDkZcNz4sv5jSwR/nCRgJE9YBvJKTW1IQ2Nxn1fGCOXl8BLHrqfV0ubMiD/AZHaFOkXSO/7KfLxaIRIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BPkfSG+iXeKAyAjVqa1PJ1E1IonWgQrZ7MBYoYvRJTg=;
 b=xOx+N4QI/Ah34rgng+rP9EZL1KNwTVRuuCUT/Ni3DICYo5b/46ewc/1vOMJ7toEU0VuMraC01GI78ntEoxpNlTdT3s6KPwujgQfbORkHtZ+Y1eeG+vQnKK8d2/OPq66WjPzxK2lstzWUNjaC6qfkrzzacDnmtumjrgGl+zL77Y2Hq724ZNtMUExxNTKHvsOoUZHGgTQwZyqk1UrFjQloP8On+cZv0wuBAU7nwMMzl8R0OHe8MBk5OzCXMDh3HeCAQegrPwPQkaYekNN0ozxon+lI27PXie04Qjy8lxbn2oc7mBEBS8umJNmqo6IyJU7gsQepFTnSX45lyRcwulo34A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BPkfSG+iXeKAyAjVqa1PJ1E1IonWgQrZ7MBYoYvRJTg=;
 b=s+J0Si8hNs+qazbX4Y2OQ0odNmFefpUABaFFEvI0NgmsdMqIWgPSJuLXGAsmiFVu3cCcLBU22zqdx3y4X9pggQ4H49UAfNYI+x1o9KzCEWfzy4dzxblazM0AdV/DC4oOtUYI4etC6NZqOIiFFKwJNX2EXbZNhcM3K7CEl0ovSecfOWx45QnuTFSzUS6/ht3upiELOPjpbYxkU069xUNUOeOis8BQcCU5+UWirase7leePKQokX/TPPMvXDWQYsClEg2hUkVLx3rD5wMgRdH5T2UNHHOAUKINvQXnqRvEKLbrZ2MKHkJb47DA1vj63yuMcH1X3iEbgfRvz40JEFlA5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 CH3PR12MB7593.namprd12.prod.outlook.com (2603:10b6:610:141::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 03:57:15 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%7]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 03:57:15 +0000
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
Subject: [PATCH v8 16/20] mm/huge_memory: Add vmf_insert_folio_pmd()
Date: Tue, 18 Feb 2025 14:55:32 +1100
Message-ID: <16b232f09b2e678ef5c21eb74f21794a06422ce4.1739850794.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.a782e309b1328f961da88abddbbc48e5b4579021.1739850794.git-series.apopple@nvidia.com>
References: <cover.a782e309b1328f961da88abddbbc48e5b4579021.1739850794.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY6PR01CA0068.ausprd01.prod.outlook.com
 (2603:10c6:10:ea::19) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|CH3PR12MB7593:EE_
X-MS-Office365-Filtering-Correlation-Id: 24c37faa-2354-478d-2056-08dd4fd054af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lBEMAxJCJ497ZANIjP+a2HbX2IEb6BbN9dgdBjcT0PPvpI9NENvgCKx/mXSO?=
 =?us-ascii?Q?9bbBz28PSM6ADYOc8ea6pK8LIriubf/nHolk6Ngn8kDSg+/+JkpUc2+B++QR?=
 =?us-ascii?Q?Ki0TTPxiuL/iz4pW5K3kf/rZtVQ7ZiJRPJt/s1mnln3yDJA+bsPeI1ZjI2c+?=
 =?us-ascii?Q?Ekb5RKP2Wq0YKi6dHMuIO9WT5sx+vXAtJzY2ZMburHLqT8fprkjyTlz8IvKg?=
 =?us-ascii?Q?hTfO/P72doHuwDybc58bmJA/94Zzb0fmpC5nsCE3Zqnx//l6dYoqm2QUroIG?=
 =?us-ascii?Q?0unAIAm6EhCTsjQp3Wx3wAzGIc6ys6nYowpeoMg5sJ7flGExCD5+z2wpnqct?=
 =?us-ascii?Q?zbVX1H2BSI+CEA9KmRWKaLlcHAl7cu8Y9vzxymzZqbsqNSiIs/rRcGjJD6Kk?=
 =?us-ascii?Q?10Ar7KHIbXgQKDQ9F0QdcwSdYf8mu/tLAhBFb3gViBBHHbItmh1izRaXLzeN?=
 =?us-ascii?Q?pJYBlRjnm8QZJrrBw2R0TWE0WV84wZIvH4CWSbXNMq4EmVVkf31rdG15aiKz?=
 =?us-ascii?Q?owE07AupHcfUOqxSHLKDWTxPxcXnpK/KYWbbTg3+AUxx3uJLOYfWjhZ6pXS/?=
 =?us-ascii?Q?tr3jbP/co5hgkryAryXz38ScdAnKr97EG2xZRPSLBtQoVMm/XVZjxTpZq10Y?=
 =?us-ascii?Q?gFKJeVtJJG4a33n0Wgz6sVOF3Va56nUcIJXPBpUeUbK14xulg4ZCa8QJ2iJ0?=
 =?us-ascii?Q?m5Q+VmuFC7znL2j29eVMBtgxyLvSgOmbrWTVwqZwACBa51q8PE3OEGDF6SIB?=
 =?us-ascii?Q?Y5d1XF6N30O6DD07dVFDYLPCf9uC4REpXhsPQDkt2vSApQAomeQEcY1UHjpQ?=
 =?us-ascii?Q?7tn+VIBRNc7CbUi3zxyfl3YtXViBSqnQflT91fDVWN7ALwRbBFg/xDvr5mc4?=
 =?us-ascii?Q?eZNL8pFwcSydbQhgVGUnX+hbyTD+V6+yH08Dcok6DbBWRBgxsDZc4Jyx4reE?=
 =?us-ascii?Q?ZqzmayrnqkEMuJkvcttnn6bqUmFHDVHB3rsskVTc7O0AOzELjVO4wSBPGIvk?=
 =?us-ascii?Q?YNsPM0qRc7UJGWiybWvUev2WdxJT85LuSBkdoAWy5E3LynyPR7r6FB9kY0F0?=
 =?us-ascii?Q?pzoCl7TrzzsPaOfL4ckmFCWDXL+PcVU51mGcYyuxvd7K57TWfeC11lK6fJoU?=
 =?us-ascii?Q?9KkHS0ZbPU6qJ8LwPsDRA9qG+TQliLheA/sTdj+aeB2BlNSMQHXs/qLh0zOT?=
 =?us-ascii?Q?y56rN0tOFkjaFvT+B4Lvn+ti5X5BwQ+K42AQo6TW3kZHJdXshjdxChSnTQ27?=
 =?us-ascii?Q?QyFSu45qQPjawvRB9Bt7ETG0FVYSxIDC7Kzg2Q5BiPtLHXHOurwGM6KJGRmh?=
 =?us-ascii?Q?gew04tiQgyj0qvvWdxFRqKmAf1B+6omdIoDMASIJ0oakDNMsZZzIA/yHFhXj?=
 =?us-ascii?Q?HDavm1IJhoS+7Lh9eSUHx9HtX1Ci?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pY6qgrMIi3O2e2bkDzvGBDdgZThi3ZYUIWDqXIoW8ErVgcUaf3zPIN4vqvV6?=
 =?us-ascii?Q?qrwtDz1ANvovOFLm8C76GwOESNG6VvMMvukH+RPd4vwkZDHbHjqGY5pIAZpC?=
 =?us-ascii?Q?Izh6K3JWfR/kCsT0lX6IrAJudtOqBpGh7DrZ65upmPnX5TJnosuMeloeK9QO?=
 =?us-ascii?Q?YW3HD35UwIhV6EDVzO9HqB5N+1mm2QTVzrLgGhvG+Flb4z0yBHb/b58TNLye?=
 =?us-ascii?Q?NAvUHzcokhyZIrKwFnJhwZTwKmKiX7wvbhEKGo2esuaBU+yoYlrc13hX4V9B?=
 =?us-ascii?Q?+1KYsXbN140GmfhLIL5iTRD34X0VgDyd4C0JHEtlMrqUJDKhUenzDMOmHSWA?=
 =?us-ascii?Q?jexbdnIb5Novzr5j6yJp68dYrkjZqtojDbAw78WkXI9kZS2SYLV+cm4v5E68?=
 =?us-ascii?Q?+7z69XUnyuPPXGlP6rVn6k1qXiqTasBatR+h/MYn9A0QS3yBK2zjqIflfD79?=
 =?us-ascii?Q?/TvqqBuPQKIrrsuyngcd2PlHvclzZlHbpI+YoXlOfdhpTTVjNKZsjvp9SCWD?=
 =?us-ascii?Q?frU5AlY1jy835WUSJUUI/wmdjLalPIP+qcVG3U/9x+5ROZ8Hcgjk8n2iDE3n?=
 =?us-ascii?Q?u/114A+oYwHSkrTj7fTX0tngD0no7ANXBuIu0GKFZ9gYvuZ+oUnEpC7NZa61?=
 =?us-ascii?Q?HiXCJkB3V2e35mHAHpzR8uu9fngZAgBwvIE7jgK7y+tYZBoxHW7VRA6HBPtv?=
 =?us-ascii?Q?SSxoqx8ei5AgsU/8iUa3mccYsNgKQLvL9Y5EodDnnYVrsF+8ibocxWz17dfI?=
 =?us-ascii?Q?Tk++YrubuSBQG7TDvt7WlbV5dAd6Umz/rbu6nA8QJw6qlbP4c4wxQBHRmytc?=
 =?us-ascii?Q?fkkZ3dSAppMR+BtVDZ1TA4zAciO0bYbPj7FWTNDWYoytIJcZDSoP16d6khF5?=
 =?us-ascii?Q?regEgIeZsi2xnIK8ZjJH2InwJRcU+8nFOOBQtt5nu7Ptmjyz55nAtw+ta5UU?=
 =?us-ascii?Q?T7CxX3hjUmp7iwHULv9+cOT4PC67BSfcU6ueH9tQwvCmCpDKpe06soevWHwU?=
 =?us-ascii?Q?7MSxefyxsj6rPwGeezM2HHHTWnxdG0kSLmQTrlaBW61FTbQ+iAqJ21nirjbT?=
 =?us-ascii?Q?NHSUA2m/MKb54/qJ2WNiPtg9Fuj9Skhm36B1uVMS/kiBlTPSk840PEKx9aiR?=
 =?us-ascii?Q?ZZoYoTId8mAR49nnriLFzA56qFUqhKL7ZMHuJOPs2tezfcrOHYGKiNJR7w6z?=
 =?us-ascii?Q?WyAihvKyViN3tOSDLd5eMry4nXlerItnbTdaYsFd4oGE4yEn/fCAhFhKs39l?=
 =?us-ascii?Q?R58DAQ3KAD7uwp+4I0G4nYv07kr4+WU/4SJxiqQddyqageDdnAjevlyCEu6W?=
 =?us-ascii?Q?17s222KDFLt4cx6nhZmXrNtdflh1639RWhE03mL6dMSqkMEQjRXJ/g4P29Yf?=
 =?us-ascii?Q?IcX52mbo1EB/HpMxYAZGk/ISFAGx/mW0N0MTvIsvDgVS5ZU3gVmlZXBvh1tN?=
 =?us-ascii?Q?7UoFhQUUy1SJVy6LBSfsnFp+yax7P1i6bBwFV1aphnTxlFtO8OqaJP3ypS2o?=
 =?us-ascii?Q?/DUDXKb84Oo/EqNvZ8RL1R+jlkkIf3eZ8yDMzKXbRE4DHMOx1USVhjaACCX5?=
 =?us-ascii?Q?5srSo/g6I0YRKPncbqGSDYxgTUQPMHT8O4A9cmmF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24c37faa-2354-478d-2056-08dd4fd054af
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 03:57:15.2316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9tCb2iUkgYhRW08XmmxhM3SUU0/9GmLe9S/rscn3kAbzKGsZz6mZoldA5fdZKbEMWHtwIaVX22hrXBbTEzPynA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7593

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

