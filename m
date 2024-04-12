Return-Path: <linux-fsdevel+bounces-16758-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA06B8A234F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 03:38:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18FD21C217E1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 01:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 947146FC6;
	Fri, 12 Apr 2024 01:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="d3QHJp9A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80EE84437;
	Fri, 12 Apr 2024 01:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712885891; cv=fail; b=C1/gzCtTIAivEePbMEtasI/eXSp0MP5YHYY8oY1dNl31JngZBFVNCeeVJXW3xc9UspDthn8RFazxWHcK+4CDS+VGF5fcbCsEnGxwrHYiiLUJt2UO714WKyBQilH1WjHXdBWiuwAzXZMYy+ZJMklJ2j/1gjbN4t2v6dZleZPRhEU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712885891; c=relaxed/simple;
	bh=8lNm91An4pzIb8ddqlx0jhMZtpTj5E2/WeHIjVhwsHo=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=t4t+NsHTCJX4DHpO8OvV7Bib39dkgtAsvEOfhXamiHWo22yWoFgJ7LRSXwB3qUWx30hnopwtDaSY0LLxFcy6TZBtH9slo+xsOg2Qqm/jXysn9CP1MAPIt8BON7b2tTmNm6ju37wUMmCeFKnjsyOT5fzDp93gcFJvihbu4IgjoFA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=d3QHJp9A; arc=fail smtp.client-ip=40.107.244.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SaD1DsdU0kSKsnboVYLyzBYJ44krKHyrQ4K17O83MerqL9amy0N8SWy/wfj1YhzyidEHx7zQnMCLkFG3B4tIO5EmcbHmKWTOJWDk+GxVtiTW+dbp7BcTM4VnvyCEiOYtfoKKnCy5hPcWMf74unVV0ZnY7sDWzktNPBVxH+CNditb6//U4HdBa1D5jjANo5HL/j3oVBxs/gxr/B1JvFSA2Ib2N3YvL/tgxTi8i99fFg5Wtl+En7boMH1MVkHckPc4fBVSDsX3UBNWmmBN0pKOFqwDU5W8XgP492gYEAGBg8yIY0R89t0PdBhaW6GSd3NK3iVcU51gt46ST7j7H6ev/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KSbUVGPtf+v3LW6pTQEiRVRGmx/VBwb2GU1vmTvfrt4=;
 b=ikI9SteXd76q5LFDTZO0wGlC2MwOoKn3b+0Botf1ccQRduz2qrfgPOjraRfD9FiImV6fEY6OhQiJMRlDAuotvhtBjGtrdi/mt9P7ktzB4JgSqj6GNZrzKiAf/xToBQBEeumfPSOfrL1O5dm8iw8wpGZIP+3bTemh8/c32E4ycNbsabK7i+2l4lOqSXTrpNafOUg9qIxGo9IKX5UvrtgOJTC684u0ZEbV0CCJMsKXoLa1YNgfSgDG+Y91dgYamGIFJ6aZAySz8AuhOZ52fNCkBiB8OnLF7taJcwQdNmjhBN0C/h9CGWNUUwNzPt/S1TmWMJBdxPdk6dOx+4OTqEQAew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KSbUVGPtf+v3LW6pTQEiRVRGmx/VBwb2GU1vmTvfrt4=;
 b=d3QHJp9AlN2IUO0LY4W/MWenThZ+IKW50tY0QJIO27U/lTg7Q1fEGoJFAmeACZCbW/bimE8Tb0WxfPXVi1mqWImubiuPV1CQjNb41AJRwmgWO0W9SrKlV41nl69G0kut8sOitxpn9O2bVwHkfzXbfbYeNZWr5/mVfjYR14K+DG14EUR/zlloUtYEf2RXf6a+d96MuZRzHu535HgK5HYu0zIJ/JEXhkvNatEGA0t0j3RpSxu/eFLcBm3JzNK1AEEh0xKTo2N8oQnmHF9ZNOLAi6qUXyVDPK6ZVyU80QGJ6nuJENhsegHcG56CI1YIKwaw3RTu7uRVXgRixCMiTkMRsA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB7705.namprd12.prod.outlook.com (2603:10b6:930:84::9)
 by PH7PR12MB6540.namprd12.prod.outlook.com (2603:10b6:510:213::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 12 Apr
 2024 01:38:06 +0000
Received: from CY8PR12MB7705.namprd12.prod.outlook.com
 ([fe80::e71d:1645:cee5:4d61]) by CY8PR12MB7705.namprd12.prod.outlook.com
 ([fe80::e71d:1645:cee5:4d61%7]) with mapi id 15.20.7409.042; Fri, 12 Apr 2024
 01:38:06 +0000
References: <cover.fe275e9819458a4bbb9451b888cafb88af8867d4.1712796818.git-series.apopple@nvidia.com>
 <ffd72e934eeae28639b636e1e61a9c5109808420.1712796818.git-series.apopple@nvidia.com>
 <f3b38a24-d252-49ea-88ea-ac12fab3c121@redhat.com>
User-agent: mu4e 1.10.8; emacs 29.1
From: Alistair Popple <apopple@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org, david@fromorbit.com, dan.j.williams@intel.com,
 jhubbard@nvidia.com, rcampbell@nvidia.com, willy@infradead.org,
 jgg@nvidia.com, linux-fsdevel@vger.kernel.org, jack@suse.cz,
 djwong@kernel.org, hch@lst.de, ruansy.fnst@fujitsu.com,
 nvdimm@lists.linux.dev, linux-xfs@vger.kernel.org,
 linux-ext4@vger.kernel.org, jglisse@redhat.com
Subject: Re: [RFC 01/10] mm/gup.c: Remove redundant check for PCI P2PDMA page
Date: Fri, 12 Apr 2024 11:37:00 +1000
In-reply-to: <f3b38a24-d252-49ea-88ea-ac12fab3c121@redhat.com>
Message-ID: <87o7af5pj9.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SY5P282CA0137.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:205::11) To CY8PR12MB7705.namprd12.prod.outlook.com
 (2603:10b6:930:84::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7705:EE_|PH7PR12MB6540:EE_
X-MS-Office365-Filtering-Correlation-Id: be276bb0-b080-4d97-d11a-08dc5a913393
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Ne6ef9eTTYt2LJ5x882KqDRzRtQespPhtt0+KBDJTeEfCe6H9+Bizq4QkSQt4YJhSzv4U8PaS4MM6tMV9uEiaSK62ZnjiXk6T/VUkHjIpTrmiTSJY0yYt1QzvrNuvpP+/XQEFtuj2Zzgb6FC8esLEVP46ld8fYhxWbJ910Rie7p1Zon0HLJuB3ryDf5q7LMAzoihoO9PSjW2JQO+GqzbRYImiYIrBS6oR12ZNTvtuW1Ykk1FfhqFe13/5JYEi/HlBEJJxUpMGmasiBcBSBBzCge7OPQmVDHSRJLHkvRrqyPbDEF7jbM4j0aFdDLJGN9JSQ7MTiCxH00aMjl7nKiLxz0jL8uAPqxfnNK7NEnsM+A+HDM757/2QXM7ufUHROnDVIJEI8kh5PgGlgrPBGx4bxsvKopXBhAlMqwPzQylWB0MqADXpBgvo3geHCNGEJYs3rneMZnoVvUsjQL2/OYU94dZm80A81SXI5xIGfo8xrSVanIZ/n8TRdLpDBX7klYRm2Zzja7DGHasqBS5JfldpC5wL1Dg/rtvoFxGIdPxFFT74cczKQ3LAO/FlIKdJCiOYM0RFr9Wb9wUIIcz8j7vfjN+mUnzxePsK8tX2e4970mk4VDWfpSIuN2dOfmNL9a40lltSaruR1/UF0E9jZdgHr0KyNX4oFnoWni+X+5steM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7705.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fsn7AF266uxYvu1qAfJyt9RtMKELXxndqawXyXRW6KT4WH3yJ++syzPx+1Yd?=
 =?us-ascii?Q?QemYKfh6jlr/EJuzESL6PnUeJTl1RN9X2MB5OHjqUum2LYcDhZAwWYtHQVoW?=
 =?us-ascii?Q?AfUyBuvsBJGRVCsKrQdMTorvPj8dwanqyO/l7sxJ2h7j03YSZTUW884cTm8M?=
 =?us-ascii?Q?tVDLgcYDSoe9+j5/OG7YPSTwnvXmfw1Q96ZTGoJZ2PYmcTHYzEdIVRrlvW17?=
 =?us-ascii?Q?7q/gbc6BnMyYlp7n76bgkTonBx7DZs1O/E4B46pDxezd9UFxKepLu5dwv4Kw?=
 =?us-ascii?Q?Hg0qewWigc8IjZU+cqNsWMWWCfKmRy+7u8Gy9bn7j+HeVfCgRvZatkj+tKXO?=
 =?us-ascii?Q?BVwwnyhFZNhQrYREUYfaMFZs76Aj3jiOnpFBlPH5hrQiR80c499K7Se3hVwS?=
 =?us-ascii?Q?zhA/ISxVtv4DIbYbD/dn/P4bygL9NMkXRnQkBB70i0gdfhJrdFffy2i6uVdH?=
 =?us-ascii?Q?qyeY0bKZIP6ehTUaR4/q4ArV0B1I7ricIxCiLg8gF2nGBB1S8NvRdlLQGijg?=
 =?us-ascii?Q?y+G5a9aZD3QVnuG5cdxCZ/LBvjUo0f8nUk1K0gEeA4Ev/++A8+rIEks0to31?=
 =?us-ascii?Q?ux/uHTwDrovSaEAbvpqfgCHD4e+Plc3hYQXyZK/rvLeWUbkCgeDrGXP+7kBm?=
 =?us-ascii?Q?GKZYBw+6m/sLDFeIPbXCf5v8pWL94xWG3hRrxyRitGZlYp5DQXfHz7IN+Ugm?=
 =?us-ascii?Q?f0G8U+lj1abweI6CCrk6fcPcU8/ymZLzwe0wzMorUNCabZYgyUnWBwo3YZTg?=
 =?us-ascii?Q?f49qGd6pgBHIvj2WIPZuc4E96/SKtmfSlEnc0EZkLih087+gSqdvsZ5orabU?=
 =?us-ascii?Q?t5Ox0F1JeQRjgL693MDdGIZYD7pomhDMJI124Wb22i/WWAww3T3xwK1uD1y9?=
 =?us-ascii?Q?kz3b8qNGnQ/HtQJq1LqUUxFmODrnWT6bPV0o6fQARjTMILq6yxT5d3eMEri6?=
 =?us-ascii?Q?SUqYlmXN1O2MGko5XbqBZHO0Pgqq3wnsuk1K54qsIADPpm5k9V+bIz1TW0Gk?=
 =?us-ascii?Q?hQgPZabe810BQ5xSB7rmKYfylcF76OkUuu5qzfnXvku//sg9OAXIYwOxvbiT?=
 =?us-ascii?Q?KX0DUkcW4LKcebS7D3kCGN7+AFCfQ34mt5EYJ4lmSqdXvOgavASqa1rWSdh1?=
 =?us-ascii?Q?enVjHkgeh52QAiYBJgoOaSp9dQm6CBaI8UoDKwSioxIkTphX2bBnJ8zDCc2a?=
 =?us-ascii?Q?Kncy1aEubB4uhK8wO82qzCjQUBSmG9V+GxFN4ABK1HIZXiRoZf7zCqSQYfGn?=
 =?us-ascii?Q?7pgRgiIk9lKivPGdLoeM2apJQb3n44AArOulWcXXVHgjzIsf8+Ibdel6dC8J?=
 =?us-ascii?Q?PZoQOb7NmC3AnAFUAmtlO+fo2w96eCH6VQnJ89ljLvcebA3A3l8Cm2aRyhnS?=
 =?us-ascii?Q?Cy2EEy8sBRfACKVNT/+7j3kv/58gW7Sh0dlo3THVFBJZJFWclNAj2mqEUsMC?=
 =?us-ascii?Q?CzE4UbKviIxVaP942/OZSFumBmBqY4t/pOajmlxwdcN1Qx/XZtz3pgSOdXbi?=
 =?us-ascii?Q?KIUKZeFmZC6ljVsd5onaA2uoViwfgpR4D12Jw3QaN96913xWynGtOf4zFKKw?=
 =?us-ascii?Q?KRlIhVkYYB69Oa662Xki3/S9aCEFSFAJUF+mKpY0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be276bb0-b080-4d97-d11a-08dc5a913393
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7705.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 01:38:06.2831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +dJkgw/QD/bMhPkoTLDnV+Q8EJwpwjM7/5NJp7GqrPGuVbRVmjaFL4wqPxBaONhUYuXlnOaYHpzezaaPug/EUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6540


David Hildenbrand <david@redhat.com> writes:

> On 11.04.24 02:57, Alistair Popple wrote:
>> PCI P2PDMA pages are not mapped with pXX_devmap PTEs therefore the
>> check in __gup_device_huge() is redundant. Remove it
>> Signed-off-by: Alistair Popple <apopple@nvidia.com>
>> ---
>>   mm/gup.c | 5 -----
>>   1 file changed, 5 deletions(-)
>> diff --git a/mm/gup.c b/mm/gup.c
>> index 2f8a2d8..a9c8a09 100644
>> --- a/mm/gup.c
>> +++ b/mm/gup.c
>> @@ -2683,11 +2683,6 @@ static int __gup_device_huge(unsigned long pfn, unsigned long addr,
>>   			break;
>>   		}
>>   -		if (!(flags & FOLL_PCI_P2PDMA) &&
>> is_pci_p2pdma_page(page)) {
>> -			undo_dev_pagemap(nr, nr_start, flags, pages);
>> -			break;
>> -		}
>> -
>>   		SetPageReferenced(page);
>>   		pages[*nr] = page;
>>   		if (unlikely(try_grab_page(page, flags))) {
>
> Rebasing on mm-unstable, you'll notice some minor conflicts, but
> nothing earth shattering :)

Thanks. Rebasing was the other thing I meant to add as a TODO in the
cover letter :)

> Acked-by: David Hildenbrand <david@redhat.com>


