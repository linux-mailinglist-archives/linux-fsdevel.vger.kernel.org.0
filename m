Return-Path: <linux-fsdevel+bounces-15054-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B81A88666B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 06:50:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A56631C22758
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 05:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B786710953;
	Fri, 22 Mar 2024 05:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cwKopyn7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2074.outbound.protection.outlook.com [40.107.96.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10447FBF2
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Mar 2024 05:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711086621; cv=fail; b=RKELboJync9NmHqPJ/7d+UEPfrOsq8rYh8iLujjoTMx8Tapxx+6YpKOfJDPueKTuNTrhKtB8F2PwLeu9k/3x4vdlDzp5efXFU7ZeAaatWNU/whtAzml2VK6DBMYtayblTq3wHj7CYp39qUcW6DiemVksZ3y+Zl7OdBTlHQvbcpc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711086621; c=relaxed/simple;
	bh=rOwL35rLo8RizlzN8kWwPhH5uXwsY5lsLw8vcxUeecc=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=JJXgrR1H3ZZ550EKBRypEr1/CdOhJnXH/c3+okEFOU95r7HGweacp0A2p1VdVP+UN1EHd6zP3/11RRBhi5gAGGrIxUE3fLlFAg5CUb0mATL3qv1PDjOTVeQ7RnqrviPLQsszTyYn6yKJthKA/gqWL+V8OMGsbNREX4/c9JN52B8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cwKopyn7; arc=fail smtp.client-ip=40.107.96.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AXkIYP8ak3WEAQlUnHC8D+LPpw5HpAXT6q/Iy2n67//b1bKWu4FmuLWnjVTq9h2EVtr0A8CigcUJTWeTybjFA/fdZkKgksKe4gxhkAg1vbYWj6wPVgAtf6CoAfCowe9lYUiO/mLZrApSYwe3p21iiv8zj3aNP9LjGYpyLo765CjW5ePNKpe/nvw+An63me/RGv+3qD6mrqeKWA4AoJl03j2zH7uDwM52WzGwSNumgN3RxbPbLcOTMmAjVqvY2FBm0cj/HJqhhNDfXiqIUR3++j22ZEK8DTR5f0GiCHzD3P25o255bQVXJi1LkJhsfIemffgOIMNjTu4ohdTMCEbWhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=avh4eT/z/nq/Sayj53eklOz75lrBsGidodbTEAm7nQU=;
 b=WNju+X6wbVp6APnHF5EmlM0Jxp3dbiTQU897fCsAac8lOs7XEvaRZzNVmNt/wMhKyiNU+zz7yosUXQP7OwZ3fjLrv28FAl4TGwwcRTZNycqtbbPk7MXE0v231NihsOYLz6hHdcjE4AXNnDlSudWKWxAoTwR8ecuGVmOMpyY/YzBwzdEneg+FjhTTRvTsqGwCSdcK2S+Swyz0LySrjo3xaukriLAHOiGjeAtCzuRwXdX+bp4Th94gdLOo6K/yvn5AAAOJkoRGvJQZWCHuXML0WvUDPLAkJ3t9f1qEnkh9h/EBFlrHvDzSLJ7+ZlIu6yJ7CEV2swAdMKSqVghG1aEG6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=avh4eT/z/nq/Sayj53eklOz75lrBsGidodbTEAm7nQU=;
 b=cwKopyn7okWyQpY7PLVEW1E7vUz+LQmNmuGV+DsdgvobMWlRFBJn5s8/a9Q71vKRn9Q70dJZ12PVo8kXZ9+uxVNTPCu9r+h1sFo4ztfjLzA8RoxElf404aHY/fCCYpOtoAJLhyVzj8P/BhmwYyyx/YlSiMBCi/KvJgKCuTl6laNsd8/LyF9Y1cHufsJHOS8cwSPzA+EKmn+EPbeB8zP/jo573TMRwjkVxAw6IXL9zy5vZpcVYC5mLthm5M4ea/RVrd3GA67YUvlgXE4mfGWxgDCRcs5r6FN95kLcqyb1XGx2spTfEqQ+ojN1ytsk9db4jha5UhcauIaoihu2veiRKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 PH0PR12MB7010.namprd12.prod.outlook.com (2603:10b6:510:21c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.24; Fri, 22 Mar
 2024 05:50:15 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::c5de:1187:4532:de80]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::c5de:1187:4532:de80%7]) with mapi id 15.20.7409.023; Fri, 22 Mar 2024
 05:50:15 +0000
References: <87ttlhmj9p.fsf@nvdebian.thelocal>
 <65f148866bc56_a9b42947@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <87y1ad776c.fsf@nvdebian.thelocal> <878r2c6t99.fsf@nvdebian.thelocal>
 <65fbcdaf2042f_aa222948c@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <874jcz6ryu.fsf@nvdebian.thelocal> <Zfz4dT+YWpx5OYxM@dread.disaster.area>
User-agent: mu4e 1.10.8; emacs 29.1
From: Alistair Popple <apopple@nvidia.com>
To: Dave Chinner <david@fromorbit.com>
Cc: Dan Williams <dan.j.williams@intel.com>, linux-mm@kvack.org,
 jhubbard@nvidia.com, rcampbell@nvidia.com, willy@infradead.org,
 jgg@nvidia.com, linux-fsdevel@vger.kernel.org, jack@suse.cz,
 djwong@kernel.org, hch@lst.de, david@redhat.com, ruansy.fnst@fujitsu.com
Subject: Re: ZONE_DEVICE refcounting
Date: Fri, 22 Mar 2024 16:34:33 +1100
In-reply-to: <Zfz4dT+YWpx5OYxM@dread.disaster.area>
Message-ID: <87v85e6cj2.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SY5PR01CA0067.ausprd01.prod.outlook.com
 (2603:10c6:10:1f4::14) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|PH0PR12MB7010:EE_
X-MS-Office365-Filtering-Correlation-Id: 226ac399-1189-4f12-8761-08dc4a33f231
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	EpnL++CHVwTBwZHXwhwka4jmYhi4tOgEgixw0TkyXSfNqg7WSEKgXsyhB8xz4GGfG5npwZ8v1tbmTQAj/Q+fOzIxkeOdtnLrwKojoPndCt8s9KHY10c+F07RGYa73ow9W7zJpKZGTF1akoCHCOQYZ3ov8WnMNmkNy9MSNWMUGLrLbK4uMS6cE2qcWh/OZIHD4tVWsdHFErC45RR56rV9DZzZAuI5vkZeANmxtCe+MjzhJxbFovJdHTs31tDGfK3Bbf2N//h5Ga9u3K9DIEMItmhGc0UbbojGBOjXilVvi4lqCiLHl3tIKrHEOpmT09d768Kfj39NIzwhW5t0io664M7UOfw+yy7jwl2IItt+K706dOD2lZ98iMJvB0KPxjVyoWmoR5rkyDmG98CYOl7YsXOdl95+RVTI7NhQePd9yVz01Sy2IV9C2+DHIafISxmRtd4NbttqI/OzZNLQbWNlAqBGMsm28M+uX1Pzcwnm7X6buLE7FNm9rJXHQxp0aMnRifeaQ5cRai7XzxX8QHssetAGrfQhbjb6mZCLRBqPaoqS/fNzpJhFenRd+Sw1yP8GqkYHbogrKeEv7QZp83qNAu7F6wBTfIYbeWNJAZqh0YZkygmBW8UVd5crc5XG61Ll/0fnuUekszfgq3fJJoxsZicvkL1UCov5fT3YSsae8Zo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gwEnKmc0YqOyyGX2khaoh+0M51/Eb6tQGKM7uH8fCu4QkkWmI7o512ALsFWx?=
 =?us-ascii?Q?lnCgpDJw4dn5mohrvjkzbWW7uACF7oYwG/bf55a8oOkO93qsw8cNXInN0oaR?=
 =?us-ascii?Q?xi4BRQu6/DXl1xJ0eJuB4N3RFL2oMOTN5wABXvB1l5avyILnIeqQcAY/Re/K?=
 =?us-ascii?Q?R+iVO2gSE9+TGAjNUomMnHEoAIMmxbi0y/QPiCeDJz97OWvrKhxVga/HrXtX?=
 =?us-ascii?Q?HdTqFHDeg7WgmPx9fk2Jd+HMEcJuER6aYIjA93PN4w319ryhVytr53RrefOA?=
 =?us-ascii?Q?9gxCCVcLn59qhk9TnytjseaXkzaq/L/ekI/g+JKhwn71/2d7t/NCbPGa2NbY?=
 =?us-ascii?Q?cSt4E7Ac6cBznBd22s5d97B3tdebXKS1lwqJPEj4zk7P/JfmAh56VDiTsWb3?=
 =?us-ascii?Q?njLGNGEOd3nnZ4rBD2h2LhD0DAcEWYyVuWLzyuJv63ngI3McahXx1LDkUqNI?=
 =?us-ascii?Q?VPJ12VQ+UYD6/FGMJ8CkZFtzh9OeKDeuVfSm1ljBZzJCqPi5PdFXr1v8VN+c?=
 =?us-ascii?Q?YsyClFzX6Usd8sve6RaLWZOfCbReE7zvykKeWwPJJYL/CF8BAq1EBE6WvcGh?=
 =?us-ascii?Q?k9bNbSPG9D4vqVJ+RV/oZlxJ9kGZFBXHOiLq1QMKcvHjU7FTkZP837lTAPp0?=
 =?us-ascii?Q?PcnnelFoxVd/41x7Njc1hv8Oo8n7jIZYxoEaUym6/xOR9NR8Sy1JNwSovjp0?=
 =?us-ascii?Q?36xPPxBMYkqzH8uEi706fqte88YL0Oqgtb464ocfj2Rk3GMZCOZgIXVA4bu4?=
 =?us-ascii?Q?RuZAy3ljRcHS4yORNP5EU+LBryaMKJ0rHo67SDcpL24vehZIk4uIfO0fDGdS?=
 =?us-ascii?Q?XzurIoKQHijjEf4ASMnjyl0yRKFw5KSBATKNvICmyh3xF2PK4xO4jvwXkegP?=
 =?us-ascii?Q?1Gmf+gjMOOiyo907Mtv0sRyOQVLSRttjbUWN53WwAJIGrhoFtaiFlziN6oYn?=
 =?us-ascii?Q?g9M4CQvb2z3UQ2EtXlW9pad/mZ94vBg4Un2+nR+92ZscbD8vJ6s3/mzB2Gp9?=
 =?us-ascii?Q?5vs0yFXXmCL6WRGnTor//2Oan6Fd3tcju2f8qYjjZ+qswRuRM8qzYcw8gBB7?=
 =?us-ascii?Q?vz+lABQ6e8/HAFqFM+XnXO5kqgfk7Qnoz0ZcQZlF9YWKwCl7SGwnhIQizaqR?=
 =?us-ascii?Q?rBM1pN4KMgcZrYdQxDLZVTjR4kN1FpHWbJgYTJTlUJtqKJVf4MTwSaftFfNj?=
 =?us-ascii?Q?wvkV/kiY7vecyUMenizOfCk2updkU+IujCe4l5oZ+7xg9o7wtLfzgEpZYRgV?=
 =?us-ascii?Q?6AzycT0E9rdjlVYLBKzEnSgrzx2ucnLegdhoKFokRF6l6Y2oFEpPzOpSNnUR?=
 =?us-ascii?Q?6YV/tAzOtm0gkpo5GCJfmfWlk/1MRtXYaCAvqZ/h6/QY6WHGcIQJIqrfdwwz?=
 =?us-ascii?Q?SP6ZTH2DoDPeA7nRaZiCxZFTd1r0E19boCMMy/pOFIfpfl9DGLPLWS598OfJ?=
 =?us-ascii?Q?YTi+Efb5Mh1O/exIhI/j1Wm27zxsppkKtHliqLJSxiLPbT4usA2e25yjYV5P?=
 =?us-ascii?Q?/2hifHsJhARZ5kTSkHdMUBf+85KRHgAcaYWMoquTL1Lo7x8T5dS5YpcXnbgW?=
 =?us-ascii?Q?p/ELM6aMPOjX1RhMW/Cw+gNcTU6SXrkRwE8kR+N4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 226ac399-1189-4f12-8761-08dc4a33f231
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2024 05:50:14.9858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: euQFXVGilMlVee+zxfdwkB0Nq/E+tf26uuhvJrfUctSqPiw2bsJ5JwkwQBEykWqvnzU7cJ5wPJsxxL23YluMgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7010


Dave Chinner <david@fromorbit.com> writes:

> On Fri, Mar 22, 2024 at 11:01:25AM +1100, Alistair Popple wrote:
>> 
>> Dan Williams <dan.j.williams@intel.com> writes:
>> 
>> > Alistair Popple wrote:
>> >> 
>> >> Alistair Popple <apopple@nvidia.com> writes:
>> >> 
>> >> > Dan Williams <dan.j.williams@intel.com> writes:
>> >> >
>> >> >> Alistair Popple wrote:
>> >> >
>> >> > I also noticed folio_anon() is not safe to call on a FS DAX page due to
>> >> > sharing PAGE_MAPPING_DAX_SHARED.
>> >> 
>> >> Also it feels like I could be missing something here. AFAICT the
>> >> page->mapping and page->index fields can't actually be used outside of
>> >> fs/dax because they are overloaded for the shared case. Therefore
>> >> setting/clearing them could be skipped and the only reason for doing so
>> >> is so dax_associate_entry()/dax_disassociate_entry() can generate
>> >> warnings which should never occur anyway. So all that code is
>> >> functionally unnecessary.
>> >
>> > What do you mean outside of fs/dax, do you literally mean outside of
>> > fs/dax.c, or the devdax case (i.e. dax without fs-entanglements)?
>> 
>> Only the cases fs dax pages might need it. ie. Not devdax which I
>> haven't looked at closely yet.
>> 
>> > Memory
>> > failure needs ->mapping and ->index to rmap dax pages. See
>> > mm/memory-failure.c::__add_to_kill() and
>> > mm/memory-failure.c::__add_to_kill_fsdax() where that latter one is for
>> > cases where the fs needs has signed up to react to dax page failure.
>> 
>> How does that work for reflink/shared pages which overwrite
>> page->mapping and page->index?
>
> Via reverse mapping in the *filesystem*, not the mm rmap stuff.
>
> pmem_pagemap_memory_failure()
>   dax_holder_notify_failure()
>     .notify_failure()
>       xfs_dax_notify_failure()
>         xfs_dax_notify_ddev_failure()
> 	  xfs_rmap_query_range(xfs_dax_failure_fn)
> 	     xfs_dax_failure_fn(rmap record)
> 	       <grabs inode from cache>
> 	       <converts range to file offset>
> 	       mf_dax_kill_procs(inode->mapping, pgoff)
> 	         collect_procs_fsdax(mapping, page)
> 		   add_to_kill_fsdax(task)
> 		     __add_to_kill(task)
> 		 unmap_and_kill_tasks()
>
> Remember: in FSDAX, the pages are the storage media physically owned
> by the filesystem, not the mm subsystem. Hence answering questions
> like "who owns this page" can only be answered correctly by asking
> the filesystem.

Thanks Dave for writing that up, it really helped solidify my
understanding of how this is all supposed to work.

> We shortcut that for pages that only have one owner - we just store
> the owner information in the page as a {mapping, offset} tuple. But
> when we have multiple owners, the only way to find all the {mapping,
> offset} tuples is to ask the filesystem to find all the owners of
> that page.
>
> Hence the special case values for page->mapping/page->index for
> pages over shared filesystem extents. These shared extents are
> communicated to the fsdax layer via the IOMAP_F_SHARED flag
> in the iomaps returned by the filesystem. This flag is the trigger
> for the special mapping share count behaviour to be used. e.g. see
> dax_insert_entry(iomap_iter) -> dax_associate_entry(shared) ->
> dax_page_share_get()....
>
>> Eg. in __add_to_kill() if *p is a shared fs
>> dax page then p->mapping == PAGE_MAPPING_DAX_SHARED and
>> page_address_in_vma(vma, p) will probably crash.
>
> As per above, we don't get the mapping from the page in those cases.

Yep, that all makes sense and I see where I was getting confsued. It was
because in __add_to_kill() we do actually use page->mapping when
page_address_in_vma(vma, p) is called. And because
folio_test_anon(page_folio(p)) is also true for shared FS DAX pages
(p->mapping == PAGE_MAPPING_DAX_SHARED/PAGE_MAPPING_DAX_SHARED) I
thought things would go bad there.

However after re-reading the page_address_in_vma() implementation I
noticed that isn't the case, because folio_anon_vma(page_folio(p)) will
still return NULL which was the detail I had missed.

So to go back to my original point it seems page->mapping and
page->index is largely unused on fs dax pages, even for memory
failure. Because for memory failure the mapping and fsdax_pgoff comes
from the filesystem not the page.

> If you haven't got access to the page though a filesystem method and
> guaranteed that truncate() can't free it from under you, then you're
> probably doing the wrong thing with fsdax...
>
> -Dave.


