Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB9B7ACFD0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Sep 2023 08:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjIYGCp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Sep 2023 02:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbjIYGCn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Sep 2023 02:02:43 -0400
X-Greylist: delayed 1953 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 24 Sep 2023 23:02:36 PDT
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53B61E8
        for <linux-fsdevel@vger.kernel.org>; Sun, 24 Sep 2023 23:02:36 -0700 (PDT)
Received: from pps.filterd (m0209327.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38P54CUj009680;
        Mon, 25 Sep 2023 05:29:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=S1;
 bh=VwsICy0PpltOTtNKO1i+rZvXSxl78uZaXysnpZ9LNAQ=;
 b=jzsaMHP9D3uWdnpfkDjPuVXLxkbQDqXbHlqX4XMXJS7jDYx1IuytdfCq/QMyR29UzPob
 7Rw8Kglo4u1PS8G4KAXPvvmMdODhVn/DVpa6vV/A+7dYVVUVyN3u9woCcVUL+S3IrXmM
 UQO1DYYZ8WerfUS7xLE1UiQtcKG/i4HFQTkxRaUfyAImQMKmGMd3xiRPn4H6NtjP5HfA
 PC2Ef2EY2iyQgKz6Lp5T8oec2eL4rAZAkC/ClAmAibjXkSXIBckA+qnc6L6ejx7wuQiw
 la1yK6x+XOLQeJ01kZONaUZHRPgxtys08bW4DQyP0AYKDaE1rg4c2WvEP1XXN7KpAdnz XQ== 
Received: from apc01-psa-obe.outbound.protection.outlook.com (mail-psaapc01lp2047.outbound.protection.outlook.com [104.47.26.47])
        by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3t9pw3sfb8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Sep 2023 05:29:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XjJ33Kkcu8jCtLZsEUAZdCS0gM77KwCO1O2ITmV005uxyNqR/jJScvdiQ2GM4OMEGP26o2Dd5r9bH9IbLDye8wMZUpQTISG4UmbmJRmmCiAzBe2CUQASRIIgSxl6bVWdc689nVx+3UljrEkicHiXJl2BRtkzjQmVgznQDVUguEI3r2iDxJq7Z74KA1oydUhg8xga5Qptx4w9a6RxkQ+4qCmXty7PzSPndXfZP1xqYSWWKKMqDsc9Bp9s+OxyeZc5lOfc8/Z+dsqzyS+uodnIcg5LdxCvVCV9KOp2iNjDXjjd2yq1UUlq3FhQaZkjkxd8N5cNGVgM079fIQ2mGTXG4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VwsICy0PpltOTtNKO1i+rZvXSxl78uZaXysnpZ9LNAQ=;
 b=FitErS4cx3ABzA4tBY3wf0Rhcdcd7aQDiE5hm8T4177g+W6MDm9RBU8qvwntYXWfWXPH50jTmJ/IIt7ITfV/lgaYIbSPxaP8VxCKbB2c9J0HQhUYQCAJdvs+nJdyaRhv7f5NPGtN9Czm3d1FVxdqv99H4+4lZ+Og8HWd9k/QsrkaKi0IcHpoRTatODBr71JyufK9cebH/WsbXTmcEJr8qNJYqDwF3IRQ1b1GbYpTur3wPzSvjqouzzKSooShSdUrFI9UnNx7V/jRBvHio/O8692e6jakmtit7o1MVg484+KShZPmxtjGCkKX7etbDFHceNFsmbvtRz7tC/jXgCnFHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by TYSPR04MB7081.apcprd04.prod.outlook.com (2603:1096:400:47d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 05:29:44 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::f9d4:e3c8:e9c0:1ad]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::f9d4:e3c8:e9c0:1ad%6]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 05:29:44 +0000
From:   "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To:     "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>
Subject: [PATCH v3 0/2] exfat: get file size from DataLength
Thread-Topic: [PATCH v3 0/2] exfat: get file size from DataLength
Thread-Index: AdnvcGEzwPu3dXUbRDKPesA1ujBe2A==
Date:   Mon, 25 Sep 2023 05:29:44 +0000
Message-ID: <PUZPR04MB6316C51D022473DD0D54120D81FCA@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|TYSPR04MB7081:EE_
x-ms-office365-filtering-correlation-id: a7f67db5-b593-42fe-fd77-08dbbd886cce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dO2yTk1JUp/RuGlLVs8dXbzhGN2FZ7ArTBj74pP3HlDp4IwYYjIi+4rrd6S7p6iu00tVGg606ZOAH9Dyn/6c/M/isqCDWGny3/ckYEFEscEfDpwnlADSXR9D/OGYktiwd4t8fZ4/l2s5+Tv5P9Wzcxr28fPD0skPaJBBuZeyZSpmQ84eV+gdtY9HUZ9s0t9oNkyfKuGL9aOrjICzg/C6ECuF1/Vv5Qa5h3xIcEGgvLNmYZTkOA8E+K4wRWoOEElPTYs2vPXTKDDzFZniWDf8ryDbhfTg/PPr9Uh6mG4ZiCUE0CMLy20Hk1w/8nOrUEeNwuy+pCcCcQiAwn8SXdsVsDb5DzQIxzA6ou5HD3QpQAD7CP7cu+nLH1LvP71PdpRXEW7SC9sfeyK5Y+RGbfJgCYLIYbLMylgRxJBy98lZKzMUuIDRM/GhEnPQLd1U4r/usVJk7Ip5zJeRuvC1dTkza05LodB2fP3Iql3HpYqqyRzO0JHcIw/VS+aTBJoSoWJiMWYo1NYa5vk0lp9yqEHXUc0CxIDax5Slt4sJdHqAQuMOh642VxO3NtBt3FNAllGg3h8gOObpmOJIoweMCFiT56LmBY0VHM4CrCsCyNDOnbIPT2DD8+zgsROLpxHBmIWd
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(366004)(346002)(376002)(230922051799003)(186009)(451199024)(1800799009)(8936002)(4326008)(5660300002)(8676002)(2906002)(52536014)(316002)(41300700001)(66446008)(64756008)(66556008)(55016003)(66476007)(54906003)(110136005)(66946007)(76116006)(26005)(107886003)(33656002)(9686003)(71200400001)(38100700002)(82960400001)(122000001)(38070700005)(86362001)(478600001)(83380400001)(6506007)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UGg3YnNOVXV2eUJiS25LczVndng0YzRLRTdnVFUrV0x5ekN0N3JxVTBHUWtR?=
 =?utf-8?B?S1lYK2drTFRpbGloQUVIMnNZSFVNVFg2ajRvUE9sajU3bk1mUzdDYXcxZFoz?=
 =?utf-8?B?bnhVTEY0RURnNlhmSnA2cG4yRUtBQ0FRa2NrZ3k1c2xzK3N4NXJhZHZQZldy?=
 =?utf-8?B?YzdoZWFFSm51Yit2TlZ5dDVBaGF0OG1yVjR3bHBsTEowazNIMnhXQnVHL3ZO?=
 =?utf-8?B?cFg0SVhqVU00R1lVK0ErV3ZYaEE4bk9pakdCUnQ3UEoyZHQ4am1keE1jWTcy?=
 =?utf-8?B?OUE0bEsvdjB2b2Z2Z1o5M1J0WDd5Kzg5QXNaTnVDMERKTklDZGpvM2FweUhL?=
 =?utf-8?B?MVRKYVVGYUhrOGkreVc2VDZEODAyRFNEczFGbFluNURMWng0RFpNdW9QeXBF?=
 =?utf-8?B?dVlyVkQyQXdhVk5QbCtEbFduQ0NjRExiV0EyQS80QnN4QklrQlpJVDB0dnBo?=
 =?utf-8?B?cFBxaUVKcjRLSWxmUjU5ZXpXbHIxbndTOXZPUlJxK3NqY0JqbHR0OGRLNG5N?=
 =?utf-8?B?ckJVMjhQUWhZZm04bmVPYVpiK1VFUEJOanZJM0FMYzFOa1VDdzRqeUxhU2h3?=
 =?utf-8?B?czBPeDlDUFdEbFZvT2N0MjVDNFl2NXZjZUJ2REcrVktMQkZMcGU0d0RNVkJx?=
 =?utf-8?B?NnZha2RuK1hMUlFMaTh4eTBrWDlWTXpTSlpIa0IvaW5nWVlETERNaUdoN2d6?=
 =?utf-8?B?SHM4bHcyNW5Hdm5uTUdoMG5qOWE5SkhuR1BuNWdMUHpQd0YweHRCK0dPU3VO?=
 =?utf-8?B?bFF6eUFocGgrYVdhSFF3azRJbXhpUW5zdVVvWkhDUE5ZY2xUOTBMQ2J4VXNR?=
 =?utf-8?B?Y052MDVhbVlXVnFJNTR2TG5CZWNlTkdma25zbzNneXFJOHhXY0VhZkpYSE5X?=
 =?utf-8?B?UHFYSEduRitOLzY4czVHVXhhNFJtMkV3TUhWVGplSFpDWndHRG9FRnpRZncy?=
 =?utf-8?B?dE4wS2RUa3BadFl2ZjU3bEJHRG9BWDlmUWN0VDdaaC9tSHplSmY4ZGg0ZEo3?=
 =?utf-8?B?dGtyMlNzcjBhUGpubXVBMjBSaDVuRDdDR2ZsU0Y3T2pjL3dXU2dhaFFjVmxj?=
 =?utf-8?B?TWFPRGl6alBtYnBFeFM4VU04NnBCdkdxRXVoUnc4OEt0a3hBK2NhY00xT3hQ?=
 =?utf-8?B?RW1hTENjUTlOdzdCdmFVU2V6R1g2N2FxNXZaQXJHbm10QnJpQ09VZ0FqVHR4?=
 =?utf-8?B?TFhrRWJxQTRXWHhPN2dlLy9OMnROcGRvbEtDZnJKYTR0TWNRd09qbU9zVmZS?=
 =?utf-8?B?NFJtL2FCQzJLQ0M2aWFRc3duOE1XeU1xUmZCMVorK1l1OXdnNWhrRHplQ0sy?=
 =?utf-8?B?Q0ZhbnNqa096WitEVGFFOURNQSs3dHRWOE1XeDJwZTUxL3Jnczg2S3Jrb2hh?=
 =?utf-8?B?eW5uZmhoOFY0cS9ManUwU21ZVm8wSzFEWTk3TWpOVkhkN09DNEwyeDJTVE10?=
 =?utf-8?B?a1ROZGQ0cVNsYnNyZ0I3R2FTM0JxTnEzYUI5dmFsalgxWUl6dS95UWVKdmZz?=
 =?utf-8?B?bXZqN1BQWUdHcG9mV0JDZXh6anNzK1lVdzVUL1YrM0tuN1lvNGUxN2pSb0FI?=
 =?utf-8?B?dFpIc0RyZEZZYzZWaFJjTEZkVWg2c2pNTGx2T29aSjBiTHNyN0N5YnVZYUdJ?=
 =?utf-8?B?MUxXSHFlbEtETlkyR3R6dVhwUUdZLzROWnM4NXF1UW5yQUp1anBESWttWkxh?=
 =?utf-8?B?K3JoTnJlZkdhYk93dU0rTHkyQmwvbzlvbW5NOVIwM2JmTmJBcUNxYUJITGNp?=
 =?utf-8?B?M1JVbmZaM3RTRjRQdkhFTHl6dzQ3UU5XUzAvZDhoWW9DOWVackNueFZhTXQy?=
 =?utf-8?B?aExBSlorWmVISklvdWNBbEVwTzZBdUlIM1hLWGs0YjQ5SWVRcVdoU2d6QkFD?=
 =?utf-8?B?b2U3dURXOVhKTUNJMDA2djgwdEZoZkdDYnhWUlVkeWRMSS9DdTNzS3ZVbVBT?=
 =?utf-8?B?Y2tRbkwyMmFuZU5FaFFXMWlDVTNMRnRtemFYWVdVRktCT2h5Qm91Q2FOR05R?=
 =?utf-8?B?MVAzU0tXTlRXUWNkTERNdUhxSXFhM3c3WjFKR1A0OVBNaENOSVQ4UDhsQ2xN?=
 =?utf-8?B?UDQ2UldQRzk1dFdscjAyZVZUcHRFRGwzZ05taGNFdWpvWDNsMlB1ZVYyU01D?=
 =?utf-8?Q?nlnQPho2oWTzd9zY7tdv6zWWo?=
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Jv/Nl4eZF15INO0CJZq+acs2arjSXOAWoB5DkHeDxdEmrDdtAHfLg5wwIoGi+e/5q1XFMqokmhJEaYlzFpAchJP3AW2OI0kvleOuMqYBYnM94eG5OAm3mZ5sSGIkT0PPO3L8K1/AaDWH46QR6sMTeYcualCjhPQCH1UzEis1Ca81vsUTYwoyY0ZgugJzgQE2jfEQVIJMnThoQEVEiPFkuFb0DwePxQRSn2diQT+44N9znv8mY1vFoJ4zp+Chtyayepv/+Z77C3XDF0fIKe92amKoxLKiSXreiXI7YjhyBNAE7J1pkdjeB2/ekxzIEJde1Hn5ffdxGtVWMHiM1rYIbNSiZ/nARELJCNzOacZXPCb3G15Ux/6W8W3ratDgj+vw3iIW552Ldt2zevqd1ZsrTqVVQuDYXlDTcfRAGQSOgZVd6fMoCqlBNkZiXI9QqJUpXA8yU9hRkzDZNKsQkW5udMP8KjuIjD1lgttCJsHdqdonlHSZQ3wG31H0NJ59NJR+T2Qf0RPaYcfyNcWObm2eX0N7nzWIrYEQ1fb85W2XQuxrpfZKLgwc5rtdt07HWFnPaa2mshyKuFmMk1i2yt2cnpsJK/KtkAAFiJMliTtiotgDpX4L08TGWTPEB8T0xf6f0U213mCmUSSdV+K6XpYKeyBIxVAILubVB+I2rCneYH+tzF33eiFuV31LseRW3Yt3sOndMTgcwWcMAviFtFO9CK3IwnDBhlSLeXwEb78GJRlt1gB2N7eqbLZ48LnvbeNHQuduzOozAQUpcGyJ3XNL1x8jbuj3N0xFoGbn5wQNmkYaFOC3x6Ww66mzbklLSnOMSwiPqG/KRQnF2VQrJjnr/w==
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7f67db5-b593-42fe-fd77-08dbbd886cce
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2023 05:29:44.1239
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AxXJOQxXGtbi+1XTmUVwSegEnv5yM7fJtRpO4Y64YB0oaSj/qbcLXv/5fwr/CzUc+N/A34fYxh3xTe9gSDt8ZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR04MB7081
X-Proofpoint-GUID: qKdguk7lLDYX1VvpAuu41zKoy1jyX5P4
X-Proofpoint-ORIG-GUID: qKdguk7lLDYX1VvpAuu41zKoy1jyX5P4
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Sony-Outbound-GUID: qKdguk7lLDYX1VvpAuu41zKoy1jyX5P4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-25_03,2023-09-21_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

RnJvbSB0aGUgZXhGQVQgc3BlY2lmaWNhdGlvbiwgdGhlIGZpbGUgc2l6ZSBzaG91bGQgZ2V0IGZy
b20gJ0RhdGFMZW5ndGgnDQpvZiBTdHJlYW0gRXh0ZW5zaW9uIERpcmVjdG9yeSBFbnRyeSwgbm90
ICdWYWxpZERhdGFMZW5ndGgnLg0KDQpXaXRob3V0IHRoaXMgcGF0Y2ggc2V0LCAnRGF0YUxlbmd0
aCcgaXMgYWx3YXlzIHNhbWUgd2l0aCAnVmFsaWREYXRhTGVuZ3RoJw0KYW5kIGdldCBmaWxlIHNp
emUgZnJvbSAnVmFsaWREYXRhTGVuZ3RoJy4gSWYgdGhlIGZpbGUgaXMgY3JlYXRlZCBieSBvdGhl
cg0KZXhGQVQgaW1wbGVtZW50YXRpb24gYW5kICdEYXRhTGVuZ3RoJyBpcyBkaWZmZXJlbnQgZnJv
bSAnVmFsaWREYXRhTGVuZ3RoJywNCnRoaXMgZXhGQVQgaW1wbGVtZW50YXRpb24gd2lsbCBub3Qg
YmUgY29tcGF0aWJsZS4NCg0KQ2hhbmdlcyBmb3IgdjM6DQogIC0gUmViYXNlIHRvIGxpbnV4LTYu
Ng0KICAtIE1vdmUgdXBkYXRlIC0+dmFsaWRfc2l6ZSBmcm9tIGV4ZmF0X2ZpbGVfd3JpdGVfaXRl
cigpIHRvIGV4ZmF0X3dyaXRlX2VuZCgpDQogIC0gVXNlIGJsb2NrX3dyaXRlX2JlZ2luKCkgaW5z
dGVhZCBvZiBleGZhdF93cml0ZV9iZWdpbigpIGluIGV4ZmF0X2ZpbGVfemVyb2VkX3JhbmdlKCkN
CiAgLSBSZW1vdmUgZXhmYXRfZXhwYW5kX2FuZF96ZXJvKCkNCg0KQ2hhbmdlcyBmb3IgdjI6DQog
IC0gRml4IHJhY2Ugd2hlbiBjaGVja2luZyBpX3NpemUgb24gZGlyZWN0IGkvbyByZWFkDQoNCll1
ZXpoYW5nIE1vICgyKToNCiAgZXhmYXQ6IGNoYW5nZSB0byBnZXQgZmlsZSBzaXplIGZyb20gRGF0
YUxlbmd0aA0KICBleGZhdDogZG8gbm90IHplcm9lZCB0aGUgZXh0ZW5kZWQgcGFydA0KDQogZnMv
ZXhmYXQvZXhmYXRfZnMuaCB8ICAgNCArDQogZnMvZXhmYXQvZmlsZS5jICAgICB8IDE5OCArKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLQ0KIGZzL2V4ZmF0L2lub2Rl
LmMgICAgfCAxMDggKysrKysrKysrKysrKysrKysrKystLS0tDQogZnMvZXhmYXQvbmFtZWkuYyAg
ICB8ICAgNiArKw0KIDQgZmlsZXMgY2hhbmdlZCwgMjgwIGluc2VydGlvbnMoKyksIDM2IGRlbGV0
aW9ucygtKQ0KDQotLSANCjIuMjUuMQ0K
