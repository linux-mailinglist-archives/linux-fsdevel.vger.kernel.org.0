Return-Path: <linux-fsdevel+bounces-36455-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAF6F9E3BDF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 14:58:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE8C9B2BB4F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 13:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711A91DEFF3;
	Wed,  4 Dec 2024 13:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R6vZj6xM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F0F1B983E
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Dec 2024 13:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733319505; cv=fail; b=uJsfZwNSWnC+XACCSFpElTg2N1UmBWUhzkkd+CtzHvKZy5ZMdVfOX3qGAldKAcADJAOzOVtzOIwqHKHLsft+s8DqGCPt6CNB2YFhaFEFeOocAVdiYJ3ieCUDHX61TbzBKYM7gyPaiNM+5u8kFp/vRw/jvbVDcycPVA1EhTsZp+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733319505; c=relaxed/simple;
	bh=Bs5rEw4CstA7d5b2gVDPkekdgOqO0ImEsb08lt8HanY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bgZFsNFJyMkvHCDZfxief8aHAhIFthscQR/tUXmlGEuuiDAuV3w8H7I7OJOCeilQuD67SmYLko+GwjyG9SS+VC2RYOA2qVvntoRtWTYG5aYUsUWyMvss7js0qXSIOgVOw1SM/7wgdi1G5wkU5K3lwDA0I3qt/XIv3VQPnd7J8tQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R6vZj6xM; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733319504; x=1764855504;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=Bs5rEw4CstA7d5b2gVDPkekdgOqO0ImEsb08lt8HanY=;
  b=R6vZj6xML3oqQUaaIG7+7yQNjDZ8gE2dO2lsG1cguc990TwqfwBQomOI
   weAoOR2PkqyJKKVoOiKwW7VfbV0f11SwZx0nwfdAw58i2v+5NQ+itGCUk
   jsoJTnJkI157BGB1Qav9UOVycb9SFtur3KJUMor5mry6qSwVT6VMnULv9
   03PewC1AOExu7DF7zwrAMx3dHjYdFmTcYLcFXa0wq0D8u3ilmGF+FJ1r4
   02Qbz/wFUT2Bm1Yp1YHXIq2L7hyyxLQa8vL/ayUX704Ty4U18+TXpLGBd
   0wohYT4jRPw3cIvOLMEPRosgIsb+7MB3ZBXqbpVNfoC8x6CTrl1O9ick2
   A==;
X-CSE-ConnectionGUID: FlXHUZTgQSGCb/tTGBAd3g==
X-CSE-MsgGUID: eiJ9AsA+TAeLaKKW6YMJ7g==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="44612245"
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="44612245"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 05:38:24 -0800
X-CSE-ConnectionGUID: iedoGlR8SrOHMwMdHeVyzA==
X-CSE-MsgGUID: mjPgZAfFRyGf6Ai/x+obHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="97831140"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Dec 2024 05:38:23 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 4 Dec 2024 05:38:22 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 4 Dec 2024 05:38:22 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.176)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 4 Dec 2024 05:38:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t56np/CpObWCYZeUwssYbhiQEt48wk7QB+RS/0MBhZDvpVE555F0TWAmHEhKJtzQekIZhTPoOVOx+xbuONpKQI/uK+mBKBqVUHrkmN3Ai0tM8xT2ZcQ268LPVd+/vZmr5Wzr86JkZywnUi24K3S8BL8kpfv0gHvqUKOLhqSudG5R/NRfysGSOMlVzMxVU3LmGCxtIYUjTT2S/Yju5S6RDddrkklcwAT8D/5JSg9tYjr+jF6hcpGgY2HDPQ+hDXkGBHlgdFlMNfLkAZV6FP9qRZr+OSOzdLcYIWTPsFBCpDUQFlzokJ1uCLJve9coXAHjrxv0HrAhu+7ulfSfQpsCXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t6Lg3CfK5LwOSmHIaWioUrjdPiMsKzKVg14o2z1txRQ=;
 b=P0klBwj/qxmJGwIKOPcbaFco9eLg1njgxTST3G1mSKbysxs/LmhBVAkKSCJI4Vb5vYgmEWri+Qy5xoBTF8NG2ELeFth1HYw8vZB6oLKy+zB6yhgZ3LxLf+tcLa8A7Oi44csUl/stlJHNKApcA1HzzKlXtM3DFTMq5wMHiNMqU8RntttOj5Wr0q0eJbDvjwgkV4TSxEvCClSH3KtDA4VxPjSDFAYx7gqnAVPrC6o6wFLb/SK0bYtangMnrR6XDlB4ZyAXEZNBF0W4fK/lR2J2fg1cz++cgA9t3ThxRrmGimg9mIaTsC8W8o7ftVkrvX4ADteV5hPgZKjf25rtfKB3kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by IA0PR11MB7813.namprd11.prod.outlook.com (2603:10b6:208:402::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Wed, 4 Dec
 2024 13:38:20 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%6]) with mapi id 15.20.8207.017; Wed, 4 Dec 2024
 13:38:19 +0000
Date: Wed, 4 Dec 2024 21:38:11 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Yafang Shao <laoar.shao@gmail.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Andrew Morton
	<akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>,
	<linux-fsdevel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: Re: [linux-next:master] [mm/readahead] 13da30d6f9:
 BUG:soft_lockup-CPU##stuck_for#s![usemem:#]
Message-ID: <Z1BbQ5zAjLd1kUoW@xsang-OptiPlex-9020>
References: <202411292300.61edbd37-lkp@intel.com>
 <CALOAHbABe2DFLWboZ7KF-=d643keJYBx0Es=+aF-J=GxqLXHAA@mail.gmail.com>
 <Z051LzN/qkrHrAMh@xsang-OptiPlex-9020>
 <CALOAHbDq8yBuCEMsoL=Xr+_QHQ39-=XHK+PEN5KxncxmL=nhYw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALOAHbDq8yBuCEMsoL=Xr+_QHQ39-=XHK+PEN5KxncxmL=nhYw@mail.gmail.com>
X-ClientProxiedBy: SG3P274CA0008.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::20)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|IA0PR11MB7813:EE_
X-MS-Office365-Filtering-Correlation-Id: 44d50dc6-ad71-4b31-dcb3-08dd1468ea64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SmZRNkphOGhscW0zcGlxMDROMW5ERGw2QUgxWE9FRlYvbGl0WTIxTkJlRjJn?=
 =?utf-8?B?aVkvVzlYKzJHaVQ4TkF5T0NTbFRHNXh4cjNzZUc4WDJiUXhTb2VoWHo3andY?=
 =?utf-8?B?Ukg5TXhXWkpBUkZ5RGk2WGUxQ3JCTXdkTDJtczUyNHIyak9VNlZLY3o4UEtE?=
 =?utf-8?B?L0RERTZnN0k5Unkza2VWL0ovL0ZqSThXWWh3YjFnV2dXZlpQaG1UN1hWbFB3?=
 =?utf-8?B?OG9mdDRvMGpSNkxjVDlPeTZZNHVGbGI2ZVRGNjNFaEtET3BPYUk3M1JmcG5H?=
 =?utf-8?B?VG9lU0NCaTQrV0pOaDVBKzN6cGNVYzlNSXhjNk1sQ1paRDBJaFZ4dks1K2xX?=
 =?utf-8?B?K1ZaVFFpQlFPNkNQWnpJNmt6M3ErZkhDS0NHcURWNWFwQWlGYmppOUd3Rzlt?=
 =?utf-8?B?ZzF5QUFSdWd2VzBwN2Npd3hHRi8xN05qcEhzdG5Ed05UaWRYQ2RiWUlHbXQ4?=
 =?utf-8?B?K09qeHpaVXFPTFdhQVlPZlRRZnIyZXNnNU9aZ1E1NUw4akRVTHM0S21iajVN?=
 =?utf-8?B?RmFrVXIxalpnN043Wjg5Qmxhd2xBOUtxTldENmVsempnak1pSUdDQW9kWHRo?=
 =?utf-8?B?UHZFWk9oYm1lcmpUUVBRQXRpUGM3UE5SSnJ5dkUwbFRkejlIMTRFVEVYOVRj?=
 =?utf-8?B?NzRpTng4UjllTW5LclNOTENCWjZOU0Qxa2xVN1dNakMzSXJDQkNWT3ZuQjFx?=
 =?utf-8?B?QkY3L2FGd2tmZWVnYVZkaGF4R0VORUh2MC83Ymx2ckh6dzhYNlRyRlJON0xa?=
 =?utf-8?B?Zmx2TDdEQXhBcHN3ZVFPc0hJMmFQL29NcFBCOUhmUjlVZ25XczRJMklDSHpI?=
 =?utf-8?B?azhTRHkwc0pLdWVPVk82cEp6L2Z6a1cyemhCcEk0Z1ROR2g4bXVVVElnbU0w?=
 =?utf-8?B?SE1yVGRRNi9GSjlFWXRrVHd3d3RvYy8rdjBpNjloTytPd0c3MmNDTFlnZWNE?=
 =?utf-8?B?MFJPczZDTzNVN01USElKalRTa3o1YzlTSWdMbTRCTFZEMGhzNzIzVTdMY2tZ?=
 =?utf-8?B?TkJNMTZIL3FPUFdUSjArZUZnMWxVemREbjk1T0pyWXFyMFFDWTk1ZkR4cy9G?=
 =?utf-8?B?YWZyUXB2YXlheng5bmNQUmtNcHZsR1pLWFlRUTVvQUJjYkJtbXNHYWxaT2tp?=
 =?utf-8?B?MTYzVWdESVdQSkVSbXltZmlYbUFCaXhkZWZEdGYzUVczUWNvcDluMVVPU2hz?=
 =?utf-8?B?MUxFN1JmMGZlRHU1VHcvcjRBelRZOG9YSHcwY3BDdko2QUN4cjN4WWxuM2tI?=
 =?utf-8?B?UzQ0Q08wUzhTVS84R0FXQVhiM0RaTGhlL0lmeStuUmx5c0dzTWdjRkpkMUpO?=
 =?utf-8?B?M0JCVGVEOVhlc3Q3bXdQa2UrUVU4Y0J4eFBzTmJKbUlVc3NsZEp3N2V0UVp4?=
 =?utf-8?B?eWtLMzZMWEp3WFBLV0lFaFQzc1pvQzdsb1JPS0U4WjZ1UXRmeEROSTl1bytT?=
 =?utf-8?B?bjZPWDFWRHZnYnpHSG53RGlrcUdNb1BaNHBZVC84S25OT3RCMkV4TURGWitm?=
 =?utf-8?B?SVdCVzlIZTRQdkNyUlViRWhLbnhlelFEY0tlYmVPSFRPZkJ4TDZISklCWDEx?=
 =?utf-8?B?SW45SFJubCtoTzNBUnJTMkxlUlBrVjkzWFJKTzVJQStYVmhPMmFPZWdpa1M3?=
 =?utf-8?B?VW81am8xT1UzR1d5NFBDWVNPai9ISXovZkIvbUxEMHNHeFpRRnhtVUlaWVlB?=
 =?utf-8?B?M2l2eW1uUFI1b0s4SXlVdllJT0p1c05XeXZUYXFWby90V3JySEFmM2llSHh6?=
 =?utf-8?B?czFUT2dnZFhBaWVkOTVFc2trQm02ZEJXSGJFL0dnOWVKeG5xNlRlaWNWYit2?=
 =?utf-8?Q?k1Yq/Cm3x91vi/m0ife1HMWYX9HGG9p9NKxW8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUZNbUhQZ1pKT2NwcjZhbzFUcnE1SVpSRUJZdWZpWXZtNWFGOEU0YkFWVk5v?=
 =?utf-8?B?VWo3NCtUS2s5bzg2WVJOS0dSdkFFYnM4Y3lpMGVCOURTV0FlMGZOcTVWSzJi?=
 =?utf-8?B?YmhncDluNEZwYTBUTDBhTmRseDRSVTlXR3RmNlVDbjBBaE5VeEhIWFlLbUJO?=
 =?utf-8?B?QnNkcUVNTGJydWFrd2IwYXhjL3NyNm85aHJCTVlZNUZockZ5WW95SmttcjZY?=
 =?utf-8?B?bFdMcDJvSzVUeGY3aUcwWDRrS2VjQWtQTnVhQ1M4OTk5ZXB2QzRsdjRGM3NP?=
 =?utf-8?B?R1U2YVlFRDZjT2FxMC9IOE9jRmN3d1RmSjczOFRVQjJmTjc0NWpzQnN4Mzds?=
 =?utf-8?B?VHVyM3lraktEMUlLTWYycU1tOGwzbTNyRTJ0VFpVYkEwenU0Wmc2MlR4NHl0?=
 =?utf-8?B?ejUyNDFZZER6NmhKcG5HYkFCSFV1c3VRYSsrcWdsZm5nNk9JaFlRci9qOHlR?=
 =?utf-8?B?MW0yU1VLcjFyMmlZODNmNnQzNXl4T1pMVWpZMFZIUkE4ek9YMWxhb2RYeVJw?=
 =?utf-8?B?ZlFNbGdXNDhMcjA5Z25XdEpaRVpPNGtQYkNuMERXaUJaZnBXdkhIeERJQ2Jk?=
 =?utf-8?B?VktmNnlnYU9YSWk5RnZXRitQUVpXcjlMUU5LRnY3bjkyYVFRYmZXN2NqS1BB?=
 =?utf-8?B?RFl4UnUzTWtXejBvWnNqeklPaW1ZaVdBZFQ5d0hjb2ZUenZ2Rnhsd3pHWVB0?=
 =?utf-8?B?dFNaZnFBQi9DRDJGS1I1T2tUS0w0SVlTUS82SzV5UXRiczZiak9SRVZCMkhy?=
 =?utf-8?B?TzRUVWlES0ZibFd3SXloRUhCZkQvRnUrTFlkV0xkWnFvOS9kU3NuamRLMEw1?=
 =?utf-8?B?RHBCeVViOHBuRldXVTVyMUhyeEN4anc4SHZGd1duZ3ptT2tETU01VjZSS2Zq?=
 =?utf-8?B?R3MvbUp2UHF0NE5qR3drYWQ4aEhna2hqR2s3QWE3RE1udGwxejBtYVRaSEZT?=
 =?utf-8?B?bGs1OUI2L1JhWXdkR2lha25aZFZBaTVNR3liSnVRR3pPWEU5SnZoVGtaZ2Vy?=
 =?utf-8?B?OWFEZ01XYnFrU3ZBN2tITVRvQjNnMzZxNXhZQm9JTDZ1YXM3NnJ4S1hOcjZL?=
 =?utf-8?B?L1pMWHV4cXpyZVpLdGFNRlZKdTBhQWRENEtPQnZJTnlxSVlETFg4TzhObisy?=
 =?utf-8?B?L0tVSjJLVXJCM1QrdU90TkFZMzFjRU5DTTBMNU9idnhyRXptbUpkTnF6WjN6?=
 =?utf-8?B?U1pST3JoekdycDhTVThBU0dnTHM2dHNDVDNHczFlL28vaUI2Y1lKcTEycGdu?=
 =?utf-8?B?ZUFTdXZIcVFyUHBzbkFjNDhyWlFHYWJkbHgzNDdYQ085Nm0wR1pmSlZyWktx?=
 =?utf-8?B?L29jQkRrbk9VZ0VlUk83cldBWGlQY2paaERhSFJmY2gvUVg3SG9nT3gzQ1Fw?=
 =?utf-8?B?MEtOcVJUTEt4U25XbWFEeWtCcURxWTQ5aVZaUWNmM2VHMmhNc1dDK2VSZ0JJ?=
 =?utf-8?B?bWdzaEtmMHFGSENVbjlrbU5tUCswSExBMVh1czI2Q3VScWdRUFZtU3VlSXRa?=
 =?utf-8?B?WDdVSmdWd0lBMyt3ZS8wMVB4VnRvY1c2eVdzQ0JNQml1WUFKdnAyYndSbEE2?=
 =?utf-8?B?YXo1R041MmFTakUxS3FiMm5OYjdpSkhDRHg3VjBibkNUZ2d2Yk5LeHE0L1ZO?=
 =?utf-8?B?cVlDQ0FKcUVYYWIxVGtKSDBpZDkzWUdESTN6SFI3VCtpR1FHempZVDdJNXNk?=
 =?utf-8?B?eXdnRmx4eU1lZ0JQVW5KUUFqN3FuWWhZM3dNUVgwOXB1TXdOK2wwdDlhR3ZX?=
 =?utf-8?B?UzBSTTVCSlZTUkppUG9tWHoxWkZBakVaSnBaNEt1bUt2OWkyRjI2OHpjYTFZ?=
 =?utf-8?B?Ym9WWjhNczU1dGoyV2R5cm5SUG1YNkloNGNJUXREZ3ZxdnZ3Z0E4bVByL3ZW?=
 =?utf-8?B?OENXSnNXRWtpU1d3LzNMSWx2M3VOQXNsSXB1cmszVnVGZlR2c2dKWjkzUFFz?=
 =?utf-8?B?Qnc5TWVRYTMyYU9sTzkwcFZHMlBiMUFJSXowcmVOOU9hMjdxbURNSjFDYnhh?=
 =?utf-8?B?Z2dmMlFqd0JKZzJEdE91Z3M1eUFCcEFKZ1JvajhseXh3T1E4c0JsMVNaWmxt?=
 =?utf-8?B?RERyV0FMdDNQUUxqWWRNbWFEbXhFVFVJeFRRUjFna0tjNEluVWM2ZTQxNEJl?=
 =?utf-8?B?YjVzLzJqcWs0WCs5ZzJDQVBFSFZWclZKanFTTFdJeTVVRExQRFNQa09Dalk3?=
 =?utf-8?B?Z0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 44d50dc6-ad71-4b31-dcb3-08dd1468ea64
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 13:38:19.9066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 64siAvO3KwJpTpyd0Aylmm53z9Bk52Kdi+poXTc3Ai8MIgct0fbWCugnkMwUK/hhQNX4YDkzyfhjwmXIVJlRFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7813
X-OriginatorOrg: intel.com

hi, Yafang,

On Tue, Dec 03, 2024 at 05:33:16PM +0800, Yafang Shao wrote:
> On Tue, Dec 3, 2024 at 11:04 AM Oliver Sang <oliver.sang@intel.com> wrote:
> >
> > hi, Yafang,
> >
> > On Tue, Dec 03, 2024 at 10:14:50AM +0800, Yafang Shao wrote:
> > > On Fri, Nov 29, 2024 at 11:19 PM kernel test robot
> > > <oliver.sang@intel.com> wrote:
> > > >
> > > >
> > > >
> > > > Hello,
> > > >
> > > > kernel test robot noticed "BUG:soft_lockup-CPU##stuck_for#s![usemem:#]" on:
> > > >
> > > > commit: 13da30d6f9150dff876f94a3f32d555e484ad04f ("mm/readahead: fix large folio support in async readahead")
> > > > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> > > >
> > > > [test failed on linux-next/master cfba9f07a1d6aeca38f47f1f472cfb0ba133d341]
> > > >
> > > > in testcase: vm-scalability
> > > > version: vm-scalability-x86_64-6f4ef16-0_20241103
> > > > with following parameters:
> > > >
> > > >         runtime: 300s
> > > >         test: mmap-xread-seq-mt
> > > >         cpufreq_governor: performance
> > > >
> > > >
> > > >
> > > > config: x86_64-rhel-9.4
> > > > compiler: gcc-12
> > > > test machine: 224 threads 4 sockets Intel(R) Xeon(R) Platinum 8380H CPU @ 2.90GHz (Cooper Lake) with 192G memory
> > > >
> > > > (please refer to attached dmesg/kmsg for entire log/backtrace)
> > > >
> > > >
> > > >
> > > > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > > > the same patch/commit), kindly add following tags
> > > > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > > > | Closes: https://lore.kernel.org/oe-lkp/202411292300.61edbd37-lkp@intel.com
> > > >
> > > >
> >
> > [...]
> >
> > >
> > > Is this issue consistently reproducible?
> > > I attempted to reproduce it using the mmap-xread-seq-mt test case but
> > > was unsuccessful.
> >
> > in our tests, the issue is quite persistent. as below, 100% reproduced in all
> > 8 runs, keeps clean on parent.
> >
> > d1aa0c04294e2988 13da30d6f9150dff876f94a3f32
> > ---------------- ---------------------------
> >        fail:runs  %reproduction    fail:runs
> >            |             |             |
> >            :8          100%           8:8     dmesg.BUG:soft_lockup-CPU##stuck_for#s![usemem:#]
> >            :8          100%           8:8     dmesg.Kernel_panic-not_syncing:softlockup:hung_tasks
> >
> > to avoid any env issue, we rebuild kernel and rerun more to check. if still
> > consistently reproduced, we will follow your further requests. thanks
> 
> Although I’ve made extensive attempts, I haven’t been able to
> reproduce the issue. My best guess is that, in the non-MADV_HUGEPAGE
> case, ra->size might be increasing to an unexpectedly large value. If
> that’s the case, I believe the issue can be resolved with the
> following additional change:

sorry that our service runs into some problems these two days and we are
busy fixing them, I cannot address your request quickly.

here is a quick update. we rebuild kernel the rerun tests more, issue seems
still persistent.

d1aa0c04294e2988 13da30d6f9150dff876f94a3f32
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :20          75%          15:20    dmesg.BUG:soft_lockup-CPU##stuck_for#s![usemem:#]
           :20          75%          15:20    dmesg.Kernel_panic-not_syncing:softlockup:hung_tasks

in order to remove the possibility of env issues on this machine, we tried same
tests on another Ice Lake platform, still see the similar issues, though the
rate seems a little lower.

d1aa0c04294e2988 13da30d6f9150dff876f94a3f32
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :10          50%           5:10    dmesg.BUG:soft_lockup-CPU##stuck_for#s![usemem:#]
           :10          50%           5:10    dmesg.Kernel_panic-not_syncing:softlockup:hung_tasks


we will test your below patch and update you the results. thanks.


> 
> diff --git a/mm/readahead.c b/mm/readahead.c
> index 9b8a48e736c6..e30132bc2593 100644
> --- a/mm/readahead.c
> +++ b/mm/readahead.c
> @@ -385,8 +385,6 @@ static unsigned long get_next_ra_size(struct
> file_ra_state *ra,
>                 return 4 * cur;
>         if (cur <= max / 2)
>                 return 2 * cur;
> -       if (cur > max)
> -               return cur;
>         return max;
>  }
> 
> @@ -644,7 +642,11 @@ void page_cache_async_ra(struct readahead_control *ractl,
>                         1UL << order);
>         if (index == expected) {
>                 ra->start += ra->size;
> -               ra->size = get_next_ra_size(ra, max_pages);
> +               /*
> +                * For the MADV_HUGEPAGE case, the ra->size might be larger than
> +                * the max_pages.
> +                */
> +               ra->size = max(ra->size, get_next_ra_size(ra, max_pages));
>                 ra->async_size = ra->size;
>                 goto readit;
>         }
> 
> Could you please test this if you can consistently reproduce the bug?
> 
> --
> Regards
> Yafang

