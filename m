Return-Path: <linux-fsdevel+bounces-12203-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 468A685CDC5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 03:11:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94929B2171A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 02:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 348B563AE;
	Wed, 21 Feb 2024 02:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iSrbxvft"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1B96FB2;
	Wed, 21 Feb 2024 02:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708481489; cv=fail; b=Qy631wU5QzFqRLjdFrC3wLIKPaie17fWQ9Eyq/opehnapny6LQ/WsQndeO7/SLk2Qn/vuoQrDMlNKXexEbCI8/wRT/eLhFh5WtxDtYSHmdLfE9GNRGO1wo8Ycc25kJksG2ksJuiy1besLn5S2JR61Tu19OBM3iGpW+J+6ZIRKyk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708481489; c=relaxed/simple;
	bh=ncTDQSMGXEEdYGauYSPKEAYev2NFhqpDDpvFDFQ32Kw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=I6GMRENwJTNIHYHX48RWtb003YGSvhG2xDyxLFDWhZb8T8dJNofOZFfRtAomobfnxguR9+ngEDwrg9TDjrWMsnaSZFnDtXY65Sl4Z1o3HmnUvawRB5+MTbwMzq+41kyjwpwi39HQvmFz+kpqgdPw38rOO137LPT1jWhvF6O9d1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iSrbxvft; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708481488; x=1740017488;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ncTDQSMGXEEdYGauYSPKEAYev2NFhqpDDpvFDFQ32Kw=;
  b=iSrbxvft1RRVi4etL/jKVT0WFF+ZUC7HhL2M+ll1M/hRLvlJPkco9yxk
   EOrKiJBv5rR5mlTAQXHlmmXH6XoOhV96KlvoUuwJcy2giUkdrYTsRIb8Q
   smgiC7Go2oFIDVoD+jIbfALUfqeK2JtJ7Na8U+V6o/rBylxsjDj3G9FMg
   3crRvX2xV5lIyxkpCorot2IhwIuvU1WBQZPHITkZXk87zYQRpo4b4NgZc
   nngZqLYlCTwmLKhoe9cS0TM1BDydk806wdg88IfDf3xVHBl9EkAqeMQal
   LhUIVs98ES85TXzweeYj/A3TalbSuxpne+tnGAu1s4rdix6wOa9Tf/tZK
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="2484776"
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="2484776"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 18:11:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="9601753"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Feb 2024 18:11:26 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 20 Feb 2024 18:11:26 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 20 Feb 2024 18:11:25 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 20 Feb 2024 18:11:25 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 20 Feb 2024 18:11:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q3m1f/J/cqE1+lnucZFE7l/d+AKxJGbG3Bi7g4eosWNR8z5OSxniwIQW3wFE8Shzy9pSYUzW/rsJ7ob56dzD15Nk4ioLyu5ollC5Pik0Gha5G7WW/9WQZalu3rEjBoNlSwAmesQmJpD/vdgS4/HDLtyOyQZXclUWV/QK3SrGwWR7M97ahR/9raahO5M5o7KWaCz0PA9eOpYf7XuyYaf5RDHUxbqaLWeK1G3DhK75p4mmFDoC/kmliLxcDXLKvqwWcQD+jEIo3CjrqvoHNSZc153NyrHzZS9g0CJiNzdsJmpzmgQTvLY/9iidIDxQ9T/ah6+HdkbkagCddRzpn9OWyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ncTDQSMGXEEdYGauYSPKEAYev2NFhqpDDpvFDFQ32Kw=;
 b=N4U/KhjF7bBPFMe12Iwd6RWB0qThVEwbInrGO3RxnHLr/NNBi7EBkdqAwCyUGUkSzGO5A/F7Cg5+bDuG8eXkVGEqZlhRn/szDlJOJBArjJCY0RkPys7IWMsfY0/pZIRb2XHEqejIwGKsWqZ6+zM6U/EJ/kv9Dh0q3q7Opkdc/f8LtFdaNRP5ErO/a+iXcDI/aRe5b1mzzksNwJ/bLXAh6fZAcipBAdG9N6NbnQ4E2/sFRdXYSfvkd3jlRyPgYOhcYxbNxMu7c2Fi33Drl344w00rJiW6OccaQhwl45fQxm6bS5BTHTq/hYfoue2SscN1SP9b6C5a5X1IoZaQCtJAuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by MW4PR11MB7006.namprd11.prod.outlook.com (2603:10b6:303:22f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.29; Wed, 21 Feb
 2024 02:11:23 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::5d40:83fd:94ac:d409]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::5d40:83fd:94ac:d409%7]) with mapi id 15.20.7316.018; Wed, 21 Feb 2024
 02:11:23 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "dalias@libc.org" <dalias@libc.org>
CC: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
	"suzuki.poulose@arm.com" <suzuki.poulose@arm.com>, "Szabolcs.Nagy@arm.com"
	<Szabolcs.Nagy@arm.com>, "musl@lists.openwall.com" <musl@lists.openwall.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>, "corbet@lwn.net"
	<corbet@lwn.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "catalin.marinas@arm.com"
	<catalin.marinas@arm.com>, "broonie@kernel.org" <broonie@kernel.org>,
	"oliver.upton@linux.dev" <oliver.upton@linux.dev>, "palmer@dabbelt.com"
	<palmer@dabbelt.com>, "debug@rivosinc.com" <debug@rivosinc.com>,
	"aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, "shuah@kernel.org"
	<shuah@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "maz@kernel.org"
	<maz@kernel.org>, "oleg@redhat.com" <oleg@redhat.com>, "fweimer@redhat.com"
	<fweimer@redhat.com>, "keescook@chromium.org" <keescook@chromium.org>,
	"james.morse@arm.com" <james.morse@arm.com>, "ebiederm@xmission.com"
	<ebiederm@xmission.com>, "will@kernel.org" <will@kernel.org>,
	"brauner@kernel.org" <brauner@kernel.org>, "hjl.tools@gmail.com"
	<hjl.tools@gmail.com>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "paul.walmsley@sifive.com"
	<paul.walmsley@sifive.com>, "ardb@kernel.org" <ardb@kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>, "thiago.bauermann@linaro.org"
	<thiago.bauermann@linaro.org>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "sorear@fastmail.com" <sorear@fastmail.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [musl] Re: [PATCH v8 00/38] arm64/gcs: Provide support for GCS in
 userspace
Thread-Topic: [musl] Re: [PATCH v8 00/38] arm64/gcs: Provide support for GCS
 in userspace
Thread-Index: AQHaVpxQxL7eT1mQek6VcjPJOSVEZ7ETiLSAgAAiyYCAAASHgIAATE8AgAAGrQCAAAuagIAADnuAgAAMOQA=
Date: Wed, 21 Feb 2024 02:11:23 +0000
Message-ID: <6332963a828d247ef935b7d3352fa1fbd83b11b0.camel@intel.com>
References: <20240203-arm64-gcs-v8-0-c9fec77673ef@kernel.org>
	 <22a53b78-10d7-4a5a-a01e-b2f3a8c22e94@app.fastmail.com>
	 <4c7bdf8fde9cc45174f10b9221fa58ffb450b755.camel@intel.com>
	 <20240220185714.GO4163@brightrain.aerifal.cx>
	 <9fc9c45ff6e14df80ad023e66ff7a978bd4ec91c.camel@intel.com>
	 <20240220235415.GP4163@brightrain.aerifal.cx>
	 <a57d6c7eada4b9a7c35addbc8556f5b53a0c3e6f.camel@intel.com>
	 <20240221012736.GQ4163@brightrain.aerifal.cx>
In-Reply-To: <20240221012736.GQ4163@brightrain.aerifal.cx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|MW4PR11MB7006:EE_
x-ms-office365-filtering-correlation-id: 8a001086-f6c8-466e-8024-08dc328266c1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U9g8ergQ+av2SJ/t25j8Vwm6eeMiYmLyeMTVbxwZRwATsm9MLj+WvaxsW2/+coaLqAPmMGll59ZB4FiRhXooT/Bo9wGRrNLjSSm1Xa6U3iZyy64Yw7uxIElw5qsjl9rp0MA1+n0oV+xTmqRdf1dewYqfbsJYnKzxWjInMXtkJ/isU+6BZT68B9uEPMGxXkaoP+yuqQRVVYL0/CY+UBFP7c5NmXQhN3UcwAvRVvd3O5EGaS4OtKAeIJ6proqyM5Z10NHxune9tKfKgmyVFHfhEiy+hITQgXy8DkJ6y5N7oBYEVmsSULlKTMcEsb4++RndiTHmjEN5mrrKAe5wXyR04/NKNNa4XUVi/R7RzfA7oEqbqb1EsErhW6mgX9sIqhmWqhKDb2OmqcXr/S33yI+m7/3tMI7dWVDo0AWz77hFAgGizcr3MBrkligU7AWnYl3LgtAlJOer7hJ3fv8lRRlu/Y+U5fJxvDeOZJHfIfQpHusz3uYZ3D6TmK0R4sS94AM/HJa6XZ3VtjhK2NV47sVccoZxeLskje48yNwFlpvVkRwmIRORCJvyEQ5kMJSnZjyDnzEW/KAC/pDbaemRn9lm9rzPmD6eDXtZ73QZ75xIl/SfhwDIZxwk7Jaza2k3gXZ1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c1RJaDZjYVFvdEtHdjNNWEVqNzV3cjBQQ3hOWGhIY0Fya0JnWGs2TDU5SElT?=
 =?utf-8?B?SmlaT2hkaGZMZXJwWVJxNGlCVHFKY1BtQ000WXpwWXc0M1JDb21SOU1tUk01?=
 =?utf-8?B?ekowZDROei8xQ3JwemYwTEJ2YVVXekNOT1oxZFlkMUxqZHAxT01rYzQrTC9E?=
 =?utf-8?B?eGViam5ZMngwclVaUkJFQnB5Smp1a3ZOQlpCWmtIM29hcG8rL1pTYWVDOGU5?=
 =?utf-8?B?K2RBQlo2WmVCeVlySXJ5OEdKd0U5c1Eya0lDbzZsN3d0Qk83SEc2TGpRWHhk?=
 =?utf-8?B?T1MxUlcwejNwdjRjS2s2VGdLa29OV05tWEtoM2R3SFkzTHlQS1NobWFXaUxa?=
 =?utf-8?B?NFNUVzk0dzVIaVBBU3l2YXI0YlJqcDRWZDR2ZDBuYW4zQmYyS2pHRWNIbFdZ?=
 =?utf-8?B?SUxWMitWTnQ2NUJpTUthU2Nha3FBcjB0Qnd1TEJCNVBuNFhsRkZ6NDVMUHAw?=
 =?utf-8?B?Qm00eUxXZ3hienRsZU1RWTlXNjVZZGdkaDdjU2d3QWFZUGxtT2xEM0FBbm5h?=
 =?utf-8?B?NWEwN3FFSkhqSTVJcDEzZXNzYWNEcjl1Mkd3SGk4TTFlUHlWN2FCYXc1by9V?=
 =?utf-8?B?Tno5cTRmb1lzUmhjbkx2UGhwV1J4NjAvd0dMcjUxVTRsT25rUG5tSk00cEh0?=
 =?utf-8?B?ZmJ1elQ3Rkl6MlJOakwvdFBNY0c5L21EN0g1SlBraUx1b2wrK2ZUSXF0Q2Q4?=
 =?utf-8?B?SE1xNURFZ2tCWjdHR1Z4U25ydi94bWZzTFdVUzA2RTYyVStMZUNyYm4yb1pO?=
 =?utf-8?B?Vm5YVVhmYlIvTWhEOTZ1U2pMZzZkMndwQmRSTVZpYWJCSXBmRWNkQTZRekor?=
 =?utf-8?B?b2cxemRGZ0x2U21UMGtoSlpHejY3WHlJVytaWStEdStQYktSd3Y0NDltblVm?=
 =?utf-8?B?SHBFL1Jqb1Uva1U0d2M3VTk1QllYVWkzeGxodU9xZ0lZWGp1VjN6ZzRld1NJ?=
 =?utf-8?B?WGJpMWhkQTltY3Nmd2srdDRBTlJYTk1zSXN4UE12eUVnOE1oUklNUis2ejVY?=
 =?utf-8?B?VkdWandGWWY0QVdHTEZMd2FTdXBCWVRuMVN6aHpIcjEweVBnb0k3VnRsOHg2?=
 =?utf-8?B?YVhORXRlMnhQNWNJbzQ3WHBsNWVSUWh1UzNhRkllenh5ZVpudFNzdW45c2Vh?=
 =?utf-8?B?Y3NDZVNtRjBDeTNhejlQZ2toUmpHcGV0TFVJbTlKdlFLMmRNcjlBMGllTmNu?=
 =?utf-8?B?eXRpaXIrdlZ3NTZ6Qk10YzNPRGU1K0F3TGNrOEVFUnpqM1ExV1RhYitXZTht?=
 =?utf-8?B?RktTVGJXVDFaNzE4VnFnRE9nYTFMVVUxcDlLQi9QVXdnRTBvSEFhQWVOYmVS?=
 =?utf-8?B?Nllrbk1OSndMWU83STlXd09YeUNBWGxuc3huSlczYWh0YW1rS1duQ01pejF1?=
 =?utf-8?B?TE1OK24zdXpDNFI2WXIzSjkrYmk5YXJ6YzJwZG0yWmpLWlpyOFllVStad0xT?=
 =?utf-8?B?QkNxUmNRL0xpeFRKbDljNy9EQ1lmRUxMVzJPMTJ6UGp3UHBwa1lKTVBHeHZw?=
 =?utf-8?B?WUpMbFpkOXdqa0cyWmRKZlY4TS91UHNDNk5SeS9Pb21NdlhqNXJkQWRxbFpJ?=
 =?utf-8?B?bnFOSUppY1JsWWI0c1hIdFllMzNJTWxZVFlPQjZ5aVVERVBHL0JVMzBCUTNl?=
 =?utf-8?B?bGE1TlBHRTljRkhmWDlmeUhOWDBHTVE3N0ZWUVRxaW8xSG1RL3EyUTlaNXRX?=
 =?utf-8?B?U2Z1RnRTb2pJSUNCMEVmUkY4VEhPZzl0bXY4UUlwTDROVkUvbnBSSW44cXlJ?=
 =?utf-8?B?dktxYXcwTnpQRjJrZ0xqb3VCcGN4QkxkRDZ3WVVsUkMwWm1ad2U1Y0I1RVFi?=
 =?utf-8?B?YUR6T3lVZThWNy8zSnJ0TVV0WkFQc0JRRm9Ybk11emJ0R3Z5cTVSQTZHN1dS?=
 =?utf-8?B?TEZTVHl4NGlEc1lTWEgzOVNaRnFzdTJGK3BlZWlUN3dJY1ZXOGpJMXVSSjRv?=
 =?utf-8?B?QmZFZVUwRHg5SW0xTW1BQmI0T29qM2lucU1FTFNjK0hsckhEYm9hSTlTVXVS?=
 =?utf-8?B?SFJGSm1CV203cENGTEZZVFhiQTlZUzJhT3NjRHFUNm1zYkRSOVRNRVpUQ0sr?=
 =?utf-8?B?aENoNTRTYk5CWnVldVdCdENVTWpIWk51NkRPemVVOUF4OFVRT1V3WmttVzVt?=
 =?utf-8?B?QndRZmduSlc1YUt1dTVOQlptTEdiYUZkam01QUlzd3FjeGd4QjBSYXRMQVU2?=
 =?utf-8?B?cHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8851A1C899EC24478F25894595770BF5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a001086-f6c8-466e-8024-08dc328266c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2024 02:11:23.0552
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qoRXUgslkP5/TNNChVA/y11tl5lPKHJtB//iyyokpPf/CqubGXx+UiBQArDEKUmKkrFaliNDi08YHGbop8HJ5q8sGXH6iSVZMHdqkimoDCI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7006
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI0LTAyLTIwIGF0IDIwOjI3IC0wNTAwLCBkYWxpYXNAbGliYy5vcmcgd3JvdGU6
DQo+ID4gVGhlbiBJIHRoaW5rIFdSU1MgbWlnaHQgZml0IHlvdXIgcmVxdWlyZW1lbnRzIGJldHRl
ciB0aGFuIHdoYXQNCj4gPiBnbGliYw0KPiA+IGRpZC4gSXQgd2FzIGNvbnNpZGVyZWQgYSByZWR1
Y2VkIHNlY3VyaXR5IG1vZGUgdGhhdCBtYWRlIGxpYmMncyBqb2INCj4gPiBtdWNoIGVhc2llciBh
bmQgaGFkIGJldHRlciBjb21wYXRpYmlsaXR5LCBidXQgdGhlIGxhc3QgZGlzY3Vzc2lvbg0KPiA+
IHdhcw0KPiA+IHRvIHRyeSB0byBkbyBpdCB3aXRob3V0IFdSU1MuDQo+IA0KPiBXaGVyZSBjYW4g
SSByZWFkIG1vcmUgYWJvdXQgdGhpcz8gU29tZSBzZWFyY2hlcyBJIHRyaWVkIGRpZG4ndCB0dXJu
DQo+IHVwDQo+IG11Y2ggdXNlZnVsIGluZm9ybWF0aW9uLg0KDQpUaGVyZSBuZXZlciB3YXMgYW55
IHByb3Bvc2FsIHdyaXR0ZW4gZG93biBBRkFJSy4gSW4gdGhlIHBhc3Qgd2UgaGF2ZQ0KaGFkIGEg
Y291cGxlICJzaGFkb3cgc3RhY2sgbWVldHVwIiBjYWxscyB3aGVyZSBmb2xrcyB3aG8gYXJlIHdv
cmtpbmcgb24NCnNoYWRvdyBzdGFjayBnb3QgdG9nZXRoZXIgdG8gaGFzaCBvdXQgc29tZSB0aGlu
Z3MuIFdlIGRpc2N1c3NlZCBpdA0KdGhlcmUuDQoNCkJ1dCBicmllZmx5LCBpbiB0aGUgSW50ZWwg
U0RNIChhbmQgb3RoZXIgcGxhY2VzKSB0aGVyZSBpcyBkb2N1bWVudGF0aW9uDQpvbiB0aGUgc3Bl
Y2lhbCBzaGFkb3cgc3RhY2sgaW5zdHJ1Y3Rpb25zLiBUaGUgdHdvIGtleSBvbmVzIGZvciB0aGlz
IGFyZQ0KV1JTUyBhbmQgUlNUT1JTU1AuIFdSU1MgaXMgYW4gaW5zdHJ1Y3Rpb24gd2hpY2ggY2Fu
IGJlIGVuYWJsZWQgYnkgdGhlDQprZXJuZWwgKGFuZCB0aGVyZSBpcyB1cHN0cmVhbSBzdXBwb3J0
IGZvciB0aGlzKS4gVGhlIGluc3RydWN0aW9uIGNhbg0Kd3JpdGUgdGhyb3VnaCBzaGFkb3cgc3Rh
Y2sgbWVtb3J5Lg0KDQpSU1RPUlNTUCBjYW4gYmUgdXNlZCB0byBjb25zdW1lIGEgcmVzdG9yZSB0
b2tlbiwgd2hpY2ggaXMgYSBzcGVjaWFsDQp2YWx1ZSBvbiB0aGUgc2hhZG93IHN0YWNrLiBXaGVu
IHRoaXMgb3BlcmF0aW9ucyBoYXBwZW5zIHRoZSBTU1AgaXMNCm1vdmVkIGFkamFjZW50IHRvIHRo
ZSB0b2tlbiB0aGF0IHdhcyBqdXN0IGNvbnN1bWVkLiBTbyBiZXR3ZWVuIHRoZSB0d28NCm9mIHRo
ZW0gdGhlIFNTUCBjYW4gYmUgYWRqdXN0ZWQgdG8gc3BlY2lmaWMgc3BvdHMgb24gdGhlIHNoYWRv
dyBzdGFjaw0Kb3IgYW5vdGhlciBzaGFkb3cgc3RhY2suDQoNClRvZGF5IHdoZW4geW91IGxvbmdq
bXAoKSB3aXRoIHNoYWRvdyBzdGFjayBpbiBnbGliYywgSU5DU1NQIGlzIHVzZWQgdG8NCm1vdmUg
dGhlIFNTUCBiYWNrIHRvIHRoZSBzcG90IG9uIHRoZSBzaGFkb3cgc3RhY2sgd2hlcmUgdGhlIHNl
dGptcCgpDQp3YXMgY2FsbGVkLiBCdXQgdGhpcyBhbGdvcml0aG0gZG9lc24ndCBhbHdheXMgd29y
aywgZm9yIGV4YW1wbGUsDQpsb25nam1wKClpbmcgYmV0d2VlbiBzdGFja3MuIFRvIHdvcmsgYXJv
dW5kIHRoaXMgZ2xpYmMgdXNlcyBhIHNjaGVtZQ0Kd2hlcmUgaXQgc2VhcmNoZXMgZnJvbSB0aGUg
dGFyZ2V0IFNTUCBmb3IgYSBzaGFkb3cgc3RhY2sgdG9rZW4gYW5kIHRoZW4NCmNvbnN1bWVzIGl0
IGFuZCBJTkNTU1BzIGJhY2sgdG8gdGhlIHRhcmdldCBTUFAuIEl0IGp1c3QgYmFyZWx5DQptaXJh
Y3Vsb3VzbHkgd29ya2VkIGluIG1vc3QgY2FzZXMuDQoNClNvbWUgc3BlY2lmaWMgY2FzZXMgdGhh
dCB3ZXJlIHN0aWxsIG9wZW4gd2VyZSBsb25nam1wKClpbmcgb2ZmIG9mIGENCmN1c3RvbSB1c2Vy
c3BhY2UgdGhyZWFkaW5nIGxpYnJhcnkgc3RhY2ssIHdoaWNoIG1heSBub3QgaGF2ZSBsZWZ0IGEN
CnRva2VuIGJlaGluZCB3aGVuIGl0IGp1bXBlZCB0byBhIG5ldyBzdGFjay4gQW5kIGFsc28sIHBv
dGVudGlhbGx5IG9mZg0Kb2YgYW4gYWx0IHNoYWRvdyBzdGFjayBpbiB0aGUgZnV0dXJlLCBkZXBl
bmRpbmcgb24gd2hldGhlciBpdCBsZWF2ZXMgYQ0KcmVzdG9yZSB0b2tlbiB3aGVuIGhhbmRsaW5n
IGEgc2lnbmFsLiAodGhlIHByb2JsZW0gdGhlcmUsIGlzIGlmIHRoZXJlDQppcyBubyByb29tIHRv
IGxlYXZlIGl0KS4NCg0KU28gdGhhdCBpcyBob3cgeDg2IGdsaWMgd29ya3MsIGFuZCBJIHRoaW5r
IGFybSB3YXMgdGhpbmtpbmcgYWxvbmcgdGhlDQpzYW1lIGxpbmVzLiBCdXQgaWYgeW91IGhhdmUg
V1JTUyAoYW5kIGFybSdzIHZlcnNpb24pLCB5b3UgY291bGQganVzdA0Kd3JpdGUgYSByZXN0b3Jl
IHRva2VuIG9yIGFueXRoaW5nIGVsc2UgeW91IG5lZWQgdG8gZml4dXAgb24gdGhlIHNoYWRvdw0K
c3RhY2suIFRoZW4geW91IGNvdWxkIGxvbmdqbXAoKSBpbiBvbmUgZ28gd2l0aG91dCBhbnkgaGln
aCB3aXJlIGFjdHMuDQpJdCdzIG11Y2ggc2ltcGxlciBhbmQgbW9yZSByb2J1c3QgYW5kIHdvdWxk
IHByZXZlbnQgbmVlZGluZyB0byBsZWF2ZSBhDQpyZXN0b3JlIHRva2VuIHdoZW4gaGFuZGxpbmcg
YSBzaWduYWwgdG8gYW4gYWx0IHNoYWRvdyBzdGFjay4gQWx0aG91Z2gsDQpub3RoaW5nIHdhcyBl
dmVyIHByb3RvdHlwZWQuIFNvICJpbiB0aGVvcnkiLg0KDQpCdXQgdGhhdCBpcyBhbGwgYWJvdXQg
bW92aW5nIHRoZSBTU1Agd2hlcmUgeW91IG5lZWQgaXQuIEl0IGRvZXNuJ3QNCnJlc29sdmUgYW55
IG9mIHRoZSBhbGxvY2F0aW9uIGxpZmVjeWNsZSBpc3N1ZXMuIEkgdGhpbmsgZm9yIHRob3NlIHRo
ZQ0Kc29sdXRpb25zIGFyZToNCjEuIE5vdCBzdXBwb3J0aW5nIHVjb250ZXh0L3NpZ2FsdHN0YWNr
IGFuZCBzaGFkb3cgc3RhY2sNCjIuIFN0ZWZhbidzIGlkZWENCjMuIEEgbmV3IGludGVyZmFjZSB0
aGF0IHRha2VzIHVzZXIgYWxsb2NhdGVkIHNoYWRvdyBzdGFja3MgZm9yIHRob3NlDQpvcGVyYXRp
b25zDQoNCk15IHByZWZlcmVuY2UgaGFzIGJlZW4gYSBjb21iaW5hdGlvbiBvZiAxIGFuZCAzLiBG
b3IgdGhyZWFkcywgSSB0aGluaw0KTWFyaydzIGNsb25lMyBlbmhhbmNlbWVudHMgd2lsbCBoZWxw
Lg0KDQpBbnl3YXksIHRoZXJlIGlzIGFuIGF0dGVtcHQgYXQgYSBzdW1tYXJ5LiBJJ2QgYWxzbyBw
b2ludCB5b3UgdG8gSEogZm9yDQptb3JlIGdsaWJjIGNvbnRleHQsIGFzIEkgbW9zdGx5IHdvcmtl
ZCBvbiB0aGUga2VybmVsIHNpZGUuDQo=

