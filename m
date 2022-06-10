Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE834546718
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jun 2022 15:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347731AbiFJNIC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Jun 2022 09:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348074AbiFJNHr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Jun 2022 09:07:47 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2120.outbound.protection.outlook.com [40.107.215.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A177B4832B;
        Fri, 10 Jun 2022 06:07:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VSvH5nQCZDjGvCdc1lzwdC7hC26y+/i1MiVjrW54k8eRIyry4qxXQhj/BqhsYaFLo5bvFMjf5zyQIYAK1L129+W1mSoF38BuwCRO6Wsc7dJ/iM9/gxTLEfY4hekeFd/fg+4Pe9svPjT53hygxT9Ot88UBcYlwZwLPDdQrjeZ/hwUEhWhwSZ5Ynj+ECdIDYuowiFHjB5LAjH1hQBcrf0+3u3svIgyxxviPQQdVfq/3vBlLt2Oi/qKnfp4woWZjXk8ad/a1aXv/jSM87FA5iLpu5hvymLxbeM2sbDVpfAObDQlNvOX1FPTwOiB2nyIkkk3B3RiMaThktD6BRIEGaSACg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nhToBSKyHgI4HelIFj3BNJK4LAcotKnk9TPSs2OkQTk=;
 b=NBt6eJi/rVrxMBxkHqyZAo0CYu+Tc5fS9DlWE9fh33op6TDLYICzltJ4NU9/ITQXQLOsITb4Pg6v112+GIJObY/QLoOV9ne2zZ4OEnlKJyO2M0+unmvHasjWmfFdkRP4I17Xo64Md6x+oR90K/s2glIc8H98Zfd9IoOYMUdXyxm8UT749LQIVIo4cwyxwK+8uAtqIbNAhK4UnI4naGRzqTkxK4mk+zWqt+KzVG+TjbV92IWgoNK/SpSOjWJN9aAfz4rgr1OzD1O6Ui2/KOH09UYm/G22LY5C2bGZm/7ZWSsnrTxyoVc8pb0TlnNJXXySiUdPwUyywku9bLiJMSu5dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nhToBSKyHgI4HelIFj3BNJK4LAcotKnk9TPSs2OkQTk=;
 b=jrgEKvAEzDBeQVNkVPhk/0WHlOoroN5OIs5QgbitHqOPVwL5B7azPgaphazF7qjLzMY9FWmptkE1ICz83OmRCsOb+S3EHHK0T2nENdXgHbcNKvN6Z9U3qiF75g+1kZ2DvGfj/60D3W1MhmWrmMz/xLeMUc3BxfCuhhLip9mb3Xk=
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB3905.apcprd06.prod.outlook.com (2603:1096:820:26::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.11; Fri, 10 Jun
 2022 13:07:41 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8588:9527:6e72:69c2]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8588:9527:6e72:69c2%5]) with mapi id 15.20.5314.019; Fri, 10 Jun 2022
 13:07:41 +0000
From:   =?utf-8?B?5p2O5oms6Z+s?= <frank.li@vivo.com>
To:     Namjae Jeon <linkinjeon@kernel.org>
CC:     "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?utf-8?B?562U5aSNOiBbUEFUQ0hdIGV4ZmF0OiBpbnRvcmR1Y2Ugc2tpcF9zdHJlYW1f?=
 =?utf-8?Q?check_mount_opt?=
Thread-Topic: [PATCH] exfat: intorduce skip_stream_check mount opt
Thread-Index: AQHYehlC77zhZwGEZ0yT3MKGsxe3Ha1H180AgADJdPA=
Date:   Fri, 10 Jun 2022 13:07:41 +0000
Message-ID: <SEZPR06MB526945BC172186A13FA60B11E8A69@SEZPR06MB5269.apcprd06.prod.outlook.com>
References: <20220607024942.811-1-frank.li@vivo.com>
 <CAKYAXd99NAbQP6m93P3bcjvWTN-T8Qy59DHJyfyTHqdH-7aWBQ@mail.gmail.com>
In-Reply-To: <CAKYAXd99NAbQP6m93P3bcjvWTN-T8Qy59DHJyfyTHqdH-7aWBQ@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2a4614c3-4873-43e0-3da7-08da4ae233c4
x-ms-traffictypediagnostic: KL1PR0601MB3905:EE_
x-microsoft-antispam-prvs: <KL1PR0601MB3905D7CA5DFB746E318C12BEE8A69@KL1PR0601MB3905.apcprd06.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pkqCSeTwqgsru34mvFzWn6ua7dG/nGZNadTNAyN3I95QCseppgg16xkwn+aLn3aYydn5pGbN7GvEnKk/MKlp4QBkAHLJn1g4Ytp3Dw2jBDZkYId0/g8JuLwZ/ogJUYW2641kiBERUed3N2DTBmCjpoIDCKG2oNw1GVmmYhc5g854rUSulowxptfpeVygbd7DQU6Vj62SmL+IMnvGfEpFJ2zyQruPK+vR4x00lm990hlJ1RSHkukBMOXyxIdvPs9kPKg80K5NUDHlmP+F4lfjuSTtiidFWXFE3Qs3jkZrdVvl441YrhGo9KIECofTtmdrF7JHIT5ZT32Ob5+M0y0kU8a4H/sng/n/nTtA91sSfaaY+2X1k0Ac+FdmAbYs/AChxuxrGJdl7lKPn+Dj0MJ/4PhCu/8hHicuglsllh/uv2hEV4rSe1KPcR6seGGpnbfgIz/jTJoYZCw+PFYyPXMwR7O1M2o0k8ZmX8BQjbiNfYdZQpg3jKBDVXaicDdFqW767BYK+fzWDIuFctfLwKkHd1rCrYL1CgQf98zKcSO7irAabcLpT41EmdqZof2qpU0ASDfz8016i2A0rFI4ttgd8cr9v4ZlxlvVvxnjje9Ijfkvnf9iVVsJPPSm5WXVdHdg71x7VhAJxKLCueDTJc9dwDNM4a8RtPr9QBL84hXPgpZB/QVWQi1FP0meIengTg4lS5NnsU3cmWv10AFdItcuCw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(64756008)(9686003)(66476007)(66446008)(26005)(316002)(52536014)(8936002)(33656002)(66946007)(224303003)(186003)(83380400001)(86362001)(71200400001)(38070700005)(85182001)(76116006)(66556008)(4326008)(122000001)(2906002)(7696005)(55016003)(5660300002)(38100700002)(6506007)(508600001)(54906003)(4744005)(6916009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VkNjQWg0YXZxMmNEdlhJSHlrSjYxajVkdHM2WHplTzUxeUowMVRFeHg5VGxK?=
 =?utf-8?B?QzM0TU5BeGRCeUJqNnB4VHB3a0NueTh6TTFvWHYzYlVuYzJtUVc2N1BSM3c2?=
 =?utf-8?B?ZDJEZDBaRGxsRnhnOTJQSVNOVmMxN3FWdElXUS8rdTh0cWV0TXZxMDFpWmVF?=
 =?utf-8?B?ZFNiZVlxeUJvaE5tODd5ampwS2NvRGV6bDZNOE1KMC9NWFUyRlBHSGtGMGZq?=
 =?utf-8?B?ZDhSdFRLbkowYnFJaXpkd3p6QkZGdFNQMkhaS2lmMU1PVitYYm5xU2xYUWU4?=
 =?utf-8?B?TUNLZktoSHFZTk1IM2RXVzVVdVNwQzVIeitQZk5Ld2RqekpQSGxUWldyT0Rq?=
 =?utf-8?B?eTc2RGFNTG1VbjljT1NXWlhLTWFqWU91MlgxUWRCMFBZbjhzSEdKSUVzRFoy?=
 =?utf-8?B?OHNxd2thVVVHN0llaDdoRWYzU0VJWUlDTGpWNCtxc2FLRllWVFVyWUhkSmE0?=
 =?utf-8?B?eGNMMndvWFQ4cXJwRjJSWVVRd0lYYUR3bVBKalN0RXNrY0UvbEIydkt5ZUNm?=
 =?utf-8?B?RzNnNHJiQXZvZUN2OVFMSnIrcmJiTEQ4S3Q4RVpHWWtDdmQ0cUdtRUYwWDd3?=
 =?utf-8?B?L0FKbFJIZ0thY0czTnRMelVhZTJ5bURScWNBOVFyRW55TWM1dzZwQisxZGRY?=
 =?utf-8?B?SFlGUzJMSnowQzNiS1BIWEh2VHo0QmVTRGxycHZ2bitYOEJiNW1kWlBTN1Vv?=
 =?utf-8?B?TExuU0JDcmQ4cWxCQ1RDN042NGQ1U1QwaDFjT2wwWjFRNWRjTWpsL0JNaEJM?=
 =?utf-8?B?SXpuTHNuTHpGeG8yeHduWDRFdWJWZUlGQ2NrNzU1Mmk0ZTk2dGpkVldqRHYw?=
 =?utf-8?B?bDJ2anpSbmpjeW14bVd1TnVoK1BTekQ2US8xU1dzVkJuTHJ5a0hNa3pYZmtN?=
 =?utf-8?B?NkFmYVpMcVpDWXlNNWVwSmZlMWFlb3BTWnh5dThSRytINmI2bGtmdDRReTk5?=
 =?utf-8?B?d3IwRXlQOWp6ZWkvS0laTmc1b3lta3l5aGkrMXJBL0t4cGROU0xJU2NFTjVa?=
 =?utf-8?B?d2VZd3NzeTNacjBabk1YbFJTT3VsYUZ4VFppcUdDeUxQME5tdVNYU1NsUWxJ?=
 =?utf-8?B?b21CTlljeEloSm11MVA1ajVOMExuY0dJd0o1NTFIb3EzK3RIdHRMWFAveXpN?=
 =?utf-8?B?RlFEQnIzcE44OUNCTDJLM3VWNG5ySXBFWDlBK001d2V6c3BPbWdWNGtZS2xr?=
 =?utf-8?B?RCtueWVsZ2thQUEyTkttQk1ab3VuZVM4blEyekRFcVdVdlBIclJtcGNxRko0?=
 =?utf-8?B?UjlGa0JLZ3NML1JYZmYxQ1MrRmF3MWxVSlVXMzVPYVVsWkxRTDA0WmV5SzVV?=
 =?utf-8?B?cmlhbW5zY3dKOUM3NTZsbXpaeUx0MzZzeGNXWE5PUDdZRHBnR25jdkY5YzY1?=
 =?utf-8?B?OWlvMkFPeC85aEhZUEdCMVo3ejBMMWMzaTY3dkh6d1lDR2Z3cno1eEtBcnM3?=
 =?utf-8?B?Z2FlMEFnSlRoNDdTbzg4WjBBTDFFYzZZbERwc1VOVzNJdEhDTlo3cWJma1pw?=
 =?utf-8?B?ZDZvaEFWWnltZkNzN0lzNFJtRmVvc3MxMVp3WktTUHFnWUlaWGVOb1MvUGtT?=
 =?utf-8?B?VFl1dnNndFhmQkkyOGZ4MjFIMUxwNEZkTGJwOGpHNnRjSDBmN2h1cklYL1E2?=
 =?utf-8?B?cEE3NHhsWDAvUWIzV2prZnR2elpieVV5ODcwclBtTld2bnJsNkVwVmt6Yjd6?=
 =?utf-8?B?OFVsNmhXQjQwV0M2WEY1a1JUNE9GNlVkc1VFa2hDMVluSlhmdUh2b1A4UUVJ?=
 =?utf-8?B?eVZXZWQ5WGNIc09JdWxkVUM4M3pYVm5QUFJqdXpVOWxzSlFlSVRySnZ5RzBn?=
 =?utf-8?B?OVNRcFI0TGpWS0ErV25ZSmpESS9EQUlPdnhvQTNQMlBtSFFrTk5QVjZiVzBD?=
 =?utf-8?B?MzR0Mm93Nm5xc1pucklmcWpsSm1IUXB6YSt5Z3d3dWNENkFHQjhRRnlZaTRn?=
 =?utf-8?B?eFZQQWZJcDJVbCtyb1JTUHNGVzRTT1cxalRHcU4xWjlhSytEaVBsemQrZ2t6?=
 =?utf-8?B?enFCeHVFdjNTRzRmRUNhRWJJSGYyL3gyTXZ4SFJzMEpmeG9yQis0M2NjMExE?=
 =?utf-8?B?K1padWZXZjVndlV6MzFQOS93Ukh0d1JXMU9aUVdTd0wxd1UxOFF4ZmxCM3hx?=
 =?utf-8?B?ZmZ2MjJjQ0RMcnJXblhxMTRralBLbk9WZkpVZE00R1NwaFdIeVp4U2NCVWtC?=
 =?utf-8?B?SWFIcVJIODRiUk4rVFlPbnhXaUlEZjVtWjFQMFJXQmVYRkFVSWc0YzFnbG16?=
 =?utf-8?B?RnhaWGJXYVZ0U01IR3pUWDUxbTc3Z3ZXVkpaY0ZFUkpERkhQeDlESVgxclNp?=
 =?utf-8?Q?3phkLWqP1f3CPjHx4e?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a4614c3-4873-43e0-3da7-08da4ae233c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2022 13:07:41.7753
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rijJfUvOZeV5EMZ0audR1FOhZKgfmGDzKahG/5/d54zPZf7TCOf6t15Zrtg2ZS12+PXvp+uPpfPuZQl4prSyyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB3905
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

SEkgTmFtamFlLA0KDQo+IFN0aWxsIGhhdmluZyBwcm9ibGVtIG9uIGxpbnV4LWV4ZmF0IGFmdGVy
IHJlY292ZXJpbmcgaXQgdXNpbmcgd2luZG93cyBjaGtkc2s/DQoNCkFmdGVyIHJlcGFpcmluZyB3
aXRoIHRoZSBjaGtkc2sgdG9vbCBvbiB0aGUgd2luZG93cyBwbGF0Zm9ybSwgdGhlIGN1cnJlbnQg
ZmlsZSBjYW4gYmUgYWNjZXNzZWQgbm9ybWFsbHkgb24gbGludXguDQpIb3dldmVyLCBpdCBjYW4g
YmUgYWNjZXNzZWQgbm9ybWFsbHkgb24gdGhlIFdpbmRvd3MgcGxhdGZvcm0gaXRzZWxmLCBhbmQg
bm8gdG9vbHMgYXJlIHJlcXVpcmVkIHRvIHJlcGFpciBpdC4NCkltYWdpbmUgdGhhdCBpZiBzb21l
IHVzZXJzIGRvIG5vdCBoYXZlIGEgV2luZG93cyBlbnZpcm9ubWVudCBhbmQgZG8gbm90IHVuZGVy
c3RhbmQgcmVwYWlyIHRvb2xzLCB0aGV5DQpjYW5ub3QgYWNjZXNzIHRoZXNlIGZpbGVzIG9uIExp
bnV4Lg0KDQpXaHkgbm90IGp1c3Qgc2tpcCB0aGUgc3RyZWFtIGVudHJ5IGxpa2UgV2luZG93cyBk
b2VzIGFuZCBhbGxvdyBhY2Nlc3Mgd2l0aG91dCBmaXhpbmcgaXQ/DQoNClRoeCwNCllhbmd0YW8N
Cg==
