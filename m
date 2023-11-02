Return-Path: <linux-fsdevel+bounces-1809-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A73CF7DF0AF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 11:56:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 015B0B211B3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 10:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F004714293;
	Thu,  2 Nov 2023 10:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D9KULCyj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0684F1426B;
	Thu,  2 Nov 2023 10:55:50 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 401CA131;
	Thu,  2 Nov 2023 03:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698922546; x=1730458546;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=YgZ2eYSzUjpjNVzDSTQGHYgS096UR5GeSSRvck88unc=;
  b=D9KULCyjKZkpgsVj42ZRR+V/0xvneFou0Kq8O3vzf8VxzjlEYpMklBdi
   +yb2teEUrtWhyu3LD1sCnb5Xlwfc5WvVOQpY4mkhZSEzBT2IxH45jhtqs
   uRt73ZI97bkC/f8ms3r52jBMxG3D4jWm63LJQ2ihKjSFOewxNqtnuCDn3
   oP7sRr240CQ6Z+n/7kYzk7Rb+0hYh8uYe27yCtR0jq3/OsWNGrXFLMeyl
   PXx9CEyjNvvu/rneQckGMwiXH+XbxD3keujKw0IzDF4YF7DQqqrQpZY3Y
   yxWklL3GfEtt1ge4LkvaurE9lZuH1OtM1OZwopFMW+75CfodpU906rsde
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="388505729"
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200"; 
   d="scan'208";a="388505729"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 03:55:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="878202295"
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200"; 
   d="scan'208";a="878202295"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Nov 2023 03:55:41 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 2 Nov 2023 03:55:40 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 2 Nov 2023 03:55:40 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 2 Nov 2023 03:55:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HYEc12Pti53H8iEIEQDM5dkX3u66Jh6116mqqOlNNRV7ZSHNgYWQvs5pG6rbmA2uI7wpaCt3YRFScG5PVhmFM7mohnHvETyDzb3y/rOAayENJlKUc2OD5XQBy+8yXO1grB9eFjb7jAJmb2VLoW3OY8DCnq++ZTEyoRXj74lu5k6ixBC0OL4BhbLKJluXim866zRs379PrhCoqNM3LlzHJ1P5XOOI/czRLRKnP0fHBt4c7PManB93Mng5j6Lrmixf1x3MrgauueT4ybr2fFc8N8JfJDixQh8SNleDzIKaAn+UVSjjXZX1zpcH4NvBtNhhPNUaixOI3h9Dl8TvIQtsCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YgZ2eYSzUjpjNVzDSTQGHYgS096UR5GeSSRvck88unc=;
 b=GpLZ2TNHE3pWGWKAC4co+0R0sok6eRNWK8CnhGLRDucJFwX/bBMEcnUSNfqts5Tudx1M12XC//pn4l9z6JBtn4tHCpnsuGFgZVihTZgGg/wNJEoOASuMqnfp/6w+/NZQ9z4d+e5qKXFblf5c6IVIY5IsvN+0RApSc+iU2qNadJGA+M343Sqo5Nssmw+FyT99Vikx2qs8VsGNYtnqlRph3hBPs3h8h0YzLQR999aEAv4OygnyPtdFJZe1aHmyzef9jWskoKM0m1JpXs4l/3Lw9BkKJ0Rc6QdoY4x06FT6wUE3pZDYZCxyuT3Di6gIhdqf8W/LGhjIYpGDahrH8TcOUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by IA1PR11MB8099.namprd11.prod.outlook.com (2603:10b6:208:448::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Thu, 2 Nov
 2023 10:55:31 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::5d1:aa22:7c98:f3c6]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::5d1:aa22:7c98:f3c6%6]) with mapi id 15.20.6954.019; Thu, 2 Nov 2023
 10:55:31 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "willy@infradead.org" <willy@infradead.org>, "Christopherson,, Sean"
	<seanjc@google.com>, "brauner@kernel.org" <brauner@kernel.org>,
	"oliver.upton@linux.dev" <oliver.upton@linux.dev>, "paul.walmsley@sifive.com"
	<paul.walmsley@sifive.com>, "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
	"palmer@dabbelt.com" <palmer@dabbelt.com>, "chenhuacai@kernel.org"
	<chenhuacai@kernel.org>, "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "maz@kernel.org"
	<maz@kernel.org>, "anup@brainfault.org" <anup@brainfault.org>,
	"mpe@ellerman.id.au" <mpe@ellerman.id.au>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>
CC: "Li, Xiaoyao" <xiaoyao.li@intel.com>, "kvm-riscv@lists.infradead.org"
	<kvm-riscv@lists.infradead.org>, "mic@digikod.net" <mic@digikod.net>,
	"liam.merwick@oracle.com" <liam.merwick@oracle.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "Yamahata, Isaku" <isaku.yamahata@intel.com>,
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"david@redhat.com" <david@redhat.com>, "tabba@google.com" <tabba@google.com>,
	"amoorthy@google.com" <amoorthy@google.com>, "linuxppc-dev@lists.ozlabs.org"
	<linuxppc-dev@lists.ozlabs.org>, "michael.roth@amd.com"
	<michael.roth@amd.com>, "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
	"chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>, "Annapurve,
 Vishal" <vannapurve@google.com>, "vbabka@suse.cz" <vbabka@suse.cz>,
	"mail@maciej.szmigiero.name" <mail@maciej.szmigiero.name>,
	"yu.c.zhang@linux.intel.com" <yu.c.zhang@linux.intel.com>,
	"qperret@google.com" <qperret@google.com>, "dmatlack@google.com"
	<dmatlack@google.com>, "Xu, Yilun" <yilun.xu@intel.com>,
	"isaku.yamahata@gmail.com" <isaku.yamahata@gmail.com>,
	"ackerleytng@google.com" <ackerleytng@google.com>, "jarkko@kernel.org"
	<jarkko@kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>, "Wang, Wei W" <wei.w.wang@intel.com>
Subject: Re: [PATCH v13 13/35] KVM: Introduce per-page memory attributes
Thread-Topic: [PATCH v13 13/35] KVM: Introduce per-page memory attributes
Thread-Index: AQHaCQK3kNRHfZahgEebBaAjW/uRc7BmX58AgAB+IwCAAAZhAA==
Date: Thu, 2 Nov 2023 10:55:31 +0000
Message-ID: <72e15d0a3f1b2e8ddd2b880f9f433423b6614dcb.camel@intel.com>
References: <20231027182217.3615211-1-seanjc@google.com>
	 <20231027182217.3615211-14-seanjc@google.com>
	 <b486ed5036fab6d6d4e13a6c68abddcb9541d51b.camel@intel.com>
	 <a03d0e36-7b38-4841-9c62-66c9029e388d@redhat.com>
In-Reply-To: <a03d0e36-7b38-4841-9c62-66c9029e388d@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|IA1PR11MB8099:EE_
x-ms-office365-filtering-correlation-id: a433efab-7831-4592-9a2f-08dbdb923b8b
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NFwDAjxDrm7N83kq8TlEVS2Pf9+CZIHn/gVSgMSR8FwxTl2jQa5PplmtJcv1UdtM/llF/gbo8uv0qpbmS2wcYNAXuhBuLi14W2soHV4JpP025L+jmu0ulZdcx04VjFu4FtcKvaIfurzhvBa1/8J3S/jVhyjD2bWtiB8PSuIYruajxoS1rSvp8/xNx11B6BHYwhcN5z2lMXxepDr1OJx/RoRUwp4ThzJ1aUBD8fIefqNDrRgYn1yaAfwhdZXVDWBlj3/vr7TBSQOoMfbmhpY9wln3V+2yyP1H3tyB0nRDdFDfYDzs+hGeq3d171my8i6sT6pviS5OmQOPMaXuRmFVBmxcK2M1xd86he5gQQoigHP/VW5hdvRI5+VS2mHsOheEtsrXgyyr2DcuhEbMtXypNVLKarVrE0yFFXDZ5qpsEVi7rvNbQquDHVbgzc3C7TUfnr7bhePKHrvQuuAErjKhHu0VPx4qY5c99w34sSdR41JKI/0cS4G5stCqzrE7XieRCTi+8YbIMTKJm/iuH7BQwMnujrTKCtL/TCzJIgpxEgXTL79eEAoDQ9FzYA8/oVaBweUfg8MYoNFHo4bfdH12U+pcOYP7ZfWppQTZJ9spsHFfLkwiD7s+YVYMcdjYKVU3tLd4YZGr453B1ZB/kgxZCA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(376002)(136003)(366004)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(4744005)(41300700001)(7416002)(5660300002)(82960400001)(7406005)(86362001)(921008)(36756003)(38070700009)(2906002)(6512007)(316002)(38100700002)(122000001)(66946007)(2616005)(66556008)(54906003)(76116006)(91956017)(64756008)(66446008)(66476007)(110136005)(26005)(6506007)(71200400001)(6486002)(478600001)(4326008)(8936002)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Rk5DUmVaS3NzajdLc0Q3aTY3Rkk4SGpWUThMbnpZcm0yQ0xESHljN09Na0xU?=
 =?utf-8?B?TXViVnoyTlFwUEVoOVpaMWx0TWpzNW1pd3RLaFNQT0Q4Mlc4NkFwZmozenF6?=
 =?utf-8?B?Zk8raG5CcXNTZ2RzQXhPS05URHhvRlA3bWFMalo3ZEN0MUlaZldldXVIeGJ2?=
 =?utf-8?B?SVVPeFpYdVZwSFFyTXdCdEs1WXJnY2hPeWdBaC9kdHNwc2x5N3U3RVNHSWk0?=
 =?utf-8?B?Y0hNTVh5Wmk5K3R0ZXc2QTdwS2QxWlpnY1JIdVFVY05zOUQ0TWs4b1RFUHdi?=
 =?utf-8?B?bE5HMHZZY2lnbHVrNC9xaGJsSnQ5MUtUeXk3VTdDeW1DWFp4YmhQRS9OOFl5?=
 =?utf-8?B?ZnFzcnpJVGkrK3FiS0F3MWJPcTduOEJNdWl2M2VVVWFOVHk4QmdQaHhhK1Q3?=
 =?utf-8?B?MFh3ZndqbldyTlgxaW1CblRha2hBN1VoTHNWRmdtOXBwMGpsTVM2M05pcVZQ?=
 =?utf-8?B?aFUxbmgzdmFnZVhtbmpmY3h4QktZNTM0Z24zVGxDS3lvTWhXWGREdEpKVHhU?=
 =?utf-8?B?UDFyU2VOL2FaZEdzQ2l6aXBzbFJieUpWdU8wZHp3dmszRFcwaVR1aXZNVXBt?=
 =?utf-8?B?SUg4M2UrVEtRZGZSa1g1YWtjM1dpVXROVkVhUSsrVEVhdm9VTFBIVDNtSlV2?=
 =?utf-8?B?ZnhaQTVoYjRYcjM3OHl1R0RYOHdPYTFLOHRXdUxHODVRUGlSQ0U1ZXhubnJS?=
 =?utf-8?B?dnp4S2V2TDBWWXBtdXZVclJzMEVocjFCVTJPZzJXU0FmRkNQR2dOSjFEbXdQ?=
 =?utf-8?B?STF0cll1bUJPd0dma0c2QlpqWDJDRTZhSjhURWxTWUl5SlpJMXlRRU5UcUVx?=
 =?utf-8?B?S0djZzFYUXJhUVdZMEFXY1l0OGlnVjJBWWFiN3JZd3gvOVNobDAvVkswZXA0?=
 =?utf-8?B?N1hHZmJSZGswMjhpaXAxMXpHbUZBRk51Vk41ME5ROWdQL21vbHhHdStFNUI4?=
 =?utf-8?B?UVNXUTlzVjhFbWtPSVpyNVV0ck9CNHRUUlB0SGxUeUEwNU5kNi9OSUNIbkhH?=
 =?utf-8?B?QUZzVWszTzhXYzhZdTFTNEpoR011TEFsOWhzUWo3MnN0ZzBuaVhOcWtzL211?=
 =?utf-8?B?ODZJemE1Zm1QUXJNdThPZklTWmtEMlI1bGhrakJzc0cxSW5KK2FxWjV3Vkc2?=
 =?utf-8?B?Vk9vaDhhUXVWRXVmbU9hU3BmQzNCTUVVUytzUkRCemR5di8rVTRqL08vQmdV?=
 =?utf-8?B?WWJ2cGk4cjhZVlJpOWF5Z0ZPc0Q4N05nQmM5R0hhaFhzbC9UZWRDYlJ3RDBG?=
 =?utf-8?B?d1h1a00wdXViOWVwQTV5S0ZGZk5OMW52dlo3eE1YUW41c0NiQTRLZDVtTXhJ?=
 =?utf-8?B?Rkkxd05TK0NYVkFxWGhqTGY2UVk2VmoxUU4xY3A4QXN4TEJhNDRMaEI0R3NT?=
 =?utf-8?B?OFRlcGtWM3Q5OTZnS2hwbS9QVFhuejVXRmVpbWJvNFRxMFNmQ3d0bGwwbEM5?=
 =?utf-8?B?VHNlOFFkU2RuZWVLOTNPVXFDUG41RUNJdDNoakxaMVJvN1Y3ODNOZDI4U0lP?=
 =?utf-8?B?UUZrV1pPNFJNV1dNeE91WG5OZ1FMd25BS0tmc0cvSVUxY2FwQUl2Qmx1TWJC?=
 =?utf-8?B?czZ5UVl6cjBRREhHbUdIMTYwWlU1NlRpd1hpVVdrejR1VVpPODk5ejJuVkZV?=
 =?utf-8?B?b2ZOOTRlWDJGN3I0OW5xakIvYjNnUFQ3dWlDL2tONEhsWDMvOFpEV0xzMUY0?=
 =?utf-8?B?QWorWkgwdndOV0lIUlppcXIxcDZ1NURHNFJwWHY5d2VPd2Rac2hlRStHcE1W?=
 =?utf-8?B?MmJNLzJBMUFJMVJaL3FqckUzdEVJdUQ2Nkw5Ykwwa0l5RlpOOG1Hd0dWUnBZ?=
 =?utf-8?B?R0N5ZWZiRGxxUHlKMk1LSW1vRlFyeTJCN0dFUUw0OHg1ZWNybWM0cEZDMDBP?=
 =?utf-8?B?aVNNeDhKZjFRaURTQWRDSTZnSDd1N0FZbjB1TlN6alhXeGc3SjBXS3c5bGhv?=
 =?utf-8?B?Wml4OUsra1REMndOeHV3bmJwRkJjcFJ1YUlJclRmV0I4U2Nma1puQzNPcVJk?=
 =?utf-8?B?ZEd4b2hqd1BYdHYyL1MvWDVqTUdpYjJNWnljZHNrU2lIMUh3K3dPNXBXUG5J?=
 =?utf-8?B?TnZGWjJFQ3A4aWI3WkxLbWx4Ym94Qk5GVGJTTkVrMzgyZTRsd1I2MjkrakFY?=
 =?utf-8?B?M3FUdi9EQzJWb2JKNlV3MUIzb2k5QXF5Qkd4VERYQ2ZvZ0tXVkhMaEhmM2pq?=
 =?utf-8?B?MEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C0D2CDF1769E124DAF3EC8325C1EFA93@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a433efab-7831-4592-9a2f-08dbdb923b8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2023 10:55:31.3378
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zS6dCgXksNhbv3pnR7CFAFiDaFqPoNducKKneKC6Ty6X13yJv4d8FNGvAZdodOkcwJzUOhPBrj2zLOOo87SitA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8099
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDIzLTExLTAyIGF0IDExOjMyICswMTAwLCBQYW9sbyBCb256aW5pIHdyb3RlOg0K
PiA+ID4gKyNpZmRlZiBDT05GSUdfS1ZNX0dFTkVSSUNfTUVNT1JZX0FUVFJJQlVURVMNCj4gPiA+
ICtzdGF0aWMgaW5saW5lIHVuc2lnbmVkIGxvbmcga3ZtX2dldF9tZW1vcnlfYXR0cmlidXRlcyhz
dHJ1Y3Qga3ZtICprdm0sIGdmbl90IGdmbikNCj4gPiA+ICt7DQo+ID4gPiArCXJldHVybiB4YV90
b192YWx1ZSh4YV9sb2FkKCZrdm0tPm1lbV9hdHRyX2FycmF5LCBnZm4pKTsNCj4gPiA+ICt9DQo+
ID4gDQo+ID4gT25seSBjYWxsIHhhX3RvX3ZhbHVlKCkgd2hlbiB4YV9sb2FkKCkgcmV0dXJucyAh
TlVMTD8NCj4gDQo+IFRoaXMgeGFycmF5IGRvZXMgbm90IHN0b3JlIGEgcG9pbnRlciwgdGhlcmVm
b3JlIHhhX2xvYWQoKSBhY3R1YWxseSANCj4gcmV0dXJucyBhbiBpbnRlZ2VyIHRoYXQgaXMgdGFn
Z2VkIHdpdGggMSBpbiB0aGUgbG93IGJpdDoNCj4gDQo+IHN0YXRpYyBpbmxpbmUgdW5zaWduZWQg
bG9uZyB4YV90b192YWx1ZShjb25zdCB2b2lkICplbnRyeSkNCj4gew0KPiDCoMKgwqDCoMKgwqDC
oMKgIHJldHVybiAodW5zaWduZWQgbG9uZyllbnRyeSA+PiAxOw0KPiB9DQo+IA0KPiBSZXR1cm5p
bmcgemVybyBmb3IgYW4gZW1wdHkgZW50cnkgaXMgb2theSwgc28gdGhlIHJlc3VsdCBvZiB4YV9s
b2FkKCkgDQo+IGNhbiBiZSB1c2VkIGRpcmVjdGx5Lg0KDQpUaGFua3MgZm9yIGV4cGxhaW5pbmcu
ICBJIHdhcyB0aGlua2luZyBwZXJoYXBzIGl0J3MgYmV0dGVyIHRvIGRvOg0KDQoJdm9pZCAqZW50
cnkgPSB4YV9sb2FkKC4uLik7DQoJDQoJcmV0dXJuIHhhX2lzX3ZhbHVlKGVudHJ5KSA/IHhhX3Rv
X3ZhbHVlKGVudHJ5KSA6IDA7DQoNCkJ1dCAiTlVMTCAoMCkgPj4gMSIgaXMgc3RpbGwgMCwgc28g
eWVzIHdlIGNhbiB1c2UgZGlyZWN0bHkuDQo=

