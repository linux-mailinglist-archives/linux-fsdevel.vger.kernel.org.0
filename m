Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60867669D93
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jan 2023 17:23:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbjAMQXZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Jan 2023 11:23:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbjAMQW7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Jan 2023 11:22:59 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B57AC766;
        Fri, 13 Jan 2023 08:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673626643; x=1705162643;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jBW+I8EsYE54hgXsNe1Dpvah0FuHXXQaTVNS0wina14=;
  b=ibx0jtPjJ5HCfLSl1ZTG0fDwh9rAWozs6V2vfaFTwM8xrpW6eGC0LnAS
   2dg7R7+dJ8RpYm8Cb33VFeUW75K2sgRJ+ocreXUC1NQlhKyo4WXksAwZX
   gU32jMWAL6De+3J7tUYbvxVUEwI3i7yBLse8fQzr0NaTr+ujQZ+PtXH4J
   WIY/gs/kw9a5pNa44qe69XyQ7TuZZCYs7P56KJgAC1NtwJEtpAvbay8dZ
   m4iFNqdGlCugM70Y/OqL+yvb/7uT2M5+wdyi+F55S+Ab5tNgggpHEbWHu
   EtH4cUKMcc2t8QrFA+lTKNNCBCUzeg9Ope38grKBi8nMuzD24uJNmz1XY
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="303723294"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; 
   d="scan'208";a="303723294"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 08:17:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="987040341"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; 
   d="scan'208";a="987040341"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP; 13 Jan 2023 08:17:22 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 13 Jan 2023 08:17:22 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 13 Jan 2023 08:17:21 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 13 Jan 2023 08:17:21 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 13 Jan 2023 08:17:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AvrNAilhTxo0YnsY5wrVvro2PERCcX1LXjMkAm3wmcXWo+11WYY1rQERg7MO3AJBIVAbIRgFBOr7qyDUPmBNPkkawKd6D317Fs5e6hYac4XFKbCEhLMtOVoLAJxbLpde/x8XC6mR9oPAYjjlSrQSYdQYJ3X3mNBQCL0ZPnQ/3WUoHykegm4F0Yd3LfvSq4yzqAG2JNjhau2fNcmN3DPCPX8R1mftcmBrPOEKcM3uwJ76mwt0qxY12FkuT/BBTfOvj06ZqfsRrakVWAtTLaOGUOB4gUTBoHWik32/s8bEiJp3VAkZYmFBkn8c8zF4CAZVRDU/06IYzAG0D0V/uoNHVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jBW+I8EsYE54hgXsNe1Dpvah0FuHXXQaTVNS0wina14=;
 b=BYNlV2xQk/4ymqtHGxHwv/hUHuAv5DwW7Z9CbbCUCtc1NaEn7nNzRQiN3z74EyZuYs5r8okssJ81MlkhaHsqWaXzP+L2q2aDg1gj1Uzq6gwYNQR5+tZIC23Nruf/iNwn+JyllydmSAzoiE52THfybwn6HmUEvYb9FPQe81CQr+w1YhIMYJFNUW2K50O/RVOjBdNG9Ta96vZxn53LPzFzuoIDWJyOD2KukdveQrrfnpiEHiKiXj7yXLKEYw3RY/zzRani6dL0RoGeYErx/84h5SVHeuNu5jHtCSxIGO6MwBKx/BftEXCOwJgnLeijlFtVGPm5iLW3Hlw3pSj+wMZhXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SA0PR11MB4655.namprd11.prod.outlook.com (2603:10b6:806:9d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.19; Fri, 13 Jan
 2023 16:17:18 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::3c14:aeca:37e2:c679]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::3c14:aeca:37e2:c679%6]) with mapi id 15.20.5986.018; Fri, 13 Jan 2023
 16:17:17 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
CC:     "Torvalds, Linus" <torvalds@linux-foundation.org>,
        Mateusz Guzik <mjguzik@gmail.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        Jan Glauber <jan.glauber@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: RE: ia64 removal (was: Re: lockref scalability on x86-64 vs
 cpu_relax)
Thread-Topic: ia64 removal (was: Re: lockref scalability on x86-64 vs
 cpu_relax)
Thread-Index: AQHZJyR/hg4pL/N6e0ad2k2xs4MPaK6cg1cw
Date:   Fri, 13 Jan 2023 16:17:17 +0000
Message-ID: <SJ1PR11MB6083CA763F3510B45C6F5779FCC29@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <CAGudoHHx0Nqg6DE70zAVA75eV-HXfWyhVMWZ-aSeOofkA_=WdA@mail.gmail.com>
 <CAHk-=wjthxgrLEvgZBUwd35e_mk=dCWKMUEURC6YsX5nWom8kQ@mail.gmail.com>
 <SJ1PR11MB6083368BCA43E5B0D2822FD3FCC29@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <CAMj1kXEqbMEcrKYzz2-huLPMnotPoxFY8adyH=Xb4Ex8o98x-w@mail.gmail.com>
In-Reply-To: <CAMj1kXEqbMEcrKYzz2-huLPMnotPoxFY8adyH=Xb4Ex8o98x-w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SA0PR11MB4655:EE_
x-ms-office365-filtering-correlation-id: c24ddb1b-325f-43b3-685d-08daf581a3dc
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hVoFOY1DnhFIcv/aRzIXCf2BK2Y9AxXfUxrDJODkYSVCVdjQtMW4BMDZNXIZK4XOCli2zz4B89fclIV/SFifrtYw8aaRV7ojCXKGbrgRryCGJeYkniUsnOFsEBjZjlltQ2mBbn9BB3ARsjGHX+fcNnWMewgI89LbgmNxpo1Q/iOsIzpIIMrzHYjgyyxXZiazh8oqPAXA9fKOH9P+jo3l3uFRpUiOC7oN9ZzqkKnDsMFaca5Yoq4B/wEoyHnaZXGE9zvRfC4i38qL2IO4pghGeZumNcKg6JdmmCxCObbKki1FN5/krhbLncL9AggwTihamc7BpOIaSilFbZr85tfICTR9F5gZQfLDCOh4J+qXzOSONbTJNnXRUWIPn7yIy3OkO58NumXlPCDHRHumCfze/V+WvIDJWxySVCIRMyCuOb8hQ2tw4ET1G4AIhsBx3d30bphqvlCneH0+wX4sKr/Na6OunwDiqIo/QJkgww2vMegjsjM9a18KwNqihaONpe4ivj2clnPYdTK/YIS7L/nCThUqGyxle2Glk9sPMBsQVxN/iqwEBrRgpzcEf7qyhF3Q9Q4AfnwoHwNN8//3IBCOrf8fdxsOH+ZbdI1wiE9SDohP183Gh//bNkeu6sbK0xLVjxh9aAyD+/JvLZq4tUjCqo4A16dtgMexGg1UNA6DIFLk1PQE5h4HUxkObG1gEra64RJpihQxrHU4vp+i55URj8p+AgwUAC+psaUqsp6UfFU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(396003)(366004)(39860400002)(136003)(346002)(451199015)(82960400001)(122000001)(38100700002)(86362001)(38070700005)(2906002)(41300700001)(52536014)(7416002)(5660300002)(8936002)(55016003)(478600001)(6506007)(9686003)(186003)(26005)(316002)(66556008)(8676002)(6916009)(4326008)(66446008)(66476007)(76116006)(66946007)(64756008)(7696005)(71200400001)(54906003)(66899015)(966005)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TnZ2MGRnekxqNDZ1U1RRbHZtL0JsQ1RyZzdLK0RrOHR2aWprS0h4UjJWeE9K?=
 =?utf-8?B?ODZja1o1SC9ZMUNUTUVRbXFjTktMWVl4SGlyMStzMHZCckN0S3BaWVJETE5S?=
 =?utf-8?B?dUNydkw4dklTaUgwZHJQV3ZqVkZseTRuMjZSbWJ1WktUaTR0czhVRFRmZUpU?=
 =?utf-8?B?a1RGTTB3NzJpSFlscXdjeGlCUEZaM1RZVWJWaEM3Rkc5QmhFZEdYa1Q4cFF0?=
 =?utf-8?B?emJ1N0Vxb0ZkS1V3RDZtcndDd2o3RjRjN214dS9lekF1UFZncEo5dnZGTzMr?=
 =?utf-8?B?bk9KYlV5K05rdkVSRUJ2SnhidmRaeXZjR0pDb0MyVkZWSzVvMG84Y1dOaGgz?=
 =?utf-8?B?WWRqMmtyL1RVYldMc0hmYllyQStxcFZsb1ZUQ21CRjAxS2tnTVNNMHNpL2tr?=
 =?utf-8?B?VTBrbDFhRHBnTUs4VGlHTzdaUnpSeWVQdmErWmlXWHlTZkpCbWU2a1dtcUhl?=
 =?utf-8?B?QW5KRzFrdTN5QmRzS0xuNStzQTRlTzNjdDhZMkJVS2VhbXRIZTRiK25xck5y?=
 =?utf-8?B?cWEwbS8rVVFaR2VRZC9QT1N2djlza3IxOG9tWU1OVkhTU3k3ZUFoU0tPSVl6?=
 =?utf-8?B?MDBQTTkrb2Qya3Z3U2RLUXVBdUQ3V29Jd3NTQ0NwWSt1YXVJcDVwQkd6SkhT?=
 =?utf-8?B?YUdzNXNSendRemlibGdWL2xHMm1TbE1rOStRQ1pnYklKM1dxdE1ucCtQVnB6?=
 =?utf-8?B?eEJUYXBZMHdWaFY2YkFRZDhHa2JtWHh0aTJmcG1ZMjk0Ti9QTm5LQzQyblBP?=
 =?utf-8?B?Rk5adTZPTXhxT0c2YklYbU03WFllYXZBbGNqd0c4dEN5S0Y0ckZEbkgxMW8w?=
 =?utf-8?B?YzRFTVBBVUpheUg1QS9lZzVpVW0zVXpaWTNRb3M5aXJwQlFrVzhEWGtIRVRj?=
 =?utf-8?B?WkxMM2piakZNM0JGSW1GemdPUjZJQWpaYjNkM083eVNYQ3BCUWpqNndUOTlD?=
 =?utf-8?B?eTN2ck1UNG90TFhwamhzMVd1cFVOZjFTREwyRUZlcllZODFvZ2YwR1BnUVRZ?=
 =?utf-8?B?c25wVzB1TmNtVmg3c01RZGQwcEhMMUlObndsMlFLaEpIQVVtc1FsRVU1YzdM?=
 =?utf-8?B?Mll0UGhyRmMyR3NvMjl6STBCZUtwQWxhRmF3VDA0dGRJZ3Q2ZHpDR25pYW1q?=
 =?utf-8?B?STdzejNONWp1WjVSanhrSEZaay94OWlReEtsc2tvMVBTYmRGSmdJSWU3Mytx?=
 =?utf-8?B?VTFQRGI1c3pBaWVPNUpKU2RqalZNUVZHdE51SVczOXFsYnFmWnorYlA1L0JX?=
 =?utf-8?B?eGRZcW5odUNncTUvbjVxUTVuRTdUWXlaV1MveGNUYjhRODNVZzJIbENmSkZa?=
 =?utf-8?B?MFBSaEMwUjBFOUxZTG9qL2hiZHZoSWJBYVpFa0d3L25lVVNXZUxCdDY0YVhx?=
 =?utf-8?B?YWxNczcyMVkwY0EwUlRyZ3hpTjM0Z1VuSmJBY2xIaHNPQ3Z6Q1lJZkVGNVRI?=
 =?utf-8?B?amV5akFOYWdUb1R0UEpITVE4Mlk2V3ZzM2RYMERkS0NCOW5Da3VzSUNHbWIr?=
 =?utf-8?B?dVVDRDZsbHJwSkVEenVJQWVpZHIycVJvK3BOUlBNSmlDTUFNS1JCMHo5cEhx?=
 =?utf-8?B?TEd6aFowUzJxVG94SCtMWE92TEZ1dUJBeWdvR1hiVldoQS9rTXNrdGhmdG53?=
 =?utf-8?B?TitxYXpSTzhZTDNNaXVXU1ArSVJuQWdrbnppejUrQXZYb2N2VzJ5VjcvS3M2?=
 =?utf-8?B?dWVrVGZDdW9aOEFHSk1kbTk5NDVSQ1d4QUJXbXNVK2dLbW9PL2tEZmh3eUNm?=
 =?utf-8?B?QVNMQjEwdHlSRVNwL0cvdUwzZ2hjaHpjRGpkOUFWTWVVdUorR1dsWFkrMXJn?=
 =?utf-8?B?VzRHb0U3RmVJQnB5N2Z4dWljeGhmM20zb3FXY1FCZklvaTBsRVYySXAza2NT?=
 =?utf-8?B?bHZtZ3ljMnpxcDVYeVYzR3dMZ1ZxSU1jZFEzcytDVERIaGc5aHppSEpLMTJj?=
 =?utf-8?B?QlVjNXJjeVN3LzF1eW5hSm1Tb2hhZkgrdWd4WXp1Uy9haFB2N0tqUnNoQ3BZ?=
 =?utf-8?B?eldtS1VNenRlN0ZwVHp2bCtOZjJpU3h5cW9oSEFORHM0SkpMbktRU3ZnSjRL?=
 =?utf-8?B?YkxET1RhWGQ1RFBSeVZxajBoWlptRjc1Yk9hTXd0UnVKQjdUNG8wSEVtams1?=
 =?utf-8?Q?WLFIjmtPU/Cff6UYzpJTDoK6J?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c24ddb1b-325f-43b3-685d-08daf581a3dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2023 16:17:17.4751
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I8BmX2diP3xgBc7SfKXcg6A3MOANgVdQBubY8UyED4RWw7wluRxrjRGhER39adCYVjevAEu76KK5sODJwUce3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4655
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Pj4gSXMgaXQgdGltZSB5ZXQgZm9yOg0KPj4NCj4+ICQgZ2l0IHJtIC1yIGFyY2gvaWE2NA0KPj4N
Cg0KPiBDYW4gSSB0YWtlIHRoYXQgYXMgYW4gYWNrIG9uIFswXT8gVGhlIEVGSSBzdWJzeXN0ZW0g
aGFzIGV2b2x2ZWQNCj4gc3Vic3RhbnRpYWxseSBvdmVyIHRoZSB5ZWFycywgYW5kIHRoZXJlIGlz
IHJlYWxseSBubyB3YXkgdG8gZG8gYW55DQo+IElBNjQgdGVzdGluZyBiZXlvbmQgYnVpbGQgdGVz
dGluZywgc28gZnJvbSB0aGF0IHBlcnNwZWN0aXZlLCBkcm9wcGluZw0KPiBpdCBlbnRpcmVseSB3
b3VsZCBiZSB3ZWxjb21lZC4NCj4NCj4gVGhhbmtzLA0KPiBBcmQuDQo+DQo+DQo+DQo+IFswXSBo
dHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9hcmRiL2xpbnV4
LmdpdC9jb21taXQvP2g9cmVtb3ZlLWlhNjQNCg0KWWVzLiBFRkkgaXNuJ3QgdGhlIG9ubHkgaXNz
dWUuIEEgYnVuY2ggb2YgZm9sa3NbMV0gaGF2ZSBzcGVudCB0aW1lIGZpeGluZyBpYTY0DQpmb3Ig
KGluIG1vc3QgY2FzZXMpIHNvbWUgdHJlZS13aWRlIHBhdGNoZXMgdGhhdCB0aGV5IG5lZWRlZC4g
VGhlaXIgdGltZSBtaWdodA0KaGF2ZSBiZWVuIG1vcmUgcHJvZHVjdGl2ZWx5IHNwZW50IGZpeGlu
ZyB0aGluZ3MgdGhhdCBhY3R1YWxseSBtYXR0ZXIgaW4gbW9kZXJuIHRpbWVzLg0KDQpBY2tlZC1i
eTogVG9ueSBMdWNrIDx0b255Lmx1Y2tAaW50ZWwuY29tPg0KDQotVG9ueQ0KDQpbMV0gZ2l0IGxv
ZyAtLW5vLW1lcmdlcyAtLXNpbmNlPTJ5ZWFyIC0tIGFyY2gvaWE2NCB8IGdyZXAgQXV0aG9yOiB8
IHNvcnQgfCB1bmlxIC1jIHwgc29ydCAtcm4NCiAgICAgMTkgQXV0aG9yOiBNYXNhaGlybyBZYW1h
ZGEgPG1hc2FoaXJveUBrZXJuZWwub3JnPg0KICAgICAxMSBBdXRob3I6IFNlcmdlaSBUcm9maW1v
dmljaCA8c2x5Zm94QGdlbnRvby5vcmc+DQogICAgICA5IEF1dGhvcjogRXJpYyBXLiBCaWVkZXJt
YW4gPGViaWVkZXJtQHhtaXNzaW9uLmNvbT4NCiAgICAgIDggQXV0aG9yOiBBcm5kIEJlcmdtYW5u
IDxhcm5kQGFybmRiLmRlPg0KICAgICAgNiBBdXRob3I6IFJhbmR5IER1bmxhcCA8cmR1bmxhcEBp
bmZyYWRlYWQub3JnPg0KICAgICAgNiBBdXRob3I6IEtlZmVuZyBXYW5nIDx3YW5na2VmZW5nLndh
bmdAaHVhd2VpLmNvbT4NCiAgICAgIDYgQXV0aG9yOiBBbnNodW1hbiBLaGFuZHVhbCA8YW5zaHVt
YW4ua2hhbmR1YWxAYXJtLmNvbT4NCiAgICAgIDUgQXV0aG9yOiBNYXNhbWkgSGlyYW1hdHN1IDxt
aGlyYW1hdEBrZXJuZWwub3JnPg0KICAgICAgNSBBdXRob3I6IEFsIFZpcm8gPHZpcm9AemVuaXYu
bGludXgub3JnLnVrPg0KICAgICAgNCBBdXRob3I6IFBldGVyIFppamxzdHJhIDxwZXRlcnpAaW5m
cmFkZWFkLm9yZz4NCiAgICAgIDQgQXV0aG9yOiBNaWtlIFJhcG9wb3J0IDxycHB0QGtlcm5lbC5v
cmc+DQogICAgICA0IEF1dGhvcjogRGF2aWQgSGlsZGVuYnJhbmQgPGRhdmlkQHJlZGhhdC5jb20+
DQogICAgICA0IEF1dGhvcjogQ2hyaXN0b3BoZSBMZXJveSA8Y2hyaXN0b3BoZS5sZXJveUBjc2dy
b3VwLmV1Pg0KICAgICAgMyBBdXRob3I6IFl1cnkgTm9yb3YgPHl1cnkubm9yb3ZAZ21haWwuY29t
Pg0KICAgICAgMyBBdXRob3I6IE1pY2hhbCBIb2NrbyA8bWhvY2tvQHN1c2UuY29tPg0KICAgICAg
MyBBdXRob3I6IEdlZXJ0IFV5dHRlcmhvZXZlbiA8Z2VlcnQrcmVuZXNhc0BnbGlkZXIuYmU+DQog
ICAgICAzIEF1dGhvcjogQmhhc2thciBDaG93ZGh1cnkgPHVuaXhiaGFza2FyQGdtYWlsLmNvbT4N
CiAgICAgIDMgQXV0aG9yOiBCYW9xdWFuIEhlIDxiaGVAcmVkaGF0LmNvbT4NCiAgICAgIDMgQXV0
aG9yOiBBcmQgQmllc2hldXZlbCA8YXJkYkBrZXJuZWwub3JnPg0KICAgICAgMyBBdXRob3I6IEFu
ZWVzaCBLdW1hciBLLlYgPGFuZWVzaC5rdW1hckBsaW51eC5pYm0uY29tPg0KICAgICAgMiBBdXRo
b3I6IFlhbmcgR3VhbmcgPHlhbmcuZ3Vhbmc1QHp0ZS5jb20uY24+DQogICAgICAyIEF1dGhvcjog
V2lsbCBEZWFjb24gPHdpbGxAa2VybmVsLm9yZz4NCiAgICAgIDIgQXV0aG9yOiBWaXJlc2ggS3Vt
YXIgPHZpcmVzaC5rdW1hckBsaW5hcm8ub3JnPg0KICAgICAgMiBBdXRob3I6IFZhbGVudGluIFNj
aG5laWRlciA8dnNjaG5laWRAcmVkaGF0LmNvbT4NCiAgICAgIDIgQXV0aG9yOiBTdGFmZm9yZCBI
b3JuZSA8c2hvcm5lQGdtYWlsLmNvbT4NCiAgICAgIDIgQXV0aG9yOiBTZWJhc3RpYW4gQW5kcnpl
aiBTaWV3aW9yIDxiaWdlYXN5QGxpbnV0cm9uaXguZGU+DQogICAgICAyIEF1dGhvcjogUmljaGFy
ZCBHdXkgQnJpZ2dzIDxyZ2JAcmVkaGF0LmNvbT4NCiAgICAgIDIgQXV0aG9yOiBQZXRlciBYdSA8
cGV0ZXJ4QHJlZGhhdC5jb20+DQogICAgICAyIEF1dGhvcjogUGV0ZXIgQ29sbGluZ2JvdXJuZSA8
cGNjQGdvb2dsZS5jb20+DQogICAgICAyIEF1dGhvcjogTWFyayBSdXRsYW5kIDxtYXJrLnJ1dGxh
bmRAYXJtLmNvbT4NCiAgICAgIDIgQXV0aG9yOiBMdWthcyBCdWx3YWhuIDxsdWthcy5idWx3YWhu
QGdtYWlsLmNvbT4NCiAgICAgIDIgQXV0aG9yOiBKdWxpYSBMYXdhbGwgPEp1bGlhLkxhd2FsbEBp
bnJpYS5mcj4NCiAgICAgIDIgQXV0aG9yOiBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+DQog
ICAgICAyIEF1dGhvcjogSmFzb24gV2FuZyA8d2FuZ2Jvcm9uZ0BjZGpybGMuY29tPg0KICAgICAg
MiBBdXRob3I6IEphbiBLYXJhIDxqYWNrQHN1c2UuY3o+DQogICAgICAyIEF1dGhvcjogQ2hyaXN0
b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+DQogICAgICAyIEF1dGhvcjogQmpvcm4gSGVsZ2FhcyA8
YmhlbGdhYXNAZ29vZ2xlLmNvbT4NCiAgICAgIDIgQXV0aG9yOiBBbGV4YW5kZXIgTG9iYWtpbiA8
YWxleGFuZHIubG9iYWtpbkBpbnRlbC5jb20+DQogICAgICAxIEF1dGhvcjogWmkgWWFuIDx6aXlA
bnZpZGlhLmNvbT4NCiAgICAgIDEgQXV0aG9yOiBaaGFuZyBZdW5rYWkgPHpoYW5nLnl1bmthaUB6
dGUuY29tLmNuPg0KICAgICAgMSBBdXRob3I6IHllIHhpbmdjaGVuIDx5ZS54aW5nY2hlbkB6dGUu
Y29tLmNuPg0KICAgICAgMSBBdXRob3I6IHh1IHhpbiA8eHUueGluMTZAenRlLmNvbS5jbj4NCiAg
ICAgIDEgQXV0aG9yOiBXb2xmcmFtIFNhbmcgPHdzYStyZW5lc2FzQHNhbmctZW5naW5lZXJpbmcu
Y29tPg0KICAgICAgMSBBdXRob3I6IFdlaXpoYW8gT3V5YW5nIDxvNDUxNjg2ODkyQGdtYWlsLmNv
bT4NCiAgICAgIDEgQXV0aG9yOiBTdXJlbiBCYWdoZGFzYXJ5YW4gPHN1cmVuYkBnb29nbGUuY29t
Pg0KICAgICAgMSBBdXRob3I6IFNvdXB0aWNrIEpvYXJkZXIgKEhQRSkgPGpyZHIubGludXhAZ21h
aWwuY29tPg0KICAgICAgMSBBdXRob3I6IFNlcmdleSBTaHR5bHlvdiA8cy5zaHR5bHlvdkBvbXAu
cnU+DQogICAgICAxIEF1dGhvcjogU2VyZ2VpIFRyb2ZpbW92aWNoIDxzbHlpY2hAZ21haWwuY29t
Pg0KICAgICAgMSBBdXRob3I6IFNhc2NoYSBIYXVlciA8cy5oYXVlckBwZW5ndXRyb25peC5kZT4N
CiAgICAgIDEgQXV0aG9yOiBTYW11ZWwgSG9sbGFuZCA8c2FtdWVsQHNob2xsYW5kLm9yZz4NCiAg
ICAgIDEgQXV0aG9yOiBRaSBaaGVuZyA8emhlbmdxaS5hcmNoQGJ5dGVkYW5jZS5jb20+DQogICAg
ICAxIEF1dGhvcjogUGVuZyBMaXUgPGxpdXBlbmcyNTZAaHVhd2VpLmNvbT4NCiAgICAgIDEgQXV0
aG9yOiBOYXZlZW4gTi4gUmFvIDxuYXZlZW4ubi5yYW9AbGludXgudm5ldC5pYm0uY29tPg0KICAg
ICAgMSBBdXRob3I6IE11Y2h1biBTb25nIDxtdWNodW4uc29uZ0BsaW51eC5kZXY+DQogICAgICAx
IEF1dGhvcjogTWlrdWxhcyBQYXRvY2thIDxtcGF0b2NrYUByZWRoYXQuY29tPg0KICAgICAgMSBB
dXRob3I6IE1pa2UgS3JhdmV0eiA8bWlrZS5rcmF2ZXR6QG9yYWNsZS5jb20+DQogICAgICAxIEF1
dGhvcjogTWlja2HDq2wgU2FsYcO8biA8bWljQGxpbnV4Lm1pY3Jvc29mdC5jb20+DQogICAgICAx
IEF1dGhvcjogTWF0dGhldyBXaWxjb3ggKE9yYWNsZSkgPHdpbGx5QGluZnJhZGVhZC5vcmc+DQog
ICAgICAxIEF1dGhvcjogTWFydGluIE9saXZlaXJhIDxtYXJ0aW4ub2xpdmVpcmFAZWlkZXRpY29t
LmNvbT4NCiAgICAgIDEgQXV0aG9yOiBMdWMgVmFuIE9vc3RlbnJ5Y2sgPGx1Yy52YW5vb3N0ZW5y
eWNrQGdtYWlsLmNvbT4NCiAgICAgIDEgQXV0aG9yOiBLZWVzIENvb2sgPGtlZXNjb29rQGNocm9t
aXVtLm9yZz4NCiAgICAgIDEgQXV0aG9yOiBKYXNvbiBBLiBEb25lbmZlbGQgPEphc29uQHp4MmM0
LmNvbT4NCiAgICAgIDEgQXV0aG9yOiBJbHBvIErDpHJ2aW5lbiA8aWxwby5qYXJ2aW5lbkBsaW51
eC5pbnRlbC5jb20+DQogICAgICAxIEF1dGhvcjogSGFvd2VuIEJhaSA8YmFpaGFvd2VuQG1laXp1
LmNvbT4NCiAgICAgIDEgQXV0aG9yOiBHdXN0YXZvIEEuIFIuIFNpbHZhIDxndXN0YXZvYXJzQGtl
cm5lbC5vcmc+DQogICAgICAxIEF1dGhvcjogR3JlZyBLcm9haC1IYXJ0bWFuIDxncmVna2hAbGlu
dXhmb3VuZGF0aW9uLm9yZz4NCiAgICAgIDEgQXV0aG9yOiBHYW9zaGVuZyBDdWkgPGN1aWdhb3No
ZW5nMUBodWF3ZWkuY29tPg0KICAgICAgMSBBdXRob3I6IERtaXRyeSBPc2lwZW5rbyA8ZG1pdHJ5
Lm9zaXBlbmtvQGNvbGxhYm9yYS5jb20+DQogICAgICAxIEF1dGhvcjogRGF3ZWkgTGkgPHNldF9w
dGVfYXRAb3V0bG9vay5jb20+DQogICAgICAxIEF1dGhvcjogQ2h1Y2sgTGV2ZXIgPGNodWNrLmxl
dmVyQG9yYWNsZS5jb20+DQogICAgICAxIEF1dGhvcjogQ2hyaXN0aWFuIEJyYXVuZXIgPGJyYXVu
ZXJAa2VybmVsLm9yZz4NCiAgICAgIDEgQXV0aG9yOiBDaHJpcyBEb3duIDxjaHJpc0BjaHJpc2Rv
d24ubmFtZT4NCiAgICAgIDEgQXV0aG9yOiBDaGVuIExpIDxjaGVubGlAdW5pb250ZWNoLmNvbT4N
CiAgICAgIDEgQXV0aG9yOiBDYXRhbGluIE1hcmluYXMgPGNhdGFsaW4ubWFyaW5hc0Bhcm0uY29t
Pg0KICAgICAgMSBBdXRob3I6IEJlbmphbWluIFN0w7xyeiA8YmVubmlAc3R1ZXJ6Lnh5ej4NCiAg
ICAgIDEgQXV0aG9yOiBCZW4gRG9va3MgPGJlbi1saW51eEBmbHVmZi5vcmc+DQogICAgICAxIEF1
dGhvcjogQmFvbGluIFdhbmcgPGJhb2xpbi53YW5nQGxpbnV4LmFsaWJhYmEuY29tPg0KICAgICAg
MSBBdXRob3I6IEFuZHkgU2hldmNoZW5rbyA8YW5kcml5LnNoZXZjaGVua29AbGludXguaW50ZWwu
Y29tPg0KICAgICAgMSBBdXRob3I6IEFuZHLDqSBBbG1laWRhIDxhbmRyZWFsbWVpZEBpZ2FsaWEu
Y29tPg0K
