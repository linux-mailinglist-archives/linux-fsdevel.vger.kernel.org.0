Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACC3A332F55
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Mar 2021 20:53:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbhCITw4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Mar 2021 14:52:56 -0500
Received: from mail-dm6nam12on2089.outbound.protection.outlook.com ([40.107.243.89]:64737
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231138AbhCITwv (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Mar 2021 14:52:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xa8oI7xCkO3TeBVNyJkLWhqnr4Ku+m8fMXmMetHtFuqfc1TanHQkxaE60IssbRo5bCjQ5cJWroPr+kXDk298tNIp88UmlVofYCr3Gy1smK8iwnRIaBH2phHBco1iJ0fXVoG8IOUZZUpNU5rX5mwyhfzXr8AExZeUQZ7I8uNBDAXTFJFEirs+MC9apXlf2A8F7x301ZtQyAAj/Nq58XAifu9af4+hur3xC1nPwynfFeauqhJQFBwjCAUEkYmmXznJOOgL5/FDocUGNoXUWgFvGI92aDTV/HJfpJt/+LpQ5Z7DEYurhY7YUAqc3x+gR8bq+3VKOXMqC81O25YcpupptQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kSMBj5cMlsPIO+BoJ/4p5nMTEpLtlS3S5rmvg39mde8=;
 b=FbDApj/t03fyivh4zd3gktMYXrazeHaM9FwJCsFIGe9xvSjlyqGdDy7nka8UWFUEYIMio0gm6zHZDgpDj0iFpwjUXgC5a01QJG+iy7v5+0ic9jUVo9zlYVFg42xf7sfYMLMkY/rpFrZaHIpokby3EVLrSZpP2pmqU0WzxKVdtQx2JsTfwKoRDJw+nMLkFp5CuK53WMzSlbw0rgqIohQY5S7N3yfoLhe6q3dc8KvyLwwwpiBOSPVvBeQv22gaTAZ3ur/YDK4xdn+Hd1FXpC0HOz6mPqP100fPUWn0Ap5ULkGRhoL6jWV3mOk0vr7OoUjI4KKdLnZnIll1V93hogkF+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kSMBj5cMlsPIO+BoJ/4p5nMTEpLtlS3S5rmvg39mde8=;
 b=ADcjrsdImwnjzO1/SIaBbepkc5uTDkvL5wIt0KsHT7AdIamIQz+vqbHT6BPElDnJNMCffFR1dDSXZo+/D98e4F7AyJKxHGZbivx0J3dxhNJ+kzzkzx8Xh/HNsrOgUJxNjrIALy3Zf5Lad2kh+FvF/GXgbO0NYExLawlJE5haB6d9pr3JzTgrrvhWyPlLp9bAGACA2EvTK0nxrZEgUM7eFmQEJyqIRH0Xx48/YHsBhNcJXQU70zAXRupo2k2Eto9VtPkRPFt8XdTvIMOeeG1C3eEKalpNw1zywUjY6mYHgkF2s3E6gmbHzLTAqhC5G2z3edG2WY4ao6SDGCQo04Wptw==
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by MN2PR12MB4045.namprd12.prod.outlook.com (2603:10b6:208:1d6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Tue, 9 Mar
 2021 19:52:49 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::a1b1:5d8:47d7:4b60]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::a1b1:5d8:47d7:4b60%7]) with mapi id 15.20.3890.038; Tue, 9 Mar 2021
 19:52:49 +0000
From:   "Zi Yan" <ziy@nvidia.com>
To:     "Axel Rasmussen" <axelrasmussen@google.com>
Cc:     "Alexander Viro" <viro@zeniv.linux.org.uk>,
        "Andrea Arcangeli" <aarcange@redhat.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Hugh Dickins" <hughd@google.com>,
        "Jerome Glisse" <jglisse@redhat.com>,
        "Joe Perches" <joe@perches.com>,
        "Lokesh Gidra" <lokeshgidra@google.com>,
        "Mike Rapoport" <rppt@linux.vnet.ibm.com>,
        "Peter Xu" <peterx@redhat.com>, "Shaohua Li" <shli@fb.com>,
        "Shuah Khan" <shuah@kernel.org>, "Wang Qing" <wangqing@vivo.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        "Brian Geffon" <bgeffon@google.com>,
        "Cannon Matthews" <cannonmatthews@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        "David Rientjes" <rientjes@google.com>,
        "Michel Lespinasse" <walken@google.com>,
        "Mina Almasry" <almasrymina@google.com>,
        "Oliver Upton" <oupton@google.com>
Subject: Re: [PATCH v2 1/5] userfaultfd: support minor fault handling for
 shmem
Date:   Tue, 09 Mar 2021 14:52:40 -0500
X-Mailer: MailMate (1.14r5757)
Message-ID: <04697A35-AEC7-43F1-8462-1CD39648544A@nvidia.com>
In-Reply-To: <20210302000133.272579-2-axelrasmussen@google.com>
References: <20210302000133.272579-1-axelrasmussen@google.com>
 <20210302000133.272579-2-axelrasmussen@google.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_DC4EE074-9620-4C9D-AB73-C4315CB1453D_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-Originating-IP: [216.228.112.22]
X-ClientProxiedBy: MN2PR17CA0003.namprd17.prod.outlook.com
 (2603:10b6:208:15e::16) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.2.49.51] (216.228.112.22) by MN2PR17CA0003.namprd17.prod.outlook.com (2603:10b6:208:15e::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Tue, 9 Mar 2021 19:52:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 69117480-4511-4f9f-5772-08d8e334ea33
X-MS-TrafficTypeDiagnostic: MN2PR12MB4045:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4045AF0C3032CE7CCFEA8AF8C2929@MN2PR12MB4045.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: efpCbyEm/bgDuHQ/PWUlVyVpW8wqtE3lGwGzwJq9wofvFbO+8hgPDlijvijFAc4xMkzXdJ+ERTxo24ohSBPH6/Gx4fw1PnIoX+Y3IXAR7AMf34VqPe4jTBsh2QljVUlqCKTTMcJU3QeetKaNYIYXOkXzZUhClZLvcUeZzYdtwLnmxbIZ9CDbKT1BCFtMMip04oTBPf8SUuQu4TM24bQzUs27krN83sVWus4yJwjUGnFvN+IEiTIRtoXA78FyYnFmNkuHMbKVV6oT5TzUZ+1Mg+w8w/jEZFpkjTkJDhQhN204tPciIvQ72wphAEVmHm2I8NGp2ZqzfrUdmQ0y0YqSK1eIkEFUJ5pEviG/Skdktboty0KcOqhVYFQqYkgPStZ1F6iyqjWN8hwOvzp9bVNEAVQET2jiNaJbuD6FmjOCVVXhrtX477B18XAdFhRgV54oR4lGM41eVPOf/mlGZNONr+HveOplkDJmwqOlyxpKJ3WfnV5Z7WJ/fj81B/KUuZA1JNF/kXOBlpgiD/IAL3kw4FZRvhaxKhH8dPQ9uqW9tEKZKlfqeWpBaHGB5ZZvfJ1XPEIAtlf0gQb8gI2fH3b4Nm9Zf55F9VvwMu5+CRZYGOg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(366004)(346002)(136003)(39860400002)(5660300002)(54906003)(16576012)(6486002)(6916009)(8936002)(66476007)(4326008)(66556008)(2906002)(33964004)(33656002)(36756003)(186003)(16526019)(7416002)(26005)(8676002)(316002)(53546011)(66946007)(956004)(83380400001)(2616005)(478600001)(235185007)(86362001)(45980500001)(72826003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?eXVLWDdWS09ieHpUemVTSk1pcm1veDRRNVFsR21QTUpDVjYzVjVFRGw1TlZ6?=
 =?utf-8?B?NzlCYnkxQk45cWtDWEpiUkdEZ2pWQVZhYnhRcExydDlLVDdJMnIvbUxodW1S?=
 =?utf-8?B?SnV1VW54am9ySEhCN0IwTGMxQmRUUG5uQ3lVU01uOUNUUWpUa2hLN29IMkly?=
 =?utf-8?B?ODFQeEVnR3NSdldTZkc4dmZzRjgrQ3ZBdVdjek13eUU3RUlpUG9xNjFRZnJN?=
 =?utf-8?B?Z2xSNzVDUmNOemlXcThwWVNXKzNIdmszdDFFQndrS1Y4cktDZjF3NnNaQkZ1?=
 =?utf-8?B?TlQzM0I5aUJFNWs1SGNEaEFvZXNCdzdQMTdQdjN1bWF0MjhESDlmU2xreDhk?=
 =?utf-8?B?QzhJK3FGZUZ0S0Jud3hQWHlBanhhdGU1bW1La0k3VTBVbm9hQXBENUtMNmtY?=
 =?utf-8?B?K1hPZUErL1ZwZy9oSFA4WVhmWUVTcDgvbk1zQVBpZFZzdkR1d3pxdzl5elVq?=
 =?utf-8?B?RVZ0b0tkVkFWUkJFNFhpSXhQNElGL21Vcjc5bVRBK2R4bFJMU2krVVg5WlBr?=
 =?utf-8?B?aXQ0cnd1dHhscWJMUy84ZThjd2ZCMlZNRlduem12cHBwYUFQRVpsNDJIOEV3?=
 =?utf-8?B?YVdGYVdkRThRQ2VHTThSb3B4Y0ZoMy9hcEhaRG5KWEtzUHhiS3dLekwrdnBZ?=
 =?utf-8?B?V0tmMFdQekI2K1U0dGNYeGxtdlRnd0ZxUytTUy94TXpxeGp4WTJHcE9WbTV6?=
 =?utf-8?B?N2ZqTy8rbEJnVUI3bVhaS24zZ3lhc1dGKy9hSkk0bmxrK096VkFJM1plVTFN?=
 =?utf-8?B?OWY1VVFUS3d0TzA4M0NiOS9aSy8xc0x6eEpyM3ZjZjd6MWFDaDl4d1Y1ZGE4?=
 =?utf-8?B?TWFLVnBsNnhwelVpeEFnaURxY2gyci81WUNpYUZIa25CZDB6WVQ1cy9BN1BZ?=
 =?utf-8?B?UHhlejM0SXRZN21sNWpJci9KWjlENjdub1ZzS2pCSFF5bi83M0F5ZWp2Sldl?=
 =?utf-8?B?dGZMSkxMQ1prL2ErQVVZRU1wRnJqUytIeCtNaGtBWmlMbEdkVWFFSWM3U252?=
 =?utf-8?B?Y3lVelBIYW00bzRGL00vRWg5SWhwbFN2TGUzdXZzTlI1QXRMN1VpUTdsSkQ1?=
 =?utf-8?B?U3F4Y3ZSYnhKb0UvNUxCKzQrWVJ6aFgwekVsL2prYWt3V2NUaEVvQm1RTzJx?=
 =?utf-8?B?L1Q5cGlLdFNEeHFMdjhvYTZ0TS9PZENrSWpiRlFqUUJTYUJxUHRCeUNaUk56?=
 =?utf-8?B?NW9LVlE0RGdMVjhPWFZMd2hOZlhyc0lvdXF2RTQzRCs3c3U2WjlJR2FldGJV?=
 =?utf-8?B?MjdwdUlrSWQ1Q2I2SldPajJjdVVGTkVIa0pHUzg5QllQR3dJUE9iTW5JejBi?=
 =?utf-8?B?Sk9uYkFjSXFqMHhmUmdhdk4xQUQ1NVBMVWp6Mjc4aVpQdSt2UzB3Y3pPVEpY?=
 =?utf-8?B?bE5IOTBTa0NkWk83V2FaUExvL3E4MDFHS0hSVUNvT0h1WGZaMlU2aVBNOGJ4?=
 =?utf-8?B?ZFhEM25hQVplUW9DSTNQbjV0dEswb0hjeHU1RC9VTlUreHdKM1JOYUQvN3hM?=
 =?utf-8?B?L29tVzQ4a0o3MnhhTVNrSG96WFRyTEFJb2FMTkt6S1VVeWhXcC80ViszOG45?=
 =?utf-8?B?L0RGTVJydXZBUzFIUWhtaFZvcEpIOVJhYlVYQ3NkdWN0ZHZiZC9xdWlKMVh0?=
 =?utf-8?B?QmNEOU8xN2xaV3JSWExwdHVaTmt5QmQxdHNqSVd5ckJVRFJ1OUtRejJtdXNr?=
 =?utf-8?B?NWRkTm90cVNkUHJSQkdjVUpwOExuMWtnU084Mngwekx4WDQrSVFlUFlUY0hB?=
 =?utf-8?Q?6XBvYk9akKIDIEG/ZHTYq1953B8nkQWTriGahKq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69117480-4511-4f9f-5772-08d8e334ea33
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2021 19:52:48.7988
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LNfwIxD/pH0Jta3jWxxsW+eTjFFRPA8lgGJ8rQ5WJJAfGe/GzQba50XomYyLrk4W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4045
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--=_MailMate_DC4EE074-9620-4C9D-AB73-C4315CB1453D_=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 1 Mar 2021, at 19:01, Axel Rasmussen wrote:

> Modify the userfaultfd register API to allow registering shmem VMAs in
> minor mode. Modify the shmem mcopy implementation to support
> UFFDIO_CONTINUE in order to resolve such faults.
>
> Combine the shmem mcopy handler functions into a single
> shmem_mcopy_atomic_pte, which takes a mode parameter. This matches how
> the hugetlbfs implementation is structured, and lets us remove a good
> chunk of boilerplate.
>
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> ---
>  fs/userfaultfd.c                 |  6 +--
>  include/linux/shmem_fs.h         | 26 ++++-----
>  include/uapi/linux/userfaultfd.h |  4 +-
>  mm/memory.c                      |  8 +--
>  mm/shmem.c                       | 92 +++++++++++++++-----------------=

>  mm/userfaultfd.c                 | 27 +++++-----
>  6 files changed, 79 insertions(+), 84 deletions(-)
>
> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> index 14f92285d04f..9f3b8684cf3c 100644
> --- a/fs/userfaultfd.c
> +++ b/fs/userfaultfd.c
> @@ -1267,8 +1267,7 @@ static inline bool vma_can_userfault(struct vm_ar=
ea_struct *vma,
>  	}
>
>  	if (vm_flags & VM_UFFD_MINOR) {
> -		/* FIXME: Add minor fault interception for shmem. */
> -		if (!is_vm_hugetlb_page(vma))
> +		if (!(is_vm_hugetlb_page(vma) || vma_is_shmem(vma)))
>  			return false;
>  	}
>
> @@ -1941,7 +1940,8 @@ static int userfaultfd_api(struct userfaultfd_ctx=
 *ctx,
>  	/* report all available features and ioctls to userland */
>  	uffdio_api.features =3D UFFD_API_FEATURES;
>  #ifndef CONFIG_HAVE_ARCH_USERFAULTFD_MINOR
> -	uffdio_api.features &=3D ~UFFD_FEATURE_MINOR_HUGETLBFS;
> +	uffdio_api.features &=3D
> +		~(UFFD_FEATURE_MINOR_HUGETLBFS | UFFD_FEATURE_MINOR_SHMEM);
>  #endif
>  	uffdio_api.ioctls =3D UFFD_API_IOCTLS;
>  	ret =3D -EFAULT;
> diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
> index d82b6f396588..f0919c3722e7 100644
> --- a/include/linux/shmem_fs.h
> +++ b/include/linux/shmem_fs.h
> @@ -9,6 +9,7 @@
>  #include <linux/percpu_counter.h>
>  #include <linux/xattr.h>
>  #include <linux/fs_parser.h>
> +#include <linux/userfaultfd_k.h>
>
>  /* inode in-kernel data */
>
> @@ -122,21 +123,16 @@ static inline bool shmem_file(struct file *file)
>  extern bool shmem_charge(struct inode *inode, long pages);
>  extern void shmem_uncharge(struct inode *inode, long pages);
>
> +#ifdef CONFIG_USERFAULTFD
>  #ifdef CONFIG_SHMEM
> -extern int shmem_mcopy_atomic_pte(struct mm_struct *dst_mm, pmd_t *dst=
_pmd,
> -				  struct vm_area_struct *dst_vma,
> -				  unsigned long dst_addr,
> -				  unsigned long src_addr,
> -				  struct page **pagep);
> -extern int shmem_mfill_zeropage_pte(struct mm_struct *dst_mm,
> -				    pmd_t *dst_pmd,
> -				    struct vm_area_struct *dst_vma,
> -				    unsigned long dst_addr);
> -#else
> -#define shmem_mcopy_atomic_pte(dst_mm, dst_pte, dst_vma, dst_addr, \
> -			       src_addr, pagep)        ({ BUG(); 0; })
> -#define shmem_mfill_zeropage_pte(dst_mm, dst_pmd, dst_vma, \
> -				 dst_addr)      ({ BUG(); 0; })
> -#endif
> +int shmem_mcopy_atomic_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
> +			   struct vm_area_struct *dst_vma,
> +			   unsigned long dst_addr, unsigned long src_addr,
> +			   enum mcopy_atomic_mode mode, struct page **pagep);
> +#else /* !CONFIG_SHMEM */
> +#define shmem_mcopy_atomic_pte(dst_mm, dst_pmd, dst_vma, dst_addr, \
> +			       src_addr, mode, pagep)        ({ BUG(); 0; })
> +#endif /* CONFIG_SHMEM */
> +#endif /* CONFIG_USERFAULTFD */
>
>  #endif
> diff --git a/include/uapi/linux/userfaultfd.h b/include/uapi/linux/user=
faultfd.h
> index bafbeb1a2624..47d9790d863d 100644
> --- a/include/uapi/linux/userfaultfd.h
> +++ b/include/uapi/linux/userfaultfd.h
> @@ -31,7 +31,8 @@
>  			   UFFD_FEATURE_MISSING_SHMEM |		\
>  			   UFFD_FEATURE_SIGBUS |		\
>  			   UFFD_FEATURE_THREAD_ID |		\
> -			   UFFD_FEATURE_MINOR_HUGETLBFS)
> +			   UFFD_FEATURE_MINOR_HUGETLBFS |	\
> +			   UFFD_FEATURE_MINOR_SHMEM)
>  #define UFFD_API_IOCTLS				\
>  	((__u64)1 << _UFFDIO_REGISTER |		\
>  	 (__u64)1 << _UFFDIO_UNREGISTER |	\
> @@ -196,6 +197,7 @@ struct uffdio_api {
>  #define UFFD_FEATURE_SIGBUS			(1<<7)
>  #define UFFD_FEATURE_THREAD_ID			(1<<8)
>  #define UFFD_FEATURE_MINOR_HUGETLBFS		(1<<9)
> +#define UFFD_FEATURE_MINOR_SHMEM		(1<<10)
>  	__u64 features;
>
>  	__u64 ioctls;
> diff --git a/mm/memory.c b/mm/memory.c
> index c8e357627318..a1e5ff55027e 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3929,9 +3929,11 @@ static vm_fault_t do_read_fault(struct vm_fault =
*vmf)
>  	 * something).
>  	 */
>  	if (vma->vm_ops->map_pages && fault_around_bytes >> PAGE_SHIFT > 1) {=

> -		ret =3D do_fault_around(vmf);
> -		if (ret)
> -			return ret;
> +		if (likely(!userfaultfd_minor(vmf->vma))) {
> +			ret =3D do_fault_around(vmf);
> +			if (ret)
> +				return ret;
> +		}
>  	}
>
>  	ret =3D __do_fault(vmf);
> diff --git a/mm/shmem.c b/mm/shmem.c
> index b2db4ed0fbc7..6f81259fabb3 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -77,7 +77,6 @@ static struct vfsmount *shm_mnt;
>  #include <linux/syscalls.h>
>  #include <linux/fcntl.h>
>  #include <uapi/linux/memfd.h>
> -#include <linux/userfaultfd_k.h>
>  #include <linux/rmap.h>
>  #include <linux/uuid.h>
>
> @@ -1785,8 +1784,8 @@ static int shmem_swapin_page(struct inode *inode,=
 pgoff_t index,
>   * vm. If we swap it in we mark it dirty since we also free the swap
>   * entry since a page cannot live in both the swap and page cache.
>   *
> - * vmf and fault_type are only supplied by shmem_fault:
> - * otherwise they are NULL.
> + * vma, vmf, and fault_type are only supplied by shmem_fault: otherwis=
e they
> + * are NULL.
>   */
>  static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
>  	struct page **pagep, enum sgp_type sgp, gfp_t gfp,
> @@ -1830,6 +1829,12 @@ static int shmem_getpage_gfp(struct inode *inode=
, pgoff_t index,
>  		return error;
>  	}
>
> +	if (page && vma && userfaultfd_minor(vma)) {
> +		unlock_page(page);
> +		*fault_type =3D handle_userfault(vmf, VM_UFFD_MINOR);
> +		return 0;
> +	}
> +
>  	if (page)
>  		hindex =3D page->index;
>  	if (page && sgp =3D=3D SGP_WRITE)
> @@ -2354,14 +2359,12 @@ static struct inode *shmem_get_inode(struct sup=
er_block *sb, const struct inode
>  	return inode;
>  }
>
> -static int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
> -				  pmd_t *dst_pmd,
> -				  struct vm_area_struct *dst_vma,
> -				  unsigned long dst_addr,
> -				  unsigned long src_addr,
> -				  bool zeropage,
> -				  struct page **pagep)
> +int shmem_mcopy_atomic_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
> +			   struct vm_area_struct *dst_vma,
> +			   unsigned long dst_addr, unsigned long src_addr,
> +			   enum mcopy_atomic_mode mode, struct page **pagep)
>  {
> +	bool is_continue =3D (mode =3D=3D MCOPY_ATOMIC_CONTINUE);
>  	struct inode *inode =3D file_inode(dst_vma->vm_file);
>  	struct shmem_inode_info *info =3D SHMEM_I(inode);
>  	struct address_space *mapping =3D inode->i_mapping;
> @@ -2378,12 +2381,17 @@ static int shmem_mfill_atomic_pte(struct mm_str=
uct *dst_mm,
>  	if (!shmem_inode_acct_block(inode, 1))
>  		goto out;
>
> -	if (!*pagep) {
> +	if (is_continue) {
> +		ret =3D -EFAULT;
> +		page =3D find_lock_page(mapping, pgoff);
> +		if (!page)
> +			goto out_unacct_blocks;
> +	} else if (!*pagep) {
>  		page =3D shmem_alloc_page(gfp, info, pgoff);
>  		if (!page)
>  			goto out_unacct_blocks;
>
> -		if (!zeropage) {	/* mcopy_atomic */
> +		if (mode =3D=3D MCOPY_ATOMIC_NORMAL) {	/* mcopy_atomic */
>  			page_kaddr =3D kmap_atomic(page);
>  			ret =3D copy_from_user(page_kaddr,
>  					     (const void __user *)src_addr,

Hi Axel,

shmem_mcopy_atomic_pte is not guarded by CONFIG_USERFAULTFD, thus it is
causing compilation errors due to the use of enum mcopy_atomic_mode mode,=

when CONFIG_USERFAULTFD is not set.


=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_DC4EE074-9620-4C9D-AB73-C4315CB1453D_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmBH0ggPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqK3TEP/13+fp5MFtdNoVk4LtbycPO2UFgR7AS5LR8b
qZt01ZLBq+iMxtFXV+5Z5Grt83c4dztoI/8rDbLVm5QdTgD5kRJzogDdRglFuY9g
e6lXer060JuIz2gtuUF9rIjpStK0pIODe6X1ZqvU/PF4pz3Wgk/UMEjiMARqqDnn
L/ksHCiyV0WqlKcrlTlGEhnT8JEXOEbkMcbUqL9s6gu9yTuZnfgu7b+sZ1T8Fm+J
vK0mMicoc9bXSnula3CVA98nPywyhvR9N9uVK10+CySCznh2Vwh3w222/2piy9kF
tsv7wIhhsHmdazsPZEKalkgyG+AegL28ji23K6OTeCioz+TSEUMXkY2AU8O2GdR/
AMqgwxmlkKVWYdyByrr++FwFafahDA4TqWbJz3c614GgV+IxOFY9+KLggzAh1Afc
xYkP797jQVH4FiIZpFEiyISu2MkqFl7xKR3Sg2TerIY7oqGjOJ3ouO0Pfb1DJ54p
WZUDmidczpeA/40TBo4rxJilpShJZIWAuePm9TUl4m/7r4qC4nH0QgUcNk2zFe0I
fNxZJO1bzRHSiw39yYv6VT/RMQEbxoRjXuWjo5d3YseSQV7qGdIyf9HRKBh6JmBX
FQtmXqRgpxmcfoFy4JbB8uMUzpSu0GI2OTKR7ND22lpVxx2Vy9lfHD0pgqrLm9gA
bmfHG8tu
=A/j0
-----END PGP SIGNATURE-----

--=_MailMate_DC4EE074-9620-4C9D-AB73-C4315CB1453D_=--
