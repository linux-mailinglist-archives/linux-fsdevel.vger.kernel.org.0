Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 341AF53C2FC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Jun 2022 04:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240930AbiFCBai (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jun 2022 21:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240877AbiFCBaS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jun 2022 21:30:18 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE79025592;
        Thu,  2 Jun 2022 18:29:43 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2530qqQa028996;
        Thu, 2 Jun 2022 18:29:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=hsHPRhueROTnjtsqgpfRxSkoH4JDiRGItq4HCkWMx+w=;
 b=oJ++hjQLrrvb+8nOLKFUuwRis9jw44CgfsexeAvtLEFSp7GILuPo7qn/5l25p7+j/n2j
 5knVrt51zNbPPsDTzsqdUI7y1s2qr09RgPYQqIw5+V33VVkVFfZdKN1Wb0yBpluJai50
 yDOrDX7whfJOvnmHIPD80hAdAdFw1Vx1llQ= 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3gewq94ed4-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Jun 2022 18:29:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Di15XJgt3qR2BFv+AxM8Vn7vxu1JKiFrnUzy5swrSQxyHIBeNdVq3TX1aXCcMZwfhmz39LbIR1RXkJ8Qc6lwq5kWUl+Ki7ffpUlY9BC3lWWtEA4NJr1hdEnywSaKiSok9kUMGB7TYwIZBO4oemU/sAdPKnnLoi9z7/VzggxLol8HKYq+dJHMq9qhdxYfgV07mJxLBG9VyhmLTGvVi/OGEiayiapd1Wks+wBJQ+/Heum5x7Jxp8uxS1XzMz+qcHAaINcai5Df4rzl4UhtKlSIcg4muIiVwwM0Zhm5YhssxkqVxNVTFu5ESSLqR1QYHDOoOy8UeJWHe/LJUVJXjwOfRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hsHPRhueROTnjtsqgpfRxSkoH4JDiRGItq4HCkWMx+w=;
 b=fHtWdTgzJwuv3bw2DnsEBUA/OzujSJXg+2mjy9gJk4048gGq3AdVXR3C0nU19MZcu+HMTZTXh5PQoxhUxqmbls4UzKLY9bAf+2mqbGKda23bvwc89WgvMezAb+DpIUp5xeOBKur0+Y/Aox96qfkbUVkDG3iB4l1PpoqtKmnsaUyxnSJmpvJhNTZBuQaWBIToBIV9XKn4f6Se/y6ojPDnV3NBaEV9lcLrR8VsrqA5vtaIN1ZYKvNs92AaDGtYm126myeLz/qVjCFF0kVGhEyd3swSPA7q63ZelB4uJj+J1dcKGOm6zEHXZH/PtNNmt9ayT72fyu+1SXDQWkcB7jmlbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MN2PR15MB4287.namprd15.prod.outlook.com (2603:10b6:208:1b6::13)
 by PH7PR15MB5497.namprd15.prod.outlook.com (2603:10b6:510:1f7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Fri, 3 Jun
 2022 01:29:40 +0000
Received: from MN2PR15MB4287.namprd15.prod.outlook.com
 ([fe80::548f:cce1:5c99:3995]) by MN2PR15MB4287.namprd15.prod.outlook.com
 ([fe80::548f:cce1:5c99:3995%7]) with mapi id 15.20.5314.013; Fri, 3 Jun 2022
 01:29:40 +0000
From:   Chris Mason <clm@fb.com>
To:     Dave Chinner <david@fromorbit.com>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "dchinner@redhat.com" <dchinner@redhat.com>
Subject: Re: [PATCH RFC] iomap: invalidate pages past eof in
 iomap_do_writepage()
Thread-Topic: [PATCH RFC] iomap: invalidate pages past eof in
 iomap_do_writepage()
Thread-Index: AQHYdVSdJFyxgdgUO0+O8N+baoACW606eNWAgAAgGICAARcrAIAAkS8AgABuEICAADjIgA==
Date:   Fri, 3 Jun 2022 01:29:40 +0000
Message-ID: <B186E2FB-BCAF-4019-9DFF-9FF05BAC557E@fb.com>
References: <20220601011116.495988-1-clm@fb.com>
 <YpdZKbrtXJJ9mWL7@infradead.org>
 <BB5F778F-BFE5-4CC9-94DE-3118C60E13B6@fb.com>
 <20220602065252.GD1098723@dread.disaster.area> <YpjYDjeR2Wpx3ImB@cmpxchg.org>
 <20220602220625.GG1098723@dread.disaster.area>
In-Reply-To: <20220602220625.GG1098723@dread.disaster.area>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.80.82.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a2c4cd95-7764-4677-29c2-08da4500877c
x-ms-traffictypediagnostic: PH7PR15MB5497:EE_
x-microsoft-antispam-prvs: <PH7PR15MB54978BAEE312559BC22BFCC3D3A19@PH7PR15MB5497.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rkfo6ATTBsDNdN1oaOR5iubTWz3GEEA+cxsElk7df9VK+fOWgGddkplP3VAx97BvAfoFfgWAs10B8tbLHI0s1f/gqS0gkT84bQytxtsPI+CKA9MiPdYawlNbQRqsrv/MIoIyx11lKA/zp4wY4k+Pg3QWCoQjI1QT5tUufLKJQtOhHTYFf7xPWt1IKkUSfANrlXCNEG9N/zi+ygNnQKwVnjC3CRYZssYvhIw82sxChzalrwfEEHWUaxQlc5G6a1/e2KINjGDwrGKucQEHGWu81zQtj2xZQG8+ZnY04c1IGyA08PO+9R3L398Rjufnd48keGYeXWT4bRBdNqrnKyiWXZzzWKwDL/pQAC7olRgbd6Y7/YrNWSR2mTdC8OxRvjBvOS6Cz42I991DxP/ptKourLaf+Z4GXeC4rN26RVuTQRIm8f5Q37OJ3oEJIHXlUsLzvfaAQCENDEXeOne7xWPgKOhnOzIXMbhQZ1TlGvTifb0TUcfBATEju6FfYxHPxJsUf15CSm5Vt+IA1O34PIn5ptvDnS6pJC64Lymn4Q6pht/fGDPoOmriMQfOk5GjeevUFDcsRTUP8TuL6drl2M4q98nb2qgtb/rd2Bypg+EAiot27gtFgXVT1kaiSobWgB/7XOX4KGeH6qThOtc+psspKgKla8lg0qD4ELdUHRXoTgvPKsuA0P/fzTaiSzlOHEzDWwBn6K9H+pd4g1MdcZA90B+IJwL4oxOT4NkDSpk4nUO6j07IvnX/HUcpcSzFS6Iz
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR15MB4287.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(6506007)(6486002)(53546011)(38070700005)(6512007)(2616005)(186003)(83380400001)(36756003)(8936002)(33656002)(316002)(86362001)(4326008)(8676002)(76116006)(122000001)(66946007)(66556008)(64756008)(66446008)(66476007)(6916009)(38100700002)(54906003)(508600001)(71200400001)(5660300002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bnNkTjcrM1lUUzgvQ2hoVXIwNi85bjJtR25hQmZjN1lVeFdTUDh5NDlQRlEw?=
 =?utf-8?B?ODF1eGsyU25MbHB6NFZXbHFWL0wxaHBMYlMrRWE2WTBNOXdlSGNLeDErTUVp?=
 =?utf-8?B?Vi9KbUZwQXc3YVZEUTB4ZjhzWlkxYnNoQlRzd0tKSDhoaDNrM3BCZS9wNCsv?=
 =?utf-8?B?b2l2ekRBNldLbVpPS3pHajc2eEZYZTVoRU4xMkhrL1JLM3FCMUE5bjJMZytH?=
 =?utf-8?B?bGJYWDNTWEd3cWNOOGcrRndzSFB4SGdGSEZFS1pocU1SZU9aR0NiZ2RNejV2?=
 =?utf-8?B?OXd3WW16SnY3b3lqVnlRMUt1S1ZKaTliTDNhd09UamRmcFlHc0hhb2xaWkhC?=
 =?utf-8?B?UGx0OVA3cytZVFdweUpVeEx6RFVTSm5kQjRDY0wyYThpSmJqQ0Y5Sm85c08r?=
 =?utf-8?B?TlVZb0xCSkRvbThWYVh1WXBNT3hsWXlacGRhdXpZYThqbXBUT1oxdHI1OElL?=
 =?utf-8?B?NUo4b0NOdzVvYjNzMzhnL3dIbmhjUVQ0TExONDRmUkpDWkZWdHM0UDhPUnNv?=
 =?utf-8?B?aXArMWNyQ1dsZUtGZksvbTFjNmthdTRubUU1cWIxL3pxMlY0RHZ0a25sVHNt?=
 =?utf-8?B?RXBZN3IxcUtubEdYUWN1VDlBT3R2cm9BTjYzSXVCWWpubFRBVzZDR2MySUd1?=
 =?utf-8?B?bkZRa09jY0FiWDhkanQ5NGsvWjllelNFS0RjLzA3eW5vblhyYlRSaUxUZVc3?=
 =?utf-8?B?dTM2MkJvek1Eam9vNCtNQ3VFZWNFTmorTm9wSGVTUGJWeWZhK3ZXRjNZMEd4?=
 =?utf-8?B?SXVEMGVFT3R2eTZrbTFsWFVKOXcvWUdSYnNycHFtNkVDb2lMQkJRTmg5bmN3?=
 =?utf-8?B?VTYwNWVNSm1kM0gxL1hJYUhMMGxEQTBHRUFOZFMrcnRhYTJpSnJTMDIrc2NO?=
 =?utf-8?B?UzkwVFJva2RpMm1waEx2akhwMkpWL1hoaTM1UzRwdnlnUXFzbnBCVmRhc21p?=
 =?utf-8?B?b2IxNFdtQjFnWkxSbHRuY0JrdmhhcGE2ckdXd1JTM2tTdzVRVFdkYXJzMzRp?=
 =?utf-8?B?UndZYys4cCt1bzIvQUgyWGF1QXBOc3RpRlRaamFIQ0N4WEVCemllajBna3pY?=
 =?utf-8?B?UHpaM3NOYXZLMEtoQmMrVTVMcFdrVFdhbXY5WjF5VXM2bXdQUFkydjc2V09a?=
 =?utf-8?B?a3orOGErTkRVY1FVSFN2ZW5XQ01wemZKMGJUcnplNHlaZHM5V2xBeTlRSTVl?=
 =?utf-8?B?NnFJMmNNVmpBdTNWN2N2UWdMdFZ6RG1jZllJN2Q3c0dwR0psUjF4bkR0eWx0?=
 =?utf-8?B?SUV5RkxERkE3dktvWHAyd3MvVWVzSGRiSXFhcElXZWhCMmZSQTF0bkN0NGsx?=
 =?utf-8?B?dmVpS2paQW50SWNhWTMyUEFhRjg5VWwzUzVkQU93dWY3NXdlWEI4YmEzSmtr?=
 =?utf-8?B?N1NMb3duQ0RhN21vM2lQcUpacWVMVm5aVEtIMm1lTVlDYXJSeWk5VTRpRUU4?=
 =?utf-8?B?cGlsRGpVbnpWbHQzZDdHMytHZVpvU2VhelNQVlFWc2JEZnNmR2pDWDAzSi9N?=
 =?utf-8?B?dnlncHNIOW1GbEhmVlZMVnNQNlV6MmFFUGJqNFBqODQzeFg1VnJza0lJeUJL?=
 =?utf-8?B?QTlCU2g0bVZhbmlQQ2RNOWUyaUFpLzNWaE84MnNnZURPd0pqSVhsQkxvZ3U1?=
 =?utf-8?B?YWF6MW9VelBmeVp0eTE0eG1IZDY2S1VaamYrbVdMNDQ5bUlxc25FekVrQk9P?=
 =?utf-8?B?dmRPVFp3c09IOTdpQUk4Lzc0MUpCdnZYR2F6VE91Tnl0SlNldlVmdVZ5UjJj?=
 =?utf-8?B?Vmh1dm9FRUFyOVJjM1hRYk5tRjZSYTB4UEJJL1MvMUFCQ0xZQkhxN3laQVpZ?=
 =?utf-8?B?eVdzdWt6RkI2UUcxRTVFajlGQzB6dVIwUnFENXA2bFNONVQvOHorQURFU1BL?=
 =?utf-8?B?OFBYZHJvMWZmQWRLNW5LT05lYndFRWN5VHczMlg1R0Z4RDIxWjYvbEdqY3VF?=
 =?utf-8?B?ZFhpR0lQTnpidUJoNzViUUxaTUF0d0JOdHcvOUsrRCtnb3VFVURiMG4zTzBT?=
 =?utf-8?B?ODhneDRVYnAydWZwWFdaVlpIOHk2cTA4eitIbW9PZUcwQjVweTM5UWJoYXhr?=
 =?utf-8?B?WHBPL25FbXJndThlL2JwbjFIekgrWGtpSUhEM3RYd1RBOEtVUzMxNjdvYlly?=
 =?utf-8?B?U0RGQ2VXRWtidTdKaUlBWEwxZ0ZObEJqb01KYklUeTltZ201WUdmWTlYZXZh?=
 =?utf-8?B?VFVEU2YwcWFWTm44R3I3dnZNWXFqSEhhcFkrbFYvd0xnTHpZVndzeWcvVVF1?=
 =?utf-8?B?WmxjYThBSjF4R014TVF4WTBxQ1RSQ1hQTXljM3pRSnpHT0hnU0lkU09mMHhQ?=
 =?utf-8?B?TTdyRkhvbkRaNFdPVmFnTkFmb3d3RllTdDlkVnlITm5PdHZsb3hjMnFLWjlJ?=
 =?utf-8?Q?tJeHZa6lPvRYpVU4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B0C30901B5D1F4458C75D2F188B796F1@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR15MB4287.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2c4cd95-7764-4677-29c2-08da4500877c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2022 01:29:40.1099
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M+Y+83dgQ9kS5cdx5Q8rtTpWKCtM8GyyRLVvc8GTUrZc0Q+fQcy0iJkTZ5xKKnMw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR15MB5497
X-Proofpoint-ORIG-GUID: slldi181uPBsoGtXydQ53hQ04axS3Ff-
X-Proofpoint-GUID: slldi181uPBsoGtXydQ53hQ04axS3Ff-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-03_01,2022-06-02_01,2022-02-23_01
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

DQoNCj4gT24gSnVuIDIsIDIwMjIsIGF0IDY6MDYgUE0sIERhdmUgQ2hpbm5lciA8ZGF2aWRAZnJv
bW9yYml0LmNvbT4gd3JvdGU6DQo+IA0KPiBPbiBUaHUsIEp1biAwMiwgMjAyMiBhdCAxMTozMjoz
MEFNIC0wNDAwLCBKb2hhbm5lcyBXZWluZXIgd3JvdGU6DQo+PiBPbiBUaHUsIEp1biAwMiwgMjAy
MiBhdCAwNDo1Mjo1MlBNICsxMDAwLCBEYXZlIENoaW5uZXIgd3JvdGU6DQo+Pj4gT24gV2VkLCBK
dW4gMDEsIDIwMjIgYXQgMDI6MTM6NDJQTSArMDAwMCwgQ2hyaXMgTWFzb24gd3JvdGU6DQo+Pj4+
IEluIHByb2QsIGJwZnRyYWNlIHNob3dlZCBsb29waW5nIG9uIGEgc2luZ2xlIGlub2RlIGluc2lk
ZSBhIG15c3FsDQo+Pj4+IGNncm91cC4gVGhhdCBpbm9kZSB3YXMgdXN1YWxseSBpbiB0aGUgbWlk
ZGxlIG9mIGJlaW5nIGRlbGV0ZWQsDQo+Pj4+IGlfc2l6ZSBzZXQgdG8gemVybywgYnV0IGl0IHN0
aWxsIGhhZCA0MC05MCBwYWdlcyBzaXR0aW5nIGluIHRoZQ0KPj4+PiB4YXJyYXkgd2FpdGluZyBm
b3IgdHJ1bmNhdGlvbi4gV2XigJlkIGxvb3AgdGhyb3VnaCB0aGUgd2hvbGUgY2FsbA0KPj4+PiBw
YXRoIGFib3ZlIG92ZXIgYW5kIG92ZXIgYWdhaW4sIG1vc3RseSBiZWNhdXNlIHdyaXRlcGFnZXMo
KSB3YXMNCj4+Pj4gcmV0dXJuaW5nIHByb2dyZXNzIGhhZCBiZWVuIG1hZGUgb24gdGhpcyBvbmUg
aW5vZGUuIFRoZQ0KPj4+PiByZWRpcnR5X3BhZ2VfZm9yX3dyaXRlcGFnZSgpIHBhdGggZG9lcyBk
cm9wIHdiYy0+bnJfdG9fd3JpdGUsIHNvDQo+Pj4+IHRoZSByZXN0IG9mIHRoZSB3cml0ZXBhZ2Vz
IG1hY2hpbmVyeSBiZWxpZXZlcyByZWFsIHdvcmsgaXMgYmVpbmcNCj4+Pj4gZG9uZS4gbnJfdG9f
d3JpdGUgaXMgTE9OR19NQVgsIHNvIHdl4oCZdmUgZ290IGEgd2hpbGUgdG8gbG9vcC4NCj4+PiAN
Cj4+PiBZdXAsIHRoaXMgY29kZSByZWxpZXMgb24gdHJ1bmNhdGUgbWFraW5nIHByb2dyZXNzIHRv
IGF2b2lkIGxvb3BpbmcNCj4+PiBmb3JldmVyLiBUcnVuY2F0ZSBzaG91bGQgb25seSBibG9jayBv
biB0aGUgcGFnZSB3aGlsZSBpdCBsb2NrcyBpdA0KPj4+IGFuZCB3YWl0cyBmb3Igd3JpdGViYWNr
IHRvIGNvbXBsZXRlLCB0aGVuIGl0IGdldHMgZm9yY2libHkNCj4+PiBpbnZhbGlkYXRlZCBhbmQg
cmVtb3ZlZCBmcm9tIHRoZSBwYWdlIGNhY2hlLg0KPj4gDQo+PiBJdCdzIG5vdCBsb29waW5nIGZv
cmV2ZXIsIHRydW5jYXRlIGNhbiBqdXN0IHRha2UgYSByZWxhdGl2ZWx5IGxvbmcNCj4+IHRpbWUg
ZHVyaW5nIHdoaWNoIHRoZSBmbHVzaGVyIGlzIGJ1c3ktc3Bpbm5pbmcgZnVsbCBib3JlIG9uIGEN
Cj4+IHJlbGF0aXZlbHkgc21hbGwgbnVtYmVyIG9mIHVuZmx1c2hhYmxlIHBhZ2VzIChyYW5nZV9j
eWNsaWMpLg0KPj4gDQo+PiBCdXQgeW91IHJhaXNlIGEgZ29vZCBwb2ludCBhc2tpbmcgIndoeSBp
cyB0cnVuY2F0ZSBzdHVjaz8iLiBJIGZpcnN0DQo+PiB0aG91Z2h0IHRoZXkgbWlnaHQgYmUgY2Fu
bmliYWxpemluZyBlYWNoIG90aGVyIG92ZXIgdGhlIHBhZ2UgbG9ja3MsDQo+PiBidXQgdGhhdCB3
YXNuJ3QgaXQgKGFuZCB3b3VsZG4ndCBleHBsYWluIHRoZSBjbGVhciBhc3ltbWV0cnkgYmV0d2Vl
bg0KPj4gdHJ1bmNhdGUgYW5kIGZsdXNoZXIpLiBUaGF0IGxlYXZlcyB0aGUgd2FpdGluZyBmb3Ig
d3JpdGViYWNrLiBJIGp1c3QNCj4+IGNvbmZpcm1lZCB3aXRoIHRyYWNpbmcgdGhhdCB0aGF0J3Mg
ZXhhY3RseSB3aGVyZSB0cnVuY2F0ZSBzaXRzIHdoaWxlDQo+PiB0aGUgZmx1c2hlciBnb2VzIGJh
bmFuYXMgb24gdGhlIHNhbWUgaW5vZGUuIFNvIHRoZSByYWNlIG11c3QgYmUgdGhpczoNCj4+IA0K
Pj4gdHJ1bmNhdGU6IGZsdXNoZXINCj4+IHB1dCBhIHN1YnNldCBvZiBwYWdlcyB1bmRlciB3cml0
ZWJhY2sNCj4+IGlfc2l6ZV93cml0ZSgwKQ0KPj4gd2FpdF9vbl9wYWdlX3dyaXRlYmFjaygpDQo+
PiBsb29wIHdpdGggcmFuZ2VfY3ljbGljIG92ZXIgcmVtYWluaW5nIGRpcnR5ID5FT0YgcGFnZXMN
Cj4gDQo+IEJ1dCB3cml0ZV9jYWNoZV9wYWdlcygpIGRvZXNuJ3QgcmVwZWF0ZWRseSBsb29wIG92
ZXIgdGhlIHBhZ2VzLg0KPiANCj4gVGhlIGZsdXNoZXIgaXMNCj4gDQo+IC0+d3JpdGVwYWdlcw0K
PiBpb21hcF93cml0ZXBhZ2VzDQo+IHdyaXRlX2NhY2hlX3BhZ2VzKCkNCj4gbG9vcCBvdmVyIG1h
cHBpbmcgdHJlZQ0KPiBsb2NrIHBhZ2UNCj4gCWlvbWFwX2RvX3dyaXRlcGFnZQ0KPiAJIHNldF9w
YWdlX3dyaXRlYmFjaygpDQo+IAkgYWRkIHBhZ2UgdG8gaW9lbmQNCj4gPGVuZCBvZiBtYXBwaW5n
IHJlYWNoZWQ+DQo+IGlvbWFwX3N1Ym1pdF9pb2VuZCgpDQo+IDxwYWdlcyB1bmRlciB3cml0ZWJh
Y2sgZ2V0IHNlbnQgZm9yIElPPg0KPiByZXR1cm4gdG8gaGlnaCBsZXZlbCB3cml0ZWJhY2sNCj4g
DQo+IEFuZCBldmVudHVhbGx5IElPIGNvbXBsZXRpb24gd2lsbCBjbGVhciBwYWdlIHdyaXRlYmFj
ayBzdGF0ZS4NCj4gDQoNClllcywgdGhpcyBpcyBhY3R1YWxseSBoYXBwZW5pbmcgYmVmb3JlIHRo
ZSB0cnVuY2F0ZSBzdGFydHMuICBUaGUgdHJ1bmNhdGUgZmluZHMgdGhlc2Ugd3JpdGViYWNrIHBh
Z2VzIGFuZCB3YWl0cyBmb3IgdGhlbSB0byBmaW5pc2ggSU8sIGFuZCB3aGlsZSBpdOKAmXMgd2Fp
dGluZyB3Yl9jaGVja19iYWNrZ3JvdW5kX2ZsdXNoKCkgZ29lcyB3aWxkIG9uIHRoZSByZWRpcnR5
IHBhdGguDQoNCj4gaS5lLiB3cml0ZV9jYWNoZV9wYWdlcygpIHNob3VsZCBub3QgYmUgaGFyZCBs
b29waW5nIG92ZXIgdGhlIHBhZ2VzDQo+IGJleW9uZCBFT0YgZXZlbiBpZiByYW5nZV9jeWNsaWMg
aXMgc2V0IC0gaXQncyBza2lwcGluZyB0aG9zZSBwYWdlcywNCj4gc3VibWl0dGluZyBhbnkgdGhh
dCBhcmUgdW5kZXIgd3JpdGViYWNrLCBhbmQgdGhlLCBnb2luZyBiYWNrIHRvIGhpZ2gNCj4gbGV2
ZWwgY29kZSBmb3IgaXQgdG8gbWFrZSBhIGRlY2lzaW9uIGFib3V0IGNvbnRpbnVhdGlvbiBvZg0K
PiB3cml0ZWJhY2suIEl0IG1heSBjYWxsIGJhY2sgZG93biBhbmQgd2UgbG9vcCBvdmVyIGRpcnR5
IHBhZ2VzIGJleW9uZA0KPiBFT0YgYWdhaW4sIGJ1dCB0aGUgZmx1c2hlciBzaG91bGQgbm90IGJl
IGhvbGRpbmcgb24gdG8gcGFnZXMgdW5kZXINCj4gd3JpdGViYWNrIGZvciBhbnkgc2lnbmlmaWNh
dGlvbiBsZW5ndGggb2YgdGltZSBiZWZvcmUgdGhleSBhcmUNCj4gc3VibWl0dGVkIGZvciBJTy4N
Cj4gDQoNCkkgc3BlbnQgYSB3aGlsZSB0cnlpbmcgdG8gYmxhbWUgd3JpdGVfY2FjaGVfcGFnZXMo
KSBmb3IgbG9vcGluZyByZXBlYXRlZGx5LCBhbmQgZW5kZWQgdXAgbWFraW5nIGEgc2VyaWVzIG9m
IGJwZnRyYWNlIHNjcmlwdHMgdGhhdCBjb2xsZWN0ZWQgY2FsbCBzdGFjayBmcmVxdWVuY3kgY291
bnRlcnMgZm9yIGFsbCB0aGUgZGlmZmVyZW50IHdheXMgdG8gd2FuZGVyIGludG8gd3JpdGVfY2Fj
aGVfcGFnZXMoKS4gIEkgZXZlbnR1YWxseSByYW4gaXQgYWNyb3NzIDEwMEsgc3lzdGVtcyB0byBm
aWd1cmUgb3V0IGV4YWN0bHkgaG93IHdlIHdlcmUgZ2V0dGluZyBpbnRvIHRyb3VibGUuICBJdCB3
YXMgKHRoYW5rZnVsbHkpIHJlYWxseSBjb25zaXN0ZW50Lg0KDQpBcyB5b3UgZGVzY3JpYmUgYWJv
dmUsIHRoZSBsb29wcyBhcmUgZGVmaW5pdGVseSBjb21pbmcgZnJvbSBoaWdoZXIgaW4gdGhlIHN0
YWNrLiAgd2Jfd3JpdGViYWNrKCkgd2lsbCBsb29wIGFzIGxvbmcgYXMgX193cml0ZWJhY2tfaW5v
ZGVzX3diKCkgcmV0dXJucyB0aGF0IGl04oCZcyBtYWtpbmcgcHJvZ3Jlc3MgYW5kIHdl4oCZcmUg
c3RpbGwgZ2xvYmFsbHkgb3ZlciB0aGUgYmcgdGhyZXNob2xkLCBzbyB3cml0ZV9jYWNoZV9wYWdl
cygpIGlzIGp1c3QgYmVpbmcgY2FsbGVkIG92ZXIgYW5kIG92ZXIgYWdhaW4uICBXZeKAmXJlIGNv
bWluZyBmcm9tIHdiX2NoZWNrX2JhY2tncm91bmRfZmx1c2goKSwgc286DQoNCiAgICAgICAgICAg
ICAgICBzdHJ1Y3Qgd2Jfd3JpdGViYWNrX3dvcmsgd29yayA9IHsNCiAgICAgICAgICAgICAgICAg
ICAgICAgIC5ucl9wYWdlcyAgICAgICA9IExPTkdfTUFYLA0KICAgICAgICAgICAgICAgICAgICAg
ICAgLnN5bmNfbW9kZSAgICAgID0gV0JfU1lOQ19OT05FLA0KICAgICAgICAgICAgICAgICAgICAg
ICAgLmZvcl9iYWNrZ3JvdW5kID0gMSwNCiAgICAgICAgICAgICAgICAgICAgICAgIC5yYW5nZV9j
eWNsaWMgICA9IDEsDQogICAgICAgICAgICAgICAgICAgICAgICAucmVhc29uICAgICAgICAgPSBX
Ql9SRUFTT05fQkFDS0dST1VORCwNCiAgICAgICAgICAgICAgICB9Ow0KDQo+IElPV3MsIGlmIHRy
dW5jYXRlIGlzIGdldHRpbmcgc3R1Y2sgd2FpdGluZyBvbiB3cml0ZWJhY2ssIHRoZW4gdGhhdA0K
PiBpbXBsaWVzIHNvbWV0aGluZyBpcyBob2xkaW5nIHVwIElPIGNvbXBsZXRpb25zIGZvciBhIGxv
bmcgdGltZSwNCg0KRnJvbSBKb2hhbm5lc+KAmXMgdHJhY2luZyB0b2RheSwgdGhhdOKAmXMgYWJv
dXQgMTd1cy4gIE91ciB2aWN0aW0gY2dyb3VwIGhhcyBqdXN0IGEgaGFuZGZ1bCBvZiBmaWxlcywg
c28gd2UgY2FuIGJ1cm4gdGhyb3VnaCBhIGxvdCBvZiB3cml0ZV9jYWNoZV9wYWdlcyBsb29wcyBp
biB0aGUgdGltZSB0cnVuY2F0ZSBpcyB3YWl0aW5nIGZvciBhIHNpbmdsZSBJTyBvbiBhIHJlbGF0
aXZlbHkgZmFzdCBzc2QuDQoNCj4gbm90DQo+IHRoYXQgdGhlcmUncyBhIHByb2JsZW0gaW4gd3Jp
dGViYWNrIHN1Ym1pc3Npb24uIGkuZS4geW91IG1pZ2h0DQo+IGFjdHVhbGx5IGJlIGxvb2tpbmcg
YXQgYSB3b3JrcXVldWUgYmFja2xvZw0KDQpJIGFjdHVhbGx5IHRoaW5rIGEgd29ya3F1ZXVlIGJh
Y2tsb2cgaXMgY29taW5nIGZyb20gdGhlIGZsdXNoZXIgdGhyZWFkIGhvZ2dpbmcgdGhlIENQVS4g
IFRoZSBpbnZlc3RpZ2F0aW9uIHN0YXJ0ZWQgYnkgbG9va2luZyBmb3IgbG9uZyB0YWlsIGxhdGVu
Y2llcyBpbiB3cml0ZSgpIHN5c3RlbWNhbGxzLCBhbmQgRG9tYXPigJlzIG9yaWdpbmFsIGZpbmRp
bmcgd2FzIElPIGNvbXBsZXRpb24gd29ya2VycyB3ZXJlIHdhaXRpbmcgZm9yIENQVXMuICBUaGF0
4oCZcyBob3cgaGUgZW5kZWQgdXAgZmluZGluZyB0aGUgcmVkaXJ0eSBjYWxscyB1c2luZyBoaWdo
IGxldmVscyBvZiBDUFUuICBXZSBob25lc3RseSB3b27igJl0IGJlIHN1cmUgdW50aWwgd2UgbGl2
ZSBwYXRjaCBhIGxvdCBvZiBib3hlcyBhbmQgbG9vayBmb3IgbG9uZyB0YWlsIGxhdGVuY3kgaW1w
cm92ZW1lbnRzLCBidXQgSeKAmW0gcHJldHR5IG9wdGltaXN0aWMuDQoNCi1jaHJpcw==
