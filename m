Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B132A730E0A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jun 2023 06:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238202AbjFOEWk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jun 2023 00:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234125AbjFOEWi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jun 2023 00:22:38 -0400
X-Greylist: delayed 3190 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 14 Jun 2023 21:22:37 PDT
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC5B61720
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jun 2023 21:22:37 -0700 (PDT)
Received: from pps.filterd (m0209321.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35F0ZIUE003698;
        Thu, 15 Jun 2023 03:29:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=S1;
 bh=LKK9CJ3mDtQ1Fj34PpAuFjhjhOUeIM/8rShic0UMPn0=;
 b=hiEbB7PbJ6xZkYRw26g9JLhXLPCbtOXOsPyEj2uKcKj37oOmybwPQ/Yh97uwfk8tpv2q
 GumBvEKXdLsAi/rk8uh9d6GdhY3ERBvU1CcPe1M4d8LMxNBV4A1AdvgHxA1bz2X3jDKl
 VY4lSDNR4Ft5JjRjb8m2lWD0aM6aIXmRwFp6ej84Ex5a+rsWjqh9j6qeRMf4zH9bx2z1
 Exxdu7iud8S54zDftIe6ta3wh6978YqJD+SQkEXQXVHgF1d8lwfm8Jmg7jw11oxrP4cg
 vZWWPKcrcuur4gYV7PaJDePX5/rCXwJbYJY1uuXaVibqfDkLrks4MUhPWqZtpFcZD8+0 ug== 
Received: from apc01-sg2-obe.outbound.protection.outlook.com (mail-sgaapc01lp2104.outbound.protection.outlook.com [104.47.26.104])
        by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3r64q1u2gu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Jun 2023 03:29:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zmlvp+ZdYy9dFYT7MraSsqEEs6vItE+nFc5nf/cg6Q7rvJhLMvOc0GTKk3LOrS+4cH4VpfY2tN0/mjrTwsR2y0+eoL6emdyJPC1zLWct4lCDHXAvLeVhZiwAIrVqbvRy0lGJkwWPRcpbS6OK9ckB4IVvUVBXoNARxFQdsCH/nh2m54/2iF9Oc+1d3FjsRevXVmodY6/OqcwruDg6M625AruJnK9soXk4zVANj3zG2QgHSwjMmQpFpT+HKjCWcuxd54KE8w0Q3PaxGd8atAl2xepbfw5dvMJHny/zxgD82Zu54HVQm82NEtzJF1VsTmPXWh8G8NI9uBscKdO4oRs/hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LKK9CJ3mDtQ1Fj34PpAuFjhjhOUeIM/8rShic0UMPn0=;
 b=GnjpVA4eik4hDrLKjsIJN5mr6cdPB7XbkcU+3v3PHSLrOOCgpvE22gdiUiVuy9BsWm9RiXbFToy0VX5kB1PnFBNe7jxzGePXu+knf0syq1rw1Na4QVoO967l+PnilXzcXao5JbxPpFPlsDpTw00NZa6o2x9VqTiGs9AWe9vwVeuq21z6hGoY22adaK7PChNk+cmRBaXqYo7D15j/Q/e6WELGCCr6+i96QvUF8g5cR8YBHLk71FXY+qL2MY/Sr/uNcmW4VkLBgSIJyDSwVNzmCt+W6ze0GOB5cQavSeWnGwRm3JG2ZEJJqurKu1UKhm+dhDUSGgGApzFV2GFGyBu2Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by KL1PR0401MB4212.apcprd04.prod.outlook.com (2603:1096:820:27::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.25; Thu, 15 Jun
 2023 03:29:00 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::ce2d:a9dc:4955:5275]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::ce2d:a9dc:4955:5275%5]) with mapi id 15.20.6455.037; Thu, 15 Jun 2023
 03:29:00 +0000
From:   "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To:     "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>
Subject: [PATCH v1 0/2] exfat: get file size from DataLength
Thread-Topic: [PATCH v1 0/2] exfat: get file size from DataLength
Thread-Index: AdmfODMxTKFC/pCyRPukKkKvxSTr0A==
Date:   Thu, 15 Jun 2023 03:29:00 +0000
Message-ID: <PUZPR04MB6316DB8A8CB6107D56716EBC815BA@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|KL1PR0401MB4212:EE_
x-ms-office365-filtering-correlation-id: a47adf70-02ff-4d63-d0ac-08db6d50a910
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: A/bOUdm8pzNr6QepZzXJc2xshkdY0x6/F1UC0Mg+LC0+GUWDFepgnPbWlFz6MbrqQF9AYQR043UYs0CtEj9M9NKKOigccruVHqwLCjHMQyXqkd8vxTe747rkG8f4DM+0XlP4dCRD2IC5JbyoMmCJ7kyTnMwOMzHulb9g36PM+Dl/7w6m3SYPCoqBVCx1HkLqOXnpGuu1fvkf3xJO5bjE26mvpoI7yGOkF+94JCH4otko4nssmmnd8ps57o3utQrABRShsHrZybpTpt9tLO+JvtIXvs8OdxmoTHWm8l/mfFTBy8506S4ZYoH8LKh1rBsG7wY/6Cs21APr5YtW24frpUzWIkMoROexcDMxSJIksdC9dVGX0lgwVPsjhtBclfyMlEQwxBziOqzwSMeP6tFUaI/pskdK3um1NSEKDcDlgQnx4TaZZQvkkJ1/suB+ucFOw4KadNbY8RHICPK5QfM0owA5Z+eWmP03QVTd6hGBhn1qsR0ErA3YgNyH9T/Oh+okh1OX725lz043DKyFvK1KaR4HJOiHsTYnQqlqhgrwHDsM+gU73DjbFvGt5gu6KVrXT/3EUtnnQ4k68cOdOLNUh162hD1zAHEIKeX5udkR/cHF4T0+e5wzp/FPoCC+zf53
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(136003)(346002)(39860400002)(376002)(451199021)(76116006)(4326008)(2906002)(4744005)(86362001)(38070700005)(316002)(64756008)(66446008)(66476007)(66556008)(66946007)(41300700001)(110136005)(5660300002)(52536014)(8936002)(8676002)(54906003)(38100700002)(478600001)(122000001)(82960400001)(7696005)(71200400001)(83380400001)(107886003)(55016003)(9686003)(26005)(6506007)(186003)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TnE3a0svRm40M2IrMzRmYjIyaXQ5SXNDVjNoUFNuRmhvaGxRU2tHTDgwRFJq?=
 =?utf-8?B?OFN2K2xIYVVrTWc1aDNyeGJFSGZ3WXVHR0Voa0RWWFhQNDZYOHcrRE1qMzRG?=
 =?utf-8?B?OTFHZ0h3Y1hwWjNQenRvWjZnb1I2UnBvY1d0WERXRmhBbW9pVFc4NVFsUCtX?=
 =?utf-8?B?VFRFYThSYnBGVWVPNGJsWjNtQ2FrcXY3ZE13WnJOSnJTd0lkekpYRUFqbFV2?=
 =?utf-8?B?b2lydTBNQ3UwSDFoSWN1TkVqTmkvZGZvTlBBbk5YSWI1T21obzJyaXh2SGZj?=
 =?utf-8?B?Y2hmblJURU5XRUVhbGJHRGpjRXk5MTBSdk16bDBSL1FHUGIzd2xQdDVabCs2?=
 =?utf-8?B?SU42bmtiYkNsMjFHbmdMRHpHaGhLQVZBUHM3TzVEZFJGQWdPRy9oZnNaVGhw?=
 =?utf-8?B?WHo5R2NyeDZsMmM3Y2hqQ0FBWjVjU1BhTXZ0NkFZMEhsQ1R3Zmk1U2VYei9l?=
 =?utf-8?B?VXNWYjllcklQUFppUEkwZUR6a21JS0FKMUNHSUNTbEUyNXdhZkVnWisrdWlW?=
 =?utf-8?B?bnJNZDM0TDJKYkdSMGtGUVdHMTltdnVrd1F1NHM3SklyWjErUmR3QVIzZEpi?=
 =?utf-8?B?dExHUmQvTmdJQWtLQTdoeldDMWtITTBvNUdXSlc0K1FURHFVVzJ6SnAzaFA4?=
 =?utf-8?B?N0RuWHhteUorZWhoYmZnZTdPNng2K3p3Q3BndkMxdFN5U2R4Vld2MHlmeDM5?=
 =?utf-8?B?aWcrd2UyYWNWcjhwNzlHNDFBT204UUFIdGpVRk1VWVJYb3RsZjI0UkhZczI3?=
 =?utf-8?B?b003c3JvcWljeE9ndFkyUG1pVU8venlBbUd6d2hnZmJuMHlkM3FOYTZzSXpk?=
 =?utf-8?B?cnBKVUhGbUh0Yndud21BOTl6TFJsall3S1ZtYUdkRmdXSjlHL2FRZ0NtYlhU?=
 =?utf-8?B?RVlZbU0wTlNSODhLdnRycmtJV0hVcVJKMStYcEtIWUcxYWxWNUxnTitJbk9z?=
 =?utf-8?B?Ni8rdFczV2FsNW52U1ErYkl3bmFMWU5aWTVoWGFsblZWNldab21xbktqY2JZ?=
 =?utf-8?B?WWVSVWlCNWc5Rk1pSEtqSWFZcTA0MEVOM0lZRm5CWnVRY2RpQ2ROMUxpYXVm?=
 =?utf-8?B?R0tCSDk3ZnJFMjB4V29JL2V4anNkMHlFdmtOa012UGQweHk3QkNVLzhvd3ZR?=
 =?utf-8?B?N3djTEhzcC96U3JYT0NOSHFUM2U3UXU1VitXMXRwYVUrcjVhZ1VFME1YTHVT?=
 =?utf-8?B?TDRyejRXRmM3TzFOSmR0aC9FcXFzZk8vazZMSHppd0J1M1pCandsSXlHRVZt?=
 =?utf-8?B?ZUFRWU05VDQ5TmNuRU9aRm41UDB4TFJSMVE5MEE1UFRFTW5zYmFRYXpjY2V2?=
 =?utf-8?B?RkF2WmdTbnBWM2dlbGpvSDVwOUNZNWhIUkU1QS9RMWk0WWJCOHdjZkViWWF3?=
 =?utf-8?B?MXlUSXlXdGVvRS9ETDFFQmdHdEhEK2J3aHBGOHFJaXBWaWplYVBRSjQ3WkFK?=
 =?utf-8?B?cE1PcFpoRlZLOTdlNmV3Ym9OdFBmNzJGTTg5YVpNL2R2Nk11dlVmOU9WUjRu?=
 =?utf-8?B?d1hmZ3RXWEhhN3NBd2kvbFc4R1NlSGo1bjdRbFY1eVF2UHJ4RkdBNlpVb1V1?=
 =?utf-8?B?Nnk0dU92bm1pWXhrNmdRcUxBZFZYRmV3blF0TlpRS1liTTNmbnZXRnlPVWZZ?=
 =?utf-8?B?UUFkcld2NDNURXJOcXg1ZGdlY1pMTEpnMUhMM1NOcDFtckk4bDFnZUVZM3JK?=
 =?utf-8?B?NmI2S0UzT0xlS081bVNJdGJGMi9ZTGlVNTNGcVRIelhyay9iMU9GZkErRGlh?=
 =?utf-8?B?RnZrN005ZW4rK2pRVHFyQnEvTVp0aG9WOVhUeHd4QXJqNXJid2ZTd2RHczVm?=
 =?utf-8?B?M3dKdElaYmJkeG5HNFppZUdtQzFtTU5Vbm5saWFjTmlKTldNdExpVHpWLzBL?=
 =?utf-8?B?alJQQzFzQ3hHQVdQdkZLVWNWUE9yQ2p0TldiaEdONkEvK0JjSzVRNE9VaEF2?=
 =?utf-8?B?QVBHS0JSOC8xWFFGY2p6YWtjdFhDaU9Kd0oza0xiaDRjMGhGcWdmR01uakF4?=
 =?utf-8?B?SE5lOEZ5Q2hXOStoZTBRNWxJN0JoeHZFeitsVzMwWGhteXhLSk9PTWNobDRC?=
 =?utf-8?B?bzl1SnVWMm10MWRyUXlsT3RheUc3UEFqdWhULzMyKzlMcmtJMDhBcUxFNFVB?=
 =?utf-8?Q?qWRD0fxQKhhyUAxvgzizfjxhe?=
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: txVe7GSxE+Ygk9/7mEIISp6/VZ8Nb3CUWB/wVY3uEo1v9srohrqw7ktn2mRCRnQww9kObXppLLAJdShWG/82kh89TREA3MH5tdskFHwnkHHORivX001b9FF455O7CHKsus4SuqG0xYt9K4klaLtk3sfjQ2v/rBOR/n/BHG3uJcxQkgKJs0CQamEn5Rp0ZaZZLe1Mm+rtOkTBaOPEZTB0LMF+5CrlGSKI7g+mQ4S0Y2T/GOC8aJdMShEhJQ3+PSUzUuWLDoPE7dea5dPPy+czWJHEqo1E84BHLjrV4DISg2AuvX9B6nfelZ28PQ04q5K2OQIWqt9nPlZzkpEY4po4HHlblXo4SR0UBGB+HDvG6mwX9xGEjXtl1aG611FAbCbRL9biLJw/LSx0gYR2HNC0yCLzbgbvVDkeS3Zd0YsZQBTW6awTT+LOlEpmcndcTgKD4kVFs0lpmuK50omqURGntarz9iRdb4dNUdOsWYVtVPLcWRKxZX3ZOZK/ffcdh9S++AH71ZjQN353AT4pH/v6nUk8CptK3pRnpw4m6R5gGqKXxnC3ubPeO9jZYWMviBFmFiZgJgDlB9mcxk8bs+rFtcZ0fwtJdkGlgvH1Gd6GKyYAZtrpnDY8EchP7C9kxj6UHkdpBPvqVyl1SqZP2f7157ANNuz/EFR6H4SQ2ax56zPzyGK9mKhfb/h4bR/r612nbEy1IuGl2k4S5pGJFMk0ZD5xLvKgC5hJ5Yxjk6mbIMhNlHup1+jKPM/+ZW/5UF39kB7uyfyK7B06o5OBQTFjoIIFWNqhF8no3op9hfiN7Ok1SDDQClUDKyiUXtsxdKB6YQi5eEnfSROTZzxJOJZ6Lw==
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a47adf70-02ff-4d63-d0ac-08db6d50a910
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2023 03:29:00.3764
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v+p9adcJ0kKKPJtZfQqeRDLO8EjLIjh+D86wrl3ZY6syadS4JFBblVpOR9moWDUZyModPTKszC30F/swTHVyRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0401MB4212
X-Proofpoint-GUID: eVa9Ews-bTTxPtc04NjfjDgtq_tbT4Bn
X-Proofpoint-ORIG-GUID: eVa9Ews-bTTxPtc04NjfjDgtq_tbT4Bn
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Sony-Outbound-GUID: eVa9Ews-bTTxPtc04NjfjDgtq_tbT4Bn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-14_14,2023-06-14_02,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

RnJvbSB0aGUgZXhGQVQgc3BlY2lmaWNhdGlvbiwgdGhlIGZpbGUgc2l6ZSBzaG91bGQgZ2V0IGZy
b20gJ0RhdGFMZW5ndGgnDQpvZiBTdHJlYW0gRXh0ZW5zaW9uIERpcmVjdG9yeSBFbnRyeSwgbm90
ICdWYWxpZERhdGFMZW5ndGgnLg0KDQpXaXRob3V0IHRoaXMgcGF0Y2ggc2V0LCAnRGF0YUxlbmd0
aCcgaXMgYWx3YXlzIHNhbWUgd2l0aCAnVmFsaWREYXRhTGVuZ3RoJw0KYW5kIGdldCBmaWxlIHNp
emUgZnJvbSAnVmFsaWREYXRhTGVuZ3RoJy4gQnV0IGlmIHRoZSBmaWxlIGlzIGNyZWF0ZWQgYnkg
b3RoZXINCmV4RkFUIGltcGxlbWVudGF0aW9uIGFuZCAnRGF0YUxlbmd0aCcgaXMgZGlmZmVyZW50
IGZyb20gJ1ZhbGlkRGF0YUxlbmd0aCcsDQp0aGlzIGV4RkFUIGltcGxlbWVudGF0aW9uIHdpbGwg
bm90IGJlIGNvbXBhdGlibGUuDQoNCll1ZXpoYW5nIE1vICgyKToNCiAgZXhmYXQ6IGNoYW5nZSB0
byBnZXQgZmlsZSBzaXplIGZyb20gRGF0YUxlbmd0aA0KICBleGZhdDogZG8gbm90IHplcm9lZCB0
aGUgZXh0ZW5kZWQgcGFydA0KDQogZnMvZXhmYXQvZXhmYXRfZnMuaCB8ICAgMiArDQogZnMvZXhm
YXQvZmlsZS5jICAgICB8IDIxMiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrLQ0KIGZzL2V4ZmF0L2lub2RlLmMgICAgfCAxMDggKysrKysrKysrKysrKysrKysrKy0t
LQ0KIGZzL2V4ZmF0L25hbWVpLmMgICAgfCAgIDcgKy0NCiA0IGZpbGVzIGNoYW5nZWQsIDMxMCBp
bnNlcnRpb25zKCspLCAxOSBkZWxldGlvbnMoLSkNCg==
