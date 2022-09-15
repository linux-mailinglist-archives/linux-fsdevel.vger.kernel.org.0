Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDA665BA07C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Sep 2022 19:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbiIORtb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Sep 2022 13:49:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiIORta (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Sep 2022 13:49:30 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 544303CBD5;
        Thu, 15 Sep 2022 10:49:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bj8JHtZMJAK26iYnZF77CJtpa7lWkOGwmZD1SK3jgQw8wxdlE4+4O5/mCxj3/huyL7mSXu8STPD+XRMIV2u78yyNEHS4O2B7SEeAa2avujTLEh+QQsG5NyUaA1OqBJoyq7Ph8rnMQl38FZMk87n1T3JJLfIFXmjfX1+aUjGc358lY5vxtSVNizGGnkRb5ytoT4EFg9AxN4pjyYxpSME0ba3GCDIPGQaCN/GOY+/Mrz46nh10DLAD7gwVapSl0kD3ym79GiiIhFR5hXRpQmv6kniKyKLdzuT6Wyfq/lK1y2eLk7g4fr0AJF+GsH19ULm0fC1AS7F2iCYz8PssAAWSsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qqD5M/ni5v4aTGHck1xKJe6GVqlnOoOPB394wME3xl8=;
 b=DZvqd1rRUMpOvE50/h9ShZErTMoSJaEBE3R9DQMlFQEd2v8qoHUJ9cPK7r/l0Zn3lEZSNJQ9PzPOXO2r7sSULJVsnGQm7UGDFj+knyb1m2Z60gSTEtG53R24BIyjyg5jtRjiuHMvkkiiNUqHLRlisa3jIscSi0BYkjNQESDtR2NJs4Y/j0TyV5vB+sh23Q0K3fry3lUtMRWYB5Rh5YtmwbQIq5RqGFeHZzuZRTs1ofAVA5erqmSjOcA9jtsyjr3O7J3p+APh3YXFKEJE5Ik4xKzwgvvtKKj2AxasNMjp3TIA++gKyxb42vItlxKIn5elZwWvEx2W0grZuAyEyUUM3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qqD5M/ni5v4aTGHck1xKJe6GVqlnOoOPB394wME3xl8=;
 b=FiskM0ASLjjlSUizSegrxgS0mHyS/Z1dPahKzJ61LouIEeV3bkwcM4zUoUdcheH1hpyF/YtAQDH+TjKBcDEFc9h7aP0DpR52lUDG9fWs4+vv90WJjBc7eB/4rpNsYEB/BvOi5sT0dHkSLAUHSj4//HjrGMDpM6haiP8vle5J//M=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by MW5PR13MB5993.namprd13.prod.outlook.com (2603:10b6:303:1c7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.10; Thu, 15 Sep
 2022 17:49:17 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::f1c7:62d0:a63d:f5ca]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::f1c7:62d0:a63d:f5ca%3]) with mapi id 15.20.5632.012; Thu, 15 Sep 2022
 17:49:17 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bfields@fieldses.org" <bfields@fieldses.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "neilb@suse.de" <neilb@suse.de>
CC:     "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
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
        "xiubli@redhat.com" <xiubli@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "lczerner@redhat.com" <lczerner@redhat.com>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [man-pages RFC PATCH v4] statx, inode: document the new
 STATX_INO_VERSION field
Thread-Topic: [man-pages RFC PATCH v4] statx, inode: document the new
 STATX_INO_VERSION field
Thread-Index: AQHYwqs/evAHvn9kzUKFB4lWpvCB0q3T1xmAgAATgACAAAFbgIAABbEAgAAK/YCAALZNAIAAgw4AgAByGoCAAAZagIAAAzmAgAAdFoCAAAvtAIAADJkAgANYaoCAApXgAIAAn+4AgAQd8ACAABFGgIAAGxkAgAARzAA=
Date:   Thu, 15 Sep 2022 17:49:16 +0000
Message-ID: <0646410b6d2a5d19d3315f339b2928dfa9f2d922.camel@hammerspace.com>
References: <20220908083326.3xsanzk7hy3ff4qs@quack3>
         <YxoIjV50xXKiLdL9@mit.edu>
         <02928a8c5718590bea5739b13d6b6ebe66cac577.camel@kernel.org>
         <20220908155605.GD8951@fieldses.org>
         <9e06c506fd6b3e3118da0ec24276e85ea3ee45a1.camel@kernel.org>
         <20220908182252.GA18939@fieldses.org>
         <44efe219dbf511492b21a653905448d43d0f3363.camel@kernel.org>
         <166284799157.30452.4308111193560234334@noble.neil.brown.name>
         <20220912134208.GB9304@fieldses.org>
         <166302447257.30452.6751169887085269140@noble.neil.brown.name>
         <20220915140644.GA15754@fieldses.org>
         <577b6d8a7243aeee37eaa4bbb00c90799586bc48.camel@hammerspace.com>
         <1a968b8e87f054e360877c9ab8cdfc4cfdfc8740.camel@kernel.org>
In-Reply-To: <1a968b8e87f054e360877c9ab8cdfc4cfdfc8740.camel@kernel.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|MW5PR13MB5993:EE_
x-ms-office365-filtering-correlation-id: 3310dab3-33d2-4c6b-5648-08da97429c31
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x8QfNx5MXvhMrC+dqK/zVY3WcrGVeF4dQe2hvu43bIsvSl4hUAkS1QLeQNQWpnqzKDlt5dJCNaelLPvccCLWbRYaTZIQztwi1ZoJWfWB8HgkUJxT+lURAZT36eNUXd8ypIq8fOKQbsbAkpLiB2d/m2tIwge7K6RdMvUaBb4hDV1t8/U8p+J2Mxvz+W0VaMdNUS+Ul4kCP4qwrL9IyREgASBLeKDc67ZcU8zNNXVa9Tv0Yiz7RwLUMjZtqRvLKirOoPpNQg/O8cU4WFc9BiZQBRSi1gmnmEHoy/A/dZ3RQLazQc5tXqkOGyeyNLXbOuUkLtK+8PJyUQPrQP8Sq8v5Qgx879Y6clRukrJ+00YSwjPCR73cw1dJdCBHFptRyIc1tMEnQl6OVNXzSEUokdXHZblAqQIQg9kWiKndJC8O8No44PdEN2+Kx2UQIKSGzQi3iwVbm6AOT20OM+iOoH2+lmbk9s3XL88tGErzmzAs5xgCq/erzIeQ8Y+Tnf8ckLVUyJMYI6Obtkj7g702dXv0dhgR2gmszZAXmEWAJSMNH3X7TfHMWrFWWcTELcGVKiojhLN1xxCKj075nQoIEgfkkC8RGXfxTcei0/uOoES0C31p4iHwthyIncTFjSV0TquUPWg326ctNlbtbBMBuvj2c6SVkbtNFU0fFX/BboQ9eYtZ/T5w91ohLZuHSiCGkJsrmmCJG6Y/k0vANza7PBXVG3gwahPVkWbrlPSH+i2Zf2lW4vk507wX6JIjNPWotaZDPmz83HQZNR5oiJEMGobEcw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(366004)(396003)(376002)(39840400004)(451199015)(110136005)(6486002)(5660300002)(6506007)(316002)(2906002)(41300700001)(66556008)(8676002)(64756008)(6512007)(2616005)(26005)(71200400001)(38100700002)(66476007)(8936002)(36756003)(38070700005)(66899012)(66446008)(186003)(76116006)(66946007)(478600001)(54906003)(83380400001)(91956017)(4326008)(7416002)(122000001)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?enZ4cU04QnowcjR2QWpMMXFCMjNNT21UdFRrc2pUdXE0WEdESnJDaFBvdDJQ?=
 =?utf-8?B?TlNXWVg2OGtHUGRXSkFac2VwMG90L0RGZ3BrSittWURacEY1alJ6MjUzWFlL?=
 =?utf-8?B?QnlOZU9MK29MQ0UyRDFpcGNKNklVVCtCOXNIL0xiUW1oa1UwR1VIWjQwM2tE?=
 =?utf-8?B?cnQ4YWQydTZKN1d4NlRpbHluVnhyU1p6ZXZ4QWVKdHh5UVpGVjhXVlFBLzZh?=
 =?utf-8?B?bFBWQjQxWU5qNEVlSnA0UnJhRmsralNyNU8zT0RyV1FQekI4YktRaklmVDNP?=
 =?utf-8?B?bEIrWDJtODd4c3lTazh3bjFVakhVT1RNQUM3REZNSUxpS3JiOHA0VUZ6RkhM?=
 =?utf-8?B?YmkybWlMTGdnWEZzcUdsYVE5RW8vdGpqNzhSbWJjNC9admVJSjR6SUI5QnNW?=
 =?utf-8?B?UGRHUHgwQXZOQWpsQStlY0xVSkgzZUNOTmNydm5SdUNQbWFUZXZWdnB0bUpx?=
 =?utf-8?B?akxHdzgralRLdCtVdEtVK21FZklqRngweWlpb2M3UCtuVDlxcjIzWEY4L1RY?=
 =?utf-8?B?MWVVcWZzcUlZa1FiUjgzdjB0Nkh5elBVNjV1b2VpU2RZZ2RncTBPV2pLY0o2?=
 =?utf-8?B?SGZaUm5nSFc0d2FvQ0VmVUxvT0t5SWUrOGJuTHVEOGtjR3V3SENxU3BTeGgv?=
 =?utf-8?B?MU9xb05vRDMyN2t4N1VIRVVxQkphc0ozaEdIN1dmcG5DU1crSC9BMndleXRN?=
 =?utf-8?B?NTVOUGJuMG9tQU5jN0hrT1VNNVdCNU51MDY5cUhDWkRDaDVwNnl5SFlZZTBK?=
 =?utf-8?B?T0Noa1h0bDNXME9yQXcxd0ZERXR2T3BrekFsWG81Tk9LVFU5OFBFeGtrS1Bu?=
 =?utf-8?B?eVViUWpCQkI5L2lKeW91SjBrQ2tBdWkzRzRENFI2RDEvM3lBd3h3bzJkOXVZ?=
 =?utf-8?B?RkEzdHV4SmtuYTJHMWFHaW5zSnViTWRwNmhVekxaSzA4TFlkNitnWVM1RGhs?=
 =?utf-8?B?N09zOUdZT2RlU2JZeDlOMmxMWllNWmlPTXAzWHgxb0NrMWdGTFNPQ25TOHRI?=
 =?utf-8?B?WUZPcXpvTnREYTBCdmhMSGpXeUxNbnBMeXU4T284MEt3OXBQREZudm85TWlq?=
 =?utf-8?B?RzNmWE4vVmJOYkx4blRIZkxXdFp5TG5maVhFNXZHMFc1NFo1Z25WVEFaUysy?=
 =?utf-8?B?WEhkcXB2TVlMNyt0NmltRGxRQ1dLd29zTWpLOTlMNStzMFhmVjIzUEVzUlFI?=
 =?utf-8?B?WVUwTDdmNk9ab1Q4bmJKeVpMelNKSkJGdjBFdXBmcVN2VlB0T0UvZzRsSzNW?=
 =?utf-8?B?Tkd1Uk5Mb0hrYjJxd3o2cXc1TEhLY0t5N3NaRGxUQ2oyQ2cyalcwNmQwODNu?=
 =?utf-8?B?S1BXSGxUWDU5WFUrV2JkaHJXMEdXUFd5UDh0VnlkcDZZd0xaOEFJdm15MlFN?=
 =?utf-8?B?OTFhYmIzUHFhWCtIaDFFSklVZWR6LzFrZDlyTVBtTWc1UWJseGpLRVc1eVo0?=
 =?utf-8?B?Y3FBK3ZUdm9WVy9HdXhtdXpuUlJrM0RzdSs2V2pFUEs2YjFsajdXUFBrUE92?=
 =?utf-8?B?ZEsxOU0wOVJubTlMdUt3NlVCQlFIMjlmeXFmeU9paG1vT0xGMjA4emMyQ1lq?=
 =?utf-8?B?SWJoMDhhenVnbExKU1FDVThsSDgwNFVRcjlkQmJhN3hqS1cyZGRmWnZIZWo0?=
 =?utf-8?B?dnlYREhOL3RpQXlDVnNzM1lBYjA0eU5WdzRJeVlFMlk2Z0U4d2dUZWNHdnVN?=
 =?utf-8?B?ak81YXFLNUFBdlFvVTN2cmVYZ09VL2xCSW9hTGV0ekJBMEY4anVnVzZVMzIw?=
 =?utf-8?B?TU9RemlqNTBlZkFVcGhPaVkyaFBGSVFEdmVVQXlqaXM0M0xWTDdHUnZXQW8r?=
 =?utf-8?B?cnQrVUM3NkdDcExwbWpuZ2R5UXNHZVcxVVJ1ZzdtZEZLSUZjbk5CUURQNnF6?=
 =?utf-8?B?MkIvWDJ4bzRmS1MwVVh3cDV6bG9Qdmx1U2ZDWldoajVRTkt0d2Z1UE4xWjVq?=
 =?utf-8?B?bWVydS80WW4rYnUvMXd5U0NPTGVUQ0s1TG5ORVlJS0lHT3hJRm0wemE4aTd1?=
 =?utf-8?B?Mjc4T1ppeW9VVFdjYTVwWHgwN0dDSmp6ajE2ZFl0YUNQN0xBMU1Sdm1oNFd6?=
 =?utf-8?B?VVZFM0xyQlVSdERGRk1BcGpISWd1VEZtWmJzNGM0RHV0SEpNK2wvS2xqWjJ3?=
 =?utf-8?B?WmZBNStKaEw2THlJRnJYTDJ3Q3FYc0RqSzJiVlNlZVRzTytzNmNaSEZicXM5?=
 =?utf-8?B?U1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C2BFABD41ED24F4E8B28D0DC36127F2A@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR13MB5993
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gVGh1LCAyMDIyLTA5LTE1IGF0IDEyOjQ1IC0wNDAwLCBKZWZmIExheXRvbiB3cm90ZToNCj4g
T24gVGh1LCAyMDIyLTA5LTE1IGF0IDE1OjA4ICswMDAwLCBUcm9uZCBNeWtsZWJ1c3Qgd3JvdGU6
DQo+ID4gT24gVGh1LCAyMDIyLTA5LTE1IGF0IDEwOjA2IC0wNDAwLCBKLiBCcnVjZSBGaWVsZHMg
d3JvdGU6DQo+ID4gPiBPbiBUdWUsIFNlcCAxMywgMjAyMiBhdCAwOToxNDozMkFNICsxMDAwLCBO
ZWlsQnJvd24gd3JvdGU6DQo+ID4gPiA+IE9uIE1vbiwgMTIgU2VwIDIwMjIsIEouIEJydWNlIEZp
ZWxkcyB3cm90ZToNCj4gPiA+ID4gPiBPbiBTdW4sIFNlcCAxMSwgMjAyMiBhdCAwODoxMzoxMUFN
ICsxMDAwLCBOZWlsQnJvd24gd3JvdGU6DQo+ID4gPiA+ID4gPiBPbiBGcmksIDA5IFNlcCAyMDIy
LCBKZWZmIExheXRvbiB3cm90ZToNCj4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+IFRoZSBt
YWNoaW5lIGNyYXNoZXMgYW5kIGNvbWVzIGJhY2sgdXAsIGFuZCB3ZSBnZXQgYSBxdWVyeQ0KPiA+
ID4gPiA+ID4gPiBmb3INCj4gPiA+ID4gPiA+ID4gaV92ZXJzaW9uDQo+ID4gPiA+ID4gPiA+IGFu
ZCBpdCBjb21lcyBiYWNrIGFzIFguIEZpbmUsIGl0J3MgYW4gb2xkIHZlcnNpb24uIE5vdw0KPiA+
ID4gPiA+ID4gPiB0aGVyZQ0KPiA+ID4gPiA+ID4gPiBpcyBhIHdyaXRlLg0KPiA+ID4gPiA+ID4g
PiBXaGF0IGRvIHdlIGRvIHRvIGVuc3VyZSB0aGF0IHRoZSBuZXcgdmFsdWUgZG9lc24ndA0KPiA+
ID4gPiA+ID4gPiBjb2xsaWRlDQo+ID4gPiA+ID4gPiA+IHdpdGggWCsxPyANCj4gPiA+ID4gPiA+
IA0KPiA+ID4gPiA+ID4gKEkgbWlzc2VkIHRoaXMgYml0IGluIG15IGVhcmxpZXIgcmVwbHkuLikN
Cj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gSG93IGlzIGl0ICJGaW5lIiB0byBzZWUgYW4gb2xk
IHZlcnNpb24/DQo+ID4gPiA+ID4gPiBUaGUgZmlsZSBjb3VsZCBoYXZlIGNoYW5nZWQgd2l0aG91
dCB0aGUgdmVyc2lvbiBjaGFuZ2luZy4NCj4gPiA+ID4gPiA+IEFuZCBJIHRob3VnaHQgb25lIG9m
IHRoZSBnb2FscyBvZiB0aGUgY3Jhc2gtY291bnQgd2FzIHRvIGJlDQo+ID4gPiA+ID4gPiBhYmxl
IHRvDQo+ID4gPiA+ID4gPiBwcm92aWRlIGEgbW9ub3RvbmljIGNoYW5nZSBpZC4NCj4gPiA+ID4g
PiANCj4gPiA+ID4gPiBJIHdhcyBzdGlsbCBtYWlubHkgdGhpbmtpbmcgYWJvdXQgaG93IHRvIHBy
b3ZpZGUgcmVsaWFibGUNCj4gPiA+ID4gPiBjbG9zZS0NCj4gPiA+ID4gPiB0by1vcGVuDQo+ID4g
PiA+ID4gc2VtYW50aWNzIGJldHdlZW4gTkZTIGNsaWVudHMuwqAgSW4gdGhlIGNhc2UgdGhlIHdy
aXRlciB3YXMgYW4NCj4gPiA+ID4gPiBORlMNCj4gPiA+ID4gPiBjbGllbnQsIGl0IHdhc24ndCBk
b25lIHdyaXRpbmcgKG9yIGl0IHdvdWxkIGhhdmUgQ09NTUlUdGVkKSwNCj4gPiA+ID4gPiBzbw0K
PiA+ID4gPiA+IHRob3NlDQo+ID4gPiA+ID4gd3JpdGVzIHdpbGwgY29tZSBpbiBhbmQgYnVtcCB0
aGUgY2hhbmdlIGF0dHJpYnV0ZSBzb29uLCBhbmQNCj4gPiA+ID4gPiBhcw0KPiA+ID4gPiA+IGxv
bmcgYXMNCj4gPiA+ID4gPiB3ZSBhdm9pZCB0aGUgc21hbGwgY2hhbmNlIG9mIHJldXNpbmcgYW4g
b2xkIGNoYW5nZSBhdHRyaWJ1dGUsDQo+ID4gPiA+ID4gd2UncmUgT0ssDQo+ID4gPiA+ID4gYW5k
IEkgdGhpbmsgaXQnZCBldmVuIHN0aWxsIGJlIE9LIHRvIGFkdmVydGlzZQ0KPiA+ID4gPiA+IENI
QU5HRV9UWVBFX0lTX01PTk9UT05JQ19JTkNSLg0KPiA+ID4gPiANCj4gPiA+ID4gWW91IHNlZW0g
dG8gYmUgYXNzdW1pbmcgdGhhdCB0aGUgY2xpZW50IGRvZXNuJ3QgY3Jhc2ggYXQgdGhlDQo+ID4g
PiA+IHNhbWUNCj4gPiA+ID4gdGltZQ0KPiA+ID4gPiBhcyB0aGUgc2VydmVyIChtYXliZSB0aGV5
IGFyZSBib3RoIFZNcyBvbiBhIGhvc3QgdGhhdCBsb3N0DQo+ID4gPiA+IHBvd2VyLi4uKQ0KPiA+
ID4gPiANCj4gPiA+ID4gSWYgY2xpZW50IEEgcmVhZHMgYW5kIGNhY2hlcywgY2xpZW50IEIgd3Jp
dGVzLCB0aGUgc2VydmVyDQo+ID4gPiA+IGNyYXNoZXMNCj4gPiA+ID4gYWZ0ZXINCj4gPiA+ID4g
d3JpdGluZyBzb21lIGRhdGEgKHRvIGFscmVhZHkgYWxsb2NhdGVkIHNwYWNlIHNvIG5vIGlub2Rl
DQo+ID4gPiA+IHVwZGF0ZQ0KPiA+ID4gPiBuZWVkZWQpDQo+ID4gPiA+IGJ1dCBiZWZvcmUgd3Jp
dGluZyB0aGUgbmV3IGlfdmVyc2lvbiwgdGhlbiBjbGllbnQgQiBjcmFzaGVzLg0KPiA+ID4gPiBX
aGVuIHNlcnZlciBjb21lcyBiYWNrIHRoZSBpX3ZlcnNpb24gd2lsbCBiZSB1bmNoYW5nZWQgYnV0
IHRoZQ0KPiA+ID4gPiBkYXRhDQo+ID4gPiA+IGhhcw0KPiA+ID4gPiBjaGFuZ2VkLsKgIENsaWVu
dCBBIHdpbGwgY2FjaGUgb2xkIGRhdGEgaW5kZWZpbml0ZWx5Li4uDQo+ID4gPiANCj4gPiA+IEkg
Z3Vlc3MgSSBhc3N1bWUgdGhhdCBpZiBhbGwgd2UncmUgcHJvbWlzaW5nIGlzIGNsb3NlLXRvLW9w
ZW4sDQo+ID4gPiB0aGVuIGENCj4gPiA+IGNsaWVudCBpc24ndCBhbGxvd2VkIHRvIHRydXN0IGl0
cyBjYWNoZSBpbiB0aGF0IHNpdHVhdGlvbi7CoCBNYXliZQ0KPiA+ID4gdGhhdCdzDQo+ID4gPiBh
biBvdmVybHkgZHJhY29uaWFuIGludGVycHJldGF0aW9uIG9mIGNsb3NlLXRvLW9wZW4uDQo+ID4g
PiANCj4gPiA+IEFsc28sIEknbSB0cnlpbmcgdG8gdGhpbmsgYWJvdXQgaG93IHRvIGltcHJvdmUg
dGhpbmdzDQo+ID4gPiBpbmNyZW1lbnRhbGx5Lg0KPiA+ID4gSW5jb3Jwb3JhdGluZyBzb21ldGhp
bmcgbGlrZSBhIGNyYXNoIGNvdW50IGludG8gdGhlIG9uLWRpc2sNCj4gPiA+IGlfdmVyc2lvbg0K
PiA+ID4gZml4ZXMgc29tZSBjYXNlcyB3aXRob3V0IGludHJvZHVjaW5nIGFueSBuZXcgb25lcyBv
ciByZWdyZXNzaW5nDQo+ID4gPiBwZXJmb3JtYW5jZSBhZnRlciBhIGNyYXNoLg0KPiA+ID4gDQo+
ID4gPiBJZiB3ZSBzdWJzZXF1ZW50bHkgd2FudGVkIHRvIGNsb3NlIHRob3NlIHJlbWFpbmluZyBo
b2xlcywgSSB0aGluaw0KPiA+ID4gd2UnZA0KPiA+ID4gbmVlZCB0aGUgY2hhbmdlIGF0dHJpYnV0
ZSBpbmNyZW1lbnQgdG8gYmUgc2VlbiBhcyBhdG9taWMgd2l0aA0KPiA+ID4gcmVzcGVjdA0KPiA+
ID4gdG8NCj4gPiA+IGl0cyBhc3NvY2lhdGVkIGNoYW5nZSwgYm90aCB0byBjbGllbnRzIGFuZCAo
c2VwYXJhdGVseSkgb24gZGlzay7CoA0KPiA+ID4gKFRoYXQNCj4gPiA+IHdvdWxkIHN0aWxsIGFs
bG93IHRoZSBjaGFuZ2UgYXR0cmlidXRlIHRvIGdvIGJhY2t3YXJkcyBhZnRlciBhDQo+ID4gPiBj
cmFzaCwNCj4gPiA+IHRvDQo+ID4gPiB0aGUgdmFsdWUgaXQgaGVsZCBhcyBvZiB0aGUgb24tZGlz
ayBzdGF0ZSBvZiB0aGUgZmlsZS7CoCBJIHRoaW5rDQo+ID4gPiBjbGllbnRzDQo+ID4gPiBzaG91
bGQgYmUgYWJsZSB0byBkZWFsIHdpdGggdGhhdCBjYXNlLikNCj4gPiA+IA0KPiA+ID4gQnV0LCBJ
IGRvbid0IGtub3csIG1heWJlIGEgYmlnZ2VyIGhhbW1lciB3b3VsZCBiZSBPSzoNCj4gPiA+IA0K
PiA+IA0KPiA+IElmIHlvdSdyZSBub3QgZ29pbmcgdG8gbWVldCB0aGUgbWluaW11bSBiYXIgb2Yg
ZGF0YSBpbnRlZ3JpdHksIHRoZW4NCj4gPiB0aGlzIHdob2xlIGV4ZXJjaXNlIGlzIGp1c3QgYSBt
YXNzaXZlIHdhc3RlIG9mIGV2ZXJ5b25lJ3MgdGltZS4gVGhlDQo+ID4gYW5zd2VyIHRoZW4gZ29p
bmcgZm9yd2FyZCBpcyBqdXN0IHRvIHJlY29tbWVuZCBuZXZlciB1c2luZyBMaW51eCBhcw0KPiA+
IGFuDQo+ID4gTkZTIHNlcnZlci4gTWFrZXMgbXkgbGlmZSBtdWNoIGVhc2llciwgYmVjYXVzZSBJ
IG5vIGxvbmdlciBoYXZlIHRvDQo+ID4gZGVidWcgYW55IG9mIHRoZSBpc3N1ZXMuDQo+ID4gDQo+
ID4gDQo+IA0KPiBUbyBiZSBjbGVhciwgeW91IGJlbGlldmUgYW55IHNjaGVtZSB0aGF0IHdvdWxk
IGFsbG93IHRoZSBjbGllbnQgdG8NCj4gc2VlDQo+IGFuIG9sZCBjaGFuZ2UgYXR0ciBhZnRlciBh
IGNyYXNoIGlzIGluc3VmZmljaWVudD8NCj4gDQoNCkNvcnJlY3QuIElmIGEgTkZTdjQgY2xpZW50
IG9yIHVzZXJzcGFjZSBhcHBsaWNhdGlvbiBjYW5ub3QgdHJ1c3QgdGhhdA0KaXQgd2lsbCBhbHdh
eXMgc2VlIGEgY2hhbmdlIHRvIHRoZSBjaGFuZ2UgYXR0cmlidXRlIHZhbHVlIHdoZW4gdGhlIGZp
bGUNCmRhdGEgY2hhbmdlcywgdGhlbiB5b3Ugd2lsbCBldmVudHVhbGx5IHNlZSBkYXRhIGNvcnJ1
cHRpb24gZHVlIHRvIHRoZQ0KY2FjaGVkIGRhdGEgbm8gbG9uZ2VyIG1hdGNoaW5nIHRoZSBzdG9y
ZWQgZGF0YS4NCg0KQSBmYWxzZSBwb3NpdGl2ZSB1cGRhdGUgb2YgdGhlIGNoYW5nZSBhdHRyaWJ1
dGUgKGkuZS4gYSBjYXNlIHdoZXJlIHRoZQ0KY2hhbmdlIGF0dHJpYnV0ZSBjaGFuZ2VzIGRlc3Bp
dGUgdGhlIGRhdGEvbWV0YWRhdGEgc3RheWluZyB0aGUgc2FtZSkgaXMNCm5vdCBkZXNpcmFibGUg
YmVjYXVzZSBpdCBjYXVzZXMgcGVyZm9ybWFuY2UgaXNzdWVzLCBidXQgZmFsc2UgbmVnYXRpdmVz
DQphcmUgZmFyIHdvcnNlIGJlY2F1c2UgdGhleSBtZWFuIHlvdXIgZGF0YSBiYWNrdXAsIGNhY2hl
LCBldGMuLi4gYXJlIG5vdA0KY29uc2lzdGVudC4gQXBwbGljYXRpb25zIHRoYXQgaGF2ZSBzdHJv
bmcgY29uc2lzdGVuY3kgcmVxdWlyZW1lbnRzIHdpbGwNCmhhdmUgbm8gb3B0aW9uIGJ1dCB0byBy
ZXZhbGlkYXRlIGJ5IGFsd2F5cyByZWFkaW5nIHRoZSBlbnRpcmUgZmlsZSBkYXRhDQorIG1ldGFk
YXRhLg0KDQo+IFRoZSBvbmx5IHdheSBJIGNhbiBzZWUgdG8gZml4IHRoYXQgKGF0IGxlYXN0IHdp
dGggb25seSBhIGNyYXNoDQo+IGNvdW50ZXIpDQo+IHdvdWxkIGJlIHRvIGZhY3RvciBpdCBpbiBh
dCBwcmVzZW50YXRpb24gdGltZSBsaWtlIE5laWwgc3VnZ2VzdGVkLg0KPiBCYXNpY2FsbHkgd2Un
ZCBqdXN0IG1hc2sgb2ZmIHRoZSB0b3AgMTYgYml0cyBhbmQgcGxvcCB0aGUgY3Jhc2gNCj4gY291
bnRlcg0KPiBpbiB0aGVyZSBiZWZvcmUgcHJlc2VudGluZyBpdC4NCj4gDQo+IEluIHByaW5jaXBs
ZSwgSSBzdXBwb3NlIHdlIGNvdWxkIGRvIHRoYXQgYXQgdGhlIG5mc2QgbGV2ZWwgYXMgd2VsbA0K
PiAoYW5kDQo+IHRoYXQgbWlnaHQgYmUgdGhlIHNpbXBsZXN0IHdheSB0byBmaXggdGhpcykuIFdl
IHByb2JhYmx5IHdvdWxkbid0IGJlDQo+IGFibGUgdG8gYWR2ZXJ0aXNlIGEgY2hhbmdlIGF0dHIg
dHlwZSBvZiBNT05PVE9OSUMgd2l0aCB0aGlzIHNjaGVtZQ0KPiB0aG91Z2guDQoNCldoeSB3b3Vs
ZCB5b3Ugd2FudCB0byBsaW1pdCB0aGUgY3Jhc2ggY291bnRlciB0byAxNiBiaXRzPw0KDQotLSAN
ClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFj
ZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
