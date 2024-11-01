Return-Path: <linux-fsdevel+bounces-33504-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D81519B9A60
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 22:50:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E48D1F2291A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 21:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC831EF93E;
	Fri,  1 Nov 2024 21:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DRQD73Od"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002F91EABA6;
	Fri,  1 Nov 2024 21:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730497656; cv=fail; b=jOHKqHvkAMTT4wroROgiHLCn4rHe4Ssx9G/jovsbPez1oJ5FdN7UWX4AH7xhtxFCdT2cprhYwugIMOrmBe1EMc+XFboF/qbTyirkM18UXq8BnA6ecNYglRiXxXFpe0uWpU1knnkG+kXzRonIlCxscfGGfIcc7Qm0y9W6NVtH5HU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730497656; c=relaxed/simple;
	bh=idDZDFsKXbnpfFymmAPd7I548090+r/cFIJ/KnH5UNs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lQVBIX7OjpkZEI0TITUhm2IMrwdLcXyI4fc4r1AmHtYZAXMZ+BJPe2vbzI0uvSORlVK8L7PYJfwk04FlnQLyrtD4m47xgFZcy8MDCJmdqJ1t0KrhpLfpifRoVHTZFn7IkJ1AWU/ozTBNYQAo7NsZc1Io5B9U0pPNEJvsRIJyIJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DRQD73Od; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730497654; x=1762033654;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=idDZDFsKXbnpfFymmAPd7I548090+r/cFIJ/KnH5UNs=;
  b=DRQD73OduBauJPMjUCAF+7g8VjSJtvDe4m5ZzdLM21e3wO+umrqSSRfj
   e0M++0ez143xAi/qxlIox59zlzn0ldip0Pf1dmwlWFgWLzEFzYQoZFe1p
   zryYrnUISMl2L4yUnnUybcmQW6QQKl0skUslD/ibhvuzdhaCDZkXwblAs
   oO11WY0r3Y8Zwi7wHLefVhJE6I1xItGDK9FTumEU8ruO3N5WgCTY45W0O
   z9jmvO4aDg4/Go9T5Mfbd+Gc6TDVLs/I0DRdSb+1Lbwrt/Ybka/zVwbgo
   G6eyn9W83+wh+rsqYTzDBIBkGyQcpWtcJpcAMAr6nncjU6YA8N3v4QDHN
   A==;
X-CSE-ConnectionGUID: gpPRhlaZQres1u3OO+XZ2w==
X-CSE-MsgGUID: djKzyphWQra5t629F//B+g==
X-IronPort-AV: E=McAfee;i="6700,10204,11243"; a="34065238"
X-IronPort-AV: E=Sophos;i="6.11,251,1725346800"; 
   d="scan'208";a="34065238"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2024 14:47:34 -0700
X-CSE-ConnectionGUID: P+SjG3cmSPuHRUK3RYLlkg==
X-CSE-MsgGUID: my1ohWpxTR+NFOPyrn9rwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,251,1725346800"; 
   d="scan'208";a="83203544"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Nov 2024 14:47:34 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 1 Nov 2024 14:47:33 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 1 Nov 2024 14:47:33 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.173)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 1 Nov 2024 14:47:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tCnWhmywVDAVqe/fZeMWoq5/N1gJUU07IwqM7T94buvl5lMmZJnlwv1kafEGuoSQVkQfpDilGJ9L29ta0/QiA0Fw4lXzBS67pKRLZQkV65YReAldidr9eygRH2aqgQRj4KSVa848C3ELK46CHTdbBzHcF7p6WVAztJpYv7J541m84MBiG+R49a7Dl2hdgjkqDzKWNFYLqMUC7yQxYKVMXUA7iMA70E2AW4EZPiI7K45bDBONVkGWbnwRAENm+xFApUTpz+X/+tV5JKS/Ri70FKx25N6hjt+CnX0lvEWyUSHweYnqq8m/o6AsDVG+xSfyswM4lpOxiLavnwwbCi6Ncg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=idDZDFsKXbnpfFymmAPd7I548090+r/cFIJ/KnH5UNs=;
 b=QVEMJo3J+7rCDMrgyOO7dGwEp1ndOnsAlhEnZdkvd4srOjVq4iBNBnAnMn3jxqKoTLc0qEwmn1xlQRWYzJMBZavHQrBjJ7/eM6ELfY3DpggJsJlxcxkhycmGLEHuHKcqHAMFvNat1QssND4avwtsQpZKo2jkoZc5FdoYPH7EgrxBB/Y20+/aVgq9mTbe+9Ya6WTJIvDd0XzJh/SMHebDziCp12xOIKPgqmT2Z6Ljp857oCGcYaFbBqOGjUp8Fv2K2y5oIkTmoX78NhsMQHcqSVSWwn1mMZjuH5aNX4e51EY43TfU0ZzKPjgcF7JIUYcJbv5RwW95+u71zAUI44Opng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by CH3PR11MB7276.namprd11.prod.outlook.com (2603:10b6:610:14b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.24; Fri, 1 Nov
 2024 21:47:31 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%4]) with mapi id 15.20.8093.027; Fri, 1 Nov 2024
 21:47:31 +0000
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
Subject: Re: [PATCH RFC/RFT v2 0/2] Converge common flows for cpu assisted
 shadow stack
Thread-Topic: [PATCH RFC/RFT v2 0/2] Converge common flows for cpu assisted
 shadow stack
Thread-Index: AQHbIBZ2sUCYeXXHvU62aFNE99XN4bKjDx8A
Date: Fri, 1 Nov 2024 21:47:31 +0000
Message-ID: <964caf1797be61001901b92e3b71259443d3196f.camel@intel.com>
References: <20241016-shstk_converge-v2-0-c41536eb5c3b@rivosinc.com>
In-Reply-To: <20241016-shstk_converge-v2-0-c41536eb5c3b@rivosinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|CH3PR11MB7276:EE_
x-ms-office365-filtering-correlation-id: 7a36e6c4-dd7a-4baf-1088-08dcfabec980
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?VW56ckpiM3EyTkQzMnVRNS9wV1d1MEhsUDRKY3BvTUU4Ynl3ZS84eXNnMVNH?=
 =?utf-8?B?QXIwVlNVY3dzcHpvWEUvWkxYZDJTNUpPaFVva0RWc0YwSlBsWm5sYXpjMG5j?=
 =?utf-8?B?aUovQmIwc1IzN0dTdlNBci9rUWlqbEoxNWwxeFpKYU5WekRSRmNGdmowNkZM?=
 =?utf-8?B?OVZaVnV5VTRmYXVrcS9qbXQrOWY1VHpYQ0lobk96SllhUklmZngreEQrNm8y?=
 =?utf-8?B?Z1hYZTVGaEkxSVZ4QjJ6Mk5rTDlNZ1dFNGZDa0F1WDg0VHFKZUJ2YTg0cnJy?=
 =?utf-8?B?VWVsK2VFQ3R4eDBaNG5qUXJFZnVxcjNSSWFaeXI0azJZdGlKenFkNDIxV2Fh?=
 =?utf-8?B?QjNwRWxVVFlBd0Z4NnZtTERZNnVaaXh1YzlQUmM5TTlJNFgwWEs5aERRTit1?=
 =?utf-8?B?Q0E1U3cvb1dOenFCSVJwMlJYTWl6cGp5L2cvSUtXY3piTDMzNnNZdHYxR0JN?=
 =?utf-8?B?dVFwbmhYem9BQzRJWWJUTUFFTE8rSkt0aGt1UVFoTUp3NHJVRmZqaytpdS9M?=
 =?utf-8?B?L1piUDFBZzV5L0Uvd3FrMVJ6NEZxcGdGNDF1aTlWSXYvejZ4NGc5amhqemRz?=
 =?utf-8?B?bnlnMjhDeThVZ1N0ODVKdXdrci9EMWFrRE9MdzQyK1JjRnVUU1lqc2VPaGlX?=
 =?utf-8?B?dG9CYUI4ZEVna1ZjRUk0QXViekJ0NG9HSndMSlBIYVlCNmFjcjV1b3p3VnFK?=
 =?utf-8?B?SFBHTU1lR0VlZkpGRmhEVTU3anZMbFg3L0RRWVd3a1NMOEo0QW56VXBxbjc5?=
 =?utf-8?B?c0ZnVFRWY1RVRDhTSDY1cm9CZWZHUGp0eVBSMmpzb3lKMTN2ZGtuSisvb3BC?=
 =?utf-8?B?UEU2eTZTMXFhVlovR2oyblBLczBuNmlKSS9naGNXcEpNcVVKOTQ2NW42OVJY?=
 =?utf-8?B?QTZBdlIwWCtSN0VieXdEOVBZcU9UU1J0OFNuVmlLNHlBMk1pbGtyUThhaW5t?=
 =?utf-8?B?Wmpad1YrMW1veVRGRmtvbEVYdTIwMUJCYUdUc0JqeHhNUmlTa1ZFK2xSekhx?=
 =?utf-8?B?Z3YvdjhMVW1vOHZ0SGN6NVM2cmt2Y0xVc1pWV0x0K1R0VVM3U0FIODFqUlZl?=
 =?utf-8?B?d1ZhdGx6NDE4VUxiM2V3V1hCZXY0RDlYMjZEWGpRNzlIcEQ1cnFsQ2hHc1Jo?=
 =?utf-8?B?OVhhbndPL0FOQ2ZDYUNuUVBxZjEralZuMlRzWkVoSFd0VVBmUHlXZE5pWXAr?=
 =?utf-8?B?bDU5WDhpMlAwNWorSG11QVN3REpIalNuQXVzQzJocVlOUkFiTmt0QW9rUWFE?=
 =?utf-8?B?RXpTRVFwSDN0SWlFS1VuN0daM2sxVGJ4V2tGTHZXNjVDQkZyTkE3THlyQWw4?=
 =?utf-8?B?cFhQeFRQNHhUZ2g1UUM0R0M1RHQvMEtkSGh1ZDlzTGo0U3hHNWdyRjYvY05y?=
 =?utf-8?B?Q3YyR1V0UnZBbmVrOWZqSmk1dmh6bkZTdWU5Vk5qZFpJWjR1WU5HYktpK1hr?=
 =?utf-8?B?SW4ydzNBZ1ozdmJ5bjBXamh5ZUY1YkN6NXRhVmtPL2lJOWluSkVObUZ3M2dT?=
 =?utf-8?B?ZHBsVjlvKzZOQytTTzlqck8zK29yY0tnVisyU0pvZis3RE5IV1lJZWY1TDNn?=
 =?utf-8?B?NklsRE96WlB0emV1eXBwUUZZVEM2dkpJM0cwM295SHgxU2ZWblB0dExKZ3Fk?=
 =?utf-8?B?aDRIUCtGWVJOSUdTQVdOM0tuR3hmTjUybTVROUlJWm9GTzRySjh1SGR4a0Nu?=
 =?utf-8?B?dzY2Ym1PWHJXaUZ6cGZQNnQwcFNYazYyUzlDV1k3RlJYZVVSNy9sUkhNaFJI?=
 =?utf-8?B?ak5kYUhlWnhGMnhHRE1BNWxhdHVuR0RaQ3MzUWMwaXhXSGI5bFJwMVI0RVM4?=
 =?utf-8?B?bitYano3d2R3UW5semtqekliS0MzdEJacmpaWFphOElITmUwZkhjdm5lbmlt?=
 =?utf-8?Q?oeV4/HjvHaO5V?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d2dMTUVIejBiM0prSkN0QUxLUlF4dXZOQ054ZHZiYVpUZGpGWkh0ekhsaUpX?=
 =?utf-8?B?WFZ5cm9hTlhDeHlJcFlsL2NHWVVpKytKQktqVnl0eGRvUE91OXlJMnRadkVq?=
 =?utf-8?B?MWJUV2ZCYURmbjFucGRNandaSDU1bytndVJEVkIvWDkrS25HbU1Wb0hjRmht?=
 =?utf-8?B?ck1YQkhiaDI1Z2dwYkJkdEJ5cXhNZjV4ZnBaRzdQbzFnRlFmRWRnM2tybyt5?=
 =?utf-8?B?Q0RCTHVuZi91L0dienVyT3dibWh3cS9od3ZCNkZTZWFpL1pXRUVadEVaTVlt?=
 =?utf-8?B?dFFjMDdqb0RXbHdWSW5jcFRiVGQ2QWlVSWVxSkVDUmN5eFp2RXZ5MUx1S09B?=
 =?utf-8?B?a0R2UjNqZEhlVjJBMmZPYjlZR25Sc1pZSXljWmhYa0lxZWdUYUxxUEZhM1BP?=
 =?utf-8?B?MXZuak5VOG9sanRRN0ZpdXJZanZnVzNTZTdOY212cHB3T1FQMnhzZmcxcTJ6?=
 =?utf-8?B?WTdqdlNxVVRocWJzSUJFSStWbDVLQXhrYWNZd243bVpScnZFbFFFL2wzQk9a?=
 =?utf-8?B?Zjd0OVg2akpGZ2tPUXQxdFRvdHBrL3lnakoxeitNbm4yRFJZajl5a1FONjB2?=
 =?utf-8?B?TnNuSmFZT1ZmemlUQS9vZzVVWjVVallSbjJBS0NjTURQT3dOZVhraTF4MERW?=
 =?utf-8?B?Zmd2Q0xiUDRGR1lPRFlBazJlcHpiRGdTdmFDZFJSU04rUVNxQXllOW4xVldl?=
 =?utf-8?B?VVR2VzE1VTRxWGJHcFZiMFNNZ01zRmQ0MzlnRTdyOGhDUy9wMDViTmRrWDhI?=
 =?utf-8?B?aDk5TjBkNjMzT0xGMkNXdkZocmtPWXZQM0RMR3B3d3dhTWhCRGh1WlBXejBn?=
 =?utf-8?B?ck1IRUJtSGp3Rk1DVjI2K0VPVmdFTjhCQXRJSWFDa3NJQzBPSm5iM1hSdytq?=
 =?utf-8?B?OXpKN2IzaWFMZVBUbnIrK2tsRnFveXM1a1FIRldxU3g5SUNZbGFXa0FhQ2Mx?=
 =?utf-8?B?OGpTK0RsN1BOSTAvTjVWaXRGdjdaTmFMLzJRcFpHZFhkUloyU1RITnRxTktv?=
 =?utf-8?B?MXBRRXYrMWFrZUw3U01XWHZVN0FHWHJ6NXVIangwRWdsQ3RVOFZQNlZYQmZw?=
 =?utf-8?B?Zit3NDJlWnJRVDZUOHZ0OVB0SHNEa1lNZlkzSTFRcE41Z2hMM1BSR3FMeTFl?=
 =?utf-8?B?TVJ1U1NBc2pjQ2lYc3JTMkUyTlpPamdKREVpcmxyNGY0YWs5KzNpY3ZjUmF1?=
 =?utf-8?B?RVhOR09yVmRBb2UxZmNTTWphVlk0UGFTbml3bkVHdDRSM0svczdHWUtMNDNY?=
 =?utf-8?B?ZzJjdkpWczE1b0ZiQisrckw5cUY3YXkvNzh3Uy9YaTVwSzBiRUtVNmVMNWto?=
 =?utf-8?B?Z2Rwd2JlNHFnck5HakVGZzZzNk9yZnhPVGFsUlozTFc3UDJiOFlEMWNUa3pY?=
 =?utf-8?B?VWZGbXl4bG41eTNQazVqc1Izb1pmTGJCN3NRUHJDZUJtYmluUXJQNHpGai9O?=
 =?utf-8?B?S3Q5Sk80R0x1dWwzSE1YdTFUYjAwcVQ2SDBKdEJsR1F3eGdkS2N4SGpOUmdn?=
 =?utf-8?B?SUxkNjFjdGhzVVJwZms2c1l4b2c0dXRwb1FTbjRnWFdpWVFBek81TVkxQldU?=
 =?utf-8?B?YThoc1UweklrUmZtdmdQNktEWDFjdHJaZCtWZllyQTZRRUc2K1VKenh0cSt2?=
 =?utf-8?B?R0lGbHdRNmtFUHpwNGVQU2VVdTB2ZlRzc0lXSjZ2Qjg2WWdZWmptc1hDM0sx?=
 =?utf-8?B?QU9TdWFUUEhlQlZGOXNUZERBLzFhZ2svdGMyMFoyb1oxMmNaNEJENGZGVTRM?=
 =?utf-8?B?ME1NeFlybXhUcGw1OTRmZ1hkclJ2aTVCNFBaV0pCQUhSTytiTFNDbkdZM1Y4?=
 =?utf-8?B?RnJreWdWUUpzRHVEYStqazFaKzl4c0JTWmhVQzBlNVRMZDVyMHdJUDhYSlhC?=
 =?utf-8?B?aGd1SDNzRktBbVNwS0M4czh5L1dUZjZoa2ZwRyt2Szh1c2kzTXhBaFhZWTlV?=
 =?utf-8?B?aFBmbjRZR2kwT2lnV3JHbGFkS2FWKzZ0eWRNY1RKM0VRU0JNem9xZ1dWeCtJ?=
 =?utf-8?B?RW1XSUNuSXJyK0hoMzBtWVhxdDh1eDJIOXA5V0hSSGp5VFpndVFUVVg1Qi9y?=
 =?utf-8?B?RmJsdWF3MnFFVGZWS3RkV2s0aWhVSlBhTTUwVU53aXJXWHpCN1NkVEFNck1n?=
 =?utf-8?B?Wm1wT3lJV0NSRUhwdkdxcHNvU0NmZkY3N2YwdGhmYUMxeE0rUDRPaXVjNFhT?=
 =?utf-8?B?Rnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4ECE8C5495B3904BA6009BC05BD777D5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a36e6c4-dd7a-4baf-1088-08dcfabec980
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2024 21:47:31.0626
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g7YRwdWS50VZM9+5Ye4PakZ6GMLg54/smw9av1yr/gpRSxgYJsDbC5MFcb/74u49uu2QIGVPoUqbjFd9gvbVpZPTRxQ/159lEUQkpaJjagE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7276
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI0LTEwLTE2IGF0IDE0OjU3IC0wNzAwLCBEZWVwYWsgR3VwdGEgd3JvdGU6DQo+
IC0tLQ0KPiBiYXNlLWNvbW1pdDogNGUwMTA1YWQwMTYxYjQyNjJiNTFmMDM0YTc1N2M0ODk5YzY0
NzQ4Nw0KPiBjaGFuZ2UtaWQ6IDIwMjQxMDEwLXNoc3RrX2NvbnZlcmdlLWFlZmJjYmVmNWQ3MQ0K
DQpXaGVyZSBjYW4gSSBmaW5kIHRoaXMgYmFzZSBjb21taXQ/DQo=

