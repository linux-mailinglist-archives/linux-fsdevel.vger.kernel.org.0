Return-Path: <linux-fsdevel+bounces-30223-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5501C987F36
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 09:16:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F0B0283C75
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 07:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C233218733B;
	Fri, 27 Sep 2024 07:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bS4sqM7v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3817F165EED;
	Fri, 27 Sep 2024 07:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727421365; cv=fail; b=HiB9QWAaOM0ng4ftJXAGz3X9LjJ06S+j2feuI+4k9S3SxV6WMUTAKggprLpG8hNGnIJP2LN5lCtOq22ziG2WPevHBoJt4BpdxTKvVC7KX2SYTv+r6EFlU/Qnx6JJcTl3oKxakKsVp8lVX44vo6x5Au+GNL6nNU+uwzoPCGBpgKM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727421365; c=relaxed/simple;
	bh=PyI5b7KSNKuqSdWvAcaxwpF1PLFb+NglfnHVqmyIGs8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TAjmI6j9e6TVhkjDqmLEDgV2w8jY4lnyR5NPe24PW6C18YRfmHz0i0x1Mne25QW+HAiMDo+KdONMnNvPuTAC/ODS940pXjGU3wKBvXPck5tVpckss2jX7Yti5NAQ22/VAmucjMGeWczL/Bx7WLrCPlIQueAfSY7s0YCDS1niDyY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bS4sqM7v; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727421364; x=1758957364;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=PyI5b7KSNKuqSdWvAcaxwpF1PLFb+NglfnHVqmyIGs8=;
  b=bS4sqM7vIW1gTP97kdcWfXREGOhcjPiraXd2TenEimngV7iQq+ajtAX2
   NvexMb+5vNk1LFaWdOx4aPhBrY6IYTVaLU8c47i4bBtK11N09RREBwUPA
   T3eyBBHlqHs6B5C2yzd0RcdpwpPqAuDHppJlz7zr3G7A37YgU8JQAjU/c
   tKooX0Azz8luu7ICyfV804A6HLHCpa6SzVx0KB+xUy5eZmQbkhJ+++7f2
   E6DyUrA6vpb3MYAxSu3eW0+5NTTHIbmR01/rgwfjuZEoZNQQvJVxHv73Z
   52MCCCUmm5nD9pezblqlr4gk5VCS68a9AhNRiWit1MggU6a2zHcdwVmvl
   Q==;
X-CSE-ConnectionGUID: hSViL9GFTwyatSKQ4IWxHQ==
X-CSE-MsgGUID: 6A8jU76/Qr6t+9rU+jfIcQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11207"; a="26721411"
X-IronPort-AV: E=Sophos;i="6.11,157,1725346800"; 
   d="scan'208";a="26721411"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2024 00:16:03 -0700
X-CSE-ConnectionGUID: vdj0NRl0T5aDV3nn3vc1kA==
X-CSE-MsgGUID: T8EHBWs8SoqL9vKRY9FMzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,157,1725346800"; 
   d="scan'208";a="72754628"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Sep 2024 00:16:02 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 27 Sep 2024 00:16:01 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 27 Sep 2024 00:16:00 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 27 Sep 2024 00:16:00 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 27 Sep 2024 00:16:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aIXhLVyFoCkRxmLJjX0ph3x1d1X4zvnIch9SdwJMJYntgfPNF7WLuqPxlAup7sEkvIdCboM/Tpa4RdGF0kfOFiBPw5OPapSlcXDP0xoOJjuT9yjFQ+US1OAppftGfZwUgSFQmx0w0iePUVkpPk07Exq0uSu4EhiFakMCfyF7zTJjsubViheQbhVDmKW2+ByhmtbvzTk2yClmDGtaMFymOoka5uE7RvuaUtZTyFn4w7Dw2qs4wwx+BU4ifH5GA8NehascWS2HFqOOKEIrwzY5IWJJeniGlQElguptpQxqFuPTzgiDqmUJt6FU9fJFJFlZbA9H50hvp6XqIJtXkSCIPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wvzJfMTjCpLgevUw69jM60+GEUa0heiOcgtJnTKGihU=;
 b=JyJ21IiePzA08IIPa+AuQqAxvA+uDKL81JLfs0K7n8W2m4fH9GB8tzLVLNNrRfhNMrKCOstVeiSt9D3XhyhdicZpZLeNHJhls78oK39yQ/aRmXvlpEK/HEQvyCs46dtt8VvmxmAIEDv5QXfm/8O2Fg6iR9Iav0onDI6IqJbZ9O/L8SAdbz+pKRR7OMZoocTabL3LcTN/PghM3DWyeD4yn9SkjgLufv2ZETezIIh1jLE+/rGkCNaQmF3FqxiswYacfAAgeH6fEbJrVU+Fwbc9CuwzHb4Do9uEqKfheqEQpbRIaB4vHvfXWSbKvB+V3TX72TDwmp12f8g1koPsN09/lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW6PR11MB8338.namprd11.prod.outlook.com (2603:10b6:303:247::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Fri, 27 Sep
 2024 07:15:53 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%7]) with mapi id 15.20.7982.022; Fri, 27 Sep 2024
 07:15:53 +0000
Date: Fri, 27 Sep 2024 00:15:49 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Alistair Popple <apopple@nvidia.com>, <dan.j.williams@intel.com>,
	<linux-mm@kvack.org>
CC: Alistair Popple <apopple@nvidia.com>, <vishal.l.verma@intel.com>,
	<dave.jiang@intel.com>, <logang@deltatee.com>, <bhelgaas@google.com>,
	<jack@suse.cz>, <jgg@ziepe.ca>, <catalin.marinas@arm.com>, <will@kernel.org>,
	<mpe@ellerman.id.au>, <npiggin@gmail.com>, <dave.hansen@linux.intel.com>,
	<ira.weiny@intel.com>, <willy@infradead.org>, <djwong@kernel.org>,
	<tytso@mit.edu>, <linmiaohe@huawei.com>, <david@redhat.com>,
	<peterx@redhat.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linuxppc-dev@lists.ozlabs.org>, <nvdimm@lists.linux.dev>,
	<linux-cxl@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-ext4@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
	<jhubbard@nvidia.com>, <hch@lst.de>, <david@fromorbit.com>
Subject: Re: [PATCH 09/12] mm: Update vm_normal_page() callers to accept FS
 DAX pages
Message-ID: <66f65ba5be661_964f229415@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.9f0e45d52f5cff58807831b6b867084d0b14b61c.1725941415.git-series.apopple@nvidia.com>
 <64f1664980bed3da01b771afdfc4056825b61277.1725941415.git-series.apopple@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <64f1664980bed3da01b771afdfc4056825b61277.1725941415.git-series.apopple@nvidia.com>
X-ClientProxiedBy: MW4PR04CA0061.namprd04.prod.outlook.com
 (2603:10b6:303:6b::6) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW6PR11MB8338:EE_
X-MS-Office365-Filtering-Correlation-Id: 14b172a0-704b-4239-c6c5-08dcdec43943
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VuhzwWkiVwlcfC4jmo1eDcIpTrj9enaJtLzHxmMJLvNqUVFK3fjAC0QJAkl2?=
 =?us-ascii?Q?9BmRtaqDEpUqMEnYchQNdIvpag1sCztqHBbWEVrSpOBiU0Q94YoNlGqbos/Y?=
 =?us-ascii?Q?vAk+GYaLwlEF3Tbn53uEAYWMSuiIMnB9KoGS7IrXX677Wjob8t6zbTChTJYY?=
 =?us-ascii?Q?VjHnmH5xJ8OOsAk07MRCacTewcScSEfPLcAhkhcFvuSozI5HAHuphz3K0oj3?=
 =?us-ascii?Q?59WpoLSpus8+vkRnCBoutgh06dz/aBJ3W1p4OzRc4IfGQ9vP4TQhu4VRROq9?=
 =?us-ascii?Q?CZdoyehno8XYbNnOWyrkGxnmrdgYN1/7uFQTcYbkzpHQ58RRJMpPpNza3/db?=
 =?us-ascii?Q?DGhoB83LWpiboMQCeepvpo0Maea88iW6J5S/8G1/yulFsfsoE/y+QrYXkZGp?=
 =?us-ascii?Q?GhTpGJml/OJUo1v/A690KCQ1YRDPkOT+/pJy4UAG40Tm89hm+vRY001+OS+b?=
 =?us-ascii?Q?bLcGTeQSOhUIDC82b3H14+QBasnGSqLnONrWWCw44NLX43IOkQWBWAZ3ZYnw?=
 =?us-ascii?Q?PjhCvV7r+Ch9FA5+oC3sJZL4gpGOBkkzBg4IO9qLdGXVWKcMK0m97mo7k19a?=
 =?us-ascii?Q?MDKxRBBLKZVAyi7KXkGMh8I+037BX1vXmfsr86ebcy87ErDtOpFOTdLgssr4?=
 =?us-ascii?Q?3t/fXXxlm71UEPa7qbpxs9qldDKW08BSl8QL9io/z5Q+wHJO2B+8V6MYAkv1?=
 =?us-ascii?Q?/rUJA4dznV9bHKktr8IrYGUtKdUK+H45QwmmZrrthWOt7mvW48qALyuF+AFS?=
 =?us-ascii?Q?nwe8vyUSSBgMfYKoVaWN7sR/kulob5aoax9J2CqhR/JfeHn0pTU+D7n8ayUp?=
 =?us-ascii?Q?2ElKUXHVnAh7LsNOD7HVwysIqIrqG2L3uKEtv9uUGP3y/ij8NQKXpjsSbM4o?=
 =?us-ascii?Q?L9oEqWG4CT9EbCJhmGqoYgBMqFzlYoqYRb+8yZHqQdzzNmr3fWwDrEcd2JYA?=
 =?us-ascii?Q?B2ElfE0BZQMSls9SeL2+fGXxpebgJ9S1OZoFZi/xWUkyrdMEUE5BpMf22InA?=
 =?us-ascii?Q?B6iARsEOn1YplGBRiFV20+7/rC+KP6wWbo5KLrxDVXbXpcqhTPZVyNIfnHlD?=
 =?us-ascii?Q?M/NsgIsG+wq37fcFZumBsGYG868VUKEoRD4EE0AHqWsFNku2LdoHkO5f477u?=
 =?us-ascii?Q?pz7h4FmH/SnfonPMM7W7mMMmt06/jOur85NA9DLLygzaV8j4Y8yxpEfsOd07?=
 =?us-ascii?Q?qiWxZtal/6MNWOSjr0bzeacbWhJWxvofpzHdSiuZgGY2/DRPhqiUifOXLsGv?=
 =?us-ascii?Q?qDnQBTEXwQIXuGBVQwn3vRhrmms1g6uoR3Ss/NAKdg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xpucomMBBXB31DURt7YWYV1ucyjJ0c6RrkYQySYQEr57EyQ1Bu/eZ+LEad73?=
 =?us-ascii?Q?cctUiCza8vtoxLxMSUsXM0GGttEbua5jns/xokBF4YXtpaQxfE5Rp6vLloQU?=
 =?us-ascii?Q?egEb6/lBpzDHWSpFn6bAs3bCBc4/Ljbp39YCR3XoSi+bEUFDtfXEXNvJ++/y?=
 =?us-ascii?Q?Fz0xKiVUj2WHxJd6XHMuuKfrC9phmaCPbTkLdicNtvw5rAWrZY5mHSEvlx1d?=
 =?us-ascii?Q?Bxq0OJpj4ujh4cMUEl+33XDtjkmdxrD+yw3Ry6+1v3CuEx+q3jJAlIcuGpq+?=
 =?us-ascii?Q?mlPuKjgsdDzdfBtahu/Qllcdc2QmEVoO3ZJ2+0zVa86LrQaknxeoCsnOC9Fo?=
 =?us-ascii?Q?h9NQNzXxffWkeDu/R0kDCNoKapUFMv+s9YzPiD76ZZuOUCS+r7pA7bZRq33g?=
 =?us-ascii?Q?Jdo2hGGGX3dHrpy047s2u0I9Eo8NrExTcNyGsm4SXsmkgGKSoBAXRdvye4ZJ?=
 =?us-ascii?Q?JOK1c6FY/F7cGNbzFpd4AhyfVqTh+p9nyEOhLwNxY5E7m2+S4S8VdQ0nHD/7?=
 =?us-ascii?Q?ByWEIvdLSVdIJp7E9/Gjfn8qU6SN0XDh3YPdwwYx7wdMknaC6JM2ajbYgcPl?=
 =?us-ascii?Q?9SjLrXX1ZBysqS/nYj4Sper5JWj6OOkBCW8bxBrrhOIQNfdtZnxNiTbfTmdX?=
 =?us-ascii?Q?9GPcz/QZv9psHLtEZrKiMaICuuSY3n1MRm8dhEeRaAHVFmIWv7TN6N2HVbPH?=
 =?us-ascii?Q?JFMeMkOnZhorsFGbyzzF4tB6KUDshTNPcztYsUVtCF7kMrfsxJA/OIrlznfI?=
 =?us-ascii?Q?n4CRTWRx2ev86JCi9S7jra3VIG77BfLhSkZWhJkZYVdQX65nzwZkDad2AygZ?=
 =?us-ascii?Q?/5SRqkDsFtqSDA0EulfmBC8b3P32blDGDjKYuBu9w812vBrEnXVeLm9+dkdn?=
 =?us-ascii?Q?8Ih8EVg0WP5gzNG+eVrBtiREqrq3Rb0hrPMVmKvqzeGCMwxoRnSiuuGwxfct?=
 =?us-ascii?Q?JzslzP7Qlsf2d6LkRXGjY7wnztR3aMzfrOSh5Fv1W+icf8xDGCVd/Wc7Sz6K?=
 =?us-ascii?Q?VNdr0yf2O+6dKaszVklQlIPuOj/LUgvRl7aP28c2D0snRWbtI3p3YKDiOgyu?=
 =?us-ascii?Q?Cnd80FaaSLJ7AbKmH3ccTs/VaGoSPnSMsRETtM0EptTOiDnE96ZiuDQEcLg4?=
 =?us-ascii?Q?UyccIVnnPch/H3DjaFMpRYMA33RaXUpg2+VbPqWvgNMuMKUXIVHXiq5BFwlF?=
 =?us-ascii?Q?NMJLzjm7oz0pcfy0EtLNQcg9QVle8ZvNV4KVdX8eEaNJv6Uz9Rlpe7b51u1X?=
 =?us-ascii?Q?zISnT6Y0MMG0xhOfcE10zabT2xPaMmD9mZ8KzJWSTwrmSDRZsvZGZqSeNMup?=
 =?us-ascii?Q?6VT+QrFXXlvzicQHxa6Zd0CB5IXQHGTlR7/TE8qb6HBjLrxaZk0Fh3N7e5cZ?=
 =?us-ascii?Q?OTjG7EzyOv8zVakoogdr2eGHj/M1RRsg0HwYmQmGBj4Ty4z7BExB/L0Qkznc?=
 =?us-ascii?Q?G/zPSoHX7V21tctVpkQIsOldtbWZUefuEka6ZiR6opX/8Dx2sGH+gXlyPBJk?=
 =?us-ascii?Q?Pn6XrB21lVQbvsI4IzWMX5y5d0sPYRelaOo0w06Yxg34bqR8SG2U5gp544Fm?=
 =?us-ascii?Q?L2A7TZMljxmrfl/RuPvw1qXA97qByCYdZpRX9VlSpX8MMskxxa9+M+gEP1Id?=
 =?us-ascii?Q?ng=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 14b172a0-704b-4239-c6c5-08dcdec43943
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 07:15:53.6805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dkxtra6wUGhXF4erD0PnhhxUE+qFmkrwAUIajUZ7aW1udcQ6Scic5aK/HBEMo6RlluxfvuxfpFR1xTx9S0yFG2nNoVe+JCQRETYMBXoUTp4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8338
X-OriginatorOrg: intel.com

Alistair Popple wrote:
> Currently if a PTE points to a FS DAX page vm_normal_page() will
> return NULL as these have their own special refcounting scheme. A
> future change will allow FS DAX pages to be refcounted the same as any
> other normal page.
> 
> Therefore vm_normal_page() will start returning FS DAX pages. To avoid
> any change in behaviour callers that don't expect FS DAX pages will
> need to explicitly check for this. As vm_normal_page() can already
> return ZONE_DEVICE pages most callers already include a check for any
> ZONE_DEVICE page.
> 
> However some callers don't, so add explicit checks where required.

I would expect justification for each of these conversions, and
hopefully with fsdax returning fully formed folios there is less need to
sprinkle these checks around.

At a minimum I think this patch needs to be broken up by file touched.

> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> ---
>  arch/x86/mm/pat/memtype.c |  4 +++-
>  fs/proc/task_mmu.c        | 16 ++++++++++++----
>  mm/memcontrol-v1.c        |  2 +-
>  3 files changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
> index 1fa0bf6..eb84593 100644
> --- a/arch/x86/mm/pat/memtype.c
> +++ b/arch/x86/mm/pat/memtype.c
> @@ -951,6 +951,7 @@ static void free_pfn_range(u64 paddr, unsigned long size)
>  static int follow_phys(struct vm_area_struct *vma, unsigned long *prot,
>  		resource_size_t *phys)
>  {
> +	struct folio *folio;
>  	pte_t *ptep, pte;
>  	spinlock_t *ptl;
>  
> @@ -960,7 +961,8 @@ static int follow_phys(struct vm_area_struct *vma, unsigned long *prot,
>  	pte = ptep_get(ptep);
>  
>  	/* Never return PFNs of anon folios in COW mappings. */
> -	if (vm_normal_folio(vma, vma->vm_start, pte)) {
> +	folio = vm_normal_folio(vma, vma->vm_start, pte);
> +	if (folio || (folio && !folio_is_device_dax(folio))) {

...for example, I do not immediately see why follow_phys() would need to
be careful with fsdax pages?

...but I do see why copy_page_range() (which calls follow_phys() through
track_pfn_copy()) might care. It just turns out that vma_needs_copy(),
afaics, bypasses dax MAP_SHARED mappings.

So this touch of memtype.c looks like it can be dropped.

>  		pte_unmap_unlock(ptep, ptl);
>  		return -EINVAL;
>  	}
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 5f171ad..456b010 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -816,6 +816,8 @@ static void smaps_pte_entry(pte_t *pte, unsigned long addr,
>  
>  	if (pte_present(ptent)) {
>  		page = vm_normal_page(vma, addr, ptent);
> +		if (page && is_device_dax_page(page))
> +			page = NULL;
>  		young = pte_young(ptent);
>  		dirty = pte_dirty(ptent);
>  		present = true;
> @@ -864,6 +866,8 @@ static void smaps_pmd_entry(pmd_t *pmd, unsigned long addr,
>  
>  	if (pmd_present(*pmd)) {
>  		page = vm_normal_page_pmd(vma, addr, *pmd);
> +		if (page && is_device_dax_page(page))
> +			page = NULL;
>  		present = true;
>  	} else if (unlikely(thp_migration_supported() && is_swap_pmd(*pmd))) {
>  		swp_entry_t entry = pmd_to_swp_entry(*pmd);

The above can be replaced with a catch like

   if (folio_test_device(folio))
	return;

...in smaps_account() since ZONE_DEVICE pages are not suitable to
account as they do not reflect any memory pressure on the system memory
pool.

> @@ -1385,7 +1389,7 @@ static inline bool pte_is_pinned(struct vm_area_struct *vma, unsigned long addr,
>  	if (likely(!test_bit(MMF_HAS_PINNED, &vma->vm_mm->flags)))
>  		return false;
>  	folio = vm_normal_folio(vma, addr, pte);
> -	if (!folio)
> +	if (!folio || folio_is_device_dax(folio))
>  		return false;
>  	return folio_maybe_dma_pinned(folio);

The whole point of ZONE_DEVICE is to account for DMA so I see no reason
for pte_is_pinned() to special case dax. The caller of pte_is_pinned()
is doing it for soft_dirty reasons, and I believe soft_dirty is already
disabled for vma_is_dax(). I assume MEMORY_DEVICE_PRIVATE also does not
support soft-dirty, so I expect all ZONE_DEVICE already opt-out of this.

>  }
> @@ -1710,6 +1714,8 @@ static pagemap_entry_t pte_to_pagemap_entry(struct pagemapread *pm,
>  			frame = pte_pfn(pte);
>  		flags |= PM_PRESENT;
>  		page = vm_normal_page(vma, addr, pte);
> +		if (page && is_device_dax_page(page))
> +			page = NULL;
>  		if (pte_soft_dirty(pte))
>  			flags |= PM_SOFT_DIRTY;
>  		if (pte_uffd_wp(pte))
> @@ -2096,7 +2102,8 @@ static unsigned long pagemap_page_category(struct pagemap_scan_private *p,
>  
>  		if (p->masks_of_interest & PAGE_IS_FILE) {
>  			page = vm_normal_page(vma, addr, pte);
> -			if (page && !PageAnon(page))
> +			if (page && !PageAnon(page) &&
> +			    !is_device_dax_page(page))
>  				categories |= PAGE_IS_FILE;
>  		}
>  
> @@ -2158,7 +2165,8 @@ static unsigned long pagemap_thp_category(struct pagemap_scan_private *p,
>  
>  		if (p->masks_of_interest & PAGE_IS_FILE) {
>  			page = vm_normal_page_pmd(vma, addr, pmd);
> -			if (page && !PageAnon(page))
> +			if (page && !PageAnon(page) &&
> +			    !is_device_dax_page(page))
>  				categories |= PAGE_IS_FILE;
>  		}
>  
> @@ -2919,7 +2927,7 @@ static struct page *can_gather_numa_stats_pmd(pmd_t pmd,
>  		return NULL;
>  
>  	page = vm_normal_page_pmd(vma, addr, pmd);
> -	if (!page)
> +	if (!page || is_device_dax_page(page))
>  		return NULL;

I am not immediately seeing a reason to block pagemap_read() from
interrogating dax-backed virtual mappings. I think these protections can
be dropped.

>  
>  	if (PageReserved(page))
> diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
> index b37c0d8..e16053c 100644
> --- a/mm/memcontrol-v1.c
> +++ b/mm/memcontrol-v1.c
> @@ -667,7 +667,7 @@ static struct page *mc_handle_present_pte(struct vm_area_struct *vma,
>  {
>  	struct page *page = vm_normal_page(vma, addr, ptent);
>  
> -	if (!page)
> +	if (!page || is_device_dax_page(page))
>  		return NULL;
>  	if (PageAnon(page)) {
>  		if (!(mc.flags & MOVE_ANON))

I think this better handled with something like this to disable all
memcg accounting for ZONE_DEVICE pages:


diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
index b37c0d870816..cfc43e8c59fe 100644
--- a/mm/memcontrol-v1.c
+++ b/mm/memcontrol-v1.c
@@ -940,8 +940,7 @@ static enum mc_target_type get_mctgt_type(struct vm_area_struct *vma,
                 */
                if (folio_memcg(folio) == mc.from) {
                        ret = MC_TARGET_PAGE;
-                       if (folio_is_device_private(folio) ||
-                           folio_is_device_coherent(folio))
+                       if (folio_is_device(folio))
                                ret = MC_TARGET_DEVICE;
                        if (target)
                                target->folio = folio;

