Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27EC46E73F7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Apr 2023 09:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbjDSH0a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Apr 2023 03:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231309AbjDSH02 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Apr 2023 03:26:28 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2046.outbound.protection.outlook.com [40.107.113.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A48197EC9;
        Wed, 19 Apr 2023 00:26:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JC08avQKZF08e56KQqtGSQOhsb2T1nOD5eQukEmLAMV74fts4dMjN8nqNg23BlU74nuf2Sl4OciiRItEqfjcTQt3Q1deaOgFGYuqN1NDBkfsbRMI7kczzZSCapg87p8TvLwUJuBTDBZuRTpbUFpXVQ5ZVnc1LQ0is0/uNJULjxAr6GqcrtP7XQytQbwomch+2o07wJPo6rhdNbAuiSFYxkp8o0OOWeNy7u+wJb1nQH7rJFe1TIfk7RkJTyoX0XKsAFI0txZnz3Huq+wM+MwfVshPEkZVC8sxFRaSswwZCtnFG5/7whEabhpvhSpT5GnL9eVq1nwYIY71jgoHMoylmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qCTIsTyE/drCcr1u7qV0ZSsval0X0MqMYPjYRq5UBgo=;
 b=oTUtsShLrud9jEjk0usYnpZRIzJUEhFR1mW/Nj2UxvI1L9d6G1pcvS/IW1aQLhUaoKu6JZgUCxPOAG1SM8cKz4NCiTvdtlGUMeFi6i2Pcsj7mTNPyxz3XyjiBnstGJ7LtNvYWdYuWW3JxN0lTLxNAM1sbNvFFeZFlKowU7ivo48YjEWEYiiXhaUcMqA4mG9j5JdmqoEI7tLZzVZRxUfG7gJGPtBcSUF8BuDJPkE+DgO5Vx9bQJsbb6TBTUsktbeSeu3b/GC3yhJ8rcn8AuX4EngNtv9ACVa0Ojscd4CpIDvyqfLUTPa4JD7av2gaX0vQzckVLvDFiR+YFhptBacHHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qCTIsTyE/drCcr1u7qV0ZSsval0X0MqMYPjYRq5UBgo=;
 b=GFDyArQ/T+rI2/Fbm7sTCEIMI34crsNVgT6iDtOkC6XmA4p45qBbVCMbRCXV8+rLxs4V+lyKmCcYClGpHzc6LVRaRTzpe/KjU9P6AnFCYZG2CNVEi6liIMVUmWU0OjiLAI5ruSALfswZr3Y/+QVpLVQ+odgJ/AGzisMpx8XSs2I=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by OSZPR01MB8609.jpnprd01.prod.outlook.com (2603:1096:604:187::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Wed, 19 Apr
 2023 07:26:00 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::22a3:7e89:cc26:15c8]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::22a3:7e89:cc26:15c8%7]) with mapi id 15.20.6298.045; Wed, 19 Apr 2023
 07:25:59 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
CC:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tong Tiangen <tongtiangen@huawei.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v2] mm: hwpoison: coredump: support recovery from
 dump_user_range()
Thread-Topic: [PATCH v2] mm: hwpoison: coredump: support recovery from
 dump_user_range()
Thread-Index: AQHZcaO0la0PeSJsOESJfU1UoYMpbK8w0aIAgAFrdIA=
Date:   Wed, 19 Apr 2023 07:25:59 +0000
Message-ID: <20230419072557.GA2926483@hori.linux.bs1.fc.nec.co.jp>
References: <20230417045323.11054-1-wangkefeng.wang@huawei.com>
 <20230418031243.GA2845864@hori.linux.bs1.fc.nec.co.jp>
 <54d761bb-1bcc-21a2-6b53-9d797a3c076b@huawei.com>
In-Reply-To: <54d761bb-1bcc-21a2-6b53-9d797a3c076b@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8591:EE_|OSZPR01MB8609:EE_
x-ms-office365-filtering-correlation-id: cf7f5969-5de2-4307-2070-08db40a75301
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K4stozMMQufN4oEBiMuXv7smvEZ3qNfZYnQKLBdmz0zhMhxcPrgDF2FzQxHeow94tKbpROK3hqqltNDJ/rWScgNr6CXj6l3lRF/Z7Hmlpxh1sZzIVEqZHhyMDxyA+WCG4fZqiYBbBxUebSk+dEXuI5O92muOj7d5Qt9BfJK03Jfhhreu0Bwb32dnmE4O4FGeU0pzsexsezMCF7powzJH8riypEIdZff4+Bv8Tz4TmGbs3oUErKCellRxvEircKMZIhEvOsEhNeVgyFLtStzNeNL+NTYbVZhqZ3zjZDNm6tkdhspqqNN8EHkgQbpS7Uh1uI7Ltwv7UmkJfNNYE95fweo8gVI16kbTXDkr0JGMBCmBrrPv0UtQhDI1pw64zLTJVeH1Wxv+54LvLaJjpAVi7zLVB3uRLuqJKzsFb+Eh8BbigXOsAR5p6zPvZdQzimWa9jtMre8BVf1XvjleNkfNbkVbMZ91Plk7ct90khqmkZJCc0MX8gcQiCOG8SeCXitA36us69RZdJzn/xSM1b4yBkCf13s8MfgQkyZZ/N9ZkmyG7B9b7a7AES03U6NxZWDIEYJiR1LMaZHkgiV0ibULQ1tCsJZvY3o8gqKXba970rfZq7pIZNhoXih4zQJ3Y8EZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(346002)(376002)(396003)(366004)(451199021)(8936002)(38100700002)(8676002)(122000001)(38070700005)(7416002)(2906002)(85182001)(33656002)(86362001)(5660300002)(478600001)(6486002)(71200400001)(54906003)(186003)(6506007)(1076003)(53546011)(66946007)(9686003)(76116006)(66476007)(66446008)(6512007)(55236004)(26005)(316002)(82960400001)(6916009)(83380400001)(64756008)(66556008)(41300700001)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bjhvTzJQTTcybDVFT3FYZmtmcENSYVpBanFlWEJvbHh6RVpXZm1iMG13a2Jn?=
 =?utf-8?B?ZGFoamJZTjE0aTdFSWF6TmFUSjVNQk1NbFUwU0tzblpEL1hOb0ZvZGIxbkpH?=
 =?utf-8?B?WmNIaHZLVzQ3YW1NYS8vNnY3TEp4dXcvVmVSaUxWUm1LcDFRMTg5T3R5Z0lr?=
 =?utf-8?B?UEpzUmVURC9IRXVRTUxCNDRyYTBhaG0rVG9nZ0dzeXRyeWJWR1ZrOWNoalBa?=
 =?utf-8?B?Y3J2T1c1eWFFWUZPajhKSXdkNlN0WFBUT0p4elB0RlN1RTR2VUZMK3FHUDkr?=
 =?utf-8?B?eC9zL0xvU1YyUE56WE81NjlTOEFQK0ZUTjYvUUVXTCtiMzV0Y21iQVVRRWE5?=
 =?utf-8?B?TXluWUlXOFMrS0J6SU82eWtHeS9VaWNsNTNETGtkcE1sNGpQR2t3SE56S1Uy?=
 =?utf-8?B?YXY5L2M4Tmd0d3NrdXJLaGJkY3QvVTlFUmx6S2d5aDMzMHB3VjZsU0hIZzhD?=
 =?utf-8?B?a2wwaUxLajNWSVgzSzBSMFFFZmZBWTFXa3ZYVGowemYvUDhMMWpQZVZQNzV0?=
 =?utf-8?B?S3ljVkpCYWgrQ0kxOFRTTTY5S2RyU283SkZoczVaNmhJc0FWZVB1ekhJMERL?=
 =?utf-8?B?SXVucHNrbXk0djlYaTQxUkM5bGJPRFUyYS8zVEcwekkxcjdMYWRSY01qUmN4?=
 =?utf-8?B?QTNHS3NML1NqU05BUzE2MzJoQ2tQUUtqS0w3RWlsa2NMbVpBdDhnKytLVmpK?=
 =?utf-8?B?MFdHcmQ0c2FqT2t5eDlKYzNtZ1grWTRlaFNySW9jSjJWQ2paYkxDU1d6SG50?=
 =?utf-8?B?OG0yWEpSM1A2bFR0WTZ0bTQwTFkyTHhWNElUVnhNSXQvb2tvUmdkSjFwanhp?=
 =?utf-8?B?MU8rWVEyV0R4ejRpMkFwSmtCaWdoNnBtbjZDQ1ZGRTltNFkwcHJZaFpMc2FM?=
 =?utf-8?B?ZTVGaG1zZTNrK3JyK1A1eTErTlNsWFp4b1Y4UnBJdmNLcnJ0SDFPT01tcnJY?=
 =?utf-8?B?NTJYNVFWemdYUEcwUk9XaTdYMGlLV2gxc3dva0QzOUloMDcvQU5DNVpGdDdq?=
 =?utf-8?B?aFd5WU5MMVR1b1lCQVhzWnFRODVjVFA3QXQ1anRYUU1IMWxyN2JtN2o3aEFx?=
 =?utf-8?B?SUpmY3E1Qld3bWp5R1FUUHpGQ2hUbVAzZGdmOWYyYkF3L2gzTmFwSEtPMEhT?=
 =?utf-8?B?b0VhcVNLNGIxeDA3TXU0NWU4Vk0zUVZyeWJjSkRObUJza3RZS2gyR0ZTSUNi?=
 =?utf-8?B?MmMzdm5lSDdKd011RG5KNHZXU01Zdk5PK3ZPc0ZLNkJRWmhzUW1FaDZxaWpX?=
 =?utf-8?B?Z0U3SlU4dit0emJYTTdnSFRrTVQxeXBia2Vvb1RRc3FTbDF5dThKMk9zeDBu?=
 =?utf-8?B?QjdyQXBwQlllQzM1MHNYNW5PWEpBNnJLakFnd1JVOTZ2Q3JSbXEzS2NEcG9a?=
 =?utf-8?B?VEEvSGg5dW84Zm4zSE94QmZCVDBMdmNUVDRETW5vdy9yRXcza2N2RnpVZXNY?=
 =?utf-8?B?MXhpRHIwN29ZU2dzL2lYQ1FwdHBWdS8ybnIybEZtbUFKZEYrNnNoL1RIcFkr?=
 =?utf-8?B?a2N4OVJTTGFrVm8vcGpRTHlSbkJ1YzhGREt1M0NVYUlHd0dLUTU1OHNSa0Nx?=
 =?utf-8?B?Y04vMkFXT2NLV0M1UERYQXlDQm8veDJJRkxEZmt4RkM1Z29HWjRQNHQ5STZ0?=
 =?utf-8?B?ZU0wb1VrcHRCWkg4cjFFSXl3OHdnL3VleHdDbDJIaktML2s3bERTZERXU3Zh?=
 =?utf-8?B?ZUZyVEVlQlR3ditEeVNXVkNQK0VLWnRGbXVKRGY4U2Q5eEErdGN5YW5SRFBq?=
 =?utf-8?B?T2llM2xhaGJvbGtaZVhtTGFzcGZ5R0U5bWZDa2hFR0tuV3ZrSHZ3b2RTWWNC?=
 =?utf-8?B?ZnNsN3BtMjllZ0pKbXhsVzBUOEV1Qm5ReUhTRE14dzNYcDVRSnQvOVBJOWZN?=
 =?utf-8?B?NFl5VFI0Z21KUVI1dVRRQjAwYW9vRGhIRXJ0QjNyNVlHcnVLZEo1Q3FFMVdB?=
 =?utf-8?B?K0VHODRBak5CSVgxZ3F3R3ZLM3hkQlFlLzEzQ0lXZkRkZCswRjdoWjZ1eW45?=
 =?utf-8?B?SEFBUGhmODE4V0FJdUhkakc2bHE0SnEzSnd5WFg5NGJGSENRSWM1K1kwYlVv?=
 =?utf-8?B?akx0UmJhUm1SQ1IwVURySzM2MEhPVlRWamFrR3FEN3lpQWhSRlZGU3Q0aHdE?=
 =?utf-8?B?SXlTRmM5V1FtV0tab3NaeUZhQnl1TFF4U2QvblJLZ01rejlNdVJ4WXJFRWRk?=
 =?utf-8?B?MEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DCD1F870F7B6C34ABC117ACD1B38117D@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf7f5969-5de2-4307-2070-08db40a75301
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2023 07:25:59.9154
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zoNnP7kXgPnzw7GL2Wy8cFz+9QHlxTg2ENPFrwHbnDGgfrLhLp9kdIobd57w8TlyRQfIwdNhdeuSfpfJGjsGjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8609
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gVHVlLCBBcHIgMTgsIDIwMjMgYXQgMDU6NDU6MDZQTSArMDgwMCwgS2VmZW5nIFdhbmcgd3Jv
dGU6DQo+IA0KPiANCj4gT24gMjAyMy80LzE4IDExOjEzLCBIT1JJR1VDSEkgTkFPWUEo5aCA5Y+j
IOebtOS5nykgd3JvdGU6DQo+ID4gT24gTW9uLCBBcHIgMTcsIDIwMjMgYXQgMTI6NTM6MjNQTSAr
MDgwMCwgS2VmZW5nIFdhbmcgd3JvdGU6DQo+ID4gPiBUaGUgZHVtcF91c2VyX3JhbmdlKCkgaXMg
dXNlZCB0byBjb3B5IHRoZSB1c2VyIHBhZ2UgdG8gYSBjb3JlZHVtcCBmaWxlLA0KPiA+ID4gYnV0
IGlmIGEgaGFyZHdhcmUgbWVtb3J5IGVycm9yIG9jY3VycmVkIGR1cmluZyBjb3B5LCB3aGljaCBj
YWxsZWQgZnJvbQ0KPiA+ID4gX19rZXJuZWxfd3JpdGVfaXRlcigpIGluIGR1bXBfdXNlcl9yYW5n
ZSgpLCBpdCBjcmFzaGVzLA0KPiA+ID4gDQo+ID4gPiAgICBDUFU6IDExMiBQSUQ6IDcwMTQgQ29t
bTogbWNhLXJlY292ZXIgTm90IHRhaW50ZWQgNi4zLjAtcmMyICM0MjUNCj4gPiA+ICAgIHBjIDog
X19tZW1jcHkrMHgxMTAvMHgyNjANCj4gPiA+ICAgIGxyIDogX2NvcHlfZnJvbV9pdGVyKzB4M2Jj
LzB4NGM4DQo+ID4gPiAgICAuLi4NCj4gPiA+ICAgIENhbGwgdHJhY2U6DQo+ID4gPiAgICAgX19t
ZW1jcHkrMHgxMTAvMHgyNjANCj4gPiA+ICAgICBjb3B5X3BhZ2VfZnJvbV9pdGVyKzB4Y2MvMHgx
MzANCj4gPiA+ICAgICBwaXBlX3dyaXRlKzB4MTY0LzB4NmQ4DQo+ID4gPiAgICAgX19rZXJuZWxf
d3JpdGVfaXRlcisweDljLzB4MjEwDQo+ID4gPiAgICAgZHVtcF91c2VyX3JhbmdlKzB4YzgvMHgx
ZDgNCj4gPiA+ICAgICBlbGZfY29yZV9kdW1wKzB4MzA4LzB4MzY4DQo+ID4gPiAgICAgZG9fY29y
ZWR1bXArMHgyZTgvMHhhNDANCj4gPiA+ICAgICBnZXRfc2lnbmFsKzB4NTljLzB4Nzg4DQo+ID4g
PiAgICAgZG9fc2lnbmFsKzB4MTE4LzB4MWY4DQo+ID4gPiAgICAgZG9fbm90aWZ5X3Jlc3VtZSsw
eGYwLzB4MjgwDQo+ID4gPiAgICAgZWwwX2RhKzB4MTMwLzB4MTM4DQo+ID4gPiAgICAgZWwwdF82
NF9zeW5jX2hhbmRsZXIrMHg2OC8weGMwDQo+ID4gPiAgICAgZWwwdF82NF9zeW5jKzB4MTg4LzB4
MTkwDQo+ID4gPiANCj4gPiA+IEdlbmVyYWxseSwgdGhlICctPndyaXRlX2l0ZXInIG9mIGZpbGUg
b3BzIHdpbGwgdXNlIGNvcHlfcGFnZV9mcm9tX2l0ZXIoKQ0KPiA+ID4gYW5kIGNvcHlfcGFnZV9m
cm9tX2l0ZXJfYXRvbWljKCksIGNoYW5nZSBtZW1jcHkoKSB0byBjb3B5X21jX3RvX2tlcm5lbCgp
DQo+ID4gPiBpbiBib3RoIG9mIHRoZW0gdG8gaGFuZGxlICNNQyBkdXJpbmcgc291cmNlIHJlYWQs
IHdoaWNoIHN0b3AgY29yZWR1bXANCj4gPiA+IHByb2Nlc3NpbmcgYW5kIGtpbGwgdGhlIHRhc2sg
aW5zdGVhZCBvZiBrZXJuZWwgcGFuaWMsIGJ1dCB0aGUgc291cmNlDQo+ID4gPiBhZGRyZXNzIG1h
eSBub3QgYWx3YXlzIGEgdXNlciBhZGRyZXNzLCBzbyBpbnRyb2R1Y2UgYSBuZXcgY29weV9tYyBm
bGFnIGluDQo+ID4gPiBzdHJ1Y3QgaW92X2l0ZXJ7fSB0byBpbmRpY2F0ZSB0aGF0IHRoZSBpdGVy
IGNvdWxkIGRvIGEgc2FmZSBtZW1vcnkgY29weSwNCj4gPiA+IGFsc28gaW50cm9kdWNlIHRoZSBo
ZWxwZXJzIHRvIHNldC9jbGVjayB0aGUgZmxhZywgZm9yIG5vdywgaXQncyBvbmx5DQo+ID4gPiB1
c2VkIGluIGNvcmVkdW1wJ3MgZHVtcF91c2VyX3JhbmdlKCksIGJ1dCBpdCBjb3VsZCBleHBhbmQg
dG8gYW55IG90aGVyDQo+ID4gPiBzY2VuYXJpb3MgdG8gZml4IHRoZSBzaW1pbGFyIGlzc3VlLg0K
PiA+ID4gDQo+ID4gPiBDYzogQWxleGFuZGVyIFZpcm8gPHZpcm9AemVuaXYubGludXgub3JnLnVr
Pg0KPiA+ID4gQ2M6IENocmlzdGlhbiBCcmF1bmVyIDxicmF1bmVyQGtlcm5lbC5vcmc+DQo+ID4g
PiBDYzogTWlhb2hlIExpbiA8bGlubWlhb2hlQGh1YXdlaS5jb20+DQo+ID4gPiBDYzogTmFveWEg
SG9yaWd1Y2hpIDxuYW95YS5ob3JpZ3VjaGlAbmVjLmNvbT4NCj4gPiA+IENjOiBUb25nIFRpYW5n
ZW4gPHRvbmd0aWFuZ2VuQGh1YXdlaS5jb20+DQo+ID4gPiBDYzogSmVucyBBeGJvZSA8YXhib2VA
a2VybmVsLmRrPg0KPiA+ID4gU2lnbmVkLW9mZi1ieTogS2VmZW5nIFdhbmcgPHdhbmdrZWZlbmcu
d2FuZ0BodWF3ZWkuY29tPg0KPiA+ID4gLS0tDQo+ID4gPiB2MjoNCj4gPiA+IC0gbW92ZSB0aGUg
aGVscGVyIGZ1bmN0aW9ucyB1bmRlciBwcmUtZXhpc3RpbmcgQ09ORklHX0FSQ0hfSEFTX0NPUFlf
TUMNCj4gPiA+IC0gcmVwb3NpdGlvbiB0aGUgY29weV9tYyBpbiBzdHJ1Y3QgaW92X2l0ZXIgZm9y
IGVhc3kgbWVyZ2UsIHN1Z2dlc3RlZA0KPiA+ID4gICAgYnkgQW5kcmV3IE1vcnRvbg0KPiA+ID4g
LSBkcm9wIHVubmVjZXNzYXJ5IGNsZWFyIGZsYWcgaGVscGVyDQo+ID4gPiAtIGZpeCBjaGVja3Bh
dGNoIHdhcm5pbmcNCj4gPiA+ICAgZnMvY29yZWR1bXAuYyAgICAgICB8ICAxICsNCj4gPiA+ICAg
aW5jbHVkZS9saW51eC91aW8uaCB8IDE2ICsrKysrKysrKysrKysrKysNCj4gPiA+ICAgbGliL2lv
dl9pdGVyLmMgICAgICB8IDE3ICsrKysrKysrKysrKysrKy0tDQo+ID4gPiAgIDMgZmlsZXMgY2hh
bmdlZCwgMzIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPiA+IA0KPiA+IC4uLg0K
PiA+ID4gQEAgLTM3MSw2ICszNzIsMTQgQEAgc2l6ZV90IF9jb3B5X21jX3RvX2l0ZXIoY29uc3Qg
dm9pZCAqYWRkciwgc2l6ZV90IGJ5dGVzLCBzdHJ1Y3QgaW92X2l0ZXIgKmkpDQo+ID4gPiAgIEVY
UE9SVF9TWU1CT0xfR1BMKF9jb3B5X21jX3RvX2l0ZXIpOw0KPiA+ID4gICAjZW5kaWYgLyogQ09O
RklHX0FSQ0hfSEFTX0NPUFlfTUMgKi8NCj4gPiA+ICtzdGF0aWMgdm9pZCAqbWVtY3B5X2Zyb21f
aXRlcihzdHJ1Y3QgaW92X2l0ZXIgKmksIHZvaWQgKnRvLCBjb25zdCB2b2lkICpmcm9tLA0KPiA+
ID4gKwkJCQkgc2l6ZV90IHNpemUpDQo+ID4gPiArew0KPiA+ID4gKwlpZiAoaW92X2l0ZXJfaXNf
Y29weV9tYyhpKSkNCj4gPiA+ICsJCXJldHVybiAodm9pZCAqKWNvcHlfbWNfdG9fa2VybmVsKHRv
LCBmcm9tLCBzaXplKTsNCj4gPiANCj4gPiBJcyBpdCBoZWxwZnVsIHRvIGNhbGwgbWVtb3J5X2Zh
aWx1cmVfcXVldWUoKSBpZiBjb3B5X21jX3RvX2tlcm5lbCgpIGZhaWxzDQo+ID4gZHVlIHRvIGEg
bWVtb3J5IGVycm9yPw0KPiANCj4gRm9yIGR1bXBfdXNlcl9yYW5nZSgpLCB0aGUgdGFzayBpcyBk
eWluZywgaWYgY29weSBpbmNvbXBsZXRlIHNpemUsIHRoZQ0KPiBjb3JlZHVtcCB3aWxsIGZhaWwg
YW5kIHRhc2sgd2lsbCBleGl0LCBhbHNvIG1lbW9yeV9mYWlsdXJlIHdpbGwNCj4gYmUgY2FsbGVk
IGJ5IGtpbGxfbWVfbWF5YmUoKSwNCj4gDQo+ICBDUFU6IDAgUElEOiAxNDE4IENvbW06IHRlc3Qg
VGFpbnRlZDogRyAgIE0gICAgICAgICAgICAgICA2LjMuMC1yYzUgIzI5DQo+ICBDYWxsIFRyYWNl
Og0KPiAgIDxUQVNLPg0KPiAgIGR1bXBfc3RhY2tfbHZsKzB4MzcvMHg1MA0KPiAgIG1lbW9yeV9m
YWlsdXJlKzB4NTEvMHg5NzANCj4gICBraWxsX21lX21heWJlKzB4NWIvMHhjMA0KPiAgIHRhc2tf
d29ya19ydW4rMHg1YS8weDkwDQo+ICAgZXhpdF90b191c2VyX21vZGVfcHJlcGFyZSsweDE5NC8w
eDFhMA0KPiAgIGlycWVudHJ5X2V4aXRfdG9fdXNlcl9tb2RlKzB4OS8weDMwDQo+ICAgbm9pc3Rf
ZXhjX21hY2hpbmVfY2hlY2srMHg0MC8weDgwDQo+ICAgYXNtX2V4Y19tYWNoaW5lX2NoZWNrKzB4
MzMvMHg0MA0KDQpJcyB0aGlzIGNhbGwgdHJhY2UgcHJpbnRlZCBvdXQgd2hlbiBjb3B5X21jX3Rv
X2tlcm5lbCgpIGZhaWxlZCBieSBmaW5kaW5nDQphIG1lbW9yeSBlcnJvciAob3IgaW4gc29tZSB0
ZXN0Y2FzZSB1c2luZyBlcnJvciBpbmplY3Rpb24pPw0KSW4gbXkgdW5kZXJzdGFuZGluZywgYW4g
TUNFIHNob3VsZCBub3QgYmUgdHJpZ2dlcmVkIHdoZW4gTUMtc2FmZSBjb3B5IHRyaWVzDQp0byBh
Y2Nlc3MgdG8gYSBtZW1vcnkgZXJyb3IuICBTbyBJIGZlZWwgdGhhdCB3ZSBtaWdodCBiZSB0YWxr
aW5nIGFib3V0DQpkaWZmZXJlbnQgc2NlbmFyaW9zLg0KDQpXaGVuIEkgcXVlc3Rpb25lZCBwcmV2
aW91c2x5LCBJIHRob3VnaHQgYWJvdXQgdGhlIGZvbGxvd2luZyBzY2VuYXJpbzoNCg0KICAtIGEg
cHJvY2VzcyB0ZXJtaW5hdGVzIGFibm9ybWFsbHkgZm9yIGFueSByZWFzb24gbGlrZSBzZWdtZW50
YXRpb24gZmF1bHQsDQogIC0gdGhlbiwga2VybmVsIHRyaWVzIHRvIGNyZWF0ZSBhIGNvcmVkdW1w
LA0KICAtIGR1cmluZyB0aGlzLCB0aGUgY29weWluZyByb3V0aW5lIGFjY2Vzc2VzIHRvIGNvcnJ1
cHRlZCBwYWdlIHRvIHJlYWQuDQoNCkluIHRoaXMgY2FzZSB0aGUgY29ycnVwdGVkIHBhZ2Ugc2hv
dWxkIG5vdCBiZSBoYW5kbGVkIGJ5IG1lbW9yeV9mYWlsdXJlKCkNCnlldCAoYmVjYXVzZSBvdGhl
cndpc2UgcHJvcGVybHkgaGFuZGxlZCBod3BvaXNvbmVkIHBhZ2Ugc2hvdWxkIGJlIGlnbm9yZWQN
CmJ5IGNvcmVkdW1wIHByb2Nlc3MpLiAgVGhlIGNvcmVkdW1wIHByb2Nlc3Mgd291bGQgZXhpdCB3
aXRoIGZhaWx1cmUgd2l0aA0KeW91ciBwYXRjaCwgYnV0IHRoZW4sIHRoZSBjb3JydXB0ZWQgcGFn
ZSBpcyBzdGlsbCBsZWZ0IHVuaGFuZGxlZCBhbmQgY2FuDQpiZSByZXVzZWQsIHNvIGFueSBvdGhl
ciB0aHJlYWQgY2FuIGVhc2lseSBhY2Nlc3MgdG8gaXQgYWdhaW4uDQoNCllvdSBjYW4gZmluZCBh
IGZldyBvdGhlciBwbGFjZXMgKGxpa2UgX193cF9wYWdlX2NvcHlfdXNlciBhbmQga3NtX21pZ2h0
X25lZWRfdG9fY29weSkNCnRvIGNhbGwgbWVtb3J5X2ZhaWx1cmVfcXVldWUoKSB0byBjb3BlIHdp
dGggc3VjaCB1bmhhbmRsZWQgZXJyb3IgcGFnZXMuDQpTbyBkb2VzIG1lbWNweV9mcm9tX2l0ZXIo
KSBkbyB0aGUgc2FtZT8NCg0KVGhhbmtzLA0KTmFveWEgSG9yaWd1Y2hp
