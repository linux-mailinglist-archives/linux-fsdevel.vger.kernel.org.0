Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9912568AB67
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Feb 2023 17:52:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbjBDQwg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 Feb 2023 11:52:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjBDQwf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 Feb 2023 11:52:35 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2109.outbound.protection.outlook.com [40.107.220.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0974976A4;
        Sat,  4 Feb 2023 08:52:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VwYFEc261J0zUFe/9j+XKZ3XZ3A2pr4sNaupWNSADzt7HGDypjiZAcIp6n+xjKYNFXosDG+eAdhRjwIFyENUL6CsaqZp0oy5tcxMG1y7ZoW7NkKTymmRq5VDbwjVsBECddTLMuSkf+dBTphLkBuB3V2r9U/XT2wTkrDKQxBW4hJZP4vjNWmHizAfpJypC5aPs4fY+y4EpVbMHAKZ4Cj687l0UvNjBbUZcx38zt9qoZha6aHZe3i46IEXHVWWpe4ivU72iTkKiHQwz33vNgTnxYbrbFp21NXN68kZaWR870te61DwuljK5kATeLLij8/EohWPSJ21WpCeh/GWqqH9lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tMf01UdUFSNa1Yp76OqzS/hktX2qYfFBq9fpD4AOynE=;
 b=mpyt44VJNExat/oApbfoflVhb6a9BpAOzN49xZoYpsh8PJLxleFFBnO2XJ7eNY0GCL0NjPrNpJCCP1e8ycZQkt5M/zW4Xv/vv0HXhvf0BJZ2+7F0EfSdW+IIgwEM1wsBG3f49/Sy/HZUGXUN8pvGhfTsxRv3Fkme8jLGELliFq5960oAhxSIQnFD6gzpZZEiXWyRNLqyjJQnWqUqDleCixHv4Ni9072e/V0E2yyOrcA/brdmmrfImma7kvMNZhOoT74lZhDNopQ/RcXKNG5hVJHJsBy5nwPtitdEGi1h6Zmc0CXKNMe2AgTZiQUO3HN3qy4pyW0o1VO3/n2DEfmqRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tMf01UdUFSNa1Yp76OqzS/hktX2qYfFBq9fpD4AOynE=;
 b=fz7HW3maKNpruZN4Gw9O1Maqh/HwG4+XGpL1UO0UXUCDweO3rAINVlv5Lm2py1LhUzNq0Ca5Ndb96HKCPpQl/UEV8xCVgqRIBuw/jxAl14lQv3D9h2eROO+k3/BaunhddcrMniHTRK+/Vl5pJnrzxKJiypJ57Sam+DUyK26rPPM=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by DM6PR13MB4035.namprd13.prod.outlook.com (2603:10b6:5:2a3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.31; Sat, 4 Feb
 2023 16:52:29 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::7007:3376:4f4e:b87b]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::7007:3376:4f4e:b87b%5]) with mapi id 15.20.6064.031; Sat, 4 Feb 2023
 16:52:29 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     Benjamin Coddington <bcodding@redhat.com>
CC:     Thorsten Leemhuis <regressions@leemhuis.info>,
        Hugh Dickins <hughd@google.com>,
        Charles Edward Lever <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Anna Schumaker <anna@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Linux kernel regressions list <regressions@lists.linux.dev>
Subject: Re: git regression failures with v6.2-rc NFS client
Thread-Topic: git regression failures with v6.2-rc NFS client
Thread-Index: AQHZNbks6EbZ9+Bo00OYN0rzWVADp665E+wAgAEOhICAABzOgIADD6gAgAAJrgCAAAZCAIAAG42AgAANvACAACDsAIAABuIAgAAhzgCAAAx6gIAAC7sAgAAD7YCAAAIvAIAADDeAgADN+K2AADxnAA==
Date:   Sat, 4 Feb 2023 16:52:29 +0000
Message-ID: <031C52C0-144A-4051-9B4C-0E1E3164951E@hammerspace.com>
References: <9A4A5673-691D-47EC-BC44-C43BE7E50A48@oracle.com>
 <D0404F55-2692-4DB6-8DD6-CAC004331AC1@redhat.com>
 <5FF4061F-108C-4555-A32D-DDBFA80EE4E7@redhat.com>
 <F1833EA0-263F-46DF-8001-747A871E5757@redhat.com>
 <B90C62F2-1D3A-40E0-8E33-8C349C6FFD3D@oracle.com>
 <44CB1E86-60E0-4CF0-9FD4-BB7E446542B7@redhat.com>
 <1AAC6854-2591-4B21-952A-BC58180B4091@oracle.com>
 <41813D21-95C8-44E3-BB97-1E9C03CE7FE5@redhat.com>
 <79261B77-35D0-4E36-AA29-C7BF9FB734CC@oracle.com>
 <104B6879-5223-485F-B099-767F741EB15B@redhat.com>
 <966AEC32-A7C9-4B97-A4F7-098AF6EF0067@oracle.com>
 <545B5AB7-93A6-496E-924E-AE882BF57B72@hammerspace.com>
 <FA8392E6-DAFC-4462-BDAE-893955F9E1A4@oracle.com>
 <4dd32d-9ea3-4330-454a-36f1189d599@google.com>
 <0D7A0393-EE80-4785-9A83-44CF8269758B@hammerspace.com>
 <ab632691-7e4c-ccbf-99a0-397f1f7d30ec@google.com>
 <8B4F6A20-D7A4-4A22-914C-59F5EA79D252@hammerspace.com>
 <c5259e81-631e-7877-d3b0-5a5a56d35b42@leemhuis.info>
 <15679CC0-6B56-4F6D-9857-21DCF1EFFF79@redhat.com>
In-Reply-To: <15679CC0-6B56-4F6D-9857-21DCF1EFFF79@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.400.51.1.1)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|DM6PR13MB4035:EE_
x-ms-office365-filtering-correlation-id: 211e8b08-23fd-48b9-1f66-08db06d03396
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: od/KnsI9l/RLIi6FbN2Fs8Or7h6eoIbFMmKOqeMkIlU2eSSf1AIfZKxR94xgQlCbpQbFNMaZPFnutX2H81GjMQFG1PMtU4HnEOI1tbjl4jsLoPEusJIrR+0kGOtddG7of0V4SZPQYh4qMKRpqe8byPUSy3wPwROrUTvo9Fm9GywKMJJ9T4wFqZbXC7pcrxiU5EZ8SkjLW/+FD/y2RqJzFMYeUFcfIxKvC8jCaNp//Rhcgd0Ifo8CS2MFel1+uP5uZZ9y9WGSx2WZY2KGi1wuplTCqcavvFCynAf3n343jvh7a4R9OgdAHYhsquIzZb1w+m/D7nRR33SAFlvm6pLe3sk8bjWOyQwLcv05W5Xr00Lt/7g1E7L8HMm6tlcq/IQH18V75PipTMfdv1KIKOat61ITJM/+i7C5fqG0MTvCEFMMwPruks4f/9/OrbY+IE7xCHzVSTfqnH6daNRO2CRfjgtofnuvxVFvNXFqU/+FGD3iUnTcmiEIrfBmIzfQvUMBr0uvszk+fjVYEnfjJNXPnqD27MqNRelRO/nMz+JZ6SMzrQJ2fSBrOuiV6/+xhF+bA9niohjnNOdbIj6PnwxIIFBORWKOgh1ZpiHnzmY7T5uyLj7op5U6j0zL1GNK6mdi0P6Q+NzDC1Y4Cyjbe1bjYOBCsYIcvywcmrzRiKHkPrIKsf2E0sA39+C38XjeYZ5HArji12M6QG7aW5emko2pDDx+PrSqQJNcewaTMLTWLHs9Aez4BRlXW5onT+MlURp4B/RhjhMUi3J/8CZhttOTZg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(366004)(376002)(39840400004)(136003)(346002)(451199018)(316002)(8676002)(66556008)(66946007)(54906003)(6916009)(4326008)(5660300002)(66446008)(76116006)(41300700001)(8936002)(66476007)(33656002)(38070700005)(86362001)(36756003)(122000001)(38100700002)(64756008)(53546011)(6512007)(6506007)(186003)(71200400001)(2906002)(83380400001)(7416002)(2616005)(966005)(478600001)(6486002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R0I1MStJTWNjNXo1ZldUcy9hWHFFQXVld1ZDVHZBODBkNzZmYzAvWDFTcWFU?=
 =?utf-8?B?RnQxTW9IT0tidXNqKytlNHVUV2djK0tmL2x3K0xKQUJDSmFmbW4rWkVtQ3hZ?=
 =?utf-8?B?QkszYlZIbHhYNVoyWVVOWXlkUmhZZ3RvWjFYUERsNVYveHovU1VsWXltZ1pV?=
 =?utf-8?B?R3d2QUxvalMvYTZOd09LSnIva0ROUGxwaDh1Q0RQR2tmNFp2OGd0MllueG9k?=
 =?utf-8?B?VkwvdzNTalA4U1J1UzY0cHVtOU5Nb29qL0xwNG5sZ0FsaVlscnk0Ti93U1J0?=
 =?utf-8?B?VkdkcFd3b1pYeERFd2hSTFhTdTVVc21BU2V4Y281elA1Q1Q5YW9aSnQwYWJX?=
 =?utf-8?B?ZExDTVArSHF0WWJwTEd5YWYyR3RGMzNrK1RKVGFNTUM3WWs4Tzh3R2VNalVn?=
 =?utf-8?B?TGRXWlVaMWg4ZE8rRU5CVEIveWV5R3pqVDZTZ29EVks1TTVvayswZnNPSWFl?=
 =?utf-8?B?TS80M1ZLR3diUlhmbzNQTnBLVURnNklvNW0xaVYrNUVlc1UrVnZXMEE1Zncz?=
 =?utf-8?B?dG12WlpCRU45VVZLV1VnZ05rN2pUclRyUFBHV1JtTk1WeTd1VlRQUUdlNFd4?=
 =?utf-8?B?QWhmd0VVKzE1ZzVaQXBKRmRNSy9ETUJZNjdqcURGY0M0M1o4Q08rYXJ1T29U?=
 =?utf-8?B?YjB1dm9oWEIxa1NaK0NSZm9sazBSb09jS3lQZmtDWE5zNUQ5OEw2RHdjeXRR?=
 =?utf-8?B?UlRTaEh0bTZ3Vm5wa21mMWtsUW9yZWJQeXFSeTdwbWI5aDVXbmM0L0JsNWpz?=
 =?utf-8?B?anRveWxib3ozam03Q1FLdXBNNjgwY0d2eDEyeDZQYmNPWFIwVUhZQWV0RCtB?=
 =?utf-8?B?WHlSb2V6L2xsWFBGU2FzcXFmSDVwdzZmd3NPV0pnNFhLMi9VcWNrUnNOWkl5?=
 =?utf-8?B?aVROSjdzU29QanZ4bVY5STQ5OU1pVnBZQzdodldBbGRQT0lheUROdHlDY0lh?=
 =?utf-8?B?SUlJdjYwQ296ajNkL3BFb05aNjlqbmwvTTV3VlRUUy9uQVJRWHI0dHNQbC9Z?=
 =?utf-8?B?d210cndFamZUUXN4TC9QVHpLN29mSjNWVENXUktNY0F4a3AvYmhPamRuR2p2?=
 =?utf-8?B?OHE3Y3k3NDFMQ2hFS2RjcTdCUW84dEt3VDF4clFSbzh0NUxwc01mb3Q3ZWxB?=
 =?utf-8?B?R0V5N3BiNHhrNTZFLzZRTWVURlUwVTd6bk83Um1zT0tkOThPNEhCak5PaTh4?=
 =?utf-8?B?RVZRRVFTbGdaaEp2bUoyNTBpWTNvT2hMRjlwalRJUzhyNWlCWXlSdWdaQ0hM?=
 =?utf-8?B?Vjh6REpyRDQvYkhXZVVHZmRTVXF3b0NwNHV0cU0vUGluUGlEM3RrVHVsQjgr?=
 =?utf-8?B?OEdjNGcrUDFTN0lrVmlRcDFzUnhBUnY2bWZNZVZVaHhJbWZrbWdMd255RUFU?=
 =?utf-8?B?L0RDcXIzbzdsdURFY2IrWFkvVHVPaWdFM0tOOTYzQ0kzZ0xrdnJhaHBOSGxH?=
 =?utf-8?B?aFFVZnRIVW5KOTZ2M0Y2VFFkYmpkUHlmTkFMVWpnOUJ0bFZoZ0lNcVdzajQ0?=
 =?utf-8?B?cDZOZGtGSXJlS05QMk1abkFGbHREd04xWHNpNUpGb2Z5Ky9kTSs2QlhPU05G?=
 =?utf-8?B?OEtFSjhzemU3QnZPMFYvKzZUbXNCL2VTVWVLY08zdTZHMXZaRWdxUzQ1Ly9h?=
 =?utf-8?B?Q1BtSEQvNnRIdUd0eDNVRWlhN0h4d1hGVXAxR3ZjTUlGMDJLT1MveUdyeWl5?=
 =?utf-8?B?eUN1TnFPSjNrbjRqSDJqVVJwTU9tQ2pDN1BXbUt4bmtvZDJFTHluMVFKNnkv?=
 =?utf-8?B?TWdpMktpbDY0dHdGQzIrdlpOT3ZCVGt1UHBMRmpNUjF1WUhrbVBzeTJPRmQ3?=
 =?utf-8?B?clhIYTF6WkVyQmJ2aFp3a0R5TldnMmxXS3dzUWVyWkJzOUtKck5kRjhyaHRG?=
 =?utf-8?B?UjkxeTdEbTJpajF1cmM2dGtkSzU5M0dGNlRaaDFNeXdwZGJNbXo0UXdKM0l5?=
 =?utf-8?B?SnJHOTJsM2JGVTM1bjVwOWRoVG5qeHJnTzNwQkZ0Tmh1Tm8xdi8wbGRyaE9U?=
 =?utf-8?B?OUlHWGRiY2Y5aVdDYW55czFmSndPQy9CbkRZSWZhQmRpZE1YRjIzMkFjVTdN?=
 =?utf-8?B?SlZNZXBneXBwaEVDeWE3L2V6YlYveGpXU0tvYXRtNlBSaEc4bE5IVVBPeUVz?=
 =?utf-8?B?TEFpRzM2V3hvN2lYVzZPYUFvQjlTbzVLWElzL3hDQm5MSWhkbGhjV1pKZGpE?=
 =?utf-8?B?c2JKRTZhMm5zS0NFMThadFhxcVBmNERaMnNINU9ScXZXYW8ya2ttQWlZV3o4?=
 =?utf-8?B?a1VDQ3ZPaFpKemh5WVNyQVhhYVJ3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D211A4059F941245925A448C53AE5DAE@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 211e8b08-23fd-48b9-1f66-08db06d03396
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2023 16:52:29.1029
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n6FHKr0bNgGiHF/+CvCp9BNet75HzzwBet3OJLrkn9+PDLfnjn0puFzjNATBtXkeMmOqZ0GejP7YqdGOWZBwDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB4035
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

DQoNCj4gT24gRmViIDQsIDIwMjMsIGF0IDA4OjE1LCBCZW5qYW1pbiBDb2RkaW5ndG9uIDxiY29k
ZGluZ0ByZWRoYXQuY29tPiB3cm90ZToNCj4gDQo+IE9uIDQgRmViIDIwMjMsIGF0IDY6MDcsIFRo
b3JzdGVuIExlZW1odWlzIHdyb3RlOg0KPiANCj4+IEJ1dCBhcyB5b3Ugc2FpZDogcGVvcGxlIGFy
ZSBtb3JlIGxpa2VseSB0byBydW4gaW50byB0aGlzIHByb2JsZW0gbm93Lg0KPj4gVGhpcyBpbiB0
aGUgZW5kIG1ha2VzIHRoZSBrZXJuZWwgd29yc2UgYW5kIHRodXMgYWZhaWNzIGlzIGEgcmVncmVz
c2lvbiwNCj4+IGFzIEh1Z2ggbWVudGlvbmVkLg0KPj4gDQo+PiBUaGVyZSBzYWRseSBpcyBubyBx
dW90ZSBmcm9tIExpbnVzIGluDQo+PiBodHRwczovL2RvY3Mua2VybmVsLm9yZy9wcm9jZXNzL2hh
bmRsaW5nLXJlZ3Jlc3Npb25zLmh0bWwNCj4+IHRoYXQgZXhhY3RseSBtYXRjaGVzIGFuZCBoZWxw
cyBpbiB0aGlzIHNjZW5hcmlvLCBidXQgYSBmZXcgdGhhdCBjb21lDQo+PiBjbG9zZTsgb25lIG9m
IHRoZW06DQo+PiANCj4+IGBgYA0KPj4gQmVjYXVzZSB0aGUgb25seSB0aGluZyB0aGF0IG1hdHRl
cnMgSVMgVEhFIFVTRVIuDQo+PiANCj4+IEhvdyBoYXJkIGlzIHRoYXQgdG8gdW5kZXJzdGFuZD8N
Cj4+IA0KPj4gQW55Ym9keSB3aG8gdXNlcyAiYnV0IGl0IHdhcyBidWdneSIgYXMgYW4gYXJndW1l
bnQgaXMgZW50aXJlbHkgbWlzc2luZw0KPj4gdGhlIHBvaW50LiBBcyBmYXIgYXMgdGhlIFVTRVIg
d2FzIGNvbmNlcm5lZCwgaXQgd2Fzbid0IGJ1Z2d5IC0gaXQNCj4+IHdvcmtlZCBmb3IgaGltL2hl
ci4NCj4+IGBgYA0KPj4gDQo+PiBBbnl3YXksIEkgZ3Vlc3Mgd2UgZ2V0IGNsb3NlIHRvIHRoZSBw
b2ludCB3aGVyZSBJIHNpbXBseSBleHBsaWNpdGx5DQo+PiBtZW50aW9uIHRoZSBpc3N1ZSBpbiBt
eSB3ZWVrbHkgcmVncmVzc2lvbiByZXBvcnQsIHRoZW4gTGludXMgY2FuIHNwZWFrDQo+PiB1cCBo
aW1zZWxmIGlmIGhlIHdhbnRzLiBObyBoYXJkIGZlZWxpbmcgaGVyZSwgSSB0aGluayB0aGF0J3Mg
anVzdCBteSBkdXR5Lg0KPj4gDQo+PiBCVFcsIEkgQ0NlZCB0aGUgcmVncmVzc2lvbiBsaXN0LCBh
cyBpdCBzaG91bGQgYmUgaW4gdGhlIGxvb3AgZm9yDQo+PiByZWdyZXNzaW9ucyBwZXINCj4+IGh0
dHBzOi8vZG9jcy5rZXJuZWwub3JnL2FkbWluLWd1aWRlL3JlcG9ydGluZy1yZWdyZXNzaW9ucy5o
dG1sXQ0KPj4gDQo+PiBCVFcsIEJlbmphbWluLCB5b3UgZWFybGllciBpbiB0aGlzIHRocmVhZCBt
ZW50aW9uZWQ6DQo+PiANCj4+IGBgYA0KPj4gVGhvcnN0ZW4ncyBib3QgaXMganVzdCBzY3JhcGlu
ZyB5b3VyIHJlZ3Jlc3Npb24gcmVwb3J0IGVtYWlsLCBJIGRvdWJ0DQo+PiB0aGV5J3ZlIGNhcmVm
dWxseSByZWFkIHRoaXMgdGhyZWFkLg0KPj4gYGBgDQo+PiANCj4+IFdlbGwsIGtpbmRhLiBJdCdz
IGp1c3Qgbm90IHRoZSBib3QgdGhhdCBhZGRzIHRoZSByZWdyZXNzaW9uIHRvIHRoZQ0KPj4gdHJh
Y2tpbmcsIHRoYXQncyBtZSBkb2luZyBpdC4gQnV0IHllcywgSSBvbmx5IHNraW0gdGhyZWFkcyBh
bmQgc29tZXRpbWVzDQo+PiBzaW1wbHkgd2hlbiBhZGRpbmcgbGFjayBrbm93bGVkZ2Ugb3IgZGV0
YWlscyB0byBkZWNpZGUgaWYgc29tZXRoaW5nDQo+PiByZWFsbHkgaXMgYSByZWdyZXNzaW9uIG9y
IG5vdC4gQnV0IG9mdGVuIHRoYXQgc29vbmVyIG9yIGxhdGVyIGJlY29tZXMNCj4+IGNsZWFyIC0t
IGFuZCB0aGVuIEknbGwgcmVtb3ZlIGFuIGlzc3VlIGZyb20gdGhlIHRyYWNraW5nLCBpZiBpdCB0
dXJucw0KPj4gb3V0IGl0IGlzbid0IGEgcmVncmVzc2lvbi4NCj4+IA0KPj4gQ2lhbywgVGhvcnN0
ZW4gKHdlYXJpbmcgaGlzICd0aGUgTGludXgga2VybmVsJ3MgcmVncmVzc2lvbiB0cmFja2VyJyBo
YXQpDQo+IA0KPiBBaCwgdGhhbmtzIGZvciBleHBsYWluaW5nIHRoYXQuDQo+IA0KPiBJJ2QgbGlr
ZSB0byBzdW1tYXJpemUgYW5kIHF1YW50aWZ5IHRoaXMgcHJvYmxlbSBvbmUgbGFzdCB0aW1lIGZv
ciBmb2xrcyB0aGF0DQo+IGRvbid0IHdhbnQgdG8gcmVhZCBldmVyeXRoaW5nLiAgSWYgYW4gYXBw
bGljYXRpb24gd2FudHMgdG8gcmVtb3ZlIGFsbCBmaWxlcw0KPiBhbmQgdGhlIHBhcmVudCBkaXJl
Y3RvcnksIGFuZCB1c2VzIHRoaXMgcGF0dGVybiB0byBkbyBpdDoNCj4gDQo+IG9wZW5kaXINCj4g
d2hpbGUgKGdldGRlbnRzKQ0KPiAgICB1bmxpbmsgZGVudHMNCj4gY2xvc2VkaXINCj4gcm1kaXIN
Cj4gDQo+IEJlZm9yZSB0aGlzIGNvbW1pdCwgdGhhdCB3b3VsZCB3b3JrIHdpdGggdXAgdG8gMTI2
IGRlbnRyaWVzIG9uIE5GUyBmcm9tDQo+IHRtcGZzIGV4cG9ydC4gIElmIHRoZSBkaXJlY3Rvcnkg
aGFkIDEyNyBvciBtb3JlLCB0aGUgcm1kaXIgd291bGQgZmFpbCB3aXRoDQo+IEVOT1RFTVBUWS4N
Cg0KRm9yIGFsbCBzaXplcyBvZiBmaWxlbmFtZXMsIG9yIGp1c3QgdGhlIHBhcnRpY3VsYXIgc2V0
IHRoYXQgd2FzIGNob3NlbiBoZXJlPyBXaGF0IGFib3V0IHRoZSBjaG9pY2Ugb2YgcnNpemU/IEJv
dGggdGhlc2UgdmFsdWVzIGFmZmVjdCBob3cgbWFueSBlbnRyaWVzIGdsaWJjIGNhbiBjYWNoZSBi
ZWZvcmUgaXQgaGFzIHRvIGlzc3VlIGFub3RoZXIgZ2V0ZGVudHMoKSBjYWxsIGludG8gdGhlIGtl
cm5lbC4gRm9yIHRoZSByZWNvcmQsIHRoaXMgaXMgd2hhdCBnbGliYyBkb2VzIGluIHRoZSBvcGVu
ZGlyKCkgY29kZSBpbiBvcmRlciB0byBjaG9vc2UgYSBidWZmZXIgc2l6ZSBmb3IgdGhlIGdldGRl
bnRzIHN5c2NhbGxzOg0KDQogIC8qIFRoZSBzdF9ibGtzaXplIHZhbHVlIG9mIHRoZSBkaXJlY3Rv
cnkgaXMgdXNlZCBhcyBhIGhpbnQgZm9yIHRoZQ0KICAgICBzaXplIG9mIHRoZSBidWZmZXIgd2hp
Y2ggcmVjZWl2ZXMgc3RydWN0IGRpcmVudCB2YWx1ZXMgZnJvbSB0aGUNCiAgICAga2VybmVsLiAg
c3RfYmxrc2l6ZSBpcyBsaW1pdGVkIHRvIG1heF9idWZmZXJfc2l6ZSwgaW4gY2FzZSB0aGUNCiAg
ICAgZmlsZSBzeXN0ZW0gcHJvdmlkZXMgYSBib2d1cyB2YWx1ZS4gICovDQogIGVudW0geyBtYXhf
YnVmZmVyX3NpemUgPSAxMDQ4NTc2IH07DQoNCiAgZW51bSB7IGFsbG9jYXRpb25fc2l6ZSA9IDMy
NzY4IH07DQogIF9TdGF0aWNfYXNzZXJ0IChhbGxvY2F0aW9uX3NpemUgPj0gc2l6ZW9mIChzdHJ1
Y3QgZGlyZW50NjQpLA0KICAgICAgICAgICAgICAgICAgImFsbG9jYXRpb25fc2l6ZSA8IHNpemVv
ZiAoc3RydWN0IGRpcmVudDY0KSIpOw0KDQogIC8qIEluY3JlYXNlIGFsbG9jYXRpb24gaWYgcmVx
dWVzdGVkLCBidXQgbm90IGlmIHRoZSB2YWx1ZSBhcHBlYXJzIHRvDQogICAgIGJlIGJvZ3VzLiAg
SXQgd2lsbCBiZSBiZXR3ZWVuIDMyS2IgYW5kIDFNYi4gICovDQogIHNpemVfdCBhbGxvY2F0aW9u
ID0gTUlOIChNQVggKChzaXplX3QpIHN0YXRwLT5zdF9ibGtzaXplLCAoc2l6ZV90KQ0KICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBhbGxvY2F0aW9uX3NpemUpLCAoc2l6ZV90KSBtYXhf
YnVmZmVyX3NpemUpOw0KDQogIERJUiAqZGlycCA9IChESVIgKikgbWFsbG9jIChzaXplb2YgKERJ
UikgKyBhbGxvY2F0aW9uKTsNCg0KPiANCj4gQWZ0ZXIgdGhpcyBjb21taXQsIGl0IG9ubHkgd29y
a3Mgd2l0aCB1cCB0byAxNyBkZW50cmllcy4NCj4gDQo+IFRoZSBhcmd1bWVudCB0aGF0IHRoaXMg
aXMgbWFraW5nIHRoaW5ncyB3b3JzZSB0YWtlcyB0aGUgcG9zaXRpb24gdGhhdCB0aGVyZQ0KPiBh
cmUgbW9yZSBkaXJlY3RvcmllcyBpbiB0aGUgdW5pdmVyc2Ugd2l0aCA+MTcgZGVudHJpZXMgdGhh
dCB3YW50IHRvIGJlDQo+IGNsZWFuZWQgdXAgYnkgdGhpcyAic2F3IG9mZiB0aGUgYnJhbmNoIHlv
dSdyZSBzaXR0aW5nIG9uIiBwYXR0ZXJuIHRoYW4NCj4gZGlyZWN0b3JpZXMgd2l0aCA+MTI3LiAg
QW5kIEkgZ3Vlc3MgdGhhdCdzIHRydWUgaWYgQ2h1Y2sgcnVucyB0aGF0IHRlc3RpbmcNCj4gc2V0
dXAgZW5vdWdoLiAgOikNCj4gDQo+IFdlIGNhbiBjaGFuZ2UgdGhlIG9wdGltaXphdGlvbiBpbiB0
aGUgY29tbWl0IGZyb20NCj4gTkZTX1JFQURESVJfQ0FDSEVfTUlTU19USFJFU0hPTEQgKyAxDQo+
IHRvDQo+IG5mc19yZWFkZGlyX2FycmF5X21heGVudHJpZXMgKyAxDQo+IA0KPiBUaGlzIHdvdWxk
IG1ha2UgdGhlIHJlZ3Jlc3Npb24gZGlzYXBwZWFyLCBhbmQgd291bGQgYWxzbyBrZWVwIG1vc3Qg
b2YgdGhlDQo+IG9wdGltaXphdGlvbi4NCj4gDQo+IEJlbg0KPiANCg0KU28gaW4gb3RoZXIgd29y
ZHMgdGhlIHN1Z2dlc3Rpb24gaXMgdG8gb3B0aW1pc2UgdGhlIG51bWJlciBvZiByZWFkZGlyIHJl
Y29yZHMgdGhhdCB3ZSByZXR1cm4gZnJvbSBORlMgdG8gd2hhdGV2ZXIgdmFsdWUgdGhhdCBwYXBl
cnMgb3ZlciB0aGUga25vd24gdGVsbGRpcigpL3NlZWtkaXIoKSB0bXBmcyBidWcgdGhhdCBpcyBy
ZS1yZXZlYWxlZCBieSB0aGlzIHBhcnRpY3VsYXIgdGVzdCB3aGVuIHJ1biB1bmRlciB0aGVzZSBw
YXJ0aWN1bGFyIGNvbmRpdGlvbnM/IEFueW9uZSB3aG8gdHJpZXMgdG8gdXNlIHRtcGZzIHdpdGgg
YSBkaWZmZXJlbnQgbnVtYmVyIG9mIGZpbGVzLCBkaWZmZXJlbnQgZmlsZSBuYW1lIGxlbmd0aHMs
IG9yIGRpZmZlcmVudCBtb3VudCBvcHRpb25zIGlzIHN0aWxsIFNPTCBiZWNhdXNlIHRoYXTigJlz
IG5vdCBhIOKAnHJlZ3Jlc3Npb24iPw0KDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18NClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJz
cGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQo=
