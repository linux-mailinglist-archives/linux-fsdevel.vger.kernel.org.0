Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82F34506FDA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Apr 2022 16:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241432AbiDSOOt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Apr 2022 10:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343600AbiDSOOr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Apr 2022 10:14:47 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2107.outbound.protection.outlook.com [40.107.237.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 475403982F;
        Tue, 19 Apr 2022 07:12:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=epT01J5u2NSB3hJ7m/zO+fMpsggTbGONJGzLxJO0eyXkHg8hknsvBAT8Nobbv9WhUxUuA2Xeq3guCSKQCvbK/fXpWaV0/OHkpMsSXazT7UlqCuc79CF4AQrNRkV6MIV0bLOp/8Uhc+0YcqjthnZMuKOlaQm0mfWtccwZIXSAHqNdDf+Ejmsz+q0/i1pkvsCPMHXr0Ypi3XEx6GiZlRNxcx+cMRitBZMPIAW4moUY+KDz/99Mm/GZV10m6jabQboLN8YvN8hiCuJ2/krfnEV+rr0AuYcsqfL0FpdePnXBjU4rjLCrNxI3E74Q+1qKTCKd1SdeylfcJBVOQ4jeZCYzfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=88EfXzalNS7vnTV9qCOz8pW1qmzRDqi6pCFvIgUlRCc=;
 b=X7XE5AjEl0gVFwpuRamjAtXS2oIGsaCmLzjHgCMrez4dbgehT4Rz4vGrWIpOMOiCUs+pXSTQdQVMZcdoznD+gXMxAR4YJIJjLEjKDdtC5H0EsWIsSaEYX7dOg09D/gr2Sc47IzpnkSGNxl36Qq7+bmLviRzoyPKDDdEf50DOJkhKkA6ropM/PXcK80mKz7tVbRTcUOWNlrTscstQjkUR3MUn7hx685ThT5Xf4unmc5zNHPSFIm1PqJp8HJJydadNFBc+kaDAPLeRS8ezFxqHQg0kgs7IFowHyzHndPpasmjO00BNA5jAkeGgFiBgAvpPm1BCJd7OXRnN66kurVSWsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=88EfXzalNS7vnTV9qCOz8pW1qmzRDqi6pCFvIgUlRCc=;
 b=TaxhrmO/6Uy0DIVsT+/QVjxntK0wVXSuKjEwwuCMiAg61aT89ooy5ziOylBjCWlQIeai9u2FEwdApYGenjqOPlE+8X3oszf+XOcxmuFUIy4xzAH9cBmbPhJJaGBsLMqDG1alQ4ZRS29ebrmhTamReYzgbi5rOAvDPho/g0J0tiE=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by DM6PR13MB3017.namprd13.prod.outlook.com (2603:10b6:5:192::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Tue, 19 Apr
 2022 14:11:59 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::c0b:4fda:5713:9006]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::c0b:4fda:5713:9006%7]) with mapi id 15.20.5186.013; Tue, 19 Apr 2022
 14:11:59 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "brauner@kernel.org" <brauner@kernel.org>,
        "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
CC:     "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "ntfs3@lists.linux.dev" <ntfs3@lists.linux.dev>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "chao@kernel.org" <chao@kernel.org>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "jlayton@kernel.org" <jlayton@kernel.org>
Subject: Re: [PATCH v4 4/8] NFSv3: only do posix_acl_create under
 CONFIG_NFS_V3_ACL
Thread-Topic: [PATCH v4 4/8] NFSv3: only do posix_acl_create under
 CONFIG_NFS_V3_ACL
Thread-Index: AQHYU9rkuNt4/dYxt0yZ2ARc+gLlVqz3Q7QAgAADaQA=
Date:   Tue, 19 Apr 2022 14:11:59 +0000
Message-ID: <707fc9d665b44943d4235a51450bff880248eda6.camel@hammerspace.com>
References: <1650368834-2420-1-git-send-email-xuyang2018.jy@fujitsu.com>
         <1650368834-2420-4-git-send-email-xuyang2018.jy@fujitsu.com>
         <20220419135938.flv776f36v6xb6sj@wittgenstein>
In-Reply-To: <20220419135938.flv776f36v6xb6sj@wittgenstein>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7c1862e2-589d-4da3-974a-08da220e91aa
x-ms-traffictypediagnostic: DM6PR13MB3017:EE_
x-microsoft-antispam-prvs: <DM6PR13MB3017756B31036152242D7D19B8F29@DM6PR13MB3017.namprd13.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +J7Vk/2Xb+ykUesD1p9qyZss+KTELKIgPS3n1uydEP1ovSKhQpcmJ0sBS7ZkU6wafqc53banhKCtOSbABCmneJttJeHRY1lt1fjg88Dy+uVPAExJpdozu8VXuIt1tj9r1ckfhDxC67GrCDv6LwZiZFam506od9ZlPBb/dve0QqYbhmwM++ozJbE4F0pwqzDv5ACR6FmHayaS3+HwkNSCg2LEUyySzBPTrC+KAjNdAsqKgu4f4TpfEfq94Dv8ZIt/tduNzRW3hRFTqAI2ygEAdHbtFZaRkBuCUzFSAKIiG/w/qAKvTLGuvlhdxwFFe/I9naNhg8R3caF48uPb2/nrLjRVyo2hvq/qqOlOmdjdTWMmQOHPtDKV3Qy/zDDpf2/jRFyQFPd6cg+2vUJg+JAW5YFlM1Akx7gjbdti/pdttvN/LM8S9tA05A1u0zSQOG6i2AKyroQPPhUPmAbVFfk1Bxt8Zd8iZT6q+m5eC0wJ9KvNM+EMW2jJUPKL2A0CzYk8wwkUWe1VZB0G7ZfZUEaodAp2eVHuhHQvLL8ylpi+2Sks5fR9xEIHGzFy5IdICYKWPBIaRAVGIF++FyoT/pfs6n40KWN/uqjk365EvWwS+frM6JdzoCYYogD3jMNUAAVKWj/7ppAButVpaT+gKURWiX2V2RaCviXy4nZbeWSo3gelI5kjdreMcZPRKCelA+Peq7X+BV3WrMvKE8Pf8DejKw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66556008)(66476007)(66446008)(64756008)(66946007)(4326008)(8676002)(76116006)(110136005)(6506007)(71200400001)(6486002)(2616005)(54906003)(508600001)(86362001)(36756003)(316002)(26005)(38070700005)(38100700002)(7416002)(5660300002)(8936002)(6512007)(186003)(122000001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UzBhOXhTR3RDczlSc21Va25HUnZGZ1ZWK3gvWkVYZmMxMjk4T2I2aXJFQ0N4?=
 =?utf-8?B?VnNUL05NMWl6OFU1V2QzR2RoQllxVWFjZVdOajNKd0E2eGtMRHk5bCtibStR?=
 =?utf-8?B?TUJmQlduUk42U09VcFJxRjdOWmFWam5jWUpZazFPeFM2U1g0Zkt2VHUyYloz?=
 =?utf-8?B?L1FHK1J3T0Vab1A4YzRpYy94QWRZSFluT0RIQmZlL2ZsTzJUaUk0aUJIT3dU?=
 =?utf-8?B?ZkZlYitZRkFMTSs3TkZOdmVTaEkwRXBSVWhVNWhVcmpmWHVqWTF5V1BQaTJS?=
 =?utf-8?B?R0lyaDJEeWFaeVJVRG1vNW1rdXljSUJwaEJqVDdXMDlOQUIwNnZudHc1a0FY?=
 =?utf-8?B?b1ZkeUVHTWtqNjRiT3kxUmhKdmltcmxkTTNteDFVR0E1dmVQbU1oaTdDVlZu?=
 =?utf-8?B?eTZTNXk3QmhEMTdNMnJFRnE3MEc2LzJ0TUNaTmFkU0RETWFXODJqckVaKzJL?=
 =?utf-8?B?eUtlY2Vrb3RqU3llRDZwM1FmNm02M3VCRW1uMHBCakZORHA1TW9aWWU4Wk1j?=
 =?utf-8?B?a21wZFdCYVd6dVBuUkk4eEY4Z3AzUkFmWjNXZVVuKzJ3RGlma0RLbktmODRF?=
 =?utf-8?B?TmN5K1FydzVzTzYyalVaeWp0NFkyeGRDOFBROTNDWm1KYmpCWnErYUhDN1hM?=
 =?utf-8?B?S0lYUVJxV05CZVhJQlc5aHdKSE1Cd2ZmeTdoU3lQbFErRWJiWVRhc1o0ZGNK?=
 =?utf-8?B?QWhHL3NQY3dqYTBDWkNrakNpTVR1WThUNTRoNE5abnIxb1lIcFJTZEdCS2hy?=
 =?utf-8?B?Sy92MEtRRVNva1YvekNyMUp3M0xjM1lyWHdJNlZNNGppTlJDT1daazBhdGxo?=
 =?utf-8?B?ejc5WUpKclVXVUJsMGRXWEtGK0g1Y3BnU29uSzl3d2VXN0NIendZZDVNQ0Q4?=
 =?utf-8?B?YTQzV0FCWm5HM1N2SVJJaHJDVmVQOUN2djRISE1TVGlLc1JkMUhieHQ4Z3Jw?=
 =?utf-8?B?cGR3VXdEV3YxQkh4TTA2d0x0OUtJOGRDMEdzN3BQNDY5S056Z1VHaVh2SEV2?=
 =?utf-8?B?SEZISlFocXkveGFsK010dHBzNERrVXZmRUluQXRhZmdrTUFxUEZqbzRmdHN6?=
 =?utf-8?B?ZWtpQWNGNGdlVS9nZm0va3hRUkl4OUFaeVpZdmEyZVg4a1VtNU15SUFZRkFP?=
 =?utf-8?B?d1lZd0R2c1MySGdyWXczdGRtMUduTG8wZ1JzOCtxOHE3bms1Qk9VV3NNb0tV?=
 =?utf-8?B?ZGE0alFDQTN3ajlpTXN0QzRYQUNna2dzRTF0MnIvOWRFSmdqNld3Q2tZNytt?=
 =?utf-8?B?WEsvcUhQOXI0dlVGWDNuN05rUnl6VUZtREt0c1hlb3VxRlRMSW9mZ3pNWmh2?=
 =?utf-8?B?TzM3WitIUzlyUjQ1VTlnVU4rM2ZzQ1ZSQ1JpeFJyMndzekdXTHl1bEZ6cTZS?=
 =?utf-8?B?azE1dDhPZ0NZQ2RPc1dyZUVsTjl6NXpObnhRcUtBNW9SeEVwY3lmQU9weU1D?=
 =?utf-8?B?VTFiMzJJRHFzVXE5V09ZTXNJcXA1NnlvZTRiZkk0eXI2bGZCWUpab1lVZkEr?=
 =?utf-8?B?Zy94eW1JZEZqaTNXdTJxbityL3BjckhyS0hwVVplOXpwV0FyeXBaekp3Q2ZY?=
 =?utf-8?B?eGMwb3U4VkduRFVmMHN0d2ZqWSsxZU1paUlCTWxYRjJ6NUpOVEVyY3dWK2Zu?=
 =?utf-8?B?bXIxL1cyZ3RkOWV1L3BCbEova29rVkNDM21lUFBxSG1lS1VidHAreForZ2tn?=
 =?utf-8?B?ZGRaVUVvZTVRVjRwTFREc0pzaUZteHIyU3g1dHYvemMrdm9NWUlCa1FGWXk3?=
 =?utf-8?B?akhtQnJNcXZUL0hBMy95emo5SElDRThsQmloM1NWNldOZzBqc1NKam4rdU5S?=
 =?utf-8?B?V1daTFlvNGpEZGxKd2ljUVNudEVjOWtYSHczbzdwaXNQcExXNU5XR2ZKeFF6?=
 =?utf-8?B?UVdNbDVhS1EycGRTTllDNnVETWJsb3RPQWxsRlQ4RTJhNVV1cm1IUkxZODd5?=
 =?utf-8?B?bTlXcGtWNDlqQTJmT3BValFxdGVyaGhtUGlUdG1YK0I1bXlES2RkdU02c2FC?=
 =?utf-8?B?UHRKR3NMWTg5RnhoQU5mQTBWUkZ3bzh0L2hyVGF5a1h5US9FNVBITXhCZ2F0?=
 =?utf-8?B?Z3RJOXM1YkRVVnhPOGVkNkRoeHF4QUR6U2NQQlFUT0JmMUxHZ0lUbm84ZGFh?=
 =?utf-8?B?WGx6dFpuU1RqQUczbWdYWlNHU240d2U1V3JRd3RESUhjUGhyeFZKc2lOdjEr?=
 =?utf-8?B?Zkt3V0taUXQzdUYzZVY4VnFEWHkrUjBFam1BT2ZFelRaV1ZLbDZaN1kwSDg4?=
 =?utf-8?B?NFF5SEtsQUF2VHJKcXlmTVhzM2RRL3o2eXMvMlNJZEkzN3A1SlNYaUlNRmxm?=
 =?utf-8?B?Z01HR2pTVXhzWEtIRldMVDg3a3BKL1FoenFHakltQkpxZDZCb0hJWnI5SmxV?=
 =?utf-8?Q?rZVdoPhJEQ/F8aJ0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E127A97A75E7FE4B91198A0053345E07@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c1862e2-589d-4da3-974a-08da220e91aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2022 14:11:59.4640
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FkrJaHtDRrHg0lpj9pzqM2vo8h7SMU+/qpd2PqmjKCCA80XOpcAZCJvnAB5alRZzAud/YIZ/gpNUWtwELtscBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB3017
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gVHVlLCAyMDIyLTA0LTE5IGF0IDE1OjU5ICswMjAwLCBDaHJpc3RpYW4gQnJhdW5lciB3cm90
ZToNCj4gT24gVHVlLCBBcHIgMTksIDIwMjIgYXQgMDc6NDc6MTBQTSArMDgwMCwgWWFuZyBYdSB3
cm90ZToNCj4gPiBTaW5jZSBuZnMzX3Byb2NfY3JlYXRlL25mczNfcHJvY19ta2Rpci9uZnMzX3By
b2NfbWtub2QgdGhlc2UgcnBjDQo+ID4gb3BzIGFyZSBjYWxsZWQNCj4gPiBieSBuZnNfY3JlYXRl
L25mc19ta2Rpci9uZnNfbWtkaXIgdGhlc2UgaW5vZGUgb3BzLCBzbyB0aGV5IGFyZSBhbGwNCj4g
PiBpbiBjb250cm9sIG9mDQo+ID4gdmZzLg0KPiA+IA0KPiA+IG5mczNfcHJvY19zZXRhY2xzIGRv
ZXMgbm90aGluZyBpbiB0aGUgIUNPTkZJR19ORlNfVjNfQUNMIGNhc2UsIHNvDQo+ID4gd2UgcHV0
DQo+ID4gcG9zaXhfYWNsX2NyZWF0ZSB1bmRlciBDT05GSUdfTkZTX1YzX0FDTCBhbmQgaXQgYWxz
byBkb2Vzbid0IGFmZmVjdA0KPiA+IHNhdHRyLT5pYV9tb2RlIHZhbHVlIGJlY2F1c2UgdmZzIGhh
cyBkaWQgdW1hc2sgc3RyaXAuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogWWFuZyBYdSA8eHV5
YW5nMjAxOC5qeUBmdWppdHN1LmNvbT4NCj4gPiAtLS0NCj4gDQo+IEkgaGF2ZSB0aGUgc2FtZSBj
b21tZW50IGFzIG9uIHRoZSB4ZnMgcGF0Y2guIElmIHRoZSBmaWxlc3lzdGVtIGhhcw0KPiBvcHRl
ZA0KPiBvdXQgb2YgYWNscyBhbmQgU0JfUE9TSVhBQ0wgaXNuJ3Qgc2V0IGluIHNiLT5zX2ZsYWdz
IHRoZW4NCj4gcG9zaXhfYWNsX2NyZWF0ZSgpIGlzIGEgbm9wLiBXaHkgYm90aGVyIHBsYWNpbmcg
aXQgdW5kZXIgYW4gaWZkZWY/DQo+IA0KPiBJdCBhZGRzIHZpc3VhbCBub2lzZSBhbmQgaXQgaW1w
bGllcyB0aGF0IHBvc2l4X2FjbF9jcmVhdGUoKSBhY3R1YWxseQ0KPiBkb2VzIHNvbWV0aGluZyBl
dmVuIGlmIHRoZSBmaWxlc3lzdGVtIGRvZXNuJ3Qgc3VwcG9ydCBwb3NpeCBhY2xzLg0KPiANCg0K
QWdyZWVkIGFuZCBOQUNLZWQuLi4NCg0KQW55IHBhdGNoIHRoYXQgZ3JhdHVpdG91c2x5IGFkZHMg
I2lmZGVmcyBpbiBzaXR1YXRpb25zIHdoZXJlIGNsZWFuZXINCmFsdGVybmF0aXZlcyBleGlzdCBp
cyBub3QgZ29pbmcgZ29pbmcgdG8gYmUgYXBwbGllZCBieSB0aGUgTkZTDQptYWludGFpbmVycy4N
Cg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFt
bWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
