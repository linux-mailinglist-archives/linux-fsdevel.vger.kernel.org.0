Return-Path: <linux-fsdevel+bounces-36299-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D514C9E1192
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2024 04:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 464F5283312
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2024 03:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7BA13B2B8;
	Tue,  3 Dec 2024 03:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K3ypQwzF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED7BA59
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Dec 2024 03:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733195072; cv=fail; b=rwPTgPBF/HyhslLAzW7Y74Zi8Vy2y3svatmcjfEKIg/qSPPJCF+YuIXTPWn9/z5hP6jROZIW8Na2XWBLExckrBRNpsov9Gp4+xXwxFBykhP43b+rZ6QPzXbeACL7hnKfZ9U3z2tDdRanReGGuAEaALb52GAd+ROIpqGZjC/DRJ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733195072; c=relaxed/simple;
	bh=2gFRHEnMpy7xR7RQc5YauyZX8cmti3p+M5s75iKWsXc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XxK4n92Jk8bl4G4uJfjUfcVn8PG/EbUpe/znsE25b/of5WgYmZH7Es8TbvLlTfS1QC90Ur7jSVxXDLiXaxfD+iMIbHC1/i1NVtA3NpkS37SqNeVdQlxXuv98NCYBnhvBbOuwxOaPM5yNOer/hQFz/bMeQPe5P1wHOdRoR2yhuY8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K3ypQwzF; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733195069; x=1764731069;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=2gFRHEnMpy7xR7RQc5YauyZX8cmti3p+M5s75iKWsXc=;
  b=K3ypQwzFCWkkoAKjnt/JORrDf6ayltPoWHgGOApMrWBtU0jtZHyblF7G
   gQu0cYss17LlNIpedfM5tsQAB6puL2kNM6XXb/Uj9dfPTMbhcEOGy7nrJ
   /H8YZ++UovI/7P2xM8KFqt62ytyjbSlJBJ7A3QPProvvOizrJ1EfQFUdQ
   F/YmtKwavC90AYkN4Lfqb+wDIWSahrMRatk8QelRG7S/CYdiZyUpUvAv4
   zLI1o6McTED6lnnfD0ocDsBkJadHtvdf/6SibwcVWdP/xKnUoLqRbRuLH
   Tzn4HNBVCZ3DcSiyrN/jbm/slCGplK7z19jmu2m75PJ4SAh5O+lh5tLgz
   w==;
X-CSE-ConnectionGUID: rNjKHo/jRQG0POVUNH2mCQ==
X-CSE-MsgGUID: TJAO2XWBRvGSh+cQsl0dSQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="44424223"
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; 
   d="scan'208";a="44424223"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 19:04:28 -0800
X-CSE-ConnectionGUID: Cj/etIRHRZCnzOyR936XXA==
X-CSE-MsgGUID: UAFX/jg4SluFVO2xYltIBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; 
   d="scan'208";a="93193128"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Dec 2024 19:04:28 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 2 Dec 2024 19:04:28 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 2 Dec 2024 19:04:28 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 2 Dec 2024 19:04:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SOW7XtO6g9j0ousavoUmM4rlQT/bQXbSYTKqRb0gMtGk0gI7wlXtP+uqfspdlY6EPrEETyBKlrMolPUEjIGi/I+O+Jd3E/L8K1Y3uwCfdFSNWrzEXZIBEjABY824Aethx1vDHbUj06tRI0Gj/LNKj/avXfWLqcOfK16/rnGAl6529N2exZzBbLyZvdAXeP1veUF1a5nIE2cDfzAKL7dRQlABGCaRT+bDZn0ipp9pmOpvZI3ISkapL5OTDqORlveRyGFXQjJxIiNdlItPLzKtAxMcQ5M9FaDd72iZxBG7Wp4iuCDgA5uFXkiO0oSWcUClnNR26eGvmuSRYehR3VyxVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gomZL2sPl3xDVRBWCeasjFWin1f3b0pQWKeZWeWk8bI=;
 b=hexzrIQCdiKqFz6pBfdHdqlH48nwtijbtbN4xvcQCYRVo46ixr0FBt0eFGEIfOc+f9iaM44wQvr5Fwsd/3PAST4N5I6Zu5kzV1vM4/Ica4yKEyii3Rj3cqH8FUFJFi1C79x5Q7TooTcNPmn6IaCa7ZuPQpzZIrHsWYnp18Do1nkvvEDAQoImGqX65k+S6odjY65BFmWGN7D0EXQQBWlalm7qpyFs46R2pZMVDH6KefnaDp5FF8S4KZ6clXsyh+xK8OEzCGTC6RFamLSvaHGUROl+mz6BDod1COBmPhQj7fZbMEw6lsBiREH4yKmYjo8Tpy1bnbcQ+5lGGrVPlCgb+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SA1PR11MB8490.namprd11.prod.outlook.com (2603:10b6:806:3a7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Tue, 3 Dec
 2024 03:04:25 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%6]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 03:04:25 +0000
Date: Tue, 3 Dec 2024 11:04:15 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Yafang Shao <laoar.shao@gmail.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Andrew Morton
	<akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>,
	<linux-fsdevel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: Re: [linux-next:master] [mm/readahead] 13da30d6f9:
 BUG:soft_lockup-CPU##stuck_for#s![usemem:#]
Message-ID: <Z051LzN/qkrHrAMh@xsang-OptiPlex-9020>
References: <202411292300.61edbd37-lkp@intel.com>
 <CALOAHbABe2DFLWboZ7KF-=d643keJYBx0Es=+aF-J=GxqLXHAA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALOAHbABe2DFLWboZ7KF-=d643keJYBx0Es=+aF-J=GxqLXHAA@mail.gmail.com>
X-ClientProxiedBy: SI1PR02CA0017.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::10) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SA1PR11MB8490:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bb0b9e7-8ba5-489d-dc49-08dd13473169
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VVFSWUwwRDNFK2cveUY1NUNuam5tQ0VIRm5sZU1lM2Y0V2JWNFVqRzJxRWhx?=
 =?utf-8?B?NmZUc1JCNzVHYWdZQXA1ZzhCZDNKSWsrTGd5NTNxb0o4bEVwMFI1WVJMSnpj?=
 =?utf-8?B?VWZvWjcvY3BRa2RRdHlubGpVVkdxNHFUSlFoRFZKcld6aUdDd3AwdVd0VDVw?=
 =?utf-8?B?WlpJS21tb1dOenlQSjFhYkZBOTMwRm9ZNlk3bnVYb1Rpc3hNczFwVGhQYW1M?=
 =?utf-8?B?d1BtVjNNQXFtdm40TFd4U2g3QnpnOXR1R0FhVUdSOEpiSWc1RnRDVGhyU3hV?=
 =?utf-8?B?azlqUmE4cG9keTBhNmo2SDFOR05CREdPR1ByaDlzanNPQW85VWE5ZUVzNEw5?=
 =?utf-8?B?NExUY2ZtUmJDUXpVMHNTdUdiaHJ5ZThncmRGZlFjRlBHb2lKUlpZNDNuSXk3?=
 =?utf-8?B?QmJBeTRmNHp4cWFseDJtZzlSNEtsY1Erdm9Ga3psS2VLNnZqUkloaGtGV0Qv?=
 =?utf-8?B?RmsrYm9KTE1ZUkUwZ3Bsa3VtQmlEVnR2UWpNc1dRNzRrUldYSlFyL3UvOGxk?=
 =?utf-8?B?VUcyTkh6OG5sTmlKaC9EL2VtUk02d0QzTzlhWHh3T25lOHorVHhaMjgwRGNU?=
 =?utf-8?B?bUMxakZQb1dkSGNuSlNDTjVPQlBuRjA0T05PaEpERm9zSmNpcGdzOHhidkVR?=
 =?utf-8?B?dXQ4R1NMR3ZOSWVkNFhlcnovVVpDNUt0c2U1UUV4eS93S0hGTDc2YlpnV0U3?=
 =?utf-8?B?NUVnOHhpeDlUR3BUZ2lWWXVZZ3dHZDAxaW1qRW1TZmZBdHRmQVQ1S2FWUUpk?=
 =?utf-8?B?OEtla0FpVCttb25pSklHS28wcU1VbFo2bTNKOUZ1ZWR3ZWJ5OUdqdmlPTGE0?=
 =?utf-8?B?OVpLUGxJSmJpVzlpTTNxVUVnQnRIRmhRNTFUN0ZQM01lMWREbGRtMWtXSThw?=
 =?utf-8?B?RVZXWTVUZnJ2UEdhZlBLMm5hMCsxWEl1YWpxS3c2TmdtMkt3VEVrVVBsbmZX?=
 =?utf-8?B?SU05K1hRRW0wM1JtUDJSR3o3NDBrMVRxUnRTMDNXY0NQVUQ3dUpjZHQySkJi?=
 =?utf-8?B?aVRLZkZDQ1lxd0t3UTF3bElNeHpRbmF3TXh1M0xUc3R4clN5NzdpSmg4dm9s?=
 =?utf-8?B?QVNSWGtSS3U4a3hPWjVpS3l6bTZXVm5QZVowUnAzVEpjNUhoN1ZCM1N2cy9K?=
 =?utf-8?B?QkU0T3VkalhKN0xQbndQZzRpWWdvcHdzTkora3lxaVo0ZXpMTTRwZmtNLzJM?=
 =?utf-8?B?aVpjQkM0Zy9kTE5adkduY0NqU3E1cWdocms2MnpZTUF4R205NlhHWXA4WVli?=
 =?utf-8?B?TnpZOXA2a25ITGN0blcwTWZEWHhnMmYrRmhGdTMraGpCRmJGWGc4N1k3T3Np?=
 =?utf-8?B?dU0raE1KUm5oYWNIT2RCUkJNcWFPcW5nYVo2Ry9lQ0lRaEU2Yit2dHhwS0VU?=
 =?utf-8?B?dHkyb1JMcXN3YlNLdFpxZXZwN21selFxN0ZERzc0Y0lwQmNrU3B1b0tOQW1E?=
 =?utf-8?B?UHVWTGxrMmx2WW01cWFrMGRPbnVxYzRoTmN2aU56MWJkYklVakdibEttVDZH?=
 =?utf-8?B?VTNzcUxNVWpNVGJ3R2pEYUxmSEtxOWhSYk9zMlEvaDI3c2lTZ1R1OXRMemh3?=
 =?utf-8?B?VnVUWG5jRXRna2F0T1R0ck9WbmdQL0hiQ0hSS01BU1E2RWZBRnVxRVZBOHFL?=
 =?utf-8?B?M0FLMHNSbEVKZTFYM1liYVJtTnFzRWtwS3FuYktGQlE1WUtmV1hHQXJHSVpl?=
 =?utf-8?B?Uk51VVFjOEZvQ05zOWUrcVQ3NFNYaEpmdXZFeXlieWgvWk8yYkVYZUtGeDhp?=
 =?utf-8?B?Y0g2TXdWd014R0lZSTZONVVSRUVVRkZBTkV5cnFBcmZJamFrU05VVDM0UmY1?=
 =?utf-8?Q?BEX1Ep5PBNJ5ajviwsioEsIavC+BL6eR2DZVY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0pOR1J1NDFUU3phZGs2eUpSWTJmMkI0VVFpblA2U2hFc1pKUzhrL0NGMjQ3?=
 =?utf-8?B?U0ZIclFkdHUwdXVoWmVkeks4cHFETk5RK1FlMlRrNmNKZEZtY3RjTXdnZ0ZU?=
 =?utf-8?B?U0c0TG81U0dQYitQUk9UWWNlS3daanJEWkFwSFdqSlppRE1vOFBxTDd2M2Nz?=
 =?utf-8?B?RmVXRmt5MlEzcFFPUkNRdndhYi9zeFVwVTdjSTVqZFZLQW4wSmhKZ1dPL2N3?=
 =?utf-8?B?OVZrajRQU0pZTmpYMXdvY1NHcFRWcWM5cHpwc0xGZ0RlcWpVTlpIek51Qy9o?=
 =?utf-8?B?NHkzZlhxeVFqc05SdjcvT1FFLy9RdEFvOW1CTUZTMGxKSkYyUmNmRmQ2Mm1Z?=
 =?utf-8?B?UmY5QTkyM0tibFRQemIvOTR6WHc3c1J0bFgwckJjY041SThUWitsUDVCaHpz?=
 =?utf-8?B?YTFrTy9IUmxvRis0THFERzF0NmdYZEtVOC9YMzJnOGVicjFnMjVTTEFrVkdz?=
 =?utf-8?B?MDIzdE9KZi9MaFM5TVBJS0dTVVJjMzJyaUFKNlhjWkJsTHlVTGJQOVBOUEYx?=
 =?utf-8?B?RFF5dlA1ZTBMVFA5cjU1TlJ0Tk1FNGJUY3V3S2VQcWhpNWxiQnZ4a0FLQ0NW?=
 =?utf-8?B?c1NHdFRtTTkzWHRYVnVnMndMUkdZOFI1UnFsUFRncEtYSmxsL0hLZ3VlYmZS?=
 =?utf-8?B?MUQySnF2bG52Y1Fyd0pWN2tsdGk0c2FDQ1NjZVNtUVNRcjNqK0xaazRkTnJa?=
 =?utf-8?B?K3FPVEpmTDh2d041eUpYVmdpTDRKRFFQMWZXVlNWVUVpcVU3aGN1VHlHOUho?=
 =?utf-8?B?cjRPSndZT2FRNFIyeWpSYnJKOTdiNTBMKzBSSkVtenhiZE94Wi9ZekVLd3NB?=
 =?utf-8?B?cTNtTWdlUVNtV05JMkdZcHFZckdjYS9VTTMrV2tJMlJacThORkljREY2Zitq?=
 =?utf-8?B?TDl3d01qRldEWmNScG4vOFB5Y0dXNGV2QWExV3gyUjhMQVZIR3hhVGRpMS91?=
 =?utf-8?B?ZXFDV3EyeW1KV2ZPYkNJWXN1WG9TcVB4QlhBMGVMU0laYmtFUmFaTitLeGNr?=
 =?utf-8?B?M0Y4b1hDQldPdjhkZWt2VEZpaDlyc0UvQ1dxaDFEanNqajFXdnh3OUlWZU9o?=
 =?utf-8?B?MGtWRlU3UzhzcWJhSUxtWFVtRHdKd2J4bXZoTVdSdlBFT0FIRitTRUhrQnVu?=
 =?utf-8?B?c1lMaER3dmJGTjVDTW5QRFNPVU1MNlNaOU5aay94WFplaEVhdFFsMytHNkw4?=
 =?utf-8?B?WkJtUW13a1BMR25oa05ZOEZ3YUVETTVNTXdjNWV5QnVMejFkSnlhcmJCSDJx?=
 =?utf-8?B?U0ppVTBLM2VRTXhsOE5YdjVvQUhLYW1FTmZUVVNncVZQYnczU3dQMS8zWTZQ?=
 =?utf-8?B?MkpldXp6WTg1UEFsaEpjaGcwM2IzTE93NVkySmVhYTdWaXJNUWo4RjFYdURZ?=
 =?utf-8?B?bURjd1YxN0MrOWZGVnl0VnExZkJrWUNxVS9Yem9hTTJLR1VhL3A1VytMMWhG?=
 =?utf-8?B?NFEzMTNoNWVyTGs3Rk1UTGorMDRJSURnd3Q5Nm9xYUVkaTcrRURRbzZLS3Rs?=
 =?utf-8?B?NW81dVJBbU1BbnBITWs4WEZPTkxFcnFWM2FOREFrWUxIcFJaaE1WejBZQTFl?=
 =?utf-8?B?cS9OL2hacG1sS09aRjRpb0VtR09vNm1Ddm5kaWJSTEhLai9xL0o2eW03dGk1?=
 =?utf-8?B?KzZSR2VaSmdNWFUxQVNWejJwaHFpalJFTjBmVVNoamRYcU9vcG1FZTlxZkZB?=
 =?utf-8?B?S05sT1dyYkRlMmJMZC9kbkdlZjkrcWlaZHU4cVNEVDFQUlhrQ1FGclFEQ2dL?=
 =?utf-8?B?WlhESHUyemxNK0t1L2piZWE4MWhRZ3pJWUxCRDNIRHJTdXpWOGY4bHpIeVY3?=
 =?utf-8?B?TzBXdDRZUTVLdDAzYjV0cmNhYlBiK2FUR2Q1aVI2UTc0V0t0cHVYYzc5NHR3?=
 =?utf-8?B?WDZIekF1R2ZUaUdiS2NGWU1wb29kVFJrWlFQREhGN0xTODlpa0IrcXhWQVRt?=
 =?utf-8?B?MXpOeTZUMkUvNkpUMWM1TTBwL0dVN1pKTkVsYjM1WXZHUmVNUFBOdW9pK3pZ?=
 =?utf-8?B?dW5tUTlKYitrMi8rODJsWGM4L0Y2cnhqcEUzUUFkYU1MNk9ZSEhJL2dQbThG?=
 =?utf-8?B?aGtsV0pWdHJyRTZYWElIY2ZaOC96UEVNWitnMy9tVDRtSU80N0lDN3l4aDlD?=
 =?utf-8?B?TysyRllVWjlmSmhPczBuVTVYMGE0cjBlL3ZaL1Rkdkw0dXhhbVNGbHYvMEJv?=
 =?utf-8?B?SVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bb0b9e7-8ba5-489d-dc49-08dd13473169
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 03:04:24.9921
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jVdhw5njUoB3OlKtc1Jl2W47nLCADMGw7ZWXkVwuL1UQrq202zjGpd1FHjuZJdPWrkcPQwEmP4WeSqWNwB1/pA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8490
X-OriginatorOrg: intel.com

hi, Yafang,

On Tue, Dec 03, 2024 at 10:14:50AM +0800, Yafang Shao wrote:
> On Fri, Nov 29, 2024 at 11:19 PM kernel test robot
> <oliver.sang@intel.com> wrote:
> >
> >
> >
> > Hello,
> >
> > kernel test robot noticed "BUG:soft_lockup-CPU##stuck_for#s![usemem:#]" on:
> >
> > commit: 13da30d6f9150dff876f94a3f32d555e484ad04f ("mm/readahead: fix large folio support in async readahead")
> > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> >
> > [test failed on linux-next/master cfba9f07a1d6aeca38f47f1f472cfb0ba133d341]
> >
> > in testcase: vm-scalability
> > version: vm-scalability-x86_64-6f4ef16-0_20241103
> > with following parameters:
> >
> >         runtime: 300s
> >         test: mmap-xread-seq-mt
> >         cpufreq_governor: performance
> >
> >
> >
> > config: x86_64-rhel-9.4
> > compiler: gcc-12
> > test machine: 224 threads 4 sockets Intel(R) Xeon(R) Platinum 8380H CPU @ 2.90GHz (Cooper Lake) with 192G memory
> >
> > (please refer to attached dmesg/kmsg for entire log/backtrace)
> >
> >
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > | Closes: https://lore.kernel.org/oe-lkp/202411292300.61edbd37-lkp@intel.com
> >
> >

[...]

> 
> Is this issue consistently reproducible?
> I attempted to reproduce it using the mmap-xread-seq-mt test case but
> was unsuccessful.

in our tests, the issue is quite persistent. as below, 100% reproduced in all
8 runs, keeps clean on parent.

d1aa0c04294e2988 13da30d6f9150dff876f94a3f32
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :8          100%           8:8     dmesg.BUG:soft_lockup-CPU##stuck_for#s![usemem:#]
           :8          100%           8:8     dmesg.Kernel_panic-not_syncing:softlockup:hung_tasks

to avoid any env issue, we rebuild kernel and rerun more to check. if still
consistently reproduced, we will follow your further requests. thanks


> 
> --
> Regards
> Yafang

