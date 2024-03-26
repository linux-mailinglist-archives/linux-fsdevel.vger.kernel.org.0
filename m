Return-Path: <linux-fsdevel+bounces-15358-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7068888C91E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 17:27:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 118A7B29316
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 16:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F8913CA8F;
	Tue, 26 Mar 2024 16:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QQ9Fmyf2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2121.outbound.protection.outlook.com [40.107.220.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9EA12D1EB;
	Tue, 26 Mar 2024 16:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711470230; cv=fail; b=fuenCJ/MDBBuA4Aro//JMyfDMr88thHUO2rnedlw0W2IyDH6TxjqUQKXJSf+jCzy10/lHR/NtJTy/7ypKK0aomm4oInmwATkQzN67QIk4LoR4MZiq2jjGbsn9aTlt4Ep1dm1kz3q+bA9RZmO0Dg8K5+4Mww49VHE1O0HqGQvFcQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711470230; c=relaxed/simple;
	bh=7vJuH1ColHlh4x9JWWx22aHrsEuN6QnB/TvdB/6J5Mo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qlJdqeXn0FUEXjExdZUwDWHLKXuyAzVeb9tHqEsgIOUZ2fwkaVPGho4eEGXxZdg6td+TZxUw4PY+gZHxXsZCmW0qiW3A4P/D7eV9DiEjEzO0lKIkQH8ZqXolnyJ9oritwAjLpIrUoPj3bBMxr0P+7NXrs8rx0BYMToDrf+2khqE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QQ9Fmyf2; arc=fail smtp.client-ip=40.107.220.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VaoPJI+5oU34Gj7vsbZgBPCTBbXT++BskxkEnRZw/tj5pq3MJDSfNQwyLMGZWFYrh1r3ZW9LCn/3R6+ZnqlmXYmLPinp66BQm83bKJIG32RTg8rCbNUGS0sRD7WAJ6lwf3sUd2AddifTW8fgm4gkqf34a9B+UNcaezB3CdJfprFP8vTrU04OXs87LXFy8vJ+fgPq0SaywNr8dvy+D2wavogsD8CG66Byku0mK++6c/0EX31G/wFa+4eHZEJd6v8hSJnNcqFjxOkEqIjoKtr9oQbahbNAb1YpHp8wMtRlbOZd0QcEUQZkIinpbgz2jvQTqSP0uHv7adnNNoJIqGW+WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fqQDgMkBfvkN4PAfPSDAkvASWoEzuGk/azR7cIOfwho=;
 b=HniscXOwoDNC0T6NButfSiiiklytmqk/kt+akzLSNLtiYSsem+1ppu5HhNbzpW8Thpk1RBB6GdJpyLA7ozBiPzsEhq2nuINQ+K4uNlHUDGG0pCM6E+cnK2ZqEeW9RC5Wan76exZvDxrS2Bm5+/gAIxvo2ZQLW8iCeMKrtgRgIwk5vcJ0LqgZGcL7opECSZGZ1I2hX3FsLsF9nC9BitR+mEqjIubykyEi7GnEgvvDlTyniX6+Um9cql218IlxLH86mJKSJay9w0cXQm826r2QxKmFq4cnptkABqRFGnAc6moSgInuxRqz34jmUNKm/HaaZ5fUz1XGs0jvfytFO29PjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fqQDgMkBfvkN4PAfPSDAkvASWoEzuGk/azR7cIOfwho=;
 b=QQ9Fmyf2r0ZAnsaFSG4fzCipDez+43j0BtvrHU/DSba1bWHM2IC2vMMD/ftt5pZTz59YepaePoAPG3HzEgCESX/Pt1lFgWr4G4ooKwRxvV/p9raJ5uo9jrlXxYrm36Q28pkZKEwae2UcpqGS6O6Rk7VOPOgE4Klk7jo4Fc1OtzvzbZcFFiQjy4gyR9tFZmkErkqPDMmDnZQ7V286zcOPonflKHmS7pzLMqBJ+DdbIL+Kysntsv4lspH6Hnavd895+wU+ZuilovXcqU+dxEGj0Y+FksECNaR+5X/RcQR5siBRZZnW7jOJejELdtDeVvmFosRuVbp5e930NvEtOVLw8g==
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 DM4PR12MB8500.namprd12.prod.outlook.com (2603:10b6:8:190::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.31; Tue, 26 Mar 2024 16:23:40 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753%6]) with mapi id 15.20.7409.031; Tue, 26 Mar 2024
 16:23:40 +0000
From: Zi Yan <ziy@nvidia.com>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: Matthew Wilcox <willy@infradead.org>, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, gost.dev@samsung.com, chandan.babu@oracle.com,
 hare@suse.de, mcgrof@kernel.org, djwong@kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, david@fromorbit.com, akpm@linux-foundation.org,
 Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH v3 07/11] mm: do not split a folio if it has minimum folio
 order requirement
Date: Tue, 26 Mar 2024 12:23:37 -0400
X-Mailer: MailMate (1.14r6028)
Message-ID: <EE249FE8-2FE9-4BB0-B27A-6202F93B6C12@nvidia.com>
In-Reply-To: <muprk3zff7dsn3futp3by3t6bxuy5m62rpylmrp77ss3kay24k@wx4fn7uw7y6r>
References: <20240313170253.2324812-1-kernel@pankajraghav.com>
 <20240313170253.2324812-8-kernel@pankajraghav.com>
 <ZgHLHNYdK-kU3UAi@casper.infradead.org>
 <muprk3zff7dsn3futp3by3t6bxuy5m62rpylmrp77ss3kay24k@wx4fn7uw7y6r>
Content-Type: multipart/signed;
 boundary="=_MailMate_261F1C50-ABC5-456C-A886-DC5CAE0BA0B4_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR08CA0011.namprd08.prod.outlook.com
 (2603:10b6:208:239::16) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|DM4PR12MB8500:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	j/Lxnsr5y4GcJjs68FnbIlPAr5Kutv+JVO7U227R+htDfRDfXYmiwPAIccbYwp/UdUPpw4i44oiMHXEmyouityLxKg3v1eo9yqPMGaVlZT2QTTE1hnzkAc183Fqt2ixQk2Ak/bhyJ5BkMaXz6xIuYiuy5iXKXQOB7bNod3KTSgoueT+cNRsN3SSr4sRWVvFJWJHN8ZjeK6sb0wKPTTeKUkO+3TuWC4KzzRtQ8rT33gUj7jan0RjKdh0EcGltC1Lde3s4nl7yng/jwIapWZ2KLjqzFcM8AHE6KSSy1QHSPRKd1smImCOndstBRH4qN8eYY3uBhuxA8iypZHzf9vEqEwMzfAGxgeAjIGNEJHLzDEpPUagmkK7sx+xO+64z+dcL6SWuTIxza0b4wJSv8MhVLrPcX+ekpcj6hD6tKj/QooOcYu9daxEJmzxfpuOEkK+Ar8gzq6rbS0d8cag4gEVL106n+8Eny/9Zl+AVvhoeqSb5+tqHRUsxF6ZZx+a/eXtzHfHoGY5Q+kry9InQ1ms9kEhf9fMEvMVYziaO0HuVjdI+R/7Z8qZGc7UdqshEd8CmwdS1pc5pXGsBa65wJJu3neSdnPzDMaPC7w6f+cY6LIdKpWKCGAF+MT28mUS5iwzAUu+LJ0Sk2Etu6OSHD3VU07TgGvuj49zz6ih7VM/TGbw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6NX0Y0t05JECDR+vW3g//AD7bJJs+5+iSmT5L3JXxXg3W9yhPJrPx8HCU+Kn?=
 =?us-ascii?Q?cYdA4R6CExFKPyVhy0+sjU3Kz6wCaWDvEBHzCfm3KwGZSgIt4hjQmpDmyS57?=
 =?us-ascii?Q?4PFM3PNurSn345D35TOqNNwjm2PBskP5NyIaS4PSiE0oYkIimzwvOArsIctd?=
 =?us-ascii?Q?gqzcXEEIwSOoXso/KWjmwBIujFsNHvNTapjfu0PukXVB3gSjpmJYSfsjcIWS?=
 =?us-ascii?Q?pwSiO3+qX6SwmohBjdIVs+A8YsuxgdCa+CtTaB4Tq9C9c6ZOGXPng1I9IESE?=
 =?us-ascii?Q?8GLkhMb1Nc9hwtBO9Wb7AlDHRI2QYJPC1wz9daH6yB/rjXesfwRVjAhgoClf?=
 =?us-ascii?Q?1JbxCXXlICH9qe2G5tQC6JqK2JNXBdZ47WoF41si+704ts44Tgoe2plpmVOo?=
 =?us-ascii?Q?SCuBK/kYoAoMLVcSqIx5Q4RY9+4Llkaw7i8mu0/RMrg+v6VDt3zzQI4MfpoK?=
 =?us-ascii?Q?UMq99sKY8J1dJilhDotEANgUtYe8yZwzUeWPkCoAxaRoGG/NDzF8fBEcSE2n?=
 =?us-ascii?Q?mVYkV++Fy/Pj4d8BXDwwNxRnSpOETIsl7cEByYU/zT4LdszUmm3fpQzk9SpO?=
 =?us-ascii?Q?+VT578b12bZG1dnR5AKnkF3GVR+N9VAnFvnQ3DIMnt2FdP+WX6Xx59NGrf5p?=
 =?us-ascii?Q?KHVNQjkNKMFFnXIeKF1fppZvB6/ii91/LEO+S6v/35V3Msk52ALj51xdHjvv?=
 =?us-ascii?Q?IDLZYnyJXFBUALW6cZKniRtYB15dMeEhZq7IdtCdkbg7V3eY9kMJLpIMGFUO?=
 =?us-ascii?Q?/AN4xLMcpkI/piXhlBpyPmUH9OvfsLR8l/4565hRvo6b5BcTZUUTcrVTIWfw?=
 =?us-ascii?Q?VbpDJdstT5JDHxf7wHBUl0nXfgn3hND+MCgw7AIXC+bk2ULI+piBhbAtmTMN?=
 =?us-ascii?Q?jCLWFsR+469DWsbg5L964txIK83LoLKy4tJGKmufbAEcGs4wNS6CP+4KMZP3?=
 =?us-ascii?Q?kkVtmMNEMQG/k2A/qKzd2EhYny/6vJJZkWlh0CdEBBc3L4hkY2M9RRSsMAxj?=
 =?us-ascii?Q?oWHwGMqKAL1B9Nb9cU4qVYUs1QMhMZvcAI/N2kCy4rG0dE4xj1b5nGa4Ygl+?=
 =?us-ascii?Q?bUOictKESIEIGxmQJHe2V/t5cG5nbPZsa+uRW+KzPylrrxn/jjxjxoeSJeIk?=
 =?us-ascii?Q?FXAcyXc4X/VLHpFw7ttq81oMHp842HStFefHYfgRDGjr9HaKgAD9sOV83fHf?=
 =?us-ascii?Q?E5cYONcBpXWzQuj1Z6+OgaYcc/fvrBo0VGD4HQX8d5vJantnErCMx3IX/n6O?=
 =?us-ascii?Q?z8XfGMeVpa5ZiVt2PAyfwkqdn5U+LKe8kyEnYAKhVca53Ip9UpdSzJ0tf6G0?=
 =?us-ascii?Q?KoUGCAEhBU7yMH8siPmJ3pWPtMMqfofOFCEoSfFk2qm8g+V26HnV1snwsSND?=
 =?us-ascii?Q?ib8mmPAz1e3CAO2xv4E4xfdG/5R9IxxeVBVRyvnp2Lv+gAMCNdyuek/W/9UB?=
 =?us-ascii?Q?ZU29rTiLCv4zjF+csBsbmuG0Cwn8n+XOE6Y85kTtGJR2XuetBwTijTsdCs6g?=
 =?us-ascii?Q?KhybwbWcbBnTgVvFlGvkQ84IKLrR8wI9oE+rHIqyl0HRq9alQ0shTo5wtRYa?=
 =?us-ascii?Q?SPLiYruCYIoOQFyO020=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f44c86e0-a90f-40ea-c087-08dc4db118bc
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 16:23:40.1823
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FXykaS2SUiLi1iclK/utitv2FY1L4U0UAgW/1zqFQSFqSLAGUvseu59T6jcL6O1X
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8500

--=_MailMate_261F1C50-ABC5-456C-A886-DC5CAE0BA0B4_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 26 Mar 2024, at 12:10, Pankaj Raghav (Samsung) wrote:

> On Mon, Mar 25, 2024 at 07:06:04PM +0000, Matthew Wilcox wrote:
>> On Wed, Mar 13, 2024 at 06:02:49PM +0100, Pankaj Raghav (Samsung) wrot=
e:
>>> From: Pankaj Raghav <p.raghav@samsung.com>
>>>
>>> As we don't have a way to split a folio to a any given lower folio
>>> order yet, avoid splitting the folio in split_huge_page_to_list() if =
it
>>> has a minimum folio order requirement.
>>
>> FYI, Zi Yan's patch to do that is now in Andrew's tree.
>> c010d47f107f609b9f4d6a103b6dfc53889049e9 in current linux-next (dated
>> Feb 26)
>
> Yes, I started playing with the patches but I am getting a race conditi=
on
> resulting in a null-ptr-deref for which I don't have a good answer for
> yet.
>
> @zi yan Did you encounter any issue like this when you were testing?
>
> I did the following change (just a prototype) instead of this patch:
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 9859aa4f7553..63ee7b6ed03d 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -3041,6 +3041,10 @@ int split_huge_page_to_list_to_order(struct page=
 *page, struct list_head *list,
>  {
>         struct folio *folio =3D page_folio(page);
>         struct deferred_split *ds_queue =3D get_deferred_split_queue(fo=
lio);
> +       unsigned int mapping_min_order =3D mapping_min_folio_order(foli=
o->mapping);

I am not sure if this is right. Since folio can be anonymous and folio->m=
apping
does not point to struct address_space.

> +
> +       if (!folio_test_anon(folio))
> +               new_order =3D max_t(unsigned int, mapping_min_order, ne=
w_order);
>         /* reset xarray order to new order after split */
>         XA_STATE_ORDER(xas, &folio->mapping->i_pages, folio->index, new=
_order);
>         struct anon_vma *anon_vma =3D NULL;
> @@ -3117,6 +3121,8 @@ int split_huge_page_to_list_to_order(struct page =
*page, struct list_head *list,
>                         goto out;
>                 }
>
> +               // XXX: Remove it later
> +               VM_WARN_ON_FOLIO((new_order < mapping_min_order), folio=
);
>                 gfp =3D current_gfp_context(mapping_gfp_mask(mapping) &=

>                                                         GFP_RECLAIM_MAS=
K);
>
> I am getting a random null-ptr deref when I run generic/176 multiple
> times with different blksizes. I still don't have a minimal reproducer
> for this issue. Race condition during writeback:
>
> filemap_get_folios_tag+0x171/0x5c0:
> arch_atomic_read at arch/x86/include/asm/atomic.h:23
> (inlined by) raw_atomic_read at include/linux/atomic/atomic-arch-fallba=
ck.h:457
> (inlined by) raw_atomic_fetch_add_unless at include/linux/atomic/atomic=
-arch-fallback.h:2426
> (inlined by) raw_atomic_add_unless at include/linux/atomic/atomic-arch-=
fallback.h:2456
> (inlined by) atomic_add_unless at include/linux/atomic/atomic-instrumen=
ted.h:1518
> (inlined by) page_ref_add_unless at include/linux/page_ref.h:238
> (inlined by) folio_ref_add_unless at include/linux/page_ref.h:247
> (inlined by) folio_ref_try_add_rcu at include/linux/page_ref.h:280
> (inlined by) folio_try_get_rcu at include/linux/page_ref.h:313
> (inlined by) find_get_entry at mm/filemap.c:1984
> (inlined by) filemap_get_folios_tag at mm/filemap.c:2222
>
>
>
> [  537.863105] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [  537.863968] BUG: KASAN: null-ptr-deref in filemap_get_folios_tag+0x1=
71/0x5c0
> [  537.864581] Write of size 4 at addr 0000000000000036 by task kworker=
/u32:5/366
> [  537.865123]
> [  537.865293] CPU: 6 PID: 366 Comm: kworker/u32:5 Not tainted 6.8.0-11=
739-g7d0c6e7b5a7d-dirty #795
> [  537.867201] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS=
 rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
> [  537.868444] Workqueue: writeback wb_workfn (flush-254:32)
> [  537.869055] Call Trace:
> [  537.869341]  <TASK>
> [  537.869569]  dump_stack_lvl+0x4f/0x70
> [  537.869938]  kasan_report+0xbd/0xf0
> [  537.870293]  ? filemap_get_folios_tag+0x171/0x5c0
> [  537.870767]  ? filemap_get_folios_tag+0x171/0x5c0
> [  537.871578]  kasan_check_range+0x101/0x1b0
> [  537.871893]  filemap_get_folios_tag+0x171/0x5c0
> [  537.872269]  ? __pfx_filemap_get_folios_tag+0x10/0x10
> [  537.872857]  ? __pfx___submit_bio+0x10/0x10
> [  537.873326]  ? mlock_drain_local+0x234/0x3f0
> [  537.873938]  writeback_iter+0x59a/0xe00
> [  537.874477]  ? __pfx_iomap_do_writepage+0x10/0x10
> [  537.874969]  write_cache_pages+0x7f/0x100
> [  537.875396]  ? __pfx_write_cache_pages+0x10/0x10
> [  537.875892]  ? do_raw_spin_lock+0x12d/0x270
> [  537.876345]  ? __pfx_do_raw_spin_lock+0x10/0x10
> [  537.876804]  iomap_writepages+0x88/0xf0
> [  537.877186]  xfs_vm_writepages+0x120/0x190
> [  537.877705]  ? __pfx_xfs_vm_writepages+0x10/0x10
> [  537.878161]  ? lock_release+0x36f/0x670
> [  537.878521]  ? __wb_calc_thresh+0xe5/0x3b0
> [  537.878892]  ? __pfx_lock_release+0x10/0x10
> [  537.879308]  do_writepages+0x170/0x7a0
> [  537.879676]  ? __pfx_do_writepages+0x10/0x10
> [  537.880182]  ? writeback_sb_inodes+0x312/0xe40
> [  537.880689]  ? reacquire_held_locks+0x1f1/0x4a0
> [  537.881193]  ? writeback_sb_inodes+0x312/0xe40
> [  537.881665]  ? find_held_lock+0x2d/0x110
> [  537.882104]  ? lock_release+0x36f/0x670
> [  537.883344]  ? wbc_attach_and_unlock_inode+0x3b8/0x710
> [  537.883853]  ? __pfx_lock_release+0x10/0x10
> [  537.884229]  ? __pfx_lock_release+0x10/0x10
> [  537.884604]  ? lock_acquire+0x138/0x2f0
> [  537.884952]  __writeback_single_inode+0xd4/0xa60
> [  537.885369]  writeback_sb_inodes+0x4cf/0xe40
> [  537.885760]  ? __pfx_writeback_sb_inodes+0x10/0x10
> [  537.886208]  ? __pfx_move_expired_inodes+0x10/0x10
> [  537.886640]  __writeback_inodes_wb+0xb4/0x200
> [  537.887037]  wb_writeback+0x55b/0x7c0
> [  537.887372]  ? __pfx_wb_writeback+0x10/0x10
> [  537.887750]  ? lock_acquire+0x138/0x2f0
> [  537.888094]  ? __pfx_register_lock_class+0x10/0x10
> [  537.888521]  wb_workfn+0x648/0xbb0
> [  537.888835]  ? __pfx_wb_workfn+0x10/0x10
> [  537.889192]  ? lock_acquire+0x128/0x2f0
> [  537.889539]  ? lock_acquire+0x138/0x2f0
> [  537.889890]  process_one_work+0x7ff/0x1710
> [  537.890272]  ? __pfx_process_one_work+0x10/0x10
> [  537.890685]  ? assign_work+0x16c/0x240
> [  537.891026]  worker_thread+0x6e8/0x12b0
> [  537.891381]  ? __pfx_worker_thread+0x10/0x10
> [  537.891768]  kthread+0x2ad/0x380
> [  537.892064]  ? __pfx_kthread+0x10/0x10
> [  537.892403]  ret_from_fork+0x2d/0x70
> [  537.892728]  ? __pfx_kthread+0x10/0x10
> [  537.893068]  ret_from_fork_asm+0x1a/0x30
> [  537.893434]  </TASK>


--
Best Regards,
Yan, Zi

--=_MailMate_261F1C50-ABC5-456C-A886-DC5CAE0BA0B4_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmYC9okPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhU4lAP/iTXmhjDfp7bNGdcCq/uCLtIePRN2Mv3a50q
48f7PKawVUTRvpYskLWgFCB3ODyu4i2Gj2vlQg+2B8dtFj7472CBaS1XWMZOIQl6
gHV+rSLkDJzRq/QJD5WHjX+AUpuiAuAyoabnAr+K6nBUAFhUlqhQDc4z6Uvr+OyI
B2iqVyseV76zrH+qC5KP1sYJt06CuWVe74AU+F8/5dCXh5QYpyiVlFvvFFJ0MeAe
6p+eZMw/BfPd2YJbNcB5W/MMh89GI8xBT/Yc/dFRFyi++GGFxHVyFIkmESwz6zSK
q86hBLDe6TXjKzJ6YORZ7HJH6BWycalWVErTqtfZAaxDgwOIXCXYSrZ3kHFipQVv
tJPf0ZkbSGO4C4hHuXLg1D13vuWQ0DGr3Yqm0WFvhlMiG2VNebqBs++gP1+0HWi4
ptHt006EOj4h5MY8t5c7JR41i1g0zsnjMMl8MFbr1Ypon8G/1SONwKJ4j6Q61xtG
WvOZgogGPrgVHGpPfZloIYNu7Bz8Aj3jAH3cd+GjRu6ZZMjNl5Fe7Xrk9erU+yi+
9psTs3b2b6Im3ny8rdBQ88np/cKiDvXq+7cPI77YrPjk+w4empQowW0CNweKkerx
dMfyn1sY+wsvwS6WuI4f3VHFAf3famw2ymsSL9/v7f+imiwVT9lnOm4JJy1LJ7pU
Fd1OXhJp
=JTyE
-----END PGP SIGNATURE-----

--=_MailMate_261F1C50-ABC5-456C-A886-DC5CAE0BA0B4_=--

