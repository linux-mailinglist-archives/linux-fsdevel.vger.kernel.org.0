Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0CD06A0FBD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Feb 2023 19:51:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjBWSvN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Feb 2023 13:51:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjBWSvM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Feb 2023 13:51:12 -0500
Received: from CY4PR02CU007-vft-obe.outbound.protection.outlook.com (mail-westcentralusazon11011003.outbound.protection.outlook.com [40.93.199.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 346413C06;
        Thu, 23 Feb 2023 10:51:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J9MVnSi/0dtYLjzOMqAyB46JduYj+YrzU5Lo9gzR01N6Z3t+Un7kAIFTLR24U1H5lZ+kUWWjCC2Lq0cFzhABSfuInK+jCG3EeDMFUWP02cnTQhwnp3FUuL4DOpdscu+KRpD5XJU9M2HB8FNeByNxAt2tLr9QKVlzAL2n7PlV4ERJZZnBccLMUFs27IX38ZTfkRZYN1JP/mdavLVPiNqLAn81i80MSSy/BjCJmv0W8JzRL/FTYPyMm6V0FrCGCGtGIWiLqz1hFAoptiit/IYTNwrmmdjbUq5rSmakPoIp6K1Am3mW89FZ0JLrSbTmivGhpecsaJe+gBVRUIhUn8pXUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KuHgbHj9kd14rlg2Z/BM9phm7iTsMI4pilNzjZrD0f0=;
 b=Jv5pan9iwUzHo4v1J7j/f8WE1BIlNuO+qocSIYcWx78iKFi2nmtSxuDPHUluKh0FnJbYoIJurYyCNapEBWgS9A5K/ndI+Tp0kRlY9DZXKZcWDuVaxiIHHssPpl5yqZDD9UKBFNJrpFFR5vTH8cXe6Ojdv5/q27s5ZaxWLGxidnKBRBe6VYyjfAQ8GdQRW7W0MuN5CaW8mrnXQQuuJDDoMNF7ceMP/YIdk1Mh3wFxaSf1F+8L1JKMT2X8QRbwUhl93sLP/m1pisChdz0kjxHXz3MaWEsqoWlFXj4ICRg4AxB1dZY435Xw5GEAiAtAYnnCtscIFZ02SBtMTjRrFQJu6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KuHgbHj9kd14rlg2Z/BM9phm7iTsMI4pilNzjZrD0f0=;
 b=P7BXGQ5r9nL0hv/Ul9fhraiW5qsFmYnQ6IcXn91/TKEYdkzfo0yttKljn1ejQpQiCe4atG3OFSpZWpHH5Izo3CqfBiMYuPw1+ShgwzsOganu9hD50sGvhNM/E3GioGNs65Bskt3Hv5UmO7DIagTmInbK4yFoNZFkNujxVqSriyk=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by PH0PR05MB7915.namprd05.prod.outlook.com (2603:10b6:510:95::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.21; Thu, 23 Feb
 2023 18:51:01 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::e9bd:ef2f:b71:8084]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::e9bd:ef2f:b71:8084%9]) with mapi id 15.20.6134.021; Thu, 23 Feb 2023
 18:51:01 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
CC:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
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
Subject: Re: [PATCH v2 3/5] mm: userfaultfd: combine 'mode' and 'wp_copy'
 arguments
Thread-Topic: [PATCH v2 3/5] mm: userfaultfd: combine 'mode' and 'wp_copy'
 arguments
Thread-Index: AQHZRyHq5XmoYIOsjkuDkcqzrjwGLa7c4ToA
Date:   Thu, 23 Feb 2023 18:51:01 +0000
Message-ID: <F3D3DA6C-0AEC-4947-9E2F-7A9773296A5D@vmware.com>
References: <20230223005754.2700663-1-axelrasmussen@google.com>
 <20230223005754.2700663-4-axelrasmussen@google.com>
In-Reply-To: <20230223005754.2700663-4-axelrasmussen@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.400.51.1.1)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR05MB8531:EE_|PH0PR05MB7915:EE_
x-ms-office365-filtering-correlation-id: 67534055-c53f-46a4-497b-08db15cee888
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /TF9XIUsr/JK1rmAARVyu6fe/D1sNP4G2OPJT9jElaA/ko3dQxpcRui4XXyBfqvR2WGFfRx/Cnc3b/l3l9nWUsPCWK3FqzLJTR96WsFFK3+Tvh/H1TH5xEbiJYegQpM602a/TIhvxYmaE03mbVvFE+GDqyuwGAyng3DQFlwSF52c5ilr+4/UkDmPZlLpuY/xHccke8eVtybLZFAmgwa3qOgpbMpy6XaiFpC0nuFp3Oz6Vvyu6MbgE4vGRiZ7U7iiCTV/lzN4kih2ODmv8OZUFqsCQcQCcyg4aTl13v0y9MiXinWN3sLWLRxCtm0RfoYocTeqlWkFt/gov8ALS0SH5nbylgxnLrvsq17/1B4+Yf6FrV01B80vL57yZTvU6HTRSdjGiQzpWUUSewkAxn1Dp20N46+lTTHEpk0uNiAaSI599M/CG9vzmYVs0eCnT45PgBmpTbfVXzMqkQKuQtaLLWe+ecwA2Xouu7CmSQ3YZtLu9LyN1rqyEi9ucefKE8Y31j8oYRu+hCKq1+h4anz8Q1xQRPLf6FLEZQkKGWaFBFMcrIFOI8DovsQlXJY/zeUndRbGhQd+zfeTMWv8tmosOxNZTdjOZ1PcMTA8W3xGokcmFVzMwgTouhBoc/v0pYjW8p0n7bSrOUtJzsaoTgzLByQ3BcrSg63pwT8jgIQt0RjoA9WYSJ/0N4qNIvDWbgaQqggIuYq8cVHGbWjyWWGT6pJSBGpAU8SEN44fD4qm6OU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(366004)(39860400002)(136003)(396003)(376002)(451199018)(36756003)(33656002)(86362001)(8936002)(7416002)(2906002)(41300700001)(38100700002)(38070700005)(122000001)(5660300002)(71200400001)(478600001)(316002)(66446008)(64756008)(76116006)(4326008)(6916009)(66476007)(6486002)(66556008)(66946007)(8676002)(2616005)(26005)(186003)(54906003)(6506007)(53546011)(6512007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SEEvbFk4QU1BUWJZQnAxVWIva0VXU004SXprQ1k5WWc3WUJ0c01ucFVlTmNI?=
 =?utf-8?B?SzJGUkk3a216dDlFaEFjTWVQNHpHSHlKbVFnMFVhWUY4bENjcXh5cmhMWEtw?=
 =?utf-8?B?ampybm1TdEhnWkVSQnpOTDUrOUVNTk55dkRHQ1VyMGNpcXY2RGdxeTRxdWRq?=
 =?utf-8?B?SHNYNTV0dWVnYUJ4K08rSVlEZXUrVXdicTU3TTZISXpkckhLdkxkeER6T0Mx?=
 =?utf-8?B?amZsVmVLRjRhS1VQdkxKWXhSZlRvOERtSTFuZkFVSUVYTzlzMXdPKzJsZ2NV?=
 =?utf-8?B?YjR6bFRlcmJGb2hyL2xjUGc4QUVvTDI4U2VoS1NiclB0akVyL2M4bVVOR2Nr?=
 =?utf-8?B?ZTVRNXpvT3FYajJDL2wzQlNjclNQcUJjWExUTG5UNG12emFpOXg4NHdJb01u?=
 =?utf-8?B?V2tqUTZMMFdDT1FNTVZoSU9EOXEzTkx1MVM5YW5Mb05lWWlERnZ2aktOb3M5?=
 =?utf-8?B?d3lLQ0lkN2Y0OER4dEZsSXpxdVY4M0F1cU90anJzN2dQTTVPUEd4eklMdm1J?=
 =?utf-8?B?YVBFRXVGQVNCditVZ0VTLzFuQjV1MjhSNUl4a2t2T1J1OGFGQTRnQWNhdXJU?=
 =?utf-8?B?TklZNnNGNUdUVG93cFRka2ZrRkpadEY1QW1Rd2ZRb1ZKWXgxREtITVZOZ01k?=
 =?utf-8?B?dEpmaGdQM3JuTThMMWlPOUFrUFZKQ01Pa2ZnaHVvd282WjYwbWF6TERmL0pR?=
 =?utf-8?B?ajkzZGgyQmNRcjhuR1NJODdIdlM1N3BQZ3FYeXQrVllwMkVJTEpYZzVqV2Nr?=
 =?utf-8?B?dUdEbWJKaE9GRytBamJHc2pZS2JpbGs0STBLWUdUZGl1ZTZHeE9weURjcnpV?=
 =?utf-8?B?YTBmMCtjM1VIN1dJMUk5b0hNNzNGM01Wb21pdGlHU29UVi9Jb1ZRWGMvY2xY?=
 =?utf-8?B?bFYrUlA4aEdXazdibTFSUk1YUnp4VHNOTzlMZTR2OTY3MDhrenVScXBLSEFp?=
 =?utf-8?B?UmhxWW1TTVpXREYxTWhaZUJQSDFWOHQrUlQ1M1MxeVRlVUFuTmtoZm8wUXdx?=
 =?utf-8?B?NFNmZDh0dTFtVUZ2RThWS3RCUkd1aUF0d1JOUUtqa1lFYkNraUViV0I3Q2Rz?=
 =?utf-8?B?aHFTTlI5TnNlci8rb2IvYkdVa2t0eTVHWG9RemYxSmRWQUdoeE5WS0VVNytJ?=
 =?utf-8?B?UWtiQkJhYUxUU29IMVJVeFo4LzVVaHd1NTViV3BwZERmMXJnbUVQcnZRamIx?=
 =?utf-8?B?c1YvTHJUQWZBd0hxR0tpbXNyWkl0YzRlWmttTXlJUTU0bkRkNEk5MDlsb3E4?=
 =?utf-8?B?Z3FTbk5Jb1N6NHRwVlZwd2NUY3FzdVRKZXEzWjFmb2pac1RoQ2pXTDB0bUth?=
 =?utf-8?B?THBDcVB3U1EvNlVNczhHdkNVUVlXUlM5bnh4VE8rNTVEL1JRNjIrWE9MYWdN?=
 =?utf-8?B?SlVxZEd0N1QxaThCYUU0SkJSSDV2U2tRRVEvbUVxK1FDam1GR0lIQU9ZS3Ni?=
 =?utf-8?B?UXR3RWJOTzhKTGFKRyszTVlGQ0k2ZTA4Yi9VY1Jmd1g0dCtaY1lNRGtGcHNW?=
 =?utf-8?B?TXZ5SUNkYytYa1l6dGpJcGd5TkdYYTBHN3VqdjBzVnlJclZZdWphakF0SGNK?=
 =?utf-8?B?T3BSdG5DWDlPTU5Sdlppd3Y3ak51U1pSTm9uZkJMMEIwVFVQNWV5YkNCRERI?=
 =?utf-8?B?U0k0aDdrMEtmUzJKd2Z5YzB1d2gza1NQMjd1QmhseDF4UUp4RGFvc3R3UGFF?=
 =?utf-8?B?Q1JtS1RGMUhHNEhYWDNvRFgwOEpvajEwMHBhM2FVU0dPeU1vNVlCQVpXYjFh?=
 =?utf-8?B?NXpJdmt3bUZqeE10WGU0K0V5L2t0TkhjWU1nZnVQNVBMZjg2ZEc5VTdKSlJr?=
 =?utf-8?B?cTFVTE84VHk5ZEl0S0VVZU8rQTYyTHRaUWJuWHdIaGQ5clQ2MU14NHB6VDZD?=
 =?utf-8?B?NkU0QlVOMmdRY0NzZEovaGhFNHJiak5KUU4vbGNyWmJmTnV0eW1zLzRHRzV4?=
 =?utf-8?B?UzhFclcvT1JIM2xMcFplQ1VnVVNMWE5wNWtkUnJ5SEc0RE5NUUVTY2lENnpj?=
 =?utf-8?B?Nk1YN0xVQzVDUkdHamZLbnZGNFYwTkM4MktyQXM4TU9TWW1GTmk1ZlpqS2dN?=
 =?utf-8?B?U25iSDJOV1Y5ZEFHTEx6a0dTaVVpYXcxYUJuOGhWMGhtcGNhdDMzS1ViNU5V?=
 =?utf-8?Q?QuQgsIoFJxjj5DeUyY6E40T/Y?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CCB6D1A0C500BB4B887665A4246FC022@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67534055-c53f-46a4-497b-08db15cee888
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2023 18:51:01.1593
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VHs0xgIIfAmTYDHEdu2vPTsTKtyvhSL9HKdmGPlGHUU/3VBE9l1s2yaM/fbpTcNpLvo4eT948bxiaYsmk/9TOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR05MB7915
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

DQoNCj4gT24gRmViIDIyLCAyMDIzLCBhdCA0OjU3IFBNLCBBeGVsIFJhc211c3NlbiA8YXhlbHJh
c211c3NlbkBnb29nbGUuY29tPiB3cm90ZToNCj4gDQo+IE1hbnkgdXNlcmZhdWx0ZmQgaW9jdGwg
ZnVuY3Rpb25zIHRha2UgYm90aCBhICdtb2RlJyBhbmQgYSAnd3BfY29weScNCj4gYXJndW1lbnQu
IEluIGZ1dHVyZSBjb21taXRzIHdlIHBsYW4gdG8gcGx1bWIgdGhlIGZsYWdzIHRocm91Z2ggdG8g
bW9yZQ0KPiBwbGFjZXMsIHNvIHdlJ2QgYmUgcHJvbGlmZXJhdGluZyB0aGUgdmVyeSBsb25nIGFy
Z3VtZW50IGxpc3QgZXZlbg0KPiBmdXJ0aGVyLg0KPiANCj4gTGV0J3MgdGFrZSB0aGUgdGltZSB0
byBzaW1wbGlmeSB0aGUgYXJndW1lbnQgbGlzdC4gQ29tYmluZSB0aGUgdHdvDQo+IGFyZ3VtZW50
cyBpbnRvIG9uZSAtIGFuZCBnZW5lcmFsaXplLCBzbyB3aGVuIHdlIGFkZCBtb3JlIGZsYWdzIGlu
IHRoZQ0KPiBmdXR1cmUsIGl0IGRvZXNuJ3QgaW1wbHkgbW9yZSBmdW5jdGlvbiBhcmd1bWVudHMu
DQo+IA0KPiBTaW5jZSB0aGUgbW9kZXMgKGNvcHksIHplcm9wYWdlLCBjb250aW51ZSkgYXJlIG11
dHVhbGx5IGV4Y2x1c2l2ZSwgc3RvcmUNCj4gdGhlbSBhcyBhbiBpbnRlZ2VyIHZhbHVlICgwLCAx
LCAyKSBpbiB0aGUgbG93IGJpdHMuIFBsYWNlIGNvbWJpbmUtYWJsZQ0KPiBmbGFnIGJpdHMgaW4g
dGhlIGhpZ2ggYml0cy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEF4ZWwgUmFzbXVzc2VuIDxheGVs
cmFzbXVzc2VuQGdvb2dsZS5jb20+DQoNCkhpIEF4ZWwsDQoNCkkgc2VudCBhIHBhdGNoIGEgbG9u
ZyB0aW1lIGFnbyBjYWxsZWQg4oCcdXNlcmZhdWx0ZmQ6IGludHJvZHVjZSB1ZmZkX2ZsYWdz4oCd
Lg0KRm9yIHNvbWUgcmVhc29uIGl0IGRvZXMgbm90IGFwcGVhciBvbiBsb3JlLCBidXQgeW91IHdl
cmUgYSByZWNpcGllbnQuDQoNCkl0IHdhcyBwcmV0dHkgc2ltaWxhciwgYnV0IG9uZSB0aGluZyB0
aGF0IEkgcHJlZmVycmVkIGluIG15IHZlcnNpb24gaXMNCnRoYXQgaXQgZGVmaW5lZCBhIGRpZmZl
cmVudCB0eXBlIHRvIGF2b2lkIGNvbmZ1c2lvbi4gU2luY2Ug4oCcZmxhZ3PigJ0gaXMNCmEgdmVy
eSBnZW5lcmljIG5hbWUsIHBlcmhhcHMgeW914oCZZCBsaWtlIHRvIGFkYXB0IHRoaXMgYXBwcm9h
Y2guDQoNCg==
