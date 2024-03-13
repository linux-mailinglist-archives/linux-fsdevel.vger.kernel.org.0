Return-Path: <linux-fsdevel+bounces-14262-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CABEC87A2F9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 07:32:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E48A283021
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 06:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22751426C;
	Wed, 13 Mar 2024 06:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C0pc57MX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E48210A24
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Mar 2024 06:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710311572; cv=fail; b=axYZMDxxBivLJdXZNRchXP+JJOy3HLeQ5zxwRBsY8avmzifVPMdQDT2hgOhGc95mvJ6j7L46qLjPBZ02U7P5Xh+uNLLh5jLJ3ZxeVpait1+X+6kGi3mEhU2V3A1Gn9mCC3Ds1azHSjyE3OJJfz/DCkpXeAK8GDMpELOf4msWwTM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710311572; c=relaxed/simple;
	bh=n1FaCQ3Ym4YX6R4q6yADKdxeV5ria5yHWlGKVQGcKUw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bWHWexWeDnx9/TCz5bm1rOI8y1JW2/J4bLEwPpT035VDxraUhUJqHPtNvBFmgNg9EVP1+A64I8GvODIVxkNlZrJzagcupeiH6VcynTkFboONtJP5GmP1WDn/ums7UKqvV4vFJe6irByTEfGoTKs/kpXDIWcZcmGsw935PdwVxNg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C0pc57MX; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710311570; x=1741847570;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=n1FaCQ3Ym4YX6R4q6yADKdxeV5ria5yHWlGKVQGcKUw=;
  b=C0pc57MXia4IQVrGOkDcc6g0e7Tu6e4yk6NC9oO3cCOi/qyKqI9C3toi
   ZrEa58TEzYktY64VeEy53pNDRAx83pGxCPSIe0eaIC9FBmXao81j3ZEQE
   le6NVEl1Ni/Ul9Ty2VYCjEC9sxwP92NJSErb3E3iJl7k7WvUvaCIBHtFs
   UwmdF/oAa6EOWrMO4/ohwCcJ8H0fvmVCr9d4EVC9rffv9HJsAMpkyf7Kv
   S9vz68fKL2AWS81mdYlBAMXyiHegwqJlTmCZGMGLa6sBVtmKRhMes49NE
   if93Z7PfpBTCsdKTZsCg0BNraCQ6UTq4MvccWms7W3OxM0P2A2WLW/tL2
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="22509636"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="22509636"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 23:32:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="11899008"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Mar 2024 23:32:49 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Mar 2024 23:32:48 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 12 Mar 2024 23:32:48 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 12 Mar 2024 23:32:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PAbr8Pn3rTAsysWpjydURXC/yX0chXg7Kw1IrHVvMVPikXyz04sErwTr0dHmjJ+lOMqvR9Hl8UUd/WtsbUgZgv2QArBqoZ0jqQfz8KvIXz5N9IF4xmIpJPDP4X6nFQA2cdbTbTvxWqHHLVA7TTsEGaJHJ7CsdBOTnkHqhyN/K8NzKV6R39UWhx7ZkimQqdShzJqlr8tgX+Hn6VYWEgPRhbJh0FrbA8XiVaxIRYq7kWhvQQLyM7pDFXjGl0YR9f2+FeLpRZzonBYRu3Jw1hTAtQE6PZ6heAZxfHkiThf/FgMaQu5Mjp4bSploRdGJnP9iHiAMndayFvPo5+vfqP4d9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gt8BOjG248V8hFz2gUx0ZnI4lhL7j/GZkVntlnF3XT4=;
 b=mZGbdF7hUMV2/IQOTqUz4lwelBB5ChlsQ1mARhpOcir6D1gHnUZyBu9w+mCYEab+fNVvKZXek+n5ijHKHPyd6cxtlFLLaa2uhWjfIHd6vyuNz8ynUGZg7j33UZsS3+tYW3UV3CqvIqWDz39REE0LnjRwTI/MnqM4CwuyRr2UMCtfhiQ813KsICLVA1O+IXDxzpg6g9acpF05kZZy9K1h6SM2Pghd7kjIO65kKph+GYVdESgv7F5l8f72BCF1ZMpP5qOedHfn2Yga0sI77WzIdkNDK4Iwzx7hF03NYsqYlO75P3xLz+atDmPH0F57WFtclamblL8S7iGLw080knwJHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA1PR11MB8255.namprd11.prod.outlook.com (2603:10b6:806:252::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.19; Wed, 13 Mar
 2024 06:32:41 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7386.015; Wed, 13 Mar 2024
 06:32:41 +0000
Date: Tue, 12 Mar 2024 23:32:38 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Alistair Popple <apopple@nvidia.com>, <linux-mm@kvack.org>
CC: <jhubbard@nvidia.com>, <rcampbell@nvidia.com>, <willy@infradead.org>,
	<jgg@nvidia.com>, <dan.j.williams@intel.com>, <david@fromorbit.com>,
	<linux-fsdevel@vger.kernel.org>, <jack@suse.cz>, <djwong@kernel.org>,
	<hch@lst.de>, <david@redhat.com>
Subject: Re: ZONE_DEVICE refcounting
Message-ID: <65f148866bc56_a9b42947@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <87ttlhmj9p.fsf@nvdebian.thelocal>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87ttlhmj9p.fsf@nvdebian.thelocal>
X-ClientProxiedBy: MW4PR04CA0381.namprd04.prod.outlook.com
 (2603:10b6:303:81::26) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA1PR11MB8255:EE_
X-MS-Office365-Filtering-Correlation-Id: abd51317-eeac-424a-9bfa-08dc43276279
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KJStwdh4p6CZxDJK7thRObh4Y/5qY1LjKHu/3vNEzHaxwbqLqrs8ECMYTCG9OBSsepEKaQF7cBhHqk8nt0ttCC8j80c+vQ7E6BXsby1c9C7CIJMZXr+puXpjfhFhjxZr0M2fvrZqPM3nMN5I8/jJ5J7zjpE+ZAx/i3UbiOnzHhAzLRdz3Av0eP/AK3qt3fssY57wYiVhsljpXcsiO+CCmkQaVNE33RMElwiQrVWoBr6NosneMG+/e7voZd48dc7hed+xHvUo8ckMa75jERhXuYHOn7pOtqxsM67Q9o3ueBylFl+VbbXc+Ja+dQGN9BvjXcbXXE/NpaqG/hQplARDNi//mvt+Yq8xqlXEGyLckfOb0duR+Jsb4eVH/jtxY3/34BPX+tOj4z75aCc0ZHTAX3yM//bASNZs+w1hEht/Jxd+NtMk8eS29X+88MY9QM4cqLTaaPSZCbRC6dkhZK5r35V4JH1AOeg3dsYN4/d7Hivq0L8RSnOa+Sox3JJAMMSvJf8ICjh1aJZTMlq09dZ2wdsr02v0CcQyVzPsax/+/B/KQ1MGrLSqXx5kxD5pkNyZH5gDb13LEBVlNLa+TSPswnH+VW8fqPTAuPmssRZKI1GOxhd6Q4L4i95TIjN55DGBr7UDv9pSO+jZMmmH4uWwzkM0C/Wr5CyNvD6pVbTaWCY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?u+dAMc74omN2yZmHGJRTEgQYnjP0rWFXS1pyeICfVnN/GS9vJOBJVxmsT4lE?=
 =?us-ascii?Q?bv/P05RpQJ9y2uc8B8l7+d+Wgw5kT/MzIw22pf6YGecB45LrvJe+iXK99L7Q?=
 =?us-ascii?Q?2fQcnYw0rC54Q3oxa0x+ws9JoSquVfZvxYCwrEvM2HtQitJ0u80+5QaijaaE?=
 =?us-ascii?Q?cwOs++MY0sOu8xmqILP4ZpuLreWHjqll33/20KCzfXkGBDLrHZlC/oVSqy3x?=
 =?us-ascii?Q?JB8bPin01mCvYcP/Q51pYYPs7OQi0qZxpdXiVJ0BQma50AYuNSXh86+QDU/h?=
 =?us-ascii?Q?tNgF1ORvo4oc3IUy6y+t12UbWnfrYq0bfNNWZgqAxxbms4/SkBP5lN90prL1?=
 =?us-ascii?Q?9mIQUO+aYwzlySlR8VmZ7L2/1MaVMBGu6ZGb1nMJT9nCOyVtDyA15lr6h8Id?=
 =?us-ascii?Q?6+mSOBKGnQ/6UlF7Z+b/SSUCjmCBfk6xCYfnuckhgSH3SxcKgYEEHYuUUeV6?=
 =?us-ascii?Q?efNRGRU8OVqBOyeUIfEdn2Fnidzq3eQ0DvW4vAKuBKDXBHK+TVQwCWyZFGSO?=
 =?us-ascii?Q?2HNU6xfXrb7qWYwiABh3HEjLgs9oVv9w/UMixv6zKtky8dUet9HnBEXu43sZ?=
 =?us-ascii?Q?ZefVO+TbyUVAF0Y51FEoaYzRdUfz020rSNTz/l3HDho5MFo+Elg1hLAyUYKN?=
 =?us-ascii?Q?1/QB5WFSv0BbokW5EW30GpZIxBfmQ8AxfRh/+2s+ik8/17qzBc59UnhH2Okn?=
 =?us-ascii?Q?o9PoEKpkBGKS9KeLLZbADYCsl+UxMVMj/HbJji6WSTavB9inA71dRFqPtusw?=
 =?us-ascii?Q?HPT/suJEVLU1swZziPZx0EhAeA0Kek9pXxxqTE2YOvEUcFAL0xRtZEusY3y+?=
 =?us-ascii?Q?eEbzu1CgJ3+le3zWeXKuox/g5OaB70J/iK1rlZB7Bk8WV5nRgQo0WwL/1N1i?=
 =?us-ascii?Q?pw7cLKTkIRgVJycdcJz7oJZDZSQyb3ZbE6xGRR8qJYl49WfR5hbKfYcGd4ul?=
 =?us-ascii?Q?3dJ62WfSGERdC5iCOMJFaPt04dHC15QdO6qAg/mU6a9MnYMdu9+1r8+KDK89?=
 =?us-ascii?Q?5sgweCZeRoKj3CLoNxrlZ8+HhoeTk4d1qNnVbek7y56QYROPDzuWIfxfX1uI?=
 =?us-ascii?Q?be9hpoa26xHzVkmtUbnkqrnIgaydjMw+nySZkHMYgiNcbPwT4bzGcifVGZQx?=
 =?us-ascii?Q?dDBB8Y6SjvokPl3gLeLZc4XNi11OOZhTvPuvOZCEef3OgG7eccWAGuKNff5y?=
 =?us-ascii?Q?rUWCHlTqLKCYkhZxLlnNp7RN7d2eDdXUausszwgwlUXpeZOw/y918/45PCKO?=
 =?us-ascii?Q?bKYyuNmn1ZTt5/yXTTR/5gXw17wPqK3YHLVO8ji4P15q4c3Ya8JLgYzSmrgq?=
 =?us-ascii?Q?B5qBSY2EtgFbXZefbUg+tLWSkOZtLgU9VawAlbBB4lIFst6scpXP06t+pxpk?=
 =?us-ascii?Q?ccS6JoFwHN2mIY/KuY9kYGuWZhC50PEAl+FAG5HCSS5BA7N7Bm0sAF+QFDqX?=
 =?us-ascii?Q?5Gc+vTLJ13KEI1s7ABGR/V35KNeAa7kiH0dYDxogaNllNTHoGjeagZas7lYD?=
 =?us-ascii?Q?jXxstZLcL6UwbM2UkXcJKO/OmE+l1se01Dq8Fu51pue5Kuw0xxzFRJX0oh0y?=
 =?us-ascii?Q?oaHUjFy2LMemzvAkqLi1HPm5njlacsGf9QvEZtsIKLy7mXtLLeTpSehlgrfH?=
 =?us-ascii?Q?mQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: abd51317-eeac-424a-9bfa-08dc43276279
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 06:32:41.6026
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oK5GemeKx7oueiP2As6CbLdgLrDvTnn2Wq8FpYB7t6oi7k//s8wQ3GG0FvD74sM9c5yR6/xZvzOMcUFkfWtfQJ5VbR1LJB/DGsgkAj3tcsA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8255
X-OriginatorOrg: intel.com

Alistair Popple wrote:
> Hi,
> 
> I have been looking at fixing up ZONE_DEVICE refcounting again. Specifically I
> have been looking  at fixing the 1-based refcounts that are currently used for
> FS DAX pages (and p2pdma pages, but that's trival).
> 
> This started with the simple idea of "just subtract one from the
> refcounts everywhere and that will fix the off by one". Unfortunately
> it's not that simple. For starters doing a simple conversion like that
> requires allowing pages to be mapped with zero refcounts. That seems
> wrong. It also leads to problems detecting idle IO vs. page map pages.
> 
> So instead I'm thinking of doing something along the lines of the following:
> 
> 1. Refcount FS DAX pages normally. Ie. map them with vm_insert_page() and
>    increment the refcount inline with mapcount and decrement it when pages are
>    unmapped.

It has been a while but the sticking point last time was how to plumb
the "allocation" mechanism that elevated the page from 0 to 1. However,
that seems solvable.

> 2. As per normal pages the pages are considered free when the refcount drops
>    to zero.

That is the dream, yes.

> 3. Because these are treated as normal pages for refcounting we no longer map
>    them as pte_devmap() (possibly freeing up a PTE bit).

Yeah, pte_devmap() dies once mapcount behaves normally.

> 4. PMD sized FS DAX pages get treated the same as normal compound pages.

Here potentially be dragons. There are pud_devmap() checks in places
where mm code needs to be careful not to treat a dax page as a typical
transhuge page that can be split.

> 5. This means we need to allow compound ZONE DEVICE pages. Tail pages share
>    the page->pgmap field with page->compound_head, but this isn't a problem
>    because the LSB of page->pgmap is free and we can still get pgmap from
>    compound_head(page)->pgmap.

Sounds plausible.

> 6. When FS DAX pages are freed they notify filesystem drivers. This can be done
>    from the pgmap->ops->page_free() callback.

Yes necessary for DAX-GUP iteractions.

> 7. We could probably get rid of the pgmap refcounting because we can just scan
>    pages and look for any pages with non-zero references and wait for them to be
>    freed whilst ensuring no new mappings can be created (some drivers do a
>    similar thing for private pages today). This might be a follow-up change.

This sounds reasonable.

> I have made good progress implementing the above, and am reasonably confident I
> can make it work (I have some tests that exercise these code paths working).

Wow, that's great! Really appreciate and will be paying you back with
review cycles.

> However my knowledge of the filesystem layer is a bit thin, so before going too
> much further down this path I was hoping to get some feedback on the overall
> direction to see if there are any corner cases or other potential problems I
> have missed that may prevent the above being practical.

If you want to send me draft patches for that on or offlist feel free.

> If not I will clean my series up and post it as an RFC. Thanks.

Thanks, Alistair!

