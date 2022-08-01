Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD5C5871D0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Aug 2022 21:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235201AbiHATxs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Aug 2022 15:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234382AbiHATxl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Aug 2022 15:53:41 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D048F17AB1;
        Mon,  1 Aug 2022 12:53:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LsETfzDOUpPTN1WOSGCwgxWBU9Zgih0earwSrJK2ARGwlCLLv3PcjzwDRVpJnm0TQYUtbnyWIj4AGRagAZkhSqDmSLxF4tvbvNYVB7ygqS6ZHV/H8d/8mJOm2WNpmJ43qzhVRsoBKyfV/+S61IMMNikPFu0KYQbM0mzOoj5yhapCU6GflZa9RPahClWUw2Lu7T9/UyyiOuSfux4bj+FfGWEWklSlptnrX5Afz/kk1atmjGVvN+Y7qOoL0OjHqe4LqYSKmeuqpTi82foWZ074H4L8v/4uLhHlbzKiap4sCygay2TM8SAighFb2taOFP/oUcDGa0BYQXrDy6CMmiX+TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GZL75a2w0YyGBTAPqF5JYchGpNbEQFEr+jvdvOMpCkc=;
 b=iqDXCgxFNLBSsFhDWQ1Z/UmTRAmOUlafjC060DUvMYXD91hYHWv8wp1KWH3srJBcV819RnFwm5q1Xl6dYYINT1rM/l04RK7UAddkJU21jqnphbwfwj2JjSMwDfUEfMZfwQ6+KnU4wzc+R4283NnZWd4tAblkNJer94Og0x1+BV0giPOjtPkhmKqDcty6wJ9SgoDadw5ljJKJfxK0LA6/mtarrtga4Zm9fmd9/LCwe3sUFbUkc5tqurU/LCZVjZB8dD1iKkrgUY5crj9HYKX3XcFDuAvZeURLTzKSXJ0ZgWJgCpLYYUdtvXHPVckF/tC0XRS5Jhyfshp3QqWSYYrkSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GZL75a2w0YyGBTAPqF5JYchGpNbEQFEr+jvdvOMpCkc=;
 b=ezyKQpuJpmBktKNeoCzGy87OXEiWDPp3bZy3biSadT+wZZu7Gvv/M972qK4zLJvZRhB/pxXYnEezpBUbIVgcOJV9HYggWody/kOnAcGolMTnUOHvA0gZIaNXGohH3Ikhuu5khmsWLV5cSPcT8cRPAYVoMSpwZDprDhm8IE5Dc94=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by PH0PR05MB7590.namprd05.prod.outlook.com (2603:10b6:510::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5504.12; Mon, 1 Aug 2022 19:53:37 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::d813:9300:4877:39d0]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::d813:9300:4877:39d0%8]) with mapi id 15.20.5504.014; Mon, 1 Aug 2022
 19:53:36 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
CC:     "Schaufler, Casey" <casey.schaufler@intel.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        Jonathan Corbet <corbet@lwn.net>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>, Peter Xu <peterx@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        zhangyi <yi.zhang@huawei.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH v4 0/5] userfaultfd: add /dev/userfaultfd for fine grained
 access control
Thread-Topic: [PATCH v4 0/5] userfaultfd: add /dev/userfaultfd for fine
 grained access control
Thread-Index: AQHYm6moVvUxeU2aLUSjhWg4PqcU4q2H1VIAgAANjICAAASjgIASdSEAgAAsz4A=
Date:   Mon, 1 Aug 2022 19:53:35 +0000
Message-ID: <DDE06635-71B4-46B9-9635-97E35E0B5482@vmware.com>
References: <20220719195628.3415852-1-axelrasmussen@google.com>
 <PH7PR11MB6353950F607F7B8F274A3550FD8E9@PH7PR11MB6353.namprd11.prod.outlook.com>
 <CAJHvVchusMjvhLxYkWpa+iTaHvXYPFHcX7JGP=bW60e_O1jFGA@mail.gmail.com>
 <7EF50BE4-84EA-4D57-B58C-6697F1B74904@vmware.com>
 <CAJHvVcghaZjgU6YhoGMehQTDU36S-UL5djG+Bym6Uax=VVoX7g@mail.gmail.com>
In-Reply-To: <CAJHvVcghaZjgU6YhoGMehQTDU36S-UL5djG+Bym6Uax=VVoX7g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ff930dbf-0c5e-40fb-7b3f-08da73f78590
x-ms-traffictypediagnostic: PH0PR05MB7590:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FN7inO5zJ+Gsh7WLFwey7Wxee0apQjtDju/+QEOrgtkfFWOVTwIJUUDyCQru5cBUebE/KBuvMZhY/t8XxGirQCV4IA9NwKbU6s0uG8OzZ8uhX5xxcFt8AC9CmiUj/ePmSowdxSCTtbaxinClCkJLkCIFGZyebgu4LzFERfFoKdbXpIE3WspRgTRJ64UE8UAJcFd55fm3dPYWaxwJRNATA0x9p02t+GFFQzBBy6iQhzo/PviQIHQudwfZlaQQIlf+ibmsdGDsXhQ/a2tikXzJbdTlU92W3NeZqMus2k/akX1C3hsRyQBKMl1+c+VzD/aKGqWSLe2VpmP6L5rnu8hIxcRvjdTXIMEiOHaqlmlWWGwGnSDNon1pcuL7R8SLy6W90Lf5ImbvUluGJb80PyQWFJtVMed5VP4dapWzV820PzQCreGpaaV9Lg7eAQ5/tT2PYx26igvYkuovQq2flmcNmSSDt8hnSLKuRz5376dOqwPSGjduinkFv3hS4ktKXy3OTWFxDAztRV431LNdbIMTUusBAsNHu1gN0icsjC74OFyjAg6Ye86//X7iUEIdBSCnx8B5pL2RTHQ2jAZttXeARfHt+4C7hFfqXRdT31lzbTAefm5XkSBh1wytwIuf0SssTW6vH6iGfIQE3FGr6ywz0Qkr5Uoy8V8aulbRwF16+1SH+m40P5R9GP/4Hpj5t5GBZPZRZeoSbWxcC6H9Je1VNGWalutw4gUIqmYtNkeLzgr2Ova+AUB7OEa2GqKTG6aXMiguiC/78DFRqFmD2x++7KNlr27S1AR/sSxzDfK3g5ROYKbXYsj1c+1Lq2GE3WeAZHrVDnG9W7mRpp18JoJNew==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(376002)(346002)(366004)(39860400002)(26005)(53546011)(6512007)(478600001)(7416002)(8936002)(5660300002)(6486002)(33656002)(2906002)(6506007)(86362001)(41300700001)(122000001)(38070700005)(83380400001)(2616005)(71200400001)(186003)(6916009)(38100700002)(66946007)(76116006)(8676002)(54906003)(4326008)(66476007)(66446008)(64756008)(36756003)(66556008)(316002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dW43clpyZzE5TFEwNnkzU2REOEkzS0RMeDU5N1RXRXNzRXVRMk1PUHZmUG1Q?=
 =?utf-8?B?dUZRU0FGUzRlNHFmeFgvMGZpaTgwejNuVW5BNlBFKzU3MnZwVnpyZDdiSElK?=
 =?utf-8?B?c21BNERKS1NjWk5nOFlnZnhabGJJZ2c4U285NUU0anc2SDdsbWUvYVk1NnUx?=
 =?utf-8?B?b2RKb3NLY1MzR01yVWZLemw2ZmsxWGFENmQxSDhZSkNyb1BwN0hPb3pqTTZw?=
 =?utf-8?B?Uk1IUG96SSswSEFsaWpuS3JyTnhPRTZxaVJuM0szOStuNjFpb3NTNHAyUlZO?=
 =?utf-8?B?cVRuem1oY2tnYklkSndVbVdNeUw5WkNmK1hLcjlvUzdtV29YQkZUTGxEWUFM?=
 =?utf-8?B?c01MY1ZGcTFCUlYvVUpNanltUEVzR3NrTUZpbHN0U2daUmxBTyttUUdjSlNx?=
 =?utf-8?B?dis0TG5qd2dGOGJUcE1XOHM0TGRlY1d2KzUzSTJYZGZpT3VMa1M3ZFI1ektD?=
 =?utf-8?B?Z3JYczdGRG9aUjdOcWd6ekxiTDdZZmo4ZWQ2ZHROK1pBbE9tZTNGOXZsb0dv?=
 =?utf-8?B?ei9SWGNMMnE0MUJqWUxYZjRDbzl3M2pXaWEyb0Y1YWE0VDBsek5XNDAvdzh2?=
 =?utf-8?B?Zlk1dHNOdkNkNENyajdlTFNIbTJua2lXZmNobTJFVUd6bDdKSlU3L3BLWGhp?=
 =?utf-8?B?UDJ1Rnk0VzgzcHp1WENiRkVpNVdadUpjZXppKzI1bDhXdlRNOU9scWRYQXdG?=
 =?utf-8?B?VHhqRjc2RlA0dXRVTVFZUjROMndVMW1WbVFiQjlHejlQYUw5blVOZjJSbDZF?=
 =?utf-8?B?bVgwQ3FvN1dlWWFWU3RXRTA1Nk1sR3lueEwvek9mdlJTcTA0VWZIZFpKbnZh?=
 =?utf-8?B?em9na1hGaEM5YmpSWUJKN2k0MFo0SjBrbkV0UllFMlNYc1NpNncvNHlvVjhy?=
 =?utf-8?B?WTYzcjF6WUlQalZraSs1TXU2akFJekRWUmhyNldlaCtocDMvWE5ZZWxMdWRD?=
 =?utf-8?B?bjd3VkRWbEZhZVg3SWl5aTRBZ3oxRjUwazNZa3hqcUpjYXdVS1hhTCtiRWpT?=
 =?utf-8?B?dVdTY3hIODZKK2ZGL1NKOE5XMDhpVkt4eEd2bUdEMmdxMmZ4NkFuOVNtTEhx?=
 =?utf-8?B?cDlLcXdCMjdnM2o3WXZrdmlyVDFxTy9oUEgzSG9qOXlNOFJJOFk2Q0FiVk1y?=
 =?utf-8?B?K3gvZnE3NndJUlBqN0JGS0lyN2ZiYy9TQ1BqTURZdlRBdk16RUlpK1QwdWFj?=
 =?utf-8?B?dGxyUnJIQXNudldBT0xkSyt4NHZCcXk2eUFmVEUrblFkRTQ2b2p6SjBJM2lx?=
 =?utf-8?B?eW5jbUx1bjByZGlNb0xnYUFJUkFjQ3JLVGdQeWV4Q1FjODZ5T3Yzc3p6bWxQ?=
 =?utf-8?B?aXdvOUxwTVZVaEpNcW9DMVRqS2szVFUyMWhLYWFLbFpNODV2em9rbFE3Z0ty?=
 =?utf-8?B?NTdweXRvT0kveVNQKzQvaTVxNDJoVlUwYlErWGh4VnJQM2NCdG5Qc0ZzT245?=
 =?utf-8?B?THpmb2d5TWo2UXMzcVNTR3ByMDZLNHVFR0U0aks2cVVVZ3NMOUlyNEc2Yk5K?=
 =?utf-8?B?UmJKdFA0dW9SdE4wak1scGw1UjNWUm55VW5wbUwwc2xud0hadFYzUk5vU0lQ?=
 =?utf-8?B?TlBQZi93Q01FaUd4OHdnWkQ3dUJMR0VaZlpLY1pHTUFDckpoMy8ydFpiTnla?=
 =?utf-8?B?b1hibHpNYTMrMXhKWVZvUGdIMUZHQUY4Smc4V1NhU1BwWkw3V1ZoMnNkdDJP?=
 =?utf-8?B?OGFWSmpNRGtFdnplMm5MN201S1k5cTQrLzE2UGRzTnJBQmNWdk43UkRQT0ps?=
 =?utf-8?B?R3dTNURublliWW9CS0ZmQ2hOREJpY3pWd0tEN0lvUncramx2REs2ZkMxTlND?=
 =?utf-8?B?NWphL0t0dE5qeEhYbzdPRFJ0QTBmelJONHpKQXlBVkFJV1pGZlRMc3NuT3Az?=
 =?utf-8?B?YzNBUFpJd2tZMmlzaWtDU1VWWXpxUnFKZ1A4REZGaDFiK3JOV3psdkV6NGhF?=
 =?utf-8?B?TUlhNkpzaktNdTZUdlA1a2J6UnI0cEVRd1B3bXRPbDZ6YmhqeXl1RE9hQ2ZR?=
 =?utf-8?B?cXhIcTN2Ti9PMmVFbzdlTEhtSnFzeEF6cmEzN3FrYkszOVFJSGZhMjJTT05s?=
 =?utf-8?B?eFBweUxWd20zYnN4YWJDdG1yQWI3dHRhMmlQRXZ0RWsyQm1RQ0xNd00rUEhY?=
 =?utf-8?Q?DSY9xH8YCccOxwnNSa9WnTeGr?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0E801C91B3E5924AAEA700C70CFAD8B2@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff930dbf-0c5e-40fb-7b3f-08da73f78590
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2022 19:53:35.8957
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GwxQmhKbkh3lTYtmInRkW7DCKYrV9a20ikmvgdJEppOfVQcNUfyeh3ZiNwZinuGlz2KqjdS+5nitkSgzILATAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR05MB7590
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gQXVnIDEsIDIwMjIsIGF0IDEwOjEzIEFNLCBBeGVsIFJhc211c3NlbiA8YXhlbHJhc211c3Nl
bkBnb29nbGUuY29tPiB3cm90ZToNCg0KPiDimqAgRXh0ZXJuYWwgRW1haWwNCj4gDQo+IEkgZmlu
aXNoZWQgdXAgc29tZSBvdGhlciB3b3JrIGFuZCBnb3QgYXJvdW5kIHRvIHdyaXRpbmcgYSB2NSB0
b2RheSwNCj4gYnV0IEkgcmFuIGludG8gYSBwcm9ibGVtIHdpdGggL3Byb2MvW3BpZF0vdXNlcmZh
dWx0ZmQuDQo+IA0KPiBGaWxlcyBpbiAvcHJvYy9bcGlkXS8qIGFyZSBvd25lZCBieSB0aGUgdXNl
ci9ncm91cCB3aGljaCBzdGFydGVkIHRoZQ0KPiBwcm9jZXNzLCBhbmQgdGhleSBkb24ndCBzdXBw
b3J0IGJlaW5nIGNobW9kJ2VkLg0KPiANCj4gRm9yIHRoZSB1c2VyZmF1bHRmZCBkZXZpY2UsIEkg
dGhpbmsgd2Ugd2FudCB0aGUgZm9sbG93aW5nIHNlbWFudGljczoNCj4gLSBGb3IgVUZGRHMgY3Jl
YXRlZCB2aWEgdGhlIGRldmljZSwgd2Ugd2FudCB0byBhbHdheXMgYWxsb3cgaGFuZGxpbmcNCj4g
a2VybmVsIG1vZGUgZmF1bHRzDQo+IC0gRm9yIHNlY3VyaXR5LCB0aGUgZGV2aWNlIHNob3VsZCBi
ZSBvd25lZCBieSByb290OnJvb3QgYnkgZGVmYXVsdCwgc28NCj4gdW5wcml2aWxlZ2VkIHVzZXJz
IGRvbid0IGhhdmUgZGVmYXVsdCBhY2Nlc3MgdG8gaGFuZGxlIGtlcm5lbCBmYXVsdHMNCj4gLSBC
dXQsIHRoZSBzeXN0ZW0gYWRtaW5pc3RyYXRvciBzaG91bGQgYmUgYWJsZSB0byBjaG93bi9jaG1v
ZCBpdCwgdG8NCj4gZ3JhbnQgYWNjZXNzIHRvIGhhbmRsaW5nIGtlcm5lbCBmYXVsdHMgZm9yIHRo
aXMgcHJvY2VzcyBtb3JlIHdpZGVseS4NCj4gDQo+IEl0IGNvdWxkIGJlIG1hZGUgdG8gd29yayBs
aWtlIHRoYXQgYnV0IEkgdGhpbmsgaXQgd291bGQgaW52b2x2ZSBhdCBsZWFzdDoNCj4gDQo+IC0g
U3BlY2lhbCBjYXNpbmcgdXNlcmZhdWx0ZmQgaW4gcHJvY19waWRfbWFrZV9pbm9kZQ0KPiAtIFVw
ZGF0aW5nIHNldGF0dHIvZ2V0YXR0ciBmb3IgL3Byb2MvW3BpZF0gdG8gbWVhbmluZ2Z1bGx5IHN0
b3JlIGFuZA0KPiB0aGVuIHJldHJpZXZlIHVpZC9naWQgZGlmZmVyZW50IGZyb20gdGhlIHRhc2sn
cywgYWdhaW4gcHJvYmFibHkNCj4gc3BlY2lhbCBjYXNlZCBmb3IgdXNlcmZhdXRsZmQgc2luY2Ug
d2UgZG9uJ3Qgd2FudCB0aGlzIGJlaGF2aW9yIGZvcg0KPiBvdGhlciBmaWxlcw0KPiANCj4gSXQg
c2VlbXMgdG8gbWUgc3VjaCBhIGNoYW5nZSBtaWdodCByYWlzZSBleWVicm93cyBhbW9uZyBwcm9j
ZnMgZm9sa3MuDQo+IEJlZm9yZSBJIHNwZW5kIHRoZSB0aW1lIHRvIHdyaXRlIHRoaXMgdXAsIGRv
ZXMgdGhpcyBzZWVtIGxpa2UNCj4gc29tZXRoaW5nIHRoYXQgd291bGQgb2J2aW91c2x5IGJlIG5h
Y2snZWQ/DQoNClsgUGxlYXNlIGF2b2lkIHRvcC1wb3N0aW5nIGluIHRoZSBmdXR1cmUgXQ0KDQpJ
IGhhdmUgbm8gaW50ZXJlc3QgaW4gbWFraW5nIHlvdXIgbGlmZSBoYXJkZXIgdGhhbiBpdCBzaG91
bGQgYmUuIElmIHlvdQ0KY2Fubm90IGZpbmQgYSBzdWl0YWJsZSBhbHRlcm5hdGl2ZSwgSSB3aWxs
IG5vdCBmaWdodCBhZ2FpbnN0IGl0Lg0KDQpIb3cgYWJvdXQgdGhpcyBhbHRlcm5hdGl2ZTogaG93
IGFib3V0IGZvbGxvd2luZyBLVk0gdXNhZ2UtbW9kZWw/DQoNCklPVzogWW91IG9wZW4gL2Rldi91
c2VyZmF1bHRmZCwgYnV0IHRoaXMgaXMgbm90IHRoZSBmaWxlLWRlc2NyaXB0b3IgdGhhdCB5b3UN
CnVzZSBmb3IgbW9zdCBvcGVyYXRpb25zLiBJbnN0ZWFkIHlvdSBmaXJzdCBpc3N1ZSBhbiBpb2N0
bCAtIHNpbWlsYXJseSB0bw0KS1ZNX0NSRUFURV9WTSAtIHRvIGdldCBhIGZpbGUtZGVzY3JpcHRv
ciBmb3IgeW91ciBzcGVjaWZpYyBwcm9jZXNzLiBZb3UgdGhlbg0KdXNlIHRoaXMgbmV3IGZpbGUt
ZGVzY3JpcHRvciB0byBwZXJmb3JtIHlvdXIgb3BlcmF0aW9ucyAocmVhZC9pb2N0bC9ldGMpLg0K
DQpUaGlzIHdvdWxkIG1ha2UgdGhlIGZhY3QgdGhhdCBpb2N0bHMvcmVhZHMgZnJvbSBkaWZmZXJl
bnQgcHJvY2Vzc2VzIHJlZmVyIHRvDQpkaWZmZXJlbnQgY29udGV4dHMgKGkuZS4sIGZpbGUtZGVz
Y3JpcHRvcnMpIG11Y2ggbW9yZSBuYXR1cmFsLg0KDQpEb2VzIGl0IHNvdW5kIGJldHRlcj8=
