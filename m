Return-Path: <linux-fsdevel+bounces-33037-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF879B23E3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Oct 2024 05:35:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE76D1F21CBD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Oct 2024 04:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D374318C03A;
	Mon, 28 Oct 2024 04:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kyfN+kFY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290FC161;
	Mon, 28 Oct 2024 04:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730090095; cv=fail; b=GkJ8g0zqD89OljFGpFvLB2REIvDG9M9QiWjNX7Iugo8L9clpEXz42SMlyI6UBxjAhj7TH8jPR+jxr0B3M32e+aOHEhRvNMCg7ceKwyocgBxLGz299mhiAfqJeBrzqrlUZGyq92/yVvLIWpXX7ygazUof+dxCvHRkoVlJ3bJSbXU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730090095; c=relaxed/simple;
	bh=jTsY2dMvlIUw7O6bEm86+P/giwqxqEBgasaJ8aglfGo=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=MQA9GueYkfRJKBb15yQyc5mLLGQKtQX/9DESpHye5M0U7mFdhsIllyu6mV462vPSJi4iI7OyH6fx7kScPJ3SBvLKHALzMQlWocaGA8FMlftpczVqNerS5WyNUX5fd+WYczDBWkOQSaXh2Gy8q2RILmjA2O8oDdBX8wFCPhgi6ic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kyfN+kFY; arc=fail smtp.client-ip=40.107.94.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KWU96ZN7iu7ql0aKRA4xA/GNmZQ/pdj4x9VKCOf3KVxRzk29VepY22u5sCi66KVOmEULOxWL2nVCrw+MLdN+9678Y1ULgL+ipv5Xe5f8mnIXgBxWOEYBNac+oc7T2y5o51ut44ZyJ+9XIrHg0/urBAvveYy7qXOfgDVGD5EaBaGh2I4fZlJMM7KN1FBIvq6qR5PmzghTMe4tmN0Ff2x7mB2VRvuyOCAHiAbhdJIO1y2sLhc0D4lPm459Xh36IvIjNpQwObi08r2yqETb8tAl2UbrydmhsiioXNmabInkcJtlsHqDI5xhB7P12nDydM/Ie9H96J4a+M8xFDVdZ2Catw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ZjXdEcoSVBoYgdbPzIgj4JnGn7V3W84zJapxpY/PGc=;
 b=RvjxpbotQ11VxvcxZFfWMqEkbuOZwiuKoj4yibCt2FuI+FrOYzZ8uc3Q0NigK/LZLk53aPRnTsKmVGM4QMBlGIxoyC1b0T4j/yZAc5+gHXrtj4ydzGfnOpOOP0Y899ma5Cdt+OtDO96iDBJvJav5o1Z5mJSjmxw5xLfaliwe+XzKrewG8wClJaTVpZZ/ox77MjfmDOWk9yg6DIJUiVSa5+alsYwdOXZF0eZUS4K4DVyt1PLSQVK8rZZH1OM0ntV/hp05CR8n9dP8hEyqMeCjM/9VC1/iPI02k/ygYx3JvlMmWHsUlQZEiI02vXYW6SGHFjjER207WvOQURi8EnBldQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ZjXdEcoSVBoYgdbPzIgj4JnGn7V3W84zJapxpY/PGc=;
 b=kyfN+kFY3toCsnT6/ZJBlqyPx0sEIGagWuVgISHQqjWDnyxNRv31Sngp/52JvP5Ez/wROMtn50OhdIiHqxBE8DEFRyrEjpFn1pwqrbJpRjkHX/S5O8LkqUjHk13n+rsjE5IK5Z3K/6qFyRyJL9SGQrDsC1uVyLKqeqKrZzawbQZhRdiOhtrfkU2hSm9PbO7jD0oI90pCkpn72073VgpJbuTooS3wUOs/9DS6cDsXXAcUtIA/wp1sUo6v9YIyytyXEtsRkeN0s3/TjTSQPImqv6jAW1/AO3mOepBrDKYV4wgXx8Ayw0bjjw3T+ocovPRSsVwEW/XHe/uSEUkCLosHTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 CY5PR12MB6477.namprd12.prod.outlook.com (2603:10b6:930:36::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.21; Mon, 28 Oct 2024 04:34:46 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%3]) with mapi id 15.20.8093.024; Mon, 28 Oct 2024
 04:34:46 +0000
References: <cover.9f0e45d52f5cff58807831b6b867084d0b14b61c.1725941415.git-series.apopple@nvidia.com>
 <9f4ef8eaba4c80230904da893018ce615b5c24b2.1725941415.git-series.apopple@nvidia.com>
 <66f665d084aab_964f22948c@dwillia2-xfh.jf.intel.com.notmuch>
 <871q06c4z7.fsf@nvdebian.thelocal>
 <671addd27198f_10e5929472@dwillia2-xfh.jf.intel.com.notmuch>
 <87seskvqt2.fsf@nvdebian.thelocal>
 <671b1ff62c64d_10e5929465@dwillia2-xfh.jf.intel.com.notmuch>
User-agent: mu4e 1.10.8; emacs 29.4
From: Alistair Popple <apopple@nvidia.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-mm@kvack.org, vishal.l.verma@intel.com, dave.jiang@intel.com,
 logang@deltatee.com, bhelgaas@google.com, jack@suse.cz, jgg@ziepe.ca,
 catalin.marinas@arm.com, will@kernel.org, mpe@ellerman.id.au,
 npiggin@gmail.com, dave.hansen@linux.intel.com, ira.weiny@intel.com,
 willy@infradead.org, djwong@kernel.org, tytso@mit.edu,
 linmiaohe@huawei.com, david@redhat.com, peterx@redhat.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-xfs@vger.kernel.org, jhubbard@nvidia.com, hch@lst.de,
 david@fromorbit.com
Subject: Re: [PATCH 10/12] fs/dax: Properly refcount fs dax pages
Date: Mon, 28 Oct 2024 15:24:49 +1100
In-reply-to: <671b1ff62c64d_10e5929465@dwillia2-xfh.jf.intel.com.notmuch>
Message-ID: <87a5eon8v3.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SYCPR01CA0035.ausprd01.prod.outlook.com
 (2603:10c6:10:e::23) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|CY5PR12MB6477:EE_
X-MS-Office365-Filtering-Correlation-Id: 7140a1f8-8fe8-4063-af39-08dcf709d9d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fgnaV8jGW6LwSP1WJQ0sYmq1XrFf1+cHzI4zsUpowSK9m7cwp1PuC5C7o48z?=
 =?us-ascii?Q?dAzzN1qSvbTNuwPd4dnYI0q6U8iDz0WUthKIRmrVBcAM0LAj51j4L2lQ7vWn?=
 =?us-ascii?Q?N3sfcX+cvtSorxWQHM7/WpyDLO64+23TMpFTbWAZsSA5De9Drh9aLEQzzPtj?=
 =?us-ascii?Q?YAAH9k95k7kh49e2YBKTLu+JfzJjODIKcdpC5plyxHRD1frNkjqZLb+H1fMC?=
 =?us-ascii?Q?2pBQoLXSW3/hVBlVuEyfxM1R6Fcv+w/BxnSxFHEywvRuiP1xktB2LLBkEGp9?=
 =?us-ascii?Q?XA/dZ5v/1o4zxCD3xgADmyTdyGm8+zhGILeaJPx9Mt9w7WUrdArajO8lIrL/?=
 =?us-ascii?Q?Ksram/lR/bm9Sng1aqj3DDcs0gRro5q62SsnS5Qt2Lwr3RVvaJ/5MYDRQv1i?=
 =?us-ascii?Q?VV6ODXJOzLLUzZRFQ02nJBT3WT6FJ73EtHv00vjxe8nK/32E6TI6yEtYJHez?=
 =?us-ascii?Q?E5dfwRNWyZYlTSa7qNDwH0ARRFfWMWE5eQAKVQKWU4upCZqJ50DnJH+iBjoB?=
 =?us-ascii?Q?31beG7ah6XEojKeaJt6tX9KTgKCk9iuZLIh4v04sr36fIF+srJQ4XkZiMPuD?=
 =?us-ascii?Q?5ToarrCsXBJyK8G/GpjwJCgcZa8PYOYuxTsuE38Hcof31bJ0mQ0G2y0rcYvt?=
 =?us-ascii?Q?PB8OcHQW37qq7qggzoS3ZKSdnK8QTkBp+0I5OtDQSwW0L5pnhhIsSyXphjtj?=
 =?us-ascii?Q?bz3ZZCVJDO/j4EEjoJFI/LJd9/mv1EUgWsHX3sddk8S4Dfaqi45VO+1Ug97a?=
 =?us-ascii?Q?7oQH2dOdx6pN4xgNFEb+wUwAOvEyPPZwO8BwAq2B4woQKJxp/aA8kn9PeRjh?=
 =?us-ascii?Q?p2uT1FnHmPl+Khacnz+evYXozbDesL+Gb++GTeBsBPa7bTa2Oj95BhBwIQ9f?=
 =?us-ascii?Q?jKnMrDDwShRcRNxTgxIIn2csPPk2YFPp8m8DbWZVplGSw2PBLIWoWENxPJmS?=
 =?us-ascii?Q?rNSMJ3Lc8xaTBT6PyJDXlDY3k605/XcfrIUJ6YwrxXmweqslzXlS0c3vknGq?=
 =?us-ascii?Q?GGWMgkaZoqc/utSMcS9g5d/i4TtiZNgzDNrtu6ebMP/D97ZbrXLH92kaaW3c?=
 =?us-ascii?Q?u08BWfiD1B9+TomZW4AnbrR8LvuH4VAaxGWh5sMQVVGyD/OWGicvzbWaStBo?=
 =?us-ascii?Q?uy8/KTueH4UVYm6k5lNtcZVd+Ty8uTk5SGYvOy6nTv3qbxPiTG88rOjEDNKN?=
 =?us-ascii?Q?oa9GD6Frhs1wOY1WJ3SBi/JN3j9bN++52ubRYeFT/k1pR/wwXbXm41th9OFx?=
 =?us-ascii?Q?s6pDwEitH/Fm/qfzu8GYximzsz00y9UYATx8VRxivJfSeaerDfE9j66xESBa?=
 =?us-ascii?Q?MZYaa9bQ8X6y45OsSmiP1/OL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WTkHbol3qlVRxuDb7VYSFwUqUmmu9hfcI39aw5VENI59vkP6p5vlHUCEY7nA?=
 =?us-ascii?Q?gcF0XOEcd35wMtm04aOKz7lwfreanMJpCNf6SA4vp4rKmlrNBwPusVtmCFQy?=
 =?us-ascii?Q?GuQpuJnibNPLbi8uzbL80XFxDGKUUnBvvkTmY4LVfzUj3QHp0hh7BQ8aXZfj?=
 =?us-ascii?Q?wEqCn49fI2YD2BTa+mOVWQpJy+XvmDpTjqhE0HCakbYIiR+1sCoEo+ZM7KAE?=
 =?us-ascii?Q?tQkRttJDxzjU3Zu0wgX782qr2DkcmPabcN63JXjGgKmuYCKyVxr5hcA5Q88j?=
 =?us-ascii?Q?V9o+JvRMFVIyudLadoKyKOV0sZ3l84iqB7VxpfTqltEDIaquKVbV+rt4zXNF?=
 =?us-ascii?Q?+rJKGJfn2wgoAF430R227vwfrqIu6+P3zs2i9mH693Xv7qnj3DHQ1LgMnLs1?=
 =?us-ascii?Q?/jx1lmK68rsualYETA351a9Tx/Qje2O7xIKSJuCNsKEKSoBLP+Jw8gCmRd69?=
 =?us-ascii?Q?zOG+K97E3EKf1h+BvwIiijDN58/LYYsfGxkdE5Rj5JfmZvDm0PTpopqgGyiS?=
 =?us-ascii?Q?bIGiFpaXJHa5uVtaAnrKlVJV8eU8iDkpa7k40vtQu8VF6NS/BTB/97UpfmG1?=
 =?us-ascii?Q?w9SlknjN41WOCSi/FqQC9oAu02dEjVaX73CGbPKCF9PcmDy4U5mrEKF7UbKQ?=
 =?us-ascii?Q?7WkfzafdHC04MR24byBS+givSO5VDeEVLqJwWVcIVwmkpJ+jUpKD1uqEndcV?=
 =?us-ascii?Q?KEbj0qPIKtZByR4XbRADqdfNDHMzAKcEacnwtCuDpf/QXXz7JAWo3ESluJpg?=
 =?us-ascii?Q?FsvD7IcfuPQMxY0iwcDng0hKP31B443ElUxzZFlr+k1lSqtyHeus+tHtCgsa?=
 =?us-ascii?Q?zmW5s+Nr4f6JsVsHWtXAUPXwFcyw/uX/gMoxs9PM7Wgu0JNW1OtuNt3+Lgxl?=
 =?us-ascii?Q?T80IXBgwJSdeR6yfl7sMCMeJnZIOQjxdTMZX1upMg5B+EKJPLfZOi2I8/NKZ?=
 =?us-ascii?Q?/kxcmdKs5agSiFBIjmzDsAer5DrwExJhRvOwiaV8xpvLK5Z5Xk2q6h+JPnGw?=
 =?us-ascii?Q?qlwP7y3qP3dcm0xg1I/Zx8vbn6NzSkmo6WS3pM9cegvTMvNzf3kEF2Swry3f?=
 =?us-ascii?Q?sMoFmtF2Xw+SB2YjDmX9Gk5Of89kN0duQqMZaS9Hgyf3SLMk4wjlPvJQ4lm8?=
 =?us-ascii?Q?jekb8uyKCA9/X4/VyVoINJnSQSAplHU9glfcERJkZvDCxtNwiqnt8ULtbGAr?=
 =?us-ascii?Q?FbDbPgAaX5NCdBnBrvWSgR8AHIp9eyxkBPpcZ7KLig1LSrqestTsmdnLC1k6?=
 =?us-ascii?Q?g3n5wrzSXpUEHryjHsSK22DVwmxI11PpagxLgMUq81ee5PC0Ala8WgKsHxEO?=
 =?us-ascii?Q?/twZ8vQkxvAUo0P+jKr75XnS4wubHqcqxuidCpSq/ttIipzXkNn3mtT+qq5x?=
 =?us-ascii?Q?j9ZF3YsKRyXoauOO5oHEl4RN4cutgwDHdbDI6em/w7ZSR8uo1DDnV85e9kdB?=
 =?us-ascii?Q?AT8jGhgeCFePL6gWeiVCWDO2a9o8sGkRE+pZm6PlGHrcXBy9cFns9j7PEB3S?=
 =?us-ascii?Q?BobGVoxTgA4xxsJUeC9TrK7z/g/87Pg7TrX+9ZjDt/nPHNGdke12XlpLQI4Y?=
 =?us-ascii?Q?jxOzR9wgeCygZLvD2h2aCW9oQOrSuby2kgqjpYTC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7140a1f8-8fe8-4063-af39-08dcf709d9d3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 04:34:46.4762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tg5fHwZLoq+AStLtA5KXu7ZjK2NEFA/9/pUs9ON5e8AVRG+gW68koTrzcb0oNkmNkdgxY15O9Yb/Kwq2r/9nqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6477


Dan Williams <dan.j.williams@intel.com> writes:

> Alistair Popple wrote:
> [..]
>>> I'm not really following this scenario, or at least how it relates to
>> >> the comment above. If the page is pinned for DMA it will have taken a
>> >> refcount on it and so the page won't be considered free/idle per
>> >> dax_wait_page_idle() or any of the other mm code.
>> >
>> > [ tl;dr: I think we're ok, analysis below, but I did talk myself into
>> > the proposed dax_busy_page() changes indeed being broken and needing to
>> > remain checking for refcount > 1, not > 0 ]
>> >
>> > It's not the mm code I am worried about. It's the filesystem block
>> > allocator staying in-sync with the allocation state of the page.
>> >
>> > fs/dax.c is charged with converting idle storage blocks to pfns to
>> > mapped folios. Once they are mapped, DMA can pin the folio, but nothing
>> > in fs/dax.c pins the mapping. In the pagecache case the page reference
>> > is sufficient to keep the DMA-busy page from being reused. In the dax
>> > case something needs to arrange for DMA to be idle before
>> > dax_delete_mapping_entry().
>> 
>> Ok. How does that work today? My current mental model is that something
>> has to call dax_layout_busy_page() whilst holding the correct locks to
>> prevent a new mapping being established prior to calling
>> dax_delete_mapping_entry(). Is that correct?
>
> Correct. dax_delete_mapping_entry() is invoked by the filesystem with
> inode locks held. See xfs_file_fallocate() where it takes the lock,
> calls xfs_break_layouts() and if that succeeds performs
> xfs_file_free_space() with the lock held.

Thanks for confirming. I've broken it enough times during development of
this that I thought I was correct but the confirmation is nice.

> xfs_file_free_space() triggers dax_delete_mapping_entry() with knowledge
> that the mapping cannot be re-established until the lock is dropped.
>
>> > However, looking at XFS it indeed makes that guarantee. First it does
>> > xfs_break_dax_layouts() then it does truncate_inode_pages() =>
>> > dax_delete_mapping_entry().
>> >
>> > It follows that that the DMA-idle condition still needs to look for the
>> > case where the refcount is > 1 rather than 0 since refcount == 1 is the
>> > page-mapped-but-DMA-idle condition.
>> 
>> Sorry, but I'm still not following this line of reasoning. If the
>> refcount == 1 the page is either mapped xor DMA-busy.
>
> No, my expectation is the refcount is 1 while the page has a mapping
> entry, analagous to an idle / allocated page cache page, and the
> refcount is 2 or more for DMA, get_user_pages(), or any page walker that
> takes a transient page pin.

Argh, I think we may have been talking past each other. By "mapped" I
was thinking of folio_mapped() == true. Ie. page->mapcount >= 1 due to
having page table entries. I suspect you're talking about DAX page-cache
entries here?

The way the series currently works the DAX page-cache does not hold a
reference on the page. Whether or not that is a good idea (or even
valid/functionally correct) is a reasonable question and where I think
this discussion is heading (see below).

>> is enough to conclude that the page cannot be reused because it is
>> either being accessed from userspace via a CPU mapping or from some
>> device DMA or some other in kernel user.
>
> Userspace access is not a problem, that access can always be safely
> revoked by unmapping the page, and that's what dax_layout_busy_page()
> does to force a fault and re-taking the inode + mmap locks so that the
> truncate path knows it has temporary exclusive access to the page, pfn,
> and storage-block association.

Right.

>> The current proposal is that dax_busy_page() returns true if refcount >=
>> 1, and dax_wait_page_idle() will wait until the refcount ==
>> 0. dax_busy_page() will try and force the refcount == 0 by unmapping it,
>> but obviously can't force other pinners to release their reference hence
>> the need to wait. Callers should already be holding locks to ensure new
>> mappings can't be established and hence can't become DMA-busy after the
>> unmap.
>
> Am I missing a page_ref_dec() somewhere? Are you saying that
> dax_layout_busy_page() will find entries with ->mapping non-NULL and
> refcount == 0?

No, ->mapping gets set to NULL when the page is freed in
free_zone_device_folio() but I think the mapping->i_pages XArray will
still contain references to the page with a zero
refcount. Ie. truncate_inode_pages_range() will still find them and call
truncate_inode_pages_range().

> [..]
>> >> >> @@ -1684,14 +1663,21 @@ static vm_fault_t dax_fault_iter(struct vm_fault *vmf,
>> >> >>  	if (dax_fault_is_synchronous(iter, vmf->vma))
>> >> >>  		return dax_fault_synchronous_pfnp(pfnp, pfn);
>> >> >>  
>> >> >> -	/* insert PMD pfn */
>> >> >> +	page = pfn_t_to_page(pfn);
>> >> >
>> >> > I think this is clearer if dax_insert_entry() returns folios with an
>> >> > elevated refrence count that is dropped when the folio is invalidated
>> >> > out of the mapping.
>> >> 
>> >> I presume this comment is for the next line:
>> >> 
>> >> +	page_ref_inc(page);
>> >>  
>> >> I can move that into dax_insert_entry(), but we would still need to
>> >> drop it after calling vmf_insert_*() to ensure we get the 1 -> 0
>> >> transition when the page is unmapped and therefore
>> >> freed. Alternatively we can make it so vmf_insert_*() don't take
>> >> references on the page, and instead ownership of the reference is
>> >> transfered to the mapping. Personally I prefered having those
>> >> functions take their own reference but let me know what you think.
>> >
>> > Oh, the model I was thinking was that until vmf_insert_XXX() succeeds
>> > then the page was never allocated because it was never mapped. What
>> > happens with the code as proposed is that put_page() triggers page-free
>> > semantics on vmf_insert_XXX() failures, right?
>> 
>> Right. And actually that means I can't move the page_ref_inc(page) into
>> what will be called dax_create_folio(), because an entry may have been
>> created previously that had a failed vmf_insert_XXX() which will
>> therefore have a zero refcount folio associated with it.
>
> I would expect a full cleanup on on vmf_insert_XXX() failure, not
> leaving a zero-referenced entry.
>
>> But I think that model is wrong. I think the model needs to be the page
>> gets allocated when the entry is first created (ie. when
>> dax_create_folio() is called). A subsequent free (ether due to
>> vmf_insert_XXX() failing or the page being unmapped or becoming
>> DMA-idle) should then delete the entry.
>>
>> I think that makes the semantics around dax_busy_page() nicer as well -
>> no need for the truncate to have a special path to call
>> dax_delete_mapping_entry().
>
> I agree it would be lovely if the final put could clean up the mapping
> entry and not depend on truncate_inode_pages_range() to do that.

I think I'm understanding you better now, thanks for your patience. I
think the problem here is most filesystems tend to basically do the
following:

1. Call some fs-specific version of break_dax_layouts() which:
   a) unmaps all the pages from the page-tables via
      dax_layout_busy_page()
   b) waits for DMA[1] to complete by looking at page refcounts

2. Removes DAX page-cache entries by calling
   truncate_inode_pages_range() or some equivalent.

In this series this works because the DAX page-cache doesn't hold a page
reference nor does it call dax_delete_mapping_entry() on free - it
relies on the truncate code to do that. So I think I understand your
original comment now:

>> > It follows that that the DMA-idle condition still needs to look for the
>> > case where the refcount is > 1 rather than 0 since refcount == 1 is the
>> > page-mapped-but-DMA-idle condition.

Because if the DAX page-cache holds a reference the refcount won't go to
zero until dax_delete_mapping_entry() is called. However this interface
seems really strange to me - filesystems call
dax_layout_busy_page()/dax_wait_page_idle() to make sure both user-space
and DMA[1] have finished with the page, but not the DAX code which still
has references in it's page-cache.

Is there some reason for this? In order words why can't the interface to
the filesystem be something like calling dax_break_layouts() which
ensures everything, including core FS DAX code, has finished with the
page(s) in question? I don't see why that wouldn't work for at least
EXT4 and XFS (FUSE seemed a bit different but I haven't dug too deeply).

If we could do that dax_break_layouts() would essentially:
1. unmap userspace via eg. unmap_mapping_pages() to drive the refcount
   down.
2. delete the DAX page-cache entry to remove its refcount.
3. wait for DMA to complete by waiting for the refcount to hit zero.

The problem with the filesystem truncate code at the moment is steps 2
and 3 are reversed so step 3 has to wait for a refcount of 1 as you
pointed out previously. But does that matter? Are there ever cases when
a filesystem needs to wait for the page to be idle but maintain it's DAX
page-cache entry?

I may be missing something though, because I was having trouble getting
this scheme to actually work today.

[1] - Where "DMA" means any unknown page reference

> ...but I do not immediately see how to get there when block, pfn, and
> page are so tightly coupled with dax. That's a whole new project to
> introduce that paradigm, no? The page cache case gets away with
> it by safely disconnecting the pfn+page from the block and then letting
> DMA final put_page() take its time.

Oh of course, thanks for pointing out the difference there.

>> > There is no need to invoke the page-free / final-put path on
>> > vmf_insert_XXX() error because the storage-block / pfn never actually
>> > transitioned into a page / folio.
>> 
>> It's not mapping a page/folio that transitions a pfn into a page/folio
>> it is the allocation of the folio that happens in dax_create_folio()
>> (aka. dax_associate_new_entry()). So we need to delete the entry (as
>> noted above I don't do that currently) if the insertion fails.
>
> Yeah, deletion on insert failure makes sense.
>
> [..]
>> >> >> @@ -519,21 +529,3 @@ void zone_device_page_init(struct page *page)
>> >> >>  	lock_page(page);
>> >> >>  }
>> >> >>  EXPORT_SYMBOL_GPL(zone_device_page_init);
>> >> >> -
>> >> >> -#ifdef CONFIG_FS_DAX
>> >> >> -bool __put_devmap_managed_folio_refs(struct folio *folio, int refs)
>> >> >> -{
>> >> >> -	if (folio->pgmap->type != MEMORY_DEVICE_FS_DAX)
>> >> >> -		return false;
>> >> >> -
>> >> >> -	/*
>> >> >> -	 * fsdax page refcounts are 1-based, rather than 0-based: if
>> >> >> -	 * refcount is 1, then the page is free and the refcount is
>> >> >> -	 * stable because nobody holds a reference on the page.
>> >> >> -	 */
>> >> >> -	if (folio_ref_sub_return(folio, refs) == 1)
>> >> >> -		wake_up_var(&folio->_refcount);
>> >> >> -	return true;
>> >> >
>> >> > It follow from the refcount disvussion above that I think there is an
>> >> > argument to still keep this wakeup based on the 2->1 transitition.
>> >> > pagecache pages are refcount==1 when they are dma-idle but still
>> >> > allocated. To keep the same semantics for dax a dax_folio would have an
>> >> > elevated refcount whenever it is referenced by mapping entry.
>> >> 
>> >> I'm not sold on keeping it as it doesn't seem to offer any benefit
>> >> IMHO. I know both Jason and Christoph were keen to see it go so it be
>> >> good to get their feedback too. Also one of the primary goals of this
>> >> series was to refcount the page normally so we could remove the whole
>> >> "page is free with a refcount of 1" semantics.
>> >
>> > The page is still free at refcount 0, no argument there. But, by
>> > introducing a new "page refcount is elevated while mapped" (as it
>> > should), it follows that "page is DMA idle at refcount == 1", right?
>> 
>> No. The page is either mapped xor DMA-busy - ie. not free. If we want
>> (need?) to tell the difference we can use folio_maybe_dma_pinned(),
>> assuming the driver doing DMA has called pin_user_pages() as it should.
>> 
>> That said I'm not sure why we care about the distinction between
>> DMA-idle and mapped? If the page is not free from the mm perspective the
>> block can't be reallocated by the filesystem.
>
> "can't be reallocated", what enforces that in your view? I am hoping it
> is something I am overlooking.
>
> In my view the filesystem has no idea of this page-to-block
> relationship. All it knows is that when it wants to destroy the
> page-to-block association, dax notices and says "uh, oh, this is my last
> chance to make sure the block can go back into the fs allocation pool so
> I need to wait for the mm to say that the page is exclusive to me (dax
> core) before dax_delete_mapping_entry() destroys the page-to-block
> association and the fs reclaims the allocation".
>
>> > Otherwise, the current assumption that fileystems can have
>> > dax_layout_busy_page_range() poll on the state of the pfn in the mapping
>> > is broken because page refcount == 0 also means no page to mapping
>> > association.
>> 
>> And also means nothing from the mm (userspace mapping, DMA-busy, etc.)
>> is using the page so the page isn't busy and is free to be reallocated
>> right?
>
> Lets take the 'map => start dma => truncate => end dma' scenario.
>
> At the 'end dma' step, how does the filesystem learn that the block that
> it truncated, potentially hours ago, is now a free block? The filesystem
> thought it reclaimed the block when truncate completed. I.e. dax says,
> thou shalt 'end dma' => 'truncate' in all cases.

Agreed, but I don't think I was suggesting we change that. I agree DAX
has to ensure 'end dma' happens before truncate completes.

> Note "dma" can be replaced with "any non dax core page_ref".


