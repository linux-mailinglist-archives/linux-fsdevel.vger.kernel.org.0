Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4CB26E27C4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Apr 2023 17:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbjDNP5k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Apr 2023 11:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbjDNP5j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Apr 2023 11:57:39 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2103.outbound.protection.outlook.com [40.107.244.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBFB012F;
        Fri, 14 Apr 2023 08:57:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AX2AuXkHBwrGR22w8UferelnF2y6D4PQ1XxZRyN5qfL/7qpUcVD0C4tEXevJ8mqS8UXV66wJr/s0d4pC6PbRZu+yHoEc80bIMIGSsT6RnULOcK6GXvvawUJyRr4tkp3jOrrt4gnlgCpAVeO03VKHqyNkuUDQrKpfyvlPJkqL92N1YUJLUCI5jjVWjdN21aJG/NlwoxFnn4P10qMbDGtxj7E3iOlBM/uKuOALYTwMkrojwBiPpDxc2iukUaMWdQsq8aS8EI0sd+Xe0JjJu9SGJ7XY/mXfe1mu1KsyMxLef7LLNa0DUbnJf8A/QTF1PGHflsfccYQSqlZEqKeHpLx/7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tt4mQdIEFkPDhRyXx4jWf+NJ4CIHeSAOSbQYWMnC5ck=;
 b=PuHyYGyIDr4gBAq2/tJlMNWgbBNrKr+WLoRNHTodWnEwFcq4L2Pp8gkuw62UDjTvAt6BWUfR7dLKBb0guvQfXBLWW3oMjklms9qtXMG0WUyRJ3NFZ7d9tM4mVU5ZIVqMXhL2c3lFp1ZMXgTMwf/jj4ybO0v0HuG0OjsTVsB0ClecEN+VQ41IRHUxPf+/kXGiMiLd1a591UHdyq6+8w5OXhg5ZvkhOwNbUn3ag/rl4UcQVRaPAXuXVvCyjg//KxZYmjsHnzUGPYEGub8/95n6n7JRACU0U32yeKL7EBu5JaDfKcYPG70rObFu+aEr9lyiaJSTSPDJG/HyRQ6WbLtNGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tt4mQdIEFkPDhRyXx4jWf+NJ4CIHeSAOSbQYWMnC5ck=;
 b=OuWlrIfy8mtcQ6/sbGsgJ/aihQJpWZ4gQn5r9YYnURGwZXTmok3TlR0IBc73VigDDhP6diUnJBEdTXYHSfDwmyJPjv//mgBnibt9w8B7q+bVXQW/EkTTdNzsW5NNobYkEXffUvGTVE3vmXBvvycM4oVCi4tGCjmbR0jVfwWa22s=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by DS7PR13MB4766.namprd13.prod.outlook.com (2603:10b6:5:38c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Fri, 14 Apr
 2023 15:57:34 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::3627:d466:b0ae:1740]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::3627:d466:b0ae:1740%3]) with mapi id 15.20.6298.030; Fri, 14 Apr 2023
 15:57:34 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     Christian Brauner <brauner@kernel.org>
CC:     Jeffrey Layton <jlayton@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Neil Brown <neilb@suse.de>,
        Dave Wysochanski <dwysocha@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: allowing for a completely cached umount(2) pathwalk
Thread-Topic: allowing for a completely cached umount(2) pathwalk
Thread-Index: AQHZblNqsf7f4dFF3kOaw1n+rBD0gK8p1WaAgABDqACAAHvlAIAAO+cAgAALHwCAAA6aAIAABNEAgAAHj4A=
Date:   Fri, 14 Apr 2023 15:57:34 +0000
Message-ID: <4F4F5C98-AA06-40FB-AE51-79E860CD1D76@hammerspace.com>
References: <95ee689c76bf034fa2fe9fade0bccdb311f3a04f.camel@kernel.org>
 <168142566371.24821.15867603327393356000@noble.neil.brown.name>
 <20230414024312.GF3390869@ZenIV>
 <2631cb9c05087ddd917679b7cebc58cb42cd2de6.camel@kernel.org>
 <20230414-sowas-unmittelbar-67fdae9ca5cd@brauner>
 <9192A185-03BF-4062-B12F-E7EF52578014@hammerspace.com>
 <20230414-leiht-lektion-18f5a7a38306@brauner>
 <91D4AC04-A016-48A9-8E3A-BBB6C38E8C4B@hammerspace.com>
In-Reply-To: <91D4AC04-A016-48A9-8E3A-BBB6C38E8C4B@hammerspace.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|DS7PR13MB4766:EE_
x-ms-office365-filtering-correlation-id: 09c6a9b3-739d-4d02-e51f-08db3d00f611
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U7zrbjmNh63yWSOuIa3vuL3At+Q/iI1mvsmvpiJ02A2vCKCfDvrUpeHLHRri7DKUdvmDKyGCbMJTWxXhU1fPrvMYCpG9tsbmfH8rVoVkv4AWuh1BABmVk8quH5lfjZdrF+arTrKQ7KMangL9EU75XVlS9ifQJjL4Qxlk7P4inlaHxmOVhjJxhl24G7uJhAUuOofHdyBVoGc4aijsRv5hJ0xSCbId1cREM0j0ZjrjnvxDsXpeRNXWOXWMU54gF0taY9IkiOht4v14sbmeXE4fwyy8nkc9QMz/SUfsVtJ3lxH+KPz59q38SaPN1Ikjz2X1A/NowSotXaw4n75AxiYKKuJiAttdpkzykzPeqrTezS6T/vgM0/VxyF+8MbTuG9OMT9+1chrcp1lXBcWgCIz6JgcrUMNp1mnrTk3X2ADeMXmQwR9eki76qjZvbXfNGV6KFJci5zyT0ooKK6npnoAVCCWjBfnLyT3wgtNBXJQRaBb376OdzP10ZQ2LNMOUzsvviQQRyHyGQ3p+Wuk8NuKqrO9e/qwpTl51rZhP9Wy0WJwl6Z38fcLYzsmuZv73jeF8KAM8xDqXUwgtB4TBtWMjgPkf6DBN7YiQDM4zscs9fHS3uN/zdXdRUHOb5oZ0ZZ9zzGUIY057sshqwu3Q98qr4gsViiGCkBkNWNNkAIFKk/evJnagA4ZcC0Ar/BYHhYyh/5nmHthT2mzHEGGkarzZyg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39840400004)(376002)(396003)(136003)(366004)(451199021)(38070700005)(26005)(76116006)(66476007)(64756008)(66556008)(66446008)(53546011)(36756003)(6506007)(6512007)(71200400001)(2906002)(83380400001)(6486002)(2616005)(186003)(66946007)(4326008)(6916009)(54906003)(86362001)(5660300002)(8676002)(38100700002)(8936002)(122000001)(33656002)(316002)(478600001)(41300700001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WkMwalowWkk2ZFgwVFczTnJBaVhFeVRaMDlrdDluVTdJNkNELzZjQ05ZOUxE?=
 =?utf-8?B?SzR2Y0lCSUJlWGl0MHR1U0dEb1BTdklwOEJoRVF0b0pmVHhtNUY0U3VhQldK?=
 =?utf-8?B?WXc1aHM2U29GSE80empsZEpuV2lHblhUNFZSNzlUanRwaVI3Z0VKSnNuYnJC?=
 =?utf-8?B?ZzBBS0toNUxtOHNqNzE1NjFJbnhIcEdWdXp2MnZRdlNnU1NBTG1WN0tUNEov?=
 =?utf-8?B?Yk9tQU4wZFZwVzdYaUd1elIzSkNJQlpsK1hua2dxYmI3RWxSRTNiblh0czNX?=
 =?utf-8?B?aXhSbEdHQ09KTzZLYStkT1N4QVpaNG9DelZCa1Z2QjhRckhDR0NEMWR6RW4w?=
 =?utf-8?B?TWJENWNGOXkraWlQTkhYTUQ3MFMreXB1UWgzWWNlTlp5cVJoYldTSkt4TWxO?=
 =?utf-8?B?SjM3bmZkRjNydmg2T2JSbklFMlF5Sld2L1pseGhWVFFadHRwM2REWjVjQWRK?=
 =?utf-8?B?dFgvc1h1OW5iTjJyRmZyYm9EOUJlREFQenpyWVUvNUJTeGhGM1R0MlptT2Ju?=
 =?utf-8?B?OWd6Q1RmSVUzTXU3R3laR1ZsS2hYM2cyMFZSOFNSdUFmSVhDcW9hV2hLV29P?=
 =?utf-8?B?QVNNWXhwbi9SbVlnT0Z3ektoSHNTNmNaMHVTdFArQkptK2pjRzAydHdTTDJT?=
 =?utf-8?B?UEEyWkhHcEhPWHpBMzJwaTNiaGpiV3owRHRRcUVPN1hZM2xJN0Y3bE1VRG9E?=
 =?utf-8?B?ZkdGUmo1OW5SYnB5aUhvM2ViOUF6Q05GMWVGdytKQzFoSkNtUDdyalBBRmp6?=
 =?utf-8?B?NW8wSEVXWVFBWk00YmE2MFBxMHRBUFNJdTNuemZhSXJRbUFoN2lDekJyM0Np?=
 =?utf-8?B?Z243RHJyWE90NFA3b2Y5OWFlZ0VvdkgzdzNVZUlDNEFsdklCeEdWeW54anp3?=
 =?utf-8?B?Z1gxbnp3SjVKdlR4Q1V1YzMzQmx0a2I3MUtjbDUzODdHaEhROXpDV1ZScU5a?=
 =?utf-8?B?SzV6d09YaU5EbGpEOXFMMEttbzFYZTd2dHNoNy9HZE1qTERrZFVkMmY1dEwx?=
 =?utf-8?B?MzRSdGRveHNIa3Q5V1dRYm83WW5SN3pkUzRVdHZRZllZL2dTMlpzUHhMcC9q?=
 =?utf-8?B?Kzd6ZzJ0NlJiYmFDeUpHdjV4ek4ybU5WZHR4b0hSM2U1UEVzN1BXb3B1MDgx?=
 =?utf-8?B?ZWNxVUdFYm9heE1EeG9mWEpVdFE0WTd2QVd2ODNuMFMrTG9mSWcrQUtMUjJZ?=
 =?utf-8?B?WkZOSlZORXAwemhDWHZ1WlJyQ1hzbGFLbTUrTUYvUklvazdrL2NYOWpQdm5p?=
 =?utf-8?B?RktQemFDMU84azZmWmpMYllweGppdXowbWJWTU92bjhCdElBYVFoZEUvbjlo?=
 =?utf-8?B?T1lLd1ltTFZ2OU8vUzVoQVUzMVk5M2xvOVlUekhLNzdKSGZ2OXJIcXZueHEr?=
 =?utf-8?B?QzA0YzMxeERVSFN4YndJNHRFSmRHdHZRb0I2NzNKb0JaQTY3b2Z3aVBIdnNv?=
 =?utf-8?B?REpGZ3RVcloxUnkxMjlWbDJjQjcvNWJjTUxKZlJPZHJnTVRYbEZIWC9nVnZ6?=
 =?utf-8?B?V2I3Sk9leWhnY1Q4TllCaWJ6UHExSDBYNmFUVXZtUDY2Uyt1eVBoRjZzNEYx?=
 =?utf-8?B?emtlWTdwa1cxTGR4NUF5S1ZaZVdpdVJPTEdwem4wUEhXNnc5TWVWSytMM2do?=
 =?utf-8?B?RzU2WGFqeEZUc2x6T3hhWURZM3BWM2RmY1lubHJMYTF0aXZGbEpxUFRBQVNJ?=
 =?utf-8?B?OHFDZjdncTZCb1VpREVMVVBmOHp6Z0VwYkVoM1JEcUN2RmZPaFZZWTRwUDlR?=
 =?utf-8?B?ZDQyNjZJcVhXSXQzNkc4a3plRjZlMFZxVWRFOEEydGV6dGxSR2c2cVZ6STRa?=
 =?utf-8?B?YW5Jc04vSXM4elB5M3IxSVhpY0RxZkF2QWZsM1U0MHFtem5RNkZ0eE9nZ3I0?=
 =?utf-8?B?YWZneTFJWCs4c2hRbXIxQmsyaDBQK0RWYUFSemVsdmhWcmhqS2dTT3ZMV1B5?=
 =?utf-8?B?cnFhU3dRQWd3UEZGU05ubWpKQUJwY1JHc3EvK0RML201MzFIR2Q0WHhsSWdG?=
 =?utf-8?B?K1VLU3UxN0tnRWo0WmtPdGZTZDlGazRvVTYwV3lGZ0Zob0t0SUFVZnVnQmJk?=
 =?utf-8?B?bmNFaStWUWRnN0pBdDVzSzQxVG9RbzJ4Ny9DWFdtOGw0Tld1d3lDeTZsZGdJ?=
 =?utf-8?B?MXBIRmtxRnpyNWk5Y3lMVDkxVnVJQnpUZGZVeEJGcS8wR3BaWlhNUG9GSlN3?=
 =?utf-8?B?MHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3126E3EF70E0C64AAE6A15270EC46CD3@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09c6a9b3-739d-4d02-e51f-08db3d00f611
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2023 15:57:34.0163
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rq9YSh8/UGZCOXhkWJXEfkBe1i5k86zGwzobffI2i4g4XAs3aLEFYwI7bg49uspOLZe1x+fo/6CmseHh2JKHRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR13MB4766
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

DQo+IE9uIEFwciAxNCwgMjAyMywgYXQgMTE6MzAsIFRyb25kIE15a2xlYnVzdCA8dHJvbmRteUBo
YW1tZXJzcGFjZS5jb20+IHdyb3RlOg0KPiANCj4gDQo+IA0KPj4gT24gQXByIDE0LCAyMDIzLCBh
dCAxMToxMywgQ2hyaXN0aWFuIEJyYXVuZXIgPGJyYXVuZXJAa2VybmVsLm9yZz4gd3JvdGU6DQo+
PiANCj4+IE9uIEZyaSwgQXByIDE0LCAyMDIzIGF0IDAyOjIxOjAwUE0gKzAwMDAsIFRyb25kIE15
a2xlYnVzdCB3cm90ZToNCj4+PiANCj4+PiANCj4+Pj4gT24gQXByIDE0LCAyMDIzLCBhdCAwOTo0
MSwgQ2hyaXN0aWFuIEJyYXVuZXIgPGJyYXVuZXJAa2VybmVsLm9yZz4gd3JvdGU6DQo+Pj4+IA0K
Pj4+PiBPbiBGcmksIEFwciAxNCwgMjAyMyBhdCAwNjowNjozOEFNIC0wNDAwLCBKZWZmIExheXRv
biB3cm90ZToNCj4+Pj4+IE9uIEZyaSwgMjAyMy0wNC0xNCBhdCAwMzo0MyArMDEwMCwgQWwgVmly
byB3cm90ZToNCj4+Pj4+PiBPbiBGcmksIEFwciAxNCwgMjAyMyBhdCAwODo0MTowM0FNICsxMDAw
LCBOZWlsQnJvd24gd3JvdGU6DQo+Pj4+Pj4gDQo+Pj4+Pj4+IFRoZSBwYXRoIG5hbWUgdGhhdCBh
cHBlYXJzIGluIC9wcm9jL21vdW50cyBpcyB0aGUga2V5IHRoYXQgbXVzdCBiZSB1c2VkDQo+Pj4+
Pj4+IHRvIGZpbmQgYW5kIHVubW91bnQgYSBmaWxlc3lzdGVtLiAgV2hlbiB5b3UgZG8gdGhhdCAi
ZmluZCJpbmcgeW91IGFyZQ0KPj4+Pj4+PiBub3QgbG9va2luZyB1cCBhIG5hbWUgaW4gYSBmaWxl
c3lzdGVtLCB5b3UgYXJlIGxvb2tpbmcgdXAgYSBrZXkgaW4gdGhlDQo+Pj4+Pj4+IG1vdW50IHRh
YmxlLg0KPj4+Pj4+IA0KPj4+Pj4+IE5vLiAgVGhlIHBhdGggbmFtZSBpbiAvcHJvYy9tb3VudHMg
aXMgKk5PVCogYSBrZXkgLSBpdCdzIGEgYmVzdC1lZmZvcnQNCj4+Pj4+PiBhdHRlbXB0IHRvIGRl
c2NyaWJlIHRoZSBtb3VudHBvaW50LiAgUGF0aG5hbWUgcmVzb2x1dGlvbiBkb2VzIG5vdCB3b3Jr
DQo+Pj4+Pj4gaW4gdGVybXMgb2YgInRoZSBsb25nZXN0IHByZWZpeCBpcyBmb3VuZCBhbmQgd2Ug
aGFuZGxlIHRoZSByZXN0IHdpdGhpbg0KPj4+Pj4+IHRoYXQgZmlsZXN5c3RlbSIuDQo+Pj4+Pj4g
DQo+Pj4+Pj4+IFdlIGNvdWxkLCBpbnN0ZWFkLCBjcmVhdGUgYW4gYXBpIHRoYXQgaXMgZ2l2ZW4g
YSBtb3VudC1pZCAoZmlyc3QgbnVtYmVyDQo+Pj4+Pj4+IGluIC9wcm9jL3NlbGYvbW91bnRpbmZv
KSBhbmQgdW5tb3VudHMgdGhhdC4gIFRoZW4gL3NiaW4vdW1vdW50IGNvdWxkDQo+Pj4+Pj4+IHJl
YWQgL3Byb2Mvc2VsZi9tb3VudGluZm8sIGZpbmQgdGhlIG1vdW50LWlkLCBhbmQgdW5tb3VudCBp
dCAtIGFsbA0KPj4+Pj4+PiB3aXRob3V0IGV2ZXIgZG9pbmcgcGF0aCBuYW1lIGxvb2t1cCBpbiB0
aGUgdHJhZGl0aW9uYWwgc2Vuc2UuDQo+Pj4+Pj4+IA0KPj4+Pj4+PiBCdXQgSSBwcmVmZXIgeW91
ciBzdWdnZXN0aW9uLiAgTE9PS1VQX01PVU5UUE9JTlQgY291bGQgYmUgcmVuYW1lZA0KPj4+Pj4+
PiBMT09LVVBfQ0FDSEVELCBhbmQgaXQgb25seSBmaW5kcyBwYXRocyB0aGF0IGFyZSBpbiB0aGUg
ZGNhY2hlLCBuZXZlcg0KPj4+Pj4+PiByZXZhbGlkYXRlcywgYXQgbW9zdCBwZXJmb3JtcyBzaW1w
bGUgcGVybWlzc2lvbiBjaGVja3MgYmFzZWQgb24gY2FjaGVkDQo+Pj4+Pj4+IGNvbnRlbnQuDQo+
Pj4+Pj4gDQo+Pj4+Pj4gdW1vdW50IC9wcm9jL3NlbGYvZmQvNDIvYmFyZi9zb21ldGhpbmcNCj4+
Pj4+PiANCj4+Pj4+IA0KPj4+Pj4gRG9lcyBhbnkgb2YgdGhhdCBpbnZvbHZlIHRhbGtpbmcgdG8g
dGhlIHNlcnZlcj8gSSBkb24ndCBuZWNlc3NhcmlseSBzZWUNCj4+Pj4+IGEgcHJvYmxlbSB3aXRo
IGRvaW5nIHRoZSBhYm92ZS4gSWYgInNvbWV0aGluZyIgaXMgaW4gY2FjaGUgdGhlbiB0aGF0DQo+
Pj4+PiBzaG91bGQgc3RpbGwgd29yay4NCj4+Pj4+IA0KPj4+Pj4gVGhlIG1haW4gaWRlYSBoZXJl
IGlzIHRoYXQgd2Ugd2FudCB0byBhdm9pZCBjb21tdW5pY2F0aW5nIHdpdGggdGhlDQo+Pj4+PiBi
YWNraW5nIHN0b3JlIGR1cmluZyB0aGUgdW1vdW50KDIpIHBhdGh3YWxrLg0KPj4+Pj4gDQo+Pj4+
Pj4gRGlzY3Vzcy4NCj4+Pj4+PiANCj4+Pj4+PiBPVE9OLCB1bW91bnQtYnktbW91bnQtaWQgaXMg
YW4gaW50ZXJlc3RpbmcgaWRlYSwgYnV0IHdlJ2xsIG5lZWQgdG8gZGVjaWRlDQo+Pj4+Pj4gd2hh
dCB3b3VsZCB0aGUgcmlnaHQgcGVybWlzc2lvbnMgYmUgZm9yIGl0Lg0KPj4+Pj4+IA0KPj4+Pj4+
IEJ1dCBwbGVhc2UsIGxvc2UgdGhlICJtb3VudCB0YWJsZSBpcyBhIG1hcHBpbmcgZnJvbSBwYXRo
IHByZWZpeCB0byBmaWxlc3lzdGVtIg0KPj4+Pj4+IG5vdGlvbiAtIGl0IHJlYWxseSwgcmVhbGx5
IGlzIG5vdC4gIElJUkMsIHRoZXJlIGFyZSBzeXN0ZW1zIHRoYXQgd29yayB0aGF0IHdheSwNCj4+
Pj4+PiBidXQgaXQncyBub3doZXJlIG5lYXIgdGhlIHNlbWFudGljcyB1c2VkIGJ5IGFueSBVbmlj
ZXMsIGFsbCB2YXJpYW50cyBvZiBMaW51eA0KPj4+Pj4+IGluY2x1ZGVkLg0KPj4+Pj4gDQo+Pj4+
PiBJJ20gbm90IG9wcG9zZWQgdG8gc29tZXRoaW5nIGJ5IHVtb3VudC1ieS1tb3VudC1pZCBlaXRo
ZXIuIEFsbCBvZiB0aGlzDQo+Pj4+PiBzZWVtcyBsaWtlIHNvbWV0aGluZyB0aGF0IHNob3VsZCBw
cm9iYWJseSByZWx5IG9uIENBUF9TWVNfQURNSU4uDQo+Pj4+IA0KPj4+PiBUaGUgcGVybWlzc2lv
biBtb2RlbCBuZWVkcyB0byBhY2NvdW50IGZvciB0aGUgZmFjdCB0aGF0IG1vdW50IGlkcyBhcmUN
Cj4+Pj4gZ2xvYmFsIGFuZCBhcyBzdWNoIHlvdSBjb3VsZCBpbiBwcmluY2lwbGUgdW5tb3VudCBh
bnkgbW91bnQgaW4gYW55IG1vdW50DQo+Pj4+IG5hbWVzcGFjZS4gSU9XLCB5b3UgY2FuIGNpcmN1
bXZlbnQgbG9va3VwIHJlc3RyaWN0aW9ucyBjb21wbGV0ZWx5Lg0KPj4+PiANCj4+Pj4gU28gd2Ug
Y291bGQgcmVzb2x2ZSB0aGUgbW50LWlkIHRvIGFuIEZNT0RFX1BBVEggYW5kIHRoZW4gdmVyeSBy
b3VnaGx5DQo+Pj4+IHdpdGggbm8gY2xhaW0gdG8gc29sdmluZyBldmVyeXRoaW5nOg0KPj4+PiAN
Cj4+Pj4gbWF5X3Vtb3VudF9ieV9tbnRfaWQoc3RydWN0IHBhdGggKm9wYXRoKQ0KPj4+PiB7DQo+
Pj4+IHN0cnVjdCBwYXRoIHJvb3Q7DQo+Pj4+IGJvb2wgcmVhY2hhYmxlOw0KPj4+PiANCj4+Pj4g
Ly8gY2FsbGVyIGluIHByaW5jaXBsZSBhYmxlIHRvIGNpcmN1bXZlbnQgbG9va3VwIHJlc3RyaWN0
aW9ucw0KPj4+PiAgICAgIGlmICghbWF5X2NhcF9kYWNfcmVhZHNlYXJjaCgpKQ0KPj4+PiByZXR1
cm4gZmFsc2U7DQo+Pj4+IA0KPj4+PiAvLyBjYWxsZXIgY2FuIG1vdW50IGluIHRoZWlyIG1vdW50
bnMNCj4+Pj4gaWYgKCFtYXlfbW91bnQoKSkNCj4+Pj4gcmV0dXJuIGZhbHNlOw0KPj4+PiANCj4+
Pj4gLy8gdGFyZ2V0IG1vdW50IGFuZCBjYWxsZXIgaW4gdGhlIHNhbWUgbW91bnRucw0KPj4+PiBp
ZiAoIWNoZWNrX21udCgpKQ0KPj4+PiByZXR1cm4gZmFsc2U7DQo+Pj4+IA0KPj4+PiAvLyBjYWxs
ZXIgY291bGQgaW4gcHJpbmNpcGxlIHJlYWNoIG1vdW50IGZyb20gaXQncyByb290DQo+Pj4+IGdl
dF9mc19yb290KGN1cnJlbnQtPmZzLCAmcm9vdCk7DQo+Pj4+ICAgICAgcmVhY2hhYmxlID0gaXNf
cGF0aF9yZWFjaGFibGUocmVhbF9tb3VudChvcGF0aC0+bW50KSwgb3BhdGgtPmRlbnRyeSwgJnJv
b3QpOw0KPj4+PiBwYXRoX3B1dCgmcm9vdCk7DQo+Pj4+IA0KPj4+PiByZXR1cm4gcmVhY2hhYmxl
Ow0KPj4+PiB9DQo+Pj4+IA0KPj4+PiBIb3dldmVyLCB0aGF0IHN0aWxsIG1lYW5zIHRoYXQgd2Ug
aGF2ZSBsYXhlciByZXN0cmljdGlvbnMgb24gdW5tb3VudGluZw0KPj4+PiBieSBtb3VudC1pZCB0
aGVuIG9uIHVubW91bnQgd2l0aCBsb29rdXAgYXMgZm9yIGxvb2t1cCBqdXN0IGhhdmluZw0KPj4+
PiBDQVBfREFDX1JFQURfU0VBUkNIIGlzbid0IGVub3VnaC4gVXN1YWxseSAtIGF0IGxlYXN0IGZv
ciBmaWxlc3l0ZW1zDQo+Pj4+IHdpdGhvdXQgY3VzdG9tIHBlcm1pc3Npb24gaGFuZGxlcnMgLSB3
ZSBhbHNvIGVzdGFibGlzaCB0aGF0IHRoZSBpbm9kZQ0KPj4+PiBjYW4gYmUgbWFwcGVkIGludG8g
dGhlIGNhbGxlcidzIGlkbWFwcGluZy4NCj4+Pj4gDQo+Pj4+IFNvIHRoYXQgd291bGQgbWVhbiB0
aGF0IHVubW91bnRpbmcgYnkgbW91bnQtaWQgd291bGQgYWxsb3cgeW91IHRvDQo+Pj4+IHVubW91
bnQgbW91bnRzIGluIGNhc2VzIHdoZXJlIHlvdSB3b3VsZG4ndCB3aXRoIHVtb3VudC4gVGhhdCBt
aWdodCBiZQ0KPj4+PiBmaW5lIHRob3VnaCBhcyB0aGF0J3MgdWx0aW1hdGVseSB0aGUgZ29hbCBo
ZXJlIGluIGEgd2F5Lg0KPj4+PiANCj4+Pj4gT25lIGNvdWxkIGFsc28gc2VlIGEgdmVyeSB1c2Vm
dWwgZmVhdHVyZSBpbiB0aGlzIHdoZXJlIHlvdSByZXF1aXJlDQo+Pj4+IGNhcGFibGUoQ0FQX0RB
Q19SRUFEX1NFQVJDSCkgYW5kIGNhcGFibGUoQ0FQX1NZU19BRE1JTikgYW5kIHRoZW4gYWxsb3cN
Cj4+Pj4gdW5tb3VudGluZyBhbnkgbW91bnQgaW4gdGhlIHN5c3RlbSBieSBtb3VudC1pZC4gVGhp
cyB3b3VsZCBvYnZpb3VzbHkgYmUNCj4+Pj4gdmVyeSB1c2VmdWwgZm9yIHByaXZpbGVnZWQgc2Vy
dmljZSBtYW5hZ2VycyBidXQgSSBoYXZlbid0IHRob3VnaHQgdGhpcw0KPj4+PiBUaHJvdWdoLg0K
Pj4+IA0KPj4+IFRoYXQgaXMgZXhhY3RseSB3aHkgaGF2aW5nIGEgc2VwYXJhdGUgc3lzY2FsbCB0
byBkbyB0aGUgbG9va3VwIG9mIHRoZSBtb3VudC1pZCBpcyBnb29kOiBpdCBwcm92aWRlcyBzZXBh
cmF0aW9uIG9mIHByaXZpbGVnZS4NCj4+PiANCj4+PiBUaGUgY29udmVyc2lvbiBvZiBtb3VudC1p
ZCB0byBhbiBPX1BBVEggZmlsZSBkZXNjcmlwdG9yIGlzIGp1c3QgYWtpbiB0byBhIHBhdGggbG9v
a3VwLCBzbyBvbmx5IG5lZWRzIENBUF9EQUNfUkVBRF9TRUFSQ0ggKHNpbmNlIHlvdSByZXF1aXJl
IHByaXZpbGVnZSBvbmx5IHRvIGJ5cGFzcyB0aGUgQUNMIGRpcmVjdG9yeSByZWFkIGFuZCBsb29r
dXAgcmVzdHJpY3Rpb25zKS4gVGhlIHJlc3VsdGluZyBPX1BBVEggZmlsZSBkZXNjcmlwdG9yIGhh
cyBubyBzcGVjaWFsIHByb3BlcnRpZXMgdGhhdCByZXF1aXJlIGFueSBmdXJ0aGVyIHByaXZpbGVn
ZS4NCj4+PiANCj4+PiBUaGVuIHVzZSB0aGF0IHJlc3VsdGluZyBmaWxlIGRlc2NyaXB0b3IgZm9y
IHRoZSB1bW91bnQsIHdoaWNoIG5vcm1hbGx5IHJlcXVpcmVzIENBUF9TWVNfQURNSU4uDQo+PiAN
Cj4+IFRoZXJlJ3MgYSBkaWZmZXJlbmNlIGJldHdlZW4gdW5tb3VudGluZyBkaXJlY3RseSBieSBw
cm92aWRpbmcgYSBtb3VudCBpZA0KPj4gYW5kIGdldHRpbmcgYW4gT19QQVRIIGZpbGUgZGVzY3Jp
cHRvciBmcm9tIGEgbW50LWlkLiBJZiB5b3UgY2FuIHNpbXBseQ0KPj4gdW5tb3VudCBieSBtb3Vu
dC1pZCBpdCdzIHVzZWZ1bCBmb3IgdXNlcnMgdGhhdCBoYXZlIENBUF9EQUNfUkVBRF9TRUFSQ0gN
Cj4+IGluIGEgY29udGFpbmVyLiBXaXRob3V0IGl0IHlvdSBsaWtlbHkgbmVlZCB0byByZXF1aXJl
DQo+PiBjYXBhYmxlKENBUF9EQUNfUkVBRF9TRUFSQ0gpIGFrYSBzeXN0ZW0gbGV2ZWwgcHJpdmls
ZWdlcyBqdXN0IGxpa2UNCj4+IG9wZW5fdG9faGFuZGxlX2F0KCkgd2hpY2ggbWFrZXMgdGhpcyBp
bnRlcmZhY2Ugd2F5IGxlc3MgZ2VuZXJpYyBhbmQNCj4+IHVzYWJsZS4gT3RoZXJ3aXNlIHlvdSdk
IGJlIGFibGUgdG8gZ2V0IGFuIE9fUEFUSCBmZCB0byBzb21ldGhpbmcgdGhhdA0KPj4geW91IHdv
dWxkbid0IGJlIGFibGUgdG8gYWNjZXNzIHRocm91Z2ggbm9ybWFsIHBhdGggbG9va3VwLg0KPiAN
Cj4gDQo+IEJlaW5nIGFibGUgdG8gY29udmVydCBpbnRvIGFuIE9fUEFUSCBkZXNjcmlwdG9yIGdp
dmVzIHlvdSBtb3JlIG9wdGlvbnMgdGhhbiBqdXN0IHVubW91bnRpbmcuIEl0IHNob3VsZCBhbGxv
dyB5b3UgdG8gc3luY2ZzKCkgYmVmb3JlIHVubW91bnRpbmcuIEl0IHNob3VsZCBhbGxvdyB5b3Ug
dG8gY2FsbCBvcGVuX3RyZWUoKSBzbyB5b3UgY2FuIG1hbmlwdWxhdGUgdGhlIGZpbGVzeXN0ZW0g
dGhhdCBpcyBubyBsb25nZXIgYWNjZXNzaWJsZSBieSBwYXRoIHdhbGsgKGUuZy4gc28geW91IGNh
biBiaW5kIGl0IGVsc2V3aGVyZSBvciBtb3ZlIGl0KS4NCj4gDQoNCk9uZSBtb3JlIHRoaW5nIGl0
IG1pZ2h0IGFsbG93IHVzIHRvIGRvLCB3aGljaCBJ4oCZdmUgYmVlbiB3YW50aW5nIGZvciBhIHdo
aWxlIGluIE5GUzogYWxsb3cgdXMgdG8gZmxpcCB0aGUgbW91bnQgdHlwZSBmcm9tIGJlaW5nIOKA
nGhhcmTigJ0gdG8g4oCcc29mdOKAnSBiZWZvcmUgZG9pbmcgdGhlIGxhenkgdW5tb3VudCwgc28g
dGhhdCBhbnkgYXBwbGljYXRpb24gdGhhdCBtaWdodCBzdGlsbCByZXRyeSBJL08gYWZ0ZXIgdGhl
IGNhbGwgdG8gdW1vdW50X2JlZ2luKCkgY29tcGxldGVzIHdpbGwgc3RhcnQgdGltaW5nIG91dCB3
aXRoIGFuIEkvTyBlcnJvciwgYW5kIGZyZWUgdXAgdGhlIHJlc291cmNlcyBpdCBtaWdodCBvdGhl
cndpc2UgaG9sZCBmb3JldmVyLg0KDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18N
ClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFj
ZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQo=
