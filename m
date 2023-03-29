Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEBC06CDA48
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Mar 2023 15:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbjC2NRK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Mar 2023 09:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbjC2NRI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Mar 2023 09:17:08 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0450D5258;
        Wed, 29 Mar 2023 06:16:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k1r1z/q233HrrjpZSVvkbNwy6IkW6VFKJfOxrK3bLh/lOLB5yeRfO+6p/I72vO9jdpBWR6tgXq3pXKRM8hyfzXvitunR2RkJk4s1UA3hLfgIJC7z2OHxAJbNlTkzCPROLtfVlVZly9JwM1YYs/xxLyu7MWlc7JtGyEPvN1fDuFyRJEralbmuOLNHSvhNaUswwfQea1mX5B9fz2JFLMAfq/6v2v9TTzVDBsprF3xYJnjgmGzk+KzmGYFf6FoCFZimj2L8eJPk0BbTbpYxYtWfNhusvTuyoA23o0LQOuGppMNpOMmMjBIYSHt4vxaFK/dIp6xx265rjEDORixuXvaMCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EkkfzvzIrc/sY02IgoyBaFfrBtVtIdUj4W8RRCy6PQ0=;
 b=ExnGe8JzQydcC0dO7PZiM7Uxg8wAYEVIwzPJ3v+CeNe23rhz6WppObR/hIUrJUqpjmdN1G/LAdWZ1tdUs79Dx3VAp78G9MEXO73fQ3GGApxMVG6X2jSHYuHjvBPwGgpRv8zKvGGo0a9KcCe9Tm1IebZT8Uvd5llMHy+jzUqDcGBg3VQRfHGFZbiIWJGvnTKz/FFKwES7pOvYnvfo804Uwh7Xhe4v/cHAKeNpxGk4LM+RSXYoXIEhCkPPwbAz7AiJ5/UUU8vIUlaI/H0X6li8WyDkVIC69IBtTTweB4x62zIgNGZsoxO6h8zmDnaP3zTlZZEgZvWl0NRwWtI+fVtNuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EkkfzvzIrc/sY02IgoyBaFfrBtVtIdUj4W8RRCy6PQ0=;
 b=J89lKcoDAW48rBtQCezx6f8FZtHF5CqZB6eDEoSllKLeycwGUuOmSh5G2WBdAIzgSNtaTAYmYJf+IOapbai0awSimU81EPqPHVHlsQeRvgQDxK7IaYUZxyYCwxMIsaE1OOXWT9ekm/e1gnNV844d58ni7bMl2fCmcLB+UqvZ3Alk6MPI3n7Qv+Pwa/M8yfi+A2nhktnmTOMCBQZyVePIjmkVy6g+wVxGkWo1ZXWdVV2O7LXi+sIsB+bpIOSovyNrZ2//aNgF8ACSBzwzlucojYYdNlgFSKY8WOV17ZFM7oDMVgLyOnxV76Wl8eckl18TVUx4OM92gzJUmP823jApbA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 DS0PR12MB7970.namprd12.prod.outlook.com (2603:10b6:8:149::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.33; Wed, 29 Mar 2023 13:16:35 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::bb0b:f14a:c49a:9cd7]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::bb0b:f14a:c49a:9cd7%6]) with mapi id 15.20.6222.028; Wed, 29 Mar 2023
 13:16:35 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     kernel test robot <lkp@intel.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Yang Shi <shy828301@gmail.com>, Yu Zhao <yuzhao@google.com>,
        linux-mm@kvack.org, oe-kbuild-all@lists.linux.dev,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        "Zach O'Keefe" <zokeefe@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 4/7] mm: page_owner: add support for splitting to any
 order in split page_owner.
Date:   Wed, 29 Mar 2023 09:16:32 -0400
X-Mailer: MailMate (1.14r5963)
Message-ID: <657AFA72-1604-4FFF-8F40-1B6CFB0B5061@nvidia.com>
In-Reply-To: <202303291732.7OqWI96E-lkp@intel.com>
References: <20230329011712.3242298-5-zi.yan@sent.com>
 <202303291732.7OqWI96E-lkp@intel.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_4B7CCE87-645F-4425-A0C9-5A14AB99006F_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL0PR02CA0045.namprd02.prod.outlook.com
 (2603:10b6:207:3d::22) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|DS0PR12MB7970:EE_
X-MS-Office365-Filtering-Correlation-Id: e1480b92-7687-4100-0ae1-08db3057d25f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z+1qp/DAuNZKY9tvAJegJB6xNj0P/0LREnMogsr6288zOMg7YZojVzMCz8g+H0LAClISX7DdnweYEJPiZVjKyhgE9JrPlqZOr0R4iZL/fYAol43uFRskZMndpPzPbOWd+gKBnwqbGX8D7LYj/VS1j4ZJEGuieITSE9jVN+PQvhaMIwTtt+/evR0hjiJgSF051H4GP9pF1jwueo3RSW5Ug36/JYkS3qgx9fJMT4grkePCniP6yHsSdIiZgDfqA9Rtpx6Ti2vPfg9CJWYIHtSKsO/J5KuH+Rpzi0yK6cAd4LKZIhFcPwoOf9uih+X3Hyi+HvITZ3Bkc+DCUZD+ZXcsVbbbbCxxqWLqIn9HMbUK4lTHX5JrN44YvesIcSkacHuqEM5OeI8huIFpbwYMIuAC/h9SLY4EmKBHBqTvdzCt6KAVdzbTCl0E1RrMjpzZY/KJh+wq96SZ1J5T9oaV2HDbpYGV2LBSXEDUEwkAMZ9hOaV8Q8hmPCL95TnVPKnz82bcObh6KZRKVX3GjsbvTE4NNzYnaF9Rad/GdWr13EqtdMLDb7eMh0r2iBqnX7HudfSHBCDA5wq3hJbytIsJigbeI9vW5e8y8Uxt8890oH+YJe8C1u+hBmV/qgx1xJV/D/ok/L63xMitTMCnhYhQ7N8lj+N+8JJbXXZarzgHxeO2iSBwtfVhgWue/QHtHU+lWLhdgE8JWweXh3vqCf2y5IMnWQdTQtcBEBMgJqbXCxuZ9FY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(376002)(346002)(396003)(136003)(451199021)(26005)(4326008)(6916009)(41300700001)(8676002)(66476007)(66556008)(66946007)(478600001)(6666004)(966005)(6486002)(2616005)(6506007)(53546011)(316002)(186003)(54906003)(6512007)(86362001)(235185007)(36756003)(2906002)(33656002)(5660300002)(38100700002)(7416002)(8936002)(83380400001)(45980500001)(72826004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DIKOMZrWR9ryow+iXOsSv9/DiaWXCs1N9zhYi//6Yu2SbYQtEvF7YSVsVYCs?=
 =?us-ascii?Q?1f6meDUbP9zN7uIuhctvNoY9PHKmLc08B/18Su1naxCcWQQuYz+aMr7K6WVh?=
 =?us-ascii?Q?yu4c6wodVo4YRQeAgEuqESmlql9UCR8J7AIdykLlWtcDPCh8w5kwTKGGJyex?=
 =?us-ascii?Q?FJKwC+L8ZYaEwyb3SJa67T4xHfGuHD+iAd6rOfX5tNp95jA+SfcB4zfwJp+w?=
 =?us-ascii?Q?qX2mBwiocRIcvXaSX8Tv7De1o2TVPGb6vNFl0sJ+IKWVUniRZwNFvBp1j9Ls?=
 =?us-ascii?Q?Hs3hK7DxkAW920QlgDiyVRBW1I0JhLMf5a/183Y0FWNv2dEooUu2oasA/dhc?=
 =?us-ascii?Q?PPjhHQn0ZF2+RDLhwV4nr1LjJFXFwmFT9U5NO91bE7w6hPXaMpLrnMYRz7DP?=
 =?us-ascii?Q?wlAnq4dDvRE1qCqzfvq/NGrwwFNO6sNcgs/WmmM8GsVS8c1LQvtjheun0fQF?=
 =?us-ascii?Q?G330p81PblQ8lYfs5kqR3Mc/0VvkR4NDitVkxaOeJADSncCxY4v8OKYv+kol?=
 =?us-ascii?Q?TqJCY1BpSE8bSRQ/ljWO3cTmc8S+p23KlNCEbg7/CkBfY2FmbCyOI/wR28Bj?=
 =?us-ascii?Q?c1dBmYcXcIcoyo3w+gS3P/UlTgu9Tifl/ygH0SneOqo0eIQVHpEWOzMVpcKM?=
 =?us-ascii?Q?0yjkTr6w7ZiRMCHZsxNR/IhZyInJGo0UM8tsV3d0Pd4Caoq4yxyX+k6Q1OD6?=
 =?us-ascii?Q?3u2rLSkSZwvVZy6bySAKgivDkds5J8wUl+mtCP0MYfIjqM43shqafXzpIH75?=
 =?us-ascii?Q?5JNni+Hj9JBSUY+OsmyqfsixQBOLZ4PKjKV+SFFANVZEXa1Vs5JgfmYjvFbn?=
 =?us-ascii?Q?aoxpQXkG2lux8ujXuJREJFZKgjQ1iS1ya5KATIGp3Khaj7NUNUU4wWX8Tdzl?=
 =?us-ascii?Q?kESgDancewypMsk8EnZNNqj/Nbo1V2X2wbsMwdOBML7HbwACF28b3/3GJlE3?=
 =?us-ascii?Q?2LNhYUzOsa5hr2S5VmZs+ILmmCfIf4gRXrduuEnIx3H7iG430cPe+CqG0xTQ?=
 =?us-ascii?Q?nRPz0obEiZifdrGjqfU7OUCXPqBWMtbk0ROHyMi9+GoKiuWAGmEyK8+Izap/?=
 =?us-ascii?Q?baT9p7PBJG2tvbctDhv7DPLjJ0x6jfN9VPYE3ebZ00tC66GVuXkOmuq3qptt?=
 =?us-ascii?Q?mncTC5CiDgrpfa2uu7NC/AJlN6JPaFTlvhQTOmks5liQm6VXYTvH54ueL6Ca?=
 =?us-ascii?Q?+ti5MuOLbqCe9eaM7rLusWLrbSRoXaFP3IFfE5K+2jGMoYf4T2B62qnsOL44?=
 =?us-ascii?Q?dVBfo7g/lb2REEt7s53OxgbTzqiDvjp8NgGF2+IGTfyPdSqs6cLXKkNdR2Ez?=
 =?us-ascii?Q?zK6V2lgRglFGAZkrabcPn2Aw+AaiEzyCekwdcLdR17ph5Ugr7hXZGPjJpA05?=
 =?us-ascii?Q?a3ZnQ3GyO6tP+aQ3qjiBC5n9N4zIJqXnhc6QW1BfXNvlmpBmbDw5FWGSdyUg?=
 =?us-ascii?Q?aTBQBLAKswHZg3VUlUKLVbYNveSWasl1ysq85I1lcuuLTpVqK/hKBqvHpxwu?=
 =?us-ascii?Q?KTX5hrSWSAS/UYZRfUKBlWGNRDTebJOqneSqDQEkeM+fBtqZ/xy+LuJgGqT/?=
 =?us-ascii?Q?OQ3VARcxjC8N9x1YY7I=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1480b92-7687-4100-0ae1-08db3057d25f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 13:16:35.4366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dL11tB5NWs9Ms0X1GRwYE5nWYCUwCBZx05CS6RkfCHEBd4WNUcarsEJLKm2RT+PX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7970
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--=_MailMate_4B7CCE87-645F-4425-A0C9-5A14AB99006F_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 29 Mar 2023, at 5:58, kernel test robot wrote:

> Hi Zi,
>
> Thank you for the patch! Yet something to improve:
>
> [auto build test ERROR on akpm-mm/mm-everything]
> [also build test ERROR on linus/master v6.3-rc4 next-20230329]
> [If your patch is applied to the wrong git tree, kindly drop us a note.=

> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Zi-Yan/mm-memcg-=
use-order-instead-of-nr-in-split_page_memcg/20230329-091809
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-=
everything
> patch link:    https://lore.kernel.org/r/20230329011712.3242298-5-zi.ya=
n%40sent.com
> patch subject: [PATCH v2 4/7] mm: page_owner: add support for splitting=
 to any order in split page_owner.
> config: i386-randconfig-m021 (https://download.01.org/0day-ci/archive/2=
0230329/202303291732.7OqWI96E-lkp@intel.com/config)
> compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
> reproduce (this is a W=3D1 build):
>         # https://github.com/intel-lab-lkp/linux/commit/6d1831c0e01a1a7=
42e026454fe6e5643e08c5985
>         git remote add linux-review https://github.com/intel-lab-lkp/li=
nux
>         git fetch --no-tags linux-review Zi-Yan/mm-memcg-use-order-inst=
ead-of-nr-in-split_page_memcg/20230329-091809
>         git checkout 6d1831c0e01a1a742e026454fe6e5643e08c5985
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         make W=3D1 O=3Dbuild_dir ARCH=3Di386 olddefconfig
>         make W=3D1 O=3Dbuild_dir ARCH=3Di386 SHELL=3D/bin/bash
>
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Link: https://lore.kernel.org/oe-kbuild-all/202303291732.7OqWI96E-lkp=
@intel.com/
>
> All errors (new ones prefixed by >>):
>
>    mm/page_owner.c: In function '__split_page_owner':
>>> mm/page_owner.c:226:28: error: implicit declaration of function 'look=
up_page_ext' [-Werror=3Dimplicit-function-declaration]
>      226 |                 page_ext =3D lookup_page_ext(page + i);
>          |                            ^~~~~~~~~~~~~~~
>    mm/page_owner.c:226:26: warning: assignment to 'struct page_ext *' f=
rom 'int' makes pointer from integer without a cast [-Wint-conversion]
>      226 |                 page_ext =3D lookup_page_ext(page + i);
>          |                          ^
>    cc1: some warnings being treated as errors
>
>
> vim +/lookup_page_ext +226 mm/page_owner.c
>
>    213	=

>    214	void __split_page_owner(struct page *page, int old_order, int ne=
w_order)
>    215	{
>    216		int i;
>    217		struct page_ext *page_ext =3D page_ext_get(page);
>    218		struct page_owner *page_owner;
>    219		unsigned int old_nr =3D 1 << old_order;
>    220		unsigned int new_nr =3D 1 << new_order;
>    221	=

>    222		if (unlikely(!page_ext))
>    223			return;
>    224	=

>    225		for (i =3D 0; i < old_nr; i +=3D new_nr) {
>> 226			page_ext =3D lookup_page_ext(page + i);
>    227			page_owner =3D get_page_owner(page_ext);
>    228			page_owner->order =3D new_order;
>    229		}
>    230		page_ext_put(page_ext);
>    231	}
>    232	=

>
> -- =

> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests

It can be fixed by the patch below. I will fix it in the next version. Th=
anks.

diff --git a/mm/page_owner.c b/mm/page_owner.c
index 347861fe9c50..72244a4f1a31 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -223,9 +223,9 @@ void __split_page_owner(struct page *page, int old_or=
der, int new_order)
                return;

        for (i =3D 0; i < old_nr; i +=3D new_nr) {
-               page_ext =3D lookup_page_ext(page + i);
                page_owner =3D get_page_owner(page_ext);
                page_owner->order =3D new_order;
+               page_ext =3D page_ext_next(page_ext);
        }
        page_ext_put(page_ext);
 }


--
Best Regards,
Yan, Zi

--=_MailMate_4B7CCE87-645F-4425-A0C9-5A14AB99006F_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmQkOjEPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUZQYP/2fsS7bSqo6psiOKF+rRUEoXRLNZFwYTAZeX
GQLwQyGkW5S5ZVcMX144LIRSjZcTRsMeW86XRytL6O4ZD/yOrWCYx0c9y7mj1Hzs
JXWI5o1C50V9E6b8okKuWunOor976Ynw3qlJ0y2LOkTuE1SqO4ZnllM9TgYfcSxo
xEyNX9LxBcjui7oG6b6cNC/zyNtEmfhdfGOfB29wLJdj8ALfZhQDfeaeJLTQ/mWW
1Kb7h6ECknbZQSRs7yMKrlW7lgtMkxaN++MuimtJt6yLtpxLnZluRhMG02KONf4n
1D018vdWK38KkBMj7jGkOhA+TCFYp9gyiMeBUi3G3w2S0yY7xxNHtxePQ3+jviwx
9WbZ8HSPfabztXY0YD7sRLxO2gD/tMuclmSgY4lksloACt0bwZ3PCbZcwRtwRzhK
rAFkWIOQSYqQSUcsKSYrhmSvT8SCOX8Eyn1cnQXDDhSQ0+8eCyVIhsCOGg9XSCps
a3FkVlXoaJ9WF1Mdcq8YBUtmxNKL1YA3mQEIane7gN+IGCYaqXm14MbBvn2ioLgE
xOBIaxcJAIFMOMIBRGigXyFIUD4cB8RAk5tf3lr32DEi6pBDgZn1/DwLDgVynqtC
RsuUmg/wjYz3fm143q9gxGELQHaSU1Ri0AjGqTX4DCW0Cxo4VoL4vwTeFrn6elwH
feV9Fe9u
=sAUa
-----END PGP SIGNATURE-----

--=_MailMate_4B7CCE87-645F-4425-A0C9-5A14AB99006F_=--
