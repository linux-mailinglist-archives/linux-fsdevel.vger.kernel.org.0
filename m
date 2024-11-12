Return-Path: <linux-fsdevel+bounces-34532-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D009C618D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 20:34:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34A1A285D81
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 19:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B4021A4CE;
	Tue, 12 Nov 2024 19:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IgYotECi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30C2219C8D;
	Tue, 12 Nov 2024 19:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731439968; cv=fail; b=jNjSsWV7U7zyEZkFunAF8UX6LrHW28oBFFUy0SFVOViVR4PTsQNGHfUCRwu8W7vQ9wTa13CQqWm6IJQ9rpi2OEPmyWEFR3X7OyxpMS0jPmsHPe52KsCPWAorltLTR3kFWULP4lmIDF4KRwWDJHYOdblXDLWoLR5uzpsTWiz3Mc8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731439968; c=relaxed/simple;
	bh=An0nUhTwo1SlhtLRSG7bZIpb7VXDqe8XZYY1EIxJ7sc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HfyrvpLK8O6cRn8XnTa368Id1DmzHDEb3KsReI4IoMa0wtSC0KbFTL3hXTRZg+6MDiY9WZgRCzrDls0kzVeY8qNakiQOLyyt8SmmLPXdYBirQXCr5v4uNQcDBFyDBt00mPwY8reA0l0A+puai0ER85r7d2M5J4cWjBoh3Z2H0E0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IgYotECi; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731439966; x=1762975966;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=An0nUhTwo1SlhtLRSG7bZIpb7VXDqe8XZYY1EIxJ7sc=;
  b=IgYotECivIPSSEWYjHjrV6/8ntIXm8IUQgA9XsygYyE2K5RonyN3piZm
   LJ0DFSc7Bo7ZkZSrX+udTCAanuDBV9DZN1tzrNUV27oHBDSdsz9GCoEt+
   gyyCbuEO5ijEbFz55+ptvnWg/VDnfpxgeAUa0BHir61I+TYDly7pNeT7w
   7J4gUGjE+YAbemzjLb2zGoymiqjKt2BuIp7wiZwqbwsQB5OOAp/LaK/uX
   KwpGD8X9bbMD3btD01smMOmZSC+4bP+8k0n6UcaRPY9rfs3hPjRN2MXC8
   +OBe4X/W57aiP4ZeK7IRSzXZp9RjRaYOp2tkFexe1CWr5e9ylUK1idnW7
   Q==;
X-CSE-ConnectionGUID: Bi4g6WYuQySyxsMf6Ilaww==
X-CSE-MsgGUID: Pj1RN2BoRw+KgGRXB7s43Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="53853065"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="53853065"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 11:32:45 -0800
X-CSE-ConnectionGUID: Vr7Kjq15TAe2/qP/3SpOOA==
X-CSE-MsgGUID: tVjcFDSwTKuFwLs4wfsGYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,149,1728975600"; 
   d="scan'208";a="87532779"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Nov 2024 11:32:44 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 12 Nov 2024 11:32:43 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 12 Nov 2024 11:32:43 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 12 Nov 2024 11:32:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wPpST534Gj4l0nCMNrtbeARIWZPf5Tb9PxkEaNyQTq/o0sYVLPrQNVv25LbWvRuHBjEp24mpR1BjvVqy4l0tBGq7YG51/E8vSYQFfOZvorgQXI29qlMEcihX6KmmH6RtFxuEYsVmJDwJVo9KPWvJFiHSdNnePtp+kqCVupo2ly5zHz90HqmwsILTVtN6r0MSi4ppopqK4SQEe5lAkB3MVIKckpmV5Xf2Rd0xEDztKRJ/d6BC52uwI9N7wyU/f6/a/YbnAQ10io0CMWsGOvwLCQKIb9os3+wGUFddS0LMoJuUMBStXIX+sxrDIQGcp66TwDQoKCCyRPVoSWPy9gkyrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hzSrY5bbSBMYOrN9uexB0QJKB4yXeNpdvrppivoMj3A=;
 b=Ap6HkWSrHZD+HBPA8NhRUz6+xNz4aJ8JXnuPnkEokNaU175B8qR0YvZONzdT7fzJBCQt04C0iHkWltJmQuhtJCedAyhC/kAQrWLLHBbQo5Nx6Cvbvtflfc/mabjLSot727KseppEv7FqPlGQjKFljT064AAJUXGQTKu+TAAz5D0DrpwIlfQTGViyqEDrWSaPhwpWbzvPGQVu5NN8YMxffR1PCFIIXBn051btHNGKeoECPf3gZxAs91wWqe8y/FP68McSnkJYPAKJpcDAqSlim0anpnYV29EZh0TWn/BKG4iPG9c1FWVg3KIwwhE3ExfX2NLgc7rZGzuBRXaVTUOa9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA1PR11MB8427.namprd11.prod.outlook.com (2603:10b6:806:373::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29; Tue, 12 Nov
 2024 19:32:39 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 19:32:39 +0000
Date: Tue, 12 Nov 2024 11:32:36 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Jan Kara <jack@suse.cz>, Asahi Lina <lina@asahilina.net>
CC: Jan Kara <jack@suse.cz>, Dan Williams <dan.j.williams@intel.com>, "Dave
 Chinner" <david@fromorbit.com>, Matthew Wilcox <willy@infradead.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
	<brauner@kernel.org>, Sergio Lopez Pascual <slp@redhat.com>,
	<linux-fsdevel@vger.kernel.org>, <nvdimm@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <asahi@lists.linux.dev>
Subject: Re: [PATCH] dax: Allow block size > PAGE_SIZE
Message-ID: <6733ad54b70ed_10bb7294b2@dwillia2-xfh.jf.intel.com.notmuch>
References: <7f0c0a15-8847-4266-974e-c3567df1c25a@asahilina.net>
 <ZylHyD7Z+ApaiS5g@dread.disaster.area>
 <21f921b3-6601-4fc4-873f-7ef8358113bb@asahilina.net>
 <20241106121255.yfvlzcomf7yvrvm7@quack3>
 <672bcab0911a2_10bc62943f@dwillia2-xfh.jf.intel.com.notmuch>
 <20241107100105.tktkxs5qhkjwkckg@quack3>
 <28308919-7e47-49e4-a821-bcd32f73eecb@asahilina.net>
 <20241108121641.jz3qdk2qez262zw2@quack3>
 <a6866a71-dde9-44a2-8b0e-d6d3c4c702f8@asahilina.net>
 <20241112143436.c2irwddrwopusqad@quack3>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241112143436.c2irwddrwopusqad@quack3>
X-ClientProxiedBy: MW4PR04CA0373.namprd04.prod.outlook.com
 (2603:10b6:303:81::18) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA1PR11MB8427:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a867ea5-882b-4f69-c735-08dd0350c4fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7ClaD9lrIHeLAC1zhuxCISjrAUYah7z8f3Nq9uFdMvtrQXCDUVp2CT2qjqAJ?=
 =?us-ascii?Q?Sw+KFBJJguAI1DXj63SbJC4CwPchA4grBgWWaKbJF8bmSumdcArC7My/pGJl?=
 =?us-ascii?Q?8nAI5hIdplEzdkfAUGHOsmT+t4nz1B8wHApGSR5f/UzDa9wbdtm4zDdciaZh?=
 =?us-ascii?Q?XVu5ODv3fqX/T0JQb1Jdq9qYoNtTDILHjScxaECxMJpnYL7664UV4FDC3AqO?=
 =?us-ascii?Q?NUGrVUfcwgyPMgpyWVqkXm9xiwU6QQL46elw43FDKa4GhrDEVmn9zYfZLjfS?=
 =?us-ascii?Q?nt+VtyjBOssNv/g9leCVJlPUCheaDGlusy0qW96wqiKCyvgFdm4eMp5TRCiE?=
 =?us-ascii?Q?v8EpDsKMO5i/HSjG+V9dvZuRTssCtT1A4O4RTXlV+oa0sWK/xbdRmXmh4jzB?=
 =?us-ascii?Q?39fvbhTK7YMebBEos/0j9XQRKWdX/nExsAD1VU9MldEALq4ThRyjTeG++7/G?=
 =?us-ascii?Q?Xp9gb1QUD3U8x5dGRFgQzO4GuUbd3ejj7hUPg7Dih6UQ8jwcGBWeFTaYSq76?=
 =?us-ascii?Q?8BlEha7GxttQnF1JBwYlvRQjEN2AnbPvvP7TKGQVwqy6NT1Jitt/k29h6Q51?=
 =?us-ascii?Q?Zv+f0o1LvcOtThTwJ5vSZ51GCohaTtsaV8LiAMXSMOvlG7selk++3QUSYvf9?=
 =?us-ascii?Q?q6zIscousk2lxfIp6QDquwygILhunZ18UsI+NPR6UZYbjANXkb4PpoanH1E4?=
 =?us-ascii?Q?u8uqm5Zi7uMQpkNjNBxr0zZAw2Yue5kwDiT/BDFIytM+hP5n7bA7psPXmURV?=
 =?us-ascii?Q?xFjqbRgaRTxr2L/SXsCJT2RMAEdQjrOru7sCDgl0MIaZt8h5LRIPKuRz//kG?=
 =?us-ascii?Q?mS7WD/94hbSjXfBMNolyWQ6W+l9ogDJCxNdQ4G2cGJaPKSZhZH7q5eRfujkT?=
 =?us-ascii?Q?8DSdPvCZIatdKgKswAOMzb5orF+kMUh9UlKaHrJfF5+OcwarqDBFI93c33tr?=
 =?us-ascii?Q?ZOSp37BUUrlOCg9CkEQcLE/zXYnB4EsbDP/YSQRVQ74pmEmecvU30svw1gbm?=
 =?us-ascii?Q?JqMKkv8sZfRKRnsfUlWsAz4eusSVAQhHxf8ZLLEqZDd2IAp62jB2gFuzVtCd?=
 =?us-ascii?Q?DyxFTTlWmpSEcMAWSFHrnTdHmR/V4A1RRoHnc+E4QDjZ6rtmFk9TAE+obA0V?=
 =?us-ascii?Q?GVQ9UM9YYs3AgWj6SEJp8tcCK48/x7vluCKSN2afmcBzflFQCRpgwaxmnPsV?=
 =?us-ascii?Q?jk96Ffw4QKnxmkJxgkDyvsO0Bl0stM463r8/pCBk5p6jrLe9L70TOGbIur/x?=
 =?us-ascii?Q?lKtG8/IImKBKA4yTYElzb3NSlS3FNBBimcIHQjusTBlINUxFEAifM5Og6fzA?=
 =?us-ascii?Q?bGqOZWgPu+6gjqb/US2PGpu+?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6zXmtwwqBjTBHYgidGB8fN179j8rhIz4LuzBwW9cjE30iPcKV2gno0Y7mHwm?=
 =?us-ascii?Q?lMLCKTJshFIG5xecbFO80sLb/xADPPRbNQ9h0RbE64IAb5KgX24GWbh1k4L9?=
 =?us-ascii?Q?aXHC56F3php6B2L6wgLXyrSNydEy+6OxrkEw+VtL/o0mDexP4kVg52wMzNLE?=
 =?us-ascii?Q?DrdX8ECfTWdNZnmKWVrfxBqOVig8quadfu3Ig8wDEbeygErxsKZoPTFsRIEl?=
 =?us-ascii?Q?yvR+wBnBhs8y2rPG77QwFGGaI4tjiqefaMz319mnQgm3Y07rRhYWmu4+TcLr?=
 =?us-ascii?Q?zhGBr8NSpmTZoApgZoCnsjsuzrSeYPl6TSCvVZ3dhhhl9c4WUP7oov+ON8k4?=
 =?us-ascii?Q?u7yb01yp2sS6yd6EBNtZOzSsN7NqBi6tcKkQYvr546njqgRfQN1F4yR+dvsb?=
 =?us-ascii?Q?QOPFqqrgfPBXUpuoCIu/bvsLfH7YLt+3XaDQEi/wmOT91MGuK2N0u66foQXz?=
 =?us-ascii?Q?21AnJlQOIdc92v34QIwSZWXmWpBxLub8JhNX/GpQxaKl52bpiAeODQp5HIX8?=
 =?us-ascii?Q?eqwMWTAfnQcZ13ONqFkHgc5fjc6u4ZNCUuWRDdmWRKfV6CnBFTP3CgI5d6nV?=
 =?us-ascii?Q?8ELq8JGFXCqWcCaL1zHEfaFMQEUmM/Hcv8sJY4ZkSDyAsMJhXqIMWyO8Cs+L?=
 =?us-ascii?Q?8qIkM1LNJybWXXNl9yHtD/aPSQSm9mK0s9c2o8Wsw+/qmZs1wNHprV3m+ePK?=
 =?us-ascii?Q?877cdDoi/SDGX3rAEQmq7Lz5r7tzdsFvAucRmDadhoZ7RAUUWUjQQuqKPjEd?=
 =?us-ascii?Q?zrgpmB6xULGQUjtLvaH5gskOyjjKn4NIIOdkKDR5a7pw9htkzt2IKkQ0RVLQ?=
 =?us-ascii?Q?z+SSBdqUMTGECHJ4Q14y7ZWw6GJXZqaXth1eO4GZh3ep+ftIoN2Lp3ULm1G9?=
 =?us-ascii?Q?6C5YRO+s5iUCEdqcxoDK0kac7ZEkdWgRWZDQOyab9S8tQkUVALvefGl+7KvZ?=
 =?us-ascii?Q?aCPd14Cdaht9jSm0h0Nta1a3skdK85U7EAebWfK7+O4HUZVYx1nr/rpEcN0y?=
 =?us-ascii?Q?9tGyph7lZkwb6m5lBBLSrFv3eiIho9nJ2V3y/f9RFqDpvHnnEzF3bsddOsKF?=
 =?us-ascii?Q?tByvy0ej0zmKYkT5IoNwtdlGxJMrkifNc4Ntf2Pb8g7mvJBruK+ySsiKxVdj?=
 =?us-ascii?Q?Pn6IN1qTFempqWlQWXxY0MQHLER2hv+hZg6jKkuCSsexgAOqehSOq/uNqwdF?=
 =?us-ascii?Q?FMm8/IMeOb4mockJOv+jbF3W4ZYmLKuvmpUhCzl3HVpFCaPzy+oHnC+kITtH?=
 =?us-ascii?Q?VVCcq8kJmGKqpHSmUrP/0BEVPr6s9Zxd1lzcvdeI3VIMDKJNuo5Fp+CkikrB?=
 =?us-ascii?Q?MDRtXX+AOpypZkDELZNEfZGQBtHW/yG127LgNqABcCPJZVJBQmjY8+VGt0l9?=
 =?us-ascii?Q?QK18xB36SclSqBxCTEUuOiMnyO8XenR9VFJaKkMVXptWxw+Z8/zJRBZMcd2U?=
 =?us-ascii?Q?dgLt2Y7BBNTu+qIjdYnFyrLtDLCV8fVbjdj0aMAjfQevP3+4i7BfmZCfFwAw?=
 =?us-ascii?Q?QwLbB8HEahCI5YWtyE/HIlNp+hwpFIOwmMPGG0bcMQqttb8aOy6OndfT7/2m?=
 =?us-ascii?Q?La+JAnFsizHdLaoeqRWtJRm+62K+AEb/0BryLRqHevT9u8xE0lX31s1U8qPO?=
 =?us-ascii?Q?AA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a867ea5-882b-4f69-c735-08dd0350c4fc
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 19:32:39.5443
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PLUgSyJoUZJYP+B6lwVCFowRu3crG8haj0B1TL/bA2gK/f0bzr93Dc3sdHAh1FSYBAc/mCSDDGTdvObfku6N5mt2rkW9xZiA5qXY8fn2CCg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8427
X-OriginatorOrg: intel.com

Jan Kara wrote:
[..]
> > I think we should go with that then. Should I send it as Suggested-by:
> > Dan or do you want to send it?
> 
> I say go ahead and send it with Dan's suggested-by :)

Yeah, no concerns from me, and I can ack it when it comes out.

