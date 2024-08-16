Return-Path: <linux-fsdevel+bounces-26122-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD4E954B95
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2024 15:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B137B1C23B9F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2024 13:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3888B1BCA16;
	Fri, 16 Aug 2024 13:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GCJTneti"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60441BC08C;
	Fri, 16 Aug 2024 13:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723816759; cv=fail; b=HJ2lFnlrlPug8JHH0TV7hqdxRDCwMW8F6+AknMDk87pxaazQes9hgI+Ikkk5nSFgWn9Q06cH3Wb0v2J5Z+IOJMhbXmVkpisQZuonyKB/Z1Z88FbdXQ0y8+quCDPOTEtF6yoyf3ygYp1XZVtGld4FNhFvWFDT2wriKbrD7QDQ5pQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723816759; c=relaxed/simple;
	bh=GoynHsdnG4k72j2B1kI3w8vSQhFIXi47Q2FPr1AHzSY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Z8a/qnHrIwFyi0wNyOOoLu8FWRCeZLDsskg01gDUKy+0yke3XgcDgF1uNbc4+RjuJFCTAZy4M8ZSZ6KPaH7dpCIBY0whfb6ob1A+9nfnxNtqAVjmEtriNw95kAcwgWbM9N7Kp0VYyw57QoLoI0/SSVl0xvex8K04PW3h2PUKNds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GCJTneti; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723816758; x=1755352758;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=GoynHsdnG4k72j2B1kI3w8vSQhFIXi47Q2FPr1AHzSY=;
  b=GCJTnetiqUui8ENLhsg/gxdF57V6rFUO6oLEnIODRV1Dptg9uDBufNb3
   JCPd9auRQWjfJL+EGFGHfnv4VEutYd7OeC+eSnbFaAHetXJkvS0dy75Gx
   hqsr7NGrvW2kTw7COxTKHPdNMeUPL5YpZrt58T64L/MnQ92UXMoc7UWBo
   OkwnVG6B3Du0/3gSa1/Nx6tvrTMjNRDuYiiYYQ5pPkk/a9Gfd6cHMyF/t
   K8OTT6yb2LddyX2uY1d/BKyYCFzbHrm5cY2wAkgTRLg2FH+36gS3MoW/9
   I3kqaTkVm+WCkQShiCMG9fb/pDor8onZKrg6AFs1T7y++4jqVFyb5Q8KU
   g==;
X-CSE-ConnectionGUID: 8X+qiXQmQ7CLnkC7mGWUGQ==
X-CSE-MsgGUID: buulw0xsRR6hN0LgnyGEsA==
X-IronPort-AV: E=McAfee;i="6700,10204,11166"; a="22083712"
X-IronPort-AV: E=Sophos;i="6.10,151,1719903600"; 
   d="scan'208";a="22083712"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 06:59:17 -0700
X-CSE-ConnectionGUID: EpZ8HQ+VR6W0X+0W1ueKtA==
X-CSE-MsgGUID: 8FxvSvCFSnOqanuRKyoyyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,151,1719903600"; 
   d="scan'208";a="64569906"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Aug 2024 06:59:16 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 16 Aug 2024 06:59:16 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 16 Aug 2024 06:59:16 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 16 Aug 2024 06:59:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ITflLPERkA4AVZBj9IkIIKkmxBBRDAoh9xhyjyF0MrIenOQPAM/QtzETE9HN9NmQpaw2J+haNZhl6XfbIb34EM336k78tQAzG7r29jGbc/JEhCIDRin8fj1KbDZSjgGnAp7WQiGfIE3c6IL0cJVqmVleIGq+bou8+TvWd0qVs37cdqBbL9LtsJ7yrTn4eG8x71Z33mHkTR4L+JgYgsLnSwdV9qwCWtOdx/IpxqmM0vcwLMIA2MqV8rRoJT69MwgwXPiscKH02hi3Emd308wSbiFPJAN8dpRAlcUsoic01aiPOb3UqXfCVCHY7xOcEU/uHqpwAtVQyx0TCiXYTNkz0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GoynHsdnG4k72j2B1kI3w8vSQhFIXi47Q2FPr1AHzSY=;
 b=ZggRQ8d7eKZ6GziGNCqW2IZS0yTEtI016RYmpJhYu6KHpbvNWlOB2iL45pfKt5kewiZ4OPEFpfIoyMFOuXfunz23sTLOuwhG6rVsVrcyHStvSjin2hDrMtAI6HqTNLtOpp34kql/tZvFTWx48IcdcoMNkBUepw5x5mElh7vLa81MA+bZpkOWgsw2RndBaY8AgA5eHeKjhHJPsNC5CguSBP9vvEAQL8Eoo23dOX8oSm+cOt2B/fJDIsS0HpTA0KKO0yjSTHbaBupIiwR9TiJQgNSxNAU1Xv+dwGYXzQBULQc9CkaI7/RwR9QMpH8RT/Y9QaUYj++Xrz5QJHDfi1ARHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by DM6PR11MB4721.namprd11.prod.outlook.com (2603:10b6:5:2a3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Fri, 16 Aug
 2024 13:59:14 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%4]) with mapi id 15.20.7875.018; Fri, 16 Aug 2024
 13:59:14 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "broonie@kernel.org" <broonie@kernel.org>
CC: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
	"ross.burton@arm.com" <ross.burton@arm.com>, "suzuki.poulose@arm.com"
	<suzuki.poulose@arm.com>, "Szabolcs.Nagy@arm.com" <Szabolcs.Nagy@arm.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>, "corbet@lwn.net"
	<corbet@lwn.net>, "kees@kernel.org" <kees@kernel.org>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"oliver.upton@linux.dev" <oliver.upton@linux.dev>, "palmer@dabbelt.com"
	<palmer@dabbelt.com>, "debug@rivosinc.com" <debug@rivosinc.com>,
	"aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, "shuah@kernel.org"
	<shuah@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "maz@kernel.org"
	<maz@kernel.org>, "oleg@redhat.com" <oleg@redhat.com>, "fweimer@redhat.com"
	<fweimer@redhat.com>, "thiago.bauermann@linaro.org"
	<thiago.bauermann@linaro.org>, "james.morse@arm.com" <james.morse@arm.com>,
	"ebiederm@xmission.com" <ebiederm@xmission.com>, "will@kernel.org"
	<will@kernel.org>, "brauner@kernel.org" <brauner@kernel.org>,
	"hjl.tools@gmail.com" <hjl.tools@gmail.com>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"paul.walmsley@sifive.com" <paul.walmsley@sifive.com>, "ardb@kernel.org"
	<ardb@kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>
Subject: Re: [PATCH v10 12/40] mm: Define VM_SHADOW_STACK for arm64 when we
 support GCS
Thread-Topic: [PATCH v10 12/40] mm: Define VM_SHADOW_STACK for arm64 when we
 support GCS
Thread-Index: AQHa5BKUVD7wI5NTNUm62iFzIM90d7IohUeAgAABngCAABRGAIAAFLaAgAAHSQCAAUmjgA==
Date: Fri, 16 Aug 2024 13:59:14 +0000
Message-ID: <6e246375ed9e798906c9de59692d4b10f089c98e.camel@intel.com>
References: <20240801-arm64-gcs-v10-0-699e2bd2190b@kernel.org>
	 <20240801-arm64-gcs-v10-12-699e2bd2190b@kernel.org>
	 <34f7a5378447b1a8d5a9561594b37cfeaa6bd2b1.camel@intel.com>
	 <3a7d9b69-e9df-4271-a3f0-8e8683c2654f@sirena.org.uk>
	 <68ec09da-fb4a-4d59-9c8c-6fae4c48ea68@sirena.org.uk>
	 <e6c8618a1585006dde44c17192a3bb7ae8ec5c0b.camel@intel.com>
	 <9949a344-be8e-40ed-b483-02ff95175072@sirena.org.uk>
In-Reply-To: <9949a344-be8e-40ed-b483-02ff95175072@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|DM6PR11MB4721:EE_
x-ms-office365-filtering-correlation-id: 8aa42662-7562-47c9-66f8-08dcbdfb9c9d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?RFU4YW5tT0ZBMDJodnd5bi9ZampraFVubTNINVpBWHQ4QnZxUkI4WWljb0xo?=
 =?utf-8?B?OXJ2Zm9ZMTBqbjEvbzNVNU1RSzMxdk1GUUQ0TmNaaU9GK0V2WGlhUm5qSURR?=
 =?utf-8?B?WkdZYXUzYmRRa3JhY2dUZVFBOGNBNysvbzFVR1ZMM0VSZGZaajRVTkpONUZF?=
 =?utf-8?B?K24rc29JWk5OSjNKMU0yUU51RkxjVHFBZ3RHdzFtR21ldmMvVmVQVy9MWEF2?=
 =?utf-8?B?dFdhYm9wM2Z4d3JReS9QYnhUUk0vaE5QcEdqUjVHdkZmM1oyTjZ1OUM1NWEx?=
 =?utf-8?B?R01aeU9sb3VyMEtvQUNiVHhBVUQ3clRxaGszMU1MQkR0YU56NGJiTEtVZ2xM?=
 =?utf-8?B?WUpITjQyK05jNU5VNVpXb3ZMWG1wTE40QWcxVmpPaUlqUUwxRW0xczRJdTdI?=
 =?utf-8?B?QkorbXNqdlZXTEJZOFQ0eHhxdjdIOE1ocTEzT0paODVEQjlBRHp4K1NIcGVs?=
 =?utf-8?B?YmVTb29xNi9pN3FTTUIxa1FYTDFWdmI2ejc1TWZsd0ppYnkwc1VZY1RmTW94?=
 =?utf-8?B?TCtmY2M3RmhacVltSVNOUTQwcUVVZzVFazRRMEp4NEN5OGNMOEp4RWtoNDd4?=
 =?utf-8?B?ZXYrTHZ0eU1yNjliT0FXZjlXUkFFajYwZkEvOHE1QWR1azV4R0oyVXB3WS9r?=
 =?utf-8?B?WFRvYm1wbUVzRlhpQXRyNGJiZ0picjF6UUFuMTBHV2V1OG1LK1NUSVZad3NB?=
 =?utf-8?B?c0E2WVkrRjZEMTJ3eWw0d1kvNTBiTFl5OGYzbk1ZU3A0UThwY1p6UkpWVjlK?=
 =?utf-8?B?R0pacmJZQUdidVBNZngxd2pFeERnY0RPQjZXSzR3Y1BaTUY1aWlRL29qR2Zo?=
 =?utf-8?B?N2k3ZHdHMHlCdGJVQkVlcVc2SlE3RjVkd1c2ejdTekZjeWF2Y1ZaajB1S3ZK?=
 =?utf-8?B?MzhxOEUrRW51eFBhSndGWElPN0lBQVNZOXZyNjF5cWYvb0tUMDc2VlV5SEEw?=
 =?utf-8?B?UlBuWStuMm5yMXJaVS9lSlZ2K2Y1Q0xuZVlOeEZ6TTlzRWUwN0RrbTRXUFFE?=
 =?utf-8?B?KzZLT2N1Z3Q0RnFQQW9US2VjbDh6cWY3Qm9mWFMrbzBRc1F5V0dDMjlDTmFr?=
 =?utf-8?B?M2tScGF5Q1ZEMWNITXl4K245YUh1WFVua0Njc3BCVTVuZ1F4dC9ycm9PS09H?=
 =?utf-8?B?bDBJM2dDY2R6dC9yeFJtZFhEdlpyWnNtSVFOZEtOZ1M2aVgvL0UvK2FpL3pI?=
 =?utf-8?B?QjlySTRKWTdRRHJnU3JQWldzcm9VUktESi8wTlB4RGxOc1ZqWXlmSlRuQW16?=
 =?utf-8?B?OUgva1RZV3RXQitiVk9wMFBxZ01qWmRGejRhcFdORlRUTUx1bWdTZ0wwN3Ey?=
 =?utf-8?B?VGhydCt6SmEwdTMwSzdNZnk1a0lkTy85N0Nyays5RXhtS3c5bjE0QkY1R2lv?=
 =?utf-8?B?OFNTMUpmQUdQZVVjNjV4U0lYdWRRc0t2dUl1cWJEOHlXQnBpVHQxOHFkNGhU?=
 =?utf-8?B?amxudjFXZVU3MFY1dzBSbHM0UzlUMmhZVkliNEYxU0JuVWhheW0rZmhWcFlL?=
 =?utf-8?B?VlgwbkJaSmtHa25HRVhPazBDeE45WmYyWEpoZmFJajFYZ0pGRy9kejVpS1pm?=
 =?utf-8?B?NzJaY3hxdEVtWWRBSFBXWWU0QW9XSllnQXhxQ0hIRlJYRStkOHJvbjFsaWVk?=
 =?utf-8?B?YzdRWnd1TjJwZ0xLTjZyVXVMY2FXM1VMRXN2VnFTZVB3MHpXdDdOVndua0dN?=
 =?utf-8?B?R1FHOGFQWWRDSlJ4d2FvYXRPWm9qdFRxS1hCckw4ei92RVlyNTFKbFBTUUYw?=
 =?utf-8?B?QW1lblgwdHZQT1R2Wit6UU1ma0Y5TlJSdlZKa2NnZVpzU0x5UWRkRXZrU0Nu?=
 =?utf-8?B?dnFnNE4rUUxTcVNwL1pQWGcvNkZ4YXY5VDArcEFjMWNpb25WVW9kMnBTMXdp?=
 =?utf-8?B?RE1GOUdpWk4vMENIc1IveTJIUjlYSjRiRmRhWU5idEx3SEE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dW9yVkNFZVNaVzdtd3F0Ukk0R1ByNTlmMWlYVzlYL1VFMGoxMysrcjlvUGs5?=
 =?utf-8?B?SHNvbjZDTVBzTkpUWGh6QS9EV1dIcVBwZXROeWUxTFN1dEhxbWMwNGwxbWth?=
 =?utf-8?B?OTlGSmw1aEx6VTJOZzVnWnZiWG9BblZCbkdUOHM0TzlhZ2pWbk0rckErVlBN?=
 =?utf-8?B?aTVlcVlHVFk4empRZnpvc3dPNWpDVWpiUDZvcHBwUE5DdHBpbllzSXJ1eHJi?=
 =?utf-8?B?WllvRVJzTFRXOEZZVWFSTGxkZmZtZUhqLzhoWXFReE45VGhPWFpvTUROcWVQ?=
 =?utf-8?B?anJFVVhucEhobFprVDE3dUZpZHBUTlFDQWdPck1PRzUrbzRoODBuOXdML2Nz?=
 =?utf-8?B?UlRlaWZIeHAybGZ3aGYwSTJQeTA5NC9TOUc2aEpOUWkzL3VOM1F5dmZyWUlH?=
 =?utf-8?B?bS9kSkVWbHY2TkpITk13NXJDemhTbG96Z0RQcVlEUTFkSGdHZjFZcHRqT0Rm?=
 =?utf-8?B?RXNYOW9Hbkg2MWZ4SzA1b0pkSUFCQ01kZUI0WndJY25yNXYzbzNqUHNMWm9U?=
 =?utf-8?B?elVaa3dxZ0RhT0toL1VIRmhmbTEyOEJPUjIvS0hFVWE1UmhWWUdUTUxCZlNq?=
 =?utf-8?B?cUxiSkFaWkVKRDVUYjRSNmRjYVRrNENud0ZielRSUVJLQ1phcmpSOG1aQXJD?=
 =?utf-8?B?VkRxTjBUY2lIZTA0a0NaR1RMMjNzMGNEa3JiQUlaRHFvOG1zV3JzL3JEOHpI?=
 =?utf-8?B?U0Z3cFRZT0hqZXZPSVNpd0ZFYzJtSnlGV3h4b3ZlM1hSOHMwelJJTjdQZ0Rw?=
 =?utf-8?B?cDZmaFAzK1VzN0xqM0pNQngxbmlobTZpRzg5UEJLSUw5aWNPOWhpSDhkL1lX?=
 =?utf-8?B?M3llWk9LN1hBbHZ1ZTduUWtUcW5zU2hVV0E5U2x5clF3ZHNpNkhKVjNoVU1q?=
 =?utf-8?B?ZzlramVhZHdRdFZ3emk2c00yOEJiaFdSK3ZIbXFUMFFlR2ZSV0lsTVhvcEw1?=
 =?utf-8?B?YURtdUl1SUlPbjIzNEo4dXRhVXlONmdvTXlMYm9oblJiV2g2eTJGeUhKWk83?=
 =?utf-8?B?NGQ0WUZxMVpSeWdUaWk3T2VqZStmdUp1SGFnSmE5a3cyejhkUTVSMGYzVnpD?=
 =?utf-8?B?eXcvWlhFZFUvKzZiUzMyMmd3THVpelFzSXlnQmxvbkFEbEhJakxNRG5lVmFk?=
 =?utf-8?B?cEFsb1lNQ1NYRW1tbHlPdU5UUklHTlVHdWtkdWN0K1UxYWNja2t4SFlIREdS?=
 =?utf-8?B?Wmppa2pMSGduRmt1Z2xJZnFjeU9NMmxVL0w4bDBEN2RMWXVyQWE5My9VcVc0?=
 =?utf-8?B?Q20rWHRIZFNjQmRwTU1pQi9QZWxLb2g1YnBpVGJ3QUppTldFTHVuSGdsY3Ju?=
 =?utf-8?B?UDNKcDJrd0l2eWVWQVNTa0NWS3lhamV2dzRKZEdSTG5ZL1hGMUZoMzlJOVRZ?=
 =?utf-8?B?VExiVjYrWWNKWEcwTHdQOTdMQ3N2N3ZDdFFXc1l6dDlqL25EL3J1RFgyQUkw?=
 =?utf-8?B?MjU4RVMrS3hHYis3UTRVdXlBKzFEcHRIS1lBMnVnQ2N4emxFOEVrUVJVc2pG?=
 =?utf-8?B?bU05eEtvVDROdU9tUytuV01UQ3I4Ni9YZzh2cWhHSi95aUdDVExoR0lheHZB?=
 =?utf-8?B?d3gvdFFCTTF2dng0aS94ekphS2pKZ2JNS2ZtVGxpYklEQndYZkhRMFBiRi9l?=
 =?utf-8?B?S2trTnpkbWh6YTQ5cEgwQzR1TWhOK0lDR2ZDa085VExkeldUOFFNQmRLa0s2?=
 =?utf-8?B?cDV2NTdQSzl0cmhWb0dGZkF5YTVYcXRLazA4a3o4Qk0vMHE4MWVudTkza3lY?=
 =?utf-8?B?NWhLOHF6NlZMbkwwNi80RTAvME5SUjBMUjFjem5zbTNKRTVtbC9aTFZNZWt4?=
 =?utf-8?B?ZWdxQjFHdVo1bjVwa2VzSCtLRlR4VHMwTnpKcFVVWmVmWEJkdy9KMlNUQVBw?=
 =?utf-8?B?dWloeTR3bWgxV3Z5OUFiMndWZUg4cFBJMmFJazJBRHV3UnRMemRjVDNvaFBt?=
 =?utf-8?B?clhDYUF2dTA4ZzROOTl6SEF3RDZHZ0VRdVNEZnBxeVEyWXJKZE84a3d5MFoz?=
 =?utf-8?B?OXdQSjVpMXFVMTE4alJ2eVlsTTI3VVBSZWJBdVJnNVdKTUY2UW8vdHNmejBK?=
 =?utf-8?B?Z3dseG0vVXpLcXNlV0xyL2xzZDFrRnhuNHVPZlF0MG1NeWNLbDRhZmM1MG1Y?=
 =?utf-8?B?ZzlnNFBSWXdaZWtLKzkzQWVGM0poUUxYOTF1Y2VBMWEzQmtManB2Y0NRcHNK?=
 =?utf-8?Q?J3qb1qUGQKD4rQ/XsC/cJHk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0C53E84EC3B9E042A86E55E4DE4DDDEB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aa42662-7562-47c9-66f8-08dcbdfb9c9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2024 13:59:14.1165
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5ujkp7BUYvBDerYLDPdSv+wEvYrR8p61LAjaAoi6BAFXPVmUVICQWb5TS6aKmC6sD3o5C6Tt9c5BtN9SsODZDXRVC9D/1ihN6Rg/22U9s0Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4721
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI0LTA4LTE1IGF0IDE5OjE5ICswMTAwLCBNYXJrIEJyb3duIHdyb3RlOg0KPiA+
IFRoZSBzZXJpZXMgaXMgYWxyZWFkeSB1cHN0cmVhbS4gWW91IGp1c3QgbmVlZCB0byBhZGQgYW4g
YXJtIHZlcnNpb24gb2YgdGhhdA0KPiA+IGxpbmtlZCBwYXRjaC4gQnV0IHVwIHRvIHlvdS4NCj4g
DQo+IFlvdXIgc2VyaWVzIG1vZGlmaWVkIHRoZSBleGlzdGluZyB4ODYgY3VzdG9tIGFyY2hfZ2V0
X3VubWFwcGVkX2FyZWEqKCkNCj4gZnVuY3Rpb25zLCBhcm02NCB1c2VzIHRoZSBnZW5lcmljIGlt
cGxlbWVudGF0aW9uIG9mIHRob3NlIHNvIEknZCBoYXZlIHRvDQo+IGVpdGhlciBhZGQgY3VzdG9t
IGltcGxlbWVudGF0aW9ucyAod2hpY2ggSSBjYW4ndCBpbWFnaW5lIHdvdWxkIGJlIG1ldA0KPiB3
aXRoIGdyZWF0IGVudGh1c2lhc20pIG9yIHVwZGF0ZSB0aGUgZ2VuZXJpYyBvbmVzLsKgIEEgZ2Vu
ZXJpYw0KPiBpbXBsZW1lbnRhdGlvbiBzZWVtcyByZWFzb25hYmxlIGFuZCBpdCBsb29rcyBsaWtl
IFJJU0MtViB3b3VsZCBhbHNvIGVuZA0KPiB1cCB1c2luZyBpdCBzbyB3aGlsZSBpdCdzIGEgYml0
IGludmFzaXZlIGl0IGRvZXMgc2VlbSBtb3JlIHNlbnNpYmxlIHRvDQo+IGRvIHRoZSBjaGFuZ2Ug
dGhlcmUuDQoNCkFoLCBJIG1pc3VuZGVyc3Rvb2QuIE1ha2VzIHNlbnNlLg0K

