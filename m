Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44AE56EC66C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Apr 2023 08:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbjDXGoe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Apr 2023 02:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjDXGod (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Apr 2023 02:44:33 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2052.outbound.protection.outlook.com [40.107.113.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 992E6211D;
        Sun, 23 Apr 2023 23:44:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S70XWEthV8AZVJF1Eczd+Y+C+n/5vsoajMIEEU3Sxx0IZSMM3LW079KAJW8jNXd4KhJWtqBxsFeN2NJkvD9ucQSgARKiPshMUMeoF8ZrGgqRflqMccC7BBkjR2kyQ9h5kh8DzNptG3tPjuch6Vu6AujsHyy0BJg1dLAc7ab3zODJ8aYgsjxj6KCQb6B3gUIwXNwWvzS2lq2k+ZXvnOUtnP22AbHntqxRcj54+YP5QFbeBIUyluRW+6lHzxPBIfyIoB8Sybo0IhaA1oTbtoLN70BngHQH7ZhEtzxcKWPif3OFLEnH6iu5bNchsofJnVj2x7B4NVbkx9SkeFZF/GiOQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z6sqjHEnsg75p3Q6iDvXChnScdX5GtacmCsnISE44RI=;
 b=bCO3Kcky36ca2LCzNyB/RNr02shooHjKBj4d5q/fwhevpwGnXame4F/MXdF0JnTTKE/AeT7P+tRiIDztICR3FfUShN9Hax/sGpQhZ2H8sRQ8m/nyJs3yjHrn7gl6jCOzF+dVb6AmnlcgXQ8v0NNQSdRuEoE4e18eg+U/kALKQ7jKPq8E0DCRhgGFbs+8wlgxwErplAwnq6sw8tSu3D+MFRphDKYk3MGiKjXBeqegMes++00sqoZivGI/c++B5hggmEVOhP8ye5KugDveyO5HVrYiFDe1qRIh+xu3XWs6kesYrQG+UjfRapoGy1IxXzX3/lVFfDBJvx8aCQy5NmGGbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z6sqjHEnsg75p3Q6iDvXChnScdX5GtacmCsnISE44RI=;
 b=XTWvBuO47FLA3oICB7AuSUW9IahjjlHDmP/17BdoiEHa9O4sB318BEtMagQtsAJq7b/GBIZVUxRsi/NUwhoRNAAKHl3Whpo9qQxnavn5mf1FzWT1YmVIr+10VsTf4s4fvWWYEd28cyqdq2QK6jihXPiOHhq1+yyTE4QoG06KHDY=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by TYAPR01MB5626.jpnprd01.prod.outlook.com (2603:1096:404:8054::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Mon, 24 Apr
 2023 06:44:28 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::15c9:309c:d898:c0f5]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::15c9:309c:d898:c0f5%3]) with mapi id 15.20.6319.033; Mon, 24 Apr 2023
 06:44:28 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
CC:     "tony.luck@intel.com" <tony.luck@intel.com>,
        Jane Chu <jane.chu@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
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
Thread-Index: AQHZcaO0la0PeSJsOESJfU1UoYMpbK8w0aIAgAFrdICAAE1ugIAA6rGAgAAP4ACAAMqmAIAAy5sAgAAp1ICABMf7gA==
Date:   Mon, 24 Apr 2023 06:44:28 +0000
Message-ID: <20230424064427.GA3267052@hori.linux.bs1.fc.nec.co.jp>
References: <20230417045323.11054-1-wangkefeng.wang@huawei.com>
 <20230418031243.GA2845864@hori.linux.bs1.fc.nec.co.jp>
 <54d761bb-1bcc-21a2-6b53-9d797a3c076b@huawei.com>
 <20230419072557.GA2926483@hori.linux.bs1.fc.nec.co.jp>
 <9fa67780-c48f-4675-731b-4e9a25cd29a0@huawei.com>
 <7d0c38a9-ed2a-a221-0c67-4a2f3945d48b@oracle.com>
 <6dc1b117-020e-be9e-7e5e-a349ffb7d00a@huawei.com>
 <9a9876a2-a2fd-40d9-b215-3e6c8207e711@huawei.com>
 <20230421031356.GA3048466@hori.linux.bs1.fc.nec.co.jp>
 <1bd6a635-5a3d-c294-38ce-5c6fcff6494f@huawei.com>
In-Reply-To: <1bd6a635-5a3d-c294-38ce-5c6fcff6494f@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8591:EE_|TYAPR01MB5626:EE_
x-ms-office365-filtering-correlation-id: b77ac2b6-83a2-4da0-1924-08db448f5a31
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tx21QsBnma/UqAsFAWMmP0ytMTMfVvFOO/cbU9Fr43L9bBkeLdIIexPR2IY4Z9HR87GbNRs9iLsMyW4GZbqtQsuHj58slQZ1xC+aQbNOVkLiblZ5+4V3sKTCZ9RiFi20N5VErFcXy/1B9LsHLa/csQK4USx5xMYZXpALn3tn4twafO70FY6U4VdaRhNkzLuyDoiiGCMTebuiwpg0O/5U0mReyps8UFHGFuq1PUikO/KXpGnAOrxhrYOB7Tu11zSkUT1uAhHHAPD3FwhL09L21ybGhz4El4EoYmq1h/46qp4ENAIx3SlL6chfI+FdQLoqX3ER46KG/1D3dn4YYOamqgCeD7CoHr8F2uOSQ629YqZAjOUO6EX/OMFgtrx3IPhAOeoMw6SgW264QLzB7C56zV8SMbe/4zbFIK5NghHBJdWA6KnAvL3dajkSKlqZOzGmuBtQx7ziTgihUxRh3LdDA2AFUqqKTwLQbHSlj5JWvKle/wc9eA2gb/DfUwcvm7pgsfGBoiKDaKpGU7evoKxkG4X+8zmQUFNF8eQnLtVSnko92ziLQUmLBBQdYhx1wUXfFXopOa309XGjr95nQ9BXBiXNr0d6dpKrQomCCQcukA2CK+Z30HrXlkxIAcjIIvVC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(366004)(376002)(346002)(396003)(451199021)(2906002)(76116006)(64756008)(66446008)(66476007)(66556008)(66946007)(6916009)(316002)(4326008)(7416002)(8676002)(8936002)(5660300002)(38070700005)(41300700001)(33656002)(85182001)(86362001)(6512007)(9686003)(26005)(186003)(1076003)(122000001)(71200400001)(55236004)(38100700002)(478600001)(6486002)(966005)(83380400001)(6506007)(82960400001)(54906003)(21314003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RCtGQ3NQUGdQNjg0WXQ5M0dPdExIYnU2cmFSZllpVzhGTEhUUEZGRjhKMDlJ?=
 =?utf-8?B?dkV4cnhadXFGWEMzdGlGWnZIa3JpTDNPVTdnd1N0STBmRGNsUVJlMGtQOFpZ?=
 =?utf-8?B?aWUvNmpIRkhvRVpGU3FDZ1NXVXhSR1JxQmNzRTdLdnpPeE0vdnhYRVpXQWh1?=
 =?utf-8?B?UEtXRHNCY01EM3I3emZ2U25IOHNOWExCa3pybGU5YzVVMmJMcG9hMWVCSVFG?=
 =?utf-8?B?NkdiU1FHVEZLNUhoRW9NSFJEeVRyNWE1STgvYjVEaXRRNU9JcUZsb2Qrc0JJ?=
 =?utf-8?B?dUt4S0xkTUxtSjdIY1RaN1VoVjgyaFRTNkovbXk5dDJuK3Y2YWI3NDViMEFU?=
 =?utf-8?B?N2FrRjlnRHovSkNhb1ZKZ0xRV3ZiODNGU2ZBQjdMZ1M2b1hmSVV5TWNNaXoz?=
 =?utf-8?B?Q1YrcVlDOFE3ZW9GcEp4UG4zWjYwaE9ZbkF3RklpeS9OaGE0dE4wTHpnNmNa?=
 =?utf-8?B?THlpTDllS3g3V3JHVldjUXF5ZXFtWXpvcmFHWFJDYXZlUFdCWUlYdzJ3eUJm?=
 =?utf-8?B?Q2NyamdwaGxCZnM1VUpsSmdMQTZqQzRySncwYkFDeU5OS0lsM01YL1RCcjhi?=
 =?utf-8?B?MWRYTzhrajZIYXhUdTNLVnNRM1FyZlZyWnpwTVFvWGdOcnhueDNyQ3YvRExP?=
 =?utf-8?B?cU5VZitEaW5PTm8zN1FJQkQ4dndkdFFhSVNOUzZvNzR4ZnVwbWRTZWVHcXB5?=
 =?utf-8?B?VjRHeEJWRFNqUmNJTEhQVXBqLzVVcmt5UlkyRVN1M1BKZXFCT1dYMVhRVzFi?=
 =?utf-8?B?a1JaeHcwWFdnd0ZpSXUwVUZ0Mk1mMEJJMmRoczZ3UjREWksyaXVtWUcwdzBE?=
 =?utf-8?B?R2NoMkR1ZnZlNm9RMkQ5emY0ZmhmalB5MCtzQnBvOTg4eHVaRmMrRzVGZVJR?=
 =?utf-8?B?ZWpFZ0JUVktyT1l3cUgySHBYLzdPWmIxWE1hdmlVQnZobENuS0VsRFErTmRM?=
 =?utf-8?B?ZDJlNURVZlMyeklmMVNMNFRRZGt5ek1QWjUwbkFCcmJPVGRhd01qK285YnZz?=
 =?utf-8?B?VFQ1OGZ6M2RMRkdnalRGS3JKaG8wOWtHcUlOMWNmNjVFNUJLeG0yMmdTSHUx?=
 =?utf-8?B?a3dLRUJCbWVXUUtSNGpXMGRlenBEWEptVVZBenFaV2VHNTVMOXlxc0FPeDFo?=
 =?utf-8?B?QWlKaWFFd3JVNkVaVWRoc1dQTGxncWV2SkFmeWFHOUd3TCtXREVJZCtya3Yw?=
 =?utf-8?B?ZmQxQm41elB5L1VXVWlGeGQ4dVU5NytWZVRhZmxnRHRYelB2WDBPcFo0ZEpV?=
 =?utf-8?B?MlltOFB4U05xY2hKTVNLcHFsRFU2YXkwVDR1cE52VzhCZExXbkwwNkV0MmEw?=
 =?utf-8?B?UVpObk5uSk1hT2VnVkJDQjF0WitVTTRKejZmZWxIc3QzbjhnaHR5OVozV1Y4?=
 =?utf-8?B?UGxKamR2MFR0WXNOcEljb3dSSzdkMERMYStUVU52bWlVQnU1cWhYTFIwVDJj?=
 =?utf-8?B?SGxCNVB6ZlpqM1JWTzZNeFBPcU5pQW1pcU5BUmlsRklKVEVDS0pHeEZxNzhP?=
 =?utf-8?B?cHFSdHQ5emE4TnNwc255WTUySHk0SFhHU21IU3dTYThwN2tSL203WTIxTjZU?=
 =?utf-8?B?OVFzKzFwSjM2YUdybjRVKytTTVIvMWc2TnhTd3FWMnhXSDJLUkRuTzlnMkR6?=
 =?utf-8?B?cGFMdGZSUi9hT2JOOTZ6dm4ybVhrZDB6OVc5T0ljYTZJaXJGeXh1WE5XQUk5?=
 =?utf-8?B?eFRka3BwU2twRkpqQkpLUTVOYVVtb3dsOUFKZzZVTDJTdFB3VE9mN3pRdHJ4?=
 =?utf-8?B?V3dzUmxRVkhDZ0JSRzl4Rzdyb3dEOHdaZWx5eDNINzlIZ2NIRXQweDZCR2tz?=
 =?utf-8?B?ZlVlNlkrZ2ROcVpWbUVLQWp1Sm9HZ3JMVXcrbjVXWDdBZk9SOU1xVld1Mnp2?=
 =?utf-8?B?RG96ZXl6UnlDdUIrMG83azhiZ2FENmhQQUNjK25xdkE4dVY4TUN1UnFSRkNW?=
 =?utf-8?B?RVd0aXdpRTQzM0JHL0ZRdEt2d3l6SXVFeVJWcVNwWWFkSmxGd2xscitzRHM2?=
 =?utf-8?B?WXlEZVJTdmxHSERLcTdXWHVnMWQxZm5xYS9HWUkvTEJsZUtDUDhMUlVkOHNS?=
 =?utf-8?B?NUF6M1Vnd0JmNitrMkJwL0swc3JLVDRRNDJaQVd3WWdqRHdjTTY1VWNURE9P?=
 =?utf-8?B?SjR5RkNpWGdxZkRCSzBlZzVLc1BadEFGdUlwdFNENThSR1hRZ1VwYkFDaTU4?=
 =?utf-8?B?blE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A5615D4B204C4D4A9F820E1BC2576B5A@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b77ac2b6-83a2-4da0-1924-08db448f5a31
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2023 06:44:28.7197
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1k+rlgj+8bXFIn8VtnECCqjwcFEhrYLg0ghgtQcRjBLjpmN0HbgrqbmzQpClePBlow4871cRoPAKI7sW7z36zA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5626
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gRnJpLCBBcHIgMjEsIDIwMjMgYXQgMDE6NDM6MzlQTSArMDgwMCwgS2VmZW5nIFdhbmcgd3Jv
dGU6DQouLi4NCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gQW5vdGhlciBxdWVzdGlvbiwgb3Ro
ZXIgY29weV9tY190b19rZXJuZWwoKSBjYWxsZXJzLCBlZywNCj4gPiA+ID4gPiA+IG52ZGltbS9k
bS13cml0ZWNhY2hlL2RheCwgdGhlcmUgYXJlIG5vdCBjYWxsIG1lbW9yeV9mYWlsdXJlX3F1ZXVl
KCksDQo+ID4gPiA+ID4gPiBzaG91bGQgdGhleSBuZWVkIGEgbWVtb3J5X2ZhaWx1cmVfcXVldWUo
KSwgaWYgc28sIHdoeSBub3QgYWRkIGl0IGludG8NCj4gPiA+ID4gPiA+IGRvX21hY2hpbmVfY2hl
Y2soKSA/DQo+ID4gPiA+ID4gDQo+ID4gPiA+IA0KPiA+ID4gPiBXaGF0IEkgbWVhbiBpcyB0aGF0
IEVYX1RZUEVfREVGQVVMVF9NQ0VfU0FGRS9FWF9UWVBFX0ZBVUxUX01DRV9TQUZFDQo+ID4gPiA+
IGlzIGRlc2lnbmVkIHRvIGlkZW50aWZ5IGZpeHVwcyB3aGljaCBhbGxvdyBpbiBrZXJuZWwgI01D
IHJlY292ZXJ5LA0KPiA+ID4gPiB0aGF0IGlzLCB0aGUgY2FsbGVyIG9mIGNvcHlfbWNfdG9fa2Vy
bmVsKCkgbXVzdCBrbm93IHRoZSBzb3VyY2UNCj4gPiA+ID4gaXMgYSB1c2VyIGFkZHJlc3MsIHNv
IHdlIGNvdWxkIGFkZCBhIE1DRV9JTl9LRVJORUxfQ09QWUlOIGZybw0KPiA+ID4gPiB0aGUgTUNF
X1NBRkUgdHlwZS4NCj4gPiA+IA0KPiA+ID4gQW5kIEkgdGhpbmsgd2UgbmVlZCB0aGUgZm9sbG93
aW5nIGNoYW5nZSBmb3IgTUNFX1NBRkUgY29weSB0byBzZXQNCj4gPiA+IE1DRV9JTl9LRVJORUxf
Q09QWUlOLg0KPiA+ID4gDQo+ID4gPiA+IA0KPiA+ID4gPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYv
a2VybmVsL2NwdS9tY2Uvc2V2ZXJpdHkuYw0KPiA+ID4gPiBiL2FyY2gveDg2L2tlcm5lbC9jcHUv
bWNlL3NldmVyaXR5LmMNCj4gPiA+ID4gaW5kZXggYzQ0NzcxNjJjMDdkLi42M2U5NDQ4NGM1ZDYg
MTAwNjQ0DQo+ID4gPiA+IC0tLSBhL2FyY2gveDg2L2tlcm5lbC9jcHUvbWNlL3NldmVyaXR5LmMN
Cj4gPiA+ID4gKysrIGIvYXJjaC94ODYva2VybmVsL2NwdS9tY2Uvc2V2ZXJpdHkuYw0KPiA+ID4g
PiBAQCAtMjkzLDEyICsyOTMsMTEgQEAgc3RhdGljIG5vaW5zdHIgaW50IGVycm9yX2NvbnRleHQo
c3RydWN0IG1jZSAqbSwNCj4gPiA+ID4gc3RydWN0IHB0X3JlZ3MgKnJlZ3MpDQo+ID4gPiA+ICAg
wqDCoMKgwqDCoMKgwqAgY2FzZSBFWF9UWVBFX0NPUFk6DQo+ID4gPiA+ICAgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGlmICghY29weV91c2VyKQ0KPiA+ID4gPiAgIMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIElOX0tFUk5FTDsNCj4g
PiA+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbS0+a2ZsYWdzIHw9IE1DRV9JTl9L
RVJORUxfQ09QWUlOOw0KPiA+IA0KPiA+IFRoaXMgY2hhbmdlIHNlZW1zIHRvIG5vdCByZWxhdGVk
IHRvIHdoYXQgeW91IHRyeSB0byBmaXguDQo+ID4gQ291bGQgdGhpcyBicmVhayBzb21lIG90aGVy
IHdvcmtsb2FkcyBsaWtlIGNvcHlpbmcgZnJvbSB1c2VyIGFkZHJlc3M/DQo+ID4gDQo+IA0KPiBZ
ZXMsIHRoaXMgbW92ZSBNQ0VfSU5fS0VSTkVMX0NPUFlJTiBzZXQgaW50byBuZXh0IGNhc2UsIGJv
dGggQ09QWSBhbmQNCj4gTUNFX1NBRkUgdHlwZSB3aWxsIHNldCBNQ0VfSU5fS0VSTkVMX0NPUFlJ
TiwgZm9yIEVYX1RZUEVfQ09QWSwgd2UgZG9uJ3QNCj4gYnJlYWsgaXQuDQo+IA0KPiANCj4gPiA+
ID4gICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZmFsbHRocm91Z2g7DQoNClNvcnJ5
LCBJIG92ZXJsb29rZWQgdGhpcyBmYWxsdGhyb3VnaC4gU28gdGhpcyBjaGFuZ2UgaXMgZmluZSB0
byBtZS4NCg0KPiA+ID4gPiANCj4gPiA+ID4gICDCoMKgwqDCoMKgwqDCoCBjYXNlIEVYX1RZUEVf
RkFVTFRfTUNFX1NBRkU6DQo+ID4gPiA+ICAgwqDCoMKgwqDCoMKgwqAgY2FzZSBFWF9UWVBFX0RF
RkFVTFRfTUNFX1NBRkU6DQo+ID4gPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG0t
PmtmbGFncyB8PSBNQ0VfSU5fS0VSTkVMX1JFQ09WOw0KPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBtLT5rZmxhZ3MgfD0gTUNFX0lOX0tFUk5FTF9SRUNPViB8IE1DRV9JTl9L
RVJORUxfQ09QWUlOOw0KPiA+ID4gPiAgIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBy
ZXR1cm4gSU5fS0VSTkVMX1JFQ09WOw0KPiA+ID4gPiANCj4gPiA+ID4gICDCoMKgwqDCoMKgwqDC
oCBkZWZhdWx0Og0KPiA+ID4gPiANCj4gPiA+ID4gdGhlbiB3ZSBjb3VsZCBkcm9wIG1lbW9yeV9m
YWlsdXJlX3F1ZXVlKHBmbiwgZmxhZ3MpIGZyb20gY293L2tzbSBjb3B5LA0KPiA+ID4gPiBvciBl
dmVyeSBNYWNoaW5lIENoZWNrIHNhZmUgbWVtb3J5IGNvcHkgd2lsbCBuZWVkIGEgbWVtb3J5X2Zh
aWx1cmVfeHgoKQ0KPiA+ID4gPiBjYWxsLg0KPiA+ID4gDQo+ID4gPiB3aGljaCBoZWxwIHVzZSB0
byBraWxsIHVubmVlZGVkIG1lbW9yeV9mYWlsdXJlX3F1ZXVlKCkgY2FsbCwgYW55IGNvbW1lbnRz
Pw0KPiA+IA0KPiA+IEknbSBub3QgMTAwJSBzdXJlIHRoYXQgd2UgY2FuIHNhZmVseSB1c2UgcXVl
dWVfdGFza193b3JrKCkgaW5zdGVhZCBvZg0KPiA+IG1lbW9yeV9mYWlsdXJlX3F1ZXVlKCkgKGR1
ZSB0byB0aGUgZGlmZmVyZW5jZSBiZXR3ZWVuIHdvcmtxdWV1ZSBhbmQgdGFzaw0KPiA+IHdvcmss
IHdoaWNoIHNob3VsZCBiZSByZWNlbnRseSBkaXNjdXNzZWQgaW4gdGhyZWFkIFsxXSkuICBTbyBJ
IHByZWZlciB0bw0KPiA+IGtlZXAgdGhlIGFwcHJvYWNoIG9mIG1lbW9yeV9mYWlsdXJlX3F1ZXVl
KCkgdG8ga2VlcCB0aGUgaW1wYWN0IG1pbmltdW0uDQo+ID4gDQo+IA0KPiArdG9ueSBmb3IgeDg2
IG1jZQ0KPiANCj4gVGhlIHg4NiBjYWxsIHF1ZXVlX3Rhc2tfd29yaygpIGZvciBFWF9UWVBFX0NP
UFksIHNvIEVYX1RZUEVfRkFVTFRfTUNFX1NBRkUNCj4gYW5kIEVYX1RZUEVfREVGQVVMVF9NQ0Vf
U0FGRSBzaG91bGQgYmUgc2ltaWxhciB0byBFWF9UWVBFX0NPUFksDQo+IG1lbWNweV9tY194eHgg
cmV0dXJuIGJ5dGVzIG5vdCBjb3BpZWQsIGxldCB0aGUgdGFzayB0byBkZWNpZGUNCj4gd2hhdCB0
byBkbyBuZXh0LCBhbmQgY2FsbCBtZW1vcnlfZmFpbHVyZShwZm4sIDApIHRvIGlzb2xhdGUNCj4g
dGhlIHBvaXNvbmVkIHBhZ2UuDQo+IA0KPiAxKSBxdWV1ZV90YXNrX3dvcmsoKSB3aWxsIG1ha2Ug
dGhlIG1lbW9yeV9mYWlsdXJlKCkgY2FsbGVkIGJlZm9yZQ0KPiByZXR1cm4tdG8tdXNlcg0KPiAy
KSBtZW1vcnlfZmFpbHVyZV9xdWV1ZSgpIGNhbGxlZCBpbiBDT1cgd2lsbCBwdXQgdGhlIHdvcmsg
b24gYSBzcGVjaWZpYw0KPiBjcHUoY3VycmVudCB0YXNrIGlzIHJ1bm5pbmcpLCBhbmQgbWVtb3J5
X2ZhaWx1cmUoKSB3aWxsIGJlIGNhbGxlZCBpbg0KPiB0aGUgd29yay4gc2VlIG1vcmUgZnJvbSBj
b21taXQgZDMwMmMyMzk4YmEyICgibW0sIGh3cG9pc29uOiB3aGVuIGNvcHktDQo+IG9uLXdyaXRl
IGhpdHMgcG9pc29uLCB0YWtlIHBhZ2Ugb2ZmbGluZSIpLCAgIkl0IGlzIGltcG9ydGFudCwgYnV0
IG5vdA0KPiB1cmdlbnQsIHRvIG1hcmsgdGhlIHNvdXJjZSBwYWdlIGFzIGgvdyBwb2lzb25lZCBh
bmQgdW5tYXAgaXQgZnJvbSBvdGhlcg0KPiB0YXNrcy4iDQo+IA0KPiBCb3RoIG9mIHRoZW0ganVz
dCB3YW50cyB0byBpc29sYXRlIG1lbW9yeSwgdGhleSBzaG91bGRuJ3QgYWRkIGFjdGlvbiwNCj4g
dGhleSBzZXQgZmxhZz0wIGZvciBtZW1vcnlfZmFpbHVyZSgpLiBzbyBwcmVsaW1pbmFyaWx5LCB0
aGVyZSBhcmUgbm90DQo+IGRpZmZlcmVudC4NCg0KVGhhbmtzLCBzb3VuZHMgZ29vZCB0byBtZS4N
Cg0KLSBOYW95YSBIb3JpZ3VjaGkNCg0KPiANCj4gDQo+IA0KPiA+IFsxXSBodHRwczovL2xvcmUu
a2VybmVsLm9yZy9sa21sLzIwMjMwNDE3MDExNDA3LjU4MzE5LTEteHVlc2h1YWlAbGludXguYWxp
YmFiYS5jb20vVC8jdQ0KPiA+IA0KPiANCj4gVGhlIENPUFlfTUMgc3VwcG9ydCBvbiBhcm02NCBp
cyBzdGlsbCB1bmRlciByZXZpZXdbMV0sICB4dWVzaHVhaSdzIHBhdGNoDQo+IGlzIG9ubHkgdHJ5
aW5nIHRvIGZpeCB0aGUgdW5jb3JyZWN0ZWQgc2lfY29kZSBvZiBzeW5jaHJvbm91cyBleGNlcHRp
b25zDQo+IHdoZW4gbWVtb3J5IGVycm9yIG9jY3VycmVkLCBzbyBJIHRoaW5rIGl0IGlzIG5vdCBp
bnZvbHZlZCB0aGUgQ09QWV9NQy4=
