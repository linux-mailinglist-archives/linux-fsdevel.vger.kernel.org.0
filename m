Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF5006AD44D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Mar 2023 02:55:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbjCGBzE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Mar 2023 20:55:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjCGBzD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Mar 2023 20:55:03 -0500
Received: from CY4PR02CU007-vft-obe.outbound.protection.outlook.com (mail-westcentralusazon11011004.outbound.protection.outlook.com [40.93.199.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B76214109C;
        Mon,  6 Mar 2023 17:55:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tt1+Ky4M+MQmI4vZs3IMMBYeZb1i0Yban4f78LWZAtYmu6KxLlfBgGM8hGteVNLI1LlgR2lDrnynk35SfgRYdrPx+rbvCb2/eltH9wBC1Gg/9qonpx/6on/6ImIYC+RSw5mrEHn9i3EdgyAPifFu9OSWuVtbrd63w0tXgE6HsmcuMDRYApCtydBAG85wQ0MZoNU3NAniQoMzCDkzM7DZMKfVY4ZTr2P3ist1eelCU2p4in8tNjNMoFFyrGU8xAYSW3jt0M62ZESdfPNrKo3xeblb95IQqEffJqCkws74XDnOrDveHHMrGYeRHO6RWGTmvuaZH8zqd+yPErYSh/7koQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nTx9fZ28aEdvNCT70kIxoJYZqvUxe0TeIYYdP0lp+Kw=;
 b=LWczsd1eUYTIjLBZyn9V8q7O22ZIVi96DsOTIHx/tTMjifdkUFUSF1rfpjgK+B7McBofOTy8On4xEdPzchopQeUZtGmvoPHIiXtmYh7g41C5aFg9OfRHcdQU4h15QB9SK9ibTcgLCEJP72bCMWgWFHTP6OEAKLjh6ouS93ozNtaZ8sJmB85mpd7SG3hFsrTjxo94xmOkPyI8DXxNwHHCSn4deBvuwViIysyjNPbFToD6bRhMdkPGLbO7xa4sFcz6jtYMHfDmLCBsDv+iIKTHZ/N7hvrBKGo+2TZC5/XBlsBd7SbPaeW3oDya0hbcKsOR3d1uhsentPCTE1d0+hry0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nTx9fZ28aEdvNCT70kIxoJYZqvUxe0TeIYYdP0lp+Kw=;
 b=hQSSCMsBSKr+kkQotv9oJSLyQyxk6+zK59yPI76LGJU98uaSWW4br1sK4SS4GZ39jmYJdmIuQEjZuOA2BVmF11ToZ+Kkv5vhq+P/k17H6XIAnAIld2HJ3clHXomYhDS6nAM8e5sucxJhai0YM/9AI4pk+5Nc6rlZHp/Zs8rFO5g=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by CH3PR05MB9809.namprd05.prod.outlook.com (2603:10b6:610:126::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Tue, 7 Mar
 2023 01:54:59 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::e9bd:ef2f:b71:8084]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::e9bd:ef2f:b71:8084%3]) with mapi id 15.20.6156.028; Tue, 7 Mar 2023
 01:54:59 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
CC:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
        James Houghton <jthoughton@google.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v3 3/5] mm: userfaultfd: combine 'mode' and 'wp_copy'
 arguments
Thread-Topic: [PATCH v3 3/5] mm: userfaultfd: combine 'mode' and 'wp_copy'
 arguments
Thread-Index: AQHZUH4WbMp2mEvwVk211rdYxr1H5q7ujpwA
Date:   Tue, 7 Mar 2023 01:54:59 +0000
Message-ID: <0F14FF60-BE23-4946-B5BA-3786251ACB5D@vmware.com>
References: <20230306225024.264858-1-axelrasmussen@google.com>
 <20230306225024.264858-4-axelrasmussen@google.com>
In-Reply-To: <20230306225024.264858-4-axelrasmussen@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.400.51.1.1)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR05MB8531:EE_|CH3PR05MB9809:EE_
x-ms-office365-filtering-correlation-id: 4ecf5abd-54ea-489e-bb1a-08db1eaef542
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0/vmcAi8NZiUaBMN0qsE8oYIJ98t0FYAa5KhYsN5gff7rvjYN7D2K+9d/CN++F3hbAu+k18uIYQ32GzGcjokW2+MuFp42I2uBZ/bWo96cu2n5dsBQkirNHd6sMBLZcRS2ewjtYqPnK3pZTGjhvHP8MhDHHutb2uQcXdLys7OjkjyFcOGzLB2hUfLVaHOy77c+db/mhPSUdE6tuHZ8oZBEvhPUaxpHFXEJRUpPQ8hDsk8Q9BmvL7Yp+U+TmL9HqfUTC1fj740VOCCmhWngqBcFR18nvSSiLWhoEZzEei34KgQUMdRueSc7e4orzSmMd96y7XQ+2dc2SBX/EH50/Dh4ipJOzhpJSB0Wic572haO1BvtqSGB6ks/Uw9Wyeb6Qjk4Wl0dV6+8SQ1k2LVxNfVrSvTOhmLRIwBrseU4dcWpT+joqVn9IqHuyjtJ0pASoPYC+1Tq1Ulj00gMooyOcWwjoCr5V9siyBgQZ7lk/NCLnxUjck00WkCiaaQhUz03BdouzlOV0PxRYAa8mk/g5oo1msB2NR0JKyqgP7KPJ6zip1xYP/7vnjstAg1bSwnJp7aJgpET6/MagbYOpdOcUnnuWdTaxq2hZZz7NTXDQPMvw/aUMyr+DCOqGDux9ICmoVjkrz1IatAxjAM32Di68zxLuvcMSDnkhh1u3nHcCPeKpSNdloG6ihwGiuSQTM/it1Ao8Hoa8OJc1J3IBt2g+SOWuhB2YkbC/RJ+IW1D7uGjjRomnMxFYg8qhcr+Vi0BJKVQZFApj6w9swtTR6MlSTv7eps6WBYVeEOwiOWsoo+IAc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(396003)(136003)(346002)(39860400002)(366004)(451199018)(36756003)(33656002)(4326008)(76116006)(66446008)(7416002)(41300700001)(66556008)(8676002)(8936002)(6916009)(64756008)(4744005)(2906002)(5660300002)(66946007)(38070700005)(86362001)(122000001)(66476007)(38100700002)(71200400001)(6486002)(478600001)(54906003)(316002)(6512007)(6506007)(186003)(2616005)(53546011)(26005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cERFTkpkUFBFMnZwb05UL0VuSTI5d2syVElNRGowUUhJT1JmNkFHSHlwMnQv?=
 =?utf-8?B?K2dxeDgyb3pabXdFSlZhYnNQcTV6UTd6RUVJSGVJZ1NNQVNUSU9YOVdFdWVw?=
 =?utf-8?B?Mng0MVQydlBLUHd6Sm56aTA5Y2RSUVhzb0w2bGZ3enNCQmk1MmduVVdVWG5o?=
 =?utf-8?B?bUpabkhlV04zcFh2Vmc5L1orRDc4RjZNZ3lBL1UvVXJNeTBTVTVvRTZIWGRi?=
 =?utf-8?B?RCtWWFJKM3lndXF0NExxa2hlc1JnMnJQckRCQlZVelkrZldWcFVUQ1VRMG1N?=
 =?utf-8?B?VnFvekJtRkRlRmkrWlZIeFBCYTdoK2V5UmRmb0U0M3BUQU85bHQwTDErbHFl?=
 =?utf-8?B?Y3FEMll6b0NUdklrYnpvekljNVdXWmJsVzNPdGJDeHQ1QlRhQmIwQ0hlamF4?=
 =?utf-8?B?ZUJ3NE9hR3d6Vi8wdjl3U0pheWNHdnVydWJDRDJxL2NiYng1T1RNV3JYNU9p?=
 =?utf-8?B?ZTNETEpTVTVqWUY5YmpYcXJGbmptWUFqOEhkRWRhOEt3Uk9oLzRKUzZ4UWVU?=
 =?utf-8?B?aDMvTGhEMWpqcnJBZ1pMWHBLMDJhU1B1K0VRbDhmWjZkdTQyVTExWXVDN055?=
 =?utf-8?B?blcwcWkxM1hxMzFMdzlwc3FhYUN2QnlVTjdJN3ZnLzhvc3JheTdPTUZTVFAx?=
 =?utf-8?B?NGQvYWVnTVZiWHJOMzVwZ3NzS0FrWmpUY0k3WEMvZFFwOU1xclRFVlNwRG5l?=
 =?utf-8?B?S1p5NDBvaGRMcE1RLzQ2ZUYyQlZrS0MrNmN2K0FEbys4NGRJN0VaMkJtV2lM?=
 =?utf-8?B?cUlGMXlhWmRHS2pkRW9EeTl4MXpzZ0NYdFBUN05TcGV2c1VTZ1g1a0JrSHhp?=
 =?utf-8?B?U2NlVmtMQzNDcVhJU3Y3djUvbVV2dGw1VW1kSlB1eVQ0VWp0MHplM3ZMNXVk?=
 =?utf-8?B?Uk9jSWZKOHFQTmlRT0pQdUFpU0FuTTNPVmtRMHBSakQvU1EzbHBXVUpoNnAr?=
 =?utf-8?B?VkQ1VU5FdWJDYUYyU09mL2ZVK0ZXdU9odHM5aTFJcGJiWEl6NkxscG9MNGUx?=
 =?utf-8?B?N0lHMnJMNW13cDhkeFZtR0xMRHJ0L1FFWU9vaExJd3UzcW1WWXo0WWpGbHcz?=
 =?utf-8?B?b0VhVU1VK3Z6cHZ0YXNBczZHYWtITnVoNEJTMmt3L0ZGaDR1czdKTzdXeEtz?=
 =?utf-8?B?OGoyTHlJRnBwRzA0Zy9SKzl1aE5sVlBKZk1sNW51Zllja2xMUFFGWWdNQzV4?=
 =?utf-8?B?NlEraERWM0Rtd2lVenF0bjRMUFcyK3hiTXJVUWNiRXBYODRmNWdZZ0FBSEtI?=
 =?utf-8?B?dWdNc0g4YnBCSWczNlNVUnRJUGdkL0drQ3FoTGN3aVdTRWR4UmFOYUNmYVNG?=
 =?utf-8?B?TnlmcHJZT3ErQ1kxdzhlcXhHV1ZBRVVpc2VaZXFxdDBIUnJFM1R5cFpiRllo?=
 =?utf-8?B?dVpuTXRmaTVlZEFyZ2pUNUNJd1o5NG1rYmNKaWx2TFltRGlGaFMxcjhJTFd6?=
 =?utf-8?B?cXROaVBMSWJVUms4d2NrK2MzWHpFc25RdUVtWFBuTkxUdVl1NU85VjAzOGx1?=
 =?utf-8?B?SE81WFExMW0ySlRQMWFwdVY0aTFSNUtVaWlUZjcrYkEyWGRuMzY0MWxCSEN0?=
 =?utf-8?B?ell3R2tPemwycFhVdUg5aWlrZzkrcVU0aThGa2FvSS9EdU1aSGFuK1lNazA0?=
 =?utf-8?B?NHBpREp6VHdFYklUbUV3RWllejgzbmlZUnFZdUJCNndCUXNoV0cxWld6bURw?=
 =?utf-8?B?YTdKdUwyMk56emNDYy9tSll2ZTdBSVF1VTZCSWxIU29vVUd5RktQbHlDL05a?=
 =?utf-8?B?Y0YvaHBUOUp1dFJrVUs1MEZ2L1h1RUp0RXdzUkNtY0ppcEFhNHJCMHNzMk1y?=
 =?utf-8?B?WTlzNnJjR3ZtZERQS1hXaVZNUDFUdGZJc09LMVA1UG1QQnR2N29DRGVaUEFo?=
 =?utf-8?B?cFYwb2FvMnNVYzdSU3VVRmtYb2dJVGxZRDR1TDhjVTZPVm56allEcjFmdFIy?=
 =?utf-8?B?TnprWnJwSytScS9zSXhObWtTclBtaVBQRDl1L0xVcVlPNEhacTZTbVhtRXNX?=
 =?utf-8?B?MkRxMGxLMURId1JSYkNRci9VYmhXMzhQczJ1dXF5Z1l3djlkSVpTVkxjU3FF?=
 =?utf-8?B?R0pMWDh1TFRRV0JVR0czaFNhL1FOUlExMWw5cWFkY3FzeHd2bEQzMkVBRjVp?=
 =?utf-8?Q?emuNmFM+UpInijZKjHnbinXIC?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <574C7084E945584DAF037365D2734AF5@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ecf5abd-54ea-489e-bb1a-08db1eaef542
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2023 01:54:59.0678
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fVx5ZWjxtvvq5UyD7zaLIr+oCkOmaa4xEKmeEKHAyUMe9zpzg5VDf68PkyHsz1+kXTw4naTDCdaf0Ommb/fDCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR05MB9809
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

RXhjbHVkaW5nIFBldGVy4oCZcyBjb21tZW50cywgTEdUTS4gDQoNCj4gT24gTWFyIDYsIDIwMjMs
IGF0IDI6NTAgUE0sIEF4ZWwgUmFzbXVzc2VuIDxheGVscmFzbXVzc2VuQGdvb2dsZS5jb20+IHdy
b3RlOg0KPiANCj4gQEAgLTEzMSw4ICsxMzEsOCBAQCBzdGF0aWMgaW50IG1maWxsX2F0b21pY19w
dGVfY29weShwbWRfdCAqZHN0X3BtZCwNCj4gCQkJCSBzdHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3QgKmRz
dF92bWEsDQo+IAkJCQkgdW5zaWduZWQgbG9uZyBkc3RfYWRkciwNCj4gCQkJCSB1bnNpZ25lZCBs
b25nIHNyY19hZGRyLA0KPiAtCQkJCSBzdHJ1Y3QgcGFnZSAqKnBhZ2VwLA0KPiAtCQkJCSBib29s
IHdwX2NvcHkpDQo+ICsJCQkJIHVmZmRfZmxhZ3NfdCBmbGFncywNCj4gKwkJCQkgc3RydWN0IHBh
Z2UgKipwYWdlcCkNCg0KWWV0LCBpdCB3b3VsZCBiZSBuaWNlIGlmIHdlIGNhbiBiZSBjb25zaXN0
ZW50IG9uIHdoZXRoZXIgcGFnZXAgcHJlY2VkZXMNCmZsYWdzIG9yIG5vdCAoaXTigJlzIHRoZSBv
dGhlciB3YXkgYXJvdW5kIGluIHNobWVtX21maWxsX2F0b21pY19wdGUoKSkuDQoNCg==
