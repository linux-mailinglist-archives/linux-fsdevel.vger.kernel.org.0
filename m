Return-Path: <linux-fsdevel+bounces-33505-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4FC9B9A74
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 22:51:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45A732815B5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 21:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1816B1E9092;
	Fri,  1 Nov 2024 21:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IW0T/7Wm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1DD1CF2B7;
	Fri,  1 Nov 2024 21:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730497833; cv=fail; b=rG9kjzrO5djJ52I0RfxA4cCCvCavBv7YWudSLFrk820lZPifBFjmRetrRmOuC4RI7u2qrZ77H1xV5swCBrHODrmmhWo8ifnIAN8CaxpEoM/fXGjmnVra6wT9UPCIktUHlhJ1w+9/07qCYozJ+LiFrUS5iqRyLb/dfHkq4HSzLak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730497833; c=relaxed/simple;
	bh=t0fjjYGyB2JG3cwKsmLy7ZSVDd09tJIfBJEUc4bWNmc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QJfhwu4rduA4dckiQUXt0LL5UEKckfRHDGp6jE+PqEtF15+oJYcdJ57dBJQGznHihQ1+PZpxRS1Dc0XonNys+cerVS81IwzP9rfmSKgWNfOsNQrmfXs2aKZXK7kh3kx12O3QjanEs5GZDPlm5lTB5e15tmptEWhwyUQXEVkcuNU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IW0T/7Wm; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730497833; x=1762033833;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=t0fjjYGyB2JG3cwKsmLy7ZSVDd09tJIfBJEUc4bWNmc=;
  b=IW0T/7Wm/6kZ4jAXymTu15Xx/HQBT20iCaPss+aYy8I7JGPmMiMs+hQo
   pxLUkDX+npYF6NBXYQzgD4i48FpGHfSHt7hxYIY9OP2BXX9ZxRN6nFv3H
   +63yOWgAP5+Wkp+B4/MwpXskmTPqPIiq/f00RjRcOHQROJfpJjfMe9OiK
   fJd82CJYAVodOR4zSH12UG2OpsUtJfA+iRYg1QwO79f2hkOJWN+vM+Cpq
   6JXy4LsYV0IUbLC/vX4gcxzFEdIqaB7y1YrN8kcMIzc4Gwz0Xuq8qiIJU
   gVmhzERb9e8lh8Qezui8PL75qtfW1KcJz2d3bQnpuotEDwzo5Fc1WMi+5
   w==;
X-CSE-ConnectionGUID: 3vWjkOLyQIaquMclXBzt1w==
X-CSE-MsgGUID: JecgPLLNT8SSx4tqPQjNaw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="41371463"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="41371463"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2024 14:50:32 -0700
X-CSE-ConnectionGUID: Z5GlHjJATn67tK19QH6/eQ==
X-CSE-MsgGUID: 0zA8btc6TyOposRbqA0oDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,251,1725346800"; 
   d="scan'208";a="82763629"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Nov 2024 14:50:30 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 1 Nov 2024 14:50:29 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 1 Nov 2024 14:50:29 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 1 Nov 2024 14:50:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZoXWr5thK0ikksfNGVwrdA9m6k8Lg6LGqtBCk1zOQM2P3RmmcgzDd9P408qhPilNiNsLNimxeENYIWRTAjO2fExCCHVUkKfgD9aVCwX2kjPEZtfQ6ILeEI9921Bh4uBua2NBroiA38cbKMxODT0E2VlppYoFkc3KysHCmfKhn/X/yk5lwcZEu6Cvg6I88kTuyH9vp62SqZ9fkmoTl1s5VDyNg4xbeIs55F19i7dSZlXPsqrva92RdJJ2XAkQOx5uyqiSDxT3ryIkYvbj79Fx0Bt90pRKVmirR83Wg4/DBLfBqznjtYIGHFXKRDVULpbW5W75xK+YxDGDWsPmHPkrWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t0fjjYGyB2JG3cwKsmLy7ZSVDd09tJIfBJEUc4bWNmc=;
 b=XbsHXxVygLKh2x9sHuPDFuB7n/EWzfzrVRLqv0uX9QorLQq+WHciF0GQAOwYCuLqH6ZgEIKu8EGvfCGt1Pi7Uzkqw2X2ZDZE+66J36pIQfhq2ONzhJkQC2huBe8A3jbTgtYboHKopFU8XQoXR2HRrMi6RVpv31PyogwHQNb8GDx9SzrF0u8qVsPDxfOQ8wgLT/tvht98gY0RNdrPAAsdSTzrp2jYWzQK9yOjneMmNWoSWlIxK7FXWCqXBIjsrX4cKOsN6WtbAK1ra/rJ/0LaYXKiqUN7qTnRJ3yVGnrU7FdvdeHs3wVpmPaYnsO1jFtxm34PK9ud+SzkRcAOhE0IOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by MN6PR11MB8171.namprd11.prod.outlook.com (2603:10b6:208:471::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.23; Fri, 1 Nov
 2024 21:50:27 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%4]) with mapi id 15.20.8093.027; Fri, 1 Nov 2024
 21:50:27 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "debug@rivosinc.com" <debug@rivosinc.com>, "Liam.Howlett@oracle.com"
	<Liam.Howlett@oracle.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "bp@alien8.de" <bp@alien8.de>,
	"lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>, "hpa@zytor.com"
	<hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "x86@kernel.org" <x86@kernel.org>, "vbabka@suse.cz"
	<vbabka@suse.cz>, "arnd@arndb.de" <arnd@arndb.de>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC: "linux-mm@kvack.org" <linux-mm@kvack.org>, "broonie@kernel.org"
	<broonie@kernel.org>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>
Subject: Re: [PATCH RFC/RFT v2 2/2] kernel: converge common shadow stack flow
 agnostic to arch
Thread-Topic: [PATCH RFC/RFT v2 2/2] kernel: converge common shadow stack flow
 agnostic to arch
Thread-Index: AQHbIBZyPOfX3Zr4okuuoIHBkG5sC7KjD/EA
Date: Fri, 1 Nov 2024 21:50:27 +0000
Message-ID: <7109dfcc6df5a610dcfe35a77bb7a84f8932485b.camel@intel.com>
References: <20241016-shstk_converge-v2-0-c41536eb5c3b@rivosinc.com>
	 <20241016-shstk_converge-v2-2-c41536eb5c3b@rivosinc.com>
In-Reply-To: <20241016-shstk_converge-v2-2-c41536eb5c3b@rivosinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|MN6PR11MB8171:EE_
x-ms-office365-filtering-correlation-id: 7f74decc-9dd9-4582-47b4-08dcfabf3295
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018|921020;
x-microsoft-antispam-message-info: =?utf-8?B?WkF3ZGhQV1hRMVVUS3o2ZzRuRnBpemNoODFaUzBmM1krVHdrRUZDV04xRzlt?=
 =?utf-8?B?RHYwbGgvRW5TdDNXU2FnVVhRRWV0Q2tsMW9TbW5WRnVJQXVUamJIKzhNbzZ3?=
 =?utf-8?B?bStkWSt6NEhWM2dRQi9iUXhzTDdDZmpKYi9Da2NBU0N5cmtzTnBaMTlwMENO?=
 =?utf-8?B?L1JVR2sxSUFtSWQrSHRPUGtkcGFjaURLQjYwTDlsR0hnNW5CZWkwYzFBTWJZ?=
 =?utf-8?B?RnpnL1ZzZzcwRTJKOFZySlVUZnBUV2g3Ukp1Vms4UnpGSldDKzA3SVc3M1BF?=
 =?utf-8?B?YkVib2hoTDg0ZEs0WWlBZ3I0ZGZ6aWxlSjlaQXliRkE4ZWIySFJ6ZkhRN3Bh?=
 =?utf-8?B?dlRHZ09xZXRmYWhHczd2ZFJveDZ4SUNYa3UxdWgrOWlYSWIybG5HL3MwSTg1?=
 =?utf-8?B?NUR1bzJHS0xNQzNEb3NJZmRXMzVvOHc5eTBkamhNbS9icVk3N1RPRkpaNlZx?=
 =?utf-8?B?VE8yOUNWR0l6RmF0Rk16VnFDT1FmU2h2OHdPY1VJWUplUkRnaktwd1AvZmY2?=
 =?utf-8?B?TDBDR3IvL3c2cUc2Z3BtK001UjdFOEFjS1VNcHRsejJ1dTdjZkZ6RFhzVkx2?=
 =?utf-8?B?cHNmblhpbytQMDlkelg2K2ZVbzZ3ODZoRnFWSGlYTWI4ZVZneXIwQlRVRVd3?=
 =?utf-8?B?Q2N4OVV2VWYvQUo3WGJUd3g3bWdCYmVOSVQ2MzY2R0dCY2xXSU9NMzBSSUhG?=
 =?utf-8?B?NWh1SmRuSnhQTmN5TGJJMy8waW1LekNvQ0E2VnlJL0hwQ1ZqN2JFRjNWdVF4?=
 =?utf-8?B?Zmc2Zkt6TXFneHYvTld6djZTWXJ0b2JXMzQ1MnMzMGFvR0pnY0ZHZnd1NmFs?=
 =?utf-8?B?M0dEZXh4dHpZL0NyaXI1aXdTT2pjbG9hVm5Wa3JXWFRyRGFtQVN1c1M0dUlM?=
 =?utf-8?B?ZHY5MjJSb2I0WE5Ec3N0VHBtV2ZjdDhmSWhqUVlJaFBNTWdrMlBhaGNjNHBo?=
 =?utf-8?B?ek8vc0FvRkNTL0h6dzI2V1pITFJVQjlPaUc4RXdwcytlaUx2VFAvUm5Hcmdz?=
 =?utf-8?B?Y1dnbHMrV2pMdDhPSlNGTWVSNktuSFUvSGxYTEhlanMraG9sT2hnWkZMWERx?=
 =?utf-8?B?L1BUSnVRK0ZZcWw3WnZDU1pHeDhwUVNPNXBqMVRwMG1kaXIvYks5VlBCSFNk?=
 =?utf-8?B?MmlVTUw5RzVTeXprSnZjOFNmMFJjem1UbDU5OGlIMjRPODYyYVg5aWdZZkQw?=
 =?utf-8?B?RUV1c3VhWlI4RXpWdHhlUE1tcXRKQVFNREl1dzhWR29XUWNiWms5SlNCUUF2?=
 =?utf-8?B?dG4zVnNuQ2xHbHJDbmM1eCt1VnByRzJ2dmc4Z0NQRytNZnpNNkxNR0lWMzZ3?=
 =?utf-8?B?VzYrQWFrSXVlVytNVVA4bC8rVEs5NW1ZK1RtZkgvYWZ5MjVDcGgrOGRlaTlo?=
 =?utf-8?B?UHRSWmROR0QrVlErU05ncEJjSGlHRjR3cXI3cjM3bjl1V1picDdSajU1akph?=
 =?utf-8?B?cVo1NXZYczF2Vks3Q3cyNjNsVVdpZ0xjRzZoaUhqeU00UVl0SklNdXd0UXB5?=
 =?utf-8?B?bnA5STJ0RURYdllRVWpOdnNxVTJDcENYV1EzR1hHRlQ2N2tycmp6L21LeHBX?=
 =?utf-8?B?N0hFL3lpd2JueG9KMTlEQ0hXSmszOUFqcXAyYjFqM0kzcUtKTllrVzQxNFJl?=
 =?utf-8?B?c2RWMVllcWFXZHBIWWI4Zlk3WUhEay9LTzdWQmlhQ2N2TjRBTVNLL2p3ZFhs?=
 =?utf-8?B?cVpFb04zMFY2WFEzK2pFejdEaDR1TFFEQzNjdWRuYnVZMmVvOVcxZUJRSDhB?=
 =?utf-8?B?TVlZMlVBMUVQbjFoNmJZSGErSHVVVmVLUXM3eW1NWUZVY0dldzg3dk1adnlE?=
 =?utf-8?B?OHR4U1dqMUdGTGFpQzRhcmdsMkE3Ukc1R1JtOGRzc1dlZGgyNlY0a3B6M2FS?=
 =?utf-8?Q?1jLk64G9CnZpx?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d0FrM1V0bVZEN1BIdXNWMkE3WmJOY3podE9UZnd4Z0c0di9ZQzlLUjhNV1E3?=
 =?utf-8?B?aFJPa3Vtdlpwcy85ZnptT0kvcE1QVmVYNm40a1AxU0wvcksyV2lSMnJGdzV6?=
 =?utf-8?B?azFKNG53TFZSdnExaVZTZkhvU05xb09iUkRXaHJpVDZNUmc4Q1pCc05QRjR6?=
 =?utf-8?B?cHFxRG0vTW9JbzZqcGp4T3V2dGw5VTU1Q2t5Qm5uMjZJL0VxWC9rNkhNbTc5?=
 =?utf-8?B?ZG9vWHZ2Ni9tM2lZK0xjVzVkQ3gzS242V0pYOVJhWjVVZEwvSS8xdlBkMUx5?=
 =?utf-8?B?VWQwTGtYdzhRaG4rVElzUy9YRmhudjBPa0dmRXA4bjZuN2Y2clFSRm9tTHQ3?=
 =?utf-8?B?L0k1ODd3YW4zZWtac2dYS3p3aWZrUVcvME16TVQ3TnV6aDJyeGE3MHo2Vk90?=
 =?utf-8?B?SGxzTWtZQzNZWnFuWWFTaVBKbEdtSE9GTWdXenJKbjVqWHdTeUV2Tjg1S3BW?=
 =?utf-8?B?MlEyN0M3WWs4VjhoWnE5K2hPNmlHTFU2aUY5WEdjWEhSV2MzVkF6ck5qaEo1?=
 =?utf-8?B?dDMvV2lXWWFTRmFiSlBBbnFSVnlKODdFQjFUNk1UOXlOcnVBdjMxa01EUDY3?=
 =?utf-8?B?cm4xUFRHNTBHS25yam9zUk5KU2RXYzZDQlFBd3NXWGl3ZlArZTRKZVd5OE45?=
 =?utf-8?B?R0Q3NXVWODFTQW1FY3grbmtLdElGd3EwREt2N3BxSW1pNW1tdmtTSDNvcWEr?=
 =?utf-8?B?b283djJTSy9ya2sySUtxWUYyRWY2NXBRR2dCaWVheUlRV244VTdLdE1BeGtG?=
 =?utf-8?B?ZXZMSldLK3pMOXdTSmVKY1N2ekxHWjZkSVluWUQ5Q2JsQXZlQmEzVEs3Y3Zt?=
 =?utf-8?B?dHRtcThUR0s5akhUNHpRZUJ6R1UxWTBldXkyZ2psTjRTZWNTN3QyOUlGeDlO?=
 =?utf-8?B?UFhPNDZiMVZVVE5TYituL2QrUnV2dGVjMFdkeW9XR3hwcEpsNW1oWVRndVk4?=
 =?utf-8?B?b3BuaVQ3bC9Qc01BZEJoOG02L2x4Y0N2SWZoZ0ZRVWcwbHdLNy9RcUdJc0R4?=
 =?utf-8?B?MnJBckFRaU1hZWJMUEVNN1R2UGU2YURaMTYzVjdEd282dXJxdEJoQTU3UDZD?=
 =?utf-8?B?SjZnaTBGVmRkQjBDYlBsVGxPN2ZHVHdYNDR1eEdvRjRrUWFaTnNkazZSRWZF?=
 =?utf-8?B?azJidG4vdnFqYUwzS3ROM1RxNXVMUXdQa1A1Mm5kSzNvOTQyNkZ6aml4a0pn?=
 =?utf-8?B?Y203Y01VL290eFNzRllsdDF5ZFlmeHRydGVvT05EbnJaVmJOcTdjREFrbTY4?=
 =?utf-8?B?TW54MTVmamh2NVRmYmVLRmUyRWlYMjQ3dDVHeW0xckpmV0N5VFFkU3d4SDF4?=
 =?utf-8?B?UlNDUnN0TXlHTWl4c0oreTF3MXhYbFJNRXFHOHRBZ3V6RFJJb0w5UjB1aWth?=
 =?utf-8?B?Q0FiSGlJcUlpR2ozaHVrTDk2YVNYSFloc0F0L0hoWDM4Mk4vZVNwN1BKa002?=
 =?utf-8?B?SmpnOW81YnBYWllHWG9WU1pra2NYeGwxM2lMNFlrdExMUzdsMVdwV2lnUEtX?=
 =?utf-8?B?MWZLcEErRzNWVkkzU2ZhcWNTM1JCRkRydFYyUFlhM2Q0QldSL2RIR0RtcGpN?=
 =?utf-8?B?NUFNWDM0QUFQdy9CcUh2eFluMjVTQ0dkRkd3WFFmdWF6M04xNVdFTzh6VnYw?=
 =?utf-8?B?NlFNNVlNaTAwVDc0TU01NWowY1o4TVVhQUkrWXFBYjk0M0VhRkV0aFlNcThN?=
 =?utf-8?B?TVcxei9FaDIvTkRGeEFGb1VUZ0xLZGdGNmltTkhaZDkwZXV2ajVnM0c2VTho?=
 =?utf-8?B?R0NZbVdmNTRmemNzcS9qRTF5OXk5eVlIeHlvdjFjYkJUSmdiNHhRSDByM1gx?=
 =?utf-8?B?WWdHa3JVSmFvWWNjK29FUlBMMXEwZkprbytnZ2ZXcnlPNjRZVm5EVm1US1Fu?=
 =?utf-8?B?NmJQaXBDM0h4bnYyVFdZZ251dVB5L2hPOEdOajlRVlRvU2RMR3hQbmxnL0Nk?=
 =?utf-8?B?MWxKMm04dE1TdnZnL29uYlFZYUNRd0w2N05HZ2JkSjJYbEg5bFJWVVlpc0lQ?=
 =?utf-8?B?TnVXWjRaeC9tbkE1R1NieXJQMkpwQ29LU3BsOUxEZytnc1U2emlaYXJmSkVF?=
 =?utf-8?B?R0htcGpIZklwUmxZT0JkVGZIcEZFK2FZWUJXWnBnbWN3QWhNdk5Bdy8wdkhn?=
 =?utf-8?B?YldFOXNHVjk3a3Q1ZU8vMlNzRGY4R2xMT0l4bC9Obng4eUhDWUMraTFjTUdV?=
 =?utf-8?B?Q3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0F79BAFDD47A9043B74DD90D78ACF0FA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f74decc-9dd9-4582-47b4-08dcfabf3295
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2024 21:50:27.3909
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g/MhO0F5xGIoPMtgvAdP2lGNUTHoygHLtpbmctOKTKetUdaCjCZTcDClVLsHLhjFnZFNXwTI2ptqYUfMbtAZi9k65wTbhKitHvppfSZokrU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8171
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI0LTEwLTE2IGF0IDE0OjU3IC0wNzAwLCBEZWVwYWsgR3VwdGEgd3JvdGU6DQo+
IC0vKg0KPiAtICogVk1fU0hBRE9XX1NUQUNLIHdpbGwgaGF2ZSBhIGd1YXJkIHBhZ2UuIFRoaXMg
aGVscHMgdXNlcnNwYWNlIHByb3RlY3QNCj4gLSAqIGl0c2VsZiBmcm9tIGF0dGFja3MuIFRoZSBy
ZWFzb25pbmcgaXMgYXMgZm9sbG93czoNCj4gLSAqDQo+IC0gKiBUaGUgc2hhZG93IHN0YWNrIHBv
aW50ZXIoU1NQKSBpcyBtb3ZlZCBieSBDQUxMLCBSRVQsIGFuZCBJTkNTU1BRLiBUaGUNCj4gLSAq
IElOQ1NTUCBpbnN0cnVjdGlvbiBjYW4gaW5jcmVtZW50IHRoZSBzaGFkb3cgc3RhY2sgcG9pbnRl
ci4gSXQgaXMgdGhlDQo+IC0gKiBzaGFkb3cgc3RhY2sgYW5hbG9nIG9mIGFuIGluc3RydWN0aW9u
IGxpa2U6DQo+IC0gKg0KPiAtICrCoMKgIGFkZHEgJDB4ODAsICVyc3ANCj4gLSAqDQo+IC0gKiBI
b3dldmVyLCB0aGVyZSBpcyBvbmUgaW1wb3J0YW50IGRpZmZlcmVuY2UgYmV0d2VlbiBhbiBBREQg
b24gJXJzcA0KPiAtICogYW5kIElOQ1NTUC4gSW4gYWRkaXRpb24gdG8gbW9kaWZ5aW5nIFNTUCwg
SU5DU1NQIGFsc28gcmVhZHMgZnJvbSB0aGUNCj4gLSAqIG1lbW9yeSBvZiB0aGUgZmlyc3QgYW5k
IGxhc3QgZWxlbWVudHMgdGhhdCB3ZXJlICJwb3BwZWQiLiBJdCBjYW4gYmUNCj4gLSAqIHRob3Vn
aHQgb2YgYXMgYWN0aW5nIGxpa2UgdGhpczoNCj4gLSAqDQo+IC0gKiBSRUFEX09OQ0Uoc3NwKTvC
oMKgwqDCoMKgwqAgLy8gcmVhZCtkaXNjYXJkIHRvcCBlbGVtZW50IG9uIHN0YWNrDQo+IC0gKiBz
c3AgKz0gbnJfdG9fcG9wICogODsgLy8gbW92ZSB0aGUgc2hhZG93IHN0YWNrDQo+IC0gKiBSRUFE
X09OQ0Uoc3NwLTgpO8KgwqDCoMKgIC8vIHJlYWQrZGlzY2FyZCBsYXN0IHBvcHBlZCBzdGFjayBl
bGVtZW50DQo+IC0gKg0KPiAtICogVGhlIG1heGltdW0gZGlzdGFuY2UgSU5DU1NQIGNhbiBtb3Zl
IHRoZSBTU1AgaXMgMjA0MCBieXRlcywgYmVmb3JlDQo+IC0gKiBpdCB3b3VsZCByZWFkIHRoZSBt
ZW1vcnkuIFRoZXJlZm9yZSBhIHNpbmdsZSBwYWdlIGdhcCB3aWxsIGJlIGVub3VnaA0KPiAtICog
dG8gcHJldmVudCBhbnkgb3BlcmF0aW9uIGZyb20gc2hpZnRpbmcgdGhlIFNTUCB0byBhbiBhZGph
Y2VudCBzdGFjaywNCj4gLSAqIHNpbmNlIGl0IHdvdWxkIGhhdmUgdG8gbGFuZCBpbiB0aGUgZ2Fw
IGF0IGxlYXN0IG9uY2UsIGNhdXNpbmcgYQ0KPiAtICogZmF1bHQuDQo+IC0gKi8NCg0KSSB3YW50
IHRvIHRha2UgYSBkZWVwZXIgbG9vayBhdCB0aGlzIHNlcmllcyBvbmNlIEkgY2FuIGFwcGx5IGFu
ZCB0ZXN0IGl0LCBidXQNCmNhbiB3ZSBtYXliZSBtYWtlIHRoaXMgY29tbWVudCBtb3JlIGdlbmVy
aWMgYW5kIGtlZXAgaXQ/IEkgdGhpbmsgaXQgaXMgc2ltaWxhcg0KcmVhc29uaW5nIGZvciBhcm0g
KD8pLCBpcyB0aGVyZSBhbnl0aGluZyBzaXR1YXRpb24gbGlrZSB0aGlzIGZvciByaXNjLXY/IE9y
DQpyYXRoZXIsIHdoeSBkb2VzIHJpc2MtdiBoYXZlIHRoZSBndWFyZCBnYXBzPw0K

