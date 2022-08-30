Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B21B5A6C0B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Aug 2022 20:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbiH3SZU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Aug 2022 14:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbiH3SZS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Aug 2022 14:25:18 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2126.outbound.protection.outlook.com [40.107.100.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE2CE2A73D;
        Tue, 30 Aug 2022 11:25:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CLJzNmpu7w8uENfofYRE1eMCD2aFh6MWJ0Am8ESkanl20WcbojllVRthyLpIbNYY32o/rTfgSKRVQ+a13hJDtf4XIoxwoM3IrATeXUWOxmMKlIdb4XWPgtWHeyJ2jRH+H4/nbFitGj408NzhGdZ+yAraL0QmKZDVpr9UFtKQ9+wThVWRlxZktNHAfWcJ2oP5gh4SaS1jz0+XgvxWa4F4iv9MM4Ofos5a8+Cnm1+LYYxFrOLLnwmKSVnwz/cOYZi2BFC8wXVMSGPUYai/v+ErutgIs9+qHmRTdNoIOabWcleYhMT6mjdvBJ5yHqumWF8Ms/cHHoja5glGxsRkLZ9iNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lO7OgpIoxTVkiNCYsmLOxphbwfKbRonCwPUu7BlbyyU=;
 b=kFnVX5QVL/F0RQqkREekPKjT2wMa+71yjyvdIPVmhP77Ck4HT1UAPaOj8NqP8ZTYbeY5n1xIp33JVEV9hBaALw5vyFf4ds5VLHMuKcqDx/D0zUnGhwM/whh2IJRwa2oObDVFOt5abWo69MNGfbok9K3ZYFAsBU3I+yHW4kpv6y9m2509qawCf83awXeEuBRXFG7TJjPJ+GCCXbYcn5oHQ2wDymrwzAn+u6woVfFk6bX5mHOC14A/v8KSNqStRUbW9R/TN62RaeMRB2u0R49CSQiNgf6vLkrh+H5jxlyg19ZCPH8SK8hhfx2B8xQdykMqMt0oD8AiUPYUurOODEEDeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lO7OgpIoxTVkiNCYsmLOxphbwfKbRonCwPUu7BlbyyU=;
 b=KwO/GyNovfSF9eopC7gtNJ1JKFUcYREyqNrcwvXGuOXWnYiJTWcdwg4qhlvmw0iTKNQhqAcXtRq4B409XZyBSHMnXgt/YPmDKdJ/UrQA1WzD3id/IRfrd3euBUiKIQUquihivur4V0b+jTp7aJAZ+j2N5u9ioTo95FFfQuEL4es=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by MW4PR13MB5861.namprd13.prod.outlook.com (2603:10b6:303:1b4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Tue, 30 Aug
 2022 18:25:12 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::f1c7:62d0:a63d:f5ca]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::f1c7:62d0:a63d:f5ca%3]) with mapi id 15.20.5588.010; Tue, 30 Aug 2022
 18:25:12 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bfields@fieldses.org" <bfields@fieldses.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>
CC:     "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "xiubli@redhat.com" <xiubli@redhat.com>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "neilb@suse.de" <neilb@suse.de>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
        "linux-ceph@vger.kernel.org" <linux-ceph@vger.kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "tytso@mit.edu" <tytso@mit.edu>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "jack@suse.cz" <jack@suse.cz>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "lczerner@redhat.com" <lczerner@redhat.com>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "walters@verbum.org" <walters@verbum.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v3 1/7] iversion: update comments with info about atime
 updates
Thread-Topic: [PATCH v3 1/7] iversion: update comments with info about atime
 updates
Thread-Index: AQHYuZVnsRGFuLc+aUSHryeVbtc1Ya3FhqCAgAAtUwCAAM6GgIAA1NcAgAAdQICAAAcSAIAADzgAgAAD2QCAAAVOgIAABzCAgAAWUACAAAxZAIAAAcoAgAAI3QA=
Date:   Tue, 30 Aug 2022 18:25:12 +0000
Message-ID: <a7a5a9acbe88d8ebcfd7074bf663359f1647cafc.camel@hammerspace.com>
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
         <5fd1f7e99d5ab87db48c8c3603b014c1c2d2ec5a.camel@hammerspace.com>
         <5f194ec391498f18602f75126d78bfe21132ecea.camel@kernel.org>
In-Reply-To: <5f194ec391498f18602f75126d78bfe21132ecea.camel@kernel.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ebbae332-47ff-4d26-fc0b-08da8ab4fa60
x-ms-traffictypediagnostic: MW4PR13MB5861:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BaRmB1HlxFVVRkTZguTjHCt3BmOL+VGh4C6knQ0u+HdTnPMNgFMzXnEp+f6jtwa/0WiDkM9j92E7K9loZpROZ88RPzqeEVs2Xgg1cjxq9k9ehDHGDL48x70b2x+B2wIL5gQUOr0a9lCFq0EtAKiumWFJlE19PxEFHPt9cLq+68QkShso1+XE4rThGd6X7I/uPHSfU9RL3TB/IHno05Wp0/0VZbea6469n8IxJNhNRQjphvjx7JZSjuC52HqU+AdYbuyNvp+x2yWks3n2GURecacOFtbWlFrA6w6Uvtx6D4ix9kyt5qvKhuDPMHGnVoNNVnHVgm3pO3oMXlKXhPyANpGwaOpO0UavcDbHy1oIMujIJbsOcna5OAyCwngpcGbdXEemfklVoTFKBUFyeDG0dlADznWbcB2RPO9oYBTcgTKrBykb0Gc0iNgU2YURxdd0rVADhAWyMZQ74ME9FWxLiJCzGk6SlALEdtG3eyLC3+CLNnUjWET/r6ajtKMQsORyih4YbXl7rg3KZMz/pi3tk7pnUALg8JFhjynZ8HfPjxdTgqZ0x3YfvNWdC8caM6up1C6e8C5VJKLzQ2+sD/vaFG9AfjwTUYq0FSKT7dqrGMh7kJlTeGrRptUc4crr/nxsm+trCFEskA2/v+6kVrTkSS777tRIPWUsKpIawcQS6ShzsvyXj60aXdX3aTlyoiPtYkAro6KNUYfcxQlagYUX6wOrFBF8qsL7hyFix74IQExOMbWuCgenyBndT+hYkVjfvt/QbHTyqdUaDcdKY+OaDV6XogFCyw3CSIFW94Z6pZ8aH+C+drmrF7PJcQqvR1DibtvIEbs5C4XcBCw29eXvCg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(396003)(39840400004)(136003)(376002)(346002)(66556008)(316002)(110136005)(54906003)(966005)(6486002)(66476007)(64756008)(6506007)(15650500001)(66446008)(2906002)(8676002)(66946007)(76116006)(71200400001)(4326008)(2616005)(36756003)(83380400001)(186003)(26005)(122000001)(38100700002)(41300700001)(6512007)(478600001)(8936002)(38070700005)(5660300002)(86362001)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T1Exek1HUFRiZWlZeC9qTnBMRm5ZamRGQ0NUUjI0Zk9WcVY4ZmlwOXZJUGpJ?=
 =?utf-8?B?enozOFo3YjBCbG9PRGtYZUN6KzB0R2wvRE8zK2crbGFNcXBhaDRrK0tDdVRC?=
 =?utf-8?B?VTRpMFREVU5RQ0Y1b0RZUjNtcHFYZjh0NU4yODhLa21RcmFSWGtIcVhwdmNR?=
 =?utf-8?B?Y0FaL1B1ajJKZ0FKSnkzYk92eklFaWR3SExhbEQ2TkQ5WkRsU1ZvKzlFY3ZL?=
 =?utf-8?B?enVBL3d3YkZjd2U5Z1pNVVZ2MXF2MUR3Q3hVUllpT1htK1BwcHU4TE0rY3U3?=
 =?utf-8?B?UWkvRTRrbXVjMlNiSXNUOTFZWVYrdzBQMVNycWdiN25ZNjFYRTlYb0JMWXQx?=
 =?utf-8?B?alJ3OXlNMnJ4NUxXNnZXaS82MzVPemU0SDJvNkEyTVExbTZSV3ZLWmdHWFZ3?=
 =?utf-8?B?ZlRNYlhURWdOd1pyL0hVRFZxS3hYTHVJM05GQVFzdVQzaHVRajI3eVFCdXNv?=
 =?utf-8?B?Ymk4TjY4c0thejZIbU84cU10akFxV3hzMXN3dTB5TFJhQXFHemdFajlEM0U0?=
 =?utf-8?B?NmgwUkxGNktXWTkxQS9sRXBiZGs1OUJuWEFLdEZOR1VLdW1jMW5KeFdMM0dj?=
 =?utf-8?B?UHhyM0ZUWGU0VmdhdFNQdUpTOFMwNEJVTkN4emlXcVgwT0ZTMzBFTWRpQ1do?=
 =?utf-8?B?QTloUHpNbXNKUXo0YmFYMGlMbGYrQnlYTFVXSUcrajV2Q3ZBdk1xaWRYMmg5?=
 =?utf-8?B?WHl2cFA3RDNNYXhVU2lGRUFlQk9ZcFpXU2ZTNERTNHBFOXB1Q2xJL0RmS0Zr?=
 =?utf-8?B?ZGZrWE1hOUN5Wlh1Vk4rcWZMNUFoOUFlVTZUVkNRL1NiMmk5c1ZFYWNGWXRM?=
 =?utf-8?B?RjRyNzVyS3hjTUpPeVdYVTBrRjFlZzFXcWlyekhBQXM3V29UZm53OVZ3Y1B1?=
 =?utf-8?B?L0l0T1o5UngyLy9wUVUyUitGMDVtUFpEbTIwOGNBT0tobUl0Wk1jZmtUY3pU?=
 =?utf-8?B?QzVNRGxTdTdlZnRUd2VhUktybkxBcEdaNCtxZGx3bnRHZWV1QnNMWkZveDVK?=
 =?utf-8?B?TlRtdzArMWVURVBvb2E0Rm9Zd1hwRWlFSThKMGZUYStyS1FwVzFlM0tMSWNy?=
 =?utf-8?B?a2txOGJRRlF2dHFPTVNNQzVycU0zb1hVWlRCaHA1aHFpTEU5WDlOclp3aGRx?=
 =?utf-8?B?YXFrRGlVQkY3eE83YXNQdEs2T3k1b1pFUkJhY2RDUlpTTFNHWlU2aWRPOURU?=
 =?utf-8?B?T3loVFFtS2JxclVmUS8yT012Q3NxWjAzZ0tTOElmUmNULy9kZkhTMFFaNmVQ?=
 =?utf-8?B?L2x3T1dDWGM1VHF0MVhZUFNoQm5SV0JTRllmQ2R3UDdJYTBVcklIMm90V1l3?=
 =?utf-8?B?N3BUY2t1NE52anVHVCttUVlUNEJMcUs5cCtxb1ZROWtoeGRxb0dBdS96eXNO?=
 =?utf-8?B?YmtqZjB1UWFHY3dIc0Y5eG9aWFVDa2xydXFqVzVrZmwrT05pNzdVK1NCZ2Vo?=
 =?utf-8?B?MzVOZVRhQ3lIWXlNS01iVUFLOU5PbFY5Q1ZPR0d6S2JzUjZBckRFbEpuTFUy?=
 =?utf-8?B?dFJmMzBLdGxGOWtIZ3RlV3dMTkRubU0rQTNINVZ2K083enJrS3lONEpRUWV0?=
 =?utf-8?B?ZVpTRVZRZy9VajRzdHJZUStsZjBYN2t3Z2FmR3dvd0d4NlU1YkVZNTZic1Fo?=
 =?utf-8?B?ODJ3YllGWUVLdWpwazJhdUxmelhmVmdvYkFCbUJrejlUZ2x0NGtvZEpDUXBZ?=
 =?utf-8?B?SjBxaG1NcHVNQ3FTeFdKZ0xodHNvaDBXYTRLbUhPc2QrblowYjVyWnk4Ymg5?=
 =?utf-8?B?UGFpVXYvSElDcjhKMllmVlZqTnhaTHdwQ1ZZZVFGYkMzd1F1VUNTT2hIWVVI?=
 =?utf-8?B?MFkxRWxRaHNob0FRTUVLZkpIeDIyY2NydU00V3BIMWhPSGkrOXgyVlJ4L0ww?=
 =?utf-8?B?Ukg5TWRuK2xoTHdoeDhjNm1UVUp1ZTd5U1U0VHpSdXY2ZjhmU1NSZGdrelVt?=
 =?utf-8?B?ZGlFZWh5Mk9zWUlhbFVCeVBqYW40c0diaVRmamFTRnRQNjJ6MG11NWxqVFpl?=
 =?utf-8?B?elphMERzY0wxdEhuYjlhTXhVajhGT1AvK1grRVI3NzNZTXc4WXpob1lEV1Yx?=
 =?utf-8?B?MWVIMHRCY2pDbnhib3JjWWlDSkZBaVdXbkxrWStJNFZyRlpZcWhpVWZGUWFU?=
 =?utf-8?B?RVRYNUMyaG4zM1I0UTFIN1dLc2NGNW1HOEdnRnpXdU1LK1lyZHphdXhtSUJq?=
 =?utf-8?B?Umc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AE2A99DEC2C99C49AD966CB8D555DA5B@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebbae332-47ff-4d26-fc0b-08da8ab4fa60
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2022 18:25:12.5127
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8Zb36uDfeEN3G2imf7TAem4Mgo5eYii6qZQIzQGtYudZ1yFfmDI0BxTwVqTOrS0PpJlXUcdadg2BnL60HLYApA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR13MB5861
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gVHVlLCAyMDIyLTA4LTMwIGF0IDEzOjUzIC0wNDAwLCBKZWZmIExheXRvbiB3cm90ZToNCj4g
T24gVHVlLCAyMDIyLTA4LTMwIGF0IDE3OjQ3ICswMDAwLCBUcm9uZCBNeWtsZWJ1c3Qgd3JvdGU6
DQo+ID4gT24gVHVlLCAyMDIyLTA4LTMwIGF0IDEzOjAyIC0wNDAwLCBKZWZmIExheXRvbiB3cm90
ZToNCj4gPiA+IE9uIFR1ZSwgMjAyMi0wOC0zMCBhdCAxNTo0MyArMDAwMCwgVHJvbmQgTXlrbGVi
dXN0IHdyb3RlOg0KPiA+ID4gPiBPbiBUdWUsIDIwMjItMDgtMzAgYXQgMTE6MTcgLTA0MDAsIEou
IEJydWNlIEZpZWxkcyB3cm90ZToNCj4gPiA+ID4gPiBPbiBUdWUsIEF1ZyAzMCwgMjAyMiBhdCAw
Mjo1ODoyN1BNICswMDAwLCBUcm9uZCBNeWtsZWJ1c3QNCj4gPiA+ID4gPiB3cm90ZToNCj4gPiA+
ID4gPiA+IE9uIFR1ZSwgMjAyMi0wOC0zMCBhdCAxMDo0NCAtMDQwMCwgSi4gQnJ1Y2UgRmllbGRz
IHdyb3RlOg0KPiA+ID4gPiA+ID4gPiBPbiBUdWUsIEF1ZyAzMCwgMjAyMiBhdCAwOTo1MDowMkFN
IC0wNDAwLCBKZWZmIExheXRvbg0KPiA+ID4gPiA+ID4gPiB3cm90ZToNCj4gPiA+ID4gPiA+ID4g
PiBPbiBUdWUsIDIwMjItMDgtMzAgYXQgMDk6MjQgLTA0MDAsIEouIEJydWNlIEZpZWxkcw0KPiA+
ID4gPiA+ID4gPiA+IHdyb3RlOg0KPiA+ID4gPiA+ID4gPiA+ID4gT24gVHVlLCBBdWcgMzAsIDIw
MjIgYXQgMDc6NDA6MDJBTSAtMDQwMCwgSmVmZiBMYXl0b24NCj4gPiA+ID4gPiA+ID4gPiA+IHdy
b3RlOg0KPiA+ID4gPiA+ID4gPiA+ID4gPiBZZXMsIHNheWluZyBvbmx5IHRoYXQgaXQgbXVzdCBi
ZSBkaWZmZXJlbnQgaXMNCj4gPiA+ID4gPiA+ID4gPiA+ID4gaW50ZW50aW9uYWwuDQo+ID4gPiA+
ID4gPiA+ID4gPiA+IFdoYXQNCj4gPiA+ID4gPiA+ID4gPiA+ID4gd2UNCj4gPiA+ID4gPiA+ID4g
PiA+ID4gcmVhbGx5IHdhbnQgaXMgZm9yIGNvbnN1bWVycyB0byB0cmVhdCB0aGlzIGFzIGFuDQo+
ID4gPiA+ID4gPiA+ID4gPiA+IG9wYXF1ZQ0KPiA+ID4gPiA+ID4gPiA+ID4gPiB2YWx1ZQ0KPiA+
ID4gPiA+ID4gPiA+ID4gPiBmb3IgdGhlDQo+ID4gPiA+ID4gPiA+ID4gPiA+IG1vc3QgcGFydCBb
MV0uIFRoZXJlZm9yZSBhbiBpbXBsZW1lbnRhdGlvbiBiYXNlZCBvbg0KPiA+ID4gPiA+ID4gPiA+
ID4gPiBoYXNoaW5nDQo+ID4gPiA+ID4gPiA+ID4gPiA+IHdvdWxkDQo+ID4gPiA+ID4gPiA+ID4g
PiA+IGNvbmZvcm0gdG8gdGhlIHNwZWMsIEknZCB0aGluaywgYXMgbG9uZyBhcyBhbGwgb2YNCj4g
PiA+ID4gPiA+ID4gPiA+ID4gdGhlDQo+ID4gPiA+ID4gPiA+ID4gPiA+IHJlbGV2YW50DQo+ID4g
PiA+ID4gPiA+ID4gPiA+IGluZm8gaXMNCj4gPiA+ID4gPiA+ID4gPiA+ID4gcGFydCBvZiB0aGUg
aGFzaC4NCj4gPiA+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiA+ID4gSXQnZCBjb25mb3Jt
LCBidXQgaXQgbWlnaHQgbm90IGJlIGFzIHVzZWZ1bCBhcyBhbg0KPiA+ID4gPiA+ID4gPiA+ID4g
aW5jcmVhc2luZw0KPiA+ID4gPiA+ID4gPiA+ID4gdmFsdWUuDQo+ID4gPiA+ID4gPiA+ID4gPiAN
Cj4gPiA+ID4gPiA+ID4gPiA+IEUuZy4gYSBjbGllbnQgY2FuIHVzZSB0aGF0IHRvIHdvcmsgb3V0
IHdoaWNoIG9mIGENCj4gPiA+ID4gPiA+ID4gPiA+IHNlcmllcw0KPiA+ID4gPiA+ID4gPiA+ID4g
b2YNCj4gPiA+ID4gPiA+ID4gPiA+IHJlb3JkZXJlZA0KPiA+ID4gPiA+ID4gPiA+ID4gd3JpdGUg
cmVwbGllcyBpcyB0aGUgbW9zdCByZWNlbnQsIGFuZCBJIHNlZW0gdG8NCj4gPiA+ID4gPiA+ID4g
PiA+IHJlY2FsbA0KPiA+ID4gPiA+ID4gPiA+ID4gdGhhdA0KPiA+ID4gPiA+ID4gPiA+ID4gY2Fu
DQo+ID4gPiA+ID4gPiA+ID4gPiBwcmV2ZW50DQo+ID4gPiA+ID4gPiA+ID4gPiB1bm5lY2Vzc2Fy
eSBpbnZhbGlkYXRpb25zIGluIHNvbWUgY2FzZXMuDQo+ID4gPiA+ID4gPiA+ID4gPiANCj4gPiA+
ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gPiBUaGF0J3MgYSBnb29kIHBvaW50OyB0aGUgbGlu
dXggY2xpZW50IGRvZXMgdGhpcy4gVGhhdA0KPiA+ID4gPiA+ID4gPiA+IHNhaWQsDQo+ID4gPiA+
ID4gPiA+ID4gTkZTdjQNCj4gPiA+ID4gPiA+ID4gPiBoYXMgYQ0KPiA+ID4gPiA+ID4gPiA+IHdh
eSBmb3IgdGhlIHNlcnZlciB0byBhZHZlcnRpc2UgaXRzIGNoYW5nZSBhdHRyaWJ1dGUNCj4gPiA+
ID4gPiA+ID4gPiBiZWhhdmlvcg0KPiA+ID4gPiA+ID4gPiA+IFsxXQ0KPiA+ID4gPiA+ID4gPiA+
ICh0aG91Z2ggbmZzZCBoYXNuJ3QgaW1wbGVtZW50ZWQgdGhpcyB5ZXQpLg0KPiA+ID4gPiA+ID4g
PiANCj4gPiA+ID4gPiA+ID4gSXQgd2FzIGltcGxlbWVudGVkIGFuZCByZXZlcnRlZC7CoCBUaGUg
aXNzdWUgd2FzIHRoYXQgSQ0KPiA+ID4gPiA+ID4gPiB0aG91Z2h0DQo+ID4gPiA+ID4gPiA+IG5m
c2QNCj4gPiA+ID4gPiA+ID4gc2hvdWxkIG1peCBpbiB0aGUgY3RpbWUgdG8gcHJldmVudCB0aGUg
Y2hhbmdlIGF0dHJpYnV0ZQ0KPiA+ID4gPiA+ID4gPiBnb2luZw0KPiA+ID4gPiA+ID4gPiBiYWNr
d2FyZHMNCj4gPiA+ID4gPiA+ID4gb24gcmVib290IChzZWUgZnMvbmZzZC9uZnNmaC5oOm5mc2Q0
X2NoYW5nZV9hdHRyaWJ1dGUoKSksDQo+ID4gPiA+ID4gPiA+IGJ1dA0KPiA+ID4gPiA+ID4gPiBU
cm9uZA0KPiA+ID4gPiA+ID4gPiB3YXMNCj4gPiA+ID4gPiA+ID4gY29uY2VybmVkIGFib3V0IHRo
ZSBwb3NzaWJpbGl0eSBvZiB0aW1lIGdvaW5nIGJhY2t3YXJkcy7CoA0KPiA+ID4gPiA+ID4gPiBT
ZWUNCj4gPiA+ID4gPiA+ID4gMTYzMTA4N2JhODcyICJSZXZlcnQgIm5mc2Q0OiBzdXBwb3J0IGNo
YW5nZV9hdHRyX3R5cGUNCj4gPiA+ID4gPiA+ID4gYXR0cmlidXRlIiIuDQo+ID4gPiA+ID4gPiA+
IFRoZXJlJ3Mgc29tZSBtYWlsaW5nIGxpc3QgZGlzY3Vzc2lvbiB0byB0aGF0IEknbSBub3QNCj4g
PiA+ID4gPiA+ID4gdHVybmluZw0KPiA+ID4gPiA+ID4gPiB1cA0KPiA+ID4gPiA+ID4gPiByaWdo
dA0KPiA+ID4gPiA+ID4gPiBub3cuDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvbGludXgtbmZzL2E2Mjk0YzI1Y2I1ZWI5ODE5M2Y2MDlhNTJhYThmNGI1ZDRl
ODEyNzkuY2FtZWxAaGFtbWVyc3BhY2UuY29tLw0KPiA+ID4gPiA+IGlzIHdoYXQgSSB3YXMgdGhp
bmtpbmcgb2YgYnV0IGl0IGlzbid0IGFjdHVhbGx5IHRoYXQNCj4gPiA+ID4gPiBpbnRlcmVzdGlu
Zy4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IE15IG1haW4gY29uY2VybiB3YXMgdGhhdCBzb21l
IGZpbGVzeXN0ZW1zIChlLmcuIGV4dDMpIHdlcmUNCj4gPiA+ID4gPiA+IGZhaWxpbmcNCj4gPiA+
ID4gPiA+IHRvDQo+ID4gPiA+ID4gPiBwcm92aWRlIHN1ZmZpY2llbnQgdGltZXN0YW1wIHJlc29s
dXRpb24gdG8gYWN0dWFsbHkgbGFiZWwNCj4gPiA+ID4gPiA+IHRoZQ0KPiA+ID4gPiA+ID4gcmVz
dWx0aW5nDQo+ID4gPiA+ID4gPiAnY2hhbmdlIGF0dHJpYnV0ZScgYXMgYmVpbmcgdXBkYXRlZCBt
b25vdG9uaWNhbGx5LiBJZiB0aGUNCj4gPiA+ID4gPiA+IHRpbWUNCj4gPiA+ID4gPiA+IHN0YW1w
DQo+ID4gPiA+ID4gPiBkb2Vzbid0IGNoYW5nZSB3aGVuIHRoZSBmaWxlIGRhdGEgb3IgbWV0YWRh
dGEgYXJlIGNoYW5nZWQsDQo+ID4gPiA+ID4gPiB0aGVuDQo+ID4gPiA+ID4gPiB0aGUNCj4gPiA+
ID4gPiA+IGNsaWVudCBoYXMgdG8gcGVyZm9ybSBleHRyYSBjaGVja3MgdG8gdHJ5IHRvIGZpZ3Vy
ZSBvdXQNCj4gPiA+ID4gPiA+IHdoZXRoZXINCj4gPiA+ID4gPiA+IG9yDQo+ID4gPiA+ID4gPiBu
b3QNCj4gPiA+ID4gPiA+IGl0cyBjYWNoZXMgYXJlIHVwIHRvIGRhdGUuDQo+ID4gPiA+ID4gDQo+
ID4gPiA+ID4gVGhhdCdzIGEgZGlmZmVyZW50IGlzc3VlIGZyb20gdGhlIG9uZSB5b3Ugd2VyZSBy
YWlzaW5nIGluDQo+ID4gPiA+ID4gdGhhdA0KPiA+ID4gPiA+IGRpc2N1c3Npb24uDQo+ID4gPiA+
ID4gDQo+ID4gPiA+ID4gPiA+IERpZCBORlN2NCBhZGQgY2hhbmdlX2F0dHJfdHlwZSBiZWNhdXNl
IHNvbWUNCj4gPiA+ID4gPiA+ID4gaW1wbGVtZW50YXRpb25zDQo+ID4gPiA+ID4gPiA+IG5lZWRl
ZA0KPiA+ID4gPiA+ID4gPiB0aGUNCj4gPiA+ID4gPiA+ID4gdW5vcmRlcmVkIGNhc2UsIG9yIGJl
Y2F1c2UgdGhleSByZWFsaXplZCBvcmRlcmluZyB3YXMNCj4gPiA+ID4gPiA+ID4gdXNlZnVsDQo+
ID4gPiA+ID4gPiA+IGJ1dA0KPiA+ID4gPiA+ID4gPiB3YW50ZWQNCj4gPiA+ID4gPiA+ID4gdG8g
a2VlcCBiYWNrd2FyZHMgY29tcGF0aWJpbGl0eT/CoCBJIGRvbid0IGtub3cgd2hpY2ggaXQNCj4g
PiA+ID4gPiA+ID4gd2FzLg0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBXZSBpbXBsZW1lbnRl
ZCBpdCBiZWNhdXNlLCBhcyBpbXBsaWVkIGFib3ZlLCBrbm93bGVkZ2Ugb2YNCj4gPiA+ID4gPiA+
IHdoZXRoZXINCj4gPiA+ID4gPiA+IG9yDQo+ID4gPiA+ID4gPiBub3QgdGhlIGNoYW5nZSBhdHRy
aWJ1dGUgYmVoYXZlcyBtb25vdG9uaWNhbGx5LCBvciBzdHJpY3RseQ0KPiA+ID4gPiA+ID4gbW9u
b3RvbmljYWxseSwgZW5hYmxlcyBhIG51bWJlciBvZiBvcHRpbWlzYXRpb25zLg0KPiA+ID4gPiA+
IA0KPiA+ID4gPiA+IE9mIGNvdXJzZSwgYnV0IG15IHF1ZXN0aW9uIHdhcyBhYm91dCB0aGUgdmFs
dWUgb2YgdGhlIG9sZA0KPiA+ID4gPiA+IGJlaGF2aW9yLA0KPiA+ID4gPiA+IG5vdA0KPiA+ID4g
PiA+IGFib3V0IHRoZSB2YWx1ZSBvZiB0aGUgbW9ub3RvbmljIGJlaGF2aW9yLg0KPiA+ID4gPiA+
IA0KPiA+ID4gPiA+IFB1dCBkaWZmZXJlbnRseSwgaWYgd2UgY291bGQgcmVkZXNpZ24gdGhlIHBy
b3RvY29sIGZyb20NCj4gPiA+ID4gPiBzY3JhdGNoDQo+ID4gPiA+ID4gd291bGQNCj4gPiA+ID4g
PiB3ZQ0KPiA+ID4gPiA+IGFjdHVhbGx5IGhhdmUgaW5jbHVkZWQgdGhlIG9wdGlvbiBvZiBub24t
bW9ub3RvbmljIGJlaGF2aW9yPw0KPiA+ID4gPiA+IA0KPiA+ID4gPiANCj4gPiA+ID4gSWYgd2Ug
Y291bGQgZGVzaWduIHRoZSBmaWxlc3lzdGVtcyBmcm9tIHNjcmF0Y2gsIHdlIHByb2JhYmx5DQo+
ID4gPiA+IHdvdWxkDQo+ID4gPiA+IG5vdC4NCj4gPiA+ID4gVGhlIHByb3RvY29sIGVuZGVkIHVw
IGJlaW5nIGFzIGl0IGlzIGJlY2F1c2UgcGVvcGxlIHdlcmUgdHJ5aW5nDQo+ID4gPiA+IHRvDQo+
ID4gPiA+IG1ha2UNCj4gPiA+ID4gaXQgYXMgZWFzeSB0byBpbXBsZW1lbnQgYXMgcG9zc2libGUu
DQo+ID4gPiA+IA0KPiA+ID4gPiBTbyBpZiB3ZSBjb3VsZCBkZXNpZ24gdGhlIGZpbGVzeXN0ZW0g
ZnJvbSBzY3JhdGNoLCB3ZSB3b3VsZA0KPiA+ID4gPiBoYXZlDQo+ID4gPiA+IHByb2JhYmx5IGRl
c2lnbmVkIGl0IGFsb25nIHRoZSBsaW5lcyBvZiB3aGF0IEFGUyBkb2VzLg0KPiA+ID4gPiBpLmUu
IGVhY2ggZXhwbGljaXQgY2hhbmdlIGlzIGFjY29tcGFuaWVkIGJ5IGEgc2luZ2xlIGJ1bXAgb2YN
Cj4gPiA+ID4gdGhlDQo+ID4gPiA+IGNoYW5nZQ0KPiA+ID4gPiBhdHRyaWJ1dGUsIHNvIHRoYXQg
dGhlIGNsaWVudHMgY2FuIG5vdCBvbmx5IGRlY2lkZSB0aGUgb3JkZXIgb2YNCj4gPiA+ID4gdGhl
DQo+ID4gPiA+IHJlc3VsdGluZyBjaGFuZ2VzLCBidXQgYWxzbyBpZiB0aGV5IGhhdmUgbWlzc2Vk
IGEgY2hhbmdlICh0aGF0DQo+ID4gPiA+IG1pZ2h0DQo+ID4gPiA+IGhhdmUgYmVlbiBtYWRlIGJ5
IGEgZGlmZmVyZW50IGNsaWVudCkuDQo+ID4gPiA+IA0KPiA+ID4gPiBIb3dldmVyIHRoYXQgd291
bGQgYmUgYSByZXF1aXJlbWVudCB0aGF0IGlzIGxpa2VseSB0byBiZSB2ZXJ5DQo+ID4gPiA+IHNw
ZWNpZmljDQo+ID4gPiA+IHRvIGRpc3RyaWJ1dGVkIGNhY2hlcyAoYW5kIGhlbmNlIGRpc3RyaWJ1
dGVkIGZpbGVzeXN0ZW1zKS4gSQ0KPiA+ID4gPiBkb3VidA0KPiA+ID4gPiB0aGVyZSBhcmUgbWFu
eSB1c2VyIHNwYWNlIGFwcGxpY2F0aW9ucyB0aGF0IHdvdWxkIG5lZWQgdGhhdA0KPiA+ID4gPiBo
aWdoDQo+ID4gPiA+IHByZWNpc2lvbi4gTWF5YmUgTVBJLCBidXQgdGhhdCdzIHRoZSBvbmx5IGNh
bmRpZGF0ZSBJIGNhbiB0aGluaw0KPiA+ID4gPiBvZg0KPiA+ID4gPiBmb3INCj4gPiA+ID4gbm93
Pw0KPiA+ID4gPiANCj4gPiA+IA0KPiA+ID4gVGhlIGZhY3QgdGhhdCBORlMga2VwdCB0aGlzIG1v
cmUgbG9vc2VseS1kZWZpbmVkIGlzIHdoYXQgYWxsb3dlZA0KPiA+ID4gdXMNCj4gPiA+IHRvDQo+
ID4gPiBlbGlkZSBzb21lIG9mIHRoZSBpX3ZlcnNpb24gYnVtcHMgYW5kIHJlZ2FpbiBhIGZhaXIg
Yml0IG9mDQo+ID4gPiBwZXJmb3JtYW5jZQ0KPiA+ID4gZm9yIGxvY2FsIGZpbGVzeXN0ZW1zIFsx
XS4gSWYgdGhlIGNoYW5nZSBhdHRyaWJ1dGUgaGFkIGJlZW4gbW9yZQ0KPiA+ID4gc3RyaWN0bHkg
ZGVmaW5lZCBsaWtlIHlvdSBtZW50aW9uLCB0aGVuIHRoYXQgcGFydGljdWxhcg0KPiA+ID4gb3B0
aW1pemF0aW9uDQo+ID4gPiB3b3VsZCBub3QgaGF2ZSBiZWVuIHBvc3NpYmxlLg0KPiA+ID4gDQo+
ID4gPiBUaGlzIHNvcnQgb2YgdGhpbmcgaXMgd2h5IEknbSBhIGZhbiBvZiBub3QgZGVmaW5pbmcg
dGhpcyBhbnkgbW9yZQ0KPiA+ID4gc3RyaWN0bHkgdGhhbiB3ZSByZXF1aXJlLiBMYXRlciBvbiwg
bWF5YmUgd2UnbGwgY29tZSB1cCB3aXRoIGENCj4gPiA+IHdheQ0KPiA+ID4gZm9yDQo+ID4gPiBm
aWxlc3lzdGVtcyB0byBhZHZlcnRpc2UgdGhhdCB0aGV5IGNhbiBvZmZlciBzdHJvbmdlciBndWFy
YW50ZWVzLg0KPiA+IA0KPiA+IFdoYXQgJ2VsaWRpbmcgb2YgdGhlIGJ1bXBzJyBhcmUgd2UgdGFs
a2luZyBhYm91dCBoZXJlPyBJZiBpdA0KPiA+IHJlc3VsdHMgaW4NCj4gPiB1bnJlbGlhYmxlIGJl
aGF2aW91ciwgdGhlbiBJIHByb3Bvc2Ugd2UganVzdCBkcm9wIHRoZSB3aG9sZSBjb25jZXB0DQo+
ID4gYW5kDQo+ID4gZ28gYmFjayB0byB1c2luZyB0aGUgY3RpbWUuIFRoZSBjaGFuZ2UgYXR0cmli
dXRlIGlzIG9ubHkgdXNlZnVsIGlmDQo+ID4gaXQNCj4gPiByZXN1bHRzIGluIGEgcmVsaWFibGUg
bWVjaGFuaXNtIGZvciBkZXRlY3RpbmcgY2hhbmdlcy4gT25jZSB5b3UNCj4gPiAiZWxpZGUNCj4g
PiBhd2F5IiB0aGUgd29yZCAicmVsaWFibGUiLCB0aGVuIGl0IGhhcyBubyB2YWx1ZSBiZXlvbmQg
d2hhdCBjdGltZQ0KPiA+IGFscmVhZHkgZG9lcy4NCj4gPiANCj4gDQo+IEknbSB0YWxraW5nIGFi
b3V0IHRoZSBzY2hlbWUgdG8gb3B0aW1pemUgYXdheSBpX3ZlcnNpb24gdXBkYXRlcyB3aGVuDQo+
IHRoZQ0KPiBjdXJyZW50IG9uZSBoYXMgbmV2ZXIgYmVlbiBxdWVyaWVkOg0KPiANCj4gwqDCoMKg
DQo+IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RvcnZh
bGRzL2xpbnV4LmdpdC9jb21taXQvP2lkPWYwMmE5YWQxZjE1ZA0KPiANCj4gVGhlcmUncyBub3Ro
aW5nIHVucmVsaWFibGUgYWJvdXQgaXQuDQoNCk5vdCByZWFsbHkgc2VlaW5nIHdoeSB0aGF0IHdv
dWxkIGJlIGluY29tcGF0aWJsZSB3aXRoIHRoZSBpZGVhIG9mDQpidW1waW5nIG9uIGV2ZXJ5IGNo
YW5nZS4gVGhlIElfVkVSU0lPTl9RVUVSSUVEIGlzIGp1c3QgYSBoaW50IHRvIHRlbGwNCnlvdSB0
aGF0IGF0IHRoZSB2ZXJ5IGxlYXN0IHlvdSBuZWVkIHRvIHN5bmMgdGhlIG5leHQgbWV0YWRhdGEg
dXBkYXRlDQphZnRlciBzb21lb25lIHBlZWtlZCBhdCB0aGUgdmFsdWUuIFlvdSBjb3VsZCBzdGls
bCBjb250aW51ZSB0byBjYWNoZQ0KdXBkYXRlcyBhZnRlciB0aGF0LCBhbmQgb25seSBzeW5jIHRo
ZW0gb25jZSBhIE9fU1lOQyBvciBhbiBmc3luYygpIGNhbGwNCmV4cGxpY2l0bHkgcmVxdWlyZXMg
eW91IHRvIGRvIHNvLg0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBt
YWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0K
DQoNCg==
