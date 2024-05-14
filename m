Return-Path: <linux-fsdevel+bounces-19465-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D09B18C5AD8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 20:13:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 062311C2199A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 18:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483A41802CB;
	Tue, 14 May 2024 18:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QySKiS9G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2551E487
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 May 2024 18:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715710404; cv=fail; b=gVEJfOaEAt7R7nIF/vCrRVeMp9wd+p/hyRX+fnVZeePz7PCuLZRKOKl74AfaeV/15NjQw5XqRCjpcyLFco+x4pJagcASJsMpMuVqPQCEmajkhJz0v4uBunDV4YuU2SAI8fEv5QbFT9TeHQqcIi7WGZvMfui2qJb5RQNConufrK4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715710404; c=relaxed/simple;
	bh=v7Uum+fETTHBYeB8fMJsl+5irHRtbo7CPOVqrsNS0lg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=isp4Y53k5B0aBDybigk8yV1AuXmrGPz8mOkZOK0c9/U3WA1S5fQNcxnOBhi8MsYMuP2+Pk8dQyup5IK3rTVV2iQdTOlYnyP5uty7DIRwC1aHitniMhDnjUvVIwZVfjIPZdGBc5I16VoMJSFEkT/AQWzcNruEu/15eFq4KuwOpxE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QySKiS9G; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715710402; x=1747246402;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=v7Uum+fETTHBYeB8fMJsl+5irHRtbo7CPOVqrsNS0lg=;
  b=QySKiS9G2A+v87JnX7o0bQGzSLNScZakAKfTYzf1witetEx3B3/vsZqc
   cCJdr0Pc+gojFiPEMd3NZATkRjFUSETn2dt52Iy3OXy0CSimhIh50G0dY
   ZlxGebAc6PK3PdK6BxflO3HOSxyKpgmhR21/bnS760VUkeVmPu8Ma7YiH
   ovFIRrP6Slxgi8LRUvG9JFuNa6HMJc+1HF0nn/5jITVHNDvKtHHs7yVJm
   JRiYJozZ9nzdyWwQTyFDPnQeNXVNBW4Y5ZB6Cf9zuCBjk2a1areyZ/l9Z
   ymlnVMEDlUnpfVjVdLjAz0r+ZvpopZHX3mQ0ua/864sVSIc6hbNf6xTHU
   w==;
X-CSE-ConnectionGUID: h5qdV6xtSIGoHSYnsVZNYw==
X-CSE-MsgGUID: qiOo9o+WQw6X6H/AIpsZ6Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11073"; a="34228541"
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="34228541"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2024 11:13:22 -0700
X-CSE-ConnectionGUID: 4xf23ZlSTeGNZU5xke5Y8g==
X-CSE-MsgGUID: z87zoMigSlm38nY3RM6+0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="35648843"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 May 2024 11:13:21 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 14 May 2024 11:13:20 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 14 May 2024 11:13:20 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 14 May 2024 11:13:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZL9K2NQM3VbHYtj+AfAs4suBcNAdXHkfpt9/0byJeoRKIdwSVHWbVLPKdxQjpqf0nsUMz12hv0SfnEX/4c7K1jcCaDc4RhTMt+I1nyg2kiZnfO7ISkp/qC3w3DhKamn4iVMmk4VOVvHg/DHsPw/vQhJ7QteSxGwoCcavWw2eOVRqynfAr6uXLCn9oKx2mh8RGFMQVz8zLMwMYnI8whd4aAJd0WwS/oqtUQm549ovC4+I0X+qoZx4FDqGm1Fb+sckW1Z9I8CTvY8BOeOQN2PVRgIhYjn+uNhQwnHsSq36UccudH6ssrpPpuC3F1yGKhVuyMsHq+/cyRrHMJuFRqoHzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BZtieGdlMLf8dMnTybHyqUEIo3EDJKvELHQFWnA6fos=;
 b=RdhzXR7L13YJPM0aeOTqqtmVBe7riKrGBW57iGbpGS+Sacmhr+/H4ZTOsYEmGg2Ws68okcizotCfcekA9ec1b8yfrK1c96ivXtB37StZqzuyXY1iFuQQ8Yu0vyrQ18ljUYfSExT4z0PE7p0IgUHQTCYnoKWhu8Zj6WybDZLI2tIOkYw8N0bF8mBfcD68EYnwc/7g/+teU2v+iOXig2lHz60ys1+MzZJ1Wn+5oxFRvxQL3rzeqF2+Xt1K4VpcN0er6ga+k/l2Qm0sj66/s34YzKK9H4wPg7UO/YmeYOc2o3I+1NM3tY7s2C5qTpV9yl0gFQKSeSF+vnXZpEFp6Y4Aww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8441.namprd11.prod.outlook.com (2603:10b6:610:1bc::12)
 by SA1PR11MB6917.namprd11.prod.outlook.com (2603:10b6:806:2bd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Tue, 14 May
 2024 18:13:17 +0000
Received: from CH3PR11MB8441.namprd11.prod.outlook.com
 ([fe80::bc66:f083:da56:8550]) by CH3PR11MB8441.namprd11.prod.outlook.com
 ([fe80::bc66:f083:da56:8550%4]) with mapi id 15.20.7544.052; Tue, 14 May 2024
 18:13:17 +0000
Message-ID: <3127eb0f-ef0b-46e8-a778-df6276718d06@intel.com>
Date: Tue, 14 May 2024 11:13:14 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] drm/xe/guc: Expose raw access to GuC log over debugfs
To: Michal Wajdeczko <michal.wajdeczko@intel.com>,
	<intel-xe@lists.freedesktop.org>
CC: Lucas De Marchi <lucas.demarchi@intel.com>,
	<linux-fsdevel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>
References: <20240512153606.1996-1-michal.wajdeczko@intel.com>
 <20240512153606.1996-5-michal.wajdeczko@intel.com>
 <d0fd0b46-a8ac-464b-99e7-0b5384a79bf6@intel.com>
 <83484000-0716-465a-b55d-70cd07205ae5@intel.com>
Content-Language: en-GB
From: John Harrison <john.c.harrison@intel.com>
In-Reply-To: <83484000-0716-465a-b55d-70cd07205ae5@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0291.namprd04.prod.outlook.com
 (2603:10b6:303:89::26) To CH3PR11MB8441.namprd11.prod.outlook.com
 (2603:10b6:610:1bc::12)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8441:EE_|SA1PR11MB6917:EE_
X-MS-Office365-Filtering-Correlation-Id: 6940f5ba-7924-45c0-ebb3-08dc7441871e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MHNST2NJU09yL0dkRHY4a1YzVkxEMFVldkNZOFlWRXNXSDFycldJZlV5QXRG?=
 =?utf-8?B?dlkwdkdYTjJHR1E3TFVJYURaeEE3WUlxcHArcXBvcDI1ZjkvUFcyUTJDYmNV?=
 =?utf-8?B?a2hmbTB0UXFWWWt0TmNKRXN4QWxXMmNLMi9rdWtwZW9CbDJGYjBOZVhFaUdh?=
 =?utf-8?B?WUQ2N21XV2tIK0tYQXpiM0t6NDVBZWVqclJ4WTExeHdpWVhKN2g5bENJSEp0?=
 =?utf-8?B?OUpiYWNRWmtDZjRycmxxUTRDbEpESVJ5RHRIWWpRNHZqeVBJOGVCVjROZEh2?=
 =?utf-8?B?S3hJNlNkd00vZHVvQ05wMVB2N1RMREI0RGViN3ZPS2FwTitIcFYyZEEwRXIx?=
 =?utf-8?B?SVluU0hWUUVBVVFqZmR0bkJIUjI3aFV1NFhnVFl2dzRLak9rWWZ2VFJzYS9R?=
 =?utf-8?B?azByNmZBTExVNWt6OE1OSWszZzBkQU9sUHJ5Y0pJTTRnemNXc2dxZlNvNGNK?=
 =?utf-8?B?SldmMnYzQXppalgvM0Fnak9YZTFYcDUyT3JVdnlMTFk4c0dLcGNtOTJRSDE3?=
 =?utf-8?B?WnRIZFpqeFRhU0JPYi8yYjZTYmVFcXhDVVkwOXZnNTNBRjFEd2NHQ3J5SUxp?=
 =?utf-8?B?WE1mdWNQVEVoMFQ4NENEL091c0RaZjUwNHZLajVOMHNsSWN3QUFiOEw4Z0lk?=
 =?utf-8?B?dGhTamtnU2NLSGlaKzkrck5NUDNFdnlIS2pXME13UUY1U2lDbWRraUhsYXRS?=
 =?utf-8?B?NlpGTDRsemdVNlNWemZycCtqQXd5RnFGM09seWQ0WURLbks0QmRreDQrelNE?=
 =?utf-8?B?REtaVjBuYVRESE5COTVZN05mMnIrL3hqYWVzUThKNFFTOGw3aXFqelFUcnB1?=
 =?utf-8?B?VjduZHBUMHdYSXJpeG5iR1JZaG10ZVBXTm9JNWJWQkpYSHFoUFBmSEEvcERS?=
 =?utf-8?B?NEhjY25TMkRacERlTlZWSExWZzJQQm5WNUNMQkJmYk1mbVBYM2dET1JwdXp4?=
 =?utf-8?B?UWxXL0dMTVdJVHpJWlFQVDc4SU1OMHpqNmE0MTBKM3FzNnFnUzBzY0FMeFh6?=
 =?utf-8?B?MzIweW1COU1oUVQyV3FSQ3hWOGdTZzNVZ1lyTXMrSDV0eEVBdEZWWVAzeXZQ?=
 =?utf-8?B?MXIyQUM0RjM2ejNOdWhwQ0xYa1FMeHI1MlYzQURqVnlTUjRNaFdnRHU0ZW9U?=
 =?utf-8?B?MTFFU1VkVC80YjErZml3R05IbWtkOGdpZFAwUlJOTlhxUUdyaDJVT3FjREkr?=
 =?utf-8?B?cWdvM293cmh0MkpDQUpsWnZmQ0JLWE5sdEpBdXEwSm1BMW9KQ0xSVEpYTnd3?=
 =?utf-8?B?SUtlTFJKZW1TWFZaRUkvdzhNT2J2RjBkTUEzODJhczNYeUsvTU8rTDdPdmRx?=
 =?utf-8?B?OVpYZUlnaFM5TFJtS0IzdTE4Z1FSZnhyMjRLRVE1RDRabjFaSnNXdEh4RkMw?=
 =?utf-8?B?VTlxV1NsZWVsd3N0VTZ4bDBPWlNuZkdCRDdZRUpRQlRIdTZSM0kyQ2p2K21v?=
 =?utf-8?B?RnU5YXBOc01Xc0FDM2pXSVZjb0FreEE4K2xEL3Vqemp6aWxPeE5SZDFjVTZs?=
 =?utf-8?B?a0orV1dSWWQvelJkUlRPU282dHpjZUlxS1Rqc3hoMm0vNkJxN1dXYzZZZTda?=
 =?utf-8?B?OFo4ZXFMbGFrRzhOMktnU2Naejh1ejJPTXRBZGJjVWdFQ3dXbUFheE9hZkZp?=
 =?utf-8?Q?hmqc+5afZSJiScTAN+biVkQlIBvYqNcYEY/kb9siV3oM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8441.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2IwSk1jZzFKNjdGTEJ4UGlodmcwSldFYXUvSk5ZQW0va0tKWTdLdHdCazVX?=
 =?utf-8?B?VTZidUdORTNJS0Z1TmpxOWNPSGgyVlNJdlZ5L25WVHN3RElLUHkyemV3MmNq?=
 =?utf-8?B?L05hMTZhTDErdmphalF0bGREc1J6NEZEblNxMjZ3cUVPSVJlS2pnaG1KbUl1?=
 =?utf-8?B?WWZ0USt1YzlxVC9KZGk1L0diM0VGYURmWFNUbjlUdTJ5ZWs2SisrR3lualpy?=
 =?utf-8?B?MlZRQ0phd1pFZnNxbzZjZ241dis2U0NkSkJkcWduQlNyd0xZaERrWVJwMS9Z?=
 =?utf-8?B?dDM1eWtPRnV2bWpDTzgwUlRnOUtpdjFtTGpkdnQ3RE11c21RZ05TMzlhTHVj?=
 =?utf-8?B?czY2aUdmeFFOZktpSkcyZTI4eTA2OFJ4bENhS2ZZajM1THVselU3NVVxNUVz?=
 =?utf-8?B?T201NzZ2Wk53T2w3OUxEL1J6VHY0ejA2YjVMTkdobnFsamU3Y3MybFV4bXgz?=
 =?utf-8?B?VDFGRkxrNUo4azg0TmkweVJyL2VoL3FrTHFrM3JhQUhMc3J1dC9vbHFUOTdO?=
 =?utf-8?B?WEdmeTZrcnNVTEZ6SEJxMjZLTUxUWVJwL1RTNFl2enZVMUxqallvb2M5cWZ5?=
 =?utf-8?B?SkFZMnp6MEhlVGRBTStjZTNmaGJKaldvRlZxeVBxanBsRXk5MGYrL1hwVS81?=
 =?utf-8?B?RE1WcUdhUFpNVHNrU25ENCtlcDhQMEpIQmhadW81eHExdEJtZHd5MktlQzZX?=
 =?utf-8?B?bWUwcWZMQjZIWFpsNXN4a04wc2UvMVg4QWM5RGJPY29mQWlHemZERmZDMlRH?=
 =?utf-8?B?blR0SkRFSTJnbnBCYmJHbEg3dkF5bjJmTTQ2MVRBQ1h5Q0ZOYVBVcjRBd3NW?=
 =?utf-8?B?Y0dNbXltVlB4eStXU1doU25INU9LSHg3S2s1V3pzZVZtSHFiVHlhTmoyNFdo?=
 =?utf-8?B?MEhINlFWdmFKRWxUVVRUbHhiVGF1dkJwU2ZTNW9WKzYrejhkNkU2Yko5cHZt?=
 =?utf-8?B?L2N5c1JqYjdpZnl1ZEpwK2JidDArQzM0ckx6ZGRLUGhxVTlpbWtJMlg0Q0lp?=
 =?utf-8?B?T01rdVZSMGpXNGFEUzFaMFBJS0dFNjNLdzdrc2NPNUg4WTVDYzNZZWpjSlRY?=
 =?utf-8?B?bGs3NVBqaDBlWVFLY0dueTZHRmViNHRIUGZzTktsZXlyTER6QzJxMnJTQlJJ?=
 =?utf-8?B?VGo3VERjbm5IVU1PNUplZTg0VTRyRHowemJiTmNicmkvRlBQTFpNY2hLbXJZ?=
 =?utf-8?B?Tmo1SExrWXhmYUNpZFROR0EzSGhCM1g2ZUF6TGFzd1J0MnZpNytXRWF4TU9J?=
 =?utf-8?B?bHNvSXBYSThkbHA4SWtyZ1VpT0tmR0pQMmlVV0hRMVZ6VDNNLyt2N0VXNnUz?=
 =?utf-8?B?RTJHNXJBRjBxUGlXakdBL3hRVC91M0xzSUphUFdyYnVYa2VSMWRYSXBuY3lB?=
 =?utf-8?B?TTNYUHhqSi9nWFdnN1dpN3VhdEErci9WWWEyU1cyN3I0dVc5RGc1MTVyd3dy?=
 =?utf-8?B?VFhia1BNNVlTTEF1eGhPeHlaZjhZL2FtZlJXQmY0azNhNWVaNHVFN1BZOEtZ?=
 =?utf-8?B?d1NTUDM5dkJWRENkVDVjQzdjYmRNWW56OFY2SzJyTlpnQ3htZkIvNC9rbkVp?=
 =?utf-8?B?UjRhRU85NktMZStQbmNJRnIxOU1aeStMVGlNMjBOZEVhWEN4NURTTmxxSGZH?=
 =?utf-8?B?aFZBU00rTmcvNm5QUnZuVXcvcDNTWmgxWFBaNjd2UWFaejNYRVRKNVZ5NlhD?=
 =?utf-8?B?blZWd1k2Vi80YVVBVEVDMFVOQXhCejFGTWF5di9kb3BGQ25jcEFaK1NXaTlY?=
 =?utf-8?B?bXM1Y25DZ0t2MUZ4TFZZYWNmd211VTNRaDZ3OVpaMnlmeWlpU2ZRc25WMytB?=
 =?utf-8?B?YzRJNlBTSStjaUM1ZXl6Wmltb2wzRy9JdGlINDlRak96N0lNdnFITFBUZG5m?=
 =?utf-8?B?MUJqVHc3eWNwOCtCYzg5NU13dkg0MmFrMDA4eGpEZjJvcitQaWtwZ0djM29i?=
 =?utf-8?B?b2tIQU1naG5wKzdqSkdnV1lwMTBSdTNOV3lUbXdvVHlVT1h3M01hL1R6b1FB?=
 =?utf-8?B?ajREVGE4ZlQ4cEhUOVQyUEd5SkZLMmM4QXIrcUhQZ2RKOUdZNHhaUDdrVHFz?=
 =?utf-8?B?Z1o4bWx5UjFVSEpJdEJYSlUwQndJNVJlWXRocG52QWZ2dDNwam1FVVhSR0tZ?=
 =?utf-8?B?V3lwbm1kOWN3ajAxSVV6ZE92anBHV2g4N2dVWUgxamgyekh3OG1yaTk2VGxJ?=
 =?utf-8?B?TFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6940f5ba-7924-45c0-ebb3-08dc7441871e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8441.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2024 18:13:17.0435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gjl7QYoqEUdC6PT0iI9JmJiFWukESgDdmc/zv8Pt0bLrW0lgJJf6CGZBLDZN24li+UOlZ5JLfi8bqKvc4XPkHAkrHKZd8tieAkwZ0md0Lsw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6917
X-OriginatorOrg: intel.com

On 5/14/2024 07:58, Michal Wajdeczko wrote:
> On 13.05.2024 18:53, John Harrison wrote:
>> On 5/12/2024 08:36, Michal Wajdeczko wrote:
>>> We already provide the content of the GuC log in debugsfs, but it
>>> is in a text format where each log dword is printed as hexadecimal
>>> number, which does not scale well with large GuC log buffers.
>>>
>>> To allow more efficient access to the GuC log, which could benefit
>>> our CI systems, expose raw binary log data.  In addition to less
>>> overhead in preparing text based GuC log file, the new GuC log file
>>> in binary format is also almost 3x smaller.
>>>
>>> Any existing script that expects the GuC log buffer in text format
>>> can use command like below to convert from new binary format:
>>>
>>>      hexdump -e '4/4 "0x%08x " "\n"'
>>>
>>> but this shouldn't be the case as most decoders expect GuC log data
>>> in binary format.
>> I strongly disagree with this.
>>
>> Efficiency and file size is not an issue when accessing the GuC log via
>> debugfs on actual hardware.
> to some extend it is as CI team used to refuse to collect GuC logs after
> each executed test just because of it's size
I've never heard that argument. I've heard many different arguments but 
not one about file size. The default GuC log size is pretty tiny. So 
size really is not an issue.

>
>> It is an issue when dumping via dmesg but
>> you definitely should not be dumping binary data to dmesg. Whereas,
> not following here - this is debugfs specific, not a dmesg printer
Except that it is preferable to have common code for both if at all 
possible.

>
>> dumping in binary data is much more dangerous and liable to corruption
>> because some tool along the way tries to convert to ASCII, or truncates
>> at the first zero, etc. We request GuC logs be sent by end users,
>> customer bug reports, etc. all doing things that we have no control over.
> hmm, how "cp gt0/uc/guc_log_raw FILE" could end with a corrupted file ?
Because someone then tries to email it, or attach it or copy it via 
Windows or any number of other ways in which a file can get munged.

>
>> Converting the hexdump back to binary is trivial for those tools which
>> require it. If you follow the acquisition and decoding instructions on
>> the wiki page then it is all done for you automatically.
> I'm afraid I don't know where this wiki page is, but I do know that hex
> conversion dance is not needed for me to get decoded GuC log the way I
> used to do
Look for the 'GuC Debug Logs' page on the developer wiki. It's pretty 
easy to find.

>> These patches are trying to solve a problem which does not exist and are
>> going to make working with GuC logs harder and more error prone.
> it at least solves the problem of currently super inefficient way of
> generating the GuC log in text format.
>
> it also opens other opportunities to develop tools that could monitor or
> capture GuC log independently on  top of what driver is able to offer
> today (on i915 there was guc-log-relay, but it was broken for long time,
> not sure what are the plans for Xe)
>
> also still not sure how it can be more error prone.
As already explained, the plan is move to LFD - an extensible, 
streamable, logging format. Any non-trivial effort that is not helping 
to move to LFD is not worth the effort.

>
>> On the other hand, there are many other issues with GuC logs that it
>> would be useful to solves - including extra meta data, reliable output
>> via dmesg, continuous streaming, pre-sizing the debugfs file to not have
>> to generate it ~12 times for a single read, etc.
> this series actually solves last issue but in a bit different way (we
> even don't need to generate full GuC log dump at all if we would like to
> capture only part of the log if we know where to look)
No, it doesn't solve it. Your comment below suggests it will be read in 
4KB chunks. Which means your 16MB buffer now requires 4096 separate 
reads! And you only doing partial reads of the section you think you 
need is never going to be reliable on live system. Not sure why you 
would want to anyway. It is just making things much more complex. You 
now need an intelligent user land program to read the log out and decode 
at least the header section to know what data section to read. You can't 
just dump the whole thing with 'cat' or 'dd'.

>
> for reliable output via dmesg - see my proposal at [1]
>
> [1] https://patchwork.freedesktop.org/series/133613/

>
>> Hmm. Actually, is this interface allowing the filesystem layers to issue
>> multiple read calls to read the buffer out in small chunks? That is also
>> going to break things. If the GuC is still writing to the log as the
>> user is reading from it, there is the opportunity for each chunk to not
>> follow on from the previous chunk because the data has just been
>> overwritten. This is already a problem at the moment that causes issues
>> when decoding the logs, even with an almost atomic copy of the log into
>> a temporary buffer before reading it out. Doing the read in separate
>> chunks is only going to make that problem even worse.
> current solution, that converts data into hex numbers, reads log buffer
> in chunks of 128 dwords, how proposed here solution that reads in 4K
> chunks could be "even worse" ?
See above, 4KB chunks means 4096 separate reads for a 16M buffer. And 
each one of those reads is a full round trip to user land and back. If 
you want to get at all close to an atomic read of the log then it needs 
to be done as a single call that copies the log into a locally allocated 
kernel buffer and then allows user land to read out from that buffer 
rather than from the live log. Which can be trivially done with the 
current method (at the expense of a large memory allocation) but would 
be much more difficult with random access reader like this as you would 
need to say the copied buffer around until the reads have all been done. 
Which would presumably mean adding open/close handlers to allocate and 
free that memory.

>
> and in case of some smart tool, that would understands the layout of the
> GuC log buffer, we can even fully eliminate problem of reading stale
> data, so why not to choose a more scalable solution ?
You cannot eliminate the problem of stale data. You read the header, you 
read the data it was pointing to, you re-read the header and find that 
the GuC has moved on. That is an infinite loop of continuously updating 
pointers.

John.

>
>> John.
>>
>>> Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
>>> Cc: Lucas De Marchi <lucas.demarchi@intel.com>
>>> Cc: John Harrison <John.C.Harrison@Intel.com>
>>> ---
>>> Cc: linux-fsdevel@vger.kernel.org
>>> Cc: dri-devel@lists.freedesktop.org
>>> ---
>>>    drivers/gpu/drm/xe/xe_guc_debugfs.c | 26 ++++++++++++++++++++++++++
>>>    1 file changed, 26 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/xe/xe_guc_debugfs.c
>>> b/drivers/gpu/drm/xe/xe_guc_debugfs.c
>>> index d3822cbea273..53fea952344d 100644
>>> --- a/drivers/gpu/drm/xe/xe_guc_debugfs.c
>>> +++ b/drivers/gpu/drm/xe/xe_guc_debugfs.c
>>> @@ -8,6 +8,7 @@
>>>    #include <drm/drm_debugfs.h>
>>>    #include <drm/drm_managed.h>
>>>    +#include "xe_bo.h"
>>>    #include "xe_device.h"
>>>    #include "xe_gt.h"
>>>    #include "xe_guc.h"
>>> @@ -52,6 +53,29 @@ static const struct drm_info_list debugfs_list[] = {
>>>        {"guc_log", guc_log, 0},
>>>    };
>>>    +static ssize_t guc_log_read(struct file *file, char __user *buf,
>>> size_t count, loff_t *pos)
>>> +{
>>> +    struct dentry *dent = file_dentry(file);
>>> +    struct dentry *uc_dent = dent->d_parent;
>>> +    struct dentry *gt_dent = uc_dent->d_parent;
>>> +    struct xe_gt *gt = gt_dent->d_inode->i_private;
>>> +    struct xe_guc_log *log = &gt->uc.guc.log;
>>> +    struct xe_device *xe = gt_to_xe(gt);
>>> +    ssize_t ret;
>>> +
>>> +    xe_pm_runtime_get(xe);
>>> +    ret = xe_map_read_from(xe, buf, count, pos, &log->bo->vmap,
>>> log->bo->size);
>>> +    xe_pm_runtime_put(xe);
>>> +
>>> +    return ret;
>>> +}
>>> +
>>> +static const struct file_operations guc_log_ops = {
>>> +    .owner        = THIS_MODULE,
>>> +    .read        = guc_log_read,
>>> +    .llseek        = default_llseek,
>>> +};
>>> +
>>>    void xe_guc_debugfs_register(struct xe_guc *guc, struct dentry *parent)
>>>    {
>>>        struct drm_minor *minor = guc_to_xe(guc)->drm.primary;
>>> @@ -72,4 +96,6 @@ void xe_guc_debugfs_register(struct xe_guc *guc,
>>> struct dentry *parent)
>>>        drm_debugfs_create_files(local,
>>>                     ARRAY_SIZE(debugfs_list),
>>>                     parent, minor);
>>> +
>>> +    debugfs_create_file("guc_log_raw", 0600, parent, NULL,
>>> &guc_log_ops);
>>>    }


