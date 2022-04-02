Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 933554F0675
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Apr 2022 23:41:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238874AbiDBVnT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 2 Apr 2022 17:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbiDBVnO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 2 Apr 2022 17:43:14 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2063.outbound.protection.outlook.com [40.107.92.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D052056C39;
        Sat,  2 Apr 2022 14:41:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NF50/VXVhGvpUQCUsKhJi0/tERH/AK3TgYKK29xAjThbXBI8QVekjNqRl4I8NF6wr8XP8wwdBl7dmalvtrY4wtfSug9wHUEUSIEAc3eN1Jha+UH5tDvNC8GCoa1J1qIye8+awtAIj2GyjqVUyNyE0sUZHITgQswTPeZujwYfCdjO0j1/udf+Bm+Wz7oufpbLo81815bpCgbTkYprqBU8mtlrJ1qs0EO/WFj9hDbulazsi7DbgpMNeWYi8QJgVSYc6rwn6HnPFRExXyKGTzmgdyz3IY2eLjz/IJJmgjGsgarLP0xWsMwnroxR25mkpNVWGww8z+DnnrD/jVO5XNhh5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R08YZ935yb1P+a6p111svTa2naMVsBjs6UKU0qvMTvo=;
 b=D6zR21CmMm4U7Hntx9v7GJo3BCg3qHGaW9spmYfSqDoIxj5R98N/HPWsvnpG6mobEcvrGRvJZrQeFk0PiEbJZhUwyBxVu74VNILHEhCA/+HSe0jGvS6mmvfiQV2HScan4a0WLyThRAGBICubz1n14n11U8lmkTomvHrVS8bAeltzBKiOSE97M7Arpl31xEB/Ur3X/+TiGvijzsd8jDuy1sgA5sXo/AV+JgC482YJe1GTf1z5ypeXkKEyqFD8dbxV0UO01wHR64jJeKSRRyH8/6vC9QD4L4CWGd7yOu3V0AVn8OF/4A8PHnQkMVICz51FBOvK9tmitfKBHFUFbz1V/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R08YZ935yb1P+a6p111svTa2naMVsBjs6UKU0qvMTvo=;
 b=HaK6byHVzlusi9mr77AUip+COdHEpEIlcK3feFB7SEJFgwJkz0NfySq/B9+IeApYGxsUmDteOZczyu4b1wSDz16xsQA1X8HVB1PYTUOTKrpyl220mWWlaHuYE04BkjsMF8cDXYonHiS1Y7XYnIwNBUUve+9VhPcCNYlubYGOqe/LfB/JOdegBIAn/brVKYgD218FnnKbkYIbD/9XaYQkw0/3EObqYOwyG2QdChlZJic5oKoJd5XtiS/v2v9AxeWTNaVeQGr5xu9+Ljg3Gj/M4Z93/oRh4vRVRNNWqZYZXRlOliOx5Oe5ZWnxQKTqFv47R8ueymN7L2Xa2AFLewOi+Q==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BYAPR12MB2662.namprd12.prod.outlook.com (2603:10b6:a03:61::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.30; Sat, 2 Apr
 2022 21:41:19 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3dbb:6c2c:eecf:a279]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3dbb:6c2c:eecf:a279%6]) with mapi id 15.20.5123.030; Sat, 2 Apr 2022
 21:41:19 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     "cgel.zte@gmail.com" <cgel.zte@gmail.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
CC:     "nathan@kernel.org" <nathan@kernel.org>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        Lv Ruyi <lv.ruyi@zte.com.cn>, Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] fs/buffer.c: remove unneeded code
Thread-Topic: [PATCH] fs/buffer.c: remove unneeded code
Thread-Index: AQHYRm5dSk9Wv1pxAkujd7iYrhrtDqzdJ+mA
Date:   Sat, 2 Apr 2022 21:41:19 +0000
Message-ID: <1235fa07-8a29-069a-34c2-dadcfa5e3be5@nvidia.com>
References: <20220402084746.2413549-1-lv.ruyi@zte.com.cn>
In-Reply-To: <20220402084746.2413549-1-lv.ruyi@zte.com.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 57311ca8-5bd0-46f9-3d20-08da14f18651
x-ms-traffictypediagnostic: BYAPR12MB2662:EE_
x-microsoft-antispam-prvs: <BYAPR12MB2662C222813B8DF782821E0AA3E39@BYAPR12MB2662.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tdSlidSOibyUtG38iXlNEunCQCNNZPkBsFkbEzI5Vh/mrEwH7fafeSxvB/h9vvcz8OJIj1BSzhsgI5pZgZcvxWYHHrHzdXEL561m4K/doKFhusrDAG/OxkjbYQB6FdiGS2yzsHhblCKvF/zscXnD248AB8bR5SLgdwFf3XkJE1HAa3n2e4f7j/liUdDQMpeW+1KtNn3zW8FPDASF0n+75kZOQsrcCAr5IJFI1HUH8EQFB0xqhvKdXlDmaTo9aeSSIzWlqiaqgrdsXpRU16KdLoPOyy3EgBctY/yT5Tut6oDUH/XdQIH/JxmnTHb/UbNrUD4bK2Ux7VX34Nzo+Utu1r4miByWALZhkh6Mf3zzlJC+NRiM8zEeKm/RAEW30xELXpSvQX736X3dO80cU1hRy3Ahg6+/us8QtmvkjzaUPjSIU3VpVNhLQDkBpgfS0NAHkOTMIxhSwzQVRxK+3V7DotdJhcBtE1MGhsVH/JQ1+HHO/S778UHdBJtWMFHclMSM493Cmen9EJ1FQABe/QWjQi3CmPQTvN2X6z7FQoVWspUGSNhHxCKMxaqMdr8zBzLYK6jHNsMJvj6J3yvqjPbIFugjYNkUAL/5xQw3NTTdeT4ZRMOyrn250Vycb3nk9OyiWGsbJceEEvIv+rQN0mbmByAMLIAdZ3tDjexKWt25Y7sLCVp3wDe36zpAQVoaEHVZE7ncfpcLSMTSCbzM17QU5e/RbnBGYXkLe4a6IKLJMKNQhMKMJtp8NtpDm6TTUwv+JHSK2XxnrxwHRe2ddDuBNA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(2906002)(86362001)(508600001)(31696002)(76116006)(91956017)(6486002)(83380400001)(36756003)(558084003)(110136005)(316002)(54906003)(66946007)(5660300002)(186003)(4326008)(66556008)(66446008)(64756008)(66476007)(2616005)(8676002)(38100700002)(6506007)(6512007)(71200400001)(31686004)(38070700005)(53546011)(122000001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L3pwcnJiMzlTZjd4WTltd2hheGZiVldzTEZWUXhGVXJ1V1owUUgyNmEzc2lV?=
 =?utf-8?B?QlNVNEs0Sm5NQ0VlL1hxdStNTTdnZXp3Y3hzM2R6Y09ZYU80Vk5QOHJQTWsy?=
 =?utf-8?B?a29YUjZmVVE2VkpMU3hlMlpJenVCQUkwdDIrQlRNWmJnR1l6cHhOaEVkbVk0?=
 =?utf-8?B?OGdEWGlFcmNnYlV3bFRDaU9pN2JZU0ZSV3IxY3pjZHpnb1F4aTNyNmZBdmFZ?=
 =?utf-8?B?amJYdyt4WklaNndvV2N0aC85NmlBZFE2YUNsei9kYTlBTk5iOWZZQ1VmMUdN?=
 =?utf-8?B?cHBTQXByc2xMWUVGbWdVc2RqYWd0RTJ0aFJQNlBYbGxOSXQ3M2pkMndVWlll?=
 =?utf-8?B?bFpyTzZpQXcwTWt2d1hGWXlQR1c4a1Mxb0FSQTFtV3VrUFdTZHpJd29SaDU0?=
 =?utf-8?B?Qjl1WkpMUXd5SnZZUU16cU5SdktKTW9rZEgwSVFiVzl2VWI0U3pQTkQ2YWFH?=
 =?utf-8?B?SDY2Y293ZjhMWndmRU95N0I0SlRhaXRqODBVRnNGSXRXaDZMZXhDQVJyYmYw?=
 =?utf-8?B?QUpPWHhJOUZGVm9hYzdXeU5ZcjRTd2FuQ1F1RmtxSFl6MEpOS0dNQW1MUkVC?=
 =?utf-8?B?ajhxcElJcysvRFJnSVkwZmxUSTZuZ3VMcXFYeXFKUVNyNGc4SUJMeWh5RmFM?=
 =?utf-8?B?OXhlNHprUVBuSkFqNmNtUzU0dmxCQXhNQzVtbHBPZUVFcE1hU3B1WGF0Q2dY?=
 =?utf-8?B?Ry95azFwUElXbXpabUtHQ3lIalFkY0dQT1QzVzZsK3k0MHRSN0hmam9JTzVX?=
 =?utf-8?B?MzArSzI0VEdhOXJGVU9KMFVGTys5UUZUVUxxc1JaU09Pa1NkQzYrdWpYMHRw?=
 =?utf-8?B?aTFwd0dQNGxBd0lEYmpjdkFyaVZqMHRBazFiWUxXTnZlM0V1cnZWb1RhUmxJ?=
 =?utf-8?B?ckRIRGx0Z2xSeTB4UU9RRENIRkEwc3haSWJQeHZUalFDNVpuQW82bENYM1No?=
 =?utf-8?B?aTFWRS9aMTFnNzlKc3ZuRytna1lFdWkxL0JoYm80UDh1N0dneE5GeXFKTnMz?=
 =?utf-8?B?Z3ZvbEp0SzJOc0hwSUxsV0JrdzlmeUhHa3BuaFF2UmF4aWJFZnV0c0hnRko3?=
 =?utf-8?B?Sll0VGxXL0txNmtpTGY3M2xJWEJ0cm5LZWVIaW1jYSs0M3FuNFBFczhUZDho?=
 =?utf-8?B?MnM2dU03WUpVbGYxNEFTZUlRb2FmbVJkelR6eUdVOUZOZktHb1lBMnd3Snky?=
 =?utf-8?B?eEUrcVFEYmxHQW5qaE53WDlhYThWaG04dzdZNG5seWZydSs1cUxjaHhrMzhp?=
 =?utf-8?B?Zm0vQ1pNdncxczdubUhyMmF1UThSOWhNRXdra0lzcUE2eSs3UTB6b0g4VU03?=
 =?utf-8?B?c2FYL1lPMEFZV3JDWDEwdnN6NXdjb0EydUwrL0EwTmoxL0lhUFY3KzlDNm52?=
 =?utf-8?B?TFdkL2tZcnRIcU1iMUJwdjNISUNWZEJCTTdhUk5BYUdkSmVVTy9IeTR6bFFW?=
 =?utf-8?B?L05LKzFPRGNHeEhMZVpETEpiRzNsVEtWbTIxR2VYN3haaksyWUJoaklvUU9x?=
 =?utf-8?B?c3VkaEwyc3JDMllGNS9udHJOcmY4dTJIb2VtVkFIVHVFYllham5WeE5ITVNK?=
 =?utf-8?B?SkN1VEt6OU9RdmRyRmlQOE16RjBJNENrL2NpcTE2U2k4ZFZFWTF4V0psL2Z4?=
 =?utf-8?B?blJUcjBxR2NYWk5VZnpvbWxIdGtUWG9UOHB6ZGttb2tlMjJjQkwrdk1Eckc5?=
 =?utf-8?B?WmY0dlpQcFZzVUQ5OEducWNOYnRzWkVLUFA4bm9JYTAvY0pzQWFCNXBiRTJi?=
 =?utf-8?B?K3pxSkt4WERkcTlKb0dNdkJKanZGZ2x0YmFIUGM3VUpTakxnMGVMQW9hWGxE?=
 =?utf-8?B?RlhTUXlibUpiblRyNGpNbEkvWmJYMkthdU1BV3JJMXJtQ09vTmtBdlNmU2NB?=
 =?utf-8?B?VlNUMXllZkFuYXVGSU5nbHhUSlRWVEJ6cjFOcDg3OThBSG1sSHc0NjQ0b1dJ?=
 =?utf-8?B?WHV4WlhPc1VHNVpJSisrNzZCMFhnS3gydG9QM09Ib2RncnpieE1rRVdMM2tk?=
 =?utf-8?B?bzM4bUY2Q3U5ZFlBVEgzRUhsRXdLckpjN3VWSVlTUkZ0a0k0ankrQzVpMmhS?=
 =?utf-8?B?UDN2MERTZCtZVVdPOVl4NXNveUpZb2I2T1lJellzRCt3RUhGaGRRb0hGOTB4?=
 =?utf-8?B?Qk0zaG1HaHNEM1A5cC9ZenhDWmV2WGQ5NHFZMWV5YWZpK1pDOE1BazBBanp5?=
 =?utf-8?B?SHkwVUNkZmZqTW9QdnNXd1JSZlZsZDNjMG9paSt1MWt6eWw4Q0FJTUQ1dWlm?=
 =?utf-8?B?NFN5NXNybmhPdVZDTUJIUEhFUElyS1ZNU3Vvd2V5OWdKSk80dWE1MmZibVAw?=
 =?utf-8?B?Mnh3L3p0Y2RRcktkOEM5dy9qZTNZNVV5SWV6am1nSTZYaE9Tb0dMdEoyWG8y?=
 =?utf-8?Q?vg72JitFF7L/VnPo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <777BFE1D13F39043A0D5A279317196A4@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57311ca8-5bd0-46f9-3d20-08da14f18651
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2022 21:41:19.8553
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k0PAlXzsWj5cOkkWVrpCr3AE80F8hI0zo/g9rwgVuS5SnkhempzsSyETtzSj74V9C0k56TPXWCtk//x+czQbIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2662
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gNC8yLzIyIDAxOjQ3LCBjZ2VsLnp0ZUBnbWFpbC5jb20gd3JvdGU6DQo+IEZyb206IEx2IFJ1
eWkgPGx2LnJ1eWlAenRlLmNvbS5jbj4NCj4gDQo+IGZpeCBjbGFuZyB3YXJuaW5nOiBWYWx1ZSBz
dG9yZWQgdG8gJ2VycicgaXMgbmV2ZXIgcmVhZCBpbiBsaW5lIDI5NDQuDQo+IA0KPiBSZXBvcnRl
ZC1ieTogWmVhbCBSb2JvdCA8emVhbGNpQHp0ZS5jb20uY24+DQo+IFNpZ25lZC1vZmYtYnk6IEx2
IFJ1eWkgPGx2LnJ1eWlAenRlLmNvbS5jbj4NCg0KDQpMb29rcyBnb29kLg0KDQpSZXZpZXdlZC1i
eTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoNCg0K
