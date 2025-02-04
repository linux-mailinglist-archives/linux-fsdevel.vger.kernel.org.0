Return-Path: <linux-fsdevel+bounces-40835-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8534AA27E9C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 23:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10B97166E06
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 22:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F1B22256F;
	Tue,  4 Feb 2025 22:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="maS3nbP6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45BD2221DAE;
	Tue,  4 Feb 2025 22:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738709346; cv=fail; b=RgGhuNromeXIyI/AMd+8BqPmKejpuPmB5C8zm+hJvpbJ9Yxi7ZKwweql8Nur6vDHgPu4cG86Mv1tz+F5FuazR//hDqSLAyZJfYEJC14fCFcTplPTckT3ikUO9OPpM+S/XEOSXApjJ5UFE9nPaUApija6CCLjYSc35gZbG6n20AE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738709346; c=relaxed/simple;
	bh=CwyrdwK1ZXkInedOlmoMX4apu+QfXivI1xUsaehEV2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J25EPZ1zeRjzN6rAD2wSeyRuGJWZG+h9VCtaGk6fK/ZcchxkpHmJc8U5GYwOPYYzcUZGGfEjWqcWguh4CfFC+Wd+tRfzTXDm2IQ0uVB/ztLcqLqf0CY0p5CvyubugGoNbEAvfadG2CMSSAui4Pc8pWEg9H81wYow45gZt83WZLU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=maS3nbP6; arc=fail smtp.client-ip=40.107.237.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mmDZXJ6yKvggFZ+WJnjh0dOymC8/L9JHtXDBU2EGOU5EGvvZQXZ8fbEK+eeWaKfVi7ubV9DC6DVWnUkpoLBHsSFGXmBIknTv3k3EzDR16+FRIurPitn702JaaD4uBuDx5avY4LvpLI+3/K3g7CqdJqdlMINJR/njkWxx0PKMpnq/R8wLQBOPffwNNro2IQ55Mof/7osMs5txRztf6UkAjeQ3G1QLqsKGIqEHm5JhH/+0SeJvC67LRZ1UffnEggMOpGUz4Tn0+XxIjV58zwxIAFeEo9cYVXJpqsd2KSrHTrTP6nunfXRZDXKRqwSH1E9pHx/m5xWX62v9Fm9d5ymjhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nsZoUh+nyFEoPubBz3cIx2eZnKCFotac/GnzP3+94mg=;
 b=OAbA3JjvWlu39W+9DXroavWLq2wOe+zDWGZ/OJNWbMer6sKRa/HqSDjoBfxWaXc9RLi/8OtDydZLsuH1ycmZxTO9KHgRx+/RMKwXWzC77XJgYZabwDp4qmWy9rZia3TjJgvXsVendrE2P7p0cdtlyIqxT7FT0xMxnfAyVkppIyDp0YSjIGOxVTljGLse1kNGONvlJ/Kix5BQKdQlHy20ykVAk2zt1oAvwSgCbeopsNO2xEOGThht9OHvszxHkJS6Ka7iz4uj+JhbqC3RTdvP9TwpHuIH3kAwnZ1ph0SGmk3IussCmqKRi7VK4eDu4dy6KGEYaXdbSqMx74VXZGFFSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nsZoUh+nyFEoPubBz3cIx2eZnKCFotac/GnzP3+94mg=;
 b=maS3nbP6gTcmWBkwsj4Dd5VD0lwS8d0Ssae4I8WymRSNJl0cNcHSSB3o2j3x/5Ju+HNNDqUpLQ1u4po8h9MB9tVHocq+WUEARx+4jgwEfvagI4uYrowG0KPVu6N/D+vUNgof7Lvefo5xhBDwtHEuept45HceP9+YNDRxmgI/XuzMiMM73YkomAr1UoeJ7etCPYucCEe/zdXSjvDOBvok7UR1XQUyrH97pIx4ChDUlp2P5/L3D4WfVukZypkDHnW/qkW/GTxdhIDC7IkKuyEumaiD+XggtSfbQn2DhyKqPA6XQSY45cSvrkieWPkCV0MhcMD2P9zJBztAXtDUplG0GQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 IA1PR12MB8537.namprd12.prod.outlook.com (2603:10b6:208:453::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.22; Tue, 4 Feb
 2025 22:49:01 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%7]) with mapi id 15.20.8398.025; Tue, 4 Feb 2025
 22:49:01 +0000
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
Subject: [PATCH v7 05/20] fs/dax: Create a common implementation to break DAX layouts
Date: Wed,  5 Feb 2025 09:48:02 +1100
Message-ID: <28fcec91d5a764aa58ce897cc6739a4bebdf7840.1738709036.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.472dfc700f28c65ecad7591096a1dc7878ff6172.1738709036.git-series.apopple@nvidia.com>
References: <cover.472dfc700f28c65ecad7591096a1dc7878ff6172.1738709036.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5PR01CA0128.ausprd01.prod.outlook.com
 (2603:10c6:10:246::26) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|IA1PR12MB8537:EE_
X-MS-Office365-Filtering-Correlation-Id: 567e4890-c7ff-410a-0867-08dd456e1dde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1VnO0i3hY5jnMKOB0SLDgK1PLhR6Ktyof8iBTamMRhAs2IjlSp67MEGp6s2f?=
 =?us-ascii?Q?cFVJ82BLC3dD61227ex4TgEiF2oMIH2UOHr0hm37tvDgqb+irHOT20WctZCv?=
 =?us-ascii?Q?+lLUHyA7vkAmE8SMBaGL2PiSgCFdGV9+8P+4o3p7s5GOclbXkRUvSkg+XrHM?=
 =?us-ascii?Q?c/V4zM6J6zgV3rDjXGpiEj+te9XxEBrI5qa38V/yRNttTHCJ0oOljDvGvgdd?=
 =?us-ascii?Q?W/vXERDyHfzub7bYsYUPyYyLwvx4xZfawkCI6EajHdEODU5i0/sCyYS9sU7a?=
 =?us-ascii?Q?2NZe/PgIdAZmF5UkJXGMytSQxEBVlCskC6v7BGR1n0Kg0Wp/4V7UfYIs5jkA?=
 =?us-ascii?Q?DybhRS54WWyfybmzgmLERl11+yKWCPOnxKgaTlQp6bJ4cfjaJYqU1snPdLre?=
 =?us-ascii?Q?wuAzG61f+uXqXyfGdWTttvuKFBQ0r7s3RG6Sc5DFNSAN2DkS22IbYw9kzhZJ?=
 =?us-ascii?Q?P/OUivuEzRDZCl33F/oSQvoeSNcbDlgiGATYseWXFA1VSoEPEYzeKoxRxfLY?=
 =?us-ascii?Q?Qado4y/7D8SIbbNLQ8Wg7FLTbOh4DJfb0sNkD0ZOyOLOOG4dNtB7LJvc/g5G?=
 =?us-ascii?Q?UTHs9RDivJBrKJfDClF2eCnixkeRL15YHqctOqMqdb8K7eRWdlqjDNSENs1x?=
 =?us-ascii?Q?BCx7LLOTYiJL3sIh9lZKkceLT4ZNbqjk927xynP9IBpX0n/ueL0qFcq8UL7A?=
 =?us-ascii?Q?dzOVq3iSMAKKg/E50nWX0Wp5sovbK9iPSv/uvh7CKkBdbXVDWWFOpjxJmtm9?=
 =?us-ascii?Q?YXj+Ywyq4J+lDj29xfeBE0StbuoK+yZ6bvuIZWJeZ4Yn3ohA5DeM7F9jpumZ?=
 =?us-ascii?Q?49Zm9DanWz+2Q16QaUMjlYrioVFowlkOXqATcp+WCM0xYSF4o3OdUCcF9fhp?=
 =?us-ascii?Q?Q4EselVzPWz4Y9WJBYIymPmBEMPeK/KhzvT8poAvoGjn72bRBU6dK3mxxtpq?=
 =?us-ascii?Q?jQVSowGpKQTJ0HkA+lLah0dNuot20OP/QAj9nHHp1+oQNoVQXTLljkiT/lG3?=
 =?us-ascii?Q?drqRXGowbcTdw3plnZr27mvN5Vzvp3HMlsieLw7HD90sQuvinmjxwdmJKJ76?=
 =?us-ascii?Q?EXRCL/2UPecJ4/fO2S4nYVISIttDQv5ea7XA81mY+NOL8GEmYLswDsEouhqj?=
 =?us-ascii?Q?HHqA+VIlbt1OzVzZ9j/jJVLPwiaEOPy7TuC7uxEZwg+rzDPsbC/bIvQrfjDR?=
 =?us-ascii?Q?VNTeLTMo0puwMwPeJgVtzIe9hgCfVZm8DQ6P5ZUjrh0XOOYdIussEonAWX8X?=
 =?us-ascii?Q?KErUEJV7bYJIoL4IkAucPhvOIyqpbgJsB55T7TKHsVK2RcuxTPhVK6+yfRho?=
 =?us-ascii?Q?IkrMmDMmY8XWAH1QW0IXLm8IJI7ywyIQsVzb56ia83onYVZ5GYjGlVAeih6t?=
 =?us-ascii?Q?NNdBw4dqFuX2B0sMHu1NsdSkWiS0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FlwM8GYVpHLejANQsT5jn/BXEgGi6n1nZcFKg6LxtIEywg9TjVbIgFEYLAFA?=
 =?us-ascii?Q?Hb3zVd4YaH9P5w9ma4551WyqnZB0C+Fk//HQ72Zyu0AZNJ715rF8m3UK7dBH?=
 =?us-ascii?Q?9VRMDvDKny1bejEzDJX4www/63e0oUhS3W3+NGBM/3lT3o9s20U6bTWeuyTy?=
 =?us-ascii?Q?TXbla5wXZ107WGcPCiXXNwa375U8JQV5o2h9GEoB3vcPM9aXfHYBR636UB9s?=
 =?us-ascii?Q?8sceaM/0RI7MToEQGP+wGn54hoiIuNrNzypzeLZ5zjDCte5RFGuYRZ8eczWY?=
 =?us-ascii?Q?swjyKYPWxA6kslQUbsEB0h+MDifZTJq+PJS0bjL3VgTAhHlUEcyBFZOr7a5m?=
 =?us-ascii?Q?QaCgcpgGXe9NvjpNrBTJ5FoeH+5qa/46QgOLzqJHpVXi506E3S9oK0vWXpgn?=
 =?us-ascii?Q?pQ3xPrdwQC4m81/PNrC0bFBRghFRXuST1Dq3+6LH5qNad4mxDS4/NbiK+S+c?=
 =?us-ascii?Q?MLWvN+h5ljaOH7L7BdbY9Jx9ZiEKWKEWrSop8GOSqFIkKRBFyIyuepv1Q75Z?=
 =?us-ascii?Q?2EmVTgKIjHnwzkzlrx7+AQVBgQKHpXHo91+Psn/Ia691hI7ev8yANm6EmJaf?=
 =?us-ascii?Q?q3d17kFC3rzlhw4YUPN4bpka2MyJ6Q4mXa+Dv86PpIbR7bl/zhbN8Wku7LUO?=
 =?us-ascii?Q?oKJnrjJGgWHNcjnkrc+0GkCrfcaphTSTsgSL74PxJkZbehG+0xhvmAhS1mzb?=
 =?us-ascii?Q?wJBL2GDqwMZwqE78/mfg9o53X4NZj3R/JrBjKUHG+UizKMEhVWyBVabmXZ6r?=
 =?us-ascii?Q?nPkS8lC6vUhltpqD+SmZH6IVDTOuBQp6z+8yEHyHW3nLrB2X2jDem1Q+Iuzi?=
 =?us-ascii?Q?t4IFVTE6awt3FU6gWlsm6PcWiNArri5YyC88JJVXHjOcMbngN+W72bVSGWsX?=
 =?us-ascii?Q?6LGQg44vHjdJ6QXcC/eBvDsYJAIieYTqxCHSY3XOxmmUnXQG00v6HjNL/LRi?=
 =?us-ascii?Q?FvconAYnd8YGT77eY90xr9xXmaof8GK1F5YpW/iGF1XYTezadfxM93kgCiGk?=
 =?us-ascii?Q?P9DWL80IGTYHECcZ8AA6eQgJ1qtrcYT+EzWWvQ86lxKMrfl1RkMnWrAVehRM?=
 =?us-ascii?Q?QSvjRo3Y0RmcVvUSSc4ttWdu1FNGVu/a3aPAryl0lmgWQ5qmTwMNjJjOWsrE?=
 =?us-ascii?Q?TJMw50ahxbAD/8XZjGm7V+clBQKbIHf/reNC8RHHudFn4tmX//Zrmjzbp4Pb?=
 =?us-ascii?Q?EK3+DhrFcrxPbaxuWLjWUcF+vDKaf1LJZGRrOBsBj2cq3XXfcSu8R6G+cjnl?=
 =?us-ascii?Q?EEkqyKO2rHs4bAz6+q6BelhbaDFeBXNpezVwVGPvSBpTPFPD7xN7t0o5f7rV?=
 =?us-ascii?Q?CWBHyZjjLPDWzVDGko6vE9FmIKlY9S6YVZ7Ty51f9RFaeJeoRLXH4U7oTeK6?=
 =?us-ascii?Q?xZBIQIkgrj931Ppx+Q7nJnIfXfzPjdEu6dInQCrAidG4Vwu2SDDSx7iC7kQH?=
 =?us-ascii?Q?l5LdosUzcIpRcaQlu0Ettz5wQ/WXRlThs/jAnXe0fVmv9BdxXIfL3Zb5ECkE?=
 =?us-ascii?Q?PEg36q8GAQHkGJQSW9Y9PhzzxpOjT93uxwUiAsEYAQ1glGHpVopHOEOny20H?=
 =?us-ascii?Q?xf/sWBSP6j4beR0kp2s3WrnkDkABdbj3+olJsREX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 567e4890-c7ff-410a-0867-08dd456e1dde
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 22:49:00.9449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S5Z+MSFHIZrRWm6hkAuWy8vaCIR9WWXQciZZ9jxMdINC2tJCUiDY64K6o119IwzGhFwdgHKl0WRQFFYHSfFGwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8537

Prior to freeing a block file systems supporting FS DAX must check
that the associated pages are both unmapped from user-space and not
undergoing DMA or other access from eg. get_user_pages(). This is
achieved by unmapping the file range and scanning the FS DAX
page-cache to see if any pages within the mapping have an elevated
refcount.

This is done using two functions - dax_layout_busy_page_range() which
returns a page to wait for the refcount to become idle on. Rather than
open-code this introduce a common implementation to both unmap and
wait for the page to become idle.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>

---

Changes for v7:

 - Fix smatch warning, also reported by Dan and Darrick
 - Make sure xfs_break_layouts() can return -ERESTARTSYS, reported by
   Darrick
 - Use common definition of dax_page_is_idle()
 - Removed misplaced hunk changing madvise
 - Renamed dax_break_mapping() to dax_break_layout() suggested by Dan
 - Fix now unused variables in ext4

Changes for v5:

 - Don't wait for idle pages on non-DAX mappings

Changes for v4:

 - Fixed some build breakage due to missing symbol exports reported by
   John Hubbard (thanks!).
---
 fs/dax.c            | 33 +++++++++++++++++++++++++++++++++
 fs/ext4/inode.c     | 13 +------------
 fs/fuse/dax.c       | 27 +++------------------------
 fs/xfs/xfs_inode.c  | 26 +++++++-------------------
 fs/xfs/xfs_inode.h  |  2 +-
 include/linux/dax.h | 23 ++++++++++++++++++-----
 6 files changed, 63 insertions(+), 61 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index d010c10..710b280 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -845,6 +845,39 @@ int dax_delete_mapping_entry(struct address_space *mapping, pgoff_t index)
 	return ret;
 }
 
+static int wait_page_idle(struct page *page,
+			void (cb)(struct inode *),
+			struct inode *inode)
+{
+	return ___wait_var_event(page, dax_page_is_idle(page),
+				TASK_INTERRUPTIBLE, 0, 0, cb(inode));
+}
+
+/*
+ * Unmaps the inode and waits for any DMA to complete prior to deleting the
+ * DAX mapping entries for the range.
+ */
+int dax_break_layout(struct inode *inode, loff_t start, loff_t end,
+		void (cb)(struct inode *))
+{
+	struct page *page;
+	int error = 0;
+
+	if (!dax_mapping(inode->i_mapping))
+		return 0;
+
+	do {
+		page = dax_layout_busy_page_range(inode->i_mapping, start, end);
+		if (!page)
+			break;
+
+		error = wait_page_idle(page, cb, inode);
+	} while (error == 0);
+
+	return error;
+}
+EXPORT_SYMBOL_GPL(dax_break_layout);
+
 /*
  * Invalidate DAX entry if it is clean.
  */
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index cc1acb1..2342bac 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3911,21 +3911,10 @@ static void ext4_wait_dax_page(struct inode *inode)
 
 int ext4_break_layouts(struct inode *inode)
 {
-	struct page *page;
-	int error;
-
 	if (WARN_ON_ONCE(!rwsem_is_locked(&inode->i_mapping->invalidate_lock)))
 		return -EINVAL;
 
-	do {
-		page = dax_layout_busy_page(inode->i_mapping);
-		if (!page)
-			return 0;
-
-		error = dax_wait_page_idle(page, ext4_wait_dax_page, inode);
-	} while (error == 0);
-
-	return error;
+	return dax_break_layout_inode(inode, ext4_wait_dax_page);
 }
 
 /*
diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
index bf6faa3..0502bf3 100644
--- a/fs/fuse/dax.c
+++ b/fs/fuse/dax.c
@@ -666,33 +666,12 @@ static void fuse_wait_dax_page(struct inode *inode)
 	filemap_invalidate_lock(inode->i_mapping);
 }
 
-/* Should be called with mapping->invalidate_lock held exclusively */
-static int __fuse_dax_break_layouts(struct inode *inode, bool *retry,
-				    loff_t start, loff_t end)
-{
-	struct page *page;
-
-	page = dax_layout_busy_page_range(inode->i_mapping, start, end);
-	if (!page)
-		return 0;
-
-	*retry = true;
-	return dax_wait_page_idle(page, fuse_wait_dax_page, inode);
-}
-
+/* Should be called with mapping->invalidate_lock held exclusively. */
 int fuse_dax_break_layouts(struct inode *inode, u64 dmap_start,
 				  u64 dmap_end)
 {
-	bool	retry;
-	int	ret;
-
-	do {
-		retry = false;
-		ret = __fuse_dax_break_layouts(inode, &retry, dmap_start,
-					       dmap_end);
-	} while (ret == 0 && retry);
-
-	return ret;
+	return dax_break_layout(inode, dmap_start, dmap_end,
+				fuse_wait_dax_page);
 }
 
 ssize_t fuse_dax_read_iter(struct kiocb *iocb, struct iov_iter *to)
diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index a457c13..62c2ae3 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -2732,21 +2732,17 @@ xfs_mmaplock_two_inodes_and_break_dax_layout(
 	struct xfs_inode	*ip2)
 {
 	int			error;
-	bool			retry;
 	struct page		*page;
 
 	if (ip1->i_ino > ip2->i_ino)
 		swap(ip1, ip2);
 
 again:
-	retry = false;
 	/* Lock the first inode */
 	xfs_ilock(ip1, XFS_MMAPLOCK_EXCL);
-	error = xfs_break_dax_layouts(VFS_I(ip1), &retry);
-	if (error || retry) {
+	error = xfs_break_dax_layouts(VFS_I(ip1));
+	if (error) {
 		xfs_iunlock(ip1, XFS_MMAPLOCK_EXCL);
-		if (error == 0 && retry)
-			goto again;
 		return error;
 	}
 
@@ -2761,7 +2757,7 @@ xfs_mmaplock_two_inodes_and_break_dax_layout(
 	 * for this nested lock case.
 	 */
 	page = dax_layout_busy_page(VFS_I(ip2)->i_mapping);
-	if (page && page_ref_count(page) != 1) {
+	if (!dax_page_is_idle(page)) {
 		xfs_iunlock(ip2, XFS_MMAPLOCK_EXCL);
 		xfs_iunlock(ip1, XFS_MMAPLOCK_EXCL);
 		goto again;
@@ -3005,19 +3001,11 @@ xfs_wait_dax_page(
 
 int
 xfs_break_dax_layouts(
-	struct inode		*inode,
-	bool			*retry)
+	struct inode		*inode)
 {
-	struct page		*page;
-
 	xfs_assert_ilocked(XFS_I(inode), XFS_MMAPLOCK_EXCL);
 
-	page = dax_layout_busy_page(inode->i_mapping);
-	if (!page)
-		return 0;
-
-	*retry = true;
-	return dax_wait_page_idle(page, xfs_wait_dax_page, inode);
+	return dax_break_layout_inode(inode, xfs_wait_dax_page);
 }
 
 int
@@ -3035,8 +3023,8 @@ xfs_break_layouts(
 		retry = false;
 		switch (reason) {
 		case BREAK_UNMAP:
-			error = xfs_break_dax_layouts(inode, &retry);
-			if (error || retry)
+			error = xfs_break_dax_layouts(inode);
+			if (error)
 				break;
 			fallthrough;
 		case BREAK_WRITE:
diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
index c08093a..123dfa9 100644
--- a/fs/xfs/xfs_inode.h
+++ b/fs/xfs/xfs_inode.h
@@ -603,7 +603,7 @@ xfs_itruncate_extents(
 	return xfs_itruncate_extents_flags(tpp, ip, whichfork, new_size, 0);
 }
 
-int	xfs_break_dax_layouts(struct inode *inode, bool *retry);
+int	xfs_break_dax_layouts(struct inode *inode);
 int	xfs_break_layouts(struct inode *inode, uint *iolock,
 		enum layout_break_reason reason);
 
diff --git a/include/linux/dax.h b/include/linux/dax.h
index 9b1ce98..a6b277f 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -207,12 +207,9 @@ int dax_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
 int dax_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
 		const struct iomap_ops *ops);
 
-static inline int dax_wait_page_idle(struct page *page,
-				void (cb)(struct inode *),
-				struct inode *inode)
+static inline bool dax_page_is_idle(struct page *page)
 {
-	return ___wait_var_event(page, page_ref_count(page) == 1,
-				TASK_INTERRUPTIBLE, 0, 0, cb(inode));
+	return page && page_ref_count(page) == 1;
 }
 
 #if IS_ENABLED(CONFIG_DAX)
@@ -228,6 +225,15 @@ static inline void dax_read_unlock(int id)
 {
 }
 #endif /* CONFIG_DAX */
+
+#if !IS_ENABLED(CONFIG_FS_DAX)
+static inline int __must_check dax_break_layout(struct inode *inode,
+			    loff_t start, loff_t end, void (cb)(struct inode *))
+{
+	return 0;
+}
+#endif
+
 bool dax_alive(struct dax_device *dax_dev);
 void *dax_get_private(struct dax_device *dax_dev);
 long dax_direct_access(struct dax_device *dax_dev, pgoff_t pgoff, long nr_pages,
@@ -251,6 +257,13 @@ vm_fault_t dax_finish_sync_fault(struct vm_fault *vmf,
 int dax_delete_mapping_entry(struct address_space *mapping, pgoff_t index);
 int dax_invalidate_mapping_entry_sync(struct address_space *mapping,
 				      pgoff_t index);
+int __must_check dax_break_layout(struct inode *inode, loff_t start,
+				loff_t end, void (cb)(struct inode *));
+static inline int __must_check dax_break_layout_inode(struct inode *inode,
+						void (cb)(struct inode *))
+{
+	return dax_break_layout(inode, 0, LLONG_MAX, cb);
+}
 int dax_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
 				  struct inode *dest, loff_t destoff,
 				  loff_t len, bool *is_same,
-- 
git-series 0.9.1

