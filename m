Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 217235B2AB7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Sep 2022 01:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbiIHX73 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Sep 2022 19:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiIHX71 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Sep 2022 19:59:27 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2106.outbound.protection.outlook.com [40.107.244.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE8FF1CA;
        Thu,  8 Sep 2022 16:59:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JmE3arF0hFsAFJoFLQQpOYEJZDvg4+/vdhPb9PvlIqBH92DmscvFVF0Z/koVMnw6b7s2/3gSiwL2wmaCpoRsc10Pvtfd95Y9Pr7xvoh2u5PCX3MPixcfbREu+gsNRoqXnjkM1qpHFGQTjB5+qhPgPjA7waMqvbI3Y8ru4IDZpsRUY2vUP3OcOk4sseasD86HBV76P/P3SrzBYn7Gez/pTAm3oHsJ5cxInkp93+o5FhkayDG9Zx8l8RN6lwv0RGbdsNYw5Mww1f9MR/EFDlvjYy9vM522oEFWLRRLDZfQhveuy4vVUN8PuqYjrjcTdStGNFIAKBT/hGY2rEctJJWDSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SN9H2stYsIzAlHYYJozR/hSYyAKq4D5GCaX7l6nsXBs=;
 b=mcDywoWVEK1K3J2xJfri3rJTr5noAn94oAdtmlaC5ega4mCbfcRKiUEULUk2X5csCZBrqNY9TA/mI5Fm/Dc/1CymN7pvj3FQl3Rtz73qKC+ORtjLX0KR0JSfMzekOjn/x1Ut1hheNrKTvLi9orZR7mDnNNlQqsf6vuZ+olEZlSCrZbvNY0bLs4HOQv86wlMu7qZJbxOMB2gvzPT/VJSWoW9knpDFbjg8x40CQ2TGyBgIxP23tV6OwbJRfCHgmrDql/7px7mRvsggKcvm9qlTEfz229BwUw+Ndujr6xMtPeH6ZgNz0VJ7wQxfaQX27+YeuYxAuAfAuqfZbPNhB309Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SN9H2stYsIzAlHYYJozR/hSYyAKq4D5GCaX7l6nsXBs=;
 b=MlUHdL4Nxto9JpqIUip3Z84Ghn5D4t+2ddoWGCRRZPkgCNHrGBBxpckNrRqSqBWPxL98k1pt5AcZpl8bRcwrkTfvAUPxoNWUlA03EjhXKZBuCrAeQ8awFTHdv69AJfylsMYLpIVZwX2bV1z2IcoWKqfOjfFs4CWNkkFpKXsVUvs=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by SJ0PR13MB5368.namprd13.prod.outlook.com (2603:10b6:a03:3d2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Thu, 8 Sep
 2022 23:59:18 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::f1c7:62d0:a63d:f5ca]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::f1c7:62d0:a63d:f5ca%3]) with mapi id 15.20.5612.012; Thu, 8 Sep 2022
 23:59:18 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "jlayton@kernel.org" <jlayton@kernel.org>,
        "neilb@suse.de" <neilb@suse.de>
CC:     "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "xiubli@redhat.com" <xiubli@redhat.com>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "bfields@fieldses.org" <bfields@fieldses.org>,
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
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "lczerner@redhat.com" <lczerner@redhat.com>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Subject: Re: [man-pages RFC PATCH v4] statx, inode: document the new
 STATX_INO_VERSION field
Thread-Topic: [man-pages RFC PATCH v4] statx, inode: document the new
 STATX_INO_VERSION field
Thread-Index: AQHYwqs/evAHvn9kzUKFB4lWpvCB0q3T1xmAgAATgACAAAFbgIAABbEAgAAK/YCAALZNAIAAgw4AgAByGoCAAAZagIAAeIiAgAARsIA=
Date:   Thu, 8 Sep 2022 23:59:18 +0000
Message-ID: <91e31d20d66d6f47fe12c80c34b1cffdfc202b6a.camel@hammerspace.com>
References: <20220907111606.18831-1-jlayton@kernel.org> ,
 <166255065346.30452.6121947305075322036@noble.neil.brown.name> ,
 <79aaf122743a295ddab9525d9847ac767a3942aa.camel@kernel.org>    ,
 <20220907125211.GB17729@fieldses.org>  ,
 <771650a814ab1ff4dc5473d679936b747d9b6cf5.camel@kernel.org>    ,
 <20220907135153.qvgibskeuz427abw@quack3>       ,
 <166259786233.30452.5417306132987966849@noble.neil.brown.name> ,
 <20220908083326.3xsanzk7hy3ff4qs@quack3>, <YxoIjV50xXKiLdL9@mit.edu>   ,
 <02928a8c5718590bea5739b13d6b6ebe66cac577.camel@kernel.org>
         <166267775728.30452.17640919701924887771@noble.neil.brown.name>
In-Reply-To: <166267775728.30452.17640919701924887771@noble.neil.brown.name>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|SJ0PR13MB5368:EE_
x-ms-office365-filtering-correlation-id: f4854b8e-9e52-40a1-485d-08da91f6244b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M7JHdg58Mbvc3Jrr34ftkMTGL6DAvh9evFCsysd6gTyS1L49MLR8Vvng8Yjms9HicDKNZnJVTsy4svec1ZZ6PAXxow/KU/63vYMDnWgX7cEQXZIGx5dh8LCQK+r0twh1y+1mjGswyYtQP3gK7f9RAyFqwZ3Vmc5eeCBnIeMFyd5ZTTtnr2c8x1LMcBxgFDZ3DfA4hrlLzD8EfPIpiApIvmSWK70ob7eNTw8hMOBc7cGnBPrlh1KOGjEaj8IH0Xge7yD0gunoZWowGsQWMvauprcWi+vRHhzDC5SZRS+fsRTYP9db5M6SfHJtYZfq38cCfviq1ejtJaUocn2YVtNR4uVNxQBCicpQTNETFp86hI6cV/OaGsin29QuXW+b9pVEq23tWNdA+16FgGpr/jmImGncub8/ZEyBo0SqA17GHvee+p3Tixo0ytJSLH0XZMrzYH2tQhg242+HoU094pBJ542C9bBBAshzAFSzfcQWfrCiaR0YfSv8BDHaoSXFspvEo8hTQL8lvGhWrkaDLPUrLIbomaD+ose+lyfWUSUYfMwfTCO98zWw/GQkTYDuxElDvlifZ5Jw/DaIVBi6YAVh6CJ4RCQKRwr7tkD4P2ou7y3SU2LIynghsWfRf6zS59T06AWZmnfqLgBYhOHWNmF2ZW/lPdrLR4rnXdGJpYvgdZBMrnj8RwgRZRuDWrTPgIb8CZXx+K3uJM5oie1Td/9U4HAMTFI5qaaHLzk5hnyDuWw0bT0Yvdj5S0WTy1QP3j+JcdxvO79OWjgIHWkT3BVaFy0ektz0YvsqaYqcVzJL7cP2oCr4UYDTShDAyyMFqGGB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(396003)(136003)(346002)(39850400004)(366004)(5660300002)(38100700002)(8676002)(186003)(6506007)(8936002)(54906003)(36756003)(7416002)(110136005)(6486002)(41300700001)(71200400001)(478600001)(2616005)(4326008)(83380400001)(26005)(66476007)(64756008)(66946007)(6512007)(2906002)(316002)(66446008)(38070700005)(86362001)(122000001)(66556008)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MmcxT3FJSzRTVmZkckQ4VXY1cUd2U3Jpd3l3dG1KUU5qYmEzWVQ4YmlDZ2l5?=
 =?utf-8?B?c1EwRUtPbzhTRGpTU0pwdXp4SWdYb0RKeGU4dW5kNXZXZy9PZFl0VDBtRzVq?=
 =?utf-8?B?bE9TZzF0Qm9DMzhaK2s0ZGFybFlrNzdEMWQ2SXdZUXBqNGhlSkc5cUJwWEZo?=
 =?utf-8?B?UzJpMnVKZXNPTFFGM3AxZFpWN3BNV3loU2haU2tVZFdvSTRlNjNhRGlVL09t?=
 =?utf-8?B?UWFBUENjK0ZjZEhwSTB4Qzl0cVF0S1hyVzVMTm92Wk5Ta0J2OUtjWG1hWE1N?=
 =?utf-8?B?Nm1jN0VkUzhBbnRWZ3ArTWdvOU5LdXgwVTdrM2gxSDFjYUgzR1MrR0lOYjlw?=
 =?utf-8?B?a05yRHNNVk1mTEticWxGdzNodVZTdXFiT2EwOUlaT0dYOXhDR3hyUHJwM2t1?=
 =?utf-8?B?c2ZSaGlLRnRrYTdndE9nTkIzbEpqYVdlM01DcTZvMGJydDhTSU5BYnFqbFgz?=
 =?utf-8?B?UGRMREFrdDJaTjhFYVZwdUQ2MFBPdzI5MllYS1ZzazMrb0pXRUpZN0JSa2Vz?=
 =?utf-8?B?bWJOanBFYzFyalN1TVBTZ21CQ2xtZll1dGNDc1VPdUZkOTlKd1hrb0I5R1lj?=
 =?utf-8?B?d0hzbFJXWHBjU0xSaVI4aSt1TGdTZ2FqWnlxNTNDTk5kbUVtclQ2ckQ0SEgy?=
 =?utf-8?B?cENlR05FaEVCUXlMVFp0TU9qbWJpeXB2ekgxSnpFNzFqZ09OaHNUYjcvaXVn?=
 =?utf-8?B?VkI1WWliajdTWVA2SWZKcnFRdGlJdUMzbWpjL2N1RGlncW0xR2pGZEQ2R3By?=
 =?utf-8?B?cjZhNzhDS3VIcVFsWjZxbTloOHMwNEE2ZHJObWJzR0tUckJ4M0h2Z29XSTdy?=
 =?utf-8?B?RmlUMWJSQm9FWmx6bHFVdTJDODBOS1MxVTJNNHRMOVVBMy8zbGluM1g3QmFN?=
 =?utf-8?B?MzB3MGFJOHEzcE5KbDkxanA2ZWk1bDc3eWVaNnpOZ2tDYnhNYUNlTGxubWYy?=
 =?utf-8?B?ekFiNlV1T3A2a28zSWlmUkVHQ3NLR2ZYVllUNmxzSVV6NndSc0VSTzBlWlZq?=
 =?utf-8?B?b0RoMG9hWW1QSzNIS0hNT0RVUGtpQ2x3MXpscmREMHVDckRBUzFQY2MzSVhO?=
 =?utf-8?B?cWR4R1hicEt4TXRxRDFubjlxUlNIbWFiVGZOMVVLd2FHSStKVHJVTVNON1pL?=
 =?utf-8?B?TlZ6TnNUalFiMjZSRTNZMWRSc2t6SXNObkZpaEN2NFl4aGhiSzdPN0YvdStI?=
 =?utf-8?B?ZWE4ekQzYkVRMS9TMFZMRGZEQ1daVzNIZ29WdElIOS9zT014SmpSV1dTODdR?=
 =?utf-8?B?L3oxaVM3L3c4b1l3RFdSWVpzUXFwbU9vbFhxdnhwSWp1aFUzdXU3TWdsSEph?=
 =?utf-8?B?ejBRU3l6eEM4ZWFqNllKN3ZjSUFaNHB5b0NkUWdYRHJwN1NaNzB1Umw4cU9v?=
 =?utf-8?B?UlRPQnlBMWdDUk5qMm9oaWpiYXpsZlFmam9BZ0ZKc0tremtsNHhiYUJrdm1x?=
 =?utf-8?B?S2Z2S3pURnpMYUFHbmU4cDMxSFZDVnoyOU1NVFNEVnJDc3Z0aGNwL0ZDbC9R?=
 =?utf-8?B?TWd4VGhDd3daK2ZFcS9TQzNtM1hSZmZWU082OVdsMU1tOG9idm90WUNaRGQ2?=
 =?utf-8?B?SFJWL2RtQlk1ZzljNkdmVWdnUzJLeDkzTTFkWEh6QjZBN1lodkV3ODd6RzRv?=
 =?utf-8?B?RzQrWHdwMm0zYzlGVFBwRkUyYkRFQW9MZlVUM3R3QzZZZ1RhcFRqaEhSekFU?=
 =?utf-8?B?ZXlYNy85MTNwOC9yKytydGFLSTFDM29JeUlLeWtSbmlEajg3MnVmOWNyVGpQ?=
 =?utf-8?B?T0E5Z0h2bEsrMWtjalFYTndMdkNpUFdhN2QwOThqQS81cjRCdHdHNDE3Z3J3?=
 =?utf-8?B?OTkxeDVXZVpDNWNpVFZIUGpCUEpYWUtKNCsycjNSa3NHVzljQzF1dFprbjhk?=
 =?utf-8?B?cDl4eDM1QnZJcjY0SjVQMVNZM3dCa2pzejJWc051aDFVczUyTUhzTGlkU2Nw?=
 =?utf-8?B?LzcrUFVnRkl2UDJWbk11U3VPMFRLbUxzZEVtZ2p0ZHhydVBNR3MxcnF2Qkcv?=
 =?utf-8?B?a2FBSEdnaE1qaEdlL3JHK2MzZFdxT2IrdnpPZGY5VnFTSFkwcit0czJDdXRm?=
 =?utf-8?B?eFM4RzhPb2QrcHJOS3RwQlRqRkxoMTB0d09pbWNXWFl0TFZ0UmhwZDVVelYy?=
 =?utf-8?B?ZGloSENoNUVoaHd3R2tTRytzcFQxMmVNTEc1a016R09xUmJOMG5OdnJlV3Q3?=
 =?utf-8?B?SHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E77D25241F370C428ADA6A1B37351C63@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR13MB5368
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gRnJpLCAyMDIyLTA5LTA5IGF0IDA4OjU1ICsxMDAwLCBOZWlsQnJvd24gd3JvdGU6DQo+IE9u
IEZyaSwgMDkgU2VwIDIwMjIsIEplZmYgTGF5dG9uIHdyb3RlOg0KPiA+IE9uIFRodSwgMjAyMi0w
OS0wOCBhdCAxMToyMSAtMDQwMCwgVGhlb2RvcmUgVHMnbyB3cm90ZToNCj4gPiA+IE9uIFRodSwg
U2VwIDA4LCAyMDIyIGF0IDEwOjMzOjI2QU0gKzAyMDAsIEphbiBLYXJhIHdyb3RlOg0KPiA+ID4g
PiBJdCBib2lscyBkb3duIHRvIHRoZSBmYWN0IHRoYXQgd2UgZG9uJ3Qgd2FudCB0byBjYWxsDQo+
ID4gPiA+IG1hcmtfaW5vZGVfZGlydHkoKQ0KPiA+ID4gPiBmcm9tIElPQ0JfTk9XQUlUIHBhdGgg
YmVjYXVzZSBmb3IgbG90cyBvZiBmaWxlc3lzdGVtcyB0aGF0DQo+ID4gPiA+IG1lYW5zIGpvdXJu
YWwNCj4gPiA+ID4gb3BlcmF0aW9uIGFuZCB0aGVyZSBhcmUgaGlnaCBjaGFuY2VzIHRoYXQgbWF5
IGJsb2NrLg0KPiA+ID4gPiANCj4gPiA+ID4gUHJlc3VtYWJseSB3ZSBjb3VsZCB0cmVhdCBpbm9k
ZSBkaXJ0eWluZyBhZnRlciBpX3ZlcnNpb24gY2hhbmdlDQo+ID4gPiA+IHNpbWlsYXJseQ0KPiA+
ID4gPiB0byBob3cgd2UgaGFuZGxlIHRpbWVzdGFtcCB1cGRhdGVzIHdpdGggbGF6eXRpbWUgbW91
bnQgb3B0aW9uDQo+ID4gPiA+IChpLmUuLCBub3QNCj4gPiA+ID4gZGlydHkgdGhlIGlub2RlIGlt
bWVkaWF0ZWx5IGJ1dCBvbmx5IHdpdGggYSBkZWxheSkgYnV0IHRoZW4gdGhlDQo+ID4gPiA+IHRp
bWUgd2luZG93DQo+ID4gPiA+IGZvciBpX3ZlcnNpb24gaW5jb25zaXN0ZW5jaWVzIGR1ZSB0byBh
IGNyYXNoIHdvdWxkIGJlIG11Y2gNCj4gPiA+ID4gbGFyZ2VyLg0KPiA+ID4gDQo+ID4gPiBQZXJo
YXBzIHRoaXMgaXMgYSByYWRpY2FsIHN1Z2dlc3Rpb24sIGJ1dCB0aGVyZSBzZWVtcyB0byBiZSBh
IGxvdA0KPiA+ID4gb2YNCj4gPiA+IHRoZSBwcm9ibGVtcyB3aGljaCBhcmUgZHVlIHRvIHRoZSBj
b25jZXJuICJ3aGF0IGlmIHRoZSBmaWxlDQo+ID4gPiBzeXN0ZW0NCj4gPiA+IGNyYXNoZXMiIChh
bmQgc28gd2UgbmVlZCB0byB3b3JyeSBhYm91dCBtYWtpbmcgc3VyZSB0aGF0IGFueQ0KPiA+ID4g
aW5jcmVtZW50cyB0byBpX3ZlcnNpb24gTVVTVCBiZSBwZXJzaXN0ZWQgYWZ0ZXIgaXQgaXMNCj4g
PiA+IGluY3JlbWVudGVkKS4NCj4gPiA+IA0KPiA+ID4gV2VsbCwgaWYgd2UgYXNzdW1lIHRoYXQg
dW5jbGVhbiBzaHV0ZG93bnMgYXJlIHJhcmUsIHRoZW4gcGVyaGFwcw0KPiA+ID4gd2UNCj4gPiA+
IHNob3VsZG4ndCBiZSBvcHRpbWl6aW5nIGZvciB0aGF0IGNhc2UuwqAgU28uLi4uIHdoYXQgaWYg
YSBmaWxlDQo+ID4gPiBzeXN0ZW0NCj4gPiA+IGhhZCBhIGNvdW50ZXIgd2hpY2ggZ290IGluY3Jl
bWVudGVkIGVhY2ggdGltZSBpdHMgam91cm5hbCBpcw0KPiA+ID4gcmVwbGF5ZWQNCj4gPiA+IHJl
cHJlc2VudGluZyBhbiB1bmNsZWFuIHNodXRkb3duLsKgIFRoYXQgc2hvdWxkbid0IGhhcHBlbiBv
ZnRlbiwNCj4gPiA+IGJ1dCBpZg0KPiA+ID4gaXQgZG9lcywgdGhlcmUgbWlnaHQgYmUgYW55IG51
bWJlciBvZiBpX3ZlcnNpb24gdXBkYXRlcyB0aGF0IG1heQ0KPiA+ID4gaGF2ZQ0KPiA+ID4gZ290
dGVuIGxvc3QuwqAgU28gaW4gdGhhdCBjYXNlLCB0aGUgTkZTIGNsaWVudCBzaG91bGQgaW52YWxp
ZGF0ZQ0KPiA+ID4gYWxsIG9mDQo+ID4gPiBpdHMgY2FjaGVzLg0KPiA+ID4gDQo+ID4gPiBJZiB0
aGUgaV92ZXJzaW9uIGZpZWxkIHdhcyBsYXJnZSBlbm91Z2gsIHdlIGNvdWxkIGp1c3QgcHJlZml4
IHRoZQ0KPiA+ID4gInVuY2xlYW4gc2h1dGRvd24gY291bnRlciIgd2l0aCB0aGUgZXhpc3Rpbmcg
aV92ZXJzaW9uIG51bWJlcg0KPiA+ID4gd2hlbiBpdA0KPiA+ID4gaXMgc2VudCBvdmVyIHRoZSBO
RlMgcHJvdG9jb2wgdG8gdGhlIGNsaWVudC7CoCBCdXQgaWYgdGhhdCBmaWVsZA0KPiA+ID4gaXMg
dG9vDQo+ID4gPiBzbWFsbCwgYW5kIGlmIChhcyBJIHVuZGVyc3RhbmQgdGhpbmdzKSBORlMganVz
dCBuZWVkcyB0byBrbm93DQo+ID4gPiB3aGVuDQo+ID4gPiBpX3ZlcnNpb24gaXMgZGlmZmVyZW50
LCB3ZSBjb3VsZCBqdXN0IHNpbXBseSBoYXNoIHRoZSAidW5jbGVhbg0KPiA+ID4gc2h0dWRvd24g
Y291bnRlciIgd2l0aCB0aGUgaW5vZGUncyAiaV92ZXJzaW9uIGNvdW50ZXIiLCBhbmQgbGV0DQo+
ID4gPiB0aGF0DQo+ID4gPiBiZSB0aGUgdmVyc2lvbiB3aGljaCBpcyBzZW50IGZyb20gdGhlIE5G
UyBjbGllbnQgdG8gdGhlIHNlcnZlci4NCj4gPiA+IA0KPiA+ID4gSWYgd2UgY291bGQgZG8gdGhh
dCwgdGhlbiBpdCBkb2Vzbid0IGJlY29tZSBjcml0aWNhbCB0aGF0IGV2ZXJ5DQo+ID4gPiBzaW5n
bGUNCj4gPiA+IGlfdmVyc2lvbiBidW1wIGhhcyB0byBiZSBwZXJzaXN0ZWQgdG8gZGlzaywgYW5k
IHdlIGNvdWxkIHRyZWF0IGl0DQo+ID4gPiBsaWtlDQo+ID4gPiBhIGxhenl0aW1lIHVwZGF0ZTsg
aXQncyBndWFyYW50ZWVkIHRvIHVwZGF0ZWQgd2hlbiB3ZSBkbyBhbiBjbGVhbg0KPiA+ID4gdW5t
b3VudCBvZiB0aGUgZmlsZSBzeXN0ZW0gKGFuZCB3aGVuIHRoZSBmaWxlIHN5c3RlbSBpcyBmcm96
ZW4pLA0KPiA+ID4gYnV0DQo+ID4gPiBvbiBhIGNyYXNoLCB0aGVyZSBpcyBubyBndWFyYW50ZWVl
IHRoYXQgYWxsIGlfdmVyc2lvbiBidW1wcyB3aWxsDQo+ID4gPiBiZQ0KPiA+ID4gcGVyc2lzdGVk
LCBidXQgd2UgZG8gaGF2ZSB0aGlzICJ1bmNsZWFuIHNodXRkb3duIiBjb3VudGVyIHRvIGRlYWwN
Cj4gPiA+IHdpdGgNCj4gPiA+IHRoYXQgY2FzZS4NCj4gPiA+IA0KPiA+ID4gV291bGQgdGhpcyBt
YWtlIGxpZmUgZWFzaWVyIGZvciBmb2xrcz8NCj4gPiA+IA0KPiA+ID4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLSBUZWQNCj4gPiANCj4gPiBUaGFua3MgZm9yIGNoaW1p
bmcgaW4sIFRlZC4gVGhhdCdzIHBhcnQgb2YgdGhlIHByb2JsZW0sIGJ1dCB3ZSdyZQ0KPiA+IGFj
dHVhbGx5IG5vdCB0b28gd29ycmllZCBhYm91dCB0aGF0IGNhc2U6DQo+ID4gDQo+ID4gbmZzZCBt
aXhlcyB0aGUgY3RpbWUgaW4gd2l0aCBpX3ZlcnNpb24sIHNvIHlvdSdkIGhhdmUgdG8NCj4gPiBj
cmFzaCtjbG9jaw0KPiA+IGp1bXAgYmFja3dhcmQgYnkganV1dXVzdCBlbm91Z2ggdG8gYWxsb3cg
eW91IHRvIGdldCB0aGUgaV92ZXJzaW9uDQo+ID4gYW5kDQo+ID4gY3RpbWUgaW50byBhIHN0YXRl
IGl0IHdhcyBiZWZvcmUgdGhlIGNyYXNoLCBidXQgd2l0aCBkaWZmZXJlbnQNCj4gPiBkYXRhLg0K
PiA+IFdlJ3JlIGFzc3VtaW5nIHRoYXQgdGhhdCBpcyBkaWZmaWN1bHQgdG8gYWNoaWV2ZSBpbiBw
cmFjdGljZS4NCj4gPiANCj4gPiBUaGUgaXNzdWUgd2l0aCBhIHJlYm9vdCBjb3VudGVyIChvciBz
aW1pbGFyKSBpcyB0aGF0IG9uIGFuIHVuY2xlYW4NCj4gPiBjcmFzaA0KPiA+IHRoZSBORlMgY2xp
ZW50IHdvdWxkIGVuZCB1cCBpbnZhbGlkYXRpbmcgZXZlcnkgaW5vZGUgaW4gdGhlIGNhY2hlLA0K
PiA+IGFzDQo+ID4gYWxsIG9mIHRoZSBpX3ZlcnNpb25zIHdvdWxkIGNoYW5nZS4gVGhhdCdzIHBy
b2JhYmx5IGV4Y2Vzc2l2ZS4NCj4gPiANCj4gPiBUaGUgYmlnZ2VyIGlzc3VlIChhdCB0aGUgbW9t
ZW50KSBpcyBhdG9taWNpdHk6IHdoZW4gd2UgZmV0Y2ggYW4NCj4gPiBpX3ZlcnNpb24sIHRoZSBu
YXR1cmFsIGluY2xpbmF0aW9uIGlzIHRvIGFzc29jaWF0ZSB0aGF0IHdpdGggdGhlDQo+ID4gc3Rh
dGUNCj4gPiBvZiB0aGUgaW5vZGUgYXQgc29tZSBwb2ludCBpbiB0aW1lLCBzbyB3ZSBuZWVkIHRo
aXMgdG8gYmUgdXBkYXRlZA0KPiA+IGF0b21pY2FsbHkgd2l0aCBjZXJ0YWluIG90aGVyIGF0dHJp
YnV0ZXMgb2YgdGhlIGlub2RlLiBUaGF0J3MgdGhlDQo+ID4gcGFydA0KPiA+IEknbSB0cnlpbmcg
dG8gc29ydCB0aHJvdWdoIGF0IHRoZSBtb21lbnQuDQo+IA0KPiBJIGRvbid0IHRoaW5rIGF0b21p
Y2l0eSBtYXR0ZXJzIG5lYXJseSBhcyBtdWNoIGFzIG9yZGVyaW5nLg0KPg0KPiBUaGUgaV92ZXJz
aW9uIG11c3Qgbm90IGJlIHZpc2libGUgYmVmb3JlIHRoZSBjaGFuZ2UgdGhhdCBpdCByZWZsZWN0
cy4NCj4gSXQgaXMgT0sgZm9yIGl0IHRvIGJlIGFmdGVyLsKgIEV2ZW4gc2Vjb25kcyBhZnRlciB3
aXRob3V0IGdyZWF0IGNvc3QuwqANCj4gSXQNCj4gaXMgYmFkIGZvciBpdCB0byBiZSBlYXJsaWVy
LsKgIEFueSB1bmxvY2tlZCBnYXAgYWZ0ZXIgdGhlIGlfdmVyc2lvbg0KPiB1cGRhdGUgYW5kIGJl
Zm9yZSB0aGUgY2hhbmdlIGlzIHZpc2libGUgY2FuIHJlc3VsdCBpbiBhIHJhY2UgYW5kDQo+IGlu
Y29ycmVjdCBjYWNoaW5nLg0KPiANCj4gRXZlbiBmb3IgZGlyZWN0b3J5IHVwZGF0ZXMgd2hlcmUg
TkZTdjQgd2FudHMgYXRvbWljIGJlZm9yZS9hZnRlcg0KPiB2ZXJzaW9uDQo+IG51bWJlcnMsIHRo
ZXkgZG9uJ3QgbmVlZCB0byBiZSBhdG9taWMgdy5yLnQuIHRoZSBjaGFuZ2UgYmVpbmcNCj4gdmlz
aWJsZS4NCj4gDQo+IElmIHRocmVlIGNvbmN1cnJlbnQgZmlsZSBjcmVhdGVzIGNhdXNlIHRoZSB2
ZXJzaW9uIG51bWJlciB0byBnbyBmcm9tDQo+IDQNCj4gdG8gNywgdGhlbiBpdCBpcyBpbXBvcnRh
bnQgdGhhdCBvbmUgb3Agc2VlcyAiNCw1Iiwgb25lIHNlZXMgIjUsNiIgYW5kDQo+IG9uZSBzZWVz
ICI2LDciLCBidXQgaXQgZG9lc24ndCBtYXR0ZXIgaWYgY29uY3VycmVudCBsb29rdXBzIG9ubHkg
c2VlDQo+IHZlcnNpb24gNCBldmVuIHdoaWxlIHRoZXkgY2FuIHNlZSB0aGUgbmV3bHkgY3JlYXRl
ZCBuYW1lcy4NCj4gDQo+IEEgbG9uZ2VyIGdhcCBpbmNyZWFzZXMgdGhlIHJpc2sgb2YgYW4gdW5u
ZWNlc3NhcnkgY2FjaGUgZmx1c2gsIGJ1dCBpdA0KPiBkb2Vzbid0IGxlYWQgdG8gaW5jb3JyZWN0
bmVzcy4NCj4gDQoNCkknbSBub3QgcmVhbGx5IHN1cmUgd2hhdCB5b3UgbWVhbiB3aGVuIHlvdSBz
YXkgdGhhdCBhICdsb25nZXIgZ2FwDQppbmNyZWFzZXMgdGhlIHJpc2sgb2YgYW4gdW5uZWNlc3Nh
cnkgY2FjaGUgZmx1c2gnLiBFaXRoZXIgdGhlIGNoYW5nZQ0KYXR0cmlidXRlIHVwZGF0ZSBpcyBh
dG9taWMgd2l0aCB0aGUgb3BlcmF0aW9uIGl0IGlzIHJlY29yZGluZywgb3IgaXQgaXMNCm5vdC4g
SWYgdGhhdCB1cGRhdGUgaXMgcmVjb3JkZWQgaW4gdGhlIE5GUyByZXBseSBhcyBub3QgYmVpbmcg
YXRvbWljLA0KdGhlbiB0aGUgY2xpZW50IHdpbGwgZXZpY3QgYWxsIGNhY2hlZCBkYXRhIHRoYXQg
aXMgYXNzb2NpYXRlZCB3aXRoIHRoYXQNCmNoYW5nZSBhdHRyaWJ1dGUgYXQgc29tZSBwb2ludC4N
Cg0KPiBTbyBJIHRoaW5rIHdlIHNob3VsZCBwdXQgdGhlIHZlcnNpb24gdXBkYXRlICphZnRlciog
dGhlIGNoYW5nZSBpcw0KPiB2aXNpYmxlLCBhbmQgbm90IHJlcXVpcmUgbG9ja2luZyAoYmV5b25k
IGEgbWVtb3J5IGJhcnJpZXIpIHdoZW4NCj4gcmVhZGluZw0KPiB0aGUgdmVyc2lvbi4gSXQgc2hv
dWxkIGJlIGFzIHNvb24gYWZ0ZXIgYXMgcHJhY3RpY2FsLCBiaXQgbm8gc29vbmVyLg0KPiANCg0K
T3JkZXJpbmcgaXMgbm90IGEgc3VmZmljaWVudCBjb25kaXRpb24uIFRoZSBndWFyYW50ZWUgbmVl
ZHMgdG8gYmUgdGhhdA0KYW55IGFwcGxpY2F0aW9uIHRoYXQgcmVhZHMgdGhlIGNoYW5nZSBhdHRy
aWJ1dGUsIHRoZW4gcmVhZHMgZmlsZSBkYXRhDQphbmQgdGhlbiByZWFkcyB0aGUgY2hhbmdlIGF0
dHJpYnV0ZSBhZ2FpbiB3aWxsIHNlZSB0aGUgMiBjaGFuZ2UNCmF0dHJpYnV0ZSB2YWx1ZXMgYXMg
YmVpbmcgdGhlIHNhbWUgKmlmIGFuZCBvbmx5IGlmKiB0aGVyZSB3ZXJlIG5vDQpjaGFuZ2VzIHRv
IHRoZSBmaWxlIGRhdGEgbWFkZSBhZnRlciB0aGUgcmVhZCBhbmQgYmVmb3JlIHRoZSByZWFkIG9m
IHRoZQ0KY2hhbmdlIGF0dHJpYnV0ZS4NClRoYXQgaW5jbHVkZXMgdGhlIGNhc2Ugd2hlcmUgZGF0
YSB3YXMgd3JpdHRlbiBhZnRlciB0aGUgcmVhZCwgYW5kIGENCmNyYXNoIG9jY3VycmVkIGFmdGVy
IGl0IHdhcyBjb21taXR0ZWQgdG8gc3RhYmxlIHN0b3JhZ2UuIElmIHlvdSBvbmx5DQp1cGRhdGUg
dGhlIHZlcnNpb24gYWZ0ZXIgdGhlIHdyaXR0ZW4gZGF0YSBpcyB2aXNpYmxlLCB0aGVuIHRoZXJl
IGlzIGENCnBvc3NpYmlsaXR5IHRoYXQgdGhlIGNyYXNoIGNvdWxkIG9jY3VyIGJlZm9yZSBhbnkg
Y2hhbmdlIGF0dHJpYnV0ZQ0KdXBkYXRlIGlzIGNvbW1pdHRlZCB0byBkaXNrLg0KDQpJT1c6IHRo
ZSBtaW5pbWFsIGNvbmRpdGlvbiBuZWVkcyB0byBiZSB0aGF0IGZvciBhbGwgY2FzZXMgYmVsb3cs
IHRoZQ0KYXBwbGljYXRpb24gcmVhZHMgJ3N0YXRlIEInIGFzIGhhdmluZyBvY2N1cnJlZCBpZiBh
bnkgZGF0YSB3YXMNCmNvbW1pdHRlZCB0byBkaXNrIGJlZm9yZSB0aGUgY3Jhc2guDQoNCkFwcGxp
Y2F0aW9uCQkJCUZpbGVzeXN0ZW0NCj09PT09PT09PT09CQkJCT09PT09PT09PT0NCnJlYWQgY2hh
bmdlIGF0dHIgPC0gJ3N0YXRlIEEnDQpyZWFkIGRhdGEgPC0gJ3N0YXRlIEEnDQoJCQkJCXdyaXRl
IGRhdGEgLT4gJ3N0YXRlIEInDQoJCQkJCTxjcmFzaD4rPHJlYm9vdD4NCnJlYWQgY2hhbmdlIGF0
dHIgPC0gJ3N0YXRlIEInDQoNCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGll
bnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5j
b20NCg0KDQo=
