Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34FB46ED248
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Apr 2023 18:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbjDXQRg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Apr 2023 12:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbjDXQRe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Apr 2023 12:17:34 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 598997682;
        Mon, 24 Apr 2023 09:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682353053; x=1713889053;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=A13s2FpHfp3QShzoH+swzwBF2qvfk45AwBHh8DX+6ps=;
  b=FHFbBUa4/Oj3BHcSJJU5sjAgCjEsaQnZeEbJ74szfMHX6OlPsbihERA5
   66gN0duy6jrVwJL5cxUVFV34+n3t14dFYCgK9ts+W12iEPWxIqKrtqB/F
   pbSms/prhJkh1X0YFcrztl/HdSnV2VxKhwKF4qnzah35oFvmJGyjiLAkg
   Jgh1He6vvZLNYK46Q4IKDACm/RgWMlKWg3sGdXHvuCB7GjU3n4gRlpEZl
   uKwhZ6sEhfWfDEPdy3lYaA1WcHreg8kwWg+bDpjxRtmdZHMJGCLxbsHKX
   jObrTV505esWSRzMELEKsvi1sCd+XzMOjLGl4ynVwKKiE606SPTC4iEzj
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="346518984"
X-IronPort-AV: E=Sophos;i="5.99,223,1677571200"; 
   d="scan'208";a="346518984"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2023 09:17:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="867537378"
X-IronPort-AV: E=Sophos;i="5.99,223,1677571200"; 
   d="scan'208";a="867537378"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga005.jf.intel.com with ESMTP; 24 Apr 2023 09:17:31 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 24 Apr 2023 09:17:30 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 24 Apr 2023 09:17:30 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 24 Apr 2023 09:17:30 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 24 Apr 2023 09:17:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VDORoAwPZW9tyycrrf4DaeeUsIOU6t6Qig7f9MOD7LIw0HitN1Ihlc9Z1yy5LPNKeavjmAYfSff3c329oCSNx6H7XtuQKP1J00a9pd+PyZHdmeowEu5OwpfnDQXi5h5vlu1v0k+0Pah6OWNro9mw+7XHCtBh06Q9FH7ONFIaZYxazEX/phyEGadM2LCCbdWlE23FOkgePowr3jv9hXxgOdASb3/4VlYfPYjdOfHx/lsV8OLm2B5s2oXYROwCirPll4fiMHhXiSwGt9szb/D8N7oKXxJ9Ow8VyHuc8jbmY/tAh3Rd5GJrNtn+LDt5yCLULums8cQeyj6n2iAXbzuKFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A13s2FpHfp3QShzoH+swzwBF2qvfk45AwBHh8DX+6ps=;
 b=iJwtFgFeZev1x9iSbEqPz179zrGMF2g3Jbj0JktS4mMpz9A4sLeOXFouUIflfCP16c3q1F84rAoU0K+EFLN5jSS2uHgUdge+jnqoA/sKmRbStf4FthFmDjEkIGWoFfIY+EQFmKHE4jOGMXCiST4PLhmbL/3zLt2yqLN4LHpeO+o3eLfy51ypYQxkrsUnyE2VMxN6G81gMNBuYuMecM7FR0cNxgKr05Iz/dYLzF/uLeZo67QyUEM3pzQXNLgpPq1pKAhVl41UljfkyeQ6GSSIhRaDux6eab2oHTwzjuLTPWyN4ypXYTVl3evCaFFi3bVE+kn5sfFVR3BksDdY2aTm1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by DM6PR11MB4675.namprd11.prod.outlook.com (2603:10b6:5:2ac::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Mon, 24 Apr
 2023 16:17:28 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::a52e:e620:e80f:302]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::a52e:e620:e80f:302%6]) with mapi id 15.20.6319.022; Mon, 24 Apr 2023
 16:17:27 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>, Kefeng Wang <wangkefeng.wang@huawei.com>
CC:     "chu, jane" <jane.chu@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tong Tiangen <tongtiangen@huawei.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: RE: [PATCH v2] mm: hwpoison: coredump: support recovery from
 dump_user_range()
Thread-Topic: [PATCH v2] mm: hwpoison: coredump: support recovery from
 dump_user_range()
Thread-Index: AQHZdBRFPZDWlOOp3UGtHDT7fo0Pga86CEYAgACeJYA=
Date:   Mon, 24 Apr 2023 16:17:27 +0000
Message-ID: <SJ1PR11MB60833E08F3C3028F7463FE19FC679@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20230417045323.11054-1-wangkefeng.wang@huawei.com>
 <20230418031243.GA2845864@hori.linux.bs1.fc.nec.co.jp>
 <54d761bb-1bcc-21a2-6b53-9d797a3c076b@huawei.com>
 <20230419072557.GA2926483@hori.linux.bs1.fc.nec.co.jp>
 <9fa67780-c48f-4675-731b-4e9a25cd29a0@huawei.com>
 <7d0c38a9-ed2a-a221-0c67-4a2f3945d48b@oracle.com>
 <6dc1b117-020e-be9e-7e5e-a349ffb7d00a@huawei.com>
 <9a9876a2-a2fd-40d9-b215-3e6c8207e711@huawei.com>
 <20230421031356.GA3048466@hori.linux.bs1.fc.nec.co.jp>
 <1bd6a635-5a3d-c294-38ce-5c6fcff6494f@huawei.com>
 <20230424064427.GA3267052@hori.linux.bs1.fc.nec.co.jp>
In-Reply-To: <20230424064427.GA3267052@hori.linux.bs1.fc.nec.co.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|DM6PR11MB4675:EE_
x-ms-office365-filtering-correlation-id: c707f6d4-bf00-45e0-768a-08db44df65c9
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 96rZ5/+BTLzx1NrVLRPNyS0ArhaHmyKJwOVA/CcD1aGoEr5HLPf0BiCzVOH9wU0fVLwBZ7Kl9Ry1/c5xe89WxgipHFqLR7YVeEQomQPISZKg9kgmvllc+WIOc3UAx7PiNKOXrZ6EDctRQWIFNMEssxsirIL8O5qZLfYP9Df6fyeuL1sfSFnVcZ+cL2QMgJNy7j5rqbfeA62u4A+rs2OqghkirxVhTMorSo4HdbFqJCyJTeSIkF0NG/sy058MtUWsoyHi28cNFL3g2rjX8hSb4v0GBCI6kwkDyjnZ+92APvifYleCZSGrKfFqYkRebY1/giLJXIqdJI1utvtQTLO+6LnYMYPC9ldEPJvZYUF74Zx0o4NY7YIceOoDZGHlySGDejz7nb3cikuvw8SHv722uThgOUEEDQzoKC6GRPUFFPLQGw1A28rvx57iNYOpKefIswOrqXhkFsiK8FUO/IUnAHqqezWEncIpCTbjT/I7Hc9uhiSnv3pvlKTxbWbxSNt9L19KTvO2xar6CyBc9clbQiVVatWJXMrOtoPQYbHckbbN1WGupBaXniMHcbauJYOLc95Q2KO1pcPNTbaRTxdIPeiZ1dEvM0XhklixUeqb1ivp1YfocXwRvA5aYsUnG6ga
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(346002)(39860400002)(136003)(396003)(451199021)(478600001)(110136005)(54906003)(86362001)(186003)(7696005)(26005)(9686003)(6506007)(55016003)(33656002)(71200400001)(4326008)(64756008)(66446008)(66476007)(66556008)(316002)(82960400001)(83380400001)(66946007)(76116006)(2906002)(4744005)(38100700002)(122000001)(41300700001)(8676002)(8936002)(38070700005)(5660300002)(7416002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SlU3U2JUSkE0Z1QyYjhTeGhxQkt0V2FnRTc4RE53SEhub3ZoTzVyYURDR0Vv?=
 =?utf-8?B?RHpoV3NCZEpRM0lCTXk5WnpFcG1panl0aUd2S25yWlNzNjg1eWJBUDJwdzkz?=
 =?utf-8?B?dlY5SUgvUmQ3TzZkOEVaalIzRVBXdHYyZTFsMGhlVkdlZVBFeThSUjgrOW9o?=
 =?utf-8?B?bWxrVnRBdHJSbE1XZkFJMWpKUjloN3JuR0lPd01BZjlsWENNY0o5cFJkdktJ?=
 =?utf-8?B?NjVJWmZwV2Z0OWxIMktUVVREZ1JwMjI5WkFCd0J6aWtwbFFweUFTbTBFdFFz?=
 =?utf-8?B?TitueU5WYnFNdVI4R043ZXpKd3VYd3VGbUsyZkJyWitCWlYyODN1R2E4SnQw?=
 =?utf-8?B?ZnNIQlJZTXZMbFJCUk9NWjl6Z0g1U3RkQ21qSEYyang1OXlzemhpbUU5SW83?=
 =?utf-8?B?RG41TXQ4cytyS3J6aHVQVnBNeVg3QURrdkVPTk9YSm5tM0tzaStITWkrVkVR?=
 =?utf-8?B?Vy9aVW5nZEFWMU9hTTkwQXE3MEZjV0psb2N0NXJYOEZpUmZiT0JDTUxzTGR3?=
 =?utf-8?B?ZFpqZE9JcDIxSG1wZkZXMWdiV3c3a0Q4S05Za0IvS1pGdmdBTTA1eldFVlFY?=
 =?utf-8?B?TTBsNlZFMFJSNkpscml0QUFsQUtpUjdEVldVcy9BRzMzQlo0WEhRWmV5cTc2?=
 =?utf-8?B?NFg4eW1QMjJuRkliV2poczFaZWVnVlZUaXRTYnl4Y0JWTHZja3FmSlByMUF3?=
 =?utf-8?B?Y2tiOG5yaks4MW55YjIza3lBVXFvMDFVNHg4SG5GYnBaTGFhRG1Nd0NDazc0?=
 =?utf-8?B?UDQvVVhzMmlyTHBKQXcwNUxOcVJyL3hGMCtBcGR1ZEpUd1p4ZXRob0NDV0xF?=
 =?utf-8?B?SklWSGNKdXcxVjF0aWhsNkFEaUcvdGpRWnlXb1d6RWRDd2EzcUwyVUpEZThy?=
 =?utf-8?B?WHlLeS82c3hmKzhic1JWci94bml0OUJEVTVha3hseFFJeWJtVWxYeVZrK1dh?=
 =?utf-8?B?NFNyOTUxK2Z2Qkx5SXRWenZqUVRTN215d1JibkRsOVFXcXFHOW0vV1d2SzFt?=
 =?utf-8?B?bElIcWNPbnc0MkJBc2pNdVZCTmNhMnNjVlZGR0xzL1lFMHpUT0Q5MEw3ZzY4?=
 =?utf-8?B?aEVCamRRUHphTk50YWZWR0poUlh2ZStlMm1SMFllbXl4cG8rbmU4NElTVXdw?=
 =?utf-8?B?aVpKS3JpaHRZbEhXdjNrbFN2NGNJZ2tNcHZuU1ZKVExxMlY3K0ZpNjc3QjRr?=
 =?utf-8?B?OTZHWVB1MS9FWFRKK2l3UGhFcld4dHc5VERpaFhKUnBKUVFrN1ZkdkxVSVB4?=
 =?utf-8?B?MnRqblRzbGNsQ2hNWFZ6b29oT2YvbEtjQy9MVnlHcUE1bWV3eml4bzVMSHZT?=
 =?utf-8?B?NTJES1kxMmk5UHlZck1wd1U2TlVGRkhlL1U1TS93cjMwRGZzbkdhbzM2bmV6?=
 =?utf-8?B?eWNXNkprbzArSlRJalZ0UWpwY2txOTdib1hQTWYxM3J1Yks0RmY1bHhYdHkr?=
 =?utf-8?B?SUU3S2VPMmlRN1lIZ29LTHZkR3pxY0xXUHhPVEI2TWpGNmxKQzErY0VyWHF2?=
 =?utf-8?B?WUd1Q29ab3J5NVVSd0ZMNFhlWUVSSmFGRktHVG1XUmd3akJxUDh6SGppWnAw?=
 =?utf-8?B?NUV0cVJWZ01Zd0RuSTFhNkI5dm1SeXpnK1FBWVd2RWl1NVZYVGlMMzQrRVdB?=
 =?utf-8?B?a1VRcFR6WTlVWlFVd2hLVmt4ck43TkJwU2tDK0hCam9CRW9BRFMvT0xZWXVC?=
 =?utf-8?B?S3VxYzNQcExhRGNMTSt3US9lbUp0WWxwRlk5RDhIVUpGRlNQNkZTb0hBZDV3?=
 =?utf-8?B?TGJnODlTU1hmaGhZRUdKeXN1QnVZcWV1NHRsNUpycTlJRDNoUDEwMDNGcTVh?=
 =?utf-8?B?Mk1HNGJqU0doL2JBQmRGb0dScG5zalNZUkhicXNXUFV4S3oyOS9malpIczV3?=
 =?utf-8?B?bWZxT3NSLzJwZ1J1WGRKdklqaldocDRNdS9NU0x0VDVic1ZUNXRlSWEyZXBR?=
 =?utf-8?B?RE1VY0l6NjVJRkhIbGpXZThHTHAvSDUyNUVDOFRaZ0hPNWRiT3VVYkhkUmx1?=
 =?utf-8?B?U3ZqU2R3cFo4QjZ0MlBwQUovOFc0ZFVNNjhSRUFTV0M1aUZ2ZlRCaUhKam13?=
 =?utf-8?B?aUcyQ1ZDUVdXaC9QdzJBWTlaK25qZXVmNWhoS3cvT3VNbjdHeHBtd1gzWXgw?=
 =?utf-8?Q?juwE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c707f6d4-bf00-45e0-768a-08db44df65c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2023 16:17:27.8549
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NANQbxBpLMFk6Q1p40qjzqJEZ0MhXWfB7rMkrBnbEfEfhHRPk12sQG/m3nZJbLrUgP8LuQ/q+5ocvt0ePvCrWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4675
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

PiA+IFRoaXMgY2hhbmdlIHNlZW1zIHRvIG5vdCByZWxhdGVkIHRvIHdoYXQgeW91IHRyeSB0byBm
aXguDQo+ID4gQ291bGQgdGhpcyBicmVhayBzb21lIG90aGVyIHdvcmtsb2FkcyBsaWtlIGNvcHlp
bmcgZnJvbSB1c2VyIGFkZHJlc3M/DQo+ID4gDQo+IA0KPiBZZXMsIHRoaXMgbW92ZSBNQ0VfSU5f
S0VSTkVMX0NPUFlJTiBzZXQgaW50byBuZXh0IGNhc2UsIGJvdGggQ09QWSBhbmQNCj4gTUNFX1NB
RkUgdHlwZSB3aWxsIHNldCBNQ0VfSU5fS0VSTkVMX0NPUFlJTiwgZm9yIEVYX1RZUEVfQ09QWSwg
d2UgZG9uJ3QNCj4gYnJlYWsgaXQuDQoNClNob3VsZCBMaW51eCBldmVuIHRyeSB0byB0YWtlIGEg
Y29yZSBkdW1wIGZvciBhIFNJR0JVUyBnZW5lcmF0ZWQgYmVjYXVzZQ0KdGhlIGFwcGxpY2F0aW9u
IGFjY2Vzc2VkIGEgcG9pc29uZWQgcGFnZT8NCg0KSXQgZG9lc24ndCBzZWVtIGxpa2UgaXQgd291
bGQgYmUgdXNlZnVsLiBDb3JlIGR1bXBzIGFyZSBmb3IgZGVidWdnaW5nIHMvdw0KcHJvZ3JhbSBl
cnJvcnMgaW4gYXBwbGljYXRpb25zIGFuZCBsaWJyYXJpZXMuIFRoYXQgaXNuJ3QgdGhlIGNhc2Ug
d2hlbiB0aGVyZQ0KaXMgYSBwb2lzb24gY29uc3VtcHRpb24uIFRoZSBhcHBsaWNhdGlvbiBkaWQg
bm90aGluZyB3cm9uZy4NCg0KVGhpcyBwYXRjaCBpcyBzdGlsbCB1c2VmdWwgdGhvdWdoLiBUaGVy
ZSBtYXkgYmUgYW4gdW5kaXNjb3ZlcmVkIHBvaXNvbg0KcGFnZSBpbiB0aGUgYXBwbGljYXRpb24u
IEF2b2lkaW5nIGEga2VybmVsIGNyYXNoIHdoZW4gZHVtcGluZyBjb3JlDQppcyBzdGlsbCBhIGdv
b2QgdGhpbmcuDQoNCi1Ub255DQo=
