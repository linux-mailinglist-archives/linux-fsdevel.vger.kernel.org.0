Return-Path: <linux-fsdevel+bounces-41928-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 805E1A391E8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 05:02:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A2EB7A3B9F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 04:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 948A81DE4DE;
	Tue, 18 Feb 2025 03:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nGvhWfaF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65D71DE3D7;
	Tue, 18 Feb 2025 03:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739851054; cv=fail; b=KXWbEkghtshMBN8QjXKnq6ndfxSiA4mLbuWflU7cy/7DoprGeT7VRxJIlxqUaes7YghkgP+hB/CvCHeVseNh3wB0K20ncZZMvxRHPZvFFxIgn0rORwikvqGnV6vpGOKQAL0bTWifxx3PFWxorTNdpy1GfB+DfRzkVXWHzwfF3y0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739851054; c=relaxed/simple;
	bh=X623mmXDr/V8tui02oZFzBQpW5DYhwmPCmwhu2QfHlI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DADKODPaYQwsIHoX4oytD9Amp0VglKay+H79Y+4SJYhxL1le9AeNdIyH7LORKx5Eu9YAzSErkCag17J2Uh3bOZyMin8lhiG6guxm7C7dllvcanaotZ0YPC/OKDYgJ7rhjvddlutPhg7+j4kOis9FiOgMLEhPe56mD0xriSUtG4Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nGvhWfaF; arc=fail smtp.client-ip=40.107.220.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZP39YEW1M4Ve94mnIESFggkIJO/hRc8Ab/PQWZWO3vPom0HHhD/0BntWCWQXgA+GNrcrdnUqGPEk3N4zZ+43wzpRsQf3tMsbLJvbbmkGWC+HmP/TXdSNtCLEGCKgEDh6qCY5PZA9cqfNyAA65eAiV9s8xnrCNSncCn7dqpBrzFjmUDmgSJiIqr28vfXTuojsx40vUXZ0jPrw/ZeRciX9QRf3WHanWRZQGqcpLG9TLb2yXFkljpWRTd3QTbZpmp+OT1RgPQKKnGGtXGoRPAFhsPlgTfXmG803AN2PVgqS7YjL4zYD5MEnr+LNj9CylhgskBuVHwBC7IZtYb/TTFdBbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RtBaqYvfVYWwhkk0mbirzaJ8NN/nkFZeQ7cueszAH5c=;
 b=i5Y4Zou5Sag6WHNNMm199sonbUw6E8fozpbJtzepsmPuI48qKUyPz+bP8Dlemi3Jj9jpSXdzWt1imK+6ESZZuSBKwWwYjfWctfnxv1PhITO1FQNNN7BZl2XnogC25qnHfbEQyDLzpEUkcxImacux5yY6ltyYxMibWolHE0apCQPKR/15Wh38FfFIhEPS61llWfFdyqYesLPard9kmjBszVotRdDnQrdf9IlAfmYDMZdGxNF6DGDqAW9gZcfoWoDPywVYnQRDGp7SsoekB1s1/T9qg/XTK5ZpPxciWSj8CSSiqc1/3lEDphje+JBLDldLOK/gUAg3ONukE2oVh/T5MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RtBaqYvfVYWwhkk0mbirzaJ8NN/nkFZeQ7cueszAH5c=;
 b=nGvhWfaFAP91l6b1EcwazmEcAIqMnxfoKAH6H9sw8LtMB2U71xSXtCna6yvUYml1SuG01eU3aOmbU24PVFYG4JBS9GJvvyzGJaf19LM8NdXOakTRh24VtbGMfFqvb7XwHaRboQOAQSdb2vz78h3+GkgphWA00UdOlJwZRSCa63ifllB+CVBOsJio5C3ve3FWOeZwRI25ZvfajHLO01ysgL8UVtnoyvRfxjWro/ttRSm0hcUR8ii6fgzTopHQKnHVbYtpdRFaFUhgpeo8LlM2J02tjN5ZwnxxhZ7Ls9s5bQ9hiwqcC34cHGmkRWCuxNnqAY16y7Qg9tUcRkjZT1WCvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 CH3PR12MB7593.namprd12.prod.outlook.com (2603:10b6:610:141::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 03:57:26 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%7]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 03:57:26 +0000
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
	loongarch@lists.linux.dev,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>
Subject: [PATCH v8 18/20] dcssblk: Mark DAX broken, remove FS_DAX_LIMITED support
Date: Tue, 18 Feb 2025 14:55:34 +1100
Message-ID: <f6a6adc9628745c5545378dcbd64fe68ea8e5ae2.1739850794.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.a782e309b1328f961da88abddbbc48e5b4579021.1739850794.git-series.apopple@nvidia.com>
References: <cover.a782e309b1328f961da88abddbbc48e5b4579021.1739850794.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5P282CA0160.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:24a::17) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|CH3PR12MB7593:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ec3027f-2c8b-4eb4-b486-08dd4fd05b43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JnbaNkcAr0zS3vBVEVZE6qyx8J2Ab8vwC/crckWojmkYTONKbHNtIdxZQCa0?=
 =?us-ascii?Q?GZpeEe2OP9wheYtlnhflIjB0aKWzW3VkCxNILefh7JTPsD/XT9YFq9KzHaxA?=
 =?us-ascii?Q?oqhBQ0sXOHNwx8maHmKkTqeng3kfVK6wCky7WWUndQfIT5bXzXSDcC3EQMCE?=
 =?us-ascii?Q?Fu0iZWN70KI8zsiydUUdTDq4lGJ+8O98F2c6LBJC8jmQ5Y1RG0qjg1I9Nej6?=
 =?us-ascii?Q?2q7OLGnvLfEG/xNw4YqhhBCx6FPp51IT0x4VO4P/xgJCXMSE2jfVyiVAoxlL?=
 =?us-ascii?Q?Hs/tZEQ58cMsjvxHot9IrABgxH8aebKT3ceeA85aj1D5FwpV/FVlCsMyJQvk?=
 =?us-ascii?Q?3ueEUzrTrh68n3wshheOxS2c4XAzc8i8MOM1Jl29F95lhnnC7ZLIrKIjXe3X?=
 =?us-ascii?Q?yINKeGHcJCEaUIW2iin9bNpofQ3lPaNqEDD/kqHDr+nyMChqZkZlkA5Gwxnp?=
 =?us-ascii?Q?00W5GJfahx0UcXMosSq51R3xBnaMLZm0CG+UGHtY8eGnlXFRzD3bFBzdLvqr?=
 =?us-ascii?Q?e/RcD3yi72d1ddInN9IVg9fKwyHzAXxaw4VDctRw4bG5dfauJqZd4BICkNDb?=
 =?us-ascii?Q?LGRCBK61nT4OzFAsmvW/BmGZNSW1mlByLYFFnA2UsYZx98hDh0Q7mM9v63b5?=
 =?us-ascii?Q?DLaWV3R/Wa+NH68jrRrhUPRQBJ8pSLuP4r6cR4Yn6eoNsdxjHGRtKzNufYSJ?=
 =?us-ascii?Q?YGtTIFRlEmdHMp/qokMBf0sVt3/+/dEO+K5aRaCBEeODAvGHKuF/8A1ohvm1?=
 =?us-ascii?Q?GcqMHwtJKo0TG96O58LCe5xpmFL9OR+hVENPuYmF54qmZx5bWKfzEn34fmNj?=
 =?us-ascii?Q?qXJEEjJl+XUKpZM/e+jHsKlpmfjsUK2BDSWs8LZX1O9VcG8xnBB9HhC8IwJt?=
 =?us-ascii?Q?X48U0ig+lm09OBbNEvco8wINjCSuLHSavMelr25EK9J80Zq8xHk48JJSEfCj?=
 =?us-ascii?Q?W+Y02pTZWUBtPZ4ynrzNX2UXNgGi//0YdjvhYklxAgtDoWrpDU+jM2sPl1lD?=
 =?us-ascii?Q?A2Gk7gU8s6U8qcagbsW30zW7CEzbAZAsyCdlIJQ0tKna1edjZV+GQK6ev43R?=
 =?us-ascii?Q?ehuDCW7CH04JwMHYpU65AyjPOhvYNwfvF6ahlUBv9QOCpqUQ+HidELeg0auH?=
 =?us-ascii?Q?xX+xV34fTNF9nq8/R5EwC/hprrO5JVEz9A9evmvRRWKrPUc7kvuUS7vj6Bjp?=
 =?us-ascii?Q?fVWVwbgSyyHGB+GP4CHlZ/0CrTcfGoRkj/wTnoU2TXzFsZBtsFYcdUroLc0r?=
 =?us-ascii?Q?eyuLKiFxYkfiW5yXJn5qYdv7Zx1Oan6gwKP4liwuqMnBzK2pnigYYFwrvxhO?=
 =?us-ascii?Q?uv7d5qRzf6H1sXi7nyMWLepTg5eYXKbpE/9h4f5SXO6/25+6TGyzDSa8knt7?=
 =?us-ascii?Q?Rm9flEylnw3kBtVvBEY/817FMrW8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ixnYgZUGlw3eAcgIXBMJMarzExISbwtvVXdHcjF6pkRDA8WPMzXWspOtIcsb?=
 =?us-ascii?Q?a01mwEg6miXFgClqfkpbUHQk8qTF1w96jlrkgH4+KU/M0OOalH0EpBLg1To2?=
 =?us-ascii?Q?QWUgs01WOY/0ZRM5CJPtjA6SQETAGov+fqdIH9uVguq2ITMA/KVkAMJjIOoY?=
 =?us-ascii?Q?laHWdmoljRsLWZ/PtXj5Tf/d5XzMpiYvRhnWlhsE/yCzAS/3E6GEPgXbhg2D?=
 =?us-ascii?Q?zgD6oxi2XG0ockwDnsoqzVqdBbUuR+DtOqa6pyyQN8IJlM/iEjhXggUXnqHs?=
 =?us-ascii?Q?FqTdgpOZNQiUOnl+B64/5UTWByq7Cftm0vTUYeUC3bBZ0Ya3ToTsv2be1ejf?=
 =?us-ascii?Q?CAK52bkLAGLh2eaoRNgQC4JQkQc4v3dlqQJ2bH9erkCNLhC1QY5WO5pky++N?=
 =?us-ascii?Q?cugsS24QTi0u3I/jqQfUXsOc07zWudBoAIgKz2yb71i+QMvBOVVEsEAUsPID?=
 =?us-ascii?Q?flTe9qWL8x88TvNf85qTdvgZteKxhU7ASv8gz65mr3VWBQmifFu71xu9FJNl?=
 =?us-ascii?Q?PDXoX0271xKGN+0l1m3k9vhEKE36r/9P3SFupjn3X9WeJWyoCG2fSkl/Zvp7?=
 =?us-ascii?Q?lxO9tGxVkNs0/w2wup9ShnufI7ZI75eD1T53tEh5arS0klmvUVFcJ9TQY8dn?=
 =?us-ascii?Q?FVi+FTrG1dKi6t9iJT/nS0oixrv4zcaTfCz0kYD8otiGJEiSrgyto76Ss+pi?=
 =?us-ascii?Q?eNaq55nmkzeILg+/ARQIWaC2loRfVc5EqWp/zHotsk27bvKPCRIhKrgg/+QR?=
 =?us-ascii?Q?jc+lA8/N14rP3nbT+O5TY6URihwNsvb+zEsKrgWcyr7WkGEOa7TaegTkMm7q?=
 =?us-ascii?Q?RDa8v93TRzAcDKCcCKInskWsyXRfEQFxAYWsFV5wpXxWbeFRGID6H4nUPmSs?=
 =?us-ascii?Q?0I8s7PTM8Cyw7/m0ikeiT85+LZ5c+jcbGt6ca04gmrLI1q0QS40+JpXXeEIb?=
 =?us-ascii?Q?LSMbtL2CZhy0Oox31vDxCkOaL8IlHxHhwlBNU3l+k9eNb8SbQZTqzz3EZvH/?=
 =?us-ascii?Q?N5ePuFakZOD4vuTBSHZQZAbucc85dMi6QxfvYTMLhngvcX4q2nTkg4TyIP+H?=
 =?us-ascii?Q?QBEOVH8T9NNk+YCAvxSfyrmuz6GCYV3m50/PEFZiNsJXRtkaUMZjbZ9KTDIp?=
 =?us-ascii?Q?fX9GcaNwq56GXxB/BVCcQ1nOfRPWMasrbBByVnrpsPwpzb4WkRMdpfReAMir?=
 =?us-ascii?Q?IQiakqqvzM6tp8dQ75HcB86uazIVLua5WQ3wldiPho9zpML4egUEAdAbKfYF?=
 =?us-ascii?Q?VqkqSB5XHqNCRIqBSkFQPOyrfD4zfMHi+AWp/uqr3s5nDJRW738fzJWvPEtv?=
 =?us-ascii?Q?mxyQ1Wj/v+HoWE/kXMuTQ3VH/VtoT9n7hyq9Vr/pRoiU8HtNuFZhAxpBW4j4?=
 =?us-ascii?Q?dFJeRR8LMPtgVCSDCyzzDJ2w/N8pfJsGT3JxrVYfndqp2uPLvS2a/YjsEKiN?=
 =?us-ascii?Q?t4CwlxcId+Hx9SzqTyn+/xGIafKLwBp/dLKG/HObPkE1uRIjrziNI9UnGob0?=
 =?us-ascii?Q?pxU28hrCwpAfrhWYzdTn469nffIjl2RTGqk2NKRfxq2dn9LqosY+KUSLoT20?=
 =?us-ascii?Q?M7g+f95bGndOlJeBmXhwaRiFrz7cGNbTgs6EJjzN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ec3027f-2c8b-4eb4-b486-08dd4fd05b43
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 03:57:26.1705
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DhJtABB/6USBLgYeI935XzYGRloguVxaUrOOqxycqdPvyNL99fH/2Q260OKpOfbUfPmq7/qbbU8n2gEYJ21ShQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7593

From: Dan Williams <dan.j.williams@intel.com>

The dcssblk driver has long needed special case supoprt to enable
limited dax operation, so called CONFIG_FS_DAX_LIMITED. This mode
works around the incomplete support for ZONE_DEVICE on s390 by forgoing
the ability of dax-mapped pages to support GUP.

Now, pending cleanups to fsdax that fix its reference counting [1] depend on
the ability of all dax drivers to supply ZONE_DEVICE pages.

To allow that work to move forward, dax support needs to be paused for
dcssblk until ZONE_DEVICE support arrives. That work has been known for
a few years [2], and the removal of "pte_devmap" requirements [3] makes the
conversion easier.

For now, place the support behind CONFIG_BROKEN, and remove PFN_SPECIAL
(dcssblk was the only user).

Link: http://lore.kernel.org/cover.9f0e45d52f5cff58807831b6b867084d0b14b61c.1725941415.git-series.apopple@nvidia.com [1]
Link: http://lore.kernel.org/20210820210318.187742e8@thinkpad/ [2]
Link: http://lore.kernel.org/4511465a4f8429f45e2ac70d2e65dc5e1df1eb47.1725941415.git-series.apopple@nvidia.com [3]
Reviewed-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Tested-by: Alexander Gordeev <agordeev@linux.ibm.com>
Acked-by: David Hildenbrand <david@redhat.com>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: Jan Kara <jack@suse.cz>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Alistair Popple <apopple@nvidia.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 Documentation/filesystems/dax.rst |  1 -
 drivers/s390/block/Kconfig        | 12 ++++++++++--
 drivers/s390/block/dcssblk.c      | 27 +++++++++++++++++----------
 3 files changed, 27 insertions(+), 13 deletions(-)

diff --git a/Documentation/filesystems/dax.rst b/Documentation/filesystems/dax.rst
index 719e90f..08dd5e2 100644
--- a/Documentation/filesystems/dax.rst
+++ b/Documentation/filesystems/dax.rst
@@ -207,7 +207,6 @@ implement direct_access.
 
 These block devices may be used for inspiration:
 - brd: RAM backed block device driver
-- dcssblk: s390 dcss block device driver
 - pmem: NVDIMM persistent memory driver
 
 
diff --git a/drivers/s390/block/Kconfig b/drivers/s390/block/Kconfig
index e3710a7..4bfe469 100644
--- a/drivers/s390/block/Kconfig
+++ b/drivers/s390/block/Kconfig
@@ -4,13 +4,21 @@ comment "S/390 block device drivers"
 
 config DCSSBLK
 	def_tristate m
-	select FS_DAX_LIMITED
-	select DAX
 	prompt "DCSSBLK support"
 	depends on S390 && BLOCK
 	help
 	  Support for dcss block device
 
+config DCSSBLK_DAX
+	def_bool y
+	depends on DCSSBLK
+	# requires S390 ZONE_DEVICE support
+	depends on BROKEN
+	select DAX
+	prompt "DCSSBLK DAX support"
+	help
+	  Enable DAX operation for the dcss block device
+
 config DASD
 	def_tristate y
 	prompt "Support for DASD devices"
diff --git a/drivers/s390/block/dcssblk.c b/drivers/s390/block/dcssblk.c
index 0f14d27..7248e54 100644
--- a/drivers/s390/block/dcssblk.c
+++ b/drivers/s390/block/dcssblk.c
@@ -534,6 +534,21 @@ static const struct attribute_group *dcssblk_dev_attr_groups[] = {
 	NULL,
 };
 
+static int dcssblk_setup_dax(struct dcssblk_dev_info *dev_info)
+{
+	struct dax_device *dax_dev;
+
+	if (!IS_ENABLED(CONFIG_DCSSBLK_DAX))
+		return 0;
+
+	dax_dev = alloc_dax(dev_info, &dcssblk_dax_ops);
+	if (IS_ERR(dax_dev))
+		return PTR_ERR(dax_dev);
+	set_dax_synchronous(dax_dev);
+	dev_info->dax_dev = dax_dev;
+	return dax_add_host(dev_info->dax_dev, dev_info->gd);
+}
+
 /*
  * device attribute for adding devices
  */
@@ -547,7 +562,6 @@ dcssblk_add_store(struct device *dev, struct device_attribute *attr, const char 
 	int rc, i, j, num_of_segments;
 	struct dcssblk_dev_info *dev_info;
 	struct segment_info *seg_info, *temp;
-	struct dax_device *dax_dev;
 	char *local_buf;
 	unsigned long seg_byte_size;
 
@@ -674,14 +688,7 @@ dcssblk_add_store(struct device *dev, struct device_attribute *attr, const char 
 	if (rc)
 		goto put_dev;
 
-	dax_dev = alloc_dax(dev_info, &dcssblk_dax_ops);
-	if (IS_ERR(dax_dev)) {
-		rc = PTR_ERR(dax_dev);
-		goto put_dev;
-	}
-	set_dax_synchronous(dax_dev);
-	dev_info->dax_dev = dax_dev;
-	rc = dax_add_host(dev_info->dax_dev, dev_info->gd);
+	rc = dcssblk_setup_dax(dev_info);
 	if (rc)
 		goto out_dax;
 
@@ -917,7 +924,7 @@ __dcssblk_direct_access(struct dcssblk_dev_info *dev_info, pgoff_t pgoff,
 		*kaddr = __va(dev_info->start + offset);
 	if (pfn)
 		*pfn = __pfn_to_pfn_t(PFN_DOWN(dev_info->start + offset),
-				PFN_DEV|PFN_SPECIAL);
+				      PFN_DEV);
 
 	return (dev_sz - offset) / PAGE_SIZE;
 }
-- 
git-series 0.9.1

