Return-Path: <linux-fsdevel+bounces-14861-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B22880B34
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Mar 2024 07:24:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 987B41C2211A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Mar 2024 06:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDDD422338;
	Wed, 20 Mar 2024 06:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VOvYOOOe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699F9224D1
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 Mar 2024 06:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710915832; cv=fail; b=sZWxbIjrRpiI+TabcPHh3x9Rum0b0+Ew3L+EmxqXm5yagYH9ix2i6rWTkRFiwMziqcWYf8tfjfrx8fOzGw9kAyzHuHwYXj7tDrlijX/kdGiiVhQlJfyreHq7fWu/ndjAwUQnQtUS8i+Yu7PyOmWAHvnz4FtWQfN8ikNlUz8ygEY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710915832; c=relaxed/simple;
	bh=nyuw8ptsFBw4NEJBDsu5JJ/fe9Zhj3gA3GlZCflsEmY=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=XI1XSxryLWdQI+ZMv78mGKOZouERBWBf5mxEpSDjFEDZYFKQNbjQzju+ikm6SivEJKUzggJ9uZFkBKKcWnEBGpQIvbZnf0PG6ILfrfeNRK0UreBL9x5dXYJLV73Dm55A6Hqal294vJI8k1DnuEfURewtPpr07BUl4PQLCksrKSs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VOvYOOOe; arc=fail smtp.client-ip=40.107.220.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CQwedToEKA2GB96oEiWLudTjVIyfwAJQ7HKVXfogASNjaHSm7aONbnLZMS2m76NCF38Za8p/KdFwzeZsQUNy7FFDAn1V0lDAmAn6sx2W0Ac35VSAHBps+L5TTvADc8811DpnMS8MUaJmfhnoyGlb/C0r2JBzR2dADHYHgNNg990gLutCGqorw5Ivp8uMrkrU/Y+MWcY3a4pV52FGi8oQWU8jLgHyJCeO34awze/8yjyDNVlsgdLSAzgwAVtlnh9PawCsYMWcQEVPMiqgW0h6CIMLrT0MlvOakP1lNCzqG3SLG9F58rXunhZPEUvJ9x8oYrXqXd//ZW9RkIN2st35/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SjN6dmqt2FVPmJoGrj0fvR3Pf7yTg9jLHnp5TnQu1lo=;
 b=PpntN2/3idaEhKgFIaaLs0sL33H0bBh/jKbeWSwgk/eJ8670pxUmKAAvirXkwzVO4cojIccr7eZgbTq5/fq9STp6mPtC0JWeK4yqKXtHdbgdr7wA9DXHcv/LV3Vlnv8qWF9BLJhkBv4RSWaHJPgK/dlQZZwuZQ2oMXvitA6COrV7wKDC8Xy9d5nUrJTVBSzAZkpBt9mKhX01Dp3Ww4UgFT88Qwx6d+qigoK7J8zmiXQRzXIufNWYUtZENV4neMRCY8TrhUJI5MToJDGO9NkfTaPeeUkUZkNmhJSa3h063s26Q80LihwJUwLHhOvKYnIwO5raUYo37H5hjcYsnZGfZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SjN6dmqt2FVPmJoGrj0fvR3Pf7yTg9jLHnp5TnQu1lo=;
 b=VOvYOOOerXVvvQxRSowVNxfkaFWFHJbawrmmx7osenL5BUMW0ItYt2NR2RWITElPDkweRfAbNVcm5Am/+SYX1gc76bsWK1eoWgJZsWhsm+siP18roKs5ZFJKOXhXuu1U/ctsDVF2/Hibt9S1mSmLoexaIOVwRmG4mxBnjA7ZBNFIG+OzGFFx7Hclb5v0o6tKcOm/K292uTkQ83Vf6S6x1tXbkro9UHePJpVhMnaZPSXsgeMrCMjt6Nhl8u4S8mdSWd0FyxL6E45747AtSj/5f4H0S8QopMAD4kzJdr6xXVvcRjzHajMrvlftYIO8jGJSrWPJxCatpqnNsLut4BUc2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 DS7PR12MB5816.namprd12.prod.outlook.com (2603:10b6:8:78::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.31; Wed, 20 Mar 2024 06:23:45 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::c5de:1187:4532:de80]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::c5de:1187:4532:de80%7]) with mapi id 15.20.7386.025; Wed, 20 Mar 2024
 06:23:45 +0000
References: <87ttlhmj9p.fsf@nvdebian.thelocal>
 <65f148866bc56_a9b42947@dwillia2-mobl3.amr.corp.intel.com.notmuch>
User-agent: mu4e 1.10.8; emacs 29.1
From: Alistair Popple <apopple@nvidia.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-mm@kvack.org, jhubbard@nvidia.com, rcampbell@nvidia.com,
 willy@infradead.org, jgg@nvidia.com, david@fromorbit.com,
 linux-fsdevel@vger.kernel.org, jack@suse.cz, djwong@kernel.org,
 hch@lst.de, david@redhat.com
Subject: Re: ZONE_DEVICE refcounting
Date: Wed, 20 Mar 2024 16:20:59 +1100
In-reply-to: <65f148866bc56_a9b42947@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Message-ID: <87y1ad776c.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SY6PR01CA0143.ausprd01.prod.outlook.com
 (2603:10c6:10:1b9::21) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|DS7PR12MB5816:EE_
X-MS-Office365-Filtering-Correlation-Id: dbb7fce1-b7dc-4b1c-54d2-08dc48a64bb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WquVNOiElBIvkWumsmPumi843m/cuT5718KfzIL0bIgeCz30+SYWbKU5wCY0ojj/5/J71fK3MjlhQRW2xTBhGbSGiznFUkAWes+DfZjjzsgGuCHbB5GartcCzklxBIavs6vaIKMrsJiNDaLbG0hP1OVvNoMzJcLsMiVuifqQzJMR7AxdpBI+W5l1xs7j9IdybM/YL5qCCwQPoledAJUnHUFs36cxFYAxYKqZ5HkvV09nBkgfkGJ4HuVs2iI62P2/Rc8XKZhVFpsezGSzSOpAdUg0RZBL/ROWzyXs1ZgxfqnWnCHyKdIIq7Of10mWh/Rh0G/5A3qfdyIsQd8LESIzm0t64EIhR71ag5gD/3ZAN2FEr8FDwJA5Sr9U55oJwMs/xqowW+NM1U9sT0NuDfNFX5E/JhWsSYDq+dlRsRwhZzCoUF9n+1vhQcUF2frEjKHJS02R3ZWDL9vkdNU/X46Rgn0FI8YMms+HBAIMGuArblO1BzmyzNPR8BtUeknMBcaM0eFbgDDaozhl9FeyHEBFjjjmEYLACC5JqQWr/q3Ugom6B4kKX2NfESb2i99+MQ7XdK/8ffE14i22E0UW+ad+0L2BVjPUnJbe3DqcfW3z0K6zbtK+mYKFxu/xN/xlHogGaPpBSfclhhDh7xWD8rWhKdZVYfx8WBLe9DfK8NuafJw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?f5mv/Z6lqbBk/Qp2HzbP0JFmE+tqGathhr4HdNFTVgGpa5xA1TYXnJJScV0w?=
 =?us-ascii?Q?BRV48Kl8s7lqMD84eumUK28klM54rChVP+esJp99+HirNdB8lyQvn8jNM/Eu?=
 =?us-ascii?Q?2a6M4DQaTuO0I+aIbHrEWL8q9od1Um+LQ+H3TSSva607Uayt9HK2eLDCC31R?=
 =?us-ascii?Q?g4ujrenmigNJmJ4Dy/Eq5B6EEQraFjICf1FKOCpXduIxJQ4082fA14OflsYN?=
 =?us-ascii?Q?jypAJRsE3nM0A75hg2GR35ST26IJLu7F8f5uhfdj9JCCLZGcusDg0kB9+suW?=
 =?us-ascii?Q?YMJyoAjCwtAueURs5ihDsZA5MzUXyvea9SimUxu05Db4Wi9b/Llzqw0HmKZc?=
 =?us-ascii?Q?ZBMeJXa0HumH5oN4+bJ8h7gYrRuXHthQJ6QGFjjWJygGsEGTlZ/NnXkEnq7/?=
 =?us-ascii?Q?y34fb4iCQfHX53+u2B7TvIzWlW9LWEsBOkQcs8r6GJ2CRg2rBi0sHFhiJZcY?=
 =?us-ascii?Q?S72zYLC8ePMPQYPH0CwYY6P11LpqVAYPx33LcjObJsqdP+OYHgqjcglE7SmH?=
 =?us-ascii?Q?+Qx1c7wlRgWAt9MF0fhy3sVTNg3SnD+EupSfFL2/z9slNbTyu1snEtqi1PdW?=
 =?us-ascii?Q?WYM0eQeEB98cjBfpyhGgYeDBo94YnT8+4P/XxYc0IGxEWeCDYIeSnNVW2z+D?=
 =?us-ascii?Q?sbbCUXKOwE1gCSAk5kq6ehVndDBAZmrCoGzL/CaVU4mPZDBSnOpNPXBjUJSZ?=
 =?us-ascii?Q?xW9KWpQFN0B4IpxWUXd/kWnrEbyrjSUZkyqmaXkxnrLKtHnGPzc8K1Da0ne6?=
 =?us-ascii?Q?rGtzGsISa1o9rA6ScnoXSTKHJlhRW1LFJ3LjVIEvRZ5ah6FdNodxFhbRBl5b?=
 =?us-ascii?Q?k0qfrTbdj8b+QpgLf+vJt3zruh7qrDla+iPr5uROqNmdNCgwIXlP/Uy1rLay?=
 =?us-ascii?Q?7Ofhp0zOp2KH65BmfekiJe1U9bh+nHIRaw+Dk2jXH2/5u3VrkETvsg0K785z?=
 =?us-ascii?Q?zU50nkb0DoO4GLMfZnVzST31B6PATED/5RDIBpBJSZBAQXgVjs1aDbCqMVZx?=
 =?us-ascii?Q?0S9VYxiM4xlMBxAcBEBOSS2jkTAkkLQiwNwL2LSvnwdxF4ueKPXc0CZ2j4sR?=
 =?us-ascii?Q?XapQSt+OGsr/6PqBnsBZMPkpdtHFtWNIbcm2bSobmeo50DyjNkv4dvQihrYf?=
 =?us-ascii?Q?3SNvLUlB20bb4gn3ZUa2eeecb5sRXYC/bJATbFHA4mCGAZt3BL4CnwC/nj0T?=
 =?us-ascii?Q?FgIqS9M8aAmBtMIMocnwfOnUioM/KK/JY+YfTHszohesZZHAB5zRX6inGpih?=
 =?us-ascii?Q?ZwjZRXzdQxNkJkPOPbeON03XTSvwg6WE68VoTfnXWA/4my9iHMvj9vmP1pfb?=
 =?us-ascii?Q?n9FLVdjTFfDzz/8e9uUIV7/lcOHN4NAAIazFKmk/3Sba+r1BnuToOp+YsFQd?=
 =?us-ascii?Q?T50TM5Zhoi78pU84ZTtGuZIxVsN7QlqiCyTjUDstJrZ07AkXusOOi0LVRetM?=
 =?us-ascii?Q?ofRh/oWp9csxguMPH4CUrQnoNuEkS8zCkD9yT5i3PA9mjWsdRTk8nPgQqHSB?=
 =?us-ascii?Q?PUGR7XRVIf0uBsoQxOpYyygfAxoemY11vFvXP+NPG3D4zfewYsLEZ8y99gGq?=
 =?us-ascii?Q?P/RzvUOtCHD91wbBk6LuQLBu2i6LjKsGamixpqeO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbb7fce1-b7dc-4b1c-54d2-08dc48a64bb2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 06:23:45.4480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gxjXfEvEqJMsamG8PktN+QGbbUe56LLL7oP6FFQDHTvt+bx1LIekxC63jx20KHxxtjsTSh6OiYEuCKMmzQfxlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5816


Dan Williams <dan.j.williams@intel.com> writes:

> Alistair Popple wrote:
>> Hi,
>> 
>> I have been looking at fixing up ZONE_DEVICE refcounting again. Specifically I
>> have been looking  at fixing the 1-based refcounts that are currently used for
>> FS DAX pages (and p2pdma pages, but that's trival).
>> 
>> This started with the simple idea of "just subtract one from the
>> refcounts everywhere and that will fix the off by one". Unfortunately
>> it's not that simple. For starters doing a simple conversion like that
>> requires allowing pages to be mapped with zero refcounts. That seems
>> wrong. It also leads to problems detecting idle IO vs. page map pages.
>> 
>> So instead I'm thinking of doing something along the lines of the following:
>> 
>> 1. Refcount FS DAX pages normally. Ie. map them with vm_insert_page() and
>>    increment the refcount inline with mapcount and decrement it when pages are
>>    unmapped.
>
> It has been a while but the sticking point last time was how to plumb
> the "allocation" mechanism that elevated the page from 0 to 1. However,
> that seems solvable.

So as a proof-of-concept I was just doing it as part of the actual page
mapping (ie. by replacing vm_insert_mixed() with vm_insert_page()) done
in dax_fault_iter().

That did have the weirdness of passing a zero-refcount page in to be
mapped, but I think that's solvable by taking a reference when
converting the pfn to a page in eg. dax_iomap_direct_access().

The issue I have just run into is the initialisation of these struct
pages is tricky. It would be ok if we didn't have compound pages.
However because we do it means we could get an access request to a
subpage that has already been mapped as a compound page and we obviously
can't just switch the struct page back and forth on every
dax_iomap_direct_access() call.

But I've been reading the DAX pagecache implementation and it looks like
doing the page initialisation there is actually the correct spot as it
already deals with some of this. I've also just discovered the
page->share overloading which wasn't a highlight of my day :-)

Thankfully I think that can also just get rolled into the refcounting if
we do that properly.

[...]

>> 4. PMD sized FS DAX pages get treated the same as normal compound pages.
>
> Here potentially be dragons. There are pud_devmap() checks in places
> where mm code needs to be careful not to treat a dax page as a typical
> transhuge page that can be split.

Interesting. Thanks for pointing that out - I'd overlooked the fact
pXd_trans_huge() implies !pXd_devmap(). Most callers end up checking
both though, and I don't quite understand the issue with splitting.

Specifically things like __split_huge_pud() do pretty much the same
thing for pud_trans_huge() and pud_devmap() which is to clear the
pud/pmd (although treating FS DAX pages as normal compound pages removes
some special cases).

And folio splitting already seems like it would have dragons given these
are not LRU pages and hence can't be split to lists, etc. Most of the
code I looked at there checked that though, and if we have the folio we
can easily look up the zone anyway.

I also noticed folio_anon() is not safe to call on a FS DAX page due to
sharing PAGE_MAPPING_DAX_SHARED.

[...]

>> I have made good progress implementing the above, and am reasonably confident I
>> can make it work (I have some tests that exercise these code paths working).
>
> Wow, that's great! Really appreciate and will be paying you back with
> review cycles.

Thanks! Do you have a preferred test suite that you use to stress FS
DAX?  I wrote a couple of directed "tests" to get an understanding of
and to exercise some of the tricker code paths (eg. GUP). Have also
tried the DAX xfstests but they were passing which made me suspicious.

>> However my knowledge of the filesystem layer is a bit thin, so before going too
>> much further down this path I was hoping to get some feedback on the overall
>> direction to see if there are any corner cases or other potential problems I
>> have missed that may prevent the above being practical.
>
> If you want to send me draft patches for that on or offlist feel free.

Great, once I figure out the compound page initialisation I should have
something reasonable to send.

>> If not I will clean my series up and post it as an RFC. Thanks.
>
> Thanks, Alistair!


