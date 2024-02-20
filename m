Return-Path: <linux-fsdevel+bounces-12173-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E69685C3B3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 19:41:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D09001F228D9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 18:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9620D12F377;
	Tue, 20 Feb 2024 18:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gHx7Han1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4CB69D01;
	Tue, 20 Feb 2024 18:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708454471; cv=fail; b=MfcNdatTDCpzOvhguKMKOYLqzz7gL55M618lgPm+BPOQTG5YWwiBJLl46gGekQJbvqS6bOBKaf+b8DdZ9EAXkPQJIl3advYd5n1sInLNGqniPGPehAiic5WTbUQAhwZQe1JHNUW0xNBgA3Rm9SoAyaAL+FHEsrW0VqM7RMwmeu0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708454471; c=relaxed/simple;
	bh=5NCLBYd5NBIHckJ6HbXpI5Dio2Gzm7lg1JfKe5RxE0E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HEYGErRf3FQo5bjMU88DdmMSYFahd6oSXEZJPCgOBsdnRb3KKYQetkq5tZAJFnEudVSIbsGqufRJJplvqIcywrsTJDHySbpGGpvkKQNdVEBiZLSODebk3nKaYbtgMmsp57a6P1a9ZYsqsRmbKy4QCxhYmU9+BeZPSf/xv7MxF1c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gHx7Han1; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708454470; x=1739990470;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=5NCLBYd5NBIHckJ6HbXpI5Dio2Gzm7lg1JfKe5RxE0E=;
  b=gHx7Han1izrlI4NCpAt4nCR/oQOEsZZrzmdZIqBWAQXDzSP/FAqZgR4g
   3Th1mS0nFjwCmi+XMWXtbSKAqNtkceK26vyMzRH9OfMV6mgjByNbMxMW7
   8HGiXSryBq8CxaIQbctphZKCA+CV8E4VGmE0ujQBr8v4dQ2JU3Fbc6Tac
   BqzAYsd0umBePWwrno1WazbIh7ga4DTg1LXEsmRsaxD/L9zTyomwZdMHZ
   n0DirzhkfdBbbGxE0Pj2DUzYq+YUKiyAKLmbRk9ask1Pl4jygkDvgEL06
   Ls59E7pQ0PwUpqwzI+vlxZx0+TZTth0SLJEIowdkF1vHpQXi/rXYGGdcm
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="2451146"
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="2451146"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 10:41:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="35636535"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Feb 2024 10:41:07 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 20 Feb 2024 10:41:07 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 20 Feb 2024 10:41:07 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 20 Feb 2024 10:41:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KAm1UFOK1rtJ8W9p4wGVcLdXwskB0VpHmHQPEEQ381WQNzLZS4kSZQbmlIrxMV3QrPU34WdaV4OLwN+i4SjhBoFg/uQ9ssgT5BBDDu7KFhBYLDciM5OSvvcxY+E1tyhmPAT9bDJqa7glXJ9k+SmfcqC+9SqBV+NwX6E+xGQr5Oz2tyonkA5xoDdsBaRl6FaTreGBIypdUWmN8QzoHQSsWoFL04QMoDkCgwU6CbadeIQ4H0i7d8nAYrlT24wV3VNWgTYDfHrDZDWGk0f1POWmR/AUjUnfuW1D02LoPgKlfhZPaphIZJlXnrs0cqXzoEAd7/TmrKEeNfOWP9ylrQ9nRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5NCLBYd5NBIHckJ6HbXpI5Dio2Gzm7lg1JfKe5RxE0E=;
 b=MG/lTwsFZVv5O5MKYh0EnDAfDGQFX3yMyJWkDlEPnX8mU7ZmreZ/AB/4tw9yemxN8LMBTp6w/zx/NQSUGrxogqyXOc62ZHSVhnosIhdC1cz7t+8IWvJhI2snLRA6BiRVR6eg+XgFZgSxCRLXdQd59odlQdcfRRId+HFDD1bND2efirrSX/L598/O04m/FMcxUGu2UpFIO5ydm5dBCp8ppTIkGabAZEIIqZkDh2WiXQbgJANxjaJXUPmSruOJtwpLlyfb3CUyEfm7Vv/qX9ZGMPADj+RzKgs88U15IDrPFcWwn8ULC5ySRLWktw70Zv6wzuay6eIbZVPVVRqVTLKg5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by SJ1PR11MB6105.namprd11.prod.outlook.com (2603:10b6:a03:48c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.34; Tue, 20 Feb
 2024 18:41:05 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::5d40:83fd:94ac:d409]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::5d40:83fd:94ac:d409%7]) with mapi id 15.20.7292.036; Tue, 20 Feb 2024
 18:41:05 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "corbet@lwn.net" <corbet@lwn.net>, "ardb@kernel.org" <ardb@kernel.org>,
	"maz@kernel.org" <maz@kernel.org>, "shuah@kernel.org" <shuah@kernel.org>,
	"Szabolcs.Nagy@arm.com" <Szabolcs.Nagy@arm.com>, "keescook@chromium.org"
	<keescook@chromium.org>, "james.morse@arm.com" <james.morse@arm.com>,
	"debug@rivosinc.com" <debug@rivosinc.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "catalin.marinas@arm.com"
	<catalin.marinas@arm.com>, "oleg@redhat.com" <oleg@redhat.com>,
	"arnd@arndb.de" <arnd@arndb.de>, "ebiederm@xmission.com"
	<ebiederm@xmission.com>, "will@kernel.org" <will@kernel.org>,
	"suzuki.poulose@arm.com" <suzuki.poulose@arm.com>, "sorear@fastmail.com"
	<sorear@fastmail.com>, "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
	"broonie@kernel.org" <broonie@kernel.org>
CC: "brauner@kernel.org" <brauner@kernel.org>, "fweimer@redhat.com"
	<fweimer@redhat.com>, "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"paul.walmsley@sifive.com" <paul.walmsley@sifive.com>, "hjl.tools@gmail.com"
	<hjl.tools@gmail.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"palmer@dabbelt.com" <palmer@dabbelt.com>, "kvmarm@lists.linux.dev"
	<kvmarm@lists.linux.dev>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>, "thiago.bauermann@linaro.org"
	<thiago.bauermann@linaro.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "musl@lists.openwall.com"
	<musl@lists.openwall.com>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v8 00/38] arm64/gcs: Provide support for GCS in userspace
Thread-Topic: [PATCH v8 00/38] arm64/gcs: Provide support for GCS in userspace
Thread-Index: AQHaVpxQxL7eT1mQek6VcjPJOSVEZ7ETiLSAgAAiyYA=
Date: Tue, 20 Feb 2024 18:41:05 +0000
Message-ID: <4c7bdf8fde9cc45174f10b9221fa58ffb450b755.camel@intel.com>
References: <20240203-arm64-gcs-v8-0-c9fec77673ef@kernel.org>
	 <22a53b78-10d7-4a5a-a01e-b2f3a8c22e94@app.fastmail.com>
In-Reply-To: <22a53b78-10d7-4a5a-a01e-b2f3a8c22e94@app.fastmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|SJ1PR11MB6105:EE_
x-ms-office365-filtering-correlation-id: 9a77e7ee-82ac-49ae-868c-08dc32437ec2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0BlJiWQH/EDPM4P1Rx3Uu7favFcBm/vPm4jqZsSYwWxm5cKlmtwV8amCNVw5DtZ1lsFttE+jEqunwvejAmeSnei995I0F86lgkIPR59Hi6ghUz2ZDjMYdcf8c7uu1L/gX9r6OM/lePsXzujg2oWPjnmV11P4ZSGyrFFtOTFjOA54CP9xCpSOvQQ07fwOi7s5XsViyNMF7H9me7oBGIVh1emHmqrVR6vHF06X/D0y5G4P7OK0334g2Xbo49m8MeFGmciH4qhyCzarJ4wXOAQZGxKgD4yeEWB4n1i2J8ei/0cqnx38vvTVQOkpRh75gCxZ/pgBv2eXTbMGFpGk2615mSDZ4kvz8YokOrIwFcX57jQHjV1f6ka3QfmMvBVeoEFf78OENoPzSgtGzdpzgmmU5GTgloD66dVNLHSQkkM3EuQSQETuNB3LG5ApdH4r/zrhCB4JEAchTVwcJcdTp580VDKJA8S8CSTy9m59orAEReZB/CrrKoIVBdGFN356CW/0QxpVhMXx0cvWgoX3ODA/67vEcsMuoSqr9wPfZCSOx+1EnGgnAhRSvhxDeZRHccj9yIn6SIm2/zEZFOlTl6aSA1FMQtMA1p1zM/1zgUGqxBLnzp1grZQhkhAkQydRkr1r0nbnDFzXzbXfuXF31i3uhw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(921011)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N2o0K2tWenhFd0pOMGhDeWxzOURrYllBb0pqOXJuZjRDdVlRWVkvQkJYRUta?=
 =?utf-8?B?Smw3ZlJRVXl5UFFEdGxpbXR0TSs3eHdMU0pCTjN4ZmJuM3FlSlpyTTdidUVY?=
 =?utf-8?B?Nk1YMGdqVW1rRmVyY1dsN3Z5R3R4UGFvQkliSHd3cDkxTGloeGN5UnFlZVBk?=
 =?utf-8?B?bGJCb1FNd0M4eTdPL1RDNm1lamJQNi91bWVla3ZoWWM4c1RpcElTaEZXUDVm?=
 =?utf-8?B?bmFMQXZERVRSczB3VUNZQXZObHptVWRtM0xPeG5nMjVsUDIrWTJ6SFR1WFZ6?=
 =?utf-8?B?NEJOdDFQSDJ0OU13MHZYdDlaK1VmaUxqMzhDblZSbFhQMzVpOUdqRVlqNHhi?=
 =?utf-8?B?OWRCYXZyL2wycWZjcEFFTkNlcURoVlFKaElhQjdHekUyM1hNZDlCcjBuZG0v?=
 =?utf-8?B?QmNPbm9jcDFHdHh6S2NjeDhvUzM3YmM2QTI5bnpYelpPMzdUekM5a01PNVIw?=
 =?utf-8?B?WE43eU5tY081SStTK0dqeXJ1NEM4Q0dGT1hGeTMxL2U2NGxvNS9BeHVrMmVZ?=
 =?utf-8?B?MWlPR3JhaDUwRWkvZXd5d3FpSlRSU2Z2RjVIK21pcFVZMGpycUNyekJSaUJl?=
 =?utf-8?B?cXVHK24yMW5DTGJQd3NZbmZoUmQ0R29lQUFSaHF4akxMaEVRanJsUS9DLzVu?=
 =?utf-8?B?SlZmMEd3TXhMQUc4Y1d4OE5mblRKZHk1TGt0dXlBTXcvengwc0J3T29rYjdB?=
 =?utf-8?B?UkVqZ2hodzRtOWRZK3RYK0VFRGljeHRjZ21CbmQ5NWNoU1kvSEtSTFhSdVBn?=
 =?utf-8?B?dS9HTmMrb0NJUXFOSjlNM2NkWUw4Nmp2cFlIOUVjMTBTeEZzYWZ3Zk1JY3lk?=
 =?utf-8?B?QWk1S3dPaDhvRGdMWVRDbGxKWUNSclhBNDNseU9WL3lnekE2Z3VWOWxUNjdo?=
 =?utf-8?B?dVpsVC9Qcmk1VkVXaHNtRW1hQURNL1pnbFNmYmN6NlJaNHd0ZldrSnVvdGt0?=
 =?utf-8?B?dk9ybStLYU9RQ0V6SEMwMWN6ZTJiQ0s2dDFYSExCVlB4eDZqVGdPcytoOGZ3?=
 =?utf-8?B?VHBtR2J0S3g4WVdLWlJrNFFKaHJNWnliVm5PR0YyUFZzblRJdHk0cFR1NXIx?=
 =?utf-8?B?Z290SUJUMk1hTGRwNGxJK3pxWWFWOFBEWDVpdlBEWDlQS3ZvNHZadDh1OFlJ?=
 =?utf-8?B?ZVdNaWgwaHVzM2l4Wit4emdML3ZRdktGZGZPS0RpVEppdDR0YnA1V2tlN3Y2?=
 =?utf-8?B?Sk9GbWsrNXJJOTRjak4vQXF4S01oUU1QYWo5WVl1RlVZQUNFb3ZRMjRKaGZY?=
 =?utf-8?B?aUZiS2lDQlNFNGxuVDBEaGlJOTc5M29GNXhlM001MC9jKzhOUjE0N0RodWxn?=
 =?utf-8?B?d25Wc1AyRUptNXFJUlc5M2VOTkdKVjhpVnY5eVVZWHMvNjhWWFhUYmZNSHMz?=
 =?utf-8?B?amo2dGt3bGFPTGt4NGx2VUVFakJjREY3ZmZEVlgwRmdROTcvdHROd1pwd0do?=
 =?utf-8?B?OGFCU0V2bkhsaTUrMDB2ZWZIMEErVGpYYnk0VkI5NGIrN1BOR0tpdDV4Y2c5?=
 =?utf-8?B?Sk42ZXN5ZGsvc1g0WWJML2JJZjErVmJTdVpBTThRY2RaWFRsQmJnbFcvazRJ?=
 =?utf-8?B?Y3BBcmRaUDJINGRURG1GUjFJQk0xT3FHYUhMK285Q3NHWlZXMnZHRUtLL0FV?=
 =?utf-8?B?VFQzTkNNNEs5aHZhZFJ3R2lBRFJ1aXJQeTkxd0tyd1A1NS85WEcrV3NmT3hU?=
 =?utf-8?B?NHZIK2lZZVNpVjJNK3ZZV0tUY1ZQLzB6K3ZDdldvUWxoUyt6RWloeUVjZGIw?=
 =?utf-8?B?Q0wrakxwbkRXQWluQVhXc2RjM0VUWWJEV0pwaHNKWXc2T0EzUEhWS09NTkFt?=
 =?utf-8?B?ZEZKZVBTMHNhNWlhM3dnTitRSVhOSWw1UXRPTHV1dzJ3RTZsQ1pra2xzbHRk?=
 =?utf-8?B?Z01tMnR0cStqaWlFWWtjWGpnaDJvaXhnY2dNUmkvV2plUzNZNENURlM5ZUU1?=
 =?utf-8?B?akVqYlIvS0YrZEdFeEhUMmFJb3JkVG5SUVNKbTJyeU1SRUFNYXBIem8rKy9r?=
 =?utf-8?B?WGNpZmgxT0FLcGQzdDVLbjQ3azlkNDZvK1FoUFhqcjVGNGUvYXh4UGpHalFM?=
 =?utf-8?B?TUJwS3VJWG1qTGVMeDhVUzlaaUhmMXFvN2Iya1JMNzlpZVQ1aHA1b3QvbHJk?=
 =?utf-8?B?SGJZeDE3dk5BTTdLa2pybVBOOXNLSHpLbFNFNS9CMmRnZjdiNWVNNTU1UVdx?=
 =?utf-8?B?U3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <78ED690EA967E04CA43EE946E217B642@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a77e7ee-82ac-49ae-868c-08dc32437ec2
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2024 18:41:05.0595
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zSNLUP9tfZdx0e4oBi33RHz7qS7TSh5NvFZ0FC1XLkRwMagQbnDVsAqjpqBwc9a9ot4gVE5HVE3KTnc/6G59ta4xAFDRgFuDyquEatfVFLQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6105
X-OriginatorOrg: intel.com

SGksDQoNCkkgd29ya2VkIG9uIHRoZSB4ODYga2VybmVsIHNoYWRvdyBzdGFjayBzdXBwb3J0LiBJ
IHRoaW5rIGl0IGlzIGFuDQppbnRlcmVzdGluZyBzdWdnZXN0aW9uLiBTb21lIHF1ZXN0aW9ucyBi
ZWxvdywgYW5kIEkgd2lsbCB0aGluayBtb3JlIG9uDQppdC4NCg0KT24gVHVlLCAyMDI0LTAyLTIw
IGF0IDExOjM2IC0wNTAwLCBTdGVmYW4gTydSZWFyIHdyb3RlOg0KPiBXaGlsZSBkaXNjdXNzaW5n
IHRoZSBBQkkgaW1wbGljYXRpb25zIG9mIHNoYWRvdyBzdGFja3MgaW4gdGhlIGNvbnRleHQNCj4g
b2YNCj4gWmljZmlzcyBhbmQgbXVzbCBhIGZldyBkYXlzIGFnbywgSSBoYWQgdGhlIGZvbGxvd2lu
ZyBpZGVhIGZvciBob3cgdG8NCj4gc29sdmUNCj4gdGhlIHNvdXJjZSBjb21wYXRpYmlsaXR5IHBy
b2JsZW1zIHdpdGggc2hhZG93IHN0YWNrcyBpbiBQT1NJWC4xLTIwMDQNCj4gYW5kDQo+IFBPU0lY
LjEtMjAxNzoNCj4gDQo+IDEuIEludHJvZHVjZSBhICJmbGV4aWJsZSBzaGFkb3cgc3RhY2sgaGFu
ZGxpbmciIG9wdGlvbi7CoCBGb3Igd2hhdA0KPiBmb2xsb3dzLA0KPiDCoMKgIGl0IGRvZXNuJ3Qg
bWF0dGVyIGlmIHRoaXMgaXMgc3lzdGVtLXdpZGUsIHBlci1tbSwgb3IgcGVyLXZtYS4NCj4gDQo+
IDIuIFNoYWRvdyBzdGFjayBmYXVsdHMgb24gbm9uLXNoYWRvdyBzdGFjayBwYWdlcywgaWYgZmxl
eGlibGUgc2hhZG93DQo+IHN0YWNrDQo+IMKgwqAgaGFuZGxpbmcgaXMgaW4gZWZmZWN0LCBjYXVz
ZSB0aGUgYWZmZWN0ZWQgcGFnZSB0byBiZWNvbWUgYSBzaGFkb3cNCj4gc3RhY2sNCj4gwqDCoCBw
YWdlLsKgIFdoZW4gdGhpcyBoYXBwZW5zLCB0aGUgcGFnZSBmaWxsZWQgd2l0aCBpbnZhbGlkIGFk
ZHJlc3MNCj4gdG9rZW5zLg0KDQpIbW0sIGNvdWxkIHRoZSBzaGFkb3cgc3RhY2sgdW5kZXJmbG93
IG9udG8gdGhlIHJlYWwgc3RhY2sgdGhlbj8gTm90DQpzdXJlIGhvdyBiYWQgdGhhdCBpcy4gSU5D
U1NQIChpbmNyZW1lbnRpbmcgdGhlIFNTUCByZWdpc3RlciBvbiB4ODYpDQpsb29wcyBhcmUgbm90
IHJhcmUgc28gaXQgc2VlbXMgbGlrZSBzb21ldGhpbmcgdGhhdCBjb3VsZCBoYXBwZW4uDQoNCj4g
DQo+IMKgwqAgRmF1bHRzIGZyb20gbm9uLXNoYWRvdy1zdGFjayBhY2Nlc3NlcyB0byBhIHNoYWRv
dy1zdGFjayBwYWdlIHdoaWNoDQo+IHdhcw0KPiDCoMKgIGNyZWF0ZWQgYnkgdGhlIHByZXZpb3Vz
IHBhcmFncmFwaCB3aWxsIGNhdXNlIHRoZSBwYWdlIHRvIHJldmVydCB0bw0KPiDCoMKgIG5vbi1z
aGFkb3ctc3RhY2sgdXNhZ2UsIHdpdGggb3Igd2l0aG91dCBjbGVhcmluZy4NCg0KV29uJ3QgdGhp
cyBwcmV2ZW50IGNhdGNoaW5nIHN0YWNrIG92ZXJmbG93cyB3aGVuIHRoZXkgaGFwcGVuPyBBbg0K
b3ZlcmZsb3cgd2lsbCBqdXN0IHR1cm4gdGhlIHNoYWRvdyBzdGFjayBpbnRvIG5vcm1hbCBzdGFj
ayBhbmQgb25seSBnZXQNCmRldGVjdGVkIHdoZW4gdGhlIHNoYWRvdyBzdGFjayB1bndpbmRzPw0K
DQpBIHJlbGF0ZWQgcXVlc3Rpb24gd291bGQgYmUgaG93IHRvIGhhbmRsZSB0aGUgZXhwYW5kaW5n
IG5hdHVyZSBvZiB0aGUNCmluaXRpYWwgc3RhY2suIEkgZ3Vlc3MgdGhlIGluaXRpYWwgc3RhY2sg
Y291bGQgYmUgc3BlY2lhbCBhbmQgaGF2ZSBhDQpzZXBhcmF0ZSBzaGFkb3cgc3RhY2suDQoNCj4g
DQo+IMKgwqAgSW1wb3J0YW50OiBhIHNoYWRvdyBzdGFjayBvcGVyYXRpb24gY2FuIG9ubHkgbG9h
ZCBhIHZhbGlkIGFkZHJlc3MNCj4gZnJvbQ0KPiDCoMKgIGEgcGFnZSBpZiB0aGF0IHBhZ2UgaGFz
IGJlZW4gaW4gY29udGludW91cyBzaGFkb3cgc3RhY2sgdXNlIHNpbmNlDQo+IHRoZQ0KPiDCoMKg
IGFkZHJlc3Mgd2FzIHdyaXR0ZW4gYnkgYW5vdGhlciBzaGFkb3cgc3RhY2sgb3BlcmF0aW9uOyB0
aGUNCj4gZmxleGliaWxpdHkNCj4gwqDCoCBkZWxheXMgZXJyb3IgcmVwb3J0aW5nIGluIGNhc2Vz
IG9mIHN0cmF5IHdyaXRlcyBidXQgaXQgbmV2ZXINCj4gYWxsb3dzIGZvcg0KPiDCoMKgIGNvcnJ1
cHRpb24gb2Ygc2hhZG93IHN0YWNrIG9wZXJhdGlvbi4NCg0KU2hhZG93IHN0YWNrcyBjdXJyZW50
bHkgaGF2ZSBhdXRvbWF0aWMgZ3VhcmQgZ2FwcyB0byB0cnkgdG8gcHJldmVudCBvbmUNCnRocmVh
ZCBmcm9tIG92ZXJmbG93aW5nIG9udG8gYW5vdGhlciB0aHJlYWQncyBzaGFkb3cgc3RhY2suIFRo
aXMgd291bGQNCnNvbWV3aGF0IG9wZW5zIHRoYXQgdXAsIGFzIHRoZSBzdGFjayBndWFyZCBnYXBz
IGFyZSB1c3VhbGx5IG1haW50YWluZWQNCmJ5IHVzZXJzcGFjZSBmb3IgbmV3IHRocmVhZHMuIEl0
IHdvdWxkIGhhdmUgdG8gYmUgdGhvdWdodCB0aHJvdWdoIGlmDQp0aGVzZSBjb3VsZCBzdGlsbCBi
ZSBlbmZvcmNlZCB3aXRoIGNoZWNraW5nIGF0IGFkZGl0aW9uYWwgc3BvdHMuDQoNCj4gDQo+IDMu
IFN0YW5kYXJkcy1kZWZpbmVkIG9wZXJhdGlvbnMgd2hpY2ggdXNlIGEgdXNlci1wcm92aWRlZCBz
dGFjaw0KPiDCoMKgIChtYWtlY29udGV4dCwgc2lnYWx0c3RhY2ssIHB0aHJlYWRfYXR0cl9zZXRz
dGFjaykgdXNlIGEgc3VicmFuZ2UNCj4gb2YgdGhlDQo+IMKgwqAgcHJvdmlkZWQgc3RhY2sgZm9y
IHNoYWRvdyBzdGFjayBzdG9yYWdlLsKgIEkgcHJvcG9zZSB0byB1c2UgYQ0KPiBzaGFkb3cNCj4g
wqDCoCBzdGFjayBzaXplIG9mIDEvMzIgb2YgdGhlIHByb3ZpZGVkIHN0YWNrIHNpemUsIHJvdW5k
ZWQgdXAgdG8gYQ0KPiBwb3NpdGl2ZQ0KPiDCoMKgIGludGVnZXIgbnVtYmVyIG9mIHBhZ2VzLCBh
bmQgcGxhY2UgdGhlIHNoYWRvdyBzdGFjayBhbGxvY2F0aW9uIGF0DQo+IHRoZQ0KPiDCoMKgIGxv
d2VzdCBwYWdlLWFsaWduZWQgYWRkcmVzcyBpbnNpZGUgdGhlIHByb3ZpZGVkIHN0YWNrIHJlZ2lv
bi4NCj4gDQo+IMKgwqAgU2luY2UgcGFnZSB1c2FnZSBpcyBmbGV4aWJsZSwgbm8gY2hhbmdlIGlu
IHBhZ2UgcGVybWlzc2lvbnMgaXMNCj4gwqDCoCBpbW1lZGlhdGVseSBuZWVkZWQ7IHRoaXMgbWVy
ZWx5IHNldHMgdGhlIGluaXRpYWwgc2hhZG93IHN0YWNrDQo+IHBvaW50ZXIgZm9yDQo+IMKgwqAg
dGhlIG5ldyBjb250ZXh0Lg0KPiANCj4gwqDCoCBJZiB0aGUgc2hhZG93IHN0YWNrIGdyZXcgaW4g
dGhlIG9wcG9zaXRlIGRpcmVjdGlvbiB0byB0aGUNCj4gYXJjaGl0ZWN0dXJhbA0KPiDCoMKgIHN0
YWNrLCBpdCB3b3VsZCBub3QgYmUgbmVjZXNzYXJ5IHRvIHBpY2sgYSBmaXhlZCBkaXJlY3Rpb24u
DQo+IA0KPiA0LiBTSUdTVEtTWiBhbmQgTUlOU0lHU1RLU1ogYXJlIGluY3JlYXNlZCBieSAyIHBh
Z2VzIHRvIHByb3ZpZGUNCj4gc3VmZmljaWVudA0KPiDCoMKgIHNwYWNlIGZvciBhIG1pbmltdW0t
c2l6ZWQgc2hhZG93IHN0YWNrIHJlZ2lvbiBhbmQgd29yc3QgY2FzZQ0KPiBhbGlnbm1lbnQuDQoN
CkRvIGFsbCBtYWtlY29udGV4dCgpIGNhbGxlcnMgZW5zdXJlIHRoZSBzaXplIGlzIGdyZWF0ZXIg
dGhhbiB0aGlzPw0KDQpJIGd1ZXNzIGdsaWJjJ3MgbWFrZWNvbnRleHQoKSBjb3VsZCBkbyB0aGlz
IHNjaGVtZSB0byBwcmV2ZW50IGxlYWtpbmcNCndpdGhvdXQgYW55IGNoYW5nZXMgdG8gdGhlIGtl
cm5lbC4gQmFzaWNhbGx5IHN0ZWFsIGEgbGl0dGxlIG9mIHRoZQ0Kc3RhY2sgYWRkcmVzcyByYW5n
ZSBhbmQgb3ZlcndyaXRlIGl0IHdpdGggYSBzaGFkb3cgc3RhY2sgbWFwcGluZy4gQnV0DQpvbmx5
IGlmIHRoZSBhcHBzIGxlYXZlIGVub3VnaCByb29tLiBJZiB0aGV5IG5lZWQgdG8gYmUgdXBkYXRl
ZCwgdGhlbg0KdGhleSBjb3VsZCBiZSB1cGRhdGVkIHRvIG1hbmFnZSB0aGVpciBvd24gc2hhZG93
IHN0YWNrcyB0b28gSSB0aGluay4NCg0KPiANCj4gX1dpdGhvdXRfIGRvaW5nIHRoaXMsIHNpZ2Fs
dHN0YWNrIGNhbm5vdCBiZSB1c2VkIHRvIHJlY292ZXIgZnJvbQ0KPiBzdGFjaw0KPiBvdmVyZmxv
d3MgaWYgdGhlIHNoYWRvdyBzdGFjayBsaW1pdCBpcyByZWFjaGVkIGZpcnN0LCBhbmQgbWFrZWNv
bnRleHQNCj4gY2Fubm90IGJlIHN1cHBvcnRlZCB3aXRob3V0IG1lbW9yeSBsZWFrcyBhbmQgdW5y
ZXBvcnRhYmxlIGVycm9yDQo+IGNvbmRpdGlvbnMuDQoNCkZXSVcsIEkgdGhpbmsgdGhlIG1ha2Vj
b250ZXh0KCkgc2hhZG93IHN0YWNrIGxlYWtpbmcgaXMgYSBiYWQgaWRlYS4gSQ0Kd291bGQgcHJl
ZmVyIHRoZSBleGlzdGluZyBtYWtlY29udGV4dCgpIGludGVyZmFjZSBqdXN0IGRpZG4ndCBzdXBw
b3J0DQpzaGFkb3cgc3RhY2ssIHJhdGhlciB0aGFuIHRoZSBsZWFraW5nIHNvbHV0aW9uIGdsaWJj
IGRvZXMgdG9kYXkuDQoNClRoZSBzaXR1YXRpb24gKGZvciBhcm0gYW5kIHJpc2N2IHRvbyBJIHRo
aW5rPykgaXMgdGhhdCBzb21lDQphcHBsaWNhdGlvbnMgd2lsbCBqdXN0IG5vdCB3b3JrIGF1dG9t
YXRpY2FsbHkgZHVlIHRvIGN1c3RvbSBzdGFjaw0Kc3dpdGNoaW5nIGltcGxlbWVudGF0aW9ucy4g
KHVzZXIgbGV2ZWwgdGhyZWFkaW5nIGxpYnJhcmllcywgSklUcywgZXRjKS4NClNvwqBJIHRoaW5r
IGl0IHNob3VsZCBiZSBvayB0byBhc2sgZm9yIGFwcHMgdG8gY2hhbmdlIHRvIGVuYWJsZSBzaGFk
b3cNCnN0YWNrIGFuZCB3ZSBzaG91bGQgYXZvaWQgZG9pbmcgYW55dGhpbmcgdG9vIGF3a3dhcmQg
aW4gcHVyc3VpdCBvZg0KZ2V0dGluZyBpdCB0byB3b3JrIGNvbXBsZXRlbHkgdHJhbnNwYXJlbnRs
eS4NCg0KRm9yIHVjb250ZXh0LCB0aGVyZSB3YXMgc29tZSBkaXNjdXNzaW9uIGFib3V0IGltcGxl
bWVudGluZyBjaGFuZ2VzIHRvDQp0aGUgaW50ZXJmYWNlIG1ha2Vjb250ZXh0KCkgaW50ZXJmYWNl
IHRoYXQgYWxsb3dzIHRoZSBhcHAgdG8gYWxsb2NhdGUNCmFuZCBtYW5hZ2UgdGhlaXIgb3duIHNo
YWRvdyBzdGFja3MuIFNvIHRoZXkgd291bGQgYmUgcmVzcG9uc2libGUgZm9yDQpmcmVlaW5nIGFu
ZCBhbGxvY2F0aW5nIHRoZSBzaGFkb3cgc3RhY2tzLiBJdCBzZWVtcyBhIGxpdHRsZSBtb3JlDQpz
dHJhaWdodGZvcndhcmQuDQoNCg0KRm9yIHg4NiwgZHVlIHRvIHNvbWUgZXhpc3RpbmcgR0NDIGJp
bmFyaWVzIHRoYXQganVtcGVkIGFoZWFkIG9mIHRoZQ0Ka2VybmVsIHN1cHBvcnQsIGl0IHdpbGwg
bGlrZWx5IHJlcXVpcmUgYW4gQUJJIG9wdC1pbiB0byBlbmFibGUgYWx0DQpzaGFkb3cgc3RhY2tz
LiBTbyBhbHQgc2hhZG93IHN0YWNrIHN1cHBvcnQgZGVzaWduIGlzIHN0aWxsIHByZXR0eSBvcGVu
DQpvbiB0aGUgeDg2IHNpZGUuIFZlcnkgZ2xhZCB0byBnZXQgYnJvYWRlciBpbnB1dCBvbiBpdC4N
Cg0KPiANCj4gS2VybmVsLWFsbG9jYXRlZCBzaGFkb3cgc3RhY2tzIHdpdGggYSB1bmlxdWUgVk0g
dHlwZSBhcmUgc3RpbGwgdXNlZnVsDQo+IHNpbmNlDQo+IHRoZXkgYWxsb3dzIHN0cmF5IHdyaXRl
cyB0byBjcmFzaCBhdCB0aGUgdGltZSB0aGUgc3RyYXkgd3JpdGUgaXMNCj4gcGVyZm9ybWVkLA0K
PiByYXRoZXIgdGhhbiBkZWxheWluZyB0aGUgY3Jhc2ggdW50aWwgdGhlIG5leHQgc2hhZG93IHN0
YWNrIHJlYWQuDQo+IA0KPiBUaGUgcHRocmVhZCBhbmQgbWFrZWNvbnRleHQgY2hhbmdlcyBjb3Vs
ZCBiZSBwdXJlbHkgbGliYyBzaWRlLCBidXQgd2UNCj4gd291bGQNCj4gbmVlZCBrZXJuZWwgc3Vw
cG9ydCBmb3Igc2lnYWx0c3RhY2sgYW5kIHBhZ2UgdXNhZ2UgY2hhbmdlcy4NCj4gDQo+IEx1Y2tp
bHksIHRoZXJlIGlzIG5vIG5lZWQgdG8gc3VwcG9ydCBzdGFja3Mgd2hpY2ggYXJlIHNpbXVsdGFu
ZW91c2x5DQo+IHVzZWQNCj4gZnJvbSBtb3JlIHRoYW4gb25lIHByb2Nlc3MsIHNvICJpcyB0aGlz
IGEgc2hhZG93IHN0YWNrIHBhZ2UiIGNhbiBiZQ0KPiB0cmFja2VkDQo+IHB1cmVseSBhdCB0aGUg
dm1hL3B0ZSBsZXZlbCB3aXRob3V0IGFueSBuZWVkIHRvIGludm9sdmUgdGhlIGlub2RlLsKgDQo+
IFBPU0lYDQo+IGV4cGxpY2l0bHkgYWxsb3dzIHVzaW5nIG1tYXAgdG8gb2J0YWluIHN0YWNrIG1l
bW9yeSBhbmQgZG9lcyBub3QNCj4gZm9yYmlkDQo+IE1BUF9TSEFSRUQ7IEkgY29uc2lkZXIgdGhp
cyBzdWZmaWNpZW50bHkgcGVydmVyc2UgYXBwbGljYXRpb24NCj4gYmVoYXZpb3IgdGhhdA0KPiBp
dCBpcyBub3QgbmVjZXNzYXJ5IHRvIGVuc3VyZSBleGNsdXNpdmUgdXNlIG9mIHRoZSB1bmRlcmx5
aW5nIHBhZ2VzDQo+IHdoaWxlDQo+IGEgc2hhZG93IHN0YWNrIHB0ZSBleGlzdHMuwqAgKEFwcGxp
Y2F0aW9ucyB0aGF0IHVzZSBNQVBfU0hBUkVEIGZvcg0KPiBzdGFja3MNCj4gZG8gbm90IGdldCB0
aGUgZnVsbCBiZW5lZml0IG9mIHRoZSBzaGFkb3cgc3RhY2sgYnV0IHRoZXkga2VlcA0KPiBQT1NJ
WC4xLTIwMDQNCj4gY29uZm9ybWFuY2UsIGFwcGxpY2F0aW9ucyB0aGF0IGFsbG9jYXRlIHN0YWNr
cyBleGNsdXNpdmVseSBpbg0KPiBNQVBfUFJJVkFURQ0KPiBtZW1vcnkgbG9zZSBubyBzZWN1cml0
eS4pDQoNCk9uIHg4NiB3ZSBkb24ndCBzdXBwb3J0IE1BUF9TSEFSRUQgc2hhZG93IHN0YWNrcy4g
VGhlcmUgaXMgYSB3aG9sZQ0Kc25hcmwgYXJvdW5kIHRoZSBkaXJ0eSBiaXQgaW4gdGhlIFBURS4g
SSdtIG5vdCBzdXJlIGl0J3MgaW1wb3NzaWJsZSBidXQNCml0IHdhcyBnbGFkbHkgYXZvaWRlZC4g
VGhlcmUgaXMgYWxzbyBhIGJlbmVmaXQgaW4gYXZvaWRpbmcgaGF2aW5nIHRoZW0NCmdldCBtYXBw
ZWQgYXMgd3JpdGFibGUgaW4gYSBkaWZmZXJlbnQgY29udGV4dC4NCg0KPiANCj4gVGhlIGxhcmdl
c3QgY29tcGxpY2F0aW9uIG9mIHRoaXMgc2NoZW1lIGlzIGxpa2VseSB0byBiZSB0aGF0IHRoZQ0K
PiBzaGFkb3cNCj4gc3RhY2sgdXNhZ2UgcHJvcGVydHkgb2YgYSBwYWdlIG5lZWRzIHRvIHN1cnZp
dmUgdGhlIHBhZ2UgYmVpbmcNCj4gc3dhcHBlZCBvdXQNCj4gYW5kIGJhY2sgaW4sIHdoaWNoIGxp
a2VseSBtZWFucyB0aGF0IGl0IG11c3QgYmUgcHJlc2VudCBpbiB0aGUgc3dhcA0KPiBQVEUuDQo+
IA0KPiBJIGFtIHN1YnN0YW50aWFsbHkgbGVzcyBmYW1pbGlhciB3aXRoIEdDUyBhbmQgU0hTVEsg
dGhhbiB3aXRoDQo+IFppY2Zpc3MuDQo+IEl0IGlzIGxpa2VseSB0aGF0IGEgc3lzY2FsbCBvciBv
dGhlciBtZWNoYW5pc20gaXMgbmVlZGVkIHRvDQo+IGluaXRpYWxpemUgdGhlDQo+IHNoYWRvdyBz
dGFjayBpbiBmbGV4aWJsZSBtZW1vcnkgZm9yIG1ha2Vjb250ZXh0Lg0KDQpUaGUgdWNvbnRleHQg
c3RhY2tzIChhbmQgYWx0IHNoYWRvdyBzdGFja3MgaXMgdGhlIHBsYW4pIG5lZWQgdG8gaGF2ZSBh
DQoicmVzdG9yZSB0b2tlbiIuIFNvLCB5ZWEsIHlvdSB3b3VsZCBwcm9iYWJseSBuZWVkIHNvbWUg
c3lzY2FsbCB0bw0KImNvbnZlcnQiIHRoZSBub3JtYWwgc3RhY2sgbWVtb3J5IGludG8gc2hhZG93
IHN0YWNrIHdpdGggYSByZXN0b3JlDQp0b2tlbi4NCg0KPiANCj4gSXMgdGhlcmUgaW50ZXJlc3Qg
b24gdGhlIGtlcm5lbCBzaWRlIG9uIGhhdmluZyBtZWNoYW5pc21zIHRvIGZ1bGx5DQo+IHN1cHBv
cnQNCj4gUE9TSVguMS0yMDA0IHdpdGggR0NTIG9yIFppY2Zpc3MgZW5hYmxlZD8NCg0KQ2FuIHlv
dSBjbGFyaWZ5LCBpcyB0aGUgZ29hbCB0byBtZWV0IGNvbXBhdGliaWxpdHkgd2l0aCB0aGUgc3Bl
YyBvciB0cnkNCnRvIG1ha2UgbW9yZSBhcHBzIHJ1biB3aXRoIHNoYWRvdyBzdGFjayBhdXRvbWF0
aWNhbGx5Pw0K

