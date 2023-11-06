Return-Path: <linux-fsdevel+bounces-2051-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E47B7E1D36
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 10:28:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EE391C20A53
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 09:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31991642A;
	Mon,  6 Nov 2023 09:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A5NI4Xyq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E3C15AFC;
	Mon,  6 Nov 2023 09:28:30 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35295DB;
	Mon,  6 Nov 2023 01:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699262909; x=1730798909;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=1aTHIU7N0pGV6n6pehUCBKxqGSGakbySjYNhHlMv9Jo=;
  b=A5NI4XyqiX14LkncvTEiB5TQCEdiTjWc5HQAZJ1sUzrMJL+G6OLB5EWG
   /97aMVytapJ+HRBwt6B2eQObpHU5SyaHswWZmKkk2GWhbfDDFXjos3UWx
   x1W4cSpXZZiI/nvfqSimh+I15244Q6y01QsKH+oKF/hKN8jI8POPtSPal
   Be+nmYDpz/pOIw3m1C8GTbNcYfRY5TwVByf0PLR+5f/dKMG/5HYvbUPZX
   R50pf4RFVvVYA6tLThIgIQvHw7HHUiWapbwsxDyOERudmCktLtXW7LxH6
   2T8CmLeICofw+fYFeNcW+vVwK161YbUfus/ZK4Z+LvaxLcwmI8gME4EdR
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="368574872"
X-IronPort-AV: E=Sophos;i="6.03,281,1694761200"; 
   d="scan'208";a="368574872"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 01:28:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="832672081"
X-IronPort-AV: E=Sophos;i="6.03,281,1694761200"; 
   d="scan'208";a="832672081"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Nov 2023 01:28:26 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 6 Nov 2023 01:28:27 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 6 Nov 2023 01:28:27 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 6 Nov 2023 01:28:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K8uMyAzDtMO7aspnDT6oGiUYHvXw7K328VIJuqghA68BYhOZ6iLQnCnQP/AcJYlP39v7N9j2VpzwH/gNLOzHLWjMQr8W6yvqFhmb15VHg2IzDclbq5jPASSKz6Yj7hjXsOFr/4E0LVq7VTLUAD0ISQlyW3TIabIwZRiW0ZeCvJXFM1BulzPuJh97YxMmB9ZxpUZ5S/HbrdhYbMccL1mohq9xVQfCP7WXHU5pPBYalQbN9B9gSU/w8oEB/f6PDV2I0Rs9Da9EWpY71BpSiyyENMnFqAQcL+nq7uDowmI+L7af7+BmcRBV7/MsA1rm7sm1TZirEQayIr5I/A3ZpdtBbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1aTHIU7N0pGV6n6pehUCBKxqGSGakbySjYNhHlMv9Jo=;
 b=XxM3q4/xhsgzJxxOwSuzYDy4angv5F2KIIEMkJAViiHjQhQ0ZE2Y+yvLD8LiBVf4i7bydUY3xDg3YKkBwpgAeGnyHH5bq6iArAZcy91JlPNketHWNMeHUrJdMMfh6UHtWqlH7kYWFRlcBrt7sOU4YrMtsKPgWDpPiJm/KA4wjoCIgA14NGSyac32Nbc9f0LZanbU8PP0cgTFM6MoYxxSTECJDDe157yYzXIN3maVQfdvU9263jc9tMK4fecDTbCExa4aCjKxfg43SzPt7Aq3Xf+0yfGxSsaEPKB6ADsg4TWqVwmnUsLJ9fzXS4dqLAuNjdbCujW3ubd7/2B8acOREQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by BL1PR11MB5525.namprd11.prod.outlook.com (2603:10b6:208:31f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Mon, 6 Nov
 2023 09:28:19 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::5d1:aa22:7c98:f3c6]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::5d1:aa22:7c98:f3c6%6]) with mapi id 15.20.6954.021; Mon, 6 Nov 2023
 09:28:19 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "Christopherson,,
 Sean" <seanjc@google.com>, "brauner@kernel.org" <brauner@kernel.org>,
	"oliver.upton@linux.dev" <oliver.upton@linux.dev>, "chenhuacai@kernel.org"
	<chenhuacai@kernel.org>, "palmer@dabbelt.com" <palmer@dabbelt.com>,
	"aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, "maz@kernel.org"
	<maz@kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"mpe@ellerman.id.au" <mpe@ellerman.id.au>, "paul.walmsley@sifive.com"
	<paul.walmsley@sifive.com>, "anup@brainfault.org" <anup@brainfault.org>,
	"willy@infradead.org" <willy@infradead.org>, "akpm@linux-foundation.org"
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
	"chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
	"linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, "Annapurve,
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
Subject: Re: [PATCH 01/34] KVM: Tweak kvm_hva_range and hva_handler_t to allow
 reusing for gfn ranges
Thread-Topic: [PATCH 01/34] KVM: Tweak kvm_hva_range and hva_handler_t to
 allow reusing for gfn ranges
Thread-Index: AQHaEAWEPzKX68JGHE+jPckwg3K537BtBxiA
Date: Mon, 6 Nov 2023 09:28:19 +0000
Message-ID: <53be446a44f2755325c44d38f987a9ea4207ac62.camel@intel.com>
References: <20231105163040.14904-1-pbonzini@redhat.com>
	 <20231105163040.14904-2-pbonzini@redhat.com>
In-Reply-To: <20231105163040.14904-2-pbonzini@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|BL1PR11MB5525:EE_
x-ms-office365-filtering-correlation-id: 18be1be9-b602-4162-2ca8-08dbdeaab6cd
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1bd/GRtqVArAs5/48QhaHvz/IGjR0ZAWwGSOg0BQ/vBto4a7uvbvokINIIk9VNwkEW2ic0Uux5H9JoywPjD9/1KxCVRBTxMHOMoNpEVJBL7mDFS8//uOto4sVwsA0eL50X7xjaESiLZyk2JCN2f36gHnUd16RxZX+vBQnWjPXekwhxcLYRff7RhTbOYUtkZhDsRjILsX+lbrunvO+tOzNlXMf/aa9TQTrIZZvIg4TVWQ6lh2upptC6TQwi/nom/GedBF4bpu66mP20RAO5BirqWQ4rj5Ugwj5kmwIRSbU+N4ap77kp6D4M92XF9m8zIpvd/y2Q/4LXMVfuxkeXV3TQO7xHqlqFu44IWOkJkLKYQKN7jYqfMAWDci2AWVddXsg5jrUT3bsIi9wxZuitUOHti9S9DGZeGo3l40xtHB7do/EaY+VDo4rpkh0ZPciijmeXBY/Q2ZmDv1CNIb9KmRFZN3U9CVHDi6R/qKtsbs3xcreyW2Hu2iT1Soz7kc7sudSTx5LHHW7pQSB5Zdy5/iEZBpvjZeeXWLHVgQKRfK0wJITVWUfDG3FR3/ncMbBEQBvZOmwCn4EYekB1lsIs4c5XR/NIMV4bv1Q17USUejrc4ae/1uONwSVAno/CblXxUim5eJlev590QIPJucX7w2ZA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(136003)(39860400002)(346002)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(2616005)(6512007)(6486002)(6506007)(478600001)(71200400001)(2906002)(38100700002)(36756003)(86362001)(122000001)(82960400001)(7416002)(5660300002)(7406005)(4744005)(41300700001)(66476007)(64756008)(66446008)(54906003)(83380400001)(66556008)(66946007)(26005)(921008)(38070700009)(91956017)(110136005)(316002)(8936002)(76116006)(4326008)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eHc5ajNHcG1BYittSGpVbzJCZEpLcmlnMW12bFpOcFAyOWtnZS9HYVpOa0ZB?=
 =?utf-8?B?TGxaUFlWRnVXZnJkckVQYWhnaFVWMFpjOVVmR2tsMkZnSmV6T2hZMHZEMWwx?=
 =?utf-8?B?dWFlUlBDTis4b1RCVFdZTHgzSklxTFVPL0F3Y21zNEplOEhKWWxQZGg1ZUhP?=
 =?utf-8?B?bGdzWFFxZDUycFRRTWJNa3phTEdtMXZYVDhTT3Z3enZDS3IrTnB0SnNuazdq?=
 =?utf-8?B?MWZqL0IyRXhhRWhnSVhPbUMyNUw5VENnS2Z2SzZvUnoyQ214U3NHN0F6dUpu?=
 =?utf-8?B?cFdMQk0rWGZRMzR5d1YwWExWY3gwRy9UN2lrVU1Cc2FkNExEay9MaStUVDlr?=
 =?utf-8?B?WDgwcmg2cU5wVVJkTEIzREtueDdvaVJqMjdGaFFuS1Zncnhod3dock1VSDdw?=
 =?utf-8?B?MUVZNWlxZU92L3RQTnB6OElmR0Q1NzRFdytlblNOd05qYi94RkwxOGJ4ejFm?=
 =?utf-8?B?dHFKM0NjK29BeTNXWTA3WlRXZGhzN2NKRy8wS2djUVJTejZiSnFPSDgzN3ZH?=
 =?utf-8?B?bG1sRURYd2hFK00wRHFCcEs5OWNRTzZxQmNTTTdIQ0JlbWdCdXpHSEd3Lysw?=
 =?utf-8?B?dUpVcHpQVHg1eXR6Mm5GaTFVY0laMklwNENrNHM2N0RET1prdXp1c0RnSFNL?=
 =?utf-8?B?RlRmRFN5ejd6Q0JvZXorU1J2OEVFckpqRTNNMTI3SnlvRGFCZk8wRCtJZWxi?=
 =?utf-8?B?R21HV09HN2xGOENXNlM4eGVCWlM1M1VLRjF4NTYrZmk5bTRydWpLMjgvYmZz?=
 =?utf-8?B?akllaFBUeWNxNDBGdGFaeENpaDZLS09BM2M0a05XdWhYTW4raVFPa2lkSG1D?=
 =?utf-8?B?OThFUHIwZ2FTazR0bDdXcGQ0V2EwTUVobFR0OHZtZTcvdVNQdkE3Q2NlMnpq?=
 =?utf-8?B?Mk9lY3g0SHZKdUJJL3UvendQUExYeFVvUElrcXBEb0srK1pqZmhJZitsSnht?=
 =?utf-8?B?RjBYbHlGSlNySURKOW5RdENUcEVDN0I3RkJDK2hiMEI0eVVYMGFVT1dUZnhJ?=
 =?utf-8?B?YnZEeEhyZzdIUmFIT0JNOEtJRzcyUjRBVUNOdXN1a0dnSkNIWkFOSlFIdXVS?=
 =?utf-8?B?bzBNRnJ1MmUwMEhqZWxKTWc3ekdZM082R0lBay9JZGNQT3JNQ3U5Q1NDQ2dO?=
 =?utf-8?B?R2t3U29TbXBmZkxrQXRtTlpZWGZ1SGZqNTdKaVJvOG1KOHZwV29oa2lvWEpG?=
 =?utf-8?B?TmFaUDIxTU5jeURNaW5pTEdmSm9EN3E0a1ZLYzFqekplME1IUXJyZkZjQ1U4?=
 =?utf-8?B?cndaNUpmZVVxdGZlQmdaUjh2WXE4ZDh4dWw4YzYyOVNraEYrUUlWVU9URGVS?=
 =?utf-8?B?MTNlQWNSb0RGeHRPUEhySWVSRTFad215Z2dCNDNpT3BvS0tCL2JtK0ErUDNj?=
 =?utf-8?B?R0dlYURRbjlpUDFzVHpLZ0pMeS9ud0hEbkFkZnErRkg4TXJYREtuSTlBUnVH?=
 =?utf-8?B?Qm5CdS9UM01EMjdhbjNCZE5Oa0xxL2xtMnpoeEh5aFFYNmVDQjluNng5T0pz?=
 =?utf-8?B?RTlXMlJ6ejQ0UHIyblJoSGJwSGk2SjI1OEQrMVFWdFdzc2VCOGdGLzdFbXpx?=
 =?utf-8?B?bzhudzVVUkh1QlZ1NE9GSk5BVksvdW4zWkVlc2tza2FUbGcrdUFtbCt3WHNm?=
 =?utf-8?B?cWU4d1hGWkFmS0NVa1V3K2pIeit2aVIwTjZUeU1vc1RhaEI3WnQrb0x4bjB6?=
 =?utf-8?B?RC9qMUt3OUF4dXpUK283dVU3eGNPTjlLNzJYU3E4c0ZSNCtXZmlObSs1UWN5?=
 =?utf-8?B?Y0VJUWhuamh2VUtScHZ3OENjeUYyalBTYk9DRHN2ZW0wako2Y291a3Q0V2VR?=
 =?utf-8?B?WXB3VllIckFJeXYxanVpWDJESXhSZEhhVFJBMzB6VUhWVHhSenRMWkpwZGho?=
 =?utf-8?B?VEpRMnU3dm5pODhkVExSejBYTGVYbnY0K2Mrb0xDQTRpQStCdlJXUmhHRFZo?=
 =?utf-8?B?VXA0dDNFa3dtT2p0cGYveTRKS3lwdHpOTkhqZ1ZwVHJYRFEyd0hMMjk5QTlZ?=
 =?utf-8?B?Ylk2Wmw2TUJ0R2hUeGlqZENLSWpuUFhaVlRPbXo2M3BWZ0pOZkZRMDVSeUtC?=
 =?utf-8?B?MnZUTG5LaTNNNzREMVlNODBFSCt0NVZ2MWN4dEJVRWdrS2x5ejVNa1NiTEJa?=
 =?utf-8?B?SG1ZMGUvVlFDaGJsc0c3amhybXZlTWhTbjhmNHlXemtMWU4yQ0NYbDBCYjls?=
 =?utf-8?B?RUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2902AC67C7058F4AA11BC316C8195C39@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18be1be9-b602-4162-2ca8-08dbdeaab6cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2023 09:28:19.5326
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NPHPgjtzEY8mAK4jG9bIOO7mIvbeLkbu+1vl2asBYzF7QN1XheGKfZ+nsQFXoHdDAeSjGmxxfQbqEk5I42IpAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5525
X-OriginatorOrg: intel.com

T24gU3VuLCAyMDIzLTExLTA1IGF0IDE3OjMwICswMTAwLCBQYW9sbyBCb256aW5pIHdyb3RlOg0K
PiBGcm9tOiBTZWFuIENocmlzdG9waGVyc29uIDxzZWFuamNAZ29vZ2xlLmNvbT4NCj4gDQo+IFJl
d29yayBhbmQgcmVuYW1lICJzdHJ1Y3Qga3ZtX2h2YV9yYW5nZSIgaW50byAia3ZtX21tdV9ub3Rp
Zmllcl9yYW5nZSIgc28NCj4gdGhhdCB0aGUgc3RydWN0dXJlIGNhbiBiZSB1c2VkIHRvIGhhbmRs
ZSBub3RpZmljYXRpb25zIHRoYXQgb3BlcmF0ZSBvbiBnZm4NCj4gY29udGV4dCwgaS5lLiB0aGF0
IGFyZW4ndCB0aWVkIHRvIGEgaG9zdCB2aXJ0dWFsIGFkZHJlc3MuICBSZW5hbWUgdGhlDQo+IGhh
bmRsZXIgdHlwZWRlZiB0b28gKGFyZ3VhYmx5IGl0IHNob3VsZCBhbHdheXMgaGF2ZSBiZWVuIGdm
bl9oYW5kbGVyX3QpLg0KPiANCj4gUHJhY3RpY2FsbHkgc3BlYWtpbmcsIHRoaXMgaXMgYSBub3Ag
Zm9yIDY0LWJpdCBrZXJuZWxzIGFzIHRoZSBvbmx5DQo+IG1lYW5pbmdmdWwgY2hhbmdlIGlzIHRv
IHN0b3JlIHN0YXJ0K2VuZCBhcyB1NjRzIGluc3RlYWQgb2YgdW5zaWduZWQgbG9uZ3MuDQo+IA0K
PiBSZXZpZXdlZC1ieTogUGFvbG8gQm9uemluaSA8cGJvbnppbmlAcmVkaGF0LmNvbT4NCj4gUmV2
aWV3ZWQtYnk6IFhpYW95YW8gTGkgPHhpYW95YW8ubGlAaW50ZWwuY29tPg0KPiBTaWduZWQtb2Zm
LWJ5OiBTZWFuIENocmlzdG9waGVyc29uIDxzZWFuamNAZ29vZ2xlLmNvbT4NCj4gUmV2aWV3ZWQt
Ynk6IEZ1YWQgVGFiYmEgPHRhYmJhQGdvb2dsZS5jb20+DQo+IFRlc3RlZC1ieTogRnVhZCBUYWJi
YSA8dGFiYmFAZ29vZ2xlLmNvbT4NCj4gTWVzc2FnZS1JZDogPDIwMjMxMDI3MTgyMjE3LjM2MTUy
MTEtMi1zZWFuamNAZ29vZ2xlLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogUGFvbG8gQm9uemluaSA8
cGJvbnppbmlAcmVkaGF0LmNvbT4NCj4gDQoNClJldmlld2VkLWJ5OiBLYWkgSHVhbmcgPGthaS5o
dWFuZ0BpbnRlbC5jb20+DQoNCg==

