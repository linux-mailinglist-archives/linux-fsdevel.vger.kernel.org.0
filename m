Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5807E6CB6B6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Mar 2023 08:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232287AbjC1GQE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Mar 2023 02:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjC1GQD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Mar 2023 02:16:03 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE042136;
        Mon, 27 Mar 2023 23:16:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WRz2Br7efvc5fPn2XD+0Qz4EphRRi8HchCPoDzKViF2vydRqRAy1Q7IH9QRFkmvo/KePsbGGSEN0R/irNq8dXj4T0NML8XXffkwXemJRk2ocSlMf36nc1hdADa0gu5rMaUYAc0JY7jdt6xNcF47kbMguUnt8/rxOZahTNvzLK47k024yZ/jdqX+VlnP6/r/LFZZJhAN9coDPbE+s0O3TNgJKH6LQGvKrfj1dbCc5JIhNT/LsknF8CzWjvIZNT/Um9FEQD/mcKQ2YjTDffH/cLfU96LFdOWo1g3/MRRZaDOGplF6ovhfEaUOY4yQhBK9L5TVbrf20zHJIKG6x+2mFGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kWQNfoQ8FjtwIzKoOV8LY3StBg1j483A+FxqQPw1CrU=;
 b=Hapdgo7KOviBy87GSjKBEJRApVUADvM0uUAWvEKlAFMNPI0+MH2LuXJsDgSB1gdl3W1ettIKKMnKsBa5Q1lR0Ao4ILL0TdszPJp4np+yQ8P3yYYWqVVppQiSsToflqBAxmse9P8GIC0mTIF0pv4d59MtuL8QbK9sov2QWeakVIn2o2y0pPGrWmB2byXiM6fbu1LiHcn2YKli7xhUuxDD/HfM/1RFqahVO8a0J6XhuLyxfIYmrBe6OOiYSI6dqhdyYZDDAD4pN6v28AQXqIpRN3lQ0yjm8mji39lyKqQOUWkRj3w8+8H4iS/iR7sYw5DHYuvIsIk3K+wChL+p9GJuWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kWQNfoQ8FjtwIzKoOV8LY3StBg1j483A+FxqQPw1CrU=;
 b=TCiW0tARSOJtWYLCOU4FYIjRLNkBiw+ruZyU2oGBt2DyJzPBl99t2coBN+jTlZFlXZJ6Vsr0eabne9P2g7a6dJEmhG8veEYM0s73xkxg1mKzfvnSfNOR59D+elObKujMggeRXn4dOL5SP0xEcodzlixyC98tFY5SBpeWOwemOUY5oSpUjYAFCOwRmoWjVzVexJAAqIV0rI/0nPz9ILSc2ZYuM53J+LEX285IIBOSMSlx6S2WEVWhpIptHP55jPsIsbYeQSxQ8W2TxfJAe1qc74IsEsW9Zr7IaWw5D7rYTfQzCgvhfmaLZtkZtNU3fCLr9mXSlWNoBlzQZeS2+csNqA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BN9PR12MB5242.namprd12.prod.outlook.com (2603:10b6:408:11f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Tue, 28 Mar
 2023 06:15:59 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::9f90:cf3d:d640:a90b]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::9f90:cf3d:d640:a90b%4]) with mapi id 15.20.6222.030; Tue, 28 Mar 2023
 06:15:59 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Eric Biggers <ebiggers@kernel.org>,
        "fsverity@lists.linux.dev" <fsverity@lists.linux.dev>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fsverity: use WARN_ON_ONCE instead of WARN_ON
Thread-Topic: [PATCH] fsverity: use WARN_ON_ONCE instead of WARN_ON
Thread-Index: AQHZYSpeqYRshNqQPEGMCqvmIQelPa8PtzEA
Date:   Tue, 28 Mar 2023 06:15:59 +0000
Message-ID: <962dab64-8010-26b5-a8d9-872fc27dce3e@nvidia.com>
References: <20230328040326.105018-1-ebiggers@kernel.org>
In-Reply-To: <20230328040326.105018-1-ebiggers@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|BN9PR12MB5242:EE_
x-ms-office365-filtering-correlation-id: fed2c44d-6874-4fe5-0d5c-08db2f53e632
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QTQY68yCeXtYXDszPdhg5URymNIuxDKThDl09b2vJ2aWhDkKgaeRgQOWEIDYfopQ3TPehipBX9Lv/UWtO8WF04pQDgkJXb52JgiylA0GhkxS8XeS0ertDrcgSkXZzBndxiUZ28uHnPL1extlTGUCUj4/MV5k8riEY/ZIZv7CT98HGeFKGHOOBd8SkO7f8dyNQ6ahP5Y6TxWKbokZQ26+3FPvE8bKHaWC8twHRPGH2vLtsD2Pbfa9ySehW9jx0Ux6EPt9epSoChldwUtBVHEBWR3jfSf56K9zIkFWYfb4R5AZb040DmfnLOyCcc/IspSzS0RIJw+xmx2F4MHJy4MASc2fVt7e2bSK0HqTZY4JBX7wbv0fd4FQZpdC317n0QEraTDLNANadymmI+XQDl73qJQLa5+R8L/F9Z8QVXYaJgWiuk3M+DWAvD96Yc+UU2beE2qnDanJ2/KHZMgN7lq0lDjYymZuzK6rt0J6zokeUIWjgvUYu21nMcpdW5NMRVOlQ3ezzD3SSYBeWolDhJvZk5r/ePQfADBPXnXM8/PEnfvQZHBD6+wcPChzduJCqJkMcmY+XIpEKX0VaBpp1Y974xZ+wtkZ8giV8jmyFm1ciD5GxTdPXwVVaU0sqpTUS25tXEsik1olTckjWa8XclJrvVZHp0m4J5Xc10Or0Y/9goAz1AjsKIvbnxMqYQm4KNnWxhsugDlMCKDdz4DkRCTK3w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(366004)(396003)(39860400002)(376002)(451199021)(6512007)(6506007)(316002)(6486002)(110136005)(91956017)(186003)(66556008)(66476007)(66446008)(76116006)(8676002)(64756008)(53546011)(66946007)(31686004)(71200400001)(478600001)(41300700001)(5660300002)(4744005)(38070700005)(38100700002)(2906002)(36756003)(122000001)(2616005)(31696002)(86362001)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V05BRjhTUTNVbXNESEdCK0loUkUyTzhMSWRQbGhoSGxzeDJKMVRDa3hCeVFL?=
 =?utf-8?B?L01PbjlKVEdiaXJkdWVESDhKSFlFdDVPajVzL2Myaktrem52aE1ZWWNGeXBq?=
 =?utf-8?B?UTh4ZEREbENLWjZYOGVNRVJuWDJQMFVVZnFnN2NhRWhzdGhSOEw0N3c1a1h4?=
 =?utf-8?B?dkNpQklnZFVqemNkRnZjbTUxbXc0NGY3OHFqT05IZ05TclNCZ2FDcWU3RU5R?=
 =?utf-8?B?ZE9QRVFEa0hlYjBsNFNZZENVN0R5UVRGaVFQSENyNnFubTBmOUZNUFA1QlBW?=
 =?utf-8?B?SWd6QndudDFBSGJzWHI1RVBUWS80bXZieXhxVTBNc1YwMEJiZld5blF0UXk2?=
 =?utf-8?B?TnBpbDgyTHV3UjVaeE9wcjZUcXdsSFhzSVl6cHNnbUtDSWJKYTd2VHNnWS9E?=
 =?utf-8?B?RVZ0NUhmYk5UV3BVV0Y1MlBXemlJTm5xK1BTV2V5ZzdiTWZVbDJrcHhWNVlP?=
 =?utf-8?B?OHc3dnl6bllYcmhlSUpmQlNIa1JKZlNUTnpGVWFFa080emVOcUhZSC9yZGc1?=
 =?utf-8?B?OGFLL3c3QVZBV091VnMxQ0ZlNW1MbUJ2NTc0N2xjemtid0Q1NVdoemNPUWZW?=
 =?utf-8?B?MW1DU3U1c05zcTZybytRR1pHZittNU40ZnNGNThrcTg2d1I2UmNwdVpJLytm?=
 =?utf-8?B?WW9UTUpxd2I3UlhBRXVDN3h6THdRb2ZEbEVTMU53UGVnTWRwcEFYejBacURZ?=
 =?utf-8?B?TFhUZmZlclFkSjlXejFRSERQdHhlWkUwbjdxWlNSZGlya29SN3Q2QzZnaWhp?=
 =?utf-8?B?WW9lVDkyOEJzWUNXZWk0MG1wOFpHKzNnZGNwZlc2Wnhid0F1aG5PK3pIbmhC?=
 =?utf-8?B?QWJhcDl6bzNzdlUyRTdvd0dCalVTZVhBdmcrOTNKZlFLT2NrczdNdXBWMzhl?=
 =?utf-8?B?VEpjK3BLOWZRNCtYYVlMdjIwQ1NEeS9aTU4rVjBPNVk0Q0RYZEYrRlVWSGpL?=
 =?utf-8?B?ZzJEZzNKTC9wTFJ5blV6V2dIM09aaEZGWnBISWFwQ3BpRVhwaUw5VWJhL2Rv?=
 =?utf-8?B?ejNINWt4ZUl0UldVZldqSFRaR0pIYXRnSHliWC9uSGdhcUpyc2JFQ0F2S0Nq?=
 =?utf-8?B?V1Y1QUZITEprWlMraVRycVB3RWVPZm05UVFKYkl6NFMxeUl2a0x5eXFpNnRk?=
 =?utf-8?B?cGZoeDVtbDZZK1RzeUN0bDkrUnNRNTRseXQ0RFg0enhpRTlERTk3bGNmL0M3?=
 =?utf-8?B?QVlldFlacEl3L3JZL2lJWlJyRmgyVkRHQWF6bG05bDFmTkxpT0tUUUU5VlAy?=
 =?utf-8?B?aC8xVUVUQlJVazdXVk0yMjEvRW1BR2hrM2xYTTJlcDRiN09YS0RLNnM1aHpY?=
 =?utf-8?B?eWVPTWpKUmFteW5pVXg4d0JVRzE0TmJrclpDUGl3MXdTRE00Q2dFS0RDb3BS?=
 =?utf-8?B?cVFlbHRLUFRQRk1haXlRR3ZRYlJUZ1NFMk5QaENKZ3MxblFvWjZJWDZOOTBU?=
 =?utf-8?B?Z0hoRUFvekVuKzRaWjJLbVpYNHFTU3ZRNXF0Z3FuWWVrRUVKcnpYYVhjSFVY?=
 =?utf-8?B?bzNmb214SjF1a0xYMG0vUWJtUUJ3NkdWTW5oSDI0QndEV3E1Y05QVVlhSGlo?=
 =?utf-8?B?amYzY211OHc5STdyOThORkZBZ25DOTRZN2N0TWJSU29KRDduOGVWUXR2WXBL?=
 =?utf-8?B?bFV4NEo0NmJrNUhBRFNsdjVRWU1VRlBIR1FHMkJLTmZwK2hKTHBtQVZxSVVI?=
 =?utf-8?B?cGtPYkFpV05WbE15UG95bzNtM3l5VjFNY2ZYcDBzUVVWUFlKU2RhZHVoOHJZ?=
 =?utf-8?B?TVZ3eFpHZXlBb216Tm5UME1qNzdIbEF0Tm5LUU4yREF5dERJWEFOUHVaMWxu?=
 =?utf-8?B?ZnR5dUJzQWxYSlFNVUV6NG1jd2g5UGtmSmxyQXRsRzB1MGJLcjhjcjdSQlg0?=
 =?utf-8?B?REREa1YwaTRqMzk5bWtMbnRxSjViMEZwUm1XUTMydjZKUS9ldlk5TkxmMzAw?=
 =?utf-8?B?OEJteEFnV203eWlqUk5FMzc0dnR4RWhBYWl0cnF6MGNTMVcyU0dmY29nL05i?=
 =?utf-8?B?TitMRnRUaW1reVhFWGFRNEhJdDJWNVJzWG0zWlRHWVhTWlUzVWlxaFhWMzFN?=
 =?utf-8?B?a3pZaStVY3JSR1M4ZVBmYWhTQlFuWVlHWlpJeGtEeTJLKzFHd1Z2bjh5My9C?=
 =?utf-8?B?RDdpaldMYWdBYUZhbU0wYjBFa1o4TUJlZWVpR2UyOWJnenZyWW1seHg1ckpO?=
 =?utf-8?Q?2AtKGz3jRZL2FDrZbZTHKZTR1vZUCAbywblxVLciG9bo?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A369414C02DAD64FA29BE2D37E06C674@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fed2c44d-6874-4fe5-0d5c-08db2f53e632
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2023 06:15:59.3748
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /OJl2AH1+Hzy59bWNHrdcEMyCpPBbU3+GMMwVpIQzX5yTQiNQFg95aRlDQct5UThuuQnc76+mn+NaDFwJ3LLlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5242
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMy8yNy8yMyAyMTowMywgRXJpYyBCaWdnZXJzIHdyb3RlOg0KPiBGcm9tOiBFcmljIEJpZ2dl
cnMgPGViaWdnZXJzQGdvb2dsZS5jb20+DQo+DQo+IEFzIHBlciBMaW51cydzIHN1Z2dlc3Rpb24N
Cj4gKGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvQ0FIay09d2hlZnhSR3lOR3pDekc2QlZlTT01
dm52Z2ItWGhTZUZKVnhKeUF4QUY4WFJBQG1haWwuZ21haWwuY29tKSwNCj4gdXNlIFdBUk5fT05f
T05DRSBpbnN0ZWFkIG9mIFdBUk5fT04uICBUaGlzIGJhcmVseSBhZGRzIGFueSBleHRyYQ0KPiBv
dmVyaGVhZCwgYW5kIGl0IG1ha2VzIGl0IHNvIHRoYXQgaWYgYW55IG9mIHRoZXNlIGV2ZXIgYmVj
b21lcyByZWFjaGFibGUNCj4gKHRoZXkgc2hvdWxkbid0LCBidXQgdGhhdCdzIHRoZSBwb2ludCks
IHRoZSBsb2dzIGNhbid0IGJlIGZsb29kZWQuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IEVyaWMgQmln
Z2VycyA8ZWJpZ2dlcnNAZ29vZ2xlLmNvbT4NCj4gLS0tDQo+DQoNCkxvb2tzIGdvb2QuDQoNClJl
dmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQotY2sNCg0K
DQo=
