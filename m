Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E82465A6B36
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Aug 2022 19:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232024AbiH3Rur (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Aug 2022 13:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbiH3Ru3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Aug 2022 13:50:29 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D7B1A074;
        Tue, 30 Aug 2022 10:47:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZBgz/qoO1WpJe25ZBK822ZqxpaUGEhsgdDabVsQdK+hDYVrVdpiZD7uwZ3ugBpPj+XLLtt+ptv2XFdNvE7evdGTkTJ4zLMdthRH+GCou9CWQe2u69d+GVRxihawPtwo/HmTxY0CgwVW6BUoqTnJxR43mCT/GR+tp0+4NNCK0a0CvfAWCajpaNgxMMMOm/DTnr36ssX4F8G8+N0mRz2fvuod49+9//liS4uG4n/CBg4NpyOLG8YdkdAamOpz0Es8jOl2Xkr/x0WX4eEHY3jb6VhADTbqgcSRHQ1YTUJtOGezgAud8Civ/d19HJUjLTVa1xrCjjPSVW9sBDkDzIG8Ygg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=84Es0yB/hXGqbiRVc1Qr+xz3vlIkjiiNdQXrBjCxzbo=;
 b=M25FQOkpg3dHAqHC3KzxoykjlcwwL2NzvGhu2fPbvKQxrRWPHRnKI3UrmfyPPUqRa4Eo31qiTHqbu+MQ3F9X/cHUAfq+B7/ehYg/ic1o6R8PvgEywnoXpFHhyXibBUl3vkcp3uW68GUNI+VLQA21gXMj9xLMk+qwSz1y7wyt0XS0khSzrQJxQbepaXi/OnAnBk/bP9Iet89RG/8GMFPooxJ2qZwv5C85TJZx1aA5XiBj1PtDdw+sAJ0IeoAW1Pfnknuw2XXqB+rSRYqRzenmItX5UjUGG406g2rDKYRoB66FMU5hWrwb3oZemc1Z3drI1YUakXjeIdUNI4rl2FbbLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=84Es0yB/hXGqbiRVc1Qr+xz3vlIkjiiNdQXrBjCxzbo=;
 b=O+ib0m9qTJxXadUWlL7HRxaRhXUWQ8j56neD0j+abbkAUn+QIDRzZ3BUJux6JhBwHfbGqEEI2q1W1ItcwVR00Nwb7loPjwhZWtoI6YSazoG9tBIW2y0gE5vpQwoiGw7NXBJb8MrCYBzmBsi/VY6EAGwQZuw6/Wfu7gnG/x7AH78=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by BN6PR13MB1108.namprd13.prod.outlook.com (2603:10b6:404:69::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Tue, 30 Aug
 2022 17:47:05 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::f1c7:62d0:a63d:f5ca]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::f1c7:62d0:a63d:f5ca%3]) with mapi id 15.20.5588.010; Tue, 30 Aug 2022
 17:47:05 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bfields@fieldses.org" <bfields@fieldses.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>
CC:     "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "neilb@suse.de" <neilb@suse.de>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "xiubli@redhat.com" <xiubli@redhat.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
        "linux-ceph@vger.kernel.org" <linux-ceph@vger.kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "tytso@mit.edu" <tytso@mit.edu>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "jack@suse.cz" <jack@suse.cz>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "lczerner@redhat.com" <lczerner@redhat.com>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "walters@verbum.org" <walters@verbum.org>
Subject: Re: [PATCH v3 1/7] iversion: update comments with info about atime
 updates
Thread-Topic: [PATCH v3 1/7] iversion: update comments with info about atime
 updates
Thread-Index: AQHYuZVnsRGFuLc+aUSHryeVbtc1Ya3FhqCAgAAtUwCAAM6GgIAA1NcAgAAdQICAAAcSAIAADzgAgAAD2QCAAAVOgIAABzCAgAAWUACAAAxZAA==
Date:   Tue, 30 Aug 2022 17:47:05 +0000
Message-ID: <5fd1f7e99d5ab87db48c8c3603b014c1c2d2ec5a.camel@hammerspace.com>
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
         <3e8c7af5d39870c5b0dc61736a79bd134be5a9b3.camel@hammerspace.com>
         <4adb2abd1890b147dbc61a06413f35d2f147c43a.camel@kernel.org>
In-Reply-To: <4adb2abd1890b147dbc61a06413f35d2f147c43a.camel@kernel.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 444ad69c-a16f-4f23-e0f7-08da8aafa6f1
x-ms-traffictypediagnostic: BN6PR13MB1108:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HoCliX/xYia29vLKE/ym4J7xoqkCjPGB3Zc+NAX5rXBDUX9UHCqPFPXA1hJK/rg1SGkNXmuv1HnoyYcMxO4Nkaz9wH5Lz3ePItzZOIZzbuOPsbCuyIB0apgFkc5RVAIlq8AElnSOuXD3j/B6F8AzgFt47zPZLBovgMeoLqYBA9b4IBqapWGgFkQeuUeTB1RyWhNr3YBYw5EKPyp8kINnX8fxc5XHcddacSkwchOn9Znb5H7Cjh9M37oCUoOk/6cEiGcpP+w4647k2hHXjOWrHPFJvZxpYjL6XwXr5pruCVdk2MJk+6UTF0o7fxSwPdWJVKe44speubEIlfQW7Ka09jZiZtH93D8iijeLzYHdGzC2Dz80NN0whWTbjRMJKKO9lg+9+bheQ+6lMzD5P+k+gPLJ4+mPdpZAQTI/vvMQQvOz/12EM6ySOMkLCX9e/5AFgPmaONFC8V5ovmdvi113agLJSLhEyIzpECMxNhlshZyh97no7RVj2eiIK2hk8F0vfEbtRl30MCyuyb0zNv6GKYGfII9UqdyB9vqB6PJqJkjVl1lj3ClKWrcZNwCdImIXl2ykdMDGbpXJpW3uz1hAgjLngEAZizTi+74HExXKYcvBsGzAGhmCBVtw5KZe+BJo355dHejUfRW49AxkOYq/D+295G2s4S41g6oxnJZQmKBdrGsxfVfE+nteTx2qJbZe/z/ava2z9IFF7zdGMExu3MhNHfoZ4dDEgRCrCYRvPDJLLrFsDLUlZdYqXNOO9GvSf3kvih18C1mIPogPajGOy6QbtpIXWfIPl25/wGiXCmA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(136003)(366004)(376002)(39830400003)(396003)(122000001)(6512007)(26005)(38100700002)(7416002)(5660300002)(86362001)(8936002)(41300700001)(478600001)(38070700005)(15650500001)(6506007)(6486002)(8676002)(64756008)(4326008)(66476007)(76116006)(66946007)(66446008)(2906002)(2616005)(66556008)(110136005)(54906003)(36756003)(186003)(83380400001)(966005)(316002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SHVhR2JyZ1NjMmpMaFlPbE5IOXBMZjBRNjBza1czL2tRMjNhZmtKNmoxcHdq?=
 =?utf-8?B?aHpPVGsvbE5vamIyS0hnUGlsTzl0RHpGOEMreVp1b0JWWW5KbDdVMlFjUFMr?=
 =?utf-8?B?cmNTNjNDQnlycGJxU3dtK00xNUhpcXJMWUI4MDhnQlo5cGlmRklTRU5KTDlK?=
 =?utf-8?B?NWhjQndITjh4a1ROZ2xwVytMZ0taV1Z0eFNsSnFxZ3dvSlJaN29BVzE1NTV2?=
 =?utf-8?B?QUtJdEpRR3RVcCtCanZnQ1JiYlpMdGdwRVFoVEJXM2FjWXl6emFjenhNejBZ?=
 =?utf-8?B?YjdLcllyNmYxd3NpVFVSVmFzMVRjbktYNlBvc3ErTC9kMlpHK3Y2bUxxOGor?=
 =?utf-8?B?dU5XUFo5a29IeGdEaDdYZmRod21aTmFnSjRGSVFBY2NjdzRJa1RINUZrWnl3?=
 =?utf-8?B?cVpMRUVyTjNVN2xGTCtYb3BLelVDYjJjcUxDWUJqRDlicGYvKzJ3RThBSTh6?=
 =?utf-8?B?Tm1qRmFGZUFYbDRtTFdTTmNzL09aU1NWRnlXTkVteStmZGFqMXQ0NXJ3TVZS?=
 =?utf-8?B?RjBtVVJ6M1pxOUtuZTlEMGhsR3FqMzIyWk11OGNHQzFIMk94cWNkZXE5WFlS?=
 =?utf-8?B?c0h4eHREcXlXNGN0RytOb0prTUlKUGNWTGQ4OTdxeUJDa0pwRFdBZFljaWpE?=
 =?utf-8?B?L3NtRlpBblRRbU1GdnpTdGtRQVduOGlSckV0VTlkZFoybVNhb3RkZ1UzaUha?=
 =?utf-8?B?ZmkwbHp0QU01WlF1aXh1a0Znc2NwZVlBM1hsc0Z2WXkvOFI5Y2JneW94L0dw?=
 =?utf-8?B?d2hyWWdVR0hjdUVBbUlSZjU2a3VpZGFLUHkrRmM5NUdTaG5JUjNwYU9HcTQz?=
 =?utf-8?B?L3lyekxOOWtweHhzWitnbEVDRGFHOS9yMVZzQWZqdWNFc01NMG50TGx5Rk5G?=
 =?utf-8?B?MVk3L0FxVTM4eStlSWpXK21IRVFKQVV0dmFQT2xBSUQ2MzlvdmpOQVBaQ0N5?=
 =?utf-8?B?UnUwMHFXeDgxaUg4ZFpLSVhYSjJDSGI0cXFGYnA3Y1NNakpmZTJOUE41UERj?=
 =?utf-8?B?VDRYRXMrU080Vk9ZLytNZ0ZJYzlhVGlWa201Ky9tR0JNckJ6YmJTMWsyanlJ?=
 =?utf-8?B?ZTg4dElwUWtUTUd6dkxvTVVKWDYzalp5dkFXSU9WTWlXLzN0MFlQQzZvZGhM?=
 =?utf-8?B?cWlreGlYK3Q3NEREZVc3ZzJjU2xZZEpIcERpTVNES29DKzIyenlkR0FFQ00w?=
 =?utf-8?B?WHZTZjY4UHpyNUpwbjAyMk9RNGM4bDVZVVp5QUR6QXRCUDY2THY5UE5pZUc5?=
 =?utf-8?B?NGU2ZHFWeGwxQUZjalpJR2hNVjRWZTJQdForQ2h0cll3UlMxeE5qcjlNTktT?=
 =?utf-8?B?OVN2OFpXWEFQa2NWZldFRHdUS2lzRXhhUGRWVndySFlDM3JjK0JLczhlT0d2?=
 =?utf-8?B?ZFBQVEZqU3U4bCt4MEcyU0Z0eHlaS0xnY0gxTkhFZUl5RmtFUEtneHZzU0Fr?=
 =?utf-8?B?UXlabWxQU3h0c3BLOU1peE1ZTHZtZ2RPRHVPVngzN3FvL2lqN0tmSzQ2aCtS?=
 =?utf-8?B?cVJ6eE45VUt0R2JSYkU1OU91aUd4cG92UTRCUm9aM0liRk1CWUZTa1c4dEsy?=
 =?utf-8?B?K1B6NHVaUzlHNEpObmFGSTVWT091Z1hnamhNNnZnbmx6NGhEYjQyZjZnYU1B?=
 =?utf-8?B?bExlZmtVblRNUW1zOTU3d3NScVBHanYxckFjYmc1eHg3Yjl6djJQRzJvMnJa?=
 =?utf-8?B?TDFZTWQwTFlLeHV6OGhGWnRuVitnNTl2d3pLK3d1MktyempVUHVjQS9lYWhB?=
 =?utf-8?B?UzB0c0NWc3RRVkZaOTZwUHA3MUUwS2RScTZybkZISVB0bEhFclhqVXZsWGQw?=
 =?utf-8?B?UngwMnQ0TDR5THBDN1hWcmJ0VTdSR2ZmY3R3dllLS0tBT1BWT1cyUElCS1pX?=
 =?utf-8?B?enlsdEYwZnRKK1dLZHVHbytVcnhrRnV6YkRXYkxWbXdXNkNKWlZUaVdPTnR0?=
 =?utf-8?B?eVR4S0U1UWZXWHJua1ZIekRoS2lGM2N1MkRxQzJkQjZtNGdXM2tGUHRORTJJ?=
 =?utf-8?B?R0IvbVVzSERWUy8wbVlWbXRQY2NOWXpUcW9Bd1doT0VzclViOVhpd0lXTEJ3?=
 =?utf-8?B?c1JRdlZhU01TUjM4NVV6RERubkJHaC96alBqMmlPZUhwS2xkRm5sZkZBWHk3?=
 =?utf-8?B?WWxHWGFzaHV2YWk5MlBKNVZQQjRzeHlhSGlsRlJsZ3l2c010WUovQkJ4bEh2?=
 =?utf-8?B?b2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <102D12207CF54549B6D40D230093FB16@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 444ad69c-a16f-4f23-e0f7-08da8aafa6f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2022 17:47:05.0969
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ckkXYDdGBU7nRDXreDbqem2gio7Z9M1uiZM61eCTlhcN8PySj7AF31xBUlLER0kiqR80923mQhqBhWL8dveiCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR13MB1108
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gVHVlLCAyMDIyLTA4LTMwIGF0IDEzOjAyIC0wNDAwLCBKZWZmIExheXRvbiB3cm90ZToNCj4g
T24gVHVlLCAyMDIyLTA4LTMwIGF0IDE1OjQzICswMDAwLCBUcm9uZCBNeWtsZWJ1c3Qgd3JvdGU6
DQo+ID4gT24gVHVlLCAyMDIyLTA4LTMwIGF0IDExOjE3IC0wNDAwLCBKLiBCcnVjZSBGaWVsZHMg
d3JvdGU6DQo+ID4gPiBPbiBUdWUsIEF1ZyAzMCwgMjAyMiBhdCAwMjo1ODoyN1BNICswMDAwLCBU
cm9uZCBNeWtsZWJ1c3Qgd3JvdGU6DQo+ID4gPiA+IE9uIFR1ZSwgMjAyMi0wOC0zMCBhdCAxMDo0
NCAtMDQwMCwgSi4gQnJ1Y2UgRmllbGRzIHdyb3RlOg0KPiA+ID4gPiA+IE9uIFR1ZSwgQXVnIDMw
LCAyMDIyIGF0IDA5OjUwOjAyQU0gLTA0MDAsIEplZmYgTGF5dG9uIHdyb3RlOg0KPiA+ID4gPiA+
ID4gT24gVHVlLCAyMDIyLTA4LTMwIGF0IDA5OjI0IC0wNDAwLCBKLiBCcnVjZSBGaWVsZHMgd3Jv
dGU6DQo+ID4gPiA+ID4gPiA+IE9uIFR1ZSwgQXVnIDMwLCAyMDIyIGF0IDA3OjQwOjAyQU0gLTA0
MDAsIEplZmYgTGF5dG9uDQo+ID4gPiA+ID4gPiA+IHdyb3RlOg0KPiA+ID4gPiA+ID4gPiA+IFll
cywgc2F5aW5nIG9ubHkgdGhhdCBpdCBtdXN0IGJlIGRpZmZlcmVudCBpcw0KPiA+ID4gPiA+ID4g
PiA+IGludGVudGlvbmFsLg0KPiA+ID4gPiA+ID4gPiA+IFdoYXQNCj4gPiA+ID4gPiA+ID4gPiB3
ZQ0KPiA+ID4gPiA+ID4gPiA+IHJlYWxseSB3YW50IGlzIGZvciBjb25zdW1lcnMgdG8gdHJlYXQg
dGhpcyBhcyBhbiBvcGFxdWUNCj4gPiA+ID4gPiA+ID4gPiB2YWx1ZQ0KPiA+ID4gPiA+ID4gPiA+
IGZvciB0aGUNCj4gPiA+ID4gPiA+ID4gPiBtb3N0IHBhcnQgWzFdLiBUaGVyZWZvcmUgYW4gaW1w
bGVtZW50YXRpb24gYmFzZWQgb24NCj4gPiA+ID4gPiA+ID4gPiBoYXNoaW5nDQo+ID4gPiA+ID4g
PiA+ID4gd291bGQNCj4gPiA+ID4gPiA+ID4gPiBjb25mb3JtIHRvIHRoZSBzcGVjLCBJJ2QgdGhp
bmssIGFzIGxvbmcgYXMgYWxsIG9mIHRoZQ0KPiA+ID4gPiA+ID4gPiA+IHJlbGV2YW50DQo+ID4g
PiA+ID4gPiA+ID4gaW5mbyBpcw0KPiA+ID4gPiA+ID4gPiA+IHBhcnQgb2YgdGhlIGhhc2guDQo+
ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiBJdCdkIGNvbmZvcm0sIGJ1dCBpdCBtaWdodCBu
b3QgYmUgYXMgdXNlZnVsIGFzIGFuDQo+ID4gPiA+ID4gPiA+IGluY3JlYXNpbmcNCj4gPiA+ID4g
PiA+ID4gdmFsdWUuDQo+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiBFLmcuIGEgY2xpZW50
IGNhbiB1c2UgdGhhdCB0byB3b3JrIG91dCB3aGljaCBvZiBhIHNlcmllcw0KPiA+ID4gPiA+ID4g
PiBvZg0KPiA+ID4gPiA+ID4gPiByZW9yZGVyZWQNCj4gPiA+ID4gPiA+ID4gd3JpdGUgcmVwbGll
cyBpcyB0aGUgbW9zdCByZWNlbnQsIGFuZCBJIHNlZW0gdG8gcmVjYWxsDQo+ID4gPiA+ID4gPiA+
IHRoYXQNCj4gPiA+ID4gPiA+ID4gY2FuDQo+ID4gPiA+ID4gPiA+IHByZXZlbnQNCj4gPiA+ID4g
PiA+ID4gdW5uZWNlc3NhcnkgaW52YWxpZGF0aW9ucyBpbiBzb21lIGNhc2VzLg0KPiA+ID4gPiA+
ID4gPiANCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gVGhhdCdzIGEgZ29vZCBwb2ludDsgdGhl
IGxpbnV4IGNsaWVudCBkb2VzIHRoaXMuIFRoYXQgc2FpZCwNCj4gPiA+ID4gPiA+IE5GU3Y0DQo+
ID4gPiA+ID4gPiBoYXMgYQ0KPiA+ID4gPiA+ID4gd2F5IGZvciB0aGUgc2VydmVyIHRvIGFkdmVy
dGlzZSBpdHMgY2hhbmdlIGF0dHJpYnV0ZQ0KPiA+ID4gPiA+ID4gYmVoYXZpb3INCj4gPiA+ID4g
PiA+IFsxXQ0KPiA+ID4gPiA+ID4gKHRob3VnaCBuZnNkIGhhc24ndCBpbXBsZW1lbnRlZCB0aGlz
IHlldCkuDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gSXQgd2FzIGltcGxlbWVudGVkIGFuZCByZXZl
cnRlZC7CoCBUaGUgaXNzdWUgd2FzIHRoYXQgSQ0KPiA+ID4gPiA+IHRob3VnaHQNCj4gPiA+ID4g
PiBuZnNkDQo+ID4gPiA+ID4gc2hvdWxkIG1peCBpbiB0aGUgY3RpbWUgdG8gcHJldmVudCB0aGUg
Y2hhbmdlIGF0dHJpYnV0ZSBnb2luZw0KPiA+ID4gPiA+IGJhY2t3YXJkcw0KPiA+ID4gPiA+IG9u
IHJlYm9vdCAoc2VlIGZzL25mc2QvbmZzZmguaDpuZnNkNF9jaGFuZ2VfYXR0cmlidXRlKCkpLCBi
dXQNCj4gPiA+ID4gPiBUcm9uZA0KPiA+ID4gPiA+IHdhcw0KPiA+ID4gPiA+IGNvbmNlcm5lZCBh
Ym91dCB0aGUgcG9zc2liaWxpdHkgb2YgdGltZSBnb2luZyBiYWNrd2FyZHMuwqAgU2VlDQo+ID4g
PiA+ID4gMTYzMTA4N2JhODcyICJSZXZlcnQgIm5mc2Q0OiBzdXBwb3J0IGNoYW5nZV9hdHRyX3R5
cGUNCj4gPiA+ID4gPiBhdHRyaWJ1dGUiIi4NCj4gPiA+ID4gPiBUaGVyZSdzIHNvbWUgbWFpbGlu
ZyBsaXN0IGRpc2N1c3Npb24gdG8gdGhhdCBJJ20gbm90IHR1cm5pbmcNCj4gPiA+ID4gPiB1cA0K
PiA+ID4gPiA+IHJpZ2h0DQo+ID4gPiA+ID4gbm93Lg0KPiA+ID4gDQo+ID4gPiBodHRwczovL2xv
cmUua2VybmVsLm9yZy9saW51eC1uZnMvYTYyOTRjMjVjYjVlYjk4MTkzZjYwOWE1MmFhOGY0YjVk
NGU4MTI3OS5jYW1lbEBoYW1tZXJzcGFjZS5jb20vDQo+ID4gPiBpcyB3aGF0IEkgd2FzIHRoaW5r
aW5nIG9mIGJ1dCBpdCBpc24ndCBhY3R1YWxseSB0aGF0IGludGVyZXN0aW5nLg0KPiA+ID4gDQo+
ID4gPiA+IE15IG1haW4gY29uY2VybiB3YXMgdGhhdCBzb21lIGZpbGVzeXN0ZW1zIChlLmcuIGV4
dDMpIHdlcmUNCj4gPiA+ID4gZmFpbGluZw0KPiA+ID4gPiB0bw0KPiA+ID4gPiBwcm92aWRlIHN1
ZmZpY2llbnQgdGltZXN0YW1wIHJlc29sdXRpb24gdG8gYWN0dWFsbHkgbGFiZWwgdGhlDQo+ID4g
PiA+IHJlc3VsdGluZw0KPiA+ID4gPiAnY2hhbmdlIGF0dHJpYnV0ZScgYXMgYmVpbmcgdXBkYXRl
ZCBtb25vdG9uaWNhbGx5LiBJZiB0aGUgdGltZQ0KPiA+ID4gPiBzdGFtcA0KPiA+ID4gPiBkb2Vz
bid0IGNoYW5nZSB3aGVuIHRoZSBmaWxlIGRhdGEgb3IgbWV0YWRhdGEgYXJlIGNoYW5nZWQsIHRo
ZW4NCj4gPiA+ID4gdGhlDQo+ID4gPiA+IGNsaWVudCBoYXMgdG8gcGVyZm9ybSBleHRyYSBjaGVj
a3MgdG8gdHJ5IHRvIGZpZ3VyZSBvdXQgd2hldGhlcg0KPiA+ID4gPiBvcg0KPiA+ID4gPiBub3QN
Cj4gPiA+ID4gaXRzIGNhY2hlcyBhcmUgdXAgdG8gZGF0ZS4NCj4gPiA+IA0KPiA+ID4gVGhhdCdz
IGEgZGlmZmVyZW50IGlzc3VlIGZyb20gdGhlIG9uZSB5b3Ugd2VyZSByYWlzaW5nIGluIHRoYXQN
Cj4gPiA+IGRpc2N1c3Npb24uDQo+ID4gPiANCj4gPiA+ID4gPiBEaWQgTkZTdjQgYWRkIGNoYW5n
ZV9hdHRyX3R5cGUgYmVjYXVzZSBzb21lIGltcGxlbWVudGF0aW9ucw0KPiA+ID4gPiA+IG5lZWRl
ZA0KPiA+ID4gPiA+IHRoZQ0KPiA+ID4gPiA+IHVub3JkZXJlZCBjYXNlLCBvciBiZWNhdXNlIHRo
ZXkgcmVhbGl6ZWQgb3JkZXJpbmcgd2FzIHVzZWZ1bA0KPiA+ID4gPiA+IGJ1dA0KPiA+ID4gPiA+
IHdhbnRlZA0KPiA+ID4gPiA+IHRvIGtlZXAgYmFja3dhcmRzIGNvbXBhdGliaWxpdHk/wqAgSSBk
b24ndCBrbm93IHdoaWNoIGl0IHdhcy4NCj4gPiA+ID4gDQo+ID4gPiA+IFdlIGltcGxlbWVudGVk
IGl0IGJlY2F1c2UsIGFzIGltcGxpZWQgYWJvdmUsIGtub3dsZWRnZSBvZg0KPiA+ID4gPiB3aGV0
aGVyDQo+ID4gPiA+IG9yDQo+ID4gPiA+IG5vdCB0aGUgY2hhbmdlIGF0dHJpYnV0ZSBiZWhhdmVz
IG1vbm90b25pY2FsbHksIG9yIHN0cmljdGx5DQo+ID4gPiA+IG1vbm90b25pY2FsbHksIGVuYWJs
ZXMgYSBudW1iZXIgb2Ygb3B0aW1pc2F0aW9ucy4NCj4gPiA+IA0KPiA+ID4gT2YgY291cnNlLCBi
dXQgbXkgcXVlc3Rpb24gd2FzIGFib3V0IHRoZSB2YWx1ZSBvZiB0aGUgb2xkDQo+ID4gPiBiZWhh
dmlvciwNCj4gPiA+IG5vdA0KPiA+ID4gYWJvdXQgdGhlIHZhbHVlIG9mIHRoZSBtb25vdG9uaWMg
YmVoYXZpb3IuDQo+ID4gPiANCj4gPiA+IFB1dCBkaWZmZXJlbnRseSwgaWYgd2UgY291bGQgcmVk
ZXNpZ24gdGhlIHByb3RvY29sIGZyb20gc2NyYXRjaA0KPiA+ID4gd291bGQNCj4gPiA+IHdlDQo+
ID4gPiBhY3R1YWxseSBoYXZlIGluY2x1ZGVkIHRoZSBvcHRpb24gb2Ygbm9uLW1vbm90b25pYyBi
ZWhhdmlvcj8NCj4gPiA+IA0KPiA+IA0KPiA+IElmIHdlIGNvdWxkIGRlc2lnbiB0aGUgZmlsZXN5
c3RlbXMgZnJvbSBzY3JhdGNoLCB3ZSBwcm9iYWJseSB3b3VsZA0KPiA+IG5vdC4NCj4gPiBUaGUg
cHJvdG9jb2wgZW5kZWQgdXAgYmVpbmcgYXMgaXQgaXMgYmVjYXVzZSBwZW9wbGUgd2VyZSB0cnlp
bmcgdG8NCj4gPiBtYWtlDQo+ID4gaXQgYXMgZWFzeSB0byBpbXBsZW1lbnQgYXMgcG9zc2libGUu
DQo+ID4gDQo+ID4gU28gaWYgd2UgY291bGQgZGVzaWduIHRoZSBmaWxlc3lzdGVtIGZyb20gc2Ny
YXRjaCwgd2Ugd291bGQgaGF2ZQ0KPiA+IHByb2JhYmx5IGRlc2lnbmVkIGl0IGFsb25nIHRoZSBs
aW5lcyBvZiB3aGF0IEFGUyBkb2VzLg0KPiA+IGkuZS4gZWFjaCBleHBsaWNpdCBjaGFuZ2UgaXMg
YWNjb21wYW5pZWQgYnkgYSBzaW5nbGUgYnVtcCBvZiB0aGUNCj4gPiBjaGFuZ2UNCj4gPiBhdHRy
aWJ1dGUsIHNvIHRoYXQgdGhlIGNsaWVudHMgY2FuIG5vdCBvbmx5IGRlY2lkZSB0aGUgb3JkZXIg
b2YgdGhlDQo+ID4gcmVzdWx0aW5nIGNoYW5nZXMsIGJ1dCBhbHNvIGlmIHRoZXkgaGF2ZSBtaXNz
ZWQgYSBjaGFuZ2UgKHRoYXQNCj4gPiBtaWdodA0KPiA+IGhhdmUgYmVlbiBtYWRlIGJ5IGEgZGlm
ZmVyZW50IGNsaWVudCkuDQo+ID4gDQo+ID4gSG93ZXZlciB0aGF0IHdvdWxkIGJlIGEgcmVxdWly
ZW1lbnQgdGhhdCBpcyBsaWtlbHkgdG8gYmUgdmVyeQ0KPiA+IHNwZWNpZmljDQo+ID4gdG8gZGlz
dHJpYnV0ZWQgY2FjaGVzIChhbmQgaGVuY2UgZGlzdHJpYnV0ZWQgZmlsZXN5c3RlbXMpLiBJIGRv
dWJ0DQo+ID4gdGhlcmUgYXJlIG1hbnkgdXNlciBzcGFjZSBhcHBsaWNhdGlvbnMgdGhhdCB3b3Vs
ZCBuZWVkIHRoYXQgaGlnaA0KPiA+IHByZWNpc2lvbi4gTWF5YmUgTVBJLCBidXQgdGhhdCdzIHRo
ZSBvbmx5IGNhbmRpZGF0ZSBJIGNhbiB0aGluayBvZg0KPiA+IGZvcg0KPiA+IG5vdz8NCj4gPiAN
Cj4gDQo+IFRoZSBmYWN0IHRoYXQgTkZTIGtlcHQgdGhpcyBtb3JlIGxvb3NlbHktZGVmaW5lZCBp
cyB3aGF0IGFsbG93ZWQgdXMNCj4gdG8NCj4gZWxpZGUgc29tZSBvZiB0aGUgaV92ZXJzaW9uIGJ1
bXBzIGFuZCByZWdhaW4gYSBmYWlyIGJpdCBvZg0KPiBwZXJmb3JtYW5jZQ0KPiBmb3IgbG9jYWwg
ZmlsZXN5c3RlbXMgWzFdLiBJZiB0aGUgY2hhbmdlIGF0dHJpYnV0ZSBoYWQgYmVlbiBtb3JlDQo+
IHN0cmljdGx5IGRlZmluZWQgbGlrZSB5b3UgbWVudGlvbiwgdGhlbiB0aGF0IHBhcnRpY3VsYXIg
b3B0aW1pemF0aW9uDQo+IHdvdWxkIG5vdCBoYXZlIGJlZW4gcG9zc2libGUuDQo+IA0KPiBUaGlz
IHNvcnQgb2YgdGhpbmcgaXMgd2h5IEknbSBhIGZhbiBvZiBub3QgZGVmaW5pbmcgdGhpcyBhbnkg
bW9yZQ0KPiBzdHJpY3RseSB0aGFuIHdlIHJlcXVpcmUuIExhdGVyIG9uLCBtYXliZSB3ZSdsbCBj
b21lIHVwIHdpdGggYSB3YXkNCj4gZm9yDQo+IGZpbGVzeXN0ZW1zIHRvIGFkdmVydGlzZSB0aGF0
IHRoZXkgY2FuIG9mZmVyIHN0cm9uZ2VyIGd1YXJhbnRlZXMuDQoNCldoYXQgJ2VsaWRpbmcgb2Yg
dGhlIGJ1bXBzJyBhcmUgd2UgdGFsa2luZyBhYm91dCBoZXJlPyBJZiBpdCByZXN1bHRzIGluDQp1
bnJlbGlhYmxlIGJlaGF2aW91ciwgdGhlbiBJIHByb3Bvc2Ugd2UganVzdCBkcm9wIHRoZSB3aG9s
ZSBjb25jZXB0IGFuZA0KZ28gYmFjayB0byB1c2luZyB0aGUgY3RpbWUuIFRoZSBjaGFuZ2UgYXR0
cmlidXRlIGlzIG9ubHkgdXNlZnVsIGlmIGl0DQpyZXN1bHRzIGluIGEgcmVsaWFibGUgbWVjaGFu
aXNtIGZvciBkZXRlY3RpbmcgY2hhbmdlcy4gT25jZSB5b3UgImVsaWRlDQphd2F5IiB0aGUgd29y
ZCAicmVsaWFibGUiLCB0aGVuIGl0IGhhcyBubyB2YWx1ZSBiZXlvbmQgd2hhdCBjdGltZQ0KYWxy
ZWFkeSBkb2VzLg0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWlu
dGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoN
Cg==
