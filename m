Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0FB48710B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jan 2022 04:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbiAGDIx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jan 2022 22:08:53 -0500
Received: from mail-dm6nam12on2108.outbound.protection.outlook.com ([40.107.243.108]:38369
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229769AbiAGDIx (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jan 2022 22:08:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EOLvnOB3oxD8FA7hX4aMC3lxH9zP+Xmq7otSwqURM0XsFHP52OcpgUxRtWRzG6WjpwgTalfyUbTy/rrfLw+XrG0GmpShGwnYGTjKoSNBjXZK9846+1yf21CX+sNxc7K/pFVErYGdgiycBzEpWEexJxgGPPi5NOGT0FWGLM/PwO3aSPzEQv/FS7FhsB5IZhvAWN2GvZxLOQRRcZHbn4tJHo/p7WqnEea/a4Do6tqtMC7H+2gWVCA7CZjFOlcwMNwnLx4H2QDAf6YT4MvTM0F7J35PoDl3X85nbiBP+YChaQ9DAbrRUj+UUUG5FgGmadQxCUbkT6WmwkWetLc+4jVhSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=318BWoXeSWHB+7m6jjMf3Ejnw53o8vx7o3IgAIl9cfw=;
 b=eIfzVYuwhVCBT5gA8BfqM+nfoVoOriXpVDN7QKUMOKp2NduWUQqJrCHGgjbslWmYbyKmGQDg+2Ui3w9LICdbF4f68efBPkjbB3vTO8XOyISoXwXC+8ZIM8XLDbzz5NiSlg25sH2M6DJ9+putC82NccId3qqbh4u9i9ux0lKZ8rGOLHzEKnc6P95W2WZe7yjGUKedXZFbddTK0BSyTsuN/0zjJWGHbdhHYodpLNBVL5FsFFr00oVypfgLjZaU7anp61PcqokmbjjVlQ0GgCZl5Aw7UOAxAMy3sF/cfc2aHQkNzCn93ronn7gHCkS2wbI2iBUBW7/NNW4hss0L7MRCXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=318BWoXeSWHB+7m6jjMf3Ejnw53o8vx7o3IgAIl9cfw=;
 b=f0jXsSbQ1Go3pwFYu0I6725q8QU1COn1ZhnpnnQHpCjOXuvpvkVrb94mE1I4BisCnaaiipTK6XPfu7oX2g0zKKx3AgfiVFyLA3BHr0Y8R/HlYfFwb/og/Sreima0VMeX5rPAS8wMmUWhxh0ryhwQNRJRQiBs+U9GiU7INQgDIOs=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CY4PR13MB1349.namprd13.prod.outlook.com (2603:10b6:903:a0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.4; Fri, 7 Jan
 2022 03:08:49 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::288c:e4f1:334a:a08]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::288c:e4f1:334a:a08%4]) with mapi id 15.20.4867.009; Fri, 7 Jan 2022
 03:08:48 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bfoster@redhat.com" <bfoster@redhat.com>
CC:     "david@fromorbit.com" <david@fromorbit.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "trondmy@kernel.org" <trondmy@kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "willy@infradead.org" <willy@infradead.org>
Subject: Re: [PATCH] iomap: Address soft lockup in iomap_finish_ioend()
Thread-Topic: [PATCH] iomap: Address soft lockup in iomap_finish_ioend()
Thread-Index: AQHX/bVbnIYKv9Eyz0mlbt/BPMOEG6xL0+EAgABMs4CAAWrGAIAA5lqAgANuRQCAACHbgIAAFcSAgAGffQCAATe6gIAAIn2AgAFMBQCAABlwgIAAdZqA
Date:   Fri, 7 Jan 2022 03:08:48 +0000
Message-ID: <b7eb3f2cf7a2c819f38c647f4247ff1de80e19b9.camel@hammerspace.com>
References: <6f746786a3928844fbe644e7e409008b4f50c239.camel@hammerspace.com>
         <20220101035516.GE945095@dread.disaster.area>
         <fb964769132eb01ed4e8b67d6972d50ee3387e24.camel@hammerspace.com>
         <20220103220310.GG945095@dread.disaster.area>
         <9f51fa6169f4c67d54dd8563b52c540c94c7703a.camel@hammerspace.com>
         <20220104012215.GH945095@dread.disaster.area>
         <0996c40657b5873dda5119344bf74556491e27b9.camel@hammerspace.com>
         <c9d9b7850c6086b123b4add4de7b1992cb62f6ad.camel@hammerspace.com>
         <20220105224829.GO945095@dread.disaster.area>
         <28e975e8235a41c529bccb2bc0e73b4bb2d1e45e.camel@hammerspace.com>
         <YddMGRQrYOWr6V9A@bfoster>
In-Reply-To: <YddMGRQrYOWr6V9A@bfoster>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3a7f4468-b8e4-46d4-a12e-08d9d18b0686
x-ms-traffictypediagnostic: CY4PR13MB1349:EE_
x-microsoft-antispam-prvs: <CY4PR13MB1349CBC81E511247B019881CB84D9@CY4PR13MB1349.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XG+IdMKZgfP5VLe2n+u7VIA648XUyxhw+HYVrWt2LN8ltTgtNgXpb8mo3q0UUIW8TaUp+XYCv0AZ8/ZeDHxxgnHcOcX2zLy0HkJx3Y1TbI2W42u+OE1L5NT7V/zY0x159wFWblYbF/YXO7FURujRAZa6SDvm3e8IdEI+SsTBXvZo70kyZn/PViqq7ca36Aw1APGnOXc8w4Ke2lKLMSXTj6rYcwvSgoL5/fkB31iuX+LMefR8uQzP1f7wcBXmFjH/+CmX8zSC/4MLZzZJ7BT2TCJCAXkpY+KqfoTSlw6PjITlrBl1l1e2/Gpr3zxz9dxT+AB6ZU6bgxs4eTCu6E5bxIBFpzttJrOLtGkuhoyLnktE3i6Wkc7+9FHXrGO6NHQVT/eSch3XDMrwP6SDXy9cTfGYgT24jXa0s2Cra48E2lIsP2ONqMWpLKKmjpgscki65Kwbu7yw1+T3pu1PPxVg8bzH9K3s6m93AzLwSH5CaGT8CIMrkwFTp6/OLIsx9yxAkJ8NnL9F4OGYjZSMEI/nUemYEJUoVdLYdDLZ3BlwOOjhFfAyKZfr8MSXdghpXQbh7oIbYxYmKu8I7qVE1kBIr8CUTfXYkgztFNkPh5DgBPYCR8URrulMt/2qZhtrxCHg+EAaflpku2TCPEgY/NkZdd5KP/MLuPUwIghpwAzjra3lQQvQc2QB2T1yp6e4z/PNp4NZA/kUvYZJx9Qqqyko3QPmEdOdHX9zoT4Sp8XSe+Qj6MpNRYuMy/WfotVTPkrP8GgbFLCvIrIoCfGxfQ+RllmoYUoIzBFOYZKVwVQ0daI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(376002)(136003)(396003)(39840400004)(346002)(366004)(2906002)(6512007)(508600001)(2616005)(86362001)(4326008)(36756003)(6506007)(966005)(6486002)(38100700002)(66446008)(316002)(5660300002)(66946007)(8936002)(71200400001)(122000001)(66556008)(6916009)(76116006)(26005)(54906003)(38070700005)(8676002)(66476007)(83380400001)(64756008)(186003)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VEg5N0krYkdSWlo4bFhBTGJnY3cvQmtJR05SclRlQy9rbkZlYUh0OTFDWkRr?=
 =?utf-8?B?M28zWFIrRjBwb290cDFXZHR0R1hNZmJKT3VFdXNvZTRlckdPeGF5M0g4SkVH?=
 =?utf-8?B?YTZsaTgvLy9yNEZUMFFCUEZ3NTRrN1poakdDNElhajdxYkpwdWdST05hMTZx?=
 =?utf-8?B?MlZFZS9icmZDNm14R0EzU2U2eE1EKzhDSEdZSEZrY0NjMnB5em03UFEwWHZz?=
 =?utf-8?B?Ui9XbTZkdjJDZDdtRHliV1pmd0FQWHdxYkFrRk5tZmU1dUhSVkJXUkdWYXRD?=
 =?utf-8?B?UUZnWkV2N3l2bUdyOUFodWVzS2NTYUVaTGVzK0l2VG5EVmZsaVVsQnZadDAz?=
 =?utf-8?B?cXBrVEJwNGNYSUJaVEhyK1lzRnJFNzc5N29TTjFsWkE5bElkc1kwVmQ4OHFs?=
 =?utf-8?B?aXA0WGsyYWx1Y2ZSTHo4M0tRSVZPQXRTa2liZ3IrU1Jyb1ZTWkpHL2QzbmVh?=
 =?utf-8?B?dnp1OGpjY0tjaGV4S055cnpRUXRWcnhmTFZncnl6K3gyQjFjd0tpUW9OeENT?=
 =?utf-8?B?N3J2UkpkUGRzN3lOTzBPV016RjZvbXJ2b0U1cHdsakt2ME5vTzA3QnVTU2wz?=
 =?utf-8?B?UGtMNHBnbzlVUDhEYVBIYmZWUzZPNE5adjRrSmdrTFB5MFQrNnRtenorTUdv?=
 =?utf-8?B?LzJ0bjU2dkR1bS9PZVZpNVh5VjRNWVEvZjZsR1ArTU9yMCtnNXphQjdTTm5B?=
 =?utf-8?B?WEh5THlyVUlJY1VLaWpiNEd1Z2MxazFOQ1Q1SXVxNTl4U2hvL1ZES09qMi9S?=
 =?utf-8?B?R2RPQTR2MWwzMzN1QkFhM0pORXgyeEsxSmd5YytYc21pOUFUaGNYOHR4RC8z?=
 =?utf-8?B?RWVlMGdWdGtvUlV6akFoNWo3RTdzYjNpZXZOMWZaZ29Md3dobDVlYzBRM1Uy?=
 =?utf-8?B?a1lJUzJoOXgzcXQ0alE3UGlQaUdxYnAzVU5wb3NlRk1Sdm45aHFyNjU3T3V0?=
 =?utf-8?B?OEM0N1BycGZnYmxqSldHZnV2OWZ2ZTdDRVc0aEI4YmtOY05na3hkNEUveCtT?=
 =?utf-8?B?VTY4WVVBaVM3ZnVWVDgwTFBXdE1WbUxnT3JZTmUvZjBHR29qOUhuRTZqRmpJ?=
 =?utf-8?B?cnJQZlVvUjNqRzJWY2JLYjVUOGpnellMeVBKL0FWVEZlSTdGOHZBRE9BU0dr?=
 =?utf-8?B?d1gzSW9GUHVjZkhqazQ3OXlBQ2JBSm5KZ3VoMjRVZ1E0WW4yZE1EYjlIdFBs?=
 =?utf-8?B?b1ZZODgrTkhSRGJPVFFYaVcycDNSdzI4Z3VBeVNESlp5cmdBMEF1NmQ2TXhQ?=
 =?utf-8?B?ZlFtZzJKTHVNMUNrS09nUkFDT29md2FqR1JvczRGYlRzcUlLL0xJOHBndTZW?=
 =?utf-8?B?YVJLN1o0SHNvSnJtZkVzZ0lva3dONlN2MS9LeTY2Vk5WMStNb2pkcDRiREdv?=
 =?utf-8?B?L0ZUZjEwSW4xTXBYck40bE8xaE5tOWZES1VseW81aFNld3dOL0RNNGMvYmVs?=
 =?utf-8?B?UTZlaWJJSmxqWWRWNjBBUVlvQStseG5CYVpCZ2pnbTdJeFNPZ0F0VlN4anBl?=
 =?utf-8?B?cUJoRUhlZmxiNUVoVjF0aGtjN3hRY3lCdWYyejRYcHVKRlNud0hLeGJSUHB0?=
 =?utf-8?B?a1gxRlVEajR1bEE2MTNVa2ZRYUtLeXNEZnF2ZVo0TDYxbVBuemh3bmxNMFlE?=
 =?utf-8?B?aVNVTDdNMVg2b3dDL2JXZVpEc1NtL1NjV2hKY01DY0RQR0hMd210K0d0cDlK?=
 =?utf-8?B?K2xtbkllb285dWUxanRTMlVoWG5DZ3VzbmZMOTYzUzFEbDJqdlptZWVVVm1Z?=
 =?utf-8?B?S1dHdXJJYlhPMjhUeDFYQTB0UFl2cVhvYW14NjZCa2k1cEMrUnJUVkFHYVlK?=
 =?utf-8?B?amhhb1dMWHBOM1lsWmcwdC9wUjNCcXBLb1BybzNvQ0dwSXY2cEVNZVIyOXlo?=
 =?utf-8?B?WGxZSWhZN2w0U3g2TzFWRnk0U3FNbnZpRnNFQ0V1ajJBLzVPODlHa3d2akRx?=
 =?utf-8?B?TGM0MlU1Sk9HYmdxMzRxOW5INVJIcklHVGdnazJqalRQSGpsa0RBTFdLb0x1?=
 =?utf-8?B?VWl6TzFlRU9QcDM3VWlXTnRidWwwbHR5ZWlqOVAxdHB4TC9LbngyWDh2bWpH?=
 =?utf-8?B?NFE4Z1MxbUFOT2tKVS9Xbkt0ZzNHZktoMVVPUmxHYkUwRTZENEcramowNFh1?=
 =?utf-8?B?V1RJeSt6OFRwVDhtZWtZdHNzOVZHUDRUWTBXVUpaNklmdVpmY2pHOTRVbWxW?=
 =?utf-8?Q?xZDzCJ3nTmuq90QNbzav8DI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3E84E8DAB2854341B6DCB64AC32E45FF@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a7f4468-b8e4-46d4-a12e-08d9d18b0686
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2022 03:08:48.8656
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1+D5Xkz0EXnNGfxWsyizwB1Fvcg805GOmne5LtaqI7QKYK2X6mCpvcLKZcuAp8xOH6wzGQCWKQdTcKvYvtVzWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR13MB1349
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gVGh1LCAyMDIyLTAxLTA2IGF0IDE1OjA3IC0wNTAwLCBCcmlhbiBGb3N0ZXIgd3JvdGU6DQo+
IE9uIFRodSwgSmFuIDA2LCAyMDIyIGF0IDA2OjM2OjUyUE0gKzAwMDAsIFRyb25kIE15a2xlYnVz
dCB3cm90ZToNCj4gPiBPbiBUaHUsIDIwMjItMDEtMDYgYXQgMDk6NDggKzExMDAsIERhdmUgQ2hp
bm5lciB3cm90ZToNCj4gPiA+IE9uIFdlZCwgSmFuIDA1LCAyMDIyIGF0IDA4OjQ1OjA1UE0gKzAw
MDAsIFRyb25kIE15a2xlYnVzdCB3cm90ZToNCj4gPiA+ID4gT24gVHVlLCAyMDIyLTAxLTA0IGF0
IDIxOjA5IC0wNTAwLCBUcm9uZCBNeWtsZWJ1c3Qgd3JvdGU6DQo+ID4gPiA+ID4gT24gVHVlLCAy
MDIyLTAxLTA0IGF0IDEyOjIyICsxMTAwLCBEYXZlIENoaW5uZXIgd3JvdGU6DQo+ID4gPiA+ID4g
PiBPbiBUdWUsIEphbiAwNCwgMjAyMiBhdCAxMjowNDoyM0FNICswMDAwLCBUcm9uZCBNeWtsZWJ1
c3QNCj4gPiA+ID4gPiA+IHdyb3RlOg0KPiA+ID4gPiA+ID4gPiBXZSBoYXZlIGRpZmZlcmVudCBy
ZXByb2R1Y2Vycy4gVGhlIGNvbW1vbiBmZWF0dXJlIGFwcGVhcnMNCj4gPiA+ID4gPiA+ID4gdG8N
Cj4gPiA+ID4gPiA+ID4gYmUNCj4gPiA+ID4gPiA+ID4gdGhlDQo+ID4gPiA+ID4gPiA+IG5lZWQg
Zm9yIGEgZGVjZW50bHkgZmFzdCBib3ggd2l0aCBmYWlybHkgbGFyZ2UgbWVtb3J5DQo+ID4gPiA+
ID4gPiA+ICgxMjhHQg0KPiA+ID4gPiA+ID4gPiBpbg0KPiA+ID4gPiA+ID4gPiBvbmUNCj4gPiA+
ID4gPiA+ID4gY2FzZSwgNDAwR0IgaW4gdGhlIG90aGVyKS4gSXQgaGFzIGJlZW4gcmVwcm9kdWNl
ZCB3aXRoDQo+ID4gPiA+ID4gPiA+IEhEcywNCj4gPiA+ID4gPiA+ID4gU1NEcw0KPiA+ID4gPiA+
ID4gPiBhbmQNCj4gPiA+ID4gPiA+ID4gTlZNRSBzeXN0ZW1zLg0KPiA+ID4gPiA+ID4gPiANCj4g
PiA+ID4gPiA+ID4gT24gdGhlIDEyOEdCIGJveCwgd2UgaGFkIGl0IHNldCB1cCB3aXRoIDEwKyBk
aXNrcyBpbiBhDQo+ID4gPiA+ID4gPiA+IEpCT0QNCj4gPiA+ID4gPiA+ID4gY29uZmlndXJhdGlv
biBhbmQgd2VyZSBydW5uaW5nIHRoZSBBSkEgc3lzdGVtIHRlc3RzLg0KPiA+ID4gPiA+ID4gPiAN
Cj4gPiA+ID4gPiA+ID4gT24gdGhlIDQwMEdCIGJveCwgd2Ugd2VyZSBqdXN0IHNlcmlhbGx5IGNy
ZWF0aW5nIGxhcmdlICg+DQo+ID4gPiA+ID4gPiA+IDZHQikNCj4gPiA+ID4gPiA+ID4gZmlsZXMN
Cj4gPiA+ID4gPiA+ID4gdXNpbmcgZmlvIGFuZCB0aGF0IHdhcyBvY2Nhc2lvbmFsbHkgdHJpZ2dl
cmluZyB0aGUgaXNzdWUuDQo+ID4gPiA+ID4gPiA+IEhvd2V2ZXINCj4gPiA+ID4gPiA+ID4gZG9p
bmcNCj4gPiA+ID4gPiA+ID4gYW4gc3RyYWNlIG9mIHRoYXQgd29ya2xvYWQgdG8gZGlzayByZXBy
b2R1Y2VkIHRoZSBwcm9ibGVtDQo+ID4gPiA+ID4gPiA+IGZhc3Rlcg0KPiA+ID4gPiA+ID4gPiA6
LQ0KPiA+ID4gPiA+ID4gPiApLg0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBPaywgdGhhdCBt
YXRjaGVzIHVwIHdpdGggdGhlICJsb3RzIG9mIGxvZ2ljYWxseSBzZXF1ZW50aWFsDQo+ID4gPiA+
ID4gPiBkaXJ0eQ0KPiA+ID4gPiA+ID4gZGF0YSBvbiBhIHNpbmdsZSBpbm9kZSBpbiBjYWNoZSIg
dmVjdG9yIHRoYXQgaXMgcmVxdWlyZWQgdG8NCj4gPiA+ID4gPiA+IGNyZWF0ZQ0KPiA+ID4gPiA+
ID4gcmVhbGx5IGxvbmcgYmlvIGNoYWlucyBvbiBpbmRpdmlkdWFsIGlvZW5kcy4NCj4gPiA+ID4g
PiA+IA0KPiA+ID4gPiA+ID4gQ2FuIHlvdSB0cnkgdGhlIHBhdGNoIGJlbG93IGFuZCBzZWUgaWYg
YWRkcmVzc2VzIHRoZSBpc3N1ZT8NCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+
IFRoYXQgcGF0Y2ggZG9lcyBzZWVtIHRvIGZpeCB0aGUgc29mdCBsb2NrdXBzLg0KPiA+ID4gPiA+
IA0KPiA+ID4gPiANCj4gPiA+ID4gT29wcy4uLiBTdHJpa2UgdGhhdCwgYXBwYXJlbnRseSBvdXIg
dGVzdHMganVzdCBoaXQgdGhlDQo+ID4gPiA+IGZvbGxvd2luZw0KPiA+ID4gPiB3aGVuDQo+ID4g
PiA+IHJ1bm5pbmcgb24gQVdTIHdpdGggdGhhdCBwYXRjaC4NCj4gPiA+IA0KPiA+ID4gT0ssIHNv
IHRoZXJlIGFyZSBhbHNvIGxhcmdlIGNvbnRpZ3VvdXMgcGh5c2ljYWwgZXh0ZW50cyBiZWluZw0K
PiA+ID4gYWxsb2NhdGVkIGluIHNvbWUgY2FzZXMgaGVyZS4NCj4gPiA+IA0KPiA+ID4gPiBTbyBp
dCB3YXMgaGFyZGVyIHRvIGhpdCwgYnV0IHdlIHN0aWxsIGRpZCBldmVudHVhbGx5Lg0KPiA+ID4g
DQo+ID4gPiBZdXAsIHRoYXQncyB3aGF0IEkgd2FudGVkIHRvIGtub3cgLSBpdCBpbmRpY2F0ZXMg
dGhhdCBib3RoIHRoZQ0KPiA+ID4gZmlsZXN5c3RlbSBjb21wbGV0aW9uIHByb2Nlc3NpbmcgYW5k
IHRoZSBpb21hcCBwYWdlIHByb2Nlc3NpbmcNCj4gPiA+IHBsYXkNCj4gPiA+IGEgcm9sZSBpbiB0
aGUgQ1BVIHVzYWdlLiBNb3JlIGNvbXBsZXggcGF0Y2ggZm9yIHlvdSB0byB0cnkNCj4gPiA+IGJl
bG93Li4uDQo+ID4gPiANCj4gPiA+IENoZWVycywNCj4gPiA+IA0KPiA+ID4gRGF2ZS4NCj4gPiAN
Cj4gPiBIaSBEYXZlLA0KPiA+IA0KPiA+IFRoaXMgcGF0Y2ggZ290IGZ1cnRoZXIgdGhhbiB0aGUg
cHJldmlvdXMgb25lLiBIb3dldmVyIGl0IHRvbyBmYWlsZWQNCj4gPiBvbg0KPiA+IHRoZSBzYW1l
IEFXUyBzZXR1cCBhZnRlciB3ZSBzdGFydGVkIGNyZWF0aW5nIGxhcmdlciAoaW4gdGhpcyBjYXNl
DQo+ID4gNTJHQikNCj4gPiBmaWxlcy4gVGhlIHByZXZpb3VzIHBhdGNoIGZhaWxlZCBhdCAxNUdC
Lg0KPiA+IA0KPiANCj4gQ2FyZSB0byB0cnkgbXkgb2xkIHNlcmllcyBbMV0gdGhhdCBhdHRlbXB0
ZWQgdG8gYWRkcmVzcyB0aGlzLA0KPiBhc3N1bWluZw0KPiBpdCBzdGlsbCBhcHBsaWVzIHRvIHlv
dXIga2VybmVsPyBZb3Ugc2hvdWxkIG9ubHkgbmVlZCBwYXRjaGVzIDEgYW5kDQo+IDIuDQo+IFlv
dSBjYW4gdG9zcyBpbiBwYXRjaCAzIGlmIHlvdSdkIGxpa2UsIGJ1dCBhcyBEYXZlJ3MgZWFybGll
ciBwYXRjaA0KPiBoYXMNCj4gc2hvd24sIHRoaXMgY2FuIGp1c3QgbWFrZSBpdCBoYXJkZXIgdG8g
cmVwcm9kdWNlLg0KPiANCj4gSSBkb24ndCBrbm93IGlmIHRoaXMgd2lsbCBnbyBhbnl3aGVyZSBh
cyBpcywgYnV0IEkgd2FzIG5ldmVyIGFibGUgdG8NCj4gZ2V0DQo+IGFueSBzb3J0IG9mIGNvbmZp
cm1hdGlvbiBmcm9tIHRoZSBwcmV2aW91cyByZXBvcnRlciB0byB1bmRlcnN0YW5kIGF0DQo+IGxl
YXN0IHdoZXRoZXIgaXQgaXMgZWZmZWN0aXZlLiBJIGFncmVlIHdpdGggSmVucycgZWFybGllciBj
b25jZXJuDQo+IHRoYXQNCj4gdGhlIHBlci1wYWdlIHlpZWxkcyBhcmUgcHJvYmFibHkgb3Zlcmtp
bGwsIGJ1dCBpZiBpdCB3ZXJlIG90aGVyd2lzZQ0KPiBlZmZlY3RpdmUgaXQgc2hvdWxkbid0IGJl
IHRoYXQgaGFyZCB0byBhZGQgZmlsdGVyaW5nLiBQYXRjaCAzIGNvdWxkDQo+IGFsc28NCj4gdGVj
aG5pY2FsbHkgYmUgdXNlZCBpbiBwbGFjZSBvZiBwYXRjaCAxIGlmIHdlIHJlYWxseSB3YW50ZWQg
dG8gZ28NCj4gdGhhdA0KPiByb3V0ZSwgYnV0IEkgd291bGRuJ3QgdGFrZSB0aGF0IHN0ZXAgdW50
aWwgdGhlcmUgd2FzIHNvbWUNCj4gdmVyaWZpY2F0aW9uDQo+IHRoYXQgdGhlIHlpZWxkaW5nIGhl
dXJpc3RpYyBpcyBlZmZlY3RpdmUuDQo+IA0KPiBCcmlhbg0KPiANCj4gWzFdDQo+IGh0dHBzOi8v
bG9yZS5rZXJuZWwub3JnL2xpbnV4LXhmcy8yMDIxMDUxNzE3MTcyMi4xMjY2ODc4LTEtYmZvc3Rl
ckByZWRoYXQuY29tLw0KPiANCj4gDQo+IA0KDQpIaSBCcmlhbiwNCg0KSSB3b3VsZCBleHBlY3Qg
dGhvc2UgdG8gd29yaywgc2luY2UgdGhlIGZpcnN0IHBhdGNoIGlzIGVzc2VudGlhbGx5DQppZGVu
dGljYWwgdG8gdGhlIG9uZSBJIHdyb3RlIGFuZCB0ZXN0ZWQgYmVmb3JlIHRyeWluZyBEYXZlJ3Mg
Zmlyc3QNCnBhdGNoIHZlcnNpb24gKGF0IGxlYXN0IGZvciB0aGUgc3BlY2lhbCBjYXNlIG9mIFhG
UykuIEhvd2V2ZXIgd2UgbmV2ZXINCmRpZCB0ZXN0IHRoYXQgcGF0Y2ggb24gdGhlIEFXUyBzZXR1
cCwgc28gbGV0IG1lIHRyeSB5b3VyIHBhdGNoZXMgMSAmIDINCmFuZCBzZWUgaWYgdGhleSBnZXQg
dXMgZnVydGhlciB0aGFuIDUyR0IuDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMg
Y2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3Bh
Y2UuY29tDQoNCg0K
