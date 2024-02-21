Return-Path: <linux-fsdevel+bounces-12194-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B04185CCBF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 01:36:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 111B9283B35
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 00:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098481876;
	Wed, 21 Feb 2024 00:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kn5LviLb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51AF417D5;
	Wed, 21 Feb 2024 00:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708475760; cv=fail; b=H/5ZM6YFtdH05FuAIj5rk0rnd7TpkWpaU54w4spGP005aajmU6SKi+5qABPYM7t2qIYbTBdmR37efE+qAUtAjUVKyMPDzR08kNy6kHWXnysIMe54jklQukaSmus8SPFRs1Ic1eu5ufypfUI+gm1fRvZSSgvu6P1AOAMQCSTOz8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708475760; c=relaxed/simple;
	bh=yvWZeqeG6lK0nLAj7Gr2MxiS0y4W2vBZef9F41O1g7Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kHgkwrFnxvf7iLIR8GL/UrZ/96jkhJdoJbzdUlmrFIz6vBeqb2QP1vjtmSPuiqpVPccwgf2K2R+Ak3trIZcX1nnsYgLgW48G1HxeQzoKC2XNvz4mcS75V3ohoMgB0dOQeLahYZ2BWVcCjMK8XMkB86nQC8m0ALD1dK8uCnKvtgk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kn5LviLb; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708475759; x=1740011759;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=yvWZeqeG6lK0nLAj7Gr2MxiS0y4W2vBZef9F41O1g7Q=;
  b=Kn5LviLb4QaBEYZAAnpJp7ys7az4U7a21fDh/wEx+CDFr3vPlMkiUY4k
   ASKNqzWg6P56jsb6HTMk3tWDtG/rKCJY0NxElgnlcrUh30kFUNmF/us9K
   nqa0GRlU/lmAK4i6I5oD968Yk9lsMOG8lZHpxH5JO62fx4vfvptlQ422a
   84TwC+6DGhSFPjVgNuOTEpxQe+UCRhFtns0ph85bZZ+fG0g6LovnzdEwD
   qT7xRRs+RuQbmxBrPhx6C+yWpDZ5pQXRENbaSuMfgMM5/AEBbKLfhNDVk
   rt/POImh4xxXsps6AMdT8KT/wJAEvQWRkBP3oe+5kRJGiTg6al3Qi4SVt
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="14021124"
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="14021124"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 16:35:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="4897081"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Feb 2024 16:35:53 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 20 Feb 2024 16:35:52 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 20 Feb 2024 16:35:52 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 20 Feb 2024 16:35:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h0mKmwmPUgnfX/O79EbFgBmtdL/vzrsBPURnK3bQsitQ4UsEUhyCraOVpn0i3ubpOWMTPV5NVQ1c8g2VI4KfZGn5t1Ej94pBFUdJuejagYZhwZaREWlp6SPUIcHGvhBJmKTy+EniD5xtwlQ/u5kujm88yRFEhRkPwHq7QYw8T8wEYaTKEjFC+bTS8EASzp/wYu1B1jAg6yG81PnCJNVSALwAfQQD+NHrL+z3VDHLxI+zt/7qtNOAHqiFdSYoRKmrX6PJLo/7HdFyN8xvIXemqzB5LSbATnGdW4mi0FZKGVCGo8d4fOB6bsJnrSVtfnQhnU6A+VOUfiW/iTVPCx8VVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yvWZeqeG6lK0nLAj7Gr2MxiS0y4W2vBZef9F41O1g7Q=;
 b=Xp6CB3G6/q//DjL6G6jBpShJXwyYEWCdGujua1KGREd2yhJiGMZEklbSoE3IRTqf+ozG8H7ovFFncdmY/gZbYfAKV5unXf2uZjb81b8zUSvkE28xxbU2UNDju4aRu5NlVipRk3WWidnMS8MAOYfXktVsQGrgBaU7fB224hJr082DkZX0B/B8Zplr7mdn48XGDltqh6g1cvdumvfXiR89bIvIeCbVjRaFJ/7CZRozBcwvV/XRRLIyiWYLD7drfshqPj/gwPydlroCTkM1XS/AdqyX87yqzMJDD0FL9/S5Zb1OmK52B3onan+6qYK5e0kC9q23hEv4oQDT54f7l8IynA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by SJ2PR11MB7599.namprd11.prod.outlook.com (2603:10b6:a03:4c6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.32; Wed, 21 Feb
 2024 00:35:48 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::5d40:83fd:94ac:d409]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::5d40:83fd:94ac:d409%7]) with mapi id 15.20.7316.018; Wed, 21 Feb 2024
 00:35:48 +0000
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
Thread-Index: AQHaVpxQxL7eT1mQek6VcjPJOSVEZ7ETiLSAgAAiyYCAAASHgIAATE8AgAAGrQCAAAuagA==
Date: Wed, 21 Feb 2024 00:35:48 +0000
Message-ID: <a57d6c7eada4b9a7c35addbc8556f5b53a0c3e6f.camel@intel.com>
References: <20240203-arm64-gcs-v8-0-c9fec77673ef@kernel.org>
	 <22a53b78-10d7-4a5a-a01e-b2f3a8c22e94@app.fastmail.com>
	 <4c7bdf8fde9cc45174f10b9221fa58ffb450b755.camel@intel.com>
	 <20240220185714.GO4163@brightrain.aerifal.cx>
	 <9fc9c45ff6e14df80ad023e66ff7a978bd4ec91c.camel@intel.com>
	 <20240220235415.GP4163@brightrain.aerifal.cx>
In-Reply-To: <20240220235415.GP4163@brightrain.aerifal.cx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|SJ2PR11MB7599:EE_
x-ms-office365-filtering-correlation-id: 1ba1dca6-7226-485e-7ddf-08dc32750caf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: enetlF/TgaEsiVEVlFWaWMgyHeXLACasvQHg6vo4wXljGOw/7Q4/Y69zpiliGDMazrqK5/J7zGUVcLFb4NiNQ3s4xoh4WwZf3bPNJicHMqlZGQP/9qXNa+lA8O3fjfjTGWLhDBe+fMQSh0Jq1L79iblhefbPES/Buy4I8l92y/c4yEcisc2kpSTypryFumHSbyasFV2Uin8MTts01bRC+8G/EI03kS4WPJ9jT2YtRbzwbLbxJA2OqCQ/kkCw8NRwzwYHLF2MwsVC89PZavGKHhakt6SPPmPZIHtrjR5Z8WSCpC9pYOkCJxqlDHrA0XYOGIx8KuiRwxFsENHpIBZoThSvXKQkZUmbXR4KSTWt91wHIyPevZW2vPexhGBfrYOxKzW/bhkLQ/Z4lS4H0W7s0Me23uda6Ss3C8Xa6kqvDmeA7FPw6GmmvUT8MLNTUWYGQKkuQ29IKydpul20/NqZ7UViO7HPOewSYOwl7gJQYIyNfDrOJkr64dwxcTzGrtpOLw6rImlOvXZ5MBKrsi/qqpEnhvAbENQxUYBr/eHtzVcTRUymjXdNoTxC3AYEqFqPv7pUOrA7ZDf5JS27bcL02fw1XXOzj/wGSBsMnlsJ5XE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WjZSRFAvak92QlBsaGdXMkNjZEdYa0QzaTZsNDAzclZsbUV0bEZ1K2hvMFEv?=
 =?utf-8?B?ZjZ0SjhHdUU4RHJjeGt4UDZJbWRDcGFLNXA3R3dsODFDQkVmYWNxQ0JoRU82?=
 =?utf-8?B?YzhUZmwrbjdaMDdzVHZna2F6NFo3WlpWdnlCaWl5RktNckVWVnY0ZWJqZjZD?=
 =?utf-8?B?UGpkb21Kb3RWbkhZZnFBQjlYUkhON0V6aDdERENuODMwODV3ODRPOFp2L0Mv?=
 =?utf-8?B?U2p3NTZ0TUxWVVhMbFEybzY2bWdOYWdQOHlXbGNhNUI1ZStGbmRMNEFJRVo0?=
 =?utf-8?B?ZVo5SDU1djZWYWRXYkFDcC9MTTNEWUVSYi9YNHM1cGVuZ1AyTmNGUzJYMW9w?=
 =?utf-8?B?VjhZQVB2eis1R3dVeHdKVXFCQW9VYnprUnlpbXdic1AvdHhVRkcwRzAwQ2gz?=
 =?utf-8?B?NlNibEVEZ1VueWRuYmtIL3lTZVcvSGIyLzZqN1poZWJwb2xZRWZBaUtRa3o2?=
 =?utf-8?B?Y05uMG53d0paN0hEV210YkphN0d5N1h6VGc4Q09VdjRjRXpRRlcwZ2gzMHBY?=
 =?utf-8?B?cWVJRTk0RE5PYjBReENFclZnakxjR01US2tsOXpEeHZ1bVQvNEJ3b0s0NDBX?=
 =?utf-8?B?UUZRRnA0anB0bUdNZnFvcFp5OUtMVEJlTXk0ZTZRMTR6K3FDRm05SWVSc2JI?=
 =?utf-8?B?SHgwTU1Wc1JkdXhlQ041ZUJMVXY4NGhONUtsN0ZCODhCbHFBK2tlTXJMRE1k?=
 =?utf-8?B?VnFVbExXTnBka1pKcmh6M3JMakd0NDg0MnNuZWV1bXdQdmhJaG0rcWRYK3dk?=
 =?utf-8?B?eUFSOG8rR1ZCeUZhdnBVUDRYWEZtR1haUUdlMGx2RjJkVVdSZmtINCtWK0F2?=
 =?utf-8?B?eU1kdnNyNzdMVVVDVTdYeVd3Tmc3SWZiL3pYY09iWTVWS00vNE81NVp6Zjk3?=
 =?utf-8?B?OHFkOGhRa2k4YVYxdEdpTmJYQmkxZzYwektYc0cyUXJsWkNHNHJib0lKZml4?=
 =?utf-8?B?ZVVjN1Ztd054Sko5NTl5THdJck53YjdLM2dvOGNYSHRhamNpL3l3RzZTaUFO?=
 =?utf-8?B?OVJ0dEVLY2wrMlJvWFJVZmJ1WTg0ZVFHNEJDME8wcW40aThGUm4rRzFUakpu?=
 =?utf-8?B?Y2p1VE9Ic1ltSlN3SUhhSUpseFpxNWIzUGcvR0NUSTNzK0NYT0RyVkwrRm5r?=
 =?utf-8?B?RVJyY0VDSE5nVTVwa0UwSXI0Qkw3QUI2WkJ0a3RSOHFWQWNvZHdqU3RZYkJE?=
 =?utf-8?B?V3FYSnBxclN6Z3hsbWZLZ2QxdEZUUXJMekRQN2ZVQkpzRExYOGJEZE1WSDhh?=
 =?utf-8?B?d1pMRDZXendYY3kzN3hlQTBjSTB2YTVmaXJPajBCdlhiVUZXN3FTN05PbUJu?=
 =?utf-8?B?V3NuMDU0eGh1czZUZWRZbVZ1RFV6NUdUd3Z5d3NkbjRsNDc0WWxEd2l3VTJR?=
 =?utf-8?B?bHFobTR1NHJtcCsyTGFaS2g3dklPdzFvdHI5M01SdDYwTEcvM29DZjF5OUxW?=
 =?utf-8?B?ZzRhMmRMSCtOWitwZ1JXMWN4RGFid1ZZdEtyWHcvdE03M3E0Zk1rYjMxdVgz?=
 =?utf-8?B?TldKY0V1OUphWGxDSUhUaFR0VEJ4Y1dkQ0ltd3hUdzIxREp0Q1B2K0djcnYw?=
 =?utf-8?B?MkUrdjBTUWgvSVdiU3FERENFTDB3ZUwxeUxIZ0xhbFRBTWFXbjhwZ3hsUGtq?=
 =?utf-8?B?UFBrRVRHekhSdlNsMWwydnVMblNTdlhUSFJjWFh5K0pic3RWVStjK2FBRVFC?=
 =?utf-8?B?V0picjEySktGbUYrOUNxZWpFc1ByR25aVEx2blhKNUlvdjlnUU1MbzdVSEJ0?=
 =?utf-8?B?S3NrMWozY296RC8za0pGL0pLdUR0eDZVbWVFRVpPSWFaV0dYMjA3VDVTVGJk?=
 =?utf-8?B?L0hBdjhvT0VmKzBVcFNoTTlkWlNlSEFxcWF0bDJDMEFUWFpEc213d3JSRUtE?=
 =?utf-8?B?WFJ0SUsvUlhwTTZzL0xZeHBFSkZrVDNHNUR6TG4vdWUzbHBQc3VST0FIc3Ev?=
 =?utf-8?B?UDNQWUdkd2prdWhLMGhWRzN2Wm5acHdyYk85RmJiUUFDMm1rQWV3cDg2M3My?=
 =?utf-8?B?OUlvSWNQcWVuSE9CNWd3MWdtd3FLV1BqYUJabCtPSmFZR0RnTC9aSGwveFhk?=
 =?utf-8?B?MVlUbm85WGx0OUlhZm1OSWtSNWxjdjZFUWdrUlc5eTRITWRKYmdMb3c1TEIz?=
 =?utf-8?B?ekpFQnE2WVlDTGNYRm1ocVhaYjhuY2FZYlFTSFNJdDg5OVBHNURYOTZDQU9q?=
 =?utf-8?B?cnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DFA76843B4E31A499F2C7E5504D86BDF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ba1dca6-7226-485e-7ddf-08dc32750caf
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2024 00:35:48.4706
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: or+tl3kPuhb2TIVgVOe3ReyVSd3yJKtA0zNA4QTaOwrQl3i/JMOf0LNN1YnQqC9ayTGWOj1xr6BMv9qiOzkSvLo3rL/Kg3PypjZT7YJhwqI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7599
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI0LTAyLTIwIGF0IDE4OjU0IC0wNTAwLCBkYWxpYXNAbGliYy5vcmcgd3JvdGU6
DQo+IE9uIFR1ZSwgRmViIDIwLCAyMDI0IGF0IDExOjMwOjIyUE0gKzAwMDAsIEVkZ2Vjb21iZSwg
UmljayBQIHdyb3RlOg0KPiA+IE9uIFR1ZSwgMjAyNC0wMi0yMCBhdCAxMzo1NyAtMDUwMCwgUmlj
aCBGZWxrZXIgd3JvdGU6DQo+ID4gPiBPbiBUdWUsIEZlYiAyMCwgMjAyNCBhdCAwNjo0MTowNVBN
ICswMDAwLCBFZGdlY29tYmUsIFJpY2sgUA0KPiA+ID4gd3JvdGU6DQo+ID4gPiA+IEhtbSwgY291
bGQgdGhlIHNoYWRvdyBzdGFjayB1bmRlcmZsb3cgb250byB0aGUgcmVhbCBzdGFjayB0aGVuPw0K
PiA+ID4gPiBOb3QNCj4gPiA+ID4gc3VyZSBob3cgYmFkIHRoYXQgaXMuIElOQ1NTUCAoaW5jcmVt
ZW50aW5nIHRoZSBTU1AgcmVnaXN0ZXIgb24NCj4gPiA+ID4geDg2KQ0KPiA+ID4gPiBsb29wcyBh
cmUgbm90IHJhcmUgc28gaXQgc2VlbXMgbGlrZSBzb21ldGhpbmcgdGhhdCBjb3VsZA0KPiA+ID4g
PiBoYXBwZW4uDQo+ID4gPiANCj4gPiA+IFNoYWRvdyBzdGFjayB1bmRlcmZsb3cgc2hvdWxkIGZh
dWx0IG9uIGF0dGVtcHQgdG8gYWNjZXNzDQo+ID4gPiBub24tc2hhZG93LXN0YWNrIG1lbW9yeSBh
cyBzaGFkb3ctc3RhY2ssIG5vPw0KPiA+IA0KPiA+IE1heWJlIEknbSBtaXN1bmRlcnN0YW5kaW5n
LiBJIHRob3VnaHQgdGhlIHByb3Bvc2FsIGluY2x1ZGVkDQo+ID4gYWxsb3dpbmcNCj4gPiBzaGFk
b3cgc3RhY2sgYWNjZXNzIHRvIGNvbnZlcnQgbm9ybWFsIGFkZHJlc3MgcmFuZ2VzIHRvIHNoYWRv
dw0KPiA+IHN0YWNrLA0KPiA+IGFuZCBub3JtYWwgd3JpdGVzIHRvIGNvbnZlcnQgc2hhZG93IHN0
YWNrIHRvIG5vcm1hbC4NCj4gDQo+IEFzIEkgdW5kZXJzdG9vZCB0aGUgb3JpZ2luYWwgZGlzY3Vz
c2lvbiBvZiB0aGUgcHJvcG9zYWwgb24gSVJDLCBpdA0KPiB3YXMNCj4gb25seSBvbmUtd2F5IChm
cm9tIHNoYWRvdyB0byBub3JtYWwpLiBVbmxlc3MgSSdtIG1pc3Npbmcgc29tZXRoaW5nLA0KPiBt
YWtpbmcgaXQgb25lLXdheSBpcyBuZWNlc3NhcnkgdG8gY2F0Y2ggc2l0dWF0aW9ucyB3aGVyZSB0
aGUgc2hhZG93DQo+IHN0YWNrIHdvdWxkIGJlY29tZSBjb21wcm9taXNlZC4NCg0KVGhlIG9yaWdp
bmFsIHBvc3QgaGVyZToNCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMjJhNTNiNzgtMTBk
Ny00YTVhLWEwMWUtYjJmM2E4YzIyZTk0QGFwcC5mYXN0bWFpbC5jb20vDQoNCi4uLmhhczoNCiJT
aGFkb3cgc3RhY2sgZmF1bHRzIG9uIG5vbi1zaGFkb3cgc3RhY2sgcGFnZXMsIGlmIGZsZXhpYmxl
IHNoYWRvdw0Kc3RhY2sgaGFuZGxpbmcgaXMgaW4gZWZmZWN0LCBjYXVzZSB0aGUgYWZmZWN0ZWQg
cGFnZSB0byBiZWNvbWUgYSBzaGFkb3cNCnN0YWNrIHBhZ2UuICBXaGVuIHRoaXMgaGFwcGVucywg
dGhlIHBhZ2UgZmlsbGVkIHdpdGggaW52YWxpZCBhZGRyZXNzDQp0b2tlbnMuIg0KDQouLi5hbmQ6
DQoiRmF1bHRzIGZyb20gbm9uLXNoYWRvdy1zdGFjayBhY2Nlc3NlcyB0byBhIHNoYWRvdy1zdGFj
ayBwYWdlIHdoaWNoIHdhcw0KY3JlYXRlZCBieSB0aGUgcHJldmlvdXMgcGFyYWdyYXBoIHdpbGwg
Y2F1c2UgdGhlIHBhZ2UgdG8gcmV2ZXJ0IHRvIG5vbi0NCnNoYWRvdy1zdGFjayB1c2FnZSwgd2l0
aCBvciB3aXRob3V0IGNsZWFyaW5nLiINCg0KSSBzZWUgU3RlZmFuIGhhcyBjbGFyaWZpZWQgaW4g
YW5vdGhlciByZXNwb25zZS4gU28gSSdsbCBnbyB0cnkgdG8NCmZpZ3VyZSBpdCBvdXQuDQoNCj4g
DQo+ID4gPiA+IFNoYWRvdyBzdGFja3MgY3VycmVudGx5IGhhdmUgYXV0b21hdGljIGd1YXJkIGdh
cHMgdG8gdHJ5IHRvDQo+ID4gPiA+IHByZXZlbnQNCj4gPiA+ID4gb25lDQo+ID4gPiA+IHRocmVh
ZCBmcm9tIG92ZXJmbG93aW5nIG9udG8gYW5vdGhlciB0aHJlYWQncyBzaGFkb3cgc3RhY2suDQo+
ID4gPiA+IFRoaXMNCj4gPiA+ID4gd291bGQNCj4gPiA+ID4gc29tZXdoYXQgb3BlbnMgdGhhdCB1
cCwgYXMgdGhlIHN0YWNrIGd1YXJkIGdhcHMgYXJlIHVzdWFsbHkNCj4gPiA+ID4gbWFpbnRhaW5l
ZA0KPiA+ID4gPiBieSB1c2Vyc3BhY2UgZm9yIG5ldyB0aHJlYWRzLiBJdCB3b3VsZCBoYXZlIHRv
IGJlIHRob3VnaHQNCj4gPiA+ID4gdGhyb3VnaA0KPiA+ID4gPiBpZg0KPiA+ID4gPiB0aGVzZSBj
b3VsZCBzdGlsbCBiZSBlbmZvcmNlZCB3aXRoIGNoZWNraW5nIGF0IGFkZGl0aW9uYWwNCj4gPiA+
ID4gc3BvdHMuDQo+ID4gPiANCj4gPiA+IEkgd291bGQgdGhpbmsgdGhlIGV4aXN0aW5nIGd1YXJk
IHBhZ2VzIHdvdWxkIGFscmVhZHkgZG8gdGhhdCBpZiBhDQo+ID4gPiB0aHJlYWQncyBzaGFkb3cg
c3RhY2sgaXMgY29udGlndW91cyB3aXRoIGl0cyBvd24gZGF0YSBzdGFjay4NCj4gPiANCj4gPiBU
aGUgZGlmZmVyZW5jZSBpcyB0aGF0IHRoZSBrZXJuZWwgcHJvdmlkZXMgdGhlIGd1YXJkIGdhcHMs
IHdoZXJlDQo+ID4gdGhpcw0KPiA+IHdvdWxkIHJlbHkgb24gdXNlcnNwYWNlIHRvIGRvIGl0LiBJ
dCBpcyBub3QgYSBzaG93c3RvcHBlciBlaXRoZXIuDQo+ID4gDQo+ID4gSSB0aGluayBteSBiaWdn
ZXN0IHF1ZXN0aW9uIG9uIHRoaXMgaXMgaG93IGRvZXMgaXQgY2hhbmdlIHRoZQ0KPiA+IGNhcGFi
aWxpdHkgZm9yIHR3byB0aHJlYWRzIHRvIHNoYXJlIGEgc2hhZG93IHN0YWNrLiBJdCBtaWdodA0K
PiA+IHJlcXVpcmUNCj4gPiBzb21lIHNwZWNpYWwgcnVsZXMgYXJvdW5kIHRoZSBzeXNjYWxsIHRo
YXQgd3JpdGVzIHJlc3RvcmUgdG9rZW5zLg0KPiA+IFNvDQo+ID4gSSdtIG5vdCBzdXJlLiBJdCBw
cm9iYWJseSBuZWVkcyBhIFBPQy4NCj4gDQo+IFdoeSB3b3VsZCB0aGV5IGJlIHNoYXJpbmcgYSBz
aGFkb3cgc3RhY2s/DQoNClRoZSBndWFyZCBnYXAgd2FzIGludHJvZHVjZWQgb3JpZ2luYWxseSBi
YXNlZCBvbiBhIHN1Z2dlc3Rpb24gdGhhdA0Kb3ZlcmZsb3dpbmcgYSBzaGFkb3cgc3RhY2sgb250
byBhbiBhZGphY2VudCBzaGFkb3cgc3RhY2sgY291bGQgY2F1c2UNCmNvcnJ1cHRpb24gdGhhdCBj
b3VsZCBiZSB1c2VkIGJ5IGFuIGF0dGFja2VyIHRvIHdvcmsgYXJvdW5kIHRoZQ0KcHJvdGVjdGlv
bi4gVGhlcmUgd2Fzbid0IGFueSBjb25jcmV0ZSBkZW1vbnN0cmF0ZWQgYXR0YWNrcyBvcg0Kc3Vn
Z2VzdGlvbiB0aGF0IGFsbCB0aGUgcHJvdGVjdGlvbiB3YXMgbW9vdC4NCg0KQnV0IHdoZW4gd2Ug
dGFsayBhYm91dCBjYXBhYmlsaXRpZXMgZm9yIGNvbnZlcnRpbmcgbWVtb3J5IHRvIHNoYWRvdw0K
c3RhY2sgd2l0aCBzaW1wbGUgbWVtb3J5IGFjY2Vzc2VzLCBhbmQgc3lzY2FsbHMgdGhhdCBjYW4g
d3JpdGUgcmVzdG9yZQ0KdG9rZW4gdG8gc2hhZG93IHN0YWNrcywgaXQncyBub3QgaW1tZWRpYXRl
bHkgY2xlYXIgdG8gbWUgdGhhdCBpdA0Kd291bGRuJ3Qgb3BlbiB1cCBzb21ldGhpbmcgbGlrZSB0
aGF0LiBMaWtlIGlmIHR3byByZXN0b3JlIHRva2VucyB3ZXJlDQp3cml0dGVuIHRvIGEgc2hhZG93
IHN0YWNrLCBvciB0d28gc2hhZG93IHN0YWNrcyB3ZXJlIGFkamFjZW50IHdpdGgNCm5vcm1hbCBt
ZW1vcnkgYmV0d2VlbiB0aGVtIHRoYXQgbGF0ZXIgZ290IGNvbnZlcnRlZCB0byBzaGFkb3cgc3Rh
Y2suDQpUaG9zZSBzb3J0cyBvZiBzY2VuYXJpb3MsIGJ1dCBJIHdvbid0IGxlYW4gb24gdGhvc2Ug
c3BlY2lmaWMgZXhhbXBsZXMuDQpTb3JyeSBmb3IgYmVpbmcgaGFuZCB3YXZ5LiBJdCdzIGp1c3Qg
d2hlcmUgSSdtIGF0LCBhdCB0aGlzIHBvaW50Lg0KDQo+IA0KPiA+ID4gRnJvbSB0aGUgbXVzbCBz
aWRlLCBJIGhhdmUgYWx3YXlzIGxvb2tlZCBhdCB0aGUgZW50aXJlbHkgb2YNCj4gPiA+IHNoYWRv
dw0KPiA+ID4gc3RhY2sgc3R1ZmYgd2l0aCB2ZXJ5IGhlYXZ5IHNrZXB0aWNpc20sIGFuZCBhbnl0
aGluZyB0aGF0IGJyZWFrcw0KPiA+ID4gZXhpc3RpbmcgaW50ZXJmYWNlIGNvbnRyYWN0cywgaW50
cm9kdWNlZCBwbGFjZXMgd2hlcmUgYXBwcyBjYW4NCj4gPiA+IGdldA0KPiA+ID4gYXV0by1raWxs
ZWQgYmVjYXVzZSBhIGxhdGUgcmVzb3VyY2UgYWxsb2NhdGlvbiBmYWlscywgb3IgcmVxdWlyZXMN
Cj4gPiA+IGFwcGxpY2F0aW9ucyB0byBjb2RlIGFyb3VuZCB0aGUgZXhpc3RlbmNlIG9mIHNvbWV0
aGluZyB0aGF0DQo+ID4gPiBzaG91bGQgYmUNCj4gPiA+IGFuIGltcGxlbWVudGF0aW9uIGRldGFp
bCwgaXMgYSBub24tc3RhcnRlci4gVG8gZXZlbiBjb25zaWRlcg0KPiA+ID4gc2hhZG93DQo+ID4g
PiBzdGFjayBzdXBwb3J0LCBpdCBtdXN0IHRydWVseSBiZSBmdWxseSBub24tYnJlYWtpbmcuDQo+
ID4gDQo+ID4gVGhlIG1hbnVhbCBhc3NlbWJseSBzdGFjayBzd2l0Y2hpbmcgYW5kIEpJVCBjb2Rl
IGluIHRoZSBhcHBzIG5lZWRzDQo+ID4gdG8NCj4gPiBiZSB1cGRhdGVkLiBJIGRvbid0IHRoaW5r
IHRoZXJlIGlzIGEgd2F5IGFyb3VuZCBpdC4NCj4gDQo+IEluZGVlZCwgSSdtIG5vdCB0YWxraW5n
IGFib3V0IHByb2dyYW1zIHdpdGggSklUL21hbnVhbCBzdGFjay0NCj4gc3dpdGNoaW5nDQo+IGFz
bSwganVzdCBhbnl0aGluZyB1c2luZyBleGlzdGluZyBBUElzIGZvciBjb250cm9sIG9mIHN0YWNr
IC0tDQo+IHB0aHJlYWRfc2V0c3RhY2ssIG1ha2Vjb250ZXh0LCBzaWdhbHRzdGFjaywgZXRjLg0K
DQpUaGVuIEkgdGhpbmsgV1JTUyBtaWdodCBmaXQgeW91ciByZXF1aXJlbWVudHMgYmV0dGVyIHRo
YW4gd2hhdCBnbGliYw0KZGlkLiBJdCB3YXMgY29uc2lkZXJlZCBhIHJlZHVjZWQgc2VjdXJpdHkg
bW9kZSB0aGF0IG1hZGUgbGliYydzIGpvYg0KbXVjaCBlYXNpZXIgYW5kIGhhZCBiZXR0ZXIgY29t
cGF0aWJpbGl0eSwgYnV0IHRoZSBsYXN0IGRpc2N1c3Npb24gd2FzDQp0byB0cnkgdG8gZG8gaXQg
d2l0aG91dCBXUlNTLg0KDQo+IA0KPiA+IEkgYWdyZWUgdGhvdWdoIHRoYXQgdGhlIGxhdGUgYWxs
b2NhdGlvbiBmYWlsdXJlcyBhcmUgbm90IGdyZWF0Lg0KPiA+IE1hcmsgaXMNCj4gPiB3b3JraW5n
IG9uIGNsb25lMyBzdXBwb3J0IHdoaWNoIHNob3VsZCBhbGxvdyBtb3ZpbmcgdGhlIHNoYWRvdw0K
PiA+IHN0YWNrDQo+ID4gYWxsb2NhdGlvbiB0byBoYXBwZW4gaW4gdXNlcnNwYWNlIHdpdGggdGhl
IG5vcm1hbCBzdGFjay4gRXZlbiBmb3INCj4gPiByaXNjdg0KPiA+IHRob3VnaCwgZG9lc24ndCBp
dCBuZWVkIHRvIHVwZGF0ZSBhIG5ldyByZWdpc3RlciBpbiBzdGFjaw0KPiA+IHN3aXRjaGluZz8N
Cj4gDQo+IElmIGNsb25lIGlzIGNhbGxlZCB3aXRoIHNpZ25hbHMgbWFza2VkLCBpdCdzIHByb2Jh
Ymx5IG5vdCBuZWNlc3NhcnkNCj4gZm9yIHRoZSBrZXJuZWwgdG8gc2V0IHRoZSBzaGFkb3cgc3Rh
Y2sgcmVnaXN0ZXIgYXMgcGFydCBvZiBjbG9uZTMuDQoNClNvIHlvdSB3b3VsZCB3YW50IGEgbW9k
ZSBvZiBjbG9uZTMgdGhhdCBiYXNpY2FsbHkgbGVhdmVzIHRoZSBzaGFkb3cNCnN0YWNrIGJpdHMg
YWxvbmU/IE1hcmsgd2FzIGRyaXZpbmcgdGhhdCBlZmZvcnQsIGJ1dCBpdCBkb2Vzbid0IHNlZW0N
CmhvcnJpYmxlIHRvIG1lIG9uIGZpcnN0IGltcHJlc3Npb24uIElmIGl0IHdvdWxkIG9wZW4gdXAg
dGhlIHBvc3NpYmlsaXR5DQpvZiBtdXNsIHN1cHBvcnQuDQoNCj4gDQo+ID4gQlRXLCB4ODYgc2hh
ZG93IHN0YWNrIGhhcyBhIG1vZGUgd2hlcmUgdGhlIHNoYWRvdyBzdGFjayBpcyB3cml0YWJsZQ0K
PiA+IHdpdGggYSBzcGVjaWFsIGluc3RydWN0aW9uIChXUlNTKS4gSXQgZW5hYmxlcyB0aGUgU1NQ
IHRvIGJlIHNldA0KPiA+IGFyYml0cmFyaWx5IGJ5IHdyaXRpbmcgcmVzdG9yZSB0b2tlbnMuIFdl
IGRpc2N1c3NlZCB0aGlzIGFzIGFuDQo+ID4gb3B0aW9uDQo+ID4gdG8gbWFrZSB0aGUgZXhpc3Rp
bmcgbG9uZ2ptcCgpIGFuZCBzaWduYWwgc3R1ZmYgd29yayBtb3JlDQo+ID4gdHJhbnNwYXJlbnRs
eQ0KPiA+IGZvciBnbGliYy4NCj4gPiANCj4gPiANCj4gPiANCj4gPiBCVFcsIHdoZW4gSSB0YWxr
IGFib3V0ICJub3Qgc3VwcG9ydGluZyIgSSBkb24ndCBtZWFuIHRoZSBhcHAgc2hvdWxkDQo+ID4g
Y3Jhc2guIEkgbWVhbiBpdCBzaG91bGQgaW5zdGVhZCBydW4gbm9ybWFsbHksIGp1c3Qgd2l0aG91
dCBzaGFkb3cNCj4gPiBzdGFjaw0KPiA+IGVuYWJsZWQuIE5vdCBzdXJlIGlmIHRoYXQgd2FzIGNs
ZWFyLiBTaW5jZSBzaGFkb3cgc3RhY2sgaXMgbm90DQo+ID4gZXNzZW50aWFsIGZvciBhbiBhcHBs
aWNhdGlvbiB0byBmdW5jdGlvbiwgaXQgaXMgb25seSBzZWN1cml0eQ0KPiA+IGhhcmRlbmluZw0K
PiA+IG9uIHRvcC4NCj4gPiANCj4gPiBBbHRob3VnaCBkZXRlcm1pbmluZyBpZiBhbiBhcHBsaWNh
dGlvbiBzdXBwb3J0cyBzaGFkb3cgc3RhY2sgaGFzDQo+ID4gdHVybmVkDQo+ID4gb3V0IHRvIGJl
IGRpZmZpY3VsdCBpbiBwcmFjdGljZS4gSGFuZGxpbmcgZGxvcGVuKCkgaXMgZXNwZWNpYWxseQ0K
PiA+IGhhcmQuDQo+IA0KPiBPbmUgcmVhc29uYWJsZSB0aGluZyB0byBkbywgdGhhdCBtaWdodCBi
ZSBwcmVmZXJhYmxlIHRvDQo+IG92ZXJlbmdpbmVlcmVkDQo+IHNvbHV0aW9ucywgaXMgdG8gZGlz
YWJsZSBzaGFkb3ctc3RhY2sgcHJvY2Vzcy13aWRlIGlmIGFuIGludGVyZmFjZQ0KPiBpbmNvbXBh
dGlibGUgd2l0aCBpdCBpcyB1c2VkIChzaWdhbHRzdGFjaywgcHRocmVhZF9jcmVhdGUgd2l0aCBh
bg0KPiBhdHRyaWJ1dGUgc2V0dXAgdXNpbmcgcHRocmVhZF9hdHRyX3NldHN0YWNrLCBtYWtlY29u
dGV4dCwgZXRjLiksIGFzDQo+IHdlbGwgYXMgaWYgYW4gaW5jb21wYXRpYmxlIGxpYnJhcnkgaXMg
aXMgZGxvcGVuZWQuDQoNCkkgdGhpbmsgaXQgd291bGQgYmUgYW4gaW50ZXJlc3RpbmcgYXBwcm9h
Y2ggdG8gZGV0ZXJtaW5pbmcNCmNvbXBhdGliaWxpdHkuwqBPbiB4ODYgdGhlcmUgaGFzIGJlZW4g
Y2FzZXMgb2YgYmluYXJpZXMgZ2V0dGluZw0KbWlzbWFya2VkIGFzIHN1cHBvcnRpbmcgc2hhZG93
IHN0YWNrLiBTbyBhbiBhdXRvbWF0ZWQgd2F5IG9mIGZpbHRlcmluZw0Kc29tZSBvZiB0aG9zZSBv
dXQgd291bGQgYmUgdmVyeSB1c2VmdWwgSSB0aGluay4gSSBndWVzcyB0aGUgZHluYW1pYw0KbGlu
a2VyIGNvdWxkIGRldGVybWluZSB0aGlzIGJhc2VkIG9uIHNvbWUgbGlzdCBvZiBmdW5jdGlvbnM/
DQoNClRoZSBkbG9wZW4oKSBiaXQgZ2V0cyBjb21wbGljYXRlZCB0aG91Z2guIFlvdSBuZWVkIHRv
IGRpc2FibGUgc2hhZG93DQpzdGFjayBmb3IgYWxsIHRocmVhZHMsIHdoaWNoIHByZXN1bWFibHkg
dGhlIGtlcm5lbCBjb3VsZCBiZSBjb2F4ZWQgaW50bw0KZG9pbmcuIEJ1dCB0aG9zZSB0aHJlYWRz
IG1pZ2h0IGJlIHVzaW5nIHNoYWRvdyBzdGFjayBpbnN0cnVjdGlvbnMNCihJTkNTU1AsIFJTVE9S
U1NQLCBldGMpLiBUaGVzZSBhcmUgYSBjb2xsZWN0aW9uIG9mIGluc3RydWN0aW9ucyB0aGF0DQph
bGxvdyBsaW1pdGVkIGNvbnRyb2wgb2YgdGhlIFNTUC4gV2hlbiBzaGFkb3cgc3RhY2sgZ2V0cyBk
aXNhYmxlZCwNCnRoZXNlIHN1ZGRlbmx5IHR1cm4gaW50byAjVUQgZ2VuZXJhdGluZyBpbnN0cnVj
dGlvbnMuIFNvIGFueSBvdGhlcg0KdGhyZWFkcyBleGVjdXRpbmcgdGhvc2UgaW5zdHJ1Y3Rpb25z
IHdoZW4gc2hhZG93IHN0YWNrIGdvdCBkaXNhYmxlZA0Kd291bGQgYmUgaW4gZm9yIGEgbmFzdHkg
c3VycHJpc2UuDQoNCkdsaWJjJ3MgcGVybWlzc2l2ZSBtb2RlICh0aGF0IGRpc2FibGVzIHNoYWRv
dyBzdGFjayB3aGVuIGRsb3BlbigpaW5nIGENCkRTTyB0aGF0IGRvZXNuJ3Qgc3VwcG9ydCBzaGFk
b3cgc3RhY2spIGlzIHF1aXRlIGxpbWl0ZWQgYmVjYXVzZSBvZg0KdGhpcy4gVGhlcmUgd2FzIGEg
UE9DIGZvciB3b3JraW5nIGFyb3VuZCBpdCwgYnV0IEknbGwgc3RvcCB0aGVyZSBmb3INCm5vdywg
dG8gbm90IHNwYW0geW91IHdpdGggdGhlIGRldGFpbHMuIEknbSBub3Qgc3VyZSBvZiBhcm0gYW5k
IHJpc2Mtdg0KZGV0YWlscyBvbiB0aGlzIHNwZWNpZmljIGNvcm5lciwgYnV0IGZvciB4ODYuDQoN
Cj4gIFRoaXMgaXMgbXVjaCBtb3JlDQo+IGFjY2VwdGFibGUgdGhhbiBjb250aW51aW5nIHRvIHJ1
biB3aXRoIHNoYWRvdyBzdGFja3MgbWFuYWdlZCBzbG9wcGlseQ0KPiBieSB0aGUga2VybmVsIGFu
ZCBhc3luYyBraWxsaW5nIHRoZSBwcm9jZXNzIG9uIE9PTSwgYW5kIGlzIHByb2JhYmx5DQo+ICpt
b3JlIGNvbXBhdGlibGUqIHdpdGggYXBwcyB0aGFuIGNoYW5naW5nIHRoZSBtaW5pbXVtIHN0YWNr
IHNpemUNCj4gcmVxdWlyZW1lbnRzIG91dCBmcm9tIHVuZGVyIHRoZW0uDQoNClllcC4NCg0KPiAN
Cj4gVGhlIHBsYWNlIHdoZXJlIGl0J3MgcmVhbGx5IG5lZWRlZCB0byBiZSBhYmxlIHRvIGFsbG9j
YXRlIHRoZSBzaGFkb3cNCj4gc3RhY2sgc3luY2hyb25vdXNseSB1bmRlciB1c2Vyc3BhY2UgY29u
dHJvbCwgaW4gb3JkZXIgdG8gaGFyZGVuDQo+IG5vcm1hbA0KPiBhcHBsaWNhdGlvbnMgdGhhdCBh
cmVuJ3QgZG9pbmcgZnVubnkgdGhpbmdzLCBpcyBpbiBwdGhyZWFkX2NyZWF0ZQ0KPiB3aXRob3V0
IGEgY2FsbGVyLXByb3ZpZGVkIHN0YWNrLg0KDQpZZWEgbW9zdCBhcHBzIGRvbid0IGRvIGFueXRo
aW5nIHRvbyB0cmlja3kuIE1vc3RseSBzaGFkb3cgc3RhY2sgImp1c3QNCndvcmtzIi4gQnV0IGl0
J3Mgbm8gZXhjdXNlIHRvIGp1c3QgY3Jhc2ggZm9yIHRoZSBvdGhlcnMuDQoNCg==

