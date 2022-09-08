Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EBC35B1D4A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Sep 2022 14:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbiIHMkx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Sep 2022 08:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiIHMkv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Sep 2022 08:40:51 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2107.outbound.protection.outlook.com [40.107.237.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B979C697A;
        Thu,  8 Sep 2022 05:40:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jB9GCDSkLYMaHec3ZkEcZfqt595VQ6BM0ehaK345k0TN/vjf5NAgLa2I9SGHUYACopQ9XuEC1BSH0Nqz3aMAnWuntt6j7X4JQm0qvJGLsByV8dVcmCprvm594hYmZAjyMGWLJxQZeWokC/eJk90N9+f6qJRcVQfRxejcJyC7GB31++qtYpNvBihl389ryOMgzTVNQaO7EP5GFGdoYJq7PV15LG80sNdeWnxxw95hCgDkQpcGv1InBNC3ruhUN86sVxDEuLDxG2YKfrGlSq3tVUjYiKbf1QHXGOaqxFulk99fN6kXgjqaAjc7quJ3BpvdFTkzJYx9fcVdesvLziFz8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KWzul/p1iYmEnnBNjSokC3JhoXQt64pxvhXRhcPn8hU=;
 b=VZDyMNjIGAIc9fkC7bOGNv+HhQGZ8Qz6WuNjVWkBFRg0Q87Ms9O+FDW9zO+i/O2WNxHJBTz65DRuq/0kKxN5042U1FQSiHYPS/8eB1HjNiEB8NZ+GQV1NJcQWO//oTVpNxmo9MynJCIOU3SNBdWAtZlcT2zb4k34iR12cWAbnWr15mYOICso0/cHqC4CT+aR2nJdNuLvKhfdN1ZJY5fVi4tr+lfitjviCHrTI+bU3NjnVlq4RaowYtgF1oxtHCiQfdXNwzgt+aZTp2EO0o5FUTNeqHFarsrvRLluVcU0k14RZ4zelRY8IAnAeH85k3je5heKR0jJurEE9A8OuaeBxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KWzul/p1iYmEnnBNjSokC3JhoXQt64pxvhXRhcPn8hU=;
 b=Qv6PTTyFDpZ93rZO06Gpnx4+X2L8rGi5sH0yBATSsDQYVmcMQPV0qK4+G1Gu307dcScsdA7JUfwwCV8XYzd7HfxlRtUzSr3fWKcI0YCy84EzVeKOyoA5tqt7dSpn4hQU+N7HqapgdluXZYpcxq+DHjz/MpPwYhn1YOk32PvOwWk=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by PH0PR13MB5922.namprd13.prod.outlook.com (2603:10b6:510:165::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.4; Thu, 8 Sep
 2022 12:40:46 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::f1c7:62d0:a63d:f5ca]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::f1c7:62d0:a63d:f5ca%3]) with mapi id 15.20.5612.012; Thu, 8 Sep 2022
 12:40:45 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "jlayton@kernel.org" <jlayton@kernel.org>,
        "neilb@suse.de" <neilb@suse.de>
CC:     "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "xiubli@redhat.com" <xiubli@redhat.com>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "bfields@fieldses.org" <bfields@fieldses.org>,
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
Thread-Index: AQHYwqs/evAHvn9kzUKFB4lWpvCB0q3T1xmAgAATgACAAAFbgIAABbEAgAAL3gCAALG5AIAAAwUAgAC3DICAABHHgA==
Date:   Thu, 8 Sep 2022 12:40:45 +0000
Message-ID: <69be8d4dbe98258d7d3e4528505eca5dba45cebe.camel@hammerspace.com>
References: <20220907111606.18831-1-jlayton@kernel.org>  ,
 <166255065346.30452.6121947305075322036@noble.neil.brown.name>  ,
 <79aaf122743a295ddab9525d9847ac767a3942aa.camel@kernel.org>     ,
 <20220907125211.GB17729@fieldses.org>   ,
 <771650a814ab1ff4dc5473d679936b747d9b6cf5.camel@kernel.org>     ,
 <8a71986b4fb61cd9b4adc8b4250118cbb19eec58.camel@hammerspace.com>
         <166259706887.30452.6749778447732126953@noble.neil.brown.name>
         <9f8b9ee28dcc479ab6fb1105fc12ff190a9b5c48.camel@hammerspace.com>
         <c15f58c78e560bb9a597db6d22c317f98f020435.camel@kernel.org>
In-Reply-To: <c15f58c78e560bb9a597db6d22c317f98f020435.camel@kernel.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|PH0PR13MB5922:EE_
x-ms-office365-filtering-correlation-id: c10ee1f4-3966-4eb8-9b6c-08da919759c7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q08CLQ8C+ucSngslZuTUjLdJqjulh8Y/gNrYB5t3MDX1DMXT+gfU3sVYsGRrIc0w+3uJJDBG3qh05+9OA2Cfa1ylFuVHOuSEuTVOSGDBbYOX8mnXZmpP1sTzSEwWvV9JKrfjqeTjs0QoycN3r6xu2FNgPyGBzbGFGa6Dcvg3mMLYqK4H23XDUiTrmSMdg2p2DCS0fYmawmazWl89X/J9mdRGu027ExhBKTs+iAgzSryRGrEwyMgo0J3+1NqxJKMJYmUHFbNWKPuEh8H5tHh2LP0wSSpRroLoFbPv0ajnGFEleyLpFfoLQNpajwuXNjhsAQkXcCGaH2iB+yNA8jv8816DO0QEsXQWEoTf3fqvVKQrn6IRXcFuhmn618ZPMhZ8SHXnQ72yh2xPWUdG0XwkoYxmCOKChMz5WjLuhnHpG17DCyWPws6dwkw4iVONVTIiaN1QlWpz/TR7fjU4QjKsk7OmOcWuIicYPKzm+B1rLxX9O+8AoYNVKSZmiHb3qKRNCywtjI4pCLp7b6agzmfcEskD8uRtPZ5W9yD3qzQcNGOMQ04ut6wbI68RPnYfyLKDt77wuvbQYIQErSZq8QXQ/4vzagIvhOioe0ap5tG7BzUsV83SljF3mGU/LGD2+X+sPyugM6TdYIYIBvAFxiv8lnubKqtKX4XMh9dnZ9T5Oh1LOoTLJ2+ee0PlEzIcK3Ygsh+hnn37RZ/aLLBvJvVbX60oV4oo8FhaHTSsD0EytTqTikShAqQNWXte2+W67eC/sVpOa5bScofnefvcxUSqvw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39840400004)(396003)(346002)(136003)(366004)(376002)(71200400001)(6506007)(38070700005)(26005)(6512007)(86362001)(41300700001)(478600001)(6486002)(186003)(2616005)(83380400001)(36756003)(122000001)(7416002)(38100700002)(4326008)(76116006)(8676002)(8936002)(5660300002)(66446008)(316002)(66946007)(54906003)(64756008)(110136005)(66476007)(66556008)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Nm1JeUJ0eWxDTW41ZUUzZ0tiWnorMkcxQllySnhsUlZHS2NkNFVpZGltbjZS?=
 =?utf-8?B?TlIrbmZmN2xUSEsrWTVkeUljM3J1UEpwR1VGNHFTY0RKbm95V0VDQytxUVA4?=
 =?utf-8?B?dDNWc21xZ01XU0xQK29EbklReVk5c0V2TVFPRFlETUFPUlFFVHB4MnRMYjIw?=
 =?utf-8?B?YWdDd3l6dzkxaUtGeWErSVFHWGZLU2pQR3dLd1AxUWROdTh2MDNWUWZKMVpH?=
 =?utf-8?B?OWg3V2ZWRkFsR1NNWm0zZHFsK0pyaHF0M3I0NFhWS3ZNejNUazU1emJoV2Z6?=
 =?utf-8?B?RmErTkZZcm9LN05GTmpjV0xoRHFkY1FtRUZmYWhsdjlYYUVDYzZSbXpaNjEz?=
 =?utf-8?B?YWhGbzE0N2t6VHZ1SzZvOXFqRlNwYlFMci80aVFzVVRVYTNiRXhLR05mWU50?=
 =?utf-8?B?WUI1Z211UUFzT2dkZWhRSWRZSkNtTDZxazJqTDRwUFB2ZERrUEJWUFZjRExl?=
 =?utf-8?B?OFJPZVdMNjBKcVFITG1QbW9aSnVvTzByd2pUQk55YUFIRjNvNmoyRDloWW0x?=
 =?utf-8?B?TXptK0ZBQVFjUHZ4KzhkdUVERmk2ZURwMk9PRXdxejRDT2IxeExNTnhjZ2hu?=
 =?utf-8?B?elA2bStBWWl4WlhsdFVXWHFNemRUeXR4VDZaZXNFWVFpKzM4Qm12Rm5UQ1Jk?=
 =?utf-8?B?aDhyaXN4WWNuRFhxL2QvZGNBVEJDM1RQc0NhUmY0SDhPZTFuU2xsRnBqMTlI?=
 =?utf-8?B?eG0ycDZxaGVnVXF3aDk2UFBrQjdya08wMHJiZ2xrb1VhZENYUjVPa01tSzZY?=
 =?utf-8?B?TUpaUmVLcXFGZFYrUjhmS1BvWFNoQUpKQnJmZEV1WTlabnI3cVJNL2RGSnhu?=
 =?utf-8?B?Z29mZmNtTEVzOGNieWlaUUJNZWtBOEk2WG0wRFNwUlJZYlRUMkNHRWxpczJy?=
 =?utf-8?B?UFNHQlRIckdqYjdLRkY2dHB0WitHdWhESUNlKzAzdU5CZFB5ZmZ4STF4TmhX?=
 =?utf-8?B?S2ljTkMzUVNPTENZZjNWQ3RwUlFoaGlFZjE3c2Z2NzlDNm1ab1dQWm5yWHhU?=
 =?utf-8?B?aCs2V0ZyYWxDOUp4K3JiZHpuci9JbXJETUYyV01RMGVKZmFnUitFUlhiUkd1?=
 =?utf-8?B?bi95bnB5ajRYZ3h4bktHSHZKbHVqRkNuK2taNC9xRmg1ZWxVcEZxd0pxb21t?=
 =?utf-8?B?OCtqOUxlbUtSUjZaaERJWU5MMjlXSGVLV2tFLzJVWFJKK0Jkc2JDYXZrV0Q3?=
 =?utf-8?B?M1JDWEtsdVYyVzloOWZxRWtnVytkOW9GMXlXQnpBdUFia0prYTZIOGMwbDZu?=
 =?utf-8?B?eTlrL0R4d1JMWHV2ay9RL2tZdnRSZzZSNm1JS1NnZFRBOGRBTFlQU3BHWlcx?=
 =?utf-8?B?andIY3FDRTQydWp4VWN0LzdNdDYzTXRwUFl3bG9UZGYwNjNzY0I1SytHbE9Y?=
 =?utf-8?B?d3hTUWJGQ0tRazA0eFBBaStvM1FROHhXekRaQThlYlMwNnZyOG1WbnBndmtz?=
 =?utf-8?B?bFZ4N01IUzdaNXorUXEvYTl1b0ZFMDVvWEFyU2MzQW5XRFBscWNqT3p6UFMx?=
 =?utf-8?B?WEdMNDdpa0lCdTZVRnZzZTg1MnBJamVHN0tqU1hvbHpvMzgyYlIvK1pEcjdi?=
 =?utf-8?B?M3NEdzBIWHB3L0hnNjhvRE9qbG5Zb1V3Y2hTbC9QZk0xcjBOa21HV1hDOWly?=
 =?utf-8?B?cWI0U1R4Y3Y3RFRObkhQR3VudWUrNVJUMVhLU2pTd2k5V0JlaU9scXQ3T0Vl?=
 =?utf-8?B?bUdOaEpNRU9DYXFDVG4rRk5tRzV1NGMzdWp0SGplVVdSWDdRb1FFeE0zbTlm?=
 =?utf-8?B?VGhya3VLNzl6bGxzQTl6ay91bnBLbVlBaC8yUytiRnpoS1ZWdzVUdzJlTXlY?=
 =?utf-8?B?TGpPY1hIT1ZET3UvZ0lXaE5KMHdtTFZkUGhCeXlQQUZnMVQyZnh0NWsxbm44?=
 =?utf-8?B?a21xbVBncU9KbmpLNEtNQnhONDZGaUNDOTg5VzFvYngyR1AvMFp4alNqNUNa?=
 =?utf-8?B?NWREbnphaDBEZnhRamZpR3NoUm1lNWxEK2VDMjIzcis1TWZRR1hEKzYrNVh4?=
 =?utf-8?B?blF6NVM5SmVRb2prcDV4OWZyNVRCelExNlNTNlNmbmFLcU5Bc0U1eXYyVTJ3?=
 =?utf-8?B?enlIaXhHMHhCV0lFQUUwTUM4YVdZWW5ONWFOQ0RyTlJjeTNNVVpEb0V2Ykto?=
 =?utf-8?B?aGtBSU94U2hkSk81Ym1aci91VFgwNjhsUG1QT0tVTDE1TjlZaE54Y200ZXkw?=
 =?utf-8?B?Y3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9A2F473B38BE5142BA9632773AD89ED2@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR13MB5922
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gVGh1LCAyMDIyLTA5LTA4IGF0IDA3OjM3IC0wNDAwLCBKZWZmIExheXRvbiB3cm90ZToNCj4g
T24gVGh1LCAyMDIyLTA5LTA4IGF0IDAwOjQxICswMDAwLCBUcm9uZCBNeWtsZWJ1c3Qgd3JvdGU6
DQo+ID4gT24gVGh1LCAyMDIyLTA5LTA4IGF0IDEwOjMxICsxMDAwLCBOZWlsQnJvd24gd3JvdGU6
DQo+ID4gPiBPbiBXZWQsIDA3IFNlcCAyMDIyLCBUcm9uZCBNeWtsZWJ1c3Qgd3JvdGU6DQo+ID4g
PiA+IE9uIFdlZCwgMjAyMi0wOS0wNyBhdCAwOToxMiAtMDQwMCwgSmVmZiBMYXl0b24gd3JvdGU6
DQo+ID4gPiA+ID4gT24gV2VkLCAyMDIyLTA5LTA3IGF0IDA4OjUyIC0wNDAwLCBKLiBCcnVjZSBG
aWVsZHMgd3JvdGU6DQo+ID4gPiA+ID4gPiBPbiBXZWQsIFNlcCAwNywgMjAyMiBhdCAwODo0Nzoy
MEFNIC0wNDAwLCBKZWZmIExheXRvbg0KPiA+ID4gPiA+ID4gd3JvdGU6DQo+ID4gPiA+ID4gPiA+
IE9uIFdlZCwgMjAyMi0wOS0wNyBhdCAyMTozNyArMTAwMCwgTmVpbEJyb3duIHdyb3RlOg0KPiA+
ID4gPiA+ID4gPiA+IE9uIFdlZCwgMDcgU2VwIDIwMjIsIEplZmYgTGF5dG9uIHdyb3RlOg0KPiA+
ID4gPiA+ID4gPiA+ID4gK1RoZSBjaGFuZ2UgdG8gXGZJc3RhdHguc3R4X2lub192ZXJzaW9uXGZQ
IGlzIG5vdA0KPiA+ID4gPiA+ID4gPiA+ID4gYXRvbWljDQo+ID4gPiA+ID4gPiA+ID4gPiB3aXRo
DQo+ID4gPiA+ID4gPiA+ID4gPiByZXNwZWN0IHRvIHRoZQ0KPiA+ID4gPiA+ID4gPiA+ID4gK290
aGVyIGNoYW5nZXMgaW4gdGhlIGlub2RlLiBPbiBhIHdyaXRlLCBmb3INCj4gPiA+ID4gPiA+ID4g
PiA+IGluc3RhbmNlLA0KPiA+ID4gPiA+ID4gPiA+ID4gdGhlDQo+ID4gPiA+ID4gPiA+ID4gPiBp
X3ZlcnNpb24gaXQgdXN1YWxseQ0KPiA+ID4gPiA+ID4gPiA+ID4gK2luY3JlbWVudGVkIGJlZm9y
ZSB0aGUgZGF0YSBpcyBjb3BpZWQgaW50byB0aGUNCj4gPiA+ID4gPiA+ID4gPiA+IHBhZ2VjYWNo
ZS4NCj4gPiA+ID4gPiA+ID4gPiA+IFRoZXJlZm9yZSBpdCBpcw0KPiA+ID4gPiA+ID4gPiA+ID4g
K3Bvc3NpYmxlIHRvIHNlZSBhIG5ldyBpX3ZlcnNpb24gdmFsdWUgd2hpbGUgYSByZWFkDQo+ID4g
PiA+ID4gPiA+ID4gPiBzdGlsbA0KPiA+ID4gPiA+ID4gPiA+ID4gc2hvd3MgdGhlIG9sZCBkYXRh
Lg0KPiA+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiA+IERvZXNuJ3QgdGhhdCBtYWtlIHRo
ZSB2YWx1ZSB1c2VsZXNzPw0KPiA+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiANCj4gPiA+
ID4gPiA+ID4gTm8sIEkgZG9uJ3QgdGhpbmsgc28uIEl0J3Mgb25seSByZWFsbHkgdXNlZnVsIGZv
cg0KPiA+ID4gPiA+ID4gPiBjb21wYXJpbmcNCj4gPiA+ID4gPiA+ID4gdG8gYW4NCj4gPiA+ID4g
PiA+ID4gb2xkZXINCj4gPiA+ID4gPiA+ID4gc2FtcGxlIGFueXdheS4gSWYgeW91IGRvICJzdGF0
eDsgcmVhZDsgc3RhdHgiIGFuZCB0aGUNCj4gPiA+ID4gPiA+ID4gdmFsdWUNCj4gPiA+ID4gPiA+
ID4gaGFzbid0DQo+ID4gPiA+ID4gPiA+IGNoYW5nZWQsIHRoZW4geW91IGtub3cgdGhhdCB0aGlu
Z3MgYXJlIHN0YWJsZS4gDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IEkgZG9uJ3Qgc2VlIGhv
dyB0aGF0IGhlbHBzLsKgIEl0J3Mgc3RpbGwgcG9zc2libGUgdG8gZ2V0Og0KPiA+ID4gPiA+ID4g
DQo+ID4gPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJlYWRlcsKgwqDC
oMKgwqDCoMKgwqDCoMKgd3JpdGVyDQo+ID4gPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoC0tLS0tLcKgwqDCoMKgwqDCoMKgwqDCoMKgLS0tLS0tDQo+ID4gPiA+ID4gPiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgaV92ZXJzaW9uKysNCj4gPiA+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgc3RhdHgNCj4gPiA+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
cmVhZA0KPiA+ID4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBzdGF0eA0K
PiA+ID4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoHVwZGF0ZSBwYWdlIGNhY2hlDQo+ID4gPiA+ID4gPiANCj4gPiA+
ID4gPiA+IHJpZ2h0Pw0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gWWVhaCwg
SSBzdXBwb3NlIHNvIC0tIHRoZSBzdGF0eCB3b3VsZG4ndCBuZWNlc3NpdGF0ZSBhbnkNCj4gPiA+
ID4gPiBsb2NraW5nLg0KPiA+ID4gPiA+IEluDQo+ID4gPiA+ID4gdGhhdCBjYXNlLCBtYXliZSB0
aGlzIGlzIHVzZWxlc3MgdGhlbiBvdGhlciB0aGFuIGZvciB0ZXN0aW5nDQo+ID4gPiA+ID4gcHVy
cG9zZXMNCj4gPiA+ID4gPiBhbmQgdXNlcmxhbmQgTkZTIHNlcnZlcnMuDQo+ID4gPiA+ID4gDQo+
ID4gPiA+ID4gV291bGQgaXQgYmUgYmV0dGVyIHRvIG5vdCBjb25zdW1lIGEgc3RhdHggZmllbGQg
d2l0aCB0aGlzIGlmDQo+ID4gPiA+ID4gc28/DQo+ID4gPiA+ID4gV2hhdA0KPiA+ID4gPiA+IGNv
dWxkIHdlIHVzZSBhcyBhbiBhbHRlcm5hdGUgaW50ZXJmYWNlPyBpb2N0bD8gU29tZSBzb3J0IG9m
DQo+ID4gPiA+ID4gZ2xvYmFsDQo+ID4gPiA+ID4gdmlydHVhbCB4YXR0cj8gSXQgZG9lcyBuZWVk
IHRvIGJlIHNvbWV0aGluZyBwZXItaW5vZGUuDQo+ID4gPiA+IA0KPiA+ID4gPiBJIGRvbid0IHNl
ZSBob3cgYSBub24tYXRvbWljIGNoYW5nZSBhdHRyaWJ1dGUgaXMgcmVtb3RlbHkNCj4gPiA+ID4g
dXNlZnVsDQo+ID4gPiA+IGV2ZW4NCj4gPiA+ID4gZm9yIE5GUy4NCj4gPiA+ID4gDQo+ID4gPiA+
IFRoZSBtYWluIHByb2JsZW0gaXMgbm90IHNvIG11Y2ggdGhlIGFib3ZlIChhbHRob3VnaCBORlMg
Y2xpZW50cw0KPiA+ID4gPiBhcmUNCj4gPiA+ID4gdnVsbmVyYWJsZSB0byB0aGF0IHRvbykgYnV0
IHRoZSBiZWhhdmlvdXIgdy5yLnQuIGRpcmVjdG9yeQ0KPiA+ID4gPiBjaGFuZ2VzLg0KPiA+ID4g
PiANCj4gPiA+ID4gSWYgdGhlIHNlcnZlciBjYW4ndCBndWFyYW50ZWUgdGhhdCBmaWxlL2RpcmVj
dG9yeS8uLi4gY3JlYXRpb24NCj4gPiA+ID4gYW5kDQo+ID4gPiA+IHVubGluayBhcmUgYXRvbWlj
YWxseSByZWNvcmRlZCB3aXRoIGNoYW5nZSBhdHRyaWJ1dGUgdXBkYXRlcywNCj4gPiA+ID4gdGhl
bg0KPiA+ID4gPiB0aGUNCj4gPiA+ID4gY2xpZW50IGhhcyB0byBhbHdheXMgYXNzdW1lIHRoYXQg
dGhlIHNlcnZlciBpcyBseWluZywgYW5kIHRoYXQNCj4gPiA+ID4gaXQNCj4gPiA+ID4gaGFzDQo+
ID4gPiA+IHRvIHJldmFsaWRhdGUgYWxsIGl0cyBjYWNoZXMgYW55d2F5LiBDdWUgZW5kbGVzcw0K
PiA+ID4gPiByZWFkZGlyL2xvb2t1cC9nZXRhdHRyDQo+ID4gPiA+IHJlcXVlc3RzIGFmdGVyIGVh
Y2ggYW5kIGV2ZXJ5IGRpcmVjdG9yeSBtb2RpZmljYXRpb24gaW4gb3JkZXINCj4gPiA+ID4gdG8N
Cj4gPiA+ID4gY2hlY2sNCj4gPiA+ID4gdGhhdCBzb21lIG90aGVyIGNsaWVudCBkaWRuJ3QgYWxz
byBzbmVhayBpbiBhIGNoYW5nZSBvZiB0aGVpcg0KPiA+ID4gPiBvd24uDQo+ID4gPiANCj4gPiA+
IE5GUyByZS1leHBvcnQgZG9lc24ndCBzdXBwb3J0IGF0b21pYyBjaGFuZ2UgYXR0cmlidXRlcyBv
bg0KPiA+ID4gZGlyZWN0b3JpZXMuDQo+ID4gPiBEbyB3ZSBzZWUgdGhlIGVuZGxlc3MgcmV2YWxp
ZGF0ZSByZXF1ZXN0cyBhZnRlciBkaXJlY3RvcnkNCj4gPiA+IG1vZGlmaWNhdGlvbg0KPiA+ID4g
aW4gdGhhdCBzaXR1YXRpb24/wqAgSnVzdCBjdXJpb3VzLg0KPiA+IA0KPiA+IFdoeSB3b3VsZG4n
dCBORlMgcmUtZXhwb3J0IGJlIGNhcGFibGUgb2Ygc3VwcG9ydGluZyBhdG9taWMgY2hhbmdlDQo+
ID4gYXR0cmlidXRlcyBpbiB0aG9zZSBjYXNlcywgcHJvdmlkZWQgdGhhdCB0aGUgc2VydmVyIGRv
ZXM/IEl0IHNlZW1zDQo+ID4gdG8NCj4gPiBtZSB0aGF0IGlzIGp1c3QgYSBxdWVzdGlvbiBvZiBw
cm92aWRpbmcgdGhlIGNvcnJlY3QgaW5mb3JtYXRpb24NCj4gPiB3LnIudC4NCj4gPiBhdG9taWNp
dHkgdG8ga25mc2QuDQo+ID4gDQo+ID4gLi4uYnV0IHllcywgYSBxdWljayBnbGFuY2UgYXQgbmZz
NF91cGRhdGVfY2hhbmdlYXR0cl9sb2NrZWQoKSwgYW5kDQo+ID4gd2hhdA0KPiA+IGhhcHBlbnMg
d2hlbiAhY2luZm8tPmF0b21pYyBzaG91bGQgdGVsbCB5b3UgYWxsIHlvdSBuZWVkIHRvIGtub3cu
DQo+IA0KPiBUaGUgbWFpbiByZWFzb24gd2UgZGlzYWJsZWQgYXRvbWljIGNoYW5nZSBhdHRyaWJ1
dGUgdXBkYXRlcyB3YXMgdGhhdA0KPiBnZXRhdHRyIGNhbGxzIG9uIE5GUyBjYW4gYmUgcHJldHR5
IGV4cGVuc2l2ZS4gQnkgc2V0dGluZyB0aGUgTk9XQ0MNCj4gZmxhZywNCj4gd2UgY2FuIGF2b2lk
IHRob3NlIGZvciBXQ0MgaW5mbywgYnV0IGF0IHRoZSBleHBlbnNlIG9mIHRoZSBjbGllbnQNCj4g
aGF2aW5nDQo+IHRvIGRvIG1vcmUgcmV2YWxpZGF0aW9uIG9uIGl0cyBvd24uDQoNCldoaWxlIHBy
b3ZpZGluZyBXQ0MgYXR0cmlidXRlcyBvbiByZWd1bGFyIGZpbGVzIGlzIHR5cGljYWxseSBleHBl
bnNpdmUsDQpzaW5jZSBpdCBtYXkgaW52b2x2ZSBuZWVkaW5nIHRvIGZsdXNoIG91dCBJL08sIGRv
aW5nIHNvIGZvciBkaXJlY3Rvcmllcw0KdGVuZHMgdG8gYmUgYSBsb3QgbGVzcyBzby4gVGhlIG1h
aW4gcmVhc29uIGlzIHRoYXQgYWxsIGRpcmVjdG9yeQ0Kb3BlcmF0aW9ucyBhcmUgc3luY2hyb25v
dXMgaW4gTkZTLCBhbmQgdHlwaWNhbGx5IGRvIHJldHVybiBhdCBsZWFzdCB0aGUNCmNoYW5nZSBh
dHRyaWJ1dGUgd2hlbiB0aGV5IGFyZSBtb2RpZnlpbmcgdGhlIGRpcmVjdG9yeSBjb250ZW50cy4N
Cg0KU28geWVzLCB3aGVuIHdlIHJlLWV4cG9ydCBORlMgYXMgTkZTdjMsIHdlIGRvIHdhbnQgdG8g
c2tpcCByZXR1cm5pbmcNCldDQyBhdHRyaWJ1dGVzIGZvciB0aGUgZmlsZS4gSG93ZXZlciB3ZSB1
c3VhbGx5IGRvIG91ciBiZXN0IHRvIHJldHVybg0KcG9zdC1vcCBhdHRyaWJ1dGVzIGZvciB0aGUg
ZGlyZWN0b3J5Lg0KDQpBdG9taWNpdHkgaXMgYSBkaWZmZXJlbnQgbWF0dGVyIHRob3VnaC4gUmln
aHQgbm93IHRoZSBORlMgY2xpZW50IGRvZXMNCnNldCBFWFBPUlRfT1BfTk9BVE9NSUNfQVRUUiwg
YnV0IHdlIGNvdWxkIGZpbmQgd2F5cyB0byB3b3JrIGFyb3VuZCB0aGF0DQpmb3IgdGhlIE5GU3Y0
IGNoYW5nZSBhdHRyaWJ1dGUgYXQgbGVhc3QsIGlmIHdlIHdhbnRlZCB0by4NCg0KLS0gDQpUcm9u
ZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRy
b25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
