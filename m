Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD3A4F8C50
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Apr 2022 05:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233875AbiDHDLN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Apr 2022 23:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232790AbiDHDLG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Apr 2022 23:11:06 -0400
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2FBF174E99;
        Thu,  7 Apr 2022 20:09:02 -0700 (PDT)
Received: from pps.filterd (m0209326.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 2382kRDh008391;
        Fri, 8 Apr 2022 03:08:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=S1; bh=6fYGCxgKttzH9eB1tAftNtI/yN/5IfOXkcp2fgV92Qk=;
 b=B0xFzkZ7DvXkYHe+P3pUri9E7HCL1PX5p6eFunGqcWWUh/iCv+W9/QaMk5D62koJcjy2
 fx7orewajS7/g0M/2GMN5IAlLi4FKc4I1j+aWTXxKCnLPjTnrxbHY6Ys0ayNJM+LFEt4
 OzkGlQKTkv/qyqlSdp+bW5dpStJ8j0mAbpfTeTNICkHezigS1AT1rj4VHHFyg++ckF76
 aXQracQMA6ZrobijBOkmof1uSZAVx7qrS8kO8TcAQGMLlsjUYO2//Htq152Oo/VNKVZJ
 dKJVStFhMf6//pSX2wj8vfSHLa4dLxVKJgDcLSqE54hTmZpzzqCUbVewKONQwjaUQ1ky gQ== 
Received: from apc01-tyz-obe.outbound.protection.outlook.com (mail-tyzapc01lp2046.outbound.protection.outlook.com [104.47.110.46])
        by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3f8yhgjfuf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Apr 2022 03:08:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XnQ5thP/18TiC4wyRDrVGCtXpqhUYQZddqma2QqbftFkZQA8Rd8B3NaoGf16nwSJvaygZ7w/m8YPxjVrDqJim6d75sKZHAemtPhH/OFDZXBPNcucSkJ+3+xTVJoiIJxeaJboWEJOhZSO6dlyYqpmMhMIyrGIFcYUqmPE5dpQzfJAi1pE7tAK2Uze9OrkhLZQ0uJIHoZ1IWGJR+umxcYQDeyxHwPdrhi2cFXarjCuIB4O97UpsG6CcW8HZes8mFXQ30iPN24UAavEIYtz3AKIUabtpOGystSoVJMT+zFPxxy3RgSUcOJv2EASRxl4uh7AepFgUX2u90RNkX1LI2F6hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6fYGCxgKttzH9eB1tAftNtI/yN/5IfOXkcp2fgV92Qk=;
 b=DBjwd2YP2A7+okpdScZvrRZcVCY9+BtL+GOTZIWcHIenZMMt5KPGElm0EmeewHF8XgUWqW4na419fmKRBJQeDGEcKCOeRX2Ysrg37zpgixRz6I6PQgl1vW4FshtRVS+lFvUjYAU9LnNnpV9qGSL9PxadenwY1Njwi2ctjjGRUQV5XhPSfpzwm0i3ApyNbSr40Ya/PctZHFDI6vXRoet3XU7Tmnk/fwNqw/46ZON+LyOU1Um4ocCxmNOq5iHbumC6DUU631oOgLcUMLrWzLFcRGF63dwWCi5PmuJz5kYo2zAKolvRMexmFkvt8bYWtZGasaeJg1MMWx5uKtQcCvV6nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from HK2PR04MB3891.apcprd04.prod.outlook.com (2603:1096:202:35::13)
 by SG2PR04MB3866.apcprd04.prod.outlook.com (2603:1096:4:a3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.22; Fri, 8 Apr
 2022 03:07:32 +0000
Received: from HK2PR04MB3891.apcprd04.prod.outlook.com
 ([fe80::7440:bc88:211:6094]) by HK2PR04MB3891.apcprd04.prod.outlook.com
 ([fe80::7440:bc88:211:6094%4]) with mapi id 15.20.5144.022; Fri, 8 Apr 2022
 03:07:32 +0000
From:   "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To:     Namjae Jeon <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
Subject: [PATCH v3 0/2] exfat: reduce block requests when zeroing a cluster
Thread-Topic: [PATCH v3 0/2] exfat: reduce block requests when zeroing a
 cluster
Thread-Index: AdhK9Eq/oJsWvsb3TgmrJ3fepcIZEw==
Date:   Fri, 8 Apr 2022 03:07:32 +0000
Message-ID: <HK2PR04MB389167BA767D8BED49D595D981E99@HK2PR04MB3891.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5dc290d4-df87-4263-e22a-08da190cecb8
x-ms-traffictypediagnostic: SG2PR04MB3866:EE_
x-microsoft-antispam-prvs: <SG2PR04MB386636F7D90BA68D3778976981E99@SG2PR04MB3866.apcprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BfJOS0AwvHcszQ7q+Z6jZy0bNgclcbmCIiuum3q7SgoDmMXBZRxSiivteX6c/eowa9nXJgQtcEz8sZyi0kbPCWdsNLRyTDXyn0B0Ub6tf9MubnW74m0Z0EszPWkaYwthuWel55EuaVY+uCBU4Y9QMtygKeIoYuoTYMVL2bx8dqGpyZwS3qlb7VV1nPGqx9/Pah6dwK/Ubunyo3YvTIsoYj9ir6rewvFW5Wy6DKZbg8xBRjqthX4a1qF3LORpZt1fmbeiAOSVtfwh+86l5oFkTTQdk+TtXV53hhqVS+MCuzb9bBDv6fcmIuoiB1zzpiu+cEPDbPYtjC1DzSQDnRjIoKj4RsO8bAEGpEPR4dSw1hMYv10mJ1CxR4WIZzu6y87v3QtL//egPWhHSfK7Vm4Fbpcb+JfgJoAphMDdbwBp6l9B3XvLwDSieaEJkvFbAp2WuwRN6BUpk1DGC7mZzXxbfbJKXRHvZzqsnxLxPBrHpXWrPtrJo86vztRlshwX2SXvpEMCdqQ533DsO7pC47gTH53shMkDT4/1l8RLPgWnCNZDmpOfKPmazb/zI7ZtXyEBe4Kjps+VDI0z/7WNifIe6234+67NcoxZfBFdGNBAkrP85dPVp2r1ccgHjCuLvBacQX/9SIHJtqdOZ8yLcsc45DX3XOB5lladxG8hQg7IGrYKhCF+F/vuN97v2RgX6DWCnhOnYQ9n8wYp5vNy/UvFTQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK2PR04MB3891.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(83380400001)(7696005)(6506007)(52536014)(71200400001)(82960400001)(5660300002)(33656002)(8936002)(38070700005)(4744005)(2906002)(508600001)(86362001)(55016003)(9686003)(54906003)(186003)(26005)(122000001)(38100700002)(110136005)(316002)(76116006)(4326008)(66556008)(66476007)(66446008)(64756008)(66946007)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?czROdnFPVlVEdkx0K1IrZTZQWWM1eDJLQ2JIa0hLbGovWGlFWjRsRjZxTmF5?=
 =?utf-8?B?aDhqNE9xdXpFWWl3OUtrY21aZGREMUZKNGg0MXBUalcvTXFvZVNYU1REUDIz?=
 =?utf-8?B?U3VnTndZRGx0RDlRRm5EZGdNWm5zWnpLZVNEZXpXNDlxMjVKR1FZZGxiVmdi?=
 =?utf-8?B?WkszSlN2OE51MUpDUG9uYlBKcGZqWnZ5Tyt1eU9jNHA5K1BMVHZBejdhMlJ5?=
 =?utf-8?B?WUwydmN3cjhHa1YxLzNOWUw1bHRQZzQ3SWhQbm5LckR5WlVUTzducWpodXpa?=
 =?utf-8?B?Q2J0d1I1VXY0TktjRDllWGhCL1k5Ymw1bklOMXNJQSsrNlRGN2YyVzlpR25r?=
 =?utf-8?B?VkJTckVhcHRKdndMelBtSkJZaVUrSEhwOWZ5aHU3UU9UcTNYakxaak44NmpZ?=
 =?utf-8?B?aVhHbjRsMXpxNFZSNnNocm1TRE5aTGFmR2d4ZVZQOUpTVjQ5WDgvSjRheXEy?=
 =?utf-8?B?VUwwU01CWERkZ1pDNE1vWmkzRVBWS2w4MlNhMHprOEpqZGt6bzJsQlhDQWVw?=
 =?utf-8?B?OWF6MVhJek1yQ2ROTEdQY3JGSndLOTNlV3NvcHBvZTlMZTZIR0tkS2RueTRY?=
 =?utf-8?B?c2pvMFhSd3FIUThpUWtmRTA2NUJPcXlGY0JNL2FHaWRidFZVVTdMekhLTlR3?=
 =?utf-8?B?Q1NXc2ZSdUtXeUdnZUJLYThuWUpLeVpjMStKMks0dFNxU1lwUFlYRlVZeDk5?=
 =?utf-8?B?ckFjbkJQc2d5Sk1XS2ZSdTAwalIzSkJBZmtCVFJaTHdDbW9BUnFiVGFRN0FC?=
 =?utf-8?B?OFcvQVBJWW9pYUtTT2pncFNBZlhjUWZJR0JlUU5kNFR3ZEc1WWJSVUlrWllq?=
 =?utf-8?B?RTRFKzRPbU9UYjlxb1BNZzh4WEUvelpnU2FUZHdxNG95RG92S08rRGRvaVdU?=
 =?utf-8?B?YTYvSWI2dG43OVZoUWxlVlVrYkk3dDFOZGVBSytFTldjQzdKamlLRlBvS2gw?=
 =?utf-8?B?TGRhNC9mSzVSSXFmS2pHT01SUFRPeGlLbzhGdDFtelQ1a1ZDbjdVUENPdE12?=
 =?utf-8?B?eS9GL09ySUNaT0Q3WCtpWHg3bU83WUlsdWtaRWtwdHkzZFdtQmpoUm9yc2VU?=
 =?utf-8?B?aHAyQjg2UmNrTi9pUFBFS0o1cE9jVEFYM0RETHpnalhuNTVZL3JkQm9TWmtY?=
 =?utf-8?B?MWNWZmdEV05RV1VtVlNXYXhIeUVsUGRXQTlYVUtLdCtqN1h4U1NHb0c3eHdq?=
 =?utf-8?B?RXVDK3ZPRjZyb1l0aytZdC9yL1dVdkk0SjhsWXZqRzkwaXArWWpiRWdUMXc2?=
 =?utf-8?B?YmNpdEY2WVNha2xWdlNoSHRFNEx3Qm9WazRDa1I2ajdSZHVHNFBZOS8wcUZm?=
 =?utf-8?B?TFROeVhTRnliK1R4WWNDbWVhVUc5TCsvcC9iazFGaUFrLysrWWhKRTdPYnhy?=
 =?utf-8?B?MmQwRmZ6c2t2WXRyU09nK3BBT2FicmNKWTYvVk5kM3VaaEJvMGtyVlJIQkNQ?=
 =?utf-8?B?WTQ1NnF5K1VVc3NXR1A0cXpjZmFWRFlUK2l6NmI3SHlFMlJpMTRaNGFaSUEv?=
 =?utf-8?B?Z3VOSmtxS3gzYXBPUDlhLzkwdkg3cGtHVEpuTkdjeVQ1VnpHRml6ZVRTcXln?=
 =?utf-8?B?SmdrQnlEUGMvRGpNcWF0dEVaUEcrQUZnRWIvYzZVMVp5WUlILzh4Q0JzZlFR?=
 =?utf-8?B?NmNvRnk4VDRUL2Y1S2tmek5wOW4za0ZxN1dMNk85anFWbjFDTmo2VEQ4Q2xk?=
 =?utf-8?B?SDVKRG80TUlFSUhTL3cyRmZaUlBpVTRtbXlnQ05TVjc2NDB6OCt2YkxsQlVI?=
 =?utf-8?B?Q20rS1JidHlKRVBvQXFTWGpOY0ZjUGRrR2Q2ZlFRcVpwczYwVHZ1c3cvdXgz?=
 =?utf-8?B?cG9uVVZPZnpGRTdkWk81WVYvb1ZlVk1OOGZOTHZZZnZyK2lVelRXZEU5cXMr?=
 =?utf-8?B?dTJDbkEyR0haWnJISm5BVDU4aFdaOEpzek5TMEVBN25LN3RWN0cvZ2lyR1gx?=
 =?utf-8?B?c2tQeWh6Q2p3ekRYTnZlNWE2UFZCZjhNZTE2UXFWNmM2TVhDQWdjR25ISFJ4?=
 =?utf-8?B?L1JISUZzUkRIQ3F0c2c3eEcrSGEySzRGNTVjSmw5MCt4NWYxRE5wL1ZDNGtU?=
 =?utf-8?B?MnRwSVpINTByczBldkxGdWxRc1kxQUNuZXB2anNHcWlkWjc2b0k2cWl2NUYv?=
 =?utf-8?B?R2hhem1VK0FESFpLdXpvNjZUZFg3ZFlLMWYxY0pOd1BNRlFqZXpFL1pXcEcz?=
 =?utf-8?B?QTQ3em9Wc2tnNXZlbVBHNFJnV0ZYTTJaK2lOQ2dQYks0NitBZFUxK01oWENL?=
 =?utf-8?B?ZzV1QVI0N0YxOGdTODNxYnE0dWxQWElsbGtXZFhWTENWdnFrWHhJNC8ydUY2?=
 =?utf-8?B?bGVaMzdTYTlBbkxlV2d4SjFoaXkzYVc2YnJBczdRTjhJcm13OUNLdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK2PR04MB3891.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dc290d4-df87-4263-e22a-08da190cecb8
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2022 03:07:32.7094
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KXvwwO3SMzbeKJhKZT+qfAG8NW1U9mlfwr09vL8+LG8bRssJUtoZJi5Eg4mCoVfyFvYo3SQ7xS5oTHM1ddAnCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR04MB3866
X-Proofpoint-GUID: eINll1jLJSh_nI-r305Y6a1ESgAQTccE
X-Proofpoint-ORIG-GUID: eINll1jLJSh_nI-r305Y6a1ESgAQTccE
X-Sony-Outbound-GUID: eINll1jLJSh_nI-r305Y6a1ESgAQTccE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-08_01,2022-04-07_01,2022-02-23_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Q2hhbmdlcyBzaW5jZSB2MjoNCi0gWzEvMl06IFJlbW92ZSAhYmRldiBjaGVjayBhbmQgIUNPTkZJ
R19CTE9DSyBzdHViLg0KDQpDaGFuZ2VzIHNpbmNlIHYxOg0KLSBBZGRlZCBoZWxwZXIgdG8gYmxv
Y2sgbGV2ZWwgaW5zdGVhZCBvZiBtYW51YWwgYWNjZXNzaW5nIGJkX2lub2RlDQogIGZyb20gdGhl
IGZpbGVzeXN0ZW0gYXMgc3VnZ2VzdGVkIGJ5IENocmlzdG9waCBIZWxsd2lnDQoNCll1ZXpoYW5n
IE1vICgyKToNCiAgYmxvY2s6IGFkZCBzeW5jX2Jsb2NrZGV2X3JhbmdlKCkNCiAgZXhmYXQ6IHJl
ZHVjZSBibG9jayByZXF1ZXN0cyB3aGVuIHplcm9pbmcgYSBjbHVzdGVyDQoNCiBibG9jay9iZGV2
LmMgICAgICAgICAgIHwgIDcgKysrKysrKw0KIGZzL2V4ZmF0L2ZhdGVudC5jICAgICAgfCA0MSAr
KysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KIGluY2x1ZGUvbGludXgv
YmxrZGV2LmggfCAgMSArDQogMyBmaWxlcyBjaGFuZ2VkLCAyNSBpbnNlcnRpb25zKCspLCAyNCBk
ZWxldGlvbnMoLSkNCg0KLS0gDQoyLjI1LjENCg==
