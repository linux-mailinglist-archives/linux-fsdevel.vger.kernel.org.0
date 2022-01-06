Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 236F0486A06
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jan 2022 19:36:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242917AbiAFSg4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jan 2022 13:36:56 -0500
Received: from mail-mw2nam12on2131.outbound.protection.outlook.com ([40.107.244.131]:10253
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242731AbiAFSg4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jan 2022 13:36:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i+r7h3NZSwsBYbUWWjB08VBNxHRydjl4/rJodfSN0ZLOl/XEMwvx6H/CjG2zcf3WPq04JDtCyqQ0NTLUOkTGlPG0GshmIqu17wOGx4JkYjA6IHshBl1ARlIHyJ5ia+xC635PvgV6Gq7TUWszn5/EFT2Hxo6HNNsqyyM9bdEmOed0lkASIx1TnylI7Ci/Yl8RJ1itCdx3qsz7Kc4BQiW9Ql2dL7M4IF6Sob2Q0FJ4xRmKBOn8IUkoKy57DYXMb9v0OO4dOID7Mgf0ELb7RNsm8d/DyMSnHZe5Gw+DWnVTygzMQMt2jMEfVqQeA7oZycopLDAiZManEVkMizztUMJU0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mxcru6ya9jDi70JWG9LI7J366EQV9NsbACUoHxGlAGA=;
 b=bAk/lE/2PcGkU6BWo9bHEVG3d1aOoAfMtYl5WPl2lZMHBqXw5esVChytlsFIdJnm9sMifDhJJB25KTz2igEeXxOZM+3zy3FZ1UezdIOokZlSl0sPaFvFHlfNwWl96rD6EmvBuQO9DO6MpEjFqt1AcZHV5Ec6NlSsRybbJi9ymHCCKxjLo0TTa4Day47hIm9LEGKXqwloPXP4LvGiXd9ildkXUYlnOMKX4nBYpvBY3Qtzin5MToaykT9DO6d88qhrBOdzajCHLE+Q/BA6JZ0lBIVVTYlPhAeDsbn9VcOOnuFqEJGOKzvLZCh/1g4gVPGJg4aQjnYuB4XRCjjKpECaow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mxcru6ya9jDi70JWG9LI7J366EQV9NsbACUoHxGlAGA=;
 b=dTgRhsOjy2IdcPpTW80hlN9teY4jOzb7bSNg6PX75kNS/afgPXbEuerz+BmK5QjdIqXp8Mn72049KQtaQcrZ69ZqkMCLvSkbIzd9k15NPAkoBOGuTsPut0PF4E44C9YfaifWDgS7Qg2gQssf4WTwRaURw734KOdaVfzbdeA/CTw=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CY4PR13MB1320.namprd13.prod.outlook.com (2603:10b6:903:9f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.6; Thu, 6 Jan
 2022 18:36:52 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::288c:e4f1:334a:a08]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::288c:e4f1:334a:a08%4]) with mapi id 15.20.4867.009; Thu, 6 Jan 2022
 18:36:52 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "david@fromorbit.com" <david@fromorbit.com>
CC:     "bfoster@redhat.com" <bfoster@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "trondmy@kernel.org" <trondmy@kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "willy@infradead.org" <willy@infradead.org>
Subject: Re: [PATCH] iomap: Address soft lockup in iomap_finish_ioend()
Thread-Topic: [PATCH] iomap: Address soft lockup in iomap_finish_ioend()
Thread-Index: AQHX/bVbnIYKv9Eyz0mlbt/BPMOEG6xL0+EAgABMs4CAAWrGAIAA5lqAgANuRQCAACHbgIAAFcSAgAGffQCAATe6gIAAIn2AgAFMBQA=
Date:   Thu, 6 Jan 2022 18:36:52 +0000
Message-ID: <28e975e8235a41c529bccb2bc0e73b4bb2d1e45e.camel@hammerspace.com>
References: <20211230193522.55520-1-trondmy@kernel.org>
         <Yc5f/C1I+N8MPHcd@casper.infradead.org>
         <6f746786a3928844fbe644e7e409008b4f50c239.camel@hammerspace.com>
         <20220101035516.GE945095@dread.disaster.area>
         <fb964769132eb01ed4e8b67d6972d50ee3387e24.camel@hammerspace.com>
         <20220103220310.GG945095@dread.disaster.area>
         <9f51fa6169f4c67d54dd8563b52c540c94c7703a.camel@hammerspace.com>
         <20220104012215.GH945095@dread.disaster.area>
         <0996c40657b5873dda5119344bf74556491e27b9.camel@hammerspace.com>
         <c9d9b7850c6086b123b4add4de7b1992cb62f6ad.camel@hammerspace.com>
         <20220105224829.GO945095@dread.disaster.area>
In-Reply-To: <20220105224829.GO945095@dread.disaster.area>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 88800141-2fb6-48af-de33-08d9d14381fa
x-ms-traffictypediagnostic: CY4PR13MB1320:EE_
x-microsoft-antispam-prvs: <CY4PR13MB1320D4F3CE5EF41D7BA820D4B84C9@CY4PR13MB1320.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7PEN/aAbUm3qjs7QF/R670Ph0mqdQtDqtXC4j5TMGIs2XHXPeLkmqFHaem8FJTXfgXvXt1OL1Mr/MM8Is/7wi5B/1rj3cHGKoS9RZibuZPYoTP1ZFHay0F/2k9qADC2OXxP4bNcTP3UQAlm6aFGKbWrhHezAASwO4OcBih9sxuE/F2wwEe7sSmvc5kWvOWy8Mxhf0+xzaqF0ALUrd53jJqwvbUOGEV2anGeJ17xkTxujYgQUMGJ1zmfGn1dLxMxG3Fr+8MN7YUo4LVGPrQYOZJsgW/LVdH+14kN8B5pXBtUl4NwUdcnL9pXYCVrCtSF3aKPLtYXXtn4Ty315kfFxGIlBhBB7jRA8GjgI/KKGPIVLsFoD1Y6zFZ5rBNOp9GGwiXK2oEbjwOro6vUTeJbVoJjRYgaBNlZ4MWduSGo3z6et2XW1GEPTClHKyA+yNPDjY1KXKiqMJe484wFauOfyRMFY1EKn5r6OIiEr9ODboc2HC4PPfDcj99PZhFaG48BI3p1oBBzB4vIbnJh82XofeZ7zsljbQ/7r27glriK+QlEbJe18rsUJu5qnU0l4jH+YqKTggfR4vt58yc5ZT1lcmrOFgN42keesRFH4/t9pDMovYvEAeEnDuoLu8xcOOYA0U5lZCJfxeILLPDbk9icPt3SOZ7vHot+C37/D9IGZcz8Xp8Y9z0zYl1lI49vPjUupwYDb4DBOehwFYT8lzOrwPg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(376002)(346002)(396003)(39830400003)(136003)(36756003)(83380400001)(54906003)(76116006)(6512007)(6916009)(26005)(66946007)(2616005)(6506007)(6486002)(186003)(4326008)(316002)(38070700005)(64756008)(508600001)(122000001)(38100700002)(86362001)(2906002)(71200400001)(5660300002)(66476007)(8676002)(66556008)(66446008)(8936002)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RmlyemJVZFRlUzN6am16UWRqbGp0dW02Q3EwVitUNGJZSnlEU2x4SUxMVjNG?=
 =?utf-8?B?WW45T3I1ZC9aTkl0ZWRGU2IweEsvRDdEN0lBekFsc3lDZ1VoREI0S3BFQzYr?=
 =?utf-8?B?WjNNb1JKc3gzaW0vcHhjcnRBWXNLV1JsTzIrazRZQklFTzZBeVZhaERHOFJk?=
 =?utf-8?B?dVlCNTBaWjRWR3hJMCsybUc0ZXBJbFhGdWJTQ0tJcjJXcGlTcnp1L21HbGpR?=
 =?utf-8?B?eC9tWHBQTXNOb00wM1ZJSWI3S3hacmRtNk5ZSnpRTDkzMTQvWkxZNWhqQ1F5?=
 =?utf-8?B?NnFJL21FREZPV3hqaGt5cmorYlltbXVlbkFvSTVIRjBiWkNGTDh0Zkh5ZEk0?=
 =?utf-8?B?Mml6T25PTHpETXN3UnI3UHdhUlRLWFNoNUJmcTBMWU9nbHBOS3dncWxDM3dr?=
 =?utf-8?B?UjFHbis5SnRPSkk1T1FDUDQ2blBrSEtWajFPc0pXdVU2SkxtQ0hKeThNbTQ3?=
 =?utf-8?B?bHJaR0RWajBqWi81UFEwZkRFd2E1NjNSdW82MXVTZ1dZQ290WGVmZHdSTisx?=
 =?utf-8?B?NVVtakpPbGtBYjRvbzZib2E0VzRnTFlZazBWcWhQMCtBSm91NFVEU1FSVW43?=
 =?utf-8?B?Y2pNMmJ6TnVadFg1cC9KV3M5VW00aUVzZXdjK0JjNGNXQTdvMFhjZG5mMmtr?=
 =?utf-8?B?ekdMVEg2amU1cXFaajRlOXJGUFk2cE5Fekw5VHdQaFhCS1VlZHFLVE5GNmZB?=
 =?utf-8?B?eVVTWGFqTm5UUXlvenNLT2pXK3JJMmhXd1Ftck9sY0h1aVpVMHhrTm5Pbkw1?=
 =?utf-8?B?TWNTczk4SnFCNFRncjN1YlQzNmxWMlZPeVY4YkdNUnpDVkZoQXFUMDdXR0JC?=
 =?utf-8?B?N0hQV2lYVWtnTVhmcnpma3kwYk5jS3FvOWJkVzRocDBVc1lCWkRwajBEN1ZD?=
 =?utf-8?B?V0RSMDhZRUJKdXZONkFIU3BTWnBwaDlOM1ZpK05vTCtoWVNJZjFHNE9vMEFG?=
 =?utf-8?B?RUZwQXFwMXcxOERDZjdkL3JWN291SlhlT1MvaXYxZVdkYTNKSVVaMHZxejlz?=
 =?utf-8?B?TjhteW9PTzNmRGhvQXRGSmR5dE9URVZFMzYwTzN3OHFnY2tqRG5NMzB3dDJ0?=
 =?utf-8?B?L3h2ZGVUNDg4ODN0VGR6T3IrM0xHZWVWK2FXVGJlZEppWDJyeU5ZQ1FTK1VL?=
 =?utf-8?B?NlJHMEZGdVhDRWtuekV0MkdUOTFnS3ZOYVVkdE45VGxmem91QTlJSFBta0Ix?=
 =?utf-8?B?Q3ZqeHpLYThQQ2JVMnVaNWRMN1ZzRHdHcGJCZlMxREJYT0JKQjVxZ1ZaZnhN?=
 =?utf-8?B?dTNFNUNQMnYvQnQ2SGhzaE5PT2NUenRtemp1WTlZcnM1OXlqME9QczNDYWZi?=
 =?utf-8?B?VGViY0pkNnpXUmdkSi9TeS82SEJVNXdsZ01sMEpMbzRobVNuNjZpK1B0eWZW?=
 =?utf-8?B?OVdsVERXakYrWnFMSUc1Sno1REwwT2JxaVZFRHgwNTFYNm43T1dsREVUNE0x?=
 =?utf-8?B?MGRLcXg1TXNaT1NQNmNUc1IyWWNHVUZHd1RRdmNNR21vYmZNMmRsUXJyMGc0?=
 =?utf-8?B?N21iSElReXVOT3FFczQycXNYSWRjK29lUTVkQmhHK3RRKy82RUZPQVd3Z0I4?=
 =?utf-8?B?cnVNL2FuT3BvS2pNaGdoN3dvQ2RiQUIvK0lBRjBhT0JnWFozQkowVTl6bXdO?=
 =?utf-8?B?Z1RsVVNmZTlBa25rQ3NUakRLWUpJei9hbUdtZVRicjk5OG1vV1hwbXZvNW43?=
 =?utf-8?B?ME1icG1NRHFxQzhCem9LMHZkbzd5NGlKRzZJMWduYWVOV1h6UmUvay96dGIz?=
 =?utf-8?B?Rmg4WlB2RTlQUG0rRlRYb0JtN2lGVlBVUDliZERVZGxmZ3dUYnZOZHZiYU41?=
 =?utf-8?B?YmV4TFVxTzk2Ui84QUJiMm83V3dJbXBLYzUwNlM2OTJRcmJoQ09xbVMwREo1?=
 =?utf-8?B?bjdYNXM0SFplNjQ4UGZ3YmFuK1cxYWh6MGxuWGlybzhMbTNYRjEvMnhQYWox?=
 =?utf-8?B?cXdoenNmWEphZjNvclFUVndkdFFBNkw4RWE5cndGSnovNzVKNS9lM1AxZEoy?=
 =?utf-8?B?OWoyOVFmSDh6M1lhbFJoZlM2ZEtLdTNQa3lMNW9NK3BWOUlDVHNJRVczcGNU?=
 =?utf-8?B?RW9NVXBra1JIdnNWd1NCMnRSVlZnQ1VkMUVaL1EvR2xsVFl0c3F4NG1iUnl2?=
 =?utf-8?B?WFVaVU4xV1FLSnpzbCtJeEpmNUc2QWRoSDEyd09VckRBcWIzVHBic3JBV2w2?=
 =?utf-8?Q?/9eV3x7gGxLdDPYgJMsfgTE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DBD156842731C146B88AD2EDD737480A@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88800141-2fb6-48af-de33-08d9d14381fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2022 18:36:52.2594
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y2jo/ZQffig6HkQkmnJtjWaR8C1Qs8jgLLbh4Cc4IgkYJ36JE6245n7pwiNTHc0DzvfLFNGahbY4s3YC1qdgEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR13MB1320
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gVGh1LCAyMDIyLTAxLTA2IGF0IDA5OjQ4ICsxMTAwLCBEYXZlIENoaW5uZXIgd3JvdGU6DQo+
IE9uIFdlZCwgSmFuIDA1LCAyMDIyIGF0IDA4OjQ1OjA1UE0gKzAwMDAsIFRyb25kIE15a2xlYnVz
dCB3cm90ZToNCj4gPiBPbiBUdWUsIDIwMjItMDEtMDQgYXQgMjE6MDkgLTA1MDAsIFRyb25kIE15
a2xlYnVzdCB3cm90ZToNCj4gPiA+IE9uIFR1ZSwgMjAyMi0wMS0wNCBhdCAxMjoyMiArMTEwMCwg
RGF2ZSBDaGlubmVyIHdyb3RlOg0KPiA+ID4gPiBPbiBUdWUsIEphbiAwNCwgMjAyMiBhdCAxMjow
NDoyM0FNICswMDAwLCBUcm9uZCBNeWtsZWJ1c3QNCj4gPiA+ID4gd3JvdGU6DQo+ID4gPiA+ID4g
V2UgaGF2ZSBkaWZmZXJlbnQgcmVwcm9kdWNlcnMuIFRoZSBjb21tb24gZmVhdHVyZSBhcHBlYXJz
IHRvDQo+ID4gPiA+ID4gYmUNCj4gPiA+ID4gPiB0aGUNCj4gPiA+ID4gPiBuZWVkIGZvciBhIGRl
Y2VudGx5IGZhc3QgYm94IHdpdGggZmFpcmx5IGxhcmdlIG1lbW9yeSAoMTI4R0INCj4gPiA+ID4g
PiBpbg0KPiA+ID4gPiA+IG9uZQ0KPiA+ID4gPiA+IGNhc2UsIDQwMEdCIGluIHRoZSBvdGhlciku
IEl0IGhhcyBiZWVuIHJlcHJvZHVjZWQgd2l0aCBIRHMsDQo+ID4gPiA+ID4gU1NEcw0KPiA+ID4g
PiA+IGFuZA0KPiA+ID4gPiA+IE5WTUUgc3lzdGVtcy4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBP
biB0aGUgMTI4R0IgYm94LCB3ZSBoYWQgaXQgc2V0IHVwIHdpdGggMTArIGRpc2tzIGluIGEgSkJP
RA0KPiA+ID4gPiA+IGNvbmZpZ3VyYXRpb24gYW5kIHdlcmUgcnVubmluZyB0aGUgQUpBIHN5c3Rl
bSB0ZXN0cy4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBPbiB0aGUgNDAwR0IgYm94LCB3ZSB3ZXJl
IGp1c3Qgc2VyaWFsbHkgY3JlYXRpbmcgbGFyZ2UgKD4NCj4gPiA+ID4gPiA2R0IpDQo+ID4gPiA+
ID4gZmlsZXMNCj4gPiA+ID4gPiB1c2luZyBmaW8gYW5kIHRoYXQgd2FzIG9jY2FzaW9uYWxseSB0
cmlnZ2VyaW5nIHRoZSBpc3N1ZS4NCj4gPiA+ID4gPiBIb3dldmVyDQo+ID4gPiA+ID4gZG9pbmcN
Cj4gPiA+ID4gPiBhbiBzdHJhY2Ugb2YgdGhhdCB3b3JrbG9hZCB0byBkaXNrIHJlcHJvZHVjZWQg
dGhlIHByb2JsZW0NCj4gPiA+ID4gPiBmYXN0ZXINCj4gPiA+ID4gPiA6LQ0KPiA+ID4gPiA+ICku
DQo+ID4gPiA+IA0KPiA+ID4gPiBPaywgdGhhdCBtYXRjaGVzIHVwIHdpdGggdGhlICJsb3RzIG9m
IGxvZ2ljYWxseSBzZXF1ZW50aWFsDQo+ID4gPiA+IGRpcnR5DQo+ID4gPiA+IGRhdGEgb24gYSBz
aW5nbGUgaW5vZGUgaW4gY2FjaGUiIHZlY3RvciB0aGF0IGlzIHJlcXVpcmVkIHRvDQo+ID4gPiA+
IGNyZWF0ZQ0KPiA+ID4gPiByZWFsbHkgbG9uZyBiaW8gY2hhaW5zIG9uIGluZGl2aWR1YWwgaW9l
bmRzLg0KPiA+ID4gPiANCj4gPiA+ID4gQ2FuIHlvdSB0cnkgdGhlIHBhdGNoIGJlbG93IGFuZCBz
ZWUgaWYgYWRkcmVzc2VzIHRoZSBpc3N1ZT8NCj4gPiA+ID4gDQo+ID4gPiANCj4gPiA+IFRoYXQg
cGF0Y2ggZG9lcyBzZWVtIHRvIGZpeCB0aGUgc29mdCBsb2NrdXBzLg0KPiA+ID4gDQo+ID4gDQo+
ID4gT29wcy4uLiBTdHJpa2UgdGhhdCwgYXBwYXJlbnRseSBvdXIgdGVzdHMganVzdCBoaXQgdGhl
IGZvbGxvd2luZw0KPiA+IHdoZW4NCj4gPiBydW5uaW5nIG9uIEFXUyB3aXRoIHRoYXQgcGF0Y2gu
DQo+IA0KPiBPSywgc28gdGhlcmUgYXJlIGFsc28gbGFyZ2UgY29udGlndW91cyBwaHlzaWNhbCBl
eHRlbnRzIGJlaW5nDQo+IGFsbG9jYXRlZCBpbiBzb21lIGNhc2VzIGhlcmUuDQo+IA0KPiA+IFNv
IGl0IHdhcyBoYXJkZXIgdG8gaGl0LCBidXQgd2Ugc3RpbGwgZGlkIGV2ZW50dWFsbHkuDQo+IA0K
PiBZdXAsIHRoYXQncyB3aGF0IEkgd2FudGVkIHRvIGtub3cgLSBpdCBpbmRpY2F0ZXMgdGhhdCBi
b3RoIHRoZQ0KPiBmaWxlc3lzdGVtIGNvbXBsZXRpb24gcHJvY2Vzc2luZyBhbmQgdGhlIGlvbWFw
IHBhZ2UgcHJvY2Vzc2luZyBwbGF5DQo+IGEgcm9sZSBpbiB0aGUgQ1BVIHVzYWdlLiBNb3JlIGNv
bXBsZXggcGF0Y2ggZm9yIHlvdSB0byB0cnkgYmVsb3cuLi4NCj4gDQo+IENoZWVycywNCj4gDQo+
IERhdmUuDQoNCkhpIERhdmUsDQoNClRoaXMgcGF0Y2ggZ290IGZ1cnRoZXIgdGhhbiB0aGUgcHJl
dmlvdXMgb25lLiBIb3dldmVyIGl0IHRvbyBmYWlsZWQgb24NCnRoZSBzYW1lIEFXUyBzZXR1cCBh
ZnRlciB3ZSBzdGFydGVkIGNyZWF0aW5nIGxhcmdlciAoaW4gdGhpcyBjYXNlIDUyR0IpDQpmaWxl
cy4gVGhlIHByZXZpb3VzIHBhdGNoIGZhaWxlZCBhdCAxNUdCLg0KDQpOUl8wNi0xODowMDoxNyBw
bS00NjA4OERTWDEgL21udC9kYXRhLXBvcnRhbC9kYXRhICQgbHMgLWxoDQp0b3RhbCA1OUcNCi1y
dy1yLS0tLS0gMSByb290IHJvb3QgIDUyRyBKYW4gIDYgMTg6MjAgMTAwZw0KLXJ3LXItLS0tLSAx
IHJvb3Qgcm9vdCA5LjhHIEphbiAgNiAxNzozOCAxMGcNCi1ydy1yLS0tLS0gMSByb290IHJvb3Qg
ICAyOSBKYW4gIDYgMTc6MzYgZmlsZQ0KTlJfMDYtMTg6MjA6MTAgcG0tNDYwODhEU1gxIC9tbnQv
ZGF0YS1wb3J0YWwvZGF0YSAkDQpNZXNzYWdlIGZyb20gc3lzbG9nZEBwbS00NjA4OERTWDEgYXQg
SmFuICA2IDE4OjIyOjQ0IC4uLg0KIGtlcm5lbDpbIDU1NDguMDgyOTg3XSB3YXRjaGRvZzogQlVH
OiBzb2Z0IGxvY2t1cCAtIENQVSMxMCBzdHVjayBmb3INCjI0cyEgW2t3b3JrZXIvMTA6MDoxODk5
NV0NCk1lc3NhZ2UgZnJvbSBzeXNsb2dkQHBtLTQ2MDg4RFNYMSBhdCBKYW4gIDYgMTg6MjM6NDQg
Li4uDQoga2VybmVsOlsgNTYwOC4wODI4OTVdIHdhdGNoZG9nOiBCVUc6IHNvZnQgbG9ja3VwIC0g
Q1BVIzEwIHN0dWNrIGZvcg0KMjNzISBba3dvcmtlci8xMDowOjE4OTk1XQ0KTWVzc2FnZSBmcm9t
IHN5c2xvZ2RAcG0tNDYwODhEU1gxIGF0IEphbiAgNiAxODoyNzowOCAuLi4NCiBrZXJuZWw6WyA1
ODEyLjA4MjU4N10gd2F0Y2hkb2c6IEJVRzogc29mdCBsb2NrdXAgLSBDUFUjMTAgc3R1Y2sgZm9y
DQoyMnMhIFtrd29ya2VyLzEwOjA6MTg5OTVdDQpNZXNzYWdlIGZyb20gc3lzbG9nZEBwbS00NjA4
OERTWDEgYXQgSmFuICA2IDE4OjI3OjM2IC4uLg0KIGtlcm5lbDpbIDU4NDAuMDgyNTMzXSB3YXRj
aGRvZzogQlVHOiBzb2Z0IGxvY2t1cCAtIENQVSMxMCBzdHVjayBmb3INCjIxcyEgW2t3b3JrZXIv
MTA6MDoxODk5NV0NCk1lc3NhZ2UgZnJvbSBzeXNsb2dkQHBtLTQ2MDg4RFNYMSBhdCBKYW4gIDYg
MTg6Mjg6MDggLi4uDQoga2VybmVsOlsgNTg3Mi4wODI0NTVdIHdhdGNoZG9nOiBCVUc6IHNvZnQg
bG9ja3VwIC0gQ1BVIzEwIHN0dWNrIGZvcg0KMjFzISBba3dvcmtlci8xMDowOjE4OTk1XQ0KTWVz
c2FnZSBmcm9tIHN5c2xvZ2RAcG0tNDYwODhEU1gxIGF0IEphbiAgNiAxODoyODo0MCAuLi4NCiBr
ZXJuZWw6WyA1OTA0LjA4MjQwMF0gd2F0Y2hkb2c6IEJVRzogc29mdCBsb2NrdXAgLSBDUFUjMTAg
c3R1Y2sgZm9yDQoyMXMhIFtrd29ya2VyLzEwOjA6MTg5OTVdDQpNZXNzYWdlIGZyb20gc3lzbG9n
ZEBwbS00NjA4OERTWDEgYXQgSmFuICA2IDE4OjI5OjE2IC4uLg0KIGtlcm5lbDpbIDU5NDAuMDgy
MjQzXSB3YXRjaGRvZzogQlVHOiBzb2Z0IGxvY2t1cCAtIENQVSMxMCBzdHVjayBmb3INCjIxcyEg
W2t3b3JrZXIvMTA6MDoxODk5NV0NCk1lc3NhZ2UgZnJvbSBzeXNsb2dkQHBtLTQ2MDg4RFNYMSBh
dCBKYW4gIDYgMTg6Mjk6NDQgLi4uDQoga2VybmVsOlsgNTk2OC4wODIyNDldIHdhdGNoZG9nOiBC
VUc6IHNvZnQgbG9ja3VwIC0gQ1BVIzEwIHN0dWNrIGZvcg0KMjJzISBba3dvcmtlci8xMDowOjE4
OTk1XQ0KTWVzc2FnZSBmcm9tIHN5c2xvZ2RAcG0tNDYwODhEU1gxIGF0IEphbiAgNiAxODozMDoy
NCAuLi4NCiBrZXJuZWw6WyA2MDA4LjA4MjIwNF0gd2F0Y2hkb2c6IEJVRzogc29mdCBsb2NrdXAg
LSBDUFUjMTAgc3R1Y2sgZm9yDQoyMXMhIFtrd29ya2VyLzEwOjA6MTg5OTVdDQpNZXNzYWdlIGZy
b20gc3lzbG9nZEBwbS00NjA4OERTWDEgYXQgSmFuICA2IDE4OjMxOjA4IC4uLg0KIGtlcm5lbDpb
IDYwNTIuMDgyMTk0XSB3YXRjaGRvZzogQlVHOiBzb2Z0IGxvY2t1cCAtIENQVSMxMCBzdHVjayBm
b3INCjI0cyEgW2t3b3JrZXIvMTA6MDoxODk5NV0NCk1lc3NhZ2UgZnJvbSBzeXNsb2dkQHBtLTQ2
MDg4RFNYMSBhdCBKYW4gIDYgMTg6MzE6NDggLi4uDQoga2VybmVsOlsgNjA5Mi4wODIwMTBdIHdh
dGNoZG9nOiBCVUc6IHNvZnQgbG9ja3VwIC0gQ1BVIzEwIHN0dWNrIGZvcg0KMjFzISBba3dvcmtl
ci8xMDowOjE4OTk1XQ0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBt
YWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0K
DQoNCg==
