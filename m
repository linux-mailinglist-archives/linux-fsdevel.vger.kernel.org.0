Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCCEF5A6792
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Aug 2022 17:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbiH3PnV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Aug 2022 11:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiH3PnS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Aug 2022 11:43:18 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2127.outbound.protection.outlook.com [40.107.101.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E7DDB6D57;
        Tue, 30 Aug 2022 08:43:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KMrAoE8xZILfaKWFFpAT0sik2pTYKXg4yGCAHc6SD0KkdRcsR3JMYPXGnhTkZ2jUNqea2VHV3y5CX4ssi8TEb9JJUqMvhxUoafEVhjpAns6pEUBKvutUls767gJRDOywCm3ysdkfI0ri+JtqgGxWuQSrXNezmwWq/OjKjfmU+9GUsMmQ+4w+LE7MLLCXOs+ub6w9SsLtMjjSkX6cy6mq6D6XoHhcECcpDnzipb5UxlWKeu0pxIvAzjE2d0e/Oq0WtD00Fo5WyR9V6+k5miBjS63GanZMAsFMEhh0bCPdi7UrIUx1mb7OpnbHZ54bXVDwn3CpH9V5z5/BvYRlJZjshg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BEsLOWDYkUH89BPDOoetjjz+ynw5RSbaadqY7YEzB6I=;
 b=BZg/veFbLb97aR96zFrAEZQt0qLjQ/MayZniUMpPlHzT/AdDiWoZiQBYnbMbxS/o7nfaoz3WRgCxW0r6Rbc1HF3U/sz3ipOxoyhFN9hKg60fuRrS/Mb3rvKvQ5C+YfEZlnHLE4yubPT/S9Q26XegHZE6oZfnEkW+6gJNiI2nrcxb+gdYalQuJU5t7kKwFXcc0sh9hqSWVV9C+hcMXMThYERQfx23Jvm+CGaacvgok8gTaXIilUg1XHH5L+xNCuCmZVdYQ1DNt9I9Gc6H1mH8emxzgF+mu6ihDDs00H8HPnFHHNoiohOCDzcFaw/KOkpXnAXRkHnKff8KSt2Zk0PbLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BEsLOWDYkUH89BPDOoetjjz+ynw5RSbaadqY7YEzB6I=;
 b=QkDdjeng64CE1XEjG0S7Ib9dABy9RLWoBvWCoeXvWdX7OWPkjlq+mD069OlpFCAIgkB7NjhI60ASyF8g4rAl9eZ1TVVkpWJkyIumhqrPFD6iG+0Ryo/Z0OpgW16nYgfFfSY2Z9UoSeaVv2bYRU3esko0Zn5BZpV9UCjs9CUlmRs=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by BN6PR13MB1090.namprd13.prod.outlook.com (2603:10b6:404:74::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Tue, 30 Aug
 2022 15:43:14 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::f1c7:62d0:a63d:f5ca]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::f1c7:62d0:a63d:f5ca%3]) with mapi id 15.20.5588.010; Tue, 30 Aug 2022
 15:43:14 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bfields@fieldses.org" <bfields@fieldses.org>
CC:     "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "xiubli@redhat.com" <xiubli@redhat.com>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "neilb@suse.de" <neilb@suse.de>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
        "linux-ceph@vger.kernel.org" <linux-ceph@vger.kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "tytso@mit.edu" <tytso@mit.edu>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "jack@suse.cz" <jack@suse.cz>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "lczerner@redhat.com" <lczerner@redhat.com>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "walters@verbum.org" <walters@verbum.org>
Subject: Re: [PATCH v3 1/7] iversion: update comments with info about atime
 updates
Thread-Topic: [PATCH v3 1/7] iversion: update comments with info about atime
 updates
Thread-Index: AQHYuZVnsRGFuLc+aUSHryeVbtc1Ya3FhqCAgAAtUwCAAM6GgIAA1NcAgAAdQICAAAcSAIAADzgAgAAD2QCAAAVOgIAABzCA
Date:   Tue, 30 Aug 2022 15:43:13 +0000
Message-ID: <3e8c7af5d39870c5b0dc61736a79bd134be5a9b3.camel@hammerspace.com>
References: <20220826214703.134870-1-jlayton@kernel.org>
         <20220826214703.134870-2-jlayton@kernel.org>
         <20220829075651.GS3600936@dread.disaster.area>
         <549776abfaddcc936c6de7800b6d8249d97d9f28.camel@kernel.org>
         <166181389550.27490.8200873228292034867@noble.neil.brown.name>
         <f5c42c0d87dfa45188c2109ccf9baeb7a42aa27e.camel@kernel.org>
         <20220830132443.GA26330@fieldses.org>
         <a07686e7e1d1ef15720194be2abe5681f6a6c78e.camel@kernel.org>
         <20220830144430.GD26330@fieldses.org>
         <e4815337177c74a9928098940dfdcb371017a40c.camel@hammerspace.com>
         <20220830151715.GE26330@fieldses.org>
In-Reply-To: <20220830151715.GE26330@fieldses.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 68031c78-5f06-4955-fcb9-08da8a9e59ab
x-ms-traffictypediagnostic: BN6PR13MB1090:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NaMZa4rtAKeR/0OITUUt7EBo3Du/v/sNhgpVhGMcy99j8RRD4IF6KJRKZ9pfqADwuMizAdpjBeTNhykS+SNq2mKH0V+gc391gWM5hiPnRURUf/3GupsLQTg8E4DqMjMxwZ6khLx22pvPXWrU2s1nt4MCNQtP5Ei2FlcFKcNjGTLuvyOKkZgzjZjM2uPt5WDSbcewmtdnUPMcyY+QTy9GsmBJzUkYd8k0Uya02EAf8OZoPX6iebX2yL3BFGp9iQpE0aD4FrBrNEced4Q3DGz0ueqTt4aKEPw+D5SEjzzI7SJmH+3WsyOjmjIkS29k/7B36cqIhsULab3kr/+6/oXg+/Jwi55+JnuPqEHpUiEYC9A0tu8keDHKZ4ZzgSuXj56RPUyQ/A8ipQU01ztnvdzvzMRdjEX80ox6++j8sT/EiN0JrB7sxCHXscJzmf5epJ+XHpRTGn/bLvAbPaVI3Kde16VJtRf4IjUTGM33hXXY11RH1hD6TcF7isXX0DH/l6OefN2lo2aBeF3CFhEDcvSy4Ql1qSHrGIOP+SbwTEB5AVrnXBMLRgFc3fm+LoB7vz/zrfNVP9aPGWnXuWfX+6pITPjT4VqTbJPUhxjHao7aEXwB9j7ZAV+rYNNKhWxhF5+x+UXJRRg0c3UObYJyPx6aap5zwHa6JkqggOtFsS55teP7VsDZ1RoohCGSQLD4D+QdS5m6GpZLPCPybZVJE8Hw5Q/XqvAnmsO9a53zdNAelaVFLDLuMXMshDKR5U+1dVuRwwoHeSW4pinYseTE/a65rBT7S2xJoSdleoNNBPTmdic=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(396003)(136003)(376002)(346002)(39830400003)(54906003)(41300700001)(478600001)(6916009)(316002)(71200400001)(86362001)(966005)(38100700002)(6486002)(6506007)(122000001)(26005)(6512007)(38070700005)(83380400001)(2616005)(186003)(66446008)(66946007)(2906002)(15650500001)(36756003)(66476007)(5660300002)(8936002)(64756008)(4326008)(8676002)(76116006)(7416002)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZXRmYmpXZHBrNWRpUUlPZ3hJWUJOSjdiRkFsdG9ZY0wrZEpWSUN3eW05YVJm?=
 =?utf-8?B?c3Jud1A5Q0NEcTI1SlpuOGlONlQvcTNqbU1ERklCbHBRRU5xdFEzdkJ5d0ZD?=
 =?utf-8?B?aEo2dmh1UU9rekV2SlVCbWhTRnpRK3BkSXhxTUNVV2JxekJxaG1BNUNXZ0tO?=
 =?utf-8?B?RDROLzhZd2xSQ3dTWURtY3J2U0phOU43UXRIWHROOEozQTJ1K1IvUVlrOEVT?=
 =?utf-8?B?SGNmbDVmakxFMHd3dU5qT3p6eU5KQnV2NXo1bUxnbjNidXNKTmJOSmRDVHlH?=
 =?utf-8?B?MVpaMjVpbmF6TlBmaDhaWklod2lacHVzMFEvREZXQVlTR2tIajFxK3VmVERK?=
 =?utf-8?B?Z3lteWhRRjFzUnJ0M0pSZ2JEWFhwSHIvV3JKaXcvbitaL3BpeHpRcmFqeHNG?=
 =?utf-8?B?U2Mra2JrSjI0TDNLVzF1QjVzN3kvWDBjelJDMWhXYlpsM0llZ25hQnVtc1FG?=
 =?utf-8?B?THFxRSt3TVpRUnZ1SUJvR09qTlpRU00wd0Z4SE1WdnI3d2Zuc0k4Y2NBSFpW?=
 =?utf-8?B?cXpTSkF4QnVaTElsWmNBZlF6VWRsUHhQN0ZCRSt0VDlDcVBaZ1BqYVlKald2?=
 =?utf-8?B?cGY2M085Q0ZUamErUzg1MDlSVlF0WDl2d3VZenlZMDk1MHJWV3BTRWdxWGU2?=
 =?utf-8?B?YlN5U0ZNOGExWU1EWUk3bS9VTHl1aklXUHVVcVNCd05sVHJGUU5qL1ZGRkpV?=
 =?utf-8?B?VzdqTml3ZlkyalpnUDBKbVYzeGJka2gzNERVdUYxUDI3R2xKU28wMmVDMW5S?=
 =?utf-8?B?UEZaeHd2WGZtQ1NOVUJlbkQ1ZjBOWS9OblgrN1ZkaXJVclRkblpZTUNjbE1Q?=
 =?utf-8?B?MWFNQXlUSXBod1A4ck14TmVGZDFpMzZmM3IyRDJCME45Z0YzTjNYSGk0aDlu?=
 =?utf-8?B?cmtHZzA4ZnY0VjU2eWJyYnhVbnNaV1RGOGlUT0JjOERPMnlkb0RCL29ONEtt?=
 =?utf-8?B?ckVaTk5PdzV5UlRwVW13T1VFbmEya1FpNmlwRjJvenNIemxLN3lIU0VRUGdJ?=
 =?utf-8?B?K0tWVTNwQXJtbG95bC85MmV2bkFaM3RZZ1ZiWUhYQXZCaFpjRE1DcEg1Um9t?=
 =?utf-8?B?TWdBWjBSaVFYUm5jL3lOMlpCV2hNUzdVM0EwbE1BMkR2L0VFUlN5a084aGN1?=
 =?utf-8?B?d1NMM1lnZ2RSczNpSWhkVWhUWjBsRVNBYXBZcjNVTVNTV1ZNYkVLM0hyRFBF?=
 =?utf-8?B?TUZtalNqWlZ0UTR2M2p1WkFuUlVVOFhNajdZdTRxaVVDV2lPZkdtVnZmaWsx?=
 =?utf-8?B?ckxIdjR4NS80MmdvMFZFM0NBSWJ3dUtiVElOQm9hT1ZRNTllUGttTDJYL3dw?=
 =?utf-8?B?NVZ2ZDZlU0dwcXhjd1l4TkhaU0tUY1BncGc1TExHNU0wbkZSN2VIYlhUSFo2?=
 =?utf-8?B?dkc0L1c4TGJGUTRtdllTaHhiSzIvUnNFQkJRcVp3RFNGN3k3ejNSUHRlL3ZI?=
 =?utf-8?B?dFFKYjN4ZENpVEg2RW9RbCtCbmRHRGpBM0dOYlBCOXZnbFZIQ1FJYnFzcDF0?=
 =?utf-8?B?eDh3a3F3dkZGUkM5OXd3dlRqWFZNWUhCOGU4Mis3S3Zta0tWaUhUNlVPR2Uz?=
 =?utf-8?B?YldJdFFwY3hzbHRTbDJuaDVSejExNTlSWXBibUx1WVJ3QUZtdEF5a0JaUDQw?=
 =?utf-8?B?djhud1pEdHNodnpXcUc4M2U5NDhrNlNVNzRnOEJEbkFJS05pS2svM3pESS9j?=
 =?utf-8?B?WlpqK2NlNnZ1VHpRWWVPT21xN3pncEtmZm1QUXUrc1JMK0ZJUW9HSG5HSits?=
 =?utf-8?B?S2tWZ2RWNEhyZ2dmSnEwVmpvM1BwSnBtM2J1K3NCRzRzUTV6Uk1SZDcwckpo?=
 =?utf-8?B?UVFwY0s3RmViWDR0S2d5UnkyQnVLZW5XYlhCWFNmMWdwNnc3dnhaSzhuTEE1?=
 =?utf-8?B?OUVnT0xJRzRTeHVHVE5xbGJ6UlpPSXMybjhDRE1ybFBrNmk4Nnp3UDZEZk4y?=
 =?utf-8?B?RGw5eHdWcldmSElMMTVtQjc2QUtlTmlnZVpzY0xSWmJRZXVtdkdpTUxkWDJQ?=
 =?utf-8?B?TmZhWXh6djY4R3JsNzBVWTVJWFhtVW1Ha2ZvblpxUnIzaFA0R3U5U1h6R09l?=
 =?utf-8?B?TjhBZ3FBWGw1d0pXelczb0k4dHlqWnNraFRRc2N6ZXdUTzhNZ2hiL1dYanly?=
 =?utf-8?B?MWNHNE9DM3VVYk9VRytBbWxsL1YzTkd5Mkdzc0EzSitZcDgxRXc0WkNhNXZi?=
 =?utf-8?B?R2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3924CC11C14159428C97C2B657250D42@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68031c78-5f06-4955-fcb9-08da8a9e59ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2022 15:43:13.9631
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pxCHDdWpTF+qtOxYoROdMCp2QOJXMmxsxJzD/SDQfccteIDIC4Ig4dKzv8PQJmD/f0P8xFFGF1uNLzzb1G9hLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR13MB1090
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gVHVlLCAyMDIyLTA4LTMwIGF0IDExOjE3IC0wNDAwLCBKLiBCcnVjZSBGaWVsZHMgd3JvdGU6
DQo+IE9uIFR1ZSwgQXVnIDMwLCAyMDIyIGF0IDAyOjU4OjI3UE0gKzAwMDAsIFRyb25kIE15a2xl
YnVzdCB3cm90ZToNCj4gPiBPbiBUdWUsIDIwMjItMDgtMzAgYXQgMTA6NDQgLTA0MDAsIEouIEJy
dWNlIEZpZWxkcyB3cm90ZToNCj4gPiA+IE9uIFR1ZSwgQXVnIDMwLCAyMDIyIGF0IDA5OjUwOjAy
QU0gLTA0MDAsIEplZmYgTGF5dG9uIHdyb3RlOg0KPiA+ID4gPiBPbiBUdWUsIDIwMjItMDgtMzAg
YXQgMDk6MjQgLTA0MDAsIEouIEJydWNlIEZpZWxkcyB3cm90ZToNCj4gPiA+ID4gPiBPbiBUdWUs
IEF1ZyAzMCwgMjAyMiBhdCAwNzo0MDowMkFNIC0wNDAwLCBKZWZmIExheXRvbiB3cm90ZToNCj4g
PiA+ID4gPiA+IFllcywgc2F5aW5nIG9ubHkgdGhhdCBpdCBtdXN0IGJlIGRpZmZlcmVudCBpcyBp
bnRlbnRpb25hbC4NCj4gPiA+ID4gPiA+IFdoYXQNCj4gPiA+ID4gPiA+IHdlDQo+ID4gPiA+ID4g
PiByZWFsbHkgd2FudCBpcyBmb3IgY29uc3VtZXJzIHRvIHRyZWF0IHRoaXMgYXMgYW4gb3BhcXVl
DQo+ID4gPiA+ID4gPiB2YWx1ZQ0KPiA+ID4gPiA+ID4gZm9yIHRoZQ0KPiA+ID4gPiA+ID4gbW9z
dCBwYXJ0IFsxXS4gVGhlcmVmb3JlIGFuIGltcGxlbWVudGF0aW9uIGJhc2VkIG9uIGhhc2hpbmcN
Cj4gPiA+ID4gPiA+IHdvdWxkDQo+ID4gPiA+ID4gPiBjb25mb3JtIHRvIHRoZSBzcGVjLCBJJ2Qg
dGhpbmssIGFzIGxvbmcgYXMgYWxsIG9mIHRoZQ0KPiA+ID4gPiA+ID4gcmVsZXZhbnQNCj4gPiA+
ID4gPiA+IGluZm8gaXMNCj4gPiA+ID4gPiA+IHBhcnQgb2YgdGhlIGhhc2guDQo+ID4gPiA+ID4g
DQo+ID4gPiA+ID4gSXQnZCBjb25mb3JtLCBidXQgaXQgbWlnaHQgbm90IGJlIGFzIHVzZWZ1bCBh
cyBhbiBpbmNyZWFzaW5nDQo+ID4gPiA+ID4gdmFsdWUuDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4g
RS5nLiBhIGNsaWVudCBjYW4gdXNlIHRoYXQgdG8gd29yayBvdXQgd2hpY2ggb2YgYSBzZXJpZXMg
b2YNCj4gPiA+ID4gPiByZW9yZGVyZWQNCj4gPiA+ID4gPiB3cml0ZSByZXBsaWVzIGlzIHRoZSBt
b3N0IHJlY2VudCwgYW5kIEkgc2VlbSB0byByZWNhbGwgdGhhdA0KPiA+ID4gPiA+IGNhbg0KPiA+
ID4gPiA+IHByZXZlbnQNCj4gPiA+ID4gPiB1bm5lY2Vzc2FyeSBpbnZhbGlkYXRpb25zIGluIHNv
bWUgY2FzZXMuDQo+ID4gPiA+ID4gDQo+ID4gPiA+IA0KPiA+ID4gPiBUaGF0J3MgYSBnb29kIHBv
aW50OyB0aGUgbGludXggY2xpZW50IGRvZXMgdGhpcy4gVGhhdCBzYWlkLA0KPiA+ID4gPiBORlN2
NA0KPiA+ID4gPiBoYXMgYQ0KPiA+ID4gPiB3YXkgZm9yIHRoZSBzZXJ2ZXIgdG8gYWR2ZXJ0aXNl
IGl0cyBjaGFuZ2UgYXR0cmlidXRlIGJlaGF2aW9yDQo+ID4gPiA+IFsxXQ0KPiA+ID4gPiAodGhv
dWdoIG5mc2QgaGFzbid0IGltcGxlbWVudGVkIHRoaXMgeWV0KS4NCj4gPiA+IA0KPiA+ID4gSXQg
d2FzIGltcGxlbWVudGVkIGFuZCByZXZlcnRlZC7CoCBUaGUgaXNzdWUgd2FzIHRoYXQgSSB0aG91
Z2h0DQo+ID4gPiBuZnNkDQo+ID4gPiBzaG91bGQgbWl4IGluIHRoZSBjdGltZSB0byBwcmV2ZW50
IHRoZSBjaGFuZ2UgYXR0cmlidXRlIGdvaW5nDQo+ID4gPiBiYWNrd2FyZHMNCj4gPiA+IG9uIHJl
Ym9vdCAoc2VlIGZzL25mc2QvbmZzZmguaDpuZnNkNF9jaGFuZ2VfYXR0cmlidXRlKCkpLCBidXQN
Cj4gPiA+IFRyb25kDQo+ID4gPiB3YXMNCj4gPiA+IGNvbmNlcm5lZCBhYm91dCB0aGUgcG9zc2li
aWxpdHkgb2YgdGltZSBnb2luZyBiYWNrd2FyZHMuwqAgU2VlDQo+ID4gPiAxNjMxMDg3YmE4NzIg
IlJldmVydCAibmZzZDQ6IHN1cHBvcnQgY2hhbmdlX2F0dHJfdHlwZQ0KPiA+ID4gYXR0cmlidXRl
IiIuDQo+ID4gPiBUaGVyZSdzIHNvbWUgbWFpbGluZyBsaXN0IGRpc2N1c3Npb24gdG8gdGhhdCBJ
J20gbm90IHR1cm5pbmcgdXANCj4gPiA+IHJpZ2h0DQo+ID4gPiBub3cuDQo+IA0KPiBodHRwczov
L2xvcmUua2VybmVsLm9yZy9saW51eC1uZnMvYTYyOTRjMjVjYjVlYjk4MTkzZjYwOWE1MmFhOGY0
YjVkNGU4MTI3OS5jYW1lbEBoYW1tZXJzcGFjZS5jb20vDQo+IGlzIHdoYXQgSSB3YXMgdGhpbmtp
bmcgb2YgYnV0IGl0IGlzbid0IGFjdHVhbGx5IHRoYXQgaW50ZXJlc3RpbmcuDQo+IA0KPiA+IE15
IG1haW4gY29uY2VybiB3YXMgdGhhdCBzb21lIGZpbGVzeXN0ZW1zIChlLmcuIGV4dDMpIHdlcmUg
ZmFpbGluZw0KPiA+IHRvDQo+ID4gcHJvdmlkZSBzdWZmaWNpZW50IHRpbWVzdGFtcCByZXNvbHV0
aW9uIHRvIGFjdHVhbGx5IGxhYmVsIHRoZQ0KPiA+IHJlc3VsdGluZw0KPiA+ICdjaGFuZ2UgYXR0
cmlidXRlJyBhcyBiZWluZyB1cGRhdGVkIG1vbm90b25pY2FsbHkuIElmIHRoZSB0aW1lDQo+ID4g
c3RhbXANCj4gPiBkb2Vzbid0IGNoYW5nZSB3aGVuIHRoZSBmaWxlIGRhdGEgb3IgbWV0YWRhdGEg
YXJlIGNoYW5nZWQsIHRoZW4gdGhlDQo+ID4gY2xpZW50IGhhcyB0byBwZXJmb3JtIGV4dHJhIGNo
ZWNrcyB0byB0cnkgdG8gZmlndXJlIG91dCB3aGV0aGVyIG9yDQo+ID4gbm90DQo+ID4gaXRzIGNh
Y2hlcyBhcmUgdXAgdG8gZGF0ZS4NCj4gDQo+IFRoYXQncyBhIGRpZmZlcmVudCBpc3N1ZSBmcm9t
IHRoZSBvbmUgeW91IHdlcmUgcmFpc2luZyBpbiB0aGF0DQo+IGRpc2N1c3Npb24uDQo+IA0KPiA+
ID4gRGlkIE5GU3Y0IGFkZCBjaGFuZ2VfYXR0cl90eXBlIGJlY2F1c2Ugc29tZSBpbXBsZW1lbnRh
dGlvbnMNCj4gPiA+IG5lZWRlZA0KPiA+ID4gdGhlDQo+ID4gPiB1bm9yZGVyZWQgY2FzZSwgb3Ig
YmVjYXVzZSB0aGV5IHJlYWxpemVkIG9yZGVyaW5nIHdhcyB1c2VmdWwgYnV0DQo+ID4gPiB3YW50
ZWQNCj4gPiA+IHRvIGtlZXAgYmFja3dhcmRzIGNvbXBhdGliaWxpdHk/wqAgSSBkb24ndCBrbm93
IHdoaWNoIGl0IHdhcy4NCj4gPiANCj4gPiBXZSBpbXBsZW1lbnRlZCBpdCBiZWNhdXNlLCBhcyBp
bXBsaWVkIGFib3ZlLCBrbm93bGVkZ2Ugb2Ygd2hldGhlcg0KPiA+IG9yDQo+ID4gbm90IHRoZSBj
aGFuZ2UgYXR0cmlidXRlIGJlaGF2ZXMgbW9ub3RvbmljYWxseSwgb3Igc3RyaWN0bHkNCj4gPiBt
b25vdG9uaWNhbGx5LCBlbmFibGVzIGEgbnVtYmVyIG9mIG9wdGltaXNhdGlvbnMuDQo+IA0KPiBP
ZiBjb3Vyc2UsIGJ1dCBteSBxdWVzdGlvbiB3YXMgYWJvdXQgdGhlIHZhbHVlIG9mIHRoZSBvbGQg
YmVoYXZpb3IsDQo+IG5vdA0KPiBhYm91dCB0aGUgdmFsdWUgb2YgdGhlIG1vbm90b25pYyBiZWhh
dmlvci4NCj4gDQo+IFB1dCBkaWZmZXJlbnRseSwgaWYgd2UgY291bGQgcmVkZXNpZ24gdGhlIHBy
b3RvY29sIGZyb20gc2NyYXRjaCB3b3VsZA0KPiB3ZQ0KPiBhY3R1YWxseSBoYXZlIGluY2x1ZGVk
IHRoZSBvcHRpb24gb2Ygbm9uLW1vbm90b25pYyBiZWhhdmlvcj8NCj4gDQoNCklmIHdlIGNvdWxk
IGRlc2lnbiB0aGUgZmlsZXN5c3RlbXMgZnJvbSBzY3JhdGNoLCB3ZSBwcm9iYWJseSB3b3VsZCBu
b3QuDQpUaGUgcHJvdG9jb2wgZW5kZWQgdXAgYmVpbmcgYXMgaXQgaXMgYmVjYXVzZSBwZW9wbGUg
d2VyZSB0cnlpbmcgdG8gbWFrZQ0KaXQgYXMgZWFzeSB0byBpbXBsZW1lbnQgYXMgcG9zc2libGUu
DQoNClNvIGlmIHdlIGNvdWxkIGRlc2lnbiB0aGUgZmlsZXN5c3RlbSBmcm9tIHNjcmF0Y2gsIHdl
IHdvdWxkIGhhdmUNCnByb2JhYmx5IGRlc2lnbmVkIGl0IGFsb25nIHRoZSBsaW5lcyBvZiB3aGF0
IEFGUyBkb2VzLg0KaS5lLiBlYWNoIGV4cGxpY2l0IGNoYW5nZSBpcyBhY2NvbXBhbmllZCBieSBh
IHNpbmdsZSBidW1wIG9mIHRoZSBjaGFuZ2UNCmF0dHJpYnV0ZSwgc28gdGhhdCB0aGUgY2xpZW50
cyBjYW4gbm90IG9ubHkgZGVjaWRlIHRoZSBvcmRlciBvZiB0aGUNCnJlc3VsdGluZyBjaGFuZ2Vz
LCBidXQgYWxzbyBpZiB0aGV5IGhhdmUgbWlzc2VkIGEgY2hhbmdlICh0aGF0IG1pZ2h0DQpoYXZl
IGJlZW4gbWFkZSBieSBhIGRpZmZlcmVudCBjbGllbnQpLg0KDQpIb3dldmVyIHRoYXQgd291bGQg
YmUgYSByZXF1aXJlbWVudCB0aGF0IGlzIGxpa2VseSB0byBiZSB2ZXJ5IHNwZWNpZmljDQp0byBk
aXN0cmlidXRlZCBjYWNoZXMgKGFuZCBoZW5jZSBkaXN0cmlidXRlZCBmaWxlc3lzdGVtcykuIEkg
ZG91YnQNCnRoZXJlIGFyZSBtYW55IHVzZXIgc3BhY2UgYXBwbGljYXRpb25zIHRoYXQgd291bGQg
bmVlZCB0aGF0IGhpZ2gNCnByZWNpc2lvbi4gTWF5YmUgTVBJLCBidXQgdGhhdCdzIHRoZSBvbmx5
IGNhbmRpZGF0ZSBJIGNhbiB0aGluayBvZiBmb3INCm5vdz8NCg0KLS0gDQpUcm9uZCBNeWtsZWJ1
c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xl
YnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
