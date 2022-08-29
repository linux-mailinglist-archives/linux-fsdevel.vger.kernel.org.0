Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 874655A4276
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Aug 2022 07:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbiH2Fmp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Aug 2022 01:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiH2Fmn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Aug 2022 01:42:43 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2054.outbound.protection.outlook.com [40.107.113.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 713473DF29;
        Sun, 28 Aug 2022 22:42:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GKal3toqu/aSf1aWhebiz4yPy9giDJYb/Ixrx3GizD59jVI5tnfwW9Nbxh03rqICFVx8V73Ln00cn5Klb9pT4g+ttAk6PihtTcFf+ehWQXA2B/uR+yDwsXipIqK9mJ0yIFlSomP1fNmhh6uQQQO65L+Rj6zRCHamvOoPpd32bQ/+0hcx/1/nO+W2cnbYja5tejvSUDNYdCNx8dpyqfbyTXYCFxGC9owAiQKTHOvEXh7zdf9+LneVxdULDHDD816Ceom21cQf/CSJDFACVcExN03Jq5afWhr8Kon4fCj53qUD/Pvlv3T1+q2R/gs4v+GOlpQrXsHOpW6imYLnMMx7vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t42xooH/fQ/j4hbsEH+AzPNraTBd5HDDh8I7pdGnSU8=;
 b=iD2hYm4SGlZmZX0jCO64S4giJkovpp4MgWmXu/z9rAwgUwTHDp+8rM5OugIqftK0UK/yGqRwwPZWmINh2eboz5SgdmCxvwH4nqCu/MvBrWtw4ptog5F7bFzIJaF8aIkYWhcC0MiZyB7Of7MV0m6NtZz/MAkUO+Xfg08h301HSSujG3n9zfF6mYOG1H4+ngJ7THMvzKxUUcIjo1mOTqV40+5+ZLs8GMfS0gNlNPB9gdOGgvxsle3G00oHBzPJ/0tjKtXEKeiHGiPyT9CRrgoCor+H5in9lJag/iKVKrZu4oMHOVLFSsTt4pPTw+w4Kkb0Lk9GAEB+eKjk1+5zAILFbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t42xooH/fQ/j4hbsEH+AzPNraTBd5HDDh8I7pdGnSU8=;
 b=A/VbURsCLWflkDvyvEIFfgKTbTjL1MnvlS5BjacQxj0K3ciaKyL2ROvQ16OkB5yweUw42PS/YXD26TN/AAI7f6AkRRr9DXgEcBmOBTfntkeTZH9mXj6+bb9IY0vZYryAaAY970+NbvJhgxGNIIB1VE67i865H7SHqrez1JcHp8Y=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by TY2PR01MB2284.jpnprd01.prod.outlook.com (2603:1096:404:f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Mon, 29 Aug
 2022 05:42:39 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::442c:db3a:80:287a]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::442c:db3a:80:287a%5]) with mapi id 15.20.5566.021; Mon, 29 Aug 2022
 05:42:39 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "djwong@kernel.org" <djwong@kernel.org>,
        Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dave Chinner <david@fromorbit.com>,
        Goldwyn Rodrigues <rgoldwyn@suse.de>,
        Jane Chu <jane.chu@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 4/4] mm/memory-failure: Fall back to vma_address() when
 ->notify_failure() fails
Thread-Topic: [PATCH 4/4] mm/memory-failure: Fall back to vma_address() when
 ->notify_failure() fails
Thread-Index: AQHYuW/ehI43Wryl6023IlppSuqkba3FYWsA
Date:   Mon, 29 Aug 2022 05:42:39 +0000
Message-ID: <20220829054238.GB1029946@hori.linux.bs1.fc.nec.co.jp>
References: <166153426798.2758201.15108211981034512993.stgit@dwillia2-xfh.jf.intel.com>
 <166153429427.2758201.14605968329933175594.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <166153429427.2758201.14605968329933175594.stgit@dwillia2-xfh.jf.intel.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3b062cfc-4531-42d5-023e-08da898148d2
x-ms-traffictypediagnostic: TY2PR01MB2284:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZC+kn+m/lWGty51YnNEv99Yoemgpk798fN8xby7p6nli6POXmQK7CGXMjNtbij0NrC46Kl4aiNbheXmpSb9y4PXLSYHJjEQ10kfmidpnk/+VfXvW5IQ9AZrATtAVeNpiHdUZUwxepccjmfJuhP1nbxy5svIVGP6DBw8JGV8rBOF/eAjhz6J4HwSOtyPpz1FrlmSrFZ54UY3mP+nAvLgR0TvAnoYQbgB94hGdit1oMyUmK4SmqK99vtSKqFvhn7jQmqHMTUD7Z9X3c/M7bLV55/1V43u2SclvtEHH9W+X/xm63xWhmiKUX5/AUgqSFxHs+tIunY/qrrzCuobKT/7advKakxZEfiNoE39rSyvKKDUvmPbbtyVClftE+FTiAVeq5ZDP1J06/Q0QFhyYPISp8rp2vjAvp/Xp5c1T1KiIHqZVEQYmGjGv1zsXC1/fIc47/ATtgPdHyexZhNwE5sgi9KQzFiJ+zcMDvlXeEzOy4w1t8MQ7vTrer3werLdAYSk3O8fQmnT6sAGNLGzQK2z6mODq3t2fEGvSy/ROm5gq6T80Okg1MNN5tZxTLXvBp1BCgX5UByDsU6/1Sa/tQbLIjNEACZsh9ZIZq8MUylvZC/HqlXINvOJ1Cfxhu3xG4kYhKnHd9vi/kwRX26zjIQqx/Eppq1bTkEEIqecjiAOV188J6VCEOZ7P1zbPJkFVXlnScR+sdZerL0/GqIn0x6ZiKWaNbbIJC9vYBToU8UzJqcMaGR9aCLNKOsSSUA5ipi63Ob+R80J1iQuZ0y048TZm0Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(376002)(39860400002)(136003)(346002)(1076003)(316002)(6916009)(54906003)(71200400001)(8676002)(4326008)(6486002)(86362001)(66446008)(66946007)(76116006)(66556008)(66476007)(64756008)(5660300002)(478600001)(85182001)(82960400001)(38070700005)(8936002)(41300700001)(7416002)(38100700002)(6506007)(122000001)(2906002)(83380400001)(26005)(6512007)(9686003)(186003)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZVNGRWNySTBTRVlQZEpublh0SVhtMEt6ZnZmajlXZU1PSDcyeDBaSjQxdkVQ?=
 =?utf-8?B?ak5OcUYyU3RSUGU4N3YzeHhWc3NwQUxZMkR1NEYrejdxQ3VDTmx1YTVqeVU1?=
 =?utf-8?B?YVVKMDA2ZVVEL0hXbkpPeUpURkRsN0Y5eXdPa0FIU3htdFgvTVUyTFIrRDI5?=
 =?utf-8?B?U0xQRG1EcDhQZFJHVzVRMkFXSUZvc0wzckhtK08rYVA3OHo2VkNVbkxaUFlU?=
 =?utf-8?B?UkpjT0FYc0ZyOWFXWDJXRWRkNGdBbldHMVRVTmI4RDduZ0xpL2QvemNIdXFW?=
 =?utf-8?B?VjdldGNRTkRLZzRTUlZkaVJTS2pBTkRCbUlqd3l1SXVKRlNQbG9DbjZRVkFZ?=
 =?utf-8?B?NDVVSGdLRHdjSjJzbzFUcTFMR3FqK0JqbjJINlZVR1JML1ovdlB5dE1Wd3dT?=
 =?utf-8?B?cFpadDB0Y0hUU0YrSWwzOE1vYU90cmVPOHBPYmQ0MWxnWlo1dCtmTWJTeTBQ?=
 =?utf-8?B?T1FVdDNlYVhiNmQ1VUZwYmdVZVpmYVhpZmFRajZzTEJEK05rNjcwZkIyZ0k2?=
 =?utf-8?B?dVNxRC9uV3p5K2dteUtXTGdtaHJWYUlqanJJUDJtSjRqNGI1UVJQb20xUUZM?=
 =?utf-8?B?WS83SHJ1NUtEY3FzWjUwaWJNTit2N3g4bmFabUg4anBjL2RMRU9VS2MzWlAr?=
 =?utf-8?B?NUU3SDA4cjVqcVFueVJQRGJhWnJVb2REbytQVmQ5Q3JyUWFVNmFFVEFHVGRX?=
 =?utf-8?B?SzJia0ZuOFJtM3d4OVMzQkcwOW5XUVNHL2FkSWpDSjh1eDVLNHhKYm82REtj?=
 =?utf-8?B?eSswVkowSUs5Yi90KytXNEV0ZnhxM0dOSnlWeDFIVW9BSmJiRzJ2eXVTem1h?=
 =?utf-8?B?ZmNBaDJvbzdvc1J6K21KaFAzRlFucks1Nm5pU2V5YXUwd2U3NDg0bk9hem9p?=
 =?utf-8?B?bC9ZMzc4TzB4TE1EK3BoZFpGc25ZaFo3S2VvalRydGRJRGRwVkV1T2IrR2Uv?=
 =?utf-8?B?bnlLSFJTdkVUTnZtY2ZTMGRyeXhTaWEzSVF4MERJajdHK3dDbzRBdHJpR1B0?=
 =?utf-8?B?Z3NEbkw2VHJPWXVwRm5jYThndEkyaWxTZEpQUjRZNllrVWhKbk1lb3dJdXl2?=
 =?utf-8?B?RmpGUndVTzJsczJ3N0FMSkFIaHcxRXhsQXhJbEtFYnpUMm1uck1seHZMZ0Rp?=
 =?utf-8?B?RHRjMlhkUi9CSFVMRk80eFBId05JZFdXTDFtVnNCcWtzenBvbEVham1abG00?=
 =?utf-8?B?cm94TmpXcGVyTEt2WHVpUGFydkRSWFZQalNsb3hwZ2hrL3VlWDMzaDJYV2pp?=
 =?utf-8?B?Wjh3YVFtVDErRHdlRnF1ZzRuZ1dFUVB6WXRTZS9RbzNMSit0NUcrM05OUHdV?=
 =?utf-8?B?aTc3TnQwZS85THNqcmF2MnJsRk1lZXpabTFpZFNQUzhyU0JVTFNmOGFFN1FM?=
 =?utf-8?B?Zk1HamkzMEdYVmNDSW8rOFBGS3BuL2x0dXlqeFZMR0NuWi9NdndWWWV1QlJM?=
 =?utf-8?B?cVdsQmVuYTRkeTRrUnVpbXdSUXBpU1ZhTGhYYmlTWHFjVnN0eThwbHlwVUNZ?=
 =?utf-8?B?Vlp0U1AzR2hrMVpOSlhZVHhmd2d4NXd4Rm8wOUQ4QXVHS3gxL01CUmJHcitG?=
 =?utf-8?B?VGs2aGdERm9lVjViSHVVcnA2NXJiTW80N3Y4aHJrOG9yN2RwWlQ5MnZaeVd3?=
 =?utf-8?B?MTZzaE1mVUVyc0dTUGJGbHlXMHNIeVNvano3VTF2bmEvUFJ6Zkp2RWUwR2Nz?=
 =?utf-8?B?TnVlbFhJZ1lUWWU4cGxQNVowMk1SOUhUVndpN0NjUmliS0pqaCtlaTh6ZmFw?=
 =?utf-8?B?RXpTK1VHK0dQTkNDUUEwdTNxTU4zN21WWWhqU2EwOVFoSjJQSHpJQ1JyVFlZ?=
 =?utf-8?B?T0dXNGVtelpMSEM5UEwySnpoNTZQYTE4NS9SMkZZL2orNDczVFlvUjV1cUND?=
 =?utf-8?B?YkFxRnlSaVo4cnR4VVRjb2I2STJaWno3bjB1V3hsdmUxNmozVGE2MzJZU0tU?=
 =?utf-8?B?cFlkM3RTblR1aXBxaHNwWXpoZUtzTGFKZWloc3JoeUhxdmxXenB0N214dkNl?=
 =?utf-8?B?blZML0J6YXhwZk1OOFYwRTRteFBpUEhqb0kwUnpPOUdmZXZiaU5GMW5BT3By?=
 =?utf-8?B?WHc1NWM1azRueERUZEdUL25EVHRmRHdXbHVkRDB1T1pObEFjZHA2TG5aK1Iv?=
 =?utf-8?B?SlczdnkzRUNRTEJSaThrdnprVXJHVzFlR29oMHBpajB3U0U2M1BoYXhubEZ1?=
 =?utf-8?B?dFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2ABCB1A080C4D342886D9EBE92359DB1@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b062cfc-4531-42d5-023e-08da898148d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2022 05:42:39.1543
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vPgSHduDLvajUsOzrG64huZwD5693IYnyJcuJyaw1y29w2898XFr/DcUEBSfSY0V53/q/C/L2yxii08F0hpHPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB2284
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gRnJpLCBBdWcgMjYsIDIwMjIgYXQgMTA6MTg6MTRBTSAtMDcwMCwgRGFuIFdpbGxpYW1zIHdy
b3RlOg0KPiBJbiB0aGUgY2FzZSB3aGVyZSBhIGZpbGVzeXN0ZW0gaXMgcG9sbGVkIHRvIHRha2Ug
b3ZlciB0aGUgbWVtb3J5IGZhaWx1cmUNCj4gYW5kIHJlY2VpdmVzIC1FT1BOT1RTVVBQIGl0IGlu
ZGljYXRlcyB0aGF0IHBhZ2UtPmluZGV4IGFuZCBwYWdlLT5tYXBwaW5nDQo+IGFyZSB2YWxpZCBm
b3IgcmV2ZXJzZSBtYXBwaW5nIHRoZSBmYWlsdXJlIGFkZHJlc3MuIEludHJvZHVjZQ0KPiBGU0RB
WF9JTlZBTElEX1BHT0ZGIHRvIGRpc3Rpbmd1aXNoIHdoZW4gYWRkX3RvX2tpbGwoKSBpcyBiZWlu
ZyBjYWxsZWQNCj4gZnJvbSBtZl9kYXhfa2lsbF9wcm9jcygpIGJ5IGEgZmlsZXN5dGVtIHZzIHRo
ZSB0eXBpY2FsIG1lbW9yeV9mYWlsdXJlKCkNCj4gcGF0aC4NCj4gDQo+IE90aGVyd2lzZSwgdm1h
X3Bnb2ZmX2FkZHJlc3MoKSBpcyBjYWxsZWQgd2l0aCBhbiBpbnZhbGlkIGZzZGF4X3Bnb2ZmDQo+
IHdoaWNoIHRoZW4gdHJpcHMgdGhpcyBmYWlsaW5nIHNpZ25hdHVyZToNCj4gDQo+ICBrZXJuZWwg
QlVHIGF0IG1tL21lbW9yeS1mYWlsdXJlLmM6MzE5IQ0KPiAgaW52YWxpZCBvcGNvZGU6IDAwMDAg
WyMxXSBQUkVFTVBUIFNNUCBQVEkNCj4gIENQVTogMTMgUElEOiAxMjYyIENvbW06IGRheC1wbWQg
VGFpbnRlZDogRyAgICAgICAgICAgT0UgICAgTiA2LjAuMC1yYzIrICM2Mg0KPiAgSGFyZHdhcmUg
bmFtZTogUUVNVSBTdGFuZGFyZCBQQyAoUTM1ICsgSUNIOSwgMjAwOSksIEJJT1MgMC4wLjAgMDIv
MDYvMjAxNQ0KPiAgUklQOiAwMDEwOmFkZF90b19raWxsLmNvbGQrMHgxOWQvMHgyMDkNCj4gIFsu
Ll0NCj4gIENhbGwgVHJhY2U6DQo+ICAgPFRBU0s+DQo+ICAgY29sbGVjdF9wcm9jcy5wYXJ0LjAr
MHgyYzQvMHg0NjANCj4gICBtZW1vcnlfZmFpbHVyZSsweDcxYi8weGJhMA0KPiAgID8gX3ByaW50
aysweDU4LzB4NzMNCj4gICBkb19tYWR2aXNlLnBhcnQuMC5jb2xkKzB4YWYvMHhjNQ0KPiANCj4g
Rml4ZXM6IGMzNmUyMDI0OTU3MSAoIm1tOiBpbnRyb2R1Y2UgbWZfZGF4X2tpbGxfcHJvY3MoKSBm
b3IgZnNkYXggY2FzZSIpDQo+IENjOiBTaGl5YW5nIFJ1YW4gPHJ1YW5zeS5mbnN0QGZ1aml0c3Uu
Y29tPg0KPiBDYzogQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+DQo+IENjOiBEYXJyaWNr
IEouIFdvbmcgPGRqd29uZ0BrZXJuZWwub3JnPg0KPiBDYzogTmFveWEgSG9yaWd1Y2hpIDxuYW95
YS5ob3JpZ3VjaGlAbmVjLmNvbT4NCj4gQ2M6IEFsIFZpcm8gPHZpcm9AemVuaXYubGludXgub3Jn
LnVrPg0KPiBDYzogRGF2ZSBDaGlubmVyIDxkYXZpZEBmcm9tb3JiaXQuY29tPg0KPiBDYzogR29s
ZHd5biBSb2RyaWd1ZXMgPHJnb2xkd3luQHN1c2UuZGU+DQo+IENjOiBKYW5lIENodSA8amFuZS5j
aHVAb3JhY2xlLmNvbT4NCj4gQ2M6IE1hdHRoZXcgV2lsY294IDx3aWxseUBpbmZyYWRlYWQub3Jn
Pg0KPiBDYzogTWlhb2hlIExpbiA8bGlubWlhb2hlQGh1YXdlaS5jb20+DQo+IENjOiBSaXRlc2gg
SGFyamFuaSA8cml0ZXNoaEBsaW51eC5pYm0uY29tPg0KPiBDYzogQW5kcmV3IE1vcnRvbiA8YWtw
bUBsaW51eC1mb3VuZGF0aW9uLm9yZz4NCj4gU2lnbmVkLW9mZi1ieTogRGFuIFdpbGxpYW1zIDxk
YW4uai53aWxsaWFtc0BpbnRlbC5jb20+DQoNCkFja2VkLWJ5OiBOYW95YSBIb3JpZ3VjaGkgPG5h
b3lhLmhvcmlndWNoaUBuZWMuY29tPg==
