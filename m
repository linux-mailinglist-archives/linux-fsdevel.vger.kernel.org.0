Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5034A7583D2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jul 2023 19:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232324AbjGRRsT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jul 2023 13:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233046AbjGRRsO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jul 2023 13:48:14 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 655C21986;
        Tue, 18 Jul 2023 10:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689702493; x=1721238493;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Cb30eSAxJkQu278Wu79OF8aJOrCpjg1rjlb40nIq6wY=;
  b=nEZ/EnczIAv4e5ieEkX3p6UfPDbaPef5mgGsU4dXzYq1dA5Zm/QolRXq
   0Sx/mJCTr5t2ZeGE50zIK2lyNOKR9ddOam9RtniKQLHppAuSXC1hw5gV8
   rofSZ4utB8phJXcKiiXNhgyCmXbUedvwTA1VlfS1DjazWX0CSnlj4+PDh
   Puoup4C58edSBD1qs7XJuN/AZwBAeKEKFzNOQJTD+IVu56m0dBZOjCNYl
   jRAULUYC/WV2x7HVKhceokdRy7a0v443Qqi2qOP3ys/kArjfIH/6mDopA
   2DYn97UVsAvhey4A0pQTRimiDT/lnGAP1uKxX+hJlwxiHWZ9kg1sKPYbM
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="366314753"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="366314753"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 10:47:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="1054391593"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="1054391593"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga005.fm.intel.com with ESMTP; 18 Jul 2023 10:47:35 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 18 Jul 2023 10:47:35 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 18 Jul 2023 10:47:35 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 18 Jul 2023 10:47:34 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 18 Jul 2023 10:47:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FoktNnV67oLuIXOqs91MRpyE/WGkaoF8sJAEemM1BkMk4Rm33AhiI3ThemoAvF5Ct/sch6luFen13hJMIKw6xI9QFNwRQymSYHkStkRlFpbVL7i9eN0yT49Tf15lEr/yPFVGpGKWoQZJvoLCSd6F/lpt5rXrv1CTVL/Hz1IWhcQDDTLJYaBHK9udTfTU3Z53V5MV3pYyHT8zaraEbMIA0xyBchu3lS/SCXBmkukS2CAXG/pEk9QtbdmPDVyaPIJSwfT/DdZusokYQSLiZaKA1pWO7nr+eb2xnjBRuoXO5TAi54Drt8CZ7wkNLaQq2Y2/rOulTuNLDXepIIJ3znsBaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cb30eSAxJkQu278Wu79OF8aJOrCpjg1rjlb40nIq6wY=;
 b=WU4b5xmyqZDAoupGT2FXeGqBx/adjZ6fC+pnq3k6n5nP/SYYPqcUqopCCuRSk2gcS4AioIS6a+fiVaNPQJkdmDc5QkpObhvUbn9ZEHsTEuklUU6TQ/swQeF8hgpsySUWsiMhsJtGhEA7QNvSk8AnCkbbaeB6e1ojuarxMgoEF3hXRjPFXrfU5ivQA9KGUueb1O5Xnyy34S2qplmhNbcZIz6EqD3yGQEJDCkb55Gk39ZPXsqzpB/WT0kmto5K5F1+XtMjshtmDVTDkKOFEjXmVAqBx8e6TTlitJYoI8ZwGT0BeR+4schet2cQHr6yf3oEtCHDgkAKykS2oFSj1GBC/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by SN7PR11MB7707.namprd11.prod.outlook.com (2603:10b6:806:322::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32; Tue, 18 Jul
 2023 17:47:32 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::abd2:f781:1433:259]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::abd2:f781:1433:259%3]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 17:47:32 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "corbet@lwn.net" <corbet@lwn.net>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "maz@kernel.org" <maz@kernel.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "Szabolcs.Nagy@arm.com" <Szabolcs.Nagy@arm.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "will@kernel.org" <will@kernel.org>,
        "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
        "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
        "broonie@kernel.org" <broonie@kernel.org>
CC:     "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: Re: [PATCH 02/35] prctl: Add flag for shadow stack writeability and
 push/pop
Thread-Topic: [PATCH 02/35] prctl: Add flag for shadow stack writeability and
 push/pop
Thread-Index: AQHZuC/roOlukFBqMEenGz5meOCqe6+/z3qA
Date:   Tue, 18 Jul 2023 17:47:32 +0000
Message-ID: <a236d8bb1593035252f7094b6461e4d2c5b432a1.camel@intel.com>
References: <20230716-arm64-gcs-v1-0-bf567f93bba6@kernel.org>
         <20230716-arm64-gcs-v1-2-bf567f93bba6@kernel.org>
In-Reply-To: <20230716-arm64-gcs-v1-2-bf567f93bba6@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|SN7PR11MB7707:EE_
x-ms-office365-filtering-correlation-id: 9a8c28f1-7acc-4bbd-6222-08db87b71027
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x1EQ3gTEjJ6dvkfUd6Kof0WtnkZo2MHiPyvdvDwnZW9WK2XM7RyoA4ik95Gtp3oew77cQfJLJ4Rl/TePGfJwYVItDeD/9i8tvUEgVGQWc2a/xo7Wxx91FDA2K/Z2KS/k0yhsEVsHNO7jRkf0yMssDdkCBYTqIDKSsSfhGXN6oVSLZORiQ0hwwlBUJxsTCvJNc+crVAyhH1iJ1P6Rp/bZ+7es3QSdfRj5LIqGEkyrXW0qarJod+YCbaBPtv4Y46nIFBQB/UqcjxVEqJ6X7Y/fepLtYqWR4+RPojYkN2fzB11LW94AGRwOfT5oG4Eogl4NnPTE+rf+QEI4xVOm6RMoibS8ly2D7vANzfMnxbaGmTanhr/JXBfvRGomeY96P5J1CAkazhIswfdveWfDPzMS2ImwToll9tHKJWEc2GqbKRm0kmAyWLIMZi3SfeSb5aFHbXjqd60Xx6jZVw7j/IF679bhVt+vmLtjo/aj1tEJ6lBRc6LApPpXAwilKNnMGqfMpejEo5WbbRmTsg9IqaPP71PYmryxdYFJsxOcgORYLmddWxqJWI09Dz9db6Dc7sVHCq/NL3d21DpYZJz5FVDbHQHgE1RgZA/bdG5e6EiHPCfGp2W8vhuK7dOledIZf2XW
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(396003)(39860400002)(366004)(346002)(451199021)(91956017)(316002)(66946007)(4326008)(76116006)(122000001)(86362001)(38070700005)(38100700002)(66446008)(82960400001)(64756008)(6512007)(110136005)(478600001)(71200400001)(921005)(8936002)(54906003)(2616005)(7406005)(41300700001)(66556008)(7416002)(8676002)(66476007)(6506007)(26005)(5660300002)(186003)(83380400001)(2906002)(6486002)(36756003)(4744005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Nk93b3NMZUNNNmZoYm9MT2Y2S3RvUHgzTVVGY2RmYjdVeXhIa2o2RTNaaytt?=
 =?utf-8?B?L0JudFJWOGlSa09sV3JLajJjV3M5Yzh0N0NLLzEwVEdWZE1ad2pKcTd6WnVN?=
 =?utf-8?B?SFFGSVVjQy9JU2RQenA3a0h2NUJQbHNzazdESlp5VG50SVovUkNUdG8zbko2?=
 =?utf-8?B?c3h5UUNjZ0YxWVM4NWg2emwyZDI0M3JvTnRHTXRqWTNma3M3a2JvNVFmSmp0?=
 =?utf-8?B?QVFhYnFwMmVTc3hDNG9PaW5IOEphSUphSkxKeDdPaFNjajlsVWlSekhid3Az?=
 =?utf-8?B?RWRpNE5PZVBxVE5BK3p6anB0SGllZDN1cDNZRU9aV1MzcmVHNHVXVVRlcEc3?=
 =?utf-8?B?RGx5dHptT0RWalAxWGE5L0RxdW4rMUNxRTRGN01qUjU2Q1FXYzJtcDkxL3Vl?=
 =?utf-8?B?SHdGYzJ3TmhFdUV6d1VVUisybHlwejdwZlZaanBaeW1DOWoxUlpJL2IySk5E?=
 =?utf-8?B?OGZFVVNPOXVKMGtWSE9odXJDVVF6M2ZFZDA0emFOeGFWL0ZlTzNXTjZWa0dS?=
 =?utf-8?B?UmJ1bkp4dkJRTGxtZVVuU0wzS0Z6UCt4NHI3cVF6K1BBbkZZbDRqUG5zVDFK?=
 =?utf-8?B?YkQ5clhqSkNsOU9uMHdQaDRNa3FXeXRESTVJbXByMmpFNEpyWFdzcTlKT1d6?=
 =?utf-8?B?M01rcS9TaGRPQlBsdHA1S2VaMnpDTkl1cVJWRGR4QTVyVzBUbFNJUk8zVC9R?=
 =?utf-8?B?U0ZySC9DalI1ZVV2WTVvSkVFOWdmNDBpSmVYMXJVaDRPNDRURS95Qml2R2sz?=
 =?utf-8?B?RVJVU1lYZ0VXU1d3SXNYOE9CRG9xbWF4WG9xUHk3QjlZZC9YNlJlVVFnRTZM?=
 =?utf-8?B?RnBFOHlacEo5VTBuQkNpS1pNSzFwMmRsT3I5Y2RoYVR0MnlQMUxKazJ1RVU0?=
 =?utf-8?B?Y3R6T2JaVm9Fb3RaS2ZKWENGZENMczVCbzVyazhCRkdkMk12U21NNTBaNTd6?=
 =?utf-8?B?azVOMllEeXd6ZlpQWnQzNks1dkJBR0w3NDBzN1ZEVUZiT2o2Tys3aTNrUi9m?=
 =?utf-8?B?bGFVaEdqdjlBTCs5TXlKK3hSNFBEVUphU0psOW10V1NQanRwNnNMWnllNXpZ?=
 =?utf-8?B?VXd0bzErTDFWV0pENStSdVRRdjA0RDQwaU9iK2RCT0I1R2JlOXh1azZvV2gw?=
 =?utf-8?B?Yk1rWjhEODJRcG1XcFF0NHVDT0svV0lmM2Z4OGtCYmdnSy8wTzBFRzJDaUhN?=
 =?utf-8?B?N0tQTG5NdmJTVFRLU0xRakxrZHhKNGdkNytGZmQ2NHJVRlVHTkdqM0ZTR3d0?=
 =?utf-8?B?WDlGWlJRMjZmRXRxOEtVUW9XRjZyVG95U1RrNlRoVVVvVkZMTFhCTi9iMGFt?=
 =?utf-8?B?cXdxcnRjakF2dXpzZHFNN3Zpck9rc2VSUVpqWGxMaHRnYnJrbng5V1VoV3hh?=
 =?utf-8?B?dENoYmxEdFVzSUpwelNnVkFaZnNkS1Y1VzZMZFhpWEQ1UVhrNEdFLzhWOXJP?=
 =?utf-8?B?dHJ4eVVwdTA1c2Z3K2oveHVSSTlBUC9uSjB1QStxMkFaRUk0T0o4bTgvaXVq?=
 =?utf-8?B?RlJkZ3k0YjR2QU1JdUFiOWx2RWhKTllFNUlhTFlWaUE2RnZ2cU4rZWhEcXpq?=
 =?utf-8?B?RzhoZ3FNeUdmSUxtU2E3dC9MQkFWUUROR0dyMkdQb2h1azdVN0RpOVpGVFBW?=
 =?utf-8?B?SXFSa0M4WFh2Rm1wUFc2MFB0Q1hORm0wem93RlYvd294aWdta3JUamMvZUk3?=
 =?utf-8?B?V0NWR0U5bU4waEdmRWk2S1hnaDlTaC9nZFRZQ3ZxR05FNjJlYkdXN1pzTTVB?=
 =?utf-8?B?akFid0JQVGNxWE10Q2diVkUwVG05ZHRkYm1aUnlieDN2d0UrL0ozd1dxcm9G?=
 =?utf-8?B?aCtYeFNmODNzK01oSEljNElHeDJBVElHUVV6N0ZyWTVVWGNpT2tDTXFjVVRE?=
 =?utf-8?B?TnprRHcrcXV5ODFMTE90L080QVhzUE9XNUlXZUQyN0IwRGZaREErWlNvakls?=
 =?utf-8?B?NVptVUJIb2FkTkNYMHV3ekc5Y3Fpa0l0SjBOVEtjNE8zZzAyQkViNFBYSy9l?=
 =?utf-8?B?RnpWWm80TjRKek5zVFN3dDdteHNqdWFvbVA3cGovVm5iZXlNa2h0b3lXM0VM?=
 =?utf-8?B?dENmTE1UTVczUi9NL2R2dFFoUGlacVR0U1JCaHRrK0F0QWVwbUx5L1ZXUFZO?=
 =?utf-8?B?a3BMRzY5SmMwQlNwQzJPY2RUUDU3VTRvakZMcUtZVXdtaEgrYWFoZlJ6OTMy?=
 =?utf-8?B?RHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5F194CC5C1433C41A3A90DB1E2F9F201@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a8c28f1-7acc-4bbd-6222-08db87b71027
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2023 17:47:32.2717
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5YqWzm2PAG4b6c6Z/+A46C/oHMrJlO8SIwZ46O40EaQWTHNXLhUX6wyLlult6uJNDvmD0DhBtDj3SrndZU+UuJLsUIKm7j0Iyav1taMbOpc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7707
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gU3VuLCAyMDIzLTA3LTE2IGF0IDIyOjUwICswMTAwLCBNYXJrIEJyb3duIHdyb3RlOg0KPiBP
biBhcm02NCBhbmQgeDg2IHRoZSBrZXJuZWwgY2FuIGNvbnRyb2wgaWYgdGhlcmUgaXMgd3JpdGUg
YWNjZXNzIHRvDQo+IHRoZQ0KPiBzaGFkb3cgc3RhY2sgdmlhIHNwZWNpZmljIGluc3RydWN0aW9u
cyBkZWZpbmVkIGZvciB0aGUgcHVycG9zZSwNCj4gdXNlZnVsDQo+IGZvciB0aGluZ3MgbGlrZSB1
c2Vyc3BhY2UgdGhyZWFkaW5nIGF0IHRoZSBleHBlbnNlIG9mIHNvbWUgc2VjdXJpdHkuDQo+IEFk
ZCBhIGZsYWcgdG8gYWxsb3cgdGhpcyB0byBiZSBzZWxlY3RlZCB3aGVuIGNoYW5naW5nIHRoZSBz
aGFkb3cNCj4gc3RhY2sNCj4gc3RhdHVzLg0KPiANCj4gT24gYXJtNjQgdGhlIGtlcm5lbCBjYW4g
c2VwYXJhdGVseSBjb250cm9sIGlmIHVzZXJzcGFjZSBpcyBhYmxlIHRvDQo+IHBvcA0KPiBhbmQg
cHVzaCB2YWx1ZXMgZGlyZWN0bHkgb250byB0aGUgc2hhZG93IHN0YWNrIHZpYSBHQ1MgcHVzaCBh
bmQgcG9wDQo+IGluc3RydWN0aW9ucywgc3VwcG9ydGluZyBtYW55IHNjZW5hcmlvcyB3aGVyZSB1
c2Vyc3BhY2UgbmVlZHMgdG8NCj4gd3JpdGUNCj4gdG8gdGhlIHN0YWNrIHdpdGggbGVzcyBzZWN1
cml0eSBleHBvc3VyZSB0aGFuIGZ1bGwgd3JpdGUgYWNjZXNzLsKgIEFkZA0KPiBhDQo+IGZsYWcg
dG8gYWxsb3cgdGhpcyB0byBiZSBzZWxlY3RlZCB3aGVuIGNoYW5naW5nIHRoZSBzaGFkb3cgc3Rh
Y2sNCj4gc3RhdHVzLg0KDQpJcyB0aGlzIGNvcnJlY3Q/IEkgdGhvdWdodCBTemFib2xjcyB3YXMg
c2F5aW5nIHBvcCB3YXMgYWx3YXlzDQpzdXBwb3J0ZWQsIGJ1dCBwdXNoIHdhcyBvcHRpb25hbC4N
Cg==
