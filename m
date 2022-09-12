Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7765B5D2C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Sep 2022 17:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbiILPcI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Sep 2022 11:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbiILPcH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Sep 2022 11:32:07 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D85286F8;
        Mon, 12 Sep 2022 08:32:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QlWQgPL9fFlXJ6LXQrLukM5cR6B6M+NaHtAksFDJ52Mfk7BGzPTzFmV7ZtdEAjZG4hFHK74U/g2Ruy/CprD9+HNPwAcYe/5C0uGazxT9PRBx4shr4zd6sPtDdi9F8f7ZjAbgJzXCl1fa+8hm2emvvdXKArDj0yrEHpK2Ta0kpXVWmq7asbsI6Gc/03HRuG9FrZvMHvrODV+1bYXHW6dX0XKM8jhOJcyiMhKW/D+jcqaqK7enWPhDF7+yAK6tUmTUC5c+z6C/lNhWsJGwZEFw+q/719i1bMWffY1IPfoyL76v6ZEu82P5BDFjVkIWm3vK1TAWhvF8vT6ekn6hVOjqcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nYVPTj3urp7Vk36sKS2DdVLFquI+uLhHhiX86VM8NUc=;
 b=mILwZSIfn52nAzJ3aYdxFl3daX8AxLuQv4EBCT45fxMUhqoJSGFjoeIIOp942pTkr8suDPZSxfvX+lC+GPdQFUbC2rOXBc7dhRS3NLNQ2Oet9fSnYghICrnpxKeP41P0B7kztmUFffv4spm/TD6Zm4Ni2VmSwkxcL4HAP4IFECpB2RXSK0ExEFaOSWS4rnCd8MkZRWv2mm+9m5X6Q9cCagX5SddVRvI6CaZYKcTj7oUNlfC9t57rwjXWdT+HrVKaI1sv6OmBiRToY3QFgRr3yO93F1usNhMO+DuN5Jv3CGHvh0erpO3wj5wenHIKKNGJM4u95xy3kY/I/uW03C9DJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nYVPTj3urp7Vk36sKS2DdVLFquI+uLhHhiX86VM8NUc=;
 b=VgQBVDU4QWIgvZCmQahJ5p1+KINfphnKObsBhVLPJDxPcmBFH/3JXgtfv8SevuXY0jvkm3UoUGsXovDH5I9HGquglwVsvPXniXUOBpz/ERRphMViFLo8orNgEl++RY0RxnLl/dMaXKwdFNPpbUpu42csuR8qkvhEni6qSVx/LgM=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH2PR13MB3734.namprd13.prod.outlook.com (2603:10b6:610:9b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.10; Mon, 12 Sep
 2022 15:32:03 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::f1c7:62d0:a63d:f5ca]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::f1c7:62d0:a63d:f5ca%3]) with mapi id 15.20.5632.012; Mon, 12 Sep 2022
 15:32:02 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bfields@fieldses.org" <bfields@fieldses.org>
CC:     "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "neilb@suse.de" <neilb@suse.de>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "xiubli@redhat.com" <xiubli@redhat.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "tytso@mit.edu" <tytso@mit.edu>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "jack@suse.cz" <jack@suse.cz>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-man@vger.kernel.org" <linux-man@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "lczerner@redhat.com" <lczerner@redhat.com>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Subject: Re: [man-pages RFC PATCH v4] statx, inode: document the new
 STATX_INO_VERSION field
Thread-Topic: [man-pages RFC PATCH v4] statx, inode: document the new
 STATX_INO_VERSION field
Thread-Index: AQHYwqs/evAHvn9kzUKFB4lWpvCB0q3T1xmAgAATgACAAAFbgIAABbEAgAAK/YCAALZNAIAAgw4AgAByGoCAAAZagIAAAzmAgAAdFoCAAAvtAIAADJkAgAFZpwCAAA5bgIABdkIAgALuiQCAAAizZIAAC6QAgAAPxoCAAAadAIAACf6AgAABjQCAAAnpgA==
Date:   Mon, 12 Sep 2022 15:32:02 +0000
Message-ID: <44884eeb662c2e304ba644d585b14c65b7dc1a0a.camel@hammerspace.com>
References: <20220908182252.GA18939@fieldses.org>
         <44efe219dbf511492b21a653905448d43d0f3363.camel@kernel.org>
         <20220909154506.GB5674@fieldses.org>
         <125df688dbebaf06478b0911e76e228e910b04b3.camel@kernel.org>
         <20220910145600.GA347@fieldses.org>
         <9eaed9a47d1aef11fee95f0079e302bc776bc7ff.camel@kernel.org>
         <87a67423la.fsf@oldenburg.str.redhat.com>
         <7c71050e139a479e08ab7cf95e9e47da19a30687.camel@kernel.org>
         <20220912135131.GC9304@fieldses.org>
         <aeb314e7104647ccfd83a82bd3092005c337d953.camel@hammerspace.com>
         <20220912145057.GE9304@fieldses.org>
         <626f7e46aa25d967b3b92be61cf7059067d1a9c3.camel@hammerspace.com>
In-Reply-To: <626f7e46aa25d967b3b92be61cf7059067d1a9c3.camel@hammerspace.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|CH2PR13MB3734:EE_
x-ms-office365-filtering-correlation-id: 16ed73af-ec78-4462-3487-08da94d3f107
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c8JMh68LAAlv4N+aabsvHzs8rpRp+VD7K2Mj7Olddjqryp/9retgj3zoapIxcjIGhoQlq8WHmX6RroO7EhKhpQ295eQkJpSs1ES6gMW2M7rjtfAwRfSqsPUvnk9Ri+o5sgMca6W8fDFr0bc/9T0Vrm2/H+GzPsBZR3kHooaqe/DpEroynB6OnVcmzavt7IqADVKkXFA3ybOouwB0Bz28vQYBm3MBCTkhtUng8+N8e4XugpBg3QZ9x+eh9Mabwpw9RNvqq5UBeeJ0SH/yRVhnT5/WjMVzxiqCvR6sTgF7MOYL4mkrwdBgc+P3K8W8qMMbz6Lv1ZfCwdpxXIGFmSoYBzXPdG0M5H4ApGCYRmHCDccQGv0Gd+LWATPnyDb/PC2Yok3ERfVpV7svV9gnJDNzfxTt1HtushZ2ZFDaRxzED85p2T6DiA2Dy5bdruxojSjttZlDmd/TT0G50Y8Pem+fqKCTZin+s1h70pkzyMC/PhI7be1VKPrykyQCTEdfzUbCMzUPsxdm3peFV+oUEkRSrzHeocj0UBg0HfXZ6h4L3z8IVeVUfocVqXC1IW7Ht0sPsIGihiQawrkgANUvfYX8whP4J8REF9pVKHB61R9qJhtUSsKL02mXmakk0lL51dsb61JaphJlJa/zY2DiZeV2IUmFHUxeiGkfvBvbnZeebwSPkAcrnksPcTFCKW8E+Di8CH47MKoScMWfw6sh6bwP+lt/kDuR10IEEbQMbnyxK2f+J50mf9sRY85iNeTC1amsJkaxwvXy4uPY1E3KU7ptAA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(136003)(346002)(376002)(39830400003)(66446008)(83380400001)(2616005)(122000001)(36756003)(66476007)(64756008)(66556008)(4326008)(66946007)(2906002)(76116006)(38100700002)(5660300002)(8936002)(8676002)(7416002)(86362001)(316002)(54906003)(6486002)(38070700005)(478600001)(41300700001)(26005)(71200400001)(6506007)(6512007)(186003)(6916009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NUZac1gyazI5Z2N4c0h0K2lRdXlrRCtockxyTFZ5dFRTRnVMaDNxRXhkeFNP?=
 =?utf-8?B?OTVEM1QrUENzaHZzN2xJcHliUGsvR290Q01kMXNCMUIwbHlmN3RxMC96aVZQ?=
 =?utf-8?B?c1dsZ1VLT2l5dS9FNVVwOUdvRUZoenFZNWJueXZEMFlieFdZNU9sUDVwckQw?=
 =?utf-8?B?K2tGaDFwcDNTa0NYT1k2RXBUek5SQnlIaE1JeURlNW9WSG1EMVgycHcyVHJW?=
 =?utf-8?B?RzRvWnpYMTYyNUdUZTJUcFdHUTIwTjNjNjRZdXVqRkMvV3d2OXFkeVFSVUxV?=
 =?utf-8?B?Yy9VT2M5S3ZyTGFvMFZQd3Y3ME5LNnNwUDhDeW1wbFZ5dzltazBpekdTK2I3?=
 =?utf-8?B?bFd3ZE9qdFlVVEQ3dEFkcDdWOEtWYnNtTTM0T0JUMjdEd0VEampLTzJLaGQ4?=
 =?utf-8?B?WSsxWUc4US9sK2tJNVFqZkoxTVlWSG5JOHNDdk1qRkFQazg4UjJydDdESUFY?=
 =?utf-8?B?WkYxWS9oVlA4Y0syRUJLV3pRTW9rNUF5Q0paZ1dKMS9sTWxhMEFiYklTOVYr?=
 =?utf-8?B?NHR0MjVNTXB3dEV5b2tFcURwbTBIeXhZQXZ6dGJiLy9NekhJQUdHT21wVHVz?=
 =?utf-8?B?MEF6azNvdjVnMm45WnduN0hKLzBhYkFSM1ZvM1ZXcUwxOHVyWnVsejdacWpm?=
 =?utf-8?B?eWR1eWhkeTVrTHI4eG1FUDBRdElxN2hBbGpMdjFRTUg5ajBuOU5qM1ZSMk5h?=
 =?utf-8?B?aTNQa2NWeHB3SWFyUzErbGE5bHBGTXJZSFJhK0t5Y3RHUGtyWGcrQ05Xbkhh?=
 =?utf-8?B?eVFFM0dBb3VTcVlnamlZSXc0YzNOK0ZSUnFISlBxSGlNVG5GZWdFdkphK0Fo?=
 =?utf-8?B?N1Q2SFZPRmF1MThoeUpHU29uVnVONmllWTZqUFNLS2M0c3JwUm9BcU1kdTRU?=
 =?utf-8?B?c2s3dFNvOGZIdk84VkV6THRVcmk0NW5lWWpVbnJCSi84NTFkRmNoZE9hdi9u?=
 =?utf-8?B?ZG5OKzk4WHpEYlF4T3FkeW55VzZsbGxnZElNaVJHc2RGUHZZRG1YT0syTVZU?=
 =?utf-8?B?NUl3c2RBV2M0Qm5aUlJVQTFjMzlrbmhRME8yQWIxMDVpbWVBSzZSQ2VDd1BI?=
 =?utf-8?B?TXYxNW5nR0c2ekovTVVibG1GVUxJcXBXSVdQNVUxTWJsTER0cGZuYXFZY0xV?=
 =?utf-8?B?TGNGK052bnM4dFBMcU0zQ2R0UTlGbzU1enl5VkJhUnBiYk5QZktsS0E0Y1k2?=
 =?utf-8?B?WXlVQlJZNGhlUHloNnRmTllzOUc3TU9YU05RdHE0ZXpiMHNBdVVxUmtuZEti?=
 =?utf-8?B?VjBQRmphaFpTWVl0ZVo0UWV0ZmhBNzNXZkJIbEM2elFHR3RqQzIva2sxTkZG?=
 =?utf-8?B?WHpQNVEwRU5UYnoycnhKVkM3Um1kWVc1SmdJQVlzczR2aWhwMTYrUWVsOFBO?=
 =?utf-8?B?TXJOdjJiY0MwSHA2Vi9CVFpFclVJM0xtVnFhU2VON0VrZS9ZdGNBTnJaWDcz?=
 =?utf-8?B?R3JEQ2FVaDBhUklCQ0NPNFdUSDBURm5RUWZrRS9jT2dVTzRYSkFGN2VkK2R1?=
 =?utf-8?B?RDJiNG9CT2EzeDBHT1hEUEVjZityOG9tMmlqa2xqMlJLZ25BQm1idGROcHZR?=
 =?utf-8?B?aVJ0ZnNoaDdCTlVqSnM1K3FQMEgzZDF6VWdpWFV2amx6cm5WSjc4b2ZsRXRU?=
 =?utf-8?B?cVdzbVZ0ZThkQjdzVlAzTTJmeklNNW9rai9zSHJDblI2MUZpMnpVdWtaaktz?=
 =?utf-8?B?eVA2WUVKZW1FZG9VQWJ3aUxnTU8xTVlkNEVlMVorUnljaVpGWFhMdTAyTC9x?=
 =?utf-8?B?TWcxd3dncktjZEppUFUyQmJKZ0FDdnBacHJwRUFhcE5JMUxadnMrYUx6Mlh0?=
 =?utf-8?B?ZnQxdS9vQ1puSW4wNEtSK3hiS2JVRnNKMGhIYVlnUnQ5cmNUeGIzNGdCZlMy?=
 =?utf-8?B?dlMzcDZlTU9oNWZXWnNtck5uMlNWN2I5OUxLK1hHcG9HQ0FoczBvdGkvcjIr?=
 =?utf-8?B?ZzBMRDV4TmpUUXVBSjl3RjlkNlE5N1U5cS9uYXRJMFdhMi9yNHhxZGdiZXBD?=
 =?utf-8?B?ZkYxY1A4cEd0UGhwN01zVjVZWU1sL1l2NTlueXcrOXQvZU1CeWlWOEIrNCtV?=
 =?utf-8?B?dFJkYi9oMjlnTDBQSnNjRGhrc1lINGJhK1pkcHJGL1loOFBoOWd1KzY4cjMy?=
 =?utf-8?B?c0g0OXA5cTUxRXBHSnpzelNGa3RCcENER0lKOFp2YVFtb01OeHYyVzJ4M2NW?=
 =?utf-8?B?Umc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B7C3D6E22FDF7E48A49C73EB9D48DA21@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3734
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gTW9uLCAyMDIyLTA5LTEyIGF0IDE0OjU2ICswMDAwLCBUcm9uZCBNeWtsZWJ1c3Qgd3JvdGU6
DQo+IE9uIE1vbiwgMjAyMi0wOS0xMiBhdCAxMDo1MCAtMDQwMCwgSi4gQnJ1Y2UgRmllbGRzIHdy
b3RlOg0KPiA+IE9uIE1vbiwgU2VwIDEyLCAyMDIyIGF0IDAyOjE1OjE2UE0gKzAwMDAsIFRyb25k
IE15a2xlYnVzdCB3cm90ZToNCj4gPiA+IE9uIE1vbiwgMjAyMi0wOS0xMiBhdCAwOTo1MSAtMDQw
MCwgSi4gQnJ1Y2UgRmllbGRzIHdyb3RlOg0KPiA+ID4gPiBPbiBNb24sIFNlcCAxMiwgMjAyMiBh
dCAwODo1NTowNEFNIC0wNDAwLCBKZWZmIExheXRvbiB3cm90ZToNCj4gPiA+ID4gPiBCZWNhdXNl
IG9mIHRoZSAic2VlbiIgZmxhZywgd2UgaGF2ZSBhIDYzIGJpdCBjb3VudGVyIHRvIHBsYXkNCj4g
PiA+ID4gPiB3aXRoLg0KPiA+ID4gPiA+IENvdWxkDQo+ID4gPiA+ID4gd2UgdXNlIGEgc2ltaWxh
ciBzY2hlbWUgdG8gdGhlIG9uZSB3ZSB1c2UgdG8gaGFuZGxlIHdoZW4NCj4gPiA+ID4gPiAiamlm
ZmllcyINCj4gPiA+ID4gPiB3cmFwcz/CoEFzc3VtZSB0aGF0IHdlJ2QgbmV2ZXIgY29tcGFyZSB0
d28gdmFsdWVzIHRoYXQgd2VyZQ0KPiA+ID4gPiA+IG1vcmUNCj4gPiA+ID4gPiB0aGFuDQo+ID4g
PiA+ID4gMl42MiBhcGFydD8gV2UgY291bGQgYWRkIGlfdmVyc2lvbl9iZWZvcmUvaV92ZXJzaW9u
X2FmdGVyDQo+ID4gPiA+ID4gbWFjcm9zIHRvDQo+ID4gPiA+ID4gbWFrZQ0KPiA+ID4gPiA+IGl0
IHNpbXBsZSB0byBoYW5kbGUgdGhpcy4NCj4gPiA+ID4gDQo+ID4gPiA+IEFzIGZhciBhcyBJIHJl
Y2FsbCB0aGUgcHJvdG9jb2wganVzdCBhc3N1bWVzIGl0IGNhbiBuZXZlcg0KPiA+ID4gPiB3cmFw
LsKgDQo+ID4gPiA+IEkNCj4gPiA+ID4gZ3Vlc3MNCj4gPiA+ID4geW91IGNvdWxkIGFkZCBhIG5l
dyBjaGFuZ2VfYXR0cl90eXBlIHRoYXQgd29ya3MgdGhlIHdheSB5b3UNCj4gPiA+ID4gZGVzY3Jp
YmUuDQo+ID4gPiA+IEJ1dCB3aXRob3V0IHNvbWUgbmV3IHByb3RvY29sIGNsaWVudHMgYXJlbid0
IGdvaW5nIHRvIGtub3cgd2hhdA0KPiA+ID4gPiB0byBkbw0KPiA+ID4gPiB3aXRoIGEgY2hhbmdl
IGF0dHJpYnV0ZSB0aGF0IHdyYXBzLg0KPiA+ID4gPiANCj4gPiA+ID4gSSB0aGluayB0aGlzIGp1
c3QgbmVlZHMgdG8gYmUgZGVzaWduZWQgc28gdGhhdCB3cmFwcGluZyBpcw0KPiA+ID4gPiBpbXBv
c3NpYmxlDQo+ID4gPiA+IGluDQo+ID4gPiA+IGFueSByZWFsaXN0aWMgc2NlbmFyaW8uwqAgSSBm
ZWVsIGxpa2UgdGhhdCdzIGRvYWJsZT8NCj4gPiA+ID4gDQo+ID4gPiA+IElmIHdlIGZlZWwgd2Ug
aGF2ZSB0byBjYXRjaCB0aGF0IGNhc2UsIHRoZSBvbmx5IDEwMCUgY29ycmVjdA0KPiA+ID4gPiBi
ZWhhdmlvcg0KPiA+ID4gPiB3b3VsZCBwcm9iYWJseSBiZSB0byBtYWtlIHRoZSBmaWxlc3lzdGVt
IHJlYWRvbmx5Lg0KPiA+ID4gPiANCj4gPiA+IA0KPiA+ID4gV2hpY2ggcHJvdG9jb2w/IElmIHlv
dSdyZSB0YWxraW5nIGFib3V0IGJhc2ljIE5GU3Y0LCBpdCBkb2Vzbid0DQo+ID4gPiBhc3N1bWUN
Cj4gPiA+IGFueXRoaW5nIGFib3V0IHRoZSBjaGFuZ2UgYXR0cmlidXRlIGFuZCB3cmFwcGluZy4N
Cj4gPiA+IA0KPiA+ID4gVGhlIE5GU3Y0LjIgcHJvdG9jb2wgZGlkIGludHJvZHVjZSB0aGUgb3B0
aW9uYWwgYXR0cmlidXRlDQo+ID4gPiAnY2hhbmdlX2F0dHJfdHlwZScgdGhhdCB0cmllcyB0byBk
ZXNjcmliZSB0aGUgY2hhbmdlIGF0dHJpYnV0ZQ0KPiA+ID4gYmVoYXZpb3VyIHRvIHRoZSBjbGll
bnQuIEl0IHRlbGxzIHlvdSBpZiB0aGUgYmVoYXZpb3VyIGlzDQo+ID4gPiBtb25vdG9uaWNhbGx5
DQo+ID4gPiBpbmNyZWFzaW5nLCBidXQgZG9lc24ndCBzYXkgYW55dGhpbmcgYWJvdXQgdGhlIGJl
aGF2aW91ciB3aGVuIHRoZQ0KPiA+ID4gYXR0cmlidXRlIHZhbHVlIG92ZXJmbG93cy4NCj4gPiA+
IA0KPiA+ID4gVGhhdCBzYWlkLCB0aGUgTGludXggTkZTdjQuMiBjbGllbnQsIHdoaWNoIHVzZXMg
dGhhdA0KPiA+ID4gY2hhbmdlX2F0dHJfdHlwZQ0KPiA+ID4gYXR0cmlidXRlIGRvZXMgZGVhbCB3
aXRoIG92ZXJmbG93IGJ5IGFzc3VtaW5nIHN0YW5kYXJkIHVpbnQ2NF90DQo+ID4gPiB3cmFwDQo+
ID4gPiBhcm91bmQgcnVsZXMuIGkuZS4gaXQgYXNzdW1lcyBiaXQgdmFsdWVzID4gNjMgYXJlIHRy
dW5jYXRlZCwNCj4gPiA+IG1lYW5pbmcNCj4gPiA+IHRoYXQgdGhlIHZhbHVlIG9idGFpbmVkIGJ5
IGluY3JlbWVudGluZyAoMl42NC0xKSBpcyAwLg0KPiA+IA0KPiA+IFllYWgsIGl0IHdhcyB0aGUg
TU9OT1RPTklDX0lOQ1JFIGNhc2UgSSB3YXMgdGhpbmtpbmcgb2YuwqAgVGhhdCdzDQo+ID4gaW50
ZXJlc3RpbmcsIEkgZGlkbid0IGtub3cgdGhlIGNsaWVudCBkaWQgdGhhdC4NCj4gPiANCj4gDQo+
IElmIHlvdSBsb29rIGF0IHdoZXJlIHdlIGNvbXBhcmUgdmVyc2lvbiBudW1iZXJzLCBpdCBpcyBh
bHdheXMgc29tZQ0KPiB2YXJpYW50IG9mIHRoZSBmb2xsb3dpbmc6DQo+IA0KPiBzdGF0aWMgaW50
IG5mc19pbm9kZV9hdHRyc19jbXBfbW9ub3RvbmljKGNvbnN0IHN0cnVjdCBuZnNfZmF0dHINCj4g
KmZhdHRyLA0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb25zdCBzdHJ1Y3QgaW5vZGUgKmlu
b2RlKQ0KPiB7DQo+IMKgwqDCoMKgwqDCoMKgIHM2NCBkaWZmID0gZmF0dHItPmNoYW5nZV9hdHRy
IC0NCj4gaW5vZGVfcGVla19pdmVyc2lvbl9yYXcoaW5vZGUpOw0KPiDCoMKgwqDCoMKgwqDCoCBp
ZiAoZGlmZiA+IDApDQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gMTsN
Cj4gwqDCoMKgwqDCoMKgwqAgcmV0dXJuIGRpZmYgPT0gMCA/IDAgOiAtMTsNCj4gfQ0KPiANCj4g
aS5lLiB3ZSBkbyBhbiB1bnNpZ25lZCA2NC1iaXQgc3VidHJhY3Rpb24sIGFuZCB0aGVuIGNhc3Qg
aXQgdG8gdGhlDQo+IHNpZ25lZCA2NC1iaXQgZXF1aXZhbGVudCBpbiBvcmRlciB0byBmaWd1cmUg
b3V0IHdoaWNoIGlzIHRoZSBtb3JlDQo+IHJlY2VudCB2YWx1ZS4NCj4gDQoNCi4uLmFuZCBieSB0
aGUgd2F5LCB5ZXMgdGhpcyBkb2VzIG1lYW4gdGhhdCBpZiB5b3Ugc3VkZGVubHkgYWRkIGEgdmFs
dWUNCm9mIDJeNjMgdG8gdGhlIGNoYW5nZSBhdHRyaWJ1dGUsIHRoZW4geW91IGFyZSBsaWtlbHkg
dG8gY2F1c2UgdGhlDQpjbGllbnQgdG8gdGhpbmsgdGhhdCB5b3UganVzdCBoYW5kZWQgaXQgYW4g
b2xkIHZhbHVlLg0KDQppLmUuIHlvdSdyZSBiZXR0ZXIgb2ZmIGhhdmluZyB0aGUgY3Jhc2ggY291
bnRlciBpbmNyZW1lbnQgdGhlIGNoYW5nZQ0KYXR0cmlidXRlIGJ5IGEgcmVsYXRpdmVseSBzbWFs
bCB2YWx1ZS4gT25lIHRoYXQgaXMgZ3VhcmFudGVlZCB0byBiZQ0KbGFyZ2VyIHRoYW4gdGhlIHZh
bHVlcyB0aGF0IG1heSBoYXZlIGJlZW4gbG9zdCwgYnV0IHRoYXQgaXMgbm90DQpleGNlc3NpdmVs
eSBsYXJnZS4NCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRh
aW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
