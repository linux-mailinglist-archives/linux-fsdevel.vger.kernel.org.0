Return-Path: <linux-fsdevel+bounces-5748-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 578AF80F925
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 22:23:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C15F1B20F68
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 21:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD9C6413B;
	Tue, 12 Dec 2023 21:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="InNXhKAn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C08AD;
	Tue, 12 Dec 2023 13:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702416216; x=1733952216;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=qPA06EMsxn4ZdCbgvvYpOcMfbzoNvDOXQdORaBMyLEg=;
  b=InNXhKAnCGLr+811P+53PI5F2DFj0WaxwfcQp1H4MllSGl7NycnoteYV
   6cAsIPS9cVjjKCuSXTU3oSrsnN2FWJy/YLd27PZjVzVFF9TuSLUnUA17C
   PvJed3LcDLE9jpwpE3bJynufoZBgx0vt3qmFJqb8FqWbQaRQ/rQv6HoaY
   nWn6G95KSiQzLCPJfAyVlOnqvifP4vAywgNn44StQjFp3hKL9zCCjGeSB
   9Wn94UP3ybr3LVA6yze3c4wbTlFMq9IEQTNOL/le2qKygt2ZNRXni9L03
   scwhA3jltq4FfGUrWyoFOTB5pOpqB4om9XDoGmWcnNWhBtPB0zxoV0r5t
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="481070659"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="481070659"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 13:23:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="802622558"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="802622558"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Dec 2023 13:23:34 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Dec 2023 13:23:33 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 12 Dec 2023 13:23:33 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 12 Dec 2023 13:23:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Df+dFz2IQ2WVT+5ch6m7R/jaxNOKHqqZEpVyLSGhqOE8QuoHAEkdOVL8syzJNPc3QwQ3dI4mxqfkwrCxOh3K0zlJ/yELkONcpHysZzAiWsus+//Gxjw+MVgbzIgZXuOgjsbT2BEoYaTW53xVwb5y9Mmy3aBM/EGT/Q6tUAQIuNauu2oxyE+Iql/24Ww0ahsjhkVw9NRs92uBanQt3ZTnWKIbbgWdulND2Ej6c2muyzx/6xwXwBMZDvYDSHFedRNcp4yUUEkh5yuRovWjI7/8iJa47k6nIvihWJel93YnzBYGr6cLNpRSvEDoIElNXF9YrUWZIhHqyQ3O7Ou19LdcKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qPA06EMsxn4ZdCbgvvYpOcMfbzoNvDOXQdORaBMyLEg=;
 b=n78YxjNWaZY5gMuNLF8/A0eBFZY5w0kF9nPmKxkW0k8kmMr+4yyOriT7qE65oC6XxWeD+Xh/+uiKr7wg3YEgxPU/FZkjF/4imM0y/A4FOLz2hlfY/Ak/8V4E+a1p7az8/GK9jaKsWdSjfV4L2OJ+p8lcGZw3RMU8tVlxkMdB5XLlEHglgOqLuxpRsx8Scknb9Vkew9quAkfUpfUWEo3jeRaYFE/nr/Jp8wcB+XE9ORjyzdxmSeN3fFpM2Xd9LTzvn+2a0zdq1jl9lvuSzxaTBjy8yVcS+DIuqxHvutfuy80EcZJEa/P/yn19C9PkT6gZW9bWVVoJ4BlI98ilEkqpLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by LV8PR11MB8605.namprd11.prod.outlook.com (2603:10b6:408:1e5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Tue, 12 Dec
 2023 21:23:00 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::6dc:cee5:b26b:7d93]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::6dc:cee5:b26b:7d93%4]) with mapi id 15.20.7068.031; Tue, 12 Dec 2023
 21:23:00 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "broonie@kernel.org" <broonie@kernel.org>
CC: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
	"suzuki.poulose@arm.com" <suzuki.poulose@arm.com>, "Szabolcs.Nagy@arm.com"
	<Szabolcs.Nagy@arm.com>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, "catalin.marinas@arm.com"
	<catalin.marinas@arm.com>, "corbet@lwn.net" <corbet@lwn.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>, "oliver.upton@linux.dev"
	<oliver.upton@linux.dev>, "palmer@dabbelt.com" <palmer@dabbelt.com>,
	"debug@rivosinc.com" <debug@rivosinc.com>, "aou@eecs.berkeley.edu"
	<aou@eecs.berkeley.edu>, "rppt@kernel.org" <rppt@kernel.org>,
	"shuah@kernel.org" <shuah@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>,
	"maz@kernel.org" <maz@kernel.org>, "oleg@redhat.com" <oleg@redhat.com>,
	"fweimer@redhat.com" <fweimer@redhat.com>, "keescook@chromium.org"
	<keescook@chromium.org>, "james.morse@arm.com" <james.morse@arm.com>,
	"ebiederm@xmission.com" <ebiederm@xmission.com>, "brauner@kernel.org"
	<brauner@kernel.org>, "will@kernel.org" <will@kernel.org>,
	"thiago.bauermann@linaro.org" <thiago.bauermann@linaro.org>,
	"hjl.tools@gmail.com" <hjl.tools@gmail.com>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"paul.walmsley@sifive.com" <paul.walmsley@sifive.com>, "ardb@kernel.org"
	<ardb@kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>
Subject: Re: [PATCH v7 02/39] prctl: arch-agnostic prctl for shadow stack
Thread-Topic: [PATCH v7 02/39] prctl: arch-agnostic prctl for shadow stack
Thread-Index: AQHaHSi7sAK+Ev02qEq/1HaZdZvzcLCmNgsAgAACjICAAA/ZAA==
Date: Tue, 12 Dec 2023 21:22:59 +0000
Message-ID: <4acb51ebb3764f6a48a741d7b7d33f9a68c996fb.camel@intel.com>
References: <20231122-arm64-gcs-v7-0-201c483bd775@kernel.org>
	 <20231122-arm64-gcs-v7-2-201c483bd775@kernel.org>
	 <e1362732ba86990b7707d3f5b785358b77c5f896.camel@intel.com>
	 <28c584ff-ef25-464f-852c-c5ddf66e5906@sirena.org.uk>
In-Reply-To: <28c584ff-ef25-464f-852c-c5ddf66e5906@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|LV8PR11MB8605:EE_
x-ms-office365-filtering-correlation-id: 9669cd04-cf7c-4af0-777c-08dbfb588409
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6WLJqOXh6LPtHQSucO9Wxa5e90qEt9egF0ve9CpX0CAFknBy9iebLSMS+GlcDxbtuz1Cfm66Caa+jBa09vPpOtignVVe5WzKCtwGQ+8tcDNzQG27PH6iHdgrQDfkCXicsSRB3T7DR9mhtRxnfGzSFTwVwVrLyvJWHW3ctnUA7stCaz3WSA/HyUFM0z/4Fd4DrAR/GbuxmRikLy5aD9OsjFmJeE7plpBt+y6fL6kp4M6/n1jF5Pmi12ehzowNt5nh0yzWIIH3BKETe4D8o0mwN49+aAvoB5i/KuEX5tjRsBRbXRu/XwdkxPwuHo2ua/c3f9hBR9Kn5wyevjw5Ni38S+uI3bYRNnbiXyjWTdUt8tELIdV3hDYSb5y48YnovbdelCWNnwsO9lJtW+vVIrwqZTMx5BdcTTtu85XXvdjNnveKsEWonlcOvpGDQ74wLwqlezUK37rDbiBMvPHnfC0DftLQ9cnSrHM6XRuzB0RM7o2gOLWJmNZLL3ejq8+3WLWDCGy4fcThG0aW2GgeLquPs6g9MZsBA6YcY6HxG1ZwWKgpC0swq4QkL4n55j6N1oFKu65mLtN8hgqlgRbgbdk5A7OrmiGa7n5fefR3/Qw/aA8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(39860400002)(376002)(346002)(366004)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(26005)(2616005)(41300700001)(71200400001)(6506007)(6512007)(7406005)(5660300002)(66446008)(4326008)(478600001)(2906002)(83380400001)(966005)(6486002)(8676002)(8936002)(66946007)(76116006)(316002)(66476007)(91956017)(6916009)(64756008)(4001150100001)(54906003)(7416002)(66556008)(122000001)(82960400001)(86362001)(38100700002)(36756003)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZVZ6WWhlbFc4eEpad01iWi9LV2ZKeGp3S3NTc29hcVc1aG1NUDUxZkx6aWxy?=
 =?utf-8?B?emZOKzBDbXNlY0FwaTFYRGZyclY4ZXl0ZHhwaU02K1ZZcFVjVHE5VW8zQk5w?=
 =?utf-8?B?c3c0TExacVYvbVhUM3hINGJEaFpPcU9FeTJlUEtaenRFU2ljdlQ3WDVwUGFm?=
 =?utf-8?B?eTBoSXVvOE13TmxkTW1EZmptdGg3SHZIaWJhMmgxNDNNV3ZUNjNVOW5rUlMw?=
 =?utf-8?B?cHFmTDUzM3ZzUEsrMWdtSEQ3ZFZHSVQ4d2hzVjVRbGlrMUVEVnpTV2tPaFR2?=
 =?utf-8?B?UmJWZ3RxTDU3ZjdXQVlqWWxVdnlteGZsREFkMUhENWZiUnJZZEtZZEtBU2NP?=
 =?utf-8?B?Mlh0VngrWGtQWXJZYXNxZFdyaW1laitob2dORndiODA1SVBxMlBTS3h1bjY4?=
 =?utf-8?B?ZjExOGhyUHJaRXNMdXlMZzdpWXB4WmZtQVJEZlBJaTFOUDRZTmdqTDgybllL?=
 =?utf-8?B?b3Fwa1J6dnFQRFNYekYrNm1za2lGS0NTT3pWTFY5VHZ3WFBYNkprdlF0dlln?=
 =?utf-8?B?eFkvTFdIeSttL1oxQ0N3OW9Oa0lLMkp2M0F3K2F3bG5JZzBTU0d1TkdqSDF6?=
 =?utf-8?B?UVoxcEkwWXZzSWt1ZEc3ZUJqQ1lmOUNHamRNb0VjNmE4M2xGUXpySkZVS09y?=
 =?utf-8?B?UlBFTHZ6ZE1IYlpDSEdLeC9LL0FDYnpkSEhxaWdCSzlzZWxaSUcramwweXFE?=
 =?utf-8?B?QVVjRncxelRZRUYyaWtSOHJ2MFE0L3F6MVFKR2Fhamp6cWVNenJvQUZKNEx6?=
 =?utf-8?B?Nk9NaDJjd01OM0xKYWhNWjU2VHoybWhIZGtiM2w4czQ5NFpFTDdNeFEwaFY1?=
 =?utf-8?B?a2NBc2gzZ2pLYUV5QS9OQkJveGk5dXc5L1l4aGJpQ29BZHBVQXVNalpVb1h4?=
 =?utf-8?B?bStGMlI3Z2U2N3Z2cko2ZEtqOVNqZE4yN0lHUy9XbHlFWWlQQmpWSDFKeU5Q?=
 =?utf-8?B?MlV3UEpjSjJ5Zm0vSmlyRGR4NW9ZQVN2RlJBRGNpZGcwNi9GTnh4Wlg0VTVn?=
 =?utf-8?B?ZWlacFRDN0pFd0ZjUVMzZit0OFJyYW9wellCMWd6UVczamQ4M1d1T1VqWUxx?=
 =?utf-8?B?K1hRb2R3ME4ySy90T3JBaDJma3lBU0ZhdG5YclVlRElvWGdxSnBkT0ZxU2Yr?=
 =?utf-8?B?TWJaSU00aUZtZjFwcGtGRGJycG5zcldWSTEwTGJvVjhQNkZYblljeTJ0blB2?=
 =?utf-8?B?dG5pczIzdVN4NkM5ZDJwc3M3NCtLNXpWOXFTS3gyY3BTbjEzVGpTY0h3dXVu?=
 =?utf-8?B?eTFFUkw1ZWQ2WW1nT1FlNC9ERDRGRHNnQ3FtQmJKdmRMTlM1UHpyS2dVcFd0?=
 =?utf-8?B?SXRTYkVndGV2UzdIK2szTWtobDRMYmx0WEhtRWtWcTRUV1J6aHlwZkFVWXlR?=
 =?utf-8?B?N2ZnQXZTYzhSakNMQ1FHZHg3Wjd4bFJLNnYwbXZSTTQxS28wWm5PK09hdE0r?=
 =?utf-8?B?NnRmdGw4eHFrdlc3cHM1emc2L2VoUDBTL3hkNDBXMWhSSnQvbmZyWGRvYzhp?=
 =?utf-8?B?bjc5NVpDaDNZc290TmJTdHV3SHA5SjFBRFBTSE1KSmdEaUJtSkJMd1N6V21I?=
 =?utf-8?B?RWs4eVc3REFiYWZheEtSRjVnYUxyelhpd0RMelB6WS9iUzVVeVlKOXlyaG83?=
 =?utf-8?B?MWVpaEJMMGtjNGhrTURFMnZnZG1UUTcvU0xtSW93Y3kzTUh1NDJqOUtyTFVp?=
 =?utf-8?B?eGpkaXV5VlpsQVM4ODNZUFFXazNBclZGQmh3UTNJckQ5NVB5OWg0NFZLeFEz?=
 =?utf-8?B?R0VDcU53KzZwZlcxTGhibUhDbWNMSFlYWXA5REY0ajRFeVBYeDhpbkp1R2R0?=
 =?utf-8?B?VVM3R3hzUEtnL1NuVUUyZXRFSmF2bDFtVE9LZWFSalRRcTEzS1cwMFdGRTNv?=
 =?utf-8?B?ZVJ2UFdPOFhiR0sySzZBdXVyWXNuTkI3dm5ybUpwdXZWTDhIZXMzTjc1RW4z?=
 =?utf-8?B?OEZjME1TSTRhOGhTYkhIdUo4UXF2a0J3MXJqYlV4Mm9HaTRHZ2hVcVF0cHhD?=
 =?utf-8?B?NmFqME85TFNaWDg2UHRKZ1k1UjJCekI0RHltTFVwSVUrK2dwM29TMmZZditB?=
 =?utf-8?B?djk3cXVBS2ZoR1J6eGxUdy9leTNycnMya2dldSt2akZGbW42SzRtY2FWU1NO?=
 =?utf-8?B?eStKUHpGamQ3dHF2MzZ6Vnc3MEVDMzliY2M0SmwwVEwwY2VHM0ZVTTNNMkVX?=
 =?utf-8?B?NlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <527013D03C82B843B6D255C730CB57BF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9669cd04-cf7c-4af0-777c-08dbfb588409
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2023 21:22:59.3387
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MgTEZojq1F2pxmkTV/oMbixzUtUjdJgUiYbICWT7uABBHMEKjmH3Cz+bqOnC2+opgDxDhUsRyrqMAlQpIBfxukuNk40i9wY5CmUQcVaGuMU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8605
X-OriginatorOrg: intel.com

K01pa2UsIHdobyBkaWQgdGhlIENSSVUgd29yaw0KDQpSZToNCmh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL2xrbWwvZTEzNjI3MzJiYTg2OTkwYjc3MDdkM2Y1Yjc4NTM1OGI3N2M1Zjg5Ni5jYW1lbEBp
bnRlbC5jb20vDQoNCk9uIFR1ZSwgMjAyMy0xMi0xMiBhdCAyMDoyNiArMDAwMCwgTWFyayBCcm93
biB3cm90ZToNCj4gVGhlIHNldCBvZiBsb2NrZWQgZmVhdHVyZXMgaXMgcmVhZC93cml0ZSB2aWEg
cHRyYWNlIGluIG15IGFybTY0DQo+IHNlcmllcywNCj4gdGhhdCdzIGFyY2hpdGVjdHVyZSBzcGVj
aWZpYyB1bmZvcnR1bmF0ZWx5IGJ1dCB0aGF0IHNlZW1zIHRvIGJlIHRoZQ0KPiB3YXkNCj4gd2l0
aCBwdHJhY2UuDQoNCkFoLCBzb3JyeSBJIGRpZG4ndCBzZWUgdGhhdCBsYXRlciBpbiB0aGUgc2Vy
aWVzLiBNYWtlcyBzZW5zZS4gDQoNCj4gDQo+IEluIGdlbmVyYWwgaWYgdGhpbmdzIGhhdmUgYSBu
ZWVkIHRvIGdldCBhdCBwcmN0bCgpcyB2aWEgcHRyYWNlIHdlDQo+IHNob3VsZA0KPiBqdXN0IGZp
eCB0aGF0LCBhdCBsZWFzdCBmb3IgYXJtNjQgdGhlcmUncyB0aGluZ3MgbGlrZSB0aGUgdmVjdG9y
DQo+IGxlbmd0aHMNCj4gdGhhdCBhcmUgY3VycmVudGx5IGNvbnRyb2xsZWQgdmlhIHByY3RsKCks
IGJ1dCBpdCBzaG91bGRuJ3QgYmUgYQ0KPiBibG9ja2VyDQo+IGZvciB0aGUgbG9ja2luZyBzcGVj
aWZpY2FsbHkuDQoNCnB0cmFjZSBhcmNoX3ByY3RsKCkgaXMgYSBiaXQgb2RkLiBOb3QgYWxsIHZh
bHVlcyBvZiAnb3B0aW9uJyBhcmUNCnN1cHBvcnRlZCBiZWNhdXNlIHB0cmFjZSBhcmNoX3ByY3Rs
J3MgaGF2ZSB0byBvcGVyYXRlIGNyb3NzIHRhc2suIFNvbWUNCmhhdmUgZXh0cmEgY29kZSB0byBz
dXBwb3J0IGRvaW5nIHRoaXMsIGFuZCBzb21lIG9ubHkga25vdyBob3cgdG8NCm9wZXJhdGUgb24g
dGhlIGN1cnJlbnQgdGFzaywgc28gcmV0dXJuIGFuIGVycm9yIGluIHRoZSBwdHJhY2UgY2FzZS4N
Cg0KSSBndWVzcyBhIGJlbmVmaXQgd291bGQgYmUgdGhhdCB0aGVyZSBjb3VsZCBiZSBzb21lIGFy
Y2ggYWdub3N0aWMNCnB0cmFjZSB1c2Vyc3BhY2UgY29kZS4gQW5kIEknZCBhbHNvIGd1ZXNzIChy
ZWFsbHkgYSBndWVzcykgdGhhdCBtb3N0DQpwdHJhY2luZyBjb2RlIGhhcyBzb21lIGFyY2ggYXdh
cmVuZXNzIGFscmVhZHksIGJ1dCB0aGUgb3RoZXIgd2F5IGlzDQpwcm9iYWJseSBub24temVyby4g
U2FtZSBmb3Igc2hhZG93IHN0YWNrIGVuYWJsaW5nIGNvZGUuIFRoZW4gb24gdGhlDQprZXJuZWwg
c2lkZSB3ZSdkIGhhdmUgdG8gYWRkIGFuZCBzdXBwb3J0IGEgcHRyYWNlIHByY3RsKCkgc29sdXRp
b24uDQoNCklzIGl0IHdvcnRoIHRoZSBlZmZvcnQ/IEkgZG9uJ3QgaGF2ZSBhIHN0cm9uZyBvcGlu
aW9uLg0K

