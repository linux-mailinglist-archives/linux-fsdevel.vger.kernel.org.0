Return-Path: <linux-fsdevel+bounces-12190-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 265B685CC16
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 00:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93DA51F231AE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 23:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B8C9154C0D;
	Tue, 20 Feb 2024 23:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iwGQq84l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0050178688;
	Tue, 20 Feb 2024 23:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708471859; cv=fail; b=RkJpFqatNgVRwoI3hcxdGzsh9ygglb3JYLCrMGToiCVm0K2UBO7OBi5tveIFMUBeXuv4OUIQ4fEiDzgqrrDObZzun74SHkZjk40G4AJblonfBTR8KyvtNornXS1zwScTYnUR5GIvM2o3fEmpn8O3Npj5rqLDDIUOcITUJzGOZ/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708471859; c=relaxed/simple;
	bh=omKYy//wgGK+wKrI0FBmHGqpEz8nrdq6ozOCoegNdrI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZVr9FGDR5AprrCeGXbBh7GjEQbQdOeQ527VxrFHPLiDXCsQyr3sHpEDTDQtEdwDVPqU6V55vY61ObpSWSHRaiMHMSWkFPSFS7D52XVVeFaDtRBijT/oeAItnveRXXqlFXpb3NQzs/2ZZxZtq23Wmp/OS7CCmakQwJXXyzndtkxk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iwGQq84l; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708471858; x=1740007858;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=omKYy//wgGK+wKrI0FBmHGqpEz8nrdq6ozOCoegNdrI=;
  b=iwGQq84lPYcfgio/wZG6DqPMN6y2+81ZNd8DzvYfpCSYuMrkXaRXpfml
   MJrJ77fLUsN0I+kxdofkcPOEvDjbf5GKfvYNF3PthtIWGYiH6lXjo7Epq
   1xYRn+tMXXdOr8dXxZ+GuC8M05EzqAz2objqjw/AxKnPbxuJs3Oxt0YJK
   CZb8ycub0bJt1rnTL/pJZNanRsP+5JrOdEgM3n4tVN2mJzQlDmTcVcnrT
   QCHd5fuWHKTlPpHtiBMjHZ/8nxmNb2w1v7H4ZBCeHmusF32nYC8jeUt7l
   QegTpYD1IP0JbQ9mJw5MAgE8pvuPwM4aKcr9KolXuFWKR+QLez9PxHiZC
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="5562231"
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="5562231"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 15:30:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="5236416"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Feb 2024 15:30:56 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 20 Feb 2024 15:30:55 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 20 Feb 2024 15:30:55 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 20 Feb 2024 15:30:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IsL5KK3aTP+gX+nre/+wCYnSUlIqBkjHbiP3rZPvaLnNQvf8a10O1ZVJrtCC9ZpxuKP9IqCHWI5ZBzk4IlQ3mblKUE/MegA5zGAvmCuAWM8CEDq/G3Ypcm4TZQp0s6ZHmCeKq6xOeg7TmglZbsYbkwhl9hKJ2k/spH0jeqQcWyUoTCpwDr2OV61QzqQdFZxzSZsEVO13XPxrHl+UzSCSvtjdmygS+punanfrlqZWlCyt25fwsV+5qNqm1HYaQ0mtcP6VCyUAhVfjJR6eVQqD5aIUYQEeWnVx7sOG3hzn6A3TGQuf9io2kbuRtnGPRwZu/8wGPEGsiFk7z3USoCImbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=omKYy//wgGK+wKrI0FBmHGqpEz8nrdq6ozOCoegNdrI=;
 b=enX54HWc4LQ88oOArliR5+ct/k4j5f9Ypmha7hBiLMowOJcuGXlqHlCho4swrkVQKLKFDJA7BGpU8ccsfKAvKlbGswGQzRZc2QSxW2KwCarKxiuUkfDy4TrtksMbG2bV4z45DVb7xOUKodv4hhAnj2cXhIlp7/R62Z035U6WMVMZ+4VOjZ/h1Jj+fJqLytMTmO2cujwRLB1iAo5iAjLOKaw+dyCmQiR0D94C2L8dsVNOjYGYb1Ljq78CQ/kHXr+z9vbBS7IZoPUmamo6VbJLiapIHQeA/hofCxnJXHQo4qx8WLagIXRBg7bQxTR2oHYlgGroN4lIN/BMOM9iTf+Tuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by CH3PR11MB8442.namprd11.prod.outlook.com (2603:10b6:610:1ae::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Tue, 20 Feb
 2024 23:30:53 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::5d40:83fd:94ac:d409]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::5d40:83fd:94ac:d409%7]) with mapi id 15.20.7316.018; Tue, 20 Feb 2024
 23:30:53 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "broonie@kernel.org" <broonie@kernel.org>
CC: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
	"suzuki.poulose@arm.com" <suzuki.poulose@arm.com>, "Szabolcs.Nagy@arm.com"
	<Szabolcs.Nagy@arm.com>, "musl@lists.openwall.com" <musl@lists.openwall.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>, "corbet@lwn.net"
	<corbet@lwn.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kvmarm@lists.linux.dev"
	<kvmarm@lists.linux.dev>, "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
	"palmer@dabbelt.com" <palmer@dabbelt.com>, "debug@rivosinc.com"
	<debug@rivosinc.com>, "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
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
	<linux-doc@vger.kernel.org>, "sorear@fastmail.com" <sorear@fastmail.com>
Subject: Re: [PATCH v8 00/38] arm64/gcs: Provide support for GCS in userspace
Thread-Topic: [PATCH v8 00/38] arm64/gcs: Provide support for GCS in userspace
Thread-Index: AQHaVpxQxL7eT1mQek6VcjPJOSVEZ7ETiLSAgAAiyYCAABocAIAANt0A
Date: Tue, 20 Feb 2024 23:30:53 +0000
Message-ID: <feeb353566149eb807812ee74ba64d3238183b64.camel@intel.com>
References: <20240203-arm64-gcs-v8-0-c9fec77673ef@kernel.org>
	 <22a53b78-10d7-4a5a-a01e-b2f3a8c22e94@app.fastmail.com>
	 <4c7bdf8fde9cc45174f10b9221fa58ffb450b755.camel@intel.com>
	 <527e2b4d-5d2b-4993-a30a-834e77a23a40@sirena.org.uk>
In-Reply-To: <527e2b4d-5d2b-4993-a30a-834e77a23a40@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|CH3PR11MB8442:EE_
x-ms-office365-filtering-correlation-id: e5b4e2ce-4ed5-4ed0-e908-08dc326bfb20
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wzL8swXKrtdm37Agjh6PUzwXiMwDbvMcGUO9ydGnyy88WPUSGK/jvcbzvFDWndGFfclCNTEgZlslga1Z2Um48dSbTGop/j2ZGcIbiNTA++p64RtMODCf50oUqTmEYLiGAWsPVutCYKT8fLS5rH0RcWz0OWY3WeBY99dmLT3JX68W8nAvBUCWYQPuWZu98Ra6XDVtc8heCNgoEXIY0TAsmQ7l+jxA8boqOcLSql4s2XE1NlY+zpIubaU1mF1DVP1KGghNqPHuam+kZRAWRYMz86yJgjUFhpv9HIFoRGmFDbfpkTf8Bias5cYZu9fNZlXsWfCHp72VIDpL/ZpcOZWi18cjrXeOv3tLpMYk31E9o/Ga/Ll00Ip/oCxVpEU3egbiDNF0tutpUATxGdsEH4p8lCs9BuwAS4LT79UrBzuepJowYVkKK7f0cExJtNv/NNfcx8KmgRSsWPPhCsLDbBcfk8aygjzE8YmdQhre9lBPswvL102RCjiFQRtMRhrIBlryOiXOfqwxZGKNZvAqEji9zhig31gErWi0u4zrP07EKcF+S0LJD2uJnfRy3XcU/+QNFyD3m5Gq5Z3Cqz9NiJSWgzW6/wtrC1Bf5fccvYSSrPt2Skun3SD5QGuJbaX8EBpk
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eStWOUpKTDZKSC9ocXljT0VNVzdodkNyVDlhYlk1TC8wc3dhRmpIWWFaWFVF?=
 =?utf-8?B?R2NXU0t1ZG9KMW9qUXAreTRWMTVjUmNGSTFaQU90TXUybUFvQ3NnU3lBd1A0?=
 =?utf-8?B?OS9XK1NoNkNSamlUc2hZWlFtVGMxNVEzNVc1UmVvUkFvUitWQUVia3AzSEc4?=
 =?utf-8?B?QndrQWZHUEpmOFhTOWk3eDU3STdWejRwbFRIUG9RVVprZXd5MDI1RmRheWE0?=
 =?utf-8?B?NWVNaDdLWHBCL29vTDFNUjBpbEw5Ym9CSldWQmF4L2orNTZLWVRNN05jQ28v?=
 =?utf-8?B?VFhZUDEyUUc3U055dXcxVVhIbWlCcmw4eUl5UmUxMzc1dlJwOTM1UzhhdlZM?=
 =?utf-8?B?U1hnY3Flc1YrMXlSYlFkdWladU9CVVlVMU02VEhlNEVjSGtVYk5QdE1hWXdq?=
 =?utf-8?B?ejFoTEFBeHFRcTU3NVpQTGk2Z2lrM3ZGOEZBMjY3ME9OU3hiSEMzS3Y1UGVY?=
 =?utf-8?B?REVya0xOZVVIRWszZDNvcnpLb0lOeDZJbVM3cDRQaXlZcjZhZHFod0UyTEl3?=
 =?utf-8?B?L09LcldoeG0yMEsrK2QxM2JWcHVVK2thREFIOWM1QjhrZCt1UjV5N1NRdjdN?=
 =?utf-8?B?N09QRDVDZUFPT3M1U0F6VTFKTWlpQUgrQ012cERETEhGRktyc3dwaTNwNkJZ?=
 =?utf-8?B?ZVR2cVZUR1k5SXhYbDMvbmRDOHRPVTFRT00vVkFwd0hOZWNoOUJmeXp6QzZo?=
 =?utf-8?B?UzR3aTFtbnptZ1Y2T1pyY3AydXBrSTBFNnN6cmdTb2FKUVZuek4vL1oyYVVV?=
 =?utf-8?B?QWxEUWVpVDJGTDlGVVFvTTAraE4yRzhVWUNwa2NSb29CWWdmUEtzS2pnWklK?=
 =?utf-8?B?Q3RCRm5JU3Rzc2JlazMvOWxZQ2lTOTUvQ1A4RmRWYnVZZWhWZFNZVjlvdkVz?=
 =?utf-8?B?TFpMNDh5L25EUGRQM2dpaXhtUk50WjRqRlpmWFhyNXlYWk5nZ2lLZkYxYzhZ?=
 =?utf-8?B?SHgvUDhSQmpIM0pmdFpDS2xITXJjMFhCQmx4MjQzNythdHJ0czdxalZpaVVK?=
 =?utf-8?B?M2VMVjNrVnRZLzVseW9HTUNUV05JbHc3cktOM0k5M2d0aVBPZWZ3bTlGMjA3?=
 =?utf-8?B?cE84bm9RMEovRFY4TFljSUgvWFRBcmQ5RVB3MnZNOWZzeUIvU29BcS9SUUdW?=
 =?utf-8?B?NGdEeEhuSG5Oem9Ya2FuVCtvYlM1TzdrYUVjcXRBUG9ubDZOVUV6eVdZZ2VP?=
 =?utf-8?B?cHdtZjJIRlV4SnF2WUJ1a2FVZFkrK21IcVRSUWYzanpRYXlKaDdvSTZweDhD?=
 =?utf-8?B?aVQ5d21LVW5TM3g1YkpmdFFCcVBzRlV1Q2hwZEpYRjBXcFVVTkRxS0s5QW9E?=
 =?utf-8?B?VUdjZW84RHN0MGw0ZXRZRFdqa0o0RmJwdEh3NUFmSDNnZ2h5L2luRzVsUkJk?=
 =?utf-8?B?N2RsbjNDQTI4aHFWcGNXVVhkaDBzUzg3Z1F2OW9GcllWNUQ1UjFYTFo2N096?=
 =?utf-8?B?elFpMFlIcWVEamkxbE9JRFVwbUNTcGZ6RFY4Z3lqQkpZNkllTG5rRFBkWDl6?=
 =?utf-8?B?bUh2MEZLMkZ4TXhjbE02MVBNK0hkOURSeHVaRjduZWZMMjd1emxwOEhsOHZl?=
 =?utf-8?B?aWN0ODhROUxmUmIvL2s0b1pTS0Vrb3kwR05md3RMb1pkT004OXJkalVNNFhR?=
 =?utf-8?B?cDNCdUNGU1NZdVhGdjVXd0dvSzd5MnRIbEtCWk43QURHZlUydll2TXZINmlN?=
 =?utf-8?B?QXZzY1hIM1IxVEYrcEc2c1o5RmRHRVhRQ0dORjdqR3VObHp5VkVTbkxIUit1?=
 =?utf-8?B?WTgvUXpoWEJQTFB5QjhaVlZ6Z2lKZlZpU2FUdEhUWE5VVGYzTlJkZmJ4cGlU?=
 =?utf-8?B?aXRJaEh0VERxV1EvSFRaTU1QamJlSEVJL1dLdWV1bis0aDV1RER6VWFhQmRs?=
 =?utf-8?B?ekNIbVJUcFNyTmx0NjJmQVJRQjNGT01CTWIzK1NGcXhxRGNvdWRScXE1UExx?=
 =?utf-8?B?WFUwZE16a2tKQ1Q2NTlMbER1N0hDTVhvNDJiM1I4RDFsTHRnWmNxMWJpR3Iz?=
 =?utf-8?B?UGc2UjZXT0ppbUd5UXBQR3lpamVycnVES3RMQUxSeG1ka09aWWxVdE1aM1I5?=
 =?utf-8?B?R0J6MnA0WW5mMElKZlI5UG1JMDB2U1drY1lGOGtJamRaT2llMkpRMmN3TXZm?=
 =?utf-8?B?TjhRNldSZDhUN1BQM1lJVFAwSDlWU1oxenpYMVlsQ21ZS2VWSHBFTHdYNHZU?=
 =?utf-8?B?Vnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <45288A8D870226429F531F9EEC397106@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5b4e2ce-4ed5-4ed0-e908-08dc326bfb20
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2024 23:30:53.5838
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IR56EuIGbyYIkw7m3t753M5ylsVadGXEQyyJTpTFDtGeyNLHkHMVHJuEeN3uShVEQQPAjmdyAC+DpaGLX6gfO5LlD1rlWmWicPLOjhVsQ5s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8442
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI0LTAyLTIwIGF0IDIwOjE0ICswMDAwLCBNYXJrIEJyb3duIHdyb3RlOg0KPiA+
IEhtbSwgY291bGQgdGhlIHNoYWRvdyBzdGFjayB1bmRlcmZsb3cgb250byB0aGUgcmVhbCBzdGFj
ayB0aGVuPyBOb3QNCj4gPiBzdXJlIGhvdyBiYWQgdGhhdCBpcy4gSU5DU1NQIChpbmNyZW1lbnRp
bmcgdGhlIFNTUCByZWdpc3RlciBvbiB4ODYpDQo+ID4gbG9vcHMgYXJlIG5vdCByYXJlIHNvIGl0
IHNlZW1zIGxpa2Ugc29tZXRoaW5nIHRoYXQgY291bGQgaGFwcGVuLg0KPiANCj4gWWVzLCB0aGV5
J2QgdHJhc2ggYW55IHBhZ2VzIG9mIG5vcm1hbCBzdGFjayB0aGV5IHRvdWNoIGFzIHRoZXkgZG8g
c28NCj4gYnV0DQo+IG90aGVyd2lzZSBzZWVtcyBzaW1pbGFyIHRvIG92ZXJmbG93Lg0KDQpJIHdh
cyB0aGlua2luZyBpbiB0aGUgbm9ybWFsIGJ1ZmZlciBvdmVyZmxvdyBjYXNlIHRoZXJlIGlzIGEg
Z3VhcmQgZ2FwDQphdCB0aGUgZW5kIG9mIHRoZSBzdGFjaywgYnV0IGluIHRoaXMgY2FzZSB0aGUg
c2hhZG93IHN0YWNrIGlzIGRpcmVjdGx5DQphZGphY2VudCB0byB0aGUgcmVndWxhciBzdGFjay4g
SXQncyBwcm9iYWJseSBhIG1pbm9yIHBvaW50Lg0K

