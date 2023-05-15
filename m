Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6CA7703D08
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 May 2023 20:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242502AbjEOSx4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 May 2023 14:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235962AbjEOSxy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 May 2023 14:53:54 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2121.outbound.protection.outlook.com [40.107.92.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 058DC14375;
        Mon, 15 May 2023 11:53:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YcQfk2DiYsarEsas/pHCcL7V/eLW6EtBC/c+3rPdPmtzqJkitrcjdgRafLf3MPBJ+Re8gqzFxGRLmz5zPj/EsvEL0kwTSgSphgcoDFrbKrd5cuTCq5Hr/QRGRUllMVVsSbl9uVDOrbOXoOTmMY5OxMd4kUbL4WKZt2GsFj6mtNfCCaIIWENXZfzPE1vqguo70dNzbaGJq8yPl9c7Mg7jM3cDI5TnhCSfOp3szvkqkbl4iTqACEKtQq5ulkXo6jPq6ubSuQrzJzUFxs4tjv8u7vdeuPioDmLxVVlT0NHUbA+Uc0BgD9SGeJseOcGjuDEawaZzDFkY9IYijBUJ8q1fxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OEktkJ+4qJd0qa6F97ZL5P+X68N26V7mqUPlSPSL9Ik=;
 b=BuAttpbuV7KQkV8wqgE1EIpG4Dv++1ZucXjMsMPiIELnTSoY/0v6g06OWz0e7mFIqb7O1DMy2qpK7ewBiJF4sZTNRhLtg2Ub+D/ln1kdbM0bo5jf0D71LOhxIp11tAFsFEqKrtxa0upyFHR9EiwzcEwwe+TMc7Kxb22hCrWOEYYVQJb79yY7okV4eYutPIpT4t9PkKWegrSDVn4yuF5i3Nxxgj/lGNiC0xWij3L+cT60/iymtsAaHgHHgFpKiSHIuDfBP4GUZ3wY/5WHrntd1ko50R52WAbiUUy8Mc6uAyl5f4N8nMGZaIKOTew0xIUqQ6ZSDYsKvh6xWHyAyiYCNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OEktkJ+4qJd0qa6F97ZL5P+X68N26V7mqUPlSPSL9Ik=;
 b=HykxPQ/RvR86JnngdK7xApGqFSNpIejf9T7/m+ZKhYDnLG36YqIHv4bIFdrFuoDXDmjEjHPPq742DaVPrITPRTErURO6JcOP/ia9ApPv9RU0+/a1KqldbxbcCQhaSCAY8lKnzF3rgxiTffiV2lowRShE9CZrovaRDJgUvTpvbAA=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by DM6PR13MB3836.namprd13.prod.outlook.com (2603:10b6:5:24f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.22; Mon, 15 May
 2023 18:53:46 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::3627:d466:b0ae:1740]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::3627:d466:b0ae:1740%6]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 18:53:46 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "eggert@cs.ucla.edu" <eggert@cs.ucla.edu>,
        "jlayton@redhat.com" <jlayton@redhat.com>,
        "bruno@clisp.org" <bruno@clisp.org>,
        "ondrej.valousek.xm@renesas.com" <ondrej.valousek.xm@renesas.com>,
        "brauner@kernel.org" <brauner@kernel.org>
CC:     "bug-gnulib@gnu.org" <bug-gnulib@gnu.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] fix NFSv4 acl detection on F39
Thread-Topic: [PATCH] fix NFSv4 acl detection on F39
Thread-Index: AQHZh1C3kpBoUTLtAEenGrrL6g3A8q9blrwAgAAFyoCAABH9AA==
Date:   Mon, 15 May 2023 18:53:46 +0000
Message-ID: <da77f960d561014c02b987ac380b2f2de9c9ed1a.camel@hammerspace.com>
References: <20230501194321.57983-1-ondrej.valousek.xm@renesas.com>
         <c955ee20-371c-5dde-fcb5-26d573f69cd9@cs.ucla.edu>
         <TYXPR01MB1854B3C3B8215DD0FA7B83CCD96D9@TYXPR01MB1854.jpnprd01.prod.outlook.com>
         <17355394.lhrHg4fidi@nimes>
         <32edbaf1-d3b1-6057-aefc-d83df3266c20@cs.ucla.edu>
         <4f1519d8-bda1-1b15-4a78-a8072ba1551a@cs.ucla.edu>
         <TYXPR01MB18547A591663A4934B5D4D82D9789@TYXPR01MB1854.jpnprd01.prod.outlook.com>
         <fb005d7e29f1167b83acf7b10800ff3124ee2a50.camel@redhat.com>
         <f967cbcc1620d1a5e68d7f005571dc569c8b5bb4.camel@hammerspace.com>
         <d4e26d9e4d9113f8da20425f5bf7ad91c786f381.camel@redhat.com>
In-Reply-To: <d4e26d9e4d9113f8da20425f5bf7ad91c786f381.camel@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|DM6PR13MB3836:EE_
x-ms-office365-filtering-correlation-id: 61494ec6-5770-4e38-04ed-08db5575b64c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PTtVaw9J1vCaIiMFEkvpYoV8eva7+D4BosM54udU6nh81I3Fd9e+RP3v7/bYWe13vFEUA9VJTxC3ENFEFwR4hiUWdWniPt2wexRCGFUZ6Jer6ZBQ1FvNccNdPVSwi3DCEFVwhs9NwEH2C7smPiMYJOhfoOOoEl/+WEEFT9WMk64HXO0UpzP3nQVo4aOUou/HoSVGWODtqMv8KT2P5JFjoPRFn/cYkVxYcqr9+FpuYBU/VnDXKpAzF9u6xXv10bfk7aTf97b4vc9AAv/lawlpi0GCZtjBLJd+J6roYBhdm2po6btBLwOO1L+X9ZPcoBquW3bi+TDFCCdvsfD2mAG1xesoda9EDo/8aIfYNCYDO+p1rCEfsfpHbVnDZx3mN1xkNKxx3XPlZTId+zHyfqvqw5D7b3MGME7mQaliN6gR2d8KH/xA78jjeL2aPtUI2v/BDsBPwV2RS5ICMsVg6pbwzOGkSopgxTHrRKDFaGsRavH1CwRa8MBvCuM28TiCDChmphO0reRxG2gC2eF0SLw+8XqafV0ft89t2XO1/DoRWNWcFDVsTVjEQ4gBFlhMN5fmk/5989ddEOBhAZmOuAvxdzraGyglwFpQz3yhdBY+PF+RijFayvYNLOrGS/A3HtDF
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(396003)(39830400003)(366004)(376002)(451199021)(83380400001)(66556008)(76116006)(64756008)(66946007)(66446008)(2616005)(6512007)(6506007)(66476007)(478600001)(54906003)(110136005)(186003)(71200400001)(2906002)(5660300002)(86362001)(8676002)(8936002)(26005)(6486002)(36756003)(41300700001)(4326008)(316002)(38070700005)(122000001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RG1ZT2lxalY3Y1N6RmNONTZ3UElLdVZLVGlhTnB0UG1MVitwWUxRWm90R2dM?=
 =?utf-8?B?eW9oakswdmxHM2J1Nzc3MDNuN3ZSa0M3SWVjTWFPc1Uza0YrN1JxWXVIbURx?=
 =?utf-8?B?ZHVkWFp1bXJpbkpSTkxQckgydjVTQlhoTmEwVjV1aktYdU5HTGNxRklNcG9Y?=
 =?utf-8?B?UEhoY3dGR1ZUbXlHOURBMkRYUlQ1dVc3S3l0MVBjenYxL3ZQdkp6OEE1d2My?=
 =?utf-8?B?VjJaaFZnNk9qVUVQSEhXRWNOa082MTI1RHc2RldVUFY3eUNDcDJucjZCTjJV?=
 =?utf-8?B?YWhBVFl2RzV1S3pyRFFLUzdYOG4yN2M4dWx6WjhRRzR4a0UweGxQYTVENENI?=
 =?utf-8?B?VVduVk1oMmY2Z3NWUHhabUVnNkVncWZQOERTUWEwek5KV1pYZkQyWWhGY21l?=
 =?utf-8?B?N0lmTU5lQWhsUnhvRi91UG9jTEM0S01Qc0JSZEpxRWJJeUpraHJtc3lHUUpB?=
 =?utf-8?B?NWVmZUhiUUthdUgrZkZBN2IxLy9SUnQ1azhuMWIrakNKWkIvRG5aRWNBYStL?=
 =?utf-8?B?cjAzY3J1NktqUFN3UEVtdHV0UUozTTJNY3VkWWJ5allhQnRNZWE0ZFE2dFB4?=
 =?utf-8?B?NTVWYnZidythOHdUU0lKRFRXVkRLWndaVlQ3emNmeEl6WGY5L2gwQ2VHL2Qv?=
 =?utf-8?B?VWZFMXhMR1pidEpoQW9zbkp1dXo2dzl2MEMxQmRINzRmZnNreTlsY0NiTkQx?=
 =?utf-8?B?N1pyNDRYWVhSdk5lQk5OMFE5QS9DZnNISXBzdkVYejJPUlR4QStDc3ZjTi9q?=
 =?utf-8?B?eWlzRWlBaThCTktFbUZYSEF4OFVYT0pYcVVGQmRVUTFkTHJ2OHk4VC9YQ3da?=
 =?utf-8?B?NC9EbEhHSzZjMHA3QXRFc2hWV0MxWHpaYTNWNS9BbGpEVGRURVkwdjNmOEJs?=
 =?utf-8?B?dmpodnlpQi9WSnRlQjZIT01RbVdkWWF1cjNDejdmbExwbjdsbU81cnNydHI0?=
 =?utf-8?B?V2VGTDlML01sQWcrZmxWTlRoVnA3TWtadllQMVFEeU92SXZTemdPS2VWdUlu?=
 =?utf-8?B?MjZob0pKVGtML2tIMC9xNUI4WTJrYzJQYWE3dS9NYXYvaDVDWW1iL0s0eTQ1?=
 =?utf-8?B?cnZFK2Y0eXZnUHJ6MTdiTE9zWGd2aUNKeERKa3crZEdKRkhSQjZTLzhvZk00?=
 =?utf-8?B?Y1NkMk9PcEtpTlV1M2xCK0JlOUhuZTUwbXRjQjVmYUpNcHhtVE9BbHZaTG1L?=
 =?utf-8?B?L04ydDZYdGFwVTdIRWY1VkVpL3hrckFnUlVwRVJESTNFWXJKcXpSZEVEQUtE?=
 =?utf-8?B?amYyeTF3YzVGRGdWaXhlM3RzZmR0VUord3ZnNTJCZ0VMWSthdU1vUzlJdFNC?=
 =?utf-8?B?THlkL1hTL1QxelVheDc0VXQvSHg1WDhyKzFHWktxQ3ozc0NZWVEzdEtYeUpk?=
 =?utf-8?B?U2RuZXk0dm9SMU5UWkUvM2U4UGFUc3ZCQU5KZGVqelNpVnZxU0IvYjNQRkRG?=
 =?utf-8?B?T0FocCs0RmYrZ2FBRkpDL3Vydlc2QXlta05NSnh4cUtybEw5TEFicllvclRK?=
 =?utf-8?B?ODNZQlVhR0I0WFpKV3BydTlZRWVnVklEWUdueWhDNFFvOE1nZkxwak9kQk04?=
 =?utf-8?B?SlFKN3lId0lxeVB6QzZVRlNTeFY1N0puVmVtUGJ5Q3BJakkxRXJKQkR3OERh?=
 =?utf-8?B?UnhNTENPZ2puOFRISHpGdFFmMW9hcjlucGJ5TTR0S0JJWGpwZzFOakZWaDRj?=
 =?utf-8?B?UHZvcHR6bW9sS1Fwa0FycWNKVHFqeUFuS0NWcDZEZ282R0dPOG1HYWRuWGJB?=
 =?utf-8?B?a2NQc3lhVEpheGZ0T2JZclZtL3ZqVndmMXFMcHYyZkhFanhFdXVzWTZsZ205?=
 =?utf-8?B?WUloam9adm1HdU9Qd2RYcEZwbzJxTDdobElhZTRSblNyQXpnVEhyS3FvQTVB?=
 =?utf-8?B?bWZ4REc5aUhhZ1NwdERhYWxHbGgrejdvOU9oTWRML3JmUW5oV1QvQ1pJcGZ2?=
 =?utf-8?B?c1U3OTY3aGFPOW14TWFnb1FZcGZOTW01czJVU0hYK3ljaFcrSzhjbEd6RTE0?=
 =?utf-8?B?OE41Z3NVUnJ2cklmN1lRRDd1S3llc0hnL0FrU3VSTjFQY0lyUGd2U0lCd3hw?=
 =?utf-8?B?dENjVmg5YzkrOWpJN25PWWw3c0VScFZCbzB6TU5PdUFtcHFBcTNINEtwRisv?=
 =?utf-8?B?VStyS2tXbHBqMHJXRjZaVEVaZXZYVWVVS05BOGhRTmZ4NXVaclNOUFN1VnZm?=
 =?utf-8?B?Mmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7F5B5F321C0B3940B935BD2D0B13F041@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61494ec6-5770-4e38-04ed-08db5575b64c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2023 18:53:46.0463
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MSq1/jAFJ97NJzKFUUpNOYzA8iH2c+zJiPS7IM/l1XVLO+yrGHXsazRslyXhrdbzB9mnvTazb/OZg7fc5HvFEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB3836
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gTW9uLCAyMDIzLTA1LTE1IGF0IDEzOjQ5IC0wNDAwLCBKZWZmIExheXRvbiB3cm90ZToNCj4g
T24gTW9uLCAyMDIzLTA1LTE1IGF0IDE3OjI4ICswMDAwLCBUcm9uZCBNeWtsZWJ1c3Qgd3JvdGU6
DQo+ID4gT24gTW9uLCAyMDIzLTA1LTE1IGF0IDEzOjExIC0wNDAwLCBKZWZmIExheXRvbiB3cm90
ZToNCj4gPiA+IE9uIE1vbiwgMjAyMy0wNS0xNSBhdCAxMTo1MCArMDAwMCwgT25kcmVqIFZhbG91
c2VrIHdyb3RlOg0KPiA+ID4gPiBIaSBQYXVsLA0KPiA+ID4gPiANCj4gPiA+ID4gT2sgZmlyc3Qg
b2YgYWxsLCB0aGFua3MgZm9yIHRha2luZyBpbml0aWF0aXZlIG9uIHRoaXMsIEkgYW0NCj4gPiA+
ID4gdW5hYmxlDQo+ID4gPiA+IHRvIHByb2NlZWQgb24gdGhpcyBvbiBteSBvd24gYXQgdGhlIG1v
bWVudC4NCj4gPiA+ID4gSSBzZWUgZmV3IHByb2JsZW1zIHdpdGggdGhpczoNCj4gPiA+ID4gDQo+
ID4gPiA+IDEuIFRoZSBjYWxjdWxhdGlvbiBvZiB0aGUgJ2xpc3RidWZzaXplJyBpcyBpbmNvcnJl
Y3QgaW4geW91cg0KPiA+ID4gPiBwYXRjaC4NCj4gPiA+ID4gSXQgd2lsbCBfbm90X3dvcmsgYXMg
eW91IGV4cGVjdGVkIGFuZCB3b24ndCBsaW1pdCB0aGUgbnVtYmVyIG9mDQo+ID4gPiA+IHN5c2Nh
bGxzICh3aGljaCBpcyB3aHkgd2UgY2FtZSB1cCB3aXRoIHRoaXMgcGF0Y2gsIHJpZ2h0PykuDQo+
ID4gPiA+IENoZWNrDQo+ID4gPiA+IHdpdGggbXkgb3JpZ2luYWwgcHJvcG9zYWwsIHdlIHJlYWxs
eSBuZWVkIHRvIGNoZWNrIGZvcg0KPiA+ID4gPiAnc3lzdGVtLm5mczQnIHhhdHRyIG5hbWUgcHJl
c2VuY2UgaGVyZQ0KPiA+ID4gPiAyLiBJdCBtaXN0YWtlbmx5IGRldGVjdHMgYW4gQUNMIHByZXNl
bmNlIG9uIGZpbGVzIHdoaWNoIGRvIG5vdA0KPiA+ID4gPiBoYXZlDQo+ID4gPiA+IGFueSBBQ0wg
b24gTkZTdjQgZmlsZXN5c3RlbS4gRGlnZ2luZyBmdXJ0aGVyIGl0IHNlZW1zIHRoYXQNCj4gPiA+
ID4ga2VybmVsDQo+ID4gPiA+IGluIEYzOSBiZWhhdmVzIGRpZmZlcmVudGx5IHRvIHRoZSBwcmV2
aW91cyBrZXJuZWxzOg0KPiA+ID4gPiANCj4gPiA+ID4gRjM4OiANCj4gPiA+ID4gIyBnZXRmYXR0
ciAtbSAuIC9wYXRoX3RvX25mczRfZmlsZQ0KPiA+ID4gPiAjIGZpbGU6IHBhdGhfdG9fbmZzNF9m
aWxlDQo+ID4gPiA+IHN5c3RlbS5uZnM0X2FjbMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgPC0tLS0gb25seQ0KPiA+
ID4gPiBzaW5nbGUgeGF0dHIgZGV0ZWN0ZWQNCj4gPiA+ID4gDQo+ID4gPiA+IEYzOToNCj4gPiA+
ID4gIyBnZXRmYXR0ciAtbSAuIC9wYXRoX3RvX25mczRfZmlsZQ0KPiA+ID4gPiAjIGZpbGU6IHBh
dGhfdG9fbmZzNF9maWxlDQo+ID4gPiA+IHN5c3RlbS5uZnM0X2FjbA0KPiA+ID4gPiBzeXN0ZW0u
cG9zaXhfYWNsX2RlZmF1bHQNCj4gPiA+ID4gLyogU09NRVRJTUVTIGV2ZW4gc2hvd3MgdGhpcyAq
Lw0KPiA+ID4gPiBzeXN0ZW0ucG9zaXhfYWNsX2RlZmF1bHQNCj4gPiA+IA0KPiA+ID4gKGNjJ2lu
ZyBDaHJpc3RpYW4gYW5kIHJlbGV2YW50IGtlcm5lbCBsaXN0cykNCj4gPiA+IA0KPiA+ID4gSSBh
c3N1bWUgdGhlIEYzOSBrZXJuZWwgaXMgdjYuNC1yYyBiYXNlZD8gSWYgc28sIHRoZW4gSSB0aGlu
aw0KPiA+ID4gdGhhdCdzDQo+ID4gPiBhDQo+ID4gPiByZWdyZXNzaW9uLiBORlN2NCBjbGllbnQg
aW5vZGVzIHNob3VsZCBfbm90XyByZXBvcnQgYSBQT1NJWCBBQ0wNCj4gPiA+IGF0dHJpYnV0ZSBz
aW5jZSB0aGUgcHJvdG9jb2wgZG9lc24ndCBzdXBwb3J0IHRoZW0uDQo+ID4gPiANCj4gPiA+IElu
IGZhY3QsIEkgdGhpbmsgdGhlIHJhdGlvbmFsZSBpbiB0aGUga2VybmVsIGNvbW1pdCBiZWxvdyBp
cw0KPiA+ID4gd3JvbmcuDQo+ID4gPiBORlN2NCBoYXMgYSBsaXN0eGF0dHIgb3BlcmF0aW9uLCBi
dXQgZG9lc24ndCBzdXBwb3J0IFBPU0lYIEFDTHMuDQo+ID4gPiANCj4gPiA+IENocmlzdGlhbiwg
ZG8gd2UgbmVlZCB0byByZXZlcnQgdGhpcz8NCj4gPiA+IA0KPiA+ID4gY29tbWl0IGU0OTkyMTRj
ZTNlZjUwYzUwNTIyNzE5ZTc1M2ExZmZjOTI4YzJlYzENCj4gPiA+IEF1dGhvcjogQ2hyaXN0aWFu
IEJyYXVuZXIgPGJyYXVuZXJAa2VybmVsLm9yZz4NCj4gPiA+IERhdGU6wqDCoCBXZWQgRmViIDEg
MTQ6MTU6MDEgMjAyMyArMDEwMA0KPiA+ID4gDQo+ID4gPiDCoMKgwqAgYWNsOiBkb24ndCBkZXBl
bmQgb24gSU9QX1hBVFRSDQo+ID4gPiDCoMKgwqAgDQo+ID4gPiANCj4gPiANCj4gPiANCj4gPiBO
by4gVGhlIHByb2JsZW0gaXMgY29tbWl0IGYyNjIwZjE2NmUyYSAoInhhdHRyOiBzaW1wbGlmeSBs
aXN0eGF0dHINCj4gPiBoZWxwZXJzIikgd2hpY2ggaGVscGZ1bGx5IGluc2VydHMgcG9zaXggYWNs
IGhhbmRsZXJzIGludG8NCj4gPiBnZW5lcmljX2xpc3R4YXR0cigpLCBhbmQgbWFrZXMgaXQgaW1w
b3NzaWJsZSB0byBjYWxsIGZyb20NCj4gPiBuZnM0X2xpc3R4YXR0cigpLg0KPiA+IA0KPiANCj4g
DQo+IEFoaCBvay4gTG9va2luZyBhdCB0aGF0IGZ1bmN0aW9uIHRob3VnaCwgaXQgc2VlbXMgbGlr
ZSBpdCdkIG9ubHkNCj4gcmVwb3J0DQo+IHRoZXNlIGZvciBtb3VudHMgdGhhdCBzZXQgU0JfUE9T
SVhBQ0wuIEFueSByZWFzb24gdGhhdCB3ZSBoYXZlIHRoYXQNCj4gdHVybmVkIG9uIHdpdGggdjQg
bW91bnRzPw0KPiANCg0KU28sIHdoaWxlIGl0IG1heSBzZWVtIHJlYXNvbmFibGUgdG8gYXNzdW1l
IHRoYXQgU0JfUE9TSVhBQ0wgbWVhbnMNCidzdXBwb3J0cyBwb3NpeCBBQ0xzJywgdGhhdCBkb2Vz
bid0IGFjdHVhbGx5IG1hdGNoIHRoZSBkZWZpbml0aW9uIGluDQppbmNsdWRlL2xpbnV4L2ZzLmgg
KG9yIHRoZSBlcXVpdmFsZW50IGRlZmluaXRpb24gZm9yIE1TX1BPU0lYQUNMKToNCg0KI2RlZmlu
ZSBTQl9QT1NJWEFDTCAgICAgKDE8PDE2KSAvKiBWRlMgZG9lcyBub3QgYXBwbHkgdGhlIHVtYXNr
ICovDQoNClNlZSB0aGUgdXNlIG9mIG1vZGVfc3RyaXBfdW1hc2soKSBpbiB2ZnNfcHJlcGFyZV9t
b2RlKCkuDQoNClNvIHllcywgTkZTdjQgc2V0cyBTQl9QT1NJWEFDTCwgYW5kIGl0IGhhcyBkb25l
IHNvIHNpbmNlIGNvbW1pdA0KYThhNWRhOTk2ZGY3ICgibmZzOiBTZXQgTVNfUE9TSVhBQ0wgYWx3
YXlzIikgYmVjYXVzZSB3ZSByZXF1aXJlIHRoZSBWRlMNCnRvIG5vdCBhcHBseSB0aGUgdW1hc2su
IA0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBI
YW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
