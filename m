Return-Path: <linux-fsdevel+bounces-25107-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F31D5949306
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 16:29:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 723641F254CA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 14:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EB451C37AA;
	Tue,  6 Aug 2024 14:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RGcTgp4V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892ED18D638;
	Tue,  6 Aug 2024 14:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722954528; cv=fail; b=TuNLuXb9HNFXU3AkUSpEuWP0oyirpBSbIrtVAtviXZRhX0CY4Da+HygnYqHPI+lCzkIONbrxR8I3tmm6vlYpqt4bboCjEbIaG0Y36OU9T90WMzL7NPNHE9Z2myE7H2JC4+slY2RtlH03EF/QSOB12cr0dSHn5GQGS7qCleQKYLA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722954528; c=relaxed/simple;
	bh=guJXt5hLs/k6Gy5qqQbEgBY5K6l41GRJp9C7qXsr19U=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=ZGCCE6R4K6GGxE4RBr7QoWvg8iTjcD3JKJLS1zXCcyfC3ymNdUEQE4Lg7DWlsqJ9T2F1UMAI7qlYyDBhevzRPBahR+YH0ATSkkDSWkf5XqTcjxoV2E3rDwu1ys8Jo+NqfDQ3ZXjdBDIVMBpbU7p35Jvur7T9jhli7o8U+sFfuRk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RGcTgp4V; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722954526; x=1754490526;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=guJXt5hLs/k6Gy5qqQbEgBY5K6l41GRJp9C7qXsr19U=;
  b=RGcTgp4V7ckAT5DjAqJK3lvkMaUaSbsDiwwpgQXNnJp3Lay8WqErei2c
   hJItz/FgN/DwRB9/cV07qNhLaYOBK7J3CWJBNUHnTn0BbSZuILZlJh/6G
   MXdNp3of4VVYsnHbeihgeLgtaLrdYxRgqZAr3+CSmzwCLxl9871g5Qrti
   rbmOQGsPmFiX7coEp8NvqCv8AIb/59hr15olAwazfq9ZvfetzxOvDAgO6
   dBfAXLO9qHJ4rFu5WLrdaKH66K9kQEsia884YsJsrZErg9AajHj93sij3
   frdF7DJBCLntl9Ur0IFWtw8jS60QTck8cA65gw2vjK3mdfWvbxyMLFcVT
   Q==;
X-CSE-ConnectionGUID: ki9NTdStQWy0+W5yRbSxog==
X-CSE-MsgGUID: eqTR9qQmRWWg/dM5aIjbeQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11156"; a="21124737"
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="21124737"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 07:26:39 -0700
X-CSE-ConnectionGUID: gyD9eSBARPSsOiF2Yik7eQ==
X-CSE-MsgGUID: J7P7JTsrQqmWurS4CYTNwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="56223387"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Aug 2024 07:26:39 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 6 Aug 2024 07:26:38 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 6 Aug 2024 07:26:38 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 6 Aug 2024 07:26:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ATdlNkQbUURFDWw3EQ+FOv2F6queS9qW4usskKMd+Fs3nfnS6ph5+3i7pXGUIPEJvV29SqvVDRQSRUK2X/taTH6FZTHVEs0bVvmbyYra2A8QTSpkry7VwLGZRiEVE4EijQnqSln9G18QUTQfaunphnYANjcKCLuXUKVjFXRWHDvGoa5O2ewSMRoBqyKBfxQsGqKRZD+iEelWYzWgn29a1FxqLlgItaeijC7IffnJBmLlQvaZWoqxBnYJ01G/FPtGUYu6u+TVEXUXZJY0HaMvKXJy6PJEsLo2SyK8NKWXy7iNdzEuSlT3LReculGkdKW0Q4HvXM/5Ugw/9ZTmifBYng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fGzr3Hp4lzoFa6xs7RG144KUvQcQ6K+5zwbk0tnn9O8=;
 b=JQ/qoi+efmqX+X3Wwao0QTpvXE13VRzLRoAfbNQZaZs9KTu30nuM/Zw6GhzjVbTWHpF2Ysp6Uycp6LgvzJtPCPEPlvpdVJPGMUpzH6Q+WFDh+t0fxjsO88CH5BENq8QtnRbmIdSoIH+02fitNOkIrTKjQ4v/v5cvRNGbTfJmcGYlLuCy8CeqMW+AXYs7psNrIrhvYoAJLA75znLSm1MIeErOLU7Io/K4Rz+apegkm+e8b7yV8KKaAgfq5XSpsCJjCy1SCnNZE9zgCQq3p3HgRXPYQbinnnzerNxjIMzT+rY+XZIDJAGj6QensS866WeCHJgKXgevnt+CGgMIlpbmGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH7PR11MB7500.namprd11.prod.outlook.com (2603:10b6:510:275::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.32; Tue, 6 Aug
 2024 14:26:32 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7828.023; Tue, 6 Aug 2024
 14:26:32 +0000
Date: Tue, 6 Aug 2024 22:26:17 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Matthew Wilcox <willy@infradead.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Linux Memory Management List
	<linux-mm@kvack.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-block@vger.kernel.org>, <intel-gfx@lists.freedesktop.org>,
	<linux-bcachefs@vger.kernel.org>, <ceph-devel@vger.kernel.org>,
	<ecryptfs@vger.kernel.org>, <linux-ext4@vger.kernel.org>,
	<linux-f2fs-devel@lists.sourceforge.net>, <linux-um@lists.infradead.org>,
	<linux-mtd@lists.infradead.org>, <jfs-discussion@lists.sourceforge.net>,
	<linux-nfs@vger.kernel.org>, <linux-nilfs@vger.kernel.org>,
	<ntfs3@lists.linux.dev>, <ocfs2-devel@lists.linux.dev>,
	<linux-karma-devel@lists.sourceforge.net>, <devel@lists.orangefs.org>,
	<reiserfs-devel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [linux-next:master] [fs]  cdc4ad36a8:
 kernel_BUG_at_include/linux/page-flags.h
Message-ID: <202408062249.2194d51b-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR04CA0009.apcprd04.prod.outlook.com
 (2603:1096:4:197::8) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH7PR11MB7500:EE_
X-MS-Office365-Filtering-Correlation-Id: e94a9346-3ceb-4cd4-8bfe-08dcb623c495
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mB0EYL1MtFxFD4RDqIsstpIbKISXJ2c07Ppcpx3pCKE9AJbAtYP2j+1ba9Pc?=
 =?us-ascii?Q?8Q9mp8Yku7SkBSYAKvaZMGGhluZnWYxNRW0aCaPLaHozkVnX4UGosa3GedhV?=
 =?us-ascii?Q?E60y9fWon/ftfVYnX2NuwudQGhH0Q8xhAqj0aJ23WGDK3ahx69Ir8ibuZalj?=
 =?us-ascii?Q?895JjgX8mdt/9U5EU18nPt+/5NpFUhRJFPTnWlOm/6h/zcrJXxYtilGhej94?=
 =?us-ascii?Q?xKxQvMmfZmBa8YNItOcDSXjR26MRBsZBLZFfpqdTaUbdE+dcP5pRY5d3NVhT?=
 =?us-ascii?Q?GmgJvYJ+nDxx5AID2hXAmkchx+Sb1XGEuvfcwP/0yxEWK0iYkviZD6E6x4Ki?=
 =?us-ascii?Q?oS3IxvdUzrCDojVHAUtLlQf5ERfjwGtqqiYpeZ4wmyHJdMNqRslyVXra+pUH?=
 =?us-ascii?Q?prYXa5mORiz+YBr04gv6Pco4f4VvntCG6jp+ygxzQ0a4TKdzv/yOn2jxliei?=
 =?us-ascii?Q?PlTu0fltzdAwYQfNFJuU09S5JO4Xrx3e/uhK9D53FCHD+CkZ3HVafZUrp1zl?=
 =?us-ascii?Q?9YE/74s0u+vi2AN6JD5vMb8mkI8052vCx6dKLccQVWmusUJhJrpyLc+YqYA9?=
 =?us-ascii?Q?8//6dZP72PaV2PQo2L1H8Iew/el0oDZT26IwP+VMANdXlqDuL49zWbEssdVw?=
 =?us-ascii?Q?qkcmYzfa7HTNjKZnXU79+4F8t8VfyPYLOdo7mB4fsj2fBuAwyVvru3hl92lU?=
 =?us-ascii?Q?8iXrxbBu7rxagfP4Z1ENeQPPZLmJ1gyCvqOhF5xuytspjTY6Gz79mbzDZkNB?=
 =?us-ascii?Q?hVCsvddcZDKpr2a9+/QPWLusW0NT0DrShAB87+6qa7iWpL5o+H+yEnWObUnt?=
 =?us-ascii?Q?cyydQlyUFhio0SXEWP4hhfb5AP1peTTufoDkmJfyDTppvx+ZhfJAmnwW55IG?=
 =?us-ascii?Q?QJsXcrxdc+/pQE2Y2s26t5FQryTNkfzWxywHfw5voWmQshXW/K7kv8VvxFst?=
 =?us-ascii?Q?I2oKWNza9KSHSHRbWnH/rjihV+CjL1pweVIzZrZjmHIYGTqCNd33//7tOM65?=
 =?us-ascii?Q?wAlFbTIVmQ048+dVxr11IoWbPGHb91Bp8+btr2PiFowhfr0si0k1nRhjadE4?=
 =?us-ascii?Q?YprU/hIqedvuBVDEJLsTQj7u/b0OYxtWeimbDfQF6NsFAp5JPM73UADl/svq?=
 =?us-ascii?Q?/5OeDfKyaPtxf6PxE9y+yMf4uR2YCVd/zjiQYAN7u6aXo2381Uwv6adk/53D?=
 =?us-ascii?Q?cV9ZFixCZWX3YBJ1CzRt/l+aMHvmimVIj3JPo/jPgEOUPSYFYbjPUgC2oIto?=
 =?us-ascii?Q?YAwFMVTe0JgAGqjkxeDp00oThIN/rC/g1TlE8Cjn1D71QxIBckP1D2sZLnew?=
 =?us-ascii?Q?0v40ozKpSz2TAN+4FFt4zqju?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eA8AFK2lv6HKS8Do5EpGunyYg8LGOi8TAGkrw9RlUF6gLklfvPIu9az/Nrqa?=
 =?us-ascii?Q?KyPPQQiRwTu75vMfa0Y2/BUT0zqfDs8d3LyvBPK2O0WW2KT+L14BNSYaKPkC?=
 =?us-ascii?Q?P01VR7JlwjhpzQ+EWf2kHNrt2eDCXPWzJvPrs/uoQBsLZg7aUocRknmG7uAk?=
 =?us-ascii?Q?2+oAD3zkzZUkZzeZaEv4qMO0EG9AlMsChe8j6+826OQqF7586IL4vjH1DyDR?=
 =?us-ascii?Q?aktAopGWTs8dZLqhei1qQncoVU5YytLnVvKF4coInKnVtqN6SELdgIApv0yR?=
 =?us-ascii?Q?9EnybXHG2yVHlD8QUHDFhKTEge0JkZsiwNUuIH/dgElxUze7kuKmCISSlYmk?=
 =?us-ascii?Q?V+QeTEHHTOi2nEchL2+K0yBIQl0pf0R2edJvU67hrEp/XrkUv2j/T12qhA0E?=
 =?us-ascii?Q?ExjIM07wCBUWxWc6srJMrq8qr9go54roba7Ng2eIz+Wq/exUbY/pwKpOm9No?=
 =?us-ascii?Q?XI4OAKO2iX4IWq32fH78tD2yJ6qQEMpSt8CD6XGs6ktxdhv7fPmRl3jdhH1u?=
 =?us-ascii?Q?6TOXyAzSYUb230a4w2XU/nQFbI/hUH8eoqAtAKAL6oQOcyu5p1atEupBB+T/?=
 =?us-ascii?Q?TKjS/Gvykh7VZL9ejA9z/xlyec/YHmlx4A5OxzFMYUx3rEforrF9OfQUWUwL?=
 =?us-ascii?Q?Xh+FraY2cUv5epuBgQB3UHdEip1JeNLf+qCeiW5ILjAATO6nhh6ZvZOBJM92?=
 =?us-ascii?Q?hubFQRsa3ZgJ+6AMlXUW1YJCZ4p3Nn9wBsQGP/R12JRw94an4KgztD/fUuGw?=
 =?us-ascii?Q?13aMKO/D3sFbQFZ7h3lh8dLp8uOpVlR6crFVdz2geCH8T5jGoSydkre6P7pU?=
 =?us-ascii?Q?/IxE5SzhBCBYPdkaCKiQfcbls0cdd5iK8xUvaOvFJkuJw5y5PGAHubZlQUzz?=
 =?us-ascii?Q?2PtioQ/oHSTWV6DEq+J/pTHcvMX1RDaqxY23P2z7xLiqst30ZAq5s5r5Om15?=
 =?us-ascii?Q?gUJ8xZVTOH8tDwiii9OBP5NxbdjvuZEwZdSNNcw02c3a/utK0vWfy7HKGFfl?=
 =?us-ascii?Q?AQSzZ3HVhdseHuUUU4DIzcWV9nk/qb0QbxCukbh9t0lY40GxJZqT1OrWgXqy?=
 =?us-ascii?Q?nQp73XXiEjedvpnUAi9smncnWLwGwnBs4HsRFJjTcVHEJldAljQb1eMbWP63?=
 =?us-ascii?Q?xq9uX1sbmrDbWpCTn+StKsJ2O/aPmt0XjyXc0aGurzFOnOgOq8H1fHpLZyVq?=
 =?us-ascii?Q?N6W3TbTyOg/Iv1C7OpLYFdiUwVE0LrZ2KkIzoSc5TGru8XdzR8JJs9Djy7oF?=
 =?us-ascii?Q?Db1jOkdFZrftNcuvtf/xHJxUuY/lj1uqwDruJ6VXlP5x0Xlw7T6UBkVA8Y4q?=
 =?us-ascii?Q?svlHSJrT4AlgdApJLVQicsqWqSkKCAg5p5Ih/1vwn5FeJK7x+H1756+d54ot?=
 =?us-ascii?Q?OtrTkAyku2ee0RzANMxWsLG0WHJGZNGCr2FLO2u2+HLqeZ4DXAmY/jZ4q5bS?=
 =?us-ascii?Q?Eg3KUjfjRI1F1eDCYLLyvQuPOZFQjOqTomCa7kBw+EYlzfqtTq6fEsh5N8Ml?=
 =?us-ascii?Q?OiQZs4HXfETvSAiuDiSotsfEjPf9JrcNbZaOcwjSriUHFyIsNo5WavSiO5rO?=
 =?us-ascii?Q?t8DSZYZw7mlUBJae7Rxf/SMaLdueiCOa+sYgB7dn3ObPYNEZ/abNBPFPY18K?=
 =?us-ascii?Q?nA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e94a9346-3ceb-4cd4-8bfe-08dcb623c495
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 14:26:31.9618
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: swcdo0wJAwd82lP8fzEEHBl2Vr4WkMHQML81U3Dywhz+DO16CUWG15l5v/2XHCWEMAIET54dfLVTOGo9er3dBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7500
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "kernel_BUG_at_include/linux/page-flags.h" on:

commit: cdc4ad36a871b7ac43fcc6b2891058d332ce60ce ("fs: Convert aops->write_begin to take a folio")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master 1e391b34f6aa043c7afa40a2103163a0ef06d179]

in testcase: boot

compiler: clang-18
test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 4G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+------------------------------------------+------------+------------+
|                                          | 300dd0fa8e | cdc4ad36a8 |
+------------------------------------------+------------+------------+
| boot_successes                           | 36         | 0          |
| boot_failures                            | 0          | 36         |
| kernel_BUG_at_include/linux/page-flags.h | 0          | 36         |
| Oops:invalid_opcode:#[##]PREEMPT         | 0          | 36         |
| EIP:shmem_write_begin                    | 0          | 36         |
| Kernel_panic-not_syncing:Fatal_exception | 0          | 36         |
+------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202408062249.2194d51b-lkp@intel.com


[   11.817454][  T102] ------------[ cut here ]------------
[   11.818309][  T102] kernel BUG at include/linux/page-flags.h:308!
[   11.825783][  T103] aops:shmem_aops ino:8 dentry name:"n2.tmp"
[   11.826808][  T102] Oops: invalid opcode: 0000 [#1] PREEMPT
[   11.827585][  T102] CPU: 0 UID: 0 PID: 102 Comm: udevd Not tainted 6.10.0-12082-gcdc4ad36a871 #1 bef0abbc1afe2d2f07a6410b59dcdae1fe513b9d
[   11.829082][  T102] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 11.830495][ T102] EIP: shmem_write_begin (include/linux/page-flags.h:308) 
[ 11.831231][ T102] Code: 62 ff ff ff 8b 7d 10 01 f7 89 d3 83 d3 00 39 79 34 8b 79 38 19 df 0f 8d 4a ff ff ff eb cb 89 f0 ba 0b 15 3b c2 e8 ec 60 01 00 <0f> 0b 68 18 5c ad c2 e8 d0 fe 6a 00 89 f0 ba f6 f4 3a c2 e8 d4 60
All code
========
   0:	62                   	(bad)
   1:	ff                   	(bad)
   2:	ff                   	(bad)
   3:	ff 8b 7d 10 01 f7    	decl   -0x8feef83(%rbx)
   9:	89 d3                	mov    %edx,%ebx
   b:	83 d3 00             	adc    $0x0,%ebx
   e:	39 79 34             	cmp    %edi,0x34(%rcx)
  11:	8b 79 38             	mov    0x38(%rcx),%edi
  14:	19 df                	sbb    %ebx,%edi
  16:	0f 8d 4a ff ff ff    	jge    0xffffffffffffff66
  1c:	eb cb                	jmp    0xffffffffffffffe9
  1e:	89 f0                	mov    %esi,%eax
  20:	ba 0b 15 3b c2       	mov    $0xc23b150b,%edx
  25:	e8 ec 60 01 00       	call   0x16116
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	68 18 5c ad c2       	push   $0xffffffffc2ad5c18
  31:	e8 d0 fe 6a 00       	call   0x6aff06
  36:	89 f0                	mov    %esi,%eax
  38:	ba f6 f4 3a c2       	mov    $0xc23af4f6,%edx
  3d:	e8                   	.byte 0xe8
  3e:	d4                   	(bad)
  3f:	60                   	(bad)

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	68 18 5c ad c2       	push   $0xffffffffc2ad5c18
   7:	e8 d0 fe 6a 00       	call   0x6afedc
   c:	89 f0                	mov    %esi,%eax
   e:	ba f6 f4 3a c2       	mov    $0xc23af4f6,%edx
  13:	e8                   	.byte 0xe8
  14:	d4                   	(bad)
  15:	60                   	(bad)
[   11.833693][  T102] EAX: 00000000 EBX: 00000001 ECX: 00000000 EDX: 00000000
[   11.834656][  T102] ESI: e7a1f820 EDI: ebad5ac0 EBP: eb4fdd20 ESP: eb4fdd10
[   11.835648][  T102] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 0068 EFLAGS: 00010282
[   11.836740][  T102] CR0: 80050033 CR2: 00fb121c CR3: 2b40a000 CR4: 000406d0
[   11.837714][  T102] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[   11.838683][  T102] DR6: fffe0ff0 DR7: 00000400
[   11.839367][  T102] Call Trace:
[ 11.839909][ T102] ? __die_body (arch/x86/kernel/dumpstack.c:478 arch/x86/kernel/dumpstack.c:420) 
[ 11.840561][ T102] ? die (arch/x86/kernel/dumpstack.c:447) 
[ 11.841150][ T102] ? do_trap (arch/x86/kernel/traps.c:? arch/x86/kernel/traps.c:155) 
[ 11.841736][ T102] ? do_error_trap (arch/x86/kernel/traps.c:175) 
[ 11.842383][ T102] ? shmem_write_begin (include/linux/page-flags.h:308) 
[ 11.843047][ T102] ? shmem_write_begin (include/linux/page-flags.h:308) 
[ 11.843761][ T102] ? exc_overflow (arch/x86/kernel/traps.c:252) 
[ 11.844444][ T102] ? handle_invalid_op (arch/x86/kernel/traps.c:212) 
[ 11.845176][ T102] ? shmem_write_begin (include/linux/page-flags.h:308) 
[ 11.845918][ T102] ? exc_invalid_op (arch/x86/kernel/traps.c:267) 
[ 11.846634][ T102] ? handle_exception (arch/x86/entry/entry_32.S:1047) 
[ 11.847347][ T102] ? lru_lazyfree_fn (include/linux/list.h:124 include/linux/list.h:215 include/linux/list.h:229 include/linux/mm_inline.h:355 mm/swap.c:633) 
[ 11.848042][ T102] ? exc_overflow (arch/x86/kernel/traps.c:252) 
[ 11.848686][ T102] ? shmem_write_begin (include/linux/page-flags.h:308) 
[ 11.849348][ T102] ? lru_lazyfree_fn (include/linux/list.h:124 include/linux/list.h:215 include/linux/list.h:229 include/linux/mm_inline.h:355 mm/swap.c:633) 
[ 11.850008][ T102] ? exc_overflow (arch/x86/kernel/traps.c:252) 
[ 11.850650][ T102] ? shmem_write_begin (include/linux/page-flags.h:308) 
[ 11.851371][ T102] generic_perform_write (mm/filemap.c:4018) 
[ 11.852110][ T102] shmem_file_write_iter (mm/shmem.c:?) 
[ 11.852790][ T102] vfs_write (fs/read_write.c:498) 
[ 11.853346][ T102] ? kmem_cache_free (mm/slub.c:4425) 
[ 11.853945][ T102] ? shmem_file_read_iter (mm/shmem.c:3061) 
[ 11.854693][ T102] ksys_write (fs/read_write.c:643) 
[ 11.855325][ T102] __ia32_sys_write (fs/read_write.c:652) 
[ 11.856005][ T102] ia32_sys_call (arch/x86/entry/syscall_32.c:44) 
[ 11.856683][ T102] do_int80_syscall_32 (arch/x86/entry/common.c:?) 
[ 11.857375][ T102] ? syscall_exit_to_user_mode (kernel/entry/common.c:221) 
[ 11.858131][ T102] ? do_int80_syscall_32 (arch/x86/entry/common.c:343) 
[ 11.858864][ T102] ? free_to_partial_list (mm/slub.c:4265) 
[ 11.859637][ T102] ? __slab_free (mm/slub.c:4291) 
[ 11.860288][ T102] ? do_mkdirat (fs/namei.c:4243) 
[ 11.860926][ T102] ? mntput_no_expire (fs/namespace.c:1460) 
[ 11.861609][ T102] ? kmem_cache_free (mm/slub.c:4425) 
[ 11.865615][ T102] ? do_mkdirat (fs/namei.c:4243) 
[ 11.866331][ T102] ? do_mkdirat (fs/namei.c:4243) 
[ 11.866989][ T102] ? syscall_exit_to_user_mode (kernel/entry/common.c:221) 
[ 11.867783][ T102] ? do_int80_syscall_32 (arch/x86/entry/common.c:343) 
[ 11.868435][ T102] ? irqentry_exit_to_user_mode (kernel/entry/common.c:234) 
[ 11.869221][ T102] ? do_fast_syscall_32 (arch/x86/entry/common.c:411) 
[ 11.869855][ T102] entry_INT80_32 (arch/x86/entry/entry_32.S:944) 
[   11.870507][  T102] EIP: 0xb7e536c2
[ 11.871050][ T102] Code: 90 66 90 66 90 66 90 90 56 53 83 ec 14 8b 5c 24 20 8b 4c 24 24 8b 54 24 28 65 a1 0c 00 00 00 85 c0 75 15 b8 04 00 00 00 cd 80 <3d> 00 f0 ff ff 77 47 83 c4 14 5b 5e c3 90 89 54 24 0c 89 4c 24 08
All code
========
   0:	90                   	nop
   1:	66 90                	xchg   %ax,%ax
   3:	66 90                	xchg   %ax,%ax
   5:	66 90                	xchg   %ax,%ax
   7:	90                   	nop
   8:	56                   	push   %rsi
   9:	53                   	push   %rbx
   a:	83 ec 14             	sub    $0x14,%esp
   d:	8b 5c 24 20          	mov    0x20(%rsp),%ebx
  11:	8b 4c 24 24          	mov    0x24(%rsp),%ecx
  15:	8b 54 24 28          	mov    0x28(%rsp),%edx
  19:	65 a1 0c 00 00 00 85 	movabs %gs:0x1575c0850000000c,%eax
  20:	c0 75 15 
  23:	b8 04 00 00 00       	mov    $0x4,%eax
  28:	cd 80                	int    $0x80
  2a:*	3d 00 f0 ff ff       	cmp    $0xfffff000,%eax		<-- trapping instruction
  2f:	77 47                	ja     0x78
  31:	83 c4 14             	add    $0x14,%esp
  34:	5b                   	pop    %rbx
  35:	5e                   	pop    %rsi
  36:	c3                   	ret
  37:	90                   	nop
  38:	89 54 24 0c          	mov    %edx,0xc(%rsp)
  3c:	89 4c 24 08          	mov    %ecx,0x8(%rsp)

Code starting with the faulting instruction
===========================================
   0:	3d 00 f0 ff ff       	cmp    $0xfffff000,%eax
   5:	77 47                	ja     0x4e
   7:	83 c4 14             	add    $0x14,%esp
   a:	5b                   	pop    %rbx
   b:	5e                   	pop    %rsi
   c:	c3                   	ret
   d:	90                   	nop
   e:	89 54 24 0c          	mov    %edx,0xc(%rsp)
  12:	89 4c 24 08          	mov    %ecx,0x8(%rsp)


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240806/202408062249.2194d51b-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


