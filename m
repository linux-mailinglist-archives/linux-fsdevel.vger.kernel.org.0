Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1EE6642279
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Dec 2022 06:10:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231500AbiLEFKg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Dec 2022 00:10:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231463AbiLEFKe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Dec 2022 00:10:34 -0500
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2894FDEA2;
        Sun,  4 Dec 2022 21:10:32 -0800 (PST)
Received: from pps.filterd (m0209319.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B5445uA006120;
        Mon, 5 Dec 2022 05:10:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=S1; bh=QhH9VyPGdNTGqWkZmSmt0Hm58Ex/kwEIfhsELooyTIE=;
 b=S91fQx3+IBD5ElcY5WOHeBtm+TE1VnE0GNOoYrvd++2PeGpHNHY1SQAQqTmuW3bimwTo
 I+DmTGZYrQ3cr4XvJobquhiEu3DY9PDvMVSN7+xmC+Vyj+tQgkywxtz0kPM8nhhUFqLe
 14nw6IkUM92t7FWiaRoM48UFY4AQcNteWex/K2TIM6Eju0kbVdzOLV4pcGY5Ob8UHTtF
 HAu9W6LczccKFKBOkt63AFw5R8l022Zc9FDcw86bKiRi54DiOg040JvATa+7cFtamxA4
 GE1FOkKhI+Z4zG8TQ5b7x8Jmm+Es2AQQY+XPKOKdgg/gdB0xdBohMVYps/qIFuE0aJ8X ZQ== 
Received: from apc01-tyz-obe.outbound.protection.outlook.com (mail-tyzapc01lp2040.outbound.protection.outlook.com [104.47.110.40])
        by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3m7yfghadc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Dec 2022 05:10:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WoAS7B1vg3XKg85ff5lYLxBayoujEYxA/WSbj4XZBSSCijPXQYy8nFcEwWnXPrApyhxCLyeYC57LM7yYYICQZSRAHx6Ja8Q9f6iUrG4JH/ZpAbYLRSz/4YViAKECjvLldSOAt80CMFfVW5feHfzExlWqTdU1kPpErHHUF2zNFdQJQW/TSvwuFbcP4PenVZCTJiQY7ZAh1i+oqpkp4yMNqv406IrBAOsEMBoGfIQ7hsTjoLI/WFG0rlBEL/1I7/6pKln9S0ox1/h9GM4T5utcNaldRPnTJNozg7xQQO+50pu8fMbpNc3JMVEJwI3SCggk8eoLgC+U08V1ezFN4nqTOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QhH9VyPGdNTGqWkZmSmt0Hm58Ex/kwEIfhsELooyTIE=;
 b=S4GTRvgFICEuJRhPyZ9xcpxIKmiI0JbTY0JU7CaLHmOY2FE7lL0Myvo5PFAuFEDjuQph56qfBjFVBzxdWMtZ9tPDQSp4CYDOu26aE/gbWAJ9vHTrouGYgaEdixvNzPAvs7IBO9yK5nVltjKt9FN7WWkdmMAzCu/Ihv0pO/tTryUYn/D7HOVsKh/3Z7JtwPNcgIvEmM9IUp8yaDM3+PHCjQ/a6y8nOAnrmsYWnDKDUlOT4BNvkKpWPNWp3mtcx381tE1m28QkN13w+jFwjARbJ7P7lzVwwpH6xU8ZJMbIkqaF8hSi4iKobbD1XyVMisCKI41/5d+FyAldm9e4MKFi4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by PSBPR04MB3909.apcprd04.prod.outlook.com (2603:1096:301:2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Mon, 5 Dec
 2022 05:10:10 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::c689:d665:b3a2:d4de]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::c689:d665:b3a2:d4de%6]) with mapi id 15.20.5880.008; Mon, 5 Dec 2022
 05:10:10 +0000
From:   "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To:     "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>
Subject: [PATCH v1 3/6] exfat: remove unnecessary arguments from
 exfat_find_dir_entry()
Thread-Topic: [PATCH v1 3/6] exfat: remove unnecessary arguments from
 exfat_find_dir_entry()
Thread-Index: AdkIZj3HTv953xMKQy2/a3f6bPetrQ==
Date:   Mon, 5 Dec 2022 05:10:09 +0000
Message-ID: <PUZPR04MB6316B2458A3E3038F0889D2181189@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|PSBPR04MB3909:EE_
x-ms-office365-filtering-correlation-id: a3c5e62f-2e23-4360-a968-08dad67efb83
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GIF/UtOfx2FewT3uqEKEtTERSABuFl/p7mVkNcepqm442VXM2SONxnt/vlFMtXryX/LKrnSAercIoG6k55ftqcddYEH4DlLsXeFZB2uuoSmE5sZ4VF5BcJdfUGpIGFtp+tcX8EOMLzWDVQQFZkiX6DeP04XG8e8xnA/omp9ExieGRIsMTmCmaAtuZDeMtrZPDG3w2Uiqp67syPyOCD0FNp7uQTSAK3OTlTTISFKP4mKp/cX0iYQc7Rc/BQ9t7jDjaZI5YVhilzogF40hYsOd6zxBvbs6wPNoedVHsIPHMo/G4KErrhVUQAPA0uKBV63atX6K7AtOeCAlueX3Ahd31UB/Sm7NNxdzGBj5w4NTrnFn+pokFMzbGWnbK16H/sGnJkmFa7Gp9yr6Y42wog9BU2IjODkjsnuoN3D+1feO8dTQ4TD+Rqm5JlcIjp+AJZEwLTUyX+mAVcbh9zcMiLeDPV+2e68XjxHswf0PN+C596ZT+lQoeRX8jrZxlhnGAYG8D1RsYGW2AZREMd2SwwsRgsy6TGTUMvy+ggkdapYXP0o8By6OmFoDauLXdGx9HemdCz3PHlqUp6spfWs4hZ8I8xJR/mtU5KqPbx1oVGujpWsKa5hFKJDlVBUxWcKggBtJGIwbnaRODfAXQPqqX/xnc2Hck2s8OkElcRGEl+scMhpjLv4QuNtmMLp/IQrsJFzJtWgtW/Db1JKIBbUxd15i2w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(396003)(136003)(346002)(376002)(451199015)(26005)(316002)(107886003)(478600001)(6506007)(7696005)(54906003)(110136005)(9686003)(71200400001)(76116006)(66556008)(66476007)(8676002)(66946007)(4326008)(64756008)(66446008)(8936002)(52536014)(5660300002)(186003)(83380400001)(41300700001)(2906002)(122000001)(38100700002)(82960400001)(38070700005)(55016003)(86362001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QXg5dnlWSHQ1aGowMTd6Qi9qVTM2akJLZTIyNkg3cytlbHJMVDdPRFNQZTdF?=
 =?utf-8?B?aFJpZFV2N3cwdWljRTdKdWlPVVltbXhMbTlBNHFkdzUxSWJpK0NZT2RGQlM4?=
 =?utf-8?B?WVYwYWRlbU5VdDlzemFuWC9WVFpFNit0TGI5QjhSRklHTXY5NUd1bjFyNzdn?=
 =?utf-8?B?S0p0STFPbXlIazZSUjBYUXdoYTZRTm83V1ZHYXRDNGpNNllCeFh5TVBmblBk?=
 =?utf-8?B?bk1mam11VmpGMWpvSEZsU3EzK2FzRnNYUkZIQVNtUjcwc2xPa3lESktRbXdK?=
 =?utf-8?B?SWN6TjNrQlFkUTZUUEloUWpDL2o4ZkFXQzZ5T1orSHhLQ3RVNEw4d2RBSS9k?=
 =?utf-8?B?aU1ZOFdnelFxazdDZXJVbGVhQlh6bWp2MTV4YzY1aGh0TTYwOCtiUHkzSFRp?=
 =?utf-8?B?MHZCNVlzM2Vrd2xaZVRIUkdqWHUrT3FKZU5tUU9Ddm9KQ0t0bnRTMXZjMFdI?=
 =?utf-8?B?My9oQVJNTnZEdkttNFoxNThXZzVhV00wMXJ1bjRrS2ZDcGpRcHZ3WXRCdnZj?=
 =?utf-8?B?dWZJWmNJaWw3MmVmaHVvd1U5L0hXOFNXcFdidWtiSU1qTFV4K0R0Mzk4UHBR?=
 =?utf-8?B?bnhuRjh1NHl1czRWUkNYbUNzbEtsSlR2bVA0RlpGV2M5enFTMHp4MmpoUzFm?=
 =?utf-8?B?VG5pSVRxaVU0NlBaL2ExNnMxa0xiaTF5Smd0d1Y4bGNRbEZRMWdVTGtvV0Jy?=
 =?utf-8?B?eHhWSnNHUEtHbkVVMmR0ZDM0TW53UDF6TkIwSmkvbGFiQ0NkNEYxdE0vUG1V?=
 =?utf-8?B?cCtVMm1sSFJ6TVVRRENNT29yL1ZOcVFtS01uY0M3WENkSDFkN2pnZUJkSVIx?=
 =?utf-8?B?bVp3bzJjRmdNdnBDeVdRQTg4MjBrcjNQUVNQQUgremdGUldHTUZneDJ1dnVl?=
 =?utf-8?B?SW5YU3BxY1c5d2pGS1NzQ240TE95U2RjazdIUE5pL1hTMzAzd3BYbHJ6WXg1?=
 =?utf-8?B?Z0x2V1Qwd1VDUnNjMDlRWGh0MXRnRjR6cS9Qc0dZdkhOQmZqMzl4ZFcvYlZR?=
 =?utf-8?B?M2d2SEpXVEJFVDFKVUtMVmNHdFpjdUNVNXUvMXVvRlBxMzdSTnB5dHZRTncw?=
 =?utf-8?B?ei9ueFJ3UzdmUWdxRGVCVGFwVmdtQ2VLZGFQNjBoOWxjK2tBUVllbmtuWXph?=
 =?utf-8?B?VlNvTmR2UnhoWHJQd2tndVhwM2s3RXhIbHVpOUtVaFp3dzlEMDh0RlgrcEpt?=
 =?utf-8?B?QnR3cGRjR1NzZ0lhajdybmZJUmRHbFU1VGlLVlBnZUpMSzNjV0h6b2UxNTJy?=
 =?utf-8?B?SHMzdi85SC9DQnBXRFZaYndMMzFjVHYxM3YyZ0NvaS9CaHV3eEJVYmFFVnU5?=
 =?utf-8?B?b1QweFZLZFRLdWNkVTJXTTBnSmR3R2xvYlgydmJyQ3FXUmFUbWVSMXpjclh1?=
 =?utf-8?B?UkJweThQY1hLcWJuYmVhQllNOU9sS1VmalF6bHdhZWQvbEdnRVRUbEtZUVFJ?=
 =?utf-8?B?cGNLb1ZhRFpaK3pEZDRJTmFJdzRsdkxRYTFqaVczaktCS1RoUHNObHZXZDJY?=
 =?utf-8?B?S0JrOGJ5UzlMaTJrZ01vUVY5Qk5ZVklneS85UzV1SUJQYlpPMTUvTzluSEdW?=
 =?utf-8?B?TlV1L0JLK3pGSlVDd1VLNTJGQitRcCt3bFFiMTJkajY1S2ovbjlHQjVnOVNo?=
 =?utf-8?B?MzlaekwxU0lHZUY0RENDTnd6a2hiVGRLeDdrRkxBdFJ2SStlSGd4cEZzUFhU?=
 =?utf-8?B?UDdleDVUbFB1R3VZVFhwekxLK2ZYSU81TGE0dXlUenNpa1pVTmFQTndaKzh6?=
 =?utf-8?B?a0VpSHJLa2tmejFBK2NScUhMdXYwVTU3QUcrYm40a0x1d0ZyaDRuVVBtUlZu?=
 =?utf-8?B?RlpCK0d2bXJSeHJ1SWNoTGdidzVWR3J6S0VQNUpnVEhGQ2ZMSDEraE9BK0FH?=
 =?utf-8?B?VWM3aXdadlZ5RGRuTUlET3k0azhpM2lmUzV6cmp6NHJjOFpiVldoQVZiU0Ew?=
 =?utf-8?B?OEF2VjBLVmlxdlFiZklyN1lSZ3RrZ2V2YnR6czBuQSthT09lQjZPb3JLMFZZ?=
 =?utf-8?B?Vm5tZWtnd1ZtRTZDSEVEczY2RGVuRFdSTzJDYzBwUDZva09XSzAxVFF1TFVK?=
 =?utf-8?B?bVlNRjJxci8vdFhEeXpwMm9YVnBReWpSTzFPanRKbG1CNnR5L29ISGlxei9O?=
 =?utf-8?Q?ge66li7gBA/+4BEkZZvSXx9nY?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: AupgN5D95/UfZA9hs42AWpHeP/wy7ozjAqq8437uYa7iK1ux0OumeN8JbPTxKW0Cl32c3h2SIVIbJD+E2HJI613KCBl309OyR6RWkCkhzcxqzq+HhhLmflPqez3XBaKJ5oiJ5l1DwxVROPDvJMVeHPO8S41j72hDRhHOJOBrBYFBkqwwoTzlhkKylRUHeyFoMIhdzaiYMPu2Qasq5sCM1DNAOsn+sqmZlj9gzfuhc1iW9nyW5D4Jpf21HSapkcTYJHd4Y7/YzuBP9lGGWnnP4yATDjlD/lNIM/bCiI1XBSxMcIqx0EKLM4cxTpd4IUl2o2uawalnD6T0Ueef/4HtJgBUUMOsnutdBL9U2YHvC5+EIa+DPa4UyPu+r+6Ncg+y+zflN4LTQh2OBxZUu6DyQiEUURiCTUOtQtfhfo9jkBYLYVs0gtkh4kSAmJGMjbP/gDLvQRmEbXmvdQUc0hVPD4UkuT75DGfA0zNjztZuRDAOi1btfJ2U1QTmjMSBQAPs4zzAgYsJ+itTHAN0B3TSjntM6+qta3/sYfBP7tUZaIW8Jh8v+yVbLmMh5KJ/VqSM7j3Nv4A+okpQyHQsag4pAGOyknrY3WMB7bdbRcLSfM4Df+qZ1Dmd4vwdu2WUuGR507FP0cZl5XdoRT454BhFluw++GY3sLnto7DXHZttSYF3JVV2BXtTMuZ6WyyFTASGSrVMXIFvfZAzyw/lAQna+R+Glx/PvzgVJLKXzu7OXqJlHk4vr/+BuAzUZAQQUm94do+ShztLScvR0jne1Kvykn0KljurDU2mcyOEPTSajC5wmOFkMBdIhOsgr2/5sreJFnUQgPsrmV82q5U+iM5mN2pPoKBbMlViCoKdMC0moriRJ1yWzKcSIEVmoz8af7ND
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3c5e62f-2e23-4360-a968-08dad67efb83
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2022 05:10:09.9654
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Sk5VaZwQmJFJw13bycR41tEbvpyXHHoC8rzKGgcwo30pB0v1kjxW3zy+iin0gb22rxqjlXxEO+J1nQHxXX8HPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSBPR04MB3909
X-Proofpoint-GUID: H4u1S6m0n4qdrO1IqV--v2ATmot5yZ2L
X-Proofpoint-ORIG-GUID: H4u1S6m0n4qdrO1IqV--v2ATmot5yZ2L
X-Sony-Outbound-GUID: H4u1S6m0n4qdrO1IqV--v2ATmot5yZ2L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-05_01,2022-12-01_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

VGhpcyBjb21taXQgcmVtb3ZlcyBhcmd1bWVudCAnbnVtX2VudHJpZXMnIGFuZCAndHlwZScgZnJv
bQ0KZXhmYXRfZmluZF9kaXJfZW50cnkoKS4NCg0KQ29kZSByZWZpbmVtZW50LCBubyBmdW5jdGlv
bmFsIGNoYW5nZXMuDQoNClNpZ25lZC1vZmYtYnk6IFl1ZXpoYW5nIE1vIDxZdWV6aGFuZy5Nb0Bz
b255LmNvbT4NClJldmlld2VkLWJ5OiBBbmR5IFd1IDxBbmR5Lld1QHNvbnkuY29tPg0KUmV2aWV3
ZWQtYnk6IEFveWFtYSBXYXRhcnUgPHdhdGFydS5hb3lhbWFAc29ueS5jb20+DQotLS0NCiBmcy9l
eGZhdC9kaXIuYyAgICAgIHwgMTIgKysrKysrKy0tLS0tDQogZnMvZXhmYXQvZXhmYXRfZnMuaCB8
ICAzICstLQ0KIGZzL2V4ZmF0L25hbWVpLmMgICAgfCAxMCArKy0tLS0tLS0tDQogMyBmaWxlcyBj
aGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspLCAxNSBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBh
L2ZzL2V4ZmF0L2Rpci5jIGIvZnMvZXhmYXQvZGlyLmMNCmluZGV4IDM5N2VhMmQ5ODg0OC4uODEy
MWE3ZTA3M2JjIDEwMDY0NA0KLS0tIGEvZnMvZXhmYXQvZGlyLmMNCisrKyBiL2ZzL2V4ZmF0L2Rp
ci5jDQpAQCAtOTU2LDcgKzk1Niw3IEBAIGVudW0gew0KICAqLw0KIGludCBleGZhdF9maW5kX2Rp
cl9lbnRyeShzdHJ1Y3Qgc3VwZXJfYmxvY2sgKnNiLCBzdHJ1Y3QgZXhmYXRfaW5vZGVfaW5mbyAq
ZWksDQogCQlzdHJ1Y3QgZXhmYXRfY2hhaW4gKnBfZGlyLCBzdHJ1Y3QgZXhmYXRfdW5pX25hbWUg
KnBfdW5pbmFtZSwNCi0JCWludCBudW1fZW50cmllcywgdW5zaWduZWQgaW50IHR5cGUsIHN0cnVj
dCBleGZhdF9oaW50ICpoaW50X29wdCkNCisJCXN0cnVjdCBleGZhdF9oaW50ICpoaW50X29wdCkN
CiB7DQogCWludCBpLCByZXdpbmQgPSAwLCBkZW50cnkgPSAwLCBlbmRfZWlkeCA9IDAsIG51bV9l
eHQgPSAwLCBsZW47DQogCWludCBvcmRlciwgc3RlcCwgbmFtZV9sZW4gPSAwOw0KQEAgLTk2Nyw2
ICs5NjcsMTAgQEAgaW50IGV4ZmF0X2ZpbmRfZGlyX2VudHJ5KHN0cnVjdCBzdXBlcl9ibG9jayAq
c2IsIHN0cnVjdCBleGZhdF9pbm9kZV9pbmZvICplaSwNCiAJc3RydWN0IGV4ZmF0X2hpbnQgKmhp
bnRfc3RhdCA9ICZlaS0+aGludF9zdGF0Ow0KIAlzdHJ1Y3QgZXhmYXRfaGludF9mZW1wIGNhbmRp
X2VtcHR5Ow0KIAlzdHJ1Y3QgZXhmYXRfc2JfaW5mbyAqc2JpID0gRVhGQVRfU0Ioc2IpOw0KKwlp
bnQgbnVtX2VudHJpZXMgPSBleGZhdF9jYWxjX251bV9lbnRyaWVzKHBfdW5pbmFtZSk7DQorDQor
CWlmIChudW1fZW50cmllcyA8IDApDQorCQlyZXR1cm4gbnVtX2VudHJpZXM7DQogDQogCWRlbnRy
aWVzX3Blcl9jbHUgPSBzYmktPmRlbnRyaWVzX3Blcl9jbHU7DQogDQpAQCAtMTAyMCwxMCArMTAy
NCw4IEBAIGludCBleGZhdF9maW5kX2Rpcl9lbnRyeShzdHJ1Y3Qgc3VwZXJfYmxvY2sgKnNiLCBz
dHJ1Y3QgZXhmYXRfaW5vZGVfaW5mbyAqZWksDQogCQkJCXN0ZXAgPSBESVJFTlRfU1RFUF9GSUxF
Ow0KIAkJCQloaW50X29wdC0+Y2x1ID0gY2x1LmRpcjsNCiAJCQkJaGludF9vcHQtPmVpZHggPSBp
Ow0KLQkJCQlpZiAodHlwZSA9PSBUWVBFX0FMTCB8fCB0eXBlID09IGVudHJ5X3R5cGUpIHsNCi0J
CQkJCW51bV9leHQgPSBlcC0+ZGVudHJ5LmZpbGUubnVtX2V4dDsNCi0JCQkJCXN0ZXAgPSBESVJF
TlRfU1RFUF9TVFJNOw0KLQkJCQl9DQorCQkJCW51bV9leHQgPSBlcC0+ZGVudHJ5LmZpbGUubnVt
X2V4dDsNCisJCQkJc3RlcCA9IERJUkVOVF9TVEVQX1NUUk07DQogCQkJCWJyZWxzZShiaCk7DQog
CQkJCWNvbnRpbnVlOw0KIAkJCX0NCmRpZmYgLS1naXQgYS9mcy9leGZhdC9leGZhdF9mcy5oIGIv
ZnMvZXhmYXQvZXhmYXRfZnMuaA0KaW5kZXggMzdlOGFmODA0MmFhLi4yMWZlYzAxZDY4ZmYgMTAw
NjQ0DQotLS0gYS9mcy9leGZhdC9leGZhdF9mcy5oDQorKysgYi9mcy9leGZhdC9leGZhdF9mcy5o
DQpAQCAtNzEsNyArNzEsNiBAQCBlbnVtIHsNCiAjZGVmaW5lIFRZUEVfUEFERElORwkJMHgwNDAy
DQogI2RlZmluZSBUWVBFX0FDTFRBQgkJMHgwNDAzDQogI2RlZmluZSBUWVBFX0JFTklHTl9TRUMJ
CTB4MDgwMA0KLSNkZWZpbmUgVFlQRV9BTEwJCTB4MEZGRg0KIA0KICNkZWZpbmUgTUFYX0NIQVJT
RVRfU0laRQk2IC8qIG1heCBzaXplIG9mIG11bHRpLWJ5dGUgY2hhcmFjdGVyICovDQogI2RlZmlu
ZSBNQVhfTkFNRV9MRU5HVEgJCTI1NSAvKiBtYXggbGVuIG9mIGZpbGUgbmFtZSBleGNsdWRpbmcg
TlVMTCAqLw0KQEAgLTQ5MCw3ICs0ODksNyBAQCB2b2lkIGV4ZmF0X3VwZGF0ZV9kaXJfY2hrc3Vt
X3dpdGhfZW50cnlfc2V0KHN0cnVjdCBleGZhdF9lbnRyeV9zZXRfY2FjaGUgKmVzKTsNCiBpbnQg
ZXhmYXRfY2FsY19udW1fZW50cmllcyhzdHJ1Y3QgZXhmYXRfdW5pX25hbWUgKnBfdW5pbmFtZSk7
DQogaW50IGV4ZmF0X2ZpbmRfZGlyX2VudHJ5KHN0cnVjdCBzdXBlcl9ibG9jayAqc2IsIHN0cnVj
dCBleGZhdF9pbm9kZV9pbmZvICplaSwNCiAJCXN0cnVjdCBleGZhdF9jaGFpbiAqcF9kaXIsIHN0
cnVjdCBleGZhdF91bmlfbmFtZSAqcF91bmluYW1lLA0KLQkJaW50IG51bV9lbnRyaWVzLCB1bnNp
Z25lZCBpbnQgdHlwZSwgc3RydWN0IGV4ZmF0X2hpbnQgKmhpbnRfb3B0KTsNCisJCXN0cnVjdCBl
eGZhdF9oaW50ICpoaW50X29wdCk7DQogaW50IGV4ZmF0X2FsbG9jX25ld19kaXIoc3RydWN0IGlu
b2RlICppbm9kZSwgc3RydWN0IGV4ZmF0X2NoYWluICpjbHUpOw0KIHN0cnVjdCBleGZhdF9kZW50
cnkgKmV4ZmF0X2dldF9kZW50cnkoc3RydWN0IHN1cGVyX2Jsb2NrICpzYiwNCiAJCXN0cnVjdCBl
eGZhdF9jaGFpbiAqcF9kaXIsIGludCBlbnRyeSwgc3RydWN0IGJ1ZmZlcl9oZWFkICoqYmgpOw0K
ZGlmZiAtLWdpdCBhL2ZzL2V4ZmF0L25hbWVpLmMgYi9mcy9leGZhdC9uYW1laS5jDQppbmRleCAz
NDdjOGRmNDViZDAuLjVmOTk1ZWJhNWRiYiAxMDA2NDQNCi0tLSBhL2ZzL2V4ZmF0L25hbWVpLmMN
CisrKyBiL2ZzL2V4ZmF0L25hbWVpLmMNCkBAIC01OTcsNyArNTk3LDcgQEAgc3RhdGljIGludCBl
eGZhdF9jcmVhdGUoc3RydWN0IHVzZXJfbmFtZXNwYWNlICptbnRfdXNlcm5zLCBzdHJ1Y3QgaW5v
ZGUgKmRpciwNCiBzdGF0aWMgaW50IGV4ZmF0X2ZpbmQoc3RydWN0IGlub2RlICpkaXIsIHN0cnVj
dCBxc3RyICpxbmFtZSwNCiAJCXN0cnVjdCBleGZhdF9kaXJfZW50cnkgKmluZm8pDQogew0KLQlp
bnQgcmV0LCBkZW50cnksIG51bV9lbnRyaWVzLCBjb3VudDsNCisJaW50IHJldCwgZGVudHJ5LCBj
b3VudDsNCiAJc3RydWN0IGV4ZmF0X2NoYWluIGNkaXI7DQogCXN0cnVjdCBleGZhdF91bmlfbmFt
ZSB1bmlfbmFtZTsNCiAJc3RydWN0IHN1cGVyX2Jsb2NrICpzYiA9IGRpci0+aV9zYjsNCkBAIC02
MTYsMTAgKzYxNiw2IEBAIHN0YXRpYyBpbnQgZXhmYXRfZmluZChzdHJ1Y3QgaW5vZGUgKmRpciwg
c3RydWN0IHFzdHIgKnFuYW1lLA0KIAlpZiAocmV0KQ0KIAkJcmV0dXJuIHJldDsNCiANCi0JbnVt
X2VudHJpZXMgPSBleGZhdF9jYWxjX251bV9lbnRyaWVzKCZ1bmlfbmFtZSk7DQotCWlmIChudW1f
ZW50cmllcyA8IDApDQotCQlyZXR1cm4gbnVtX2VudHJpZXM7DQotDQogCS8qIGNoZWNrIHRoZSB2
YWxpZGF0aW9uIG9mIGhpbnRfc3RhdCBhbmQgaW5pdGlhbGl6ZSBpdCBpZiByZXF1aXJlZCAqLw0K
IAlpZiAoZWktPnZlcnNpb24gIT0gKGlub2RlX3BlZWtfaXZlcnNpb25fcmF3KGRpcikgJiAweGZm
ZmZmZmZmKSkgew0KIAkJZWktPmhpbnRfc3RhdC5jbHUgPSBjZGlyLmRpcjsNCkBAIC02MjksOSAr
NjI1LDcgQEAgc3RhdGljIGludCBleGZhdF9maW5kKHN0cnVjdCBpbm9kZSAqZGlyLCBzdHJ1Y3Qg
cXN0ciAqcW5hbWUsDQogCX0NCiANCiAJLyogc2VhcmNoIHRoZSBmaWxlIG5hbWUgZm9yIGRpcmVj
dG9yaWVzICovDQotCWRlbnRyeSA9IGV4ZmF0X2ZpbmRfZGlyX2VudHJ5KHNiLCBlaSwgJmNkaXIs
ICZ1bmlfbmFtZSwNCi0JCQludW1fZW50cmllcywgVFlQRV9BTEwsICZoaW50X29wdCk7DQotDQor
CWRlbnRyeSA9IGV4ZmF0X2ZpbmRfZGlyX2VudHJ5KHNiLCBlaSwgJmNkaXIsICZ1bmlfbmFtZSwg
JmhpbnRfb3B0KTsNCiAJaWYgKGRlbnRyeSA8IDApDQogCQlyZXR1cm4gZGVudHJ5OyAvKiAtZXJy
b3IgdmFsdWUgKi8NCiANCi0tIA0KMi4yNS4xDQo=
