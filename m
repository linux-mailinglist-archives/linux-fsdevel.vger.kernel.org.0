Return-Path: <linux-fsdevel+bounces-60973-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADBA2B53E79
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 00:07:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67AE4AA5EE8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 22:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B621346A1D;
	Thu, 11 Sep 2025 22:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VJ8ixl+G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921EA2EB5C9;
	Thu, 11 Sep 2025 22:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757628455; cv=fail; b=YuF4E43rSUPTvjUaVigfEBkuHK8QAKBw/B+j3EtkL5rRqRWPXJNFpCvj7PxTn5Zrt/2R0ZRF+bvV8B22pA2Uh6K3ZxMnSkMiW/FTgh1xrBf/akr65K5sZEv82nJ5SwNzR1q3d0k0BD8i9f0ZeYUB36HmsNL81fkUA3hK2eArVWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757628455; c=relaxed/simple;
	bh=/0jbTR5no0OX5GVvppW5xzir+Y05qrAhgk/zorEwNO4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tjknviZsNAYAFCjA51sOljCqwgDxccd3eTZbVHkdERhSxUYL16Ve9QKrp+tk58idyJIPHgtgtWlLQSvXJ8QM7EyGTVsW8jemUWg8d1KHxg/noiCztSQPgQMA2PWdFcbswSZ8gTlt2JlF7lDdXNJTnvOSgBZ/wTdgpQuR+eghNyM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VJ8ixl+G; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757628454; x=1789164454;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/0jbTR5no0OX5GVvppW5xzir+Y05qrAhgk/zorEwNO4=;
  b=VJ8ixl+Gb97te+evVOXtnehFqnNxdiVuEFZmWUCPcSw2BGuuSxjKSBKi
   MMNdulgneZjWIzIA1vSNcNg1RB6S6spMoT4DxokP80FsDQEH5ZdW40f4Z
   uWezUcZg7oRI0+OmlkVO2wjRvtk0S/vNjborkWSCxKUEEXF7coAdE2sun
   Vzs2Sy0WUDyVMGyfne2d4RajrCUD5UCAWjy+Ruhy2XBW0s0UKWfXmeXt0
   UWidSGP3RSDO2asstnLJiGim0YfZQGwzGf/2hLUN+avsr8VRGJjevTvyV
   9Weh336wmbGp4iOmHbIkzfGgBxKk+NK2B2TFub0GqIvzVmt9Fs4wldxnn
   A==;
X-CSE-ConnectionGUID: 6gw8TbyoQG6orfDvaJJjwA==
X-CSE-MsgGUID: 052zDmidTHq+RvC014xyRQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11550"; a="71349756"
X-IronPort-AV: E=Sophos;i="6.18,258,1751266800"; 
   d="scan'208";a="71349756"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2025 15:07:33 -0700
X-CSE-ConnectionGUID: fxqupNegR/CqAnoDOWiuoA==
X-CSE-MsgGUID: 3hMBsVIaRWWKRDkUUGglng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,258,1751266800"; 
   d="scan'208";a="173710304"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2025 15:07:30 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 11 Sep 2025 15:07:29 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 11 Sep 2025 15:07:29 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.64) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 11 Sep 2025 15:07:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rqDNgKe8mBHicsje7i1Z+3vUa+N0iv+fkR96LCZNnfuBoJLgZ5EEUwoM6UR2XY1LvxqloiceHAf4sAe/cSPMxlufqyWX3ovoGImcv/QrRPCIfOts3KBA9BSQZAQlPCfkpXfuWPbsFbZNkDqUR5e+/LEAksj8n9i8XUaE6YZsy8pndyZ1gW2zmJOcME40rHbwKLPQaBkmXI2nS6mgBm8iuXBYFIMDSNrjRI+3fWoo65iC0FNY/FKm5rC9qaM+uOBnCEDLK5MSX6OmZGpIzZwrAqnsSaZGCQcaBfWLO0bTWsz9anYTjAhH4sfN0OJB3SuYB7GC6V0fOTdP74UGMw26Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Yb5jZGdD0sSS+5D1aGT7DsEJz3AB9mw/RY9EV+oKqU=;
 b=jkSAEq98XNF45dpVyqG/x4x1EnOhZ/imo6pAR83pY2mMqGr73T9aGK/U5sakWd4k9pz9K5b/uU5pvNU5fB+G1AvR0blLoZBkR2PEFA9vav3OfnQ4RWgPFCK3yP0L3kjbluc9lDq+668sRrHSJAaPQVuoMFFTvaPQwITJCcN0cbHVQDhQz0MenniiWmhBZvHEypGvFZGgKv+Kv4Wg45xHxFpWRLG5QVagQJFxkfve/1VqLVQLom72b8iYn1OnMyvugbQLJIB2Riu8CtBZBLobZlwygnJZLmsyLYa647f9WIjvEb6IK/fX9RoWk4XkOndf1LWx3JNKpIrx/czPxejDMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA2PR11MB5035.namprd11.prod.outlook.com (2603:10b6:806:116::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 22:07:26 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 22:07:26 +0000
Message-ID: <dce30be7-90d3-4a6a-9b26-44d76c3190a0@intel.com>
Date: Thu, 11 Sep 2025 15:07:21 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/16] mm: add ability to take further action in
 vm_area_desc
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton
	<akpm@linux-foundation.org>
CC: Jonathan Corbet <corbet@lwn.net>, Matthew Wilcox <willy@infradead.org>,
	Guo Ren <guoren@kernel.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger
	<borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, "David S .
 Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, "Arnd
 Bergmann" <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dan Williams <dan.j.williams@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, Nicolas Pitre
	<nico@fluxnic.net>, Muchun Song <muchun.song@linux.dev>, Oscar Salvador
	<osalvador@suse.de>, David Hildenbrand <david@redhat.com>, Konstantin Komarov
	<almaz.alexandrovich@paragon-software.com>, Baoquan He <bhe@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>, Tony Luck
	<tony.luck@intel.com>, Dave Martin <Dave.Martin@arm.com>, James Morse
	<james.morse@arm.com>, Alexander Viro <viro@zeniv.linux.org.uk>, "Christian
 Brauner" <brauner@kernel.org>, Jan Kara <jack@suse.cz>, "Liam R . Howlett"
	<Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport
	<rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko
	<mhocko@suse.com>, Hugh Dickins <hughd@google.com>, Baolin Wang
	<baolin.wang@linux.alibaba.com>, Uladzislau Rezki <urezki@gmail.com>, "Dmitry
 Vyukov" <dvyukov@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, "Jann
 Horn" <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-csky@vger.kernel.org>,
	<linux-mips@vger.kernel.org>, <linux-s390@vger.kernel.org>,
	<sparclinux@vger.kernel.org>, <nvdimm@lists.linux.dev>,
	<linux-cxl@vger.kernel.org>, <linux-mm@kvack.org>, <ntfs3@lists.linux.dev>,
	<kexec@lists.infradead.org>, <kasan-dev@googlegroups.com>, Jason Gunthorpe
	<jgg@nvidia.com>
References: <cover.1757534913.git.lorenzo.stoakes@oracle.com>
 <d85cc08dd7c5f0a4d5a3c5a5a1b75556461392a1.1757534913.git.lorenzo.stoakes@oracle.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <d85cc08dd7c5f0a4d5a3c5a5a1b75556461392a1.1757534913.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR05CA0016.namprd05.prod.outlook.com
 (2603:10b6:303:2b::21) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA2PR11MB5035:EE_
X-MS-Office365-Filtering-Correlation-Id: 104ed724-b80f-487b-4edc-08ddf17f97a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eDM4VnBna1g3SjJRb00wdjJNN3haRzlDaHhNc1VEMUhZNWZOb0IxRERDM09K?=
 =?utf-8?B?NVlVRnVlNXlzYTZsUnBoZzFkRUszSTdRRWNKaFQyK0h3QUdjblZNUlcvNEZl?=
 =?utf-8?B?UFZYZ3g1WTVIWkNuNjFiN05sWHVhUWNQNTI3UUxxbUViUWlXRUdTdHJRNlZh?=
 =?utf-8?B?aW9ybE1RYTlEZGVKa3dyQjJPUVJVajFUeGdzK202a2o3SWt5NFZaR3drS2x6?=
 =?utf-8?B?c0JsSTBTNzA1a21SZFdrYzNWdFk3NDFiUWovVVgxTjRHRkh5WU5ubkxKbXNv?=
 =?utf-8?B?aWIzTFg0bWVqRFVzSmRpQTNKdVI5UlJoTVBwcWxlQk10TVVHRUFNTituUzR4?=
 =?utf-8?B?N2dFZ1VQOVFVWVN6amdVYllnVHFFU1RFUS9lN0dyQmxOenR1UW02THhPNnV3?=
 =?utf-8?B?SmxBWjFDbHhtMmk5aG51SCtZYzFvOVhYd3JlUnJFQkk1LzRiSVJpZmtDeDJQ?=
 =?utf-8?B?NGlLSzdUbDMvYkxNR3RBbXE2ZmU2c1U2U0U4Tk4rWW1nSkk5RzZPWjBiUjlJ?=
 =?utf-8?B?UnBGYkRKWXdRbEErOUZ2QVE0U2sza1BZZzdScVpaV0NocUw1b3BzOUN5TEJa?=
 =?utf-8?B?K0cwWkFDZWRRRVVUdlVIb3VnY2Fzc0liWDVlck02dWJNWHdnamlRbnBySm5P?=
 =?utf-8?B?dE01YlloUXBOM2xYa20yVytxUUR6REhmY2ZkQkg3bXdIZFc4RTdDNE10UGZk?=
 =?utf-8?B?S0RabHI5L2djN3R2ZFB4RmF6VEVkMlBsa2gyK3F0czhUaGNiVDlpNnpKUW9n?=
 =?utf-8?B?Z0lYdUNsOHEzVTZMVGZ2U2NtUHdybWlZTzRDMEtSY1U3UUZnQW4vemhFVnJO?=
 =?utf-8?B?NzJOcGxOODVUc2dZTGxZdUhOOS8xaXRqK2pSMXFMOU9ZdlEyc3dkdVBwZjdO?=
 =?utf-8?B?VnZLK2h1WVBUZWlOYU5BMlgrVUQrYis0dXRNQmpzNE80czdVRUszLytOcDV3?=
 =?utf-8?B?UFdTQm9UL0JsbTZIay9vdEhvc3FTaXhSb1BINUpYQmxxL0dHLzl2eEU4WjNa?=
 =?utf-8?B?em05ZWJaL3A0T3NGNHhhZnNMZWhlTTZYbzVKRE4xSStvT3N0RTY0NU9HMFNE?=
 =?utf-8?B?NW1MUXM4MDVvM0FIMjd2YUt5ZWtVRFd4aVQ3bWJkTyswYXNjRk0zZHV3b1hB?=
 =?utf-8?B?UlF1YzZPbjFmZFo4N29kN2UzMDVCcGZoY0FUQ204WnBTNkg0RE1zR0libk0r?=
 =?utf-8?B?NXdyb3FkbkdUYk50aGYvU0ZJK3FpRkVsMlZETEhGUE5HUEw5K0JsS3dVSmpp?=
 =?utf-8?B?TnJ4cTdTbDZ3T01EQUI4cEpWeFVTYWtzOE1aUlFJMGpSOE9iV1pEdnZCSDl0?=
 =?utf-8?B?M1dtNXJWVUJwcU9CUUpabXNEK3VSbWJ3T3ZzbnIzQ3JIbDY0alR1S3lLeWsv?=
 =?utf-8?B?ZWhkdis1QUhMRTZPbi9KMWxkNXNmcFVXWUNEWFQxNzk2Y1ZZUXR4UExCbEls?=
 =?utf-8?B?WVQ2ZGJnRERDaVdtaG9LbGxJaXZjSkppQ3VlUnZzZnlickRVQVRyUEJyS01M?=
 =?utf-8?B?UVNVcnhKaUlNOTUyYllLZnFSNmRMOU5kMU1Iem5XVmNDakhPbm8rbDIxazJF?=
 =?utf-8?B?T0N6M3kzK2FFVzFxKyt5OGFOUjlKNUJXaFRJcXlGS0lGeGN1Slc2dHF2anJF?=
 =?utf-8?B?b0VwWEpZUnlUUDNXNjBUS094WTUzUE5aM3FmUUFtNllzZ1p6YjBXUHBBMkQv?=
 =?utf-8?B?RkhOSHlMSkdVMVQ0RzdmZzhJUFgxellQRGFSTll0NHRaTm1IS3pPYjROK1Rs?=
 =?utf-8?B?ZTRIRktwMDhDV1ROUlNlUDEyZzhObFEwak1XeFdGUDlNZVhJTUtEaDBUUGgw?=
 =?utf-8?B?QWI3S1FRbE5PQy9LNFVsOWpvU3pqMk9iRXd3aWxobS96VXViQjNhZkRzVHBF?=
 =?utf-8?B?UWE4SGJMcVBjbGtsTitRVTBmZTdJUmRLWEQxUHI1VWIxcEtHUzB4V1E3WHNz?=
 =?utf-8?Q?EKmVJ1TaePc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGVUZWYxa1pQYTZpeElDYmU5aVVFdC9uT3JwT3ZadnpIc0RZWm1hZUwxZ2I5?=
 =?utf-8?B?TndzaG1pQ2d0WTJCOTd5VlpzdEI1aXhJaU9yV3dPdUhwcDNIelRWd2ZqVmZt?=
 =?utf-8?B?bW9DRFNmL1drR2lBWms0c1BTdHlwYTdTdnBQVDZNbm82eUxuRjFyR2wxbWl4?=
 =?utf-8?B?ZitYTHhCOFFNWlVWMWFnUlpFZXJsSloyWnVvN3d5TXczY0hFZy9nL1hybEww?=
 =?utf-8?B?T09UcmwwTUM3bVE3MFZYZnRCNEx5dmgrbTVvMHZiTlhoK1BNb3llYVdnYS9B?=
 =?utf-8?B?Q0dydDN6QTRKelZwMDkvTEdJWW1YbnBpdGh2SUttNGZJeWdZbVRQcWI3Qm1h?=
 =?utf-8?B?bEJyWjFmNHh6VHU1R0l2QmNjMUJGQjg3S1R1aEV5MzNxd1IrS29Rd1JGMFhT?=
 =?utf-8?B?cmVlS0xqZndzbWxzSDBtSk1BanJBOUppY2oyWGpjR2F4SWNjZk5RZjBYaXBp?=
 =?utf-8?B?dXNzZGxFN3liamZSOEhzNkh2eElDOGJDRUJJYW1TV3V1TEVsWkgxSHRLWjdW?=
 =?utf-8?B?YjhhcGhReGZ4ZXlkMGwzZ0J5a1l5WDF6WmxHSzFCeWFqUUFQbU9RTzdHQXdV?=
 =?utf-8?B?cmJCSXVTUGlYZ29IQ21rTUJTbHFQREt1WGpHZUEvQzEwVHRtKzRHdkhVVG84?=
 =?utf-8?B?MjZZWTI1bmdCUFNpOWpZM1A5cHFTYktUcUNJa3J5Ni9BODh6bkliZDBodEsw?=
 =?utf-8?B?SnZPSGRRSVgvQVM0V0FaYzgrMWVtakJ2VFU2WFNkUExuRXRSQmFIdmc1VFdL?=
 =?utf-8?B?MENJdC8xQllRNFZkMHhiaXlEVTd1U3F3R2ZXeFFFbyt5OUIyUDBsekZObDdx?=
 =?utf-8?B?UWhYSUw0cGdmWGk3NTFJbnkrSXcrb0hsOG5VUmsxbFVGNTAxNnZnZEZIVWJk?=
 =?utf-8?B?TktFT2FUZnFKSC9OemhSV1cwQmlpeWJsb0dBbExnVy9OR3VGWktsbE5GWUM4?=
 =?utf-8?B?Q2M2dGtFWGZTLzIyZXduaHdsRGlKZGl2WGpTdEVuNDlGNk1RaGZCUFVPcDg0?=
 =?utf-8?B?YjJQbW9TWVFkVnVJdHFnNUNRL1pBWFoyWHJmOWZ0dXNsQm1nSnhFOGZIK2tz?=
 =?utf-8?B?TUlpdDQ3Qmc0M25IZXpxZ0toejh4MDMxSXE0bktBcEZ6bDBnUXFaMS9POEE3?=
 =?utf-8?B?bXgwTkZVYlJYUFI1Yzk4bHRjNktreGUzTHhWcllQQ1g4Q3hBVU53V05jRnE5?=
 =?utf-8?B?VFRXbVZPZTY2VlFsa1g3d3ZnYVpJQWE4SHhEY0ZxWTNzSmwvK3kvMndVVXJH?=
 =?utf-8?B?NEgyQ1dWYWlXU0gxOVQwYmhPNmRaWXdmQ3NWaUNlbEN2MnpsNTdQYStVckxX?=
 =?utf-8?B?bHdudU5lTlhyVDhsQm5VTkduNEE2VHVNUkp2SkpDQk9QZThiYzg5UHZNM2tk?=
 =?utf-8?B?RGpXMzdxT0doR2V6ZW05cHRNUVVrdzdwdDVjUWFWRytva2hyMjNxUlk2R3dh?=
 =?utf-8?B?ODlydXVLSmlVVmIxU01iSXZXaXcxK3MvZnJtb3ZaQWRHMWIrTnpJdys3UE5m?=
 =?utf-8?B?UGtIVmZqN0E3QVF4YlpZeFpKNzVWcFFWNDhuMlJ5UmFPR1ovbUxYNEpveUlR?=
 =?utf-8?B?eGphS1A0WGFVSUxoQVJCTEE0MEordENyM0oyUTBLK2hIMm55bEN4WTc3WW5G?=
 =?utf-8?B?VS94b3NoMWkzNlpNd2RNSzRkQWNDVVFVTnBHUHVjbDJlaFdITW1jeWJySVpo?=
 =?utf-8?B?TXcrbTFWa3Y3UVJTOW9XODBSTzExazFUOGZzaFBnQUtIVTcraFc1Sys3K3VH?=
 =?utf-8?B?cWc1WEVlcSs1eE55azdzTnBXYmJxZlRsZFZXaGU3aEY0aHg5aE5BUTZndnFB?=
 =?utf-8?B?VUpOeU1TMVBOTEVGcXJKNk5NRzMza1BpQWJmYnlXazVQNjBqOFdTWUJqTWl5?=
 =?utf-8?B?dHJmZ1YxMXc4d2I0WlphSWxzU0c1RVdnRDFkNzE2RSs5Y0VjTlV1ZFdMRmRU?=
 =?utf-8?B?QUR2SFZ1NkpLWlFzSVNhQThCL0Q1S1Nhdzd1REd6bUVHNHVId1FESWRUdk1F?=
 =?utf-8?B?VGQvYnR3SXdJRkRHWTR3VXpJYktFTkRHSUl0TE4wcm5qWTBET1owOEFLOXMz?=
 =?utf-8?B?MGxQaWkzd0lNOXI1WG9vNU91OFZLdHZ1V1RVR1dNUzUzWXVkV0xlSm5pQjVl?=
 =?utf-8?B?WXI4dHVOSXdRN25rNHBLZ3g3ayt6SXkxZytpOXRxdU5pNzJya0pTTmoxSC9T?=
 =?utf-8?B?VFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 104ed724-b80f-487b-4edc-08ddf17f97a2
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 22:07:26.5698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MBxoLnLomYseB9mjG3m6U94rsNPsKwzmOs4mn79Mk++qLduFtEp+EQJ789YL7nPnhG10yna7KpqGmrq2df+lNJ2pl05FoIG9mVAKX7d+d28=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5035
X-OriginatorOrg: intel.com

Hi Lorenzo,

On 9/10/25 1:22 PM, Lorenzo Stoakes wrote:

...

> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 4a441f78340d..ae6c7a0a18a7 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -770,6 +770,64 @@ struct pfnmap_track_ctx {
>  };
>  #endif
>  
> +/* What action should be taken after an .mmap_prepare call is complete? */
> +enum mmap_action_type {
> +	MMAP_NOTHING,		 /* Mapping is complete, no further action. */
> +	MMAP_REMAP_PFN,		 /* Remap PFN range based on desc->remap. */
> +	MMAP_INSERT_MIXED,	 /* Mixed map based on desc->mixedmap. */
> +	MMAP_INSERT_MIXED_PAGES, /* Mixed map based on desc->mixedmap_pages. */
> +	MMAP_CUSTOM_ACTION,	 /* User-provided hook. */
> +};
> +
> +struct mmap_action {
> +	union {
> +		/* Remap range. */
> +		struct {
> +			unsigned long addr;
> +			unsigned long pfn;
> +			unsigned long size;
> +			pgprot_t pgprot;
> +		} remap;
> +		/* Insert mixed map. */
> +		struct {
> +			unsigned long addr;
> +			unsigned long pfn;
> +			unsigned long num_pages;
> +		} mixedmap;
> +		/* Insert specific mixed map pages. */
> +		struct {
> +			unsigned long addr;
> +			struct page **pages;
> +			unsigned long num_pages;
> +			/* kfree pages on completion? */
> +			bool kfree_pages :1;
> +		} mixedmap_pages;
> +		struct {
> +			int (*action_hook)(struct vm_area_struct *vma);
> +		} custom;
> +	};
> +	enum mmap_action_type type;
> +
> +	/*
> +	 * If specified, this hook is invoked after the selected action has been
> +	 * successfully completed. Not that the VMA write lock still held.

A typo that may trip tired eyes: Not -> Note ? (perhaps also "is still held"?)
(also in the duplicate changes to tools/testing/vma/vma_internal.h)

> +	 *
> +	 * The absolute minimum ought to be done here.
> +	 *
> +	 * Returns 0 on success, or an error code.
> +	 */
> +	int (*success_hook)(struct vm_area_struct *vma);
> +
> +	/*
> +	 * If specified, this hook is invoked when an error occurred when
> +	 * attempting the selection action.
> +	 *
> +	 * The hook can return an error code in order to filter the error, but
> +	 * it is not valid to clear the error here.
> +	 */
> +	int (*error_hook)(int err);
> +};

Reinette



