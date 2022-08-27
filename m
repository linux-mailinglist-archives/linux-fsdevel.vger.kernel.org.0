Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 998345A389F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Aug 2022 18:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233664AbiH0QDS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 27 Aug 2022 12:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbiH0QDR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 27 Aug 2022 12:03:17 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2092.outbound.protection.outlook.com [40.107.92.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD0E2124C;
        Sat, 27 Aug 2022 09:03:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b2ih4FhJHofFOcEt6k/OLJWqQKYnaC9Aorrii4IT8Aj+1qxQnA/J1fzAeyzMwomqjuHGpCkNzREu96wt1ddQEP5voO6avI3IMY4QZLMWshBbIHamVle8r3w/GM7kYZNQugrqbMR+ywlYo7vfNiNonI5D5D8cfPr3hTB/o2HxvwRUYkgezPZAV6/Oe8k7+BTKuB4Z8Phdmq/Wh9Bt9+fV/ToXbmTJMf+lajGfsxG0o+LK3l/lRPuxDoEt8wM9bvH1on48b2eAH1+hoGOd/Q9F22A5DbbqjURLOCjkVZdjhyQUwCDkO3yZ6/nrrTbyNeMzqN5PUhc/OC/+ZQH/aaTqnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aHyxjWj1rNiuJhDN2XmTjT6ha5/ji9JJxlSaYN7aoeo=;
 b=mSLbiRTAh8wMuLBkSu22/M/vv7d9P5HHu2nQbKzLwJXHBywsJN2hIYyXYQHlKAN7ljgaXIk+eY/47WOmlYeqtWoHsbM9T0GCLkKL9l334IwwFE8USv1InU39FbjsEfMOr3xvkd2X7bV0++DJgu7yf33dL4F+GxGUcrzENyFHKaeab2cJF8Izpn85uVbd4sZ/RoYKZlqSdFQPADLiVRWfM9il9VkZf/L+JPTPf2hn2kO/z5tIkip4/L54QEW1P6o5CZWXcZ6r7aCwFjJj358DKf+SESlp2KQEB1lFDIKdRF9Hx8vV/MlUthh22wN6WkLBvJtGpnPGcinKEppCTdb61w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aHyxjWj1rNiuJhDN2XmTjT6ha5/ji9JJxlSaYN7aoeo=;
 b=fXkocKfmiUi+3ZqQVaDJN1ujkPJySt7M/S+KDY269wo8lhIP2phhkvwlkfeFQIGidKKxcZ6eWWglyxEaldhsh7vyUXzIHaQBp/iqFVaeyKpR3+DyyFicwBJrrIEPRqn+S8BKL5p6TrqL1IfUOWWNYCDsbkYfxJJLXMsbHBT+kmY=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by DM6PR13MB4203.namprd13.prod.outlook.com (2603:10b6:5:171::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.3; Sat, 27 Aug
 2022 16:03:09 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::f1c7:62d0:a63d:f5ca]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::f1c7:62d0:a63d:f5ca%4]) with mapi id 15.20.5588.003; Sat, 27 Aug 2022
 16:03:08 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "djwong@kernel.org" <djwong@kernel.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>
CC:     "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "xiubli@redhat.com" <xiubli@redhat.com>,
        "neilb@suse.de" <neilb@suse.de>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "dwysocha@redhat.com" <dwysocha@redhat.com>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "tytso@mit.edu" <tytso@mit.edu>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "jack@suse.cz" <jack@suse.cz>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "amir73il@gmail.com" <amir73il@gmail.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "lczerner@redhat.com" <lczerner@redhat.com>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Subject: Re: [PATCH v3 4/7] xfs: don't bump the i_version on an atime update
 in xfs_vn_update_time
Thread-Topic: [PATCH v3 4/7] xfs: don't bump the i_version on an atime update
 in xfs_vn_update_time
Thread-Index: AQHYuZVsJRRF0PWz8kOHI52liC045q3CWXOAgAAJxgCAAFd9AIAAKpiAgAAEgoA=
Date:   Sat, 27 Aug 2022 16:03:08 +0000
Message-ID: <079df2134120f847e8237675a8cc227d6354a153.camel@hammerspace.com>
References: <20220826214703.134870-1-jlayton@kernel.org>
         <20220826214703.134870-5-jlayton@kernel.org>
         <CAOQ4uxjzE_B_EQktLr8z8gXOhFDNm-_YpUTycfZCdaZNp-i0hQ@mail.gmail.com>
         <CAOQ4uxge86g=+HPnds-wRXkFHg67G=m9rGK7V_T8yS+2=w9tmg@mail.gmail.com>
         <35d31d0a5c6c9a20c58f55ef62355ff39a3f18c6.camel@kernel.org>
         <Ywo8cWRcJUpLFMxJ@magnolia>
In-Reply-To: <Ywo8cWRcJUpLFMxJ@magnolia>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 99b5e0ad-a354-43dc-cafc-08da8845a23b
x-ms-traffictypediagnostic: DM6PR13MB4203:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YaXsOOAjOOtUeW8kOuN4d76FH6Sbe0I+7QG37H4yBxg84fRafFpKiRJbwzaN0WL5bzfr/k9bOGsHYP5Qgae7IdmE93K1uPQinfZV8IeiGKylRgNrjpQpGnmW2ehdEFe30WBLtOPR3oaVLrPMRQmubh4dNbCnw5/2uYBzqGidSx2shmCYIVMM0ylb/4bVk0gyOFD32UqQDTTvMlzEKbxPItsh/aLzl8hzoVoldQmZ+KVTzjbhYQW2wNf417KL93Nez1A/bmMdnN/WywW6VDGPAxFaaV6X24CmM8Cidfwx2vf4X3FMmhHjl/ya1u71XWw7MzheS0A1X3EsqoAAPxK/5DuZaokO42GKtQlSLWS7rkTKuHeKOidZL5iXKAXf56fH1JRi/TaGKSSQ8mPgjAmeH5cDXAAkq2BqnsDhA+vif3NJJJTdqqAGsrqyqmip9mksB4WN5x709ZpxZNWTKM8vhGlJg4LQ8jrQv79YJeQW2XWjh9+hjY18RLZLQhn2jhoqWpPC9fOjv/Hsxqy/VIdURQvcMGgjpMYtcrFQVmbO3V1ReIGhT76GqBjMPZY2nFxmF0Hrr8ILhEAIFAQHrrJ8kHIxpILxvUYTCsaSAVnNJvI0VeAhXJAyKGebW5PQOEIpvNwqcl2q0NplRs2cELP1YpkPujqnQnef2oJfpK9z0y9orcH7cCtD8zHulMZaiOaSmAuL5pShDe3nvYlD37pncEzozNU1IuA77MSgRTvHHJJCpvq7ndtWOtb2p6z68pyovQLRzMFE0v6JNCirr4FwvVt2ysbjljwVXWoV9BsILQRTt0aF6cXEOccjv4L8PZlB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(39830400003)(396003)(376002)(366004)(346002)(186003)(6512007)(71200400001)(2616005)(41300700001)(478600001)(6506007)(122000001)(86362001)(6486002)(53546011)(38070700005)(38100700002)(26005)(83380400001)(110136005)(54906003)(36756003)(8676002)(2906002)(66446008)(76116006)(316002)(4326008)(66946007)(66556008)(64756008)(5660300002)(66476007)(7416002)(8936002)(15650500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WTFWblNZT0M0ODZVQWhIVndiM1h6dE91Q3YzOFU3RUFqOGVicUJNMEsxSVhk?=
 =?utf-8?B?UEZQUGJpZVZMT2NnTUQ1emQ0QmhPcVArMk05V1ptV2p1c1hWQU9xZW1xbmFP?=
 =?utf-8?B?ellTSFBJb2ZWeG5jMXJTNFNiNVRhZHJLVjVEb29SbWdteWMvVVUvM0MxRWdR?=
 =?utf-8?B?b3FFZ3ZaSjMyQ0RuaG13Nis3T1FFZmVBY282bGp2aWRxUTVtUzRHeU9xSFZP?=
 =?utf-8?B?dUlHMXFPbHBZMEN4K3hvb1psbGdJT2hFTmoyZllWY2hNWHorL1JJck9uQm9z?=
 =?utf-8?B?cGM2UUpPUmdMWUxOUlJZSUsrcS8wQXV1a0o1L1RMeTczbVpBb1dPUVdZdTdx?=
 =?utf-8?B?WXB3eTBwMVRaSytwRlF0NWppYmt5ZmQxQXd6UklRSmxwcmxJdGJkbW52cHhi?=
 =?utf-8?B?bFFXYzQrY0dlZWR0bjF1eDJaQjVZMitZMEdYemNuVTgyb3lnbDB1cGN2bDlt?=
 =?utf-8?B?SFpLRkRnWklwWEJLNUFRcFpwWEU5QWxDcXg4U0lNdUhJU1ZaQzNua3NPc3ph?=
 =?utf-8?B?QkliRk1TUzAzMEdaRkRmd2JRWmVieVNRNUFQaFBkK2dWaFdPM3d2Rkc3WlJr?=
 =?utf-8?B?ZzdEUklpaGdzMGdSVHVqaGw3VHFRci9pNWpNejBYVzBlYkl0b1hYY2ZuQ1Nl?=
 =?utf-8?B?YU05YUdBQkpUWWhYWjdrMGZSWjRmUjdIOVlCMkoyUUF3TFVoOXNDUXZja3Jx?=
 =?utf-8?B?MmN3alI2bmp5MVIxRkp1OWEwMlpjWDZuMVJkcTBKejRuOThjSFRUWFdoN1ZW?=
 =?utf-8?B?ckQzOGhoaU9Pb3BVZkdPUmpmNTZnbEFPUnRCQmhsaTJqaWdSR0cyYU9NNjJ0?=
 =?utf-8?B?TGI4UHg1VjdTQkcyQ3lBTU9aZE0yaExMMGgwbTR5UVhkaFF5dG5vZm9FVGg1?=
 =?utf-8?B?WFJSVUdDbnhCN0ptZWZHYWRWeTgwcStLbVlWcXBKaXVPZ0wreUdYN1p5MEk3?=
 =?utf-8?B?dFNtMnMwUUMyUUhWYWJ6MmZkelhmUTNLbjVrU1UxQW9DRWcwWGU1ZWpqVDZB?=
 =?utf-8?B?MCs2WEVDSTZHd3VjVkxUaHppNDMvUmozczhVMWdyZ0QzUzc4MmgwQ3JiNmVL?=
 =?utf-8?B?VXpQL3pnQ3BCd3JKb0MyU3hvUFQ0bFk2RXEvMlNhTG42SE1xa3hXSXc3bTdu?=
 =?utf-8?B?bVBrck5iMFA5aGUrODE3aUlIeFg0eEhCVnVoRFZLdE5PbC8vbi9yMUZxRDVI?=
 =?utf-8?B?R2grWU1lc3F6akpobFIzK3RPQkRSd01OMFBrdWVNZzZEa3lNQ1hDNFplT2h0?=
 =?utf-8?B?RWVQZEFFd0lWR3BxVDkveDQxWUFKNUswRHhGaDdkcGowRDgwUjZtcloxMUNW?=
 =?utf-8?B?OHB4WjlCYmVOVGVQaFIrT1FoZGdLSG00NW1iZW1ITkRCNmw3Lzl6Q2ZBRmg5?=
 =?utf-8?B?V2c3MDRpQWp6eFlkbDhWZGMxU2drTVNqaGRzWDVRcUNoQXNDTU43TTl1dDNn?=
 =?utf-8?B?VHNQc054MjFhRml6aXMvUk02dXJPcUIvTEVrQXF3NDFXdnRTcWJuaitMZ0d4?=
 =?utf-8?B?NW1GYzNxWGg4V2ZZMERDUVdVSTFuSVRBSnllT0xWUW9OYTljS09BVTY0NDZE?=
 =?utf-8?B?Y1VZdkdsTDdjNStvakpJMjQzL1hrVTZTemlwMlNNRytiV3pTQnpnWnJTRndI?=
 =?utf-8?B?YlBiOXZsK09vNVBDRHRvQ2t0ZElGTXlRM0lhT0NRSngrOEJYMHNtT0R5VW5o?=
 =?utf-8?B?ZFZMeFBiK3Z4ZGdlSWhpTTEyd0Rva0U4dkhoeXorNWVDZmR4bjhVeWFnYWVn?=
 =?utf-8?B?ZFJaN3ZjZHg5anRMSHhYamx4L3N2Z3d5NTRJMGxSdmNQUUpVZmNDOHZsZnVx?=
 =?utf-8?B?MXJ2TUgwVnZnLzlwTHRDTVBscmd2dU5lY2QvSzhYSFFQdGZ2RS9zdE1NVjcz?=
 =?utf-8?B?Snp3SzY0eHpldk1EZmQxSWV4MjNRRURkemVlM3V3cHpISTBFaFlHaHl1UHpp?=
 =?utf-8?B?M2I2aXpmZjk5YjJKa0FYY1pxYVRNSEVwVHNwUkJ0MmFiYlA4SlVyRzZUVUFH?=
 =?utf-8?B?WnVLakRqSWNVZTZnZTRwZTFXWk81LzYvZVV5bUY0ck9qeWFQd2ZvSUlxSVBI?=
 =?utf-8?B?YUQwK3dWTDZHNGUxdVRtVkNjNE1OdlJ4M1ZlbVdsZDd0NHRsR1QyakUyeWc5?=
 =?utf-8?B?ODJDMkZTbkhCSkEyb2x2VFZEcmpPODl5azNaMzJiK3puZ1M5Y1BzU0RUZnU5?=
 =?utf-8?B?UkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <161D309D8394CF459A81EE82F5A5C7C7@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99b5e0ad-a354-43dc-cafc-08da8845a23b
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2022 16:03:08.1835
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gpRgusrV4HU1Hw7vCV/m8cKEQEVGApaG5zQFDD0VDh7uQCkqVN0CHiB+2bHvRNMNglzCm4DU2/gSGmzeixWCKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB4203
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gU2F0LCAyMDIyLTA4LTI3IGF0IDA4OjQ2IC0wNzAwLCBEYXJyaWNrIEouIFdvbmcgd3JvdGU6
DQo+IE9uIFNhdCwgQXVnIDI3LCAyMDIyIGF0IDA5OjE0OjMwQU0gLTA0MDAsIEplZmYgTGF5dG9u
IHdyb3RlOg0KPiA+IE9uIFNhdCwgMjAyMi0wOC0yNyBhdCAxMTowMSArMDMwMCwgQW1pciBHb2xk
c3RlaW4gd3JvdGU6DQo+ID4gPiBPbiBTYXQsIEF1ZyAyNywgMjAyMiBhdCAxMDoyNiBBTSBBbWly
IEdvbGRzdGVpbg0KPiA+ID4gPGFtaXI3M2lsQGdtYWlsLmNvbT4gd3JvdGU6DQo+ID4gPiA+IA0K
PiA+ID4gPiBPbiBTYXQsIEF1ZyAyNywgMjAyMiBhdCAxMjo0OSBBTSBKZWZmIExheXRvbg0KPiA+
ID4gPiA8amxheXRvbkBrZXJuZWwub3JnPiB3cm90ZToNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiB4
ZnMgd2lsbCB1cGRhdGUgdGhlIGlfdmVyc2lvbiB3aGVuIHVwZGF0aW5nIG9ubHkgdGhlIGF0aW1l
DQo+ID4gPiA+ID4gdmFsdWUsIHdoaWNoDQo+ID4gPiA+ID4gaXMgbm90IGRlc2lyYWJsZSBmb3Ig
YW55IG9mIHRoZSBjdXJyZW50IGNvbnN1bWVycyBvZg0KPiA+ID4gPiA+IGlfdmVyc2lvbi4gRG9p
bmcgc28NCj4gPiA+ID4gPiBsZWFkcyB0byB1bm5lY2Vzc2FyeSBjYWNoZSBpbnZhbGlkYXRpb25z
IG9uIE5GUyBhbmQgZXh0cmENCj4gPiA+ID4gPiBtZWFzdXJlbWVudA0KPiA+ID4gPiA+IGFjdGl2
aXR5IGluIElNQS4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBBZGQgYSBuZXcgWEZTX0lMT0dfTk9J
VkVSIGZsYWcsIGFuZCB1c2UgdGhhdCB0byBpbmRpY2F0ZSB0aGF0DQo+ID4gPiA+ID4gdGhlDQo+
ID4gPiA+ID4gdHJhbnNhY3Rpb24gc2hvdWxkIG5vdCB1cGRhdGUgdGhlIGlfdmVyc2lvbi4gU2V0
IHRoYXQgdmFsdWUNCj4gPiA+ID4gPiBpbg0KPiA+ID4gPiA+IHhmc192bl91cGRhdGVfdGltZSBp
ZiB3ZSdyZSBvbmx5IHVwZGF0aW5nIHRoZSBhdGltZS4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBD
YzogRGF2ZSBDaGlubmVyIDxkYXZpZEBmcm9tb3JiaXQuY29tPg0KPiA+ID4gPiA+IENjOiBOZWls
QnJvd24gPG5laWxiQHN1c2UuZGU+DQo+ID4gPiA+ID4gQ2M6IFRyb25kIE15a2xlYnVzdCA8dHJv
bmRteUBoYW1tZXJzcGFjZS5jb20+DQo+ID4gPiA+ID4gQ2M6IERhdmlkIFd5c29jaGFuc2tpIDxk
d3lzb2NoYUByZWRoYXQuY29tPg0KPiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEplZmYgTGF5dG9u
IDxqbGF5dG9uQGtlcm5lbC5vcmc+DQo+ID4gPiA+ID4gLS0tDQo+ID4gPiA+ID4gwqBmcy94ZnMv
bGlieGZzL3hmc19sb2dfZm9ybWF0LmjCoCB8wqAgMiArLQ0KPiA+ID4gPiA+IMKgZnMveGZzL2xp
Ynhmcy94ZnNfdHJhbnNfaW5vZGUuYyB8wqAgMiArLQ0KPiA+ID4gPiA+IMKgZnMveGZzL3hmc19p
b3BzLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgMTEgKysrKysrKysrLS0NCj4gPiA+
ID4gPiDCoDMgZmlsZXMgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkN
Cj4gPiA+ID4gPiANCj4gPiA+ID4gPiBEYXZlIGhhcyBOQUNLJ2VkIHRoaXMgcGF0Y2gsIGJ1dCBJ
J20gc2VuZGluZyBpdCBhcyBhIHdheSB0bw0KPiA+ID4gPiA+IGlsbHVzdHJhdGUNCj4gPiA+ID4g
PiB0aGUgcHJvYmxlbS4gSSBzdGlsbCB0aGluayB0aGlzIGFwcHJvYWNoIHNob3VsZCBhdCBsZWFz
dCBmaXgNCj4gPiA+ID4gPiB0aGUgd29yc3QNCj4gPiA+ID4gPiBwcm9ibGVtcyB3aXRoIGF0aW1l
IHVwZGF0ZXMgYmVpbmcgY291bnRlZC4gV2UgY2FuIGxvb2sgdG8NCj4gPiA+ID4gPiBjYXJ2ZSBv
dXQNCj4gPiA+ID4gPiBvdGhlciAic3B1cmlvdXMiIGlfdmVyc2lvbiB1cGRhdGVzIGFzIHdlIGlk
ZW50aWZ5IHRoZW0uDQo+ID4gPiA+ID4gDQo+ID4gPiA+IA0KPiA+ID4gPiBBRkFJSywgInNwdXJp
b3VzIiBpcyBvbmx5IGlub2RlIGJsb2NrcyBtYXAgY2hhbmdlcyBkdWUgdG8NCj4gPiA+ID4gd3Jp
dGViYWNrDQo+ID4gPiA+IG9mIGRpcnR5IHBhZ2VzLiBBbnlib2R5IGtub3cgYWJvdXQgb3RoZXIg
Y2FzZXM/DQo+ID4gPiA+IA0KPiA+ID4gPiBSZWdhcmRpbmcgaW5vZGUgYmxvY2tzIG1hcCBjaGFu
Z2VzLCBmaXJzdCBvZiBhbGwsIEkgZG9uJ3QgdGhpbmsNCj4gPiA+ID4gdGhhdCB0aGVyZSBpcw0K
PiA+ID4gPiBhbnkgcHJhY3RpY2FsIGxvc3MgZnJvbSBpbnZhbGlkYXRpbmcgTkZTIGNsaWVudCBj
YWNoZSBvbiBkaXJ0eQ0KPiA+ID4gPiBkYXRhIHdyaXRlYmFjaywNCj4gPiA+ID4gYmVjYXVzZSBO
RlMgc2VydmVyIHNob3VsZCBiZSBzZXJ2aW5nIGNvbGQgZGF0YSBtb3N0IG9mIHRoZQ0KPiA+ID4g
PiB0aW1lLg0KPiA+ID4gPiBJZiB0aGVyZSBhcmUgYSBmZXcgdW5uZWVkZWQgY2FjaGUgaW52YWxp
ZGF0aW9ucyB0aGV5IHdvdWxkIG9ubHkNCj4gPiA+ID4gYmUgdGVtcG9yYXJ5Lg0KPiA+ID4gPiAN
Cj4gPiA+IA0KPiA+ID4gVW5sZXNzIHRoZXJlIGlzIGFuIGlzc3VlIHdpdGggYSB3cml0ZXIgTkZT
IGNsaWVudCB0aGF0DQo+ID4gPiBpbnZhbGlkYXRlcyBpdHMNCj4gPiA+IG93biBhdHRyaWJ1dGUN
Cj4gPiA+IGNhY2hlcyBvbiBzZXJ2ZXIgZGF0YSB3cml0ZWJhY2s/DQo+ID4gPiANCj4gPiANCj4g
PiBUaGUgY2xpZW50IGp1c3QgbG9va3MgYXQgdGhlIGZpbGUgYXR0cmlidXRlcyAob2Ygd2hpY2gg
aV92ZXJzaW9uIGlzDQo+ID4gYnV0DQo+ID4gb25lKSwgYW5kIGlmIGNlcnRhaW4gYXR0cmlidXRl
cyBoYXZlIGNoYW5nZWQgKG10aW1lLCBjdGltZSwNCj4gPiBpX3ZlcnNpb24sDQo+ID4gZXRjLi4u
KSB0aGVuIGl0IGludmFsaWRhdGVzIGl0cyBjYWNoZS4NCj4gPiANCj4gPiBJbiB0aGUgY2FzZSBv
ZiBibG9ja3MgbWFwIGNoYW5nZXMsIGNvdWxkIHRoYXQgbWVhbiBhIGRpZmZlcmVuY2UgaW4NCj4g
PiB0aGUNCj4gPiBvYnNlcnZhYmxlIHNwYXJzZSByZWdpb25zIG9mIHRoZSBmaWxlPyBJZiBzbywg
dGhlbiBhIFJFQURfUExVUw0KPiA+IGJlZm9yZQ0KPiA+IHRoZSBjaGFuZ2UgYW5kIGEgUkVBRF9Q
TFVTIGFmdGVyIGNvdWxkIGdpdmUgZGlmZmVyZW50IHJlc3VsdHMuDQo+ID4gU2luY2UNCj4gPiB0
aGF0IGRpZmZlcmVuY2UgaXMgb2JzZXJ2YWJsZSBieSB0aGUgY2xpZW50LCBJJ2QgdGhpbmsgd2Un
ZCB3YW50IHRvDQo+ID4gYnVtcA0KPiA+IGlfdmVyc2lvbiBmb3IgdGhhdCBhbnl3YXkuDQo+IA0K
PiBIb3cgL2lzLyBSRUFEX1BMVVMgc3VwcG9zZWQgdG8gZGV0ZWN0IHNwYXJzZSByZWdpb25zLCBh
bnl3YXk/wqAgSSBrbm93DQo+IHRoYXQncyBiZWVuIHRoZSBzdWJqZWN0IG9mIHJlY2VudCBkZWJh
dGUuwqAgQXQgbGVhc3QgYXMgZmFyIGFzIFhGUyBpcw0KPiBjb25jZXJuZWQsIGEgZmlsZSByYW5n
ZSBjYW4gZ28gZnJvbSBob2xlIC0+IGRlbGF5ZWQgYWxsb2NhdGlvbg0KPiByZXNlcnZhdGlvbiAt
PiB1bndyaXR0ZW4gZXh0ZW50IC0+IChhY3R1YWwgd3JpdGViYWNrKSAtPiB3cml0dGVuDQo+IGV4
dGVudC4NCj4gVGhlIGRhbmNlIGJlY2FtZSByYXRoZXIgbW9yZSBjb21wbGV4IHdoZW4gd2UgYWRk
ZWQgQ09XLsKgIElmIGFueSBvZg0KPiB0aGF0DQo+IHdpbGwgbWFrZSBhIGRpZmZlcmVuY2UgZm9y
IFJFQURfUExVUywgdGhlbiB5ZXMsIEkgdGhpbmsgeW91J2Qgd2FudA0KPiBmaWxlDQo+IHdyaXRl
YmFjayBhY3Rpdml0aWVzIHRvIGJ1bXAgaXZlcnNpb24gdG8gY2F1c2UgY2xpZW50IGludmFsaWRh
dGlvbnMsDQo+IGxpa2UgKEkgdGhpbmspIERhdmUgc2FpZC4NCj4gDQo+IFRoZSBmcy9pb21hcC8g
aW1wbGVtZW50YXRpb24gb2YgU0VFS19EQVRBL1NFRUtfSE9MRSByZXBvcnRzIGRhdGEgZm9yDQo+
IHdyaXR0ZW4gYW5kIGRlbGFsbG9jIGV4dGVudHM7IGFuZCBhbiB1bndyaXR0ZW4gZXh0ZW50IHdp
bGwgcmVwb3J0DQo+IGRhdGENCj4gZm9yIGFueSBwYWdlY2FjaGUgaXQgZmluZHMuDQo+IA0KDQpS
RUFEX1BMVVMgc2hvdWxkIG5ldmVyIHJldHVybiBhbnl0aGluZyBkaWZmZXJlbnQgdGhhbiBhIHJl
YWQoKSBzeXN0ZW0NCmNhbGwgd291bGQgcmV0dXJuIGZvciBhbnkgZ2l2ZW4gYXJlYS4gVGhlIHdh
eSBpdCByZXBvcnRzIHNwYXJzZSByZWdpb25zDQp2cy4gZGF0YSByZWdpb25zIGlzIHB1cmVseSBh
biBSUEMgZm9ybWF0dGluZyBjb252ZW5pZW5jZS4NCg0KVGhlIG9ubHkgcG9pbnQgdG8gbm90ZSBh
Ym91dCBORlMgUkVBRCBhbmQgUkVBRF9QTFVTIGlzIHRoYXQgYmVjYXVzZSB0aGUNCmNsaWVudCBp
cyBmb3JjZWQgdG8gc2VuZCBtdWx0aXBsZSBSUEMgY2FsbHMgaWYgdGhlIHVzZXIgaXMgdHJ5aW5n
IHRvDQpyZWFkIGEgcmVnaW9uIHRoYXQgaXMgbGFyZ2VyIHRoYW4gdGhlICdyc2l6ZScgdmFsdWUs
IGl0IGlzIHBvc3NpYmxlDQp0aGF0IHRoZXNlIFJFQUQvUkVBRF9QTFVTIGNhbGxzIG1heSBiZSBw
cm9jZXNzZWQgb3V0IG9mIG9yZGVyLCBhbmQgc28NCnRoZSByZXN1bHQgbWF5IGVuZCB1cCBsb29r
aW5nIGRpZmZlcmVudCB0aGFuIGlmIHlvdSBoYWQgZXhlY3V0ZWQgYQ0KcmVhZCgpIGNhbGwgZm9y
IHRoZSBmdWxsIHJlZ2lvbiBkaXJlY3RseSBvbiB0aGUgc2VydmVyLg0KSG93ZXZlciBlYWNoIGlu
ZGl2aWR1YWwgUkVBRCAvIFJFQURfUExVUyByZXBseSBzaG91bGQgbG9vayBhcyBpZiB0aGUNCnVz
ZXIgaGFkIGNhbGxlZCByZWFkKCkgb24gdGhhdCByc2l6ZS1zaXplZCBzZWN0aW9uIG9mIHRoZSBm
aWxlLg0KPiA+ID4gDQoNCg0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVu
dCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNv
bQ0KDQoNCg==
