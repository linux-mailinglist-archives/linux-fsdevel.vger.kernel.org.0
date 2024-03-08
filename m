Return-Path: <linux-fsdevel+bounces-14001-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3334F876588
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Mar 2024 14:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B40391F21D6C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Mar 2024 13:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB3638DCD;
	Fri,  8 Mar 2024 13:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aET731pv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2048.outbound.protection.outlook.com [40.107.212.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0A163B8
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Mar 2024 13:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709905465; cv=fail; b=PfyDKheJe/ChIB9a90A3wToY+61zRlreDNHk8Ij15WQRVYz4aG+8si57EFHYGxwOS/dmgWrTeMnTfE1RUJT9SkKd2WHBApPXdx9BQaOEMd9oXRMY311fzAeSE+03M9NS/M/UpFFwPBB/phEPxA7btHP8IDu/hnYQxZmnBtu77ig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709905465; c=relaxed/simple;
	bh=p6tL9/V/sg4wCvqQlKd6NnA1j5Y91TFrofcJQm9A/0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Jyu6Fh0EiG370uvKhjJzHiVyxlK4kfJfnHmPZTUggVUXRokBWi0tzdeUQZ0nyExhT2E9r+hyppec/3CdwPk+GEaBVEL7F7tcu8dKLNm3u5jIj7HjBe21wowYf9oEI6viBkrcKZIqIhQCNX4r911LXueommOcu6qappd6dbSNhr0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aET731pv; arc=fail smtp.client-ip=40.107.212.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TZFOlA1qDrWFApo6eDNFp8QrVI3e1TGmpMCccEcd4V3F1TLyXZL6ZCGDJ3X0N69yDD4NhPuN7ilmpgx3Qkg2Bi/om08O1qOrhvb3F7XNy4GxL9y1gfPhsd0AHPblEaTOSIlKphwQSq1xaU3khEooqYDEJB16jzbAftIaE4Vu/ZG9A6c8NV3jfG+tbe4mOddwRAaOFbFk+ibyC8XKVNGqErXFtK7i+/6Q1DkRnehc626kZf05wMnHHAYTiykhXz9dGNbHpnWiir9qv/CvnuwFKNIu//HJvGg6LeqgN4KWzgQ2a5qKILf2DI3TuKBeGvQx+qNy1OPkOqbosTdyATGx9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OpylKlH8q9clcObwOt+tE2VdTFrv/sOTJ70XLUxAV5A=;
 b=c5WHRPnK3rXspxp84/ibqYxaLkiDIE45kZfWJ+IQJpKsBcX5m99VmaV1XaC6tAi+ApYAIB51bI+1LXAZ/bqIg2XiWvC9ZF9wXV4IOLFihEE3dWsRjbFR95XHnlKkWHuVrmtp97bo8ymNe/fvU37CLIFgb6dnxZMhbB2/DKkM6j2nbrHqBDR/0y8OvK2zLXdslwHi45KL/c2Q08azSppkXtTHzCNM56qGVVZ2sjDbdfLCGptyXpdfdumcmAdYiLZfYFzvdgsWhqGpGKczdg9obA2YtV1mCZYAwngkumkaHq4a1H4tib33lkWpvc0tyb5jlK2obssBqfGKhXu+hyNR/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OpylKlH8q9clcObwOt+tE2VdTFrv/sOTJ70XLUxAV5A=;
 b=aET731pvklLkbca5E54sW8Y0c5jfuM6/fj8galJrWX3uBaZoyB6GoyJtGyyW5BhLcWK3H3HLk9pOwwI2aDItjjb3xIRc9X25gJGxWmNG4f39CJb+o+eXM0SJ18730dFzwaUnURmGBNG4S+YuDGlh+PSDRt/K8bi56LfAOj0/p2ySogMC67ETowxOOa0w9RqzRxTtrwXmIxrYiEn0KJWR6gihPDcz4XQyBl3MUJbJVW1EkfELvVjjKk1PYp+Dnt1O032dKYJY902+4uDZ3nvxBp0PnuysrUGH7OJEJy9seRawIQ6bJ27NKAkpy5Kj2FuTvnSnqWi50ulMfJJHybgXRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by DM6PR12MB4282.namprd12.prod.outlook.com (2603:10b6:5:223::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27; Fri, 8 Mar
 2024 13:44:20 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222%5]) with mapi id 15.20.7362.019; Fri, 8 Mar 2024
 13:44:20 +0000
Date: Fri, 8 Mar 2024 09:44:18 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Alistair Popple <apopple@nvidia.com>
Cc: linux-mm@kvack.org, jhubbard@nvidia.com, rcampbell@nvidia.com,
	willy@infradead.org, dan.j.williams@intel.com, david@fromorbit.com,
	linux-fsdevel@vger.kernel.org, jack@suse.cz, djwong@kernel.org,
	hch@lst.de, david@redhat.com
Subject: Re: ZONE_DEVICE refcounting
Message-ID: <20240308134418.GH9179@nvidia.com>
References: <87ttlhmj9p.fsf@nvdebian.thelocal>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ttlhmj9p.fsf@nvdebian.thelocal>
X-ClientProxiedBy: SA0PR12CA0015.namprd12.prod.outlook.com
 (2603:10b6:806:6f::20) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|DM6PR12MB4282:EE_
X-MS-Office365-Filtering-Correlation-Id: 08f9dc60-5371-4b1b-76c5-08dc3f75db44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MMYlES+3BkhHnUmwRF8aO7lG1/kdpqD9qfkeDGMx2yrZrNXPBK2xk4KyhDWdtpcKDB1XSL3Tpd9yjXxrA+vmjoJcrTTCAa9ZbUkfLyVA2xDPsP+YtAb3fnJtNkdUMSqYyjp1XQwaEDR8UCKyta+aJ1eVl/CRBD0LVRtKwgvaCa87jNlwd+luHApa+eG6WK3IkS17evLLXiZA0JCUrMdaQTGCrZqVKIMg65iXAv3uwWzlD40PGkNNZB48LGwoNW6KqG+cYDP1/b+TT5J4cGI4aUhetue9NpucIcOa8wDhdZ2sFhqa+sOCYq9keZBR7r4JeDgViX4xSva2MJWLuJf5yyDqR657LSopC8HdNW7vHnkHOIYqmYqz68+KXELeSzctN/ZBU+p1Mgyt57kof7kYULyCuffTC7CBSM660JitJo4pZBddwun+6Noy9k3CTf5kUfFDd805gukpUWSMRJbakei5i3T6nJhOHLdW8gvjDBmd1n4urnAPXAvvxk9Uxf60THT+/HXvRzBVdJrI5v+jkArYboPZSHMCLzFdrg5Zva6NEzEoShkkoyiGWJkX+qBxhVuVCH9xDoOf5rHJ15fM0fGbno5MqzYEywQCpruFPzve+nK9WddseXwb1N3/Y7UnadHdJjAbzTShZo8pA8ffjuUGkQgOrJ8N/0voETd4YMc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oKcc7ukosBW3ZpH/zIb6cfMWU513eqUIGSaiMg5tH4GQDemlRPtUrMepJQSK?=
 =?us-ascii?Q?Q8Q+6XJNOE2EaTW+dn/lTUlhOWiNbubwkKHbg3CDKuaiGSTUOLD3vISFyT9i?=
 =?us-ascii?Q?kNOmnDnAqfilmdU1qc+inOQtWuVoqNq6Yy4+hzMbSFRYWZqdGsOykKJM+mCC?=
 =?us-ascii?Q?aBoX54W3h5xXyU5bOOt2TvL8JICmoklaXcuaVJs7gWDBkU0L1uJ+/dRNd7jS?=
 =?us-ascii?Q?FqNN6u5ksudnsrA7j485XDFrKjzh7LEBFmLKX3xW2ypKAJQbc8MOTNMzp2i3?=
 =?us-ascii?Q?6RNi6t5CMQfp0pY25ApiblKOIlqE1jY+EsCF9vNEc6ybutMRdSNarKnK2eMv?=
 =?us-ascii?Q?8OYdMapVdv8QSn+P3zho2WV3sr5vuUnOuE5j9JfLxWvPwbIIy19BLgv0SPvz?=
 =?us-ascii?Q?cL4Y0OMaWU5SU3qtlv053A4yqicKag47O/uCJ9JaU7AQvo5J4x2nJYLwgxkW?=
 =?us-ascii?Q?VS7IuiUvAAhsYq/BNwMPt+kxpeo6yJonO7LL9uDimWq84QeBDBaoCEIUHNHz?=
 =?us-ascii?Q?bZHcFSiAsynxZvb9W6F0O3Sm5j/rrzcdsgpGxksvEmP/m6b4+WQLm5iekbFw?=
 =?us-ascii?Q?LRrJNT+jKAHtaKLQxz0kX1NLWzp5Im9eCvMtR1+0x9zy7sVjU3D4jS3AFzs5?=
 =?us-ascii?Q?FwIG0AenZfc+fI/WkkZUIhvGcbduL6NBXiXsTklo0UgheKqyNTa2CtJdbGam?=
 =?us-ascii?Q?OweMcWWQfAp+bA7TPQ9rfch1W5lB7gqcJptAL7XHI2uLs4sYiarpGaHOt3v4?=
 =?us-ascii?Q?d0s4UAoIo9vHWqB/w64zV48wkgSUhA6Su36CczELGCdG1vMoQbY+HzNBBQhW?=
 =?us-ascii?Q?3eBHsxDi+gx63TZSAbYRtU9xdOwu4UgQf+ds9XvYhKUmet7o5SPFpDYM3+QU?=
 =?us-ascii?Q?qF/lqNGAnfoTN/ChyMLX0iJ15s0YmfghChhsngIaVHZwonetVH6ASwlW51+l?=
 =?us-ascii?Q?k2nIMbN6HqK24lJHlR5y/O7/HQupR/lP0t6US/yhpgLx5kGzfxyIY76oWcYK?=
 =?us-ascii?Q?iGqF7sUl0KwHdSJ7egiEegoKe9KYdGBr2BzoBCi/t5RgJZSDkvGWp2ZKvCQn?=
 =?us-ascii?Q?JkI9r7mOCsrv0HLtc8BwHWflBd4uP8jv3ffW4PTnvCfZve03wZguw0eje7z6?=
 =?us-ascii?Q?JzZ/LT5jZRpQAsLwP7ag1AB+CzN7IkZnYodu0x7yw/cxvx1P/QVDgIrlJWK0?=
 =?us-ascii?Q?9foeBYA1bglFHCZq2bOK+YhijMutRSLzf9Rs0KsR4lUlOGjWlwrZ/jFGtPQ2?=
 =?us-ascii?Q?4RSEcyTdIIAtmr5bnX1MqsDacLU/4pmPuA6wivXCpapay1RQOVwtxnyNnhQ0?=
 =?us-ascii?Q?eB3idOiocV8aHmOhB5xmufczw2Nzg1iEG+DRtuTjqiih8YQAZ4t50gSAQmVF?=
 =?us-ascii?Q?7ci9dmBG15RTco0kzNukNEXgIQe5P2SXAowXeSu0KC5FEJ7j1KM8UsSXgeMf?=
 =?us-ascii?Q?Dbn32/5hgTj5y0d+ytI6oPlG76ue0x0HM4dcEsL/pwQ5GbpVT228K82LqwkF?=
 =?us-ascii?Q?CDwa7tLq2uMss7SbNplJ83L4G7Pd87zDIFPC3mB0unMG3+0vCsvIuoUDplSj?=
 =?us-ascii?Q?pgpMTo1Ov/admKjNRvk=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08f9dc60-5371-4b1b-76c5-08dc3f75db44
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 13:44:20.3558
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J56QJaTc5qdYwQN+GzPpPg226z/CQp0LsfhaCA2dKkQBq8Z8AxkPz1TdroJIt0Hn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4282

On Fri, Mar 08, 2024 at 03:24:35PM +1100, Alistair Popple wrote:
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

This is the right thing to do

> 2. As per normal pages the pages are considered free when the refcount drops
>    to zero.
> 
> 3. Because these are treated as normal pages for refcounting we no longer map
>    them as pte_devmap() (possibly freeing up a PTE bit).

Yes, the pmd/pte_devmap() should ideally go away.

> 4. PMD sized FS DAX pages get treated the same as normal compound pages.
> 
> 5. This means we need to allow compound ZONE DEVICE pages. Tail pages share
>    the page->pgmap field with page->compound_head, but this isn't a problem
>    because the LSB of page->pgmap is free and we can still get pgmap from
>    compound_head(page)->pgmap.

Right, this is the actual work - the mm is obviously already happy
with its part, fsdax just need to create a properly sized folio and
map it properly.

> 6. When FS DAX pages are freed they notify filesystem drivers. This can be done
>    from the pgmap->ops->page_free() callback.
> 
> 7. We could probably get rid of the pgmap refcounting because we can just scan
>    pages and look for any pages with non-zero references and wait for them to be
>    freed whilst ensuring no new mappings can be created (some drivers do a
>    similar thing for private pages today). This might be a follow-up
>    change.

Yeah, the pgmap refcounting needs some cleanup for sure.

Jason

