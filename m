Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14CA16E06F2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Apr 2023 08:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbjDMG20 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Apr 2023 02:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjDMG2Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Apr 2023 02:28:24 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A004D5FD4;
        Wed, 12 Apr 2023 23:28:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B+cwPBQ62qUJGXHAIlmnimtyHQ3KRqkDlGMV0pb1jdVcbDTrh8o6+gjZNbouBoRT+fALf0Eqa+Ou+5NxRGBGFU1NDClNBGI+a08qUTg39ALwiB8OieYc0swhyAzhLWwFFYTDJgafJnSJadWxKuyxJwixpmisdVNwE3RH6KG+E74QL4Kdc4WuHROJMDfei2agNX/MoqfWCT1OINbi6VuXHHSE6ZNOzpI5dZE6YeRA1R1Tl1e0KauDmuvQ+lLGTbOWhSl/zXi5NvZ9mZj2gsFJlCp7V8G//2NMWZwNFU+YGv3Tr7vdWmdJjw3fBgrPvyukPwfu019bjTxKkmA6jIVzZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UX8ZazFIU+OEQyIY6cIO9TB2lkgSfZTirdJPrhYT2rU=;
 b=Z62hneU6Sp8bYjSqFxv89ces8uP6BTGqF2xh/IYCv68uxpn9lDEKYclY3gM2j+L5x/DkRm7vnPPdJuIHNc9zUDhQ5Hm+Fl4XMQmkDjudI0VfSwLYHUoLwqibqNPt+mfTrBirRdTar/zkjpuzcjsx2ppiJtfsUOWT0bO5bjk8l4TtBR3APucaXtNCufyLv+Y+Gu8JfyHq4CB5Yw7uFh8TOXIytSepl/OGm/bp9SxR0JeHZBSpEnF8EJrY+jI3ataf/ImDssD8gmsN57gZKfcwOu5KwUiPzddMASMkW6iHDI56o4MZOzFhIrqF4yDPbxvM4w4oIdpes8tOy8uekAfJxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UX8ZazFIU+OEQyIY6cIO9TB2lkgSfZTirdJPrhYT2rU=;
 b=WBaxvjUYJRVI5zvXysGSDiH5huHkhm/sWQqvwLUmQJrf4fezkfI5hXmjOsZGUR/tVuWcZeMg2YotY+FOyXhvFeF24q4H1F2R4RsHBqupeBG2kqS67BxDWLmRXZJbm1dOIcjscXoav2wNSAP9ELuVDxAPzrUxTee0dzwONaNl2w7sTbDt3ta4Y76OGkVC607M1qusEK9/BF7XlW0Ft6Ha7bNDXHMiCCbz4rkodXSxXVCqeWQLA1BRJMPpGQmqOHPeDEMd6rtaB5CrrRxzEY9M+A3dbgpGBkF/43tK8aES5K9BtjmLQBsMHcT7DSKTfG5/e9iPaCJ31QD3mMtUeAFCkg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by CH3PR12MB7761.namprd12.prod.outlook.com (2603:10b6:610:14e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Thu, 13 Apr
 2023 06:28:20 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6b01:9498:e881:8fb3]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6b01:9498:e881:8fb3%4]) with mapi id 15.20.6298.030; Thu, 13 Apr 2023
 06:28:20 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Anuj Gupta <anuj20.g@samsung.com>, Jens Axboe <axboe@kernel.dk>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
CC:     "bvanassche@acm.org" <bvanassche@acm.org>,
        "hare@suse.de" <hare@suse.de>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "dlemoal@kernel.org" <dlemoal@kernel.org>,
        "joshi.k@samsung.com" <joshi.k@samsung.com>,
        "nitheshshetty@gmail.com" <nitheshshetty@gmail.com>,
        "gost.dev@samsung.com" <gost.dev@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Vincent Fu <vincent.fu@samsung.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v9 9/9] null_blk: add support for copy offload
Thread-Topic: [PATCH v9 9/9] null_blk: add support for copy offload
Thread-Index: AQHZbE5nst5YOYqA/020poicHbZ9H68oyaoA
Date:   Thu, 13 Apr 2023 06:28:20 +0000
Message-ID: <b8eb491b-ecb6-c559-1340-9984897f2aa4@nvidia.com>
References: <20230411081041.5328-1-anuj20.g@samsung.com>
 <CGME20230411081400epcas5p151186138b36daf361520b08618300502@epcas5p1.samsung.com>
 <20230411081041.5328-10-anuj20.g@samsung.com>
In-Reply-To: <20230411081041.5328-10-anuj20.g@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|CH3PR12MB7761:EE_
x-ms-office365-filtering-correlation-id: da22d29b-b61f-40b7-acb1-08db3be84676
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ixTpiDzlma0BGpv0nfJoO54r3/+qAiZtyRMPM2e31890DOafLV/BsVO6f4W0uGPAgMsp+YGxZrOYXFnQONu5HZUFpJJjD70O0PeX9T0fWdh6w90MVXkQSkYQdsiIDfhEbGInhWovQ9NPL3/fgIKau4LEpJTkDquJxOQqlFP/s3MTpr35yEQBbk+4aXxONDFr+sh/Ey6qpYEb13OK1atOjA0pw206utzLqoqlzEtUbrxcDEM12ZCU6Ai5JTQTPsq8t4XLMATYIzv6JBEk9d1K9hiRNPReUtAPsOXcPtv70zp4C0snZJMvlcnI0c4wlMJjRsp+EmhyMZn4rLDi2IKDpI/0x5lQLS1/gr1H/7tEfR9aStKyX/CuEp1CrgDtIlzrnxlJ9/xlTfldnE0aq3a3WwqCrCrud3g59KKdAJ6B/Vj40V7dz+blcbpu3BbSdQzfn1Yv7tTvVag2O7dDuh0fWCVtv2s1fbIjqPpLO2OkKQJa5B5CChCLhD65iUr1PsXcD6tW+qLVItRRf65Ejh+qnP3zN0rUp2jiOj4nSqk6gKaamF3BAY53rWBg69vVZe878YDv0YAPuccv6NXPLW/dxu5STnLKSv5oIH0h2yBWiif9pbCpSvCgSApcF6r6ORw5cafCbmfJBTZLY0Lmg97zOBuoPlbCNHaWpcz7ZDvkP6P73kNM8uG8e4XcIlz/8iC32OEXMO9AoMvN0ozg3+N7JQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(346002)(39860400002)(376002)(136003)(451199021)(8676002)(186003)(8936002)(38100700002)(6506007)(6512007)(53546011)(478600001)(316002)(31696002)(54906003)(86362001)(921005)(76116006)(66946007)(91956017)(110136005)(6486002)(64756008)(4326008)(66556008)(66476007)(36756003)(66446008)(71200400001)(41300700001)(7416002)(122000001)(2616005)(83380400001)(31686004)(38070700005)(5660300002)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eExaYndSbXZLcU9SeVJTTVZjYmd1WmhlOEZleFFTU1h4VTJKc2FIZkdnVUsy?=
 =?utf-8?B?cHJRTnY3STIrQjFvemMxOTN3RUQ2SElJN2dqbUxuZW9sL0FCTWZvcTdwejRC?=
 =?utf-8?B?ZVhzM3p0ZjlSRmhpcHpvcDNZOW9wZ1JOY3M0dVU4NW1CL2ZNTU5hMVRYbUgy?=
 =?utf-8?B?K0o0MlFZcDhEQmVOZVVoQlIxbHRHM3ZvR3RDbDlWZkR6RG9EVkZDQUJ3eGtL?=
 =?utf-8?B?TlFOVUQxL3VsL2M1bTlreStsaUY0aGJISG9YZzZCTUhMRGxDbUgyZUk3ZHRp?=
 =?utf-8?B?R0VlMlpwVkVSdEhWdlpJTVd1YVJhZDRHcU5CU0dpVi9GVnJUMnRzd3RQcUtK?=
 =?utf-8?B?Rm42S3dmVjg5Z1oxdndXNUZqdjBXcDRLN2pqbzdvQnFnSnhrUE1keHZKdkVh?=
 =?utf-8?B?a1VOOER2WjhzaDZwMkZ3cFhmNUI3c2RWTnY3bXYyT0pyMmFOK05IYUlqZDdy?=
 =?utf-8?B?S1g1UE1SVEtDL3NiSncyaDVrVys5VjU5VkozdC9Kajh3UXg5Yy9NOXhuUWlw?=
 =?utf-8?B?cUlSMm01b3RhZDFvZ3B2RXBPYzVKekRjcFhNcEpLNUFoQ2xKWXlkdEpNTXdC?=
 =?utf-8?B?VmhZU1lDWkYzd0hDeHVSaE1CdTNJczI3REdFN1RLRnNkZ3pnWHZHR3lBWUJ6?=
 =?utf-8?B?OExrSHlhZEZpVzBVTklGUE9lNGVFUTU4azgwOThiM1NBME41TWRRMTBsajQ0?=
 =?utf-8?B?UzZxcW1ncDhuNjkxbmxtVFRMOExUdGp4ZVpKL200WDFaUXBOL1M1c240Ukxt?=
 =?utf-8?B?MHpJVXpCdmJhbC9pSGt2VVlDM3RPaklPdnMwaGhsLzZoMi9aVjFvWXNLNGVV?=
 =?utf-8?B?RTMraUNnQXJncHZUWU0vQ2p1MWoyVDR3OHFoRlFyZzhCTGF6TVNIMmhGeUVp?=
 =?utf-8?B?UFp3L3VHTnBWcThxTVpFRW8vMHZWZTJ5RVU4SU1lQWxnS1Q4TGhQVm94Ym5P?=
 =?utf-8?B?Y0pFd3Nja0srSWVjaWhUaXlVMUViZVd2Vm9hMVY1UW5IVzlhVmtHdEJEK2hk?=
 =?utf-8?B?VGlYcG5PajVEcytOWkZVRWM1dmt4TitHYm0rdUp3SEZsWjRmbDREeXRCUFpm?=
 =?utf-8?B?OCtCYjFiVFcrWlhFWDdTMDFOSktvanZTNW1ZUlViRXRBUytPUEJ6dW1FbHpp?=
 =?utf-8?B?L0xMSWdRNGQ1MVdmMFE2WEg5WGhEbk5UVHNGVXZFU1pwdG94bFJWa1BtaStv?=
 =?utf-8?B?UWUxM1RHSnpCeVpWSWNrbHJEVmhxSzd5WStDdXZvM0VXc1VwUGlBMk1iNlVD?=
 =?utf-8?B?UVk1UHBhT2ttcFhQKzh6RjNKTWJxRWppSkpDU2I2WEN2Zm5yTGYxUGlUd3hk?=
 =?utf-8?B?ZkhJV3VYdWJhV2NJRnVPbTVTWkU4ZmhLMDlJNFlSc3Fwa2tpUHlWR0NtVlpB?=
 =?utf-8?B?c3Z2ZGJTV1dyc3k2TkJicENncEhBaWxEMFpjVU10UHNjVjc5ZVIyTC9xQ1NJ?=
 =?utf-8?B?Nzdna1NHRkcvVWdxVW1kSVcyaDVCSFNFNm5Cd1MwRGFqVU1VZ1pYaUQ1NEFo?=
 =?utf-8?B?MkNlZjNuWXpjU0FsTytrNi91TE9wWHN2NFgvNVMrREIzdjcwVWN4YkwvbjNG?=
 =?utf-8?B?bUF1RlZqTWVQYXVzY2QxSVN4dnVURDhuSGl6L3pnaFNOc3k4YS9WSkNkOXZV?=
 =?utf-8?B?ZUdib2JkM0xON2hQTnF1VXN4bC9XV2Z1WVdnejhYY2FmYk1RSlhpL25WSkVY?=
 =?utf-8?B?WlB0RFRhR3VYa1Y1WlRtMzFXb2JOWHh2ckh3MzRHdG1hL2xYbnZlOElLTWw5?=
 =?utf-8?B?bmRoVnBOeHZWMEh1ekdoT09qb3dTRUdOWGJkUmUybXptUyszQzJtb3hoamdi?=
 =?utf-8?B?NldvcW5rK2ozaFlXN0xWSlQvNDBwbEtkWk1tS1JMNVJlL0paWFJxcWZDRGtp?=
 =?utf-8?B?ajNLbUlEOXF6SXptVmZhNHFCUHhnQTVtL3h0Yk9FeEM4Z28vZWM2VG54UmRm?=
 =?utf-8?B?Z2FJOHExdG80c3o3czdUd1hTdG1GNndEWk9sNU1xQ3FhSmo0Q0xaM1pVQ2Fr?=
 =?utf-8?B?UlJhN3I4WXIyTzJwc1RTalkxN0pMak12anc1a2pUbWpmOUVjZzdnQURHTHFD?=
 =?utf-8?B?cWg5ajBHeEdmSTJaYklHWWZ4aDF5YlNRQmRZbmdpYUR4NXorYmJIWVNZSlhi?=
 =?utf-8?B?bEVrM2lxZFFSUW8yMkN6cWZ5ajJLSSsyUVVFdnVqYXFXT1ZUd0FXaDVBYUlv?=
 =?utf-8?Q?g924MqpcBdB8tEgDseTgGVkmVIqCw/uhcLuFDmM+WvK1?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <92C70530638E9A4CBFBC230DEA5AF1D5@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da22d29b-b61f-40b7-acb1-08db3be84676
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2023 06:28:20.3580
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iDTHKweywMDxgXELI23sGRCfPWYzHd3An4QwIAU1HZ3qIUTjtZ+qPLAdBQy82XZla/vQzN+FTCQwxd97842ZHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7761
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gNC8xMS8yMyAwMToxMCwgQW51aiBHdXB0YSB3cm90ZToNCj4gRnJvbTogTml0ZXNoIFNoZXR0
eSA8bmouc2hldHR5QHNhbXN1bmcuY29tPg0KPg0KPiBJbXBsZW1lbnRhaW9uIGlzIGJhc2VkIG9u
IGV4aXN0aW5nIHJlYWQgYW5kIHdyaXRlIGluZnJhc3RydWN0dXJlLg0KPiBjb3B5X21heF9ieXRl
czogQSBuZXcgY29uZmlnZnMgYW5kIG1vZHVsZSBwYXJhbWV0ZXIgaXMgaW50cm9kdWNlZCwgd2hp
Y2gNCj4gY2FuIGJlIHVzZWQgdG8gc2V0IGhhcmR3YXJlL2RyaXZlciBzdXBwb3J0ZWQgbWF4aW11
bSBjb3B5IGxpbWl0Lg0KPg0KPiBTdWdnZXN0ZWQtYnk6IERhbWllbiBMZSBNb2FsIDxkYW1pZW4u
bGVtb2FsQG9wZW5zb3VyY2Uud2RjLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogQW51aiBHdXB0YSA8
YW51ajIwLmdAc2Ftc3VuZy5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IE5pdGVzaCBTaGV0dHkgPG5q
LnNoZXR0eUBzYW1zdW5nLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogVmluY2VudCBGdSA8dmluY2Vu
dC5mdUBzYW1zdW5nLmNvbT4NCj4gLS0tDQo+ICAgZHJpdmVycy9ibG9jay9udWxsX2Jsay9tYWlu
LmMgICAgIHwgMTAxICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiAgIGRyaXZlcnMv
YmxvY2svbnVsbF9ibGsvbnVsbF9ibGsuaCB8ICAgOCArKysNCj4gICAyIGZpbGVzIGNoYW5nZWQs
IDEwOSBpbnNlcnRpb25zKCspDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Jsb2NrL251bGxf
YmxrL21haW4uYyBiL2RyaXZlcnMvYmxvY2svbnVsbF9ibGsvbWFpbi5jDQo+IGluZGV4IGJjMmM1
ODcyNGRmMy4uZTI3M2UxOGFjZTc0IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2Jsb2NrL251bGxf
YmxrL21haW4uYw0KPiArKysgYi9kcml2ZXJzL2Jsb2NrL251bGxfYmxrL21haW4uYw0KPiBAQCAt
MTU3LDYgKzE1NywxMCBAQCBzdGF0aWMgaW50IGdfbWF4X3NlY3RvcnM7DQo+ICAgbW9kdWxlX3Bh
cmFtX25hbWVkKG1heF9zZWN0b3JzLCBnX21heF9zZWN0b3JzLCBpbnQsIDA0NDQpOw0KPiAgIE1P
RFVMRV9QQVJNX0RFU0MobWF4X3NlY3RvcnMsICJNYXhpbXVtIHNpemUgb2YgYSBjb21tYW5kIChp
biA1MTJCIHNlY3RvcnMpIik7DQo+ICAgDQo+ICtzdGF0aWMgaW50IGdfY29weV9tYXhfYnl0ZXMg
PSBDT1BZX01BWF9CWVRFUzsNCg0KaG93IGFib3V0IGZvbGxvd2luZyA/IG1hdGNoZXMgbnVsbGJf
ZGV2aWNlLT5jb3B5X21heF9ieXRlcyB0eXBlIC4uDQoNCi1zdGF0aWMgaW50IGdfY29weV9tYXhf
Ynl0ZXMgPSBDT1BZX01BWF9CWVRFUzsNCi1tb2R1bGVfcGFyYW1fbmFtZWQoY29weV9tYXhfYnl0
ZXMsIGdfY29weV9tYXhfYnl0ZXMsIGludCwgMDQ0NCk7DQorc3RhdGljIHVuc2lnbmVkIGxvbmcg
Z19jb3B5X21heF9ieXRlcyA9IENPUFlfTUFYX0JZVEVTOw0KK21vZHVsZV9wYXJhbV9uYW1lZChj
b3B5X21heF9ieXRlcywgZ19jb3B5X21heF9ieXRlcywgdWxvbmcsIDA0NDQpOw0KDQpbLi4uXQ0K
DQo+IEBAIC02MzEsNiArNjM3LDcgQEAgc3RhdGljIHNzaXplX3QgbWVtYl9ncm91cF9mZWF0dXJl
c19zaG93KHN0cnVjdCBjb25maWdfaXRlbSAqaXRlbSwgY2hhciAqcGFnZSkNCj4gICAJCQkiYmFk
YmxvY2tzLGJsb2NraW5nLGJsb2Nrc2l6ZSxjYWNoZV9zaXplLCINCj4gICAJCQkiY29tcGxldGlv
bl9uc2VjLGRpc2NhcmQsaG9tZV9ub2RlLGh3X3F1ZXVlX2RlcHRoLCINCj4gICAJCQkiaXJxbW9k
ZSxtYXhfc2VjdG9ycyxtYnBzLG1lbW9yeV9iYWNrZWQsbm9fc2NoZWQsIg0KPiArCQkJImNvcHlf
bWF4X2J5dGVzLCINCj4gICAJCQkicG9sbF9xdWV1ZXMscG93ZXIscXVldWVfbW9kZSxzaGFyZWRf
dGFnX2JpdG1hcCxzaXplLCINCj4gICAJCQkic3VibWl0X3F1ZXVlcyx1c2VfcGVyX25vZGVfaGN0
eCx2aXJ0X2JvdW5kYXJ5LHpvbmVkLCINCj4gICAJCQkiem9uZV9jYXBhY2l0eSx6b25lX21heF9h
Y3RpdmUsem9uZV9tYXhfb3BlbiwiDQoNCndoeSBub3QgPw0KDQpAQCAtNjM3LDExICs2MzcsMTIg
QEAgc3RhdGljIHNzaXplX3QgbWVtYl9ncm91cF9mZWF0dXJlc19zaG93KHN0cnVjdCBjb25maWdf
aXRlbSAqaXRlbSwgY2hhciAqcGFnZSkNCiAgICAgICAgICAgICAgICAgICAgICAgICAiYmFkYmxv
Y2tzLGJsb2NraW5nLGJsb2Nrc2l6ZSxjYWNoZV9zaXplLCINCiAgICAgICAgICAgICAgICAgICAg
ICAgICAiY29tcGxldGlvbl9uc2VjLGRpc2NhcmQsaG9tZV9ub2RlLGh3X3F1ZXVlX2RlcHRoLCIN
CiAgICAgICAgICAgICAgICAgICAgICAgICAiaXJxbW9kZSxtYXhfc2VjdG9ycyxtYnBzLG1lbW9y
eV9iYWNrZWQsbm9fc2NoZWQsIg0KLSAgICAgICAgICAgICAgICAgICAgICAgImNvcHlfbWF4X2J5
dGVzLCINCiAgICAgICAgICAgICAgICAgICAgICAgICAicG9sbF9xdWV1ZXMscG93ZXIscXVldWVf
bW9kZSxzaGFyZWRfdGFnX2JpdG1hcCxzaXplLCINCiAgICAgICAgICAgICAgICAgICAgICAgICAi
c3VibWl0X3F1ZXVlcyx1c2VfcGVyX25vZGVfaGN0eCx2aXJ0X2JvdW5kYXJ5LHpvbmVkLCINCiAg
ICAgICAgICAgICAgICAgICAgICAgICAiem9uZV9jYXBhY2l0eSx6b25lX21heF9hY3RpdmUsem9u
ZV9tYXhfb3BlbiwiDQotICAgICAgICAgICAgICAgICAgICAgICAiem9uZV9ucl9jb252LHpvbmVf
b2ZmbGluZSx6b25lX3JlYWRvbmx5LHpvbmVfc2l6ZVxuIik7DQorICAgICAgICAgICAgICAgICAg
ICAgICAiem9uZV9ucl9jb252LHpvbmVfb2ZmbGluZSx6b25lX3JlYWRvbmx5LHpvbmVfc2l6ZSIN
CisgICAgICAgICAgICAgICAgICAgICAgICJjb3B5X21heF9ieXRlc1xuIik7DQogIH0NCiAgDQpb
Li4uXQ0KICANCitzdGF0aWMgaW5saW5lIGludCBudWxsYl9zZXR1cF9jb3B5X3JlYWQoc3RydWN0
IG51bGxiICpudWxsYiwNCisJCXN0cnVjdCBiaW8gKmJpbykNCit7DQorCXN0cnVjdCBudWxsYl9j
b3B5X3Rva2VuICp0b2tlbiA9IGJ2ZWNfa21hcF9sb2NhbCgmYmlvLT5iaV9pb192ZWNbMF0pOw0K
Kw0KKwltZW1jcHkodG9rZW4tPnN1YnN5cywgIm51bGxiIiwgNSk7DQoNCmRvIHlvdSByZWFsbHkg
bmVlZCB0byB1c2UgbWVtY3B5IGhlcmUgPyBjYW4gdG9rZW4tPnN1YnN5cyBiZSBhIHBvaW50ZXIN
CmFuZCB1c2Ugd2l0aCBhc3NpZ25tZW50IHRva2VuLT5zdWJzeXMgPSBudWxsYiA/DQoNCisJdG9r
ZW4tPnNlY3Rvcl9pbiA9IGJpby0+YmlfaXRlci5iaV9zZWN0b3I7DQorCXRva2VuLT5udWxsYiA9
IG51bGxiOw0KKwl0b2tlbi0+c2VjdG9ycyA9IGJpby0+YmlfaXRlci5iaV9zaXplID4+IFNFQ1RP
Ul9TSElGVDsNCisNCisJcmV0dXJuIDA7DQorfQ0KKw0KDQpubyBwb2ludCBpbiByZXR1cm4gMCAs
IHVzZSBsb2NhbCBib29sIGZvciBmdWEgaW5zdGVhZCBvZiByZXBlYXRpbmcNCmV4cHJlc3Npb24g
YW5kIG5vIG5lZWQgdG8gZm9sZCBsaW5lIGZvciBudWxsYl9zZXR1cF9jb3B5X3JlYWQoKQ0KbWFr
ZXMgaXMgZWFzeSB0byByZWFkIGFuZCByZW1vdmVzIGV4dHJhIGxpbmVzIGFuZCBpbmRlbnRhdGlv
biBzZWUgYmVsb3cgOi0NCg0KLXN0YXRpYyBpbmxpbmUgaW50IG51bGxiX3NldHVwX2NvcHlfcmVh
ZChzdHJ1Y3QgbnVsbGIgKm51bGxiLA0KLSAgICAgICAgICAgICAgIHN0cnVjdCBiaW8gKmJpbykN
CitzdGF0aWMgaW5saW5lIHZvaWQgbnVsbGJfc2V0dXBfY29weV9yZWFkKHN0cnVjdCBudWxsYiAq
bnVsbGIsIHN0cnVjdCBiaW8gKmJpbykNCiAgew0KICAgICAgICAgc3RydWN0IG51bGxiX2NvcHlf
dG9rZW4gKnRva2VuID0gYnZlY19rbWFwX2xvY2FsKCZiaW8tPmJpX2lvX3ZlY1swXSk7DQogIA0K
LSAgICAgICBtZW1jcHkodG9rZW4tPnN1YnN5cywgIm51bGxiIiwgNSk7DQorICAgICAgIHRva2Vu
LT5zdWJzeXMgPSAibnVsbGI7DQogICAgICAgICB0b2tlbi0+c2VjdG9yX2luID0gYmlvLT5iaV9p
dGVyLmJpX3NlY3RvcjsNCiAgICAgICAgIHRva2VuLT5udWxsYiA9IG51bGxiOw0KICAgICAgICAg
dG9rZW4tPnNlY3RvcnMgPSBiaW8tPmJpX2l0ZXIuYmlfc2l6ZSA+PiBTRUNUT1JfU0hJRlQ7DQot
DQotICAgICAgIHJldHVybiAwOw0KICB9DQogIA0KICBzdGF0aWMgaW5saW5lIGludCBudWxsYl9z
ZXR1cF9jb3B5X3dyaXRlKHN0cnVjdCBudWxsYiAqbnVsbGIsDQpAQCAtMTMzNCwyMCArMTMzMSwy
MSBAQCBzdGF0aWMgaW50IG51bGxfaGFuZGxlX3JxKHN0cnVjdCBudWxsYl9jbWQgKmNtZCkNCiAg
ICAgICAgIHNlY3Rvcl90IHNlY3RvciA9IGJsa19ycV9wb3MocnEpOw0KICAgICAgICAgc3RydWN0
IHJlcV9pdGVyYXRvciBpdGVyOw0KICAgICAgICAgc3RydWN0IGJpb192ZWMgYnZlYzsNCisgICAg
ICAgYm9vbCBmdWEgPSBycS0+Y21kX2ZsYWdzICYgUkVRX0ZVQTsNCiAgDQogICAgICAgICBpZiAo
cnEtPmNtZF9mbGFncyAmIFJFUV9DT1BZKSB7DQogICAgICAgICAgICAgICAgIGlmIChvcF9pc193
cml0ZShyZXFfb3AocnEpKSkNCi0gICAgICAgICAgICAgICAgICAgICAgIHJldHVybiBudWxsYl9z
ZXR1cF9jb3B5X3dyaXRlKG51bGxiLCBycS0+YmlvLA0KLSAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgcnEtPmNtZF9mbGFncyAmIFJFUV9GVUEpOw0KLSAgICAg
ICAgICAgICAgIHJldHVybiBudWxsYl9zZXR1cF9jb3B5X3JlYWQobnVsbGIsIHJxLT5iaW8pOw0K
KyAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIG51bGxiX3NldHVwX2NvcHlfd3JpdGUobnVs
bGIsIHJxLT5iaW8sIGZ1YSk7DQorDQorICAgICAgICAgICAgICAgbnVsbGJfc2V0dXBfY29weV9y
ZWFkKG51bGxiLCBycS0+YmlvKTsNCisgICAgICAgICAgICAgICByZXR1cm4gMDsNCiAgICAgICAg
IH0NCiAgDQogICAgICAgICBzcGluX2xvY2tfaXJxKCZudWxsYi0+bG9jayk7DQogICAgICAgICBy
cV9mb3JfZWFjaF9zZWdtZW50KGJ2ZWMsIHJxLCBpdGVyKSB7DQogICAgICAgICAgICAgICAgIGxl
biA9IGJ2ZWMuYnZfbGVuOw0KICAgICAgICAgICAgICAgICBlcnIgPSBudWxsX3RyYW5zZmVyKG51
bGxiLCBidmVjLmJ2X3BhZ2UsIGxlbiwgYnZlYy5idl9vZmZzZXQsDQotICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgb3BfaXNfd3JpdGUocmVxX29wKHJxKSksIHNlY3RvciwNCi0g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBycS0+Y21kX2ZsYWdzICYgUkVRX0ZV
QSk7DQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgb3BfaXNfd3JpdGUocmVx
X29wKHJxKSksIHNlY3RvciwgZnVhKTsNCiAgICAgICAgICAgICAgICAgaWYgKGVycikgew0KICAg
ICAgICAgICAgICAgICAgICAgICAgIHNwaW5fdW5sb2NrX2lycSgmbnVsbGItPmxvY2spOw0KICAg
ICAgICAgICAgICAgICAgICAgICAgIHJldHVybiBlcnI7DQpAQCAtMTM2OCwxMiArMTM2NiwxMyBA
QCBzdGF0aWMgaW50IG51bGxfaGFuZGxlX2JpbyhzdHJ1Y3QgbnVsbGJfY21kICpjbWQpDQogICAg
ICAgICBzZWN0b3JfdCBzZWN0b3IgPSBiaW8tPmJpX2l0ZXIuYmlfc2VjdG9yOw0KICAgICAgICAg
c3RydWN0IGJpb192ZWMgYnZlYzsNCiAgICAgICAgIHN0cnVjdCBidmVjX2l0ZXIgaXRlcjsNCisg
ICAgICAgYm9vbCBmdWEgPSBiaW8tPmJpX29wZiAmIFJFUV9GVUENCiAgDQogICAgICAgICBpZiAo
YmlvLT5iaV9vcGYgJiBSRVFfQ09QWSkgew0KICAgICAgICAgICAgICAgICBpZiAob3BfaXNfd3Jp
dGUoYmlvX29wKGJpbykpKQ0KLSAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIG51bGxiX3Nl
dHVwX2NvcHlfd3JpdGUobnVsbGIsIGJpbywNCi0gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgYmlvLT5iaV9vcGYgJiBSRVFfRlVBKTsNCi0gICAg
ICAgICAgICAgICByZXR1cm4gbnVsbGJfc2V0dXBfY29weV9yZWFkKG51bGxiLCBiaW8pOw0KKyAg
ICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIG51bGxiX3NldHVwX2NvcHlfd3JpdGUobnVsbGIs
IGJpbywgZnVhKTsNCisgICAgICAgICAgICAgICBudWxsYl9zZXR1cF9jb3B5X3JlYWQobnVsbGIs
IGJpbyk7DQorICAgICAgICAgICAgICAgcmV0dXJuIDA7DQogICAgICAgICB9DQogIA0KDQoNCg0K
Wy4uLl0NCiAgDQorc3RydWN0IG51bGxiX2NvcHlfdG9rZW4gew0KKwljaGFyIHN1YnN5c1s1XTsN
CisJc3RydWN0IG51bGxiICpudWxsYjsNCisJdTY0IHNlY3Rvcl9pbjsNCisJdTY0IHNlY3RvcnM7
DQorfTsNCisNCg0Kd2h5IG5vdCB1c2Ugc2VjdG9yX3QgPw0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ibG9jay9udWxsX2Jsay9udWxsX2Jsay5oIGIvZHJpdmVycy9ibG9jay9udWxsX2Jsay9udWxs
X2Jsay5oDQppbmRleCBjNjdjMDk4ZDkyZmEuLmZmYTRiNmE2ZDE5YiAxMDA2NDQNCi0tLSBhL2Ry
aXZlcnMvYmxvY2svbnVsbF9ibGsvbnVsbF9ibGsuaA0KKysrIGIvZHJpdmVycy9ibG9jay9udWxs
X2Jsay9udWxsX2Jsay5oDQpAQCAtNzAsOCArNzAsOCBAQCBlbnVtIHsNCiAgc3RydWN0IG51bGxi
X2NvcHlfdG9rZW4gew0KICAgICAgICAgY2hhciBzdWJzeXNbNV07DQogICAgICAgICBzdHJ1Y3Qg
bnVsbGIgKm51bGxiOw0KLSAgICAgICB1NjQgc2VjdG9yX2luOw0KLSAgICAgICB1NjQgc2VjdG9y
czsNCisgICAgICAgc2VjdG9yX3Qgc2VjdG9yX2luOw0KKyAgICAgICBzZWN0b3JfdCBzZWN0b3Jz
Ow0KICB9Ow0KICANCg0KLWNrDQoNCg0K
