Return-Path: <linux-fsdevel+bounces-13891-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3077875285
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 15:58:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1263A1C23E5E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 14:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753B912EBCB;
	Thu,  7 Mar 2024 14:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ArWceSIB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E651E89D;
	Thu,  7 Mar 2024 14:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709823523; cv=fail; b=RMKBId9JyaBqJDS851cg33l3/Z7uZOxjMbTVTiJ26cPGyJTyGQvcwmzrS5sBMoOakR4lIRlY9fXiNQOnpmHEgjlM8B8/x3YV4q1WRWd7rkqz9wpOcl3pRCgPDXW3pKHtQ2fAFvxFbqoFvtUoygilJt+sU5dgKSGikxQkINav0Rc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709823523; c=relaxed/simple;
	bh=tBJYfHltlDFwd1wz0ldKORx6we99iajw67pd/b7QjQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Wt0Ukj5kcKoX6+1hdo1S47JXev6cMSzUCRY5/flaXs+1M0SJV8cUgno6vowAtqKXDRcwwfnxvwN2qSDFY3bJMCnvcL3s3ohrOq7/7QRdeU5MmLXSmDulIN7mrQCantHmNgVSFROMJj9yMPggbkB2G5ZOTVyYbqVv7VscqzglekI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ArWceSIB; arc=fail smtp.client-ip=40.107.93.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QOOfnR8xFCmN1lFBfcZKY2XnJ8i7LHLOJsJXu03WB7nh75KpZNvzYO1jRo6/6IrszgN+TcsniEENCx+Ibp2AO9vid2RvSPvTKVNMeUFqKjwp21Tbg10ZnUgATF2vWln7nAnZ0UnZpXgMj9HxZCaSiO8LWejdosyJTEDih6D4BdbBUkgevngeyg654K0KQCYc3z+8aFfyQIPAhSNB8SZOFQpIMCo2WubLWHTEKlEyt8wOOWnXy9s0BguKbdY4cAmJbpFJpuCyLtZdz3zpuOwNf1pZDXq64xe7+LaNXG0kIKoymCqqvf16hd1FULfNNojcI/za5KsbIPZpwTFPZTNahg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1vv+cvqrBr7Y7XvMWMSCLMfwxDKrVh/Vey9+8gmQfrI=;
 b=ABDiJie/ubkYBM1tVWT84IkiLt5eBlUnXEYF5M1tAzMoXN5liVA2rFYlHLZnGVRxLABBZMN2qCiAJMKnJtudKvDoV2ffgf7xnbMDp7BxI4J5vAs/KVSpMZmMqLGfSmQ9sE79pfegO2SjvrIAsb6MRJ+ozBoZ8g4OGsPGPXKAEVwxGGCtc/kVaT0HeV92PjlQhIiqLudqHmVJF+VXxlmHnM+OOepfxXStvL8DE26YS95bMf4bqD24yvre5HfT/IQuH1t6rLCnQTPO9SGZRsd8RAkTk0yp60WoVkyubEYmF6OusAcWBt/P5e4K0EsRtJAzgSDkN7+hqSEWZiHC6C/vIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1vv+cvqrBr7Y7XvMWMSCLMfwxDKrVh/Vey9+8gmQfrI=;
 b=ArWceSIBgKTXATEMAEMl5JZPgjQCkCSouOmiGPY6/7EZWmvMkRhj52aZ9SwfzGdE9yEL4Qb8QOEeU8DluKO9n5dNkea0wOZfYJLS0SfrnQWqixpwnRfflMunNc21XNHf1cRTfmzuRmZ2YhFfEng9zCjNfj5pqiJqA7sFDSTi4OcemTsEVk9lWvPCqwr1zk3Wu8ZlMCZJDmYnAnarGf1oxeulabGDIFEDBja27wf3gluPkEfbD3Kd6fqA9JIhY4ah64VVnC7XHEdpTvEKlOgJN2+8WeZsAO2S4OQhaOnDcRc/e5pPO/HQuRVQxINT4vGePqxj1/xTTMSzDHPL/FOWqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 DS0PR12MB8575.namprd12.prod.outlook.com (2603:10b6:8:164::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7339.39; Thu, 7 Mar 2024 14:58:38 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753%6]) with mapi id 15.20.7362.024; Thu, 7 Mar 2024
 14:58:38 +0000
From: Zi Yan <ziy@nvidia.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org,
 "\"Pankaj Raghav (Samsung)\"" <kernel@pankajraghav.com>,
 Zi Yan <ziy@nvidia.com>, "\"Matthew Wilcox (Oracle)\"" <willy@infradead.org>,
 David Hildenbrand <david@redhat.com>, Yang Shi <shy828301@gmail.com>,
 Yu Zhao <yuzhao@google.com>,
 "\"Kirill A . Shutemov\"" <kirill.shutemov@linux.intel.com>,
 Ryan Roberts <ryan.roberts@arm.com>,
 =?utf-8?q?=22Michal_Koutn=C3=BD=22?= <mkoutny@suse.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 "\"Zach O'Keefe\"" <zokeefe@google.com>, Hugh Dickins <hughd@google.com>,
 Luis Chamberlain <mcgrof@kernel.org>, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH v5 7/8] mm: thp: split huge page to any lower order pages
Date: Thu, 07 Mar 2024 09:58:34 -0500
X-Mailer: MailMate (1.14r6018)
Message-ID: <FD2D17E1-5B18-4342-8692-FCE2FA774895@nvidia.com>
In-Reply-To: <20240226205534.1603748-8-zi.yan@sent.com>
References: <20240226205534.1603748-1-zi.yan@sent.com>
 <20240226205534.1603748-8-zi.yan@sent.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_B8DAFD2B-C04B-489B-B42B-E18B80234EC8_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BLAP220CA0028.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::33) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|DS0PR12MB8575:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ba4b84b-2393-42de-242d-08dc3eb711e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	euu0hl1EMGOXF+qGDXACburRrCYLucLv4l1nCRyVNEyGvgB9NjIvw2ES6bAzRtsuUQM1QadRsEJZRPrT1eV8IcKCaUCv7lC18gFe49QBCYMd/5oXiu0neHp9Tf1/NX65s3qa3jkBA0abvb2m+zPaFVKPtd14+8FuTBh3P20fTj9ClZJKTNePoSqRp9kzfnZd1SVK8LtU4EJDHBctkuhpuQYW6MlD1p7aVzsoATGLmEwk4iMytXQUUIuGs9PWhs5GppKEueJ5kdLA0jwsEeCrGHEmyY16PEnEJj3gJX0i9SZL6Edz+eMgGIjdRf56feAD7+WVHDJh15QKHXD+oiF3ENRX23JrXqyp4bTDCQc73lINO/DmqtDO9QbsJysrjVBcUhQfbEqJFbxfKBffrxCFUpuE6EPz6oFclilAgaUF2C/KcbtXHg5dDGe9sL2XfszJDCyGrSoJ3eWdoaYgu9QReDNSuRKfkUHYwrr0EfX+GmYet0UJXQM2tY7ardfbgSLnjjJ46IhIuz5oTy1E6kXFTWnS51qzP/Jnbw1UgmpHvhPydVUR7CLDY0qfybsKha/N+hBTQ4mfskd//ImoCugFf1dXHb2QJ3f7BF5UMj6mo0EKS6+IALPdjDGf/txZ7uRsZnDh0TDQcDhOk/6ycmDX/HYq4zitTHUPJIYUi+u4boY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?15J7Vl2CRuPKR8SmVbwXZk+tcQAz+3gYVg+BKiL5jtX0IfnFzJo1dm8Y9vsc?=
 =?us-ascii?Q?ZSRc76yZzWuxqJvT5ay9bd57pI4sPfElnY+090KkZiGocdC2L6OAL5FaQX+S?=
 =?us-ascii?Q?NwRSocAsGjMDDrjUYlducq7+SM3xGjKGXjZser/wBcHuEq3kkBm7Yzpx5wc+?=
 =?us-ascii?Q?Fi2NI4ACopNJSrIGH9154R07UuLv7mHXwAsxtqutNIxheuJSoQR3QJ+Xefgp?=
 =?us-ascii?Q?u6u87spqGD8LiYtB+lNbbtEx18ych+yBDtOdj5K5Kw7WnEl1SkonbZcbVoeG?=
 =?us-ascii?Q?2Rk5bE92GQ+nc3W+F8Y/8NUSyfd+Haec7Itwaeu1A7viF6MCgUBDYjB0Rhv9?=
 =?us-ascii?Q?2cYm0EOxxrP16OCBuTZtxbL7xm9btTEZ7TRUuzo9nyJHvtkXKzdtvMxOG2I3?=
 =?us-ascii?Q?XLgidk60RzfOGHf4s/O+nd46E6Fik/LrdrqeYDRmyC+MRFe1XgZHAWeY4+Wy?=
 =?us-ascii?Q?eqXzPQH9nJXay7eyINZT9Ml12jU4djrOaUdxlfrrqTilJaJrf9uHjggv2ppY?=
 =?us-ascii?Q?KQur5wsOhxVVzUt7qCeRu9j7XYMzDtm07xAi8kcSmSXyA2td91uxWSocsk7a?=
 =?us-ascii?Q?bOsMwHKVgys4ME9h8CDWGisPoQMYDNZh9aDRF4om8eJ65HhDYaHEk687/Y9H?=
 =?us-ascii?Q?1H9TAwS1nClJm5EyyIClU+iYkxFYlcQ/LbXtk9tI+gxcOyKpAOzM8bujYDSV?=
 =?us-ascii?Q?Kg5hN3egtMeBq2yBUA41Aw/ja8w4lUs8fuafbz9et9/ZAR3NIFkzt0OAd2Z+?=
 =?us-ascii?Q?16ECvw7OPz67rOowB7mjHZF+LiXa5sZanOfZhflqJzd88K6CAM73te9HNmtY?=
 =?us-ascii?Q?YwxchxgmhyjzI2SIxBa1oCMKs9L7nksKFZH3L7KkTMK4zkmQkKCrUBfpu6ZN?=
 =?us-ascii?Q?9HVAcO8XRHbej+Gya6CsU+d7jRezI4BS1lfkR1v31JIhZ4qgR+Xtv1ZkPRme?=
 =?us-ascii?Q?SUbE0EwS7w4rZP6RG9PIkccXkRjNtCnL7AKL+3rDvQhyfjHVFOSRlg9W1qAb?=
 =?us-ascii?Q?Ci3IdoJuz3fz5UDuKWue3dDpGYAs+yMUnWEOh3Pm5FOBOzeZwY346AmSy4I3?=
 =?us-ascii?Q?8VUjmCmGH0pbPoFqmU1bpS2DKLcvG+aH2IRVmT/JM/Wtnv5I7fAdTuA8P3t8?=
 =?us-ascii?Q?fVZqbWMkQJwALgSwP51ItxorYP3P52PGrGiuQeEIhOwKThui6I4EVDgSBHbY?=
 =?us-ascii?Q?ghac/Ayo+3dmRcq0h7d+rJHbdgTCvh2+z5WUxe8QviBuv32lkdbAvBE5KlLI?=
 =?us-ascii?Q?OJ4eKU1XDgeFqNd2K+0KTauSKC/SGpMTPxvc93Kptifr5PqlfBf+t2aRCw9Y?=
 =?us-ascii?Q?zlsreGRxj04uDAfRMWwAI8POERDNuY2hRnDhlgj0Ep7Bo6iWO9ntixxOVKxi?=
 =?us-ascii?Q?alzBS2KHqczwL7sRrFmFtu7NckPioQqWqYZYsG1oDQM8pPOATQyUTb4t+eVY?=
 =?us-ascii?Q?UX14Tk+pyU1iWY2/Qap8KuNeX26vhYZ+Tt7iTtue7jc2px71NlmAm6lZxDaZ?=
 =?us-ascii?Q?4AdYAJJIXtZSjEYGVrW9919vcMP9RhB7WI2nmjHG8bM+Ry6qJ9gNzKlSyYG+?=
 =?us-ascii?Q?RbZBCJuQ89nqSGhkZpeP50F/fRfEk4meja7v1JX6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ba4b84b-2393-42de-242d-08dc3eb711e3
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 14:58:38.1309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M8XV+TifusyUEtbohxKxRttRCCDzmL1G+1eX/wpQPYqitKYo4uxfp80nDCfBqr75
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8575

--=_MailMate_B8DAFD2B-C04B-489B-B42B-E18B80234EC8_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 26 Feb 2024, at 15:55, Zi Yan wrote:

> From: Zi Yan <ziy@nvidia.com>
>
> To split a THP to any lower order pages, we need to reform THPs on
> subpages at given order and add page refcount based on the new page
> order. Also we need to reinitialize page_deferred_list after removing
> the page from the split_queue, otherwise a subsequent split will
> see list corruption when checking the page_deferred_list again.
>
> Note: Anonymous order-1 folio is not supported because _deferred_list,
> which is used by partially mapped folios, is stored in subpage 2 and an=

> order-1 folio only has subpage 0 and 1. File-backed order-1 folios are
> fine, since they do not use _deferred_list.
>
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---
>  include/linux/huge_mm.h |  21 +++++---
>  mm/huge_memory.c        | 110 +++++++++++++++++++++++++++++++---------=

>  2 files changed, 99 insertions(+), 32 deletions(-)

Hi Andrew,

Can you fold the patch below into this patch 7? It is based on the discus=
sion
with Dan Carpenter at https://lore.kernel.org/linux-mm/7dda9283-b437-4cf8=
-ab0d-83c330deb9c0@moroto.mountain/.
It prevents invalid new_order input from causing unexpected outcome of
split_huge_page_to_list_to_order(). Especially in patch 8, new_order can =
come
from debugfs without any restriction. I will send another fixup to
patch 8 to check new_order from debugfs.

Thanks.

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index a81a09236c16..57fca7bffd20 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3052,6 +3052,9 @@ int split_huge_page_to_list_to_order(struct page *p=
age, struct list_head *list,
        VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
        VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);

+       if (new_order >=3D folio_order(folio))
+               return -EINVAL;
+
        /* Cannot split anonymous THP to order-1 */
        if (new_order =3D=3D 1 && folio_test_anon(folio)) {
                VM_WARN_ONCE(1, "Cannot split to order-1 folio");


--
Best Regards,
Yan, Zi

--=_MailMate_B8DAFD2B-C04B-489B-B42B-E18B80234EC8_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmXp1hoPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUMnEQAJ1C/Cy05bUNn2krv9foAAFlcORFj0/hyisD
19MRI7B4l1iYcHZDqYNj9WwhOypnOIYqdDutkHhJGwZBCnoYwmfZizaNmwOZu/d5
H5HjNIV2RXsBXWbwMM/f750Y8Vc2ccVQvS57np/5mYiVfFjJ7AAr3d8cdSxDlJwq
JytAgGLXJS6bV2GIX8AxLc/AwKAe+8cCZRU3pf24P40FM4u5GhkASbTrY0UzsqeZ
mUmkH6th0H5ZDBiu3GMVsIbHqlOutP2D9rmptcvqcZuxrFKIZ5tK7VweJ1VdU7SV
Ddgclc8pTtNY1hdzDgvd9OdkhZDDTMTdl748cdbtR59E5TT+JByr8Ofwkdx1KWqI
W6mP+Kxte3jWwAjxRCzp3mb3MbjS+/O7KGH6vJM+2Yc2lu0Pt3aKxsxOSmHPJcdD
uH7e8FOMjSDoKsTA5t/OCxWiv4a5NxEppNnW7+kgmcGmNwQLNU4WvNggvTmHHeks
ReqsKkfFtg7M0DnRDBajETEoQJw49VcIkxM0jDq0nVNuIJSH3uctIZPj8NAkIlF1
gSxx8uT8vY5BrYAhT7aZ2QP8MhGLIqtdtoWNafMgN0IbcbM2AZX6UQUWh1xsV4pw
FY27IoBS/uVnaxYEgrKuY2uQUZl+/kVPSabXdfwCFcrpQWXlhM52wO9jzwO1jMU4
8g5WhRPf
=r1py
-----END PGP SIGNATURE-----

--=_MailMate_B8DAFD2B-C04B-489B-B42B-E18B80234EC8_=--

