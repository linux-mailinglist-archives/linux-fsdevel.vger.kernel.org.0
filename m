Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 186E96E13C5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Apr 2023 19:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjDMRyz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Apr 2023 13:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjDMRyy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Apr 2023 13:54:54 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2101.outbound.protection.outlook.com [40.107.220.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8420F10E5;
        Thu, 13 Apr 2023 10:54:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GEGeehB3gkzD8AJl8HPOPxsGPkJQYJrMB/w6oO+A+8tm0KoCoXd+Op3lws9J6NUpJ20jNIQ7PfiuSyt9dPqt195Yq2YW/UF4LEX43bMSAsd9aQ6Jp0fepy0Arc9v1681Nu/eVAoZnZmu3SsSMkR+zyAH3DHnpJhL8gBkl/uaKmkciPEo48oSSJiGYlt0KoOxzbLEoTpvEXBsoZY8f8/LjfSHkQCC6dd57EpLx04/rtZ6KkSjWHPPJex2hWRiPfRPyUW6LMwelYOQp+WoJJKMTPi5LYZG7dtJL6bFrez802TXv3EiOvGCJQudJZlYt5eeuk3DXbllamsDNBF0T8aKDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v2WJoYftDmR2eRpLPOaouJDQYodZSstnHfrF47iD/ZU=;
 b=R/ISVs7gp4YMYk2EegoVkEtSIQNYnSehUqmnxY6x89FP0+fxaYzQ7UD6m/8hzB1Z6TxaP1rdzIhjkGr++xXhc/Twznl/zdvDsIb6+9nLdHFdq5I5YPQa5b8r4g0EQUUDgpxOZnLa8uDpXbnqM+9jYeuxnWvamEVm6e31AraN9iek/mwsJeBxvgXgjDkAAKk2OlN7ZxqoHc0SLSirGDj3CiZIHRIQwPc1lwhckHd91ivrHp+mXqU6hq+L7rYcE00NeQjWhR15h/3fDTWFl5NhjNTHzEEB5toL54QUfmfVW4zu2MFrZsyANKqxl+Cs7Q0Gay+pLXsAK3Ec/yPt3otVKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v2WJoYftDmR2eRpLPOaouJDQYodZSstnHfrF47iD/ZU=;
 b=AqsjwLUbHHY3JhohtfwvfntuGX7jyU+80jZCeLrh3thHmklYRbtR89cnusPXwk6z60gbczrRJjCUi4Am4/460FUp3+uRHFquObHi29n+QhTkHgTBW3hhU7w1aAyw4bNBM2fqd4zmVBRSqvfFM0WECepl9keQKCm0oQ9zp3GRbcw=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by SJ0PR13MB5427.namprd13.prod.outlook.com (2603:10b6:a03:425::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Thu, 13 Apr
 2023 17:54:43 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::3627:d466:b0ae:1740]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::3627:d466:b0ae:1740%3]) with mapi id 15.20.6298.030; Thu, 13 Apr 2023
 17:54:43 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     Charles Edward Lever <chuck.lever@oracle.com>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [LSF/MM/BPF TOPIC] BoF for nfsd
Thread-Topic: [LSF/MM/BPF TOPIC] BoF for nfsd
Thread-Index: AQHZbWxjbwN4AXhTVEi8u3WYTLTb1a8pRyAAgABABwA=
Date:   Thu, 13 Apr 2023 17:54:43 +0000
Message-ID: <906AD704-F7A3-4B36-AE16-311E47B8CA75@hammerspace.com>
References: <FF0202C3-7500-4BB3-914B-DBAA3E0EA3D7@oracle.com>
 <ZDgMIlpCwfCKcwkx@casper.infradead.org>
In-Reply-To: <ZDgMIlpCwfCKcwkx@casper.infradead.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|SJ0PR13MB5427:EE_
x-ms-office365-filtering-correlation-id: aa767656-3c3e-44e0-0c3a-08db3c482955
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: haqJk7R9B2iJk8ZN65kN4QF5/G4f9S97MyLbbpH4GIXc+ezrL19Jac1WNgv/HnI9/pzDmUtkucl+H1WypY3yYsAa/TxNojXIH8bfkwkuGEWxJvXv9571tnelXrxmTat9YUw63aYaasiY8R9t+pgWHCIQjmwKTks9jBvW8n9zzkPp6w9xvfy/Sh1lQ53L3Zz6y2iqB0CwGjURM6gNoJLgOFk/7j8u9GeMTJgZNJqxgOfLhh+Hat1iJFF/Mq/Z4wEnATFpepndoS4yLfWTHm7XB572qwe5xDsi8yuxBsowPxZor/599/ndBW60GwhMjK4iouqr1//aRYZWnzVrpFAXtQdbX47kxAZPDY2BaE7WUOoLNvpmvzV2IjAYZjwaqbuOeHlIUj0NZuLwz/K7zYJegTvWzpoIKgW1PVBg2DfRQa1MRKE/pk81AyicWJA/iTONc0gxenHQT/SVcCfcEzAUZZqDk7r4D3fXW4clo231D9p7Vkd+/bllf7JWcG9TaiENDbbu7HSMe756qungKFSd92v4u4g6itUjNDSzVcLkfZrsAOlrZn532P9FEBYA7WuY+7X+RlI7GOF5xNfMDFCVnp8HsE4U8cqP9VNiWEPCk+QU2L0s/r6Sbo5Car+qyH+BxGlPr/AHyrmZ4QQkSt6fvtIbmWDKgPfwPFoYFU9IxcVsUUOdmEP8NJ9AKop+dtD+M6dJBtq6EQPpJURvsrVt4A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(376002)(39840400004)(346002)(366004)(451199021)(4326008)(6916009)(54906003)(66476007)(64756008)(66446008)(76116006)(316002)(66556008)(66946007)(6506007)(53546011)(6512007)(186003)(26005)(2616005)(83380400001)(38100700002)(8936002)(5660300002)(8676002)(41300700001)(6486002)(478600001)(71200400001)(36756003)(33656002)(86362001)(38070700005)(2906002)(122000001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MjU2a2I5Nmtqd2wvYTF1VCtPMW5oU3ZPNWNMT1prVVpUbUtsMTUrQWFIejZi?=
 =?utf-8?B?OGNWRUU5RzZOL2NRT3h6NkdIRVU3WG1QdXY3ck1LNko4cUVmN3BhVmlGVFFj?=
 =?utf-8?B?YmlsWkRkY3JHVncwc2l2RE5RN3NQT0ZabWpQRkpRcTM4R3FMUGJKN0djMGZq?=
 =?utf-8?B?dnk5bjVmYmdWdWp4cDVJMjRQb0FSMVkyUjZucUQydlVZbGNGb3A4VmErYnd2?=
 =?utf-8?B?VlIvYzIvdDQ2Q3pDMWZlOU0xakdEN2Q4d1VFN2d4VEVSUDl6Qno5ZEV1MXBi?=
 =?utf-8?B?dVFlTXR4ckR6Z2gyRndZZmZlMStoUllBOFBiMzk5RDM1aFMxZkFaY3U4VUlQ?=
 =?utf-8?B?SVBsYS95NC9nZ01qM0tqTWJnUjZ5WEQ3R3Zwd3BmejlRUENDNmk2MS83MG5l?=
 =?utf-8?B?QUJqMHd0ZGRXZWhBTm9POHZIaXBnYnl2cFFWZ0RSenlzWGFWZUIzQWJ0N0t6?=
 =?utf-8?B?QXhILzAvTkpYMkRWckx3d245T2lSazZIMUxqNk9UeU56bXM0NWFaR0p6NXY2?=
 =?utf-8?B?Tm9ObElWL2hMVkZlZ0JHeWNlcWVMakFzcVdCUnVUazBlWmg2dXh2aVhxUC90?=
 =?utf-8?B?NGpaZ09kOStRN2RWWFB4eGlZa3pScHhjdFVtdjBXdXViV0xnNUNKSXJkbXc5?=
 =?utf-8?B?SUdpSEl4dUtrVG1OcytYbjRXNFY1WG1vaTFqcE5VWFdwRmxtREZyS0VNMVRZ?=
 =?utf-8?B?Mm04SllCaU0yNlZhbGpqNVBFb3lzUWxSc3NkN283bHpGTnBlck9qcGZTdE5M?=
 =?utf-8?B?WlV4Y0JFS1Q5NUdkU050K0xjMEVlb1ZDdlhDdHlyeVFQbzZ1TnhTZWhEc0tK?=
 =?utf-8?B?MkRNajRERTRSdHoxZmVoTUgrcTZPVzQ5OHRsYkYzT3dlT2p4ak9kM2lqS2pj?=
 =?utf-8?B?NWtXSUk3enBYdk00SUdlVmpQWmVIUGk0RlliNE9qSUtjTDNvT2JSVENjSGtw?=
 =?utf-8?B?N0ZUbmJFL3djTWJ1elA2aVlNKzE0M0RmZWlmNG9BQ0dkbFFTbHI3UlcwTnJl?=
 =?utf-8?B?M0RTY1lBVWlpbGNBb0hKSis0dFNQUlBXeUg3TkZNejRlY0ErUnRocVF5UGZl?=
 =?utf-8?B?UEhDU2o3QU1tSHpRVk96TDRpUXhlUE5Za2FqKzBKUDExM1NNZG8rOENiOFNy?=
 =?utf-8?B?WmE5dWU0N2p4SFlnUXFoYTFKTGUwTElvZEYvaEhzTlNIZjFTR0JpWGxhSDYv?=
 =?utf-8?B?ZDk3dll6K21lakJrUHdMTEhmbnBReENDbVNIQUxEZ1BieStuUTNDTzRiUGNN?=
 =?utf-8?B?U0RzWVh1RUFFNEtNbnphdHRNalYzemVxM1BjeEYxakRYaTFkYUJLT2N2M2NJ?=
 =?utf-8?B?WmNMQ08xVHlXbEV6eUNwcmtPTm1OZ29FL2J4Nkx6d0lYNTlPWk9GUmhSSFNS?=
 =?utf-8?B?ckc4Z1NrUEtyRWs2N2VVRS9oak9XOFRZNmRQSUdvbUFXdUc4Q3M2djY4QkVM?=
 =?utf-8?B?NkR5RkFwL1QzRWhmWEZpaFFFMDdxanJkUk1wZitnTU9TMzFqZjlDUTZWQXlB?=
 =?utf-8?B?UDVNbFZJNTZwMGVRbUlWYWI3Umt6N1ZFUExvSldPcU05eTNHUG9Ma1UvZ3BZ?=
 =?utf-8?B?d1gyU0xnUEdCTVZVNHplaHZKTkFzSHFBSHJRYThIdHlRUmVZbFI0cVc4WC9k?=
 =?utf-8?B?TUx5QzRORGh2K0orMDJZVFlWV2RkUG5xN2pJK3RyVGU2Y0t0WTd0NW5oYzhL?=
 =?utf-8?B?Nkpmdmw0S3NUOC91YWl5dFNXdXRFbjhraTFaN28rM2twSnVoelNVbHVrUFRH?=
 =?utf-8?B?Ky9QK1g1TnIwZXVtTi9DTlVGeTA1QkN2Mks1eUNpVUh0OGpnWlJDdDhuZW1I?=
 =?utf-8?B?SDkyZXAxOW5IYUVGZkFuNEFKeFlsWWJtMVF1enFmUkp6U29CU0RXVHoxRkJk?=
 =?utf-8?B?UFAzb1hIUXpUeGEvenJKc3JhMGZzL2tDWVkvZzNNUEp3WEk0dzU0dXpROVZJ?=
 =?utf-8?B?T2s0YWhwM2pVblR2N2Zwb3BQeHlnaEpDN1cxWEtCdFJKYjNINXZqMUh6SGR3?=
 =?utf-8?B?RWZJZGZiSEladG9Va0JkM1BLQjM0bDE4ek82MkQrK3ZYWWh1K25xcUNOTUM2?=
 =?utf-8?B?QkJURENNc1F2MU54cFZCdEh6bkh4MWF0NUpvWkl2N2x2Uko4REpnY05XamNS?=
 =?utf-8?B?cVBGM01udEtEbkxzbkxrNDdqYnB1R2REYTdqQU96WmhkbnVvaE1xS2ROYXpZ?=
 =?utf-8?B?Vnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D88527DD2546354BAD35C5C3D594E2D4@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa767656-3c3e-44e0-0c3a-08db3c482955
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2023 17:54:43.1616
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L7g1CkB0ee3ocneXcyKoo6yT8qvWbvjUFXfP6laIDGTMqZ4sN2O2EAkh3HumDik/cNV/8ZUdAbcHdUEGL+cjeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR13MB5427
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

DQoNCj4gT24gQXByIDEzLCAyMDIzLCBhdCAxMDowNSwgTWF0dGhldyBXaWxjb3ggPHdpbGx5QGlu
ZnJhZGVhZC5vcmc+IHdyb3RlOg0KPiANCj4gT24gV2VkLCBBcHIgMTIsIDIwMjMgYXQgMDY6Mjc6
MDdQTSArMDAwMCwgQ2h1Y2sgTGV2ZXIgSUlJIHdyb3RlOg0KPj4gSSdkIGxpa2UgdG8gcmVxdWVz
dCBzb21lIHRpbWUgZm9yIHRob3NlIGludGVyZXN0ZWQgc3BlY2lmaWNhbGx5DQo+PiBpbiBORlNE
IHRvIGdhdGhlciBhbmQgZGlzY3VzcyBzb21lIHRvcGljcy4gTm90IGEgbmV0d29yayBmaWxlDQo+
PiBzeXN0ZW0gZnJlZS1mb3ItYWxsLCBidXQgc3BlY2lmaWNhbGx5IGZvciBORlNELCBiZWNhdXNl
IHRoZXJlDQo+PiBpcyBhIGxvbmcgbGlzdCBvZiBwb3RlbnRpYWwgdG9waWNzOg0KPj4gDQo+PiAg
ICDigKIgUHJvZ3Jlc3Mgb24gdXNpbmcgaW9tYXAgZm9yIE5GU0QgUkVBRC9SRUFEX1BMVVMgKGFu
bmEpDQo+PiAgICDigKIgUmVwbGFjaW5nIG5mc2Rfc3BsaWNlX2FjdG9yIChhbGwpDQo+PiAgICDi
gKIgVHJhbnNpdGlvbiBmcm9tIHBhZ2UgYXJyYXlzIHRvIGJ2ZWNzIChkaG93ZWxscywgaGNoKQ0K
PiANCj4gLSBVc2luZyBsYXJnZXIgZm9saW9zIGluc3RlYWQgb2Ygc2luZ2xlIHBhZ2VzOyBtYXli
ZSB0aGlzIGlzIHRoZSBzYW1lDQo+ICAgZGlzY3Vzc2lvbi4NCg0KVGhhdOKAmXMgbm90IGRvYWJs
ZSB1bnRpbCB5b3Ugc29tZWhvdyBtYWdpYyBPX0RJUkVDVCBpbnRvIHVzaW5nIGZvbGlvcy4NCg0K
PiANCj4+ICAgIOKAoiB0bXBmcyBkaXJlY3RvcnkgY29va2llIHN0YWJpbGl0eSAoY2VsKQ0KPj4g
ICAg4oCiIHRpbWVzdGFtcCByZXNvbHV0aW9uIGFuZCBpX3ZlcnNpb24gKGpsYXl0b24pDQo+PiAg
ICDigKIgR1NTIEtlcmJlcm9zIGZ1dHVyZXMgKGRob3dlbGxzKQ0KPj4gICAg4oCiIE5GUy9ORlNE
IENJIChqbGF5dG9uKQ0KPj4gICAg4oCiIE5GU0QgUE9TSVggdG8gTkZTdjQgQUNMIHRyYW5zbGF0
aW9uIC0gd3JpdGluZyBkb3duIHRoZSBydWxlcyAoYWxsKQ0KPj4gDQo+PiBTb21lIG9mIHRoZXNl
IHRvcGljcyBtaWdodCBiZSBhcHBlYWxpbmcgdG8gb3RoZXJzIG5vdCBzcGVjaWZpY2FsbHkNCj4+
IGludm9sdmVkIHdpdGggTkZTRCBkZXZlbG9wbWVudC4gSWYgdGhlcmUncyBzb21ldGhpbmcgdGhh
dCBzaG91bGQNCj4+IGJlIG1vdmVkIHRvIGFub3RoZXIgdHJhY2sgb3Igc2Vzc2lvbiwgcGxlYXNl
IHBpcGUgdXAuDQo+PiANCj4+IC0tDQo+PiBDaHVjayBMZXZlcg0KPj4gDQo+PiANCg0KX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBj
bGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFj
ZS5jb20NCg0K
