Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 115E976BEE3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Aug 2023 22:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231995AbjHAU6H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Aug 2023 16:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231559AbjHAU6E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Aug 2023 16:58:04 -0400
Received: from mgamail.intel.com (unknown [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D92BB4;
        Tue,  1 Aug 2023 13:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690923484; x=1722459484;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=YC5JtNaoq8Ec/WrS4nz16CChgowf5YBvj0tOigYpL/M=;
  b=RBS/t+5iOBa2mT/Dt4PwioilM7vfQJ25QTn13c9Q1v8veGorwqnHxSjb
   woHxa0LMTW5vtT/e+aY2K2HSYwAwIvGrO009svaHRIrzdirHN3zRlWJbj
   zXaCsjCGMhTqRSRkhE+wU4MC+VgpGn0GGaovZ45yBY+G6u0NH//KYKIqP
   tq22r71G4eG22sH7thr0SKAspYOM+FLTZDhPSbppGR0pYhXDwjFh2eKhL
   f7lv23CJG2IRerVDXyQU2CUx9OXKmpunxEZUXuIOdFo00qVTeM2nj0gBL
   5WGPIpbqPCotrZN64+IkY6ZS9j4/LCjEwJogOjxt42LWJPEuaFHg/P3+V
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="368310483"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="368310483"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 13:58:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="852617657"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="852617657"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga004.jf.intel.com with ESMTP; 01 Aug 2023 13:58:02 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 1 Aug 2023 13:58:01 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 1 Aug 2023 13:58:01 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 1 Aug 2023 13:58:01 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.103)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 1 Aug 2023 13:58:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HRblaN5Y+qf8SyMdI//xvGMqVJH3wocT885bkEdAq6VMB8jpc+KPQOiWBZHPKmJrw+ZnOO33zoudQtJbOnmaA0Yp/TdUZXGMH/7XqPMTWVbvgdMr9D5cvxDn9jLMW0TxWc+KaR+eWLrujUrJj8TjVE00nozKTzQhqD/AIrYcW1s+eELmv7JVMsGRz2lZrNWs09xKnJ4Ah9HhfCcMqftm8Zdq2nHXvQ86EWTYhMshwm/JSDTQU1fzERsPqb/kqvlvdtq4s2APIh0YaMou0AJc0dESMWdlLDB0fb5YINPfHSgYbCTwk96513jYL+S5pF4yI+pGFv4fqeDmZdeNYwOGGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YC5JtNaoq8Ec/WrS4nz16CChgowf5YBvj0tOigYpL/M=;
 b=M8ThfuRDqt0LI5I2VwuohCCXKrwYm+/KXLVDrDdu5gYwT1yenM6jxNLR1Bp4C6W5U4AwX58ztbQZkNNeG335XHAQKHfNjBTH9WGrn7G3rkVvGclwjz7/RRrhI3ZYsOFWeXDGicxIvLCmSlJFPvP6lPmSGOL/UOVHBnc1RsGFYlydbh97IUylitRPAZe8Xqx4t0MogQAzskP7VLqBP20qVJDSGdwLdTugEV3zeAjn4jTyI6Ii6FeWUvkUcQRjMe9Xh/DPpb19/m7BlPSPLnXo7+e25/JPMNIs4yOgmG274cNFcp6yMbpwfUFIBMJnzvEel3NxAaTdBvu0yhn9slOoNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by BL1PR11MB6025.namprd11.prod.outlook.com (2603:10b6:208:390::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Tue, 1 Aug
 2023 20:57:59 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::abd2:f781:1433:259]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::abd2:f781:1433:259%3]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 20:57:59 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "broonie@kernel.org" <broonie@kernel.org>
CC:     "corbet@lwn.net" <corbet@lwn.net>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "Szabolcs.Nagy@arm.com" <Szabolcs.Nagy@arm.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "maz@kernel.org" <maz@kernel.org>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "will@kernel.org" <will@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
        "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v3 21/36] arm64/mm: Implement map_shadow_stack()
Thread-Topic: [PATCH v3 21/36] arm64/mm: Implement map_shadow_stack()
Thread-Index: AQHZw7ZZVWMs6JZuI06/zv64SypFG6/UB86AgAATdQCAAGg9gIAA9o2AgAAzsICAAA4DAIAAMoYA
Date:   Tue, 1 Aug 2023 20:57:59 +0000
Message-ID: <7d03be1277a5f4be23df35ca96f4d6cd77735e2b.camel@intel.com>
References: <20230731-arm64-gcs-v3-0-cddf9f980d98@kernel.org>
         <20230731-arm64-gcs-v3-21-cddf9f980d98@kernel.org>
         <5461c56cf4896f18bddaa66c3beec7b909fc8fb9.camel@intel.com>
         <0a6c90d6-f790-4036-a364-d4761fdd0e95@sirena.org.uk>
         <e827138f9d8800e3db158831bca88d1ea8b559af.camel@intel.com>
         <21d7e814-8608-40ce-b5d3-401f2110ad91@sirena.org.uk>
         <a9ea33d31aad0c45eab41b0dcbd4913d863cc930.camel@intel.com>
         <55c629cc-0545-460b-91cb-2ebdb8ae9051@sirena.org.uk>
In-Reply-To: <55c629cc-0545-460b-91cb-2ebdb8ae9051@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|BL1PR11MB6025:EE_
x-ms-office365-filtering-correlation-id: 7059ad1c-0ed2-4830-78ed-08db92d1fcee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xRSaUgVdkLJfHYWHMbwycmzpHkDF7jAVMIjGaq3rzVv67QN3FPkHnbyvjNAyRWu78Fhuf4qge0cu7sX+kQpBnh6EThEcTkCdqf0cMCKOnfHY6E7HxlVdwC+Sqg3VKFK92PwvJ5cxEpnGBMqDcIfLc/Xh1lSK/La4bmOL1m+3g4Frg5QH1lLa5J4pp47XDKF6mQbJQe25pd7BVX1eFoBGyiy0/94EpbVWLpdfGCBCZFGCwjLX4BCPV0XgmVcs3LJoRqlvINSpnW7gq6gQnKTqbk8xIuKvhxnmgetyVqDwIw3hxYSH91QjNV0a37zvnd1uQwasBf1YzYVbjfza5yB0tpg9ZGyUeayfggtXU7TXGR3jHUOCUGPwVP5qR/GpH4Z1KyuEwHKp/dLYiCHHsaIUqK2SaQ0YP+hIqt3AU0rbnes5Zffn8gWXJc6AIg4l8a7+UxJQXeB6dyyIrv5fym7fxTwh3BNSARHhhvP+x4yxUqgI2vrxLVUhSy7f4g7ViwzMA0BMSmHCw60KN1IPKfdHCTF0nUMH0Nmt9vqoCt+6pcGlg6B/I4Zp/AN87h9RA14XJ5fkphRJSNXFkSYGnXgFAA1j/6ip8eu+QUuKuO4QrHNkvKCOZryJxVGERcCOsA77
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(376002)(346002)(136003)(366004)(451199021)(66899021)(2616005)(6506007)(26005)(36756003)(38070700005)(122000001)(38100700002)(82960400001)(7406005)(83380400001)(54906003)(2906002)(186003)(7416002)(91956017)(6486002)(478600001)(8936002)(8676002)(5660300002)(86362001)(71200400001)(66556008)(66476007)(66446008)(64756008)(6916009)(4326008)(66946007)(316002)(41300700001)(76116006)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ekFZSnZkeUtBajFteXRXZ3o0cFZsQlA5T3NmcHRoZnJUUS9UWVBKMk45eUlU?=
 =?utf-8?B?NnhuOUc1M3ZWRWo3anN0VnhYaWRVVnFOUTZIQmVhd2pYbEYrZkVsWTV0eFdJ?=
 =?utf-8?B?ZGNZNmlraThlVEU2Zkc5ZTVRaEhpckNIRndHZGtsQmFCSnhFVU0xR2ZkVnpJ?=
 =?utf-8?B?NWtnOE1ISXdjY3VHeVNYbTlQNEwyUTI0UUlya0pJd3ZxNHpLOFpadWdMM2s1?=
 =?utf-8?B?MHl0b0hZRmpncTFtWHhRQlp4dHZMcElhYVowTnhQaW1sdksyUTRsUTZ5Q05Y?=
 =?utf-8?B?SnFiL1F3U00rL3J4ZWlVaERDRUY0bkQrZkUxUms4cmpReU5ubVF1cjVYNUJz?=
 =?utf-8?B?TkVabGRPeEFROGxFakd6L0NyWXBWZjNXTnNUUkxrN09rMmJCTkJybnFMcnBH?=
 =?utf-8?B?UlFhL2hTckJjZ2pBZ1NGNmdZb0xzZ0NkMnBQemFLOW9RNjlTMkN2dVVzZTMy?=
 =?utf-8?B?VVhhWVhhcTk1c0pnbElSTUlMZWFUbFQzOG9FVFNHYk9hbUNOMlBCdG55ZCt4?=
 =?utf-8?B?WWh5L2tUcDhKVzlHVWZzQjFnSW4xYkVGMS9iblY5Q1FrR2FaOG81ZklnTStB?=
 =?utf-8?B?RjBRV3lIRk0zeXpsSUdzL1ovNlhJUjVLUEx6NFhwQjlpc3VSQjEyV0M5d2NR?=
 =?utf-8?B?alpOajFRWW8wcVV2TGU5dnlTSzVQVG9PbHhDampOQmNlOEd0WkZObVNMVU1W?=
 =?utf-8?B?Wk1hcXU1SjhrUFVLN3g3cjZ4Rmx2Y0pCN09ROTZjMDZ0VEJKYW1Yc3phM0dS?=
 =?utf-8?B?SW0wUG43WU1LKzgvNUlJSElyQ01Gd3BGWHN3dEFJVFBzckdEYWZOUDFzcm9J?=
 =?utf-8?B?RFdSMXhFdEhqY29kcThkQ1BrL25CQ0J6TUMwalpqOVNCekdZbzIxMmIzOVR6?=
 =?utf-8?B?cWhlTnpvcGk0dDVYUmVmMUJkakpMSTN4a2txY0JVY3NNOVJFVHp4UklUMHF5?=
 =?utf-8?B?akRqekRFZVRPQm9TbzUxa25HZ3luSXhUSTY1U1Q1QzVJNjY4MUJKcy92V2dD?=
 =?utf-8?B?aHNDcWlqVGJjTGNRK0JKUE9Xb3VKQ1VZTDFwWE1xa2YxUkFkamtna09mNGhQ?=
 =?utf-8?B?aUt6Y3k4S3BlTzlJTjJDLy9jYTJINlRkMDViQkRNQUVqS1l6MjJDZGJNVzg5?=
 =?utf-8?B?ZWVCL1lWVktEcFhjQ2lpbHAwSXBEY0VBNkpHcVQ4T3hJZm5PdVFHNG9TZ3pL?=
 =?utf-8?B?NWNCSnR1clVUQVBKUHVvQzZmWHhnUTJlQnV2ZVNKL0xoV25TRTVUTWg0RTZJ?=
 =?utf-8?B?SUtWZTlUZHY4ZzBzVU45VXpjdXFyN2dvRGNXV2cwUXRkNlRSOTVZUUl5ZFQv?=
 =?utf-8?B?ZE5ha2V5M01CNnFHeFhEejFIcWNFbnhzL0hKbzlVdVZ3MkVEeE1yeWFZa3dr?=
 =?utf-8?B?dm5PaFVOK3MxQWxvaDR3cEVzK1ljUjZvbm9tTjVHRG1MRFdhZmRzL0VPaWNs?=
 =?utf-8?B?b3FQVVgwdGk0ZzRKeUc0UTRzNHBYK05HVTdIVG8yR0dselEvb3RaM0hCZ2ht?=
 =?utf-8?B?UlNnaDB1MG9XbmVYWTkybmJYYys5eDcrVG5vNnZmaUp0ZGZzRW5OMHRtUVU4?=
 =?utf-8?B?NVROdEovOW5GTFQyWFFnQm9obzlPY1VsKzFKTVlvU1pET1BJYjJRM3hEbW5w?=
 =?utf-8?B?ZXNudnBra2djSnRtNE9yNnNra3JXbThsdHVMa0VURnUwV1hPcVBmS2NicnZh?=
 =?utf-8?B?em9ZQzFKNmRTZi8vdW01K0I0UHFXVldyOFpYRFN2cDdyditMUGZ3cDE4NEo3?=
 =?utf-8?B?OCtDS2hxSjdkcmQvTW5wT2oySEdZb1NJNVEzcldyT0RDWU9xTlMxK2JzeFFY?=
 =?utf-8?B?L091aUtnSVZCY0pFSGZvbDdWVFRKQU5hMXBpMm1xd3M0b1hobHNuS280OGFv?=
 =?utf-8?B?V3BZckZCUjFrSk1KbXBLNGU4VVh0c2NFWHpkMmpMdlBpYTZ0UXJoNEJlNEJw?=
 =?utf-8?B?c2RnSmNuOXRDQU1Ea2N0YjZLVHpzVk9udHBrN0kzSUVmU2E3NGtIMU5CU25q?=
 =?utf-8?B?WE1JUkJNQk1kbVppOGVuVjhldVY0TXVwWGRFUWRuL0dHOXh1NEllSjhjSHk5?=
 =?utf-8?B?WnF6Ui85djlBb0dacmJXd2xSajgremhaQlNCcWpKa2pQQWhGaWk3YytCVE9L?=
 =?utf-8?B?cEowenRQWEtuajU5MUgwbWtYUXVkUTMwaFFxQ0JldTFzY1Nyc3Bzb1RQbWFw?=
 =?utf-8?B?OUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C01773FE4960B04D83C367382FA13904@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7059ad1c-0ed2-4830-78ed-08db92d1fcee
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2023 20:57:59.1884
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NnnL1FG9d5WSNM8pgj8V26UfYRktG+KK8bdjlQv86dHXbpEuXOqS1jGrzNYGytt75xEuMoWE1GenVXLTNdqP22EJYzrC+D9y3N2SxPTcD2A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB6025
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gVHVlLCAyMDIzLTA4LTAxIGF0IDE4OjU3ICswMTAwLCBNYXJrIEJyb3duIHdyb3RlOg0KPiA+
IFlvdSBkb24ndCBoYXZlIHRvIHN1cHBvcnQgYWxsIHRoZSBmbGFncyBhY3R1YWxseSwgeW91IGNv
dWxkIGp1c3QNCj4gPiBzdXBwb3J0IHRoZSBvbmUgbW9kZSB5b3UgYWxyZWFkeSBoYXZlIGFuZCBy
ZWplY3QgYWxsIG90aGVyDQo+ID4gY29tYmluYXRpb25zLi4uIFRoZW4gaXQgbWF0Y2hlcyBiZXR3
ZWVuIGFyY2gncywgYW5kIHlvdSBzdGlsbCBoYXZlDQo+ID4gdGhlDQo+ID4gZ3VhcmFudGVlZC1p
c2ggZW5kIG1hcmtlci4NCj4gDQo+IFN1cmUsIHRob3VnaCBpZiB3ZSdyZSBnb2luZyB0byB0aGUg
dHJvdWJsZSBvZiBjaGVja2luZyBmb3IgdGhlIGZsYWcNCj4gd2UNCj4gcHJvYmFibHkgbWF5IGFz
IHdlbGwgaW1wbGVtZW50IGl0LsKgIEkgZ3Vlc3MgeDg2IGlzIGxvY2tlZCBpbiBhdCB0aGlzDQo+
IHBvaW50IGJ5IGV4aXN0aW5nIHVzZXJzcGFjZS7CoCBJIGd1ZXNzIEknbGwgaW1wbGVtZW50IGl0
IGFzc3VtaW5nDQo+IG5vYm9keQ0KPiBmcm9tIHVzZXJzcGFjZSBjb21wbGFpbnMsIGl0J3MgdHJp
dmlhbCBmb3IgYSBrZXJuZWwuDQoNClRvIG1ha2Ugc3VyZSB3ZSBhcmUgb24gdGhlIHNhbWUgcGFn
ZTogV2hhdCBJJ20gc2F5aW5nIGlzIHNheSB3ZSBkbw0Kc29tZXRoaW5nIGxpa2UgYWRkIGFub3Ro
ZXIgZmxhZyBTSEFET1dfU1RBQ0tfU0VUX01BUktFUiB0aGF0IG1lYW5zIGFkZA0KYSBtYXJrZXIg
YXQgdGhlIGVuZCAobWFraW5nIHRoZSB0b2tlbiBvZmYgYnkgb25lIGZyYW1lKS4gVGhlbiB5b3Ug
Y2FuDQpqdXN0IHJlamVjdCBhbnkgZmxhZ3MgIT0gKFNIQURPV19TVEFDS19TRVRfTUFSS0VSIHwN
ClNIQURPV19TVEFDS19TRVRfVE9LRU4pIHZhbHVlLCBhbmQgbGVhdmUgdGhlIHJlc3Qgb2YgdGhl
IGNvZGUgYXMgaXMuIFNvDQpub3QgcmVhbGx5IGltcGxlbWVudGluZyBhbnl0aGluZyBuZXcuwqAN
Cg0KVGhlbiB4ODYgY291bGQgdXNlIHRoZSBzYW1lIGZsYWcgbWVhbmluZ3MgaWYvd2hlbiBpdCBp
bXBsZW1lbnRzIGVuZA0KbWFya2Vycy4gSWYgaXQgZG9lc24ndCBzZWVtIHdvcnRoIGl0LCBpdCdz
IG5vdCBhIGJpZyBkZWFsIG9uIG15IGVuZC4NCkp1c3Qgc2VlbWVkIHRoYXQgdGhleSB3ZXJlIG5l
ZWRsZXNzbHkgZGl2ZXJnaW5nLg0K
