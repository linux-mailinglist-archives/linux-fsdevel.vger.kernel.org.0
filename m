Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 073F97407CF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 03:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbjF1BxG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 21:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjF1BxF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 21:53:05 -0400
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CF9198
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jun 2023 18:53:04 -0700 (PDT)
Received: from pps.filterd (m0209320.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35RN1xoY006382;
        Wed, 28 Jun 2023 01:52:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=S1;
 bh=WysguHm4qgjGifxmyPEPmUO9Eb+ftQvT56vRiBwOEeM=;
 b=RtLlyHvcUruz7Dh1OxZQCXPfiyqlaj8d8G0wz8PRFqzahCMxjgszClRVNa+HB9AFfjGz
 oQqlz9zCKlPgVo23r1YrwslkFw4mBA764GevPSaj4G9rLNgJMuMJFNo6TWDBQoUuDJb0
 RUBoiRSCL9R11locXeGdhlj3350eVkp46O4jKYbN8PVeXFalFSp6siiQ+U96VoiozKCL
 oZ0sxTAB+Rwb+2OS/ZNP7jvNTFOTbhbTNmV0+E+9jWVEbkffVnGcHygtPtRXtglU5ma/
 L4innShXICMVDoBsmkBh3miG61fdUhwfrUhUl5nifSblKV2TGE2eL5Cov72mnfQltLV/ pA== 
Received: from apc01-psa-obe.outbound.protection.outlook.com (mail-psaapc01lp2040.outbound.protection.outlook.com [104.47.26.40])
        by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3rdpcm3kb3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Jun 2023 01:52:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A8ZdYfi3m6MpmaOq6yShqiBDlSND6ckqUsHq6SMkBwnmItTBbF6rpC/rnJkuJJWG3keTVS+mvcPfxK/7wXv1G2X986EzqINDVQYm0hnSRBsTdffpt8gUdylMsZKv2BAVF2PNtRBsHbdDjAQo4DCWU7zkbE0Ta3fdPW9u8pZxTeCn/HxgyZdKvDYtCNmGCa/+eoEEfBDewqYQoextZ0OdeqcLH4w7v5sGOr5psGTNaJj/Ip/T2wVZOETDWRvZkPEIU1PwmIgaH7Cy3/+652OLQZJ6IYrBfjzZeCZSPiOlRBgmqYY3qqZwLcSCrdeFRB67T3tDZMN7OcopPGYru04XqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WysguHm4qgjGifxmyPEPmUO9Eb+ftQvT56vRiBwOEeM=;
 b=MS9dJPTRYDFS7A6+05HeoBwskK6K8x/8RRz+y2tmgbze3HEWdVHtZd0PK54QwPu390sSCZ1caUqwyOd0A3Q4awrxVFQQl7zhqUijCWyXxLkQ6vGRf2AGqaIlqRhzkzIP3Pz1fTCqyUe8DSDgSh2HdV99h4btrUHcLk8wGlYVJmg4UU8Y3+sMvK66n1oabaomzOGTeAZTPJnYX2Ndai2ENS4SFV9Tjjsm1ST7MYEaCBkbXqs98f7sLuBO+gqX9I3kP0fzfhlh+8rhwIjNSSkSc6HzdBBBSEZ0icEnj5b6xEZKEl+2ZdGqRxuM6t4gss/gAbrPiVNhiHA7bkS6owEs9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by PSAPR04MB4389.apcprd04.prod.outlook.com (2603:1096:301:3f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.15; Wed, 28 Jun
 2023 01:52:38 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::ce2d:a9dc:4955:5275]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::ce2d:a9dc:4955:5275%5]) with mapi id 15.20.6521.026; Wed, 28 Jun 2023
 01:52:38 +0000
From:   "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To:     "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>
Subject: [PATCH v2 0/2] exfat: get file size from DataLength
Thread-Topic: [PATCH v2 0/2] exfat: get file size from DataLength
Thread-Index: AdmpYryl/FPuaz6xTw6KCAgAPNhv/A==
Date:   Wed, 28 Jun 2023 01:52:38 +0000
Message-ID: <PUZPR04MB6316F533D28ACDEBDC20BD3C8124A@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|PSAPR04MB4389:EE_
x-ms-office365-filtering-correlation-id: 6efd5a8f-b2e6-4bb8-2c48-08db777a5a2a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v9j6yOYRigQLAmwiEUQ0q9cTl2HRg/YBxWUsD+bAZkjA+DR+lOG4xSEHqwGOCgP/Z1lRXWE8TAxwXS332ftKuN+TlABubPA2+gvQosH4kGT3WeGDsHWhzRtSBK0X0Zq/2RZ+awxdGSjH1lyCgcKbEl6KlwVE65GUDQDhbA5C0CC8IJmiFAxAtJ3QDo+ByX1ShsRco3UqSuj8cybV2agKU3bczaKBEeZqghIwMDM8Ud1iHeHPMQhO4VXcCNqSfnlJdKc4XYxS0h6GmwaV/TxN+dA1SUxofVqU4Ixscq/BlfAwkmfm8ZlPD/Hz8R7f6JlFKhunyym8n6M6ygCmoI1Ray39YpebxSj09QNdmk0u+j+Svisu7rcABhphLnrshcgEG0XpdvMo+AnqQcIrek638tem0YT/DuUm9mPR2A5pvKc05Lq22jinmf02EPLE4aQJ7RvxLa1nMR1E0r/W7ZnyQU4CTBi9/dxWv7hDyBCIGjuzjyGK6rKaGPSxCjcRI+ok1orzL2CxtpO8Buhgn7uPPHOBFtohyOrrN6Pd0OwxvGO3Zjqbzwccyjv9/oJkGU8j/arWoa9CtuRaNA9QBop7kNBsczV2D/b6Ma+RqFRL+CPB1irwj3jll0MQjW42bYyf
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(366004)(376002)(39860400002)(451199021)(5660300002)(66946007)(41300700001)(52536014)(76116006)(64756008)(66446008)(66476007)(66556008)(8936002)(8676002)(4326008)(316002)(478600001)(83380400001)(38070700005)(55016003)(26005)(6506007)(4744005)(2906002)(33656002)(107886003)(9686003)(186003)(54906003)(110136005)(122000001)(38100700002)(86362001)(82960400001)(71200400001)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MW4valJtOHFtd3pHckFHdDlwa0xmVDBJZnlYbWswRE1SVVZWaWR5czNmM01N?=
 =?utf-8?B?aFNSeXZLT2hxaDNpbHpCeDB2eFhUOEZBb1RYaitkdkFqRVBZL25vQWZXeFZp?=
 =?utf-8?B?YmNjUFdUTlo3RmlORFNwYXBNWFZ2M1NiakZxb3hxTjkwZVAvQ0d1VU8yMFcw?=
 =?utf-8?B?czJkRy9mcUFBbm9abDlBeXM4TGc4VzM5bjFhVmJFaGtGSmhWb0tYeERKd0I4?=
 =?utf-8?B?cEpPWnYvMnMxRmJKRzdHQTJXNlp4cW9mYnpOTTh5MXJUWlA1djFMa0xsSDh3?=
 =?utf-8?B?ZjVVTTcrL2U1OVo3NTdnTVByUk82K3kwa2tMK0kxSUszUGQ5enVzemUrZms5?=
 =?utf-8?B?S28vWWtqeDUyZ1NTa0VnUHJ1SmFrYW5RbkJWRlM3S3YzUHhMbUc0WkJhK1Vv?=
 =?utf-8?B?UmFoM011Z0FSRlZ4Sm9UT1RNNXBEbTkvZGVQNFNhdDEvdEo2VG1GalFEYmFy?=
 =?utf-8?B?VzJpaHQ0UHIwQURJR1RmdjNQd3ZESVJYUCtTZ3dndXRDaXk0Q0hwRWRWbUsv?=
 =?utf-8?B?bVFoeVY3cG5zNFcvS1pTZXBoVDhuN2hTSStEcGwrc0hoWkttdGcxeXJYeFRr?=
 =?utf-8?B?cFF0a0JkY2tBTndUbm9YRVN5SExROTVyb2hXWWhKeUhWclZKMllROUNmUXZx?=
 =?utf-8?B?V0cyTjU3NUttai9NbVgyekJ2SVFjbjNaNVNCeCszVlUyN3FYc2NNMG5Wb3Jx?=
 =?utf-8?B?ME5ESnNsa01nUm1MTWc0TjQ3WW8vWlNreW5ZYTh2OFUxL2hEeGlkN1NsSHFH?=
 =?utf-8?B?QTVqbXRpdUwxUXd1STFkTmZZNUs1Vk11SmJtdk1IMWJCUHNIT3c1YVNTalUr?=
 =?utf-8?B?dGdlZXlpY2tnVm1VckpJU1BrYzc5VzJlakNuYi9TTzBIbC9lbnJPZTdacS9K?=
 =?utf-8?B?eGpNTElEWGhyd0R0c1pBais3MCtKeFdycWs3S3BLZnVqQ3pONE5nTGJzME1z?=
 =?utf-8?B?dWxUKzNBbHExYVNrWmFkMkhlMk9zM3U1eE9iOENoSjMwQ0F4NUpweUUrbCtL?=
 =?utf-8?B?WHFxVWg1dDkvWWloN09RYmNZbnhkYVJwL3pWbWcvU2pvWFpCT0ZqM01xcmZy?=
 =?utf-8?B?aWd2OWR4RHhhNjBJVTZBRndwR3JXM1Q1MVI3R1A2VTNNQlE5WnZOWkdTUmtZ?=
 =?utf-8?B?bTJIUjMzTDV1UkhKVXBGNzVDbFAwT3pYNSt0aWFEMi9ORVE1WlhseFJLZCtI?=
 =?utf-8?B?dG96UHFDdG9CTm9kVGtGMmRpcVliaDJiQWZxS3RoQjlrNklzTVRyTTdoMU1Z?=
 =?utf-8?B?dHlNeU1OSUp1QS9hZys5cWhndFlWa3M4UVMyRUxYOElQMTBIT240dDRmSWYy?=
 =?utf-8?B?OS9yem90WE8wdFFrOU90UTdEODFaVlVVdjlNMkJRek9mdjhsVjB5MHVPVzZY?=
 =?utf-8?B?bW5vKzRlOW43TVU1ajJkbkpNcVNrSVEyWHZGdTdlaS9KaktrdUhHK0NmOFdt?=
 =?utf-8?B?OWpTZnZIeW1GbWMrSkhXNSthVXZabkwzMnJzWThUWko2ZUVaUTcwZEdGTzd5?=
 =?utf-8?B?N2Q2dU1LRngyWklraVlLbGk1cHlHS2dBbjRucElGVHJMc2lhekw2MFBDMUFj?=
 =?utf-8?B?VVZ0d0xkbUFOUWZCN3RrSElLRDhwZ3Z2Ky9mdmtZNExYYnFDeVZBWE5BV1Fw?=
 =?utf-8?B?M1lJbWhXZUVxbDRjaTZOV2M4T1RYMWdybUlzQXFESW1aR1dsQm13OFZuSlBG?=
 =?utf-8?B?OW82ZlVMaXdGNkg3WnRITjg5bmt1S1RQRHJaUWM0b0V0Szg3bit2ZXREOWJy?=
 =?utf-8?B?SXQ2MzVtZlpqWm1tckVQNjdsV1A3bDZMRW13ZWhmSDVtdzdEU2hFU1BpM3BY?=
 =?utf-8?B?bGRGMmlPZmhKNTNNN3d4VmFNQWVOWnZBRHAwN2tldXZIbld1T3pJMjMvQjdi?=
 =?utf-8?B?TFVyVzhiYkFHWjFuWjZBV3dxZlFqKytmUFVWcGNRL3pURFNJUHNLWW16TVh3?=
 =?utf-8?B?UFFUaEQ3UWRqNE15YlFwYnJxQ25uNkdPTG95RGJkVDEyYml3aldzQ0hhR2xI?=
 =?utf-8?B?ZldPcm5wRlB3ZjhQTisrbjc2SFVIa2JmODFaelF3UWVya2E0bDA0R25FaXI3?=
 =?utf-8?B?d0ZnTDBwcVI0QjdJWTBiNHdmanZHVjMrWmtDZGl0WGthMHl3MXR3RU01Rk0z?=
 =?utf-8?Q?YBSyA2bekHZ+YxenfuiqQzbgn?=
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: x8l4GBI/El+0lcAZTDrG8ziZmM3howAWhlrrfYKNDdmUrKmcHYMJfZP9YAGQCeCcJb0dYqq/B292MMcYch6tCv50lGaK8d1ezYFC+Y9nIUyzxk1Qh4l3PuxlduCbvn5aN/U0xLo/EldjQd/NJnfZMbHA6w1MUJjrF+eF1fPk2L7Nwrz4v+1hbXWPtwzTPSUj4m/B6DSWCaSta9xS6YH9khsHwx4WTyxzro8EclMG51hfK7R3m+yhvGwGzqUqqvs2uwk9eENGYb1pfTZn9VjTT9LHmyj2xmjI5aFThAOMK3fmw7nInI/ms61e2MZqd9/wX/DnNqoIwDt2xqx6c/WdTzduRUG4AQ2/0PzmFnq3LTnC5Q2vwRyAZsuXh7Z8f1qAKxZ1JlZIDDgYPX+XdNMiAxwBSMSnkcBQJ01zkec3ApUwGPQn1lnq8OQjoq1yeXdnv7ehuOywt7wSxGk003DnLFrS+MscAVw9PxY2stv1thlHGOCDZlxIG2PwM9s6MjKME8b7o996OWC+PrxCCT8nw84mqkLXtjpu8qWgXUIB8YcgNRFD5LdtAJQasYSEBU209Z1hIJ0sUgpn61XHNz6TXowJUyb5wBiSpR2vC1xUb5BkKvft2MiF3exqJjjyHx6RqrjQsgAziEdEq0c415NULH0FX3+h4L+YdfzsOaXjpsBHZBbatM+HOyDvQ8y9mXKnxyc7VLpjtPd4WAHPSdP6QGSvuibAptlgDA6eTqycaiZ8W8aVZqtMhwgndlzVDHu1QNIVciM/qRmzhsYGrd50SGiACx3f2lKNMhfXnVGHSnq9qHNHIETJtfP3A6x8j1dyJxMZcvW3qGcD+5Y0tv181A==
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6efd5a8f-b2e6-4bb8-2c48-08db777a5a2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2023 01:52:38.5054
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zJY0twltOBCAcvYhKsuH/8/Sqj//g52caW92t7YwBOG3g+fcwqxORx0pE7L0bOkH36/iBOxt6uL2LW/b8U23Mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR04MB4389
X-Proofpoint-ORIG-GUID: PvQdB2lkqTMSO_aFhfnzysGR7Rl7607H
X-Proofpoint-GUID: PvQdB2lkqTMSO_aFhfnzysGR7Rl7607H
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Sony-Outbound-GUID: PvQdB2lkqTMSO_aFhfnzysGR7Rl7607H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-27_16,2023-06-27_01,2023-05-22_02
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

RnJvbSB0aGUgZXhGQVQgc3BlY2lmaWNhdGlvbiwgdGhlIGZpbGUgc2l6ZSBzaG91bGQgZ2V0IGZy
b20gJ0RhdGFMZW5ndGgnDQpvZiBTdHJlYW0gRXh0ZW5zaW9uIERpcmVjdG9yeSBFbnRyeSwgbm90
ICdWYWxpZERhdGFMZW5ndGgnLg0KDQpXaXRob3V0IHRoaXMgcGF0Y2ggc2V0LCAnRGF0YUxlbmd0
aCcgaXMgYWx3YXlzIHNhbWUgd2l0aCAnVmFsaWREYXRhTGVuZ3RoJw0KYW5kIGdldCBmaWxlIHNp
emUgZnJvbSAnVmFsaWREYXRhTGVuZ3RoJy4gSWYgdGhlIGZpbGUgaXMgY3JlYXRlZCBieSBvdGhl
cg0KZXhGQVQgaW1wbGVtZW50YXRpb24gYW5kICdEYXRhTGVuZ3RoJyBpcyBkaWZmZXJlbnQgZnJv
bSAnVmFsaWREYXRhTGVuZ3RoJywNCnRoaXMgZXhGQVQgaW1wbGVtZW50YXRpb24gd2lsbCBub3Qg
YmUgY29tcGF0aWJsZS4NCg0KQ2hhbmdlcyBmb3IgdjI6DQogIC0gRml4IHJhY2Ugd2hlbiBjaGVj
a2luZyBpX3NpemUgb24gZGlyZWN0IGkvbyByZWFkDQoNCll1ZXpoYW5nIE1vICgyKToNCiAgZXhm
YXQ6IGNoYW5nZSB0byBnZXQgZmlsZSBzaXplIGZyb20gRGF0YUxlbmd0aA0KICBleGZhdDogZG8g
bm90IHplcm9lZCB0aGUgZXh0ZW5kZWQgcGFydA0KDQogZnMvZXhmYXQvZXhmYXRfZnMuaCB8ICAg
MiArDQogZnMvZXhmYXQvZmlsZS5jICAgICB8IDIxMCArKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrLQ0KIGZzL2V4ZmF0L2lub2RlLmMgICAgfCAgOTIgKysrKysrKysr
KysrKysrKy0tLQ0KIGZzL2V4ZmF0L25hbWVpLmMgICAgfCAgIDcgKy0NCiA0IGZpbGVzIGNoYW5n
ZWQsIDI5MyBpbnNlcnRpb25zKCspLCAxOCBkZWxldGlvbnMoLSkNCg0KLS0gDQoyLjI1LjENCg==
