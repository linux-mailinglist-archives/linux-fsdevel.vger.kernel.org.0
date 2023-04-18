Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AEB86E6682
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Apr 2023 16:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbjDROA4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Apr 2023 10:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbjDROAy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Apr 2023 10:00:54 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E711384F;
        Tue, 18 Apr 2023 07:00:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VMSh4kH7aqm8IXyS///y221nMuWrMHuaWqLdM78l82UDNmBxF3SlZP7vnV2CUkuyQao1fa7haS/0Im4IZjrarFiEarleBcAutajvJEX5aTYLpJOWAC0bP7aqMWnLb0TDXqKRRn2LYc1OTuDsCy2tTy60gIy9UN+IC49ziPtmp/93J5nz+oc8CiAGk+M+s7XQv61xs2ZMt4cy4w9XtWHLPxNtyXr/6D1WE2CBY1+5PNWKb16m9Nj0Cqt6SqzwFxST7P7JZYeFmu0UOMbYPy/YDh4C0WQndt1FgZ8Nd3m2/XqZ7lK/z4WbzDSwUbe0NTAmpWXIMJXWWltM4egj715wbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uB18raNWnmeNPDPC26CDptXk7WiQSIQT7vl2EaQoqSY=;
 b=kSjHSEDgbUHlwY7se9S2XVHeelyS8I9LtFGpHuWToXeOgSrb3jkLEkzq67LwT3aCzrxXFIXo17JK/MxlZv9IHDhByb/hYGYCWp8+gArK4BeY3s7qWba+CUhRmgzanbaR4UUah6MKvVpqr2wcGMkJiqKoB3Cl458bg2tJmU6Okeu/mEPd5L8+wwxew6xr8ujfFDNQ1MMazXyLcoylvPjEZCSIwZVi0rPUEXXUR1OWDiuvjVs4FhHpg7fmQKghQsm/vygofmlBBzuEIrPXyCrl8TsfyO89QvBeUr2jpxesgVSopolE1P2JycUQ3lDiHxOnsa8cd2MGuUmwMwfVLj5UYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uB18raNWnmeNPDPC26CDptXk7WiQSIQT7vl2EaQoqSY=;
 b=mddm9d5304RIAIE4gJQfWLqQFUverQv+UqYhAzs73SPO1OmkB3sLqFaBwcpY3e5lVoniy1qBhD8dblrlvi8p/BUmhO1RRZBr0mYXgfrqY04LOH8cLmGE8JbPcIhYV31MwMZc5Baet8zJBMYa9O6o2/YQlCt85bTFqcl0YKqqwZ5wh/jfejDmWD5JI2cG6k3I+CYXSmgRBcS1vXyu/orrPMyuSeKmuH9e2cbLrGiCUelgG1TzBi8qq/IqQR7S7A/yRU3Lgj+9Syx2ZEaCJBo8WP41HH+8EGTkjeMXDkKapsfvvgLEQHrZF3ZWr7S0B+47DcLqN3z8LVJzHQ7SiLjkkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 DS7PR12MB6096.namprd12.prod.outlook.com (2603:10b6:8:9b::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6298.45; Tue, 18 Apr 2023 14:00:47 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::847b:988d:86fe:a0f8]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::847b:988d:86fe:a0f8%5]) with mapi id 15.20.6298.045; Tue, 18 Apr 2023
 14:00:47 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Yang Shi <shy828301@gmail.com>, Yu Zhao <yuzhao@google.com>,
        linux-mm@kvack.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        "Zach O'Keefe" <zokeefe@google.com>, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 0/7] Split a folio to any lower order folios
Date:   Tue, 18 Apr 2023 10:00:43 -0400
X-Mailer: MailMate (1.14r5963)
Message-ID: <9AA686F5-5366-4F41-92A7-C18B77BFDD6E@nvidia.com>
In-Reply-To: <c1429e20-7462-dc73-766a-cf7b3d482c6d@redhat.com>
References: <20230403201839.4097845-1-zi.yan@sent.com>
 <20230404144727.e613116684dbd65a4b4745c1@linux-foundation.org>
 <49ee481e-452f-61c7-2da5-28de2cf3de2@google.com>
 <b37d1876-0a74-aa52-7911-e6f78280caaa@redhat.com>
 <8B784026-7C90-427D-91E2-2D551FA576D7@nvidia.com>
 <c1429e20-7462-dc73-766a-cf7b3d482c6d@redhat.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_7EF800F6-588F-4AE4-909D-5775F8A02B83_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BLAPR03CA0144.namprd03.prod.outlook.com
 (2603:10b6:208:32e::29) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|DS7PR12MB6096:EE_
X-MS-Office365-Filtering-Correlation-Id: 97f01431-c053-4c9d-1090-08db40154ed2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nCNadWrXVWrMpsrJmvYM6xq7LD/0Wjaw+0wkFPlu9NOne/UO316VaS19Y+GQf32YfC3XRuZVpjAFrKCz3btttOpFaFB1glovkqyDfOuy//8b0it6wOys/XJMOtdmemUll0vBQI4WPNkTzeCiMM7SyADlesjto2G6YdZ84MteP0tVGJjUlQN0LTLtrSMu2/s9e28exVise24Dw+CNOcI0hu8fFTWECLrYvmad16nwpt61wh4qJH7D+n52GPGDxLo74OXb/Z1mYrrVW86LDPXBrImEU/FEdKWFF2zmgWN/k0BkfTmY6qR3IOPEknXUDlAnqn7wrIfZP318GE6/H7FeM3+DJ78W/xiXeZvHG14f6vMZMlLFO22Z4H5VMVzSoYCMV9jDxkgkkCpjIp5S/TRnAs3XWUQTIrz0CgSqSIKSErampTWO7z/RHzH2GlHJlLUNjf5Qx/nmIaHO26er+by157F9hMuC0/jASqrQZ/Q06J9tK+d/dM04m+vJ65FmBvYj5fv9vwTwJ1hEnVhxZzO2A1lh/msDqJzOfVGXoiw7DIV5WoISOI6WQjvSytjplKc1AM0/00dUXt5yqZNcYELtNM4b8Jig9b+ifReEuXbzCCEq7oy4RUMOAP3KuCytpezhauvs7TC5DP+YRcBaMQVZsw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(366004)(376002)(396003)(346002)(451199021)(6916009)(4326008)(54906003)(316002)(66946007)(66476007)(66556008)(8936002)(478600001)(6486002)(6666004)(5660300002)(41300700001)(8676002)(235185007)(7416002)(86362001)(2906002)(33656002)(36756003)(38100700002)(2616005)(6506007)(26005)(53546011)(6512007)(186003)(83380400001)(45980500001)(72826004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MbneRwEoHDaEmqr/EVbjTdCGuTgAl+lrDZBcU+uU//9df0gKDHLzeYzUo+23?=
 =?us-ascii?Q?IdLXMIo85/cCwto0PQk0rZkGyHO+xNp0g7C1DGFeTjA8dHtrPo8sW6Kfr0G7?=
 =?us-ascii?Q?ZTOa3HHtFCoBgJeFrc1+lbRk9hcb4KR0BSuWw/u85PnPbN5X9SxnR8URAyr6?=
 =?us-ascii?Q?l4suYoaL9aSz2cY4FZLGazev0icGWlBiiJ2XH7Eor/MwLThU4OXW0op+YykP?=
 =?us-ascii?Q?tMITgniyndrx8Wjm+aKEkC34GLkPrFJQXEdrTCyK3XlrycUdtHzKc10gPaXX?=
 =?us-ascii?Q?TfJAXvRS3dBBOJho3bv41TgU4AYh95OjHT2AB8C+RG92K2AhDy5X1q7T26yH?=
 =?us-ascii?Q?vsfRPjX1QdCw71fN/gV/WlRU78O3avnMiTS8um/vw9Zt0qw9afNZcimRCka5?=
 =?us-ascii?Q?nW1gfR41EFIHcW+7Vfu4neijQ8zgOLJc4t2NlyYYBoI5nwrkxkHXa+7JYHIE?=
 =?us-ascii?Q?nh/TjdtN9lNtSSc6wycge4PioetQr07l3ShoftOS78FoiF7cIWzpLbODUfc/?=
 =?us-ascii?Q?87xJTcdf+ZKaxB5Me8xZ6rxU9BaIHMpqNf5qKf7/ONSRJJQum/6lzxLhqH+Q?=
 =?us-ascii?Q?e2jLtiMqYRi6TFGXPqGZwaO44qS68JK8MzuwZnu7h1NtY2ks8qeQKycrHsxl?=
 =?us-ascii?Q?1bziNsJOvnPZa65icmvdlpbhgTxnyfYvWy1n6Ty/AzilcDrk4zFEDV3KeGFJ?=
 =?us-ascii?Q?DxaHW/zYrrZ0tPO43mElgWP9ZjbOovVgab8zPTA++ncvj/TdckpzyALPs9eS?=
 =?us-ascii?Q?9O2dNZpDKhVW9wgCpr80X2IzP1lfRmDNz9cCbq5jz4I24o47l8OHN63mg8Qy?=
 =?us-ascii?Q?qmJ6uJO397eiASKM0mSbvLAaSkKTRpLDE5iUiMiDiMc4R2xWST3orc9bJU8t?=
 =?us-ascii?Q?19Qcj6LW8wCen6PEwSMX4l8fhD2+PWduYVfC5inmnBdxgUyttx+WzV9oo61q?=
 =?us-ascii?Q?bUMyiWJ7Y/41i/DQAB9mBVCzdQNSVcXzTc+e2AUiMnr8AZWyibyUNSZnSovj?=
 =?us-ascii?Q?0TfILnSdCQZRe0MTAy2mDXMhjWju+LvCuwLDpMYCjHS/cWLdCOlCA7l4YiZS?=
 =?us-ascii?Q?UIi6SfnZjh86JJ/xs9G88r77jiSzZrfqP82LTepNdKrQWPQapqIEYrKF9x6g?=
 =?us-ascii?Q?effVU1R0rxK3G+Jh8GuLQluZ/7uMYtMg7QYndO949bDC8p0741BiDsHw7eQM?=
 =?us-ascii?Q?a0Qty9BGVkkHvYIsF2k8ew9zxw/k69btiRqg4tspcppcIuTQLyfvhDuwSaEh?=
 =?us-ascii?Q?yWrxUIfriyFSRB4TJATPxpGeySIqX40nP15da6yDfTXXKlfzouDNlLLCQax0?=
 =?us-ascii?Q?4hhKZbR30VW6Jzqo15q1iTCzZKUR9S1r1FSMQ9ROuIzhV30+Wzjwrlg1wUN7?=
 =?us-ascii?Q?UjjD3oZ7H5nvJtV4OwIiDsN0zRbV56ZwHFm4fW+aBnw8Ht0PKYZGFyKmrSHt?=
 =?us-ascii?Q?yMSgope6QgAczEyZWHgo1IzcKAZZsnREWmLsS7DlzAXzWv7gtJkBveYbGVQk?=
 =?us-ascii?Q?ig1ZFDgpmVAyUw9+Z/4GdJovRq6f0ucIi+q2LTL3En5DHge3T2YggQBaAP4L?=
 =?us-ascii?Q?dTCf9AVEnKNqh9Cs/0M=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97f01431-c053-4c9d-1090-08db40154ed2
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2023 14:00:46.8233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VO1OkqgVDKmnsjvDY9bS5dYJGKlYbB6YkQ+ZUzRMzB7tJj6cK2ociXFxAnvg3pR5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6096
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--=_MailMate_7EF800F6-588F-4AE4-909D-5775F8A02B83_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 18 Apr 2023, at 6:29, David Hildenbrand wrote:

> On 17.04.23 21:26, Zi Yan wrote:
>> On 17 Apr 2023, at 10:20, David Hildenbrand wrote:
>>
>>> On 16.04.23 20:11, Hugh Dickins wrote:
>>>> On Tue, 4 Apr 2023, Andrew Morton wrote:
>>>>> On Mon,  3 Apr 2023 16:18:32 -0400 Zi Yan <zi.yan@sent.com> wrote:
>>>>>
>>>>>> File folio supports any order and people would like to support fle=
xible orders
>>>>>> for anonymous folio[1] too. Currently, split_huge_page() only spli=
ts a huge
>>>>>> page to order-0 pages, but splitting to orders higher than 0 is al=
so useful.
>>>>>> This patchset adds support for splitting a huge page to any lower =
order pages
>>>>>> and uses it during file folio truncate operations.
>>>>>
>>>>> This series (and its v1 & v2) don't appear to have much in the way =
of
>>>>> detailed review.  As it's at v3 and has been fairly stable I'll que=
ue
>>>>> it up for some testing now, but I do ask that some reviewers go thr=
ough
>>>>> it please.
>>>>
>>>> Andrew, please don't let this series drift into 6.4-rc1.
>>>>
>>>> I've seen a bug or two (I'll point out in response to those patches)=
,
>>>> but overall I don't see what the justification for the series is: do=
ne
>>>> because it could be done, it seems to me, but liable to add surprise=
s.
>>>>
>>>> The cover letter says "splitting to orders higher than 0 is also use=
ful",
>>>> but it's not clear why; and the infrastructure provided seems unsuit=
ed
>>>> to the one use provided - I'll say more on that truncation patch.
>>>
>>> I agree. Maybe this patch set is something we want to have in the fut=
ure once actual consumers that can benefit are in place, such that we can=
 show actual performance numbers with/without.
>>
>> Ryan is working on large folio for anonymous pages and has shown promi=
sing performance
>> results[1]. This patchset would avoid getting base pages during split =
if possible.
>>
> Yes, I know. And it would be great to get some actual numbers with/with=
out your patches to show that this optimization actually matters in pract=
ice.

Sure. Will try to add perf numbers in the next version.

>
> Unrelated, your cover letter mentions "file folio truncate operations."=
=2E Would it also apply to FALLOC_FL_PUNCH_HOLE, when partially zapping a=
 THP?

Yes. In the self tests, I have
fallocate(fd, FALLOC_FL_PUNCH_HOLE|FALLOC_FL_KEEP_SIZE, offset[j], len[j]=
);
and it uses the truncate operation I updated in patch 6.

>
>>>
>>> Until then, "365 insertions(+), 68 deletions(-)" certainly needs some=
 reasonable motivation.
>>
>> Come on. 225 out of 365 insertions are self tests code. We need motiva=
tion to add
>> testing code?
>
> Well, if you add feature X and the tests target feature X, then certain=
ly having the tests require the same motivation as feature X. But yeah, t=
he actual kernel code change is smaller than it looks at first sight.
>
> -- =

> Thanks,
>
> David / dhildenb


--
Best Regards,
Yan, Zi

--=_MailMate_7EF800F6-588F-4AE4-909D-5775F8A02B83_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmQ+oowPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhU3ykP+wRt9zBYbVEprluv/xhZhFq8Vxhlfgi/v6Yo
ZGoedu6yksFPONQvTFuIsb73w1kjvVGHy60h9OqWWoMQGOvB+2lPC/tWMK/8TcE0
9PZrzo0Frt5XiMrDXWdBFHsSEbwFupITrNvbooqout+JEkWLDGifwTM05bZQJgwg
8MgccjHopOimBACXMTNNzIkW4iePMXnB5BxBRlSKn1RQCSv2bEFjOMZdMFi7M1LD
2WC79ipJl1qN1PZ2YKb5NCOjj3S57nPEW42QZWuL9MgitWLJmfBUodca500GEG50
pirkM6MQPmIkNsgBClFvPIVYuwuuebrndos7wkdGBJ3bfAGt0v91b8gC0ilhXjUX
le1SzCkTfFtJeo1gbN9baKln61USx3BtavmJKQA0dTLuzWD23QFb+/9lq5YC425r
F9cwwXEnI7Yvtuxh2Q8I/3vVF4MwGM+/2isL+mWzU5jd+7yokaukiaWpPBcyPrOu
Nm28lfqoMttOxumZOraG2/OaNfh74ZQ4IPG1T1grBCu0hVp/WIxqMZlvBpC4ROZv
mqc/vmoMiQSy3MIs0R08TQWLbxenNevwFeqAIWKwNkFyBwam4Gk8Al29DyqF3hX/
2BHaNVVmi6mNaIifx1vnFajVbvsKGURvUCDXHEKxCXYJ7HePnAwhZ7IBx1eb3wy/
o8QXb+77
=4mbv
-----END PGP SIGNATURE-----

--=_MailMate_7EF800F6-588F-4AE4-909D-5775F8A02B83_=--
