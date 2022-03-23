Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB434E5AF6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Mar 2022 22:58:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245027AbiCWWAU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Mar 2022 18:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbiCWWAT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Mar 2022 18:00:19 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2115.outbound.protection.outlook.com [40.107.92.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D40D33355;
        Wed, 23 Mar 2022 14:58:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LTSUHUt4h2vgKtI2ntwRkTQS+bBD7hkNo0fD087gFAIigRpN9jqbpAL4qovmXWzyQLhCOzKcq0I/vn9wyQKLpSVOgvoLKWT1ik9sgfzKUs4qwuiXE1QtPqMJs2wQsxJzsPKhrXBhrdCcfop1d7saW9l+dh8qDuxajr5o4pJeo4b3t1/pwjgn+ebi1UUzRDT+Ph7fUMez+t8FelanbYwrHVjPIRKS/X/Czcx7fecqwb6KjhkdfE9ysJRc3lH25kGpao5Ynxlyl5ta2T5U8vMO3zgCqBLVefPDnBOZn8iyD0MnHlb9ZocTMa5laeySuArKKL5Wn/T0yqmxeWN0UlFWEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2V/TvgEf9EcLmZJ9eVy6Z646cw6/AhHokI0t4Zlf/64=;
 b=BUneixq6IcQ1jfM0rFRqb42bHCl7Jz76iyalxTvAGOkbpYeSQc31h2tdR0cI/+KXPaPdE5pUwWQlZgIUXfK45e3hcIRe9wvuHsVCafrGIofsT7Tkf/wk8lCaY60AQwJbRB4BNXCw3MmRYSaE1m4IyxsrHYDwVjoqHNd69ztWKDUl81kRVALRsHKg+f/j6e1+T0kCb1/s3ccG6Bvfp2B/G4aWockHRHZY34aV/DKxrDQ/yiGvWiiNLOWsBpWgMO5WwuPkTkNjoskjHaGSyla+vQNiOOBe3z8a/q/P/agSegZlrABvFhi3T7HrDS8MKv2iLYO+EGx/fZW30foAUu833g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2V/TvgEf9EcLmZJ9eVy6Z646cw6/AhHokI0t4Zlf/64=;
 b=I6fXYyRpQzZheyCGrjsHpjNN0MOBL9kuD8ftBifGZVuAgOgkvhLfjKTxuH/4MBEPk384yPmygdhoub+SDRUmw0hwsPpxQtit3bY0XpXR8xce4o6b0ig1mQsH0wzYT8ZzHC7IBnBeuiOkyjB3arcUfOTabfr4OWcVSeCs3FT+2n4=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by DM6PR13MB3595.namprd13.prod.outlook.com (2603:10b6:5:1cb::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.18; Wed, 23 Mar
 2022 21:58:45 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::c0b:4fda:5713:9006]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::c0b:4fda:5713:9006%6]) with mapi id 15.20.5102.016; Wed, 23 Mar 2022
 21:58:45 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "tbecker@redhat.com" <tbecker@redhat.com>,
        "willy@infradead.org" <willy@infradead.org>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "kolga@netapp.com" <kolga@netapp.com>,
        "steved@redhat.com" <steved@redhat.com>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH RFC v3 0/6] Intruduce nfsrahead
Thread-Topic: [PATCH RFC v3 0/6] Intruduce nfsrahead
Thread-Index: AQHYPvM9Jm7pNaCP70y6EDSGkJFDmazNfQYAgAAHZoA=
Date:   Wed, 23 Mar 2022 21:58:44 +0000
Message-ID: <90687b54dbcc3505f9d6de546932644a45a37ddc.camel@hammerspace.com>
References: <20220323201841.4166549-1-tbecker@redhat.com>
         <YjuR3h6yDYLoEeum@casper.infradead.org>
In-Reply-To: <YjuR3h6yDYLoEeum@casper.infradead.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b48b9b60-3aff-4be6-eaae-08da0d184d24
x-ms-traffictypediagnostic: DM6PR13MB3595:EE_
x-microsoft-antispam-prvs: <DM6PR13MB3595523CDF073BC3D479AC8AB8189@DM6PR13MB3595.namprd13.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YDewuQXc0GiDWZJ+yHwPAnjtjZ7RtFLYRDihc9plxZOUg5y4gQKYk96UGa8qPv9/ltx1h4gGXas4aCPfjFPfELdeDOo/OLmnhh8egrPW0JOhqsOcZ2GcM4T9vXLBVrK0ORthvDPmj91dm5UWe9ECtq+300m9nNCvOsu+CSN+U1erG27CF6rZ7B0o6uiimjNOhFsdpyGtmv17sLZsmINB8qdy6cMNcaOHdE2ZHOFOuEvzVxUWT3EgwFzSitwCBdhrGkgPw7xrX3gna8f72YFSbt6sQlWzqPkFBRnP9M4gDU/GdyZ3FhRa17DkXfoH/oJeYeEpW2vsxdWZrnlCtCnqbDFuW0kwwAJNc4WbvS+uLg01BefLwbAiFceVwOWqL65ocAggqwPttS+MBYktXKoQuZc4F0gUcUsX2wQJEXVD+iw7mR3QdWhh0dvSzbkROzgOLKsKnpT4YHhv+/L5QGvvV5z/Jz9P12ADdjzuMzcZMiP4PHMTGaZsL7s6d+NH6K0pjmy4L5GQMUeJ1EZgRSEpbsGmVh49rEq8Q2hlpdLgw/Pizn2fvXLDkUbq1to5quswH1QLmN+FJ7tO3c8103LonzCOQWg35c9Tp8ecCDSXpy02NiTIdYLyURHwRUZLMjhnoav1F/YZSoeeKkAfzq9xntfg+uLZicbHCMO7EzqX8ohgynO784qwehVOCC7VfVGAhEE8KcGQeETm4NaAEstOwA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(38070700005)(6512007)(6506007)(8676002)(54906003)(110136005)(86362001)(316002)(186003)(26005)(83380400001)(66556008)(66446008)(64756008)(66476007)(508600001)(66946007)(4326008)(76116006)(2616005)(71200400001)(38100700002)(122000001)(5660300002)(6486002)(36756003)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aGZuNXFYZWRlUFZ6SXdmYzlCRjBhei9GUnlMTE52cFJCUkpLSkZkOU1ZMmFQ?=
 =?utf-8?B?a2tKNFpOYTB5YlpRN21YMHhmSWx5Z0ZwelJTb1l5a2Q3WThtc1AwNHQraElL?=
 =?utf-8?B?VlRpMnBlWFFlN2hhV0lSY0x6NzF5eTlSYW5nM0s3OG9ZZ0hKc3BDc3BVdDhq?=
 =?utf-8?B?cDlZV0lncHdYYitFVWpPc0lFQVhNYlEvSVlUdnFLNkVDemNudDhxeW1uV01n?=
 =?utf-8?B?UHdIbjJKdVh4ZWdCdFh4eHR6NlpMcTZ1b0VmVWlCWlZvb3hTbk5USkcwU1dP?=
 =?utf-8?B?T1BQMnZYa2VQT09CbjFvUkx2ZEdkbkdQWjZML2ZCK2h1SE1mQlYwMUpSdWNu?=
 =?utf-8?B?ZjByYWNNcm5JZi84Yzd2cGJIaDN4UUs5STVGRnNTaDhYUkJLT3ZVa2Y1eVhy?=
 =?utf-8?B?ckFSUkxnNWtIdy9sdDVjR0ptUVlFd1NsUUw1Z0hzTHg5Wkl0ZVVJSXdXM25Y?=
 =?utf-8?B?dVdjMTgrdm5xZEF6MFVLWGd2T2JUWFliaGNSdnV6N1BMYkM4dzUxZmxpcVRP?=
 =?utf-8?B?d0ZDS0M2WE4rWkFRS0xlKzVkS1JaM2Y4NFlNOSsxVWsvanpNYWh5V2laNnA0?=
 =?utf-8?B?QXZweEpjV2RhQ3ZwWDNiWjgzeTNrZWtqa3VuU3VHZXU2RHlpMTUyUnBzZWdj?=
 =?utf-8?B?N1FiY2wrUjZLeVFWY0YxUVZqWkZ5N016dWFDay9PU2ZFMWlUODlCT0JPNU8r?=
 =?utf-8?B?eUR2OHRTaE85ZDErOE1OT2lUdlhxSjZRc09CK3MyZnZuNC9vSlgvcm1VWjAr?=
 =?utf-8?B?UG53WkNoVmhrZ21NeE9qQi9qUDVVVUpka3hNWFdaUE9rRnRITDM2TndHQW5q?=
 =?utf-8?B?OENXRmEyUm4yYUNtSlpVVzM3YTB3WjdRcXdFU3FZK2YybUVMdnU0Nytaa2hW?=
 =?utf-8?B?UG84WEZ5bXVKOGhwZEltS0JlekprK2cxTGV0TXJhNmN6ZVhWeWtWWWZFNE5U?=
 =?utf-8?B?UlB4bzIza20rbUluWnRDYndLOTZOckZnRzRqVm0xN1pTWTVrdjdINzlzaWtS?=
 =?utf-8?B?TTF4Uk9NRDZZQnBNSUxvUElucW52VjkwZmZiQXRZRDM5SmFiZDdCWlZ0SXVX?=
 =?utf-8?B?b1NFclpkVXAzc0JRQUV3YjBpSUlsTXBkMGRjMXQ2bFFhbEVwSVhCQ21vMmto?=
 =?utf-8?B?aWdSZ1RRRVAzMjNwRklqU3hRcEtKcitUWm9KSE9meDBZS3MyYnl4QnE3MCtr?=
 =?utf-8?B?MEEyTWYrWVhVcU5aQ0NqaXVnV0ZDdWtDNzhhajJaZWtLMUFZbGFRLzRoMXJE?=
 =?utf-8?B?Q2RmS095T1hxb1VZYmE1Ti9zN3RZcVRZczRWY3J0eDhnaGxYMlFUdjNMR3B0?=
 =?utf-8?B?dGFURG1XQWxndlc2Y1QxUWpXa2xQNTFNR2NNQ3VHeHdrVUZ2bTdtWjZRL2Nz?=
 =?utf-8?B?QlhRNGNucWVoUFRhTml5RHJBM1g4bFNLU1Y3emNUcEFndzFhWkRSYzNiQjVY?=
 =?utf-8?B?SUIwL0ZEb0w5Sno4ZzFLR28raU9vcmxkWkQ4dlphbmpDNlB6ZkZaTkYyR2g0?=
 =?utf-8?B?Y3lLTCtRWEg4ZFo4SWt0bHBkbmN6Ty8zNEdPL2psVzVwVGRUMHhrcFhpZE5V?=
 =?utf-8?B?dTNUUG9ybThCSzRBZGdqSUJITm9oVXhoTVBaVFNmb3FSVkFhaVQ1b1BWYmlr?=
 =?utf-8?B?WXBmYWZnMFF4eDRzbkh3dENXNExjTmJiOGEyVm95eGg2OTRFc3lPUkdDK1FS?=
 =?utf-8?B?RHVCcW1zQzY1MkwyV1ExZENGTlJNbjFCbEo3VEpyblJqam8xNnRvcEg5M2Mz?=
 =?utf-8?B?R3ZzeWs3NkNYbllHczZNdkkrNjBSTUpIM2hybGlNZS8xT3RyaUtwQTNPUXJv?=
 =?utf-8?B?bG5qcUtPVjF2TUNZdDIyUjJ4SUpmUnFWemRwMXdDN2o3Y1pYeXlnSXVFU2Qv?=
 =?utf-8?B?YWE5dXk1c1lxVWpQT053RVlBdWduSTU1ZHlWMFRXbFZUYjB5L3FJTVd4UVdJ?=
 =?utf-8?B?NEFwUnhmN2VZQlZpZkhiS2RFKzIzV3RaVDJTaWxmYXlUZE02b1N6VHl5YTg5?=
 =?utf-8?B?L3ZRcFFGR3dydWlFNlYxM3Q1SC9BOUV5K09lcEpMdjNvQlcyb2NZQXpCbkVE?=
 =?utf-8?B?SmpTSWNnUTRKZE41NXoxT0w0clFOMzM4dE8xTkNUZktCcjJpbnVlZU9NSFBC?=
 =?utf-8?B?Q3FuL2psY1d6R1NDeW9oeDltTkN4UlNqNEo2NWtwZG1neDltN3ZsZ3Vtekow?=
 =?utf-8?B?RlFKQlZhZXM4ZUl3d1lDczRkQzM2VXNUMit4dXpzclh4bTFwSkcxejgvdk1y?=
 =?utf-8?B?R2RaeWFrbmdSU2VIS1ZWRE1ocFFXbTN6d2pORmpleTUxdnl3aHBRWjhKQzMw?=
 =?utf-8?B?WXVxNzF5Snh0Q1I2bHpVY2lNL1J0UWZ3TW4xUmxBSUxUOGVCSWRMc3FCYVZn?=
 =?utf-8?Q?lgTJJlX4d4zLyMos=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1E7FC124D0713A4C9E88010D8E1F466E@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b48b9b60-3aff-4be6-eaae-08da0d184d24
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2022 21:58:45.0050
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8u1iTDw0uzlCvKgLfu9wjLv3wQRUIr5Nj2bAI9uP+PfFhjngZc+lTt1LIcEo37S9T0nDY2mCtQ99bNS86O1d1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB3595
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gV2VkLCAyMDIyLTAzLTIzIGF0IDIxOjMyICswMDAwLCBNYXR0aGV3IFdpbGNveCB3cm90ZToN
Cj4gT24gV2VkLCBNYXIgMjMsIDIwMjIgYXQgMDU6MTg6MzVQTSAtMDMwMCwgVGhpYWdvIEJlY2tl
ciB3cm90ZToNCj4gPiBSZWNlbnQgY2hhbmdlcyBpbiB0aGUgbGludXgga2VybmVsIGNhdXNlZCBO
RlMgcmVhZGFoZWFkIHRvIGRlZmF1bHQNCj4gPiB0bw0KPiA+IDEyOCBmcm9tIHRoZSBwcmV2aW91
cyBkZWZhdWx0IG9mIDE1ICogcnNpemUuIFRoaXMgY2F1c2VzDQo+ID4gcGVyZm9ybWFuY2UNCj4g
PiBwZW5hbHRpZXMgdG8gc29tZSByZWFkLWhlYXZ5IHdvcmtsb2Fkcywgd2hpY2ggY2FuIGJlIGZp
eGVkIGJ5DQo+ID4gdHVuaW5nIHRoZSByZWFkYWhlYWQgZm9yIHRoYXQgZ2l2ZW4gbW91bnQuDQo+
IA0KPiBXaGljaCByZWNlbnQgY2hhbmdlcz/CoCBTb21ldGhpbmcgaW4gTkZTIG9yIHNvbWV0aGlu
ZyBpbiB0aGUgVkZTL01NPw0KPiBEaWQgeW91IGV2ZW4gdGhpbmsgYWJvdXQgYXNraW5nIGEgd2lk
ZXIgYXVkaWVuY2UgdGhhbiB0aGUgTkZTIG1haWxpbmcNCj4gbGlzdD/CoCBJIG9ubHkgaGFwcGVu
ZWQgdG8gbm90aWNlIHRoaXMgd2hpbGUgSSB3YXMgbG9va2luZyBmb3INCj4gc29tZXRoaW5nDQo+
IGVsc2UsIG90aGVyd2lzZSBJIHdvdWxkIG5ldmVyIGhhdmUgc2VlbiBpdC7CoCBUaGUgcmVzcG9u
c2VzIGZyb20gb3RoZXINCj4gcGVvcGxlIHRvIHlvdXIgcGF0Y2hlcyB3ZXJlIHJpZ2h0OyB5b3Un
cmUgdHJ5aW5nIHRvIGRvIHRoaXMgYWxsDQo+IHdyb25nLg0KPiANCj4gTGV0J3Mgc3RhcnQgb3V0
IHdpdGggYSBidWcgcmVwb3J0IGluc3RlYWQgb2YgYSBzb2x1dGlvbi7CoCBXaGF0DQo+IGNoYW5n
ZWQNCj4gYW5kIHdoZW4/DQoNCkkgYmVsaWV2ZSBUaGlhZ28gaXMgdGFsa2luZyBhYm91dCB0aGUg
Y2hhbmdlcyBpbnRyb2R1Y2VkIGJ5IGNvbW1pdA0KYzEyOGU1NzU1MTRjICJORlM6IE9wdGltaXNl
IHRoZSBkZWZhdWx0IHJlYWRhaGVhZCBzaXplIiAoaS5lLiB3ZSdyZQ0KdGFsa2luZyBhYm91dCBM
aW51eCA1LjQpLg0KDQouLi5hbmQgeWVzLCBhcyB0aGUgY29tbWl0IGRlc2NyaXB0aW9uIG5vdGVz
LCB1c2VycyB3aG8gd2FudCB0byBjaGFuZ2UNCnRoZSBkZWZhdWx0IGNhbiBkbyBzbyB1c2luZyB0
aGUgc3RhbmRhcmQgc3lzZnMgbWVjaGFuaXNtLg0KQUZBSUNTLCBhbGwgdGhpcyBpcyBkb2luZyBp
cyBwcm92aWRpbmcgYSB0b29sc2V0IHRvIGFsbG93IHVzZXJzIHRvIG1vcmUNCmVhc2lseSBzZXQg
dXAgYW5kIGVkaXQgdGhlIHVkZXYgc2NyaXB0cyB0aGF0IHdpbGwgYXV0b21hdGUgdGhlc2UNCnNl
dHRpbmdzLg0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFp
bmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
