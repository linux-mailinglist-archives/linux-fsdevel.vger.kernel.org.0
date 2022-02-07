Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DCFA4AC9E9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Feb 2022 20:54:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235556AbiBGTu6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Feb 2022 14:50:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240744AbiBGTr2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Feb 2022 14:47:28 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2120.outbound.protection.outlook.com [40.107.92.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F6EC0401E5;
        Mon,  7 Feb 2022 11:47:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SAKI43oc/Z4mUvbIvQyQtW+Eye6dQh1WtPMjtEttHh1rT69ifG3oGJWzjjFw80bYNEk2cJL7Oe50UWsp2hZhHbhbXhJx03vPjjy9LCWOgl/+UDpS5KjXJblzGA1/trmgP+X9ms0D/rLibk8ZkO4rcJDzkXmTyEgiTiVBXJy75nj6QANrLX1de8/0bZew5onaxjivb9zCL0GR7dLMkhYHs82uLrmxp0udDhYkDK1viBVoBM6ZOWD8u7T3HfaDS/p+Cki+MVynAaGnP3KbsTvjISnLwYzu1HEu6FauzOh5YhFltK8Fmzllgcnnf1zw85LOBNO2x+aD6SuXQVvlobxfrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H7KEPmFd9i8EkJlaZ4WwEjwiPjsd1FUYhHPfvK4X1QE=;
 b=mY8Fg0VFie2S38OzSla4g5+S1hJs7GCNCgzRWPJAghuQXxj8zDhFcF1VTBgerjLQfLGSNzJI3wY1f+OLfIhR/aaiKJ2cPDxtRETEA0JU4cfWfP7xxXp5czLbPbv+1dHKQIloH4pX4Crn2UfM24NCCGDTbpnY/DcBaMwIJt7QqZVyJJjM6GKuEev9gbnO2+4/5RHnDZPzUaqUWVXI7XDzKjzz41/0tnB2DTi90JLK8WcJkTuApJFTscMfV+ddpPljzWKIVNFE1WSIG6b5Tr4t3rIed3fYt1eB9i6z4tGgvHdUMoHtk2BjyL1+Rjqa+D4GSPAoYdDcVklNjwQ4DWY7gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H7KEPmFd9i8EkJlaZ4WwEjwiPjsd1FUYhHPfvK4X1QE=;
 b=DOP5go/v4ZW8Tv0epbsywr3biWUWylLV8fYnfTQU3Nes8DndsEXmvSuejIj34cejjnD6ij3zZoY2QK7GwoxGzVak1POhyw1aAtNDqptKSQIoUYuIthdF5Gdd7+zs1yHXKsgvAAsySmg8AOzyT65FQ21IzpXwB7TrFtyf3br+WpI=
Received: from DM8PR13MB5079.namprd13.prod.outlook.com (2603:10b6:8:22::9) by
 CH0PR13MB5233.namprd13.prod.outlook.com (2603:10b6:610:fe::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4975.8; Mon, 7 Feb 2022 19:47:09 +0000
Received: from DM8PR13MB5079.namprd13.prod.outlook.com
 ([fe80::9839:95f8:577f:b2b5]) by DM8PR13MB5079.namprd13.prod.outlook.com
 ([fe80::9839:95f8:577f:b2b5%4]) with mapi id 15.20.4975.011; Mon, 7 Feb 2022
 19:47:09 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "dhowells@redhat.com" <dhowells@redhat.com>
Subject: Re: [PATCH 1/2] Convert NFS from readpages to readahead
Thread-Topic: [PATCH 1/2] Convert NFS from readpages to readahead
Thread-Index: AQHYD9JZMpH99jSHC0aEacDA4/4++6x9QQGAgAsb8gCAADpjAA==
Date:   Mon, 7 Feb 2022 19:47:08 +0000
Message-ID: <a9384b776cc3ef23fc937f70a9cc4ca9be8d89e0.camel@hammerspace.com>
References: <20220122205453.3958181-1-willy@infradead.org>
         <Yff0la2VAOewGrhI@casper.infradead.org>
         <YgFGQi/1RRPSSQpA@casper.infradead.org>
In-Reply-To: <YgFGQi/1RRPSSQpA@casper.infradead.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e0bcdf11-1bcc-47d2-81b4-08d9ea72a093
x-ms-traffictypediagnostic: CH0PR13MB5233:EE_
x-microsoft-antispam-prvs: <CH0PR13MB52331365D8E5064DB7828F8EB82C9@CH0PR13MB5233.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ezoZyQAfp0XmQJfcmrjOdv8lnRyH7ZvD1RD8xDUCZlERoK+thZqa+0dp6tqEBuItxHUCP9juzSc4vDsVTswZokqy+KLs9vRCzQwEW89UFor58hX3q7STAzxjs3VmnUK/rgx9osSjjoYG6pC1c6rqSjoIWhU740dD+uNV4SCGVGJenhERP7Yt8qoMW4/kKb4x7l7z6itMO871wdp6URWn92eX1ZRuOi6IUgf8qshq/kPKmXWZ5F85+RmylqiSN61AYZlTIHryHuSG07CfAWin3B84cnLzImhhJuBaNZXloU66bpG43f5gtDpWlEu4oH7fCMnPWR+P3waeo1/AnrHwtKR2fVrJzWi5r4OnIqhKDPihjsqC0nF7ihgzOpCYIH8iVboMLHLjFxl4aRPePly+75FNoPyzpKE42ys2tXuI1t0I1Sj6qgUJroEtSeHVhDvoXPjl/BfCQo1pRRuBrbit7VDoHOmbkSKFZpJPTUdVtN+YAhjgrAh9JweOusJwAU5JxcnfMIse9Q6ilIzRK4FS7iAd2wc7MJRcOoeA4vdbQ28TW7OL4pJyxwGnbapVNAJqcL9PD0lqEA/jpl02ultwbIPzRBegcQjLw/+emF/NgRAs6EN8UJiyOqbwU95IYfiMVJMO+0dLZUCT7KRv3WScmOEqygOm37HQetKyMyarrel1/syjL69/5W726ByDElbvTDSnXK4YYGVX1Kg//XxIBA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5079.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38070700005)(86362001)(91956017)(8936002)(8676002)(36756003)(38100700002)(5660300002)(76116006)(316002)(66946007)(110136005)(66446008)(66476007)(26005)(66556008)(186003)(64756008)(2616005)(508600001)(71200400001)(2906002)(83380400001)(122000001)(6486002)(6512007)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eWxTWGs0RTgyRjlsWVdLSVJmSVRGK2VUQ3RndkNkRTRmVlFPSCs5YlZYOUlP?=
 =?utf-8?B?MXdmZllCWDJHN0ZvMW95OVphODBGUEhQVUlBRDQzbFZBWFdGVlJ6dWJzQmFS?=
 =?utf-8?B?ai9icG9TKzU2akZmemo1SGhFNzFXN0N1VU1LOUVFT2NrUW5RTVNVTmlmS0NU?=
 =?utf-8?B?R0xia2FnVXNFWWlkR0t0cDNta3JrRGdSSTNUVTVuRXQ4SE9rWkFKU2pUTlBj?=
 =?utf-8?B?WjRmbHRiZ1NUZExTaCtUZHJ6RSt4Z05TeXNQVUZtV0F1Q3doOHYxN3IxcXlw?=
 =?utf-8?B?UDFZbWpvdmlMMDVKYlZQdHgzOGRvWGhFSFlyZFdpZ0VSa1NreDNLblBwRnl6?=
 =?utf-8?B?L29rNWtnN3hUcEU3MkhQNG4yQ2xlTEVqMHdpa1IvWjJKS0d4RHlmeWdMMnRs?=
 =?utf-8?B?clBpZFdOcUtGKzlwUjFNbGRhSTk4UjJ4WUhid1dEbFpsQ2x6L3RZeDlRcDgw?=
 =?utf-8?B?OFVUeXJ3Z0xuQmpNTVhVNmxQN0ZGd05XTzc5YkRHaWJLR2FsQXpOK3JlNVJa?=
 =?utf-8?B?QlU4NThFbkV4blVkODVBUG1qSVR1Y3NRZXA2OHhvZXVQejVQN3ZheDRTWCtx?=
 =?utf-8?B?MjJmRGdaRHRCYXJhUVN5TW11UlBaOGhJMDFXT2kwVXZmVm9kTzZPT2pkTkVY?=
 =?utf-8?B?OUhvRjJ5eFdKNUczSGNudldqQWJRM3VhTG9EOEU3R0pqSnl5bjk1VTM0ekxL?=
 =?utf-8?B?RHozSytXaFZ1cVVaSmp1Y0grSWVZaitlWGx5a3B0aGd0UE5hWFhvU05vWit1?=
 =?utf-8?B?MEY5Z3dDSWRnYWxPSitSdUxmNStPWWRadWZMYmJCRG94QjBHM0tjM2Y5SW1K?=
 =?utf-8?B?NGd1WkxXcDlOVEVReUNYNU83Uzg1RkVLR2c4T1ZYaUxzSmw5d29hOVExMWZN?=
 =?utf-8?B?Tjd2NU1sV0tVR2ZpclZESDlZNXZnZTI0elJSTFVsMW43VmFKVmFlbHE5WTMr?=
 =?utf-8?B?T2F2TGs3U2pmSXZjckZsRHlTV1RFUDhDVkdEeUVEVUNnaXF0VEx6UTNLTmFX?=
 =?utf-8?B?VXpHQzc4akxER1RCYlg5QnBiaVR1VytIVFB4anhLSHBjU1NySXpPMDBkVVY3?=
 =?utf-8?B?SFA1R1RwaVV5bU5QTStUZWxXNHdaZ0FzenB0T04vUUhEUU52c2RsTzN4Q2V6?=
 =?utf-8?B?eFg3amdreDcyVWpzU2FSZW9kazFGc3hxVGRHejh3Tjc2RE5KUDIvS3NwOXpU?=
 =?utf-8?B?eXBNK1EzWHE0eW56NzNPL0ZhUlVNUFNuc2U0aGpRdTF6OThEOGFrVzJzMWpt?=
 =?utf-8?B?Y05jZzBnSUFpNEtUN2hpTi84NnNQcmhOMHZwWHhtWUw4Ty82WTlsYW93UGVy?=
 =?utf-8?B?WmYvY3IvOGxIM0w1alZ0ckw1UXdpNzhiaFZBWjJyYUVYMEFpdkloZElaazlQ?=
 =?utf-8?B?Q3o5ZWFpOXp3bXVjQStUblFQUTNVelUrQ3libFh6K1ViM0pQd01MV2x2MUx6?=
 =?utf-8?B?SEwwenpnVHZwTGF2ck9pVk5yTElST2IzMnFGc2wza0ZzaFVZTUQ1SEU2WFRh?=
 =?utf-8?B?bmQyR2dvYTdWWlY1VVhIVWZKV2k3NzZaaVRodEdLd1NBN1hQK1VWU0dDVXNm?=
 =?utf-8?B?L1YxMmxNK2N2alNlRGtERXR4bUcwUE45aXNlQnlIekRTdWR3YnVTTHVBbXNE?=
 =?utf-8?B?bDk5TVhsNFFnaFhWNitGRnNXc2I4Rkdka29jeUY1aXpiaVBIRzNHeDFVOHdL?=
 =?utf-8?B?eEtxaG5XTyt1VUMveGhJaG51SENlUGdxVXlGM0dVN2Y4VE1BbjVCM1JWYXlI?=
 =?utf-8?B?cllPZDJaaTRzaHRPVlR5UjBjSWZPRWdVZHlIYXprY0pKQUdjWW52d3B0d0RR?=
 =?utf-8?B?R1N3UTFYSXh1OEo1WERqeER0MzFsMGRaYzllMkJ5OGVGZjhBVTM3WmxPT0Ew?=
 =?utf-8?B?anNXS2Uzc2Q5Q2tkTUducmg1L2VERXJ3TmtLRHArdGtuUjVVQi9NbHNmWFNk?=
 =?utf-8?B?Y1NwSUk1dm5vODk4WWZoWG5xZVBIb3R3TFhmM1d3eUh4S25kZWNsN0hDTGFQ?=
 =?utf-8?B?NWVhMU40c3N6REd3M3BUcXk4NFBjL01qU1hzL2FqakNIWUlwTkJiOTc0TW9m?=
 =?utf-8?B?WkJoTUE0bEFtVktPamhkbDFVL2xoS0xIa2doOEpmRlpMRytxK1dnc2JiV3FP?=
 =?utf-8?B?VFN0UnA5Q3Z0TTAwNFZvVENWbllQQnc2OUYwbzZ3ZkZSZDQzU1ZLcGp1Y05F?=
 =?utf-8?Q?LHkG3yjBsWIodaFGFW6eRtc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5B541512CA9B934EA3C41828C7C106D7@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5079.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0bcdf11-1bcc-47d2-81b4-08d9ea72a093
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2022 19:47:08.9735
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OhagVGUhPd8TDjqrKzI/PDdxSe19/KNUEsqtV+Ynk51KofWLdcF4O/Z4aQSpozz2P22SaIVu+PpgATHWrE3Z6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR13MB5233
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gTW9uLCAyMDIyLTAyLTA3IGF0IDE2OjE4ICswMDAwLCBNYXR0aGV3IFdpbGNveCB3cm90ZToN
Cj4gT24gTW9uLCBKYW4gMzEsIDIwMjIgYXQgMDI6Mzk6MTdQTSArMDAwMCwgTWF0dGhldyBXaWxj
b3ggd3JvdGU6DQo+ID4gT24gU2F0LCBKYW4gMjIsIDIwMjIgYXQgMDg6NTQ6NTJQTSArMDAwMCwg
TWF0dGhldyBXaWxjb3ggKE9yYWNsZSkNCj4gPiB3cm90ZToNCj4gPiA+IE5GUyBpcyBvbmUgb2Yg
dGhlIGxhc3QgdHdvIHVzZXJzIG9mIHRoZSBkZXByZWNhdGVkIC0+cmVhZHBhZ2VzDQo+ID4gPiBh
b3AuDQo+ID4gPiBUaGlzIGNvbnZlcnNpb24gbG9va3Mgc3RyYWlnaHRmb3J3YXJkLCBidXQgSSBo
YXZlIG9ubHkgY29tcGlsZS0NCj4gPiA+IHRlc3RlZA0KPiA+ID4gaXQuDQo+ID4gDQo+ID4gVGhl
c2UgcGF0Y2hlcyBzdGlsbCBhcHBseSB0byAtcmMyLg0KPiANCj4gQW5kIHRoZXkgc3RpbGwgYXBw
bHkgdG8gcmMzLg0KPiANCj4gSSdtIGp1c3QgZ29pbmcgdG8gc2VuZCB0aGVtIHRvIExpbnVzIGFz
IHBhcnQgb2YgdGhlIGdlbmVyYWwgZnMtZm9saW8NCj4gd29yayBJJ20gZG9pbmcgZHVyaW5nIHRo
ZSBuZXh0IG1lcmdlIHdpbmRvdy7CoCBJZiBhbnlib2R5IHdvdWxkIGxpa2UNCj4gdG8NCj4gdGVz
dCB0aGVtLCBJJ20gaGFwcHkgdG8gc3RpY2sgYSBUZXN0ZWQtYnkgb24gdGhlbS4NCg0KVW5sZXNz
IHRoZXJlIGlzIGEgc3Ryb25nIGV4dGVybmFsIGRlcGVuZGVuY3ksIEknZCBwcmVmZXIgdG8gc2Vu
ZCB0aGVtDQp0aHJvdWdoIHRoZSBORlMgdHJlZSwgYm90aCBmb3IgdGVzdGluZyBwdXJwb3Nlcywg
YW5kIGluIGNhc2Ugd2UgbmVlZCB0bw0KbWFrZSBjaGFuZ2VzLg0KDQpJIGFscmVhZHkgaGF2ZSB0
aGVtIGFwcGxpZWQgdG8gbXkgJ3Rlc3RpbmcnIGJyYW5jaCwgYnV0IEkgY2FuJ3QgbW92ZQ0KdGhh
dCBpbnRvIGxpbnV4LW5leHQgdW50aWwgQW5uYSdzIHB1bGwgcmVxdWVzdCBhZ2FpbnN0IC1yYzMg
Y29tZXMNCnRocm91Z2guDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50
IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29t
DQoNCg0K
