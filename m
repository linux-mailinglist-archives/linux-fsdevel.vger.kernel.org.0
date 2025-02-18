Return-Path: <linux-fsdevel+bounces-41916-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FE8FA391A7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 04:58:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22A64163A8E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 03:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB8DD1ABEC5;
	Tue, 18 Feb 2025 03:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uSt9xC/2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2050.outbound.protection.outlook.com [40.107.212.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFAF1B6D0B;
	Tue, 18 Feb 2025 03:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739850985; cv=fail; b=XuL/XNFTlexNe6DyKgGcqgaVyh/ezCl3NOiSZg2CEhudDFG6Ms+qH8+YlmqRj1VC+WFbSXwMoezvtrd9jB6JVli7Uhx3jbXl/zhiKnGMv9LgwDmqMVS63l1rOCTXOniEfQrdOixv0iH0vvuBFcO/mCnqK2a+OTSrJqutlRa+f/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739850985; c=relaxed/simple;
	bh=NB2qWAEf3M0nhaVcGry6fSIHPnB+RJDfQFtzNOsjReE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uK4i8lb+R9Xr9Y4Rd9t9ouFq2to66lC4dK276s6ZpT/OKOFXk2+i52cmJEodCcQJir0w7lV+Yh/7qIO2HmUiu67thRD6Fd8m3K61cptPyE4sv1lytisRysGF7zWeuJz2yamvUUKlzsv7Rfxme//6r9wF/eAGYd+9gnY8rUKLuLY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uSt9xC/2; arc=fail smtp.client-ip=40.107.212.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wzy0NbSx0zrou61QMtC6nTBzSle0ZENdX0ECe7607sB61OP79Vq/JY56vTTdeg8N+qLs31fZkKx6hnNJzXe2cjkD0Ie4+O5FbT1FpNTXiDBrQ8a83jDQEhnwyDcEgql/E+/f0krdNokUdn1YxQKng0XOwPJCXwitiv0K1zLaVIfKcxxkDEySAQo9Ql3GFI+HrRe2ZfQXd20kWUYPIo0VWG36NscXdkDIARPtgdnoOk+GSLWovIUNhDAySRSaxvmk+wcVoMDVy6u/PBzuCr+YWMh+0LCwaQkiNZG1h0LdJ1qrDpodQsbiDIQyZrXZPYXwuq10q+7qyJw61OtXjPr1jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w7VcP7ZEvUthj5PzZYbtWmdjUZ5HeQZyLdoZRveFFxw=;
 b=tAjDNY85KuzC597VdzEJdLkAIr0ywSQDtMAMEFYOU5324Hjw32ptwKLO8/wlQqeJ3bWn3AyoOQ4w+aLWZXQAoDHNLXLK4SvmSkRbydr8MsYjYs9+BbI6mW2vbQoVjHCNDf2aoZS5FxcbOf+7kEwoAbQ7sYOu8DFwLqkgL3pij38YkB/eDKhwFmiA1sm2awnRzXncw+ze8eVKyrg0JoPK0XbneG151injWIMFguF00XIWgIyOl1blLv8SCpQiN39eJXxxJN4+LlzbKfO4UOJTE+7X6eojls7XSAj4Cd9p5AaXtjPpCQhfz7Y1dyOiubi/A2L7EPIylMCbmFjF21Qu4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w7VcP7ZEvUthj5PzZYbtWmdjUZ5HeQZyLdoZRveFFxw=;
 b=uSt9xC/2fYa9YNjkDDaobSAdMvCcKnSimK7rQh0OC0J/ymyLRu5A3EGS87mFaGYxUB4sYIXKjCL6lbPH8ZMPJY+MpHTQDl2Bis/hwdRZiWHurwB6mVkJb+1f4KRfaX7cj+ckcx3wLRspsfz7cVr9o6XpGCbXDicDCqmTl0px52oLW7mx2+sSzfr9IBQNIjI2b1htgF5EqXwW1iMaIsPD9P0FCt4h6qPC0tsD4nacnG72jSLHW5IzahwczA+BV5xjNKsJk+XPqolXeoE/+u5icYRdQtQ6geaC43MWWU9hl4cnwzuhbPAc5wCAPrsLoo4e1DZEztCptEzjPHKZ7+GSiw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 SN7PR12MB6789.namprd12.prod.outlook.com (2603:10b6:806:26b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Tue, 18 Feb
 2025 03:56:21 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%7]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 03:56:21 +0000
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
Subject: [PATCH v8 06/20] fs/dax: Always remove DAX page-cache entries when breaking layouts
Date: Tue, 18 Feb 2025 14:55:22 +1100
Message-ID: <3be6115eaaa8d28fee37fcba3287be4f226a7d24.1739850794.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.a782e309b1328f961da88abddbbc48e5b4579021.1739850794.git-series.apopple@nvidia.com>
References: <cover.a782e309b1328f961da88abddbbc48e5b4579021.1739850794.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5P300CA0015.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:1fb::7) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|SN7PR12MB6789:EE_
X-MS-Office365-Filtering-Correlation-Id: bd48a5c9-fddd-4032-6da5-08dd4fd03460
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Zn5utKrhRIbfUAnJ0WOh8IrXyO/ZBkC2ojdrsKAhaLpPXPIVh5gQ8X/bNTxl?=
 =?us-ascii?Q?aWkwxoh00G0ZgX5QjKQ9gT8t90pzPHmxjl/eYDqzGgGeqVK/zTxFcLzsoPaZ?=
 =?us-ascii?Q?3Ty6eB3BEKZphR99IaRZbNU2VMIGN/jGtLesKYkbDmH9XpOZEBodeFaV5baG?=
 =?us-ascii?Q?5q992s7xplocmkmBwBDYfxtUFXeEgzGgjRARUNQEF5PELuBLI2gZFRI/wjmZ?=
 =?us-ascii?Q?HdhNtVYrTY8F8iNWJ8o7ruvwuJkPnOFQ9wY/uvh/Pu40ilvVDL4kIMkx2CFR?=
 =?us-ascii?Q?Vq9AJivq5EpIAeYUVxv7FlyDXtDEuZmS8xeRVTMiXdDiFUZzaQqS4sYlaJ77?=
 =?us-ascii?Q?tyxxMOdh9i+F3ia+DpyqNzBV1DnnXiAr965IX4z30qWe6as6F2GNfsVpo6Km?=
 =?us-ascii?Q?x8KT+/cCkdlW+zIF1i01+hNCKk0lHLQisEyIR+BrnuzVk3FO2jiWG5dlwdu9?=
 =?us-ascii?Q?Z93vWhdMEUxie+MzlW0hHSZisVOMH/ICI7iBSxdS5WpV7ChelKF9hk7rluXa?=
 =?us-ascii?Q?VjeZrmIABiC6BS3CLW3NF031+hZFnWf9hKgqqNG/+XgDs8yDQhZRPv3YRc9U?=
 =?us-ascii?Q?BHUwKcifquPyMgjeLZ7WAW/c5G9zLeqplP3z5xI5W+FCFphPBihT03cRJV6F?=
 =?us-ascii?Q?ib0wrwF2/lvTWoFMFlXzmxe8NfAFQTjLPLjTIqwj5oLJKODhXcO3csD2LtM/?=
 =?us-ascii?Q?3sLA9Cf4U+3VXLE5teTgGgBG8aQgcZv5QTX5Jeh13B+PMuhtwQLuxzet8Wfd?=
 =?us-ascii?Q?lT17fv/CuDtE9NmauSpHMHO1uQpdW6v8bMJ7UhjrRfMG4DtQQAyr9RrIT7B7?=
 =?us-ascii?Q?cqLSg4W4xpqVuSqz1WgAztNfrQs9owGljVnfV5kpy0TFCeXJSR8l9wwKMJlA?=
 =?us-ascii?Q?fdDQXFVpsR1crQMxxdjGYF8NK+0MoNal+oEa2LhtDtC16hqWTZ4PQ4IeXhAt?=
 =?us-ascii?Q?+W/ZiwgkPzRcq1ZjjF01RkbrgWLnPBu/KCNUhZzOR5lwu0SNWI/0EpEDW8AT?=
 =?us-ascii?Q?qwU4Ye6kBwe5cbYJgmvpimyIBZRIYoVpDoC7yLNbhX4N8InHHIygN/xlFoEt?=
 =?us-ascii?Q?Q2ZfJRb0bimhk/DoPD1F35y1FAN9dyjZEN1/A9U2X8CqLL50SkJyW9hdp5J9?=
 =?us-ascii?Q?oNMv8wwBoWJrXt4ZiEbGazNwIgWVhfvKjYsjUCWIDsIrqg5HiC+NWyb8arVz?=
 =?us-ascii?Q?PHg+MfOypMWloOIB1O/5ld3sFuaWKZswys5cmRjLKyPk6q8q2AWYJAzglcX6?=
 =?us-ascii?Q?ifb+Cvc9SO/bfDWI9JHJ6KYQVPHWACLAobwllB9EDybfN7D78LEz/M78fXzL?=
 =?us-ascii?Q?3MWV07KIrOy950ipPzxU9kVwhEFtn3CvUrFBIIxDCV5iFYmfDPSXqEpPxvTb?=
 =?us-ascii?Q?r0aGpHf/GOxtTsnaaRFmhVMm8/VB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?B0GoW6AX/U601I+sS70aN6Tkm669QIndGzF9Cc1uks/ljUTUqHfpkLdcjoYQ?=
 =?us-ascii?Q?549U5rUq62jZ4BdEJlSMhcJmIWyTnXoL8u1H536LBJUd0K3bEzyyz4W0lpGj?=
 =?us-ascii?Q?QtcgJ2UVWB4kt+CGxiOvkvDPCEOI0YxIc26a0zMYWV1v5/ThZScQp8JW3PeY?=
 =?us-ascii?Q?BdIhgJazbBOyz5cibBlz2wTKFmCbGHe0QeLNAAjzp8onmfJ6nAndz0GCJIA0?=
 =?us-ascii?Q?7mZ1sDWklyej8D7BtSDSQQtgJPFg0Be9OsHVl4f/ht1eBtOpcTM97wIK+7fI?=
 =?us-ascii?Q?VuuOvbd6UD7vzqTXDD2ZyIkIzSCUqGgRtuLta+U7vwgBppn33KDZOlD72XLr?=
 =?us-ascii?Q?EOBqzNnLRtisLoCHAGiyWAuScnKCuxkUym0c4n+MJ1ZdY0Kg+H1hIUOUhIyX?=
 =?us-ascii?Q?VHZQAa4y6bXvrlRYQA4i/2lcAFLchGl2yZr7LN6QPCinIkRFYRU2HDG6YdQg?=
 =?us-ascii?Q?ceq+UxFStbgv0zuMYs3hJ8ffjERyK2HSOsw4VbMqhKGxcqUtlcXZS+qhkkSZ?=
 =?us-ascii?Q?/karIdqPuNQiik0r2AOeg2RnY64YqjvmYifAYyugwAzqWwCASn/j5vvDipe/?=
 =?us-ascii?Q?cf2t8WpPR/01/ebXvu2pqcK2awtE8vRM6iBicw5/Ph77P/9OILAP4GzgBfld?=
 =?us-ascii?Q?x5sAddUxFaxOHtdLFflZKwW8UGc7zyjwAgkQ7YklPlmebMgXoUUTRvUeslSG?=
 =?us-ascii?Q?CcF1dmGMoADjSnAAPVS6Gcuk+lNyfsD4k0OtaCLT0ILZiniTtL53QLC/Jlyd?=
 =?us-ascii?Q?tTfOAR5HrzzFegYwAm+BkXhn4QZqN55SbS1OpCnwXsRXl7lCaWwwon68gRC4?=
 =?us-ascii?Q?YvxDKdTAy+sqpKmrqkTmaAJIslSlPnocZaQp3RqgAn6U6cgHtrRcclbBbNmQ?=
 =?us-ascii?Q?odaoVS+MV+AJhzh+kJ1MMtkppVC0V0lop72y1D/ljdEFISWPhYD7bh479mf5?=
 =?us-ascii?Q?1s6Y7sYEs356BshDJ5HbgdX2uK2YgFjoMTD+g4npZ5npe4ILk7VY24Hf9BGG?=
 =?us-ascii?Q?qT89SVfBy8QbLtR8+UKq6D0w/vMzz6CbxkwidPpifdqbcRK/JVfRAPwIbXZJ?=
 =?us-ascii?Q?+Hg2wqzThxYb+RAd3WhPL/xHeu+3gh3T2rLghVvptYElM2chqYD4llKvUQWW?=
 =?us-ascii?Q?MZe/ahEUQi5Gu2PUm0JjkkZ6YlQ10SBLWloKa2Vk6JIYLCWA718rMZNBJ3yV?=
 =?us-ascii?Q?K0RtJbqa2RDNJwdocFfLgmpJwph10WQsQIhQov8VcdUmSUYMRN/+e/dQxSiJ?=
 =?us-ascii?Q?rWLvvF1DeGUhpeak9hW6C56OAXG1iMQbuDmXDpNvdpwnWIN4ISZqBwFHUCrB?=
 =?us-ascii?Q?mLouuivYA4fmCe5ovf2wo7W8ChMK6sRJa3P73j98Z7v10KVqajPiZ7xICjex?=
 =?us-ascii?Q?KsNUdpFvkeW3oyVztQRaTKxVQfoxnpUK9qHXxMMMRIcAJF23qp/V+BBQ1/Ww?=
 =?us-ascii?Q?rPNt7EL8kXlXlYOg9TDuv4Oz0Fpo/H9hulvFwDcZouN9ZXsEvcEVwSLd1zd1?=
 =?us-ascii?Q?7hwTH6a2K8fKPXPel6Otey7/cNC1v+vMrX2e5tE2MSQ1eBu3KVhEpAWd+/32?=
 =?us-ascii?Q?cUCeaxawZdOyizg2cqUHfNO8DWlH3NrUkzePyUyL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd48a5c9-fddd-4032-6da5-08dd4fd03460
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 03:56:20.9979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YZAR4vlAoCuWXsUoAOgcYP+tDTvnuY7bpacFW1NQkQmEBfVkBJbEx67mEH6RQV15HaKhRXxm5XgJl84nEx1JjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6789

Prior to any truncation operations file systems call
dax_break_mapping() to ensure pages in the range are not under going
DMA. Later DAX page-cache entries will be removed by
truncate_folio_batch_exceptionals() in the generic page-cache code.

However this makes it possible for folios to be removed from the
page-cache even though they are still DMA busy if the file-system
hasn't called dax_break_mapping(). It also means they can never be
waited on in future because FS DAX will lose track of them once the
page-cache entry has been deleted.

Instead it is better to delete the FS DAX entry when the file-system
calls dax_break_mapping() as part of it's truncate operation. This
ensures only idle pages can be removed from the FS DAX page-cache and
makes it easy to detect if a file-system hasn't called
dax_break_mapping() prior to a truncate operation.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>

---

Changes for v7:

 - s/dax_break_mapping/dax_break_layout/ suggested by Dan.
 - Rework dax_break_mapping() to take a NULL callback for NOWAIT
   behaviour as suggested by Dan.
---
 fs/dax.c            | 40 ++++++++++++++++++++++++++++++++++++++++
 fs/xfs/xfs_inode.c  |  5 ++---
 include/linux/dax.h |  2 ++
 mm/truncate.c       | 16 +++++++++++++++-
 4 files changed, 59 insertions(+), 4 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index f1945aa..14fbe51 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -846,6 +846,36 @@ int dax_delete_mapping_entry(struct address_space *mapping, pgoff_t index)
 	return ret;
 }
 
+void dax_delete_mapping_range(struct address_space *mapping,
+				loff_t start, loff_t end)
+{
+	void *entry;
+	pgoff_t start_idx = start >> PAGE_SHIFT;
+	pgoff_t end_idx;
+	XA_STATE(xas, &mapping->i_pages, start_idx);
+
+	/* If end == LLONG_MAX, all pages from start to till end of file */
+	if (end == LLONG_MAX)
+		end_idx = ULONG_MAX;
+	else
+		end_idx = end >> PAGE_SHIFT;
+
+	xas_lock_irq(&xas);
+	xas_for_each(&xas, entry, end_idx) {
+		if (!xa_is_value(entry))
+			continue;
+		entry = wait_entry_unlocked_exclusive(&xas, entry);
+		if (!entry)
+			continue;
+		dax_disassociate_entry(entry, mapping, true);
+		xas_store(&xas, NULL);
+		mapping->nrpages -= 1UL << dax_entry_order(entry);
+		put_unlocked_entry(&xas, entry, WAKE_ALL);
+	}
+	xas_unlock_irq(&xas);
+}
+EXPORT_SYMBOL_GPL(dax_delete_mapping_range);
+
 static int wait_page_idle(struct page *page,
 			void (cb)(struct inode *),
 			struct inode *inode)
@@ -857,6 +887,9 @@ static int wait_page_idle(struct page *page,
 /*
  * Unmaps the inode and waits for any DMA to complete prior to deleting the
  * DAX mapping entries for the range.
+ *
+ * For NOWAIT behavior, pass @cb as NULL to early-exit on first found
+ * busy page
  */
 int dax_break_layout(struct inode *inode, loff_t start, loff_t end,
 		void (cb)(struct inode *))
@@ -871,10 +904,17 @@ int dax_break_layout(struct inode *inode, loff_t start, loff_t end,
 		page = dax_layout_busy_page_range(inode->i_mapping, start, end);
 		if (!page)
 			break;
+		if (!cb) {
+			error = -ERESTARTSYS;
+			break;
+		}
 
 		error = wait_page_idle(page, cb, inode);
 	} while (error == 0);
 
+	if (!page)
+		dax_delete_mapping_range(inode->i_mapping, start, end);
+
 	return error;
 }
 EXPORT_SYMBOL_GPL(dax_break_layout);
diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index d4f07e0..8008337 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -2735,7 +2735,6 @@ xfs_mmaplock_two_inodes_and_break_dax_layout(
 	struct xfs_inode	*ip2)
 {
 	int			error;
-	struct page		*page;
 
 	if (ip1->i_ino > ip2->i_ino)
 		swap(ip1, ip2);
@@ -2759,8 +2758,8 @@ xfs_mmaplock_two_inodes_and_break_dax_layout(
 	 * need to unlock & lock the XFS_MMAPLOCK_EXCL which is not suitable
 	 * for this nested lock case.
 	 */
-	page = dax_layout_busy_page(VFS_I(ip2)->i_mapping);
-	if (!dax_page_is_idle(page)) {
+	error = dax_break_layout(VFS_I(ip2), 0, -1, NULL);
+	if (error) {
 		xfs_iunlock(ip2, XFS_MMAPLOCK_EXCL);
 		xfs_iunlock(ip1, XFS_MMAPLOCK_EXCL);
 		goto again;
diff --git a/include/linux/dax.h b/include/linux/dax.h
index a6b277f..2fbb262 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -255,6 +255,8 @@ vm_fault_t dax_iomap_fault(struct vm_fault *vmf, unsigned int order,
 vm_fault_t dax_finish_sync_fault(struct vm_fault *vmf,
 		unsigned int order, pfn_t pfn);
 int dax_delete_mapping_entry(struct address_space *mapping, pgoff_t index);
+void dax_delete_mapping_range(struct address_space *mapping,
+				loff_t start, loff_t end);
 int dax_invalidate_mapping_entry_sync(struct address_space *mapping,
 				      pgoff_t index);
 int __must_check dax_break_layout(struct inode *inode, loff_t start,
diff --git a/mm/truncate.c b/mm/truncate.c
index 0994817..031d0be 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -78,8 +78,22 @@ static void truncate_folio_batch_exceptionals(struct address_space *mapping,
 
 	if (dax_mapping(mapping)) {
 		for (i = j; i < nr; i++) {
-			if (xa_is_value(fbatch->folios[i]))
+			if (xa_is_value(fbatch->folios[i])) {
+				/*
+				 * File systems should already have called
+				 * dax_break_layout_entry() to remove all DAX
+				 * entries while holding a lock to prevent
+				 * establishing new entries. Therefore we
+				 * shouldn't find any here.
+				 */
+				WARN_ON_ONCE(1);
+
+				/*
+				 * Delete the mapping so truncate_pagecache()
+				 * doesn't loop forever.
+				 */
 				dax_delete_mapping_entry(mapping, indices[i]);
+			}
 		}
 		goto out;
 	}
-- 
git-series 0.9.1

