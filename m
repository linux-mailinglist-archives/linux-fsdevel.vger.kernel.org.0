Return-Path: <linux-fsdevel+bounces-69993-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 09E7CC8D917
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 10:33:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0B18B4E59B2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 09:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F0A7329384;
	Thu, 27 Nov 2025 09:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gTX+qBlI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0489322A2E
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Nov 2025 09:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764236021; cv=fail; b=M2fByve+68sestLBuYKR8tIuuRAWXRazKvXhPf0g6s7IleGBW11OeONcMGjp8NhKgJNGVOvWnpkXkzg1hW3UsftCZ0gBUs4Ua9OVm0PZZgyHZwvPDNZ6ZlxnKVBXGMD3Y2v91g4euNu/cc0DGIfYDKr+ADXUpNN7WiFaE/GJk8Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764236021; c=relaxed/simple;
	bh=6ondrGfRWl8h2s6HD61DdT5L10c5ShvypSXvB02zF2s=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nmxANjlwpDTVQORU7KLgBXx7/4rQxIeTy5COPrJc5Y46UJXyYjsCxhRnm0OSYfJrXjzohT79YZB01Kqo83Uq/s12n5vCme2PdSjaSo2nuVwmmA9+TDkJE5xUCEGajiHS4WG8usf/tV5IrJ5fY7lKUWN2HIooXj2WdE/6TlpkzF8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gTX+qBlI; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764236020; x=1795772020;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6ondrGfRWl8h2s6HD61DdT5L10c5ShvypSXvB02zF2s=;
  b=gTX+qBlIgPVInSxsWYujuQwtZQALC3Hlf5ivTq2FOr1bSinEjcwywssZ
   iOtdb2xLhZExa6nKDe2UV708ylArKCffRGF1THKjtoO5+9ytAAwpXfoO2
   D2uZqUq7gQNEk6z/Mu+ZcvEFPFqeFOgyEPGb4EPZBXSSallw6Iw9DB6UV
   y71D6k+l9LiQRoIQP92rd7iPvWJcwd80Xct8vESFRSnV91wpqp+KlYjfV
   5KFeJa7gxV+FmRukNNVWokiF4kCeylYpuBcf0y4HcMRrzeMfIz3zYKzpS
   uxSEYiYjn+fZfOkf6w1L/JOhIopdzty9gwqPFPOhIjgfZVvw+J030F8qm
   A==;
X-CSE-ConnectionGUID: VeRq5EioQ6i7TkCCzRRnOQ==
X-CSE-MsgGUID: Fg9/7c6xTNqX5PWbm69NEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11625"; a="76970220"
X-IronPort-AV: E=Sophos;i="6.20,230,1758610800"; 
   d="scan'208";a="76970220"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2025 01:33:39 -0800
X-CSE-ConnectionGUID: XjXOuQQJRgO8gn49lLvVMA==
X-CSE-MsgGUID: Q6CqcK4ISaW15I+1Ww5ExA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,230,1758610800"; 
   d="scan'208";a="197671017"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2025 01:33:39 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 27 Nov 2025 01:33:38 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 27 Nov 2025 01:33:38 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.8) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 27 Nov 2025 01:33:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f8Ld2BR8/jLQ0UXSpAd5Dc/untujIa4P4JNnkoKm4aJdcqAJN/zGm/iJOsYgWQ/2sendvFEY+hi7hDoVv+A+ZiFSldB1inbMy+LJyiULKac5K/zcYUshDaKh4EeQRr8/U1YEijfUooUee21+z73+fGSKlaQN/8ioEQJ4GlZ/iPCc7X8SvXWsMIrSPOc+06LPd7gNs99QI/b6lFAOKr7CVErpOdgviG0s4jWJwYL6wviHeAxJpVM1bEl9dewjpoxLoca2tNFeMsrlrYgJcXPpos1gNYLWhwnFFIHdJuJFIIbnO4eEWN1Hy6VW4SNgRd1IY7Fih8fWgrUPjHbvrfrMvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pZxNvhRl6YwnlKhImBM50QtJwvpUnPstbtiyysXQJww=;
 b=rH0Df391BfVZSx1VNKdQOF/5WFW+yAW4uhZi5+EkNit0X4JGWz7metZ0AbbxCacbzkChn9j2/0WdliEY/WtlzmsIUJHBPqFvC8vu7RjeFr71fMw2IIdADSz484R+AvLPX/TCbsbicv6fYPNszEaanKjBIV03VUSMWYKzCLCZUPyy/jNoYLgGicCYLEmw/w2GSRKH7skl2/u217AG0yQge05B2i71HfPwUr9uRQQbi9Ny6w8ns8d02VoRVtkYq+aPmtCVhb5gU5EJ9ByiMUOXAafEnMCReOBlDuBq99lP34B08Ldzm/2FRtyBMWHkaVyUuyoAljTguW/IjZi/CIZHMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6129.namprd11.prod.outlook.com (2603:10b6:a03:488::12)
 by IA1PR11MB9470.namprd11.prod.outlook.com (2603:10b6:208:5af::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Thu, 27 Nov
 2025 09:33:36 +0000
Received: from SJ1PR11MB6129.namprd11.prod.outlook.com
 ([fe80::21c3:4b36:8cc5:b525]) by SJ1PR11MB6129.namprd11.prod.outlook.com
 ([fe80::21c3:4b36:8cc5:b525%5]) with mapi id 15.20.9366.009; Thu, 27 Nov 2025
 09:33:36 +0000
Message-ID: <5ffeb0af-a3c9-4ccb-a752-ce7d48f475df@intel.com>
Date: Thu, 27 Nov 2025 15:03:27 +0530
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
From: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>
In-Reply-To: <20251127-agenda-befinden-61628473b16b@brauner>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0050.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d3::14) To SJ1PR11MB6129.namprd11.prod.outlook.com
 (2603:10b6:a03:488::12)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6129:EE_|IA1PR11MB9470:EE_
X-MS-Office365-Filtering-Correlation-Id: 34095d51-cbdc-4516-9021-08de2d980a0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?clhJWUwycjltTEZ0TWhyZDhwODNpQWoxQTVHVCtSdVkySFZDRFFWeTYraXpC?=
 =?utf-8?B?Q1EzK21XaHRIS0MrZmxEQ05hc3dLenhmMnQyQlNmaGJTcWhUUEFHcVAzTkZV?=
 =?utf-8?B?MnBjaU1LT3hHWTRTdVBVejhoRWI0WVptMCtodnNJSW9RNkhkR2ZUVzdqbXow?=
 =?utf-8?B?ZUVwaVNoYmdOZ283Rmsxb0ZRcEN6NTA1NUEwRFZ2RFFyNjFxR09YTU5xbzVH?=
 =?utf-8?B?TmQzVU9DS1I2ZVkvckVlMnRjUmJmTE52MlhERkhScFptZTFVUHdGVDVxRkM5?=
 =?utf-8?B?dnZ3WUt3QnJtL0hTbno2aS92QzJ0MDVGMnRQTnpoU1U5LzRKZ1orZVRwS01W?=
 =?utf-8?B?M2VBYlJYa01EM3BwM01qNGJTd1QxbXJOdkZwRFhWM09LUG44WjJnbm4yZHpN?=
 =?utf-8?B?SG1WUHRJSlRmRmt2WisyQmpoQjdmTU1td0h2YlBNSUtiazd3NW52TUw4L1px?=
 =?utf-8?B?NUxuS0pQcmNqWkdZZ24rVHJhVHVtVHhVU1FkQ0pQbFlNT3BZQlIrd3FyalFR?=
 =?utf-8?B?N2tCM2oyeUVPSHYyR1VaWG13c2E5eE1oQ2JBSFhDZG1IZU5Cc05SK3gvOVBt?=
 =?utf-8?B?NVRXc2hPeFdjNUwxNW5jcHpMMWVkRUc1SUxhTldweERBQ1ZWZ2gzcXB6RG14?=
 =?utf-8?B?UC9KZWRtSFNBK1NzVWwrMERjMUtkZFJEdWUzK1BpUGR1cDR5Q2YvbW0vM1kv?=
 =?utf-8?B?NVNhVzVvcXZXdWRpSEt6V01ncUw0UmhjUFFCYk1HZ2RzdDRmYWJIRjFKYW9k?=
 =?utf-8?B?eGNmV2p2VGlIOE54N1hEbnhxeTBFMjRIUUhFODFnUDVCbEhlVTlrUzBvdG91?=
 =?utf-8?B?SmJtb1hPSG03VnBEL05BcURMS1FTaFBBUWM4dDB6Y3d6Q2dBQU9SS0VPWmZS?=
 =?utf-8?B?UVh5ckhOYURWM1FUcm5qeEVWQi9ucFdNc1NTaUt1L3gxbHQ1K2wyY2RTSUov?=
 =?utf-8?B?NUlrN0ZJdm5PdHd0eVRWdEJ6MEV5MnYrUTk3ZDVaamlBTnZuZ3ZDb205YUFL?=
 =?utf-8?B?eUpwMU83dytXSVRLYXBUVzJITWpFU09EajFZT1ppa1VBRFVZZWQ4bGIzdWtF?=
 =?utf-8?B?by9ENFFHdUJqc2RuNVBzUFlJczZscHA3N2FlZGVLSExHNXZ0RlkyUFNObDFh?=
 =?utf-8?B?RWRwaUlndlg3ejN5UWdlcU81dElyUzF0b1BMUE9BSENWcnQ1ei9CclY2K3po?=
 =?utf-8?B?VjhvMnhVYjJZRHZ6RHowN1JOZ1dqcUIxVkxPeldxUlphMlc3cUpDOEhtcmhE?=
 =?utf-8?B?MkZ5WmErL3RadFErT1lGRjlMK0RUVWVJak5sRnhPMm8rYko0NWpiSzkxS0t4?=
 =?utf-8?B?Yi9aYnVaeEkwcWQ5WmJ5bmgvZXA0SmxtQTBWZk42ZTNSNjlId0c2Y2czZ3JC?=
 =?utf-8?B?bmFuQnRwVHNZUEtOZEFtUHV5STFLSnlRdlI4SHo3SFdtQ3RSOS9HekRjcEpI?=
 =?utf-8?B?dFlRTGtqMnBQTGNWK0NjVUlvYURFRzVGdk1xYnlKazErU1NQMHM3Q0FQRGYr?=
 =?utf-8?B?ZmtobngzMGZzTlJoeFRTY1dSRFY5c2lMSkdaMVlyQ0wwZSszY3ZFWmV3NVBj?=
 =?utf-8?B?SlpHdEdnRUlOcEhEdDRHd0JIWFRGaWk3VFAvL04wK1F4YXM3ZUliYXhNb2tw?=
 =?utf-8?B?d0gyQWhYcU5MaG8zeHVKOUY4aHRST1JKQzI0Mk5ZQU1lb0pXVHJCR1IvckY0?=
 =?utf-8?B?cVFkVHJ2VFRtQk1NNWtvQkdLRzUzZzU2ZkJFSngvbC85cHhNbE5aT0tjYWIz?=
 =?utf-8?B?MXh1ZzRTb25nT2swaU42NzZaNDl4cUhWZEhkYnZZdXR6eHFiVzZQdGFxSUZu?=
 =?utf-8?B?K2gxa0NtWXE3M25rNGZRYnRtd2xuNjJ4bDk0ajZvT1duaHRsT2kzYW1EZkdy?=
 =?utf-8?B?d3A5ak5oUkNZd3pJR0dmLzBUWnVuVktZYllEdnF5UkVpNlIxSXdib0Z3N253?=
 =?utf-8?Q?Tm0dyLFlw2l2lzMi8ujCOMuYQyMhH2lh?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6129.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2FacWxxMERzbU1GLzJXNCszVG0vcnhVZWlXNkxtUjFCMVJzbWFpWHNic0VV?=
 =?utf-8?B?UEZmaGo4cS9oRXljNmNKS3p6ZzlXelNYYXZDeWRvUzNFSytuWSsrWkdrSnZD?=
 =?utf-8?B?clhMQUc4aksvRnRqbXVFbWt3dUdpT0VaQ2Rva0o1R3V2NzAxb1ZMN2VDQ255?=
 =?utf-8?B?R0xiVWRwNjdzcExGY1pHMWh5RWo2bStKOU1zQ3JYR28rNDc2bjZxZ20vbE1H?=
 =?utf-8?B?dHhaWjI5bUUrRldGems5b3h3LzFQMXRZNTdFZ2hST1VXdVhScHAxdlBkWE80?=
 =?utf-8?B?b3AwK0plbmhvRlZFOFdLSEJJeVhMVnU4dW5SN2tQMVM4dlVqditDL3g3WEo4?=
 =?utf-8?B?NzRWNmdxYTg5QjJ0MmdwWWZSWk9MZ25qNkxaSzliQ3dQaERTN3p5clFiQ213?=
 =?utf-8?B?ZU0xcEw4OEcyb1RxY1FqR3ppc1R5WGdlVGhVOXdWMUd6cUtmVDMzNGQrWWIw?=
 =?utf-8?B?Rm1tYVNxU01YbS9kdVV2S1RFY0lQRkRXUUZrRlVJVUgwOWhlOC9sTElINUlo?=
 =?utf-8?B?RmZNMklCT2svTXZzdjVFZXVKa2dwVHZIZDF5ZWw1V1B4aXRVZG9LaXRKTW5S?=
 =?utf-8?B?eG1VS3dRZFdxcmFOVlNKTWpnTVJyM0ZWSENLdjJlZXpPNkdqU2JkVC9OeGxP?=
 =?utf-8?B?cDV6azI0VlNCMnNtODFJNnk1MXZVdXZvZTRKdzlPd1FXb2htaVFSSGVrZW9v?=
 =?utf-8?B?OXBvOTZKUWRyS2I4UDE1VUdFYmk2OXFLWmFBZ1ZZZmlpdEpyN25lNm1nMnQ0?=
 =?utf-8?B?K1BRbllWUkZSSFlya3ExZXEyTVZnUzhEWVpJWmpuSGdnRkpGSlMvVUl6MUZy?=
 =?utf-8?B?aUpXUFFuclREdzFZRm5ibnJVRWFhcGcrWm1OekxRaG1UcFNmYWh2MjVjQmEv?=
 =?utf-8?B?MzczVW5ubk5Zcm8vc1BVUFdUR0cvRkk0NFI5UThjOS93cE1vNUVmTnA5a1Rz?=
 =?utf-8?B?b0p0dXRTVVBCam9wZHdXc1RJTklFZU1Wc0lIMFQ5MlFaR3RucTlzTjVjYU9z?=
 =?utf-8?B?YTBSalY5cVZHOHdxR3pZVVFSZjVQVUIzYS9nYm42V1lPMEw1ZTBiTHZlR1hj?=
 =?utf-8?B?d2liU0o0aUhHcUc5TkVsQ2oxOEMrNmJFYlhHdmllT0MzUjB1R0JoclVnRGxN?=
 =?utf-8?B?Qm0wa3lZUHk0WjBzSGo3MzBkcUxqd0xYUElhNzlsTjMreHlDcm04UzQwV09B?=
 =?utf-8?B?bmcwUjZFdUVORTlzMHR6ckR3dlFqUTFEQ0kzb3FlQmJPdjBVL1lqZndXUTVh?=
 =?utf-8?B?eitHMHBwQVlXaXEwY2szaEw4YTJibTJOQ0VPcTdTbjRHR3AzYS9UaDVRWGZQ?=
 =?utf-8?B?NVpIRVYxaDhmajlTS0dkVWZYUkZ0cTlRbXQ0NTZmZDFGazJyd08xWWhvZFll?=
 =?utf-8?B?Uk11M3FLcTdxTHN6UVY2UUtBR29jbWF4M2tDaXVpT3krRmhmYldZQUc5eWds?=
 =?utf-8?B?YU5XNXJWeDc1WVNFMHNkK2lHK1oydGwyWFZZVU4rNWNtUkxnQW1FNFM5MURk?=
 =?utf-8?B?SlNCc3F5c29QVWZtVHVKL3ZOZytEMmZ1OU1lZUtaelVoTDBDVVNFR1RTNHly?=
 =?utf-8?B?Kzh4Um9SYmt5eFlKSSs4Q3ZjZnJEOXN3YVhzaHc2eklUYmtWMXhvS05FaE56?=
 =?utf-8?B?N2oyLzNpTW1wQ3N3TDNWQjdnOW1NWGdTUWhuQ1NXNFVFbGNkd3V1N09KN1h4?=
 =?utf-8?B?Y1lMYnhSdkt2aDMrNUxjMlZZb3ZjeGkyTi9TU2t0OS9iOG5senBJQ2gzZzBz?=
 =?utf-8?B?dnhCcStWdmRkV1ZlU3JIS2RKZlpzSkg0VjNPcEl0NUd4bzgrQkNVNm1iZzdx?=
 =?utf-8?B?R1RhaHZHOEprLzNDMGtRdDdRRjlPbUdvU0xsVmx1Nzk5ZzFIZXpRaWpQSGk5?=
 =?utf-8?B?aW54dDVvRVRaUkl2N0JzeTAyVmV2SWJJMVM1eTFjeGpNQTVrTkM2eXZyeE5D?=
 =?utf-8?B?U3JPdmhQVnkybGFnRkxiWGhpMDhCd0RZK1JRSXQ5YjE5TnlScFhsV2lKUGFx?=
 =?utf-8?B?OHNoa29mSEV2THpxazV5dzNoYytPd0s1UlJ2c2Jnc3hTYldnWk5mdmxEZEdx?=
 =?utf-8?B?aUF2R3F3R1VuYy9yS2hGVDRkMmxYVk96aUlTZGdVeDBKdFlCbXA0YmIweEg2?=
 =?utf-8?B?VGVsZGhsMGowM25TL1R0VnJHMzFNSzV5UUJPeXNTR2g1MU1tWWRCaHZYS3RX?=
 =?utf-8?Q?Q/kaQv5fkoDdaDWTK6tNI9o=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 34095d51-cbdc-4516-9021-08de2d980a0c
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6129.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2025 09:33:36.3603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ctJs4MYmLBO+CFfxM4uGQa2rNU+AwOnu3TrYm++mbnDn3aJgIOu7eV8g7UHzupDdrARLBUCMG+EDyoIg0lEtV5fgQflo+bhGnUl+B8qfdTs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB9470
X-OriginatorOrg: intel.com



On 11/27/2025 2:57 PM, Christian Brauner wrote:
> Pushing out the fix now. Can I trigger a new test myself somehow?

Thank you Christian!
Not really. Once it makes it to linux-next, our CI will pick it up. Till 
then let us validate locally.

Regards

Chaitanya


