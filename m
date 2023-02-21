Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2211369DB45
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Feb 2023 08:34:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233358AbjBUHew (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Feb 2023 02:34:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjBUHev (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Feb 2023 02:34:51 -0500
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AF77A270
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Feb 2023 23:34:50 -0800 (PST)
Received: from pps.filterd (m0209323.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31L6qYoi009198;
        Tue, 21 Feb 2023 07:34:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=S1; bh=wWT75qH20mK+361T38BT3LOvxd/8xEdQzfPv3cp5z84=;
 b=EFNFFIkPqYuQZNT/fEneFKVYqfmoFrws8V0KIWTGYyeO/JxC8/eJOOU3N8memT3htAgp
 NxHtpyKNkuwsUGeu1MgZ0dM+xL8huujjxkhnTfYqTShj8YIhC3uIrpcs3vZ0SoehdFQD
 MCkmLfPsmmUz5/B10KnheDYFsFPUOGAsChvGNzF8oxe1AsdyBeO50ysR64OhYHJrF1cc
 /IazbeMDNGPpkKYtdGfcsYat1LOa+ywKIvoxsiPEZIyK9NJPREp6vAyKr+PRpFVxJQ/y
 qtbBIcyNly1WiqRjdHhnEqUqrCrv26jMactrko4jUjiOVxPoosI266GD1TEw5VyQUGjh GQ== 
Received: from apc01-tyz-obe.outbound.protection.outlook.com (mail-tyzapc01lp2043.outbound.protection.outlook.com [104.47.110.43])
        by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3ntp11tucq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Feb 2023 07:34:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IHZIWLjxYLBXRUusESC0GANUg7TN9dnM5lgk8OkuCYA45DMmLOItLqhNZGuy9EiOIRij4yyHez9NfuukHyk/lIlEp5df9V81KY2obmnLQHkIHdUruRY10yKZaFTPNnHQv3sFJDeQlWJ7TWY8bIjQDreSj8Syc0gXfI0F88CjU3PFc/Ertk32N8GUqKW93FevBpsqJnTAyoBsC4ONYVROQxhOzVNV1I6Qm6P+bM2uYp6RbaxL4BCDQ/parE/zJeM6tM+MaCPHBKlHPRFBZ3MQaLKG5IeO8R9sRySpwUiJA+PaZfy5OUiFczuTjihZbuu5Ye4FQTTHPOmn+jyhm8zGmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wWT75qH20mK+361T38BT3LOvxd/8xEdQzfPv3cp5z84=;
 b=imfEhrE2fS1+8+dcHuKy4HnETe92SwGNgojyixXDFB1EWEEg2JKoOAQh/LP6hcYrqonzgdRxl3Rq45uIKB3OJd82+X6MmK2Kwh++NR4aKULlUmIWx+ESU3U0tRl22YnNcdcvT0/XuKeMuC+Cx6VGZ9j/nFGNNLXJcjqciW4UEVqys68S1s7Ddeer4JcnFT2yhZ5U2Zi38BzlneLn0IKrsaT0J1utg7m3+YMUEkECbrJ1cdKouHpnfk8OvGjknA4n4LjsDjgSI8D6vE0iGGdrexXs3i9bAnvT1kQhoN2H2Kmhd0x/XJRl1Y4Rbyhtjr1LbDwOZZQAOARH/h/b+Wggrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by PSAPR04MB4165.apcprd04.prod.outlook.com (2603:1096:301:34::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21; Tue, 21 Feb
 2023 07:34:26 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::779:3520:dde5:4941]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::779:3520:dde5:4941%7]) with mapi id 15.20.6111.020; Tue, 21 Feb 2023
 07:34:25 +0000
From:   "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To:     "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>
Subject: [PATCH 0/3] exfat: fix and refine exfat_alloc_cluster()
Thread-Topic: [PATCH 0/3] exfat: fix and refine exfat_alloc_cluster()
Thread-Index: AdlFxX7eR78/y043QeuSuWWz8nDOdw==
Date:   Tue, 21 Feb 2023 07:34:25 +0000
Message-ID: <PUZPR04MB631692BD55FAACC63E6F622D81A59@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|PSAPR04MB4165:EE_
x-ms-office365-filtering-correlation-id: 0028eb3a-074e-4002-8ad5-08db13de0ef2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HQHqZ11XSXPMzKqk0j230Mk2NUCm3ffiRT0f+f6rE4pHlX+35MXnfJmU40tyWlxsXVt9em6meVEUIxxzAZTMZQWb1EZNH06P70XnXcey4fxDti6tVsGSjJwtq11rylPP347yAdrr3SwJvhdKSB4kzyrTClEVe8ZjNUUo0g6VMq65JhG0yWjbNMKbYwBzS7EiwK4MVQJMP3sMYufw3PCpi+elb33O2ERUV6BXLY6+xBQLUwZNaNu4iOnOVj35yfG0HWvGi6yTeJJRQ3YOxVFHEHfUT1cNtBf3vVq3LAuNOzRU6+oPO5meu0pXZUFaVR7OUG0UGLoLAxrLpyepKy31WR6v+FhNNVynvLCFafuxxuK5QXGUQ2QPdsr5dabmdBGbcXbzQVeM/3u4Aab3HmpTc7HDhMaV/uFtwA9nmSp2sL2YHsk0qIOOcOQKh122RvFB7V/x1D7vSJJdUk1HqqHscn5U1zbBpfCn8nHXAcKWHJ+7V4zkawbQvrS3uQyDoG0218+6RkZnYvZoQ3iEapXDpcbEf8yiisIJY/0YdRuI9o80VZa4BN5N1O/+PYGAubrMWTIza/enIrM5hEEmC2PJGYSWjc78m8zeEC1ThNo2J2E054NMgvheh6MMNwy0iaGbaGiYZkx5wVbmoBftPH9uQklpywf8DU+WAKCLUuQyvvBQnm+S/PGCUTbcpAbI82RYFURJR3E1TZ02NdDE5Q/IqA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(366004)(39860400002)(396003)(346002)(451199018)(82960400001)(122000001)(38100700002)(4744005)(83380400001)(86362001)(316002)(54906003)(8936002)(5660300002)(64756008)(66476007)(8676002)(4326008)(110136005)(55016003)(41300700001)(478600001)(38070700005)(107886003)(33656002)(7696005)(76116006)(66946007)(2906002)(71200400001)(66556008)(66446008)(52536014)(9686003)(186003)(6506007)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?emphT2RsT1JiZ2FPbEhuZ253Wk5BcERpbk5CUjg2Wm1ZSnNhQ2VSK0ptRUh0?=
 =?utf-8?B?MEpnWWRncTlDWklqWUVDUUYxbjFwV0F5QnJXdFA5Q21PUVZrMkh2bTJKL0dT?=
 =?utf-8?B?bFZHQWU3dGdxZkgvd1NNZUowblRLeXJNMDFVQVh0eTRvQitFQk4raTF3bmUy?=
 =?utf-8?B?MDBFQld4NlowZURDL0VvODgrL3pyVkJ2S2NPNWZuWklhK0hubENXVnJxSDNS?=
 =?utf-8?B?d3dXR1k1THozbWc5U2RLcGZ2a0Q5dWNqOU1pMWp6RXJTYVQ5R0lEUE03UkJ2?=
 =?utf-8?B?MjFIbDc2dmEySjh4SkVrL2Zmb09KRWU1NSswMVFTSXFsWDRmMkNoRFUrdjVX?=
 =?utf-8?B?cDF1bXBublZrYWJiTnpTS2Nwak5melVwektnZ3IwcUJaWWZqSGFmWEdTckZR?=
 =?utf-8?B?R1dma1Q1RWNLc0JkblRiSEhLamhJTEF2Vm5mcmdsOEdaUE55MTd5eEVNTVJz?=
 =?utf-8?B?SFYyVUl4RDRZZVcrL0RCZWpJTldRZWdmL0tML1g0cm1MR0JQYjMyS3g5c2VJ?=
 =?utf-8?B?VG9ScDdLVW9tVnZzUFV6T3ViaUR1eUFZdlpTcDJaaUhrb1RNc3UxNGVMd3dI?=
 =?utf-8?B?TksrMEJyMmFIaUgrTDhWNHcxVlRFUGpZekZIQkVaMUMxZzBvREIzK3RLWXBy?=
 =?utf-8?B?dlhZRnVHMXhLTlVvVmkrSkJuc2pISDlVTkVFV2FEMVUrR3hudGk4cVVyNnVK?=
 =?utf-8?B?dGMrT0Y5OWhRSGhPaVNaVER5MmFabFJMOEZYcWo2blJYOWFIOEVKN0ZHN0Zs?=
 =?utf-8?B?dGFSTnhsY2NuSUMvUHBraWdtT0Z4UkN1dk9qKzQxdWxQTGhxOXdwT1BKMGZa?=
 =?utf-8?B?NW5YWWZuUitybU40WndVeDdJN0lXYlplL2trOGg1dHBUT1lNMWJ5cEREMEN6?=
 =?utf-8?B?UDl4NVNLY0Rpd25DdjZDR1YxalpOK0JRU21OMkNXdktXZ21vYjhveE9WVDJQ?=
 =?utf-8?B?NWpWRnRQMld4VTVOWjFIYkl3Z0oxc1dUZTY0NHMvaDJKQW92SEljMlRSdmVF?=
 =?utf-8?B?T1lSS0tlR3N1L1dUbDloZGZPUVh1SU96c2xYUGhhc05sMFZGMi9oSTZ6YVkw?=
 =?utf-8?B?L2dtOFAwbHo1bTg3REJnVnJIQ0FDdW93SGw2MElVd1R2ZWU0eU13OW9CR2RC?=
 =?utf-8?B?TVJCWDJmeTh1a2VMZlVVaW1WNkxIOTd1VllLa3BWUyt4aTRzVFZpWWlPVEhi?=
 =?utf-8?B?UXJEVzBPRDZwZ2xjU3pxMDZ2QnB2aWsxYW9MZ04wanZnVzZya0V6ejI1SHpU?=
 =?utf-8?B?aFUvMHM3VFhnRzVsS0kxL2ZPZk10d3JLVTlkM0dtaC9GRDloUFBLL1hpTlY4?=
 =?utf-8?B?TGhvTWZQTmQ1THFNajBVM2NSWk44enVjQk9WYnRtcDhuazNMa1UyK0xiTGQz?=
 =?utf-8?B?WXRuMUNBeEpHc3RqT0daUStGNW5VRk5raVEyTDMyMFZSV2RpMEEvNkVuQ0w4?=
 =?utf-8?B?a3lZOFFUVW5IQlFpV05TaFJXMHdCTVNHUEtNVFBBV25DTGluSVlEUXdUZjNO?=
 =?utf-8?B?YTRsdkNRUklDbFBNeEZwTFZaOWV5YlVSeUcydEttNllBeTFzd1ZrOW90dG9v?=
 =?utf-8?B?VzlLV0x0TDVrdDduOXRJS3NmOWlhL1cyNHlSSDhKT2pxelFjcE5iZkZyMU1P?=
 =?utf-8?B?V2l5RnBrQmh6RXN2N044RW94aVFHdlFFUmd2V21PamdGaTdqNE4xWWVVbzU3?=
 =?utf-8?B?RzJlS3BRNW9JakRWcWtXbXNNUXpHaHRKSVlqUEp1dFJyQU52dmcyVzBUOUxQ?=
 =?utf-8?B?TE9QWFBMOU5vRXp0UTVKNnQzOGlEVVVYTXBseHhvQmFvaitaYytOWVdoQUZw?=
 =?utf-8?B?azBUS0RqKzFNT0tsbW5mY2FYV1JvZmMrRmQxVVdJdWhkQnJud25DTEhtUEFa?=
 =?utf-8?B?UU9CWW1wWjFJN2p5T1pWY3RaZUNOUXJiMVRJZkt1amVEUlNlUWRJYTVYUUtK?=
 =?utf-8?B?WGhjZ1RuOUZBU2ZDelZZTmlrdEsrb1pBdGV2M2ZMckxxL1dtTTRNQWVXa1NE?=
 =?utf-8?B?NzRzSEVkanJMeUNLQUhjRTVoRk1FaHI3dzZob2RUYi96THlyenBzQ2czbzF1?=
 =?utf-8?B?K1NvZnhsTlk4bjNDQ2VQUGIzZTFNbkdmRnA4eWJBV2hhVGw3bXQwUERoOWF3?=
 =?utf-8?Q?VTXa5dGVi4Hl9JaFbbEECWyeY?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: YlkBcJZVLxYuDvJkydPLJTl8hxbvxGT1qxm0J1Ihqo/v7lasb6IUFa4cq1jnaQG5X7kltQqIQ+nrdaaVYscSKwVjh/iFTJX4dZ07q7BDyE02zoFarB5/vjPztdo78ry20y44BMgHV/fqVCj7e+T5kWVg0R2dOqwdZGYU7chsz0jcg6IXKXbpyOGaQwN/qzTG24AVbr/dt4U9377oUgQ3JelWl897nZ9fGFZzY/tbj7Nu0kj2FtpKF6+rVLbwAQ67iXEQ+DLalUtjWlPWAeP2yOVLQc8ZDrZ01M+TxOy4GQ/96aSmI0Wc6TKfQXqNRI52JIAPsBQhz+N/Vi3JWSuN0iCfkvhSyMui86jP6Jr8GM3SAe74xhUjzO5qrplmZH0Bp+SaqLE92u68ZhcVaK2DdM5217jj3aMcFZC0zaNEQCoZf43vC8XIiH4SCFvEOEAL2HCxQySx+YRMVvwdImnKALGSAoT6WI1NRwfLtxHutPBSr7bjufzj+2LxTkdthkF51RBT/GTZwbIdGX5YaU82+x7HBYZ2zZVZLd+HQA3+BnRU9/yf/BWJLzole1g7ucoFpT0/LHW95b/Ahnwa1vrHrgp2C/F+t+uihY8Cbew7yeVldVe2dh6cRXKujQKzwyr/KOB0AbY+uHPmx7mUEW4GNmHHT5rfwGz1Wjh6UKRoc0UMvyf5/2ooH6jnz/ZnEgyRNexIJkU9hfghsyLwNEf9qFcI0kb916Tl8Ay36s/J/foo7lfFXXZ5sZ/kjyipXoQ2MyR6hFz0XvGJ9kHi8IwTC+KjCixrpUAaqIflAEis1I3uCynhmc5L4QRsUUvcKUo//dphj3kPrBPflBFpr3LVPw==
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0028eb3a-074e-4002-8ad5-08db13de0ef2
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2023 07:34:25.6876
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Une7AK61agZOmz/ljINe2CIZCw6/oxWxlrp6R4uUjsom6WId+WG9PmmY1wKF1fnajiuByrUgwje1dFBl+O3ItQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR04MB4165
X-Proofpoint-GUID: O4xu5hNKN9IMJgybwO-6gS1-2xiXu0E4
X-Proofpoint-ORIG-GUID: O4xu5hNKN9IMJgybwO-6gS1-2xiXu0E4
X-Sony-Outbound-GUID: O4xu5hNKN9IMJgybwO-6gS1-2xiXu0E4
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

WXVlemhhbmcgTW8gKDMpOg0KICBleGZhdDogcmVtb3ZlIHVubmVlZGVkIGNvZGUgZnJvbSBleGZh
dF9hbGxvY19jbHVzdGVyKCkNCiAgZXhmYXQ6IGRvbid0IHByaW50IGVycm9yIGxvZyBpbiBub3Jt
YWwgY2FzZQ0KICBleGZhdDogZml4IHRoZSBuZXdseSBhbGxvY2F0ZWQgY2x1c3RlcnMgYXJlIG5v
dCBmcmVlZCBpbiBlcnJvcg0KICAgIGhhbmRsaW5nDQoNCiBmcy9leGZhdC9mYXRlbnQuYyB8IDM3
ICsrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0NCiAxIGZpbGUgY2hhbmdlZCwg
MTYgaW5zZXJ0aW9ucygrKSwgMjEgZGVsZXRpb25zKC0pDQoNCi0tIA0KMi4yNS4xDQo=
