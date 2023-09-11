Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3146F79AE6A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Sep 2023 01:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237970AbjIKUyd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Sep 2023 16:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244008AbjIKSlB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Sep 2023 14:41:01 -0400
Received: from BL0PR02CU006.outbound.protection.outlook.com (mail-eastusazon11013000.outbound.protection.outlook.com [52.101.54.0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B2BC1AB;
        Mon, 11 Sep 2023 11:40:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kwLcjnrzjYqUs1OfPoi+UjErDuSGZSwnMXYtjZVSsc1DPMbEqRutDWZxaqU2lLRcd8/XMNOQOeUdCpeiZOC8rUx++81blvHbFwpDNyVG3L4T1EmRu36s+Y5RLG1M5hnM2bUlwYH7In60qpHXbTl/EuucMFWXC4lg6h5JA8UfhOB4tgV4ODhw+b2yNBjHfExuRLKHsYll5ilcg2p2m4elh5BhO6hwQGDSzSPPwP+kCKfS9zkejr7wPwrrdXRL2nat9Wm0vb3ufQHR3MG6DMtSUFOCFmV+Y+q5+WgjhTwyVv7dVo6MLq/dBEWRp2YHUa89nPyk2w3ah9cNdjNn1UO73g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1T9pxfbxjmsgL8zxOZEhHegnPmlymlB1qXyMAOZLP98=;
 b=fWyXJ3YZtRMMCl2eS52+4PRNZHk8Xe6W9DbJ8mBL/nKIdjhk5WA5MzLYuZH6/cTtbhKQZUfka+RnjiKd5HtBfWrrpdSyzJAYeT961gwWf0tKawHijpkO6x3GhVrTtno/mCBJZS1uvJR18kYCrOpyLylqDPTddZEQjPSCIGJmqDiijxcxuU1i+1bBDqtwkLgOAQTUYKWjWGS6s/ebT2m3ILoyBqODXG3BoXPfxnwBxVImFYywWJFgtMGJBl1qY+Fk7gIv8WIVeqfbjgKe01vcqJxIug/f+Y4lYdEX9nT2ghCg3IEWIlZE/wPBOxeK2wtHtSFAa67g83V/hdcIJ8LxCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1T9pxfbxjmsgL8zxOZEhHegnPmlymlB1qXyMAOZLP98=;
 b=YNjoVuVmP99KjY3OUKiZUlhAyA8AIdG5TAgExhvkIbNgUAT0F/Ygx13iFCvIL6WEopfv4dQQ9ck0fxVKV0dz1fQhyGGNu6zIatYfc05ZdRkTDKE9jenKGUHT3orjNCnc/bzimmzqwuC+gEf6lKCLXbgkf1rai2SdY20h4IspsRE=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by DM4PR05MB8965.namprd05.prod.outlook.com (2603:10b6:8:a0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Mon, 11 Sep
 2023 18:40:52 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::f967:2d39:e36d:d1fa]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::f967:2d39:e36d:d1fa%6]) with mapi id 15.20.6768.029; Mon, 11 Sep 2023
 18:40:52 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Qi Zheng <zhengqi.arch@bytedance.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "tkhai@ya.ru" <tkhai@ya.ru>, "vbabka@suse.cz" <vbabka@suse.cz>,
        "roman.gushchin@linux.dev" <roman.gushchin@linux.dev>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "tytso@mit.edu" <tytso@mit.edu>,
        "steven.price@arm.com" <steven.price@arm.com>,
        "cel@kernel.org" <cel@kernel.org>,
        "senozhatsky@chromium.org" <senozhatsky@chromium.org>,
        "yujie.liu@intel.com" <yujie.liu@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Muchun Song <muchun.song@linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Pv-drivers <Pv-drivers@vmware.com>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v6 27/45] vmw_balloon: dynamically allocate the
 vmw-balloon shrinker
Thread-Topic: [PATCH v6 27/45] vmw_balloon: dynamically allocate the
 vmw-balloon shrinker
Thread-Index: AQHZ5JU93wlJq2PwVUmGqtJtah5CibAV9X8A
Date:   Mon, 11 Sep 2023 18:40:52 +0000
Message-ID: <D6970168-2C9A-4247-AEA7-C6A7EF72A7F6@vmware.com>
References: <20230911094444.68966-1-zhengqi.arch@bytedance.com>
 <20230911094444.68966-28-zhengqi.arch@bytedance.com>
In-Reply-To: <20230911094444.68966-28-zhengqi.arch@bytedance.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR05MB8531:EE_|DM4PR05MB8965:EE_
x-ms-office365-filtering-correlation-id: a0e55204-c5c0-4b53-3a57-08dbb2f6a03b
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZuM0eT0nYjP7WiKZF5E3wrg+ux9OvIbThY8ztD4kTjr/gy66Qpj+uwEw0tqoVu+UmYWADzDG0TrraYrn+a5EUm9v4FQM/0K0C5zbg2sAumz0B41U1uNfvHVjw8xRENz94erBuMApYUlfBvRHRIzAVHZ6Sx7bu5xUx5FEVI5Gw4fAIK6n+7EdEtBGy5m6bOVy2y/frmnc6cMuksi6bl9nfY3S/bDnlorElZNk1fp5Yl7vV2QN+3luXNPRy9Y2Eo0YW5Orvt0d/CapaXrGPnnbWQAxJt5HQvq/xfZ5XR3KH42YCTzvDqHOVEnLiQ16TVzXxaZrj3qDAcDrYhYNIQN6e4SEBzY46ffj68QwYFpDqN2lWtynZCOY5lYdTy9C/p0CQQY4nFBt+vlUt50gU10fVr/WYBqvPNVZNiW9qENK1hN0ak40F7fKtkyGrP0xlPjfqwbeu+v9Z4sDBVVedXni1+EDUMzx1Xw+0YNHCqQGnZHFwLdbcHsXTnmtorwkUfmFfb+VPewThcTbYzUu46SJUzFQN571B0ptNORU8+NYP2WvoCdYrgyp7QO/o0fw5OcDlbmgFxSGQ5cEVSQgj8GHpvEe2fXelS19W3GYVYpduPfgdil2Q+xmd4i1WTHTqXVyZIWXtk3sv7Z750OL28eljuWkqcvHQlNFpvyfatEcmpaKdQxCi24VLEHOfBLzuwSm8XfadNU1OyXFGuaLddHhlQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(39860400002)(396003)(366004)(186009)(1800799009)(451199024)(33656002)(26005)(86362001)(36756003)(83380400001)(6916009)(66446008)(66476007)(54906003)(66946007)(64756008)(76116006)(316002)(66556008)(41300700001)(38070700005)(38100700002)(5660300002)(8676002)(4326008)(8936002)(71200400001)(6506007)(53546011)(122000001)(478600001)(6512007)(2906002)(6486002)(7416002)(2616005)(4744005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Evqsv+r38Hv4/IxKItwgLDgt6Y/YSLrF/EVbR70cJGqccP925UHa88NMxPb1?=
 =?us-ascii?Q?O0uZVwmC9LaWD7bILqxny9kT1TBqzULDlevsgR1gMmEKyD4EqgPo2x5mfhV6?=
 =?us-ascii?Q?K7OWY0mzUU7RFibE2wfQCFDbjNck7Ro7eBkSIPW/oWL5ptP0pEl3Xv2eYirB?=
 =?us-ascii?Q?1UOySjqR/0kvWF7DJ/X8xpbh0x/xx4rafb2YbDdMJFIsHnZg/XtgAavhvc4e?=
 =?us-ascii?Q?yz9SSjHuZtGG7q1e8hXz0vpX2wWYZRzc5ePN6jTpMdGSYNfvRPBUzXdqoGFR?=
 =?us-ascii?Q?f7V3hpGrOdQX2TxuX8K2L/Z9xYiWPKFZrlELYsD1V8x/YflvbKdUOC/xN5FR?=
 =?us-ascii?Q?g/eby4fLwPz8gmqH++1JS2U3Ec6u5RM7TEqOJcasesOoGDNPhohDNlQN9pn9?=
 =?us-ascii?Q?wU8Rv9qRenhXVFkkMnv2Z3F5IAANBO3QvhRKdE/y8dj21TNkqnG1i0Zsk9VL?=
 =?us-ascii?Q?rkCgS+TpVKzpr97Q7rM+GeAWwalADLwYYnloh+ayMWex9jtVkbNxpuQdSG44?=
 =?us-ascii?Q?eyfZx1IhrpbDElM8TetsbofPpAQblUbHPpU0uJ8oTjj4lHUL7UNYyvJAAxyS?=
 =?us-ascii?Q?nLPhv6xwhT5ZkvKcbFoeXZqJbxR1Iv/h3Cum8jtoIYfB7kERuVKNwD7t83G7?=
 =?us-ascii?Q?4/Wng0b7PD2MlJTQzjP2A5cFgUPRkaMaDmy9UMaT/D8E3XcXEntVvR/QwFVc?=
 =?us-ascii?Q?mvyEjKgfzut4jic45k+aI4xDJqhtvi3pTRh6ywQ+++PaCl1GfT0uE8cWJwhl?=
 =?us-ascii?Q?K1bSqIpGJVDr3YCe58PYz+jfwCnTMUba/9nhDGIfMwTHANB4igbyMIwjsEt0?=
 =?us-ascii?Q?kJa1AI7lgiFSSR46Z/GzLLF8CdBKVM1rzjCIjxx122JebjMmcZv3WqUpF8th?=
 =?us-ascii?Q?/kwDp7DdZbe7lq6LKhZH91QzgNdQECb9plzjuJ1akUQPm7qUri6qMmx9WOaP?=
 =?us-ascii?Q?CPqx38/taLQl9BVvdMlKL/Ni8J+ms2pw+cQuzZmslzDiur0e6swvhsDXJP1o?=
 =?us-ascii?Q?bQsxbIt4K5fnEzQplEKdI7wEG7C+VSeRuHVznNhtcHHCUPVJWbie2F0H6Rc4?=
 =?us-ascii?Q?hdk1h5HWepluxS1iAmcIYGholAhIhlzQEgQ5x69+EwNafc+iNKVuWbjFE/Lq?=
 =?us-ascii?Q?K7GWlx0AbtqYL71TAVQ5BbNicnfdBnBMvE9tparlJWh4uFXZ+6IrJEy1KkvX?=
 =?us-ascii?Q?u8bUTp6Nk1edB8DYbaiWcddPg4D0DK8NETnRZ08rlI8/h02yGA7idjxR3bcd?=
 =?us-ascii?Q?ZNgHsvChR6QBg4mXuXXI37yUUyelxwPbI1BE36wPlMJ0pnRUBqK6NTwTzj8m?=
 =?us-ascii?Q?7CKTXjzubcER+5kJN9Yj9uxG7NW6w9kMSnBpkT+59LCiBD8guVAVra/ITY/1?=
 =?us-ascii?Q?LFxcJcKBEQPBaudZXrhZK3mkh7P1W2hxn7LuceSaxbjnHQODc/Cs10ixk9QL?=
 =?us-ascii?Q?2PDbOGmXAHFzf27Gu5d0PzdVrNKemBi1ncBpZKYGsRFD8dDrCLz20wXwwT9R?=
 =?us-ascii?Q?oZhXcRIzK1TzayHqzU2HmPXmbDqnRvDj04i+kwdDuXJXjtqcqtk9gd0aXPAm?=
 =?us-ascii?Q?xFENuh81OU3vv7j+RLAP7VuCKUNmfQVWAHOE8jsC?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <ABD1BEB3CFC9034186BEEB0F2B2FF87D@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0e55204-c5c0-4b53-3a57-08dbb2f6a03b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2023 18:40:52.2601
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OSIYJYMZ3VejcCVFk5aLvKN5S3xcsII5hB4wWWEpkXHAdVVGNgFCzUmU2CJag4slL6ZmdOtWxAVV5ltkUGONzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR05MB8965
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Sep 11, 2023, at 2:44 AM, Qi Zheng <zhengqi.arch@bytedance.com> wrote:
>=20
> In preparation for implementing lockless slab shrink, use new APIs to
> dynamically allocate the vmw-balloon shrinker, so that it can be freed
> asynchronously via RCU. Then it doesn't need to wait for RCU read-side
> critical section when releasing the struct vmballoon.
>=20
> And we can simply exit vmballoon_init() when registering the shrinker
> fails. So the shrinker_registered indication is redundant, just remove it=
.
>=20
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Reviewed-by: Muchun Song <songmuchun@bytedance.com>
> CC: Nadav Amit <namit@vmware.com>
> CC: VMware PV-Drivers Reviewers <pv-drivers@vmware.com>
> CC: Arnd Bergmann <arnd@arndb.de>
> CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Acked-by: Nadav Amit <namit@vmware.com>

