Return-Path: <linux-fsdevel+bounces-71682-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 46744CCD097
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 18:55:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 12C1C3053FFF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 17:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29E72EACEF;
	Thu, 18 Dec 2025 17:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AcLEwwX6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0042C21FC;
	Thu, 18 Dec 2025 17:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766080376; cv=fail; b=JWJJDWzG1kP70k3vN6Gt0nHjVF+yX0LWfZLmoKDNTg3X7fW6RwWo2xpGycvqvE5pivE3WrCSzN9Aai7nsCnG0AWS64dX3oFghOPwBmGtBaW7IHcQkTL5SnFXtw/tLdB5rRUs7IySdvzj4o+3toop+eHRaAPQEH34rxj8ZjvUjI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766080376; c=relaxed/simple;
	bh=Zu52ZR/nZ73/YDHGQJAnsEiRcn5SgH4mVPB1bZGteYw=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=WOuw4zxH4W0xTBvoaD43Ca2oLk9gG9/+hhB2pg1oj/nohdJMaXCP8a3WYrdtYBGVyo5ymV+QH27JNSWenQXoMGd6Jgghrxruizj0n4/71zetYGjokzAzOxTEteTysNgoOP5O6LUXg+OWiv1/9sdhZL4cOfpDlg1JPZ5ohXn2pxI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AcLEwwX6; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766080374; x=1797616374;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=Zu52ZR/nZ73/YDHGQJAnsEiRcn5SgH4mVPB1bZGteYw=;
  b=AcLEwwX6eBg5QwW3B9dWqdgjmBnwy6QGSP86vj/PgW4r6eweDZan3mEF
   hqnRR+0drOkGLLgI4je8Ok4ClHCsnPsGAstuR8uq3rhTx83OvakH8XbzD
   VPbAyrlp7V+oqDi5CYiOrS9SJVuSbF3C0hodrrJhJ8Z7TYjTTs6LKXfx7
   DDkEps2XN0PLSJ4Z/h6rDs0wGg0Y3IV1rsCLEnRX6zGI3tP2vwpKFieOb
   IOvDIZ6BnXoGb2oK1idnmWZybfQ4hZSc4J+x7yuQqL9gIlozGpByzB7mC
   Mx/0DMdQ8DhX00JQ8u9zZ/Umle0M43ocia5MJ4roP7j4amnbefn53Jjb0
   Q==;
X-CSE-ConnectionGUID: TnPcry07QcuOO3Mbs1XnmQ==
X-CSE-MsgGUID: TtV5pGSDTAOCCDTAq5rQkg==
X-IronPort-AV: E=McAfee;i="6800,10657,11646"; a="67036544"
X-IronPort-AV: E=Sophos;i="6.21,159,1763452800"; 
   d="scan'208";a="67036544"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2025 09:52:53 -0800
X-CSE-ConnectionGUID: GF/Qw+YWQwKNukpgIQ0uqA==
X-CSE-MsgGUID: 8ONfA4smS8OOl2MvV+9AWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,159,1763452800"; 
   d="scan'208";a="203549209"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2025 09:52:53 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 18 Dec 2025 09:52:52 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 18 Dec 2025 09:52:52 -0800
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.39) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 18 Dec 2025 09:52:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kKrK5kJGaFObC2zKoeg3OFQnct/yABpAmW2Hmy4oxXs07bXB5fSWqRplIy4r/QTDA89klIPKzv0AhJ/g/mP5EoS/HeVXrZunGIa/cMegX1ireSRuOrlJCr4BkRRenOgfBNTge1OGTPV+Zub6aD//oS46iDw6GK5CzmiFU911MmX4+H58KHKfyYggmYg3wV5hU7PfIRqyxqmlF++dbUKF9AP9js1AuGj4X47fbQ+XMerX7pNzANUgqPj4OA5LNpSFjItYOdGJXh1cKbe4WoplYIhWo0PrcclCEDjbuxblIE2wlmWKxC3c5DJ8BNJNqpNSNvePf2pnpX8U5tSfa5rjqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bzyprGw3bJh1HvEu4zyr6k5rUCcVdakmxFxn2gs47Ik=;
 b=lSCwkzXxxnmOHmrbODwF0OHYRmrbfekxRGEiz/2DKu87oL5RLt8pYYyvGkOU9Y//Odk8NuqRjwb5NUcCOVnxR3e0iw5MiG7t0FkMv26oFsrUGj5hKhCraVDk7WXe14HdzVSE5vyhdmI6JEi9x+uemZMl3vkdT/F3aj3EYRj0ydo675ieXUMWON37bMzl4n+4LuzvwdDCwo+BgCr2ZBEO3CJhd+HpNpT9CnoiQ5bMhd6xT8YwJ+JzME6qBO2Fgt5Jdl/Sf7YZLSHNCr298XcZLBGwg+KRV8ABlM6TCaIn9NBpcmM3mOTGQ4z1S+G7Iw47ym1zhAL0zu+C+4EGGXInBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ0PR11MB5005.namprd11.prod.outlook.com (2603:10b6:a03:2d3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.8; Thu, 18 Dec
 2025 17:52:50 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%4]) with mapi id 15.20.9434.001; Thu, 18 Dec 2025
 17:52:50 +0000
From: <dan.j.williams@intel.com>
Date: Thu, 18 Dec 2025 09:52:48 -0800
To: Borislav Petkov <bp@alien8.de>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<nvdimm@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, Davidlohr Bueso <dave@stgolabs.net>, "Jonathan
 Cameron" <jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Matthew Wilcox <willy@infradead.org>, Jan Kara
	<jack@suse.cz>, "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown
	<len.brown@intel.com>, Pavel Machek <pavel@kernel.org>, Li Ming
	<ming.li@zohomail.com>, Jeff Johnson <jeff.johnson@oss.qualcomm.com>, "Ying
 Huang" <huang.ying.caritas@gmail.com>, Yao Xingtao <yaoxt.fnst@fujitsu.com>,
	Peter Zijlstra <peterz@infradead.org>, Greg KH <gregkh@linuxfoundation.org>,
	Nathan Fontenot <nathan.fontenot@amd.com>, Terry Bowman
	<terry.bowman@amd.com>, Robert Richter <rrichter@amd.com>, Benjamin Cheatham
	<benjamin.cheatham@amd.com>, PradeepVineshReddy Kodamati
	<PradeepVineshReddy.Kodamati@amd.com>, Zhijian Li <lizhijian@fujitsu.com>
Message-ID: <69443f707b025_1cee10022@dwillia2-mobl4.notmuch>
In-Reply-To: <20250909161210.GBaMBR2rN8h6eT9JHe@fat_crate.local>
References: <20250822034202.26896-1-Smita.KoralahalliChannabasappa@amd.com>
 <20250822034202.26896-2-Smita.KoralahalliChannabasappa@amd.com>
 <20250909161210.GBaMBR2rN8h6eT9JHe@fat_crate.local>
Subject: Re: [PATCH 1/6] dax/hmem, e820, resource: Defer Soft Reserved
 registration until hmem is ready
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0030.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::35) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ0PR11MB5005:EE_
X-MS-Office365-Filtering-Correlation-Id: 839939bf-094a-4955-f428-08de3e5e427a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZUdoSWxPckZyaFpZUU1qb2lEM2RvR0UxeFMvNndEQW9raGJBM1hZQ3BOMS9T?=
 =?utf-8?B?VmZOU2J2WEhIdGZpSmhUR2hSblJwOUpoNnZwcWhzaGVubVEzMExPNWtLWHov?=
 =?utf-8?B?cElGaEVSMnY2SllzdG5UTGlQUlZMNFpjQzJwTURDS05CSzVCWUs2ckwwTzIy?=
 =?utf-8?B?OVZKZ1JDK3krUm5NYWZ3bGsvLzBZbUZFaDlQUUZDKys4QjVLT3QwcnM3WVBH?=
 =?utf-8?B?RlRoMU1rc2t6Y0xPTHh0SW40N1J4L0c4M2ZjY010aEpKczdud0lwUnpFTFpz?=
 =?utf-8?B?eE9Ia1cxK0l6ZGd0bTVSR2R0ZktxWllBeGxGK0k4eGlnbDJCTThqVmw1ZVlU?=
 =?utf-8?B?TmsvK3JtOXBLYURGaG9uUG1FeXlwS2VlMjVYKzlqdDA5bktxUnBiUTBsc2Vn?=
 =?utf-8?B?Yi8yQndwVGdEVXJWNEI5c21KSk1rUGU0WURvM0xia3o0OFlRdHRsbmx5elkv?=
 =?utf-8?B?Ymd4VXpMeVVOVWJiamM0RkE4OWl4MGlWVzVMZjdydVhjV212WnN4Snp0cWYw?=
 =?utf-8?B?aDd0ak1WYy9LWGJJVTZDY2JBSWVyVzdJaDl2WEpuT1RTNlc3dGY5OGZnWDlj?=
 =?utf-8?B?YldGMElZMlhFRHhvbVVuekFpamJEelI2Und2TEdkc24weGVOMkN1Z2tnak8x?=
 =?utf-8?B?TXRWM3lEYW4wZTd4cVNTK1Z3bFc4R2g2TkNTV3c5WEJGRjFXM0JIbkt1NTdW?=
 =?utf-8?B?SjMvRGlwQ2JXS0FRQnRHRldZRlVRWnJZZTBvZERGMDdEMmRSVHdTTjdJdTdU?=
 =?utf-8?B?ekk4c3JFQUNnUDhwOGg0eDh2ck84MGFLWHFVeXdNbDFXd2Eza0Noam53M2Rn?=
 =?utf-8?B?Zi9CM3ROd1U0RGE4T3UvVlVzQzNSa3RCYTcwbTNFZy9QT2YvMTZESU5Yanhp?=
 =?utf-8?B?aUtoQUJVYm5NV0tQRGUvQTRsN1ZwRE5UbURLSStmbE9icVowb1NRTzhCaEJs?=
 =?utf-8?B?dzlPSTViTHFvNlREdHpqZmpqa3Z1bEZBYlpZOFE0STBHVUR1K2QzRUFWRTVD?=
 =?utf-8?B?aDVDVXV5bkl2WTFlbXl5bVFrRlAxNEZLSjRqSU1VYTd5eDJPQzRuaUEwRFMw?=
 =?utf-8?B?YTZlUmkzU3h3VU8yWDM1ZHFFVGl2dFF3VEExNHgvWWdXK1FpaXg0WXAraFVy?=
 =?utf-8?B?TWNOSnNDYkVwV1J1U3FZRUtDMmZJc0xoL25xeml4S0FLSHBnb01zL0MxMlk4?=
 =?utf-8?B?V2FibW45dkRqVi9VNVdHb2lxSXIyQjFtdEwrbkg3OUYrT0Q4aUxiREV5YzBW?=
 =?utf-8?B?bG8vSjlsY2lFeDdHcHZ6SldmTGpuU0RxT2pmQVlYOGpleVpCT3p6MEhqTVAz?=
 =?utf-8?B?VDdsWTMwaEhnc3BCTll2K0wrK3VFS2xnY3A5YytXQ1dTdENjdHZIUmF2b3VO?=
 =?utf-8?B?anc3d24zOUEvYVhDbGxJL3N6TTZManRIY2pSVTRaOE5hSnVKUVVpTUYrMUR1?=
 =?utf-8?B?aGoxbkkxditkREFQc0U4dXM3Yms4NmcxRmtBU2hVTmxqeDNwUVZiNElTaVk3?=
 =?utf-8?B?a1FFZUhlNGlRbUNHTnhKc0xlZDFxM0M4Y0ZBYTFnWmRHaVVWTnhKMjlIN01T?=
 =?utf-8?B?eTU5WE1Fck0wbW1ncDVkNkV6TG53S21MK0Y5NjBpQjJFU0U2M3lSMDFSa1ZC?=
 =?utf-8?B?QlhsYkhkaVpndUNhYmFhUTBQQ3Jsbm1DaTFicE9RaXRsMm5HSk5LMEI0WkZ4?=
 =?utf-8?B?MUlmL0FzWkJtYm1pQXJiNDA2aVpSa0JNVVkzSGVBcUl6RTNRSXNlK0JHQ2t3?=
 =?utf-8?B?VmFsdmhaYXUxaC8wbFdsUjVscXl5d3M4WXdLclM0empVY1dPZGNmaUtHeHJL?=
 =?utf-8?B?VnNsaDJ3WklQSlFzK3RXVXhDdFlFdUQycUFhd1pUT2d0S2JhQWo4emNlS0JP?=
 =?utf-8?B?bitJWDRFUHd2eUVwaldxUXhsMm5PWkcxR3RQRHFuZXp4WGlnNTdIZUJyaWlK?=
 =?utf-8?B?aEJ1alA3d1VaQng5WGRHTFhpcElXdXpSeWNBUkZWQStsdDlpbjNHYld5bGxm?=
 =?utf-8?B?SGhybWErSmN3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0ZabGh5ZnVTL3Q1TGVTSzJtWktHWVgrNkZoaWFFL2NWaEgrdG4wYWRzWmRy?=
 =?utf-8?B?MzJXME0zWVprYk9LOWVvUUpUNkVyaVF0Z0lvWmJ4ZnlzeVlNWHJxVFhncHFP?=
 =?utf-8?B?Rk9VWWpIMzZid3IrUUxHejE2YWQ3R05tNGQzTmhYeXFaaWJBaDBpb2ZRK0do?=
 =?utf-8?B?aVV5R1piUTJZblhyK2FyQ1A0N0xVc0lXNTB4dy9UdThNbVZvN3B4NlNiYWxY?=
 =?utf-8?B?M25WTGx1aWN0Y0VqcHFCRG9OT2hydDlsZWN0Rkk1VEwzYk9mWnB5ZUMxN1Ra?=
 =?utf-8?B?L0dBMERFSmJhS2ZpRjk3My9mUkFaYUxZSUhyaElyR09VTmN5Z0VWSFdDNE9a?=
 =?utf-8?B?N3lIUFcwb1ZMbzE4UjRhWExjNjNDOWVKZ3FuZEpNTWR5YzYyR1h2K3RxbllH?=
 =?utf-8?B?NXkza3JnUUdUUlRYOEFBNVBuV0dGNlZObjY5aytFVEZyUFRiczhWbUhVVERU?=
 =?utf-8?B?TTE2RFFNK1Rucm1XOS84a2pSMVdhYnQ5UHNIVmxmcndVTVVmczc4YUlLRCt2?=
 =?utf-8?B?ZmJhcUJnYXBaY0pCQnlWUUpjbis1VTZlV1FUUGtTMzlVaVdFbG91UkcrZ2Vi?=
 =?utf-8?B?Z0JHNW5KK29iOUFEdjBETUZuZUVTczFNVjlxdnFnMkFIbXlYNDZuQStzZi9V?=
 =?utf-8?B?aGxsVmliMlgxdVVhLzFtVUcxR1BUay9EVU5IWHI5OVVwVGh0YTlJYTJmbmMv?=
 =?utf-8?B?eUJhc21wVnVjcnVydDdEYkpUUWhyY2ZtY1ZmMHo5WG14NHJINTlGNkZuSW1s?=
 =?utf-8?B?NHZzQkYzdjZoSCtWQW5ZR1B4ekthUEthSm9TaVA1NE5qTVZEeEJmRkh0K0xM?=
 =?utf-8?B?TnhFbG1zRk5uanY4SGFJTTVoYm52WHZJTEZUL0lVMk9mQm5qYXFGbUpFeS9X?=
 =?utf-8?B?cU5ic3JpQlM0ejlmaFlpb1NPbTRMNWJOMGpvU2J5eHNJRHh5K1AreWhybytC?=
 =?utf-8?B?N1VkY2ZWMTBZdGNDb0FyajdhT3g1VGNKdjlUdjRTS28reHV2T2tWTFljNGtw?=
 =?utf-8?B?eVJzZXdQeDZSeTRNeVhhSE9kWHBkNmMwdXd1V2YxQk5CZ0VPMGc3T0JqMThU?=
 =?utf-8?B?YmhrS1JPOUN3Y25nZGNEMFFPMWhpNnc1dVlqQzRjSkw0UHZxdG56ZDhhTVFh?=
 =?utf-8?B?U092VW90V3pXN1FoM1NEcXJqckluYVdWYlV1ekk1aFhGcDFIT1p4TCtHclEv?=
 =?utf-8?B?c1lXSHpCdWp1emlHTktVRFhrSkk0cERySC9SM0JseXFwTndrUEpOTUZlTmpk?=
 =?utf-8?B?eFM2SXNoN3NDN3BQNmM4RENBekxnbXZvcmkzdlFYN1hkZWcvMkpZVGM4Szhn?=
 =?utf-8?B?TU5Ca1ViNERBNVI2elluTlRXbk11SzMwZjZyZThUeGk4NUdRR1ZKZTZyVXVW?=
 =?utf-8?B?dStoR2lqVFhEclk1dklhQTAvQ0tDN0Q3Rkx0Z3lwRmZ0bm9COTVkSEpmM21O?=
 =?utf-8?B?eW1hbDFtYjlUZmJzcVN5ZnhDSzZKdng3a2ZXZzdzMVNDTUhoV095V2NFTm5Z?=
 =?utf-8?B?VU1PU3ZLS1FwdjRXZVZHd05BQkZPR28xdnBFUEhKTUJoeU9Qc1F2TGQzdVk2?=
 =?utf-8?B?THJNb2dWK2MveVoxU1hzMU50eXhkck9aMkFSTXVZcVR1NlUyczF4ZkxOTEY3?=
 =?utf-8?B?OFRNUUg1ZVQ0Snk1dWdRQnFlRkFhQUlYOS9BMmNEU3ppcTRqQ2h6K0FuMHVy?=
 =?utf-8?B?MmwzVHRLamdKSktFNVBvQmlNWnhyNzhNZzJ0YTVDaVNLUlphNjZwWEhBb1p6?=
 =?utf-8?B?cUJaT3l4dWloRjZJZzdEODJPMUQvSlVsVi9vNGZJVjc3Q2hqS0tZOHhmQzRr?=
 =?utf-8?B?S0w1RHBweHJCNWx1QWp4bjN5TFdhNERQVHhXUDYvRy80U1ZGOXNhZy81SnUv?=
 =?utf-8?B?RFdZRHQ2aSs1SlFMQklxTG43YlpsSUpxZGNjMTdRdmVOMkdjaDAxN2UyakYy?=
 =?utf-8?B?Y0dScUtFc3Fvc0Q4OUxkd3RjbFRwWWY3T2MrRDZtN2JpZG1qNUEyWnY4UGZ4?=
 =?utf-8?B?dTdtdXFZMDhnYW5xTTVBSzF5WmxZTWdySzRpQ3hRVDdoanRxZzJMdW12MSt3?=
 =?utf-8?B?U1ZEa1AvV0lkdDE1M2dJZzBKY09yMG9zNWtIckhiNTYrVVlKblVMN0hha1dY?=
 =?utf-8?B?WE5Bc2Erb0ZxL1EyTk1qMFZSS1Z0SmRXU00vR3lOdHlyME11QjJnL211MUc2?=
 =?utf-8?B?UWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 839939bf-094a-4955-f428-08de3e5e427a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2025 17:52:50.1830
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0lSCgCm76eDaQsXNZuZbvk6bri/Yc+boMeGQu0WSwbhB6NK+lFoiPuQvIn4+bYQgpk2a9OaFio5TTQEarKkAJwAjjn8s/0rcrsNR/HBuQ0M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5005
X-OriginatorOrg: intel.com

Borislav Petkov wrote:
[..]
> Also, I'd do this resource insertion a bit differently:
> 
> insert_resource_expand_to_fit(struct resource *new)
> {
> 	struct resource *root = &iomem_resource;
> 
> 	if (new->desc == IORES_DESC_SOFT_RESERVED)
> 		root = &soft_reserve_resource;
> 
> 	return __insert_resource_expand_to_fit(root, new);
> }
> 
> and rename the current insert_resource_expand_to_fit() to the __ variant.
> 
> It looks like you want to intercept all callers of
> insert_resource_expand_to_fit() instead of defining a separate set which works
> on the soft-reserve thing.

Finally catching up with this feedback after a few months. In the latest
code from Smita [1] this has become:

void insert_resource_expand_to_fit(struct resource *new)
{
       struct resource *root = &iomem_resource;

#ifdef CONFIG_EFI_SOFT_RESERVE
       if (new->desc == IORES_DESC_SOFT_RESERVED)
               root = &soft_reserve_resource;
#endif

       __insert_resource_expand_to_fit(root, new);
}

[1]: http://lore.kernel.org/20251120031925.87762-1-Smita.KoralahalliChannabasappa@amd.com

I am uncomfortable with insert_resource_expand_to_fit() having
build-conditional semantics. However, I agree with you that my initial
wrapping attempt with insert_resource_late() was not much better.

When someone revisits this code in 10 years I doubt they understand what
this redirect is doing. So, make the deferral explicit, open-coded, and
with some commentary in the only function where the distinction matters,
e820__reserve_resources_late().

Proposed incremental on top of v4 rebased to v6.19-rc1 that also
unconditionally defines 'soft_reserve_resource', drops some redundant
arguments to helper functions, and sprinkles more commentary about this
mechanism.

I will go ahead and pull this into the for-7.0/cxl-init topic branch.
Holler if any of this looks broken.

-- 8< --
diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index 61bf47553f0e..95662b2fb458 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -232,6 +232,7 @@ struct resource_constraint {
 /* PC/ISA/whatever - the normal PC address spaces: IO and memory */
 extern struct resource ioport_resource;
 extern struct resource iomem_resource;
+extern struct resource soft_reserve_resource;
 
 extern struct resource *request_resource_conflict(struct resource *root, struct resource *new);
 extern int request_resource(struct resource *root, struct resource *new);
@@ -242,8 +243,7 @@ extern void reserve_region_with_split(struct resource *root,
 			     const char *name);
 extern struct resource *insert_resource_conflict(struct resource *parent, struct resource *new);
 extern int insert_resource(struct resource *parent, struct resource *new);
-extern void __insert_resource_expand_to_fit(struct resource *root, struct resource *new);
-extern void insert_resource_expand_to_fit(struct resource *new);
+extern void insert_resource_expand_to_fit(struct resource *root, struct resource *new);
 extern int remove_resource(struct resource *old);
 extern void arch_remove_reservations(struct resource *avail);
 extern int allocate_resource(struct resource *root, struct resource *new,
@@ -419,13 +419,10 @@ walk_system_ram_res_rev(u64 start, u64 end, void *arg,
 extern int
 walk_iomem_res_desc(unsigned long desc, unsigned long flags, u64 start, u64 end,
 		    void *arg, int (*func)(struct resource *, void *));
+extern int walk_soft_reserve_res(u64 start, u64 end, void *arg,
+				 int (*func)(struct resource *, void *));
 extern int
-walk_soft_reserve_res_desc(unsigned long desc, unsigned long flags,
-			   u64 start, u64 end, void *arg,
-			   int (*func)(struct resource *, void *));
-extern int
-region_intersects_soft_reserve(resource_size_t start, size_t size,
-			       unsigned long flags, unsigned long desc);
+region_intersects_soft_reserve(resource_size_t start, size_t size);
 
 struct resource *devm_request_free_mem_region(struct device *dev,
 		struct resource *base, unsigned long size);
diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index 0df7d9bacf82..69c050f50e18 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -1151,11 +1151,18 @@ void __init e820__reserve_resources_late(void)
 	int i;
 	struct resource *res;
 
-	res = e820_res;
-	for (i = 0; i < e820_table->nr_entries; i++) {
-		if (!res->parent && res->end)
-			insert_resource_expand_to_fit(res);
-		res++;
+	for (i = 0, res = e820_res; i < e820_table->nr_entries; i++, res++) {
+		/* skip added or uninitialized resources */
+		if (res->parent || !res->end)
+			continue;
+
+		/* set aside soft-reserved resources for driver consideration */
+		if (res->desc == IORES_DESC_SOFT_RESERVED) {
+			insert_resource_expand_to_fit(&soft_reserve_resource, res);
+		} else {
+			/* publish the rest immediately */
+			insert_resource_expand_to_fit(&iomem_resource, res);
+		}
 	}
 
 	/*
diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index e4a07fb4f5b2..77ac940e3013 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -856,7 +856,7 @@ static int add_cxl_resources(struct resource *cxl_res)
 		 */
 		cxl_set_public_resource(res, new);
 
-		__insert_resource_expand_to_fit(&iomem_resource, new);
+		insert_resource_expand_to_fit(&iomem_resource, new);
 
 		next = res->sibling;
 		while (next && resource_overlaps(new, next)) {
diff --git a/drivers/dax/hmem/device.c b/drivers/dax/hmem/device.c
index 22732b729017..56e3cbd181b5 100644
--- a/drivers/dax/hmem/device.c
+++ b/drivers/dax/hmem/device.c
@@ -83,8 +83,7 @@ static __init int hmem_register_one(struct resource *res, void *data)
 
 static __init int hmem_init(void)
 {
-	walk_soft_reserve_res_desc(IORES_DESC_SOFT_RESERVED, IORESOURCE_MEM, 0,
-				   -1, NULL, hmem_register_one);
+	walk_soft_reserve_res(0, -1, NULL, hmem_register_one);
 	return 0;
 }
 
diff --git a/drivers/dax/hmem/hmem.c b/drivers/dax/hmem/hmem.c
index 48f4642f4bb8..1cf7c2a0ee1c 100644
--- a/drivers/dax/hmem/hmem.c
+++ b/drivers/dax/hmem/hmem.c
@@ -73,9 +73,7 @@ static int hmem_register_device(struct device *host, int target_nid,
 		return 0;
 	}
 
-	rc = region_intersects_soft_reserve(res->start, resource_size(res),
-					    IORESOURCE_MEM,
-					    IORES_DESC_SOFT_RESERVED);
+	rc = region_intersects_soft_reserve(res->start, resource_size(res));
 	if (rc != REGION_INTERSECTS)
 		return 0;
 
diff --git a/kernel/resource.c b/kernel/resource.c
index 7287919b2380..7f1c252212d0 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -48,6 +48,14 @@ struct resource iomem_resource = {
 };
 EXPORT_SYMBOL(iomem_resource);
 
+struct resource soft_reserve_resource = {
+	.name	= "Soft Reserved",
+	.start	= 0,
+	.end	= -1,
+	.desc	= IORES_DESC_SOFT_RESERVED,
+	.flags	= IORESOURCE_MEM,
+};
+
 static DEFINE_RWLOCK(resource_lock);
 
 /*
@@ -451,24 +459,17 @@ int walk_iomem_res_desc(unsigned long desc, unsigned long flags, u64 start,
 }
 EXPORT_SYMBOL_GPL(walk_iomem_res_desc);
 
-#ifdef CONFIG_EFI_SOFT_RESERVE
-static struct resource soft_reserve_resource = {
-	.name	= "Soft Reserved",
-	.start	= 0,
-	.end	= -1,
-	.desc	= IORES_DESC_SOFT_RESERVED,
-	.flags	= IORESOURCE_MEM,
-};
-
-int walk_soft_reserve_res_desc(unsigned long desc, unsigned long flags,
-			       u64 start, u64 end, void *arg,
-			       int (*func)(struct resource *, void *))
+/*
+ * In support of device drivers claiming Soft Reserved resources, walk the Soft
+ * Reserved resource deferral tree.
+ */
+int walk_soft_reserve_res(u64 start, u64 end, void *arg,
+			  int (*func)(struct resource *, void *))
 {
-	return walk_res_desc(&soft_reserve_resource, start, end, flags, desc,
-			     arg, func);
+	return walk_res_desc(&soft_reserve_resource, start, end, IORESOURCE_MEM,
+			     IORES_DESC_SOFT_RESERVED, arg, func);
 }
-EXPORT_SYMBOL_GPL(walk_soft_reserve_res_desc);
-#endif
+EXPORT_SYMBOL_GPL(walk_soft_reserve_res);
 
 /*
  * This function calls the @func callback against all memory ranges of type
@@ -692,21 +693,22 @@ int region_intersects(resource_size_t start, size_t size, unsigned long flags,
 }
 EXPORT_SYMBOL_GPL(region_intersects);
 
-#ifdef CONFIG_EFI_SOFT_RESERVE
-int region_intersects_soft_reserve(resource_size_t start, size_t size,
-				   unsigned long flags, unsigned long desc)
+/*
+ * Check if the provided range is registered in the Soft Reserved resource
+ * deferral tree for driver consideration.
+ */
+int region_intersects_soft_reserve(resource_size_t start, size_t size)
 {
 	int ret;
 
 	read_lock(&resource_lock);
-	ret = __region_intersects(&soft_reserve_resource, start, size, flags,
-				  desc);
+	ret = __region_intersects(&soft_reserve_resource, start, size,
+				  IORESOURCE_MEM, IORES_DESC_SOFT_RESERVED);
 	read_unlock(&resource_lock);
 
 	return ret;
 }
 EXPORT_SYMBOL_GPL(region_intersects_soft_reserve);
-#endif
 
 void __weak arch_remove_reservations(struct resource *avail)
 {
@@ -1026,7 +1028,7 @@ EXPORT_SYMBOL_GPL(insert_resource);
  * Insert a resource into the resource tree, possibly expanding it in order
  * to make it encompass any conflicting resources.
  */
-void __insert_resource_expand_to_fit(struct resource *root, struct resource *new)
+void insert_resource_expand_to_fit(struct resource *root, struct resource *new)
 {
 	if (new->parent)
 		return;
@@ -1057,19 +1059,7 @@ void __insert_resource_expand_to_fit(struct resource *root, struct resource *new
  * to use this interface. The former are built-in and only the latter,
  * CXL, is a module.
  */
-EXPORT_SYMBOL_NS_GPL(__insert_resource_expand_to_fit, "CXL");
-
-void insert_resource_expand_to_fit(struct resource *new)
-{
-	struct resource *root = &iomem_resource;
-
-#ifdef CONFIG_EFI_SOFT_RESERVE
-	if (new->desc == IORES_DESC_SOFT_RESERVED)
-		root = &soft_reserve_resource;
-#endif
-
-	__insert_resource_expand_to_fit(root, new);
-}
+EXPORT_SYMBOL_NS_GPL(insert_resource_expand_to_fit, "CXL");
 
 /**
  * remove_resource - Remove a resource in the resource tree

