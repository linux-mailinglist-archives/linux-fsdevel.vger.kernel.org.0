Return-Path: <linux-fsdevel+bounces-70015-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3A2C8E4E7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 13:46:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 879523508A3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 12:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B31B91A0712;
	Thu, 27 Nov 2025 12:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Do3Ovvgy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FD017BA2
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Nov 2025 12:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764247579; cv=fail; b=KQ8bnTigSAsG5MEVzcFhrcIyD1wFtZko/M1+YpmSsJOU/d6KL+uT2U5I+pq4biXzNsSa2EAH+1LXvnQKeMyYSD0C+52G+3zrnDa8aRpXpJaLx5rmE9uKIrgOEn6rpyv2fp7LCYlivtoMZ5WcOElPVFFde2nf/8HR7CkpRGsJrmc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764247579; c=relaxed/simple;
	bh=S08KtKwDpSpR0FDd3AwISpaYszSMzOqbAvcv5MHb3dI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=H7sOvWIUOK+zzib+Td3/xBLOuSyUojewyzsoXcnF2PwxAPaY82BWQs9FFh0Ysn4kDh22udExvb/K1u5T7BYK94clgeo8Wx4QQLXKvGohrr2FVP6oaYRuwh9EZfruplkDIjnBR/KCOOsAa6I2x5AkNzpwASJfmJPXyYnXcuxNPiU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Do3Ovvgy; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764247577; x=1795783577;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=S08KtKwDpSpR0FDd3AwISpaYszSMzOqbAvcv5MHb3dI=;
  b=Do3OvvgyTIxOZIiONeb/w5HWfuPKG3idwEb1RdYn9XNpVETYP99k60qg
   Tf8l90xy3NrzN0QjFINiomFskKAjWVyu+TcHwqQemNwungCaI5yC72X52
   /fIiqYA/a//Dl3q1MA6MIwRt2v/39AYr03XJkIzJd6b2GoaP7GI/SsJPu
   aoCUYVFDwGfbBUJ2vLVaiT1zcAt1NWOZtLThp3EcE5TP1/3OAM73/sCHy
   4tKnETs9ZX7EZBIR1ly61/SWttB38ABm2ztgCe5lJq2a0IkaqStKpS8mB
   cTxJ63mja43ceyCrgaxg3S3A/Oj16yz5Pl9kq8SHvk/d61ddfhJI52KG3
   w==;
X-CSE-ConnectionGUID: a7XvSxwkT0uayn1xGfoMuw==
X-CSE-MsgGUID: Gik6Wed7QjWf0CNYVrDQmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11625"; a="88937976"
X-IronPort-AV: E=Sophos;i="6.20,231,1758610800"; 
   d="scan'208";a="88937976"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2025 04:46:17 -0800
X-CSE-ConnectionGUID: qsp6G/RCSbGQ3IiSvjZbjQ==
X-CSE-MsgGUID: 3Z04gto6TSipsz6gzGkw1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,231,1758610800"; 
   d="scan'208";a="223922489"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2025 04:46:16 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 27 Nov 2025 04:46:16 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 27 Nov 2025 04:46:16 -0800
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.14) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 27 Nov 2025 04:46:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CR01Oc/mGo8b9aMANdjVxwpgh8VjRapCryEJZUouhVYqmAW3Jmo2GDGwwPtDp9TgZi07n+XazttPnfbxufkU0NgxhAAPbmmcjuwI8j4V2J1r7/uAabf9xoyXID6lDcuC89dwavwDGZ2MFoFgIjpCknfMT6hPzk9UOI8KCByr+xTYaJEeTi3lZuFoQK1q8sQ+DqppOWRbwtMYM464sMhLiQpyb9x1VztEaFuytGtYUNXMW38W4Ji6KmQwRWEUaqgJznwoyV8Amm/SVn+9XVjKnRPhbCiHv1r4h571WEYoPBcJIawcxpzQxoaMJoRqoDNSjEvOkj4UOc2h8vJlrPLiZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DuWBCvCEY62K2p52rKsZLWEpbxYzBFxurV5qZj41K24=;
 b=uVuiyMAZT0bxTQt6jfZb93jZoOyzgg6hinaTdeo88btdiM1rL6SJSXKFB4w0eSH8Y36h+nf2v/0KtUMZ7obtkHRG0H03diqVBGSlLLKxsmTl2SHTm9rx5xoeb+hkQibcG3Kb/rrkebg/5DLzP2qNtr4goqOCTTABbr5psING2wkdKfj/MEi/QHWP1bbVPmDgKH9Mc0rQYd7Vh8cQW0cHkd/PWFWxVJMuloCVm30FpTy8h5Z+9gCknybGEmpR0CQzcfR3QqCKw8+p+Q5C2HS/blsnY//TCIm4ytdfNx4+FBc75hGtIFnHl7cjTRBYSIifYhxdKqksK5vAq03XiEee4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6129.namprd11.prod.outlook.com (2603:10b6:a03:488::12)
 by MW3PR11MB4588.namprd11.prod.outlook.com (2603:10b6:303:54::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.14; Thu, 27 Nov
 2025 12:46:12 +0000
Received: from SJ1PR11MB6129.namprd11.prod.outlook.com
 ([fe80::21c3:4b36:8cc5:b525]) by SJ1PR11MB6129.namprd11.prod.outlook.com
 ([fe80::21c3:4b36:8cc5:b525%5]) with mapi id 15.20.9366.009; Thu, 27 Nov 2025
 12:46:12 +0000
Message-ID: <78e1b97d-837f-48e9-882f-8320473ec9bb@intel.com>
Date: Thu, 27 Nov 2025 18:16:05 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: REGRESSION on linux-next (next-20251125)
Content-Language: en-GB
To: Christian Brauner <brauner@kernel.org>
CC: "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
	"intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>, "Kurmi,
 Suresh Kumar" <suresh.kumar.kurmi@intel.com>, "Saarinen, Jani"
	<jani.saarinen@intel.com>, Lucas De Marchi <lucas.demarchi@intel.com>,
	<linux-fsdevel@vger.kernel.org>
References: <a27eb5f4-c4c9-406c-9b53-93f7888db14a@intel.com>
 <20251127-agenda-befinden-61628473b16b@brauner>
 <5ffeb0af-a3c9-4ccb-a752-ce7d48f475df@intel.com>
 <20251127-kaktus-gourmet-626cff3d8314@brauner>
From: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>
In-Reply-To: <20251127-kaktus-gourmet-626cff3d8314@brauner>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0062.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b8::16) To SJ1PR11MB6129.namprd11.prod.outlook.com
 (2603:10b6:a03:488::12)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6129:EE_|MW3PR11MB4588:EE_
X-MS-Office365-Filtering-Correlation-Id: 4063490b-ce8a-4552-8bee-08de2db2f216
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VmJHY0dLRFRaVHU5LzJmUXFUc21SK2ltRGZZQlk3V0htcjdyZFcxVXdTSHE2?=
 =?utf-8?B?WkxTZlZITm4rRFdRN3JiK2wxTy9Qakg3VFUwaHZiNmpzMCtpSnYxSXlidkhY?=
 =?utf-8?B?MW12TWI3MElXQmlpWmQwK0JlbUZQWFFjQmN6Yy8rejhyM0tHQllaWnRYRGlv?=
 =?utf-8?B?dUJsTHI2cWtubHhQcmVZWlZwOWpLZWtZVjdPeG5SMkx4L3dTNlg4dllieURP?=
 =?utf-8?B?YnFiZ3BCYTVWYlBXVFdEUmFnWkEyK1E4WnpicDRCK0tjcjdrbFhkcGltQmcr?=
 =?utf-8?B?OGhxTFZoT2dUNGk1ZXZTYVVoWWJURjBHVWdqM21zWDQ2TDI5a1RsanBRT2JD?=
 =?utf-8?B?ZldWeTNlRmM2RmpJdWVseU1ObUtWeEcwcnhET1BYV0JZMlJuQWJKcERzeTRx?=
 =?utf-8?B?NDlSNlQ5NE0vRVpoWEI3QUU0dkQrWDR4ZDlDOThUNUxBRm1XNU5FUlNyQ3la?=
 =?utf-8?B?cld2SHd4MGtwOU5ROWQ0c0pHeHRHa2tIOTltNDVMbXEyS29TVzl4T0VGenM4?=
 =?utf-8?B?TllvcXVaUlVFeVNndk5UNWFCTVk1R0gwQ2w2VDRNclFLT0dPM2swcllYSTR5?=
 =?utf-8?B?OG04Qm02YnZFNmxDVUd4TGNSYkk0bk9nTUhSVU9iUjZlejY2QjhtZXNJb3Ew?=
 =?utf-8?B?cDhMZkorNGVPVWdsQVdSZzFRc0w0dC9TN2Q1UWphbW1vSGtaUkZWWUpXV3R2?=
 =?utf-8?B?UUJoQkFUMWdtd1JGbjhjN0NLZUpmQ0Y3M0hRK1JkV3BBK3NQTG1tODFFQ0hq?=
 =?utf-8?B?YVJNakxtV3ppc0FjTFA3MlozRTlqRjZia0VrODRoMlRGeGh6VkVCc0MyZisr?=
 =?utf-8?B?KzZVZ01QUldyUEFWOUlzRlhmZzVUbnNKUkMxS2VXWlJYa3A5ZXNlTDJEdXlh?=
 =?utf-8?B?YWFiUTZRVFJxUVA1ZDI0TVdNTFFoaElrQ2lLcjB5cHRZL3BwZ1dlL3k5N3l0?=
 =?utf-8?B?UlB2YnY4aUVwZkZ2WkNUMXQ0ODcrVWxlWUl2R0dGZzRwSDNqWmtSQ1BJNU0y?=
 =?utf-8?B?YTYvUzIybTVFczhqUHVJSHlFSUNIQ3F0aG5HcHNERDJ2N0xXQnlUeENYWnFW?=
 =?utf-8?B?dGVsSnY5ZHRRRXJNSkpXL1A4d2lEaVAvOWJDeDFxOFhHaVR6MWpSeFRMSVgr?=
 =?utf-8?B?Z2paZTJqODMyRG5EYmZtWkNkODlDU2VOU2hpc3d1Wi9qSjJwVHFnbGlkZk9F?=
 =?utf-8?B?NUcyR2ptaDNlMkNRSnBGRGEzbm93cUxGODRzSDVTMlFnVjZUa29RV0FDN3Fv?=
 =?utf-8?B?MlJ0T0VwMitvWEtUL1lUbVRmc2ZjczB3bWZkSFR6dThZVlA3WHdPbVBRbEdT?=
 =?utf-8?B?akRzUytZNW96UjJIeVIyWGRLZENCeW5NK1BlckRRMmZaYVhnM3BqMG5tMFp4?=
 =?utf-8?B?ZStIdnBMMFBrZlhIemFPSEp1YUJSd2xBRVo4TG9zV0JucTZKTGt5NEduZkVi?=
 =?utf-8?B?MXdEN1hZU3pNYmlTNFUrNG1MaDcxa2JHWUtjSXh2R2h1MjBnK0RlM083RFl2?=
 =?utf-8?B?cnUwQU83Z2dNajhaSmJROTNVbE5uUWRPYXRua3dOVHlLdEY3cWRNK0lkS3la?=
 =?utf-8?B?K0V0WFkvcGVDZFBvdFZSVWZqd1FMWW1XYzJZaGFmbE1oNnUyV29tVVBNVEkr?=
 =?utf-8?B?NFFORWtWN1JvT0szUERDeFMxV1cza1ZXVkQ1OXRCL2I0T1A0NjAxV01aV2My?=
 =?utf-8?B?Z0FjdnlmdHNOTHhlTEViWndNY0d2aDVXOFBxbzZ5S1g2Rlp5S1dwd0p1R0pw?=
 =?utf-8?B?YlZoUFpnbFBRc1N1algvVzZNZjRDTDlIMVJSUkNxU1FkbWVGMlB0enZKaUlE?=
 =?utf-8?B?SVN5NHBRVkdtMHBieVJmV2tQcW1ENERnY0QxdWVhbFp3eGc0VnpSQjlVZmpy?=
 =?utf-8?B?TnVZZThtR0F1UWJOU3kxbDBYd1NwK0ZjaW5PUHc2NVpkYjBqSDV0aElHdmhI?=
 =?utf-8?B?TWJsZUNZQlJsMlJWSmcxSlIySzNaZ0dNRnVDczhYeUlTUTY4bi9MMUdmM0t1?=
 =?utf-8?B?VkVXRlpCTEd3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6129.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFFTNEhISFExejM2RElISndIRGNsOXBYdkVnUEgvMlZ4T09Ga3BlZGVLZ05o?=
 =?utf-8?B?Y1I3MmhYYjh6cHY0UjA2VlNiL2RxbzZmWjhCSEc5QUVqUVNnMEg3T1ZiN3Bo?=
 =?utf-8?B?M3NOUEdHalJRRXVZbTBpWWhEdXNVNVJjdWJXSmlBSmZEUmRwYTZkb25aak9B?=
 =?utf-8?B?UDFHbEx5WlBjeExjS2x3dDMrUW4zdEcvUVdGcGdhdXNJOTNTdm5DZEMyTFA3?=
 =?utf-8?B?ZVM4WGJmRnNqZnlwQ01QLzRST3hVZ1BmU3FqNElkNlRaUk5pTFhjTlVIMTVF?=
 =?utf-8?B?dHM5ekNuMnQ2UkJnNy9leWtOS1IySEFML05ybXVGNUZXOVVEbTE4bllyTWNK?=
 =?utf-8?B?dDhOcnRqUERGalM2R0cxcU1Fa0NzdmgrdzQ1UEJQSENMNkZEUGFhRUlyUU1M?=
 =?utf-8?B?c0JyRkdMemxjZ1V4cGY4ZHhMbm0zWkFhamdlYUxCaGNzUlNJYk41dDAvdDJI?=
 =?utf-8?B?NEZNaHpSQzJzandTenZBL0F4UWg3dXBzVFBsQzVPcVc3NWtyU3krKzlnRHpp?=
 =?utf-8?B?VTZwS3NWODd1b25KNGMvOGkwR3BQMEw0eVlVMHdXL2pENngxRWNyUUU3MVBI?=
 =?utf-8?B?c0phTXJ4c2FYNUQ5ZmVMUXBELzhTNUxiSStaYkV2R0RMNFBBcG01MXBLRkhv?=
 =?utf-8?B?T3dvZ1FCcEJjOERjTlpscDZqdFVrVTAwRmdRZVB4aFkzMnJhMmV2T2doKzJH?=
 =?utf-8?B?YjZSL2tjeVBXZmRKOThyUzlWcXppY1BnTkNOczRRd0tSYWQ0QWJuTVJ6Mlly?=
 =?utf-8?B?cFJnc0hkQnJkdE51WVhDckJldzF6THg4Z1lMV0JtNnN6UUZScFVIQmVPaGRR?=
 =?utf-8?B?ZDFQRzFvQVJnRXdIK0tOR2UzN3h6dDJZOXBEbnV1dkJNckJqelIyRWkrc0E0?=
 =?utf-8?B?RzBIWHlHS2xUTXBjN1dyUCtrV1ZqUmFFUDl5bWhWYjVZNGtubStNcjNsS3dn?=
 =?utf-8?B?dTJ3TFJVR2NKSUc4OHI5cEROcHU0cjZXVWhKVnlIU2NVM1E2dlE2QUZ1aHVw?=
 =?utf-8?B?SzhXb0thamt2cWtKeGFFcHJDeSszVFhEVngvVmJwQ2dKNm5MeFR5VzZZNFhI?=
 =?utf-8?B?UjYvdUE5R1FPM1FGYUxnTy9BMEx4MGMyVk1kWFVxaG1BcE55dkV6bHZib2k2?=
 =?utf-8?B?dHo2cUFYQXBScjBFME1oK1RnYytFYk1DR3JFYXprc3llSXdwTFNnMUl1Nkp6?=
 =?utf-8?B?SHlCYURwWmtmdzdVUkRIUTQ5dkw2YW92ZGxUVm93YzhyZmNteVFCaFN1OW1X?=
 =?utf-8?B?ZjRVMGt1OFZrcFZZeUJ4OWdLR0hNcHdxSjZxQndmdDR6dU03ZUdBZVNFNFoz?=
 =?utf-8?B?c2p3ZTBCc2lwL0pzdTVnRWx5RDBISWhwMWwxVXpuWVltMnJxa0VxUDE4eVJL?=
 =?utf-8?B?OHNsY3VaZWNRaFNtTWViQitPOXorWkVJZWgxblBzS1l5VmJQd2ROQ3dJd3RN?=
 =?utf-8?B?Z0c3aU90d2lzeTQ1ZU9icmhyaVBQNm1lZTMzbGJqME5LUjZ0UTJJSlNVZEhy?=
 =?utf-8?B?UGVtM05qdFQyZ05NTHUzcnZpVnN6eWJzVkI2WDFUR3ZzUjBkdWdwUkRPUWp2?=
 =?utf-8?B?SmZiWGlnUU80RTR3MHV5NmpTMEV6YXVMaWVkSStYczN5aXdkN2JXWjh1RzV6?=
 =?utf-8?B?V25kV2FFMlR3Qnl0SFM5ZGYraThtK1RudkJLdGdCT1V3aHpVdHBVbkJOazRF?=
 =?utf-8?B?UnNmbjlWM1hqeUVUQUFoN2w4MkdKVno1NkpKUWpFTjRHRytPVmpTQnRBc3Qw?=
 =?utf-8?B?WE1obm05NUorL0l0REpsaU1NWGdnMWZoV1BYV0h2MVh0Y1RVY0U0KzAwOEZ2?=
 =?utf-8?B?UnVIMHB3Z0VPU1VEeSsyYy9Tck9SMmxVb20yNVJycEpSREs1ZWYxZ1pPRDRK?=
 =?utf-8?B?bEZVWGtVcDVndjJLeFM4cnBTRmpkamdmc3lGcFM4dHozblBOSkpVWUpYS1B1?=
 =?utf-8?B?cTBObnBza2pRTVJzVlNVemFKa1orbERpeHQ4eloyZDEwS1pRUFg2a2U1dzhS?=
 =?utf-8?B?RzJTdytZUHkxSUFXQ1luZTYrSWFZbFhGM3l3SnRoWWVYa05ZT2EzR2tEWEkw?=
 =?utf-8?B?aTNvcnU4Ti91NDVNTFRXWmc1ZUl1ZmhsSk1YekdjS2dOZ0N4dzVLVEVZbFhm?=
 =?utf-8?B?SHNiVlYyMHpsTFJFVk1BWjhQNk8rVTlibHRwdUt2Kzd1ZzRCbmp3WlBldmpS?=
 =?utf-8?Q?LMLNEB3YnKHfImmjKJ/A/Pc=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4063490b-ce8a-4552-8bee-08de2db2f216
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6129.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2025 12:46:12.5759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sTrDlrfZnHKkYZ0egYDd7ocnPfKpgUq98Vk0hOsmtAk9mYTmYGYqJlA8fq7qObgZh6yLZOevslu4MGKrwVDgxncnO7SM3wKDzHm/NmbZuEs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4588
X-OriginatorOrg: intel.com



On 11/27/2025 4:13 PM, Christian Brauner wrote:
> I just pushed:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs-6.19.fd_prepare
> 
> If you want to test that, please.

aah! only the sync_file.c change you suggested was not fixing the issue. 
But with [1] on top of linux-next, the issue is now resolved.

It also solves another issue[2] we bisected (before I could report it to 
you, which is never a bad thing)

Thank you.

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/commit/?h=vfs-6.19.fd_prepare&id=bf44cb6382f90fbda2eeae67065dc9401a967485
[2] 
https://intel-gfx-ci.01.org/tree/linux-next/next-20251125/bat-mtlp-8/igt@core_hotunplug@unbind-rebind.html

==
Chaitanya





