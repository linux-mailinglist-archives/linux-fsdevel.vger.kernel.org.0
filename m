Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C003773C5B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Aug 2023 18:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231699AbjHHQEw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Aug 2023 12:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231612AbjHHQDX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:03:23 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5600BC;
        Tue,  8 Aug 2023 08:45:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pbg0xGOCYYTawii4xH2zWytnxeWIPFTrt4kDMug8QmW+Lri65lprNxPSXB0tJJt8arzlRxmy2KWXI8QeGw2oNoQBqqvuS+FAWQOt5ia4D9K50siG7gV88v5oHCpAHAChalO9cwPqwECFmpywGEEGwcHvGzScoHV50rnPENyBDc9aGqHgcy7XbE3jqWTsLgG9r72ahXO+s/FZmVSUlS4udcxxpIhYgU3AoWHTzsYRwO37hRzKl2Hj2guB+BmLBVQeonUhgI9gkE3My8IuIm/RB3GmADVbryN4b8etLLTvjlqwyFZBI+AKSV5XGZhirvzTMG1A2Jd7s9eXIw8azCW6Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7guSE/On/Af6MDAkEypPOZndSAV8AV2RCD5K0lnYs+Y=;
 b=QZXri4XWZ9TYZ59S1m5e6gYAWxEEQueOb2nYI4vAZsK1hvfDz7UpI/0cf97ZSXyJvNBtlppTjzDc88BZNBtes9GRV6MUrSEl9dgTFh/u9z0LbwwIusYr53pirR/Mg1VZvtf+omnBtW7IaxPX28Y+aAxDOIWWT34VgZVo+QlAmA3eRGdK6j+X+ha+eFK0hjrtA+asKr+Y0Y3ppWy8VSYs6S3mYYpSOmyWbdnsx8O1S9WRKSxVjBHnDoOQFXe477iSVt1mkPvfD/gk8xef6h/R5kvJupgKfgbg3MxmIypnnS0n4I37vNDWNhpI4yxQG02M7fAdUFOpp6l0fNCo9I1QXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7guSE/On/Af6MDAkEypPOZndSAV8AV2RCD5K0lnYs+Y=;
 b=SjHt1r0MOAszMQxKSR5S+6l3VUa1SsTkCi8DGmf1ZDuWdlpI/cK8U6dlhxsQmLRIwUBv+eoTQOb+br2b7c9/Kw5aJ+y0g/YCB3LQz5LmwHu2jCdaOfH5uNPXxhQQgv57Y7i5IMFzEKQPpyfv5+bjP7wyASxuiiqP7+qrPsOHPIYO3lqPy+/F3obb80ns/ZX7cerpSOrJwcayDhtjGKcuIu/2NrEHgmCRchFr1HgRey7wiWrd/Y8oWnD9cxyC8kA1Bo/n9H+jDyhsY/HjRIM0fPz/p0I0yDEksmsh2Dws4iLozDLdh6K/6RKp4b/UVdxlHeFrJ9NrimyihAMP0YbTAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 DM6PR12MB4401.namprd12.prod.outlook.com (2603:10b6:5:2a9::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.27; Tue, 8 Aug 2023 14:45:37 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::c166:b535:d93:641e]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::c166:b535:d93:641e%4]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 14:45:37 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Yang Shi <shy828301@gmail.com>, Yu Zhao <yuzhao@google.com>,
        linux-mm@kvack.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        "Zach O'Keefe" <zokeefe@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 5/7] mm: thp: split huge page to any lower order pages.
Date:   Tue, 08 Aug 2023 10:45:34 -0400
X-Mailer: MailMate (1.14r5964)
Message-ID: <A6C02D09-CD3A-4F12-89D6-F1F4B03C177A@nvidia.com>
In-Reply-To: <b545cac8-76f7-e3c3-0e1c-3cb922c9c9ae@redhat.com>
References: <20230329011712.3242298-1-zi.yan@sent.com>
 <20230329011712.3242298-6-zi.yan@sent.com>
 <b545cac8-76f7-e3c3-0e1c-3cb922c9c9ae@redhat.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_B9F89779-6ED9-4666-9B7F-FF6FF172146B_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR10CA0025.namprd10.prod.outlook.com
 (2603:10b6:208:120::38) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|DM6PR12MB4401:EE_
X-MS-Office365-Filtering-Correlation-Id: d1530fa2-a290-4caa-b353-08db981e20c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EjPZGAvBBJ4IkJ+tPLobVY2xBO0feHIOzJf8fWW5MZ0KkXXLKHu+VyOnjtgn1UJ+oj1LQM4liFckjZJoi3zSXMlZHyrsGWbXqI47QmIe8P/qxAD6Zb5oox9x8ctH91WBlxSrDj/A0lFe4/ri1JO1SetvtKxCMPbO9WFNR3zB7HMqUv9ncVhhTLQZtdQ4dZ+ltW5KTqNBJOh+WdUgEum718J/5nFXvjVVmJWAJTOYWnL6xUpNYmgjiDgwOoHxpic9dsum5f1wsa4uPdk1SQzf3zX4ncGJEteJc99gO0Xcr5nqOcY5797DDuuhcSLSYqaqm+hfRlfwdGwG49tjgPbsH3tgNwWJWVrDCNQ19Q0p4flApe8rLw+auufOMC7YgXgVia77E0SmCkzoN9D18J8oJzpVcWGbosipZOkcNOtcozMMbuoTJ5HNJnKg9mel5v0rrg77hmVLXLGVh+Gg+CA6f5ySU1i1rv0WKexarifpw7A7Q0IbZOf+lvE7HHktMkTJVUaY3v6Qu3O7j7q1SgBjhBmf8YZrTMbfvxmc+Xe3ZJYN5A4EedvCvmfW2g67kv9EZErm2uxIwt3vt2/4Kup1+YgBKbjBlGANDZzfklntCdbeKVyXnOr2tFKBWtbZUGcccdFx5QOL4h9KXcLoRELTisz2PpOMOdskXEst8etAzEg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(346002)(376002)(136003)(39860400002)(451199021)(186006)(1800799003)(2616005)(6512007)(36756003)(4326008)(316002)(6916009)(38100700002)(54906003)(6506007)(6666004)(86362001)(66946007)(6486002)(66556008)(66476007)(33656002)(478600001)(53546011)(26005)(8936002)(235185007)(41300700001)(8676002)(2906002)(83380400001)(7416002)(5660300002)(14583001)(72826004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tuveEswnXg7Dip2wkuPSJYG9qjPDc08i+8pMq7gJwPM09clFY4haVSnTPzr7?=
 =?us-ascii?Q?wyRqzVVMTb52/ECnztJjRzgl5YXERbZAd/3bBFONAP8ShDSqN9eaIXdY7aN9?=
 =?us-ascii?Q?F8I+wL9Jqihy9/DBBS19+kHMv3WpFTDlf6Jvvjl86D70SYvQWeUliFvO3EAc?=
 =?us-ascii?Q?rE98GThgpsHPC+0/wBvgCgFsbYY72XtjPJ03SIGif2o05aqOtYdx1V4X0KJE?=
 =?us-ascii?Q?ZJ9N7v6ielO5ev8s1+t7Sb+vTF2Q4n7gDwtd6CZepBWPZ+eDqg7e/gEJpf4M?=
 =?us-ascii?Q?xNp57HE+ZjNN6jMB+NjL8oDpL6DSzRMBXVQZSO1LR7xpRJfnuvilEMVIpN/a?=
 =?us-ascii?Q?sYRsIJigVFOjMmZaKeUeTcIUQWwMBgrF6lXJR2cFuEGMDS7ALDrRmQ7GsIHK?=
 =?us-ascii?Q?1XAbSZhoEAb0RLib5OzkfcFXCqAxLPdPxih9BoPJpKx01AkbKanvDqaE3Wwi?=
 =?us-ascii?Q?edUxOid0jL2iA3KtAGUZcdj9XtjGX7+yJjO4/vA3Inpc6nlS3AvQmRqusJum?=
 =?us-ascii?Q?uFKS85oRCREvASpqbHdKxDEorWJQ4WDzDL9CLo7ESWI/gyKn7lULX2eAoSPX?=
 =?us-ascii?Q?0okoJ5DG1CwJjJbUgYFO8wiIZL4sHecw6tVBn2wdvC8MY7jZ1w/eNlhntLG3?=
 =?us-ascii?Q?F4t6qNnz6vjXy/44V2sNlLQyK7Csq8x90IPzZJIB19ySOpIRed+8BNIwbowC?=
 =?us-ascii?Q?/XzKdNJLhyQKN8wgi3yFg6gtvjvjxyJQBzUqjaZnGLfnnb4dWzflOYjYNFm5?=
 =?us-ascii?Q?IhUM39wO4xvfw+6hkJYNFdOiv1k3hq0qH2VyrWTQzBUnSQjrdJUwASdemRqc?=
 =?us-ascii?Q?jCvlspl3ttVBYe3PD73FhEkTNqNAERAxFIwIaQU0JeMT+WOwxpiHhrh7doqU?=
 =?us-ascii?Q?hmSlXCQ/1I77WoGrNGheuOsrXkaEVoCNjgTbUOj8ITb171aIL+Pfxup1e+yr?=
 =?us-ascii?Q?WCIKuKBlcaVtYj9sGJw2ZkbkzCnRyTK+Yzm5bsjUVJe70XnOZ1oQwNcjh/Xm?=
 =?us-ascii?Q?DQVaS5mND+nzEKku7vmICPOfVsg2S6ZeLf121VJjhvaTC0I8WOzzs3QiSqyT?=
 =?us-ascii?Q?pa6HEq1NoLKAPIurpmBvKF3J1/PNHxh8eyDLwma2UpAKCOKtmCjOsRkqDD85?=
 =?us-ascii?Q?7UYcvnLgAcK+lF/e644hHeShSQ5SYNuetoqY876X9duAte0C+s5roNC3/Nfr?=
 =?us-ascii?Q?S/tUKXs6hpHFMNhG8LKbV/iBQ43mupoOnY6UwQggkEcZmU2VAssw/ZihLgGq?=
 =?us-ascii?Q?AE4cTBqVNljKHZXBNjf5DKqkXIKShkXwT355b9U0kqDP2iK4T5iSOa7lsio7?=
 =?us-ascii?Q?ygeG4WsqE6So5zu656ady/M95+cmmntypghfnF2Ng6+mVaZMRudoIyc87Me+?=
 =?us-ascii?Q?bWI9x1BPJfzKeoZys+sfNacwy50KBbdrwITKGyS+Vx1PJ3Exv2v/sfefDDKk?=
 =?us-ascii?Q?N9jwA0eLfKgOM9oCmUlLnqlggeizN+9CE0txHulBXkWMRJnaQK7XtHbKry10?=
 =?us-ascii?Q?sr9tYdEBv0rOYt/2N1ccoodq4NCfb91Og7B9f+4RWw3X+6Fjc5OwO8inbS6w?=
 =?us-ascii?Q?eQX7mZelLtptZZOShmou75fr6LT2cyp9FgN7xxeR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1530fa2-a290-4caa-b353-08db981e20c4
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 14:45:37.1009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iodjFmPTfQBDhiYxms/d8me/hcArJh4gUqFUSbz42B5/3JqJbwDL2KePPQkSzxfL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4401
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--=_MailMate_B9F89779-6ED9-4666-9B7F-FF6FF172146B_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 8 Aug 2023, at 5:01, David Hildenbrand wrote:

> On 29.03.23 03:17, Zi Yan wrote:
>> From: Zi Yan <ziy@nvidia.com>
>>
>> To split a THP to any lower order pages, we need to reform THPs on
>> subpages at given order and add page refcount based on the new page
>> order. Also we need to reinitialize page_deferred_list after removing
>> the page from the split_queue, otherwise a subsequent split will see
>> list corruption when checking the page_deferred_list again.
>>
>> It has many uses, like minimizing the number of pages after
>> truncating a huge pagecache page. For anonymous THPs, we can only spli=
t
>> them to order-0 like before until we add support for any size anonymou=
s
>> THPs.
>>
>
> Because I'm currently looking into something that would also not be com=
patible with order-1 for now:
>
> You should make it clear that order-1 is not supported, like:
>
> "mm: thp: split huge page to any lower order pages (except order 1)"
>
> And clarify in the subject why that is the case.

Sure.

I will add below to the commit message and the comment of
split_huge_page_to_list_to_order():

Order-1 folio is not supported because _deferred_list, which is used by
partially mapped folios, is stored in subpage 2 and an order-1 folio only=

has subpage 0 and 1.


--
Best Regards,
Yan, Zi

--=_MailMate_B9F89779-6ED9-4666-9B7F-FF6FF172146B_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmTSVQ4PHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUANcP/3yZuiZWzhU5HjmynjKBIMR7eGcLOBQ5fRvR
FhT7g5vFE7BRQwY3mMomckjStXE6Xiy4BLL5m/VkYv8m/Xnf7M49tjlmPBZJYOvT
/X29IvRo1iJLXUYRUOaDmMlkcblpcwIGdKNmYsVSMsMrmeKyYds8nMP/8R0W+oJP
g5U5hndjPq2tNI6w7Ca5cyIfXek9wRebEmtovybk8tNw/uaRVj046L82Oo63hiYj
czzjV61LvBd82Zu5VKBHwqHVcSfAIct3fkt6aOJscFANeUsQl3EYiOofAzDyEGq+
L5tVe9EDSt+pH9UHvnuThrhttEKdkHFZHnzeUcrRQjCB7EQotdMNxwB7ZfOJ4LVc
Hlg/PfV2+aODadmjtcOg0dhBppRV6z7JwZI+oCTRDWpmNID0eNvVlz5Z2Z2/JxY4
8LKZ4//7Q7XWTGBwj9P7o6jtDUd8yflhP1dTBofafBPQldknWxj90P5OUgomF4bE
O6r0Gri8Xla1jJLx4tIJ2CYO/cgCNtSaIFXEWVFp/tKJJQX5SLKyckNbvEODLZdJ
Rz1Nqb6zu3yhMpZTgE/Kznkj+AVPcI8f9SMGvAy85dcdzWFPgNMx5z0qkgwUF6MG
LK1OyDN708foIYISU8AaiekagwwkkDKQaxysWhCRf7ylc0qyBz3O8vzQog3Dg2AO
eIbafFJL
=2pY6
-----END PGP SIGNATURE-----

--=_MailMate_B9F89779-6ED9-4666-9B7F-FF6FF172146B_=--
