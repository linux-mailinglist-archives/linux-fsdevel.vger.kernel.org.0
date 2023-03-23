Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 078686C6612
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Mar 2023 12:04:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbjCWLER (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Mar 2023 07:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbjCWLEQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Mar 2023 07:04:16 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A839FCDCB
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Mar 2023 04:04:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FCN7793IcuIfYP5S+QgNqg3g0TtGud4pHu/VeL+MSCKIKhAe0/PZ6KMJq524wPwyFP9IOzWeZ1VXS35szK9QTc+KuPvYWlK3vTtfWJfRBnFzIToKFZJmZwki3+v8TMWJo/WB2m/t3pXBZjmrpiNAn844tFtemycOT3ICbeosE/3ARmWEU55AHbujNNQl+2raAvYpyWcX0eollq2CmIANKDEJGmffiLoaeKz5SahGyIUptK8hCzq1T07sNczlsgZch9Krb2H9FGvSkmzqqQ+uAh3vQ6CsiBiJViYxQK4n1SpjeSyJBA3uCVZvj7aKvzJI+D5MB2f/EaZC6Qzt2vp9Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WDbLKZ4UoU8oglDZfWSaxWNaG+h9yhaNGEtUz4upmxE=;
 b=P0dHeTQWpePG3pjpV7b0SvBI4pFbUG1ZhbMcs1WoXCCHLnFs+3knkzBbXcMccIVPYqJsPw8fQ8mCxjliQ/+xPmHx18h9uI5uHAkHL0agGSEgPhSELOwvXnsk15NdSiJIEDnqm3iKz8WLJ7h9VOdnwb9dQoySyiHO6vnPBOV6dzAMpnJ2zCzGwj389Y+05dMwC07lGPkCUFhoh9qqEr+GA2qQNL8y88Kmvhm4QYFd/FzG0Icc+/ZlhQ8+GD6MAD02wQq7gXNpUFX9ARiPoatlf+dVBlXRCClqtvL/SQ/qO27hYxYeEzcD0EEBF/h/xGE36ajlULkbXUBjahnPad4x3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WDbLKZ4UoU8oglDZfWSaxWNaG+h9yhaNGEtUz4upmxE=;
 b=POtB0x+X18JSxHeEqtzUC1++zE5Iv4nX3KnHyIhGitRwLzAFMH/geXPireJUb8fGFKW8eLmnoeKu0Vt87044Xr0NVPEK29L6teJPKBvkUURA5268F++iKcIxDqjMot8Ph2fqc2etTDWis9vrwJqY7HDsFOD+ID90NvxAvtmRG7g=
Received: from DM5PR1901MB2037.namprd19.prod.outlook.com (2603:10b6:4:aa::29)
 by PH0PR19MB5444.namprd19.prod.outlook.com (2603:10b6:510:fe::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.36; Thu, 23 Mar
 2023 11:04:12 +0000
Received: from DM5PR1901MB2037.namprd19.prod.outlook.com
 ([fe80::e6d4:29f7:2077:bd69]) by DM5PR1901MB2037.namprd19.prod.outlook.com
 ([fe80::e6d4:29f7:2077:bd69%4]) with mapi id 15.20.6086.024; Thu, 23 Mar 2023
 11:04:12 +0000
From:   Bernd Schubert <bschubert@ddn.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Dharmendra Singh <dsingh@ddn.com>,
        Amir Goldstein <amir73il@gmail.com>,
        "fuse-devel@lists.sourceforge.net" <fuse-devel@lists.sourceforge.net>,
        Ming Lei <ming.lei@redhat.com>,
        Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Subject: Re: [PATCH 06/13] fuse: Add an interval ring stop worker/monitor
Thread-Topic: [PATCH 06/13] fuse: Add an interval ring stop worker/monitor
Thread-Index: AQHZW5INP1WhR4AlW0WGDgYwsBdWma8ILRSAgAAKLQA=
Date:   Thu, 23 Mar 2023 11:04:12 +0000
Message-ID: <28a74cb4-57fe-0b21-8663-0668bf55d283@ddn.com>
References: <20230321011047.3425786-1-bschubert@ddn.com>
 <20230321011047.3425786-7-bschubert@ddn.com>
 <CAJfpegs6z6pvepUx=3zfAYqisumri=2N-_A-nsYHQd62AQRahA@mail.gmail.com>
In-Reply-To: <CAJfpegs6z6pvepUx=3zfAYqisumri=2N-_A-nsYHQd62AQRahA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR1901MB2037:EE_|PH0PR19MB5444:EE_
x-ms-office365-filtering-correlation-id: 745c7e5b-62f1-45a0-d0ba-08db2b8e559a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UIfsmAsWdzvHMeoNcKE3rHDdvId0VgP09UQSvtU9ImKTVmJaSsksd9oMHDIMb6VoX3tXu2GsNwtSaxMMBfDjOfKBFVrXl0PNjBkvSf45/lHepg0BvztnD+yYRgX4CfZFneUeubkwf3kLFr0i7ugockjpIoDSh2GC/ib2Q9iJMMcbA7iL3p78pKmtprXTu7rj9T8euLPKnBz6CUmq6sbVvIxF1cvmNT9+KnttoigECsyNQ0tZjCpldmc0Yz7K91PhZDG73V8qlaTstvrXppAtmDqWHP/hdgek9ItcS2lCs97W9SpRsT20Gwl/eN8NOwGf3UC0UyW+8OUqRLScRBd3xrI25A3MFFtt4Srk/nPRDb3tJzN8lFx+rmyMOofKu2G02nUD+gaKPiQDlWS2ECk4HfptWr08piWjUU6WyE41I6qajFBXvhqliozj9BicEFQPoJjDmLMayZsB9MdO7usXbIw3M3OQ63oNNVuHnoEgIsUQgWG11eqNyQnHjvzlGGDHLb+ToL0xOcf+To6oFmWuRvNE2zILqu3p/fR4ooBDRdq9QyryBhDen2KXfPq2q2Q7MBr4rWRbYaOFWeyJOk5dw2aMeWMYpCntjvKMsYjcULYb/0mBAR4mvh662/DzJq59xV4IJvTN0xl/31DvkgIIKHWL6F17tvLCv2hPtK0VXKzpDzhz6sIPuMGCq+0KLV/C9fmRt22WGN0XK89iG0quA0t0SGUvodEVO9TznyAA80X8IiTcHNn9qFZT6BfH8A7Z4l6SN5YP9++MfzpbAtUQHg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1901MB2037.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(366004)(39850400004)(396003)(346002)(451199018)(31686004)(38100700002)(122000001)(36756003)(76116006)(54906003)(4326008)(8676002)(64756008)(66446008)(66476007)(66556008)(31696002)(6916009)(66946007)(316002)(478600001)(91956017)(71200400001)(83380400001)(2616005)(6486002)(6506007)(6512007)(186003)(53546011)(2906002)(38070700005)(8936002)(5660300002)(41300700001)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aG5RRUxLQUtuWVNMNjVUSmRGNHIyYk9FejVLUXlLM0p4WEo2enRBZk9TK0xC?=
 =?utf-8?B?S3FQd1lJK0NXWmFMNlJFejNGbkVHMVRIKzdWbjc2Y3E5K0ZlUU9uNzBKd3BO?=
 =?utf-8?B?Sy9UT281SXBoeEY5YTNWRE51Vk9YUURYZ2tIZjJoYmorZ3pueFg3a0M1TGh0?=
 =?utf-8?B?aW92TzFpV3EwN0FlbU5UazdxL084cFgwN1J5WGkzSm5RblJTUDRYaW80RWlx?=
 =?utf-8?B?cVdVMmlVUlhPcmtBN0kzeUFDTlZNQmVRbE9URS96aVVMUzBBdXpHQlFTbGxZ?=
 =?utf-8?B?UDVESEpySFBWck9UeTJodWhDKy9RTXovMVdoVEZkaHpiQzBlVUZjeXdUcTR4?=
 =?utf-8?B?Z1Q1YkpGRHErMlovOGs4NDc1eWhmek1qc2REOW1lYUthcGJtZ1BhV1g5RzQ5?=
 =?utf-8?B?QXdIR1VIbG1GZWZHY2RTSEF2M05WRlE4R2xTR2pJUUxjTllENVZ2SER1T2Vy?=
 =?utf-8?B?VnVWdzR3S0xRblBua28wV3hBWU4xZXdCRmMvQmJldnJMZlhsSTBqdUNocTBG?=
 =?utf-8?B?NlU2U3I4RzVXRXdMVnowcVBNMlBLWTdVeXAwRUNORUhneC9IcWMyK21VanRQ?=
 =?utf-8?B?ZUppUmR4Slk5Q3BBV0lrVXZBZnpWWERiSm5SMzlLM0Q5VitMZVFuTEJhczFu?=
 =?utf-8?B?UnpZV0FOMzVtQUNXWHUxODJycWpjMVVhY1lWQm5MMDA0R2V6K0NzVjNOWmlm?=
 =?utf-8?B?SEIrWlRQcWk0WUhyNDJGaHNDaGRnYXdsODY0TG82cW1FU01sSTNhQW0rNmdF?=
 =?utf-8?B?TTQrSElXMHhFbHBCd25tOEZMeVQ4V1BOTUpKeTh5QUJld1drdkJJUkVVMGlK?=
 =?utf-8?B?Z1FjMVJaRlRlSEd3K1kvUlpMdnZXQTZRaDd4eWtRVmU3OEtTY2xrS3hJU002?=
 =?utf-8?B?VHZad3FJK2RYeWgzaHhvY1QrLzMweVZiTXlPOW9UNkRML3RWMUVrY3VxcFFz?=
 =?utf-8?B?UWNiZ2cvRmZPQzFqTEtJaW8vUFFrdmdlY1J6QmxBc2RZekd2aE42TDlCVldL?=
 =?utf-8?B?Sml4OVNCdHpHTmhpby9NK05BRnVJQ1QxNm5IbnZtNWpYKzNnUzVzV0tyK1pk?=
 =?utf-8?B?MmozbFBSRmVEc3lpYUVXelNpSFVQZUxEVE4yaVgwQWwrMFVkNU12bFRTZENV?=
 =?utf-8?B?azlyd0VmczRManRGRTJpcTliVFJGUktoSFFpYmlySTB4WTZVYkMrYW8zVytY?=
 =?utf-8?B?ejc5OVRkbXBhcHFPanVhSTRudDdDa0QzUk8yWVlDK0c4RHNqZm5jaUxKVFIy?=
 =?utf-8?B?UTBseXVOM1pVekc5UEZJSUpLcmNVM28rYUtYdkdaVUF3bGNGSGhQR284WUhP?=
 =?utf-8?B?Y3ZsdFl1Rk5NSXExa3NMcDRuVVVmUEdLRG1QSTRuc004QUk3YitIWGt5Wk1i?=
 =?utf-8?B?em9Pelp0Y1VxSjViUUsvdnBFZENJTVYwN2VmRmRFSklPby9NNWhYNmZ6bjRm?=
 =?utf-8?B?QkdhUmt1WDBHMlVSTVhiNmhNb05TVlQ3aVJrRjhTalNGaWo3OUNuY3NCc2xa?=
 =?utf-8?B?RDJmSWhWSVVIRnZlV1BpaFEzTlUzVUQ1ZWtPd3BmNFFURmRVLzVqamNoZVQy?=
 =?utf-8?B?YjdVR3hxb0U3eGtibnZ2R2hZMUxtS2lrSTUrUHY0SVQ2L09tTjRwWVJRdU1B?=
 =?utf-8?B?YU82aFMvUGRHS0ZWQzRtTEljaHpNSWVXN0JOZ0h1aXRUbm43TWZXR3BvNEpR?=
 =?utf-8?B?OXRYaUpZdDVxY1AyWllLZnNLRUJFRjlBc2dSU09jbmpyQXUzbmh3cVNXK2x6?=
 =?utf-8?B?SWI5N1RlS08xUXBXNGw3S21salllNWNjUTdxbzkwYStZL3dwZU8yMTQ3akVF?=
 =?utf-8?B?dkg5eG1BR3JVZnNIOUYwRnI0SHAzYSt6YVI3b2YxMC8wTlNjQ3I1SldCeDJz?=
 =?utf-8?B?bVZzMFdlR2lPKytOblA2UmRncG9pbzFDRHhrV0lMQ3Z2bTZ6OHZXUlJBQWVX?=
 =?utf-8?B?TktyVmk5WG5LZ09va1Y0Y05GTUNDeXRvWktxYlA3MmlEWmFYbUc5cm1zRDN6?=
 =?utf-8?B?a1VRdERoa0VCRmRQbDl5OUtrS3JkSUpSbG42RHFDWUNpWUhudUJUOWNjSmti?=
 =?utf-8?B?TUZHTEREUkEya09KNjRyMVp2SElWTzNPSUgyMGhRU3BpWlBzd2haaCttZkVq?=
 =?utf-8?B?WE5tSUE1VnFxa0dJOWw1emNmMjVYalh3ck1HUG9wRTlXRnVGeTNSVWRTRkR6?=
 =?utf-8?Q?raDp8bpp5kQ0N9x+DSSmq/c=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <706B93F4F686404C881FB3F1AAA977C4@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1901MB2037.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 745c7e5b-62f1-45a0-d0ba-08db2b8e559a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2023 11:04:12.4148
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X7z40fSrTPjuEIoyk2URpmSl57YYB91ZwA3llwvoxN9JV8ObFrlRI2nzYkbDpXth8sl9StdPoCa3OVEoluw/mA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR19MB5444
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

VGhhbmtzIGZvciBsb29raW5nIGF0IHRoZXNlIHBhdGNoZXMhDQoNCkknbSBhZGRpbmcgaW4gTWlu
ZyBMZWksIGFzIEkgaGFkIHRha2VuIHNldmVyYWwgaWRlYXMgZnJvbSB1YmxrbSBJIGd1ZXNzIA0K
SSBhbHNvIHNob3VsZCBhbHNvIGV4cGxhaW4gaW4gdGhlIGNvbW1pdCBtZXNzYWdlcyBhbmQgY29k
ZSB3aHkgaXQgaXMgDQpkb25lIHRoYXQgd2F5Lg0KDQpPbiAzLzIzLzIzIDExOjI3LCBNaWtsb3Mg
U3plcmVkaSB3cm90ZToNCj4gT24gVHVlLCAyMSBNYXIgMjAyMyBhdCAwMjoxMSwgQmVybmQgU2No
dWJlcnQgPGJzY2h1YmVydEBkZG4uY29tPiB3cm90ZToNCj4+DQo+PiBUaGlzIGFkZHMgYSBkZWxh
eWVkIHdvcmsgcXVldWUgdGhhdCBydW5zIGluIGludGVydmFscw0KPj4gdG8gY2hlY2sgYW5kIHRv
IHN0b3AgdGhlIHJpbmcgaWYgbmVlZGVkLiBGdXNlIGNvbm5lY3Rpb24NCj4+IGFib3J0IG5vdyB3
YWl0cyBmb3IgdGhpcyB3b3JrZXIgdG8gY29tcGxldGUuDQo+IA0KPiBUaGlzIHNlZW1zIGxpa2Ug
YSBoYWNrLiAgIENhbiB5b3UgZXhwbGFpbiB3aGF0IHRoZSBwcm9ibGVtIGlzPw0KPiANCj4gVGhl
IGZpcnN0IHRoaW5nIEkgbm90aWNlIGlzIHRoYXQgeW91IHN0b3JlIGEgcmVmZXJlbmNlIHRvIHRo
ZSB0YXNrDQo+IHRoYXQgaW5pdGlhdGVkIHRoZSByaW5nIGNyZWF0aW9uLiAgVGhpcyBhbHJlYWR5
IGxvb2tzIGZpc2h5LCBhcyB0aGUNCj4gcmluZyBjb3VsZCB3ZWxsIHN1cnZpdmUgdGhlIHRhc2sg
KHRocmVhZCkgdGhhdCBjcmVhdGVkIGl0LCBubz8NCg0KWW91IG1lYW4gdGhlIGN1cnJlbnRseSBv
bmdvaW5nIHdvcmssIHdoZXJlIHRoZSBkYWVtb24gY2FuIGJlIHJlc3RhcnRlZD8gDQpEYWVtb24g
cmVzdGFydCB3aWxsIG5lZWQgc29tZSB3b3JrIHdpdGggcmluZyBjb21tdW5pY2F0aW9uLCBJIHdp
bGwgdGFrZSANCmNhcmUgb2YgdGhhdCBvbmNlIHdlIGhhdmUgYWdyZWVkIG9uIGFuIGFwcHJvYWNo
LiBbQWxzbyBhZGRlZCBpbiBBbGV4c2FuZHJlXS4NCg0KZnVzZV91cmluZ19zdG9wX21vbigpIGNo
ZWNrcyBpZiB0aGUgZGFlbW9uIHByb2Nlc3MgaXMgZXhpdGluZyBhbmQgYW5kIA0KbG9va3MgYXQg
ZmMtPnJpbmcuZGFlbW9uLT5mbGFncyAmIFBGX0VYSVRJTkcgLSB0aGlzIGlzIHdoYXQgdGhlIHBy
b2Nlc3MgDQpyZWZlcmVuY2UgaXMgZm9yLg0KDQo+IA0KPiBDYW4geW91IGV4cGxhaW4gd2h5IHRo
ZSBmdXNlIGNhc2UgaXMgZGlmZmVyZW50IHRoYW4gcmVndWxhciBpby11cmluZz8NCg0KDQpsaWJm
dXNlIHNlbmRzIElPUklOR19PUF9VUklOR19DTUQgLSBmb3J3YXJkIGNvbW1hbmQgYW5kIGV2ZXJ5
dGhpbmcgaXMgDQpoYW5kbGVkIGJ5IGZ1c2Uua28gLSBmdXNlLmtvIHJlY2VpdmVzIHRoZSBTUUUg
YW5kIHN0b3JlcyBpdC4gT24gc2h1dGRvd24gDQp0aGF0IGNvbW1hbmQgbmVlZHMgdG8gYmUgY29t
cGxldGVkIHdpdGggaW9fdXJpbmdfY21kX2RvbmUoKS4gSWYgeW91IA0KZm9yZ2V0IHRvIGRvIGl0
IC0gd29ya2VyIHF1ZXVlcyB3aWxsIGdvIGludG8gRC1zdGF0ZSBhbmQgcHJpbnQgd2FybmluZyAN
Cm1lc3NhZ2VzIGluIGludGVydmFscyBpbiB1cmluZyBjb2RlLg0KDQpQdXJwb3NlIG9mIGNoZWNr
IG9mIFBGX0VYSVRJTkcgaXMgdG8gZGV0ZWN0IGlmIHRoZSBkYWVtb24gaXMgZ2V0dGluZyANCmtp
bGxlZCBhbmQgdG8gcmVsZWFzZSB1cmluZyByZXNvdXJjZXMsIGV2ZW4gaWYgeW91IGRpZG4ndCB1
bW91bnQgeWV0Lg0KDQoNClRoYW5rcywNCkJlcm5kDQoNCg0KDQo=
