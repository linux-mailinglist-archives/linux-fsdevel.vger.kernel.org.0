Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFAE778BD98
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Aug 2023 06:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234768AbjH2Eu7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Aug 2023 00:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235657AbjH2Euz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Aug 2023 00:50:55 -0400
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A6B719F
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Aug 2023 21:50:46 -0700 (PDT)
Received: from pps.filterd (m0209321.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37T2CthD004986;
        Tue, 29 Aug 2023 04:50:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=S1;
 bh=JQORbiELvo4dRwux7hYMYLbc4pT/vpJZuHsMzv2g/nc=;
 b=JXnOKs2574Y7AUYI43+HWsld0iM7NTfG9MtMyFUfnPYhGu+/2VVBUPYCGF3J3AIGioVs
 tlCP6ati0kRn2bZBGkttU1cnGwI/0W6Pjc4qO9ShtDWygHCp9pZfj29XheA7JLhNlj9L
 wOwHJ5A6elTbSM+e3nKdl2ughuyZCeRVZ8Tn9TZ5IPqfrfTkXnX6IU2mHMdSQcZ/P70k
 mNyk+vDBJvalJp0xZEVm6cLRwWc5Rs6lwVybuU6Kvna3ZC/dakkaxmaze72knuLMDd+A
 sTSjFuVaP9UGlXBft+Ri90dM0an612HPY0pTKJ9qyINUBHUBszFgwjdwLOWKlX3/46ih 4w== 
Received: from apc01-sg2-obe.outbound.protection.outlook.com (mail-sgaapc01lp2104.outbound.protection.outlook.com [104.47.26.104])
        by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3sq9eq27vh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Aug 2023 04:50:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V4/+iVXlakwIROVmayaoW1GutDeMmok1tFHjXDZH9ytW96Wxs5FJmlnz6hZWyreTNAcko+XUkbOxYORefZu5cMP04HO/erdsVeQrVUpuhkTeHGiYsXIW4MtfBz+NLREJrJH1kyBAPT8ffiDkENTw68olVwo/aefLCtAWoxDSpdbpuJj5nqUN/5Dvn1RmZuWigqrayFiY+Ez63O6EoEvBRF3/Rg4MvtBmNs8DUAW7lLg5bZY0XZZ4Jwm/N38+DRmYIoTeGtVdCNxkR1EBlK7R5uGA9hWvWDuph2BHQkwb8BcUhnbGJ4y73KLxskldYjQ9auAnWLQMDOQsat6w3xy/qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JQORbiELvo4dRwux7hYMYLbc4pT/vpJZuHsMzv2g/nc=;
 b=fxFThaDUM0wDw9Nb7mskmxguAX3T51BtZiaSQIrbSgJUtMP208ijMnSI0H9ZT4P8tGKDQKjv3PrFfi3fBh9qXQsS96qMFShuxkNWX/5x6c8PQn2UYEys8YawbZhEIhcW3YSNBk4zUdE9eeUmR56fD9Q2773eeGCsRMqDjgpuEtoIh3SuOyePgTGsq7BRE0KHzPCd/KIFriXm6FzR4V/cOgGdPHK1o2789zppCM1ddb6HAnupr3EBGxKTVfqYSiAgnpRQ1LaFYuNZL03D544pQhEPZHZdtwxlFcMn9/80ArE5+TajrQD9X/i7kwkEjgM++1a+9yEmAc+4CC0MCSwdrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by KL1PR0401MB4340.apcprd04.prod.outlook.com (2603:1096:820:24::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Tue, 29 Aug
 2023 04:50:21 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::9391:4226:3529:ac7c]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::9391:4226:3529:ac7c%7]) with mapi id 15.20.6699.035; Tue, 29 Aug 2023
 04:50:21 +0000
From:   "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To:     "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>
Subject: [PATCH v1 0/2] exfat: support zero-size directory
Thread-Topic: [PATCH v1 0/2] exfat: support zero-size directory
Thread-Index: AdnaM3kMKu9cq5DfSUisPE+vFDwnZA==
Date:   Tue, 29 Aug 2023 04:50:21 +0000
Message-ID: <PUZPR04MB6316F8ABA8D791886D45435C81E7A@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|KL1PR0401MB4340:EE_
x-ms-office365-filtering-correlation-id: d6886f0d-ff5f-40b4-92b8-08dba84b7385
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MbFe9PvHUeGRY6y8egfsXguXJWLcad9cCT1JcH8v5/oJTRo5/tc8ugp5N+EfNGg5TeDgOcNVOC5Ml/jsLrUKUVbrOKQWHa0NAupV/HQcPZKrBtDdWVlSGcB7pjcudcslV/MZZ1oy1uqrYvHUJLisLuK3eInZ1qNWpXQJOE1d/2am9n1NH+eBxJgG1m/gjhviFerkVbE/GvGh4+Lb4vcCEnZhEgsy5N3tIvFOV1ydNfnLwdaxdyZPLXZj63LL0Lglgof6hFzXCwNg0VlyV2LbXIawBeQk/E59unbGuNMMmLB0bHOnLw/cgk1rC7eLbboD1vgglQlCOwN/yOzWIJ/BhYdbZHnuvBwtDOCNcBhqsPFQLxcO8vgQo1ueaGdenhJrURC/21AMAZFq4ZtyTmWnLyW9QavSUqilqo0Qrp3BWi3fLVVd9It8ARUfAiPQMh8aqG49CG+W4It6wNtBEiSuYXU+przukfhK+atdf2KoYOXUQaO97tKencc2/nz7woEDXmuXqamL9L/qmXSrj+TmCmuAsdQRMT2P6/kYz/DzXd7QJqJ+vD8Qvw/oUeX+vXQlOfLC3xYZkDiCg42XJ6mOis73CFBVauSDeZCfzMBW50nQivDg2ns9/2segnfF2W+0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(366004)(396003)(346002)(186009)(451199024)(1800799009)(9686003)(7696005)(6506007)(71200400001)(478600001)(83380400001)(107886003)(76116006)(4744005)(26005)(2906002)(54906003)(316002)(64756008)(66446008)(66476007)(66946007)(52536014)(66556008)(110136005)(41300700001)(8936002)(5660300002)(8676002)(4326008)(33656002)(55016003)(122000001)(82960400001)(38070700005)(38100700002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?akg5ZkxFV0U0Z0ZsditoMm5PYUhZQlRRM1V1eFVrbDVKZjdSSG5BTGFYNEJE?=
 =?utf-8?B?dHRwekxjdG9SVE15YjJMSXFNNWh3ME8weVBmUzJFT29UZ1ZycVNaOGRWaTdB?=
 =?utf-8?B?Y0V5Vi9YT1BFYlRiK2N2NEVYQlVKR0JMNlgrTWZ0RzhtRStaM3loZ1J2RXdE?=
 =?utf-8?B?Tk1LNjJyMDVKRDZ3Ym9odTYyclNoM0IvVm43ZHJkVGY1ZndwVmVVQ2FLRGN1?=
 =?utf-8?B?MW0xRnJlTXNlMnM4eW5jSnNIbk1Vd2E3R0hyYlZlOEZQeWx6L2Q1SDl1dy93?=
 =?utf-8?B?TVg5em8zWmtEOEZVTFhWczNlM3F4N2k5d0JTTFV5ZERZNEFvT2pnVEw4OTI0?=
 =?utf-8?B?VmYwZlYyQVNBeWtnSXNnWFVRV29BZW9jNG1IZXBDejJsT3VxTDJKREZxKzlI?=
 =?utf-8?B?M2hqcGtXdnZmZnB2N0dOM0JqbDBTNFdGRHZWMDlFSW9BRFFDUkE2K3pxOTgz?=
 =?utf-8?B?bVo2QjNkL3ArN2daYjlNaEdJOHZiY284VTFNbVIydGpQd0RqMDVTcDNIdTQw?=
 =?utf-8?B?VlhXcTRpOS9JMkhZSW91Vm55bWVmNlJIaVZhdTNDV0JYakt1OWNaZWpoS1hP?=
 =?utf-8?B?d3F3bzR3NDhLUjJQWlpKWFJKV3Z5aXhpVnBSNXAzQ3hiNzV2QXhwSC91dEw4?=
 =?utf-8?B?OTJGZWxGSFJOdTF5Q1VYUlJpQjY3UVNGQjhIM2JhcHkrTTRMc3ZEbk12T3d3?=
 =?utf-8?B?STBZR21WMzVWZkJodUZxMEoxMDJPeG1TaE9nTHhzUnpPdGNBWWh6U1NYSDhE?=
 =?utf-8?B?RkZhbm14UDl1QUttR05JNHhUNUk5Z1FXT2NDbGRHZkZIOXdhU2xaOU5sdGFQ?=
 =?utf-8?B?UWhtU3djazVnTGYwSHJmSzhIVGpPcFBYVVIzS3ZnK0dGTWFPeXEvSWg1cHhv?=
 =?utf-8?B?NmY3WlY5aDk2cDJvQ1hpR3ZXY0ZFcXp0WXV3Zm52OVRRZ1dvbStTN0tYMWR2?=
 =?utf-8?B?TytqSGorOU1idkVWZjJQZ2RaMUJ4dm5nQlJaWkJ5SFI4TzBpdjlYaEtUOE1r?=
 =?utf-8?B?TUlzWmI2RXU0YWhBMUlpbGkzOFpDTkUxcXc2SE42U2lDR0xQN3E0WGNDd2s4?=
 =?utf-8?B?V1FVLzI4SlFTMlExc3ZEMmFweEcrbHp2b25vZzZYS3k2OUNLa1c0WHdSTi94?=
 =?utf-8?B?SzZyMGtuOWxuaGcxcVdXUVBVd0E3eHpjQVR3T2Y0MFlmanY1cmNtaExSdnZv?=
 =?utf-8?B?UU9FMVpGdzhCVm1ZTlBqdXJPRW03ZUZiUUpVTm54QU5WY1dqRjJFcXVpcm1C?=
 =?utf-8?B?YzB0eEZWa2Zlekl2eFN6Y25OSCtVM3QxRTNCS3dNV1E5OWlpb0hFMUFWOEt1?=
 =?utf-8?B?eUVwZWI3OEQ5NXhLYjBxeDlGbnZvN0RLUXlocTFoK1dFUTRPOWQxQThKM1Nx?=
 =?utf-8?B?WmgzZGJSZEM0RnI3ZjhEN01aRWNDcmZFbFUrNXlFRXJGZkpTVzdpTmVReXc0?=
 =?utf-8?B?KzdwTDQ3M0hoOVhab05kK2YzcWVHUmc5UjVsaWlLUkQ1dzZZa0hlSURJbmdS?=
 =?utf-8?B?Q0dHeHZKemNvZjdYMzdvTGJ4OHRxbE9ta2wxTEtTLzNmSFU4bGVLSGxvUW1L?=
 =?utf-8?B?QnRhT1QxNFdDeGZiK0RoTjVMN01tNkZFaGw2YmczUVJjcWNoemF4YUFEMkNB?=
 =?utf-8?B?dWhES0JLdUpNNU93NnFEekxXV3pGUzhzWnZubmVOdGFNc1pYb1hYSzQ4bXRs?=
 =?utf-8?B?NDdvRWFKVWpOcUdTVXZ2bGJDZHhCTHpNaVIwOUo1aTdrRGRUYzhncitjVmdE?=
 =?utf-8?B?ejRpOEFuc25jY3NydFNUOTJ3SDFNNDM4RGdiWDdjMWNQTnkvWXpkLzZRazB5?=
 =?utf-8?B?UXUxY0xjNUlYUTAvVDRvRVpnVDJQUldmeFNqRmZNR3oxaXZLRVJ1VzF2cjhF?=
 =?utf-8?B?eTJqNVZ6T05uVmhUQWlqWVM0cW9rZkVIZjNSTkNEdHJKRVIvRi9oTm1pMmRl?=
 =?utf-8?B?bFpHQWV2cUYvMUFmcnV3M0ZoMkJ3MnY2K05ZNEs4K0ZiU3hkMGdXTnJXVkFI?=
 =?utf-8?B?ak5FSTVqVWNqY2lRdTE2YXpjVUJLelgxVnVTalZTNjJBVFl3RU5mY2NmZENk?=
 =?utf-8?B?cDRBdXpzaWhNaitsaGlVWDlUNmRxUkRwby9BWkJEZkJySHlpdHVLZWpRNTl5?=
 =?utf-8?Q?ULuk5cdR3vkJGH3zeEuoE46Kl?=
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: r3fFr8/Fk52dbuHBaiSjAuSjsGUOGICM+co+Wc9PvdIttvtZJaNzcxLNLH4blUTl4MgKziLMDV3vutFJG443vZ8nTzOhyxK1fFKvQ0LoOKzG0jKaKcCqN9A6MDmXH/OuaMslJ1UKKMpKAU28ZPAR5mLek+xZJE24aiNxt9tdl76QTXjXlTJEldDYVVj71HaWaMZOsHztf6hcNvmzaU09KcLakUrU04yYvvyf8UvZ8TerzrM4/lULdkrIb4IK9k8fa7Ye31RcXACqxs0VhxkxKDXmrShn8HGaDP4+Tc2LDk8y1aJ1q0nxbqZO2iC8raqXsDXUK6ZoyPGeDqrRjh3VJ1+OJu+wytYji93Y4eMiSk1Z9cmOXEW/OduoQjycqirPItny6HHIDpKyuhyxWEglnGFE5sbwmJKbVTZzQX5b3DOwR5Tng3lsxSw/Gah0x4Fzdzzo/rjBnI0ncqJU6HfFZ0+SozjtqOEj07JHYlfBiflp/eiX70mCn6jIVcH7nX72JzH1b6QVqRxTvbpNZY77vAuEScqIxjBkvtZFTyD3buH5qvAAAQpxLmCWVxJgUILPFkUYVQLOqvLgv14CVCWrfUowTcYMJ3dqjNuDYAnVgzPfLPf0IboxmhQTyhrwAujUDg6dyFovJPs8GsRpKOK8lPH2LEBukfwb+SkQJlp98nbtgLhorO2khZYS5m0eOVPDdVtYyZO1gqH6vGAC73CFZgov63O5TjTY3qnwVteszImIfUpRJvsGzXN86u0OSCAKMBRa3M+dH3kYh9rDF3qw5IXDMAA2OXUihKKoTjk/9eJiWuRbLcAwQmKrDF41hwPMpf2pCArAVBrB3wO2vtUN7Q==
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6886f0d-ff5f-40b4-92b8-08dba84b7385
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2023 04:50:21.7149
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YfloZvu5VGMaETs9HX7NpVjxOVNMF/5VfSOkjw+aIJOTUFyw3z/QP4T1v4lb5tiAgCqbnEBUGicHSEbtowxvJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0401MB4340
X-Proofpoint-GUID: NZDjcZx-SUys_Tl6lXREy6TOxsETFcl_
X-Proofpoint-ORIG-GUID: NZDjcZx-SUys_Tl6lXREy6TOxsETFcl_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Sony-Outbound-GUID: NZDjcZx-SUys_Tl6lXREy6TOxsETFcl_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_01,2023-08-28_04,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

WXVlemhhbmcgTW8gKDIpOg0KICBleGZhdDogc3VwcG9ydCBoYW5kbGUgemVyby1zaXplIGRpcmVj
dG9yeQ0KICBleGZhdDogc3VwcG9ydCBjcmVhdGUgemVyby1zaXplIGRpcmVjdG9yeQ0KDQogZnMv
ZXhmYXQvZGlyLmMgICAgICB8IDEyICsrKysrKy0tLS0tLQ0KIGZzL2V4ZmF0L2V4ZmF0X2ZzLmgg
fCAgMiArKw0KIGZzL2V4ZmF0L25hbWVpLmMgICAgfCAzNiArKysrKysrKysrKysrKysrKysrKysr
KysrKystLS0tLS0tLS0NCiBmcy9leGZhdC9zdXBlci5jICAgIHwgIDcgKysrKysrKw0KIDQgZmls
ZXMgY2hhbmdlZCwgNDIgaW5zZXJ0aW9ucygrKSwgMTUgZGVsZXRpb25zKC0pDQoNCi0tIA0KMi4y
NS4xDQo=
