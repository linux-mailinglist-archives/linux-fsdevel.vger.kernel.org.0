Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 770944B6337
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Feb 2022 07:01:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232481AbiBOGBr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Feb 2022 01:01:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbiBOGBq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Feb 2022 01:01:46 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B7D1A9E31;
        Mon, 14 Feb 2022 22:01:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L5ZlpQ9OqcFa4n3YNOfmyj8sD89/C9AUY5T9qNQwImOe0tqLLSml4mameeMyrrpiSzr1NTXAD7c8FpU0xwWpnZ4zGTBVLoXQiY2g0xWB0di/ZQOWHkXIQ5C6gd52dRGXD5AAhz/G8x/O/Sh0lsFGD0HzInAKLHGgwQW9qhQb/6SdQVQ6zjUuUWj4VMK2g77A0ojVxBe5ak7CNsn2upHndExUqChd1TMmM9RA1AjDHOirnn9q1J2ykkBB53u/g0FCdM+sNjU08usx0UUE7yoXTVxivzGwIZNI2K0uXGIBvXtD3BRrWgA6XZqS3j90vnlGWybIBUsNkqWsmL4nofI0Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oZwGENqx6LzRDrEPdLU3I2+04Hvd8AVTlOXmW6jC540=;
 b=CH4Q9nvaJ0T9hv7cpTRtGEBYru18tZmAFPUCj7UBnLaikI1O+f4gBQolOvym8wORNCwi+R7GymnwgPFG1Na9dsAn5dgFVtmSXZW2ONQZBL9qeiFjyQFuzhcbf0Wtycnvro8iYp2wzQE77RUqoI5RtDON283CxhR6XI0pLZDI0E8sdiq8dlOw4GgbnJIPZuvrwdEFL692sp4ObMBGW4eQqVq8OqFT5t3S6t4ZE/SMjMWA+FhyPSqb3D8iT2TWEcBgEXIS806qzD+N8cE5AL6Gskyo5kzYEpOYkF9vl5RPWuVhOf4p3aoNGi2Kr4BIG/hoaSuKv59Gp8V75pRUpAikuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oZwGENqx6LzRDrEPdLU3I2+04Hvd8AVTlOXmW6jC540=;
 b=Azzq5/8x77EDCeH7/zXY59UDx8cJouQLP93Tsx3xqbOd09s/0TBVXiK5yxQnfuj8UcQfMBZ+bjrv6NxzbX39ioPA/Zt5CEqzSkUrWdQ1N7Botvx4srv3fmRtI+xk0TreLMXpE4Afmw61Y20oWf+oK9H7K/PghiVWvaEveyy2FJFMiPgaXwTbmGtnTZU1Y9L04ZI6wMV/HcjYQOVYNLNNlLnEXQ9VJe5+2uc6sKJkeLJFueZpTi1ShYpit5VAA/vK0UPyIRPPVlMZKQNQ6iQ2XaEY+mgeStBpg+7nmEo2pNCTsNojUn8M00pIxmQdLsTOoSpNppBG2ADCO6myMMc8Dw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BY5PR12MB4036.namprd12.prod.outlook.com (2603:10b6:a03:210::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Tue, 15 Feb
 2022 06:01:34 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::846c:d3cd:5a30:c35]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::846c:d3cd:5a30:c35%5]) with mapi id 15.20.4975.017; Tue, 15 Feb 2022
 06:01:34 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Zhen Ni <nizhen@uniontech.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>
Subject: Re: [PATCH 0/8] sched: Move a series of sysctls starting with
 sys/kernel/sched_*
Thread-Topic: [PATCH 0/8] sched: Move a series of sysctls starting with
 sys/kernel/sched_*
Thread-Index: AQHYIiwPC8F/Ye1dDk2gCcUNZiYTi6yUHp+A
Date:   Tue, 15 Feb 2022 06:01:34 +0000
Message-ID: <625e6989-dcd9-9dab-8c15-8f15321f10a2@nvidia.com>
References: <20220215052214.5286-1-nizhen@uniontech.com>
In-Reply-To: <20220215052214.5286-1-nizhen@uniontech.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f45ef16e-a844-4e2f-d573-08d9f0489eea
x-ms-traffictypediagnostic: BY5PR12MB4036:EE_
x-microsoft-antispam-prvs: <BY5PR12MB40364BBA285DEFDECBA366A3A3349@BY5PR12MB4036.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oK4QamtNVuVufH898N1o0QNrjgSl2UM4DSUZ7sOHiAoD2Wlhxd3UhRggXKh4cH9MSi1TSY93SSlflwyFCMVW4DWQDoKpMNYjSX7Zst6fGtl6SiKbwQ2Aw6bXXrmAF4U5uCLQZxvj5KhDo9tR8ZjskugCG0dZXnhoxsmkPGal/M18LRQQz1NPSy1pcsdPGZ+7k1K7cD4hbzop6cA53GBkXDUECe23CLfo0Ahl7CZPD2xGGdfiogXNZC90oEOwZz6hXajtjsSJ+EGNXyAyzrRXA2WFCNiaEZ/WAIiYBhZR2Y7Guql8J/Il6Lr+3fTT5+PDW1nDvpwa4yApfijdUNyc3xEogAuf0M+29AL8rKqnzhr4XAQRGjro5MfSTNyH1t/zAZf/7J9M0C0oSIjj7kcYUyyDnrU7GpxNa9/8lTfwG6zjCx5lowLDbkj4/FmHBOwBX2EJfMeZRcFC3/MawjgjqFzap34fDWsogd7MeGZmVz/HyN+Ib48wN/vHgQlzjQXEPPYyKXQnozs2NQxr9GTg5k/FnhntLqH7WSwMsPr9wLChr/eCVAUCLArxy8pxV75zRqJBndsOgfrbSEMsQB7+ky8qDE2v4du0PoMYtwe6GhGvnXhgk/Tv735zYleuwL8PFQpRFD4OZfbrZq6rYrIkjDisQqr4kc9OVopOPKVGJM2/VUt1GLaBDbXw5WPtNPIedVslGafn2XyGaEhCoRj1GHVROj0UhcVniMk/DSMM4CkNpnnUFdWE0mNkXKIGdc6ZBPVNX2utOLDNjg0rEyl/Kw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(36756003)(316002)(8936002)(4326008)(66946007)(66556008)(8676002)(66476007)(64756008)(66446008)(76116006)(558084003)(31686004)(186003)(2616005)(91956017)(38100700002)(38070700005)(86362001)(31696002)(2906002)(5660300002)(6916009)(6506007)(71200400001)(6512007)(54906003)(6486002)(122000001)(53546011)(508600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QUZJMWpqak9RTk9kS05MeWo4UGo2cFVWTGF1UE9tWW9wRStwMW9YZk9Bc2k5?=
 =?utf-8?B?OEhNUmc3NlBTWlZoZHprK1hhbjZOUU0rbkN4WDhHS0ZXVDlRN1dVN1JwSU5L?=
 =?utf-8?B?ZDZoNzh3SGNtQW9hbitVZHRpQzdkS2ppTGpudkdvTE9zWVNDY0lSMGZRbmx6?=
 =?utf-8?B?TGQySmIvV0tUTG0yVVRldVVEcDl5TDhhRFUwQUFhc253YnYzNlRFM1c1TU5x?=
 =?utf-8?B?b3VyQUtvRlRtVjNselFnRVJxaEpSb3c5NmViVldrSG9ZbVJxeDRCN2RGN0ZB?=
 =?utf-8?B?STVoL1Q2TUYzaEd4NndmSkJIakJEdlFXbW03RVVpZTZHWDFPTlUzdXg5eU5E?=
 =?utf-8?B?VytyWTNGWDcyeW5oKzJNc2VmL3cyL0tuMTJpS3pQOW1rR2t4djlSMkJtU2Ni?=
 =?utf-8?B?WXUrcWl3ZXl4MWp2R2JodVo3Nm9kMUhQMXluM3ptL1J3MjZKdGx3L3RyQVpT?=
 =?utf-8?B?bnlMMVhGb20xNmpCeUxGY2IweXhxOFJUeXlxL3pkSmlRY2kvSFhma1VrdjNh?=
 =?utf-8?B?NU5wZXdRVDk3OXFKUVFpK09QdUJvWHErWkUxdlQzb3ZTVnFOODJYb0ZCeDRR?=
 =?utf-8?B?OS9IZVJUVFROeVhvNlJvNFFBY2xUMTVSenVKd1haZmlKWDlJZWpFTnpHWnJn?=
 =?utf-8?B?NERHajVueXAvakJEczdtQXRieEpITGk4MUlDWjljelhYbjRsTmVYUDN5RTFk?=
 =?utf-8?B?RW94RXZXSTY2R2hySUYzOFBGOTlYTGRqRmZPQi8wRERMQkxSOFdUeFdtUWlW?=
 =?utf-8?B?a3FkakRITXNCTW93ZWtLVHZCcWszNkRVUkhISW4zSmUxcStKd0Z3YzdjaFhF?=
 =?utf-8?B?eVpFZzdIRnc1SlpkRWRCMHBsV2V0Y0U1cXA0WWsxVEVLNURMS3loeGRMVGRz?=
 =?utf-8?B?Tk56KzREU2t3bWtKaDdvb29pa3J3UDFsUWdBZlhkTDZvb0Fkd3psYXE2ZlZN?=
 =?utf-8?B?b1NMellOb3pFbHN3U1BqdDRqNjhQcVprbGo2VGtvNEpvQkVCd1VPM3Zma2Ev?=
 =?utf-8?B?ZjhjdE9EYjdiRUdYcDNmOXFUM3VkbThXeHNmRmhLZ2JQT0Y1cy9Rd3htZitl?=
 =?utf-8?B?WUp1aSs1enhyQ1ptNEJBWEVmSXYvcjJnUFJkQ1RPY2kwQTR5RHU4a0hEYTVC?=
 =?utf-8?B?R1hQeGVhcWJiM2l6T3RCTmhXWUhhVndkMXlaWXZXc09MNm8rQjVCVVRJZlNE?=
 =?utf-8?B?Z1BNTjF4TTdDY1h4TVJxQmtwbzIzNEFLUDdJNlFXRS9jc3dHWlpXcHJxdjgx?=
 =?utf-8?B?cERJc2M4RGhHamh2ZllsNCtIZEl5VDIxb1NYcXlUeUltUm9xQUFXNzZ4cFZZ?=
 =?utf-8?B?dTZVSysxN0w5S1hGWU1ENncwRXlUbUlLcWNKTHNzVTRLQXNXOFdlZmVGUlA4?=
 =?utf-8?B?VS9lY2lZMkxnNHRhd0ovZEwyNmVCZGxTSDgyOWZRbTcyeVpJM0o2d3VZazBM?=
 =?utf-8?B?TnRST1VnVVVBaGhEeFZRM1cydW9FQmo2T1ZKdkJLMG1JYWdMUkpsSFZQemRp?=
 =?utf-8?B?VTR5VVBSU2t2ZGV6WkkybFNIYmxmRlRrZkIvdFo2UW9SeUZDN2J2QXdaV3VB?=
 =?utf-8?B?Rk0renNGYTRFZzEzTWkrL21SbWN6ZDlnNDZqNHNvb3BNMXlmQi9QZjMxWGFI?=
 =?utf-8?B?cDlKRnV3ZG9KdjlCT1NFc3dhSWR3VzdOcGpVdmsrYXFKd09mN21ITEFxNGpJ?=
 =?utf-8?B?THF5M2FTWlFXbTVZNFROYkRub1dRNlhHWndvcnRuV2hEbHlwRVJRN0dURnAz?=
 =?utf-8?B?Q004eU9kY1VFWlo0RjJaeDlSa08vempwSzR0T0U2eUUxU0docFR0QTBOREZC?=
 =?utf-8?B?OVhuU0F4eW5LTnNtenN6Ri84NW9sS2pBaEN0NHZiZzIxZ2JnaFJMMkJTekxp?=
 =?utf-8?B?b2kzM0xVUytwVzFzQVJ6Rm5EUDFveG82SFlNR3BoYzB2V1hBSWhxN1A5RHA1?=
 =?utf-8?B?NFFZN1M2UXlYZ0JNcWNudVNKb1p2MkRuRWdyZTBiRDBTYzhqTWg2SkpKS0Nq?=
 =?utf-8?B?RzROZlVkYkVGTzZvQnEvM3N2TXpJdC9DMitHUUw1OHQwd0l2UFM3VStDOHli?=
 =?utf-8?B?Qk1obVovalZiVVJBeWJjaHc1a0hRQThFVm5mRXloRUdTRGJ6YjY3YTFIV1hS?=
 =?utf-8?B?QnFyeDQydHBVRlhkSUpnZUlRbDdmVEw2U2phd0NMdUpxTWRvVzJkc2Z0ZkQ1?=
 =?utf-8?B?VTZRckJvM25RK2FIRjVCWGpVa1hNSTRBWmtrRXpVeDR5T0RzL09zWDVmY3FX?=
 =?utf-8?B?N2llamRUbGE5bTR1QThGcTUzQTJBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <17820D099ADACD47BD26D2A14BEF7905@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f45ef16e-a844-4e2f-d573-08d9f0489eea
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2022 06:01:34.3200
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3QOl52Uy4H3Ijxn1uufAI2oLo5W5ALHAhBsN75IkRphR6qxvViGX9ZPsDwdq2eURIuMPGMtPOr2HgT0EHGqsiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4036
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMi8xNC8yMiAyMToyMiwgWmhlbiBOaSB3cm90ZToNCj4gKioqIEJMVVJCIEhFUkUgKioqDQo+
IA0KDQplbXB0eSBDb3Zlci1sZXR0ZXIgPw0KDQotY2sNCg0KDQo=
