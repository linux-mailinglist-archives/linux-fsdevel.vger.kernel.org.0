Return-Path: <linux-fsdevel+bounces-12207-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E0AD85CF45
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 05:18:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6237284499
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 04:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A9739861;
	Wed, 21 Feb 2024 04:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kn3PvkVa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A96D38FA3;
	Wed, 21 Feb 2024 04:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708489094; cv=fail; b=CWdhk4W7OQJ2EkQhDdnUPkNC+5qXm3ThhCa5nw15QgzLk+g+h6zjy+bl9UTz5PabGeTPUJBgQU6dnFnK4oCi5zurw5XjAoI5n5mTjulKiwZ5M0vXn4hXvNmwhqjBBHC3ozbJ9Rqbe2aI3gLJvRzHzBbnvoOZCEV29c/1AZB5mqU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708489094; c=relaxed/simple;
	bh=AtrkrqX68O98zyA7Neh9JSYjurH/H6HubiPaLloNeIQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Gxi0fauJ4In3wE5TK9XSORxrGYbEZLzZVVlbsjX2t9JBBQHxXMRvlwodjqVFbZ955CiC5ZwGa3Ik0D+zecQciIJZrDbtfnpU5+C1V/JF2bjfPtBSo72LYJDet1m2j5R+8N61mHDxf0qbWlJXbMF/qIF7XmC+Fk/rsy7zUOML7BM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kn3PvkVa; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708489092; x=1740025092;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=AtrkrqX68O98zyA7Neh9JSYjurH/H6HubiPaLloNeIQ=;
  b=Kn3PvkVaj7YAwIncaTXoh6iQ0XCEm6+T8JLDlzaLLlBhTOH44BYJQlzH
   zMShdj1GUSiEnHeqQKNQOvM6006GUxio2I8lA9cs8O30PX85V+y5mw0+k
   NBbeEy7FGL0lac1q4AFTzViBp32lF9WBEWvyYEoAj0khuFbqprecqeBH3
   UKTdYX6KvHgiJgiY0SS2FxEdMAFIFyTicClPxNeNWRSBrHDm9Yn+ms3x3
   fgKW7nzfULyUSaXgNVj79JkLaSgRHEpkrDptLh8o5NoZWxwHCgvj2RXxr
   rlZrte0NRUH/aIxmCBSc6DvUfCIyo/vzCnV+QPBlMo3IZGv7Z2IVci49p
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="2500437"
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="2500437"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 20:18:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="5349897"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Feb 2024 20:18:10 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 20 Feb 2024 20:18:09 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 20 Feb 2024 20:18:09 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 20 Feb 2024 20:18:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UBwly99FpLrp9921GJxXMItPIMZyHLf5ip5y76LtpTAFscMY3j4fazip+CZPXSpL3lL9pcUGBav2Dasv55yumIjqHZwPm/i0uUcUj8QvQk8Qc/wtFq9AoPliYmcdioOq9E+JCnyhIbus6cEtDnBnlgZpUn1PPSjMFrcPHHqo2sY7WzOMcMs1rcg9XkmXX9FhVukS2n+COmGSrHx4bL3gN2oqGlY7+FJROqPWonFVj3QdlHzoWt27B+QtWvkemWuYI+gTWX0Pe3B5JraZTz4uZaSlNKESu7OQS5F1mk7+jgtS0msecHP8nVO+X6CiwgWVHkygCcM8FM4mRXVc6VLPAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AtrkrqX68O98zyA7Neh9JSYjurH/H6HubiPaLloNeIQ=;
 b=jTni16n0TKZp+ZbwfsOHsncs7Ow4iuVTJfwgnNu3u7J28lawPGVDEDJ9YhegRSmgTMxxlFoukHcwZpa4ApY+JKlGnuab24a5V5oAfRAVj43VJ3mqBEwls5dpkTYx4WB8yDnrDrfskYL4rxX3WWAsGZOAAzwK5WMfEk+a8YzzI8bN1PExW3ByB26x3tG1LPzgltv/PHDdrAv6fid75NZ6gaGbXb1hxD7l1sgxtY0OUROO8mu63dBjWHMKCKqaO7jHKygad439YQFDvfSeozTRtQnMcH+f+r0clNOIKNQ4IsBC0qsB5EIKtmN4jWwT+I+3taU8d+D3+uHdaCR0IA1A4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by IA1PR11MB8100.namprd11.prod.outlook.com (2603:10b6:208:445::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38; Wed, 21 Feb
 2024 04:18:02 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::5d40:83fd:94ac:d409]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::5d40:83fd:94ac:d409%7]) with mapi id 15.20.7316.018; Wed, 21 Feb 2024
 04:18:02 +0000
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
Thread-Index: AQHaVpxQxL7eT1mQek6VcjPJOSVEZ7ETiLSAgAAiyYCAAASHgIAATE8AgAAGrQCAAAuagIAADnuAgAAMOQCAACNjgA==
Date: Wed, 21 Feb 2024 04:18:02 +0000
Message-ID: <41b401d59b3846f44cee33f1d680b2534b7c0dea.camel@intel.com>
References: <20240203-arm64-gcs-v8-0-c9fec77673ef@kernel.org>
	 <22a53b78-10d7-4a5a-a01e-b2f3a8c22e94@app.fastmail.com>
	 <4c7bdf8fde9cc45174f10b9221fa58ffb450b755.camel@intel.com>
	 <20240220185714.GO4163@brightrain.aerifal.cx>
	 <9fc9c45ff6e14df80ad023e66ff7a978bd4ec91c.camel@intel.com>
	 <20240220235415.GP4163@brightrain.aerifal.cx>
	 <a57d6c7eada4b9a7c35addbc8556f5b53a0c3e6f.camel@intel.com>
	 <20240221012736.GQ4163@brightrain.aerifal.cx>
	 <6332963a828d247ef935b7d3352fa1fbd83b11b0.camel@intel.com>
In-Reply-To: <6332963a828d247ef935b7d3352fa1fbd83b11b0.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|IA1PR11MB8100:EE_
x-ms-office365-filtering-correlation-id: 9caed3a2-545a-4e4c-ae6c-08dc3294185a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q2dr+0y0PeBpJqqp8CmHJtSYjPJ8p8yP2kxWBDJ7CYbGWYVpPoM1taZ0/pHSWTU17z211nBJYrpoa6SfupN1kNew3makZkh+RYjp/fzEvCZ6wk1qfNctPJWCRZu9fX14Dc3PwnAOHNZEte3ZYSsCTc+KpObUedHNNC/5oQ/Jp7IqoEeTXezXT0noyvf1NvKxjolRN4duCNHDqeEKx0SuF7FfEDybRPkwQp1UM4vWmh+A5qxAXbSTdaoM0dYjD0Fw5h9QuaJU081Pzlnwn39hXyP2c4VsBdkvIEY9/SyQlEiz1mZXucf7INaexFICgYdBwfSFpELSBLhk710zfU95/oUgH9fZiAB23HAEx4/FFkiFPp4xby9C+398KFTScdXlfMtHe71nk2nNvHyGiV68cqhqW9ci0hUHlibYTDjnomElbH35bjnxVd1tWWBFOV7yJNG6X28pfO1S0YQxmiVUBTzqVDfd0E4tSSUtVpYedBpCIhQ5LJsntx/ChNZWXnohATABTrfTsUUR37XNKwujETRn85Q4zYJXxcrzQYAHhmP5ys1cHoaPhKpI5dIQHmK2SlnDfnbnoAtxRpYHbnMkDQgFvcCRYcQNt9uXrzsJutQKUuNWn/0xKQak1bVbq8aO
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SDh4NEYyeHdXdXZxT0kvRHpucExJcnpUVFZXMDJGVkVURWlRdk4vMWYzTHcr?=
 =?utf-8?B?LzVuMmcxOGdvOUl2bTFYL3dwTk96cmRKcEl4WjV1dksvMkYyRkRLYUxDYWxL?=
 =?utf-8?B?Z1dFMmlRK0N1UGxvRzRuZkFwMUdtai9QYU50akdkb1A2UGtHQmJZMktrRGhX?=
 =?utf-8?B?Wkh5bnNoZHFJQW9oSmt6aEZUTWxLTDAwOStld1hHTmVpdVNzZDU4eTlzSEJV?=
 =?utf-8?B?aTlDdlNIWFIyTHMzV1dRRmRCWExBMlhZbUJBWWZlWk9VU0l3RWoyT2FZVDRP?=
 =?utf-8?B?dzJ0MzVIQXR6cm50TWNYY3U0cTJEL2g0VG5rMGRPTnVyVFJzSHpDenVGc0p2?=
 =?utf-8?B?S2FZMFJMWGZ3ZUo0STZJNnpJY25lR3RaTlB2TzBBVTBLMmI3d2VuUE9GbC96?=
 =?utf-8?B?MkxQUjF4azBsalN1T1M0T2h4a2dwdHRMc2dpdENSanluSlRqSTc4ZVRRQ00w?=
 =?utf-8?B?MnB0WUczVlh5NzRuallCUVpMUWhEVEprRjJzUis2aW15eXJ2ekNQOU1yS2V0?=
 =?utf-8?B?WW13RU9kNm92V1BzVUwxVUN5TXdjekwwaEgzdTU2YzNNdXBWaGVlalhaWEZj?=
 =?utf-8?B?dkZnNFVZWEpiUFAwZ1UzbGZGbll6OWtMMDNZc0hxSy9lRHBDak16N1ErTDl1?=
 =?utf-8?B?aUI3U1kxVW5KT1FHQkpBamRiMWpDWGk5NWg5dkUwcXM0UmxqRFJBamI5Q3Fa?=
 =?utf-8?B?bTU2RUNBVmwvY1hNWFpnL0NhRGJMSFA2NHFqbU5QR1REV3psNWFHOTJ0K0lo?=
 =?utf-8?B?dzE4QWVKbXhnWVFrWHpGamtFV1hWcFpySm1XUFFFMTljZWk5V2xjVGFUZXNx?=
 =?utf-8?B?cXBtYStvNE9zbnFRUlFQT01EYUxaY0o3QlRVdGQ0d3pJSlJ6ci8wRi9kSHR5?=
 =?utf-8?B?M3VaMTdxSmRibCtXeWF5WXZwRkYzaUxsaHJvb1hVQzY2Z0JTc2xGVG9scUU4?=
 =?utf-8?B?VHloVTd6WnA5ajVsUGRLUUhRZnhaN0d2MVB2RllyeEIvL2hOUHVPcnkxMFg1?=
 =?utf-8?B?cjVVZVJENUZpT3N5WGFWejJDcGltM1pxdE5NM1NzdklrWkZtWDZnSHVjTG1V?=
 =?utf-8?B?TVRSNXByTnV1M3c3NzBvdGtRNnhGV3F1ZHBpNmVIVDgyN1l4QitTM1ZzeFJD?=
 =?utf-8?B?SE5IMithYTBZclo2QWVUd3lERWJRUVBqQk9aV1pVRzY2bTRSUU9zSit4Qlgy?=
 =?utf-8?B?NzRjSDBiREZVcld6MU53eDh3T1BBSHp3ZkcxYWdEOWNPZWdVVUN3NFhMSnVU?=
 =?utf-8?B?elVEcmkyODQxZ1U2MlhpbWNkVG4venViaURrRGxtemtRSVREMDBLdm1Eb25p?=
 =?utf-8?B?MXdpZmVlVWlwaWxUdEx5UmtUTkZvejlpdXlUcVdZTjJxT21PR3BRR29UaG9G?=
 =?utf-8?B?SEFkUCtkTElHejZlbUxsUk0zNythblBYbGFMTFBBMFdYcU9iZ282R2Zwcjdn?=
 =?utf-8?B?dGt6MStaa2hKcVFaYkVlb3FsVDdLWS8wYm0yNjV2TjdpODZoR2UrNzNSZXRS?=
 =?utf-8?B?QW1RSktWYUFOM05yVnpkN3V1eXJ4ZnFXcGlES1pWRmJKSGc3MHVrUEhkaGhj?=
 =?utf-8?B?MGpRdTZZcTBGMVA2amVRUUYraXlJNE5aM24vb2ZSUEFXcVppQllmNDVkeCtR?=
 =?utf-8?B?bTFaZFllUjA1OTVUT0xkdW9nbWl4RmRldnoxZXA5VEFZS3NsL1ZpUTFFbDRq?=
 =?utf-8?B?NnVyQ1VRZGxYYWltNHhtemtyWlhidzVvcjlzK3F3QmRtclo3dVNEeXRtOGNn?=
 =?utf-8?B?NHpTMXA0YU1DUDdiTEZhbUxHQlJ4dWp5MVBOaXg1V0tlY1NYZjU0YjdhZUZT?=
 =?utf-8?B?RTFzb1ZFNDVYazVMZ1ZyL3VFcDJYREN1aVRtNFV6R2t1TUhTY05RK3NFTUV1?=
 =?utf-8?B?NmdLdHQyVWtsVHlseXFYUW04WjV1Qlg0bStDMHVuOHozbFN2MEltd29KMUtL?=
 =?utf-8?B?VGxFeFE5SnBRTGgyYkdYYlZKUGVjSnl6TnAraXFJL1JISDZiQ01NTkhoUm90?=
 =?utf-8?B?Y29DT1o1cW1haVZsbzhuRGNCR29xUSs2amdYMGoyS08xM1dXc1ZPOVplVWsz?=
 =?utf-8?B?YXBHTFl0MWVnVUxnem9zZk5MdmZITmloaXJLV1JrYlJqSk9ZL1VrRUpjRkc0?=
 =?utf-8?B?N1NYWWJLNXpoRU5QZU5TVHNhYmVCMXVOVGhBN1Btd3FkOWZjdktxRHczSEZs?=
 =?utf-8?Q?4n7gWWmgbxY4TTy3Cp9PeSU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C5ABC9A534BFC942AF9732629CA297C7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9caed3a2-545a-4e4c-ae6c-08dc3294185a
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2024 04:18:02.4351
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2a1K4pjY9e1W4n/MBIe2zxxDUzdLNzOhL0Y9lUQ3t22yoaNaw5s5ERW2kTsVZZ88i/Y2sJfZs86JP7eXaBOeI56EQQuKGUvr5HSzyHEd/Ww=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8100
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI0LTAyLTIwIGF0IDE4OjExIC0wODAwLCBSaWNrIEVkZ2Vjb21iZSB3cm90ZToN
Cj4gU29tZSBzcGVjaWZpYyBjYXNlcyB0aGF0IHdlcmUgc3RpbGwgb3BlbiB3ZXJlIGxvbmdqbXAo
KWluZyBvZmYgb2YgYQ0KPiBjdXN0b20gdXNlcnNwYWNlIHRocmVhZGluZyBsaWJyYXJ5IHN0YWNr
LCB3aGljaCBtYXkgbm90IGhhdmUgbGVmdCBhDQo+IHRva2VuIGJlaGluZCB3aGVuIGl0IGp1bXBl
ZCB0byBhIG5ldyBzdGFjay4gQW5kIGFsc28sIHBvdGVudGlhbGx5IG9mZg0KPiBvZiBhbiBhbHQg
c2hhZG93IHN0YWNrIGluIHRoZSBmdXR1cmUsIGRlcGVuZGluZyBvbiB3aGV0aGVyIGl0IGxlYXZl
cw0KPiBhDQo+IHJlc3RvcmUgdG9rZW4gd2hlbiBoYW5kbGluZyBhIHNpZ25hbC4gKHRoZSBwcm9i
bGVtIHRoZXJlLCBpcyBpZiB0aGVyZQ0KPiBpcyBubyByb29tIHRvIGxlYXZlIGl0KS4NCg0KQWgs
IEkgcmVtZW1iZXIgdGhlIG90aGVyIG9uZS4gSWYgdGhlIHRva2VuIG9uIHRoZSB0YXJnZXQgc2hh
ZG93IHN0YWNrDQppcyBhdCB0aGUgZW5kIG9mIHRoZSBzaGFkb3cgc3RhY2ssIGl0IG1heSBub3Qg
YmUgYWJsZSB0byBoYW5kbGUgcHVzaGluZw0KYSBzaGFkb3cgc3RhY2sgc2lnbmFsIGZyYW1lIGlm
IGEgc2lnbmFsIGhpdHMgd2hpbGUgaXMgdW53aW5kaW5nIHRocm91Z2gNCnRoZSB0b2tlbi4gQXMg
aW4sIHdoZXJlIG5vcm1hbCBsb25nam1wKCkgaXMgZGlyZWN0IHRyYW5zaXRpb24sIGluIHRoaXMN
CmNhc2UgdGhlIGxvbmdqbXAoKSBvcGVyYXRpb24gY2FuIGJlIHRlbXBvcmFyaWx5IGluIGEgcGxh
Y2Ugd2hlcmUgYQ0Kc2lnbmFsIGNhbm5vdCBiZSBoYW5kbGVkLg0K

