Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91B317096A5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 May 2023 13:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbjESLig (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 May 2023 07:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjESLif (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 May 2023 07:38:35 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2107.outbound.protection.outlook.com [40.107.113.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF65191;
        Fri, 19 May 2023 04:38:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dDjQ+uiefqyhVPzbXTX5JnO3lasoSxQpqJI/XBDEN8lqaxlakrVqdQsD9vWInQAxFOH4jjB/OW5/PKveLPqyYpRcGCG0xlvCT4Cj3M8NCqXhCgEcKi7pUXlgYjSFhXfiC39KSMMHz03BF0sb48zBPBJnYVCC2wWVIwghHskIZmOfxpUbibSZPqLKJr1YY7ulkTltD4IxNEcjQMzIhxLCEkUmOKkVjNYcYcaHbKXVdZiBoCeqhfxNJQVrPTo9t3I+Wwi9ZnqBQFZB5vLIj24HNAASukU/KHQIU6vdhQxvLq6f0njrY+Zo6fPE4ChMzkjAGJG9kkUU1qXn6UQzeLN5Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rx1Dn0dcjt49JF2Eu6Y3HwZDkiVZsu8xrVE47Hc0lrk=;
 b=Urdi/zYJXNCulrkKmVQg/ZfRsHuGqkGdO9SPgY/1zr5lzHCN0lRHSmAsNdPd1dlP7fseLZXVAYWChgpUKBuOtrPd3SfNTOjC8Be9c0ltAX4z3GdMDqh0++gupXuokQyENy4O1PrHEsSDl/zwwoH1OgB3tKgZPHohv0wmFSUOxW5cOzOOrMk7d/YkHctX2Kz1EiWn5VvLhZlkZk+nwHAqx2zhBvKWapDMZ7XO2bBld60tCh0pwLqLsu+wK945oFkZ53saDIqULZ3kF0rjZWICk0hrB+nB7Bbp4YWcDuCwCGQrQJpuz/0nNfB3EEukb98N8c78vrZm2Gk+CT7Nhdo0VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rx1Dn0dcjt49JF2Eu6Y3HwZDkiVZsu8xrVE47Hc0lrk=;
 b=bGrvIjXndlH/3cY6/EoWh6GfCHF/uP9kuGe/a52ZzXf31XkWz/mtg5cYcK72HCfeHukBUhtHos5ExpglgYjb9ozXzNJ0b7BgNhDL+YimHsXDZcJIXfaOZVHKOi8QIqCRQ6Qd4z34EZ7p9cI0sbotqExTdAtk9ns9gYX/9/JXX98=
Received: from TYXPR01MB1854.jpnprd01.prod.outlook.com (2603:1096:403:d::19)
 by TYWPR01MB8622.jpnprd01.prod.outlook.com (2603:1096:400:13d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21; Fri, 19 May
 2023 11:38:30 +0000
Received: from TYXPR01MB1854.jpnprd01.prod.outlook.com
 ([fe80::15b:810c:c285:9400]) by TYXPR01MB1854.jpnprd01.prod.outlook.com
 ([fe80::15b:810c:c285:9400%3]) with mapi id 15.20.6411.019; Fri, 19 May 2023
 11:38:30 +0000
From:   Ondrej Valousek <ondrej.valousek.xm@renesas.com>
To:     Christian Brauner <brauner@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>
CC:     Jeff Layton <jlayton@kernel.org>,
        "trondmy@hammerspace.com" <trondmy@hammerspace.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: A pass-through support for NFSv4 style ACL
Thread-Topic: A pass-through support for NFSv4 style ACL
Thread-Index: AQHZiDgRL/8V1539UEOAlA+RtK3rRq9daJoAgACtXICAAFLGAIADCBOAgAAHxLA=
Date:   Fri, 19 May 2023 11:38:30 +0000
Message-ID: <TYXPR01MB185439828CC7CEC40425065BD97C9@TYXPR01MB1854.jpnprd01.prod.outlook.com>
References: <20230516124655.82283-1-jlayton@kernel.org>
 <20230516-notorisch-geblickt-6b591fbd77c1@brauner>
 <TYXPR01MB18549D3A5B0BE777D7F6B284D9799@TYXPR01MB1854.jpnprd01.prod.outlook.com>
 <cc4317d9cb8f10aa0b3750bdb6db8b4e77ff26f8.camel@kernel.org>
 <20230517-herstellen-zitat-21eeccd36558@brauner>
 <20230517123914.GA4578@mit.edu>
 <20230519-allzu-aufmerksam-c3098b5ecf0d@brauner>
In-Reply-To: <20230519-allzu-aufmerksam-c3098b5ecf0d@brauner>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYXPR01MB1854:EE_|TYWPR01MB8622:EE_
x-ms-office365-filtering-correlation-id: ded64c03-1bae-413a-10d7-08db585d9201
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K3oADyBECLBmL5xwstN40HmmhzxPdS6QnC6mrvS36ZYyv/wpUbiTrVtAA4iYmv9x8YLMqul7HidKrXr4K0A6d9a6cac0mnkR2Ig8rOgdJt+CcgLsQnWVqgHUhndiI0wcSJigDlwLooGu+T16k+yyMGg4dlw+DPA7HaoLc8piHoGzlobaSSDzBikfEcHxFscwrcEsL9LgvV/o0QKiQ2WJNGW0ku+nkfPivBOiAyn0f6/20wRhVYDqwy+fRcpBuTpcl30m/gEyB6hQHyIEdmEL9slUBZYkXT/IQ6TlcUMyV4ElqaJ5PGQS/t4kspOniNWV1IuI7MOzjUyiSgduPslxb2X4mTJAEzVd3tH2RZfS3YKct6mPGKhMks2m2IM5542wnN6DWpLRnDMio9tzkoBqZlBcInWyprmNtDgXdj7YDDUttrhgfNN6AO49yEAmhxMi0L4b7TmiqK49r0IEg8215uhKV2jpmXnEEuMnKuiHkNj25vIhrC57FFFyTOCPR5FTdGOVFMb8L85rnaQxeXUX0A22xMYS5Bl9F5qyKAeQIA1DQd5g0zcluS8kSQpNs22/Khmut6CDZY1B0Gd5ADKdywUudcqH9H3G7V3MHXLXYuXZ5oPzEdwZ1JV1NJ1f1dL7
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYXPR01MB1854.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(376002)(366004)(346002)(39860400002)(451199021)(110136005)(54906003)(478600001)(86362001)(83380400001)(26005)(33656002)(186003)(71200400001)(9686003)(6506007)(122000001)(38100700002)(38070700005)(55016003)(7696005)(4326008)(316002)(76116006)(66946007)(66476007)(2906002)(64756008)(66556008)(66446008)(8676002)(8936002)(52536014)(41300700001)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZkxKVU16bFlBSjRFR0JoQjhZTkY0NWtYemlZaEtERFd3U3lucUZqMTU0Z3dP?=
 =?utf-8?B?am95TkFrZi9ZTlozc2xSSERLTkhJYTdkU1JvQjdMUTRGZnhLWklDalNienRM?=
 =?utf-8?B?WEJZL1BacmNqY0N2dGlCMFBwTXYzRmNnTWRXWlNGSnhGMFpPc3V4SnpJUmxp?=
 =?utf-8?B?VWZYdGdhVEVZVnU3ZmM4dlRHb3NnYjJiVExVdG5IM1BRb2d1WkNGemx0RGdj?=
 =?utf-8?B?ZXJ5aEttMUc1RWQ5YTFheWpkWFJEaklhSyt1ZjZsK25OaEhHK2JMRzBVVnIz?=
 =?utf-8?B?UGZRUzBDenBkYU1wd1ZtL0tObk5Id2VTK3hhNzVXSnQxN2s4b2pwOEJtQkYz?=
 =?utf-8?B?bDhZNFlpVWFSVDEyZFdnUVZtSElIdnFMR2VnZGdBTEtKZ2xXNmViN0ZsUTNE?=
 =?utf-8?B?dFNKQ21TSGZKZVB2NDE4SXd3ZWF2R2FyYnlvK3UwSXJ5NTZMTStreEFsVldu?=
 =?utf-8?B?WFNIZ0k5L3NEZEhIeU5Md3lLS0JKVnNJR0NmWmVrNnRWeFpnNStPWjVyWk8v?=
 =?utf-8?B?ekZYanV3OWk3N2dER3ZEQ3NQczg1Q1ZIdzU5V0krRzhyMlFPa0RKbWt1LzFP?=
 =?utf-8?B?OFhYRS9yTy9mM3NQUi82bXppMGplU1htbUo2UFFqWUorNnlJTTdvd29aanhE?=
 =?utf-8?B?bkZMUEpKZ1dNM3NmT2o5RE9PWERmT3J2WHFpeDVSVGtUTGI3ckY5YmhhNkhC?=
 =?utf-8?B?TE90QzRIS3BFZTVQTmdpTGdvMjA1TjJLSkNkQU1xQi9SNmRhN3hTMEpta21Q?=
 =?utf-8?B?aEpMMUROS3MwTytiVHF2cm1YSVlrbEcvUjlOUTdHT1NJaHZpcFFqS0VGS0Fz?=
 =?utf-8?B?ZEQ5TUtyOG43OHRvNDY0ajRWNG5VR2dRTDYrMDRPVU5zSkwwMkdmQzNaK0FD?=
 =?utf-8?B?UHVHTEZGZjBlV1V6T1FnbUVCMW9xYmNzcFhIdXhXSXErR2JXNXB5M1RNM004?=
 =?utf-8?B?ajY0OWtKQU1NZ1dic05TV0ZqUFdmWTVqUEhPdGtPQURoZkwzWmhiaHNUaDJp?=
 =?utf-8?B?aStMdWJON3hmSUpTeStYY1VNRVVsZ0VPbXQwT2JUeVF5R0NYWkdhNm1CRDFi?=
 =?utf-8?B?U252UG9nQ0FJWjlrMEYvbTdZZkVqN1JZT3RQK2Jsd1ByditCQlNZRGZaYTM4?=
 =?utf-8?B?RnlZSnp6aVp2UEErcFBHMjBNUXJtSUZyZ1Vvc2IyNDlvQlJRUTBQNmNweVFj?=
 =?utf-8?B?UkdXQmJ2MCt6NkJWQjZNR0t2SENKV3NXVDRhd2gyRHNGU3VnWmZUTVZreTFo?=
 =?utf-8?B?MHJiWEl0eUsyQXUwOGptTjBDMXg3R0VsUHhmR2tHcVk0Q21YZEYwUlFVb0F1?=
 =?utf-8?B?Y0VPMS90K1ptb3hXd2RZdWJmZkFzNDlJUjNEVnk5YWFldS9BT1FpaTdkcG9i?=
 =?utf-8?B?Nmx3TE4rMUJSZFZ6MERzQnpkcHdDWmNqbnh6c3Bma0NyRCt2UWFTNHVFK2pQ?=
 =?utf-8?B?MlVzVms2ZFVpVVFqWFprdTN3eWp2cFNIYWtkQjVsNHBYV2IvRHY2cEpMTGZT?=
 =?utf-8?B?SmdMc2R6dXlUOFlWS1NsdldmUVJzSmJTSWFsRE93L0U3YUJrVXBiUGtwZ2Nq?=
 =?utf-8?B?Y09wdjhGb0lZM1Ira2tKTFdPU2ZRd3NGd1RUSGlHK3ptMW5iMTh4SXgyUGxW?=
 =?utf-8?B?cWxTbm80UHdvZldNK1AzMmpYdnJ4d3NZckNTcXVEdTlDUDNOdE9TajVSM1Er?=
 =?utf-8?B?ZndsZytyNVM4TzVFdWx6QjZhTXVkZUF0blBaRFh4ZGNLT1FXNm1iQ0s0eFhL?=
 =?utf-8?B?YUxIbGlHVEgwU1lRbDdCV2hQbWVaSldKTytqOE9pODNvN1hhVHRHdGRhb0s0?=
 =?utf-8?B?QnFWb3h6YlpFckhnYTR4ZnExSXJaWXdXTDlkbUg5TGVYaWwxQ1g1N1B1a3NY?=
 =?utf-8?B?TTRXbE1uclBHbnpBdEtGaE1NcGhvZFowNWxUbFFHc3JBeGd0WGhTVGNCaWZI?=
 =?utf-8?B?OHVnOTNveGttUktocWJKQVUxYTlwM08xY2FlTzVDSUxPU0ZFZHl6L3RGaHk2?=
 =?utf-8?B?b3czY0lKdURTZ3FucXkyQnlrNEE4NHE5Y0c4dDFPbmYvZUFiZnJ2bWxkVHlO?=
 =?utf-8?B?L3RqcnhmVldDb0hMVm5JUTlJd2xRUnc0NHBNQnJ1Q2hUZTExSEpjZU1kc0Qz?=
 =?utf-8?B?OUxJNHVuUzFvbm82YkJXMk4vck5sQzVWZG5aczZrZFhGTnYzTHYzSkJCUXZ5?=
 =?utf-8?B?anc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYXPR01MB1854.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ded64c03-1bae-413a-10d7-08db585d9201
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2023 11:38:30.7440
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5UMB9xUFgPGojkBI+HJFp8rqGaNwQj2zhLQFqtQB5fJMRwmgPBqRe8nlez5KiQ1zTpBYmObi1R5RbQwiIQviKeH0UpBs2aTZtXDnCPfCIqA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8622
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

PiANCj4gSSdsbCBub3RlIG1vc3Qgb2YgdGhpcyBjb21wbGV4aXR5IGlzIG9ubHkgbmVjZXNzYXJ5
IGlmIHlvdSB3YW50IHRvIA0KPiBoYXZlIGxvY2FsIGZpbGUgYWNjZXNzIHRvIHRoZSBmaWxlIHN5
c3RlbSB3b3JrIHdpdGggc2ltaWxhciBzZW1hbnRpY3MgDQo+IGFzIHdoYXQgd291bGQgZ2V0IGV4
cG9ydGVkIHZpYSBORlN2NC4gIElmIHlvdSBkaWRuJ3QsIHlvdSBjb3VsZCBqdXN0IA0KPiBzdG9y
ZSB0aGUgV2luZG93cy1zdHlsZSBBQ0wgaW4gYW4geGF0dHIgYW5kIGp1c3QgbGV0IGl0IGJlIHNl
dCB2aWEgdGhlIA0KPiByZW1vdGUgZmlsZSBzeXN0ZW0sIGFuZCByZXR1cm4gaXQgd2hlbiB0aGUg
cmVtb3RlIGZpbGUgc3lzdGVtIHF1ZXJpZXMgDQo+IGl0LiAgVGhlIHByb2JsZW0gY29tZXMgd2hl
biB5b3Ugd2FudCB0byBoYXZlICJSaWNoQUNMcyIgYWN0dWFsbHkgDQo+IGluZmx1ZW5jZSB0aGUg
bG9jYWwgTGludXggcGVybWlzc2lvbnMgY2hlY2suDQoNCj4gWWVhaCwgSSdtIGFscmVhZHkgc2Nh
cmVkIGVub3VnaC4NCg0KV2VsbCBJIGRvIG5vdCB0aGluayBpdCdzIHRoYXQgZGlmZmljdWx0LiBB
cyBJIHNhaWQsIGp1c3QgdGFrZSBhIGxvb2sgaG93IE9tbmlPUyBkb2VzIHRoaW5ncywgdmVyeSBu
aWNlIC0geW91IGNhbiBzZXQgdXAgYSBWTSB3aXRoIGl0IGluIGp1c3QgYSBoYWxmIGFuIGhvdXIg
YW5kIHlvdSBnZXQgYSBzeXN0ZW0gd2l0aCBaRlMgYW5kIG5hdGl2ZSBORlN2NCB3b3JraW5nLg0K
VHJ1ZSBpdCdzIG5vdCBSaWNoYWNsLCBidXQganVzdCBORlN2NCBzdHlsZSBhY2wgLSBldmVuIGJl
dHRlci4NCg0KQXMgZm9yIHRoZSBpbXBsZW1lbnRhdGlvbiwgbG90IG9mIGNvZGUgY291bGQgYmUg
cHJlc3VtYWJseSB0YWtlbiBmcm9tIFNhbWJhIHdoaWNoIGlzIGFscmVhZHkgZG9pbmcgV2luZG93
cyBzdHlsZS1BQ0wgdG8gTkZTdjQgdHJhbnNsYXRpb24uDQoNClRvIG1lIGludGVyZXN0aW5nIGJp
dCB3YXMgdGhhdCB0aGUgb3JpZ2luYWwgcGF0aCBmcm9tIEFuZHJlYXMgd2FzIG5vdCBhY2NlcHRl
ZCBsYXJnZWx5IGJlY2F1c2UgaXQgd291bGQgYWRkIGFub3RoZXIgcGllY2Ugb2YgbWVzcyB0byB0
aGUgYWxyZWFkeSBtZXNzeSBjb2RlIGluIHRoZSBrZXJuZWwsIEkgZGlkIG5vdCBrbm93IHRoYXQu
DQpJIGhvcGVkIHRoYXQgIG5vdyB0aGF0IENocmlzdGlhbiBjbGVhbmVkIHRoZSBjb2RlIHJlY2Vu
dGx5LCBpdCB3b3VsZCBwZXJoYXBzIGFsbG93IHVzIHRvIHJlY29uc2lkZXIgdGhpbmdzLCBidXQg
bWF5YmUgSSBhbSB0b28gbmFpdmUgaGVyZSDwn5iKDQo=
