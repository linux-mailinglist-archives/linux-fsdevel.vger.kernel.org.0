Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3B865A66BD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Aug 2022 16:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbiH3O6n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Aug 2022 10:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbiH3O6d (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Aug 2022 10:58:33 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2106.outbound.protection.outlook.com [40.107.96.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3660B81D0;
        Tue, 30 Aug 2022 07:58:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hPKf5CLZ/lS2AOngzjdI50MoWbWT84cqOIG7QM0XxsPFykv5phunf5pVnFJtajVz1bMfiNkD2KKmyM14chH1M7ZUEx4jc7FcRBjHHekfHeFFwOwOvYhcfmSPjWAtdPlRiDPZ1sg8FKfdCG0Z81DWgHgcbsHrCzrVsARLJFIe+S+d+et33vGkMkjQP2XV/yv7ulII787qR9c5xDVFJ0eUEodSX9WKpYC/vr4fUYfkb6MPQrhSfDW0Hoj5mPWlPWxby4GTnRgF1DsljelzAX2Y+irJ30MqxW7ua1V2ku1OAsYewKj9T5+9P4c+WTKi0sivgYjKzZ4t8sP+09RDkyB1jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fleS/7NmXBRTUobGYsChLUP90B1QMxtqUuo8xslh6UI=;
 b=fkeHsyahBnN39T8dKIa61TDqMgIGakQfIGTdR1S/xOsZIOocG8r4b69ft3ZrnToMYJSfe0aEkQd5CS4+iR2B7X2Kj0PWNy69WEZeZIKNrG3BgkE8XBq3hJ1i4SYeRzztqEFx0oOs1aSIPLBD0bP+iPhAcKx1hD7ll+q5gNcN27kc+zkJ6ksqK7LN2sy3sjMqVtz6MsUFp/0TB+2BtaScGLArR9LDW7nyTxE0uzBCqifL27HnxMpPtOCTlCS1s5sH/3+M7pXn2DkNDHXoEXTYOif0dOmCHN3C0fUzBENmBQnbTBZAzvU2nIwPYFwXSu+/txIMZcnhHw8RZ+asrha8hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fleS/7NmXBRTUobGYsChLUP90B1QMxtqUuo8xslh6UI=;
 b=M+LhSUeG7BfInytkQc+kyHA6s66zgmDCPGR3JuLX0FVEGvpktyLRFeI0JOPJ/yV08USnqk+4kPWyqf8O7QeFYViNomWlhT+dZQYK+cze/dmkIp9nDnf3hIbqA290ydxLwLHSPaNqEHSDQruKNe1p1PhyaQze39dh7PWMUWHuCt0=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by DM5PR13MB1482.namprd13.prod.outlook.com (2603:10b6:3:124::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Tue, 30 Aug
 2022 14:58:27 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::f1c7:62d0:a63d:f5ca]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::f1c7:62d0:a63d:f5ca%3]) with mapi id 15.20.5588.010; Tue, 30 Aug 2022
 14:58:27 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bfields@fieldses.org" <bfields@fieldses.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>
CC:     "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "xiubli@redhat.com" <xiubli@redhat.com>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "neilb@suse.de" <neilb@suse.de>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
        "linux-ceph@vger.kernel.org" <linux-ceph@vger.kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "tytso@mit.edu" <tytso@mit.edu>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "jack@suse.cz" <jack@suse.cz>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "lczerner@redhat.com" <lczerner@redhat.com>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "walters@verbum.org" <walters@verbum.org>
Subject: Re: [PATCH v3 1/7] iversion: update comments with info about atime
 updates
Thread-Topic: [PATCH v3 1/7] iversion: update comments with info about atime
 updates
Thread-Index: AQHYuZVnsRGFuLc+aUSHryeVbtc1Ya3FhqCAgAAtUwCAAM6GgIAA1NcAgAAdQICAAAcSAIAADzgAgAAD2QA=
Date:   Tue, 30 Aug 2022 14:58:27 +0000
Message-ID: <e4815337177c74a9928098940dfdcb371017a40c.camel@hammerspace.com>
References: <20220826214703.134870-1-jlayton@kernel.org>
         <20220826214703.134870-2-jlayton@kernel.org>
         <20220829075651.GS3600936@dread.disaster.area>
         <549776abfaddcc936c6de7800b6d8249d97d9f28.camel@kernel.org>
         <166181389550.27490.8200873228292034867@noble.neil.brown.name>
         <f5c42c0d87dfa45188c2109ccf9baeb7a42aa27e.camel@kernel.org>
         <20220830132443.GA26330@fieldses.org>
         <a07686e7e1d1ef15720194be2abe5681f6a6c78e.camel@kernel.org>
         <20220830144430.GD26330@fieldses.org>
In-Reply-To: <20220830144430.GD26330@fieldses.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ecbb62d8-83ed-4f31-0943-08da8a981876
x-ms-traffictypediagnostic: DM5PR13MB1482:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K4FgKGEnzWIkpfs0YbQ60gEPuLV0W3pTZD311k16DpM8uKuWhtm3gG9BAhTHO4PH3XLsdprHWM9u3Ge1KuTe0OXXdXCw+DBDfGqXU4Y+dn9ejQF3wiRFr1+DwqaWvIVjc91ia/3qJmm2EwHxUBF51ibQp0on++TNVzWbNcfzQc16jL8q7bcQ8K3zSo2L88WFIYJi6nYDT7ysC8aVGcoMdhHPpkllHgxOyv03UQRWH5Q1u3CWfBON3YyXcvEZmKVDaOe0pmFuuCgcrvB8mBzhsLb53jIzluktNj1S5+4pqVNHffz9hqwIlmQ5AmcoyAzq9nuPx6TL5b+JmMgcybKDRCBxkXT42M6woAYrHnC0/jhvmpz+cf1UNYziO5YdsKX5DI/68iMMPuZCIJL4bL8FEewKAVkdeHz46MCKyQGDxxAdGn31afzu6gGjAbsoytdS9apiKtYpxX5g4VVr19pzn6iQ31ryDQ+cpVNqcSZRQS2r5kimN2wekPfe5JsDi7gnkRJgw+TpgtSrYyeyzI3//wqRM7gTOkdzPpaY61rVbo0qG4PPOyrv1curV5mBPYG9dUpY2S5YOayzP8oR8viDHnCrNaE5YHE1U6DZw3tYgYovWN40drHae877ToEQvQocV50w0IHT8yO8j8WCH/f2Yq8BspkzukzLuO3SgMLhqnOtin4KDF0qGHd/1aETSLu9/jr8l5udbb0aekv33CXbYGUsrRo8gvYxHtKMX19nQeTQSZbTUvYhgk8BmNwDC/ChdzWvDn/KI7h2tCq7b0Zpwg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(39830400003)(366004)(396003)(136003)(5660300002)(83380400001)(7416002)(41300700001)(8936002)(186003)(2616005)(15650500001)(6506007)(2906002)(26005)(86362001)(6512007)(122000001)(36756003)(110136005)(316002)(71200400001)(54906003)(478600001)(38100700002)(64756008)(38070700005)(4326008)(66476007)(66556008)(76116006)(66946007)(6486002)(66446008)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QlgvVXFneVF3b2RqNUR6dlFwM0ZtWDl5aVZJcEJ6bkhCMFZQOG9BV3pVQXZi?=
 =?utf-8?B?K2dtRW1FRTVBSlBhekdNS3czTDZmNkZLaUJ1MnRlWlBEZkRjblRXSTE1WnN5?=
 =?utf-8?B?dGVYQytiejEzV0pxaXJXTVJWcTRUL0hvTlhMSmxWYWlTT0FFVS9iWllwVGl5?=
 =?utf-8?B?dkxJYTUwRzZMU1dveURQNVZQdlJxMkZTQjRlVnhpNFhoRGZuUWN0ZTZqemJ4?=
 =?utf-8?B?dmZnMzFaMExzaE0vMm1tdldONlhQb0JNMFBOa2lSUlUyaWlpM2JNSWN0NTh2?=
 =?utf-8?B?VGtSSFBta3hzYVYvWHRtci9STzQ1WVRiS1NUTXlYeXVTdHFsS09kbGhoeVBH?=
 =?utf-8?B?eWYyT2NmS3k2UlJSUHl5OG1hQTBpOGNWQWNNc1JPMGZlYzNXVUNvZWxqM1hB?=
 =?utf-8?B?OEhYTjhnV3NoMUpFWnBscExaYnBhbFhhQS9HQmE3eFJlRXE5U1NZc3VIVld2?=
 =?utf-8?B?aVo4K2F2YndGd1pFbG1vOVVEd1A0d0RhVzJYUjBxSFBiQnFEdjlBVDFrbk9C?=
 =?utf-8?B?RW9CaitLOGpRSU1xUCtTM2FYbEd5VmxGMkdhL3BUL3I1RTNXeWxaQjNSWFcy?=
 =?utf-8?B?eTF3V0diVHkwZHlaaGhWSmFSNk5lZko1VlVsUVF4ZDZLS2E0enBLTiszakpI?=
 =?utf-8?B?NDgwZWNXN3krVi9RY2pIWDQzREFCenlEanZEV0FxUk9wamdZUFMvRHBOS2M4?=
 =?utf-8?B?MEIzQnVzSW10TXhINHp1dmZWaUhRTDdmUjN2YnJQNkxVUnZmUEZKbHNSSWR4?=
 =?utf-8?B?a1dtNVFlWWxaa2xpSEJlbGRVRU5RWHh3YUg4UEdMZzhwQ1psLy9rQUtNeTls?=
 =?utf-8?B?NTBuTk1ObEVVRXlxYWpMd29aM0U1ZkhTWDA5Z3NMZXpzT2xuVCtRT3REY3NQ?=
 =?utf-8?B?K214bkN0UHRnQU9FUDdzVkdnQzBSVGJuNnZtQythaGVjN3F1aUJGTWxZUW9Z?=
 =?utf-8?B?aFlXVWVFck04ZE44OGgrMDZTenowL0xVWHVEQTlkTzdaUUk4MnM4SjRaWTVT?=
 =?utf-8?B?OXBFVTh1UVdPWkxRM21BZnVnd0ZBdHlyQmJOY21GTHVXcGtRUXhENEVodmhq?=
 =?utf-8?B?ZTdOUmVmZUlFcnJRZUlRMDRtaXh3YmpxN09OT3gxM3lqOU5QTFRsbVJKQlhx?=
 =?utf-8?B?NDJESHZFektIeXFVWWlCK0JxcVErdkhQVFhOY1hYaUhOUmhTZ2RqTFIxLzND?=
 =?utf-8?B?cllUOC9BOU10TDlvWXhnajI3cWQ1U05TTVBmdEVJZ0g0K0VFQTVmQ1BFSTZJ?=
 =?utf-8?B?bGx5K1l6MmRJcHN3ZHFxVXg0eE9qSVMxL2o0c1FXVTlNWFF0YStqSE1xanBm?=
 =?utf-8?B?SE52NU5xT1dKMWVUT3JKZ0FOcXVNKys3Y2orZS9oaG5jLy9SMjZwdXVyeHdP?=
 =?utf-8?B?U25KUXNLU3FYMGJLWkFoQmVYTXJRMkNmTWNJaGw5UThlQ1Y4NjQ2TTZVeGdZ?=
 =?utf-8?B?Q2NaelF4bi9JeDRVT2lLNys5cXZjTUtWbTF3NzN1RnJSd1g4OTdleUlTcCtu?=
 =?utf-8?B?ekNDa21RUTVpNlI0Mjh4V2JJcEV2UnFTTHVPUnNDa2NUdzNGeERmSzl6Nmhj?=
 =?utf-8?B?YmU1M3ZNRUlmempCMSszc1ZQbTI4WHdPQkhwUzU0UnlQYzNHbE5hSEtwMW04?=
 =?utf-8?B?R0MrbjIxMzRoa01HYktYRUVUeXV0NmFjekVyMmM5R2RBZC9TOTRHRVJTR1NU?=
 =?utf-8?B?YmxWSlZlRWpjdTB0Q3JUbWdpQTdJZFk5YnlreDgrcFBxaGlwU0s1MmdUeXZ6?=
 =?utf-8?B?dFNINUo3bE1DWVlYUEpzTE9kak0ycUZDWVdwRXJjMXJiakNNMGF6OE5MbFB0?=
 =?utf-8?B?alNXUVVHd0d0YWpMbGtIakhtdVVvamdraUUvQ3lZSE1PN1gyY3lJaytuRWxm?=
 =?utf-8?B?YUlYWEZlbUowSlRCdE4veGZHS2JrUkxoNjVocXpHMFQ0Z2VlWWlhZjcvMTdi?=
 =?utf-8?B?MHFZZXM3SzlxUEExNjRQTWNLWk90c3BrdytOTExqYmpVZ2taRzYwT0YvVVZ5?=
 =?utf-8?B?d2tQS2pTb3k3MGRTTlRGaDhLY2pUTnpNbFZHM2xmeTdlRU4xMU4wZUhVWlNa?=
 =?utf-8?B?YjNmUks0VmMvODBKZDZsS1FjbnJhaXl4dkpzdWlJMGRtZ0Fzei91blRiQkl6?=
 =?utf-8?B?d1l6WkNJWThuQkN1cmxFMVQvc3BNWC9rWWgzVEdadS83RmxtdHhpS241NXU5?=
 =?utf-8?B?TkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <46CCAAB9446A2341AC9F2FC8B94FCC0E@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecbb62d8-83ed-4f31-0943-08da8a981876
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2022 14:58:27.5928
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G2P/nHWTuZvOsJ32AgK5PQwbK+bsdWsl5gtdnjGs0pLR/B1TozeieTjMMjND3YDCqReou3Qr0KMbvDBTM9iR5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB1482
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gVHVlLCAyMDIyLTA4LTMwIGF0IDEwOjQ0IC0wNDAwLCBKLiBCcnVjZSBGaWVsZHMgd3JvdGU6
DQo+IE9uIFR1ZSwgQXVnIDMwLCAyMDIyIGF0IDA5OjUwOjAyQU0gLTA0MDAsIEplZmYgTGF5dG9u
IHdyb3RlOg0KPiA+IE9uIFR1ZSwgMjAyMi0wOC0zMCBhdCAwOToyNCAtMDQwMCwgSi4gQnJ1Y2Ug
RmllbGRzIHdyb3RlOg0KPiA+ID4gT24gVHVlLCBBdWcgMzAsIDIwMjIgYXQgMDc6NDA6MDJBTSAt
MDQwMCwgSmVmZiBMYXl0b24gd3JvdGU6DQo+ID4gPiA+IFllcywgc2F5aW5nIG9ubHkgdGhhdCBp
dCBtdXN0IGJlIGRpZmZlcmVudCBpcyBpbnRlbnRpb25hbC4gV2hhdA0KPiA+ID4gPiB3ZQ0KPiA+
ID4gPiByZWFsbHkgd2FudCBpcyBmb3IgY29uc3VtZXJzIHRvIHRyZWF0IHRoaXMgYXMgYW4gb3Bh
cXVlIHZhbHVlDQo+ID4gPiA+IGZvciB0aGUNCj4gPiA+ID4gbW9zdCBwYXJ0IFsxXS4gVGhlcmVm
b3JlIGFuIGltcGxlbWVudGF0aW9uIGJhc2VkIG9uIGhhc2hpbmcNCj4gPiA+ID4gd291bGQNCj4g
PiA+ID4gY29uZm9ybSB0byB0aGUgc3BlYywgSSdkIHRoaW5rLCBhcyBsb25nIGFzIGFsbCBvZiB0
aGUgcmVsZXZhbnQNCj4gPiA+ID4gaW5mbyBpcw0KPiA+ID4gPiBwYXJ0IG9mIHRoZSBoYXNoLg0K
PiA+ID4gDQo+ID4gPiBJdCdkIGNvbmZvcm0sIGJ1dCBpdCBtaWdodCBub3QgYmUgYXMgdXNlZnVs
IGFzIGFuIGluY3JlYXNpbmcNCj4gPiA+IHZhbHVlLg0KPiA+ID4gDQo+ID4gPiBFLmcuIGEgY2xp
ZW50IGNhbiB1c2UgdGhhdCB0byB3b3JrIG91dCB3aGljaCBvZiBhIHNlcmllcyBvZg0KPiA+ID4g
cmVvcmRlcmVkDQo+ID4gPiB3cml0ZSByZXBsaWVzIGlzIHRoZSBtb3N0IHJlY2VudCwgYW5kIEkg
c2VlbSB0byByZWNhbGwgdGhhdCBjYW4NCj4gPiA+IHByZXZlbnQNCj4gPiA+IHVubmVjZXNzYXJ5
IGludmFsaWRhdGlvbnMgaW4gc29tZSBjYXNlcy4NCj4gPiA+IA0KPiA+IA0KPiA+IFRoYXQncyBh
IGdvb2QgcG9pbnQ7IHRoZSBsaW51eCBjbGllbnQgZG9lcyB0aGlzLiBUaGF0IHNhaWQsIE5GU3Y0
DQo+ID4gaGFzIGENCj4gPiB3YXkgZm9yIHRoZSBzZXJ2ZXIgdG8gYWR2ZXJ0aXNlIGl0cyBjaGFu
Z2UgYXR0cmlidXRlIGJlaGF2aW9yIFsxXQ0KPiA+ICh0aG91Z2ggbmZzZCBoYXNuJ3QgaW1wbGVt
ZW50ZWQgdGhpcyB5ZXQpLg0KPiANCj4gSXQgd2FzIGltcGxlbWVudGVkIGFuZCByZXZlcnRlZC7C
oCBUaGUgaXNzdWUgd2FzIHRoYXQgSSB0aG91Z2h0IG5mc2QNCj4gc2hvdWxkIG1peCBpbiB0aGUg
Y3RpbWUgdG8gcHJldmVudCB0aGUgY2hhbmdlIGF0dHJpYnV0ZSBnb2luZw0KPiBiYWNrd2FyZHMN
Cj4gb24gcmVib290IChzZWUgZnMvbmZzZC9uZnNmaC5oOm5mc2Q0X2NoYW5nZV9hdHRyaWJ1dGUo
KSksIGJ1dCBUcm9uZA0KPiB3YXMNCj4gY29uY2VybmVkIGFib3V0IHRoZSBwb3NzaWJpbGl0eSBv
ZiB0aW1lIGdvaW5nIGJhY2t3YXJkcy7CoCBTZWUNCj4gMTYzMTA4N2JhODcyICJSZXZlcnQgIm5m
c2Q0OiBzdXBwb3J0IGNoYW5nZV9hdHRyX3R5cGUgYXR0cmlidXRlIiIuDQo+IFRoZXJlJ3Mgc29t
ZSBtYWlsaW5nIGxpc3QgZGlzY3Vzc2lvbiB0byB0aGF0IEknbSBub3QgdHVybmluZyB1cCByaWdo
dA0KPiBub3cuDQoNCk15IG1haW4gY29uY2VybiB3YXMgdGhhdCBzb21lIGZpbGVzeXN0ZW1zIChl
LmcuIGV4dDMpIHdlcmUgZmFpbGluZyB0bw0KcHJvdmlkZSBzdWZmaWNpZW50IHRpbWVzdGFtcCBy
ZXNvbHV0aW9uIHRvIGFjdHVhbGx5IGxhYmVsIHRoZSByZXN1bHRpbmcNCidjaGFuZ2UgYXR0cmli
dXRlJyBhcyBiZWluZyB1cGRhdGVkIG1vbm90b25pY2FsbHkuIElmIHRoZSB0aW1lIHN0YW1wDQpk
b2Vzbid0IGNoYW5nZSB3aGVuIHRoZSBmaWxlIGRhdGEgb3IgbWV0YWRhdGEgYXJlIGNoYW5nZWQs
IHRoZW4gdGhlDQpjbGllbnQgaGFzIHRvIHBlcmZvcm0gZXh0cmEgY2hlY2tzIHRvIHRyeSB0byBm
aWd1cmUgb3V0IHdoZXRoZXIgb3Igbm90DQppdHMgY2FjaGVzIGFyZSB1cCB0byBkYXRlLg0KDQo+
IA0KPiBEaWQgTkZTdjQgYWRkIGNoYW5nZV9hdHRyX3R5cGUgYmVjYXVzZSBzb21lIGltcGxlbWVu
dGF0aW9ucyBuZWVkZWQNCj4gdGhlDQo+IHVub3JkZXJlZCBjYXNlLCBvciBiZWNhdXNlIHRoZXkg
cmVhbGl6ZWQgb3JkZXJpbmcgd2FzIHVzZWZ1bCBidXQNCj4gd2FudGVkDQo+IHRvIGtlZXAgYmFj
a3dhcmRzIGNvbXBhdGliaWxpdHk/wqAgSSBkb24ndCBrbm93IHdoaWNoIGl0IHdhcy4NCg0KV2Ug
aW1wbGVtZW50ZWQgaXQgYmVjYXVzZSwgYXMgaW1wbGllZCBhYm92ZSwga25vd2xlZGdlIG9mIHdo
ZXRoZXIgb3INCm5vdCB0aGUgY2hhbmdlIGF0dHJpYnV0ZSBiZWhhdmVzIG1vbm90b25pY2FsbHks
IG9yIHN0cmljdGx5DQptb25vdG9uaWNhbGx5LCBlbmFibGVzIGEgbnVtYmVyIG9mIG9wdGltaXNh
dGlvbnMuDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWlu
ZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
