Return-Path: <linux-fsdevel+bounces-12308-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41EC585E6B7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 19:54:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C13071F26126
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 18:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F3E8594D;
	Wed, 21 Feb 2024 18:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ngzaI5nN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C0685926;
	Wed, 21 Feb 2024 18:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708541644; cv=fail; b=Q3uXriUsamZ6eRjZ20ffsJz94gG6M5mCpKjTmnviKOKEdz3gajirUQsvCHB3Yyq80uKcMD3Vjd1o/b30KgNVGGOSzkwzJXSBHFDbVJOG+vvE9EeM7H8hyCy1pvoDxj2NrNpydAM1ivNk3A69Uokk+PThKabQgxdhMsRdx7rNmEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708541644; c=relaxed/simple;
	bh=XD3/Dg2/lBptWkx+edPUXDYQQgAYQqietWZOEnyHKUI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cxzZEEypguMwyGXYJQwYfiJ2KMzwg19m4kZZMCWI6a7X4ckItkKKRwZLGcKuNifWxa9VeItDXjuM44QxdkNhpuvMFOfpjm+vAIN0dbOAb4OrMfOisnP9UhOrSxLqLN2cCGzIEgf6b+GDxmY7NQvQqCDc2AOdC8L8BMkDXA/7aMU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ngzaI5nN; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708541642; x=1740077642;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=XD3/Dg2/lBptWkx+edPUXDYQQgAYQqietWZOEnyHKUI=;
  b=ngzaI5nNiY1XzJEB2mv94QRfpgmDil3PDBFrR0ZApMTo5nxjQbRA6Bqe
   2T1XchL6whqGfIv9uV47GGIRoiVH7sMBGeyCY5kU2QskCw2/ekE8mcjDD
   eGlYxNE7pQo/e9+epP12hgMTxIzPTEX46/HC+vmRN8xPgqTOv8MNLduyx
   xNubFP5eEFI/DtvW1NmMLtVHAq3sIKVggQkaTyXrCx9yq+z/4wnZfyBN+
   mv7FW5DDXqhi99p2Xd/Qzk2LknnP9rFr6J+l1TL3l89pQGokB3H7zNhIF
   JGKYM4PLcURISBtxdBbcoENo9xu2X1ayjzt1FhHjZrL59uSUWgz//BXKU
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="2864302"
X-IronPort-AV: E=Sophos;i="6.06,176,1705392000"; 
   d="scan'208";a="2864302"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 10:54:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,176,1705392000"; 
   d="scan'208";a="5243958"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Feb 2024 10:53:59 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 21 Feb 2024 10:53:58 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 21 Feb 2024 10:53:58 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 21 Feb 2024 10:53:58 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 21 Feb 2024 10:53:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EHmOpcL2/QcfcXWM1kpkz60SmMBFH9uxZG5UapCfBY32YECV0xlj4o5M86FFLRFSUigS438HCuJQD/wf9GouK0mJXeXW6gRgC3gvki2QlVUkbzE+5Jl+paT3Qm4aAs2ytbIsXM/mbItAQbcJyI05/XbVwq2Y/c+pp6rjlApqXIBdroV7esoWxQEw3OfuWseoFb7A0x6oCclnSoTQJQ4NF1awSZYaqp6g4TsJ7Hv+pap+L/yhuwFMiEZ7ADwhk/2rTOLg/NI+OOFQ3Y9CvISzbl0WzuTm9uI+5ov/nsKE6948NWu+oErA3AVZoXZCesuLsd6xJlqqoeV6CmYqT3CwlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XD3/Dg2/lBptWkx+edPUXDYQQgAYQqietWZOEnyHKUI=;
 b=eDxpOQr7GicVrYMBjlEeIK/R9GVa0lqpMdB4XYfTfzd0WAZ7ojFTsO094yPgbDyq4oCaxyBacLF+fvG4pLizbuFJtoHYdKjPLJO2PcMqxaW8jIn1AvcWU+G3Lv9ug+u+P0UNMmPtxeQzD8HA4W6KbTsbW1cwt0ZDn/itUufa8m4YEaiesfTZue3YyF8WVencELo/wKbWMc4oL8IrVZCTUdo0YAcc8WRGq+pBTlVAVcVMRMji1Hv0+AR3TTsUFJ5uQYo4i1yYxbFJm4i4k/0oWfmuv3hSGBZNLDBDMSyGCOETwCWg3KurWojQzhyTP/d3YzisQGP2sfaKWGbd2oCvng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by SA1PR11MB7086.namprd11.prod.outlook.com (2603:10b6:806:2b3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Wed, 21 Feb
 2024 18:53:44 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::5d40:83fd:94ac:d409]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::5d40:83fd:94ac:d409%7]) with mapi id 15.20.7316.018; Wed, 21 Feb 2024
 18:53:44 +0000
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
Thread-Index: AQHaVpxQxL7eT1mQek6VcjPJOSVEZ7ETiLSAgAAiyYCAAASHgIAATE8AgAAGrQCAAAuagIAADnuAgADQTgCAABIegIAALDIAgAAF54CAAAQ9gIAABSaAgAAGX4A=
Date: Wed, 21 Feb 2024 18:53:44 +0000
Message-ID: <c3085fbe10193dfe59b25bc7da776e60779b0e8c.camel@intel.com>
References: <20240220185714.GO4163@brightrain.aerifal.cx>
	 <9fc9c45ff6e14df80ad023e66ff7a978bd4ec91c.camel@intel.com>
	 <20240220235415.GP4163@brightrain.aerifal.cx>
	 <a57d6c7eada4b9a7c35addbc8556f5b53a0c3e6f.camel@intel.com>
	 <20240221012736.GQ4163@brightrain.aerifal.cx>
	 <d18f060d-37ac-48b1-9f67-a5c5db79b34e@sirena.org.uk>
	 <20240221145800.GR4163@brightrain.aerifal.cx>
	 <4a3809e8-61b2-4341-a868-292ba6e64e8a@sirena.org.uk>
	 <20240221175717.GS4163@brightrain.aerifal.cx>
	 <f4a54297767eb098d903404cbe8860d655d79bed.camel@intel.com>
	 <20240221183055.GT4163@brightrain.aerifal.cx>
In-Reply-To: <20240221183055.GT4163@brightrain.aerifal.cx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|SA1PR11MB7086:EE_
x-ms-office365-filtering-correlation-id: 2cd7a699-a011-44df-0e2a-08dc330e6dd7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Wb3iU4lBRYXmQL8QgNSm4obykimOm0FfHt8qIMd+Qmi5SnFLonkgNzRwTiNPsmoovXtkFxmiTRXoZSHjj5zs7OHlzFut5IRGTk3Yi8BFju12ZTG96dytPZDQZjn/fLeUGmb2BJW5O+S3nt7ydMU5pril77zfHrdV0hnoeYCqfGVVIiwIXi6Pj+e6nDbSd5SFYqvx+CiBWUeCvdIt47DteiFRM6VHrI+UR3yEP6u0/ijfyR2Hx6medHPM+QSvPW0bdYuRnV1eIXcw3CSAUfrNr6dDBSmJQF6dPAAGmeBtXmjfJqxoN3vZiMs+4JGBXIRjJiKZVhW6TisbmsPIJSGqQJ2Ou1ZM0kRKpauCok908kkWh5csgbjC55JnF5Ys2zQThO+lU2MfrB9uhzKnh03pjtQdSkzs/0ymX+pXLKYNxZOqSSBhkiJ6hOcV7kdKVsiwH1PcN1OwDgaDDJrjWQWYAZ5TXYuzBzEKP9KrYZ+jFGIeysZjP9G/j8Y/7CZtLNrJUPzHBaZBOoo4A9fFPZ8P2BCRLVSr9VPU2XFXKKsT3WPi8wnd1WyMCVe25TAkdJX2HpGuGaq6EwRxK+XGZO+1ed/73TG7Db6EwWL7UsImoN4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZXFNc0p2bUlOWUtldWpiN2wyNEFYeVN1Q0hvbmxTblBxa1ZMNnk2UlVPbWtI?=
 =?utf-8?B?SXNVdWhzb1daZ0I4MFpDTVM2TExGL2FOWGc4Y3NrTExxRk5lOE9tNjdhY1ly?=
 =?utf-8?B?QkhQdHNsWHJCUUhCUVNXUCtXd3BYY0xuUGJsM1h0aEhJVHlMWlg5MFJWRXNE?=
 =?utf-8?B?YnpCMEUyQjllTGRGbWRmQ29XN0U3dk1UeWlsa0EydE1ianMvZFpacUhxd1h0?=
 =?utf-8?B?ZWw2OVN5c1pkRnFQbTBYRmJ1cVpQMGlYekhabXF6QnBtQkxRY1dhTjFoT2dL?=
 =?utf-8?B?Qm1tOEJoSW1FWXZDSDh4S1kvajBYV0xHMm5qNGkzTHZ4bVl1aUtIV1Q4V3VZ?=
 =?utf-8?B?OW1KcVdnRkNpK3JuazBUZ290K1puU3p2S3ZqSDVDRWQ1R3ZtVDRuTXhBOHVi?=
 =?utf-8?B?Q2tkMk44YTROdWtwRnFWcHREZm5jZC9DT2pKdjBab1pVM0hjbXZPTEQ4NHls?=
 =?utf-8?B?TjZHU21wUmw0cTkyWTgxalYxUzFJS2pzV2h5WFVqNWx5Rlh6V0M5RE93aGV1?=
 =?utf-8?B?UnIyMlB0RE8waWNoa21PUjBoMlhwTnQrVGU5aDRPSENYMHJHWmtPNWNIR2Fz?=
 =?utf-8?B?NDZCakR4QmNHLzBQOGpFOU04MjBZWkd5T2dLYmpjc0daRWk2N09YakhhcGlR?=
 =?utf-8?B?MWlCZ2pFZ1NjT0RlTTZ0azE0bnI0WDJKeHMrQU13V2V2V2dFeG8rMTQ5aWRS?=
 =?utf-8?B?dHUxWEJMV2djZUdRd21qKy9uRGNrRTFtSGUvZytqS2xoMVo4QnllK2krT2hm?=
 =?utf-8?B?bmI1WVJwRjdTYUxETVl3NFJkTzV4N01SR0gwK3czcE5oRkZGUnJOTjFLRWY5?=
 =?utf-8?B?K0xQS3BvUEcxYWtOSXRVOU95ZVNiM1hBSWFyVmdFUVJuSW9zdVlWd2pVcHMz?=
 =?utf-8?B?b3J2SEtpZjZzVTNZUlRVU3IzTG5talZxVWt6aDRQUlhYWG5BWFlBRmVlYWRC?=
 =?utf-8?B?SFE4SUpPWG1uamdCa0dWeCtZcU1BY3RreUllaXZBR2QwY1czMTRERDNENlRR?=
 =?utf-8?B?Y0FqQ0svcEU0SXlJaWZTa1lNR3NESlJXZkhPRDZrcU1Teno2dG1ubVJDbytG?=
 =?utf-8?B?NEZEanJEejFXaTF2T3VjckRMa1lVeSt5UjI2dDBCd3F3MFJTY09YT2JhcnRu?=
 =?utf-8?B?ZlFLZitEdWxURngwNyt3aWIyUVdUYzJqY2JSZHZEamlPa0prVUdaT2czWjdn?=
 =?utf-8?B?K240YmlveXhQYXZ3blJkV3pZVW8wUXY2QzJ6elNnOFEzNERaN3VlK1B5enVn?=
 =?utf-8?B?NXRlNWZhYjFlWFl6WW83eXN5SDRWNHY0U1pNMy9NR3JuZ0ZoL1hjS2UrMVRV?=
 =?utf-8?B?cXNmUDVMcDFGVmcyWmxqcEpwTE1Pa0hJZ2ZpSUJNdGtLVEN6M2RmMEJtM0kr?=
 =?utf-8?B?RThrU3ZhVDltZ3BMQ2pvZlQwMnFXNkNaZEFQOVdmZDVacnlNcVFEbFUyeHNB?=
 =?utf-8?B?aDNacDJlSzF6aHZONEx6cStyQzlMUVlMSjRrZzllZmx1Ti9lbm9HMGZoV0tB?=
 =?utf-8?B?aWRiRTA5VXRUL1h0SlljQkx6dFRwdjc5cmxwTGRoU0tPK1ZYOU51VFVWOFE5?=
 =?utf-8?B?QXpKbE0zWGZXaG5rODBnRlJweW9SZmN1VjZldks4eC9teExTUWJQN011ZFNO?=
 =?utf-8?B?WTd3VWxWdmt2VTlDbVVzeDJzZXh5SUhTemtOMS96UkNzaGVFbTU2aU5XOG04?=
 =?utf-8?B?OXZ0T0xSeEFqS1BOM3dMK0VlRjRmY1h4ZFBTSFJGM09adFl0Vk0yTEExd0Vy?=
 =?utf-8?B?blR5WVFmYjBsNHlRanUzQXlUYkF4STErWUo4d1FuK3BTTlEzUS9weGYvR29G?=
 =?utf-8?B?czJzRndiaTUrQ0dTaENEVDJHTlAzaU5lVUQvOUdHV3liYTVGT21aUzRUTlg5?=
 =?utf-8?B?ekVLcXBKdUJXVTBvNVRFZDYzQld5ZFpJQ3VIek1Ob0pRY0xxbUtMMTEyenRO?=
 =?utf-8?B?bEN5dXpMVUltZlBOeWxCWmRUdG1rd2p6MFRkTmFnbEROcTlkNVZaMjB5djgx?=
 =?utf-8?B?dUJ6ZXRmd1FGWjJ0OUw0TlhhamJLY1JlUzhwcHNXWlowK2dvRHY2ckFxeUNE?=
 =?utf-8?B?TXVTblFQL2MxbEJiRXVXVVpYbmt2VnZmT2xoN2pzQXZUanpDV0V2UDBzbGd0?=
 =?utf-8?B?d28wSkZPR3NNalhBeGtWMEFmcnd0MXNoTmpIY1p0b2hhWkh4QTdkcU9STkhL?=
 =?utf-8?Q?HAUgTmF7fSNcVTQIDigG70o=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <54FB79F0FF7D744E8DDF82D22D33BDDF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cd7a699-a011-44df-0e2a-08dc330e6dd7
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2024 18:53:44.4632
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +4KEvFRa1hayVzlGJI/MhjHnStXlSjgSPqSyeMoO0NJVozWga5a1XdpBl4fM3S1db5DeXVMovvm+l4At/ygjbNNxGTEv1nSsNOkUyD8sR8A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7086
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI0LTAyLTIxIGF0IDEzOjMwIC0wNTAwLCBkYWxpYXNAbGliYy5vcmcgd3JvdGU6
DQo+ID4gMyBpcyB0aGUgY2xlYW5lc3QgYW5kIHNhZmVzdCBJIHRoaW5rLCBhbmQgaXQgd2FzIHRo
b3VnaHQgaXQgbWlnaHQNCj4gPiBub3QNCj4gPiBuZWVkIGtlcm5lbCBoZWxwLCBkdWUgdG8gYSBz
Y2hlbWUgRmxvcmlhbiBoYWQgdG8gZGlyZWN0IHNpZ25hbHMgdG8NCj4gPiBzcGVjaWZpYyB0aHJl
YWRzLiBJdCdzIG15IHByZWZlcmVuY2UgYXQgdGhpcyBwb2ludC4NCj4gDQo+IFRoZSBvcGVyYXRp
b25zIHdoZXJlIHRoZSBzaGFkb3cgc3RhY2sgaGFzIHRvIGJlIHByb2Nlc3NlZCBuZWVkIHRvIGJl
DQo+IGV4ZWN1dGFibGUgZnJvbSBhc3luYy1zaWduYWwgY29udGV4dCwgc28gdGhpcyBpbXBvc2Vz
IGEgcmVxdWlyZW1lbnQNCj4gdG8NCj4gYmxvY2sgYWxsIHNpZ25hbHMgYXJvdW5kIHRoZSBsb2Nr
LiBUaGlzIG1ha2VzIGFsbCBsb25nam1wcyBhIGhlYXZ5LA0KPiBtdWx0aS1zeXNjYWxsIG9wZXJh
dGlvbiByYXRoZXIgdGhhbiBPKDEpIHVzZXJzcGFjZSBvcGVyYXRpb24uIEkgZG8NCj4gbm90DQo+
IHRoaW5rIHRoaXMgaXMgYW4gYWNjZXB0YWJsZSBpbXBsZW1lbnRhdGlvbiwgZXNwZWNpYWxseSB3
aGVuIHRoZXJlIGFyZQ0KPiBjbGVhcmx5IHN1cGVyaW9yIGFsdGVybmF0aXZlcyB3aXRob3V0IHRo
YXQgY29zdCBvciBpbnZhc2l2ZW5lc3MuDQoNClRoYXQgaXMgYSBnb29kIHBvaW50LiBDb3VsZCB0
aGUgcGVyLXRocmVhZCBsb2NrcyBiZSBuZXN0YWJsZSB0byBhZGRyZXNzDQp0aGlzPyBXZSBqdXN0
IG5lZWQgdG8ga25vdyBpZiBhIHRocmVhZCAqbWlnaHQqIGJlIHVzaW5nIHNoYWRvdyBzdGFja3Mu
DQpTbyB3ZSByZWFsbHkganVzdCBuZWVkIGEgcGVyLXRocmVhZCBjb3VudC4NCg0KPiANCj4gPiAx
IGFuZCAyIGFyZSBQT0NlZCBoZXJlLCBpZiB5b3UgYXJlIGludGVyZXN0ZWQ6DQo+ID4gaHR0cHM6
Ly9naXRodWIuY29tL3JwZWRnZWNvL2xpbnV4L2NvbW1pdHMvc2hzdGtfc3VwcHJlc3NfcmZjLw0K
PiANCj4gSSdtIG5vdCBjbGVhciB3aHkgMiAoc3VwcHJlc3Npb24gb2YgI0NQKSBpcyBkZXNpcmFi
bGUgYXQgYWxsLiBJZg0KPiBzaGFkb3cgc3RhY2sgaXMgYmVpbmcgZGlzYWJsZWQsIGl0IHNob3Vs
ZCBqdXN0IGJlIGRpc2FibGVkLCB3aXRoDQo+IG1pbmltYWwgZmF1bHQgaGFuZGxpbmcgdG8gcGFw
ZXIgb3ZlciBhbnkgcmFjaW5nIG9wZXJhdGlvbnMgYXQgdGhlDQo+IG1vbWVudCBpdCdzIGRpc2Fi
bGVkLiBMZWF2aW5nIGl0IG9uIHdpdGggZXh0cmVtZSBzbG93bmVzcyB0byBtYWtlIGl0DQo+IG5v
dCBhY3R1YWxseSBkbyBhbnl0aGluZyBkb2VzIG5vdCBzZWVtIHVzZWZ1bC4NCg0KVGhlIGJlbmVm
aXQgaXMgdGhhdCBjb2RlIHRoYXQgaXMgdXNpbmcgc2hhZG93IHN0YWNrIGluc3RydWN0aW9ucyB3
b24ndA0KY3Jhc2ggaWYgaXQgcmVsaWVzIG9uIHRoZW0gd29ya2luZy4gRm9yIGV4YW1wbGUgUkRT
U1AgdHVybnMgaW50byBhIE5PUA0KaWYgc2hhZG93IHN0YWNrIGlzIGRpc2FibGVkLCBhbmQgdGhl
IGludHJpbnNpYyBpcyB3cml0dGVuIHN1Y2ggdGhhdCBhDQpOVUxMIHBvaW50ZXIgaXMgcmV0dXJu
ZWQgaWYgc2hhZG93IHN0YWNrIGlzIGRpc2FibGVkLiBUaGUgc2hhZG93IHN0YWNrDQppcyBub3Jt
YWxseSByZWFkYWJsZSwgYW5kIHRoaXMgaGFwcGVucyBpbiBnbGliYyBzb21ldGltZXMuIFNvIGlm
IHRoZXJlDQp3YXMgY29kZSBsaWtlOg0KDQogICBsb25nIGZvbyA9ICoobG9uZyAqKV9nZXRfc3Nw
KCk7DQoNCi4uLnRoZW4gaXQgY291bGQgc3VkZGVubHkgcmVhZCBhIE5VTEwgcG9pbnRlciBpZiBz
aGFkb3cgc3RhY2sgZ290DQpkaXNhYmxlZC4gKG5vdGljZSwgaXQncyBub3QgZXZlbiBhICJzaGFk
b3cgc3RhY2sgYWNjZXNzIiBmYXVsdC13aXNlLiBTbw0KaXQgd2FzIGxvb2tlZCBhdCBhcyBzb21l
d2hhdCBtb3JlIHJvYnVzdC4gQnV0IG5laXRoZXIgMSBvciAyIGFyZQ0KcGVyZmVjdCBmb3IgYXBw
cyB0aGF0IGFyZSBtYW51YWxseSB1c2luZyBzaGFkb3cgc3RhY2sgaW5zdHJ1Y3Rpb25zLg0KDQo+
IA0KPiBJcyB0aGVyZSBzb21lIHdheSBmb2xrcyBoYXZlIGluIG1pbmQgdG8gdXNlIG9wdGlvbiAy
IHRvIGxhemlseQ0KPiBkaXNhYmxlDQo+IHNoYWRvdyBzdGFjayBvbmNlIHRoZSBmaXJzdCBTUy1p
bmNvbXBhdGlibGUgY29kZSBpcyBleGVjdXRlZCwgd2hlbg0KPiBleGVjdXRpb24gaXMgdGhlbiBr
bm93biBub3QgdG8gYmUgaW4gdGhlIG1pZGRsZSBvZiBhIFNTLWNyaXRpY2FsDQo+IHNlY3Rpb24s
IGluc3RlYWQgb2YgZG9pbmcgaXQgcmlnaHQgYXdheT8gSSBkb24ndCBzZWUgaG93IHRoaXMgY291
bGQNCj4gd29yaywgc2luY2UgdGhlIFNTLWluY29tcGF0aWJsZSBjb2RlIGNvdWxkIGJlIHJ1bm5p
bmcgZnJvbSBhIHNpZ25hbA0KPiBoYW5kbGVyIHRoYXQgaW50ZXJydXB0ZWQgYW4gU1MtY3JpdGlj
YWwgc2VjdGlvbi4NCg0KVGhlIGlkZWEgd2FzIHRvIGRpc2FibGUgaXQgd2l0aG91dCBjcml0aWNh
bCBzZWN0aW9ucywgYW5kIGl0IGNvdWxkIGJlDQptb3JlIHJvYnVzdCwgYnV0IG5vdCBwZXJmZWN0
LiBJIHdhcyBwcmVmZXJyaW5nIG9wdGlvbiAxIGJldHdlZW4gMSBhbmQNCjIsIHdoaWNoIHdhcyBj
bG9zZXIgdG8geW91ciBvcmlnaW5hbCBzdWdnZXN0aW9uLiBCdXQgaXQgaGFzIHByb2JsZW1zDQps
aWtlIHRoZSBleGFtcGxlIEkgZ2F2ZSBhYm92ZS4gSSBhZ3JlZSAxIGlzIHJlbGF0aXZlbHkgc2lt
cGxlciBmb3IgdGhlDQprZXJuZWwsIGJldHdlZW4gMSBhbmQgMi4NCg0KPiANCj4gPiA+IElmIGZv
bGtzIG9uIHRoZSBrZXJuZWwgc2lkZSBhcmUgbm90IGdvaW5nIHRvIGJlIGFtZW5hYmxlIHRvIGRv
aW5nDQo+ID4gPiB0aGUNCj4gPiA+IHRoaW5ncyB0aGF0IGFyZSBlYXN5IGZvciB0aGUga2VybmVs
IHRvIG1ha2UgaXQgd29yayB3aXRob3V0DQo+ID4gPiBicmVha2luZw0KPiA+ID4gY29tcGF0aWJp
bGl0eSB3aXRoIGV4aXN0aW5nIGludGVyZmFjZXMsIGJ1dCB0aGF0IGFyZSBpbXBvc3NpYmxlDQo+
ID4gPiBvcg0KPiA+ID4gbmVhci1pbXBvc3NpYmxlIGZvciB1c2Vyc3BhY2UgdG8gZG8sIHRoaXMg
c2VlbXMgbGlrZSBhIGRlYWQtZW5kLg0KPiA+ID4gQW5kDQo+ID4gPiBJDQo+ID4gPiBzdXNwZWN0
IGFuIG9wZXJhdGlvbiB0byAiZGlzYWJsZSBzaGFkb3cgc3RhY2ssIGJ1dCB3aXRob3V0IG1ha2lu
Zw0KPiA+ID4gdGhyZWFkcyBzdGlsbCBpbiBTUy1jcml0aWNhbCBzZWN0aW9ucyBjcmFzaCIgaXMg
Z29pbmcgdG8gYmUNCj4gPiA+IG5lY2Vzc2FyeS4uDQo+ID4gDQo+ID4gSSB0aGluayB3ZSBoYXZl
IHRvIHdvcmsgdGhyb3VnaCBhbGwgdGhlIGFsdGVybmF0aXZlIGJlZm9yZSB3ZSBjYW4NCj4gPiBh
Y2N1c2UgdGhlIGtlcm5lbCBvZiBub3QgYmVpbmcgYW1lbmFibGUuIElzIHRoZXJlIHNvbWV0aGlu
ZyB0aGF0DQo+ID4geW91DQo+ID4gd291bGQgbGlrZSB0byBzZWUgb3V0IG9mIHRoaXMgY29udmVy
c2F0aW9uIHRoYXQgaXMgbm90IGhhcHBlbmluZz8NCj4gDQo+IE5vLCBJIHdhcyBqdXN0IGludGVy
cHJldGluZyAidXBoaWxsIGJhdHRsZSIuIEkgcmVhbGx5IGRvIG5vdCB3YW50IHRvDQo+IGVuZ2Fn
ZSBpbiBhbiB1cGhpbGwgYmF0dGxlIGZvciB0aGUgc2FrZSBvZiBtYWtpbmcgaXQgcHJhY3RpY2Fs
IHRvDQo+IHN1cHBvcnQgc29tZXRoaW5nIHRoYXQgd2FzIG5ldmVyIG15IGdvYWwgdG8gYmVnaW4g
d2l0aC4gSWYgSSdtDQo+IG1pc3JlYWRpbmcgdGhpcywgb3IgaWYgb3RoZXJzIGFyZSB3aWxsaW5n
IHRvIHB1dCB0aGUgZWZmb3J0IGludG8gdGhhdA0KPiAiYmF0dGxlIiwgSSdkIGJlIGhhcHB5IHRv
IGJlIG1pc3Rha2VuIGFib3V0ICJub3QgYW1lbmFibGUiLg0KDQpJIGRvbid0IHRoaW5rIHg4NiBt
YWludGFpbmVycyBoYXZlIHB1dCBhIGZvb3QgZG93biBvbiBhbnl0aGluZyBhcm91bmQNCnRoaXMg
YXQgbGVhc3QuIFRoZXkgd291bGQgbm9ybWFsbHkgaGF2ZSBjb25jZXJucyBhYm91dCBjb21wbGV4
aXR5IGFuZA0KbWFpbnRhaW5hYmlsaXR5LiBTbyBpZiB3ZSBoYXZlIHNvbWV0aGluZyB0aGF0IGhh
cyBsb3dlciB2YWx1ZQ0KKGltcGVyZmVjdCBzb2x1dGlvbiksIGFuZCBoaWdoIGNvbXBsZXhpdHks
IGl0IHN0YXJ0cyB0byBsb29rIGxpa2UgbGVzcw0KcHJvbWlzaW5nIHBhdGguDQo=

