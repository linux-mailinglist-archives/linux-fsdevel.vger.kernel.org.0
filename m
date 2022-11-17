Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5365762D2E3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Nov 2022 06:46:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234754AbiKQFqn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Nov 2022 00:46:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbiKQFqk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Nov 2022 00:46:40 -0500
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 845815F856;
        Wed, 16 Nov 2022 21:46:39 -0800 (PST)
Received: from pps.filterd (m0209321.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AH3dCjF002252;
        Thu, 17 Nov 2022 05:46:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=S1; bh=ynyCX91+qKXzvHhkZ2kQzl6p4NUmG408AcZXWEyV5aY=;
 b=nYF8kIIQjZMKaYyTwxXPV11BbSL31CZOWLuyTKGw1iKDZam008Qb5aV+rWOaOxclWbp6
 Yg147F2SriJfraN5g/Ks+pE0UX0CrkjoALuKBhBioC8KDKK5vDH6QlmmpbuBAWHoTdL9
 W49QbZi1GxQQvBDvMracwmtYCDKdmyyFWYAqyMhxPu2XAZrIPb9t6lGno24hWWHRGG9N
 VbFISsoWfz90g9zf7BhUC5i/ercbwTujxmun/PEmihFtEqBBuz3CCPYA7ZjeOk+y8i+s
 d6E9JNGfcZivmyKHyROgRIW68L5zUy1blKeXdiGGJXeWhqvoVAGOTHwo2Qcuf9XLP6Oo gA== 
Received: from apc01-psa-obe.outbound.protection.outlook.com (mail-psaapc01lp2043.outbound.protection.outlook.com [104.47.26.43])
        by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3kv3jmtjab-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Nov 2022 05:46:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YsRfbZzIwq0K9UzHIx+/Zupk44Ae9KMQRKDG0kLKSd1YVR8xynYBqI4JzMuuhqfg9iXWsr5hj/2yZiKlCAETiJy+T3T+ITdZjzGdx5XW24oiLtU1qiafeCE5C4ry9PDhnq7qHp2y7qgZw7ifJMtpUWTjABCV5cJHLcSXmKViNqTt4Utod3XobGnsrDa0olP/DXkknVa/BJ21Upywva+MA1r5Tqdsu/O7di/hhy8KbP8DeKGh71mMJB4qtA1ROk0y0FZnElqw7OPLnZ0FkJ9hQv9AG6daSIKKaTToxrVy1wlsIJxbFvZ2m5UAgs72FozCD2Rdw1zZB/FUz4KORSzHgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ynyCX91+qKXzvHhkZ2kQzl6p4NUmG408AcZXWEyV5aY=;
 b=hDc/qUsI+BCS8iQVZt/fjUWzZV8ApY2a0QdAWz9dclUAxO5rY0wWQTFbEK55QpKMt/1rhfrDicQruxzsS4MvpTYcFDvBMirW/Ef4qAUWvsO1uPKsQOQWuPRbj2K5sRnRc/HUwBd/FxsusnIxxnq392PUhh8fBah6cPscd6+LFT/ZEc+GmK8KghSbHjHonZ8gh8iSHcBGlEeKa78fS4tC1U6AdE1GIDLud/6qN6I1rjwnMmaXSE1d1gHKr525wsuM0X3sc9E/3+zMB/7aSYMXsow9dW6wH37VmST3NU0uDGQ03xs2MHJ4EmhPyQPDfVR4E1Fh6fgp64XPxAymkc/7xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by PSAPR04MB4134.apcprd04.prod.outlook.com (2603:1096:301:38::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.9; Thu, 17 Nov
 2022 05:46:16 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::708b:1447:3c12:c222]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::708b:1447:3c12:c222%7]) with mapi id 15.20.5834.007; Thu, 17 Nov 2022
 05:46:16 +0000
From:   "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To:     Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>
CC:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>
Subject: [PATCH v1 1/5] exfat: reduce the size of exfat_entry_set_cache
Thread-Topic: [PATCH v1 1/5] exfat: reduce the size of exfat_entry_set_cache
Thread-Index: Adj6RgjM4RrwzVx0Tk+pTmebpSgl7Q==
Date:   Thu, 17 Nov 2022 05:46:16 +0000
Message-ID: <PUZPR04MB63168831A4F57B74109A893A81069@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|PSAPR04MB4134:EE_
x-ms-office365-filtering-correlation-id: 0f05fea6-c07e-4a3f-3b29-08dac85f0b46
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cKVGPCfwaX3STrgz2OUEy0mk+4YXP4094nS478G0KQE4RPXi0BpR81LsuBl3sSxOJBPxiZoWAdnt/bHX/rMC0rd93+2oG+4284bb8+qSpR6PS4mIhtFtmXvDI3COfBY3sb6+zVQJm+Be4NNCL/SHzXLsGbZ7iZ+vywB22vHeHPTVtjYnctstv4nbU2DqJ3IHrWCq01NhmKA8+9rQ6Y8GJTXZBRulVT51WqJDfoGxQhm6R8rJK85fVWeNYRyGrX6pCAq7x3R6g1Dkt+9qYLGlbf1jj/TdAGEk3ockeUzj2Lz0g40ARQIE5THIPgb+eaOiSPi/sfGBHVCT5DVw3mbDzxSSrtBlpdsdJBvKzjAzsvUbGZpELn7q1G9TiR7XsuTp2PbKxAUkARlOyJYoKBSMjr6vZ/KvJLOzVwDcn9xfBqKS+OO1cvEbGru0qIxEGxDTG3FMEXUdb4khzBHhvSm0jtmQazu7XRh0jJ/x8CtIu5Ufsj1yJmeplzjtGtLFTtEDLj4f9TAqHeN3d2Iix+cnHIsNbo0PHSVbQm9T90BuncbgVpP4CpTguTrjlSiJMlEfVKUJhKZHKLRU/mRbsJ5ahbcqUSwqsuE5fW0Fry8yVxxe2WfYoebUtbh3fViTR+Qfvl0yBBYCz7VPlIUcwulDV/2QoQzkeuZ/B7wkM47rXQb0N1cxtTB+pqT/XqzIsKCQ/hxnC7Z2O+5nByJoE+ACGA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(376002)(39860400002)(366004)(396003)(451199015)(33656002)(316002)(110136005)(186003)(38070700005)(54906003)(71200400001)(107886003)(83380400001)(6506007)(26005)(478600001)(7696005)(9686003)(2906002)(86362001)(55016003)(66476007)(66556008)(66946007)(76116006)(64756008)(66446008)(8676002)(5660300002)(4326008)(8936002)(52536014)(38100700002)(82960400001)(41300700001)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?LzBVdmtDU3JpeHRRMEg5ZmE0SGJMZzVsSWNOMVVDNzc4UEhmazZuam5RaWJ3?=
 =?utf-8?B?RGJpWXhzTWpMSlZKQWtTOXRFQkpSNUdVYlVwTlh2bjBCTTJSaFZzYUwyeDUy?=
 =?utf-8?B?Q0RhK1ppRmNxL1JwMmxNU2RiSUZ6RmFlWjRHdzBTQWpjTUw3QVdDVDUwaW1i?=
 =?utf-8?B?Rk91TkJod0VGWk51aDY1djFoc0VhNW9XOWhTREh5VGIzclM1akdnYmlCKzFC?=
 =?utf-8?B?MEhyQmE4Z2l0TzdGKzRZSjNCZUJqL0lzalQza1FxNGxQZUQxU0E4NE9wQnNi?=
 =?utf-8?B?QjFML01EbWgrN2IzQ0dEeTd5Ym1ZTmtzanArOGtvUDg5S2VaTkkzT0tBV2gw?=
 =?utf-8?B?Vzl0NVd4ZFN6YkFIM0taZ2JtSlZBYWtpd29xQllLZFBhUUQ1U1l1NTFnOElY?=
 =?utf-8?B?N3BqVXd6N29SUTFnNldkazQ5UldraW12WGc4M3BwZ25DRlZuMnZLaDUwdWND?=
 =?utf-8?B?cWFsbDBpWkFYTGJkdjBsRy9oRUJMcGdvc1dsRXphM3BzaFdEUWNHQ2pDeTZT?=
 =?utf-8?B?M2xrZDc5ZmdmL0xFS0dxTk1ERnZrdEE1L3hWQVljWlhUdXlnSTMwYkFLMzV6?=
 =?utf-8?B?MTVTc2Nqdk1NTzlJTTJIUzk5dmw4YmJTRUErSVJYS3ZYdHhRZXRYdFFTeTBh?=
 =?utf-8?B?ZWFCUmIxNVg0YytvK1dWbi84UmhFRFUxenJqazk4NVpScERwTkY1YURCWktZ?=
 =?utf-8?B?SHpXTXNUWDZ3QldrU1ZUZzd6eXIydVA0cGg2OGcwa0RoOFBYRHh3K3pQTnF0?=
 =?utf-8?B?elR1UTZyemxvWnpHVndtQWFiK1pMM3Z3UmRFZWh3c2VqMTR5Ry8xRzJad3hj?=
 =?utf-8?B?NFZ4RlkyUUxZK2RCdjQydGxzNGRiNmgvd2ljZTNXS3krSWdXZGhwdUt0WVRV?=
 =?utf-8?B?U0VHN1RZZjlidjUxZHA5L2JCcjJUSXUrb1lEKzFVNkx6ZUNDVC9hYmdIeC80?=
 =?utf-8?B?UW5BNnQrcnRYSHpFNDJ3RGl2QnJUazUyNmxPeHdVYUppeUZydzFNR1ZrS2Z0?=
 =?utf-8?B?b2hOR1FHQzVKL2JnV0w5QjhORGxDeFYvMzk3K0hQMVFIRUtPQnhhQXBVZTRK?=
 =?utf-8?B?ZEs4aXptdStZVmhEWDVTNVNkdi96SVVNVERFbDBOLzArR1pmL0RLWUV4aGtY?=
 =?utf-8?B?TTN6dEltdTAwcU45Undvcm5CVS8xUUZmWWhjbWtMNzhmWnZuWGxxa3RRekQ2?=
 =?utf-8?B?TUFKdGh3c1BlM1htZkZ6V1Y3ZGtiT3pvWWJST0hmSjVmSmhZNzcxNVREOTlZ?=
 =?utf-8?B?SEIvQWJtMUZGRVJndnRIbVFhV3NDTGZ4SUlGelkrSWxUaGFwUEFLeVdCVlJw?=
 =?utf-8?B?RkdsdHpGK0d6TkF0VGY0RnE4aXNZVHV5cGFyZFdQWjRiZFFHOEwzMGZVb3RM?=
 =?utf-8?B?TktMOHZRL2pDM29CNGM2RFp4RnRUaWgrM1l0NmlqNkZBNjB5REdScUJIY2Rl?=
 =?utf-8?B?RTVkVU15RUZSbTdITDBaa3pvZDZLd3pKd1hkRXBaK3EySFhJeWhLZXdldW9q?=
 =?utf-8?B?T0Q3ZU1TMG1MZDRsUExKVFNKdHF6dThSalVuandVZEI2RnJVa1N0S2tFQ3ZC?=
 =?utf-8?B?MHBsN1hLYWhXRlpFWlluNGJ3UWdPaXpYSFlSR1hmUlM0SVovSmppc21VYW1n?=
 =?utf-8?B?U0hSSDRkcUsvMHkrMHcrMzhVdjZ0eEs0R1U5OENIODVxKytqdjVtTWV3RTlM?=
 =?utf-8?B?U2svSHdNb1pwMkZNSFpYUURDVjZyL2VLOENrbFRzRmFRbnVVN0FSSERWL05t?=
 =?utf-8?B?enYyN0RNNWEvMThFVUdtOGZCMnByNFZFNlBoOW52dk1yclNaREF1TUxlWUFG?=
 =?utf-8?B?WGd6bVR0bDUvZW1FbnI1VVFLdDBNZlQxYmxoVzlGZ1Q1RkYySUM1TGdaQ3JS?=
 =?utf-8?B?SEM2V2NTOGRpaW1MWTY4L0k2TGlIRmlTVDZJdXZ1eXJxUk90S3hsN013ZTB3?=
 =?utf-8?B?ZEhLbU45OFNxUmswRTZXS2w2eTdoRmhxeDJ1U2NVby90UGt0QlNTL3VrTHdH?=
 =?utf-8?B?QmJEY2FBaXJVMEtZNVdPdHFJR0VRRHZXR2tFTWxVQzhiQWVJcGRQVmoyUXdv?=
 =?utf-8?B?SHJuT2VMcTZMMTZ5RjkveFVmdWNOdlVQV3RFSmVSZzR4N20wQlNRTEJ3OVFY?=
 =?utf-8?Q?mNCTkKPs1xTp60zw0LH4TGrP2?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: bnbr9+7D6b9C//hJ/PgTPK+HKFHb0xLCTaNC7uCp0ySWz+7Bt3gnUDu0Xr5rHIr2oyGOz7S8cQ8Lri5T462VWTMj//fLMvWpn3jiywAPquD4qtWC4C8i3/cjAuyNtTP007IxF99hIfY5vtxP4xcsHX46/8rClCRBrCfW3/3P0xRWpdflKBCVCDhBhAy/S1pAtB+NMtK4fFbuo4LsfN2TNI2jXzn/iYbd/0lzr69IYDesqvFbnc4nb8MgvY6DYVUSTrDcGeHPiLAU9TYJ4lIu9OSL7IsMseXMkwlHvMO7KdD2awpkaX+me3HGhlh0C1x+O07UD9m7YbpNu33f6GJKU9Z4UBebCCA2wFQyoa6nEnUpT2ZgJ988s8JpeB/hSDZWfKWJoxKrpyqwx7/D+Gkqdf2Nj7i22MWthhhOs+VtjbCIXSihV5is/cMhrMOFpO/C0+Zg4DrYxUJUScVspzATyGyeNRuItEyAjJdhDqFM5MD6V8Xm87aTbLyPtaHk1YdjgOgJcmxig5UQXg8VV+JZxY02hgD2eQSxSighkFWKJ3fU7xXfzeZboivgxfwTVKVR7JdyOVUC4/vnbC6WxLGX721+Sx0m5N6LEV6/wBoOWtuBXDy4VRp6yvlZ3QN8//y4wMttm8yfIrpNI+111JhPbc4WK3t94ltyWYEUJML0FrYtr8467s9z3VRzLLsemJyIacM4nC/XXtBHpQJb578cGAWNEOVBTbEbfrejXbkFfNonGMBz1UrXPtTnyVrwWRuHDGwFXQGEAJrXtuco+ySgN6vCrlMZJp1djjDIOUovQ5xzKUd4zCs4noFYt8EkspMkctzgk7i3dFHMQiVy36GSHGnce1JGA+VxFc7KbyMZBjF9BQShxxEk7nq+VV2ejIL2
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f05fea6-c07e-4a3f-3b29-08dac85f0b46
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2022 05:46:16.2634
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tqdR1xgG3CUIzKMjUnUh3hUJObxDQPk6pxKCd6PpcSq22evCnR9E3/9nRx8Hzm5EP3wlWKy0Aa0BQswNsaZn8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR04MB4134
X-Proofpoint-ORIG-GUID: qH7KW5O6m-y3xKEaRKlogaOXXF6BOZMU
X-Proofpoint-GUID: qH7KW5O6m-y3xKEaRKlogaOXXF6BOZMU
X-Sony-Outbound-GUID: qH7KW5O6m-y3xKEaRKlogaOXXF6BOZMU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-17_02,2022-11-16_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

SW4gbm9ybWFsLCB0aGVyZSBhcmUgMTkgZGlyZWN0b3J5IGVudHJpZXMgYXQgbW9zdCBmb3IgYSBm
aWxlIG9yDQphIGRpcmVjdG9yeS4NCiAgLSBBIGZpbGUgZGlyZWN0b3J5IGVudHJ5DQogIC0gQSBz
dHJlYW0gZXh0ZW5zaW9uIGRpcmVjdG9yeSBlbnRyeQ0KICAtIDF+MTcgZmlsZSBuYW1lIGRpcmVj
dG9yeSBlbnRyeQ0KDQpTbyB0aGUgZGlyZWN0b3J5IGVudHJpZXMgYXJlIGluIDMgc2VjdG9ycyBh
dCBtb3N0LCBpdCBpcyBlbm91Z2gNCmZvciBzdHJ1Y3QgZXhmYXRfZW50cnlfc2V0X2NhY2hlIHRv
IHByZS1hbGxvY2F0ZSAzIGJoLg0KDQpUaGlzIGNvbW1pdCBjaGFuZ2VzIHRoZSBzaXplIG9mIHN0
cnVjdCBleGZhdF9lbnRyeV9zZXRfY2FjaGUgYXM6DQoNCiAgICAgICAgICAgICAgICAgICBCZWZv
cmUgICBBZnRlcg0KMzItYml0IHN5c3RlbSAgICAgIDg4ICAgICAgIDMyICAgIGJ5dGVzDQo2NC1i
aXQgc3lzdGVtICAgICAgMTY4ICAgICAgNDggICAgYnl0ZXMNCg0KU2lnbmVkLW9mZi1ieTogWXVl
emhhbmcgTW8gPFl1ZXpoYW5nLk1vQHNvbnkuY29tPg0KUmV2aWV3ZWQtYnk6IEFuZHkgV3UgPEFu
ZHkuV3VAc29ueS5jb20+DQpSZXZpZXdlZC1ieTogQW95YW1hIFdhdGFydSA8d2F0YXJ1LmFveWFt
YUBzb255LmNvbT4NCi0tLQ0KIGZzL2V4ZmF0L2V4ZmF0X2ZzLmggfCAyNCArKysrKysrKysrKysr
KysrKysrKy0tLS0NCiAxIGZpbGUgY2hhbmdlZCwgMjAgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlv
bnMoLSkNCg0KZGlmZiAtLWdpdCBhL2ZzL2V4ZmF0L2V4ZmF0X2ZzLmggYi9mcy9leGZhdC9leGZh
dF9mcy5oDQppbmRleCBhOGY4ZWVlNDkzN2MuLjdkMjQ5M2NkYTVkOCAxMDA2NDQNCi0tLSBhL2Zz
L2V4ZmF0L2V4ZmF0X2ZzLmgNCisrKyBiL2ZzL2V4ZmF0L2V4ZmF0X2ZzLmgNCkBAIC05LDYgKzks
NyBAQA0KICNpbmNsdWRlIDxsaW51eC9mcy5oPg0KICNpbmNsdWRlIDxsaW51eC9yYXRlbGltaXQu
aD4NCiAjaW5jbHVkZSA8bGludXgvbmxzLmg+DQorI2luY2x1ZGUgPGxpbnV4L2Jsa2Rldi5oPg0K
IA0KICNkZWZpbmUgRVhGQVRfUk9PVF9JTk8JCTENCiANCkBAIC00MSw2ICs0MiwxNCBAQCBlbnVt
IHsNCiAjZGVmaW5lIEVTXzJfRU5UUklFUwkJMg0KICNkZWZpbmUgRVNfQUxMX0VOVFJJRVMJCTAN
CiANCisjZGVmaW5lIEVTX0ZJTEVfRU5UUlkJCTANCisjZGVmaW5lIEVTX1NUUkVBTV9FTlRSWQkJ
MQ0KKyNkZWZpbmUgRVNfRklSU1RfRklMRU5BTUVfRU5UUlkJMg0KKyNkZWZpbmUgRVhGQVRfRklM
RU5BTUVfRU5UUllfTlVNKG5hbWVfbGVuKSBcDQorCURJVl9ST1VORF9VUChuYW1lX2xlbiwgRVhG
QVRfRklMRV9OQU1FX0xFTikNCisjZGVmaW5lIEVTX0xBU1RfRklMRU5BTUVfRU5UUlkobmFtZV9s
ZW4pCVwNCisJKEVTX0ZJUlNUX0ZJTEVOQU1FX0VOVFJZICsgRVhGQVRfRklMRU5BTUVfRU5UUllf
TlVNKG5hbWVfbGVuKSkNCisNCiAjZGVmaW5lIERJUl9ERUxFVEVECQkweEZGRkYwMzIxDQogDQog
LyogdHlwZSB2YWx1ZXMgKi8NCkBAIC02OCw5ICs3Nyw2IEBAIGVudW0gew0KICNkZWZpbmUgTUFY
X05BTUVfTEVOR1RICQkyNTUgLyogbWF4IGxlbiBvZiBmaWxlIG5hbWUgZXhjbHVkaW5nIE5VTEwg
Ki8NCiAjZGVmaW5lIE1BWF9WRlNOQU1FX0JVRl9TSVpFCSgoTUFYX05BTUVfTEVOR1RIICsgMSkg
KiBNQVhfQ0hBUlNFVF9TSVpFKQ0KIA0KLS8qIEVub3VnaCBzaXplIHRvIGhvbGQgMjU2IGRlbnRy
eSAoZXZlbiA1MTIgQnl0ZSBzZWN0b3IpICovDQotI2RlZmluZSBESVJfQ0FDSEVfU0laRQkJKDI1
NipzaXplb2Yoc3RydWN0IGV4ZmF0X2RlbnRyeSkvNTEyKzEpDQotDQogI2RlZmluZSBFWEZBVF9I
SU5UX05PTkUJCS0xDQogI2RlZmluZSBFWEZBVF9NSU5fU1VCRElSCTINCiANCkBAIC0xMjUsNiAr
MTMxLDE2IEBAIGVudW0gew0KICNkZWZpbmUgQklUU19QRVJfQllURV9NQVNLCTB4Nw0KICNkZWZp
bmUgSUdOT1JFRF9CSVRTX1JFTUFJTkVEKGNsdSwgY2x1X2Jhc2UpICgoMSA8PCAoKGNsdSkgLSAo
Y2x1X2Jhc2UpKSkgLSAxKQ0KIA0KKy8qIDE5IGVudHJpZXMgPSAxIGZpbGUgZW50cnkgKyAxIHN0
cmVhbSBlbnRyeSArIDE3IGZpbGVuYW1lIGVudHJpZXMgKi8NCisjZGVmaW5lIEVTX01BWF9FTlRS
WV9OVU0JRVNfTEFTVF9GSUxFTkFNRV9FTlRSWShNQVhfTkFNRV9MRU5HVEgpDQorDQorLyoNCisg
KiAxOSBlbnRyaWVzIHggMzIgYnl0ZXMvZW50cnkgPSA2MDggYnl0ZXMuDQorICogVGhlIDYwOCBi
eXRlcyBhcmUgaW4gMyBzZWN0b3JzIGF0IG1vc3QgKGV2ZW4gNTEyIEJ5dGUgc2VjdG9yKS4NCisg
Ki8NCisjZGVmaW5lIERJUl9DQUNIRV9TSVpFCQlcDQorCShESVZfUk9VTkRfVVAoRVhGQVRfREVO
X1RPX0IoRVNfTUFYX0VOVFJZX05VTSksIFNFQ1RPUl9TSVpFKSArIDEpDQorDQogc3RydWN0IGV4
ZmF0X2RlbnRyeV9uYW1lYnVmIHsNCiAJY2hhciAqbGZuOw0KIAlpbnQgbGZuYnVmX2xlbjsgLyog
dXN1YWxseSBNQVhfVU5JTkFNRV9CVUZfU0laRSAqLw0KQEAgLTE2NiwxMSArMTgyLDExIEBAIHN0
cnVjdCBleGZhdF9oaW50IHsNCiANCiBzdHJ1Y3QgZXhmYXRfZW50cnlfc2V0X2NhY2hlIHsNCiAJ
c3RydWN0IHN1cGVyX2Jsb2NrICpzYjsNCi0JYm9vbCBtb2RpZmllZDsNCiAJdW5zaWduZWQgaW50
IHN0YXJ0X29mZjsNCiAJaW50IG51bV9iaDsNCiAJc3RydWN0IGJ1ZmZlcl9oZWFkICpiaFtESVJf
Q0FDSEVfU0laRV07DQogCXVuc2lnbmVkIGludCBudW1fZW50cmllczsNCisJYm9vbCBtb2RpZmll
ZDsNCiB9Ow0KIA0KIHN0cnVjdCBleGZhdF9kaXJfZW50cnkgew0KLS0gDQoyLjI1LjENCg==
