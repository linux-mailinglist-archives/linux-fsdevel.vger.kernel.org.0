Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CAD56EE670
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Apr 2023 19:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234762AbjDYRQN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Apr 2023 13:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234055AbjDYRQM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Apr 2023 13:16:12 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA2FD19AE;
        Tue, 25 Apr 2023 10:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682442970; x=1713978970;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=G67Ci/nQexfvdzec865WTVrdjl3a2Z8A41kpVOKwORU=;
  b=lKxIUpa95ZC+fds5MuwauEvoMNXUYYFY0jgVkN0OpED9pKnf38CJfrWp
   3ImqbIbuI46u+8hCtTFafbu6ZQlFk7zb6RUGRGhWfJCFoJbnfDY57O2X0
   wWUD2EkNCJXMydnvcflaqR45B81uuSYDm8OY8Gkc5y2Q7+vGKMhImFI8f
   +q42XYh5Ayg/Q1fW2GC3HvFaWp7p672tiu03DKUKuf3Gwg/wUPi4AP/X6
   5hnyaUJNaEsvjPypqcFl8cfOBuIWub84K2T103h7AfV1AdYeH7P1IkHgG
   R7iUX9dWpe5baZaKeBySy1P/Qj7ULsM4GyYK0ohrbVU+VDXtzNqPljVF/
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10691"; a="326440854"
X-IronPort-AV: E=Sophos;i="5.99,226,1677571200"; 
   d="scan'208";a="326440854"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2023 10:16:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10691"; a="817778784"
X-IronPort-AV: E=Sophos;i="5.99,226,1677571200"; 
   d="scan'208";a="817778784"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga004.jf.intel.com with ESMTP; 25 Apr 2023 10:16:09 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 25 Apr 2023 10:16:09 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 25 Apr 2023 10:16:09 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 25 Apr 2023 10:16:09 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 25 Apr 2023 10:16:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g2/USZo314stPT6AB0TpsrdRBzDo9hUDgsR//OBx1x8epsSIv+NuCGnfSoU8GryH5+BL1oNVZDBncwQ5fm/++bGk5A6sDX34TWpJ2I6150ChjAwXFbPBeyYiIuaVX/CgZQ0kE3eCn/pG7avRr+I3X8Dbate+Sxi55eprIacmp7khTirxXZX6x8w5UG1r3+/wXlmp/aVXTz5wW0Cv1CJdP/ZAiIxgXehX8fDKhwilehLmzGZ7B/tC6cm44a8JdrYtsxsRGIFw89qpvvjsk07Oo28uyGI4PKLfTQaIL6qZHXN6oWkE5KtUNTv4LHIW7gCjch75pN1RoZNvaAf+UNXwgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G67Ci/nQexfvdzec865WTVrdjl3a2Z8A41kpVOKwORU=;
 b=HFz6WF9jZtd9FosgnISvHycaXiZ/NDVKobvMANYJw2HLw6vIsolQWEQgFtULR3LWZA79cu7upADbB8GZc+mKjSIXwt+L8aynUp95y6ibvTpcmAT16xGhZfonroAFGS5SEXGG6L0RY5hUV0HCQtI6JTB5UQ2wWzOZiWCa/imUQlIvLWRYuee3YUOCrVNAhVtXKlFNEbUIw6ka4O4b1kQUQxAoQbfeCuFI8pca3kxIeIMzIJlJGWmM5D98KdhlTTbqRA1a/QF1bfE2EgHjSxhUhSGKDnS2lvm1dVw/MqS2LvVwvSHrKUWPVTfbfgjG+XaxnmHzpB5s0vHjsrE0W8j3ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by CH3PR11MB8139.namprd11.prod.outlook.com (2603:10b6:610:157::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Tue, 25 Apr
 2023 17:16:07 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::a52e:e620:e80f:302]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::a52e:e620:e80f:302%6]) with mapi id 15.20.6319.022; Tue, 25 Apr 2023
 17:16:07 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>
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
Thread-Index: AQHZdBRFPZDWlOOp3UGtHDT7fo0Pga86CEYAgACeJYCAAKEtAIABAwhQ
Date:   Tue, 25 Apr 2023 17:16:06 +0000
Message-ID: <SJ1PR11MB6083452F5EB3F1812C0D2DFEFC649@SJ1PR11MB6083.namprd11.prod.outlook.com>
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
 <SJ1PR11MB60833E08F3C3028F7463FE19FC679@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <316b5a9e-5d5f-3bcf-57c1-86fafe6681c3@huawei.com>
In-Reply-To: <316b5a9e-5d5f-3bcf-57c1-86fafe6681c3@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|CH3PR11MB8139:EE_
x-ms-office365-filtering-correlation-id: c73714aa-5273-4150-6578-08db45b0c1be
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AJbmf943aazxZOqx7JdtDQIXYK91Y30mA81ARvaPM/QxNcWUEK/6BscL8KCDaig1F4zoXFx/1ijFUII/YpfWKWnelb1H3OWkNA2lHeUJAWcBiZo7UGYY8vWQCUzI1CVkYieOeeIRiAYFDAtT/UAHBJf4umj1LGh3G3KQ/aX983J02FxvFmZtP4/yd6z1hiGpLQWJWBRetIvVzHJZgJHCcoPkyg7n1p64VoLCYeVew2wA1s1LoXWtS9MYjy4h2Rfx7j0FVTSAgMUTwALB4pnTomi+s6NRKXBcphC34gi9JvgI3j1nRerYvA7rv7ws94gXiTwidRi9vAQ61j5PN+tFySjwwTnkjcLwAn0soFafKY79WH+UFZg+mgS1BCRp0fd//0/EN11WuT0bDrf+BIhoHvjHToZ2TQiOi1zsaQI02KpMRcZ3GG/L5zFxfDxeyCHVevtw1Pr0xng+QCq9fLX0Ypj+b24krT6gtzf3PtZzB74Lw2bqneU0pMRBEH4puXZeMe4A53TaSqPA4Yu/sEUBIjnwPAS70J31E5NJvIugrLS7XHteLg98VJ3iBxr+1b96rZuerZnKHiCKlNS49O0DbmC1zEa8RuaEaaLRtozF6Ki6STkWC91FwnbLxTftnRQd
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(346002)(136003)(396003)(39860400002)(451199021)(478600001)(110136005)(54906003)(86362001)(186003)(26005)(9686003)(6506007)(55016003)(33656002)(71200400001)(4326008)(64756008)(66556008)(316002)(82960400001)(66446008)(66476007)(66946007)(83380400001)(76116006)(2906002)(4744005)(38100700002)(8676002)(122000001)(41300700001)(38070700005)(7696005)(5660300002)(8936002)(7416002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OXVCMVZ0cVFwTkRWbmRwWHJrbnBsVStlV1I1NzVHWXpoYU9HMDFieXp5QVhm?=
 =?utf-8?B?Tnh3VmtTa0pLL29TYkwrQjBqYnRwUHk1MU1CZWRtUnVhMHF2M3F1emNzM3dD?=
 =?utf-8?B?RDBVMWk0TjR2ZnJhcUh4NTB6SlcxcW5SVytKbDZrdHdlNTZJMmh5NG56b2tx?=
 =?utf-8?B?dmV1SXV6MERKTzM4NkNtc2hBUWI5TmhNRERsOWF5SEJWb1hUYlJQbTFiZXUr?=
 =?utf-8?B?UWhHQWxhckZMcTRIdXNlYVhFWTJEQ3cxd1kzSUkxdFFLOXF3czVBNm9xclU4?=
 =?utf-8?B?aVpEVmJUdWkzWFFRUW1HSW9jdVBMajBjSnU0T0VBTVB6SjJLRVRBY1dCek03?=
 =?utf-8?B?MkNLMnpFZXArQWxJc1NjTWI4bTIrZjZ4WVV4QUtvZXdJQ3R4WUxqZVozR1hk?=
 =?utf-8?B?ck1vNVVvZ2lzTkE0dk5xREFhaGNLbkhMVHRhNjBFQitPM3JJTXo5enhwakZa?=
 =?utf-8?B?YmpBNUtJVlY5ckFIWklsVTlEall3M3NkSWlnSTQvcXFrNkZHR2FxbmQxL0N2?=
 =?utf-8?B?S3dSNzJmNmh2eHcxMXhIVVFSK0JBaUszYUEyZXhlWXo4SnYxYmw4ZzZvTTdl?=
 =?utf-8?B?dWZvZXNBdWtUbElWOTZxeitucXJmNXlJbnMzNjNCZ0g4V2lScWs5bHI3bWNa?=
 =?utf-8?B?KytTOWJIT29WendJMEJjUjJ3RzkraXBBZU15VjRObDVWRTA5cjlQd1M1WnFD?=
 =?utf-8?B?TDRBaUhRUjFLTHRPWk5JemJnQTVMeTZFdTNNODFWeDJ1TldTYkFaQksrdWFR?=
 =?utf-8?B?cmVqaW0xSFVLSUFzMUdad2Z2eXZCdjR1dzU1ekVPSnFjN1FhU2VqTFVNYTlt?=
 =?utf-8?B?b2ZsREwyckFqaXRSSW92eEtpbkVFWHVLZHd1eXl3cit0TGFSRHhEaW82N0Y2?=
 =?utf-8?B?NE9JYmkyK1hEajl1YzZVcDBGWVFENFlUS2VzQmNaUHpORFlqekY0OENkVG5l?=
 =?utf-8?B?aXlMcmJ6elI3VlAwT0FIZGJBOFB5ZzZ4K2w1cVU3aVIwdUhBUHB6NHQvWmFG?=
 =?utf-8?B?Y0FCWkpnU1FNSElKK2h2L1B6MEZZNW9xOFk4RUJUdkwzZWNNN1FlcGtZdlpP?=
 =?utf-8?B?dkFqcVRyM1REZ01PTUlQVnR3M0FwMVkvL21tNldTa2dwcVRpVlcwV3U3MEtq?=
 =?utf-8?B?QTlUbEtBRlJocVdmTTZkMzF5cE1yN0RKZGxCT0lDNmFMUms1YkhiN1VveVpT?=
 =?utf-8?B?RGlVam5DY3pFdmxqTG0zVkk3WHJ4aFV1SzBLaWh5bTNIWXhkbnAvR2NHUnZX?=
 =?utf-8?B?NkJjTTlnTFZjc1JnQkFDTkx0dmE5R2U4WWtwSWlqNnl0dnkxVE9maEx0VFoy?=
 =?utf-8?B?Lzc3ek9lN1lCczREMzQ4TzJIbHlMcVdLWUd3ZE5KSllVeWMxVE9hWE41L3lJ?=
 =?utf-8?B?TThPaXRqN1BEUE9UMk5SQmZMdlhNRFdPUWZNV2Mwc1lkY1RHODhjbFNub3R4?=
 =?utf-8?B?anNMT1IwZi9tKzg5Q2lLQWNuZFY4N205N3ZuUnNEYkMzZnVmajZKakttOEFI?=
 =?utf-8?B?TjNEVmc4MEh0T2h4ZXlyM3VZTXpQNFpOaHYreVhBSXF3ZE5oZzN2RExraUZD?=
 =?utf-8?B?YzNCdldGclVOU2dDRDlpSmowVzgzZXdJUGNOR1RHaUVHK3JlNHlVTDd4R3VJ?=
 =?utf-8?B?a0U4OFJDU0tQdUkvQlluVThLYmdvbTFycWFiQ0hXMGFsR2dEUWJ2SXpNR0V4?=
 =?utf-8?B?V0ExR3MwdFdqUjlrbmtNR3FBdytyMW9jSDhwVnVCUnpucmNRZFBKbWQ1dWxF?=
 =?utf-8?B?QjRydkswcHJrUS9DR2xZZjJUVGJDbDhtRGw3czRldmRTd0NGeXVMcDRNLzNB?=
 =?utf-8?B?SlFoY0ltUmxJNjltWlg1V2RBd0pzblBMd0RlazRlcEY2NitYSnJKL0lYUFhH?=
 =?utf-8?B?WE00bUc4ZUVML3RRRXMwUW9sYzRlVkZLcW1YeDRFbnFYVnlXUEMzZnFCRmZ6?=
 =?utf-8?B?UXFwZjJ3WFc3dVFHM3JFZkJiT3pZZXBrZk1WdWEwakdWTXVIeStTczA4NmVG?=
 =?utf-8?B?bWJZbnJYQ2g4RmxUTVFENU95Z0F4MllTMHJMTFZKR3pZcDh2ZE43cC95UHo1?=
 =?utf-8?B?dlRhWms3MnJHSkZleGIzc0s4bm0vU01pL2dLMHZGZmJnZU1FTmV5eXdNeUZ2?=
 =?utf-8?Q?pE6w=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c73714aa-5273-4150-6578-08db45b0c1be
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2023 17:16:06.9506
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v5lPRBjlUGfTOgSxm87MxDZ2FaIlCXHcUiu736GDpfuuEf3FtUIAbOZKUZPukjx5f3Tney0bSHOEre+tgLApRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8139
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

PiBUaGFua3MgZm9yIHlvdXIgY29uZmlybSwgYW5kIHdoYXQgeW91ciBvcHRpb24gYWJvdXQgYWRk
DQo+IE1DRV9JTl9LRVJORUxfQ09QWUlOIHRvIEVYX1RZUEVfREVGQVVMVF9NQ0VfU0FGRS9GQVVM
VF9NQ0VfU0FGRSB0eXBlDQo+IHRvIGxldCBkb19tYWNoaW5lX2NoZWNrIGNhbGwgcXVldWVfdGFz
a193b3JrKCZtLCBtc2csIGtpbGxfbWVfbmV2ZXIpLA0KPiB3aGljaCBraWxsIGV2ZXJ5IGNhbGwg
bWVtb3J5X2ZhaWx1cmVfcXVldWUoKSBhZnRlciBtYyBzYWZlIGNvcHkgcmV0dXJuPw0KDQpJIGhh
dmVuJ3QgYmVlbiBmb2xsb3dpbmcgdGhpcyB0aHJlYWQgY2xvc2VseS4gQ2FuIHlvdSBnaXZlIGEg
bGluayB0byB0aGUgZS1tYWlsDQp3aGVyZSB5b3UgcG9zdGVkIGEgcGF0Y2ggdGhhdCBkb2VzIHRo
aXM/IE9yIGp1c3QgcmVwb3N0IHRoYXQgcGF0Y2ggaWYgZWFzaWVyLg0KDQotVG9ueQ0K
