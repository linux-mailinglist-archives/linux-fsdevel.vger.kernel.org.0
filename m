Return-Path: <linux-fsdevel+bounces-1873-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F1367DFA01
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 19:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A02261C20FEE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 18:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E217B1CFBA;
	Thu,  2 Nov 2023 18:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K+2IY0Fr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA3414274;
	Thu,  2 Nov 2023 18:35:35 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 450EFDB;
	Thu,  2 Nov 2023 11:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698950131; x=1730486131;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=4oJXWL25r8xbMStnOC6PXzlKG7Q1Fs8jN08h1AzJKmk=;
  b=K+2IY0FrhkkZA7YSvIV54qrxGGhCU/+bLab16XX6Sahst2YxOG2Dew1p
   u0wo6ao8mLm/Y28uzI6Bfkhb6eyPJWG/EKSwKGYGuvmneD8Z5sez78dSf
   xoU6Xd5M4q8Aru9GvbrwNwCvCTI//ZGNs7rX/juSm2X8rtoZuJktsbpin
   1jmqD0d2sjXWtFPQ8wLiw+9spfy/KwQllmBln6C8a/Mbi3UeKb3WeYNzf
   eo3jEEOP5f2CSsoUaBaXpauMZSMWVTwbv55dJMW2nZaNybEhhBZfVOGB3
   J4AzBRUkVHDKVFH1q2DNghWSuOKdvxg2BDP3uAmY89VGU/+MKsTx3KM5B
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="368990407"
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="368990407"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 11:35:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="1092816011"
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="1092816011"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Nov 2023 11:35:29 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 2 Nov 2023 11:35:25 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 2 Nov 2023 11:35:24 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 2 Nov 2023 11:35:24 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 2 Nov 2023 11:35:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m4e8qDAxJmTBl78NqRbCoIXqMGxbah7WG7icyWf9KAb8AuKeiZgiItED81qLL8xqXQWC1NrVEnMWK3PMxaBoF4MYPsQC+LoICbksOEoeipxb8xoniXLrSLLyccx8whWqvFC/NDMqw4hka+Gz1s19/BaO0DgMNT6rI4jc8LoQ8+/AJXd3XHwuLkYVbsfxFxU2E04Yizotn+7MTP/3hs4hBVZZJN4+zR6zvvlh2tjiCWzDGSvxOqyymcJGz3n2qF6LiSV8AfRN+2CROq1fk4cbAP5UV11+EfJ4JlIIz354x4uOjJXWJx2RJLWOyfpADqSCDE5VsVTCdiqy+FJp2IwTsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4oJXWL25r8xbMStnOC6PXzlKG7Q1Fs8jN08h1AzJKmk=;
 b=BOrLXBUhR6oh02CrBAOGFE4IS93T7CLhdoGnAG7s8WAEwNb928Bh23UdQ9kj/NTOf/XLe0m7DNrpGFwfa9jGp8D2yErjM9rDICAHS+Aa0DeSE5W1urhnvN5gH/tJLzWnprWlg63s7lrjTiMhV0/pgwc4dOiCdx+TrLYjRGDMkwOj5ETOi/s9etCcTOd3VJYqKzb3NeKYtqbbP6Ks2gi0luZ7lBJhpwUYX73SdTrQp8zwZeWXjrI20Orf9o5ei6I8YUQed6LgvKX5ZzSVzCibPF9PsnOSnEdRB3SeUh2c03xSHU/4Psjt6sqvn/E+YYJLNXMg30nNqfa4nlimq6WHMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by PH7PR11MB8569.namprd11.prod.outlook.com (2603:10b6:510:304::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Thu, 2 Nov
 2023 18:35:21 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::5d1:aa22:7c98:f3c6]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::5d1:aa22:7c98:f3c6%6]) with mapi id 15.20.6954.019; Thu, 2 Nov 2023
 18:35:21 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, "Christopherson,, Sean"
	<seanjc@google.com>
CC: "Li, Xiaoyao" <xiaoyao.li@intel.com>, "kvm-riscv@lists.infradead.org"
	<kvm-riscv@lists.infradead.org>, "mic@digikod.net" <mic@digikod.net>,
	"liam.merwick@oracle.com" <liam.merwick@oracle.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "Yamahata, Isaku" <isaku.yamahata@intel.com>,
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"david@redhat.com" <david@redhat.com>, "linux-mips@vger.kernel.org"
	<linux-mips@vger.kernel.org>, "amoorthy@google.com" <amoorthy@google.com>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"tabba@google.com" <tabba@google.com>, "kvmarm@lists.linux.dev"
	<kvmarm@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "oliver.upton@linux.dev"
	<oliver.upton@linux.dev>, "michael.roth@amd.com" <michael.roth@amd.com>,
	"chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
	"palmer@dabbelt.com" <palmer@dabbelt.com>, "chenhuacai@kernel.org"
	<chenhuacai@kernel.org>, "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
	"mpe@ellerman.id.au" <mpe@ellerman.id.au>, "Annapurve, Vishal"
	<vannapurve@google.com>, "vbabka@suse.cz" <vbabka@suse.cz>,
	"mail@maciej.szmigiero.name" <mail@maciej.szmigiero.name>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"maz@kernel.org" <maz@kernel.org>, "willy@infradead.org"
	<willy@infradead.org>, "dmatlack@google.com" <dmatlack@google.com>,
	"anup@brainfault.org" <anup@brainfault.org>, "yu.c.zhang@linux.intel.com"
	<yu.c.zhang@linux.intel.com>, "Xu, Yilun" <yilun.xu@intel.com>,
	"qperret@google.com" <qperret@google.com>, "brauner@kernel.org"
	<brauner@kernel.org>, "isaku.yamahata@gmail.com" <isaku.yamahata@gmail.com>,
	"ackerleytng@google.com" <ackerleytng@google.com>, "jarkko@kernel.org"
	<jarkko@kernel.org>, "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>, "Wang, Wei W" <wei.w.wang@intel.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [PATCH v13 09/35] KVM: Add KVM_EXIT_MEMORY_FAULT exit to report
 faults to userspace
Thread-Topic: [PATCH v13 09/35] KVM: Add KVM_EXIT_MEMORY_FAULT exit to report
 faults to userspace
Thread-Index: AQHaCQKnsgoTcbnsvUKkAITO6oVjaLBlURAAgABw5QCAAKIkgIAAabmAgAAYoICAAE6SAIAAL52A
Date: Thu, 2 Nov 2023 18:35:20 +0000
Message-ID: <55672e5b0ff9855e609654b6565f610dbffa56fd.camel@intel.com>
References: <20231027182217.3615211-1-seanjc@google.com>
	 <20231027182217.3615211-10-seanjc@google.com>
	 <482bfea6f54ea1bb7d1ad75e03541d0ba0e5be6f.camel@intel.com>
	 <ZUKMsOdg3N9wmEzy@google.com>
	 <64e3764e36ba7a00d94cc7db1dea1ef06b620aaf.camel@intel.com>
	 <32cb71700aedcbd1f65276cf44a601760ffc364b.camel@intel.com>
	 <496b78bb-ad12-4eed-a62c-8c2fd725ec61@redhat.com>
	 <ZUPD9NWF4eOXqeiA@google.com>
In-Reply-To: <ZUPD9NWF4eOXqeiA@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|PH7PR11MB8569:EE_
x-ms-office365-filtering-correlation-id: 6c262d30-ad01-4b01-2c8d-08dbdbd2783f
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: j3uZNaCZvdCzNMGqtDN0+rdpxIFRVPBLxF/CjG7lG3Xa+Ui5Qjvnb7mGmqYkfkUfyivZW+FLFZkviN8A3igp1+DycPu8dvuuuOb2Orinl+cRyimwNUxKZAjczWuuzX5vIMSc+ekupO+eruVbg1rJ6jwUlPReD/G7aJ4gs4CjthiMjg1T3cTu6qoZ35dyIi8Xvr9SbeHqkySHmZPDJ+5sgDcMuz9ulqVRSiAhgtT8I6jU3WOsiWM9tyzzoK92mm24z2jW4Qor5OzxPv7Q/hXAA/kfycLLH2b2de0frtXQm0bubrOKilvNHUsopOEWp+XvL3ZRH70pX1S3YN9N1dFGU5zg7/BPMOXnA9FMmX/0NIpco58O9poYbfMJgLIjSbhrNvCSaYnqrdRxvl9H/EfghP4OUcxMvPVLUjAWy11jZ1UJKB/fiWpWh1UoG0YwrPAV2QKVKn0vnWPyWyHSjCZrE8ur4PPL2iYI2O5qgrx+X/7nrDqny3kHixg3nFjPsDZlDRiKOM4uNFGBDyCitTzf0U0KOCJaU4HJaj17W5IBd2d8l5L+qHSj4xe5p1j83Kee0BMlsmPKS//4hLDsiPc3JrQ9ZDqv7QcMgQu+nl3tIeDBg5/y6n8Aqafd4MPbYQ1d
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(39860400002)(376002)(346002)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(53546011)(8936002)(6486002)(4744005)(41300700001)(7406005)(7416002)(82960400001)(5660300002)(2906002)(86362001)(122000001)(64756008)(6512007)(2616005)(71200400001)(110136005)(4326008)(38100700002)(8676002)(91956017)(26005)(66446008)(66476007)(66556008)(66946007)(6506007)(316002)(54906003)(478600001)(76116006)(36756003)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q1k4ekpoMlF3UnM1bGtXNGtqdG0vQkxsR1lNSEdXdjVHVFY4cE10ZFlXc2Vp?=
 =?utf-8?B?ZlhmSkRkRmUxVlpUdjhqaXYxRmM4K3VRcXRkMGhpNHF5TnZ6UjFzQVFCL3Vo?=
 =?utf-8?B?MDk0Zi9mOW1rK2VJVy94ZHRJR3ZreWE5L1VNNVVsT3NRRlhSTGNDRE9WcHVU?=
 =?utf-8?B?UVIva3h1cHRiRWlaT09TclBrS2ZYRmVIK1NGWHZZa2NkTnpWWDFLTldoa1hx?=
 =?utf-8?B?djdLWUNlWHA5bTkzMW9oV2hOZGpuUmE3UlY0R2ltbnVvdnNIa1ZOTW13Znpk?=
 =?utf-8?B?M0hkS0tsNFY4d2dpQ3lWRkJjblNZRVRIQ0k4SXJOVlFzdCt0S2IrbVpCWlFO?=
 =?utf-8?B?TTQrYmhHRmt1ZjZXdE9ISnZUaHhlYVNsUlJwQUprSDI2VGx5WXlXVnJDOFRO?=
 =?utf-8?B?RXI4SjBlZXN6cUxYTkJYeDVxcnZHNHpRdnczZ21NYVg3UE0xL0dlTjUzVDJo?=
 =?utf-8?B?eTJIY0g5K1FkOXNOUHpXQlhsUllxYUxLaC8rc2l0TWg3ZkV0U1N6QUtOVVho?=
 =?utf-8?B?Q2Z5cE5zTi9TdlEyb3RBQ3FhazhBME1GRjV2bG5tMnlHa3ZmYTZzbGUzc0tO?=
 =?utf-8?B?UHRkeGxSd2tVNll1QW5jMVFzQ1o1N3l5Rlp3ZnhFVVFhZ3JMbEpBRHZZTkhI?=
 =?utf-8?B?emkweEp3UmhaYVZTZHpsVHF3L2xEUUN4Y092bXFOZTEwdHpOczhBd2V3TnhQ?=
 =?utf-8?B?Mk96TGZwRWxVSEVoU3ZuaVd1S0VZOXRHNnNTcHM2Mi9pYTJsV09hb0RGSDlv?=
 =?utf-8?B?SGhKV1lOdmRpUEwzYytoYzFubGwvR1lnUHUvRmxwNVBuL2dYbkFELy9aY3Js?=
 =?utf-8?B?WGNjLzN6dUlUcmprRlFnN0VWM1Fxb0lkZTFuWWhyR0M5Ymx4RE1xcGludU1E?=
 =?utf-8?B?bU9Pd1NNR3R0K1RIc3V1akdVbGRJcitaOVk5bFhRb21yKzBXYjAyd2srclZk?=
 =?utf-8?B?OVg2RGc3cVJHc1pJUk5halRQMlhadjFDQlNNUXY5VnhZbndsc2Nid0JBQlZX?=
 =?utf-8?B?WFBDTnV3ZnlSSHE0SnF1VVV5L25NZ3g1L1pXNEk3VDRBNjQ0VnJKM1gvY0tF?=
 =?utf-8?B?TFRCa2NrN1BCMzIrdVpNOStzWGpLTWNHdE1YNG1hZTU4UmpKQTdSMGIyTlBi?=
 =?utf-8?B?KzBDRGRhV1hjSzE0U0FIcFNZOXRrc3Y5UjFsN2x3emw5T1pobmlhaHpGeXUz?=
 =?utf-8?B?NEYwNHFZSi81UkpVaUlrSWRUc3VzQlRvZkZpWUd5eHhncThsK0lLK1Mwbm9M?=
 =?utf-8?B?VHFYK3ZPdVFxNkVINjBXTFJFSlJuVk0vSnhzeXFPM2dxOS8wY1g3dThiaENW?=
 =?utf-8?B?VldsaU5JckVxdG1ndENOSGhhNmdDQXZIejFta2FGa3hCeWs4N1BsTjU0cXp3?=
 =?utf-8?B?WTR6VDNtNjEwWXdMdS94aEdsSnEwemtTYy95MU80M01Rbk5qYTNzVE5nMzRT?=
 =?utf-8?B?M1hIb3RNRzdMSWRKTXd0ZVNwSkxQREVaREo3byt3VndmTlZ4VnVyNkRKWGow?=
 =?utf-8?B?RUlFb1haVVdVaWphL2hPVnliRDNtaVlXU1F3cjd4YjVxMWxzZFUwZkhiNW02?=
 =?utf-8?B?UEtkY1RHSVBYOUVVZG5hU0lIZWowTmpXeHFxTFY3a0IvamxDTWI2UFMzR0VX?=
 =?utf-8?B?a3hZV25hOVRQQXdBT1YxcGordjBOVkJNbFczdDlOVjE5dnZwY3Y5S1dTVjZJ?=
 =?utf-8?B?OTBjQjRNMjh4cmtHUmI4VnRzL0x1bncxdUFPQXNjeFYrNk9ZUTFOUkpFTVJK?=
 =?utf-8?B?WUFqaFo2eUNRcFN1TFBKSnJHWWc0QTI2ZHFjdVRIYnJQMGsxU0wyTWVVR2Jh?=
 =?utf-8?B?M3ltckwxL2VWUWZLaW5EZVNtN1hBczVyVGFFTmY1TGE1cjFyUHlqUlUzeC9W?=
 =?utf-8?B?b0trOGdnMXpSZm9pOVdHT3JhSlh6OFhORERxV3pGZVNSeTVmbTlMb0VxZUtW?=
 =?utf-8?B?ZkIvTkxvandDWmpUbnIwY0o3aVgrUlhWMXQwWWkvL0pRMG5EVmJoSUdPZ2c2?=
 =?utf-8?B?S2FTQjRhRkpPdUZVdzBFS0RSQmlCakJXZ0k0SGhFeEdjZGJLdlBIZmllbXZQ?=
 =?utf-8?B?UXRQam84RUpEY3R6a2pVbFc3cUw3bUpSa0VTcm8xdVZpWXl0bnFaV3oxQnZH?=
 =?utf-8?B?VUo2MUJpWDkveUtRUFFqenNNTWY5d2lGd2xoWi9obUNUK0ZkYThBaDdQVzVu?=
 =?utf-8?B?Y1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <74FDCC177320F944ACB608818902ED2B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c262d30-ad01-4b01-2c8d-08dbdbd2783f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2023 18:35:20.9909
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zUiB7sjiAJFWGCDvsC2fya89WUgLrQktgTA54FTIl+YS0tOPPjSCxLxojusYR00iLQv/Q+nyMtHF2qCDVBV86Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8569
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDIzLTExLTAyIGF0IDA4OjQ0IC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOgo+IE9uIFRodSwgTm92IDAyLCAyMDIzLCBQYW9sbyBCb256aW5pIHdyb3RlOgo+ID4gT24g
MTEvMi8yMyAxMDozNSwgSHVhbmcsIEthaSB3cm90ZToKPiA+ID4gSUlVQyBLVk0gY2FuIGFscmVh
ZHkgaGFuZGxlIHRoZSBjYXNlIG9mIHBvaXNvbmVkCj4gPiA+IHBhZ2UgYnkgc2VuZGluZyBzaWdu
YWwgdG8gdXNlciBhcHA6Cj4gPiA+IAo+ID4gPiDCoAlzdGF0aWMgaW50IGt2bV9oYW5kbGVfZXJy
b3JfcGZuKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSzCoAkJCXN0cnVjdAo+ID4gPiBrdm1fcGFnZV9m
YXVsdCAqZmF1bHQpwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoAl7Cj4gPiA+
IMKgCQkuLi4KPiA+ID4gCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqAJCWlmIChmYXVsdC0+cGZuID09
IEtWTV9QRk5fRVJSX0hXUE9JU09OKSB7Cj4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoAkJa3ZtX3NlbmRfaHdwb2lzb25fc2lnbmFsKGZhdWx0LT5zbG90LCBmYXVsdC0+Z2ZuKTsK
PiAKPiBObywgdGhpcyBkb2Vzbid0IHdvcmssIGJlY2F1c2UgdGhhdCBzaWduYWxzIHRoZSBob3N0
IHZpcnR1YWwgYWRkcmVzcwoKQWgsIHJpZ2h0IDotKQo=

