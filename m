Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 713FB5F5589
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Oct 2022 15:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbiJENec (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Oct 2022 09:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbiJENea (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Oct 2022 09:34:30 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2104.outbound.protection.outlook.com [40.107.220.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E0AD7A75B;
        Wed,  5 Oct 2022 06:34:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z/Lejbj4d87bG4q6ow39rDl8Ikq8YNKqzrz4K3T9h/ozmF6VE4zCORVN3btu++VMajubaSA0CFm0xzUnC/WQ/pDH/HljipZieKRJp+sU+6NZfsiT6V2Wmv3lZpARRTO1BwLOfzFJnq8e6zlpzXM+R2BX2fp+w9PRjUr+ffnjD8MgmYyD/YkSIb7hGxLzWBbdhopsZhWOOV42mpGA+GGzTFONxfY/7iKTNULbyy2Z5ec+bvSw8j7/lUuAnhyHgiONEilZifnmH20phiwbwlZJK3eWprc5/Mg/KrOFL5NnA28dvftjh87js1BknW/Ui31FKgulidqZ3y0wQbsIck1h5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7lS7zgcRpGDlUNfPmxJSuqGNPF00RRB22Equm4CwEqg=;
 b=TA9XztPW6Ruqly/rO38AoHB+FjEEFTM11tOBo776HWZUpeX+857yJTQqf8bqvmZN0jsBH6Lb/h9VBQkMT3yqpedOPRt9KHNAP27zvU2t5/EPgDSR4eHGw+9i4G3GrqlHJt1horkWBASpYQb5X5LGIilXJ++Ok0Muh2kbO9BCMfk+Rb1tGIPrM9UO61ab+ePm3fQ5Z8ofzxj0tAXezwn6NNx9g6fCmouvExj7SSVtEFKDuCk855MBJQBdDvZFJiWXBsYLF62qs22POm7PS/qKoiUKlXGDAZNFEKTLiJiGbquvAeJm6SylV5tdkUhTv7AQNONujdvjRUS5RL/78u21BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7lS7zgcRpGDlUNfPmxJSuqGNPF00RRB22Equm4CwEqg=;
 b=PdQuSGXt0Jk9+1N2E1Cz6dxmbzwiXKleaXGNtnBy0rkGqWBlEuBt1587bNun+Q0lUhRLKA4zmFZl+sGGMNjHFz6g6CPDECniTFFdkzKYEGQw2CpEFwW7rCkOsdai9etYYI9kwkZLCg61MPy0Dw6eAS9zDb6UU99w6swArbDs1U0=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CO1PR13MB5000.namprd13.prod.outlook.com (2603:10b6:303:f8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.10; Wed, 5 Oct
 2022 13:34:23 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::93e4:42a1:96af:575e]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::93e4:42a1:96af:575e%9]) with mapi id 15.20.5676.023; Wed, 5 Oct 2022
 13:34:23 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "jlayton@kernel.org" <jlayton@kernel.org>,
        "neilb@suse.de" <neilb@suse.de>
CC:     "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "xiubli@redhat.com" <xiubli@redhat.com>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "bfields@fieldses.org" <bfields@fieldses.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "tytso@mit.edu" <tytso@mit.edu>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "jack@suse.cz" <jack@suse.cz>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "lczerner@redhat.com" <lczerner@redhat.com>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Subject: Re: [PATCH v6 6/9] nfsd: use the getattr operation to fetch i_version
Thread-Topic: [PATCH v6 6/9] nfsd: use the getattr operation to fetch
 i_version
Thread-Index: AQHY14FfsBwPJFkLR06LGZLlLjAExq3/lVkAgAA5/YA=
Date:   Wed, 5 Oct 2022 13:34:23 +0000
Message-ID: <cdbd9c6917ab66164596b95dad90625f46221b70.camel@hammerspace.com>
References: <20220930111840.10695-1-jlayton@kernel.org>  ,
 <20220930111840.10695-7-jlayton@kernel.org>
         <166484034920.14457.15225090674729127890@noble.neil.brown.name>
         <13714490816df1ff36ab06bbf32df5440cad7913.camel@kernel.org>
In-Reply-To: <13714490816df1ff36ab06bbf32df5440cad7913.camel@kernel.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|CO1PR13MB5000:EE_
x-ms-office365-filtering-correlation-id: 606f3bc2-45b4-4026-cca1-08daa6d650a2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: buMG0s2sjtGTIv6B30kkCVERyiNV1RXq+2F1BS0WTjfCM9inJ//jxJ5by+f9NAJxqLxKKuuF9RmDWhS0wS6cJQAliLV5wMaQ2VhFpZPy4Mu65hh62a85IU59r0s3+66SAGUIFQ4FL17rr15OIlWYmgCtPDK1q4zUUSU0Z7RH2v8j9PCPhilJSdrN2/EJkyGJSJVqJ0EZbgH/C9vJWtN6qXCmsdfijtrkx+DkEorDk5CCHqiFx/Noa0rQGKnrpljAil+efven5Az1+mwfjOfGSV2rvMruG+dsHpI5TKAxgSNTFsOfD4EKmqvAyIhjVdNdsMLkaYGLMgkN88Z0DvFTJ9hnvLj7QqZz/+lFfZrUBeBjifpjnvwxSnoZ/zSarIJupBB4QyZkfLTk46KUY7uiYnRhWrkWRHfC3Vtkaw40cxEJqNz1qk4gzNG1I1FcgbT1h7lrQYSOo+YETLEGtPVYVuRnZH92u7T+cJy8t9xDk/Epom5rRpriA19Jd59CeGB5oWGg9H1y2bINxdSRMVnv0cQ2TjVRCwvKiDCcEq2+cou32JpPvQlnzTX8IwQWW/0yl4iDDMhwIg+l9f636yOPzb0OLlkjaIikmQXyMb24YyXKPArrqu/n3QgO+GvpxVyaBvK/DP9U/rJM9uQt9VG3UaV+w0CMQPih0m8ICQbJgLNJeJ4a2PHGBcKCRd4KW/8lgOghyw9t1vlDAhhaiDedua7UfswP5dfRA64jEGBqjiDY+i+VIobSiL44lNJ9gGKNGWe1uTu9OATWGdLjkiR+t7aYp2gbZlhqLfsc/eg/3dA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(376002)(136003)(39840400004)(396003)(451199015)(36756003)(66899015)(316002)(54906003)(6512007)(110136005)(2616005)(122000001)(6506007)(6486002)(5660300002)(478600001)(86362001)(26005)(186003)(2906002)(71200400001)(7416002)(8676002)(64756008)(66446008)(38100700002)(66946007)(76116006)(66556008)(66476007)(4326008)(83380400001)(8936002)(41300700001)(38070700005)(60764002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?clpFQkVXSC82bXkwQ2ErZzh4N054YzRuTUtpUVd2RjBJVFdLRm8wWXhRN2F6?=
 =?utf-8?B?aWdqNDlnT3Z3RXpFb29CY2k1MXVGZ1gwT2U4OFZaZ2VDbWVSR3BKd1p6d2FZ?=
 =?utf-8?B?SE9lWVI2VEhUNWUxbE5uQWNFbDFMNmVqOFFUZ21tR3ZlTnBEUlNGUFlQWWpD?=
 =?utf-8?B?M2hSbE4zMXlzazdCcVVRZUJvUTg3Ylh2dStzWHZVUkdyR0w5S2gvdXAwSzg0?=
 =?utf-8?B?cStiMjhMY3FsaFBmekhiMDZWTHB0Y3l4aU5aSXVMdXNXVlEzdngrcVRJSTBE?=
 =?utf-8?B?YUEwZVZwTlFzaEJrOG5sQTFvL0JKeVJkNVpLZ3BLejU5VTlBdlZlL2E0cW9l?=
 =?utf-8?B?V1VVTUNQSmVqNDJaTkpXSGtWdHdlQ05kZXA0Qi9tdU1JcWwyMkx3VXh4K1Iw?=
 =?utf-8?B?VGFlT1dsTlcwc1VWZ0E1OXhucis3OU9xLzVaQXBHdFlaTVZ4QjZtMklqUWt6?=
 =?utf-8?B?VkROZ0pwRUZJTEZoV3hBWXVTQXhiVlhLdHMxbkVGRWxIdmVERnlxRDJLbUZ2?=
 =?utf-8?B?aEl1d1NOSE9XT3pMb1dYdHZRTmxud0FaN0syaEZkeG0yQzlTU3ZGR0lyTWp3?=
 =?utf-8?B?bmdXcVlzeGxlRHYveE1ubXZuNEJvTFlpblc5aldYRXBZaWIxeUExT1JmOVNY?=
 =?utf-8?B?ZnBNVmd0ak9LQ0dXdkVCSzdUMzNUNS9hWldhOVhJc2RmWHdVSHJtTXBzSVFB?=
 =?utf-8?B?NHZpL3BPcjNkdnRyb1lsd1BiYXhBRCtNdGhhcHc5bWpoNlJENVZtaXd6N0Rq?=
 =?utf-8?B?eGVwWmxDOHVXczZaYUNwd01PTWpkNXBLcjErTjZ2dTZGTklsUWpOK2t3a2dj?=
 =?utf-8?B?NVJUM3NEZ2hqVWdmSGV6STVlQTBqeko0OFRINEtYMHpjNkhka1JBbDBkaXRP?=
 =?utf-8?B?M3hvOXBkKzBxUUR0NkZqaGJkRDJzNWpRUDdHaDZxcEdlcnpxcFp6QVJrcS9w?=
 =?utf-8?B?OUExTU9kcXVLYW5MSHFMNk1jZlVWRWthb1E1dDUyV1dIKzFDd0NPaytEWG9D?=
 =?utf-8?B?T3llM0M0bDN4c2k2cDVnSXNtclplbmh4K1V4RGczMUJsT1BudHdBRjFqaG45?=
 =?utf-8?B?SkcyQ0ZMZ2hUdzh0UmlZNFIvZitkTFhPWlZZZjUvcElwd2tZd2J2TU51Njly?=
 =?utf-8?B?aU9ucWFUMVdaR0o4OW5SZTZnNkMybzM1NExJS2RvTXpveUFjWDhuZ01VTkM1?=
 =?utf-8?B?OWp5VDRmZGh4OCtoYm1ick9hSVVyZVE1eTlmdDBNeEwxdm5LMlJiVllQekZU?=
 =?utf-8?B?NWlURnZJK0FEQmxOaVR6SGlsN2pHRzAwMEFNNUZKNU5UR3YzUFYwR1F3eXZt?=
 =?utf-8?B?ZzJpVnRuaWxMeS9VOFZHMkVZb0pTZ05ieGcxL0lUczF1aG9IYlR6M0VCbFQ1?=
 =?utf-8?B?VnYreXRSaUlIeUZ6ZThEbk4yTnRlaTNlZmVzZW9NRUwwQVcwSEs0RFNscVQv?=
 =?utf-8?B?WlJwMVZYenFneUJBRWE0WUF2dE9YRHlZaXRCTEI2clhDUHcrRUxtRmVmeTNa?=
 =?utf-8?B?VlByand0RWJhNHV0dmhrdHVkSnFROWhkdlpnZUFlaTJ4VStuZWhZU0lUdSs2?=
 =?utf-8?B?ak10S0pXVHJ3U0FYQ2l5MEYwdGI4di9PNS9Yb3lobFNMVjZ2ZitxbzhGVGFl?=
 =?utf-8?B?bHVBNlhwNi9ZeFJ4QmFWZStubmZBUnlGbUUvV3hYcWhNYTF5eHA1NkNiUnRS?=
 =?utf-8?B?Y0VCNVNlQzEwZXJ2dE5WMW9sMUhHb1FXdURvc002anZwUGNxMHpibmx3SWlv?=
 =?utf-8?B?aHkvUENVR1ovTVZvYVpSVmRkNEk3NlJ5aDJBejVZd2ZaTHA1bGJMbktoVGVm?=
 =?utf-8?B?T1JIb1k4MXNnb3FTZTh5ZTZSeDI2aGdmcVdTakJCVHdYdlJ4V21FTlNSZUc5?=
 =?utf-8?B?UHhiRm1zbFg3N1dzWTZRY0I0QThoSEdvb3NPTGdCb21GeFAvU2d3cU13MUdr?=
 =?utf-8?B?T3pHc1cwN3JxZ3NXY0pYYjlDbHZ4MDl0TlNaeVJSbEpBQ2k1YWRoUXNCNVlY?=
 =?utf-8?B?WjMwMlZ4SXJCbFpDQkVQSVBxWHp4TXFnVmFiRkRxU2FiZ00yZm1uSnpvMHNC?=
 =?utf-8?B?L0xuY29pVEJnbmpGSC81SFllQVVVaUV2RWM2elNOM1hpeEgwSnVaZ3JoSExy?=
 =?utf-8?B?OWN0eUl6YUJEQVFJbzcrRDY4eHliakdyUWNGMGdVaUQzK3NOZW9uV0VGQTNy?=
 =?utf-8?B?Tnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B20EFEE816CB524F97F3931C87E6A74B@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 606f3bc2-45b4-4026-cca1-08daa6d650a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2022 13:34:23.1936
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ODVzLV3tl8gfe9uxEphotUVmVlzOORNxwW85lRUEz/J4QJQbNamvx0vMWVKcrzA0Gc/vOAhLoJYQVpyRX+tE8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR13MB5000
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gV2VkLCAyMDIyLTEwLTA1IGF0IDA2OjA2IC0wNDAwLCBKZWZmIExheXRvbiB3cm90ZToNCj4g
T24gVHVlLCAyMDIyLTEwLTA0IGF0IDEwOjM5ICsxMTAwLCBOZWlsQnJvd24gd3JvdGU6DQo+ID4g
T24gRnJpLCAzMCBTZXAgMjAyMiwgSmVmZiBMYXl0b24gd3JvdGU6DQo+ID4gPiBOb3cgdGhhdCB3
ZSBjYW4gY2FsbCBpbnRvIHZmc19nZXRhdHRyIHRvIGdldCB0aGUgaV92ZXJzaW9uIGZpZWxkLA0K
PiA+ID4gdXNlDQo+ID4gPiB0aGF0IGZhY2lsaXR5IHRvIGZldGNoIGl0IGluc3RlYWQgb2YgZG9p
bmcgaXQgaW4NCj4gPiA+IG5mc2Q0X2NoYW5nZV9hdHRyaWJ1dGUuDQo+ID4gPiANCj4gPiA+IE5l
aWwgYWxzbyBwb2ludGVkIG91dCByZWNlbnRseSB0aGF0IElTX0lfVkVSU0lPTiBkaXJlY3RvcnkN
Cj4gPiA+IG9wZXJhdGlvbnMNCj4gPiA+IGFyZSBhbHdheXMgbG9nZ2VkLCBhbmQgc28gd2Ugb25s
eSBuZWVkIHRvIG1pdGlnYXRlIHRoZSByb2xsYmFjaw0KPiA+ID4gcHJvYmxlbQ0KPiA+ID4gb24g
cmVndWxhciBmaWxlcy4gQWxzbywgd2UgZG9uJ3QgbmVlZCB0byBmYWN0b3IgaW4gdGhlIGN0aW1l
IHdoZW4NCj4gPiA+IHJlZXhwb3J0aW5nIE5GUyBvciBDZXBoLg0KPiA+ID4gDQo+ID4gPiBTZXQg
dGhlIFNUQVRYX1ZFUlNJT04gKGFuZCBCVElNRSkgYml0cyBpbiB0aGUgcmVxdWVzdCB3aGVuIHdl
J3JlDQo+ID4gPiBkZWFsaW5nDQo+ID4gPiB3aXRoIGEgdjQgcmVxdWVzdC4gVGhlbiwgaW5zdGVh
ZCBvZiBsb29raW5nIGF0IElTX0lfVkVSU0lPTiB3aGVuDQo+ID4gPiBnZW5lcmF0aW5nIHRoZSBj
aGFuZ2UgYXR0ciwgbG9vayBhdCB0aGUgcmVzdWx0IG1hc2sgYW5kIG9ubHkgdXNlDQo+ID4gPiBp
dCBpZg0KPiA+ID4gU1RBVFhfVkVSU0lPTiBpcyBzZXQuIFdpdGggdGhpcyBjaGFuZ2UsIHdlIGNh
biBkcm9wIHRoZQ0KPiA+ID4gZmV0Y2hfaXZlcnNpb24NCj4gPiA+IGV4cG9ydCBvcGVyYXRpb24g
YXMgd2VsbC4NCj4gPiA+IA0KPiA+ID4gTW92ZSBuZnNkNF9jaGFuZ2VfYXR0cmlidXRlIGludG8g
bmZzZmguYywgYW5kIGNoYW5nZSBpdCB0byBvbmx5DQo+ID4gPiBmYWN0b3INCj4gPiA+IGluIHRo
ZSBjdGltZSBpZiBpdCdzIGEgcmVndWxhciBmaWxlIGFuZCB0aGUgZnMgZG9lc24ndCBhZHZlcnRp
c2UNCj4gPiA+IFNUQVRYX0FUVFJfVkVSU0lPTl9NT05PVE9OSUMuDQo+ID4gPiANCj4gPiA+IFNp
Z25lZC1vZmYtYnk6IEplZmYgTGF5dG9uIDxqbGF5dG9uQGtlcm5lbC5vcmc+DQo+ID4gPiAtLS0N
Cj4gPiA+IMKgZnMvbmZzL2V4cG9ydC5jwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCA3IC0tLS0tLS0N
Cj4gPiA+IMKgZnMvbmZzZC9uZnM0eGRyLmPCoMKgwqDCoMKgwqDCoCB8wqAgNCArKystDQo+ID4g
PiDCoGZzL25mc2QvbmZzZmguY8KgwqDCoMKgwqDCoMKgwqDCoCB8IDQwDQo+ID4gPiArKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gPiDCoGZzL25mc2QvbmZzZmgu
aMKgwqDCoMKgwqDCoMKgwqDCoCB8IDI5ICstLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+
ID4gPiDCoGZzL25mc2QvdmZzLmjCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCA3ICsrKysrKy0N
Cj4gPiA+IMKgaW5jbHVkZS9saW51eC9leHBvcnRmcy5oIHzCoCAxIC0NCj4gPiA+IMKgNiBmaWxl
cyBjaGFuZ2VkLCA1MCBpbnNlcnRpb25zKCspLCAzOCBkZWxldGlvbnMoLSkNCj4gPiA+IA0KPiA+
ID4gZGlmZiAtLWdpdCBhL2ZzL25mcy9leHBvcnQuYyBiL2ZzL25mcy9leHBvcnQuYw0KPiA+ID4g
aW5kZXggMDE1OTZmMmQwYTFlLi4xYTlkNWFhNTFkZmIgMTAwNjQ0DQo+ID4gPiAtLS0gYS9mcy9u
ZnMvZXhwb3J0LmMNCj4gPiA+ICsrKyBiL2ZzL25mcy9leHBvcnQuYw0KPiA+ID4gQEAgLTE0NSwx
NyArMTQ1LDEwIEBAIG5mc19nZXRfcGFyZW50KHN0cnVjdCBkZW50cnkgKmRlbnRyeSkNCj4gPiA+
IMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gcGFyZW50Ow0KPiA+ID4gwqB9DQo+ID4gPiDCoA0KPiA+
ID4gLXN0YXRpYyB1NjQgbmZzX2ZldGNoX2l2ZXJzaW9uKHN0cnVjdCBpbm9kZSAqaW5vZGUpDQo+
ID4gPiAtew0KPiA+ID4gLcKgwqDCoMKgwqDCoMKgbmZzX3JldmFsaWRhdGVfaW5vZGUoaW5vZGUs
IE5GU19JTk9fSU5WQUxJRF9DSEFOR0UpOw0KPiA+ID4gLcKgwqDCoMKgwqDCoMKgcmV0dXJuIGlu
b2RlX3BlZWtfaXZlcnNpb25fcmF3KGlub2RlKTsNCj4gPiA+IC19DQo+ID4gPiAtDQo+ID4gPiDC
oGNvbnN0IHN0cnVjdCBleHBvcnRfb3BlcmF0aW9ucyBuZnNfZXhwb3J0X29wcyA9IHsNCj4gPiA+
IMKgwqDCoMKgwqDCoMKgwqAuZW5jb2RlX2ZoID0gbmZzX2VuY29kZV9maCwNCj4gPiA+IMKgwqDC
oMKgwqDCoMKgwqAuZmhfdG9fZGVudHJ5ID0gbmZzX2ZoX3RvX2RlbnRyeSwNCj4gPiA+IMKgwqDC
oMKgwqDCoMKgwqAuZ2V0X3BhcmVudCA9IG5mc19nZXRfcGFyZW50LA0KPiA+ID4gLcKgwqDCoMKg
wqDCoMKgLmZldGNoX2l2ZXJzaW9uID0gbmZzX2ZldGNoX2l2ZXJzaW9uLA0KPiA+ID4gwqDCoMKg
wqDCoMKgwqDCoC5mbGFncyA9IEVYUE9SVF9PUF9OT1dDQ3xFWFBPUlRfT1BfTk9TVUJUUkVFQ0hL
fA0KPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBFWFBPUlRfT1BfQ0xPU0Vf
QkVGT1JFX1VOTElOS3xFWFBPUlRfT1BfUkVNT1RFX0ZTDQo+ID4gPiB8DQo+ID4gPiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoEVYUE9SVF9PUF9OT0FUT01JQ19BVFRSLA0KPiA+ID4g
ZGlmZiAtLWdpdCBhL2ZzL25mc2QvbmZzNHhkci5jIGIvZnMvbmZzZC9uZnM0eGRyLmMNCj4gPiA+
IGluZGV4IDFlOTY5MGEwNjFlYy4uNzc5YzAwOTMxNGM2IDEwMDY0NA0KPiA+ID4gLS0tIGEvZnMv
bmZzZC9uZnM0eGRyLmMNCj4gPiA+ICsrKyBiL2ZzL25mc2QvbmZzNHhkci5jDQo+ID4gPiBAQCAt
Mjg2OSw3ICsyODY5LDkgQEAgbmZzZDRfZW5jb2RlX2ZhdHRyKHN0cnVjdCB4ZHJfc3RyZWFtICp4
ZHIsDQo+ID4gPiBzdHJ1Y3Qgc3ZjX2ZoICpmaHAsDQo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBnb3RvIG91dDsNCj4gPiA+IMKgwqDCoMKgwqDC
oMKgwqB9DQo+ID4gPiDCoA0KPiA+ID4gLcKgwqDCoMKgwqDCoMKgZXJyID0gdmZzX2dldGF0dHIo
JnBhdGgsICZzdGF0LCBTVEFUWF9CQVNJQ19TVEFUUywNCj4gPiA+IEFUX1NUQVRYX1NZTkNfQVNf
U1RBVCk7DQo+ID4gPiArwqDCoMKgwqDCoMKgwqBlcnIgPSB2ZnNfZ2V0YXR0cigmcGF0aCwgJnN0
YXQsDQo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIFNUQVRYX0JBU0lDX1NUQVRTIHwgU1RBVFhfQlRJTUUgfA0KPiA+ID4gU1RBVFhfVkVSU0lP
TiwNCj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgQVRfU1RBVFhfU1lOQ19BU19TVEFUKTsNCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqBpZiAoZXJy
KQ0KPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBnb3RvIG91dF9uZnNlcnI7
DQo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgaWYgKCEoc3RhdC5yZXN1bHRfbWFzayAmIFNUQVRYX0JU
SU1FKSkNCj4gPiA+IGRpZmYgLS1naXQgYS9mcy9uZnNkL25mc2ZoLmMgYi9mcy9uZnNkL25mc2Zo
LmMNCj4gPiA+IGluZGV4IGE1YjcxNTI2Y2VlMC4uOTE2OGJjNjU3Mzc4IDEwMDY0NA0KPiA+ID4g
LS0tIGEvZnMvbmZzZC9uZnNmaC5jDQo+ID4gPiArKysgYi9mcy9uZnNkL25mc2ZoLmMNCj4gPiA+
IEBAIC02MzQsNiArNjM0LDEwIEBAIHZvaWQgZmhfZmlsbF9wcmVfYXR0cnMoc3RydWN0IHN2Y19m
aCAqZmhwKQ0KPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBzdGF0Lm10aW1l
ID0gaW5vZGUtPmlfbXRpbWU7DQo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oHN0YXQuY3RpbWUgPSBpbm9kZS0+aV9jdGltZTsNCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgc3RhdC5zaXplwqAgPSBpbm9kZS0+aV9zaXplOw0KPiA+ID4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmICh2NCAmJiBJU19JX1ZFUlNJT04oaW5vZGUpKSB7DQo+
ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHN0YXQu
dmVyc2lvbiA9DQo+ID4gPiBpbm9kZV9xdWVyeV9pdmVyc2lvbihpbm9kZSk7DQo+ID4gPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHN0YXQucmVzdWx0X21h
c2sgfD0gU1RBVFhfVkVSU0lPTjsNCj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqB9DQo+ID4gDQo+ID4gVGhpcyBpcyBpbmNyZWFzaW5nbHkgdWdseS7CoCBJIHdvbmRlciBpZiBp
dCBpcyBqdXN0aWZpZWQgYXQgYWxsLi4uDQo+ID4gDQo+IA0KPiBJJ20gZmluZSB3aXRoIGRyb3Bw
aW5nIHRoYXQuIFNvIGlmIHRoZSBnZXRhdHRycyBmYWlsLCB3ZSBzaG91bGQganVzdA0KPiBub3QN
Cj4gb2ZmZXIgdXAgcHJlL3Bvc3QgYXR0cnM/DQo+IA0KPiA+ID4gwqDCoMKgwqDCoMKgwqDCoH0N
Cj4gPiA+IMKgwqDCoMKgwqDCoMKgwqBpZiAodjQpDQo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoGZocC0+ZmhfcHJlX2NoYW5nZSA9DQo+ID4gPiBuZnNkNF9jaGFuZ2VfYXR0
cmlidXRlKCZzdGF0LCBpbm9kZSk7DQo+ID4gPiBAQCAtNjY1LDYgKzY2OSw4IEBAIHZvaWQgZmhf
ZmlsbF9wb3N0X2F0dHJzKHN0cnVjdCBzdmNfZmggKmZocCkNCj4gPiA+IMKgwqDCoMKgwqDCoMKg
wqBpZiAoZXJyKSB7DQo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGZocC0+
ZmhfcG9zdF9zYXZlZCA9IGZhbHNlOw0KPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqBmaHAtPmZoX3Bvc3RfYXR0ci5jdGltZSA9IGlub2RlLT5pX2N0aW1lOw0KPiA+ID4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmICh2NCAmJiBJU19JX1ZFUlNJT04oaW5vZGUp
KQ0KPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBm
aHAtPmZoX3Bvc3RfYXR0ci52ZXJzaW9uID0NCj4gPiA+IGlub2RlX3F1ZXJ5X2l2ZXJzaW9uKGlu
b2RlKTsNCj4gPiANCj4gPiAuLi4gZGl0dG8gLi4uDQo+ID4gDQo+ID4gPiDCoMKgwqDCoMKgwqDC
oMKgfSBlbHNlDQo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGZocC0+Zmhf
cG9zdF9zYXZlZCA9IHRydWU7DQo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgaWYgKHY0KQ0KPiA+ID4g
QEAgLTc1NCwzICs3NjAsMzcgQEAgZW51bSBmc2lkX3NvdXJjZSBmc2lkX3NvdXJjZShjb25zdCBz
dHJ1Y3QNCj4gPiA+IHN2Y19maCAqZmhwKQ0KPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqByZXR1cm4gRlNJRFNPVVJDRV9VVUlEOw0KPiA+ID4gwqDCoMKgwqDCoMKgwqDCoHJl
dHVybiBGU0lEU09VUkNFX0RFVjsNCj4gPiA+IMKgfQ0KPiA+ID4gKw0KPiA+ID4gKy8qDQo+ID4g
PiArICogV2UgY291bGQgdXNlIGlfdmVyc2lvbiBhbG9uZSBhcyB0aGUgY2hhbmdlIGF0dHJpYnV0
ZS7CoA0KPiA+ID4gSG93ZXZlciwgaV92ZXJzaW9uDQo+ID4gPiArICogY2FuIGdvIGJhY2t3YXJk
cyBvbiBhIHJlZ3VsYXIgZmlsZSBhZnRlciBhbiB1bmNsZWFuDQo+ID4gPiBzaHV0ZG93bi7CoCBP
biBpdHMgb3duDQo+ID4gPiArICogdGhhdCBkb2Vzbid0IG5lY2Vzc2FyaWx5IGNhdXNlIGEgcHJv
YmxlbSwgYnV0IGlmIGlfdmVyc2lvbg0KPiA+ID4gZ29lcyBiYWNrd2FyZHMNCj4gPiA+ICsgKiBh
bmQgdGhlbiBpcyBpbmNyZW1lbnRlZCBhZ2FpbiBpdCBjb3VsZCByZXVzZSBhIHZhbHVlIHRoYXQg
d2FzDQo+ID4gPiBwcmV2aW91c2x5DQo+ID4gPiArICogdXNlZCBiZWZvcmUgYm9vdCwgYW5kIGEg
Y2xpZW50IHdobyBxdWVyaWVkIHRoZSB0d28gdmFsdWVzDQo+ID4gPiBtaWdodCBpbmNvcnJlY3Rs
eQ0KPiA+ID4gKyAqIGFzc3VtZSBub3RoaW5nIGNoYW5nZWQuDQo+ID4gPiArICoNCj4gPiA+ICsg
KiBCeSB1c2luZyBib3RoIGN0aW1lIGFuZCB0aGUgaV92ZXJzaW9uIGNvdW50ZXIgd2UgZ3VhcmFu
dGVlDQo+ID4gPiB0aGF0IGFzIGxvbmcgYXMNCj4gPiA+ICsgKiB0aW1lIGRvZXNuJ3QgZ28gYmFj
a3dhcmRzIHdlIG5ldmVyIHJldXNlIGFuIG9sZCB2YWx1ZS4gSWYgdGhlDQo+ID4gPiBmaWxlc3lz
dGVtDQo+ID4gPiArICogYWR2ZXJ0aXNlcyBTVEFUWF9BVFRSX1ZFUlNJT05fTU9OT1RPTklDLCB0
aGVuIHRoaXMgbWl0aWdhdGlvbg0KPiA+ID4gaXMgbm90IG5lZWRlZC4NCj4gPiA+ICsgKg0KPiA+
ID4gKyAqIFdlIG9ubHkgbmVlZCB0byBkbyB0aGlzIGZvciByZWd1bGFyIGZpbGVzIGFzIHdlbGwu
IEZvcg0KPiA+ID4gZGlyZWN0b3JpZXMsIHdlDQo+ID4gPiArICogYXNzdW1lIHRoYXQgdGhlIG5l
dyBjaGFuZ2UgYXR0ciBpcyBhbHdheXMgbG9nZ2VkIHRvIHN0YWJsZQ0KPiA+ID4gc3RvcmFnZSBp
biBzb21lDQo+ID4gPiArICogZmFzaGlvbiBiZWZvcmUgdGhlIHJlc3VsdHMgY2FuIGJlIHNlZW4u
DQo+ID4gPiArICovDQo+ID4gPiArdTY0IG5mc2Q0X2NoYW5nZV9hdHRyaWJ1dGUoc3RydWN0IGtz
dGF0ICpzdGF0LCBzdHJ1Y3QgaW5vZGUNCj4gPiA+ICppbm9kZSkNCj4gPiA+ICt7DQo+ID4gPiAr
wqDCoMKgwqDCoMKgwqB1NjQgY2hhdHRyOw0KPiA+ID4gKw0KPiA+ID4gK8KgwqDCoMKgwqDCoMKg
aWYgKHN0YXQtPnJlc3VsdF9tYXNrICYgU1RBVFhfVkVSU0lPTikgew0KPiA+ID4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoGNoYXR0ciA9IHN0YXQtPnZlcnNpb247DQo+ID4gPiArDQo+
ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKFNfSVNSRUcoaW5vZGUtPmlf
bW9kZSkgJiYNCj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgIShz
dGF0LT5hdHRyaWJ1dGVzICYNCj4gPiA+IFNUQVRYX0FUVFJfVkVSU0lPTl9NT05PVE9OSUMpKSB7
DQo+ID4gDQo+ID4gSSB3b3VsZCByZWFsbHkgcmF0aGVyIHRoYXQgdGhlIGZzIGdvdCB0byBtYWtl
IHRoaXMgZGVjaXNpb24uDQo+ID4gSWYgaXQgY2FuIGd1YXJhbnRlZSB0aGF0IHRoZSBpX3ZlcnNp
b24gaXMgbW9ub3RvbmljIGV2ZW4gb3ZlciBhDQo+ID4gY3Jhc2gNCj4gPiAod2hpY2ggaXMgcHJv
YmFibHkgY2FuIGZvciBkaXJlY3RvcnksIGFuZCBtaWdodCBuZWVkIGNoYW5nZXMgdG8gZG8NCj4g
PiBmb3INCj4gPiBmaWxlcykgdGhlbiBpdCBzZXRzIFNUQVRYX0FUVFJfVkVSU0lPTl9NT05PVE9O
SUMgYW5kIG5mc2QgdHJ1c3RzIGl0DQo+ID4gY29tcGxldGVseS4NCj4gPiBJZiBpdCBjYW5ub3Qs
IHRoZW4gaXQgZG9lc24ndCBzZXQgdGhlIGZsYWcuDQo+ID4gaS5lLiB0aGUgU19JU1JFRygpIHRl
c3Qgc2hvdWxkIGJlIGluIHRoZSBmaWxlc3lzdGVtLCBub3QgaW4gbmZzZC4NCj4gPiANCj4gDQo+
IFRoaXMgc291bmRzIHJlYXNvbmFibGUsIGJ1dCBmb3Igb25lIHRoaW5nLg0KPiANCj4gRnJvbSBS
RkMgNzg2MjoNCj4gDQo+IMKgwqAgV2hpbGUgU2VjdGlvbiA1LjQgb2YgW1JGQzU2NjFdIGRpc2N1
c3Nlcw0KPiDCoMKgIHBlci1maWxlIHN5c3RlbSBhdHRyaWJ1dGVzLCBpdCBpcyBleHBlY3RlZCB0
aGF0IHRoZSB2YWx1ZSBvZg0KPiDCoMKgIGNoYW5nZV9hdHRyX3R5cGUgd2lsbCBub3QgZGVwZW5k
IG9uIHRoZSB2YWx1ZSBvZiAiaG9tb2dlbmVvdXMiIGFuZA0KPiDCoMKgIHdpbGwgb25seSBjaGFu
Z2UgaW4gdGhlIGV2ZW50IG9mIGEgbWlncmF0aW9uLg0KPiANCj4gVGhlIGNoYW5nZV9hdHRyX3R5
cGU0IG11c3QgYmUgdGhlIHNhbWUgZm9yIGFsbCBmaWxlaGFuZGxlcyB1bmRlciBhDQo+IHBhcnRp
Y3VsYXIgZmlsZXN5c3RlbS4NCj4gDQo+IElmIHdlIGRvIHdoYXQgeW91IHN1Z2dlc3QgdGhvdWdo
LCB0aGVuIGl0J3MgZWFzaWx5IHBvc3NpYmxlIGZvciB0aGUNCj4gZnMNCj4gdG8gc2V0IFNUQVRY
X0FUVFJfVkVSU0lPTl9NT05PVE9OSUMgb27CoGRpcmVjdG9yaWVzIGJ1dCBub3QgZmlsZXMuIElm
DQo+IHdlDQo+IGxhdGVyIHdhbnQgdG8gYWxsb3cgbmZzZCB0byBhZHZlcnRpc2UgYSBjaGFuZ2Vf
YXR0cl90eXBlNCwgd2Ugd29uJ3QNCj4gYmUNCj4gYWJsZSB0byByZWx5IG9uIHRoZSBTVEFUWF9B
VFRSX1ZFUlNJT05fTU9OT1RPTklDIHRvIHRlbGwgdXMgaG93IHRvDQo+IGZpbGwNCj4gdGhhdCBv
dXQuDQoNClRoYXQgd2lsbCBicmVhayBjbGllbnRzLiBTbyBubywgdGhhdCdzIG5vdCBhY2NlcHRh
YmxlLg0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVy
LCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
