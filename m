Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C14D664ADC9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Dec 2022 03:38:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234317AbiLMCiV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Dec 2022 21:38:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234180AbiLMCht (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Dec 2022 21:37:49 -0500
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A57E1E70E;
        Mon, 12 Dec 2022 18:37:13 -0800 (PST)
Received: from pps.filterd (m0209322.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BD1YF55012328;
        Tue, 13 Dec 2022 02:37:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=S1; bh=iBj07h2SdMFEsf8LZAE/mWaTKdfHGp4yQIyyvjn2Kdo=;
 b=Vb99SBR71tBj5P2x4EVBnpt2G1zmKK5RQGup03t/yHWHqmnuJdpUncIf3E/EEWIY9LcE
 fNBsVsVWZsuy2rYLrDDc644twpqSiAqkvJWgS42RjzTwZtwWL5iNHQ7bxZE9drcDa8a0
 oMPNgSEFhhmYXgEayqANVlmls4NPVWsybaX+4zW0hjDiETc2xA7qE9GkdMUJ6eKlUxiz
 ghlI3D/py4sefSvDZoggXAAcS/4UqojGs9AySh1MTKqGYc0qnLtlpxbHzhlyW+bOQ1H9
 Cxp6TwK405qKAsEoYz4C7M6Rs4CJAluCs8dF7hSCO0UXQ0X/6bAppkE+4gOaXDrhXHyA pQ== 
Received: from apc01-tyz-obe.outbound.protection.outlook.com (mail-tyzapc01lp2047.outbound.protection.outlook.com [104.47.110.47])
        by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3mcgw7th26-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Dec 2022 02:37:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G7GKnZzsYfRnIvUd1T8uGfScWB9KkSoxrXNgZXQ2bTbJPhWklbvk1RHn7nuVL4In7KVZ5q8qN6wKO7n7hAHeLtD8MQNP0vZ/7qMdWpOt2Tyy1TqUwXgDDX0SvRaDgHprtHM/2QjqEqi2dyXwgm2wqt7GjONEjccvf9Aj1zYJ7V/q8UlByIOTa6G0JXq76aZ6Eruvm7531pxosgTzpkeh+e18UGCSWEHnxlCZA003mnf+zju0pOMA00L4c5QyXHGqBeDlKL1dWSkTOPwO2ccD9QIJBK7zpMkYRoUxEY22hmaVUFFFBXzujd3mQv8gWy5FNMVel1ikzctMN/mNKybnQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iBj07h2SdMFEsf8LZAE/mWaTKdfHGp4yQIyyvjn2Kdo=;
 b=MvqkuGIwjawTjfwJPjwJvOMvBrgB4QKBuvw/U01OTPrU2dDrCKnYXBnAx9Et21RqnD8ONf0jE2sE2WuG8JepYsErAnn4UG0ncA0EMBr2or9iuKIPgetcCdMsoUK7IT7i71yZ5lIHEQSyEBbD/Un+TwTpAoX/ZTq34b0n6lv4PauP5bv1LaQfx7/0/vKh9KBNm0utIMMISCeo3YcWlBDyQto4efZIX0qo14vmuONqSubSCyzQZdaf3nVcEFmctsiRMPm7UoGqcG+uJfv2TkQPGpFShcRCLQBZ74piVZFgqRqWgRtMrmk5Ba/I3hRwbaQob6IMXfcof99itNtGJTrZ0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by SEZPR04MB6948.apcprd04.prod.outlook.com (2603:1096:101:e1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.10; Tue, 13 Dec
 2022 02:36:55 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::c689:d665:b3a2:d4de]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::c689:d665:b3a2:d4de%7]) with mapi id 15.20.5924.009; Tue, 13 Dec 2022
 02:36:55 +0000
From:   "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To:     "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>,
        "linkinjeon@kernel.org" <linkinjeon@kernel.org>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>
Subject: [PATCH v2 2/7] exfat: remove unneeded codes from __exfat_rename()
Thread-Topic: [PATCH v2 2/7] exfat: remove unneeded codes from
 __exfat_rename()
Thread-Index: AdkOmaed8wnUZh9jSXqXATN8Nxo26Q==
Date:   Tue, 13 Dec 2022 02:36:55 +0000
Message-ID: <PUZPR04MB63166E7CA77E9C266566263181E39@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|SEZPR04MB6948:EE_
x-ms-office365-filtering-correlation-id: f68da264-21ef-4b1e-0704-08dadcb2e686
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sDfLlNZwzDI+HRQYhs9jVeSWEf9UBV3qTiXOAZpEj8xEWajvakEiml1KTAZ5b6fS/KdJ/Vx1U96kNfV9guoBtJoK2rz3egoccO8qvPQgfZCYh4WWZxsl4YnWPISse1BB3RBBgoXCavpjXtSkybz3miQl8n34tYmw3ARznYrP0p7WFyZfr0eM5S9DUZGb1ZrnAib/hkwXbl0jt+QXOXkU6rj737Bd98Gto1z9FPhii5OdJ3bjkE5zg9i2rD+kUivkk505NSvO7TXgro8bm1zf9mg0f8pLGRkQO3hInDfc4ayadkhOzF6kkv9jtDJeat0GuuQV3EScd/1Y/N0OfG5YtX3hUeEtDpCW967syjdC9jsoZ57MO8WVCJv1wq9TOXX+xSOfTQIU1URTLbRoiXxzB8PM9QwP9/HQW3sAFYY3Q+XOXrg5qt9V2f9VfU+QrqI2BdvQcIZSNPPw0kD4DKRsxl5DAzM9ozkCV+dv/6I7F/NYQYUTRxOS6NCJdj3bvc9qkitAbjlFtuaUTwrPhQ2aSuCpu3Y+wBz/dkEA5OU0seE8Mt328w6Rl35HUUIXVrquWB7kCS1w57dRK+g+28tTk7jQrdoAzQbGEn5CzYff7Za7xLFtwo/QfTKpYZE23r9VqrzPB9TWmMP54gaCbd+f2evgIbu8xz5ltBJ1D4S9iMJhegOLDx5dxBnIoXPYjmtYbX8/nktsd9v2trFkz0eLqw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(136003)(366004)(346002)(396003)(451199015)(86362001)(82960400001)(38070700005)(2906002)(8936002)(4326008)(8676002)(66946007)(66476007)(66446008)(64756008)(66556008)(5660300002)(122000001)(38100700002)(33656002)(83380400001)(478600001)(110136005)(316002)(54906003)(71200400001)(76116006)(55016003)(52536014)(41300700001)(6506007)(7696005)(26005)(186003)(9686003)(107886003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NVNuMFBhdkx3dlhTeHB3a0swdTVxWmw5ZkRiNlRLSjdlcUw4dzhURWZpUlNs?=
 =?utf-8?B?c0dRd3ZIQm4wT0dVLy9kNmtBR3NkYWZmSHFLSW53clVvUGZkMkNtZVFtVFI3?=
 =?utf-8?B?V0VjNDZxUkJWSU04T1lQVmtQZENxY3hMRHA3WGQ1bUpXY1N3WW0yekI3SHRn?=
 =?utf-8?B?TzRua2NkSFBqc3BNOXZUb2hYY1FaMjFXRHZ5UVdoWU9xYWdvSUIzcTVtWGJF?=
 =?utf-8?B?SSt6OElJLzVtdFJrTjJhbVBlZ0djQVVSVVV0cmlScEdpUmtRZ0pLUTcwNmhm?=
 =?utf-8?B?UlVNWkp3RStIdzFaM0o1ZnBCLzNQdkVpZEl0d1lHd3VDaFlJMEg3bHk5cWdI?=
 =?utf-8?B?bE1aK2ZvUzQ1RW1xcXZGK1dodW1TMy8xQ0psN25FWVkrRGpCU0htV2RtNHpH?=
 =?utf-8?B?Q2JEMjVVdG5qM1dhK05qVGlQdlIrbnMrQVRsVGIwSEpaZk9GdllVME9pQmdF?=
 =?utf-8?B?alBZbXpWVWpEaEQzalhRaXJodlEycDZlcDBqNzZtd0JDYlkvMVdFYnp4VkJP?=
 =?utf-8?B?LzFiQmY4UVR2MTF3ZldLQk81RjJTVm9MU05pTDhUMWJIQ2lMTS9HUkVubFdx?=
 =?utf-8?B?blhKeXRLSU9ObWxxTEJNNVBwSHRZd08wUFJmMW1BelNIWGhmTE1UQ0EwUnY5?=
 =?utf-8?B?OGFPejF0UEE5M29aKzVLM240NjZvcWlGbVVvUWU4U3dPWW1YK0JHME1ZM1JV?=
 =?utf-8?B?WEh6Tmdnemh1a3ZtMHZlMndMV0JvMGF2ZTZlWTZGZjIrZkc3YUdXbTQvYjB4?=
 =?utf-8?B?UlpjTHJpVnNZc1d4MEo1WXFTTVdPcFNEMks0OU5FRjFCZ3AxdHNmYThWOXBW?=
 =?utf-8?B?bEFtblB2TnFaajkrdGZnVkRJYzNEcXNnbWRjaDZZOTY1SEJmWnkrakRQUG0w?=
 =?utf-8?B?R1ZXTVJ3RXlhSFpXTmtFODlNdlVsY2hMeUZyaFJFRDRSclFwelhLZW5hZFY2?=
 =?utf-8?B?bzd5RWgrOFhwZmZxVjNscTR3bGFPblI4VGNDRzRWeGo4ODhjMlhveXdGNm0r?=
 =?utf-8?B?SUV3cjErV1JNMENrRGY0dVhqOFlPVk1iZWlXT0RPdjJiNWJOcTRBaHV6RHRZ?=
 =?utf-8?B?SnBzZXgwSWE1NVVackxmK0xER1hQYjhkR0VZYnBQcUNERXgxa3IzNGhvUGVt?=
 =?utf-8?B?b0M4ajhLOUZ4VGRaWmtBUVJDN0lZQlRKQUxuYWZ3WWM4NHFBcUdFOTJhL1dq?=
 =?utf-8?B?TStFWUZaVU45WVhKM0FiVUd2am16a0Qyb0tTQjhJbkFVWlBRR2UrUlQ3dnU5?=
 =?utf-8?B?c1h4OXl3a3h2c2F0NFpKcHRHWDh3TUxOb3RpMENVTEN1NVphWnF6SG00bnJw?=
 =?utf-8?B?UnVPMHQ5MFZMQUMzUU1IeGpVaDMybk0rU203K3RCK3J0dTBCNXlhTUlnWGl6?=
 =?utf-8?B?Y013ZmFOYjZsd3pHdXJxSnUrUmNrOUhKczRacXFsbUhkaDVUV0R4Ryt0dHZ0?=
 =?utf-8?B?U2pJTDBhQ1dRUEpsNXE5cy9vWEpiV3p2ZDJ4emY5U3FiZkhsU0xYemRmdnRD?=
 =?utf-8?B?OFBFNEF0SjI0dzlDTG02Q2xwSXZka2Y4akxlWFBjUS9Za0dySll6ZmZMUXdJ?=
 =?utf-8?B?dnVFbUlYcDJqMU9kbnhZVkgwOWJyY0pHelM3bHNBVUI3V1FQTytxejRNYlZn?=
 =?utf-8?B?OHQ3V2srNjNoeldidG9yOWxWSlpJZndML3dMODd0OFp0RU82UFl5RmFNSzBl?=
 =?utf-8?B?d1JpT2lxd2ZBOUU3Y1MwVVZTY0xqcm5DS1AzUjV4SG4zTXVoRlZicVdjVm8w?=
 =?utf-8?B?L2xEV3ZxbHJOWW42Tkg2bG5zRGVpVnJNN1pFZ2piTGRvTEtPTm9jSm9pUTVF?=
 =?utf-8?B?MVpxVFhXRFhZTTRpOEc3cFJUS3loVFFnSU1Ha25wZGk2SjZHK0J6Z2dMcEFI?=
 =?utf-8?B?RWFJb0RXZ2w2alZxQ3dNdDFxMXgrditGVXRyRDAvSWVqVWtHZGJOb1dNckdR?=
 =?utf-8?B?cyt1YlphRVZkeVJKdmFoUlBuNWVCQmRPdXVFR0RvV3VjL1VoZnJPNjZDVHlW?=
 =?utf-8?B?L0VpS0Q1N1cvQzhnNlArbHAxNGM4MTgyWlpVbzRDcHZqOE1Ua0RzUi9BZWNH?=
 =?utf-8?B?QjNGZ3A0dEh5aU9zYmZaRGphVjB6d2s1ZE5CSGhUMmlkdUljOG9LcUQyYXB2?=
 =?utf-8?Q?0EvdYlKSKnBpPQ6ae5e7/1Nuu?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f68da264-21ef-4b1e-0704-08dadcb2e686
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2022 02:36:55.5710
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /qkwMK/XJChcas+xCqCBORCMA8OtLB+f2PAmv0UdRuc0MN5+l2vDwuERnCR56Go9NtzhIm+0BeRE+6CbAHWpWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR04MB6948
X-Proofpoint-ORIG-GUID: wMBJregojqql3Fwa1t7V2-leddumCxAq
X-Proofpoint-GUID: wMBJregojqql3Fwa1t7V2-leddumCxAq
X-Sony-Outbound-GUID: wMBJregojqql3Fwa1t7V2-leddumCxAq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-12_02,2022-12-12_02,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

VGhlIGNvZGUgZ2V0cyB0aGUgZGVudHJ5LCBidXQgdGhlIGRlbnRyeSBpcyBub3QgdXNlZCwgcmVt
b3ZlIHRoZQ0KY29kZS4NCg0KQ29kZSByZWZpbmVtZW50LCBubyBmdW5jdGlvbmFsIGNoYW5nZXMu
DQoNClNpZ25lZC1vZmYtYnk6IFl1ZXpoYW5nIE1vIDxZdWV6aGFuZy5Nb0Bzb255LmNvbT4NClJl
dmlld2VkLWJ5OiBBbmR5IFd1IDxBbmR5Lld1QHNvbnkuY29tPg0KUmV2aWV3ZWQtYnk6IEFveWFt
YSBXYXRhcnUgPHdhdGFydS5hb3lhbWFAc29ueS5jb20+DQotLS0NCiBmcy9leGZhdC9uYW1laS5j
IHwgOSArLS0tLS0tLS0NCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDggZGVsZXRp
b25zKC0pDQoNCmRpZmYgLS1naXQgYS9mcy9leGZhdC9uYW1laS5jIGIvZnMvZXhmYXQvbmFtZWku
Yw0KaW5kZXggMDFlNGU4YzYwYmJlLi4zNDdjOGRmNDViZDAgMTAwNjQ0DQotLS0gYS9mcy9leGZh
dC9uYW1laS5jDQorKysgYi9mcy9leGZhdC9uYW1laS5jDQpAQCAtMTE3NSw3ICsxMTc1LDcgQEAg
c3RhdGljIGludCBfX2V4ZmF0X3JlbmFtZShzdHJ1Y3QgaW5vZGUgKm9sZF9wYXJlbnRfaW5vZGUs
DQogCXN0cnVjdCBleGZhdF9pbm9kZV9pbmZvICpuZXdfZWkgPSBOVUxMOw0KIAl1bnNpZ25lZCBp
bnQgbmV3X2VudHJ5X3R5cGUgPSBUWVBFX1VOVVNFRDsNCiAJaW50IG5ld19lbnRyeSA9IDA7DQot
CXN0cnVjdCBidWZmZXJfaGVhZCAqb2xkX2JoLCAqbmV3X2JoID0gTlVMTDsNCisJc3RydWN0IGJ1
ZmZlcl9oZWFkICpuZXdfYmggPSBOVUxMOw0KIA0KIAkvKiBjaGVjayB0aGUgdmFsaWRpdHkgb2Yg
cG9pbnRlciBwYXJhbWV0ZXJzICovDQogCWlmIChuZXdfcGF0aCA9PSBOVUxMIHx8IHN0cmxlbihu
ZXdfcGF0aCkgPT0gMCkNCkBAIC0xMTkxLDEzICsxMTkxLDYgQEAgc3RhdGljIGludCBfX2V4ZmF0
X3JlbmFtZShzdHJ1Y3QgaW5vZGUgKm9sZF9wYXJlbnRfaW5vZGUsDQogCQlFWEZBVF9JKG9sZF9w
YXJlbnRfaW5vZGUpLT5mbGFncyk7DQogCWRlbnRyeSA9IGVpLT5lbnRyeTsNCiANCi0JZXAgPSBl
eGZhdF9nZXRfZGVudHJ5KHNiLCAmb2xkZGlyLCBkZW50cnksICZvbGRfYmgpOw0KLQlpZiAoIWVw
KSB7DQotCQlyZXQgPSAtRUlPOw0KLQkJZ290byBvdXQ7DQotCX0NCi0JYnJlbHNlKG9sZF9iaCk7
DQotDQogCS8qIGNoZWNrIHdoZXRoZXIgbmV3IGRpciBpcyBleGlzdGluZyBkaXJlY3RvcnkgYW5k
IGVtcHR5ICovDQogCWlmIChuZXdfaW5vZGUpIHsNCiAJCXJldCA9IC1FSU87DQotLSANCjIuMjUu
MQ0K
