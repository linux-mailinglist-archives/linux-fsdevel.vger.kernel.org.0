Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B83B666886E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jan 2023 01:31:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbjAMAbQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Jan 2023 19:31:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232442AbjAMAbN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Jan 2023 19:31:13 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E845E09C;
        Thu, 12 Jan 2023 16:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673569865; x=1705105865;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=z4LMc+R76v++skd4E7pD6XjKqYP8TfMVXWgGcM+vD8g=;
  b=RzD3wBZh6AwATU/xgsO6uK+3gRMRd3g8sSd5XcFkozUM9/97eCTc6EER
   XSfLgG+KnQfiDmPSsyKSPtvZAsiLmL/q6qx9NOCKvBGyDur3OBDZpCIuS
   xz0GgkrPA9VlX6dLef5zmTSK88k1FKUnfZPrm5GfK3FOp9+OWoiFCa2x5
   DNhRF0cbu8JxVNVRM1ofGljt+nFzLfMSF1pNMAzx7o1XmtvMjbU+PiQoQ
   5KUM+TFhyWF2Jv6XsucakJvZpkRiRhGWrlE8PdbyaSSLwaUBJoCdKhVPa
   4LdwdQw8rE8JuJlHsdAkcjV5b7zZBPgUjhKl+madxJRhbAp9SM3ndNmcT
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="386216520"
X-IronPort-AV: E=Sophos;i="5.97,212,1669104000"; 
   d="scan'208";a="386216520"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 16:31:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="800418810"
X-IronPort-AV: E=Sophos;i="5.97,212,1669104000"; 
   d="scan'208";a="800418810"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga001.fm.intel.com with ESMTP; 12 Jan 2023 16:31:00 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 12 Jan 2023 16:31:00 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 12 Jan 2023 16:30:59 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 12 Jan 2023 16:30:59 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 12 Jan 2023 16:30:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O2q2qjB9qsIf119Cm39I10JxyIj+K+BlB1AT/RI1+j09IlPn/x/pYJZCVKtyqSNyJS2GlYiLEomlwvWU/BN13ni+XhRlvf/ewi7XLFjLT0fmnxR1Su5lW4PF57jTiV9Su9h3slw8tprA+N1EHRwDTfpwue5mRWSIzv4ICt7SUnUsF8QXB8JbLYgfFGNt5D85awtQiMYsNQtKJAB5pUve1bnnYSLXSsoYl56xi+XyPKqVMdnzex6TDP4xLMWMq48YS5YRDuPeO10qcAdJZfEi2d8I6BBbqDmWuFyEfoQT1HQ+5h7bVC3BzN1O2a7wwMJPQ6Q0fQw63ZA3U8qA7y0bqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z4LMc+R76v++skd4E7pD6XjKqYP8TfMVXWgGcM+vD8g=;
 b=KgJHbQ5L9Z5dplUsteJKJmx0pMiyfRIDkFi7l+9MAWkbk+DgAzZY9EacUC05aEv2yuqSTfUgQtQY5Ed/TZm1qYeL6q9QKU5LLXqNVliYUW2RC1hB5Bl5Fe3jWFgHBnEq8d0JnIXj1iqkOnZBn9/1poOxS1B/IogDLl/6LgZmn4iNHr22Qy2LTgBnoWWvZ4nyQlpPL3OU0IJTFeY6wsNlB9UfcX51h0wK5bMXQR+UsSx+9x4PVtx5SoAo+5298G9RUyVIf7DU3pv9QpuWfMgB9yBMFjjysxpCVYtUGCQMJIeXPYrk4wvEfEjXfQzvnGwMJIkWWWZlqx341HU3IccOUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by BY1PR11MB8008.namprd11.prod.outlook.com (2603:10b6:a03:534::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Fri, 13 Jan
 2023 00:30:55 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::3c14:aeca:37e2:c679]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::3c14:aeca:37e2:c679%6]) with mapi id 15.20.5986.018; Fri, 13 Jan 2023
 00:30:55 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "Torvalds, Linus" <torvalds@linux-foundation.org>,
        Mateusz Guzik <mjguzik@gmail.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        Jan Glauber <jan.glauber@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: RE: lockref scalability on x86-64 vs cpu_relax
Thread-Topic: lockref scalability on x86-64 vs cpu_relax
Thread-Index: AQHZJt7KdH/r0F24HUujNHbVVCTD/K6beewAgAADW1A=
Date:   Fri, 13 Jan 2023 00:30:54 +0000
Message-ID: <SJ1PR11MB6083368BCA43E5B0D2822FD3FCC29@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <CAGudoHHx0Nqg6DE70zAVA75eV-HXfWyhVMWZ-aSeOofkA_=WdA@mail.gmail.com>
 <CAHk-=wjthxgrLEvgZBUwd35e_mk=dCWKMUEURC6YsX5nWom8kQ@mail.gmail.com>
In-Reply-To: <CAHk-=wjthxgrLEvgZBUwd35e_mk=dCWKMUEURC6YsX5nWom8kQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|BY1PR11MB8008:EE_
x-ms-office365-filtering-correlation-id: 1e5d6793-02f7-433e-88a7-08daf4fd6ecc
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ev/XDhwJ0nd4NGPb9eMnlWwZ3PQU9ZA7GxXD1iuvfowsFd5skWJnCjR5iHP0gGAN4i6n+VEGlU9bMNBrqv1j7N6AyMTEDrz2VSjjZDACJz/8qA/5jyp6egB5oow5pmDxEY2fMFk08iYsui9d9u/O4a9t/pO1GV+vaaK4yMJ1oAZX3wjfUXT5JrlCub7/TG9q/W9hWNgLM1qXqRzlSY4BvmzwRMaPE7uCYBKNY9V++MpGsXTPgxyGVk/OGq4yc7B2Fx7xUbJ1N3RtEqGo4qvk2zPmykyz9I++4OfuIr34asA1zWK6BW8ZSUDMkgEDR6u+MUECYZbfpa7KkDyiyTEOaymxp1KsitLG/loWVflR81bzjCDTwIr/Io/x9md1cppwyaWC5+IbXIbu2iv40CAFqc9tqENNnaHGHwBFbGm1dxV0zBSlHK0o4H48cEptCFdkyBEcWJ17BH+fEj2ynuNLxyvsU2bGwkaNg9BXL4fBt34fQ8INFm+U38FgD6bZzCPE1gre1OeSp4IKR9hkXz3964lzSbPesBtkc2zjhuZCn1Nf5a7KkkGmrXXZd5rDzyutXKI3MfupKxa8rD0WbNsu/pra61rjTBf5M7oqjNM8eqTBcuDkBPCn9Nk0I5NO7xBZHoX2bLjHP58C0V1FK+wadpZyUPZJga2m5dZOXkZk+8CuhQgXocLf+fHLmZL6XheyrRBgtlGBc94cdvv5ouJT4Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(136003)(346002)(39860400002)(366004)(376002)(451199015)(7416002)(6506007)(2906002)(122000001)(5660300002)(52536014)(4744005)(4326008)(8936002)(64756008)(8676002)(66446008)(38100700002)(82960400001)(9686003)(478600001)(33656002)(41300700001)(38070700005)(66556008)(66946007)(26005)(76116006)(66476007)(186003)(7696005)(55016003)(86362001)(71200400001)(54906003)(110136005)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q3B2Y2VLcnNFSXdtYitoSU9LZnNNRjV6Z3ZIeS90UEFRTTRjRGcySGd1TXJ4?=
 =?utf-8?B?dzhLRTBZeE5xaldtNXJ4V2lmNllhQWtCaytoK0pNNUNRaThrdENQQ0FKaWd4?=
 =?utf-8?B?NUVEeWlsOUFCT1NSZGZ1QlF1MGowRjVla0swU1VVSlAxcXdBM0J2ZXhaakw5?=
 =?utf-8?B?YmQ2SkhPWEhkZlkxZ3dJWlptU2NkcGo4NnNEdi9yRjRlaXlVckVCVUlDNzFE?=
 =?utf-8?B?WXpYejFVVUIzeXo0TytUZnM4MUlHNUcrbFZsbFpaaUdXU3oyT3VQZktoclpE?=
 =?utf-8?B?b3R0NFJlQStleTkrVHZjS2p3bytOZHJlSnJ3cnM5cEZOb09wQlZjSDlUUjN6?=
 =?utf-8?B?dk9MYmxYQVEvT1d6MTBTeFJPemJEM2hrTXdTbnR0L05NNCtQZ2NZVGluamRU?=
 =?utf-8?B?S09qYld2cDlQaVVmRGtrZXZ4ZmE4V2hzZTUzU1FIc0FGaENsZFY2Slc5RlM0?=
 =?utf-8?B?bzhTczlVSnB3Zno2ZWVIRW5KVkNJTmFNNjRLc3RwY3hqVzRLZ2dqZEI1VkNG?=
 =?utf-8?B?Uk8xUWtaNkNoTU5ndVNkWmlDVXZCVlc0bWdGSWF2U29nN2UyQ2dZaTlkRktK?=
 =?utf-8?B?WUJEdzJ6b3g2R2dVUEpLZVl5bmZERndwdTNXTmh5c1ZuMW4rZHdWR05DK1dH?=
 =?utf-8?B?QnpISXNTMWhuQXZJeDJNZ3lMVjlydmd5ZlFsSzhXdXhBMkRNN09JaGRoYnR3?=
 =?utf-8?B?VTNKZ3RKTjhqVWZOcnJmc0trS0pubzc4aFhXZTNockMvY3UxQVpwZktVWkZq?=
 =?utf-8?B?bCtnOWZkYnoxNVYzaHZOTzkramdDMUdqNjc0TkloY3IvK29pcDYvWUhvcGJw?=
 =?utf-8?B?RXFvb1NjMnJhZDBuU2dNd1MrZ09nV2ZKUGpjcmtWMWx0YjhQZlUxMTVnbEdm?=
 =?utf-8?B?WlhyTWtVdi84SVdmUDRhdngvK0g0WTh0WDNoeHRiWXFsdXhYaGVuQUM3ZGhK?=
 =?utf-8?B?bTg1WHVwKzlSdllDVHphcHJYV2RHU1dnQkxhS3g1SDhVN29KUHltZWx3S21h?=
 =?utf-8?B?WDN1NTMzc09kWnRQRmdRbkR1dFBBdXFCU0JjclpTQzRSQlc4Y2FMMnZTcnBI?=
 =?utf-8?B?ZTZvbU1UbzRJUVEwK2VjeU5aaE9IZVBwRUZBblI3UUIyNUkxb1IwYThDY1JT?=
 =?utf-8?B?b2ljQ3RETjk3NngwYTZvcHp6ZThJWVpJY21xdFBnVHp1aGl5bGY2QUhUNDRy?=
 =?utf-8?B?WDBMQmErQjhsY2ZmZzF2T28rZ1hqb2dTQ2dIU00zN3NIbVZUdVYwNnI0Y1Uw?=
 =?utf-8?B?QWcrUndRWTY4VFpGa3NLNy9wdmN0L092WHVEWDQwb01nVS9RNHU0bjFhZlpN?=
 =?utf-8?B?U1k2b0FrT1U1MCtaazBaU3F6MGFLb0FTSmZ4TTUxSlNIenV4c01rM04ycmk5?=
 =?utf-8?B?TUpJbEJOT2xqUzFFZ2dNMDlmV3dpQVJvdmsyUWVOeWV0eHRpejJCdlJOSkhw?=
 =?utf-8?B?aWYvRjg0SVdmRGg0U2xkYXlPaGdxQngxU0QvdEZkcElkM2R6aE5BZ1ljcW10?=
 =?utf-8?B?bFNWQ3RNeFY0VEdITHNuUVVZZjh4UE9YcjdSbE14Sy9OQ05VbFg2a2tLWXR4?=
 =?utf-8?B?ajhDYjd6K1VBNU93emhmd1hIa2h0NTdyU2NkZGw4dDNjbGJLVHJVVklRdXE2?=
 =?utf-8?B?WUYzSEdzeHUvVExTdktqR0pEWXUvbVE4aXYyNHU3T1dNVElTVHJycWg2ZE8w?=
 =?utf-8?B?NG5Jenh4Z2ZuSFIvSmxHTEhkOGxLNUtKZnB2S0N3OFdsWEQ1Q1dsSktIdkEx?=
 =?utf-8?B?R1hxYUdBSkNBa3FuS0x0T2JPZU9tSmRBT1RuQ2gwM3Z1c0FRa2R4aTNaVFFq?=
 =?utf-8?B?d3c2eXc2Z1F0emcySXdkR2duOG9xbkxyeUlQdUNadmhxdTV6M1YrVUhKWEVv?=
 =?utf-8?B?V2ZWelpyOHBINVBmUjhOYUFxQTAvNG8rd2FCL25nRzF6MzZHTjh2M0xVcStG?=
 =?utf-8?B?K3E2RDMweVYzWUpxZDl4TERpTitqNjZIZDlSNDFPVFpFc0xtbkRxaTJLT2FQ?=
 =?utf-8?B?NHdxdWxuYW1Lb2l1VHlhVFFQU2dsVHBDNVM1cW82cmtzb2JrUE9iK3pDUVJH?=
 =?utf-8?B?QXNUUFY4T25hZGpRaSs0Vy8zTFFyUDh1SzdGOU1ZR3ExKzFVRnBGWVg5OGJO?=
 =?utf-8?Q?ecSGefbhvH9ULLX2tVENBrx8n?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e5d6793-02f7-433e-88a7-08daf4fd6ecc
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2023 00:30:54.8679
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1hiwd5nBdF/12EnOySJcxRf65U8KM87Mmof859iCKHxF5bj9VTZq7HX95lC06GlQ4tomYsGz/+nariX3+HfNJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8008
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

PiBZZWFoLCBpZiBpdCB3YXMgaWE2NC1vbmx5LCBpdCdzIGEgbm9uLWlzc3VlIHRoZXNlIGRheXMu
IEl0J3MgZGVhZCBhbmQNCj4gaW4gcHVyZSBtYWludGVuYW5jZSBtb2RlIGZyb20gYSBrZXJuZWwg
cGVyc3BlY3RpdmUgKGlmIGV2ZW4gdGhhdCkuDQoNClRoZXJlJ3Mgbm90IG11Y2ggInNpbXVsdGFu
ZW91cyIgaW4gdGhlIFNNVCBvbiBpYTY0LiBPbmUgdGhyZWFkIGluIGENCnNwaW4gbG9vcCB3aWxs
IGhvZyB0aGUgY29yZSB1bnRpbCB0aGUgaC93IHN3aXRjaGVzIHRvIHRoZSBvdGhlciB0aHJlYWQg
c29tZQ0KbnVtYmVyIG9mIGN5Y2xlcyAoaHVuZHJlZHMsIHRob3VzYW5kcz8gSSByZWFsbHkgY2Fu
IHJlbWVtYmVyKS4gU28gSQ0Kd2FzIHByZXR0eSBnZW5lcm91cyB3aXRoIGRyb3BwaW5nIGNwdV9y
ZWxheCgpIGludG8gYW55IGtpbmQgb2Ygc3BpbiBsb29wLg0KDQpJcyBpdCB0aW1lIHlldCBmb3I6
DQoNCiQgZ2l0IHJtIC1yIGFyY2gvaWE2NA0KDQotVG9ueQ0K
