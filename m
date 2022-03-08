Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62CBA4D1545
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Mar 2022 11:56:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346050AbiCHK5O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Mar 2022 05:57:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346001AbiCHK5J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Mar 2022 05:57:09 -0500
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A14B434B3;
        Tue,  8 Mar 2022 02:56:12 -0800 (PST)
Received: from pps.filterd (m0209323.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 227NQEsw027486;
        Tue, 8 Mar 2022 10:55:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=S1;
 bh=Gq5fIWzsGKKqS7kb9Uq4GLpaWFSqhsix/a90y41TefM=;
 b=L2mJVuVBJj8THB71nrCLy3yvXfvf5F8nol4HrJyEj9koDjoh1M6BBmI3NI5Ytftz+EVz
 DFcjiiilQJjVxcGCdOYucmEFIMzQALs2agGjEwQ066JxgMhVhqhQ+3zrs8dIp8awCIx2
 r8Ws2Ni4SL14RrTGZlfvpu0yeb1Z7FiB+uMy8NQl0slabj80hPnB2g/4mVS9qPo7MlSl
 EDpxiYb/iiSt/oaq0qVyRcopBiN6hkZhInF51+cUXkn4nH7jlW71/oF/wICGVmL48mtU
 TMyS3wqaBEejXXRCsEJRrf0vChaD9DIo4EJemCo0WL9XRcOmvOcKoZ44wIOsf58xRJ16 nA== 
Received: from apc01-sg2-obe.outbound.protection.outlook.com (mail-sgaapc01lp2107.outbound.protection.outlook.com [104.47.26.107])
        by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3ema7kjbcc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Mar 2022 10:55:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nm5u/WmEWrpiwZUh70VhBgFwpiNfoDH4vaTIMY7kmvA2ikOh7xqu8NMJTxsyY5wMIVl/qKxeiX8md6lEs0DD1d4YCY4GfA63OQZY3NI2FsQloHNHBtIZb9H5FuXKgEEy3YNWpmp/VgMQONjwZhMj7wKlh5s+YHmslb8FvyeaptIpTT8vx/KcnSmQc0iiuk2MUeCcv6uKBp6UrmKNXcWwGkmrsONpuXUwEuPn00KJmVSocR6lkEF2IUeRUwqrKHgF17RykqGbbE+tCgqsci18XTxG45clZGyXqfIK/NTTy2q5ec+BY5T66X2WSQkvxc46nFphhaa6tZY41xHtXeMv7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gq5fIWzsGKKqS7kb9Uq4GLpaWFSqhsix/a90y41TefM=;
 b=SqAKjsF2rfJcFqvlfTWWvmyBspo8gjh9CChncZMIMhW4vfND/ZsoUNg17XKkKwBK2sDNZ8b+jHzeNyCbhp01BW/6zltSquDVvX22Vx5HalQhjJnJqtjcRoCvlwP1PucX11ZbnhSDN/KNDPVkq1AO+e7KecfTsY8ZdM0GFkkCTnzI+FG31saCKNMffFPOLT3RcI4BBgvqdGCGbOwLGlofw0nD81pmsPsv1L57MA5LhQGwLiQ4offnshB1frZftqvO8IlzCSIGOmnORjC5ffiZIIlHgBFWBlh1a614L78eKm1xxhEMoKZP1pDjocyUfwf+nItFfqYTvJQQw8ZAzSWQfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from HK2PR04MB3891.apcprd04.prod.outlook.com (2603:1096:202:35::13)
 by PU1PR04MB2437.apcprd04.prod.outlook.com (2603:1096:803:36::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.17; Tue, 8 Mar
 2022 10:55:28 +0000
Received: from HK2PR04MB3891.apcprd04.prod.outlook.com
 ([fe80::7420:b05b:beb9:38a8]) by HK2PR04MB3891.apcprd04.prod.outlook.com
 ([fe80::7420:b05b:beb9:38a8%6]) with mapi id 15.20.5038.027; Tue, 8 Mar 2022
 10:55:28 +0000
From:   "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To:     Namjae Jeon <linkinjeon@kernel.org>
CC:     "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>,
        "Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp" 
        <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
Subject: RE: [PATCH] exfat: do not clear VolumeDirty in writeback
Thread-Topic: [PATCH] exfat: do not clear VolumeDirty in writeback
Thread-Index: AQHYHKozeVmted1T5UKvjQCq+AaGCaywdCUAgAT/s3A=
Date:   Tue, 8 Mar 2022 10:55:28 +0000
Message-ID: <HK2PR04MB38910EE3467822EBAB4CC79681099@HK2PR04MB3891.apcprd04.prod.outlook.com>
References: <HK2PR04MB38914869B1FEE326CFE11779812D9@HK2PR04MB3891.apcprd04.prod.outlook.com>
 <CAKYAXd_hF+xYXNiawCZLYmnha+wSUSUCEJTVBw8v6UDYfjPiUg@mail.gmail.com>
In-Reply-To: <CAKYAXd_hF+xYXNiawCZLYmnha+wSUSUCEJTVBw8v6UDYfjPiUg@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 935250e4-3bf2-4794-5eda-08da00f2285a
x-ms-traffictypediagnostic: PU1PR04MB2437:EE_
x-microsoft-antispam-prvs: <PU1PR04MB243718A8AC08CB093A2F86F681099@PU1PR04MB2437.apcprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9gX24t2NoA0etuIDKzpx/nayqv1hRLwPyj8e9gMdYP3lUBHthJ0ZzDFa/QPasK+esi7nCy1kS30IJ9HKZDRWEisE4P6KG8vpA4ilKA7NqU8r4OPiVszmJdbAQGlAnetJhzOLRFnzAQ+uzva7/oL9ESjzFCAqC+vS+N7NPwwqm9lJH1EcZw6mwHthg5Mepwt8B0v9QUjqtZ+DgvcgEUYqY0reV5VetY6OpuqPrd95V4RLx/mg0tVb23ksVhpXSrbhR7PUJHbmQHKEuQGIF12IGHqN6bMrmIH9coqT60f+ousvvpgoaQOHtJz3dV48sbYkuQ8HmWoQVyd3fOvd4BVtnaem/0xiPB5nARW2guw2cQbkBw2gW4fiOSbRC0pst2bXTyFsShcr7y/QHoUuCtDN4ow7J8YF5M2UCwr7J3NjyY/VkAYWD0/ssJfmghm1iaSbz8XDFCxqAufAad23rDf/2K4HZhao28U/va4C7wlgzkOPDxlGWk2AqMQDLV7QP6XHlpOYJZ4DF+3jkVuMn7KDjTRkD/AV97RdryhG61XqLsBvkKNZWiq9b7Iayv+5FA5PKVLiPMSdi0pzudb6907Sl6m5q2Mmp5lwn9iJbn0Ar/gEARGLePgAon8w7/y82c6bcbmEVEhp0ZeaaFoD7UZgSnYIeK7p3u4hbIO1jpycr9K7rtHcgw5vXVoc1xcxL7YpZ/REnljUl7VqxY6bdRaP3A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK2PR04MB3891.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6916009)(64756008)(66476007)(66446008)(8676002)(122000001)(66556008)(8936002)(4744005)(82960400001)(5660300002)(4326008)(38100700002)(66946007)(76116006)(52536014)(6506007)(186003)(7696005)(33656002)(2906002)(26005)(54906003)(86362001)(508600001)(316002)(55016003)(71200400001)(38070700005)(83380400001)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K1dVOTBCandtUURMRmN6VWFCUUloSEhYUzlGRnV4U3hsbk1UaHZTN1MrUDln?=
 =?utf-8?B?b2srTnRrUUhBeVA1Vk5aVWVhZXlyQnpLdGUyU2ZPdUY0cU1KQzZrK1VYTThF?=
 =?utf-8?B?QkZRTDhNR2Z4dG9VVEFqeHlPcU1ncm9JTjZRUVNVNzFiamtPQk1tTkp4Rm9u?=
 =?utf-8?B?eCtPc2huTGNIWTJHOTlzVzA5V0lYaWtvK09GM2tRMVpKempVUDBjd21aR1VD?=
 =?utf-8?B?Nm9DdnVCTkFnMkRvKzMzb3RzNUdMZHBCRExMR2NjdXFIWGY4VHM3QVBEc0VO?=
 =?utf-8?B?WlRvbWZSR2cxeXpJYzlzZHFwUWpyblkxZ0RqTnVCb1VnTzVHRDkwOHZSMUpI?=
 =?utf-8?B?cGJhTDNKOEViMGRkaDFvNFdVckpKL1pndnpqdVByQm5YMjBmckgyK25xb3h5?=
 =?utf-8?B?YUxLK3d4eEtWOFB0VVk1S25PelJiVk9qWTNOaTlhU0xFNE4vWFRDQUhUQms4?=
 =?utf-8?B?Z3RpbEg0cnkzeWJvMk9mUmphYVVtQ1hpelFOdEhWTUNvajRxRUdRRGszRE5k?=
 =?utf-8?B?WGVFNTl1cmZQVjJMK2xkWWtFc3hJSmFYbStDNml0SVdnOFR2Uis0dkhvMWtV?=
 =?utf-8?B?b1U1aWZMQ1FVcDlFY2Vhd0V1bFV6NkcwRXpDRS9uKytuV2t3UUxPeE9TdnIz?=
 =?utf-8?B?eDBlVE9SeS9pdFR0Nk5ZVEJGalNQdjZjcmJuOTdpTm9pZnVnM21qN3NwaFkr?=
 =?utf-8?B?bityVnBTL1NBSXhQeWNIRnJyVmdReHF1OFJoWE5rcERHR0FjWUlwVHhENFor?=
 =?utf-8?B?bHVFYkd2aDN2cms0YkNOdk1MUlVZMlJ5enJRVnFSbXBGbDVWQi9ISWRaVmtS?=
 =?utf-8?B?b00wM2d1TGRLTHFyUXZkVmZBcjdCcFFkdDNDd1VvSXlaMy9EaElCRCtTai9X?=
 =?utf-8?B?T05ZOXZQVE1ldXYyS2dkdVlMc25lVlR5Y1llOEVNZDVMSXh2d0FrbGJyUEFh?=
 =?utf-8?B?S0MrdHNwYUQ5QlYzd0lLTWpwZ052TytaS05LWHppNmY0UGZPNEp2Z1o0ZENw?=
 =?utf-8?B?TXlLMkxBSkdORktiWHRHTVVWMVpocG52eC82NHBiMWRDajZQbzRwbytsazdF?=
 =?utf-8?B?OHEzVGJMRUVqM1ZRYlRxUmp1VVJWdlU0Tm1aY2s0a0tPUUZReCt4b21DZFFp?=
 =?utf-8?B?aG1HMUZmaGRnV25aRFBDSThIMGxkRVJ3a29pcWxab2tkeVdpYUhKbGJUVVAr?=
 =?utf-8?B?dTJFeDhEb1Bneno5UTRTRjVycjB2aWFQdDJCMWEveG9UNDJta0lKRGxadm00?=
 =?utf-8?B?VTN3YXhQUDFjcTliNGhhRFlMQUNKenRZV1hqVGhXN2NKWmovdUNhYU5VZWdQ?=
 =?utf-8?B?eklaMk9TeWhTUFY1ektQcUVBbEsyNGtuZjJqaDJXQzRSOG1ac2RYUG9YSVda?=
 =?utf-8?B?dVZRcStYbTlxVkhwbWFBR0x0dDFPMTJuVHZVL1MzSmJSV1dJQ0JSWnFITDRN?=
 =?utf-8?B?eTJ4MlpxMUJKdkJxV1dQVlZHL3d0a2U2YlRKK2JRTm82aCtQK3BYMUoxbTUy?=
 =?utf-8?B?aWNISlRVLzE5UmlramNqcFo5TTBMWTAwSjcyV1ZEVXU3OGQxNk5TYWVSa1FP?=
 =?utf-8?B?NDBHRGovRDMyWm1QYkN3cDZNdTN5M0hUN2lIMm1zaXFjTmJVVndhRVV6UUVV?=
 =?utf-8?B?QmdWK0NmSU1sUmZWbW5FKzYzbm14SWE0OTU0YUtrdWwvNG1VS1lQSGFHZHRQ?=
 =?utf-8?B?K1RHWmpnTEV2SloraWd5MFIzTktKU1hZV0lWZTNPS3dKRVZaVDdUNUxJZlMw?=
 =?utf-8?B?TldJRk1MMzl2Q3B5ZFZjZXVUb1puNVVOY3ppb3RzcUhDYzFOS2kxYjV3UEpJ?=
 =?utf-8?B?WkVXeXhQY25OMjRxWHM1YVJUMUtqUmhiQzJnMFlWRVhpWWM2cTUvVmlGNWY4?=
 =?utf-8?B?M0ttU21RUzArN040Ym5LS3pYUDkveGVRK0dPbXZlVDRqZWk2MyttQmt0TmJN?=
 =?utf-8?B?MEJoVDdrcms4a25UWDc3SzNYYk9mMlFBUnRydm9VeklzNFZkci83TEI1TFJq?=
 =?utf-8?B?K3MyQXRERDY2QkVSQXhRamhWZDIyZE5qVDM5MDFxWnlvajVQdEZjV0VsOTAv?=
 =?utf-8?B?Q3p0MHFGYUh4RHdxVHhmNTlrbkVBclpsV242YW0vNG9OT0NWMjZyN2VnN21M?=
 =?utf-8?B?QkZQZUdlV0pQMTZSVGcxZ3JPNjVXTGpPVVlsNmVJWmRnN0FxUUUyRHlKbVBv?=
 =?utf-8?Q?zNuTKR2KMS6xL0d0yAkv1Bw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK2PR04MB3891.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 935250e4-3bf2-4794-5eda-08da00f2285a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2022 10:55:28.4349
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /FVGW8RHQ89wJyMgtRasrN9AtxHVuifYSoUg+rl7fcM5ffG5vkoWrBmKiSOwLVgx5enJ3qkKApRLkCWSmoO2Nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1PR04MB2437
X-Proofpoint-GUID: Sq478SRqWy7FQbJV-y0ppKrdGxxlQ6aR
X-Proofpoint-ORIG-GUID: Sq478SRqWy7FQbJV-y0ppKrdGxxlQ6aR
X-Sony-Outbound-GUID: Sq478SRqWy7FQbJV-y0ppKrdGxxlQ6aR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-08_03,2022-03-04_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 adultscore=0 spamscore=0 mlxlogscore=864 lowpriorityscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 malwarescore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203080058
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

SGkgTmFtamFlIEplb24sDQoNCj4gPiAraW50IGV4ZmF0X2NsZWFyX3ZvbHVtZV9kaXJ0eShzdHJ1
Y3Qgc3VwZXJfYmxvY2sgKnNiKSB7DQo+ID4gKwlpZiAoc2ItPnNfZmxhZ3MgJiAoU0JfU1lOQ0hS
T05PVVMgfCBTQl9ESVJTWU5DKSkNCj4gSG93IGFib3V0IG1vdmluZyBleGZhdF9jbGVhcl92b2x1
bWVfZGlydHkoKSB0byBJU19ESVJTWU5DKCkgY2hlY2sgaW4gZWFjaA0KPiBvcGVyYXRpb25zIGlu
c3RlYWQgb2YgdGhpcyBjaGVjaz8NCg0KSSBmb3VuZCB0aGF0IFZvbHVtZURpcnR5IGtlZXBzIFZP
TF9ESVJUWSB1bnRpbCBzeW5jIG9yIHVtb3VudCByZWdhcmRsZXNzIG9mIHN5bmMgb3IgZGlyc3lu
YyBlbmFibGVkLCANCmJlY2F1c2UgdGhlcmUgaXMgbm8gcGFpcmVkIGNhbGwgdG8gZXhmYXRfc2V0
X3ZvbHVtZV9kaXJ0eSgpL2V4ZmF0X2NsZWFyX3ZvbHVtZV9kaXJ0eSgpIGluIF9fZXhmYXRfd3Jp
dGVfaW5vZGUoKS4NCg0KSWYgZXhmYXRfc2V0X3ZvbHVtZV9kaXJ0eSgpL2V4ZmF0X2NsZWFyX3Zv
bHVtZV9kaXJ0eSgpIGlzIGNhbGxlZCBpbiBwYWlycyBpbiBfX2V4ZmF0X3dyaXRlX2lub2RlKCks
DQppdCB3aWxsIGNhdXNlIGZyZXF1ZW50IHdyaXRpbmcgb2YgYm9vdHNlY3Rvci4NCg0KU28sIGhv
dyBhYm91dCByZW1vdmluZyBleGZhdF9jbGVhcl92b2x1bWVfZGlydHkoKSBmcm9tIGVhY2ggb3Bl
cmF0aW9ucywgZXhjZXB0IGluIGV4ZmF0X3N5bmNfZnMoKT8NCg0KDQpCZXN0IFJlZ2FyZHMsDQpZ
dWV6aGFuZyBNbw0K
