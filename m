Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 949105B05CA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Sep 2022 15:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbiIGNzK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Sep 2022 09:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiIGNzJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Sep 2022 09:55:09 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2109.outbound.protection.outlook.com [40.107.220.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F038A1CFC7;
        Wed,  7 Sep 2022 06:55:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bPCdCe5e72xinleAvGEbESNFNCl3vrKlKuvQmopK1NkYxaMrtmyKEZwoEBhb5roJl18NiKP+iMrZ0C4uxEAcFYvibuVIxA3jv+VJGpIwW6tf2je5xmBCw4RXjREx4f+j+FfzZ+Yju5WiIUd8JiO11ThEsU1IoSxnsyaz74IYJ5C77xrrc6UrdWh9PWHP0CcsZLkagF8bFJG4V3e5CyQ8lQ/Kjv54Ibm6sVoIcabvUpnxbymEsfs47QCaH9R7VebNzmVMlGaHSAJhu8rdSquBYnP1SNoGCqN0irLu10WEZI+GBYlOi2G/qkxgeFjsxP0g2eaI63/jm8yoq0RiLfeqgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JwIHfaCdvzel1e9WABqdEAe8MbzLyd/gL/qsoQitn+E=;
 b=NeZzHtNRC0Ty4OazUNlA0n9OGSpoPFPfgXShejO/brs4o3x/s0SbBCqAIwWiTsVM/slweUF8vgKoGj2HkURZfUwQ5Ju97MlPIQ7a5SACjmOBz4quMJ/4oPXJDruNPmPrA6kNfFz0MHbiFO3ClsSlt4z8agS8weYsed7hawjwfo7fD/lVdsC89bToHNd3PcGB6ickOlBqpOG5badTRUl4pkQ3UADsl0emlGiNZUDjPe749Daf3WCd/H24QPqKUdRkBauLlVtu4z6OuuhJfJrd984WkNFuth1KZYUdCgds+L/i8RQ+eR9v/fP43039x6XoKTW1JlPFAGIZWkP+X4S/+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JwIHfaCdvzel1e9WABqdEAe8MbzLyd/gL/qsoQitn+E=;
 b=O2TE786Y6dY6VbVfeyMHo4QJNrc1fufaG2WzjALAQD+DNrKiGqgO0qGzYS6DnTQFKV7O26L5GLm6eS3UFjVilRkufQChqP4k9xDJSffsXgBGZfcmFqzOHa1uExOZrQCLmFLG3kTSt5lewkiuT3NbhDj0SsMAMNMGfk+DyqQuq5Q=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by BY5PR13MB3762.namprd13.prod.outlook.com (2603:10b6:a03:229::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.11; Wed, 7 Sep
 2022 13:55:05 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::f1c7:62d0:a63d:f5ca]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::f1c7:62d0:a63d:f5ca%3]) with mapi id 15.20.5612.012; Wed, 7 Sep 2022
 13:55:05 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bfields@fieldses.org" <bfields@fieldses.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>
CC:     "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "xiubli@redhat.com" <xiubli@redhat.com>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "neilb@suse.de" <neilb@suse.de>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
        "linux-man@vger.kernel.org" <linux-man@vger.kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "tytso@mit.edu" <tytso@mit.edu>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "jack@suse.cz" <jack@suse.cz>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "lczerner@redhat.com" <lczerner@redhat.com>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Subject: Re: [man-pages RFC PATCH v4] statx, inode: document the new
 STATX_INO_VERSION field
Thread-Topic: [man-pages RFC PATCH v4] statx, inode: document the new
 STATX_INO_VERSION field
Thread-Index: AQHYwqs/evAHvn9kzUKFB4lWpvCB0q3T1xmAgAATgACAAAFbgIAABbEAgAAL3gA=
Date:   Wed, 7 Sep 2022 13:55:04 +0000
Message-ID: <8a71986b4fb61cd9b4adc8b4250118cbb19eec58.camel@hammerspace.com>
References: <20220907111606.18831-1-jlayton@kernel.org>
         <166255065346.30452.6121947305075322036@noble.neil.brown.name>
         <79aaf122743a295ddab9525d9847ac767a3942aa.camel@kernel.org>
         <20220907125211.GB17729@fieldses.org>
         <771650a814ab1ff4dc5473d679936b747d9b6cf5.camel@kernel.org>
In-Reply-To: <771650a814ab1ff4dc5473d679936b747d9b6cf5.camel@kernel.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|BY5PR13MB3762:EE_
x-ms-office365-filtering-correlation-id: 2ed4403c-3c81-4f26-9d41-08da90d89136
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZEZHD6QdzoveZJpjCeDfH8VYFWZruydiawLPy1FmroaXmqr1Sw2nXdxI3N43P1lU0J8B1I0l/kyGvM1afEGviv6ztA3E+OpBU8jwlyVeVBLRmUs3HDJlfGcthYyg9OdKcd1isX6ifCyR8qOLpIIOkPil5PNt1mlQHBdFfCMmn4B51/7YbNEMVFVe7C83GcwJzhEtKVi8LjqpjntkXRd5HRhoo/kR3KjpR2MllLXSUCwChu/PgEoUCZCMMv0ZAGveWoq+P2JqHGYSFmUyxz/zzcwE/AMUfTgSqInZuohfN4oXTF4cvtp3OahWROi23fYLeWYjes9rds1s/jDiQ36IqR1dGLNQpjBpZoPQ1/fO7wv5IeNnu9l/0rg2evUbw9hPHbInDQyx0/ZnRJWN4MrVO7FS9jeAbIddbKbC40jGhD7AOeoRwPsIY/esk8FGsSi0Y8bXDJVCLzNCtUzjQwCSkowbrXE5S7ktj3Z79BWjTHkltAh3WosgUBYtVmfj9stugA3leMTZr7tWjBwTkzCe9JdU27QHIIxfOk4VBW//mBQfF/FK6M8/4C6oNIeBzfEBRK302HikF+kmEs+72EBTmXqDrpLn+4KR5b2EmX+DBWS3yseLI2MyG5By1FPSnrWZ1g4Zd3eP6M2qgyJeVYm/mlRDlcL6VwXnKe3oMkSDSAYiZdqmJsVkJc7/plJ6iDITvFdlU0hxB6NV7H8BpbEWtAeTLAdkUm0GeCfmT3+Qj/mHmbAhB+oDkl3xh6H5VlNAWwWoiE8cyT0jWIICgJV7eQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(39830400003)(376002)(346002)(396003)(366004)(36756003)(38100700002)(4326008)(86362001)(76116006)(8676002)(64756008)(66446008)(66556008)(66476007)(66946007)(316002)(38070700005)(122000001)(6486002)(83380400001)(6506007)(26005)(478600001)(41300700001)(6512007)(71200400001)(54906003)(110136005)(5660300002)(8936002)(186003)(2616005)(7416002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dFFtYlE1UVNxNGkxTjhBWEUxVEM0cDVwQURqQnpQMHk1K01YT1BqbnZSUXdG?=
 =?utf-8?B?dWJhYVVqZW9NQlh2UWdFMzdIZGpFc3Vmb1VudFdTN1JKVEJQZ2dtbXZKb3lI?=
 =?utf-8?B?Kzh4NFJWVGVnU0xWY3BmVTF5bVRpYWxtSVp4Vmt0dGdiN0Vvb1ZSaStTQ1pt?=
 =?utf-8?B?SUswbzdhL2JyN2c1d1RXV2syOVRLZW1BVmZpQllrc2JOM3dza2IySU1Ma0Ra?=
 =?utf-8?B?dWZFVllyV3o4bUxHSHlwYmsyczhiSElnTW01dlgybjVKWm1XKzB2MnFiZnBN?=
 =?utf-8?B?WmgvMTVVK0MvMmx1Y3FOeWMyeWZjSndHQ1U4cU4xMFUrSTJ6UU1NM253eC9L?=
 =?utf-8?B?Y245dlpYK0dJd1ZkRmxibzg5WGtxaFFSVCtHS1ZucnF2TVNscnZ3dWd1NHpD?=
 =?utf-8?B?Qm1sSm5GeTBTR21sV1RlNFNBSGQxblhQWGR3eGNzZGF0VmFGRFpHTUQ4bURj?=
 =?utf-8?B?dXdRdndma0VUZ3NDNi9OelJxUDc2UEtBREgveVZaOGVXTGpBeDhxWVV5eisv?=
 =?utf-8?B?RTY3ZXpBYTZBY0wwN1VWU1BuaDR5KzlsMlBMT09uclN6SXFxemVOV2tXRnFH?=
 =?utf-8?B?UEJSZUN3dVUrd1FzYlZJbkVoVVp6Q3EwWTd0SWJuRWZ1dkNtNGF0STZTWHJ0?=
 =?utf-8?B?U1ZpV0svRGsvRWxSenViKzRwdDVCM3IzUmUyWkFQUnNXcnNNNHFOdjVFVkZn?=
 =?utf-8?B?QWJiaGlueCtmN3d1aFNYamFnVWVUQXlyNHBBZ1VDUGVFQTkxN3UxZFdhTFZU?=
 =?utf-8?B?VzhPQjJoeWRWYU9ZN0RiUmRrNEZuQkFzSmtoQTU1ZXZvWkUvK3pVZDZSVStj?=
 =?utf-8?B?UFhENGNFUVVEbE9qMEp3RCtBYzRVQ1lqU3ZESjBHNi9lRmZkR2ZreUo2YlFv?=
 =?utf-8?B?OWtzTFd5QnZrZkwwVTE3ckxZL3ZKbXNlY3NzcWZ2Y1lhV2ZvMXlVUnR1T3dB?=
 =?utf-8?B?dWoramlEOU1zd216SGV5WUh1WXoyL2phSkdjVndWMEpiM1JsL01qYmErT1J5?=
 =?utf-8?B?RzJhVkZ0YkZMYWVSSVMyVlRUK2o1Q2V1SmhTVTV0L0ltWEwyUnU5c1FHMFJn?=
 =?utf-8?B?SjJ4eDNNMmdDbDd5VTJIazlBeXlFUEtIb1RIZkhmdXZjZ3ROTklpS3NlL3U2?=
 =?utf-8?B?UHdPS1RPcVg1Rk5ieFVQbU1qR29LNW9rbnM1OVRUYm9yZk4zNjRJeUJDMnIz?=
 =?utf-8?B?RVFFOEpxdy9EYzBnSmJBMGJMQ3EvdzJyeWgyNEM4OGJ3RXFzeHY5TFhpZThE?=
 =?utf-8?B?NkJUMzhKOEdNeHl3SE9kWHArSmU5RExkSVZQQWprL0JYVGdNdm5RWDd5OFB2?=
 =?utf-8?B?dVd2WUZMZHBjdzZHOEdac3V5RlRlcytYUWdsOVBxb1dOMW9pWkpaN2xkZUNw?=
 =?utf-8?B?Y09LRjNJZ3Jja2RKWEFoMmhBVGhabldObUFKZkJGWnphREVjbmU1amVmWDFr?=
 =?utf-8?B?emtMZWFpVzdxUXJOTTMyVExXa3c1U3pFOVBpNTNpRXRkb01SS0tla1lZTGNs?=
 =?utf-8?B?MjU5STlKam9qblh5L2dFR2VqTWJzVzhtVzZyNUc5c2JCQUh4dzV3RE9DcVlm?=
 =?utf-8?B?OXViMkNzY0ZsY291MjRQNWowanZsQitJbmp0b1hVdkhlVCt6NFJvbGtkUysw?=
 =?utf-8?B?Smt5a2FWQmJWQko4L1RGNnZkamZLMlFRZUJTb3pZV0NaSlBFWjM4Ymdtd0VW?=
 =?utf-8?B?OHpta2lacHVzUy9rc3RQSEZQd2ZnbG1lalY4dUEvbXRIQ2NBYkpYcC9kK0p1?=
 =?utf-8?B?UUorMGUzV0tjbEdwSTJZVFovd3NabU9IcXhCaTlvZmhjS2pHNXZvTWxpcW9n?=
 =?utf-8?B?MXkwZ0MrZmdkeHg4cDdHWkp3eTRnbnhwMGtVUUIxRHdFUm9hZ3p4VDl5RTlU?=
 =?utf-8?B?Wk9JTVd6YVNhM0tJa25EOVlkVEtpZURCRHUvbUlLQ1Y3WWkxWHA1S0o4eTkx?=
 =?utf-8?B?cnA1T1VnclVrYUt5amR3YWtnMHBXRVd3bjJBOEhkdW4vd2ZCVnNaK1FtdTNP?=
 =?utf-8?B?cHFlb3Q2ZC8zSDY3dG82aEhLWG5WVVM3MmxQWFg2QUZVaHVJM21sZ0tSd1pV?=
 =?utf-8?B?K0pNWmMyMkt4cStnb0VFWU84UWhTbHJGQmttY3U4OEhjbFF4cmxCOTJTL1FV?=
 =?utf-8?B?QkIyOW5hM0VFOVBuOWExL25tcnhSZHpZbU4zeW5PUUxGd3hEN0hBNnRNc2oy?=
 =?utf-8?B?Ync9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5B9E4A44480CF14D8C1E8D4815DBB9A3@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR13MB3762
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gV2VkLCAyMDIyLTA5LTA3IGF0IDA5OjEyIC0wNDAwLCBKZWZmIExheXRvbiB3cm90ZToNCj4g
T24gV2VkLCAyMDIyLTA5LTA3IGF0IDA4OjUyIC0wNDAwLCBKLiBCcnVjZSBGaWVsZHMgd3JvdGU6
DQo+ID4gT24gV2VkLCBTZXAgMDcsIDIwMjIgYXQgMDg6NDc6MjBBTSAtMDQwMCwgSmVmZiBMYXl0
b24gd3JvdGU6DQo+ID4gPiBPbiBXZWQsIDIwMjItMDktMDcgYXQgMjE6MzcgKzEwMDAsIE5laWxC
cm93biB3cm90ZToNCj4gPiA+ID4gT24gV2VkLCAwNyBTZXAgMjAyMiwgSmVmZiBMYXl0b24gd3Jv
dGU6DQo+ID4gPiA+ID4gK1RoZSBjaGFuZ2UgdG8gXGZJc3RhdHguc3R4X2lub192ZXJzaW9uXGZQ
IGlzIG5vdCBhdG9taWMgd2l0aA0KPiA+ID4gPiA+IHJlc3BlY3QgdG8gdGhlDQo+ID4gPiA+ID4g
K290aGVyIGNoYW5nZXMgaW4gdGhlIGlub2RlLiBPbiBhIHdyaXRlLCBmb3IgaW5zdGFuY2UsIHRo
ZQ0KPiA+ID4gPiA+IGlfdmVyc2lvbiBpdCB1c3VhbGx5DQo+ID4gPiA+ID4gK2luY3JlbWVudGVk
IGJlZm9yZSB0aGUgZGF0YSBpcyBjb3BpZWQgaW50byB0aGUgcGFnZWNhY2hlLg0KPiA+ID4gPiA+
IFRoZXJlZm9yZSBpdCBpcw0KPiA+ID4gPiA+ICtwb3NzaWJsZSB0byBzZWUgYSBuZXcgaV92ZXJz
aW9uIHZhbHVlIHdoaWxlIGEgcmVhZCBzdGlsbA0KPiA+ID4gPiA+IHNob3dzIHRoZSBvbGQgZGF0
YS4NCj4gPiA+ID4gDQo+ID4gPiA+IERvZXNuJ3QgdGhhdCBtYWtlIHRoZSB2YWx1ZSB1c2VsZXNz
Pw0KPiA+ID4gPiANCj4gPiA+IA0KPiA+ID4gTm8sIEkgZG9uJ3QgdGhpbmsgc28uIEl0J3Mgb25s
eSByZWFsbHkgdXNlZnVsIGZvciBjb21wYXJpbmcgdG8gYW4NCj4gPiA+IG9sZGVyDQo+ID4gPiBz
YW1wbGUgYW55d2F5LiBJZiB5b3UgZG8gInN0YXR4OyByZWFkOyBzdGF0eCIgYW5kIHRoZSB2YWx1
ZQ0KPiA+ID4gaGFzbid0DQo+ID4gPiBjaGFuZ2VkLCB0aGVuIHlvdSBrbm93IHRoYXQgdGhpbmdz
IGFyZSBzdGFibGUuIA0KPiA+IA0KPiA+IEkgZG9uJ3Qgc2VlIGhvdyB0aGF0IGhlbHBzLsKgIEl0
J3Mgc3RpbGwgcG9zc2libGUgdG8gZ2V0Og0KPiA+IA0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgcmVhZGVywqDCoMKgwqDCoMKgwqDCoMKgwqB3cml0ZXINCj4gPiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC0tLS0tLcKgwqDCoMKgwqDCoMKgwqDCoMKgLS0tLS0t
DQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoGlfdmVyc2lvbisrDQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqBzdGF0eA0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmVhZA0KPiA+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgc3RhdHgNCj4gPiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgdXBkYXRl
IHBhZ2UgY2FjaGUNCj4gPiANCj4gPiByaWdodD8NCj4gPiANCj4gDQo+IFllYWgsIEkgc3VwcG9z
ZSBzbyAtLSB0aGUgc3RhdHggd291bGRuJ3QgbmVjZXNzaXRhdGUgYW55IGxvY2tpbmcuIEluDQo+
IHRoYXQgY2FzZSwgbWF5YmUgdGhpcyBpcyB1c2VsZXNzIHRoZW4gb3RoZXIgdGhhbiBmb3IgdGVz
dGluZyBwdXJwb3Nlcw0KPiBhbmQgdXNlcmxhbmQgTkZTIHNlcnZlcnMuDQo+IA0KPiBXb3VsZCBp
dCBiZSBiZXR0ZXIgdG8gbm90IGNvbnN1bWUgYSBzdGF0eCBmaWVsZCB3aXRoIHRoaXMgaWYgc28/
IFdoYXQNCj4gY291bGQgd2UgdXNlIGFzIGFuIGFsdGVybmF0ZSBpbnRlcmZhY2U/IGlvY3RsPyBT
b21lIHNvcnQgb2YgZ2xvYmFsDQo+IHZpcnR1YWwgeGF0dHI/IEl0IGRvZXMgbmVlZCB0byBiZSBz
b21ldGhpbmcgcGVyLWlub2RlLg0KDQpJIGRvbid0IHNlZSBob3cgYSBub24tYXRvbWljIGNoYW5n
ZSBhdHRyaWJ1dGUgaXMgcmVtb3RlbHkgdXNlZnVsIGV2ZW4NCmZvciBORlMuDQoNClRoZSBtYWlu
IHByb2JsZW0gaXMgbm90IHNvIG11Y2ggdGhlIGFib3ZlIChhbHRob3VnaCBORlMgY2xpZW50cyBh
cmUNCnZ1bG5lcmFibGUgdG8gdGhhdCB0b28pIGJ1dCB0aGUgYmVoYXZpb3VyIHcuci50LiBkaXJl
Y3RvcnkgY2hhbmdlcy4NCg0KSWYgdGhlIHNlcnZlciBjYW4ndCBndWFyYW50ZWUgdGhhdCBmaWxl
L2RpcmVjdG9yeS8uLi4gY3JlYXRpb24gYW5kDQp1bmxpbmsgYXJlIGF0b21pY2FsbHkgcmVjb3Jk
ZWQgd2l0aCBjaGFuZ2UgYXR0cmlidXRlIHVwZGF0ZXMsIHRoZW4gdGhlDQpjbGllbnQgaGFzIHRv
IGFsd2F5cyBhc3N1bWUgdGhhdCB0aGUgc2VydmVyIGlzIGx5aW5nLCBhbmQgdGhhdCBpdCBoYXMN
CnRvIHJldmFsaWRhdGUgYWxsIGl0cyBjYWNoZXMgYW55d2F5LiBDdWUgZW5kbGVzcyByZWFkZGly
L2xvb2t1cC9nZXRhdHRyDQpyZXF1ZXN0cyBhZnRlciBlYWNoIGFuZCBldmVyeSBkaXJlY3Rvcnkg
bW9kaWZpY2F0aW9uIGluIG9yZGVyIHRvIGNoZWNrDQp0aGF0IHNvbWUgb3RoZXIgY2xpZW50IGRp
ZG4ndCBhbHNvIHNuZWFrIGluIGEgY2hhbmdlIG9mIHRoZWlyIG93bi4NCg0KLS0gDQpUcm9uZCBN
eWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25k
Lm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
