Return-Path: <linux-fsdevel+bounces-5741-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F046180F7BB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 21:17:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B77F1F21832
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 20:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A1E63C0B;
	Tue, 12 Dec 2023 20:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JwbGLs7B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7755C11B;
	Tue, 12 Dec 2023 12:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702412239; x=1733948239;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=1wagE92nn0U14GIOLGltHhflAUGflbyfugT+wZeMlhg=;
  b=JwbGLs7BS81G3xtQ2xB0iVBQcJ962Nv8TYmXMakOAKzEwpVTWp+qpjOP
   Q2zdB2NJkkT2o3I9J+vXE8vjibMzXc7raYaOWyMKA0u3JpVizJrjX3Cwe
   oKBWskS0MmS+uEl0srgkJnWse+m7qTsevLCyXUwi60el4DmcmwAyqHOQV
   AInbH7AVIkcDcprd4DK/nOQEA1ufv24UkApr+gI1jF4finIPV4RszonUr
   MSMtWycmDXE2qV+q0e4vWjY+ArXq27sPHOXh8t8Ua5qp4aRMLPBWQCGLP
   eBCudbjO1TQKYQnmGgP2D5vdktKiynUJYlmKaYRLVg7tlDNVQy8w1xf2N
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="459181701"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="459181701"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 12:17:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="21652959"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Dec 2023 12:17:18 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Dec 2023 12:17:17 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 12 Dec 2023 12:17:17 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 12 Dec 2023 12:17:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NkJMkY+pO1oS4FhNa2+lgnBERU7hsuXskJe6qB3h5aQqv2U6MKbVrL4x9I19nNS1CzVjfYhfrdZa/UJ5h+/g0dLBwYwNjshOtns3P9k8ZkEkaOOzfp1OqWilusDRaxoN5DxG78Aa6R5YQtnDfHqmM5TCE1usEPgglK+KfOWKAPQfk3W8bcPTs/yiz0q1wxCx1MX+UVsqbxDidgi7z/zTAOiiBz+p8HCcnBayk0crtarQTbLggIUF/2UyKG0cpuD6BeekF//gsgz5gxRVuiin10H1CidmkxxPM3cUJAa6RC5TXy6LKrV3GbPdc4HQhicimuF9BO9fssVJYfCLk1QGxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1wagE92nn0U14GIOLGltHhflAUGflbyfugT+wZeMlhg=;
 b=c1joYOYCJOWvwNRIkYnDZS/LuN2YXWgu/xNVJzlobcLhssZQfbXHIjKfEvChGLS7031FK3L7t9JnssPVJNjgYOoQm8nQV7Kst39r2JBc4rlx+abQGvNhI3OGh6PdpCJPGrAl0+RHqu7tvKaSDkvPeqGCBqY8QlbO9huStpOmwjhyRUf+x1IStiV1wArU3C6zPfNzyZNueUH2Fo6KrHaLm8+Nh9QXUMrFyJ0PZe4P59882GyoZml/YYbN4l2kT0tHRO1kh2/0ZEE6DvYojOjPW8R0UAqg6M3hBXAgi9XfcJEN9HFef0UbVCozG/+n0AnDYzh8jA+dOsS958stB3BVbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by DM6PR11MB4708.namprd11.prod.outlook.com (2603:10b6:5:28f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Tue, 12 Dec
 2023 20:17:10 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::6dc:cee5:b26b:7d93]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::6dc:cee5:b26b:7d93%4]) with mapi id 15.20.7068.031; Tue, 12 Dec 2023
 20:17:10 +0000
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
	"suzuki.poulose@arm.com" <suzuki.poulose@arm.com>, "oliver.upton@linux.dev"
	<oliver.upton@linux.dev>, "broonie@kernel.org" <broonie@kernel.org>
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
	<linux-kselftest@vger.kernel.org>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v7 02/39] prctl: arch-agnostic prctl for shadow stack
Thread-Topic: [PATCH v7 02/39] prctl: arch-agnostic prctl for shadow stack
Thread-Index: AQHaHSi7sAK+Ev02qEq/1HaZdZvzcLCmNgsA
Date: Tue, 12 Dec 2023 20:17:09 +0000
Message-ID: <e1362732ba86990b7707d3f5b785358b77c5f896.camel@intel.com>
References: <20231122-arm64-gcs-v7-0-201c483bd775@kernel.org>
	 <20231122-arm64-gcs-v7-2-201c483bd775@kernel.org>
In-Reply-To: <20231122-arm64-gcs-v7-2-201c483bd775@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|DM6PR11MB4708:EE_
x-ms-office365-filtering-correlation-id: 9b83f151-b3f9-4fc1-bc44-08dbfb4f519c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jHx/rFIVGpAe58OzFelefnQHDN61StWjizNi44Yk3BAlFH+P87UwUCaKLQXWeQfFPy/ITxGB4HbOAIaZT8g3fsWorvMSbOoNLOJsi5MoCppQN3lJHCU6ynsNNvIti7eZDCiRVIhfv3s50dWJG9KdNj5sxi/waPJu35Kv55GNDJhEaeSAUAyGFG6fcM1Rn96sBCIbRqlLgDIow58PMKE9iYePetNHpfELwp4TOyRs4e26puRawFq2o4YZfvyCQIs5nPm6z7x1HV/8lTFR8IJmhFcR3LmFbNsHxnsZe/N4uM+qxj4csRfGhp274xtOKrXUWKJx2vPT4pq5My1OTkPJzhgIfgFyTfzkuuC4X3eOC/zpRbP9foOlnI6O48CgJN1i3sImqXewGhjyJ8JM/55fiWomLvHrT7KClln/IYs8m15ZsCBPI6/EXPlTdEHe5e++KyISHjtkgNxtt4dvfjgVuBaJvHGP2q+ix2mHuE+V0lq+3dmmen6wJ5IPPvHb+QGY28uwQI4vA5kwJVN3aTrKgGRyg5behAXKGuPhcp+moJ11FjKXvzRfUz7lSUGGBwLzTLLBWnla/ZtFL16HgX0T1667CsPXo0THfkKPa4lzD01b6mIp3rUDczCfJZqhCtg8pRUbiChMooLgYHh/wnUHQA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(136003)(366004)(346002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(7406005)(4744005)(4001150100001)(2906002)(7416002)(41300700001)(38100700002)(82960400001)(6512007)(36756003)(6486002)(122000001)(110136005)(91956017)(86362001)(2616005)(26005)(6506007)(478600001)(83380400001)(71200400001)(54906003)(4326008)(5660300002)(921008)(316002)(38070700009)(76116006)(64756008)(66556008)(66476007)(66446008)(66946007)(8676002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UzZzQ0lEblhta210OUlsQUt0ODAyanN2c2E2RnJwanczSlhRUGpQbjNFdHpI?=
 =?utf-8?B?bGdlT2s2RXR3bkJkRjJZNlh2RjdEeGRmaTREaGJLNnlML2wwNkVoQkp3WFZ3?=
 =?utf-8?B?SFdCVytDdmxOSWRsOW9BRWUxOTh3aWdMalNXUGNYcnFrcy83c1VZLzJTWFNo?=
 =?utf-8?B?NHlvV2RHTmdaWGYzbEoycExGalR1bXlTK25OdWNRYnNsdGhuS3F4Zy9lbG4v?=
 =?utf-8?B?R2VTWFN0RklHK0RPTEY0MWpkK2ZFckV0Yk1KQkIzUGtkU1VwaERsQVV5dzN0?=
 =?utf-8?B?TUh5REN6dUxIRHBOWTNrWGpoR2FTbjdBZUFpS25tZjd0Z01heGtqZ2xldTZU?=
 =?utf-8?B?S1Z3YStSMGpibnlUU0I3amEwMHM4K25rTzM3SUwxS05vbVZTd2ZjWlcxUHlB?=
 =?utf-8?B?OExScUl5VGFmalNtbHgvOEF2NkI3Yk9HYUY3c2RDWHYrMlFnNFlid3NoVXc2?=
 =?utf-8?B?d0tOUnFDME5MclQzU0Rhb0FRZE1RUGQvY3dNR2VzWUFicFo5K2FWd2hkTURt?=
 =?utf-8?B?T2xsTE5WdHlFTzlKWCtXeE5LWno0VVlpT1dnaVZiWVVoN3FVeHZZS2FkWERF?=
 =?utf-8?B?bjRuSWs1SlplcHpJbjVOQzBUS09lbDUveVZVdTk1WllYMDlwaE90RENCSFZY?=
 =?utf-8?B?VEZzc0t6ZEZZaGdZcy9VWGIwVGVqN05EVVFXNHJBWUJXaVZRd1FUd0F6V0t0?=
 =?utf-8?B?N1NxeTFybkVTQjlsbWFseDJtT1NNdkt1RnF6YXVJekJLcXVpK3dOVElMN0w2?=
 =?utf-8?B?Ry96OHRkMkRpeEZnZm0xUnRQcVppTXYxN3J4Yit4VXR1VFNnVjZpZVV2VUdn?=
 =?utf-8?B?ZitjQnU5REFPUVRWYTF2NlhuYStjNm1nTDRnOFVVZkxWQk12SUxZdFFKSXFH?=
 =?utf-8?B?aURScFBmcHp2UnM0RnFiMWQzRm5UeUhkU2wrNW51ZVhTMldsSkxjbEZqdld5?=
 =?utf-8?B?bnM5M29xMlRuenFIN0tvZXBxcmRPY2JLWmxSRHZXMjl3VmNhNUc0OFFOWnZO?=
 =?utf-8?B?ZHdhb253MksvZlZaalY0TU5HdDhyL3V6cm5kR0RBOHJ1eklMNTM5VGtWRnIz?=
 =?utf-8?B?a2F3UHNlVTBuekhyQ0NoUThPSTd5SlRLZVFBZ0xuci85eHlDWmtWODRoa0tH?=
 =?utf-8?B?K09OT2J2SHhxb0d2VHpSdU1HSnBOUmhvOG52cWsrbDRQVlpZeFJDL2xBWFI4?=
 =?utf-8?B?dXJ6MndoNzFVUVVuUXV6QXBKUVpkVjJ6VFVjeGRqejAvbXlNNExGam5COWpP?=
 =?utf-8?B?TDBQT0dMRkNHR2c4MUpqNFJEcTJ5UzV0TXJQMUJ3d2krUllZQWZQRVZHUk84?=
 =?utf-8?B?cXhYMTNMdlk5UmVydE1UbDNHNk5VWWdWdUtKeFdpNXlJSzk4WEVGMkdqRHFX?=
 =?utf-8?B?eEdvd2xXejhhS1RTSTBwM2V2cnVWbG5uOUdtb0RkRnJMTkxvNkJIYzdTQWl5?=
 =?utf-8?B?ZFRzclEyS1JUdHdudS84N1laQitTc05TMDRuSFZKNDV3WUptRFF5a05hamZ6?=
 =?utf-8?B?OEdPTUh5dld6SlIvbEt1WWZhVWxHaldYUGVaVUYxU3RaeUxLbWFqcFNoNzRp?=
 =?utf-8?B?Z2NDQW9HOGczN29ydWFMbUh4c25sL3JwQVBBcjFRY0l6Ry96NldJUVNCaEgw?=
 =?utf-8?B?N0VSa0pxaS9Ed25HYWJST2tRTkJ2aXlXNmIzeXVTd3RGcWNkQ0c5L3k3M05o?=
 =?utf-8?B?NGlLZjB4RzJsMi94bFh4cm03M2grV0o5R2pSWStTYXJiTlg1QXpPU0RWL09i?=
 =?utf-8?B?UmNzdFhlMG9mUTF5U2hiTEtuY2FaVXV0VW13Mk5EMFRzVC9WdDYrZGFxcEpF?=
 =?utf-8?B?Zmp0OFN1S0J0YzB5aTB3VHIzLzhFTERrS2Mva2NaL3Nqekd1S2R1V2ozVUZv?=
 =?utf-8?B?ZjV0NHk1K1VBaTNZeVZhUUlxK1VCejFwMFNrN1ZKbXhQMUZyZU1yMW1kU2tp?=
 =?utf-8?B?TU8wMzVrQTFab3Bpak1mQ00wYXpSdENMZXBYc0ZaMWJiOVA2ckJlRGl6QVpu?=
 =?utf-8?B?VmNPQ0cyYUhEQWNnYTZyZDFlVW14Nm85NmF2aGxOSEN0RFVpc1dNWHQ3MzJa?=
 =?utf-8?B?MXo5REFHSzVldC9hVGFKM2pNU1hNdHl5N1pQNTlrYUhUcWNHRWFzWlZoY0RV?=
 =?utf-8?B?VW9HaVNOb2dwTlJDRWxmTlhpbE0vZTFRMG44Y25rRVJmUjRKTzZ5TERmeTZh?=
 =?utf-8?B?V2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BB5612178D454847A3849A59C67399B1@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b83f151-b3f9-4fc1-bc44-08dbfb4f519c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2023 20:17:09.3216
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iZh2pk2o1L/k+OrSVhMy9Wg8H7zuUXSXsprc9jwzy7zP84vsL60DKG+3f0vmJGBNrDs97eRx4PGDJGoudxy8vjc/k1qXW4ntykufct+tk0E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4708
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDIzLTExLTIyIGF0IDA5OjQyICswMDAwLCBNYXJrIEJyb3duIHdyb3RlOg0KPiBU
aGVzZSBmZWF0dXJlcyBhcmUgZXhwZWN0ZWQgdG8gYmUgaW5oZXJpdGVkIGJ5IG5ldyB0aHJlYWRz
IGFuZA0KPiBjbGVhcmVkDQo+IG9uIGV4ZWMoKSwgdW5rbm93biBmZWF0dXJlcyBzaG91bGQgYmUg
cmVqZWN0ZWQgZm9yIGVuYWJsZSBidXQNCj4gYWNjZXB0ZWQNCj4gZm9yIGxvY2tpbmcgKGluIG9y
ZGVyIHRvIGFsbG93IGZvciBmdXR1cmUgcHJvb2ZpbmcpLg0KDQpUaGUgcmVhc29uIHdoeSBJIHN0
dWNrIHdpdGggYXJjaF9wcmN0bCB3aGVuIHRoaXMgY2FtZSB1cCBpcyB0aGF0IENSSVUNCihhbmQg
cHJvYmFibHkgb3RoZXIgcHRyYWNlcnMpIG5lZWRzIGEgd2F5IHRvIHVubG9jayB2aWEgcHRyYWNl
LiBwdHJhY2UNCmFyY2hfcHJjdGwoKSBjYW4gZG8gdGhpcy4gRGlkIHlvdSBoYXZlIGEgcGxhbiBm
b3IgdW5sb2NraW5nIHZpYSBwdHJhY2U/DQo=

