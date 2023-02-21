Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3741069DB49
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Feb 2023 08:35:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233658AbjBUHfJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Feb 2023 02:35:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233656AbjBUHfE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Feb 2023 02:35:04 -0500
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B4C2A270
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Feb 2023 23:35:03 -0800 (PST)
Received: from pps.filterd (m0209323.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31L6sUUq013847;
        Tue, 21 Feb 2023 07:34:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=S1; bh=7ohFektqA0LiNvF7AArgLumAu2Q7Yl5BbjRcnIgmNNQ=;
 b=HNijkcTnxtwhh8nvQSPtpeyih3kGhP+YewqgQmYq+9+O1vKjxbKxoVKirL/bGpLUlkwW
 YBJw5SWQKwitX64Ovy/dPlwIWqEhTWLgkcgPJw+agdukoqrVtcWZ78o8cTAzMZSdK8K/
 MK1sdKAjBH5TrPvUskI2zvXMVk5BhLX9ahNxycQF0sznUBULdm2K8Ho3OYBPHq3cPKnE
 m3mU6jLcp0/0LMP+3gOn6fgVm9/Mk/e1yArr0clWPRqUyzTc2W0ZprtstbQyS4iGN30g
 /h+FcUdMQfNpAQXW2AsWeLqs8aUXw/zNFl4b8t6SypkWUShvYJdFfX7u3blvsRmo9gdH bg== 
Received: from apc01-tyz-obe.outbound.protection.outlook.com (mail-tyzapc01lp2040.outbound.protection.outlook.com [104.47.110.40])
        by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3ntp11tucy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Feb 2023 07:34:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VHqnycWIqkT7A6na7O8aN1GjE3Qlz7JFcmHlS7MVZKGn8b6Jary2juUKP5iUU4GHMowdIHCTBAaQ8rmIjBu9A2PwnCdLGip4egOgm882J15tLUda5Ca7irMnoYtrM+3UglQuj4Ai8qwzpKTvKNTjZx0wXOoGOR2XgKSFb7xzabJZrclT2J04V+x23HDYk5CQbgWKkdDyP3bZzR8b3C85ZjTI9tMm0d1NQOGdJ8NBOPwSbBBsVALL3zpQdHEHCY969kINXXgiajO5ESXekafD4VO+mdDAK81toYBoEfbqH9TkVvnEr3sjAPM06adsVTb6kxxbW4vGYGW8TtA0Z8zB5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ohFektqA0LiNvF7AArgLumAu2Q7Yl5BbjRcnIgmNNQ=;
 b=gKppwqbNYyE+cu1Cdv0cOIPikeC5+lg63u+dqHklWcliai0isOVdXdIrdDHzuOLL9yLO235YbNG7UlMb5WeomnX28k1APtGUOtbsU8LKuFVGMSiU8suNPh8n6m2Uy/VNN4h9S7slTbc1jwqcE54DfalRsUB7y84KtDVDOVCjYpWvLlDxo20Cx5M4H0AXDSGoOQlx5FTNqiyFMrGIDusQMH9E9ZvtUFtnhAaAWaBufD3k43vxzQWRGFFf7iK217Ek8SmN4NyzPgRQFpJQwULbIzrzJkPj9E1roA8vUSWTl5qocSvKUVlYqweULLcqjL8HVI3NO9T8JqL6xo0MctZmuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by PSAPR04MB4165.apcprd04.prod.outlook.com (2603:1096:301:34::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21; Tue, 21 Feb
 2023 07:34:48 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::779:3520:dde5:4941]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::779:3520:dde5:4941%7]) with mapi id 15.20.6111.020; Tue, 21 Feb 2023
 07:34:48 +0000
From:   "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To:     "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>
Subject: [PATCH 3/3] exfat: fix the newly allocated clusters are not freed in
 error handling
Thread-Topic: [PATCH 3/3] exfat: fix the newly allocated clusters are not
 freed in error handling
Thread-Index: AdlFxnPdDHWMMvx/Tn2pD0MXxIUl0g==
Date:   Tue, 21 Feb 2023 07:34:47 +0000
Message-ID: <PUZPR04MB6316A8F257BCF4D6200FD14081A59@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|PSAPR04MB4165:EE_
x-ms-office365-filtering-correlation-id: c7ee2cd2-bafb-40ca-ee69-08db13de1c20
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gLU8i4PK0LUQXk1+Gg8LUVRs/wXn1rQDN6AtzI913YYMLUr5EjO2KU39Jkf1KgWjpY7qg+v/2L0fktISqRTd+4s8d+1DgtZ2Ok5DTUNlsy/BmMXhwPENpVi9sphXdwCnsD32EraktAM0177rnt+ezwShw2Z6axW/wknZ8qdTLL9mkbl7wwAuAhliC4ieVlRBV4P1NUbGhrbNArClQZ4EWbZdpntmXd9A+khQvYXHFWKX8TyT1aWFzN/9T3BxTC31T25SLv+iy+VeRIfVTrL1By48FULEUMTWY8XqRRxPFgw+id+GTY30Yx9nRp5a0XEVVfGa1ZgNw0QZkuUCZx7k793vrHjxkoWxPlWB9w6Mzt55r0lBNBMnKZ36ajaoYVYHDVmQUj0HVsNWdzBZSkXz2TbkAJEmzJPnIpEEq+QQp83qdKvYjyYyghD2i6RXxkImJxiuIaJGoURN+tg6WVTsRpyeJzSKAleDW9gk6bW6UEEaGx3p8UTrvL/ZtoYQI5ma8V4JlMCAvh7ubl/2i8P8TNgVgEBmkzv9Uve5yqetI0imP/1kIlJibMCVZxLwgObCWTqGkfCgGznN7Ty88t4PbTbxCdOpz/enRJyM8CiPdFGVzT+ZdbLRwBuHZogmnqiSd3TZXuWuEmGwBE91TLZ82QiBWNkUK8HYyoN/O1IEnDZ/L4JB36jQvOCau1HiHdZnuVN8BQ5I+S3RCXYh5RKa7A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(366004)(39860400002)(396003)(346002)(451199018)(82960400001)(122000001)(38100700002)(83380400001)(86362001)(316002)(54906003)(8936002)(5660300002)(64756008)(66476007)(8676002)(4326008)(110136005)(55016003)(41300700001)(478600001)(38070700005)(107886003)(33656002)(7696005)(76116006)(66946007)(2906002)(71200400001)(66556008)(66446008)(52536014)(9686003)(186003)(6506007)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L0pTTTBoYWVUWDM0S1M1UXlFRjZtVTdEdGxNaEVjRzlQMjQ5ODVKcFcyVkJn?=
 =?utf-8?B?OFhBbm1xZ3pqZWhXdDN2bUpNZXdsZ1hYVXVRQktrL2MxWFd0eHN3TzZQa2s2?=
 =?utf-8?B?bzQ5cnQ3OWFHQmpSdUxJQ3EzK1BvQ2Rha05BZnQ5c3NsbndudmFuYTlZVld2?=
 =?utf-8?B?d0tlNVpjRW9HK0ROY2l6THR3NUJKRG10Tm9Kd1U1NUk1SHlMbUFkYy9DalF6?=
 =?utf-8?B?SXYwdXp3OTNLWUVja2Era2xJZE9OYUhMK1Q3QlpnMXMxRFNvd3JqNlphV0xj?=
 =?utf-8?B?MEk4ZjBDR0NYbkFSYU8rZWlObHFDamgyTnh0enZ1ZmhqYURaSUVTVVV6RFBL?=
 =?utf-8?B?YVdOd0VyeEVvWUpJODNXT3d2OEJPTE5mcVdNNGwwVTNRaXFNMFBOZklrbk81?=
 =?utf-8?B?NE5iMGlRYUFPaWVvYXVVUjI0L0ZqT3FlUjNHODRnTXo3dS9DWkg4TEhiZ0pB?=
 =?utf-8?B?YkJMOGdRNUExS2hIREZnUXBQQUVXblY4TXQxMmJrdjYxeEFObGNYWnVyNmZK?=
 =?utf-8?B?S0h4ejNJSGVtL0NjdkpiOURVdjQ2VzBrRkxIckNNcnhaUDdMVWYrNTZCVnNn?=
 =?utf-8?B?bmQ1a2cyYXpYRmhpZlZpbU8yWUk5elV0NzZuWjkxTHlzQi9LUW5FK2U3VzJR?=
 =?utf-8?B?VjJoblN2Q1BDOTluQW92dzA5U292ZkZ0RmZMQWtJYldYakVMSjA5RHdReWdz?=
 =?utf-8?B?dmllY08yVWtsYmJPU3JUcGtQZFNrR1FURjE5TFNqV0VvMTZkNzNmRlB4U0p1?=
 =?utf-8?B?YnR6akZSQVU2azNiUjNYWHZnYVBKOG5YdHNtbXRBRUk2MWpMWFdWRXU0Wlh1?=
 =?utf-8?B?aEJvUG5oMXRDdWxCdWk4RXhGZndBc1EybmQ0TDh4ajBZUklKUWJxaldyRTBj?=
 =?utf-8?B?b1d6MisvczZaZmk5aE11anNzQjNCc1RmSHZna1NjUzJxS1FWQzREbnFKWlha?=
 =?utf-8?B?VmJuMEhVSUdKMFk3VmxqY29yVWJJei9ydFV6QUhYYWlwYWVpbE9lZGlHZUFk?=
 =?utf-8?B?eWZwTGIzUHZBTFdVWDVmN3Z0djZrSlhqRGpYRTJQeEdmT0luRkNCd3NHMWRU?=
 =?utf-8?B?SnhtK2EvekpyclNmODA4SzU1Z01VdmhVWXE2eVM5cHZId1h4UVcvUlVKZndu?=
 =?utf-8?B?UTk2dHhvcWZYRUV5aEQ1b0dwYjU3WjhxZS8xSCszYU5TQTlXNjF5NDJRZzBE?=
 =?utf-8?B?N3ZtOUwrdzZhazVzbXRrUWwxQURyRmdQYzhqWnhsRmMzS3FjbzVhNmZpRXFT?=
 =?utf-8?B?S0wwZ3hLdENWaXBEdm15dUJYTE1jVXRYcUI4RGQrT1JCSVZyL0ZyTzAzZXM4?=
 =?utf-8?B?dXZYSm1mSGh2TkFnaEFYc3M2aWQwbHlkU0trbTJQa0FTVkhBWDMzcWp0ZFAr?=
 =?utf-8?B?Tzh5ZzY1c2I0T0pNNVQ5TDdpcGxHTHNpQXZYTGl3MUZFYlF1OGMvaWM2TUR0?=
 =?utf-8?B?dFkybDN4c25nTUhQeUpqUUsvdkxvanE5WWY2TTl4aWtpTkhOSEJpOHl2L3Ro?=
 =?utf-8?B?R3BQWkUxbFZ4ektmMk1Ka1kwUFVwbG9YRzVsY0FnNXc1NC9kdjZTSzB6d2Iv?=
 =?utf-8?B?ZFJGQ25XRkZBYVJXdWVYcmliZ2RibWFaTHhzdG15ZkRHUHUxR3Z3U3FQelpj?=
 =?utf-8?B?SEZzUHBxTkt2VWFjU1NxZHFmNGlOMmsyYnZycTV2MUVGOEJLWFcxbWh5U3lR?=
 =?utf-8?B?NmlGenVERnNpeFlLSVhpeHk1RXluT1h6VFQ4dzdQSHBncG1VWjNzcnFxaDRN?=
 =?utf-8?B?NFY2RkdlMTFpVW1LdzZqZ0pMcm1OSmt5R3JpQ0VaZVpaT1VXTmRvVzVZR0ls?=
 =?utf-8?B?eHBVVGZGTDFLTE5pbWFHaGJyTjltcnBJUytVUGxQVDFyYXhuakRuVERHaUl4?=
 =?utf-8?B?eHBwK2dqNFlNMjN0b0hnbTFHQk12U1NLMThDMTNDeS9jbHZnSE1LUllBQlJQ?=
 =?utf-8?B?VDFpRmhUSGg3WXBrR1IxbEJ2M21BekliL1hTUis3THR6a2sxa3oxYWNTN094?=
 =?utf-8?B?SjNpZkpXVmZ2YmlockhNNTA3U2F1RENNZUtLakM3Sjk3cVhHQlFOaEdOem4y?=
 =?utf-8?B?djYyTS9ZUTN1MkY0TVdYd2owaUNtdStYV1EwMi9oSkZGOUpxckhzZklrOUts?=
 =?utf-8?Q?SMm2YmwDQtcBy8K1ZopAqqNjE?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: GD2o/3Jz2Zd7Lb6bbHVd9gvFzGDyIFPE8c8O8BtgNPAohao0acV0PIE+FRHNpCfLuGV4+Pcb4+8PTj8GSbR7f8k2unonuPW01mSDSFgGabjaz6omr0mSgK8TRQB9zDkMNu55KinRTB+r4b8X5daLwcQY0Z4wRxQVelof39P90+0c/bffC+0xnzi/7i7j/fPBMHrmtYaihIrWqXbXl8XtBRUbzESXq27u8Knw23GCEBNx/rMiqK8hgxh6zdSQGqcIY/AFWMo4t2rsstJ10+bJ8LVNM3L/MNtMb3j40cNmMk9gZS58mscPqX5/bUbU3rdnVFFw34q3dvYzg+yW+kUb/zXX9qPOis29lhiMbL0UxEWdQ1MovyRvCaQqYxBZl5M9B5ZWRzrxM6DSn03ywVeNfI4ma3AUcl7EdE4yP3xJSWwt5G5qG2EfDfiObWqYYaf8QOJbezDkK2gNJuh12dlU9H1ndfvQ2mZ/CpR3iY1v7MM3qtasMHLR31ZptUnK9p0yCgargMoCm+1tALKU5y3jrl6iXkWMCFPAr9EcDE7zjL+gidgr24sUABjeTbXlcw823AUNwc+AM1EcXg6OKEU228y5kZ51xoj46IxJfoiLblbGtTWqRNdX7i0qtANlr+GE4cWe9nvehcAri3EbzZ4Pa9CNDl4UoEM4e1d37fQloeD1DgMgognU5F/JahEMKxyJCjBbJV7v9NPhSpEPjciVSvwnqnwUKM6n7y1IfavLBHGbPgiOGdUO0UWASbjisiJmifb83EH2ooAS8Gsk4VI6UtFUk2z00dpaHMiFOun7oq8H7b3sL64gZfOzAiC9B/k6tzNIbPbk7sBudZN5TsZN0A==
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7ee2cd2-bafb-40ca-ee69-08db13de1c20
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2023 07:34:47.8332
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ATPppy4bRa/2kzDd/FR7BO8akWsmogRICYloJh4lHzuVCjXACsZYsdoa90NXqPMLwPiZUJuS6MVjz1ZmsKjJlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR04MB4165
X-Proofpoint-GUID: QpIgEdyqJ4yRFLvlb7Cg5VcvbNLUbdKH
X-Proofpoint-ORIG-GUID: QpIgEdyqJ4yRFLvlb7Cg5VcvbNLUbdKH
X-Sony-Outbound-GUID: QpIgEdyqJ4yRFLvlb7Cg5VcvbNLUbdKH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-21_04,2023-02-20_02,2023-02-09_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

SW4gZXJyb3IgaGFuZGxpbmcgJ2ZyZWVfY2x1c3RlcicsIGJlZm9yZSBudW1fYWxsb2MgY2x1c3Rl
cnMgYWxsb2NhdGVkLA0KcF9jaGFpbi0+c2l6ZSB3aWxsIG5vdCB1cGRhdGVkIGFuZCBhbHdheXMg
MCwgdGh1cyB0aGUgbmV3bHkgYWxsb2NhdGVkDQpjbHVzdGVycyBhcmUgbm90IGZyZWVkLg0KDQpT
aWduZWQtb2ZmLWJ5OiBZdWV6aGFuZyBNbyA8WXVlemhhbmcuTW9Ac29ueS5jb20+DQpSZXZpZXdl
ZC1ieTogQW5keSBXdSA8QW5keS5XdUBzb255LmNvbT4NCi0tLQ0KIGZzL2V4ZmF0L2ZhdGVudC5j
IHwgMTggKysrKysrKystLS0tLS0tLS0tDQogMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygr
KSwgMTAgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9mcy9leGZhdC9mYXRlbnQuYyBiL2Zz
L2V4ZmF0L2ZhdGVudC5jDQppbmRleCBiNGNhNTMzYWNhYTkuLmVkYmQwZjI1MWRhMSAxMDA2NDQN
Ci0tLSBhL2ZzL2V4ZmF0L2ZhdGVudC5jDQorKysgYi9mcy9leGZhdC9mYXRlbnQuYw0KQEAgLTMw
Nyw3ICszMDcsNyBAQCBpbnQgZXhmYXRfYWxsb2NfY2x1c3RlcihzdHJ1Y3QgaW5vZGUgKmlub2Rl
LCB1bnNpZ25lZCBpbnQgbnVtX2FsbG9jLA0KIAkJc3RydWN0IGV4ZmF0X2NoYWluICpwX2NoYWlu
LCBib29sIHN5bmNfYm1hcCkNCiB7DQogCWludCByZXQgPSAtRU5PU1BDOw0KLQl1bnNpZ25lZCBp
bnQgbnVtX2NsdXN0ZXJzID0gMCwgdG90YWxfY250Ow0KKwl1bnNpZ25lZCBpbnQgdG90YWxfY250
Ow0KIAl1bnNpZ25lZCBpbnQgaGludF9jbHUsIG5ld19jbHUsIGxhc3RfY2x1ID0gRVhGQVRfRU9G
X0NMVVNURVI7DQogCXN0cnVjdCBzdXBlcl9ibG9jayAqc2IgPSBpbm9kZS0+aV9zYjsNCiAJc3Ry
dWN0IGV4ZmF0X3NiX2luZm8gKnNiaSA9IEVYRkFUX1NCKHNiKTsNCkBAIC0zNjEsNyArMzYxLDcg
QEAgaW50IGV4ZmF0X2FsbG9jX2NsdXN0ZXIoc3RydWN0IGlub2RlICppbm9kZSwgdW5zaWduZWQg
aW50IG51bV9hbGxvYywNCiAJCWlmIChuZXdfY2x1ICE9IGhpbnRfY2x1ICYmDQogCQkgICAgcF9j
aGFpbi0+ZmxhZ3MgPT0gQUxMT0NfTk9fRkFUX0NIQUlOKSB7DQogCQkJaWYgKGV4ZmF0X2NoYWlu
X2NvbnRfY2x1c3RlcihzYiwgcF9jaGFpbi0+ZGlyLA0KLQkJCQkJbnVtX2NsdXN0ZXJzKSkgew0K
KwkJCQkJcF9jaGFpbi0+c2l6ZSkpIHsNCiAJCQkJcmV0ID0gLUVJTzsNCiAJCQkJZ290byBmcmVl
X2NsdXN0ZXI7DQogCQkJfQ0KQEAgLTM3NCw4ICszNzQsNiBAQCBpbnQgZXhmYXRfYWxsb2NfY2x1
c3RlcihzdHJ1Y3QgaW5vZGUgKmlub2RlLCB1bnNpZ25lZCBpbnQgbnVtX2FsbG9jLA0KIAkJCWdv
dG8gZnJlZV9jbHVzdGVyOw0KIAkJfQ0KIA0KLQkJbnVtX2NsdXN0ZXJzKys7DQotDQogCQkvKiB1
cGRhdGUgRkFUIHRhYmxlICovDQogCQlpZiAocF9jaGFpbi0+ZmxhZ3MgPT0gQUxMT0NfRkFUX0NI
QUlOKSB7DQogCQkJaWYgKGV4ZmF0X2VudF9zZXQoc2IsIG5ld19jbHUsIEVYRkFUX0VPRl9DTFVT
VEVSKSkgew0KQEAgLTM5MiwxMyArMzkwLDE0IEBAIGludCBleGZhdF9hbGxvY19jbHVzdGVyKHN0
cnVjdCBpbm9kZSAqaW5vZGUsIHVuc2lnbmVkIGludCBudW1fYWxsb2MsDQogCQkJCWdvdG8gZnJl
ZV9jbHVzdGVyOw0KIAkJCX0NCiAJCX0NCisJCXBfY2hhaW4tPnNpemUrKzsNCisNCiAJCWxhc3Rf
Y2x1ID0gbmV3X2NsdTsNCiANCi0JCWlmICgtLW51bV9hbGxvYyA9PSAwKSB7DQorCQlpZiAocF9j
aGFpbi0+c2l6ZSA9PSBudW1fYWxsb2MpIHsNCiAJCQlzYmktPmNsdV9zcmNoX3B0ciA9IGhpbnRf
Y2x1Ow0KLQkJCXNiaS0+dXNlZF9jbHVzdGVycyArPSBudW1fY2x1c3RlcnM7DQorCQkJc2JpLT51
c2VkX2NsdXN0ZXJzICs9IG51bV9hbGxvYzsNCiANCi0JCQlwX2NoYWluLT5zaXplICs9IG51bV9j
bHVzdGVyczsNCiAJCQltdXRleF91bmxvY2soJnNiaS0+Yml0bWFwX2xvY2spOw0KIAkJCXJldHVy
biAwOw0KIAkJfQ0KQEAgLTQwOSw3ICs0MDgsNyBAQCBpbnQgZXhmYXRfYWxsb2NfY2x1c3Rlcihz
dHJ1Y3QgaW5vZGUgKmlub2RlLCB1bnNpZ25lZCBpbnQgbnVtX2FsbG9jLA0KIA0KIAkJCWlmIChw
X2NoYWluLT5mbGFncyA9PSBBTExPQ19OT19GQVRfQ0hBSU4pIHsNCiAJCQkJaWYgKGV4ZmF0X2No
YWluX2NvbnRfY2x1c3RlcihzYiwgcF9jaGFpbi0+ZGlyLA0KLQkJCQkJCW51bV9jbHVzdGVycykp
IHsNCisJCQkJCQlwX2NoYWluLT5zaXplKSkgew0KIAkJCQkJcmV0ID0gLUVJTzsNCiAJCQkJCWdv
dG8gZnJlZV9jbHVzdGVyOw0KIAkJCQl9DQpAQCAtNDE4LDggKzQxNyw3IEBAIGludCBleGZhdF9h
bGxvY19jbHVzdGVyKHN0cnVjdCBpbm9kZSAqaW5vZGUsIHVuc2lnbmVkIGludCBudW1fYWxsb2Ms
DQogCQl9DQogCX0NCiBmcmVlX2NsdXN0ZXI6DQotCWlmIChudW1fY2x1c3RlcnMpDQotCQlfX2V4
ZmF0X2ZyZWVfY2x1c3Rlcihpbm9kZSwgcF9jaGFpbik7DQorCV9fZXhmYXRfZnJlZV9jbHVzdGVy
KGlub2RlLCBwX2NoYWluKTsNCiB1bmxvY2s6DQogCW11dGV4X3VubG9jaygmc2JpLT5iaXRtYXBf
bG9jayk7DQogCXJldHVybiByZXQ7DQotLSANCjIuMjUuMQ0KDQo=
