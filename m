Return-Path: <linux-fsdevel+bounces-34857-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5634F9C9630
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 00:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBA741F22740
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 23:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C3D1B3953;
	Thu, 14 Nov 2024 23:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CeLH1w3g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765061AF4EE;
	Thu, 14 Nov 2024 23:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731627242; cv=fail; b=pAQe06YQE/9ZV93sEz1VfpzuM8ekqGXrcsLF6fHCSfVVwrA8tfQLy9/WApP/yzwM9ByOTS8p2UwpiQ0GbOdKU4f+JgetJ68B2GRxGwLK0qeRqgitI4uxBptaNsfFvlkf3M3a4ZFrj9uYGZNUmBVY09/ngiS0zzVKnNh6p5j73qM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731627242; c=relaxed/simple;
	bh=/FCD8K0scuzYaAjpUb8gg2OFHbFPhl7+Bw9fhxAojuM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=so1Wq+xQiTqlx5nkDMEUAFSWt1ZFjAYrci8NRRnaIP1r2l94sTq0c/rWdX7x19OT1eT6HjJQuRqM35yTgBO+2InZMDBKDTYZZ05aBTGoqWSaMT7kvhxOBJnC79c6m3+KCq3gnvEK9Y967LX/29QRKSP97T9BE4Vf2YvNEkyJojw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CeLH1w3g; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731627240; x=1763163240;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=/FCD8K0scuzYaAjpUb8gg2OFHbFPhl7+Bw9fhxAojuM=;
  b=CeLH1w3gEXpMAPF57ma7ayRW+TPR6FVaDBicpSkS4jhJb7Q2rMWJLRRp
   gnTNEQ8TdMe+Lo9CzDWGL0anjoUjhwZbitM3l7fEApLcmfpK86wKU5wq7
   t0Q/nUIx5pPMf/+hr1bo8XGV7r34QjM8jVU2tGsEenAIqWbg98h3P93VU
   /4hOorDiUAg/sDkhzdiuCB44TobsJzrL+HNx4jc0T+GCzbpzI2eait9rF
   wUMmFuNENOqDEeUS5BlVq1+xcbs1UqWPlIFU5QG6ie2hOv1d0DgRiB/tX
   5AuQbfdK8Ue5F4d5a5vxfuh6kHhGRqdjn6UulV2r3PmedE3VtOcrlFjrW
   Q==;
X-CSE-ConnectionGUID: zqBr1fuFSEWUlrgYnn7Avw==
X-CSE-MsgGUID: 1mnV19F7R32g115nhagwmg==
X-IronPort-AV: E=McAfee;i="6700,10204,11256"; a="34472390"
X-IronPort-AV: E=Sophos;i="6.12,155,1728975600"; 
   d="scan'208";a="34472390"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2024 15:33:59 -0800
X-CSE-ConnectionGUID: sjei2LqMT8qrHKsMZEKJZw==
X-CSE-MsgGUID: eJdEGl5yQYa1hGxowb1W5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,155,1728975600"; 
   d="scan'208";a="93308007"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Nov 2024 15:33:59 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 14 Nov 2024 15:33:59 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 14 Nov 2024 15:33:59 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 14 Nov 2024 15:33:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CRKdhEay4qA6olYAZzSxigbQO64V05GUfKwefpdG16q+U0ozjx+A5KBhm0BXdUWnqswy98BAR3u/LMfSicByrzhaX3TD6ucMDJ2wA8a5WMoyAN3wsMkdtqYNuDvPkkdjG+72FOA2PIfvM5u6NIOwm4LZQzjNip5/6M0SBj65dlkc8/dGUiQH9a+mfbL5pX4sp29BFdBJxtuwDVsiYQJSo9QA8QsZMcXyyW0aJo4RcBfrbwfyc5wrpgvoEdQ4oWHKtIcTgA8ZVFvp2cUtZkanBGMXLL6Fy/EYltYGkigYY7zQFUlaWpIegmCwaeExAfVmr63hwV1Jz7kmico0ldcQSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/FCD8K0scuzYaAjpUb8gg2OFHbFPhl7+Bw9fhxAojuM=;
 b=ZVKjaglInWYyFG/HgXD5C6vSwdkaiv3O1eAPf2Arx92h7l4MVNLPPG/QYn6VIkILbh0DIf389R8fhBbw37jQarIIq1jtXKUzbxLyqifrrKb2PKVzZb6QPgBgB9IXm1UsrBfu5WlzSiMmvlT8EwXdBmpY3VP8c8LX8aaF/73F+a582OQASsdHvkYBSAR12j1LN1gyXGqh2XiXobVqgadXjWzHtFaEUpOc/KLLDKgubPmbV1WGwLHl1DcEAPxzMee1+jkRC2569OROrPiy5L8NQBzSUhUE0GTgJxt1yASnPViB71PdBhU98WHDqEb9IhK6qgBfErPpucSSqCf7T2oE+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by CY8PR11MB7922.namprd11.prod.outlook.com (2603:10b6:930:7b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Thu, 14 Nov
 2024 23:33:55 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%5]) with mapi id 15.20.8158.017; Thu, 14 Nov 2024
 23:33:55 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "broonie@kernel.org" <broonie@kernel.org>, "debug@rivosinc.com"
	<debug@rivosinc.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>, "hpa@zytor.com"
	<hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "x86@kernel.org" <x86@kernel.org>, "vbabka@suse.cz"
	<vbabka@suse.cz>, "arnd@arndb.de" <arnd@arndb.de>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "bp@alien8.de"
	<bp@alien8.de>, "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH RFC/RFT v2 2/2] kernel: converge common shadow stack flow
 agnostic to arch
Thread-Topic: [PATCH RFC/RFT v2 2/2] kernel: converge common shadow stack flow
 agnostic to arch
Thread-Index: AQHbIBZyPOfX3Zr4okuuoIHBkG5sC7KjD/EAgAANpICAFHyygIAAAOEA
Date: Thu, 14 Nov 2024 23:33:55 +0000
Message-ID: <57adad09dfd4b360a0871247919ae295e978fbe5.camel@intel.com>
References: <20241016-shstk_converge-v2-0-c41536eb5c3b@rivosinc.com>
	 <20241016-shstk_converge-v2-2-c41536eb5c3b@rivosinc.com>
	 <7109dfcc6df5a610dcfe35a77bb7a84f8932485b.camel@intel.com>
	 <7f392b4e-9970-42d4-8204-2aa967a5375d@sirena.org.uk>
	 <ZzaIJQXQprUFn3k4@debug.ba.rivosinc.com>
In-Reply-To: <ZzaIJQXQprUFn3k4@debug.ba.rivosinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|CY8PR11MB7922:EE_
x-ms-office365-filtering-correlation-id: fb683016-a23f-4527-1fe2-08dd0504ce4a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Wkd5aHNPRDZRejUxcUVuZHZWOEdkY1I3RE5kbVlzMWVRMFljRWZxZkxKT0Jh?=
 =?utf-8?B?Y0ExazF6ckcwcnZ6OEo4TERjeDFlV212WlVGeUpNZktPWVlFcjNUUEJ6aEJL?=
 =?utf-8?B?NTFQRkxtUGkzVWJmWU10ZUJQQUNSZHpBMzZKQTA1RktWbGtrRkYvY0VFTTFB?=
 =?utf-8?B?YnFhUWptYk03eElzWTRpR0l0eHhrdzZzYlRMM21aZjdOZndZNGl6VTVNTkVo?=
 =?utf-8?B?U25lblNKZ2Z5dU91cHcvZUVkZ1haNnE1Rmk0YkRuR2RZSEo2bHd4NzNPMFNQ?=
 =?utf-8?B?ZHRYNjQzNjc0YTRQNXA2STlqL2J2NWVtb0JSWlRLQmZWVzhtTnVGTzdYaUR3?=
 =?utf-8?B?Mk9tNlpJSm5EZWx6Uk5mSlZBZXJKNXM4N3RPNjlhdTBRZzhncm1PZXpoN1Z5?=
 =?utf-8?B?dXpYL0QvTS9hV2NxZEtGSTBjZWRQNkprUUpGWVRwaEdkWmU0UDlvQlYwY2tP?=
 =?utf-8?B?ZEYyYjJDWlpLY0VhTFMwQzV0RzcyMlpGZmRPL1ExM2dOQWdrKzJ1WXlubWZv?=
 =?utf-8?B?Qm9OeEUwUHpkZStRL1NoMTZweW8vQ0p3T0RLTXJybHJ6YWc4UGVrUlVHcmJ6?=
 =?utf-8?B?OXJub0RxYWlxVFgyeTZ0MnZuOWNvMlhNeXNTWGxRZEdUdDMwY1dqVjVZU01L?=
 =?utf-8?B?UWF2ZGN6SXlMWjUvd2c0dFY4cXBxcWlxVEtaMkRYK2lXc0c4K3ErUE9tODVa?=
 =?utf-8?B?dDdFTzdWdmlrdTFWMUdQWFUxNDA3d29paXVxNnZSd0lmaElZQW5xbDlrcW44?=
 =?utf-8?B?MDd4RTkxMW9vaHMxandMV0t4NkErRXo5RVBCWDhiQ2thRXJMY2tEVXE2L0Js?=
 =?utf-8?B?UDFzbEpOaVVMUy93ZVdGUWwvWUZjemxmSFowc1FzcWl4dSs0WDE2d2c4QVJP?=
 =?utf-8?B?YkNVOWdweDVzOTdqUk9waFFBMEhhK053ZDdKS2dXKzVKOW8wNkp3ZmttMW5h?=
 =?utf-8?B?SExSK2lBQ3ZKREQ4OExpZ2JzaUtGRzBxVzdIMEs2QjA1RUoxQVh0VXhGaVlT?=
 =?utf-8?B?dXk1eXhvNnI1dDJZcDVjdFR1UGhrNUZNcUpIUEVhS1FpcDBYMkxjSlBhUWFw?=
 =?utf-8?B?RXlVa3BXckxQdnUrd2kybGRJb0o4Qy83YzBJbjdzWThVcXRpWDc5SlZqelZF?=
 =?utf-8?B?UzlmQnVGakJxaVBaSVA0Vkh2V0UvTUVLc2tRZ0NhMVNzenNaYjNPcE10ekVl?=
 =?utf-8?B?ZWplb0g1blJKaHJGUlBHOXZoRi9uYytkT24zSnd6dE54WkwxK1VuVitzNmwz?=
 =?utf-8?B?NkdRdTZmRW5qcnMyZmFUZVd6UDkrZG1Kb3JVeDByM1Q0bUxVNWRML2hXbHdS?=
 =?utf-8?B?UHJOc1lSTUZ2NENYNHliOG9GcWxiQzc5UUVpenZOL1IvR0FtbTJtWFFBNXNS?=
 =?utf-8?B?QzlNRkU4eUpTUnJLYnU4QmJGdnA4Q0lNMnJwdDhpRWF6YzlQSFg1VXQzUVNi?=
 =?utf-8?B?a1YzcStnaUkxR1kzWDh6TEtMYUUrZXJ1Y3RaaDc2a3RpWWkrd1BIdituMmZO?=
 =?utf-8?B?bi9uUFpjWXFndS9mOCt4YVgyeUFsRmJ5QzlpM0Y2NU0rYURQMzluTHNlVS81?=
 =?utf-8?B?aG1zOVhtK2NXNVp2dDQzMnNERnFvanFRcktvckUyLy9WSGhlVjh2WGI4eTdL?=
 =?utf-8?B?b2tBamlQK1BQVjBHRS9mcG9pVmp3Y2oyWlBSSlprTUMxZVJaWk85ZnBrV3Ft?=
 =?utf-8?B?OHNQenRVeFBjMjE3UlFtbWtXMm00SDZrNHVLZGNIYnhCcU1SYUphc0NGL1JC?=
 =?utf-8?B?ZWFjNVl3bEUrTmJlRTVEMnovL1NRWk8reURPWmlEUFF0OVF5djRTanVxSHBq?=
 =?utf-8?Q?jIlqN6PyV0/0MYpwMlAdIDKc8pKXv10O9yX4g=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dWd2SEpNUEdYM1hIWGJVcEhPUU9WVkFPV2FvSFZpYldZR0N2MG5EWG1tSzE0?=
 =?utf-8?B?d1hsSTFHdFdKYURKY3c1VjFyU2o2NEJ1SVNJaTYzVjRvTEtqQm5qWFh6d2ta?=
 =?utf-8?B?TTR2eXN4Rjg0b2ZNT0VmOHhucTNha2doOEFEb0JFaG5hNHNJN1pMNFA5REdL?=
 =?utf-8?B?Y2VmaGFoNGxCRmQwU0NTN0lVZkkxc2dpdU1RMTRzRDhXKzI2elYxbkRHSzlr?=
 =?utf-8?B?TVlkYlkzWTVLdk9kSjB2RHFFNHdSL0F0MUhSSXYzYlJzTjB2Z2NxMFBhcHFi?=
 =?utf-8?B?V0hZalJrODBQVDRKcFV1SlQ0ZHRkTHZHUVQrNTRIOENLT2J2QnNKZjBMSTZ6?=
 =?utf-8?B?NEpDRGpKRE82UXRkSVdRVHlJeEJ2U21QMWxVRittUEdvUzdLUi90REU1ZzAv?=
 =?utf-8?B?azhqVGNPU014UFVXbkJFOTRJVGhlZWVFbG1oNDFIK2E5c3YvWXNlREVNaHNy?=
 =?utf-8?B?NXN1NHlSWWU0YU0vNyszL2tUZHJsR3c3UkVEMWYyMzVKTWpWZDA5RENnU0RC?=
 =?utf-8?B?L1BtWGE5OTRmUklHS0U5eUFsREhQMzlhUjgyeVd4VnpzbGxwSGs1dkgxKzFF?=
 =?utf-8?B?NnpoMXZmeDRqc2c2QzBGcENOSTVnZWxOS1ErTTc1YTVmc1d3eGlxZ0x1bWth?=
 =?utf-8?B?M3NlTlB4bnUzL01xdlhtMkgvU3llQ1U1R0RSSFJVN3JYNyszTExKS3BlaVZr?=
 =?utf-8?B?dUVFNEk1QlcxR09FOFdTR0F4WGdqVEZJZmpOWHJsMjZyMG9xVWhTMjBDbEt1?=
 =?utf-8?B?NDN2Z3hZV2t0Qnptak1rbTFES1g0M1JsTXVaV29ROTlxOTdCd2FTWVV3ank3?=
 =?utf-8?B?eXN5NEttTlRLdWVodGxtREVFbVBLMHVyMFJwN252OVdoSDlMT3A5cnQwLzNP?=
 =?utf-8?B?UkNGdGxUbG8rT1pocTRJelBoRExqbHpiZFJXejJpUEIzWFVVUTJ3RVhNM1A5?=
 =?utf-8?B?YzVkYit4emdQYUoxSEh2c1c3ZStvYlB5bmczODYvQ1Z5K2h5MmtJRzIwUTdL?=
 =?utf-8?B?dEtKZGlHb0xVR2NTVW1LVDdqL1lJSWZWSktVeEdrY2k3RDVjdjNOQ0pVNkxv?=
 =?utf-8?B?ajhJVVYraFVOeXJyejJkd3FWU3lIRElhanlBT2JLSzluRnhKR2JLYjh0U3Fo?=
 =?utf-8?B?TkZZWVpZQSt4NEV5UTJUVTdlSU5OUytWaFlSZStnVFM5R3VDK0FvZUJucTJ3?=
 =?utf-8?B?L01XR0hicEVnM0JTUVFUUU1KYzN0YW1NN2tYUHE2enNJN2FUYVBGZERheVdY?=
 =?utf-8?B?Zmw2MHpaRWFVZElVZjU2bDJqenduRzR4eEErVVVGSU5rQ1ZSRkludTNCYWEv?=
 =?utf-8?B?RjNmcTJWT2ozQ3dmeitWYTRwUFl0OXYzWnNpN2dnRVYreWpnMXpaZjhXdUJl?=
 =?utf-8?B?RDZpaGZoOHV3RTZnVnIyUTZtcFUwUm04U25adDJKRmMvZ3pwekhZb05jN0Va?=
 =?utf-8?B?TnQ0b3R1Nk5ZSHV2QjBTUUo3ZnczU3BEWkFDbjNPSFY1cDBnT09nNmE2V1JJ?=
 =?utf-8?B?N0hIOUVpaFFzWk5PRUpSWlArcmJOZGlLbHJ2ZElIcjl6QWVjQ29PRGo2cjhX?=
 =?utf-8?B?RTl0ZmJrWDJIamtGdnRkZ0hWQ2ZYdk90VElFenlMUFh5cndsY2dCem1tRStN?=
 =?utf-8?B?aCtEUkhtc2I3OFd3cmlCTDZ2Z0EwRjg2S0RMM2lZMTQzV0xkNG43VVpLT2I0?=
 =?utf-8?B?S1ViQkFETllLeEh4NUFXNEFSNUlndk1SZTFGOGQ5WGNINFFoZXByczB6Z0tX?=
 =?utf-8?B?eE1MUnAvOWNtY1BFVUJjK0NLc0d6dUlRdjAzcXVUdW1GbHBIcldGOGlIWGpQ?=
 =?utf-8?B?YlhGamkxLzBsWlQ1VkE0VFFmNjRzSFNPNHBxU1dkM20xbkdqMVlvUFd5TUJD?=
 =?utf-8?B?NjI0S1hKTW5KZU44YjNuTnZjYXVuRTBhQ25LSzZ1OXBzTjZWMXMycnBNbkJH?=
 =?utf-8?B?MHNKbUdDbWFWR2piY3FPZ05MbVNRSHZPUEowcDZCZGgwYUNudUl3TC9NQUZo?=
 =?utf-8?B?SnM2KzZxR3RCTGJRRjZSdG9LVUp6T09vZ0VubmNBSCsvUUlWaERWc2dHNnY3?=
 =?utf-8?B?VXptdkFVak4rOENIQVhGbXRtSkVSK0piTE1SQkVJY2U0RkNjeDhRVVZjYTAx?=
 =?utf-8?B?SHE4T2YvS2YxM21OWWg5MUxxenhZT0FMZWJkUEhiSHFibEl5UGpGenBtSE8w?=
 =?utf-8?B?MEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <50475D7335874D4C8370ABB3127229D8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb683016-a23f-4527-1fe2-08dd0504ce4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2024 23:33:55.5409
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EPdfyemIkCJoKWKJQzZY5OjFFLkPCSmsj11zbPrNpQzJPiAbiPVwG0/tij8M7dAAk9xH4CDZ+9iW8RwFo5gjHARohbj4ZS/Zv3+DphuQtYM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7922
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI0LTExLTE0IGF0IDE1OjMwIC0wODAwLCBEZWVwYWsgR3VwdGEgd3JvdGU6DQo+
IE9uIEZyaSwgTm92IDAxLCAyMDI0IGF0IDEwOjM5OjE1UE0gKzAwMDAsIE1hcmsgQnJvd24gd3Jv
dGU6DQo+ID4gT24gRnJpLCBOb3YgMDEsIDIwMjQgYXQgMDk6NTA6MjdQTSArMDAwMCwgRWRnZWNv
bWJlLCBSaWNrIFAgd3JvdGU6DQo+ID4gPiBPbiBXZWQsIDIwMjQtMTAtMTYgYXQgMTQ6NTcgLTA3
MDAsIERlZXBhayBHdXB0YSB3cm90ZToNCj4gPiANCj4gPiA+ID4gLSAqIFRoZSBtYXhpbXVtIGRp
c3RhbmNlIElOQ1NTUCBjYW4gbW92ZSB0aGUgU1NQIGlzIDIwNDAgYnl0ZXMsIGJlZm9yZQ0KPiA+
ID4gPiAtICogaXQgd291bGQgcmVhZCB0aGUgbWVtb3J5LiBUaGVyZWZvcmUgYSBzaW5nbGUgcGFn
ZSBnYXAgd2lsbCBiZSBlbm91Z2gNCj4gPiA+ID4gLSAqIHRvIHByZXZlbnQgYW55IG9wZXJhdGlv
biBmcm9tIHNoaWZ0aW5nIHRoZSBTU1AgdG8gYW4gYWRqYWNlbnQgc3RhY2ssDQo+ID4gPiA+IC0g
KiBzaW5jZSBpdCB3b3VsZCBoYXZlIHRvIGxhbmQgaW4gdGhlIGdhcCBhdCBsZWFzdCBvbmNlLCBj
YXVzaW5nIGENCj4gPiA+ID4gLSAqIGZhdWx0Lg0KPiA+IA0KPiA+ID4gSSB3YW50IHRvIHRha2Ug
YSBkZWVwZXIgbG9vayBhdCB0aGlzIHNlcmllcyBvbmNlIEkgY2FuIGFwcGx5IGFuZCB0ZXN0IGl0
LCBidXQNCj4gPiA+IGNhbiB3ZSBtYXliZSBtYWtlIHRoaXMgY29tbWVudCBtb3JlIGdlbmVyaWMg
YW5kIGtlZXAgaXQ/IEkgdGhpbmsgaXQgaXMgc2ltaWxhcg0KPiA+ID4gcmVhc29uaW5nIGZvciBh
cm0gKD8pLCBpcyB0aGVyZSBhbnl0aGluZyBzaXR1YXRpb24gbGlrZSB0aGlzIGZvciByaXNjLXY/
IE9yDQo+ID4gPiByYXRoZXIsIHdoeSBkb2VzIHJpc2MtdiBoYXZlIHRoZSBndWFyZCBnYXBzPw0K
PiA+IA0KPiA+IFllcywgZm9yIGFybTY0IHlvdSBjYW4gb25seSBtb3ZlIHRoZSBwb2ludGVyIGlu
IHNpbmdsZSBmcmFtZXMgc28gYQ0KPiA+IHNpbmdsZSBwYWdlIGlzIGVub3VnaC4NCj4gDQo+IFll
YWggb24gcmlzYy12IGFzIHdlbGwgZ3VhcmQgZ2FwIGlzIGV4cGVjdGVkIGFuZCBzaW5nbGUgcGFn
ZSBpcyBlbm91Z2guDQo+IA0KPiBJIHJlbW92ZWQgdGhpcyBjb21tZW50IGZyb20gaGVyZSBiZWNh
dXNlIG9mIHg4NiBzcGVjaWZpY3MuIEkgY2FuIG1ha2UgaXQNCj4gZ2VuZXJpYywgZG8geW91IHRo
aW5rIGl0IGJlbG9uZ3MgaGVyZSBvciB0aGUgcGxhY2Ugd2hlcmUgd2UgZGVmaW5lDQo+IFZNX1NI
QURPV19TVEFDSz8NCg0KSSB0aGluayBuZWFyIFZNX1NIQURPV19TVEFDSyBhY3R1YWxseSwgZ29v
ZCBpZGVhLiBJSVJDIGl0IGdvdCBtb3ZlZCBmcm9tDQpWTV9TSEFET1dfU1RBQ0sgYmVjYXVzZSBp
dCB3YXMgdG9vIHg4NiBzcGVjaWZpYy4gU28gaWYgaXQncyBnZW5lcmljIEkgdGhpbmsgdGhhdA0K
d291bGQgZml0Lg0K

