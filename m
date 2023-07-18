Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE9777583E0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jul 2023 19:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233338AbjGRRwa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jul 2023 13:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjGRRw2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jul 2023 13:52:28 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87524A1;
        Tue, 18 Jul 2023 10:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689702747; x=1721238747;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=wtelWRk7MKWhr2tYUSdTBJgR/9igMRxjgziQDvLciwg=;
  b=lH03UmugDw2dLQvEk0nVq81AUKtXvACb/gRq3ERJBEwQUsOGd35iFwAT
   FNVL/KnlpF0gcxnx+9JhaPL+ZH6aZkGu97RByQ06x+XlXNEwGYN3mmmDi
   2UK/DpJjpS9dnoc1hUIKrVLzCQsNctVwaSGJ1tsQT5P/9I5IliL9/ddWo
   fEEOzdyp8oVMpbjSsYYAgrw6cSaDgA37Wp0L9wtafbbseSiKtwsJlG7/p
   lgjMLF7QxuM8+Xt22KB1EntFkW2UbjoN1YgnQF9XnEnmKqhqX2X81Agx6
   K9s+xZAH6ZIzgSXm2FHtsd+/s0quEUEgnK8r4I4ZL4bRB2nnvRaVj5Z5t
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="356218507"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="356218507"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 10:52:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="674008428"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="674008428"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga003.jf.intel.com with ESMTP; 18 Jul 2023 10:52:26 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 18 Jul 2023 10:52:25 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 18 Jul 2023 10:52:25 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 18 Jul 2023 10:52:25 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 18 Jul 2023 10:51:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TarnZNXDn6XW+FZvqva4e/flYqgovNUOAWq6B+7U6wgITBexcL8Ym+9IdnnXWkB1OsQMixXi4jRDYZX5g043sgdIlyRvNklzD2Dw4LSyXLJSwk98t2/mZHLiglxnQYr3W/pzIFNYFSawb7WBYkjw1e1DeG40rCfYCT2crowY51Z/2Vuz7XEKupnN0ZUKxh3j9+5l13b/b0+lQ2yPWVXM1w4e0VK0+8PEaT2h9FVtTA2AwjW9YSN6TYzKY/K5T6paiwVlOROJMWwrmY90/QMNj63RVfKCKtDLVrezicvHK/Wh9+cQ+ffvc4z9ZR/77kW7J/Af1F2fgwW0ahRQ8TklBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wtelWRk7MKWhr2tYUSdTBJgR/9igMRxjgziQDvLciwg=;
 b=C9lSMK0gpm1A2caGGc8/afcmvUyBE/ZxnsAYuBAR5NTGg46T8HLwgDSN6jkO2qw2o3+sPnqnSTWXt0vOb/4JX/CSkY1WSZW8JIqSzQou3/0rTkhCH0A5X5nXB5mkpftSKEWeCguX5mi/FIe4gnPSPpIA0Br/KDvsKuAvY5yjfu17n9NKmAmOvg3I+AIwSWRrONts8slgooYV4ZCxHZXQrFTmgWrwo18M4J5fQGYRlqPc1mu5O78k0l/Ih/YrETFNhwR1/sCYW048JE69LpBIaF55GB0zFybXXqco3dpM4PW+8YVsJG3NvUHhTfNrlLdBUoObjnu56hxG/a+h1hY5fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by SN7PR11MB7707.namprd11.prod.outlook.com (2603:10b6:806:322::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32; Tue, 18 Jul
 2023 17:51:54 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::abd2:f781:1433:259]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::abd2:f781:1433:259%3]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 17:51:54 +0000
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
Subject: Re: [PATCH 21/35] arm64/gcs: Implement shadow stack prctl() interface
Thread-Topic: [PATCH 21/35] arm64/gcs: Implement shadow stack prctl()
 interface
Thread-Index: AQHZuDA1LUh5Nzx/+EyacdABEqXnPK+/0LGA
Date:   Tue, 18 Jul 2023 17:51:54 +0000
Message-ID: <2e1c24e343fb920e1f8616e083bba625717c384d.camel@intel.com>
References: <20230716-arm64-gcs-v1-0-bf567f93bba6@kernel.org>
         <20230716-arm64-gcs-v1-21-bf567f93bba6@kernel.org>
In-Reply-To: <20230716-arm64-gcs-v1-21-bf567f93bba6@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|SN7PR11MB7707:EE_
x-ms-office365-filtering-correlation-id: 982e5bea-ba1f-4167-01e2-08db87b7ac88
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RRLOtkMqM39awwWdPebxuS7IsNwpkIZHPBf+Zz7kHEHQarwwcoPQRwDSJxlXSjgwQPGKBTxHL/fJrNmF57+NOraNSyyyxxCVwmmPUyiKiMXbjDjSE/I+DKXEgifnZLq95Q0ph53oR4Ix/v6co7McGwPFqLOG2zG6Z6+hPJKrN0/XLoOmzErqQeCPW/KbLCGAk0G99ORXyUGBYimgUNXoqxmQet2cDjkTt2jxTMXKb7Cl1pBRTfZTzuPfPmSbDCghQcLDrkIupL4YumzzEKoZBm3Q67Ak5+IgC6oEGbyPDKHDgrFUhJckn9t1Bo9cjgIrBKcMFEs+zFCnQxG/8QFTuwdHPpE3lDsAPrulOiyyQgrFphZW+W6EZK3dRJSuZ+R0FcV1oqbprRt7eJx7nOKI99oudbJJm/vK/DvavYKM3PTTl7mFV/FkhNBtIe46Ca28EynZsKmYq9OD2407q8Cmb6CdtNwQW8YUzgriuD3nHghoXuhKiDyX1x9/0Y7XfkDlElyMbHPRd7rYNA/0wQoJ2mUaDopPyqOa16e//ZIHvoujYA2JW4iOEoaxLOZqYyWohglWzy0XYTr20l16Z+Vi45ACHB6RklS2IV8WWjnW34bOI5AyIy8Denu8L3b5Kd6nbuPJWoZg88JS0RwqfC2fNA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(396003)(39860400002)(366004)(346002)(451199021)(91956017)(316002)(66946007)(4326008)(76116006)(122000001)(86362001)(38070700005)(38100700002)(66446008)(82960400001)(64756008)(6512007)(110136005)(478600001)(71200400001)(921005)(8936002)(54906003)(2616005)(7406005)(41300700001)(66556008)(7416002)(8676002)(66476007)(6506007)(26005)(5660300002)(186003)(83380400001)(2906002)(6486002)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SWRYR3hYdVlTZm5pRXBTMDM3cnBLQ2pFK3RoVGo3VTROWkJoaDFZbk9NbDFL?=
 =?utf-8?B?aW5CR0s1TURaaWdHVHp0NjFvT0IxQmwzUDF0MnBJWlJnSnNoTDJEemJhYjIx?=
 =?utf-8?B?eGhML1NFQytOSDZaY0NBOVR3aG5SUE80bGNCNTgybmtRaWZORFJjQ2RKZTQ3?=
 =?utf-8?B?WEtyT1J6a0JXNE5tOGZadENpYjgvMzN0T1JjVG1qbG43NWt4MVVCcWZHcitF?=
 =?utf-8?B?MTNEZHNCSXUrcWUwS1creFlVdVBYSlZHTG5DUU9YejZRTUtTRUFvU2U2Skxs?=
 =?utf-8?B?Y0tYQVBCSmVKWGgwR3F4R0tvcTZUVGM0ZERjM2l4WjJCSm1DWDNaL3gvME83?=
 =?utf-8?B?VkVoc2tsSVBCMUV1Zy93elh4aEwyUkNLNzUvTjk4aVBJQUJzaHlhVFh0eFRP?=
 =?utf-8?B?enM1d21zVUpVeFBvaitoNHEvaUVwZ3ZXWk5rUzdoNFdTdExVL1BVUzdUTTJT?=
 =?utf-8?B?cjFxTTJpVFZNRmw1U2g1OUJSZ2Q1cEFQb0htUC92OXlUZm40WEc4elp2WnJF?=
 =?utf-8?B?MEh6L0tzcjJzaCtBMHBSdFBLS1hIUFJDY0diZVQweHJDS3J5dUxJeXRMWXds?=
 =?utf-8?B?YyswbTVMT2IyeXlZTzFKUWZOWkZ6RXNjelNOdWdNcjRVMm1hUU9RZkxaNjlW?=
 =?utf-8?B?Nm92cEROeGNtcVQwY0VFNDhUckpsemdpazNCa1QxR3p2MjBwS1ozWTZ3QzZu?=
 =?utf-8?B?NW4wdkFvVnJyYWlZcUFTN2JxbUQxZDBTSXV0RGJQQUJsYmFuRGIrek5jWDE4?=
 =?utf-8?B?Rk9UQ0E4bWp3ZXowdTl2dVpNU3lnbDI2VzBsOXNuY2xvVmsweE5HVXNFaHls?=
 =?utf-8?B?ZFJ4NGpCRVQ5VWxwSWpTYlk1VmNPZTNvcGxuMWpua2paSHlRYUwrajZMeDJt?=
 =?utf-8?B?c2JPZDkwZjEzRHdTM3VjZzhBUVRNRXBxZEZSNk5VYjZhSEs4bTdiNSs3TG05?=
 =?utf-8?B?NHVsL3dDTzRZSVYrMVR5OVBlSVlrRmw3ZWo3NXEwNGNYZ2wwYkZiZTU1MHNO?=
 =?utf-8?B?VFo0QzFlZGVWSlhiUEg3b0VrWGFqVnBJaTNCZHlhNmFQYWVmMm5WVnVkZ0tT?=
 =?utf-8?B?K1R1MXVFNUo5V05TaGx0V2hnRFVDTWlYTnlqR1VnWUx2TTVsdndDU2J0NUxR?=
 =?utf-8?B?Wkw5bWQyUW80OXJLWmZ1bmpla3JmMUFuZHNMWWRoYjI4UjlFL1FYanB4M2dp?=
 =?utf-8?B?aUV3eUNBbXRZYkZRZEluN3pJVGx4K21xTnpadVRxREtEM3M5dVIwc1l5Qmt4?=
 =?utf-8?B?UkVnSE1mRjFQaEpCT2kvdWl2UUZ4QkplUTN4ckJtOXg5WEY3UHRoWC9ac3Qv?=
 =?utf-8?B?YnlEZ3JibEQ5SEZZMDlleTFjK0VDeHNIRmVrTmFGYkZzWTE5Z3NzRUdFM1BI?=
 =?utf-8?B?R2dxWkhSNjB3QWlSc0k4c245Vm9zK2tvR1Z2YnFrMHVlNG42WkNtSHBRelIr?=
 =?utf-8?B?WGx4WGJRSWVMMlR1YklKcW4yNGg0WGpuTnM2emtVc1J2dS9SNXhkd3UvamF2?=
 =?utf-8?B?NS9lMUxlSElNU2ZUeVpLbFhZU0ZlajlBMUpiUUxXZENyMlcyclJuNEdWU2xy?=
 =?utf-8?B?bkpscHA0amdCdkprdjdpb3AwR1UwL1JOTE9XemdqblJnUHpyREd2TUUxMk5Y?=
 =?utf-8?B?S3FWQS8xcUpsOWdYZkRtMGlNeVdzWml2NWIwalVmYTR2cmkyNkhSZnJiTGpi?=
 =?utf-8?B?Qk83OXdKWW5mcTQrWERQbUl6c2ZaS0Q1cE5SQkk3SGFmWG1BR0F1ZXpSelBk?=
 =?utf-8?B?TFYxSmJLeWtHQkZ1OS9pV1dGMWx4MUJHbWNsVmx1VGN4ZksxbmRCVEoydEJT?=
 =?utf-8?B?QmZQN2ozcG5sckFST0FlRFUrY21NdGJ3Y2lhZ3ZRVmRtaGRxRjZtOGtDVFg4?=
 =?utf-8?B?ejdnb1NybEZBcTFqRlorQXdIakEyUTh5Z25oQXN3V0FXUG16amV5RWRsVkxX?=
 =?utf-8?B?ZWh4QkZJVjVvbnVjM1JoSHpTUklYMFBXMnlsMXczYjJSdmlRR0RYNkVCQ1lW?=
 =?utf-8?B?b1VOZ3VjVHlEdmFQZzkyYWpXQkR3NzlYNE1FRzhqQ29JcVhjRWtHYlBFWE1K?=
 =?utf-8?B?eXhqenRKSUZFZ0lZanJYb3VMdzYxaEFUeWNnUUM3dDBnTlpRTElYUjJNcUQ3?=
 =?utf-8?B?Wml3dXZIZnF3a0h6b2Y0NmUvUGZtODVVc0Y5MVZXQ0p6NUlpSWE4d2hWM1k5?=
 =?utf-8?B?M2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <40E75ED7E5D8524EAFA027E8D22BA07E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 982e5bea-ba1f-4167-01e2-08db87b7ac88
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2023 17:51:54.6156
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rwhjObLJn1jIdbo5la5ONzFvJSQMdOaBf+Fx5+GWK5DhCYD8yz4LZAZjzrl0AIAjllRLjf6oB1L0Ux3S/sEjILH9F8+mooHGVe5VJ1xED0k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7707
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gU3VuLCAyMDIzLTA3LTE2IGF0IDIyOjUxICswMTAwLCBNYXJrIEJyb3duIHdyb3RlOgo+ICtp
bnQgYXJjaF9zZXRfc2hhZG93X3N0YWNrX3N0YXR1cyhzdHJ1Y3QgdGFza19zdHJ1Y3QgKnRhc2ss
IHVuc2lnbmVkCj4gbG9uZyBhcmcpCj4gK3sKPiArwqDCoMKgwqDCoMKgwqB1bnNpZ25lZCBsb25n
IGdjcywgc2l6ZTsKPiArCj4gK8KgwqDCoMKgwqDCoMKgaWYgKCFzeXN0ZW1fc3VwcG9ydHNfZ2Nz
KCkpCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiAtRUlOVkFMOwo+ICsK
PiArwqDCoMKgwqDCoMKgwqBpZiAoaXNfY29tcGF0X3RocmVhZCh0YXNrX3RocmVhZF9pbmZvKHRh
c2spKSkKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIC1FSU5WQUw7Cj4g
Kwo+ICvCoMKgwqDCoMKgwqDCoC8qIFJlamVjdCB1bmtub3duIGZsYWdzICovCj4gK8KgwqDCoMKg
wqDCoMKgaWYgKGFyZyAmIH5QUl9TSEFET1dfU1RBQ0tfU1VQUE9SVEVEX1NUQVRVU19NQVNLKQo+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gLUVJTlZBTDsKPiArCj4gK8Kg
wqDCoMKgwqDCoMKgLyogSWYgdGhlIHRhc2sgaGFzIGJlZW4gbG9ja2VkIGJsb2NrIGFueSBhdHRl
bXB0ZWQgY2hhbmdlcyAqLwo+ICvCoMKgwqDCoMKgwqDCoGlmICh0YXNrLT50aHJlYWQuZ2NzX2Vs
MF9tb2RlICYgUFJfU0hBRE9XX1NUQUNLX0xPQ0spCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoHJldHVybiAtRUJVU1k7Cj4gKwo+ICvCoMKgwqDCoMKgwqDCoC8qIERyb3AgZmxhZ3Mg
b3RoZXIgdGhhbiBsb2NrIGlmIGRpc2FibGluZyAqLwo+ICvCoMKgwqDCoMKgwqDCoGlmICghKGFy
ZyAmIFBSX1NIQURPV19TVEFDS19FTkFCTEUpKQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqBhcmcgJj0gflBSX1NIQURPV19TVEFDS19MT0NLOwo+ICsKPiArwqDCoMKgwqDCoMKgwqAv
KiBJZiB3ZSBhcmUgZW5hYmxpbmcgR0NTIHRoZW4gbWFrZSBzdXJlIHdlIGhhdmUgYSBzdGFjayAq
Lwo+ICvCoMKgwqDCoMKgwqDCoGlmIChhcmcgJiBQUl9TSEFET1dfU1RBQ0tfRU5BQkxFKSB7Cj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmICghdGFza19nY3NfZWwwX2VuYWJsZWQo
dGFzaykpIHsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oC8qIERvIG5vdCBhbGxvdyBHQ1MgdG8gYmUgcmVlbmFibGVkICovCj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAodGFzay0+dGhyZWFkLmdjc19iYXNl
KQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoHJldHVybiAtRUlOVkFMOwo+ICsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoHNpemUgPSBnY3Nfc2l6ZSgwKTsKPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGdjcyA9IGFsbG9jX2djcyh0YXNrLT50
aHJlYWQuZ2NzcHJfZWwwLCBzaXplLAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAwLCAwKTsKPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmICghZ2NzKQo+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoHJldHVybiAtRU5PTUVNOwo+ICsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoHRhc2stPnRocmVhZC5nY3Nwcl9lbDAgPSBnY3MgKyBzaXplIC0K
PiBzaXplb2YodTY0KTsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoHRhc2stPnRocmVhZC5nY3NfYmFzZSA9IGdjczsKPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHRhc2stPnRocmVhZC5nY3Nfc2l6ZSA9IHNpemU7
Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAodGFz
ayA9PSBjdXJyZW50KQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoHdyaXRlX3N5c3JlZ19zKHRhc2stCj4gPnRocmVhZC5nY3Nw
cl9lbDAsCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBTWVNfR0NTUFJfRUww
KTsKPiArCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoH0KPiArwqDCoMKgwqDCoMKg
wqB9Cj4gKwo+ICvCoMKgwqDCoMKgwqDCoHRhc2stPnRocmVhZC5nY3NfZWwwX21vZGUgPSBhcmc7
Cj4gK8KgwqDCoMKgwqDCoMKgaWYgKHRhc2sgPT0gY3VycmVudCkKPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgZ2NzX3NldF9lbDBfbW9kZSh0YXNrKTsKPiArCgpBaCEgU28gZG9lcyB0
aGlzIHRhc2sgPT0gY3VycmVudCBwYXJ0IG1lYW4gdGhpcyBjYW4gYmUgY2FsbGVkIGZyb20KYW5v
dGhlciB0YXNrIHZpYSBwdHJhY2U/CgpJZiBzbywgdGhlbiBpcyB0aGUgYWxsb2NfZ2NzKCkgcGFy
dCBvbiB0aGUgd3JvbmcgbW0/Cg==
