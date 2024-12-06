Return-Path: <linux-fsdevel+bounces-36601-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B599E641C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 03:27:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D2671885137
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 02:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0023D170A26;
	Fri,  6 Dec 2024 02:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DBiaOUHz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B05316132F
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Dec 2024 02:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733452043; cv=fail; b=mYHUWfSoXiiZ1DvK/HulLebWPReHyAh2daX2z4VFZoN49Swf+KmJSxk/dNv3wH6XdeVKuZ2lZ7ZpOBug/Rz7GjSE706tUAMAJP+IPag5XPwoImC2LtBsLGOI21wXaglw1plzGSiSCDuTW5USvSdLgBkgOSzGJWY4cz9bYdigQSg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733452043; c=relaxed/simple;
	bh=WBkM2fe8uALoOLQDR255vzrkpNayq2x4Ak80bQRG704=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gwG/LMr113KG54DOQzO+8g7aTMIcSCzhcZmmJwV4xEInp4Pox3cYOdXaZ1h9rIXKInc2n1fkMvsvfGLkUx6fhKel32VH/uNOHnCJ4QM0Hyp3bsPAQYTVmLV/xyuh0uoKmX//niC+cCmirlv2XuUINdrqCabRCgeNbXfbq6Dt5yA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DBiaOUHz; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733452041; x=1764988041;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=WBkM2fe8uALoOLQDR255vzrkpNayq2x4Ak80bQRG704=;
  b=DBiaOUHzRqefWbp166j6YJzJ0nOWK+vCeRNQ1DtfwM2Dfn4Ym3+ORfLb
   hBNUfYvFGs9XwaXyP4foCvRD7J0x7p6FVMa+6AYbqlypFe8jBkLHeTTie
   k0A2WIIDz0vw9IU8oMjZ7BZbdClNowSeItSOh9SMcLLEEAiGMNoPAEsrY
   jIQYThHuHn54OmAcRS590+l2qSqLgh6h1VqlIzq4JygDomgDwS1ruayvE
   2qyxJhncXjF54X5/hG9fVMzOG07wgmJBo0S/KTBnm5N+PMEkY8OiNHjvJ
   qauAh2NXh5iUEHSl7hRvrZijNF0zhM6TwYdpp/EA5xJF7vRUMUniSoqwb
   A==;
X-CSE-ConnectionGUID: nZKcK32iTpG8roTCqS0NlA==
X-CSE-MsgGUID: 2vRcn/1kQQ+uWAUk4fkJlQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11277"; a="44464490"
X-IronPort-AV: E=Sophos;i="6.12,212,1728975600"; 
   d="scan'208";a="44464490"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 18:27:19 -0800
X-CSE-ConnectionGUID: xPmwHDHwSl2wGaalGX7G7g==
X-CSE-MsgGUID: 07bd3QldSIa+xU0doeIkiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,212,1728975600"; 
   d="scan'208";a="94354126"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Dec 2024 18:27:20 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 5 Dec 2024 18:27:18 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 5 Dec 2024 18:27:18 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 5 Dec 2024 18:27:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y9lZBYXe9+u4YV/6GOX4RhtchOH8CfEgHf3G03AC5wlSbEyfVcY6eqZvsL+hZbgRx7iqrlYyjjfhWuL1uMTm/symzODCMB+Ma1T+QiXRzwPflVeaYcCG3dyg3nRjTEO7b5plngOVrWYo1l0OzSGRdtBHZo9HD1jvoAPAfPlqyBDIDl7nHRQcpxIjdsi75Vo4minyZFz1UVPN4pkHmMc27Qg94bvPVZ6bfNtNGxAanOgl0xqEFEMMTkoOZBmjWFcZaLt+2OggwARG7LxgJzeh/JHq+ID6FrGgc+7UpFuBOnpHxbXSz4cRY8WZFz1lO0UAO3mU57N+GzIv+Er6Q1/3CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4p0d3Ro9DE023bCLHq225GXXC5dtULY+FpmJpjDM9Yo=;
 b=P+1wmnFlsOSi+MOlvMoTF4YruilVlyCLEbL3Zi6bgA9Yqj4a2h+tdf+qSkBF/jiOGpP0TlHNAyzJpg161V5k5DZUO4OFxKPBDjOSrA0jRgBx515HMPzf1OasYinYPfa+n6IiDX1zPvt3chvBqlzRIvGDKuqdOudJjk9bCVVYwD61bjURQGQEUqWXGaUA9Zyr77aLNulVbli8iwaiF7ulqCQM0muUoKBWrAp/d23YG5AuWEKNQ+3LaJ3FGMvkwGlq1w3W5xacbmrwtQzuWVO3peWuPcPsYokofBvHEPcCtPSJc7njLJCBiCZNndTktX+ltwjqO3+Y2mRPXQzb/2ziZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by MN2PR11MB4518.namprd11.prod.outlook.com (2603:10b6:208:24f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.20; Fri, 6 Dec
 2024 02:27:14 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%6]) with mapi id 15.20.8230.010; Fri, 6 Dec 2024
 02:27:14 +0000
Date: Fri, 6 Dec 2024 10:27:06 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Yafang Shao <laoar.shao@gmail.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Andrew Morton
	<akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>,
	<linux-fsdevel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: Re: [linux-next:master] [mm/readahead] 13da30d6f9:
 BUG:soft_lockup-CPU##stuck_for#s![usemem:#]
Message-ID: <Z1Jg+vcpFKGSfx25@xsang-OptiPlex-9020>
References: <202411292300.61edbd37-lkp@intel.com>
 <CALOAHbABe2DFLWboZ7KF-=d643keJYBx0Es=+aF-J=GxqLXHAA@mail.gmail.com>
 <Z051LzN/qkrHrAMh@xsang-OptiPlex-9020>
 <CALOAHbDq8yBuCEMsoL=Xr+_QHQ39-=XHK+PEN5KxncxmL=nhYw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALOAHbDq8yBuCEMsoL=Xr+_QHQ39-=XHK+PEN5KxncxmL=nhYw@mail.gmail.com>
X-ClientProxiedBy: SG2PR04CA0168.apcprd04.prod.outlook.com (2603:1096:4::30)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|MN2PR11MB4518:EE_
X-MS-Office365-Filtering-Correlation-Id: 421391bc-bfd7-456b-5bae-08dd159d7f19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b0dLRmNkdHY3aWFuZ0g4S2VzY1NiUVY0Z25WYnRSR0c1bm94Qm1sQ3RXTkxF?=
 =?utf-8?B?T0p5a1FUNk80dU1uWXQvaXVwUXMvYk5YMXFhVXRYTTBTaXZSOFgzVGdFZ3c5?=
 =?utf-8?B?cjlLRzhlY21lSHh0bVhxTHNIUUpmT01ObXBubjZGQkwvdmwyRjNYYnAzbGww?=
 =?utf-8?B?R2tvWWVkeSs3L3hEdGxFcHdIWXk0UlFXMVdoS3NUK3NuVFZhdXoxQTIyY1h5?=
 =?utf-8?B?MkdxNmxzUm94cklvbml4aTFPeW1oa0JZV2RwYXdIbDZqNFdEcFBvL3lUeXNt?=
 =?utf-8?B?NXBkVUJGOUtxQXZTZ1RzZnlWYWNUVlcvZ2R2bzYvbDBMYTc3RDQ4WlRDbDJ0?=
 =?utf-8?B?MFdGaTBDckZYK3RMek5hQlBKalA5eGVhU3VRMW1tR2paVWNMdS9OL0hXb25n?=
 =?utf-8?B?OTBac3RoOFdiKzZDWGlFRVkvYU9GUWptQ252cGUwOTNnTGZ3L2pqR1BTdE5P?=
 =?utf-8?B?SUY2OUs4NHA3TS9VOXhXNEJHQzlFc1BxVjhhMjl2RE9lR2xNVDBSRDlQNGxF?=
 =?utf-8?B?VTlhSzZSV0lJRUNlT09EV0hOdFRtOG1mb1RQbFhnNnFSNkdranNmQTQ4UmtM?=
 =?utf-8?B?Z0dlVHZZZTFqTDEzNFNNOWxZVFhuNmtodmdRRzNROUpZdDVOZEJCZXhoWHhj?=
 =?utf-8?B?cXpnZjg4cmZCNVdVRTR6OGhlVXphNGhrMEZyUVJFM05RdFJST0VvZU1PVUZs?=
 =?utf-8?B?NnNkWUdLZ1lnbDlPL1F2Q1lHeklEaGZuazhpd0dyTHZLY1BxK1ErOTYzNE9z?=
 =?utf-8?B?L1h5ZkxPUFI0K3F6ckRSaWRXYmo4NlhtRlA4QkpDV0JoU0xPWW1VdHFrUFRl?=
 =?utf-8?B?VFlPVXBxS2w0SXRsUm14OVROaCtEdzk1RTZ1aVJiQ2tzOFUrUVQxaGFDeHRn?=
 =?utf-8?B?Qm92Z2pJaG84NVJxVlFiUFQvZ1liMjVQYlBBK2ZLTW80R21STkU0RUIyUGdz?=
 =?utf-8?B?NG0xbEdUM1FVVnFQUzdaZjAwMWo3WndqbXBBMjlDSXBmUVpadDJiaXhERUw2?=
 =?utf-8?B?LzFtb2hqNlh1NnhucmdVUVpIT1J5UDVlZHgzR21xU210WG55ejdKZVpQRXc1?=
 =?utf-8?B?VENzc1hnVXZwbFRCQzZDVDFRNlc4R2dLVXZkT2RmL2EvZ1pSejdNN0g1Mmg0?=
 =?utf-8?B?ZlBUcXhLRmVtSkxaaFAxTnZrTlpncEJwOWl4VXNyTXdBVjNzY0NSVEROd2hm?=
 =?utf-8?B?S0JSSUJuUFF0ZlNvTytVZDNXN293a3VnWUdUT2RJYm84Z2RLRkRFTDZDd1dH?=
 =?utf-8?B?dFR5bXhFYU9YWGhlYUEzOWhsbkRiMExkWGpzWDBpMTdvMTlJMXhLa0xHQ2Fl?=
 =?utf-8?B?T2grdUlENm5GaHNFdTcxald3cm9VZEI5SFEwMU5kQXpjYU01eFFtRitvL2Q4?=
 =?utf-8?B?bVNkNUNnaGdwOGtYbUo1VzNTUTJ4cGpaN1BXazZ4Tnd0bDB2bXN3d2JlbUJv?=
 =?utf-8?B?WFA0bnl3ZmlubkplNkVwMlRwYlZWV0ZRRzJ5MDNBMGJsNVM3WHd0SVpXUzVX?=
 =?utf-8?B?TFgzMDQyc3V2cS9Za1VibStIdkVnaFc2V1lkdm93aEdNb1U1L3dJMGg1a2pG?=
 =?utf-8?B?WTBvMkhCY3kvOEZBRlczQmQ2NXNPUzlJSWVNSEQrVFIzVDRrQ1o3TjNzYXBG?=
 =?utf-8?B?WVZVRkhmQ3czbVoxV1F5WW94Vy9GY0s3TkxqZ2xiODVnS0RLQXF5QVU1Z1Rl?=
 =?utf-8?B?dXAvWTNlTkkyUEVSS2ltbDRFeGpsNitWaHV3SkN2bWFJc3lOZXFLMzFBb1FH?=
 =?utf-8?B?RlNsSDk5ZU40OGQ0VGtjNmZadG4reUcyK0RCcnVKVnBkc1VERHJXYXUyQ0o2?=
 =?utf-8?Q?FFblv2B6bhE/g5XVelHKmgK3uLEFsJdLxIZEo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dTNPa0w1eVdhdUh1S1R5TDhHT2VjdC96cW9lMDBLSzFpdUEvR2hCcXBoYVBt?=
 =?utf-8?B?bXFOd0NSK29jQjh2VXkxZXptVXRZU0lTRnA2Sk9WYmp5aHdnc0ZicW4wdkNl?=
 =?utf-8?B?NVdiSjZ6TzJTQjhDSlRqZmNJcW5LY3ovZFNHeHBKc2pubEQ1V1hRcURLTEJz?=
 =?utf-8?B?T0J4RHBkcWk5RHBkZ09rSnhhNHdMck00SFh0bGhDdVI5OVJKaCs0SnhGREdn?=
 =?utf-8?B?dkh4d2ZIWVVwTU9KNW0xWnpsdUh0eVRaYVczNUpES0FHTnZRNXZiUHFnYzFE?=
 =?utf-8?B?Rk5ZT0VPNEY2MVAwT1Nva0puaWRTWWlhNDFLUms1b3lvaDkxSkRhbDRIWm1I?=
 =?utf-8?B?THB2SzcwR0JzSEMzd3FUbXdKVnd2WWtLN1FTZDB1bmpQM0VGdW9sRndHZU9W?=
 =?utf-8?B?M1JGMEJjUjdFTHVwNFhTeXpVMFB0MWVvYndacmVlMGwzSGJFM2N6cnpRaTJr?=
 =?utf-8?B?QlNCWlQ0UHdLVEhvSVNncks0a2lNcVNsZE43aUYrUFI2YWRZbHdrMkJoL2hn?=
 =?utf-8?B?VUlINUd1cEluNk1icFJBQ00yME5Wcmk2elRoaG9xdUl0T0psdmhxVnlPYTJl?=
 =?utf-8?B?UmV2OTRXZThKZlh0UlI1TUdlM1g0eFRsYy9nYVV0QTB2RjVUbit4L3JSOWsz?=
 =?utf-8?B?YTNyZ1hhb2xwQ2VTQkg2c1lvZm1zQWZpOCsrMGg4S3RVSEc3WXErdTRmRHNN?=
 =?utf-8?B?d29yOWsxVUl0Mnc2ZHRTQytjY3JJdk9FOXJIQWNacnhlYzhmNnFiN25yTURa?=
 =?utf-8?B?c0dqOE0yT2thVDZ3TmNvSUdZUE1TUkdweWhHTi80YzVqZnRmM2FIZktreG94?=
 =?utf-8?B?b0NBUzFhSlFZelpsWVNFWkQvS3loRWs5NnN0OWt0a2w4K0QycCtodC9KbnlZ?=
 =?utf-8?B?M0ZiMkJwdDZ6UHFVSzN4TXlJT0JWeEpMcU5BRk9RRGo0VGlNYk5uVGxDU2R6?=
 =?utf-8?B?eDc5WUp1eXAwbG1CWmM0WlhhV050aHZuY0trOVd0NDg2OG1IVmFkak5XV2t2?=
 =?utf-8?B?ZUtQd3FJbWxmYTZyMmVITGJkUWJ1K0tMUVVTRnJ5OTZOK21JeFJTL0pna2FL?=
 =?utf-8?B?c1N2WG9FOVdTMGMxYURhcDE5Zmg5NlhacU5iSWx1RDA3TTN3MTEzdHFSUjgr?=
 =?utf-8?B?UE14ekxpVkgxL1FheGhHbzB3Wkg3bWJQZ0hTTHFrUnRwTzRNL1VXT0dkRTJG?=
 =?utf-8?B?amRFV0FSWHl3bWRFVkdmWmpBZk5kc2tGVFR2VytjOTE3ejkzU3VEMzZIblR0?=
 =?utf-8?B?Nmh0WlEvQ2lqQXVrNlJxVjQ2dU5McUVCUlFnZjNpUEVLTzMvbWUrWWNWZkJu?=
 =?utf-8?B?NDJDWFJyOE8wRFJvSGtZN2J2TXRnbTN3UFE4SHovN1IzbmFZNmxTaUR1a1dG?=
 =?utf-8?B?aUNObVhSVHBJS3U5L1dEUXdjUTFIWklrVmlRU3dDSUxLYnpJTXNkT3VGcG9G?=
 =?utf-8?B?MDVBdzF2M3VDMkdsbXZCNEpsUDVJZ25zNFhGSWxXcmg0ZVNNN3crdmVDN1lk?=
 =?utf-8?B?QU1kaHpPbWZ4bmdRVjNLanlUOXFqS1M2UnBoZFpaZEYyL2VCSEszTFVoUWNI?=
 =?utf-8?B?UitZdlNPRkhWQm5ITmhsaG56WGI4MnlFN1hUaXR3V1l0SGpiMGdmcmNTVzhs?=
 =?utf-8?B?aUdxdXJxWUFKMEVmL2U4YlQ1cUh1ai8vaU9rTytTRHpKd3gxdFZid0lMMlF3?=
 =?utf-8?B?RjhkVUVQcC94RGpCZmt0RUhSUWJscmpidGNnTjhjaDRVMGZUZk1nZkk0WEdD?=
 =?utf-8?B?bXZoK1llWDdRWWE3ZUtzdHlJSkdQbzFFWCtTUUtKWDkyYnBJSnlpZ0Z0Rml4?=
 =?utf-8?B?ZW5mcEpIUDFzUnJVWFhNblNHQStaa1k5elFJT0o5ZDlHWFR1bndZb0NRajUv?=
 =?utf-8?B?RCtsSTRiRVlKdUdNd0F4Zlp6OHo1WGRoT3RJdld6c3JhOW5lUDVRNzFHS0xW?=
 =?utf-8?B?UHU4cGdCQmh1MlZ0WXJkc2J5TmJLc25aNUoyNlhDdWVuV0dhWExHcWZ0YnY0?=
 =?utf-8?B?d0cyUWdHT2pnT1huM3JsN21aSnBWVURpZ215cllxK05Bc3BIYjZrN3p3Zzdr?=
 =?utf-8?B?ZzV1VkNxNGhLWXBjVjY4VGdBS2tvSW5DSGxUOWtON3JxM1dSaFJMdFpmMWd0?=
 =?utf-8?B?UVR2MGx0b0o1NXZ6NDUwUUhWWFk4Wkhia005K1VqSzZ4Tjk4YzkyWHdONVcr?=
 =?utf-8?B?V2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 421391bc-bfd7-456b-5bae-08dd159d7f19
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 02:27:14.4407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uShxwDeI0lkSFAkgzwY49Mq6hkGuv7ovCC+RPWvff6QoHe9rvVp/Xj8+66x3F7LWJqCPFJZTjzCEWLuBSRG99Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4518
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

by this patch, we confirmed the issue gone on both platforms.

Tested-by: kernel test robot <oliver.sang@intel.com>

below d18114f8dcb33d7ed6216673903 is just your patch

on Cooper Lake in our original report

d1aa0c04294e2988 13da30d6f9150dff876f94a3f32 d18114f8dcb33d7ed6216673903
---------------- --------------------------- ---------------------------
       fail:runs  %reproduction    fail:runs  %reproduction    fail:runs
           |             |             |             |             |
           :20          75%          15:20           0%            :20    dmesg.BUG:soft_lockup-CPU##stuck_for#s![usemem:#]
           :20          75%          15:20           0%            :20    dmesg.Kernel_panic-not_syncing:softlockup:hung_tasks

on another Ice Lake platform

d1aa0c04294e2988 13da30d6f9150dff876f94a3f32 d18114f8dcb33d7ed6216673903
---------------- --------------------------- ---------------------------
       fail:runs  %reproduction    fail:runs  %reproduction    fail:runs
           |             |             |             |             |
           :10          50%           5:10           0%            :20    dmesg.BUG:soft_lockup-CPU##stuck_for#s![usemem:#]
           :10          50%           5:10           0%            :20    dmesg.Kernel_panic-not_syncing:softlockup:hung_tasks


> 
> --
> Regards
> Yafang

