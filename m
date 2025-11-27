Return-Path: <linux-fsdevel+bounces-69957-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AEB0C8CAF6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 03:42:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 264CD4E02BA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 02:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B802B2848A1;
	Thu, 27 Nov 2025 02:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gHPsRD74"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E44F21FF23;
	Thu, 27 Nov 2025 02:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764211332; cv=fail; b=KTuuL+k2qfT5d1SAJOSghVQlGvTf16OgFkQQhamL467rIMXrgCAaSNyNdiIDuFZEDxTkunM+i9TfpECyByn6srNe8Q5t7EsYEQroiPKi+CBQyRsY9YVcIA5iPKHzRcBeXEUtvtSqmZfujp8Dv/DycYcU1jS26bsTkBaWo15CHPI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764211332; c=relaxed/simple;
	bh=kSuXUNxotIE2+P96FIyK/iViU7usBJypXVDSXGqK42g=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=G7UiKY2IUUyKQzrlrsxpiOGGUMUvIYq/jrGR/O53wDOj3SyIYcizUSPxD6qc3q8WQyFEUVq0F7W7budSLyJ6AomE+XKTxoxdXzgymflqZ+lTT54OTW9COn7aD0SL4vi8PSyJRjm2L5ch7wERQ1HHLloLEz3UaOW5aWCW0PENEEY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gHPsRD74; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764211331; x=1795747331;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=kSuXUNxotIE2+P96FIyK/iViU7usBJypXVDSXGqK42g=;
  b=gHPsRD747EQtei4JETFFkZF31LUGAA4FFsnWNKss9MEfh5D+ZiIaZdpv
   5xf5gt07GhrMKiVZBgz19U485iABz0/bKEvPhxyfGhEs08pWZ0a71Z4qp
   5SOOC9mmturQc0vB0oGPsaAmxKtgvaDBuADEYetBSHGzPZoIg/1qaHK6h
   II8PDayCism5eyL96YHOM7jFZa3S6iyPJR43ABsi9o7zpaMqnCP5vmKDk
   ZSFmWBAmQAQbznfimOr1xi2UWuUa+sv0oZffTlvqqzmwY0Iozy5/cNfNF
   FLzHaTClULp1YyehDZXIwAhkFw43ot3nz4lTgoROspNCLxJWjcV8LiWhq
   Q==;
X-CSE-ConnectionGUID: usYeF7PdShag1tS4NC1Cuw==
X-CSE-MsgGUID: JqO5pH/DQmCjgxJZ6VkFMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11625"; a="83647035"
X-IronPort-AV: E=Sophos;i="6.20,230,1758610800"; 
   d="scan'208";a="83647035"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2025 18:42:11 -0800
X-CSE-ConnectionGUID: 5WDThhelT0S7vwoDD71kkg==
X-CSE-MsgGUID: pcAjqG2dScCCDnoMzrgO+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,230,1758610800"; 
   d="scan'208";a="192236958"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2025 18:42:10 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 26 Nov 2025 18:42:08 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Wed, 26 Nov 2025 18:42:08 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.1) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 26 Nov 2025 18:42:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c7V/DwqEGhBlEnr4a8clnz+mAgO4hQNXSDTzDWnjJQRS8bKPmlV768euA3cFhNKqIgo6qP5p/hVoqba0dJiR27pIo6wwc3nZJrmDTepA+F4q8/3dJHzEJ26/w+a7BLMq33eTA2Y6yf7dbSR9Q6GuppD9u2PiuXo3JgR75x0TvxhAXDNt/vO31F23xDC2vePKJLtUHBpxDNtW2fbBwkDjIMDBXiuBSF8A3e1bcHbg6lgwePCvyAJ8wamC5H08gZ3OdoMFXHPANimERnsy4im51+9cGnr1CWq0EICDOQTPIOOuvAp8ve++XL0dPxS3e9mlx3ydySDri9vDi58FP38/aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kc/Fu42HvQRROIILnvjoAmhl0ZjQlzJpDIMvU3UXbtM=;
 b=APZTGl/CdSLDWqKn5rAQZ0RQKjj6ENPvQ4fovPBrBbqr0y9VAVKwKPlSuJnDRaYnfvYzH8Frhzi4HHNI8VNkSCu/513XttPBjFSoR1JWArR+h3t33L7CcbKGRIws7HrJvHzN4WnHGQswror4VPMgP5vbmIjJgQOUpksULX9EuGjcipzNXMZL+bX3XSuimcwCIA86lwcj/5L/tAZrlvLgbK4ufiM681kt+vyttFf8ya2y++0xKwIakYDeNZutdTO7MoNAhw6hTkSDSTYjquUZqMl+UsWwetAcpF49me8+L8of5ECdEgl67/XL068LOkyUoKPXzDdwA/wBoaZuSJ4xfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DS0PR11MB6446.namprd11.prod.outlook.com (2603:10b6:8:c5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.13; Thu, 27 Nov
 2025 02:42:04 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9366.012; Thu, 27 Nov 2025
 02:42:03 +0000
Date: Thu, 27 Nov 2025 10:41:53 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Amir Goldstein <amir73il@gmail.com>
CC: Christian Brauner <brauner@kernel.org>, NeilBrown <neil@brown.name>, "Jeff
 Layton" <jlayton@kernel.org>, <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
	<netfs@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
	<linux-nfs@vger.kernel.org>, <linux-unionfs@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: Re: [linux-next:master] [VFS/nfsd/cachefiles/ovl] 7ab96df840:
 WARNING:at_fs/dcache.c:#umount_check
Message-ID: <aSe6cWAoUpEWL44E@xsang-OptiPlex-9020>
References: <202511252132.2c621407-lkp@intel.com>
 <20251126-beerdigen-spanplatten-d86d4e9eaaa7@brauner>
 <CAOQ4uxgHqKyaRfXAugnCP4sozgwiOGTGDYvx2A-XJdxfswo-Ug@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxgHqKyaRfXAugnCP4sozgwiOGTGDYvx2A-XJdxfswo-Ug@mail.gmail.com>
X-ClientProxiedBy: SG2PR02CA0089.apcprd02.prod.outlook.com
 (2603:1096:4:90::29) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DS0PR11MB6446:EE_
X-MS-Office365-Filtering-Correlation-Id: d6c3b2e1-176d-40bd-ac0f-08de2d5e8c50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N2tOUVNab1pGemRQdU1QQ3RseGk5ZUJrK0hOZXl6cDNsSkdCTjhNV2pkN01Y?=
 =?utf-8?B?WjFJWXRqb3h4YWdPM2NWY241RmxibVI5b2dkRks2dHRjN2I0Z1NBM3J2Zm5s?=
 =?utf-8?B?L3QvMGFlYXpGbGdrY1pQU1pqdWl2VXkxcDVCd0U4SDZlenJ6NEZ0V1NsUU51?=
 =?utf-8?B?dGtaVnBTUHovcDByTnpKVkJ4WWpVUHYzbkJWeXQzQ0RIUWhjT0ZCV2FSZUVr?=
 =?utf-8?B?WUlYLzU2Z0h2cFc5SC9ETnV5OTd6dm1HMi95cHFETHpyU0RTc3JKMis1OVR6?=
 =?utf-8?B?dzA2ZnNzRkNTRTBkRXBXNmVHenhKVWNwWTNHaUhzbVBJbUFJWGFxbnpRdGhn?=
 =?utf-8?B?TWVaSk9NWkprMkVRa0hOTWRESFRtOVcrUmcxaXZXMDJndE4xQzBEV0lEc0pV?=
 =?utf-8?B?Y25vd21kN1FVRGV3d1pPTGUyckl0T1NzaW82WTFBSG5MR2IxcXU4ZERLZ2Jn?=
 =?utf-8?B?eEJZVzlJWERYM21NZHlqM1ZIUnBKRnNsZDlyemNKT0RmelRTeFhLNzFaeXdv?=
 =?utf-8?B?L1QvendlYnlmT0hvN3M2dEVYcE9DM2l4V0sxZzd2Z2pGcW5kcmRuM2cxcjZX?=
 =?utf-8?B?UjNPaFFhcUVxbHZhS0VNRzhxcmdGV01HVERydFp5eHZWZncvNFB5VUUzWitw?=
 =?utf-8?B?bnlKQThmSmdwQU5LYW5zWTJlaHVTd1ZXZHBXUVV3MUQ3WW4weXNzY04xbld2?=
 =?utf-8?B?YTI4QzA3eFJ1Z1h0VkV4SVBnTnlTWmdWSExNZ1NFM2E5TFgrRkt2RTlRblpx?=
 =?utf-8?B?MmVQWHZ2V1piOC9BWEVqcGVlSmZlMHFXS0VPMUxyckdaY2Mzbi94OFJPY3d2?=
 =?utf-8?B?Z0dFU3RGRTJMQTJSTHNyc00rcjYyRjRxVklyL2lHMEtWamd4eXlrMjBDVzAx?=
 =?utf-8?B?RzZhYnhoMnVueVBzSklBNDFlMndNUHJPYnpnSHdNMHFLSXd0MDNtSWRyREVT?=
 =?utf-8?B?a1dzOWZFYWt0d3FudzExRVZDcVNpWldkN0hUamJVckpQcEJyRUNEVitncHJB?=
 =?utf-8?B?dmd1VW5qbDlUVVNkK0FrZFBYTnUzWEg1OG5uSi9kdmd0MjhwRlJGK2FScWdp?=
 =?utf-8?B?dEpaNHRiMzd1VXRUR2xmRTkrTTMxTUQ3V0M3eGd1ODBqTVVva25DV1Q3ekl3?=
 =?utf-8?B?OTIxTDMyRlNjdGlsb1RyckpweXFiZXRKZmZ4WUpGWnpISmFvSkY0OUQyTWti?=
 =?utf-8?B?QzhrbHp2M2FmYnZ1Q1U5U2wrZ0tyMDFNY3liTkxrM3c2K0Z3QzRjcU4wOXFp?=
 =?utf-8?B?bmpEamJGazFuQjNETk1PbWNlbGlORFluQWRKeDJORkpDNXZ2OXhhTnJOMGtR?=
 =?utf-8?B?S1ZRdlA2VFYwbWlXNVR4cjJGVTRxNGxnZVBGbjg1REswT25qUEZWL1dtcDA4?=
 =?utf-8?B?Q2YwaTQzd3Y0ZThTb09tdmp4WlB1OEFFbmJLQjQ0dDFjV1dJclVGeWJDY0E4?=
 =?utf-8?B?THM0c08xTVhlZ2FyU08wYnpJWmJqcjJWL3JOdlc0VWRnWjdqR2ZuY05SSDd0?=
 =?utf-8?B?b1RXRTczcEw1ZVF2T0lzVnN1eTh5M0lnUjBKOGNiaE16bkVWa3ZCUFAzcEVU?=
 =?utf-8?B?OVpZdUNuYUZ5YVo4d2pXSnloaXBTbGdCZ2FNKzZFaFV3NHo5bENuTHJtOG1w?=
 =?utf-8?B?ZzBiWjU0SHU2Q1lKWktnM0lWNngzV0NKV0lDTDFGbVBucGtkMlFCSDlnbzI5?=
 =?utf-8?B?bWFIT0FpTGZ4azNaQmp2TmdSNk40T0NRSVozckVuUTdqTkl0cC9oellIT0w1?=
 =?utf-8?B?Rjl6NjYvNGswTlZHNEdBR2oxTzFaZ3JWRm1uenhYUHdRK1BwVElZMkc1ekps?=
 =?utf-8?B?YUlrdVpWT3h0SkovUzVRVjFvcXcvT1ZTNDYzY2xnUlB0WVJnd21qLzJXTU5Q?=
 =?utf-8?B?ZzRwRU0ycXNXeFMybmdIZm5LRTFFWjA4eTVVUGh0UEU1cUVQK0Z1UUc3VStZ?=
 =?utf-8?B?alIvSWxkb0IwSmlPVkhpQkg3Q2ZYZmZEUGVtLzJMdkc2Y1NNUkRVbDhKVE9G?=
 =?utf-8?B?Z3dXaWFCZUtRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aC9YcUtxMTVCVTJtc3V5eEhtMGhxZ2NmMWljNm9ZVy8zZVdET01ZQk5LMkJH?=
 =?utf-8?B?czd4Z3JBQ1pCQW5rSUVNbnlBS0Yza09nSVJweXVJSUNuSVgyaFVkZDlIT1J3?=
 =?utf-8?B?MjZyNzBWNkpvSXVZVVI0OTVDZ0YwSEFmRTN4bHcrTW5wU1ZlN0xWSHBaZkxq?=
 =?utf-8?B?VFMvMDc0UjJ5Q3J5TTZzUjNyWnhKLzlvSjZCejhvbFJTc1Z1endkRUxZWjMw?=
 =?utf-8?B?cmRQUVl0Z1pyMzdqdHN0VzBpOE9McGJyZWhWY241cGY2Rlc2elZNbXNwWlgv?=
 =?utf-8?B?TWRKODl2OUNaVklUQmVHYnczNUlpdXpGK0Y1M0w0QUU0RW0vQ25EZlAwZXgw?=
 =?utf-8?B?M3owc3lqc2ZBUHo2ejI5eTl5ZUpqV3c1TW9HVlhwUTNJM0xSSHdYT3dQN3Jw?=
 =?utf-8?B?aW9YOURDMVBLZGNUdUVLRDFmWWhTYlY1dkhYMitqUlBhYmlZRGJKUkdDVU4w?=
 =?utf-8?B?aFRGeFRaSzlYaFY1RFBjSzdwSy9rODhOWFMyT2V2WkJyNUZ2djlGeVl5UEFs?=
 =?utf-8?B?YW5pNnB5TEhja3JWcUlKakZad0xiaUxRSXRQekQ3YjhVdjl0YTFYbzdsbnBR?=
 =?utf-8?B?UHN2TFJLN2RjMDROWExCYndEZFZGYmk4dE9pRVZCa3BjaGNyMzJPODZpZTl2?=
 =?utf-8?B?clFjcjNrS2R4dit4SkwrS0NZSi81ZERPZFoxSHpuVHVQblE0eGJ2WmhZR0NV?=
 =?utf-8?B?ZTRGdW5KL0NheUZVR0hucmRJQ1NTRWVkTlMzcXVxMk9pYXo1QlI5SCtGS3Rh?=
 =?utf-8?B?NzF0NGN4RVJWYUlmRjJRTHBFUzdKY2FMcjZKWHVST3IySEVFMlMranJlalhy?=
 =?utf-8?B?VW9RNHE5RDlVZUJpM01ISWZsdDZvbnJEUWVNY1ZEc2VMNEpaazlZMlR5c095?=
 =?utf-8?B?UkRORXlkeVJHajhaZGE4aHh0ZFB3YUlsMmV3QzhHNWpKUStmSWdsOE52TUJO?=
 =?utf-8?B?QTcvelg0VFdYWGJqeHJneW02eUM5bUs3ZHVwS1lQTFFNaXFaQk4wVzJsc0JM?=
 =?utf-8?B?TXBGbU9KYUZ0V25QN0txSVA3Z0g3ZGVBYTFhelpjY3EzdjR0eE5XNWZRNnN5?=
 =?utf-8?B?ZmlUd0dselFJMFNaTTd0QThkQ1lTQWtRS0pqSXlLUWtsZk9ZckUvRmhyTDZT?=
 =?utf-8?B?ZVVGUWFKM3lDd2dWNmJ2WUJUaFJsZi95UUUrOVFucEt5bllCTjZmcG83MHZK?=
 =?utf-8?B?QnV4MlN2UXQ1cmpteEdmOFNsdU9tbGZSNGkxdFhBaVdPZEN1UmNJb1ltQzUv?=
 =?utf-8?B?Nmt1MDZRZU9uQkgya3YxM2VsdS9lUW1NWitlaWlEOVJ2cUswQm0xWmFkblBU?=
 =?utf-8?B?RnNDYndVUm5rMXJRYzhRUVpxcjJ2S0RZaHJIQk4zS09YV1RaeU9ucmhiN0hq?=
 =?utf-8?B?VDlJWnRRK1JuZkVBVlN2b3ZzUnd6ZGdHSG5wTGhETFNReXlXNVdlcUorMzd0?=
 =?utf-8?B?U253K3N3T3k3Z1NrQThEM0N3RUFmdVJCRWQwdzJjdWlXSW9oY0VHdHg0a1ZX?=
 =?utf-8?B?TnA1Nk14M3lLdTJ2SkRxQmJ3RG56YTJKYm51TldRRW5LOFEraThnVWZGQk95?=
 =?utf-8?B?Snk4dEZoSWJhYWdjcmZvN2RWK1NuK2JPZUlycWtzajRNcmNSVnJaVEVBMVZx?=
 =?utf-8?B?N0sxSzhSUFFtS2FFRzZPVzdQMUdCM2RvVGNFbW1zaFRZYXdkNkt2WXVFTi9Z?=
 =?utf-8?B?NUtaZ0Q5eFBicTdPTXY2R1E2TlVPRnBGeWpvTnJSS3g0aldWVlN3RWZMYjkr?=
 =?utf-8?B?VjhGUklORkwzTmxwZ1BMS1BoNlFSeTlDdlg2bVF3bWV2NDEwTlp4VkRaaGI0?=
 =?utf-8?B?a21UcHh0eWY0MDNTUGQ3NVUrZkhpMjZmN0owN3dsNjJpNGprYno2MmV6WkFj?=
 =?utf-8?B?TzUwVUV6MVlJWUU5YWM3czBVVk5iTWFYenpwcHBMWTNITEJQRXRPbHFUQU5F?=
 =?utf-8?B?VWhNVDV4U0xzVnBjNVVBYk54RXJCR2l3UVBSdEtrSjRneHQ4N2JoUitVQTRB?=
 =?utf-8?B?UkE3WUQ2dTYyRWZLTTVHa0N2K0czUUtlS0FTSmtnSEpEMDM0UmM3YVhrdVJn?=
 =?utf-8?B?QUFSdDFqRG5Pc0ZVOTVJcEtCNU1DNnZod0xMRFZwYXA0MWwxMnhtOWNjNXB5?=
 =?utf-8?B?N3BVUGU5MStWNy9Oczh0MmxlODc1MGIrM0RxU25RU1VodHlBVlQ2RXExWjI4?=
 =?utf-8?B?YXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d6c3b2e1-176d-40bd-ac0f-08de2d5e8c50
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2025 02:42:03.8134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MG2I0n3ed7OCrescMrZ2bkyLJ617YjzqDiTBWFLQtxE3TUwNktcqJySy1pAisLlsFMiSPnHbKjqYbykdOOtH5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6446
X-OriginatorOrg: intel.com

hi, Amir,

On Wed, Nov 26, 2025 at 01:29:57PM +0100, Amir Goldstein wrote:
> On Wed, Nov 26, 2025 at 11:42 AM Christian Brauner <brauner@kernel.org> wrote:
> >
> > On Tue, Nov 25, 2025 at 09:48:18PM +0800, kernel test robot wrote:
> > >
> > > Hello,
> > >
> > > kernel test robot noticed "WARNING:at_fs/dcache.c:#umount_check" on:
> > >
> > > commit: 7ab96df840e60eb933abfe65fc5fe44e72f16dc0 ("VFS/nfsd/cachefiles/ovl: add start_creating() and end_creating()")
> > > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> > >
> > > [test failed on linux-next/master d724c6f85e80a23ed46b7ebc6e38b527c09d64f5]
> >
> > Neil, can you please take a look at this soon?
> > I plan on sending the batch of PRs for this cycle on Friday.
> >
> > >
> > > in testcase: filebench
> > > version: filebench-x86_64-22620e6-1_20251009
> > > with following parameters:
> > >
> > >       disk: 1SSD
> > >       fs: ext4
> > >       fs2: nfsv4
> > >       test: ratelimcopyfiles.f
> > >       cpufreq_governor: performance
> > >
> 
> Test is copying to nfsv4 so that's the immediate suspect.
> WARN_ON is in unmount of ext4, but I suspect that nfs
> was loop mounted for the test.
> 
> FWIW, nfsd_proc_create() looks very suspicious.
> 
> nfsd_create_locked() does end_creating() internally (internal API change)
> but nfsd_create_locked() still does end_creating() regardless.
> 
> Oliver,
> 
> Can you test this handwritten change or need a patch/branch for testing:

thanks for the patch! but it cannot solved the issues we reported.
since we are now testing refined patch from NeilBrown, I won't supply more
detail such like dmesg here. if you still want it, please let us know. thanks!

> 
> diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
> index 28f03a6a3cc38..35618122705db 100644
> --- a/fs/nfsd/nfsproc.c
> +++ b/fs/nfsd/nfsproc.c
> @@ -407,6 +407,7 @@ nfsd_proc_create(struct svc_rqst *rqstp)
>                 /* File doesn't exist. Create it and set attrs */
>                 resp->status = nfsd_create_locked(rqstp, dirfhp, &attrs, type,
>                                                   rdev, newfhp);
> +               goto out_write;
>         } else if (type == S_IFREG) {
>                 dprintk("nfsd:   existing %s, valid=%x, size=%ld\n",
>                         argp->name, attr->ia_valid, (long) attr->ia_size);
> 
> 
> Thanks,
> Amir.
> 

