Return-Path: <linux-fsdevel+bounces-2978-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B127EE6F7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Nov 2023 19:45:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4242D1F251C5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Nov 2023 18:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7236C2FC3F;
	Thu, 16 Nov 2023 18:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i2PzbS1y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12912D49;
	Thu, 16 Nov 2023 10:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700160339; x=1731696339;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=swhMY9zsn3gb7izTgxe74mS/8v3BX1PLGCcG2he48Ys=;
  b=i2PzbS1yiAPufCBYStPS2WSz29AuXD2Zqm8owNvi/pZPn9zWNjlJ5ak7
   O+ydl6r25gpIAdagux4yHPWaenzZd0yvhgMwCUHBGAmNUOXQHjKl54poh
   GoRYzQqyvapCjIFjwfoFhlwbf9ACNOb5vSKJKv0m1pO0E74MfvVIYyhms
   NMeX7nRnAKY1EfK+Aic5KjEFkpUUF3c9uqUBzZtyEDCL7i2oSh01kn2pL
   IApW4Rwc+04tz0OYoWP7eHX36oh7VmqBTPCqA/wEXYBq0rbZq4kSogkfM
   Yvl0Ve1OvgQ1ckW6FOiAyWWuZab7NGcfvTmJRpn9vizqVArFex6u+1eNT
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="9799526"
X-IronPort-AV: E=Sophos;i="6.04,204,1695711600"; 
   d="scan'208";a="9799526"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2023 10:44:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,204,1695711600"; 
   d="scan'208";a="13652835"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Nov 2023 10:44:43 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 16 Nov 2023 10:44:42 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 16 Nov 2023 10:44:41 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 16 Nov 2023 10:44:41 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 16 Nov 2023 10:44:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YlelY299YSs+M9+H+oiRlq+9A3D7FrDeZ33Jt5cG0tx3a0aSM9g9OMVJYlOafJnE4b5RSApta6AGZ+6KiUdt7LXyoHX9us9vEf75oRrUYpioN1SN9/YKscElxHRfB5rBRcU7UcfnkP/kOnUpRP8bA/kYK/jE85AT8yjc31u3IOd8I8wgpDoPzG8pnMVDU87Zrrphyh5x6ovROhrUXvOtjRiPIQoKev2RWLnyT+VfgEsZ/ZQnt4ouuq8iBxjLiCm7C8muo7cxzo0L6IHq/xQUtaRhHrXkX5GAQ9+CkNcbuV2dsNABN5O8SnKWVRlEVMl5A9MDkW6o3Mbm+gmrBFmSMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=swhMY9zsn3gb7izTgxe74mS/8v3BX1PLGCcG2he48Ys=;
 b=cdkAIeCq+HJ2ysq70CLAsJZIGyik2uJUE0mUQmK0Od7O0OLUsIUAf1bblxCgPDjN2vl4/hDLlln8ehxfmaUJZAINhrWqPF0sqy0rWczR24HVVqEu2D0fUYCOjrpDTFj0bHZA8MKBMf3HUoQPzpkFlyLz6fDJTzjRDx/hb9mkOZstLecQetBywdYLN4VArINJMmG2V5+s6SAZNuJfAlE5uOxzn1i+lHGEvQwLKLJ1Zha70g75SoUPolAc5D+GIf7dBaLE93wXP66J+qnzIkxJAhk1ibB6X2JsnJhdLZdaeTZ4+UqS08igc6eA80S2P26yLn8IwCB9NwrvKgC/sdCLAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SA1PR11MB7063.namprd11.prod.outlook.com (2603:10b6:806:2b5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.20; Thu, 16 Nov
 2023 18:44:34 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::2b58:930f:feba:8848]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::2b58:930f:feba:8848%6]) with mapi id 15.20.7002.021; Thu, 16 Nov 2023
 18:44:34 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Avadhut Naik <avadnaik@amd.com>
CC: "rafael@kernel.org" <rafael@kernel.org>, "lenb@kernel.org"
	<lenb@kernel.org>, "james.morse@arm.com" <james.morse@arm.com>,
	"bp@alien8.de" <bp@alien8.de>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "alexey.kardashevskiy@amd.com"
	<alexey.kardashevskiy@amd.com>, "yazen.ghannam@amd.com"
	<yazen.ghannam@amd.com>, Avadhut Naik <avadhut.naik@amd.com>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: RE: [RESEND v5 2/4] fs: debugfs: Add write functionality to debugfs
 blobs
Thread-Topic: [RESEND v5 2/4] fs: debugfs: Add write functionality to debugfs
 blobs
Thread-Index: AQHaEcKmSJnxE55esE+d2zUzr8vlorBvbmaggA3Z6oCAAAwVIA==
Date: Thu, 16 Nov 2023 18:44:33 +0000
Message-ID: <SJ1PR11MB6083BC35F108E319B7C898DAFCB0A@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20231107213647.1405493-1-avadhut.naik@amd.com>
 <20231107213647.1405493-3-avadhut.naik@amd.com>
 <SJ1PR11MB608345F0C62627E7A0520449FCA9A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <71ad8b0e-984b-4739-a940-82c5a1456f50@amd.com>
In-Reply-To: <71ad8b0e-984b-4739-a940-82c5a1456f50@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SA1PR11MB7063:EE_
x-ms-office365-filtering-correlation-id: f1fe248a-8106-48f3-0746-08dbe6d4139e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9ppnwkTRdcU6LUxxg72f0leLk7/8+VPx7+mgcSljFFs8QqAn9w6iJ0n0aNC/S0BJf6tetdsPcRgxqJJ5pKuuW8lG8WjFQ9KhKYk0IPouj4ztC8OhnoSHiI/9FLh9aI/2iR7YZAWPcIViRbo3eRIwqFenXSaUozuWEMeGZ5g/bxSM8ncDCY8jyIwr5KTsc8Km7Wqv3zF37V6ss0uGNVR66Iy9ndqfXjc0HSj1xYdmh8yyEr7BJfaanuRoIg/yfmPBOis7zLzKf5ixZrqlUXCuQ7OehPvPPH5nlPUyFCy/krHrn5CCNQA9WfwiwbZSJyIWr6eEHtZHeR1jS50gaw6yyX3vn9JsSz0Ylf2PG5Yza7KnZXo5gadyllRaQE4PfAFxMdZWk+Pz5oDJgK3AklkX9zCBMHdqPmGn449ZTrvCAgJCjLDfZW31ufg2eAyaK/Dln9/vicR7bKdQBOOzhKOh/saws0c7LmvUceE81sMvpHYd7MC31uoYEYy7hy0ePvTXj8jGDyMM4irdeMWPlaxnLsCefs/b5XY63ksZrs2DtKVCao1p2txt1NAZZFWi38+TOfw0Gs6zA9lni7ssXg/ZTkr+xXREGQJRyOQYHjH9TTa1WkTkQWcylb61/2jZPDUw+3ObPcsZHGWAwAvlpHDB5w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(136003)(396003)(39860400002)(230922051799003)(230173577357003)(230273577357003)(451199024)(1800799009)(186009)(64100799003)(71200400001)(86362001)(6916009)(478600001)(8676002)(4326008)(8936002)(6506007)(7696005)(316002)(66476007)(33656002)(26005)(66946007)(66556008)(76116006)(54906003)(64756008)(9686003)(52536014)(82960400001)(66446008)(83380400001)(55016003)(7416002)(5660300002)(2906002)(38070700009)(122000001)(38100700002)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bE1hMkk3RzFjeTRYVEkrQTUrMFl0V2hSU3FIQlp1Y3lCaEkwWHRHd0JSNWtN?=
 =?utf-8?B?dUM5TkQreUtPd3dSWEJjMFhjQ1VySVpld0cxWUUxVnJUbGVLTGVWZ054Z0V4?=
 =?utf-8?B?MzdyelJPdVZDZ3g4enhaTjNzQnB6V3lxTmcwalBIRTE3VWYwbThjelJtUWFR?=
 =?utf-8?B?THhpV0lhcXdEWkNiUExobEM2M0NBRmU1NFhXS2QvSm05Uks5WHZtbC8zenFq?=
 =?utf-8?B?UWJRTVlKZFFML0NYakxPY2hwWWQvZlZUVE9uQ0wvSzNWakpNZmFIdW0waGtU?=
 =?utf-8?B?MlIvaEV4R2NzcExYOFNBRjA3OFJZTFdJeXZMYXI1TTZFbXVBd2hrRmhOR1hH?=
 =?utf-8?B?bnlQVFBWaHd6c1FFcVVhVWx5ZEUweHh0S2MvTkdvN2cwLzZ1eWZMSFlsVVdw?=
 =?utf-8?B?UlFZb1hzei94NXBzV3BHdWRlRzFlVWtha1pKaEpaZy9nc2gyYkxxTmhuMC80?=
 =?utf-8?B?ZDd4azRhQWpkdXFVdTdDMWhEZXd3VVhOekszVUdJRGUxanlJa1c0U2FUV3hG?=
 =?utf-8?B?aThHRmFEZFFqZDBubVZEdFcxSXI5RWw2OTBOTG9mMStNR1FsTGJRbVRIeTNL?=
 =?utf-8?B?cUVyNlZNZmswWFlYOUsrVWFLQTlMMTQzYmhic2xXOXVudUpQQ1l2bFRBOFVt?=
 =?utf-8?B?L3U1MWlOYjhMbjBTKy8wS0ttcmMxRFF2L1RjOCtONmxiaHRGZnlnNFY2eFVQ?=
 =?utf-8?B?b09Bb2RqL1NUZEx5TmV6SjAvckV1dklYRm9sQlBENmtsVjZJME1kWUk1RUox?=
 =?utf-8?B?OWNhU1dyY2s5Q3llMTNpNUk4b0o1Z1lPMDF2bExsaWVic3UxV3hQN0hJbGJG?=
 =?utf-8?B?RHA1MFRsdVJtM0cxRWF1S1M1dnpQRlIxQXdrYnFwbFZXdWpBcUxlMWdBS0Jm?=
 =?utf-8?B?R1hCVEJXNm9DeTlKcFBNL0hraUg5bHI1enhaOE9MVkZvUnNzcDN5WVZBZ2s2?=
 =?utf-8?B?YUlkOEkxWmhkU0JLR013THhVZmVuZ3o5ZG9mVUVMbzJmTUNzV2RVSXR5dmNF?=
 =?utf-8?B?ZlpVTU9HU1NaNzB1QUxzazJ4MmxsdEdxeVExRTlTM0pMZmlkdUg1OUZNWURh?=
 =?utf-8?B?NHowR1M2em41OTZxU0NLTEhMRXhuZFN2M0JteGNqMXBQcXVHMEw1d2Z3cnZ0?=
 =?utf-8?B?NXE1WHUrRFZJQjNQY2lmL0k1RitiZkhnVHJqWkpWMHhxWDRqZ2MvcUt6THZU?=
 =?utf-8?B?UzdETjJMeEtTdm9IcUl2RVFuazBHR2tWNHcxUGNWdFBKYndnNit0NWlpUDFN?=
 =?utf-8?B?TE5ZdEt6ampjN0FUY3FHV2cyaXVIaitFZWM1MUhESGg3RmlNYklGMmRiOHlW?=
 =?utf-8?B?UjE0bVJPb1VoTlVQRmdCTVlodHMvanRzY3lxRmxTa1d6akJwdUk1TlBKODBa?=
 =?utf-8?B?ZExTRHNGTVVCQ0F1djVrVm1GU1p3bTg4cG1xNEV6c1EzV1R4UEowc1BXQVFz?=
 =?utf-8?B?bFdqVVNXQUVFa1k4bEhRS3JTa2hodmt2eDBEK2hPcnFMYjR3Q2x1UFI5bkhr?=
 =?utf-8?B?MDFENjZ5ZWFIMFBxN2wyS1RLYitiUHoxTTc3akM1VjFaSmJMOEkxcnNCZlM5?=
 =?utf-8?B?Z0JoZ0RsYTB6UTNVQkpuREdzTmIwR3dSVHVnUGMvdjhPUVlxNkprU1QzQkh2?=
 =?utf-8?B?OThycUFCdU9Bd3hoU1E4NmpERWcwUWp0M3RjWkxKNmRreFh4clYrd3oxdUFt?=
 =?utf-8?B?aFdhaDdVNk9FeDFDR2F4R3F1ZmlNaVAvQ2FaOW5yeWVzZ3YzM3A1WTZ4YWRN?=
 =?utf-8?B?N2hhY2JPMmlKRTRGMnE4b04yYm9oTHFQRXl6eENjSWRqYU5pMVZ4dHRiQ0w5?=
 =?utf-8?B?K0hPK04yK3hUSHg2Y1dxU2xrNWtQd2tCU25TeXlTWVZvb3Z5d2lmb3NmRDV3?=
 =?utf-8?B?MXRoajJjdzV1VHp6NmN1UW5IQWt6UEFlbkl6OGQwZkZnT2hLOXJIUTVPZWJH?=
 =?utf-8?B?enVka0NJc1ZYQUZzaGtOOExuNmQ4bTI4NUpxVlQ3Vk9ScU5Belo2djU3MXVy?=
 =?utf-8?B?UlNNZll2dGRKelpzazVaTm91SU1OeHkrajJkNGxVa3MxZEF1UGVKYlVOOXkv?=
 =?utf-8?B?R2RMM2FYMU5VcnMrRVFaS0NVWjlWNERsU0FVeWY2NFltLzZCUGNQVi9QWGoz?=
 =?utf-8?Q?KFkeoXziQYmf9HKTdaf7gfQD3?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1fe248a-8106-48f3-0746-08dbe6d4139e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2023 18:44:33.9501
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eKKlOBjm+31PKNc713z9opn2RAuyW1lAx+FYKog6c0Cl6PpKHfaDJs9yTh4jgq9CUBRDmOAA/wJH09IX7A8LfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7063
X-OriginatorOrg: intel.com

PiA+IFRoZSBtaW5pbWFsaXN0IGNoYW5nZSBoZXJlIHdvdWxkIGJlIHRvIHMvMDQ0NC8wNjY2Lw0K
PiA+DQo+IEp1c3QgcmVhbGl6ZWQgdGhhdCBzLzA0NDQvMDY0NC8gbWlnaHQgYmUgYW4gZXZlbiBt
b3JlIG1pbmltYWxpc3QgY2hhbmdlIHNpbmNlIHlvdSBhbnl3YXlzLA0KPiBJIHRoaW5rLCBuZWVk
IHRvIGJlIHJvb3QgZm9yIGVycm9yIGluamVjdGlvbiB0aHJvdWdoIGVpbmouIERvZXMgdGhhdCBz
b3VuZCBnb29kPw0KDQpZb3UgbmVlZCB3cml0ZSBhY2Nlc3MuIEkgZG9uJ3QgdGhpbmsgeW91IG5l
ZWQgdG8gYmUgcm9vdC4gRS5nLiBhIHZhbGlkYXRpb24gc3lzdGVtIG1pZ2h0DQpzZXQgdXAgYW4g
ImVpbmoiIGdyb3VwIGFuZCAiY2htb2QiIGFsbCB0aGVzZSBmaWxlcyB0byAwNjY0LiBCdXQgdGhh
dCdzIG5pdHBpY2tpbmcuDQoNCj4NCj4gSW4gYW55IGNhc2UsIHVzaW5nIDA2NjYgd2lsbCByZXN1
bHQgaW4gdGhlIGJlbG93IGNoZWNrcGF0Y2ggd2FybmluZzoNCj4NCj4gW3Jvb3QgYXZhZG5haWst
bGludXhdIyAuL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLXN0cmljdCAtZyBIRUFEDQo+IFdBUk5J
Tkc6IEV4cG9ydGluZyB3b3JsZCB3cml0YWJsZSBmaWxlcyBpcyB1c3VhbGx5IGFuIGVycm9yLiBD
b25zaWRlciBtb3JlIHJlc3RyaWN0aXZlIHBlcm1pc3Npb25zLg0KPiAjODQ6IEZJTEU6IGZzL2Rl
YnVnZnMvZmlsZS5jOjEwNjM6DQo+ICsgICAgICAgcmV0dXJuIGRlYnVnZnNfY3JlYXRlX2ZpbGVf
dW5zYWZlKG5hbWUsIG1vZGUgJiAwNjY2LCBwYXJlbnQsIGJsb2IsICZmb3BzX2Jsb2IpOw0KPg0K
PiB0b3RhbDogMCBlcnJvcnMsIDEgd2FybmluZ3MsIDAgY2hlY2tzLCA1NCBsaW5lcyBjaGVja2Vk
DQoNClRoZSB3YXJuaW5nIGlzIGR1YmlvdXMuIFRoaXMgY29kZSBpc24ndCBuZWNlc3NhcmlseSBl
eHBvcnRpbmcgYSB3b3JsZCB3cml0ZWFibGUgZmlsZS4gQnV0DQppdCBkb2VzIGFsbG93IGEgY2Fs
bGVyIG9mIHRoaXMgcm91dGluZSB0byBkbyB0aGF0Lg0KDQo+DQo+IFdvdWxkIHlvdSBiZSBva2F5
IHdpdGggcy8wNDQ0LzA2NDQvPw0KDQo+IC0gICAgICAgcmV0dXJuIGRlYnVnZnNfY3JlYXRlX2Zp
bGVfdW5zYWZlKG5hbWUsIG1vZGUgJiAwNDQ0LCBwYXJlbnQsIGJsb2IsICZmb3BzX2Jsb2IpOw0K
PiArICAgICAgIHJldHVybiBkZWJ1Z2ZzX2NyZWF0ZV9maWxlX3Vuc2FmZShuYW1lLCBtb2RlICYg
MDY0NCwgcGFyZW50LCBibG9iLCAmZm9wc19ibG9iKTsNCg0KDQpZZXMuIFRoaXMgaXMgZmluZSAo
YmV0dGVyKS4gTWFrZSBzdXJlIHRvIG1lbnRpb24gaW4gdGhlIGNvbW1pdCBjb21tZW50IHRoYXQg
dGhpcyBhbGxvd3MNCmNhbGxlcnMgdG8gY3JlYXRlIGZpbGVzIHdyaXRlYWJsZSBieSBvd25lci4N
Cg0KLVRvbnkNCg0KDQo=

