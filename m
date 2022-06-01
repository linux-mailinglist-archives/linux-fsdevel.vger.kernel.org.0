Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4310153A918
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Jun 2022 16:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352793AbiFAOYI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Jun 2022 10:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355586AbiFAOXx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Jun 2022 10:23:53 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 253A74D60E;
        Wed,  1 Jun 2022 07:13:46 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 251CSqlu026454;
        Wed, 1 Jun 2022 07:13:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=+KpcLKNB2ycAbLeX0jsyuRAcaZ6B0kEmkuVlOEMG4Us=;
 b=eE/RINXN52Cr5m6Snekkq2C1kSr6mnyMOUO0B7+fo+z4/SQr3ycobG9Jz0Oz8/MlFe2n
 UOR/oI4EYFveujTYfRSkf7vuHfEakMwfyfqe23GCNUuPAkAYXJa2r7CI+kQyZBPns1Hh
 BSmB1mcUmRtwP153r+GmWlW8JsGZHDYSKwI= 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3gdbt69qkf-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Jun 2022 07:13:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E83ynkHk/Gzde94zpkMNjW4tcLiuph/4fS88xoeb/laIfJtl1TXGo9OexEfuYzN7LBfpCQ1rNPqHGX4uAch6dOkR0ajydWUtTgaoYfWSc0A2wMei+BCgTj99BAa3TNaxl30MqRPjcchZcx5UsGC09Kj3HOcBK2ukzV/oKV9sGwLhqSxVWGuCG5knW5daNeRsrZW5wNiVQn2Ap5mWAecsekqxdXPPImiXKlcT6gZFlcyk1FW728zvtc6eqINC0wnXwmdXrjtcvlY5vU1M0kRI6zCRk9H3kYSYCfI0zn1yYT9v0yOSKcjg+plG0Bzy5tJDLL2qHbBXMb7wg3XjYHwWAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+KpcLKNB2ycAbLeX0jsyuRAcaZ6B0kEmkuVlOEMG4Us=;
 b=dexhxLGF1Eb7VJ3yLD4Aevahw8JwtRHy081mP9L1EWT8qOkNwkrgxRkR9xeMyo3Uc0EmkO5OaFTrwCkwNTnO3qFAoKVMviozVvLu/K9QucNGBNrIZ+TWNWfvPNqXWGNQkmmuxMF741yI3iYj2lLgE0piKvzKklSS2TWEWiI9CXwb6fy9yVgtlEN3tsN0yaZMCGcY5bn324vAoI8elD6hgspWjCt839HfKXFbvhm5RojzH2P5YBvCX+O/acg7hXdtiFq78pzxgdOhORv0fpKP10/J+czoJToIf+KoXnuBDnY5Xric+4AFJBI1BesqQBLrHJ0/fBgFOOiW3AmVNzI1Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MN2PR15MB4287.namprd15.prod.outlook.com (2603:10b6:208:1b6::13)
 by DM6PR15MB4250.namprd15.prod.outlook.com (2603:10b6:5:16b::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Wed, 1 Jun
 2022 14:13:42 +0000
Received: from MN2PR15MB4287.namprd15.prod.outlook.com
 ([fe80::548f:cce1:5c99:3995]) by MN2PR15MB4287.namprd15.prod.outlook.com
 ([fe80::548f:cce1:5c99:3995%7]) with mapi id 15.20.5314.012; Wed, 1 Jun 2022
 14:13:42 +0000
From:   Chris Mason <clm@fb.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     "Darrick J. Wong" <djwong@kernel.org>,
        xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "dchinner@redhat.com" <dchinner@redhat.com>
Subject: Re: [PATCH RFC] iomap: invalidate pages past eof in
 iomap_do_writepage()
Thread-Topic: [PATCH RFC] iomap: invalidate pages past eof in
 iomap_do_writepage()
Thread-Index: AQHYdVSdJFyxgdgUO0+O8N+baoACW606eNWAgAAgGIA=
Date:   Wed, 1 Jun 2022 14:13:42 +0000
Message-ID: <BB5F778F-BFE5-4CC9-94DE-3118C60E13B6@fb.com>
References: <20220601011116.495988-1-clm@fb.com>
 <YpdZKbrtXJJ9mWL7@infradead.org>
In-Reply-To: <YpdZKbrtXJJ9mWL7@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.80.82.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 43f5344d-b089-4a5d-05f1-08da43d8ee92
x-ms-traffictypediagnostic: DM6PR15MB4250:EE_
x-microsoft-antispam-prvs: <DM6PR15MB4250982AAA7759D608ECE7C0D3DF9@DM6PR15MB4250.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mvjKQdASdTiz1IH1/LDypq11gk0oB80SD6mPIHTDCrM9Uqm6j3bqtnY2J5UzT1PqoIDaNMCVVnNhnS0+4z7mAiF5I5zRGh7zJwfqSvoE9vfTlBR916QwMbNaRB/R4dWvhL0QISkx1MuOhpRKtgia6yHoRePSSEXf7AzZ6NXkTTmPTOeV760woK7nK+5rbnilDF4IL3evypMM28LQAWhuIoeKXelxLkOpEnMzDIw40sPeFzxwN+9f0+Rl3wGIymxJnw2WPe0OTN9hMrnPmcMwHjmEzjtLFTu0m5vMNDc2efXdNLUTXEgZGFzgcuVyL9VR0jBYBEZFg9IQ8c/QuWcIQL4qFwkNS/+r8ve++GWV/uAVwOz6pHx+3nVPjgYjSLBIge72istEkykCjk2+beykSOZvh8dgwIz98ZyuoURZmk9lANN/aXDPPpSnMQAwcJJF1qMTs+d62Tes/d9yd21EtzEqUU3rUBnboJeQ3roASA4WiqZD2hE/vGL4MzEWWNQ0o/lw9DzLW2Ro9XP2HH9iIGns9Q2Bj4qeacIBEDv0mqcemdlxS3X0TPGs4E7utBsG7xA0vp0nxQcdeR7xYL+Lb2wjjlg2hnDWjcy/KHLvFf923KPQlbOMHPQNhWmye0GgeDux4AEnss5z59TZwFiLZHooGDP2Nn9WDWoE3h8UhKQjk8BhqaBA88zmetjbUaSrtghiDjBzsjXyWrvmBrNAq5bBHfL5T1TiDgmYmcFjAMIqE2Pa6BOaPOTecLtigWUt
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR15MB4287.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(54906003)(2616005)(6916009)(8936002)(38070700005)(33656002)(76116006)(66946007)(508600001)(316002)(4326008)(86362001)(186003)(64756008)(66556008)(66476007)(66446008)(8676002)(83380400001)(53546011)(6506007)(5660300002)(6486002)(71200400001)(6512007)(2906002)(122000001)(38100700002)(36756003)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RlVON2xqSFRxYzZtb3pYdmJtVEpOdHNrV1lsUzZURjVHMFdRWksyaXRQQWxh?=
 =?utf-8?B?dHhnUzczeXlEVHpYbEd0ODdwSzFiSm9wMyt6TGpJL1Y4OFJ1VzZScWMvRUxs?=
 =?utf-8?B?YmZQRVhDL3M4OWpRaHBSVGVSRmc5bkl6bW12UnpESEl4RUVsbkVWZjFlQ1JV?=
 =?utf-8?B?b0c0RjVpV0hkNEZRaEE3THdqTi9iZitwdnhJbFg3c2RiWEJkbGR4aEdIRDV3?=
 =?utf-8?B?TUd4a3pYZ3gwQk5uek5lVkUxbzlFKzJHV0xBNjZEV3ZMVDFEeXI5NHZGUkRq?=
 =?utf-8?B?MnBiWHRwdDV6Y2E0dW93YW1xSjRpekJ2MWM5c1NHY2FBanVuWTNtdnB4OUZk?=
 =?utf-8?B?eXlQSU9sb285TytBUms0WVpXLy9BTTlZTzQ1OEUrUHI0T2FoOXNQK1daNE5W?=
 =?utf-8?B?aDVFS3UrTXNNU0dCT1NRZ1I2S3ZpeGNhSytaTUtJNkRURTl3dUVFRkJ3ejhp?=
 =?utf-8?B?S2dMNDNlaUt2QnQyY0cxeVBOWTN4Y2JweFF5VzNjYVI2SWRKbTcwVWJXbUtq?=
 =?utf-8?B?VE5kNUdDbWFyQmc2U2hiYm5RRWFSWWtONjB5TUtZeFhlbmgvSklrRFhKL1M5?=
 =?utf-8?B?cDh2Yk1JTEdxWkloYTE2L2MxZk5GM1RZcTZoMGl3Y1RGZFFqV25CWHdjamZB?=
 =?utf-8?B?dXgxSm5ibzR4K2U0aERMQU1ibUFPdkdRN3JtcFpoNUdGU3hQcmpzSE1MbFVW?=
 =?utf-8?B?Qm41TTdEcktGeTRJaWhoNWJPQzNTUzNFV0UycmlwU1BydUVubUFKUTRBQmww?=
 =?utf-8?B?eUZEUU1lR09SM0QxL1VlbFcwYStreTdTMEVHY2c1MHQvRUpURDMydEgrK0NJ?=
 =?utf-8?B?OXpEZUE2N3FxdlA2N1A2UVRPVHFzR1YxRkVUdGt4bEc1UWZUUCs0YXJoVkFt?=
 =?utf-8?B?eVp2N2o2TDBsQWJtc0ZoTjFQaFNuN3hIeFIzVGxWTzRmc3BqbE9Pa0dzTzRv?=
 =?utf-8?B?RWt6VmVjZHl3UE1BVDVrT2JOU0JHVFYwU0diemNOSlhhTHRaUVVBZzJxSEl2?=
 =?utf-8?B?VjcvZ1BxL0pMbEhHKzZkb1k4NFN4K1UwWnZ6dXgvY3lJNmg1R01oZ3NwZEwy?=
 =?utf-8?B?SFh1RFExOHZYSXROanZESVZnWkkzWSsxOUFwR2dvS01rV2k0TGt6eXFSeE1W?=
 =?utf-8?B?djNXM1VFYkNhMC9QOGlMc21kby9tUldzOTBMT3BTcnFXS0xWQ3lENGZYVTY5?=
 =?utf-8?B?WWR0c0lMdFBJaEN2MGtiNFpxR3RVN1RKVisrM1JFRFh4eno2NThGMEJnckRG?=
 =?utf-8?B?SnlhQmlCeVJCZUthMkwvOXNaY0MvUEx3QU1BZTRsNUlrRnZwd2RoMGE4aDY4?=
 =?utf-8?B?eFFEd0JzS2twMDVpcnBkem1oUjZNQm1IbWlPNGxCdXFoRVAzWDhKL1hEM2Rm?=
 =?utf-8?B?aU9PQnI0NXVDT1pZZ3hCeWU1NnRtVDRSbGxkTlpaWlBXeDY0R1F5c3Z4RTIw?=
 =?utf-8?B?UnVuaUZ0MDVEeVlWTE5hcnFEOHFZOUxmdHdOUmV5WlB5SjJDTngyODFpQ0pZ?=
 =?utf-8?B?clhVci80L1ZzTTc3VThXL0ZrelFiZW9mZXczQUEwdm1OcEVwTm5yb1h6aTBx?=
 =?utf-8?B?SlJyUEF0dVBIVmFzRDB6R1RRZ0tHbHVlSllSc1drVllpTXZmVGdyTXNRN2NL?=
 =?utf-8?B?eDhQNWpoWHJSbXlDUXdJbldibVJrWWh3MitvMDJXNnhsZXNTM2hFclVKem5z?=
 =?utf-8?B?amdKRWtrSkJsbDBpZmxnVXhTSVpSNzUvQzhDRHl1SEZBQjdxWStOTXlVSlIw?=
 =?utf-8?B?eEVad2o4NUFDUUhqMWVzMythTGk4VlRoYUhRZjVhcnliZC9nWTNpVFdlejRa?=
 =?utf-8?B?SGRuaDlhRTBiZmNSTVZNTTZWNTdsRUVMc1drQUJlNk1aMWc4NGF5ZTJ5c0VE?=
 =?utf-8?B?RDFvb2tWSFBVKytyNG0vY1VXdEhGZTdJcmZnbEdicVIxaXl5cWgwZzBJYjJQ?=
 =?utf-8?B?QzQ1S3FLYnpUTEVLK2pxN09Bd2Z5Vjc3c2wvK2kxUnRBZW9OUDR4Qnk1dHdr?=
 =?utf-8?B?bmxGb0hIQTArQ0ZMb0ZqWWpjTmdSRk1ZVGhuNUNvOUtwbUp0QTU2MUJNNWRL?=
 =?utf-8?B?NXAvZmxGYjR3aGNrYmV1QmNmKzR4TWV5NlAzZXZETTVXNmFZRzNYU0U5QTQ0?=
 =?utf-8?B?eXBlUW92Q3pjUGV2WWo0bzN4WkJOd2xub2ZGL1ZWVFFUNHhrdkFhNWl4Rmdu?=
 =?utf-8?B?Slp4d1UxMSs2V1ZOaTFoK2hRN0pKWDQraGF4V2JzRmlJVW94clJ1MUxpR2cw?=
 =?utf-8?B?YzdZOVo1S0NmckJPN09Ib3EzYlQ0ZVRHK041b0NtcVRBRWpENnJrSFNVRWxB?=
 =?utf-8?B?bERzQ0ZEWSs2WnFoN0RJNEZlRVNlNjc3NnpJVTIyNFQ5QWI5TnYrekpWMHhR?=
 =?utf-8?Q?/H0ec4qgDxmnQfe4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9F9EAD31221C304EA8402093302C67F4@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR15MB4287.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43f5344d-b089-4a5d-05f1-08da43d8ee92
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2022 14:13:42.0734
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 39xf/8UB5atwL6O+2INDO1e9LzAaruP8KTEwePd9A25RoK4CScFAztjdXHGc+6yL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB4250
X-Proofpoint-ORIG-GUID: 1eTLS2qZ4KwxZVvde3zpg-yfQuUmEvCP
X-Proofpoint-GUID: 1eTLS2qZ4KwxZVvde3zpg-yfQuUmEvCP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-01_05,2022-06-01_01,2022-02-23_01
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

DQo+IE9uIEp1biAxLCAyMDIyLCBhdCA4OjE4IEFNLCBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGlu
ZnJhZGVhZC5vcmc+IHdyb3RlOg0KPiANCj4gVGhpcyBkb2VzIGxvb2sgc2FuZSB0byBtZS4gSG93
IG11Y2ggdGVzdGluZyBkaWQgdGhpcyBnZXQ/DQoNCkFsbW9zdCBub25lIGF0IGFsbCwgSSBtYWRl
IHN1cmUgdGhlIGludmFsaWRhdGVzIHdlcmUgdHJpZ2dlcmluZyBhbmQgYmFzaGVkIG9uIGl0IHdp
dGggZnN4LCBidXQgaGF2ZW7igJl0IGV2ZW4gZG9uZSB4ZnN0ZXN0cyB5ZXQuICBUaGUgZmlyc3Qg
cnVsZSBhYm91dCB0cnVuY2F0ZSBpcyB0aGF0IHYxIHBhdGNoZXMgYXJlIGFsd2F5cyBicm9rZW4s
IHNvIEnigJltIGV4cGVjdGluZyBleHBsb3Npb25zLg0KDQo+IEVzcGVjaWFsbHkNCj4gZm9yIHRo
ZSBibG9jayBzaXplIDwgcGFnZSBzaWUgY2FzZT8gQWxzbyBhZGRpbmcgRGF2ZSBhcyBoZSBoYXMg
c3BlbnQNCj4gYSBsb3Qgb2YgdGltZSBvbiB0aGlzIGNvZGUuDQo+IA0KDQpTb3JyeSBEYXZlLCBJ
IHRob3VnaHQgSSBoYWQgeW91IGluIGhlcmUgYWxyZWFkeS4NCg0KPiBPbiBUdWUsIE1heSAzMSwg
MjAyMiBhdCAwNjoxMToxN1BNIC0wNzAwLCBDaHJpcyBNYXNvbiB3cm90ZToNCj4+IGlvbWFwX2Rv
X3dyaXRlcGFnZSgpIHNlbmRzIHBhZ2VzIHBhc3QgaV9zaXplIHRocm91Z2gNCj4+IGZvbGlvX3Jl
ZGlydHlfZm9yX3dyaXRlcGFnZSgpLCB3aGljaCBub3JtYWxseSBpc24ndCBhIHByb2JsZW0gYmVj
YXVzZQ0KPj4gdHJ1bmNhdGUgYW5kIGZyaWVuZHMgY2xlYW4gdGhlbSB2ZXJ5IHF1aWNrbHkuDQo+
PiANCj4+IFdoZW4gdGhlIHN5c3RlbSBhIHZhcmlldHkgb2YgY2dyb3VwcywNCj4gDQo+IF5eXiBU
aGlzIHNlbnRlbmNlIGRvZXMgbm90IHBhcnNlIF5eXg0KPiANCg0KTW9zdCBvZiBwcm9kdWN0aW9u
IGlzIHNldHVwIHdpdGggb25lIGNncm91cCB0cmVlIGZvciB0aGUgd29ya2xvYWRzIHdlIGxvdmUg
YW5kIGNhcmUgYWJvdXQsIGFuZCBhIGZldyBjZ3JvdXAgdHJlZXMgZm9yIGV2ZXJ5dGhpbmcgZWxz
ZS4gIFdlIHRlbmQgdG8gY3JhbmsgZG93biBtZW1vcnkgb3IgSU8gbGltaXRzIG9uIHRoZSB1bmxv
dmVkIGNncm91cHMgYW5kIHByaW9yaXRpemUgdGhlIHdvcmtsb2FkIGNncm91cHMuDQoNClRoaXMg
cHJvYmxlbSBpcyBoaXR0aW5nIG91ciBteXNxbCB3b3JrbG9hZHMsIHdoaWNoIGFyZSBtb3N0bHkg
T19ESVJFQ1Qgb24gYSByZWxhdGl2ZWx5IHNtYWxsIG51bWJlciBvZiBmaWxlcy4gIEZyb20gYSBr
ZXJuZWwgcG9pbnQgb2YgdmlldyBpdOKAmXMgYSBsb3Qgb2YgSU8gYW5kIG5vdCBtdWNoIGFjdHVh
bCByZXNvdXJjZSBtYW5hZ2VtZW50LiAgV2hhdOKAmXMgaGFwcGVuaW5nIGluIHByb2QgKG9uIGFu
IG9sZGVyIDUuNiBrZXJuZWwpIGlzIHRoZSBub24tbXlzcWwgY2dyb3VwcyBhcmUgYmxvd2luZyBw
YXN0IHRoZSBiYWNrZ3JvdW5kIGRpcnR5IHRocmVzaG9sZCwgd2hpY2gga2lja3Mgb2ZmIHRoZSBh
c3luYyB3cml0ZWJhY2sgd29ya2Vycy4NCg0KVGhlIGFjdHVhbCBjYWxsIHBhdGggaXM6IHdiX3dv
cmtmbigpLT53Yl9kb193cml0ZWJhY2soKS0+d2JfY2hlY2tfYmFja2dyb3VuZF9mbHVzaCgpLT53
Yl93cml0ZWJhY2soKS0+X193cml0ZWJhY2tfaW5vZGVzX3NiKCkNCg0KSm9oYW5uZXMgZXhwbGFp
bmVkIHRvIG1lIHRoYXQgd2Jfb3Zlcl9iZ190aHJlc2god2IpIGVuZHMgdXAgcmV0dXJuaW5nIHRy
dWUgb24gdGhlIG15c3FsIGNncm91cHMgYmVjYXVzZSB0aGUgZ2xvYmFsIGJhY2tncm91bmQgbGlt
aXQgaGFzIGJlZW4gcmVhY2hlZCwgZXZlbiB0aG91Z2ggbXlzcWwgZGlkbuKAmXQgcmVhbGx5IGNv
bnRyaWJ1dGUgbXVjaCBvZiB0aGUgZGlydHkuICBTbyB3ZSBjYWxsIGRvd24gaW50byB3Yl93cml0
ZWJhY2soKSwgd2hpY2ggd2lsbCBsb29wIGFzIGxvbmcgYXMgX193cml0ZWJhY2tfaW5vZGVzX3di
KCkgcmV0dXJucyB0aGF0IGl04oCZcyBtYWtpbmcgcHJvZ3Jlc3MgYW5kIHdl4oCZcmUgc3RpbGwg
Z2xvYmFsbHkgb3ZlciB0aGUgYmcgdGhyZXNob2xkLg0KDQpJbiBwcm9kLCBicGZ0cmFjZSBzaG93
ZWQgbG9vcGluZyBvbiBhIHNpbmdsZSBpbm9kZSBpbnNpZGUgYSBteXNxbCBjZ3JvdXAuICBUaGF0
IGlub2RlIHdhcyB1c3VhbGx5IGluIHRoZSBtaWRkbGUgb2YgYmVpbmcgZGVsZXRlZCwgaV9zaXpl
IHNldCB0byB6ZXJvLCBidXQgaXQgc3RpbGwgaGFkIDQwLTkwIHBhZ2VzIHNpdHRpbmcgaW4gdGhl
IHhhcnJheSB3YWl0aW5nIGZvciB0cnVuY2F0aW9uLiAgV2XigJlkIGxvb3AgdGhyb3VnaCB0aGUg
d2hvbGUgY2FsbCBwYXRoIGFib3ZlIG92ZXIgYW5kIG92ZXIgYWdhaW4sIG1vc3RseSBiZWNhdXNl
IHdyaXRlcGFnZXMoKSB3YXMgcmV0dXJuaW5nIHByb2dyZXNzIGhhZCBiZWVuIG1hZGUgb24gdGhp
cyBvbmUgaW5vZGUuICBUaGUgcmVkaXJ0eV9wYWdlX2Zvcl93cml0ZXBhZ2UoKSBwYXRoIGRvZXMg
ZHJvcCB3YmMtPm5yX3RvX3dyaXRlLCBzbyB0aGUgcmVzdCBvZiB0aGUgd3JpdGVwYWdlcyBtYWNo
aW5lcnkgYmVsaWV2ZXMgcmVhbCB3b3JrIGlzIGJlaW5nIGRvbmUuICBucl90b193cml0ZSBpcyBM
T05HX01BWCwgc28gd2XigJl2ZSBnb3QgYSB3aGlsZSB0byBsb29wLg0KDQpJIGhhZCBkcmVhbXMg
b2YgcG9zdGluZyBhIHRyaXZpYWwgcmVwcm9kdWN0aW9uIHdpdGggdHdvIGNncm91cHMsIGRkLCBh
bmQgYSBzaW5nbGUgZmlsZSBiZWluZyB3cml0dGVuIGFuZCB0cnVuY2F0ZWQgaW4gYSBsb29wLCB3
aGljaCB3b3JrcyBwcmV0dHkgd2VsbCBvbiA1LjYgYW5kIHJlZnVzZXMgdG8gYmUgdXNlZnVsIHVw
c3RyZWFtLiAgIEpvaGFubmVzIGFuZCBJIHRhbGtlZCBpdCBvdmVyIGFuZCB3ZSBzdGlsbCB0aGlu
ayB0aGlzIHBhdGNoIG1ha2VzIHNlbnNlLCBzaW5jZSB0aGUgcmVkaXJ0eSBwYXRoIGZlZWxzIHN1
Ym9wdGltYWwuICBJ4oCZbGwgdHJ5IHRvIG1ha2UgYSBiZXR0ZXIgcmVwcm9kdWN0aW9uIGFzIHdl
bGwuDQoNClRvIGdpdmUgYW4gaWRlYSBvZiBob3cgcmFyZSB0aGlzIGlzLCBJ4oCZZCBydW4gYnBm
dHJhY2UgZm9yIDMwMCBzZWNvbmRzIGF0IGEgdGltZSBvbiAxMEsgbWFjaGluZXMgYW5kIHVzdWFs
bHkgZmluZCBhIHNpbmdsZSBtYWNoaW5lIGluIHRoZSBsb29wLg0KDQotY2hyaXMNCg0K
