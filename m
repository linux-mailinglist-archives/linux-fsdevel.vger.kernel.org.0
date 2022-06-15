Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBFD654D486
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jun 2022 00:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349547AbiFOWZR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jun 2022 18:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347056AbiFOWZP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jun 2022 18:25:15 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB05A2F027;
        Wed, 15 Jun 2022 15:25:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I5dUgL904Awaf5GB87Ph+XT8l2I9ZlaqfbLcLK7VqN0jRVaEvJJehcmFQ7ogj3nvgWWxrzhiYn3cP4gYOh6M5YnMWKTGVxwHceTn08W+M2+IoEJKdrGcmmefE2fq5VMyN3zksnzrBvZi7cXEwBMA84XAyzdAC9bG2SuadVvt1R2gCpaP+SquUisWaJ184JK+J0ipd9A40ofQaOLfIUKx/9XIlTW2uGztSg+p2hyw1XqyBz4XSRdknbRHuItgMjXswqTK/myguyCdMvxilzcLIx0r6/xeiobx1+JQAjNXjwTq5no1Ot1igvsddGbBACpDKyLQwxnJZI7ecbjdd1QPmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=one2GZ2Kga2hjrWKebUneYR1HHafhg8oBuExZHY7A6Y=;
 b=iJbgsbWgxH70dh5c/GulvbEKc42rvCfDl95GkVDTIYCz/9fDqtke13y2H0u3IuvbRnDPcGfv4U+3w6WgIkMPbAJ1p8YNu6Xqwjt2hCpqDgMPdD7l6KtINaCZFALPnQ4wuxuEhATkNPmE8atQZ+gD+tXJUYSAVevSUJ3j9KiOqQIorXuakFuQXA2pNzCmkUOD4kh43mStkg8T+b+Le3if8WHiEs0oItOwV8fDGytKoqNCZFxYIOyHaJcFnajl0/P0VpiTsSrEn/Sfs0atOvvSCx0TkzL/WTgCXzy5NoSsMsjQFaL/jplI8SXs5Ym7SESb2u21fa3jIzNhMHkveZn1nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=one2GZ2Kga2hjrWKebUneYR1HHafhg8oBuExZHY7A6Y=;
 b=x9TJpMbbZYFWYYDJLj6sUFSOrM4V1qBvYQqMAcdIOVtz1VuHUIMOU11X7UtyVZfkjV+uaLbgH9Y8sgBxs7YLhEPnFkFBmo5DCDLywgCOfs8dNtmxpAJFIm4zHLKl44903tDx+INGA0KcbbFq37+KGBs94H86Ol3NjYZaVa/uKi8=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by DM6PR05MB6538.namprd05.prod.outlook.com (2603:10b6:5:130::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Wed, 15 Jun
 2022 22:25:12 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::a4f8:718a:b2a0:977f]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::a4f8:718a:b2a0:977f%5]) with mapi id 15.20.5353.013; Wed, 15 Jun 2022
 22:25:11 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
CC:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Charan Teja Reddy <charante@codeaurora.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        Jonathan Corbet <corbet@lwn.net>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>, Peter Xu <peterx@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        zhangyi <yi.zhang@huawei.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v3 5/6] userfaultfd: selftests: make /dev/userfaultfd
 testing configurable
Thread-Topic: [PATCH v3 5/6] userfaultfd: selftests: make /dev/userfaultfd
 testing configurable
Thread-Index: AQHYdfv6fDyMczipnEG9l81JJqWcj61RIZWA
Date:   Wed, 15 Jun 2022 22:25:11 +0000
Message-ID: <7665FE27-EB0C-4FCA-ACAA-B4B37F87CB19@vmware.com>
References: <20220601210951.3916598-1-axelrasmussen@google.com>
 <20220601210951.3916598-6-axelrasmussen@google.com>
In-Reply-To: <20220601210951.3916598-6-axelrasmussen@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8aec645d-7a29-4aa5-f066-08da4f1de99a
x-ms-traffictypediagnostic: DM6PR05MB6538:EE_
x-microsoft-antispam-prvs: <DM6PR05MB65389BF7A0851F540E1C7972D0AD9@DM6PR05MB6538.namprd05.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qdyyNUdH/MnrZLe1WxnN9kYcMZEaCKdj41OEzS+JM+xxPqPwwbLxv4UScrvR/dThmdvkyvxKDZhNkKMooAeudFZIzMhC5FE2qzSjoG3S3KHgHC5wQRWfE26u5uZrKjycCoOkMQhmS1QxXwDn/dLXwLSiC8CHnEJqM3aUIdy8CBmD3942c8Wsb7mtlj+GXr1nQ4V0eybKt488vphfsSuiolHCv+NL4fc0cBSkfx6x5ZGun6YDHCGBTcmbKwOxtuS8SfvxEL69ee1O2r+dc03UFI1wK7rK5MPbzo/x2OGNrmZQaNC2ftO+c02jZf/pEpQop8XyIg2+BKpetFzPe+p4F4/s0TlWjjn5dA1Fj/yNoce+7/5cy1q9THuuEbLXD5CraOYqsmgsxcoGr2ew/D2QW+BT8XyvvTyXiT7g8SYRXTwU2oI3odsUNv1UrNhwCwOgQfsJHtFKN2g/66utKpC7Us/9fY2i/IZlOEyxcSvLoc4Whgwe+6ZJbO5UQV+CejeBvdjzPrsgesVJaDGWL8MXEoa8lNEjkSVbKwjBhYwLYKpsuE8EkWZ99Vj+vrmHVNM+RBdQ63+8MV/SXs6/0zC1MyyOSqj74cl4z2sIxPwjar59b5FPrJ6SDvNsEORLkctxJLxZL9/c4HcW9tsNHNCX5ah7e84vVkBGFhhr7yOuWI/0+jtph77ZZecso0td/vDlAoZFoCPs5Zvz6h1mNkqimXaKwghbwAO2iHIkGzqyzLoeJMihnBXpFdRWlrtTfR+tL1hbx1eJwxYpNHLwI/MIhP79F+T3EnpjGtzuXsp7d1b/L5qjMzLdHhOrYjwULTdZJGxH2Tv49+I0+ZsnAKl9oA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(6916009)(71200400001)(33656002)(54906003)(38070700005)(5660300002)(186003)(2906002)(7416002)(36756003)(4744005)(76116006)(8676002)(66946007)(66556008)(66476007)(316002)(53546011)(4326008)(66446008)(8936002)(86362001)(6486002)(966005)(122000001)(38100700002)(508600001)(6506007)(2616005)(26005)(64756008)(6512007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xvni0SIxgt6F/3CDT1ezacdC0bbUZk8L0yyphz7O0Cs3x4OhEJ9tteXDE0qv?=
 =?us-ascii?Q?9IIVD8xz2WwkKOBGD2kxR58fgDA85OVjxLJGoAPo1cBeKaFVfyDYyAAZlgjV?=
 =?us-ascii?Q?/6lC8fmGqRONLz4UWbhNxzflBa2IGckzE7Cr0YkrZnH118d8HI/5CsJX+Xr+?=
 =?us-ascii?Q?Ry/2DPuESJpSo+bXGGt5DARXT1nA3IBeoKHE36HJXBbgv65+74UufT4i6k4n?=
 =?us-ascii?Q?FeBq4nXhlK4cNm2UzT3+zeX5S8GMVuGpPNWE+13fpPR4/MpdKhtXo5N4HTOj?=
 =?us-ascii?Q?cAZ4wufOINFRI723Zn9llKXql2kGUs1BI7SqPoZaz6sjn4DJsahbRT4Cmum3?=
 =?us-ascii?Q?F3jWkdu9IiswB2LzAaj6987R4OJ9XRhFh+J6a/ztvtHsKVOhxm9vxfWD3x22?=
 =?us-ascii?Q?k8H2Dw1/zFlFzJvGVvJQFNYufZPMdEEZifocZTJ6B0Hb6LB5VIW/lkV+ZPtm?=
 =?us-ascii?Q?7EfUzebASUeumrx/ynQCwKBXEIPWaZkDn+L3jHoe7Wz/rgdHzVn4dJG1WPwD?=
 =?us-ascii?Q?ofY3stBxd0y5qDDvS/zn8P7YYDwcSKdTj+7oHL2DgFuGGXLchEwibGZn5sMu?=
 =?us-ascii?Q?2kxF5nR38vc5I9woMBHFQqhf9PZHAQsqvwvVyVgQVB8hcDVI3zGFEh5bYdDm?=
 =?us-ascii?Q?7YI68TUl3bYgM5Lbcwhr4qW93JDj2qST1Ny/2cTU9QzPbfaacKLgfUdSei2S?=
 =?us-ascii?Q?QTQmvExSj0ff70hqEcfnoL0zpDsOHGWiswb39aupywH54msWsqZLV53u8EAs?=
 =?us-ascii?Q?roNcUel++mr6mFY/B9TY96ZjjIxY6HMdfFlkPtiGpiMiAt1+QgKXSIFcMb5u?=
 =?us-ascii?Q?+C6U3GWUOpw0Xz+rXapp/HWom1udJ2ZndZwn96gn0nbjWJZ+dJsyNWWcWXVZ?=
 =?us-ascii?Q?6iq16ILavkyj+XdO2VkUNyIOcQuBdW8XmMlQK7Kw9nt9RLtvsmt7sirgQXoM?=
 =?us-ascii?Q?e26X1jnNe6OcAPNYe+5O98MepsNqTBLUfzDHuiyfBj2BsUBbFMEkascUuv6z?=
 =?us-ascii?Q?Qzf4abHuB9uB5bPjcizQCHqBm9ecUrIrOTh/HLo/kzUeDcvy8BkcF2q4GscO?=
 =?us-ascii?Q?Ry5lV5LASM22YZ5tTi2MiLCJhxWN0OXBQapZqmfiKQhxzITHko5iZB3n5Azk?=
 =?us-ascii?Q?n+gl7paSOZ+jiDVfYCP0f5F8H573Gp1BUFjj/avA0ixanU7PiyI9YopBLAHL?=
 =?us-ascii?Q?kBlHIKipo6huAYf5OkSUgzD/n8X7IN838Y7MRhs9ivpY5TVD5gWF15U5dXP7?=
 =?us-ascii?Q?UufKvjwTwS8rlin+FnCU3k5pOzi6aJIbsbLI6e+nbPZo3QDi4hziztMzbf/v?=
 =?us-ascii?Q?oFKp/5erV/pPxEPCVu7M40x3311Btd6Tr8cBFEhv6md2u+sSarE4dyP42fZK?=
 =?us-ascii?Q?L7iCyc15Ht5CUta7yM26zwDbkWAKpytHC9ThW/3TfDykXJ+RYToeIVN5XhJV?=
 =?us-ascii?Q?A31DCjq+jpJQlDQ28aaJFF5CcJX2KPBhEd/qWL8Dk1Za10UQlkzkawH3Tq23?=
 =?us-ascii?Q?PtIZC7n6Iq/93b6cQ11FIgvSe3wwDg9b6a6KM59hwWLyMutLa1A92Ye69KhH?=
 =?us-ascii?Q?wyBhaTclDJS4vNlBrSA8Oc8muecBOKuDXcGbBkxbeOjBxriexlvaqMt3DYOD?=
 =?us-ascii?Q?zE+HwrdGxDJeTtZbBbEcwxvDz8imS6Cr2q3Ho4bBSB8xW7JcB/k8RoIlEyBB?=
 =?us-ascii?Q?4gK1uUAPVNwheMkUEFpNC+kxkYdjz3slstxwoVBPPIjvRrQ5LrVCOZcsr6pz?=
 =?us-ascii?Q?EeJ+IkdP3g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <78A305CC8349C94FAD25ABBFD1E25239@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aec645d-7a29-4aa5-f066-08da4f1de99a
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2022 22:25:11.8081
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: igsPpQUdj//u5SDQzz9K0Mk33jqv/ZiZw8T66luGJwhiVLs7F5vBzU76Exw/Xv/L+pLlRyQX/2eS2RFZ+/ZyxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR05MB6538
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Jun 1, 2022, at 2:09 PM, Axel Rasmussen <axelrasmussen@google.com> wrote=
:

> Instead of always testing both userfaultfd(2) and /dev/userfaultfd,
> let the user choose which to test.
>=20
> As with other test features, change the behavior based on a new
> command line flag. Introduce the idea of "test mods", which are
> generic (not specific to a test type) modifications to the behavior of
> the test. This is sort of borrowed from this RFC patch series [1], but
> simplified a bit.
>=20
> The benefit is, in "typical" configurations this test is somewhat slow
> (say, 30sec or something). Testing both clearly doubles it, so it may
> not always be desirable, as users are likely to use one or the other,
> but never both, in the "real world".
>=20
> [1]: https://patchwork.kernel.org/project/linux-mm/patch/20201129004548.1=
619714-14-namit@vmware.com/

Thanks for pushing this change! Your code is better.



