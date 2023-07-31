Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9119476A4C3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Aug 2023 01:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjGaXVG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jul 2023 19:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjGaXVD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jul 2023 19:21:03 -0400
Received: from mgamail.intel.com (unknown [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7702326B8;
        Mon, 31 Jul 2023 16:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690845639; x=1722381639;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ne7CuyJySmKGCp9qZxoKSlIvPYLk9+y0lcKXu7eA6Ic=;
  b=Kl9xq45pkvgiXnKu9q1JkGmLOwcr+GbV9z8g1OuMWESH590cEdQgi3F9
   2wvbGr2bWDPnJ2iS0uleMPZV4UCNU6OfOE5BKlLClhJWCML9aoIJd5u7y
   za6E3T0J8jTxgpQAsvLGgUsDkS6yiLbFhiMDz2ICrbuHhkBDOvFyU1lJi
   cchUqkPx01ycz+HShFsW5hNuklXsf0780GAu9HdYMW+0XL/RL3gQCa2RT
   u8mggnl0xn2Qu4XUvUQ67yyDIl2M97seByR60b+jw3QHnHCc9rhWThKo3
   b5dwAXHqW3ykaRPfAdcTDohziDo+zEfEgXELlOqWgDXwmMS26EkAXORm1
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="369148599"
X-IronPort-AV: E=Sophos;i="6.01,245,1684825200"; 
   d="scan'208";a="369148599"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 16:19:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="731741501"
X-IronPort-AV: E=Sophos;i="6.01,245,1684825200"; 
   d="scan'208";a="731741501"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga007.fm.intel.com with ESMTP; 31 Jul 2023 16:19:37 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 31 Jul 2023 16:19:37 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 31 Jul 2023 16:19:36 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 31 Jul 2023 16:19:36 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 31 Jul 2023 16:19:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OkFbqSnpRAxfsQKWX3eFSczGeA8A8iucwraWgJuztVKRBmLwh5a2pY6TgG4pa/E1rVXDJ325fwwQv4+uC+p7suluWUKzSIjsrZeOjQmfZia0Nb0MVEnpkrQiMmPaKweoFWFY8xF+eNJVN5gAXWHQtM2ijGIgBstUCynBPTe81g00k/axohTyh8a0Ia4i2BauRn+o9OSaZmRMTed26OPMTQszVr5wjVh48SqSyAXBiDlpTQGwqrJxkgdJVD22QGjvDKCyDiC222TiKHRSBjaLYjCNrzXpDIf6zjp/yZOxxqfNTV41w8QVOavNRGMUQ23XJ4c0qmNgj0Px44UT5Zzxsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ne7CuyJySmKGCp9qZxoKSlIvPYLk9+y0lcKXu7eA6Ic=;
 b=fWCgEuG7GbkLtLnkOrvHgIXIVSzDId1hfwzjsjs3Mfz0G8Ovo2HzePltpKFEaAN1xuakovPXZMG8Cr6nfEEfGkn/QmjWUJpJiKhbAz3hppSbL3R8AywTo/i1PHjWS1mkotkvRuf1OU3agHEh2x246iKtzCuopKAEljig0f0X0LToK1GSp/JhgDXdVRWTj/IqOwemBvT+VdCufmpbz0KtH6SzX4MyB83rVMWCPZMK1wO9KQzrRX/Uz3UqKfvzGSuhERco0EJ/JCp/pImPg2mmQw9aHLYtHhgnTKxlvZgBKe/0AQEZoMna0hU4UMygUCSJdBTW6g2u/WlWVCskF3TelQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by MN6PR11MB8195.namprd11.prod.outlook.com (2603:10b6:208:47f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Mon, 31 Jul
 2023 23:19:35 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::abd2:f781:1433:259]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::abd2:f781:1433:259%3]) with mapi id 15.20.6631.042; Mon, 31 Jul 2023
 23:19:34 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "broonie@kernel.org" <broonie@kernel.org>
CC:     "corbet@lwn.net" <corbet@lwn.net>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "Szabolcs.Nagy@arm.com" <Szabolcs.Nagy@arm.com>,
        "maz@kernel.org" <maz@kernel.org>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "will@kernel.org" <will@kernel.org>,
        "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
        "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>
Subject: Re: [PATCH v3 21/36] arm64/mm: Implement map_shadow_stack()
Thread-Topic: [PATCH v3 21/36] arm64/mm: Implement map_shadow_stack()
Thread-Index: AQHZw7ZZVWMs6JZuI06/zv64SypFG6/UB86AgAATdQCAAGg9gA==
Date:   Mon, 31 Jul 2023 23:19:34 +0000
Message-ID: <e827138f9d8800e3db158831bca88d1ea8b559af.camel@intel.com>
References: <20230731-arm64-gcs-v3-0-cddf9f980d98@kernel.org>
         <20230731-arm64-gcs-v3-21-cddf9f980d98@kernel.org>
         <5461c56cf4896f18bddaa66c3beec7b909fc8fb9.camel@intel.com>
         <0a6c90d6-f790-4036-a364-d4761fdd0e95@sirena.org.uk>
In-Reply-To: <0a6c90d6-f790-4036-a364-d4761fdd0e95@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|MN6PR11MB8195:EE_
x-ms-office365-filtering-correlation-id: ca6754ad-b3ca-4c4c-64fb-08db921c9a3e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m3aJKOpRh+QWXfb1+MsPPEfl2LaQ0RSEFukU5YgUgctAz8t/X2RqYtuXxB6rELsr53O5JPKACRx8JsEqcum8mBX1sye/U0PAlXzmVVgQ0ohijDbeJha8VV5fW6+ChZ30BHejmenxegvF1sjZAOB2OKjLRrMpqTQIxNb+HPe2kVpE7TG5e3oA6MwiuyjEaUgheYTL4IWHr/40+DbWBgvvBS/yPWT0l1a1YB4Nuv6SQyukaPVSpn3b7JcwI9W3dnjdHOuLBzCItkNpKsmjPcFNlYASCuOgBuiwWUASfZ++1ND8+QhH/yKUSySEZ3Wh7SdxrnLfYu1HP28iISmHDiyobjUFkYxB9c1mZXTGHlk1NO6HVnRAjaaKdQv0Z9RdJqs9ZglQMsJpR9A3qDe3ol5N29KjycCTg2pxDRw6dlANmnRZmORwce6q1XCFdmmSzPZmKAUqeBOp/+XAe6Hg7xSrZVyj8sE044L2z0rCLO7uYrlxJ/PBs0O1WM5wsSWFpxcT1OXWsrbNKTPChBbre3Ngg3rcRc2v3SYhPcSg5u8zg20HJZ4I8z5hSCAG5iYlknG+ly74FOo4A6dxLfMIYGQf/Dsur/LZx27EoFTeMGK43tbcxryvZff+UMrVVQ7eOiwF
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(396003)(136003)(376002)(346002)(451199021)(5660300002)(66476007)(2906002)(66946007)(6916009)(66556008)(91956017)(4326008)(66446008)(76116006)(64756008)(7406005)(7416002)(316002)(41300700001)(54906003)(6486002)(2616005)(71200400001)(8676002)(6506007)(8936002)(186003)(26005)(83380400001)(478600001)(82960400001)(122000001)(36756003)(38100700002)(38070700005)(6512007)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SE85Qjdwa2N1dlpWOEpKeVFhWG1MREM1eGttcjN2bnRBRk5DODU3VVphWjBE?=
 =?utf-8?B?ZWc5UXVRZmh6eDdmbSs2ajRDZzFkSlQ3MkhveTdqbldmb043c0hxQlpIU2ZW?=
 =?utf-8?B?TC9lTS83NEhGaFJ3VGdlWDdBdFlPWitBSHBEL05XMC8zcm12ZXhzdjVxUVVr?=
 =?utf-8?B?RExuSjkyS0NzOXc5SWVsSG41eTlHMFBmQ3Q2UXM5dmFmd0Nwemk5endOakNs?=
 =?utf-8?B?OERrS1RMOHNpSzVld0FCYTN2a21Ua0hURGRsY2VON1RqUnJyNHRwMTN3SW5L?=
 =?utf-8?B?ZVBqaGM2bFFRdDQyUGVyRmg1dEc5WVBkNzdHVkpWSTdOOXlBaVUyYzE1T2Rt?=
 =?utf-8?B?RjZDUDJORHk4Z2NNSk5WeGdZZWNwRlJNeXJ5VE1wdXlqSjdCRmVta2lxbEps?=
 =?utf-8?B?WjIyWWt5cEpTNkZVYlZXWXJTa0N4ZFA1WDdrY2lVREg3TzdaaEdGRGo2MDF3?=
 =?utf-8?B?YzdUMk1ZdUtDc3NPMGdyZkQwR0swdjd5aUJmWlU5M3RQQmZ3SGpwZi9INVBx?=
 =?utf-8?B?dVNmUjZRSVhOUWE3MTVSL1NRRDQxS0VYTUxGUXVhYUgvRWRmUWdaa2E4NkRT?=
 =?utf-8?B?TjJucWhqRWhlVkxtUXcxaG94dStIRTFzVVRGVXQzRHNlaHR5ZjZEWEZ3T1Nk?=
 =?utf-8?B?a0FkYmFLRlB0a1c1WDZIaFhUUHBsNDN2cXRrbFVDWENqeCtoeksyZVBPL0Jw?=
 =?utf-8?B?QTFnRnZSQzAyTmVPSEJoR2U0VTFUVlU0WlNNdXd5TXB5elJGdmhIYjRiTXF3?=
 =?utf-8?B?K2RqVDE0SVBsNGZRLzA5Y1QxUkg5OVRUMExlSHBZUnVrNGhvV0ppVVVIdnVX?=
 =?utf-8?B?ejBEY0dDbUJ0Zlc2YUIwdE5Ic2dITXZHWFBWbGdxeG1ZTkczNDFPMFZETjlj?=
 =?utf-8?B?cGtyR2V4TzQzL3FOTVVIYW56cHBTQjl0Zm5Mdm1mWjZCQXFMMjBQalRiczc0?=
 =?utf-8?B?QWpYcnZJa3UxSGFDaVZsTUpKWERmWkc1Nnk1QW5BYWdHOStOV0Q3UDdubTdO?=
 =?utf-8?B?Y3VsVXRreTl0cS9ZWFo2Qmlwalh6S3B0bHRIRnZOQmRQd21GUXFNbDZKWlJy?=
 =?utf-8?B?VWlEOVRHWUNNVUpiQU0vK1dIRXhFSDFFM2kwUmYyYlU1akVlTjdTVVJwc1cx?=
 =?utf-8?B?TGNYbGl5S3hQck5HSnhWL0Z5a09sYTMxbkptT2FxYmVoRi9RR1RmelRsOFZC?=
 =?utf-8?B?Y3N0UExMREJRNkZ3WG5LNXlYRlBCbDNROVhxLzF2ZzFXTjdOM2s2UVBGR0FW?=
 =?utf-8?B?ODc1VjZjeGxOMWVMZGRrQjVCdDI5ayt6TGM5ZmMwVEhVa2NZMk1meE1XQ1VU?=
 =?utf-8?B?a3B0RnpFVjBuTXk4eXhZcDZBYkFuL2VNayt0Vkh0Z2pHRTdZTlkrNjdnRGpU?=
 =?utf-8?B?TGJDYUF2UWtVOEdqMjJWZjNWZ0t0RWF0eGdSeHgvQlFQZXlESXVKenFScHc5?=
 =?utf-8?B?VUFONk1aVEJZQ2Y0TGpXbnI0N3RKSGw4RUdLYlVUUm16Yks0cWxObEJneFRQ?=
 =?utf-8?B?K0UrT0I1cWhYSVlBUHVWWFRMOHM0TTZ4RllTU2xFOWhoZk9wODNkdVh1ckR3?=
 =?utf-8?B?c0ZRVjZNWWtuK1FRdVZtUVFydDZmdVV6Tnl3Y2JHaXRURmtNWXJGaVFHV1dB?=
 =?utf-8?B?VVBRU0xQMzQ3ajcydDl0cE0zTG1OYnROblRLUTd2NmgvNG1YcW9XUGhIYXJY?=
 =?utf-8?B?NmUzMnhOQmR3eXV2QzB6K1U4cDJ3UVN1bHZOL0hodEpYb3NBQTFuSUt1YXVh?=
 =?utf-8?B?QW4yaGZTdXJ1eFVMNm1ESkN6Q3N4c1ZnR08vQ2RuWHQxeE1FZ3FuaitEckdm?=
 =?utf-8?B?RjlYaW0wNTU1T3hNYThRT0NPUG9VVER1cThDc2MrK0hOSmxxTGlsR0tRVkN2?=
 =?utf-8?B?b2hiWm9WMEdZbkoxL2wwbDlhb2RZUkR1VVRlc2RROHFocG9ZTTZ1ZjBaaWF1?=
 =?utf-8?B?aWRob0dIRVdlcXF4NTRtakZPVnk2QTBQdkZ3dUxrdXorK0RENlNZVVNObWRw?=
 =?utf-8?B?OGZhQkh1WnRwa09CdWZ6V0lzcnIzb0paVHZTd0VrSXdLcVdidks3WUZwbnNa?=
 =?utf-8?B?cmNoSkVMOFJzTDhCWUNXNVNaWXg5ajNFbUpXZHJtZzc1UE9CaDZCQWJ5ejNJ?=
 =?utf-8?B?ckJJYVN0L1ZtQ1UwdG5za2tLLzNzb1pYdVVyWnp1VDR2NGZscmVkOFlwNUtR?=
 =?utf-8?B?Rmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E2248B610F82CE4181AD6A16DE6C04BA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca6754ad-b3ca-4c4c-64fb-08db921c9a3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2023 23:19:34.7474
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yqZg5y6ZegP52+EPjegT3P40DQDv769nOtzpkFuQ09TP+cNj9Sd2943HcGep4fMMiazmHVUnrET3QegqkhJ+zGNdZD8b3uEJ47TVMDbBgbA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8195
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gTW9uLCAyMDIzLTA3LTMxIGF0IDE4OjA2ICswMTAwLCBNYXJrIEJyb3duIHdyb3RlOg0KPiA+
IFNvbWVkYXkgd2hlbiB0aGUgeDg2IHNpZGUgaXMgZmluYWxseSB1cHN0cmVhbSBJIGhhdmUgYSBt
YW5wYWdlIGZvcg0KPiA+IG1hcF9zaGFkb3dfc3RhY2suIEFueSBkaWZmZXJlbmNlcyBvbiB0aGUg
YXJtIHNpZGUgd291bGQgbmVlZCB0byBiZQ0KPiA+IGRvY3VtZW50ZWQsIGJ1dCBJJ20gbm90IHN1
cmUgd2h5IHRoZXJlIHNob3VsZCBiZSBhbnkgZGlmZmVyZW5jZXMuDQo+ID4gTGlrZSwNCj4gPiB3
aHkgbm90IHVzZSB0aGUgc2FtZSBmbGFncz8gT3IgaGF2ZSBhIG5ldyBmbGFnIGZvciB0b2tlbitl
bmQgbWFya2VyDQo+ID4gdGhhdCB4ODYgY2FuIHVzZSBhcyB3ZWxsPw0KPiANCj4gQWgsIGl0IHdh
c24ndCBjbGVhciB0byBtZSB0aGF0IHRoaXMgd2FzIGEgcXVlc3Rpb24gcmF0aGVyIHRoYW4ganVz
dA0KPiBvcGVuIGRlY2lzaW9ucyBhYm91dCB0aGUgZXZlbnR1YWwgbWFucGFnZS7CoCBMb29raW5n
IGFnYWluIEkgdGhpbmsNCj4gd2hhdA0KPiB5b3UncmUgYXNraW5nIGFib3V0IGlzIHRoYXQgSSBz
ZWUgdGhhdCBhdCBzb21lIHBvaW50IGluIGRldmVsb3BtZW50IEkNCj4gbG9zdCB0aGUgU0hBRE9X
X1NUQUNLX1NFVF9UT0tFTiBmbGFnIHdoaWNoIHg4NiBoYXMuwqAgSSBzdXNwZWN0IHRoYXQNCj4g
d2FzDQo+IGEgcmViYXNpbmcgaXNzdWUgYXMgaXQgd2Fzbid0IGEgZGVsaWJlcmF0ZSBkZWNpc2lv
biwgdGhlcmUncyBubw0KPiByZWFzb24NCj4gd2UgY291bGRuJ3QgaGF2ZSB0aGF0LsKgIE90aGVy
IHRoYW4gdGhhdCBhbmQgdGhlIGZhY3QgdGhhdCB3ZSBhZGQgYm90aA0KPiBhDQo+IHN0YWNrIHN3
YXAgdG9rZW4gYW5kIGEgdG9wIG9mIHN0YWNrIG1hcmtlciBJJ20gbm90IGF3YXJlIG9mIGFueQ0K
PiBkaWZmZXJlbmNlcy4NCg0KVGhlIHRoaW5nIEkgd2FzIHRyeWluZyB0byBnZXQgYXQgd2FzLCB3
ZSBoYXZlIHRoaXMgc2hhcmVkIHN5c2NhbGwgdGhhdA0KbWVhbnMgY3JlYXRlIHNoYWRvdyBzdGFj
ayBtZW1vcnkgYW5kIHByZXBvcHVsYXRlIGl0IGxpa2UgdGhpcyBmbGFnDQpzYXlzLiBPbiB4ODYg
d2Ugb3B0aW9uYWxseSBzdXBwb3J0IFNIQURPV19TVEFDS19TRVRfVE9LRU4gd2hpY2ggbWVhbnMN
CnB1dCBhIHRva2VuIHJpZ2h0IGF0IHRoZSBlbmQgb2Ygc2l6ZS4gU28gbWF5YmUgYXJtIHNob3Vs
ZCBoYXZlIGENCmRpZmZlcmVudCBmbGFnIHZhbHVlIHRoYXQgaW5jbHVkZXMgcHV0dGluZyB0aGUg
bWFya2VyIGFuZCB0aGVuIHRoZQ0KdG9rZW4sIGFuZCB4ODYgY291bGQgbWF0Y2ggaXQgc29tZWRh
eSBpZiB3ZSBnZXQgbWFya2VycyB0b28uDQoNCkl0IGNvdWxkIGJlIGEgZGlmZmVyZW50IGZsYWcs
IGxpa2UgU0hBRE9XX1NUQUNLX1NFVF9UT0tFTl9NQVJLRVIsIG9yIGl0DQpjb3VsZCBiZSBTSEFE
T1dfU1RBQ0tfU0VUX01BUktFUiwgYW5kIGNhbGxlcnMgY291bGQgcGFzcw0KKFNIQURPV19TVEFD
S19TRVRfVE9LRU4gfCBTSEFET1dfU1RBQ0tfU0VUX01BUktFUikgdG8gZ2V0IHdoYXQgeW91IGhh
dmUNCmltcGxlbWVudGVkIGhlcmUuIFdoYXQgZG8geW91IHRoaW5rPw0KDQo=
