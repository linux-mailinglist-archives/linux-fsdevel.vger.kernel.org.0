Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C660955E8DC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jun 2022 18:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346140AbiF1Oeg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jun 2022 10:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231822AbiF1Oea (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jun 2022 10:34:30 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2128.outbound.protection.outlook.com [40.107.94.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63CD22AC7F;
        Tue, 28 Jun 2022 07:34:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E6c6jB6ilcTPMD6P0gxUkfb+FxVaKUOrGyz/GE82Oc3LMz0U7PKdm2eKZNBRcbOA+82StLXuFV2PO6tWTPUuoscdc+CZ+tTdmH/IofEBURPdJXcWy88rZrR59629HbfPakn0om9/RSDWALpe+iOWOcGdPJWbqOGaO1mbIwZ+xgXcGRMBFqrR0lPHCN77L5+zT8t5Gr73LfrqA1/0mroQkZ6F8roZA3hTwBIFIEj5J4MV8aLfkIa5QwLbXSUqXB7gc5iw8Hr3hNkWjDoVGn6EqHCsrx3eXfLG9RHpnme8AE05lRIPlNJN+JO1ixTczpM0VwDaIT07pwXUD2DLVP/vdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TZKcvVLL7kqPtR1Lo3RFR2gtEzXOQiFNO/j8ZQAidYQ=;
 b=Tyh7cc8CERF9igfJZBREiF37YUS137axmanv7Yv/D4HemkCWqOQdAteZR7Z+Xqep//eMjLrX6jN0xLraSJ5mXTGIfHrCPCC4ZRL3w2TIUuuRFZlbXOv8NQBMh4YuwGfxeLT+B+XGnTvxOzqVhKSXUodt29bWyoNu05chYnO0m0tzZYvQuFh1PYGXrxRsZyBhdx7NjUXMONNThU7m1+PRJhrRLp7IMvVww3wkjpFFtZdNuACBk5knsZAVrfGgTf/tEbPQJ4ZoBlHCApl53xZvfeEPOaM38POEbK0keesTwE8HLrs3agIboi2U4e0/fSf9RnfgybAbq911ipEem6nr3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TZKcvVLL7kqPtR1Lo3RFR2gtEzXOQiFNO/j8ZQAidYQ=;
 b=J7HA6yrZ/2CHzY/TKPPpBqODT2yR8mD7upKIDVljAf5XPWnmGOqXXFUw8wZW7AVNwlb7QrRfAr/UUx0C33X4tzhIMJTB5dUX0/PWO12WsGtaq+e7XqKTa9NPOlv0DwFPw1af5zZN3k8lrH5aJ2qgq+LfIKt5UETILlEh1dCYvLs=
Received: from DM8PR13MB5079.namprd13.prod.outlook.com (2603:10b6:8:22::9) by
 BYAPR13MB2501.namprd13.prod.outlook.com (2603:10b6:a02:c9::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5373.10; Tue, 28 Jun 2022 14:34:24 +0000
Received: from DM8PR13MB5079.namprd13.prod.outlook.com
 ([fe80::85b8:c87:1b86:40b1]) by DM8PR13MB5079.namprd13.prod.outlook.com
 ([fe80::85b8:c87:1b86:40b1%8]) with mapi id 15.20.5395.014; Tue, 28 Jun 2022
 14:34:23 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "Anna.Schumaker@Netapp.com" <Anna.Schumaker@Netapp.com>,
        "raven@themaw.net" <raven@themaw.net>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "SteveD@redhat.com" <SteveD@redhat.com>,
        "bcodding@redhat.com" <bcodding@redhat.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>
Subject: Re: [REPOST PATCH] nfs: fix port value parsing
Thread-Topic: [REPOST PATCH] nfs: fix port value parsing
Thread-Index: AQHYioWJZklspGquU0m3p/tguyzN061k40UA
Date:   Tue, 28 Jun 2022 14:34:23 +0000
Message-ID: <cadcb382d47ef037c5b713b099ae46640dfea37d.camel@hammerspace.com>
References: <165637590710.37553.7481596265813355098.stgit@donald.themaw.net>
In-Reply-To: <165637590710.37553.7481596265813355098.stgit@donald.themaw.net>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4d523f6e-3a65-47b6-46c1-08da59134bda
x-ms-traffictypediagnostic: BYAPR13MB2501:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C9FoDDpa0+u5kwfdaPKkadWEGGVj6OghyJAyKfNDQeVCv1PZ39/ePmEIYql/5L5ebXCV0GtAH2rAQBF/T238piXdlg9N+XCal0siJclXgoLh+hnqWYka2dQewxiQjelGLMtwg6o54q+7U4NOvfPU3bQKn8lnQCqwPuoOe3lArDvaPfKDr8bacB87bZpV0pQMErIXuwQ6V6NT7IeJVxmhdvVe/NCDoOZlmu58Z1VliTuYKIY+UthWsevFQWVrzsTtPBYEQAZ/Dv9RyoPSQW2q8JjF38S/oAKeZwj/iSRvQuGoZrmaXRiVDwH0aOYSpeHD5tiGD27Dcx30A9Z2KBNJIHQ/DB7eUJWuoxq0zYUAXQRR/PWQR0feiMjWdN0fktC7Mb0VMWUD2CD+3dd0oqfDDjYbbfoP1Hay1s9qnmoYkgdeVnIP9xIee4WeGF/duYAkjpzllQLV7fqgyl92jwmKzTualvLBg9R6GDlOkC0pWp2Iz333fsBkrN80LHtoFxgN2Gd8daOyl3041mtoAjxWh+I8zH/Rd9qLPp8tV8Q8brCUQmhNrL+hfj9jL2OuMPLCds2gj32899SAhiuckMa86rst0oi7Ea+Z6V8YvG5WsjdqU1aOC9k+juCNtPm4baVz5zLpDMd2/fVv6j1c4mBxeU9Zyg6KmlMGHUjjLAr4M6Q8GsN1/RKYNV/5caFp3XYENk5soKkBwMRcsThD0Kwwqcx3MLn3bImfKMupX+Kj5I0vBpYvYhCeKSX+ErL2/TiLxkk4TXE+4dEM8HGvbSz/vkBb2mTC9Z6knIESB3Ta2ukUn3W1iEMeLF07KyIKrlyU33SzKMNhgsNv+ipS8W3LV9lixjULYxrmeo6Si9S4V2g=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5079.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(396003)(346002)(366004)(136003)(39840400004)(5660300002)(66476007)(66946007)(122000001)(110136005)(66556008)(36756003)(66446008)(76116006)(2906002)(64756008)(38070700005)(83380400001)(54906003)(41300700001)(8676002)(91956017)(4326008)(6486002)(6506007)(8936002)(71200400001)(26005)(186003)(38100700002)(6512007)(478600001)(86362001)(316002)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R3J6aUs0VHRXTUlsNDFQRmlhRzJxOWM4ZS9JVVUwL3FlQ2xvQmxmMTI3cTF3?=
 =?utf-8?B?NzlQRWhTeUpGL0gvTUQ2SDJTSC91Vlg2SVlHWEs1dlQ1QWsveE9rTTRmd0NB?=
 =?utf-8?B?T0o3ajVWUnpPWHNaMTNkWk42MlRCdHlYR1duNk4zYllCQ2VMNENWQ210d3E5?=
 =?utf-8?B?dko2MHpvQmZpNldjZkk5U01KeUl1S3IxazF3U0RnUUxFQzlTaytzMWtiTUdM?=
 =?utf-8?B?Vk9pendpN2M3SlorMHlpYVdWemJ0UkVlZm8yazNnaTFYaFZJazZYSmI5REN3?=
 =?utf-8?B?L2NoeVgxWVhQK25KYVU3M01xbTlGRVBkZGJlMTBQVWlubENyVEVKUzZPWTd6?=
 =?utf-8?B?QUZxdXpaZmJYZ01yNy90SVZTQmV5MDNKdHZ4K0lseVh1TkxhRmhITnk4aldr?=
 =?utf-8?B?clRGZEJRM3RUWFdHVkYva251UW84RnRMWUN3eEwyTEZvR0ExVXNPeHJtV3RK?=
 =?utf-8?B?ZmRhMXd4NzBxck1vQzN5cFM2OEp0aVE0YU5KYUxmVk8xUHdjR0JPL3lhS2ty?=
 =?utf-8?B?NzNEVVN1OGpyOFZucFpoT2RCenk1UEdpZ2ZqME5WQVZUeDJSMFl2ZEE0NWZz?=
 =?utf-8?B?eUkxbml2ZmYwWmhvMHoxZk5wWDREU3YzZzZ4ZU11Nk4rcktoVUZJMC9VRk5N?=
 =?utf-8?B?cCszSXpTZy9WMUZDNVlWbVphT25wUGdIdUlyRjhGZEdIMWlWSUpHSmhHRzlw?=
 =?utf-8?B?a1VLNDZjUWtBajZ6NFVLcmJFK1A4QmdjQi9TOGtDNkVQSFpSVWZCOTNqTngx?=
 =?utf-8?B?S3NSVk1PR2xhNnU1OWZ5ZXZTNUhibGNaZWc5YzJ0bUdzM3I2Z1BVcG1PQVkx?=
 =?utf-8?B?MWRBenlYL2RBd3Y0eHpGd2dtRmY2V3hPVlJHR2w5U0JqSVE1bWw2MTZtM1FM?=
 =?utf-8?B?dHZRTlpnZ2c4Um5NeFRRVFpsZlpZakxQck1hVlpPaFBPejJNSFdIby80Y0ZV?=
 =?utf-8?B?Y1BKekhEcmxKaHQ2dFUxRDNpSzdVenJya29CeWVjUUw0T2hLV21IcVczQ1lE?=
 =?utf-8?B?OEtXUDFYZjVpSm50Q29BRGRLaDE1b3ZYOW1EaUdkM3R0S1c3aTJ1dlpRVkwv?=
 =?utf-8?B?UTdDUVBwcmpTaTFqR2ErOFlLMWRRUFIwMFJMRHFNN0tRNzBSRzhONTF2eUpD?=
 =?utf-8?B?ck55amU2bEd3SDYyRFhJaUtyeHVQUmdJNVE5NkVUMSs5bjdjc2RlckR0N1U0?=
 =?utf-8?B?dWd4c3RIems4eFpjWVJUNStIYWlWNDVxZzJyNE0wby9nN1lHUXZjS1RINDJu?=
 =?utf-8?B?K3RBeFZkOWNuTnpRTW5Vem9Ta3VQNkN5YzJNL216Qjc4Umg3czBSSmFwRTdj?=
 =?utf-8?B?K2Vuc3FhSzZTbHoxL3JMZmNvUmFBbUNXQ1ZhRTBXeXhkNHlZWk40VHFRZzYw?=
 =?utf-8?B?QzQ3L0tOVXBPVUFTVVl4aXREQlN2WGVqMGpxTW9waVVoV21iRmg1aGFEQUNS?=
 =?utf-8?B?QjFibjV0Mktyd251YXBiUmtsMVFneDE4bUNvVFpPT3FIMW1JNkw5bGhNSXQw?=
 =?utf-8?B?Nk1YWGFCVGdPaTNacTlsalFUaXFMZFVoQlY1Q1lVSFcxWlFOV1lXR1M3MG1I?=
 =?utf-8?B?aHFKTGs3a0w2OEViSHNnUENvRnhlT0FUNkhvNk1Td3FXOTh1MFFXQ0dTUExz?=
 =?utf-8?B?Vng1cy90U3dmbnJKdC9BZ2w1a09DdHdWbWlIK0Roc09wTjRZU3VVOG9UYUM1?=
 =?utf-8?B?b3RPUU9ieWN1Z1phTUhzVUtLcmJ5a2JqaDJmOWV1cnoxdXJzUHEyL0dhUXpC?=
 =?utf-8?B?NTExT3ZHMnFTdDhVL096bTBheTBKdE1jMkZCSThlZmJyOTNPK1FkanhZaTJ0?=
 =?utf-8?B?cmVXY1NnOVArSnEzZi95aGZvWms1R2laTDZ3NlJFWm1nLzdYYllPTFdXK2I4?=
 =?utf-8?B?YnF2SXFNZ1BHa24xakhxNFY0ZWYxYTF6MW13N2pWQXp5d3Z6Y3dlOUN0NU43?=
 =?utf-8?B?Slg0a202RWcwYjJJMGhtUStvbmZyQnlSQVFqZGEzak02b1dOYUZIc1Zrczdk?=
 =?utf-8?B?TTNRZGtZeDNzOWdCOEZ3NFA2ZG9YcytGVTBBWEx1aFYyazF1NVZGb1RDbWVG?=
 =?utf-8?B?UmFmNG5xdmNpbGxlV2NGTExERWh4Y3N6MHBzTWpOSk5XU3VhUU0ybmluS0tX?=
 =?utf-8?B?RlFCRFZoT2dwWmV2S3haRlRzQ2pLRHBlVHc5ZiswMGZGci8vZDZxV0NDSVcw?=
 =?utf-8?B?TGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4CA5FC2915F6D8418FBC6EDB3405B695@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5079.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d523f6e-3a65-47b6-46c1-08da59134bda
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2022 14:34:23.7568
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CjbIFX83SefPINtdir2L9OkW6oebFyj4K758xaNnv2T5S7LcXh8kJz2UpIPyt7jlMyntmP08zDAX8hLMA/Lu+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR13MB2501
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gVHVlLCAyMDIyLTA2LTI4IGF0IDA4OjI1ICswODAwLCBJYW4gS2VudCB3cm90ZToKPiBUaGUg
dmFsaWQgdmFsdWVzIG9mIG5mcyBvcHRpb25zIHBvcnQgYW5kIG1vdW50cG9ydCBhcmUgMCB0bwo+
IFVTSFJUX01BWC4KPiAKPiBUaGUgZnMgcGFyc2VyIHdpbGwgcmV0dXJuIGEgZmFpbCBmb3IgcG9y
dCB2YWx1ZXMgdGhhdCBhcmUgbmVnYXRpdmUKPiBhbmQgdGhlIHNsb3BweSBvcHRpb24gaGFuZGxp
bmcgdGhlbiByZXR1cm5zIHN1Y2Nlc3MuCj4gCj4gQnV0IHRoZSBzbG9wcHkgb3B0aW9uIGhhbmRs
aW5nIGlzIG1lYW50IHRvIHJldHVybiBzdWNjZXNzIGZvciBpbnZhbGlkCj4gb3B0aW9ucyBub3Qg
dmFsaWQgb3B0aW9ucyB3aXRoIGludmFsaWQgdmFsdWVzLgo+IAo+IFBhcnNpbmcgdGhlc2UgdmFs
dWVzIGFzIHMzMiByYXRoZXIgdGhhbiB1MzIgcHJldmVudHMgdGhlIHBhcnNlciBmcm9tCj4gcmV0
dXJuaW5nIGEgcGFyc2UgZmFpbCBhbGxvd2luZyB0aGUgbGF0ZXIgVVNIUlRfTUFYIG9wdGlvbiBj
aGVjayB0bwo+IGNvcnJlY3RseSByZXR1cm4gYSBmYWlsIGluIHRoaXMgY2FzZS4gVGhlIHJlc3Vs
dCBjaGVjayBjb3VsZCBiZQo+IGNoYW5nZWQKPiB0byB1c2UgdGhlIGludF8zMiB1bmlvbiB2YXJp
YW50IGFzIHdlbGwgYnV0IGxlYXZpbmcgaXQgYXMgYSB1aW50XzMyCj4gY2hlY2sgYXZvaWRzIHVz
aW5nIHR3byBsb2dpY2FsIGNvbXBhcmVzIGluc3RlYWQgb2Ygb25lLgo+IAo+IFNpZ25lZC1vZmYt
Ynk6IElhbiBLZW50IDxyYXZlbkB0aGVtYXcubmV0Pgo+IC0tLQo+IMKgZnMvbmZzL2ZzX2NvbnRl
eHQuYyB8wqDCoMKgIDQgKystLQo+IMKgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwg
MiBkZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0tZ2l0IGEvZnMvbmZzL2ZzX2NvbnRleHQuYyBiL2Zz
L25mcy9mc19jb250ZXh0LmMKPiBpbmRleCA5YTE2ODk3ZThkYzYuLmY0ZGExZDJiZTYxNiAxMDA2
NDQKPiAtLS0gYS9mcy9uZnMvZnNfY29udGV4dC5jCj4gKysrIGIvZnMvbmZzL2ZzX2NvbnRleHQu
Ywo+IEBAIC0xNTYsMTQgKzE1NiwxNCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGZzX3BhcmFtZXRl
cl9zcGVjCj4gbmZzX2ZzX3BhcmFtZXRlcnNbXSA9IHsKPiDCoMKgwqDCoMKgwqDCoMKgZnNwYXJh
bV91MzLCoMKgICgibWlub3J2ZXJzaW9uIizCoMKgT3B0X21pbm9ydmVyc2lvbiksCj4gwqDCoMKg
wqDCoMKgwqDCoGZzcGFyYW1fc3RyaW5nKCJtb3VudGFkZHIiLMKgwqDCoMKgwqBPcHRfbW91bnRh
ZGRyKSwKPiDCoMKgwqDCoMKgwqDCoMKgZnNwYXJhbV9zdHJpbmcoIm1vdW50aG9zdCIswqDCoMKg
wqDCoE9wdF9tb3VudGhvc3QpLAo+IC3CoMKgwqDCoMKgwqDCoGZzcGFyYW1fdTMywqDCoCAoIm1v
dW50cG9ydCIswqDCoMKgwqDCoE9wdF9tb3VudHBvcnQpLAo+ICvCoMKgwqDCoMKgwqDCoGZzcGFy
YW1fczMywqDCoCAoIm1vdW50cG9ydCIswqDCoMKgwqDCoE9wdF9tb3VudHBvcnQpLAo+IMKgwqDC
oMKgwqDCoMKgwqBmc3BhcmFtX3N0cmluZygibW91bnRwcm90byIswqDCoMKgwqBPcHRfbW91bnRw
cm90byksCj4gwqDCoMKgwqDCoMKgwqDCoGZzcGFyYW1fdTMywqDCoCAoIm1vdW50dmVycyIswqDC
oMKgwqDCoE9wdF9tb3VudHZlcnMpLAo+IMKgwqDCoMKgwqDCoMKgwqBmc3BhcmFtX3UzMsKgwqAg
KCJuYW1sZW4iLMKgwqDCoMKgwqDCoMKgwqBPcHRfbmFtZWxlbiksCj4gwqDCoMKgwqDCoMKgwqDC
oGZzcGFyYW1fdTMywqDCoCAoIm5jb25uZWN0IizCoMKgwqDCoMKgwqBPcHRfbmNvbm5lY3QpLAo+
IMKgwqDCoMKgwqDCoMKgwqBmc3BhcmFtX3UzMsKgwqAgKCJtYXhfY29ubmVjdCIswqDCoMKgT3B0
X21heF9jb25uZWN0KSwKPiDCoMKgwqDCoMKgwqDCoMKgZnNwYXJhbV9zdHJpbmcoIm5mc3ZlcnMi
LMKgwqDCoMKgwqDCoMKgT3B0X3ZlcnMpLAo+IC3CoMKgwqDCoMKgwqDCoGZzcGFyYW1fdTMywqDC
oCAoInBvcnQiLMKgwqDCoMKgwqDCoMKgwqDCoMKgT3B0X3BvcnQpLAo+ICvCoMKgwqDCoMKgwqDC
oGZzcGFyYW1fczMywqDCoCAoInBvcnQiLMKgwqDCoMKgwqDCoMKgwqDCoMKgT3B0X3BvcnQpLAo+
IMKgwqDCoMKgwqDCoMKgwqBmc3BhcmFtX2ZsYWdfbm8oInBvc2l4IizCoMKgwqDCoMKgwqDCoMKg
T3B0X3Bvc2l4KSwKPiDCoMKgwqDCoMKgwqDCoMKgZnNwYXJhbV9zdHJpbmcoInByb3RvIizCoMKg
wqDCoMKgwqDCoMKgwqBPcHRfcHJvdG8pLAo+IMKgwqDCoMKgwqDCoMKgwqBmc3BhcmFtX2ZsYWdf
bm8oInJkaXJwbHVzIizCoMKgwqDCoMKgT3B0X3JkaXJwbHVzKSwKPiAKPiAKCldoeSBkb24ndCB3
ZSBqdXN0IGNoZWNrIGZvciB0aGUgRU5PUEFSQU0gcmV0dXJuIHZhbHVlIGZyb20gZnNfcGFyc2Uo
KT8KCi0tIApUcm9uZCBNeWtsZWJ1c3QKTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1t
ZXJzcGFjZQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tCgoK
