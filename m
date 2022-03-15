Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 369674DA4EC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Mar 2022 22:53:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237315AbiCOVyc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Mar 2022 17:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbiCOVyb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Mar 2022 17:54:31 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CD7963FA;
        Tue, 15 Mar 2022 14:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647381198; x=1678917198;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=WO5NOStJHjP/Kn5gltuqAEXde9ssn73ZM1u+Lm2K1WE=;
  b=ElmQ/G2vVxG35voqt8gvim2I6QUxHrm4bev18S5k1Mc6/C9xdVaKrjDf
   cnSvANV4cd2sY3RvNIHSp3xIUFS57R+M87he6K2JvCmOEK7tQaLQKVn2g
   9k7vPf0X/GXQjFy40ZsbyjxL55auXY8daqqPORhx35KGZJtJmHMo8BfQ4
   9FP+tHSAMy2zyko9idiDOP8boO3icXvmt8PAQgw4TQhWZre5G0VTWcy2u
   gFaZN7LGwLkv5fAR5S2BxFcWXha1zu5QYtjPXgrhuzShlKmdgC2rjjKrT
   TYcHLzBL5uCo4vpaF3NXNyF6fL9d9gyOI6uH4rJmc358uvoGPCXwNLmbd
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="256621129"
X-IronPort-AV: E=Sophos;i="5.90,184,1643702400"; 
   d="scan'208";a="256621129"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 14:53:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,184,1643702400"; 
   d="scan'208";a="644421635"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by fmsmga002.fm.intel.com with ESMTP; 15 Mar 2022 14:53:17 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 15 Mar 2022 14:53:16 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 15 Mar 2022 14:53:16 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Tue, 15 Mar 2022 14:53:16 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Tue, 15 Mar 2022 14:53:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y+klBI6GPYxTEMOgyeCjmahWTiLYeNDV2XWPRjWKM2KJ6Wdal5DAn3996F/Xk3xaAe3k9wnfg97HeypT2AHojOUPZKT/TE6IL7yb+9mUGK2V2C1nI5BwYFML3A0NjUGWQspfjsFYy+fDhyoAEw3Bq1dmPOpaNHAA4iCI83uJiR9KlcsKJ1Xtt6Pbxo2H6KSK/1VJVi1XFqcNK1/rEV/pHJ8mbKOi4WfU89w4bDIFLBOnZd97kvonBNW//JlPT837diaRIlmjkxHZ7MyoQ61mOXL3rg4kEBuBGzYEVUkhP+VhfzZlBSJEt88gf1kKtCGpiN4NES0F0DIODmhhDFaUVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WO5NOStJHjP/Kn5gltuqAEXde9ssn73ZM1u+Lm2K1WE=;
 b=mCl/OSG15FBKNNx0glo1nOvLhgoaHZ3hD1f5vjatH3CkRr9t6n3zKSZEsotUH3co5zUhau+ZxWPimpoOtJOZ8K8RLXLbJJmfTFlLoaH3GdRX/xv010kPywRmiqIBTxHVGPSq+NcatOdpRKAjhDa4y1ZdJ/qOZQJabO5H2pz60JeIy/JeK3T0HbJsqKtzfseQxNB7zxk8yd78ytfIY9XR4cUJ+VHZq9BJv9GJ7jihdT08r3usvuzd3OrKBRU+AxtzCrsgR+D+30mQwiIhFvfbUwnkgE46oDpylcgE44mDY14IJxvr+CXwAPyiyim/nts6DHljvEqgWCu4uovUFt2eLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by MN2PR11MB3903.namprd11.prod.outlook.com (2603:10b6:208:136::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Tue, 15 Mar
 2022 21:53:13 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::c1ac:4117:326:eff2]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::c1ac:4117:326:eff2%3]) with mapi id 15.20.5061.029; Tue, 15 Mar 2022
 21:53:13 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "keescook@chromium.org" <keescook@chromium.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Brown, Len" <len.brown@intel.com>
Subject: Re: [PATCH 1/3] x86: Separate out x86_regset for 32 and 64 bit
Thread-Topic: [PATCH 1/3] x86: Separate out x86_regset for 32 and 64 bit
Thread-Index: AQHYOKnIB2wsd8uW6EiQs+9kCgApRqzA6N8AgAAT7wA=
Date:   Tue, 15 Mar 2022 21:53:13 +0000
Message-ID: <fe7ce2ae1011b240e3a6ee8b0425ff3e2c675b6d.camel@intel.com>
References: <20220315201706.7576-1-rick.p.edgecombe@intel.com>
         <20220315201706.7576-2-rick.p.edgecombe@intel.com>
         <202203151340.7447F75BDC@keescook>
In-Reply-To: <202203151340.7447F75BDC@keescook>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3d7871ae-7a26-47a8-d97c-08da06ce345a
x-ms-traffictypediagnostic: MN2PR11MB3903:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-microsoft-antispam-prvs: <MN2PR11MB390359EA6647D8CCC0D63AE6C9109@MN2PR11MB3903.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eS0HeKCtTiSBtjyuQEVgWMLBHeQiP3T9qmhwWvTwkiCQ81BD3IpQzJH3LOMU8oQKoDV2WYI5jueuOEJZdZ94W/EIn4hoE0CHNTI13CSaeQo+XduklF38HwPnGHy/JXtX6IwtkXtC+d+JgGIzFJj/5vAZyzbAgEEBuC8mmsLmrNLKGO/HemXwKdKAXrWkC3+HHrKx7Yyebh1h97+6fmiFRVLzKxSm+FMPm8tLiEkVTtixX7m5xHSTKyvp2YGOKEsrcnBvpChTt837PFUUQ2L+8DiiWdb/IbgNxx46cB8sZOKSaRPPT8UYOE1kRgy8k+wwnHCxxgEFdLmxyDGGVuu0AXZtRAspbvjPO0bsNtYXGJiFOwkHAdrW1146cUy915JVuZoHLcUI4IrJ6ltLgXmzhBBkKD0yKvSufBjiRqKZBCodDuA8Ia6OG7FSEkPm2PcPY5QEXGTn8VsEmlXrDL7SuZHRYZVVhGA8WnQoDIbQNyPZzkvhBiwQIKzaEeIqnIEoZeOhnKzMBiN7SmGW8zGL0MXVqgY0Jj04dErmSceX9rF3HY18kmsKgM0suIejCwkhKGRZRUFocZAVBPd/PwNJUrc/bGDi+H2AIPoPpd+nM5JOjD9Dl+Vc0SruvqzV1sa5j4aGqyVR+OSBxIzl+FYtWbb9/ryqNHOzQoIyAmCL/UIS2upNxZCgDVpDakXghOYa2BXpEebSzdHpsxkJ0l3Mbqa4r8MIfXeaBNR54uyyfxE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(82960400001)(122000001)(6506007)(316002)(54906003)(6486002)(6916009)(83380400001)(36756003)(71200400001)(2906002)(4326008)(186003)(26005)(38070700005)(4744005)(5660300002)(66446008)(2616005)(8676002)(38100700002)(66946007)(64756008)(66476007)(66556008)(86362001)(8936002)(76116006)(508600001)(6512007)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WEdwT2YrWTh2bWdaTlZJOHJicUdqVVUxQm8wSm5aaWYxemdkZWhnQ2trTXpP?=
 =?utf-8?B?ZHRsa3hjNXpZeFVETkR0eGVIdDg4WkVUYjBVNW9abUNmeEo5WWw1OGxNR1JQ?=
 =?utf-8?B?dExJWmxWVnVxY2UzMXR5V0lEQUpxUlRtRGpCcG9FOHo1ZVhGc1FBcXhYRUJH?=
 =?utf-8?B?Sm9FQVJ4YU81Yi9mNm5ZMGNkN29IVnl6RGRmVHNyNXozTERwTFBJdUtCQnBu?=
 =?utf-8?B?VVM1TDFIdEUvdmtTMHRaMUQyWVduVUJHWWhvbFRmTlV5aGhuMlBuOXdjeVZD?=
 =?utf-8?B?YTcwcGpjQmNUVittLzl0aU1OV2JXcGVqSi9sVFBlRG0yMVB3Z2FLTXFhazdF?=
 =?utf-8?B?NmtqVXlJMGgvTHZ3RGduLzl4S25tL1pESG9IWFJPQmpSYnd2OWxMMmg5YW5D?=
 =?utf-8?B?VWpzSG9sQkJCSVc5dW53SDZWenBIZVBISTNKUnJOeUl6aEJNUU9rVHNuV0RH?=
 =?utf-8?B?cUNyVzJkOERGY1llOFFpNzRhbGFNZUh1VEdWKzZEaGxoaEwyR0dBMHBlczR5?=
 =?utf-8?B?bzI3M2FFcHFtaDdwWmNVK2FDaDJVaXJoaW04a201TzE3L2gzdENtTHJaZ3Ez?=
 =?utf-8?B?UjQvZjJod25xeVYvUDRyek51QVJ5bTZaYmhpUkkvK2Y5SjJvakU5WFh1aGZN?=
 =?utf-8?B?bDk0SktEVE92ZGh2WVlkSTBhZXcvd2RZaVFQRlB4VlJ6Zlc1bGlqd1VuREFZ?=
 =?utf-8?B?aUtndkFoeVRFdHhKZW1HeFNqenlLNEdwVlFhUyt0aGxndkZjSTVqdGN4QzJ5?=
 =?utf-8?B?NTd6ejhBYmFiVHEzbFlKUXQzR3JSQlArVU10Sk1JTjFiM2FIaFFjWU52dlJ1?=
 =?utf-8?B?N01vd2xwUlExeVBmMzBDQzlHa3gxMmNJdktVblJIN21GVjFUQnE3bzhaaWly?=
 =?utf-8?B?bTJva1JKQi91NTBTRUUzNjhNVi82Qlk3SUZkdmxNVXJBSGtkSG1Qc0h5b0hp?=
 =?utf-8?B?SUFRcTBTRlVqS2w3K2ZBTmV5MFhVSEQ2TnA3SkVjaFpub1J6cUdTVEFMaXp5?=
 =?utf-8?B?bjZwTjl5WlNhVzU2UUpNaDBRbXNPbHJITUZSM1lsZ2NPU3RhTGV5ODNHOEJ4?=
 =?utf-8?B?eE5OL0Y3RmJNYzBBV2ZCZklSUDJoQXM0TGR3RHJmZiszcVg3Zms2STRxcFJz?=
 =?utf-8?B?M0FWU3dWVkk2WWp3c0owRXlXekhIMHo4ZWFmeHJrUkdmNzBVYk5BK3RVclFJ?=
 =?utf-8?B?UG5qelJGZDZ3d1JzMWh1WFdMSWQvYWtzRVJKV0FNL2hROGVKN01nWE1DQXFv?=
 =?utf-8?B?WUdVSC9lTGRWZ08wTHROanc4dk8rUE9STHdaL2hseUJ4VXFYMEpENnpQRkFF?=
 =?utf-8?B?WTJVV1BERFYxSHA4Wi9CVWJ4TEpKVU1mbmRSd3dpNi90NmxXVHM4MmV5bXVG?=
 =?utf-8?B?NmZpdnhmeG9mQUtuemZYUDBtQXZsZkxGa28xcjYwcjB2TVBlMG5sUVJlVm9X?=
 =?utf-8?B?Ukt4QnpaNVg4UWdvTFJIOUVjTHVqSXl4TDN3QzNqR3FuRjVDKzczNXRiMGUz?=
 =?utf-8?B?MnYrcWxJNVprOHFTOGFDT21IcG1WNGU1Y28wWDBxczFCTWQ0bFhtRmNDKzdR?=
 =?utf-8?B?aXhla2U3S0ZGWEprNFNGMyt4K0ZPaTIrcTNrL3NoMFlOUWpWSWxaNWpwdkwr?=
 =?utf-8?B?WC9zQWNiazZIdEhCTHlBYlZuZ0ppRGtJdE92WkZXNCs1MytGNFp5bHdXRG1W?=
 =?utf-8?B?RitrSkhHY2Z6Z0Rid0NRQWpuSGM4eUs5Zlpyd095TnpwWEpLTXA1OFZVMDZ5?=
 =?utf-8?B?MjluMUVjcjA3TkQxLzBxZUwwanN4UW13bWpZaVhsUFprb09KcEVwSXVveWVX?=
 =?utf-8?B?N00wYkEzT0N3L1JuR2RTTVNsQW0yYnR6dlNablpQRzg4V2RXS25HT0ZoalFD?=
 =?utf-8?B?bHlZdHpxVVEveGNiV3c0TDh6UGpmZ1k5MFQreGJFS09JeGcvWEliYmtBU0lN?=
 =?utf-8?B?dlNGYUNjT1lIVkE0V2wycGJna29MdUpSbXlCeWpkcjRyaFZ4VnRYV2ZCSCtO?=
 =?utf-8?Q?zC4VNbiHCNdHd9iGdn5JHXKY73wKws=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9DD56D4EFF769C4F8FF1634F01797BBD@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d7871ae-7a26-47a8-d97c-08da06ce345a
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2022 21:53:13.6495
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XtlCjmP+Q8+xPYdS2Bfo6LzArcKOBQQOa7CBhOwQZXVGThuU94j1IUbjIbvsLnSvAllp1sunONWOvRIKAmO9rM1mFtruHMHXAtZuEyN4dDs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3903
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gVHVlLCAyMDIyLTAzLTE1IGF0IDEzOjQxIC0wNzAwLCBLZWVzIENvb2sgd3JvdGU6DQo+IEhh
dmUgeW91IHZlcmlmaWVkIHRoZXJlJ3Mgbm8gYmluYXJ5IGRpZmZlcmVuY2UgaW4gbWFjaGluZSBj
b2RlDQo+IG91dHB1dD8NCg0KVGhlcmUgYWN0dWFsbHkgd2FzIGEgZGlmZmVyZW50IGluIHRoZSBi
aW5hcmllcy4gSSBpbnZlc3RpZ2F0ZWQgYSBiaXQsDQphbmQgaXQgc2VlbWVkIGF0IGxlYXN0IHBh
cnQgb2YgaXQgd2FzIGR1ZSB0byB0aGUgbGluZSBudW1iZXJzIGNoYW5naW5nDQp0aGUgV0FSTl9P
Tigpcy4gQnV0IG90aGVyd2lzZSwgSSBhc3N1bWVkIHNvbWUgY29tcGlsZXIgb3B0aW1pemF0aW9u
DQptdXN0IGhhdmUgYmVlbiBidW1wZWQuDQo=
