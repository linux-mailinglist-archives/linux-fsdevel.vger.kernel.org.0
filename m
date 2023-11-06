Return-Path: <linux-fsdevel+bounces-2052-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C17E77E1D3D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 10:29:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E37791C2093A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 09:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B9B171A3;
	Mon,  6 Nov 2023 09:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bj16w45B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE2A168A3;
	Mon,  6 Nov 2023 09:29:24 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 761E7100;
	Mon,  6 Nov 2023 01:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699262963; x=1730798963;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=f1Yl7mONMt4XI3sYzMLXJntdRq7nmU0p2N73ry9ykvM=;
  b=bj16w45BtUwinfRcJrsy5kR9juzB1sG6C1Ndq7fB3ddk1u89GStFc8Q5
   gklT4oHstZdRf6yVF0fR0A/fxlQZVoBD0KFSGRe8icSk44Aqyw+fBeWmi
   y7wY9EoxtzI6iQXEmqGVNbI4YyLHNui05Ej7lYl0cvQfr04TKc69tEyj0
   2SkHxD1LGqhU5rkO0XULzPUl6H9odBXhCmLaeKCeMuG7u+9dBeE85yvLS
   U85vwVUaCVMTN2HbmcHbngo1zM2qTf+qOSLGi0TLiOnb7XQINjU4HnXNb
   /ixG3OunATLSSTrUpUgYXTKJkD1oWcee/cT5+46sX8aL9SuQAAOwbTvcL
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="386415766"
X-IronPort-AV: E=Sophos;i="6.03,281,1694761200"; 
   d="scan'208";a="386415766"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 01:29:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="1009468904"
X-IronPort-AV: E=Sophos;i="6.03,281,1694761200"; 
   d="scan'208";a="1009468904"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Nov 2023 01:29:22 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 6 Nov 2023 01:29:22 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 6 Nov 2023 01:29:21 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 6 Nov 2023 01:29:21 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 6 Nov 2023 01:29:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e6KoCyi40+RSXvlWSdVXuqoIfOhQLCCE6sJokgwlAnF2sBfDxJv9s2iutc4QV5C1e7syZ7Yb7xUH0vvuJwmOymTAMQohUPKRjiUGRPQc8rtqseyt975XRWAza9kX7woOO2xIsIO2oOGUGtB+7AhG4cml6SjdQ1Wk95473+mZvbWL+7Ih7sm/8zTEiYt+VxiPrXqKevznWV/itHYLPtxtRDfQiE6ziCjehhkP58Rd+jEwbZC4paL3v6EMLe/7Lytx10R8Mp1cg0l9ih/MghwVeflZfhahIOXjWakClbtjKh0WUIcVQRvZYAfat+epJfPzq9A2vktRamdwF20KYMpNYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f1Yl7mONMt4XI3sYzMLXJntdRq7nmU0p2N73ry9ykvM=;
 b=Jc14gycWR4OfweVFirVUPOjc3kwDL9u29tb41yX7wMmacx13d/wbLqXhcYGvUjw8WAYDulW02sAVGgWbEAn3vWDEruFxMJ4lFCriwWzfwCXJ7ssC/2BVIu+0VN9ESAMZy8aOJYpGXqYXnI3CAK5dkmVeN77UdYczaKAgcRj2jzOKShiQD0GHdeJ62v9ywXvwVJGzUktXgrsNkSBIl0HW2sV5jzzT4XFoA++XCwVmQaFROXfHS5fsNQ2FPVGLw2pA3zIwjzaqMsmXTZITokLVr/rL51IjwmpXf+ZvF2YNE7sVY7/9/zz2Z6jB+k85BTKT8BZ2Sg4E7iDNi0SKvtWUAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by BL1PR11MB5525.namprd11.prod.outlook.com (2603:10b6:208:31f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Mon, 6 Nov
 2023 09:29:19 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::5d1:aa22:7c98:f3c6]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::5d1:aa22:7c98:f3c6%6]) with mapi id 15.20.6954.021; Mon, 6 Nov 2023
 09:29:19 +0000
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
Subject: Re: [PATCH 02/34] KVM: Assert that mmu_invalidate_in_progress *never*
 goes negative
Thread-Topic: [PATCH 02/34] KVM: Assert that mmu_invalidate_in_progress
 *never* goes negative
Thread-Index: AQHaEAWHJi5fBZoopUSMc5jauL0xqbBtB1+A
Date: Mon, 6 Nov 2023 09:29:19 +0000
Message-ID: <4e64f7f303ac25ba3bfadeecf8422340a62ec1d0.camel@intel.com>
References: <20231105163040.14904-1-pbonzini@redhat.com>
	 <20231105163040.14904-3-pbonzini@redhat.com>
In-Reply-To: <20231105163040.14904-3-pbonzini@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|BL1PR11MB5525:EE_
x-ms-office365-filtering-correlation-id: e2a9d0b7-1ded-410c-9f05-08dbdeaada52
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o3yuwOL7Mz2UBulZDYlhuHCARB8gt+MpV+4t/I80BKZwRjidG9fRDIiF1Pb6IvcO0V7sVUXhZT9p1E0YEWptn+VXj19XC7/JiEIk5KFLT3wBOMAwiMklJPEulyFTWzUPDmkBh8Ky864NtzPnjYlsOW5Yv74rAu2SWuzl/fpaW5pW39dqtpe2lcQUZVrk+z4yDazZsXvAzz7Ay02VRVyXJh1V629GzNpS6CwEQPAiAJ5b7joUrrVRaoQG9dWxAx2xXk7GBM+fZd6JIxKB9OOXuzwIyHp0wkL6TLypizTj+192mQZ5rYxWF2zj1YmEViK6By7e85L/9X5DzrDhB5CUUYPr3NbuGmuIhMfX8zgIlz3PpLEwMipYUDl7PsT6B/X0o+i1Bk0gcouS9CNP6GJrz5Pudc7ahCl6ElkbMcEJsrVltdnF1/JKliSIJWVgGam61R/pnEiZ9c4L2dms9Oss4a9gpjG5LKxhvsQ5fgzGnGSGhksFaNy199qCHTAJgwjHGcOB4k7xAsoVvGlok1br8p3AGWZUrJniiL3f7z7FchARxFhpQPlqa1LNUQ4zp3+itOA+v/csteWPkj98GXRT8ihLkKtScLV9rbJsBiFNJy98qr3Cn56ED/1Wq9AtxifXKycx5ji3m4KJN2o4eMe/aQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(136003)(39860400002)(346002)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(2616005)(6512007)(6486002)(6506007)(478600001)(71200400001)(2906002)(38100700002)(36756003)(86362001)(122000001)(82960400001)(7416002)(5660300002)(7406005)(41300700001)(66476007)(64756008)(66446008)(54906003)(83380400001)(66556008)(66946007)(26005)(921008)(38070700009)(91956017)(110136005)(316002)(8936002)(76116006)(4326008)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V25ONWxyUkR4cmFzKzdBVjgxNFh5czdoeGY0MWhqMGtRb0ltVjFoUVBGbUEv?=
 =?utf-8?B?ZXJaVSttZkdQSG45dW96M3Rqc0RLRUhEQnRUNm1GazA1WGgyVDdhQTQ4R3hl?=
 =?utf-8?B?RGxVN2ZhbVZ1V0UzT1FWS09Hc2VhM3V3OHAxa2JhQnp6ZzdNUjUwdC8zTk90?=
 =?utf-8?B?QUFsWGFWOEtUK0VzTzlGMGNDR29lczZxam9qOHNhYUdHYlFFRjFJZmsxbEo0?=
 =?utf-8?B?aWM0bWtJZEFiZmNSbmpLNWlFLzNFQThMYnk2L3BBcWVBYitDcHlnRVFhUzJa?=
 =?utf-8?B?SGtnSHNBK3cwN2g3MzlIOUUxa1VZQWVZcjhyMUtIV0VycElvTnBWZEFxTUQz?=
 =?utf-8?B?VjAzQmVzVHZsbDUwWVQ1MGk0YW5OTnN0bFRUV3ZHNjcxTWZzblJQc3VnTVZM?=
 =?utf-8?B?UzJMTjBGMmRoN3oyeDRjc2RvY1JVa2pKZXNKbTlTSHdsQ2JROXpmSmVxSUV1?=
 =?utf-8?B?WkxGK1REdDlGVlJOY1pEWkJienV6QjFUaVpheVYrUWE3VC80NzhhQ0FFYjAz?=
 =?utf-8?B?N0srU05zVTF1WlhGTzlKWTRJKzZxRXhObVlFVXFsVSttaXEzR3lFa1N1dm1D?=
 =?utf-8?B?YnhXSldobEk0eCtEYk5xb3p0aEorQkFUZjRabSs4SC96K3VKeFh4OURHN1ZU?=
 =?utf-8?B?NURhOHJIWEUwZWtKMlpaS3BhSkM1Y1Q1UmYvek1WeWFtcUZ4cHB4NmFoZEMw?=
 =?utf-8?B?VXI4WG5VQW81a0xlUzBnRVJlc2NYM1NZRDlzYW55cThrSE00cEdNcW45THAr?=
 =?utf-8?B?WjVXSlQvcUE4dmY1SFBYNDFVb3krR2hONktqSDJ3ZjV5eldKcFhlaHRuRlZT?=
 =?utf-8?B?UXdVOUY1aEplRXdCN1FtUCtiMVdjaDVuQWJTUHI2bmtyVWIzNUpQVjNNelkr?=
 =?utf-8?B?UC9hUUxES2JjQ3oyMi9UNkgzR1FDenBFYUdGS2FlTDdaNnRZc1dKaUV3Wmgr?=
 =?utf-8?B?Q2l6c2dzVTFTWkxhMXJ0cURrbCtzVi82dFltaWVUVXYzVFRpNlVieTBkanI0?=
 =?utf-8?B?a3MyakRJQUE4aHBWdSs0MkI2Z2MwV0x5aXZRbDdWUjN4UnZndEppTUpIT0VG?=
 =?utf-8?B?OTJXT1NScEpWclRDTHJjTCtIeFFMejEyTnVubDk2OUhQcW9iS0k1QTZDdU5Z?=
 =?utf-8?B?aWpBdVZLeWhGYjNvQ1N3aWVHSVI4VmhnK2VSVC9wRk4vMU0wWnYxdmxyaEFL?=
 =?utf-8?B?d1pJcFFsbjFMUnZ4VUZCOStnN0pBQk9lbHNpMkEvZjlPZzJhZDNHYW90bzFZ?=
 =?utf-8?B?SGRSUzNRTHlpekZYZlBqVHJMclFOVGdKUmZNNnh4N1FrTm81QlZvVXlOMEVu?=
 =?utf-8?B?TWE0eUJXQ0RhaXlPU1B3TTBGZzBxVGJZZlh6b2dSZUtseW5rTXFUQStTendK?=
 =?utf-8?B?T09sb3hockZmSEFPQUY0UlhlNzV0SEJpYzZ4ZGQxTDJ0c1FWV0hFQ2h6eWZ0?=
 =?utf-8?B?WWs3R011NEV4V09sY0F1LzEydVZMOHBSdFRHTDFiQnJGNUJSVmQ3Y0pEa1dy?=
 =?utf-8?B?UWlIQlI0ZVd6ZzEvbVRmMlZMNW9xN0ExYXNyYVRUM0R4b0tFRGtxQUw0dm1S?=
 =?utf-8?B?RFVUbk1ETVJqb2pxTjZQdE84RTRpTyt3OWxwU2VPQW5XOE5mWUZST2xMOUlo?=
 =?utf-8?B?SWJtSlQwOE90K0Zpd1JRMldGZUVRSWxmdlhoVU80cGh4R0x5UG4yMUVlemZ2?=
 =?utf-8?B?TkhOOVd6V3BQR3FGUUF4UFdSQUtndnJZV2hCYkZYTThUbFNJVHFuaW5pUzIz?=
 =?utf-8?B?b2tpTC8zM2l2bmhqNVUwTTkxRWd1N3VoMXJmdmNkUTNYTUJteHdmTzc0VmtW?=
 =?utf-8?B?aUt4UUZ4aVlMczJ1b2IzQnFQcmpVRnVZYVppTktCZXROV1ZLblh6U2hCbFYz?=
 =?utf-8?B?bEFRSWlNTmI3VkFmanpCQ242aXJWVG5aczhRSXhqZlYxS0gyOUVjNEY0Wjl0?=
 =?utf-8?B?RnY0cThna2RnMjRjbVJDenA0RXEyWFJiVkVKdzY5N0x6Q0FxQXJqeDBuTW96?=
 =?utf-8?B?elk1T3dKZnAzNzM2ZGJBa1VseTlDcnhZR1YzTDVtaGFEdHpYRDVXMW5ad2R2?=
 =?utf-8?B?K0R3VEZUbzNxQ0tUeGJ6RmpnQUVUOGNoTnhGQlpXMkliczkrMEFOQ1dxekJ2?=
 =?utf-8?B?Wmh2NmtBa1lYZVZWN28wdlM2ZUZoTmlZM1RXV2tlaGVGeDM1QytmZ2l3Vm5v?=
 =?utf-8?B?dHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CE2EFE781FFA774BA493B98156C62FA6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2a9d0b7-1ded-410c-9f05-08dbdeaada52
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2023 09:29:19.1671
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IGD2oQupS3cWF5tTAZmZ1gGzTuQwblE77jXb4mL6vbLHW9fCGBmfVopPkEX31ZE78kvJS98OBTHFV0tfjs/3Jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5525
X-OriginatorOrg: intel.com

T24gU3VuLCAyMDIzLTExLTA1IGF0IDE3OjMwICswMTAwLCBQYW9sbyBCb256aW5pIHdyb3RlOg0K
PiBGcm9tOiBTZWFuIENocmlzdG9waGVyc29uIDxzZWFuamNAZ29vZ2xlLmNvbT4NCj4gDQo+IE1v
dmUgdGhlIGFzc2VydGlvbiBvbiB0aGUgaW4tcHJvZ3Jlc3MgaW52YWxpZGF0aW9uIGNvdW50IGZy
b20gdGhlIHByaW1hcnkNCj4gTU1VJ3Mgbm90aWZpZXIgcGF0aCB0byBLVk0ncyBjb21tb24gbm90
aWZpY2F0aW9uIHBhdGgsIGkuZS4gYXNzZXJ0IHRoYXQNCj4gdGhlIGNvdW50IGRvZXNuJ3QgZ28g
bmVnYXRpdmUgZXZlbiB3aGVuIHRoZSBpbnZhbGlkYXRpb24gaXMgY29taW5nIGZyb20NCj4gS1ZN
IGl0c2VsZi4NCj4gDQo+IE9wcG9ydHVuaXN0aWNhbGx5IGNvbnZlcnQgdGhlIGFzc2VydGlvbiB0
byBhIEtWTV9CVUdfT04oKSwgaS5lLiBraWxsIG9ubHkNCj4gdGhlIGFmZmVjdGVkIFZNLCBub3Qg
dGhlIGVudGlyZSBrZXJuZWwuICBBIGNvcnJ1cHRlZCBjb3VudCBpcyBmYXRhbCB0byB0aGUNCj4g
Vk0sIGUuZy4gdGhlIG5vbi16ZXJvIChuZWdhdGl2ZSkgY291bnQgd2lsbCBjYXVzZSBtbXVfaW52
YWxpZGF0ZV9yZXRyeSgpDQo+IHRvIGJsb2NrIGFueSBhbmQgYWxsIGF0dGVtcHRzIHRvIGluc3Rh
bGwgbmV3IG1hcHBpbmdzLiAgQnV0IGl0J3MgZmFyIGZyb20NCj4gZ3VhcmFudGVlZCB0aGF0IGFu
IGVuZCgpIHdpdGhvdXQgYSBzdGFydCgpIGlzIGZhdGFsIG9yIGV2ZW4gcHJvYmxlbWF0aWMgdG8N
Cj4gYW55dGhpbmcgb3RoZXIgdGhhbiB0aGUgdGFyZ2V0IFZNLCBlLmcuIHRoZSB1bmRlcmx5aW5n
IGJ1ZyBjb3VsZCBzaW1wbHkgYmUNCj4gYSBkdXBsaWNhdGUgY2FsbCB0byBlbmQoKS4gIEFuZCBp
dCdzIG11Y2ggbW9yZSBsaWtlbHkgdGhhdCBhIG1pc3NlZA0KPiBpbnZhbGlkYXRpb24sIGkuZS4g
YSBwb3RlbnRpYWwgdXNlLWFmdGVyLWZyZWUsIHdvdWxkIG1hbmlmZXN0IGFzIG5vDQo+IG5vdGlm
aWNhdGlvbiB3aGF0c29ldmVyLCBub3QgYW4gZW5kKCkgd2l0aG91dCBhIHN0YXJ0KCkuDQo+IA0K
PiBTaWduZWQtb2ZmLWJ5OiBTZWFuIENocmlzdG9waGVyc29uIDxzZWFuamNAZ29vZ2xlLmNvbT4N
Cj4gUmV2aWV3ZWQtYnk6IFBhb2xvIEJvbnppbmkgPHBib256aW5pQHJlZGhhdC5jb20+DQo+IFJl
dmlld2VkLWJ5OiBGdWFkIFRhYmJhIDx0YWJiYUBnb29nbGUuY29tPg0KPiBUZXN0ZWQtYnk6IEZ1
YWQgVGFiYmEgPHRhYmJhQGdvb2dsZS5jb20+DQo+IE1lc3NhZ2UtSWQ6IDwyMDIzMTAyNzE4MjIx
Ny4zNjE1MjExLTMtc2VhbmpjQGdvb2dsZS5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IFBhb2xvIEJv
bnppbmkgPHBib256aW5pQHJlZGhhdC5jb20+DQo+IA0KDQpSZXZpZXdlZC1ieTogS2FpIEh1YW5n
IDxrYWkuaHVhbmdAaW50ZWwuY29tPg0KDQo=

