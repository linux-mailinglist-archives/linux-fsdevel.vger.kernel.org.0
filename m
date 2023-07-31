Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43730769B8B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jul 2023 17:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233254AbjGaP5a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jul 2023 11:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233061AbjGaP5P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jul 2023 11:57:15 -0400
Received: from mgamail.intel.com (unknown [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F524171F;
        Mon, 31 Jul 2023 08:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690819033; x=1722355033;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=tK7bQD5eUTy/JNI9n7lX6f08A4aMl10FOfRouHBr7QQ=;
  b=nKfVwE0oGZzM4a6PSv2P9/LoqVxcJrB2/W0Keuj0wQxmDjdfWVxrMHiA
   4VZlc7VGKuTfykq2UJtZaQJ/eEbQiqcA6tn4QvZlKoilFtooDtyXpTNiN
   7N9vMjOAANTBbK2pJNjNuQN9dwAbMZeWCyysA+q8b5dStxKR9+rdlky1o
   EH10AXaYs6vQSFWLzVeQ990+eGmvnhtDEmLglZiJbgIxbip8q1MDv6sdG
   6ZhS42RFbA+uRpYEeztCchA6l0jAsAbOrfD7gB94XMKi0fH8bIY7jMfQs
   3XQTVNqmH0+gqq40gjQJbZYsIUdX7iiJli7sPwXAkK6c9FzdZupVwwY1L
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="367955863"
X-IronPort-AV: E=Sophos;i="6.01,244,1684825200"; 
   d="scan'208";a="367955863"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 08:56:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="1059027232"
X-IronPort-AV: E=Sophos;i="6.01,244,1684825200"; 
   d="scan'208";a="1059027232"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga005.fm.intel.com with ESMTP; 31 Jul 2023 08:56:52 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 31 Jul 2023 08:56:52 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 31 Jul 2023 08:56:52 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 31 Jul 2023 08:56:52 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 31 Jul 2023 08:56:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B7WBl2JEcPEZNvyVJhKUVvulYzS+rAf/iPnuP4OWpKHnmCAj9eSlHkoY2n8UKIGV+THwgM5760VXesUWG2yV5G3Gw3S8QZUwplGsckRe2D99xzGKl2OBEnmt4+BE7Ncu/VPB+IbCaWbh19ywCsNjhgHEvV30ByI63vH/xDyO0LwqvGt/+aYAjTf9ODHmzXrxh8UFGFAx/2EGCbL2xbbDvknDlvZ47YknNPfw92RcTBtD262Uv6eOoLO0pLjfG3Y5aNvYSGjWgGyFeO4zf8PaCiy4IKwr7DU4Nt80DLghlVl7qXx4k8Q4b9IOg6spvJSGsmwKj70awBSIAKClFBzA5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tK7bQD5eUTy/JNI9n7lX6f08A4aMl10FOfRouHBr7QQ=;
 b=TLaGYnzerbeyErBh8z7h0aRDIN+PzxZDAxVMlB6MZMgsj1IyDvi/xw0be6tR29bcHfOJ1JiQXrGa7KAtDhO+aigD0TDySPE1jS9zS9XMnoR0yFcjSL9Jzr4XkaZYTFmoHpgxY3xHLCh+MlDpp7lzou8ibCKAl+EauXcXM7KKxm3ytbTLYKZ2ZrlTM02i8b4HaAb/Fr4rycIl1yNMM/6f+bbtchFpLEr6TFvcUwT0isg9wqVFQGFnfiwx+aGrknXhwOgfmpR8xEcYF/H5DVcpbTNcAZr59RWfmJmJieDW40wzfwPuXGvVRt3+m+mJWpukndiNAocf1qfXQvNpiEw/Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by BN9PR11MB5307.namprd11.prod.outlook.com (2603:10b6:408:118::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Mon, 31 Jul
 2023 15:56:50 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::abd2:f781:1433:259]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::abd2:f781:1433:259%3]) with mapi id 15.20.6631.042; Mon, 31 Jul 2023
 15:56:50 +0000
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
Subject: Re: [PATCH v3 21/36] arm64/mm: Implement map_shadow_stack()
Thread-Topic: [PATCH v3 21/36] arm64/mm: Implement map_shadow_stack()
Thread-Index: AQHZw7ZZVWMs6JZuI06/zv64SypFG6/UB86A
Date:   Mon, 31 Jul 2023 15:56:50 +0000
Message-ID: <5461c56cf4896f18bddaa66c3beec7b909fc8fb9.camel@intel.com>
References: <20230731-arm64-gcs-v3-0-cddf9f980d98@kernel.org>
         <20230731-arm64-gcs-v3-21-cddf9f980d98@kernel.org>
In-Reply-To: <20230731-arm64-gcs-v3-21-cddf9f980d98@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|BN9PR11MB5307:EE_
x-ms-office365-filtering-correlation-id: 0ed329f1-58c9-412d-31d7-08db91dec0a0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ysicHXPiDE2MZTrvCCQNK+hWRlavnDQa7JKl7Zka9uXSriMkfxq9zO/m845ZNkHFLtbsjzTtQtlGgu7G52iE5FaPbOOl3in774iDKdMd9OJTWwdzlQBqsSmAXVPtRDBiO4s5bd/S0OHkPMfctUym5dlFKpUWLn8mkLwWT4AAMw41U4TvY9cng8B8tXKj0V8YvgG7wXG92xE7Pxi72JteO69SeqrjKe0tuNA0p+NIEs++3HIGXa+YSuo7X7ef4gDlaYhbbN/KmOZOD9ToW5dVIFRZN4PPYJoN1lI6V+goEJLzXRecKjHzp4g+uBaPGUe22B659wfPGAwUFZwDPIfBLfCvKyW57p4ChtDLJ82ASeD296rDqeE67inJ6JgXR28gfzkYli11cz3VxZ7Hl4h8YekMLg5V/pV9TEYvZjV8PsDZ7/DNi/Q1tzjcLEHSSmgBGai8Jc+NsVoMxQ2zulrCSmRSL9n2MILqKONQXeV779CJ0OSoAYppERoLiyRixxvTvOPXdJoOK9qNVFFHfVPWpPCBpob9CXk1Gf+6ECN9pn19z3rzLzrsPMuqLNygHvfcDukEhfrSQMXJ0yj6oF8VmJ/k+FidxAb5X/s8Da1tmg2vrCqb9ADaqp/kyR9KH0qXuCOZLaUwYBcjGTqOFxFAMgHWSLFbguCNaqY0lmr2atg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(396003)(376002)(346002)(39860400002)(451199021)(5660300002)(2616005)(8936002)(186003)(8676002)(6506007)(7416002)(316002)(26005)(7406005)(478600001)(76116006)(4326008)(66446008)(110136005)(66946007)(66476007)(91956017)(54906003)(66556008)(64756008)(6486002)(71200400001)(6512007)(41300700001)(966005)(86362001)(38070700005)(4744005)(36756003)(2906002)(921005)(82960400001)(38100700002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eXJuRGhjWXZnYS9HUCs2T01PdHhhNDRUcjBrSVlCd3AvNmNDTExDL2F2QkRt?=
 =?utf-8?B?Y2dUVGIxKzYyYnE3Yks4WmxDMUtmR09UZmQzUWJXNllZUTNWMHdMSzhOWmFZ?=
 =?utf-8?B?RUFybnp5VlAwRjY4Zk9PeTlxZmtyVHZ4ZWlwQkZLWmdobWJsUEdOR2lmMU5G?=
 =?utf-8?B?VVF1aTJGaW9yYXF6TUg0ZVQ0Z0VZaEt6MUc3Rm9MdXVGZEN2Q2hZN1k3MndZ?=
 =?utf-8?B?ZlhuRXAwUFdxQzdUOWN2QlY2RTdGdU4yMVppaERIOU5FRlRSMklZd2d5Z3FJ?=
 =?utf-8?B?VWpubnQzc2k1c0xDSWxKTXVmQWVlWCtqazJ5ZTdRVDhHdUxpc3ZNZDZVTUhi?=
 =?utf-8?B?OWMvUnBDd3pvTFBxMGJhbktNQzdubDZZWkx5QWRaL2N2MjRMeTBtTWtHKyt1?=
 =?utf-8?B?cSt4V25Sc1UzQThBVTR4MmFUMHlpZGcrcTdtd0FmS1lGcDd0RTM0UkxmU3ZD?=
 =?utf-8?B?WUU1MjNPUUtubjY4eGFFOEdCMnhYNmNRam9uRHMrSWtsVmRrdUdreUtMdlBD?=
 =?utf-8?B?L2lkT3VWWmNVM0wxWWxWeXRMSlVvUG5xbWpLRFptdzJjWHdLQldkL28yV1dv?=
 =?utf-8?B?MG12cVU1c2FVa3ZNQm1sNWJGKzNpWjRRM1dtM1pMS3BMMUo0SzlCOWkzWkg5?=
 =?utf-8?B?U1JrWGsrY0JtclJrUCttSU1RQUxtVnIycVYyNUphRWFoaFhnVjkrbnU2Qzdw?=
 =?utf-8?B?S3c1U0cxaEVHNXNyZEtYajRHUjJNTXFBWTNyTk15emNMN1Q5M2VnTXBwRUVV?=
 =?utf-8?B?MWpudHFnNkpyUTh4TVNwQy9ZQmZlYkZOMU9Gb1d6cTB6RUdGNEh4cWlkM2FL?=
 =?utf-8?B?RkhTQS8wN2V1YmkzV1Z1aytLVE9hTzdPN0lrb3EyZGNjRlBrZlovN0FidUxH?=
 =?utf-8?B?WkxLaWRIVkdxSDgwMkozd044dEpONTFVZ051bHFwbSsrQlE4S1FhTkdDUlJJ?=
 =?utf-8?B?VmxLZmFMZmYxVzBNcmN4ZVVwcUJQQXltOGZYczE5VVFiMUJOY0VZTVlEMlg1?=
 =?utf-8?B?UXVaekZOTERUY0hIc3d2bFpXaS9HQThObFlscThUZGtHTzBsbFZoWTR2VUZx?=
 =?utf-8?B?cmk3NVp5eTJDQzJibEpYb084UmJaSFNVR0xCRU5lRUhPZTR5SzhKME0xWWkw?=
 =?utf-8?B?YTNkZjFrTlAxS3RVa3g2bEIwVDduNFlrSnhMeVZTenY3bEtORFJlRmF4OExP?=
 =?utf-8?B?akFEOFc1YWF1TThDaXBMWkNtR1Iyc1ZTaVd4a2NWck1YVmR6WU9rajZ4Sk5C?=
 =?utf-8?B?ZDBtRjNyWmF1NEk1ZTlUMlk1WHNhMWFPOFdSYjVFeWE2R1hUZ25NbjVxYW11?=
 =?utf-8?B?Mm9oeXRmQmszaHJJYnVMaGYwaHBvcDk2azNNbTZsZ2JIM2RZcnBZZGJRbnll?=
 =?utf-8?B?bDZTYXdPWnFKeGhPcnA0bCsxY253S3VOUW5nTW41dXQyaFNpcmtRNi9lbWhB?=
 =?utf-8?B?b1dMY1U5bm05dWhBaGQ4ZUdNYTJ0TnJlOFUzb0tUQzRlaUQzcXVMSk9QU3lS?=
 =?utf-8?B?NDFYb2VTTzlrU3RYRkVjcS9nMHFvNjNJamdGaFlUYTlUNnoxVmpwRWRkeGtD?=
 =?utf-8?B?VExoK3ZJSHdrNW8rWXBUcUl0TE5VTjRabkNzZlBLNWVZUFZVcm9pdG4zSHFX?=
 =?utf-8?B?YlVGaXFUc2dUVHVPQldzZWpSQ200M1U3VCttaDlBaXo0S3pxUkI2TjRTZjNM?=
 =?utf-8?B?eDRkRzBkblhpZEFDaGc3cVFtVld1QnNBQkdXRVNKRU1XWUdpTGp3UXd4aDdR?=
 =?utf-8?B?ZnpiQmJyUWRYcm55M3RkcXBSNDRReGZ3VFJEMHQ5NnpiTU8xMUxvREZDL2dz?=
 =?utf-8?B?T2tUeWhHN2ZKUXlxZldYWlA4S3BDQWxCd3pQSVhaVVdGUWVsOUlvazVHL21l?=
 =?utf-8?B?aWJNMlVVRmMzdnJ1V0pWbTNGWUNnUWJTNWxoVjh4QlFSNDV0MUVyLy9LZnlX?=
 =?utf-8?B?Wk5EOGJReXNueFlLbFFYVFNxTnc4Qy9OQXhSZlJ5MFdpdm5jaVlsUjdhdEli?=
 =?utf-8?B?R252b0RVSXpXMDJRK0NYVlkreUxkVEQ0MjlGUzhPYkNwZDBORytQcHZyb0VY?=
 =?utf-8?B?M1VTaVhpV3hzeVhqa0hYK3hsbDJMYUtOR2VLQlNDMFFibTlJNEtSUm12UmVI?=
 =?utf-8?B?Q1hlQVBYaDJQZUNQRXhnZWduLy9xT0lLNjY5MDl0V0JVUmlkSXJ6N1hFaXJ3?=
 =?utf-8?B?Smc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C877C60AE9E7884A8BC034F522377641@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ed329f1-58c9-412d-31d7-08db91dec0a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2023 15:56:50.3297
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5FxCg3PSovEDhq2cJAiAOP5kDhRcfZrjOCqgKMM5t+jmTe+8C8X5IhdJJvMN/Gd7utsKtJMqkCJUrxX+xZ5aE5iHawJvQ9VNyCSvkw3kcaY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5307
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gTW9uLCAyMDIzLTA3LTMxIGF0IDE0OjQzICswMTAwLCBNYXJrIEJyb3duIHdyb3RlOgo+ICtT
WVNDQUxMX0RFRklORTMobWFwX3NoYWRvd19zdGFjaywgdW5zaWduZWQgbG9uZywgYWRkciwgdW5z
aWduZWQKPiBsb25nLCBzaXplLCB1bnNpZ25lZCBpbnQsIGZsYWdzKQo+ICt7Cj4gK8KgwqDCoMKg
wqDCoMKgdW5zaWduZWQgbG9uZyBhbGxvY19zaXplOwo+ICvCoMKgwqDCoMKgwqDCoHVuc2lnbmVk
IGxvbmcgX191c2VyICpjYXBfcHRyOwo+ICvCoMKgwqDCoMKgwqDCoHVuc2lnbmVkIGxvbmcgY2Fw
X3ZhbDsKPiArwqDCoMKgwqDCoMKgwqBpbnQgcmV0Owo+ICsKPiArwqDCoMKgwqDCoMKgwqBpZiAo
IXN5c3RlbV9zdXBwb3J0c19nY3MoKSkKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
cmV0dXJuIC1FT1BOT1RTVVBQOwo+ICsKPiArwqDCoMKgwqDCoMKgwqBpZiAoZmxhZ3MpCj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiAtRUlOVkFMOwoKQW55IHRob3VnaHRz
IG9uIHRoZSBxdWVzdGlvbnMgYXQgdGhlIGVuZCBvZiB0aGlzIG1haWw/CgpodHRwczovL2xvcmUu
a2VybmVsLm9yZy9sa21sLzdhNGM5N2Y2ODM0N2Q0MTg4Mjg2YzU0M2NkY2NhYTEyNTc3Y2RiOWUu
Y2FtZWxAaW50ZWwuY29tLwo=
