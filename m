Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F96D4DD068
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Mar 2022 22:53:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbiCQVyv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Mar 2022 17:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbiCQVyp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Mar 2022 17:54:45 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F827199533;
        Thu, 17 Mar 2022 14:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647554007; x=1679090007;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=o32/pbO/iIW3ywRUL5Ir3djLnqL1nIBOMkscyoxSZHg=;
  b=jIycZqEvhMFzw0mjt1dZio+hFYKdgoaJ0XBIet8IHyaS7vKwwP2Rorip
   wRnvFBh5C29B88YAD0VY4QH+vLQOwQ/vYqwGo3UccRcAIAEOAKPJVBnGa
   5E3UoGY0TXRkg79Zm9XiAlWb8d6B0Q9Hclf0R2oYyH5MvtZU7y1Q4BWDr
   sWvH8GFmttOl8DsP3ey7g04RK+efzjG+QO1nP5vROWPyQLANsqbnzk/eS
   ZY3h/k9zqA/THAo9GBd0CXJ1qQTVRBAYTr/t9h1VXnF3vHFyB5f4QYf8k
   1Ilb4uv24/HGW+bqMg1yfW8MMCejAEnPYCLjQb/7njw0bcJKlVkcZjjDe
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="256938276"
X-IronPort-AV: E=Sophos;i="5.90,190,1643702400"; 
   d="scan'208";a="256938276"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 14:53:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,190,1643702400"; 
   d="scan'208";a="513596617"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by orsmga002.jf.intel.com with ESMTP; 17 Mar 2022 14:53:27 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 17 Mar 2022 14:53:26 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 17 Mar 2022 14:53:26 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Thu, 17 Mar 2022 14:53:26 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Thu, 17 Mar 2022 14:53:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bJcA3LzmxsGLw/+1kWd6pQwVI8DXVxOZOW37XDpfaLwyWyIJ5GqH9RJ+8pkEIXIXcyERS+5jUMB7PYXI50dcAQZJfTBdkjrJh6hLYNRLQoXpssfOm9u26kJdA2HZMGotKuzqNPpsmce7RGK+uh7x1/Ywk7WbO27xpXYG4VH6cwa5UpkPbvOX4RiI8bcQeA8aKluiMuA2JqhCIZSw3mctLbqPb+MNVte5PmoH6qBWoZljPmUPs8bqVYFFHPmv43sGY/pNhbIQkdoEObLfV9wUWgEyyIKyrJ05PjrnfaXUdoz0OxlTM9qqL24lGn/f5goYmSeGEi19tntWo/6gfa2eaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o32/pbO/iIW3ywRUL5Ir3djLnqL1nIBOMkscyoxSZHg=;
 b=ipotRfcPC/ZNH4kuMfPc8dLNKUUZdrRBglLTEvN9nH6ihjYUikg+h7rlbM5vzGE9/tmPJZ4hdK8rH5Bu1lmhpOGui56umvMGUqCpmArGVUO2w2EDMQulkiuPadsYay/ZLVS5SzfG85NS5kUc2zK7ODU9jXASy3I/cCLDQDHBMRElZIrJqFYbovv8aJJOA08r2IZ44ZTeC0fItMQAk4Sk82KrXR3EImkRYQk05YeDxFc8BYch8b36HofbLqWaWf1uzVWWee8aQxhwGAYweFdunuSbM02Ys5zx9NhOBV4jlPcZ02H+m1C8ntLUPETVQYn91qgjOPlMjiBzh5+oBIRiaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by DM6PR11MB4412.namprd11.prod.outlook.com (2603:10b6:5:14e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.15; Thu, 17 Mar
 2022 21:53:23 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::c1ac:4117:326:eff2]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::c1ac:4117:326:eff2%3]) with mapi id 15.20.5081.015; Thu, 17 Mar 2022
 21:53:23 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "keescook@chromium.org" <keescook@chromium.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Brown, Len" <len.brown@intel.com>
Subject: Re: [PATCH v2 3/3] elf: Don't write past end of notes for regset gap
Thread-Topic: [PATCH v2 3/3] elf: Don't write past end of notes for regset gap
Thread-Index: AQHYOjQoPZMsqzGecEqsc5lgZvJrXazEFvCAgAAHgIA=
Date:   Thu, 17 Mar 2022 21:53:23 +0000
Message-ID: <30063d9fdd906f64cf6ccfd8604ed6e6cacf02ea.camel@intel.com>
References: <20220317192013.13655-1-rick.p.edgecombe@intel.com>
         <20220317192013.13655-4-rick.p.edgecombe@intel.com>
         <202203171425.565EB773FD@keescook>
In-Reply-To: <202203171425.565EB773FD@keescook>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bdb8df73-ebae-432a-7c94-08da08608f25
x-ms-traffictypediagnostic: DM6PR11MB4412:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-microsoft-antispam-prvs: <DM6PR11MB441294B5A73F0261831A57E9C9129@DM6PR11MB4412.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tGcbnobNSHG5o0YPZDy5WqJtQkQGFFmIZOSKUlmXes+j8+CKLt0qoZh3v7I2XDcQJu0gilgxybBHA/DqTE9hM//V4q3rGb3cI/px2oCEWsq/ZelF5/YcdwIaW9OwJkV7byJTSvebhxL2yrmu4gHChC+JTF6mf1DiFBOXICSOdBhwcfawo+nIzIP5wcb6jK0K5ypLu11cJMYsk/KIe3nVnnNh2h77FelB2/bdmDqq/unR2xgmbV3m7RkXLb1NUJ2Y7whkzSE0DSp5MoGAOqf0JjEK6Ciixh7e3eM6njadtwlcxVour4F7CbOqPZzRis05T33Go4HryEYk6hLTVM5oBCY+cEGQiy/lddC3jwGKusGDRQaeQ+fVouxELOHSZaMgKQ33CKM90sDLfFhVbh001tANWGipaWlTuiNe6fVNHHkm5+9kSRvA8K2GW+yqTzsfQtT5F35owRLiPY6nSxxKVOJYtxE1tjsHCCk8y3MdA1m3xcpFUNSRwsDuuh3MNrFDLRtpC28n7f/4DWHVBU/LYo5y0mnl9Pig2ASG+ncMKNCmsicIBnoYMuM3r2YMDsL9uggerd87ddRw23vQKFhIhwHscckoS0GZr2y68wpI1CaisMw7VY5/30JhcE9HB3ywxqiZYFOtcizYxzaqk79HzinTExBf/38gEtGd3fCqk2gaUEX74d3NNmSvfuM8d1hXaM01BQut3FnDoCpN9sT7KQ8tNmiIrLLgGLlwvaMo3sY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(76116006)(2906002)(508600001)(64756008)(8676002)(6916009)(6486002)(71200400001)(66556008)(36756003)(4326008)(86362001)(6506007)(66476007)(2616005)(6512007)(66946007)(316002)(66446008)(186003)(26005)(122000001)(38100700002)(82960400001)(38070700005)(8936002)(54906003)(5660300002)(4744005)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aDhlOEhZNXZSckR4WEFwcHd0Yy9yM09jT3lacEd0eGNYOVNOeEVkZ2k1emFB?=
 =?utf-8?B?UUYzZFdjL1RuRWJYeGIreHhpbExLb1B6Um1DMkV3aENEVVN1TVRLeGRHU1ZG?=
 =?utf-8?B?UWZmM1JuTEhUSjhYNDhwQlN6OHlDR2JoNkovQ2hmWit4UGlaK0lVby9QamhX?=
 =?utf-8?B?NldtckREMG5UWW04R01mN1BPM1FyR1JMUWNqOHRMeFhHNmc1eGl4RTVRMU1t?=
 =?utf-8?B?Z1UyWnlta1Fid3I5ZXE5VE43L0p3K3lsRG54WGhmM3M5SEJlMUwxSUhhZEVU?=
 =?utf-8?B?aGtaYXFNOFJuMzdkWTlOUDF5ZUVHTmlBMm02MmVwdTFzQnBqcldnWFk5bzdG?=
 =?utf-8?B?YnpNSWxpS0IweFlFZGdtR1I0TnNDL1NCOW03NFFzVDhoZnBwWTBlWWdMN2t0?=
 =?utf-8?B?YkgrckxUcFB1ZlJZVXlvVVhJUnN2aWxLb3plNnZKYUx6OXNQSFZHa1BvRXlY?=
 =?utf-8?B?dTk2dzVsdmoxYnRPeWVDM25XMWV4NUFMU2g2QWlhSmZUaDlsQndBV2dybjV0?=
 =?utf-8?B?bGFMTGxXNXYyR0hLYVRGZGFoZmFNR1ppaWRVa2owTUh1RXk3Q1QxMTVlTmNw?=
 =?utf-8?B?dVMzUElvdWU3dXdIT2gzOFpMT3JEWEdsUC94TnE2c1A5VWZjU3ZSM1VNZ2hO?=
 =?utf-8?B?SEZQYXNraVZPWFhNMkV1b00veFRaK2x3YTBQTzVqdU1QVmI3UEE0RzRzTVpt?=
 =?utf-8?B?R1lRZkIxTkxNM0Nic053ZVlQZzVjaFRSamhtUmtkVlZ2RTBMcG11STl0TS9i?=
 =?utf-8?B?SXM1S3EzaVhnRTZBS2ZMbk81d2RDWkR0NmQ4Z2Z1WU01VlAweWhib3A4N2FY?=
 =?utf-8?B?QnNTN0gzamRtNXMwWFlkVnJjUzhibFh0UTNFM1QrUm1SVXFFMmRLZGVVaytV?=
 =?utf-8?B?S1RtdVhNOHAxd2h5ZkhjYTQ1cmM0Z2dCODNiMlBTZ3lZMllmbElXS0NadHUw?=
 =?utf-8?B?MUJDODN6V0ltOUgzL29WUHd3UzIyWmdLWloyQlpReVgrbERraEh4cUdaRW0x?=
 =?utf-8?B?Y3FSZ2hWZ25FSml3YVJWYVdDRmJhalRYeTBFdnBFeVdPR3cza1VFSW5mY2Ew?=
 =?utf-8?B?MHhUeDRPcE9ZekdOSnNpOTRJeUxlR0lwVUsxMy9HLzdkVHVQSExtYnJ6VkZI?=
 =?utf-8?B?NkMyRityaXlmSVpVVTlBTzdSdGZUM3prZ2NvUko4TnZlTXUyS1l4cWtZZFUv?=
 =?utf-8?B?YmhUOGdKOVBranE0c0ZmR1piZnZubk9hUFc5ZWJoZGh2eVhzS1MzQk5Oamk5?=
 =?utf-8?B?c1FXVkpnOWliaTd3ZElQbkdwOTFpOWlDdlFucHMwczBHbjFQUk9VcnRlc3RN?=
 =?utf-8?B?d1VhbUw5cGFMYkNEOG9Mb2h3R3NzSnlJVEtaeVV6cWJ3UVduTmpHRHRWeVp1?=
 =?utf-8?B?OE02QjRWTkU5QXZYU3Z6aXhNNmNNVzd4eVhPeHhuaUU2SExRSDhvOW9CSEN0?=
 =?utf-8?B?WXg5QVRKM2tCS3hDc3U4cmRkVlB0SkRYT0tWbnVrTkF4S2txTXZiUGQxbHVk?=
 =?utf-8?B?S01uM2VDdGd2NURnU1BVL2pKUDRsN21tR09jaG9acnA2VElEK1JxTDYrUmdr?=
 =?utf-8?B?K3MwcjQvb3lGNzFFTlZVbGVmTlA4Mk1HeTdNV3NMMFFvT3l0U0Y4eEpDRjVH?=
 =?utf-8?B?ODhkVzl6Z1ZOc09LczY5MXByWjlOc0twUTdkbEVkcjRMbGw0UmxROHBFTjJj?=
 =?utf-8?B?OVVGNklUWGF3MVJ3V0FNMm9kNTAxd3l0ZUJRZWxuMG5BYXNHU2VNdnpVaGRp?=
 =?utf-8?B?UnI3SVBtNkdjdmtBaFIrR3czTFRBTFlFNlB1MlljRGtCTFZRdElnZjJYOE8x?=
 =?utf-8?B?WHJNbDRXeTBYSThtNWU0Rkk3RWIrb0RPTjBQQXhnK3ZzeXo1eGdvd0U0TXZ2?=
 =?utf-8?B?TGc1NkprOENIZWFaZHRCR1RpcDgxWnorS2R3TFhRYTVHK3E3eW1sWnI5WjBW?=
 =?utf-8?B?SHhWcWhsY0dqMWFFTTVXcml2RmdDQVZaTmY5d29ER1ZPZHNvSHUzSGl6QmJU?=
 =?utf-8?Q?RR0IkBWClx6OIvBkj1dv+OPNMlXFoQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D10CE85215610C45B3F0E03D4C5DA98A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdb8df73-ebae-432a-7c94-08da08608f25
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2022 21:53:23.6890
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xPDbA5spJ7ZuX9CPTXQYUKAMY78TLdzni85aJjaLZxMfIt/WTcCMyMB8VvhPJCiKbHqz8CrCFZQn9jxXNBm4bSHrO2k5OirhGCPrxcUxMoc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4412
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gVGh1LCAyMDIyLTAzLTE3IGF0IDE0OjI2IC0wNzAwLCBLZWVzIENvb2sgd3JvdGU6DQo+IFRo
aXMgbG9va3MgZ3JlYXQ7IHRoYW5rIHlvdSBmb3IgdGhlIHR3ZWFrLiA6KQ0KPiANCj4gQWNrZWQt
Ynk6IEtlZXMgQ29vayA8a2Vlc2Nvb2tAY2hyb21pdW0ub3JnPg0KPiANCj4gU2hhbGwgSSB0YWtl
IHRoaXMgc2VwYXJhdGVseSBpbnRvIHRoZSBmb3ItbmV4dC9leGVjdmUgdHJlZSwgb3Igd291bGQN
Cj4geW91DQo+IHJhdGhlciBpcyBzdGF5IGluIHRoaXMgc2VyaWVzPw0KPiANCj4gLUtlZXMNCg0K
R3JlYXQgdGhhbmtzLiBZZWEgdGhhdCB3b3VsZCBwcm9iYWJseSBiZSB0aGUgYmVzdCBJIHRoaW5r
LCB1bmxlc3MNCmFueW9uZSBzcGVha3MgdXAuDQo=
