Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07C0B57BF1A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Jul 2022 22:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbiGTUOQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Jul 2022 16:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiGTUON (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Jul 2022 16:14:13 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-bgr052101064008.outbound.protection.outlook.com [52.101.64.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D09994D148;
        Wed, 20 Jul 2022 13:14:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lUG8Xa9Pl/OWq6eN4Z1hR9Mb1L/ttbMfOhTHleFPXOXMDZidWhH32ro4qP1cHfD7qwrYBxVqXKKaBHxpAynKZZLAuMYKs2EzSts4SV1OTfFC3aYCT+U7dvr/cqKnzLuJabYPl9VB3XtUwcvBvK22FOkloqO0pGRo5TdDzF1dU0spCwiykCIauAb7UfpKfeyGC9O/4zz8XSAMmMyrUTJSHAe8Fnw+fckf7tOldTF8nuxCgRkCRwC6nzd4t3snaCXHZs63AiLVeKycouBfHS3XNfWCeWVpMHQzy4J+tJXm/piDYTxJWw+KcUC/w+AOM5ds9Nf5N/byQjqf05onklT2rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6cDSRCOAMPsIHEHBbDDkwpuAhymyyIAOnG0lRMCI7xc=;
 b=ekVrZ/lvcWTbwqSH7iQ4Dr/6scAVD48+iXV06fOiqUuXD3g0nB1dRO1MGEhSSHsCUMFYZMDKHMFyacroEvCRUocHJK4BTLcQulGe3nlPgBOPjGF7PYwcLf+y7SqsM4kGHY0dTNpHuK6cXaPJHPxVLg4Lx6202d7W/R5Z7vhDMkkXOfOLEffn7WGpId/q6ka3izZhnGlO6f0++3J9sQ9hzUsP3cRWg1uq2jV+q67/mi7c608vr0h/MeUz/zIbugPMWWrlMwBAuDGXXdK+VGfDxMl0pAh6GroDlbayGGqrQ7ytN0L/SOSkUT6Ph1sOq+eWqzbOsgWo+6K4Q2JT70OsuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6cDSRCOAMPsIHEHBbDDkwpuAhymyyIAOnG0lRMCI7xc=;
 b=cglaK2sDUb1QISqCxa2s9A+jIKLTVNh3J7vTWKY7Q9CR05dTpZNoqM3IKGbh+7Yi+qbgafWJ3H14hqSLl9UgWmTc+9ftn4oxWqGgRbyBae6P9D0uFJGNx6IrpBrHeZqCJ6Pp5ymyRQ2fw5sdxQ4cY499J0uHaRaWGea1oe8LWwI=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by DM5PR05MB3258.namprd05.prod.outlook.com (2603:10b6:3:c8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.16; Wed, 20 Jul
 2022 20:14:09 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::d813:9300:4877:39d0]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::d813:9300:4877:39d0%7]) with mapi id 15.20.5458.018; Wed, 20 Jul 2022
 20:14:09 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
CC:     Peter Xu <peterx@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        Jonathan Corbet <corbet@lwn.net>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        zhangyi <yi.zhang@huawei.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v4 2/5] userfaultfd: add /dev/userfaultfd for fine grained
 access control
Thread-Topic: [PATCH v4 2/5] userfaultfd: add /dev/userfaultfd for fine
 grained access control
Thread-Index: AQHYm6msXDLL/Bu+aECRDX4d27LWyK2GR2wAgAADx4CAABN8gIAAK+oAgAD+VgCAACkugIAAARgA
Date:   Wed, 20 Jul 2022 20:14:09 +0000
Message-ID: <C14F0ED5-0347-4CF5-A5D6-BB8DC3437F1C@vmware.com>
References: <20220719195628.3415852-1-axelrasmussen@google.com>
 <20220719195628.3415852-3-axelrasmussen@google.com>
 <D43534E1-7982-45EE-8B16-2C4687F49E77@vmware.com>
 <CAJHvVcigVqAibm0JODkiR=Pcd3E14xp0NB6acw2q2enwnrnLSA@mail.gmail.com>
 <D8D7C973-1480-4166-86AF-AD179873B2A4@vmware.com>
 <YtdpQBrAGJwMnssj@xz-m1.local>
 <3C93275E-B3B8-45CA-808E-0C163DBBB32F@vmware.com>
 <CAJHvVcjs_=vbUbXcm1_vAxatEu9inqkVo_geX7pcW1XqWF=gJw@mail.gmail.com>
In-Reply-To: <CAJHvVcjs_=vbUbXcm1_vAxatEu9inqkVo_geX7pcW1XqWF=gJw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 31e0ed8c-b109-4bd5-f68c-08da6a8c67b0
x-ms-traffictypediagnostic: DM5PR05MB3258:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fnGhEhnr1PWGpuIhVg4Fk6He9aPEW1/qvgiWF0EWqOf3n7Sp/150wiWNl+2r2qoSQaGeuBs4SgI7zFHy6JgMvSmiADxP7gX4BXDxse1nHVvbD3ZrO5koYZ88/wcNR9/l/y72KM0a262dpGZYHJTD13YEE0rFEURjk3ff3dE8juJPWlMEtMQxy5dwNWQIkrZT9lPqu08I1u5cpBff9QNE1Be7bkMUxQZ0vpnyD3OJEbqyTTLWZo5jJn/lA/yF4yHwwDhbtPrYC06kFf54wGmrsfZQjBAFPahVsejILRJ2rO0ktVtwW+CoZTC58uV0Ig/aUgbajp39VHOJ5B9YbBAmqbgc8iHRJ8DWEnCYOVha+g5YEhAns4+OIwMz3UoIxir7ew4OJmH4wY4QSqe+iufDlwTynjkn85lv1734gi612Su8GvZ6rtaVz/fGROw1Pn4CePV22ozqS86+dUi/kA4sHMCRHPXgu4ONYYbYB8LIgiLsAUwt8z/Qg0COEl/YYGfZuiMO5U03xF6WbNZRn2laHHPz8UQ2WRIrkhxUwzIRmEvY7xdS5JBLqmnqOoeR/NIWQ1UUpm9avCD7fWweYqOYbA4F2JS1uzJMyZ5e73OG+o9fyxAf6fjwITlIbeHXAnp6l+vlj6JgrcDaRPfK7oqCWSRsPIKiLB3rURNJnTBwqF6MucYqUcLcqgrNVmuz/gv/wT4k8qz4+lGsFVZD2pb4Wb/q2TSrkWp3y6cekx5geFn5hCSi+iRaE+6pQ25ZpS1JWdRophFaKXECVuYDDryZMfqFiIXZ9piILwV7s90pVy41PZEQzOqbEeNbRalmrGgraJk33EUyV82Gcogx0Gj7Lg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(346002)(39860400002)(136003)(396003)(376002)(2616005)(122000001)(83380400001)(54906003)(4326008)(38070700005)(8936002)(7416002)(186003)(5660300002)(53546011)(6512007)(71200400001)(26005)(2906002)(478600001)(86362001)(41300700001)(6486002)(66946007)(66446008)(6506007)(33656002)(38100700002)(64756008)(76116006)(6916009)(66476007)(316002)(8676002)(66556008)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TEJYNGJGSGx2c1F5Q1YzS1RDcXZGejdwWTBoM1VFcklNaEZZTHhvNG9NbEVS?=
 =?utf-8?B?TXBnN2NPb3dMNndUMXhtaGpBTzRGckxLR0JiV0RyTzBDNDRhOWRkOWx0ZEg2?=
 =?utf-8?B?SkxQaW4vb1QvQ1EyOUlmOVdCKzJJRTkrTEJtbFhlR2hXRTJXRGtOZFVZL2lz?=
 =?utf-8?B?N3VpcVNOdGZ6M3pZaXlVT282NVZtYjIwK2xjejV3MVBUUEpsVE5FcGFDSnNj?=
 =?utf-8?B?MW9uc2VLWTg4MTgzWDgvMVR1ZDJzVFlRSWF1ZXhneldCbE1tbGxVTEFDMnB0?=
 =?utf-8?B?NmFBT1VhMjdpWnZ3QTFoTmI4ZjBESFNWaFpVbnVONUR4Wm43bWEvWnFUYnMx?=
 =?utf-8?B?L3c0cmdENHJJcG05dFAycDdja2wvUVhRcC96cVRkYkFncXdIK0RCTUxTRlNY?=
 =?utf-8?B?VDNHa291SVNaTm9oTE94NHBwSGFuRnNjK2tyNGxLcm5xZFl4VHNiQzVGK3hj?=
 =?utf-8?B?TnhENHdjTG8vQmJha05PU1hJcXlkUjdpSEgyQWxGdHRVYjZaRXY5enU0L3du?=
 =?utf-8?B?U3ZVbTlFR2U3dzRTd2lwVjJzZEVMaEFyUWV1OTNVeUZkS2FhYXJqUm9kRzBx?=
 =?utf-8?B?SDVaN2RNL3JER2VkeXVzZy92bWQrb0psVE01b1VaK3hjdXc1VUN6TGkwTWhr?=
 =?utf-8?B?dUI1dGwwT25BbERDSmpITEdNY0JnTTV6WXVMUktGZFNab2Y4QTZLeGZ3NFp3?=
 =?utf-8?B?ZTluc3E5ZGVrYUh6RXZpS2ZXM1N2ak5YS05rTE8vMndnZWhDQ3EyazR4cGla?=
 =?utf-8?B?N2hVTmJjWTlEMHdGZnNPcmN3RmhqL0twNnpsL0xPeFUyYk8xbXhyTGphTzBm?=
 =?utf-8?B?VkQyQnEvSDk0bEtLVE5tSCtwOUp0MHFzdDJxaG1tcGRuZElxalRTRm9ZTjhF?=
 =?utf-8?B?Z3UyMFJzYVNPSTNqaXk1azdjLzhIQ2tVc3F4TExJeFdUMGc3T2RIdlMxVUJ5?=
 =?utf-8?B?UHpBdnkyRnNXSzc1SzJYT2lmL0dFZUVwb2xBN2VrU3NpdW9MaUJtRG4reFdP?=
 =?utf-8?B?YVRZM1FvbkZuTVhzd251RnRFTlBkcTR0cytFY1c4WEVhZGEzQlczLytoZnlX?=
 =?utf-8?B?NWNWZnJ1WU5xQVg1QjNRNGZka1BxU1FWeHprWHJkczNoQTI5VlgvbFZNQzgz?=
 =?utf-8?B?cDhZRVhVa25HL001c0RWeU9wSFAwVDBPUzJMcFdqMHRXODN4M1FKd2k1dS9Q?=
 =?utf-8?B?RGFiNzlNTkVsaFUrMHRhUWw0c3lKYlZRbEcyK0YyK1pkWHlsL3NqSEl4VGxm?=
 =?utf-8?B?NEd6SmdzK0l4Q1VnYlNXZGZIM3FMME1CUE9JUWxqY2RBQndqd1krMGMrck9D?=
 =?utf-8?B?djBxeDlSTE00cVVEdHEvQVNwZndWZ05XTnppNXQreFZDSHNjTkVqME83SVFO?=
 =?utf-8?B?d054aGZabnFDQm5BekJVZSs0aXIwRk5lWnFYMFhqOU4yV2dCKzdRWVFtSzlC?=
 =?utf-8?B?M05PelFabWRsVldsSlh6Uk9TNGdTOUloZC85dzdFS1g2Rk5renRiMGN1WnF4?=
 =?utf-8?B?YUpXbkZRaVgvdXVHMkZiOGxLUmtrNG1IQm03ZCtiZEdZZFlBaExoaGhzbm5E?=
 =?utf-8?B?dU9ublEvbFk0YnNvbk5jVU13RmJHdEl5Y2VoczdnU2EvYkFPZmNOdkpBZDdQ?=
 =?utf-8?B?KzdhbXJRM3BvWlJkbG1RVGM2YytDV2NHY1dOeDI3YVV0M21KbHlUSmV4R0w2?=
 =?utf-8?B?ZTNteVJRbmxMT0t2SXgyazBlcHYvVFVWdERCYU5NcHlHVlgvdTlZVWRGVlJT?=
 =?utf-8?B?TVJ3MlEzL3BsbFBOempDa0Mwbit6WTQ0V1ZBa3gvUWNNZzA2TmxKb2hHTHBD?=
 =?utf-8?B?RkhtVkdxSzR6NFR1WkF0QWdmU09paklucmlRQUFITU9ITSthSHFQa3IzRE9n?=
 =?utf-8?B?ZFMrSmJweGk2ZGhIOWR6K1Mrbnp4VTZDanljMWJjSmdDNWR0ZTZ6STVibTk2?=
 =?utf-8?B?YU12OTNsWHNLZ01BUXVxZVZlWExkdVlja0srR2Z0QXpFaWdoTkVuZTZmRC9Y?=
 =?utf-8?B?ZWNxV3BQcFRjdDhCZG9KQ0U3TklJdWRRMWhwS2NjNTZrYVZ0Tm1vREVqb0pQ?=
 =?utf-8?B?dy85THM2aTlLTjMxU3k0aGJXWXRqeG5zcTg5SEJTemRpUU03a0djNFZqUDNi?=
 =?utf-8?Q?HLL5f1xW2gfOlT3PChzpJQpJH?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <21D198650786AA47A65CDF7931638665@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31e0ed8c-b109-4bd5-f68c-08da6a8c67b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2022 20:14:09.3806
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q21t3BVYPhGvQ6qaUUa3cM+vBbev4PWdpgDybFoevtJTlVllk2O/k0+GEqCdgy1zW7fGSpWfCOH/MOow7olUmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR05MB3258
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gSnVsIDIwLCAyMDIyLCBhdCAxOjEwIFBNLCBBeGVsIFJhc211c3NlbiA8YXhlbHJhc211c3Nl
bkBnb29nbGUuY29tPiB3cm90ZToNCg0KPiBPbiBXZWQsIEp1bCAyMCwgMjAyMiBhdCAxMDo0MiBB
TSBOYWRhdiBBbWl0IDxuYW1pdEB2bXdhcmUuY29tPiB3cm90ZToNCj4+IE9uIEp1bCAxOSwgMjAy
MiwgYXQgNzozMiBQTSwgUGV0ZXIgWHUgPHBldGVyeEByZWRoYXQuY29tPiB3cm90ZToNCj4+IA0K
Pj4+IOKaoCBFeHRlcm5hbCBFbWFpbA0KPj4+IA0KPj4+IE9uIFR1ZSwgSnVsIDE5LCAyMDIyIGF0
IDExOjU1OjIxUE0gKzAwMDAsIE5hZGF2IEFtaXQgd3JvdGU6DQo+Pj4+IEFueWhvdywgSSBkbyB3
YW50IHRvIGNsYXJpZnkgYSBiaXQgYWJvdXQgdGhlIOKAnGNyb3NzLXByb2Nlc3Mgc3VwcG9ydOKA
nQ0KPj4+PiB1c2VyZmF1bHRmZCBzaXR1YXRpb24uIEJhc2ljYWxseSwgeW91IGNhbiBhbHJlYWR5
IGdldCBjcm9zcy1wcm9jZXNzIHN1cHBvcnQNCj4+Pj4gdG9kYXksIGJ5IHVzaW5nIGNhbGxpbmcg
dXNlcmZhdWx0ZmQoKSBvbiB0aGUgY29udHJvbGxlZCBwcm9jZXNzIGFuZCBjYWxsaW5nDQo+Pj4+
IHBpZGZkX29wZW4oKSBmcm9tIGFub3RoZXIgcHJvY2Vzcy4gSXQgZG9lcyB3b3JrIGFuZCBJIGRv
IG5vdCByZW1lbWJlciBhbnkNCj4+Pj4gaXNzdWVzIHRoYXQgaXQgaW50cm9kdWNlZCAoaW4gY29u
dHJhc3QsIGZvciBpbnN0YW5jZSwgdG8gaW8tdXJpbmcsIHRoYXQNCj4+Pj4gd291bGQgYnJlYWsg
aWYgeW91IHVzZSB1c2VyZmF1bHRmZCtpb3VyaW5nK2ZvcmsgdG9kYXkpLg0KPj4+IA0KPj4+IERv
IHlvdSBtZWFuIHRvIGJhc2UgaXQgb24gcGlkb2ZfZ2V0ZmQoKT8NCj4+IA0KPj4gYXV0b2NvcnJl
Y3Q/IDopDQo+PiANCj4+IEkgZGlkIHJlZmVyIHRvIHBpZGZkX2dldGZkKCkgYXMgYSBzeXNjYWxs
IHRoYXQgY2FuIGJlIHVzZWQgdG9kYXkgYnkgb25lDQo+PiBwcm9jZXNzIHRvIGNvbnRyb2wgdGhl
IGFkZHJlc3Mgc3BhY2Ugb2YgYW5vdGhlciBwcm9jZXNzLiBJIGRpZCBub3QgaW50ZW5kIHRvDQo+
PiB1c2UgaXQgZm9yIHRoZSBhY3R1YWwgaW1wbGVtZW50YXRpb24uDQo+PiANCj4+PiBKdXN0IHdh
bnQgdG8gbWVudGlvbiB0aGF0IHRoaXMgd2lsbCBzdGlsbCBuZWVkIGNvbGxhYm9yYXRpb24gb2Yg
dGhlIHRhcmdldA0KPj4+IHByb2Nlc3MgYXMgdXNlcmZhdWx0ZmQgbmVlZHMgdG8gYmUgY3JlYXRl
ZCBleHBsaWNpdGx5IHRoZXJlLiAgRnJvbSB0aGF0IFBPVg0KPj4+IGl0J3Mgc3RpbGwgbW9yZSBz
aW1pbGFyIHRvIGdlbmVyYWwgU0NNX1JJR0hUUyB0cmljayB0byBwYXNzIG92ZXIgdGhlIGZkIGJ1
dA0KPj4+IGp1c3QgdG8gcGFzcyBpdCBpbiBhIGRpZmZlcmVudCB3YXkuDQo+PiANCj4+IFRoZXJl
IGFyZSBhbHNvIHNvbWUgdHJpY2tzIHlvdSBjYW4gZG8gd2l0aCBwdHJhY2UgaW4gb3JkZXIgbm90
IHRvIG5lZWQgdGhlDQo+PiBjb2xsYWJvcmF0aW9uLCBidXQgdGhleSBhcmUgYWRtaXR0ZWRseSBm
cmFnaWxlLg0KPj4gDQo+Pj4gSU1ITyB0aGUgY29yZSBjaGFuZ2UgYWJvdXQgaGF2aW5nIC9wcm9j
L3BpZC91c2VyZmF1bHRmZCBpcyBza2lwcGluZyB0aGF0DQo+Pj4gb25seSBsYXN0IHN0ZXAgdG8g
Y3JlYXRlIHRoZSBoYW5kbGUuDQo+PiANCj4+IFllcy4gVGhlIHBvaW50IHRoYXQgSSB3YXMgdHJ5
aW5nIHRvIG1ha2UgaXMgdGhhdCB0aGVyZSBhcmUgbm8gb3BlbiBpc3N1ZXMNCj4+IHdpdGggYWRk
aW5nIHN1cHBvcnQgZm9yIHJlbW90ZSBwcm9jZXNzIGNvbnRyb2wgdGhyb3VnaA0KPj4gL3Byb2Mv
cGlkL3VzZXJmYXVsdGZkLiBUaGlzIGlzIGluIGNvbnRyYXN0LCBmb3IgZXhhbXBsZSwgZm9yIHVz
aW5nIGlvLXVyaW5nDQo+PiB3aXRoIHVzZXJmYXVsdGZkLiBGb3IgaW5zdGFuY2UsIGlmIHlvdSB0
cnkgdG8gdXNlIGlvLXVyaW5nIFRPREFZIHdpdGgNCj4+IHVzZXJmYXVsdGZkICh3aXRob3V0IHRo
ZSBhc3luYyBzdXBwb3J0IHRoYXQgSSBuZWVkIHRvIGFkZCksIGFuZCB5b3UgdHJ5IHRvDQo+PiBt
b25pdG9yIHRoZSBmb3JrIGV2ZW50LCB0aGluZ3Mgd291bGQgYnJlYWsgKHRoZSBuZXcgdXNlcmZh
dWx0ZmQgZmlsZQ0KPj4gZGVzY3JpcHRvciBhZnRlciBmb3JrIHdvdWxkIGJlIGluc3RhbGxlZCBv
biB0aGUgaW8td29ya2VyIHRocmVhZCkuDQo+PiANCj4+IFRoaXMgaXMgYWxsIHRvIHNheSB0aGF0
IGl0IGlzIHJlYWxseSBzaW1wbGUgdG8gYWRkIHN1cHBvcnQgZm9yIG9uZSBwcm9jZXNzDQo+PiBt
b25pdG9yaW5nIHVzZXJmYXVsdGZkIG9mIGFub3RoZXIgcHJvY2Vzcywgc2luY2UgSSB1bmRlcnN0
b29kIHRoYXQgQXhlbCBoYWQNCj4+IGNvbmNlcm5lZCB0aGF0IHRoaXMgbWlnaHQgYmUgdXR0ZXJs
eSBicm9rZW7igKYNCj4gDQo+IE1vc3RseSBJIHdhcyB3b3JyaWVkIGl0IHdvdWxkIGJlIG5vbnRy
aXZpYWwgdG8gaW1wbGVtZW50LCBhbmQgaXQgaXNuJ3QNCj4gYSB1c2UgY2FzZSBJIHBsYW4gdG8g
dXNlIHNvIEkgd2FzIGhvcGluZyB0byBpZ25vcmUgaXQgYW5kIGRlZmVyIGl0IHRvDQo+IHNvbWUg
ZnV0dXJlIHBhdGNoZXMuIDspDQo+IA0KPiBCdXQsIGlmIGl0ICJqdXN0IHdvcmtzIiBJJ20gaGFw
cHkgdG8gaW5jbHVkZSBpdCBpbiB2NS4NCg0KVGhlcmUgaXMgYSBwcm9ibGVtIHRob3VnaCwgc2lu
Y2UgZm9yIG1hbnkgdXNlLWNhc2VzIHlvdSBkbyBuZWVkDQpwcm9jZXNzX21hZHZpc2V2KE1BRFZf
RE9OVE5FRUQpIHdoaWNoIGlzIHVuc3VwcG9ydGVkLCBhbmQgeW91IGFsc28gbmVlZCAtIGluDQpz
b21lIHVzZS1jYXNlcyAtIHRvIGJlIGFibGUgdG8gc2tpcCBwaW5uZWQgcGFnZXMuIFRoZXNlIGFy
ZSBwYXRjaGVzIHRoYXQgSQ0Kc3RpbGwgbmVlZCB0byBzZW5kLg0KDQpTbyBJIGxlYXZlIGl0IHRv
IHlvdSB0byBtYWtlIHVwIHlvdXIgbWluZCB3aGV0aGVyIGl0IGlzIHJlYXNvbmFibGUgdG8gYWRk
IGl0DQpub3cgd2l0aG91dCB0aGlzIHN1cHBvcnQu
