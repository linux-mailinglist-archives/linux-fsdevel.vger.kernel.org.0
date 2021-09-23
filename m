Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 588C84167E9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Sep 2021 00:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243390AbhIWWZP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Sep 2021 18:25:15 -0400
Received: from mail-mw2nam12on2059.outbound.protection.outlook.com ([40.107.244.59]:10240
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234844AbhIWWZO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Sep 2021 18:25:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nE6QokuIWQzScME3s+kY0hBJu8WMMul/VXASjio0R2O8nXQWhX41oiiJaw0QqA8Fs35A26VyZlniFL7j0K033mZCRehl7nxdmyjoPnoGlmiCDB31Qy/bJYgCqwRhQljKGqmA+sZELG2DlcAS8N7bxsv49xuWT57mX94XRkTQOoxehfTMbc9QP9EmZz7DRYnvlPWHdDaRsSHua7wwrG8qNgphKf1Yu18Vdmrun/oL4HbqZpl3wElzWFq2k/WBLx/9FtsTdTcK9gWAgWnI1eQ418FtmKMkzATp3RYGyTsdOij+cMRnMNQT7xlqjb5VPS7Q9elK98QXSQwcvOq3DcJQkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=st7Edt/6Lyj48Wk6N7y4ZhH9tPNshbqDWVOiyMC7G34=;
 b=amkSfT3JJHIBKCeWDbX87y902xTVvEMXWejuphacj9pDQxmX2LJtIo2eHXcSMDx28GOAMxtg8JGjXcpg64RZgZc7vC5FQkL98YmkThqAFYczCUYi2/dCeXTcVZ7sEoGEsF0zAKGOmFIlUY3rl32eBYTgDzCkQYTv1UUnsIo0JA2fqTveS/YfGiiFWFtKK9GE057vgGvZ1tepXdD3DaXemmkb0Wwt8toVw4KV3JBcbuxqK0cCu1mQgkVAupYIceHCjkrkanXBACjgOFTz9m+dSfThE/Mf4kXXBGZrJelCuun0peKHrvuj/viWrDdp0MCc8pM7SeFNBdD5ggkn22Wv6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=st7Edt/6Lyj48Wk6N7y4ZhH9tPNshbqDWVOiyMC7G34=;
 b=BEIZwFN6P4UM5rllW3kV/1rAVhz1Iou+Sfwzh0hkFnkBVAUWe7YTZeVthY9DNzoaGTZeVP7xjuqXO7N+NFnCLcdY89vXUl3XNAetZcG9cM8kfgUMFPD2WHaEiRUQkALxf48Oe8hBwmY/XZUwFtLuuy6dGibCeZSXlmUjZqMRpNY5dtolS3iUjK0JL2ySEFIt59IyoApqNU97wLaeSOkhupwzhg99mQ1XZBXoLR7qMDIqxlDezF1BsP4WKGGQ8V6k9v+6x0NH1t7QuKmwEu5D+fVPRuhraBDFApw3Ha8Giag5pzJPXdusuTUR+YxGKcWa5R5Sr439IKHH7hjJ8BmBqg==
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by MN2PR12MB4486.namprd12.prod.outlook.com (2603:10b6:208:263::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14; Thu, 23 Sep
 2021 22:23:39 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::7965:aa96:5d5d:8e69]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::7965:aa96:5d5d:8e69%7]) with mapi id 15.20.4544.015; Thu, 23 Sep 2021
 22:23:39 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Yang Shi <shy828301@gmail.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: Mapcount of subpages
Date:   Thu, 23 Sep 2021 18:23:32 -0400
X-Mailer: MailMate (1.14r5820)
Message-ID: <2A311B26-8B33-458E-B2C1-8BA2CF3484AA@nvidia.com>
In-Reply-To: <CAHbLzkrELUKR2saOkA9_EeAyZwdboSq0HN6rhmCg2qxwSjdzbg@mail.gmail.com>
References: <YUvWm6G16+ib+Wnb@moria.home.lan>
 <YUvzINep9m7G0ust@casper.infradead.org> <YUwNZFPGDj4Pkspx@moria.home.lan>
 <YUxnnq7uFBAtJ3rT@casper.infradead.org>
 <20210923124502.nxfdaoiov4sysed4@box.shutemov.name>
 <72cc2691-5ebe-8b56-1fe8-eeb4eb4a4c74@google.com>
 <CAHbLzkrELUKR2saOkA9_EeAyZwdboSq0HN6rhmCg2qxwSjdzbg@mail.gmail.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_8339584A-4868-4732-94F3-7BF5B752DF28_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL1PR13CA0361.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::6) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
Received: from [169.254.242.113] (216.228.112.21) by BL1PR13CA0361.namprd13.prod.outlook.com (2603:10b6:208:2c0::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.8 via Frontend Transport; Thu, 23 Sep 2021 22:23:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1178eb79-c3d6-4c60-4f71-08d97ee0cb10
X-MS-TrafficTypeDiagnostic: MN2PR12MB4486:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4486067332080CFBDA7332F6C2A39@MN2PR12MB4486.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RfLL0ANhN8c6wHplKHogKBHLvsJwv0049jOqsRo96SVLww7RP74g1t0TV0NPBHXO/dvTuW5Zemcy2DKJRGFfwm2lZlfl+L4T2pFogy4gts3+QEZs1mVZxPeHuISxr/BQgLfs/PRBmMi+bnsKhbLz+XLRw1AjXWnyoKn9G1JDGmlni5lwW2c0i3A+h7o5yW/ZPZKG8sTwj806lyMWNDMpB9Lp+GmJMXUsEXdYxGUCJk8rnyDYLNCH1Fg+76GFAdNwWcvrySUcTnAI755V0RZRcLB6mecl4B3s3+qH3X+dKj0561wbodOyH2GRiZifWUzVu4E/JCwJXjm1L/yPFF0ynNZJXo6lyfZ5wYPM/vbBj8iCBUKbVL2t5aDadXAn2DOzliDKUJ426TJutU8IN4Q018uch4+Q5o3s02/0co1WvD9ZSIuAMU+rSBRaNj2/fKA2UYHFX5Qehmwv99+4TFVRKBcTVKH22qq282QULV6TagvRbhIA0NxUjZ7rhkaxOeFgd2hS7J2iqlclZAFa2YJ+FDX9eLXtTgqzva/uNXxo3VjstYIx+rD1zo1b4e3rxL/5Zh6jUgSnMQVHnJ+G9Mpoglz6EU9qnRhYfjxUhjnkGod3K8QiOpxcqh42LHvUCvrYS9BpL70dhgHMLtjJ5zkYbMtsaHlcpeJ8rNt+BSHEpvdQPd3rhPLFWVU65FAQGs46zXYjY+ftlVJsYFet2RZybwnRi7xCF0tp/HMSCz4doITZd7T39AzP8HLsq08pV3Gj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(54906003)(26005)(8676002)(33656002)(4326008)(7416002)(7116003)(38100700002)(956004)(110136005)(6666004)(36756003)(53546011)(21480400003)(6486002)(5660300002)(66476007)(316002)(186003)(3480700007)(16576012)(508600001)(235185007)(66946007)(83380400001)(2906002)(66556008)(8936002)(2616005)(86362001)(78286007)(72826004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MeD6BM2cjRZdn04O2jVMg5ihmWQ25lgWRIBli8mvExeRx9PP3bDpmS5NQMgJ?=
 =?us-ascii?Q?MHyPP6uC8a5UZoZBwldHupZCQS1u24ueHzxUW9ib34ZF2jfp24fgnumdli2X?=
 =?us-ascii?Q?ZHllOQCRRm1XzeuI2hQIXcfWvx/TgRHZAZiXQyD3pkpjkOwjoGp5id+hguvM?=
 =?us-ascii?Q?79NQERH3iwGodJBc8Dr5D4ceQvzE27UAM8utIgwYJYtxmxJOF55jl3h2r8yJ?=
 =?us-ascii?Q?bvYpMhHpmbc7R0OHQo4XSX89Qrq/JAbIHyCLm7oQOctkmlEL1vl1KYy68+ir?=
 =?us-ascii?Q?yTMHdWRrGTmrLv3YaStcsPGrDueXKddJWfqLFBNzvpiKhdGtXdlmogFIiDN7?=
 =?us-ascii?Q?5/JS4DxtjHRYhSekSl34BEINkVOytPjZp3LE2LB2nJQO5pNED8B7Y1k5rwHX?=
 =?us-ascii?Q?Hrl0rA7bDuoOK3Z10HpSw5mq4JARyCsJAW42GPGgx/RYTmSvwmg0zME7K7mN?=
 =?us-ascii?Q?prsgss3OhyOWNDvoek7Y+rUVtATXr4IlyUyE2d0nXF2jdJu6U7WuO3oYV9GY?=
 =?us-ascii?Q?fxKjRtRiKXtfY4MwI13xlRWC2py6LfWrJWevjx+6P4opyNYNEzf5aooYYnXq?=
 =?us-ascii?Q?mnH3LZyL4ytXkQil8Ho79vTYk031etAfsbNyynfjDGZWu2zgnW62RNKjtqgU?=
 =?us-ascii?Q?dMcx0Z2G0oRXhHSj74QJtsT7jWk2cGV45u/ME1Z4qkZx+SBT5nTaSmFQfaYR?=
 =?us-ascii?Q?o2KuirDFbqH2Bfg3UM6MsRq4hSHDvfxgtVZ96o4baNT7BptAXbR1u5WWZNTX?=
 =?us-ascii?Q?+3hDx3pS81OqOL+9LtfrUSlRAtaOwcqNh1ViB1Ljcz6S8qOAwJEJNlFsJAP3?=
 =?us-ascii?Q?tb3x2pgxx0ShlF7LP0KcY0c5ObfclaJQwKRDucjDlEAbqwGIiDHqXjtkpgdF?=
 =?us-ascii?Q?wx5rwppk1KXcqN3r30nzBP6WBwxvv15moS+J7D9KrhV07PmCbLZXadTZnZtb?=
 =?us-ascii?Q?oAsNzkuB0Dn7F2vu30VDT+jpg13HtyQEWnyUSL5RRGcdZdY+Oen03nlaC8Ab?=
 =?us-ascii?Q?cLyvDdnHh3zhalYC4FqWgJgC2/gVleW4cemq3hVXF7zGqd3O16psRmMZwYeW?=
 =?us-ascii?Q?iSu0ynG8XHAHSUjzeYfM7WG7Fhl/baxiIIelfM5ZJynU6MOUT2Xp2YtcHj3M?=
 =?us-ascii?Q?Ya17ocicPGH40MsN6wNTGWxVYdUv+D4Q/HNxP7yp/Nfiqfo4fVvjwGr/sjcN?=
 =?us-ascii?Q?jJSnZf/XJlIZ/x2Gfb7jWJC/8T4crdW9xlFrL7p0fKypq5m/iu9FjjgkXUZV?=
 =?us-ascii?Q?OwQ47XPGOpyEGBo4Btm5FoXtYxCqFVcioszHoRaqjExYpxVNB9ScVoZjQqR3?=
 =?us-ascii?Q?c2RdL/pbf97/n8z1E7auNdXU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1178eb79-c3d6-4c60-4f71-08d97ee0cb10
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2021 22:23:39.6492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VREpRBGRyS6uXEj11F8YH2TPplJQdtkU37SNrhSljyWqpcNwzmlMuoKbR9nuDnvs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4486
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--=_MailMate_8339584A-4868-4732-94F3-7BF5B752DF28_=
Content-Type: text/plain

On 23 Sep 2021, at 17:54, Yang Shi wrote:

> On Thu, Sep 23, 2021 at 2:10 PM Hugh Dickins <hughd@google.com> wrote:
>>
>> On Thu, 23 Sep 2021, Kirill A. Shutemov wrote:
>>> On Thu, Sep 23, 2021 at 12:40:14PM +0100, Matthew Wilcox wrote:
>>>> On Thu, Sep 23, 2021 at 01:15:16AM -0400, Kent Overstreet wrote:
>>>>> On Thu, Sep 23, 2021 at 04:23:12AM +0100, Matthew Wilcox wrote:
>>>>>> (compiling that list reminds me that we'll need to sort out mapcount
>>>>>> on subpages when it comes time to do this.  ask me if you don't know
>>>>>> what i'm talking about here.)
>>>>>
>>>>> I am curious why we would ever need a mapcount for just part of a page, tell me
>>>>> more.
>>>>
>>>> I would say Kirill is the expert here.  My understanding:
>>>>
>>>> We have three different approaches to allocating 2MB pages today;
>>>> anon THP, shmem THP and hugetlbfs.  Hugetlbfs can only be mapped on a
>>>> 2MB boundary, so it has no special handling of mapcount [1].  Anon THP
>>>> always starts out as being mapped exclusively on a 2MB boundary, but
>>>> then it can be split by, eg, munmap().  If it is, then the mapcount in
>>>> the head page is distributed to the subpages.
>>>
>>> One more complication for anon THP is that it can be shared across fork()
>>> and one process may split it while other have it mapped with PMD.
>>>
>>>> Shmem THP is the tricky one.  You might have a 2MB page in the page cache,
>>>> but then have processes which only ever map part of it.  Or you might
>>>> have some processes mapping it with a 2MB entry and others mapping part
>>>> or all of it with 4kB entries.  And then someone truncates the file to
>>>> midway through this page; we split it, and now we need to figure out what
>>>> the mapcount should be on each of the subpages.  We handle this by using
>>>> ->mapcount on each subpage to record how many non-2MB mappings there are
>>>> of that specific page and using ->compound_mapcount to record how many 2MB
>>>> mappings there are of the entire 2MB page.  Then, when we split, we just
>>>> need to distribute the compound_mapcount to each page to make it correct.
>>>> We also have the PageDoubleMap flag to tell us whether anybody has this
>>>> 2MB page mapped with 4kB entries, so we can skip all the summing of 4kB
>>>> mapcounts if nobody has done that.
>>>
>>> Possible future complication comes from 1G THP effort. With 1G THP we
>>> would have whole hierarchy of mapcounts: 1 PUD mapcount, 512 PMD
>>> mapcounts and 262144 PTE mapcounts. (That's one of the reasons I don't
>>> think 1G THP is viable.)

Maybe we do not need to support triple map. Instead, only allow PUD and PMD
mappings and split 1GB THP to 2MB THPs before a PTE mapping is established.
How likely is a 1GB THP going to be mapped by PUD and PTE entries? I guess
it might be very rare.

>>>
>>> Note that there are places where exact mapcount accounting is critical:
>>> try_to_unmap() may finish prematurely if we underestimate mapcount and
>>> overestimating mapcount may lead to superfluous CoW that breaks GUP.
>>
>> It is critical to know for sure when a page has been completely unmapped:
>> but that does not need ptes of subpages to be accounted in the _mapcount
>> field of subpages - they just need to be counted in the compound page's
>> total_mapcount.
>>
>> I may be wrong, I never had time to prove it one way or the other: but
>> I have a growing suspicion that the *only* reason for maintaining tail
>> _mapcounts separately, is to maintain the NR_FILE_MAPPED count exactly
>> (in the face of pmd mappings overlapping pte mappings).
>>
>> NR_FILE_MAPPED being used for /proc/meminfo's "Mapped:" and a couple
>> of other such stats files, and for a reclaim heuristic in mm/vmscan.c.
>>
>> Allow ourselves more slack in NR_FILE_MAPPED accounting (either count
>> each pte as if it mapped the whole THP, or don't count a THP's ptes
>> at all - you opted for the latter in the "Mlocked:" accounting),
>> and I suspect subpage _mapcount could be abandoned.
>
> AFAIK, partial THP unmap may need the _mapcount information of every
> subpage otherwise the deferred split can't know what subpages could be
> freed.

Could we just scan page tables of a THP during deferred split process
instead? Deferred split is a slow path already, so maybe it can afford
the extra work.

>
>>
>> But you have a different point in mind when you refer to superfluous
>> CoW and GUP: I don't know the score there (and I think we are still in
>> that halfway zone, since pte CoW was changed to depend on page_count,
>> but THP CoW still depending on mapcount).
>>
>> Hugh
>>


--
Best Regards,
Yan, Zi

--=_MailMate_8339584A-4868-4732-94F3-7BF5B752DF28_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmFM/mQPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqK9mEP/j64FZRQ5OK/0gHFHgQb/yIYqeBOc+ko0nP8
xwHlRtcZ6cyr1Ouwd7Q73OHYTTl8tNp1mZ+sUcnOrtONoYW1PflWbmrFe6eLmUIF
u8qD5XN4WTVCAZvvVAOBpv4t6wYFoKK9aIvZFh0R1yUmHmJhVFEL7cO2sFheroFk
1VXudJu+N4zGz8tWxr8i8vFo7zjrTSNyaz2nuL9BJEPuz1C3C0r3KXGm3JWfP336
n/uy9jj0vT87KVVqnL5xE/yzgyu/gLECgCrhvbIO47hnnzjUGAcy8fA5xH3Vz+F6
FIOl3mftY0lqWaUJG87HegSiCHWAsjZRaERBShocRGfSZ+LbCQBwlu9aMFWtvnS0
Fj/Xc7aqYAiYb6H/zZoJQRtCnPjJ5+K3bWRITvWyEFemwR3YwBKqTQ1uz01Zgqnm
CbAeYEmz5jPkVbfDPX1pisyku/QYBqsl2OkF0CJvnh/9Nw2GghYos/26pmpwg9TC
6vDftiHv7t15NIEP7TYci/RQlQjUwt1UJbecjQgIzQm8X9pUOaPH39jWbN0LdsFV
7GyzK8ts1mOYVrsKlG7SzRL1pC2lmUcoMTV74bAtODgfX66ZJ/7xr02ROmDU2sZD
eXr5ogUmFs2X1+XnP3BMElUaWULSR1UWVO8VPCm8NAen8PhBxvrppLdIw1AdiV4T
ZSU1bSHR
=XLer
-----END PGP SIGNATURE-----

--=_MailMate_8339584A-4868-4732-94F3-7BF5B752DF28_=--
